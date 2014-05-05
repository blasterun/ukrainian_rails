# -*- encoding: utf-8 -*-

# I18n transliteration delegates to Ukrainian::Transliteration (we're unable
# to use common I18n transliteration tables with Ukrainian)
#
# Правило транслитерации для I18n использует Ukrainian::Transliteration
# (использовать обычный механизм и таблицу транслитерации I18n с
# русским языком не получится)
{
  :uk => {
    :i18n => {
      :transliterate => {
        :ukle => lambda { |str| Ukrainian.transliterate(str) }
      }
    }
  }
}
