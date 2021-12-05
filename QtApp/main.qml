import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4
import com.uit.ce103 1.0

Window {
    id: window
    width: 1000
    height: 500
    visible: true
    title: qsTr("Automobile Dashboard")

    ValueSource {
        id: valueSource
    }

    Rectangle {
        id: dashboard
        anchors.centerIn: parent
        height: 500
        width: 1000
        color: "black";

        Row {
            id: dashboardRow
            spacing: dashboard.width * 0.02
            anchors.centerIn: parent

            TextEdit {
                id: gear
            }

            ArrowIndicator {
                id: leftindicator
                anchors.verticalCenter: parent.verticalCenter
                height: dashboard.height * 0.2 - dashboardRow.spacing
                width: height
                direction: Qt.LeftArrow

            }

            CircularGauge {
                id: rpmMeter
                width: height
                height: dashboard.height * 0.6
                value: acceleration ? maximumValue : 0
                maximumValue: 5000
                property bool acceleration: false
                style: RPMMeterStyle {}

                Behavior on value {
                    NumberAnimation {
                        duration: 7000
                    }
                }
                Component.onCompleted:  forceActiveFocus();
            }

            CircularGauge {
                property bool acceleration: false
                id: speedometer
                value: acceleration ? maximumValue : 0
                width: height
                height: dashboard.height * 0.6
                maximumValue: 180


                style: SpeedometerStyle {}

                Behavior on value {
                    NumberAnimation {
                        duration: 9000
                    }
                }
                Component.onCompleted:  forceActiveFocus();

                UART {
                    id: uart_qml
                    onValueChanged: {
                        speedometer.acceleration = uart_qml.value == 1 ? true : false
                        rpmMeter.acceleration = uart_qml.value == 1 ? true : false
                    }
                    onIndicatorChanged: {
                        leftindicator.on = uart_qml.indicator == 3 ? true : false;
                        rightIndicator.on = uart_qml.indicator == 4 ? true : false;;
                    }
                }
            }

            ArrowIndicator{
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                height: dashboard.height * 0.2 - dashboardRow.spacing
                width: height
                direction: Qt.RightArrow
            }
        }

        Keys.onLeftPressed: {
            leftindicator.on = true;
            rightIndicator.on = false;
        }

        Keys.onRightPressed: {
            rightIndicator.on = true;
            leftindicator.on = false;
        }

        Keys.onUpPressed: {
            speedometer.acceleration = true
            rpmMeter.acceleration = true
        }

        Keys.onReleased: {
            if (event.key === Qt.Key_Up)
            {
                speedometer.acceleration = false;
                rpmMeter.acceleration = false;
                event.accepted = true;
            }
        }
    }
}

