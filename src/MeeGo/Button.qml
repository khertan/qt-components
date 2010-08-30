/****************************************************************************
**
** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project on Qt Labs.
**
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions contained
** in the Technology Preview License Agreement accompanying this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
****************************************************************************/

import Qt 4.7
import Qt.labs.components 1.0
import com.meego.themebridge 1.0

ImplicitSizeItem {
    id: button

    property alias checked: checkable.checked
    property alias checkable: checkable.enabled

    // Internal property, to be used by ButtonRow and other button containers.
    property alias __exclusiveGroup: checkable.exclusiveGroup

    property alias text: label.text

    // Icon properties. Precedence is the following:
    // Source has precedence over Id
    // When checked, try to use checked Source or Id, if empty, fallback to default Source or Id
    property string iconSource
    property string checkedIconSource
    property string iconId
    property string checkedIconId

    // Defines the button viewtype. Usually this is automatically set by
    // specialized containers like the ButtonRow or the QueryDialog
    property alias buttonType: meegostyle.styleType
    property alias groupPosition: background.tilePosition
    property alias styleObjectName: meegostyle.styleObjectName

    property bool iconVisible: true
    property alias textVisible: label.visible

    signal clicked

    implicitWidth: Math.max(meegostyle.preferredWidth, centeredContainer.width)
    implicitHeight: meegostyle.preferredHeight

    Style {
        id: meegostyle
        styleClass: "MButtonStyle"
        mode: {
            if (mouseArea.containsMouse && mouseArea.pressed)
                return "pressed"
            else if (checkable.checked)
                return "selected"
            else
                return "default"
        }
    }

    Background {
        id: background
        anchors.fill: parent
        style: meegostyle
    }

    Item {
        id: centeredContainer
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: calculateWidth()

        function calculateWidth() {
            // XXX Check how does MeeGo Touch does that. Maybe use style paddings, etc
            var width = iconFromSource.anchors.leftMargin + label.anchors.rightMargin
            var hasIcon = (iconFromId.visible || iconFromSource.visible)

            if (textVisible && hasIcon) {
                width += label.width + iconFromSource.width + 10
            } else if (textVisible) {
                width += label.width
            } else if (hasIcon) {
                width += iconFromSource.width
            }

            return width
        }

        Icon {
            id: iconFromId
            anchors.fill: iconFromSource

            // When checked, try to use checked Id. If empty, the standard Id is the fallback
            iconId: {
                if (checkable.checked && button.checkedIconId)
                    return button.checkedIconId;
                return button.iconId;
            }

            // Visiblity check for default state (icon is not explicitly hidden)
            // Icon is shown if there's a valid iconId, respecting the higher
            // priority of iconFromSource
            visible: iconId && !iconFromSource.visible
        }

        Image {
            id: iconFromSource
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 10
            width: meegostyle.current.get("iconSize").width
            height: meegostyle.current.get("iconSize").height

            // When checked, try to use checked source. If empty, the standard source is the fallback
            source: {
                if (checkable.checked && button.checkedIconSource)
                    return button.checkedIconSource;
                return button.iconSource;
            }

            // Visibility check for default state (icon is not explicitly hidden)
            visible: {
                if (iconFromSource.source == "")
                    return false;

                if (!checkable.checked)
                    return true;

                // Show sourceIcon when
                //  1) checkedIconSource is present (highest priority), or
                //  2) no checked icon exists (fallback)
                return button.checkedIconSource || !button.checkedIconId;
            }

            states: State {
                name: "iconHidden"
                when: !button.iconVisible
                // Hide both icons
                PropertyChanges { target: iconFromSource; visible: false; source: "" }
                PropertyChanges { target: iconFromId; visible: false; iconId: "" }
            }
        }

        Label {
            id: label
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10

            // XXX This does not make sense yet, since the label width is not being set
            // horizontalAlignment: Text.AlignHCenter
            verticalAlignment: meegostyle.current.get("verticalTextAlign")

            font: meegostyle.current.get("font")
            color: meegostyle.current.get("textColor")

            text: "Effect"
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            checkable.toggle();
            button.clicked();
        }
    }

    Checkable {
        id: checkable
        value: button
    }
}
