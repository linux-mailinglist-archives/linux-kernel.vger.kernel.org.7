Return-Path: <linux-kernel+bounces-892419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA5C450C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541C33AF489
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B62E8B95;
	Mon, 10 Nov 2025 05:56:14 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023115.outbound.protection.outlook.com [52.101.127.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFF25C6E2;
	Mon, 10 Nov 2025 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762754173; cv=fail; b=Nv+1iSVmHnD5GnixEJkolGDXOFw2PZ6YzN34A7VtKV437ycT9sLSovUs+EBDp93Qhc1QbABfpURuVijkAmf3Hwbl/Zl8V6jBPrB1pd1x1z48Qp8tzkYkVkXRNOkO0x/R0PFlWGWLOJvZWsjcXIE5WZns7UxvJhwlfrD7/sVhd2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762754173; c=relaxed/simple;
	bh=EdO5VDMvlr4itgEoTm6hsom6BjH3bra3AZR2WwnMeYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQCjPkO/QDQEOGEOYfvpDZ7vI8Vzc3d96W9uY1SreHrboBfb7o4keRwlYhg7ZaQ6ptFyBeKqRvdMkHr2s4GIuQdqZTfEsqnEBwMriMVEgOhrls89baq9Q0q3j1vFpUUOXUHm3bIr3uoG5A/07KQZwiiL4WYUBrAT0dQKIOkw304=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4W4kfNE/SInT6iqqQhJ2kw6uJdoQTMtIXPtylHewUO/eHXGDFHeCHg86yJKYpo457i9eKM2T74T+NsfjB2dVfOhfB1HaxBPgg4YEsx00IiDtPHfWRJBYyyg1oRrSE+NGTTGDaC2tcfZS5/kgNu7KrCb2x9jeYVj8YnctHlQXd573Z+InFk1WtDQP8xecuteFn1NVO+t0nfvZDzOT8wZulXgaRjac2OF2zgzBJKjo4EuDVo51AxN6l6q+dTN380R97YrXLfGvnbkyt9MBDEcm8waDPaZAEPFX1bV/ibKAz4FxL3utK3Hi9FSBTwyZXD0e6cQYKeEELHICX6Wi4tkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdO5VDMvlr4itgEoTm6hsom6BjH3bra3AZR2WwnMeYk=;
 b=xiu+xksc99ynvWBSIr9bBVsTZh/yjQwU7BTuXAjO+f/pX6rUCo0llnZ8hHZLFdmN9OsbzV2XX+jE9jjbLpO7qelSytsHnrshF29B3cper5bPskCkjOWP6OEL1srajn/k7iV7zBHr00sroP8p+KkaXAZgG5LB/FOfBa8j+LmKtAV8yUG2Jdduvx6zx/rf1A/7tuuKupg8rPQiI0/fhSTaw2pT4n0cqO840dr2FYZ32vKqsz/hW4kZrl404bdjGa+ZZg8b5pApu+ki0Y18WeI7hGmU2BXvvuTcD5tXpamqzc1vDTN+uixGwz0lo4FNSnGnwsKOg8t2D8w21NCreFVPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from TYUPR06MB5876.apcprd06.prod.outlook.com (2603:1096:400:35e::5)
 by SEYPR06MB6707.apcprd06.prod.outlook.com (2603:1096:101:167::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 05:56:04 +0000
Received: from TYUPR06MB5876.apcprd06.prod.outlook.com
 ([fe80::ce17:7330:b522:e920]) by TYUPR06MB5876.apcprd06.prod.outlook.com
 ([fe80::ce17:7330:b522:e920%6]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 05:56:04 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogcmVzZXQ6IGFkZCBz?=
 =?utf-8?Q?ky1_reset_controller?=
Thread-Topic: [PATCH 1/3] dt-bindings: reset: add sky1 reset controller
Thread-Index: AQHcT5f429TQoTcB9UKGzGT7g1ZiKrTmzhWAgASeeOA=
Date: Mon, 10 Nov 2025 05:56:04 +0000
Message-ID:
 <TYUPR06MB5876641000411DCE14CAEBEBEFCEA@TYUPR06MB5876.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-2-gary.yang@cixtech.com>
 <5eb82fa8-e02b-4355-aa7e-6a38ef669d4b@kernel.org>
In-Reply-To: <5eb82fa8-e02b-4355-aa7e-6a38ef669d4b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR06MB5876:EE_|SEYPR06MB6707:EE_
x-ms-office365-filtering-correlation-id: cb209e12-0160-41c4-3bbd-08de201dd5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cm1tNW16THE4MUlNQ3k1YXpJbWtUcUd2aFBqay9kaVFTN0piKzIzVWcrRHNi?=
 =?utf-8?B?UllUZS9DWlhIMDNLS0JUcVh1eG9lZzk0ODl3ZnhEVnNybnFKbVFMZGJFcWli?=
 =?utf-8?B?cnMzWWpiYk9oU0ptalJwY2pCY1ozYk1rVHZ3bXR6UkhrenRGZUNENFN1VHRC?=
 =?utf-8?B?M1BjN0FPS1JGQnNudEhzVklaZnd2S2ZZQ1lwTUJkRWcrNGtZcWZEbUJkeDdn?=
 =?utf-8?B?SmhjUEpvUW5lN2xSd2N2SlhwSnFhT1QrRjQ2Ny90Nm9iZTRtL2FYTjMybkx4?=
 =?utf-8?B?OVVKb0k5Skw3blZnUHlTbUNSZjNYck1jUmlmVnplU3FpeTdBRVpCNjBrN0JG?=
 =?utf-8?B?SGFKYmZLcTJlVEsySHJjaklxK3hESURhbkpmK0xRMnRsOU85ODNjT3FkUkpH?=
 =?utf-8?B?Mzlmdk52bjJ5SU1TN3JUT2lCL3k5cnM2QU1RL1FGWWdqM2ViMGxZckcwKzZC?=
 =?utf-8?B?Z0ROekFtalBkdlZLZFY4NWcvbTR5MkY2UkdSQWlnWTJtUHRLcHlTRE1MTU1P?=
 =?utf-8?B?Q0cxdkVuRW1ZcEJ5elh1Zk5jMDJyZVVZcGhEMmZieVgya2NlYkYvL1VOYXhw?=
 =?utf-8?B?d1IvZzdQeXVsUm43N3Rkc1RvaDVPTzlRVGRkSEZSOVBaaG1Uc0x6RXd3Qi81?=
 =?utf-8?B?QnF0TkR1Q3phZmF4QnVJNTcweVN4SWtPcTZoTGhCT05mK056bEVBZWlJL2FC?=
 =?utf-8?B?R0NRTFV5ZklhRmc0NWRBNnJud2U3dmNFNzQ1MG5kRENlRDBUMWcyOEU0NVgw?=
 =?utf-8?B?OHVXdFJ6RHg4MWRzMGs4aDU0NFhuRGZJOHpxVTErSWJvWDdKa0JDMzY5YUFP?=
 =?utf-8?B?a3A4ZDZ3QkZ1cFhGSFgvYXhZYyt3dGlxRDdWQUZVcUZpcUNUTkt6SG5leEkv?=
 =?utf-8?B?VDhGRmU0Q3ZwaDhYQVZnUE8zd2dKKzVDc3NzOElZdVVqSWMva1JCRm4xeDc2?=
 =?utf-8?B?bkZSVEY4TVUrVnA1ZTIxRWhyS3NOeWwwR1loeUpxUEdTVXB6Vi9FdWVzZTZH?=
 =?utf-8?B?QVF2WEk2MGk1MHUvK2NJTEVmak8yWUlwcnZyWVdQdVdoNEdQRUpJVTl4akhr?=
 =?utf-8?B?eVA5WmRLb2NWNnBYMlBSMVNqamZQWTlRZExKZEduSGxUQmFrNzZVVTlZdmUw?=
 =?utf-8?B?UEo4UDM3dUtPSGkxNUg5OXV4OU5nV3BVUW5JVkthNnU0VmMvdyt1YVZ0bnVV?=
 =?utf-8?B?QldVMlFlNWl0aHBRTkJmSXZ5Q2RWcVBHM3ZyTU8xenFRM1dyUi85K1d5MC9p?=
 =?utf-8?B?SXFqakZaVWdXR0d6VTB5eDhJaHZ1eE9DUGxnZnlzekVwVnRtNlhSWkhPTG1M?=
 =?utf-8?B?U1o3Rkg2UDQyQ3AwamJuR0tGWlZzbTFvN09KeC9RZ0p2M0JRL0NLenorQmZj?=
 =?utf-8?B?OVhENjlZbEJSd0VXVmxieHdJWVEwVXptcW56K3ZFN2t6M0lYbHduTEJ2bmlC?=
 =?utf-8?B?Z0x4OHg2LzVNUG1UYkRvcDRVQ3d5WVl2NytZKyt0dGRmNkZhMVE1SnlUOW42?=
 =?utf-8?B?VXlWVzlGbTJtK3NRZWZlbEVZTWF0S29zSDAwemg5R3VncmNsSVNsWG5UZ21o?=
 =?utf-8?B?Nk9wRUVyOXROcG4yWStxVklFK1dmczBiSUJWbEhZK0M3Nzlld2hWczQzU2x4?=
 =?utf-8?B?aDRRckg1UVExV1JKZ2RUNWprYm9LNFBLTUNObVJETTE3SGdQYnl1dkhxb0pL?=
 =?utf-8?B?OW5qSW1LVFVCNzkvNGpWV1B2U0dnVzFGWVFlcVFPRXBBa3c1TElQTU9Jb3ZV?=
 =?utf-8?B?dVVvSUhyYmQzRU9JL2pxdFh5eGJkb1A2MVVOVVdsWHJjRlRlSjlQQmpiTkpP?=
 =?utf-8?B?dmRoTXVVWUswUmlvQ0dlYXJKMkZXbkJrZUxnTzI1bXkrMnZwYW5GdTIvaXhk?=
 =?utf-8?B?UnhvL2hyR2RZSmw1YmVSaVpSeVdDK3RNbGpVaG9Lb2xKcjJyMk9wazg5UDRF?=
 =?utf-8?B?VHkzb1c5RGlrbFZhV0VLdnYzaUMwTWtJV0lOWW9sNXhZbEhGWVJ1ZnV4STM5?=
 =?utf-8?B?cnJVYUc1c3hjajVHdzh1b0ZFM1RMV2N6R1NYbXFSMVdOd1J3aDJtdXM1L3hl?=
 =?utf-8?Q?43EHKj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR06MB5876.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDdHNWk3c1IwZldER0t1UitzSjFZQVI0czdVajV3bDdiTFI5MFZ0K2hud0Jz?=
 =?utf-8?B?ZllzbndVcDRIN1A4a3ErUzhqYXJxNEg3clVNTkF6T3dPZU1Od3RqOHlHWHFD?=
 =?utf-8?B?dGRIVzFlZlRLamNhaXpIY3F1TG00Sk5tZXZUMTdLYmttSnUyaS9FTU02K2Zn?=
 =?utf-8?B?YjR3K09rcE9mVXFmMjliMWFJbVByeXR3ZURaTVZZd3VGWmlrQUpHbkRWbUNv?=
 =?utf-8?B?dlFNd0VXOGh3SHJTYWQ3OURTMjk1ZTVxY29oNE5MOWNhNG9telgxV0dZNHA5?=
 =?utf-8?B?ZXl6YXdCYTZzT1FRUS9VWVZ2cXJ0bUloYjhuUkYyVDExeUQ1anRieVU1M0RT?=
 =?utf-8?B?UEkzb2NjOEhYdGRmSk1XZmx0TWxJeEFXd05IRk4ydU11RjJ0TlFrUS9iQU9S?=
 =?utf-8?B?OUtEUTBhMEN6NUNrckh1Vzl3THFTMHI1UWxtR055ZExuQTNScjl1VDIxTTcv?=
 =?utf-8?B?VndoU2VNcmpaM3BDa3NyaUVWUmo0OVFnV1ZJVHdObm5pNDRRb2g5TE5acG1z?=
 =?utf-8?B?SWFuNktSU0l3U2J0dWdidWRFOE9IQjY4SEdaeVZUYmJhTCt1enhDVTJVQWxC?=
 =?utf-8?B?aEt6UitySmRPNDNraXNmeEV1d21KRXMyUitxaHYzODJrNzJJd2JrMFBEa01M?=
 =?utf-8?B?YTl3ZE9mWjZnL01RRzVIN2s0MXQreTVoZmVOYUZSVEorRFZqYk5VaWxEcVpK?=
 =?utf-8?B?bVhmWnlDNmJSNlgxblN2Vk9EczlCWXdOWHozVzlYVkVnc29INEZvYUN2MlRJ?=
 =?utf-8?B?SkRBUU9saC9yTG1pRDE1UDYrVjB1N0dxTjhzOTlyOFBVZ25jQmZIQzg3bjBu?=
 =?utf-8?B?cmFGL2ppVUxidjlFTVMwR05hMzEweG4vTWl3TFVUWkVBWWk3UXZmeDNlUFVn?=
 =?utf-8?B?WjR0d2Zxemc1RjFlbjR2bmYwRFFya0FkTGJoaGl1UUpXZmpSYVdhYlVOZEI2?=
 =?utf-8?B?OGlHSmNVOG1BbVRhOGRHdHdPNXNDcHkxWWo4NmFCeDVDUG1SbkdiekkxV0ti?=
 =?utf-8?B?Z3kxbDlnc0diWWIxWWFBUXZFcy9RUXA3cFEwSUJxajF0c3dZaW1ZSUhhRStY?=
 =?utf-8?B?WGp6cHo5bHNadHB6MldFbFMxdFQvNENoUUlySk9LY3QyVURSS3RibzVCNUZH?=
 =?utf-8?B?Q0FKZHhpNXFQdUNqZE5HZ1J0VDJ0RFVoaU14WFZlQnhyNldseDV0VUdzcURI?=
 =?utf-8?B?Z1JoRzBnSEhTT2o0QWV2Y0ovdHQzL3FjYktZU2szTnlLNTdHM0g5ZW84ZDN4?=
 =?utf-8?B?aGo3aVJxMm84dHR1SU5CNENQV3F0MUsyTjcrbGU0bUhXL2dSZFNRT1J1L3Ar?=
 =?utf-8?B?bGg5dDBNdnUrQjdBU1hZUHJoWUJnUitIUU5LSDZLck02YXk5ZHZQRTFOT1E2?=
 =?utf-8?B?NmdwMWJYQWJjYzlPS2tpZGJRRURWSWtoRUx6dFRhem5LZXpncnlpemJjMEo3?=
 =?utf-8?B?UldCNEI5MWlleXBHL044Um9aOFBraUY0OEdXNWJaQktCdTBPL09EdG9vMFZi?=
 =?utf-8?B?YTB6YkpReGk0WUN5cDhXZFYweHRQeWtidm14bVJNTXQ5YWhiUjRuZFVhRkRs?=
 =?utf-8?B?Q2d5YkdYRUVncGRhenVoNThtc0RZblpRQk5KRktVOEQwU1FVMmxqVmJUZjh4?=
 =?utf-8?B?ZDVvM3R4RUhhMTNIazAxamdUQkxjQWVhaVRydEZqaG05OFgwYS9BQ0p5b1BG?=
 =?utf-8?B?Slh5UkZTZVozQmtGTldaSWZsZlQyMFBneExHNUFET0JIeGRoNlQ3Zk0rcUVn?=
 =?utf-8?B?QjNsdXo2Tm9YMnhqRjgwSDdobWZRYlZkSUhDY0dOWWdxSzFqQ1JOa0dDK3hK?=
 =?utf-8?B?STZWNktoNVd2SHkvaHBIdmVzRnI0QlhWSW9oNXJzUVBMa2ZVZ3FzdEM1RjVa?=
 =?utf-8?B?U01EK1pMSnRJVkZFd1MyUUtWR1dLSDNCZk5XQ0JaR1JnMktjS241UUJ4b2Zu?=
 =?utf-8?B?OG5BSUlCUTF5dTQrUjBOL3M2ZlRzdjVTaGNMQUNCRmxIbXg4V1RPU3p0MUVx?=
 =?utf-8?B?YkNzWFFFODA3Vi9vbGRQSksrUkNXWmhLVUpPSUE3Sm9Fays0S2Z1MXh3bmhp?=
 =?utf-8?B?TGpHMTUvWC9HaUJLdHczeTluY0dSTGNhZE9TRW01dUo5MjIvdDhXb0JIUjYy?=
 =?utf-8?Q?k8UtMPQ1Uy6BD3T6NZlYbsN0a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR06MB5876.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb209e12-0160-41c4-3bbd-08de201dd5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 05:56:04.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pud5QE7WB7hCFoWOBO/H+gzL2m+sDSkeCO+bONEPbWiAHFI6E8fs7CaFboOZ36eiwVIQ+rXou8MO/QXF9YSEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6707

SGkgS3J6eXN6dG9mOg0KDQpJJ20gZ2xhZCB0byBzZWUgeW91ciBjb21tZW50cyBhZ2Fpbi4NCg0K
PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogS3J6eXN6dG9mIEtvemxvd3Nr
aSA8a3J6a0BrZXJuZWwub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDfml6UgMTU6
MTgNCj4g5pS25Lu25Lq6OiBHYXJ5IFlhbmcgPGdhcnkueWFuZ0BjaXh0ZWNoLmNvbT47IHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU7DQo+IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3Jn
OyBjb25vcitkdEBrZXJuZWwub3JnDQo+IOaKhOmAgTogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgY2l4LWtlcm5lbC11cHN0cmVhbQ0KPiA8Y2l4LWtlcm5lbC11cHN0
cmVhbUBjaXh0ZWNoLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIDEvM10gZHQtYmluZGluZ3M6
IHJlc2V0OiBhZGQgc2t5MSByZXNldCBjb250cm9sbGVyDQo+IA0KPiBFWFRFUk5BTCBFTUFJTA0K
PiANCj4gT24gMDcvMTEvMjAyNSAwNDozOCwgR2FyeSBZYW5nIHdyb3RlOg0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIEdhcnkgWWFuZyA8Z2FyeS55YW5nQGNpeHRlY2guY29tPg0KPiA+ICsN
Cj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBDSVggU2t5MSByZXNldCBjb250cm9sbGVyIGNh
biBiZSB1c2VkIHRvIHJlc2V0IHZhcmlvdXMgc2V0IG9mIHBlcmlwaGVyYWxzLg0KPiA+ICsgIFRo
ZXJlIGFyZSB0d28gcmVzZXQgY29udHJvbGxlcnMsIG9uZSBpcyBsb2NhdGVkIGluIFMwIGRvbWFp
biwgdGhlIG90aGVyDQo+ID4gKyAgaXMgbG9jYXRlZCBpbiBTNSBkb21haW4uDQo+ID4gKw0KPiA+
ICsgIFNlZSBhbHNvOg0KPiA+ICsgIC0gZHQtYmluZGluZ3MvcmVzZXQvY2l4LHNreTEtcnN0LmgN
Cj4gDQo+IFVzZSBmdWxsIHBhdGggaGVyZS4NCj4gDQoNCk9LLCB3ZSB3aWxsIHVzZSBmdWxsIHBh
dGg6IGluY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvY2l4LHNreTEtcnN0LmgNCg0KPiA+ICsNCj4g
PiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4g
KyAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgIC0gY2l4LHNreTEtcnN0DQo+ID4gKyAgICAg
ICAgICAtIGNpeCxza3kxLXJzdC1mY2gNCj4gPiArICAgICAgLSBjb25zdDogc3lzY29uDQo+ID4g
Kw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+IA0KPiBZb3UgbmVlZCB0byBs
aXN0IHRoZSBpdGVtcy4NCj4gDQoNClNvcnJ5LCB0byBmaXggYSBidWlsZCB3YXJuaW5nLCBtYWtl
IGEgbWlzdGFrZSwgd2Ugd2lsbCBmaXggaXQNCg0KPiA+ICsNCj4gPiArICAnI3Jlc2V0LWNlbGxz
JzoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gJyNyZXNldC1jZWxscycNCj4gPiArDQo+
ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+
ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcmVzZXQvY2l4LHNreTEt
cnN0Lmg+DQo+ID4gKyAgICByZXNldC1jb250cm9sbGVyQDE2MDAwMDAwIHsNCj4gPiArICAgICAg
Y29tcGF0aWJsZSA9ICJjaXgsc2t5MS1yc3QiLCAic3lzY29uIjsNCj4gPiArICAgICAgcmVnID0g
PDB4MCAweDE2MDAwMDAwIDB4MCAweDEwMDA+Ow0KPiANCj4gQ2xlYXJseSB3cm9uZyAtIHlvdSBz
YWlkIHR3byBpdGVtcy4NCj4gDQoNCldlIHdpbGwgdXNlIHJlZyA9IDwweDE2MDAwMDAwIDB4MTAw
MD4gdG8gaW5zdGVhZCBvZiBpdA0KDQo+ID4gKyAgICAgICNyZXNldC1jZWxscyA9IDwxPjsNCj4g
PiArICAgIH07DQo+IA0KPiANCj4gLi4uDQo+IA0KPiANCj4gPiArDQo+ID4gKyNkZWZpbmUgU0tZ
MV9GQ0hfUkVTRVRfTlVNICAgMjkNCj4gDQo+IERyb3AsIG5vdCBBQkkgKHVzdWFsbHkpLg0KPiAN
Cg0KT2ssIHdlIHdpbGwgZGVsZXRlIGl0DQoNCj4gPiArDQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4g
DQo+IC4uLg0KPiANCj4gPiArDQo+ID4gKyNkZWZpbmUgU0tZMV9SRVNFVF9OVU0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgMTQzDQo+IA0KPiBEcm9wDQo+IA0KPiANCg0KT2ssIHdlIHdp
bGwgZGVsZXRlIGl0DQoNCkJlc3Qgd2lzaGVzDQpHYXJ5DQoNCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQo=

