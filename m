Return-Path: <linux-kernel+bounces-758670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C11B1D260
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2E97204E3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB1D218858;
	Thu,  7 Aug 2025 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BPpGTDbY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mZVE/S1T"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F4155A4D;
	Thu,  7 Aug 2025 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547564; cv=fail; b=DNFHe7fGK31a+IT5xnY3i3sKZfAw0y+PmWdPMIkYq8NdlV5aAJLQIOmE1YvzwopAhDqkJRffGqevHlYINI0ojimLfQF2qWMgzkLe4bpnw0KPX2SAyeP+26o6AlQXQY4agP87aD7Fftw/kTYt6g00Ta4ztVYI8rhL3wmPOLjEwZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547564; c=relaxed/simple;
	bh=jZAks1nUpoWPHSjfFDbVKNnhshrsezKC+PE8UOP0YXE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NYk9D47whs02d6WEB+wOo3bKXsKqfbKRfl7Go/AG4KnKTwAJTBfhJQYZjJsqjaNYkE0anSdQDaTFATrLpJxxNDym+sSNc3Xtmrk+o8+CbGoySTqnaN3j6e4NUGW5TLB8fK0agIXQbTCiZBhmUkZAJ57zRMAXEZSz1rcoRXCOR8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BPpGTDbY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mZVE/S1T; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6e4889ea735611f0b33aeb1e7f16c2b6-20250807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jZAks1nUpoWPHSjfFDbVKNnhshrsezKC+PE8UOP0YXE=;
	b=BPpGTDbYTMA1TaGn88v91jQZ2sgwmee/1Pk7LNsHfySyL2gwKeGp8hTQmyKneQPcogEbl2/u0gQ0rm01i6Q1utrxw/rN3s0Atr6Ial6VkOs5SM4R6CcUIn9LIVoh/q8LxuwhCStX1o7+r+/ohQzeevuFRQoWgq98888bd43Lv6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:526a2100-0231-4b9c-b0bb-2262b5e8b5af,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:28aa28ce-1ac4-40cd-97d9-e8f32bab97d5,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|51,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6e4889ea735611f0b33aeb1e7f16c2b6-20250807
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 268046639; Thu, 07 Aug 2025 14:19:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 7 Aug 2025 14:19:07 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 7 Aug 2025 14:18:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H45IaHLvaQb5G2s/aIDEADmTCkub5b/y5RJB3paRWiY3IaUgp74Z5yHY9ch/rw2lOzbSFDBUmaRF3CqdrXajvYqpb7WkdvFisLNibFDwlDnuUzt/7Ya+OO2wRcevhCsZDgThzVqv8uuWdotSWz4klfdv95YoE14xzDvPhULFgFFu7H7x/gOiNUqzKaKZ1+MH3mzwsQDMUO1zJhGFoXHReKfmoXGAHfYVDJJt540GMyQGeMH9HY84lU16iS1fAcJ9ikwtmIQGmTAOkmAu9IAT0tcLVNDqg7bpVbh0A5x7IHV9z1i5iN4ddW6hUSSSKnybeAOcmVa2NFU4butUwQmMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZAks1nUpoWPHSjfFDbVKNnhshrsezKC+PE8UOP0YXE=;
 b=lsmo9KUZ/Zo2t5kl3MhDZIxSVkRzlZDbWOjzGHYJj5+ExsoLFVxMjZcSsX3uWPgAy8tmjK/EqlZQiigp2VzuQ43wlmroMmJ0bTeJTut3S5HXMm/ZLE07wj/91u/N96ojqDnkfFm2M2w3OEYiRuzo5dKrymkTNUHuJDCwvM6RIWW8avIXO6qnJVIbOIT9M+SASc6rCkTag5iilABhZ6kfjp6hf5CJfQvunhkQCUKExj3GVm6LAcvdFMW2xHhsipHCYcV0x70K+UuSu06gDsjZaT9VwB05tC6OOtB5HSJFVjny2ulFbzIqEi4yHtPg8uooUmFVJz+ZlbR5kN4D8BNDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZAks1nUpoWPHSjfFDbVKNnhshrsezKC+PE8UOP0YXE=;
 b=mZVE/S1TZrrHKkIRjOv3QMETxajmgNbC+vYrqTeYbvDUuTyKLlT2pG3mJrJiXBU+jPYRggcJMVyJSiU4qXKCuUsuM/fzun+SDE1LJsc2N4r5PZWiz5pf1WazWL/8hp+RyZ1UnmRtt2DppUghRZUmJNJMcndoNm4l0PW6DMpre/s=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by SEYPR03MB7681.apcprd03.prod.outlook.com (2603:1096:101:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 06:19:05 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 06:19:05 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "hsinyi@chromium.org" <hsinyi@chromium.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Topic: [PATCH v2 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Index: AQHb/sZyZkzweQCVRkKZACLBrT9qjrRVO6yAgAGNHwA=
Date: Thu, 7 Aug 2025 06:19:05 +0000
Message-ID: <8b589879a5e4b60041bee5303697b2a6a707ee9e.camel@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
	 <20250727071609.26037-3-jay.liu@mediatek.com>
	 <a0e1845df41238678d3f5a568ea278ba7b1f0f61.camel@mediatek.com>
In-Reply-To: <a0e1845df41238678d3f5a568ea278ba7b1f0f61.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|SEYPR03MB7681:EE_
x-ms-office365-filtering-correlation-id: 30810fe6-f1ea-436f-3fea-08ddd57a4f9b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVhlTFJmZk4xSWZuQ0NkamFNNTZLUGFEaW5McVd1VWVLK1pkTWFHdUNjZUNZ?=
 =?utf-8?B?RW1IOVZodWdwYWRnUlFkTGZnZlVyRkdCV2wxL1g5K3ZqaXczWG9hSStZVzZF?=
 =?utf-8?B?ak1pRmprdDhkbnVvY2dFOGN2NDVlUEZsOGNGVWUwWU94NHFuaGNkNVNpZVdZ?=
 =?utf-8?B?ZFY2RW9pV0pTU3FOeWV3WlhUekFSK1Z5YllaY1pZaXVGOCt4SGl0SFF6emlX?=
 =?utf-8?B?Z2pPeUpZU2RFSVBtZlErWWFpZ2hOOTd2dE15anlEQnljMzN2SThTWU5pS3ZW?=
 =?utf-8?B?WVhwVTNzWXNiOHVFbEhqODhDdHdxMlhFcTI3NUpvN2lHR1Y4VXFaRzlBWEY4?=
 =?utf-8?B?bkxYQ1U4QXZXTi9YSndEMjZBaHAzUHI3WUpOblZidDIreWlWT2JGQnFUN3JL?=
 =?utf-8?B?SEYzOTUwdkw2R3VRWjQvTENSdm9aaktKNkxiWVFpRUh4UWppMFR2bzVRQTBT?=
 =?utf-8?B?ajNKWmExYUJXSWJaWUl5S2MxaDRZTHorTHZEZE9UZWk5K1hYZGRVSDhSWEh5?=
 =?utf-8?B?dVNyM0VybHRRdWVudGd4Mnd2MnpFRmpNSGw1OE56UUtHUG9WR0grcVl4NlFn?=
 =?utf-8?B?VWxJZytvV2tKaXRSSC9QaERtR0duTTJQaW9mMFZiZE5pK0IxUHpha0pqTjdV?=
 =?utf-8?B?aGcvbUgrY1ZMa1p0eTlhSWZrVjNtaENXODBibXB0UjhscUZ0LzhvaCtiNFd1?=
 =?utf-8?B?UVlUUWV1R0ZIVFRzOHVQWDFFUVlhSEVORCtjY3QrTmc2U1pmSnRHQ2ZKKzFm?=
 =?utf-8?B?NDFDbUkxS0dGeVM2WkxkTUVyTmJjLys0bnBBYTk2ZmpUTWlXYWNZRGh2ZkpL?=
 =?utf-8?B?Qm41TDNFbHJaRGVQQVY0S2VJUWZxcWhrV09FVTdtbDJhSWZnM0oraGQ5ZUtT?=
 =?utf-8?B?UUYwL21yNzNtVjFQOXlDandzVHdDUlh5WUxNUEMzUUdhWG0vVlFVQjZ5a3JY?=
 =?utf-8?B?UUtoYVozNDcwR3ZURmVSei9ubjlnUno2ZUNIRHFCUkQzcE9EaWwvSTZHUk5E?=
 =?utf-8?B?VG1VTEYxazN6OWhMTzFkaVJZMm14VHdWRWs4b3JaTi8vOFF0U2diZ1poSGFR?=
 =?utf-8?B?SHJMOFA4dG1kZGt0ZlNhWXE2Ullsck1lVDlWTDhoTUNUbi90YkpXNEp4V0hP?=
 =?utf-8?B?Yk96ZFFUUGFiZXlVSFFUdjFoK1UweFFhMEM3VVhEekJiNWlSdkhpZ2lpN2ZB?=
 =?utf-8?B?Wlhpd1hRZWNOM2hITmFqUFpEeFF4ZE01MGFMdlEzaDV4VE15STNIeStoYVNq?=
 =?utf-8?B?cVQvQ0JXVjhzZ2pyM0Y0SlpXNk5OOE5sdndFMi9HN1NkYUEwQTdSM0VDbEN2?=
 =?utf-8?B?WkhHNDBTNUpVVHdkaC9OMlZ0ckoydlFINW1qN0xoa3NXQnJDcUFrSVloWmxS?=
 =?utf-8?B?RW10ODdUb0hKNVJPMG53Z3R0d3BMcWVxZkNhRjBFZDlSVm91dEtYa2FNenZq?=
 =?utf-8?B?SjhnSUdTVkFISmJacUZ3R1FkeHF3QzRBVFp2NzFYd1o5a1lESzlTUkUxeThV?=
 =?utf-8?B?Vk5HNkNSUjJFeDlUTXBzcmt0OHhOdWtHTi8vQnhOUkJ0Lzcxa215SkJJSVBS?=
 =?utf-8?B?c3M0UzBGc1pYOTVPQ2pxdXJJT3pBM1p3VHRSRjF2YTlhYW1meFBPQmFVeVIw?=
 =?utf-8?B?T1l2bFZYa05WWDBuSThPY3NEaUVITjF1WWIvRC9yWEFTeC92RjdFa2dRc05x?=
 =?utf-8?B?bXNXZDVsOFBYTkU3cGdBSENMTHJxanJwVm5nc1crWmNrWXo5UDdVYW82NFdj?=
 =?utf-8?B?bFJFT1o3SHB1L2E3QmFNQlhXZ212WTVrUTJsQlFnMDd0OWpnd1RPZEloSytw?=
 =?utf-8?B?b1dQL3BxVHRETENNVjRKZCtPTjNmeDJWYjVHNUVIcC9ZRlNBdktSQWVpMWxv?=
 =?utf-8?B?elgzNUZITzY0Y2drbkZIM2orbnZjb2R5V3hWTkIwdjNOekIvRjBWUFExa1Zy?=
 =?utf-8?B?TTg1MFY2eHZZbWhWZ1kzN29QVUZVYnF4MlhVenQzZEQzbnk3ZHQxRGJpZ1BU?=
 =?utf-8?Q?ajfgxcgQRA6BUjgD4M7qlUlL6XFyMo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB8136.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHZEVCtraWwyZmVQcXFva1piMThIc1J0N2M5QkFxeGdwanVpbExoUXlCZmxU?=
 =?utf-8?B?Ti9zTXJTcXJHU284TlpZTk55dU1vYVgvVDhCb2cybzFDVW1qLzlWMEl0UlY1?=
 =?utf-8?B?dnA4RFhhVW9EVmhoS0FNY2x2Vk9Jb2xyTGhUVUhZdDlhdWNEZS9xNzdjRkFV?=
 =?utf-8?B?ZHdHbGhBc1lYUHR6QUVudUxGeFdmR1ZoVVBWUjdDMDB5ZnRsZFRLMnNQQVRl?=
 =?utf-8?B?czF2NENLT3VUOGYzQy94RjdXam9qeWNXMG9LaVRIMnY5YVRBMWx5ZkRGc1I4?=
 =?utf-8?B?WE9xQ24yQmlBUzE5aHJTZS9LVENYNDZWVTRKZTVpYStYdSt1aEUxOVJUNll0?=
 =?utf-8?B?bEJRbHJ3QktlQ2JOejExNVhyK2hGaitsZ01ILzBEMDFqekF3VEF5bXNOYVo3?=
 =?utf-8?B?Ky82UnZkczN6cnhzTEk0OVEyaUxxUXBiMldZdUlHQXRCOWZzaDd6Wjc3b1NC?=
 =?utf-8?B?ck5JMHVqZDVucEhJM0RZTExaYkh2elhnaCtGN2c4REVYMjNvaDZXa3VubGQ5?=
 =?utf-8?B?S2V6cmFWb2ZjSVM2anNjci9lT0xUeHAxNG4rMEczRGRXN0N6NTQycHNoTWpB?=
 =?utf-8?B?RXJLK2xndDFGbTJVeSt0VTdreEtXZmttNDQ2QWNWUUdHUkI4TS9PTFVGNkNr?=
 =?utf-8?B?TVd4eUFMT3NiVE5MMHRvelg3QnM1aUxlSkxmME8rOWNnR29LQlJPV3dPNUtO?=
 =?utf-8?B?VmhPK00zV1k1MlQvdklBT3BYU2RqNHRkckF5Z3pYL0liTFdHdnY5NDhhL2Yw?=
 =?utf-8?B?NjRIWG5NUXJiNkI5bWJvM1R1ZXIvR0lscDFHc05iaVZmNTJBZHAvbkI2ZnZN?=
 =?utf-8?B?N0haNXVhdlI5T29XellPVWFuSHAwUjdheGd3SS81bDBueVRybHZBQXlIck9z?=
 =?utf-8?B?VFJpaWpIMWNTVzh3SWQrNlJCZW9jQ1hiWkhQMVByQ2E1YlFRblk0RUZ4SU5X?=
 =?utf-8?B?cXI2ZGhudlBmNXNsdVFGeFJ6bnc4eDBkN1Bhd3VieVlrUFk3L2NjMDNyY05k?=
 =?utf-8?B?YjEvM2lFcUZxS3Mwby8xOVE3Y3p3OHMybmkyeGxvbWYwLzdreFBuWEJkZVpW?=
 =?utf-8?B?aXFJNkQ1OUF5L1FCQW13U0l2SDd2NGpQVVJHZlFxZVovMGxqVDdGbndScVk2?=
 =?utf-8?B?RXVHU1NDN1dtMENVRFZDeDdFd2gvMllSRjdhYXpERk1JWGhSUVJvVW9HVXla?=
 =?utf-8?B?ZFlQMEdMeCszMDhERWE3VkFZSEpISmlxVHpPdVlYL25WUk10R2M3aDN0YWp1?=
 =?utf-8?B?YU00Q3NibjRJek04U3ozUFNhM01PeUVid24rdys0UFBiSlNpclRBNWV1cHVF?=
 =?utf-8?B?Q2d2bmhuQ2xmaUZCZDhCay92TGJ0M0VtS1dLOW9STDBJakR2SGpWcm02YU5s?=
 =?utf-8?B?Qjg3UWVsWXNnRkNEcjlZL1VObGJVdDNIQ2t3YVV0QWg2S2hMcUlkSjJYSjNk?=
 =?utf-8?B?VFR4RVhJb01ocEo0SUJjWXFiSTBwYUJwd3NQU1A5NVhrN21qeVBlM2FDcTV4?=
 =?utf-8?B?L281RUJWcDNtd2QzUjBtb0s1eEdOQ1Y0bzNySzR4ZGhXTENOZTJyRHNibWpG?=
 =?utf-8?B?d1BEcVRzOEwvQVZ0eDZaaFZNcHoybkVzQU04RmF3WGZtL1RyZGk5SEZBanJY?=
 =?utf-8?B?NTJFaEpGS1J1bGJ6aUhHRmQrU012djJON2k3YWMraUNlWHZucVExejM2UXhC?=
 =?utf-8?B?Z0N0ODJSUjlXS0t1Z00zY1VFL09vZnFGNHpzaDQyTFNPS21hQnRmbm11K2E0?=
 =?utf-8?B?UmZFWS9IaHRlVWtndE92TTZHa3M2WDZadnZnbVBHaXlrK1dGSW1WZG9TUUM3?=
 =?utf-8?B?S1NGcXZyOXZhYmI2cTNsMEV4TzYvZFBTRHdOb3JySlMxazBnd0xybE5qS2xm?=
 =?utf-8?B?M3lxcXJYV2RPRTA2VXJqR0xOYlBLQlpvUFE1M09OclhhMnFSL3A5SjRVZGF1?=
 =?utf-8?B?V0lIWFNVRXhUU0tqS0xzRFd0bWlJUE55bnI2cEFsWjVvZWZTTFRFWHVwWkdB?=
 =?utf-8?B?Rk1xY2tKa3F2YmNHSmN0TjZaVkJSWDhsaHArNzFkOHVwbUY2TGJFOW05YjRN?=
 =?utf-8?B?N1kvMU1VVjhMa2FKUThtV09SV3BTVXl4ZVAxWFVBK0pkTkpkNXQ2ZXZiU0g5?=
 =?utf-8?Q?AH4ju4lfAlyni5oyFaRZyFHEx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C9CA5BF93F4EF428AA02E7250C20B2A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30810fe6-f1ea-436f-3fea-08ddd57a4f9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 06:19:05.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xK6iUmcfDD9SiwcSIpbm0TGKne64ohpJCZ36cabBjhHhoSzqj7gjrFQDkuVvoi3fZHvDhuy9av/YcgEiJOw2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7681

T24gV2VkLCAyMDI1LTA4LTA2IGF0IDA2OjM3ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gU3VuLCAyMDI1LTA3LTI3IGF0IDE1OjE1ICswODAwLCBKYXkgTGl1IHdyb3RlOg0K
PiA+IGlmIG1hdHJpeGJpdCBpcyAxMSwNCj4gPiBUaGUgcmFuZ2Ugb2YgY29sb3IgbWF0cml4IGlz
IGZyb20gMCB0byAoQklUKDEyKSAtIDEpLg0KPiA+IFZhbHVlcyBmcm9tIDAgdG8gKEJJVCgxMSkg
LSAxKSByZXByZXNlbnQgcG9zaXRpdmUgbnVtYmVycywNCj4gPiB2YWx1ZXMgZnJvbSBCSVQoMTEp
IHRvIChCSVQoMTIpIC0gMSkgcmVwcmVzZW50IG5lZ2F0aXZlIG51bWJlcnMuDQo+ID4gRm9yIGV4
YW1wbGUsIC0xIG5lZWQgY29udmVydGVkIHRvIDgxOTEuDQo+ID4gc28gY29udmVydCBTMzEuMzIg
dG8gSFcgUTIuMTEgZm9ybWF0IGJ5DQo+ID4gZHJtX2NvbG9yX2N0bV9zMzFfMzJfdG9fcW1fbiwN
Cj4gPiBhbmQgc2V0IGludF9iaXRzIHRvIDIuDQo+IA0KPiBZb3UgY2hhbmdlIHRoZSBiZWhhdmlv
ciBvZiBNVDgxODMgQ0NPUlIgYW5kIE1UODE5MiBDQ09SUi4NCj4gVGhlc2UgdHdvIFNvQyBoYXMg
d29yayBmb3IgYSBsb25nIHRpbWUuDQo+IERvZXMgYm90aCBTb0MgcmVhbGx5IGhhdmUgYnVnPw0K
PiANCj4gSW4gY29tbWVudCBiZWxvdywgaXQgc2hvd3MgdGhhdCBIVyBTMS5uIGZvcm1hdC4NCj4g
VGhlIHBhdGNoIHNlbmRlciBoYXMgbXVjaCBpbmZvcm1hdGlvbiBhYm91dCB0aGUgaGFyZHdhcmUg
aW5mb3JtYXRpb24uDQo+IFdvdWxkIHRoZXkgbWFrZSBtaXN0YWtlPw0KPiBJZiBvbmx5IE1UODE5
NiBDQ09SUiBoYXMgdGhlIGZvcm1hdCBxbV9uLCB1c2UgcHJpdmF0ZSBkYXRhIHRvDQo+IGRpc3Rp
bmd1aXNoIHRoZSBiZWhhdmlvci4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KWWVzLiBXZSBy
ZWNlaXZlZCBhbiBlbWFpbCBmcm9tIGN1c3RvbWVyLCB0aGV5IGZvdW5kIHRoYXQgdGhlIHByZXZp
b3VzDQpwYXRjaCBmYWlsZWQgdG8gaGFuZGxlIG5lZ2F0aXZlIHZhbHVlcyBjb3JyZWN0bHksIHNv
IHRoZSByZXN1bHQgd2FzIG5vdA0KYXMgZXhwZWN0ZWQgYW5kIHRoZXkgd291bGQgbGlrZSB0aGlz
IGlzc3VlIGZpeGVkIGluIHRoZSBjdXJyZW50IHVwZGF0ZS4NCldlIGFsc28gY29uc3VsdGVkIHdp
dGggdGhlIERFOyB0aGUgaGFyZHdhcmUgaXRzZWxmIHN1cHBvcnRzIG5lZ2F0aXZlDQpudW1iZXJz
IGFuZCBhbGwgSUNzIGJlaGF2ZSB0aGUgc2FtZSBpbiB0aGlzIHJlZ2FyZC4gVGhlIGN1cnJlbnQg
cGF0Y2gNCmNvbnZlcnRzIG5lZ2F0aXZlIHZhbHVlcyBpbnRvIGEgZm9ybWF0IHRoYXQgdGhlIGhh
cmR3YXJlIGNhbiBwcm9wZXJseQ0KcmVjb2duaXplLg0KDQpCZXN0IFJlZ2FyZHMsDQpKYXkgTGl1
DQoNCj4gPiANCj4gPiBGaXhlczogNzM4ZWQ0MTU2ZmJhICgiZHJtL21lZGlhdGVrOiBBZGQgbWF0
cml4X2JpdHMgcHJpdmF0ZSBkYXRhDQo+ID4gZm9yIGNjb3JyIikNCj4gPiBSZXZpZXdlZC1ieTog
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXkgTGl1IDxqYXkubGl1QG1l
ZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiAyMDIyMDMxNTE1MjUwMyBjcmVhdGVkIDxq
YXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Njb3JyLmMgfCAyNCArKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Nj
b3JyLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+
ID4gaW5kZXggODViYTEwOWQ2MzgzLi5iMDk3YzIwODc3ZjMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMNCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiA+IEBAIC04MCwyNyArODAsNiBA
QCB2b2lkIG10a19jY29ycl9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCXdyaXRlbF9y
ZWxheGVkKDB4MCwgY2NvcnItPnJlZ3MgKyBESVNQX0NDT1JSX0VOKTsNCj4gPiAgfQ0KPiA+ICAN
Cj4gPiAtLyogQ29udmVydHMgYSBEUk0gUzMxLjMyIHZhbHVlIHRvIHRoZSBIVyBTMS5uIGZvcm1h
dC4gKi8NCj4gPiAtc3RhdGljIHUxNiBtdGtfY3RtX3MzMV8zMl90b19zMV9uKHU2NCBpbiwgdTMy
IG4pDQo+ID4gLXsNCj4gPiAtCXUxNiByOw0KPiA+IC0NCj4gPiAtCS8qIFNpZ24gYml0LiAqLw0K
PiA+IC0JciA9IGluICYgQklUX1VMTCg2MykgPyBCSVQobiArIDEpIDogMDsNCj4gPiAtDQo+ID4g
LQlpZiAoKGluICYgR0VOTUFTS19VTEwoNjIsIDMzKSkgPiAwKSB7DQo+ID4gLQkJLyogaWRlbnRp
dHkgdmFsdWUgMHgxMDAwMDAwMDAgLT4gMHg0MDAobXQ4MTgzKSwgKi8NCj4gPiAtCQkvKiBpZGVu
dGl0eSB2YWx1ZSAweDEwMDAwMDAwMCAtPiAweDgwMChtdDgxOTIpLCAqLw0KPiA+IC0JCS8qIGlm
IGJpZ2dlciB0aGlzLCBzZXQgaXQgdG8gbWF4IDB4N2ZmLiAqLw0KPiA+IC0JCXIgfD0gR0VOTUFT
SyhuLCAwKTsNCj4gPiAtCX0gZWxzZSB7DQo+ID4gLQkJLyogdGFrZSB0aGUgbisxIG1vc3QgaW1w
b3J0YW50IGJpdHMuICovDQo+ID4gLQkJciB8PSAoaW4gPj4gKDMyIC0gbikpICYgR0VOTUFTSyhu
LCAwKTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlyZXR1cm4gcjsNCj4gPiAtfQ0KPiA+IC0NCj4g
PiAgYm9vbCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1f
Y3J0Y19zdGF0ZQ0KPiA+ICpzdGF0ZSkNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19kaXNwX2Nj
b3JyICpjY29yciA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+IEBAIC0xMDksNiArODgsNyBA
QCBib29sIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiBzdHJ1Y3Qg
ZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiA+ICAJY29uc3QgdTY0ICppbnB1dDsNCj4gPiAgCXVp
bnQxNl90IGNvZWZmc1s5XSA9IHsgMCB9Ow0KPiA+ICAJaW50IGk7DQo+ID4gKwlpbnQgaW50X2Jp
dHMgPSAyOw0KPiA+ICAJc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCA9IE5VTEw7DQo+ID4gIAl1
MzIgbWF0cml4X2JpdHMgPSBjY29yci0+ZGF0YS0+bWF0cml4X2JpdHM7DQo+ID4gIA0KPiA+IEBA
IC0xMTksNyArOTksNyBAQCBib29sIG10a19jY29ycl9jdG1fc2V0KHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gPiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiA+ICAJaW5wdXQgPSBjdG0t
Pm1hdHJpeDsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShjb2VmZnMp
OyBpKyspDQo+ID4gLQkJY29lZmZzW2ldID0gbXRrX2N0bV9zMzFfMzJfdG9fczFfbihpbnB1dFtp
XSwNCj4gPiBtYXRyaXhfYml0cyk7DQo+ID4gKwkJY29lZmZzW2ldID0gZHJtX2NvbG9yX2N0bV9z
MzFfMzJfdG9fcW1fbihpbnB1dFtpXSwNCj4gPiBpbnRfYml0cywgbWF0cml4X2JpdHMpOw0KPiA+
ICANCj4gPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGNvZWZmc1swXSA8PCAxNiB8IGNvZWZm
c1sxXSwNCj4gPiAgCQkgICAgICAmY2NvcnItPmNtZHFfcmVnLCBjY29yci0+cmVncywNCj4gPiBE
SVNQX0NDT1JSX0NPRUZfMCk7DQo+IA0KPiANCg==

