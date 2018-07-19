/*
 * Playlist from C++
 *
 * 
 *
 * Author: Leslie Etubo T.
 * 
 */
#include "playlist.h"

Item::Item(const QString &duration, const QString &size, 
    const QString &artist, const QString &genre)
    : m_duration(duration), m_size(size), m_artist(artist), m_genre(genre)
{
}

QString Item::duration() const
{
    return m_duration;
}

QString Item::size() const
{
    return m_size;
}

QString Item::artist() const
{
    return m_artist;
}

QString Item::genre() const
{
    return m_genre;
}
/*
ItemModel::ItemModel(QObject *parent)
    : QAbstractListModel(parent)
{
}*/

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
    if (role == DurationRole)
        return item.duration();
    else if (role == SizeRole)
        return item.size();
    else if (role == ArtistRole)
        return item.artist();
    else if (role == GenreRole)
        return item.genre();
    return QVariant();
}

QHash<int, QByteArray> ItemModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[DurationRole] = "duration";
    roles[SizeRole] = "size";
    roles[ArtistRole] = "artist";
    roles[GenreRole] = "genre";
    return roles;
}