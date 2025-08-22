Return-Path: <linux-kernel+bounces-781815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B394BB31717
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C554FB67A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00992FAC12;
	Fri, 22 Aug 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="prpi7khg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g78IRrEu"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D02FC031
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864420; cv=fail; b=TjURKJ8J/Ww9fQ5FZG+ccoc8BISURXutW/cmU51Uq1uuEqGe0Wuj9g3a7Y6WxrBxPnGUNheSsMGN23M05ySSWSStUx65EKKlcJdd2ZVd28Ig6YlVyqjmUZxPLOWNc9+encu5XomimRRoA8V3LeodMBpi9Ls68oiDT2thZLJwe4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864420; c=relaxed/simple;
	bh=fa8O6AASZtfXtjceocKDwS4Td9rK4DWZXsp3Q9FCOZQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3h98s4zh4jkXu92YvIL0l0+wampiYruyOL8bh8C8wgrpxPo+HbNPMcCOzI2SR9zstMI92H3fQv/G5m/TgwC5Lfw0qApRoLXZusf5zKDZafRnRnPpB91gtsUzrUciQJ46T//FWjdBPBhtQoQiL/79qeDpysrn1NOX51LJbPaW7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=prpi7khg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=g78IRrEu; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7d30e8d47f5011f08729452bf625a8b4-20250822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fa8O6AASZtfXtjceocKDwS4Td9rK4DWZXsp3Q9FCOZQ=;
	b=prpi7khgXZHNhHNl1yHs9gfcsqHgtoKL9oGPZxv11Xsx0WHNDPPJurNQaUZk8KcceKaMaptjwgMnQJQLp/2wXlv/CPrQDrv91cWRrWclzHmxKLL1wR3ufGQdGgl9L16v/7hSqEXY8Cdllrvo1/XukzkC3nuQz707pIfa68UFh2g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:5577f8b2-f745-4310-b746-ca5f2d39d0c0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:b0da37f4-66cd-4ff9-9728-6a6f64661009,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|51,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7d30e8d47f5011f08729452bf625a8b4-20250822
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1546235835; Fri, 22 Aug 2025 20:06:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 22 Aug 2025 20:06:50 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 22 Aug 2025 20:06:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvUhdiIp0m/KXYzshF70AUNPPpZUhW1vXJeo/9Qpn3BADVhra54NY26FtIXA5u4YoEJgGKJ3O8HCDAqE903AA7rQbTwR+yNoW3rGWCwzNDaAsvWqtJuaZSxiZOT2ocAKA645Mtg4oMJ96P9TWaDk4coB2LMejpDSYftMznzo4mcYwVrR9JnQXgsIEioGOAkIW/t0D5v3MT+uk4PBz0wbkOD+KlF2TAvl7VADb3DTL4AsVVFn8e3uRet94A0UQvY1+62ftEVEEf13aNKWGM4ydT7C3tcCwEccM/fWgO4tE99Nk/8NZfpd7Stu9YflMVQyQjnX97xz2lpQFqpyHwLWZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa8O6AASZtfXtjceocKDwS4Td9rK4DWZXsp3Q9FCOZQ=;
 b=GvAsu0F3fZp9BG2EZStaXPcagV3iGPjxAAyXePQ33grOxfrEM2s4P2i1pJHv7sXc0Ud3e4NKWcAK1GW2QEM5r2lUFPjtdsC3DCc3gDd66IUcH2WiBIYA7MuOcYGrlHThH4lqaZvnHGfIGSWM0pNWBDRVXmqQ5QK3xuo2xyS82jWW1StohFnx7FYbP8EwM+QHxhw01eiPmtO9LMS3PGRzzI186wuU0M74mYaYNSGImrQ56AGcWiqMyZp6y8iTUFqEGx7wqzGjTEzGs9a7eVKiV1REvM71eA7OuBj/ovU1bC+2erOcEdR/O8kyTyNHyQM/Ff7120Vbu/MLrQLHqVt3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa8O6AASZtfXtjceocKDwS4Td9rK4DWZXsp3Q9FCOZQ=;
 b=g78IRrEu5qRWxVSRBiNllanlYvjPKOYXc2LwFigli/CgTJzoK4a9r3UoCBcSdbveV2RpfHU6tyOfvxxLMMn0LYjiqFun7VGP2otEdDKoQh6QJQHXtAEeDtlxPhLUdBDYO5IBBNogsTgHf7DMtDqKt5KsaEQErqiE7ar+492MF9g=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by TY0PR03MB8221.apcprd03.prod.outlook.com (2603:1096:405:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 12:06:47 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::7a62:8e4a:b62a:3c13]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::7a62:8e4a:b62a:3c13%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 12:06:47 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: =?utf-8?B?UGVuZyBMaXUgKOWImOm5jyk=?= <Peng.Liu@mediatek.com>,
	=?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Topic: [PATCH v5 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Index: AQHb6ZZLtHaln/Nyfkm9ZIr+CBGDsLRVVnqAgBmQyYA=
Date: Fri, 22 Aug 2025 12:06:47 +0000
Message-ID: <b68237812ed3251114b4df3c27b82ee1fe9243e3.camel@mediatek.com>
References: <20250630080824.7107-1-liankun.yang@mediatek.com>
	 <d97b4f6790bd5ab3dfb0e32d015d65273cef1078.camel@mediatek.com>
In-Reply-To: <d97b4f6790bd5ab3dfb0e32d015d65273cef1078.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|TY0PR03MB8221:EE_
x-ms-office365-filtering-correlation-id: 9203543a-711a-4033-052a-08dde1745ea0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?eUt3b0JhV0ZrWEZyY2Z4QUZzL3JnY1RrRnR1M1BpWk1kVXRHVE9pM2cxRlRD?=
 =?utf-8?B?QW40NXVLL0dNNXpZT1lPK1VSRG1MNzZBWXUrV3RMaFVXQ3Z2MTZXc3ZLeGh1?=
 =?utf-8?B?b3dtVjlxb0dvVEJsd2pVU0NqNGJkVkhvSlp4VWp0RktaWExHclE3ZGppdGNS?=
 =?utf-8?B?VEVVcU9ReWVsZDFJOVZ1NXdzNHV5dkpNSmYvSEgrcjNjaHdmc2hySFBNWFpR?=
 =?utf-8?B?UlJBZDEra085cGdsRWxjS1NPbC9DT25DZDFhamJYWjFvS3l3RDN2Q2pOUmJn?=
 =?utf-8?B?cVprMmxENkpnOTlRdVAwYUcrS05yTlRnTWwzNU1OdWxwdUV2TVB0ZzdsMHgy?=
 =?utf-8?B?WjM5T1FWZmt0UXkwRDB4WUxwVmRsemVvSzBhY0h1aW9NVk1RT1VlWUV3bDBw?=
 =?utf-8?B?TGIrK01yOEYwSXlGWTE5YUFraG5JeEJ3VVROWVgwUFZDMUNLWEMrUDVlUHNF?=
 =?utf-8?B?K1oxZzByTHNvVFVXZlRENzd4SmpYM1BUeTRrbTNJV0pXWThkd2sxL1NZcmZ1?=
 =?utf-8?B?TVhsU0FVQWdSREkyVDY5SkhkSUk1U012ZWtJaUFxcGVqQ2ZMRE44dmptTDVu?=
 =?utf-8?B?aTc5TnZmY1Y3TUxzZElaY1cyZDhQaFloWmduYWNkUzhQSDFQZm4rT0tpcUlS?=
 =?utf-8?B?VUhEOGFFREJYQkl1alBPMkpPMVBJalczZ2lhUkJTU3ljVDYzY0NSRXJDejNw?=
 =?utf-8?B?MjFuT25TV0NLcDRVL2tIWDh2ZDdMMmRRemsvRjF4aWx3b1pibnpJeGo1d0Yz?=
 =?utf-8?B?dUkzSDRtd0RXUXVob1VrWmx4bTBlazRzdTlRTS9neW4vVGRwTjNrbmpKV1h3?=
 =?utf-8?B?Yi8xcVFrMlNJMGpaVjUzaVFhRXVtekp3U3VvM2MwYk92Y2lqbGV6M2dHU0hk?=
 =?utf-8?B?bG1aTUpXOU9NUW1taHFzYUJaYUFPdWc5TzJWNXNEUERCak1sMEl1eW5xU2xl?=
 =?utf-8?B?ZXRsTytDN1RGNE52RHJMQ1ZOUDJtOVM3ZVlSWjNaUmFmMUZZRHJaY0lvZGNU?=
 =?utf-8?B?M1g4Rk8vdXp4eTNwMCtkWjZ2T0gxVmYvdzAzeFVpWitGOUZiNnBOREE3Sjk4?=
 =?utf-8?B?Q1FvQXAzczVGNFFBQ3F2dStpZ2FVTnA4aEJyOG94N0lybnVybGFzdFl1azgr?=
 =?utf-8?B?TENhcm5oclBLUm5nTW5QVmhkQzJ5b1QzQnBHa2hCL0FXbThFZi9abHJubDcr?=
 =?utf-8?B?bm50UHNWSElYZ1d2cFM1SnhmaHlSNTN4Yy83S3ZJQm01N1NaTVNlS09jOGxH?=
 =?utf-8?B?bW0wL04zeC9tcmMybVBzRmlLNnRnTVhkWTJJMDlQWFBXd1ZsTWJ5ckFOSGc3?=
 =?utf-8?B?REgxclEyYXBiMkJPSFZKTElHMVBHSmNPREZWWVpVdFhqLy83ck1yYzNVQkxK?=
 =?utf-8?B?dE9oRXo5V3d0MUorV0Z1L1ZWc0NIN0JOaStQaU5rMkdQWHh6YVRORUV4ZFpG?=
 =?utf-8?B?ZlFJZE50ekJ4Ly96RlRtSTVZT2ZPdk9xOFBWbmsvZkRPc250bytzdEZKaFpQ?=
 =?utf-8?B?YUFrck1UbWpKTTZMZitKc1JqcGhJUnh4UktXN285RG53NmNrdXZjZGZKdXJD?=
 =?utf-8?B?STZkZng5UEFpUzljWk1mWXNGMUNkOUgxc01yeVFUckFDVjdoUW9OV0VBY3NL?=
 =?utf-8?B?UTdmUkdWeURURC9BY2JUNlJWcGVTaU9tN0VJRzV2OFVMZjdwZVRRZXFubHZQ?=
 =?utf-8?B?c05Gc0FOMzhzTTNtaU9pdVZKYjZhLzAyNXoyWkxwYzZPUlRPZ3EwbEY3TWpW?=
 =?utf-8?B?Z05jMUt5cGxXSExsQk5rZktuaXlNZmJ1Z3FxN3ZOWENUbW1TU0RlZEMwZ3NQ?=
 =?utf-8?B?M2tNd3NwL2sxZzR2UGwrQk9obW1rb2RGQ0tOdk9rR0dsRmRjeGhhdHp4dUlS?=
 =?utf-8?B?UHdlalhPOGVSdFRHS2o1OGNhWVFXa0pEbGxhKzZ2eUVzeEtQMVQ4QVpIOG5r?=
 =?utf-8?B?RlBHQm9YMlFKTWdtUy92NjdoVWEzOGNlMnBqQklBckFJeHBaZ2ZkQlI1OEI3?=
 =?utf-8?B?MGdLNzBVeHNBWlJndU15VkFOSy9xMGNoeUFBc0tOSzhlMk1UY3NjMy9jZUtM?=
 =?utf-8?Q?EpaboH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTRyVWxMRTRrQXRqTkd1c3VZZjdRSjJYVmUybnhsT0x0ZExIb0w3UVFUQmpP?=
 =?utf-8?B?KytJaTZ4S2dvTktTSncrLzFvTHFwNDQ1T05wclpJVldySFBhUlYyeXJCdVJM?=
 =?utf-8?B?czJ6bk1GZG1aVFZjY1F6b3lYMU5ZcjRZUEtGRDdTVG9sRzRQRTdRLzZmd25S?=
 =?utf-8?B?aHZFS1BNeUZNTUFTNTNVQ2JxZGpYVER2bklGUDdhN0FUK0Yxd29uZnlYbkxk?=
 =?utf-8?B?ZFF5dU10eEhuS0Q0cXZLREc2cXpuRWVxeEdwSzU4V0F4eGdkV3dNT2d4b3lP?=
 =?utf-8?B?TG9lRTltdEpzYURUTWZKdk55bTdIa0JYc1VBZWhxYTlQRWtuOCtWdHY1bDB0?=
 =?utf-8?B?WHordEVhNVNoUlFNU3ZSelB1N1Y3bkVFRkZSMFI5cm1vV2Z0Mk9CZm9IL1JM?=
 =?utf-8?B?cTdpdjZ4c0VHVU5FbFJyaUg0YUx6VE1DYUpXN3QvQ0RJcVBFNG5YSUd2M1VS?=
 =?utf-8?B?MVdLNnZtTEc4MUJ3ekFpZXpYOUl5Szh1dmNicHN4dEdiSWdXSy85SWk1RkpW?=
 =?utf-8?B?UjlaN1JtRlhDYXNoN1RpQ0IvODJOS2grV0hEdzVBaXFXUVZTUS8vM1NDMHlz?=
 =?utf-8?B?ZUd0ekVGYTZlVVkydmdNbXJES05xWUR6Q0pRZXB0aVVrdUtRM3cwNGtxT3Nq?=
 =?utf-8?B?UFZjSjJBYVBGZmNTMGFGZUw4SlQ5dUpRaVBOeWZyaWlvWkk4VjNReExFUUxS?=
 =?utf-8?B?TmFZK2thVXBjN0djZ0Ixa0d6OGdCU2IyaHhiZ2hlWnhzLzBjazE0OUFOTFZl?=
 =?utf-8?B?TVV2NE81OE1QU3RQdHIzWEg1WUs2T05CWGV5Z0N4dEFYUnc1QTRtV0E0cWxE?=
 =?utf-8?B?Yy9iME1qYTVHNWpCWTNjT1RaZGpTcE1EOHE3U3FmdzZUQURZb05pdEZldlg0?=
 =?utf-8?B?WGJPSXVSOFk0c0VSeFZaUE1qYUJzbGpUTlEvWUozMHBqTHlabTltaGRWa2NP?=
 =?utf-8?B?WlVGbGJGOWEwNkJMdlBtVlFlT0gyNEU3NklGM2g4Z3p5TWpvN3ozVW1wbXhO?=
 =?utf-8?B?QlhDT3hDQkFRNFFtMURyeHVSQkdFSE56aGUybllqaDZEVWlIRWswUWdmOEFp?=
 =?utf-8?B?M2dhcmhuMTI5UVc1a0dYVExpNXNJbHF5NjNRSVFFbjdjcEVMTGdmN005dDl0?=
 =?utf-8?B?a1JNL1Vyd3RoU1JhbWZlR2k4emMxdjR1dFFsclE3czBrTTcrNXd5RnpWckUz?=
 =?utf-8?B?dHdCejhicEE0R1FzdzQrV3R3OUNBdUdybGVCdC9LYUlRMUJiZ0grOTcrTktx?=
 =?utf-8?B?S0VscGtIckdUdFdjcUovN1p4cDgrNkVBNlp0TmtBOExqZzU5ZllLMWJYeG1F?=
 =?utf-8?B?WGRCcHFLSnViRC9DbFlLWldMSE1yQjhjZ0xLYnBaVEJyd3QvL29MTFEzYTlM?=
 =?utf-8?B?YkkrNXY2VkMzdkE1Zm5CeGxaYWRYczF4akIzK2JzUHdRN2tBanRnWjlFQWdn?=
 =?utf-8?B?eVFPVmR0SUtKN29pL1grLzFUWWJyR1dvUjlFa3U4Zy9QbTg3Ty9yREwvNFcv?=
 =?utf-8?B?SVZCZVpqN0t0MWNNV3ZKcmkrQVNqUTFRK09yRlJMS0s5UUhwOWhLSm5udnMz?=
 =?utf-8?B?d2pZbGtJRGNKNW5NTFNrWXBXVjlET1VuZklBQU82bFBLNm00eWlNVlh1N2cv?=
 =?utf-8?B?cDM3VlV3U0xINmNFWmk2TjZaMkE3TWMxZ3hKRFExQ2JIeDByNFRTakV2dk9k?=
 =?utf-8?B?c1o4cWhBck1MaEFPRmRxVExWMTA2R2lLL3U5OHgyUVFjWnF3NlJaNW5lTlhB?=
 =?utf-8?B?RFNrRmhTbWZ3WEQrVDdLNk5zdm41dEZ3aHZyQTR2V0RIQWs3ZSswREpVTWZ0?=
 =?utf-8?B?Njg5L0RDTWRISFAvQ3pRS2hYZWNad0RKbmVKWVhtdlE4RlBidTFvbnF3cTJW?=
 =?utf-8?B?Sk5EU3FiSENIT2tCcnJPMzhRRWdnV1BLV01obXJqVEZpSm9UNlMzdjFMMXNJ?=
 =?utf-8?B?Q0pxQThHVUVrR25xc2NEemo2c0ZIMklQaTlKenlLZFVzMWdSb2p4cDNvWGE2?=
 =?utf-8?B?d0lhL1Q0OXA0eEZQQTh4dHNDS3BFU3MveGZEZTlibzE0M3hUSHVYMmhld09l?=
 =?utf-8?B?L2RzMzQwSWw2cnpCUHl6bnNwUmNUMUg4RFF2RXlPRi9DUFJXT3NTTUd5ZXA1?=
 =?utf-8?B?VVZhbjFzOEV6TEw3Z01RYWdPd3BNTFhCOUdCSTRQWWlZK1BQTDJLRU5SQVFk?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <166EE647601A89439CF6B9C0B15E8ECD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9203543a-711a-4033-052a-08dde1745ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 12:06:47.5841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkiyZ3NqYUD1LC7Img1nkpEPPUHW1u8k5XLE9Fwy9UsPM2ZhuEx8UK5y8hLm904vbKoaIX2ENaYsFWnPb8yqnRiPL2q+9Tw464im5Vzbg0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8221

T24gV2VkLCAyMDI1LTA4LTA2IGF0IDA1OjQxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gTW9uLCAyMDI1LTA2LTMwIGF0IDE1OjU4ICswODAwLCBMaWFua3VuIFlhbmcgd3Jv
dGU6DQo+ID4gQnkgYWRqdXN0aW5nIHRoZSBvcmRlciBvZiBsaW5rIHRyYWluaW5nIGFuZCByZWxv
Y2F0aW5nIGl0IHRvIEhQRCwNCj4gPiBsaW5rIHRyYWluaW5nIGNhbiBpZGVudGlmeSB0aGUgdXNh
YmlsaXR5IG9mIGVhY2ggbGFuZSBpbiB0aGUNCj4gPiBjdXJyZW50IGxpbmsuDQo+ID4gDQo+ID4g
SXQgYWxzbyBzdXBwb3J0cyBoYW5kbGluZyBzaWduYWwgaW5zdGFiaWxpdHkgYW5kIHdlYWtuZXNz
IGR1ZSB0bw0KPiA+IGVudmlyb25tZW50YWwgaXNzdWVzLCBlbmFibGluZyB0aGUgYWNxdWlzaXRp
b24gb2YgYSBzdGFibGUNCj4gPiBiYW5kd2lkdGgNCj4gPiBmb3IgdGhlIGN1cnJlbnQgbGluay4g
U3Vic2VxdWVudGx5LCBEUCB3b3JrIGNhbiBwcm9jZWVkIGJhc2VkIG9uDQo+ID4gdGhlIGFjdHVh
bCBtYXhpbXVtIGJhbmR3aWR0aC4NCj4gPiANCj4gPiBJdCBzaG91bGQgdHJhaW5pbmcgaW4gdGhl
IGhwZCBldmVudCB0aHJlYWQuDQo+ID4gQ2hlY2sgdGhlIG1vZGUgd2l0aCBsYW5lIGNvdW50IGFu
ZCBsaW5rIHJhdGUgb2YgdHJhaW5pbmcuDQo+ID4gDQo+ID4gSWYgd2UncmUgZURQIGFuZCBjYXBh
YmlsaXRpZXMgd2VyZSBhbHJlYWR5IHBhcnNlZCB3ZSBjYW4gc2tpcA0KPiA+IHJlYWRpbmcgYWdh
aW4gYmVjYXVzZSBlRFAgcGFuZWxzIGFyZW4ndCBob3RwbHVnZ2FibGUgaGVuY2UgdGhlDQo+ID4g
Y2FwcyBhbmQgdHJhaW5pbmcgaW5mb3JtYXRpb24gd29uJ3QgZXZlciBjaGFuZ2UgaW4gYSBib290
IGxpZmUNCj4gPiANCj4gPiBUaGVyZWZvcmUsIGJyaWRnZSB0eXBlYyBqdWRnbWVudCBpcyByZXF1
aXJlZCBmb3IgZWRwIHRyYWluaW5nIGluDQo+ID4gYXRvbWljX2VuYWJsZSBmdW5jdGlvbi4NCj4g
PiANCj4gPiBCZWNhdXNlIERQIHdpbGwgZW50ZXIgaWRsZSBwYXR0ZXJuIHN0YXRlIGFmdGVyIERQ
IHRyYWluaW5nLHRoZQ0KPiA+IGN1cnJlbnQNCj4gPiBEUCBsaW5rIHN0YXRlIGlzIHJlYWR5IGFu
ZCBjYW4gYmUgcHJlcGFyZWQgdG8gb3V0cHV0IHRoZSB2aWRlby4NCj4gPiBUaGVyZWZvcmUsIHRo
ZSBmb2xsb3dpbmcgYWN0aW9ucyBkbyBub3QgcmVxdWlyZSB0aGUgd2FsbC1tb3VudGVkDQo+ID4g
YXV4X3BhbmVsIHBvd2VyLCBhbmQgc2V0IERQIGVuYWJsZSB0byB0cnVlLg0KPiANCj4gSW4gdjQs
IE5pY29sYXMgaGFzIHBvaW50IG91dCB0aGF0IERQIGhhcyBhbHJlYWR5IGJyb2tlbi4NCj4gRG9l
cyB0aGlzIHBhdGNoIGZpeCB0aGUgYnJva2VuPw0KPiBJZiB0aGlzIHBhdGNoIGRvZXMgbm90IGZp
eCB0aGUgYnJva2VuLCBJIHdvdWxkIGxpa2UgeW91IHRvIGZpeCB0aGUNCj4gYnJva2VuIGZpcnN0
IHRoZW4gYXBwbHkgdGhpcyBwYXRjaC4NCj4gSWYgeW91IGRvZXMgbm90IHNlZSB0aGUgYnJva2Vu
IHByb2JsZW0sIHRyeSB0byBkaXNjdXNzIHdpdGggTmljb2xhcw0KPiBhbmQgaGVscCBoaW0gdG8g
Zml4IGl0Lg0KPiANCg0KWWVzLCB0aGlzIHBhdGNoIGhhcyBmaXhlZCB0aGUgYnJva2VuLg0KDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTGlhbmt1biBZYW5nIDxsaWFua3VuLnlhbmdAbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZSBpbiBWNToNCj4gPiAtIEZpeGVkIHRoZSBpc3N1
ZSB0aGF0IHRoZSA0dGggdmVyc2lvbiBvZiB0aGUgcGF0Y2ggY2F1c2VkIERQIHRvDQo+ID4gaGF2
ZSBubyBzY3JlZW4uDQo+ID4gUGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhyZWFk
Og0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI1MDYyNTA5NTQ0Ni4zMTcy
Ni0xLWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYnchanFneHc5
LUVqMUFWTi15R3B4MmhPbTRxMnR6NHA2QWlGQWNWWEd1RVRncGR0dEFsbWVJWFNxc1F4NTYzZ1Nl
Sjc3TWx2OXNWalRBRktSZlNwS25qWEpZJA0KPiA+ICANCj4gPiANCj4gPiBDaGFuZ2UgaW4gVjQ6
DQo+ID4gLSBUZXN0ZWQgdGhlIGludGVybmFsIGVEUCBkaXNwbGF5IG9uIE1UODE5NSBUb21hdG8g
YW5kIGl0IGlzIGZpbmUuDQo+ID4gUGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhy
ZWFkOg0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI1MDMxODE0MDIzNi4x
MzY1MC0yLWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYnchanFn
eHc5LUVqMUFWTi15R3B4MmhPbTRxMnR6NHA2QWlGQWNWWEd1RVRncGR0dEFsbWVJWFNxc1F4NTYz
Z1NlSjc3TWx2OXNWalRBRktSZlMwNWM5Zko0JA0KPiA+ICANCj4gPiANCj4gPiBDaGFuZ2UgaW4g
VjM6DQo+ID4gLSBSZW1vdmUgJ210a19kcC0+ZW5hYmxlZCA9IGZhbHNlIiBpbiBhdG9taWMgZGlz
YWJsZS4NCj4gPiAtIFJlbW92ZSAnbXRrX2RwLT5lbmFibGVkID0gdHJ1ZSIgaW4gYXRvbWljIGVu
YWJsZS4NCj4gPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+ID4g
DQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQxMDI1MDgzMDM2Ljg4MjktNC1saWFu
a3VuLnlhbmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWpxZ3h3OS1FajFBVk4t
eUdweDJoT200cTJ0ejRwNkFpRkFjVlhHdUVUZ3BkdHRBbG1lSVhTcXNReDU2M2dTZUo3N01sdjlz
VmpUQUZLUmZTRVI4S3VSYyQNCj4gPiAgDQo+ID4gDQo+ID4gQ2hhbmdlIGluIFYyOg0KPiA+IC0g
QWRqdXN0IERQIHRyYWluaW5nIHRpbWluZy4NCj4gPiAtIEFkanVzdCBwYXJzZSBjYXBhYmlsaXRp
ZXMgdGltaW5nLg0KPiA+IC0gQWRkIHBvd2VyIG9uL29mZiBmb3IgY29ubmVjdC9kaXNjb25uZWN0
Lg0KPiA+IFBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gPiANCmh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3By
b2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDAzMTUwMTUyMzMuMjAyMy0xLWxpYW5rdW4u
eWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYnchanFneHc5LUVqMUFWTi15R3B4
MmhPbTRxMnR6NHA2QWlGQWNWWEd1RVRncGR0dEFsbWVJWFNxc1F4NTYzZ1NlSjc3TWx2OXNWalRB
RktSZlNRaVFUU080JA0KPiA+ICANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcC5jIHwgNDUgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ID4gaW5kZXggYTViMTBi
MjU0NWRjLi4xMDEwMjYzZjI1MTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cC5jDQo+ID4gQEAgLTE5NzYsNiArMTk3Niw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdA0KPiA+IG10
a19kcF9ocGRfZXZlbnRfdGhyZWFkKGludCBocGQsIHZvaWQgKmRldikNCj4gPiAgCXN0cnVjdCBt
dGtfZHAgKm10a19kcCA9IGRldjsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gIAl1
MzIgc3RhdHVzOw0KPiA+ICsJaW50IHJldDsNCj4gPiAgDQo+ID4gIAlpZiAobXRrX2RwLT5uZWVk
X2RlYm91bmNlICYmIG10a19kcC0NCj4gPiA+dHJhaW5faW5mby5jYWJsZV9wbHVnZ2VkX2luKQ0K
PiA+ICAJCW1zbGVlcCgxMDApOw0KPiA+IEBAIC0xOTk0LDkgKzE5OTUsMjggQEAgc3RhdGljIGly
cXJldHVybl90DQo+ID4gbXRrX2RwX2hwZF9ldmVudF90aHJlYWQoaW50IGhwZCwgdm9pZCAqZGV2
KQ0KPiA+ICAJCQltZW1zZXQoJm10a19kcC0+aW5mby5hdWRpb19jdXJfY2ZnLCAwLA0KPiA+ICAJ
CQkgICAgICAgc2l6ZW9mKG10a19kcC0+aW5mby5hdWRpb19jdXJfY2ZnKSk7DQo+ID4gIA0KPiA+
ICsJCQltdGtfZHAtPmVuYWJsZWQgPSBmYWxzZTsNCj4gPiArCQkJLyogcG93ZXIgb2ZmIGF1eCAq
Lw0KPiA+ICsJCQltdGtfZHBfdXBkYXRlX2JpdHMobXRrX2RwLA0KPiA+IE1US19EUF9UT1BfUFdS
X1NUQVRFLA0KPiA+ICsJCQkgICAgICAgRFBfUFdSX1NUQVRFX0JBTkRHQVBfVFBMTCwNCj4gPiAr
CQkJICAgICAgIERQX1BXUl9TVEFURV9NQVNLKTsNCj4gPiArDQo+ID4gIAkJCW10a19kcC0+bmVl
ZF9kZWJvdW5jZSA9IGZhbHNlOw0KPiA+ICAJCQltb2RfdGltZXIoJm10a19kcC0+ZGVib3VuY2Vf
dGltZXIsDQo+ID4gIAkJCQkgIGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMCkgLSAxKTsN
Cj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQltdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2Rw
LCB0cnVlKTsNCj4gDQo+IFlvdSBwb3dlciBvbiBwYW5lbCBoZXJlLiBJdCBzZWVtcyB0aGF0IGl0
IGRvZXMgbm90IG5lZWQgcG93ZXIgb24gaW4NCj4gYXRvbWljIGVuYWJsZS4gUmlnaHQ/DQo+IElu
IGFkZGl0aW9uLCB3aGVuIHBsdWcgaW4sIHlvdSBwb3dlciBvbiBhdXggYW5kIHBhbmVsLCBidXQg
d2hlbiBwbHVnDQo+IG91dCwgeW91IGp1c3QgcG93ZXIgb2ZmIGF1eC4NCj4gVGhpcyBpcyBub3Qg
c3ltbWV0cmljLiBJIHdvdWxkIGxpa2UgaXQgdG8gYmUgc3ltbWV0cmljLg0KPiANCg0KTm8sIGl0
IG5lZWQgcG93ZXIgb24gZm9yIGVEUCBpbiBhdG9taWMgZW5hYmxlLiBQYXRjaCB1cGRhdGUgaW4g
dGhlDQpzaXh0aCB2ZXJzaW9uLg0KDQpXaGVuIHBsdWcgb3V0LCBwb3dlciBvZmYgYXV4IGFuZCBw
YW5lbCBpbiBhdG9taWMgZGlzYWJsZS4NCg0KPiA+ICsNCj4gPiArCQkJcmV0ID0gbXRrX2RwX3Bh
cnNlX2NhcGFiaWxpdGllcyhtdGtfZHApOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJZHJt
X2VycihtdGtfZHAtPmRybV9kZXYsICJDYW4ndCBwYXJzZQ0KPiA+IGNhcGFiaWxpdGllc1xuIik7
DQo+ID4gKw0KPiA+ICsJCQkvKiBUcmFpbmluZyAqLw0KPiA+ICsJCQlyZXQgPSBtdGtfZHBfdHJh
aW5pbmcobXRrX2RwKTsNCj4gPiArCQkJaWYgKHJldCkNCj4gPiArCQkJCWRybV9lcnIobXRrX2Rw
LT5kcm1fZGV2LCAiVHJhaW5pbmcNCj4gPiBmYWlsZWQsICVkXG4iLCByZXQpOw0KPiA+ICsNCj4g
PiArCQkJbXRrX2RwLT5lbmFibGVkID0gdHJ1ZTsNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0K
PiA+IEBAIC0yMTYxLDE3ICsyMTgxLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fZWRpZA0K
PiA+ICptdGtfZHBfZWRpZF9yZWFkKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ID4gIAl9
DQo+ID4gIA0KPiA+ICAJZHJtX2VkaWQgPSBkcm1fZWRpZF9yZWFkX2RkYyhjb25uZWN0b3IsICZt
dGtfZHAtPmF1eC5kZGMpOw0KPiA+IC0NCj4gPiAtCS8qDQo+ID4gLQkgKiBQYXJzZSBjYXBhYmls
aXR5IGhlcmUgdG8gbGV0IGF0b21pY19nZXRfaW5wdXRfYnVzX2ZtdHMgYW5kDQo+ID4gLQkgKiBt
b2RlX3ZhbGlkIHVzZSB0aGUgY2FwYWJpbGl0eSB0byBjYWxjdWxhdGUgc2luayBiaXRyYXRlcy4N
Cj4gPiAtCSAqLw0KPiA+IC0JaWYgKG10a19kcF9wYXJzZV9jYXBhYmlsaXRpZXMobXRrX2RwKSkg
ew0KPiANCj4gV2hlcmUgZG9lcyBlRFAgcGFyc2UgY2FwYWJpbGl0aWVzPw0KPiBPbmx5IERQIHdv
dWxkIHRyaWdnZXIgaGRwIGV2ZW50IHRocmVhZC4NCj4gDQoNClBhdGNoIHVwZGF0ZSBpbiB0aGUg
c2l4dGggdmVyc2lvbi4NCg0KPiA+IC0JCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiQ2FuJ3Qg
cGFyc2UgY2FwYWJpbGl0aWVzXG4iKTsNCj4gPiAtCQlkcm1fZWRpZF9mcmVlKGRybV9lZGlkKTsN
Cj4gPiAtCQlkcm1fZWRpZCA9IE5VTEw7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+ICAJaWYgKGRybV9l
ZGlkKSB7DQo+ID4gIAkJLyoNCj4gPiAgCQkgKiBGSVhNRTogZ2V0IHJpZCBvZiBkcm1fZWRpZF9y
YXcoKQ0KPiA+IEBAIC0yMzY2LDExICsyMzc1LDEzIEBAIHN0YXRpYyB2b2lkDQo+ID4gbXRrX2Rw
X2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ID4gIA0K
PiA+ICAJbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uKG10a19kcCwgdHJ1ZSk7DQo+ID4gIA0KPiA+
IC0JLyogVHJhaW5pbmcgKi8NCj4gPiAtCXJldCA9IG10a19kcF90cmFpbmluZyhtdGtfZHApOw0K
PiA+IC0JaWYgKHJldCkgew0KPiA+IC0JCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5p
bmcgZmFpbGVkLCAlZFxuIiwgcmV0KTsNCj4gPiAtCQlnb3RvIHBvd2VyX29mZl9hdXg7DQo+ID4g
KwlpZiAobXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQ
KSB7DQo+ID4gKwkJLyogVHJhaW5pbmcgKi8NCj4gPiArCQlyZXQgPSBtdGtfZHBfdHJhaW5pbmco
bXRrX2RwKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWRybV9lcnIobXRrX2RwLT5kcm1f
ZGV2LCAiVHJhaW5pbmcgZmFpbGVkLA0KPiA+ICVkXG4iLCByZXQpOw0KPiA+ICsJCQlnb3RvIHBv
d2VyX29mZl9hdXg7DQo+ID4gKwkJfQ0KPiANCj4gRm9yIERQLCB5b3UgbW92ZSB0cmFpbmluZyB0
byBoZHAgZXZlbnQgdGhyZWFkLg0KPiBJbiB5b3UgY29tbWl0IG1lc3NhZ2UsIEkgY291bGQgbm90
IHVuZGVyc3RhbmQgd2h5IGRvIHRoaXMuDQo+IERvZXMgdGhpcyBpcyB0aW1pbmcgcHJvYmxlbT8N
Cj4gSWYgdGhpcyBpcyBhIHRpbWluZyBwcm9ibGVtLCBJIHdvdWxkIGxpa2UgeW91IHRvIGRlc2Ny
aWJlIHdoYXQncw0KPiB3cm9uZyBpbiB0aW1pbmcuDQo+IA0KPiBGb3IgZXhhbXBsZSwgdGhpcyBp
cyBhIHRpbWUgc2VxdWVuY2UgDQo+IA0KPiAxLiBwbHVnIGluIHBhbmVsIEENCj4gMi4gYXRvbWlj
IGVuYWJsZSAodHJhaW5pbmcpDQo+IDMuIHBsdWcgb3V0IHBhbmVsIEENCj4gNC4gcGx1ZyBpbiBw
YW5lbCBCDQo+IA0KPiBCdXQgcGFuZWwgQiBkb2VzIG5vdCB0cmFpbmluZyBhZ2Fpbiwgc28gdGhp
cyBwYXRjaCBtYWtlIGl0IGFzDQo+IA0KPiAxLiBwbHVnIGluIHBhbmVsIEEgKHRyYWluaW5nKQ0K
PiAyLiBhdG9taWMgZW5hYmxlDQo+IDMuIHBsdWcgb3V0IHBhbmVsIEENCj4gNC4gcGx1ZyBpbiBw
YW5lbCBCICh0cmFpbmluZykNCj4gDQo+IElmIGl0IGlzIHRoaXMgY2FzZSwgYWRkIHRoaXMgaW5m
b3JtYXRpb24gdG8gY29tbWl0IG1lc3NhZ2UuDQo+IElmIGl0IGlzIG5vdCB0aGlzIGNhc2UsIHRy
eSB0byBsZXQgbWUgdW5kZXJzdGFuZCB3aHkgbW92aW5nIHRyYWluaW5nDQo+IHRpbWluZyB3b3Vs
ZCBoZWxwIGFkanVzdCBiYW5kd2lkdGggbGltaXQuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiAN
Cg0KRm9yIGV4YW1wbGUsIHRoZSBwbGF0Zm9ybSBzdXBwb3J0IERQIDRsYW5lIDUuNEcsDQpidXQg
cGFuZWwgQSBzdXBwb3J0IERQIDJsYW5lIDUuNEcuDQoNClRoaXMgaXMgYSB0aW1lIHNlcXVlbmNl
Og0KDQoxLiBQbHVnIGluIHBhbmVsIEEuIEFjY29yZGluZyB0byB0aGUgcGxhdGZvcm0sIGl0IGNh
biBvdXRwdXQgNEsgNjBIei4NCjIuIFRpbWluZyBtb2RlIHNldCA0SyA2MEh6Lg0KMy4gQXRvbWlj
IGVuYWJsZShCYXNlZCBvbiBwYW5lbCBBIGFiaWxpdHksIHRyYWluaW5nIHBhc3MgMmxhbmUgNS40
RykuDQo0LiBGaW5hbGx5LCBkdWUgdG8gMmxhbmUgNS40RyBiYW5kd2lkdGggbGltaXRhdGlvbiwg
dGhlIHBsYXRmb3JtIGNhbm5vdA0Kb3V0cHV0IDRLIDYwSHosIHJlc3VsdGluZyBpbiBhIGJsYWNr
IHNyZWVuLg0KDQpJZiBhcHBseSB0aGlzIHBhdGNoLg0KDQoxLiBQbHVnIGluIHBhbmVsIEEuDQoy
LiBUcmFpbmluZyBwYXNzIDJsYW5lIDUuNEcNCjMuIFRpbWluZyBtb2RlIHNldCAySyA2MEh6KEJh
c2VkIG9uIHRoZSAybGFuZSA1LjRHIGJhbmR3aWR0aCBsaW1pdCkuDQo0LiBBdG9taWMgZW5hYmxl
IGZvciBvdXRwdXQgc2NyZWVuLg0KDQpCZXN0IFJlZ2FyZHMsDQpMaWFua3VuDQoNCj4gPiAgCX0N
Cj4gPiAgDQo+ID4gIAlyZXQgPSBtdGtfZHBfdmlkZW9fY29uZmlnKG10a19kcCk7DQo+ID4gQEAg
LTIzOTAsNyArMjQwMSw2IEBAIHN0YXRpYyB2b2lkDQo+ID4gbXRrX2RwX2JyaWRnZV9hdG9taWNf
ZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ID4gIAkJICAgICAgIHNpemVvZiht
dGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZykpOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCW10a19k
cC0+ZW5hYmxlZCA9IHRydWU7DQo+ID4gIAltdGtfZHBfdXBkYXRlX3BsdWdnZWRfc3RhdHVzKG10
a19kcCk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuOw0KPiA+IEBAIC0yNDA1LDcgKzI0MTUsNiBAQCBz
dGF0aWMgdm9pZA0KPiA+IG10a19kcF9icmlkZ2VfYXRvbWljX2Rpc2FibGUoc3RydWN0IGRybV9i
cmlkZ2UgKmJyaWRnZSwNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19kcCAqbXRrX2RwID0gbXRr
X2RwX2Zyb21fYnJpZGdlKGJyaWRnZSk7DQo+ID4gIA0KPiA+IC0JbXRrX2RwLT5lbmFibGVkID0g
ZmFsc2U7DQo+ID4gIAltdGtfZHBfdXBkYXRlX3BsdWdnZWRfc3RhdHVzKG10a19kcCk7DQo+ID4g
IAltdGtfZHBfdmlkZW9fZW5hYmxlKG10a19kcCwgZmFsc2UpOw0KPiA+ICAJbXRrX2RwX2F1ZGlv
X211dGUobXRrX2RwLCB0cnVlKTsNCj4gDQo+IA0KDQoNCg==

