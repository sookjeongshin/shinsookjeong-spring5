update tbl_member set
user_pw = '$2a$10$kIqR/PTloYan/MRNiEsy6uYO6OCHVmAKR4kflVKQkJ345nqTiuGeO'
where user_id like 'dummy_%';
-- 로그인 아이디는 admin, 암호는 user02 입니다.
-- 워크벤치 (mysql,마리아DB)의 아이디는 root, 암호는 apmsetup 입니다.