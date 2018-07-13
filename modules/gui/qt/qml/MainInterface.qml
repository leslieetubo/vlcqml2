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

import QtQuick 2.6
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import QtQuick.Window 2.2
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
            width: VLCStyle.defaultWidthPlaylist
            Rectangle {
                id: playlistContent
                anchors.fill: parent
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Rectangle {
                        color: "grey"
                        height: 50
                        Layout.fillWidth: true

                        Rectangle{
                            id: search_bound
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
                                id: add_button
                                x: 209
                                y: -12
                                width: 30
                                height: 30
                                iconSource: "qrc://buttons/playlist_add.png"
                            }

                            Button {
                                id: remove_button
                                x: 245
                                y: -12
                                width: 30
                                height: 30
                                iconSource: "qrc://buttons/playlist_remove.png"
                            }

                            Image {
                                id: search_icon
                                x: 3
                                y: -12
                                width: 30
                                height: 30
                                source: "qrc:///search_dark.png"
                            }
                        }
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        ListView {
                            id: playlistView
                            spacing: 10
                            model: MovieModel{}
                            delegate: DraggableItem {
                                Rectangle {
                                    height: textLabel.height * 2
                                    width: playlistView.width
                                    color: VLCStyle.bgColor

                                    Text {
                                        id: textLabel
                                        Rectangle {
                                            id: rectangle
                                            width: parent.width
                                            height: parent.height
                                            color: VLCStyle.bgColor

                                            Text {
                                                id: text1
                                                x: 2
                                                y: 2
                                                width: 302
                                                height: 49
                                                text: model.title
                                                font.bold: true
                                                font.pixelSize: 15
                                                color: VLCStyle.textColor

                                                Image {
                                                    id: fav_star
                                                    x: 250
                                                    y: 1
                                                    width: 15
                                                    height: 15
                                                    source: "qrc:///star.png"
                                                }

                                                Text {
                                                    id: text3
                                                    x: 176
                                                    y: 16
                                                    width: 51
                                                    height: 20
                                                    text: model.duration
                                                    font.pixelSize: 12
                                                    color: VLCStyle.textColor
                                                }
                                            }
                                        }
                                    }

                                    // Bottom line border
                                    Rectangle {
                                        anchors {
                                            left: parent.left
                                            right: parent.right
                                            bottom: parent.bottom
                                        }
                                        height: 1
                                        color: "lightgrey"
                                    }
                                }

                                draggedItemParent: playlistContent

                                onMoveItemRequested: {
                                    model.move(from, to, 1);
                                }
                            }
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
        /*Playlist End*/
    }




}
