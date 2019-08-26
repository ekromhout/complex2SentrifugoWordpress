DELIMITER ;;

CREATE TRIGGER after_insert_on_main_employees_summary AFTER INSERT ON main_employees_summary FOR EACH ROW BEGIN SET @message_id = (SELECT lib_mysqludf_amqp_sendjson('amqp://mysql:5ecr3t@mq', 'sor', 'sor_person', json_object('payload',json_object('sourceId',json_array(json_object('id',NEW.employeeId,'source','HR')),'name',json_array(json_object('givenName',NEW.firstname,'familyName',NEW.lastname)),'email',json_array(json_object('emailAddress',NEW.emailaddress,'emailType','primary')),'phone',json_array(json_object('phoneNumber',NEW.office_number,'phoneType','Work'),json_object('phoneNumber',NEW.contactnumber,'phoneType','Mobile')))))); END;;


CREATE TRIGGER after_update_on_main_employees_summary AFTER UPDATE ON main_employees_summary FOR EACH ROW BEGIN SET @message_id = (SELECT lib_mysqludf_amqp_sendjson('amqp://mysql:5ecr3t@mq', 'sor', 'sor_person', json_object('payload',json_object('sourceId',json_array(json_object('id',NEW.employeeId,'source','HR')),'name',json_array(json_object('givenName',NEW.firstname,'familyName',NEW.lastname)),'email',json_array(json_object('emailAddress',NEW.emailaddress,'emailType','primary')),'phone',json_array(json_object('phoneNumber',NEW.office_number,'phoneType','Work'),json_object('phoneNumber',NEW.contactnumber,'phoneType','Mobile')))))); END;;

DELIMITER ;
