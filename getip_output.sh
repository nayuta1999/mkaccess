#!/bin/bash
DocumentRoot='??????'
teikei="#  [jp] \n#  sorce:https://ipv4.fetus.jp/jp.txt\n#  date: ${date}\n"

IPList="$(curl -s https://ipv4.fetus.jp/jp.txt | grep -v '#')"
IPList=($IPList)
date=$(date +%Y-%m-%d)


httpd_allow=$teikei
httpd_deny=$teikei
nginx_allow=$teikei
nginx_deny=$teikei
httpd24_allow=$teikei
httpd24_deny=$teikei
#1つしか表示されてないので直す
for ip in ${IPList[@]}
do
	httpd_allow=$httpd_allow"allow from ${ip} \n"
	httpd_deny=$httpd_deny"deny from ${ip} \n"
	nginx_allow=$nginx_allow"allow ${ip}; \n"
	nginx_deny=$nginx_deny"deny ${ip}; \n"
	httpd24_allow=$httpd24_allow"Require ip ${ip}\n"
	httpd24_deny=$httpd24_deny"Require not ip ${ip}\n"
done

echo -e $httpd_allow > $DocumentRoot/jp/httpd/allow
echo -e $httpd_deny > $DocumentRoot/jp/httpd/deny
echo -e $nginx_allow > $DocumentRoot/jp/nginx/allow
echo -e $nginx_deny > $DocumentRoot/jp/nginx/deny
echo -e $httpd24_allow > $DocumentRoot/jp/httpd24/allow
echo -e $httpd24_deny > $DocumentRoot/jp/httpd24/deny
