CREATE FUNCTION acquisition_channel_referral AS (utm_medium, referrer_source) -> ((utm_medium IN ('referral', 'app', 'link')) OR (NOT empty(referrer_source)))
