/*
 *  Copyright (c) 2011, Juhani Alanko, Marko Silokunnas, Juha Sinkkonen,
 *                      Antti Ruotsalainen, Rawdimension group
 *  All rights reserved.
 *
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice,
 *     this list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation
 *     and/or other materials provided with the distribution.
 *  3. Neither the name of the Rawdimension Group nor the names
 *     of its contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 *     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 *     AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 *     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 *     ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 *     LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *     CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 *     SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 *     INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 *     CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *     ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 *     POSSIBILITY OF SUCH DAMAGE.
 */
#include "transferlist.h"
#include <QDeclarativeView>
#include <QDebug>
#include <QStringList>

TransferList::TransferList(QObject *parent) : QObject(parent)
{
    QObject::connect(&data, SIGNAL(valueChanged()),
                     this, SLOT(transferStatus()));
    QObject::connect(&xmlData, SIGNAL(valueChanged()),
                     this, SLOT(xmlListDone()));
}

int TransferList::getCount()
{
    return transfers.count();
}
void TransferList::addTransfer(const QString &id)
{
    transfers.push_back(id);
}

void TransferList::rmvTransfer(const QString &id)
{
    transfers.removeOne(id);
}

void TransferList::doTransfer(const QString &target)
{
    QString temp;
    temp = source + ":" + target;
    int i;
    for(i=0; i<transfers.count(); i++)
    {
        temp += ":"+transfers.at(i);
    }

    data.setDeviceId(source);
    data.setType("TransferFiles");
    data.setIsRequest(false);
    data.setValue(temp);
    data.setEvents(transfers.count());

    qDebug() << "Transfer:" << temp;
    emit transferStart(transfers.count());
    EventHandler::instance()->sendEvent(&data);


}

bool TransferList::isSelected(const QString &id)
{
    return transfers.contains(id);
}

void TransferList::setSource(const QString &device)
{
    source = device;
}

void TransferList::clearTransfer()
{
    transfers.clear();
    emit transfersCleared();
}
bool TransferList::isEmpty()
{
    return transfers.isEmpty();
}

QString TransferList::getSource()
{
    return source;
}

void TransferList::transferStatus()
{
    QStringList tmp = data.value().split(":");

    if(QString::compare("done",data.value())==0)
    {
        transfers.clear();
        emit transferDone();
        qDebug() << "Transfer done";
    }
    else if (QString::compare("transferred",tmp.at(0))==0)
    {
        bool ok;
        qDebug() << "Value: "+tmp.at(0);
        qDebug() << "Data: "+tmp.at(1);
        emit transferred(tmp.at(1).toInt(&ok, 10),transfers.count());
    }
}

void TransferList::initXml()
{
    qDebug() << "Loading Device: "+source;
    xmlData.setDeviceId(source);
    xmlData.setType("GetFileList");
    xmlData.setEvents(1);
    EventHandler::instance()->sendEvent(&xmlData);
}

void TransferList::xmlListDone()
{
    qDebug() << "Path: "+xmlData.value();
    emit transferInit(xmlData.value());
}
