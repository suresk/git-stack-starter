BEGIN
    dbms_output.put_line(SYSDATE || ' <Line 1> of the dbms output. ');
    dbms_output.put_line(SYSDATE || ' <Line 2> of the dbms output. ');
END;
/

delete from schema_info where name='SPS_CTIN';

--delete from fail_dbotest_now;