Return-Path: <linux-kernel+bounces-722852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F6DAFDFCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181207B143B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1AC26B2DB;
	Wed,  9 Jul 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uM2cg3hy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uCcJoX8Y"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908C156678;
	Wed,  9 Jul 2025 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041167; cv=fail; b=Uce7dExa0F40Pq5Hj4JQ5GgZPST6BqLFheMWzIfkWnU9ZJgDKxdoetC5yH8xug0MdJn0q+oHkJtRnrRRT+qdK1tiiJtluzuR4/fHiD7ovPPULwyRTYH2m9gz+5fgc/c3AzM8tLTVYRRUec3dEW150JJ9BmWLt3DvHMW6nwbdu80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041167; c=relaxed/simple;
	bh=C6bW8Nwe4s4WPlCrM2YKiAppMadHDBOJZfa8oOWAv0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyWGsU0KzGWK3EvL+5pxNw1lVKpqY9/0vSD+C0As4sqiCNqjhSknmMbC0L8lYjZ2tyZGESLnQs/RLVcD/Bbgpi7VnsXFy990ndsUNVIprIhGm/dKRNO30FZlUf4rDrz9FQIm/pWPeCA3SAz4UweTLUDmBQVBWAf3WPJlV3PvtoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uM2cg3hy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uCcJoX8Y; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c7a87b225c8a11f0b33aeb1e7f16c2b6-20250709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C6bW8Nwe4s4WPlCrM2YKiAppMadHDBOJZfa8oOWAv0M=;
	b=uM2cg3hyirvBfoDebnzHxnjbVroOCImoV/VwtAM3PXZ8sxkSggz95lMzSt6LjS5qhy5JvjVdxfhJwRAbqLsStLn+LKfUBHozSypJIiDo55DgxwAUIBXNsA8K/6V4EnBIuY92j06L21akEhObTo9t59sngt6/F8mYv2hKzBSggs0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:9b582c5a-fae9-4acb-80ad-e8aa0a4a2740,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:827cbbbc-a91d-4696-b3f4-d8815e4c200b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c7a87b225c8a11f0b33aeb1e7f16c2b6-20250709
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 383330657; Wed, 09 Jul 2025 14:05:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 9 Jul 2025 14:05:47 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 9 Jul 2025 14:05:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arJMgr9T5mXZdD/pnFgLkFbhNrIAFn/UOn8V6340kJTu4Gut1tW/MOyHqtCQM8Wok+MksrjMprswEfvWUIxSR1vlpRHslEjeVPY+TKHDkz0h5WP1ANFqAKTsebne+W1+T1fnCgCDxXfus7WYgTMXIrex3mpdovK53rC02Of2xn9Fs7low05sPGo1Puln7cC7ggrkdjtVLn090m+/nC8DHLJ5UXocr6rTaMlMocsc9gefPCHp1X0ep0ZbY+APzgARGgU19ZwbH2FIYCpV3mxirJ3xgH9lIBH0W82gWC8MbM8IGlIyo6SSbQba0uGKapN+KNHjaO6rrn8ToZBQuO/icg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6bW8Nwe4s4WPlCrM2YKiAppMadHDBOJZfa8oOWAv0M=;
 b=qAGLLjCLx1tel41TEzSflFdgIDGkTGUTBg2bXIVCrHJP7qektlLx+MGCc37uJFpc1KNRjmJUzOLgDR5lHTiC8Wc6HkWdvB+rCuVBpbEx4brBhBl1DTfpEEsPHxb5FLzVaTd/+8Zfx1KG9NP++nSAWwan5Jvm3V9Y+3AYIyIra7Kj+1hBYEdxL31ujZIpFZZBsbJxBlT6ayXck+khvHvjB4Q4+Al+9u2UKGrP32Ow323HU19Kmmres/t9YeW6Dl3iXhtwFTV5jfDQJ+usB5IYZci3Butj9CBdYXKho5x5l8msO50XRae9JIqTtMzALMu7Uj0ILOvC7VI45pi1YenLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6bW8Nwe4s4WPlCrM2YKiAppMadHDBOJZfa8oOWAv0M=;
 b=uCcJoX8YZ+JUAGHRSdrt5K5kjZeibbSkxuuoTYplcsJEcJLUkgSruC7m05D6SbfM3tja6PfeGrh24SGBZqlIYzzoHXTSLDaa63gVylIDPgS4aXNZGpo4PxVCPKHSphf/Dl4PmQ7ApCF69U9O3tjeoWIE+gNH29vPvWOphLUqjuE=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by SEZPR03MB8181.apcprd03.prod.outlook.com (2603:1096:101:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:05:52 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 06:05:50 +0000
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
Thread-Index: AQHb6/AjDLqCeVaT/UOLwUvdRPs5orQgC4SAgAAP9QCAABYCAIAJJawA
Date: Wed, 9 Jul 2025 06:05:50 +0000
Message-ID: <dff1a4d6d97d7d3d55c4bd409780d2857ae070ca.camel@mediatek.com>
References: <20250703075632.20758-1-hailong.fan@mediatek.com>
	 <20250703075632.20758-2-hailong.fan@mediatek.com>
	 <defd70cb-4351-4b0b-b4d0-dd1ff831615c@kernel.org>
	 <61784658-c71d-458b-8934-5f5db2330bc0@collabora.com>
	 <8b8a58f0-9e18-47d6-8382-1d16d630ea15@kernel.org>
In-Reply-To: <8b8a58f0-9e18-47d6-8382-1d16d630ea15@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|SEZPR03MB8181:EE_
x-ms-office365-filtering-correlation-id: 70c93676-9956-40fe-ff9d-08ddbeaea809
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?OFJBaDkwbURKR3p5N0wxWndtZXJXSG9MakU5ZXhzSG9CNWRBYmRXN3dLYjcz?=
 =?utf-8?B?YzQ0bzMvZW5yTlNock1LZW1vLzM2R3Jaa3lqUUNEdkd1c1UvMU1tM1lLeGxw?=
 =?utf-8?B?a2VPaFRRZHpBNUtKRnNUNFdFb2ozcjJHZXVHVmtOdWlFcXl0em93aEwxNVcz?=
 =?utf-8?B?anhZdGFVdnFPVDJrQXpZSW1nMGpZQjE0S2JmT1dVVUxKckI3TXlhSkhVbmJ5?=
 =?utf-8?B?MmZ0YjZyak52cUVkckNBd0lCT2VkWnRoMm55TGN0Zy93azhiNmdpZmVKRlpZ?=
 =?utf-8?B?K3MrVGo1ZnB6cEpaNmxDOSt2eU9QRU5yWmFBOEw0c0N1U2htWU8vNnI1ekZw?=
 =?utf-8?B?MmZJOWZQb1lHa3Mwd3VoS2dqcGZJWG9KMWFYRW9jd0R2bUFOVnVTaUJWYXIr?=
 =?utf-8?B?Q3loRURpbzZUQlRvbXZJeUhFWWFRb1JBWEd2MnJWdEhYL0UvWHZTNS9jOVIr?=
 =?utf-8?B?R3FOaXB4ak9taW1zdytPbk9Rc3I3SzBoQmkwbURnY05TclA2Qlo2dUVCWDdR?=
 =?utf-8?B?Z2EyYmJ1ZkM4TmVnMjhlVlBIT3dNakNkY1JqRUdZb1M4VjJmZ1Bkczc0OUZU?=
 =?utf-8?B?ZlJUdjl6bFMzUDdlMTBWcE1sNGZzVkR2bURPeHRpKzJKQnY4cnhrOXBBL05n?=
 =?utf-8?B?Q1JaQUhnUXFvUlVuaFUwN1pJYVR1S1hwRU9QZUdNQnd4WktrdDNFcjlOeHhG?=
 =?utf-8?B?WWJkbHNyZ3NMODNVeFhqUzB0d2xybGxDQTA3VFFYbGNUWWV4MVhSMTZJamlG?=
 =?utf-8?B?ZTBLSEZHQjZYVHVuRlRsRTlJTkEzRkY0TVN2VXZGNTUwdmw2Y0hYSFNUQnk4?=
 =?utf-8?B?WWo4VTVLWFd3VUk1anZrNVhxcTlrV3dCM3Nqdi91L1lrYVgyTVNURVBoNW9j?=
 =?utf-8?B?VXQwT2tXZER3V2FuNExEYlBWK2tzRDVoL3duTTlkT1UybllqcWpuSEE5cmVX?=
 =?utf-8?B?Yll2RWl1SEY4bUdMUDFFT2xrUzZLeW42aW9JSUJSd0gvN2VvUHIwRys3SDVi?=
 =?utf-8?B?NisySm5vQVFvNGgxTi9qVUFnU0d4Vk5IaTN4Qkw5TVBGT1Q0eXBiNDl6b1h2?=
 =?utf-8?B?Z3V4Vzlxa2d3djhTMXUvbGlrd2VqYjZMSVQxc2dnMmNnNm9yZEsvRUxLNm96?=
 =?utf-8?B?eS83eUZDck1TbW9kVml1K1hwZzNQS0ZYejNOQmVvZUtNOW0rY29qdm1Rb0Jt?=
 =?utf-8?B?cFpZYkF6MHd3T1M1NGdoK3R6T25XZlBady9ZTEhLS0lrc0RvZEdsVjhmY2hI?=
 =?utf-8?B?N3paRFRSc21xVFpId1FhQjlVOUg3c2xUcGltUFZnS2dSa09yQ3RKd01pdThV?=
 =?utf-8?B?S0dzdmJVZlRnWHBLNFIvak5iRUpjT3NlN3FsQmNjeURMTzlmeS9mb0d4clFi?=
 =?utf-8?B?dTlweFlESStRaGw5NkU3ODJqOWs2QWFiMzk0NjJ2S2pCa3JPcFl3L0pRMUtm?=
 =?utf-8?B?VmlmOXNxc053SlJPeDlWWjhIUCtMR1ZuVkRqUGlTeU9oWHBsZ1hZT2o0RHk2?=
 =?utf-8?B?ZmRDSHIrdzRoN3JMdWZCRGgrVHg4NmpyMWVkTVRPRWhhQjhXdG1YQUZuSlNr?=
 =?utf-8?B?SllpZ2NHK3locS9SeFJiMHdza0EvMTVTK1FhLzgrcDVRSzllajJhMXAvQm5u?=
 =?utf-8?B?RnVXWUUzcVlRR0tPaFQxdEpRcGxRU2lsOCs0MTh0OVdqRTZOU2RWalRSZXVX?=
 =?utf-8?B?MldpdmNYb0U5bC9GTFFNVFBpQk94bGxDUjFyNFZiQklzdUkrMVRaUnJQNFZZ?=
 =?utf-8?B?bFBJb2EwME8zU3krQ1pKWUxJYnhaa3BuQ3k5eXdpTk85alcwblpDcWJ2aG9o?=
 =?utf-8?B?ejZwUC9qTzFPWThhaUYwYXl1REFMelp4UXhWZGpRVEtPTHRwQnZmQ3RBWDQv?=
 =?utf-8?B?ODhUZW44d3p4c2pnMy83aDFLYVFyeDFGSCtYUUs3M3hlL3pUWitZN1pUQS9I?=
 =?utf-8?Q?ljsIrHrDucHRT0RninGtZ+sWld7AUJfh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHFGWCtXc1lpaHQvUjBSTFN1Y1UvTTJKZjB0aDBnU1FHOTlmTHJucWhiNHZs?=
 =?utf-8?B?OVRpejRmRUU0dEg2L2lqVEtZN2NVejF2RjNsVDcrNE1tWWduWW5iZjFjNTdJ?=
 =?utf-8?B?UnFmV0xJMTdUSVRJUmJCVGpCbmZmN0dTYzJScGdHUGlFdnVSUmc3clRRb2FU?=
 =?utf-8?B?WXZBVkNCdUN4UldQcXlZRG9jTi9CeXVqQ2d2NG9iRWVLTjY3WWIvSzllU0Vk?=
 =?utf-8?B?c3V3MzJJRElLM0ltbTBRaFZITTMybWZxcU00YWUzMnUyUVk4U3dKVCtHT0xh?=
 =?utf-8?B?VDN0M2V2TTdqQ1lkT3d0UnJpODNsWDRZQ1FaOFltTldEMDVmL3VqN2R0TkRk?=
 =?utf-8?B?QkVoQ0ZYUHE5SjdqdGxyU1JDSmt5d1BDSzB1NFlnOW5iWWsvWGMwRnl1aFNs?=
 =?utf-8?B?Sm9NOFVuYkErVmlOWFI0bnJ0U2dmcldkMVdRTmFpeWVTNEVzWlZGZU9iV1Bz?=
 =?utf-8?B?bk40ZWN4QmZpRVo2ZGJndEhoTlYvQU9Fa0F2WUVUWlhkUURBRG4rNFRXTE0y?=
 =?utf-8?B?cU5vVjFjWU9NdFE4SjlOdEwya1NKelkvNFBVd3JFRk8rR3RjMldjcG8rSi9I?=
 =?utf-8?B?Z3dOQ3p6YmJMWUNsOXErd0FNbkg0aEtuK1RFdlMvU1VUN0VxZG5RRVAybG1G?=
 =?utf-8?B?TUZrbVlHeTlGQmZaSDZjMHFwVUo2amNFK214eS92Z1BKTzh2L1U5TmlHL1Fk?=
 =?utf-8?B?OHdycnFBQ1QzZkRwZXE5OThuZVVXSTFoS3Fackw1VGlSUFd1SUE2U1F0ZmVm?=
 =?utf-8?B?V1pZV0ZDMStuS0lRZkRieVArVnRDQzJhb2Y5L3d2blQrT2l0WGhORnpibkJo?=
 =?utf-8?B?dnlKV2hFTkluQThSWlYwRVZwWElQQzZOcEhOeGp0Y1dnQmFuSUZ2WEJDUkZQ?=
 =?utf-8?B?NTJKc1VxT2hoTGMrVjM4aFhEMStqckVYR0Y3K0Q2YlRPd0xETlBIcEtFdWZ4?=
 =?utf-8?B?bkNmUjBkejNZSGN0OHlqSmJQaVVKaDFuTW1peDNaZjdUN0ZxdTl6dkxXRzFB?=
 =?utf-8?B?cUQ1blR1RlY4UkNSRnZJamRZSytlSkw1alZ3cDFjK05jbnM0UFhYeGNENmgy?=
 =?utf-8?B?bXBvdTlTZUNGa25lZnA3aFREWGpFTWtGSEV2dWVnNWJoNWdWSDdLamcxUjc0?=
 =?utf-8?B?Ly9rSjJMSDhZVld4OHJFNm9iU3dCRW5sdGdYSEp1QVlidU1VYXY2MDgyUWtD?=
 =?utf-8?B?Nk5IUkZNVGk3Y2NzZlJiOERoTHhzdVdrVVdDcTFlVFVaaUlHa2xVeVdqNzNX?=
 =?utf-8?B?Q25xVXN1WEtSS2o2eWtqTDhHVlZvamRFRzhhM2pWV3ZneE1XbEJ2WWFVRFVa?=
 =?utf-8?B?bi9LSkRPL0pQcC9ockJZUnZLSjN2T21jM0w4SGN1VzNQRU9hRW5nMkpwQUJ1?=
 =?utf-8?B?SGdmdEJjTXU0V1A5cjBITGxBVjNHWVRJK1Jhc2RXWkFWSW5rTDdkZ3liSENV?=
 =?utf-8?B?dnRRVHpYTjdYT0oxNkNTeThnZFhXVXZBc3dSNTVGZEsxUUl1SjV3cktvNXFJ?=
 =?utf-8?B?MTc0dWVTQkxtb0lzN2xYQ3Q5WkFPNnJramxYTnp0SEtlREVLRm1jRlBScmUz?=
 =?utf-8?B?VUxnSzRxUUplWForS0gwZDRyTFp6N3pBbHhBZmRCK3lOUWpra3NLbC9acllI?=
 =?utf-8?B?UEhRd1lOYWhSaEdkN1pJV29pZlJhNGhrZVB5UkVDaHp1bVNuMnRyamh6MVg1?=
 =?utf-8?B?RDR3Qk9rcElraTY4TXdkQlp2SGgrZE83ZkpEaWJVWXgyL2I3YVlpb3h1Z0xo?=
 =?utf-8?B?QXo3UlRUbkNKZEhFbHJaWmtyaUdkaEJ1ek5PVklGZWJHbmpiUE9aWkptOXBR?=
 =?utf-8?B?UWxGWU5NMWZXUERSMDEvbVNvazB2a2J1cnd1d3pTZ2dJTE9vTmNDN3lzeTJq?=
 =?utf-8?B?WHM2Vm9iaFhwSUliNlU0K3BmUXFqQ3NCOUxTOFA5VDlVSWNMalZBN2JPZGQz?=
 =?utf-8?B?a3Q2a2VWcklEWGFtY0RRaWg3Q1hmY2gvTkJMdERLOFRnUzZQOFN2QnpxSlc3?=
 =?utf-8?B?anc2ZjdDeUc4a2NKQlNKTFhDZDVpd3pVcHZXNm9ZekJkcGt4TXZoMnpUUU5I?=
 =?utf-8?B?WEJpQVcrMUlJSzFKYy9LY0l0UEtta2JhSXU4T2RmVFBPbE5WQ2U2NVFDRHcx?=
 =?utf-8?B?eTUwMUdQa0F6QnJaRkVMYmZMcG00SCtPN0IrNDB4cksyQmRjZ1pkQ0Zha3Uy?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B4E7CB1CCDD8948809E89587C991A17@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c93676-9956-40fe-ff9d-08ddbeaea809
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:05:50.8915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtTDrgpWVLq1N8yJpvkiidZMbdfMpP+dsvM7wHUQIo/45pAckXKcqu+SqbxVWPqL95qrW+X2q70LM9bbOsGkMvBFpenbA6G1HUShT0zk1ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8181

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDEyOjI0ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDAzLzA3LzIwMjUgMTE6MDUsIEFuZ2Vsb0dpb2FjY2hp
bm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIGNsb2NrczoNCj4gPiA+
ID4gKyAgICBpdGVtczoNCj4gPiA+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG11eCBmb3IgZHNw
IGNsb2NrDQo+ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiAyNk0gY2xvY2sNCj4gPiA+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IEFEU1AgUExMIGNsb2NrDQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgY2xvY2stbmFtZXM6DQo+ID4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiA+ICsgICAgICAtIGNv
bnN0OiBhZHNwX3NlbA0KPiA+ID4gDQo+ID4gPiBJc24ndCB0aGlzIGNhbGxlZCBhdWRpb2RzcCBp
biBvdGhlciBiaW5kaW5ncz8NCj4gPiA+IA0KPiA+ID4gPiArICAgICAgLSBjb25zdDogY2xrMjZt
DQo+ID4gPiANCj4gPiA+IERvbid0IHVzZSBmcmVxdWVuY2llcy4gSG93IGlzIHRoZSBwaW4gb3Ig
aW5wdXQgY2FsbGVkIGluDQo+ID4gPiBkYXRhc2hlZXQ/IEhvdw0KPiA+ID4gb3RoZXIgZGV2aWNl
cyBjYWxsIGl0Pw0KPiA+IA0KPiA+IEluIHRoZSBkYXRhc2hlZXQsIHRoaXMgaXMgY2FsbGVkLi4u
LiBDTEsyNk0gKHJlYWxseSkuDQo+ID4gDQo+IA0KPiBPSywgdGhpcyBpcyBhIHZhbGlkIGFyZ3Vt
ZW50LCBob3dldmVyIHdlIHN0aWxsIHRyeSB0byB1bmlmeSB0aGUNCj4gaW5wdXRzDQo+IHNvIGJp
bmRpbmdzIGNhbiBzaGFyZSBzdWNoIHBpZWNlcy4gSXQgaXMgZGlzY291cmFnZWQgdG8gaGF2ZSBz
aW1pbGFyDQo+IGRldmljZXMgd2l0aCBkaWZmZXJlbnQgYmluZGluZ3MgaW4gb25seSBvbmUgcGxh
Y2U6IGNsazI2bSAtPiBjbGsyN20NCj4gb3INCj4gd2hhdGV2ZXIgb3RoZXIgbnVtYmVyLg0KPiAN
Cj4gQ29tbW9uIGlzIGFsc28gdG8gbmFtZSB0aGUgY2xvY2sgaW5wdXQgYmFzZWQgb24gdGhlIHB1
cnBvc2UgKGxpa2UNCj4gYnVzLCByZWYpLg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNCk9uIHRoZSBNZWRpYVRlayBwbGF0Zm9ybSwgdGhlIG1haW4gU29DIGNsb2NrIHNv
dXJjZXMgYXJlIHR5cGljYWxseSAzMkssDQoxM00sIGFuZCAyNk0uIFRoaXMgaXMgd2h5IHRoZSB0
ZXJtcyBjbGszMmssIGNsazEzbSwgYW5kIGNsazI2bSBhcmUNCnVzZWQuDQpTcGVjaWZpY2FsbHks
IGNsazI2bSByZWZlcnMgdG8gdGhlIHN5c3RlbeKAmXMgMjYgTUh6IGNsb2NrIHNvdXJjZS4NClRo
ZSBjbGt4eHggbmFtaW5nIGNvbnZlbnRpb24gaXMgaW50ZW5kZWQgdG8gaW5kaWNhdGUgdGhhdCB0
aGVzZSBhcmUgU29DDQpjbG9jayBzb3VyY2VzLCB3aGlsZSBhbHNvIGRpc3Rpbmd1aXNoaW5nIGJl
dHdlZW4gZGlmZmVyZW50IGNsb2NrDQpmcmVxdWVuY2llcy4NCiANClRoZXJlZm9yZSwgdXNpbmcg
b3RoZXIgdGVybXMgY291bGQgcG90ZW50aWFsbHkgY2F1c2UgY29uZnVzaW9uLg0KIA0KRm9yIGV4
YW1wbGUsIHRoZSBBRFNQIGNsb2NrIHNvdXJjZXMgYXJlIEFEU1BQTEwoODAwTUh6KSBhbmQNCmNs
azI2bSgyNk1IeikuDQpPbiBvdGhlciBwbGF0Zm9ybXMsIHRoZSBkZWZpbml0aW9uIG9mIGNsazI2
bSBpbiB0aGUgRGV2aWNlIFRyZWUgU291cmNlDQooRFRTKSBpcyBhcyBmb2xsb3dzOg0KDQpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC5naXQvdHJlZS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNpI24zMjgN
ClRoZSBtdDgxOTYgcGxhdGZvcm0gdXNlcyB0aGUgc2FtZSBkZXNpZ24uDQogDQpCZXN0IFJlZ2Fy
ZHMsDQpIYWlsb25nLkZhbg0KDQo=

