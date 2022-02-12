from google.cloud import dialogflow


class Intent:
    def __init__(self):
        self.configure()

        self.session_client = dialogflow.SessionsClient()
        self.session = self.session_client.session_path(self.project_id, self.session_id)

    
    def configure(self):
        self.project_id = "medusaproject-341113"
        self.session_id = "123456789"
        self.language_code = "en"
    
    
    def send_message(self, message):
        text_input = dialogflow.TextInput(text=message, language_code=self.language_code)
        query_input = dialogflow.QueryInput(text=text_input)

        response = self.session_client.detect_intent(
            request={"session": self.session, "query_input": query_input}
        )
        # print("Fulfillment text: {}\n".format(response.query_result.fulfillment_text))
        return str(response.query_result.fulfillment_text)

