   /* Copyright 2013 Anant Kamath <kamathanant@gmail.com>
    *Copyright 2015 Robert <robspamm@fastmail.fm>
    *Copyright 2015 David Edmundson <davidedmundson@kde.org>
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
            horizontalCenter: parent.horizontalCenter;
        }
    }
    
    Text {
        id: date
        font.family:textFont
        color: textColor
        font.pointSize: 40
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"]," MMMM yyyy" )
        anchors {
            top: time.bottom;
            right: time.right;
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
        opacity: 0.7
        color: textColor
        font.pointSize: 27
        text : Qt.formatDate( dataSource.data["Local"]["DateTime"],"dddd" )
        anchors {
            top: date.bottom;
            right: date.right;
        }
    }
     
    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: ["Local"]
        interval: 500
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
            top: week.bottom;
            right: week.right;
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
