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


echo -e "${color} Installing nginx \e[0m"
dnf install nginx -y &>>$log_file
status_check

echo -e "${color} Copying Expense Configuration \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
status_check

echo -e "${color} Removing the old nginx content \e[0m"
rm -rf /usr/share/nginx/html/* &>>$log_file
status_check

echo -e "${color} Download Frontend Application Code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
status_check

echo -e "${color} Extract Download Application Content \e[0m"
cd /usr/share/nginx/html &>>$log_file
unzip /tmp/frontend.zip &>>$log_file
status_check

echo -e "${color} Starting nginx services \e[0m"
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file
status_check