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
import Qt 4.7
import "../javascript/Windowing.js" as Windowing;
import "../lib/colibri"

Rectangle {
    id: container;
    Connections{
        target: transferTest

        onTransferStart: {
            progress.state = "transferActive";
            transferred = "Transferring: 0/"+count
            transfertotal = count;
            transfercount = 0;
        }
        onTransferred: {
            transferred = "Transferring: "+str+"/"+count
            transfertotal = count
            transfercount = str
        }

        onTransferDone: {
            progress.state = "transferInactive";
            transfercount = 0;
            transferred = "Transfer done"
        }

    }

    width: window.width/2;
    height: window.height/4;

    anchors.centerIn: parent;

    color: theme.transferringDialogBackgroundColor;
    border.width: theme.transferringDialogBorderSize;
    border.color: theme.transferringDialogBorderColor;

    radius: 10;

    property string target;
    property string source;
    property int transfertotal: 1
    property int transfercount: 0
    property string transferred: "Loading...";

    Text {
        id: transferStatus
        font.pointSize: theme.transferringDialogTextSize;
        text: transferred;
        anchors.centerIn: parent;
    }


    CLProgressBar{
        id: progress
        anchors.top: transferStatus.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        minValue: 0
        maxValue: transfertotal
        value: transfercount
        width: parent.width-20
        state: "transferInactive";

        states: [
            State {
                name: "transferActive";
                PropertyChanges {
                    target: progress;
                    opacity: 1;
                }
            },
            State {
                name: "transferInactive";
                PropertyChanges {
                    target: progress;
                    opacity: 0;
                }
            }
        ]

        transitions: [
            Transition {
                from: "transferInactive";
                to: "transferActive";
                reversible: true;

                NumberAnimation {
                    target: progress;
                    property: "opacity";
                    to: 1;
                    duration: 100}
            }
        ]
    }

    function startTimer() { timer.running = true; }

    Timer {
        id: timer;
        interval: 1000;
        onTriggered: {
            Windowing.closeTransferringDialog();
        }
    }

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: container;
                opacity: 1;
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: container;
                opacity: 0;
            }
        }
    ]
    transitions: [
        Transition {
            from: "visible"
            to: "hidden"
            reversible: true;

            NumberAnimation {
                target: container;
                property: "opacity";
                duration: 300;
                easing.type: Easing.InOutSine;
            }
        }
    ]

}
