Return-Path: <linux-kernel+bounces-736544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938BB09E52
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49133B7129
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24B293C45;
	Fri, 18 Jul 2025 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bfkwvD8N";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ov43qZRS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513B61DC997;
	Fri, 18 Jul 2025 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828508; cv=fail; b=Ui04K7BuOwj9Qq2nC1ry8GCs5aFVPC8+7VopISyKAAuWcYhh81iJIuiO/rQeCR3PtwpZdWfeatMFv3enoMIOrD4H670xZ9SuJy3rK5dbsy/CVy9Meay8ezCXQIAyvf+HOZY5+PgTq2PswN2vm0FT1jqKIaFNftWWJrUBbQ4L6YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828508; c=relaxed/simple;
	bh=vk2u/EUpk6CyB21eWzr4zvfOKmtxmHWA2uwRnTGA5h8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UVY+CntqOHAJxBM9vRFvJCFNkxnKXXiTNg+Ld42VYv9AjGqQHbhZQ1IZuRlxjIlqtzJa3LGwcIrFe6PoRYqcC/CNHVmPZodcLqN9KEcRKQTaxUqiSCJBhH6NT27PR4QkSNuUcU7Ki6Iaqxa8sh1MIV+XD+YwWwhZcnrijj0OtWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bfkwvD8N; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ov43qZRS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f46f937c63b311f08b7dc59d57013e23-20250718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vk2u/EUpk6CyB21eWzr4zvfOKmtxmHWA2uwRnTGA5h8=;
	b=bfkwvD8Nish3l0ti93hGwzGYvlrvHinVhhQHITCu91O9kDjyAYOfVmgT2ZExi7qr0HiIRgmm4i06Lfo8rQYYMoA1Ea9QitL5xUiK/H8Acd8fBy0pP0R3QkAgqXvWdJinXR5H2XXjDnA/t6hXO7PVP82+jgpFUpy7gq0eU9VseQk=;
X-CID-CACHE: Type:Local,Time:202507181613+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:44bd2dcc-63e4-46c5-ab41-68d22308ba56,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:9eb4ff7,CLOUDID:4fcd9484-a7ec-4748-8ac1-dca5703e241f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|11|97|83|106|80|1,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f46f937c63b311f08b7dc59d57013e23-20250718
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <cyril.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 115261155; Fri, 18 Jul 2025 16:48:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 18 Jul 2025 16:48:18 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 18 Jul 2025 16:48:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDYvgjq92W1R1Hf2QGXbCT8nIoGoB/XcwykHn2Sz0oEOxpGSYcc76xlPu+DvS2qVwrQ8VqgbLQOxM+HUEXE3qZnZteJS7uSU3ZdK5EaMmYpzFvQd4DdI9tPtPge0GlHxkODI6RQLfsMOhflYadReVJMi3Yp95l3lYRwrdhH8osi4XgJN6E7H0Szhpnx1s35Ed/+U+BbXyGlEASjFdXQhBr/Y6peiBKE9CxSNmE83YEkbKTNuElZsnciqmb3cQ0xib7pYFlOPjb8zji4rfU+li5+6dX2IxwfVLLfFROKEdlGKwIO/Z4q/YBMWiVBPRe3pX0Z23UEAN8yezVN/imIAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk2u/EUpk6CyB21eWzr4zvfOKmtxmHWA2uwRnTGA5h8=;
 b=DqlNOqbRLrPa95VzkT/nsu+1iPr0+zfExHNtFSBSBHayDl9E6PfyCmwYJN/u/OQTxeINSTlaB1xUEnTPHe4xMVTKHJTabNZVcP+Dr/N6rqMQz8mPJMJ1cjSWIKbZaYfSWMMKDJEss7gq8IvxkbhIO28ushqcVGUtiK14vqN+DQO3XhtORkRBLu650QCf35ugMWLpNgVuUwdgAxZSprQzprXPPPtXn+mUPKgrQ51bo+8mwITPEjLGnFf5sEvwlUhMk7s+C49X1Ea1jzQI2/VVhaLuehQLS+zN5KYR0EAWvIUsc5FZ/GzSEHao4eFO2sUGqQO82MxufMVmWK+I51zqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk2u/EUpk6CyB21eWzr4zvfOKmtxmHWA2uwRnTGA5h8=;
 b=ov43qZRSLKU81qBHXYl8F7EN3iEmayYGNe20S9iMQuEpJ6o7NjXj78nsYN6dLduh+v6+VuJc89IUimAnbqXBgQJrxMHGns+pitn+c5fQQTm9vRCWywrr9SiGZ4NCx+gTF5PZqfO4UdO+F+VIbSuhTmiixgjfxFqAi+7tSOWvFpE=
Received: from TYZPR03MB5343.apcprd03.prod.outlook.com (2603:1096:400:3c::8)
 by TYZPR03MB6765.apcprd03.prod.outlook.com (2603:1096:400:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 08:48:16 +0000
Received: from TYZPR03MB5343.apcprd03.prod.outlook.com
 ([fe80::6a18:3b51:df4c:efbb]) by TYZPR03MB5343.apcprd03.prod.outlook.com
 ([fe80::6a18:3b51:df4c:efbb%4]) with mapi id 15.20.8922.040; Fri, 18 Jul 2025
 08:48:16 +0000
From: =?utf-8?B?Q3lyaWwgQ2hhbyAo6ZKe5oKmKQ==?= <Cyril.Chao@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"tiwai@suse.com" <tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"perex@perex.cz" <perex@perex.cz>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 10/10] ASoC: dt-bindings: mediatek,mt8189-nau8825: add
 mt8189-nau8825 document
Thread-Topic: [PATCH 10/10] ASoC: dt-bindings: mediatek,mt8189-nau8825: add
 mt8189-nau8825 document
Thread-Index: AQHb5/yCerM3mfPP/UG3QncibcTCxbQYhD8AgB8tLQA=
Date: Fri, 18 Jul 2025 08:48:16 +0000
Message-ID: <9f752338a2deda3e3475468ccc881230dc370f88.camel@mediatek.com>
References: <20250628071442.31155-1-Cyril.Chao@mediatek.com>
	 <20250628071442.31155-11-Cyril.Chao@mediatek.com>
	 <43b4c2bb-a1ed-4f6d-9977-512617130337@kernel.org>
In-Reply-To: <43b4c2bb-a1ed-4f6d-9977-512617130337@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5343:EE_|TYZPR03MB6765:EE_
x-ms-office365-filtering-correlation-id: 961aecb3-7a2b-4604-73d1-08ddc5d7d655
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?bzJEM0I3VWg0RXl3TUZHeUN2ZENXSUYyTzhQRDluQXFnUlJGZ0lmbmU4dVZx?=
 =?utf-8?B?YmxDd0k1amRHRVBBbGhMRlZ5dkhmRjk1K3c4VUpEUm9pRGsxNFkzdFhuT1Zi?=
 =?utf-8?B?WUU4VDZDRCsvem5WSlNHc3c1Qk4vWi8zS1g5S1FGNjBpYUxhYUlDQ2JtUFBR?=
 =?utf-8?B?TERXb1p5dndCblI4SGU3dERCZzJMTjZaY3ovOXErdTZ3dEc5czdHTmxEekl1?=
 =?utf-8?B?aTlML3FPMDZLZVpnNmV5Y2tiOUV4RUk3OGtUMjhwL3dBWVZNcWh2UGlPZHJj?=
 =?utf-8?B?aE5hb2ZYbWlnbUQ1ekNWdzM0aFhDaENVSG1VM1NGSjlaOVp6QmN1TTU0Zjl0?=
 =?utf-8?B?L2NLWDlzYUpWYmxDSmduVDBDTWNKbDFCZGxxRGd3VFFGMEE0UTV1enBiYTZ5?=
 =?utf-8?B?dnAyV1d1VlFPdGZIMHFCMlJJcDE2N1JPY3BJL0xmbW1rb1N5YlRTMGlBZmFH?=
 =?utf-8?B?U1lEYjJEb3FDRTBLWk9wUHV5SUk3Z2FMa2ZvbjFQTTRQVmpWSThnRy9GN0pa?=
 =?utf-8?B?cldBcDBCeWRqNy9KWit6SE9JNjBoaVVONnZkZGtic0ZsdU4yVVk5VzdWZU1Y?=
 =?utf-8?B?MWNRQnNkRG9LcjhSNUFLcDlUTzVXZ0FPMmtTQlEwMjdieWJ1V2xGalhJT1dR?=
 =?utf-8?B?eXNsQ1Rnc3dIZTBlM1N4RC9GNDgzT0dvRERia0lYOXk1Q3RQSnEvWTNHdnlU?=
 =?utf-8?B?WUtHZk41VjU5aGhJYlBUd1BSZ1A3UXNSZHJjUjR4L1ZZek90K05jZFJQTmZq?=
 =?utf-8?B?b2hQQjl5NVIrUkVwMjR4RWxmcmpLK3lIWktMTmF4UEJNNTFvYlYrR2dYdkd2?=
 =?utf-8?B?WTFGaldma3VYdWxzOWQzdTMzQU9MWDBrb2FBTUhUdEIzOFM3d3c5UldnMVdI?=
 =?utf-8?B?SWVuZUNYVWZqdHdKdFlkaDVWaUxCcmwyVTQvWmg4TFhobTVrY2tMOFF5RWRJ?=
 =?utf-8?B?SUNBeEFxclNqUDVTbU9KYW9qRVpaa3ViL2tRRTNPelhjUURrdzNkUGtHRDRB?=
 =?utf-8?B?RFFPRHlHQWZHbitIQ3h4eWVqd3dMQ21ycml5aUtPOTlDREdmTXdrU28xRUx0?=
 =?utf-8?B?ZlhOQVBmTnhUdWdkMmZCNWtDMXAzRldQSU52eU5HMU1MM0lBLytHOG1ERk9a?=
 =?utf-8?B?bWx0SzRjbTlMNSt4M0xyUnVhcUJ0OEp4ZTVETFZmNmowdnJVSUlBMk9pY3RU?=
 =?utf-8?B?bVVhTEdyMTFJaVZtUVlPcEl5Vk80MDhuY09HVEVOS3BEWjZQaXF5NXcyRHJR?=
 =?utf-8?B?ZFBFY29SSlJzWHIzdkxTemJ5aWh1VklrNmx4ZkgycU9ySnB2YXk2SXlPaEsv?=
 =?utf-8?B?Yk9ON0gvSitaVWJtR1hXbUREZ0ZoL3ZtR2VIVWpCVlRBdkJYL2NHMEJLL0I2?=
 =?utf-8?B?clg4N0lDYUJ5TkdIaHpJUVBlZDdmQU55VjQrbW9iZW1rWVVYWmpVekFMMm8r?=
 =?utf-8?B?c0pjNkN4REsxUmRnQ3FIeDZNdUdkcTRWSE1seU9vL3Z6c0pNMFFMSTRURFZ5?=
 =?utf-8?B?UndxV1lndDZSbjFGbGMrOFFXeGpMdEhJNnA4bWxaVTRrUHFnWmRIUmRlMTY1?=
 =?utf-8?B?MTdjMFF2UVhXM25PNys3M3RGbEUyUE1SYXArTVdqVTlhUnljci96c1UwTjlG?=
 =?utf-8?B?NGpzSGFJSCtTY1dYNnBicGkzcmRJWU9LYTJXNGJ5YUtmcDQ4TkRodFlIanRJ?=
 =?utf-8?B?K1hHTVZOTmFlMjJhb3pMajFmeUtxRVhnVG9aOHFOVGE1NnYzVlpSanZHVFhr?=
 =?utf-8?B?bk84U1FkeDlHczV2U1J4VU9hc2tpaENIYUdrSEVCVG4xa0xZb2xneDQ0VnZS?=
 =?utf-8?B?OVA5SGNFc29EeVFrZk1qa2RnLzVNbU1UekRpQzdyaDEwTGxzajhyYnRzOVUw?=
 =?utf-8?B?c2thRVFqNWhuQjk2cUlWZEEzSGdUL3UxR29vNzZ0dGVHenVwNzZLL1VNM29r?=
 =?utf-8?Q?6t87yyWXgByzx59JJJQM8FVqw2q9whDJ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5343.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0FaOHJJVWNnakR5UEpVbHkxYjVPbDRkeEdKZ2RXRVRrSTBpcnh4TEFIb3Fh?=
 =?utf-8?B?TWRzTzFKUDBubEhYNVVBdlRVK2tUNDRLNnZNUnFkMStJR3k3VENFVVkyajd5?=
 =?utf-8?B?RDdwSXZzbElad2cwZGppazlLVnVGYWFLQjBaTDZOVWQyL0U4d0Q3K0doa0pO?=
 =?utf-8?B?dTdTbkpCcTdJZzVPMHJ0WXY4YjV5Vy9EWHA2TnBZNjNTQzlrejljUVgvelQ1?=
 =?utf-8?B?YVR5bFowblVhRzlYWnpVYUcvd3VMWGQyRkhSdXJ5YWlPU29GbUV5bWw3WmIz?=
 =?utf-8?B?ZWtDMDhJSGR6dE9qZU8vaXU1ZDl3SXNOZitxQWtXN3YvbnhvT0FuNmIxekd3?=
 =?utf-8?B?V1o1cGNwZ1BWclRyVkxyN2wxdE5ZWEJzVWF4aS9wcnR2TDM3a25xVUJ2UWlz?=
 =?utf-8?B?V0MvTTE0YTE4eThJNXZKMkhiZzQwQWFXOU50YXE3eU1rbG1lRTVkYmlrTDBI?=
 =?utf-8?B?aHNPaFpYZE9QbVIvV3lDYUNMTmNRMFJKRFRYL3c4R3c2b2tSOGxmMm9vdnFL?=
 =?utf-8?B?MUw5ZFVKQ2dDZnpwaXpvUE8wSnlXaWFVek8reGpOU0NLeGhKVjJOQUxDWmJI?=
 =?utf-8?B?aG1sK0F6dWg4eWd2T08raVRmajFyNkN0ZVFzaDRvY3N4ZVNUcHJ2TjRhY1Mw?=
 =?utf-8?B?NEZuVTh4TlFtOURQaVZxQytoYmJsazlLZlZtc1pXYXpzT0wyM1RMSitNTTFo?=
 =?utf-8?B?aWxDeXpXaTFlUjVlaDBWN21JOHN3NmozeWxOTFg5VE1tSHNYY1R0WWtqZFdn?=
 =?utf-8?B?OEZOVURLWTdkLzF5MVh5Nm5yQ3EzZ1hzeCtLOThxSmdYUGdhUGlBNXNnYmxG?=
 =?utf-8?B?blNZcy9vSHQzQWdCbzYyNk9wbTEvS2ZoVXlXeVB4Ujh6aEpVQW9tL1JQNVFZ?=
 =?utf-8?B?RWRtZzZBcWxiWW8weHVVbnZxRnFTTzd0cXA5RkJWK05qT1BrOGQ0a290S044?=
 =?utf-8?B?Y3NDRXJ4ejlsNEVMeTRzUUxIQVh2ajl1RE5zTExrdDBoNkdrY3ZLdzVEWGdN?=
 =?utf-8?B?ZFZYYmdscTBvOWpORGZJTEVsMnc5SjlFcHVJVmJHbXVOV0JDNVJoeGFGVWFL?=
 =?utf-8?B?c1BvcWtOem12UWcyc0tTWXdOc09VNk16cHBBZzdMMDkwVldCaGtqMUp5V3p3?=
 =?utf-8?B?Sk5zQXpiSDBZdEU5bFJjdC9DV0ZNV2tlWjdvTzdob2E2TXFEa09KREF3RnRo?=
 =?utf-8?B?L1RBR2tPYzk4UzJUazlPUlFNTG14cS90ZFBkeDFiU3FpUXNteXhrYkk4M2FP?=
 =?utf-8?B?bTg4aEVITjZIMW84YUlVN1c5M2huZkl5UVB4QlRDTmYyaTNDT2NGekZpYjRM?=
 =?utf-8?B?bDduN1hoSkdGMjZqcHIvS25hdzRzZzh2eVl1VUF0d2N4WTVUcDZuMXhkWjBr?=
 =?utf-8?B?bE1IUHc5R1VBQTR3aUt1N1lGcWZyd1hiYjhteThqamZUV1ZVQ2d1QndjQmVG?=
 =?utf-8?B?NldBNUxQK1hlZ0U5dE43WHd5NlRrTXE0QnVueTdZcUlRQUMwcW5pVXNHR2lP?=
 =?utf-8?B?VFArdzV2dkpOTDRGTDFiUnJFU2dLcnNhdW91TS9VaSt1Qmp1Z2ExcmtHNURJ?=
 =?utf-8?B?RlU1QitFRlpVaDVaVmlzcER2Ly9kdWE3T3pwOUQ5dEYwcnMvVXJFQ3ZxZXdU?=
 =?utf-8?B?ck44SnkzQkFTSm5yRHhPVC9HZnA2UWtMaXhEWmZjaGZVVDFwWG1WaXowWjlH?=
 =?utf-8?B?WW13UDJOeHlsS2Z6bEJQWHJ3bGNKWEI5dG9lZTBnSU1GbWhTLzF0Ny9PWTRK?=
 =?utf-8?B?MTdqTFN5cHpjYzk5bHlCeDBCT0dWdWczMWQ1b0lEUkRJZTcvRmVzWE1ZN1BG?=
 =?utf-8?B?M1FMVDRpMmFpcEx0eG5jOWFqNWExT0dUeEp2eWw2V0JEeVNrLzYzYzFMeTg1?=
 =?utf-8?B?Wi9QV3hRbWJONGZrQ1BsaDB4WXBXblpjSVRHdlpXYmRSc3V2NTFEU2YrRzEv?=
 =?utf-8?B?VS84My9aUFRxbzhBanlEejlNalh4VkxmcEpTbEh5RzhYdXZGbTByU3h3dHJj?=
 =?utf-8?B?d1kxTDRzU3pEbWlIdGJwY3VoaWRpVDB6SmNrZmtNa1FKZXdReFBnajBrUUNR?=
 =?utf-8?B?NVBjRVFoaHdGQkNRakpQSzRVV0M3Q25yd3VzUldWM0hySkwreC8ydVZBbUZS?=
 =?utf-8?B?ZkVpZFF5aG5saEJZdExYSVZNYjZ6dXZTZWxJMFhBdzJsc0tRMzZ0QWh3SnRQ?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2557F8C4B3F65D4EB516D4BEDED08F80@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5343.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961aecb3-7a2b-4604-73d1-08ddc5d7d655
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 08:48:16.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYoLILx3Pe7fL+ARdoV2ClesInE5dYSLPiPq39YJWNsjrqK45bqanx/+pM8EnPzKcuGA//Z3OIQwA8Aak1K46Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6765

T24gU2F0LCAyMDI1LTA2LTI4IGF0IDE0OjQyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDI4LzA2LzIwMjUgMDk6MTQsIEN5cmlsIHdyb3RlOg0K
PiA+IEZyb206IEN5cmlsIENoYW8gPEN5cmlsLkNoYW9AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+
IEFkZCBkb2N1bWVudCBmb3IgbXQ4MTg5IGJvYXJkIHdpdGggbmF1ODgyNS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDeXJpbCBDaGFvIDxDeXJpbC5DaGFvQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IFdoeSBkb2VzIHRoZSBiaW5kaW5nIGNvbWUgYWZ0ZXIgdXNlcj8gRm9sbG93IHN1Ym1pdHRpbmcg
cGF0Y2hlcyBpbg0KPiBEVC4NCj4gDQpDb3VsZCB5b3UgaGVscCB0byBjbGFyaWZ5IHRoaXM/IElz
IGl0IHRoZSBvcmRlciBpbiB3aGljaCBJIHN1Ym1pdHRlZA0KdGhlIGR0LWJpbmRpbmcgcGF0Y2gg
dGhhdCdzIGluY29ycmVjdD8gTXVjaCB0aGFua3N+fg0KDQo+ID4gLS0tDQo+ID4gIC4uLi9zb3Vu
ZC9tZWRpYXRlayxtdDgxODktbmF1ODgyNS55YW1sICAgICAgICB8IDEwMw0KPiA+ICsrKysrKysr
KysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKykNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvdW5kL21lZGlhdGVrLG10ODE4OS0NCj4gPiBuYXU4ODI1LnlhbWwNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVk
aWF0ZWssbXQ4MTg5LQ0KPiA+IG5hdTg4MjUueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE4OS0NCj4gPiBuYXU4ODI1LnlhbWwN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uMzMxYzUzN2Qz
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxODktDQo+ID4gbmF1ODgyNS55YW1sDQo+ID4gQEAg
LTAsMCArMSwxMDMgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlk
OiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvc291bmQvbWVkaWF0ZWssbXQ4MTg5LW5hdTg4MjUueWFtbCpfXztJdyEhQ1RSTktB
OXdNZzBBUmJ3IWo4OXA4Q182RkRTYlRsQUV5WVhUTjJUNVI2Tm13alN3dWhOSGJJQkxiYkNSTFNV
cUVXRGxCeS1GbE9lbzhyeENUU0pldUg2QkxWWlMwMHckDQo+ID4gKyRzY2hlbWE6IA0KPiA+IGh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWo4OXA4Q182RkRTYlRsQUV5WVhU
TjJUNVI2Tm13alN3dWhOSGJJQkxiYkNSTFNVcUVXRGxCeS1GbE9lbzhyeENUU0pldUg2QnpBam1Z
WUUkDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsgTVQ4MTg5IEFTb0Mgc291bmQgY2FyZA0K
PiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBEYXJyZW4gWWUgPGRhcnJlbi55ZUBt
ZWRpYXRlay5jb20+DQo+ID4gKyAgLSBDeXJpbCBDaGFvIDxjeXJpbC5jaGFvQG1lZGlhdGVrLmNv
bT4NCj4gPiArDQo+ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogc291bmQtY2FyZC1jb21tb24u
eWFtbCMNCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiAr
ICAgIGVudW06DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg5LW5hdTg4MjUtc291bmQNCj4g
PiArICAgICAgLSBtZWRpYXRlayxtdDgxODktcnQ1NjUwLXNvdW5kDQo+ID4gKyAgICAgIC0gbWVk
aWF0ZWssbXQ4MTg5LXJ0NTY4MnMtc291bmQNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODkt
cnQ1NjgyaS1zb3VuZA0KPiANCj4gU291bmQgaXMgcmVkdW5kYW50LiBDYW4gaXQgYmUgYW55dGhp
bmcgZWxzZT8NCj4gDQpPa2F5LCBJIHdpbGwgcmVtb3ZlICdzb3VuZCcgbmV4dCB2ZXJzaW9uLCBh
bmQgbGlrZSB0aGlzOg0KbWVkaWF0ZWssbXQ4MTg5LW5hdTg4MjUNCm1lZGlhdGVrLG10ODE4OS1y
dDU2NTANCm1lZGlhdGVrLG10ODE4OS1ydDU2ODJzDQptZWRpYXRlayxtdDgxODktcnQ1NjgyaQ0K
DQpUaGFua3MgZm9yIHJldmlld35+fg0KDQpCZXN0IFJlZ2FyZHMNCkN5cmlsIENoYW8NCg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

