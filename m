Return-Path: <linux-kernel+bounces-875127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF2FC18474
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E60F14E0424
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F22F6193;
	Wed, 29 Oct 2025 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qf7dV2EW"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011034.outbound.protection.outlook.com [52.103.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050B23C38C;
	Wed, 29 Oct 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715123; cv=fail; b=cpcGfkx2btvr7z3c/j615HFQ25GOa8dinuzWXt+dWbjkCDFh/tS0N5iiPXjP9n/Hewsg/FtqLVqRKNh9VMxiaUDN5GdWSk0wRN/O3llxQGj2mN+wDxkJU8GWsLqpUOmAufXuTPJpYw1DCE8Uau6YMTHjVEmtpDOl5gqvFDRyGz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715123; c=relaxed/simple;
	bh=+tBv5gDAtU8An9kAciz90olQcMj+qrTjfi7vyMhktT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QE4KeEOW20CFGUuyF5NJeoCyenPJR1yQsYp942gL+qTNRcNd+3xFW0XwPEDk88SSOJYoZaroGQrP0hSyNvsOT/uYQN2jipavHQ9ZbNsC9NyhdCB+gmuU80NfrFlPvD/Z8CQP9W7sAbK7lyzOfd31VqMA3R5mzlCVjWQPgeMC4/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qf7dV2EW; arc=fail smtp.client-ip=52.103.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3oIsNP2sFXf8D+tG+Kfr/WX6A0WygUDOHOJIj0B+pyjV7Lc5dVqdcl/UtoX69Dftsdwit7VU+gUkQSCAWf3ExwlFp+BRHZfTfBSlyj2ngVMipEZmT/wjbWIGGfC5cne9Ayu5KQirMTcEbSOV9raUv0Y5o/73RyUpI1INYhzNtyAyunLeL1SHpPw1CD44VWIq5PH7wZx6N4/S7tjq4hMJNb0mIAXrO3RR4SOYbj0XFXdWfxsHgW/k5lUhzgvixekKvMzEfSC/vFWhpG8rom2BApY2UT008ULhCi49SxZDY4NzHK4gFiA/jaSNXJT/jF6RmmAyTnxvLI+7ErQY8S5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjsLp/M+vgWXmPf/vxh8222E6EpW8bTmu5eCMeJ+odA=;
 b=ZaEIdMah6cCyH7ZTXg+VJLZWzNQlOl9GQRGlHVc2k/XHFCY4xKSvfGMFzDAf2xlv7AVkAxscMAfdJmfgrUi4tbxyOdSBtgsyVPh38QTJzsn4TFKu6PJ039zaanmYMkq3Z0k/7ovC9oidT+LWcC64cwSzNoqSEu5brJnp1dRiHeywRf6iBLubQz9B4G2ud4iEKVgfbAGK6iqZzeEE2vgCc9gBSaq2NwOdF70YpkS8GP4R5B79huCSSXeDcGLZWBkmgcLgiSddyS7DWr5oXQW5uhI73wIlJFOvQ64RrMnF8VqzreA8HdepiW6hb2+42NFJ2KhZgEyBnRsJq87t9xLNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjsLp/M+vgWXmPf/vxh8222E6EpW8bTmu5eCMeJ+odA=;
 b=Qf7dV2EWFwOpagjDIKyJFUDk40CTH+8j7e/DiuHmEb4a27jPP4cmU3fHe9mYtXE9T/DYg1B9O7PpVsaKOWWTgfkg3SReQsQVWiE5B9Fs+Rm594KT0sYqo5Rna7MnwwJlo45sDSZehUDqPlLGn9+fom+qL1EqXGpNqN3GjF8G3SUsgIXOPywcbXJcBv4S3g9QhOxtYT4FCZHTdzf0Uvva8BOi4aIvMc4ZoMAiG82MS3QV+BIKCvQB2Yqpy6lXhXKBeTfCAv20eTUj920VqfylQdWw1CgKDnISlJgHbMW2nz7kpv6ZL8dO+C0FIiuFQQY63US/W7cI1Te0Z3h5ti7uiw==
Received: from TY3PR01MB11842.jpnprd01.prod.outlook.com
 (2603:1096:400:40c::10) by OSZPR01MB6939.jpnprd01.prod.outlook.com
 (2603:1096:604:136::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:18:38 +0000
Received: from TY3PR01MB11842.jpnprd01.prod.outlook.com
 ([fe80::179b:c587:8d2e:1406]) by TY3PR01MB11842.jpnprd01.prod.outlook.com
 ([fe80::179b:c587:8d2e:1406%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 05:18:38 +0000
From: Jia Ston <ston.jia@outlook.com>
To: Hans de Goede <hansg@kernel.org>, =?iso-8859-1?Q?Ilpo_J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jia Ston <ston.jia@outlook.com>
Subject: [Resend PATCH v4] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Topic: [Resend PATCH v4] platform/x86: huawei-wmi: add keys for HONOR
 models
Thread-Index: AQHcSJN7qnItaWt9h0m18EAQS3ywgA==
Date: Wed, 29 Oct 2025 05:18:38 +0000
Message-ID: <20251029051804.220111-1-ston.jia@outlook.com>
References: <20251016102137.92110-2-ston.jia@outlook.com>
In-Reply-To: <20251016102137.92110-2-ston.jia@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11842:EE_|OSZPR01MB6939:EE_
x-ms-office365-filtering-correlation-id: 04252215-8e50-4b8f-f27f-08de16aa9de9
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799012|461199028|41001999006|8060799015|8062599012|31061999003|15080799012|440099028|3412199025|40105399003|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?5XtoyfYDJ6ayJwjU3qgLdCYZRmyEGTaXC8sSvHprl+p9+oKrrHnIZVq5Rt?=
 =?iso-8859-1?Q?NdHWrjqezvyltFoOiBK/PbTOcpWtVkiDzuT0xmlRHySpUGnhDCs1o0o/hi?=
 =?iso-8859-1?Q?wZm/fvidqd7HOa+UTYtRYZfI2kutDgR3JkCqSEW7pMRzW4WniGfDgIdVJ+?=
 =?iso-8859-1?Q?vkrw8XARhW7jyLoTO2HLwQNlYti+XPM2WKg+fQ5v5WxGFhgkLbO+y13I0B?=
 =?iso-8859-1?Q?DEpovjOLnTxCe2iynq3RVKIy260wED2orzqQ5RvCqqusoFt98DlobnUWxI?=
 =?iso-8859-1?Q?4GSYWW6/LdIvGeEan4W5UhkFb+nud0mvAPIPEAJ9uRLEYfB6/HWTUjOE4s?=
 =?iso-8859-1?Q?hI/voXIS3ljPyLWrUDjA0JC8OdHqAok9eOmDXK3u8E8wiVUKr5cJnGrfiY?=
 =?iso-8859-1?Q?nHkgpSaxb8+R15kktWts5X12ywKXxEWwmlDs7dVlvrGYdTJeclJmaN+0n7?=
 =?iso-8859-1?Q?IgVYcNmGUuJD7uHJRxsUn8pSS3YVk7P0DX22nsREh4JvdOpn1t+ARK3bKe?=
 =?iso-8859-1?Q?9pApIZN02cYJ+9gHp/shJNIfu4idSqzrXhCN+/kjy0cUH0/tiZNYiSSLEt?=
 =?iso-8859-1?Q?6YMsaIgA1uYPLFHdvwaG+Xh4rt7+AJKWhDcAA7K7vduoWmMjAmPSrPyiKp?=
 =?iso-8859-1?Q?fPCJHIgJwfb72KltXfQ+JqEOurX64LzVuz56+gXz9EOT1KNHXOQabp0n0+?=
 =?iso-8859-1?Q?cT8WhQyvCHujxsIuQ9SUtlQlUYhoxLqjaDhoPIdShPWxskFlAMtD5glUYR?=
 =?iso-8859-1?Q?t1AHgtyrjJLmYUe7mooLOks0DFYKVZ67wE/Rre4FnVR4RHuoo4xFNZzL6Q?=
 =?iso-8859-1?Q?JRM6nomfYRspnDJzl9SmypgKcJIKBJ4voFAOMsV7Pdrkes05xrQE7wzTrF?=
 =?iso-8859-1?Q?IwFsWqlwJDDDX++AI9XevhhTMswOBSI8+ZdIMHy0RRJR35Kdbj26UBFJ8A?=
 =?iso-8859-1?Q?l2lnDXq3RO1xcCrllwpDoH0lkzrzKlG5tVeltjqt0/2sz/WLQBOvRzU5+v?=
 =?iso-8859-1?Q?JV0wAI8dov3LYUwq2Wy9PrpZhtJupMhUwWC9vGJHUTA+78SbWPVO2VZcMW?=
 =?iso-8859-1?Q?RfFHH03DZDRWklglmeLp4JdNjrwjh+iJN+0gEB6YVDoCmLgtfQzzGWYOz/?=
 =?iso-8859-1?Q?dM4dxqyTEQPgjoIq5W8ILgQOLOzQjBCZcLW/Dndi0KBBjnhYOBJcjIuHRI?=
 =?iso-8859-1?Q?JTKNVq/lynVw9s1Hh0yrD3JfiZE5D27o1dC7JFPPLKOxkRI6ixJPGXDcMn?=
 =?iso-8859-1?Q?fZZSr02NtD7XJ3+x6NmA2ISQg2ztrbMZ8CUcwkLXY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2rNRcKUt6WUoXbrw8NRR+Xu3UpP+eDM1G9HDIEKJTHotCtURgkzVynzjRK?=
 =?iso-8859-1?Q?G6pfMtXeKpIIaPsOCKDdfIzVjkN6cj53ovthVIevj1nsiowVODg4mJzFsE?=
 =?iso-8859-1?Q?2w2J3hvhRYX0Mg13Ke+ZlL2kBqa+qWPlddNSYaNLUFJsrHga13Q/zHwcBb?=
 =?iso-8859-1?Q?Y8Kjq8fnWWFxlskr755psOpNMbVAHyM2M56ZYG+Eu7pU5G7O3UX64gdBNR?=
 =?iso-8859-1?Q?FJIgLyU9/n74qf3XRNV6wYYW25oQVptJ4MQ8xZnxjAjlxQLbtTOYmK1uud?=
 =?iso-8859-1?Q?TUxJno6kCabtKXVwblDRiAnQ1Jj9rW16nkr1tTaFliKbkL3mEKMX27uBoW?=
 =?iso-8859-1?Q?nfPWqcRAR3xbqeAICm6RSsjtRjniS3vPkhs4YecVeGbBZnh3CHRYeCACH/?=
 =?iso-8859-1?Q?Zoy8uohvo9YiFPr03JVQKVjD8vq4u9tbEOhDXyjYzxTMF8og/1WslvyoSS?=
 =?iso-8859-1?Q?5TZoAznbmV8REJhRQNSXs7g2F2WvWsF1pB9h6J++nU1Q5WAUqhyhE+dsQR?=
 =?iso-8859-1?Q?FeSQvDuhuq2zyEfP6S4T7p4LSlWd33YOGTHNBpbx3j3OFDkorb+XyyZuWm?=
 =?iso-8859-1?Q?GCL9/kaWAXqjw+VtftR64M2O7UIjSSjh7RBweKG9/jiwqoDI8vbnzNX/Ts?=
 =?iso-8859-1?Q?vIlYjNeWrvPeTuIVFlqsS9GT3ptWQIp+Muk3afJuIjVF5Iuz47ShV6X1FS?=
 =?iso-8859-1?Q?E4U3SWakXzSP+k4d8s7M4MjznAphW98VHE2voeY6zMgh+yGMWUNiWmsOME?=
 =?iso-8859-1?Q?EY/N4lRYRNKMYsR1jsONX5R9WesMHAykXxeJjWrZ1jFAykMGukxABI5erE?=
 =?iso-8859-1?Q?DIfsv7lEl7hbHfIQmgyEc/RpF67CcWU7cGozsoSpksM9dt4geAx/3Kyvye?=
 =?iso-8859-1?Q?6Vcs5G/Nu8N+xEQhnklSBkxQxMSgxeUfRjd4O2Xy8YJMAjhcnO78nN8bPD?=
 =?iso-8859-1?Q?m4ZAhyAv1pKEke7e65ZUC5QflquPL0uLNnD9/sgGHB860gHa72FqWsZUMo?=
 =?iso-8859-1?Q?sZ24Orq6NqgpucdCbvjlPtvjLBpPv4P78B1SDADJb8FCjtKzOQLaquowS8?=
 =?iso-8859-1?Q?gxtLMoKCiFiKx+lTEMy6JEUR6L4q1CkVY3ymqXk2o7rpJFaHX++jSNOAsI?=
 =?iso-8859-1?Q?Ew51zmJOdvm9aX43LV0FjhTueTWohZa+exSCbsULyBg7JTjBK88YEnzfwH?=
 =?iso-8859-1?Q?Q0/DxhlagT3NdD4YZPwcrw6oUaUlb+YN0ycd0axKRgtiD3VtVFvvogNNMk?=
 =?iso-8859-1?Q?FziWVMle8sVyEAnrZ1cA=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11842.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04252215-8e50-4b8f-f27f-08de16aa9de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 05:18:38.2185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6939

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


