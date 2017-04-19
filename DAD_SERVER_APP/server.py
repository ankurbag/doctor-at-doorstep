import os
from flask import Flask, request
from twilio.jwt.access_token import AccessToken, VoiceGrant
from twilio.rest import Client
import twilio.twiml

ACCOUNT_SID = 'AC4c0150c731ba109b664e62992be482c8'
API_KEY = 'SK67583dfb8e642df5fb5c9d01d1f66734'
API_KEY_SECRET = '9V6vToSlbphFARDYjFTOkW1S8GRYZTTg'
PUSH_CREDENTIAL_SID = 'CR8ca978c38990210c00cf9f98f1422a64'
APP_SID = 'AP685ed03ac7882286002ab1bc77a19904'

IDENTITY = 'voice_test'
CALLER_ID = 'quick_start'

app = Flask(__name__)

@app.route(' )
def token():
  account_sid = os.environ.get("ACCOUNT_SID", ACCOUNT_SID)
  api_key = os.environ.get("API_KEY", API_KEY)
  api_key_secret = os.environ.get("API_KEY_SECRET", API_KEY_SECRET)
  push_credential_sid = os.environ.get("PUSH_CREDENTIAL_SID", PUSH_CREDENTIAL_SID)
  app_sid = os.environ.get("APP_SID", APP_SID)

  grant = VoiceGrant(
    push_credential_sid=push_credential_sid,
    outgoing_application_sid=app_sid
  )

  token = AccessToken(account_sid, api_key, api_key_secret, IDENTITY)
  token.add_grant(grant)

  return str(token)

@app.route('/outgoing', methods=['GET', 'POST'])
def outgoing():
  resp = twilio.twiml.Response()
  resp.say("Congratulations! You have made your first oubound call! Good bye.")
  return str(resp)

@app.route('/incoming', methods=['GET', 'POST'])
def incoming():
  resp = twilio.twiml.Response()
  resp.say("Congratulations! You have received your first inbound call! Good bye.")
  return str(resp)

@app.route('/placeCall', methods=['GET', 'POST'])
def placeCall():
  account_sid = os.environ.get("ACCOUNT_SID", ACCOUNT_SID)
  api_key = os.environ.get("API_KEY", API_KEY)
  api_key_secret = os.environ.get("API_KEY_SECRET", API_KEY_SECRET)

  client = Client(api_key, api_key_secret, account_sid)
  call = client.calls.create(url=request.url_root + 'incoming', to='client:' + IDENTITY, from_='client:' + CALLER_ID)
  return str(call.sid)

@app.route('/callSipster', methods=['GET', 'POST'])
def callSipster():
  account_sid = os.environ.get("ACCOUNT_SID", ACCOUNT_SID)
  api_key = os.environ.get("API_KEY", API_KEY)
  api_key_secret = os.environ.get("API_KEY_SECRET", API_KEY_SECRET)

  client = Client(api_key, api_key_secret, account_sid)
  call = client.calls.create(to='+16172598868',from_='+13476255515',
                           url='http://demo.twilio.com/docs/voice.xml',
                           send_digits='1234#',
                           method='GET')
  return str(call.sid)

@app.route('/', methods=['GET', 'POST'])
def welcome():
  resp = twilio.twiml.Response()
  resp.say("Welcome to Twilio")
  return str(resp)

@app.route(“/sendChat”, methods=['GET', 'POST'])
def time():
 from_number = request.values.get('From', None)
 body_number = str(request.values.get('Body',None))
 message =  "Got the message with Body:"+ body_number
 resp = twilio.twiml.Response()
 resp.message(message)
 call = client.calls.create(from_="+13476255515",to=from_number,url="http://twimlets.com/menu?Message=Welcome%20to%20SIPSTER%20Please%20press%201%20to%20doctor%20Press%202%20to%20Doctor2&Options%5B1%5D=http%3A%2F%2Ftwimlets.com%2Fmenu%3FMessage%3DPlease%2520press%25201%2520to%2520study%2520Press%25202%2520to%2520study1%26Options%255B1%255D%3Dhttp%253A%252F%252Ftwimlets.com%252Fforward%253FPhoneNumber%253D6179925194%2526%26Options%255B2%255D%3Dhttp%253A%252F%252Ftwimlets.com%252Fforward%253FPhoneNumber%253D6179925193%2526%26&Options%5B2%5D=http%3A%2F%2Ftwimlets.com%2Fmenu%3FMessage%3DPress%25201%2520for%2520time%2520Press%25202%2520for%2520lunch%26Options%255B1%255D%3Dhttp%253A%252F%252Ftwimlets.com%252Fforward%253FPhoneNumber%253D6179925191%2526%26Options%255B2%255D%3Dhttp%253A%252F%252Ftwimlets.com%252Fforward%253FPhoneNumber%253D6179925190%2526%26&")

 call = client.calls.create(from_="+13476255515",to=body_number,url="https://handler.twilio.com/twiml/EH125cf45c62541c850fa36529f8a5d6f1")
 return str(resp)

if __name__ == "__main__":
  port = int(os.environ.get("PORT", 5000))
  app.run(host='0.0.0.0', port=port, debug=True)
