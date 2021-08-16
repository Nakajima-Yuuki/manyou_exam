# このアプリについて
## データベース

### user
| カラム名 | データ型  |
|  ----   | ---- |
|  name |  string  |
|  email_address  |  string  |
|  password | string |

### task
| カラム名 | データ型 |
| ---- | ---- |
|name | string |
|description | text |
|priority | string |
|status | string |
|expiration_date | datetime |
|user_id | integer |
|task_label_id | integer |

### label
| カラム名 | データ型 |
| ---- |  ----  |
| task_id | integer |
| label_name | string |
