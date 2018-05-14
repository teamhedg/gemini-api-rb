require 'uri'
require 'base64'
require 'openssl'
require 'faraday'
require 'json'
require 'faraday_middleware'
require 'gemini/configurable'
require 'gemini/errors'
require 'gemini/connection'
require 'gemini/websocket_connection'
require 'gemini/authenticated_rest'
require 'gemini/api_versions'
require 'gemini/client'

# API Version 1
require 'gemini/v1/ticker'
require 'gemini/v1/trades'
require 'gemini/v1/funding_book'
require 'gemini/v1/orderbook'
require 'gemini/v1/lends'
require 'gemini/v1/symbols'
require 'gemini/v1/stats'
require 'gemini/v1/account_info'
require 'gemini/v1/deposit'
require 'gemini/v1/orders'
require 'gemini/v1/wallet'
require 'gemini/v1/positions'
require 'gemini/v1/historical_data'
require 'gemini/v1/margin_funding'
