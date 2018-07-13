/*
 * Playlist from C++
 *
 * 
 *
 * Author: Leslie Etubo T.
 * 
 */
#include "playlist.h"

Item::Item(const QString &type, const QString &size)
    : m_type(type), m_size(size)
{
}

QString Item::type() const
{
    return m_type;
}

QString Item::size() const
{
    return m_size;
}

ItemModel::ItemModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void ItemModel::addItem(const Item &item)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << item;
    endInsertRows();
}

int ItemModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant ItemModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_items.count())
        return QVariant();

    const Item &item = m_items[index.row()];
    if (role == TypeRole)
        return item.type();
    else if (role == SizeRole)
        return item.size();
    return QVariant();
}

QHash<int, QByteArray> ItemModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TypeRole] = "type";
    roles[SizeRole] = "size";
    return roles;
}