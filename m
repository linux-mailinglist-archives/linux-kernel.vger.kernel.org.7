Return-Path: <linux-kernel+bounces-804538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7EB47933
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F761B23AA1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 06:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722531DE2C9;
	Sun,  7 Sep 2025 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Jya4x5a+"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013085.outbound.protection.outlook.com [52.103.46.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA2145C0B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757224843; cv=fail; b=tzrwrM3dVhpn0H7G8IbhbTRIQV7p3R56/OgurtutlGTOQ36vH/gmZpoR/E9XVVG77e4NKe0/HdG22ornx376Nw+p90rc4qp2dFIcnoJLBBNsRvbanfXQf++pROjGzNQ3ZXwqlQl7Yxrd8fjAL7f1Jyljj68jZeva11GGUIWHzQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757224843; c=relaxed/simple;
	bh=qi3pd/U27k45UAJuNrqHAF3jpgu5lvz9VoMErFRWqn8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MyfRN0hCRh4ptyTI2scTHRwlkwGAtf2qV+VSQIty/6BQDZ+1nytCDL5Y+Diw91sB2UOGu8slMPfH4VGinN2F7NXPqzdPwD9frNzKIvBGaHkhvzJhHpBPGpKxA0hbykr/c2OAdfBycdtDmD/HdV57WPwWN8HW4uaS62sRPt/tybU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Jya4x5a+; arc=fail smtp.client-ip=52.103.46.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8A6Tn8N5eFNO+pnpd3Gh6bhAG+Y54pjhrXidWIO1fGqSfjE2ATlbpagSKsb7aDWuc5sfGRMqkRDSDWLDIuDCjyokjlz8JgHswjINb2t9oNVcxcd8Q545RdrSEn100EoNIbmy+26y6870hNHZkVCpS1Pntkw5sCnClT6JjLyyxcRbhzaZ11qKmkGKVebrNScItrqzVDb8dzpKAYRjaTx+wo/whxe6+QF//ykUC1EEHMV5nYtQuk6fqIaqBioWEDxB/uT6DgIZAegLURlY4Kxyrbo+vsa1gPhnnLgjY3o2Y07qHjGuQ7GvIlXcBGEuPgsfpnzzu3jiTPwmObpuPOvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi3pd/U27k45UAJuNrqHAF3jpgu5lvz9VoMErFRWqn8=;
 b=R06jlKPlHMvc2SbR9LtP9bxtMYPYaz8BM3sX8c+IsSzq5j2CuXpun0gAkji5lpCl4xC9vd0uh3I/4fqDl+Zj0ovDxRiGubGC9SG/9jhSZaWGaPJ8XU3ostUpU17CcMfJcj0gAE+h/rK0mWQYuKurH0r72ZPXV2k6L4NU5LM79W9bYySVb3Ty9b4KZYar9dx7nnlU0bXPX8Kmx/8M2UHz0HJBupqAwhBVSR4ZgczjtN4faLgM595r0KLVKHZ+iSXeqo7eSn41gZSYA/vhk8f+R5qIAblLAiNJsati3R+s2fUJXAY2q3bbfYGiEUznzKydz6Qj/J5zZuYxZoIXE1HYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi3pd/U27k45UAJuNrqHAF3jpgu5lvz9VoMErFRWqn8=;
 b=Jya4x5a+xZhjgrS21toMqy5pTcLh6I2yGvaAIDpY8TB9dArIFwb8dLIJsHORF2YMvizaUtDsSC8e59cdjBavS7EC59JK20XFUaoPKmQ/dQgoBCCTy40z9CK5TDeLvK1CQ4y/Jw25NxyDXYRgbui47TF+eDBPs0eKF6OQeNR4Mzue3Q8c1cGVALkfgfp6PJJ8plEAtPr+F0J5J8qWkR8nHL8B5h9f0paXh3o6R6EYsckPuRz5Sv993TqzKUonY1DsthWGPFmYCWu6jkXXV0m+wjAT+Ap9OcxLCYu/6s9OaJ6g5tXid2uLJpcY/AJhHGrnkJXAfRVn9bdBbdcShCU4FA==
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:5a5::8) by
 GVXP190MB2509.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:285::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Sun, 7 Sep 2025 06:00:37 +0000
Received: from DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380]) by DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
 ([fe80::5dcd:351e:4e91:2380%5]) with mapi id 15.20.9094.018; Sun, 7 Sep 2025
 06:00:37 +0000
From: Muhammed Subair <msubair@hotmail.com>
To: Andre Przywara <andre.przywara@arm.com>, Christian Gmeiner
	<christian.gmeiner@gmail.com>
CC: "linux-sunxi+help@lists.linux.dev" <linux-sunxi+help@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Chen-Yu
 Tsai <wens@csie.org>
Subject: Re: drm/etnaviv: detecting disabled Vivante GPU?
Thread-Topic: Re: drm/etnaviv: detecting disabled Vivante GPU?
Thread-Index: AdwftZRL4V/ycwT/ShypPIPQ1UB47Q==
Date: Sun, 7 Sep 2025 06:00:36 +0000
Message-ID:
 <DU0P190MB2445C0F6D091546BB4AC272FBC0DA@DU0P190MB2445.EURP190.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P190MB2445:EE_|GVXP190MB2509:EE_
x-ms-office365-filtering-correlation-id: 795058fc-ecdc-42d8-1c0b-08ddedd3ddbf
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|8060799015|8062599012|19110799012|13091999003|461199028|15080799012|3412199025|40105399003|440099028|53005399003|10035399007|12091999003|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFdkUVRxVktMZTJWVUpYVXV0NkFYTmpRMzAwajFya0F2THZ0aXl2NmIrdGRV?=
 =?utf-8?B?VndHcHNwVFErOHVVVU9rNFdhS0I2OWwzWERwcHpQUnI5WDhxbHpLdzF2cWpI?=
 =?utf-8?B?b1hzWlVUTi9seDJFeC9rY2xmWUJ6VEZTTEkvSzZHK2RZMGhxV2JiZGNlTlhL?=
 =?utf-8?B?aExVUzVjVndXeWN0U3BEeXU1YzgwWjZLeDZpTEJTenFralpiM1doNDZMSVU4?=
 =?utf-8?B?K1VsL2FERTBhVGdzOHFzaDdZVERvSVpJZFNRL25pS1o2dkk5RzF4OXNRaUMr?=
 =?utf-8?B?UjVTdHI5Z29vLzZYSHlSU3VPR2JVU3ZYU0ZIZnFOYUt2ZnJiN1ZpYTlkcVlw?=
 =?utf-8?B?QW9zeDcwZ1lHWXBENDM2QVNUcUdVTFQ3SFhualJ6S0hYNzhISWd1L2FORllQ?=
 =?utf-8?B?eXNsNGZydW1abnNpSnJ5S2IxYUkrSk1XUzVrcFUwekVEOS8vUnlycWd4K0k5?=
 =?utf-8?B?dXRzKytRRGhlbGQycW45U0c4NG1pNXFBVTkrdkRROTBlcCthaVNtbHhYQjlC?=
 =?utf-8?B?dTlqS1M4SFp2ckkxemNMdm1yWHY0MjdNWkVZdnhhYitMYmVkcjlOa2tYc2pj?=
 =?utf-8?B?RkJoanlMUTJMeDJSdGVTYkRmYSt5RThoU3dzcWdPcmk0TytENlZXWkZvbjJs?=
 =?utf-8?B?RUZOWmIyMHlYSkljOHFzQ2NQdER1anhmMFZ4RHVEL2dtbmFXZkN1UHRpMm5J?=
 =?utf-8?B?LzRkSjBaL3p3Mkk1OUtlMmJuSlZkbytQVGMrYjZadTg1WDdMMVNiL2FLbC91?=
 =?utf-8?B?aGRkclJuaHVYUUI4ZjJrWGpQc1VUNlo2aUFOMHhkWVNNS0g0NlpWRFFIelRp?=
 =?utf-8?B?TXY3VThwdkNBTU1jdHBSNGh2ck5GUmQzT2h3djVLQ3k1dG1lTUs4YkdsVVNy?=
 =?utf-8?B?Q3h4aklPTWdaSGRaSE43WWk5V3hpcWd6Q0pURVp6ZEdTM2NPeUd6RTZGMmZM?=
 =?utf-8?B?dW9LRGVSTkRNSXZQNkZXVFhLTmFaYlAwOTlEcSs3RG9Id3A2VUJKWnc5RkY0?=
 =?utf-8?B?SVozbkV5ZWJOK1VsNWxWcjhJMGV6Q1Z0YjdkT0ZtSWV1bVJXQ2J3Qk0xOHVo?=
 =?utf-8?B?LzltUEZqamYxblh3NHd0cFM2NnVaa2JKM0VFSUV2RGU4SklFcjYwNjkvL0dt?=
 =?utf-8?B?cUg4bllUU1BGaGY5c2ZKcFhpcDVVR1VaenY1bnpxMlQ0NFhkYVBiQVMrY3Zz?=
 =?utf-8?B?VW1VSUhtV0ZrUXRBK2E2bVRpaGNZcFM4d3VZUlFiVnNMOUtIYTRSSzlPc1dm?=
 =?utf-8?B?bE02TUNuYUI4Y0Z0WUlkSUkxU0krM21Oa3AzeFREcmkvWmc5WkZScXB1dnk3?=
 =?utf-8?B?RnJxaHQzaWVQZGNZS2xuNFdDTzBvOCtkZmJUTjlHNWd6TE00eVI5TzR0MmFS?=
 =?utf-8?B?RHdKOEh2Yi82cGZkTHp5NVNheG1Qa05xSzZLb0R4V0VTRzFvbVMwNXZySkZQ?=
 =?utf-8?B?aE56L2VZK2VuZzZJdUdQZGlOUUJUTkg2RGV0MEpIQ3FvMnFGSEM1V1ZGZ0hK?=
 =?utf-8?B?UVVZKzNiSHB3N0NJNjBTZWI3SjFJT2QrZCs0Z212ZStWWDZmK3k1Q3lDU0E4?=
 =?utf-8?B?NkRPcEMrc2FiRm5LZ3FzNHl0cTVKdStVNkt2MEdLTWZGcllvNGdpM2RBMWts?=
 =?utf-8?B?Q2FOazZjY1MvNkhqTUt4TWRSZTFyRUNhRzFwZUM5WnAwVjF5aDl3VG1UODdt?=
 =?utf-8?Q?69ZSZuadUfciIYQvpqYH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejY1ZTRnaEo1UFZmeWFJNE1ldXlyVlMzR0VkV0VKVGUrWHBvOHROQWU2RVlq?=
 =?utf-8?B?am5OUHp6RnUzejlTOXZZdWdkTDlWekhMOW93aGxwSWp1NzFXKzMzdVhiZGlO?=
 =?utf-8?B?cXRyR2tqZ1FJTUdpSzYyckk3VURpRzh6YTllSWRkMUFUYmJqSjZzY01WOUFv?=
 =?utf-8?B?MDVmTUd4Tm02ZUpFRGJWNjJ0cUlXZ2xQWXhXeGpvNVZNT3Q1Vm9wWkNwMStL?=
 =?utf-8?B?eFpyYjB5ditXOVVLcHZZRFBBaDgwbWhvVS9aaGtVZGFhcmlvSUh0dFJ5aGlS?=
 =?utf-8?B?eVhuYkRMQTZNK3VScWZCWlZoTEFwelJYcWRvekJZWE5ZNTVQNmpQcUdvQ1h0?=
 =?utf-8?B?SnhjWUoyMlI2d05JdFFqanJ3Z0hlR0Q1YWJEUDdHMlZkSTN4WVFhMXdsbHFE?=
 =?utf-8?B?ZEtEcmdGM3d0Ymc3bXp5NzFnUURZMyttckxQRkhVQm8weENJREs5UWo3Um9j?=
 =?utf-8?B?QTFFK2RoSlJ5bVUzNGxVbnJqQit1K0VhR3lOUXZiMndsS2dVTFBhSGZwc3N5?=
 =?utf-8?B?RGZSaEU5Qy9YV0JCcExXeGVZc3haakRCK3pnUzVaWHRoMWtmZFJjeEdNN2tm?=
 =?utf-8?B?Z0h3dlVrdi9BVkpDV29zbER0MDR6bkErMmF3Rzl6SHpMcU84U2ZjZTR4MHVR?=
 =?utf-8?B?KzdPR3ZRUEdvMVRKY3NKR1BnK1hGaytJVlMyOWhIdndyMDBvK0tUeEQreFJx?=
 =?utf-8?B?YXlJdzhHek04TWlIdXIvUnlaN3FtbUNyejdDKzhLRU1jUjB5bDliZ0pYM1FX?=
 =?utf-8?B?K20vTUgyOTMxdUdWNW9zaDdhamo2R2sxNE5jamFkdVpzRkh1VDRSZ3dWY3dn?=
 =?utf-8?B?YWsrUVZDWGpDVVU0QjdTUktQRmRLSTlIZG5HbThTdm5oeThQblNJb1o4dVB5?=
 =?utf-8?B?WUhFYkQ4Y1crZ0UrdWlaMDJ1eml4cytWQ3ZFZHVQT2xyMHdCbGVDam0zZkg5?=
 =?utf-8?B?aENIVkJoZDlUNmtKUkM5enVWWXNyNmJMWlM5UkVSMVFabEsySkFZVkJkYkQy?=
 =?utf-8?B?M1RnVHBoc0VXRnVKaWVyVFh1aEtvZzJnTXBmUXZmQ0tNdzV2L1pCd21NV04w?=
 =?utf-8?B?WDRIR3F3ZFA5SnppRHA1bUN3K3E0cHdaVVcxSmdJUXJDVS9KY0t3MzVyZVJZ?=
 =?utf-8?B?cmp2d1VwNkJNUGhzYzdzU3I5ZnlxcTVVb3JPUHBKNWVheVV6QkIveDVCREE0?=
 =?utf-8?B?M1YrV0orbXQ5NFdtbkpLNUZHMUhYTllmZEMreEgvMFZJc1RrM3ZFUTZuUmRJ?=
 =?utf-8?B?MGJjZnQzMTVsdHF4bHh5aU1ZL1FRNldVUUh5Znp3elhWanFXb3oyYWVkNVRL?=
 =?utf-8?B?Q2UyRG1rRUoyU2JBaXNXWVRUdXpWUnRsb0ZTcmJyZTRZVFJkRWtUaFplM1o0?=
 =?utf-8?B?WlQxM1crMXFaQVhVd1ZQYitOWHpVYjdwWkVxSExYc2NVbnV3eFVnYkg0aFFv?=
 =?utf-8?B?STlOU3Q5ajRJK1lYdkVIVFlpNmZvZmlSWHNVWjlNcVZSY2ppNFZMTFluL1dR?=
 =?utf-8?B?L29ITWEvcXFDRFJUbmlyZTY3OXp3T1RWS090cTl5K2wxVUcwcWFOWXRtVTd3?=
 =?utf-8?B?dU9JanVhS045QUxzaEN4ZVppYlJtOEtGRE9DbEN5TWlaTkFQUXQzaWJwWkxX?=
 =?utf-8?B?WDRRd0VKSkJqTlRjZEx6V3VYOGNpOWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-e6540.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P190MB2445.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 795058fc-ecdc-42d8-1c0b-08ddedd3ddbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2025 06:00:37.0070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2509

SGVsbG8sDQpUaGUgYm9hcmQgSSBoYXZlIGlzIEE1MjcsIGFuZCBsZWdhY3kga2VybmVsICggNS4x
NS4xNDcpIGRldGVjdHMgbnB1IGFzIGJlbG93LA0KaHR0cHM6Ly9saW51eC1zdW54aS5vcmcvQTUy
MyNGYW1pbHlfb2Zfc3VuNTVpdzMgc2hvd3MgdGhhdCBBNTI3IGRvZXNu4oCZdCBoYXZlIG5wdSwg
bm90IHN1cmUgd2hldGhlciB0aGlzIGlzIGNvcnJlY3QgDQoNClsgICAxMy44ODc4OTJdIG5wdVsx
MDZdWzEwNl0gdmlwY29yZSwgcGxhdGZvcm0gZGV2aWNlIGNvbXBhdGlibGU9YWxsd2lubmVyLG5w
dQ0KWyAgIDEzLjg5MDMyMl0gbnB1WzEwNl1bMTA2XSB2aXBjb3JlLCBwbGF0Zm9ybSBkcml2ZXIg
ZGV2aWNlPTB4ZmZmZmZmODBjMWExMWMxMA0KWyAgIDEzLjg5MDM5NF0gbnB1WzEwNl1bMTA2XSB2
aXBjb3JlIGlycSBudW1iZXIgaXMgMTE2Lg0KWyAgIDEzLjg5MDQ3MV0gdmlwY29yZSA3MTIyMDAw
Lm5wdTogc3VwcGx5IG5wdSBub3QgZm91bmQsIHVzaW5nIGR1bW15IHJlZ3VsYXRvcg0KWyAgIDEz
Ljg5MjU4OV0gbnB1WzEwNl1bMTA2XSBOUFUgVXNlIFZGMywgdXNlIGZyZXEgNjk2DQpbICAgMTMu
ODkyNzU0XSBucHVbMTA2XVsxMDZdIEdldCBOUFUgUmVndWxhdG9yIENvbnRyb2wgRkFJTCENClsg
ICAxMy44OTI3NjZdIG5wdVsxMDZdWzEwNl0gV2FudCBzZXQgbnB1IHZvbCgxMDAwMDAwKSBub3cg
dm9sKC0yMikNClsgICAxMy45Mzg2NjRdIG5wdVsxMDZdWzEwNl0gY29yZV8wLCByZXF1ZXN0IGly
cWxpbmU9MTE2LCBuYW1lPXZpcGNvcmVfMA0KWyAgIDEzLjkzODg4OV0gbnB1WzEwNl1bMTA2XSB2
aXBjb3JlLCBhbGxvY2F0ZSBwYWdlIGZvciB2aWRlbyBtZW1vcnksIHNpemU6IDB4MjAwMDAwMGJ5
dGVzDQpbICAgMTMuOTM4OTAwXSBucHVbMTA2XVsxMDZdIHZpcGNvcmUsIHZpZGVvIG1lbW9yeSBo
ZWFwIHNpemUgaXMgbW9yZSB0aGFuIDRNYnl0ZSxvbmx5IGNhbiBhbGxvY2F0ZSA0TSBieXRlIGZy
b20gcGFnZQ0KWyAgIDEzLjkzODk0OF0gbnB1WzEwNl1bMTA2XSB2aXBjb3JlLCBjcHVfcGh5c2lj
YWw9MHgxMGNjMDAwMDAsIHZpcF9waHlzaWNhbD0weDEwY2MwMDAwMCwgdmlwX21lbXNpemU9MHg0
MDAwMDANClsgICAxMy45NDAyMzBdIG5wdVsxMDZdWzEwNl0gVklQTGl0ZSBkcml2ZXIgdmVyc2lv
biAxLjEzLjAuMC1BVy0yMDIzLTAxLTA5DQpbICAgMjUuMDkwOTA1XSBzdW54aTpzdW54aV9wZF90
ZXN0LTAucGQtbnB1LXRlc3Q6W1dBUk5dOiBydW50aW1lX3N1c3BlbmQgZGlzYWJsZSBjbG9jaw0K
DQpBbmQgdXBzdHJlYW0ga2VybmVsICggNi4xNy1yYzQpICB3aXRoIHBhdGNoZXMgc2hvd3MgYmVs
b3csDQoNCiMgZG1lc2cgfCBncmVwICA3MTIyMDAwDQogWyAgIDIxLjk4ODIxNV0gZXRuYXZpdi1n
cHUgNzEyMjAwMC5ucHU6IHByb2JlIHdpdGggZHJpdmVyIGV0bmF2aXYtZ3B1IGZhaWxlZCB3aXRo
IGVycm9yIC0xMTANClsgICAyMS45ODgxNzNdIGV0bmF2aXYtZ3B1IDcxMjIwMDAubnB1OiBkZWZl
cnJlZCBwcm9iZSB0aW1lb3V0LCBpZ25vcmluZyBkZXBlbmRlbmN5DQpbICAgMjEuOTg4MjE1XSBl
dG5hdml2LWdwdSA3MTIyMDAwLm5wdTogcHJvYmUgd2l0aCBkcml2ZXIgZXRuYXZpdi1ncHUgZmFp
bGVkIHdpdGggZXJyb3IgLTExMA0KDQpJIGhhdmUgdGhlIGZ1bGwgc291cmNlIGNvZGUgaW5jbHVk
aW5nIHNjaGVtYXRpYyBhbmQgZG9jdW1lbnRhdGlvbiwgaGFwcHkgdG8gcHJvdmlkZSBhbnkgc3Vw
cG9ydCByZXF1aXJlZC4NCg0KU3ViYWlyDQoNCiogUmU6IGRybS9ldG5hdml2OiBkZXRlY3Rpbmcg
ZGlzYWJsZWQgVml2YW50ZSBHUFU/DQogIDIwMjUtMDktMDQgMTA6MTAgYCBDaHJpc3RpYW4gR21l
aW5lcg0KQCAyMDI1LTA5LTA0IDEwOjM2ICAgYCBBbmRyZSBQcnp5d2FyYQ0KICAwIHNpYmxpbmdz
LCAwIHJlcGxpZXM7IDQrIG1lc3NhZ2VzIGluIHRocmVhZA0KRnJvbTogQW5kcmUgUHJ6eXdhcmEg
QCAyMDI1LTA5LTA0IDEwOjM2IFVUQyAocGVybWFsaW5rIC8gcmF3KQ0KICBUbzogQ2hyaXN0aWFu
IEdtZWluZXINCiAgQ2M6IEx1Y2FzIFN0YWNoLCBSdXNzZWxsIEtpbmcsIGV0bmF2aXYsIGRyaS1k
ZXZlbCwgbGludXgta2VybmVsLA0KCUNoZW4tWXUgVHNhaSwgbGludXgtc3VueGkNCg0KT24gVGh1
LCA0IFNlcCAyMDI1IDEyOjEwOjMwICswMjAwDQpDaHJpc3RpYW4gR21laW5lciA8Y2hyaXN0aWFu
LmdtZWluZXJAZ21haWwuY29tPiB3cm90ZToNCg0KPiBIaQ0KPiANCj4gPg0KPiA+IHRoZSBBbGx3
aW5uZXIgQTUyMy9BNTI3L1Q1MjcgZmFtaWx5IG9mIFNvQ3MgZmVhdHVyZSBhIFZpdmFudGUNCj4g
PiAiVklQOTAwMCIoPykgTlBVLCB0aG91Z2ggaXQgc2VlbXMgdG8gYmUgZGlzYWJsZWQgb24gbWFu
eSBTS1VzLg0KPiA+IFNlZSBodHRwczovL2xpbnV4LXN1bnhpLm9yZy9BNTIzI0ZhbWlseV9vZl9z
dW41NWl3MyBmb3IgYSB0YWJsZSwgdGhlDQo+ID4gcm93IGxhYmVsbGVkICJOUFUiIGluZGljYXRl
cyB3aGljaCBtb2RlbCBoYXMgdGhlIElQLiBXZSBzdXNwZWN0IGl0J3MNCj4gPiBhbGwgdGhlIHNh
bWUgZGllLCB3aXRoIHRoZSBOUFUgc2VsZWN0aXZlbHkgZnVzZWQgb2ZmIG9uIHNvbWUgcGFja2Fn
ZXMuDQo+ID4NCj4gPiBCb2FyZCB2ZW5kb3JzIHNlZW0gdG8gdXNlIG11bHRpcGxlIFNLVXMgb2Yg
dGhlIFNvQyBvbiB0aGUgc2FtZSBib2FyZCwNCj4gPiBzbyBpdCdzIGhhcmQgdG8gc2F5IHdoaWNo
IHBhcnRpY3VsYXIgYm9hcmQgaGFzIHRoZSBOUFUgb3Igbm90LiBXZQ0KPiA+IGZpZ3VyZWQgdGhh
dCBvbiB1bnN1cHBvcnRlZCBTb0NzIGFsbCB0aGUgTlBVIHJlZ2lzdGVycyByZWFkIGFzIDAsDQo+
ID4gdGhvdWdoLCBzbyB3ZXJlIHdvbmRlcmluZyBpZiB0aGF0IGNvdWxkIGJlIGNvbnNpZGVyZWQg
YXMgYSBiYWlsLW91dA0KPiA+IGNoZWNrIGZvciB0aGUgZHJpdmVyPw0KPiA+IEF0IHRoZSBtb21l
bnQgSSBnZXQgdGhpcywgb24gYSBTb0Mgd2l0aCBhIGRpc2FibGVkIE5QVToNCj4gPiBbICAgIDEu
Njc3NjEyXSBldG5hdml2IGV0bmF2aXY6IGJvdW5kIDcxMjIwMDAubnB1IChvcHMgZ3B1X29wcykN
Cj4gPiBbICAgIDEuNjgzODQ5XSBldG5hdml2LWdwdSA3MTIyMDAwLm5wdTogbW9kZWw6IEdDMCwg
cmV2aXNpb246IDANCj4gPiBbICAgIDEuNjkwMDIwXSBldG5hdml2LWdwdSA3MTIyMDAwLm5wdTog
VW5rbm93biBHUFUgbW9kZWwNCj4gPiBbICAgIDEuNjk2MTQ1XSBbZHJtXSBJbml0aWFsaXplZCBl
dG5hdml2IDEuNC4wIGZvciBldG5hdml2IG9uIG1pbm9yIDANCj4gPiBbICAgIDEuOTUzMDUzXSBl
dG5hdml2LWdwdSA3MTIyMDAwLm5wdTogR1BVIG5vdCB5ZXQgaWRsZSwgbWFzazogMHgwMDAwMDAw
MA0KPiA+DQo+ID4gQ2hlbi1ZdSBnb3QgdGhpcyBvbiBoaXMgYm9hcmQgZmVhdHVyaW5nIHRoZSBO
UFU6DQo+ID4gICAgIGV0bmF2aXYtZ3B1IDcxMjIwMDAubnB1OiBtb2RlbDogR0M5MDAwLCByZXZp
c2lvbjogOTAwMw0KPiA+DQo+ID4gSWYgSSBnZXQgdGhlIGNvZGUgY29ycmVjdGx5LCB0aGVuIGV0
bmF2aXZfZ3B1X2luaXQoKSBjb3JyZWN0bHkgZGV0ZWN0cw0KPiA+IHRoZSAidW5zdXBwb3J0ZWQi
IEdQVSBtb2RlbCwgYW5kIHJldHVybnMgLUVOWElPLCBidXQgbG9hZF9ncHUoKSBpbg0KPiA+IGV0
bmF2aXZfZHJ2LmMgdGhlbiBzb21ld2hhdCBpZ25vcmVzIHRoaXMsIHNpbmNlIGl0IGtlZXBzIGxv
b2tpbmcgZm9yIG1vcmUNCj4gPiBHUFVzLCBhbmQgZmFpbHMgdG8gbm90aWNlIHRoYXQgKm5vbmUq
IHNob3dlZCB1cDoNCj4gPiAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvZXRuYXZpdi9ncHUgaXMgZW1w
dHkgaW4gbXkgY2FzZS4NCj4gPiAgDQo+IA0KPiBMb29rcyBmaW5lIHRvIG1lIC0gbm8gd3Jvbmcg
YmVoYXZpb3IuDQo+IA0KPiA+IFF1aWNrIHF1ZXN0aW9uczoNCj4gPiAtIElzIHJlYWRpbmcgMCBm
cm9tIFZJVlNfSElfQ0hJUF9JREVOVElUWSAob3IgYW55IG90aGVyIG9mIHRoZSBJRA0KPiA+ICAg
cmVnaXN0ZXJzKSBhbiBpbnZhbGlkIElELCBzbyB3ZSBjYW4gdXNlIHRoYXQgdG8gZGV0ZWN0IHRo
b3NlIGRpc2FibGVkDQo+ID4gICBOUFVzPyBJZiBub3QsIGNhbiBhbnkgb3RoZXIgcmVnaXN0ZXIg
dXNlZCB0byBjaGVjayB0aGlzPyBUaGUgd2hvbGUNCj4gPiAgIGJsb2NrIHNlZW1zIHRvIGJlIFJB
Wi9XSSB3aGVuIHRoZSBOUFUgaXMgZGlzYWJsZWQuDQo+ID4NCj4gPiAtIFdvdWxkIGl0IGJlIGFj
Y2VwdGFibGUgdG8gY2hhbmdlIHRoZSBsb2dpYyB0byBlcnJvciBvdXQgb2YgdGhlDQo+ID4gICBk
cml2ZXIncyBpbml0IG9yIHByb2JlIHJvdXRpbmUgd2hlbiBubyBHUFUvTlBVIGhhcyBiZWVuIGZv
dW5kLCBhdA0KPiA+ICAgYmVzdCB3aXRoIGEgcHJvcGVyIGVycm9yIG1lc3NhZ2U/IEFzIGl0IHN0
YW5kcyBhdCB0aGUgbW9tZW50LCB0aGUNCj4gPiAgIGRyaXZlciBpcyBsb2FkZWQsIGJ1dCBvZiBj
b3Vyc2Ugbm90aGluZyBpcyB1c2FibGUsIHNvIGl0IGtlZXBzDQo+ID4gICBjb25mdXNpbmcgdXNl
cnMuDQo+ID4gIA0KPiANCj4gRnJvbSBhbiBhcHBsaWNhdGlvbiBzdGFuZHBvaW50LCBpdOKAmXMg
bm90IGNvbmZ1c2luZyBzaW5jZSB0aGVyZSBpcyBubyBldG5hdml2DQo+IGRldmljZSB0byBpbnRl
cmFjdCB3aXRoLiBUaGUgdXNlciBtaWdodCB3b25kZXIgYWJvdXQgdGhlIGtlcm5lbCBtZXNzYWdl
cywNCj4gYnV0IHRoYXTigJlzIGFjdHVhbGx5IGNhdXNlZCBieSBhbiBpbmNvcnJlY3QgZGV2aWNl
IHRyZWUuIElmIHRoZSBTb0MgZG9lc27igJl0DQo+IGhhdmUgYW4gTlBVLCBpdCBzaG91bGRu4oCZ
dCBiZSBlbmFibGVkIGluIHRoZSBEVFMuDQoNCllvdSBoYXZlIGEgcG9pbnQgdGhlcmUsIGJ1dCBh
cyBJIG1lbnRpb25lZCBhYm92ZSwgdGhhdCBzb3VuZHMgdHJpY2t5IHRvDQpkbzogSSBoYXZlIHR3
byBib2FyZHMgdGhhdCBsb29rcyBvdGhlcndpc2UgaWRlbnRpY2FsLCBidXQgb25lIGhhcyBhbiBB
NTI3LA0KdGhlIG90aGVyIGFuIFQ1MjcuIEFuZCBzdGlsbCBib3RoIGRvbid0IGhhdmUgdGhlIE5Q
VSwgc2luY2Ugb25seSBzb21lDQpUNTI3cyBmZWF0dXJlIGl0LiBTbyBwdXR0aW5nIHRoaXMgb24g
dGhlIHVzZXIgdG8gdXNlIHRoZSByaWdodCBEVCAob3INClUtQm9vdCBkZWZjb25maWcpIGRvZXMg
bm90IHNvdW5kIHZlcnkgbmljZS4NCg0KQW5kIGluIGNvbnRyYXN0IHRvIG1hbnkgb3RoZXIgZGV2
aWNlcyBkZXNjcmliZWQgaW4gRFRzLCB3ZSAqY2FuKiBzYWZlbHkNCmRldGVjdCB0aGUgZXhpc3Rl
bmNlIG9mIHRoaXMgTlBVOiBlYWNoIG9mIHRoZSBTb0NzIGhhdmUgYWxsIHRoZSBjbG9jaw0KZ2F0
ZXMgYW5kIHJlc2V0cywgYW5kIGFjY2Vzc2VzIHRvIHRoZSBNTUlPIGZyYW1lIGRvIG5vdCBmYXVs
dCAtIGFuZCB0aGUNCmtlcm5lbCBjb2RlIGFwcGFyZW50bHkgY2FuIGNvcGUgd2l0aCB0aGlzIHNp
dHVhdGlvbiBhbHJlYWR5LiBTbyB5ZWFoLCB3ZQ0KY291bGQgc21lYXIgc29tZXRoaW5nIGludG8g
VS1Cb290LCB0byBwdXQgYSBzdGF0dXMgPSAiZGlzYWJsZWQiOyBpbiB0aGVyZSwNCmJ1dCBJIHdv
dWxkIGxpa2UgdG8gYXZvaWQgdGhhdCwgZXNwZWNpYWxseSBpZiB0aGUga2VybmVsIGlzIGFsbW9z
dCB0aGVyZQ0KYWxyZWFkeS4NCg0KQ2hlZXJzLA0KQW5kcmUNCg==

