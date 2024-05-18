#!/bin/bash
DocumentRoot='??????'
teikei="#  [jp] \n#  sorce:https://ipv4.fetus.jp/jp.txt\n#  date: ${date}\n"

IPList="$(curl -s https://ipv4.fetus.jp/jp.txt | grep -v '#')"
IPList=($IPList)
date=$(date +%Y-%m-%d)


httpd_allow=teikei
httpd_deny=teikei
nginx_allow=teikei
nginx_deny=teikei
#1つしか表示されてないので直す
for ip in ${IPList[@]}
do
	httpd_allow=$httpd_allow"allow from ${ip} \n"
	httpd_deny=$httpd_deny"deny from ${ip} \n"
	nginx_allow=$nginx_allow"allow ${ip}; \n"
	nginx_deny=$nginx_deny"deny ${ip}; \n"
done

echo -e $httpd_allow > $DocumentRoot/jp/httpd/allow.txt
echo -e $httpd_deny > $DocumentRoot/jp/httpd/deny.txt
echo -e $nginx_allow > $DocumentRoot/jp/nginx/allow.txt
echo -e $nginx_deny > $DocumentRoot/jp/nginx/deny.txt

