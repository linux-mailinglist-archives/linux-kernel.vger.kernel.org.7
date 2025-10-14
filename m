Return-Path: <linux-kernel+bounces-852559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BEBD9530
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A172D1925E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C4313546;
	Tue, 14 Oct 2025 12:24:19 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96607313541
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444659; cv=fail; b=pHZC43zMonPZvuWdGKr6P4FRqXgZ271ngloc/bxBYK1mxp6Vnm+zhciQPHVvhs9xp/ssJe7T+Ekvfv90YAw3Kg46bY2U2lxQZs34L+zB2IoAbUJ/zr7deZwu2SW5/yB79P83YdJ91Fq5i5pi17JhzoaWGHZKO1EIq7ZYTio4B9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444659; c=relaxed/simple;
	bh=rkBpMLRodL/FmRAkCK4/R018O2dBgJPVSizowvxLz7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=efX0Sd+pzARA5kHlzCg1ak4nbNA45K+/xONmdYIIbL9NyEUS3db3mS4vGxDuXa99z12TVDl5mWj9Qr3o0jx5UuuN0bIm2bXqFg3ubH9S1BDaXRVabIxxMNKaFqRA6Fefu/xlsOPX2YKBmecE54mRkgCOyz4EFWsCn6k6qrw9F6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ4PR01MB1249.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::10) by NT0PR01MB1263.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Tue, 14 Oct
 2025 12:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNA1ypaYQ1haBBT30RbJHCSKtHOwXzTMaeBNtLNZLkk0qPH8dc1hUjNAQX2ycWXdu32shZ3LkkmFrITWvHs9q9hJVzYyrPDTDSL4w+f4iu9XuUo1P6ILoC7PkTqweHJngQqzNHo2ExwOew/DBhyxYZIuMiVwHn/UblziC1uquitF7qQN2eaeXoRIV4CMKrsbLzSkW0r1461iIOllCQvzt/cqy+WfMr0AZntvBNiiG0SaqQoXKHh20w2orFQul3v5r/qt2Rt/bOFf/TYOlc4oyw+8iNFk5iN/Zw8lQVOoiJqdfHgCgutI8hc1b05oxtn2kOXkX3TbyZ9ED0+9aoipDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkBpMLRodL/FmRAkCK4/R018O2dBgJPVSizowvxLz7g=;
 b=VGbzA7y8nsSNbVukQXyRhZN5AZxQbXY9EjE+hyhGCDClax8Ss2YHFlGQptNhAF7++S+e2qD9P5MfcyC+5IZVGGzHQvTGLHeUFS5h832MdECmuTECRXADo28W/rDIJh2uxuTwgRXIrtudWMeQFKalodYCh2npWBi+HNYYk1ZzO7YuE83jtuHARxjg6B/7hZ2NsCQTbNRhf62q+5BTja1iFuxy1r11ZGTD+IntE0Ab4H7/aCPAV6kaePmZQY8F74DPbzos26+oXMCsFv3OjuebA1JgCGJod9i0H3SwHQ/SRvHwZDHp49BmzDFfeATtxIsYOfnm2lpomAgMfgHDBOrqGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1249.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Tue, 14 Oct
 2025 01:05:38 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::678:a5f4:7eeb:cf5]) by ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::678:a5f4:7eeb:cf5%6]) with mapi id 15.20.9182.020; Tue, 14 Oct 2025
 01:05:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Florian Fainelli <florian.fainelli@broadcom.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIDA4LzExXSBpcnFjaGlwL3N0YXJmaXZlLWpoODEwMDog?=
 =?gb2312?Q?Fix_section_mismatch?=
Thread-Topic: [PATCH 08/11] irqchip/starfive-jh8100: Fix section mismatch
Thread-Index: AQHcPCaWe+FJBT3aeEyAnv6H9tDVx7TA1Mag
Date: Tue, 14 Oct 2025 01:05:38 +0000
Message-ID:
 <ZQ4PR01MB1202FC81C8EFCC9F1D5ED8CCF2EB2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-9-johan@kernel.org>
In-Reply-To: <20251013094611.11745-9-johan@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ4PR01MB1202:EE_|ZQ4PR01MB1249:EE_|NT0PR01MB1263:EE_
x-ms-office365-filtering-correlation-id: ce4e0d9f-fbfe-40d6-5105-08de0abdc9d2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 xifgJHj1HNkupRZmU9lsJDYYAvwL88RFTttLT+p8vXxJgsAbtQKp+hHAPRnX2S90mbEzusmeIyKo3EuaAJ8MV//M31W4Q40UY/HaM3QFUauN64EyCsn9rLXDGLS55yiLGaNjO38VrBhQNRNE5LzxrlfWYb7uc8CCPK1zYMX4/1IPE6AGDRrY4Z81GfKI1oRPLecrss3o/ydoUmf/hMvZb15Eq5WBK2FBveItp2Bcr3QQgMW+sAKk2wvR4TDfj+0fpv2g1kayySo6YZLjf7kmodoIA8uIMvr84KmGe8lIiI25Z/UUHOIkuhOOxLVQIAC3/4jUk0FKcZ1QrBsZ4LXyi/5GDrrV75blqPKOEDRrasri84lMC1i7uThBtURE3B7s4QkPcA+vNNkE2tOda9yOQsFwO7QtgdKRPr9+4TD04/yjgsHN6nnpHoyPI0Ljv71Ir6Y0ZneeXL54RHqYShWnl8fStHRB0mFhiM6sxVE0OF3gjaRffKojq+D+CTpKMat2ucjvKLlM7HNlv4m+yKv2tkotZIIhDb1s310d7NrOU1GqgWPJv9wM+CN2LaYCM6h9rZ+xl748k+783OA51Jsbww==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?eFJKVnBnZnRSZVhjOTVwaHh6ZlZyR3psZEsrTDQxOUJmWFJYRlgwNnMwV0xH?=
 =?gb2312?B?RFg0RUxMMXh2NW9PUFp6bk5nUmRKVjc5R2F5eUphMnBhaFU5NnpsaXVnelcy?=
 =?gb2312?B?cm1jL3htS3JqZ2h1SFpKOVl1aFVON1VwSlRZU3NlWUtuN1hFNm5RM3RJNUM0?=
 =?gb2312?B?dGN1K2IzUStLczdqQnpRYzJwTkswZHlpZkdDdkJncEVXcGRHMEdUSzBVSmFX?=
 =?gb2312?B?ZlVtOHNtUm9Vb202NFV1NkZScEk4UWVpL2JGTEVGUFRDWGZDS25XOXNEOUl0?=
 =?gb2312?B?aHlDMnd5aWcrUXNya240MnF0VHM5RDBEdmYwa0tycVJsM291UHhNUzB2NG5s?=
 =?gb2312?B?aTlMbE5hTUZ6VGc0NnNjdDRMTlFRK2ttS1VZZFYrRVNFbTV6V0psTnVhYUxU?=
 =?gb2312?B?NG55WlJ4RmN2NHZZUHl2VGJLMjRqWWhVS1NqbFEwY0NUNjhLLytaaWZhS2Uw?=
 =?gb2312?B?WCtXMjBsYUhORkMrNmhKeFNKbG5zeWFmcnVrZzRsaFc5NmJKMmdvcTJnTnBu?=
 =?gb2312?B?NlR3b2V5KzYrNDJoQmNyNklBQ3RhdGRseU5USUNuQ0hNNk85TUtOVVk1ZzNM?=
 =?gb2312?B?RjlkL09JcExMTjdiUGtBMjExTWZseDBkZlVHUzFLamVzWW5wRU1yS2RZYVR0?=
 =?gb2312?B?bWNiNTdqbDFoOHJHZ0RjVWNnYVd1YkFkVVByRHZ4b0F3WE1uT0xjZGREWE93?=
 =?gb2312?B?NW5QSlQ3b252czFLOHh3ZHAvMk8vSGFKd2RvNVBtZWdYaS9lZE5zeGVjdjV2?=
 =?gb2312?B?WkdCcXdHNzdjZzNTMzlnK1lZSjBObHpWSmw0clg3dTc4dFRhaDJxbDVwS2sy?=
 =?gb2312?B?OTZDTHJVdmcxWnhqaWdoNDdOaGtMa0FpTk9QWXNmWWxmZEJ0RDVDdlRmaEha?=
 =?gb2312?B?b0VQMGNHMnFxV1R6NzRuaGhMbHRTYkpBVU1meXZ0Zk4vM1I2R0ptT2JxbW1n?=
 =?gb2312?B?Wk5QREtEa2R4L05hVmxlRG9GMTdiSzNoWXZCaWtuYkFCNTBtdEtkYkVUQm1B?=
 =?gb2312?B?U0dQeE9ZM25kMnNLQlB5ektnVVNxOVhEeHlWT0M1L2ljeE1ybGpaRk9EZlMv?=
 =?gb2312?B?TFJYVWRqck5mbEhUeE1KTUF5aWxzc1RnMVpkeTFDRGR1Y09GSDVEbyt2a0RV?=
 =?gb2312?B?ODhSVnN5Mm1jYjMyNFhOT1dxRXZxT0tDMFh4cEdhaENXUnRoTFJjUkJaWEt4?=
 =?gb2312?B?KzZiWkxJbXpodE5UeXRKS2NqNzNnTmMwOXlRUjZmVDJsakJrbHQrY2s1MHVX?=
 =?gb2312?B?c3NDUU9YcEdIWjdnZFBEWEtBa2xGY25MMVhuQUZHYzZVWm55dWNiMjdCU2ll?=
 =?gb2312?B?cis1UkwxM1J5emM3M1g2VS9NRit4UG13bkZnK0FLUHZYbUEwS2Fqa2RRY3R1?=
 =?gb2312?B?YkxmclorM21ndThSUm5PQkw4UmZ6WXR5ckxIQlIvUk5BOWdsbHZta1VwUGtr?=
 =?gb2312?B?Z283dmE3MnQwdEpKRlhnV3l5QW1rMXBOZCtXQ0FJYWJ6ZFlPOTdsWUZMOU5G?=
 =?gb2312?B?Z1FNMUEySTNVNG0wTU9nMnUrOTVTUXV3Vkl2cmVPOWhwMUtEdUpyak5Wejla?=
 =?gb2312?B?bHFsLzl3OXkranM3VEhobTZuNW10SEhzcWtvdXFNNFNoc0VsYmZVeCtOWitO?=
 =?gb2312?B?T25wdmlhRjZXL2VIempsVW9KTEhqb1BYSzVqVTlialh0M0FUejJUQzMwMmJv?=
 =?gb2312?B?dnhURFlrTnV3NGNZNHZEcUcvTXhPUGdmLy9PdzVZZkdBdkg5WFAybWdSYkND?=
 =?gb2312?B?NlZ3c1JhKzc1NjNsVzc4TTVsSkMwUmJwanZQVmptTmVxVVRXUTlrYW5GbENo?=
 =?gb2312?B?aUVPUmRORndnUGlXVHQvRkFQQTNia3M0S2hvSklNM1hTV09QQ3JITmM3Yysy?=
 =?gb2312?B?ekVRVlBzenNlSVY4SytrbGRCYXpkcHFrWGdhRkh6SFpQdmxEWWdZZkJzUDQv?=
 =?gb2312?B?akJURzBTVVJuS0tpVmI2bGNXc2VaNlNUSUVCZkxRVDl1azRMb2lCSlpSaEV0?=
 =?gb2312?B?bVNFZitsM3pHZ2J4NDdWUDFqVTZWZGhmamJKWWE1T3BRUFJ5SXRNOGVGSjBM?=
 =?gb2312?B?NXc0blVXaXBBNSt3dDJyenhpb0RaVU9SelhVNzVRNkhXSUpJdjZGMWpTUXJx?=
 =?gb2312?B?ZTNPVXZiR0FOTTNUZHpIL1lPcXc4SGFKaGtiS2N5TWl1UjhsODhYbHI4VkdK?=
 =?gb2312?B?bUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e0d9f-fbfe-40d6-5105-08de0abdc9d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 01:05:38.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOR1UWFzmT//EKfKH+WyYT57NJOmzn67aAK/Pq089s+Zqg2zDaD3wcvEp3f+AlC06hgtDvohKpc6cBu6FiNtNMNY2MCYLpk0RyPoz8tkxOfEvq8nuBsxwvhE8Gu6nT9F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1249
X-OriginatorOrg: starfivetech.com

SGksIEpvaGFuDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQo+IFBsYXRmb3JtIGRyaXZlcnMg
Y2FuIGJlIHByb2JlZCBhZnRlciB0aGVpciBpbml0IHNlY3Rpb25zIGhhdmUgYmVlbiBkaXNjYXJk
ZWQgc28NCj4gdGhlIGlycWNoaXAgaW5pdCBjYWxsYmFjayBtdXN0IG5vdCBsaXZlIGluIGluaXQu
DQo+IA0KPiBGaXhlczogZTRlNTM1MDM2MTczICgiaXJxY2hpcDogQWRkIFN0YXJGaXZlIGV4dGVy
bmFsIGludGVycnVwdCBjb250cm9sbGVyIikNCj4gQ2M6IENoYW5naHVhbmcgTGlhbmcgPGNoYW5n
aHVhbmcubGlhbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW4gSG92
b2xkIDxqb2hhbkBrZXJuZWwub3JnPg0KDQpSZXZpZXdlZC1ieTogQ2hhbmdodWFuZyBMaWFuZyA8
Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9p
cnFjaGlwL2lycS1zdGFyZml2ZS1qaDgxMDAtaW50Yy5jIHwgMyArLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lycWNoaXAvaXJxLXN0YXJmaXZlLWpoODEwMC1pbnRjLmMNCj4gYi9kcml2ZXJzL2ly
cWNoaXAvaXJxLXN0YXJmaXZlLWpoODEwMC1pbnRjLmMNCj4gaW5kZXggMjQ2MDc5OGVjMTU4Li4x
MTdmMmM2NTFlYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtc3RhcmZpdmUt
amg4MTAwLWludGMuYw0KPiArKysgYi9kcml2ZXJzL2lycWNoaXAvaXJxLXN0YXJmaXZlLWpoODEw
MC1pbnRjLmMNCj4gQEAgLTExNCw4ICsxMTQsNyBAQCBzdGF0aWMgdm9pZCBzdGFyZml2ZV9pbnRj
X2lycV9oYW5kbGVyKHN0cnVjdCBpcnFfZGVzYw0KPiAqZGVzYykNCj4gIAljaGFpbmVkX2lycV9l
eGl0KGNoaXAsIGRlc2MpOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgX19pbml0IHN0YXJmaXZl
X2ludGNfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKmludGMsDQo+IC0JCQkJICAgICBzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKnBhcmVudCkNCj4gK3N0YXRpYyBpbnQgc3RhcmZpdmVfaW50Y19pbml0KHN0
cnVjdCBkZXZpY2Vfbm9kZSAqaW50Yywgc3RydWN0DQo+ICtkZXZpY2Vfbm9kZSAqcGFyZW50KQ0K
PiAgew0KPiAgCXN0cnVjdCBzdGFyZml2ZV9pcnFfY2hpcCAqaXJxYzsNCj4gIAlzdHJ1Y3QgcmVz
ZXRfY29udHJvbCAqcnN0Ow0KPiAtLQ0KPiAyLjQ5LjENCg0K

