from google.cloud import dialogflow
from configparser import ConfigParser
import pyttsx3
import json
import random


class Prepare:
    def __init__(self):
        with open("configuration/local_intents.json") as jsonfile:
            self.local_intents = json.load(jsonfile)
            jsonfile.close()
        config = ConfigParser()
        config.read("configuration/config.ini")
        self.lang_code = config['DIALOGFLOW']['lang_code']

    def search_in_intents(self, message):
        self.time = self.local_intents['intents'][0]['time'][self.lang_code]
        self.weather = self.local_intents['intents'][0]['weather'][self.lang_code]
        print(self.time)
        if message in self.time:
            return cronus.Crono().chronius()
        
        elif message in self.weather:
            print("weather found!")
            return "Current Weather is cloudy"
        
        else:
            print("not found!")
            return "unknown"

class Intent:
    def __init__(self):
        self.configure()

        self.session_client = dialogflow.SessionsClient()
        self.session = self.session_client.session_path(self.project_id, self.session_id)

    def configure(self):
        config = ConfigParser()
        config.read("configuration/config.ini")

        self.project_id = config['DIALOGFLOW']['project_id']
        self.session_id = config['DIALOGFLOW']['session_id']
        self.language_code = config['DIALOGFLOW']['lang_code']

    def send_message(self, message):
        text_input = dialogflow.TextInput(text=message, language_code=self.language_code)
        query_input = dialogflow.QueryInput(text=text_input)

        response = self.session_client.detect_intent(
            request={"session": self.session, "query_input": query_input}
        )

        print("Fulfillment text: {}\n".format(response.query_result.fulfillment_text))
        return str(response.query_result.fulfillment_text)


class TTSX:
    def __init__(self):
        self.tts = pyttsx3.init()
        self.tts.setProperty('voice', 'en')

    def say(self, message):
        self.tts.say(message)
        self.tts.runAndWait()

intent = Intent()
ttsx = TTSX()
prepare = Prepare()


while True:
    message = input("Enter your message: ")
    message = message.lower()
    to_say = prepare.search_in_intents(message.lower)

    if to_say == "unknown":
        to_say = intent.send_message(message)

    ttsx.say(to_say)
