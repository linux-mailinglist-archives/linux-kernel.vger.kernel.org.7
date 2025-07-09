Return-Path: <linux-kernel+bounces-722861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95885AFDFFB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3A3480A4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB38D26B770;
	Wed,  9 Jul 2025 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D0sdZ4ty";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bpkX+hFj"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5AAD24;
	Wed,  9 Jul 2025 06:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752042893; cv=fail; b=KhiO8MJia1PvfjGJbKOlVyWeMDJY37Zta56jnu/ywPCpxDRN2aT4cwygNB8K2UWfAPRD71OAXE1IgLeWedzzEQrnHSy+NTse78BhhsYM6WOBj1XQgmIvMYy74lUmG37RiY8j3s0UIl47PnL2oxv6LinvquKmInol3+xoSkbaaF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752042893; c=relaxed/simple;
	bh=bykT2cWaqpwWA8TDqOdjrR2pW/Eqz2dJA0iflyugbas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6cNS4Z8aqiAGLlTcmpIkEWSI/ZdgiyExiAxUk4dLv5hgAKbQmU0S16GcjpkeLhLbXAZQ/XkTXHmXgO77t+z0KDjLyXrcJ0IcB8jTkj+gEjBlCGzsg1WthP4f1gF6ib4nAlEELM9lg0+LNP4rprHcYkxSaoO1q832q7Wtlm9It0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D0sdZ4ty; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bpkX+hFj; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ccea81f85c8e11f0b33aeb1e7f16c2b6-20250709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bykT2cWaqpwWA8TDqOdjrR2pW/Eqz2dJA0iflyugbas=;
	b=D0sdZ4tys+JfG7lXtj15R9q7AC9iISwgpeONLzjEfTIEniPBmuHaWcoEvX1NYWRV7KyUNTYA1uCAzMCsowMdtgfDDRDGDKaGSQRS81dES5kuf0PX6IEhRhCiQUT1s4CSLYgPAie2olRTqTStglbvLU/txqE6v3EgW91BU5TZGzQ=;
X-CID-CACHE: Type:Local,Time:202507091405+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:42f35b98-996b-4a1c-b18f-c7bb6fcaa1c7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:827cbbbc-a91d-4696-b3f4-d8815e4c200b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ccea81f85c8e11f0b33aeb1e7f16c2b6-20250709
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 419503531; Wed, 09 Jul 2025 14:34:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Jul 2025 14:34:42 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Jul 2025 14:34:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxy3o3idBtC8uQKUBHpCg05q1jVMijL/TaWMw3roRfAuyYcRyjQoMwfFvBTlCKBBpS7bSgjol/+YUy4eFaaO7Yim7r/68KA0oq3RGHH6vXM6cRWXaumNqBwgsbRr7nf5BmUEhRjX0f+t7KowPKSWQpDeQmBJP5BGno0NDzJMppP8pYO9F52Uc+NDsa7EjgOuL2Cq+9aD/idRCnbsNKxURGNcJ0Jv2fpWFh0YtSwq9OMDbmCe7w7I9d/G1skV23dJ6QTlMyYOw3kEvlq4N9VNMUf38PLdgHh26rCmPy+nvpDiJ+2gFVUqDAVcmhmihyKk1u0RRewn5JY+q4kkwpjVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bykT2cWaqpwWA8TDqOdjrR2pW/Eqz2dJA0iflyugbas=;
 b=VITlyyMnHhDvHqEWsZVW4WU+qJ5n9ncYWU/Uuibn6XLhF/XMX/Iao3r3gFGDBnp+mHfIlJIu9XAlAQGoTzVhL3hJs/qLQ/3R3EsRJC6n/Grl4o545Caefw9V9oBk4fAqNvDp2rD7BWuFk5R/lkbqjPiqb7u2/KgjEhE255oxR0FzH2cE/XiEchLHg5LtQIne4TgiN8+8M+i7wFJpmWu/D7i/LtFkWkJSwS2uCzR8DaJ6JKiAxRVMup8xs/O89DPZdXhJ01PYVR8Yw/9mEwQcORAwiAoHr17iVwuMhaxMH6JieFtwP/UttJ+kdeO1Q/JV0V3PwplWZJO5EZJS5pLxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bykT2cWaqpwWA8TDqOdjrR2pW/Eqz2dJA0iflyugbas=;
 b=bpkX+hFjLMCBmR37TbjkEzt55YQsETRU06Yr7Xu+EcltdE7/B4wTuM73BzX0hspg2Cjp7PBbBim9SSA+Ga23k9VafdNwsVv7DUQLJ8b0gP3XMKPhZcYgHKITArMsVPGI/FTQWSAasq6WCa52pOM3nsxDdj8wOmkW2GuNVPjBApg=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by SEYPR03MB7167.apcprd03.prod.outlook.com (2603:1096:101:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:34:40 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 06:34:40 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "perex@perex.cz" <perex@perex.cz>, "krzk@kernel.org" <krzk@kernel.org>,
	"pierre-louis.bossart@linux.dev" <pierre-louis.bossart@linux.dev>,
	"kai.vehmanen@linux.intel.com" <kai.vehmanen@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "robh@kernel.org"
	<robh@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"peter.ujfalusi@linux.intel.com" <peter.ujfalusi@linux.intel.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "daniel.baluta@nxp.com"
	<daniel.baluta@nxp.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "sound-open-firmware@alsa-project.org"
	<sound-open-firmware@alsa-project.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Topic: [PATCH v2 1/2] dt-bindings: dsp: mediatek: add mt8196 dsp
 document
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAAP9QCACUO9gA==
Date: Wed, 9 Jul 2025 06:34:40 +0000
Message-ID: <85ca4ceb29caec9acbe77a3d67e3bc57b0b0aeb5.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
	 <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
In-Reply-To: <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|SEYPR03MB7167:EE_
x-ms-office365-filtering-correlation-id: b6d5c552-de1a-49fa-6ac6-08ddbeb2aee6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?ZDdsRlc5UDZBMVh6MmtqSjJKdTFTdkp0MEZHZnFMcVVzYVEwWi9pamttdEs2?=
 =?utf-8?B?ZkVNQXFERXhwckhkLzJrbzJFZGVzV3crc1d4d2JBZUNHNWx6c1ZqWkNaQkY4?=
 =?utf-8?B?cG5VdkxlNDBaYWJtcnpsNEhTZ1MyQmRSWTlMMXUrWHB0SzQ2Z1F6UmhPOHZS?=
 =?utf-8?B?TXB4Ly9GaUtZdHc2dFRENHpHQ0xZbi9oSFJ6d3Rrc1NxUTRXQ3hlSTZ1Njhk?=
 =?utf-8?B?VU4vYStkSzQzeXBlT0F2djJsOHZCUkd5R3BQb0NLZHhyMXVPSS9OelVQWWky?=
 =?utf-8?B?eitBZ09NZDJGMXV0TkxjcGEzUjNGRDEvR1dtT0gwSHNHSGlISyswcEtPa0N4?=
 =?utf-8?B?UkcvWEhxVWJuQklZMmFhZ1ZxVXQvK3JXMWVIclRDSHRuN0ZpV0Q2NGM0ZzEw?=
 =?utf-8?B?K01Ed0hTTmhBaUdwZGRmcWZ5ZkJXT24rUHdOWnFWZG5mdnNEbk51ak82WEF4?=
 =?utf-8?B?aFFUb0pNTzZ5OENLQVJPTmV5cnlKc01SeUVWc21CcEpKck1vaTFtZU94bWww?=
 =?utf-8?B?dWR2SmJiMm81VG9tSmNMK2VyNDVtU3RtRngyYzFBSzNKdlAySjBDQ2x0aFlT?=
 =?utf-8?B?dTdIOFV6aGVUU09BWkpoTzlzbGkrUHo5Zkp1VHR5NUQ2V0pYcERseS9nM0F5?=
 =?utf-8?B?cC90eW5rSTZoZnp2NDRwOUQwWHBjQWpZZzcwak84aElEa0p1cGxxRTdMUDNV?=
 =?utf-8?B?QXF4ZUExNjNkOXhFMHJnRmV1RE5saG8xYWZod09LTjVwUStWMzZzSUtFZS9K?=
 =?utf-8?B?ZTl0VG5YRzd3U2Q1MU1IcWpBVGxoWlZKQk9IMmhleHNRMHU2YjdxOGpFQWJE?=
 =?utf-8?B?cmpsZ2VZNC9sS2d2YW15WE4rU2hIaHduaXF1eFlDRnBmWkNoYVVUWUo3cmRk?=
 =?utf-8?B?Yk1FRjVrVDFVM0huK0Rrb0o3V1dYc3dtb0RZWFFoWjA4R0dJZFlWT3lvNTcw?=
 =?utf-8?B?Z1N1NitmZkVreVBkaWM5dUpUUjNyWnBWVTkxcHp1OVdnYmFBT2MxbmxIT3hE?=
 =?utf-8?B?NENVS3RieWVYS055WTg2aEs1SkZ3VFp3NFFTMUJjQ0JDeE1GNE1FUTJ4ZmQr?=
 =?utf-8?B?ZFdxRC9vRVVGeFJNU1JDdUpveFVjR1RSQWlVWGdjN2RYZGxHYit5cEpoV3N0?=
 =?utf-8?B?TzJ6bVozdlRYSmFlZCs2KzVqWUpKOTFTR09nYkdNblB3UERqNlg4WFphTVAr?=
 =?utf-8?B?MUNNZEIrZG5ZeUl4R1dseExpODl5enlHZlRHYXF5cG5jMlZyQ0NNUVlTRHQ2?=
 =?utf-8?B?NjNYREswUUxEaytaL3ZDZCtwUUNpK2ZKVGNXMkgrQ281RHV2STlSZndBdlBz?=
 =?utf-8?B?WkJRMTJTYTZRcSsxZER0UEdacWlVdjcvU2xUc2s3T2F4UEhKR1RsYWFEVUdU?=
 =?utf-8?B?Z0NXRXIwWEhRVW12RXBJSVlFcGtyK3dzY2prOFNjOEUzWTFnRkVsZ0FMWEJF?=
 =?utf-8?B?NC8wcHgrTDIvQnpKNHVkZkt0bHN0aHJYaCt3V3RvMkZ6ZTNtSG82bXNMdFlz?=
 =?utf-8?B?RUZGRjYzaS9lRXNFbnowdmJhTy9pZjVZRHBScnpGbjVJbzZCV0NwODJGYStu?=
 =?utf-8?B?dk9Od2pMQWxLWDlXcTdsWmxuQWhYRHJ3MlRzOVNmSmZJZUtKNlk4ai90azdU?=
 =?utf-8?B?dUc0T2NTMTJNM2tOVXBDMlU0YTlObVJGb0dKcVZjSWRBTXN3K3M5clhJeFVy?=
 =?utf-8?B?aGdta25jOVBRR2dVdG9vaGJsZTUvaFh0VE9GZ2d4bjVEbVNZQ3RpUDhhSDVo?=
 =?utf-8?B?NzFpOEFFazhyNEg5MW9PaEIxM01ZRk1vaDR3aDVNc1IxTHk3ZlorWFN6Wmdj?=
 =?utf-8?B?WnpQL0dhQ1BIMDJZeklGR3dOTFFjWnBuQmF1aFEzNlBETXhFbmtHMlhndGww?=
 =?utf-8?B?eUk0MVJaamVjSDZ5RHhhRU94YnNvcTRZc1pUckx3c2ozbGsvOHgrL1d2VzlV?=
 =?utf-8?Q?1unVNFgNd2vOWvPBwZt186xd04mEIm7W?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRPZmRIS09OanF6b25Bd2RSOUVpTFNYMWdRRE5WZ1FkMGxzOFB5TnIxellQ?=
 =?utf-8?B?TGU1MjUvR2NtZ2RXb2t3LytMTk5FWXZIcGxvV0p5YU1EaUwvV2ovN21iWXVS?=
 =?utf-8?B?SGliRjNaVUg5c2VZeHlEQWs1c1ZoVlRDN1ZnUXNpNXd4eTZKQ0V1ZG9nTE0x?=
 =?utf-8?B?VkQwQXNPM1pZaU9URDJVUGdFalJXUjBoSU1zcFF3N3NHSys2MWpBMXZCQVdl?=
 =?utf-8?B?Y0NZVmM2bk5GNCswdmpIZE4wWUZkMU1mdndmMHEvU3JmN0QrYU5JcVV2RXY4?=
 =?utf-8?B?QVZhRW5qS1dVQWZtak5qM3FJOGdLVEI1aWZUV2QwV1JNdk54WWN6UXJuMjcw?=
 =?utf-8?B?Nk9nc2N5anJ4dFlGL3d0K1R4bDB3dzBVL1lIZnI0SFk2VzduN3QzQUlqa3U0?=
 =?utf-8?B?OTVvQ2FkWVNSSVljamZFWUwyZzVtVkd0TFVKUU1xdFpsRS9KUVF1dEFJMTBM?=
 =?utf-8?B?M2hwbGo3bzBncWtDMGxlZUN5ejRLbTdCLzVjM2tWL1ZINk9vZ0ROR1RPQ0FE?=
 =?utf-8?B?bU9IOEF1ajVuTUhuQ056VE4yaEdlb2lpOU94VjNkWTdXeFV4VzhHMFJ2bEVF?=
 =?utf-8?B?bVZnWTlSRkpvNHFFRkpRUlBYQ05EMFRDT0kyK0E5RnMxZldOVTUyV29kWmU1?=
 =?utf-8?B?Y1R1aG9ISGdMcVR5d0RmdGt1OWlFWkwvVzNLdWdMbzgzaDVDV25pOVJwK2s5?=
 =?utf-8?B?cW00OExaQ0ZzbFVRVWxXdVJqOWV3MTRsWWV1T0xBbUFXSHBxUVA2bG1CLzV0?=
 =?utf-8?B?WmtTbmZLenRYMU1FZTgzRmowZXcwYys0dG1oR3JHOHowZHNGTU9uVlRJRWZh?=
 =?utf-8?B?NjJZTmRVTEJKNXo2OUdFc3VrL3hxQkR4czRZblJVQjJwM0ZxbC9tOFE4emNy?=
 =?utf-8?B?YktscFVkMVFtWi9rcFMvRHFFK0lwS2pDWmh5M1AxUzNqVDMzTmpTZVF0UEUx?=
 =?utf-8?B?RnZvNG5VYnlxdC9HeEw4elZHQktpbHM0ZmFlRHU4VWdObVQ0NklUZTI3L3M5?=
 =?utf-8?B?aTRpMEs4eGZVWVZEUE4rYUZJdDVkZ0NMOHBsM0R4cWFMTVVBQTljaEQvKzhU?=
 =?utf-8?B?aGwwam5SQlhDU21OdFMxN0FrNVR4YVZkT2M5aURIYUtXK0RMZnlyTXgyc3Zx?=
 =?utf-8?B?NmRPcnpwaXB4UmFkbXhoY3piLzhvek5JelNkdEVYWFhXdUZiVy82S0RHN1B5?=
 =?utf-8?B?U2JBeVJSQmFxU1hvZzFzS0RXUWZjOXJ2TVl3UVZWVmVYVTBkYW82MXNoK28y?=
 =?utf-8?B?NWx2RmM1MVkxc00rRklsUnlxWVV0MlQzZ0FtbTBvSmhNaE9FWmwyTnVxWnRM?=
 =?utf-8?B?N2E3U1BRTzRJZUVnZW9veDhBS2d3R1lUYjErSTA2cGphZlRZejZXZUNvUk1G?=
 =?utf-8?B?YmJid1piSXNPaVR3MTBwTGd6T3JoczlPYkhnenBIRGFkYTlXQTFPYkRENkVv?=
 =?utf-8?B?UjgyMWtMUmxZeFlrZmhDSUdzaVhtakx1Yk1UVk8waDFVYVBvREQyelhFRVNr?=
 =?utf-8?B?Y2pPZXFUaEpwdGZYb3lUVmZSQ1ZBRG1ySmh2N2hzZDFIZWQ3d25YZnFOaisr?=
 =?utf-8?B?ZUs2TStWcVcwcVRjTGJxK3NEVUJzL1R1Q0lCMnJsN2h5S3NOQUxRSys5aUF0?=
 =?utf-8?B?S1p2S2thamkvSTBPYm1KcjJsTlFubUZMQm9FQWVsRnhodlI0aUNZeC9ndHpL?=
 =?utf-8?B?emZMOUp4aTViUjJXWEhjWnI2NWFENExEb2VDSVYrcENQb3VOUlRCU0tkSDNG?=
 =?utf-8?B?UTY5WWdMSXN3RGFCNnhEOUJNWWhjWUVoL2pHNkZ4WUgyRTUrRkVzOHVUV3VY?=
 =?utf-8?B?ZDNMYVNneE1aN2V2dUszMk45UGVIMlNzV1ZxZXBoQ2ZRa1hVdWtuWlhVd1Bx?=
 =?utf-8?B?VHhRYkJpT3VGSE82RDhDK0RoRVRrcXV4L2hGZ0dDUUZGMmZ1ellLc3B3Y0lZ?=
 =?utf-8?B?YmhmUHFqTUZ3SllxdmJ3Z3d6NC9xYXI2eHllbUsvSU45Y0NTTDNGdlpmd3V6?=
 =?utf-8?B?Z0ljTG1VMjg1U1B1TGFOdUFlNGJ2Z051TFZ2b2tFWFhEOHNzekNWVXNTbEV1?=
 =?utf-8?B?ZWFwd3hGUTBBVHdTd2Z0b0Q3OUprWmxobU9zNTNNOHR1NnZqRWRYaVFDcFFX?=
 =?utf-8?B?bVNYWjB0ekNwd0hEeU9sOFkzK3lTcTlkRzUzQkc3cEFwZFVnaWVNYm5TQ1h6?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17C0C7E23BD7304BB5D042EC7C4B6C81@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5c552-de1a-49fa-6ac6-08ddbeb2aee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:34:40.3666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tO7pWiY4brEh6UkjF5qcly0WJo8qx8PIrksMLWjWDdF5F6zJS0DxdQJ7t1S+eYT+h6QgLgzDs2oRdaGfE3tjnfJ5m36FYiOcGMiUvw0ccGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7167

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDExOjA1ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wNy8yNSAxMDowOCwgS3J6eXN6dG9m
IEtvemxvd3NraSBoYSBzY3JpdHRvOg0KPiA+IE9uIDAzLzA3LzIwMjUgMDk6NTYsIGhhaWxvbmcu
ZmFuIHdyb3RlOg0KPiA+ID4gRnJvbTogSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVr
LmNvbT4NCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBhZGRzIG10ODE5NiBkc3AgZG9jdW1lbnQu
IFRoZSBkc3AgaXMgdXNlZCBmb3IgU291bmQNCj4gPiA+IE9wZW4NCj4gPiANCj4gPiBQbGVhc2Ug
ZG8gbm90IHVzZSAiVGhpcyBjb21taXQvcGF0Y2gvY2hhbmdlIiwgYnV0IGltcGVyYXRpdmUgbW9v
ZC4NCj4gPiBTZWUNCj4gPiBsb25nZXIgZXhwbGFuYXRpb24gaGVyZToNCj4gPiANCmh0dHBzOi8v
dXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4x
Ny4xL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCpM
OTVfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWczOXE0OGZVQ3NESjVQRVRVdFEwUEswQmt3ZjBDZTFG
X1p6SmlFaVdNenV5YldRMGRTUHpibHZMbEotNHNhV1RTb0pXdVM1aW1zWGJwZGdMQnZVeTR3eHc5
QzV3N0I0bSQNCj4gPiANCj4gPiA+IEZpcm13YXJlIGRyaXZlciBub2RlLiBJdCBpbmNsdWRlcyBy
ZWdpc3RlcnMsICBjbG9ja3MsIG1lbW9yeQ0KPiA+ID4gcmVnaW9ucywNCj4gPiA+IGFuZCBtYWls
Ym94IGZvciBkc3AuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWxvbmcgRmFuIDxo
YWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4uL2JpbmRpbmdz
L3NvdW5kL21lZGlhdGVrLG10ODE5Ni1kc3AueWFtbCAgIHwgOTUNCj4gPiA+ICsrKysrKysrKysr
KysrKysrKysNCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKykNCj4gPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQNCj4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21l
ZGlhdGVrLG10ODE5Ni0NCj4gPiA+IGRzcC55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxOTYtDQo+ID4gPiBkc3AueWFtbA0K
PiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNjhm
NTk0ZjQ3NmU4DQo+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTk2LQ0KPiA+ID4gZHNwLnlh
bWwNCj4gDQo+IFdyb25nIGZvbGRlcjsgdGhpcyBzaG91bGQgZ28gdG8gZHNwL21lZGlhdGVrLG10
ODE5Ni1kc3AueWFtbCAuLi4uDQo+IA0KPiAuLi5idXQgdGhlbiBJIGRvbid0IGdldCB3aHkgTVQ4
MTk2IHdhc24ndCBzaW1wbHkgYWRkZWQgdG8NCj4gbWVkaWF0ZWssbXQ4MTg2LWRzcC55YW1sLg0K
PiANClllcywgdGhlIGZpcnN0IHZlcnNpb24gd2FzIHdyaXR0ZW4gdGhpcyB3YXksIGJ1dCB0aGUg
bWFpbnRhaW5lcg0Kc3VnZ2VzdGVkIHRoZSBmb2xsb3dpbmcsIHNvIEknbSBub3Qgc3VyZSB3aGlj
aCBhcHByb2FjaCBpcyBtb3JlDQphcHByb3ByaWF0ZS4gQ291bGQgeW91IHBsZWFzZSBwcm92aWRl
IGEgZmluYWwgcmVjb21tZW5kYXRpb24/DQogDQp2MSBsaW5rOiANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9hNzI5ODgyMTJkMGQ5NWJmZTc2ZWI5YzUzYmJkYjhjNTdjOTg5Mzc3LmNhbWVs
QG1lZGlhdGVrLmNvbS8NCiANCmNvbW1lbnQ6DQo+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5n
cy9kc3AvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sICAgICB8IDk2DQo+ID4gKysrKysrKysrKysr
KysrKysrKw0KPg0KPiBEb24ndCBncm93IGRzcCBkaXJlY3RvcnkuIEVpdGhlciB0aGlzIGlzIHJl
bW90ZXByb2Mgb3Igc29tZSBzb3VuZA0KPiBjb21wb25lbnQsIHNvIHBsYWNlIGl0IGFjY29yZGlu
Z2x5Lg0KVGhpcyBpcyBhIHJlZmVyZW5jZSB0byB0aGUgYXBwcm9hY2ggdXNlZCBpbiBhIHByZXZp
b3VzIE1lZGlhVGVrDQpwcm9qZWN0Og0KIA0KDQpodHRwczovL3dlYi5naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC90cmVlL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3ANCkRvIHdlIG5lZWQgdG8gbW92ZSBhbGwgdGhl
IGZpbGVzIHVuZGVyIHRoZSBEU1AgZGlyZWN0b3J5IHRvIHRoZSBzb3VuZA0KZGlyZWN0b3J5Pw0K
DQo+ID4gPiBAQCAtMCwwICsxLDk1IEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gKy0t
LQ0KPiA+ID4gKyRpZDogDQo+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sKl9f
O0l3ISFDVFJOS0E5d01nMEFSYnchZzM5cTQ4ZlVDc0RKNVBFVFV0UTBQSzBCa3dmMENlMUZfWnpK
aUVpV016dXliV1EwZFNQemJsdkxsSi00c2FXVFNvSld1UzVpbXNYYnBkZ0xCdlV5NHd4dzlHTjRy
eUJRJA0KPiA+ID4gKyRzY2hlbWE6IA0KPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJO
S0E5d01nMEFSYnchZzM5cTQ4ZlVDc0RKNVBFVFV0UTBQSzBCa3dmMENlMUZfWnpKaUVpV016dXli
V1EwZFNQemJsdkxsSi00c2FXVFNvSld1UzVpbXNYYnBkZ0xCdlV5NHd4dzlOS2JNdWhOJA0KPiA+
ID4gKw0KPiA+ID4gK3RpdGxlOiBNZWRpYVRlayBtdDgxOTYgRFNQIGNvcmUNCj4gPiA+ICsNCj4g
PiA+ICttYWludGFpbmVyczoNCj4gPiA+ICsgIC0gSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1l
ZGlhdGVrLmNvbT4NCj4gPiA+ICsNCj4gPiA+ICtkZXNjcmlwdGlvbjogVGhlIE1lZGlhVGVrIG10
ODE5NiBTb0MgbXQ4MTk2IGNvbnRhaW4gYSBEU1AgY29yZQ0KPiA+ID4gdXNlZCBmb3IgYWR2YW5j
ZWQNCj4gPiANCj4gPiBNaXNzaW5nIGJsYW5rIGxpbmUuIExvb2sgYXQgb3RoZXIgYmluZGluZ3Mu
IEFsc28gZG9lcyBub3QgbG9vaw0KPiA+IHdyYXBwZWQNCj4gPiBhdCA4MCAoc2VlIExpbnV4IGNv
ZGluZyBzdHlsZSBkb2MpLg0KPiA+IA0KPiANCj4gVGhlcmUncyBhbHNvIGEgdHlwbywgIm10ODE5
NiBTb0MgbXQ4MTk2Ig0KPiANCldpbGwgdXBkYXRlIGluIG5leHQgdmVyc2lvbiwgdGhhbmtzLg0K
DQo+ID4gDQo+ID4gPiArICBwcmUtIGFuZCBwb3N0LSBhdWRpbyBwcm9jZXNzaW5nLg0KPiA+ID4g
Kw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gKyAgICBj
b25zdDogbWVkaWF0ZWssbXQ4MTk2LWRzcA0KPiA+ID4gKw0KPiA+ID4gKyAgcmVnOg0KPiA+ID4g
KyAgICBpdGVtczoNCj4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBEU1AgY29uZmlndXJhdGlv
biByZWdpc3RlcnMNCj4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBEU1AgU1JBTQ0KPiA+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IERTUCBzZWN1cmUgcmVnaXN0ZXJzDQo+ID4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogRFNQIGJ1cyByZWdpc3RlcnMNCj4gPiA+ICsNCj4gPiA+ICsgIHJlZy1u
YW1lczoNCj4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiArICAgICAgLSBjb25zdDogY2ZnDQo+ID4g
PiArICAgICAgLSBjb25zdDogc3JhbQ0KPiA+ID4gKyAgICAgIC0gY29uc3Q6IHNlYw0KPiA+ID4g
KyAgICAgIC0gY29uc3Q6IGJ1cw0KPiA+ID4gKw0KPiA+ID4gKyAgY2xvY2tzOg0KPiA+ID4gKyAg
ICBpdGVtczoNCj4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBtdXggZm9yIGRzcCBjbG9jaw0K
PiA+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IDI2TSBjbG9jaw0KPiA+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IEFEU1AgUExMIGNsb2NrDQo+ID4gPiArDQo+ID4gPiArICBjbG9jay1uYW1lczoN
Cj4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiArICAgICAgLSBjb25zdDogYWRzcF9zZWwNCj4gPiAN
Cj4gPiBJc24ndCB0aGlzIGNhbGxlZCBhdWRpb2RzcCBpbiBvdGhlciBiaW5kaW5ncz8NCj4gPiAN
Cj4gPiA+ICsgICAgICAtIGNvbnN0OiBjbGsyNm0NCj4gPiANCj4gPiBEb24ndCB1c2UgZnJlcXVl
bmNpZXMuIEhvdyBpcyB0aGUgcGluIG9yIGlucHV0IGNhbGxlZCBpbiBkYXRhc2hlZXQ/DQo+ID4g
SG93DQo+ID4gb3RoZXIgZGV2aWNlcyBjYWxsIGl0Pw0KPiANCj4gSW4gdGhlIGRhdGFzaGVldCwg
dGhpcyBpcyBjYWxsZWQuLi4uIENMSzI2TSAocmVhbGx5KS4NCj4gDQo+IENoZWVycywNCj4gQW5n
ZWxvDQo+IA0KPiA+IA0KPiA+ID4gKyAgICAgIC0gY29uc3Q6IGFkc3BwbGwNCj4gPiA+ICsNCj4g
PiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+
ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEtyenlzenRvZg0KPiANCj4gDQo=

