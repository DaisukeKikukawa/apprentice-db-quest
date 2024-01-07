# インターネットTV データベース構築ドキュメント
## ステップ1: データベースの構築
まずはターミナルを立ち上げMySQLにアクセスします。(macの場合を想定しています。)

 まずMySQLの起動をします。

```sql
$ mysql.server start
```

 その後MySQLにログイン（実行、接続とも）します。

```sql
$ mysql -u root -p
```

次にデータベースの作成を行います。

```sql
mysql> CREATE DATABASE internet_tv_service;
```

先ほど作成したデータベースに接続します。

```sql
mysql> USE internet_tv_service;
```

## ステップ2: テーブルの構築

以下のSQLコマンドを使用し各テーブルを作成します。
### Channels テーブルの作成

```sql
CREATE TABLE Channels (channel_id BIGINT AUTO_INCREMENTPRIMARY KEY,channel_name VARCHAR(100));
```

### Genres テーブルの作成
```sql
CREATE TABLE Genres (genre_id BIGINT AUTO_INCREMENT PRIMARY KEY,genre_name VARCHAR(100));
```

### Programs テーブルの作成
```sql
CREATE TABLE Programs (program_id BIGINT AUTO_INCREMENT PRIMARY KEY,title VARCHAR(100),details TEXT,genre_id BIGINT,FOREIGN KEY (genre_id) REFERENCES Genres(genre_id));
```

### ProgramGenres テーブルの作成
```sql
CREATE TABLE ProgramGenres (program_id BIGINT,genre_id BIGINT,FOREIGN KEY (program_id) REFERENCES Programs(program_id),FOREIGN KEY (genre_id) REFERENCES Genres(genre_id));
```

### Seasons テーブルの作成
```sql
CREATE TABLE Seasons (season_id BIGINT AUTO_INCREMENT PRIMARY KEY,program_id BIGINT,season_number INT,FOREIGN KEY (program_id) REFERENCES Programs(program_id));
```

### Episodes テーブルの作成
```sql
CREATE TABLE Episodes (episode_id BIGINT AUTO_INCREMENT PRIMARY KEY,season_id BIGINT,episode_number INT,title VARCHAR(100),details TEXT,duration INT,release_date DATE,FOREIGN KEY (season_id) REFERENCES Seasons(season_id));
```

### ProgramSlots テーブルの作成
```sql
CREATE TABLE ProgramSlots (program_slot_id BIGINT AUTO_INCREMENT PRIMARY KEY,channel_id BIGINT,start_time TIME,end_time TIME,FOREIGN KEY (channel_id) REFERENCES Channels(channel_id));
```

### ProgramSchedule テーブルの作成
```sql
CREATE TABLE ProgramSchedule (timeslot_id BIGINT,episode_id BIGINT,FOREIGN KEY (timeslot_id) REFERENCES TimeSlots(timeslot_id),FOREIGN KEY (episode_id) REFERENCES Episodes(episode_id));
```

## ステップ3: サンプルデータの挿入
### Channels テーブルのサンプルデータ挿入
```sql
INSERT INTO Channels (channel_name) VALUES
('ドラマチャンネル'),
('アニメチャンネル'),
('映画チャンネル'),
('ニュースチャンネル'),
('スポーツチャンネル');
```

### Genres テーブルのサンプルデータ挿入
```sql
INSERT INTO Genres (genre_name) VALUES
('ドラマ'),
('アニメ'),
('映画'),
('ニュース'),
('スポーツ');
```

### Programs テーブルのサンプルデータ挿入
```sql
INSERT INTO Programs (title, details, genre_id) VALUES
('愛の不時着', '人気韓国ドラマのロマンティックストーリー', 1),
('鬼滅の刃', '剣士たちの壮絶な戦いを描くアニメ', 2),
('君の名は。', '運命に導かれる青春ファンタジー映画', 3),
('世界の今を知る', '最新の国際ニュースを伝える番組', 4),
('サッカー日本代表戦', '日本代表の国際試合を放送', 5);
```

### ProgramGenres テーブルのサンプルデータ挿入
```sql
INSERT INTO ProgramGenres (program_id, genre_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
```

### Seasons テーブルのサンプルデータ挿入
```sql
INSERT INTO Seasons (program_id, season_number) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1);
```

### Episodes テーブルのサンプルデータ挿入
```sql
INSERT INTO Episodes (season_id, episode_number, title, details, duration, release_date) VALUES
(1, 1, '愛の不時着 第1話', '二人の出会い', 60, '2020-01-01'),
(2, 1, '鬼滅の刃 第1話', '鬼に立ち向かう', 45, '2019-04-06'),
(3, 1, '君の名は。', '運命の入れ替わり', 120, '2016-08-26'),
(4, 1, '世界の今を知る 2020/01/01', '新年の国際情勢', 30, '2020-01-01'),
(5, 1, 'サッカー日本代表戦 vs アジア', 'アジアカップの熱戦', 90, '2020-07-03');
```

### ProgramSlots テーブルのサンプルデータ挿入
```sql
INSERT INTO TimeSlots (channel_id, start_time, end_time) VALUES
(1, '20:00', '21:00'),
(2, '18:00', '18:45'),
(3, '22:00', '00:00'),
(4, '12:00', '12:30'),
(5, '19:00', '20:30');
```

### ProgramSchedule テーブルのサンプルデータ挿入
```sql
INSERT INTO ProgramSchedule (programslot_id, episode_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);
```
