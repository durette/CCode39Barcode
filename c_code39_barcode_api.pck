SET SQLBLANKLINES ON
SET FEEDBACK ON
SET SERVEROUTPUT ON
SET LINESIZE 32767
SET PAGESIZE 0

CREATE OR REPLACE PACKAGE c_code39_barcode_api IS
module_  CONSTANT VARCHAR2(25) := 'FNDBAS';
lu_name_ CONSTANT VARCHAR2(25) := 'CCode39Barcode';
PROCEDURE init;

FUNCTION alphanum_to_code39(
   input_string_    IN VARCHAR2,
   with_quiet_zone_ IN VARCHAR2 DEFAULT 'TRUE')  RETURN VARCHAR2;

FUNCTION alphanum_to_code39extended(
   input_string_    IN VARCHAR2,
   with_quiet_zone_ IN VARCHAR2 DEFAULT 'TRUE') RETURN VARCHAR2;

END c_code39_barcode_api;
/

CREATE OR REPLACE PACKAGE BODY c_code39_barcode_api IS
PROCEDURE init IS BEGIN NULL; END init;

FUNCTION alphanum_to_code39(
   input_string_    IN VARCHAR2,
   with_quiet_zone_ IN VARCHAR2) RETURN VARCHAR2
IS
   input_string_copy_ VARCHAR2(32767);
   output_string_     VARCHAR2(32767);
   input_length_      NUMBER;
   input_char_        VARCHAR2(1 CHAR);
   output_char_       VARCHAR2(8 CHAR);
   quiet_string_      VARCHAR2(32767) := '      ';
BEGIN
   IF input_string_ NOT LIKE '*%*' THEN
      input_string_copy_ := '*' || input_string_ || '*';
   ELSE
      input_string_copy_ := input_string_;
   END IF;
   input_length_ := LENGTHC(input_string_copy_);
   FOR i IN 1..input_length_ LOOP
      input_char_ := SUBSTR(input_string_copy_, i, 1);
      output_char_ :=
         CASE input_char_
         WHEN '0' THEN '.. __.'
         WHEN '1' THEN '_. .._'
         WHEN '2' THEN '._ .._'
         WHEN '3' THEN '__ ...'
         WHEN '4' THEN '.. _._'
         WHEN '5' THEN '_. _..'
         WHEN '6' THEN '._ _..'
         WHEN '7' THEN '.. .__'
         WHEN '8' THEN '_. ._.'
         WHEN '9' THEN '._ ._.'
         WHEN 'A' THEN '_.. ._'
         WHEN 'B' THEN '._. ._'
         WHEN 'C' THEN '__. ..'
         WHEN 'D' THEN '.._ ._'
         WHEN 'E' THEN '_._ ..'
         WHEN 'F' THEN '.__ ..'
         WHEN 'G' THEN '... __'
         WHEN 'H' THEN '_.. _.'
         WHEN 'I' THEN '._. _.'
         WHEN 'J' THEN '.._ _.'
         WHEN 'K' THEN '_... _'
         WHEN 'L' THEN '._.. _'
         WHEN 'M' THEN '__.. .'
         WHEN 'N' THEN '.._. _'
         WHEN 'O' THEN '_._. .'
         WHEN 'P' THEN '.__. .'
         WHEN 'Q' THEN '..._ _'
         WHEN 'R' THEN '_.._ .'
         WHEN 'S' THEN '._._ .'
         WHEN 'T' THEN '..__ .'
         WHEN 'U' THEN '_ ..._'
         WHEN 'V' THEN '. _.._'
         WHEN 'W' THEN '_ _...'
         WHEN 'X' THEN '. ._._'
         WHEN 'Y' THEN '_ ._..'
         WHEN 'Z' THEN '. __..'
         WHEN '-' THEN '. ..__'
         WHEN '.' THEN '_ .._.'
         WHEN '␣' THEN '. _._.'
         WHEN ' ' THEN '. _._.'
         WHEN '*' THEN '. .__.'
         WHEN '$' THEN '. . . ..'
         WHEN '/' THEN '. . .. .'
         WHEN '+' THEN '. .. . .'
         WHEN '%' THEN '.. . . .'
         ELSE '{' || input_char_ || '}' END;
      output_string_ := output_string_ || output_char_;
   END LOOP;
   IF UPPER(with_quiet_zone_) = 'TRUE' THEN
      output_string_ := quiet_string_ || output_string_ || quiet_string_;
   END IF;
   output_string_ := REPLACE(output_string_, '_', UNISTR('\25AE'));
   output_string_ := REPLACE(output_string_, '.', UNISTR('\007C'));
   RETURN output_string_;
END alphanum_to_code39;

FUNCTION alphanum_to_code39extended(
   input_string_    IN VARCHAR2,
   with_quiet_zone_ IN VARCHAR2) RETURN VARCHAR2
IS
   input_string_copy_ VARCHAR2(32767);
BEGIN
   input_string_copy_ := input_string_;
   input_string_copy_ := REPLACE(input_string_copy_, '/', '/O');
   input_string_copy_ := REPLACE(input_string_copy_, '+', '/K');
   input_string_copy_ := REPLACE(input_string_copy_, '%', '/E');
   input_string_copy_ := REPLACE(input_string_copy_, '$', '/D');

   input_string_copy_ := REPLACE(input_string_copy_, 'a', '+A');
   input_string_copy_ := REPLACE(input_string_copy_, 'b', '+B');
   input_string_copy_ := REPLACE(input_string_copy_, 'c', '+C');
   input_string_copy_ := REPLACE(input_string_copy_, 'd', '+D');
   input_string_copy_ := REPLACE(input_string_copy_, 'e', '+E');
   input_string_copy_ := REPLACE(input_string_copy_, 'f', '+F');
   input_string_copy_ := REPLACE(input_string_copy_, 'g', '+G');
   input_string_copy_ := REPLACE(input_string_copy_, 'h', '+H');
   input_string_copy_ := REPLACE(input_string_copy_, 'i', '+I');
   input_string_copy_ := REPLACE(input_string_copy_, 'j', '+J');
   input_string_copy_ := REPLACE(input_string_copy_, 'k', '+K');
   input_string_copy_ := REPLACE(input_string_copy_, 'l', '+L');
   input_string_copy_ := REPLACE(input_string_copy_, 'm', '+M');
   input_string_copy_ := REPLACE(input_string_copy_, 'n', '+N');
   input_string_copy_ := REPLACE(input_string_copy_, 'o', '+O');
   input_string_copy_ := REPLACE(input_string_copy_, 'p', '+P');
   input_string_copy_ := REPLACE(input_string_copy_, 'q', '+Q');
   input_string_copy_ := REPLACE(input_string_copy_, 'r', '+R');
   input_string_copy_ := REPLACE(input_string_copy_, 's', '+S');
   input_string_copy_ := REPLACE(input_string_copy_, 't', '+T');
   input_string_copy_ := REPLACE(input_string_copy_, 'u', '+U');
   input_string_copy_ := REPLACE(input_string_copy_, 'v', '+V');
   input_string_copy_ := REPLACE(input_string_copy_, 'w', '+W');
   input_string_copy_ := REPLACE(input_string_copy_, 'x', '+X');
   input_string_copy_ := REPLACE(input_string_copy_, 'y', '+Y');
   input_string_copy_ := REPLACE(input_string_copy_, 'z', '+Z');
   input_string_copy_ := REPLACE(input_string_copy_, '!', '/A');
   input_string_copy_ := REPLACE(input_string_copy_, '"', '/B');
   input_string_copy_ := REPLACE(input_string_copy_, '#', '/C');
   input_string_copy_ := REPLACE(input_string_copy_, '&', '/F');
   input_string_copy_ := REPLACE(input_string_copy_, '''', '/G');
   input_string_copy_ := REPLACE(input_string_copy_, '(', '/H');
   input_string_copy_ := REPLACE(input_string_copy_, ')', '/I');
   input_string_copy_ := REPLACE(input_string_copy_, '*', '/J');
   input_string_copy_ := REPLACE(input_string_copy_, ',', '/L');
   input_string_copy_ := REPLACE(input_string_copy_, '–', '/M');
   input_string_copy_ := REPLACE(input_string_copy_, '.', '/N');
   input_string_copy_ := REPLACE(input_string_copy_, ':', '/Z');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(1), '$A');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(2), '$B');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(3), '$C');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(3), '$D');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(5), '$E');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(6), '$F');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(7), '$G');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(8), '$H');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(9), '$I');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(10), '$J');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(11), '$K');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(12), '$L');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(13), '$M');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(14), '$N');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(15), '$O');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(16), '$P');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(17), '$Q');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(18), '$R');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(19), '$S');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(20), '$T');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(21), '$U');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(22), '$V');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(23), '$W');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(24), '$X');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(25), '$Y');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(26), '$Z');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(27), '%A');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(28), '%B');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(29), '%C');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(30), '%D');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(31), '%E');
   input_string_copy_ := REPLACE(input_string_copy_, ';', '%F');
   input_string_copy_ := REPLACE(input_string_copy_, '<', '%G');
   input_string_copy_ := REPLACE(input_string_copy_, '=', '%H');
   input_string_copy_ := REPLACE(input_string_copy_, '>', '%I');
   input_string_copy_ := REPLACE(input_string_copy_, '?', '%J');
   input_string_copy_ := REPLACE(input_string_copy_, '[', '%K');
   input_string_copy_ := REPLACE(input_string_copy_, '\', '%L');
   input_string_copy_ := REPLACE(input_string_copy_, ']', '%M');
   input_string_copy_ := REPLACE(input_string_copy_, '^', '%N');
   input_string_copy_ := REPLACE(input_string_copy_, '_', '%O');
   input_string_copy_ := REPLACE(input_string_copy_, '{', '%P');
   input_string_copy_ := REPLACE(input_string_copy_, '|', '%Q');
   input_string_copy_ := REPLACE(input_string_copy_, '}', '%R');
   input_string_copy_ := REPLACE(input_string_copy_, '~', '%S');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(127), '%T');
   input_string_copy_ := REPLACE(input_string_copy_, CHR(0), '%U');
   input_string_copy_ := REPLACE(input_string_copy_, '@', '%V');
   input_string_copy_ := REPLACE(input_string_copy_, '`', '%W');
   RETURN alphanum_to_code39(input_string_copy_, with_quiet_zone_);
END alphanum_to_code39extended;

END c_code39_barcode_api;
/

SHOW ERRORS

GRANT EXECUTE ON c_code39_barcode_api TO ifssys;

EXEC dictionary_sys.rebuild_dictionary_storage_(0, 'PACKAGES');

BEGIN
   security_sys.grant_package('C_CODE39_BARCODE_API', 'FND_ENDUSER');
END;
/

EXEC security_sys.refresh_active_list__(0);

EXIT;
