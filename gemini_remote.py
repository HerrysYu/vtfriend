import pathlib
import textwrap
import asyncio
import google.generativeai as genai
import websockets
from IPython.display import display
from IPython.display import Markdown


def to_markdown(text):
  text = text.replace('•', '  *')
  return Markdown(textwrap.indent(text, '> ', predicate=lambda _: True))
# Or use `os.getenv('GOOGLE_API_KEY')` to fetch an environment variable.

genai.configure(api_key="AIzaSyB-WutYGaxqIdmqk4usyzB3EZdGcyGw5ok")

model = genai.GenerativeModel('gemini-1.5-flash-latest')


async def echo(websocket):
  chat=model.start_chat(history=[]);
  async for message in websocket:
    await websocket.send("received")
    response = chat.send_message(message)
    await websocket.send(response.text)
async def main():
  async with websockets.serve(echo, "192.168.1.11", 1211):
    await asyncio.Future()  # run forever


asyncio.run(main())