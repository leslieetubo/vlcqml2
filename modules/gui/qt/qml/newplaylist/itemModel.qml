import QtQuick 2.0

ListModel {
    id: itemModel
    ListElement {
        title: "The Mummy"
        duration: "2:00:00"
        elapsed: 0.3
    }
    ListElement {
        title: "Game of kings"
        duration: "40:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Thor Ragnarok"
        duration: "2:20:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Mr. Bean"
        duration: "2:10:20"
        elapsed: 0.0
    }
    ListElement {
        title: "Transporter"
        duration: "1:50:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Attack on the titans"
        duration: "40:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Star Wars"
        duration: "44:00"
        elapsed: 0.0
    }
    ListElement {
        title: "The Phantom Menace"
        duration: "2:00:00"
        elapsed: 0.3
    }
    ListElement {
        title: "Attack of the Clones"
        duration: "40:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Revenge of the Siths"
        duration: "2:20:00"
        elapsed: 0.0
    }
    ListElement {
        title: "A New Hope"
        duration: "2:10:20"
        elapsed: 0.0
    }
    ListElement {
        title: "The Empire Strikes Back"
        duration: "1:50:00"
        elapsed: 0.0
    }
    ListElement {
        title: "Return of the Jedi"
        duration: "1:40:00"
        elapsed: 0.0
    }
    ListElement {
        title: "The Force Awakens"
        duration: "44:00"
        elapsed: 0.0
    }
}

/*
ListView {
    width: 200; height: 250

    model: myModel
    delegate: Text { text: "Animal: " + type + ", " + size }
}*/