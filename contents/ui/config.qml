/*
 *  Copyright 2015 Robert <robspamm@fastmail.fm>
 *  Copyright 2015 David Edmundson <davidedmundson@kde.org>
 *  Copyright 2016 Anselmo L. S. Melo <anselmolsm@gmail.com>
 *  Copyright 2016 Ilya Ostapenko <ostapenko.public@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License or (at your option) version 3 or any later version
 * accepted by the membership of KDE e.V. (or its successor approved
 * by the membership of KDE e.V.), which shall act as a proxy
 * defined in Section 14 of version 3 of the license.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */

import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Item {
    id: appearancePage
    

    signal configurationChanged
    
    property string cfg_textFont
    property alias cfg_textColor: colorPicker.chosenColor
    property alias cfg_Command1: textField1.text
    property alias cfg_updateInterval1: updateIntervalSpinBox1.value
    property alias cfg_Command2: textField2.text
    property alias cfg_updateInterval2: updateIntervalSpinBox2.value
    property alias cfg_Command3: textField3.text
    property alias cfg_updateInterval3: updateIntervalSpinBox3.value
    property alias cfg_firstWeekOfYearIndex: firstWeekOfYearComboBox.currentIndex

    onCfg_textFontChanged: {
        // HACK by the time we populate our model and/or the ComboBox is finished the value is still undefined
        if (cfg_textFont) {
            for (var i = 0, j = fontsModel.count; i < j; ++i) {
                if (fontsModel.get(i).value == cfg_textFont) {
                    textFontComboBox.currentIndex = i
                    break
                }
            }
        }
    }

    ListModel {
        id: fontsModel
        Component.onCompleted: {
            var arr = [] // use temp array to avoid constant binding stuff
            arr.push({text: i18nc("Use default font", "Default"), value: ""})

            var fonts = Qt.fontFamilies()
            var foundIndex = 0
            for (var i = 0, j = fonts.length; i < j; ++i) {
                arr.push({text: fonts[i], value: fonts[i]})
            }
            append(arr)
        }
    }
    
           GridLayout { // there's no FormLayout :(
                columns: 2
                Layout.fillWidth: false

                Label {
                    Layout.fillWidth: false
                    horizontalAlignment: Text.AlignRight
                    text: i18n("Font:")
                }

                ComboBox {
                    id: fontFamilyComboBox
                    Layout.fillWidth: true
                    // ComboBox's sizing is just utterly broken
                    Layout.minimumWidth: units.gridUnit * 10
                    model: fontsModel
                    // doesn't autodeduce from model because we manually populate it
                    textRole: "text"

                    onCurrentIndexChanged: {
                        var current = model.get(currentIndex)
                        if (current) {
                            cfg_textFont = current.value
                            appearancePage.configurationChanged()
                        }
                    }
                }

        Label {
            text: "Color:"
        }
    
        ColorPicker{
            id: colorPicker
        }
        
        Label {	     		
            text: "Command #1:";
        }
        RowLayout {	    
        	TextField {
            	id: textField1
            	placeholderText: "Command"
            	text : plasmoid.configuration.Command1;			
        	}

        	Label {
            	text: i18n("Update interval:")
        	}

        	SpinBox {
            	id: updateIntervalSpinBox1
            	decimals: 1
            	stepSize: 0.1
            	minimumValue: 0.1
            	maximumValue : 3600
            	suffix: i18nc("Abbreviation for seconds", "s")
		} 
        }
          
        Label {	     		
            text: "Command #2:";
        }
	RowLayout {	    
        	TextField {
            	id: textField2
            	placeholderText: "Command"
            	text : plasmoid.configuration.Command2;			
        	}

        	Label {
            	text: i18n("Update interval:")
        	}

        	SpinBox {
            	id: updateIntervalSpinBox2
            	decimals: 1
            	stepSize: 0.1
            	minimumValue: 0.1
            	maximumValue : 3600
            	suffix: i18nc("Abbreviation for seconds", "s")
        	}
        }
           
        Label {	     		
            text: "Command #3:";
        }
	
	RowLayout {    
        	TextField {
            	id: textField3
            	placeholderText: "Command"
            	text : plasmoid.configuration.Command3;			
        	}

        	Label {
            	text: i18n("Update interval:")
        	}

        	SpinBox {
            	id: updateIntervalSpinBox3
            	decimals: 1
            	stepSize: 0.1
            	minimumValue: 0.1
            	maximumValue : 3600
            	suffix: i18nc("Abbreviation for seconds", "s")
            	}
        }
           
	Label {
        text: i18n("First week of year:")
      	}
      	ComboBox {
        id: firstWeekOfYearComboBox
        model: [ "First 4-day week", "Starts on Jan 1st" ]
      	}
    
            
        Item {Layout.fillHeight: true}
    }
}
