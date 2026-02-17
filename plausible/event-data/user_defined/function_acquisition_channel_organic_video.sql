CREATE FUNCTION acquisition_channel_organic_video AS (referrer_source, utm_medium) -> (acquisition_channel_has_category_video(referrer_source) OR (position(utm_medium, 'video') > 0))
