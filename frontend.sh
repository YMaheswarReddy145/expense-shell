echo -e "\e[36m Installing nginx \e[0m"
dnf install nginx -y

echo -e "\e[36m Copying Expense Configuration \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[36m Removing the old nginx content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m Download Frontend Application Code \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m Extract Download Application Content \e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[36m Starting nginx services \e[0m"
systemctl enable nginx
systemctl restart nginx