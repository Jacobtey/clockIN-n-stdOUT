   /* Copyright 2013 Anant Kamath <kamathanant@gmail.com>
    *Copyright 2015 Robert <robspamm@fastmail.fm>
    *Copyright 2015 David Edmundson <davidedmundson@kde.org>
    *Copyright 2016 Anselmo L. S. Melo <anselmolsm@gmail.com>
    *Copyright 2016 Ilya Ostapenko <ostapenko.public@gmail.com>
    *
    *This program is free software; you can redistribute it and/or
    *modify it under the terms of the GNU Lesser General Public
    *License as published by the Free Software Foundation; either
    *version 2.1 of the License, or (at your option) version 3, or any
    *later version accepted by the membership of KDE e.V. (or its
    *successor approved by the membership of KDE e.V.), which shall
    *act as a proxy defined in Section 6 of version 3 of the license.
    * 
    *This plasmoid is distributed in the hope that it will be useful,
    *but WITHOUT ANY WARRANTY; without even the implied warranty of
    *MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    *Lesser General Public License for more details.
    *
    *You should have received a copy of the GNU Lesser General Public
    *License along with this plasmoid. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import ApplicationLauncher 1.0
import org.kde.plasma.calendar 2.0 as PlasmaCalendar

Item {
    id: mainWindow
    Layout.minimumWidth: 400
    Layout.minimumHeight: 300
    property string textColor: Plasmoid.configuration.textColor
    property string textFont: Plasmoid.configuration.textFont
    
    Plasmoid.backgroundHints: Plasmoid.NoBackground
    
    Text {
        id: time
        font.family:textFont
        color: textColor
        font.pointSize: 105
        text: Qt.formatTime( dataSource.data["Local"]["DateTime"],"hh:mm" )
        anchors {
            top: parent.top;
            right: parent.right;
        }
    }
    
    Text {
        id: year
        font.family:textFont
        color: textColor
        font.pointSize: 40
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"]," yyyy" )
        anchors {
            top: time.bottom;
            right: time.right;
        }
    }
    
        Text {
        id: yeary
        font.family:textFont
        color: textColor
        opacity: 0
        font.pointSize: 40
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"],"yy" )
        anchors {
            top: time.bottom;
            right: time.right;
        }
    }
    
    Text {
        id: date
        font.family:textFont
        color: textColor     
        font.pointSize: 40
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"]," MMMM" )
        anchors {
            bottom: year.bottom;
            right: year.left;
        }
    }
    
    Text {
        id: day
        font.family:textFont
        color: textColor
        font.pointSize: 70
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"],"dd" )
        anchors {
            top: time.bottom;
            right: date.left;
        }
    }
    
    Text {
        id: week
        font.family:textFont
        opacity: 0.5
        color: textColor
        font.pointSize: 27
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"],"dddd" )
        anchors {
            top: year.bottom;
            right: year.right;
        }
    }
           
    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
    }
    
    PlasmaComponents.Label {
        id: label
        font.family:textFont
        font.capitalization :Font.AllUppercase
        color: textColor
        font.pointSize: 10
        anchors {
            verticalCenter: year.verticalCenter;
            horizontalCenter: yeary.left;
            horizontalCenterOffset: -18;
        }
    
        PlasmaCalendar.Calendar {
            id: calendarBackend
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: currentWeek()

        function currentWeek() {
        // Sunday & First 4-day week == ISO-8601, which is followed by Qt
        var week = calendarBackend.currentWeek()

            if (plasmoid.configuration.firstWeekOfYearIndex == 1) {
            // Check if January 1st is after Wednesday.
            var date = new Date(calendarBackend.year, 1, 1);
            var firstJanDayofWeek = date.getDay();
            // Wednesday == 3, week starting on Sunday
            if (firstJanDayofWeek > 3)
            week = week + 1;
            }
        return week < 10 ? "0" + week : week
        }
    }
    
    Application {
        id: launcher1  
        appName: plasmoid.configuration.Command1;
	}
	Timer {
		interval: 1000 * plasmoid.configuration.updateInterval1;
		running: true;
		repeat: true;
		onTriggered: out1.text = launcher1.launchScriptGetSTDOUT(); 
	}
	
    PlasmaComponents.Label {
    	id: out1;
        font.family:textFont
        color:textColor
        font.pointSize: 15
    	text: "Default";
        anchors {
            verticalCenter: week.bottom;
            right: week.right;
            verticalCenterOffset: 35;
        }
    }
    Application {
        id: launcher2  
        appName: plasmoid.configuration.Command2;
	}
	Timer {
		interval: 1000 * plasmoid.configuration.updateInterval2;
		running: true;
		repeat: true;
		onTriggered: out2.text = launcher2.launchScriptGetSTDOUT(); 
	}
	
    PlasmaComponents.Label {
    	id: out2;
        font.family:textFont
        color:textColor
        font.pointSize: 15
    	text: "Default";
        anchors {
            top: out1.bottom;
            left: out1.left;
        }
    }
    Application {
        id: launcher3  
        appName: plasmoid.configuration.Command3;
	}
	Timer {
		interval: 1000 * plasmoid.configuration.updateInterval3;
		running: true;
		repeat: true;
		onTriggered: out3.text = launcher3.launchScriptGetSTDOUT(); 
	}
	
    PlasmaComponents.Label {
    	id: out3;
        font.family:textFont
        color:textColor
        font.pointSize: 15
    	text: "Default";
        anchors {
            top: out2.bottom;
            left: out2.left;
        }
        /* text: launcher.launchScript(); */
    }
}
