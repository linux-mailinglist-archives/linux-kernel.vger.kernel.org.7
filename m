Return-Path: <linux-kernel+bounces-849971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D2DBD1813
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2BD4E6474
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CBE2DE71E;
	Mon, 13 Oct 2025 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QBzP4fwY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mLLDTbEQ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188A2D7DD0;
	Mon, 13 Oct 2025 05:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334511; cv=fail; b=HLr7JTcxS4JIfClYV4A4hGGh+bJXNzHvX9tGhDUgUW1U4sEAjj9q9ejq5+hRxECX4a/JyhEP70nrdtkR7rFsn792B7hIVUrJh8paYP4aDQ7SLhW4ceToe/ZQQBwxX4c03Ee05K5SIPlcqYK9MqvgkvHuRT7JYHMxgfL8PIU9hVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334511; c=relaxed/simple;
	bh=CGAw857/LDV5ucFJz0MwwRpo+O9xrrO6BRP+fzzn8fs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lJTv6pc30iqUxr0Gv6IrMFML6wxy29xrwbmBs+xfRES7305NDZjiRBWUwUvcpg3bpbpL4dO5IzEwz9wkCA4F8VV7WLWx/ocV1V4EHKc+do5eSfsk/ByxIvROdlTA+TdCiw+bY9JwbuChIRKAlQ4cTzyOy4HIKn7QVGsmyY9cOQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QBzP4fwY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mLLDTbEQ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3b902018a7f811f0b33aeb1e7f16c2b6-20251013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CGAw857/LDV5ucFJz0MwwRpo+O9xrrO6BRP+fzzn8fs=;
	b=QBzP4fwYnuhy+CZkFzgpzugHkCcez6gjr1bTRuT2sj6A8Xn+dSzHc9osTmnnaLFKJqUMdvyLfbHprfpiE6HTGPCZ2ddCy/vJnmqN47V59jdvw0Yng5Ozgu4nX2VuKT9isSGw2VxnkHBmS6Z8LXqJiEUlY9rx9oYzH026mXCOxik=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:4c5fbebf-22b3-43b0-9283-7a54599a6695,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5c205102-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b902018a7f811f0b33aeb1e7f16c2b6-20251013
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1318710295; Mon, 13 Oct 2025 13:48:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 13 Oct 2025 13:48:20 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 13 Oct 2025 13:48:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPkYfU/xewOTkw6azVjzSZ8fuFW2fmzznqut/zt0ObfLPzMtGChtx/ABQuQndrPYDIOdAmbOP/toleUyJjObNq8eR7uUcrTxfxoCSv8pbmVqrrFwuqxjXiUJinzjYZ/z6qu9h44JyPHcl+RZnVz0WRm1MNI6uG7vpjo07PML8AJhCAxferEJFJODvdYSKwDf8/wrEsyoQ442MfJrgGGBRN1zrJ+2g+9gjt+MkuiRCwc5OnZhoMmsh70gQmi+7AK28ZcAbxQDZPojjo5C6yzH0KScbuyvJo+AVEwF8IsEjy2fQrzHSCIhkJrLujSeBuoSQ1prIu+4XzL2zzkfXqswSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGAw857/LDV5ucFJz0MwwRpo+O9xrrO6BRP+fzzn8fs=;
 b=T8O98CQFDUkK6HoZnmh+VO8Gmzpmdae5RqQjM8KPckNM0Z3zSK+K4H/BKLkNDgay+ptBkC9YirLQ4AElLOYlUmONhUFIxIx+sfHrqQV+r9fzE5xG1hGbH2qULQNw1Z/3HsoqUGmxAOlO58i88xlylG81pGFzohNbiN7akP8e4TyjdDm8BlNHfHESw3jsz/m6o/QzgRuNf4wyXqFd75WNaX51V/DHiHiPiS0082wNeWVOpnWij+RNDwq7+K+V6d/2F6fAV3DOcnZNEoAObHKCpPNrEMQ4XAIb7DUJQPB4aMgT+6X/yVAFk2dFMuhA0Y4u4N0xq3RwlB7efZ+ViAiKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGAw857/LDV5ucFJz0MwwRpo+O9xrrO6BRP+fzzn8fs=;
 b=mLLDTbEQMmgMM7qolLrgxG3Rk1M0JN+jisZ8Hs1U236MLkCPr4mVnr/aLFMlOvZ9Xm9z5reeYm7ULhlx+lJNvBEmgwaGpStD8FfGoC6Dn+Zi/aBDauECoHiafhGhA8gINFnSRCCbGAfMk4yRPxmN6YNkasDMByzFr+9pGARYu50=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TY0PR03MB6534.apcprd03.prod.outlook.com (2603:1096:400:21e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:48:19 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:48:19 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "wenst@chromium.org" <wenst@chromium.org>, "krzk@kernel.org"
	<krzk@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Thread-Topic: [PATCH v8 1/2] dt-bindings: mailbox: mediatek,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Thread-Index: AQHcOcazFbdUoMD+aUWITgR7vSbs3LS8g1yAgAFRmICAAcFwgA==
Date: Mon, 13 Oct 2025 05:48:19 +0000
Message-ID: <537f3b828c3e296b80c529438f7600fd12993484.camel@mediatek.com>
References: <20251010091549.21325-1-jjian.zhou@mediatek.com>
	 <20251010091549.21325-2-jjian.zhou@mediatek.com>
	 <9a7d9264fe4914ce58031e08710dfd2453678653.camel@mediatek.com>
	 <50eb3618-4ce0-44b4-91fb-561207fe7554@kernel.org>
In-Reply-To: <50eb3618-4ce0-44b4-91fb-561207fe7554@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TY0PR03MB6534:EE_
x-ms-office365-filtering-correlation-id: fc8508d1-1add-462e-98a9-08de0a1c1cc8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Tnlrc1hkOG1lS0NRbUx6Q1c2enBUZ0Z6alk4NU9DdDMwNE1CVWVNRk0yaCt4?=
 =?utf-8?B?eE9FM0NwQ2FmSTV6V1JlcCs1NlhYRTlLRklCdFV0Qm82Y1piV1dlRFB5NWpH?=
 =?utf-8?B?TmsxT0xqV3Q0SVErdU1IcldoRytNZGFjUDhLeTFrMWcrb0p0emVkcjhZY3hF?=
 =?utf-8?B?TlV6RnRxTmZEeWZFaFNQb2s3RCtOTjM0dEtjWlR3aVhqTkNyYThsN2RSeWFF?=
 =?utf-8?B?ZXZIWWJWSDdpSEw3R0R6cGtWR3ZuQlJSWTBibElrN1dJbEJMS1lER0dkTEtp?=
 =?utf-8?B?K1lvb2RnU0toY0ZsRlhtbGxlU2FaRmlkSGVicFZLcnlFQVRhUHpHdHErWG91?=
 =?utf-8?B?R0FidGhzTEpXRlpqQXpKbUdDRDBRbW1YN2dGSTBaSE05S0Y5aWdKYzNDbU9s?=
 =?utf-8?B?L2Qrb0VDWjRMN0VidWF2Q0ZuWUlwR1l2RTljMktWMjFxM2xPWDdlUW12SUpR?=
 =?utf-8?B?bldnLzBha2ROT2QvR3lSdGk5TlNLT1pvZWNZVCt6VVBvYW4vbVA2SUdlQWpD?=
 =?utf-8?B?RXR6WGpLWnhEYXFhdkVMK1BIdGpzRlNERDRZYUV1SlBKaS80WHR0VGxuQndi?=
 =?utf-8?B?UmxzaTdiUFFYWk5IUHB3Mzc0dG9vbUVjQjlMVTh4WGtBZlVNazF4YVduZEt4?=
 =?utf-8?B?TmlSdktDSCtQOFhpVU5MT1o2L3lzRWEzcGk5VWlVL2hpZ2d2Q3ZRK2M0dUJu?=
 =?utf-8?B?RDlyM0QzRE4wSGVIVlluM0VSaWtVbFIyamZSOGNWcjAzcnluamNmTU1nRWl4?=
 =?utf-8?B?cVBnWlNac24rOWltUUxjM0FtenRGdG4zckZBQ01mdVIxRElLazRWcXU4K25v?=
 =?utf-8?B?QTl3MFFtRXJYUytkWmJ0RUxSS2NNM0I2QkducThGVTdnbzdzZHFacXhKSVE1?=
 =?utf-8?B?NHloY3ZTT2k3UzhUMEJ2bWdDS0toQ3hoWjBTempMSXdjS0wrbjd6NGhaMXJ5?=
 =?utf-8?B?Z1dJNFJnM3o2eXlZRmgvcFc0TFVnQm1KMUN5UUU2SE8reHpGMW83RURESFps?=
 =?utf-8?B?QjBSUHBUZUQvM1lqMDJ4MGt6Q0pCMWlyNHM2dnhucnpYMUtzdTdBM1RKZTZU?=
 =?utf-8?B?eXJJMjlHdUZWenBUVXEzRThaR2FqU3NCUFRRUjR2enVqTE01WGhkYUVxbWEz?=
 =?utf-8?B?bDYvOTg2VFVVOTlnNXI5WWR4Z0RwT2J2eWRZWC92SzE3QUJZZnNENU5OQUto?=
 =?utf-8?B?a2UwOWxLVWtqMTE3aEM5M1JmQU05bEJtMEhEcHhwNm4ySFZXcU1DOTFRNTNj?=
 =?utf-8?B?T3BCZWFER2JpcWtXd20rMTh2RUZIazhnM1RqQ2J1RUVXQ0dlRUprczd3WXB2?=
 =?utf-8?B?YXE2N2lldndTMDZmeDZ5Q3Y5SEZqMjZlUlBFZTRTaVd0UjUwekdhZXgvSWZZ?=
 =?utf-8?B?bGpic1lNbEFzQk1ZYXVJL2tqTmsrQlZkdGNTRTAvU0lNK0lmbDBVazJSZWpk?=
 =?utf-8?B?VWhYSlJqMlFxQWFDZmJ4U1VOV0JDK2xwZzl3L0JjME9LR1p3TSt3SEN6ZnZs?=
 =?utf-8?B?RGxXZTlPVnE1akZTTzd6MlFIa1ZKSmNESXFpcEcxeFRvU0gzK1g0emROYjBT?=
 =?utf-8?B?SWdxUjRtLzV5TG9lVkQxM3psTWRKdXZEa1N2cUN4Zno1RDdwMldtWS9YVys4?=
 =?utf-8?B?WDdjaldBblI0Y3JaL2xoYTh5U0NNdU5odjlJZDZhSjB0TWlaU01qc3c5dHYy?=
 =?utf-8?B?VlNBOWJodUU3NnFtWXk2Z283dHBaMjJlUzVMVzBqWlJabi9Fem5BbS9YdW11?=
 =?utf-8?B?bU5FVFcxbGc4bnVZWmhTYWtjNG1PL0FnK3ZtVENZWG9RQU9ENTNCRmJVbUMw?=
 =?utf-8?B?Ty9JenAwRzZiRlo3SXFjNnF5ODV2RGNZTmFCWFRkdTlrUkx0VWdCNEJZajZZ?=
 =?utf-8?B?bkI5cENUWmlMRzdvQnNlK3IwSFBFejJBNzBvWVg0T1V6QVluTmRCbVVGQ0NG?=
 =?utf-8?B?dlNOTkplWHE1N2F4bE1LanlRbW5sRForakhleXJxUWNtb3B4RGRWdmdITThM?=
 =?utf-8?B?eVdYTGNaQTdMOEhmT3NZa0FFYVFieW83azk4dFo4dVNwSnNndEF6UGFES2lk?=
 =?utf-8?Q?vsbn2C?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zkl5cjF0c1Z3UTM2ajZIZDRBNk5XTllBMDdaamRzdUFCdFZQTlZ3UzJJcVJn?=
 =?utf-8?B?NjlRTGpCekxnc1h0c2p1bFdnTmJEL2hRdk1XWDM2eUNOdUxVZkZQdmMva01u?=
 =?utf-8?B?cmZSa1VwNXl0aVk2NWtVMnN1cW5XcFh6cmdVaGZaZjlLUk5yd3BjV2QzQnZJ?=
 =?utf-8?B?VkMwaXhzT0x3NS9JMjFRaUYyMjRGajhxTlArYTNRM1dRSXVaRmpyRkdVaXB6?=
 =?utf-8?B?RmovM0JyN0lSb0tBcHNCNkEvZVN1ZmFqK1EwZU9KK0tENStpby9JUnhOK1J0?=
 =?utf-8?B?czRldzZqUU1HT2lqcXZyTVR5RlEzZXhXK1NnaWRaamtGUjZKU2pHb3grTWlB?=
 =?utf-8?B?dWNyZkp5OWZ1S1IzVGJGRG5HS3g3SlV2eGJ6K0hGUmNjVTVVeVRxOTh4TDhr?=
 =?utf-8?B?N2JGSjZYSEVnYVkyM1RBS1gxVlpncmtsSGZJczRWMi9jRUFUMXF5NHVBeVRl?=
 =?utf-8?B?dVUxWnR4a1JRZzlVTzNVT09pKzU2V3YwQW82S2NiWWlLYmd3bVpybW40QlZE?=
 =?utf-8?B?WkhXbmdJbUtabEtmZzRVVTNOQWhnb0UwaEdUV2p4UjRmbUhDRlBxYnd4WGdt?=
 =?utf-8?B?K0xGbDlEeC9jdE43R21oMENYQ0dDQk9vNG1sOTFNNmpUTkk5WUZoem1GUU5O?=
 =?utf-8?B?b2lZL2VxMXRmT0VVaVRtenpWNXBQK1NqVHdlVXpvRVg4YXcyTWZoWU1zS2tp?=
 =?utf-8?B?ekFKYk1zckk2bDhEbDRtR216UzJjQXREMTZNR0kxK1JmWGs2Mm8xTlhYQ0py?=
 =?utf-8?B?UUkyQlZlNHZERzlzZ1drNnY2blNqQ1Vrd1p3YUNzdHpJS1hZU01HWU9IK0M4?=
 =?utf-8?B?bVIzbEN0R0ZDTXRRbmJPajczSHJpZHFwUWdISmxXZVZXMWtISzN0eWRqMXdF?=
 =?utf-8?B?dlNoSGNNR1QvUXZydGlaTStMRnRjQkhjM0pMcnpjekFlSHUzR1YzL0tJaWxW?=
 =?utf-8?B?V24yWGVxUCszbWN0b3A0S0FvbEVKclNQdWVFZ0w2N2NOdWpqNTU4YTMzbDlJ?=
 =?utf-8?B?VU9KV1VOeXBiaGlLSldyd3ZreERCWEZzQysyS1FSUDViNHp6SW00YlI4Wjdo?=
 =?utf-8?B?RkFpMktuV2NMbFZQUW5ZbGErdGZXbHVzZVVOaFRSZXoxWHdHc0VXSld0S0RT?=
 =?utf-8?B?Yzd2YU9VUCtDZE1nWlEyY2tOWElRNkE5eVF2elJIQzBVRjZXNEo1YWZ4Ukla?=
 =?utf-8?B?RUl6djVuRmhDcFJ6R3FQaFEvWEYrZm0xaFY3Q2NnYVIwMzFtVnBHanlaSnVt?=
 =?utf-8?B?bTMrdDRoQkR4NkRvb0xMRHhaL3ZjMERzbnd4YUwySktDWDMyaWc5Ky9LbDhW?=
 =?utf-8?B?MjNxb2V6R3R3cS9iTk9LMGNpZU1zaVpQSGZVeVpTM3kxbVdVL2h5VHdLamNk?=
 =?utf-8?B?Z29MWURYRVVMaURQM0VMV3AreUpvZ0JUcUlFdEtvUXN4eGo0ZEUvYlpxdW1D?=
 =?utf-8?B?QWxpYnRya2NnWWhQeFlxOU1hdisyaXFxTTd2LytIZVlncjhkaXkybVBxNnFw?=
 =?utf-8?B?aFlENDY3OVR6N1Ara2d0dXIwV1RGRE04MFptaE1KQ1hQazRWUjZZeUZQZTFl?=
 =?utf-8?B?bXZkcmdDR2FQR1pHd2t0MjBsWERxZHNKUWs3WURXS1d6SU9FRis3aW9iUE1U?=
 =?utf-8?B?Zi9LYjgwRjdrNHNkQmdGbDBESkF1Q3BGSEE3eUo3azZsbi9OS21XRGhJemFV?=
 =?utf-8?B?L2QrT211Zk1Nb1ptR1l1SVFpSWRjRXY0SVppek0wMjFROGM0Sk5VTzBZSTIr?=
 =?utf-8?B?YUh0MlpuVGNXWmJMTWhvUk9LYkRoOWZaWElPbGpGSDdWY2plUjBocHRRTGtt?=
 =?utf-8?B?Yjhxb1hlSk1mT0U3ajB4ZUNnRzBlZ29nZWc5c1hmd2lnZFltTjA3cTJFL1VB?=
 =?utf-8?B?dlI3RDhwcmJ5WjhCcG1EVVJ0cVYvVkt6S2g0MThKS2JRbGZ2WEtWb1hFRldx?=
 =?utf-8?B?ZVZPR1lUVlJzdWh3dGZjOVlsTjgyaVhNWE5tMWFtVllTZjZjYjhsWVhMOStk?=
 =?utf-8?B?MUxLbndDdVlyOXNBV2ZzM05WQUIwcHJScTd6d3ovV2JCS2VCeWdSYi8wVUZT?=
 =?utf-8?B?MDF1aHVreDZoRlFMWmJzckZGTVNkTFVIaWMyQTE3SXlORVEyV3l4ZlUyOEdH?=
 =?utf-8?B?cmgrcTFLcFpPOWNPT29nZG9xcjF1ZVJNL1I4UCtQazRBK0lpOXczYkhuUUZW?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85C0EC85FB1AE2428D14159B22DF222D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8508d1-1add-462e-98a9-08de0a1c1cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 05:48:19.1206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Buou2Ru0MNMCEDUOjgQ9b6NIL62A6EDVnrZmU0fDziXKY+E6O8xRuxhMC0yqtX+ZxSTQAjSJ+aIU4dqTLCVSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6534

T24gU3VuLCAyMDI1LTEwLTEyIGF0IDA0OjU5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDExLzEwLzIwMjUgMDg6NTEsIEpqaWFuIFpob3UgKOWR
qOW7uikgd3JvdGU6DQo+ID4gT24gRnJpLCAyMDI1LTEwLTEwIGF0IDE3OjE1ICswODAwLCBKamlh
biBaaG91IHdyb3RlOg0KPiA+ID4gVGhlIE1USyBWQ1AgbWFpbGJveCBlbmFibGVzIHRoZSBTb0Mg
dG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgVkNQDQo+ID4gPiBieQ0KPiA+ID4gcGFzc2luZw0KPiA+
ID4gbWVzc2FnZXMgdGhyb3VnaCA2NCAzMi1iaXQgd2lkZSByZWdpc3RlcnMuIEl0IGhhcyAzMiBp
bnRlcnJ1cHQNCj4gPiA+IHZlY3RvcnMgaW4NCj4gPiA+IGVpdGhlciBkaXJlY3Rpb24gZm9yIHNp
Z25hbGxpbmcgcHVycG9zZXMuDQo+ID4gPiANCj4gPiA+IFRoaXMgYWRkcyBhIGJpbmRpbmcgZm9y
IE1lZGlhdGVrIFZDUCBtYWlsYm94Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKamlh
biBaaG91IDxqamlhbi56aG91QG1lZGlhdGVrLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gPiBS
ZXZpZXdlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3ZW5zdEBjaHJvbWl1bS5vcmc+DQo+ID4gDQo+ID4g
SSBmb3Jnb3QgdG8gYWRkICJBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPiIuDQo+ID4gRG8gSSBuZWVkIHRvIHJl
c3VibWl0IGl0Pw0KPiANCj4gWWVzLg0KPiANCj4gWW91IGFsc28gc2hvdWxkIHVzZSBiNCwgc28g
eW91IHdvbid0IGJlIG1ha2luZyBzdWNoIG1pc3Rha2VzLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIg
c3VnZ2VzdGlvbi4gSSB3aWxsIHJlc2VuZCB2OS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQo=

