--
-- PostgreSQL database dump
--

-- Dumped from database version 13.6
-- Dumped by pg_dump version 13.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: idea_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.idea_type_enum AS ENUM (
    '1',
    '0'
);


ALTER TYPE public.idea_type_enum OWNER TO postgres;

--
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role_enum AS ENUM (
    'seller',
    'admin',
    'customer'
);


ALTER TYPE public.users_role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: chat-room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."chat-room" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    customer_id uuid,
    seller_id uuid
);


ALTER TABLE public."chat-room" OWNER TO postgres;

--
-- Name: comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comment (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone NOT NULL,
    comment text NOT NULL,
    product_id character varying NOT NULL,
    ref character varying,
    user_id uuid
);


ALTER TABLE public.comment OWNER TO postgres;

--
-- Name: customerproducts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customerproducts (
    "productId" uuid NOT NULL,
    "usersId" uuid NOT NULL
);


ALTER TABLE public.customerproducts OWNER TO postgres;

--
-- Name: favorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favorite (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    created_at timestamp without time zone NOT NULL,
    user_id uuid,
    product_id uuid
);


ALTER TABLE public.favorite OWNER TO postgres;

--
-- Name: follow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.follow (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    follower_id uuid,
    followed_id uuid
);


ALTER TABLE public.follow OWNER TO postgres;

--
-- Name: idea; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idea (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    type public.idea_type_enum NOT NULL,
    subject character varying NOT NULL,
    description character varying NOT NULL,
    answer character varying,
    created_at timestamp without time zone NOT NULL,
    answer_at timestamp without time zone,
    user_id uuid
);


ALTER TABLE public.idea OWNER TO postgres;

--
-- Name: message; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message text NOT NULL,
    date timestamp without time zone NOT NULL,
    chat_room_id uuid,
    receiver_id uuid,
    sender_id uuid
);


ALTER TABLE public.message OWNER TO postgres;

--
-- Name: order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."order" (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    is_accept boolean DEFAULT false NOT NULL,
    is_answer boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    answer_at timestamp without time zone,
    piece smallint NOT NULL,
    total_price double precision DEFAULT '0'::double precision NOT NULL,
    customer_id uuid,
    owner_id uuid,
    product_id uuid
);


ALTER TABLE public."order" OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    price double precision NOT NULL,
    stock integer DEFAULT 1 NOT NULL,
    images text,
    "categoryIds" text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    show_count integer DEFAULT 0 NOT NULL,
    description character varying,
    rating_count integer DEFAULT 0 NOT NULL,
    rating_point double precision DEFAULT '0'::double precision NOT NULL,
    owner_id uuid
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: rating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rating (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    is_rating boolean DEFAULT false NOT NULL,
    product_id uuid,
    user_id uuid
);


ALTER TABLE public.rating OWNER TO postgres;

--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    owner_id uuid,
    customer_id uuid,
    product_id uuid
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    username character varying NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "profilePicture" text,
    role public.users_role_enum DEFAULT 'customer'::public.users_role_enum NOT NULL,
    is_freeze boolean DEFAULT false NOT NULL,
    balance double precision DEFAULT '0'::double precision NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, name) FROM stdin;
fdfb56e0-3aa3-4a82-9880-92ea3bffbec1	Giyim
95412e08-eb74-4924-b954-042d01e3e7d0	Teknoloji
6a9e55f7-024d-4c1a-9ff4-b7086a85daf6	Bilgisayar
c6161828-025c-4626-960b-44ff2f6d8e00	Notebook
\.


--
-- Data for Name: chat-room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."chat-room" (id, customer_id, seller_id) FROM stdin;
4d25cbc6-4962-4249-a489-da7d3af436bf	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comment (id, created_at, comment, product_id, ref, user_id) FROM stdin;
94240525-330f-4d90-af54-43b303db6dd5	2022-11-20 00:20:39.072	Bu ??r??n?? sat??n alan birisi ula??abilir mi ? 	65b36ec5-7d1f-476b-94fa-bf43b0be16c2	\N	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
d8a030f1-5159-4659-b225-7a5f49a3728b	2022-11-20 00:20:47.513	 acill	65b36ec5-7d1f-476b-94fa-bf43b0be16c2	94240525-330f-4d90-af54-43b303db6dd5	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
2b01b6d5-454e-4995-8df9-3e2d31aa2e04	2022-11-20 00:24:02.55	 ??abukk	65b36ec5-7d1f-476b-94fa-bf43b0be16c2	94240525-330f-4d90-af54-43b303db6dd5	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
de387795-0b8d-4d1e-9791-2f6f043d3ea7	2022-11-20 00:24:17.564	kimse yok mu abi yaa	65b36ec5-7d1f-476b-94fa-bf43b0be16c2	\N	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
5a4f0055-5f53-4e35-95a6-8b23f7fd8c30	2022-11-20 21:57:58.868	Gayet g??zel ??r??n.	17b9ee25-f982-4631-bce9-a57ac4b0f603	\N	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
caa743e3-92ae-43da-9f10-4010f1f44dc2	2022-11-20 21:58:42.769	Gayet sakjdygbasn au??yahsudl jas 	17b9ee25-f982-4631-bce9-a57ac4b0f603	\N	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
\.


--
-- Data for Name: customerproducts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customerproducts ("productId", "usersId") FROM stdin;
17b9ee25-f982-4631-bce9-a57ac4b0f603	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
65b36ec5-7d1f-476b-94fa-bf43b0be16c2	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
\.


--
-- Data for Name: favorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favorite (id, created_at, user_id, product_id) FROM stdin;
3b133ad1-7821-4028-826c-002f8b533fab	2022-11-19 17:47:46.035	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
\.


--
-- Data for Name: follow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.follow (id, follower_id, followed_id) FROM stdin;
234df59f-1112-479a-be2a-1596c1f11e17	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
\.


--
-- Data for Name: idea; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idea (id, type, subject, description, answer, created_at, answer_at, user_id) FROM stdin;
3f3b68ac-65e6-4834-bce5-ca0d55b52bdd	0	Eklentiler	bla bla sajhkbdjsad ashkjbdkhasjd asdhbkhjwbdsa dlajnbdl\nsadjknsa??kdm \n sadmkasild??as \n sdlkmail??dwe?? \n	jajs vhjsadh hau??u??ud asjdnuouhu??asd onu??hasduhasd ou??aheuydauhywd sadhnauwdhnuaou??s d??u j??uamhhuo??cahwduo??cjsd ??uamhjdau??j??uoj??snmad ??uashok??uhd??auhnjksxnmj ??uhadm??ushxu??d ??uasmhu??xndubsdmmyuebwad bau??ywbdhmuywabnudhasnmhdnuyehwdn uaeyhwbduahybddsd uaydhb??uywabd yuawuybdauhysdb ausbd\n	2022-11-18 18:34:10.208	2022-11-20 15:16:16.276	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
\.


--
-- Data for Name: message; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message (id, message, date, chat_room_id, receiver_id, sender_id) FROM stdin;
75a75e11-c010-482f-80a2-f8ee93a1416a	Merhaba	2022-11-18 21:59:25.415	4d25cbc6-4962-4249-a489-da7d3af436bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."order" (id, is_accept, is_answer, created_at, answer_at, piece, total_price, customer_id, owner_id, product_id) FROM stdin;
12c32fde-e1de-40a7-9eb4-601b2f3f348a	t	t	2022-11-18 21:42:53.326	2022-11-18 21:44:34.725	3	630	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	17b9ee25-f982-4631-bce9-a57ac4b0f603
6361fca0-af93-4473-8249-b91a7ef2993e	t	t	2022-11-20 22:16:24.168	2022-11-20 22:17:06.206	2	35998	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
1c8798f1-205e-4b39-b5db-065da1ff5d96	t	t	2022-11-25 22:21:45.622	2022-11-25 22:22:52.965	1	17999	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
b1f4e590-2c08-4028-8912-0547fc3ee1f5	t	t	2022-11-22 22:21:34.74	2022-11-22 22:22:49.314	1	17999	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
3653979a-f4a0-4185-9547-ac3c7ad8f1c8	t	t	2022-11-24 22:21:47.583	2022-11-24 22:22:52.006	1	19999	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
a6116ea6-ec90-48c2-a92b-7b1c7f83b71b	t	t	2022-11-23 22:21:44.075	2022-11-23 22:22:53.79	1	15999	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
deae97c3-54fe-456f-af17-827c87962691	t	t	2022-11-21 22:21:41.126	2022-11-21 22:22:50.772	1	15999	d93d3cf2-89b4-484f-a8f1-72939b35f3bf	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	65b36ec5-7d1f-476b-94fa-bf43b0be16c2
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, price, stock, images, "categoryIds", created_at, show_count, description, rating_count, rating_point, owner_id) FROM stdin;
65b36ec5-7d1f-476b-94fa-bf43b0be16c2	Asus notebook	17999	13	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	{95412e08-eb74-4924-b954-042d01e3e7d0,6a9e55f7-024d-4c1a-9ff4-b7086a85daf6,c6161828-025c-4626-960b-44ff2f6d8e00}	2022-11-18 21:50:07.857	13	Kolay ta????nabilirlik. Zahmetsiz ??retkenlik. ??ster i?? ister oyun i??in olsun, ASUS X515 g????l?? performans ve s??r??kleyici g??rseller sunan giri?? seviyesi bir diz??st?? bilgisayard??r. NanoEdge ekran??, ger??ekten ilgi ??ekici bir deneyim i??in geni?? 178?? g??r??nt??leme a????s?? ve mat parlama ??nleyici kaplamaya sahiptir. ????inde, h??zl?? ??al????an bir 11. Nesil Intel Core i5 i??lemci ile g????lendirilmi??tir. Y??ksek depolama kapasitesi ve h??zl?? veri okuma/yazma h??zlar?? ile size m??kemmel bir kombinasyon sa??lar. Daha fazla s????d??r, daha fazla yap ASUS X515, size s??per h??zl?? bir veri performans?? ve geni?? depolama kapasitesinin avantajlar??na sahiptir. Daha h??zl?? yan??t ve y??kleme s??releri i??in uygulamalar?? SSD'ye b??y??k dosyalar?? depolamak i??in kullan??n. D??nyan?? geni??let! ASUS X515'e i?? ve oyun i??in s??r??kleyici bir g??r??nt??leme deneyimi sunar ve geni?? bir ekran alan?? sa??lar. FHD paneli, rahats??z edici parlama ve yans??malardan kaynaklanan istenmeyen dikkat da????t??c?? unsurlar?? azaltmak i??in bir parlama ??nleyici kaplamaya sahiptir. Sadece ??n??n??zde ne oldu??una odaklan??n. Dinamik hayat tarz??n?? g????lendir Sadece 1,8 kg toplam a????rl??kla, son derece ta????nabilir ASUS X515, hayat??n??z??n h??z??na ayak uyduran hafif bir diz??st?? bilgisayard??r. ??zellikler b??lgeye/modele g??re de??i??iklik g??sterebilir. Teknik ??zellikler ????lemci Intel Core i5-1135G7 (4C, 8T, 2.4 / 4.2GHz, 8MB ??nbellek) ????letim sistemi Windows 11 Home Grafikler Intel Iris Xe Grafikleri (Payla????ml??) Bellek  16 GB DDR4 Batarya  Dahili 37WHr Ekran 15.6 FHD (1920x1080) IPS, 250nits Parlakl??k, Parlama ??nleyici, %45 NTSC Depolama  512 GB SSD Ses SonicMaster stereo hoparl??rler Kamera 720p HD G??venlik TPM 2.0 (G??venilir Platform Mod??l??) Kilit yuvas?? Boyutlar (G x D x Y)  360,2 x 234,9 x 19,9 mm (14,18 x 9,25 x 0,78 in??) A????rl??k 1,8 kg (3,96 lb) Renk  Gri Ba??lant??  Wi-Fi 5 (802.11ac), 1x1 +	1	3.5	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
a7cab906-2087-4ba1-8780-d849684f4ebe	logo	5000	9999	iVBORw0KGgoAAAANSUhEUgAAAcIAAAHCCAYAAAB8GMlFAAAACXBIWXMAAHySAAB8kgGPn2IfAAB4pklEQVR4Xu2dB4AkVdW2b3VVdZy8eVkyooiKiqiACogEQUUEFURRDIgJA2a/z4jZX1E+BbMiCoISFAUBFRSQpARREMmwsGl2UucK/b/nVlV3de/M7uzuzGx3z1s4zkx39a17n+rtd865JyjFgwRIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIgARIYC4J/Pcn5+z25yOPPf1Puzzzwrm8Lq9FAiRAAiRAAtuUwH3f+vyB1+z73AuvXLh04vLtdqhe9by9L9mmE+LFSSAkYJEECZAACcwmgRved9rRhcuuecfjn/rBIdaArapLB5SqJdRALdU3m9fl2CQwXQIUwumS4nkkQALTJjBy5WXJe8696Djv+pveP3bRJbsaabO3vDyprJqh0p6pKq6rCmaJnz/TJsoTZ5MA34izSZdjk8A8I/Do9366y6qfXfD2v7/+5JepjLu7mclZacNXGctSTtVTrjJUxTJUNZlQiYw5Os/wcLltSoBC2KY3htMigU4i8NBnP/u0Vb/+zYfv++hphySGcouzS/sTqqpUJlFTo4mKmlC+UgkT2mioVNlXiYSvUjlldtIaOdfuJUAh7N57y5WRwKwSGL75BqP43R+9/qG/3XT0vd/61nMzi3LbqR37lVc1lOEkVK0GK7CUVwkrpZKGpap+VblWQtmWrWpOVXmOm5jVCXJwEpgmAQrhNEHxNBIggYDAyvN/vnT0wkve+NCRr31zIVNebuR6elKLBpRZs1WuklZF31EOhC5twQpMZVTZd5Vbc5Rr+sqDa7RULSuvVlPpVKpMpiTQDgQohO1wFzgHEugAAg9/6+tPGb7w9+987H2fOKqWVtsVl6XNlD8E689VKbg9q3B3DjsTyjRNlcyYquxA/PCYDbdozoeFWK2phJ1QDp4vOh5+V/z86YD7Ph+m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EiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiABEiCBbU3g/wO59Oz3FJupLwAAAABJRU5ErkJggg==	{95412e08-eb74-4924-b954-042d01e3e7d0}	2022-11-20 23:43:45.174	0	logo	0	0	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
17b9ee25-f982-4631-bce9-a57ac4b0f603	Elbise	210	47	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	{fdfb56e0-3aa3-4a82-9880-92ea3bffbec1}	2022-11-18 18:21:08.624	17	Model ??zerindeki small bedendir\nModelin boyu 175 olup 58 kilodur\nModel ??l????leri\nG??????s 85\nBel 64\nBasen 95\nBu ??r??nden en fazla 10 adet sipari?? verilebilir. 10 adetin ??zerindeki sipari??leri Trendyol iptal etme hakk??n?? sakl?? tutar.\nKampanya fiyat??ndan sat??lmak ??zere 10 adetten fazla stok sunulmu??tur.\n??ncelemi?? oldu??unuz ??r??n??n sat???? fiyat??n?? sat??c?? belirlemektedir.\nBir ??r??n, birden fazla sat??c?? taraf??ndan sat??labilir. Birden fazla sat??c?? taraf??ndan sat????a sunulan ??r??nlerin sat??c??lar?? ??r??n i??in belirledikleri fiyata, sat??c?? puanlar??na, teslimat stat??lerine, ??r??nlerdeki promosyonlara, kargonun bedava olup olmamas??na ve ??r??nlerin h??zl?? teslimat ile teslim edilip edilememesine, ??r??nlerin stok ve kategorileri bilgilerine g??re s??ralanmaktad??r.	1	5	895ffdf7-ae2b-4dff-ba1b-9d566581dcbe
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rating (id, is_rating, product_id, user_id) FROM stdin;
e4bdac5d-33a9-4e1d-bdb9-f1c2327c3f59	t	17b9ee25-f982-4631-bce9-a57ac4b0f603	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
30abf0fe-5261-484e-be3e-319a73c891ef	t	65b36ec5-7d1f-476b-94fa-bf43b0be16c2	d93d3cf2-89b4-484f-a8f1-72939b35f3bf
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (id, owner_id, customer_id, product_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, username, email, password, "profilePicture", role, is_freeze, balance) FROM stdin;
61aa9232-d6c1-4399-842b-898a00749930	Sezer	Kenar	sezer_kenar33	sezer33@ekip.com	$2a$10$1C4.EZwdypy7ldg1V0/yXuJXhXPBYxO50FgXYc8qJ1H4EJ2HGRi1G	\N	customer	f	0
90c3509c-5cff-40b2-ac0f-c77a01d85b78	Sezer	Kenar	sezer_kenar34	sezer313@ekip.com	$2a$10$l6F5ded8n6/29BPCD.LWiOiGgc.aVS1pGhZjCAzfU4CUp4XkPpeC6	\N	customer	f	0
3dded53b-b741-4722-8cd9-0ac4a70aae91	Sezer	Kenar	Sezer67	kenarsezer08@gmail.com	$2a$10$oi6lK1P0GFWAqqFAJV2Ea.uPNnTDUH8oSU5DCNyQWj4bspfGHJvt.	data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAABFAAAARQB+zng/wAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAEJSURBVFiFvdXBCoJAEIDhn96ro2+RtyKlToGXXrSDB6ECoUNBncsO7ULIrrq7Mw54kfD7E3UAlsAJOAMr9CcHLsZcAtRAZ44PUCripTGsVwPc/k5oRvTxzthseyc1Ilx4Z2wADp6IvQC+Ad6O6x/7P9SImIxrRATjkhHRuEREMp4SIYbHRIjjIRFq+JQIddxO5YlwfeEqadyO606o//OQiGB8ERHw4nfb+9MBz4jrBY3vgZNeYM4pcD9wrohCGh961TRX+ShuRy0i5CMjHrEOwMcidnPgYhEpeHKEBB4dIYkHR2jgkyNy9Feqb5XnAK0yPhTRAjQz4L6IBiADrsAdhSXimAJ4GDP7Ao3GS7lBEjtAAAAAAElFTkSuQmCC	admin	f	0
d93d3cf2-89b4-484f-a8f1-72939b35f3bf	Sezer	Kenar	sezer_kenar	sezer@ekip.com	$2a$10$oi6lK1P0GFWAqqFAJV2Ea.uPNnTDUH8oSU5DCNyQWj4bspfGHJvt.	\N	customer	f	10005
895ffdf7-ae2b-4dff-ba1b-9d566581dcbe	Sezer	Kenar	seller	seller@ekip.com	$2a$10$oi6lK1P0GFWAqqFAJV2Ea.uPNnTDUH8oSU5DCNyQWj4bspfGHJvt.	\N	seller	f	126623
bedbacfe-c7d9-4db5-b8ad-f3b12a4358cb	sezer	kenar	deneme	deneme@ekip.com	$2a$10$wrGZeWhXmmqWJL.QQ3aJDOkhOyTnI6o2H5ntMZOgZLnq0wK5CZrCS	\N	seller	t	0
\.


--
-- Name: comment PK_0b0e4bbc8415ec426f87f3a88e2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "PK_0b0e4bbc8415ec426f87f3a88e2" PRIMARY KEY (id);


--
-- Name: order PK_1031171c13130102495201e3e20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "PK_1031171c13130102495201e3e20" PRIMARY KEY (id);


--
-- Name: favorite PK_495675cec4fb09666704e4f610f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT "PK_495675cec4fb09666704e4f610f" PRIMARY KEY (id);


--
-- Name: sales PK_4f0bc990ae81dba46da680895ea; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "PK_4f0bc990ae81dba46da680895ea" PRIMARY KEY (id);


--
-- Name: idea PK_5096f543c484b349f5234da9d97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea
    ADD CONSTRAINT "PK_5096f543c484b349f5234da9d97" PRIMARY KEY (id);


--
-- Name: category PK_9c4e4a89e3674fc9f382d733f03; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "PK_9c4e4a89e3674fc9f382d733f03" PRIMARY KEY (id);


--
-- Name: users PK_a3ffb1c0c8416b9fc6f907b7433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_a3ffb1c0c8416b9fc6f907b7433" PRIMARY KEY (id);


--
-- Name: message PK_ba01f0a3e0123651915008bc578; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT "PK_ba01f0a3e0123651915008bc578" PRIMARY KEY (id);


--
-- Name: product PK_bebc9158e480b949565b4dc7a82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "PK_bebc9158e480b949565b4dc7a82" PRIMARY KEY (id);


--
-- Name: customerproducts PK_e114c12b84a2357727370a72f2a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerproducts
    ADD CONSTRAINT "PK_e114c12b84a2357727370a72f2a" PRIMARY KEY ("productId", "usersId");


--
-- Name: chat-room PK_ea6c8a25f119f72a1039ce50f39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."chat-room"
    ADD CONSTRAINT "PK_ea6c8a25f119f72a1039ce50f39" PRIMARY KEY (id);


--
-- Name: rating PK_ecda8ad32645327e4765b43649e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "PK_ecda8ad32645327e4765b43649e" PRIMARY KEY (id);


--
-- Name: follow PK_fda88bc28a84d2d6d06e19df6e5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT "PK_fda88bc28a84d2d6d06e19df6e5" PRIMARY KEY (id);


--
-- Name: category UQ_23c05c292c439d77b0de816b500; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT "UQ_23c05c292c439d77b0de816b500" UNIQUE (name);


--
-- Name: users UQ_97672ac88f789774dd47f7c8be3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_97672ac88f789774dd47f7c8be3" UNIQUE (email);


--
-- Name: users UQ_fe0bb3f6520ee0469504521e710; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_fe0bb3f6520ee0469504521e710" UNIQUE (username);


--
-- Name: IDX_3730f7438798100e8174a0ee7e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_3730f7438798100e8174a0ee7e" ON public.customerproducts USING btree ("usersId");


--
-- Name: IDX_a0e68b2e1bbc94bd1fea8292d5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "IDX_a0e68b2e1bbc94bd1fea8292d5" ON public.customerproducts USING btree ("productId");


--
-- Name: chat-room FK_09460830caed75cf74b5f93f9a3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."chat-room"
    ADD CONSTRAINT "FK_09460830caed75cf74b5f93f9a3" FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rating FK_17618c8d69b7e2e287bf9f8fbb3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "FK_17618c8d69b7e2e287bf9f8fbb3" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: rating FK_2432a0d3bcc975f29eb1e43456b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rating
    ADD CONSTRAINT "FK_2432a0d3bcc975f29eb1e43456b" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: customerproducts FK_3730f7438798100e8174a0ee7eb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerproducts
    ADD CONSTRAINT "FK_3730f7438798100e8174a0ee7eb" FOREIGN KEY ("usersId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message FK_4404b7d229b7093872f40a87e7b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT "FK_4404b7d229b7093872f40a87e7b" FOREIGN KEY (chat_room_id) REFERENCES public."chat-room"(id) ON DELETE CASCADE;


--
-- Name: sales FK_5015e2759303d7baaf47fc53cc8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "FK_5015e2759303d7baaf47fc53cc8" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: order FK_539ede39e518562dfdadfddb492; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_539ede39e518562dfdadfddb492" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: sales FK_92c7cb23ffe1da245738c52ead6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "FK_92c7cb23ffe1da245738c52ead6" FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follow FK_952d77375f7e56e7037893744d1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT "FK_952d77375f7e56e7037893744d1" FOREIGN KEY (followed_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: customerproducts FK_a0e68b2e1bbc94bd1fea8292d54; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerproducts
    ADD CONSTRAINT "FK_a0e68b2e1bbc94bd1fea8292d54" FOREIGN KEY ("productId") REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: idea FK_abd4e09faa9a88e2171e9cc958f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idea
    ADD CONSTRAINT "FK_abd4e09faa9a88e2171e9cc958f" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: chat-room FK_b0c61631c766ca3b4236a8b6b1b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."chat-room"
    ADD CONSTRAINT "FK_b0c61631c766ca3b4236a8b6b1b" FOREIGN KEY (seller_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorite FK_b3e2e24d544d819cae3679b4084; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT "FK_b3e2e24d544d819cae3679b4084" FOREIGN KEY (product_id) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- Name: comment FK_bbfe153fa60aa06483ed35ff4a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT "FK_bbfe153fa60aa06483ed35ff4a7" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: message FK_c0ab99d9dfc61172871277b52f6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT "FK_c0ab99d9dfc61172871277b52f6" FOREIGN KEY (sender_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: product FK_c2eedda8bf0194e1fb299ee7424; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT "FK_c2eedda8bf0194e1fb299ee7424" FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: sales FK_c51005b2b06cec7aa17462c54f5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "FK_c51005b2b06cec7aa17462c54f5" FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order FK_cd7812c96209c5bdd48a6b858b0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_cd7812c96209c5bdd48a6b858b0" FOREIGN KEY (customer_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: order FK_d9181c2d154dfb71af0e18d9669; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT "FK_d9181c2d154dfb71af0e18d9669" FOREIGN KEY (owner_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follow FK_e65ef3268d3d5589f94b09c2373; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.follow
    ADD CONSTRAINT "FK_e65ef3268d3d5589f94b09c2373" FOREIGN KEY (follower_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: favorite FK_e666fc7cc4c80fba1944daa1a74; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favorite
    ADD CONSTRAINT "FK_e666fc7cc4c80fba1944daa1a74" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: message FK_f4da40532b0102d51beb220f16a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message
    ADD CONSTRAINT "FK_f4da40532b0102d51beb220f16a" FOREIGN KEY (receiver_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

