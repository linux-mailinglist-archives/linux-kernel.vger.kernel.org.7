Return-Path: <linux-kernel+bounces-584402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D66DA786D1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 05:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445153AEF8E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B612F23026B;
	Wed,  2 Apr 2025 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ce9XFa/F";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EfJbZnkv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48FF4E2;
	Wed,  2 Apr 2025 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743564663; cv=fail; b=EKDjpfMSJCNt/VNoJnBBqvQYt7aRgi/gygMtplhI0w3F66jx5V3QL3lR5Kx5trXyJcsIKdjfMi92Mp5cZlLhLazMsRba8PjJqTkrN0wEkyjhVfx8uZMcSy97Z2nzf/90CUXDImsKqPvM5A8uoZyuDuEG3s3f5SyKSBtHdkL/F68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743564663; c=relaxed/simple;
	bh=Cr25wd5s7OtgMhxTLvNcYp4666oHDo63a0Li9plFd30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ocDWnJeT2l1E89qizIY7wIdiP1AAEptqsFype8+64ZkPXiHQwj6unTpP0Eo5PL0K67GlQjhfB8DLeWL2gaC+EHSCm2SNhw83wNQCIVs0Wd0b5JQIV9EOrvgAGZ97RIpjTmlIvp0E1ZP6k/BX8OuAhpPBc9FpNf8FSm9enXbphk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ce9XFa/F; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EfJbZnkv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e1da69200f7211f08eb9c36241bbb6fb-20250402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Cr25wd5s7OtgMhxTLvNcYp4666oHDo63a0Li9plFd30=;
	b=ce9XFa/FT1wuT/k40Rz6xr1vawfvebieMu6t68TyrG9umfmHL5MRq4qJI3jqy+p6/TVIFJEHTApDIqePLfMfSmuiWFcQSH2ZodWHE4JsUva2WXx0bWaPCj4U2rtgUPAhN29XEBhPTDls5sJHD+lvc0eLpF859KyM6A2ZhlPEhFQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:32e50a9c-5269-461e-8d1f-fa5e502a704e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f9ee16c7-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e1da69200f7211f08eb9c36241bbb6fb-20250402
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1836734813; Wed, 02 Apr 2025 11:30:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 2 Apr 2025 11:30:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 2 Apr 2025 11:30:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xr3Y11hxMZnGjJXGXqRbwaCqNHMioISdf/ovE58k/8g3t54zC+WjRgYXi1nWDhFxD2fmT/Klc7Dh0NjHPO6+SXy9qlxAA3IthkZP5EzTPdxyv3zY9DsX8G5ewape0i2rvA1xoFdrnvBvO90vC93ZBqa/RS6CSfNhV3hgrtXj99JWY7ADv1jv1mMTehENuNLrBpl7eT7c5rh8xp4Ye/oXZiIT5MPT8IJp20vdy9dqKpYAMnAUhouujQLxrWUs4yJ3AfI0LwEYHhRsX2gNGGU3PjFjOB5UPWnKciChEa6aMi63S0wI3k53lEYOxrOcHUfzIFjlVPkXiit5sbc68gb4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cr25wd5s7OtgMhxTLvNcYp4666oHDo63a0Li9plFd30=;
 b=tvZZ05yxLAiMpmQVziyhcgRpYizkLLpsKO1BNE4OPr1fmWo2wFuUrPuYCdOye+JUrI78lJn1FQKq6K4aLgeq6/gj/sCE6cXL8mJQMXXc7kbXjxQzY+RttMkiU2bdN1VXancSW6Bl6po8g6GYDHkP0E1NI7DnyDo/lz9rh71HaDt9gpYkauVPo6hJMZOKMnIpqbZTgXnqoHp1cgJBfkfGy9ib9PLmuMAt5ufUfGQxLtTe7Yf2tL9ylJXNlq3hBRmZ5KenBYIjXJMlu1VV0Me6zYk321dxo2h4GnveHyElacaj//ziHCZZCMcGKMSmC3HhDrAx/N7rUIhFLp0bi2UZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cr25wd5s7OtgMhxTLvNcYp4666oHDo63a0Li9plFd30=;
 b=EfJbZnkvBgYY6L7I59Cv1El6JWfGg/of09IpFiy4Pi3imiLaZlQj1ji/I8WWwRkS1b/xZhlBahDOqqlITgl7PxKYNGeqMF58UK0T0UUGwEiiroK+ABLlMpJgAfQeHar6C4yBjEst+ZpPDDodUsKJZ+3Bv9R1i1LFaj/iAhOzEqg=
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com (2603:1096:4:1b8::6) by
 OSQPR03MB8388.apcprd03.prod.outlook.com (2603:1096:604:27a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.37; Wed, 2 Apr 2025 03:30:49 +0000
Received: from SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052]) by SG2PR03MB6636.apcprd03.prod.outlook.com
 ([fe80::98e8:d61:f404:4052%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 03:30:49 +0000
From: =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
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
Subject: Re: [PATCH v2 07/15] soc: mediatek: mutex: refactor SOF settings for
 output components
Thread-Topic: [PATCH v2 07/15] soc: mediatek: mutex: refactor SOF settings for
 output components
Thread-Index: AQHbmkSy55fguc6glUmQ8zR4VVmOgbOCi24AgA0/SAA=
Date: Wed, 2 Apr 2025 03:30:49 +0000
Message-ID: <c3041f64d64425510f9c591efb2d056960f4f469.camel@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
	 <20250321093435.94835-8-paul-pl.chen@mediatek.com>
	 <754df305-9767-47be-8f98-4e287c56808e@collabora.com>
In-Reply-To: <754df305-9767-47be-8f98-4e287c56808e@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6636:EE_|OSQPR03MB8388:EE_
x-ms-office365-filtering-correlation-id: a116573e-6420-4428-0f9e-08dd7196c347
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ny9TV2o5aFhpVVpoK0gwU2h5ZmQwSFkxZEtybEVkLzliSGI0Rk4xWXIrYjdY?=
 =?utf-8?B?Ujc1M3IyZjBVcEZlSmV3QmRyMzNTTFNaOUxWUFhLdFIyVWFYaDdLcVd5OFZP?=
 =?utf-8?B?VHFXaWZWaFNaWGlpeWxqd0l5RnExdDVCYkJ0RU41YmpiK2NyNlRMOG5rMFlS?=
 =?utf-8?B?aHRnZnZBUFNLLy93QkRLdENMclZnVmdlTjBUNXNoYzZWTW9UMlhpbTBpOXgw?=
 =?utf-8?B?MHdiclVxYUoweVlLVlRxRUExWm1wUHBHV1VzYjZFRW5CWXpCQ05yemxOdDIv?=
 =?utf-8?B?elYzSnczMHlEM1hFWkVpOUlSNFBsWHM0RkxKdVBYb0F2RU92NTFxNlRBV2Jv?=
 =?utf-8?B?cGVSb1JMVG5vQzVOY2JuS2grdFpjMDF2Wkl5ZnhOc2dkSFR3SVZRSm9RWmxM?=
 =?utf-8?B?V0Qwc1IwcXFLVXNmQWpqdjZaUFU1K1lreXZnVTRLSThIeHB0M3R2ZWFScjA0?=
 =?utf-8?B?SjFZSVpwOVJoa042ZW4vdnd6ZEZlc25uM2RTeStab2ZSY0VvVGhuRnJCTmFX?=
 =?utf-8?B?QVIyWVBuVmMrTW9pMjJTWVVnR3RLYWYya1hUS1BZcTUxUmsxcCtYN1NEUHJN?=
 =?utf-8?B?RHpZYTZCNUh1RFZDRGJvNmh2Um5YKzgzWWJQeU4zOEU3MkxBcnBwVWpxUkk3?=
 =?utf-8?B?VEI4WkQvWlZCY3BnamJqL0dWeGFCSi9OSE5NV0dla1pLRmZKK1NJOE5xVXVI?=
 =?utf-8?B?MGJYRHBwVlh5QlgwV1ZMQ3l5RlJRbExjWklRenpKaGNaODFLaXNlMzgwbnpF?=
 =?utf-8?B?d3MxT1ZZTW81Q1VQVnFRdllHMFhFMFZDcXk0MWljNVNiMjhsVjZzKzB0WXRo?=
 =?utf-8?B?eVkyMEhIcHkxc2JNa0NTZTNkejgydC90blFJaFVheEJNMGd6TWlXaEFSdjlT?=
 =?utf-8?B?RjdvTkhNTWZYZ1JzQlZ4TlhFYjFuY3NPeGh0QzZBUU1ZT1A3eEYybzlydkdx?=
 =?utf-8?B?aXo3MDczamtmelgveVBGNTZhRDhxcVR4Nnp3cG1jRnpyOUkwVmZDRE0xRG5Z?=
 =?utf-8?B?YTF5azRxR00wV1lSc1puNVpsZm5DTFhvWEZpeC83bVZzSW41MTRrNmNGNmtW?=
 =?utf-8?B?cXhMYnFTYm9SMVFjbmE3Unh6UlVtcytKZTNSTDBubmJ0ZXUwd1ptVndNc2RO?=
 =?utf-8?B?ajRNUm8xRGliZ0QrRlg4M2pXSVVrdHdPS3hQKytCdE01MllsV00rV1gzYWYr?=
 =?utf-8?B?amEwK2FZcmEwZEVqdGwzbWkxRnRIekE1ckhFeFpoN0Z5cjBkVXlYelJvclJ5?=
 =?utf-8?B?cVRzRDMvM0xwb0pKa0tUN09nSW1vZmRXMEsrODR0Yk9HekI4ckE2am90RWRB?=
 =?utf-8?B?RWk4U2t2YWRVTm5rdGtPTHJ6c3h3Qk9Ua1VEOTVZTkRrTFcxbllVL0lzOFFw?=
 =?utf-8?B?TDV2VjNVODBtSFFuWTVTSGhkbFBZWW5WRGdGWmVwS3RRSE9EUEE0Yy9NZVN4?=
 =?utf-8?B?L1BCbGZNZ3ZjU25pUzlwdEZFQkswckpuTWExTzM0cGs0R09UQmZ5Z2Y3aDJD?=
 =?utf-8?B?b013LzhDUzNBby9wOW5vZkxZaEh6ZXJMUmZPQ2tnQm14Z05WNERzWDRtRVMx?=
 =?utf-8?B?UmNISHBVVERtQllCcmwrdzNhTmNES0trbk9tTVRmbVpWbGR0VDhaZENRQWc4?=
 =?utf-8?B?YWkraTFPWGpTN01TU2s0WFg1UWRCTkJ2ZG43VVUvaXl5K1Fld0NnZ0ZQSGRE?=
 =?utf-8?B?cWpwc01TQ0lDM2M2bWtoRVpldWJYQ29tUXVySEZUR2xCS3FwSlJOc1ZVWjQ3?=
 =?utf-8?B?Rk5BMHhHb1lIY2RTN0RIekFkS09TakhYdURpdTVRRGJGTU9iRWJ4N3NFQVNY?=
 =?utf-8?B?MGR2UnlkeGRyeHduWFpHNlhvbjNkZnF5V1IwMHdCZnFZRFFKbWkwY3V0Zlp4?=
 =?utf-8?B?MjVHOTAwdHUyS2NFak5UR3V0YlBFR3FyN29qcTJlSFNUYk16eEJ5a0E2dGlB?=
 =?utf-8?B?VWhmUmJvYjhUWEF0YW1heHdYWEdHT1MxMGJTWmREMXJDOFhJUWJieGRvNndY?=
 =?utf-8?B?VktrMmZJamhRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6636.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWoreittU040enk2T2lnTEIvNnNINkJ2d003UUxpUEthYytoQWtjL1FFNitS?=
 =?utf-8?B?TlhoTVJXTEZGaU9rZkhKeGpremthbHBqZmFEd25IMldCU2RORUdrTWpqTEFu?=
 =?utf-8?B?dkVOV2FxKzNUTHhqQUlHT1BvcG1jSGQyVlA5Nzkva2Z1L3lpUHBRNVF0Z21F?=
 =?utf-8?B?MFl4ekNSMldheGJpdkRLMVViTzVrejA1anFKbFRURzlTWkxzVm1RcU1uRzZC?=
 =?utf-8?B?aktsZTVLa1BaMHdYaDVzUllRR280b1dDeXlXQy9PeU82TkdudTNEL00zbzR1?=
 =?utf-8?B?bnJMWiszWUxOVkpwVmJTaVFmaWlaaVNMWWc1MnNaV2pJbTE3MVNiUFkwOGw3?=
 =?utf-8?B?dytUekpPVVd3RHFIYUNhbUc5MVNFMzlpT3dwYXZoMGRZN0lTRUR1Q3pUT2pv?=
 =?utf-8?B?bnJYS3pKdFFDQzlKaXB4Y3RCN0JPUXN6WlFoSTArdm5ONWlsTVczMHZXVXRM?=
 =?utf-8?B?Y3lndGJQa0JWZWw5bG5SQVFDclpSd0tjUVV2WTBXYTU1bmVBOWlJbVY5Ukkv?=
 =?utf-8?B?OCtCMGx0bGI4ZUR2cGlxTHVGRGRXN2V4cWlWRWxMNVR2ZHJEQW1HWEllajUy?=
 =?utf-8?B?QVM3eDF4U0d1YzB4Zk5aaG1zT1RubU0yWmZxME5qb1JXdkt1ZEQwd1BCV0l4?=
 =?utf-8?B?SThYb3VpYllSbnFiTG1sZElsZEFZUUwzVmovYmc0WHRNMGduanVIQjZ2ZVhi?=
 =?utf-8?B?bWpRMzBPdG9xVi81dTZETVBVQ3JIaU42RlgwL3NiYlc2RTlTMjlYSjFHRjhs?=
 =?utf-8?B?cWdkUVVTbktydUdySjNiN05mMU9aczRBL25YbFEvYzFPbzRWVi9aamR5SjVr?=
 =?utf-8?B?WU5kTHh4eVJuU0pQVjBPWldHQ3VmWlRiMFFOQ0Mzc2lMVU1xUnBla0ZrVWpE?=
 =?utf-8?B?QTlTdklQa3V5cE1md0pxQ3VpbW5XOXVJUkt1a2xoT21aNjhKVmZaOWZGaDhC?=
 =?utf-8?B?aHY4TW91SDhBWGdGamQzN0xIbmZ1VE92bEJBZjBjWmJZajFQTTRyU21aeUpK?=
 =?utf-8?B?Sm4rSWd0Q2RhWnNFOW1hdDdOVmIyc3RQOUNZaHpHUDNpU2lpbGxuZ0pkOGln?=
 =?utf-8?B?ZndhYWhkMHc1T1ZXYkd5S3MyOFdZYUtYL1RRMS9hTFAwcnMwblBRRGxLdGxs?=
 =?utf-8?B?VXpOVXFpQjBIN29nVGNCNllmOG5pa2tVdVowUDhHcTZPa2ZpUFhVRGVtVjNG?=
 =?utf-8?B?S25MOU1xR295MUZhcEdDTzA3Q0dWYWNrQnI2eCs0YlE4R2NUaUtmemxEMUZX?=
 =?utf-8?B?WkJmam5aOUx6bEFFOVJNalZ3VElIdDFRQkNHY213b0pCdG00Q1l2YkFZbVZT?=
 =?utf-8?B?ZmtFazE4RUdVVjlkRndRWmRsMm5YTDRxcS8wLzNQS0Q2NnRCaytkQ28yd0Fk?=
 =?utf-8?B?cnUxLzV6U0RnS2lBRDJ3Z05ZNTRsK09uVis3dG9oU3hLRGJmNHZSL0xDek5V?=
 =?utf-8?B?RkdFSUR0U21GUDhyMFZUZVZNTEpkVExGd0c0QjlpdElzVjViU0g1S0hxVWdu?=
 =?utf-8?B?L3VUeFRLTnZCQTNtWGx4WmoxQW1FRDk5NWJnQ2xidTN5L05INS92RFg3aE9B?=
 =?utf-8?B?blk1bFREbzljQnV4c2NJc1VNa1pQc255Z1BnQjhuRFZJMk5zdEZ0azRUZUhh?=
 =?utf-8?B?SHpTM3NDMFlIM2RBNHdqYVdCeDZRTW11aGw3Zy9vVTVMdUF6Q2M1S3NXMkhO?=
 =?utf-8?B?QU03STFFcm9YQnJ1Mnl1RUl4RWRlZkFDa3l1MHZ0YnhqWTNYTW5EakxzOWxy?=
 =?utf-8?B?VU1VWkgxUHU0Z3lsL1ZuQllPYWdIekY2VzVIbGprQVd2VTFLY3UvMHl3Wk9u?=
 =?utf-8?B?YVplcEtJVEZ2b1JmSEZzODN5UUc4Q3Z1ZHUvVnBKYXpyamlxRm10TWZ3SlNP?=
 =?utf-8?B?cDJWdlNWR2RybGF4MDlJbEh0UjhaTFdnMFgzRGlNUUlPNExJdzJvYnd5ZktE?=
 =?utf-8?B?TUNxRGNiT2NXNExwTVozK0dJem5nVGhvT3lpL2lhNXJXZk55L3A2MVF5R3lx?=
 =?utf-8?B?Z2J5L1ZOMEc5Y1ZYK3JWRUVwZTROcVlOZzNGV1lZNXBxTGhQbTJGV0hDR3JU?=
 =?utf-8?B?NUVEdlVGZkdMb2haa3AzS3dEU2dvS1g2bHNaMldhUkhuVVlreWhGcTlqZG5Y?=
 =?utf-8?B?T1V6WUNRMUV3ZlpiR1VTSEhwQUJ0TVYvME1id3JlYlYxK2tiUlo3NjQ4QS9I?=
 =?utf-8?B?VVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B96DCDC8DB2DA4AA35783D8A87C8FD6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6636.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a116573e-6420-4428-0f9e-08dd7196c347
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 03:30:49.1690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNm5tQvgZA74anRBYRIrlmig3g8/xX1Wnmcztg8AKCwIKoEwlTWFcsziDq6ojPRsf8B3IPQ56cF8J8t11YBftCHJ4yBDO0WyWXzmCtf/wxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8388

T24gTW9uLCAyMDI1LTAzLTI0IGF0IDE4OjEyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToKPiAKPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbAo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuCj4gCj4gCj4gSWwgMjEvMDMvMjUgMTA6MzMsIHBhdWwtcGwuY2hl
biBoYSBzY3JpdHRvOgo+ID4gRnJvbTogTmFuY3kgTGluIDxuYW5jeS5saW5AbWVkaWF0ZWsuY29t
Pgo+ID4gCj4gPiBSZWZhY3RvciBTT0Ygc2V0dGluZ3MgYnkgYWRkaW5nIG10a19tdXRleF9nZXRf
b3V0cHV0X2NvbXBfc29mKCkKPiA+IGFuZCBleHRyYWN0aW5nIFNPRiBsb2dpYyBmcm9tIG10a19t
dXRleF9hZGRfY29tcCgpCj4gPiBhbmQgbXRrX211dGV4X3JlbW92ZV9jb21wKCkuCj4gPiAKPiA+
IC0gQWRkZWQgbXRrX211dGV4X2FkZF9jb21wX3NvZigpIGFuZCBtdGtfbXV0ZXhfcmVtb3ZlX2Nv
bXBfc29mKCkKPiA+IMKgwqAgZm9yIFNPRiBzZXR0aW5ncy4KPiA+IC0gUmV1c2VkIHRoZSBzd2l0
Y2ggY2FzZSBmb3IgU09GIElEcy4KPiA+IC0gU2VwYXJhdGVkIE1PRCBhbmQgU09GIGxvZ2ljLgo+
ID4gCj4gCj4gVGhpcyBhbHNvIG5lZWRzIG1vcmUgdGhhbiBvbmUgY29tbWl0Lgo+IAo+IFRoZSBj
bGVhbnVwcyBnbyBpbiBhIGNvbW1pdCBkb2luZyBvbmx5IGNsZWFudXBzLgo+IApIaSBBbmdlbG9H
aW9hY2NoaW5vLCAKQmFzZWQgb24geW91ciBhZHZpY2UsIEknbSBjb25zaWRlcmluZyBkaXZpZGlu
ZyB0aGUgY2hhbmdlcyBhcyBmb2xsb3dzOgoKQ29tbWl0IDE6cmVmYWN0b3IgU09GIHNldHRpbmdz
IGZvciBvdXRwdXQgY29tcG9uZW50cwoKLSBBZGRlZCBtdGtfbXV0ZXhfYWRkX2NvbXBfc29mKCkg
YW5kIG10a19tdXRleF9yZW1vdmVfY29tcF9zb2YoKQogICBmb3IgU09GIHNldHRpbmdzLgotIFNl
cGFyYXRlZCBNT0QgYW5kIFNPRiBsb2dpYy4KCkNvbW1pdCAyOiAKLSBSZXVzZWQgdGhlIHN3aXRj
aCBjYXNlIGZvciBTT0YgSURzLgoKCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeSBMaW4gPG5hbmN5
LmxpbkBtZWRpYXRlay5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwt
cGwuY2hlbkBtZWRpYXRlay5jb20+Cj4gPiAtLS0KPiA+IMKgIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ay1tdXRleC5jwqDCoMKgwqDCoMKgIHwgMTIxICsrKysrKysrKysrKysrKy0tLS0tCj4gPiAt
LS0tLQo+ID4gwqAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4LmggfMKgwqAg
NCArCj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDQ2IGRlbGV0aW9u
cygtKQo+ID4gCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4
LmMKPiA+IGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW11dGV4LmMKPiA+IGluZGV4IGFhYTk2
NWQ0YjA1MC4uYzAyNmFjMGU2OTY5IDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLW11dGV4LmMKPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1tdXRleC5j
Cj4gPiBAQCAtODUzLDQzICs4NTMsODQgQEAgdm9pZCBtdGtfbXV0ZXhfdW5wcmVwYXJlKHN0cnVj
dCBtdGtfbXV0ZXgKPiA+ICptdXRleCkKPiA+IMKgIH0KPiA+IMKgIEVYUE9SVF9TWU1CT0xfR1BM
KG10a19tdXRleF91bnByZXBhcmUpOwo+ID4gCj4gPiAtdm9pZCBtdGtfbXV0ZXhfYWRkX2NvbXAo
c3RydWN0IG10a19tdXRleCAqbXV0ZXgsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlbnVtIG10a19kZHBfY29tcF9pZCBpZCkKPiA+ICtzdGF0aWMgaW50IG10
a19tdXRleF9nZXRfb3V0cHV0X2NvbXBfc29mKGVudW0gbXRrX2RkcF9jb21wX2lkIGlkKQo+ID4g
wqAgewo+ID4gLcKgwqDCoMKgIHN0cnVjdCBtdGtfbXV0ZXhfY3R4ICptdHggPSBjb250YWluZXJf
b2YobXV0ZXgsIHN0cnVjdAo+ID4gbXRrX211dGV4X2N0eCwKPiA+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhbbXV0ZXgtPmlkXSk7Cj4gPiAtwqDCoMKgwqAgdW5zaWdu
ZWQgaW50IHJlZzsKPiA+IC3CoMKgwqDCoCB1bnNpZ25lZCBpbnQgc29mX2lkOwo+ID4gLcKgwqDC
oMKgIHVuc2lnbmVkIGludCBvZmZzZXQ7Cj4gPiAtCj4gPiAtwqDCoMKgwqAgV0FSTl9PTigmbXR4
LT5tdXRleFttdXRleC0+aWRdICE9IG11dGV4KTsKPiA+IC0KPiA+IMKgwqDCoMKgwqAgc3dpdGNo
IChpZCkgewo+ID4gwqDCoMKgwqDCoCBjYXNlIEREUF9DT01QT05FTlRfRFNJMDoKPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc29mX2lkID0gTVVURVhfU09GX0RTSTA7Cj4gPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gTVVURVhfU09GX0RTSTA7Cj4gPiDCoMKgwqDCoMKgIGNhc2UgRERQX0NPTVBPTkVOVF9E
U0kxOgo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzb2ZfaWQgPSBNVVRFWF9TT0ZfRFNJ
MDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBNVVRFWF9TT0ZfRFNJMTsKPiA+IMKgwqDCoMKgwqAgY2FzZSBE
RFBfQ09NUE9ORU5UX0RTSTI6Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvZl9pZCA9
IE1VVEVYX1NPRl9EU0kyOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE1VVEVYX1NPRl9EU0kyOwo+ID4gwqDC
oMKgwqDCoCBjYXNlIEREUF9DT01QT05FTlRfRFNJMzoKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc29mX2lkID0gTVVURVhfU09GX0RTSTM7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTVVURVhfU09G
X0RTSTM7Cj4gPiDCoMKgwqDCoMKgIGNhc2UgRERQX0NPTVBPTkVOVF9EUEkwOgo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzb2ZfaWQgPSBNVVRFWF9TT0ZfRFBJMDsKPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiBNVVRFWF9TT0ZfRFBJMDsKPiA+IMKgwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5UX0RQ
STE6Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvZl9pZCA9IE1VVEVYX1NPRl9EUEkx
Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIE1VVEVYX1NPRl9EUEkxOwo+ID4gwqDCoMKgwqDCoCBjYXNlIERE
UF9DT01QT05FTlRfRFBfSU5URjA6Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNvZl9p
ZCA9IE1VVEVYX1NPRl9EUF9JTlRGMDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBNVVRFWF9TT0ZfRFBfSU5U
RjA7Cj4gPiDCoMKgwqDCoMKgIGNhc2UgRERQX0NPTVBPTkVOVF9EUF9JTlRGMToKPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc29mX2lkID0gTVVURVhfU09GX0RQX0lOVEYxOwo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIE1VVEVYX1NPRl9EUF9JTlRGMTsKPiA+IMKgwqDCoMKgwqAgZGVmYXVsdDoKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqAgfQo+ID4gKwo+
ID4gK8KgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+ID4gK30KPiA+ICsKPiA+ICt2b2lkIG10a19t
dXRleF9hZGRfY29tcF9zb2Yoc3RydWN0IG10a19tdXRleCAqbXV0ZXgsIGVudW0KPiA+IG10a19k
ZHBfY29tcF9pZCBpZCkKPiA+ICt7Cj4gPiArwqDCoMKgwqAgc3RydWN0IG10a19tdXRleF9jdHgg
Km10eCA9IGNvbnRhaW5lcl9vZihtdXRleCwgc3RydWN0Cj4gPiBtdGtfbXV0ZXhfY3R4LAo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRleFttdXRleC0+aWRdKTsKPiA+
ICvCoMKgwqDCoCBpbnQgc29mX2lkID0gbXRrX211dGV4X2dldF9vdXRwdXRfY29tcF9zb2YoaWQp
Owo+ID4gK8KgwqDCoMKgIHVuc2lnbmVkIGludCBvZmZzZXQ7Cj4gPiArCj4gPiArwqDCoMKgwqAg
aWYgKHNvZl9pZCA8IDAgfHwgc29mX2lkID49IEREUF9NVVRFWF9TT0ZfTUFYKQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gPiArCj4gPiArwqDCoMKgwqAgV0FSTl9PTigm
bXR4LT5tdXRleFttdXRleC0+aWRdICE9IG11dGV4KTsKPiA+ICsKPiA+ICvCoMKgwqDCoCBvZmZz
ZXQgPSBESVNQX1JFR19NVVRFWF9TT0YobXR4LT5kYXRhLT5tdXRleF9zb2ZfcmVnLCBtdXRleC0K
PiA+ID5pZCk7Cj4gPiArCj4gPiArwqDCoMKgwqAgd3JpdGVsX3JlbGF4ZWQobXR4LT5kYXRhLT5t
dXRleF9zb2Zbc29mX2lkXSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtdHgtPnJlZ3MgKyBvZmZzZXQpOwo+IAo+IGZpdHMgaW4gb25lIGxpbmUKPiAKPiBPSywg
SSB3aWxsIGZpeCBpdCBpbiBvbmUgbGluZS4gCj4gPiArfQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BM
KG10a19tdXRleF9hZGRfY29tcF9zb2YpOwo+ID4gKwo+ID4gK3ZvaWQgbXRrX211dGV4X3JlbW92
ZV9jb21wX3NvZihzdHJ1Y3QgbXRrX211dGV4ICptdXRleCwgZW51bQo+ID4gbXRrX2RkcF9jb21w
X2lkIGlkKQo+ID4gK3sKPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgbXRrX211dGV4X2N0eCAqbXR4ID0g
Y29udGFpbmVyX29mKG11dGV4LCBzdHJ1Y3QKPiA+IG10a19tdXRleF9jdHgsCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4W211dGV4LT5pZF0pOwo+ID4gK8KgwqDC
oMKgIHVuc2lnbmVkIGludCByZWc7Cj4gPiArwqDCoMKgwqAgaW50IHNvZl9pZCA9IG10a19tdXRl
eF9nZXRfb3V0cHV0X2NvbXBfc29mKGlkKTsKPiA+ICvCoMKgwqDCoCB1bnNpZ25lZCBpbnQgb2Zm
c2V0Owo+ID4gKwo+ID4gK8KgwqDCoMKgIGlmIChzb2ZfaWQgPCAwIHx8IHNvZl9pZCA+PSBERFBf
TVVURVhfU09GX01BWCkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+ID4g
Kwo+ID4gK8KgwqDCoMKgIFdBUk5fT04oJm10eC0+bXV0ZXhbbXV0ZXgtPmlkXSAhPSBtdXRleCk7
Cj4gPiArCj4gPiArwqDCoMKgwqAgb2Zmc2V0ID0gRElTUF9SRUdfTVVURVhfU09GKG10eC0+ZGF0
YS0+bXV0ZXhfc29mX3JlZywgbXV0ZXgtCj4gPiA+aWQpOwo+ID4gK8KgwqDCoMKgIHJlZyA9IHJl
YWRsX3JlbGF4ZWQobXR4LT5yZWdzICsgb2Zmc2V0KTsKPiA+ICvCoMKgwqDCoCByZWcgJj0gfigx
IDw8IG10eC0+ZGF0YS0+bXV0ZXhfc29mW2lkXSk7Cj4gPiArCj4gPiArwqDCoMKgwqAgd3JpdGVs
X3JlbGF4ZWQocmVnLCBtdHgtPnJlZ3MgKyBvZmZzZXQpOwo+ID4gK30KPiA+ICtFWFBPUlRfU1lN
Qk9MX0dQTChtdGtfbXV0ZXhfcmVtb3ZlX2NvbXBfc29mKTsKPiA+ICsKPiA+ICt2b2lkIG10a19t
dXRleF9hZGRfY29tcChzdHJ1Y3QgbXRrX211dGV4ICptdXRleCwKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gbXRrX2RkcF9jb21wX2lkIGlkKQo+ID4g
K3sKPiA+ICvCoMKgwqDCoCBzdHJ1Y3QgbXRrX211dGV4X2N0eCAqbXR4ID0gY29udGFpbmVyX29m
KG11dGV4LCBzdHJ1Y3QKPiA+IG10a19tdXRleF9jdHgsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIG11dGV4W211dGV4LT5pZF0pOwo+ID4gK8KgwqDCoMKgIHVuc2lnbmVk
IGludCByZWc7Cj4gPiArwqDCoMKgwqAgdW5zaWduZWQgaW50IG9mZnNldDsKPiA+ICvCoMKgwqDC
oCBib29sIGlzX291dHB1dF9jb21wID0gISFtdGtfbXV0ZXhfZ2V0X291dHB1dF9jb21wX3NvZihp
ZCk7Cj4gPiArCj4gPiArwqDCoMKgwqAgV0FSTl9PTigmbXR4LT5tdXRleFttdXRleC0+aWRdICE9
IG11dGV4KTsKPiA+ICsKPiAKPiBMb29rcyBsaWtlIHlvdSBjYW4ganVzdCBkbwo+IAo+IMKgwqDC
oMKgwqDCoMKgIGlmIChpc19vdXRwdXRfY29tcCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtdGtfbXV0ZXhfYWRkX2NvbXBfc29mKG11dGV4LCBpZCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiDCoMKgwqDCoMKgwqDCoCB9Cj4gCj4gwqDCoMKg
wqDCoMKgwqAgaWYgKG10eC0+ZGF0YS0+bXV0ZXhfbW9kW2lkXSA8IDMyKSB7IC4uLi4uZXRjCj4g
Ck9LLAoKVGhpcyBpcyBiZWNhdXNlIHRoZSBuZXh0IHBhdGNoIFtQQVRDSCB2MiAwOC8xNV0sIAp3
ZSBoYXZlIHRvIGNvbnNpZGVyIHVzaW5nIHRoZSBjb25kaXRpb24gb2YgIm10eC0+ZGF0YS0+bmVl
ZF9zb2ZfbW9kIiAKdG8gc2V0IHRoZSByZWdpc3RlciBzZXR0aW5nIG9mIERJU1BfUkVHX01VVEVY
X01PRC4KCgo+ID4gK8KgwqDCoMKgIGlmICghaXNfb3V0cHV0X2NvbXApIHsKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtdHgtPmRhdGEtPm11dGV4X21vZFtpZF0gPCAzMikgewo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9mZnNldCA9IERJ
U1BfUkVHX01VVEVYX01PRChtdHgtPmRhdGEtCj4gPiA+bXV0ZXhfbW9kX3JlZywKPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4LT5pZCk7Cj4gPiBAQCAt
OTAyLDEyICs5NDMsMTAgQEAgdm9pZCBtdGtfbXV0ZXhfYWRkX2NvbXAoc3RydWN0IG10a19tdXRl
eAo+ID4gKm11dGV4LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlZyB8PSAxIDw8IChtdHgtPmRhdGEtPm11dGV4X21vZFtpZF0gLSAzMik7Cj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsX3JlbGF4ZWQocmVn
LCBtdHgtPnJlZ3MgKyBvZmZzZXQpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4gPiDCoMKgwqDCoMKgIH0KPiA+
IAo+ID4gLcKgwqDCoMKgIHdyaXRlbF9yZWxheGVkKG10eC0+ZGF0YS0+bXV0ZXhfc29mW3NvZl9p
ZF0sCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXR4LT5yZWdz
ICsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBESVNQX1JFR19N
VVRFWF9TT0YobXR4LT5kYXRhLT5tdXRleF9zb2ZfcmVnLAo+ID4gbXV0ZXgtPmlkKSk7Cj4gPiAr
wqDCoMKgwqAgaWYgKGlzX291dHB1dF9jb21wKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtdGtfbXV0ZXhfYWRkX2NvbXBfc29mKG11dGV4LCBpZCk7Cj4gPiDCoCB9Cj4gPiDCoCBFWFBP
UlRfU1lNQk9MX0dQTChtdGtfbXV0ZXhfYWRkX2NvbXApOwo+ID4gCj4gPiBAQCAtOTE4LDI0ICs5
NTcsMTEgQEAgdm9pZCBtdGtfbXV0ZXhfcmVtb3ZlX2NvbXAoc3RydWN0IG10a19tdXRleAo+ID4g
Km11dGV4LAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhbbXV0
ZXgtPmlkXSk7Cj4gPiDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCByZWc7Cj4gPiDCoMKgwqDCoMKg
IHVuc2lnbmVkIGludCBvZmZzZXQ7Cj4gPiArwqDCoMKgwqAgYm9vbCBpc19vdXRwdXRfY29tcCA9
ICEhbXRrX211dGV4X2dldF9vdXRwdXRfY29tcF9zb2YoaWQpOwo+ID4gCj4gPiDCoMKgwqDCoMKg
IFdBUk5fT04oJm10eC0+bXV0ZXhbbXV0ZXgtPmlkXSAhPSBtdXRleCk7Cj4gPiAKPiA+IC3CoMKg
wqDCoCBzd2l0Y2ggKGlkKSB7Cj4gPiAtwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5UX0RTSTA6
Cj4gPiAtwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5UX0RTSTE6Cj4gPiAtwqDCoMKgwqAgY2Fz
ZSBERFBfQ09NUE9ORU5UX0RTSTI6Cj4gPiAtwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5UX0RT
STM6Cj4gPiAtwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5UX0RQSTA6Cj4gPiAtwqDCoMKgwqAg
Y2FzZSBERFBfQ09NUE9ORU5UX0RQSTE6Cj4gPiAtwqDCoMKgwqAgY2FzZSBERFBfQ09NUE9ORU5U
X0RQX0lOVEYwOgo+ID4gLcKgwqDCoMKgIGNhc2UgRERQX0NPTVBPTkVOVF9EUF9JTlRGMToKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd3JpdGVsX3JlbGF4ZWQoTVVURVhfU09GX1NJTkdM
RV9NT0RFLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtdHgtPnJlZ3MgKwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBESVNQX1JFR19NVVRFWF9TT0YobXR4LT5kYXRhLQo+
ID4gPm11dGV4X3NvZl9yZWcsCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbXV0ZXgtPmlkKSk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4g
LcKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiArwqDCoMKgwqAgaWYgKCFpc19vdXRwdXRfY29tcCkgewo+
IAo+IHNhbWUgY29tbWVudCBhcyBiZWZvcmUuCj4gCgpPSywKClRoaXMgaXMgYmVjYXVzZSB0aGUg
bmV4dCBwYXRjaCBbUEFUQ0ggdjIgMDgvMTVdLCAKd2UgaGF2ZSB0byBjb25zaWRlciB1c2luZyB0
aGUgY29uZGl0aW9uIG9mICJtdHgtPmRhdGEtPm5lZWRfc29mX21vZCIgCnRvIHNldCB0aGUgcmVn
aXN0ZXIgc2V0dGluZyBvZiBESVNQX1JFR19NVVRFWF9NT0QuCgoKQmVzdCByZWdhcmRzLCAKUGF1
bAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG10eC0+ZGF0YS0+bXV0ZXhfbW9k
W2lkXSA8IDMyKSB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgb2Zmc2V0ID0gRElTUF9SRUdfTVVURVhfTU9EKG10eC0+ZGF0YS0KPiA+ID5tdXRleF9tb2Rf
cmVnLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXgt
PmlkKTsKPiA+IEBAIC05NDgsOCArOTc0LDExIEBAIHZvaWQgbXRrX211dGV4X3JlbW92ZV9jb21w
KHN0cnVjdCBtdGtfbXV0ZXgKPiA+ICptdXRleCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgJj0gfigxIDw8IChtdHgtPmRhdGEtPm11dGV4X21vZFtp
ZF0gLQo+ID4gMzIpKTsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB3cml0ZWxfcmVsYXhlZChyZWcsIG10eC0+cmVncyArIG9mZnNldCk7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFr
Owo+ID4gwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiArwqDCoMKgwqAgaWYgKGlzX291dHB1dF9jb21w
KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdGtfbXV0ZXhfcmVtb3ZlX2NvbXBfc29m
KG11dGV4LCBpZCk7Cj4gPiArCj4gCj4gUmVnYXJkcywKPiBBbmdlbG8KPiAKPiAKCg==

