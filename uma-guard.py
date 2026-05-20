#!/usr/bin/env python3
"""赛马娘版外发扫描——只禁止泰拉词汇，放行所有日本现实地名"""
import re, sys

FORBIDDEN = [
    "泰拉", "罗德岛", "源石", "天灾", "感染者", "矿石病",
    "前文明", "巴别塔", "萨卡兹", "维多利亚", "乌萨斯",
    "龙门", "切尔诺伯格", "整合运动",
]

def scan_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    hits = []
    for term in FORBIDDEN:
        pattern = re.compile(re.escape(term))
        for m in pattern.finditer(content):
            line_num = content[:m.start()].count('\n') + 1
            hits.append((line_num, term))

    if hits:
        print(f"[GUARD] 发现 {len(hits)} 个禁用词：")
        for line, term in hits:
            print(f"  第{line}行: {term}")
        sys.exit(1)
    else:
        print("[GUARD] 扫描通过")
        sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python3 uma-guard.py <文件路径>")
        sys.exit(1)
    scan_file(sys.argv[1])
