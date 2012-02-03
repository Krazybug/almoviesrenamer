# -*- coding: latin-1 -*-
__author__ = "Alberto Malagoli"

import re
import utils
import difflib

class AlternativeMovie:
    """    
    """

    def __init__(self, title, movie, guessed_title):
        """
        constructor.
        """

        stitle = title.split('::')

        countries = ''
        language = None
        if len(stitle) == 2:
            countries = stitle[1]
            possible_language = re.search('(?:[(])([a-zA-Z]+?)(?: title[)])', countries)
            if possible_language:
                try:
                    language = utils.languages_db.get(name = possible_language.group(1))
                except KeyError:
                    pass
            if language == None:

                country = countries.split(',')[0]
                country = re.sub('\(.*?\)', '', country).strip()
                try:
                    print(country)
                    language_name = utils.countryToLanguage(country)
                    print(language_name)
                    language = utils.languages_db.get(name = language_name)
                    print(language.name)
                except KeyError:
                    pass
                print('---')
        else:
            language_name = movie.guessLanguage()
            if language_name != None:
                try:
                    language = utils.languages_db.get(name = language_name)
                except KeyError:
                    pass

        self.title_ = stitle[0]
        self.countries_ = countries
        self.language_ = language
        self.movie_ = movie

        score = difflib.SequenceMatcher(None, self.title_.lower(), guessed_title.lower()).ratio()
        self.score_ = score

    def title(self):
        return self.title_

    def countries(self):
        return self.countries_

    def year(self):
        if self.movie_.get('year') != None:
            return unicode(self.movie_.get('year'))
        return ''

    def language(self):
        return self.language_

    def movie(self):
        return self.movie_

    def score(self):
        return self.score_