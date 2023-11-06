source common.sh  #this common.sh file contain the common commands that are using in frontend,backend, mysql
                  # so now we can directly import or source these commands using the file name directly without declaring
                  # the common command multiple times

if [ -z "$1" ];then                # here we are validating either input password is empty or not by -z(it means empty)
   echo Password input is missing   # if its empty then it print message we have provided and exit the process.
   exit
fi

MYSQL_ROOT_PASSWORD=$1  # with the help of this now we don't need to hard code the password in the file now we can
                        # directly provide the password in the script after the file name.
                           # sudo bash backend.sh Expenasepp@1

echo -e "${color} Disable NodeJS default Version \e[0m"
dnf module disable nodejs -y &>>$log_file
status_check

echo -e "${color} Enable NodeJS 18 Version \e[0m"
dnf module enable nodejs:18 -y &>>$log_file
status_check

echo -e "${color} Install NodeJS \e[0m"
dnf install nodejs -y &>>$log_file
status_check

echo -e "${color} Copy Backend Service File \e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
status_check

id expense &>>$log_file
if [ $? -ne 0 ]; then   # we are adding this to evaluate if the user expense  is present or not.
  echo -e "${color} Add Application User \e[0m"
  useradd expense &>>$log_file
  status_check
fi

# sudo mkdir -p /app to avoid the problem in the first place here -p is an option its ignore if there is an directory
   # if there are no directory it will give 0  by giving echo $? after the above command.

if [ ! -d /app ]; then  # here -d represent that the directory /app is exist
  echo -e "${color} Create Application directory \e[0m"
  mkdir /app &>>$log_file
  status_check
fi

echo -e "${color} Delete old  Application Content \e[0m"
rm -rf /app/* &>>$log_file
status_check

echo -e "${color} Download Application Content \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
status_check

echo -e "${color} Extract Application Content \e[0m"
cd /app &>>$log_file
unzip /tmp/backend.zip &>>$log_file
status_check

echo -e "${color} Download NodeJS Dependencies \e[0m"
npm install &>>$log_file
status_check

echo -e "${color} Install MYSQL client to load the Schema \e[0m"
dnf install mysql -y &>>$log_file
status_check

echo -e "${color} Load Schema \e[0m"
mysql -h mysql-dev.maheswary.online -uroot -p${MYSQL_ROOT_PASSWORD} < /app/schema/backend.sql &>>$log_file
status_check

echo -e "${color} Start Backend Services \e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
status_check