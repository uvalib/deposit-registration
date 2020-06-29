# shared secret to create auth tokens
AUTH_SHARED_SECRET = ENV['AUTH_SHARED_SECRET']

# deposit registration service endpoint
DEPOSITREG_URL = ENV['DEPOSITREG_URL']

# deposit authorization service endpoint
DEPOSITAUTH_URL = ENV['DEPOSITAUTH_URL']

# user information service endpoint
USERINFO_URL = ENV['USERINFO_URL']

# service timeouts
WEBSERVICE_TIMEOUT = ENV['WEBSERVICE_TIMEOUT']

# the healthcheck timeout (we want these to be shorter than a normal timeout)
HEALTHCHECK_TIMEOUT = 5
