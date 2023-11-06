# Below are the some common commands that are using frontend, backend & mysql for the  expense project
# Now with the help of these file name common.sh we can load all these command directly in frontend, backend & mysql

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
    exit 1  # we are asking to provide the status as 1 if there is any FAILURE, it 's up to us to set the return codes
  fi         # from 0-255
}