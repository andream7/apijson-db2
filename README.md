# apijson-db2

本仓库将db2数据库集成到apijson中。

## 2021.7.30待解决问题列表

1. 由于Method、Random、Request、Response表结构所占用的空间超出限制大小，无法创建上述几张数据表。
2. 某些接口报语法错误： 测试入口：http://apijson.cn/api/
  - DB2 SQL Error: SQLCODE=-104, SQLSTATE=42601, SQLERRMC=EXPLAIN SELECT *;BEGIN-OF-STATEMENT;<delete>, DRIVER=4.28.11
