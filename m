Return-Path: <linux-kernel+bounces-898620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C30C559A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A613AD130
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920A295DA6;
	Thu, 13 Nov 2025 03:57:29 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2139.outbound.protection.partner.outlook.cn [139.219.146.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26C07E0E4;
	Thu, 13 Nov 2025 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763006248; cv=fail; b=bGa/z5HjzP/FzPvaKcWv+DSN+/BM3Qslr3SMysO2l3Dr69iHapz69DL/J1I/6fJ8cakUQ+hHpcyFaN7/R20a81BGdRMqmHa3aBDd0rttNmt0WrzVlApyPwMa0B9r5U3owq0AnGm2WFdwWU7VIj7tf0sKOD6d0XC1HY8fg+Zm7Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763006248; c=relaxed/simple;
	bh=X/YxKp1w1FPuthTEdALqQaEdcEt5uPO+mvS9gGWpD+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8luNMKU4j8QyVzHS5e24khdS7gwRc+bSv24dvRpqQAvTI6LrpdNqzdNUrb3pUBUIxJaGuj/h9BBIEtKi6ysr4sZ+W0DR+C9NRzKdKFed5PN8GscdcL2jNaKbadztQOtKzJxbEI2Z2ms/s9wRam8z5VF6yMnBQWKXf5NW70gNsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqkLvMZZSWFTrEZ70WjJWa3rL35g/QO1hnTY8nMN3u7OJIsTYEcBew4s97C+rN9hioojD5XCDvu5BhbHNSO8cEx9VC7a+/AVLhKrcjBx4WnupyaGrAehNBBXuw0d6N1O/x73XSOvFjsvgtNeTDhRfkK9q7lg8VlktJSJDEpp1CEZTqOPtxq5Cgufw9Azt/HzrUIoLgx1rvq7vg4xhx8xZzVT08nxCzRw/XI+SC/fXQ1oH1MR2E5CHRzlOBUKcTn+SXDSPLwByrp+qalZWKlhkEbkSLZHtxJTulMajTMfaqc6NZhD2LMBPyNx7DB71k8xaG02Z6O4yD6SYbMNQtjPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/YxKp1w1FPuthTEdALqQaEdcEt5uPO+mvS9gGWpD+Q=;
 b=bzoh4WGlf3mq6PvDXUf8Mj1PMM996cBS1AVtvbMjn9536+2diYu22QsfRHD4Wizfqe8sM9wtiVPHpBnStMwWfohhKQHY3XNCXMWaJZQw8FL1mUNqZQ0/h3Ayc8jCRMz822D18xt9Q7Yd+BV3uceLaFhW1A8TncAzuF9J/xQs4Jrl061krBkgyRplZj2jyp1zA4xw0Pyqq1LwqQthRgqLr07XljUU8IubZIHg6du/OGaZ/4WaSFIdgjRPjMlP6DTHGtbAZjH6OjMHoOUecoQdYBpWpdN+MF7Ig8ccQy4ldeSMl5QpDYYmVQuYdnol4OyQggR2y56jWtMk5ftnOnjMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 03:42:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 03:42:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley
	<conor+dt@kernel.org>, E Shattow <e@freeshell.de>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Thread-Topic: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Thread-Index: AQHcT8yr76WB0y2LYU6wjdN+ecXGd7TvGAmAgADiXSA=
Date: Thu, 13 Nov 2025 03:42:05 +0000
Message-ID:
 <ZQ2PR01MB13076544E2136E7E7C2EEDA1E6CD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>
In-Reply-To:
 <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
x-ms-office365-filtering-correlation-id: c12e178f-4a05-4494-e085-08de22669d3c
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 hlnCs7Pd531QjbT4AFDHiuQONFos1SJTGsHEv58Ujv00K/+m/uQpsPfaGVlvU8FkAZweXgw+91uWByn4xkjDrBQHFINZit3dkVWrEJbaO6Pq8tEh/xorVHz+mE2/7GvF0DR49udqJ/8tttEp7DwTTp/gekKr6bHgsWz1ZTbZLle/JH5GSkvokE1UT8AL0rmpUywgZPhMEDPhCLPoXYAFIA2H3QnheMI96xn92SPZ8Gumi/YFIrdEzlG2gu9YglW/zfsDTKD2lobsrngpw3zJYK2AWKAh0kctZmCX5yfPpawWsqIHA5aKS7iLRYeOAvEESLRU+xULRmRESHj/868poRS+vMeqoIgLPSKEKViPIzmemiG21X9vPcX1e7Lbd8oF2HNTvUHpE+n1V3Ug+UJz6wSZxur1jjM6f9hqB5ZMSTQPnGeMSi2N9bsnCdnRJz1cs/dUvcR9CQ7Y8/23xSGHIvLwXHUTskGBUDzJH/XCG32ZzaFneFLz4HFImuufQBC/unv9YHk5SKMIEbz93L7lzFk2kQ6MoBWYOPMMhChSBQcO55A2vCanh5WJe4ZCGVCcXdBdtuVpciVm924P0wGvHACp/TG+gf5bLRpOtA3oq5w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXVHUHdQU0pEY2MvSHJnME5YeXVzQ3BkanJyeWVXdWxoZ0F1VXkwNC9zVFFy?=
 =?utf-8?B?NzhyTnRiN0pTUEJOZlRPNk9CTmlGOEZBMUhyM3hKK1Qwazg0eHVpaEhYR3VE?=
 =?utf-8?B?MDdjTEkxejU5c0pXNmdtcE9uZ3VieEZiRXZiNDVYSUlIV1F4eFdWNEhPaDVj?=
 =?utf-8?B?TVRWWW5tWTJXb1VMa1pacU44VG55Z2RDSlB0WHJjNS9JbEJLOXBGS1lsUlQ2?=
 =?utf-8?B?UDkyMXJiUVkvTmxldk0xalZ3M0NmWWpPMnBuM1ZvdGhDRi9tU0puSG9ycnd6?=
 =?utf-8?B?SFNjVXVoRFhubEFIZldsN0dTS0FKVnVLc0lRcXJ1UmJoZ3BabVNoRVd3SXMw?=
 =?utf-8?B?bXJVRU5BangvQjVXTWNQSFppd3pzK3pFVzQzTG1iRXQwbHNJT0hVU01qQ1RY?=
 =?utf-8?B?MXdRTVBCeEd2RXR0c3FORU9Send6Ykxnamk4V2psZmZ6dDlVS2JsMkhuTzhw?=
 =?utf-8?B?VFBkdGM2SS9kT2o2WW1HaTBTVGRZQ25jcW14a0Fnd1VPbkd3ZUNYdjdaOWkw?=
 =?utf-8?B?MGlZNmx3TXdySXFOeEtLVXdSZmFFZTVSTGJ5dXYyZ2FabUtmS2VodkttUFZO?=
 =?utf-8?B?cGxQejJXUTZCU0pscjVxOUZ3WEN3NFpEbWlSMTROV0F0WTJoVjVaaTdwcUZ2?=
 =?utf-8?B?ZklSSUpud1k0dHNOTkUvVmsxNW9Ed1dTdzFSQXNrWHRlc01yU2o5L1VDMzdT?=
 =?utf-8?B?MFNnNDh6bDZNNGZOOWdBMzFxMDV5cjN1V2MvYzV1MWFTS1lQSmNtV21YL1FN?=
 =?utf-8?B?bWEvQTFpRXFrTjJCVVUwVUFoVnFQOWd5ZWNtUUtoS3J5bHZXb1cvWUVQcmVu?=
 =?utf-8?B?QVUybWtWKzEzSXJWRHhjM2xpSjQyUHZERmdkbWUycFJlaFhqNVVhaWN2Ri9y?=
 =?utf-8?B?aFlROXBBUklCYjAweU1CSGwrN0s0RUJxUnEyMmt4YVhvQThHcnJGL2xuZ3Jw?=
 =?utf-8?B?dVZNSmVFVHRrTGpIY0s4bWNmeEROUlgycnIyUDZVZCswSjdnTHRwSlhTRDA1?=
 =?utf-8?B?Rmc1ejd5UEsvUE1YQnR5SnBRSHcxdUVvZnMrYjNqK1RHMmdlWUZuSlZnTFlF?=
 =?utf-8?B?eTJTNEExM3gzK0ZhQVYrRjRncy9tOEtiaUYrSWgwUmxiSnpTYmlFb2hyVEFN?=
 =?utf-8?B?OUxDVGx5STJTTmhEQ3hhdnZ0QUl3OFNTZzRSS2sxeXJrRzJ3UzJ5M3dLNkdz?=
 =?utf-8?B?eGVqakZseTlzREJyYTFwbXFIalluamJpamtDSnJRRVc4Z1BWNWV1eno2NnB2?=
 =?utf-8?B?eDFxUHorV25vRTFXWmRmQmJ4VXZScVU0M1dUNVhJcW13MCtTWm5XZDNPWEZv?=
 =?utf-8?B?OUh2Q3I3QXF4YnZlUXZUcjR4OVBiMTVaVFc2R0R6Qisvc0h0QmNtcTliak1o?=
 =?utf-8?B?LzRJV2pDdWs1SEN2cVdTZzhDdlhFMTkrWXBSUXYwNDlVZGMrUjhHRU1oSUR5?=
 =?utf-8?B?R3ZkWVFVTEo3R05tR2l2SjZ3UE1OUWNuZUpGd3dySldZRHlaUkVTUEJicXpP?=
 =?utf-8?B?UGpCSSthWHFXa1NLczJPVktGd0cxYUhKUHh4WjhCdzk5eHpuSzE0bVJ5cEM1?=
 =?utf-8?B?WHluSEhiTFZFT29TR2p6ZWd5K2NmTW52MXpXZXp2VE1OZTFOWGxoTDc3dlNB?=
 =?utf-8?B?Q0ZHcm45NUZ5YXlVbUFFbk55d3cvZy9wM0t5c0p2Z2xtbVBlWDBBY0RXVXU5?=
 =?utf-8?B?K2NmMGVKekd5Y1h2NDBBYVVQQTNETzFoV0p1MGhtZEtCQlNaVUgrZ0I1aHlv?=
 =?utf-8?B?eGZKQmFTei9tYVVUaTRZVXE4TTlUdWhYYWtrUGN2blpUMmkwTWFSUm1jREps?=
 =?utf-8?B?V3VqSlB4dlcrbklOWWx2TjJ0WXhzWFJYVWtwRXlVdDRtU3hWVml6UHhkcGZy?=
 =?utf-8?B?OTJQTnhvdmVvczhyYmhKdjlpSnFtVlFpUGl4clZqMFZGREQzOCszMmdCRm5l?=
 =?utf-8?B?bHFmTzRnejRmaVczcHdESm0ram9kM3V2MDhpSEJ4bzBTK1dMZU51ZWpWSkZG?=
 =?utf-8?B?aXpvYnZ4YWZGSGVVY3ZGVjNxWWdYZVZBS0dTeW0vOEJKNDV3RU9paVZISEo0?=
 =?utf-8?B?RmY3TFZydFBVaDNkU1ZSQjhJbnUvb1JuUTIwU0JWckt6OVVFTGtHS0grRHdS?=
 =?utf-8?Q?Jhcm8hwETFcC6y7eonkdV7cgk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c12e178f-4a05-4494-e085-08de22669d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:42:05.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMK0YvlCwDDvHOatNH0hRqn+styk30e9V/i0roM9mOYIA/GhT05veF7jb4SlkELTtlCsg+sKdnSbjm/jqomxejt1f5h8pSwU+Q3Boym2gMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227

PiBPbiAxMi4xMS4yNSAyMTo1NCwgRW1pbCBSZW5uZXIgQmVydGhpbmcgd3JvdGU6DQo+IFF1b3Rp
bmcgSGFsIEZlbmcgKDIwMjUtMTEtMDcgMTA6NTU6MjIpDQo+ID4gVmlzaW9uRml2ZSAyIExpdGUg
aXMgYSBtaW5pIFNCQyBiYXNlZCBvbiB0aGUgU3RhckZpdmUgSkg3MTEwUw0KPiA+IGluZHVzdHJp
YWwgU29DIHdoaWNoIGNhbiBydW4gYXQgLTQwfjg1IGRlZ3JlZXMgY2VudGlncmFkZSBhbmQgdXAg
dG8NCj4gMS4yNUdIei4NCj4gPg0KPiA+IEJvYXJkIGZlYXR1cmVzOg0KPiA+IC0gSkg3MTEwUyBT
b0MNCj4gPiAtIDQvOCBHaUIgTFBERFI0IERSQU0NCj4gPiAtIEFYUDE1MDYwIFBNSUMNCj4gPiAt
IDQwIHBpbiBHUElPIGhlYWRlcg0KPiA+IC0gMXggVVNCIDMuMCBob3N0IHBvcnQNCj4gPiAtIDN4
IFVTQiAyLjAgaG9zdCBwb3J0DQo+ID4gLSAxeCBNLjIgTS1LZXkgKHNpemU6IDIyNDIpDQo+ID4g
LSAxeCBNaWNyb1NEIHNsb3QgKG9wdGlvbmFsIG5vbi1yZW1vdmFibGUgNjRHaUIgZU1NQykNCj4g
PiAtIDF4IFFTUEkgRmxhc2gNCj4gPiAtIDF4IEkyQyBFRVBST00NCj4gPiAtIDF4IDFHYnBzIEV0
aGVybmV0IHBvcnQNCj4gPiAtIFNESU8tYmFzZWQgV2ktRmkgJiBVQVJULWJhc2VkIEJsdWV0b290
aA0KPiA+IC0gMXggSERNSSBwb3J0DQo+ID4gLSAxeCAyLWxhbmUgRFNJDQo+ID4gLSAxeCAyLWxh
bmUgQ1NJDQo+ID4NCj4gPiBWaXNpb25GaXZlIDIgTGl0ZSBzY2hlbWF0aWNzOg0KPiA+IGh0dHBz
Oi8vZG9jLQ0KPiBlbi5ydnNwYWNlLm9yZy9WaXNpb25GaXZlMkxpdGUvUERGL1ZGMl9MSVRFX1Yx
LjEwX1RGXzIwMjUwDQo+ID4gODE4X1NDSC5wZGYgVmlzaW9uRml2ZSAyIExpdGUgUXVpY2sgU3Rh
cnQgR3VpZGU6DQo+ID4gaHR0cHM6Ly9kb2MtZW4ucnZzcGFjZS5vcmcvVmlzaW9uRml2ZTJMaXRl
L1Zpc2lvbkZpdmUyTGl0ZVFTRy9pbmRleC5odA0KPiA+IG1sIE1vcmUgZG9jdW1lbnRzOg0KPiA+
IGh0dHBzOi8vZG9jLWVuLnJ2c3BhY2Uub3JnL0RvY19DZW50ZXIvdmlzaW9uZml2ZV8yX2xpdGUu
aHRtbA0KPiANCj4gDQo+IEhpIEhhbCwNCj4gDQo+IEN1cnJlbnRseSB0aGUgSkg3MTEwIGRldmlj
ZSB0cmVlcyBhcmUgbGF5ZWQgb3V0IGxpa2UgdGhpcywgd2l0aCBhIG5pY2Ugc2VwYXJhdGlvbg0K
PiBiZXR3ZWVuIHRoZSBTb0MgZGVzY3JpcHRpb24gYW5kIGJvYXJkIGRlc2NyaXB0aW9uczoNCj4g
DQo+IGpoNzExMC5kdHNpICAgICAgICAgICAgICAgIyBKSDcxMTAgU29DIGRlc2NyaXB0aW9uDQo+
IHwtIGpoNzExMC1jb21tb24uZHRzaSAgICAgIyBQZXJpcGhlcmFscyBjb21tb24gdG8gYWxsIEpI
NzExMCBib2FyZHMNCj4gICAgfC0gamg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICMg
UGVyaXBoZXJhbHMgY29tbW9uIHRvIFZGMiBib2FyZHMNCj4gICAgfCAgfC0gPFZGMiBib2FyZHM+
ICAgICAjIEZpbmFsIFZGMiBib2FyZCBkZXNjcmlwdGlvbnMNCj4gICAgfC0gamg3MTEwLW1pbGt2
LW1hcnNjbS5kdHNpICMgUGVyaXBoZXJhbHMgY29tbW9uIHRvIE1hcnMgQ00gYm9hcmRzDQo+ICAg
IHwgIHwtIDxNYXJzIENNIGJvYXJkcz4gIyBGaW5hbCBNYXJzIENNIGJvYXJkIGRlc2NyaXB0aW9u
cw0KPiAgICB8LSA8b3RoZXIgYm9hcmRzPiAgICAgICMgT3RoZXIgSkg3MTEwIGJvYXJkIGRlc2Ny
aXB0aW9ucw0KPiANCj4gV2l0aCB0aGlzIHNlcmllcyBpdCBtb3ZlcyB0bw0KPiANCj4gamg3MTF4
LmR0c2kNCj4gfC0gamg3MTF4LWNvbW1vbi5kdHNpDQo+ICAgIHwtIGpoNzExMC1jb21tb24uZHRz
aQ0KPiAgICB8ICB8LSA8amg3MTEwIGJvYXJkcz4NCj4gICAgfC0gamg3MTEwcy1jb21tb24uZHRz
aQ0KPiAgICAgICB8LSA8amg3MTEwcyBib2FyZHM+DQo+IA0KPiAuLndoaWNoIEkgY2FuJ3QgZXZl
biBnaXZlIGNsZWFyIGxhYmVscyBsaWtlIGFib3ZlLiBJbiBvdGhlciB3b3JkcyB3aGVuIG5ldw0K
PiBwYXRjaGVzIGFyZSBzZW50IGluIGl0IHdvdWxkIG5vdCBiZSBlYXN5IHRvIGV4cGxhaW4gZXhh
Y3RseSB3aGVyZSBlYWNoIGNoYW5nZQ0KPiBzaG91bGQgZ28gYW5kIHdoeS4NCj4gSSdtIGFsc28g
d29ycmllZCB0aGF0IHlvdSdsbCBmaW5kIHRoYXQgbW9yZSBvZiB0aGUgcGVyaXBoZXJhbHMgb24g
dGhlIEpINzExMFMNCj4gbmVlZCBzcGVjaWFsIGhhbmRsaW5nIGFuZCBhIG5ldyBqaDcxMTBzLS4u
LiBjb21wYXRpYmxlIHN0cmluZy4gVGhlbiBJIGd1ZXNzDQo+IHRoZXknbGwgbmVlZCB0byBqdW1w
IGZyb20gamg3MTEweC5kdHNpIHR3byBsZXZlbHMgZG93biB0byBqaDcxMTB7LHN9LQ0KPiBjb21t
b24uZHRzaSB3aGljaCB0aGVuIGJvdGggZGVzY3JpYmUgU29DIGFuZCBib2FyZCBwcm9wZXJ0aWVz
Lg0KPiANCj4gSWYgeW91J3JlIHNlcmlvdXMgYWJvdXQgY2FsbGluZyB0aGlzIGEgbmV3IFNvQyB0
aGVuIEknZCBleHBlY3Qgc29tZXRoaW5nIG1vcmUNCj4gbGlrZSB0aGlzOg0KPiANCj4gamg3MTF4
LmR0c2kgICAgICAgICAgICAgICAgICAjIFBlcmlwaGVyYWxzIGNvbW1vbiB0byBib3RoIFNvQ3MN
Cj4gfC0gamg3MTEwLmR0c2kgICAgICAgICAgICAgICAjIEpINzExMCBTb0MgZGVzY3JpcHRpb24N
Cj4gfCAgfC0gamg3MTEwLWNvbW1vbi5kdHNpICAgICAjIFBlcmlwaGVyYWxzIGNvbW1vbiB0byBh
bGwgSkg3MTEwIGJvYXJkcw0KPiB8ICAgICB8LSBqaDcxMTAtc3RhcmZpdmUtdmlzaW9uZml2ZS0y
LmR0c2kgIyBQZXJpcGhlcmFscyBjb21tb24gdG8gVkYyIGJvYXJkcw0KPiB8ICAgICB8ICB8LSA8
VkYyIGJvYXJkcz4gICAgICMgRmluYWwgVkYyIGJvYXJkIGRlc2NyaXB0aW9ucw0KPiB8ICAgICB8
LSBqaDcxMTAtbWlsa3YtbWFyc2NtLmR0c2kgIyBQZXJpcGhlcmFscyBjb21tb24gdG8gTWFycyBD
TSBib2FyZHMNCj4gfCAgICAgfCAgfC0gPE1hcnMgQ00gYm9hcmRzPiAjIEZpbmFsIE1hcnMgQ00g
Ym9hcmQgZGVzY3JpcHRpb25zDQo+IHwgICAgIHwtIDxvdGhlciBib2FyZHM+ICAgICAgIyBPdGhl
ciBKSDcxMTAgYm9hcmQgZGVzY3JpcHRpb25zDQo+IHwtIGpoNzExMHMuZHRzaSAgICAgICAgICAg
ICAgIyBKSDcxMTBTIFNvQyBkZXNjcmlwdGlvbg0KPiAgICB8LSBqaDcxMTBzLWNvbW1vbi5kdHNp
ICAgICMgUGVyaXBoZXJhbHMgY29tbW9uIHRvIGFsbCBKSDcxMTBTIGJvYXJkcw0KPiAgICAgICB8
LSA8Skg3MTEwUyBib2FyZHM+ICAgICMgRmluYWwgSkg3MTEwUyBib2FyZCBkZXNjcmlwdGlvbnMN
Cj4gDQo+IEkga25vdyB0aGlzIHdpbGwgbWVhbiBzb21lIGR1cGxpY2F0aW9uIGluIGpoNzExMHss
c30tY29tbW9uLmR0c2ksIGJ1dCBJDQo+IHdvdWxkIHByZWZlciB0aGF0IHRvIG5vdCBoYXZpbmcg
YSBjbGVhciBleHBsYW5hdGlvbiBvZiB3aGF0IGVhY2ggZmlsZSBkZXNjcmliZXMuDQo+IA0KPiBE
byB5b3UgdGhpbmsgdGhpcyBsYXlvdXQgY291bGQgd29yayBmb3IgeW91Pw0KDQpZZWFoLCBpdCBp
cyBjbGVhcmVyIGZvciBkZXZlbG9wZXJzIGFuZCBtYWludGFpbmVycy4NCg0KQ29uc2lkZXJpbmcg
Q29ub3IncyBzdWdnZXN0aW9uLCB3aGF0IGFib3V0Og0KDQpqaDcxMTAuZHRzaSAgICAgICAgICAg
ICAgICMgSkg3MTEwIFNvQyBkZXNjcmlwdGlvbg0KfC0gamg3MTEwLWNvbW1vbi5kdHNpICAgICAj
IFBlcmlwaGVyYWxzIGNvbW1vbiB0byBhbGwgSkg3MTEwIGJvYXJkcw0KICAgfC0gamg3MTEwLXN0
YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICMgUGVyaXBoZXJhbHMgY29tbW9uIHRvIFZGMiBib2Fy
ZHMNCiAgIHwgIHwtIDxWRjIgYm9hcmRzPiAgICAgIyBGaW5hbCBWRjIgYm9hcmQgZGVzY3JpcHRp
b25zDQogICB8LSBqaDcxMTAtbWlsa3YtbWFyc2NtLmR0c2kgIyBQZXJpcGhlcmFscyBjb21tb24g
dG8gTWFycyBDTSBib2FyZHMNCiAgIHwgIHwtIDxNYXJzIENNIGJvYXJkcz4gIyBGaW5hbCBNYXJz
IENNIGJvYXJkIGRlc2NyaXB0aW9ucw0KICAgfC0gPG90aGVyIGJvYXJkcz4gICAgICAjIE90aGVy
IEpINzExMCBib2FyZCBkZXNjcmlwdGlvbnMNCnwtIDxKSDcxMTBTIGJvYXJkcz4NCg0KTW92ZSB0
aGUgb3BwIHRhYmxlIGZyb20gamg3MTEwLmR0c2kgdG8gamg3MTEwLWNvbW1vbi5kdHNpLg0KUmVt
b3ZlIGpoNzExMHMtY29tbW9uLmR0c2ksIGJlY2F1c2Ugb25seSBvbmUgYm9hcmQgdXNlcyBKSDcx
MTBTIG5vdy4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=

