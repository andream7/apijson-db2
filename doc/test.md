

参考资料：[APIJSON/Document.md at master · Tencent/APIJSON · GitHub](https://github.com/Tencent/APIJSON/blob/master/Document.md)

测试平台：[APIAuto-机器学习测试、自动生成代码、自动静态检查、自动生成文档与注释等，做最先进的 HTTP 接口管理平台。 (apijson.cn)](http://apijson.cn/api/)

## 查询数组

```
{
    "User[]": {
        "count": 3,
        "User": {}
    }
}
```

结果：通过。

## 匹配选项范围

```
{
    "User[]": {
        "count": 3,
        "User": {
            "id{}": [
                38710,
                82001,
                70793
            ]
        }
    }
}
```

结果：通过。

## 匹配条件范围

```
{
    "User[]": {
        "count": 3,
        "User": {
            "id{}": "<=80000,>90000"
        }
    }
}
 
```

结果：通过。

## 包含选项范围

```
{
    "User[]": {
        "count": 3,
        "User": {
            "contactIdList<>": 38710
        }
    }
}
```

结果：测试未通过；

不正确的sql：

```
SELECT * FROM "DB2ADMIN"."apijson_user" WHERE  (  ("contactIdList" is  NOT  null  AND (json_contains("contactIdList", '38710')))  )  ORDER BY "id" LIMIT 3
```

## 判断是否存在

```
{
    "User": {
        "id}{@": {
            "from": "Comment",
            "Comment": {
                "momentId": 15
            }
        }
    }
}
```

结果：通过。

## 远程调用函数

```
{
    "Moment": {
        "id": 301,
        "isPraised()": "isContain(praiseUserIdList,userId)"
    }
}
```



测试：未通过：

报错信息：`不允许调用远程函数 isContain !`

## 存储过程

```
{
    "User": {
        "@limit": 10,
        "@offset": 0,
        "@procedure()": "getCommentByUserId(id,@limit,@offset)"
    }
}
```

结果：未通过；

报错信息：`"[jcc][10111][10815][4.28.11] 不能对预编译语句实例调用 java.sql.PreparedStatement.execute (String sql) 方法。 使用 java.sql.PreparedStatement.execute () 时不附带 SQL 字符串自变量。 ERRORCODE=-4476, SQLSTATE=null"`

## 引用赋值

```
{
    "Moment": {
        "userId": 38710
    },
    "User": {
        "id@": "%2FMoment%2FuserId"
    }
}
```

结果：通过

## 子查询

```
{
    "User": {
        "id@": {
            "from": "Comment",
            "Comment": {
                "@column": "min(userId)"
            }
        }
    }
}
```



结果：通过

## 模糊搜索

```
{
    "User[]": {
        "count": 3,
        "User": {
            "name$": "%ap%"
        }
    }
}
```

结果：通过

## 正则匹配

```
{
    "User[]": {
        "count": 3,
        "User": {
            "name~": "^[0-9]%2B$"
        }
    }
}
```

结果：测试未通过

错误的sql语句：

```
SELECT * FROM "DB2ADMIN"."apijson_user" WHERE  (  ("name" REGEXP BINARY '^[0-9]%2B$')  )  ORDER BY "id" LIMIT 3
```

## 连续范围

```
{
    "User[]": {
        "count": 3,
        "User": {
            "date%": "2017-10-01,2018-10-01"
        }
    }
}
```

结果：通过

## 新建别名

```
{
    "Comment": {
        "@column": "id,toId:parentId",
        "id": 51
    }
}
```

结果：通过

## 比较运算

```
{
    "[]": {
        "User": {
            "id<=": 90000
        }
    }
}
// 用例2
{
    "User": {
        "id>@": {
            "from": "Comment",
            "Comment": {
                "@column": "min(userId)"
            }
        }
    }
}
```

结果：通过

## 逻辑运算

```
{
    "User": {
        "id&{}": ">80000,<=90000"
    }
}

// 样例2
{
    "User": {
        "id|{}": ">90000,<=80000"
    }
}
// 样例
{
    "User": {
        "id!{}": [
            82001,
            38710
        ]
    }
}
```

结果：通过

## 数组关键词，可自定义

### 查询User数组，最多5个

```
{
    "[]": {
        "count": 5,
        "User": {}
    }
}
```

结果：通过

### 查询第3页的User数组，每页5个

```
{
    "[]": {
        "count": 5,
        "page": 3,
        "User": {}
    }
}
```

结果：通过

### 查询User数组和对应的User总数

```
{
    "[]": {
        "query": 2,
        "count": 5,
        "User": {}
    },
    "total@": "%2F[]%2Ftotal",
    "info@": "%2F[]%2Finfo"
}
    
```

结果：通过

### Moment INNER JOIN User LEFT JOIN Comment

```
{
    "[]": {
        "count": 5,
        "join": "&/User/id@,</Comment/momentId@",
        "Moment": {
            "@column": "id,userId,content",
            "@group": "id"
        },
        "User": {
            "name~": "t",
            "id@": "/Moment/userId",
            "@column": "id,name,head"
        },
        "Comment": {
            "momentId@": "/Moment/Fid",
            "@column": "id,momentId,content"
        }
    }
}
```

结果：未通过

错误的sql

```
SELECT "Moment"."id","Moment"."userId","Moment"."content", "User"."id","User"."name","User"."head", "Comment"."id","Comment"."momentId","Comment"."content" FROM "DB2ADMIN"."Moment" AS "Moment"  
   INNER JOIN "DB2ADMIN"."apijson_user" AS "User" ON "User"."id" = "Moment"."userId"  
   LEFT JOIN ( SELECT "id","momentId","content" FROM "DB2ADMIN"."Comment" ) AS "Comment" ON "Comment"."momentId" = "Moment"."Fid" WHERE  (  (  (  ("User"."name" REGEXP BINARY 't')  )  )  )  GROUP BY "Moment"."id" ORDER BY "Moment"."id" LIMIT 5
```

### 每一层都加当前用户名

```
{
    "User": {},
    "[]": {
        "name@": "User/name",
        "Moment": {}
    }
}
```

结果：通过

## 对象关键词，可自定义

（待完善）
