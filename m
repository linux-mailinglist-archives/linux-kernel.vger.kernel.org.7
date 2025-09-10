Return-Path: <linux-kernel+bounces-809829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9F9B5128C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5995346013A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1C3128A4;
	Wed, 10 Sep 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hFSuyrEK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rUzTCR0+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB230504C;
	Wed, 10 Sep 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496810; cv=fail; b=NiBZWhe/i6F4Lc82b0CxhbbcxmiG5b5xtT08t1mC32AtQ1iVV6KqAHTSmH8jKqp5pxIUPZcQQZ5bwolqHJAeIXtCPjzzgfkJlSiDKtNp+QsphA7cWWmv+f1dVi8R1aeIetFcdlruhxiIKuxQpP/iWdeik9WX21K78eE9Bojppto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496810; c=relaxed/simple;
	bh=6S1a8FJMDQnp2rJRnIf0KheHvoBLln6FRHglUczKIDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oUReuCwT3CO2BOmhYyhpdjCYhqkUAZoVZq0O4KHRy4qugt/HbPYU+27JzF9FNCWqrqjlPyxCX2RDmfPV3fFGjjacaNem7HOeJ8VYk8qQQVFOEnrNNe8bVZr5YK4LiO0ddxslwVns7l86fdMjNGFUrSludgeiQv/jg8tJFTqr/b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hFSuyrEK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rUzTCR0+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 143d0b888e2711f0bd5779446731db89-20250910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6S1a8FJMDQnp2rJRnIf0KheHvoBLln6FRHglUczKIDY=;
	b=hFSuyrEKLSFCNWir0AUuimd/LMYqKL+5lqPaDQMsr7DWhFn9wyvifyw1zeuYZ6NmNEnPvrgd7pLVkG7ZbWNt1njGgHdoLTStI5LT9BcdGNT0dmDxrMQXBP1Pty2sRGpYvQLVhbNGTA82MLE+3grcGovtjPbfV9NQWW5Am+XwKxQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:0fefe508-87f1-4044-9713-0b6d6d685080,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:e3b8a284-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 143d0b888e2711f0bd5779446731db89-20250910
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1242347924; Wed, 10 Sep 2025 17:18:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 10 Sep 2025 17:18:12 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 10 Sep 2025 17:18:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbPpsNNJKS0u1L4Tb7q+Hq0iUIwCauXKDvivwZA/2tXrXCpMrtbz0mF2KQDW73SNm+HQB+BGM2gowLt/DDQz11a2E0aHdziJefw5IKM++boPeQti3zZzhK4LV1tOOIRlUM+FstI9dcBpY0PWGcEuqk4x/GQydS4iLNJ29s8MTu5DshvvvItLyttkSOEGHzDW4yrfCkdkpM9Hqnuwf9MkPIpfjiXjPB+mxKgP6UR3G82dJbz1gofPZiu0l/9NE8oVFvmrMphfcDl9HopDhsypafpgdRFls1ceTjoBC32JWfmGA5t5MqblljXynjf9f+APc+jypQoRcgqRcULPYXBKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S1a8FJMDQnp2rJRnIf0KheHvoBLln6FRHglUczKIDY=;
 b=vNixufwypljiwYqd/1n7eazSLEWZfhWvApxcInEfR9EtiXjjvHz78XDJoNRz6tIR9HrZAOrlbUYF+UzetBPqq3kPzW+/xVg8MFi2AxAT9yjFHmm9/zlQGnp7n1hGr0U2KIv3fZapd1/Q/RZFMPfsFXAIvxA1s8D7Qqy7DjU2kx1Yq5Cll9oWHCTmFEA6NoGcNcdBKPTymaDbN4yrKaJFh0+2eO16YCKG7ykXOCi4tZtDsLiJWWJHDJy1tVgXQsBoMOzwCGij83xrgkll/TBI/O9xjnwXBQRn1GZYOGEXPuHhm+gBEHAjNyByHFTUd2uHS1YGKP/wYn+GQXiHNt6Tbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S1a8FJMDQnp2rJRnIf0KheHvoBLln6FRHglUczKIDY=;
 b=rUzTCR0+fWsg3MQ6uVaoFxjFwB7toqraS7U+YygpmbIPUyEsAiGSzRA9qwtcbfEYxAaMvMFXZDc/mavptlsOSttZTmhfSkHUrNpSygI4fM9eALVEd4Qz6klcIfas1BL53KP+c3mM84GS2h2aGaTtAoLLSADK6JZBDf3PFd9JZes=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8614.apcprd03.prod.outlook.com (2603:1096:405:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 09:18:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 09:18:09 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v4 13/19] drm/mediatek: Export OVL Blend function
Thread-Topic: [PATCH v4 13/19] drm/mediatek: Export OVL Blend function
Thread-Index: AQHcF/M9ImtqKzASQkuVvYlDwzOQ/7SMN70A
Date: Wed, 10 Sep 2025 09:18:08 +0000
Message-ID: <a13a968227214194b7033795a07ad554bfacfc8a.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-14-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-14-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8614:EE_
x-ms-office365-filtering-correlation-id: 611ebe23-cd52-4362-019e-08ddf04af54f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|42112799006|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZHRSeEhIaGxsV0x0RjB6TGxPU2lNRVBkQVVIRzhub0VKakZacWRJVEw2cmE4?=
 =?utf-8?B?VGE2QjFLL3FRYldaYzBxY2QwVSs3TEtUZThON1ZKSGxhRTVpcFV1c3Iva0VG?=
 =?utf-8?B?ZUc5TnNzSndZMDllbVNTRk8wckNPNU03cFB6V1ZJVUpnWENMREZra1ZFaURD?=
 =?utf-8?B?dlhnSTlGNDdKMkxjZ2FKT1NIVjJLRHRCK09qeSs2T3BrVGtSY05rUFQ4OUxZ?=
 =?utf-8?B?VUFTTGVxQ0ZZWkJBQjRyMHEyLzd5SWNUVFdkaEJqbFhHb0lhY2Ryb0NsSVEv?=
 =?utf-8?B?SlhOWjFmd3VLOFNxWFNRYUhUV09tM0IvejVrRnhMV2pIWlkvWk1vZEVEWGdY?=
 =?utf-8?B?OTQ5Z21YQTVJZDZGQW5WcS91UU9FRDlsTGx1cWVReisxaTZBOXBlUnk2M3NJ?=
 =?utf-8?B?cGlGbjNiOXUvTTlYaVJUdVplM2IzUW9LTzk1dWc1WW5KUm9xT0xuZmVUMC9r?=
 =?utf-8?B?bm9nN1FVVnlVQU16MjFRNUtvZXl5MEZsS2N2WllPcVAyNGNOTVRYS2djRUJN?=
 =?utf-8?B?MzRPWnBhUTVhanBLc2VkQXE5S001dGMrVm5pR01TeU4yazJObm1OdjEza2tl?=
 =?utf-8?B?NVBBc3E5aElhTUJDYi9MTHpNNHJmS292V2JYOEI0UGZCYXFRUUhvLzhxQTln?=
 =?utf-8?B?NWx6UTU2YS9BMDZHakh5cnRJMHBUWFRUT2llQnVZV3Bsd0xFcmQ4UVEvdDRC?=
 =?utf-8?B?Z2JCbXoySmFkTG02dkNpZGVuSDQ0NmdDTGlEM05mMHdNN0lrdWRKejFHSXpa?=
 =?utf-8?B?bndnazR6TTRRcVFTMVVrSWJLeUk2NVVVVStvVW9hKzIvVEFsU1QyYW1RRmVR?=
 =?utf-8?B?N2hqUnRxTmt0ck1vQi8xRTFzOEtsN1JPSVU1MWlxTVIxS2xucWtUL1k0eW1V?=
 =?utf-8?B?ZXYvUUFyMTluV29Zb3NOc1hjbEtITStUdHR4SlMzOXJxYmtKWHhXNXZZc0tR?=
 =?utf-8?B?TDczSTV3WllKTjdad2o3SGZOSDB4cWgyRkpJZENGRkdjY3hmTTNUQW8ydno4?=
 =?utf-8?B?dmhOZzJxWFZodlFYUGE2dDlVeXRyb2ZjU2gwNWlMNCt1KzJZa1lMTnNvdXFl?=
 =?utf-8?B?SUducUNSbFNxb2Z6a1F0VkNHVGFhbmRkV2FzdE5vdWx2UmV1VFM0Y3I4OXcy?=
 =?utf-8?B?d0ZRVmZVbUlEU3lJb2pRSmtNR25ETTcrV0pZVUJzaEhsNDJsbU1YU2hWYVFU?=
 =?utf-8?B?RGZOZnRvcTNUSElZell2QmtEYnQ0RDdOSlA1TkRCZTIxV2RRbU9BTGNaMzhs?=
 =?utf-8?B?RTVpaG53WGNnYlBraitsLzFKanM3S0tuRWtrVllnOFRSbm1BV0hibGdUNU1V?=
 =?utf-8?B?RHFLRFh0VjNMQ0FFYUY5S3FsZjVLeThUUEt5MWY3SkpjVzlVdVRIemFKNDBT?=
 =?utf-8?B?S2tzMVloNU1hRGxqMzUyMitaYStDODhvYWpsOWtYWEhobDZHekcwS2NUUTVR?=
 =?utf-8?B?RGFCNmtUM1lzS3B5ZDJLVVk4SXl3N0EzYmRJRE9qSEVIazZzeWpsNTIwMDRI?=
 =?utf-8?B?cHFDcDdJa252bDhBNU80MEJyZjZoMUcvRTRrNW5HcVR6cE8rWXFTTjBGbEtk?=
 =?utf-8?B?YWVvVTJzcEVoU3d0ckZHMk9iMjNhUEdaSFVqTFRUc3ZqUHBHYXplajlJa3I4?=
 =?utf-8?B?b1RKS2tuc0FVdWYvQjBaS2NYQUVWeWFEdzB1L1JKYmJnWnVFRCtOQVNLK2E3?=
 =?utf-8?B?c2lCQU1HRlBCTXlyQmU0dDI5Ny9jWWh6Tk92Qk55d1BxVFZtUXhXajlGbDNV?=
 =?utf-8?B?RGpyZ1JOeDNjcTRXbHRvRVFvRCtKaU5TaVJaVzYvZDFJRWhML3BUc3FiNG11?=
 =?utf-8?B?eHJXcW44T1ZBdVpWZnhPYkxETk03eUtRbzRDRVUvNFJzRk4zSDhCaldxVjQ5?=
 =?utf-8?B?MUZwV2trTGlVQnRFYnpKRkZVRmovTHh1cS95VkszUVcxcHdyRUw4NXh2VDhB?=
 =?utf-8?B?QXR1MUhqa2RkWVdSUldFcTdVT05FODdIL1NlSkw1WmxrN1FyQXlyaUZJZUFU?=
 =?utf-8?B?WG9tbCtHTE13PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(42112799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTh2NStuNUpyWjNiNlBEUW9OZDkxT3QxcmNySkpxQTIwUGl4a044aUZZYUth?=
 =?utf-8?B?WmMzY3VxdlQ0Mk5meDlBay9HR0d1NnovUm5zMXByV2FHRUl3andmcTVOL3FC?=
 =?utf-8?B?SHNKbHA2T1hFemJPSHlrUzhlV0JoOUc1c1loOFRrYkdkZkRxc3NMMkl6WVNz?=
 =?utf-8?B?ekZrU1VoVjIxZ21ZWjc2RXV3ZDh1czQ4V3NSTGxxd0drL2pFbmVlVE1nWDFr?=
 =?utf-8?B?MWpxTWhyOFFCTDd5azlzV2Y1M0ZhWStUbWJKVHlDUEZOL25RNmRObkM1alg5?=
 =?utf-8?B?K2FkRlBQSlY0aU5XY0g3bk90b0NTVGJLaVNSTFlIcTlmc3BySjFQOVVNbXNm?=
 =?utf-8?B?cThLM0V2eFhWMU56UURNSTZObVZxclNJcTZJdjJNaXNrVzVQSGxjay9lMTZx?=
 =?utf-8?B?dWdQNWVXZzJuYTdjNXhaQmRVaDJyck9DWXhpQ2wwSXNKK3RpdVN5L0d1bVVp?=
 =?utf-8?B?ck01UmZhREZBTzU5RzlNT2dTTkozbGszQTlPamNnQTVITXVOSngzYkU2d3dU?=
 =?utf-8?B?ME1KejdwUWFTVHZENHAyNEtnL0ViMEJuaFNRbzVFVGtYMHZWSXNCTEJGYkd5?=
 =?utf-8?B?RHdkZ25ibDc2SkROQlpEYmJ4bkoremY0L3k3Ykt3MG9uTHVzUEhLcmRpT0E0?=
 =?utf-8?B?cDVYdExIemxtVThRRGNyajNkTzMvUmNvVkdNVXdVbXZpYXo4cStVak9Ud0ds?=
 =?utf-8?B?T0Vkd2R0UWtIR0M2QXp5b2djTEdiLzEwMDNyaUl6ZDZSdG1qQTBkWjdNUkdp?=
 =?utf-8?B?b1RMQTFscGoxTnBKcklQWVg2Kzk5REhuVTVycVVpdlZ6T1dZOUtnOG5QT0hY?=
 =?utf-8?B?V0FmdTRacVdKNDZBenk3d0pZbHFLa1greXc1VmhxYTh5Z2hZVWVLRVlmOEN2?=
 =?utf-8?B?L2dZNjJDcU9wQUI0S1hmMjhGajdjT29Ra25LZmRkdmtzQW1JWWdJQ00zQnNU?=
 =?utf-8?B?U1AwVzBOMkpoV2ZkdzFwWDNTQmNFQTU4MHRNZlp6NWM4WnVScUhacW9nZlgz?=
 =?utf-8?B?WWx5cWg2MUhVVW5qLy9xbENKZk13UDJXaDVnQzR2T1gySlVNZzhmS1VSTDI1?=
 =?utf-8?B?SVJNbHhjUVh6SjBMRU8rZ0I2aklLSHRyWGFsUTRzTXJpSDFLMC9JVEVabEc0?=
 =?utf-8?B?Ym9pMTVvZ0xOdlJzYm5mTm5sMytVcjlwcWlyY0NUNEF0VzVlaktoS3hDNW9M?=
 =?utf-8?B?QlFqVjJJMTZIU0NpNVlMR0Rac2k3aENOcUhyMkYreUhkSmFmbCthdHhjNEh5?=
 =?utf-8?B?RlZ0ZktLUWE5RGdjdU10WldrR0JhWEcwT0Y2MFpYVTA4QnRiTTR2QjlReE1V?=
 =?utf-8?B?b2t0Rk1WRXpWZkdDZFV3WW9LMGZPWmJhYXVVS2pvb21xR1BnRzdTWnVVUS92?=
 =?utf-8?B?QndYOTZLRDNiVkRscVZZdXNBU2VIRHNPZHRFREpObTB4V1ZTMzFHVUxycVVY?=
 =?utf-8?B?cDdCV0ZyMFRLeURYT0p2K1g3WXNHbnlKUWJkT2E0NlliWFlRRTlucmFRZHVr?=
 =?utf-8?B?SUJVcjNPb3o5YWJrRGxXNjNtZXMyZnM3R25IMklTcGVaWlE0QzZYZmhoRm56?=
 =?utf-8?B?NmFHeXdXbTJPQjgrdmhzSS9sNnptU09kS3FKTFkrbDRnVWh3a2xEV3lxUUl0?=
 =?utf-8?B?Uk9vWjg4V2I2b3VGUjdQLzFOK1hYZmhHdEpXUnVzc3ByeEdjS0svaFpxbzYw?=
 =?utf-8?B?c29FNzFFcm5PdHNJaEk1TWpBOGJvSWdTOVBobWlRbWZ4c1JBbElEaDlVVU1h?=
 =?utf-8?B?bDN5SC9sK1p5ZGVQNGN1dnU5TWxBa2dEcVU3Wmd1R3pXazhHYzRSRWQ3R2xm?=
 =?utf-8?B?ZW5TYnVMOWlITHl2VFlxVEVzZ0xtMzNoMkpiWFAxdkVVZ2VmbExNNEpCODlQ?=
 =?utf-8?B?eDBXZ2Q4NHNKa0NXTEZjRjJsNUdJOUFhUVA3ak9PRkNFaFBTcGVXUjVRMjNw?=
 =?utf-8?B?cW1hcmhuODFIUnhWdFZtRzNYT2pOL0NXVHV5YXBFTEg2bkovbFpob242SzJ3?=
 =?utf-8?B?Wkpnb09mdWV3VkphOWFyNWR1SndjOWpsTVNuUUIza2RwL2d0VUJQWmtGYVhh?=
 =?utf-8?B?TE94M3RlK2xuUXdDTHQrT3d1UVZLWUZXeG4vQXc5S2lMVUNvUnBOcmdrRmFz?=
 =?utf-8?Q?VveLN3rvqHRMv4Lvvo487sx+9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1CD15FEF56B3840810DA04DECC4DA84@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611ebe23-cd52-4362-019e-08ddf04af54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 09:18:09.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMJrToOjuoichhR/Ei/sPn2Pjfc6mX2Udtk/sgBIs3X4lq2x8k0i780YPt9jmFbx76HC601wFj9pMDGpbtNOxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8614

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEZvciB0
aGUgbmV3IEJMRU5ERVIgY29tcG9uZW50LCB0aGUgT1ZMIGlnbm9yZSBwaXhlbCBhbHBoYSBsb2dp
Yw0KPiBzaG91bGQgYmUgZXhwb3J0ZWQgYXMgYSBmdW5jdGlvbiBhbmQgcmV1c2VkIGl0Lg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwtcGwuY2hlbkBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIHwgNjggKysr
KysrKysrKysrKysrKystLS0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5oIHwgIDggKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyks
IDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYw0KPiBpbmRleCBlM2VlM2Y2MGY0YmEuLjdjZDM5NzhiZWI5OCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiBAQCAtMjI4LDYgKzIyOCwyMyBAQCB2
b2lkIG10a19vdmxfZGlzYWJsZV92Ymxhbmsoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXdyaXRl
bF9yZWxheGVkKDB4MCwgb3ZsLT5yZWdzICsgRElTUF9SRUdfT1ZMX0lOVEVOKTsNCj4gIH0NCj4g
IA0KPiArYm9vbCBtdGtfb3ZsX2lzX2lnbm9yZV9waXhlbF9hbHBoYShzdHJ1Y3QgbXRrX3BsYW5l
X3N0YXRlICpzdGF0ZSwgdW5zaWduZWQgaW50IGJsZW5kX21vZGUpDQo+ICt7DQo+ICsJaWYgKCFz
dGF0ZS0+YmFzZS5mYikNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBB
bHRob3VnaCB0aGUgYWxwaGEgY2hhbm5lbCBjYW4gYmUgaWdub3JlZCwgQ09OU1RfQkxEIG11c3Qg
YmUgZW5hYmxlZA0KPiArCSAqIGZvciBYUkdCIGZvcm1hdCwgb3RoZXJ3aXNlIE9WTCB3aWxsIHN0
aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVtb3J5Lg0KPiArCSAqIEZvciBSR0I4ODggcmVsYXRl
ZCBmb3JtYXRzLCB3aGV0aGVyIENPTlNUX0JMRCBpcyBlbmFibGVkIG9yIG5vdCB3b24ndA0KPiAr
CSAqIGFmZmVjdCB0aGUgcmVzdWx0LiBUaGVyZWZvcmUgd2UgdXNlICFoYXNfYWxwaGEgYXMgdGhl
IGNvbmRpdGlvbi4NCj4gKwkgKi8NCj4gKwlpZiAoYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVO
RF9QSVhFTF9OT05FIHx8ICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+ICsJ
CXJldHVybiB0cnVlOw0KPiArDQo+ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiArDQo+ICB1MzIg
bXRrX292bF9nZXRfYmxlbmRfbW9kZXMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCXN0
cnVjdCBtdGtfZGlzcF9vdmwgKm92bCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiBAQCAtNDE0
LDYgKzQzMSwyOSBAQCB2b2lkIG10a19vdmxfbGF5ZXJfb2ZmKHN0cnVjdCBkZXZpY2UgKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gIAkJICAgICAgRElTUF9SRUdfT1ZMX1JETUFfQ1RSTChpZHgp
KTsNCj4gIH0NCj4gIA0KPiArdW5zaWduZWQgaW50IG10a19vdmxfZ2V0X2JsZW5kX21vZGUoc3Ry
dWN0IG10a19wbGFuZV9zdGF0ZSAqc3RhdGUsIHVuc2lnbmVkIGludCBibGVuZF9tb2RlcykNCj4g
K3sNCj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdF
Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBGb3IgdGhlIHBsYXRmb3JtcyB3aGVyZSBPVkxfQ09OX0NM
UkZNVF9NQU4gaXMgZGVmaW5lZCBpbiB0aGUgaGFyZHdhcmUgZGF0YSBzaGVldA0KPiArCSAqIGFu
ZCBzdXBwb3J0cyBwcmVtdWx0aXBsaWVkIGNvbG9yIGZvcm1hdHMsIHN1Y2ggYXMgT1ZMX0NPTl9D
TFJGTVRfUEFSR0I4ODgNCj4gKwkgKiBhbmQgc3VwcG9ydHMgcHJlbXVsdGlwbGllZCBjb2xvciBm
b3JtYXRzLCBzdWNoIGFzIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OC4NCj4gKwkgKg0KPiArCSAq
IENoZWNrIGJsZW5kX21vZGVzIGluIHRoZSBkcml2ZXIgZGF0YSB0byBzZWUgaWYgcHJlbXVsdGlw
bGllZCBtb2RlIGlzIHN1cHBvcnRlZC4NCj4gKwkgKiBJZiBub3QsIHVzZSBjb3ZlcmFnZSBtb2Rl
IGluc3RlYWQgdG8gc2V0IGl0IHRvIHRoZSBzdXBwb3J0ZWQgY29sb3IgZm9ybWF0cy4NCj4gKwkg
Kg0KPiArCSAqIEN1cnJlbnQgRFJNIGFzc3VtcHRpb24gaXMgdGhhdCBhbHBoYSBpcyBkZWZhdWx0
IHByZW11bHRpcGxpZWQsIHNvIHRoZSBiaXRtYXNrIG9mDQo+ICsJICogYmxlbmRfbW9kZXMgbXVz
dCBpbmNsdWRlIEJJVChEUk1fTU9ERV9CTEVORF9QUkVNVUxUSSkuIE90aGVyd2lzZSwgbXRrX3Bs
YW5lX2luaXQoKQ0KPiArCSAqIHdpbGwgZ2V0IGFuIGVycm9yIHJldHVybiBmcm9tIGRybV9wbGFu
ZV9jcmVhdGVfYmxlbmRfbW9kZV9wcm9wZXJ0eSgpIGFuZA0KPiArCSAqIHN0YXRlLT5iYXNlLnBp
eGVsX2JsZW5kX21vZGUgc2hvdWxkIG5vdCBiZSB1c2VkLg0KPiArCSAqLw0KPiArCWlmIChibGVu
ZF9tb2RlcyAmIEJJVChEUk1fTU9ERV9CTEVORF9QUkVNVUxUSSkpDQo+ICsJCWJsZW5kX21vZGUg
PSBzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlOw0KPiArDQo+ICsJcmV0dXJuIGJsZW5kX21v
ZGU7DQo+ICt9DQo+ICsNCj4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX2ZtdF9jb252ZXJ0KHVuc2ln
bmVkIGludCBmbXQsIHVuc2lnbmVkIGludCBibGVuZF9tb2RlLA0KPiAgCQkJCSBib29sIGZtdF9y
Z2I1NjVfaXNfMCwgYm9vbCBjb2xvcl9jb252ZXJ0LA0KPiAgCQkJCSB1OCBjbHJmbXRfc2hpZnQs
IHUzMiBjbHJmbXRfbWFuLCB1MzIgYnl0ZV9zd2FwLCB1MzIgcmdiX3N3YXApDQo+IEBAIC01NDEs
NyArNTgxLDcgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYs
IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJdW5zaWduZWQgaW50IHJvdGF0aW9uID0gcGVuZGluZy0+
cm90YXRpb247DQo+ICAJdW5zaWduZWQgaW50IG9mZnNldCA9IChwZW5kaW5nLT55IDw8IDE2KSB8
IHBlbmRpbmctPng7DQo+ICAJdW5zaWduZWQgaW50IHNyY19zaXplID0gKHBlbmRpbmctPmhlaWdo
dCA8PCAxNikgfCBwZW5kaW5nLT53aWR0aDsNCj4gLQl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9
IHN0YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGU7DQo+ICsJdW5zaWduZWQgaW50IGJsZW5kX21v
ZGUgPSBtdGtfb3ZsX2dldF9ibGVuZF9tb2RlKHN0YXRlLCBvdmwtPmRhdGEtPmJsZW5kX21vZGVz
KTsNCg0KV2h5IHlvdSBjaGFuZ2UgYmVoYXZpb3IgaGVyZT8NCk9yaWdpbmFsbHksICdibGVuZF9t
b2RlID0gc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZScgZGlyZWN0bHkuDQpCdXQgdGhpcyBw
YXRjaCBhZGQgYSBjaGVjayBhbmQgYmxlbmRfbW9kZSBtYXkgYmUgRFJNX01PREVfQkxFTkRfQ09W
RVJBR0UuDQpUaGUgYmVoYXZpb3IgY2hhbmdlcy4gV2h5IGNoYW5nZSB0aGlzIGJlaGF2aW9yPw0K
DQo+ICAJdW5zaWduZWQgaW50IGlnbm9yZV9waXhlbF9hbHBoYSA9IDA7DQo+ICAJdW5zaWduZWQg
aW50IGNvbjsNCj4gIA0KPiBAQCAtNTY2LDE3ICs2MDYsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJf
Y29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJICogRm9y
IGJsZW5kX21vZGVzIHN1cHBvcnRlZCBTb0NzLCBhbHdheXMgZW5hYmxlIGFscGhhIGJsZW5kaW5n
Lg0KPiAgCQkgKiBGb3IgYmxlbmRfbW9kZXMgdW5zdXBwb3J0ZWQgU29DcywgZW5hYmxlIGFscGhh
IGJsZW5kaW5nIHdoZW4gaGFzX2FscGhhIGlzIHNldC4NCj4gIAkJICovDQo+IC0JCWlmIChibGVu
ZF9tb2RlIHx8IHN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkNCj4gKwkJaWYgKHN0
YXRlLT5iYXNlLnBpeGVsX2JsZW5kX21vZGUgfHwgc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFz
X2FscGhhKQ0KPiAgCQkJY29uIHw9IE9WTF9DT05fQUVOOw0KPiAtDQo+IC0JCS8qDQo+IC0JCSAq
IEFsdGhvdWdoIHRoZSBhbHBoYSBjaGFubmVsIGNhbiBiZSBpZ25vcmVkLCBDT05TVF9CTEQgbXVz
dCBiZSBlbmFibGVkDQo+IC0JCSAqIGZvciBYUkdCIGZvcm1hdCwgb3RoZXJ3aXNlIE9WTCB3aWxs
IHN0aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVtb3J5Lg0KPiAtCQkgKiBGb3IgUkdCODg4IHJl
bGF0ZWQgZm9ybWF0cywgd2hldGhlciBDT05TVF9CTEQgaXMgZW5hYmxlZCBvciBub3Qgd29uJ3QN
Cj4gLQkJICogYWZmZWN0IHRoZSByZXN1bHQuIFRoZXJlZm9yZSB3ZSB1c2UgIWhhc19hbHBoYSBh
cyB0aGUgY29uZGl0aW9uLg0KPiAtCQkgKi8NCj4gLQkJaWYgKGJsZW5kX21vZGUgPT0gRFJNX01P
REVfQkxFTkRfUElYRUxfTk9ORSB8fCAhc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhh
KQ0KPiAtCQkJaWdub3JlX3BpeGVsX2FscGhhID0gT1ZMX0NPTlNUX0JMRU5EOw0KPiAgCX0NCj4g
IA0KPiAgCS8qDQo+IEBAIC02MDIsNiArNjMzLDkgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2NvbmZp
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICANCj4gIAltdGtfZGRw
X3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGNvbiwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywN
Cj4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9DT04oaWR4KSk7DQo+ICsNCj4gKwlpZiAobXRrX292
bF9pc19pZ25vcmVfcGl4ZWxfYWxwaGEoc3RhdGUsIGJsZW5kX21vZGUpKQ0KPiArCQlpZ25vcmVf
cGl4ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICAJbXRrX2RkcF93cml0ZV9yZWxheGVk
KGNtZHFfcGt0LCBwaXRjaF9sc2IgfCBpZ25vcmVfcGl4ZWxfYWxwaGEsDQo+ICAJCQkgICAgICAm
b3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUElUQ0goaWR4KSk7DQo+ICAJ
bXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBzcmNfc2l6ZSwgJm92bC0+Y21kcV9yZWcs
IG92bC0+cmVncywNCg0K

