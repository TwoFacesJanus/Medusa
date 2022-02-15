from datetime import datetime

class Crono:
    @staticmethod
    def chronius():
        current_time = datetime.now()
        current_hour = int(current_time.hour)
        if 5 <= current_hour <= 12:
            return "Good Morning"
        
        elif 12 <= current_hour <= 16:
            return "Good Day"

        elif 16 <= current_hour <= 20:
            return "Good Evening"

        elif 20 <= current_hour <= 2:
            return "Good Night"

        else:
            return "Can't you sleep?"
