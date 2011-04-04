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

Rectangle {
    property Theme theme: Theme{}
    anchors.horizontalCenter: parent.horizontalCenter
    width: theme.mvpMenuWidht
    height: theme.mvpMenuHeight
    color: "transparent";

    Row {
        id: mvpbuttons
        height: parent.height
        width:  parent.width

        Rectangle{
            id: musicButton
    radius: theme.mvpButtonsRadius;
            height: theme.mvpMenuHeight
            width: theme.mvpMenuButtonwidht
            gradient: theme.mvpButtonBackgroundGradient
            state:"selected"
            border.width: 1
            Image {
                id: musicIcon
                anchors.centerIn: parent
                source: theme.musicIcon
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    transfers.state="music"
                    musicButton.state="selected"
                    moviesButtons.state="notselected"
                    picturesButton.state="notselected"
                }
            }
            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: musicButton
                        gradient: theme.mvpButtonSelectedBackgroundGradient
                    }
                },
                State {
                    name: "notselected"
                    PropertyChanges {
                        target: musicButton
                        gradient: theme.mvpButtonBackgroundGradient
                    }
                }

            ]
        }
        Rectangle{
            id: moviesButtons
    radius: theme.mvpButtonsRadius;
            height: theme.mvpMenuHeight
            width: theme.mvpMenuButtonwidht
            gradient: theme.mvpButtonBackgroundGradient
            state:"notselected"
            border.width: 1
            Image {
                id: videoIcon
                anchors.centerIn: parent
                source: theme.videoIcon
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    transfers.state="movies"
                    musicButton.state="notselected"
                    moviesButtons.state="selected"
                    picturesButton.state="notselected"
                }
            }
            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: moviesButtons
                        gradient: theme.mvpButtonSelectedBackgroundGradient
                    }
                },
                State {
                    name: "notselected"
                    PropertyChanges {
                        target: moviesButtons
                        gradient: theme.mvpButtonBackgroundGradient
                    }
                }

            ]
        }
        Rectangle{
            id: picturesButton
    radius: theme.mvpButtonsRadius;
            height: theme.mvpMenuHeight
            width: theme.mvpMenuButtonwidht
            gradient: theme.mvpButtonBackgroundGradient
            border.width: 1
            state:"notselected"
            Image {
                id: pictureIcon
                anchors.centerIn: parent
                source: theme.pictureIcon
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    transfers.state="pictures"
                    musicButton.state="notselected"
                    moviesButtons.state="notselected"
                    picturesButton.state="selected"
                }
            }
            states: [
                State {
                    name: "selected"
                    PropertyChanges {
                        target: picturesButton
                        gradient: theme.mvpButtonSelectedBackgroundGradient
                    }
                },
                State {
                    name: "notselected"
                    PropertyChanges {
                        target: picturesButton
                        gradient: theme.mvpButtonBackgroundGradient
                    }
                }

            ]

        }
    }
}
