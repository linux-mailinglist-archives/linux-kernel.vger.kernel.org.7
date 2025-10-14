Return-Path: <linux-kernel+bounces-852031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D141BD7FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C05E74F6AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C32D97BE;
	Tue, 14 Oct 2025 07:44:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2104.outbound.protection.partner.outlook.cn [139.219.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5136124
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427843; cv=fail; b=bha9QjPcsY7jFw6OAIUdXQx9pd5GcY9Ntg5IuNRrXJeSPTi6Zcr4tJsv98yOmegl6s7A5MigwHqC69LX5Z4/OCNvkUC2S3LQfd20e1UxLn9upCEIhN7Qei+3k5h+3z8OCzu05EWFnIywhAaRJ7S7qv4WMLigM9KJFKTNorgaPF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427843; c=relaxed/simple;
	bh=48DqiivcDdkSYgbfkglJ8EsyK9dkhzfjAc14Ki9wB10=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+JWAYHEFvRnIbJ/0TG6jiaEyuxYrjo72Rl658synczi6T8aUiF/wVh4WrySZgvw2/LiYLLtv6sfwswusfKcDjLg/EzpYTpnPXDOR75A99v1YlWaxOzDzQgufVwLzhnyrFThPjbT7VoDLpI9ybTWTuR6jFJdJkINO6EFQScSryw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3NwYFU7oxbkpx1uFlBjsYkLFNgPmzN6nvKIJ1E7Yw/4WCfn5MTz+Ge5+X/C6gaM+oEH0op5dvi9BIAHW+lWI6bA71UZqs408i2DcqxYW07az9RBh4WKrZDpi73Xjr2C62nJwTbM2LtEGy78aCxIhaR44eVTTrs3aPsQzb9ikjqjizqPmJVlUlk0NXrzO1RN/g56PDa3SSzujRI0g+E851SBRFB4qA1K9pGkKkYXt7EWRMo8aKeTgYurGb/SLVKe+79W3+A0YZSUHNy70OOmKBO3s9P5TKA+e+g6p/9CIOj7uqooZfKFq4BnGIc8wsqVxd55DTkINQPKtylrasr9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48DqiivcDdkSYgbfkglJ8EsyK9dkhzfjAc14Ki9wB10=;
 b=lGfSUYkYxa6kKB8lC+EJFYGCuh8tOMsM3w8cgi//4mkZxH5wWCvpRScS2Oq2AdPL1lJV4mzlbva/YhvvSlY7bO5KEoayZnB18qe4nAId3EgAbEEudompindgidwcmnoyMlRQq1JBHfxEeuK5Xjz8qaO9mEoOl+P77AvR/OfWkdACZ6j9AhVYjf2GOtCAL9IHhockPALmcKsTuikF0WUeMMveWkBlp3pavcM9F4s/Im+9qASVyZWjun+L6j/SvPgFRYJkRB6kaeQK3/VpMJq2UUKyGWBVktp72yV4d24nfZwXfRACq6qb0QXXubdw7OMO6zg8W5iTQP0ZqK2zBN9+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::6) by ZQ4PR01MB1170.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.23; Tue, 14 Oct
 2025 01:11:44 +0000
Received: from ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::678:a5f4:7eeb:cf5]) by ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
 ([fe80::678:a5f4:7eeb:cf5%6]) with mapi id 15.20.9182.020; Tue, 14 Oct 2025
 01:11:44 +0000
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
 =?gb2312?B?u9i4tDogW1BBVENIIDExLzExXSBpcnFjaGlwOiBQYXNzIHBsYXRmb3JtIGRl?=
 =?gb2312?Q?vice_to_platform_drivers?=
Thread-Topic: [PATCH 11/11] irqchip: Pass platform device to platform drivers
Thread-Index: AQHcPCa5QsFOWkClUEOrWkAOtrRB/bTA1mSw
Date: Tue, 14 Oct 2025 01:11:44 +0000
Message-ID:
 <ZQ4PR01MB1202DC8FB0383C35D4FD3D10F2EB2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20251013094611.11745-1-johan@kernel.org>
 <20251013094611.11745-12-johan@kernel.org>
In-Reply-To: <20251013094611.11745-12-johan@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ4PR01MB1202:EE_|ZQ4PR01MB1170:EE_
x-ms-office365-filtering-correlation-id: 31d17c7d-02e4-41b7-73c8-08de0abea412
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 swbnB+xQbXj/WDdgxlApwWt4Vmv75vvee5LMXFMXvIG5/hPQHx+pNsWTkMNtJELMa0bszf+CrfaznVEC7aiOmWVrvRfRf2fVpuMWSsVWZy5R05uWnWvvCm3YvHclH2JNffAGMcG8NkdiLk7h6Hen9V8oURXm2ONml7+Ul5OZWXFndAfUBv8enzNq2Ugm1fQtLRtUQ9goN/uwetxXteEo8xAXQZEbe41ZgYJx/uh6J9kNwQjNnUk7beXeMcARkzHIvXMjn+4Zit9+I9z3Inq8mWHxEMhJeEkvM4lLzAgf76HU6+pONKTKu+6n9/MZ4aci6JXcant5K5+WMPwm8V2ESttn5Ksp4A+r8eyoxjY3iA5HVdqXzfJ+hCseOtVfgxhFnb6kH8NzMgC4wJFZ+E70bKbmn+95i0vWW6B4XnYaSBrEigr2gDBD4kra5SThSVgpLqrHF4BwrVtqCbm/82eGUABYJNgCr0+BCPi7izA6psApMNjfLJooFlylS0f5Qlmo+3r25RO3nGC0UcQspTHkJv3+jnDBOGvFJrntiqlHxZd4kDD8KLKlAQp03KwDdjKfJ9jbQ17uRmFv+SAAryv8Hg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?djhYK2p2emlDcDdwWjBLalY3M1dtQmVQd2ZobXdVRTVEMkdmZ09FbVFQY21i?=
 =?gb2312?B?SlB0ZmJRQmFGejR2S2ordmN4cjQyV1U3N1puaVlZVE4rRzFPNm9yRWt4K1Y0?=
 =?gb2312?B?Ny9TNlJvdTRaTWhqbXgrRENNTElJaTd1MU9lR3M3cEFOYmFXdUVtVkszWU5p?=
 =?gb2312?B?QjRic1Rva2ZkbS9ReUlCY0NreVhNUE9RM1Jvek9aUitwQnpMcEMzZVNzZnZE?=
 =?gb2312?B?SDlhbDRtcmJJdlZjM01tcDFISGZQeldDZTAyNTZjVUllTXk3MVpvKy9EVWRV?=
 =?gb2312?B?WjF0bjQ4V3FlQ0lnWUdKeW9hbmdjU2lDTE1VTCtleTBScjVkOWRLVnFRd0tV?=
 =?gb2312?B?UEI3ZVFpd2VwOUMxdFlRbENYY1BPM1pQek9zYmRDQ1pXa0xxSzlIVU1XYjRE?=
 =?gb2312?B?aUREQnFxY1c4dkFQRGtPYVVhZlRGQXRTTE00UEs0MnhyYjNhblRNTEtIbDhO?=
 =?gb2312?B?eWo2NHZXTDV0WEw2V2xGVzg2amRZUGxlQVUxRzVpZ3pjYUVOdlkzbnpmdzZY?=
 =?gb2312?B?N1hhVW1uYlRGaTdjRFdpcDZhS0RFOWdUWm45SEtSMDB1d2gzRU93Y3BuTmhS?=
 =?gb2312?B?OTlUWjE2TTNUcGVidENDZVZjZUpDZXBEVlIrNEJQTzFNck04bEVLQTlDczVW?=
 =?gb2312?B?dDF5dHhBdDcyTndDdCtTWFJyTlAyMEJzZk00R25ici91WnN4T3pRaVUrSkRR?=
 =?gb2312?B?anduNmdobGY4KzhlbUlGUmg3Z2pSNGpscUtmNFVRZXV5YUFnQUtBUmdTcGZr?=
 =?gb2312?B?eWlHM1BlS205WnhxM0NsNXIvYkNUeFJmVXNnMHNPQk9UZ0RCa1BJbzlWaTEz?=
 =?gb2312?B?NEhtNStOaW9iSFVkcWZPOXJ6bi9RazBiZFh4Wkp2eWxTeEQ2QXVLNjBVUWly?=
 =?gb2312?B?d1d2a1hVby9vdGs2OHpPZHlRTnM5a2RZK1M3aGNZaEE4U3BRMTRvQjlsQUIx?=
 =?gb2312?B?eEY5VGxvVTgyaVd0ZG9zazJEQVdDWWFUTHZJUXNXb1FwZEJwSHF1YlBXRGsr?=
 =?gb2312?B?RVJFVllpZ2NjaWF0dVh6enFpSDk4djdXYTQ5SGVCVExkQXpIRCtkek5HTWlJ?=
 =?gb2312?B?U3l2TlpuSkFKTjlsZE1UUG9SekVURjNmeDFONHhCblZKODJncFFMdFd5UmNx?=
 =?gb2312?B?TTJKUUhQU3laK3FJbE1iM29QRmM0MFlxRnJHVE5CUUs5cURtK2paa04ydjRW?=
 =?gb2312?B?SEE5Mm1lMlliL0N0MkJwTTJjQ3RLYlgrUi9lMC80WlZJWWtDSGc3M3VFNGF0?=
 =?gb2312?B?WFBvQUhRMDBlaHIwbnJ5RzRLdUtPZ0k4dnN2UkZvLzlFdkVyaDNIcVVzWGZv?=
 =?gb2312?B?SkxvcGw4L3djWm1kcUM4N0RJcmJja2JnTytGdVVDckJhQVg0Q3hWendLMGl4?=
 =?gb2312?B?K1BWQU1UaWFtd2Y3d2NVRlp5dk1LZlg5VWU3OVh3SW9xWk15UlVGZW9xOGdO?=
 =?gb2312?B?ME41bDVLbFN0Q2dka1dveURMb24wNzdsTUFoaU8zWnRLUHo0VStjbEtnWHVZ?=
 =?gb2312?B?blBjSUFqR1lqUC9lSkMxdkVUWGZiN2x3ZFRHL2hkdzBUT1k3cjY2NHprMm9V?=
 =?gb2312?B?dzdteTdOWjdJVmtqc1EvU0MrMmJHOHlCQXBMUlNOdnRuSCtORTJvYjJkek4r?=
 =?gb2312?B?Tys0S1RQVXBDQzU1RkQ3eUlHdFgyb1IvWlpSSWpwTkRjODRPTk5lTFliSFB0?=
 =?gb2312?B?bFB2NXNWVnd2MjdJL2YxUkhUaEJDUDFwcnhpcVRkWlFGUnNNMFdvK2FmMlI3?=
 =?gb2312?B?ZUFKN0pmcldQb2QxcFc3THlDTE5sSHhURjI4UFJMSVc0TmV3emZrZzZHRnp4?=
 =?gb2312?B?dEZsS2pUL3hEK1U2M0QxL2RjSVZ3T3hJeTNVL1FsamFIZG1SRlRWUTViNU1Q?=
 =?gb2312?B?ZnUvZWlPMUg1RzUvdmJJYjJ1dUxaeWV3NWpjVFZTeHNBQndYQzV5d0xGb010?=
 =?gb2312?B?Mi8xeUtpZlB0aXQvdlBwdDdPdTd0MUtjWWxDNTFDVUJqcnhUTlU3R3g4ZnJo?=
 =?gb2312?B?eDMrci92TFppaTFuSURpL0doYjVJSjM4WkVIMkc1cHRMZFpMU2xwOUkyUitM?=
 =?gb2312?B?c3R4eGRXdThyYmxFMWpnUG04c3V6RWdIamh3TFZxWFFjV1BrZEhNYitxV3pY?=
 =?gb2312?B?TE1URTE0cTc1N3lPMkFFZlhiaG1kNFVFMFVTUkJweXhVTmV4MlFXN3JjQzhj?=
 =?gb2312?B?VlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d17c7d-02e4-41b7-73c8-08de0abea412
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 01:11:44.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YM24x68lCAlpdsiv+TEfCC0k4fcAiDIdQc+T2hBJ+1O3/3d0K0P065NgUqNQQP71Qbhv91kQ2PLSwXvcAhp0602YpSZvehZQR9E9KvDvOYWYO4GcZzOh6FRiyLg0BsM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1170

SGksIEpvaGFuDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLg0KDQo+IFRoZSBJUlFDSElQX1BMQVRG
T1JNX0RSSVZFUiBtYWNyb3MgY2FuIGJlIHVzZWQgdG8gY29udmVydCBPRiBpcnFjaGlwDQo+IGRy
aXZlcnMgdG8gcGxhdGZvcm0gZHJpdmVycyBidXQgY3VycmVudGx5IHJldXNlIHRoZSBPRiBpbml0
IGNhbGxiYWNrIHByb3RvdHlwZQ0KPiB0aGF0IG9ubHkgdGFrZXMgT0Ygbm9kZXMgYXMgYXJndW1l
bnRzLiBUaGlzIGZvcmNlcyBkcml2ZXJzIHRvIGRvIHJldmVyc2UNCj4gbG9va3VwcyBvZiB0aGVp
ciBzdHJ1Y3QgZGV2aWNlcyBkdXJpbmcgcHJvYmUgaWYgdGhleSBuZWVkIHRoZW0gZm9yIHRoaW5n
cyBsaWtlDQo+IGRldl9wcmludGsoKSBhbmQgZGV2aWNlIG1hbmFnZWQgcmVzb3VyY2VzLg0KPiAN
Cj4gSGFsZiBvZiB0aGUgZHJpdmVycyBkb2luZyByZXZlcnNlIGxvb2t1cHMgYWxzbyBjdXJyZW50
bHkgZmFpbCB0byByZWxlYXNlIHRoZQ0KPiBhZGRpdGlvbmFsIHJlZmVyZW5jZSB0YWtlbiBkdXJp
bmcgdGhlIGxvb2t1cCwgd2hpbGUgb3RoZXIgZHJpdmVycyBoYXZlIGhhZCB0aGUNCj4gcmVmZXJl
bmNlIGxlYWsgcGx1Z2dlZCBpbiB2YXJpb3VzIHdheXMgKGUuZy4gdXNpbmcgbm9uLWludHVpdGl2
ZSBjbGVhbnVwDQo+IGNvbnN0cnVjdHMgd2hpY2ggc3RpbGwgY29uZnVzZSBzdGF0aWMgY2hlY2tl
cnMpLg0KPiANCj4gU3dpdGNoIHRvIHVzaW5nIGEgcHJvYmUgY2FsbGJhY2sgdGhhdCB0YWtlcyBh
IHBsYXRmb3JtIGRldmljZSBhcyBpdHMgZmlyc3QNCj4gYXJndW1lbnQgdG8gc2ltcGxpZnkgZHJp
dmVycyBhbmQgcGx1ZyB0aGUgcmVtYWluaW5nIChtb3N0bHkNCj4gYmVuaWduKSByZWZlcmVuY2Ug
bGVha3MuDQo+IA0KPiBGaXhlczogMzJjNmMwNTQ2NjFhICgiaXJxY2hpcDogQWRkIEJyb2FkY29t
IEJDTTI3MTIgTVNJLVggaW50ZXJydXB0DQo+IGNvbnRyb2xsZXIiKQ0KPiBGaXhlczogNzBhZmRh
YjkwNGQyICgiaXJxY2hpcDogQWRkIElNWCBNVSBNU0kgY29udHJvbGxlciBkcml2ZXIiKQ0KPiBG
aXhlczogYTYxOTliYjUxNGQ4ICgiaXJxY2hpcDogQWRkIFF1YWxjb21tIE1QTSBjb250cm9sbGVy
IGRyaXZlciIpDQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9y
Zz4NCg0KUmV2aWV3ZWQtYnk6IENoYW5naHVhbmcgTGlhbmcgPGNoYW5naHVhbmcubGlhbmdAc3Rh
cmZpdmV0ZWNoLmNvbT4NCg0K

