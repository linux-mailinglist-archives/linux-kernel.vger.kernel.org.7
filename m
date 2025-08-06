Return-Path: <linux-kernel+bounces-757262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F4EB1C001
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3DA3BA748
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECD1F2B8D;
	Wed,  6 Aug 2025 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="om5NL1aN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QoN2YmI5"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939A1805A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458939; cv=fail; b=X+DccwqtTiSmbyEnhVDoG4kkRQxNy0ujaubUpSTCfwYM6QbAuGO8PC4ajyMhZjX75N4puYapUQKrfnq8bgub6EZqcyPM5liNjpMPrSM43rgeB+eAe4nWSBeZxSnmOJlo5mnZ48qdEFtl0oeqw/6V69B2K8+awOnL2gImQtwXtuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458939; c=relaxed/simple;
	bh=JW6tVuIyZ1MbjwQnJ3KpsYTY9hjHxce0jGaETRCPLvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tV6RaUiaXSP4yY0Gi36rZhjMsIrc0WRPq9cWld71JhDZDpNRl6EDU1ELQpvHnpOITzaOB2Yw/c/YuPqzruPjf1OgAvtKgHMu/Jx6V/A9Wpz9qGBckEdI5ZfFxVyZlsNhTbjbMEbL00eTWzSeqDIvIUDGpYS9e0MbMMKURdtKoqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=om5NL1aN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QoN2YmI5; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 15622850728811f0b33aeb1e7f16c2b6-20250806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JW6tVuIyZ1MbjwQnJ3KpsYTY9hjHxce0jGaETRCPLvs=;
	b=om5NL1aNhB/wauuaRzGXzyzEhe0dkbDrHXiIPYRK0bYQTHSzn9bCFusQtxY4DL7R8VRN/2VKu/Dsxsw+IadOICvw0Ld9tf2oBy+vTnY7TaKDfxCMfLrz0T6MyrpWKYhDZ8HcdVq3yl9zbiCoiKxXQYqU++93t3t6mfEptB/zRJo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:c3cb78f6-b1c5-4927-aabb-431799f16104,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:40568f0f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 15622850728811f0b33aeb1e7f16c2b6-20250806
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1438815798; Wed, 06 Aug 2025 13:42:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 6 Aug 2025 13:42:03 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 6 Aug 2025 13:42:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtmbSibLdgNozbtw2JheuVM8VE7bMe8kEwF6AeUjIx904yKEmQyB4ysw2nNdifWf6hpyJStcWgRq+kKBaQxPB4IpeEUtdbnFrmiM2JzVAp/u7LTxUJjZSJ/Rq1qrpoOw+eVqZmp/pXh65CGGwCx+efMDgH7Y1OQ/Th34ixUOsC6cqM0NLxlEAEMz7aeniiYar0XvIpkjMdbIl5xTJDsiLBaqCocFJTly8v+DbAsc2Jeq/zj7ONXuXq5v5VAU2MdPA9bgW976fC7hQRj76vbS7NScZnFQKgA0gVJeoOeM8trpgC4xNqM4Tp+Sr/TmGzCeQ0xS2MJ9vim5Vq+MKTr1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JW6tVuIyZ1MbjwQnJ3KpsYTY9hjHxce0jGaETRCPLvs=;
 b=GR3YVJvlFaKOuHZFBE3yu0zjP4HAqL2bVTG6KNPbmg53Cr5WQXh1LAxcztASN/M08ZjorJYuSc5lUk2QBL7BG458Csp9IGOLLjzOfsVpJHXel3p2qWOtpGoYBRPVw+x7kdEUBHOv9OaNPFI1haTgde6vSiS/3Sxt9mJPvq1ZaQat9QDTK1u/KyOxBQSIIhGWfFNnJAd2+WUn/SzXdIxqegDG4/UxImj58Z/j6TIgBduIo0bzdfRPmPiPlCXfQaiWGuM2v+2mhOnaLLhhXFjUPn31qCOCDf18xtmW6sOGZyu5pzmAOF/930onTgFE3L8C1PKVqfdgkXktwQd0/TV9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JW6tVuIyZ1MbjwQnJ3KpsYTY9hjHxce0jGaETRCPLvs=;
 b=QoN2YmI5mJnB4GWO3VYaxvwjx/bSCo9GxUWsWjtFLlCtN6LBro3gQmw+N10GJHQ9136FlvbzKR/4IKZd2E218TIpRtW0wa2C0CoZNTtJevmXQgucEyyA9K4g3I/b0Z1Ll3mfzCc/hpwY55TE7QmH62Af9znd/Ikiql/rxaPKNq0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6583.apcprd03.prod.outlook.com (2603:1096:400:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 05:42:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 05:41:59 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "simona@ffwll.ch" <simona@ffwll.ch>, =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?=
	<Mac.Shen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?UGVuZyBMaXUgKOWImOm5jyk=?= <Peng.Liu@mediatek.com>,
	=?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Topic: [PATCH v5 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Index: AQHb6ZZD8K4/srEgLEigal7ciiaFp7RVVnqA
Date: Wed, 6 Aug 2025 05:41:59 +0000
Message-ID: <d97b4f6790bd5ab3dfb0e32d015d65273cef1078.camel@mediatek.com>
References: <20250630080824.7107-1-liankun.yang@mediatek.com>
In-Reply-To: <20250630080824.7107-1-liankun.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6583:EE_
x-ms-office365-filtering-correlation-id: 2d770855-7ccc-4999-088e-08ddd4abf688
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|42112799006|1800799024|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?VUxJS1p2S2IyaXZBOHZVV29Kbk5rRnlONU5XRFJ0emltYm90dzZ1VDFpektp?=
 =?utf-8?B?TEZNOUlBeWxtdGNvYjdFb2lrTTgvMVpyejNoN3JCUHpTcFd1RVkvdThxSjBL?=
 =?utf-8?B?NlRkOHN6MjVxYnFJS2J1VUM3YjRuY0V2cU41VlJ6eHAxNm12QVZRcndzWjMy?=
 =?utf-8?B?QlNOVnMwNTVUZ3ZOZkJGTDd3bTNMcWlyT2g1VXE4TWFiM1JSUlN6K3NhcVBl?=
 =?utf-8?B?ZFd4RUt6UkU4UXFaYVVMQkU2Si9LbVk4Rms0MDcyNnFLdVFheWNwTkRGS2x0?=
 =?utf-8?B?L2VVY2lka3orOEkxQk04WEFwZktUVXVkOTRBWkFDSVVMZDRnVXZSeFIrWnJ3?=
 =?utf-8?B?cVVzYkEvdzZIbTNRTmpuRjFQMG82M1BoZVl4dUNzMk00VGlLQko1SkJ6NU1s?=
 =?utf-8?B?RTFmZzB1ejBzeDBKUXVReWlPUXZDOGxvbG4zSnkyR29KTjRJelFGck9hcXp0?=
 =?utf-8?B?SHdEMkJzMjdJNWw1K2dMTmZmMlBlWGR1aHlRM005K0ttUlRRQWdmVC9TNVpB?=
 =?utf-8?B?SFNVc2pmbmZhZkV1Yk1kZHpDWjhKVUFTS0tlYWgza1ZyZFBmNWlXZGRZM1Zn?=
 =?utf-8?B?TGcxZVpETURyVG5TUURDNmdNN0FQWnFySzA4alVPbTBhNXBzNlFhbGpScWxs?=
 =?utf-8?B?TzJ6dHJkZDNuQ0dNRGZacU9UY0JCWUFqNjF2VDlGUEkyaVNyOHpOZkYzRnU5?=
 =?utf-8?B?UjNINVFVZ25sU1liTVJyMkJPQnkzcUsxTG1kNkVSY0ZvUUVrZHVpSUtCM1o2?=
 =?utf-8?B?L05CWnp6UU1ScElOTzRISTRSeGQwZHA0eFVsTWI3ZndUQzNVRFhFbXRxRUxw?=
 =?utf-8?B?WkNNVmc3YTVZQkxSYVBraTZQWFVHaUtuOU5sUkpFOExGMkFyWmFTbEQ3Z1kv?=
 =?utf-8?B?YmZobXdERjZQaEZLV2UvdWhTTFZTcHh6RGxMalF6QXJxY1JJb2hYOTNSZVdW?=
 =?utf-8?B?UFNkK0J4ZnBHQ2V5VGZOWXJXdmpTcTNZVmJOQW0rY0NqUmc5L1I3eTR6SStF?=
 =?utf-8?B?b0c2WmxsWFR4bTlnSzgvYmdWQ3h2TkdYaHRRV2F2Q01DVmxyelJWekg0cXAr?=
 =?utf-8?B?cGVMM0NSUXdpbWxZZFhheXNyWFJwVWVhU2ErMFZVOEh5RnNqdTJqMER0aFFp?=
 =?utf-8?B?RVhsYkw1cytMNjFTelk1d3I4RnY3aVRDN2RISElFTVlWR2p5TUpDUEhsR3FU?=
 =?utf-8?B?eEVHWHBFM0hmcGNvZEc4U1AvMFZETGtReTB3OUxCSUc1Z1lFbkpBWmFBOFJ3?=
 =?utf-8?B?NGJJOW9zcnhaWWxWQzVVZkhObHRNWnhhRjNNb0ZzNmcweFk1bUtSQmlERlBY?=
 =?utf-8?B?OG85Wk5nV0FHSDNCcEFUbWU0VEtiZFhBK2R6L2Z3aG1nODkwS25lK2JPMWZi?=
 =?utf-8?B?MmVTTmc0elovN1d4LzdYYlQrQTEzNW9IUlZoZFl4WXJLUFV6eXdYSTlMMUJQ?=
 =?utf-8?B?SGVuNkFicFNnVUdtK3pPK2VJSEZjTzMzN3ZvOHFGU2RNdFN6WU9oQUZ3SUJX?=
 =?utf-8?B?MGFwdm12UXFmNEljUHVKcVJvNThzRmJFemx6MCsxUDJyeDVMQWZ1TkVDZ3NT?=
 =?utf-8?B?dG80cHFRamp5cTE2ZFZaSmVTZG5LR1BjK280K0pLVktSWUlJdzVzT0plSmZV?=
 =?utf-8?B?YU16K2dmVmtrcFNRRjVPSmV1SEc3NnBISnhtRjdvTEpyclZtTWg5QmJRNXdR?=
 =?utf-8?B?MXRiU1M0ZWc5TXU5NGJoclY2TVNZaDNZbU5UMHZlcGE5dStKM0ozM3drK2Vr?=
 =?utf-8?B?SjVNUkJoeks4cFRKV0lHdGFUcnp4WHR0Q0UvdUV4ME5tRWNURW9vVzVoZEdD?=
 =?utf-8?B?UGFjN3lpOUVqb3VqT0lRdU5hREpRU0l4Nlc0RUtIdTBMQXd2RjJNOTJDbnpk?=
 =?utf-8?B?WkJlUEg1U0lCTU16VUZ4VUwvTE9qekpXVEgza2tPSDd2WU5GM3VMYUc5Rnkz?=
 =?utf-8?B?TTJBRXdkUXpNenR6NU9pQXFsQkdwSlExWkRjUHBZMmZ1bW1hTS9hZEdZWTll?=
 =?utf-8?B?UjYxMEhvUW5jRkVRc3VDUHNPSHNMOEcyY3owVTV0c3dCVVFLRmcvSXNLd2dq?=
 =?utf-8?Q?2cN+Ce?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(42112799006)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGNaWVN4SlBaM3BMM2NJU0haN1BIZGxvdzlvWEdtVzRUZmdiYW1GMzd2RkVy?=
 =?utf-8?B?VVBPZDRDZWVHdG9YeXNNMDJJK1pqSmhjMWFCenRtbWRsNHhpZjE1NHNteG4r?=
 =?utf-8?B?VXU5aHVzZmtjc2VRTTB4VjhPbmNmakxlSUNvV3JjdlJwbFVaLzhVeFlVZTd2?=
 =?utf-8?B?aDdPZFpCYm51L2ZLeUJ3SXM5cUlGam1ac2VpdXl2OFlsNDhYaU13cDJGSXlS?=
 =?utf-8?B?MVRkc1VGZER3WTVDaGpYQjV2aFpVK3hOdmJEeDJHVFVRZDBCMUJScWVMVEpU?=
 =?utf-8?B?cTlGSjdIRTNieFhPazM2S2ZFL2VXRGdRZFBMMDdSRjErNGZyOXVKV3djMFJ5?=
 =?utf-8?B?TGVmK0JGZTE1Ky9FRnVWZnBYVmJjQk5semxxcUtWcjFpOFRTZ3Z4c2NKV0gv?=
 =?utf-8?B?cnRwbVkrd2ptaXFYeWZvTHMycFZnVHcvSkRJelFxUG9iRWVETWxyL1lrNmRD?=
 =?utf-8?B?MmlxNWk5TFk2cXNzQlNqdEtVbUQ2YTZCWUk0QkNYazUzVGs1c3FPdGs4cUha?=
 =?utf-8?B?U0xWTkxjdXFlay9aQk4venMwZWs5NnprUUl5RUJzUjBJeVZZWlhFUGJWMmRk?=
 =?utf-8?B?KzBvVzZCNzdndk1Tc2NYRnlRRFk4aGlVaTlPZHRKYitnNHd1T21OK3hFeEQy?=
 =?utf-8?B?eWFSNStHMTViaWNoVlFxMFdNZVQ4N0VWMUVsNkZkd1hveklFOHdMSXlsY0hO?=
 =?utf-8?B?TDJwMm9UMXJ6dS9BUHRkUzdxQ3o3TUdkTi9ZcWVXNHQ4alhaWmNGYkJ6SjRU?=
 =?utf-8?B?OW4zTURoN0N1aHpBU1MrN3QyMGlQYitJM0pwTXRRR1AzenFUL1BoaVM4RUFa?=
 =?utf-8?B?bndNeVlzelhkbmVuVWFLQXJtMjl4VnZRdytpdUx0Q2p4QVRGNnlBRFNuQkxJ?=
 =?utf-8?B?cUJQL2VqWmtYdnlXbWNlTHRZK1BFQk9mZUtJOXBsNThHeE84bG1adWpNbzZw?=
 =?utf-8?B?aVY4QldzU0ZXN0RHV2tSdHlveTJEQW0vMHJnVTR2VFNNQWNBOVJzNEVWSTQx?=
 =?utf-8?B?RGplZ3RaSUhiQ0JyQnd6UXkzSUJJQitFNHBRSVk0cnU4WEl0QmlMV3NXK3k2?=
 =?utf-8?B?RjZ6WkhTdlpPOHlrREg5OWpSRGdwZWNZWVlIQ0R0Ym5EUlBrTjFNMFJSeXBt?=
 =?utf-8?B?dWZIZXplcXc5aDlWMGtUQ3h4WDdXUnFxeDY3cDltazlZTDZFTHpsTnVYVTFE?=
 =?utf-8?B?UU9teUVuWGtUMVhOeTdPUGI1bzZ0OE1QVHk0WnVWc2JnL0hrSTBYRVg3Nmlx?=
 =?utf-8?B?TUJNUUhTUWUzd0hqeWU4dXl6YzlDYytrQ3pNUmtHaVRGNktScmxsc1pVMTl6?=
 =?utf-8?B?L05jQjRCdWhPdTFRNEJzZ0tmMnRLNjJlclJSWGxkZXVqdzl5dmppZFo1SWVR?=
 =?utf-8?B?YkRZTzFsY3NGNDRFY3NGSG9FRkZWbDVVRDR3ZEdrUldUUVJLYm5JdHdUbGkv?=
 =?utf-8?B?TkJwdzFjaWlQK2JMUU5TNE1OVHY3TG1HY0RnZXNyS2Q5UkduaDN0WnM4SGVy?=
 =?utf-8?B?TlJwZEhXM0pqK0M3RjRXRnJvM3pXRjRCRmZBYmlmeVUvVkpNbjR6V1hnVU9M?=
 =?utf-8?B?ckZCOTEybGNEZTQzQmZNSlJNVCtsQ0t4ZWJTMUdDTFlBeFN4cHRrRHdYZmZ0?=
 =?utf-8?B?N0lBOG1XTTVGUlJnTCtnUVgvZjQzYVlhSVZDR1c5Qkk2eUVDNWpVcXI4a09Y?=
 =?utf-8?B?bkw1Nlo0RGxOdUtoQ0dXc1ZxcFlnaXNuZ1pWLysvSXBLUTBCNkpDejlNNUpC?=
 =?utf-8?B?UDlUU25LTGFXZGVRVGFqa08zUEd5dFpOZDkyb3NiM3hzSVBDSUw0TGM4WWRY?=
 =?utf-8?B?WGFYWTNiYUN4clpUTTMxSEQ1dURTaC9uSXZjQXZrMG9XcmtJaElBVzdUdWFG?=
 =?utf-8?B?c3h2S1NSS0JOQjFFTnhNdk91NlRpS3NBT3JOQzVkVHR3TDZLM0RFem9jN1RX?=
 =?utf-8?B?M1RlWG94WGFCZHFyeldSWHhXbS9xS2tWRzAzTUNCL2lET2RmdklWMHpuYUp3?=
 =?utf-8?B?OGdNMktnZ3N5RnYvOGFiZCsrNUx3dUlTVGFGczEvcUxWWHpQOHpWVUNlMldH?=
 =?utf-8?B?dmdaS3lIZDVGK1VqWEFaMWNhMXkwdHFkRFhmbXJRT3NadGxOWGNHODAxcmdL?=
 =?utf-8?Q?7a5kF1WlZMhOfhcNeQfD4bQeT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6877C46D9A6EF4B80A96BA1E21A133C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d770855-7ccc-4999-088e-08ddd4abf688
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 05:41:59.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+0CvMsGY9ekOq+lgjwufkAj35awaeR9kb94OWREipzlgkxj/McB7YYAsr6QPHIi1g5DXzsWX9f8EhNeXWvI8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6583

T24gTW9uLCAyMDI1LTA2LTMwIGF0IDE1OjU4ICswODAwLCBMaWFua3VuIFlhbmcgd3JvdGU6DQo+
IEJ5IGFkanVzdGluZyB0aGUgb3JkZXIgb2YgbGluayB0cmFpbmluZyBhbmQgcmVsb2NhdGluZyBp
dCB0byBIUEQsDQo+IGxpbmsgdHJhaW5pbmcgY2FuIGlkZW50aWZ5IHRoZSB1c2FiaWxpdHkgb2Yg
ZWFjaCBsYW5lIGluIHRoZSBjdXJyZW50IGxpbmsuDQo+IA0KPiBJdCBhbHNvIHN1cHBvcnRzIGhh
bmRsaW5nIHNpZ25hbCBpbnN0YWJpbGl0eSBhbmQgd2Vha25lc3MgZHVlIHRvDQo+IGVudmlyb25t
ZW50YWwgaXNzdWVzLCBlbmFibGluZyB0aGUgYWNxdWlzaXRpb24gb2YgYSBzdGFibGUgYmFuZHdp
ZHRoDQo+IGZvciB0aGUgY3VycmVudCBsaW5rLiBTdWJzZXF1ZW50bHksIERQIHdvcmsgY2FuIHBy
b2NlZWQgYmFzZWQgb24NCj4gdGhlIGFjdHVhbCBtYXhpbXVtIGJhbmR3aWR0aC4NCj4gDQo+IEl0
IHNob3VsZCB0cmFpbmluZyBpbiB0aGUgaHBkIGV2ZW50IHRocmVhZC4NCj4gQ2hlY2sgdGhlIG1v
ZGUgd2l0aCBsYW5lIGNvdW50IGFuZCBsaW5rIHJhdGUgb2YgdHJhaW5pbmcuDQo+IA0KPiBJZiB3
ZSdyZSBlRFAgYW5kIGNhcGFiaWxpdGllcyB3ZXJlIGFscmVhZHkgcGFyc2VkIHdlIGNhbiBza2lw
DQo+IHJlYWRpbmcgYWdhaW4gYmVjYXVzZSBlRFAgcGFuZWxzIGFyZW4ndCBob3RwbHVnZ2FibGUg
aGVuY2UgdGhlDQo+IGNhcHMgYW5kIHRyYWluaW5nIGluZm9ybWF0aW9uIHdvbid0IGV2ZXIgY2hh
bmdlIGluIGEgYm9vdCBsaWZlDQo+IA0KPiBUaGVyZWZvcmUsIGJyaWRnZSB0eXBlYyBqdWRnbWVu
dCBpcyByZXF1aXJlZCBmb3IgZWRwIHRyYWluaW5nIGluDQo+IGF0b21pY19lbmFibGUgZnVuY3Rp
b24uDQo+IA0KPiBCZWNhdXNlIERQIHdpbGwgZW50ZXIgaWRsZSBwYXR0ZXJuIHN0YXRlIGFmdGVy
IERQIHRyYWluaW5nLHRoZSBjdXJyZW50DQo+IERQIGxpbmsgc3RhdGUgaXMgcmVhZHkgYW5kIGNh
biBiZSBwcmVwYXJlZCB0byBvdXRwdXQgdGhlIHZpZGVvLg0KPiBUaGVyZWZvcmUsIHRoZSBmb2xs
b3dpbmcgYWN0aW9ucyBkbyBub3QgcmVxdWlyZSB0aGUgd2FsbC1tb3VudGVkDQo+IGF1eF9wYW5l
bCBwb3dlciwgYW5kIHNldCBEUCBlbmFibGUgdG8gdHJ1ZS4NCg0KSW4gdjQsIE5pY29sYXMgaGFz
IHBvaW50IG91dCB0aGF0IERQIGhhcyBhbHJlYWR5IGJyb2tlbi4NCkRvZXMgdGhpcyBwYXRjaCBm
aXggdGhlIGJyb2tlbj8NCklmIHRoaXMgcGF0Y2ggZG9lcyBub3QgZml4IHRoZSBicm9rZW4sIEkg
d291bGQgbGlrZSB5b3UgdG8gZml4IHRoZSBicm9rZW4gZmlyc3QgdGhlbiBhcHBseSB0aGlzIHBh
dGNoLg0KSWYgeW91IGRvZXMgbm90IHNlZSB0aGUgYnJva2VuIHByb2JsZW0sIHRyeSB0byBkaXNj
dXNzIHdpdGggTmljb2xhcyBhbmQgaGVscCBoaW0gdG8gZml4IGl0Lg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMaWFua3VuIFlhbmcgPGxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20+DQo+IC0tLQ0K
PiBDaGFuZ2UgaW4gVjU6DQo+IC0gRml4ZWQgdGhlIGlzc3VlIHRoYXQgdGhlIDR0aCB2ZXJzaW9u
IG9mIHRoZSBwYXRjaCBjYXVzZWQgRFAgdG8gaGF2ZSBubyBzY3JlZW4uDQo+IFBlciBzdWdnZXN0
aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9w
YXRjaC8yMDI1MDYyNTA5NTQ0Ni4zMTcyNi0xLWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187
ISFDVFJOS0E5d01nMEFSYnchanFneHc5LUVqMUFWTi15R3B4MmhPbTRxMnR6NHA2QWlGQWNWWEd1
RVRncGR0dEFsbWVJWFNxc1F4NTYzZ1NlSjc3TWx2OXNWalRBRktSZlNwS25qWEpZJCANCj4gDQo+
IENoYW5nZSBpbiBWNDoNCj4gLSBUZXN0ZWQgdGhlIGludGVybmFsIGVEUCBkaXNwbGF5IG9uIE1U
ODE5NSBUb21hdG8gYW5kIGl0IGlzIGZpbmUuDQo+IFBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHBy
ZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI1MDMxODE0
MDIzNi4xMzY1MC0yLWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFS
YnchanFneHc5LUVqMUFWTi15R3B4MmhPbTRxMnR6NHA2QWlGQWNWWEd1RVRncGR0dEFsbWVJWFNx
c1F4NTYzZ1NlSjc3TWx2OXNWalRBRktSZlMwNWM5Zko0JCANCj4gDQo+IENoYW5nZSBpbiBWMzoN
Cj4gLSBSZW1vdmUgJ210a19kcC0+ZW5hYmxlZCA9IGZhbHNlIiBpbiBhdG9taWMgZGlzYWJsZS4N
Cj4gLSBSZW1vdmUgJ210a19kcC0+ZW5hYmxlZCA9IHRydWUiIGluIGF0b21pYyBlbmFibGUuDQo+
IFBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9wYXRjaC8yMDI0MTAyNTA4MzAzNi44ODI5LTQtbGlhbmt1bi55YW5nQG1lZGlh
dGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFqcWd4dzktRWoxQVZOLXlHcHgyaE9tNHEydHo0
cDZBaUZBY1ZYR3VFVGdwZHR0QWxtZUlYU3FzUXg1NjNnU2VKNzdNbHY5c1ZqVEFGS1JmU0VSOEt1
UmMkIA0KPiANCj4gQ2hhbmdlIGluIFYyOg0KPiAtIEFkanVzdCBEUCB0cmFpbmluZyB0aW1pbmcu
DQo+IC0gQWRqdXN0IHBhcnNlIGNhcGFiaWxpdGllcyB0aW1pbmcuDQo+IC0gQWRkIHBvd2VyIG9u
L29mZiBmb3IgY29ubmVjdC9kaXNjb25uZWN0Lg0KPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBw
cmV2aW91cyB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDAzMTUw
MTUyMzMuMjAyMy0xLWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFS
YnchanFneHc5LUVqMUFWTi15R3B4MmhPbTRxMnR6NHA2QWlGQWNWWEd1RVRncGR0dEFsbWVJWFNx
c1F4NTYzZ1NlSjc3TWx2OXNWalRBRktSZlNRaVFUU080JCANCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA0NSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IGluZGV4IGE1YjEwYjI1NDVkYy4u
MTAxMDI2M2YyNTEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+IEBAIC0x
OTc2LDYgKzE5NzYsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2RwX2hwZF9ldmVudF90aHJl
YWQoaW50IGhwZCwgdm9pZCAqZGV2KQ0KPiAgCXN0cnVjdCBtdGtfZHAgKm10a19kcCA9IGRldjsN
Cj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAgCXUzMiBzdGF0dXM7DQo+ICsJaW50IHJldDsN
Cj4gIA0KPiAgCWlmIChtdGtfZHAtPm5lZWRfZGVib3VuY2UgJiYgbXRrX2RwLT50cmFpbl9pbmZv
LmNhYmxlX3BsdWdnZWRfaW4pDQo+ICAJCW1zbGVlcCgxMDApOw0KPiBAQCAtMTk5NCw5ICsxOTk1
LDI4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfZHBfaHBkX2V2ZW50X3RocmVhZChpbnQgaHBk
LCB2b2lkICpkZXYpDQo+ICAJCQltZW1zZXQoJm10a19kcC0+aW5mby5hdWRpb19jdXJfY2ZnLCAw
LA0KPiAgCQkJICAgICAgIHNpemVvZihtdGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZykpOw0KPiAg
DQo+ICsJCQltdGtfZHAtPmVuYWJsZWQgPSBmYWxzZTsNCj4gKwkJCS8qIHBvd2VyIG9mZiBhdXgg
Ki8NCj4gKwkJCW10a19kcF91cGRhdGVfYml0cyhtdGtfZHAsIE1US19EUF9UT1BfUFdSX1NUQVRF
LA0KPiArCQkJICAgICAgIERQX1BXUl9TVEFURV9CQU5ER0FQX1RQTEwsDQo+ICsJCQkgICAgICAg
RFBfUFdSX1NUQVRFX01BU0spOw0KPiArDQo+ICAJCQltdGtfZHAtPm5lZWRfZGVib3VuY2UgPSBm
YWxzZTsNCj4gIAkJCW1vZF90aW1lcigmbXRrX2RwLT5kZWJvdW5jZV90aW1lciwNCj4gIAkJCQkg
IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMCkgLSAxKTsNCj4gKwkJfSBlbHNlIHsNCj4g
KwkJCW10a19kcF9hdXhfcGFuZWxfcG93ZXJvbihtdGtfZHAsIHRydWUpOw0KDQpZb3UgcG93ZXIg
b24gcGFuZWwgaGVyZS4gSXQgc2VlbXMgdGhhdCBpdCBkb2VzIG5vdCBuZWVkIHBvd2VyIG9uIGlu
IGF0b21pYyBlbmFibGUuIFJpZ2h0Pw0KSW4gYWRkaXRpb24sIHdoZW4gcGx1ZyBpbiwgeW91IHBv
d2VyIG9uIGF1eCBhbmQgcGFuZWwsIGJ1dCB3aGVuIHBsdWcgb3V0LCB5b3UganVzdCBwb3dlciBv
ZmYgYXV4Lg0KVGhpcyBpcyBub3Qgc3ltbWV0cmljLiBJIHdvdWxkIGxpa2UgaXQgdG8gYmUgc3lt
bWV0cmljLg0KDQo+ICsNCj4gKwkJCXJldCA9IG10a19kcF9wYXJzZV9jYXBhYmlsaXRpZXMobXRr
X2RwKTsNCj4gKwkJCWlmIChyZXQpDQo+ICsJCQkJZHJtX2VycihtdGtfZHAtPmRybV9kZXYsICJD
YW4ndCBwYXJzZSBjYXBhYmlsaXRpZXNcbiIpOw0KPiArDQo+ICsJCQkvKiBUcmFpbmluZyAqLw0K
PiArCQkJcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+ICsJCQlpZiAocmV0KQ0KPiAr
CQkJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiVHJhaW5pbmcgZmFpbGVkLCAlZFxuIiwgcmV0
KTsNCj4gKw0KPiArCQkJbXRrX2RwLT5lbmFibGVkID0gdHJ1ZTsNCj4gIAkJfQ0KPiAgCX0NCj4g
IA0KPiBAQCAtMjE2MSwxNyArMjE4MSw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2VkaWQg
Km10a19kcF9lZGlkX3JlYWQoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gIAl9DQo+ICAN
Cj4gIAlkcm1fZWRpZCA9IGRybV9lZGlkX3JlYWRfZGRjKGNvbm5lY3RvciwgJm10a19kcC0+YXV4
LmRkYyk7DQo+IC0NCj4gLQkvKg0KPiAtCSAqIFBhcnNlIGNhcGFiaWxpdHkgaGVyZSB0byBsZXQg
YXRvbWljX2dldF9pbnB1dF9idXNfZm10cyBhbmQNCj4gLQkgKiBtb2RlX3ZhbGlkIHVzZSB0aGUg
Y2FwYWJpbGl0eSB0byBjYWxjdWxhdGUgc2luayBiaXRyYXRlcy4NCj4gLQkgKi8NCj4gLQlpZiAo
bXRrX2RwX3BhcnNlX2NhcGFiaWxpdGllcyhtdGtfZHApKSB7DQoNCldoZXJlIGRvZXMgZURQIHBh
cnNlIGNhcGFiaWxpdGllcz8NCk9ubHkgRFAgd291bGQgdHJpZ2dlciBoZHAgZXZlbnQgdGhyZWFk
Lg0KDQo+IC0JCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiQ2FuJ3QgcGFyc2UgY2FwYWJpbGl0
aWVzXG4iKTsNCj4gLQkJZHJtX2VkaWRfZnJlZShkcm1fZWRpZCk7DQo+IC0JCWRybV9lZGlkID0g
TlVMTDsNCj4gLQl9DQo+IC0NCj4gIAlpZiAoZHJtX2VkaWQpIHsNCj4gIAkJLyoNCj4gIAkJICog
RklYTUU6IGdldCByaWQgb2YgZHJtX2VkaWRfcmF3KCkNCj4gQEAgLTIzNjYsMTEgKzIzNzUsMTMg
QEAgc3RhdGljIHZvaWQgbXRrX2RwX2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJp
ZGdlICpicmlkZ2UsDQo+ICANCj4gIAltdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0
cnVlKTsNCj4gIA0KPiAtCS8qIFRyYWluaW5nICovDQo+IC0JcmV0ID0gbXRrX2RwX3RyYWluaW5n
KG10a19kcCk7DQo+IC0JaWYgKHJldCkgew0KPiAtCQlkcm1fZXJyKG10a19kcC0+ZHJtX2Rldiwg
IlRyYWluaW5nIGZhaWxlZCwgJWRcbiIsIHJldCk7DQo+IC0JCWdvdG8gcG93ZXJfb2ZmX2F1eDsN
Cj4gKwlpZiAobXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1Jf
ZURQKSB7DQo+ICsJCS8qIFRyYWluaW5nICovDQo+ICsJCXJldCA9IG10a19kcF90cmFpbmluZyht
dGtfZHApOw0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlkcm1fZXJyKG10a19kcC0+ZHJtX2Rldiwg
IlRyYWluaW5nIGZhaWxlZCwgJWRcbiIsIHJldCk7DQo+ICsJCQlnb3RvIHBvd2VyX29mZl9hdXg7
DQo+ICsJCX0NCg0KRm9yIERQLCB5b3UgbW92ZSB0cmFpbmluZyB0byBoZHAgZXZlbnQgdGhyZWFk
Lg0KSW4geW91IGNvbW1pdCBtZXNzYWdlLCBJIGNvdWxkIG5vdCB1bmRlcnN0YW5kIHdoeSBkbyB0
aGlzLg0KRG9lcyB0aGlzIGlzIHRpbWluZyBwcm9ibGVtPw0KSWYgdGhpcyBpcyBhIHRpbWluZyBw
cm9ibGVtLCBJIHdvdWxkIGxpa2UgeW91IHRvIGRlc2NyaWJlIHdoYXQncyB3cm9uZyBpbiB0aW1p
bmcuDQoNCkZvciBleGFtcGxlLCB0aGlzIGlzIGEgdGltZSBzZXF1ZW5jZSANCg0KMS4gcGx1ZyBp
biBwYW5lbCBBDQoyLiBhdG9taWMgZW5hYmxlICh0cmFpbmluZykNCjMuIHBsdWcgb3V0IHBhbmVs
IEENCjQuIHBsdWcgaW4gcGFuZWwgQg0KDQpCdXQgcGFuZWwgQiBkb2VzIG5vdCB0cmFpbmluZyBh
Z2Fpbiwgc28gdGhpcyBwYXRjaCBtYWtlIGl0IGFzDQoNCjEuIHBsdWcgaW4gcGFuZWwgQSAodHJh
aW5pbmcpDQoyLiBhdG9taWMgZW5hYmxlDQozLiBwbHVnIG91dCBwYW5lbCBBDQo0LiBwbHVnIGlu
IHBhbmVsIEIgKHRyYWluaW5nKQ0KDQpJZiBpdCBpcyB0aGlzIGNhc2UsIGFkZCB0aGlzIGluZm9y
bWF0aW9uIHRvIGNvbW1pdCBtZXNzYWdlLg0KSWYgaXQgaXMgbm90IHRoaXMgY2FzZSwgdHJ5IHRv
IGxldCBtZSB1bmRlcnN0YW5kIHdoeSBtb3ZpbmcgdHJhaW5pbmcgdGltaW5nIHdvdWxkIGhlbHAg
YWRqdXN0IGJhbmR3aWR0aCBsaW1pdC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gIAl9DQo+ICANCj4g
IAlyZXQgPSBtdGtfZHBfdmlkZW9fY29uZmlnKG10a19kcCk7DQo+IEBAIC0yMzkwLDcgKzI0MDEs
NiBAQCBzdGF0aWMgdm9pZCBtdGtfZHBfYnJpZGdlX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9i
cmlkZ2UgKmJyaWRnZSwNCj4gIAkJICAgICAgIHNpemVvZihtdGtfZHAtPmluZm8uYXVkaW9fY3Vy
X2NmZykpOw0KPiAgCX0NCj4gIA0KPiAtCW10a19kcC0+ZW5hYmxlZCA9IHRydWU7DQo+ICAJbXRr
X2RwX3VwZGF0ZV9wbHVnZ2VkX3N0YXR1cyhtdGtfZHApOw0KPiAgDQo+ICAJcmV0dXJuOw0KPiBA
QCAtMjQwNSw3ICsyNDE1LDYgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2JyaWRnZV9hdG9taWNfZGlz
YWJsZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZHAg
Km10a19kcCA9IG10a19kcF9mcm9tX2JyaWRnZShicmlkZ2UpOw0KPiAgDQo+IC0JbXRrX2RwLT5l
bmFibGVkID0gZmFsc2U7DQo+ICAJbXRrX2RwX3VwZGF0ZV9wbHVnZ2VkX3N0YXR1cyhtdGtfZHAp
Ow0KPiAgCW10a19kcF92aWRlb19lbmFibGUobXRrX2RwLCBmYWxzZSk7DQo+ICAJbXRrX2RwX2F1
ZGlvX211dGUobXRrX2RwLCB0cnVlKTsNCg0K

