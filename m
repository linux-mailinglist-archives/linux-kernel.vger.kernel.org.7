Return-Path: <linux-kernel+bounces-855994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2787EBE2C03
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23134E0585
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 10:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA45328633;
	Thu, 16 Oct 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fllWyrp7"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010004.outbound.protection.outlook.com [52.103.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C594328628;
	Thu, 16 Oct 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610223; cv=fail; b=Kv9p97zjZJdDmhYZNOtVsrCxshbyK+5j+lPrN+QYvSEIXXbIQw6xlaA2O1jxqdORwPQcFZaBYP/FtTw1j9rjVrDl4y8bnZmXbDfUqWwJc9HykEnXQGzzr68drWGKCxDxvgNjVxwuSDfhakUutTJBqHC+vnjP+mve1j17qqCCg64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610223; c=relaxed/simple;
	bh=+tBv5gDAtU8An9kAciz90olQcMj+qrTjfi7vyMhktT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N550MQDwaTm+OT07jeqeXbtFpVhFvYqE/LH8GNED4wEVazgB4fVHwby2fbYsI70eAUK10DV7SYTwezI5lJUUXX6OYQQ9l4W2DUU/JWV56wrBolwLzkbpt0KZOEu5/bP57QPDKoL9eBkAgrw9A/xsnfyLrJWj/o9lIfXOqDvUxkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fllWyrp7; arc=fail smtp.client-ip=52.103.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW9fZSiV2Vqi/QTCukbGNFiyNCOUY8pdFOdoK0QbrpsOJHATTHJ/LjCfM7D50OugzQa1tF24lCc/feDf1fmha+xtAnCdxYPdvmX0H9BWXHrJhjmftBgUZ7+ZGYgRiKPlE5kAvffrnsh/711WtC8KzX204+ywS3VVS/L7WoJrX/DhoBKnoZMACDhqFWjDippq8iPSsGBNEOaL9b911ymIswU3iazThnBTQmhAMAKx35nWGAk1h6Rv6YaUcTVEXxSo4G14cll6o2E0UvcE6+bNm66/FVmU5EeSUrusPmjMP2iBbDCzDoAu7z8ZiNWio06Hpt9xCeYr7w21eX49yoOxMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjsLp/M+vgWXmPf/vxh8222E6EpW8bTmu5eCMeJ+odA=;
 b=aEYbwllEmEcf1C9+5f+wn29xWmMyloh3dxKu4n2lbWPdCXufeeYeADD2GLQJ66j8x8NdexfAFgoIO/XMDb/0MUYacnlp04wHxVXL11k8mB3vMGuESu1bgg9HZ69CqbrUtlDfsoZ6lVnV2ZKz4TnnrqiCuAjnYSXodJwPXO6Ww/u8/nJkxUNq70DQSXjGV9vKWUTRNuYWk+Coan5zQfhcC6npF0//Np0R6cUGIl4uAQfOwYI6gnNXS6bhXAM5osul4JWJkm96HD+U/0TA/6S+7+icYxZixgl1Rbzfe6I+vS1tLnoYxqdz5IFunFo+FUeAllkj6oWt5ebI8ZQ5hUW3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjsLp/M+vgWXmPf/vxh8222E6EpW8bTmu5eCMeJ+odA=;
 b=fllWyrp7RoDkIIZavDQOZ1A/+w8Cqg/9Akv39oy8Ge/Xdw3MpcVZAnnvtIpEGfcZ8AxzFuWATuvwT0/nYazOCqRfOCqLwOFNGN14dUnFNpfzDLdijtGBOLhDpmIZRCVhcDrVUiu6t8GEb6ZOva5TGJSmdL0UrClJVlEQlkDR24F0LUYgx0QWCF6ASZt69sPOWyGG7va7iyLBt8X6XS+gEBuIlFfRyp4yHcpP6xPllSv1B2GungiBORrHunNZwXSwFUNJClpBBGoqPTlVjyi89lzp3Y247Lk4xqCRhGxiEXkJ8W4ZkV7EMwiHzBBXozlaX+LA7bK15y4MFtU4+y7tVQ==
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::13) by TY4PR01MB12909.jpnprd01.prod.outlook.com
 (2603:1096:405:1e5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 10:23:37 +0000
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc]) by OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 10:23:37 +0000
From: Jia Ston <ston.jia@outlook.com>
To: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "hansg@kernel.org" <hansg@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, Jia Ston <ston.jia@outlook.com>
Subject: [PATCH v4] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Topic: [PATCH v4] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Index: AQHcPobuFFoByo5DIk2nLo8KtKcKtg==
Date: Thu, 16 Oct 2025 10:23:35 +0000
Message-ID: <20251016102137.92110-2-ston.jia@outlook.com>
References: <f609dd82-2cd5-cef4-746b-10dfd59380fc@linux.intel.com>
In-Reply-To: <f609dd82-2cd5-cef4-746b-10dfd59380fc@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSRPR01MB11808:EE_|TY4PR01MB12909:EE_
x-ms-office365-filtering-correlation-id: 4e17c3ef-c8a3-4a3f-02ec-08de0c9e10cf
x-ms-exchange-slblob-mailprops:
 5fu/r660v9MHSDx/iaeYuri4/Uqx8pWIxLmJZAA1VIxN0HhY8XH2Ufm3nv3ZjSnR24REOSpybQ31JLyb7HhBKDNDBM1j4hqOBEt9MCyCvAJGY47QPpRQvo2h9b4UlxdU38DyhTpJSmL8L5qBOUPahQVGsMGwvUWjz4ttosXWU+wsx0K4lOMspYz+OV3Z0G6wICm6MefNaCIRjcCHyxsrSbfN7xl+dYpX5aKMR66QP5nZdMa2rf9Ru9O2CD3iavEN2h9cWIbeMFVo+aa43mb0lVr6gnORyDQbXRKOH28SE/l6SGVzgQg5pSjmBj7CYsq157olesLrfTeKB0ihTl4Mq7SB4n5fo4Su+KfBXfzyYqItlvKExZY+x3no82Y3tBGePg3B70PXRbzb2t9RGd3jphv+PK7gyzbEgK6OZsqu5WQJ+dxQexfuriAX8KaHBiYqjbmTk9RMPyUnLEOh/Yjuo2UIhMFlkSqdxzNSPEqEvWn3MCg4uIHvxvDp3Oe9I8oCZC0IkVgVCapejHBiSOyKZn5GmE19vEfq0oXeRyVcWzdXQu2cBqa6BmidRPLSQ1XnXmZD0AHdMs8LMZ894Ji3JzJTOHIvq5xWC2fs0E8R92wVTBFw9CmDzp0O3RV9JOKR9UBO9hGPfSMQpgs74aLs/7/Fa2/VxQ9DvRS5NCz3gpu2x3HgDs3miNzJNcMKibcsANyoLZnI12EqYSSOjZQ5JOlxLfWBXn7cR0ct7vFrPZE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|8062599012|8060799015|41001999006|19110799012|38102599003|15080799012|440099028|3412199025|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NDXM+OdFSoNBLW7RsC6thlEsUjNKhNNaQTga8Rdbw2LezmLNl0JSg9aJjS?=
 =?iso-8859-1?Q?SokboDP+KjqYxTcHfCZAsKuMtZBCk7P1gq6YAYpOw4uaz/ZrKQyhHTk0VY?=
 =?iso-8859-1?Q?KZZbsj1DyKUYt/G9nHSQvLw4xQAfAtB932NEPVubscLQFYCYQ7wprNq/eR?=
 =?iso-8859-1?Q?JPp21qeINav39sH2UnU7waLtj6WgLqIw8IpcFFrxuQ0B0vGtDuqNFVYH+m?=
 =?iso-8859-1?Q?4oclZ6QD7+BlvFzrcOcELa3RE0UQVPg7wXHTi2dSktzly/unuX4tqFGUdu?=
 =?iso-8859-1?Q?PNrrudk4PpJ1zFDUmnkFxRnPZ2DqeskVNQXJZ9iarzEmTC2Kw4opU5dA+0?=
 =?iso-8859-1?Q?KjrAA2+5RbzpvPeXwY/94UbcstP4I2cGyfDdkQ/i73T8FNQLxFTJFI0PdA?=
 =?iso-8859-1?Q?qJxe+2DXiOS9OsZVHoXXaDoUBhn3Vaq6zRV3Y1KZ2VofFmcQyEVfm1Nkz2?=
 =?iso-8859-1?Q?KOf5S4A+jlvWwZDqDx7nlVXk00DYH22Fyjt0MJtaoNi4IU2mLYyuhJABhz?=
 =?iso-8859-1?Q?PixscKkhlNY8cLKrh23erlL3nA0BloJjLCp6+lqpy7jXsqbZye5jQCsFbG?=
 =?iso-8859-1?Q?gtmfVWugTEk1fbVCaLQhTifI7pTVSDaH5OCwN7IRj5PGOTUC5CT5skwatL?=
 =?iso-8859-1?Q?Ykd8N6WwF2+lKFzgGiLhRRc0pvEmhn9u46AmV6l0DyZ6Tes1CkyvzUUpmq?=
 =?iso-8859-1?Q?daLCtgWFBDUlhNSs3rpDY6JlK23ftnBUun0C8c21aX2wNdJGKNO27vztay?=
 =?iso-8859-1?Q?cZxpE+wlZh5HD4RANSqkNagT7r7gfqjABd2wE1xVRdKsYwYeikx61S7Hkd?=
 =?iso-8859-1?Q?k1jWYoRp7OdNQ+GXdBNwkLyqJhnL4miKGyLjlYAIAYuiHLUywBm3waRBx/?=
 =?iso-8859-1?Q?YWQXcvC6EjsATNVDhzlDcpeijlMOWkDgrukDU2gpIX5mjAq6ahM971ZvAF?=
 =?iso-8859-1?Q?QISbswfQFUoNFzwDud2p/oOWIWDb7+i+fyy5ZYpuJ5snFPrPaIel3pPwPQ?=
 =?iso-8859-1?Q?2W0B0f4oEeDrbePrQM0Obcsc+GqjP6OIXjOS1AnRicWVVXs4CGZk6djLYp?=
 =?iso-8859-1?Q?wzOQi2QwkfZKGMBYxnF+PtNR/0hBQX8lXSTT+GkP/d69UTR12uGt+5ErTa?=
 =?iso-8859-1?Q?ukLK/pW9T6cKoQshEXPxbr4nFxPpLl8Bt74lJ2oFcBpuvYDiYfZTWsFQ/S?=
 =?iso-8859-1?Q?K0L2obtNx8K1JEVHhyS13QYIFz5mTDfU9XsLzp/3yIqwCJiIcWZ0pLUChA?=
 =?iso-8859-1?Q?DeRRHsSupUeLyDg+ML5erA4L0HWRLRCgcrywd/EBY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uiVkdub/AinX50Yj+5Dzqd7HZ3NlD3aMsmNAZr8ciCfz97Q+lSSBZrHEx5?=
 =?iso-8859-1?Q?YI7f43zBPfM8ca57fWwrGVjNgq1R8AooBa5NBmPTF1lwxZd6CqsNdxXxss?=
 =?iso-8859-1?Q?S8+EIQXRWrvXoGj5vg3ZPn9Op4BXfAnmcEja4Nb6EKb2OllYQfiybQ6m2a?=
 =?iso-8859-1?Q?HuIOYNSXvvnNJUtZG4hKy/n36RfKMMTw85N5JA59jtql1Fz7hT0AW6UWCw?=
 =?iso-8859-1?Q?Q7x+whmb7UjSBtHAajWDnvhMM9YFoJ2REMs61B/4Japjqhzj3VBK9gkCbo?=
 =?iso-8859-1?Q?LNU8WC8uRpWtfiJLQzM1Yug0QVy2GautQmRJvl+OkJZLvzg7qxR3zsoKwm?=
 =?iso-8859-1?Q?tPit0h0ofTVtFtL1CFoMQGyry5HRy4m5quhD5mJGR8EIsRPJDahqqzrlJM?=
 =?iso-8859-1?Q?HHrXM63wna7KGg9kxP/3c+ZEYgE9cqJ9f5+s+dUVAHVTbuE6oWxV02zqtT?=
 =?iso-8859-1?Q?8Rj56nZaOKHpwJfmy9KKMhiAc4L6Hf0CsGNnGfJ5nWjnkuYyba2dDRv2rN?=
 =?iso-8859-1?Q?e+zosQe+vwERIjmGc8H1TnDR+vVtnpkWJKOnDmXrRviCKXR+wUCBcx1hEi?=
 =?iso-8859-1?Q?QpEWcu7Br/68mS/210GYmVsfFdTXq4vDuNCM+IC2YdGS+oIInSliytHhom?=
 =?iso-8859-1?Q?FZ+m+ZjBCy9VqWqt5CmE2rco4XEn6Y7SLzumWs5NnvrAbUflxh5QBOJoid?=
 =?iso-8859-1?Q?cYziuIRAWCWSMDRi4nITDlLY8rUIQVcwJdqYJCMciej4hqlFCE6iNGGUuw?=
 =?iso-8859-1?Q?MEB1zkYR1LxecAU5snxiNYGv7znPIBr9a7qoGoNpYZxiempfMVAHXOGXdv?=
 =?iso-8859-1?Q?GSo/RwrrehI6xrB3ITd5MVGGSnNEb1jj1siKlIXCCs/RQF9cSRD/xUAgPa?=
 =?iso-8859-1?Q?veSmC3WcvhC9dV2Ufm1a+XNiTAQeDRCT6nntvwhVxRyEe7vgmoFLE2mOmP?=
 =?iso-8859-1?Q?2Y5otP+r0oIgiAWPvhdGuvUk3Xg5Y/TYzTtAeBWZMy2oFqsutKQ2vcJO2r?=
 =?iso-8859-1?Q?fIQv/b83b68m6+jNFcNLRzsBtgWgofbLO92Sw/rqMvZDhB8ouFBxPaCWIg?=
 =?iso-8859-1?Q?l+ukJmCNy6zX5aq+NO42mQABnY1XrdBKYhh8FTD4dSUMBbg+UnzEWGO/Db?=
 =?iso-8859-1?Q?nSqs9+zqnczk64JOwDTuna8RLzkwPFLoxYoIM5OfDJ/tWaFjt9MAvzHAcp?=
 =?iso-8859-1?Q?zFiI5E7pgVRGj46Kg5K1LUR9cbtwWloi6PxWLGfuY0Dzj8e2Xs5duVCrFX?=
 =?iso-8859-1?Q?mdb1ARvRhF4hcJR9xnDg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSRPR01MB11808.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e17c3ef-c8a3-4a3f-02ec-08de0c9e10cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 10:23:35.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12909

HONOR MagicBook X16/X14 models produced in 2025 cannot use
the Print Screen and YOYO keys properly, with the system
reporting them as unknown key presses (codes: 0x028b and 0x028e).

To resolve this, the key_entry is added for both the
HONOR Print Screen key and the HONOR YOYO key, ensuring
they function correctly on these models.

Signed-off-by: Ston Jia <ston.jia@outlook.com>
---
V1 -> V2: Add key_entry changes to commit message
V2 -> V3: Add error output to commit message
V3 -> V4: More detailed commit information

 drivers/platform/x86/huawei-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawe=
i-wmi.c
index c3772df34..8a4c54089 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -81,6 +81,10 @@ static const struct key_entry huawei_wmi_keymap[] =3D {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
+	// HONOR YOYO key
+	{ KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
+	// HONOR print screen
+	{ KE_KEY,    0x28e, { KEY_PRINT } },
 	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
--=20
2.51.0


