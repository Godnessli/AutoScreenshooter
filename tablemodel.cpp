#include "tablemodel.h"
#include "readtable.h"
#include "includes.h"

TableModel::TableModel(QObject *parent) : QAbstractTableModel(parent)
{
    Table tbl;
    if(!tbl.check(tbl.filepath))
    {
        tbl.getpath();
        table = tbl.readtable(tbl.filepath);
    }
    else if (tbl.run_already)
    {
        tbl.getpath();
        table = tbl.readtable(tbl.filepath);
    }
    else return;
}

int TableModel::rowCount(const QModelIndex &) const
{
    return table.size();//Number of rows
}

int TableModel::columnCount(const QModelIndex &) const
{
    return 8;//Columns
}

QVariant TableModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case TableDataRole:
    {
        return  table.at(index.row()).at(index.column());
    }
    default:
        break;
    }

    return QVariant();
}

QVariant TableModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role != Qt::DisplayRole) {
        return QVariant();
    }
    if (orientation == Qt::Horizontal && section == 0) {
        return "Дата";
    } else if (orientation == Qt::Horizontal && section == 1) {
        return "Маршрут";
    } else if (orientation == Qt::Horizontal && section == 2) {
        return "Направление";
    } else if (orientation == Qt::Horizontal && section == 3) {
        return "Плановое время";
    } else if (orientation == Qt::Horizontal && section == 4) {
        return "Фактическое время";
    } else if (orientation == Qt::Horizontal && section == 5) {
        return "Гаражный номер";
    } else if (orientation == Qt::Horizontal && section == 6) {
        return "Проблема";
    } else if (orientation == Qt::Horizontal && section == 7) {
        return "Скрин";
    }

    if(orientation == Qt::Vertical){
        return QVariant::fromValue(section + 1) ;
    }
    return QVariant();
}

QHash<int, QByteArray> TableModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TableDataRole] = "tabledata";
    return roles;
}
