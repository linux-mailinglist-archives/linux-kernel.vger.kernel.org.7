Return-Path: <linux-kernel+bounces-781577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FCB31447
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCECB015CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C702F3600;
	Fri, 22 Aug 2025 09:41:55 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2137.outbound.protection.partner.outlook.cn [139.219.146.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E127EFE1;
	Fri, 22 Aug 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855714; cv=fail; b=lBChLtBK4mRJuwLyaxAhaZbWRyfPB0CIyblZKgfwDRNbEDBqiKxVp4ET8kPpuNa3j2ykbu5//gmMyvH0zw80f01u3KJpYcAnVWlWF4G9PZXozo+X1Yi1e7otweL/cshALxDMeThpJLU4jRD3+2O501ry+ld9i8XgOXsthay9UQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855714; c=relaxed/simple;
	bh=I3BZ3FYu1NTaUkbd7H65SQUoyEbgLo+dvAFNAKYGDHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrgF8ZDTD5SSs1fw2XA6XSwcErx3wt0sU2Gta0rrEOujFso1i+SMLaLm376Fga4Sp7Zf372NmKCzk/imm16pb5CTZmkIXk3l0q8nS5qtQnmB+mIXYsAsKAX1rNbxgmOOZ7sVOHvcEZEl9UX+MshoxstuOn1aUyWvubzHjos5/CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Liy7u+d25CDtJeJFH/E3rtX3Lga7QpsAXxzWMW0dziFQVMB8gHKoBYRf+L6of4oTSZwhvi3N600NRtHkQNrl+/b8vAG45YsZB+BpRWEiL8c9Yjd9pc4bXuPgguKy4eO26Az/ocqeXluYbXugq189PC5M8cfcbrPQQYt1B347HkAQpWaJj7HLqa8ZFxXOAfPxA+lWLwWp14u79860ZrVtpmU+wGC5Gr3z7fCVdICoEx1mkYiHZDfvAU42xHaZmXD5BCRgx+bot5GcINSG66mCgpUpUFdJPjhrXCpz8Nz8zDHuiDJPDbErG+sjM3TUsqwZOardmKFk2vgF3tNkJYeDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3BZ3FYu1NTaUkbd7H65SQUoyEbgLo+dvAFNAKYGDHk=;
 b=gVdxLiKkylaFr7jJoNfEA41FFY5sKAq7oUAXJC6UlUsYGHEB5ORHl6vXODdN/pgyWH2KUABoQmg6IwrrUvptTj7Qru9X52r8CKQvmf90Zhovz+/jJtxQJFxxcP3Q8fL2h5jPLA5mqO+9+hdl5HSG8twXv7h/nJ1gNllaNlUvfl67w7uAyQ3Je2OjLTAZl5QijfLZ5MzzsJx3/S9prZz0IcDoZJreC6RzFdvqLeHVEOtEe/AbzdUmJvRkrhBz6gjNsVE7PKbed+AHifgIz/8rG/N98U6PbLQDDliJb+K1gr73mVBd8gDjP83SkoU/q54vQNJkEH1c30c7vzKssP4xeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1290.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.29; Fri, 22 Aug
 2025 09:27:05 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9031.026; Fri, 22 Aug 2025
 09:27:05 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: E Shattow <e@freeshell.de>, Conor Dooley <conor@kernel.org>, Emil Renner
 Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Topic: [PATCH v2 3/3] riscv: dts: starfive: jh7110: bootph-pre-ram
 hinting needed by boot loader
Thread-Index: AQHcDbfjrd5j87sKqkyiqAyP5B2/v7Rn7XHQgAMB3ICAA3+E4A==
Date: Fri, 22 Aug 2025 09:27:05 +0000
Message-ID:
 <ZQ2PR01MB1307FE7D4D538EEBB9A578C7E63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20250815073739.79241-1-e@freeshell.de>
 <20250815073739.79241-4-e@freeshell.de>
 <ZQ2PR01MB1307CE398A5993B9E5B93357E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <4b516172-bd75-432a-9c96-f02fbfb68c16@freeshell.de>
In-Reply-To: <4b516172-bd75-432a-9c96-f02fbfb68c16@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1290:EE_
x-ms-office365-filtering-correlation-id: a5d49516-4c91-4241-90d3-08dde15e0f41
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|41320700013|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 LswvvehgeMwp2Xibk+FY2N5oKt3/hHq1jh98YNr2VWxf6VLi+2k8r4HezJfeGxh8nuoyemjI062O44E3i0FpVyxM+91hvWTv7v10yurcoxpmJi4kDhZYW/U6hyH2V+uW0DBiC/pomhrGSK4F1PM7G0WopklffPrLTomfwEwtQDM4nRSPdTZotsmid/isCje4C9UYEs3/TZ/wnPMzeoOEM8HYgkBBMPeZGaqGYg+i8qHxj3Wj2QFyW36EOgcZ7x3ljfH+SA0gjv5qwTBJ0PMUlFJkLMmvnAGVDzw64nvfxTpFM+600dndlJKfcTe6ExW3Ij6QR9D18shbi4wfWKfb9xe2n6uc6CxwDum5/Nr/Ag38hnapibcpZCrrRvy18R8XHUb9F//f+UGV2C1cG5px51RtbUfSVwj2PiIKZG5zFO3A+yhCbDY9pWbhdYpM406aA/Gzq9ZTpggzHNLHnJwNs+grv8qdj48hJ0KzedFMshyn61sX3UkWp+rW2hZiLlHwgbljEQEEudjnJ2Ozcj+R0t+/ocFft1dYNri1kYC7VcJlIgnZpOHvMjqgRzZyrCMW/OVrX12MCAUfctWbg7p9/KBmGos1qPNY1DJ5AKa5CyU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y205TEpvdWZnSDZHSEF6aGFXL3B2cVczU3ZXSmdLRHpiY2V0RlhFZ1lPN2pP?=
 =?utf-8?B?MkF1SmdMVi9UQ3k3c0Q5ZXNxZnVWRWMrL1B4enU0RjJPbG1jWWdKY2Y1bmdJ?=
 =?utf-8?B?WkkwVmo0VTM4cG5QdVFlSkx3cW02dHpmQVpGeDExLzczMS92TU1DS0hFTkN1?=
 =?utf-8?B?VDVFVjc2Zld4M2NjSzhmcStnWkt3M09Eem1NTVJYMXJ0NXE0Y1VRb0dMK2VU?=
 =?utf-8?B?aUNRb3B4SjQvV2tvNGVhdzNIRXBndS9OUFc3T29ha2J4amJYa0V3d0cvVzF6?=
 =?utf-8?B?VzhJcFExbXZoL0tOQkIxbXlERUZHVzJTaWJQN3JrcUUxSi9zbWJCUkMzVUkv?=
 =?utf-8?B?TVRuU3dQZUxTSVk3TjFGSDZnNkY2S2RwVXU2UnF4SzNRWC9Va01UVlhyU1Zh?=
 =?utf-8?B?TUFtWC9lZ3V0YUJlazVrQmIzRUVxR1ZHVDdmNWJyeC92S3ZobnY1RDc2SGxm?=
 =?utf-8?B?S2RNU0xieGJjVkRzcDc2TkI2eG1VT3RtZndsOE1oN1BuOTZkWU5KdlVEUTZE?=
 =?utf-8?B?eVpPT3VwdGlvWE1rM0lGVUdLOGFoYkJpMm1RTmNwSkhOU1dteGFKdk1LSmVn?=
 =?utf-8?B?L2duUGVTMmFvS0pYa0NwUE85SXFCYWtXdXk3Uy9ia3hsN3BvVHhUQVhVQlRI?=
 =?utf-8?B?SGFjR2pqbHI1aGFtaFdFTGFieGNTREt3WFJSMlpGQ0VQaG81UENibnlBeUJG?=
 =?utf-8?B?QXg0THp2M0o0S0FoOWRvUkdjbms5RzBIQmFWMk52U2hXYjVVbFVsUTh1L2FZ?=
 =?utf-8?B?YTYxSVB1L0kva3dYaVVkWkRadkY2QWFFckY1MTV6aXJhenY0cHhYU1Y0VExH?=
 =?utf-8?B?MHRicmNFTkg0OHVZTGVCVVdXeUlmVFRkdDVVNjRDOHhnYTRjVHNZUlhNVjh2?=
 =?utf-8?B?ZHVBZW0rNFUwd2t0VitYWGJqUUl2QlFaUXVVUHVNR3pESlRncTlvSUk3c0JJ?=
 =?utf-8?B?UjZENVZxOHVqa1IrUU1SZENEWlMzVURrR1JLZE9zWmhuUndnK3pxYm1IK0h0?=
 =?utf-8?B?dmdtMXJRc1VKMVpqcm1VNGF0NHNXSm5rUXhEUDRYZjMvYzgzei9OTENDc1FE?=
 =?utf-8?B?TWZEdGRoNmdVb2E5UlN0WFBEQldwNFZvZlRTZzlybmpMTVdCTGk5TUFOZGVB?=
 =?utf-8?B?UjFLUlRMdFFXWUxZY3Z2MElXS3JjWFFRc0JvOHVGd2xZMmdoZVJLTmFjVEJ5?=
 =?utf-8?B?VGpMZFMwYTZjeEI3MXZ1SnJLakJoZDFab1Z5OWRZMkI3aWtqWlE4U2oyT1Rk?=
 =?utf-8?B?S2QxSy9rMEw2TERwMUFlV0N1L3g2UXBSczJnbkdpcFJIZDJZT1dtUzUwSWVJ?=
 =?utf-8?B?OUF1dFZzVDFjYmFyOFdydk05VmJxNUd6MTVVMmZSVXhrdU1hdmxxODViQjBS?=
 =?utf-8?B?N1VjNlZVNnR2bmVDQ2lYR3JTOFc4UHV4REp2UTZVSUtVYnhlZFhXbWJFSE5h?=
 =?utf-8?B?WWRTWXREalJhbVhCZ0w3d2pYQnN6QzI4TnFNRllkOXdteEFkODFnRWR1SzY5?=
 =?utf-8?B?NUMvU1ZKdkNGSStxSEIrU3dsTFh1cE16NVpBNndPR3YrUGs5UVJkdEtOaXZP?=
 =?utf-8?B?VzRHMys3YUI3a21KbzlhVCttZWxIaHBXdmFsd0lOYmdWaFFXUWt6WTkxYWpR?=
 =?utf-8?B?SzJMcmVBRDhuNkZQVGRqYVZDWUVTbURZbnB3b2xFMjh1dUU4Um1uYjVCRUg2?=
 =?utf-8?B?clRyUTFXZG84VThnUDlWL3FteitFVXpKekJDUmJNdGwvQU15RFEzbUxrVm9U?=
 =?utf-8?B?SjdyRE1wMGtLMzAybFp2SFd6alFBRHVSSkZhNDh0S0NpaXpiTFZ1MzRFZk9n?=
 =?utf-8?B?TWtId1RjdGJITFl4UnN3Y3Q4b3NzU0dwTmR0UGxWNktCOFo4cklRdTRjR09K?=
 =?utf-8?B?cEdSWHBTNVA2VlFuZnhSZUpGeVQ1K0lkbHNlZGN6elF0WFFQZ3J1aVF0RHA3?=
 =?utf-8?B?L0Z6czYvMEFkbzFoRW1DaGM4TFhJTzE5UkUxRzdTQkgxZjU5T3NuNWwwbXo1?=
 =?utf-8?B?OUNsOXZFQTVGdnhxNmIrbXpUTTQ1Y3ZuUkxnRnEzNnU1azVnK2xTczdYdlFa?=
 =?utf-8?B?RVdDbDIvWjVRb2Z4R0FVTUJSTWZaaHRlVVgrVkdMNndQbjRuN3ljNmRIL3dR?=
 =?utf-8?B?bWJuUTJoK3dkUXVnTjdWM0ozWWF5eDVNSGd5cmlMNmhlMzk5WGtXZVQyVm94?=
 =?utf-8?B?Smc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d49516-4c91-4241-90d3-08dde15e0f41
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:27:05.5574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ja3KLC5FIS0T7xQKYolzBF5+JfUR4C7u/VBu7gOPeklxR7xSjw1X58qkEU9DAURjPtZaFfvMzc9EDzWtXehT7MDsh6Baw6ChbjyS7gUX2yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1290

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRSBTaGF0dG93IDxlQGZy
ZWVzaGVsbC5kZT4NCj4gU2VudDogMjAyNeW5tDjmnIgyMOaXpSAxMTo0OQ0KPiBUbzogSGFsIEZl
bmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+OyBDb25vciBEb29sZXkgPGNvbm9yQGtlcm5l
bC5vcmc+Ow0KPiBFbWlsIFJlbm5lciBCZXJ0aGluZyA8a2VybmVsQGVzbWlsLmRrPjsgUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemsrZHRA
a2VybmVsLm9yZz47IFBhdWwgV2FsbXNsZXkNCj4gPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47
IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJlcnQNCj4gT3UgPGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdT47IEFsZXhhbmRyZSBHaGl0aSA8YWxleEBnaGl0aS5mcj4NCj4gQ2M6
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDMvM10gcmlzY3Y6IGR0czogc3RhcmZpdmU6IGpoNzExMDogYm9vdHBoLXByZS1yYW0N
Cj4gaGludGluZyBuZWVkZWQgYnkgYm9vdCBsb2FkZXINCj4gDQo+IA0KPiANCj4gT24gOC8xNy8y
NSAyMzowNSwgSGFsIEZlbmcgd3JvdGU6DQo+ID4+IE9uIDE1LjA4LjI1IDE1OjM3LCBFIFNoYXR0
b3cgd3JvdGU6DQo+ID4+IEFkZCBib290cGgtcHJlLXJhbSBoaW50aW5nIHRvIGpoNzExMC5kdHNp
Og0KPiA+PiAgIC0gQ1BVIGludGVycnVwdCBjb250cm9sbGVyKHMpDQo+ID4+ICAgLSBjb3JlIGxv
Y2FsIGludGVycnVwdCB0aW1lcg0KPiA+PiAgIC0gRERSIG1lbW9yeSBjb250cm9sbGVyDQo+ID4+
ICAgLSBvc2NpbGxhdG9yDQo+ID4+ICAgLSBzeXNjcmcgY2xvY2stY29udHJvbGxlcg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBFIFNoYXR0b3cgPGVAZnJlZXNoZWxsLmRlPg0KPiA+PiAtLS0N
Cj4gPj4gIGFyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kgfCA5ICsrKysr
KysrKw0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiA+
PiBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kNCj4gPj4gaW5kZXgg
MTRkZjNkMDYyYTQ1Li44ODRhMzUyNmNiMGYgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvcmlzY3Yv
Ym9vdC9kdHMvc3RhcmZpdmUvamg3MTEwLmR0c2kNCj4gPj4gKysrIGIvYXJjaC9yaXNjdi9ib290
L2R0cy9zdGFyZml2ZS9qaDcxMTAuZHRzaQ0KPiA+PiBAQCAtMzUsNiArMzUsNyBAQCBTN18wOiBj
cHVAMCB7DQo+ID4+DQo+ID4+ICAJCQljcHUwX2ludGM6IGludGVycnVwdC1jb250cm9sbGVyIHsN
Cj4gPj4gIAkJCQljb21wYXRpYmxlID0gInJpc2N2LGNwdS1pbnRjIjsNCj4gPj4gKwkJCQlib290
cGgtcHJlLXJhbTsNCj4gPj4gIAkJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4gPj4gIAkJCQkj
aW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+PiAgCQkJfTsNCj4gPj4gQEAgLTY4LDYgKzY5LDcg
QEAgVTc0XzE6IGNwdUAxIHsNCj4gPj4NCj4gPj4gIAkJCWNwdTFfaW50YzogaW50ZXJydXB0LWNv
bnRyb2xsZXIgew0KPiA+PiAgCQkJCWNvbXBhdGlibGUgPSAicmlzY3YsY3B1LWludGMiOw0KPiA+
PiArCQkJCWJvb3RwaC1wcmUtcmFtOw0KPiA+PiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0K
PiA+PiAgCQkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4+ICAJCQl9Ow0KPiA+PiBAQCAt
MTAxLDYgKzEwMyw3IEBAIFU3NF8yOiBjcHVAMiB7DQo+ID4+DQo+ID4+ICAJCQljcHUyX2ludGM6
IGludGVycnVwdC1jb250cm9sbGVyIHsNCj4gPj4gIAkJCQljb21wYXRpYmxlID0gInJpc2N2LGNw
dS1pbnRjIjsNCj4gPj4gKwkJCQlib290cGgtcHJlLXJhbTsNCj4gPj4gIAkJCQlpbnRlcnJ1cHQt
Y29udHJvbGxlcjsNCj4gPj4gIAkJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+PiAgCQkJ
fTsNCj4gPj4gQEAgLTEzNCw2ICsxMzcsNyBAQCBVNzRfMzogY3B1QDMgew0KPiA+Pg0KPiA+PiAg
CQkJY3B1M19pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxlciB7DQo+ID4+ICAJCQkJY29tcGF0aWJs
ZSA9ICJyaXNjdixjcHUtaW50YyI7DQo+ID4+ICsJCQkJYm9vdHBoLXByZS1yYW07DQo+ID4+ICAJ
CQkJaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+ID4+ICAJCQkJI2ludGVycnVwdC1jZWxscyA9IDwx
PjsNCj4gPj4gIAkJCX07DQo+ID4+IEBAIC0xNjcsNiArMTcxLDcgQEAgVTc0XzQ6IGNwdUA0IHsN
Cj4gPj4NCj4gPj4gIAkJCWNwdTRfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgew0KPiA+PiAg
CQkJCWNvbXBhdGlibGUgPSAicmlzY3YsY3B1LWludGMiOw0KPiA+PiArCQkJCWJvb3RwaC1wcmUt
cmFtOw0KPiA+PiAgCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+PiAgCQkJCSNpbnRlcnJ1
cHQtY2VsbHMgPSA8MT47DQo+ID4+ICAJCQl9Ow0KPiA+PiBAQCAtMzIxLDYgKzMyNiw3IEBAIG1j
bGtfZXh0OiBtY2xrLWV4dC1jbG9jayB7DQo+ID4+DQo+ID4+ICAJb3NjOiBvc2NpbGxhdG9yIHsN
Cj4gPj4gIAkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4+ICsJCWJvb3RwaC1wcmUt
cmFtOw0KPiA+PiAgCQljbG9jay1vdXRwdXQtbmFtZXMgPSAib3NjIjsNCj4gPj4gIAkJI2Nsb2Nr
LWNlbGxzID0gPDA+Ow0KPiA+PiAgCX07DQo+ID4+IEBAIC0zNTQsNiArMzYwLDcgQEAgc29jIHsN
Cj4gPj4gIAkJY2xpbnQ6IHRpbWVyQDIwMDAwMDAgew0KPiA+PiAgCQkJY29tcGF0aWJsZSA9ICJz
dGFyZml2ZSxqaDcxMTAtY2xpbnQiLCAic2lmaXZlLGNsaW50MCI7DQo+ID4+ICAJCQlyZWcgPSA8
MHgwIDB4MjAwMDAwMCAweDAgMHgxMDAwMD47DQo+ID4+ICsJCQlib290cGgtcHJlLXJhbTsNCj4g
Pj4gIAkJCWludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmNwdTBfaW50YyAzPiwgPCZjcHUwX2ludGMN
Cj4gPj4gNz4sDQo+ID4+ICAJCQkJCSAgICAgIDwmY3B1MV9pbnRjIDM+LCA8JmNwdTFfaW50YyA3
PiwNCj4gPj4gIAkJCQkJICAgICAgPCZjcHUyX2ludGMgMz4sIDwmY3B1Ml9pbnRjIDc+LA0KPiBA
QCAtMzc2LDYgKzM4Myw3IEBADQo+ID4+IG1lbW9yeS1jb250cm9sbGVyQDE1NzAwMDAwIHsNCj4g
Pj4gIAkJCWNvbXBhdGlibGUgPSAic3RhcmZpdmUsamg3MTEwLWRtYyI7DQo+ID4+ICAJCQlyZWcg
PSA8MHgwIDB4MTU3MDAwMDAgMHgwIDB4MTAwMDA+LA0KPiA+PiAgCQkJICAgICAgPDB4MCAweDEz
MDAwMDAwIDB4MCAweDEwMDAwPjsNCj4gPj4gKwkJCWJvb3RwaC1wcmUtcmFtOw0KPiA+PiAgCQkJ
Y2xvY2tzID0gPCZzeXNjcmcgSkg3MTEwX1BMTENMS19QTEwxX09VVD47DQo+ID4+ICAJCQljbG9j
ay1uYW1lcyA9ICJwbGwxX291dCI7DQo+ID4+ICAJCQlyZXNldHMgPSA8JnN5c2NyZyBKSDcxMTBf
U1lTUlNUX0REUl9BWEk+LCBAQCAtDQo+ID4+IDg5Miw2ICs5MDAsNyBAQCBxc3BpOiBzcGlAMTMw
MTAwMDAgew0KPiA+PiAgCQlzeXNjcmc6IGNsb2NrLWNvbnRyb2xsZXJAMTMwMjAwMDAgew0KPiA+
PiAgCQkJY29tcGF0aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtc3lzY3JnIjsNCj4gPj4gIAkJCXJl
ZyA9IDwweDAgMHgxMzAyMDAwMCAweDAgMHgxMDAwMD47DQo+ID4+ICsJCQlib290cGgtcHJlLXJh
bTsNCj4gPj4gIAkJCWNsb2NrcyA9IDwmb3NjPiwgPCZnbWFjMV9ybWlpX3JlZmluPiwNCj4gPj4g
IAkJCQkgPCZnbWFjMV9yZ21paV9yeGluPiwNCj4gPj4gIAkJCQkgPCZpMnN0eF9iY2xrX2V4dD4s
IDwmaTJzdHhfbHJja19leHQ+LA0KPiA+DQo+ID4gcGxsY2xrIGFsc28gbmVlZHMgdG8gYWRkIGJv
b3RwaC1wcmUtcmFtLiBCZWNhdXNlIGl0IGlzIHRoZSBkZXBlbmRlbmN5IG9mDQo+IHN5c2NyZy4N
Cj4gPg0KPiA+IAkJcGxsY2xrOiBjbG9jay1jb250cm9sbGVyIHsNCj4gPiAJCQljb21wYXRpYmxl
ID0gInN0YXJmaXZlLGpoNzExMC1wbGwiOw0KPiA+ICsJCQlib290cGgtcHJlLXJhbTsNCj4gPiAJ
CQljbG9ja3MgPSA8Jm9zYz47DQo+ID4gCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+IAkJfTsN
Cj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBIYWwNCj4gDQo+IFdoYXQgdXNlcnMgYXJlIHRo
ZXJlIGZvciAncGxsY2xrJyBhdCBVLUJvb3QgU1BMIHBoYXNlPyBUaGVyZSBkb2VzIG5vdCBzZWVt
IHRvDQo+IGJlIGFueSBkaWZmZXJlbmNlIGluIHRlc3RpbmcgVS1Cb290IGFuZCBMaW51eCB3aXRo
IG9yIHdpdGhvdXQgdGhpcyBoaW50IGZvcg0KPiAncGxsY2xrJy4NCg0KSSBzZWUgY29tbWl0IDhi
M2YyZWI3ZDg5MTIyMDRiZGEyZDkxNGI4YTlhMWNlMWMzMWJiNWMgYWRkaW5nIHRoaXMgbGluZSB0
bw0Kc29sdmUgc29tZSBwcm9ibGVtcy4NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjUwMzMwMTYyNDIxLjIzODQ4My0xLWhlaW5yaWNoLnNjaHVjaGFyZHRAY2Fub25pY2FsLmNvbS8N
Cg0KQmVzdCByZWdhcmRzLA0KSGFsDQo=

