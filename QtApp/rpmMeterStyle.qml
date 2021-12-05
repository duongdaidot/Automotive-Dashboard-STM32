import QtQuick 2.0
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle
{
    id: rpmMeterStyle

    function degree2Rad(deg)
    {
        return deg * (Math.PI / 180);
    }

    labelStepSize: 1000

    tickmark: Rectangle {
        visible:styleData.value % 100 == 0
        implicitWidth: outerRadius * 0.02
        antialiasing: true
        implicitHeight: outerRadius * 0.06
        color: "#e5e5e5"
    }

    background: Canvas {

        onPaint: {
            var ctr = getContext("2d");
            ctr.reset();
            ctr.beginPath();

            ctr.strokeStyle = "red";
            ctr.linewidth = outerRadius * 0.02;

            ctr.arc(outerRadius, outerRadius, outerRadius - ctr.lineWidth / 2,
                    degree2Rad(valueToAngle(120) - 90), degree2Rad(valueToAngle(180) - 90))
            ctr.stroke();
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.2


            Text {
                id: unitSpeed
                text: "RPM"
                color: "white"
                font.pixelSize: outerRadius * 0.1

            }
        }

    }
}

