Return-Path: <linux-kernel+bounces-743422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0D6B0FE74
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 03:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D591CC576F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EECF190664;
	Thu, 24 Jul 2025 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uovEGZU1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZXLlJek/"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B64A28;
	Thu, 24 Jul 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321797; cv=fail; b=L9YwEGpg6XlkYSDhym/a4MEog9GiDonFA2iCVcPZnfg6gZbzehETbvlSEYSDMWDrwHpIYjzf6XXjwLb0wwFke50CQQd4piIkkFcfvzxjI8jzqNWWortmbTcrZiqC4Mw558dHJxAOZ7cdXKCGncnQNE+16vynuZptKABwkWJvOaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321797; c=relaxed/simple;
	bh=OnYK8nfRBILQaK+gziyF8YNYbvEiMqijFbbg0EplKGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoeLaijitqIFmfTXSYMoGW5ktdgHGd2qIuEfurzj/5z/SA9s+nJz6ZxRbEsNXohjVSlIwUf7LX1lyvvKYZZqY/Im3e7rM/8vAvACthQrDrMaYOwvOK22Z7p+w368TYmSqQfXzE5JkZZrTkQDkaFFvyBpjD0OHUSPsO7H65bGIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uovEGZU1; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZXLlJek/; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b2e6c46683011f08b7dc59d57013e23-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OnYK8nfRBILQaK+gziyF8YNYbvEiMqijFbbg0EplKGQ=;
	b=uovEGZU1JgKrfkuD8tqsVwNYY3DfS24VFq8VWumuP7d1F+q778sjrf00YYYLhzjxDfnwv2pRQgaOsnrmU24p3WLx76Pde0eIsKEim6Y0kAK6/bLZPGKV9IVaphpGL24DO133JcftjtvFsXiLRchPaTEOsVPYxedEVzay3bduW1A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:5b4661e9-6551-40d6-a0eb-29616eaf9e74,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:8447b808-aadc-4681-92d7-012627504691,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7b2e6c46683011f08b7dc59d57013e23-20250724
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1828176177; Thu, 24 Jul 2025 09:49:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 09:49:45 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 09:49:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtZDtqPfcYAGknftgy/hRbOw0U5IJj1KfviZnfY/btBsLy3IOkdjFMNNp++Z2kqDxG0OP7VjILVPUvvS3HlQ3VdZ5kh2b2cK/fNfkxzzZh3zZ449yUHASXsvGST2OfRrFPhae9iS85MGUuBJznzE84vIIjg6iak1uGMVYq/RoGGSgWiX99lu2ddQV7Mp00lINlhlKXX2TloUvrCVnfRl1F1lxpIACfXqE+uIVr8ec11C8FjwmtanEONOfxHUKxoliGbOZgt2pbueYKPHJLaAMSbI+nu/hJsNQ4iqcjO7bJqyhRZEaDw1z3CZ5WAm3hJYrAsrBPOL3AM7rK2YDlUOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnYK8nfRBILQaK+gziyF8YNYbvEiMqijFbbg0EplKGQ=;
 b=KhMe4/GHySLfiM7dSICnbk6a9jbm9BZt2iI+xC9tjVzbE3ICOTSO53iPVyjNyiDPCvO1ecQz2Nnq0Y0i95/JfnG7sLJwtiXUaTW1JjCi+ckGgYpUhVy0fE4VYDVZoJIOseUEeS+lvDvszbjVucfDgBIoReOvkAaDF6RtgTyCQyqXwNCpWbKEXBbGlQxIp4shHrThmniJ787DlWT3y8ac0zCaxg6HvP1B94nTo1uQ5GCr+UGj3XJw44HLVI1zeBR8Vv6yaEexRTaE/Qi46HohSpKpayNtG+GJFEn1zgMKCIO3S30RIU8yjoVoSH/mjPARwKIu2V64dytBlBI9t0SqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnYK8nfRBILQaK+gziyF8YNYbvEiMqijFbbg0EplKGQ=;
 b=ZXLlJek/T3PgZxbr+vXP1AnB4m44tnPww8TEeQ/aSsXUccsQwBtfe2apZtlCFTg/ZxURGYDP0WQb93RixR1MO7lO7Ou/K/4EnaFZIJSB+moqIIJX7F3srQTY8ddvUts0kvhdwSE5yqnMfS0ijH8ta7G2uZ6gUejK3/Z5EoqVbsg=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SI6PR03MB8688.apcprd03.prod.outlook.com (2603:1096:4:253::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 01:49:44 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 01:49:44 +0000
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
Thread-Index: AQHbyhpymjbAswZs7UKlfaymlOtvZLP/xc+AgEEgbgA=
Date: Thu, 24 Jul 2025 01:49:43 +0000
Message-ID: <7421d8f4f3d5fdb392f46df93bfee21a97cc2e1c.camel@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
	 <20250521063347.31578-3-friday.yang@mediatek.com>
	 <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
In-Reply-To: <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SI6PR03MB8688:EE_
x-ms-office365-filtering-correlation-id: 28dcfb26-ae0b-4d59-8244-08ddca545cd4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVVlNjFJMHhER2pnNkJJczFJNmlWMFpxMjN6RG1SNzlBc1M4NU1wcG9oLyta?=
 =?utf-8?B?SVJQWE83bXpBZmhxQyttcnIrRnFZcS9TMkFOWlYyS3hITVd3Tk8wNWVUbEIx?=
 =?utf-8?B?NVR1WVhtNjFIVjhZa2dYaVYxWFBNZ09PNHovNGhhWEZXTlhOZUdIQmVmeVdY?=
 =?utf-8?B?OTl4VHQ3dnJraHRFRXg5WUxQQ0wwaXdPeUZqcDc5UkMzMmV1S2U2RHBlWFM3?=
 =?utf-8?B?Nk5Uc1JjdHg3bkRuYmxkajFXR283US9mUVh5cmVQcVNyS2tRMVRHQ1NuR3hv?=
 =?utf-8?B?VmduNnNtMUdCRm9TVmxLNjR2c29jZ3NWN1VDSTRGRjZNaElibzBzdStHckFw?=
 =?utf-8?B?ZzFkaS96QUJNUWRpQnFJaG0xTnltd1VlVnczbDlhZ1RnMkZCMWtqL213UE1K?=
 =?utf-8?B?TTRzU2N5MWJSdTJaUG5mQlZrWGdyY0hqbUhZMExNMnNLdkxQSFk3L3BLalZD?=
 =?utf-8?B?alpVNFB1R1gwZmFPQnlhYjh1QlZId1RlKy9HM3g3WFJrcHpaRWlOSGdaTTd5?=
 =?utf-8?B?YlEzajQwQmI2VFhnMEplTjNwbmM3MHRGMzdnRFhBMExRaGRvV2lUMU5FWWdD?=
 =?utf-8?B?NjJGZWtjKzhhZnJuR1BwdzZQWGsvZStnYUVrYW45bGs3ZmtFb2twUGNwbG5s?=
 =?utf-8?B?OGNBbWRRRWw0LzFPVENkMmJ6ZGIwdFA0QUlaeGsvaUZrclMwQ2N1RHdUNVZX?=
 =?utf-8?B?d3J0eFA2Q0JpY1UvL2ZocGQyaFc3RElkb2xKZGFDZkdzaDNTNkprMUlRM3M0?=
 =?utf-8?B?ZURpVndjVWRBTlVLbkhRa05YNk9MQldjZ0lTUFBvVnJQeEFNN3hmQklyc1A5?=
 =?utf-8?B?WjRMeVRrWm9hcDkwcEQrckFicVdPaVRMWEcyWVRTVTVwUit0cGczOWZMblUr?=
 =?utf-8?B?OG9NUEtna2hZM3JwNXBXVEcvdXM0UUhMeHdubFBYT3FXY0laQWd6STdEQk9J?=
 =?utf-8?B?M3lBbEVaOHdrNXM5b0tycHZnY3JNZVlIOTNWaWRQWVBNMmhXYmVyUnRnWThi?=
 =?utf-8?B?TFFjVzV2STFpbFpPczJEVmN3TWVVTUk5UEtWSHZkUkkvV1NPRUlTWnA2YXcr?=
 =?utf-8?B?RytIOERheVBEUmk3N1ZGNm1iNmVpb2wyWW53REQzSDkzSUlPcUVXTzFYM1lK?=
 =?utf-8?B?VDNUZllOTXIvSTlDRFVXOExRazJWRkYyeFVFLy9mcE54dERETVQ3WiswV3pu?=
 =?utf-8?B?UjZjajRITXRYMUR4YjJzZFJZbUluQytsRW01WW45UHE1citXYmVDNllRSEk3?=
 =?utf-8?B?NmtUY2IyTHRja3pVZ1hScTN6NWwrSkY3U3hSaXBnUlUyR2NzS3o3N0Q0Vm9B?=
 =?utf-8?B?NG11TmJXVjRMY3Q0eVpqQUpjdE1nZGR2UjZqdXZ4aXk0S3BBcXF3UTJSNGh2?=
 =?utf-8?B?MmFLbXVRS0M0RE90MEJjWGxvcTJnTmV4SzJrZC9ZYkhMaDFvSnB4YkxkRjRy?=
 =?utf-8?B?VmYxZXRpcjRRcEg0MWdNdS9KUHdBTXVvdmJtMkNpY0dMQlB4Y2ZsenB4aVN2?=
 =?utf-8?B?NE00ZE9ZaUxHM21nUHQwb1RnUm5MSW1DWmppWHRlN1k3SkVOVmlFRE5XbTJh?=
 =?utf-8?B?TXE5VnNWQy9GVmVmRkxFQ3JwTWVWZTdWR3pLbEtSNG9nS1pMMUtBQm9WMDNz?=
 =?utf-8?B?d2VYbjVnb3pVQUN3MCtiRlpSYThmRGpNcEd3aUVYTWpQbWhzVThnMm5UOFVB?=
 =?utf-8?B?Sk9vVGxqbTEvMHJQcHJlRXpjMCtueFMzL1BHQWNBdkg5Q2pTZGVpZllXeUxE?=
 =?utf-8?B?WE93RVhsK0REcnNqWDVvdUYrdlIvQjBmZVBiVnNkYUpnNk1jczhlV2tqRlZZ?=
 =?utf-8?B?SHA5OTErOFZQdEEvd1I4ZUpLWVdDbHd4dmVmYmgvY3hwbFl3Y1dKc04vbU4y?=
 =?utf-8?B?R1Rua1NEcWQyVW95ejFMTjVYT3pQNWg2aGx4dE9IVzk0R0l3YklkT0dZbVRC?=
 =?utf-8?B?dXRqZjJ0RVpMQnM3elNvRGlRZ1VtYitmRmVCRktyTFRoeVc1dzF3VEN5VUp1?=
 =?utf-8?Q?nLiA5f2ttM8pMwp3N6qa0ns0SHkmvs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGpuTisyaHlUQnR5TjRaK3FrOTcyN2dYOTZualhyWEd3OTFsR2RFOWFpM01t?=
 =?utf-8?B?TENRQmlzNW9IQStRSGE2VTNDNFBVdUN3VnVZdWd5WHNjZEc3emVLWjlmYjhX?=
 =?utf-8?B?K0p1V3A0SFpxYlZPVE9oMkNnQ0FCTWpmeUVPV0trb2FGUWU3Njg4Nlh1d2NU?=
 =?utf-8?B?K0REKzNLK1dBMlRjYnpsN0g4cTAxcm15eVVsd0kvK3g3Z0ZWVzFvem1pb0l0?=
 =?utf-8?B?LzV0TGpDdFpVa09PeXpKb0UwREJPNm0yOGZWRjZxTEExOExVWFprQmhrWGgy?=
 =?utf-8?B?WmpNRE4xcmNjTmZLbFBHNlNRalRROS9UYzlNSDBIdkxCQ2VvMnpCVUs4YTgv?=
 =?utf-8?B?NXZkczQrRHRoYXJRNklvZHdBVkVXS2tMSzlYT3J0Zm1lU3c4MkpqUFowYUpI?=
 =?utf-8?B?Qi9UMjYyRzlndmNoTFd2YStQVHFGZllzOW5vQVVHQldKWU9IZXhleGJUa21j?=
 =?utf-8?B?ay9jUnNSS3Y3NGluRFhVbWJJR2hsaUJXN1pDUUFJa2YrRzdvRktDSi80RWVJ?=
 =?utf-8?B?Q21VZGZ3VG9xRVViZDg5UzhaY3RkbzR4KzR5bEVSNVZJb3gxRTJjaVhtWWFk?=
 =?utf-8?B?bUZnYVVyMFNyL3grbGpSdnNUUFJ5d04vZmZkbUozR0VKdThYamRQUzdEV2NC?=
 =?utf-8?B?NFUvOTVWanNwQmtra0pxaUhCelltK0ZXZUZHR2ZNRnF6b2ozMFhDelNiV0M5?=
 =?utf-8?B?ZW9RaXE3MEkreWVGNlJYMEtDOWVLeTVEZS9Gam5wMHNBS0Q4Uld1MmtyRWR2?=
 =?utf-8?B?SFRpVFhrTGhlUVh3ZmtQemVWaW9LeHBEMTdCMlQrQnovZENpemlJSmFkQUQw?=
 =?utf-8?B?NVZsWmZiNEY2aWc0S1loM3RqWDdIUmdNSDIwMkxCaEIvMURrR3B2RjRrc0l2?=
 =?utf-8?B?RW9DYVF6bUV0ZjFlNS9iZ0luemRRdkNZUXlyQlFDNytnY3MwaEhpNEgra1NU?=
 =?utf-8?B?Y2Vrc1dtUVgzdkNsTlhUWHlPaEU0ZWFvbzB6WFJtRnJjekF4aitGMkNuWkh3?=
 =?utf-8?B?N0crL1BHcHpMWGRyakkveHMzMGxpZzMxY2Q0UnBxNG9YYnRlRjZGemw3cEp3?=
 =?utf-8?B?Znd0dWNMTzY5eDFxR0l0RSswbUdPaStKWWdiWDlrcGRHUkZxeVM2Y3hkU1d2?=
 =?utf-8?B?OXpDR3FITTlBSkh6RFlraC9iYVFWdHAzUi8rbG9zbUNyZE1aL3B1SldDSXow?=
 =?utf-8?B?cHhsZjdUM1pBMEE2elN4RDRrL1hEbVduazNuRlJ4QS94eEYxcUFkT2xqaUJU?=
 =?utf-8?B?UFlLSFJ4dFFTMUs4TldjMzEvblMvZFR2cTM2L093Uk1aeWxCRVBROGFYaThV?=
 =?utf-8?B?T1RhTHFvUHRIWnZrRWlrNW9lTFZkUmpvZ3hYRjRvU0NtMXJJVFZkY3J4VmhY?=
 =?utf-8?B?S2xpOHlUZnRIdlhudmc5Zlh0ZjhYK1B1MTZUYnEwUFhkTHFmSENaUksranBo?=
 =?utf-8?B?WnlRbE05NTR4N2huNHpOa3BhSVMrRExEYlhockV5Q1l5M3ZaWHJDQ1ZJdkYv?=
 =?utf-8?B?VTdwVW95eXJzRVd3bG00aWx0L0YzY2pCUE1KMlJDNHQvdGZlZFRWaThXWUI4?=
 =?utf-8?B?SDdhTDZXYzhYRHkzUitoUmJ1aXNpS2NEWVpTNzJFTWFDWlhVY0lHa3NYaHVY?=
 =?utf-8?B?UVFBV1AwYWloeDZINnJCTTJSbkxhYVM3ZkIwS1dFUlZOVGQwaVQ0K2NXL3dt?=
 =?utf-8?B?cVJEeGZRSW9uTzRuYSszTGN2U2dDaDBvYW1DODNpWG00Qk9qcGx3K3R0Sjc2?=
 =?utf-8?B?SEh1NXVDQ3NBWmtiR3RqWWtKd2RVNTBVUk9JcU9ZVDBqVWJRTm9NNXMxWm9Y?=
 =?utf-8?B?aHZyTXRHQ0xYSlVZaHI4V0x2S2hhR0tzM3JuNE4rVU5va2JHNTlqYmVFOW1U?=
 =?utf-8?B?ampZMUYzYTdCRDlZbGEvZXVwZjYyNStKdHkzOFV6ZzlyVVB4UlJ0RWRFL0lp?=
 =?utf-8?B?Skt6cmlhR1pTMyt2dWFtVjRSeC9uZ0R1RE1jUThCV2pHWkdkTnJmb3l1V3BL?=
 =?utf-8?B?QmRhSUlCTDl2MTUxV2gzOWdSWGJkVzNVcExVN2U0RldxeEZCUDBXRHl1WmNR?=
 =?utf-8?B?VE1PdzI1dUdVblJYQlNrUUIzTVRNZVVHeDU5T0RGMzJ0eGVXLzdzTmJVeTNs?=
 =?utf-8?B?Q0xuZXhkWHhxeXNBNFUvdStYaTVEdnhqOGhweDVuL1l1WVZGTkE1eGdxNUpK?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF23E59F0C03B24D93B94957CEE462F5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28dcfb26-ae0b-4d59-8244-08ddca545cd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 01:49:43.9327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYaD3eReRkpt2eAjDt3mP45lbGw9XkDLbqHi0et7WSYUnZziGZs5iywItdTno+pa/p7FTBT4CIiXsDbYWAAtIrmoRXhLaq10EwqJDRDHuoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8688

T24gVGh1LCAyMDI1LTA2LTEyIGF0IDE3OjE2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDIxLzA1LzIwMjUgMDg6MzMsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+IEZyb206ICJGcmlkYXkgWWFuZyIgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBUbyBwcmV2ZW50IGhhbmRsaW5nIGdsaXRjaCBzaWduYWxzIGR1cmluZyBNVENN
T1Mgb24vb2ZmDQo+ID4gdHJhbnNpdGlvbnMsDQo+ID4gU01JIHJlcXVpcmVzIGNsYW1wIGFuZCBy
ZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQgc2V0dGluZ3MNCj4gPiBmb3INCj4gPiBT
TUkgTEFSQnMgYW5kIHRoZSBjbGFtcCBzZXR0aW5ncyBmb3IgdGhlIFNNSSBTdWItQ29tbW9uLiBS
ZWdpc3Rlcg0KPiA+IGdlbnBkIGNhbGxiYWNrIGZvciB0aGUgU01JIExBUkJzIGxvY2F0ZWQgaW4g
aW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+ID4gc3Vic3lzdGVtcywgYW5kIGFwcGx5IHJlc2V0IGFu
ZCBjbGFtcCBvcGVyYXRpb25zIHdpdGhpbiB0aGUNCj4gPiBjYWxsYmFjay4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gYW5nZWxvZ2lv
YWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IEFja2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiANCj4gWW91IGRpZCBub3QgcmVzcG9uZCB0byBwcmV2aW91
cyByZXZpZXcuIFNlbmRpbmcgdGhlIHNhbWUgd2hpbGUNCj4gaWdub3JpbmcNCj4gcHJldmlvdXMg
cmV2aWV3IGlzIG9idmlvdXMgTkFLLg0KPiANCg0KQXBvbG9naWVzIGZvciBtaXNzaW5nIHRoZSBt
ZXNzYWdlLiBJbiB0aGUgdjYgcGF0Y2gsIEkgcmVwbGFjZWQNCidwbV9ydW50aW1lX2VuYWJsZScg
d2l0aCAnZGV2bV9wbV9ydW50aW1lX2VuYWJsZScuIFlvdSBwb2ludGVkIG91dCB0aGF0DQp0aGlz
IGNoYW5nZSBtaWdodCBhbHRlciB0aGUgY2xlYW51cCBvcmRlciBhbmQgcG90ZW50aWFsbHkgaW50
cm9kdWNlDQplcnJvcnMuDQoNCnY2Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1
MDQwODAzMzIwNi4xMjE3Ni0zLWZyaWRheS55YW5nQG1lZGlhdGVrLmNvbS8NCg0KVGhlcmVmb3Jl
LCBpbiB0aGUgdjcgcGF0Y2gsIEkgcmV2ZXJ0ZWQgdGhpcyBjaGFuZ2UgYW5kIGNvbnRpbnVlZCB1
c2luZw0KJ3BtX3J1bnRpbWVfZW5hYmxlJyBpbiB0aGUgU01JIGRyaXZlci4gSG93ZXZlciwgSSBk
aWQgbm90IGluY2x1ZGUgYQ0KY2xlYXIgZGVzY3JpcHRpb24gb2YgdGhlIGNoYW5nZXMgYmV0d2Vl
biB2NiBhbmQgdjcgaW4gdGhlIGNvdmVyIGxldHRlci4NCg0Kdjc6DQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzlmMDFhOWE0LTg5YjItNGJmYy05N2NkLTgyN2JlOTg5ZWYxNkBrZXJuZWwu
b3JnLw0KDQpJbiB0aGUgdjggcGF0Y2gsIEkgaGF2ZSBhZGRlZCBhIGRlc2NyaXB0aW9uIGluIHRo
ZSBjb3ZlciBsZXR0ZXIuDQpUaGlzIHNlcmllcyBqdXN0IGFkZCBmdW5jdGlvbnMgZm9yIFNNSSBj
bGFtcCBhbmQgbm90IGNoYW5nZSBhbnl0aGluZw0KZWxzZS4gSXMgdGhpcyBhY2NlcHRhYmxlIHRv
IHlvdT8NCg0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg0K

