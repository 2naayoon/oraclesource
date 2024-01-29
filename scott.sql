-- scott


--1일차


-- SELECT (데이터 조회)
-- e : 별칭(임의 지정 가능) / 없어도 됨
-- * : 전체 필드(컬럼)를 의미함
SELECT * FROM EMP;

-- 특정 컬럼에 해당하는 내용 보기
SELECT	EMPNO, ENAME, JOB
FROM EMP;

-- emp 테이블
-- empno(사원번호), ename(사원명), job(직책), mgr(매니저번호), hiredate(고용일), sal(급여), comm(보너스)
-- deptno(부서번호)

-- emp 테이블에서 사원번호, 매니저번호, 부서번호만 조회
SELECT	Empno, mgr, deptno
FROM emp;
	
-- emp 테이블에서 부서번호(중복 데이터 제거) 조회
SELECT DISTINCT deptno
FROM EMP e ;
	
-- 데이터 출력 시 필드명 별칭 부여
-- 쌍따옴표는 별칭에 공백이 있는 경우 무조건 사용
-- as 생략 가능
SELECT 
    empno AS 사원번호,
	mgr 매니저번호,
	deptno "부서 번호"
FROM
	emp;
	
-- 연봉 계산
-- 월급 * 12 + 수당
-- sal * 12 + comm
SELECT empno, sal, sal * 12 + comm AS "연봉"
FROM EMP e;

-- 정렬
-- order by 정렬기준 컬럼명 DESC(내림차순) or ASC(오름차순 - default)
SELECT *
FROM EMP
ORDER BY SAL DESC;

-- emp 테이블에서 empno, ename, sal 조회 (단, empno 내림차순)
SELECT empno, ename, sal
FROM EMP
ORDER BY EMPNO DESC;

-- 전체조회, 부서번호 오름차순, sal 내림차순
SELECT *
FROM EMP e
ORDER BY DEPTNO, SAL DESC;

-- 조건
-- 부서번호가 30번인 사원 조회
-- sal > 1000 이상인 사원 조회
-- = (같다), 산술연산자(>, <, >=, <=)
SELECT *
FROM EMP e 
WHERE DEPTNO = 30;

SELECT *
FROM EMP e 
WHERE SAL >= 1000;

SELECT *
FROM EMP e 
WHERE SAL >= 1000
ORDER BY SAL DESC;

-- empno 가 7782 인 사원 조회
SELECT *
FROM EMP e 
WHERE empno = 7782;

-- deptno 가 30이고, job 이 SALESMAN 사원 조회
-- 데이터는 대소문자 구별 함
SELECT *
FROM EMP e 
WHERE DEPTNO = 30 AND job = 'SALESMAN';

-- 사원번호가 7499 이고 부서번호가 30인 사원 조회
SELECT *
FROM  EMP e 
WHERE EMPNO = 7499 AND DEPTNO = 30;

-- 이거나(혹은) : or
-- 부서번호가 30 이거나 job이 SALESMAN 사원 조회
SELECT *
FROM EMP e 
WHERE DEPTNO = 30 OR job = 'SALESMAN';

-- 연봉이 36000인 사원 조회
-- 연봉 SAL * 12 + COMM
SELECT *
FROM EMP e 
WHERE SAL * 12 + COMM = 36000;

-- 문자 비교도 가능 - 산술연산 기호 가능
-- 알파벳 순서로 F 다음에 있는 
SELECT *
FROM EMP e 
WHERE ENAME >= 'F';

-- SAL 이 3000 이 아닌 사원 조회
-- ~이 아닌 : !=(java), <>, ^=
SELECT *
FROM EMP e 
WHERE SAL != 3000;

SELECT *
FROM EMP e 
WHERE SAL <> 3000;

SELECT *
FROM EMP e 
WHERE SAL ^= 3000;

-- job이 MANAGER or SALESMAN or CLERK
SELECT *
FROM EMP e 
WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK';

-- IN
SELECT *
FROM EMP e 
WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

SELECT *
FROM EMP e 
WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- HIREDATE 가 1981 10 31 이후에 고용된 사원 조회
-- 날짜 데이터 산술 연산 가능, 날짜 데이터 '' 로 처리
SELECT *
FROM EMP e 
WHERE HIREDATE > '1981-10-31';

-- BEWEEN A AND B
-- SAL 2000 이상 3000 이하인 사원 조회
SELECT *
FROM EMP e 
WHERE SAL >= 2000 AND SAL  <= 3000;

SELECT *
FROM EMP e 
WHERE SAL BETWEEN 2000 AND 3000;

-- NOT BEWEEN A AND B
SELECT *
FROM EMP e 
WHERE SAL NOT BETWEEN 2000 AND 3000;


-- 2일차 


-- LIKE 연산자와 와일드 카드(_, %)
-- _ : 문자 하나
-- % : 문자 개수는 무한대

-- 사원 이름이 S로 시작하는 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '_L%';

-- 사원 이름에 AM 문자가 포함된 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME LIKE '%AM%';

-- 사원 이름에 AM 문자가 포함되지 않은 사원 조회
SELECT *
FROM EMP e 
WHERE ENAME NOT LIKE '%AM%';

-- NULL : 값이 없는 상태
-- '' : 빈 값
-- ' ' : 스페이스 바도 문자임

-- comm 이 null 인 사원 조회
-- NULL 비교 : IS
SELECT * FROM EMP e WHERE COMM = NULL; -- (x)
SELECT * FROM EMP e WHERE COMM IS NULL;

-- MGR 이 NULL 인 사원 조회
SELECT * FROM EMP e WHERE MGR IS NULL;

-- MGR 이 NULL 이 아닌 사원 조회
SELECT * FROM EMP e WHERE MGR IS NOT NULL;

-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 부서번호가 10 혹은 20 사원 조회
-- OR 사용해서 추출
-- 합집합

SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 20
ORDER BY ename;

-- *Error : 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
-- 집합 연산자 UNION 을 사용할 때 출력 열 개수, 타입(숫자, 문자 등) 동일
--SELECT EMPNO, ENAME, SAL, DEPTNO  
--FROM EMP e 
--WHERE DEPTNO = 10
--UNION 
--SELECT EMPNO, ENAME, SAL  
--FROM EMP e 
--WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT SAL, JOB, DEPTNO, SAL 
FROM EMP e 
WHERE DEPTNO = 20;

-- 결과 값의 중복 제거
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10
UNION 
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10;

-- UNION ALL : 중복된 결과 값 제거 안함
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10;

-- MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10;

-- INTERSECT 
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO  
FROM EMP e 
WHERE DEPTNO = 10;

-- 오라클 함수(내장 함수)
-- 함수는 사용하는 DBMS 에 따라 다르게 제공
-- 1. 문자 함수
-- 1) 대소문자 변경
SELECT *
FROM EMP e 
WHERE ENAME = upper('clark');

SELECT *
FROM EMP e 
WHERE lower(ENAME) ='clark';

-- upper(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
-- lower(문자열) : 괄호 안 문자를 모두 소문자로 변환하여 반환
-- initcap(문자열) : 괄호 안 문자 데이터 중 첫번째 문자만 대문자로 나머지는 소문자로 변환하여 반환
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)  
FROM EMP e;

-- 2) 문자열 길이 : LENGTH, LENGTHB
-- LENGTHB : 문자열에 사용된 바이트 수 반환

SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME) 
FROM EMP e;

-- 함수 결과를 보고 싶은 데 테이블이 없으면 임시 테이블로 DUAL 사용 
-- 한글은 문자 하나당 3byte 할당, 영어 1byte
SELECT LENGTH('한글'),LENGTHB('한글') FROM DUAL; 

-- 직책 이름이 6글자 이상인 사원 조회
SELECT *
FROM EMP e 
WHERE LENGTH(job) >= 6; 

-- 3) 문자열 일부 추출 : substr(문자열데이터,시작위치,추출길이)
--                       substr(문자열데이터,시작위치) : 시작위치~마지막까지
--                       시작위치가 음수라면 오른쪽 끝부터 시작
 
SELECT job, SUBSTR(JOB,1,2), SUBSTR(job,3,2),SUBSTR(job,5)  
FROM EMP e; 

SELECT job, SUBSTR(JOB,-1,2), SUBSTR(job,-3,2),SUBSTR(job,-5)  
FROM EMP e;

-- 4) INSTR(문자열데이터,위치를 찾으려는 문자,시작위치,시작위치에서 몇번째 위치)
--    문자열 데이터 안에서 특정 문자 위치 찾기

SELECT INSTR('HELLO, ORACLE!','L') AS INSTR_1,
       INSTR('HELLO, ORACLE!','L', 5) AS INSTR_2,
       INSTR('HELLO, ORACLE!','L', 2, 2) AS INSTR_3
FROM DUAL; 

-- 사원 이름에 S 가 들어있는 사원 조회
-- LIKE
SELECT *
FROM EMP e
WHERE INSTR(ENAME,'S') > 0;

--5) REPLACE : 특정 문자를 다른 문자로 변경
--             REPLACE(문자열데이터,찾는문자,변경할문자)
SELECT '010-1234-5678' AS REPLACE_BEFORE,
	   REPLACE('010-1234-5678','-','') AS REPLACE_1,
	   REPLACE('010-1234-5678','-') AS REPLACE_2,
	   REPLACE('010-1234-5678','-',' ') AS REPLACE_3
FROM DUAL;

--6) CONCAT : 두 문자열 데이터를 합하는 함수
--            CONCAT(문자열데이터1, 문자열데이터2)
--SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB)  
--FROM EMP e
--WHERE ENAME='SCOTT';

-- 7369 : SMITH
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO, CONCAT(' : ',ENAME)) 
FROM EMP e
WHERE ENAME='SMITH';

SELECT EMPNO || ' : ' || ENAME  
FROM EMP e
WHERE ENAME='SMITH';

-- 7) TRIM : 공백 제거(기본)
--    TRIM(삭제옵션(선택), 삭제할문자) FROM 원본문자열
-- 'SMITH' = 'SMITH ' ' SMITH' ' SMITH '
SELECT '[' || ' __Oracle__ ' || ']' AS trim_before,
	   '[' || TRIM(' __Oracle__ ') || ']' AS trim,
	   '[' || LTRIM(' __Oracle__ ') || ']' AS Ltrim,
	   '[' || RTRIM(' __Oracle__ ') || ']' AS Rtrim
FROM DUAL;

SELECT '[' || '__Oracle__' || ']' AS trim_before,
	   '[' || TRIM(LEADING '_' FROM '__Oracle__') || ']' AS TRIM_LEADING,
	   '[' || TRIM(TRAILING '_' FROM '__Oracle__') || ']' AS TRIM_TRAILING,
	   '[' || TRIM(BOTH '_' FROM '__Oracle__') || ']' AS TRIM_BOTH
FROM DUAL;

-- 2. 숫자함수 : 숫자 데이터에 적용
--    반올림, 올림, 버림, 나머지 값 구하기
--    ROUND, CEIL, FLOOR, TRUNC, MOD
--  ROUND(숫자, 반올림위치)

SELECT ROUND(1234.5678) AS ROUND,
       ROUND(1234.5678,0) AS ROUND1,
       ROUND(1234.5678,1) AS ROUND2,
       ROUND(1234.5678,2) AS ROUND3,
       ROUND(1234.5678,-1) AS ROUND_MINUS1,
       ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM DUAL; 

-- TRUNC(숫자, 버릴위치) : 버림
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM DUAL; 

-- CEIL, FLOOR : 지정한 숫자와 가까운 정수를 찾기
-- CEIL : 지정한 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR : 지정한 숫자보다 작은 정수 중 가장 큰 정수 반환

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL; 

-- MOD : 나머지
SELECT 11/5, MOD(11,5) 
FROM DUAL; 

-- 3. 날짜 함수
-- 2023-01-24 or 2023/01/24

-- 오늘날짜
SELECT SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP  
FROM DUAL; 

-- 날짜데이터 + 숫자 : 날짜 데이터보다 숫자만큼 이후의 날짜
SELECT SYSDATE, SYSDATE + 1, SYSDATE - 1 
FROM DUAL; 

-- ADD_MONTHS() : 몇 개월 이후의 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE,3) 
FROM DUAL;

-- 입사 30주년이 되는 날짜 구하기
SELECT empno, ename, hiredate, ADD_MONTHS(HIREDATE,360)
FROM EMP e; 

-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 개의 날짜 데이터를 입력하고 두 날짜간의 개월 수 차이 구하기
-- 고용일과 오늘날짜 차이
SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3
FROM EMP e; 

-- NEXT_DAY, LAST_DAY 
-- NEXT_DAY(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
-- LAST_DAY(날짜) : 특정 날짜가 속한 달의 마지막 날짜 출력
SELECT
	SYSDATE,
	NEXT_DAY(SYSDATE, '월요일'),
	LAST_DAY(SYSDATE)
FROM DUAL;

-- 데이터 타입(자료형)
-- NUMBER(숫자), VARCHAR2(문자), DATE(날짜/시간)
-- 자료형 변환(날짜 -> 문자, 문자 -> 숫자)

-- NUMBER + 문자 숫자 
SELECT EMPNO, ENAME, EMPNO + '500' 
FROM EMP e
WHERE ENAME='FORD';

-- 수치가 부적합합니다
--SELECT EMPNO, ENAME, EMPNO + 'ABCD' 
--FROM EMP e
--WHERE ENAME='FORD';

-- TO_CHAR(날짜(숫자)), 형식) : 날짜 데이터를 출력할 문자형태를 지정(주로 날짜 데이터에 사용)
-- TO_NUMBER(문자열, 숫자형식) : 문자열 데이터를 지정한 형태의 숫자로 인식하여 숫자 데이터로 변환

-- Y : 연도, M : 월, D : 일, HH : 시, MI : 분, SS : 초, HH24 : 시를 24시간으로, AM(PM) : 오전, 오후
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD'), SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD HH:MI:SS AM') 
FROM dual;

SELECT 1300 - '1500', '1300' + 1500
FROM DUAL;

-- *Error : 수치가 부적합합니다
--SELECT '1,300' + '1,500'
--FROM DUAL;

-- 9 : 숫자의 한 자리를 의미함(빈자리를 채우지 않음) 
-- 0 : 빈 자리를 0으로 채움
SELECT TO_NUMBER('1,300','999,999') + TO_NUMBER('1,500','999,999')
FROM DUAL;

SELECT TO_CHAR(sal, '999,999.00') AS sal1,
       TO_CHAR(sal, '000,999,999.00') AS sal2
FROM EMP e; 

-- TO_DATE(문자, '인식될 날짜 형태') : 문자 데이터를 날짜 데이터로 변환
SELECT
	TO_DATE('2024-01-24') AS todate1,
	TO_DATE('20240124') AS todate2
FROM dual;

-- *Error : 수치가 부적합합니다
--SELECT '2024-01-24' - '2023-12-31'
--FROM DUAL;

SELECT TO_DATE('2024-01-24') - TO_DATE('2023-12-31')
FROM DUAL;

-- 널 처리 함수
-- 널 * 숫자 => NULL, 널 + 숫자 => NULL
-- 널을 다른 값으로 변경

 SELECT EMPNO, ENAME, SAL, COMM, SAL + COMM  
 FROM EMP e ;

-- NVL(널인지 검사할 열이름(OR 데이터), 대체할 데이터)
 SELECT EMPNO, ENAME, SAL, COMM, SAL + NVL(COMM,0)   
 FROM EMP e ;

-- NVL2(널인지 검사할 열이름(OR 데이터),NULL 이 아닌경우 반환 데이터(계산식),NULL 인 경우 반환 데이터(계산식))
 SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, 'O', 'X')  
 FROM EMP e ;

-- NVL2 
-- COMM 이 널이면 연봉=SAL * 12, 널이 아니면 연봉=SAL*12+COMM
SELECT EMPNO, ENAME, SAL, COMM, NVL2(COMM, SAL * 12 + COMM, SAL * 12) AS 연봉
FROM EMP e ;

-- JOB 이 MANAGER 라면 SAL * 1.1
-- JOB 이 SALESMAN 라면 SAL * 1.05
-- JOB 이 ANALYST 라면 SAL
-- 나머지 직무 SAL * 1.03 

-- DECODE 함수와 CASE 문
-- DECODE(검사대상, 조건1,조건1이 참일때 반환할 결과, 
--                  조건2, 조건2 가 참일때 반환할결과,......., 조건1~조건n 일치하지 않는 경우 반환할 결과 )

SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM EMP e; 

SELECT EMPNO, ENAME, JOB, SAL,
	CASE job 
		WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL
		ELSE SAL * 1.03
	END AS UPSAL2,
	DECODE(JOB, 'MANAGER', SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM EMP e; 

-- COMM 널일때 해당사항 없음
--      0 일때 수당없음
--     > 0     수당 : COMM 

SELECT EMPNO, ENAME, COMM,
	CASE  
		WHEN COMM IS NULL THEN '해당사항 없음'
		WHEN COMM = 0 THEN '수당 없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_TEXT
FROM EMP e; 

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무 시간을 8시간으로 보았을 때 
-- 사원들의 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여 결과를 출력한다. 
-- 단, 하루 급여는 소수점 셋째 자리에서 버리고, 시급은 두 번째 소수점에서 반올림하시오.

SELECT
	EMPNO,
	ENAME,
	SAL,
	TRUNC(SAL / 21.5, 2) AS DAY_PAY,
	ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY
FROM EMP e ;

--EMP 테이블에서 사원들은 입사일(HIREDATE)을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다.
--사원들이 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 아래와 같이 출력하시오. 
--단, 추가수당(COMM)이 없는 사원의 추가 수당은 N/A로 출력하시오.

SELECT EMPNO, ENAME, HIREDATE, 
	   TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	   NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP e ;


-- 3일차


-- EMP 테이블에서 모든 사원을 대상으로 직속상관의 사원 번호(MGR)을 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오
-- 직속상관의 사원 번호가 존재하지 않을 경우 : 0000
-- 직속상관의 사원 번호 앞 두자리가 75일 경우 : 5555
-- 직속상관의 사원 번호 앞 두자리가 76일 경우 : 6666
-- 직속상관의 사원 번호 앞 두자리가 77일 경우 : 7777
-- 직속상관의 사원 번호 앞 두자리가 78일 경우 : 8888
-- 그 외 직속상관 사원 번호의 경우 : 본래 직속 상관의 사원 번호 그대로 출력

-- SUBSTR(TO_CHAR(mgr), 1, 2)
SELECT EMPNO, ENAME, MGR,
	DECODE(SUBSTR(TO_CHAR(mgr), 1, 2), NULL, '0000', '75', '5555', '76', '6666', '77', '7777', '78', '8888', 
	SUBSTR(TO_CHAR(mgr), 1)) AS CHG_MGR
FROM EMP e;

SELECT EMPNO, ENAME, MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) ='75' THEN '5555'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) ='76' THEN '6666'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) ='77' THEN '7777'
		WHEN SUBSTR(TO_CHAR(MGR), 1, 2) ='78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM EMP e;

SELECT EMPNO, ENAME, MGR,
	CASE SUBSTR(TO_CHAR(NVL(MGR, 0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM EMP e;

-- 다중 행 함수
-- sum(), avg(), count(), max(), min()

-- *Error : 단일 그룹의 그룹 함수가 아닙니다(여러 행이 나올 수 있는 컬럼을 추가한 경우)
SELECT SUM(sal), AVG(sal), COUNT(sal), MAX(sal), MIN(sal)
FROM EMP e;

-- 동일한 급여를 하나만 선택해서 합계
SELECT SUM(DISTINCT sal)
FROM EMP e;

SELECT COUNT(*)
FROM EMP e;

-- 부서번호가 30인 사원 수 출력
SELECT COUNT(*)
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서번호가 30인 사원 중에서 급여의 최대값
SELECT MAX(sal)
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서번호가 20인 사원의 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(hiredate)
FROM EMP e 
WHERE DEPTNO = 20;

-- 부서번호가 20인 사원의 입사일 중에서 제일 오래된 입사일 조회
SELECT MIN(hiredate)
FROM EMP e 
WHERE DEPTNO = 20;

-- 부서번호가 30인 사원 중에서 sal 중복값 제거한 후 평균 구하기
SELECT AVG(DISTINCT sal)
FROM EMP e 
WHERE DEPTNO = 30;

-- 부서별 급여 합계 구하기
SELECT '10' AS DEPTNO, SUM(sal)
FROM EMP e 
WHERE DEPTNO = 10
UNION
SELECT '20' AS DEPTNO, SUM(sal)
FROM EMP e 	
WHERE DEPTNO = 20
UNION
SELECT '30' AS DEPTNO, SUM(sal)
FROM EMP e 
WHERE DEPTNO = 30;

-- 결과 값을 원하는 열로 묶기 : GROUP BY
-- SELECT 보고 싶은 컬럼(열이름)...					①
-- FROM 테이블명									②
-- WHERE 조건들 나열								③
-- GROUP BY 그룹화할 열 이름... (HAVING : OPTION)	④
-- ORDER BY 정렬조건								⑤

-- 실행 순서
-- ② → ③ → GROUP BY → HAVING → ① → ⑤

SELECT DEPTNO, SUM(SAL)
FROM EMP e 
GROUP BY DEPTNO;

-- 부서별 급여 평균
SELECT deptno, AVG(sal)
FROM EMP e 
GROUP BY DEPTNO;

-- 부서번호, 직무별 급여 평균
SELECT deptno, job, AVG(sal)
FROM EMP e 
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO;

-- HAVING : GROUP BY 절에 조건을 사용할 때
-- 부서별 직책의 평균 급여가 500 이상인 사원들의 부서번호, 직책, 부서별 직책 평균 급여
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP e 
GROUP BY DEPTNO, JOB HAVING AVG(SAL) >= 500
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP e 
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;

-- 같은 직무에 종사하는 사원이 3명 이상인 직무와 인원수 조회
SELECT job, COUNT(JOB)
FROM EMP e 
GROUP BY JOB HAVING COUNT(JOB) >= 3 
ORDER BY JOB;

-- 사원들의 입사연도를 기준으로 부서별 몇명이 입사했는지 조회
-- 1981년 10번 부서 3명
-- 1981년 20번 부서 2명
SELECT TO_CHAR(HIREDATE, 'YYYY') AS	HIRE_YEAR, deptno, COUNT(*) AS 인원수
FROM EMP e 
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO 
ORDER BY DEPTNO;

-- JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- 1) 내부조인 (일치하는 값이 있을 경우-두 테이블의 교집합)

-- EMP 와 DEPT 조인
SELECT *
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- *Error : 열의 정의가 애매합니다 (조인 할 경우 테이블에 동일한 컬럼명이 존재하는 경우)
SELECT e.ename, e.sal, d.deptno, d.dname, d.loc
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- 조인 조건이 없을 때 나올 수 있는 모든 조합이 결과로 출력
SELECT e.ename, e.sal, d.deptno, d.dname, d.loc
FROM EMP e, DEPT d;

SELECT e.ename, e.sal, d.deptno, d.dname, d.loc
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >= 3000;

-- SQL-99 표준구문
SELECT e.ename, e.sal, d.deptno, d.dname, d.loc
FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.SAL >= 3000;

-- EMP, SALGRADE JOIN
SELECT *
FROM EMP e, SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

-- EMP, EMP JOIN (SELF JOIN)
SELECT e.empno, e.ename, e.mgr, e2.ename AS mgr_name
FROM EMP e, EMP e2 
WHERE e.mgr = e2.empno;

-- 2) 외부조인 (일치하지 않는 값도 화면에 출력)
--	(1) 왼쪽 외부조인 (일치하지 않는 값을 왼쪽 테이블 기준)
--	(2) 오른쪽 외부조인 (일치하지 않는 값을 오른쪽 테이블 기준)
SELECT e.empno, e.ename, e.mgr, e2.ename AS mgr_name
FROM EMP e LEFT	OUTER JOIN EMP e2 ON e.mgr = e2.empno;

SELECT e.empno, e.ename, e.mgr, e2.ename AS mgr_name
FROM EMP e RIGHT OUTER JOIN EMP e2 ON e.mgr = e2.empno;

-- 각 부서별 평균급여, 최대급여, 최소급여, 사원수
-- 부서번호, 부서명, 평균급여, 최대급여, 최소급여, 사원수
SELECT e.deptno, d.dname, AVG(sal), MIN(sal), MAX(sal), COUNT(*) 
FROM EMP e JOIN	DEPT d ON e.DEPTNO = d.DEPTNO 
GROUP BY e.DEPTNO, d.DNAME;

-- 세 개의 테이블 조인하기
SELECT *
FROM EMP e1
JOIN EMP e2 ON e1.empno = e2.EMPNO 
JOIN EMP e3 ON e2.empno = e3.empno;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무, 급여
-- DEPT 테이블 기준으로 출력
SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
FROM DEPT d left OUTER JOIN EMP e ON d.DEPTNO = e.DEPTNO 
ORDER BY d.DEPTNO, e.ENAME;

SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal
FROM EMP e RIGHT OUTER JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
ORDER BY d.DEPTNO, e.ENAME;

-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름 순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무, 급여, LOSAL, HISAL, GRADE
-- DEPT 테이블 기준으로 출력
SELECT d.deptno, d.dname, e.empno, e.ename, e.job, e.sal, s.losal, s.hisal, s.grade
FROM EMP e RIGHT OUTER JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
	LEFT OUTER JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY d.DEPTNO, e.ENAME;


-- 4일차


-- 서브쿼리
-- SQL 문 내부에서 SELECT 문을 사용
-- 괄호 () 로 묶어서 사용
-- 메인쿼리의 비교 대상과 같은 자료형과 같은 개수로 지정해야 한다

-- JONES 사원의 급여보다 높은 급여를 받는 사원 조회
-- JONES 급여 알아내기 → 비교
SELECT SAL
FROM EMP e 
WHERE ENAME = 'JONES';

SELECT *
FROM EMP e 
WHERE SAL > 2975;

SELECT *
FROM EMP e
WHERE SAL > (
	SELECT SAL
	FROM EMP e
	WHERE ENAME = 'JONES');
	 
-- ALLEN 이 받는 COMM 보다 많은 추가수당을 받는 사원 조회
SELECT *
FROM EMP e 
WHERE COMM > (
	SELECT COMM
	FROM EMP e
	WHERE ENAME = 'ALLEN');
	 
-- WARD 사원의 입사일보다 빠른 입사자 조회
SELECT *
FROM EMP e 
WHERE HIREDATE < (
	SELECT HIREDATE 
	FROM EMP e
	WHERE ENAME = 'WARD');
	
-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, d.DEPTNO, d.DNAME, d.LOC 
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.DEPTNO = 20 AND e.SAL > (SELECT AVG(sal) FROM EMP e);

-- 단일행 서브쿼리 : 서브쿼리 실행 결과가 단 하나의 행으로 나오는 서브쿼리
-- 사용 가능한 연산자 : >, <, >=, <=, <>, !=, ^=

-- 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러개의 행으로 나오는 서브쿼리
-- 사용 가능한 연산자 : IN, ANY(SOME), ALL, EXISTS
--						IN, ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리가 하나이상
--						ALL : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족
--						EXISTS : 서브쿼리의 결과가 존재하면

-- *Error : 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다
-- 서브쿼리가 여러 개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우

--SELECT *
--FROM EMP e 
--WHERE SAL >= (
--	SELECT MAX(SAL)
--	FROM EMP e
--	GROUP BY DEPTNO);

SELECT *
FROM EMP e 
WHERE SAL IN (
	SELECT MAX(SAL)
	FROM EMP e
	GROUP BY DEPTNO);
	
-- IN 사용과 동일한 결과
SELECT *
FROM EMP e 
WHERE SAL = ANY (
	SELECT MAX(SAL)
	FROM EMP e
	GROUP BY DEPTNO);

-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 조회
-- < ANY = MAX / > ANY = MIN
SELECT *
FROM EMP e 
WHERE SAL < ANY (
	SELECT SAL 
	FROM EMP e
	WHERE DEPTNO = 30);
	
-- 서브쿼리의 값을 모두 만족
SELECT *
FROM EMP e 
WHERE SAL < ALL (
	SELECT SAL 
	FROM EMP e
	WHERE DEPTNO = 30);
	
-- 결과가 하나라도 나오면 전혀 상관없는 테이블도 연결 가능
SELECT *
FROM EMP e 
WHERE EXISTS (
	SELECT DNAME
	FROM DEPT d 
	WHERE DEPTNO = 20);
	
-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보를 다음과 같이 출력하는 SQL문을 작성하시오
SELECT e.JOB, e.EMPNO, e.ENAME, e.SAL, d.DEPTNO, d.DNAME
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.JOB IN (
	SELECT e.JOB
	FROM EMP e
	WHERE e.ENAME = 'ALLEN');

-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력하는 SQL문을 작성하시오
-- 단, 출력할 때 급여가 많은 순으로 정렬하되 급여가 같을 경우에는 사원 번호를 기준으로 오름차순
SELECT e.EMPNO, e.ENAME, e.DEPTNO, e.SAL, e.HIREDATE, d.DNAME, d.LOC, s.GRADE 
FROM EMP e 
	JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
	JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL
WHERE e.SAL > (
	SELECT AVG(e.SAL) 
	FROM EMP e)
ORDER BY e.SAL DESC, e.EMPNO ASC;

-- 다중 열 서브쿼리
-- 부서별 급여 최대값

SELECT *
FROM EMP e 
WHERE (DEPTNO, SAL) IN (
	SELECT DEPTNO, MAX(SAL) 
	FROM EMP e 
	GROUP BY DEPTNO);

-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP e WHERE DEPTNO = 10) E10,
	 (SELECT * FROM DEPT d) D
WHERE E10.DEPTNO = D.DEPTNO;

-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
SELECT e.EMPNO, e.ENAME, e.JOB, e.SAL, (
	SELECT s.GRADE 
	FROM SALGRADE s 
	WHERE e.SAL BETWEEN s.losal AND s.hisal) AS SALGRADE
FROM EMP e;


-- DML(Data Manipulation Language - 데이터 조작 언어)
-- SELECT(조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블 복제해서 DEPT_TEMP 라는 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- 새로운 부서 추가
-- INSERT INTO 테이블명 (열이름1, 열이름2...)
-- VALUES (데이터, 데이터...)

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(60, 'DATABASE', 'BUSAN');

INSERT INTO DEPT_TEMP
VALUES(70, 'DATABASE', 'BUSAN');

-- *Error : 값의 수가 충분하지 않습니다
INSERT INTO DEPT_TEMP
VALUES(80, 'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(80, 'DATABASE');

-- *Error : 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다
-- TYPE - NUMBER(2,0) : 숫자 2자리까지 허용
INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(800, 'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(90, 'DATABASE', NULL);

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8000, 'HONG', 'MANAGER', 7902, '2015-03-15', 1000, NULL, 50);

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9000, 'SUNG', 'MANAGER', 7782, SYSDATE, 1200, 800, 50);

-- 테이블의 구조만 복사 (데이터는 복사하지 않을 때)
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1 <> 1;

-- 수정
-- UPDATE 테이블명 SET 수정할 내용, ..., ... ; - 전체 변경
-- UPDATE 테이블명 SET 수정할 내용, ..., ... WHERE 조건 ;

UPDATE DEPT_TEMP
SET LOC = 'BUSAN';

UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DEPTNO = 50;

UPDATE DEPT_TEMP
SET LOC = 'SEOUL', DNAME = 'NETWORK'
WHERE DEPTNO = 40;

-- 삭제 (행 단위)
-- DELETE 테이블명 WHERE 조건 ;
-- DELETE FROM 테이블명 WHERE 조건 ;

DELETE DEPT_TEMP
WHERE DEPTNO = 20;

DELETE FROM DEPT_TEMP
WHERE DEPTNO = 30;

-- 서브쿼리 + DELETE
-- 급여등급이 3등급이고 30번 부서의 사원 삭제

DELETE FROM EMP_TEMP
WHERE EMPNO IN (
	SELECT EMPNO FROM EMP_TEMP et 
	JOIN SALGRADE s ON et.sal BETWEEN s.losal AND s.hisal 
	AND s.grade = 3 AND et.deptno = 30);

-- 서브쿼리 + UPDATE
UPDATE DEPT_TEMP 
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

-- 서브쿼리 + INSERT
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e1.EMPNO, e1.ENAME, e1.JOB, e1.MGR, e1.HIREDATE, e1.SAL, e1.COMM, e1.DEPTNO
FROM EMP e1 JOIN SALGRADE s ON e1.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1;

-- EMP 테이블의 내용을 이용하여 EXAM_EMP 생성
-- DEPT 테이블의 내용을 이용하여 EXAM_DEPT 생성
-- SALGRADE 테이블의 내용을 이용하여 EXAM_SALGRADE 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

-- EXAM_EMP 테이블에 정보를 입력하시오
INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL, 50); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7203, 'TEST_USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 60); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, 300, 60); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2600, NULL, 70); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 2300, NULL, 80); 

INSERT INTO EXAM_EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (7208, 'TEST_USER8', 'STUDENT', 7201, '2018-02-21', 1200, NULL, 80); 

-- EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를
-- 받고있는 사원들을 70번 부서로 옮기는 SQL문 작성
UPDATE EXAM_EMP 
SET DEPTNO = 70
WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게
-- 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL문 작성
UPDATE EXAM_EMP
SET SAL = SAL * 1.1, DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);

-- EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문 작성
DELETE exam_emp
WHERE empno IN (
	SELECT empno FROM exam_emp, SALGRADE 
	WHERE sal BETWEEN losal AND hisal AND grade = 5);
	
COMMIT;


--5일차


-- Transsaction
-- 하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
-- 최종반영 (Commit) / 모두 취소 (Rollback)

-- DBeaver 설정에서 커밋 모드 변경 가능
-- 기본 : Auto commit 상태

INSERT INTO DEPT_TEMP
VALUES (55, 'NETWORK', 'SEOUL');

UPDATE DEPT_TEMP 
SET LOC = 'BUSAN'
WHERE DEPTNO = 55;

COMMIT;
ROLLBACK; - COMMIT 전 실행 (COMMIT 취소 X)

SELECT * FROM DEPT_TEMP dt; 

DELETE FROM DEPT_TEMP dt
WHERE deptno = 55;

UPDATE DEPT_TEMP 
SET DNAME = 'WEB'
WHERE DEPTNO = 10;

-- LOCK : 한 세션에서 트랜잭션 작업이 완료되지 않으면 다른 세션에서 작업을 처리할 수 없는 상태
--        (DML - insert, update, delete)

-- 테이블 정의, 사용자 정의, 권한 부여(취소)

-- SQL - 1. DDL    2. DML - select, insert, update, delete    3. DCL (권한부여)

-- 데이터 정의어 (DDL)
-- 테이블 정의, 사용자 정의, 권한 부여(취소)
-- CREATE

-- 1. 테이블 생성
-- CREATE TABLE 테이블명 (
-- 필드명 필드타입(크기) 제약조건, 
-- )

-- 열 이름 규칙
-- 문자로 시작 / 30byte 이하로 작성 / 한 테이블 안 열 이름 중복 불가
-- 열 이름은 문자, 0-9, 특수문자($, #, _) 사용 가능
-- SQL 키워드는 열 이름으로 사용 불가 (order, group, select,...)

-- 문자
-- 1) CHAR  2) VARCHAR2  3) NCHAR  4) NVARCHAR2  5) CLOB  6) NCLOB  7) LONG
-- CHAR or VARCHAR : 열의 너비가 고정값인지 가변인지

-- CHAR(10) : 'hong' - 10자리 다 사용
-- VARCHAR2(10) : 'hong' - 입력된 글자에 따라 가변

-- VACHAR2, CHAR 가 한글, 영문 입력 시 사용하는 바이트 수가 다름
-- NCHAR, NVARCHAR 사용하는 바이트 수 통일

-- NCHAR(10) : 'hong' - 유니코드 문자열 타입이고, 고정 (문자 1개당 1byte - 한글, 영어 상관 X)
-- NVARCHAR2(10) : 'hong' - 유니코드 문자열 타입이고, 가변 (문자 1개당 1byte - 한글, 영어 상관 X)

-- CLOB : 문자열 데이터를 외부 파일로 저장
--        엄청 많은 텍스트 데이터 입력 시 사용

-- LONG : 2GB

-- 숫자
-- NUMBER (전체자릿수, 소수점자릿수)
-- BINARY_FLOAT, BINARY_DOUBLE

-- 날짜
-- DATE, TIMESTAMP

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

SELECT * FROM emp_ddl;

-- 기본 테이블 열 구조와 데이터 복사해서 새 테이블 생성
CREATE TABLE exam_dept AS SELECT * FROM emp;

-- 기본 테이블 열 구조만 복사해서 새 테이블 생성
CREATE TABLE emp_temp2 AS SELECT * FROM emp WHERE 1<>1;

-- DDL : CREAT, ALTER
-- 2. 테이블 변경
-- 1) 열 추가 (ADD)
ALTER TABLE 테이블명 ADD 추가할열이름 데이터타입(10)

-- emp_ddl 에 새로운 컬럼 추가 HP (010-1234-4567)
ALTER TABLE EMP_DDL ADD HP VARCHAR2(15);

SELECT * FROM EMP_DDL ed;

-- 2) 열 이름 변경 (RENAME)
ALTER TABLE 테이블명 RENAME COLUMN 기존이름 TO 변경이름

-- HP → MOBILE
ALTER TABLE EMP_DDL RENAME COLUMN HP TO MOBILE;

-- 3) 열 자료형 변경 (MODIFY)
ALTER TABLE 테이블명 MODIFY 열이름 데이터타입(20)

-- EMPNO NUMBER(5)
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- SQLplus : scott 접속
desc emp_ddl - 열 구조 확인

-- 4) 열 제거
ALTER TABLE 테이블명 DROP COLUMN 열이름;

ALTER TABLE EMP_DDL DROP COLUMN MOBILE;

-- 테이블 이름 변경
RENAME 변경전 테이블명 TO 변경할 테이블명

-- EMP_DDL → EMP_ALTER
RENAME EMP_DDL TO EMP_ALTER;

SELECT * FROM EMP_ALTER;

-- CREATE, ALTER, DROP
-- 3. 테이블 삭제 : DROP
DROP TABLE 테이블명;

DROP TABLE EMP_ALTER;

-- VIEW : 가상테이블
CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명)
-- 편리성, 보안성

-- *Error : 권한이 불충분합니다
-- 뷰는 권한을 가진 사용자만 생성할 수 있음
CREATE VIEW VM_EMP20 AS (SELECT * FROM EMP WHERE DEPTNO = 20);

SELECT * FROM vm_emp20;

INSERT INTO VM_EMP20
VALUES (8888, 'HONG', 'ANALYST', 7902, SYSDATE, 2500, NULL, 20);

SELECT * FROM EMP e;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP20';

-- VIEW 를 통해 읽기만 가능 (insert, update, delete 불가능)
CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명) WITH READ ONLY

CREATE VIEW VM_EMP30 AS (SELECT * FROM EMP WHERE DEPTNO = 30) WITH READ ONLY;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP30';

-- VIEW 삭제
DROP VIEW VM_EMP20;
DROP VIEW VM_EMP30;

-- INDEX 생성, 삭제
-- INDEX (색인, 목차) 
-- 인덱스 : 기본키, 고유키일 때 자동으로 생성
CREATE INDEX 인덱스명 ON 테이블명 (인덱스로 사용할 필드명)

CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

SELECT * FROM USER_IND_COLUMNS;

DROP INDEX IDX_EMP_SAL;

-- 시퀀스 생성 / 삭제
-- ORACLE 객체, 하나씩 증가하는 값이 필요할 때 주로 사용
-- 다른 DB의 AUTO_INCREMENT 와 동일한 역할
CREATE SEQUENCE 시퀀스명
INCREMENT BY 증감값 START WITH 시작값 MAXVALUE 최대값 MINVALUE 최소값
NOCYCLE CACHE 숫자;

-- 1 에서 시작 ~ 99999999...
-- 1씩 증가하면서 숫자 생성
CREATE SEQUENCE dept_seq;
DROP SEQUENCE dept_seq;

SELECT * FROM USER_SEQUENCES;

CREATE TABLE dept_sequence AS SELECT * FROM dept WHERE 1<>1;

CREATE SEQUENCE dept_seq
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0
NOCYCLE CACHE 2;

-- 시퀀스 DEPT_SEQ.NEXTVAL exceeds MAXVALUE은 사례 - insert 시 자동으로 하나씩 증가
INSERT INTO dept_sequence (deptno, dname, loc)
VALUES (dept_seq.nextval, 'DATABASE', 'SEOUL');

SELECT * FROM dept_sequence;

ALTER SEQUENCE dept_seq INCREMENT BY 3 MAXVALUE 99 CYCLE;

-- 마지막으로 생성된 시퀀스 확인
SELECT dept_seq.currval FROM dual;

