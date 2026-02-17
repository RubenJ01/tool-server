CREATE FUNCTION acquisition_channel_paid_medium AS utm_medium -> match(utm_medium, '^(.*cp.*|ppc|retargeting|paid.*)$')
