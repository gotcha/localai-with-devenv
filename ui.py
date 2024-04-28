from openai import AsyncOpenAI
import chainlit as cl

client =  AsyncOpenAI(base_url="http://127.0.0.1:8080/v1", api_key="fake-key")
cl.instrument_openai()

@cl.on_message
async def pn_message(message: cl.Message):
    response = await client.chat.completions.create(
            messages=[
                {
                    "content": "You are a helpful bot, you reply include emojis",
                    "role": "system",
                },
                {
                    "content": message.content,
                    "role": "user",
                }
            ],
            model="llama3-8b",
            temperature=0,
            max_tokens=1000
    )
    await cl.Message(content=response.choices[0].message.content).send()
