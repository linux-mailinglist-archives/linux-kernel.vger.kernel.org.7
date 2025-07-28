Return-Path: <linux-kernel+bounces-747555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5DB1351D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 027923B8B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC442222C3;
	Mon, 28 Jul 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZiTitjJR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RQLWbzuk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AC2C18A;
	Mon, 28 Jul 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753685572; cv=fail; b=D59ZSj+Ccodh7ru4xRxLDQ/gXIAkNia2Iwb+vaNrEWBT2GbxARIFegBKjcBz1BqWU38XjyNOvbYNrRAI+blNS+W89DxVqsGO8+7vUXehZhy2lBk0j53oZ6pwn4gRaCd98W69mRGDS5hKLag30Uh20/GL1/VBoAQi0e1RBRftN+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753685572; c=relaxed/simple;
	bh=plDj9eClc5cr/goyDmZ6OIHIR0G9gwYpbb9YOkPQ7cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y12LLLxvY+beqBp6LfvMip+8p6W7IHI5LPuSHZ/IMIFgtW/3z0TcfrStsEzXbVAbu8BAxUcL8adSDYMzj29VLK0dv3qKgywXi6rLvIPcLdH9XpIKCoOT78okI7tqZLwTWhSR68NFkXzW4M+ei7rmEx2uemuMIsUDacMJLRYCyZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZiTitjJR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RQLWbzuk; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 76903b0e6b7f11f0b33aeb1e7f16c2b6-20250728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=plDj9eClc5cr/goyDmZ6OIHIR0G9gwYpbb9YOkPQ7cY=;
	b=ZiTitjJRfIKrniWmGInjlluqBtHLgvj1uuro9G4ccDrd9RZHIsK1GlBNX11l5q27n3//k4+EpOSgt0qga0I1gMzejYFQPmGlFWibo4t8YGsAvtTcpH0uRFHJe68HfeEPosL636t4fFJw4mEvNGufLgQ++i0kkyArtUxSfUyvOv4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:5648ff23-8568-41aa-a887-df4cb0bd923c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:9e655150-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 76903b0e6b7f11f0b33aeb1e7f16c2b6-20250728
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1305258281; Mon, 28 Jul 2025 14:52:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 28 Jul 2025 14:52:41 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 28 Jul 2025 14:52:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZs8WKKRzsED2xEV72QZZdN5A/hOJcXkSAb/sToYp5o5+mcNDiEqzyeSBV0sk9XmrGRTdfPnVkgitdkAjLWViQcI1sMtvb7SZTbnF0yA1NVgZCbbFoOnSl65rQ/MzADqhdgAEb6thS775COTq8K2xBywrQlqgOnPONmSNrG1K+62ia4nraF6vrx5aBGf0wj49X968nadSBna8FzabKGaYsyblu89ATIWte25Q25Ckrqo2BrtAOx/wXUFKfDkjGEU6EYRrT2/1yOFwvf8nTysCR7N3alHJvS+xH4o/POHQQm8+oEVuCVjq/P0Dvt3Zv3phpFLoGkE6Cw8zV717VhjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plDj9eClc5cr/goyDmZ6OIHIR0G9gwYpbb9YOkPQ7cY=;
 b=F27tBcgKWRnDKc/mFRoSPOP4iAfX9Yzn6Uv0fuHU/K3vw0YQk6kLTc2ZfuZGImQrct7bho2dkKuJrccgXt2sPR4Y0ijz6SFZydsGzWIO2zdnFXO3pN3AMvkWaHRi2miBNJHthx6VEnkb2It48fzRi0OuCKz/SPRihtLwEB7gB6bcePV+4Xk3+m1nWXtnJrwDWXRIQDZtTDNNyMn5ppibdM/t4Zo6m6oItmZkZ6ul7mntAL3+qHleE7+np21uujtgFr1/ZLfM77RaT8fB0f8fkUHbdKxTSqO4leG1nG+9SNHQb5WC2srmLgsvezVKQ0X2G4uwWtf5MB++D0UlA/CEVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plDj9eClc5cr/goyDmZ6OIHIR0G9gwYpbb9YOkPQ7cY=;
 b=RQLWbzukH2O8sKD48HqeMkOKndpbuLmmxrHXYm5PV9RAe0vm9HtI8EJg4gedlJZH3x46yML9UZlMlNmtcYsq4j/WApuZhFUoOnGLQJlgt1mQ9dEpoQgiuEfJtRMqNqqIC+oFrP2M3XbH8zKCg1IsGKg10mE6RGUmmUJOhyBHa+8=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by JH0PR03MB7635.apcprd03.prod.outlook.com (2603:1096:990:e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 06:52:40 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939%3]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 06:52:40 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "hsinyi@chromium.org"
	<hsinyi@chromium.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 5/7] dt-bindings: display: mediatek: ccorr: Add support
 for MT8196
Thread-Topic: [PATCH v2 5/7] dt-bindings: display: mediatek: ccorr: Add
 support for MT8196
Thread-Index: AQHb/sZ6bHhT6BRCCEWGmJhmiaqykbRGbokAgACsUwA=
Date: Mon, 28 Jul 2025 06:52:40 +0000
Message-ID: <b0c3521e3659e8cba8d14318a3f2053dd02cc6cc.camel@mediatek.com>
References: <20250727071609.26037-1-jay.liu@mediatek.com>
	 <20250727071609.26037-6-jay.liu@mediatek.com>
	 <20250727203552.GA12324-robh@kernel.org>
In-Reply-To: <20250727203552.GA12324-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|JH0PR03MB7635:EE_
x-ms-office365-filtering-correlation-id: bcb314d9-2038-4706-74dc-08ddcda3585f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S05qRjFIYkVoeUZQWTgyYmdobldTSG1wOWZISXA3VmhUb0d0V003b0RqcFdE?=
 =?utf-8?B?ZXBLbHlwaVN2d01BMWI5TkgvazNqSzgwRmFvQzJ4NEFGUkFtTFFVRzVzYTZi?=
 =?utf-8?B?NEFIL2hFOE16MkE4b3VFSThkWXpBUm81WVFIVWFpMEJRNkRqZWhiMk1OdER1?=
 =?utf-8?B?Wk9teVpuRjFlOEMveTlhWU1CWmpCV0pRNWR4UWFPa3BuZ2J3dktpMnhHTjVU?=
 =?utf-8?B?cGN0RjU1cmFyT1JlR3ovWDVwRi9yZWJFdG5Jc3pLSnVxd1JNckhqa2VOZmdq?=
 =?utf-8?B?cVk1S1NKT21adVQ5UUMybGM4NXZFWUFXTWlIcFZxaWtQQVJmNnJrb2Q2aXZW?=
 =?utf-8?B?YklhVWkyNklrVzJlckhiSGdHUUJKS1VaRVNHYmVqT3FnK1hxK3p6NmcrTWpo?=
 =?utf-8?B?MGRBaGlsL05OWXcvMzR6Vmh5VVJpRS84K0R3eW1UYXRxSDEzSGxHUzcrK1JJ?=
 =?utf-8?B?NFhUUzE4dUpwbmJKb011Ym81N1RTVjNyUG5hVWFwZS9nMVVVc3VtSHd0a2RH?=
 =?utf-8?B?UXltZExEWmUzank3OGNtUWVuYkY5c214aVZlRDNHaHpHYVNtNnNXbFNaZ0ZJ?=
 =?utf-8?B?blIybFk4bm40dzhKb3lRQ1psSUdWTWxkWElUcGZMdkhIVWdKMWpVTUYvUHNt?=
 =?utf-8?B?VFlLQTNoN1ZuN2xyVVE5TjEzeFhwRmdsK3pncmdvNW9XakNtWGVnSlpLdnB6?=
 =?utf-8?B?am11bnZBK2QrNW1jY242M2RTT0dGVjhOcFRZVU1wUmZRYzJIM0piVmlrTHZJ?=
 =?utf-8?B?SXkzZERxcnFGYk03NkNabUNqU0RuTTEvN09mMnc4MC9nemZxbHZlYlVaOVAz?=
 =?utf-8?B?RFFxT0tRTkJneXVSc0U1dkI3RjRLMDVOYjZCSkFKVEYxdEpwMXVaWm5UNUtv?=
 =?utf-8?B?ajZXOEZDdzhVejU3UFpHM3oxaDJWSkpKK3pPcng5akdXd3ExV2djK3F2RnVz?=
 =?utf-8?B?Q0taOWs5NkZKSDZoRHkyTHhScGxqZDdHclNzckdPWjZrdUh1TG1JUWVZQ2Rj?=
 =?utf-8?B?dGZEek5IdjlCSE8rVi9vL25wSXBsdFJhZmt2elp1VlNMd0dBdk56LzNmQnlW?=
 =?utf-8?B?VFdlZERTOVdCS2wrRGNKNjRKUUtVTFZzU3N6Y2MwVW85YVBzT1VlNDJoc2FC?=
 =?utf-8?B?UW8rbWZSMlp5UXlZV1ZIWk9LalFnNkVSNlZwSjZ2dHl5MmE5R2lJZ1RhNnl2?=
 =?utf-8?B?U2FrUEFYTUFCeU03UmZxK29BUnNRWnFLVDB6eER4NUdFVVEzSkdNSm83cG5Q?=
 =?utf-8?B?am1YVnlLR3I4RjZxdExVb2N2Tit0L1dWL2M2MlVTdUVHdGY1M2hUUnlwRGY5?=
 =?utf-8?B?dHd1S1dmS0tlNzNOa1ZoMmtJMXovTElpSG5MVHk5bFhHM2RReEpzZFNPa00r?=
 =?utf-8?B?bmpvOStGYlMyQk5CcEpUb2p2cXZrQ05oWkxnTy92SytWMENhWmZ1MmdrQ2lv?=
 =?utf-8?B?TVNWbE0wUlNHQ05nUmFJcmZwbGNjNnZZc0RrUVVpOTZzVlEraHpva3E3ajVo?=
 =?utf-8?B?eFNFSXRadzJJbm9XOFVuWDNmVnZjRlR4N3hYVEJZRHE2cHMrOUg0OFozQXhB?=
 =?utf-8?B?QnVpQ1ZIWDRNcW02SjBiV2pMUzQreGRzenRPSXh4dFlaY0xmQ1JEeDhIUG5N?=
 =?utf-8?B?b21heGtZSk5rTWpXa09YNWE0Z1UzaE85eEhZUkdvVVlYTjEvS1ZYUnRoOGNG?=
 =?utf-8?B?WU05MDJCSkVTelpBb0xjZGxTWVZBOE00MWVLSlcxck9VVFU4T2M4VFJqSC9o?=
 =?utf-8?B?a2ZSUVlJNWN5VEFtWmJzYWw2RmRlR0NkbWNYMGFjQXNaRW1sazVkdlQ1d1hY?=
 =?utf-8?B?ZlREMnJJVk5ZMExjTmJDUkx3c2RjVXlhdTRHUFRQdWdWNXVVelJFRjBoejBs?=
 =?utf-8?B?bytRc2xjM3MzV2tMb2pFek1aTmYwTGRMR0J0dlM2RkVUL2htdVFTQ0k2UlMy?=
 =?utf-8?B?VFB6ZUkrbkhFR015aXlLTWRrV3RIa0pXS0U5bHBVdENPU1FwRmZMT2N0UndV?=
 =?utf-8?Q?3vAQHkBP+UyH+baWtSyH5KhJTovSMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB8136.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVlqSWtuNVFYR2hTWFhCektBZjBSRnhjNFdZM1F1ZUZjcVhJVHVxQVZOd2xk?=
 =?utf-8?B?OHpDOW9SUWFUQTBoMDYxbWxPOTR0dFI5N0dxUzhMenhaTS9vZWt0T3FLemt2?=
 =?utf-8?B?Tm1XOW9WbEZDdVZNaEovUys0UXkyMnNGUVRvRHJ3UGM1cnNOWDk4YzJUeFN2?=
 =?utf-8?B?T1NUVVIvYmJKeklwTlV2R3RNcEM1M0hZckw0M1NpV2VuNXVIb1QxK1haanlF?=
 =?utf-8?B?QXBjWFhXSlJ1K0dxaGtBcWNRQWFpL0U2WTBwc0loTklSYnlJb2k1MUkvN0NK?=
 =?utf-8?B?UTdtUUpOaHozeFdMVzI4akdUc3dwYUxWbis3eS9KTjdlUWE5Z2s5eFJBSU1F?=
 =?utf-8?B?alNKTEJXVmJqQmN5bWxob2h4NWhPSmwzOXRtRWFPZVlCR2NvYWV2cENmVVE3?=
 =?utf-8?B?OWRPTHVpV2d5cU1ObHQ2M25Ga0QzdktyWVFMTVkyTTU1UE4xY01tYVA4RzIx?=
 =?utf-8?B?WUdTZ1VOUWZwZFZBVDhFZTdaL08rTVFMQVE4V2FqZ1kyNzk4cTRTTXJmZ3BV?=
 =?utf-8?B?Nk9JT2xucUFEbDRuNzhWd2ZiamV5cU4xUzMvWG4zMm5IWC8xNWRDWjdUdHlm?=
 =?utf-8?B?TjBtbFBabVREU0Y2cGtncmlhWVQvVWp1b3ZDRHg0MWM1RkNoOEgwcHRBVU4x?=
 =?utf-8?B?amVWcTlFOGdHWGRHK2FyaDV1RGVwcnRlaVlNaTEwdUJLVE5UaU1GZ1UzUm1J?=
 =?utf-8?B?SWVuR3R3eEJWWkY0dVdMdUFRWTl5T2RhZFJEOW4zTGRNeE1nMGxSVzIybTQ4?=
 =?utf-8?B?SHVKL2svVmVrWkFSOExSUHZ4eW1kVUhzemxIdUwwaDJ5dkM4eU1HQzdJbFVR?=
 =?utf-8?B?SlVCQ2JBeStJZmFWTDRlQS8wZGVlQ2RMQVJmUGliUUNlMXZsbTBFTzgvV0p1?=
 =?utf-8?B?dGRUdEd6ZkZUaGhWQTN1aytlczNIQklsT0QxMVgwelhmU2NtRzYxZlhLNUxZ?=
 =?utf-8?B?RjFKZUJVakFBd04weXp5UDVhYzdRNTVlcHRxc0IyOWtQQU1SNFFQUmYwbERt?=
 =?utf-8?B?cHhiaEdBbS92NVQ5Y1RJbGc2cWpmdU55Q3oyY2NDazBGWFhGVGFHRGRBQTZN?=
 =?utf-8?B?YXMxZlZTNmhJcGN6eVF1bW9hWHR2M0tBUjNuZm1kWFZWTjdMcERLUkcrc0sv?=
 =?utf-8?B?dCtwUFUzNlBwMmhVdjRuYWtVdFFCWGIwKzRhRnZCVWhtVGROMXppUFYrdXB1?=
 =?utf-8?B?UE9nRVlTR3NWclVnYWpZVXowLzhiL012U3FSam1XaXFRaDRERUJpcU1HQ2tv?=
 =?utf-8?B?Uk55L0trbWpDMnhGMVo4amEyRnFQclNVTlU3cW9XU0hFR3FrUWhQVzdUckJp?=
 =?utf-8?B?NW54MnFFYzNEbFNRellNOXBVbmluek5PNVRieklaWTVGdk84cjJNL01PMS9m?=
 =?utf-8?B?WjdNOGVNRUNpRjNvTUNCSlFERzhOaDZqcGhKbUozUitRVld4VXJNZmkrWGxP?=
 =?utf-8?B?UUtWRm9JZ0dzZCt2bTRoZWV2ZlJXME9uQnU0QmhFbXc2VmROYzlwMlN6YytD?=
 =?utf-8?B?TUovc3RmNUFaWmh1cUh4OWZIZUR1bDY5Nmp0QktPTTY0MlJabUhaM0VzVHl4?=
 =?utf-8?B?UGVWdEYySWJqNFBVdzZpUktzRHluZVErSm5iT3dCUWdnc21jOGhLeENUbEtw?=
 =?utf-8?B?OXY0OCs2aFlSRWxBTkpJd2lZdDU2VFNVZ2EwVE9DYm96d3ljaWJuTndtMXRj?=
 =?utf-8?B?OTBaMlJvU00yNUVQUzdqcWpKL0ZISlZ5Zk9ESW44RUFWaElGNnB0UXJoNGZE?=
 =?utf-8?B?K2xLS3JqQ1U5OTIyMTAvWFM3WmNIVHZuR3UvVi9qWHhKUnZqNU1QcFJEbk5V?=
 =?utf-8?B?azJHMkZlVGN0T3JxTzlPNmx4aFkvamxwR3d5a1Fsa0dEcXNobXZPTE9ZZXNV?=
 =?utf-8?B?aWxLRFRWaEhiOFZVdjN5RnpPamNkbFdEd2hnWUxsQTBnVGtDVTkwaFJjU1JJ?=
 =?utf-8?B?ZW1WQklvYk14SGdMSXhyQ05FQ3RRejhTRkRiU0JSMzhxM29YTWtnby9tLzQ2?=
 =?utf-8?B?VHMrZlQxeXFTUGY2aVd4dVcyQU5vcmJoSWk0MUVTUzdveWpIL3RHOHhNTEFL?=
 =?utf-8?B?cSthQWxxVmNaRzhwL2ZMK1ZJWlh5U05Sbk8xSzRxSFdBYlBSZDd6ZXBsVXMw?=
 =?utf-8?Q?491y49Z/HdXiEU9WfITPzazE6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2347C60129DD9240A5D41BA940FB2B70@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb314d9-2038-4706-74dc-08ddcda3585f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 06:52:40.2071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbG0zdTGFRrKfm8QAfHpy/tZMV4D4Wmwe1zDCYfdN764B2XIx+CBvnkYaG7j09xKnV1gU9cYhAAvk9hMO0eYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7635

T24gU3VuLCAyMDI1LTA3LTI3IGF0IDE1OjM1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBTdW4sIEp1bCAyNywgMjAyNSBhdCAwMzoxNTo1NVBNICswODAwLCBK
YXkgTGl1IHdyb3RlOg0KPiA+IEFkZCBhIGNvbXBhdGlibGUgc3RyaW5nIGZvciB0aGUgQ0NPUlIg
SVAgZm91bmQgaW4gdGhlIE1UODE5NiBTb0MuDQo+ID4gRWFjaCBDQ09SUiBJUCBvZiB0aGlzIFNv
QyBpcyBmdWxseSBjb21wYXRpYmxlIHdpdGggdGhlIG9uZXMgZm91bmQNCj4gPiBpbiBNVDgxOTIu
DQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4g
PiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmF5IExpdSA8amF5LmxpdUBtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
MjAyMjAzMTUxNTI1MDMgY3JlYXRlZCA8amF5LmxpdUBtZWRpYXRlay5jb20+DQo+IA0KPiA/Pz8/
DQpJIHdpbGwgYWRkcmVzcyB0aGlzIGlzc3VlcyBpbiBuZXh0IHZlcnNpb24NCj4gPiANCj4gPiAt
LS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRl
ayxjY29yci55YW1sICAgICB8DQo+ID4gMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGNjb3JyDQo+ID4gLnlhbWwN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVr
L21lZGlhdGVrLGNjb3JyDQo+ID4gLnlhbWwNCj4gPiBpbmRleCBmY2E4ZTdiYjBjYmMuLjU4MTAw
M2FhOWI5YyAxMDA2NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGNjb3JyDQo+ID4gLnlhbWwNCj4gPiAr
KysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGNjb3JyDQo+ID4gLnlhbWwNCj4gPiBAQCAtMzIsNiArMzIsNyBAQCBwcm9w
ZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LWRpc3AtY2NvcnIN
Cj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1kaXNwLWNjb3JyDQo+ID4gICAg
ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtZGlzcC1jY29ycg0KPiA+ICsgICAgICAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTk2LWRpc3AtY2NvcnINCj4gPiAgICAgICAgICAgIC0gY29uc3Q6
IG1lZGlhdGVrLG10ODE5Mi1kaXNwLWNjb3JyDQo+ID4gDQo+ID4gICAgcmVnOg0KPiA+IC0tDQo+
ID4gMi40Ni4wDQo+ID4gDQoNCj4gPiAgDQo=

