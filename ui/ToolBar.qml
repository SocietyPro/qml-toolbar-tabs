import QtQuick 2.3
import "qrc:///components/ui"

Rectangle {
    id: header
    signal urlChanged(string url)
    signal goBackClicked()
    signal goForwardClicked()
    signal reloadClicked()
    property bool canGoBack: false
    property bool canGoForward: false

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 40; z: 10

    function setUrl(url) {
        locationBar.text = url
        locationBar.cursorPosition = 0
    }

    gradient: Gradient {
        GradientStop { position: 0.2; color: "#E6E6E6" }
        GradientStop { position: 0.8; color: "#DADADA" }
    }

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 1
        color: "#AAAAAA"
    }

    Row {
        anchors.fill: parent

        ToolButton {
            id: prevButton
            enabled: header.canGoBack
            releasedImage: "qrc:///images/ui/prevPageIcon.png"
            disabledImage: "qrc:///images/ui/prevPageDisabledIcon.png"
            hoveredImage: "qrc:///images/ui/prevPageHoveredIcon.png"
            onClicked: header.goBackClicked()
        }

        ToolButton {
            id: nextButton
            enabled: header.canGoForward
            releasedImage: "qrc:///images/ui/nextPageIcon.png"
            disabledImage: "qrc:///images/ui/nextPageDisabledIcon.png"
            hoveredImage: "qrc:///images/ui/nextPageHoveredIcon.png"
            onClicked: header.goForwardClicked()
        }

        ToolButton {
            releasedImage: "qrc:///images/ui/refreshPageIcon.png"
            hoveredImage: "qrc:///images/ui/refreshPageHoveredIcon.png"
            onClicked: header.reloadClicked()
        }

        LocationBar {
            id: locationBar
            anchors.verticalCenter: parent.verticalCenter
            property int mainWidth: parent.width - x - (20 + 40 + 40 + 40 + 40 + 40 + 43 + 120 + 120 + 70)
            property int currentWidth: parent.width / 2 - 70 - x
            width: currentWidth
            onAccepted: header.urlChanged(txt.indexOf("http://") === 0 ? txt : "http://" + txt)
        }

        Item { // separator
            width: 10; height: 40
        }

        Rectangle { //separator
            anchors.verticalCenter: parent.verticalCenter
            width: 1; height: 26
            color: "#AAAAAA"
        }

        Item { // separator
            width: 10; height: 40
        }

        RolesDropdown {
            anchors.verticalCenter: parent.verticalCenter
            height: 26; width: 120
            onRoleChanged: roleInfo.name = txt
        }

        Item { // separator
            width: 10; height: 40
        }

        RoleInfo {
            id: roleInfo
            anchors.verticalCenter: parent.verticalCenter
            height: 26; width: 120
            image: "qrc:///images/ui/testThumbImage.png"
            name: qsTr("The Real Plato")
        }

        Item { // separator
            width: 10; height: 40
        }

        HomeButton {
            anchors.verticalCenter: parent.verticalCenter
            height: 40; width: 70
            onClicked: {
                console.log("Home button clicked")
            }
        }

        Item { //separator
            width: locationBar.mainWidth - locationBar.currentWidth
            height: 26
        }

        Rectangle { //separator
            anchors.verticalCenter: parent.verticalCenter
            width: 1; height: 26
            color: "#AAAAAA"
        }

        CreationStackButton {
            releasedImage: "qrc:///images/ui/creationStackIcon.png"
            hoveredImage: "qrc:///images/ui/creationStackHoveredIcon.png"
        }

        ApplicationsButton {
            releasedImage: "qrc:///images/ui/applicationsIcon.png"
            hoveredImage: "qrc:///images/ui/applicationsHoveredIcon.png"
        }

        Rectangle { //separator
            anchors.verticalCenter: parent.verticalCenter
            width: 1; height: 26
            color: "#AAAAAA"
        }

        PeersButton {
            releasedImage: "qrc:///images/ui/peersIcon.png"
            disabledImage: "qrc:///images/ui/peersDisabledIcon.png"
            hoveredImage: "qrc:///images/ui/peersHoveredIcon.png"
        }

        MessagesButton {
            releasedImage: "qrc:///images/ui/messagesIcon.png"
            disabledImage: "qrc:///images/ui/messagesDisabledIcon.png"
            hoveredImage: "qrc:///images/ui/messagesHoveredIcon.png"
        }

        NotificationsButton {
            releasedImage: "qrc:///images/ui/notificationsIcon.png"
            disabledImage: "qrc:///images/ui/notificationsDisabledIcon.png"
            hoveredImage: "qrc:///images/ui/notificationsHoveredIcon.png"
        }

        MoreButton {
            width: 20
            releasedImage: "qrc:///images/ui/moreIcon.png"
            hoveredImage: "qrc:///images/ui/moreHoveredIcon.png"
        }
    }
}
