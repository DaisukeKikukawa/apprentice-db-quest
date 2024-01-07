1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
SELECT e.title, e.view_count
FROM Episodes e
ORDER BY e.view_count DESC
LIMIT 3;

2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
SELECT
    p.title AS program_title,
    s.season_number,
    e.episode_number,
    e.title AS episode_title,
    e.view_count
FROM Episodes e
JOIN Seasons s ON e.season_id = s.season_id
JOIN Programs p ON s.program_id = p.program_id
ORDER BY e.view_count DESC
LIMIT 3;

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
SELECT
    ch.channel_name,
    CONCAT(CURDATE(), ' ', ts.start_time) AS broadcast_start,
    CONCAT(CURDATE(), ' ', ts.end_time) AS broadcast_end,
    s.season_number,
    e.episode_number,
    e.title AS episode_title,
    e.details AS episode_details
FROM TimeSlots ts
JOIN Channels ch ON ts.channel_id = ch.channel_id
JOIN ProgramSchedule ps ON ts.timeslot_id = ps.timeslot_id
JOIN Episodes e ON ps.episode_id = e.episode_id
JOIN Seasons s ON e.season_id = s.season_id
WHERE DATE(ts.start_time) = CURDATE()
ORDER BY ts.start_time;

4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
SELECT
    CONCAT(DATE(ts.start_time), ' ', TIME(ts.start_time)) AS broadcast_start,
    CONCAT(DATE(ts.end_time), ' ', TIME(ts.end_time)) AS broadcast_end,
    s.season_number,
    e.episode_number,
    e.title AS episode_title,
    e.details AS episode_details
FROM TimeSlots ts
JOIN ProgramSchedule ps ON ts.timeslot_id = ps.timeslot_id
JOIN Episodes e ON ps.episode_id = e.episode_id
JOIN Seasons s ON e.season_id = s.season_id
JOIN Channels ch ON ts.channel_id = ch.channel_id
WHERE ch.channel_name = 'ドラマ'
    AND DATE(ts.start_time) BETWEEN CURDATE() AND CURDATE() + INTERVAL 7 DAY
ORDER BY ts.start_time;

