* ����������ƴ��RFM���������ݱ�.
GET
  FILE='C:\��������_��ұ�.sav'.
DATASET NAME ��ұ�.

RECODE BUY_CRED
  (MISSING = SYSMIS) ("���õ÷�=0" = 0) ("���õ÷�<=3"=0)
  ("1�Ǽ�"=1.1) ("2�Ǽ�"=1.2) ("3�Ǽ�"=1.3) ("4�Ǽ�"=1.4)  ("5�Ǽ�"=1.5)
  ("1��"=2.1) ("2��"=2.2) ("3��"=2.3) ("4��"=2.4) ("5��"=2.5)
  ("1�ʹ�"=3.1) ("2�ʹ�"=3.2) ("3�ʹ�"=3.3) ("4�ʹ�"=3.4) ("5�ʹ�"=3.5)
  ("1���"=4.1) ( "2���"=4.2) ("3���"=4.3) ("4���"=4.4) ("5���"=4.5)
  INTO BUY_CRED1.
EXEC.
VARIABLE LEVEL BUY_CRED1(ORDINAL).

STRING  BUY_PROV1 (A10).
COMPUTE BUY_PROV1=BUY_PROV.
IF BUY_PROV1="δ֪" OR BUY_PROV1="0"  BUY_PROV1="".
EXEC.

AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=BUY_PROV
  /N_BREAK=N.
EXEC.

IF N_BREAK<30 BUY_PROV1="��������".
EXEC.

* ��ʼ��RFM���������ɵ�RFM����в���.
DATASET ACTIVATE RFM��.
RECODE ����_����
  (1 = 0) (ELSE= 1)  INTO REP.
EXEC.

VARIABLE LABELS REP "�Ƿ��ν���".
VALUE LABELS REP 0"���ν���" 1"��ν���".

COMPUTE �ξ����=���/����_����.
EXEC.

* �ϲ����ļ�.
SORT CASES BY buyer_id(A).
DATASET ACTIVATE ��ұ�.
SORT CASES BY buyer_id(A).
MATCH FILES /FILE=*
  /TABLE='RFM��'
  /BY buyer_id.
EXECUTE.



