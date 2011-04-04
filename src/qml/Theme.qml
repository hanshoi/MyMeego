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

Item {


    property string generalFontFamily: "Arial";
    /*
     * Device button theme stuff
     */
    property int deviceMenuButtonWidth: 60;
    property int deviceMenuButtonHeight: 60;
    property int deviceButtonMargin: 10;


    property Gradient backgroundGradient: Gradient {
        GradientStop { position: 1.0; color: "#888888" }
        GradientStop { position: 0.0; color: "#888888" }
    }
    property real backgroundTransparency: 0.7;

    property string deviceMenuBarBackgroundImagePath: "../img/bottombar.svg";

    /*
     * Main screen
     */
    property string mainScreenBackgroundColor: "gray";
    property string mainScreenBackgroundImage: "../img/bg.svg";
    property int mainScreenBackgoundImageWidth: window.width;
    property int mainScreenBackgroundImageHeight: window.height;
    property int mainScreenDeviceMenuHeight: 70;

    /*
     * Dialog
     */
    property int closeButtonWidth: 100;
    property int closeButtonHeight: 60;
    property int closeButtonBorderWidth: 1;
    property string closeButtonBackgroundColor: "blue";
    property string closeButtonBorderColor: "black";
    property int closeButtonRadius: 10;
    property Gradient closeButtonBackgroundGradient: mvpButtonBackgroundGradient;

    /*
     * Transferring dialog
     */
    property int transferringDialogTextSize: 24;
    property int transferringDialogBorderSize: 1;
    property string transferringDialogBackgroundColor: "gray";
    property string transferringDialogBorderColor: "black";


    property Gradient dialogExitButtonBackground: Gradient {
        GradientStop { position: 1.0; color: "#c8c8c8" }
        GradientStop { position: 0.0; color: "#838383" }
    }

    /*
     * Icons
     */
    //property string meegoHandsetLogo: "../img/meego-handset-logo.png";
    property string meegoHandsetLogo: "../img/btnPhone.svg";
    property string meegoNetbookLogo: "../img/btnNetbook.svg";
    property string meegoTvLogo: "../img/btnTv.svg";
    property string meegoVehicleLogo: "../img/btnCar.svg";
    property string transferIcon: "../img/go-jump.png";
    property string pictureIcon: "../img/image-x-generic.png";
    property string videoIcon: "../img/video-x-generic.png";
    property string musicIcon: "../img/audio-x-generic.png";
    property string syncIcon: "../img/system-software-update.png"
    property string closeIcon: "../img/emblem-unreadable.png"

    /*
     * Music Transfer
     */
    property int musicTranferAlbumTextFontPointSize: 15;
    property int musicTransferArtistTextFontPointSize: 10;
    property string musicTransferAlbumTextColor: "green";
    property string musicTransferArtistTextColor: "black";

    /*
     * Movie transfer
     */
    property int movieTransferTitleTextPointSize: 15;
    property string movieTransferTitleTextColor: "green";

    /*
     * MVPbuttons
     */
     property int mvpMenuHeight: 70
     property int mvpMenuWidht: 300
     property string mvpButtoncolor: "gray"
     property int mvpMenuButtonwidht: 100
     property int mvpButtonsRadius: 10;
     property Gradient mvpButtonBackgroundGradient: Gradient {
         GradientStop { position: 1.0; color: "#64aa00" }
         GradientStop { position: 0.0; color: "#f2ffdd" }
     }
     property Gradient mvpButtonSelectedBackgroundGradient: Gradient {
         GradientStop { position: 1.0; color: "#006400" }
         GradientStop { position: 0.0; color: "#020806" }
     }

    /*
     * Picture Transfer
     */
    property int pictureIconHeight: 100
    property int pictureIconWidht: 100

    /*
     * Dialogs
     */
    property string transferDialogPath: "TransferView.qml";
}
