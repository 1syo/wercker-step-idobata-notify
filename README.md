# Idobata notify step

[![wercker status](https://app.wercker.com/status/301f193d57cb0e2be9be567fd7e847a0/m/master "wercker status")](https://app.wercker.com/project/bykey/301f193d57cb0e2be9be567fd7e847a0)

The idobata-notify-step is a plugin that notifies idobata.  
The [idobata](https://idobata.io/) is nice group chat service for developer team.

## Options

* ``token``  (required) Your Idobata token
* ``on`` (optional) When should this step send a message. Possible values: always and failed.

## Configuration

### build
```
build:
  after-steps:
    - 1syo/idobata-notify@0.2.2:
        token: YOUR_IDOBATA_TOKEN
```

### deploy
```
deploy:
  after-steps:
    - 1syo/idobata-notify@0.2.2:
        token: YOUR_IDOBATA_TOKEN
```


## Notification Example

### build
![](https://raw.githubusercontent.com/wiki/1syo/wercker-step-idobata-notify/build.png)

### deploy
![](https://raw.githubusercontent.com/wiki/1syo/wercker-step-idobata-notify/deploy.png)

## License

The MIT License (MIT)
