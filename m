Return-Path: <linux-kernel+bounces-854571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B62BDEC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9CE8407F25
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DA81FDE14;
	Wed, 15 Oct 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MawCXkK/"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011024.outbound.protection.outlook.com [52.103.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC671F4CA9;
	Wed, 15 Oct 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534846; cv=fail; b=OEYZDUztDYhbaYGpxGTELxiY/3vyQw52Np4TrKi5D06Odft8KweGuYLDP6evUOeB3nYCg+2vdqhxVMah7qoQfghEFiYrAiUxNgPQzih9biIeMR81jSOffdFH0yghvpdJiuHfpo6ULYE/HBPA+s+e/eK53Fqxud0GBT6K2CAaqc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534846; c=relaxed/simple;
	bh=wE+3kZePfDHTHmWUK0eUC/CJ2ugHok430Dg3P1lfeNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeimpWh72j+elpUtpy5E/n0ZGKyazpV0F8OwgL9tHRFhFbd4dXBaTrrOlm3qA7Q0BEZf2negl2ovw6irUZ5xuRqtWJ0g0shaCtxPhU6Y63M6L5OFlcUGMG6fnWUmcMlO7h/FFjP8GIfOIRK4deRob7nLUnzfaoOWrAuW2TGVGhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MawCXkK/; arc=fail smtp.client-ip=52.103.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnobqDHBu6trrJl8qpyHZNlel7gIVd9z6rQtMs97IKbDNxJXEL3un2GaORGHxhhByFETBigEE4I61ygjtVF4BW4Nc10DxB5JbSgMk1gmhtGzsTWqvUgm5GnzacpYwEP1jRoOT4H4IGrAL6CyulCr7LYTBaj4e5bZVa5T1emtt2GJ/+VrHCWNxT13dxNOw0MzQOGoGjezwhTnDF3nlZnhbs28lMsXT1fCZp+itFE3u7NJvF9jlSw3HQ3lNzIYt2rUizDozf2yBHi8EDwP85dMqYDoxdFs2UIKSeaqEXa1kve5BobwTBDAm+gStzoBC6oLnTIqe3oACtaUbEHexRse9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWKajaivtm4+8y8KzO5mnR/T1vsn8DjibTg2MEGCg/4=;
 b=IY6QXMKlZ4Id+gjAt+WdWKMXauSVtr9EdC07GE3/S2pe12jdHjthSVQIbMiR1rgNucoHFTuoIPQU/RLFL7fcoinQZV2xiBufhkRIwMKu6IUxbikCDYY0MrqNg6yEdGP5DIVztscqfhkFIY4wX50h515sdcO6TppCUw4B3jgwY8yc2sovv3tvqLO36R6aKgpRJxWa2r/vPPM/Q6p18afCZOWW00dtG1WYa45091LtXNlibd/5q2zmMt95nTCegzT044AStjXOPklY8qKj7zu8NErFf/lYqqZR3UUsMMhK64trVYOKdHKMHlpFiA+9xNgWFn3+gSvjwD8v6j0J2yJ3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWKajaivtm4+8y8KzO5mnR/T1vsn8DjibTg2MEGCg/4=;
 b=MawCXkK/9tvt2M5T3JgKgrgIehTbfBDIrh3qFVRde1rWv/O3CFouDjZ+qvyE1jufhAL2klOmSsRwbdD2XT92GggEuaomu0XP1Yyly1K0aOvXn8+s6BdJhIdi9tfJuhqgzC3YGMcaguNd8K+IFVvECqA60v8nJ+gle7oEFQAgCPr6tlOHKgsktioUY9xzAAR2jcT59fzuf6AKFXEl0lH/rTR6TCromyeExENgXjQaDeM3SAnjxS0TZbojcEdDQzFqMPuurt//lHis6C9pvmfn8jxmppF/3SMamhdUc991I7G/sY8Na3MrZOHVjwmko94tu1o6+BcphNwVCx72lULDOA==
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::13) by TY7PR01MB13783.jpnprd01.prod.outlook.com
 (2603:1096:405:1fe::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 13:27:20 +0000
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc]) by OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 13:27:20 +0000
From: Jia Ston <ston.jia@outlook.com>
To: "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>
CC: "hansg@kernel.org" <hansg@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, Jia Ston <ston.jia@outlook.com>
Subject: [PATCH v2] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Topic: [PATCH v2] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Index: AQHcPddu5QIaD8h/WE6bgt/R7bNWTg==
Date: Wed, 15 Oct 2025 13:27:19 +0000
Message-ID: <20251015132636.56840-1-ston.jia@outlook.com>
References: <f609dd82-2cd5-cef4-746b-10dfd59380fc@linux.intel.com>
In-Reply-To: <f609dd82-2cd5-cef4-746b-10dfd59380fc@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSRPR01MB11808:EE_|TY7PR01MB13783:EE_
x-ms-office365-filtering-correlation-id: 9f148e69-8ebb-4ad0-e297-08de0bee90b3
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|461199028|31061999003|8022599003|8060799015|8062599012|15080799012|41001999006|38102599003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0UBC+/UZ4xw24hjVdUmxWUpNkLjiCKKXf+wMZSmPC43s28A8nMXZaM+P/O?=
 =?iso-8859-1?Q?jZhadInJrXkkQFUd8o4muufbr8RXqgW9/IrsTiMDnrjocf35Ad0a8B+eoh?=
 =?iso-8859-1?Q?KMRRxBKQq50B57LzjPDXeaazxN0Vb4wuGIL//jTk8KeYTmGcTG16FybaeD?=
 =?iso-8859-1?Q?vA3KKJD/K2spgtKo6hZzj97d+7RjIHt+ep03eb+sp0CCo6mz/Xia9a8gKC?=
 =?iso-8859-1?Q?LZqD0Nmty133SF2zfiYs5ayng4Fm47U6yuanXktJJ4fi3oA/TQDptGUkJQ?=
 =?iso-8859-1?Q?PR4Tx8faiCK1Lqci5PXiXYupTpGE7A/vbDvTKigTXW5aL2KYF4Y0eCQzRM?=
 =?iso-8859-1?Q?1W8hx85+LOZVRUtVAgpbfzeVejDc7MttM4+7Jr7T1jpXUto6R9oWxqNAF/?=
 =?iso-8859-1?Q?YsYQWvVLaj3nu43YIodqz4NF1UP9hH5VMK38oa7CcHrNp1BLBGs8e2j/IU?=
 =?iso-8859-1?Q?OQQiKhJM8d1BQUMJG11ItsbIkSeLYnBtZsNPb06o2+PStd7UM1WOW/uwm0?=
 =?iso-8859-1?Q?zRAJpXJOQ5Uh/Pbey/lZUlKYl37Qv0OOQjNY7GHn4d6SVR01PCPD4tVLfH?=
 =?iso-8859-1?Q?tJ3AnsYdo4/LH6eUnC1woU0tBptavFFf8Yvkp2KBvozn2mfdYa8kILtV66?=
 =?iso-8859-1?Q?98qFt3ZoXzG/LLE0UOsnqOJyuzz0XkhiDnkAotTygT5eEFTyPv2QZUZrXE?=
 =?iso-8859-1?Q?EeEpKxeX3uL6Bbnau48DXVr0hitojq7Rzo5EWdVNaBUwQ1yeWpZsSlHXxc?=
 =?iso-8859-1?Q?FGzWEjaSNVCHtw5Q47Fo0Zq97TvUZc0soibLsO6XtesWUckBamAakse14F?=
 =?iso-8859-1?Q?8Gjebofdorf6tn1jLgsdVnR9QbZnaB0KRn8v0RSv94QB9eJCGW4urPUxl4?=
 =?iso-8859-1?Q?FwzONXcxjKQWeD7uK+1ZgjnhNkZyH0ottq0oY2AbW2g5rOBj7SJtjdFZnk?=
 =?iso-8859-1?Q?TqRhi3GRVW+L3IUTtm0TCZQZod+8YU7s14OOksvjrcgKFNwyxcBK8X2S9J?=
 =?iso-8859-1?Q?2w4gRXXs1UcXikapakKgOnGrsxg7VfbjlQrlO0wS3mAbnwN1HUOzWgRTxx?=
 =?iso-8859-1?Q?XBsR0zMG11iu719i9Az2aVi9Ri5MpUkVqbbASj37g43tQsdKqFizw4QrVd?=
 =?iso-8859-1?Q?EP7LO1utCvMBIRiQOsxvDcmyCGCe3hcn2PfmNAuqR0tJNO9L1vuz4/+ANM?=
 =?iso-8859-1?Q?hnydgkEELRZO23/GAQFJ2Sw+Vn5s8BHB59VGy/sHFMXiedGBl8OKFIHAMI?=
 =?iso-8859-1?Q?JlZwDEvup0iNXCSh73+CbKaxYeiZT+vjtewF8A+7A=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gOiDJRknLYGJ5wntBNrvgeHRc1lVWQgOhZGUP8Bs/nUR8ubCtWICUcvDkj?=
 =?iso-8859-1?Q?PPNDxjtl6Ewa829Vl7fKnhjiUPSvfW6pMT2wHiZKi/NFrhTmff0QTA65yW?=
 =?iso-8859-1?Q?NXKOa0XCIuqk4Fzl99Yd92qShOpbIJGgL35Kd4leiRyQW4Kobb9HdUGcQD?=
 =?iso-8859-1?Q?LxN5Q8GZqVktdL2zLew0nD2MUOiEKSC2FT6a0YWOgM45qrk3OI5ud1KG/R?=
 =?iso-8859-1?Q?ubEnxq9hOqXpFkm3YWR/Q29lzrXdMuLBSqnWPWhWSBxTw0PehPWdWXSNDo?=
 =?iso-8859-1?Q?iqtb0cxc8FjKy9PenNNOtSAGIQMeQbKOCOWOXxtBitCPFPgfoholgUEANP?=
 =?iso-8859-1?Q?CwNbRaqy7DOrdy3SHfRlqu9DVkraA4mC1519UOhBjZGe5klf+rF/ktF+PE?=
 =?iso-8859-1?Q?05cBiPp4BAvEuwEnCpgwywm8denzZGseSGT0aPCaGA+g53CZEHViWwiaci?=
 =?iso-8859-1?Q?KVPT1iRMIM0T+W4J7uIsnrGU10BJqfBcGkay7f+/XoUI79ZMeZRkJPRemN?=
 =?iso-8859-1?Q?6P31SySgq45HqJcucmz3f8g4POzT4Yb0Mor5xZPFI6IUJvYmQ2tP60PJxx?=
 =?iso-8859-1?Q?otiNkxkLVNPPTNJWzgw9/WluVp2CsMOMTPnNG7NyGmE0FPBZB2tXQfxSKH?=
 =?iso-8859-1?Q?jG5FR5eS4FvswQF4rsevYI8lXO/Jx+ge+iRstTlivRs/WtqsilJ+vO5goe?=
 =?iso-8859-1?Q?H/CBWUVy08sy1KBLj6wdYJBKqCkYKAHcmfGCCAYN5fyvd6xjP+OybZP+0l?=
 =?iso-8859-1?Q?0zZb3Hl72LhKbROSFC8DlLnLSx6R3xhFhyIBH9xEGGKUVJ4DlLYFJQfjcy?=
 =?iso-8859-1?Q?MtHPsRm7slAYZPtjTVU3OtsnCKWl5g7gTdYNCCq1Bve/qb3nv1qiyMqJKS?=
 =?iso-8859-1?Q?jQAC+n5aKkAUEz7lPsaX3uggUv9VJGOXx9Go807JIbkWoTNnGOi6LSENtb?=
 =?iso-8859-1?Q?euEdRzE6uYqz9cpk+1aqXMuvv5csfmobGl2+hDX95kHF5eP1A2qSUREV+I?=
 =?iso-8859-1?Q?bnWjtVxG30X0yX21/GS1oTdt7GIoXAH+B7N9SlB6z8gm7WDMaf0bzQcOXN?=
 =?iso-8859-1?Q?y4JQXb1bQbO1PAaU9XF/r2SofZoRlbqoeYGNF0s5BFyMMnF9s8+EjMkZL+?=
 =?iso-8859-1?Q?6XzVqLAHJRGpkFlr5QpoyPNr9HXBdm6zOSFwIpkWY1NpF8huBEroUsHFAG?=
 =?iso-8859-1?Q?lLio1l2WJWDmGNjem99W7d1qCfIqYAzJrC/AnCKQaiyJv/8jrF2FSs/0WO?=
 =?iso-8859-1?Q?16uLTkPhBBSIAhucNpni3QiVQCCz0GXh+cuXoAPxI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f148e69-8ebb-4ad0-e297-08de0bee90b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:27:19.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783

From: ston <ston.jia@outlook.com>

HONOR MagicBook X16/X14 models produced in 2025 cannot use the print and YO=
YO key properly.

This change add key_entry for HONOR printscreen key and HONOR YOYO key.

Signed-off-by: Ston Jia <ston.jia@outlook.com>
---
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


