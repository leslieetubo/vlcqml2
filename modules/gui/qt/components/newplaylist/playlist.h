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
    Item(const QString &type, const QString &size);

    QString type() const;
    QString size() const;

private:
    QString m_type;
    QString m_size;
};

class ItemModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum ItemRoles {
        TypeRole = Qt::UserRole + 1,
        SizeRole
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