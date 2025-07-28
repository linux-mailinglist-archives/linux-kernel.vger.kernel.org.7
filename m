Return-Path: <linux-kernel+bounces-747532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C969B134DC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B256B1774B3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90547220F5A;
	Mon, 28 Jul 2025 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GJa0E76B";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JdDD33Aw"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9D2222CB;
	Mon, 28 Jul 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683713; cv=fail; b=mQP97moyHuhfMRsUEB2pdOTomMdF9c9LS7fPtXeSyh+IR8l2JpGUWt8H8u5G2K8tprdjjeFEtIAJXzXg/J3FEaXiqZLntMYH58htWOBU2GVzVYsW4+HS2EdGdNvIM2aITvoTknd3RkZ8bSXlecU3Q1XhfG7JcJwVcXULb9X6FP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683713; c=relaxed/simple;
	bh=KST+frAvf3Z8RC4H50aUkDT4u5Aac/vC2vkbnU+6Nbc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ImvZuVCXtISXdWGDNPVk1gGC2fiVDhQ3bTZokD0eQdBTIlJXArJkwn/6fiDOrH1x8DBXDPtapxOnFWTecnYqMAmVEHweiYHrkpOV/IVBPAKgsbqZ4ncvFPy8en0+zNEWtPOAAdoihkdOxv9JYtJZFguYojQuL+J37/V42ZD7rQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GJa0E76B; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JdDD33Aw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2345ea9c6b7b11f08b7dc59d57013e23-20250728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KST+frAvf3Z8RC4H50aUkDT4u5Aac/vC2vkbnU+6Nbc=;
	b=GJa0E76B6mjHDbgZC2si4zH/3MB4mtpHXV2aAw29GP9wmbTSH/35P1w9jbMbg+ySHMvUMoehw4hfA/D5Wr9E/e8pyD3t43ZomEs5JsGgmVfDoVofoSyKKXBvceo7nOqXxfqiuOYaDQKLBjGm+QFsSuJswopIfc30QC6DD14C5/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:b1b98abe-6ff1-4622-9a17-a278deabb1f5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:500f5150-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2345ea9c6b7b11f08b7dc59d57013e23-20250728
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 377271868; Mon, 28 Jul 2025 14:21:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Jul 2025 14:21:43 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Jul 2025 14:21:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEUD+8sdbIe7J3Gv1jv+TEON9m4n9dqHFyRp4WUpbJoj3GZfeEseE6YB8y+xRTSrdKKtuSg8hiUIX6ft8/N9e+h2thqLgWX8dlowfbTaEDTmIwZq+h42t6FFSIGxG6TFKTuLEELqcAsrH5bwxiW+cxqXvhDk4sEou41DkliV9Pan76Tn9iLR7C23ofA+kgjZyeVZD1E1Lf9ncN2pDBzLha/WzimmAtJdUOeazVucRkDEQR7Unbl7MfcavCRThCxmo4yzdRTRxsdR5tmvPRWTReRnDSjSbjA3606vftjhzM5xwIGxQmam7SZae9qrXCtD7QSK5cAlEkJLeWpsAUJVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KST+frAvf3Z8RC4H50aUkDT4u5Aac/vC2vkbnU+6Nbc=;
 b=K+wD+WsFtMUCGH0X7pSn/XEfq+lN0NARC2UDW4QBk3cNBQVpf5+GO9J+b6zXw9Ei7WNRHSrXIkRcpzLCl76e//cA7pLb+KOA/fr1v+fj7sm4qBtIJxgy5XqozYe1QQ3+7oefI5Wc3s+vwFFNDybcGBpAF9jEZyVIx2zP5MVwsp3FRlBTxO6VHtiBN1LrX6SgJBrmCgCWVgeLoAFhbOvj9VjEUEl4Ok535UpcLO/ShrpdX11Al04By7iQTTlXBAyi2Npwi5DuZEq0oz8TA4vSnFwRHJNM5iuJ8/cT0gTV9ZNsZv3FOURHHE30iO7wg69b0RVPJegnVrSlbvALB2LAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KST+frAvf3Z8RC4H50aUkDT4u5Aac/vC2vkbnU+6Nbc=;
 b=JdDD33Aw+ZfkNUOLqhybhPXi7JPd3QwvthslrfO+y9//K3heuo+pmKVpNDqm46mDhMU/86AG3z6Sfq8n/gXdb5c8LnYdO1ziQl6xQDjJ3YU4wskF5PhRb4aeZ4BnpQIOgHaOcEbWzCzWVwc++5uOdgXYnqeUscZf4oWSOav5Q58=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SE2PPF9D8ADABD2.apcprd03.prod.outlook.com (2603:1096:108:1::49f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:21:43 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 06:21:43 +0000
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
Subject: Re: [PATCH v7 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Topic: [PATCH v7 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Index: AQHbubTHipXpEWAwxEOb0qpVK1Lb7LPCgVCAgIUbCwA=
Date: Mon, 28 Jul 2025 06:21:43 +0000
Message-ID: <649d78b90d026a3c9bca40b257e303fe5d5a4f22.camel@mediatek.com>
References: <20250430094545.23932-1-friday.yang@mediatek.com>
	 <20250430094545.23932-2-friday.yang@mediatek.com>
	 <c448ce68-16e9-41b7-a69d-e28c1043f8ae@kernel.org>
In-Reply-To: <c448ce68-16e9-41b7-a69d-e28c1043f8ae@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SE2PPF9D8ADABD2:EE_
x-ms-office365-filtering-correlation-id: 9096b1a9-5913-4350-118f-08ddcd9f0588
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YnB0UVJoRWt0cmV4VlhCcC9xWDI4aVVib2FicHpzUi9lYjI4Yk9McVUwVjFT?=
 =?utf-8?B?YXNKTGVCOFVSU3BuUUIxQ1VwUGhLd0pxS0lSUGhRcm5YWU5mRW1aQjM3Y2JP?=
 =?utf-8?B?SnFiZklQbzBqWGk4MS8xS1FnVGpqeCtweXpWMURsZlNtYUUwa2JFbk5EVFM3?=
 =?utf-8?B?Ty9BT2tyYnVPdnAvWDNDK1NxZlhyMHFOQ2RMNldBOWJXeHdjV2tJeG1mVGp5?=
 =?utf-8?B?WDJ4WVhGajE0L3lMckVta1Bac01jRGlTUGVCSUkrWTdkWVBhRmd4WmtZTERx?=
 =?utf-8?B?eTdJaVd0a29obHVZQ29wR2FRYmxqbnpCeEY3RnphaGt3ZnhzczBObXFaTW1n?=
 =?utf-8?B?akRRZXVRUHFJRStYTTJHRjYvb3UySENOWmlDYTQvM3pKdzloYzNYNm5oWVFT?=
 =?utf-8?B?ZkZON2NyTG10cGtBajBZTitJbS9nNmNyU0ZHNHBqWm10NHYwdU92MXU2RXBi?=
 =?utf-8?B?S2xVUFdpRGhrM3hOMS8xb2RYcXJyTEJHa0w3ak9sR0dCWlJlbFh5RlAxQVhX?=
 =?utf-8?B?bDFNV0NRa3hENWJrbkZSaHA1VlFzSVU3NDE1U0pTZ3Uzc2NIZEhKbUZ4eTF5?=
 =?utf-8?B?dk1qcWQvRi9QOTBuUjc4VmpDMFlKcmQ1WkZKQ1lrWG50VDYrdzFRaWxZbHd0?=
 =?utf-8?B?NXFCc01zNTN5MzBRckNPdnRWMlZkT3NZM3QyNDlnbUlDd3J5Q3JqNnI3ZnZz?=
 =?utf-8?B?NTVGZEJmOXRCQTNHbEFUZCtSemU1eitVTGUzNWVKbWZaZHN3RjlGWGJrYm0r?=
 =?utf-8?B?OVBtaXFJOFQ4dDZmTzQ5Ky93SURtVUJFTHlUUzk1emNBM0ZOQ21SakRhUTlr?=
 =?utf-8?B?UmRmNVkyRnUrZ05wb091M24rc3RtaEhCQU5uYkV4OU5Wamlmb1VWWUpRRzVk?=
 =?utf-8?B?NVA1SzNKY29FWDdydXRQdnB4NXloOWJGM0dnMjlhUzYzRTlDS2ZRZG1uQklD?=
 =?utf-8?B?cnpZdHhTRzliY3JOOTlPSHhIZWtUdEtJS0tQT2Z0RG5sU1h6SGx2Wncyb0Mx?=
 =?utf-8?B?TWFlYTJVZFMvMDdVS3FKV0dWN05Ja2RCTG0wTGpoNU9nVDZsSlJhWjYrWnBr?=
 =?utf-8?B?QkRJa3Y5Yjd6SkUrQmU4czd1YXdhVUcyeHpHcmt0TC9jT0JBRWtGbG9qK1VD?=
 =?utf-8?B?bmlKbkVSczN1NGhuNjdsU0V2OEtGL0N0KzR1aytzWmpoOGJ1M0djejdHbXUy?=
 =?utf-8?B?VTJ3d2JhdURmYmxodVgwNjFveVFyTUpGTUtmcThhbFhhZit5eUFVQnNEY3da?=
 =?utf-8?B?Mmd5SU85WWg5MlI0UnhsRzg0RUwxTHZERkkzUFlHdDBhWHRHNWhZQUgza2xq?=
 =?utf-8?B?UmtKaXVmWGJsVlkxUXo3U3I4ZUhxMEFXQnpZYVErcFpLcTdxZFROMDlSMFk0?=
 =?utf-8?B?SkllVGVKMHo0MXBrNm00V1lTMDluUi9aMTZEandKMGVBZHVvaG03Z2s3Sk85?=
 =?utf-8?B?YmtSampscS8wYXBHdUxFaWk5WVlYNmlheVVXMDRiZVRXVkI5VEdIZjY5c2xv?=
 =?utf-8?B?eDhHSEhxTmNKZDFmcjVlNGJ5NXJBejlYUXhnRXdJSXBmaWs4NE5hNnNnbzNS?=
 =?utf-8?B?cVVONXVmNExGNjRtK2s0cmczeHFpR1dYVzNpbEQva09BYkNJanpyVkU1T1Ro?=
 =?utf-8?B?RWZHeENaVnR6eWFMZmFEaHhPR3VlcXI2MndleHpaRi9kSGw0aGg1R2pFc1BZ?=
 =?utf-8?B?dHYyejdGTlVlS2ZITWJOT0F4OHNlOFVHR0phTU5GK2FDMm5FbTVhSHdzTXV1?=
 =?utf-8?B?L3Ewc3hiNkgzNURZR2t6YzRjYXgxVHNQSUhNaWRUODMxMlViNlIxSWZjTitR?=
 =?utf-8?B?YjlQY3p2LzVzRmJUZVMxM0czbjJTdmFrbGZUeUI2YTQ0VzhNVjNFV0R2SkZQ?=
 =?utf-8?B?QzVmNmFheEIwRDRWYlBIS0RwSjV4QTJjRjd6ZEJaVVE4VnVFQkl5c1k1amtn?=
 =?utf-8?B?b3krZDdnbzdCTzVHeXRWWVNmOE1wSjNiVzJ3andoZkk4KzNWWi9zdGFZM3kr?=
 =?utf-8?Q?8x3IQ+guuKzgo9258Kk+OTGRBVjjgw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRXMVFJYkcvbW1kTm0zcW9OOGtUTUlHV01RZVVPVEo4MXFRRTRuaUZSZCsw?=
 =?utf-8?B?VGk1YmNFZzFtSWpMRmJXS2hpVTh1Rm9sM0h1SjhnOGhpVXhnamxQYUlrVVZn?=
 =?utf-8?B?d1U2YWp3YmgwT3kwQjdkRS9mSkEwcEtmNm1DNlZTMlg2ajVJQTRwYkZSeFU0?=
 =?utf-8?B?OVVhNHNOK2V5cjRiSU51bklZc2ErUDZVbnpieFBlRW9mOWxhR3IyNDZhOVdE?=
 =?utf-8?B?bFdmbDkwMFJvSXZ6cnlFRDZ1TE50K1FQOENOZnhDQUNzOHJvTU9FZUhMUW5X?=
 =?utf-8?B?dDFjQlZSZmdtYVRWNHhzVXFVUmxVcmdUSVlrb1I0RlVwaGFOWUoxM2llcUNy?=
 =?utf-8?B?eEZPS2tDODFFS3ljUXFVdzdQL3hpSThsQlpFVzJEK2VWK3VoZlhmQW03TytB?=
 =?utf-8?B?SVV5a3lyNzB1V0JWUGxPUlh1VktmT0NVN080clNYOHNoSG1IeUpCOW5iWnhU?=
 =?utf-8?B?NDUwYlArRmNwNjhOQXZpeHpzUXdndmIvUVRBN1JrTUN2TVN5MlpwTklKUWFN?=
 =?utf-8?B?UTg3cHJJNnJBdmlza2xKR0FHQUIrNFNJbXNadndjL3h5M2tKM2ZoY1paMXVn?=
 =?utf-8?B?VEJ0SERZQWRBa3hoYmpQY3B6TUM4bkZiZXRHL2NoS2tEbEx4M2xwQUcrNno2?=
 =?utf-8?B?ME1vU1dkd3ovWlBiZGdsQ05iMWhhck42TEhJaUdlVmZoY0puVWQ5LzZ5WWxZ?=
 =?utf-8?B?Si9zTTF4TVRjMlVHUGt0NGpsNks2UVhvWXQ3L0pNUTIxVjhJK3RMUzZQcFJq?=
 =?utf-8?B?WmIvV3FLTjNPb2x1UW8xYjNWNHVPL0RDNlNjamFDUHAvOURrZzExcjh0ZGt4?=
 =?utf-8?B?dnpqcWN2N2lla2VFN2tiSjNxZDliT1Y4TFFUWDZNY0RxT2RlNGdOaE83bmdw?=
 =?utf-8?B?L0JESy9SL1RQQThSN3ExbW5UWURCQmlLRE9kRHJadG05c3BLSVVEbHdVZ1lB?=
 =?utf-8?B?UElacjVabENPV2RiZkZJRHZPYzNJaTFpNnFlV2VOTEs1QytJR1hrRHBtZkh3?=
 =?utf-8?B?NkdVVTdjWlNld01WKzROeEpVU0FRcmJkSFhjYmNEQy9zei93WUtnVU8rQXcv?=
 =?utf-8?B?NTRqU1crZzJqMVZ5R29TTFd3Nk5idlZaaE4zclUzUUZxN2tOZjRES0VPaUVo?=
 =?utf-8?B?TzErM2E0b0lvckw0YloxaFVCSEdUVjc1TElhVnhFSHg3cUJ2d3pDN1NQMHZT?=
 =?utf-8?B?RGtmVDRzQ28yY3MxZU00RDU2ZnBNakxCZ0IweEtJVENObm1LR040NWJxYjQ2?=
 =?utf-8?B?RFRlcVJvQnMxUFNEeVM5NVVsd0FqaEJlNnlWcCt1VStZZ09Sc1FaTTM3ZVZJ?=
 =?utf-8?B?eDg2YUJtMzZtemw2Q0lnQ1JmY3EzSllpL2RJM3V0M3liTU1QaEdOWkhWenNy?=
 =?utf-8?B?bmpJNEpyVGZzU21wRVdpZUNaMktieUVzd3lPWURhRE1FL0J2UkJzNTU1NGdH?=
 =?utf-8?B?VmdCeFpSMEgrb3dvdXRrRlRMcWMycWRsOEVnSXJXQUtRaUFMTDVDNVl2RlB3?=
 =?utf-8?B?WldYcVZ2TE9CS0lFM2xhYmxsT1lIdk9yRDZOZWw4Z0FzbUxvN1hMa0U0T2hv?=
 =?utf-8?B?TlhwcHZoYXZYY1gzMDYyUTlNa09mQ2N1VC8yRFBNb21xQ0JoVGlXanRjU01j?=
 =?utf-8?B?RGZoY0pGYWZVb2YwRFpESEF3WHliZFpXOUJydlNvZGQ2OEN1NDJ3YWdVMklI?=
 =?utf-8?B?bjErSlRSdzR5SlA1Kzg5dC9hNDNiMkszeUJFWE5Kdk4zV2UxWTVKNllaZ3Jl?=
 =?utf-8?B?NXhXZzM0dnZyZmFuc0VmS3QzbThpd0RyVmpOS1ZrN1VIOXM4R25vdEVkNmpT?=
 =?utf-8?B?bm9weHBQRlk1aWNubWhBaWI5bndFQk1URGJ6THNaWFhyZkFkb1JDMHVRNU5m?=
 =?utf-8?B?WDRwTHFrOERheHJtRERLRnFiL29XRDB0anQ2N0VZR3dXdVVENm9lNlBFU01j?=
 =?utf-8?B?cnVnYjZZdjdlaktnbWRDZDFZaTE2djAzYVk2R3k4a1pPN0VYbUJSM1pwbmlP?=
 =?utf-8?B?Qy8vL0JjYVZqR1ZONVo0dG5Idy9oaTNYV3YvVzdod2hlbHdnUWVaN25udHhX?=
 =?utf-8?B?Z1hKWjhZejJ3NjNacmlkU1ZRNjBidGhPNVpyNEtQV3hzekZreUhGRzZGZERx?=
 =?utf-8?B?QzJ0ajVQQVRwcC8wMUl5d2pTdEpncC9zK0k2eC9FUWczMGlEK1dJWjZWTTdW?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91D6B0005F17AA4AABB2E4646C68B114@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9096b1a9-5913-4350-118f-08ddcd9f0588
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 06:21:43.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLNyARSs47rl4cZkjVzrE3HiEKQegE+m1wN3SJBm+I4Hx/oARselgGFUC+6VHnxiSUXQIrq6BJl657i2m7cjQeKx7seLhtxpjX86lI+UWyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF9D8ADABD2

T24gU3VuLCAyMDI1LTA1LTA0IGF0IDE1OjQyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDMwLzA0LzIwMjUgMTE6NDUsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+IEZyb206ICJGcmlkYXkgWWFuZyIgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiANCj4gPiBBZGQgJ3Jlc2V0cycgYW5kICdyZXNldC1uYW1lcycgcHJvcGVydGllcyBmb3Ig
U01JIExBUkJzIHRvIHN1cHBvcnQNCj4gPiBTTUkgcmVzZXQgb3BlcmF0aW9ucy4NCj4gPiBPbiB0
aGUgTWVkaWFUZWsgcGxhdGZvcm0sIHNvbWUgU01JIExBUkJzIGFyZSBkaXJlY3RseSBjb25uZWN0
ZWQgdG8NCj4gPiB0aGUgU01JIENvbW1vbiwgd2hpbGUgb3RoZXJzIGFyZSBjb25uZWN0ZWQgdG8g
dGhlIFNNSSBTdWItQ29tbW9uLA0KPiA+IHdoaWNoIGluIHR1cm4gaXMgY29ubmVjdGVkIHRvIHRo
ZSBTTUkgQ29tbW9uLiBUaGUgaGFyZHdhcmUgYmxvY2sNCj4gPiBkaWFncmFtIGNhbiBiZSBkZXNj
cmliZWQgYXMgZm9sbG93cy4NCj4gPiANCj4gPiAgICAgICAgICAgICAgU01JLUNvbW1vbihTbWFy
dCBNdWx0aW1lZGlhIEludGVyZmFjZSBDb21tb24pDQo+ID4gICAgICAgICAgICAgICAgICB8DQo+
ID4gICAgICAgICAgKy0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+ICAg
ICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAg
ICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgfCAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICB8ICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgIGxhcmIwICAgICAgIFNNSS1TdWIt
Q29tbW9uMCAgICAgU01JLVN1Yi1Db21tb24xDQo+ID4gICAgICAgICAgICAgICAgICAgIHwgICAg
ICB8ICAgICB8ICAgICAgfCAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgbGFy
YjEgIGxhcmIyIGxhcmIzICBsYXJiNyAgICAgICBsYXJiOQ0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEZyaWRheSBZYW5nIDxmcmlkYXkueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5
OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhhdCdzIG5v
dCBwb3NzaWJsZS4gT3RoZXJ3aXNlIGV4cGxhaW4gbWUgaG93IGRvIHlvdSB0ZXN0IGJpbmRpbmdz
DQo+IChhbmQNCj4gdXNpbmcgc3RhdGljIGNoZWNrZXJzIGlzIG5vdCB0ZXN0aW5nKS4NCj4gDQo+
IA0KDQpZb3UgYXJlIHJpZ2h0LCBJIGp1c3QgdXNlZCBzdGF0aWMgY2hlY2sgc2NyaXB0cyB0byB0
ZXN0IHRoaXMgcGF0Y2ggb24NCm15IGxvY2FsIHNlcnZlci4gSSB3aWxsIHJlbW92ZSB0aGlzIHRh
ZyBpbiB0aGUgbmV3IHZlcnNpb24uDQoNCj4gPiBSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQo+IA0KPiBXaGVyZT8gUHJvdmlkZSBsb3JlIGxpbmsuIFRoYXQncyBh
IHY3IHNvIEkgZXhwZWN0IGFsbCB5b3VyIHdvcmsgdG8gYmUNCj4gZG9uZSBwdWJsaWMuDQo+IA0K
PiANCg0KVGhpcyB0YWcgc2hvdWxkIGJlIHJlbW92ZWQgdG9vLiBIZSBqdXN0IHJldmlld2VkIHRo
aXMgcGF0Y2ggaW4gb3VyDQppbnRlcm5hbCBnZXJyaXQgYW5kIGRpZCBub3QgcmVwbHkgaW4gdGhl
IHB1YmxpYyB3YXkuDQpBcG9sb2d5IGZvciB0aGUgbWlzcy4NCg0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0K

