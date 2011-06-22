/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
import Qt.labs.components.native 1.0

// ~3.47" NHD
Item {
    property alias hugeFont: textForHugeFont.font
    property alias largeFont: textForLargeFont.font
    property alias mediumFont: textForMediumFont.font

    property int marginSize: 8
    property int spacingSize: 6

    property int starIconSize: 35
    property int toneIconSize: 35
    property int starTouchSize: 50
    property int frequencyStripHeight: 54
    property int frequencyButtonSize: 58

    property real consoleRatio: 0.65
    property real stationListRatio: 0.8

    Text {
        id: textForHugeFont
        font.family: "Nokia Sans"
        font.weight: Font.DemiBold
        font.pixelSize: (screen.currentOrientation == Screen.Landscape) ? 54 : 64
    }
    Text {
        id: textForLargeFont
        font.family: "Nokia Sans"
        font.weight: Font.Normal
        font.pixelSize: 20
    }
    Text {
        id: textForMediumFont
        font.family: "Nokia Sans"
        font.weight: Font.Normal
        font.pixelSize: (screen.currentOrientation == Screen.Landscape) ? 20 : 22
    }
}
