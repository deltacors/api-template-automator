# API-led template automator

### Automate the process of preparing standard API-LED-TEMPLATE for a specific API

### Prerequisites
- Anypoint Plaftorm account
- Valid template in Exchange
- Anypoint Studio

### Create Alias
To use this script globally edit your .bash_profile
``` 
alias api='/path/to/script/script.sh'
```
Refresh .bash_profile to make the changes take effect
``` 
source ~/.bash_profile
```

### Praparation
Import you template with Anypoint Studio 
``` 
New > Project From Template
```

The template is downloaded into the default workspace directory.
My Mule 4 workspace directory is in
``` 
~/AnypointStudio/studio-workspace
```

I store all my Mulesoft projects in
``` 
~/AnypointStudio/repository
```
### Execution
Once you have set up your alias, the directory to store you Mulesoft projects and a fresh template in your workspace:
``` 
api EXAMPLE_S-API
```

### Process under the hood
- Replace all the "API-LED-TEMPLATE" string placeholder
- Rename default API-LED-TEMPLATE property files
- Prepare pom.xml version for deployment
- Initialize .gitignore to exclude /target/ files and folder

### Naming convention
I use both naming and structure conventions such as:
- Uppercase API names
- Name composed by NAME_TYPE-API for standard APIs (Type can be S, P or E)
- Name composed by SYSTEM1-SYSTEM2-INT for integrations batch
- The API folder has 2 levels, one for the project itself, one for the git repository
