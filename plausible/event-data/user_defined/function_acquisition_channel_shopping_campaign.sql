CREATE FUNCTION acquisition_channel_shopping_campaign AS utm_campaign -> match(utm_campaign, '^(.*(([^a-df-z]|^)shop|shopping).*)$')
