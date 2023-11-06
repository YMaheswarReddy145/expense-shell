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

echo -e "${color} Disable MYSQL default Version \e[0m"
dnf module disable mysql -y &>>$log_file
status_check

echo -e "${color} Copy MYSQL Repo File \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
status_check

echo -e "${color} Install MYSQL Server \e[0m"
dnf install mysql-community-server -y &>>$log_file
status_check

echo -e "${color} Start MYSQL Server \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
status_check

echo -e "${color} Set MYSQL Password \e[0m"
mysql_secure_installation --set-root-pass ${MYSQL_ROOT_PASSWORD} &>>$log_file
status_check