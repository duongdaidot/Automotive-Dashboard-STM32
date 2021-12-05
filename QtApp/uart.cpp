#include "uart.h"
#include <QDebug>

QSerialPort *serial = new QSerialPort;


UART::UART(QObject *parent) :QObject(parent)
{
    serial->setPortName("COM3");                           //Set the serial port name
    serial->open(QIODevice::ReadWrite);                    //Open the serial port
    serial->setBaudRate(9600);                             //Set the baud rate
    serial->setDataBits(QSerialPort::Data8);               //Set the number of data bits
    serial->setParity(QSerialPort::NoParity);              //Set parity
    serial->setStopBits(QSerialPort::OneStop);             //Set stop bit
    serial->setFlowControl(QSerialPort::NoFlowControl);    //Set up flow control
    connect(serial, &QSerialPort::readyRead, this, &UART::readuart);
}

UART::~UART(){
    serial->close();
}

int UART::getValue() const
{
    return m_value;
}

int UART::getIndicator() const{
    return m_indicator;
}

void UART::setValue(int newvalue)
{
    m_value = newvalue;
    emit valueChanged();
}

void UART::setIndicator(int newval){
    m_indicator = newval;
    emit indicatorChanged();
}

void UART::readuart(){
    QString tmp = serial->readAll();
    qDebug() << tmp;
    if(tmp == 'u'){
        setValue(1);
    }else if(tmp == 'd'){
        setValue(2);
    }
    else if(tmp == 'l'){
        qDebug() << m_indicator;
        if(m_indicator == 3){
            setIndicator(0);
        }else{
            setIndicator(3);
        }
    }
    else if(tmp == 'r'){
        qDebug() << m_indicator;
        if(m_indicator == 4){
            setIndicator(0);
        }else{
            setIndicator(4);
        }
    }
}
