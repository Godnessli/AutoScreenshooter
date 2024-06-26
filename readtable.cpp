#include "readtable.h"

using namespace xlnt;

Table::Table() {}

void Table::getpath()
{
    QWidget *w = new QWidget();
    filepath = QFileDialog::getOpenFileName(w,
                                            "Выберите файл",
                                            "C:/", "Файл Excel(*.xlsx)");
}

bool Table::check(const QString &path)
{
    QString check = "";

    if (path == check)
        return false;
    else
        return true;
}

QVector<QVector<QString>> Table::readtable(const QString &path)
{
    Table table;
    QVector<QVector<QString>> tab;
    QString check1 = "ОБРЫВ БЛОКА ГЛОНАСС", check2 = "ПРОБКИ", check3 = "РЕЙС ВЫПОЛНЕН ПРАВИЛЬНО";
    if (table.check(path))
    {
        workbook wb;
        wb.load(path.toStdString());
        auto ws = wb.active_sheet();
        for(auto row : ws.rows(false))
        {
            QVector<QString> ROW;
            for(auto cell : row)
            {
                int num = cell.column_index();
                if(num != 7 && num != 10)
                {
                    std::string c = cell.to_string();
                    QString cll;
                    ROW.push_back(cll.fromStdString(c));
                }
            }

            if(ROW[6] == check1 || ROW[6] == check2 || ROW[6] == check3)
            {
                tab.append(ROW);
            }
        }
    }
    return tab;
}
