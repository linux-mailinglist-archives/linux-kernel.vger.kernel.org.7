Return-Path: <linux-kernel+bounces-753929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C707B18A16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 03:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1247AA381
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CD469D2B;
	Sat,  2 Aug 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jbLppbLe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BKS9ckmS"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD0A48;
	Sat,  2 Aug 2025 01:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754097959; cv=fail; b=moPwkBmMLn3iznX0uMxR/sYwAn2inKYT1VqQwDHd7LWhsT5EFW1GqbJZsvyOW1y3LI2Ydd5Sfi9yquOv61tPD0j6KAB7dOTgyrC65iJ10J2am/Wz7HUmSYG6x63wzU/+/Y+aD9c5EPfsrxbacQeVGUr1EleyYeN6fkA5Z2nspOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754097959; c=relaxed/simple;
	bh=c4hSROOTkLjcNm7aHplWnuJrUEch5mTDTRSGmJgSn1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LzRcXLyfOjfVFWwThQzEP8Vk3+fpuLXp0FF+V3pEw3cAEnC2xt8gdJ7fup2P2Vdn97MluyUzCFAMEaO/kx9cPmzZtc3MD0N8Ri7108fgE7DV4QO5klm4yQpoc1MGT3b7Si/KfnEPdsWm7ht32o+7OczcUXGkVT/Qo8x3l/t8CAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jbLppbLe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BKS9ckmS; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9c948aee6f3f11f0b33aeb1e7f16c2b6-20250802
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=c4hSROOTkLjcNm7aHplWnuJrUEch5mTDTRSGmJgSn1k=;
	b=jbLppbLeXMvDOyMVqe9aQfNDdur3HNCu9kQhW4+9COoXgP0n/+NIulkMyiq8ElEwbmVc2I1YoVVc4GtwHKH/drYQ7rDsYKeoZcHdHC05CFtOAWLpkmol3FJUSBSUxLsHcNmURuMFiuQWUHDlA0tkvcAHGEQNYAblIFxUBHPAUt0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:2097f174-0e2e-4152-8304-9374774a4def,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:d7926c0f-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9c948aee6f3f11f0b33aeb1e7f16c2b6-20250802
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1108322948; Sat, 02 Aug 2025 09:25:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 2 Aug 2025 09:25:41 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 2 Aug 2025 09:25:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWbyLkaXVDUnuZYVNk2VBBrYZNcvVp3a/YQ554jxSaAUMrc7oH4iRhWmcjfZsgLE6x6ZU7KNBVte04A2UTCZc+HPh8cyiH9FtMCVSGpwY3uU2DfUeuujaZs+q9DR2ExLrdlXWCSstU6CX6Y8i22TZy4DjlHa6FD3xUm5fTTHXm9zLgG+90zywbMAKnyc9JR1GB7Bb9vgqZP9lOQHreWije+Ni1aGymLZrTi7C9O6+2tLPUPaR+1rdPlai1QYDdl2WcccVVEtjHuCl0zsYOaDoCUJIAhFShwM3ikz0TsT4s8boppDnQBoBjQG/3M9SHe9NQuRItrO+UIvHvKwlTHlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4hSROOTkLjcNm7aHplWnuJrUEch5mTDTRSGmJgSn1k=;
 b=DCbiu3Iq16czeWnI3b4AkHO+/zIt8fR7y9LhhtX/M+x1ihp4R7IKTQSftBoPxSnZW/50i+AyqN4s2kuEDRT+8a3RmxAapPNV8G2gfDF0ho2WCambpKOgG4yZ1r9gluTmEU+fDiEJAMVI5eSh9LqeADSGoiiUqsCPUrPm3U0BdRZW0iqyRpK5y+bRmlcBurIQBbCYB+cxCVGGnNj/xjVi/tPm4fGhxnp73Ac012oGD67K6ew6mJzIjKsmREwmH/fXHyAwpMh4QFDVr1jnlU9p3b4j91XxLspG6uCtB2nhwIo//qmklzPa3HeqOc1ddoj252utdsGpQV5Ov3BlNFDgjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4hSROOTkLjcNm7aHplWnuJrUEch5mTDTRSGmJgSn1k=;
 b=BKS9ckmSUuEKGIztZocLxpuVzvPHVYaca5/zto+aWhFEDXFyfNYfkmgdLP3Me1LiA+QJQBzYLxHfAI0wHSlNIwQAe4tqmpo+3wgUQm6vr6+9tAIm7yeTyU5TzifUDwR0SbYGABBoItZgqluwL0J7wR7tB7dlLu9pZtrcdhVI/+Y=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB8241.apcprd03.prod.outlook.com (2603:1096:405:1f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.13; Sat, 2 Aug 2025 01:25:40 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 01:25:40 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?=
	<Friday.Yang@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Topic: [PATCH v8 2/2] memory: mtk-smi: mt8188: Add SMI reset and clamp
 for MT8188
Thread-Index: AQHbyhpyeanHqT+sjUmR6kEKvwqT/rRPBICA
Date: Sat, 2 Aug 2025 01:25:40 +0000
Message-ID: <8cb598c782fa376967f8e676b5ec9f195a3475fc.camel@mediatek.com>
References: <20250521063347.31578-1-friday.yang@mediatek.com>
	 <20250521063347.31578-3-friday.yang@mediatek.com>
In-Reply-To: <20250521063347.31578-3-friday.yang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB8241:EE_
x-ms-office365-filtering-correlation-id: b49e222c-2d30-456b-360e-08ddd1637e3f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZE9uTzhFOUQ1TnpFUjJ2c1F6aXZDTjBzKzROSDNJcVRPelFqQTNnbW4wckJN?=
 =?utf-8?B?YVQ3ZzRCTHU1ZWhVQTJUdUpPdkwwVzh4ZnN2NnBtdWNDN3J1N1hlMVhKcTBk?=
 =?utf-8?B?ajJqc2VvUnlGTTRvUG9zcHQ5R0phSlpReTdjUVZpWXFyS2x3ZlI3K2VRM3Vv?=
 =?utf-8?B?YjZqRlVYNk5Dck51Qk82UUxVa2tUdVUrR0c5b1BYQ2YwTEJNRU5hQ0pubEtm?=
 =?utf-8?B?VHd2dTJqRWFRejBQb0NibkhZV2FyL3dSM2RmakFQMnRyWnV6RDNhSmhweUdU?=
 =?utf-8?B?WXlDR3ZDSEoxR2dva29LRzdERGdhS3M4N3hQQ0kyYnhXZkFVYktFekRxb2Fy?=
 =?utf-8?B?QmRWb0E3ZStwSmc3VTc2QmpZTXhZcllaTVdNdWtyNnNaZXJCREdXQS9KdXA5?=
 =?utf-8?B?ZEc2YnRzRzc2VmE5Z0ltQ3FITGt2WE4vQ2Y2czFkbC9kQnM1OEtMN2szRCtt?=
 =?utf-8?B?Y0hPSDZ3TjZMcjRGdVNYNm5rTFJqYjM1WWo3VG9IbWNnZzlFejBNM09EZjd3?=
 =?utf-8?B?bXdralRTeGVMU29XRlgyUTlTRnM5QkQyRmRvTHNPdmRkOXFLanFadHBySEJP?=
 =?utf-8?B?S3gzaXVOVjVWZEJyQVVZV1lJWW9velk1b0VWblFuQ21xb2w4eGRybmpZeGxG?=
 =?utf-8?B?cjVNL3pXd3JTU0FiNWczU1dORlZrY1V1dDUzQ2FZcWNGdjBOUyswMnp2OEVl?=
 =?utf-8?B?OXBZb3ZwQk9jNXc2Z3dHODFXSWJsYnlnY3RLeHVSTktOY3pka2JMTGp3a3pY?=
 =?utf-8?B?MEk2cm9KY3crUWMwelBDUHBCNUVzZzRiYXdOT0kwKzU1OVByblNBZngzd0ZH?=
 =?utf-8?B?b1FqRDd6NUhtS1NRbUtoM0lFNEZDWm8velZrbHpHeXJBd0ZOOFJkd2c4MkhP?=
 =?utf-8?B?dE1ONlk5bHgvWG9tSFNrRktJdnROV1o2UGNDSTFuek1uSFJydDNFa3ZuN2Er?=
 =?utf-8?B?aW1qWWlGSHFpRWxqMEtER0xBQ3ZLT0VVdVM2bWc2d1dvQTV2dlhnallIZW56?=
 =?utf-8?B?WnpsL2NuY3h0UGoyNDRiRlRkOEhNU2IzdHZyemFRWmdrb0lTa3B0MGhsVFZK?=
 =?utf-8?B?MHd4Q3Rac2dTcEV4NTN0RVZEQWpkRDZmbVJTODFQV29mZ1AwdHNzelVVNTZw?=
 =?utf-8?B?NVA1N2MvbWs5OWpoVGdKNUdaejJVWWwrK0FzR1kzeFd2NUh1SnBhMjI2d3U0?=
 =?utf-8?B?UTEwZDVSdXdNZEZEMVRnQTFmMlF6dXhvODZwcUZMTERqUjMzY1VrV1ZuZ2Z1?=
 =?utf-8?B?cjRBbWFINTJJZ2EzOTdySGlXRDYxcG1uWEVuUWI4ZWhUUFR3eXNsWi9IOVhB?=
 =?utf-8?B?SG1lcmFtMVd6UisxMnFmNVh1NDVwQlZhWWpkZnoxbTB0UHJKSlJ0cmhscHlJ?=
 =?utf-8?B?TThwcmxhRy9OY3RzRnlzS3R5dXhtYUhUcDlOS0ZxVlZQbVFJaDJOenJHY2dW?=
 =?utf-8?B?bUsrK3FLWkYwL29HSGFVR3NPMXpmbzBYL05qcndBdmNWN2ZId0tmWHk4dnJM?=
 =?utf-8?B?R1FRenlWcE54WkVJb2UvUllXRDlkbzlWd1B6Q1JkbzhiM2o0SDlWYWJkNklJ?=
 =?utf-8?B?OEZWUmFQV1R3SVk1R3RaKzVCVHlhRW5nd3VFTXpWT2k0VHpEdnpzZkpsYmhs?=
 =?utf-8?B?V2J2TlVRcEQ3clpuUW91RzB3dW1hS1dtWGVQeTVXb1dEK3RmTkNzUUxTc0h1?=
 =?utf-8?B?VWtvYnRmczZmbjVpSHhSNklRWDZqMjBUNmJSczZ0bTZ1cjdxV3pEY2R1UVl5?=
 =?utf-8?B?ZDl3bEg0NUUwRXlMVjVjSVo4SzhabDIwRkg1d2pRWVFJUVpLYXpzTVV5OXdh?=
 =?utf-8?B?Z3JZTnY1d0xUM0R3cmFleTlTY205WkpBTWRjWkNsQnBMaCt6Mkw4dEdnc1Jv?=
 =?utf-8?B?WFBJOXM0OXFaVUFCT0VjTnlJc3owUStlblUxeW1xemIzNmxXMmpreEpjclRn?=
 =?utf-8?B?QnpqbktWVzVJWEpLNHZzODdtZkFZME80RVplK1dYQzF2eUJhdEQxczVHZFV6?=
 =?utf-8?B?aEtHc3VmOVN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFJeU5OQTFVTERjemJhUU9PT3NnclRUQmdRZlhxVG9aVVhTTzA1T2tscTJ6?=
 =?utf-8?B?ZDNIU2M5NkszYm5IZ0owWGhuK2xtVjJvV0VkVFZtVWQyV3YzZ2xiTFVmaUpm?=
 =?utf-8?B?RmZaQjh0NkZBeXU1c25KSCtMRUNzbmM3dWpwb00wVVZDdlUzWkFsNmJGRHZu?=
 =?utf-8?B?Z29JQk9HSDZscWxrV0VycWdiMHpsdndLUkY0R2JhRWgvbm0ybjAzZ3BCMmkz?=
 =?utf-8?B?SkpscmR3Wi8zL1p1VjFKdGVid2x1YjhuTFRVZnFMZG5hWjc1ZUkvUXd2eHA5?=
 =?utf-8?B?WWFIcm1Xa3dUeWZjejIwYVJ1N0xJZFlNdCtYdnhTdUJFVTRBYmRSaEU0YjRH?=
 =?utf-8?B?WmhxcTVselY3UHdWbysrWlVXc3dmNXdjbldxTnRsQWd1aDFSMFNBTnhmSzJZ?=
 =?utf-8?B?MXpqdEcwalpVUXNHWHlTcTVwanNLcTBWZ1RBQW53MUxEcjZFcG9RSFp2UGRo?=
 =?utf-8?B?NFlpL1ovTGxFYUVJSWx1OTVxUXNIWVhPdTVUVi91RUNpSjVURk1sOUxlbVVY?=
 =?utf-8?B?Tkhwd2tOdjE2OVZDRWFBdGJpY3dUc2lZOHprK0cxMFFjbENzTVVvMFZUNHdD?=
 =?utf-8?B?TGhyYTZqaG1YdG9sbmRlMFUrbDdTU1VmSi9CT3BUOGdjb21NWmZHdW84YVdF?=
 =?utf-8?B?b3cybk4zam5yTXllQWt1MjNFeGJWM3pWSXFhV1dHQ0tQT3VZRHlwK2ZGYjdr?=
 =?utf-8?B?cWIvVnRORmZmK0lzYVBuSnVCSG9zMEE1SDJ4OXdtUnJqZkNLWlF3WERCcGJv?=
 =?utf-8?B?cTZESnl0VHh2dWtEQWErajQ4VVlkbXJpUHhSYlVUYW4rRVpWNTMySEtrZVdt?=
 =?utf-8?B?eVp1by9CZkRoV2MzYmpBUTZMTmxEdyszS2hzeDl2QjFTNWwvQmFBWXRJYWIx?=
 =?utf-8?B?bzNxbDdlV2xtQzMxaTRoUGZJbkg2YWhSckdkQk03OER6Yk55dEdNbkpMU2RT?=
 =?utf-8?B?bis3R3V6QS9PYklLQlMxSG15V0ltQUNnaEdJcWR0blFEVlJoblI1RlNFNURy?=
 =?utf-8?B?WlRYWjFkQW94WVdiSCt1ZzljUkxMenh6b01PcjVsSnNJYTJhNUVjallJV0dO?=
 =?utf-8?B?YllWaGFndCtoQ2FqaEJBQkFhelcxcWMvbTRYb0QyZmd2eGc5a3ZPU3kydWps?=
 =?utf-8?B?YUFMazFIWWQ1WjlxcXJsTnlZRmJiZUloZWk1S0Z1VFcwNlFYUDArbEI4aDdp?=
 =?utf-8?B?bDFCeU4zRHFtbDZrN3I0L1cyVm11dlVUZGhHV1Q2SEZNc2JGWW5YeW9MSVZV?=
 =?utf-8?B?eGxlVkwraVRScWVoOGhoMkRWMFF2VGJVSlcxWTJva1pNZGs5MnlQTUxBUXNL?=
 =?utf-8?B?K0N3c0ZNcno0ZHR4VUdEa2taK2RGYkRGVGh5L3ZxSk1kS2hSamNoNU52ZE9R?=
 =?utf-8?B?NUZQWkJIVDVsdHJ1RTVzQWlZVCswMzJUdWRuTE5kZjJqdWp1QVV0S3ZqL0Uw?=
 =?utf-8?B?TmFQZDdNbmJ4eUQxZHlTZjFpUHFVK2VxbC9GZDUycTdUY0VUVXdxaGJrZjQ2?=
 =?utf-8?B?ZUJKOUt5Vm5TMnBhdXhaRnd1ckNoZUFrNTByS1hSUlU0UGxpZ0Q5cEpkSUx0?=
 =?utf-8?B?amI5RTdvYnpwb0VWbVJlYzhNQkEwTGdtVzdzNENoeW5UckwzUEF5MmZPaDZC?=
 =?utf-8?B?eG1TbVgvU3E1N2k4OUlWR1pWZ1ZPRXhhdXJjSEROeCt4U2YxOVlneDlCRWJo?=
 =?utf-8?B?eFdTK0piTjkydGovQ0JXNEFFRWVudTFWSEpZcTJpVmdiZ2xSa1Nvc2NjcXBq?=
 =?utf-8?B?a2habDNRenNjVlVKalN2TEl3cllmZ1FNR1ZsYzlMOHpRbGN0OVViK1lhT0hO?=
 =?utf-8?B?YW96N2hPbTkvN3dFdkpOaXA5bk44UEFoeE5vcThranBKY08xQllvYStZSG0z?=
 =?utf-8?B?Q2ZaaVB0Yk5xVHlLbkFGVkxMbGtIeWkrMUJrWkgxV3pBS29vQ3Y3dGpjaFRn?=
 =?utf-8?B?cVF4SUk0NlcrV0w4dXBMK2lodUFTSUJjR1FXczRtV09PZHVxdnhoc3h1ZzN2?=
 =?utf-8?B?S1FsVGpmdjhtZ3liRGpxNkNEb3M2amtYdTZhL2xTa2JWYjdGWnN2VFlZajR3?=
 =?utf-8?B?VjVNNzVIejJranFTMXNLeW8rU0xDME1jZ3pTTkozYmlCV1FGOTgrcTRocStX?=
 =?utf-8?Q?0HqZ/NjI+c6npunR3LgOXDa29?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18193282B4075A4D97C5D7F0A9036C25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49e222c-2d30-456b-360e-08ddd1637e3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2025 01:25:40.5950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rIiyGmVb3/kYeFWcuIoJZbGCCnCAuXTYKOCtDdYYHRcnWCRFxS+qagOi+SfBduIhZ5iudkbRhhJUyMy+49VDtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8241
X-MTK: N

T24gV2VkLCAyMDI1LTA1LTIxIGF0IDE0OjMzICswODAwLCBGcmlkYXkgWWFuZyB3cm90ZToNCj4g
RnJvbTogIkZyaWRheSBZYW5nIiA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gVG8g
cHJldmVudCBoYW5kbGluZyBnbGl0Y2ggc2lnbmFscyBkdXJpbmcgTVRDTU9TIG9uL29mZiB0cmFu
c2l0aW9ucywNCj4gU01JIHJlcXVpcmVzIGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25zLiBQYXJz
ZSB0aGUgcmVzZXQgc2V0dGluZ3MgZm9yDQo+IFNNSSBMQVJCcyBhbmQgdGhlIGNsYW1wIHNldHRp
bmdzIGZvciB0aGUgU01JIFN1Yi1Db21tb24uIFJlZ2lzdGVyDQo+IGdlbnBkIGNhbGxiYWNrIGZv
ciB0aGUgU01JIExBUkJzIGxvY2F0ZWQgaW4gaW1hZ2UsIGNhbWVyYSBhbmQgSVBFDQo+IHN1YnN5
c3RlbXMsIGFuZCBhcHBseSByZXNldCBhbmQgY2xhbXAgb3BlcmF0aW9ucyB3aXRoaW4gdGhlIGNh
bGxiYWNrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJpZGF5IFlhbmcgPGZyaWRheS55YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwN
Cj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBBY2tlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9tZW1v
cnkvbXRrLXNtaS5jIHwgMTMzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5j
DQo+IGluZGV4IGMwODZjMjI1MTFmNy4uZjM3NDVmNTQ5NjI5IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+
IEBAIC0xMCwxMSArMTAsMTUgQEANCj4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9pby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+
DQo+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvcG1fZG9tYWluLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210a19zaXBfc3ZjLmg+DQo+ICAjaW5jbHVkZSA8
c29jL21lZGlhdGVrL3NtaS5oPg0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS9tdDI3
MDEtbGFyYi1wb3J0Lmg+DQo+IEBAIC0zNiw2ICs0MCwxMiBAQA0KPiAgI2RlZmluZSBTTUlfRENN
CQkJCTB4MzAwDQo+ICAjZGVmaW5lIFNNSV9EVU1NWQkJCTB4NDQ0DQo+IA0KPiArI2RlZmluZSBT
TUlfQ09NTU9OX0NMQU1QX0VOCQkweDNjMA0KDQpOb3QgdXNlZC4gcmVtb3ZlIHRoaXMuDQoNCj4g
KyNkZWZpbmUgU01JX0NPTU1PTl9DTEFNUF9FTl9TRVQJCTB4M2M0DQo+ICsjZGVmaW5lIFNNSV9D
T01NT05fQ0xBTVBfRU5fQ0xSCQkweDNjOA0KDQpTb3J0IGJ5IHRoZSBhZGRyZXNzLiBwdXQgYWJv
dmUgMHg0NDQuDQoNCj4gKw0KPiArI2RlZmluZSBTTUlfU1VCX0NPTU1fSU5QT1JUX05SCQkoOCkN
Cg0KTm90IHVzZWQuIHJlbW92ZSB0aGlzLg0KDQo+ICsNCj4gIC8qIFNNSSBMQVJCICovDQo+ICAj
ZGVmaW5lIFNNSV9MQVJCX1NMUF9DT04gICAgICAgICAgICAgICAgMHhjDQo+ICAjZGVmaW5lIFNM
UF9QUk9UX0VOICAgICAgICAgICAgICAgICAgICAgQklUKDApDQo+IEBAIC0xMzQsNiArMTQ0LDcg
QEAgc3RydWN0IG10a19zbWlfbGFyYl9nZW4gew0KPiAgCXVuc2lnbmVkIGludAkJCWxhcmJfZGly
ZWN0X3RvX2NvbW1vbl9tYXNrOw0KPiAgCXVuc2lnbmVkIGludAkJCWZsYWdzX2dlbmVyYWw7DQo+
ICAJY29uc3QgdTgJCQkoKm9zdGQpW1NNSV9MQVJCX1BPUlRfTlJfTUFYXTsNCj4gKwljb25zdCB1
OAkJCSpjbGFtcF9wb3J0Ow0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgbXRrX3NtaSB7DQo+IEBAIC0x
NTAsNiArMTYxLDcgQEAgc3RydWN0IG10a19zbWkgew0KPiAgfTsNCj4gDQo+ICBzdHJ1Y3QgbXRr
X3NtaV9sYXJiIHsgLyogbGFyYjogbG9jYWwgYXJiaXRlciAqLw0KPiArCXN0cnVjdCBkZXZpY2UJ
CQkqZGV2Ow0KPiAgCXN0cnVjdCBtdGtfc21pCQkJc21pOw0KPiAgCXZvaWQgX19pb21lbQkJCSpi
YXNlOw0KPiAgCXN0cnVjdCBkZXZpY2UJCQkqc21pX2NvbW1vbl9kZXY7IC8qIGNvbW1vbiBvcg0K
PiBzdWItY29tbW9uIGRldiAqLw0KPiBAQCAtMTU3LDYgKzE2OSwxMCBAQCBzdHJ1Y3QgbXRrX3Nt
aV9sYXJiIHsgLyogbGFyYjogbG9jYWwgYXJiaXRlciAqLw0KPiAgCWludAkJCQlsYXJiaWQ7DQo+
ICAJdTMyCQkJCSptbXU7DQo+ICAJdW5zaWduZWQgY2hhcgkJCSpiYW5rOw0KPiArCXN0cnVjdCBy
ZWdtYXAJCQkqc3ViX2NvbW1fc3lzY29uOw0KDQpUaGlzIGlzIGFsc28gb2sgd2hlbiB0aGUgcGFy
ZW50IGlzIHNtaS1jb21tb24sIG5vdCBqdXN0IHNtaS1zdWItY29tbS4NCnRodXMsIHBlcnNvbmFs
eSBJJ2QgbGlrZSB0byByZW5hbWUgdG8gc29tZXRoaW5nIGxpa2U6DQoNCiAgICAgICBzdHJ1Y3Qg
cmVnbWFwICpzbWlfY29tbV9zeXNjb247IC8qIHNtaS1jb21tIG9yIHN1Yl9jb21tICovDQoNCj4g
Kwl1OAkJCQlzdWJfY29tbV9pbnBvcnQ7DQogICAgICANCmFsc28gcmVuYW1lIHRvIHNtaV9jb21t
X2lucG9ydF9pZC4NCg0KPiArCXN0cnVjdCBub3RpZmllcl9ibG9jawkJbmI7DQo+ICsJc3RydWN0
IHJlc2V0X2NvbnRyb2wJCSpyc3RfY29uOw0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgaW50DQo+IEBA
IC00NDYsNiArNDYyLDE5IEBAIHN0YXRpYyBjb25zdCB1OA0KPiBtdGtfc21pX2xhcmJfbXQ4MTk1
X29zdGRbXVtTTUlfTEFSQl9QT1JUX05SX01BWF0gPSB7DQo+ICAJWzI4XSA9IHsweDFhLCAweDBl
LCAweDBhLCAweDBhLCAweDBjLCAweDBlLCAweDEwLH0sDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBj
b25zdCB1OCBtdGtfc21pX2xhcmJfY2xhbXBfcG9ydF9tdDgxODhbTVRLX0xBUkJfTlJfTUFYXSA9
IHsNCj4gKwlbOV0JPSBCSVQoMSksIC8qIGxhcmIxMCAqLw0KPiArCVsxMF0JPSBCSVQoMiksIC8q
IGxhcmIxMWEgKi8NCj4gKwlbMTFdCT0gQklUKDIpLCAvKiBsYXJiMTFiICovDQo+ICsJWzEyXQk9
IEJJVCgzKSwgLyogbGFyYjExYyAqLw0KPiArCVsxM10JPSBCSVQoMCksIC8qIGxhcmIxMiAqLw0K
PiArCVsxNl0JPSBCSVQoMSksIC8qIGxhcmIxNSAqLw0KPiArCVsxN10JPSBCSVQoMiksIC8qIGxh
cmIxNmEgKi8NCj4gKwlbMThdCT0gQklUKDIpLCAvKiBsYXJiMTZiICovDQo+ICsJWzE5XQk9IEJJ
VCgzKSwgLyogbGFyYjE3YSAqLw0KPiArCVsyMF0JPSBCSVQoMyksIC8qIGxhcmIxN2IgKi8NCj4g
K307DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX2dlbiBtdGtfc21p
X2xhcmJfbXQyNzAxID0gew0KPiAgCS5wb3J0X2luX2xhcmIgPSB7DQo+ICAJCUxBUkIwX1BPUlRf
T0ZGU0VULCBMQVJCMV9QT1JUX09GRlNFVCwNCj4gQEAgLTQ5OCw2ICs1MjcsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4NCj4gbXRrX3NtaV9sYXJiX210ODE4OCA9IHsN
Cj4gIAkuZmxhZ3NfZ2VuZXJhbAkgICAgICAgICAgICA9IE1US19TTUlfRkxBR19USFJUX1VQREFU
RSB8DQo+IE1US19TTUlfRkxBR19TV19GTEFHIHwNCj4gIAkJCQkgICAgICBNVEtfU01JX0ZMQUdf
U0xFRVBfQ1RMIHwNCj4gTVRLX1NNSV9GTEFHX0NGR19QT1JUX1NFQ19DVEwsDQo+ICAJLm9zdGQJ
CSAgICAgICAgICAgID0gbXRrX3NtaV9sYXJiX210ODE4OF9vc3RkLA0KPiArCS5jbGFtcF9wb3J0
ICAgICAgICAgICAgICAgICA9IG10a19zbWlfbGFyYl9jbGFtcF9wb3J0X210ODE4OCwNCj4gIH07
DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuIG10a19zbWlfbGFy
Yl9tdDgxOTIgPSB7DQo+IEBAIC01NDksNiArNTc5LDQ2IEBAIHN0YXRpYyB2b2lkDQo+IG10a19z
bWlfbGFyYl9zbGVlcF9jdHJsX2Rpc2FibGUoc3RydWN0IG10a19zbWlfbGFyYiAqbGFyYikNCj4g
IAl3cml0ZWxfcmVsYXhlZCgwLCBsYXJiLT5iYXNlICsgU01JX0xBUkJfU0xQX0NPTik7DQo+ICB9
DQo+IA0KPiArc3RhdGljIGludCBtdGtfc21pX2xhcmJfY2xhbXBfcHJvdGVjdF9lbmFibGUoc3Ry
dWN0IGRldmljZSAqZGV2LA0KPiBib29sIGVuYWJsZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX3Nt
aV9sYXJiICpsYXJiID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJdTMyIHJlZzsNCj4gKwlp
bnQgcmV0Ow0KPiArDQo+ICsJLyogc3ViX2NvbW1fc3lzY29uIGNvdWxkIGJlIE5VTEwgaWYgbGFy
YiBkaXJlY3RseSBsaW5rZWQgdG8gU01JDQo+IGNvbW1vbiAqLw0KPiArCWlmICghbGFyYi0+c3Vi
X2NvbW1fc3lzY29uKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCXJlZyA9IGVuYWJs
ZSA/IFNNSV9DT01NT05fQ0xBTVBfRU5fU0VUIDoNCj4gU01JX0NPTU1PTl9DTEFNUF9FTl9DTFI7
DQo+ICsNCj4gKwlyZXQgPSByZWdtYXBfd3JpdGUobGFyYi0+c3ViX2NvbW1fc3lzY29uLCByZWcs
DQo+ICsJCQkgICBsYXJiLT5zdWJfY29tbV9pbnBvcnQpOw0KDQpvbmUgbGluZS4NCg0KPiArCWlm
IChyZXQpDQo+ICsJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvICVzIGNsYW1wIGZvciBpbnB1dCBw
b3J0ICVkOg0KPiAlZFxuIiwNCj4gKwkJCWVuYWJsZSA/ICJlbmFibGUiIDogImRpc2FibGUiLA0K
PiArCQkJbGFyYi0+c3ViX2NvbW1faW5wb3J0LCByZXQpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsN
Cj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtfc21pX2dlbnBkX2NhbGxiYWNrKHN0cnVjdCBu
b3RpZmllcl9ibG9jayAqbmIsDQo+ICsJCQkJICB1bnNpZ25lZCBsb25nIGZsYWdzLCB2b2lkICpk
YXRhKQ0KPiArew0KPiArCXN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmIgPSBjb250YWluZXJfb2Yo
bmIsIHN0cnVjdA0KPiBtdGtfc21pX2xhcmIsIG5iKTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSBsYXJiLT5kZXY7DQo+ICsNCj4gKwlpZiAoZmxhZ3MgPT0gR0VOUERfTk9USUZZX1BSRV9PTiB8
fCBmbGFncyA9PQ0KPiBHRU5QRF9OT1RJRllfUFJFX09GRikgew0KPiArCQkvKiBkaXNhYmxlIHJl
bGF0ZWQgU01JIHN1Yi1jb21tb24gcG9ydCAqLw0KPiArCQltdGtfc21pX2xhcmJfY2xhbXBfcHJv
dGVjdF9lbmFibGUoZGV2LCB0cnVlKTsNCj4gKwl9IGVsc2UgaWYgKGZsYWdzID09IEdFTlBEX05P
VElGWV9PTikgew0KPiArCQkvKiBlbmFibGUgcmVsYXRlZCBTTUkgc3ViLWNvbW1vbiBwb3J0ICov
DQo+ICsJCXJlc2V0X2NvbnRyb2xfcmVzZXQobGFyYi0+cnN0X2Nvbik7DQo+ICsJCW10a19zbWlf
bGFyYl9jbGFtcF9wcm90ZWN0X2VuYWJsZShkZXYsIGZhbHNlKTsNCj4gKwl9DQo+ICsNCj4gKwly
ZXR1cm4gTk9USUZZX09LOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG10a19zbWlfZGV2aWNl
X2xpbmtfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+IGRldmljZSAqKmNvbV9k
ZXYpDQo+ICB7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqc21pX2NvbV9wZGV2Ow0KPiBA
QCAtNjA1LDYgKzY3NSw1MyBAQCBzdGF0aWMgaW50IG10a19zbWlfZHRzX2Nsa19pbml0KHN0cnVj
dCBkZXZpY2UNCj4gKmRldiwgc3RydWN0IG10a19zbWkgKnNtaSwNCj4gIAlyZXR1cm4gcmV0Ow0K
PiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3BhcnNlX2NsYW1wX29wdGlvbmFs
KHN0cnVjdCBtdGtfc21pX2xhcmINCj4gKmxhcmIpDQo+ICt7DQo+ICsJc3RydWN0IGRldmljZSAq
ZGV2ID0gbGFyYi0+ZGV2Ow0KPiArCWNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfZ2VuICpsYXJi
X2dlbiA9IGxhcmItPmxhcmJfZ2VuOw0KPiArCXUzMiBsYXJiX2lkOw0KPiArCWludCByZXQ7DQo+
ICsNCj4gKwkvKg0KPiArCSAqIE9ubHkgU01JIExBUkJzIGluIGNhbWVyYSwgaW1hZ2UgYW5kIElQ
RSBzdWJzeXMgbmVlZCB0bw0KPiArCSAqIGFwcGx5IGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25z
LCBvdGhlcnMgY2FuIGJlIHNraXBwZWQuDQo+ICsJICovDQo+ICsJcmV0ID0gb2ZfcHJvcGVydHlf
cmVhZF91MzIoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWssbGFyYi1pZCIsDQo+ICZsYXJiX2lkKTsN
Cj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwlpZiAoIWxhcmJfZ2VuLT5j
bGFtcF9wb3J0IHx8ICFsYXJiX2dlbi0+Y2xhbXBfcG9ydFtsYXJiX2lkXSkNCj4gKwkJcmV0dXJu
IDA7DQo+ICsNCj4gKwlsYXJiLT5zdWJfY29tbV9pbnBvcnQgPSBsYXJiX2dlbi0+Y2xhbXBfcG9y
dFtsYXJiX2lkXTsNCj4gKwlsYXJiLT5zdWJfY29tbV9zeXNjb24gPSBzeXNjb25fcmVnbWFwX2xv
b2t1cF9ieV9waGFuZGxlKGRldi0NCj4gPm9mX25vZGUsDQo+ICsJCQkJCQkJCSJtZWRpYXQNCj4g
ZWssc21pIik7DQo+ICsJaWYgKElTX0VSUihsYXJiLT5zdWJfY29tbV9zeXNjb24pKSB7DQo+ICsJ
CWxhcmItPnN1Yl9jb21tX3N5c2NvbiA9IE5VTEw7DQo+ICsJCXJldHVybiBkZXZfZXJyX3Byb2Jl
KGRldiwgLUVJTlZBTCwNCj4gKwkJCQkgICAgICJVbmtub3duIGNsYW1wIHBvcnQgZm9yIGxhcmIN
Cj4gJWRcbiIsIGxhcmJfaWQpOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9vcHRpb25hbChzdHJ1Y3Qg
bXRrX3NtaV9sYXJiDQo+ICpsYXJiKQ0KPiArew0KPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IGxh
cmItPmRldjsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJbGFyYi0+cnN0X2NvbiA9IGRldm1fcmVz
ZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwNCj4gImxhcmIiKTsNCj4gKwlp
ZiAoIWxhcmItPnJzdF9jb24pDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJbGFyYi0+bmIubm90
aWZpZXJfY2FsbCA9IG10a19zbWlfZ2VucGRfY2FsbGJhY2s7DQo+ICsJcmV0ID0gZGV2X3BtX2dl
bnBkX2FkZF9ub3RpZmllcihkZXYsICZsYXJiLT5uYik7DQoNCkFkZCBkZXZfcG1fZ2VucGRfcmVt
b3ZlX25vdGlmaWVyIGluIGxhcmJfcmVtb3ZlLg0KDQpUaGFua3MuDQoNCj4gKwlpZiAocmV0KQ0K
PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIC1FSU5WQUwsDQo+ICsJCQkJICAgICAiRmFp
bGVkIHRvIGFkZCBnZW5wZCBjYWxsYmFjaw0KPiAlZFxuIiwgcmV0KTsNCj4gKw0KPiArCXJldHVy
biAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfc21pX2xhcmIgKmxh
cmI7DQo+IEBAIC02MTUsNiArNzMyLDcgQEAgc3RhdGljIGludCBtdGtfc21pX2xhcmJfcHJvYmUo
c3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpZiAoIWxhcmIpDQo+ICAJCXJl
dHVybiAtRU5PTUVNOw0KPiANCj4gKwlsYXJiLT5kZXYgPSBkZXY7DQo+ICAJbGFyYi0+bGFyYl9n
ZW4gPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIAlsYXJiLT5iYXNlID0gZGV2
bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIobGFy
Yi0+YmFzZSkpDQo+IEBAIC02MzEsNiArNzQ5LDE0IEBAIHN0YXRpYyBpbnQgbXRrX3NtaV9sYXJi
X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKHJldCA8IDAp
DQo+ICAJCXJldHVybiByZXQ7DQo+IA0KPiArCXJldCA9IG10a19zbWlfbGFyYl9wYXJzZV9jbGFt
cF9vcHRpb25hbChsYXJiKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVycl9saW5rX3JlbW92
ZTsNCj4gKw0KPiArCXJldCA9IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9vcHRpb25hbChsYXJi
KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVycl9saW5rX3JlbW92ZTsNCj4gKw0KPiAgCXBt
X3J1bnRpbWVfZW5hYmxlKGRldik7DQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbGFy
Yik7DQo+ICAJcmV0ID0gY29tcG9uZW50X2FkZChkZXYsICZtdGtfc21pX2xhcmJfY29tcG9uZW50
X29wcyk7DQo+IEBAIC02NDAsNiArNzY2LDcgQEAgc3RhdGljIGludCBtdGtfc21pX2xhcmJfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gDQo+ICBlcnJfcG1fZGlzYWJs
ZToNCj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gK2Vycl9saW5rX3JlbW92ZToNCj4g
IAlkZXZpY2VfbGlua19yZW1vdmUoZGV2LCBsYXJiLT5zbWlfY29tbW9uX2Rldik7DQo+ICAJcmV0
dXJuIHJldDsNCj4gIH0NCj4gQEAgLTc3MCw2ICs4OTcsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfc21pX2NvbW1vbl9wbGF0DQo+IG10a19zbWlfY29tbW9uX210ODE4OF92cHAgPSB7DQo+
ICAJLmluaXQgICAgID0gbXRrX3NtaV9jb21tb25fbXQ4MTk1X2luaXQsDQo+ICB9Ow0KPiANCj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3NtaV9jb21tb25fcGxhdCBtdGtfc21pX3N1Yl9jb21t
b25fbXQ4MTg4ID0NCj4gew0KPiArCS50eXBlICAgICA9IE1US19TTUlfR0VOMl9TVUJfQ09NTSwN
Cj4gKwkuaGFzX2dhbHMgPSB0cnVlLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfc21pX2NvbW1vbl9wbGF0IG10a19zbWlfY29tbW9uX210ODE5MiA9IHsNCj4gIAkudHlw
ZSAgICAgPSBNVEtfU01JX0dFTjIsDQo+ICAJLmhhc19nYWxzID0gdHJ1ZSwNCj4gQEAgLTgxNCw2
ICs5NDYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0KPiBtdGtfc21pX2Nv
bW1vbl9vZl9pZHNbXSA9IHsNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LXNt
aS1jb21tb24iLCAuZGF0YSA9DQo+ICZtdGtfc21pX2NvbW1vbl9tdDgxODZ9LA0KPiAgCXsuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgtc21pLWNvbW1vbi12ZG8iLCAuZGF0YSA9DQo+ICZt
dGtfc21pX2NvbW1vbl9tdDgxODhfdmRvfSwNCj4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTg4LXNtaS1jb21tb24tdnBwIiwgLmRhdGEgPQ0KPiAmbXRrX3NtaV9jb21tb25fbXQ4MTg4
X3ZwcH0sDQo+ICsJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1zbWktc3ViLWNvbW1v
biIsIC5kYXRhID0NCj4gJm10a19zbWlfc3ViX2NvbW1vbl9tdDgxODh9LA0KPiAgCXsuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItc21pLWNvbW1vbiIsIC5kYXRhID0NCj4gJm10a19zbWlf
Y29tbW9uX210ODE5Mn0sDQo+ICAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWkt
Y29tbW9uLXZkbyIsIC5kYXRhID0NCj4gJm10a19zbWlfY29tbW9uX210ODE5NV92ZG99LA0KPiAg
CXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtc21pLWNvbW1vbi12cHAiLCAuZGF0YSA9
DQo+ICZtdGtfc21pX2NvbW1vbl9tdDgxOTVfdnBwfSwNCj4gLS0NCj4gMi40Ni4wDQo+IA0K

