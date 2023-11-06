source common.sh  #this common.sh file contain the common commands that are using in frontend,backend, mysql
                  # so now we can directly import or source these commands using the file name directly without declaring
                  # the common command multiple times

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