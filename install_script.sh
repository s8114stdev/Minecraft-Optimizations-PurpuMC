#!/bin/ash
# PurpurMC optimized Installation Script
#
# Server Files: /mnt/server
PROJECT=purpur

download_file() {
    local url=$1
    local dest=$2
    echo -e "Downloading $(basename ${dest})"
    curl -o ${dest} ${url}
}

download_additional_files() {
    local repo_url="https://raw.githubusercontent.com/HPiLO/optimised-mc/main/lib/pterodactyl/volumes/798c5afd-f9fc-45e7-a7fd-b8388f15710f"
    local files=("spigot.yml" "purpur.yml" "bukkit.yml" "config/paper-global.yml" "config/paper-world-defaults.yml" "eula.txt" "server.properties")
    
    mkdir -p config
    
    for file in "${files[@]}"; do
        local dest="/mnt/server/${file}"
        download_file "${repo_url}/${file}" "${dest}"
    done
}

if [ -n "${DL_PATH}" ]; then
    echo -e "Using supplied download url: ${DL_PATH}"
    DOWNLOAD_URL=$(eval echo $(echo ${DL_PATH} | sed -e 's/{{/${/g' -e 's/}}/}/g'))
else
    VER_EXISTS=$(curl -s https://api.purpurmc.org/v2/${PROJECT} | jq -r --arg VERSION ${MINECRAFT_VERSION} '.versions[] | contains($VERSION)' | grep true)
    LATEST_VERSION=$(curl -s https://api.purpurmc.org/v2/${PROJECT} | jq -r '.versions[-1]')
    
    if [ "${VER_EXISTS}" == "true" ]; then
        echo -e "Version is valid. Using version ${MINECRAFT_VERSION}"
    else
        echo -e "Using the latest ${PROJECT} version"
        MINECRAFT_VERSION=${LATEST_VERSION}
    fi
    
    BUILD_EXISTS=$(curl -s https://api.purpurmc.org/v2/${PROJECT}/${MINECRAFT_VERSION} | jq -r --arg BUILD ${BUILD_NUMBER} '.builds.all | tostring | contains($BUILD)' | grep true)
    LATEST_BUILD=$(curl -s https://api.purpurmc.org/v2/${PROJECT}/${MINECRAFT_VERSION} | jq -r '.builds.latest')
    
    if [ "${BUILD_EXISTS}" == "true" ]; then
        echo -e "Build is valid for version ${MINECRAFT_VERSION}. Using build ${BUILD_NUMBER}"
    else
        echo -e "Using the latest ${PROJECT} build for version ${MINECRAFT_VERSION}"
        BUILD_NUMBER=${LATEST_BUILD}
    fi
    
    JAR_NAME=${PROJECT}-${MINECRAFT_VERSION}-${BUILD_NUMBER}.jar
    
    echo "Version being downloaded"
    echo -e "MC Version: ${MINECRAFT_VERSION}"
    echo -e "Build: ${BUILD_NUMBER}"
    echo -e "JAR Name of Build: ${JAR_NAME}"
    DOWNLOAD_URL=https://api.purpurmc.org/v2/${PROJECT}/${MINECRAFT_VERSION}/${BUILD_NUMBER}/download
fi

cd /mnt/server

echo -e "Running curl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}"

if [ -f ${SERVER_JARFILE} ]; then
    mv ${SERVER_JARFILE} ${SERVER_JARFILE}.old
fi

curl -o ${SERVER_JARFILE} ${DOWNLOAD_URL}

if [ ! -f server.properties ]; then
    echo -e "Downloading MC server.properties"
    curl -o server.properties https://raw.githubusercontent.com/parkervcp/eggs/master/minecraft/java/server.properties
fi

# Download additional files from the GitHub repository
echo -e "Downloading additional files from GitHub repository"
download_additional_files
