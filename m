Return-Path: <linux-kernel+bounces-750066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A401B156EC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F405605CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312217DFE7;
	Wed, 30 Jul 2025 01:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ym7gcuRM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="baNixI3Z"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497861361
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753837958; cv=fail; b=L5G7X+EtiK/XuLDhIl03/IMOZkYBicQC8Sw/YMj6ELgLEzl2gaMrvUf16LqCDpbDnbHauqw2eHPiMtRYkcRGRaJ97V3AcwMcqj+9jPluJp42IX9JVhUHlmfyxgnPTRx+lOYlxvoU/45ooeUE5eHHljNY0osFCB+DtXvz9lKrXlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753837958; c=relaxed/simple;
	bh=Vl7gc+ku9p5qTmRSYcgItthxPHpn2HVOlPkfmLAViHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lbnlg4D9XoXWZFvKuMXLAuMfR3gISHRO5KJuMoozJZaqjSGzqxGS/7QX846bm9n/8tADIaXwu5/MHoDCqBPK2Ju59kjeC3CgpCAgwNmDrzZcSqX736gJuPiwv3hX0I2Nzds6iolVC0lPg0UPxD2Hbq9gz/QQiQtcMC+VpAXeSYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Ym7gcuRM; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=baNixI3Z; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 43d49c8c6ce211f08b7dc59d57013e23-20250730
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Vl7gc+ku9p5qTmRSYcgItthxPHpn2HVOlPkfmLAViHs=;
	b=Ym7gcuRM6wHuJrgR0IDNRhoBE+Se7S2OYjksAf/re2p2R+FOT6TaoJWcjD6OqYwoNEAwBjBvOQUQblcsalw3c49pXUt32VpM54jj76rbRMO37E6PzfIb8FzHwN3BXhdbUygl6xOmGHmgTQZm7n8IZ0QPF2sekxhpqVzcv02wX1g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:92f50707-88dc-4bc0-af14-914796465567,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:5b7b679a-32fc-44a3-90ac-aa371853f23f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 43d49c8c6ce211f08b7dc59d57013e23-20250730
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 137792974; Wed, 30 Jul 2025 09:12:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 30 Jul 2025 09:12:29 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 30 Jul 2025 09:12:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeYthVeqO6lHUmZetqp4o4Anox3aUjjvVEQjnL9PEB4ELIzosHnv9gFj06cA9kRhWZmonNU8fPEbFPaGN1krGLBVFYWK45UO+nKOhwA2QW3tefXfroQpFaflAepPME7dg0OcRkvm6eiJcRgsWnU92Ju5VwrqrTPtA/744Kq7sKOWN0ICb9FhdsQWegbl4TxiVewYQLekxsKnzFTFLQSEyyC+ERI5I1zA9/gNAvqjZ3zU7vgVHlpqtTlRS4+JJOLA9NBW0qCLBSSOEHDNhc94CW06Oc/1LK4o0crqbODUKTX2AYY4ozAIfnG+X7bLWs1VsvdCYZubmDO4eQ5Baq4k7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl7gc+ku9p5qTmRSYcgItthxPHpn2HVOlPkfmLAViHs=;
 b=a0rkB6RBVUIyLKxu9OxAtZfT7N+i1TQ+DalAVRPcwX/ZZk6hyoHw0clxVEURSk3nuzdNhLx2L8gnETkIQ9PGmpy9aQ5obJ/i1j3u9xxw8gFsXOjIdd7zGScWN4OCAzCxbQ/JYaQ9H3UwfHhFetTFAehT8+kNRhIbN3bGM2YAfgf7HB5F1g/cFSfV8NlgpRBNWUm3XrNmnxX8PUY5eVaIp29HkgxJxEvQZkNbvTpcwfjome2UbYNreUNacNhnQOGOadOBzASsFyvkRZ8vf8qoUC0GrrTTNgLW44jY7Cj631jCsHMwgvUPeQQJAZf1ORKrbtWWohyYcprQgpbTxOEMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl7gc+ku9p5qTmRSYcgItthxPHpn2HVOlPkfmLAViHs=;
 b=baNixI3ZSMsIhtTpMo2NXrZ+MGmv4oq9xWtGse7U+g79d9Ew4K9pi3Tm9PRlkMVeKmO+9vgdP9wpkR0R4JVQRzSeMOB1iXCmLp0N/ATzXqo1WMcoDNjdBXiaoSzPEV+IEgT8Wdnpjz0bn5IJ3/zqfFT3YR21amLVdB94XedbzM4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7553.apcprd03.prod.outlook.com (2603:1096:400:421::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 01:12:24 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 01:12:24 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>
CC: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, =?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?=
	<Sirius.Wang@mediatek.com>, =?utf-8?B?WmhlbnhpbmcgUWluICjnp6bmjK/lhbQp?=
	<Zhenxing.Qin@mediatek.com>, =?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"wenst@chromium.org" <wenst@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SmFycmllZCBMaW4gKOael+ijleWTsik=?= <Jarried.Lin@mediatek.com>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [RESEND PATCH] drm/mediatek: Add error handling for old state
 CRTC in atomic_disable
Thread-Topic: [RESEND PATCH] drm/mediatek: Add error handling for old state
 CRTC in atomic_disable
Thread-Index: AQHb/2w8NCFlo7IZx0mFVuT0QEJuy7RJ3ymA
Date: Wed, 30 Jul 2025 01:12:24 +0000
Message-ID: <65341bbc00d268b27a725110d971f0fd925a5cc9.camel@mediatek.com>
References: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20250728025036.24953-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7553:EE_
x-ms-office365-filtering-correlation-id: 409bea38-6ef0-400d-6824-08ddcf062466
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|42112799006|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkRtSkg0NmpVekVKZWVuN1Q3K1NjZmt6a1ozdDFWWHNpazNDOGVzZ1pkeStK?=
 =?utf-8?B?TWI0cnBRdFVDVURoOW8rbVYzMTVwY0FZSzMvY1FXM1M1UjNkZERjK05uVzc3?=
 =?utf-8?B?MWUxZVlaTFVTS293c2Y3S1JNbWdkR0NVUUxZblVmbmN0amRId3BoOVZWZ2Jh?=
 =?utf-8?B?YW1vbTJhVTFOZG5LUngrbUxXMFdWUlBIeUVxdkt5bWEyTHNlMUZHTk1FSW5m?=
 =?utf-8?B?bWVzalZFNmtFUE9MWFlDcGN6UFZ5QXBZZ3R3cWUyVzNJVlg2ZXVrWFUyeG1k?=
 =?utf-8?B?R3BtVVdBZFdGRE1hU3NrWlpHVUJldE14V2g5Nk5lWnhTdTk0QStnd25FN3l6?=
 =?utf-8?B?eEo2ZUp2ZDdaaGxyVE1xRmxlOWgrTzNZUDVBSVdOdDZSUmxYU3ZmWmtQQVpJ?=
 =?utf-8?B?cE1aVGtwNG1GRlV5dnpRMTdYTkNzUkkvcXE3QUpUeHNVQXN4Sm1oc3ozT3gw?=
 =?utf-8?B?Q3ZyckhpNk4rTWQrUUdJT2pYclJyNUxRRmN0RGdVellYbmdEcDVIREtULzh5?=
 =?utf-8?B?UktIeHpKWWhEL1IzTVF2SlMzTjVPWGFDME91RjFYK3JRb0dIbllwSnliNUlk?=
 =?utf-8?B?K3dyY0JmbXFzWHFjeDN3a1VyNU5kemJ1eUJQSGJPR1RuN1RuTzYzK1hiU2hm?=
 =?utf-8?B?RjU5SU1QeWFlU1NLOUkvd2VoVDM4eXFyR1lyVTk4MGJqbTBHS1hjWElRNmky?=
 =?utf-8?B?VnA2UGd0b1RBUmZkVERXVjZhcmNnTlhYYjM5Y2dhNkFEYXJYVVNuQTRZMHdR?=
 =?utf-8?B?UUtYZzlsUVpFRnFRSUVSR2NNQlordHBKaGtJbGlOZjArcjJWYUZzRFFBT1BI?=
 =?utf-8?B?U1hqdEl0V0tHakprY3RKenk0YVJTUUV6MEdGaGswMGJUcXZFQUV4NW4wNXY3?=
 =?utf-8?B?S1M0L2ZmaERsTzg2bkwxUmIzVFJLcTVWYi8xVjRtUHZONjhDNXZ2V2llQ0Ny?=
 =?utf-8?B?ekttQ1kzbEcyS3h6SGJYUGlRM3hxWTM5MHJCVDhuWWVkZzNVTURtZklacmhV?=
 =?utf-8?B?ZlEweWdYeW9BL0QzSVJJdVNBQURjb2hmT0RYYUZadGxaeUR3VU9lK3lzbktr?=
 =?utf-8?B?aHZGT0x4Yk1lRXlndU9EeUJvUkNPZ0x0dlFjb2svbkc0dkl1UlA4Z3VHM1pQ?=
 =?utf-8?B?S2VqQlBld29DNUtQN0ZETjJaT0x5ZFp5YVkrMVRPMmk2OVhrdE1TNzNkOXZs?=
 =?utf-8?B?UXgvOFlnRm9EQlcvUWhrKzFFRjNmOTlBTEkrQ21vSGhIUUdvSWdiK2krd1hh?=
 =?utf-8?B?dWJYdVdLYVBXZXBPVlRsZDJWc0UwZmxZbGV3Q0NCeElaK3ZqMVJKY2d0MDBj?=
 =?utf-8?B?TDVReHJ2N1VnNkc5cTlMcHJOQ21tcHpJeUR4TExxaUN1Q3FCRnQ1a3oxUkN5?=
 =?utf-8?B?ZVFvb21ybTRHbGY4WWxDWkNISnNZWUxudUZVcGphK0t6Vk5CYnRjMnl0RXdh?=
 =?utf-8?B?SEw4RjFkdlJmNGtqOXJvM2hEV1JYN1pKa0o0R3paRlNMMWR4YnJFT2FvM3NS?=
 =?utf-8?B?VUFBM3JhMUZLSGlMUVcxYTlaUDc3MnI2RWVZVVB6QS9NQ0FyWlYzWjJDckZv?=
 =?utf-8?B?RUhVQWdqb2JoVHpnUWJtLzlXelRuc2piMFQ5ODlIN0JpVlhVMmVON0wyV0R3?=
 =?utf-8?B?TE1zdDNmUGowSm14ZGtEUEhnOHlWRFZrRERqalpJUWhINzk2RC90d3Fickp6?=
 =?utf-8?B?SDU0bkluaW1ZQVYwTnI2ZHlZWG0zdE0xM0V4YW5rZnYrQUJIdDRQT0c2bTJV?=
 =?utf-8?B?YmFjNnU3akJEblRmUnFBeEhVN256ZEhKbWxNWThyeVdXbzloeDV5WFhBUEVS?=
 =?utf-8?B?UUpYbW11ZzBrRWhONjNKTjNZT25RYTdDaFFZMG9TcXF4RlBQWWJNYlR0TFoy?=
 =?utf-8?B?ZDFkSWc0bWgzSkpmYnpUeGpaanQwbVdFQThKSkRUQVZyUWhuZUtjTTMycEZX?=
 =?utf-8?B?UE9XdzhJNTI2YjN2WUM0R3U2T2lySXhDUUlITGI4dGl6VkhITEdkSXlSRnpp?=
 =?utf-8?B?UTVHN3VYQlRRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(42112799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0hxRW10Z3FHTkY4Z0kxaHBiMHVpNFp0dkozQXgvMTZTYWZ3dWhPTlpIb2x5?=
 =?utf-8?B?cUh5bHJmcnpacE92SWVpeGF3bzBpSDJMTDhTbWt0dmUrNU1mYXlLbmNmTDJI?=
 =?utf-8?B?NGpPZjB6ODVOMkxvUG9xT0dobFBYT1R2L2p0TzlwNlVXcjMxbFhQS2wzZmlS?=
 =?utf-8?B?Y3BHMzRIcmppTlMwbEJ2bWdaT015c2NkWlJ5RWtTMTNsU0MwYjl3OVVuaVBo?=
 =?utf-8?B?bU9NMzZEeU1SdXdNRjJsQlBQdW1qMlgrYzByM2o2ZzdLNWQ3bHBJT1RHdWpM?=
 =?utf-8?B?ak41dmZFZnpHK05wSHYyRGVMbjB4UUw2Y2JEMmRBSm1VREV0M0syWjQ5MWo5?=
 =?utf-8?B?Tmt6MXV6TTNxTUdHNk5OQUcvQU5ZcGEyajRXR2NwT1ZBS1psUlhxQVM0dkdY?=
 =?utf-8?B?UE9FaDIzbnVRdnVENXBwcURta3dqSFZSSXUvVURoakRCZlhQdDNwbnR4V0JX?=
 =?utf-8?B?ZjlobVVldkRHVURKMzNGR3dRWE9vSFA0OUUzSVBxaktzWVBoNFRzbzZqbExy?=
 =?utf-8?B?bHROc01uK2J6c3Q0c2hRWTJMR2x2SFUwRFhRS1R2OFlSYkFoY2R3V25NZUF6?=
 =?utf-8?B?UmxleTNYQXIxaXUxRVJOd2Fhcnc0T2xld2pYbnJtL2I4TTZnd0xtckxYTzh3?=
 =?utf-8?B?b3dQSVM0NEswWUM5dm1ybWIwK21VMXprTzRiU3puYnRWbG51bHJkRGcxeWhw?=
 =?utf-8?B?VGlCTUNobkx6Q2w5dkoxQXpHMmdFN3RJVmF4cUFWb1FSbVhKRHg5TFZzWkNM?=
 =?utf-8?B?RXUzTlRqZGdMWTE4bkN0VEk4cmlxOWRPS3BYZThyWGM1NW50NG1HVy9zc2Za?=
 =?utf-8?B?YmQrWEJkZHkySG1LYVlNOVpQMUpZeWJSK3FjaG8rWjg5SXJmQ0ZXTldrdVR4?=
 =?utf-8?B?ZDFaS294b0lMR2d1L1FDSzdJVjc3L0dPNTBrUnBYWEtXZXRjeFF3ZVZqcDZY?=
 =?utf-8?B?L0pwdmlRUkFLaWtXeW5kZ25LdHZRZEtoZTNQYXRYMHI1Tm5neVhUK2xybkkx?=
 =?utf-8?B?ZmNVNnRCNzg0UkpzRWhaL3M2UlpmeVFGMmRyamxsR0Q2b1BKVCthSWYrOVpv?=
 =?utf-8?B?M2g2MXB3NUxJZExMYUp1NklWT1krNWFvMDZGRnJ5M0FpeWxCTE80Vm1lOElZ?=
 =?utf-8?B?VjhZQzRPV0ZVYXNqcWxJMGVaSWx6WG9kN1JFYkJIbVNYREk3RS92NDN1TUVR?=
 =?utf-8?B?OG83YjlUVEdFRzNaV1k1TTRva2xzemk3ZG1UK1dZZUxRK1E3RzljemtEOW1s?=
 =?utf-8?B?THQvLzl4WmFkWmZnTVIwZy9WdWN2cGdHV2JlOHdONHBlajI4NWk3VlV1OFBv?=
 =?utf-8?B?Y1hMOXJPd0tPWTlqa0xxc0ExNE5Ld0lBb0VDNkgwejZ3WllGWXNJbUp6aEVT?=
 =?utf-8?B?K1lDMXFSSUVXQWx3UnVLekp0Z1hGTUlocUplaFdnU0JnaGlqb3U4MEQzVDNX?=
 =?utf-8?B?b1hlQTIyQlVpb3RwNnBab2FZQ3AwUmVPVi91bHI3MUp6cG9pSU16Nms0UkFW?=
 =?utf-8?B?WE5XY09QUFVHNVVIWlkreUVKd296QjdOdDhNUGlvQjcrM3lJTE5xeWE4aEcx?=
 =?utf-8?B?QTUvcWF5enJxcjhRbHRjRVNLMkRPVG4reE90OTRlSmRQenZSSjNZN3dNSEow?=
 =?utf-8?B?TU5XM0dzMm1zM1dmaXJtT21SVHVQdXN2aktvdnFMNkNiQXpsd29BRkZxSzAv?=
 =?utf-8?B?UHlsRnV3Si8wMmY5ZFNPcEkxc055Q2hsK2JXOG1SVGxhTDlpbkk1SWZHaXN4?=
 =?utf-8?B?SWZwMEtuVzUyVmVxeGJRS28zRDVGNlV2SVZwZk1jbVZGcmNhUVdKVU1tU2Vm?=
 =?utf-8?B?TTJSV3R3bk1rNUdmQ1NQYVUxN2hzS1ZpOGpRakZXMUNEOUkweVVBNW1NeGcz?=
 =?utf-8?B?NHkwVUJ3cmQzTk5oY1NlVFN4Wm1tQWFxNWlRRXcyMGlTck9TV0M4cjJsbHVH?=
 =?utf-8?B?NWh4THdWbVIwdW53VXhoelJ3WXRiZjNNVjhXeHVqODBUejFsbTBwa3VieDdu?=
 =?utf-8?B?L2xsWDhOUUxEcmIwWFpWZVl2ek9XTHlISVpKZHBWTmtCUWY1VnpQRFBlcEVQ?=
 =?utf-8?B?NkNSMXl3N1lzajJJQUdpbmxRMFZUN2QxT2t2QVU4Z000TXpTSG9US244eEs1?=
 =?utf-8?Q?kqrpkNFmbX+fMG3JcCYYFBKSE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3AC85A5BC1A4C4DB7159DE99DB65BDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409bea38-6ef0-400d-6824-08ddcf062466
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 01:12:24.3423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWMhGL0kc9OTbWHQ+UP2s7JFrUwHQAgzXQnHQiX4wLoRDYJMa4QJcctE+CqO3+LJUY9dknZ7MSrWzL8omRVdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7553

T24gTW9uLCAyMDI1LTA3LTI4IGF0IDEwOjQ4ICswODAwLCBKYXNvbi1KSCBMaW4gd3JvdGU6DQo+
IEludHJvZHVjZSBlcnJvciBoYW5kbGluZyB0byBhZGRyZXNzIGFuIGlzc3VlIHdoZXJlLCBhZnRl
ciBhIGhvdHBsdWcNCj4gZXZlbnQsIHRoZSBjdXJzb3IgY29udGludWVzIHRvIHVwZGF0ZS4gVGhp
cyBzaXR1YXRpb24gY2FuIGxlYWQgdG8gYQ0KPiBrZXJuZWwgcGFuaWMgZHVlIHRvIGFjY2Vzc2lu
ZyB0aGUgTlVMTCBgb2xkX3N0YXRlLT5jcnRjYC4NCj4gDQo+IEUsZy4NCj4gVW5hYmxlIHRvIGhh
bmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcw0K
PiBDYWxsIHRyYWNlOg0KPiAgbXRrX2NydGNfcGxhbmVfZGlzYWJsZSsweDI0LzB4MTQwDQo+ICBt
dGtfcGxhbmVfYXRvbWljX3VwZGF0ZSsweDhjLzB4YTgNCj4gIGRybV9hdG9taWNfaGVscGVyX2Nv
bW1pdF9wbGFuZXMrMHgxMTQvMHgyYzgNCj4gIGRybV9hdG9taWNfaGVscGVyX2NvbW1pdF90YWls
X3JwbSsweDRjLzB4MTU4DQo+ICBjb21taXRfdGFpbCsweGEwLzB4MTY4DQo+ICBkcm1fYXRvbWlj
X2hlbHBlcl9jb21taXQrMHgxMTAvMHgxMjANCj4gIGRybV9hdG9taWNfY29tbWl0KzB4OGMvMHhl
MA0KPiAgZHJtX2F0b21pY19oZWxwZXJfdXBkYXRlX3BsYW5lKzB4ZDQvMHgxMjgNCj4gIF9fc2V0
cGxhbmVfYXRvbWljKzB4Y2MvMHgxMTANCj4gIGRybV9tb2RlX2N1cnNvcl9jb21tb24rMHgyNTAv
MHg0NDANCj4gIGRybV9tb2RlX2N1cnNvcl9pb2N0bCsweDQ0LzB4NzANCj4gIGRybV9pb2N0bCsw
eDI2NC8weDVkOA0KPiAgX19hcm02NF9zeXNfaW9jdGwrMHhkOC8weDUxMA0KPiAgaW52b2tlX3N5
c2NhbGwrMHg2Yy8weGUwDQo+ICBkb19lbDBfc3ZjKzB4NjgvMHhlOA0KPiAgZWwwX3N2YysweDM0
LzB4NjANCj4gIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4MWMvMHhmOA0KPiAgZWwwdF82NF9zeW5j
KzB4MTgwLzB4MTg4DQo+IA0KPiBBZGRpbmcgTlVMTCBwb2ludGVyIGNoZWNrcyB0byBlbnN1cmUg
c3RhYmlsaXR5IGJ5IHByZXZlbnRpbmcgb3BlcmF0aW9ucw0KPiBvbiBhbiBpbnZhbGlkIENSVEMg
c3RhdGUuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0K
PiBGaXhlczogZDIwODI2MWU5ZjdjICgiZHJtL21lZGlhdGVrOiBBZGQgd2FpdF9ldmVudF90aW1l
b3V0IHdoZW4gZGlzYWJsaW5nIHBsYW5lIikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkggTGlu
IDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gUkVTRU5EIGNoYW5nZToNCj4g
LSBVcGRhdGUgYXV0aG9yIGFuZCBTaWduZWQtb2ZmLWJ5IG5hbWUuDQo+IC0tLQ0KPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jIHwgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX3BsYW5lLmMNCj4gaW5kZXggY2JjNGYzN2RhOGJhLi4wMjM0OWJkNDQwMDEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMNCj4gQEAgLTI5Miw3ICsyOTIsOCBA
QCBzdGF0aWMgdm9pZCBtdGtfcGxhbmVfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9wbGFuZSAq
cGxhbmUsDQo+ICAJd21iKCk7IC8qIE1ha2Ugc3VyZSB0aGUgYWJvdmUgcGFyYW1ldGVyIGlzIHNl
dCBiZWZvcmUgdXBkYXRlICovDQo+ICAJbXRrX3BsYW5lX3N0YXRlLT5wZW5kaW5nLmRpcnR5ID0g
dHJ1ZTsNCj4gIA0KPiAtCW10a19jcnRjX3BsYW5lX2Rpc2FibGUob2xkX3N0YXRlLT5jcnRjLCBw
bGFuZSk7DQo+ICsJaWYgKG9sZF9zdGF0ZSAmJiBvbGRfc3RhdGUtPmNydGMpDQo+ICsJCW10a19j
cnRjX3BsYW5lX2Rpc2FibGUob2xkX3N0YXRlLT5jcnRjLCBwbGFuZSk7DQo+ICB9DQo+ICANCj4g
IHN0YXRpYyB2b2lkIG10a19wbGFuZV9hdG9taWNfdXBkYXRlKHN0cnVjdCBkcm1fcGxhbmUgKnBs
YW5lLA0KDQo=

