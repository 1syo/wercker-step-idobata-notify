# Idobata notify step

The idobata-notify-step is a plugin that notifies idobata.  
The [idobata](https://idobata.io/) is nice group chat service for developer team.

## Options

* ``token``  (required) Your Idobata token
* ``on`` (optional) When should this step send a message. Possible values: always and failed.

## Example

```
deploy:
  after-steps:
    - 1syo/idobata-notify@0.1.0:
        token: YOUR_IDOBATA_TOKEN
```

## License

The MIT License (MIT)
