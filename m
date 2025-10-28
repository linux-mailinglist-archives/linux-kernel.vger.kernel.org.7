Return-Path: <linux-kernel+bounces-873076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B38E2C13002
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 780FA4E516F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D029B200;
	Tue, 28 Oct 2025 05:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lyarvgNk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PWECfeQ4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970D299A96
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630229; cv=fail; b=Gu9Qn29hiR+YAWO1i+RXJMRUX4ZaQ9kpg7QSAu4rwHqHO45C3MA+nmxX4Mm6P3GMamvBCIydYc6XG7WbTMvXeSPUxakf9NQSFmKp9jhAOPabaK2WyJkDdu24nNj9/ts7sQ7BV1lQ4Kqs4Sx+N7ooG94SgjuMhD1Vv7cpD62Enu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630229; c=relaxed/simple;
	bh=xz8DbwU4YH1GciOytEnrsRlJw+zfMPRCQNhAA2CiU+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gny0MnVsjcYcpNVBwUyk8wB/PhKNJBAI5ZzCkLxKRnsJIdVsuEVb62sdbzB/W4agOGFfdxVrVqsl5HbdBt0dugSdboYWxbmIjn0Uer+TLiVFclIWyeJzdu1HAbYsNSDvrO1k4j/Pj45+u6g9yyJXuDCwsty9D+0o2Do62g1ccTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lyarvgNk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PWECfeQ4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0fb51d5cb3c111f0ae1e63ff8927bad3-20251028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xz8DbwU4YH1GciOytEnrsRlJw+zfMPRCQNhAA2CiU+k=;
	b=lyarvgNkQDepOtDdya1wo6XjQ46+MrRpU4ON67Aim+uxX+Cw6fSDbnrL7E3ZzJF2IbMqMS0hlWf/03CoeCTQdc5dHuc742hbRCkyBoKlSNJHC7urMFm01XQzafVjF4QvkNRrqMCj+0PUDLIdXoJfUPPYNb9p7dRUTG7jfbOb5QM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1f677e41-5612-4a9c-acb5-456120401148,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:ba326184-4124-4606-b51d-d5c9eec0e7b9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0fb51d5cb3c111f0ae1e63ff8927bad3-20251028
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 452053701; Tue, 28 Oct 2025 13:43:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 28 Oct 2025 13:43:41 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 28 Oct 2025 13:43:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbWfGyjbIS6xlfMufKV7X2xf9xPCR9suC6bfVrheNElz9NSs+Atdq2Fr2Nwf4QVjjX1jePwdYKCh50Xj8DXCS0u+uQnmNlBiSX2HiKL3pqfBxUJb7BPMgaE44l6/vUKaekXVD4EAvVhm9W8npOyCbjlUFC3cXN6bWvd5aMj5xGcqlIr8W8WeU1BflxvQuhB3hiN6gMzhHmHVkzK7eeBeXuoBk1f+hVKcaGjS3vsR9QN7i5rWCmJcp54vsR5jcyReEvoTbDP1h0xIbBV1Fw9OWCcYp1vV5v/I11x000hAJ13XKm89wgaNzV4VNqtA06QLv26lz+6jywQFR4IdQx4wKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz8DbwU4YH1GciOytEnrsRlJw+zfMPRCQNhAA2CiU+k=;
 b=eaudsuLisMXnnSNZ7hP3GYtNrCD2HArWfwz0TXK/FcdVn0eiwLZRnjcANp8rFvwsGDQx7bHTqC3yzHHvZeVhxYZ0+a+6CfOagOxIxDx/YFxJZ5gvEd56NaiRq1Cxj3SXVANeZwQpReixneSi6YofZBMwG3VWFQnAPNkGtALyJShNio/rM/r0kAmfrLYZzx0mZbVQwognfhITtLTep7ye0uqTZ187qa75lwmE2URKOQJiAbQvrbcuNQYsL/hLf9OhmE8fGYSI9ic/ckDSquWN3JEcWngWAmoi59SVvja5yTFpA/b9d08x7ayiCmzxUCsW0n/ZemliJH+qFEnRDydQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xz8DbwU4YH1GciOytEnrsRlJw+zfMPRCQNhAA2CiU+k=;
 b=PWECfeQ41C6zlcBv8XYtMEB9x6RVY+nhwgL+PL5Rl7qyK/tY0TRVInGciZFGBwduPfwWqz9rcbgkjiVftetpxrhFDvBo6tkLHpS9bOX4gbB+ji0+Awu5GIre5M47C1mWYBaiIFqeR7NrFv/OQc0pIQ3Af4k9XWOpPy/+AzAGzrI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7760.apcprd03.prod.outlook.com (2603:1096:101:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 05:43:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 05:43:37 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, Sjoerd Simons
	<sjoerd@collabora.com>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"simona@ffwll.ch" <simona@ffwll.ch>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "greenjustin@chromium.org" <greenjustin@chromium.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM driver
Thread-Topic: [PATCH] drm/mediatek: Disable AFBC support on Mediatek DRM
 driver
Thread-Index: AQHcRSTP8aynjdybb0+869rbUSjgaLTXEVEA
Date: Tue, 28 Oct 2025 05:43:37 +0000
Message-ID: <342e5ddad31da9f330110fd8a01699cb489d6c1e.camel@mediatek.com>
References: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
In-Reply-To: <20251024202756.811425-1-ariel.dalessandro@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7760:EE_
x-ms-office365-filtering-correlation-id: 22ac36aa-b241-4c2e-1669-08de15e4f0f5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|42112799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MDBILy91TElKbi8yMzA3YXdsWjFjVjhRWG5YcExZczJGcmtralNVMFdld3Bk?=
 =?utf-8?B?T0RSY2Q1bmt0eVBBakVIQXVmRVlKUkxTalZ0N1pXazArR2NYbFVscHgvSm5P?=
 =?utf-8?B?cHFsNFRObVI4Qk93NzNDZ1BYT2RyY0w1VG1aMjRZYTVuTVI0L1phK0F3Wjlw?=
 =?utf-8?B?NUdheE9UWW1JbzZ2bWJORllmaGEvb1FYSGE0aE8veFNmaXBUMDRlME5ESzRK?=
 =?utf-8?B?d0I3d3pTQ2ZRZXJhOHZRbGhLZDBaYVRVaXVRM0ZMaXhGb2YwblJvdnRrdjBI?=
 =?utf-8?B?djYvQ3FUaXRiS09ER0NRdUhJeXJ4cW1PdHJkaHRhZVZIdDhXRXQ3cG5tZXlC?=
 =?utf-8?B?NVdCYlhuVkw5MU9GWXNTUVdaZk4vTkt1b1J3cDYxUXFId2pkdmlYbURqZ09R?=
 =?utf-8?B?VzhmaWtUZWlQQ1c1RDF4NFVPVTBySURoV05zTDBOZ2RsQlB6MHNUTVZ5YjNO?=
 =?utf-8?B?NlBjT01PS29oM0pORzFSTEpLUEVUSktiZGJLNHRoSU5zTC9OS1czK25zRHVL?=
 =?utf-8?B?bVkxNmVSVlAxeUNrRG44WmEyaEtyTFVCTEJGbUpsTlZQODFBbkhCMWUvNk9R?=
 =?utf-8?B?V1Brek5rcDNTTFRVSDlkc1BxSkwvam45ektpSzZzOGFoRi9XOHNYRC90WE5G?=
 =?utf-8?B?QTN6WFRxQ3JoeU81UnhNaHp5V3U0ZUxTUlB4V2d6dTg2dnBpVWJkbWxMc0Mv?=
 =?utf-8?B?c3pvaVFSZTN4Z29YTWhzRDkvZTU5cW4weGdFd3UxM2FIZWZaRm1OR1dXV0JY?=
 =?utf-8?B?QVUyN2N3RDJZNlVzWkQ0cHNOUjRyMUxHODQ2Wll6QnhCOVZKeng0TjVtTUdN?=
 =?utf-8?B?akNHeVM3SFVvUUJ6SlIxU29yQnJybHptOExTOFpLamRDUWM4U28ybVNnZmJU?=
 =?utf-8?B?cUJOUnByNXQwSXVnMUtNeWRvWnNSRFRFaXAraFdpa21kc2s4a1llRXVuUTds?=
 =?utf-8?B?dDVseFFqRC8rWGFUZVdoZzZCK0hlZmozRzZrQllXbjBxcWNpOXNPdXN2YnJv?=
 =?utf-8?B?cWhESmdkMUM1dVQ1YW5QYnNiREFRbUk3V3puekRaay9wNTZhNklBamd2UFRH?=
 =?utf-8?B?N2VYSzlqb1puajluN20xZ2h1VFdoNm00OFFQK3k4ZWRHdW9uOWtkTkFTSmV6?=
 =?utf-8?B?Q1ZyRmJoUTJKWUgzaXRheWdud1lybUx3dTdSenVvWVBabHZjMlhCbFNKZGsz?=
 =?utf-8?B?Zi9MZWNGdk9DaFlObk92c1pwa1dXa3VEdm9JYkh5MitnZXl5MVB2L24raTUx?=
 =?utf-8?B?a0Erc3pFWFJld1VWV1M3YzZSczRsZkpLckQ1bWxuVWJQakppRHpzZThJTmN3?=
 =?utf-8?B?cDAvakpJWmhCMWo4RVdrb29WeTJoYysvRFVDV0RtUTVPNUdLclZidmxUSEcx?=
 =?utf-8?B?NFhQclB3Y3dicU9LYWpEYWlBUDZ1WkFBQWpNblpqSmI0VThvNzk0WWo5bCt3?=
 =?utf-8?B?L2pwWEhJMGxMNU9QdGtPU053dStsNUlXR0sxU001SWhHY1hjR0ZtemJ0NFBw?=
 =?utf-8?B?RTd2bVVKT1lKS2hscVF1dFV3b1JyYTdkeUt0dUVwRXd0aFRPckJTWW9qUmEx?=
 =?utf-8?B?eUhTa1NHNmg2NU5RRFpESEEzcklGdWpMOEM0OUZucFNRUC8xS2FnZmM1dmxD?=
 =?utf-8?B?WnpWNG5ORTdYRGJ1aFloR0ZRM2lyS0M5NkdlNzVya1JsaEtsVTFJOVZSNXhB?=
 =?utf-8?B?dW4vMjJQTjdXbGdHdXVpZGVaOU9vS3ZXNVFWWm5xYklpYnVzeEdvWmE1QmRk?=
 =?utf-8?B?VWdPeVdSZkNTZUFKRnNsa09uV0hZZUh1L1NIT2hOc3JXODh2T2hZMDZiajFC?=
 =?utf-8?B?ejBxMDBiZWZVMjRlbE9KWUVMWURkOE5XbGJ6ckRpTDhyTmk4NnpkZGNPaGdq?=
 =?utf-8?B?Z1FYS0trb1V3Z29QQTFRZHpDdWJrUHcybXdnelJIQmNqc3pCTlhPL29WdzNF?=
 =?utf-8?B?ci9NQnVnQlJQTUQycEJmUXBINEMyVjRSUkh5bzA5MVlVbjBqRGd3Zisvd1RR?=
 =?utf-8?B?UWZaMForTkxoYXFNcWluNHcrdStCYW9hZURsUjRjbzdaVHpZdTBIRy8zRDI3?=
 =?utf-8?Q?tEE+dT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODY4QkdLMVJYMTQ0MFFiUDI2azhiWENYbHk5NFoxRGkrWVFJMlJhZXlnSHRW?=
 =?utf-8?B?LzhtdWk5SkpwU2FHNVhBUGVDcko2VGljbUFPandCbkxMU09WZm1Ob2NuOExk?=
 =?utf-8?B?REpCUFBST0hBWi9xV1E0OEtSaVR4UnhzOHRKQ2VISHE1bE9WVUN4Z01OZ0VV?=
 =?utf-8?B?bndTL2Rxb1NqTG1qNm4xaVMwWldTeGhYVFh6NmtnTXRvVVo5aU9ESkN3YnZn?=
 =?utf-8?B?ZnYwTkNDVHdTZEVYSjE2Kzk1eFI1aDJNRnljemlRTm9hU3E2N2h4TDBaRHNQ?=
 =?utf-8?B?RW5Bb0UyMmhvZUlNbWw0aTBVNFNsdmlCTWJTY3ZpS1lLVGtpZGRRRzY5Slp1?=
 =?utf-8?B?LzZtalZyaXVkZUkvTVNnQmVOSGREQ3ZpR2Z1THNod0Q2bnZiYXdnZ2hkQWg4?=
 =?utf-8?B?eXlPekhBdGp4bG1DamdQM0RrdWRnWjNvUnpYYkIyR3BEM3QxbFJ5ZkY5MUN2?=
 =?utf-8?B?Nm15cEROdTBQL1U4cWJNbitSa0IzcC9VQnkwUy96OUVvb3pZNTNPckNwa3E2?=
 =?utf-8?B?ZmErdEJiN0htOFlIMTZ6cXdzaGVZTWFSQlRSb1drSjNJNE40UkRMdHh1TjhS?=
 =?utf-8?B?eTBGNmdXaWNLNTJZRURoNVZGUFRTRnlhNlVDRmUwbDJCcFFvRUtJREZEdkF0?=
 =?utf-8?B?clhYdWVzRmNxQTQ4VG1SUUM5T1orcWhvRjAxY1R6OXFkQXV1U0lTbDNGbTBL?=
 =?utf-8?B?K3lMQmk3bmNUblNQa1JEVEZnUVBpeFFVWUZtZHkrQjlZQnVrZXNSU3lEUFBI?=
 =?utf-8?B?aTQ0Z2dLK3BJSE42VVRvanpha2YyMFNvM3RhT3ZJSklFZXd6Z2lpT3p3SXk4?=
 =?utf-8?B?a2xHY0NnN0JpUlJxU2h2V0lIWmcrbU9HV29UM3VKc1pDV3FhM3VhOXlNN29S?=
 =?utf-8?B?OVorREQyTjgwRExIZS9JcjJzMzY5Sjl2Q2FMZzh5cWpKN3krcTRrZ1g5alh5?=
 =?utf-8?B?TkhzTzlhZmp6cDQwcDhzbnltRU1WeVZZVzJwL1BOWWVRclhFd3BKMzVsbFBG?=
 =?utf-8?B?Y0tVa0UrVTJKaHR0TGIrNG1VbUpUUGkyekhWU1BPZCtzTUVFR2VSYjJjNFcx?=
 =?utf-8?B?Z2FIRENHOGFFNjkyMzJDY1RENm42Wmt0emc4dkUvSWVjNmNwR3BvVzV4U2J0?=
 =?utf-8?B?eFVwK3lhbG4yeFZ2dEJIWkM3dEwzZ1ZOVE0xZmlMeXhhckxzNlI2SkhrWlNR?=
 =?utf-8?B?ZTJHeTBXNktkNzhRUHlpUjZ4ajh0UU5FcnBXWXpIU3lVS2xYL1VxZWN0TmdI?=
 =?utf-8?B?UUE5dnRUTSt1QnVwQjg0b3pVd25ackVqMTdkWGFwQ3c0amtJalNvTXRUdVpE?=
 =?utf-8?B?Rk44WENRRyt1QXBteUErUVZPcWxpQVNsUG1JVVU1R3E5RkR2d1I0enUydkdR?=
 =?utf-8?B?V0Y3WTkwVnJrTVE5VFRtMjlpZEFzRUhGbitYVm5vcWE0Z3pSaTFsSW5UTGE4?=
 =?utf-8?B?WXQ4M1VGTXk1dWY2VDQ4YWR0dVIwNDgzQ2NkMGdsQmk0NWRtS3ROaHd2bDRB?=
 =?utf-8?B?eUtHVXFMSHBBZkxxbzkvNEVRWEJoVys4R044eUZvVnhYekVVSnMwUXpaOUVD?=
 =?utf-8?B?Yk5xcTg2dlBncCtWVUhkaUp2MS90Sm9JNDVMZW1JVnV2NzVmSmJ0N2orbWR6?=
 =?utf-8?B?cTZUV3doaVp3LzJjRDB6aHRmcmc4U3d1TERXendYVjN0NFVqNWtDNS9WMlFj?=
 =?utf-8?B?SE5jZndyTzdDUW9jODkzVlJRMWlsNmhraXhuMjNKNmRpbUh4OXprb3ZqcDEz?=
 =?utf-8?B?YmN5TDNlWjI5WEhPejVhZGRRQXdnMGhtMXltSGo4bktvdGMvcGhtdEVLZm9z?=
 =?utf-8?B?akdFbXBTWERqb1RuNTVaOG5OUXpkdzEvR3lxV3Nwb1c0dThQbTRNNlVvQ1RN?=
 =?utf-8?B?UmJiS0VtOUxtQXk4MWZNQUlsclhvcGJJaUhLZFBhbGRkOERoa2FGdkJrZ0xG?=
 =?utf-8?B?QkVHQllrUTVLZVNrdnNlNm9mNHM5M3NlOHY0TVB2VzhSV2JLQ3VWNDlaY1FH?=
 =?utf-8?B?T0lGbzlGbk1zNGVkcFJUMGlqeHF4Uy9TTWtadDVoR2xaRzR6ckExaW1HdGtN?=
 =?utf-8?B?SmxBdGx6enV0ek5HZHJTQkFaVS95M1NaV2k3Yjl4RVBxYnlMWVVmVjJlMkN2?=
 =?utf-8?Q?NC9FvSs2xIFP2i5qsWN3eenVd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E153ADB9B5E474C90B46D9A2792B896@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac36aa-b241-4c2e-1669-08de15e4f0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 05:43:37.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NB9sHOiFnVDLZRtLPs+MtWb4ttWHoe7Hs5vcQsn6Lu3FQQWrjNM5ZqkMxLVj9+cSUpfaJS1+C4Kk1XgQqhy5Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7760

T24gRnJpLCAyMDI1LTEwLTI0IGF0IDE3OjI3IC0wMzAwLCBBcmllbCBEJ0FsZXNzYW5kcm8gd3Jv
dGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gQ29tbWl0IGM0MTBmYTliMDdjMzIgKCJkcm0vbWVkaWF0ZWs6IEFk
ZCBBRkJDIHN1cHBvcnQgdG8gTWVkaWF0ZWsgRFJNDQo+IGRyaXZlciIpIGFkZGVkIEFGQkMgc3Vw
cG9ydCB0byBNZWRpYXRlayBEUk0gYW5kIGVuYWJsZWQgdGhlDQo+IDMyeDgvc3BsaXQvc3BhcnNl
IG1vZGlmaWVyLg0KPiANCj4gSG93ZXZlciwgdGhpcyBpcyBjdXJyZW50bHkgYnJva2VuIG9uIE1l
ZGlhdGVrIE1UODE4OCAoR2VuaW8gNzAwIEVWSw0KPiBwbGF0Zm9ybSk7IHRlc3RlZCB1c2luZyB1
cHN0cmVhbSBLZXJuZWwgYW5kIE1lc2EgKHYyNS4yLjEpLCBBRkJDIGlzIHVzZWQgYnkNCj4gZGVm
YXVsdCBzaW5jZSBNZXNhIHYyNS4wLg0KPiANCj4gS2VybmVsIHRyYWNlIHJlcG9ydHMgdmJsYW5r
IHRpbWVvdXRzIGNvbnN0YW50bHksIGFuZCB0aGUgcmVuZGVyIGlzIGdhcmJsZWQ6DQo+IA0KPiBg
YGANCj4gW0NSVEM6NjI6Y3J0Yy0wXSB2Ymxhbmsgd2FpdCB0aW1lZCBvdXQNCj4gV0FSTklORzog
Q1BVOiA3IFBJRDogNzAgYXQgZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmM6MTgz
NSBkcm1fYXRvbWljX2hlbHBlcl93YWl0X2Zvcl92YmxhbmtzLnBhcnQuMCsweDI0Yy8weDI3Yw0K
PiBbLi4uXQ0KPiBIYXJkd2FyZSBuYW1lOiBNZWRpYVRlayBHZW5pby03MDAgRVZLIChEVCkNCj4g
V29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBjb21taXRfd29yaw0KPiBwc3RhdGU6IDYwNDAwMDA5
IChuWkN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkNCj4gcGMgOiBk
cm1fYXRvbWljX2hlbHBlcl93YWl0X2Zvcl92YmxhbmtzLnBhcnQuMCsweDI0Yy8weDI3Yw0KPiBs
ciA6IGRybV9hdG9taWNfaGVscGVyX3dhaXRfZm9yX3ZibGFua3MucGFydC4wKzB4MjRjLzB4Mjdj
DQo+IHNwIDogZmZmZjgwMDA4MzM3YmNhMA0KPiB4Mjk6IGZmZmY4MDAwODMzN2JjZDAgeDI4OiAw
MDAwMDAwMDAwMDAwMDYxIHgyNzogMDAwMDAwMDAwMDAwMDAwMA0KPiB4MjY6IDAwMDAwMDAwMDAw
MDAwMDEgeDI1OiAwMDAwMDAwMDAwMDAwMDAwIHgyNDogZmZmZjAwMDBjOWRjYzAwMA0KPiB4MjM6
IDAwMDAwMDAwMDAwMDAwMDEgeDIyOiAwMDAwMDAwMDAwMDAwMDAwIHgyMTogZmZmZjAwMDBjNjZm
MmY4MA0KPiB4MjA6IGZmZmYwMDAwYzBkN2Q4ODAgeDE5OiAwMDAwMDAwMDAwMDAwMDAwIHgxODog
MDAwMDAwMDAwMDAwMDAwYQ0KPiB4MTc6IDAwMDAwMDA0MDA0NGZmZmYgeDE2OiAwMDUwMDBmMmI1
NTAzNTEwIHgxNTogMDAwMDAwMDAwMDAwMDAwMA0KPiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEz
OiA3NDc1NmYyMDY0NjU2ZDY5IHgxMjogNzQyMDc0Njk2MTc3MjA2Yg0KPiB4MTE6IDAwMDAwMDAw
MDAwMDAwNTggeDEwOiAwMDAwMDAwMDAwMDAwMDE4IHg5IDogZmZmZjgwMDA4MjM5NmE3MA0KPiB4
OCA6IDAwMDAwMDAwMDAwNTdmYTggeDcgOiAwMDAwMDAwMDAwMDAwY2NlIHg2IDogZmZmZjgwMDA4
MjNlZWE3MA0KPiB4NSA6IGZmZmYwMDAxZmVmNWY0MDggeDQgOiBmZmZmODAwMTdjY2VlMDAwIHgz
IDogZmZmZjAwMDBjMTJjYjQ4MA0KPiB4MiA6IDAwMDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAw
MDAwMDAwMDAwIHgwIDogZmZmZjAwMDBjMTJjYjQ4MA0KPiBDYWxsIHRyYWNlOg0KPiAgZHJtX2F0
b21pY19oZWxwZXJfd2FpdF9mb3JfdmJsYW5rcy5wYXJ0LjArMHgyNGMvMHgyN2MgKFApDQo+ICBk
cm1fYXRvbWljX2hlbHBlcl9jb21taXRfdGFpbF9ycG0rMHg2NC8weDgwDQo+ICBjb21taXRfdGFp
bCsweGE0LzB4MWE0DQo+ICBjb21taXRfd29yaysweDE0LzB4MjANCj4gIHByb2Nlc3Nfb25lX3dv
cmsrMHgxNTAvMHgyOTANCj4gIHdvcmtlcl90aHJlYWQrMHgyZDAvMHgzZWMNCj4gIGt0aHJlYWQr
MHgxMmMvMHgyMTANCj4gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQo+IC0tLVsgZW5kIHRyYWNl
IDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBgYGANCj4gDQo+IFVudGlsIHRoaXMgZ2V0cyBmaXhl
ZCB1cHN0cmVhbSwgZGlzYWJsZSBBRkJDIHN1cHBvcnQgb24gdGhpcyBwbGF0Zm9ybSwgYXMNCj4g
aXQncyBjdXJyZW50bHkgYnJva2VuIHdpdGggdXBzdHJlYW0gTWVzYS4NCg0KUmV2aWV3ZWQtYnk6
IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFyaWVs
IEQnQWxlc3NhbmRybyA8YXJpZWwuZGFsZXNzYW5kcm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3BsYW5lLmMgfCAyNCArLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMjMgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19w
bGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5jDQo+IGluZGV4IDAy
MzQ5YmQ0NDAwMTcuLjc4OGI1MmMxZDEwYzUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX3BsYW5lLmMNCj4gQEAgLTIxLDkgKzIxLDYgQEANCj4gDQo+ICBzdGF0aWMgY29uc3QgdTY0
IG1vZGlmaWVyc1tdID0gew0KPiAgICAgICAgIERSTV9GT1JNQVRfTU9EX0xJTkVBUiwNCj4gLSAg
ICAgICBEUk1fRk9STUFUX01PRF9BUk1fQUZCQyhBRkJDX0ZPUk1BVF9NT0RfQkxPQ0tfU0laRV8z
Mng4IHwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBRkJDX0ZPUk1BVF9NT0Rf
U1BMSVQgfA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFGQkNfRk9STUFUX01P
RF9TUEFSU0UpLA0KPiAgICAgICAgIERSTV9GT1JNQVRfTU9EX0lOVkFMSUQsDQo+ICB9Ow0KPiAN
Cj4gQEAgLTcxLDI2ICs2OCw3IEBAIHN0YXRpYyBib29sIG10a19wbGFuZV9mb3JtYXRfbW9kX3N1
cHBvcnRlZChzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGZvcm1hdCwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90IG1vZGlmaWVyKQ0KPiAgew0KPiAt
ICAgICAgIGlmIChtb2RpZmllciA9PSBEUk1fRk9STUFUX01PRF9MSU5FQVIpDQo+IC0gICAgICAg
ICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gLQ0KPiAtICAgICAgIGlmIChtb2RpZmllciAhPSBEUk1f
Rk9STUFUX01PRF9BUk1fQUZCQygNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBB
RkJDX0ZPUk1BVF9NT0RfQkxPQ0tfU0laRV8zMng4IHwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBBRkJDX0ZPUk1BVF9NT0RfU1BMSVQgfA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEFGQkNfRk9STUFUX01PRF9TUEFSU0UpKQ0KPiAtICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiAtDQo+IC0gICAgICAgaWYgKGZvcm1hdCAhPSBEUk1fRk9STUFUX1hS
R0I4ODg4ICYmDQo+IC0gICAgICAgICAgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0FSR0I4ODg4ICYm
DQo+IC0gICAgICAgICAgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0JHUlg4ODg4ICYmDQo+IC0gICAg
ICAgICAgIGZvcm1hdCAhPSBEUk1fRk9STUFUX0JHUkE4ODg4ICYmDQo+IC0gICAgICAgICAgIGZv
cm1hdCAhPSBEUk1fRk9STUFUX0FCR1I4ODg4ICYmDQo+IC0gICAgICAgICAgIGZvcm1hdCAhPSBE
Uk1fRk9STUFUX1hCR1I4ODg4ICYmDQo+IC0gICAgICAgICAgIGZvcm1hdCAhPSBEUk1fRk9STUFU
X1JHQjg4OCAmJg0KPiAtICAgICAgICAgICBmb3JtYXQgIT0gRFJNX0ZPUk1BVF9CR1I4ODgpDQo+
IC0gICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0NCj4gLSAgICAgICByZXR1cm4gdHJ1
ZTsNCj4gKyAgICAgICByZXR1cm4gbW9kaWZpZXIgPT0gRFJNX0ZPUk1BVF9NT0RfTElORUFSOw0K
PiAgfQ0KPiANCj4gIHN0YXRpYyB2b2lkIG10a19wbGFuZV9kZXN0cm95X3N0YXRlKHN0cnVjdCBk
cm1fcGxhbmUgKnBsYW5lLA0KDQo=

