#ifndef READTABLE_H
#define READTABLE_H

#include "includes.h"

class Table
{
public:
    Table();

    QString filepath;
    bool run_already;

    void getpath();
    bool check(const QString &path);
    QVector<QVector<QString>> readtable(const QString &path);

};
#endif // READTABLE_H
