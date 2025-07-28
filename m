Return-Path: <linux-kernel+bounces-747392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA1DB13344
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5488E175436
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F101F9F47;
	Mon, 28 Jul 2025 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GOIz/NH/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Crxkxf4k"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9B4BE46;
	Mon, 28 Jul 2025 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671582; cv=fail; b=sXHdWrgV9Ee5w7UKRz96StdHp3+5V9gdTGfiGmCIio6G56/j34OPuaiRgQ1PfarucEH0wr/9k6jgGDEREz5IAokTFGHhO+rlHG7+7Ca8OyGOASKN4pn06Ack7958iH4dBdCmtoXYixi00EJtfVNdc1Mg7I9VkVGZtwjTZDICzsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671582; c=relaxed/simple;
	bh=OY1qwHt+Rul0BnupGJ2pTNhxz4AYuKMvOjWL/41jjns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QmgqqyeQCZhZYW5auO1utBBGiXfwEX5h3uHbrvu7YoUmfgLeRio7FQFxX9Z1clnqKHonWSWjYrqd0do4qe8Ya7+fXTFvRfioDiWRnpX1WvU4pYl/YDrKBXOlR+JmuHPsclZvkrnbmP/ZNM+TrFMDlRvQsdPxHYfgU72Pj5NB+cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GOIz/NH/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Crxkxf4k; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e297d86e6b5e11f0b33aeb1e7f16c2b6-20250728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OY1qwHt+Rul0BnupGJ2pTNhxz4AYuKMvOjWL/41jjns=;
	b=GOIz/NH/3INan0N1XbGFoFUKo+ZlbfAwlDhHg9KXXDBDbOhQIquJuFZQ/LnMgP+FV76J+01/baSar51zlorYGBkj6XGnkbr5ZoH9Y2CIx7oJkZjVijHCDeAASVPQLBI/UZGmxH6SRNIkd5sOoFB/dAPcAHjtOwXHgXJREw3fTxM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:19a6d6c7-0c5a-480b-9e0b-8beb614e58db,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:2c69549a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
	COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e297d86e6b5e11f0b33aeb1e7f16c2b6-20250728
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 166176089; Mon, 28 Jul 2025 10:59:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Jul 2025 10:59:28 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Jul 2025 10:59:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1q3GBWJpQ2eUvlgPA3WHGWpDjekD18FCJ1BN8P0I30qShLlc+RPW7e4KkBVuRj/Ofkxs5WtL/nBE/y0uN/MGKh0DBmLOpCwt4pft9C/Fe+orKq2zZKbgRNuNrNqJ/jFAuCm6Cd6de4YL/U43S6ZwO8RTbC1lCrvyQe0/wAWHXQvjdjtphP881NJKiZnL6eJGkL87bDAKDW4tLgdbQZBFcCLnZmG2hzgBezu2B4+ToqAs02qjZgiD+N2L9zkKdqdAx5gVeeBhKfzTcibBI87Y0O0hHQTyWy8PunDVYKabCcfFBQ05FB0l4tjOta5rIcTQX5I1krARq85U+z9VdECgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY1qwHt+Rul0BnupGJ2pTNhxz4AYuKMvOjWL/41jjns=;
 b=rQzR4MO2lWQxQIhAzXx3Q4IPY8A8hefdNqLyPbPIKenqKtbNCjCoaUu2cdLmgHlVsYaODiurCWWtv5vn5hJPd6969JCYPQ+rkr9XnwScC3zRYUVvgGxGlqgUTeisrqK2yrsoyXZ+u7SjZgM3/tdYuElSeDVhU7byJNnTGGnU4biHZDB5TzxqeidQ0mRD94niK9Yn4Gc+QomXYszahILz4uV4NL6dJ7JmQoaJIPdIkoogSOsYAAuC10ZBqXxaJbtKVlrOYeP1OyumzZlEXTkCwSN4NOnWzc9ubUslTlh1BgwWR1jBJPc1FeO6Gz6oMpuOXxkvH6tzO9BSPjdXQ+qD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY1qwHt+Rul0BnupGJ2pTNhxz4AYuKMvOjWL/41jjns=;
 b=Crxkxf4kL3AbU4Ns8GMabrmu12tFpS/hKEVpo5PXo9ZEwEM5pIEzHN4RZeM3uJVgPVeiLjOiQltqlwn8sMatdlczcfnK4pEVXZHnrfSwjquw7m2/XLSKTQ8HmqRX7MgseIAe1/D+Q48cheqZDoKkaPCB+AZjRcOEiFQwRrxxDQ4=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEZPR03MB7418.apcprd03.prod.outlook.com (2603:1096:101:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 02:59:24 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:59:24 +0000
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
Thread-Index: AQHbyhpymjbAswZs7UKlfaymlOtvZLP/xc+AgEEgbgCAAFkbgIAADkuAgAACvwCAAAmOAIAAA0OAgAXl1AA=
Date: Mon, 28 Jul 2025 02:59:23 +0000
Message-ID: <7e390b85e1ba6362ffa0231faefc0ea63a922639.camel@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
	 <20250521063347.31578-3-friday.yang@mediatek.com>
	 <fe4d93d1-fb6a-4985-8316-7a76fa1a481f@kernel.org>
	 <7421d8f4f3d5fdb392f46df93bfee21a97cc2e1c.camel@mediatek.com>
	 <633ea291-2e02-44be-bd03-220634b3c62d@kernel.org>
	 <d7e6e9f9da7adf5c806f29c577f6bf51b35fdeed.camel@mediatek.com>
	 <1e9de035-9d32-45d1-9f11-33c3439143be@kernel.org>
	 <2cc7a0be13d2b35b8728fb23e56097620a40fc05.camel@mediatek.com>
	 <03dece78-44d5-4b85-b71c-bb6794849ddd@kernel.org>
In-Reply-To: <03dece78-44d5-4b85-b71c-bb6794849ddd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEZPR03MB7418:EE_
x-ms-office365-filtering-correlation-id: 1a09b275-f5dc-4363-c0fe-08ddcd82c207
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U09MbGNRK09yUXhGOVlTUVRjNGVBMEZKMWNHcHVzN3MxWmU1Q0R3WW1mTGdZ?=
 =?utf-8?B?a01ydjlMeFJIaThwUlAwWGhia2tiVGhUMW9Gb1M0bzdySUNrekl0ZThWOUNu?=
 =?utf-8?B?NXBKYUFFdUhnYWRsWEhjaURaZk1DQVQxcm9FUUpSTDFBM2JPU2o2c2pUZ1dm?=
 =?utf-8?B?b3hSNFNHTG5tWFIvSklWOFhnRmV6SXRjVFQzZHVnRDh5SG9LZHRNa1plZUJa?=
 =?utf-8?B?N2VpeWNQTGt4ZVN2aVZLQ1BrNmltQmg2c0lXc0RNdUJGcVZFbW52ZDVmeDNs?=
 =?utf-8?B?Um5hV1RDVXFBajNvYzRCTXVLd1R4NmQxeXlCYlJNb2xGOGcxR0FTbjVCWWRM?=
 =?utf-8?B?UVgwRmhkbnVSZXMrcERMeVJhTHRDNjIydUNackRnczRIZk5LaTE0b2p6bWp4?=
 =?utf-8?B?K2hPK1NSVVJxRHFjZzFCQ2pTcnZoUUNIOTl6czZqRzViYko0QU1iOTZiNWdn?=
 =?utf-8?B?K21MeXF4NEloUnhiYmphazhiWnAwRXo3Z1VjY2kwRVIyR1Qvd2VVOXJVeHh1?=
 =?utf-8?B?djlRcVYyMVdsUUhleUtCS0dpRHVNQWh1WHhnYklraVJ0MTByU0dwOG1MbUwv?=
 =?utf-8?B?d3o0aE0vZlhxYlF0RE9YRXhIMVhxU0VBcjFoNE8vRUFVZWhNU1laRVB1QzZv?=
 =?utf-8?B?MG81ckwyQTB5NDZHdDNzWFkvaWw0ZmN1REt2OGdtbzFSSktSVU5LWU5xUFBw?=
 =?utf-8?B?KzRzbFBCRzdXVVpVY2tSRGhyKzl4S0duQkI0VzFqalhOZWZPbnczaURiMHBw?=
 =?utf-8?B?eFdmS2VKOEJsalNUdDJPZlZFM0FWbFhXTkxPOE54ZDZ2Z2NYZ1E0dkFsb0dH?=
 =?utf-8?B?dFBTaGgvMmFZb2U5QkJnSFFXcUVjcmlWcHZqUlBVNnI5VjlmSlFydm9ndk1h?=
 =?utf-8?B?VHpuUjhsWkJ4Wk9SMWZoeVRHTGtiL0xUVUtQMnlBWkNrbHFlSHFrK09GQ0I0?=
 =?utf-8?B?ZGtZWERsQkxqRjFnakxjMkpBTlRBZ0dKcDlLVm5zTU9EN2JBQjB4M2tzMUVq?=
 =?utf-8?B?SWg1c3BvZWcwVWU3cHNHcTAvVHBoYUMvQThjejVzVGp3RElZSzAzRmxNSzJB?=
 =?utf-8?B?b0FIb2Q3WndXSFBQWmwxYlNQQmFMaUVvdHNNZ1Qzc0x4emlwRm1oSUtFTU8r?=
 =?utf-8?B?QU1pU1NNYXU2cVpHS0lOMStoWStZekFSUktidks2MlU3WGJCOHlNaURGY0tl?=
 =?utf-8?B?YktqK1V2VW4zYWJyOUtxWWRtbS80V2JEMXZDd0U5ZmdrT2YxRXpjK3dwbFkv?=
 =?utf-8?B?OUtLOE1zaEkvb3ZJajB2RHcvVUwycktFRThzZDY4aFpDTjRpZFJnYzNUcG1m?=
 =?utf-8?B?eWJnNitjT2hDdWJPeExSU1V0eTlKOGNxcGd4blFRUi9mZUJ5OHoxRDhKOEdE?=
 =?utf-8?B?eEZIQXdGckQ1WnNrWGpOeVNNejUxOTNnYnJ3YkpFY3ltV1oxemFyZTBOWVhP?=
 =?utf-8?B?T25xNkFiaTFpM01qR01zWlBPOWRRWmlJdmp3UVhNcGVndjBMNkN0M3FuV2hW?=
 =?utf-8?B?UlVxV08vcUpDeHhBUkpXSWVOcmF1dEtRZHI3djBMYXF3MW5IN2dPUzcxV1dI?=
 =?utf-8?B?OHJ4VVNFTVZONFg4ZDhCdVluQ0swbGhnK3doSGN2R29aV1JyRnJSS1lVdkU3?=
 =?utf-8?B?bk44R0NBSkJnQlprVnNkV0c2MlJkRkJQd2J5MGZMSEY3QTN4WTVjK25uMG9o?=
 =?utf-8?B?dzRxTTdiVUpybWV3OE44cEZHeFNSRVlSbTRMOW5OU3c1VVI0OTRUZDVrL3lm?=
 =?utf-8?B?OHo0MGVoWGR2SWNwRm0rRFdGK1RPR2M0cHoyY1dEcGdabXVtYysrSUtVUE5k?=
 =?utf-8?B?Q3BTWmJoTmdwem85eEM1UUFXUmdIRnhablgzYnlia21ST2EzeHlhL3o5Tnll?=
 =?utf-8?B?aENmYS9Vb3lXcHFPNVBkaUUwSGhtUTRoeXZNZXE2ZEN5bFNnUmpKOFRDNjc2?=
 =?utf-8?B?OWZodmJvMlVmeGZ5UGFacTcwQmFUR0Uvd09jd0xSUklncDlDL1pVSUljMjM1?=
 =?utf-8?Q?QMB2e+YrFoCpFzuty1YPDo1tAQ0O7c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTRWOW5mV2loaWlZcE1MSk42eWE2T1ZHdmhVZ3pDOElDOHdPZ05Pa295bkF2?=
 =?utf-8?B?MGlaZ1U4MTUrRk1NYzlaZzdPVGJDZlVYb0lnMGtIRURXMnJwSnQvOUZTb25t?=
 =?utf-8?B?SzJlL0pTTmoyaGpzRHNMeTUyWXYyWFRseHArWnBUVmNGMW0wRlBkYVVHNitX?=
 =?utf-8?B?ZjE5K3lzTldJcmpBdm1xblc0QmEzUzF3YmNBaUk5c1BUc1FBaTJyWWJwRU1Y?=
 =?utf-8?B?S1hkWHNtRkFyWHJxclE1TEdScWdHa1QxdzZnd0htT0FUbzVIaFBmRWxrazZQ?=
 =?utf-8?B?Y0I3QjRPUFNFM3BTRDFGcDdOOEF3VnE3ajZNR2ZhSHhQVnc3L0lBK2ZDNXAy?=
 =?utf-8?B?elJqdTdzQ2dVQU9PS0J6dnhnWmsvcFN1WlB0WVdEN2l6S24wcHc0em1WWmdz?=
 =?utf-8?B?VThnelBXRmNQZXY1UmgxR05jN2RCMHhKMlNDYlNFdmNrSUs0dEw3cURiVWVC?=
 =?utf-8?B?cERzNlJkSi96cXo5aW90aVFVZWlyOVM5ci83K0FHdm0rNW1HcXhtRkIzSDVG?=
 =?utf-8?B?aWtqM0laZjhhYkMyeEZzK2l1a0l0dzl6U3o4WFEyMU1MMURGTVpXQ3VuUUR6?=
 =?utf-8?B?NWRkL3kzeDd2SUZyTEdObzkxRXJmUldsMXFXZGF0TmpjUTJKQ2FnN0hRNnN6?=
 =?utf-8?B?N3NPVHlyajJSaERXWGJ5MEtjWTlXVnIzM2IyaVZJM1pMdUMvcTB0djcwZWky?=
 =?utf-8?B?eTJHYzA0Sm9XUnUxdnhZY0xEV2VXZE1NOUpvb1BBWk5jYUwxZitEdmtrUWxy?=
 =?utf-8?B?ZFZISnkwSmlrY1ZtSHdveXo4Vm5XTkp1cjBsNVdmTG9PM0JqbEZOUlhMNUtn?=
 =?utf-8?B?L0lOSmFITmhKaCtoMFB2TVFiMWxnRXM2M2p1Zm5IRFNYeDFaRVhMUnZBSVB2?=
 =?utf-8?B?OS94OXU0Q01nSGduWElzRlZsaXBCWjJEdS8yUU5LMkpSWHJhbCs5emw0dm50?=
 =?utf-8?B?aXE4dTdDdmxxbjNyNDY2STREOGhrQzRtQjJMcG9xSCs2RlJnNFM4OUR5bVpv?=
 =?utf-8?B?WElTTWNFaU1ILzZ0ODhKTis2ZllTdHBnVWZ6VHFUK05rUTZ6b1hZZEFJUy9T?=
 =?utf-8?B?QS9YWVlhRmVHWmt0MmMzaEw1aXl0c2tiU3JBOGo4ekRrM0RESnRrbmhaNVRE?=
 =?utf-8?B?S29sclAxTUZwQVpHVFpISFZNT2prQ0J5Yll3VHJ3bnduTDNzTm0wRWRmRWVo?=
 =?utf-8?B?Vnd2djFWUU9QUENlbzUveG9udWdnMWNkNXg3OUdaTVhCSTdvUVBybjlIaWdu?=
 =?utf-8?B?UzRHN1NuZUNyckdXWENOSStPekwxMTZBNVhocVJyUEs0MDkrR1hLclkrV1M3?=
 =?utf-8?B?WmVPN0YyZzVqNXd5SFRtRjhPRWNEODdpcGVwcmxCOGNITFBXSXRsNW9DbjBr?=
 =?utf-8?B?TjVyZitzNGdYN3ZGLzFSYVJueXpmOFdySXJRdmVWVGRFZ2N6NGYyL2pKR2E4?=
 =?utf-8?B?TTBxWDcwaTZUQktLSVhXYVVrekYreFZLaXBTYjRBL1U5R0FyQlNHZFRvckRP?=
 =?utf-8?B?QzlzdHQyZ2s3ZnNkcENkektJREJTZDJnb2IwRGNaVEpRK09Hbzh4bUw5YlNY?=
 =?utf-8?B?VW9lRzBvNHlpaUdlYmVyS2Q3VGtOWUdiZzVyZzZSdWNHYnE1TTNIZGFISldP?=
 =?utf-8?B?WDBLa0d5anZpT2tiS3B5SnNWcW52OHVrb0pGR1luUmkxQ09qT1dpdER5VTRa?=
 =?utf-8?B?bm9Uc2pXQmljOC96Unh5TCt1ZXJ4MkZQemlkb2VnSmNDWlhLTjNHa2VOa2t4?=
 =?utf-8?B?S3ZJMTZRQzJrL29EaVJyOFA3TXZZUVFqdmNZa3RuZ2duMTJOek5uNHNzZnBZ?=
 =?utf-8?B?NlpQYmhKTTF5VHVvWUR6VVFQaERGREdNOVhhT21teHREQVI3YVJrMmJ3RUtJ?=
 =?utf-8?B?STY1eUdNaFVOa0ZmV0VWWjlFQWlQUThWSm42L2NDS3J1R0NWS3FxaUp3M3BG?=
 =?utf-8?B?b0tRUlVFZVZkcVIvdnlUVjZpa2dGM0pzejQ2K2x4U21ySjR0V0JIQlFocTc2?=
 =?utf-8?B?anRiSkxJa2ZkS2FjU1ljaG43UGF6b2V1L3psUkpwQ2tQRW03VDZGT3UrOUV1?=
 =?utf-8?B?cGJ3VDNDT1RsQ1hFSWQ4Y1ZzQzFBdTVwbk5tS1ozNUx6UC94bEVML3dqdzhQ?=
 =?utf-8?B?aGlpdys5VFdwSXpZWFRpVk1ZbXhwZXNnMjVUdFZpTnVncE8ydmZuYXhCdzVN?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B728145B8175A845B7C8D2DA06AC9540@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a09b275-f5dc-4363-c0fe-08ddcd82c207
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 02:59:24.0940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbuYqkWNV0pUjs0IWMnx3OX1L9mR8bnHru1fC/OzGR0SXulV1TUvJcfZVzdc7tGG0/yzcGsGbJXEfUY/Eh5LGgZ9SkpFdj/kle0A1dMk/+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7418

T24gVGh1LCAyMDI1LTA3LTI0IGF0IDEwOjU1ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI0LzA3LzIwMjUgMTA6NDMsIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IGlnbm9yZSB0aGlzIHRhZy4gV2hhdCBJIGlu
dGVuZGVkIHRvIGV4cGxhaW4gaGVyZSB3YXMgdGhhdCBJDQo+ID4gPiA+IGRlY2lkZWQNCj4gPiA+
ID4gbm90DQo+ID4gPiA+IHRvIHVzZSAnZGV2bV9wbV9ydW50aW1lX2VuYWJsZScgdG8gcmVwbGFj
ZSAncG1fcnVudGltZV9lbmFibGUnDQo+ID4gPiA+IGZ1bmN0aW9ucy4gVW5mb3J0dW5hdGVseSwg
dGhlIGZha2UgdGFnIGRpZG4ndCBleHBsYWluIHRoaXMNCj4gPiA+ID4gY2xlYXJseQ0KPiA+ID4g
PiBpbg0KPiA+ID4gPiB0aGUgY2hhbmdlbG9nLCB3aGljaCB3YXMgbXkgZmF1bHQuIFRvIGFkZHJl
c3MgdGhpcywgSSB1cGRhdGVkDQo+ID4gPiA+IHBhdGNoc2V0DQo+ID4gPiA+IHY4IHRvIGluY2x1
ZGUgYW4gZXhwbGFuYXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBwYXRjaHNldCB2NiwgSSBy
ZXBsYWNlZCAncG1fcnVudGltZV9lbmFibGUnIHdpdGgNCj4gPiA+ID4gJ2Rldm1fcG1fcnVudGlt
ZV9lbmFibGUnLiBIb3dldmVyLCBpbiBwYXRjaHNldCB2OCwgSSByZXZlcnRlZA0KPiA+ID4gPiB0
aGlzDQo+ID4gPiA+IGNoYW5nZSBhbmQgaW5jbHVkZWQgdGhlIHJlYXNvbiBmb3IgdGhpcyBkZWNp
c2lvbiBpbiB0aGUNCj4gPiA+ID4gY2hhbmdlbG9nLg0KPiA+ID4gPiBBcG9sb2dpemUgZm9yIHRo
ZSBkZWxheSBhbmQgdGhlIHRyb3VibGUgYWdhaW4uDQo+ID4gPiANCj4gPiA+IE5vdGhpbmcgYWJv
dmUgaXMgcmVsYXRlZCB0byBteSBxdWVzdGlvbiBhYm91dCB0aGUNCj4gPiA+IGZha2UvaW52ZW50
ZWQvcXVlc3Rpb25lZCB0YWcuDQo+ID4gPiANCj4gPiANCj4gPiBJIGdvdCB5b3VyIHBvaW50LCB5
b3UgcmVmZXIgdG8gdGhlICdyZXZpZXdlZC1ieScgYW5kICdhY2tlZC1ieScgdGFnDQo+ID4gaW4N
Cj4gPiB0aGlzIHBhdGNoLg0KPiA+IFRoZXNlIGFyZSB0aGUgdGFncyBmcm9tIHR3byByZXZpZXdl
cnMuDQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzE3NDE3MjM2MTM3
OC40NDY1MC4xNTM0NTIwMjA0Mjc4MDM4MzMyNi5yb2JoQGtlcm5lbC5vcmcvDQo+IA0KPiANCj4g
WW91IGFyZSByZWFsbHkgbm90IHJlc3BvbmRpbmcgdG8gbXkgaW5pdGlhbCBjb21tZW50cyBhbmQg
a2VlcA0KPiBkcmFnZ2luZw0KPiB0aGlzIGRpc2N1c3Npb24gaW4gc29tZSBjb25mdXNlZCBkaXJl
Y3Rpb25zLiBEbyB3ZSB0YWxrIGhlcmUgYWJvdXQNCj4gdGhhdA0KPiBwYXRjaD8gTm8uDQo+IA0K
DQpJIHVuZGVyc3RhbmQgd2hhdCB5b3UncmUgcmVmZXJyaW5nIHRvLiBGb3IgdGhlICdkdC1iaW5k
aW5nJyBwYXRjaCwgSQ0KY2FuIGtlZXAgdGhlIHRhZ3MuIEhvd2V2ZXIsIGZvciB0aGUgJ3NtaSBk
cml2ZXInIHBhdGNoLCBJIHNob3VsZCByZW1vdmUNCnRoZSB0YWdzIGJlY2F1c2UgdGhlcmUgd2Fz
IGEgY2hhbmdlIGFmdGVyIHY2Lg0KSSB3aWxsIHVwZGF0ZSB2OSBzb29uLiBUaGFuayB5b3UhDQoN
Cg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

