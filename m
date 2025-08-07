Return-Path: <linux-kernel+bounces-758989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3392B1D6B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B32161F58
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB5277CBB;
	Thu,  7 Aug 2025 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S6t+FgdZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KcxARuwG"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330D5238C16;
	Thu,  7 Aug 2025 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754566275; cv=fail; b=R6Ji+utg9H8UChaYI3DsrJxdV+0FHUyN/WpBAvtyEfuWPVEGEGkcqCgI+wNYS4WIdZlM5K9CyKpdF2h1wSSWMhY7ihF0MCirMDRWmpApT1R3KAx2BXvsljQ7YvRu9FR+GUj2JzaDPb5fdsGccjab+ll0fKA3IIBG8HlgGdNiLQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754566275; c=relaxed/simple;
	bh=MndTKRxMAYv8SD3BbnlaI0pubu7Gy3T0uiYa2Bg5a3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KkYaVCLRrpwvh+elGYMqgJ49n2T4M0G/pPvP8rgo51Dk8K7N13LlOOCLVxG8/742FnsNCsznXPTRLQHUzsZSAf1YlkZYl3PQjYfxBNDR8tEDQhjU7wQuaO0iTwqPuNCo0P+hqV2Dhohi9o2UJjA02mdztb4rxF1AXnpPqaSMdTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S6t+FgdZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KcxARuwG; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fff9c0fe738111f08871991801538c65-20250807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MndTKRxMAYv8SD3BbnlaI0pubu7Gy3T0uiYa2Bg5a3c=;
	b=S6t+FgdZcb+H37i9XfJiZSX0qcHCaIMGo+AhLhKx27MiHLsgIlLpSdAQZCUEAx1IwVYwHNKyNIcM+lXioF7x0NyI5TlLAJG2uuX4ypt0ENycERGtEh0bb4MYdxB4SZKX3qdAlunE74lOSjR9UTURaB7jw+I9axo3OH81Dtqwe9M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:ddf1f9aa-3fa9-4116-b6c7-05eb9fe71b40,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:153a2b51-d89a-4c27-9e37-f7ccfcbebd5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fff9c0fe738111f08871991801538c65-20250807
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 877160889; Thu, 07 Aug 2025 19:31:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 7 Aug 2025 19:31:01 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 7 Aug 2025 19:31:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGVELdJoKPXYUVMzqDg7BT7DoxK6W6xUC6Nv+CKVwlmRX2ewEdZb+nrilmzFYRO5Z+lsHwBdgz0BOT9Xs5McM0LGZmy408xi/v+KZhmtvDhI61OkXz0Jx9l3MblA4BwV2uhCrAGMLvVFZQjNuwOsU+b8tDDafCIAo1fLzF9ThCHukmJfRY6k+Dl9egtTRPp+sts9nqd2zW6yPgfZeow2rw+qu0kmQP91xqNdceV0/kmBi+1uUiclRNW61iOAJhica8kLkE/regQlEigETg9ciAwKd6WMSxQzRwioqJKr/f0ig/kXrG+eVs3cDQ97PeL6eZPN9V2eO9x6z8dhrE2xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MndTKRxMAYv8SD3BbnlaI0pubu7Gy3T0uiYa2Bg5a3c=;
 b=FHMYfcF7BRwevkkVA9bKQQixgrfIMo+KaK8s/BRaxUuTDO09OcqPkIdc7HX1ChclXaS+KVpuvO3gpBInOxvUEc+41a/YGEILFAfehR3bVZ7ckS1uFKmCK4ISTYjTAioPeFokfqgLO2YulvssqlpAHU4duhDn20iAWVplCBhyjN7LXF7x/x1jRDm7RWUq6lTMnc+OoA8+bRGVfVf6SdoDdczGPUlOKQMp4bEIXqvGcOWj1gnpEXR+nSWjotWVJ1cEUPEVS1V2TM4rH8rdyoBEh/tv4S/HGbb/GmvXxqSmF0cBy4UvTMJbWGRc9v8AIO3fFASq2G0LNzmwae0HLioWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MndTKRxMAYv8SD3BbnlaI0pubu7Gy3T0uiYa2Bg5a3c=;
 b=KcxARuwGwgAJeuKVNV3HBsjMj/XeiZsXr0C/t7lR86+5oasWnwe+ZoaQ/Kt6xooo1Ai+2sNmkAQ9F9g5YJWhiw/3CMpi06j5u7b+lCaT0mjTV3JWdtRXv5gKWTfcDjvWjhUgRVqv6m6QPaf/uDiAIcV6Ik8A9X8HLXjhRtIa/i0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7244.apcprd03.prod.outlook.com (2603:1096:400:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 11:30:59 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 11:30:59 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?=
	<Jay.Liu@mediatek.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Topic: [PATCH v2 2/7] drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n
 function issue
Thread-Index: AQHb/sZy890y7qtL6Ei1hKjl+z1IFLRVO6yAgAGNIICAAFckAA==
Date: Thu, 7 Aug 2025 11:30:59 +0000
Message-ID: <5d87836c4c78f7f98233d5c304ef2770d43b0e2d.camel@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
	 <20250727071609.26037-3-jay.liu@mediatek.com>
	 <a0e1845df41238678d3f5a568ea278ba7b1f0f61.camel@mediatek.com>
	 <8b589879a5e4b60041bee5303697b2a6a707ee9e.camel@mediatek.com>
In-Reply-To: <8b589879a5e4b60041bee5303697b2a6a707ee9e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7244:EE_
x-ms-office365-filtering-correlation-id: 16432262-afe7-4261-c74c-08ddd5a5e1d5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|42112799006|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?dkFSemQ5OWgzYmhQd1F3cmczUUM1UjlVWEVtUEYxVC9RbytHUUtDZ3ZSME1a?=
 =?utf-8?B?OTAxVzU5S213Z2ExTFQ5Um15bjdPS1p6cHc2STloUXB6L2hDL29nN0lzcWhS?=
 =?utf-8?B?SmE2V0Fib0xTMlhuL3JZaWNqVVh0YXpaeWp1TDNKdVBsL09ZL2JLVVR4VzJO?=
 =?utf-8?B?SzA5aWhUUHI4bkhMeGhpajhHQmUyMzJqZ2xzRzF1WjVhU2FDTkVybzVtY1FY?=
 =?utf-8?B?VnBxUS9EeXZVZStjNXE4QWpYa1ltb1Z6VXVNK2RkYnVETmI0WnhRajlCa2Zt?=
 =?utf-8?B?OGpYaXFmaFZseWpBM1Q0dUZaRzJOQlNCejF6dHVmRU1LNHhHaEM0SmpJVTZD?=
 =?utf-8?B?dytLU1JEOWdEL3BNNVlNMnpCSnV4bzk5ZTZuK1R5WElKZzRIK3FVTS9KNXJP?=
 =?utf-8?B?UVIySzFnQ2xMM0IvUEk2Q2RrSUFBMGEvbkhFaWJhSUpzYlBkL1llM3RqVUlN?=
 =?utf-8?B?WFF5eWV0U3pLRExiUTRxc1pPaWQwU211b2hDbEt0TmxPQ3g1Z3dPcjI2Y3py?=
 =?utf-8?B?Z1haVkhkdkt3ZVRsZ0lTZG5rYlZhUkx3eTNaSkhvQzhpalhkVjZIc01wdW9T?=
 =?utf-8?B?TWdMdlZCdVFiSnk2eGNmNUh2N3habUNOTHJ4RU91QjkvREdiTlVQSVZVT05G?=
 =?utf-8?B?SWFyKzhtSURQQnczVWpScGl4RzM1UTZ6MThydHlmcHNwSkZ3V1BCYzhubTlJ?=
 =?utf-8?B?QmRuZC85WVdBcVNPcVJtUTJpbGl4cUFudzAwWFZ4ZjNYYzdDamF6QXdURmVp?=
 =?utf-8?B?K0JrSGY4cDg0UnhWb3orK3dtbUs3SmdOZ0loVXNGZmVtQzdRSUJocWhaK3pM?=
 =?utf-8?B?V0R4THJldHZVaUoyM0V3VDF0eHFsT1lta01YdEpVaTAyMWdNeFBYelJXbmFY?=
 =?utf-8?B?dWU2WWc5b2FHOVh4c24vNm5yQlBqTTFCNzhVV3U5TGs2T056Q1BTR05pM3Aw?=
 =?utf-8?B?bWhEWTV6R09UN2w3eWEyUEk1YXNDc05WeEUvTitYaEFtUXRJYitqUm5PVkV3?=
 =?utf-8?B?WFV1RHVGWDYyUDZueVZyd2xRbWM0L0ZPK0RmbVpIQjdSQVY5Rm1VQnhKNU9h?=
 =?utf-8?B?R01rTjE5WnZTMjI5K2hsajB0Nlh1N0RjV09wLzUyQ0kvR25adUdocGJlN3BJ?=
 =?utf-8?B?SkxCZGRiTmhhcXdFY3VNQkJPNDJDOU90ZzF2Q1dDUXBrQmM5eWRNSnhYVlZy?=
 =?utf-8?B?Yk1mQkdKYXNDU0tMbkFYc2RIMDQzTnlBeVowZGhwR3JKcGFvVkhzRVJRbU5V?=
 =?utf-8?B?Tk1KYmlrRGJjNUN1WnFqU0d4ZDBqMDlicUUwMm9vNGltT1MyMWt6SE9kMUta?=
 =?utf-8?B?anVzN3J3WEV3QTdzOGRheGZkZWhod0MrY2REQm53ZHdHQUlIN2NNMDNWbW5F?=
 =?utf-8?B?aytQOEZELzJXMnJBQW1MN1N3NFk0b1l6QU1RakNWRGFaa3ltbjRyQXBnY3Nk?=
 =?utf-8?B?bm1VMHpjaUNxMlRaRTAyKyswN2xUQnUySXlvYlpDOE0vMjd4WVJkVXVDNjRi?=
 =?utf-8?B?K0tmWDl6Y1E4dFVNUW0rb3FBRmdIOEsyZkd4RHYzYUs5aHFhaFNBWGcxN1BI?=
 =?utf-8?B?ZmNtLzQzZjk4c2xpTGtvdkFTeWNDT3M3NlUrMkZQcno5cFBoSWkyS3A3dzA0?=
 =?utf-8?B?ZkpRS3M2bkFhRmNtL3B4Sm5nb09VekhRL2paNVVacHI3ZzhQWFNaU0UyenB4?=
 =?utf-8?B?U2RWcnF3VGMwdVlCdERyVFA1cXo5MkYrSTFNK2FvaHV3d0ZJMkJQTW91NDJ0?=
 =?utf-8?B?S2lnN3FuOWZxUzllZ2xZVGV3ZDRFNitWa2FJcDFFMWVPZWJhUEcra3VaYlR6?=
 =?utf-8?B?bVZrMzJSd0xYelFISWN5Lzh6UWwxTkRUUVo0WkhJTThzUlpGZHJjdjFyeDV4?=
 =?utf-8?B?US9CUVpGL0hZY1MwT1p4N3FoUzgyS0Fia1dzZWtIM0xNUW96YjQ2WTBnUGVv?=
 =?utf-8?B?TjRpSlhSWTFKaVRVekcxWnd2aVM2TWlaNmg1dmVlRUFXUk90MmtRRTFIWngr?=
 =?utf-8?Q?cH8V+0QDJ9bN4F4BFd2KJV+ugVJ730=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(42112799006)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzFjeDBrUzVYeFlaTFo5cllzcVVsaXF4L2hTQjZCKzZyRitJMlcrUkpNVkR5?=
 =?utf-8?B?SHViMUNYaDJ1U0xxdmtDWDF3YWlyanU0aGIwMkdzNVRmMS95WnJuZHJqclJj?=
 =?utf-8?B?Mm1wM01obVZRV1p1aEpwWkc4YVZNN0FnZDFpM0VsVlk0QjJXRnVTSm9sd1p4?=
 =?utf-8?B?YVZvYzRoMUJMVUM4ZTIrSUlNUUhSeTN5NVFkMXZaY1l2eGRwUDBSZW5BclpZ?=
 =?utf-8?B?ZWZ5eGk0SnM4QTUyUThzT1B0Q2hNeEpJVm9hQjMwbzVNMUV6akNEYW1iU0tx?=
 =?utf-8?B?TDk3b2tZREJsSUdqQUpsMWFhMDB4K3l4Q2NyN3o3RTQyaGdNRGN6MmpnY3dW?=
 =?utf-8?B?bkhrelZxM3VDTDEzd2FpMFRnckVtRVN0aXpSbGNFQU5CMXdRN2xZdXo1SmI4?=
 =?utf-8?B?SmhybzdNRE5kTFBTU3UyZ1VXZytTYSs4aS9nRU5MdTBTNlFTUjUwanNjbnRY?=
 =?utf-8?B?MXlWUHVoclFqc2M4UlcyOUpIVnZHWk1ZZGMwUGxLZi85akxsRTNuQWZjT0Iv?=
 =?utf-8?B?QlhodlA2a0FVUU9WUGJFcFd3VVlMWE0yQ2VUSXZPRUFFbVNoVERXMlBkb0t1?=
 =?utf-8?B?LzFUL0ozeDZrQy9Tb2JlSHlRTi9jWWxhWWZZdDJjbDNLdTlZcm1LNWU2bzEx?=
 =?utf-8?B?KzdKRlZ3NTU4NGdwNlFsWVdSQ0lzV1BCVWlyVDFYRnUwVjJSRDRWemdycXE2?=
 =?utf-8?B?OHFJTC9halRycGUxR3VBM1pBdTBwdDM3SzFVL256azNSVlY3U3ZBdEdRRG1k?=
 =?utf-8?B?TU9ZMkplakVTMC9UTXdOV05QZ2VMQmpHSlZUQmZEQ0JHeXdyaTEwMm05bUdP?=
 =?utf-8?B?Ukw5WVQwLzVvMTVXZEI2ckxZeEVPc1lhL2llRkd3bDJ1Q1c4Y2NtNGlNclk1?=
 =?utf-8?B?QkJUb252VlRYUG9JeDlwQjdiSHNTZTUyOGJaaGQrRHhLZ3dIZnZ3QmI3a2Jz?=
 =?utf-8?B?WlJjelhhZ1RIZ3oxVmU0S3E5dFdHS01FUDl5RjhEMDdXbDNKMnhTeHhNOGhN?=
 =?utf-8?B?TDBZOHE0QWJRbjk2SFlodXNhYkhrM1dSSm1QOURYMjF3dytpTDE1TXNRbmVr?=
 =?utf-8?B?Y3NwSkRVVkFVa0ludWFIdnVyNzlxV0gvaDNRcFV2TndOa3R6aGMrVWplNnIw?=
 =?utf-8?B?eHlDdDlLcnpTdDVwVnZRcU1qRnpIS2taL28xd0dKc3l6UWFPeHNEQ3hXQ2NX?=
 =?utf-8?B?TDVkMU43YUdmOUdEenVnY2tJT3BRVEl4bnVBYm5Lb1cwaTk1Q1kveGc5V2pu?=
 =?utf-8?B?NVlTVDVDU0lQdmNuZXgyck11d2ZBZW5QVit6aFZXcHQrRTJwNWhBZGZYOEtK?=
 =?utf-8?B?L3F2Sm1BTU5ibHg1ZHVkN3RzZFh5MTNTcVpiQndHNEZiOU9TWURsK3VuRkpz?=
 =?utf-8?B?TEUzZHFRT21BczRoMWFoSlMzZWM3SWYyU01lcUo0WTdvRGkxUlRmTENoaE5X?=
 =?utf-8?B?dWQrV1lSTkZQZjNieldyZGsyQW1kc3JxODFtbFl6U0tCak1ZYnBUMExyTjFP?=
 =?utf-8?B?RklZc3FSUnBBRkEwN0FRaTQxMExnWWJpaDZaM1B4cGR0c295TS9URmtqSDMx?=
 =?utf-8?B?ZWExYkFKWFZ4NjcwTlU2aFJaeWlaVzRHdlc0TCtrczc2UDhZZ3ZyTitGaTBG?=
 =?utf-8?B?T01CNkNCVGI4Rm81RXhSV2VsdjRpekdFL21NL29hR0s1ZzUwT09uMURTMVFa?=
 =?utf-8?B?V2hmMHBsQnlhMzBmcWhmRTd5Z0lmNmZUUGhwMGNodGJibkJDa0dxTTNUem1n?=
 =?utf-8?B?Tmk0Ryt4bWkvRFJ0LzZRRnlHcGNQSWM4OFk3SlpKYjlYT0hoUUhwbnJ5SnRO?=
 =?utf-8?B?QmZaM2ZCTlBMQlRrQ3RSMHpqSkF4TFk4ZDZTZFFRd0J6N1puSElyOFhjN0tY?=
 =?utf-8?B?c1pMZllNVnAxSVpVdTFFd0JncllQQ01aU0dPOGhjT1dCUnlHM29NZzR0VThJ?=
 =?utf-8?B?NWNaWmVWMzE1QUNwUnRJL21SVlpMUFBuQzUyOUZydDhjdDdhK0pNTmFEeFQz?=
 =?utf-8?B?MEt5NFhSWnNXVUxoaDRXZjErSElsOE5yMVlaRzRPNXlJNitnN0JGM3hydFRI?=
 =?utf-8?B?dy96a2Q4OFN2TGlaa3FCdUEzS2ZyNFdBQkx4UVNKL3NsbmVkWnJzMVVQZStP?=
 =?utf-8?B?OVcweXQ5ejZnQjE5cWFzUHFMMkJVNnNiSmtjVlNndWtGbGdpdmxIUXlCZk9X?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4879A1E82FFDE4384522E869E83E68D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16432262-afe7-4261-c74c-08ddd5a5e1d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 11:30:59.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJuiK8ZkV8MfHTc+qRa6FLqos0VAk+j+UZBDt1VYC1Ovzbzxk4kZXa5DppcWGstf6wiLdtnIDKD3zgvx72bVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7244

T24gVGh1LCAyMDI1LTA4LTA3IGF0IDA2OjE5ICswMDAwLCBKYXkgTGl1ICjliJjljZopIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjUtMDgtMDYgYXQgMDY6MzcgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkp
IHdyb3RlOg0KPiA+IE9uIFN1biwgMjAyNS0wNy0yNyBhdCAxNToxNSArMDgwMCwgSmF5IExpdSB3
cm90ZToNCj4gPiA+IGlmIG1hdHJpeGJpdCBpcyAxMSwNCj4gPiA+IFRoZSByYW5nZSBvZiBjb2xv
ciBtYXRyaXggaXMgZnJvbSAwIHRvIChCSVQoMTIpIC0gMSkuDQo+ID4gPiBWYWx1ZXMgZnJvbSAw
IHRvIChCSVQoMTEpIC0gMSkgcmVwcmVzZW50IHBvc2l0aXZlIG51bWJlcnMsDQo+ID4gPiB2YWx1
ZXMgZnJvbSBCSVQoMTEpIHRvIChCSVQoMTIpIC0gMSkgcmVwcmVzZW50IG5lZ2F0aXZlIG51bWJl
cnMuDQo+ID4gPiBGb3IgZXhhbXBsZSwgLTEgbmVlZCBjb252ZXJ0ZWQgdG8gODE5MS4NCj4gPiA+
IHNvIGNvbnZlcnQgUzMxLjMyIHRvIEhXIFEyLjExIGZvcm1hdCBieQ0KPiA+ID4gZHJtX2NvbG9y
X2N0bV9zMzFfMzJfdG9fcW1fbiwNCj4gPiA+IGFuZCBzZXQgaW50X2JpdHMgdG8gMi4NCj4gPiAN
Cj4gPiBZb3UgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiBNVDgxODMgQ0NPUlIgYW5kIE1UODE5MiBD
Q09SUi4NCj4gPiBUaGVzZSB0d28gU29DIGhhcyB3b3JrIGZvciBhIGxvbmcgdGltZS4NCj4gPiBE
b2VzIGJvdGggU29DIHJlYWxseSBoYXZlIGJ1Zz8NCj4gPiANCj4gPiBJbiBjb21tZW50IGJlbG93
LCBpdCBzaG93cyB0aGF0IEhXIFMxLm4gZm9ybWF0Lg0KPiA+IFRoZSBwYXRjaCBzZW5kZXIgaGFz
IG11Y2ggaW5mb3JtYXRpb24gYWJvdXQgdGhlIGhhcmR3YXJlIGluZm9ybWF0aW9uLg0KPiA+IFdv
dWxkIHRoZXkgbWFrZSBtaXN0YWtlPw0KPiA+IElmIG9ubHkgTVQ4MTk2IENDT1JSIGhhcyB0aGUg
Zm9ybWF0IHFtX24sIHVzZSBwcml2YXRlIGRhdGEgdG8NCj4gPiBkaXN0aW5ndWlzaCB0aGUgYmVo
YXZpb3IuDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiBZZXMuIFdlIHJlY2Vp
dmVkIGFuIGVtYWlsIGZyb20gY3VzdG9tZXIsIHRoZXkgZm91bmQgdGhhdCB0aGUgcHJldmlvdXMN
Cj4gcGF0Y2ggZmFpbGVkIHRvIGhhbmRsZSBuZWdhdGl2ZSB2YWx1ZXMgY29ycmVjdGx5LCBzbyB0
aGUgcmVzdWx0IHdhcyBub3QNCj4gYXMgZXhwZWN0ZWQgYW5kIHRoZXkgd291bGQgbGlrZSB0aGlz
IGlzc3VlIGZpeGVkIGluIHRoZSBjdXJyZW50IHVwZGF0ZS4NCj4gV2UgYWxzbyBjb25zdWx0ZWQg
d2l0aCB0aGUgREU7IHRoZSBoYXJkd2FyZSBpdHNlbGYgc3VwcG9ydHMgbmVnYXRpdmUNCj4gbnVt
YmVycyBhbmQgYWxsIElDcyBiZWhhdmUgdGhlIHNhbWUgaW4gdGhpcyByZWdhcmQuIFRoZSBjdXJy
ZW50IHBhdGNoDQo+IGNvbnZlcnRzIG5lZ2F0aXZlIHZhbHVlcyBpbnRvIGEgZm9ybWF0IHRoYXQg
dGhlIGhhcmR3YXJlIGNhbiBwcm9wZXJseQ0KPiByZWNvZ25pemUuDQoNCk9LLCBtb3ZlIHRoaXMg
cGF0Y2ggb3V0IG9mIHRoaXMgc2VyaWVzLg0KU2VuZCB0aGlzIHBhdGNoIGluZGVwZW5kZW50bHku
DQpBbmQgdGhpcyBpcyBhIGZpeHVwIHBhdGNoLCBzbyBBZGQgJ0ZpeGVzJyB0YWcuDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+IEpheSBMaXUNCj4gDQo+ID4gPiANCj4g
PiA+IEZpeGVzOiA3MzhlZDQxNTZmYmEgKCJkcm0vbWVkaWF0ZWs6IEFkZCBtYXRyaXhfYml0cyBw
cml2YXRlIGRhdGENCj4gPiA+IGZvciBjY29yciIpDQo+ID4gPiBSZXZpZXdlZC1ieTogQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bj
b2xsYWJvcmEuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSmF5IExpdSA8amF5LmxpdUBtZWRp
YXRlay5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiAyMDIyMDMxNTE1MjUwMyBjcmVhdGVkIDxq
YXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9jY29yci5jIHwgMjQgKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4g
LS0tLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9u
cygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX2Njb3JyLmMNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Njb3JyLmMNCj4gPiA+IGluZGV4IDg1YmExMDlkNjM4My4uYjA5N2MyMDg3N2YzIDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Njb3JyLmMN
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+
ID4gPiBAQCAtODAsMjcgKzgwLDYgQEAgdm9pZCBtdGtfY2NvcnJfc3RvcChzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gPiAgCXdyaXRlbF9yZWxheGVkKDB4MCwgY2NvcnItPnJlZ3MgKyBESVNQX0ND
T1JSX0VOKTsNCj4gPiA+ICB9DQo+ID4gPiAgDQo+ID4gPiAtLyogQ29udmVydHMgYSBEUk0gUzMx
LjMyIHZhbHVlIHRvIHRoZSBIVyBTMS5uIGZvcm1hdC4gKi8NCj4gPiA+IC1zdGF0aWMgdTE2IG10
a19jdG1fczMxXzMyX3RvX3MxX24odTY0IGluLCB1MzIgbikNCj4gPiA+IC17DQo+ID4gPiAtCXUx
NiByOw0KPiA+ID4gLQ0KPiA+ID4gLQkvKiBTaWduIGJpdC4gKi8NCj4gPiA+IC0JciA9IGluICYg
QklUX1VMTCg2MykgPyBCSVQobiArIDEpIDogMDsNCj4gPiA+IC0NCj4gPiA+IC0JaWYgKChpbiAm
IEdFTk1BU0tfVUxMKDYyLCAzMykpID4gMCkgew0KPiA+ID4gLQkJLyogaWRlbnRpdHkgdmFsdWUg
MHgxMDAwMDAwMDAgLT4gMHg0MDAobXQ4MTgzKSwgKi8NCj4gPiA+IC0JCS8qIGlkZW50aXR5IHZh
bHVlIDB4MTAwMDAwMDAwIC0+IDB4ODAwKG10ODE5MiksICovDQo+ID4gPiAtCQkvKiBpZiBiaWdn
ZXIgdGhpcywgc2V0IGl0IHRvIG1heCAweDdmZi4gKi8NCj4gPiA+IC0JCXIgfD0gR0VOTUFTSyhu
LCAwKTsNCj4gPiA+IC0JfSBlbHNlIHsNCj4gPiA+IC0JCS8qIHRha2UgdGhlIG4rMSBtb3N0IGlt
cG9ydGFudCBiaXRzLiAqLw0KPiA+ID4gLQkJciB8PSAoaW4gPj4gKDMyIC0gbikpICYgR0VOTUFT
SyhuLCAwKTsNCj4gPiA+IC0JfQ0KPiA+ID4gLQ0KPiA+ID4gLQlyZXR1cm4gcjsNCj4gPiA+IC19
DQo+ID4gPiAtDQo+ID4gPiAgYm9vbCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZQ0KPiA+ID4gKnN0YXRlKQ0KPiA+ID4gIHsNCj4gPiA+
ICAJc3RydWN0IG10a19kaXNwX2Njb3JyICpjY29yciA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiA+ID4gQEAgLTEwOSw2ICs4OCw3IEBAIGJvb2wgbXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRl
dmljZSAqZGV2LA0KPiA+ID4gc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gPiA+ICAJ
Y29uc3QgdTY0ICppbnB1dDsNCj4gPiA+ICAJdWludDE2X3QgY29lZmZzWzldID0geyAwIH07DQo+
ID4gPiAgCWludCBpOw0KPiA+ID4gKwlpbnQgaW50X2JpdHMgPSAyOw0KPiA+ID4gIAlzdHJ1Y3Qg
Y21kcV9wa3QgKmNtZHFfcGt0ID0gTlVMTDsNCj4gPiA+ICAJdTMyIG1hdHJpeF9iaXRzID0gY2Nv
cnItPmRhdGEtPm1hdHJpeF9iaXRzOw0KPiA+ID4gIA0KPiA+ID4gQEAgLTExOSw3ICs5OSw3IEBA
IGJvb2wgbXRrX2Njb3JyX2N0bV9zZXQoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gc3RydWN0
IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gPiA+ICAJaW5wdXQgPSBjdG0tPm1hdHJpeDsNCj4g
PiA+ICANCj4gPiA+ICAJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoY29lZmZzKTsgaSsrKQ0K
PiA+ID4gLQkJY29lZmZzW2ldID0gbXRrX2N0bV9zMzFfMzJfdG9fczFfbihpbnB1dFtpXSwNCj4g
PiA+IG1hdHJpeF9iaXRzKTsNCj4gPiA+ICsJCWNvZWZmc1tpXSA9IGRybV9jb2xvcl9jdG1fczMx
XzMyX3RvX3FtX24oaW5wdXRbaV0sDQo+ID4gPiBpbnRfYml0cywgbWF0cml4X2JpdHMpOw0KPiA+
ID4gIA0KPiA+ID4gIAltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBjb2VmZnNbMF0gPDwgMTYgfCBj
b2VmZnNbMV0sDQo+ID4gPiAgCQkgICAgICAmY2NvcnItPmNtZHFfcmVnLCBjY29yci0+cmVncywN
Cj4gPiA+IERJU1BfQ0NPUlJfQ09FRl8wKTsNCj4gPiANCj4gPiANCg0K

