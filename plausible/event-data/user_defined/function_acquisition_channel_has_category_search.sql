CREATE FUNCTION acquisition_channel_has_category_search AS referrer_source -> (dictGet('acquisition_channel_source_category_dict', 'category', referrer_source) = 'SOURCE_CATEGORY_SEARCH')
