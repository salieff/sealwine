#include <QJsonDocument>
#include <QJsonObject>

#include "sealwinemodel.h"

SealWineModel::SealWineModel(QObject *parent)
    : QAbstractListModel(parent),
      m_netManager(new QNetworkAccessManager(this))
{
    connect(m_netManager, &QNetworkAccessManager::finished, this, &SealWineModel::replyFinished);
}

int SealWineModel::rowCount(const QModelIndex & parent) const
{
    Q_UNUSED(parent);
    return m_array.size();
}

QVariant SealWineModel::data(const QModelIndex & index, int role) const
{
    QJsonObject obj = m_array[index.row()].toObject();

#define CASEROLE(arg) case arg : return obj[#arg].toString();
    switch (role)
    {
    CASEROLE(RegCode)
    CASEROLE(Producer)
    CASEROLE(OrigName)
    CASEROLE(Alcohol)
    CASEROLE(Caps)
    CASEROLE(Image)
    }
#undef CASEROLE

    return QVariant();
}

QHash<int, QByteArray> SealWineModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[RegCode] = "RegCode";
    roles[Producer] = "Producer";
    roles[OrigName] = "OrigName";
    roles[Alcohol] = "Alcohol";
    roles[Caps] = "Caps";
    roles[Image] = "Image";

    return roles;
}

void SealWineModel::requestWine(QString qStr)
{
    beginResetModel();
    m_requestString = qStr;
    m_array = QJsonArray();
    endResetModel();

    loadMore();
}

void SealWineModel::loadMore()
{
    QString url = QString("https://wine.bozo.ru/search?q=") +
                  m_requestString +
                  QString("&o=%1&l=%2").arg(m_array.size()).arg(REQUEST_WINDOW_LENGTH + 1);
    // qInfo() << url;
    m_netManager->get(QNetworkRequest(QUrl(url)));
}

void SealWineModel::replyFinished(QNetworkReply *reply)
{
    QByteArray data = reply->readAll();

    // qInfo() << reply->url();
    // qInfo() << data;

    QJsonParseError err;
    QJsonDocument doc = QJsonDocument::fromJson(data, &err);

    QJsonArray arr = doc.array();
    if (arr.size() >= (REQUEST_WINDOW_LENGTH + 1))
    {
        arr.pop_back();
        emit whereAreMoreElements();
    }
    else
    {
        emit noMoreElements();
    }

    beginInsertRows(QModelIndex(), m_array.size(), m_array.size() + arr.size() - 1);
    for (auto value : arr)
        m_array << value;
    qInfo() << m_array.size();
    endInsertRows();

    reply->deleteLater();
}
