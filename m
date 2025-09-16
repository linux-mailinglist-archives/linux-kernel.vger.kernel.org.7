Return-Path: <linux-kernel+bounces-818205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1CCB58E35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959CB164F78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FA23D7CE;
	Tue, 16 Sep 2025 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KjYVbkXh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QVgDcNsL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB6C101F2;
	Tue, 16 Sep 2025 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758002477; cv=fail; b=XYbaMCo3NWqxZ3nI898rTVnMUCaPHGTSgGcJXrPOTQK66WIb48F79FzwIhjOqCo4d6Gn8IPDVT1wJ4knLCU/tD5UTUm5AFXs8VibiflqFGDV2D5+Nh13uqF5E0Ntcgye8rFoZvvsCN2kT/1WANdoGdT80CFGM0pK2xnJtALlbnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758002477; c=relaxed/simple;
	bh=ETJM2oP8WhluQs9e44QRp2uJWYNXSmjrLlhueTZH68I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LpXiEJA+iGR+sQRs+tJCguk0oPSASqJq25AVOp03o1NBHRrm/4jHyMJEr0p33m8+QOZ2PJKMO3+ttwd1nfvWNg0qKmJVjDSzK+Qvr6KAUHrdUXAQJUUY2B/gVnDcb8+Wo3nm+MLrq7gs1JC53mLZfry/xpEk3t8/vlN0byBFJXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KjYVbkXh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QVgDcNsL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 896159d892c211f0b33aeb1e7f16c2b6-20250916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ETJM2oP8WhluQs9e44QRp2uJWYNXSmjrLlhueTZH68I=;
	b=KjYVbkXhTohkqUVeb+EPhir5ruHP6+EOwQOSyEqnokcMUD3Ton9smkn0+RhmojoqulxS+KoIi1z4jHijfo2avNd7liDMuAp9Ijrp1Y1tmswPwI9byra4CfFg+j2/7o54Da+6pG30HxjUeyqUycYBRNkk1Fc3rlZ++kJjuACOcs8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:b1190962-fe3b-4fa4-88bb-b8d85d49194d,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:43795da9-24df-464e-9c88-e53ab7cf7153,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 896159d892c211f0b33aeb1e7f16c2b6-20250916
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 466264410; Tue, 16 Sep 2025 14:01:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 16 Sep 2025 14:01:05 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 16 Sep 2025 14:01:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cu2uJJLXU+Kg3Y1mkszy5+0DLEp6hx0r6H5a9pTJqD0nBUHoD+iseHLG0OxhR9CkclFp/Ju4DkQZ8HhauLp81ilJ+bm4oVRN2xKZ8u8QBcgqXGJdw7XVEY4nWyOYXtcAhWhry2w94/ou4Kfj06sMNZ7MY1SEQ/tIV8sWBK57FIlN/shEXdoUK2+pPYphYEjGIvGk6zIwm5Z3OBlxWe9eR4l+2dAbnNjYsRowDUawqo0ESWUQ9TR4ki5Q6MiL1eXOlty1Re0ocgq+6kDgBKZQgN+G5Rg4IueLr+r4593UC0K2vToRqacctzUH6HaTSDdBMJ5oZIA6Dkc6ek+kdVaaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETJM2oP8WhluQs9e44QRp2uJWYNXSmjrLlhueTZH68I=;
 b=s5fa/0TXbI2XPBNF1/+pm+ya35/M//c01LPPp+atLbGkoSFxihpTfHYPL4VksUhy4FgiAdNYHCVuLiRp2Yb1RO3Nv7U5jAbgBcp8rc9NnAFYKjaz9u2GwZ1l75EI/LYPien8XE5NbzrvH85aDiiMbDEerks+OEFRenhmhXLQCKarglEdPD+pCNRx93hmrq1Xh1P9u8seVTwABr4oALaDZ31uhopglI/dezYCy/+S69SVI+/2qBE1SAv5r2DKg4gMVOHYpY1wKH441aQQBJ5dvk61ZQwiXNQEdeby6oQB6NnNB19tgbpmDYuphREa6w/tq/3rSYC+y0/8YeWu9AOTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETJM2oP8WhluQs9e44QRp2uJWYNXSmjrLlhueTZH68I=;
 b=QVgDcNsLMCQi5yPCS1X4td/ZoxjURPdqeVxsIYXAkpNbdIGuIiB59HmloItXmglTywb0xeB+YbXVXKmFWFEAzA2hO6MDLNUYHKzHl5rdmKJsT1WE24mOY5/g9hCD3Np4KsZuyoS5uHYrGHt/xHY9J+NUJFI+7+7i0KUG+KzBo8I=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KUZPR03MB9493.apcprd03.prod.outlook.com (2603:1096:d10:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 06:00:58 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 06:00:58 +0000
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
Subject: Re: [PATCH v4 08/19] soc: mediatek: mutex: Reused the switch case for
 SOF ID
Thread-Topic: [PATCH v4 08/19] soc: mediatek: mutex: Reused the switch case
 for SOF ID
Thread-Index: AQHcF/MeiDWJokViq06l/6dzzsYeSbSVbqOA
Date: Tue, 16 Sep 2025 06:00:58 +0000
Message-ID: <30b0fd500d65eacd669290c16c2ba6f79ccec6ee.camel@mediatek.com>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
	 <20250828080855.3502514-9-paul-pl.chen@mediatek.com>
In-Reply-To: <20250828080855.3502514-9-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KUZPR03MB9493:EE_
x-ms-office365-filtering-correlation-id: a1deffab-91f9-4059-db70-08ddf4e66818
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|42112799006|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M0NTWW9FU2JyS1dQa1hMcEtCd0J0VHRoVnlZWi9RUlQyREVuakNaSS9RV1Az?=
 =?utf-8?B?bEovOThXTXdLdmtxQkZZWWpHT2JZaldNaW9FaUh5STN1dWs2WktEWmhaRUJp?=
 =?utf-8?B?Yy9sUFhmMmdUSCtIUWpiZ2N4YXluMy9pTURodW1uUkZzOTBnTk8zOEF6OEhj?=
 =?utf-8?B?a3VzeEc1MW1vUytKMTAyOFpkUlRVSjZCL2JTK0xiSXFiQnlFcVgwd09YK3hv?=
 =?utf-8?B?NUVlN2pTK1BoRElMaDdRTTgxNnhFQnN4SkxkQnJ6UmowMUVNUVkwR24yOTRw?=
 =?utf-8?B?N3h2SlNiQ1dkZXRlbFVUOUlFdGk5eThHaEpkcTBXSTNPNlo1UTVyZE5EcDZW?=
 =?utf-8?B?MmRnd2MwMUEyNXpyanVyTWk0Ukx5L1ZWR1F2bXR5UDJJcXhrQkpNRUNhcVV6?=
 =?utf-8?B?cmd5WEozQ3dIMTlpaEhYSkhmYzhBYWpLZGJyMFRXdTBlSnZFdkJYTHhpdGxs?=
 =?utf-8?B?QTltVFVLRW9TYy94V0J4bEthbyttdkpsNG9EMWphT04xUnVXbkJBdHpuK0wx?=
 =?utf-8?B?TWRuVHp4VUVtd3RCT3FRNk54Q01GTDI2RVBscjgxa0JSM2J6NU54Z2pnSHFw?=
 =?utf-8?B?Wmd6Z2RtYklPNnAwYk1EQXRibS9tUFp6TDY1a09wZWRDSGM2YnVqbmNqbE56?=
 =?utf-8?B?Q0JyckZDbXZ0UHNGaEM0eWQzMUJlcGVlb0laL1Eva25UVGJVUHBLb1MxczJI?=
 =?utf-8?B?UmpWVnY0ZldKdlhVL2YrbEdpd3NzWnhyK2JzNmlld2ZqcUpFbjJQWWc3Y1JF?=
 =?utf-8?B?L2ZNN2Z6YkFpWXJDZFFIenVFb2c3NS9NNTZGLytXM1FaTlhvZHJPcWwzanNG?=
 =?utf-8?B?ZGZoejZ1eGRQdExueGJYRHFQYUVzcVVZU01ERWVVdkNweFJPUGFhRFNSaUpr?=
 =?utf-8?B?SkFQOXVsS0crL2g2cWlSTnd2SmVBbWpuRlNkOEo5a3lsa0ljNnhOdzN4aFZB?=
 =?utf-8?B?VVNBajk4MkZ4ZkloWDd4eFFDVmdVMWlkRlcrNFJ6MllXSFVBeWx0YUVVdHJu?=
 =?utf-8?B?QUZsUFBLeGVaWVNtdkNqa01NT1VqOVE5R3l2SmE2dWR1cGVrMlZjc2Q1ODh1?=
 =?utf-8?B?cHV4MWV1OXRxWkd5VTNRVHBheHVKeEIxaExoZG1Yd052Z3BGWldRUGpKUng5?=
 =?utf-8?B?WHBrbWZlZ0VDbUhBVVN2cVdQRUc3bFlQN3dVOWZNdEVxSENkWUQ2YXZ6c3JM?=
 =?utf-8?B?MFpPTDhKZnRkMWFEZnNCRVRtNTBha1EyTEdDVElranpmVm13SmZpNUU4U1NB?=
 =?utf-8?B?RjdoM0V4aXlGZGNyVkFXckpJb3ZnYllmamtvZWE1N2R5d1RjS2I3c3hqZnNO?=
 =?utf-8?B?dkJ5bHN0Ti9RV3E5T1lhbi9uMU40dGdzQVA2M2R2S2xSbmNCVlJtWkNaZmJF?=
 =?utf-8?B?L0xEcUVvWER2VlNNMU96SWVkUXl0ZUd5OVN5cm1NWmIzb2dXWE15TXJNQzJE?=
 =?utf-8?B?Ukhjd3BvY0tMVVZMK2xuNTV5YnppUGZPUjNHTE92QytCZVNoZThNS2RUdEli?=
 =?utf-8?B?QmNNRE5MYklFajU3Y0U1dmdGaGR6Z2xUbWxyYjlYRkFwbFRyb09jMDZ2N0ZL?=
 =?utf-8?B?TVJQTnZRZE80TE9pbFJkaDFxdUpHZkFyOEtrelh4b2RTTG40RitKeG45R0NV?=
 =?utf-8?B?RGhRQmFURlRROFp0ei9iLzEvRGtKQVIvWmRoREZsdlhGUUdQVXZUU1hneW1L?=
 =?utf-8?B?SjVOa1VoaG5OTTZvL3lmeU9WZFhPV1ZKK1ZFWWtRTlB3T2xRTnoxalgwdmMz?=
 =?utf-8?B?SEdCL3FaZnZieGZWcWVEVVFkOURPeENzaDlEanJjUnoydGhmY2h3aDNEY20v?=
 =?utf-8?B?SVdjbkFqWmpSa0xEUTZvU0s4dzZ2QXY5R0I2bmFpWkZ2Yk5pVm5ra2NTT2JT?=
 =?utf-8?B?ank4c0twbXViVjBwQ0tYWU50NkJkcWd5azFwMU1IQ09YZFlWdWlmbStDNWlV?=
 =?utf-8?B?dGU1M3J2U08vc0pWVVRyWFhya042NXE3aGk2bWlLZHZHaDBNem1ZWlVwYnM2?=
 =?utf-8?B?UWhIMnBySkVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2ZzbGpoODZvNjh5R005MFJ3V0p1ZnBIRXR4VnVmMkp6R0F4ak5UV3BvcTVu?=
 =?utf-8?B?djV2ZGdIRnlMV0RHVGFUdFE3cXpRc1FqWUtGK2Nkenp2MFlCY21OSFhTOVQ0?=
 =?utf-8?B?WmpGQ0ZpSnlQdUhId3ZreEZOMmZ0czczSHZVeThrYXBKMGNHajlLSE1BdVkw?=
 =?utf-8?B?dFdnREk4dHpVc1czT3lnSmJRYmZaUlRSNkN1QUptYXYvWWpJaHRSR3ArVlQ4?=
 =?utf-8?B?eHdqZnpEU1p3d0krMkp2RGpxUHMxNUppR28wbVViY2dxM3lOSm1Vd2VPREZ3?=
 =?utf-8?B?UTRxK0wrMDNkNi9xeloyUXcrQlhNdFRVS0hZNGVUdUxTSlora3FmQ1lDT0JJ?=
 =?utf-8?B?bkhQSW8zSy9XRHFDdXlQK2RORkJDSVlKa005ZVBuMmtqYTB4YjAwL3ZFUXll?=
 =?utf-8?B?emhEaW1iWjBrV1UxS1M0N1U4UnhCY3BEdW04bVRxd0JsRXo1VDJSMy82ZTZ1?=
 =?utf-8?B?dzlQVGYyS2grc0RNaHVSUzc0YkNpOURVSEdwVEdKR2hsMkNWUWRYMWQzdjZ2?=
 =?utf-8?B?dVFWTk9qYlF6bFNYWkNucy83UmdQY0RxNUs2bDRrZ0wxeE5DdDNpNlpnL3ky?=
 =?utf-8?B?NDR6WGVsTUI1dkN3aFFtdm10TDFTbkVJZEdtYjUwODlOcytSYXB6eGtWL0Z5?=
 =?utf-8?B?enBucW4zUmtVSzcwNExzU0ltRkhmNG50QnZjNmVENnljRXZaYWdJdUxMYWds?=
 =?utf-8?B?TTZaQitXNHlzOHF2UWxFUmNNbTgrdDVZenVHd01XWCtoVUI4UUUza1Y2amZr?=
 =?utf-8?B?b3BqUk1UdjIzZ2ZXc3dyalI4OWxoeDhJakp1UUNUejlseXJmaEtaL3B6RjVM?=
 =?utf-8?B?bDVDMGlORlpBa2RKZlp1aWhCU2QzVGo5cjh0L1N3Q2RtSHdJMWVHaFI5RFlk?=
 =?utf-8?B?RzdHb1hkaHRnQnFUSzRKUWNFZFRGQU1FSFl4WFE0NXB6STh3Vm4vaXIzc2FD?=
 =?utf-8?B?Y040RjFLVzMyWDNKdm5ZMW0reDBucW9QbkhsVkUrcGsyYi9YZWs2MGh6aEN3?=
 =?utf-8?B?YTVURzIyMnpwUU9jVVRZaldCYmp5VUlQVXpxQWNmeUU1N0JWbUZFbmtnUUNW?=
 =?utf-8?B?MmpoVlNyQ0VoTXNIUDd1SnhrQytGTVRFUlAvcXQ0UkpYY2RlYUJqdGlxMlNw?=
 =?utf-8?B?dTNubGIwWWtCY2c1UklJdDJjMkVldHBzODJmd0RxeTdXUnE1ZFFhdWFtMHZ5?=
 =?utf-8?B?UkVPRTlYaGVaRCtta2E1SmIwR1lEMkZzb1Bsd0Zvc1dFWFp3d0NkNVR0ZGZ6?=
 =?utf-8?B?QVllTU9CY1A1YWZlY3paVXFWb2lOdXZrb0hJRW15M3BEc1RkNFkyUXVxVXZB?=
 =?utf-8?B?ZzcrWlptanhaZWViUnI0MVQ1YTl4M1NMK1dRV3U4S09zOHBNMG5zRFFSWVRa?=
 =?utf-8?B?WXhCUDc2cVk5WDRUdk81bVJGdmh1eFJOdXhKZzA5WUQydFBCcWNuUzZVSjJ6?=
 =?utf-8?B?Lzh5S3kva3Fzb1Bpa2VEWjFzaWYzT3ZrVysrTEJINWZnU1l5SjVTcis4NVBU?=
 =?utf-8?B?eWVWblpQakQ3SzlPVVFkS1dweWR1bWVmdG5XcFJmaC9qcG9qMit4VjhqWU9W?=
 =?utf-8?B?ajRmMGRZRXFvUXJSdDFoOVFBcDVJRkdnNkZjWElNZHRwTDRLcnRpbisrUzJZ?=
 =?utf-8?B?WmFHZU8xby9pc0tIRnhIS0ZkT0twMkpyUXhpbHRLM2l3QXgrQVNvWWtINDR3?=
 =?utf-8?B?bkE1ay9YUlorMFZBYjRvNCthRkZabXJGZnQxMHM2NHFsNVBGMmdKVERIaFow?=
 =?utf-8?B?R05DQVdHaG4zemFqUVJuNy9nM0tBWVRpbjJMOFg5YUhwM2ZaOVRjVUpwUFFW?=
 =?utf-8?B?alJlU2tOTW9XeHUvVkJWZmVWV2RqaFAzd0pFYTBoTVNWWGJ4b25xQWxrL0c3?=
 =?utf-8?B?SUtBV3Z1RTd3RkFpaW1HTU40eXhWcGJYN1BCY2ZnNXRvVVhqSXI3cXZFQXpx?=
 =?utf-8?B?RVNEZkZpdGtMSzdKS3I1ZGMydkxwZGJSSEhSWUJoUXhtemx2V0hheWNwUmJH?=
 =?utf-8?B?UTR3VkpLNUF3Mklua2hrMHM1SjFIbkc5S1FRZVJuQm5vMkVaZUQ2amdlKzl6?=
 =?utf-8?B?enZjamF6WnkvL2JwMS82QVJiZ2NtdXlpdzRDMW9CVnowb3Q2RmFYQkpCTkFn?=
 =?utf-8?Q?XUyUefR0OVwlF2QlkEn8WkoWC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A459F94B0376E44A71A033096A28654@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1deffab-91f9-4059-db70-08ddf4e66818
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 06:00:58.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9h+GzlgdBLdGbhnh5AszRlwxd5Ae5MCx7R319rTaQlNBMBe48phGEpgJO7/W762MWiS7nSYTA/ooYyrY2roR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9493

T24gVGh1LCAyMDI1LTA4LTI4IGF0IDE2OjA3ICswODAwLCBQYXVsIENoZW4gd3JvdGU6DQo+IEZy
b206IFBhdWwtcGwgQ2hlbiA8cGF1bC1wbC5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFJldXNl
ZCB0aGUgc3dpdGNoIGNhc2UgZm9yIFNPRiBJRHMuDQoNClRoaXMgaW5mb3JtYXRpb24gaXMgcmVk
dW5kYW50IGJlY2F1c2UgaXQgaXMgdGhlIHNhbWUgYXMgdGl0bGUuDQpUZWxsIHVzIFdIWSBuZWVk
IHRoaXMgcGF0Y2guDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVs
LXBsIENoZW4gPHBhdWwtcGwuY2hlbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgDQoNCg==

