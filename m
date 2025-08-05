Return-Path: <linux-kernel+bounces-756096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173DB1AFEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCD317DA32
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5523ABA7;
	Tue,  5 Aug 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GqJUpQw3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ta4TvLZq"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C51EDA1B;
	Tue,  5 Aug 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380755; cv=fail; b=JYMeWAL5/d53y5eIKwBbod22L9Iyc13vsnaNxvjKjA6A6rfUg+m9LpZUoCUqHPKbDKvycEfaLmzkiZIJyKn7Rb19hjvhgYnrWhh7t8ynKhfnTjWzmnkgbc6oxhDsMUu0vnRHOSe4Lj1UYTk/t1agAaplosAw8awG1LJ0cYxztxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380755; c=relaxed/simple;
	bh=B8dmHByQV7EgsTyzbpga7UsFOy+XCX7oTc/zaln6Jdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnXIDytbZcyCkcT5POdrIpvWKeJ0l+iov8VARdKC9Y6KFmsduGveyDtzL/axbSc0THOaJ0j458Uuz/bZwtPv750WLCcYsWESlBFOU30iuwUmWGKT+NFS8tWacWVjXVdQ5Gaf8eTqReT3jTDN34qL2OhMrfjigjYuNCe67iiluFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GqJUpQw3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ta4TvLZq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 101a71ec71d211f0b33aeb1e7f16c2b6-20250805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B8dmHByQV7EgsTyzbpga7UsFOy+XCX7oTc/zaln6Jdc=;
	b=GqJUpQw3CtP8jBkaXTp//yI+UrjJ9D5ouAeOKyMo8X9CBW345cbqn3yEXHMcsAz1WCIsGPLrfKgtfOLziqqpPR/pKz6O/VjPssSOo+H/LFF/WnvfWi9pHy9ciDD94rQKwEYEy55C6Ztt3qxxVltxSktQAjU69wJMUaZGUUMAHQI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:d9e49e35-5edf-4741-9da5-99b2c06a92ad,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:3e729e9a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 101a71ec71d211f0b33aeb1e7f16c2b6-20250805
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 619254885; Tue, 05 Aug 2025 15:59:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 5 Aug 2025 15:59:05 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 5 Aug 2025 15:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySmwjSlzk3bsqaIldULVOyglukUywMGB8D0c/zMcv1+CKtSR7nNMTOfdrG6aDxXsJfcRA2DscdETefgojT9qFulvkytQxV/ItQKJGE3QZzKYmFdLKzJLqIp6yOCCtfYlSK5VAPOcX8nqZYqfckk+GWBN8GWL7F84Jgn1Ks285J49t5eN4pr9hxWWlCf2I83/dslNW+VbKITgBFygNZMmyt3Fg9Q3rO0RRwVW7QP5rSIzmSWmnvtVO0mK1A/YYdfT0QZ8YSUls0IAGMWYn0dhLdlYd8qtxgbJnrNXE4HbmXuSHzVZ8Y7dgG4B6IT1zpVgc3iXDPboKc6FqRc//yuuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8dmHByQV7EgsTyzbpga7UsFOy+XCX7oTc/zaln6Jdc=;
 b=lTWwnokbBAXNDkzIKwppTl2L/dWQXoSsAZSsdeu1eqQmtnU4U+Frk6Lx/gc6f8zzptXnRoUDRhC/54ObgX0we08320EM48Dd7FI3NzXPxinc5RvtGV9O4PAr3JRX9GO2Wf2yFwbJQSsjtN6ScY0M5LpobWkYMRghi+BsEqw/HSB7Z40QzLsTCSXh+wf5xrBbESax10y/vU9NznxojpwijmMeBpHfMDZ7JNYObLHenWmcxtXzKVm7rP9gyapo8AYH7PNpvYBwympF8yqQbDK1xiW0cTAyTB4KQATPCIyfmxaLI434zhRrwGtBGCpC9YyVdtmMjmwnzAY+FsYiklSgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8dmHByQV7EgsTyzbpga7UsFOy+XCX7oTc/zaln6Jdc=;
 b=ta4TvLZq3cfx6Gb56kyJzPkim9z8Lk5Ga56lp9KIC6ySd04xcBid4bqGxkriDPdofuf8wvj8upwGMDnU7jpuRtsierNqYzNlxysf775w87eaa0GRbKziH6/q2lm2GDZr5ed1DOUb8nqhDCsKFcc1vIWGy52XA9kniTd86lAi3JY=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEZPR03MB6524.apcprd03.prod.outlook.com (2603:1096:101:73::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 07:59:03 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 07:59:02 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v9 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v9 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHcBT7F+zB8PvR2HE+D8b5hQyI3uLRSd14AgAE7wQA=
Date: Tue, 5 Aug 2025 07:59:02 +0000
Message-ID: <c45b8ffa0a5538b8170b3bae7b8c5a098b9677b9.camel@mediatek.com>
References: <20250804125215.23076-1-friday.yang@mediatek.com>
	 <20250804125215.23076-3-friday.yang@mediatek.com>
	 <bc8d1bdc-8e19-4a1d-b5f4-d0e463e22dc9@collabora.com>
In-Reply-To: <bc8d1bdc-8e19-4a1d-b5f4-d0e463e22dc9@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEZPR03MB6524:EE_
x-ms-office365-filtering-correlation-id: 6b369350-51ea-4530-ace0-08ddd3f5f17f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTlZa3BsdlVSSGZ3ZG8zazFKSFVhM3JNSzFvQTN5Z1loR1NTSDMwNi82V3Vy?=
 =?utf-8?B?OEVsdkE2SUI2cWFLNW9RVnlzOXdDc3gzOHBSKzl0TXpTcFpYQUY1SEZTNVlB?=
 =?utf-8?B?Y3pxQUt6SXcxWjlKV2dpRk9vNGdLamdaNnJMWGs0UTBGdDFod2d0a3pDVmhR?=
 =?utf-8?B?bmdjQVR0d2cyYUpYSFJtcVp2MGVFQnhkNGpGblVjcXc5dTVndldOaFN2cEtI?=
 =?utf-8?B?Z0l1YmlSdzYxNnpUdW9BWi9QY25ZcUFGMS90RjRFSmZoelg5TjJrdzJOc2xr?=
 =?utf-8?B?NWxDUVdHRDFpM09jUy9rdnBxWkIzRmh6TmIxRXQ0NjQ1dkRrcXFTb09kZmll?=
 =?utf-8?B?WDBqLy9EWUkxNEhCeG81eG5CbW5qanY5K3FRalpVa0I1NnBRaVpEOXFlSEZG?=
 =?utf-8?B?YVFXbjlzTWJ4b0xxcXFuUHNFM2lKcmFYV3NnaHBXSUlDY1JYc0VjWmkrZExC?=
 =?utf-8?B?bzdGNGxoNHRXS1oxa2lFRDhISjFWRnEzY2x2c0dMcDJVckd1NUJJczhUTFlk?=
 =?utf-8?B?Uzh0L3JnWjNzTnFwdTcxa0ZCeEx2alJpQlpKMTg2SDRsOWRYdjlxOUMwQUdK?=
 =?utf-8?B?ajJ0eDFRNExFZHA0SGRyM1ZMZkl4TUNGUmFDNGhUTmNuSGZENDRVYkZQL3pk?=
 =?utf-8?B?R2E0d2tZZ2NIbTIvYXIvNWM5NmtSYVZ2aG13eHFzSm1PZjhZaVZ0bTNDUXRi?=
 =?utf-8?B?QlhpcXpudWwrT0VoSW16akdKbHdaZ0VsYUhxRWQ1QXZSaFdHVkJuaUVKZk4r?=
 =?utf-8?B?SnZJQitMSGx1SmlZUUZzRkswdVJERjJUV1ZPdnNTbVhUY0xnYkx2YXR0ZVB2?=
 =?utf-8?B?ZStGVWFiL0xucEkyeUkxWVB1TXVxMlBUQmI2U3NJdjRKd2pEMGhCanBpeURq?=
 =?utf-8?B?NUhtVUVtbCtCWlNMc1lKaTcvUm0yUmFhSkpyanZhcWl4eUYxWS9ELzNIZXow?=
 =?utf-8?B?TXhLVnpEcWJqWEI1dll2allBNkExbjJYUS9Mc2pXZFAwT1JrNHhtSFRBU2Ny?=
 =?utf-8?B?bTRqS3VWZEt2OGlmNmtvVVpWQzQwZ2hSdjNFSzJ4RkZvS24zN0UydGIrRGs0?=
 =?utf-8?B?Q2xla3hrMHBYZGpBd3ZnUlBwMmZvZTI2Wm5BTytwZHY4NkJiaVR4Vmo5SDZP?=
 =?utf-8?B?N3FER3hUMVNIM3ovdlduTnFZMGZoT1J2bTBSZzNZRzYyMHl6cTNrOE5OckNV?=
 =?utf-8?B?ajRGSkRUQzI3R1Q4MzlBZ0M3N3kvYitBMzkrSFYyc1RHWTNlTzJ0emNPdlZk?=
 =?utf-8?B?cXF6WVc4RXhvQ3luWFVqMTYxQVYreExGOFErR04zcElGMWZSZ0FYYjBMb2lD?=
 =?utf-8?B?NTNnVkphanRmaUlheE1FZEJnRzBGMGNBM0paU3FML1Q1WUZMaGxRQmtIWjBC?=
 =?utf-8?B?WDZpSWRhVlNLaVY1Vk4yMVBLVjBMWkVvSGY0UTlibkNXZ3Q1SkVHa1hodjFF?=
 =?utf-8?B?RkRvbFVTYjFXYjdVME9UaG9pNVNSeCtRVFFjYTlxNitIYjB1R29HUU9xSmFC?=
 =?utf-8?B?VkJHOTJnTmFqM1NBK3RiRnFPYWxQUGVPL0xNV3RjdDh3YkVzMmpxQUk3NXBW?=
 =?utf-8?B?a1hpTTVlYURwTjRVcHBOR2lackhjVHpxOEdWNzNlQ093c2ZBbko0ZGpKYitl?=
 =?utf-8?B?bVl3R3g4UStTaUZ1Q2pmUGt1TC9xS0JFZ0RNNWVRdzdwQ3NKMGJ3MXNKUVQ2?=
 =?utf-8?B?anpiaTNMTmRBYUg3WEFJOEg0VTF1T3BFcXh1SEZtZHVHc0hkVVhIQ2pTQkJs?=
 =?utf-8?B?cDArMW53cCsrL3ZaYWRtMjhNZzFJNmJHZUNyMnNheEx0Z09sWEhOZE5CSngz?=
 =?utf-8?B?N05mbXZUYkFjNHE1ejJXMlpqbVdLbDhuNzlMZ2JZZ3J6Qms3SXQxVFdXL1pj?=
 =?utf-8?B?VUlxUTJsSW5RVlcreFdrQnowZisyVTVlWS84cnNNdzVCSGgxWXc3ZHRPbjNQ?=
 =?utf-8?B?VWN5V2hMbVkzT00wMFlVNHV5anpLSEJZMSt4ckZBcmxjamJubUhETVlnc0p2?=
 =?utf-8?B?M3dqSk5PLzJ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHcxMzErTWR0STlMUDI1K1pFSlZLQVZLczVOa05KYUxWMW9SbWo4Z0pOVUNs?=
 =?utf-8?B?NWxwSElBVllsckxtYnNJMWwvaTdGZHdKbWZBYXNLcjkzNjBZUmpnbXlMZFJi?=
 =?utf-8?B?U3A3VDQ1YWcyWGpQV3p1c20rM09hdU5JeEdlVnlLSlRuRXJEWnhQalJOY0xC?=
 =?utf-8?B?QTJnTEFvcWtDamFYYmgwM3I4UFlDVzFQZVgwTHlzS0xvRlBMNExPRHZtWS9Z?=
 =?utf-8?B?T2ZyNDZZSGQyYTllbUJrVU1jOXUxZkF5Q0hJYTZmeFM1czgvVTNjSHQ4WVd0?=
 =?utf-8?B?UGcxL1BEcXUrcWo2NEpiUTF4Q3VEZ09lZll3ZXlZOWFtY3BoTVFwbHRMUjBS?=
 =?utf-8?B?WkdFazlnSW1qaFo5azg0NWFGczFqK3JTUzJnakJsYWFMVWMxRU1oU2d0RUVL?=
 =?utf-8?B?bmxSQjdLblpqanV0dCtlZXhTZ3Y1Q0tiYkdxcmRkNjFBMWlUZ0phZTRiVEw1?=
 =?utf-8?B?VFFITzFSYjFNNGs2QktMYVBaSGtLdDhYSk9qaDFsNTdGY1lXbFFrOTVOWkV1?=
 =?utf-8?B?d2RBY0xBbVJPeStFaVowQ3ZVdHFYSEdJbUlxUUJwZzVKUlA3OWxqdFdNLzFI?=
 =?utf-8?B?bkVHV01wcVdGLzhLUXN6aVgyWUd4WnkzRno3eWJKdWtTNG16K0lVTUhLMFEv?=
 =?utf-8?B?cE1uOWJoSkxPa2I1d1BKVDFaMC9HU0ViOEM1WG5pM1NOSHNtR1p0REo4ZXNh?=
 =?utf-8?B?c1paUWNpSDlnbmtiQmtDVVRwTU9USGdaeW11bjBpRE15ZmEyVXJEbWNqV3hy?=
 =?utf-8?B?ZjR4R3g0QkVTNGY1MUh5L0ZGckhXYXViOGNBQ2dNZ0tyT2w0NkpDQU53TjZj?=
 =?utf-8?B?dmozZ1VvMkJ3dWpzdkQ3eStiMjU3Y1hwRk5yMmorK3lFdnhMUWp4Ly9BdDRP?=
 =?utf-8?B?c0Z6cDN2TTNjREp4QjFFVmZFSjZEWTdaUUhRdStXY0hMTkhxTFdaQ0VZTTJY?=
 =?utf-8?B?b2FyRWQ3UFdHQU5paGtVMUE1eUM1TytQWFYyamc4QVZhSldsRUlXSnBmMVFK?=
 =?utf-8?B?Y1FRMTdTWXd6MWhqQno4a2t1QVFIQ1VBL3FKODNseTA2c1hvUGViZkZsNGZr?=
 =?utf-8?B?dUFUcklYRUYxbXl5OFA2MkFDSTZNb3BMUlV2NFE4V2ZEQkl0N0VpWGxVWFF0?=
 =?utf-8?B?b1h2emdyZFF2NVpDak1jRjROZWQwc2NkNG81TlZuREo2NkUvUUQ1QTNxakl4?=
 =?utf-8?B?WW12Y1ptbFdMUlQybVB2ZW8wMURsZTNHZ1g4d0dsaFUzaUxkZFBVSSswdDAr?=
 =?utf-8?B?cElMeE9vYzV0TE90TTR0Q3pWK1RnTXE0eGNaOEVWcGY1VEpaN3VpOFcrbG1I?=
 =?utf-8?B?K0trVGdNOThpa1JsSFFZUCtYdHZyY1VkSmYyWmR2OUE5QXNhV1hmRHZVWUNw?=
 =?utf-8?B?OHZjOGlpVFJTK05YSFBkeFM1aWhINGIxeFEzVklJZ1hPRmtiUFhRVXBTZXJC?=
 =?utf-8?B?WHNLSENRZWtKWXc1Z1NNMmYvMlN0QmNoL1orbFUzU0l4NllVSmlKWTZONk5C?=
 =?utf-8?B?Qzk1bVJISVYzR25qUVRvZG5POGtLZkVJUlBoejFZUFh2QjZPVXd3L1ZZR1Fl?=
 =?utf-8?B?a2o2NnNaQ29vY2VkTlpjQkxrdEhud2ZiaDhoNzJKSkpIaFJnanluanRCZnFQ?=
 =?utf-8?B?eUlIdkRlblQ3ckVEOEY5QWhpRDJYNFY2ZjYzVXludFY0bVErWG53VzBPSjlV?=
 =?utf-8?B?dVM2YTF5djVRZTJhbHByNnV1TlNyTWpQNHorTnBxNmJXcVJVNC9zZlRTZEN6?=
 =?utf-8?B?YlVPdXdiOEg3ejRGT0k5bE9RcEw1RTUzV21MWWZ5R2hCbThTZmpuOGpZS3J1?=
 =?utf-8?B?emZvdkZTYUFGWGtVN3lpRUhWOFdYK3J4cGd3MW9FNngvRlZkSEQvcmhaMkdq?=
 =?utf-8?B?UmdpUlM3VCtwbTNycDVtNVlSYmVrL3F1a1Rtd1dRckozQ25hN3V2QmlFYmUx?=
 =?utf-8?B?bVJITWphRGozZHMyMnJXd29VNy9TUTNYV0UwL0NWcXZEck9qdVo1L2NsUDY2?=
 =?utf-8?B?NUkyOG1GVWd2ZUFQNlFIZ1BmU3NIWXo1SnFjNU9vMGk1UnZpb0htbkhzQ3Y3?=
 =?utf-8?B?Vm5pZ3BGK08vYjkvWGRDbWRnVjFjWVdpYW1SbHZyN2RqL0l4QjlEVi9QRU9y?=
 =?utf-8?B?cFd1WDdTSHdpWHo0Y0lLMThpR3RTN1ZTTmNpaWZRN3phRjVCNXhjSmcwL2RJ?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C83F14F3C16B642AEADDE25A05E2437@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b369350-51ea-4530-ace0-08ddd3f5f17f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 07:59:02.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohDTrf6FiApjlD00mfJTWHdEbhELCMqRErG5fvpLcoCyOgpu7OEUYnBHpnGKms2FN9/9+eB5rhePif1FzZUkz6iDds+EftOQLO+QdKXUPl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6524

T24gTW9uLCAyMDI1LTA4LTA0IGF0IDE1OjA4ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNC8wOC8yNSAxNDo1MSwgRnJpZGF5IFlh
bmcgaGEgc2NyaXR0bzoNCj4gPiBUbyBwcmV2ZW50IGhhbmRsaW5nIGdsaXRjaCBzaWduYWxzIGR1
cmluZyBNVENNT1Mgb24vb2ZmDQo+ID4gdHJhbnNpdGlvbnMsDQo+ID4gU01JIHJlcXVpcmVzIGNs
YW1wIGFuZCByZXNldCBvcGVyYXRpb25zLiBQYXJzZSB0aGUgcmVzZXQgc2V0dGluZ3MNCj4gPiBm
b3INCj4gPiBTTUkgTEFSQnMgYW5kIHRoZSBjbGFtcCBzZXR0aW5ncyBmb3IgdGhlIFNNSSBTdWIt
Q29tbW9uLiBSZWdpc3Rlcg0KPiA+IGdlbnBkIGNhbGxiYWNrIGZvciB0aGUgU01JIExBUkJzIGxv
Y2F0ZWQgaW4gaW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+ID4gc3Vic3lzdGVtcywgYW5kIGFwcGx5
IHJlc2V0IGFuZCBjbGFtcCBvcGVyYXRpb25zIHdpdGhpbiB0aGUNCj4gPiBjYWxsYmFjay4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmlkYXkgWWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMTMxDQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hh
bmdlZCwgMTMxIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5kZXggNzMz
ZTIyZjY5NWFiLi44YzFiZDI0NWFhYzkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkv
bXRrLXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gQEAgLTEw
LDExICsxMCwxNSBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICAgI2luY2x1
ZGUgPGxpbnV4L2lvLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9v
Zl9wbGF0Zm9ybS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0K
PiA+ICsjaW5jbHVkZSA8bGludXgvcG1fZG9tYWluLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgv
cG1fcnVudGltZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKyNpbmNs
dWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9t
dGtfc2lwX3N2Yy5oPg0KPiA+ICAgI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiAg
ICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXQyNzAxLWxhcmItcG9ydC5oPg0KPiA+IEBA
IC0zNCw2ICszOCw4IEBADQo+ID4gICAjZGVmaW5lIFNNSV9GSUZPX1RIMSAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MjM4DQo+ID4gICAjZGVmaW5lIFNNSV9GSUZPX1RIMiAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MjNjDQo+ID4gICAjZGVmaW5lIFNNSV9EQ00gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MzAwDQo+ID4gKyNkZWZpbmUgU01JX0NPTU1PTl9DTEFNUF9FTl9TRVQgICAg
ICAgICAgICAgIDB4M2M0DQo+ID4gKyNkZWZpbmUgU01JX0NPTU1PTl9DTEFNUF9FTl9DTFIgICAg
ICAgICAgICAgIDB4M2M4DQo+ID4gICAjZGVmaW5lIFNNSV9EVU1NWSAgICAgICAgICAgICAgICAg
ICAweDQ0NA0KPiA+IA0KPiA+ICAgLyogU01JIExBUkIgKi8NCj4gPiBAQCAtMTM0LDYgKzE0MCw3
IEBAIHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIHsNCj4gPiAgICAgICB1bnNpZ25lZCBpbnQgICAg
ICAgICAgICAgICAgICAgIGxhcmJfZGlyZWN0X3RvX2NvbW1vbl9tYXNrOw0KPiA+ICAgICAgIHVu
c2lnbmVkIGludCAgICAgICAgICAgICAgICAgICAgZmxhZ3NfZ2VuZXJhbDsNCj4gPiAgICAgICBj
b25zdA0KPiA+IHU4ICAgICAgICAgICAgICAgICAgICAgICAgKCpvc3RkKVtTTUlfTEFSQl9QT1JU
X05SX01BWF07DQo+ID4gKyAgICAgY29uc3QgdTggICAgICAgICAgICAgICAgICAgICAgICAqY2xh
bXBfcG9ydDsNCj4gPiAgIH07DQo+ID4gDQo+ID4gICBzdHJ1Y3QgbXRrX3NtaSB7DQo+ID4gQEAg
LTE1MCw2ICsxNTcsNyBAQCBzdHJ1Y3QgbXRrX3NtaSB7DQo+ID4gICB9Ow0KPiA+IA0KPiA+ICAg
c3RydWN0IG10a19zbWlfbGFyYiB7IC8qIGxhcmI6IGxvY2FsIGFyYml0ZXIgKi8NCj4gPiArICAg
ICBzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAgICAgICAgICpkZXY7DQo+ID4gICAgICAgc3RydWN0
IG10a19zbWkgICAgICAgICAgICAgICAgICBzbWk7DQo+ID4gICAgICAgdm9pZCBfX2lvbWVtICAg
ICAgICAgICAgICAgICAgICAqYmFzZTsNCj4gPiAgICAgICBzdHJ1Y3QgZGV2aWNlICAgICAgICAg
ICAgICAgICAgICpzbWlfY29tbW9uX2RldjsgLyogY29tbW9uIG9yDQo+ID4gc3ViLWNvbW1vbiBk
ZXYgKi8NCj4gPiBAQCAtMTU3LDYgKzE2NSwxMCBAQCBzdHJ1Y3QgbXRrX3NtaV9sYXJiIHsgLyog
bGFyYjogbG9jYWwgYXJiaXRlcg0KPiA+ICovDQo+ID4gICAgICAgaW50ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsYXJiaWQ7DQo+ID4gICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqbW11Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGNoYXIgICAgICAgICAgICAgICAgICAg
KmJhbms7DQo+ID4gKyAgICAgc3RydWN0IHJlZ21hcCAgICAgICAgICAgICAgICAgICAqc21pX2Nv
bW1fc3lzY29uOyAvKiBzbWktY29tbSANCj4gPiBvciBzdWItY29tbSAqLw0KPiA+ICsgICAgIHU4
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc21pX2NvbW1faW5wb3J0X2lkOyAvKiBzbWkt
DQo+ID4gY29tbSBvciBzdWItY29tbSAqLw0KPiANCj4gb25lIG5pdCBuZXJlOiBzbWlfY29tbV9p
bl9wb3J0X2lkDQo+IA0KT2ssIEkgd2lsbCByZW5hbWUgJ3NtaV9jb21tX2lucG9ydF9pZCcgdG8g
J3NtaV9jb21tX2luX3BvcnRfaWQnLg0KDQo+ID4gKyAgICAgc3RydWN0IG5vdGlmaWVyX2Jsb2Nr
ICAgICAgICAgICBuYjsNCj4gPiArICAgICBzdHJ1Y3QgcmVzZXRfY29udHJvbCAgICAgICAgICAg
ICpyc3RfY29uOw0KPiA+ICAgfTsNCj4gPiANCj4gPiAgIHN0YXRpYyBpbnQNCj4gPiBAQCAtNDc4
LDYgKzQ5MCwxOSBAQCBzdGF0aWMgY29uc3QgdTgNCj4gPiBtdGtfc21pX2xhcmJfbXQ4MTk1X29z
dGRbXVtTTUlfTEFSQl9QT1JUX05SX01BWF0gPSB7DQo+ID4gICAgICAgWzI4XSA9IHsweDFhLCAw
eDBlLCAweDBhLCAweDBhLCAweDBjLCAweDBlLCAweDEwLH0sDQo+ID4gICB9Ow0KPiA+IA0KPiA+
ICtzdGF0aWMgY29uc3QgdTggbXRrX3NtaV9sYXJiX2NsYW1wX3BvcnRfbXQ4MTg4W01US19MQVJC
X05SX01BWF0gPQ0KPiA+IHsNCj4gPiArICAgICBbOV0gICAgID0gQklUKDEpLCAvKiBsYXJiMTAg
Ki8NCj4gPiArICAgICBbMTBdICAgID0gQklUKDIpLCAvKiBsYXJiMTFhICovDQo+ID4gKyAgICAg
WzExXSAgICA9IEJJVCgyKSwgLyogbGFyYjExYiAqLw0KPiA+ICsgICAgIFsxMl0gICAgPSBCSVQo
MyksIC8qIGxhcmIxMWMgKi8NCj4gPiArICAgICBbMTNdICAgID0gQklUKDApLCAvKiBsYXJiMTIg
Ki8NCj4gPiArICAgICBbMTZdICAgID0gQklUKDEpLCAvKiBsYXJiMTUgKi8NCj4gPiArICAgICBb
MTddICAgID0gQklUKDIpLCAvKiBsYXJiMTZhICovDQo+ID4gKyAgICAgWzE4XSAgICA9IEJJVCgy
KSwgLyogbGFyYjE2YiAqLw0KPiA+ICsgICAgIFsxOV0gICAgPSBCSVQoMyksIC8qIGxhcmIxN2Eg
Ki8NCj4gPiArICAgICBbMjBdICAgID0gQklUKDMpLCAvKiBsYXJiMTdiICovDQo+ID4gK307DQo+
ID4gKw0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10a19zbWlf
bGFyYl9tdDI3MDEgPSB7DQo+ID4gICAgICAgLnBvcnRfaW5fbGFyYiA9IHsNCj4gPiAgICAgICAg
ICAgICAgIExBUkIwX1BPUlRfT0ZGU0VULCBMQVJCMV9QT1JUX09GRlNFVCwNCj4gPiBAQCAtNTMx
LDYgKzU1Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbg0KPiA+IG10
a19zbWlfbGFyYl9tdDgxODggPSB7DQo+ID4gICAgICAgLmZsYWdzX2dlbmVyYWwgICAgICAgICAg
ICAgID0gTVRLX1NNSV9GTEFHX1RIUlRfVVBEQVRFIHwNCj4gPiBNVEtfU01JX0ZMQUdfU1dfRkxB
RyB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTVRLX1NNSV9GTEFH
X1NMRUVQX0NUTCB8DQo+ID4gTVRLX1NNSV9GTEFHX0NGR19QT1JUX1NFQ19DVEwsDQo+ID4gICAg
ICAgLm9zdGQgICAgICAgICAgICAgICAgICAgICAgID0gbXRrX3NtaV9sYXJiX210ODE4OF9vc3Rk
LA0KPiA+ICsgICAgIC5jbGFtcF9wb3J0ICAgICAgICAgICAgICAgICA9IG10a19zbWlfbGFyYl9j
bGFtcF9wb3J0X210ODE4OCwNCj4gPiAgIH07DQo+ID4gDQo+ID4gICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG10a19zbWlfbGFyYl9nZW4gbXRrX3NtaV9sYXJiX210ODE5MiA9IHsNCj4gPiBAQCAtNTgy
LDYgKzYwOCw0NSBAQCBzdGF0aWMgdm9pZA0KPiA+IG10a19zbWlfbGFyYl9zbGVlcF9jdHJsX2Rp
c2FibGUoc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYikNCj4gPiAgICAgICB3cml0ZWxfcmVsYXhl
ZCgwLCBsYXJiLT5iYXNlICsgU01JX0xBUkJfU0xQX0NPTik7DQo+ID4gICB9DQo+ID4gDQo+ID4g
K3N0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX2NsYW1wX3Byb3RlY3RfZW5hYmxlKHN0cnVjdCBkZXZp
Y2UgKmRldiwNCj4gPiBib29sIGVuYWJsZSkNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBtdGtf
c21pX2xhcmIgKmxhcmIgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArICAgICB1MzIgcmVn
Ow0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIC8qIHNtaV9jb21tX3N5c2Nv
biBtYXkgYmUgTlVMTCBpZiB0aGUgc3Vic3lzIGRvZXNuJ3QgaGF2ZSBidXMNCj4gPiBnbGl0Y2gg
aXNzdWVzICovDQo+ID4gKyAgICAgaWYgKCFsYXJiLT5zbWlfY29tbV9zeXNjb24pDQo+ID4gKyAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgcmVnID0gZW5hYmxl
ID8gU01JX0NPTU1PTl9DTEFNUF9FTl9TRVQgOg0KPiA+IFNNSV9DT01NT05fQ0xBTVBfRU5fQ0xS
Ow0KPiA+ICsNCj4gPiArICAgICByZXQgPSByZWdtYXBfd3JpdGUobGFyYi0+c21pX2NvbW1fc3lz
Y29uLCByZWcsIGxhcmItDQo+ID4gPnNtaV9jb21tX2lucG9ydF9pZCk7DQo+ID4gKyAgICAgaWYg
KHJldCkNCj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5hYmxlIHRvICVzIGNsYW1w
IGZvciBpbnB1dCBwb3J0ICVkOg0KPiA+ICVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBlbmFibGUgPyAiZW5hYmxlIiA6ICJkaXNhYmxlIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgbGFyYi0+c21pX2NvbW1faW5wb3J0X2lkLCByZXQpOw0KPiA+ICsNCj4gPiArICAgICByZXR1
cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfZ2VucGRfY2Fs
bGJhY2soc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIHZvaWQgKmRhdGEpDQo+ID4gK3sNCj4g
PiArICAgICBzdHJ1Y3QgbXRrX3NtaV9sYXJiICpsYXJiID0gY29udGFpbmVyX29mKG5iLCBzdHJ1
Y3QNCj4gPiBtdGtfc21pX2xhcmIsIG5iKTsNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYg
PSBsYXJiLT5kZXY7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChmbGFncyA9PSBHRU5QRF9OT1RJRllf
UFJFX09OIHx8IGZsYWdzID09DQo+ID4gR0VOUERfTk9USUZZX1BSRV9PRkYpIHsNCj4gPiArICAg
ICAgICAgICAgIC8qIGRpc2FibGUgcmVsYXRlZCBTTUkgc3ViLWNvbW1vbiBwb3J0ICovDQo+ID4g
KyAgICAgICAgICAgICBtdGtfc21pX2xhcmJfY2xhbXBfcHJvdGVjdF9lbmFibGUoZGV2LCB0cnVl
KTsNCj4gPiArICAgICB9IGVsc2UgaWYgKGZsYWdzID09IEdFTlBEX05PVElGWV9PTikgew0KPiA+
ICsgICAgICAgICAgICAgLyogZW5hYmxlIHJlbGF0ZWQgU01JIHN1Yi1jb21tb24gcG9ydCAqLw0K
PiA+ICsgICAgICAgICAgICAgcmVzZXRfY29udHJvbF9yZXNldChsYXJiLT5yc3RfY29uKTsNCj4g
PiArICAgICAgICAgICAgIG10a19zbWlfbGFyYl9jbGFtcF9wcm90ZWN0X2VuYWJsZShkZXYsIGZh
bHNlKTsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBOT1RJRllfT0s7DQo+
ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IG10a19zbWlfZGV2aWNlX2xpbmtfY29tbW9u
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gZGV2aWNlICoqY29tX2RldikNCj4gPiAg
IHsNCj4gPiAgICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpzbWlfY29tX3BkZXY7DQo+ID4g
QEAgLTYzOCw2ICs3MDMsNTMgQEAgc3RhdGljIGludCBtdGtfc21pX2R0c19jbGtfaW5pdChzdHJ1
Y3QgZGV2aWNlDQo+ID4gKmRldiwgc3RydWN0IG10a19zbWkgKnNtaSwNCj4gPiAgICAgICByZXR1
cm4gcmV0Ow0KPiA+ICAgfQ0KPiA+IA0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJz
ZV9jbGFtcF9vcHRpb25hbChzdHJ1Y3QgbXRrX3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sN
Cj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBsYXJiLT5kZXY7DQo+ID4gKyAgICAgY29u
c3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gKmxhcmJfZ2VuID0gbGFyYi0+bGFyYl9nZW47DQo+
ID4gKyAgICAgdTMyIGxhcmJfaWQ7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAg
ICAgLyoNCj4gPiArICAgICAgKiBPbmx5IFNNSSBMQVJCcyBpbiBjYW1lcmEsIGltYWdlIGFuZCBJ
UEUgc3Vic3lzIG5lZWQgdG8NCj4gPiArICAgICAgKiBhcHBseSBjbGFtcCBhbmQgcmVzZXQgb3Bl
cmF0aW9ucywgb3RoZXJzIGNhbiBiZSBza2lwcGVkLg0KPiA+ICsgICAgICAqLw0KPiA+ICsgICAg
IHJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVrLGxhcmIt
aWQiLA0KPiA+ICZsYXJiX2lkKTsNCj4gPiArICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiBUaGlzIGxvb2tzIHdyb25nLg0KPiANCkkgd2lsbCBj
aGFuZ2UgdG8gJ3JldHVybiAwJyBoZXJlLg0KDQo+ID4gKyAgICAgaWYgKCFsYXJiX2dlbi0+Y2xh
bXBfcG9ydCB8fCAhbGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYl9pZF0pDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgbGFyYi0+c21pX2NvbW1faW5wb3J0X2lk
ID0gbGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYl9pZF07DQo+ID4gKyAgICAgbGFyYi0+c21pX2Nv
bW1fc3lzY29uID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShkZXYtDQo+ID4gPm9m
X25vZGUsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAibWVkaQ0KPiA+IGF0ZWssc21pIik7DQo+ID4gKyAgICAgaWYgKElT
X0VSUihsYXJiLT5zbWlfY29tbV9zeXNjb24pKSB7DQo+ID4gKyAgICAgICAgICAgICBsYXJiLT5z
bWlfY29tbV9zeXNjb24gPSBOVUxMOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCAtRUlOVkFMLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIlVua25vd24gY2xhbXAgcG9ydCBmb3IgbGFyYg0KPiA+ICVkXG4iLCBsYXJiX2lkKTsNCj4g
PiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+
ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9vcHRpb25hbChzdHJ1Y3QgbXRr
X3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSBsYXJiLT5kZXY7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgbGFy
Yi0+cnN0X2NvbiA9DQo+ID4gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNp
dmUoZGV2LCAibGFyYiIpOw0KPiA+ICsgICAgIGlmICghbGFyYi0+cnN0X2NvbikNCj4gPiArICAg
ICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiArICAgICBsYXJiLT5uYi5ub3RpZmllcl9j
YWxsID0gbXRrX3NtaV9nZW5wZF9jYWxsYmFjazsNCj4gPiArICAgICByZXQgPSBkZXZfcG1fZ2Vu
cGRfYWRkX25vdGlmaWVyKGRldiwgJmxhcmItPm5iKTsNCj4gPiArICAgICBpZiAocmV0KQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRUlOVkFMLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkZhaWxlZCB0byBhZGQgZ2VucGQgY2Fs
bGJhY2sNCj4gPiAlZFxuIiwgcmV0KTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgew0KPiA+ICAgICAgIHN0cnVjdCBtdGtfc21pX2xh
cmIgKmxhcmI7DQo+ID4gQEAgLTY0OCw2ICs3NjAsNyBAQCBzdGF0aWMgaW50IG10a19zbWlfbGFy
Yl9wcm9iZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgaWYg
KCFsYXJiKQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gDQo+ID4gKyAg
ICAgbGFyYi0+ZGV2ID0gZGV2Ow0KPiA+ICAgICAgIGxhcmItPmxhcmJfZ2VuID0gb2ZfZGV2aWNl
X2dldF9tYXRjaF9kYXRhKGRldik7DQo+ID4gICAgICAgbGFyYi0+YmFzZSA9IGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAgICAgICBpZiAoSVNfRVJSKGxhcmIt
PmJhc2UpKQ0KPiA+IEBAIC02NjQsNiArNzc3LDE0IEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9sYXJi
X3Byb2JlKHN0cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICBpZiAo
cmV0IDwgMCkNCj4gPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gDQo+ID4gKyAgICAg
cmV0ID0gbXRrX3NtaV9sYXJiX3BhcnNlX2NsYW1wX29wdGlvbmFsKGxhcmIpOw0KPiA+ICsgICAg
IGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9saW5rX3JlbW92ZTsNCj4gDQo+
IFRoYXQncyBvcHRpb25hbCwgcmlnaHQ/DQo+IA0KPiBJbiBmdW5jdGlvbiBtdGtfc21pX2xhcmJf
cGFyc2VfY2xhbXBfb3B0aW9uYWwoKSwgeW91J3JlIHJldHVybmluZw0KPiAtRUlOVkFMDQo+IGFu
ZCBoZXJlIHlvdSdyZSBmYWlsaW5nIHByb2JlLCBzbyB0aGF0J3Mgbm90IG9wdGlvbmFsIGFueW1v
cmUuDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQpZZXMsIHRoaXMgY2xhbXAgc2V0dGlu
ZyBpcyBvcHRpb25hbC4gTm90IGFsbCBzbWkgbGFyYnMgcmVxdWlyZSBpdCwgb25seQ0KdGhvc2Ug
d2l0aGluIHRoZSBJU1Agc3Vic3lzdGVtIGRvLiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCB0aGF0
DQpvcHRpb25hbCBzZXR0aW5ncyBzaG91bGQgbm90IGNhdXNlIHRoZSBwcm9iZSB0byBmYWlsLiBU
aGVyZWZvcmUsIEkNCmNvdWxkIG1vZGlmeSB0aGUgY29kZSB0byAncmV0dXJuIDAnIGlmIGl0IGZh
aWxzIHRvIGdldCAnbGFyYl9pZCcsDQpzaW1pbGFyIHRvIHdoZW4gJ2xhcmJfZ2VuLT5jbGFtcF9w
b3J0JyBpcyBOVUxMIG9yICdsYXJiX2dlbi0NCj5jbGFtcF9wb3J0W2xhcmJfaWRdJyBpcyB6ZXJv
LiBJcyB0aGlzIGFjY2VwdGFibGUgZm9yIHlvdT8gDQpUaGFua3MuDQoNCj4gPiArDQo+ID4gKyAg
ICAgcmV0ID0gbXRrX3NtaV9sYXJiX3BhcnNlX3Jlc2V0X29wdGlvbmFsKGxhcmIpOw0KPiA+ICsg
ICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9saW5rX3JlbW92ZTsNCj4g
PiArDQo+ID4gICAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiAgICAgICBwbGF0Zm9y
bV9zZXRfZHJ2ZGF0YShwZGV2LCBsYXJiKTsNCj4gPiAgICAgICByZXQgPSBjb21wb25lbnRfYWRk
KGRldiwgJm10a19zbWlfbGFyYl9jb21wb25lbnRfb3BzKTsNCg==

