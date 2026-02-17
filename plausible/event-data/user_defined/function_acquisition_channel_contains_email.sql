CREATE FUNCTION acquisition_channel_contains_email AS column -> match(column, 'e[-_ ]?mail|newsletter')
