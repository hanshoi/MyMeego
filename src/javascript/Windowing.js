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
var dialogContentsComponent;
var dialogContents;


/*
 * Opens a dialog by setting dialogFrame's state to visible
 */
function openDialog( deviceID, deviceName ) {
    console.log("Opening dialog");

    closeDeviceMenuBar();
    dialogFrame.dialogOpened();
    dialogFrame.state = "visible";

    deviceMenuBar.mode = "transfermode";
    window.selectedDevice = deviceID;
    window.deviceSelected();
}

/*
 * Closes dialog
 */
function closeDialog() {
    console.log("Closing dialog");

    openDeviceMenuBar();
    dialogFrame.dialogClosed();
    dialogFrame.state = "";

    deviceMenuBar.mode = "openviewmode";
    window.selectedDevice = -1;
    window.deviceMenuBarClosed();
    transferView.clearSelection();
}

/*
 * Opens device menu bar
 */
function openDeviceMenuBar() {
    console.log("opening device menu bar");
    deviceMenuBar.state = "visible";
}

/*
 * Closes device menu bar
 */
function closeDeviceMenuBar() {
    console.log("closing device menu bar");
    deviceMenuBar.state = "hidden";
}

function closeTransferringDialogTimer() {
    transferringDialog.startTimer();
    window.hideDeactivator();
}



/*
 * Show transfer dialog
 */
function openTransferringDialog() {
    transferringDialog.state = "visible";
    //transferringDialog.startTimer();
    window.showDeactivator();
}

/*
 * Hide transfer dialog
 */
function closeTransferringDialog() {
    transferringDialog.state = "hidden";
    closeDeviceMenuBar();
}
