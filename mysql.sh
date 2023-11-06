log_file="/tmp/expense.log"
color="\e[33m"

# previously at each step we are providing the below condition to check the status but now with the help of functions
# we can declare the condition in the functions and we can call the function directly where ever we want to check the status.
status_check()
{
  if [ $? -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[31m FAILURE \e[0m"
  fi
}

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
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
status_check