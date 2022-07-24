#!/bin/bash

NVM_DIR=${NVM_DIR:-/usr/local/nvm}

mkdir --parents ${NVM_DIR}
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | NVM_DIR=${NVM_DIR} bash

tee -a /etc/profile.d/nvm.sh <<EOF
#!/bin/bash

NVM_DIR=${NVM_DIR}
PATH=${NVM_DIR}/versions/node/${NODEJS_VERSION}/bin:${PATH}
NODE_PATH=${NVM_DIR}/versions/node/${NODEJS_VERSION}/lib/node_modules

[ -s "${NVM_DIR}/nvm.sh" ] && . ${NVM_DIR}/nvm.sh
[ -s "${NVM_DIR}/bash_completion" ] && . ${NVM_DIR}/bash_completion
EOF

chmod +x /etc/profile.d/nvm.sh
. /etc/profile.d/nvm.sh

nvm install ${NODEJS_VERSION}
nvm alias default ${NODEJS_VERSION}
nvm use default
