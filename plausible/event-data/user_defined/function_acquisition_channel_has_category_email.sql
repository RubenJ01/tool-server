CREATE FUNCTION acquisition_channel_has_category_email AS referrer_source -> (dictGet('acquisition_channel_source_category_dict', 'category', referrer_source) = 'SOURCE_CATEGORY_EMAIL')
