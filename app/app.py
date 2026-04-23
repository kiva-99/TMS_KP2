from flask import Flask, jsonify
import random

app = Flask(__name__)

QUOTES = [
    "DevOps is a journey, not a destination.",
    "Automate everything you can.",
    "Infrastructure as code changes everything.",
    "Small frequent changes beat big risky releases."
]

@app.route("/")
def index():
    return jsonify({
        "quote": random.choice(QUOTES)
    })

@app.route("/health")
def health():
    return jsonify({
        "status": "ok"
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)