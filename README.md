# Flutter SMS GATEWAY

Flutter sms gateway is an android app to send sms. It supports sending delivery reports

## Installation

Clone the app and run locally to get started.

```bash
https://github.com/codeblock-dev/sms_gateway.git
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

to upload incoming message to your remote server make provide a post end point which will accept the following http body

```python
 {
    "phone": "255XXXXXXX",
    "message":"incoming message goes here",
  }
```

## Permissions

The app requires the following permissions

```python
INTERNET
SEND_SMS
RECEIVE_SMS
```

## Additions and Optimization

Current the gateway only runs in foreground. We are looking to add background capabitlities in future. For further additions and contributions please have a look on how to contribute

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
