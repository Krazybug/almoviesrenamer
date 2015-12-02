import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

ApplicationWindow {
    id: window
    visible: true
    width: 700
    height: 600
    title: "ALMoviesRenamer"

    signal addMovieButtonClicked()
    signal movieItemSelected(var row)
    signal movieAlternativeTitleChanged(var index)
    signal searchMovieButtonClicked()

    property alias loadingPanelVisible: loadingPanel.visible
    property alias loadingPanelMovieTitle: loadingPanelMovieTitle.text

    property alias moviesTableModel: moviesTable.model
    property alias moviesTableCurrentRow: moviesTable.currentRow

    property alias movieInfoPanelVisible: movieInfoPanel.visible

    property alias movieAlternativeTitlesModel: movieAlternativeTitles.model
    property alias movieAlternativeTitleIndex: movieAlternativeTitles.currentIndex

    property alias movieTitle: movieTitle.text
    property alias movieOriginalTitle: movieOriginalTitle.text
    property alias movieYear: movieYear.text
    property alias movieDirectors: movieDirectors.text
    property alias movieDuration: movieDuration.text
    property alias movieLanguage: movieLanguage.text

    property alias searchAlternativeMovieProgressBarVisible: searchAlternativeMovieProgressBar.running
    property alias searchAlternativeTitle: searchAlternativeTitleTextField.text
    property alias searchAlternativeYear: searchAlternativeYearTextField.text
    property alias searchAlternativeLanguage: searchAlternativeLanguageTextField.text

    property alias movieRenamedPanelVisible: movieRenamedPanel.visible

    property alias movieErrorPanelVisible: movieErrorPanel.visible
    property alias movieError: movieError.text

    menuBar: MenuBar {
        Menu {
            title: "Movies"
            MenuItem {
                text: "Add movies..."
                iconSource: "../icons/movie_add.png"
            }
            MenuItem {
                text: "Add all movies in folder..."
                iconSource: "../icons/movies_from_folder.png"
            }
            MenuItem {
                text: "Add all movies in folder (including subfolders)..."
                iconSource: "../icons/movies_from_folder.png"
            }
            MenuSeparator {}
            MenuItem {
                text: "Remove selected movies from list"
                iconSource: "../icons/movie_remove.png"
            }
            MenuItem {
                text: "Remove all movies from list"
                iconSource: "../icons/movie_erase.png"
            }
            MenuSeparator {}
            MenuItem {
                text: "Change renaming rule..."
                iconSource: "../icons/tag.png"
            }
            MenuSeparator {}
            MenuItem {
                text: "Rename movies"
                iconSource: "../icons/pencil.png"
            }
        }
        Menu {
            title: "Application"
            MenuItem {
                text: "Preferences..."
            }
            MenuItem {
                text: "About..."
            }
        }
    }

    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent

        RowLayout {
            spacing: 6
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11

            Button {
                text: "Add movies"
                iconSource: "../icons/movie_add.png"
                onClicked: addMovieButtonClicked()
            }
            Button {
                text: "Remove movies"
                iconSource: "../icons/movie_remove.png"
//                onClicked: addMovieButtonClicked()
            }
            Item {
                width: 11
            }
            Button {
                text: "Renaming rule"
                iconSource: "../icons/tag.png"
//                onClicked: addMovieButtonClicked()
            }
            Item {
                width: 11
            }
            Button {
                text: "Rename movies"
                iconSource: "../icons/pencil.png"
//                onClicked: addMovieButtonClicked()
            }
        }

        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "lightGray"
        }

        ColumnLayout {
            id: loadingPanel
            spacing: 6
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11

            Label {
                text: "Getting information from:"
            }
            Label {
                id: loadingPanelMovieTitle
            }
            BusyIndicator {
                running: loadingPanel.visible
            }
            Label {
                text: "This may take a while... I will play a sound when it finishes."
            }
        }

        TableView{
            id: moviesTable
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: []

            onClicked: movieItemSelected(row)

            TableViewColumn{
                role: "original_name"
                title: "Original name"
            }
            TableViewColumn{
                role: "new_name"
                title: "New name"
            }
        }

        ColumnLayout {
            id: movieInfoPanel
            spacing: 6
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11

            Label {
                text: "Movie:"
            }
            ComboBox {
                id: movieAlternativeTitles
                Layout.fillWidth: true
                model: []

                onCurrentIndexChanged: movieAlternativeTitleChanged(currentIndex)
            }
            GridLayout {
                rowSpacing: 6
                columnSpacing: 6
                columns: 2

                Label { text: "Title:" }
                Label { id: movieTitle }

                Label { text: "Original title:" }
                Label { id: movieOriginalTitle }

                Label { text: "Year:" }
                Label { id: movieYear }

                Label { text: "Director(s):" }
                Label { id: movieDirectors }

                Label { text: "Duration:" }
                Label { id: movieDuration }

                Label { text: "Language:" }
                Label { id: movieLanguage }
            }
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "lightGray"
            }
            Label {
                text: "Not the right movie? Search for another one:"
            }
            GridLayout {
                rowSpacing: 6
                columnSpacing: 6
                columns: 3

                Label { text: "Title:" }
                Label { text: "Year:" }
                Label { text: "Language:" }
                TextField {
                    id: searchAlternativeTitleTextField
                    Layout.fillWidth: true
                    placeholderText: "Title"
                }
                TextField {
                    id: searchAlternativeYearTextField
                    placeholderText: "Year"
                }
                TextField {
                    id: searchAlternativeLanguageTextField
                    placeholderText: "Language"
                }
            }
            RowLayout {
                spacing: 6
                Button {
                    text: "Search"

                    onClicked: searchMovieButtonClicked()
                }
                BusyIndicator {
                    id: searchAlternativeMovieProgressBar
                    running: false
                }
            }
        }

        Label {
            id: movieRenamedPanel
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11
            text: "This movie has been correctly renamed."
            color: "green"
        }

        ColumnLayout {
            id: movieErrorPanel
            spacing: 6
            Layout.leftMargin: 11
            Layout.rightMargin: 11
            Layout.topMargin: 11
            Layout.bottomMargin: 11

            Label {
                text: "There has been the following error during renaming:"
            }
            Label {
                id: movieError
                color: "red"
            }
        }
    }
}
