#ifndef TABLEMODEL_H
#define TABLEMODEL_H

#include "includes.h"

class TableModel : public QAbstractTableModel
{
    Q_OBJECT
    QML_ELEMENT
    enum TableRoles{
        TableDataRole = Qt::UserRole + 1,
    };
public:
    explicit TableModel(QObject *parent = nullptr);
    int rowCount(const QModelIndex & = QModelIndex()) const override;
    int columnCount(const QModelIndex & = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

signals:
    void nameChanged();

private:
    QVector<QVector<QString>> table;
};

#endif // TABLEMODEL_H
