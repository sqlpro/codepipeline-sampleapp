#!/bin/bash
echo "> [`date`] CodeDeploy Build를 시작합니다: $(pwd) " >> /codedeploy.log

DEPLOY_PATH=/home/ec2-user/deploy
echo "> [`date`] build 경로: $DEPLOY_PATH" > $DEPLOY_PATH/deploy.log

BUILD_JAR=$(ls $DEPLOY_PATH/*.jar)
JAR_NAME=$(basename $BUILD_JAR)

echo "> [`date`] build 파일명: $JAR_NAME" >> $DEPLOY_PATH/deploy.log
echo "> [`date`] 현재 실행 중인 애플리케이션의 pid를 확인합니다" >> $DEPLOY_PATH/deploy.log

CURRENT_PID=$(pgrep -f $JAR_NAME)
if [ -z $CURRENT_PID ]
then
  echo "[`date`] 현재 구동 중인 애플리케이션이 없으므로 종료하지 않습니다." >> $DEPLOY_PATH/deploy.log
else
  echo "[`date`] > kill 15 $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

DEPLOY_JAR=$DEPLOY_PATH/$JAR_NAME
echo "> [`date`] DEPLOY_JAR 배포" >> $DEPLOY_PATH/deploy.log
nohup java -jar $DEPLOY_JAR >> $DEPLOY_PATH/deploy.log 2>$DEPLOY_PATH/deploy_err.log &

echo "> [`date`] CodeDeploy가 종료되었습니다: $(pwd) " >> /codedeploy.log