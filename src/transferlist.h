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
#ifndef TRANSFERLIST_H
#define TRANSFERLIST_H

#include <QObject>
#include <QList>
#include "eventhandler.h"

class TransferList : public QObject
{
    Q_OBJECT
public:
    explicit TransferList(QObject *parent = 0);

    Q_INVOKABLE int getCount();
    Q_INVOKABLE void addTransfer(const QString &id);
    Q_INVOKABLE void rmvTransfer(const QString &id);
    Q_INVOKABLE void doTransfer(const QString &target);
    Q_INVOKABLE bool isSelected(const QString &id);
    Q_INVOKABLE QString getSource();
    Q_INVOKABLE void setSource(const QString &device);
    Q_INVOKABLE void clearTransfer();
    Q_INVOKABLE bool isEmpty();
    Q_INVOKABLE void initXml();
private:
    void tranferDone();

    QList<QString> transfers;
    QString source;
    MMData data;
    MMData xmlData;

signals:
    void transfersCleared();
    void transferDone();
    void transferInit(QString path);
    void transferred(int str, int count);
    void transferStart(int count);
public slots:
    void transferStatus();
    void xmlListDone();
};

#endif // TRANSFERLIST_H
