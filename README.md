# Idobata notification step

## Options

* ``token``  (required) Your Idobata token
* ``passed-message``  (optional) The message which will be shown on a passed build or deploy
* ``failed-message``  (optional) The message which will be shown on a failed build or deploy
* ``on`` (optional) When should this step send a message. Possible values: always and failed.

## Example

```
deploy:
  after-steps:
    - 1syo/idobata-notify@0.0.1:
        token: YOUR_IDOBATA_TOKEN
```

## License

The MIT License (MIT)
