下文默认已在Windows环境下安装好db2。

打开命令行操作db2：

1. 进入db2环境

   ```
   db2cmd
   ```

2. 查看db2版本

   ```
   db2licm -l
   ```

3. 列出所有数据库

   ```
   db2 list db directory
   ```

4. 创建数据库

   ```
   db2 create db databaseName [using codeset utf-8 territory CN]
   
   // 建议的语句
   db2 create db databaseName APIJSON
   ```

5. 连接数据库

   ```
   db2 connect to `dbName` user `db2inst1`(userName) using `db2root-pwd`(password)
   ```
6. 查看当前database的表空间

   ```
   db2 => select TBSPACE, OWNER, PAGESIZE from syscat.tablespaces

   TBSPACE                        OWNER                          PAGESIZE   
   ------------------------------ ------------------------------ -----------
   SYSCATSPACE                    SYSIBM                                4096
   TEMPSPACE1                     SYSIBM                                4096
   USERSPACE1                     SYSIBM                                4096
   SYSTOOLSPACE                   DB2INST1                              4096
   SYSTOOLSTMPSPACE               DB2INST1                              4096
   ```

 从这里可以看到，所有的表空间都是系统默认创建的，并且使用的pagesize也是默认的4K

7. 创建bufferpool

   ```
   #创建pagesize为32K的bufferpool
   db2 => create BUFFERPOOL bigbuffer SIZE 5000 PAGESIZE 32K
   DB20000I  The SQL command completed successfully.

   #创建pagesize为32K的tablespace，同时使用新创建的bufferpool
   db2 => CREATE TABLESPACE bigtablespace PAGESIZE 32K BUFFERPOOL bigbuffer
   DB20000I  The SQL command completed successfully.
   ```

   现在再来看一下表空间的情况：
   

   ```
   db2 => select TBSPACE, OWNER, PAGESIZE from syscat.tablespaces

   TBSPACE                       OWNER                          PAGESIZE   
   -------------------    ------ --------------           ----- -----------
   SYSCATSPACE                   SYSIBM                                4096
   TEMPSPACE1                    SYSIBM                                4096
   USERSPACE1                    SYSIBM                                4096
   SYSTOOLSPACE                  DB2INST1                              4096
   SYSTOOLSTMPSPACE              DB2INST1                              4096
   BIGTABLESPACE                 DB2INST1                             32768
   ```

8. 创建数据库中的表，sql语句在script文件夹下

   
