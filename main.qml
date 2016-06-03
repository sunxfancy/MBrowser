import QtQuick 2.5
import QtQuick.Controls 1.4
import QtWebKit 3.0
import QtWebKit.experimental 1.0

ApplicationWindow {
    id: applicationWindow1
    visible: true
    width: 1366
    height: 768
    color: "#e3e3e3"
    title: qsTr("MBrowser")

    WebView {
        id: myWebView

        width: parent.width
        height: parent.height

        anchors.fill: parent

        url: "https://www.baidu.com/"
        experimental.preferences.javascriptEnabled: true
    }

    NumberAnimation {
        id: toobar_down
        target: toolbar; property: "anchors.topMargin"; to: 0.0; duration: 100
        onStopped: toolbar.state = "show"
    }
    NumberAnimation {
        id: toobar_up
        target: toolbar; property: "anchors.topMargin"; to: -50.0; duration: 100
        onStopped: toolbar.state = "hide"
    }

    MouseArea {
        id: mouseArea1
        x: 0
        width: 1366
        height: 50
        anchors.top: parent.top
        anchors.topMargin: 0
        hoverEnabled: true

        onEntered: {
            if (toolbar.state == "hide") {
                toolbar.state = "moving";
                toobar_down.start();
            }
        }

        onExited: {
            if (toolbar.state == "show" && !urlfield.focus) {
                toolbar.state = "moving";
                toobar_up.start();
            }
        }
    }

    Rectangle {
        id: toolbar
        state: "hide"
        x: 0
        y: 0
        width: 1366
        height: 50
        color: "#585858"
        z: 1
        anchors.top: parent.top
        anchors.topMargin: -50

        Column {
            id: column1
            spacing: 10
            anchors.fill: parent
        }

        ToolButton {
            id: toolButton1
            y: 10
            iconSource: "img/back.png"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            tooltip: qsTr("")
            iconName: qsTr("")
        }

        ToolButton {
            id: toolButton2
            y: 10
            iconSource: "img/forward.png"
            anchors.left: toolButton1.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }

        ToolButton {
            id: toolButton3
            y: 10
            iconSource: "img/loading.png"
            anchors.left: toolButton2.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }

        ToolButton {
            id: toolButton4
            y: 10
            iconSource: "img/menu-bars.png"
            anchors.left: toolButton3.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }

        TextField {
            id: urlfield
            y: 15
            width: 803
            height: 30
            anchors.left: toolButton4.right
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            placeholderText: qsTr("Url:")

            onAccepted: {
                myWebView.url = urlfield.text
            }
            onEditingFinished: {
                toolbar.state = "moving";
                toobar_up.start();
            }

            Image {
                id: image1
                width: 24
                height: 24
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 0
                source: "img/star-1.svg"
            }
        }
    }

}
