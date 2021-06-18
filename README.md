# Flutter SMS GATEWAY

Flutter sms gateway is an android app to send sms. It supports sending delivery reports

## Installation

Clone the app and run locally to get started.

```bash
pip install foobar
```

## Usage

to use the app simply supply the url for your messages source and the call back url to send messages statuses.
Make sure your api returns the json array as shown below

```python
[
 {
    "id": "b0cb1a67-51a5-46d0-9718-6e4c73a66666",
    "phone": "255XXXXXXX",
    "message":"",
    "status": "queued"
  }
]
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
