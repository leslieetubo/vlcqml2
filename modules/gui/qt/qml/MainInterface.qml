/*****************************************************************************
 * MainInterface.qml : Main QML component displaying the mediacenter, the
 *     playlist and the sources selection
 ****************************************************************************
 * Copyright (C) 2006-2011 VideoLAN and AUTHORS
 * $Id$
 *
 * Authors: Maël Kervella <dev@maelkervella.eu>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston MA 02110-1301, USA.
 *****************************************************************************/

import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import "qrc:///style/"

import "qrc:///mediacenter/" as MC
import "qrc:///playlist/" as PL


Item {
    // The functions the C++ part can call
    function reloadData() { mcDisplay.reloadData();}
    function changedCategory() { mcDisplay.changedCategory(); }
    function changedView() { mcDisplay.changedView(); }
    function reloadPresentation() { mcDisplay.reloadPresentation(); }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        ColumnLayout {
            id: column

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            Layout.minimumWidth: VLCStyle.minWidthMediacenter
            spacing: 0

            /* Source selection*/
            BannerSources {
                id: sourcesBanner

                // function triggered when a source is selected
                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }

                z : 10
                height: VLCStyle.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true

                need_toggleView_button: true
            }

            /* Sub-source selection */
            SubBannerSources {
                id: subSourcesBanner

                // function triggered when a source is selected
                function selectSource ( name ) {
                    medialib.selectSource(name);
                    subSourcesBanner.update();
                }

                z : 10
                height: VLCStyle.heightBar_normal
                Layout.preferredHeight: height
                Layout.minimumHeight: height
                Layout.maximumHeight: height
                Layout.fillWidth: true
            }

            /* MediaCenter */
            MC.MCDisplay {
                id: mcDisplay

                z: 0
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

        }

        /* Playlist */
        PL.PLDisplay {
            Rectangle{
            id: search_area
            width: parent.width
            height: 50
            color: "grey"

                Rectangle{
                    id: search_element_bound
                    x: 13
                    y: 23
                    width: parent.width
                    height: 22
                    anchors.horizontalCenterOffset: 9
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "grey"
                    TextInput{
                        id:search_text
                        x: 39
                        y: -12
                        width: parent.width
                        height: 31
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        property string placeholderText: "Search"
                        Text {
                            x: 14
                            y: 7
                            text: search_text.placeholderText
                            verticalAlignment: Text.AlignVCenter
                            color: "#bbb"
                            visible: !search_text.text
                        }
                    }

                    Button {
                        id: button
                        x: 209
                        y: -12
                        width: 30
                        height: 30
                    }

                    Button {
                        id: button1
                        x: 245
                        y: -12
                        width: 30
                        height: 30
                    }

                    Image {
                        id: search_icon
                        x: 3
                        y: -12
                        width: 30
                        height: 30
                        source: "qrc:///search_1.png"
                    }
                }
            }
            Rectangle{
                id: playlist_area
                x: 0
                y: 86
                width: parent.width
                height: 400
                ScrollView {
                    anchors.fill: parent
                    ListView {
                        width: parent.width
                        height: parent.height
                        spacing: 42
                        contentHeight: parent.height
                        model: MovieModel {}
                        focus: true
                        delegate: Text {
                            x: 0
                            y: 0
                            Rectangle {
                                id: rectangle
                                x: 0
                                y: 0
                                width: 310
                                height: 57
                                color: "grey"

                                Text {
                                    id: text1
                                    x: 8
                                    y: 10
                                    width: 150
                                    height: 27
                                    text: name
                                    font.bold: true
                                    font.pixelSize: 15
                                }

                                ProgressBar {
                                    id: progressBar
                                    x: 8
                                    y: 46
                                    width: 174
                                    height: 3
                                    value: 0.6
                                }

                                Button {
                                    id: button
                                    x: 266
                                    y: 8
                                    width: 30
                                    height: 30
                                    text: qsTr("")
                                }

                                Button {
                                    id: button1
                                    x: 230
                                    y: 8
                                    width: 30
                                    height: 30
                                    text: qsTr("")
                                }

                                Text {
                                    id: text3
                                    x: 184
                                    y: 40
                                    width: 51
                                    height: 15
                                    text: duration
                                    font.pixelSize: 12
                                }
                            }
                            //text: name + ": " + duration +": "+ stars
                            /*Label{
                                text: name
                            }*/   
                        }
                    }
                }
            }
            
            /*
            id: plDisplay
            color: "light blue"
            z: 20
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            Layout.maximumWidth: VLCStyle.maxWidthPlaylist
            default_width: VLCStyle.defaultWidthPlaylist
            */
        }
    }




}
