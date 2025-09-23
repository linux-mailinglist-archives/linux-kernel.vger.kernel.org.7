Return-Path: <linux-kernel+bounces-828436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C095AB949BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676D21650A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C230FC03;
	Tue, 23 Sep 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sqIyEaY3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NFkn7nxR"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33C30F95E;
	Tue, 23 Sep 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610015; cv=fail; b=jTFnvVIbU/MtXYNeO0QfcBFqSHTYeKMp/7LoZWN98e4JgF+N/bfj0q0NPxmJIVbDdtdDJl/xfi9CQQ6E9X7YZue3+WaN7SU0D6Np0KcZilU9hcoR2A4fYJ+tsSVnrT3ajuCdqpJuCdL710+YTP+4YaJZhBlIn8qbEKZIjn+BFXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610015; c=relaxed/simple;
	bh=sC1QU0KNWf7SJ3Z+JWpO5Q9pbVL4JNbALTKscLwpqa8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIzHXuZOEuht7ccn3N47dg648i8+9S/KBd6XrXUnlx3SjaYQ2dm19Kkjyj2M94Tq723l6Gb2ZrRd5ZAZO9AXYGhSFVu/ysm8CdqXFSdtpxu9LJ9NoAtl3WtiOo9tNPCKbyPofkHQGAl0LBpqGhxTD1d8q1UMc0CEhFBqXGTiREw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sqIyEaY3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NFkn7nxR; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 14c583f6984911f08d9e1119e76e3a28-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sC1QU0KNWf7SJ3Z+JWpO5Q9pbVL4JNbALTKscLwpqa8=;
	b=sqIyEaY3q9KHA9vxYKuMdSt6OnD/io51huatAdKTdcGYTq9pKCycZ30o4+0NDFgXtTPO1odYIXGhrT6tJ8klJXjPCUc7Xxl7VNJUfaTswHPjlm5k9JOtlfUur1cfs98RW6ZU9ZGuvuK9d20EztHt1Gsvdj7GKTGHfCZR86EhWFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:8e6bc095-e8d2-4426-b153-de1d6112180e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:aabdc021-c299-443d-bb51-d77d2f000e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 14c583f6984911f08d9e1119e76e3a28-20250923
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 411314414; Tue, 23 Sep 2025 14:46:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 14:46:48 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 14:46:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emrTZ16ehnsnFtcqRDDQiRS3BtWMBINpEnX7FfYukJzD6sr4gb6iXCC3m+51hBRMv+7CsUcbKIl5yHQPcmvp1d23kZwql0vyyCURZRUJAp7ggbC/CKjmFIukn0WQa2Ki4/SXCfzu3ceNxcR7dg2mCiEJVnzYXcsHGjsP70qonlclovLULFbJVagmUixeXM8cRI8t7dmwakoJDwFTVfa5aQtEHnmlXCQwKKGHr5eYaX9QSn1qzzczmo9Hjjey/MNKMHwGlCtdk7SHp+jyLmarbMFpHAEGvQk/u00XadS5LLrn59e15eGn3VZ4ee3mj6nRZ996Ww/sGaegqgYhCfHxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sC1QU0KNWf7SJ3Z+JWpO5Q9pbVL4JNbALTKscLwpqa8=;
 b=jd3iZy9+9gH1KGci8irCuWAczJt5gU4NUWXzcICMuwFQuYeE+ytXVrTrg4hAQegn38Px56O47HlW9ZEqFVz5MQ2FifmTpnIjukArmv03eaJ9fcqbMf5GH6Yy8SQ6gmOct8QnPjXCm+pNFAkiSKKQEs3qSm/mYGjX/7gs3gtnL0xz5bI3dDVnnEc5+A3gJ/yCnclSGf716hEIC3UUOA+9drJfg3xpmu5ACTNOP1fle5qbwTXDexEXTvVzMG8vP1mX3JecFDBvSgqt0+tfeyljjO3e2G19UGUnANqZxqA/kmR3SxQqn3m+K5gRcw1JxOrMLU8r1uXSFOEPD8BInMECWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC1QU0KNWf7SJ3Z+JWpO5Q9pbVL4JNbALTKscLwpqa8=;
 b=NFkn7nxRI3r9gol7ZpKBoyjX1RxroVn1x9DAvmfboWjQqnAijppnznj00ewAtLnXEMtjjUbYqsMusK+cVPV+59po+1LEIe7NzQa5vm+erixsUHJTuiovpNFWh3Ilgi4/RvwCrB3uWvMRe+vcH/nZf4+r3B5qeXO+D9mj3okoCLg=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEZPR03MB7121.apcprd03.prod.outlook.com (2603:1096:101:e6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 06:46:42 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 06:46:41 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Topic: [PATCH v5 2/2] mailbox: mediatek: Add mtk-vcp-mailbox driver
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgAa9iwA=
Date: Tue, 23 Sep 2025 06:46:41 +0000
Message-ID: <24a916ece6971d3ab9156dd8277eb23935e9cb13.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <20250822021217.1598-3-jjian.zhou@mediatek.com>
	 <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
In-Reply-To: <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEZPR03MB7121:EE_
x-ms-office365-filtering-correlation-id: 13267847-2f94-4cdd-975b-08ddfa6cf42b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U0ZIV2hNVEdYRjhHclVvYWNDQmJQMk1MZDJ1S09LWDViUEoyeldZRnh6UjBk?=
 =?utf-8?B?NUxVcWZOUFVzcTJEQkJ1L2w0VkVCVmJqenZxeEcybVAyOVJTM2FFVmFvVEwr?=
 =?utf-8?B?TE1PMklhL2dXMHR5bkFUTllySXVGeWp6TDBSMFRTeW1TKzNpd0Z1N1laaG9X?=
 =?utf-8?B?K1dwdlFTRE1wUVdvaC9FSHNuTXdFTCtzTU5zd2ZrRDl4YXhET09ONkhaL09S?=
 =?utf-8?B?WGZ3VkVlSlE2QVNka09Pblh4RzJpa2Y1aE1reWdSUXdkZllhSzZKMHA5L09M?=
 =?utf-8?B?d0tRVW00KzdQRGhWSUdkRXNRUmMzQmp3T2ZBeEY2d3E0Zm1IdlN2VUpBb1Ur?=
 =?utf-8?B?bDI2NHhJTGVtcjlUWXY1a21MaUhFbU9SckM4Qm40VitURnJ1cmRWYnNtODlZ?=
 =?utf-8?B?QnA5U1JXQjVWRXpySWtIcTBFNmhRSWpaQ3Fya0I3SjlpTWNPRjVBMDlJWUNp?=
 =?utf-8?B?RHFxcEpING9KampPWmhNRE5HTWMwOGpyS1VZMTlra0lhOTkwNllTb0tCWXI1?=
 =?utf-8?B?K29pdnpiaENScVhQV0dlRnlXLzFuS1NUaHRoM2doNVc0NTBtemxlajcyRmU1?=
 =?utf-8?B?TzBHWWhuYUdwdnRoR05nSWNEdU9CaW1NT2RDdUY3VUpqUndyRkVSQ2RPb1hx?=
 =?utf-8?B?WXh6WFJ0Q3hzVy9mVlNuYTllVmVoUnJVSzluc3B3Qmg3VHQ2bUxmd0pxOEtt?=
 =?utf-8?B?ckltQjViNXVFdVBya1R5VkdqUmNYNDBUWDgxdmc4dElZS3NqeHRNQ2dLUzJz?=
 =?utf-8?B?RFVHTFpNMzNTTm13MkFTcG04S2VEODhUbHZIRUJVbmE5QU9LUUh4WUJadXd6?=
 =?utf-8?B?dEh5UkE5bG1XcHZtZmwySmMxYlhwSEQ4dkxUcWVnTGxRMm9qMW9BeVYzKzhK?=
 =?utf-8?B?UlBIZTI2QSt3TUdJemJQeDlmc09peStpcnBZandUWkpRNy9HOHd1ekVSNFpk?=
 =?utf-8?B?WDJ3MnMwWWNIS1RUTVRMN1doM2RFSkxSN1R4dHMvZ1pvc25IZlNOdmYxWWF1?=
 =?utf-8?B?cStOU2FOcGRubXhuUFN0WnM0Sk10UXI0NXVoMHdEVGFlelprT1pvWHZUSjZS?=
 =?utf-8?B?UkxkTVBzekZpbE1pcWJQdy9na2lXckQ0WURMWTBINkt6aEhndG83OWZmcUhs?=
 =?utf-8?B?VWhscVdMNmZTTVFCNFRYeWptb2dNVWl4am9NVzJEclJWbUc3dnpJeWxaL1dO?=
 =?utf-8?B?TjA5ajZxRXp4M0dVeWR0a0Erc1lhSlJnWkVIREVPN3dSYlBqM2FJYUdLY29o?=
 =?utf-8?B?djdjam1BU1JGajBJSUlkMTVPaCs4VEc2dXNhRkFkRnc4eDlpSDZ3UzBnOGNn?=
 =?utf-8?B?TkM0cmdBWVh3akJsclhlVTA2NjQ4ZlVPbmxISWVtYU45QmZMZ3JtaUdiL2l6?=
 =?utf-8?B?bHAwNjFoTlEwSVhBQnFnQ0J4eWRpTjM3UEl6eEQxeFRBMjBVSjM5bDVQcGdj?=
 =?utf-8?B?OVRyMlQ5OCtkeEdNeWp0dzRPZzl5T3RDdW5PS2ROOUdDL3o5T0NjVVkrTnAr?=
 =?utf-8?B?dnUyVGQrUCt0WTkxbVVObHJyUVpzOW93NDJ4VHI1Tm4vaEtxcnhhODN6VS9S?=
 =?utf-8?B?THBvUTdyLzFMeFZidzhBakF4cVZFSytPZzNQNk9iNkFMdXU2TEpWSFVuRjZz?=
 =?utf-8?B?SVV3UXEyZzVKQXRsVmI5RjJTbmY2MmVLU1QwUVBhb2RYYXpZdlNNNmdWZlZX?=
 =?utf-8?B?OEZwY1hLVjl6a0VrVWR2REVpcExuTi9KbEVJQlgrSnJOVkNSTWpDbkVnajQ0?=
 =?utf-8?B?bHJtVVFLcE5ENVQwZHpNdmRsTklSeHNqYzhxWGVpQXVTcmdUNDMvclZxZHAr?=
 =?utf-8?B?ZisyZGozRE5jdDNUZjJOVDdtNEdMTjhHRXNyV2Rma1lpS090OHNyR2wwWFpv?=
 =?utf-8?B?L2JuS05FdVo3b0pDTUJGSkxnUlpiODVndGcxdDZqcnpacXYzcTc3eTJhM3B3?=
 =?utf-8?Q?0wRjKSha5wc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU5PWjVGWW9ON2dwYld3UDYyN0JxVitoYkUyWlF6M0hoU0Jtcm8veVhrbmoz?=
 =?utf-8?B?YlZTaWxHTW1SZUFDTEdHcWk1YjBhZTMvQ0dPTVRaSnEwbjNybXF3a2hkdjFH?=
 =?utf-8?B?Uy9CdldLa2ltSW1CcUwzN1ozOUdMazVkeXNhT0czajFINjdIaG9WWjE2TTk0?=
 =?utf-8?B?aFMvMkh6VCtlamlKd1Mra0tqUXhGTlZ3b2hCTFVxUmx3TDhvcmJaWXdOYUZy?=
 =?utf-8?B?MTdDODNmWDBTN2VHWURNSzVJaHhJUTRWMjh4b1JHNFNvTWZNcnYvOVR6SW9I?=
 =?utf-8?B?YlV5a0lXRDRjcXgrNW9jWWdaL0FONXZZT2psNjU4blhKL1dMRTBTemR4Y0Qr?=
 =?utf-8?B?Q1c4a3hjT3JINmIreVVGZWZzWHJOdDB3REViS3NIU1JHRGU1S05qZnE4UFd1?=
 =?utf-8?B?TGlyNVQvQUFBM0VoK2tOTGJrdkJrRDZhUUliZUE5NWJQRDJMcnBrZDdrdkIv?=
 =?utf-8?B?V2daZHJPQXNqajk0TjVydi9HbWlKazdETUY3Vm5wZzl1OHUvZG4yajh4N1hN?=
 =?utf-8?B?cnJUM0hFRldhOWhpdnFXWFoxR2l0cC9HNnljSEhZWGZCa0xqUVpLTjd1Qkht?=
 =?utf-8?B?WVNvT2hEN0VvRTdQWDFYQmg4SUZSNVNwZUI5b0dpVG02VEl5eHFSb3JpQzEw?=
 =?utf-8?B?eDJBTEFTWEgrdVRhZEJDNmFQUElCZjIzSGUvejJxT2RYS0JhZXkzSERNSHVO?=
 =?utf-8?B?VzdsVnVzMVlSMnpLaWdWdSsvMEFTdGV3VkIrOE1DMFRFU2F1dU5ncGxiQzE1?=
 =?utf-8?B?S1BxMnFwckdITGVhL2ppWnRzZ21kQkVFblYrMTRoTDQxRkg4YWpibWRPM1M1?=
 =?utf-8?B?NHErZHNkQjNPYlJrRUpEdGp3VWpaeWpTU2RwSGFpYVhjSFI2Uk5maWZad1FH?=
 =?utf-8?B?Y0huVFJPOG1tK2ZyL084QVF1UDd4M2FIMk4rZzFZL0hXaVdsdkhRT2wrL3N5?=
 =?utf-8?B?dkJkZ0owMFQ1bGhsQ3NONEdTK1IyTENsMjhVOTF4MnV6ekNub1JUMmdLN3N5?=
 =?utf-8?B?QzdkNkoyTHY0K0NObVVUK3JHSjVJZEszL2NFRG95NkowMSszTndKM3FiSndQ?=
 =?utf-8?B?Z1NmTGNJcHo4RFI1UE9aNEtMbTZMK0J4VGttRHZJM1lDcUlWa3dSTCtSR05N?=
 =?utf-8?B?UEhMU3o1SG0wT1lJM2dVY3hXeGljak5jQ1loMy94cHpTbHA5QnpmMVNDUlQ1?=
 =?utf-8?B?VTgzV0xuSmd1MGpJSEp4ZVYrTXBuVDBSYWJjOTdsVXFKajNLRmR6MFV6UzN6?=
 =?utf-8?B?NnB3K0JpZzdHNHVjQUpvOTJEeGE1L1c4VHc5STdpYWNCbTZhVExPNHRKL2Vz?=
 =?utf-8?B?WW8vZTcxT1N1dGd0S0dqWmQveGZlelBXNndaSGRJSkl2YXNhcGRmMHNrYitP?=
 =?utf-8?B?RURZV1pNSFJRSnU4Qk1weWdrdDZHamlWTHYzZzBSdUo3djJuVGc0dGRQY05T?=
 =?utf-8?B?eXBaSEIyUWdVVy8zNkk5YWcrODBnSWdtQWRnWFNQc2V1ejRNeUxwTXVhNm9h?=
 =?utf-8?B?OFRQSnd2UkNWYjFxeVlabGlCeVpEQjVENVhMNXdnMlArZ1Q5dk5HRHdxMWdo?=
 =?utf-8?B?dUJ2TThWdG1RQmtSVG5wbEFyZUJSeVV5c0dLSGkyRnJDMHFSY29Mdjc2Sjg5?=
 =?utf-8?B?c3NHL2ZoZkYvK0NzM3NUNWttclNCY1NQVFFHT05wQ0k2ajdRaTFtcnFZMzZt?=
 =?utf-8?B?WEE3d0JKcnJvbGNRUEVXU1dnZnQzaW54L3Qxb1pNU0NKL2djNU82UlVIVnZi?=
 =?utf-8?B?aVhFZmhEUkEyVzg1ZlNJUkFubGJJR3VrYncwTGhRbHRHbkRCY1FPcERzdXov?=
 =?utf-8?B?R2hXbFJMYmtsR3hycG0ycHo0MzNKTm1MM3BHK21EZ2szV1UwQkVJSGMxY21y?=
 =?utf-8?B?UjhZbC9wbG9neDZncmp4UDdvVEZDUUFxRXdNeGhZRlloaHlpV0xybENTTFhO?=
 =?utf-8?B?R05UUHplTy9aOENmZk1xdzZKYkFLRzIzTzM5a290R2JyM3F3TGpjYzlYWWla?=
 =?utf-8?B?bnhlOGhRaUVMZ0NKTEU1bys0bENNYlY2QXBaNVowR3Nrcnk5TmY1dUpEZ1RE?=
 =?utf-8?B?eGYrSFFoVHZINytHUUViM3c1ZzNTYUFlRktDUi9Gb1kxUnN2a1gyYnNjZ0pL?=
 =?utf-8?B?MFFVNm5ueW5SdFZacmtkamVVWkp1UVB0Zmx6eTJoNTU5THZmZ3NVQllTTUFS?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <756A0D0C55583949AD5D757374C09FB4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13267847-2f94-4cdd-975b-08ddfa6cf42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 06:46:41.5998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y51Xs5tr3ksPBeq1U/fbF9aOwFZXK2Fc+7NKznHkMoPTEANEMhUcuHvaxNVNeLMzy9LvXCsMyvPaoPw2ChiuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7121

T24gVGh1LCAyMDI1LTA5LTE4IGF0IDE4OjUwIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIFRodSwgQXVnIDIxLCAyMDI1IGF0IDk6MTLigK9QTSBKamlhbiBaaG91
IDxqamlhbi56aG91QG1lZGlhdGVrLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiAuLi4uLg0KPiANCj4g
PiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4N
Cj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvc2xhYi5oPg0KPiA+ICsNCj4gPiArc3RydWN0IG10a192Y3BfbWJveF9wcml2IHsNCj4g
DQo+IE1heWJlICdtdGtfdmNwX21ib3gnIGlzIGEgbW9yZSBhcHByb3ByaWF0ZSBuYW1lID8NCj4g
DQo+ID4gKyAgICAgICB2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2
aWNlICpkZXY7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbWJveF9jb250cm9sbGVyIG1ib3g7DQo+ID4g
KyAgICAgICBjb25zdCBzdHJ1Y3QgbXRrX3ZjcF9tYm94X2NmZyAqY2ZnOw0KPiA+ICsgICAgICAg
c3RydWN0IG10a19pcGlfaW5mbyBpcGlfcmVjdjsNCj4gDQo+IE1heWJlIGFsc28gaGF2ZSAic3Ry
dWN0IG1ib3hfY2hhbiBjaGFuWzFdOyAiIHNvIHRoYXQgeW91IGRvbid0IGhhdmUNCj4gdG8NCj4g
YWxsb2NhdGUgb25lIGR1cmluZyB0aGUgcHJvYmUuDQo+IEFsc28gaWYgeW91IGhhdmUgICJzdHJ1
Y3QgbWJveF9jb250cm9sbGVyIG1ib3g7IiBhcyB0aGUgZmlyc3QgbWVtYmVyLA0KPiB5b3UgY291
bGQgc2ltcGx5IHR5cGVjYXN0IHRoYXQgdG8gZ2V0IHRoaXMgc3RydWN0dXJlLg0KPiBTb21ldGhp
bmcgbGlrZSAic3RydWN0IG1wZnNfbWJveCIgaW4gbWFpbGJveC1tcGZzLmMNCj4gDQoNCg0KRVJS
T1I6RkxFWElCTEVfQVJSQVk6IFVzZSBDOTkgZmxleGlibGUgYXJyYXlzIC0gc2VlIA0KaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVyby1sZW5ndGgtYW5k
LW9uZS1lbGVtZW50LWFycmF5cw0KIzgxOiBGSUxFOiBkcml2ZXJzL21haWxib3gvbXRrLXZjcC1t
YWlsYm94LmM6MjQ6DQorICAgICAgIHN0cnVjdCBtYm94X2NoYW4gY2hhbnNbMV07DQorfTsNCg0K
Q2FuIHdlIGlnbm9yZSB0aGlzIGVycm9yPw0KDQo+IC4uLi4NCj4gPiArDQo+ID4gK3N0YXRpYyBz
dHJ1Y3QgbWJveF9jaGFuICptdGtfdmNwX21ib3hfeGxhdGUoc3RydWN0IG1ib3hfY29udHJvbGxl
cg0KPiA+ICptYm94LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgc3RydWN0DQo+ID4gb2ZfcGhhbmRsZV9hcmdzICpzcCkNCj4gPiArew0KPiA+
ICsgICAgICAgaWYgKHNwLT5hcmdzX2NvdW50KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
TlVMTDsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1cm4gbWJveC0+Y2hhbnM7DQo+IA0KPiByZXR1
cm4gJm1ib3gtPmNoYW5zWzBdICAgc2VlbXMgYmV0dGVyLg0KPiANCj4gdGhueA0K

