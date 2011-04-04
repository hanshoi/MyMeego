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


import "../javascript/Windowing.js" as Windowing

Item {
    id: container;
    property string pathToIcon;
    property string buttonText;

    property string devName;
    property string devType;
    property string devId;

    property string previousState;

    property Theme theme: Theme {}
    signal openTransferView;

    z: 1;
    width: device.width;

    DeviceButton {
        id: device
        pathToIcon: parent.pathToIcon;
        deviceName: parent.buttonText;
        width: 60;
        z:parent.z+1;

        Connections{
            target: transferTest
            onTransferDone: Windowing.closeTransferringDialogTimer()
        }

        state: "clickable";

        states: [
            State {
                name: "clickable"
                PropertyChanges {
                    target: device
                    onClicked: {
                        console.log( deviceMenuBar.mode );
                        if( deviceMenuBar.mode == "openviewmode" ) {
                            transferTest.setSource(devId);
                            transferTest.initXml();
                            Windowing.openDialog( devId, devName );
                        }
                        else if ( deviceMenuBar.mode == "transfermode" ) {                       
                            Windowing.openTransferringDialog();
                            transferTest.doTransfer(devId);
                        }
                    }
                }
            },
            State {
                name: "unclickable"
                PropertyChanges {
                    target: device;
                    onClicked: {
                        //do nothing
                    }
                }
            }

        ]

        Connections {
            target: window;
            onDeviceSelected: {
                if( window.selectedDevice == devId )
                {
                    device.opacity = 0.2;
                    device.state = "unclickable"
                }
            }
        }

        Connections {
            target: window;
            onDeviceMenuBarClosed: {
                device.opacity = 1.0;
                device.state = "clickable";
            }
        }
    }
}
