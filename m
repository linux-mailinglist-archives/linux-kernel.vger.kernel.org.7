Return-Path: <linux-kernel+bounces-780990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72BB30C02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2501D01D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F28F21E0BE;
	Fri, 22 Aug 2025 02:47:17 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2117.outbound.protection.partner.outlook.cn [139.219.17.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEE393DC6;
	Fri, 22 Aug 2025 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830836; cv=fail; b=PQiFWav0MXmYmmX4clTtkOsXVAq3KMjbQzj5HYHw6GCmod+LCQs9SVLicMX4AcsD1/CVnIIMlzZeyY+y/hr1/aiH2YNS0sQiA0kexKWipBm+jf7sfLHpRLeEtEr1rY3BlZ1X6t4J7T1TSxqh1Q5PbkVEsgbglo3uKZQ9Yb3J7Xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830836; c=relaxed/simple;
	bh=fkGugi36vkKwmkDtB8Dk84tdNc0FOy9r8GBmyjQVdA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HBuRGLXQy6LBZoRX8aeiDHnv7LKaJTKI8nH0IjH4IDuGHmDJk1WApTRzDzKc2kUkytzQyzJix8sAvGRFzczZjEVpujBpwASKt0Cw03PMLoby+ROp783MNfeu8B4QjgcKgmGR8udEHFLGM/w3zAKOAkgKxZfQUE7a0SP6gq8+sh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoJCk7JmXMu0Fyuaornn7NkhfH3EgFJIqfPyjTrjHOsqnUMqmvzdtoUJuxRcAO2vTw5qLN6bNu7HZWDOfM0pSRno2wc8CUs3k1Vd2T6KFII6yOS/6C89PAs0eHHqLoEnYEJSgeSnQhw9L8Ij4veWOOt8JR5EsUZk/ji5oFqB+5b7nDQ90G/DhVa/AlN+JrV/QTJ+eubUbluM/U0jJB1Hmu+mvLIkFKjozKhFKVEEjmhfpbPS3nYpHQVB7pN+XMbqY2tk1x63TG1XtxVrgNW5x8waUPkFb/QjmwYTSaZ94GMDSNv+I3G6xF0pACT/ui1moFz1sSUWqsjXxDJZqJXXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkGugi36vkKwmkDtB8Dk84tdNc0FOy9r8GBmyjQVdA8=;
 b=Q7hYzDOqmFQgr2o5vfv3ah4224aPx0Boo4OGSRqtZgDrSHw/aFpMMhcGysrZS+Gu7DQzNsszC3O++Bpt4hRCaXFTRvdrte0m+ouHBNZkpTqAeQ/dhS0pIsUnu/QmnKTW+aw3NtHEZE1f7gw+bQDxdt/15x4ZSq7K4JUs+vwIeZfb+QdYPgUQx8F12P8W1p5lv3JNv+JVtCxs4YwAKKVf4QCKkyosgyOsmsxbWCH06G4DEWm3k7jjEgP2FDFk9pPoduUTVQLrPZc5J8a2WQW0sUgy4gjqR4/hyPj2v8/eRbo/GgfvwNyll1tlsCHTp6Hje7c7EqsFnNQuKcJo8y9ZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1323.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.29; Fri, 22 Aug
 2025 02:13:35 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 02:13:34 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 3/3] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Topic: [RFC 3/3] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Thread-Index: AQHcEoPTVFgiZ2cNsUahDKGHWBxu8bRtJRKAgADI63A=
Date: Fri, 22 Aug 2025 02:13:34 +0000
Message-ID:
 <ZQ2PR01MB1307E45973922C6C3BC31A7FE63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-4-hal.feng@starfivetech.com>
 <c1396997-fa92-47cd-9bc6-8dcb67e87eb8@iscas.ac.cn>
In-Reply-To: <c1396997-fa92-47cd-9bc6-8dcb67e87eb8@iscas.ac.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1323:EE_
x-ms-office365-filtering-correlation-id: 7d8027b7-fda7-4560-0d71-08dde1217fa2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 k1ODaHAaXu3N+2Qw6s74jruJaGXkQb9hFufsNuNgkPHbNAn11GvDTEWlyBO4+gc5bX0oqxtz1Kl1LjN0LuSMLQiNQGN82sUbZ8nZzMSnqFDIuhkjekEd6RuRyLU2+6Ctv6Rll2QnUQEQp5bnzC3NCiiVFQRFvwrhWqpwZCy/psZT7MI5c+gC8RiOuBM4awDs065J0l04YT9EfpDzBa3vtkz6ca5pBSXRZvDmsKjajFLZRidy3yciyRsHt2uQz047HO0Fqqdfzg1m4MQ3rLL3SABM93RB0QZ5Y3RpI9CZ1SdGhPqTmlA1bK+6aFAKXqyTycrAhMy4naHQgQ9thPtr2nXqcD+XDvCIjEUwwNb2m8122ZP8qsS/mCRjQ+DWGm3VvHhf5E9yBUMS5utv2ouQG0ErbulNOp7kwNtnltSBA/TiqzsG+ltQt/Kn84cdp7xl3haunkk+GI5KkqRusFTFVDhFL6XLlIYpTCN4U3/BULpnFle6VcnrLmKiSOG2XbcCOHym3VAQ9LtmqEOVOuRA4IFSzbAFa/EXghcx1gBKSyI9yMwNaHa0X6Fql6sJDJ1jjAm0qOeWAKOj+bOqMWhnVNctSqmkw9iXcb9EZR79rKI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlRhejdXbVpNam1qWmhScXlqMjdBRm5NMVp1bTZKUmtUaWY4SVlBUTkzMnVQ?=
 =?utf-8?B?bW1NUGxBa25FNVZkSWNjaFQ2L1RadmNqOWhRd2JBQklYb2pmTU40OVMvNFFr?=
 =?utf-8?B?ZlhZUWl1T09FVmxTTFdxNERiMnBNcFE2Nk9oNnk2bnFsb20rT3pVaVNLVlhE?=
 =?utf-8?B?VjJNS3kyUWxwMnhJU09zOURuc3dvNXBNaTRaZEhRandpZUVDOGtTcW5JYVNL?=
 =?utf-8?B?ckIwYkR3NG9vbmsrNGV6MDRNbzJRcEpqWG5jOVhZWlBBM0RWZ094VmpvcEYx?=
 =?utf-8?B?SU9WbTMwRTZzeFdvdW9CbWpyWWFXY2oxY21jRzBIMTdUcUNOSTllZDdYenVS?=
 =?utf-8?B?V2YzTWt1bkJZNmtLSlM5UFNtbEZGM3RQeTBaWW84TThpSGcxV3RZTXJNV1FD?=
 =?utf-8?B?aTZFZDBieXF2UkpXczMreWNuekFqLytKZVo0SHJwZm5UNXl0WDBjY0ovTk96?=
 =?utf-8?B?Q3Z6c1Zwb3ZKZ1V3bUNORU1nRElDM2Z1Z3JLVTYzNnlKMVEzNzMzeGl6UXl2?=
 =?utf-8?B?bVFzTERJanc1ajZJU2NkdllpUmtqY3duTTlaUFpTNy9POTNLemRWSXhyaGFF?=
 =?utf-8?B?TmwzUkhSNndlalhmOHZ3dXZweTFpaThYbjdydFIzWklQYWtaVTlVUlpicUo3?=
 =?utf-8?B?empSdm9VNWM1M2xLMzNaOFBUV1pZNlBya3dMTzVIbDBpSDBHWi83NUVUWCtC?=
 =?utf-8?B?TS9aQ0hxMmdSREhITHZBSjBOTkhBakJ5LzM1SWo5RHJ4aUpUZXBQb1dTNkx6?=
 =?utf-8?B?dkJzcktncks5clRTeFVZR2d3MnFYWUJucVQ1L2NJYWxqN1RrTS9xZ3Z6Wm85?=
 =?utf-8?B?cFJXQy9GeEoxMFlUL1NacEtBckpka2ZJZWRHWENSajdFckdBd1BvTndoVGlr?=
 =?utf-8?B?UW9TeElXYXFUWXQ2clF4YXYyOTZHeWlhSjc5YkR3UEZ4TGgyT3RDcGp1bTNL?=
 =?utf-8?B?RS9FbFZjUEdvWkRvdWNXVU95Q05XUkhzZGxnL1ByWnRId0dzbDFhMlkzMzl0?=
 =?utf-8?B?QTdSTjlVZVRMNWU5Um8yU0ZuN0hRb2RUZWJIUkJEM2tRejA1NktUTXVOQi9I?=
 =?utf-8?B?SG1BZ1VQY0hsNk10MmwwUTNMbkt2dy84QTBBQ1M2SklXM2VRb243UStmcjNz?=
 =?utf-8?B?QzRVZzFTenFMa1oxT3VrMkIwQUFzTUFvd1dyLzZZNC93YzB4ai9BTWFyVldi?=
 =?utf-8?B?VzlSbG01azhHelRmMHZZNFl2Mk4wMC9xVFQ1WWJmblloUDkyT0FTcy9JTWVo?=
 =?utf-8?B?WlEzVDl4aFZ6OGNtRUdkc2hlZFpETjRxY2QyS3pCL2lwUXJKcUkwM09KRW9J?=
 =?utf-8?B?cG02S29TSGt1UCtxUFZCVGNMOFIvMTBZMk5rOHZINHNFUEx3SVpUd2l1b05v?=
 =?utf-8?B?MHRrRGRrWTNmcDJ3OFpISUlPSlFtSDVKV1FvZTJMU0dVY2JwSUROV2lTdDlp?=
 =?utf-8?B?cjVMWmlPQVErd21HazR3RmxOaUkzY0VUV2NjMXZ6L0dxTjFRN2h2VVRKbTJF?=
 =?utf-8?B?V1BKbmQ5WjgvWVUrS09Jc3dXY2l0Y1dJeCtpZEs2ZWJhakxkODlHanV3Uk9N?=
 =?utf-8?B?WjVxeU9rdmtFQTJqMG9pUHJnR0grcDNSdEgxODVBWlFrV2pxUk5IZ01tZmxs?=
 =?utf-8?B?c0ZTZG01L0NhRUExdkRTYzNnTHFLcWFjblZYUG9QdnNreEFXdUtrVkZFL2NM?=
 =?utf-8?B?dW43SXBvNFQ4UVZUTS9raHpGWWk5YlRnbGFWcC9TSVdyTUVzVEJnMXpZbDg1?=
 =?utf-8?B?MHdHQmJWWVFaWVh4K2JlbFZ2WGJITHRGd3VaUmg0Q0hseEthNmhPTlJ5aHFN?=
 =?utf-8?B?UmNyZHdCbE5rZHNTR2JWdWJmQ2R2V3VlOXlWRE10YjlKZ0FlWW82NUsrOXlj?=
 =?utf-8?B?WGtFTmRUT3lER3NwQ3ZOQXZaVU1OR0hRU3dGaGNPdlN4dHRRek5hMUs4ck9H?=
 =?utf-8?B?bkFlNGdMdUkvcUxJT0U3Vzh3NlpVa01ROUxGUmlEVnZ3aVlDYlFFbzl4bWk2?=
 =?utf-8?B?aUtpRm9rODIvYm8xeER6VXVIMThBUlFnNGVOeDJOTnhVRFBTVTNTZllzc0xo?=
 =?utf-8?B?R2EvWC96cUhScWJDV3g4cTJpaHJuVGxQMlNjN2JTQkFJK29nNnBRNENTMTVn?=
 =?utf-8?B?cnhod1pMZ0dqQTZmOWI1d0NIditXZ2dYOEd1SU1BVm9Ta2w0NVZoRzlrSzBN?=
 =?utf-8?B?cnc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8027b7-fda7-4560-0d71-08dde1217fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 02:13:34.7715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPcFiY+rlmdrTSMWykSUzViZfjupmnQvo3ysl7obSpaJQ0WItS8mRT90ZhRRQp0gzHiDrGHpd/CBrxJx41+/FeGbSamCPJng39/OEH72ilA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1323

PiBPbiAyMS4wOC4yNSAyMjowOCwgVml2aWFuIFdhbmcgd3JvdGU6DQo+IE9uIDgvMjEvMjUgMTg6
MDksIEhhbCBGZW5nIHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290
L2R0cy9zdGFyZml2ZS9qaDcxMTBzLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi1saXRlLg0KPiA+ICsr
KyBkdHMNCj4gPiBAQCAtMCwwICsxLDE1MiBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMCBPUiBNSVQNCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI1
IFN0YXJGaXZlIFRlY2hub2xvZ3kgQ28uLCBMdGQuDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAy
NSBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4gICovDQo+ID4gKw0KPiA+ICsv
ZHRzLXYxLzsNCj4gPiArI2luY2x1ZGUgImpoNzExMC1jb21tb24uZHRzaSINCj4gPiArDQo+ID4g
Ky8gew0KPiA+ICsJbW9kZWwgPSAiU3RhckZpdmUgVmlzaW9uRml2ZSAyIExpdGUiOw0KPiA+ICsJ
Y29tcGF0aWJsZSA9ICJzdGFyZml2ZSx2aXNpb25maXZlLTItbGl0ZSIsICJzdGFyZml2ZSxqaDcx
MTBzIjsgfTsNCj4gDQo+IE1pZ2h0IG5lZWQgdG8gYWRkIHN0YXJmaXZlLGpoNzExMHMgdG86DQo+
IA0KPiAgIGRyaXZlcnMvY3B1ZnJlcS9jcHVmcmVxLWR0LXBsYXRkZXYuYw0KPiANCj4gU28gdGhh
dCBpdCBjYW4gdXNlIHRoZSBvcHAgc3R1ZmYgaGVyZToNCg0KR29vZCBjYXRjaC4gVGhhbmtzIGZv
ciB5b3VyIHJldmlldy4NCg0KQmVzdCByZWdhcmRzLA0KSGFsDQoNCj4gDQo+ID4gKw0KPiA+ICsm
Y3B1X29wcCB7DQo+ID4gKwlvcHAtMzEyNTAwMDAwIHsNCj4gPiArCQlvcHAtaHogPSAvYml0cy8g
NjQgPDMxMjUwMDAwMD47DQo+ID4gKwkJb3BwLW1pY3Jvdm9sdCA9IDw4MDAwMDA+Ow0KPiA+ICsJ
fTsNCj4gPiArCW9wcC00MTcwMDAwMDAgew0KPiA+ICsJCW9wcC1oeiA9IC9iaXRzLyA2NCA8NDE3
MDAwMDAwPjsNCj4gPiArCQlvcHAtbWljcm92b2x0ID0gPDgwMDAwMD47DQo+ID4gKwl9Ow0KPiA+
ICsJb3BwLTYyNTAwMDAwMCB7DQo+ID4gKwkJb3BwLWh6ID0gL2JpdHMvIDY0IDw2MjUwMDAwMDA+
Ow0KPiA+ICsJCW9wcC1taWNyb3ZvbHQgPSA8ODAwMDAwPjsNCj4gPiArCX07DQo+ID4gKwlvcHAt
MTI1MDAwMDAwMCB7DQo+ID4gKwkJb3BwLWh6ID0gL2JpdHMvIDY0IDwxMjUwMDAwMDAwPjsNCj4g
PiArCQlvcHAtbWljcm92b2x0ID0gPDEwMDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiAr
PiBbLi4uXQ0KDQo=

