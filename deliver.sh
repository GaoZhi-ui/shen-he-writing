#!/bin/bash
# 交付脚本：自检 → guard扫描 → MD转DOCX → 发邮件
# 用法: bash deliver.sh <章节前缀> <标题>
# 示例: bash deliver.sh 第一章 带广的田野

PREFIX=$1
TITLE=$2
BASE="E:/openhanako-work/writing/uma-shenhe"
MD_FILE="${BASE}/chapters/${PREFIX}_${TITLE}.md"
DOCX_FILE="${BASE}/chapters/docx/${PREFIX}_${TITLE}.docx"
GUARD="${BASE}/uma-guard.py"

if [ ! -f "$MD_FILE" ]; then
    echo "找不到: $MD_FILE"
    exit 1
fi

# 字数检查
CN=$(python -X utf8 -c "
import re
with open('$MD_FILE','r',encoding='utf-8') as f:
    print(len(re.findall(r'[\u4e00-\u9fff]',f.read())))
")
if [ "$CN" -lt 3000 ]; then
    echo "字数 ${CN}/3000 不足"
    read -p "继续? (y/n) " ans
    [ "$ans" != "y" ] && exit 1
fi
echo "字数: ${CN}汉字"

# guard扫描
if [ -f "$GUARD" ]; then
    python -X utf8 "$GUARD" "$MD_FILE" || exit 1
fi

# 转docx
pandoc "$MD_FILE" -o "$DOCX_FILE" --from markdown --to docx
echo "DOCX: $DOCX_FILE"

# 发邮件
python -X utf8 << PYEOF
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.base import MIMEBase
from email.mime.text import MIMEText
from email import encoders
from email.header import Header

msg = MIMEMultipart()
msg['From'] = '552091485@qq.com'
msg['To'] = '552091485@qq.com'
msg['Subject'] = Header('沈禾 - ${PREFIX} · ${TITLE}', 'utf-8')

body = MIMEText('${PREFIX} · ${TITLE}\n汉字数：${CN}', 'plain', 'utf-8')
msg.attach(body)

with open('$DOCX_FILE', 'rb') as f:
    att = MIMEBase('application', 'octet-stream')
    att.set_payload(f.read())
    encoders.encode_base64(att)
    att.add_header('Content-Disposition', 'attachment', filename=('utf-8', '', '${PREFIX}_${TITLE}.docx'))
    msg.attach(att)

with smtplib.SMTP_SSL('smtp.qq.com', 465) as s:
    s.login('552091485@qq.com', 'slrhgmfjwhlubegj')
    s.send_message(msg)
print('邮件已发送')
PYEOF
