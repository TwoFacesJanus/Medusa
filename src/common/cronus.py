from datetime import datetime

class Crono:
    @staticmethod
    def chronius():
        current_time = datetime.now()
        current_hour = int(current_time.hour)
        current_mins = str(current_time.minute)

        message = None

        if 5 <= current_hour <= 12:
            message = "Good Morning"
        
        elif 12 <= current_hour <= 16:
            message = "Good Day"

        elif 16 <= current_hour <= 20:
            message = "Good Evening"

        elif 20 <= current_hour <= 2:
            message = "Good Night"

        else:
            message = "Can't you sleep?"

        return str(current_hour) + ":" + current_mins + ". " + message
