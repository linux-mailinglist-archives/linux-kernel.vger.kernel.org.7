Return-Path: <linux-kernel+bounces-722687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB53EAFDDB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEA61C26558
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CECF1DDC2C;
	Wed,  9 Jul 2025 02:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="huYt1uZY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HiYsvTf2"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42B3208;
	Wed,  9 Jul 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029544; cv=fail; b=l/IuOu8TW0jcIInHN4oK9pHTSXF4g9odjWmSJTpgaEw6IZQtbeV/PBEcVqCQ+gwGwuZkTzc7+xTfpePUssgogImtQXN7H9xPKFyZA8A4uLfCffCPDLhZOiFer9PBw69evQ+FrTSh6kqYcl2JWXNXqAv9+cvRjkeW6nKpRq9kTcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029544; c=relaxed/simple;
	bh=kbEeOGY8/7KHGJKe4Pjzf7nrR5P8FxCvN2V7dSlmfb0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r5baZt4O+qJBnXXV0AEXoKGk70pe1QkbSY4I4OTYOVnTjJ6OnGqSh+JB5/IclCpqpmYE6QtIz4k0vhz5EDuSti0lm97olozNo4LcW8RVDOk5vzaj3VsPS58Dk21LmNBU2Wrnild5Js+6THW+yfngZHkb1kkPlubAxxRS5BSgSAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=huYt1uZY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HiYsvTf2; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b4010cc65c6f11f0b33aeb1e7f16c2b6-20250709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=kbEeOGY8/7KHGJKe4Pjzf7nrR5P8FxCvN2V7dSlmfb0=;
	b=huYt1uZYRIZgv+3uLxH2KklwSfareRi8uB67+Lout1mAc9HA8yxKV9sAnHfQerrhCuGxqxxO3gvt00Dg1la2tHx5gq8eKkRvgB+LAFtwuXIJwJnfptR5P09LW/xYTqfp2jtOx9F42NvfJSgl6hLFAClARlVHe9qygMY63TmQzSY=;
X-CID-CACHE: Type:Local,Time:202507091052+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:ae75a5da-2ada-4133-a91f-0c618620a04c,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:9eb4ff7,CLOUDID:3e88f5de-2070-40bb-9c24-dfabef7c07f4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:11|97|83|106|99|80|1,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b4010cc65c6f11f0b33aeb1e7f16c2b6-20250709
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 227739982; Wed, 09 Jul 2025 10:52:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Jul 2025 10:52:05 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Jul 2025 10:52:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkAEsNlfAskt4st5hRlDesHmCr6yD9v5JKQJWHu+3zNCs/8Gx+JV6JhurlQgsWbJusDgCw+Bbwy0CqkHKd8IURm5hQuI/+vj1ps8AnGMhMZqONLhd9+0a+/mWDRDOQN8MkqH7WXMYa37Q72n4756TNsG5Nevj+sYD7e6RiouTwAu2oXX3M64TymNFi2a6Qbq0pGu6SANNeYku1fjpU09wcb95dOzmC8oOD6v1VqjPIoF4c9/ZVnfdNVF/tdQqU+oJJeSCuulSD4fvbNjYZG8Hlskj53+ZzuzWWBVtyLCl495uGOXM6R/hZHi4L1kyVExUhXeulJdo0xWxmg80C2d+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbEeOGY8/7KHGJKe4Pjzf7nrR5P8FxCvN2V7dSlmfb0=;
 b=JpvS6xaX/8At3uNIX9ch9nJyy5xvEXomLFsNm3JwUpt9IFDpIFEUS0ZcrAh5mLXx+CzSMp1dZU+CSQkuRwTziIPpE708xJSrizWbUs/fkeEvt+an0HRl0UF90juK4wF2CKD9trWM6UqU6/iQmrFOxTtt7GOoiw/WMiGR2i3uFxdp2VOsNbn2yK1jqggjkDZ/p9Xv7dg4JBehBaRsVlQY4txW9fwa86d23wYf50PXsXnLyq2x98xDTStvwTMHsTfdkZQPIjpbmMmuQ8isFdOjpWQK6H80QLNMlJhC5uIHzgnmRI5eA/EX/0/Cmo6AgPkis99CEIIlISO32Mn9eBXylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbEeOGY8/7KHGJKe4Pjzf7nrR5P8FxCvN2V7dSlmfb0=;
 b=HiYsvTf2nvXZlErnyhTQOkEVdUOEJNJMGeDPxAAG5whndNNDfCIpnkxS1vHIVBaT7Ex7bZoE3dQ3Rvm15ZdmaPfEsMaJrwbNt5Qh6MstLQp9xCL65/CkNBGExwzfkUqh32x1guxbZpy8TdkktS2f8wqQaWypJAg0i/OqIt3x/A4=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by KUXPR03MB9440.apcprd03.prod.outlook.com (2603:1096:d10:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 02:52:04 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 02:52:04 +0000
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
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAkVMoA=
Date: Wed, 9 Jul 2025 02:52:03 +0000
Message-ID: <a72ff8bbd8205698948bf5be2c71d93f41a20ec1.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
In-Reply-To: <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|KUXPR03MB9440:EE_
x-ms-office365-filtering-correlation-id: 6ef4f6f9-3326-4e9d-f9d1-08ddbe9395da
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WHRNN25pdGZzdlZIWCs0eTNPSjVBc294MkczbC9EREFkdlhOOHRmeVpQQktw?=
 =?utf-8?B?S3kwbjkzMkZ5MEQyQUR0RUtLanRFcW13M2IzZlg2ZjZ1SHRSRk9uWFVlSlNB?=
 =?utf-8?B?enE4M01jKzdIYnlEQjVhTlgwNU8rU3FvQTR5aFdlUGJjYkVpLzI0SHMvZ2ls?=
 =?utf-8?B?NFJCQUNCSThyRDBZT1I4emxURWcxNU45YzFudmc4dTRmL0JKeXV5S3B2MGJY?=
 =?utf-8?B?Z0JFdmJVRTA5dmVSTytaY01JVlpZVmpqbW1RdmNpQjRodFVWa0RBQk84Rm1o?=
 =?utf-8?B?WFlwNkZHNHBVK3EzS3NWMFUzVkNlejIrVHFYQytFRlZ5ejlKYk82LzRMSklT?=
 =?utf-8?B?ZDVJMWdacVlpdVc0V1I5Tk4wUUUwb0NVZTBjUGNuVm5JcjVJbFg1UzRNVUNO?=
 =?utf-8?B?Wm1uZmYwM2c0K2ZUeSs4dng2QkJDUXoyc1FxUy83SWZiVlR1RFcwczY1eU1t?=
 =?utf-8?B?QkE2RlhKRjQ3ZFlGeURsanF2TWdDaW5DTm5OcVpRVyt6QjRTZ1BaajlpV2Iy?=
 =?utf-8?B?YmNuZmFOYmN1RVo3RWlsSWV2QThDU0thVE8vaE9iclhBayttbWozbGJXMytu?=
 =?utf-8?B?RU5iSWlYWHpLeXB4NjBlbElYSExNT1hPbFlwRUJLOStrRENpdG50dXlkT1lK?=
 =?utf-8?B?N3dpSHMxRkhDWGFvYjlHMEtFWmdzVVBrNmF5SmRxV3lNSzhueEJxV2gydHhH?=
 =?utf-8?B?UDFHczFaRVo0QTNiSzVJemNwL3JTYWxBc0tmTFBDcWQ5SW90VWE0OWQwMlFD?=
 =?utf-8?B?OXdvQUxuL3h1Y2FMUEsyOWd1NjdFNjJ1WWRsb1J2ZFJXQVFmbmp6M3hPekt2?=
 =?utf-8?B?UFl0VVhaRWR6UFFhYW43aDZUZzcvdFR0R0c0TjNsaE5mU3BxZHNaa3lMelpP?=
 =?utf-8?B?N2VlV2NLRXdESDEveDF5VEQwMzBMWEtWdy9rK2FxaldhUFFJUW1BbzZKKzdG?=
 =?utf-8?B?bytPMWI3b1YxN2tlOHpOa3F6Rm1GYUFkYUd0NXpVNHoyWUIxeUxkSld5d3Jn?=
 =?utf-8?B?VWZnUmw2blZqWUVDSXMwRkNWQlRycGpyM2dhN2RZYnB6a2tXVGc0aWpLdHBM?=
 =?utf-8?B?aU1DZ083ZUtSVVpjdGh1dFVpUDV5bDlVWXhSUjdPcXBOM2hDcEdvNE1EcTJ0?=
 =?utf-8?B?RGxUaU5jRDhzcmIxcXpYbDB3SS9mTmU1NlQ3QjVuZmFkMWlRVVlFT2lQSXFI?=
 =?utf-8?B?TzdmdnIwUmZtc2VQaXZIU0FGSm5OcXFoaVFkQ0FVdldoUG5nQTZSV0tRNVJL?=
 =?utf-8?B?U0lTRkVNdmI1OHJoN2ZNZk01NzJnZUdFOHRUVUtzdFZQSkZDWjlPdTJrT0VT?=
 =?utf-8?B?bkR0eDhqQWlpYmlCVjVmbFIrZlVYUEpGMTZpVzBNR3RUL2ROM3NVdGVMNHV1?=
 =?utf-8?B?Y05saFJXUkdSa2lmRjduQ2xQK1Q0aVF3K3VRZlJIVDJlVy9WVHlBMHp4Wmtx?=
 =?utf-8?B?S1VpMXlvSnljT0hNTDJoNWlFaGhJRndHZ3BzUUJjMDJQVWRTa1JxKzRhajE0?=
 =?utf-8?B?bkxTWFNBVmdzRE5XVks3ekpjN2NwNHh3STYxMlk4V09YRnlpN1BnaHJ5ejNJ?=
 =?utf-8?B?MnNpNk9aMEJNTnoxczBWT0gyNFlpRjdvMkVBaXFSemRPdGhic3FXYnNvWHRV?=
 =?utf-8?B?NHBqbkJTRmQrME4wdlFDbGdjbDNVNGhXZHZSc1BKdEhhVWlEWVlUNS9FWlZz?=
 =?utf-8?B?aEZCenJsdUtRd1VvQmw2QURoY0JIaUN0NER3ZlQzcVZZZ1RYN3hFaDZSanBa?=
 =?utf-8?B?alJnMzdSWTdJTzlIWXJCYUFKaUdtL3FOMG53OHBRNkd6ODRhTWxzS2NNS0Vq?=
 =?utf-8?B?b1JsdEJnb2xzNVJ6ZnczZTMwaTdhSmtWM1IzeGR1N0RjdWVRVStTSEdCSHdF?=
 =?utf-8?B?MHkzNk5UZmFVMXp2L0xGcjM0VHFweUlOSUVCekU4WnJ1N0JMQzZXYXZIUGZI?=
 =?utf-8?Q?DkcE4dlCPZ17EBJ7XuJTviOzTxRb8KGB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3N0WUFIWVl4MEdmeForSnRncjhvMUtxZE45L2NkRy93VkNFNEdUeXl1aUVQ?=
 =?utf-8?B?c1dsWVdjMTNrYy9iOS9Nc3pTN2x3VTdUZ3hnM2ZJNjNZR09zYWFFT3FoN1pN?=
 =?utf-8?B?OFNHdCtHbW5ySDE2cVQ3S1NqZE56Wk9tQ0lrUi9rTnVJNlBTUUdGYjQrZmMy?=
 =?utf-8?B?UG8rNjZjVVJTR1UwTGoyV0hLd3VWdThiVTVURzJPOVp0dFVvajd2bnVpV2xX?=
 =?utf-8?B?YVZ0dUxtbjFZOTlOZmNyQnU3ZlFiSXpuTGZlaW54cDF5bnJqUEc2L1J0VUln?=
 =?utf-8?B?ZUdqR2RDV2ZJTFZCaTZ5eFJFUzgvMkRWNXlXbDY3bUhBV3FRMkxsay9acWJh?=
 =?utf-8?B?aloyQzk5ZGs4TER2YmFrL1QrY0c3UzZHSEZwMVVsQXFId29TU2wwa0NBbVAz?=
 =?utf-8?B?amN4YW5RV0R2RzhCdlZsMHFWUjV1ZkRxTjlWdnhTTHdvVXNPU3NIU3VPN0JH?=
 =?utf-8?B?czNJWlRhaVR1dVRZUE5mS1JTc2hBREFKdW4zVTk5WGxabk5ZNEZYejYxditB?=
 =?utf-8?B?Snl0dUFKOHNjeWtNQ1JhYjI5Mkh5N294dzI2T3VLMnZubjZKcFc2QTJlZnNI?=
 =?utf-8?B?UVVraWUvMUlVSmJaSVIzbENHMGx3bkhsdUZRQlhUWTFoWWR2VmJPNmlnSEty?=
 =?utf-8?B?RmNJdGZUT3ZzSjBHYjNqME95Z1poVEMrQlRCTWpKNWdLYkpab01FRnlzdHVk?=
 =?utf-8?B?dnFUdUxNM3F5S3krQi9DTUMyQWFieHJNbWdJZ2xtbUxJSk1QOGNjck94ZG9O?=
 =?utf-8?B?aWsxclR4ajJSNDd5cXY1b1cvRVY0UGlqcUxoK0VRRGtuN09DYmhYbXBiNUlp?=
 =?utf-8?B?bGJ4ckhGQmRtL2VnMk1FR0xsWXlRSWpYZ1BVbTRuS1I1a0FFcGNTUTdhYzNO?=
 =?utf-8?B?V2I5MytMVFpmdy9HUDZ4aXAydWVTQWI1Tjd4clkrZU1PQTVFL0J0MkFTa0FO?=
 =?utf-8?B?cWo5amdsUnV2UHMzZUlrU0V0Y014RGdaNmUreGYzSWtjYVdDWHFpYnRVWnFP?=
 =?utf-8?B?a1lvNytoUUF0aVlqMHlQMnM1Yy9MUGs5emFLeC9HSTJsNVlZZlFsWEpMcDVI?=
 =?utf-8?B?NVpSSzdHd3F4NGx3bXRDWXp2WDZQS0tSRzhsZXpsMFdtOGxoUDNnMDZpbGY3?=
 =?utf-8?B?OEo4RC9JUVYvSHp0VVRsMi9NMS85eE9WOTlzeHFJc245a3BRaHJNNUVCZ2xo?=
 =?utf-8?B?NlB4blpJK2R1NnFNaHFUVWNRQjZwNmZjOHRJdnNabGRYVkFlelk3b0RiazNC?=
 =?utf-8?B?cDErOWlYYlN3aGxsVnZ4NDVsNTNzeDE2R2Vob1NiQlBGWjFRK2JKbVF6dTh6?=
 =?utf-8?B?ajQ2RWZGakxPWTBSc1NoWWlZNlVrdHVxR3pRSjE3RE53RTFmSlJoMHpzWW9Q?=
 =?utf-8?B?Wnh2dC9iQk1VRkx3RDdEVFBod1NXZVlyM3NGaXcxV3BXSU1NNmVZK1VzTnFP?=
 =?utf-8?B?em1OMzNiNTVhTDFNbkJGd1FMZUM3UkFQUjFvUGdtTE1OK2JhaWpya05WbEla?=
 =?utf-8?B?YVFjOHE4Yy9JTmJtZVdVczk3dGhObGR1WTZEcEZzd2FFcXFjTks0WUpsSHdP?=
 =?utf-8?B?Ukx5U3o5Qm9WTFFnT1pFUEZnQk5vNVdNQnFGcEdzL2dBUTBWVGE4R3I0cC9F?=
 =?utf-8?B?T2p1NGV4STNXbTZncU5lalZsSG9pMlRFeTE2bTl6NTZkcTMrU25Wb1JFdFFD?=
 =?utf-8?B?OXF5YVJyV202ejJTeW9hZVdOYWhzVEpSck5JL2htbi9MejlvZHVmaXBaQ1Qx?=
 =?utf-8?B?SVI2OVZPa1VnMEdxTmhySll0UUQvbEl0UVlTWjRiRUhkMzZoMmN6bGYxV2xZ?=
 =?utf-8?B?UnpmajJJd21VcTladzBJTzIvSkJuN0RkTDJzWitrWVQ3TjZtb1RxbFhNaWhu?=
 =?utf-8?B?R0cxK3RLNmJQZ2JEU3ZTVmpWbXBDOU9kcjlOK3pnL0srTGZhVERlN2xyZ2kx?=
 =?utf-8?B?NEk3ZUZEcWh1c3ROb3ZnQlY3bkY1ZlRlb1FHcXU3QTVHTlRTbUM3dFRqWmo2?=
 =?utf-8?B?VldxdVBsWnowNnZxTFlJVjNteXZTYWdZRmdjdVNmU1VROHpra2pqeHhyV1d3?=
 =?utf-8?B?NldtRXFPYWU1cC94UjRtTlloWjBFb1o3WnlML1g2NnBkOXVFcEJNdXJuVG1V?=
 =?utf-8?B?Y1FvdXBrWmlhbmRtMUZ1V20xblhlWGNka09zNFZhY0ZFaHJmZitGU2JkN2xw?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B836DDD0ADD1984AB8009A76FBCAA01D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef4f6f9-3326-4e9d-f9d1-08ddbe9395da
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 02:52:03.9940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2afaAAIEKV8xGGoUVfrLLt1xSDh2/6jei6296hMQPMGZxXuAKdEJawcNWLQAtAKVctOeGUe74B9xnF73gq1i77flZj9owUqKJKHblzDwcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR03MB9440

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDEwOjA4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDAzLzA3LzIwMjUgMDk6NTYsIGhhaWxvbmcuZmFuIHdy
b3RlOg0KPiA+IEZyb206IEhhaWxvbmcgRmFuIDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+
ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIG10ODE5NiBkc3AgZG9jdW1lbnQuIFRoZSBkc3AgaXMg
dXNlZCBmb3IgU291bmQgT3Blbg0KPiANCj4gUGxlYXNlIGRvIG5vdCB1c2UgIlRoaXMgY29tbWl0
L3BhdGNoL2NoYW5nZSIsIGJ1dCBpbXBlcmF0aXZlIG1vb2QuDQo+IFNlZQ0KPiBsb25nZXIgZXhw
bGFuYXRpb24gaGVyZToNCj4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9l
bGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMTcuMS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9wcm9j
ZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QqTDk1X187SXchIUNUUk5LQTl3TWcwQVJidyFtaENC
OGNROU5ZNEF6dGRFckpXYXkzVnRGTkhTZTg5aTAwVGdHZVRkNjJXNm0tSW9zNDZYZURhWXFNMFFR
N200U0hqbE53NjlQdlU3VDlNJA0KPiANCk9rYXksIHdpbGwgYmUgdXBkYXRlZCB0bzoNCkFkZCBk
ZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRoZQ0KTWVkaWFUZWsgTVQ4MTk2
IERTUC4gVGhlIERTUCBpcyB1c2VkIGJ5IHRoZSBTb3VuZCBPcGVuIEZpcm13YXJlIGRyaXZlcg0K
bm9kZSBhbmQgaW5jbHVkZXMgcmVnaXN0ZXJzLCBjbG9ja3MsIG1lbW9yeSByZWdpb25zLCBhbmQg
YSBtYWlsYm94IGZvcg0KRFNQIGNvbW11bmljYXRpb24uDQogDQpUaGFua3MuDQoNCj4gPiBGaXJt
d2FyZSBkcml2ZXIgbm9kZS4gSXQgaW5jbHVkZXMgcmVnaXN0ZXJzLCAgY2xvY2tzLCBtZW1vcnkN
Cj4gPiByZWdpb25zLA0KPiA+IGFuZCBtYWlsYm94IGZvciBkc3AuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE5Ni1kc3AueWFtbCAgIHwgOTUN
Cj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5NSBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9tZWRpYXRlayxtdDgxOTYtZHNwLnlhbWwNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQv
bWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sDQo+ID4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY4ZjU5NGY0NzZlOA0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvbWVkaWF0ZWssbXQ4MTk2LQ0KPiA+IGRzcC55YW1sDQo+ID4gQEAgLTAsMCArMSw5NSBAQA0K
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2Up
DQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc291bmQvbWVkaWF0
ZWssbXQ4MTk2LWRzcC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbWhDQjhjUTlOWTRBenRk
RXJKV2F5M1Z0Rk5IU2U4OWkwMFRnR2VUZDYyVzZtLUlvczQ2WGVEYVlxTTBRUTdtNFNIamxOdzY5
N3FIMXQ2QSQNCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJO
S0E5d01nMEFSYnchbWhDQjhjUTlOWTRBenRkRXJKV2F5M1Z0Rk5IU2U4OWkwMFRnR2VUZDYyVzZt
LUlvczQ2WGVEYVlxTTBRUTdtNFNIamxOdzY5RWRESGdOWSQNCj4gPiArDQo+ID4gK3RpdGxlOiBN
ZWRpYVRlayBtdDgxOTYgRFNQIGNvcmUNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsg
IC0gSGFpbG9uZyBGYW4gPGhhaWxvbmcuZmFuQG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rl
c2NyaXB0aW9uOiBUaGUgTWVkaWFUZWsgbXQ4MTk2IFNvQyBtdDgxOTYgY29udGFpbiBhIERTUCBj
b3JlDQo+ID4gdXNlZCBmb3IgYWR2YW5jZWQNCj4gDQo+IE1pc3NpbmcgYmxhbmsgbGluZS4gTG9v
ayBhdCBvdGhlciBiaW5kaW5ncy4gQWxzbyBkb2VzIG5vdCBsb29rDQo+IHdyYXBwZWQNCj4gYXQg
ODAgKHNlZSBMaW51eCBjb2Rpbmcgc3R5bGUgZG9jKS4NCj4gDQo+IA0KT2theSwgd2lsbCBiZSB1
cGRhdGUgdG86DQpkZXNjcmlwdGlvbjogfA0KVGhlIE1lZGlhVGVrIG10ODE5NiBTb0MgY29udGFp
bnMNCmEgRFNQIGNvcmUgdXNlZCBmb3IgYWR2YW5jZWQgcHJlLSBhbmQNCiAgcG9zdC1hdWRpbyBw
cm9jZXNzaW5nLiBUaGlzIERTUA0KaXMgdHlwaWNhbGx5IHVzZWQgYnkgdGhlIFNvdW5kIE9wZW4g
RmlybXdhcmUNCiAgKFNPRikgZHJpdmVyIGFuZCByZXF1aXJlcw0KcmVnaXN0ZXJzLCBjbG9ja3Ms
IG1lbW9yeSByZWdpb25zLCBhbmQgYSBtYWlsYm94DQogIGZvciBjb21tdW5pY2F0aW9uLg0KIA0K
VGgNCmFua3MuDQo+ID4gKyAgcHJlLSBhbmQgcG9zdC0gYXVkaW8gcHJvY2Vzc2luZy4NCj4gPiAr
DQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBt
ZWRpYXRlayxtdDgxOTYtZHNwDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGl0ZW1zOg0K
PiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBEU1AgY29uZmlndXJhdGlvbiByZWdpc3RlcnMNCj4g
PiArICAgICAgLSBkZXNjcmlwdGlvbjogRFNQIFNSQU0NCj4gPiArICAgICAgLSBkZXNjcmlwdGlv
bjogRFNQIHNlY3VyZSByZWdpc3RlcnMNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogRFNQIGJ1
cyByZWdpc3RlcnMNCj4gPiArDQo+ID4gKyAgcmVnLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+
ID4gKyAgICAgIC0gY29uc3Q6IGNmZw0KPiA+ICsgICAgICAtIGNvbnN0OiBzcmFtDQo+ID4gKyAg
ICAgIC0gY29uc3Q6IHNlYw0KPiA+ICsgICAgICAtIGNvbnN0OiBidXMNCj4gPiArDQo+ID4gKyAg
Y2xvY2tzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG11eCBm
b3IgZHNwIGNsb2NrDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IDI2TSBjbG9jaw0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBBRFNQIFBMTCBjbG9jaw0KPiA+ICsNCj4gPiArICBjbG9jay1u
YW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBhZHNwX3NlbA0KPiAN
Cj4gSXNuJ3QgdGhpcyBjYWxsZWQgYXVkaW9kc3AgaW4gb3RoZXIgYmluZGluZ3M/DQo+IA0KWWVz
LCBidXQgZXNzZW50aWFsbHkgaXQgaXMgdGhlIG11eCBzZWxlY3Rpb24gb2YgdGhlIEFEU1AgY2xv
Y2suDQpTbywgd291bGQgdXNpbmcgImFkc3Bfc2VsIiBtYWtlIGl0IGNsZWFyZXI/DQoNCj4gPiAr
ICAgICAgLSBjb25zdDogY2xrMjZtDQo+IA0KPiBEb24ndCB1c2UgZnJlcXVlbmNpZXMuIEhvdyBp
cyB0aGUgcGluIG9yIGlucHV0IGNhbGxlZCBpbiBkYXRhc2hlZXQ/DQo+IEhvdw0KPiBvdGhlciBk
ZXZpY2VzIGNhbGwgaXQ/DQo+IA0KPiA+ICsgICAgICAtIGNvbnN0OiBhZHNwcGxsDQo+ID4gKw0K
PiA+ICsgIHBvd2VyLWRvbWFpbnM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

