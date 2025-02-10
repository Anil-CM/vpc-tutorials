#!/bin/bash
yum install -y curl

#make a directory where the downloaded files can be saved
mkdir -p /agent_binaries

#download the binaries from artifactory
curl -o /agent_binaries/schematics-job-runner https://"${ARTIFACTORY_USER_NAME}":"${ARTIFACTORY_PASSWORD}"@na-public.artifactory.swg-devops.com/artifactory/wcp-schematics-dev-team-generic-local/vpe-agent-test/schematics-job-runner
curl -o /agent_binaries/schematics-sandbox https://"${ARTIFACTORY_USER_NAME}":"${ARTIFACTORY_PASSWORD}"@na-public.artifactory.swg-devops.com/artifactory/wcp-schematics-dev-team-generic-local/vpe-agent-test/schematics-sandbox
curl -o /agent_binaries/schematics-job https://"${ARTIFACTORY_USER_NAME}":"${ARTIFACTORY_PASSWORD}"@https://na-public.artifactory.swg-devops.com/artifactory/wcp-schematics-dev-team-generic-local/vpe-agent-test/schematics-job

#run the job12 binary wih configuration
cd /agent_binaries 
export JOB_HTTPADDR=""
export JOB_HTTPPORT="3002"
export JOB_EXITWAITTIMESECONDS="0"
export JOB_KEEPWORKFILES="false"
export JOB_LOGHEARTBEATRECEIVED="-1"
export JOB_SENDHEARTBEATS="true"
export JOB_ENABLE_HEARTBEATS="true"
export JOB_ENABLE_MQ_NOTIFY="true"
export JOB_SINGLEACTIONMODE="false"
export JOB_TESTCONFIRMSINGLEACTIONMODE="true"
export JOB_MAXIDLEMINUTES="200000"
export JOB_MAXRETRIES=1
export JOB_RETRYABLEERRORSTRINGS="TLS Handshake Error:$$$$$$$$:Error: Post https://iam.cloud.ibm.com/identity/token: remote error: tls: internal error,$$$$$$$$,TLS Handshake Stage Error:$$$$$$$$:Error: Post https://iam.test.cloud.ibm.com/identity/token: remote error: tls: internal error"
export SERVCOMPATMODE="true"
./schematics-job &
#run the sandbox binary with configuration 
sleep(10)
export CATALOGURL="https://cm.globalcatalog.cloud.ibm.com/api/v1-beta"
export IAMENDPOINT="https://iam.cloud.ibm.com"
export SANDBOX_ANSIBLEACTIONWHITELISTEXTN=".tf,.tfvars,.md,.yaml,.sh,.txt,.yml,.html,.gitignore,.tf.json,license,.js,.pub,.service,_rsa,.py,.json,.tpl,.cfg,.ps1,.j2,.zip,.conf,.crt,.key,.der,.cer,.pem,.bash,.tmpl"
export SANDBOX_ATLOGGERLEVEL="-1"
export SANDBOX_BLACKLISTEXTN=".php5,.pht,.phtml,.shtml,.asa,.asax,.swf,.xap,.tfstate,.tfstate.backup,.exe"
export SANDBOX_ENABLEENV="true"
export SANDBOX_ENABLEMTLS="false"
export SANDBOX_ENABLETLS="false"
export SANDBOX_EXECUTOR_TEMPLATE="custom,catalog"
export SANDBOX_EXTLOGGERLEVEL="-1"
export SANDBOX_EXTLOGPATH="/var/log/schematics/%s.log"
export SANDBOX_HTTPADDR="none"
export SANDBOX_HTTPPORT="3000"
export SANDBOX_IMAGEEXTN=".tif,.tiff,.gif,.png,.bmp,.jpg,.jpeg,.so"
export SANDBOX_LOGGERLEVEL="-1"
export SANDBOX_SHUTDOWNREPORTINTERVAL="600"
export SANDBOX_WHITELISTEXTN=".tf,.tfvars,.md,.yaml,.sh,.txt,.yml,.html,.gitignore,.tf.json,license,.js,.pub,.service,_rsa,.py,.json,.tpl,.cfg,.ps1,.j2,.zip,.conf,.crt,.key,.der,.jacl,.properties,.cer,.pem,.tmpl,.netrc"
./schematics-sandbox &
sleep(10)
#run the job runner binary with configuring tit to be passive mode
export JR_AGENTID="${AGENT_ID}"
export JR_AGENTLOCATION="us-south"
export JR_AGENTNAME="test-agent"
export JR_AGENTVERSION="1.3.0"
export JR_ALLOWMULTIPLEAGENTS="true"
export JR_ANSIBLEJOBSERVICENAME="localhost"
export JR_ANSIBLEJOBSERVICEPORT="3006"
export JR_APIKEY="${USER_APIKEY}"
export JR_ATLOGGERLEVEL="-1"
export JR_ATLOGPATH="/var/log/at/%s.log"
export JR_COMPATMODE="false"
export JR_DISABLEOTHERJOBS="false"
export JR_EXTLOGGERLEVEL="-1"
export JR_EXTLOGPATH="/var/log/schematics/%s.log"
export JR_FEATUREFLAGS="AgentRegistration:true,AgentKPI:true"
export JR_FETCHCARTDWNJOBPOLLINTERVAL="45"
export JR_FETCHJOBSPOLLINTERVAL="10"
export JR_FETCHJOBS_COUNT="1"
export JR_HTTPADDR="0.0.0.0"
export JR_HTTPPORT="2021"
export JR_IAMURL="https://private.iam.test.cloud.ibm.com"
export JR_JOB12SERVICENAME="localhost"
export JR_JOB12SERVICEPORT="3002"
export JR_KPISENDINTERVAL="1"
export JR_LOGGERLEVEL="-1"
export JR_MAXJOBS="3"
export JR_POLL_JOBS_RETRY_COUNT="5"
export JR_REGION="us-east"
export JR_SAVESERVICECOPY="true"
export JR_SBOXSERVICENAME="localhost"
export JR_SBOXSERVICEPORT="3000"
export JR_SCHEMATICSENDPOINT="https://us-south.schematics.test.cloud.ibm.com"
export JR_SINGLEACTIONMODE="false"
export JR_AGENTMODE="PASSIVE"
./schematics-job-runner &
sleep(10)




