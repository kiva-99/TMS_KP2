from flask import Flask
import random

app = Flask(__name__)

quotes = [
    "DevOps is a culture",
    "Automation is key",
    "You build it, you run it"
]

@app.route("/")
def home():
    return {"quote": random.choice(quotes)}

@app.route("/health")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
