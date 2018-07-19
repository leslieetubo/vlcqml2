/*
 * Playlist from C++
 *
 * 
 *
 * Author: Leslie Etubo T.
 * 
 */
#include <QAbstractListModel>
#include <QStringList>

class Item
{
public:
    Item(const QString &type, const QString &size, 
    	const QString &artist, const QString &genre);

    QString duration() const;
    QString size() const;
    QString artist() const;
    QString genre() const;

private:
    QString m_duration;
    QString m_size;
    QString m_artist;
    QString m_genre;
};

class ItemModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemRoles {
        DurationRole = Qt::UserRole + 1,
        SizeRole,
        ArtistRole,
        GenreRole
    };

    ItemModel(QObject *parent = 0);

    void addItem(const Item &item);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

protected:
    QHash<int, QByteArray> roleNames() const;
private:
    QList<Item> m_items;
};