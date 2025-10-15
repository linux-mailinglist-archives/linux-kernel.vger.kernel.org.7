Return-Path: <linux-kernel+bounces-854599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D4BDED1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62244F0A89
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A662629C;
	Wed, 15 Oct 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dM+Xn06R"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010020.outbound.protection.outlook.com [52.103.43.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0634E2AC17;
	Wed, 15 Oct 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536044; cv=fail; b=h4q4ZdB680hA6pzMgTAXgYcvUMZFoFvguSvV8iKVbvTnq50wL78tTO9YkKGUnEzXVkpv0ZoKMzAb8eU+sS/FNI3aXFdkcDvz5juI1Lzga1297nzrGtOUVB1q0Vj4dXQPuzClkPjIXw2b0DvlOhXnqQWUDsaJK7i4p8hlA54ysfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536044; c=relaxed/simple;
	bh=5NLJnb+Pr+ANy6zWy3m3fhBZXeDFhTZFSRCsZ9Zn5CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tig6UkXRzovO3dOQ9VmB4rZKgOtdMwXdG959EJqhZMHGtHFv1AARVHbYWFyudQ2VrV7SyEb0dR8F5AxKaqF9Q54Mcb/D/+RUC5BygtTteri9v2CGGBpRPtEM3Be7zSk/x57RsJ8hC3eGAX4d5HW3DWSgBdNomvorrI5Gs1VuL9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dM+Xn06R; arc=fail smtp.client-ip=52.103.43.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq8US/TX59mnKvAYKncTmhmJ/I6bHhZ+FdrZR0GmgouCpFLMHVQIK1xRzJ2PVGcOGrIHopbOVtR2arRVHiduW9eEJoXYWlJaW2XC0SwN0JUqu4X7w8MV+hV4fd21FZGzoVyFGOI4rckINCXCWbJy0Jqw3AXpeAA1VlxUHiq2ysfE9vovN76371BgFVPxSnZ5QeUPVEiMY+ZCJFrL/P1JHnNiNpVvXfwz/+6Tp0FFZbtxunJcpYN4Li3l4d/7zJ53qKbWJQMRTRwtvwi2cmTm2DyeOV6sOOQkrYKG4bmR4fB6XKfXZtQw0nFl07TTzj6ZKfkkKeixxlNzXQm3kH2KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVO8ol2L7A6K+OsTpp6ZY423p7OJEiPxqxFtv363TEo=;
 b=M3t2oPEJlk8zbefOf9fWqvP4hi8T6HUquuUzS78auBy6RIFv1qgZLVRZlS6SuiZxijimaaNUI6lygKLBI2gQo0AjtxNs/GMwP1txdyB4acVq8dOGtmklk1UQco8vuwoHwjw1H6ChmQXk4lVUjDWp9uhrtgnXuSjaNsu5Qux9Pm/tEhAEKknXdFmToIH9WoFrxCBkyhD3kop+Gzx5ovyXoK8Na/MTcjhIvm9Zq6kX752OMmc6UNxfzZ2hwkOzRqC+QvyTAZZD/3tL/6k5QkwycBI8hwHTDoFQsFP1ShRE41XMSTLI8t9UYeGMsziBa9YoxCpkI+tytTvuuhmdSfnoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVO8ol2L7A6K+OsTpp6ZY423p7OJEiPxqxFtv363TEo=;
 b=dM+Xn06RrKDQhOybceP/3FXgG7DbB31zhzaPgR0tbjBWTEEu2oO68OHVXA08G56xwf8Ya3ztEFglO8rLEd2M5DoaylP+F4oPJdUFGsMgaNkzhHAU/CJK7cmv1Y9iQEK/nB+NxiLWhkdoqZUPxtcduIAE+KdLWjT5GYCBS8dmzz7xL6YE/ILLhp29n78S4fGLkaIH0/Gsc5U0zz5+l5iTzttUz8//v64ehjSMnWXhnf5FOIofr2qvXjQpdSp4NErecW8QtTBE/LICyB+RA7j38zct9zve7T65HSX+mK4QIJAhUIpCOItU0ClLUxlqwtDqgzePT+9GqaEMq7DM6mQQZQ==
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 (2603:1096:604:22e::13) by TYRPR01MB13690.jpnprd01.prod.outlook.com
 (2603:1096:405:189::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.8; Wed, 15 Oct
 2025 13:47:19 +0000
Received: from OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc]) by OSRPR01MB11808.jpnprd01.prod.outlook.com
 ([fe80::16d6:a4cf:75c9:cdfc%4]) with mapi id 15.20.9228.012; Wed, 15 Oct 2025
 13:47:19 +0000
From: Jia Ston <ston.jia@outlook.com>
To: Jia Ston <ston.jia@outlook.com>
CC: "hansg@kernel.org" <hansg@kernel.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH v3] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Topic: [PATCH v3] platform/x86: huawei-wmi: add keys for HONOR models
Thread-Index: AQHcPdo5ZNadCGg4A0W1fgdqWJB5qA==
Date: Wed, 15 Oct 2025 13:47:19 +0000
Message-ID: <20251015134645.59440-2-ston.jia@outlook.com>
References: <20251015132636.56840-1-ston.jia@outlook.com>
In-Reply-To: <20251015132636.56840-1-ston.jia@outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSRPR01MB11808:EE_|TYRPR01MB13690:EE_
x-ms-office365-filtering-correlation-id: f5d600b6-1361-4f9f-af4c-08de0bf15c06
x-ms-exchange-slblob-mailprops:
 ScCmN3RHayF0bP0FcI6aESyZnZAIXMvqCtf7Ly4v2VRpTzpjkrYM51WnbwbJ9OPiJtxaRsZKR0xYitt49NXfDAWSG3KDXUePceF1PGX/j4DrZBk39HMnBOv9udB5Xyi7rKG68JEIMqz1iUTbYr6JHY4i7tA+saGPCRKITqQO0gcAEMcuQAnGZFDcap8RSi8bzzg3BLo5gfE2oyVOZige+LZ8ApOVJ7mZUVvilOuQMKziipFAfh8KUSUi97+nm3/tjPB9KWs2AN2pBmgbNLU/iGOiw8nqix/O8ME8C4B9RwqANmS9T3z+iaNx1VKcG04gXNTiaeflzoSxk/BST710jqfwmiaUZvlzbLUMv8kiTiuwGKcLmXUMvbIxJuRtoItx2/Eucxpd22LFFGQA8x7r0mFrA3jKkVkfF0542o7GzGsYo1LBlEZq9czbBlE2JaNZSRHHGQM5ET4aShxcLCN7tDALQgMxWD11oVvHvWVVSu2VHNwkdFVt0FUjrfPdThMw51t8iQy90/08EMpQTPZtH2stVvtGaXJ8EVJ0Po9rJBpvlb2/N+quN/dsXhsiDtUaEnqwLzVikv0PEYJPwKFvh3e2D/zT0GhTCgmr82OPTtRUqnJMCuCKBSunjkYCUpPMB3yLBV0neyx1pLDh1eqfBXaOfWdpRL/7rfiq+4u5Qpmt+FkzvwaXVsUfwswXmZeprCJ26uvS9AIc7p5sukCE4JIF+bATsCUFxZPp7AriMW0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|19110799012|461199028|8062599012|41001999006|38102599003|15080799012|31061999003|440099028|40105399003|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?12sAbwt3BI8lXtlFam13M53kE3aRZeJG2x4rLsodzxhWdfiJMeY4zzjuZI?=
 =?iso-8859-1?Q?wJ2Y/SGmGO1639L0/47CUv6kxu9nEUeF8WGKgqbYZ0/nm+16css00HwomF?=
 =?iso-8859-1?Q?x70wxR2ZcHYyY8EdJ+/kqMnNxnANC9pHV/mPvxzS9UJXZqSeIPHtboGFnB?=
 =?iso-8859-1?Q?N+tUc4QVrKyikYf2tkge08EbUVwHVLEbKGaFcnzHkhOCoM2Ivyqs8uAd+O?=
 =?iso-8859-1?Q?fTLF5S3vHHc7k6Sy0C//4xDeF/uD6+hHa5SF0rrojqRokacwuqcs8rNugB?=
 =?iso-8859-1?Q?Zfis+U5NsZXLoPpOGmyFDq+Ywvyo36oSZ+/l6eeI1KXZmSE5r1X9x5uGdr?=
 =?iso-8859-1?Q?VixER0fAD5kkSPFYq+TL8GulQQD4p9j6gLIiK0UL9ZZ4g5mOYp13oP561b?=
 =?iso-8859-1?Q?KqpcnSarYgWOr9Wd5QyMfbQ99kRzL1hXsa9j2KFZyDtRoxP3lICbZDavwG?=
 =?iso-8859-1?Q?whQlJLvgWPH6ut+t8NF7tgSPVwII0lkzaZuZK1AIgbc04Tepuj0hZAQQfO?=
 =?iso-8859-1?Q?Dg6v8afrvZm58o3rvSb3yP6s8Dp3FHNNkZI8x+sFIHPp1W7F5RT9DHUGkS?=
 =?iso-8859-1?Q?jhBmghy220a6SWJRrElxbtnd+oZ1XJWRYJ8rXPz8St6YOk9a3YzZCFWyj6?=
 =?iso-8859-1?Q?WAaCoBX0bm/R1g8S5XdJjGmt5isnzY/D7YI3MsEU4cwTiV0n8OIYg9XEIv?=
 =?iso-8859-1?Q?Bgf6oEmpfa2jcp+7HeABrJR4e+Kg9UDCp7oVnpVcfUoB1uz3AgliD60+s0?=
 =?iso-8859-1?Q?cYfDDhZ57wzRv/tTL8RgYYWlBYa+ZvuTYteFGYoP5ERpMGKn/Gvxbkg8lg?=
 =?iso-8859-1?Q?4ET6fEsIA76XS2uLTpxOb8Z+okTA44g+X9qbYJMiv4RcflR9L3tfC9luKK?=
 =?iso-8859-1?Q?joccuCkwPQVReM+q1tfSWmA2aLg5D6f5tLUte4D23+XxDOCQ+r3PPEMtde?=
 =?iso-8859-1?Q?9z2SI945wY1XCs7K3EHrz99lyYcePauVHaRizEgXe+XN462hY7vYfwnSDe?=
 =?iso-8859-1?Q?aCACCQJuPjsNLxV9tNZJg1LRVxO6BGSfl7P3eCHe1e+j7vQd33hZoBuNiK?=
 =?iso-8859-1?Q?rqMgt/XLXjWO1BR4j11BXhCkl5x1AR3hu+oon0Jk2lE7YEdXH56e95zK/8?=
 =?iso-8859-1?Q?8Ld89uFyLRAFusTlyL7SVU25wGC7Dbh728K9JClbg4OLuTVonOo4RWtI1M?=
 =?iso-8859-1?Q?C2vh6LCoHbUxANedUhUf2y/qEFJBNByZ+JLVh+LMyONFm1wmgeIqg61qMc?=
 =?iso-8859-1?Q?ZxXBbUl1+XHrc3lpokUOKORsA3xQeUG8kWnKykwW4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wBC172wGRsVa+b8kDDiHdL1gPuTfX5+5TbvANOcrdIld2bOX3948f5Ki1V?=
 =?iso-8859-1?Q?jggO+uCK8itK5yhPZrT/DXvA4Pg+khY8Iku5rzcD36qw1+rh2suM+hXk7X?=
 =?iso-8859-1?Q?D8XxJP5HA/TU8aFWoL4gVpawWXw/hmehYNYbfR0IYRG0hr305cA91TcuqC?=
 =?iso-8859-1?Q?dvCjPYlA4K0abESQv7dFrOlTrmUlboAQ40wWoJBfxCAU1FASH9RaNQOMbG?=
 =?iso-8859-1?Q?vttQGm2Je8KyFhafDSrxUYGpMoAEVtEyyVdTTGmUdqLDHtfHUTlLZua7Np?=
 =?iso-8859-1?Q?5mpCKdTiA+0sEMr0rno72P67U04n4M8bjvfIjCkcXWfTXe+dyp5z9Pc11C?=
 =?iso-8859-1?Q?6blZObEQOK+71szhrFlXIRGiZ6eSpMZl4mG7qCKRf20BOXZFQ7P6hhJGlk?=
 =?iso-8859-1?Q?fxL2SIVZizciUrnKUaKX0XA0I1PwOY0AQPsm9HLGJUpW3aRh25bL8NJGhk?=
 =?iso-8859-1?Q?EjgC0BETBsI/V2iy0hYH7REfK/kRmr9ku1p5lnn3b2iWjUZrWTTdAESxb6?=
 =?iso-8859-1?Q?WadpPaJxsFw8wG1zODYuZ7EuMmELLv8SNZMBmPRrQVzmhvAQIIfPGMHFRC?=
 =?iso-8859-1?Q?1R+JUQlJyq5nPV0PPiswpJlCwlaAWeRVgeeWIZWjgmtaqAOgK42L5K8npf?=
 =?iso-8859-1?Q?OOhRYejgCbZU6ZZWIJYKdT1ieiCXCoVgMKHY0SR0PvpO5okDRfrmnCimhd?=
 =?iso-8859-1?Q?a5+EvCMFTRDhWQZm9XURF4t0nYF1Pd4D0r7hdL1zZ096Gw1t+YcnN8tGUl?=
 =?iso-8859-1?Q?LGSEAWCNN/9lNka4I9xBQ3beg4k6DfZsL/zH0rhekT57rgTqqr6Q9yhnDK?=
 =?iso-8859-1?Q?nLOgZ3FMFx0cg+Sc6Mpq3fQDvNqi+DLw3W9JisMpE08l6xCAk+1lTYmYz7?=
 =?iso-8859-1?Q?U3WMDExj9TJfqqIxhS3vVwtuyPQH0cjWgUgQDSp/3i31XJ+QqeTj8g1Oic?=
 =?iso-8859-1?Q?KtNrHzZ4tjxRjyW+8ly8QKo1HZsVp6Kwsal25yh5KmQgp2vgh+W49KehnQ?=
 =?iso-8859-1?Q?lL8HNS2wVkXMz7uLWqoTtQ6qfQYqEsbji+jfSICthKDPsHTGmIwEjjBYpB?=
 =?iso-8859-1?Q?hYjVffQuIOr0YOJgdqqhHaRuAXjKZkJu8DZ50iZWZaf+LQVqxw65wtIdvp?=
 =?iso-8859-1?Q?DXqM5tbZ2TAsGXXyEFzThATDkz6Da7RVeaI5WB+7UUTo0EuFHowzQhuYKi?=
 =?iso-8859-1?Q?4VBIxg+5Tmm9XONvXWkfwv64FnAZbvhFW5Xwk+rGFXLbMI2wvnTJUFog73?=
 =?iso-8859-1?Q?Sea4QuZgpIGZtFZLjkZypkjsPPAj9Q9Nc1/3/SVSs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d600b6-1361-4f9f-af4c-08de0bf15c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:47:19.2029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13690

From: ston <ston.jia@outlook.com>

HONOR MagicBook X16/X14 models produced in 2025 cannot use the print and YO=
YO key properly.
(input input25: Unknown key pressed, code: 0x028b)
(input input25: Unknown key pressed, code: 0x028e)

This change add key_entry for HONOR printscreen key and HONOR YOYO key.

Signed-off-by: Ston Jia <ston.jia@outlook.com>
---
V1 -> V2: Add key_entry changes to commit message
V2 -> V3: Add error output to commit message

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


