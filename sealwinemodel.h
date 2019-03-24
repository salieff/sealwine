#ifndef SEALWINELISTMODEL_H
#define SEALWINELISTMODEL_H

#include <QAbstractListModel>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonArray>

#define REQUEST_WINDOW_LENGTH 20

class SealWineModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum SealWineRoles
    {
        RegCode = Qt::UserRole + 1,
        Producer,
        OrigName,
        Alcohol,
        Caps,
        Image
    };

    explicit SealWineModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;

signals:
    void whereAreMoreElements();
    void noMoreElements();

public slots:
    void requestWine(QString qStr);
    void loadMore();
    void replyFinished(QNetworkReply *reply);

private:
    QNetworkAccessManager *m_netManager;
    QJsonArray m_array;
    QString m_requestString;
};

#endif // SEALWINELISTMODEL_H
