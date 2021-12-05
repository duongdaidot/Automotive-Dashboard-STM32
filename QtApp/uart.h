#ifndef UART_H
#define UART_H

#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QObject>

class UART : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int value READ getValue WRITE setValue NOTIFY valueChanged)
    Q_PROPERTY(int indicator READ getIndicator WRITE setIndicator NOTIFY indicatorChanged)
    public:
        explicit UART(QObject *parent = 0);
        ~UART();
        int getValue() const;
        void setValue(int);
        int getIndicator() const;
        void setIndicator(int);
    signals:
        void valueChanged();
        void indicatorChanged();
    public slots:
        void readuart();

    private:
        int m_value=0;
        int m_indicator=0;
};

#endif // UART_H
