Return-Path: <linux-kernel+bounces-786136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5695BB35589
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1786417D24C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D7026FD9B;
	Tue, 26 Aug 2025 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oWK0eqsU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="avBII7An"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADF28725F;
	Tue, 26 Aug 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192924; cv=fail; b=NgGfkzaBFJyK2pn/uyJ4DMBNAPjUpltHAh6/oQCDY1lxmpqYIHyc+sqRY8NfoWspl7lNCU/feo9KI2RxxGsdGdYj1vnvzwH3pF6oE4sHYeB8bPGN1eFh0lUVZy9ykCwt6zZxWfjriAqIGYl80STgpaV8I+Knedr9bHD2yn3NeIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192924; c=relaxed/simple;
	bh=JXI/rBI1Ay99VRM9+qMXtMIcfjG9EgvuuLOObhAImdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PsZOT/F3swtO8N1Ku25m7iAsjDTtKEuEqdH5Q41P6AKLNr8LFjoqFxxYurIUWectxGmS3ejaAbg4X/ESwhMYmxdxr5KKf4dh4hX7DStZjBabnRPZBIeWlJEnrwlH/SERBxGbfYQIolo8+f9l9DBp4s2ON979cnircaR157PpWuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=oWK0eqsU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=avBII7An; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 58ea9222824d11f0b33aeb1e7f16c2b6-20250826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JXI/rBI1Ay99VRM9+qMXtMIcfjG9EgvuuLOObhAImdY=;
	b=oWK0eqsU2v71mhqiXX92PEIYOzYFOWEAu2oIxSzEru5ufwkLivLPoHLO1NTNpPt0j6QvTdFJX5N/RNXkZboEawIvHO8hemIPVMFT753+HvquMwslQK4AOsJs/P9OYhV+zttoCikTshAluxGf5ZUeBEw30LEod73dt9jt1rVhpJI=;
X-CID-CACHE: Type:Local,Time:202508261516+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:f5697317-d8e6-4e90-87a0-47dc1d9afa88,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b962887a-966c-41bd-96b5-7d0b3c22e782,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 58ea9222824d11f0b33aeb1e7f16c2b6-20250826
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 357817204; Tue, 26 Aug 2025 15:21:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 26 Aug 2025 15:21:55 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 26 Aug 2025 15:21:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQNCaM6n2gzxJ5/YLvpLqqW855Tgz7E0xSuBbHLF5zee0y2DZKfiNk58z7/fZkyc0+ec+tsb3GE8jo7rB6Tv6bc4oRHjK3o3cPlg/CvUCzBkwMaNsXjL3YYeqMT4COP1ufblJZGyFpN0AklOil9GgxAv9/8oodnwwFj7gftjMJUSd2VUCAMjfR+tSqyAUc7h14gkLU74dKul2Cf2ky7ZAD+VR3qbKjsBO1dpqc5DVmhYGTzOKkrGFtqbsHTUxOJtHojKw3VduV3CeP9lz5zQQpnn17FXOiNIDt1CWd5tnNs3EDTE/DqwCSK7a6SAVhFPqMx86B/+8I0XLqRF5Vu4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXI/rBI1Ay99VRM9+qMXtMIcfjG9EgvuuLOObhAImdY=;
 b=njXqkbXdB33usDh4C1K+DwEjOJgKLkCTAO8Dcmf5KQUnaXCGBooRBpZyIZUFBBeKvBx/5bWwoiIHqwEq0wuyeAqFrnhUgBQNYrc7P3PJj2ZFrJMR1LR+aKUk2xcH75TEfVQn88I81EbA4VUZEFGPcIbxRPKZ2F8C7uYkoiQG3Pg7OkG+RbZVufixyTvtua6f4Pb8wp+REjrfRhXHamUmgJf0Iv6xLzu2qsIPTm9XQVxszIuENrEqux52u27rzxVJLBQfx5uCatsaTq0wCZmHpE41vVtH61utGA5J1OKPZ9gqf+8cyhIFxmy2y2GkTU6KFCj+QLESoSGt0yFPZ2zUiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXI/rBI1Ay99VRM9+qMXtMIcfjG9EgvuuLOObhAImdY=;
 b=avBII7AnevppQpCNHwCU62npzaONT8HSw05JPxcK+Q4ygtQ8E8Fb2oXSW52exJ3FXlYNBMBHPPEk+4cGBewc9v4Yp71WhpwDxPkbLwooFfm6bNyvTng45nTxNNziRrbsUS1VLpxC4jEfx3on0rVPs/IiHFRIq5hoy86c7UKEm7g=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by KL1PR03MB7128.apcprd03.prod.outlook.com (2603:1096:820:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 07:21:51 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 07:21:51 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "perex@perex.cz" <perex@perex.cz>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>
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
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAAP9QCACUO9gIAABvQAgEt2IwA=
Date: Tue, 26 Aug 2025 07:21:51 +0000
Message-ID: <80ca29ecb1f791e608ace33776e1e24adce6b8bf.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
	 <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
	 <85ca4ceb29caec9acbe77a3d67e3bc57b0b0aeb5.camel@mediatek.com>
	 <fa1b8e02-deee-44e5-a6c6-52394fc071a4@kernel.org>
In-Reply-To: <fa1b8e02-deee-44e5-a6c6-52394fc071a4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|KL1PR03MB7128:EE_
x-ms-office365-filtering-correlation-id: a3bce95a-4d37-42a8-3ddb-08dde4713a1f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?dWhDaitITEtZd29HbVhGYWp0RmwrdkZQTjcrZVZlMEQxcGZZd2MwNDM2eDNo?=
 =?utf-8?B?MWUzUDRYR3JnYlljcy8wempCWkJlMXIxV3V2MWRNajFGVGY0OGtCUStzekV6?=
 =?utf-8?B?VUVFdUNVSXJKeXB4S0pCZ0hiZkxFaVJ1bStyRzRtMGJoVVVRZWxMU3BaMnZ6?=
 =?utf-8?B?aWtXbEJqNUwwb0ZkTmp3bmM3enZpNGQ1bXZMN1hZYUw1NlN6MWZNS1FyaTFF?=
 =?utf-8?B?ZGF0bDlKdGZtTEJEVkhpV2JRRVF4SnBTRHVrYTlGKzFiZ3p5cFdsa0JnRHpN?=
 =?utf-8?B?VXpKdUlYMS8zaUlWNVVnUS8xQ3ZqRGkyTzBuaTdzREhUZ0QwT2FaNEpCcUcx?=
 =?utf-8?B?bEJ2WkpWV2h2aFdBOGFTT0ViOEluc3FkM2sxSS9PRVpUSUdoeTRRSE5aQit5?=
 =?utf-8?B?R21FbXNpc1FYeWUwV1psMVRqOTFjY3Nyclp6eTRySU1tc1BxVXhvVUI2T1ZU?=
 =?utf-8?B?amxCdnJKQ3lZUGs2NjZ4bEFCRVAxVHBHRi8wRzZTbnlJNlUrN2k3V1FPRnpX?=
 =?utf-8?B?cG5KT0lYMm1XRTJ6NGs0L2FrU0xrak5rbFU2b3BoVmlyVHRjNmVtbVlxNVFP?=
 =?utf-8?B?VjF5UytXa2VkaWpJYTlXcEc4M09hQmdXRFd6V2lwNWIrSHBERW42VWhJTU5a?=
 =?utf-8?B?TmloSm11V0FiT2pIelFpeS9wcUUzZUV5TXRSVlVOWDcxQjVic1NkRU11eTZD?=
 =?utf-8?B?bzJqc2VTNkVtZEpwVHlFc1pDdlQvWjk3U1hIVlJPZGlRVnNqTzlIeUMwQXE0?=
 =?utf-8?B?a1JWek5xMnBpelFVeXF5dTFEcFdFM3RNdjFlV2h6VVhCcDdUQlFkRlNSeFdB?=
 =?utf-8?B?WUR3cjRmUFc0dTVNbmlSdHYzaTIxd3NXM0E2TTVrWks1NmIrV0d6Y0hPZXVq?=
 =?utf-8?B?SGNNUmdnQ0phdThKalkyZTFONVgwN05kRFlJY0YxT1l0dWxGZ2laYUpBa1JO?=
 =?utf-8?B?VG9mU2RnSFl5QnRaVnJKclhUU05Ta0hGZGl2a0ZQNWVwRDJNbnJCRXdDdTZJ?=
 =?utf-8?B?KzJYdGFTQTNybHlGVDhxM3RZbmZaRFhMRTMxb0ZqeGlWRGZLbDU1UTF4N0tD?=
 =?utf-8?B?YUZQMElla0d3WDhlTHJLUkR1bmtyVlV2Q0gxYndjb1BSTGtCNTdIWlR2V2tI?=
 =?utf-8?B?REZZSzVVdnAzb3lYV0ozbG96SWNpdGNmVkc1ZFd3TlFGUklBbFRMZ0RnZzFl?=
 =?utf-8?B?bUU2b3F0RkZPVmo4QkhoTHRlcW51TEFUN1huNXZVZnFRbGZNQnFacVRVd2Fo?=
 =?utf-8?B?YmZuaUZ0eFRKOUYwL1ArRTJIdWRWV0x6VS95eWs1NndQTHZtMW5ZcFhKV1Bp?=
 =?utf-8?B?b2ZsUWRMbml1RVhRS1dvZTQ2SmhtU0l5T2t2QkJzdDNnRlhhMERLRE1WMXZk?=
 =?utf-8?B?TGF6a2FzZlA3cHZ2ZEdsVVNPV0s4cThNSTc1aWl4aHVaeXk5Z20rY1JBZzdM?=
 =?utf-8?B?VHdYV3M1Qk5DVWxJQjBTUmRKdzVhVDh5NzFGeFFmbC9VTStkWE1rVnZjcmk2?=
 =?utf-8?B?Nm1acGN4Nm11OVl1MzVyWUQvUVR4NlBpY3BHazcyaFdTdVRpTVR4VVR1N3dp?=
 =?utf-8?B?UFJHUVRTNCtseTNNZkI3K09FWmJqalRYbWExeU9EREhaTU9xNVNYRllGM1hB?=
 =?utf-8?B?WmtPQnZhMjRtcVdzcmQ3QURQd3h6UTV1VC8zTTd2Sjd4S0YxdDN0RWEzcm1t?=
 =?utf-8?B?ZVlZNU5Kb0RScldsNkZ2TU52KzlkZWtadzRvQWFjOHdzY0lsZUlTQStMZFNG?=
 =?utf-8?B?Qkdsb0tMTUxwQUxIeE94VWhOZnNETDFMa0czSmdhTHZmblVlY1lGa1JlTitl?=
 =?utf-8?B?S2lPUTJVb2JLeGhoMHZIOGI1NWVxNlUxaU1CZjZPeWpQNlZJNitxSWdCaCtW?=
 =?utf-8?B?UmJSUVlHY05sNy9LOWRpVWtOd0Q5bUxlSWJQYzZyWXZjK0VCc20zOHNQczdS?=
 =?utf-8?B?OUNUZEo3b3RpMFowYUFYbEpSd1J4aVBrZUdLcm0wcVBjY2w2WE1Vd2RIME84?=
 =?utf-8?B?eWpXdndqNjFBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU5aMGVRZXJxZTRQTGpjTWZDWlhHY3RtSFpXaTczU1F4ZlFhR3VmcGY4OUZ1?=
 =?utf-8?B?RDlQMlJ2eXBHdE9YOTZpbFNnZEZBNHROOTh3QzVwVVBVNEFSSGVsSU8rQ3Rw?=
 =?utf-8?B?aDJKZG1jYVZNV3VVaUp5RmRrSVZRTkVMc3Z4UTRVRi9OVzlEVGpCdEE1anN4?=
 =?utf-8?B?SXgxSzAvUnE0c0EraC9yN1FBUkFyMDZhM0l3clFVNURBWXlCQk9aamVXaTcz?=
 =?utf-8?B?ZlRpN3k0UmdlNmJCcUh2aURIbEcySWt2MGU2QlE3TUlhNUs1eWNRQ0VWbWxz?=
 =?utf-8?B?S0ZyMVR6M0MwWUwrNXplSmF1WkJuRFVzYzBLd2Fka0cxbVNMVU1mWUc0OE9N?=
 =?utf-8?B?YkpNWHBpYSs4VSthTFhxeXY1RElzcmhsVmtJME4zWkxIT3VlK1VFTFczendT?=
 =?utf-8?B?WG9JS0gxNzBEc2c0cU5rMVprbU9EM2JTWlRGNFJpTUFKVmtCRFdpd01EOTBH?=
 =?utf-8?B?N215VnFzaEJDL2FMWmEydmpodjUyRjhTT3RDVWpTS2dIeFBxRmUxREcrVTJB?=
 =?utf-8?B?UTU4UmlickU0THBSTVZFV3l6bWJhZCt3U21Da1NpUUpRUGpIeFhJeTVpRld4?=
 =?utf-8?B?L1BnOTZyM3RSZEJ6VDVKU0w1T2hxeW1OSHdON055QUtrSkFNb0JKYTgyVjZi?=
 =?utf-8?B?b211K2M4L0JEbEhiZVo5YzBJZTBOSGVrNzFYRDRCV3dCYThFMVc0eUtlMkFp?=
 =?utf-8?B?NUsrYUJyM0RQc05DSFhYKzU3RHJaYVloMHhYa0JaS3VZc003SVc3dERES0Zl?=
 =?utf-8?B?ZzdnOXFrdFI4RkZDYWtrYTlXUGFLN2NoWXFTMEJFbzltWWN4MFZjck51UGV6?=
 =?utf-8?B?ZDlYQUljaUp6Z1dhN3cxWHRiZjN3WGJ0eUl4UUlPdXZ0SUM3bWc4cjVMUTVq?=
 =?utf-8?B?WkZ3VDhFUlZ5YmdnTzFxRElSWDFIb2Z4dTZ1YVdBZ0lEbDlHeUwwMWFPbUNn?=
 =?utf-8?B?YWFJbXhwUG9HVlV5KzduSXhrWlVRNDF1NXZBRWdxaWdLN3gxZ1V0VkdvYlBx?=
 =?utf-8?B?SC8vTGxZZVl2Q1ZNYjNSMkQranVSTnBORWxxTzZoRVlsZ2VkTmlINUNpZUR2?=
 =?utf-8?B?Ri9zTmFpbVg4RkxIL083TmZyQUMweHNSNUFmYWtFNlNFWW5lZm1Ec1JVa1Fw?=
 =?utf-8?B?Rzc3N080bkZoY25DdllOSU81bGlUa01ueHMyMUIrdklCWGJCUVUxZ1ZRT3FV?=
 =?utf-8?B?TndkWDloai9raWFGWkdYdEFuaDdHRlhyWGtxN2JGZjUvNHFaT3ZtN0VreWNk?=
 =?utf-8?B?Y0N4ZEhYMFN6RTA2ODhpNDdzM01mb0oxeCt0Mm41WUp2ajEzRjVQdjBVbUoz?=
 =?utf-8?B?dGxxYlJhYjVaM2s0Q3ZGOEYxdDNZWWdsZzdHUUsyQ0FmUnZ5WFczcHRxQm1j?=
 =?utf-8?B?NndJQ1lzc2RUOHUxeG5RMS95SVJ6K3A3V1hUc09GYTZzb3hGZFUxVUtmOUJk?=
 =?utf-8?B?MjRvUTVzcHUrNHNEWWNLQjRpVXRmeVc3S2JvbnZLRU1MQVNqUXU5dVpXZ2d0?=
 =?utf-8?B?dWRPWklBS2YvcmZjb3NmZ0N4VDlYUFpzM1VBTkVHeEFXeEVHMk1xZitKMEFp?=
 =?utf-8?B?dVAvUGhPODFiUHN5cmNOL2d3Rk1LQTRZeWlBUGZvNXV1VExsZUp2bEJLMkJv?=
 =?utf-8?B?VERGSDIrQVpxS1RmUVJuWk5tTGdkTUM5ako0dEtzOGlZa0pzRk56QnE1MFVF?=
 =?utf-8?B?M0wySXpLR0dITTJVMmc1T3RUZjhXcllaZ21iWHZyTVNZV1RyMFd1dVVueEFy?=
 =?utf-8?B?eHo5bjl5VGovSUF6Qi96Q0xRZzJhU2dKNHoyekl2cUE3Q051OFNTUlFRY1Ax?=
 =?utf-8?B?dXNNTklrUXRRT01INk0xbGRLQk1uYktKR3dRS3ZWb3J5emhJb1RxUEtaZXY3?=
 =?utf-8?B?WXBZZjM2Kzg5RTVRSjVucHRGRkwyY1ZEOUdiTitLRHI4QkdINE9FK1hic25P?=
 =?utf-8?B?azB2UjNiaFJpOTR6dXRBZDlNMnBIODVxclhEMnNud0hueUoyYnRuait2SjF1?=
 =?utf-8?B?TUd1Z1RnajRVQ2NyUzhQczZudjFVcUUwa1RGVi9IYVRTRkIwdzBBUURTbEF6?=
 =?utf-8?B?RE53M2hMODVUbzJyeXRxTXZPM1ZDd1lUd1M5Nk5xMXZiMWV5OUQ3dnE3b2Yw?=
 =?utf-8?B?YVl0ckwxUG1FMllWbjNXT3l1aEtjT215endtL0hBZStNSW91dEpyRE5hbE5N?=
 =?utf-8?B?amc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACB610C134F6E04CA4F905EB3D4E6AC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bce95a-4d37-42a8-3ddb-08dde4713a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:21:51.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KDOMna9f0qL36/VAnd4qmTCA7H4lHX7g48id2myRSdOlMbX7uGnndL0JNj4uo7GWq1RQj73wQ+2VMIpn1Ownk4vWbl4H4JwrMTZ9SktsVC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7128

T24gV2VkLCAyMDI1LTA3LTA5IGF0IDA4OjU5ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA5LzA3LzIwMjUgMDg6MzQsIEhhaWxvbmcgRmFuICjo
jIPmtbfpvpkpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wNy0wMyBhdCAxMTowNSArMDIwMCwg
QW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVt
YWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4g
PiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJbCAwMy8wNy8yNSAxMDowOCwgS3J6eXN6dG9mIEtv
emxvd3NraSBoYSBzY3JpdHRvOg0KPiA+ID4gPiBPbiAwMy8wNy8yMDI1IDA5OjU2LCBoYWlsb25n
LmZhbiB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBIYWlsb25nIEZhbiA8aGFpbG9uZy5mYW5AbWVk
aWF0ZWsuY29tPg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBtdDgxOTYg
ZHNwIGRvY3VtZW50LiBUaGUgZHNwIGlzIHVzZWQgZm9yDQo+ID4gPiA+ID4gU291bmQNCj4gPiA+
ID4gPiBPcGVuDQo+ID4gPiA+IA0KPiA+ID4gPiBQbGVhc2UgZG8gbm90IHVzZSAiVGhpcyBjb21t
aXQvcGF0Y2gvY2hhbmdlIiwgYnV0IGltcGVyYXRpdmUNCj4gPiA+ID4gbW9vZC4NCj4gPiA+ID4g
U2VlDQo+ID4gPiA+IGxvbmdlciBleHBsYW5hdGlvbiBoZXJlOg0KPiA+ID4gPiANCj4gPiANCj4g
PiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS4xNy4xL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1w
YXRjaGVzLnJzdCpMOTVfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWczOXE0OGZVQ3NESjVQRVRVdFEw
UEswQmt3ZjBDZTFGX1p6SmlFaVdNenV5YldRMGRTUHpibHZMbEotNHNhV1RTb0pXdVM1aW1zWGJw
ZGdMQnZVeTR3eHc5QzV3N0I0bSQNCj4gPiA+ID4gDQo+IA0KPiBGaXggeW91ciBlbWFpbCBjbGll
bnQgbm90IHRvIHByb2R1Y2Ugc3VjaCBqdW5rIGxpa2UgYWJvdmUgXi4NCk9LLHRoeC4NCj4gDQo+
ID4gPiA+ID4gRmlybXdhcmUgZHJpdmVyIG5vZGUuIEl0IGluY2x1ZGVzIHJlZ2lzdGVycywgIGNs
b2NrcywgbWVtb3J5DQo+ID4gPiA+ID4gcmVnaW9ucywNCj4gPiA+ID4gPiBhbmQgbWFpbGJveCBm
b3IgZHNwLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWxvbmcgRmFu
IDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gICAu
Li4vYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTk2LWRzcC55YW1sICAgfCA5NQ0KPiA+ID4g
PiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5NSBp
bnNlcnRpb25zKCspDQo+ID4gPiA+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbWVkaWF0ZWssbXQ4MTk2LQ0K
PiA+ID4gPiA+IGRzcC55YW1sDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+
ID4gPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVr
LG10ODE5Ni0NCj4gPiA+ID4gPiBkc3AueWFtbA0KPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL21lZGlhdGVrLG10ODE5Ni0NCj4gPiA+ID4gPiBkc3Au
eWFtbA0KPiA+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gaW5kZXggMDAw
MDAwMDAwMDAwLi42OGY1OTRmNDc2ZTgNCj4gPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+
ID4gKysrDQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291
bmQvbWVkaWF0ZWssbXQ4MTk2LQ0KPiA+ID4gPiA+IGRzcC55YW1sDQo+ID4gPiANCj4gPiA+IFdy
b25nIGZvbGRlcjsgdGhpcyBzaG91bGQgZ28gdG8gZHNwL21lZGlhdGVrLG10ODE5Ni1kc3AueWFt
bCAuLi4uDQo+ID4gPiANCj4gPiA+IC4uLmJ1dCB0aGVuIEkgZG9uJ3QgZ2V0IHdoeSBNVDgxOTYg
d2Fzbid0IHNpbXBseSBhZGRlZCB0bw0KPiA+ID4gbWVkaWF0ZWssbXQ4MTg2LWRzcC55YW1sLg0K
PiA+ID4gDQo+ID4gDQo+ID4gWWVzLCB0aGUgZmlyc3QgdmVyc2lvbiB3YXMgd3JpdHRlbiB0aGlz
IHdheSwgYnV0IHRoZSBtYWludGFpbmVyDQo+ID4gc3VnZ2VzdGVkIHRoZSBmb2xsb3dpbmcsIHNv
IEknbSBub3Qgc3VyZSB3aGljaCBhcHByb2FjaCBpcyBtb3JlDQo+ID4gYXBwcm9wcmlhdGUuIENv
dWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBhIGZpbmFsIHJlY29tbWVuZGF0aW9uPw0KPiA+IA0KPiA+
IHYxIGxpbms6DQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYTcyOTg4MjEyZDBk
OTViZmU3NmViOWM1M2JiZGI4YzU3Yzk4OTM3Ny5jYW1lbEBtZWRpYXRlay5jb20vDQo+IA0KPiBZ
b3UgbGlua2VkIHRvIHlvdXIgcmVwbHkuIFdoYXQgZG9lcyBpdCBwcm92ZT8gWW91IGFyZSB0aGUg
bWFpbnRhaW5lcg0KPiBhbmQNCj4geW91IGdhdmUgdGhpcyByZWNvbW1lbmRhdGlvbiBmb3IgeW91
ciBvd24gcGF0Y2g/DQo+IA0KPiA+IA0KPiA+IGNvbW1lbnQ6DQo+ID4gPiANCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICAuLi4vYmluZGluZ3MvZHNwL21lZGlhdGVrLG10ODE5Ni1kc3AueWFtbCAgICAg
fCA5Ng0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gPiANCj4gPiA+IERvbid0IGdy
b3cgZHNwIGRpcmVjdG9yeS4gRWl0aGVyIHRoaXMgaXMgcmVtb3RlcHJvYyBvciBzb21lIHNvdW5k
DQo+ID4gPiBjb21wb25lbnQsIHNvIHBsYWNlIGl0IGFjY29yZGluZ2x5Lg0KPiA+IA0KPiA+IFRo
aXMgaXMgYSByZWZlcmVuY2UgdG8gdGhlIGFwcHJvYWNoIHVzZWQgaW4gYSBwcmV2aW91cyBNZWRp
YVRlaw0KPiA+IHByb2plY3Q6DQo+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cHM6Ly93ZWIuZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZHNwX187ISFDVFJOS0E5d01nMEFSYnchbllJU21SMENSbHdDa3ZDc1hfX0trcktQRkNp
R3kxamp3cV9yWmpNTVhtUTZSaHpsVWVMZ0JtVXB4dkFzbHFKWlR2TTdKLVFEdnFfaHBENCQNCj4g
PiBEbyB3ZSBuZWVkIHRvIG1vdmUgYWxsIHRoZSBmaWxlcyB1bmRlciB0aGUgRFNQIGRpcmVjdG9y
eSB0byB0aGUNCj4gPiBzb3VuZA0KPiA+IGRpcmVjdG9yeT8NCj4gDQo+IE5vLg0KR290IGl0LCB3
ZSB3aWxsIHBsYWNlIG1lZGlhdGVrLG10ODE5Ni1kc3AueWFtbCBpbiB0aGUNCkRvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kc3AgZGlyZWN0b3J5LiBUaHguDQo+IA0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

