import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

Item {
  id: root

  // Tweak these to taste
  readonly property string fontFamily: "Nunito"
  readonly property int timeSize: 48
  readonly property int sideSize: 16
  readonly property int bottomMargin: 80
  readonly property int rightMargin: 80
  readonly property color textColor: "#e0e0e0"

  property date now: new Date()

  Timer {
    // Wake right after each minute boundary instead of polling every second
    interval: 60000 - (Date.now() % 60000) + 50
    running: true
    repeat: true
    onTriggered: {
      root.now = new Date()
      interval = 60000 - (Date.now() % 60000) + 50
    }
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        bottom: true
        right: true
      }
      margins {
        bottom: root.bottomMargin
        right: root.rightMargin
      }
      implicitWidth: content.implicitWidth + 80
      implicitHeight: content.implicitHeight + 40
      color: "transparent"

      WlrLayershell.namespace: "dev-desktop-clock"
      WlrLayershell.layer: WlrLayer.Bottom
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
      exclusionMode: ExclusionMode.Ignore
      // Click-through so wallpaper double-click still works
      mask: Region {}

      Column {
        id: content
        anchors.centerIn: parent
        // Offset the font's ~31.5px line-height padding, leaving 20px visible.
        spacing: -11.5
        layer.enabled: true
        layer.effect: MultiEffect {
          shadowEnabled: true
          shadowColor: "#99000000"
          shadowBlur: 0.6
          shadowVerticalOffset: 3
        }

        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Qt.formatTime(root.now, "hh:mm AP")
          color: root.textColor
          font.family: root.fontFamily
          font.pixelSize: root.timeSize
          font.weight: Font.Bold
        }

        Text {
          anchors.horizontalCenter: parent.horizontalCenter
          text: Qt.formatDate(root.now, "dddd, MMMM d").toUpperCase()
          color: root.textColor
          font.family: root.fontFamily
          font.pixelSize: root.sideSize
          font.weight: Font.DemiBold
          font.letterSpacing: 2
        }
      }
    }
  }
}
