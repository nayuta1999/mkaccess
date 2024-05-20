#!/bin/bash
DocumentRoot='??????'
date=$(date +%Y-%m-%d)
JPteikei="#  [jp] \n#  source:https://ipv4.fetus.jp/jp.txt\n#  date: ${date}\n"
CroudFrontteikei="#  [CroudFront] \n#  source:https://d7uri8nf7uskq.cloudfront.net/tools/list-cloudfront-ips\n#  date: ${date}\n"

JPIPList="$(curl -s https://ipv4.fetus.jp/jp.txt | grep -v '#')"
JPIPList=($IPList)


JPhttpd_allow=$teikei
JPhttpd_deny=$teikei
JPnginx_allow=$teikei
JPnginx_deny=$teikei
JPhttpd24_allow=$teikei
JPhttpd24_deny=$teikei
#1つしか表示されてないので直す
for ip in ${JPIPList[@]}
do
	JPhttpd_allow=$JPhttpd_allow"allow from ${ip} \n"
	JPhttpd_deny=$JPhttpd_deny"deny from ${ip} \n"
	JPnginx_allow=$JPnginx_allow"allow ${ip}; \n"
	JPnginx_deny=$JPnginx_deny"deny ${ip}; \n"
	JPhttpd24_allow=$JPhttpd24_allow"Require ip ${ip}\n"
	JPhttpd24_deny=$JPhttpd24_deny"Require not ip ${ip}\n"
done

#echo -e $JPhttpd_allow > $DocumentRoot/jp/httpd/allow
#echo -e $JPhttpd_deny > $DocumentRoot/jp/httpd/deny
#echo -e $JPnginx_allow > $DocumentRoot/jp/nginx/allow
#echo -e $JPnginx_deny > $DocumentRoot/jp/nginx/deny
#echo -e $JPhttpd24_allow > $DocumentRoot/jp/httpd24/allow
#echo -e $JPhttpd24_deny > $DocumentRoot/jp/httpd24/deny

CloudFrontIPList=$( curl -s https://d7uri8nf7uskq.cloudfront.net/tools/list-cloudfront-ips | jq '.CLOUDFRONT_REGIONAL_EDGE_IP_LIST[]')
CloudFrontIPList=($CloutFrontIPList)
CFhttpd_allow=$CroudFrontteikei
CFhttpd_deny=$CrountFrontteikei
CFnginx_allow=$CroudFrontteikei
CFnginx_deny=$CroudFrontteikei
CFhttpd24_allow=$CroudFrontteikei
CFhttpd24_deny=$CroudFrontteikei


for ip in ${CloudFrontIPList[@]}
do
	CFhttpd_allow=$CFhttpd_allow"allow from ${ip} \n"
	CFhttpd_deny=$CFhttpd_deny"deny from ${ip} \n"
	CFnginx_allow=$CFnginx_allow"allow ${ip}; \n"
	CFnginx_deny=$CFnginx_deny"deny ${ip}; \n"
	CFhttpd24_allow=$CFhttpd24_allow"Require ip ${ip}\n"
	CFhttpd24_deny=$CFhttpd24_deny"Require not ip ${ip}\n"
done

echo -e $CFhttpd_allow > $DocumentRoot/cf/httpd/allow
echo -e $CFhttpd_deny > $DocumentRoot/cf/httpd/deny
echo -e $CFnginx_allow > $DocumentRoot/cf/nginx/allow
echo -e $CFnginx_deny > $DocumentRoot/cf/nginx/deny
echo -e $CFhttpd24_allow > $DocumentRoot/cf/httpd24/allow
echo -e $CFhttpd24_deny > $DocumentRoot/cf/httpd24/deny
