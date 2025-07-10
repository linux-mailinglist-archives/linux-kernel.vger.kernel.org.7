Return-Path: <linux-kernel+bounces-725720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B1BB002E5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6057BC897
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2C28134D;
	Thu, 10 Jul 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b="Ig9nBOVk"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2106.outbound.protection.outlook.com [40.107.115.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB525D21A;
	Thu, 10 Jul 2025 13:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152887; cv=fail; b=NwYYdYwh8YwFIhUVcyigHL/SgwMz6+P7yauX6D3SE6EuzVKoPq/uz4dkvm78jRwed8y3z337jEtyuEIQZH3iDAvge2eA/+Fet2Hqvrk0ThntSx8Osjj5567J6JrWOu+9+pdNKZytnUhVl/XxORuA2tlF9gtN1YA7imhbhEm9xls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152887; c=relaxed/simple;
	bh=WkyF3mf2GrgZ6VW9r+P9nf0i22nKsSiPjfOZeghqg4I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LnAznl3fX09alhp3BWkCLMLZD2fTWj6/hiLwI1Ty5Rn/MSZlGk3u4+MUtER6iUg2p7ZthJcT791OUuwMlgBSwxSWC3x7DyC9vsqwoUsNrV1g6vrZ1tfMI3xhlAHuImkNDO6I7+I6QofPlOv4+HmUZqrsyDGUD/Ksw9wphn9/HOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com; spf=pass smtp.mailfrom=ndigital.com; dkim=pass (2048-bit key) header.d=ndigital.com header.i=@ndigital.com header.b=Ig9nBOVk; arc=fail smtp.client-ip=40.107.115.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ndigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndigital.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff/Z1csx6Cw5f7wqKud7TPu1LWAQ8SeN8nBdp/kNXB3rOdmTKkLd/1pJdrwyCvX1Wf3n/sa1usa06Fkd6Lr6JjXfy8bCshF8Sz1WyvtD/m+jIKseM5V1AZFQxE5P0yo5Q2MflrN2JW0M6cU4TaNKJG0iLs/vnioX+zgGxXBIODYqjFKs8wCaY2hSQpCJVYHK92CWqGaJvHlinmS6D4pFHNzTIWUP7Topt62H4pB7Z10P9EtyeptrAXHuWKTJCDUl+UZgYTwIXsCTX7UEGo8lU8pQdb3Cb+wvDTQtasOdrYaSZaRP7ppszGnQZ5gtRGXWxxz+ldAuMgAgt6hFNb1PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddg+qXZCPN0XSThMSRfb67T71lGIa/TFwtyu4x1Zt9s=;
 b=cQSPKeaYq/RvhH/zwvojIwXbrA4lpdq9v89K4rTn+MGrmWVOsuC9DNRanDHXEUnMDG62P4Wy8YDcRBzZ0tAkd3ENOQHE/F8iiWDB0bA797Fqv76Xefz0wlRYsQGa/0aCM+O0Z4JVxFyJb2MsmRZ/TmEbfxK7dXz8B+BmPGPPxATKft1igtSIlLKd2/4id4zQrHm8wZ5nvSeNNiSNFMsd9s6yAJe15F79/SlTCwaRE7bHuUfPKt5gvMeZ73JscgKe5+OuuJkwTgePwlr5T8fYfTuHN/2QboV3A59Ga0y6b27QQ0o+ntQU5ijT9HiluekYCWA21FqZ0Y57NSqGvDVBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ndigital.com; dmarc=pass action=none header.from=ndigital.com;
 dkim=pass header.d=ndigital.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ndigital.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddg+qXZCPN0XSThMSRfb67T71lGIa/TFwtyu4x1Zt9s=;
 b=Ig9nBOVk3PeEw7SgwBhkwudlLxi9pQLG+hSN865gPTDfHctD0pc1rB582VkIqHEXogiNyxrnehcFx5f6dy9YpJFp1kUnk5k7WYy7qBOwJw9BH/i8mq1QYGnzCbYbpSxveLbsPNykgDajINZd67ANOxPDqyKHMHOY1BtB5fc1j+cueOXyZEQeeEVyKCSO5ZNQJLigTYcnTot0ePfxjw6lw5CmmA75fU2NpQbo6uARJPA/6BTH57F8AKKaT72ZI+eVEXveMZOHhIAfJ3UuFr82b8bpgEzH4uK4xIf1oWTHChceSyNEL50YdtRyJIyyYm5NsuH8Emi7tkWUUrjRrVUMwA==
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:27::5)
 by YT3PR01MB8675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 13:08:01 +0000
Received: from YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3]) by YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::206e:a5af:7f5f:76a3%4]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 13:08:01 +0000
From: Ryan Mann <rmann@ndigital.com>
To: "johan@kernel.org" <johan@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] usb: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI
 device
Thread-Topic: [PATCH v6] usb: serial: ftdi_sio: add support for NDI EMGUIDE
 GEMINI device
Thread-Index: Advxm6C8PV0uy1zLSqSOYBBJETwAcg==
Date: Thu, 10 Jul 2025 13:08:00 +0000
Message-ID:
 <YQXPR01MB4987F1E0DA41E689779E6958DF48A@YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ndigital.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YQXPR01MB4987:EE_|YT3PR01MB8675:EE_
x-ms-office365-filtering-correlation-id: e2e43a38-25f0-4ad1-9199-08ddbfb2cc5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3mLsWUd702rJyfPsbamupRfQDV6l5eImlLU6Tu4+Ro+nlL9OvGJTuMHXij7S?=
 =?us-ascii?Q?8gjUsXw6CvXCkWKyGjcDZ2vGoi8jsCcHV7xlAyOuBO9Noem9E/g0hLtxYIXc?=
 =?us-ascii?Q?zU6e6e2dRUxfy9t/VyCJvx8tbD3zcUzNdURK4nK1a6dcsWdcxeAXzV+e2s+T?=
 =?us-ascii?Q?rofH3MHNk+VP88GIIWtjnVAI1LNFI2AaPM+Tt7iPgmU4WEaroT7Izrf4PQXf?=
 =?us-ascii?Q?i8hu70s4kywRkQ43Yho2i6g+I4JMnCkyrLg8BRCI/Me/AZNq2ZcV7jO1yQuV?=
 =?us-ascii?Q?pXPLrLK2FNMcQVOyunV+hEr8tw/gGI3XyG8pNRWIvk5lWf3QLUf/iPiCfEMB?=
 =?us-ascii?Q?kj4adEC/ZdXF6HZJuewnY3G6irJo+Aqd0GPKlgYs9RQ/OrOgflK2i72bFlSi?=
 =?us-ascii?Q?kEnXAN4oQ837+giHcmHdB0YdthaXZyeLelrlM9unBUo4QvKqLaaX7Kn8boaZ?=
 =?us-ascii?Q?gslVLGNkwN4RZCSgePP1pHC/GSDFNTED1PvT/g6juXwxgQwbFzRhQQq26TM9?=
 =?us-ascii?Q?juYtSBT4Wr4FIFmSkZUN+GyFsZN4p39FWpx6PzPtQ1xO4phQnqpDVGQ2hBEl?=
 =?us-ascii?Q?sE/eOhQS6EQjxMsfLk6MsxWjF5KA9qZ9LpmfVhT5IAYJfww4cAh9WBruYcR5?=
 =?us-ascii?Q?lz9QBA2XKGgbG6uYDgO5BhhqVqX6ey84HWen4kHOTQXgFlEu2GAf1LY3bT8p?=
 =?us-ascii?Q?h/v3NUlgVXqZBjYVPVhhRVKBwzWZtIWTp7B2ur07kL1jMXNLNTvorxwnlgVu?=
 =?us-ascii?Q?9SUa7cwpXeFcJ5mkfi3PRe9xG/abAptzHuPseBcL0GIp0/ucOTBs45cjfeik?=
 =?us-ascii?Q?EMDOI5L56nK8r7sqnCk+kV+B2owexhjAP35kAtY7VNyoiyhgamgQMdrkN6qk?=
 =?us-ascii?Q?eOq5VXNurOrZ3HxKYcPV8N5OV9lZuUjAGzDkGJ1mACb0CQ3Whpv8rwW01KHI?=
 =?us-ascii?Q?YIKZQKyROjYrslSFNm4UWG3M/Ye7YLX+BJ1THIkXXFAtKYWV69hsk2NAxayc?=
 =?us-ascii?Q?77yA81szDLEHp5NTMOwn/f8OmHe1Bi8cJu119ECDN9X0Qq2bNd2V8b169e5g?=
 =?us-ascii?Q?0tTVfPuHTC0+bwbmnb9y1AIorBCpXbA/KAFEfuGa+Fkp0f7YL/U57IMLiQL1?=
 =?us-ascii?Q?WzU4QxVc30mV8HZa/AVBNlwTJ4WZItyK35TBHorCoINm45hAFu5MPv1sJIXC?=
 =?us-ascii?Q?h3Jt18M7zm7DTuc3x0nzDr/VVxApr9pk1QLcPUmrl9uPb6D0Yhggcjf7FK+i?=
 =?us-ascii?Q?vn662wQfakcls/q2KE+LCiJTd1i3ARK7NFZHa2sxcC2cXhsdP8u8qj0Sb4zG?=
 =?us-ascii?Q?EHSXMCOKCBo2gvwfii17liKcFV0el28/OPZejwyIZulME1KkcaceR9CQsy+J?=
 =?us-ascii?Q?8BqnQRh/so5d6LYmIFnfKG02f60imClmAihHWAHmFKhYxWS1MvZD+lLyJwTy?=
 =?us-ascii?Q?Vc/zsvuMXu4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Q6zhVOJQiJCa/pZM/9Y/qkNMqf0KTYCp60IUkO0jL2lsgbQx3MN2Yokhrnhk?=
 =?us-ascii?Q?UQEO/DoojclTiSj8v26/41QphSvgKKOadeEtWXx/TWJgBaZToEwDU0LF647t?=
 =?us-ascii?Q?T59KqBwEgmH6jNcNGrkExxmhahSfNmCEx6/QByrGyU8P5bsF0F676+MnxPfR?=
 =?us-ascii?Q?B2W6+qGrT8Si6cvtfVc+gWFadfPgZ4suZeCnOkdBwcGzhDCCBUa1dByexR0q?=
 =?us-ascii?Q?g86q7mf+WeDloWG9crTNwkdwU1ttn5hjsdb+tFl7Skxgj0TjH+Th0qtD8u7Z?=
 =?us-ascii?Q?hXlBDwXWCfeV+YwfaiHnR+Q6QbjaP0+nW/vBFM8qDP3IVKErjwtQQtJjoWVW?=
 =?us-ascii?Q?w2Gp4G9Oo5iUGXIaq644VHmZrXbRBarjuABgkOG436zaZlack2+2Y26t4p2M?=
 =?us-ascii?Q?3wPchH4K0W7X3FSsIKEiGP4bkejhG6JGu5PRbNnDCSP4y+iZrBYl2BDC+Dmz?=
 =?us-ascii?Q?yVkNKHbucB0hMQQhTsxEbM4nIVODW4YrUm3qqxHs1oMq2HCdYqQcujrMcRoN?=
 =?us-ascii?Q?Bi+AHk85R3tZ73pDbeEymDDhDXoxz3sWWkKyI2XqPFFhiUU3tGx3x8pq2DUe?=
 =?us-ascii?Q?UYCF1LkvpFIOvyQ4UtQ6lldzxDac7vAMmd00mQOOWtaKMI7ORMMYf7UFipkz?=
 =?us-ascii?Q?1NVI04Q+dtGTTrkkdIoQsN8f/aIRcg0JL4tb5H+lO5tiaybatnZz3Km07CYp?=
 =?us-ascii?Q?xj4vUS2PsE4WaTE6Jr68OBy5zKF5Jzn3hIru5lvieYW5KeJUJrfe6YHuYvwS?=
 =?us-ascii?Q?Igw1RTLEnTcUZL4nwY/Lq5Co77Q/hVM+vDqcw8KxHydZw9rT1T7tvEBe+/fh?=
 =?us-ascii?Q?FEzyfR4eXM7V0tkeTT3wcDk+3oqDYQOFfM4qN+0B2rpA/6E76pwTSNFvBLnW?=
 =?us-ascii?Q?qhNFu/sRqO1RspQ5nwlm9bp84/BX+H9d2ihc5sbJtVlOzEmybb3TozUPwl4P?=
 =?us-ascii?Q?jg8tCPA62ZT3BpWFl3gO+uiTbSpqQqCvA/1EA2eyviLmz7j3Jjyry3pkiNbL?=
 =?us-ascii?Q?Q4eCtD+bf5XSOdP0T5FbWL0OoeLte3yDeCIAOMwyjxe4MmbFeFLiy2/N430T?=
 =?us-ascii?Q?Kx5+ONJQ2s1lWXnKMdETJl7Eo/VcJ/8SahUVAVC+m6mT7vaO6nvmwBbReCKY?=
 =?us-ascii?Q?gzVQpcRb6OHZr/giT3Dd/qqAPDhXAtqsPobb7y1LzlXXWokveeQ05pUJACLD?=
 =?us-ascii?Q?mbloEYEgXPNgo+E+k5oLQnFhjxDZPwp/ViM0ToOA3unyyK9VyUJoEnwHqiI3?=
 =?us-ascii?Q?MRThBD6RdpLt0WUPDk297LSOBiYRWixpND9fOUdp7ARqOmhxrFEQJXfkaggY?=
 =?us-ascii?Q?B6b4vH7LlYewfZd4EtzMuuNcTypq+lPaq5Iivc4gEs/CjULHQWYJnz7S1U6g?=
 =?us-ascii?Q?6SSgDf6cOX5b6xb24krtgvuPSd1t2ZvtIZS1BL0N4cutpzN6eDv18nN4yjYK?=
 =?us-ascii?Q?8R9Ob+AVKFOS5kZHeJH66jyEZm2ADykw1B6HWCkrg7C3VlPbSZj9DUN1rIo3?=
 =?us-ascii?Q?fQJ6kRx6n41MJluua57m0Gdhdd+Mv+b5gFql5/jRxFgPfg+5+Hc5Xm7YZOwo?=
 =?us-ascii?Q?U8fLaKXmnGc6ZDp95UlzbhX7QDS7laS3gzElJX6a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ndigital.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB4987.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e43a38-25f0-4ad1-9199-08ddbfb2cc5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 13:08:00.9464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fd6f7980-6d04-4a6f-86bf-8f6d0297dd2f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3YoYSvCA4cvVsXRoiqCV8kWtqeii0g8cVChjRTaS7TEWCiXEXkTn+Rq0oaTPWHiLh5MBmJ0z5fFY6slDslvXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8675

From: Ryan Mann (NDI) <rmann@ndigital.com>

NDI (Northern Digital Inc.) is introducing a new product called the=20
EMGUIDE GEMINI that will use an FTDI chip for USB serial communications.
Add the NDI EMGUIDE GEMINI product ID that uses the NDI Vendor ID
rather than the FTDI Vendor ID, unlike older products.

Signed-off-by: Ryan Mann <rmann@ndigital.com>
---
V1 -> V2: Email-to issues fixed
V2 -> V3: Email formatting issues fixed, removed future devices
V3 -> V4: Email formatting issues fixed, removed extra comments
V4 -> V5:	Diff whitespace issues fixed,
			Restored the Aurora SCU device mapping that was removed
V5 -> V6: Fixed typo in the VID caught by compiler

 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 6ac7a0a5cf07..68f425e39da9 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -803,6 +803,8 @@ static const struct usb_device_id id_table_combined[] =
=3D {
 		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_NDI_AURORA_SCU_PID),
 		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
+	{ USB_DEVICE(FTDI_NDI_VID, FTDI_NDI_EMGUIDE_GEMINI_PID),
+		.driver_info =3D (kernel_ulong_t)&ftdi_NDI_device_quirk },
 	{ USB_DEVICE(TELLDUS_VID, TELLDUS_TELLSTICK_PID) },
 	{ USB_DEVICE(NOVITUS_VID, NOVITUS_BONO_E_PID) },
 	{ USB_DEVICE(FTDI_VID, RTSYSTEMS_USB_VX8_PID) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_si=
o_ids.h
index 9acb6f837327..4cc1fae8acb9 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -204,6 +204,9 @@
 #define FTDI_NDI_FUTURE_3_PID		0xDA73	/* NDI future device #3 */
 #define FTDI_NDI_AURORA_SCU_PID		0xDA74	/* NDI Aurora SCU */
=20
+#define FTDI_NDI_VID			0x23F2
+#define FTDI_NDI_EMGUIDE_GEMINI_PID	0x0003	/* NDI Emguide Gemini */
+
 /*
  * ChamSys Limited (www.chamsys.co.uk) USB wing/interface product IDs
  */
--

