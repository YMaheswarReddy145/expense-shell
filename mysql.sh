log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disable MYSQL default Version \e[0m"
dnf module disable mysql -y &>>$log_file
echo $?

echo -e "${color} Copy MYSQL Repo File \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo -e "${color} Install MYSQL Server \e[0m"
dnf install mysql-community-server -y &>>$log_file
echo $?

echo -e "${color} Start MYSQL Server \e[0m"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
echo $?

echo -e "${color} Set MYSQL Password \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file
echo $?