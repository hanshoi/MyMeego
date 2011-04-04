import Qt 4.7
import "../lib/colibri/includes"
import "../qml"
import "../javascript/Windowing.js" as Windowing;

Rectangle {
    id: structure

    Connections{
        target: transferTest;
        onTransferInit: xmlPath = path;
    }

    width: parent.width
    height: parent.height
    color: "transparent";

    property Theme theme: Theme{}
    property int selectcount: 0
    property string xmlPath: ""

    property XmlListModel testList: XmlListModel {
        id: picturesList
        source: xmlPath
        query: "/transferfiles/pictures/picture"

        XmlRole { name: "id"; query: "@id/string()" }
        XmlRole { name: "thumbnail"; query: "thumbnail/string()" }
    }

    GridView{
        id: pictureGrid
        anchors.fill: parent

        model: picturesList

        delegate:
            Item{
                Connections{
                    target: transferTest
                    onTransferDone: selected = transferTest.isSelected(id)
                    onTransfersCleared: selected = transferTest.isSelected(id)
                }

                height: theme.pictureIconHeight
                width: theme.pictureIconWidht
                property bool selected: transferTest.isSelected(id)

                Image { source: "../img/testdata/pictures/"+thumbnail;
                    anchors.fill: parent
                    anchors.margins: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Image {
                    id: selectfield;
                    opacity: if( selected ){
                        1
                    }else{
                        0
                    }

                    anchors.right: parent.right;
                    anchors.bottom: parent.bottom;
                    source: theme.transferIcon;
                    Behavior on opacity{
                        NumberAnimation{
                            properties: "opacity"
                            duration: 500
                        }
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if( selected ){
                            selectcount--;
                            transferTest.rmvTransfer(id)
                            selected = transferTest.isSelected(id)
                            if( transferTest.isEmpty() ) {
                                Windowing.closeDeviceMenuBar();
                            }
                        }else{
                            selectcount++;
                            transferTest.addTransfer(id)
                            selected = transferTest.isSelected(id)
                            if( selectcount > 0 )
                            {
                                Windowing.openDeviceMenuBar();
                            }
                        }
                        console.log(selectcount)
                    }
                }
            }
    }
}
