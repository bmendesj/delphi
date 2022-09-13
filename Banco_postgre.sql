PGDMP     6    )                z            wk    14.5    14.5                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16445    wk    DATABASE     b   CREATE DATABASE wk WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE wk;
                postgres    false                        2615    2200    teste_delphi    SCHEMA        CREATE SCHEMA teste_delphi;
    DROP SCHEMA teste_delphi;
                postgres    false                       0    0    SCHEMA teste_delphi    COMMENT     <   COMMENT ON SCHEMA teste_delphi IS 'standard public schema';
                   postgres    false    3            �            1255    16587 �   endereco_enderecointegracao(bigint, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     �  CREATE PROCEDURE teste_delphi.endereco_enderecointegracao(IN a_idpessoa bigint, IN a_dscep character varying, IN a_dsuf character varying, IN a_nmcidade character varying, IN a_nmbairro character varying, IN a_nmlogradouro character varying, IN a_dscomplemento character varying)
    LANGUAGE plpgsql
    AS $$
	
DECLARE
  _idendereco BIGINT;
BEGIN

INSERT INTO teste_delphi.endereco (
	idpessoa, 
	dscep
) VALUES (
	a_idpessoa,
	a_dscep
)RETURNING idendereco INTO _idendereco;

INSERT INTO teste_delphi.endereco_integracao (
	idendereco,
	dsuf, 
	nmcidade, 
	nmbairro, 
	nmlogradouro, 
	dscomplemento
) VALUES (
	_idendereco,
	a_dsuf, 
	a_nmcidade, 
	a_nmbairro, 
	a_nmlogradouro, 
	a_dscomplemento
);

END;
$$;
   DROP PROCEDURE teste_delphi.endereco_enderecointegracao(IN a_idpessoa bigint, IN a_dscep character varying, IN a_dsuf character varying, IN a_nmcidade character varying, IN a_nmbairro character varying, IN a_nmlogradouro character varying, IN a_dscomplemento character varying);
       teste_delphi          postgres    false    3            �            1255    16585 �   pessoa_endereco(integer, character varying, character varying, character varying, date, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     6  CREATE PROCEDURE teste_delphi.pessoa_endereco(IN a_flnatureza integer, IN a_dsdocumento character varying, IN a_nmprimeiro character varying, IN a_nmsegundo character varying, IN a_dtregistro date, IN a_dscep character varying, IN a_dsuf character varying, IN a_nmcidade character varying, IN a_nmbairro character varying, IN a_nmlogradouro character varying, IN a_dscomplemento character varying)
    LANGUAGE plpgsql
    AS $$
	
DECLARE 
  _idpessoa   BIGINT;
  _idendereco BIGINT;
BEGIN

INSERT INTO teste_delphi.pessoa (
	flnatureza, 
	dsdocumento, 
	nmprimeiro, 
	nmsegundo, 
	dtregistro
) VALUES (
	a_flnatureza,
	a_dsdocumento,
	a_nmprimeiro,
	a_nmsegundo,
	a_dtregistro
) RETURNING idpessoa INTO _idpessoa;

INSERT INTO teste_delphi.endereco (
	idpessoa, 
	dscep
) VALUES (
	_idpessoa,
	a_dscep
)RETURNING idendereco INTO _idendereco;

INSERT INTO teste_delphi.endereco_integracao (
	idendereco,
	dsuf, 
	nmcidade, 
	nmbairro, 
	nmlogradouro, 
	dscomplemento
) VALUES (
	_idendereco,
	a_dsuf, 
	a_nmcidade, 
	a_nmbairro, 
	a_nmlogradouro, 
	a_dscomplemento
);

END;
$$;
 �  DROP PROCEDURE teste_delphi.pessoa_endereco(IN a_flnatureza integer, IN a_dsdocumento character varying, IN a_nmprimeiro character varying, IN a_nmsegundo character varying, IN a_dtregistro date, IN a_dscep character varying, IN a_dsuf character varying, IN a_nmcidade character varying, IN a_nmbairro character varying, IN a_nmlogradouro character varying, IN a_dscomplemento character varying);
       teste_delphi          postgres    false    3            �            1259    16485    endereco    TABLE     �   CREATE TABLE teste_delphi.endereco (
    idendereco bigint NOT NULL,
    idpessoa bigint NOT NULL,
    dscep character varying(15)
);
 "   DROP TABLE teste_delphi.endereco;
       teste_delphi         heap    postgres    false    3            �            1259    16484    endereco_idendereco_seq    SEQUENCE     �   CREATE SEQUENCE teste_delphi.endereco_idendereco_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE teste_delphi.endereco_idendereco_seq;
       teste_delphi          postgres    false    3    212                       0    0    endereco_idendereco_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE teste_delphi.endereco_idendereco_seq OWNED BY teste_delphi.endereco.idendereco;
          teste_delphi          postgres    false    211            �            1259    16496    endereco_integracao    TABLE       CREATE TABLE teste_delphi.endereco_integracao (
    idendereco bigint NOT NULL,
    dsuf character varying(50),
    nmcidade character varying(100),
    nmbairro character varying(50),
    nmlogradouro character varying(100),
    dscomplemento character varying(100)
);
 -   DROP TABLE teste_delphi.endereco_integracao;
       teste_delphi         heap    postgres    false    3            �            1259    16478    pessoa    TABLE     	  CREATE TABLE teste_delphi.pessoa (
    idpessoa bigint NOT NULL,
    flnatureza smallint NOT NULL,
    dsdocumento character varying(20) NOT NULL,
    nmprimeiro character varying(100) NOT NULL,
    nmsegundo character varying(100) NOT NULL,
    dtregistro date
);
     DROP TABLE teste_delphi.pessoa;
       teste_delphi         heap    postgres    false    3            �            1259    16477    pessoa_idpessoa_seq    SEQUENCE     �   CREATE SEQUENCE teste_delphi.pessoa_idpessoa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE teste_delphi.pessoa_idpessoa_seq;
       teste_delphi          postgres    false    210    3            	           0    0    pessoa_idpessoa_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE teste_delphi.pessoa_idpessoa_seq OWNED BY teste_delphi.pessoa.idpessoa;
          teste_delphi          postgres    false    209            h           2604    16506    endereco idendereco    DEFAULT     �   ALTER TABLE ONLY teste_delphi.endereco ALTER COLUMN idendereco SET DEFAULT nextval('teste_delphi.endereco_idendereco_seq'::regclass);
 H   ALTER TABLE teste_delphi.endereco ALTER COLUMN idendereco DROP DEFAULT;
       teste_delphi          postgres    false    211    212    212            g           2604    16507    pessoa idpessoa    DEFAULT     ~   ALTER TABLE ONLY teste_delphi.pessoa ALTER COLUMN idpessoa SET DEFAULT nextval('teste_delphi.pessoa_idpessoa_seq'::regclass);
 D   ALTER TABLE teste_delphi.pessoa ALTER COLUMN idpessoa DROP DEFAULT;
       teste_delphi          postgres    false    209    210    210            �          0    16485    endereco 
   TABLE DATA                 teste_delphi          postgres    false    212   0(                  0    16496    endereco_integracao 
   TABLE DATA                 teste_delphi          postgres    false    213   �8       �          0    16478    pessoa 
   TABLE DATA                 teste_delphi          postgres    false    210   *@       
           0    0    endereco_idendereco_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('teste_delphi.endereco_idendereco_seq', 4715, true);
          teste_delphi          postgres    false    211                       0    0    pessoa_idpessoa_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('teste_delphi.pessoa_idpessoa_seq', 4761, true);
          teste_delphi          postgres    false    209            l           2606    16490    endereco endereco_pk 
   CONSTRAINT     `   ALTER TABLE ONLY teste_delphi.endereco
    ADD CONSTRAINT endereco_pk PRIMARY KEY (idendereco);
 D   ALTER TABLE ONLY teste_delphi.endereco DROP CONSTRAINT endereco_pk;
       teste_delphi            postgres    false    212            n           2606    16500 )   endereco_integracao enderecointegracao_pk 
   CONSTRAINT     u   ALTER TABLE ONLY teste_delphi.endereco_integracao
    ADD CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco);
 Y   ALTER TABLE ONLY teste_delphi.endereco_integracao DROP CONSTRAINT enderecointegracao_pk;
       teste_delphi            postgres    false    213            j           2606    16483    pessoa pessoa_pk 
   CONSTRAINT     Z   ALTER TABLE ONLY teste_delphi.pessoa
    ADD CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa);
 @   ALTER TABLE ONLY teste_delphi.pessoa DROP CONSTRAINT pessoa_pk;
       teste_delphi            postgres    false    210            o           2606    16491    endereco endereco_fk_pessoa    FK CONSTRAINT     �   ALTER TABLE ONLY teste_delphi.endereco
    ADD CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa) REFERENCES teste_delphi.pessoa(idpessoa) ON DELETE CASCADE;
 K   ALTER TABLE ONLY teste_delphi.endereco DROP CONSTRAINT endereco_fk_pessoa;
       teste_delphi          postgres    false    212    210    3178            p           2606    16501 2   endereco_integracao enderecointegracao_fk_endereco    FK CONSTRAINT     �   ALTER TABLE ONLY teste_delphi.endereco_integracao
    ADD CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco) REFERENCES teste_delphi.endereco(idendereco) ON DELETE CASCADE;
 b   ALTER TABLE ONLY teste_delphi.endereco_integracao DROP CONSTRAINT enderecointegracao_fk_endereco;
       teste_delphi          postgres    false    212    3180    213            �      x���ͪ&�E��wf���#���2�!8;�����7i�?9��$}��ؓ���jKG[K�>�������O�����o���������O�������_������߾|�����������ۯ�_x��_���~��FJ�l������~��O�?\�Å?�K��F�
�T��y�������@��	�8��#L �K��8����ĩ�h^�&PR��[ �?j�{�H��*6��݃ܦ@�j��@���%u�dS�"ה�oс�y���\���ʜ�rN�G�Y���/�pr_NN�Z '���95�d��m�A�b�ܗ����8�?N.5�pr�N�z�ܟE��\��8��k���E8y���ߢ�����|i��q;�_W��
N��O�'���^�
N�ɭ�p�\K�#��c��C]��<'[UWץ���8��z�}����+�Q��T�|�5ٚZ 'kM>� '���B��V�|XX�Uq�S>��5�8��qc�����
#� N>�F\=UT�|���P�'���V?"��g+~'�e�|�l8�\������s��-��L��g+�'�������"�|�N�G� N>��������'[�/��\Ӫ��E�
��@~}�{�u.P�j�+Ls���\a���T[�?"C�vr;Ơ!���+L�Jް=�����''y�r�i.p�M'g�쵵����0��S2u��qr��u/8'�:㜤vr��9���89��״���Ì�qrq�'�O6S�E'�gMN����r����Ϧ'�ܨ��8��������e&^�m���89 R8��y��X '���"u2prY�dyv=pr�յ~�9pr���!>�8��}�zu��æ�'׵O���X '�V8��S(ur����~N�=lp�亲ky�~����U��pr=g�r��5�ɖ���N�lqN>q�=N�Η�8��|�d�����ɶO��c����1(���ɶ���N>q�=d�uګ��v��E'NnkMV��i.�ׂ#�e���N�ď�0��:��	�\��fS�4hQ�h�i.�x�����߀�����pr[��I�? L�:�k�,�������ƫNƫ�"������?b!Ls�Ek�,�4hQ�4�a>��7�ei�oQ�侫�����@ؚL�fu2^�� �W{M��i.�iM�9a����Qa�<N6��0�Vu��	�\`f���s�W݌WV;ƫ��x�N����ƫiM���ƫn�K��x�c%^��ƫunc��h0^����ƫsM����i.У�	�\`s�j�x�c��j:�0����L��/�ƫ>���g�A����U�˄��U�|a��U�0^�a��q�4�a�W��W�/���^�� '���jr�0�,�59�����@ܚ�e��_�#Ls��&���4��]&�����P�i.v�0�Vu-��a�,a�;��݌WjH�prNa� ��r��a��a��=!Ls�gM���y�'�� '?�W <C��a�5a��N�lE��8�7P���"/ˋ��-0^VR��`���9��&��	�\�FAńi.`q8���K�����x���	a����'�0^�����78�a�`J�4��l:��E0^6�ܚ���񲺪k�#�ɛ񒟈�x��x�Z�'��P0^Vw-��`��+f�e5����ΓKU��89��"Ls���-�0^f%l����x��h����&�/������C�v�:X���*a��k�,80^f;�V�e�x��xE,�0^�0^�&a���d� N~/�M��;a��5Y^����ʮ���i.Т�w�4���Nv�i.�;���4��|�ea��Q�´�
]?U������n@���V���xY!C�8y3^�A���xɉY�4Xw�ԻL�4ˮ	�\ �!Ls��d5�C��U�ήկ)��=�W֧��i.����� ���%7�\`��c���&C�@+a���ԑ0�F� ���8$"Ls��]���4�������+�����*`����d14@���J�p�d���B���ˎEkV�.�0���M>8��w��s��a]r	�|����AA��9
�#Ls���_�k
�e���|6���xɋ_/;�
SWv0^6��m,��M�K`M��;�Rg0^6�x%��a����%/[`��f���>a����$Ls�u�Qݿ�0����[(���nP���J��|:��WUR0^m1^�np�i.p��0^-����ƫ導|�i.P����g�z�%t�4��E��a�&a��u�#Ls�gM��� Ls�#N '�>^��F�4_u�S(�q/a��u�'Ls�6]�x���5�#��eg��� ƫm������"��x��x��n�4�ٵz���6�%�Ma��K/��a����%�x��&�x���K^��x��x�o�����'�|���>�RR0^���d���\��d��0^�>�W{�%�x���EƫY	��`���xE�-0^m��W0^�º�����U���a��њ�i.�T��)N~����i��>OOׄi.p;9�v/a���Z}HD���Wv�i.`Q�a���	�\ ��&Ls��.���i.��d��O��g��0���xE�7%Ls��]�/8��@��d�4��C����s��@�ڀ��@�E��ada�a�)�W{��{��i�^�x����f/�&�0��n5��@���\ '�WE�&��i.��N�J;���[`��K/�k��w/�#��GB��9l���j��ҷ"Ls�02�0��>Y�ώ0��Γ	�\ �.a����"Ls���?�i.�]�Y�}��0^m}���[-���V��x��K��vZ�[���+ �!Ls�}J�Á�j�d���F�4�E�f=�qׄi.�/�-�4�5	�\ ������U�0�v⥞*`�z
�I���[���ƫ��]�Sm4�>��6U��8�a��Od�� ƫ�>^�V�i.��5zB��5,/���q�a������\�i.����^`�za�W��~���
a��a��W�}�jV_&Ls�0�0�v�� �x��x55�E��a�5	�\`���քi.���۪���;˄��ef���ƫ?����0^}3^�(ƫ?�W�#����U�~���ƫ�Y�4Xd��3~�i.Т�"�4��a�<k��/a���'��ήa�z����8�R�l
��-�P�i.P�}�na�&a���!Ls�82ƫ�>^�� ƫۦ5� '?�WX�a���$^j����Fu�H����r��0�¾�L���Q��i.�d�4hQ�)a���p�0�v�\���o5���yC>��'��S(�4�Q+a����8��6%Ls�ܼ��C,���+��<a�̯�4��0���N	�\ �k2�i.���x�'�>^���Y�}��k2�Wa�d�4؝�8y��
xMa���s2�Wa�&a����8a����P�N~� ��0����K&�W���ɯz�C��9�l����
x�`���x�����F�6�0���B�����oN�}����i.�;��p�b��-=Ӭ�0^�1����p��0��=����;�W����6�W��k{���,�0�6�)�8y3^�f�i.v��0�^:�p�d�Zj���r���jTCńi.�:���"���x�#5��jؒ	�5Rܚ�5&�USч0�zX��5n��jy��5	�\`�BYRR0^#͎|���i6r�7(�\ �^0^c���8y��
�ɓ��I�d���x�+;��eg�C�&�x��x�w�0^c3^���k�o5�_�1/+Em4�Q��F�k
�56�%Oa������婮�>u��%�
�kl�K}O�0���p���ծ�N,��o�+��L]U�x��>^�1����W@^�5��"���x��������u�w�0^�a�(5�4�	�\ ��5a�a�/��X���2a���x��' |   ��@^q�z�5n�+F 'O�+%�5�4�=CԳ)�װ8'�x���"$Ls�{��uOA�48�N����k�q3^n����T���&�e�O�,.��`[���!p9�L�Z�������R�          Y  x����j��}�bvI!K�G]��CI�n��H�dM�e��72d�f�S/$��E3�V������߆����:�v�ݧ�n��n�qw����p��u?���f�~����}x���p��<m���|t;N��|>��_��Ώǧ�}���w���i�a������oruq�vx��߯~zu��3������y����8��G燇q�����8lwÇ�4ݏ�S׏�p=N����t�����8{�_�����"�����4�yxw�N��/�^z����n?�=\�N��0>�˧�����G��=/�Z���_-�wO��vX>=�O����[���:X���:X�������`t��?lr0������������������K��K��K��K��K��K��K��K��K��K����?��Z�P�j�C-������?��Z�T˟j�S-��O����?��Z�T�_j�K-��/�������Z�R�_j�K-��o�������Z�V��j�[-��o��+��+��+��+��+��+��+��+��+��+��k��k��k��k��k��k��k��k��k��k����������������������q��?T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T������jxC5���Po��7T�����jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To��7UÛ��M��jxS5���To���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jxK5���Ro���T�[��-��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���Vo���U�۪�m��jx[5���V��I�.^��u��S���y����8��G燇q�����8lwÇ�4�?��׏�p=N����t�����8�O<�OT�%������<l���qz8��ƿ�z�a������pu;�_���m�W���+@�      �      x�ԽM�f��%�����f���`0"H�ʋY4`���[��cFꆤ��������f�7On̔Z]���._���ǉ�O��?�����O������o��ט��_��?���:�������?����m���Կ��_���_������������?���?��_������>���������_���u��?���������������Ͽ��dB��������Y��o�������c��E��?R�#�?����?����������K1�1����W�/�U�W�*�_�$��_U~����h$�d�~��}�_�dD����3�M��{k�k �T�N�E�����QJ�<k,#�2��S{Q��Y�΂�1�;;��-�}(%�w�EY9R�^�5�H��R9��f�5#��}��Bh1�Yr���}���b!�������4��|Q�q,l�r�R3I/�C[Q��
�FL�?���e��^Ò�mD{�L����xgg���X/ɿ?�6$vkQS*�]��Y�X��3�?��Ύkf3-ѿ���9�&��Bc�"k�2���\�;+f#I`i�
L�H�mk$��ݙ�!��3�gV��68�O\�6B\�}x\M(T�R�"��YL֢�(k�l9K_c&���`A�ڙ��ܒ�~gqQ�9�@5�H��Y�6%���xM�w��]�Y�g�%g�V?s�ZC��jy�_u��zL����*�;����4��d��/=����2lw�94J�������mYioΆ1L�M�zg8� wvF{g93����д�$�r�<��-W��es�2>��8����� ��D��LyC&��4wM1���ښ+ԞV$<gƱ㔗���S8�@'VVZe��lc����� -��3��s��)�E3�	�\uᄲ}�f�3�����F+���<r� -��hl�hy�ƨ�m�4-��f�<�e�7���{����n�3���+P^.�y��TNM+��*�ÞSle���-�0U=M �&�ѬyM���{
�m�x��3�h1�ƄH~u'-� v�O^K����Ց����9�L
���������n����p�c��7 �#���2YIZ
̅4��ٰ�ӬY��X�a��QY��w����^�$e�YZ��e�N)�%��\l�Ǣ7��h4CVJ�� ���e�wg�X�K�����A����J�=��bЅ���g�sRקk.� ,����nc� N��"��� 9�e�93�&VT���5M�c����Vҹ��է;��^R`�~�����g&!��Z�O6���3S|�PQAX�>�^���*�(���l| ֝��wgY�m�k���g5�V' )�O�1�m,�gP+nL-3.�jx�Z۾��oqj�7�C����a�~\�i6Z8ঃ�Z��Op����Y:��i���4ւ-�t������V�O��3�m����� �xf7�X���E�J���Q{y�'U<F)$[s�c*Yl\�`���f1�n�A��i�mq���8����b-8[��qE�b-�;|s`�h�4K�����m|1HLR@=���@ H�� s&~ ~	���<*6 )lq¥�e��G��'��r�6�K��	���FoV= 	�r_pl����gX�XV��Q��v���|8ur�Owp��D�T�9Z���>�S␀�y%��W���9�*޹�9���lt��G#��>��.��V�<l>��[��a͈�%�\;X��L_Q9��wnc~1Όt��Y��X=��C��T��,�+mG>�gWqc~� L��}fB 0�`������ȧ��)7r�}�t��em��p7��Lna���A�a��9m �Ij����{�����������J�qseY��9�G�}f' Bv.��	|Ѫb#�ZR��s��y����XS[ýxgX���--�����-D��\���}�pd�.��@&��p�6&��|����3���'�1�6>v/�u�����;��p��9�*����֘��-	���c1vgg/������6#nhLh
[Wa���<$��nnY�S[�x{iT@��c�����ҵۘ_ܘ$��¡M������ ��B'������"~ \4|M�UD����!Zxs:O����o.&�� ������.n�c�K{�Gڱ���δ �0rR�4	�s�D���1����Dx��L7����f��R�+1�d��D�>�!�eO�>��,�� �/U����Hj���ʋA	���{�Tc���|}�:�8AKyd���^��R��.�;?ϭK˽�p"��9�;��������F��맩%�(�p���:$���x85;��b
����s���ִ��j�a�s����7֙�P�a֖$0j��i��~?�-H�c��+o$a��Ϛs����Ľ��d���sY ��SUny�r0��T�՟���a�

v��ê9	��}���eGė�g�� ���1'���@Ӭ.@��� p� y��D����)�IԧL����ݙ:?�u�rOþ�ͳ��K&O��@��4� _�}����q� ʎ]����-,����8
�LtGR�vV�Θ�f(��6��j��rѠ�����Y�'v���t�ፃ��3m�T�痙�� 9ੋ)�*,���l�3��9��y��sW�c� ����6�Vn<�Oh>������wt���j��A�7?@��Nu�7�C��#M�R��*^�)Zu%80�7�=j�̩�RSꬼrN�����q�[q}|*7Ir|�,��i��4p�L�[��j����l�q�i9�#aҼ���d���K�ËA��0�|����Z�u�{���Z/q>k:/@�᪹��t�z"��	��]ɥ1�7���^��Ҍ����-� !�X�n�Quֲ&%[��B�K}J�� ��ѓ�L�Cy�,��_����F�?����Pey!����%.. ����?�ڥ�h_p���i�=w/�0��V����������<��=8�|;��I��7����^�o�p� pfD���#���,X@W�M ������Mf��p��%�bV����3?q�;���   �^��-؇�QF'8��T=ۮ��hk��������z����+����
��|o��{����8��:Z�� �)�<B�h!>�!�6'LHA�L���Z�����C�
�v%���6�`W Ŷ�0�'7�s_+�k���|
�v�L�ּv�n�����4aN���/�X0�$y&��3���"ֽ��W�������m����xjRSɖw6�M�3�2��]:����G�6v "�U�t ��WS89o�!����kg�b����U���K�_`V�A�)����%���* X邫��S={1�.j�u=�y�6��"�ϙ�Z%��ȽT��� p�n��5��,^�X0�D-f���?v�M�� .\Sn�+�H�7$l ���p���`2΅F��V$���A���(^��4�S�Xp�h�,0{��ϫ!�q����D�T<ك㽾0��6��]�����X�����9Uf�s���xU0����mEG�l?�Xܪၓ}+7���gAV3��jڬQ���d��ل�J�yV�5��Հ��{o�>�.w�~|1�=�� 5xi���{��?.e�����h�?�a ���������GO}���S��(�5� �<�v��o�UN�OT��
ځ-	/���u��1PШ���7�wlc�_�T?�'z�Â���F8pN0{xk�_wL�5_����_$G}{�Ҝ�Œ�Mϥa�V'p��V��h�, ��*���`�ϥT����٭>O���F+v�lՉrLk���5)�����������8�q�5�q���`g��3K�W�%oD��-/�YÎx� ���c��{fO���'���A�G�0�*-��W`�)YŹ�,�������դ�i��	N�T��Gx���8�DC"��'zS����(״�w���N`-���mc,8    ��pn ��jJ�X�;�����?F���^BV��� �9z&���h�N/d�=���,h8��*���Ue֚�[��\�g,.Y��A4Z�7�; ���&� /� !�
�f����"�~�Mk,�r�ժ7�;����z����7���^�,�,6AA����&W�{�����l-IsR�����n�0j�;�3���ĳ��� *�n˝ڎ䕒�V'��9���Rit���ե3{� p���g6����5 O�� �-u�U.���,݊�q�Do%M�{����z53�P�㷆,�V�pC�����x�ȯ��避���&5���ƍ+J�����_'�[�O��;c�-�R���Q�͉���uz��kA������,���8�z�{R�uF ���k+s4��l��5O.��٥�����Y�]#�#����3��{�/��~g�R Ե���s��mT1���y��%t�'�-�ƍ�ݳ,H	�pX�V<>��*[�D 8A	z*�L������k�`�r����� x2y���N����Cg�'��e+�=���걸���� ������ݨO�^�K��0��mO�C��V*��LQ���� ]�ؿ-H�Tw�����ж �F�C��wZFm�*�0�k��PN a�,�x|Y]��+�K���1H����,��C!�8p���O����s͚$�ћO֜8ȥ�`��^?�f�����Ǣ�E����6�� aegsAhz�L�hBz3���8���N/��mY�W'�/z�^�_j[��Ѭ�g�]AeL�0��5��,a�m��.�S���`�t�A`%u�v�P��R����!m�\�jJ�}������~���U�_<Vn�{�`^��=��i۟��;s3��T��^�7ry��� �(����I�c��V'�y�4���^�j�-L�V�+W#�����aS� 
*�#E����]Qv�S��D*��{�7��h���y-��\`(J��[c����J��,���v�q�Q�wv-��N=���z��6���`[3��҈��0�@���j�� �(����J�=M憻[���T�v��Nڮb)pW��ǲB�
��WY��W8�3k�\I��q��3�9��%��`eys1�=/��Fk^�{����E�1J�@��4}�f��k�QNM�&����&�!.��8GOb��V��?�Y�/��t��hڳk3�Q˒�ؕܪ-8:��4Ȏ���?{�c-e:���"�X���Б&@��6N�������&R�xg�b� J�U4@F��-h�a)T���Fe���#wwvd���^���g�Ik��q��Q#���zG�I��Ŀ F�5�pmc}sj�UxtR�S��S��,�ЈS3���\3��kn�ًA��u�,�*��W�(�`�+_Y��8�k��˥l�A<�����0QSk���ɸ� Q�ض|��<K���Xz�j��\(d�@ra�h�� �4�O�ܾ�G'�E�n��+��L��0#
� w��j�r�e	 mm���A�ް���2z�A��`�U�qƦ��"r1�*i�i�7��p�*@���8�j^�J�8�����;F��p�e�r�J�Sg �\��}����Non"�7Z�&����0�K�$��^+�q˜a'"{*%
qӅ���~�F~z�/���(�����-�cڙ,�Ew/݉�`�J*�w}N�Fya��
����o��s���^�Я�\�f��x��h����{�ESCή�]߾���W�2]g����t`Op��{�-��u��b�B�h.U�&��U�W`Q�)�ƺ�<G�m�Z�T���@Y�����6��䣓Z��`[�����S�� ��h }�Zf�t�m�ꃄ��O��2af(�Tf�~�рag�t���!�!���l����<@�(2^aNYGѼ�7�C���L��,��p��Eȟ�%�$>:�)d����q�e@���$.V���0��x͓��S�T�bo.�}���&��zhJ�p�AT�x�Q)������e�o<:�<=�b�d�[̤�����"f ,/[��9�ߕ.���h�gR|n��4G�>^DU�7u�o����v��(�ɕR�P�C&�$��L�5Q�U�o����+]�V:0E�ь"�	���ê<mW����d��0���G�j�l��+���ک�.��3�`�՛x^4�;��Vv/���l�M�v����������j��e��[�K\?:�,�s�c8m�~Y��A_�� �v��{7owW�l�F:r�F�Ӓ��B���`y� MO�2`CC�ZG#΁�w��Z���88�z؝u3��Le ��>��$�U���e�[����Z��j�3ȇ��J��f�!e��ڬ��{�������Y3�b���/��r�p⧶��7^R�8:�.#����CM�	�3��h���jy��Vc��y�	�1;�Ai�U�]{����(yݹ�G'�D�!xb�;.uN�%r�� /W��y���0�دw�e��������n������ѓi�M�U�|��,1x�N(�'3�`�t��-�TrtR�"�F�> �����o]l�;ޝ6�գ�:,�<d�д8�X͛��ҿ��oU(g�w���I��	y9u�µrHn���3�K`2����O[X8���wP�F\M2���Pwŷ*��wM*�<�*7����!<�=�����=�NX�OkzZGr�>`P�l��T~[�k�L�Ԥ|Ѯj��C��`����j}�RB����ɚSwu	��T���[��mn�U�������_��~f"\�g���Ē�7M��a�l�dV��4�Pu	��?�I���5�U��
��pP���*�����IYѷ0Q���Q`���ec�w���>Y�+]��~�r4]��g�a�;ȉ�U�'ݛ�
K�h��[m������'�K�إ7��F'����wnc	_V���g��`Ť�ڡD�cEkc�k=>Ys��:,��u���k�f�)�k��\|�'� 7Y̗N*�� ����\�ҫO��\�j��i|zo&�Tp����c^�5�Z��ک��|����������\��]8%�6S��gֹ�t�>H|����5|t[&`������p�1�B��ӧ*�>H�/�4r�*�-���eڝ�wq�3�B���ygu[y	'��~!�׸{��ڻ�d{���L�⣓��q�ez���<���7p\�yϙy�a�^��ʽN±#0j�C��A���1HI�q��r�0%��$������S`B�{f�=%��g��lP�S�<��I���-/IJpG;�SH\��⃋���Z��R*�[ӟ�W /����s+�KO9�����pQ����� 1��ڤM�4.�c�5���e-inm[x�:i����e@�Ľ�E�P徧N!eJ�!�x�5C�M�a&DH`x���v��p9S���i��	�~�=*]R�S�R4�ןŨsH6Ǌ����q��+�O���\��������TK1Q�{��C�U�dz�D�֡��}�T����E�=.ؘT���]��t�^a1)�8��'�IQ��*�( o�8����u��B�� HQZ��\K�2����֬�SG�.��g
o���;��'�a���|4�%���sIv�D�@>�˒�\�O�'��~�A���;�����J�S���Nv����.��ᭃ��q+2x��f�Vm M���Fu*��w�X�;5<�褂����2gtA��{��_[^Wl�,��<���w��t,V�1�p�^p����v��2���W���
��ݨ�g�g��JؚS{w��Z���#*��"z�Yx��w���IM9��,��u(u���&g6�e�֫ڻ��d�x]#�'3��\�J�� ��IM�;������� `X\�Z͖d��{�,w����t�f�֙jN��(���ܪ�N��A��RleʹV,&(ħ�z-�ZL9t���ũ���F�m�'�C <·}k^�ItjR��y�����~7�����}�O�����i��Ԍ P�+;�L���9�0�8�T!/�g��^v�)    u�U��HeM{�'k�?�-Ht� d�������3��(�'�J�8������U�6�W��@����P�����I�U�sx'9�{1h�M�Q+�����;�xj8�N3�Ҕ+�-�D>�hY.��wf�Qd���N$�"{,��{dr��J������v7�'kn��ӛ�\��U9�����f� s]ym����$z%���X���#��ʺ���3g����3��Kz���y--g-p�.�쒍�ӧk�տ����N*�}z�涊�3�S0�*����6ެ������>�.(��+��W�9P��\�=O}�Ap�HN�
��k�r�S&�+�QaM�q�4#e�� �����D��	�������a1G'�����n>�:�Z��6o�䧐����LO�:;�wXL�S�#1�٥�,/J���������?]s�ݩ-H�h��F�f���Wޖd��>�+slԗ��3�����N�;�T���[e��-��\S�^{����3u�vO�0}餲�<6^\��xY�E!�'W�W��<[�P���s���O�x%�`*�A�[�Y�S����]2���� �b�.����Z�q�B�G!�T�j�4�����H�p�]�sǟ��h��z�W��+{�m�H �l`�[M���e�}��u�_�|����z��wf�n�}yj.�K���s_ࢂ�k*���x���n�'��@��&x� r�*G����������;��褖��j�)(L���|JNpc���J���+���.�+���x�+ܵ�L����n�դxr1����� fA�� ��{1���&�A��K�5|x��4J�On$#b��::�񱻶�\�U�#��A
ՔK�k.�~���CW�֤��`@�L�oF�_��Q��tfG'��<ˎޤ6��&s�1j�b��v@Zo���p`���S��%�꣧��*��#lq�Q
O\��A��q�Dlp��j��L���5zM�p��ρ!���[���.��7�Z5e�a��|��(5��*�ZL��}��}��2��tT蓤W�%V�Xzc��9e�nJ��!�񚇟�K=��_���U�i�F��pR��f��pۣ�w�ܭ�ttR�x��y�ns�pݦwJ3J�[��CD|7��_������z�rl�ԡy�FW�\h���������̋�D�FWsZ���G}=�f�Հ�˜����3��?;:��&���0<�\�$�x>|��xsky���e�
x����0�@�RG+���w�鍃������<r��񱀒)��؆#cy��z|&� �W0Ysm�>Y[�ul�A�褦t� �5b�W:�p>�"=I$8k�LN�A�7�^T�]�&�;�k�p�|:~�u|��*�Tf\�]G�o���,�O����w��'k.[���
_�*�Շ+k�5�(O����
�DX�v$��X��� 
�*M���>��ڂ�Bg�Y::��ev�8�f,4$�Ha�]a?������s�:)�(X4W��48� ��?x�;���:P��Y��~2\�������?��Fot�2K�y�%�)���u�ZʷNj�V�^�[��y -����/�b��F]�����vIl������v`�ĺ�K~�O����I�\,�	��G����հp1a�z]�z��s]��d�L�Y�n�G[rs�)�
�ttR��)�fk�ǣL�*YI��&p��|��Dx����b�Ti�PL��㋰�����<u�0A^���>�F���^,�=�Ơ�ZO��\��Tx����x�p#�`�}��X����Эw彟xwD��eW�1�����S?�������>�x���K���>�V�yB^xVމ��Y�^*�AX���9aM�����R�����o�cm��������PL4���� CF��-�4[�����x��N����xez�?2�
-��:�7~���z�Or�t�6�� �a��%�|���:/�j� U���h�����������T|���=?L*��2rjR)7�
io�O��R���� pf�[�6��d���ט���T��Qk� �����_%
-=�r���VǦ�S;:H�.GJ�����ܾwvKk"�T�y��1�4 �(H�w�|4��[7+�}�f+�ȭ�߱y�`��T3Z.�_��
�@L}#���ڵT�~��2`�����~��pK1/��D������A�\�6�6�<>�����빍Aa,�p�
�&�	��L�
~H��.rj��ㇶ'��P@�h_j
��p��:ǎʉ��*k�T���s�N�b�װ��I��Զ�X�#��w7K�+[�L�S��Р�5�+ל
� ��eWgn���X�FW^m{ǟ�q�s�	8q�>x��)Xs�.� ��>]����-ۨ_ss�p�%d4�f�S}�R�5l>�ɚ�����#~R�%G�T��j���63.��i����m��%N�75��mx?o�4�^�x����d�]�`����n�<�;誤�S����9��L>�۸hI�e��_E���[�T��u���i^s�3O�%�
y��B�c����vu�&P����V�,��|<�ފ~�Wo.l�VV�!��I��� =�).�'����6�J>��#&��p������5��b��ᱸR��#�gR)Byԍ������|�3YU���^!n����[�� ���{dy<KWl��i��*���Q۫!R���c���z�m�U[N`m?F.�F{� ٥��.R�$��l%�1�;��+-� ���Ӓu���k��}��{\�w�GoU��T/�݉�c�mĎ�s���W�>߬�kpn����"唽�_D`��[���Ϯň�N�������
̸2�y%������ٓcc�3�4�Vxa�^�>}Tf?�F����37T$��"���e$O��L����77��1�L�e�=�c3�p�mN��b�A�p�/�TH돰B.�ˋ�-����h�${�>]s�.�b���0\���W�/\�����)�)�%z'�>��,�� �F &���P��Ϝ�܉7�T�����,>"�{�g�O�AO:۪M�V0LK=;|N��@�:X7�'Ƨ^n��!<+�ss�A�c�'�\{f�hIo��gȔ8��.�ͫ�1�Y����-D����s_�vs��yr�������[��N蘋G%J�)��Ⓨ�Y���{g�0ȗNja����w�5<��2q��z��Z���<�,9V�Lܼ�E�����C7d���G$������f�IP/�s��2�GӪ��0 �c��59���.e�1з����Ϸ�Y�SwE��[Ѽ�G� �>�+��I�q6綠P#
w��f+�4��<��b�m���K}�G'5�����c%�V�t=3:p��J[�����%m۔��FOO�@`ơ�y��l#�gT8��}��>� )=�F�� W�Y�ϣG�"���t8u*������ +��/�n��ܹ��� @��	��[v�����p�7�{S�S���k!�3�ן�(������:3�FXEW�|g�9�K���*9�*2|d���.V`�ICB����'2�O�%~vtR����,x������r��ZH�������Z�75����=�>2�Ǚ��'�^��9~��θ� ��x)y�ֲHq�SY�;��=�03��~�{C��^߮��r&td A���a�3�.?s�����p����愳I��܀?k�L�{����g���-,y+yuX{�&&�Cp��,=����5[��Z�wy1\n
�큇y[Q���7�&�U;��ź������	�w����K�dؚ�~�	��20o�U�.	f$���[.&�a�w���:�P���,
�2}PӜ,�����\�)o.���� ��%���F��f*�xF ����ޭ��u��`ur:̓�Z�;��8�O>�yj˃"H�Ouk@��e��F��M�4�U�K�.�эge��Ox����ɵ�əp���1a�0�'%����b^�űU��K����    o�l\�,�N���#�:v::�*�`������3��
9�WՇռ;�RZ�y���;V�2*?��]�����3;9O����ww��F"�T�v(��-�FWx`�X�p��|-�1�л�����T��~�6:����@O1�$�J�d7�9P����:��b%���Я�� �;��Rδ��S��� ��Qu�a���T+���ߩT1�Oyíˮ�a���-�����-M	�7WHt�!/� �$O�S�)ŉ�	C�x��̺�v�6��I��W�+�R����7�u%1s�"k���yE�Φx5��,��V�E���t	�H8����vױ�4����i�ܢw��hc����HFa���.���7�G��
���N_���	��JI=��'vV���/*鮈���j�x��V�Nj���~����fv	��3�^K�Qu[t��{�#ܳ<��ge�H�����^�I�Nj�Ґ]��jΡ��zu�>5��1��s�w��D�=�󖧖��b�����I�6�H' ��(^]w��EiG>Ys����I��u9�yj���ӹ���TUI�5Lu��3R�"�%�لK�> M\�@ډ�ۣ�v�6��\��G3���N-1�%+����SX���O�m�;9:�`0Ew<�ۂ��;�H�Ǫ�q�@NK֮����lK���+>�`˛�玕|դ^���IŽ�oo�h��e�z�b�H��*�:���]~���Q2��t�P6�?Uw��褒��옽��^*���<Z�^T�[/%jU�����\Z�V�5J�z�>3��τN.�l|�dlH.ݕ
<���b�ګ��k��rIP�h����[�GNN5ǈV�b��W���P�<����}�^�2|N)-[������Tc���g���aU��.��I�$���iRxL~�Zr�T]`H�ư0μ����Q�zs1^a�N ��Q<�����0H��W�v6�X����\qD��>#��E��Fķ*ʄ�8�IfݳG�i%j7�Vi��K+T@�}|O�vo2L�ƅ��yd+̊7��09�?�S�*VʮP��%�6>���h�$%�q��Q��'O}�6��6OS�b�����dJ��XM�՟��|:�ny�r�O������l��i������mu�o_av�*gͅɊ:�R/��K��#��u���Z���c�Q�;�'Ț����� wwv� �˅�Rcj
��6}�T�X�[���|M��],:.����P�_�Rg�=]�������w�P�q���{ʚ�&.�y�x|<5��@b�w�O����6��퇺+���Njf/B�hL�d��Yvk�حG��\w^Tq��%W �����L�Pg~���>��ҙ�� �U4��h���%���ra/�a�0C�՝�33��h����1@��g�����N*���]�ه�i�щ<f��j��\��5;˔ny꣓
�㞢W�p���>��_��>��0��;�T�0�յjbL��Zs���X?^�XH<� ���3X��2�R��T�m�s�R����W}�:�w(n��*y����~mc�7�S�Nj�.���P�Q���cB�
����A䳩�;4�ZX��<����o��g���� ����H$�Ҥ[�cj����Uj^��ˮ�I�l�
��~A���Zm^!�ZN.�������T�9�Wk��b��o6K�;�1��]�D��k6󌷢rLg>����'6��O�>N$��� ���S��y�r�vv0�k3n��wRa1x
d؈T ]~m�:�+z�N.����W�!3�Z��O}	����آ��o�Ǉ�Zv�5s��[^eg?Ys&(^�g���-Ky�<K� ��k��3R��P*N�v�g3-J�;s}�}����ޢ+O��϶*���o.��hk��H�` �,9���Y?��V?��̳,!��r����V�`�Kl������E�/�2G��3���|��T��>����W{��j��|�Et�� D�n����;;;���$o��M^�ܯ�G�|����s�����-�s�uac?	po>ԓ���T4��F���j盻m���U&�2ȇ$rMR����	<&d�!k/�'���N$�S���
J���s�Y���3ZZ�y?��?Q!}5Z����w���� C~8��i�k�0��������3��/n~��� �� k<.`=>�Q�r��Lқ�	����S�΅
����<o�	'�R����SUʭ���I-�.�*�.�_̆7Ѩ^H`.VSl��'��+{q��XC�V����ٿ@��T���V�,{�\_���������m->|�%l'xK��-oR�惑kT>}�ww&�V����H����9�'4����K�}쎟O���ًAJp����K����Hس�Z�4�7X�V����+�
���i⸣�"bo�Z�ut`�<J;��ag�(S���rI�_�Q>��4U�5~b�mtu7����f�W�#�Ĺ�U�o�aq�I3������kn.~�1��H��W��}�}&�#���-�P]]B�N�a��k;zt���
;{� ���{�CN�ڈ��؈y�A֦��UdR��9�7b�ǹkx [�D@óZr�,}`H�?���V���I�������>��L��L��ju��I.U<ӏ2z��EA���#��A$�yX�>S�G�=�Jиr\>�.m�CO֔ Ȧ��W��q+E闸��$ &m��dzEc-L�R��@Mve�VwUK�k�^���;�,`j���)_�Iw��}+�lUR[5k�%@�1�PF��� �g�a��/>�i6pj�Y9e=������� �@yO��jYa/I,��)��	q�}��n��|�z^fk��F��mN�XuFX�d�}1+b��3��gj�U���34�w��N���I�d����c�qHH������b��G��a4�3{�Je*��K�{�tjR�鋹�<�Nj0���*V�)� �6
�~>R��SѶFZ���AM�L��b8U��ʽ�V:������U^�ۑ��^��gL�@�����gf����N�ybwW6�����6�i���ՇTD��7��+��1�@6#f���G\v������(3|�~� �qL��Jp[nL�f ��u���C�E� �Sqژ>歖��������S��q�v�7�3L6���<�c)^���4l�4#-��U5D6\Г�	��G'O?�S�R�^bD+P	�*/�$+0y�O�l�|I�]�N���$~�2#�۾�m�����֧�(��Q+�d�>zW�r��b���v�'+q2�W�,�0��J쮝���* Qs�'�\��b��)�9W��I���<d�.���c� �mB�d��������K�rtR�]1������C#7���n�j���O�l��[��rtRc��7�α�b D�<`ʜ�3��s19�<��W]����9�tX�^DWv0��w7>/���X>V����>s��J�xc.1�����˞�RF���о��7��G'5���d�X{.Z}��4&��� _� kZ�	�;�����%�T\q�
q}{� |��s�<�Sr+>�!Pq����;Ip��#�S�J����>(=c_|�R��\� 2��7�'�E0�>��H]8Xs`{�Y$����-�h��˴k�7�{y)�cy\0MR����a�3�ũ�胘����`[��H?�kQV���;�.¼D�N��Z*T��Ӫ8�6f���-E{�A��.����τ�:,U&[U�v��f:˨��:��}�k� :�t���3�����IeP�)��>�O����_V��ccp��ֲ�01m�9�&�ҁ�xԤ%p��U��3.��rj��������l���[ĳ�`l���U�)�ؕ�	\�&d��(��ѷ�T���x+�stR���� X����'o&�86]C��Z��y�!9%�֫�ܓ5��%=��ԏ�]��哋a��!��O�+����J����2��ʜZ,�k�=������0�<��qG'U�N*؈S�    m�GI�b�	1䉧T9W\ٱU�llU��ѦV�_�����u�_�(�g^��7n���$���-����x�UxJ���kN��%rtRqHR���*Ar���C eI��]o���:<v+Z���A$�=���Zq�b��^�f��c�]v�9����)�V%�E��A�V����臸#<aR��Ʋ���:k��V�\>]�w�U{/�̎?���9&������u���9�5v�zB�${�V�Y⨂f���tn#=���;{kR}�J����j���	�	���7H`��SU>Ys���T���I6�����H�s�F﹝���u��B5./���#��+��י]��*G'��x�Y����bb���F �N�-︾�+����*c�	���
�j�zb�;�}'�X	)�ƍ���%=����V %�f]�F��	�Y����j���NGk;,F�iH��I��^�3������gu���&i�DA;N�Te.������#(p.p�äR���ytR�g�S�7[�Zi8��R�L)���L���q8��fe�.��H��Q�;��褚�8��-�I�O{Us�4A�X��{��3�m�Z���h�j`\
(M��L�����<�tRs̯�9Y,<�A�pѼ����>�_��?[ގ$F�8��ؑ���Ώ�9�xK}��Q_c��9��T�A2ף(���4�X �~Bk"���\� 'c
k��S�` ����EZ�5�P*Jݸ�rP
��Wj�w0lPV��x�,^��::����~�Cɀ�)j�Q7ݱ	��9ב۞B�ɚ���\L�";F<��JWa�\�F;e�Q|���A\:{�
�'��Z=@2�>�J�L_grgR��T��$;�^�㓽�'��`ե��w1h'�%��X�pN��`'I=v�=��{��`t�����wd;>�
���D����wwӶ�P�0E>jkfv���1���X���Gn�F�t���;��,W'��5��.Yj#���r�c&i��xnW'�%9l���Y�����&�jݨ��V���G��5e�\v��5w-��tfk��Xx�&W8`�͓h�v"��U�3��6za-\�@F��i΃��_�~k��YW���Liu��U�\A:�M�رs�g�8{����J h8�Y���tR5詚���d+&��\3���F�T��l����;����t���v�r�G�!=���l��hA��#� ����Cƾx�hq\�&R^�WPа5�>��n��`g�,�"�^m{���I��ũ=��i��U˰�O�4X�觺������'�R�[�N� 'Yx����u]p�Խ�X��ɭ��^���uW����(cѴu�R�aH\����Z'0ИW-q=kV�^�_��Dp��GV��f
�B'��Ԭ�8�u�v΃V[�a� "֝Z�H~���<���l��q���G�&�S�U:5�"�a�j[�Ҥ%� ^���g�j�4lǷ*w���4�ϊ�%��]���|���ܬNR��E��*r���e$��l�b�g/��^�5P��<x���n`-�J0���m|� ){ tG��g���x� �O-4��ܵ-����;;����Ǣ��:# ����\�qz̺Y��	���a}�%�͑�wZ�=�ڂ����+���|L�����0��g�k�dݤ���;���@Uq�[������=�L���2=*�wr�J�ũ#�.3�mҋ+f؈>�zhnFpw�Yms��گ��a6k	�����ɥx�ҙ��l۴l$�i�1��3�l@�������x���T/	~}L���Y<W��A؋��q�lW
~����/F���y��bi�|�6�K����n�k\J��[�5�vY�����F��3�;$�Dc	����$\F|(>��QZ}4��G�Υ�
�Z.D��F^d�&���VF����I����A��w��u1@f*�l����h�V9īt�@�8�:��2X5��0u��_!ZO�sC[�\��a���8�$O4�l���6���I��?����w��F��L�|&�ݩNҘ�� }��sf9����|.7�X��i����++*[��u��&��Up-��i�
g�֤R�ފ�쬕YꪠkK:���5WPb���>]��L/�Bi|1H����^���
�b���k�V|��k�N��xr1����/�&s
yH���
�p@��9O�3؏B�Y@Nc�n\S֒b=���cqG;I�N*8��]Z�(h�X�)
�e
������ؙA���2uvXNX������ꊟI�/��uW��٩���ׄI��p�C�I���u�)��*9��&�;���>�[[�=�
*w����r(`նYel�z�+0�p"�#�L̲s����� |+��tz��5��3���I+:���GV����Զ��`{Ok�cY��� &����wvǂ��)���ĵ{�Cyzg]�1;���/���LP����g�,���*�Z�B�|���1�b���$�0T|�b�k�6�./��K�/�3�G'U�ssgahq|�,��Q��m��K�p7��Ef�����Y�e���_g� �;;��Y�y������턔�ws����`98��q�'k�t�/�3=U�!�]�|l����joKK.�qɊ;��ɚ۷�����3���;4��|5�D�	^�&��Ƅ���s,�Vf��������Rm���׭��(yI�ɧkN�R��8Hb���Y��S�IV�a�U����y�rj���=�C0�6:IK�����u���ʸ����q9Jb�4v/X�"���L"�SI2۔�B���j}zo��Դ��w0��I�����^�uvY�4b�qe�kS��1����Z�:Ń��Щbǲ����T�]�S�f�y�m��睝����oL�R=t��g`�׺�Z�ZJ�t�e��NM*��	�5�� �Vŷ�����\��#\����X{vM(�s��ہ�}c�'�xgg'`�_m[gÓ�A,b@�����Vw-����r?_l���,����K�$��g�����U�R�R� v����F�p���W�-=f���:.(6l������=�]�t�Ó| 8z���V7�!-I1`a b�GK�ν3/n���`��8�?3|�b���ϗ�p4��Х��W�~e�[NU�ND`��=)��fi.��ӳx��6���d��`���E��۲�]�L�gȍң�,�Z�Y�}�?�Ղ[�zxR�O����1eM��c��n>��~�,8뫋QY�g�5�U	n'��7r�%w`��=Q, �EAJ��W����	$��~|��f?���=#�0��8ŉMf�V�Fķ��4��!���B�ʅcXV��I��y�����t�jYs9�%9SZ!��]c�{z�>��H���;箕���-N�9�!���h�r%�x}kA�y�I	�p׈W��sު�ІE&Ρ��/��g�f�|�c�d�\Hр�}i�z��IqMoO�P�u�C\� ��$6�����C�WI����WQ�.�9T�:[�
�\�ԇ'5;e?��9�.�m`ԑ(���_`���ѯ5�}���Eu��Kׄ�f����;u��Q!�O��O���< Q*b�֗U�Ú�[p	7��A��m=��3U��`��0u�E0ĩ�q�epZ���eAx�8�������+���/������~�n�
����'�@clة�	xR��5������e�7�X��t��XV��I�����4y�����&ꋥ	���8fĵ�i��Ԯ�D�Ó����ZwN^d��`�h�s��
+ �<'��4m�t�#��m�%��*����ܩ�?Zǎ��O]*�g�0���6NKǧο{�`�q�]��Z�KN�'z���H}ǃ�A������\���L���g�2f$�U��A�/�c�9tLƮ�R*R��\���y�[^_��\�6�:�G�Mj�y���+�O�p6w��0'P��0�V��͕a��k����b��v��!$���6�`��^�؝�_�<�����T����X_He ,��<�oH�H6O"����;��3�����D�F&l���A \  W��ztsI��_,J��7���Ge�e����/֏#G&Hސ</�1��
v��q�^�O�������lȐ�H�`�"�ȫ�w����Ó
O��~=�㴒4Y�.�n�|]ˀ���	+�Sչ�������Y���Ҳ�sɃ���"����X��=C���8�3߬Py@�� �+g�\i:zi�jn���í�3{1�q�xO"�-\��'�������9��u�j���$.y�
ѵ�y�m�~����� �'x�qc|�c���ިY�K���x��iYj*�6��T�/Bz)?��	�w,{1H)�o��s�lVse�VNk^�����9<���U�t?���;'�<�\A<�p��	s��f#�p��ԌM{��Ȥ��;�� ��)Sq�"y�L]���g��
y�(:�$o�?���[���S�Ó
g2�F�-xC�ݎ�\���M�l�81��in�-��FxT�_�O�֜��I����6r ^	��\��f$�"�m�Ϟe�&�Ր[�̰5��rU���r��ʵ=��[`9������D̹���(�"56�!nt�*��'�X?�I��9����$S��u����מ��3#��e�,0Z
�c��E�S��S��d��|��[�����¡�{
h�ZqTw��ER�螕�Xzki�iH���Y`d�f^Ξ�����i<<��+.n�K��� �Dތ�ٹT�ʸZo�dC���I�R�0Mz�g`�N%�镻�՞O?������}�@0k�[��G@���ˑ:��8$[���%��6q���Csn0v�>ֹ��G��4���<P#� R�u�Jw��-�N?�J�;˄#7���z$����O�~�#~Y����V�?�+)l���˭�u�\���Ob�BK�13�J�%�~�b8ú{R5X�(r�)�^H��w���~A����={1rj����
��.�sv��S�w���pįkn[v4���l�kH)�Χ��p�8m��#+7~Ys۲���*��'��"'CZ�W��1C�ry��|Ys۲rر-�w����K��!>7E�}�կk.[vxR%�$���%ͫ�m�7�9��83hu�oc_�ܶ�p�����ˮZx����b�Nōb���������1�j9��!��ju��X�%y���� �x��������:v����"-�p�"��`O�����Bn����ۖ�cg��n�#��D�����q$\����S߲���m�y�����~�]�!O�6��}�)R��u����ۖ����Sٸ�� ^�λD�U���̳���VP���e�8����+i*�E�re��X���g���/kn[v8�I#��M䴈��#���2I���l��_�ܶ���8�j��BV2Ik�I��]��[Yp3��~Y�Kz4~�L��s���X��ڭ�T����:B9�m�L��R�aW�����ߏP�9u/�9h������N;<��O;����,]5#!����M�C�*� س���N��ӓ�)��*t���86�#od"�W�����2rH�K�yvxRU��,�c�8`�ȶ�v%�	�V*��}]�;�*������r��{�R}��>a��6��H�}���p���\:�����q��R�!��}%�Q$�7�٣p�;\���w.f�W�ه�N7���8b�w�ּ�b����t�l7���[�(t�ye�Ó
d%���_y�!-#H|�`?�Ϛlz��yM1���d�'5$4isM�TJL��ݭ>�7�FWD���7��a�m���͕�zIR��g=ˊ}��O�đen�P��Uۊ�_���G�R<�ĕ��~�EE��)�X]�F��U����-���h��ulޟ��x�y����#YZKX��R�;�eM�r�E�O��N�~��p��gi���6�(�ȟ�S�����v*�*�rFT#���8=g}㢖{3�n.��6l�Mj�sjR4�o������={`����/<�Yuw��Ch��RvH��w�)9����Gf�4��=M������a��,oũ+}W�G�,�=�}��R�!�q ���1ax"yo���Q6�;���R���&�b��Q������n����5�o|H�Xf������>��F�Hd��nݲ��I��q�y��b�����IU�(n�Q	�׀ <�a�L^��Yy{��ʥ9O��-&'
�<]�:�T�]8S�+�D���b���o��<�ח�՞<�ۃ���5��13�jO���w�3��Sa~v�4�T�%��>}�t �ǈ����q!g_c-��b�e����I-��|bU�$#^���l�OdMű�>�뚍Aҥ�2;<�H����� �̳��k�PAZ�F�N�nE�/k�A����rfs5[��~8�bR1n�̞�������o-���=�5�C)@���D���l�'5���\�,�Q�1����A��Zg��7C۟`�G����!8|h�џ� �o^��j*�S,;����~����ۚC���oj�����a�[A1�U0�����d&Q ی��r�D��8u���$~}��=�� ��)\	Ks1��x���Y��:&�|^�"�||O�6%e~��(���X^�X��,��8�i��8�P#�wo����_:��'��>���f�3��^b]��8�?(��Q��Z�S�j����Ȉ\M� �Ԙ{�ɌC����
O�U#><�.{;TF�^���3��
��f���F���8��;��xzx~TU�<����;�U ��s,��,�mf�o{fϞ]ze
���9�U�Tl�P�j���UK4���H�u��
Ox{Rq�$���[0sm�!~HY�ב+�����J�HG P�����:-�4+T|�)�TxA4v�G�k�6r��2.�
	|%�>�A�o,�jW�� �c���'���0* ~qn��l���l3y�K�#vxRY�I{�X:<���-j���%G�ki��/擰_�MW�'nζp�p�5��d׈���Q�63��f%��>ȉ�jK����H���w�X�,�%��~J�C�;r��Z�z�nm!�v�o�3�]ቷ� �}��D�����(0���2rjq9���?�4�v5����ˈ����.XC��7�"^>[�=������*�vwOj�#O$˸lH��%7��Y�Ƃ�-�F~���/����ԈY||�Y�+�1�d�V��@[��F�jG�K/��' 1z{0!{2c��<_�ל��ZÏS�73�r���͆�J�Bg d�1����� �?#��䇣�Dʻ����#��?�҂�OH�r�[�$����C�豄������ v˃$w�~ޛ��?��R#y�Ն2[}&_�o���D�;� v�D%J����������������tk���w<����W������'AGn     