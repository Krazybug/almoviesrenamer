# -*- coding: latin-1 -*-

__author__ = "Alberto Malagoli"

from cx_Freeze import setup, Executable
import sys
sys.path.append('src')
import os.path
import utils
import shutil

## change setting first_time before building
from PyQt4.QtCore import QSettings
# load settings
settings = QSettings("src/preferences.ini", QSettings.IniFormat)
# save value on settings file
settings.setValue("first_time", True)
settings.setValue("stats_agreement", 0)
settings.setValue("duration_representation", 0)
settings.setValue("language_representation", 1)
settings.setValue("words_separator", 0)
settings.sync()

shutil.rmtree('src/log', ignore_errors = True)

includes = [
            'enzyme'
            ]

excludes = [
#            '_gtkagg',
#            '_tkagg',
#            'bsddb',
#            'curses',
#            'email',
#            'pywin.debugger',
#            'pywin.debugger.dbgcon',
#            'pywin.dialogs',
#            'tcl',
#            'Tkconstants',
#            'Tkinter',
#            'win32api',
#            '_ssl',
#            '_sqlite3'
            ]

include_files = [
                 ("src/icons", "icons"),
                 ("src/app_de.qm", "app_de.qm"),
                 ("src/app_es.qm", "app_es.qm"),
                 ("src/app_fr.qm", "app_fr.qm"),
                 ("src/app_it.qm", "app_it.qm"),
                 ("src/exceptionhandler.py", "exceptionhandler.py"),
                 ("src/gui.py", "gui.py"),
                 ("src/main.py", "main.py"),
                 ("src/movie.py", "movie.py"),
                 ("src/utils.py", "utils.py"),
                 ("src/main_window.ui", "main_window.ui"),
                 ("src/preferences_dialog.ui", "preferences_dialog.ui"),
                 ("src/renaming_rule_dialog.ui", "renaming_rule_dialog.ui"),
                 ("src/stats_agreement_dialog.ui", "stats_agreement_dialog.ui"),
                 ("src/preferences.ini", "preferences.ini"),
                 ("src/languages.txt", "languages.txt"),
                 "CHANGELOG.txt",
                 "gpl-3.0.txt",
                 "README.txt"
                 ]

buildOptions = dict(
                    includes = includes,
                    excludes = excludes,
                    include_files = include_files,
                    optimize = 2,
                    )

base = None
target_name = utils.PROGRAM_NAME
if sys.platform == "win32":
    base = "Win32GUI"
    target_name += ".exe"

main_exe = Executable(
                      script = "src/main.py",
                      base = base,
                      targetName = target_name,
                      compress = True,
                      )

setup(
      name = utils.PROGRAM_NAME,
      version = utils.PROGRAM_VERSION,
      author = "Alberto Malagoli",
      author_email = 'albemala@gmail.com',
      url = 'https://code.google.com/p/almoviesrenamer/',
      options = dict(build_exe = buildOptions),
      executables = [main_exe]
      )



