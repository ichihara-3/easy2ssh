# easy2ssh
easy setup the ssh config for ec2 instances.

## usage
Before using this tool, you should set up an instances.

* you may create ec2 instance with your aws console.
* set tag to your instance: key=Name, value=`a unique name in your instances`.

```bash
$ bash easy2s.sh [INSTANCE_NAME]
```

## TODO
* to enable to use instaance-id,
* to add only writing mode 
