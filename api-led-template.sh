#!/bin/bash

if [ $# -ne 1 ]
then

    echo
    echo "*******************************************************************************"
    echo
    echo "Automate the process of preparing standard API-LED-TEMPLATE for a specific API:"
    echo "Example: script.sh EXAMPLE_S-API"
    echo
    echo "The shell argument naming convention MUST be:NAME_TYPE-API or API1-API2_INT"
    echo "NAME_TYPE-API for common API"
    echo "SYSTEM1-SYSTEM2_INT for integrations batch"
    echo
    echo "The default folders are:"
    echo "HOME/AnypointStudio/studio-workspace"
    echo "HOME/AnypointStudio/repository"
    echo "You can customize them to fit your needs."
    echo
    echo "*******************************************************************************"
    echo

else 

    # Default template
    TEMPLATE_NAME="API-LED-TEMPLATE"
    LOWERCASE_TEMPLATE_NAME=$(echo $TEMPLATE_NAME | tr "[A-Z]" "[a-z]" | tr "_" "-")
    SPACE_DELIMITED_TEMPLATE_NAME=$(echo ${TEMPLATE_NAME//-/ })

    # API supplied
    API_NAME=$(echo $1 | tr "[a-z]" "[A-Z]")
    LOWERCASE_API_NAME=$(echo $API_NAME | tr "[A-Z]" "[a-z]" | tr "_" "-")
    SPACE_DELIMITED_API_NAME=$(echo ${API_NAME//_/ })

    # Workspace default path
    DEFAULT_WORKSPACE_PATH="${HOME}/AnypointStudio/studio-workspace"
    
    # Repository default path
    DEFAULT_REPO_PATH="${HOME}/AnypointStudio/repository"

    echo
    echo "[*] $API_NAME creation process" 
    echo 

    echo "[+] Creating API folder inside default repo folder"
    mkdir $DEFAULT_REPO_PATH/$API_NAME

    echo "[+] Copying API-LED-TEMPLATE into API folder"
    REPO_FOLDER=$DEFAULT_REPO_PATH/$API_NAME
    cp -R $DEFAULT_WORKSPACE_PATH/${TEMPLATE_NAME} $REPO_FOLDER

    echo "[+] Renaming first level API folder"
    mv $REPO_FOLDER/$TEMPLATE_NAME $REPO_FOLDER/$API_NAME 

    echo "[+] Creating and preparing .gitignore file"
    touch $REPO_FOLDER/.gitignore
    echo ".DS_Store" >> $REPO_FOLDER/.gitignore
    echo "$API_NAME/target/" >> $REPO_FOLDER/.gitignore

    echo "[+] Replacing default strings with provided API name following the naming conventions"
    find $REPO_FOLDER/$API_NAME -type f -name pom.xml -exec sed -i '' '1,/<version>[0-9].[0-9].[0-9]<\/version>/s/<version>[0-9].[0-9].[0-9]<\/version>/<version>1.0.0-SNAPSHOT<\/version>/' {} + ;
    find $REPO_FOLDER/$API_NAME -type f -name .project -exec sed -i '' s/$TEMPLATE_NAME/$API_NAME/g {} + ;
    find $REPO_FOLDER/$API_NAME -type f -name *.xml -exec sed -i '' s/$TEMPLATE_NAME/$API_NAME/g {} + ;
    find $REPO_FOLDER/$API_NAME -type f -name '*.yaml' -exec sed -i '' s/"$SPACE_DELIMITED_TEMPLATE_NAME"/"$SPACE_DELIMITED_API_NAME"/g {} + ;
    find $REPO_FOLDER/$API_NAME -type f -name '*.yaml' -exec sed -i '' s/"$LOWERCASE_TEMPLATE_NAME"/"$LOWERCASE_API_NAME"/g {} + ;

    cd $REPO_FOLDER/$API_NAME/src/main/resources/

    echo "[+] Renaming YAML properties files"
    for f in *.yaml; 
    do
        EXT=${f#*.}
        mv $f $API_NAME.$EXT
    done

    echo
    echo "All done! You are ready to develop your new $API_NAME."
    echo
fi
