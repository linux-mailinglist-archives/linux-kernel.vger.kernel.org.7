Return-Path: <linux-kernel+bounces-816484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E16B57473
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C3B3B0ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D92F5495;
	Mon, 15 Sep 2025 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GWkmVaCV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bqszkV7r"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15F2F290A;
	Mon, 15 Sep 2025 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927719; cv=fail; b=p3AGbsVo18bxO1ClhnAl4mxgmyL8pbx8/KaWg6HbjNGDaQosqZ69Ln9vRcGDXafmasTjrEReWT4wtn2gqWZ5hhy1w6d5AoiJQGqx0oDtQ15aekWM/XDta5E1eL1hdgOeySATC0UwhdgGOUPSnEFqDWEbSaO1a+ORESkygaqKy10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927719; c=relaxed/simple;
	bh=J72OjeWlrLU+WXtg5tZ9Og5oJhoJbok0xYdHYKeCkmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BAtDrHdlkw47OkA4bQSS+4ZMVsSe/hlcg23J3f7SearCRGRW5PH8QNaOcMqzxxwDOPYhhrmQ87AxTRsD9+SJ3AeTw55GvR9cQKL4SrrVoULFQfWcK+Vr07pKTE23b14gMPUeKXClGdb+btrpItuKQT+XhTGMr34S/J4CtiGdilg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=GWkmVaCV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bqszkV7r; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7a9dc868921411f0bd5779446731db89-20250915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J72OjeWlrLU+WXtg5tZ9Og5oJhoJbok0xYdHYKeCkmg=;
	b=GWkmVaCVPzX2uFOTiHQ0PS2LpNKjZXjQcP84Ki7tR6aFQZOWa+c36jUyLcPMHsHKLCmHI7DzgASGbbn0WKS4eTw1jTrYT9C64EZA1jEwxmVMyd9P2WU2Gn/UZz/p5fc4CkhEAOB7TrxnzCaPvGipHhPE3hCJG/7GYumswHfbVuQ=;
X-CID-CACHE: Type:Local,Time:202509151715+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:25062d6a-959d-4d6f-82f8-2b30852162b5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:1eec54a9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|52,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7a9dc868921411f0bd5779446731db89-20250915
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1521887864; Mon, 15 Sep 2025 17:15:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 15 Sep 2025 17:15:06 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 15 Sep 2025 17:15:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPHPfHMxwEo59wVBgBxewJDWuj4FBcoQy6m1iCLCH24OeCXPGwRYu6x67Hy+aTy9WlX8nVl0/MtVX/x9zUPFpDYjsGCS0G5LDDMyf6JXnxfYA9QEV7a9URl876tzokWRFPyG2ZFsmW0+gmJZCx2u2KhhJzEspcfX3R6g7uGGyF7gXETEB3nWA77Eiyq0rOLwvtog+1ZnDO4Bx2bqLNgQCOm7kXynl2RCWPzTKwjBcyTHvFK6m8d4nI2NtUHtsXgXmcbkLA2x1O+FTbLxt9S8xOf7cke6z/x4c20Mm4brQzQ57dBO896XaLKEtK5FYYFzaToLht0KO2A/dHzqfpbV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J72OjeWlrLU+WXtg5tZ9Og5oJhoJbok0xYdHYKeCkmg=;
 b=cYGV875ZIwuEKe2gV23IhhBp3Pjj+l2IZv+7ZX/eD7V2t3hXwL552ntvB5idY0RoCVmQ4nAOuoxTJ5L9Gzqd5ozkkWi9D7T/tjqJCt2tHOEzdduv+VkgLIlT+sanYaelaybXPlLLIcaue78N4cjr+qm/NNbDta25yzmpY+hVzASQDzvnhwPm6yNfGeSqb4bT/TFDtKkuoiyZKQlIc0Aa0dplNc/j4F69THRZrR9odXQhCt57TDVlAhQqhLR9EUJgK7HNMlThGH2xXCoQ0e3D4/0a3yzl5xrbtvft/wljOdFbPwYMVlvrt6CzRPFDH/4oa8LMzcUltoKoUbACCkUs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J72OjeWlrLU+WXtg5tZ9Og5oJhoJbok0xYdHYKeCkmg=;
 b=bqszkV7rx0nuRVh6ewP1O201cMcaYQ7dEeFqgUPcgUPDV2osOyGhEq/0Ujh3Jd/XPhqbLJdJ/jvA1EJmOs5ZEAH+De7RqGYWalsNdIPqYsf3zsNPWjjbS4c+KkXuvFrCpuyj2mOa1N5o6N5u9hUlc9KoJR4r/1ocrn0fwIrWFLc=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by OSQPR03MB8747.apcprd03.prod.outlook.com (2603:1096:604:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 09:15:03 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%5]) with mapi id 15.20.9115.017; Mon, 15 Sep 2025
 09:15:03 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v10 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v10 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHcBrCYXXn8dpTcxEeaFgD9eans8LRe71oAgDVFsoA=
Date: Mon, 15 Sep 2025 09:15:03 +0000
Message-ID: <ed424c58891fc3e95d3e6c78ff2640bc1f54855e.camel@mediatek.com>
References: <20250806085946.11383-1-friday.yang@mediatek.com>
	 <20250806085946.11383-3-friday.yang@mediatek.com>
	 <ee2c04bd76dc71a534dd649c1f7e2aa40482d278.camel@mediatek.com>
In-Reply-To: <ee2c04bd76dc71a534dd649c1f7e2aa40482d278.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|OSQPR03MB8747:EE_
x-ms-office365-filtering-correlation-id: 9f61f52c-8bd9-4fe8-1528-08ddf4385ad1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekZzQmpZd1FueFJiRWNVWVZzTDRPNzZ6NDlFV213dmtMNzRXamcxemZxc2NW?=
 =?utf-8?B?eWxZa01DOFhWc0t2T1pBVjMwcDk0VTJZamFsZlo1TTNNM1JpcDBxbkJ5L2R4?=
 =?utf-8?B?RHA4c0ZKTk5yajJpL3hIVEVKa3gzMzV1SXFzTzhMN0hFME9ZaFhLZFlSRmVk?=
 =?utf-8?B?VU1NMG91eTlRZS9XZ1R5a2VXZzh1bFd2d0lTejk3dlcvVkJCTkY2eW1lNzRx?=
 =?utf-8?B?NWRXOXZjL3lWR01KRnhyNDJ3ZVdzT3FKVkhTZ1dJWEY3VG5pbDBvOXlKK3Zk?=
 =?utf-8?B?VEtzTkJ3V215N0ljUWg5T3c5bHlXTE80YitXMzY4N2thZ3RsQlVCMmNKL2Va?=
 =?utf-8?B?TlJKNVBReFhXNklCRjhxVHUwdkVvUEdNdEFYck5OQ0RnR2NadDN0cGl1R2x3?=
 =?utf-8?B?ckk1M2gybGRPbUJaMk1LQkRRbFRGVy9QdzdVU0l1ZTFJK1pPOCtodzhnNGZE?=
 =?utf-8?B?QVVoWStrYnpVdnViRG9ZTHlQNGpiZEtCS2V6Z0orUWc2V1EyNm85NG5EZUw5?=
 =?utf-8?B?Zm5hYW81eCt0bFphZHhxcjhrdkxjeXlRV0VOR3N4QVpGOVlhbldyOEpXdlhY?=
 =?utf-8?B?dm9BbCs1Y0c2THV4RjlPcjlvL2srZy9rZEJkQVBYN0lWbkgvQzlBKzdjaXZN?=
 =?utf-8?B?RVBTZFNXMnE5SW1aVXkvempKK0pmZ3YvMVJvTDRtYmhLUHdGWHIwSzFSbVRV?=
 =?utf-8?B?ekNMUDVCei9DQUZwSHluakhSNFdWM0h4aS9MVFZEaHJKSTlaU1gzWGVseitp?=
 =?utf-8?B?QUFUazhRYWVDNkQ2eDhiVmpiVXpXZDc3N2QzRzNoVXRtdnFBVXBlWkhsOGdv?=
 =?utf-8?B?NEVQd0gvQi83ZkVWeWtiWlMwN0E3Lys2NlhWd0R1TFNlQ3RDaHRpd1NIR3NE?=
 =?utf-8?B?ejQzK29QV2hOR1IvcUpFcTA3VEM2UTZVaEdsUWplcGw5bEpMS3owS2tsUDNi?=
 =?utf-8?B?UEtKYnVhbGMzMVR3WE1OejJheUNQcGp6MWdDUDJQVk9CRzd6R1BWZTdyTG9Q?=
 =?utf-8?B?N3JnRlJGUEdQZDhwdXFxY3NiTUdMUUJudGNtU1Jldm5sL1A0cDBGUjdHelV3?=
 =?utf-8?B?L3I0bFIwZ2hrajEwOUMrZnNhdXg0YS9RYTNuaG5aSDdnNkNEUnVRSVFjWEtk?=
 =?utf-8?B?cFlvWDVTWlZqUzVseDB2UmZ2b1VzOTcwMjlZQUsvTUVTbUdYYVhUUzcyTjFC?=
 =?utf-8?B?ek5mT3V4Y0c4SzRvaE1mRTVFVDFXYTRqOGNuV1lkeUs1QVR3eDA5a2pwM0Fv?=
 =?utf-8?B?UENGK1Fva3pHVXNyakxQNWZtVWxqU04rMU12VGRLMk5zZW9zbVB0eVVEa0RX?=
 =?utf-8?B?Z1cwMDRoL3NqMmxMeEUxKzFmRFEycUJwMm9LZnRVaEJXT0dEVGErZFo3MFFq?=
 =?utf-8?B?aHdGckp6aEJxaFhjcVZ0L0xGaldDcm1aOVhRN1h5RURuNTErb1lBOXFCSDFT?=
 =?utf-8?B?dklnL01qeGRzNkVmZVd6a0cxRDdCb1JzRVNJdm1ML2g2MHJMZ0RYeWcvVDNR?=
 =?utf-8?B?eFoyNEZHRTVWZUZPN3RKN1hYTW9QWWlMcExFbVMwd3BSdU1QVWE1b1FkTjJ0?=
 =?utf-8?B?RVlWdTNkNmJBSXMvT2hWK29MRXdER3J4ZkhZS091SERkbjc5TlBxK0V6cjFp?=
 =?utf-8?B?dlAwWGQveWF6UXc4cFBOT1ordmhEZ0hubnFia2MveXZXTlpNVnUvQzQ1Wnk4?=
 =?utf-8?B?QzQ0VHpDL3QyQ3hoUVl0ckJnRUZJVmVRSXMxS3FIeEYvZW56Q1JpMGw2WG5J?=
 =?utf-8?B?VWg2NC9rZFUrMzhGeENSQVBmVm5lWHo1T0hETGxuVzhSVEh3bEs5cm5Vb1M2?=
 =?utf-8?B?VFBXUnEyUzFRMjFEV3U3ZXRYZjJESGtZaER5MXErSVpoQUR5enB2c0ZFL3lM?=
 =?utf-8?B?M0RhSTFpZU91NElQb3p1b2tlRmRmbkRCbWFWNXkxTjlpUTFpSVU2dm9DeVBT?=
 =?utf-8?B?T21DeDRQQy9QNTlzbHN2MTZsU2VLSDBrZkVSVk1Mbk9XVDBieDVUZHpzcy9E?=
 =?utf-8?B?eFZsNitrMnJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUQ3NUQzS083d2FIUGxCZldlNkdHNzFrNzNKZmtWNkxHV1Jsd2RwRGsrV0JN?=
 =?utf-8?B?T2h1dnR3ODMxOWJWd3BQNDI4N0J2Mm5sZ3ZqbEdVcEprcVppOVZUVnFzNENz?=
 =?utf-8?B?d0dHRzVoeVdsSDFibkJnZzRleitTeWE4Z0tJcXNsTkRRNUQxZjRBVTBXczNT?=
 =?utf-8?B?aUV6bVFTT0tCZkViZVRvUHQ0dDF1VXphV1dXbXVNRmdnSnFzK3poL2xOSW45?=
 =?utf-8?B?UzZ5MkMrNmZFcmFEcm5tN2hESm5KK2NXZHpwejBza0FTdXdLancySHVid0Ex?=
 =?utf-8?B?K0NRb053Wll6a20xSjF1SjFpWlRvazNLR3Q4dk16NHpHM3VQdzU5TlVoZGdF?=
 =?utf-8?B?UWdhUGJGSHNhMnFsQUNpRkhjZ3AyQlUxZmZCa1BmR1Z1VXQvZ2tHc1Nwa0No?=
 =?utf-8?B?bjJqbEdEdkNER0Iwa1lwRHRIbXJQN0x5ZzQvOUlNWnUzQUh2L1lJVFVCdXZl?=
 =?utf-8?B?R20xSGxDZjFidklPSDZsUHBSVC9zcDRGKzVaQjlxaG1ocWp5Q3BtdEt4N2ps?=
 =?utf-8?B?cE9heFBIQmVVdjM0L1hzdkVxa205NkJ5dzRSOHBpcFB0N0lTaTFkc1dJeWtQ?=
 =?utf-8?B?MkFxcmt3REMzT0xETTFLVlk1VzJSWWRzTmgxOHArQStOV0NHSURuOEFBZkt4?=
 =?utf-8?B?S0E0NXd4bnFtVkF0NTArVEFTUmpKNUUwRDZKMG9VUUVtYkRndHVLb3ZFVWlh?=
 =?utf-8?B?N1BJa0ZLVjNsRlo3QnRBM0xJNzE1bXp2R0hVU0xvWXYxZHJGdnVmejdPc2Rh?=
 =?utf-8?B?QTZVd1RXV2ZURDBpdkUzdnBsZTRTY1VQNFJqUFJsdkhNOWxtUmpSTnpSQTMz?=
 =?utf-8?B?VktlMXdmWkxtc0k4Z3hoMUZpdWwvYmhVSStIQnNJcFZPd0YrNU1PVzlYRGhj?=
 =?utf-8?B?M3NjNjRETXkzaW8zU2tRdkJHRy8xaVpQWVo3NEw2U3lETlM0UzRpRFhqZ3lQ?=
 =?utf-8?B?Q3E0T1g4RXZTRHRuRU5kR3I0cWVmZStGZWR4ekYrd1pOeTJwOWVnQmNac08v?=
 =?utf-8?B?SUNwN0hLelYrbTIvaFZBRDFYSndhWHI0LzhJSFY3UkU3K2NGMXZpNUpPdlRR?=
 =?utf-8?B?eGhLb1dncndHRVVFWWJqV2FMbjMxQloxM3U0NXhQQndpOXhGT3BWem1kNy9i?=
 =?utf-8?B?cW1ram5DTUxTaHJ3TFl2ZWdYeXNYeEU3UXB2cG9KSWpJdTlDRmZrTStuSlg5?=
 =?utf-8?B?NHA2dmgvRkp5QjVNbVNKR2dMb3gwWWZkNVYzNFZlN2FYR3JMUnczMGVLOW5Y?=
 =?utf-8?B?OHRGS1F2cHdadFBLZmRiSU14Um4xalNQbytjczgxTXpETmNTaldqaXBsS1p6?=
 =?utf-8?B?RFJFSjlXVjFTczhIQWlHaVNha1V4U0l1M0QvNEtLVTdHQmZoTHB5UzRscVda?=
 =?utf-8?B?cWNYaTlQOGlGQXpmWnR5SngzU3JsaGtNeFhtMFUvdFNoTHZBZ0hBSFF5ZDk0?=
 =?utf-8?B?aEVocnRFQnZmVnlqdmxmN1pTZHRQd1FpUkozdzJIR3JmQkp5Y3RERWg1T1hs?=
 =?utf-8?B?cmtkbFdYeGlmMjR1dUE0dnBHRnBXb3FFZmFvUllwM0Jhd1JCOU9CZmFUUWhT?=
 =?utf-8?B?UzdEa1dQU2Y2aWx3cEhaR3RnMjNzcUhsWi9sSDdUM0c0UTFQVXpnYnhDNWtH?=
 =?utf-8?B?WEcvbmdqNURVaGJub0F0NUFrYmhEcHFTYWZ5dUR5Q1d3aktDUTQ0Nzl5dVlG?=
 =?utf-8?B?ejFZYW1iVmhxckNQYmpES2lsRC9tOW9zK2oyUGQrdFJLUENIb1h1WGRUL01s?=
 =?utf-8?B?UDdFb2d3bEZ5cmtybmIycXBwSWFxVlZSeGloUWxsUzNZQ1RuYldSeGIrL1Nl?=
 =?utf-8?B?d3NlK2E0UHRvRmpocXQ1c05IWGMwZE9CNzFQbi93d2JyOEVEaFpGNDFZZ0JP?=
 =?utf-8?B?d3pUUnN2WnkrZ2gxcmVURVExdUZLeDdGYk1GWk8rZlZuSnYxbDRkL2NFN1RZ?=
 =?utf-8?B?eUkvYW9GY3NqN0VYVStVME5iUzNCYnJLTklqbWNpTXBFaEpJTDl3NENpeERH?=
 =?utf-8?B?SVF6bUpmMXFhUmJhNlZhU1Q0aXo5dXRvakcrRldGeHJWMEp6TkxlRE5rdTl3?=
 =?utf-8?B?d3k1dXVEYjJWOHZQUTB4SGNpSEpOYzJPT2xRRGV2UHk0bFBnZmVzNkFIMmQ4?=
 =?utf-8?B?T1k0VVVaUmc3WUFUelFjZVFBblNnd3VWMEI2QzdpUmJvZFQ0T0ZiMWttRG56?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A656FB87019B024DABDEF0DDDA1CAF64@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f61f52c-8bd9-4fe8-1528-08ddf4385ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 09:15:03.4866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9SWs41HIUWHkYNBe4B6NYcxXxI7VoKosCl2CUydNGWc+gGqklu+i5pMshHmCGe2UA2W4VfXsaXtwk/MeyPJfjqEEtOljga/q1ErKs9jyw4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8747

T24gVHVlLCAyMDI1LTA4LTEyIGF0IDExOjQzICswMDAwLCBZb25nIFd1ICjlkLTli4cpIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjUtMDgtMDYgYXQgMTY6NTkgKzA4MDAsIEZyaWRheSBZYW5nIHdyb3Rl
Og0KPiA+IFRvIHByZXZlbnQgaGFuZGxpbmcgZ2xpdGNoIHNpZ25hbHMgZHVyaW5nIE1UQ01PUyBv
bi9vZmYNCj4gPiB0cmFuc2l0aW9ucywNCj4gPiBTTUkgcmVxdWlyZXMgY2xhbXAgYW5kIHJlc2V0
IG9wZXJhdGlvbnMuIFBhcnNlIHRoZSByZXNldCBzZXR0aW5ncw0KPiA+IGZvcg0KPiA+IFNNSSBM
QVJCcyBhbmQgdGhlIGNsYW1wIHNldHRpbmdzIGZvciB0aGUgU01JIFN1Yi1Db21tb24uIFJlZ2lz
dGVyDQo+ID4gZ2VucGQgY2FsbGJhY2sgZm9yIHRoZSBTTUkgTEFSQnMgbG9jYXRlZCBpbiBpbWFn
ZSwgY2FtZXJhIGFuZCBJUEUNCj4gPiBzdWJzeXN0ZW1zLCBhbmQgYXBwbHkgcmVzZXQgYW5kIGNs
YW1wIG9wZXJhdGlvbnMgd2l0aGluIHRoZQ0KPiA+IGNhbGxiYWNrLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEZyaWRheSBZYW5nIDxmcmlkYXkueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDEyOQ0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTI5IGluc2Vy
dGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
IGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5kZXggNzMzZTIyZjY5NWFiLi5hY2M4
OTA0ZGQxMTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4g
KysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gQEAgLTEwLDExICsxMCwxNSBAQA0K
PiA+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0K
PiA+ICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQv
c3lzY29uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L29mLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICAj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9w
bV9kb21haW4uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4g
PiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2Yy5oPg0KPiA+ICAjaW5j
bHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbWVt
b3J5L210MjcwMS1sYXJiLXBvcnQuaD4NCj4gPiBAQCAtMzQsNiArMzgsOCBAQA0KPiA+ICAjZGVm
aW5lIFNNSV9GSUZPX1RIMQkJCTB4MjM4DQo+ID4gICNkZWZpbmUgU01JX0ZJRk9fVEgyCQkJMHgy
M2MNCj4gPiAgI2RlZmluZSBTTUlfRENNCQkJCTB4MzAwDQo+ID4gKyNkZWZpbmUgU01JX0NPTU1P
Tl9DTEFNUF9FTl9TRVQJCTB4M2M0DQo+ID4gKyNkZWZpbmUgU01JX0NPTU1PTl9DTEFNUF9FTl9D
TFIJCTB4M2M4DQo+ID4gICNkZWZpbmUgU01JX0RVTU1ZCQkJMHg0NDQNCj4gPiAgDQo+ID4gIC8q
IFNNSSBMQVJCICovDQo+ID4gQEAgLTEzNCw2ICsxNDAsNyBAQCBzdHJ1Y3QgbXRrX3NtaV9sYXJi
X2dlbiB7DQo+ID4gIAl1bnNpZ25lZCBpbnQJCQlsYXJiX2RpcmVjdF90b19jb21tb25fbWFzazsN
Cj4gPiAgCXVuc2lnbmVkIGludAkJCWZsYWdzX2dlbmVyYWw7DQo+ID4gIAljb25zdCB1OAkJCSgq
b3N0ZClbU01JX0xBUkJfUE9SVF9OUl9NQVhdOw0KPiA+ICsJY29uc3QgdTgJCQkqY2xhbXBfcG9y
dDsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBtdGtfc21pIHsNCj4gPiBAQCAtMTUwLDYg
KzE1Nyw3IEBAIHN0cnVjdCBtdGtfc21pIHsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBt
dGtfc21pX2xhcmIgeyAvKiBsYXJiOiBsb2NhbCBhcmJpdGVyICovDQo+ID4gKwlzdHJ1Y3QgZGV2
aWNlCQkJKmRldjsNCj4gPiAgCXN0cnVjdCBtdGtfc21pCQkJc21pOw0KPiA+ICAJdm9pZCBfX2lv
bWVtCQkJKmJhc2U7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlCQkJKnNtaV9jb21tb25fZGV2OyAvKiBj
b21tb24NCj4gPiBvcg0KPiA+IHN1Yi1jb21tb24gZGV2ICovDQo+ID4gQEAgLTE1Nyw2ICsxNjUs
MTAgQEAgc3RydWN0IG10a19zbWlfbGFyYiB7IC8qIGxhcmI6IGxvY2FsIGFyYml0ZXINCj4gPiAq
Lw0KPiA+ICAJaW50CQkJCWxhcmJpZDsNCj4gPiAgCXUzMgkJCQkqbW11Ow0KPiA+ICAJdW5zaWdu
ZWQgY2hhcgkJCSpiYW5rOw0KPiA+ICsJc3RydWN0IHJlZ21hcAkJCSpzbWlfY29tbV9zeXNjb247
IC8qIHNtaS0NCj4gPiBjb21tIA0KPiA+IG9yIHN1Yi1jb21tICovDQo+ID4gKwl1OAkJCQlzbWlf
Y29tbV9pbl9wb3J0X2lkOyAvKiBzbWktDQo+ID4gY29tbSBvciBzdWItY29tbSAqLw0KPiA+ICsJ
c3RydWN0IG5vdGlmaWVyX2Jsb2NrCQluYjsNCj4gPiArCXN0cnVjdCByZXNldF9jb250cm9sCQkq
cnN0X2NvbjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBpbnQNCj4gPiBAQCAtNDc4LDYg
KzQ5MCwxOSBAQCBzdGF0aWMgY29uc3QgdTgNCj4gPiBtdGtfc21pX2xhcmJfbXQ4MTk1X29zdGRb
XVtTTUlfTEFSQl9QT1JUX05SX01BWF0gPSB7DQo+ID4gIAlbMjhdID0gezB4MWEsIDB4MGUsIDB4
MGEsIDB4MGEsIDB4MGMsIDB4MGUsIDB4MTAsfSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gK3N0YXRp
YyBjb25zdCB1OCBtdGtfc21pX2xhcmJfY2xhbXBfcG9ydF9tdDgxODhbTVRLX0xBUkJfTlJfTUFY
XSA9DQo+ID4gew0KPiA+ICsJWzldCT0gQklUKDEpLCAvKiBsYXJiMTAgKi8NCj4gPiArCVsxMF0J
PSBCSVQoMiksIC8qIGxhcmIxMWEgKi8NCj4gPiArCVsxMV0JPSBCSVQoMiksIC8qIGxhcmIxMWIg
Ki8NCj4gPiArCVsxMl0JPSBCSVQoMyksIC8qIGxhcmIxMWMgKi8NCj4gPiArCVsxM10JPSBCSVQo
MCksIC8qIGxhcmIxMiAqLw0KPiA+ICsJWzE2XQk9IEJJVCgxKSwgLyogbGFyYjE1ICovDQo+ID4g
KwlbMTddCT0gQklUKDIpLCAvKiBsYXJiMTZhICovDQo+ID4gKwlbMThdCT0gQklUKDIpLCAvKiBs
YXJiMTZiICovDQo+ID4gKwlbMTldCT0gQklUKDMpLCAvKiBsYXJiMTdhICovDQo+ID4gKwlbMjBd
CT0gQklUKDMpLCAvKiBsYXJiMTdiICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gbXRrX3NtaV9sYXJiX210MjcwMSA9IHsNCj4gPiAg
CS5wb3J0X2luX2xhcmIgPSB7DQo+ID4gIAkJTEFSQjBfUE9SVF9PRkZTRVQsIExBUkIxX1BPUlRf
T0ZGU0VULA0KPiA+IEBAIC01MzEsNiArNTU2LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
c21pX2xhcmJfZ2VuDQo+ID4gbXRrX3NtaV9sYXJiX210ODE4OCA9IHsNCj4gPiAgCS5mbGFnc19n
ZW5lcmFsCSAgICAgICAgICAgID0gTVRLX1NNSV9GTEFHX1RIUlRfVVBEQVRFIHwNCj4gPiBNVEtf
U01JX0ZMQUdfU1dfRkxBRyB8DQo+ID4gIAkJCQkgICAgICBNVEtfU01JX0ZMQUdfU0xFRVBfQ1RM
IHwNCj4gPiBNVEtfU01JX0ZMQUdfQ0ZHX1BPUlRfU0VDX0NUTCwNCj4gPiAgCS5vc3RkCQkgICAg
ICAgICAgICA9IG10a19zbWlfbGFyYl9tdDgxODhfb3N0ZCwNCj4gPiArCS5jbGFtcF9wb3J0ICAg
ICAgICAgICAgICAgICA9IG10a19zbWlfbGFyYl9jbGFtcF9wb3J0X210ODE4OCwNCj4gPiAgfTsN
Cj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiBtdGtfc21p
X2xhcmJfbXQ4MTkyID0gew0KPiA+IEBAIC01ODIsNiArNjA4LDQ1IEBAIHN0YXRpYyB2b2lkDQo+
ID4gbXRrX3NtaV9sYXJiX3NsZWVwX2N0cmxfZGlzYWJsZShzdHJ1Y3QgbXRrX3NtaV9sYXJiICps
YXJiKQ0KPiA+ICAJd3JpdGVsX3JlbGF4ZWQoMCwgbGFyYi0+YmFzZSArIFNNSV9MQVJCX1NMUF9D
T04pOw0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9jbGFtcF9w
cm90ZWN0X2VuYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gYm9vbCBlbmFibGUpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiArCXUzMiByZWc7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qIHNtaV9j
b21tX3N5c2NvbiBtYXkgYmUgTlVMTCBpZiB0aGUgc3Vic3lzIGRvZXNuJ3QgaGF2ZSBidXMNCj4g
PiBnbGl0Y2ggaXNzdWVzICovDQo+ID4gKwlpZiAoIWxhcmItPnNtaV9jb21tX3N5c2NvbikNCj4g
PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlyZWcgPSBlbmFibGUgPyBTTUlfQ09N
TU9OX0NMQU1QX0VOX1NFVCA6DQo+ID4gU01JX0NPTU1PTl9DTEFNUF9FTl9DTFI7DQo+ID4gKw0K
PiA+ICsJcmV0ID0gcmVnbWFwX3dyaXRlKGxhcmItPnNtaV9jb21tX3N5c2NvbiwgcmVnLCBsYXJi
LQ0KPiA+ID4gc21pX2NvbW1faW5fcG9ydF9pZCk7DQo+ID4gDQo+ID4gKwlpZiAocmV0KQ0KPiA+
ICsJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvICVzIGNsYW1wIGZvciBpbnB1dCBwb3J0ICVkOg0K
PiA+ICVkXG4iLA0KPiA+ICsJCQllbmFibGUgPyAiZW5hYmxlIiA6ICJkaXNhYmxlIiwNCj4gPiAr
CQkJbGFyYi0+c21pX2NvbW1faW5fcG9ydF9pZCwgcmV0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
cmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfZ2VucGRfY2FsbGJh
Y2soc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiArCQkJCSAgdW5zaWduZWQgbG9uZyBm
bGFncywgdm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsJc3RydWN0IG10a19zbWlfbGFyYiAqbGFy
YiA9IGNvbnRhaW5lcl9vZihuYiwgc3RydWN0DQo+ID4gbXRrX3NtaV9sYXJiLCBuYik7DQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBsYXJiLT5kZXY7DQo+ID4gKw0KPiA+ICsJaWYgKGZsYWdz
ID09IEdFTlBEX05PVElGWV9QUkVfT04gfHwgZmxhZ3MgPT0NCj4gPiBHRU5QRF9OT1RJRllfUFJF
X09GRikgew0KPiA+ICsJCS8qIGRpc2FibGUgcmVsYXRlZCBTTUkgc3ViLWNvbW1vbiBwb3J0ICov
DQo+ID4gKwkJbXRrX3NtaV9sYXJiX2NsYW1wX3Byb3RlY3RfZW5hYmxlKGRldiwgdHJ1ZSk7DQo+
ID4gKwl9IGVsc2UgaWYgKGZsYWdzID09IEdFTlBEX05PVElGWV9PTikgew0KPiA+ICsJCS8qIGVu
YWJsZSByZWxhdGVkIFNNSSBzdWItY29tbW9uIHBvcnQgKi8NCj4gPiArCQlyZXNldF9jb250cm9s
X3Jlc2V0KGxhcmItPnJzdF9jb24pOw0KPiA+ICsJCW10a19zbWlfbGFyYl9jbGFtcF9wcm90ZWN0
X2VuYWJsZShkZXYsIGZhbHNlKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gTk9USUZZ
X09LOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IG10a19zbWlfZGV2aWNlX2xpbmtf
Y29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4gZGV2aWNlICoqY29tX2RldikN
Cj4gPiAgew0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqc21pX2NvbV9wZGV2Ow0KPiA+
IEBAIC02MzgsNiArNzAzLDUxIEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9kdHNfY2xrX2luaXQoc3Ry
dWN0IGRldmljZQ0KPiA+ICpkZXYsIHN0cnVjdCBtdGtfc21pICpzbWksDQo+ID4gIAlyZXR1cm4g
cmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9j
bGFtcF9vcHRpb25hbChzdHJ1Y3QgbXRrX3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiArCWNvbnN0IHN0cnVjdCBt
dGtfc21pX2xhcmJfZ2VuICpsYXJiX2dlbiA9IGxhcmItPmxhcmJfZ2VuOw0KPiA+ICsJdTMyIGxh
cmJfaWQ7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBPbmx5IFNN
SSBMQVJCcyBpbiBjYW1lcmEsIGltYWdlIGFuZCBJUEUgc3Vic3lzIG5lZWQgdG8NCj4gPiArCSAq
IGFwcGx5IGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25zLCBvdGhlcnMgY2FuIGJlIHNraXBwZWQu
DQo+ID4gKwkgKi8NCj4gPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9k
ZSwgIm1lZGlhdGVrLGxhcmItaWQiLA0KPiA+ICZsYXJiX2lkKTsNCj4gPiArCWlmIChyZXQgfHwg
IWxhcmJfZ2VuLT5jbGFtcF9wb3J0IHx8ICFsYXJiX2dlbi0NCj4gPiA+IGNsYW1wX3BvcnRbbGFy
Yl9pZF0pDQo+ID4gDQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICsJbGFyYi0+c21pX2Nv
bW1faW5fcG9ydF9pZCA9IGxhcmJfZ2VuLT5jbGFtcF9wb3J0W2xhcmJfaWRdOw0KPiA+ICsJbGFy
Yi0+c21pX2NvbW1fc3lzY29uID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfcGhhbmRsZShkZXYt
DQo+ID4gPiBvZl9ub2RlLA0KPiA+IA0KPiA+ICsJCQkJCQkJCSJtZWRpYXQNCj4gPiBlayxzbWki
KTsNCj4gPiArCWlmIChJU19FUlIobGFyYi0+c21pX2NvbW1fc3lzY29uKSkgew0KPiA+ICsJCWxh
cmItPnNtaV9jb21tX3N5c2NvbiA9IE5VTEw7DQo+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCAtRUlOVkFMLA0KPiA+ICsJCQkJICAgICAiVW5rbm93biBjbGFtcCBwb3J0IGZvciBsYXJi
DQo+ID4gJWRcbiIsIGxhcmJfaWQpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9v
cHRpb25hbChzdHJ1Y3QgbXRrX3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sNCj4gPiArCXN0
cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+
ICsJbGFyYi0+cnN0X2NvbiA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVz
aXZlKGRldiwNCj4gPiAibGFyYiIpOw0KPiA+ICsJaWYgKCFsYXJiLT5yc3RfY29uKQ0KPiA+ICsJ
CXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWxhcmItPm5iLm5vdGlmaWVyX2NhbGwgPSBtdGtfc21p
X2dlbnBkX2NhbGxiYWNrOw0KPiA+ICsJcmV0ID0gZGV2X3BtX2dlbnBkX2FkZF9ub3RpZmllcihk
ZXYsICZsYXJiLT5uYik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiBkZXZfZXJyX3By
b2JlKGRldiwgLUVJTlZBTCwNCj4gPiArCQkJCSAgICAgIkZhaWxlZCB0byBhZGQgZ2VucGQgY2Fs
bGJhY2sNCj4gPiAlZFxuIiwgcmV0KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiAgc3RhdGljIGludCBtdGtfc21pX2xhcmJfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYjsN
Cj4gPiBAQCAtNjQ4LDYgKzc1OCw3IEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3Byb2JlKHN0
cnVjdA0KPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCWlmICghbGFyYikNCj4gPiAg
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgDQo+ID4gKwlsYXJiLT5kZXYgPSBkZXY7DQo+ID4gIAls
YXJiLT5sYXJiX2dlbiA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ICAJbGFy
Yi0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAg
CWlmIChJU19FUlIobGFyYi0+YmFzZSkpDQo+ID4gQEAgLTY2NCw2ICs3NzUsMTQgQEAgc3RhdGlj
IGludCBtdGtfc21pX2xhcmJfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAJaWYgKHJldCA8IDApDQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgDQo+ID4gKwly
ZXQgPSBtdGtfc21pX2xhcmJfcGFyc2VfY2xhbXBfb3B0aW9uYWwobGFyYik7DQo+ID4gKwlpZiAo
cmV0KQ0KPiA+ICsJCWdvdG8gZXJyX2xpbmtfcmVtb3ZlOw0KPiA+ICsNCj4gPiArCXJldCA9IG10
a19zbWlfbGFyYl9wYXJzZV9yZXNldF9vcHRpb25hbChsYXJiKTsNCj4gPiArCWlmIChyZXQpDQo+
ID4gKwkJZ290byBlcnJfbGlua19yZW1vdmU7DQo+IA0KPiANCj4gSWYgd2UgaGF2ZSAibGFyYl9n
ZW4tPmNsYW1wX3BvcnRbbGFyYl9pZF0iLCB3ZSBtdXN0IGhhdmUgdGhlIHJlc2V0DQo+IGZ1bmN0
aW9uLCBpcyB0aGlzIHJpZ2h0PyBpZiB5ZXMsDQo+IA0KPiBpZiAobGFyYi0+c21pX2NvbW1fc3lz
Y29uICYmIGxhcmJfZ2VuLT5jbGFtcF9wb3J0W2xhcmJfaWRdKSB7DQo+ICAgIHJldCA9IG10a19z
bWlfbGFyYl9wYXJzZV9yZXNldChsYXJiKTsgIC8vIE5vdCBvcHRpb25hbC4NCj4gfQ0KPiANCj4g
YW5kIHRoZW4gd2UgY291bGQgcmVtb3ZlIHRoZSBjaGVja2luZyBvZiBsYXJiLT5zbWlfY29tbV9z
eXNjb24gaW4gDQo+IG10a19zbWlfbGFyYl9jbGFtcF9wcm90ZWN0X2VuYWJsZSwgaXQgd2lsbCBi
ZSBzaW1wbGVyLg0KPiANCj4gVGhhbmtzLg0KPiANCg0KVGhhbmtzIGZvciBjb21tZW50cy4NCllv
dSBhcmUgcmlnaHQuIFdlIGNhbiBmaXggaXQgbGlrZSB0aGlzLiBKdXN0IGRldGVybWluZSB3aGV0
aGVyDQpjbGFtcCBhbmQgcmVzZXQgYXJlIHJlcXVpcmVkIGluICdtdGtfc21pX2xhcmJfcHJvYmUn
LiBJZiB3ZQ0KaGF2ZSAibGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYl9pZF0iLCB0aGVuIGNsYW1w
IGFuZCByZXNldCBvcGVyYXRpb25zDQphcmUgcmVxdWlyZWQuIEFuZCB0aGUgJ19vcHRpb25hbCcg
c3VmZml4IHNob3VsZCBiZSByZW1vdmVkIGZyb20gdGhlDQpmdW5jdGlvbiBuYW1lIGluIHRoaXMg
Y2FzZS4NCg0KaW4gbXRrX3NtaV9sYXJiX3Byb2JlOg0KLi4uDQppZiAobGFyYi0+bGFyYl9nZW4t
PmNsYW1wX3BvcnQgJiYgbGFyYi0+bGFyYl9nZW4tPmNsYW1wX3BvcnRbbGFyYi0NCj5sYXJiaWRd
KSB7DQoJCXJldCA9IG10a19zbWlfbGFyYl9wYXJzZV9jbGFtcChsYXJiLCBsYXJiLT5sYXJiaWQp
Ow0KCQlpZiAocmV0KQ0KCQkJZ290byBlcnJfbGlua19yZW1vdmU7DQoNCgkJcmV0ID0gbXRrX3Nt
aV9sYXJiX3BhcnNlX3Jlc2V0KGxhcmIpOw0KCQlpZiAocmV0KQ0KCQkJZ290byBlcnJfbGlua19y
ZW1vdmU7DQoJfQ0KLi4uDQoNCg==

