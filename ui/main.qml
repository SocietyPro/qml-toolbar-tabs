import QtQuick 2.3
import QtQuick.Controls 1.2 as QuickControls
import "qrc:///components/ui"

QuickControls.ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    visible: true
    minimumWidth: 1024
    width: 1024
    height: 748
    title: qsTr("Society Pro")

    property var currentItem
    function mouseReleased(obj, mouseX, mouseY) {}
    function mousePressed(obj, mouseX, mouseY) {
        switch(obj.objectName) {
        case "appWindow": obj = rootItem; break;
        }

        var tmp = rootItem.mapFromItem(obj, mouseX, mouseY)
        if(tmp !== undefined) {
            mouseX = tmp.x
            mouseY = tmp.y
        }

        if(currentItem !== undefined) {
            tmp = rootItem.mapToItem(currentItem, mouseX, mouseY)
            if(!currentItem.containsPoint(tmp.x, tmp.y)) {
                currentItem.hide()
                currentItem = undefined
            }
        }
    }

    Item {
        id: rootItem
        anchors.fill: parent

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 25
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#D4D4D4" }
                GradientStop { position: 1.0; color: "#DEDEDE" }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                color: "#A9A9A9"
                height: 1
            }
        }

        PantheonDropdown {
            anchors.left: parent.left
            anchors.top: parent.top
            height: 25; width: 100; z: 1
        }

        ListModel { id: tabsModel }
        TabViewHeader {
            id: tabViewHeader
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 100
            Component.onCompleted: addTab(qsTr("New tab"), "")

            onCurrentTabChanged: rootItem.currentTab = identifier
            onTabAdded: tabsModel.append({"identifier":identifier, "launchUrl":url})
            onTabRemoved: {
                for(var i = 0; i < tabsModel.count; ++i)
                    if(tabsModel.get(i).identifier === identifier) {
                        rootItem.currentTab = prevIdentifier
                        tabsModel.remove(i)
                        break
                    }
            }
        }

        property int currentTab: 0
        Repeater {
            id: repeater
            model: tabsModel
            delegate: Tab {
                width: rootItem.width
                height: rootItem.height - tabViewHeader.height
                y: tabViewHeader.height
                visible: identifier === rootItem.currentTab
                onPageModified: tabViewHeader.modifyTab(identifier, url, title)
                Component.onCompleted: rootItem.currentTab = identifier
            }
        }
    }
}
