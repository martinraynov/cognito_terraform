# cognito_terraform
Simple terraform scripts for the creation of AWS Cognito objects 

You can use the ```make``` command to see available options

## Init the project 

### Check if the ref folder is symlinked

You must check if the symlinks are created and available. If not you can use the ```SYMLINKS_FOLDER={FOLDER WHERE THE SYMLINKS WILL BE CREATED} make createsymlinks```

This will create the symlinks needed for the terraform to work

### Init the project

You must init the project by executing ```terraform init``` inside the folder you want to run, or use the ```COGNITO_PROJECT={FOLDER TO INIT} make init```

### Plan the project
You can check if the project config is valid by executing ```terraform plan``` inside the folder you want to run, or use the ```COGNITO_PROJECT={FOLDER TO INIT} make plan```

### Deploy the project
To deploy the project you can execute ```terraform apply``` inside the folder you want to run, or use the ```COGNITO_PROJECT={FOLDER TO INIT} make apply```

### Destroy the project
To destroy the project you can execute ```terraform destroy``` inside the folder you want to run, or use the ```COGNITO_PROJECT={FOLDER TO INIT} make destroy```


