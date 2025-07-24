Return-Path: <linux-kernel+bounces-743728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18FEB1028F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B057B3B2ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244312727F9;
	Thu, 24 Jul 2025 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oYn4lHJe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="D0jzNKLF"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF027144F;
	Thu, 24 Jul 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344002; cv=fail; b=Py3tMKYKzwrisrsicHjHaKHubbUORf0K18AsEf1FE2BKTtzD+WN8THN4LUGvCAjJeYGpyGMo+CQhD+L/d3eA8bR/L9DMGjJh2aikuZNYrWW5QyWHwnNo8H6GB0MNlet9WUVLmFJaiMX+/Mg8Mmp/N9padTfDBDsbDC+HkMiqpFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344002; c=relaxed/simple;
	bh=Ix2TQvTuJ9wPxcR7JIO64SfhJplhKVJKr1BolY8AIz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z80KTRdyjy6gEZnIt/9ok6c3MxdBHFn3mHRFepCVFydshj28jh/nvngwIveApvZ9fJkY4mzpoCC3H44533SYyQznj8IE7y608NjDYQ69ZFw9z7espIRzOlwq6sMXzb3jsL0JQTET3RCHTe9J3+cM2c3zvR1Sgc/KYQnplYJDeao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oYn4lHJe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=D0jzNKLF; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2ee16940686411f08b7dc59d57013e23-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ix2TQvTuJ9wPxcR7JIO64SfhJplhKVJKr1BolY8AIz4=;
	b=oYn4lHJebYw5uA/1W1LgllLjGbafntSqISnAuWfL3wD2wD9BUoz1gauI5zuE84SzXOyMvuL0+EvsjXnssvrs03q6+DDLt1MYpD6c4YK+0BN8Sev3Ib9nr3MEyyPMWkh7fRnqrM39qPhM84llFYWkGbVVzvHMipDdG288PhrOzuM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:48710758-9323-4b5d-bfd5-d94ff5c48376,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:987f3350-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ee16940686411f08b7dc59d57013e23-20250724
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 25626055; Thu, 24 Jul 2025 15:59:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 15:59:51 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 15:59:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IW7ttlCi01SNcUGhhfGoUz0T5HI1uGuuGmPp8ud3gdW9b7xCLxhLpVWcdwVaJeUwBqxX/6zrhjWBNBdAO7c7PR02umaQZNX3xAhlXyY822wH/L91jetOBtJU9Wn8BV4Mr9wZnIxoalmoFZREfdyK6UIw+1m5CoKCAnXCLRHef4CoVeFnaNz2w1HRpo/ADX+a5B+tJfqmaoH6aONCQtt3cQox4o/nT1aiC2ZQRBmleHcjPw5TFaxYSIgpb/0s5PrfHsp5CQC/x2Yx+heebx0NSeHaBYKiVgKQri4AhIyLzzsluwzKmLG75yJ5c4mN9NRgCIszSNypwmMTwOy9YtW6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix2TQvTuJ9wPxcR7JIO64SfhJplhKVJKr1BolY8AIz4=;
 b=O64lcPMZFSB/Zy9RruRUubHuELKIknUKeHfF87BaGMiL5gH/q7lxC0DEj8ZBwoChwacjNjQK3b4hIqULrMQRB8JcC+1ai6nYyvVpWVug6t2LcPFIKs9lk/r0CM9+cUxsFP93nNS3veJcCA4aL8N+7tgc3lGJc6siNTc/mlqvXmhs7WSdbTMgFHbbtOQDszLDTqE4Hg7+OWwOhLBUnWBqeM9Ke+TVEnprNaWsE/FZHILA78J8fuzmL4u9UrMtDEjgmXGTUgRXguvidCzCubdUp1YWYXzH2FulxkBkao9ngmOWJFVSc1GYVzAaLQn0rGfH6xnKSj7JVhvLXSbfIEN7Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix2TQvTuJ9wPxcR7JIO64SfhJplhKVJKr1BolY8AIz4=;
 b=D0jzNKLFl82EHDxTj0CHG3zW0WrS3vCyOKIgdFXPBb3Fe2esF3ahSTpcGo0Hpmh3+gEtLHAVF5QPn0+qwFEkGsZEu+x3O6frtQN86NjQZK42uAdQfy0vZ1OleNKl2aPxGNAh2xbU3ZIH8EoM6TvxRuyPyzhfqpbXiOYEdsh7flo=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEZPR03MB7755.apcprd03.prod.outlook.com (2603:1096:101:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 07:59:50 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 07:59:49 +0000
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
Subject: Re: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHbyhpymjbAswZs7UKlfaymlOtvZLP/xc+AgEEgbgCAAFkbgIAADkuA
Date: Thu, 24 Jul 2025 07:59:49 +0000
Message-ID: <d7e6e9f9da7adf5c806f29c577f6bf51b35fdeed.camel@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
	 <20250521063347.31578-3-friday.yang@mediatek.com>
	 <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
	 <7421d8f4f3d5fdb392f46df93bfee21a97cc2e1c.camel@mediatek.com>
	 <633ea291-2e02-44be-bd03-220634b3c62d@kernel.org>
In-Reply-To: <633ea291-2e02-44be-bd03-220634b3c62d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEZPR03MB7755:EE_
x-ms-office365-filtering-correlation-id: 7b659552-3d04-456a-1b15-08ddca881028
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkE1ei9WVE9WbHRGL1JQMmExVlBDS3RWUlJYTDJZNVA4SFhvWlpXeWtFcnJ5?=
 =?utf-8?B?MnJ5Tk5UbzBQR2JjZytwSldpcFU1dWxEZCtCU2JFWGRIbHBMYUI3RFhROWM5?=
 =?utf-8?B?Wmd4TmZqVFV4NTVDWGxHNDQ0clhUeEVKcVR5SU05bjRNWXlPckt6L1hyZmNE?=
 =?utf-8?B?c1A5Zm9SYzI3TUcvRFAzcWZOYk5rUkJ5RTRLRUVYSWxVK2RmcmVCRHJrR2dx?=
 =?utf-8?B?aE9MbVpnOW82NGMySmtEZVNoTGNOYVA5UzB4Z0lkZUNsWkVUZU5NK0NJU0h1?=
 =?utf-8?B?T0R5a093WjRWKzdYVnNvQ20vaHh2R01XVTMxUytLUFRjWUtLaDFYL1pweFNu?=
 =?utf-8?B?K1VsRVlXRUV6SGh0VjUwT3MzK3dTQU9qSkNSQkRNM2VYNGpwbVdjVDAxM3ZY?=
 =?utf-8?B?b0h5d1FCRDdKaStlR1lJYTBjaDNTaEowS1laNTBoYkFjZlRjUzRnbm9jYmNr?=
 =?utf-8?B?VEoxRG94aHdVTHlvb3NzUDRZaHZ2SDJnd2l0QWNCQ2ZCNnBBaTRYd1l4OHV6?=
 =?utf-8?B?Rzd4M2lWQzh1SGhDQ1dLR2JxcXFqRXZiOCsyb2l1Nk1pNXI3Yi9XcHJHV05V?=
 =?utf-8?B?ZGVxN1BadWFJZlg4ZHU3NnRleFA5SWNSZFhTYTRRbjFoS01YZGljL1oxbXVW?=
 =?utf-8?B?QjVaM1NjcVFaTWJ6Yk9wWTIzRDZPYVA3UTFVNC9kUTJaUkJhYWwvdWsvWTF6?=
 =?utf-8?B?THp4TE41cnBRTVFqZ3hYQTRITDdIVkJMZU9veUFEV0NYclRTUkdyQllta0NG?=
 =?utf-8?B?NFhkZEU4aVFPaWpUMnRxME01dFlXV3ZCOHE2N0kyMGM3K3hMNkFtbXpDK2dl?=
 =?utf-8?B?dU5IcHNSaGM2Y0tmc1hvNzRWTnIvMDY5dStLTWZzOVVXbDNzcGcvRUYxMHR4?=
 =?utf-8?B?NzA5S2lSeU0vWS9oODFWV3ZkTEJZVnA0aHg2Q090T2lLdjBUY1huY1QrWVhZ?=
 =?utf-8?B?UG1pYjNlZ1lkODlKKzhHZ2dud1p4MzluOERNSll3djN1VlBMSTVDTXRJaUk3?=
 =?utf-8?B?YUM4WGg1WnRySUNQYUlXK2dNYWcydmtpc0NSMlJtS2YrTVJXUm1HVmZIbWlk?=
 =?utf-8?B?UkREakpGUVdhM0hpY01nd01rR0Y3bDFtaFZZalpBOENMRnI0VkNST2pBV0Nq?=
 =?utf-8?B?OU5kSExad0FjOThpZW1JdGhVK2VJWlBaMUV3dmRxbXVHV3hBVW5ERGl1UjRF?=
 =?utf-8?B?dmd4SXZsRkJPUXJndVJURDAwVHdJcnpOdmJSc2FVa2FTV0NCdVFraHRwZnp3?=
 =?utf-8?B?Y3ppNzhGc1dYZ3VNVk8rVGpvdGU1SEpJTmYrRHFxdWRCT1FJOTJuN3FYcWMw?=
 =?utf-8?B?NXZSdUJHWW1BTUs0MUhrcUp6ME13dUtrU1FCK0pKY1BUZnpUYTNmN3FBRERv?=
 =?utf-8?B?SFZpaVB4SkMzajNSVDJ0VE44c1hqMXlvVjk5VFMrYVNadkx2ZHhxTVhhQ2l4?=
 =?utf-8?B?TFpnaUlnWGtSRTdWN3NwVHVscmR3WS9INkRBNnRUaHFZWllWRkdjNkNKZGFH?=
 =?utf-8?B?MVdUd2dLNDV3RjZDTzFMU2dxK2FJakxYbXN3d0g3NzhHMEJwd2FBcGNjUWpi?=
 =?utf-8?B?emhxQTNqYzdsMHRiSjFVV1JnclVIZGd4M2tTdGRGWmxRd1FBV3ZrV0dHRUxR?=
 =?utf-8?B?eFBIeWtGUHRSZlRXSGEyRVpaeVpCT1lqVlN1Z0VGYjR4emFrRndrbFphVm90?=
 =?utf-8?B?azZ2Z2g1QXFzdWsxL2dHbHJzSFk1OHJRNFdwcUNyK1czRGNoNnp4ZzU4ZHpz?=
 =?utf-8?B?MGE3K0lkWWFxUU1UTW5EQ0J1NHIxcGY4aUlTcHJSYmtpRkNvOU81allqa1JH?=
 =?utf-8?B?WHlqaHFCTlFpWWRmRWdNWHp2N25GQkZ0L3FiVkkyamVvK2NYakhCQVVVNXpu?=
 =?utf-8?B?Nkg2UE1RRjJFU3BuMloyTVlkb2hjUkh4bm9pN1UrZ0JLckxlT1FrUzFvWk5x?=
 =?utf-8?B?TWU2blhrNVNySHoxWUhNcm5udjF1VzV0QkplYUdMZ1lEUW9wclozQndORmxk?=
 =?utf-8?Q?u0dEKo0QsIPxH1z2FS4ZqBYVYeTmdY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1B4YnN5WGdMemVZanhsdXNYakRiZnFSQ1Y4ZFpNcGUxSHA5VFRINTRtSEtq?=
 =?utf-8?B?emthOWZ0L1hQeWRKVWJPMjdVdTN3RHhLMUFla0dYWWNkaXh5Qmd6QVUxZEd3?=
 =?utf-8?B?eDJFV1lVL2F1eWtxcFlQVDZWNisvZUV4NE41b2V1bTFnellHWVc2ZStFMzl0?=
 =?utf-8?B?ZHU2WFBpVEdrKzFvaktOTHc3UnNvcTFZOXBMelVwY3VrYlJWNFp3RVpoRnFP?=
 =?utf-8?B?OWlQTWNQTERBaFQvenFEeHYrSmNXR2lQZ1k3dmdpSUxwcUx1KzhoQ3Rrbi9j?=
 =?utf-8?B?OTVKRllXSzd5cTNjVFZ1VlJBd09nRlpqeTArRTJLdkpUdndhTnJubmxyWXNW?=
 =?utf-8?B?eEVOR0V6NHo3azRUS1ZXaE8xemdSK3B5bEpsTTRJSCtSSm5iV1JLN0Vjem5k?=
 =?utf-8?B?NDZlUWY4ZEIycXVFWktyMEw2QlRKM1FGYmdkNlZuWjk2UzJlY2ZzNFBLa1pK?=
 =?utf-8?B?clpvUnF5TWJrbUtqUVNrb3B5bG1hNDE5d2lWUTRMU09aam53OUdJNGVzOGsr?=
 =?utf-8?B?N2tjSVE1MWVQV0Raa21lcE9OUmFRb01DY2thWElwQkZKRGNUZVNCZ2dwYVNT?=
 =?utf-8?B?cmpqK0VzeTJLbGVUNXF4b0lkYWxWdFpaY1FrOGN1Mlpvc1o2ZzBJQ05Ba0Vq?=
 =?utf-8?B?QWVzUDkzVzVPcjErYXJaUFU3bldWLzdUWkRBOGlBU05oODIvbjBMeGlpdWRI?=
 =?utf-8?B?RFg3T3NPa1VhV0xJT0x5SEZaR0NzUjBFMVZRM0lyVnNuWmliMnB5dDRyVTZi?=
 =?utf-8?B?cjcrTjd1S2wzZnRCOHUyV3RSekgrdlovRHZMQjhxY0EwVnBpUFhGenhuVGo0?=
 =?utf-8?B?UHprbFkwMmtYaVRac2R2UDF5NmpIYytBUlJnWkZoa3RKRTVOelRIaHVldFRq?=
 =?utf-8?B?MUI0RjRtbW9pNjZpV0Z3elZ1SlZDS1ZXMnpMdmFDcnR4dUxYRndDS1pnK0cz?=
 =?utf-8?B?ejAwTnR1MDJKRzJGcEY4VU1WbVBOVHk5Z1hnclUxRG1oMXNZaHZXaHVZTzRy?=
 =?utf-8?B?dzI1cVZoVVZCZHl1c0FsVE1YL25lWmgrbnZFbGlSdm55MWxLV3h0N3R6K0ts?=
 =?utf-8?B?NHhwMHVxczNVQ3UwQjdBQkNkVFZlRGt5QTNMNzhZTzVtVXBweE0xeGROcFBp?=
 =?utf-8?B?Vi85ODdwelhFN1R3WHBBVUVsMmUrQ0VUNlExdm41QjE2Qy9lSkN1akYxbHc4?=
 =?utf-8?B?elQxTWZXbUhoYjRYMElaTDJ3bW1pQ0VNNnlmU00rR0FDaVV5M0kwQzlJbGEr?=
 =?utf-8?B?Q1k3QWVONlcxMTBVSFJvakFPNWRsWnJsMTRiRGlUb0V3azRkR0tMTzVwU2pM?=
 =?utf-8?B?ZG8vSWk3M05YWmNDbHc1amI5TGsxV3J3SzU4dm9Oek10Rjdpbk5UL0JhYnRZ?=
 =?utf-8?B?MUx4RUhQS20wbFlhbkdHaENkYmRhbTFtR3YxcVoxNzNmM0V4bFhmUU0xNXZU?=
 =?utf-8?B?MkF4V0tadDRkTi9YN25MMENydnlpcUxNNUFpeVdvNXBOdjZpOUpBa0M3NkNw?=
 =?utf-8?B?SVhJaUg1VUZxVVpzaDR6NWJiMHEwVkxudlFxRHo0aVR6WUd6R0pJb3hRUlFi?=
 =?utf-8?B?SDR0blM3M3dNQzdvdE92TjZwOTA2MVZjZ2RxcDd1MGdKRC9GaE55RUxYMEkv?=
 =?utf-8?B?bXhBNGliUkd2T004QU0vSFp0aGR2OE13OWtJVFFUNzRUWmMrZTd3SDN0THlV?=
 =?utf-8?B?bmwzYnBHR2d2RThoWGNpNnQyblRrTFdrQ2JaRXpMb0tvNWJ4WGlDd2k2OGF2?=
 =?utf-8?B?d1lBRWNMQW02ZlJNd0Nrc1NvK3Y1Nmk0aEFoV2tHZUd6RVRwR0VZSmY5Wm1V?=
 =?utf-8?B?SXFsdmU5TExkc0FLTnMwWjY1VUkzM0crR0JzeXV3QVo3MTc5eUFUckUrSDJo?=
 =?utf-8?B?aG5kMkhwb2hJTkNIdGlzY1NBeHIyUVdaRU85SGxrdUVFWnRRRnVnT2c5bzg2?=
 =?utf-8?B?dFRKSVNKeEhFTnpEeHZ3bm9HQlFSZDVRRjEwVDBXUnZNeXZwR21tOWpoYmRJ?=
 =?utf-8?B?SWZJdGlJV0VaR2dPV3dFVE15MFVzVnVuM01vV2hBNmpFSUtXMkdtNzEwclZw?=
 =?utf-8?B?USt4aVFhREJqdU5XdmQxeFZia2VDNFZSQ081WEVLRjVHZFd1MnJJSmFnTWJ6?=
 =?utf-8?B?NWhnejVkQkxScEt0WVd3N1p6ejVLaEJYOXl6QkMyUGIrZnBDMlgvbU9sVVNY?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F676EA7E12DE9E4EAD6736914BE24A4C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b659552-3d04-456a-1b15-08ddca881028
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 07:59:49.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iyrbiqCLTuZ5OLNgNtJtKQ2fGnSPmGY+SObr8+CSj1FkJ46BMTUd12UAu8P42YwhBk8eTBoMMuRVMpyVxdBHF1eOALH+FUFFS7dGVyA7Ws0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7755

T24gVGh1LCAyMDI1LTA3LTI0IGF0IDA5OjA4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI0LzA3LzIwMjUgMDM6NDksIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wNi0xMiBhdCAxNzoxNiArMDIwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAyMS8wNS8yMDI1IDA4OjMzLCBGcmlkYXkgWWFuZyB3cm90ZToNCj4gPiA+
ID4gRnJvbTogIkZyaWRheSBZYW5nIiA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4g
PiANCj4gPiA+ID4gVG8gcHJldmVudCBoYW5kbGluZyBnbGl0Y2ggc2lnbmFscyBkdXJpbmcgTVRD
TU9TIG9uL29mZg0KPiA+ID4gPiB0cmFuc2l0aW9ucywNCj4gPiA+ID4gU01JIHJlcXVpcmVzIGNs
YW1wIGFuZCByZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQNCj4gPiA+ID4gc2V0dGlu
Z3MNCj4gPiA+ID4gZm9yDQo+ID4gPiA+IFNNSSBMQVJCcyBhbmQgdGhlIGNsYW1wIHNldHRpbmdz
IGZvciB0aGUgU01JIFN1Yi1Db21tb24uDQo+ID4gPiA+IFJlZ2lzdGVyDQo+ID4gPiA+IGdlbnBk
IGNhbGxiYWNrIGZvciB0aGUgU01JIExBUkJzIGxvY2F0ZWQgaW4gaW1hZ2UsIGNhbWVyYSBhbmQN
Cj4gPiA+ID4gSVBFDQo+ID4gPiA+IHN1YnN5c3RlbXMsIGFuZCBhcHBseSByZXNldCBhbmQgY2xh
bXAgb3BlcmF0aW9ucyB3aXRoaW4gdGhlDQo+ID4gPiA+IGNhbGxiYWNrLg0KPiA+ID4gPiANCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogRnJpZGF5IFlhbmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNv
bT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4g
PiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiBB
Y2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiA+IA0KPiA+ID4gWW91
IGRpZCBub3QgcmVzcG9uZCB0byBwcmV2aW91cyByZXZpZXcuIFNlbmRpbmcgdGhlIHNhbWUgd2hp
bGUNCj4gPiA+IGlnbm9yaW5nDQo+ID4gPiBwcmV2aW91cyByZXZpZXcgaXMgb2J2aW91cyBOQUsu
DQo+ID4gPiANCj4gPiANCj4gPiBBcG9sb2dpZXMgZm9yIG1pc3NpbmcgdGhlIG1lc3NhZ2UuIElu
IHRoZSB2NiBwYXRjaCwgSSByZXBsYWNlZA0KPiA+ICdwbV9ydW50aW1lX2VuYWJsZScgd2l0aCAn
ZGV2bV9wbV9ydW50aW1lX2VuYWJsZScuIFlvdSBwb2ludGVkIG91dA0KPiA+IHRoYXQNCj4gPiB0
aGlzIGNoYW5nZSBtaWdodCBhbHRlciB0aGUgY2xlYW51cCBvcmRlciBhbmQgcG90ZW50aWFsbHkg
aW50cm9kdWNlDQo+ID4gZXJyb3JzLg0KPiA+IA0KPiA+IHY2Og0KPiA+IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDI1MDQwODAzMzIwNi4xMjE3Ni0zLWZyaWRheS55YW5nQG1lZGlh
dGVrLmNvbS8NCj4gPiANCj4gPiBUaGVyZWZvcmUsIGluIHRoZSB2NyBwYXRjaCwgSSByZXZlcnRl
ZCB0aGlzIGNoYW5nZSBhbmQgY29udGludWVkDQo+ID4gdXNpbmcNCj4gPiAncG1fcnVudGltZV9l
bmFibGUnIGluIHRoZSBTTUkgZHJpdmVyLiBIb3dldmVyLCBJIGRpZCBub3QgaW5jbHVkZSBhDQo+
ID4gY2xlYXIgZGVzY3JpcHRpb24gb2YgdGhlIGNoYW5nZXMgYmV0d2VlbiB2NiBhbmQgdjcgaW4g
dGhlIGNvdmVyDQo+ID4gbGV0dGVyLg0KPiA+IA0KPiA+IHY3Og0KPiA+IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC85ZjAxYTlhNC04OWIyLTRiZmMtOTdjZC04MjdiZTk4OWVmMTZAa2Vy
bmVsLm9yZy8NCj4gPiANCj4gPiBJbiB0aGUgdjggcGF0Y2gsIEkgaGF2ZSBhZGRlZCBhIGRlc2Ny
aXB0aW9uIGluIHRoZSBjb3ZlciBsZXR0ZXIuDQo+ID4gVGhpcyBzZXJpZXMganVzdCBhZGQgZnVu
Y3Rpb25zIGZvciBTTUkgY2xhbXAgYW5kIG5vdCBjaGFuZ2UNCj4gPiBhbnl0aGluZw0KPiA+IGVs
c2UuIElzIHRoaXMgYWNjZXB0YWJsZSB0byB5b3U/DQo+IA0KPiBUaGF0IHdhcyBtb250aCBhZ28u
IE5vdGhpbmcgZm9ybSB0aGlzIHRocmVhZCBpcyBpbiBteSBtZW1vcnksIG5vdGhpbmcNCj4gaXMN
Cj4gaW4gdGhlIG1haWxib3guIFRoZXJlIGlzIG5vIGNvdmVyIGxldHRlciB0byBmaW5kIGFueW1v
cmUuDQo+IA0KPiBBbnl3YXksIHlvdSBkaWQgbm90IHJlc3BvbmQgdG8gdGhlIGFjdHVhbCBjb21t
ZW50IGFuZCB5b3Ugc2VuZCB0aGUNCj4gc2FtZS4NCj4gTm93IHlvdSByZXNwb25kLi4uIHRvIHNv
bWV0aGluZyBlbHNlIHN0aWxsIGlnbm9yaW5nIHRoZSBjb21tZW50IGFib3V0DQo+IGZha2UgdGFn
cy4NCj4gDQo+IEkgd2lsbCBub3QgYmUgd2FzdGluZyBtb3JlIHRpbWUgb24gdGhpcyBwYXRjaHNl
dC4NCj4gDQoNCkNoYW5nZXMgdjc6DQotIFJlbW92ZSB0aGUgJ2Rldm1fcG1fcnVudGltZV9lbmFi
bGUnIGNoYW5nZS4NCg0KQWJvdmUgaXMgdGhlIHRhZyB5b3UgYXNrLiBZb3UgYXJlIHJpZ2h0LCB0
aGUgJ2Rldm1fcG1fcnVudGltZV9lbmFibGUnDQp0YWcgSSBtZW50aW9uZGVkIGluIHRoZSBwYXRj
aHNldCB2NiBpcyB0cnVseSBhIGZha2UgdGFnLiBTbyBwbGVhc2UNCmlnbm9yZSB0aGlzIHRhZy4g
V2hhdCBJIGludGVuZGVkIHRvIGV4cGxhaW4gaGVyZSB3YXMgdGhhdCBJIGRlY2lkZWQgbm90DQp0
byB1c2UgJ2Rldm1fcG1fcnVudGltZV9lbmFibGUnIHRvIHJlcGxhY2UgJ3BtX3J1bnRpbWVfZW5h
YmxlJw0KZnVuY3Rpb25zLiBVbmZvcnR1bmF0ZWx5LCB0aGUgZmFrZSB0YWcgZGlkbid0IGV4cGxh
aW4gdGhpcyBjbGVhcmx5IGluDQp0aGUgY2hhbmdlbG9nLCB3aGljaCB3YXMgbXkgZmF1bHQuIFRv
IGFkZHJlc3MgdGhpcywgSSB1cGRhdGVkIHBhdGNoc2V0DQp2OCB0byBpbmNsdWRlIGFuIGV4cGxh
bmF0aW9uLg0KDQpJbiBwYXRjaHNldCB2NiwgSSByZXBsYWNlZCAncG1fcnVudGltZV9lbmFibGUn
IHdpdGgNCidkZXZtX3BtX3J1bnRpbWVfZW5hYmxlJy4gSG93ZXZlciwgaW4gcGF0Y2hzZXQgdjgs
IEkgcmV2ZXJ0ZWQgdGhpcw0KY2hhbmdlIGFuZCBpbmNsdWRlZCB0aGUgcmVhc29uIGZvciB0aGlz
IGRlY2lzaW9uIGluIHRoZSBjaGFuZ2Vsb2cuDQpBcG9sb2dpemUgZm9yIHRoZSBkZWxheSBhbmQg
dGhlIHRyb3VibGUgYWdhaW4uDQoNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

