comp v85_96=v85+v96.
comp v87_98=v87+v98.
comp v88_89_91=v88+v89+v91.
exec.
variable labels  v85_96 '�г�ҩ/��ҩ��' / v87_98 '������Ʒ�'
  / v88_89_91 '����/Ѫ/����'.


USE ALL.
COMPUTE filter_$=(range(v83,0.1,50000)=1 & range(v29,2,200)).
FILTER BY filter_$.
EXECUTE.

comp lgv83=lg10(v83).
comp lgv29=lg10(v29).
EXECUTE.
VARIABLE LABELS lgv83 'lg(סԺ�ܷ���)' / lgv29 'lg(סԺ����)'.


DATASET COPY ȫ��ҽ.
DATASET ACTIVATE ȫ��ҽ.
DELETE VARIABLES lgv83 lgv29 v41.
comp v55=1.
exec.
DATASET COPY ȫ��ҽ.
DATASET ACTIVATE ȫ��ҽ.
comp v55=2.
exec.
DATASET COPY ȫ����ҽ.
DATASET ACTIVATE ȫ����ҽ.
comp v55=3.
exec.
DATASET ACTIVATE ���ݼ�1.

ADD FILES /FILE=*
  /FILE='ȫ��ҽ'
  /FILE='ȫ��ҽ'
  /FILE='ȫ����ҽ'.
EXECUTE.

DATASET CLOSE ȫ��ҽ.
DATASET CLOSE ȫ��ҽ.
DATASET CLOSE ȫ����ҽ.



SELECT IF (missing(lgv29)=1).
EXECUTE.

comp Pred_V83=10**(MLP_PredictedValue_2).
comp Pred_V29=10**(MLP_PredictedValue_3).
EXECUTE.
VARIABLE LABELS Pred_V83 '����Ԥ��ֵ' Pred_V29 '����Ԥ��ֵ'.
