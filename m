Return-Path: <linux-kernel+bounces-793684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279E9B3D6C5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB6C18969B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44A1E102D;
	Mon,  1 Sep 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="liruYLfL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vlAf2gAB"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A0F27450;
	Mon,  1 Sep 2025 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694743; cv=fail; b=GLJtF2cF+aJFG+UC1fDIupr66fs2xyGpJNTWLHMcPytavpfj1k/LTlLSaLTwV89J8ZjFkYUxfNg+XZ7MZF3VvYhycixzBSduDbzNSDZmR2VoeSBs/EO0F4yJ32+aMsAJNnGdYXHVeREoXT6c0aqROdiL4N7XLKdL/geFIZEe7rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694743; c=relaxed/simple;
	bh=poeXZDCePkWPq4qe6Z0FsnH1LHgQ42t/U/fWaUukcLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W9/jOn7jyyYBvA4iUXJEwWic0Kp37PUBJbzU3rAE3HF1MXsNwxr4w2O2avv8VXLNbJ5+nWJTweN9dnl54JFPsiCIC/OEz7H2lIRCRx8ZhtRgRGc4wqr8tH8T1gzFfdwJkn5/WHp3/WkHJbBHlG3LHXSajViWxUqIif5cEWBhULk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=liruYLfL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vlAf2gAB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b7983f7e86dd11f0b33aeb1e7f16c2b6-20250901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=poeXZDCePkWPq4qe6Z0FsnH1LHgQ42t/U/fWaUukcLA=;
	b=liruYLfL0Z/pQaUjCqFx9hGP+oGmZ/bnUnar+vAKVzYmuGSNO6/Rf1yTXuSXnkHPXcvw2CJ9Fv5CMFbQeVH0IaDZH+/7MXqqPOfkg6Zl1WM3pFmKHCrqQ2ApWdDcBESH2XxVM/9yrqlgQFJGOLyy5N1F8An0uQGnPqQPVl2wGUw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:a26178f6-69c2-49b8-954e-5691b79cdc01,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:627b0e6c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b7983f7e86dd11f0b33aeb1e7f16c2b6-20250901
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2095705559; Mon, 01 Sep 2025 10:45:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 1 Sep 2025 10:45:25 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 1 Sep 2025 10:45:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHAusl8J4nFg5nu23jH34q2fkoFcUyFZHzm9Y8G8LLZvOenrpqduz6KGpID8Sjvu2KCH+YzoeOBrwGD8usY0zvgxMps5lwIx+OOgwBqTCp2QTzYGG2ihbq77rmaTzPQGOv9qjdLzIjd9GcEnivCT9nE3CRR+C3y0dt6JWnfU5xL7sBdE4gt859eujb4m27RBav6XSDGsSZpdeVxdajCJg0RNQbBjLwxsWs6/wh1tBINSX41kFlZvyparp36lTPN2WqPAEd43NOpS8CTB6H31PE2ArIWOPXnVYVGrpPfpOlybwMzVZ0J/d+nRReK/cjpnxrgz1LX6D0DRmv/WE+rF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poeXZDCePkWPq4qe6Z0FsnH1LHgQ42t/U/fWaUukcLA=;
 b=Oa9O1ZdZLrBrIOi4fWj02fiQHREksbqOSMxMwMfwtp+VBomxwqI2BnQoXwXtX+BPPDZ0kKX82u7twQwmNhSHc0gXphkjCmkfXTDx8PTNEAoiw5xInN80gkaNSVm86Y0vxLcD/CR6YBvOe1pLv4bTrLjmS9V3cuthnAJbZDYLSS920xqwhamhPY/BIM1T3Q/hT1NQEwMceECQttrYzfNTu9IwEcdpLTTfi3HlmLgfFwe6zdr+UNH/av70bVNl3M4Kcmu8wGNQx0AW/SFLTShdDvOb5ce/bx4vcRHsJRAncg0jrZux+cB0ssEgEOS299abUw2sjSGPvZD1DI0ikUnHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poeXZDCePkWPq4qe6Z0FsnH1LHgQ42t/U/fWaUukcLA=;
 b=vlAf2gAB6sO/pPHs4IwwCvtEWK+64cvMbnzpLykHypttcslW4F1PSnlk7rQ2po3nkeEvATZ3XuT9GncprxAKLvd1mzowSIJ3QVHiQ91TvEzolvKX2dnX4+3ZvDS4N9daC5LTGfiKzTJymUWFtXOsFT/a9j5ZNUPXv+DeKp8Ntnw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB6976.apcprd03.prod.outlook.com (2603:1096:820:b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 02:45:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 02:45:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v4 11/19] drm/mediatek: Rename OVL format naming
Thread-Topic: [PATCH v4 11/19] drm/mediatek: Rename OVL format naming
Thread-Index: AQHcF/NLXLZkMyhcfE2WiqvOmrVYJbR9pQMA
Date: Mon, 1 Sep 2025 02:45:21 +0000
Message-ID: <06e8b1c561ff54f1946cc3727e8f95420c5a337a.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-12-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-12-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB6976:EE_
x-ms-office365-filtering-correlation-id: 177b6e8c-0251-4e16-af44-08dde9019888
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|42112799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVN4RytGTVArMUlxN2hhbmtXd0xCRlhuSXFvTWh4NDlUT2t6L0RjaDRvSFBW?=
 =?utf-8?B?cU1QWlY1U0ZSMGFsNHcraXR4WjdweXgxSFluMVBEL1hjM21uRDBGY21HQ0JK?=
 =?utf-8?B?U1BTbldxek5ianRkaDUyWUJCRjJSZENnbDlsNWtCb2pOMHNzemhGNzFMRzcz?=
 =?utf-8?B?MUREN2RqeHk0VWM1Z3puSm1TbE1PVzFGNFVFalZJTEt2SHZkWDQrcGpJKzQr?=
 =?utf-8?B?K0JUNzZrbDZOcElTbkN2Z3NmcHBJT0lRc2M4UkRGU0VEY3ZlakhkWTVZT1JR?=
 =?utf-8?B?ckpBa0tLQXhCRnYrYzhRa2p4dU8rQmxydDRacXhKaDdTWktNS1pacFhRd1hB?=
 =?utf-8?B?RG0xWWlSVVBNWXE2VVQyQWFPNEhCcjB5TE1yK0FXYUt2U1VMTnlEZkZJc1JD?=
 =?utf-8?B?TmRYS3NKNE9ZRXU1SzJmYVdSR3kwaVBHMitqNEdKYWNaQ2U5aWZTd3d3aXIv?=
 =?utf-8?B?dFJmRGt5c0srOHJPS05mU0p4YTRzQlJiQi96WEM5WDBPR0MrVk52N3FMOFBB?=
 =?utf-8?B?YitockhWVWVFZFJSc2UzZGpwWUFOZ0VBZjVLaEpCcGg1NzJkcGlCdnQ2MFVJ?=
 =?utf-8?B?OGV1Y1MvZW1YTDNJRTFwUkFGUVdaRjNjSldrdkJKWGxONUpjM0F2Z3F1S250?=
 =?utf-8?B?WURQanUvQmd5TlBWSnQ5a0Q1TDg1VFR0TlpiVHhORkR3VjRyd2Z5cEJtOHZV?=
 =?utf-8?B?dk5XM3B3amhNRFNuTlQrSjU3cmxEQVpxZmlzekxSci9VTElJSDM5QVhvd3Yw?=
 =?utf-8?B?OGlVL3ZmajRPMFF0TWJrUUR2L01KQ3hBRVV1WVU2VCt5c0F0MXRLN2VtYnRn?=
 =?utf-8?B?NktjUGJXR1pBbU00VHViaHlsUDRkSk5tUkdzT1FkNkRmaThSMUY4QXdjS1Bl?=
 =?utf-8?B?UVBGNnRPU29JNUxWNHpLaW50MEpRTWtFbGdBbkZXR3BjWXZVNzNqM1JPSSt4?=
 =?utf-8?B?MmxTNWw4dklkdzJ2NS9zNjdDb3RlcVMxOUdNNlhJUlVLM2w1M2pQTkZqZzAv?=
 =?utf-8?B?SFBuS3pYVmtHdzlrSmxHUlE3S0puUkhuR2s3eGI2a2RGbFo4dm9udlpWZU4z?=
 =?utf-8?B?QWExOE5VL0g1NkJkL3VBUThHRmlkbklmaFVqVkszUG9ZRjdLckw2N0ptZ3Z1?=
 =?utf-8?B?K3lCcmlNeXZvdU1FZEtvTU5TRG9icmlseEpiOWx0VGczNVpIZldZVnlDZElu?=
 =?utf-8?B?M2hQb3FoM2RCTkdlNlJvL2oyWUhJa0ZRM2RGTFkwVHVXVHVyUTRub3VPa2NI?=
 =?utf-8?B?QzhsM3JwYmdmZlFrMW9hQ0l1bm83T1FURXFyQWNsNTQrZFpGZ3g2MzIrNmY4?=
 =?utf-8?B?Y2pGZEllSzVqQ1NYNjdpcFM4Wko5UXhkV1VJRG9uY3VQYW5XSWJSYUpaWW9Y?=
 =?utf-8?B?L0kwOEVLclNURVlLTlFzaFJqU3FJdUZEYTlYc28yb0wwSTc1UFQ2dFJYOEt2?=
 =?utf-8?B?WVpTZms1d0loOGJUeDNrdml5Mk9IcThFMjJhRHo2T1V1SDRzdkEyZ1dNTjJ0?=
 =?utf-8?B?WDVyaFFRbzU1NWd2TENpbmlyNzMrSGt3dnBsTEpSWWN5TTg2WGtORWpYc2c2?=
 =?utf-8?B?NFpBY1RSMlVOYVoyZ0x2TUx0dGJmNllsWE4xalRLK2RoajUyMncvSGZKSTZS?=
 =?utf-8?B?ZFJRSXlMREhGUk1NSTJrUHFLc3ZKV1g5OUFnbmdMNG9zV0YzK25GS0d4MTFt?=
 =?utf-8?B?WjBXTWJUbS9hWnVmQklRVTNkZEhsYk5id0JmRjRZeXJKc2wxVkJCRkVmdW53?=
 =?utf-8?B?R2NyanpPWUFlRjJFWldneVdQTFVIb3NzY0VPcXFBVG9CZ284a2pXTEpua1pR?=
 =?utf-8?B?bGlGcGMwbjFOVW5JdUZMOUhIZHkzT25Jems2WU1IY1dnTjB1YW53UWxEdUtL?=
 =?utf-8?B?SEhQdHg1cytCWXRHN0tZNVA3ekRVUGhHYUR6MXZOTnFLMjBjK0YrVDlaU0Yv?=
 =?utf-8?B?L0llUlhkRmJXQkxyKzRnSkp0R29OMGplbU1ZZXppZDZqZ25FaUVSWWNWM1Fw?=
 =?utf-8?B?Lzh3SktVMElRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(42112799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2ltMzVYTTJkbUh1ZWNMNGdUL3lDVlVkS0hYQnlBVmlsN1hWenZuQVQ1YW93?=
 =?utf-8?B?K0QvUWVzQ0VLMXVMcTh6WUU2V0ZMSzV2V2VhSFFab0lWeXRnczRBbW9ucEgx?=
 =?utf-8?B?WkFHY0x1QXlwa0hRREZZa2VTUW1XVTZ5d0xLM2h6MVljOHhVVjRQRC9kcVUy?=
 =?utf-8?B?QnVYVkNNdWxFTm83dmEvTGFRNkdFMDdXZUYvd0hxeUtXS0tGM0t6aHJDZDcz?=
 =?utf-8?B?S3VMNy9rRGxLWlVBZjd5Zi9uVWZpdUxNd3hQQUI3djY1bWFic21UKzJ2SDFv?=
 =?utf-8?B?bUlia0FiZzREemZBamUwT3hhY2ZSUSt0UFQxTHl3UlphWENHQjRYdzJSOGRT?=
 =?utf-8?B?Z2FHRVh4ZDFvNE1iQjdaUkl1OWs0NlpiNWxUcDRrNG1naVpmVHdtLzcyVC9r?=
 =?utf-8?B?K2pvaUhWWGFsa0FwNkk1ZDBNVWRUK29DR3BVTFRMeGYwMG5wWk5uYXRLZUo2?=
 =?utf-8?B?S1BXK3hudG1Ockxodkx5eDVRS2puQjNwUVJpNXptM3V1TEpwUm05UUUrbFJi?=
 =?utf-8?B?ZlF1ZW1Zbjl6ZDNxbmNtOUxtMGw1d0JGcG1kVUg5U1JMeVNvUmp2MTUrZ3RR?=
 =?utf-8?B?bS9VVHRlOTM0UTQ0ZDVJSDR4WnZwUHc3QkV0OXhjSmNrV1laRUNwRzZVN2kx?=
 =?utf-8?B?aHU0T3ZLYkhKZ3c3R2ZORDFxaU83NFJuVlh6ejc3eFFoejBlcVdCUEZMbzQw?=
 =?utf-8?B?dytPeVdiMkFoZXluL1BmMVZpLzlpazNQbUxad1M1azAxMVZsNk80ZU9BbUE3?=
 =?utf-8?B?RUh6OGxhN0taOUJ2T1JnVlZjN3JRemdYcURZaUpSdVNhNVp1STVJWTN0SEJk?=
 =?utf-8?B?K2N3bGdkWlJsU0xLa1VWRllSSTQzSXZReG5JNTBua2FoYnA5OW01dG9FaFR5?=
 =?utf-8?B?WERKb21MdDQzczlKT21XTHVEYmhhVy9CNWxROEtJMCtudE9xU2ZkbThRWEI1?=
 =?utf-8?B?S2Y3NlRtNEtLM3p6S0ZkUFpEdjhhRExNc1VXUDF1SzQwVGNvc3lCMFZVL3Zj?=
 =?utf-8?B?NEdSN0pvOU5NUnNkV3JRamIyejNrSW9YWGVBQ3llWFUwbUo3aHA2Wnp0T3JW?=
 =?utf-8?B?NElBTEVuazB5Yko5NzI1VXdaR0YwejdHZFczd1ZpQWptUG16T1ZXRFhSZHk1?=
 =?utf-8?B?Q0k3Wk9OSXUzOVB6QU5hTWVVcWI3aFB1UlVQaFdVWG4xUnZCRFdKelZxcERk?=
 =?utf-8?B?dG53a1N3MlpHZzk2QlM3ZGpOdWprVlFVRFZHNy8xY2Zzc09xVTZPejZjT0NN?=
 =?utf-8?B?V2syb0xvWHNzM3JoRDZzSlVDT3lpQVN1VWZxVFdyUVNweFhUMWxWR0t6dmJ3?=
 =?utf-8?B?MzlBR2k2eTZPWEQ3VWcwc0RjY0htOFl4K0hjM29COUYzRkIzNFRTMjREYlBr?=
 =?utf-8?B?OVNCUDE4d3lvMHZkM3NhQzhWREpMOUlVQVlLR29NeWZHZkprSmxWYzI3VGVH?=
 =?utf-8?B?MlRoa2dzZUFtZmxWMGdIUWxhVmFpRkJ6MUJ0NElvaWs3Z0NLVDNtTkYwcUp2?=
 =?utf-8?B?bnVJRTZnV0dtUE5xNm0xcmptU1F3bExjWmVGQnp5djBjMmdnSk92Q0NpSGwv?=
 =?utf-8?B?cWt5UnBDTWpONldTTWpwVzlocnliS2VTU2x4WmxmcmNhVEpwa2w3RFRtZkEy?=
 =?utf-8?B?UHNPYWxzZDVwNkNxSVhRZklsd1RPclpzS0tIUjZnVFZmL1NoSFl5blNFbHIx?=
 =?utf-8?B?eG1qaEVEU1czeWdKdE1xVDNidkhKTitCdjVJZ0dLWCsyQTFmU2lMNWtRMXA0?=
 =?utf-8?B?K0k2RGFRUGcyQ1NCczVHMEtiQWFSeVQrTWk3NlFNWjRDdjhKakpJa2llQ0pQ?=
 =?utf-8?B?U0FhWWRYWXB3Z1Z0MVlUclVXMFNmZDJ4YktDMHBzVkFzejV5NS8xT2Z0cHVh?=
 =?utf-8?B?Qnl0NE1rTy9sY0VKNndXRGtyK25NTk85Zko1eTdVY3MweGVSTWR1MTZhaG5R?=
 =?utf-8?B?UThGRHVreThraHVPTHBURGRSRzdJNTdmQ290dkc0bU9tcGo0SVErbzR0MlM1?=
 =?utf-8?B?SjJ5OEZtUGFmZHFOMi9WSU9obkYrOHRJSzgvRFZYbzUreHFiVCtUTnhqM0xN?=
 =?utf-8?B?c0pPeEE4UUQ2OUNjVXhFbmhTUUN3U3hwZmI3OEpWazVJSW13QUtvK1hWcmlW?=
 =?utf-8?Q?2CztrnBlIbzliq2+MVfIcmyyE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92233E788A929042BEDDCB3300E9F37A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 177b6e8c-0251-4e16-af44-08dde9019888
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:45:21.9209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1v2hmMzV5r0U5NfKLDTqTSlekQUQCuCHHrsT40A5nNTrdJkG2malDGG47opck2jhWJfCiL62T8qWEauwfjr6mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6976

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFJlbmFt
ZSB0aGUgT1ZMIGZvcm1hdCBuYW1pbmcNCg0KVGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLCBi
dXQgY29tbWl0IG1lc3NhZ2UgaXMgbm90IGdvb2QgdG8gbWUuDQpZb3Ugc2hvdWxkIGluY2x1ZGUg
dGhyZWUgaW1wb3J0YW50IHRoaW5ncyBpbiBvbmUgcGF0Y2guDQoNCldIQVQgZG9lcyB0aGlzIHBh
dGNoIGRvOiBkZXNjcmliZSB3aGF0IGRvZXMgdGhpcyBwYXRjaCBkbyBpbiB0aXRsZS4NCldIWSB0
aGlzIHBhdGNoOiBkZXNjcmliZSB3aHkgbmVlZCB0aGlzIHBhdGNoLiBJIG5lZWQgYSByZWFzb24g
dG8gYXBwbHkgdGhpcyBwYXRjaC4NCkhPVyB0byBkbzogY29tbWl0IGJvZHkgd291bGQgc2hvdyBo
b3cgdG8gZG8uIEhPVyBzaG91bGQgYmUgcmVsYXRlZCB0byBXSEFULg0KDQpZb3UgZG9lcyBub3Qg
c2hvdyBXSFkgbmVlZCB0aGlzIHBhdGNoLg0KRGVzY3JpYmUgdGhlIHJlYXNvbiB3aHkgSSBuZWVk
IHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVs
LXBsIENoZW4gPHBhdWwtcGwuY2hlbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgMzIgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBpbmRleCBl
MDIzNjM1M2Q0OTkuLmQ0ZjA5NmQzN2FiYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtMTAxLDcgKzEwMSw3IEBAIHN0YXRpYyBpbmxpbmUgYm9v
bCBpc18xMGJpdF9yZ2IodTMyIGZtdCkNCj4gIAlyZXR1cm4gZmFsc2U7DQo+ICB9DQo+ICANCj4g
LXN0YXRpYyBjb25zdCB1MzIgbXQ4MTczX2Zvcm1hdHNbXSA9IHsNCj4gK3N0YXRpYyBjb25zdCB1
MzIgbXQ4MTczX292bF9mb3JtYXRzW10gPSB7DQo+ICAJRFJNX0ZPUk1BVF9YUkdCODg4OCwNCj4g
IAlEUk1fRk9STUFUX0FSR0I4ODg4LA0KPiAgCURSTV9GT1JNQVRfQkdSWDg4ODgsDQo+IEBAIC0x
MTUsNyArMTE1LDcgQEAgc3RhdGljIGNvbnN0IHUzMiBtdDgxNzNfZm9ybWF0c1tdID0gew0KPiAg
CURSTV9GT1JNQVRfWVVZViwNCj4gIH07DQo+ICANCj4gLXN0YXRpYyBjb25zdCB1MzIgbXQ4MTk1
X2Zvcm1hdHNbXSA9IHsNCj4gK3N0YXRpYyBjb25zdCB1MzIgbXQ4MTk1X292bF9mb3JtYXRzW10g
PSB7DQo+ICAJRFJNX0ZPUk1BVF9YUkdCODg4OCwNCj4gIAlEUk1fRk9STUFUX0FSR0I4ODg4LA0K
PiAgCURSTV9GT1JNQVRfWFJHQjIxMDEwMTAsDQo+IEBAIC02NjcsOCArNjY3LDggQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDI3MDFfb3ZsX2RyaXZlcl9kYXRhID0g
ew0KPiAgCS5nbWNfYml0cyA9IDgsDQo+ICAJLmxheWVyX25yID0gNCwNCj4gIAkuZm10X3JnYjU2
NV9pc18wID0gZmFsc2UsDQo+IC0JLmZvcm1hdHMgPSBtdDgxNzNfZm9ybWF0cywNCj4gLQkubnVt
X2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3JtYXRzKSwNCj4gKwkuZm9ybWF0cyA9IG10
ODE3M19vdmxfZm9ybWF0cywNCj4gKwkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19v
dmxfZm9ybWF0cyksDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNw
X292bF9kYXRhIG10ODE3M19vdmxfZHJpdmVyX2RhdGEgPSB7DQo+IEBAIC02NzYsOCArNjc2LDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgxNzNfb3ZsX2RyaXZl
cl9kYXRhID0gew0KPiAgCS5nbWNfYml0cyA9IDgsDQo+ICAJLmxheWVyX25yID0gNCwNCj4gIAku
Zm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gLQkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0K
PiAtCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiArCS5mb3Jt
YXRzID0gbXQ4MTczX292bF9mb3JtYXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUo
bXQ4MTczX292bF9mb3JtYXRzKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTgzX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gQEAgLTY4NSw4
ICs2ODUsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE4M19v
dmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmdtY19iaXRzID0gMTAsDQo+ICAJLmxheWVyX25yID0g
NCwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gLQkuZm9ybWF0cyA9IG10ODE3M19m
b3JtYXRzLA0KPiAtCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0K
PiArCS5mb3JtYXRzID0gbXQ4MTczX292bF9mb3JtYXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFS
UkFZX1NJWkUobXQ4MTczX292bF9mb3JtYXRzKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTgzX292bF8ybF9kcml2ZXJfZGF0YSA9IHsN
Cj4gQEAgLTY5NCw4ICs2OTQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9k
YXRhIG10ODE4M19vdmxfMmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmdtY19iaXRzID0gMTAsDQo+
ICAJLmxheWVyX25yID0gMiwNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gLQkuZm9y
bWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAtCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4
MTczX2Zvcm1hdHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4MTczX292bF9mb3JtYXRzLA0KPiArCS5u
dW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX292bF9mb3JtYXRzKSwNCj4gIH07DQo+ICAN
Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTkyX292bF9kcml2
ZXJfZGF0YSA9IHsNCj4gQEAgLTcwNyw4ICs3MDcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kaXNwX292bF9kYXRhIG10ODE5Ml9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmJsZW5kX21v
ZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICAJCSAgICAgICBCSVQoRFJN
X01PREVfQkxFTkRfQ09WRVJBR0UpIHwNCj4gIAkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9Q
SVhFTF9OT05FKSwNCj4gLQkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAtCS5udW1fZm9y
bWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4MTcz
X292bF9mb3JtYXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX292bF9m
b3JtYXRzKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3Zs
X2RhdGEgbXQ4MTkyX292bF8ybF9kcml2ZXJfZGF0YSA9IHsNCj4gQEAgLTcyMCw4ICs3MjAsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE5Ml9vdmxfMmxfZHJp
dmVyX2RhdGEgPSB7DQo+ICAJLmJsZW5kX21vZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX1BSRU1V
TFRJKSB8DQo+ICAJCSAgICAgICBCSVQoRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpIHwNCj4gIAkJ
ICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FKSwNCj4gLQkuZm9ybWF0cyA9IG10
ODE3M19mb3JtYXRzLA0KPiAtCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1h
dHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4MTczX292bF9mb3JtYXRzLA0KPiArCS5udW1fZm9ybWF0
cyA9IEFSUkFZX1NJWkUobXQ4MTczX292bF9mb3JtYXRzKSwNCj4gIH07DQo+ICANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTk1X292bF9kcml2ZXJfZGF0YSA9
IHsNCj4gQEAgLTczNCw4ICs3MzQsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292
bF9kYXRhIG10ODE5NV9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmJsZW5kX21vZGVzID0gQklU
KERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICAJCSAgICAgICBCSVQoRFJNX01PREVfQkxF
TkRfQ09WRVJBR0UpIHwNCj4gIAkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05F
KSwNCj4gLQkuZm9ybWF0cyA9IG10ODE5NV9mb3JtYXRzLA0KPiAtCS5udW1fZm9ybWF0cyA9IEFS
UkFZX1NJWkUobXQ4MTk1X2Zvcm1hdHMpLA0KPiArCS5mb3JtYXRzID0gbXQ4MTk1X292bF9mb3Jt
YXRzLA0KPiArCS5udW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTk1X292bF9mb3JtYXRzKSwN
Cj4gIAkuc3VwcG9ydHNfY2xyZm10X2V4dCA9IHRydWUsDQo+ICB9Ow0KPiAgDQoNCg==

