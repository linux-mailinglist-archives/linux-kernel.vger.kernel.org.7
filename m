Return-Path: <linux-kernel+bounces-879533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B53C23528
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 07:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CF11A26A40
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8432E7F29;
	Fri, 31 Oct 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FnUbg+j4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oX0u0W9/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D223DDD;
	Fri, 31 Oct 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891026; cv=fail; b=K9QUXLlc13zW7Q4zEnfzlK8JNjaj1KT7AOB9vEu6+5mreS1NKtL5GLRoUhzYOisXVg1G9Qg6xP7EIYlnzbayI45QcilAGj7BIYiwDXOv8QankRJ5KyawBFvI8b443Bxm1NdA1MsrOMw9CQkrMjazp8RQo3YTH1fiL6k9QLqnZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891026; c=relaxed/simple;
	bh=TpRxk9EMHX6hWrjE+HGf8CfFjJ2ATeB1WdbpAih+cNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSiql4ydV6CM876gKlYkGHoybJlY3Aba5zBGaMYx6VVXX6ty0Ll7c3TJu/neU+Pl1AP1HQ2yOUevHSf7XcIYvOEHCZmA6Xqc3a/kAIWyEZMTAKyMqkeeffB56mwVs7h60i02SOYVoWGp8sg5Z4JS2TkotcSIqia3DRLimzYETrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FnUbg+j4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=oX0u0W9/; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 45f9b128b62011f0ae1e63ff8927bad3-20251031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TpRxk9EMHX6hWrjE+HGf8CfFjJ2ATeB1WdbpAih+cNg=;
	b=FnUbg+j4+/6FTRmMDdU26UTemxrT56ulUzBPBCLTfDKnkspc1D9FZi5nB9bXJMnxkOYlZtMydUKN4ujuMePf3UNd5hVp8Co0abV/dyaPQcp4SKQJqDUnDYzzAxwMPuWI106Rx4UDwEO5eH4dFxp+oytB3SDlnYgIYdqvbp9Yidc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e48fd3bf-579d-4311-82af-87bcc6866308,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4d7ae26a-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 45f9b128b62011f0ae1e63ff8927bad3-20251031
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 137301964; Fri, 31 Oct 2025 14:10:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 31 Oct 2025 14:10:15 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 31 Oct 2025 14:10:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hli3jHTg9d/j/d6uaJ4jOCd++Q0FCPeUo7pCaQiFowfZB/fsKrBrdiU3zQ0OTQT0I4WkLnaHSkn/I1PoD9OVZm/O9pQlgIwfpRqyNGmOTOo4HP3oLSIByqACAhHcQKw7jDVC+jxitpAGC2YbIY7bTDU2iU0ahrG/n3hT2QDZL4muiWX7a/nLJxGN3QeeG6kinsM4yMh6mYoKgCSDegnRIBePcZj5hRNlEIiY6PqjsowXioVndWbWfecS6LfKkhfoVH9gvTX6umcixpxkF4s3hHncWyLtOCU8qNTYtdLwgQgW7v9pzDNZZGHz9g2IOlh/tpYEfWBrn4Ii8Dtgx4CWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpRxk9EMHX6hWrjE+HGf8CfFjJ2ATeB1WdbpAih+cNg=;
 b=Litpqsn4/MfhK+KsoE1/dq8taOvlqfzeM4T7JfWp1te0KUNrD37HEnN7z7hGnidn4IWLVrEOYhjvSSbmmIBGW5CYrj0Gy41kzuRhx+b1QoA7aEt/5At/skwDMgoS66YnKGjpcXO1uRK4BnkuYPk1ona5y3UK8rqnKWEIp6pH5z3sidNYNBOG9dHDv3o/xEf8qkaJColzgN7+nmdROuJtPau7jop4lJ3lSF6JtYUhCTBKFezzPDPe214x2glqRcWPNJkbL/jCzOKjy0y9Lh2XiwiiBFQuW5S3yiDbKNv8br9AdNGMExXd7y5EUhveSK3bTWq/ZdMwsLAsy6RUh58JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpRxk9EMHX6hWrjE+HGf8CfFjJ2ATeB1WdbpAih+cNg=;
 b=oX0u0W9/xwpNjY2rJ4FIf4mA8VzzQMpXJ45oOYM0rglNvYTQArxmCbVu7HB2cBdhQRDK6QIPMpynloT3jm96X6a7z73YKfjmjOX9fuGSAjmrUR8OeL1DGS14ynE+xhVPJ4X0Bi+bkTWtcgYIvPNqE4m0c0349FckaxewclLenjE=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by TYZPR03MB7932.apcprd03.prod.outlook.com (2603:1096:400:44d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 06:10:13 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 06:10:13 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
Thread-Topic: [PATCH v11 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
Thread-Index: AQHcJ8vW+k5vc0j+QU61ViWQEfGoMbTITJkAgBO91oA=
Date: Fri, 31 Oct 2025 06:10:12 +0000
Message-ID: <916a3a16de8e9990d8cbe4726eca2c3d1ba73588.camel@mediatek.com>
References: <20250917120724.8650-1-friday.yang@mediatek.com>
	 <20250917120724.8650-3-friday.yang@mediatek.com>
	 <3ecf0545-513f-4a84-9772-f6cecc50f48b@kernel.org>
In-Reply-To: <3ecf0545-513f-4a84-9772-f6cecc50f48b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|TYZPR03MB7932:EE_
x-ms-office365-filtering-correlation-id: c2bb551c-ad3c-4785-370e-08de18442749
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M0JFQzhWdTQxK1QvOUhKcFcwWXB1b01ZaG1BZXErQUlGb0MrUnhyNTArYTNG?=
 =?utf-8?B?NnA3d1lVTVJKU3Y4SFJXdHZLRExFaG9Oa1lGemR1dUd3dzJvTldqMURwV3Yr?=
 =?utf-8?B?NnZCUytBVGxjVWVSVEN0dSt5cTB0dzdWYWxZanc5QWFJV1lVRTk0VmttVGtq?=
 =?utf-8?B?clpkazJJbldYQ01GRmRGS1NEYy9IdjIxZ3lxV3RHVVJGQVYxckhXd0sxY1lx?=
 =?utf-8?B?ZmNYNEtKUlhJZGswWGZtcW90QUNKK0h0WVk4MlVsSU0xMFIzaDczOTVLRWFw?=
 =?utf-8?B?TENjOGxMaDJydTZSWHBOZVNMTVpCNnpnZURrOUlmRlRUOVVic05QS2RnLzdo?=
 =?utf-8?B?UHNsSEVNb2kraHU4TElYMWtJdnlKS2lQdTk5anA5bERJK0I4N2w0TkVXcWU2?=
 =?utf-8?B?QzR0K21WR3U2NGNsYjMrUE5INm1DbXduQTRJQ3VvM3N5UThVR3IzdENGUURr?=
 =?utf-8?B?SmNvL3dWbFhHbG51THJNeGFIMG5CWVhiT0hwT281eEFXa1ZiSUZoaFR6M01H?=
 =?utf-8?B?bVNtOEllY2NIMlc4QUZGRytKRVpZc09DVkFpSkR3b2hmd1dIVWZtemhvbW44?=
 =?utf-8?B?MXFxQWVLYkNVVW9CWkhzVDBjYlQ5Sm00aDkwS3JJbnZFb3pUaWVFNW5NTVpr?=
 =?utf-8?B?Wm93Z0lrRFptRG1LcFBsZUh2YmNQZmhYMzUvZGZ4aGtxQW1sdkNGdktJcmox?=
 =?utf-8?B?S25qNFQ4SjJOZGhwbXR3WkFIYVNLeDBrWFhJK0VsaEMwbThFcmhndG8wQjBR?=
 =?utf-8?B?WGQyTENWNVY1VkpHbnpGR1M1VkNrT0h3VmNES0Uzd0d4aTlkTks0NmNsT05Y?=
 =?utf-8?B?Mk9OSU5FWk5wdFloeFJjWUhLVENBVzVDMGhUWVBtbmVIUTNJa3ZjYmREeHpL?=
 =?utf-8?B?NFNoU0JCZ0grNW5WL1J1VHRRS1ZMQS8xVHVGaEErcHFtWjlQK0VDbFc0UWcw?=
 =?utf-8?B?bllaajc2a3RhdDBIbGJ4akV5NGhKMGdxWXNoeWoyKy85dGJ0RkZaQTRGcHJH?=
 =?utf-8?B?VTk0MHhJSTk3RGhZaUM5d0Q5bjlybVlqcG8vR25WY0VhbzhjalcyKzIxUUdE?=
 =?utf-8?B?WVA0bmQ2T0lrUHBicVkweTF6RmlSbExaRzFnYjBGS3RBRzBiSS96RHA1NHRU?=
 =?utf-8?B?UVV0NEdVaUFNSU40dHk5SFNnK0xmZUpjWjBaVThvV1Q0ZGo4bW5KNWpoNk9j?=
 =?utf-8?B?VVBPYUJTdDJ2TjJDNWp2MitxSGxVYlVrUXZlVnY1WW8zOEVjUFBOZ2VWSDM0?=
 =?utf-8?B?UEdIak9tVTl3VkFGekpwTkRhS3d5dU1URmxobU5hSFNuNTBITlZGT0hZSElu?=
 =?utf-8?B?TG9MeWh5Umh2ZVRRNnZRamZpd0c3S3o2K0lqSWdPcVJOSHA4N2ZpUFpzekdq?=
 =?utf-8?B?L0VCMHc0Z21YMm1CbFRJVmdpTWdUQUNldTBFcDh5dWI0NFVPSGFUZi9LL1NS?=
 =?utf-8?B?VHFqSk52R2VUQUhPODVxSmJUb0hVUjY2a3NZR0JRVXR4Y09oTDdjTjl1ajA3?=
 =?utf-8?B?aUZtaXFhZlZ5c254aWtwT2NFRXh1NFQ4cTFPMXlaVTV0Rk0xWFgyWkpkczZH?=
 =?utf-8?B?MHZadk9MaFR2clcwaENsdi82RS8wRTBScjcvZXA2S0RMOG04WDlHMWFZVlUy?=
 =?utf-8?B?MERPa0VsNTkxWDZqNEp5UExzMTZNRDB5UlJjT0xjWHFUOURzRUxKN0k5YnYw?=
 =?utf-8?B?TlVBOUVINGtkdlp3T3ppa081Q0RjVGV1TGV3bFBSZmVtL3QwWkJEK21YeEc5?=
 =?utf-8?B?eXZqY0RmYmR6QU90OFd2a3VTL2ttUlpZOFExT2FZcG0wc2NMdkRYNnRvZ0FL?=
 =?utf-8?B?ek5lQS9FU1BRZitpTTNoYU9IUzFUS0dQandrWjNxTkJPamlGWSs3dzRWNHNk?=
 =?utf-8?B?QjVoQ0ZNblBsQjVoYWdQclpsb2NodDcycDRtZXU4emJZMUMvK3pveGtDQkhW?=
 =?utf-8?B?N2RaUDdmeHMvcyt3SHVmVGljWVFIeEM3Q3F1MXZVdzJzamJWSXM0Yko0VmxR?=
 =?utf-8?B?VWVWeVlGTXUwdjhTNW1ZYzhTdGpSNGZSUFhoZytKTHp6V0hZUzB6Yjh6UHV3?=
 =?utf-8?Q?wYswZT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWhYS0diY1kwQ2xBbTd1VnBpNWJVcmlkSTIvMTVKQjIvaFIrUXVkMHBGVWg1?=
 =?utf-8?B?TVNnZFVYd1BBaENEUlZZVUVRbUZvdDRRdTM4RDZ1b1M1K2Q5bHdIYnNGZmVw?=
 =?utf-8?B?eFp0NVREdkc1WkFJWUJRMkhJRjN0V092aURMbXBvMys2VXJlZGlSTnY2ZEl1?=
 =?utf-8?B?OXY4R090blZ6eWRuVGkvcGZTU000dnlhK1BNaDYzVzVtOXhFL2thUklSWVhm?=
 =?utf-8?B?OGtKakVoSG5Ua2dUaE0vNzl3M01NLzhwK1ZsR2dwL3c3UWZkTHlPUUxzSmtZ?=
 =?utf-8?B?Nk5NZElINVRSdUFaWVRGaE8vVXIyaUx6bUR3MmI5Z3JLQ0dIUk9ZOS9RV2Fz?=
 =?utf-8?B?S2JJT2dVYnJMSGluVXIrYzZRNmNaN2JLZDdLUVhwN3puWG9iQU9FcnNFamlN?=
 =?utf-8?B?LzNaRmZLcjZ5NHZwSThFNCtub0htMG5FZU92aXpQTVZnK3o4cjJRdlVJU2Fh?=
 =?utf-8?B?VGo0RWV5c3k0QW1tWGEzblkzYkN6SUdnRncwbUhjT1dlU1loUW1RaFc4SEJ0?=
 =?utf-8?B?VGQ0NEZEV2dWYjlzZVZPaW5vMmVJdk5WREpKdVhCK1ZjTG5mYTM0RmJMM2Jq?=
 =?utf-8?B?cFNTWGE5R0pRczNZNFo2ZDRkV0J0bmFkUFRaSEdOSTFIbE14eUQ1dDJIcm80?=
 =?utf-8?B?RnlzQmZFSDJBc1pUWk1oM3EwdUlOYXVRUzZ5ZFJBSzJZZjNkdUk5N2xpa0RV?=
 =?utf-8?B?cms4MDV4dGhSU3B2VzhHb1pLc3RMTXQrL2NMZk90K1dyakY2ck54aU10R2pY?=
 =?utf-8?B?aTc3dm9sKzFEdjdjLzF0Y0JMci9keTllcm5zY0ZIb2hzYVFNMk81K1RsN0tT?=
 =?utf-8?B?UjU3L1p6WGxlblYxZzhkREZkVy9tUExyNXB0UTFrK2JucWpOUE9ra2loNEJ1?=
 =?utf-8?B?SU5JWi91N2FrTG1XbzNNSDliZDh5SVNOMjl5S216VlkvS3NIWkM2MmNuRDN3?=
 =?utf-8?B?TldnQm9rdnZzeWVqYkhRbENnMCtlY1h6SnI4Mms5MEQyYTVIZmJuNCs5UnlF?=
 =?utf-8?B?UXpTSWlrSE9oNWQ1d290SGt5bVdnL3MzQzY1Nm5HN1V5ODlaQUdJamNqQ2NU?=
 =?utf-8?B?NVlwQ01DcitLaFZxN2g5VmxOUkV5MVRpZk1BK1VZQ3pzTGJXWW5pNkN2TDg3?=
 =?utf-8?B?bEtmSk5pd1JxZTBpbE9sWlE0Y1lvMVVYZlEwc1JBYWxRQ3NQaldmTnR6RGhC?=
 =?utf-8?B?YUxlemh4SHRzTDY0QjFsMVRDazR5bTFuY2c3VmVlODRlRGYwLzEwZ281OUsx?=
 =?utf-8?B?WnhvcEFTRVVTSjliWUpweHp5VDJBY1dUaWRxQ28wMExUanBiTlBWdVg5d2s2?=
 =?utf-8?B?RWhWODkyaG9rYUxlRmlCRGVsNEt2cmg2NkxLRWVLSGh3Ly8vY1VBVGJvU3FC?=
 =?utf-8?B?bmxFWkdhZ0JkZjNhVGRyQThPWW5YTDByWWRlRGk1bm9ieEI5YnplZ3RjZm8y?=
 =?utf-8?B?aFlzVkdYZ1NqWHZVTUlqcjhaTWtGditBVVZZSEdSWWFVazVwMVRYRUU5dERk?=
 =?utf-8?B?eWhyTy95d2NKZUMwYW1QR1I3akp1RXZ5Zm5VT2tGUi9uTENCZkhUWW14V1o5?=
 =?utf-8?B?eXhkK1BDaDY1NFg5eHN0dTBJdm1qbVBuVXFMVTBWN3ZYeWIzVlVYdmc2dE5t?=
 =?utf-8?B?U0p3YVFuT2k3ZnBqZmdPeGh6ZHBtbUJPOUUxSU0wRnJwMUo3Qml4Qmt3MDYr?=
 =?utf-8?B?R2FhaWJocmhnOHEvc1FzbHZNYWZXdjdKVTh0NmZXam5xdUl5cTNXcVkrd3or?=
 =?utf-8?B?SENhTFZaWGRNQXdTWHZqYWM3UEovT1diZVE5cjdkcXZNVjRmdFBGVnkvUENR?=
 =?utf-8?B?eXlsQTlWZTlGbHlpMEtGZlRUNWNWampPU1gyM3ZnTktLdnlFeVBlakRBY1JN?=
 =?utf-8?B?OUJFdUI2b3dPTTIxaW5CRHBMSW9EekVWY2JiTHB6SFRmejdQSHNwN3RyUHF2?=
 =?utf-8?B?NlFLbU5YVnF2RTk0Ry9WTTU3MzBrYitndHFUa2I4Z0VNRC8yeGJTR0l0NFlD?=
 =?utf-8?B?OUFmQWtzekh3amRhaCt5VVFQTVd5OTdwK0ZhbnZXV1BOYXZPYzAvc0c3aWdn?=
 =?utf-8?B?ZFZOU1hxV3I5MDBBR1AvZXFmbXBZVVBtcnlzMUlsdjBjcmhHOW9XVG51T1E3?=
 =?utf-8?B?OFZoZDJpU0pNVUdPTDFVNGN3eTVkaXc1NmJHT3ljQWViTG9TRzVWOUM0b1oz?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5187E0277991A940A1FB5D8075DADC98@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bb551c-ad3c-4785-370e-08de18442749
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 06:10:12.8627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCpUymBW46AIAdcoeCL1hZjoBf43mdjP4VMkx06fB0OCDYjEzs96zQTl7awxfi+IWeG8gbR5PwfG2UHNU18i8dwe1adVf/HIZl5Ysv+NCEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7932

T24gU2F0LCAyMDI1LTEwLTE4IGF0IDE4OjQxICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE3LzA5LzIwMjUgMTQ6MDcsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+ICBzdGF0aWMgaW50IG10a19zbWlfZGV2aWNlX2xpbmtfY29tbW9uKHN0cnVjdCBk
ZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gZGV2aWNlICoqY29tX2RldikNCj4gPiAgew0KPiA+ICAg
ICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnNtaV9jb21fcGRldjsNCj4gPiBAQCAtNjM4LDYg
KzcxMSw0NiBAQCBzdGF0aWMgaW50IG10a19zbWlfZHRzX2Nsa19pbml0KHN0cnVjdCBkZXZpY2UN
Cj4gPiAqZGV2LCBzdHJ1Y3QgbXRrX3NtaSAqc21pLA0KPiA+ICAgICAgIHJldHVybiByZXQ7DQo+
ID4gIH0NCj4gPiANCj4gPiArc3RhdGljIGludCBtdGtfc21pX2xhcmJfcGFyc2Vfc3lzY29uKHN0
cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIsDQo+ID4gaW50IGxhcmJpZCkNCj4gPiArew0KPiA+ICsg
ICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiArICAgICBjb25zdCBzdHJ1
Y3QgbXRrX3NtaV9sYXJiX2dlbiAqbGFyYl9nZW4gPSBsYXJiLT5sYXJiX2dlbjsNCj4gPiArICAg
ICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICBsYXJiLT5zbWlfY29tbV9pbl9wb3J0X2lkID0g
bGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYmlkXTsNCj4gPiArICAgICBsYXJiLT5zbWlfY29tbV9z
eXNjb24gPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKGRldi0NCj4gPiA+b2Zfbm9k
ZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJtZWRpDQo+ID4gYXRlayxzbWkiKTsNCj4gDQo+IFRoZSBjb2RlIGFscmVh
ZHkgcGFyc2VzIHRoaXMgcGhhbmRsZSAoaW4gb3RoZXIgcGxhY2UpLiBXaHkgZG8geW91DQo+IG5l
ZWQNCj4gc2Vjb25kIHRpbWU/DQo+IA0KDQpUaGFua3MgZm9yIGNvbW1lbnRzLiBXZSBkaWQgcGFy
c2UgdGhlICdtZWRpYXRlayxzbWknIHByb3BlcnR5IGluDQptdGtfc21pX2RldmljZV9saW5rX2Nv
bW1vbi4gV2UgbmVlZCB0byBtb2RpZnkNCidtdGtfc21pX2RldmljZV9saW5rX2NvbW1vbicgZnVu
Y3Rpb24gaWYgdGhpcyBuZWVkIHRvIGJlIGZpeGVkLg0KQmVsb3cgaXMgdGhlIG1vZGlmaWNhdGlv
biwgaXMgdGhpcyBhY2NlcHRhYmxlIGZvciB5b3U/DQoNCnN0YXRpYyBpbnQgbXRrX3NtaV9kZXZp
Y2VfbGlua19jb21tb24oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlDQoqKmNvbV9k
ZXYsYm9vbCByZXF1aXJlX2NsYW1wKQ0Kew0KLi4uDQoJc3RydWN0IG10a19zbWlfbGFyYiAqbGFy
YjsNCglzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiAqbGFyYl9nZW47DQoJaW50IGxhcmJpZCwgcmV0
Ow0KDQoJc21pX2NvbV9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShkZXYtPm9mX25vZGUsICJtZWRp
YXRlayxzbWkiLA0KMCk7DQoJaWYgKCFzbWlfY29tX25vZGUpDQoJCXJldHVybiAtRUlOVkFMOw0K
CXNtaV9jb21fcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUoc21pX2NvbV9ub2RlKTsNCi4u
Lg0KCWlmIChyZXF1aXJlX2NsYW1wKSB7DQoJCWxhcmIgPSBjb250YWluZXJfb2YoY29tX2Rldiwg
c3RydWN0IG10a19zbWlfbGFyYiwNCnNtaV9jb21tb25fZGV2KTsNCgkJbGFyYl9nZW4gPSBsYXJi
LT5sYXJiX2dlbjsNCgkJbGFyYmlkID0gbGFyYi0+bGFyYl9pZDsNCgkJbGFyYi0+c21pX2NvbW1f
aW5fcG9ydF9pZCA9IGxhcmJfZ2VuLQ0KPmNsYW1wX3BvcnRbbGFyYmlkXTsNCgkJbGFyYi0+c21p
X2NvbW1fc3lzY29uID0NCnN5c2Nvbl9ub2RlX3RvX3JlZ21hcChzbWlfY29tX25vZGUpOw0KCQlp
ZiAoSVNfRVJSKGxhcmItPnNtaV9jb21tX3N5c2NvbikpIHsNCgkJCWRldl9lcnIoZGV2LCAiRmFp
bGVkIHRvIGdldCBzbWkgc3lzY29uIGZvciBsYXJiICVkXG4iLCBsYXJiaWQpOw0KCQkJcmV0ID0g
UFRSX0VSUihsYXJiLT5zbWlfY29tbV9zeXNjb24pOw0KCQkJbGFyYi0+c21pX2NvbW1fc3lzY29u
ID0gTlVMTDsNCgkJCWdvdG8gZXJyX3JlbW92ZV9saW5rOw0KCQl9DQoJfQ0KCW9mX25vZGVfcHV0
KHNtaV9jb21fbm9kZSk7DQoJcmV0dXJuIDA7DQoNCmVycl9yZW1vdmVfbGluazoNCglkZXZpY2Vf
bGlua19yZW1vdmUoZGV2LCBzbWlfY29tX2Rldik7DQplcnJfcHV0X2RldmljZToNCglwdXRfZGV2
aWNlKCZzbWlfY29tX3BkZXYtPmRldik7DQplcnJfcHV0X25vZGU6DQoJb2Zfbm9kZV9wdXQoc21p
X2NvbV9ub2RlKTsNCglyZXR1cm4gcmV0Ow0KfQ0KDQpzdGF0aWMgaW50IG10a19zbWlfbGFyYl9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0Kew0KCWJvb2wgcmVxdWlyZV9jbGFt
cDsNCi4uLg0KDQoJLyogVGhlIGxhcmJpZCBhcmUgc2VxdWVudGlhbCBmb3IgSU9NTVUgaWYgdGhp
cyBwcm9wZXJ0eSBpcyBub3QNCnByZXNlbnQgKi8NCglyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3Mz
MihkZXYtPm9mX25vZGUsICJtZWRpYXRlayxsYXJiLWlkIiwNCiZsYXJiLT5sYXJiaWQpOw0KCWlm
IChyZXQgPT0gLUVJTlZBTCkNCgkJZ290byBhZGRfZGV2X2xpbms7DQoJZWxzZSBpZiAocmV0IHx8
IGxhcmItPmxhcmJpZCA+PSBNVEtfTEFSQl9OUl9NQVgpDQoJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgLUVJTlZBTCwgIkludmFsaWQNCmxhcmJpZDolZFxuIiwgbGFyYi0+bGFyYmlkKTsNCg0K
CWlmIChsYXJiLT5sYXJiX2dlbi0+Y2xhbXBfcG9ydCAmJiBsYXJiLT5sYXJiX2dlbi0NCj5jbGFt
cF9wb3J0W2xhcmItPmxhcmJpZF0pDQoJCXJlcXVpcmVfY2xhbXAgPSB0cnVlOw0KDQphZGRfZGV2
X2xpbms6DQoJcmV0ID0gbXRrX3NtaV9kZXZpY2VfbGlua19jb21tb24oZGV2LCAmbGFyYi0+c21p
X2NvbW1vbl9kZXYsDQpyZXF1aXJlX2NsYW1wKTsNCglpZiAocmV0IDwgMCkNCgkJcmV0dXJuIHJl
dDsNCg0KCS8qDQoJICogT25seSBTTUkgTEFSQnMgaW4gY2FtZXJhLCBpbWFnZSBhbmQgSVBFIHN1
YnN5cyBuZWVkIHRvDQoJICogYXBwbHkgY2xhbXAgYW5kIHJlc2V0IG9wZXJhdGlvbnMsIG90aGVy
cyBjYW4gYmUgc2tpcHBlZC4NCgkgKi8NCglpZiAocmVxdWlyZV9jbGFtcCkgew0KCQlyZXQgPSBt
dGtfc21pX2xhcmJfcGFyc2VfcmVzZXQobGFyYik7DQoJCWlmIChyZXQpDQoJCQlnb3RvIGVycl9s
aW5rX3JlbW92ZTsNCgl9DQoNCnBtX3J1bnRpbWVfZW46DQoJcG1fcnVudGltZV9lbmFibGUoZGV2
KTsNCi4uLg0KfQ0KDQpzdGF0aWMgaW50IG10a19zbWlfY29tbW9uX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQp7DQouLi4NCglpZiAoY29tbW9uLT5wbGF0LT50eXBlID09IE1U
S19TTUlfR0VOMl9TVUJfQ09NTSkgew0KCQlyZXQgPSBtdGtfc21pX2RldmljZV9saW5rX2NvbW1v
bihkZXYsICZjb21tb24tDQo+c21pX2NvbW1vbl9kZXYsIGZhbHNlKTsNCgkJaWYgKHJldCA8IDAp
DQoJCQlyZXR1cm4gcmV0Ow0KCX0NCi4uLg0KfQ0KDQo+ID4gKyAgICAgaWYgKElTX0VSUihsYXJi
LT5zbWlfY29tbV9zeXNjb24pKSB7DQo+ID4gKyAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGxh
cmItPnNtaV9jb21tX3N5c2Nvbik7DQo+ID4gKyAgICAgICAgICAgICBsYXJiLT5zbWlfY29tbV9z
eXNjb24gPSBOVUxMOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCByZXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRv
IGdldCBzbWkgc3lzY29uIGZvcg0KPiA+IGxhcmIgJWRcbiIsIGxhcmJpZCk7DQo+ID4gKyAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGludCBtdGtfc21pX2xhcmJfcGFyc2VfcmVzZXQoc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYikN
Cj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiAr
ICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICBsYXJiLT5yc3RfY29uID0gZGV2bV9yZXNl
dF9jb250cm9sX2dldF9leGNsdXNpdmUoZGV2LA0KPiA+ICJsYXJiIik7DQo+ID4gKyAgICAgaWYg
KElTX0VSUihsYXJiLT5yc3RfY29uKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgUFRSX0VSUihsYXJiLT5yc3RfY29uKSwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gZ2V0IHJlc2V0DQo+ID4gY29udHJvbGxlclxu
Iik7DQo+IA0KPiANCj4gVGhpcyBsb29rcyBsaWtlIEFCSSBicmVhay4gQXJlbid0IGFsbCBkZXZp
Y2VzIGFmZmVjdGVkPw0KPiANCg0KVGhpcyBkb2VzIG5vdCBhZmZlY3Qgb3RoZXIgZGV2aWNlcywg
d2UgdXNlIHRoaXMgJ2NsYW1wX3BvcnQnIHRvDQpqdWRnZSB3aGV0aGVyIHRvIGFwcGx5IGNsYW1w
IG9yIG5vdCBpbiAnbXRrX3NtaV9sYXJiX3Byb2JlJywgDQpsaWtlIGJlbG93Og0KCWlmIChsYXJi
LT5sYXJiX2dlbi0+Y2xhbXBfcG9ydCAmJiBsYXJiLT5sYXJiX2dlbi0NCj5jbGFtcF9wb3J0W2xh
cmItPmxhcmJpZF0pDQoJCXJlcXVpcmVfY2xhbXAgPSB0cnVlOw0KDQoNCnN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiBtdGtfc21pX2xhcmJfbXQ4MTg4ID0gew0KCS4uLg0KCS5j
bGFtcF9wb3J0ICAgICAgICAgICAgICAgICA9IG10a19zbWlfbGFyYl9jbGFtcF9wb3J0X210ODE4
OCwNCn07DQoNCj4gPiArICAgICBsYXJiLT5uYi5ub3RpZmllcl9jYWxsID0gbXRrX3NtaV9nZW5w
ZF9jYWxsYmFjazsNCj4gPiArICAgICByZXQgPSBkZXZfcG1fZ2VucGRfYWRkX25vdGlmaWVyKGRl
diwgJmxhcmItPm5iKTsNCj4gPiArICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICBs
YXJiLT5uYi5ub3RpZmllcl9jYWxsID0gTlVMTDsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBk
ZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIkZhaWxlZCB0byBhZGQgZ2VucGQNCj4gPiBjYWxsYmFja1xuIik7DQo+ID4gKyAgICAg
fQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

