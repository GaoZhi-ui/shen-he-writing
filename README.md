# 赛马娘OC同人 · 沈禾

写作工具链速查：

## 目录结构

```
E:/openhanako-work/
├── projects/shen-he-writing/
│   ├── SKILL.md                    ← 完整8阶段写作框架（必读）
│   ├── 沈禾_人物档案.md             ← 角色设定
│   └── 赛马娘_世界观参考.md         ← 写作用精简世界观
│
├── writing/uma-shenhe/
│   ├── chapters/                   ← 章节目录（写好的放这里）
│   ├── outline/                    ← 大纲文件
│   └── notes/                      ← 随笔/灵感
│
├── knowledge_base/
│   ├── 赛马娘世界观完全参考.md       ← 完整参考（136角色/26章）
│   └── 赛马娘同人创作指南.md         ← 创作技巧/避雷/模板
│
└── terra-writing-skill/
    └── pipeline-guard/guard.py     ← 外发前过滤脚本
```

## 写作流程

1. 读 SKILL.md 的阶段0（世界观框架）
2. 做阶段1（写前分析）—— 输出写作策略
3. 写章节，放 chapters/ 目录
4. 自检（SKILL.md 阶段4）
5. 跑 guard.py 过滤
6. 交付（MD→docx）

## 快速命令

```bash
# 跑过滤
python3 /e/openhanako-work/terra-writing-skill/pipeline-guard/guard.py <你的章节文件>

# 转docx（如果有现成脚本）
python3 /e/openhanako-work/tools/gen_html.py  # 需确认具体用法
```
