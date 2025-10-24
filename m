Return-Path: <linux-kernel+bounces-868031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4DBC0430D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BE63B80CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 02:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0A2773EC;
	Fri, 24 Oct 2025 02:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lfReiZtr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lkl3hRzL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDB026D4DD;
	Fri, 24 Oct 2025 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274635; cv=fail; b=fIE2GJvCPo14+9zayOandMprYESME3wIeP33+soUbu7tYUOaoIietjiEIhheAOKhYnhxJoav8WmlqnKhPFgTf/bV5KgjkRtPsDUSBoVrcmru13YrKFjETMthDtrnzL+T5GlcDdEXtRH2Skm0fdxa7IuVEGWB4vRQRFFHwV4YibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274635; c=relaxed/simple;
	bh=+yt1mA42wEcmyTpIcOnaVmmFrq0QVqHUXp1xfRc+/Wg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tvT9BfqpztxLT66PAC/hPzbrjWsND7UyEAmFGW38mOjgmIpXAZpIwoxn36G26cEccyfjOBb+Jqm35TU94JyvN3GSHWQvuNAKyPnqNpMG1ODjKmtgaLuyK56E8WFvhpn1H/k9geenHTiq0UYLzzyjlDhVgcxm/xZfe/91+BlsFhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lfReiZtr; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lkl3hRzL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d0895e0b08511f0b33aeb1e7f16c2b6-20251024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+yt1mA42wEcmyTpIcOnaVmmFrq0QVqHUXp1xfRc+/Wg=;
	b=lfReiZtrw4otDDEPsIuy3jmRcSx1Bq1U/OU1ACZ80sCEpa8vMv9Nrw0pEXsufdFQSPPWp9ehO//UttjmmKIX0O02vgJQ808wgHgJWMvPHozL8kObxJUTo12RJcKWBd0iIn5FlQ3/QDHZgVM9s5NdZijcNQ5fGJMQwegcpI5tNAU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2f1c090b-6a3f-4e46-b00f-14d86b7ddd00,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:4316fbf0-31a8-43f5-8f31-9f9994fcc06e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:nil,Bulk:nil,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d0895e0b08511f0b33aeb1e7f16c2b6-20251024
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1114125736; Fri, 24 Oct 2025 10:57:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 24 Oct 2025 10:56:58 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 24 Oct 2025 10:56:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK2ErFuG4PlyRGiCNOZkO+NoyB7O1OyzcSUOT9sQ8VSZAV6tsMIvh9zSoIstefo66aatl9Ir5lhInxMBopUvSReBm6EHD1eBZAnM+U3y191yt4Sd5mPyOO2R6kIseBM4yyOCT6J7TnxvmBZetObmQGdeZUSKHIiUnV1y+hir4ZzkJ++JnrLZLTacGTTjQ3/XoJifftF/CcTgxNpuM3rKFEQhDjjmT0zjZM6Q9J3qicOkyFKfHGPJbpKQk7DKU0uU87h0ESzNBx8C6D38cDFsfwjm8GSXTb1GSLDlN5O93LjE+ez5nnKhU5K1aSrdr3nTlAUgIgPfdaoisFJTiVI0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yt1mA42wEcmyTpIcOnaVmmFrq0QVqHUXp1xfRc+/Wg=;
 b=mgORHYSdZDiOt0CTk2XRTeFpYCZ//zkI9AE/nnxpZkfqdtL6gcHf+YiOpNx+29Fk0HEy+haAQFELbkHvHFA4KmlvLeffOpLaHNC1zumR95BxPOe7Qrio33YyY0aiq3nM7NE0kscvIovrDQm337oEkF1Djyc7TiuOpbNPbXlHv/sWzXO9L7p7OICABJms4UY5QqtFyG+I/HksUElwGerHo5YL/77/IBchpRjUPdDUgljPMrM3x4S3fejMC7bP6KVrkSEf4guQvlV/S4+Wf9iSK+5XQqxKvk8VOGRcnJKI74F/ZjKfAFnjIdCiw680TThMdNIp+pntZ1/xi9G7V1SZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yt1mA42wEcmyTpIcOnaVmmFrq0QVqHUXp1xfRc+/Wg=;
 b=lkl3hRzLwdMSxtH7oL23aCuvCkcHNFfNvuvVjKI9i4/+tZOcJfuVFAQI0F1ZF3R+a0QpDZAM+ZKFlBiDzqDyNu+50gPpzQPJxsXGVzRrgI7iew9Pm5oW4bpARsb4k7xG/iIqxDMBUw7YRplp+0IvE66QftOsBKBAN0Z1AxmPR1Q=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEYPR03MB7533.apcprd03.prod.outlook.com (2603:1096:101:147::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:56:54 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:56:54 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v9 0/2] add VCP mailbox driver
Thread-Topic: [PATCH v9 0/2] add VCP mailbox driver
Thread-Index: AQHcPAsto9DZfasHeUaDhZuTimU8O7TQq52A
Date: Fri, 24 Oct 2025 02:56:53 +0000
Message-ID: <2aea1bc042eac7e2192bf687c597ecf3e18854e9.camel@mediatek.com>
References: <20251013063146.17919-1-jjian.zhou@mediatek.com>
In-Reply-To: <20251013063146.17919-1-jjian.zhou@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEYPR03MB7533:EE_
x-ms-office365-filtering-correlation-id: f3b129e8-2e92-4410-2a48-08de12a8fcdb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V0lHaFRTT2FOVzJsRnQzeXlYV3lYUTVsS045ZmxqODRoQUt1NHVZdHg1dXM3?=
 =?utf-8?B?Skl6SDJyanJkTkhvd3haaEJsbTVOY05QYmt3NjhiZGk2bHhjNU9iS2tyYnox?=
 =?utf-8?B?NWtsQlR2c0hQaWxBTEtUR3ErR3dwNVMvdTgybHYrZ1hhcENDNG9vdXNDZXp2?=
 =?utf-8?B?Y1J4ZC91Z1hqQWp4OW5KL2IwY2JaSFlFWERyWXpTaFRzYmNUUklYY05tL3lI?=
 =?utf-8?B?ZzhuTCtUSGQrdCtHcW5Cc1FzZVRyV1Y0TnZwYUQ1azRmaUJWdUROd2JKc1dp?=
 =?utf-8?B?SFh3MDlFWE81SGozYU44RlJ1MmNjT0lseTlqVGxlVW1RQUY2L0FlbWtmVlRy?=
 =?utf-8?B?ZXBNNmdxZGtEK2dtWVk1aUJwM05LbnVqOE40c3FJODA4MlNKdkpxUDk4VzVV?=
 =?utf-8?B?a1R4RHJ5RDdabU1WNmdjM0ZqcDB2bUNqYThDcXZpcFhNRHVjcWF4RVhmNFcr?=
 =?utf-8?B?MXRsVmRxTHNhWUE4Slp5YXB6MnlKU0NHaXg0T2xIZU00N1o3cUFGQ2lNQy9l?=
 =?utf-8?B?MXhWb2xoRm14dE1Oc0xRaE9sWDIyM0gwb0F3dkZiSGZsdmVnMUxSQi9oaHln?=
 =?utf-8?B?ZGdSeTJLdjE5Z3NYUFFJU0lkbnFWdUg5enV1OWRucndFZ21VNDNxRGxxYmVU?=
 =?utf-8?B?ZWFYcUJ4OTRLM1BaTWJ2a2xYN25MellBQ2xHZlNPdStxMjNmTWdtcDhKSjQ5?=
 =?utf-8?B?SXA3TXJaTng5d0FyQ3RsTGl2eGVITHc1UllSVFhjd0Jua1plalVxR0gyUXlW?=
 =?utf-8?B?anB4SVNhaUNDZmpoQlk0UjlJdDQ2WG9NYlordUxBV1NmZTZjRG1Zemw2UzFZ?=
 =?utf-8?B?ZUUxN09FR0hkV2dNL0tlV0tVcHJvZUhjMWViRDM3d2FKNDVsTGhySlN3OUc4?=
 =?utf-8?B?MnRjbWFvZjVlRG9MRHFwLzJQd1NjNFpRWHZhQ0tFdVNsUG92L3VGRWRiV3Nm?=
 =?utf-8?B?U2NyQ0RCSHdJTEsvbm9hVUpHRnFXaXQ0bTFDLy85U0JId1hXOWdEcWNzRWVy?=
 =?utf-8?B?QzMyVWpkT00rMmx3dDJwOHlqZHUxbm1OdEoxeHA1NVQ2b2g0OE5qa1NGWHQv?=
 =?utf-8?B?NEVqd1l1Y2p0aFhhNmtWbXYxeXRWNFNmbk1nTGc4UTVPRjcwRXZlNTFyOFVP?=
 =?utf-8?B?TUZsMVMwWDVTa3o4NVQ5bmV1VzFLSlczMGpFZ2NjbFoxQWlVcytmbnpYbXB0?=
 =?utf-8?B?TXRqckUyS01SbXNlY1NjK29GTGxOMWxnL1BjTTJGWUtoOURKaU1QanJQY213?=
 =?utf-8?B?cjIrcFlMam1NUTEvZlV2U3U1QVk2SENMRzRQZ29ZSGRIVVVuNlhGM0o0UzEx?=
 =?utf-8?B?dnVUTDlhK1ZsUmpDUVZRSW9DNkwxajE1ejZrbDBaand1Sy8zTTl2eC92YnBl?=
 =?utf-8?B?VjhtTHNtbU1ha3pSWnB4VytpRTQ0L0Q4ZjRhRmZ3aTRMa2xEUlR2NE9kN0Rx?=
 =?utf-8?B?RGZ4TU5iT1BSNmdPUjYyN1F2bGJ4NnFnNnF0Vk1ZUFJnbXRuTTV4bW51Qi8y?=
 =?utf-8?B?eFNZNVJvTFc0ZVV0SjdOY2xTSTdWeWIzQmtCd3VkaDJlbCtlTTVUZUdzTDlN?=
 =?utf-8?B?OERSbkZtUjRKU3FoTzhLZUQvOHdpT0dsbmUrSkU3T2NCd2NRNkRSckx3Sk9m?=
 =?utf-8?B?UUNya21qMzJUN3NlWGs0Q0dPSTBhYnhiNUkvNXlQbFhoNVkzMTFRdWhhbnNS?=
 =?utf-8?B?VGV2NG9rYURpbVlQeHgwTHpINlNSR3Q0aGJMVC81MkZzVEZ0ZXZYU3A0cVZi?=
 =?utf-8?B?UHBnR3p2SFJpNjFraVZVN0RWSDBzZkN0SE02dU5YLzJlV0F3UnlKbFkrSzYw?=
 =?utf-8?B?aHkwdGZwbzRLTXlvWVlNKzdlczVFb05wMTNtS0ZsSzFyNnVERzVlcmowT3dI?=
 =?utf-8?B?ckFGRUpmWVduVEx1bCt0SjlGaVlrQzFoY3d0K0d1czVvN0xnOXNNMDlHeHFM?=
 =?utf-8?B?WXkwaWFUUUZ5b1ZEM05UYW9ORzVwOUt3WllLMm5NWmFUeGVkaUpaK2pLMTRq?=
 =?utf-8?B?L3FNcE1CN1ZSMEZTYmpCM1FZcHFIR1RaMVdHUVJMUVdmKzlWdm12MHppR3U1?=
 =?utf-8?B?c2I1cm5lNk1KMWFEUHZzUldYaTRONEgzbmVKQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGVwSGIwWFErenJlKzdmclVieTE2c2RaVldXc2ZERUtOazhDMis3bllDcUVV?=
 =?utf-8?B?anZMZkZsUFFuZ0pQemhyVXVPRThRY2tVcVhEUm1PcUFPOGt1K0M0RFd2UjQx?=
 =?utf-8?B?NEt6eEpGUmZPRVBvL0tXOEVLSTNnRXFuVndHZVZOL201K2ttUnE4SzBLOFR5?=
 =?utf-8?B?NFVja0RVVHY1VHJqTW0rWE95MFllbGNBSjNkc1F5dEg0WXlZSUFGWmEzUXBI?=
 =?utf-8?B?V0pvTkZjWFY0UTBJd0RxVTQwV3hXZC91Sms4OFNsa0U3dmRBMm5HUkN3ZTUz?=
 =?utf-8?B?NGlBb29nMnZsek1KMVlHbERuODUwZmtiRGJ2L2k2NjA5M3F0RG1INEYzV2VK?=
 =?utf-8?B?M2pWZWhuVllHMWxxQmc3VGdKL2tGaHhmc0NZVTh2Rit1c1VUWG5QZEo0T2k2?=
 =?utf-8?B?YnBFZkd5ZW1uOWJWcm5hdU1BL3BrNzVsZXpNbXd2cUI4K0xPZVVySldYOWhs?=
 =?utf-8?B?OUs5WlhVN1dBRWR0eXF5WGRaRkQwNVFmaUtPQXFpSy9MVHI3V04rcHVENnQz?=
 =?utf-8?B?bzRrUjFIM0Q5bTZsL0RJdnY2RlJkbHJPS05mZ2FVTzY2MkxaZmxWc1BRSHA5?=
 =?utf-8?B?RUZzUVVUVTJhd3NqaUQ4ek9UWUNiZVV5ZFVRMWdIcm40RXVvWGdRTGRxNWpz?=
 =?utf-8?B?VWRBZ050TnRNQ3dIREVvbjRRbWxXVnBCYldPZ01ESUhHWTJEKzA5cko3QXAw?=
 =?utf-8?B?cy85amdsRTN6YmorRFRWK0VXT2FrODB5VjJmVm0zMEtqZXlELy9zcG9CWUxS?=
 =?utf-8?B?ZDFwOXZvN1NEcWR4TDBxbWRMWnhITHlhMmpPWFBlMUVUODRoY2w3a3IwaTBs?=
 =?utf-8?B?dVJ0NzBJdzdObXgwSGZoNW9iWkFnc3BpZjYvalc5WXlRejdkRWlhWWplYVph?=
 =?utf-8?B?bUd4Slk0MUVzTVg1SU5YeTVISTBSTG40WU45RmhGNWo0M0RYVHdVS2tQUGFE?=
 =?utf-8?B?aWxzUEkwQXJrVkJ2NXM2WGVxQUFSMGlwZnhYWHhUb3hnRjJRZnVHZStyMzZa?=
 =?utf-8?B?M2NPdFFieE13UWtwbHJ1UUVDTzdkbWVnOTZKeHJVQVN2RXc4SERuTHZ5ekNv?=
 =?utf-8?B?Q24xNURqbVl0TUFMT0ZYdXRzWmI4UG9XOWFhNmk2UHVDQk5aU09CNXFQUFov?=
 =?utf-8?B?dlpUVG52NWhXSVFPT25NcUNvd2E1Nk1PK2pHWjFPYXVqZjVkbFBwaWJ4dGk3?=
 =?utf-8?B?RDIyMy9RR2E5NitRK3MvcTVMR2lMbUlkdXdGSVY5dWdUOGk3c0g5TTh2cXhm?=
 =?utf-8?B?d1RKNXFpVFY4QlUwUWc2SzhNZGtnSlBuVmE4YXlRSmlJRXkxKy9wMCtpYXRM?=
 =?utf-8?B?NzhHSUVFRCtLMllwMUlpVW9YZnRtdXgyUDBOZWdRMDlQdmRCS1d5cTlSL2xh?=
 =?utf-8?B?d2ovS0xEc1Nab0xGckdDcll3NlZMVnEzYytPZjllMWp2eGpiZVBMOVJ3cmM5?=
 =?utf-8?B?RGFtL1BPZ3R3YUF2RCtQZTV6ZjI3M0pqOVVYeDJwOUd1bi9LZ0x2MWQzL3pu?=
 =?utf-8?B?RVVYN1ZRaWR4K2UwdU5BV0UzSUFPeFRPZkdERXozTFBuY29MbTZ0ZEZodXdo?=
 =?utf-8?B?emxuNDFQQytYckpmcWM1Ylp0M2JXaDl0cTJlSGxaMFlXUWNuYTlEVkpydFdH?=
 =?utf-8?B?N1FuS2srTXEzb2paK3BNRy84Z082MDdiMXVKS1AxVEowUnRCNHhVc3VUMWxI?=
 =?utf-8?B?WE9nWThRR0haQ1lqQkl1d20xMWFnN1BSY21YcUs4UE5HZkI4N3FQNXgyUXJW?=
 =?utf-8?B?b3cwSXV4V2tGZ1d5b1Y4Q3Q2OVZraWtXVDhMeitZdXNwd3NFYjRjMmtteU83?=
 =?utf-8?B?K0FVZGU3ZlpDYXdDcXQ0ZDczcm92eWN0QklKVENOdHlMNVR1SVMwYjc5MDNM?=
 =?utf-8?B?NWdSbGg4VlVVRmlUaHc2K2FQTTQ3REgvZ3g1ZlVXdzZLTXQ4VGF0cmRaMFFx?=
 =?utf-8?B?eTMxVnVqSmhTcDBTUk8ybGxNbmtmVld0c0N4RVl0cnhEZC9Za3FDUzR3QTFu?=
 =?utf-8?B?bitqeHVna3grSEhLWmx5VFBlVW9CVGNWR09abG45OHMzaFp0djdoQ1ZaZE40?=
 =?utf-8?B?NTJKcGcwL1FTNFVwUGQxb0U0bHpUcUJVR1lsdGw3N1hWaGtqN0JKV3RIc3pq?=
 =?utf-8?B?RThRMzVFakg5MDl4Vm9kcHR6SWNVanJIbkgzVDJ1bGNCMXMrTHV0QldGa2ZL?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1993CE0975C5B14D898086D8CC80CA8D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b129e8-2e92-4410-2a48-08de12a8fcdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 02:56:53.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0949uGeZ5KENANPgku3ZfCIPgfwIP5Xs8tfBS3pcvfJ/+KrI6s8HdgupO7Xa/O9KDFwZKgiPJKshBQMSH1ICQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7533

T24gTW9uLCAyMDI1LTEwLTEzIGF0IDE0OjMxICswODAwLCBKamlhbiBaaG91IHdyb3RlOg0KDQpU
aGlzIGVtYWlsIGlzIGp1c3QgYSByZW1pbmRlciB0byByZXZpZXcgdGhlIHBhdGNoOg0KDQpodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAy
NTEwMTMwNjMxNDYuMTc5MTktMy1qamlhbi56aG91QG1lZGlhdGVrLmNvbS8NCg0KPiBIaSBldmVy
eW9uZSwNCj4gDQo+IFRoaXMgaXMgdjkgb2YgbXkgVkNQIG1haWxib3ggZHJpdmVyLg0KPiANCj4g
Q2hhbmdlcyBzaW5jZSB2OToNCj4gLSBBZGQgIlJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4i
DQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY4Og0KPiAtIFJlYmFzZSBvbnRvIG5leHQtMjAyNTEwMDgg
YW5kIGZpeGVkIGJ1aWxkIGJyZWFrcy4NCj4gDQo+IENoYW5nZXMgc2luY2Ugdjc6DQo+IC0gbXRr
LXZjcC1tYWlsYm94LmM6DQo+ICAgLSBDaGFuZ2UgdHlwZSB1MzIgdG8gdTE2Lg0KPiAgIC0gQ2hh
bmdlIEJJVChpcGlfaW5mby0+aW5kZXgpIHRvIGlmLg0KPiAgIC0gUHV0IHRoZSBwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YSBiZXR3ZWVuICJvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEiDQo+ICAgICBhbmQg
InBsYXRmb3JtX2dldF9pcnEiLg0KPiAtIG10ay12Y3AtbWFpbGJveC5oDQo+ICAgLSBNb2RpZnkg
dGhlIGRlZmluaXRpb24gdG8gTVRLX1ZDUF9NQk9YX1NMT1RfTUFYX1NJWkUuDQo+IA0KPiBDaGFu
Z2VzIHNpbmNlIHY2Og0KPiAtIG10ay12Y3AtbWFpbGJveC5jOg0KPiAgIC0gUmVwbGFjZSBtdGtf
dmNwX21ib3hfcHJpdiB3aXRoIG10a192Y3BfbWJveC4NCj4gICAtIE1vdmUgbWJveF9jb250cm9s
bGVyIHRvIHRoZSBmaXJzdCBtZW1iZXIuDQo+ICAgLSBEZWZpbmUgInN0cnVjdCBtYm94X2NoYW4g
Y2hhbiI7IFJlbW92ZSBhbGxvY2F0ZSBvbmUgZHVyaW5nIHRoZQ0KPiBwcm9iZS4NCj4gICAtIFJl
bW92ZSBBUEkgZ2V0X210a192Y3BfbWJveF9wcml2Lg0KPiAgIC0gUGFzcyB0aGUgcHJpdmF0ZSBk
YXRhIHNpbmNlIHRoZXJlJ3Mgb25seSBvbmUgbWFpbGJveC4NCj4gICAtIE1vZGlmeSBtdGtfdmNw
X21ib3hfeGxhdGUgInJldHVybiAmbWJveC0+Y2hhbnNbMF0iLg0KPiANCj4gQ2hhbmdlcyBzaW5j
ZSB2NToNCj4gLSBiaW5kaW5nOg0KPiAgIC0gUGF0Y2ggMSBmaXggJ21ha2UgZHRfYmluZGluZ19j
aGVjaycgZXJyb3JzLg0KPiAgIC0gTGluayB0byB2NQ0KPiAgICAgDQo+IGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI1MDgyMjAyMTIx
Ny4xNTk4LTItamppYW4uemhvdUBtZWRpYXRlay5jb20vDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHY0
Og0KPiAtIGJpbmRpbmc6DQo+ICAgLSBNYXRjaCB0aGUgYmluZGluZyBmaWxlIG5hbWUgYW5kIGNv
bXBhdGlibGUuDQo+IC0gbXRrLXZjcC1tYWlsYm94LmM6DQo+ICAgLSBEcm9wICdkZXZfZGJnKGRl
diwgIk1USyBWQ1AgbWFpbGJveCBpbml0aWFsaXplZFxuIiknLg0KPiAtIFNpbmNlIHRoZSByZXZp
ZXdlciBob3BlcyB0byBjb21iaW5lIHRoZSBWQ1AgSVBDIGRyaXZlciBhbmQNCj4gICB0aGUgVkNQ
IGRyaXZlciBmb3IgYSB1bmlmaWVkIHJldmlldywgdGhlIG9yaWdpbmFsIHRocmVlIHBhdGNoZXMN
Cj4gICBoYXZlIGJlZW4gc3BsaXQgaW50byB0d28gcGFydHM6IHRoZSBWQ1AgbWFpbGJveCBkcml2
ZXIgYW5kDQo+ICAgdGhlIGJpbmRpbmcgcmVtYWluIHRvZ2V0aGVyLCB3aGlsZSB0aGUgVkNQIElQ
QyBkcml2ZXIgaXMgbWVyZ2VkDQo+ICAgd2l0aCB0aGUgVkNQIGRyaXZlciBhbmQgc3VibWl0dGVk
IGFzIG9uZS4NCj4gLSBMaW5rIHRvIHY0DQo+ICAgDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI1MDgyMDA5NDU0NS4yMzgyMS0xLWpqaWFuLnpob3VAbWVkaWF0ZWsuY29tLw0KPiAN
Cj4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gLSBiaW5kaW5nOg0KPiAgIC0gUmVtb3ZlIHVudXNlZCBs
YWJsZSAnfCcgYW5kICd2Y3BfbWFpbGJveDAnLg0KPiAtIExpbmsgdG8gdjMNCj4gICANCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMzE3MTEwMzMxLjI3NzYtMS1qamlhbi56aG91
QG1lZGlhdGVrLmNvbS8NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IC0gTGluayB0byB2MQ0K
PiAgIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTAzMDUwODIwNDcuMTU3NDYt
MS1qamlhbi56aG91QG1lZGlhdGVrLmNvbS8NCj4gDQo+IEluIHRoZSB2MiB2ZXJzaW9uLCB0aGVy
ZSBpcyBvbmdvaW5nIGRpc2N1c3Npb24gYWJvdXQgd2hldGhlciB0aGUNCj4gVkNQJ3MNCj4gSVBD
IHNob3VsZCB1c2UgbWFpbGJveCBvciBycG1zZy4gVG8gcHJldmVudCB0aGUgZGlzY3Vzc2lvbiBy
ZWNvcmRzDQo+IGZyb20gYmVpbmcgbG9zdCwgdGhlIHByZXZpb3VzIGRpc2N1c3Npb24gbGluayBp
cyBhdHRhY2hlZC4NCj4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FHWHYrNUZYcVpi
X3YyZFFOZ0NLYkZwSnJMaGJWazNmMHNXcnJNQ1ZrM2phV3dvQnFBQG1haWwuZ21haWwuY29tLw0K
PiANCj4gDQo+IEpqaWFuIFpob3UgKDIpOg0KPiAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBtZWRp
YXRlayxtdDgxOTYtdmNwLW1ib3g6IGFkZCBtdGsgdmNwLW1ib3gNCj4gICAgIGRvY3VtZW50DQo+
ICAgbWFpbGJveDogbWVkaWF0ZWs6IEFkZCBtdGstdmNwLW1haWxib3ggZHJpdmVyDQo+IA0KPiAg
Li4uL21haWxib3gvbWVkaWF0ZWssbXQ4MTk2LXZjcC1tYm94LnlhbWwgICAgIHwgIDQ5ICsrKysr
DQo+ICBkcml2ZXJzL21haWxib3gvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkg
Kw0KPiAgZHJpdmVycy9tYWlsYm94L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAy
ICsNCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstdmNwLW1haWxib3guYyAgICAgICAgICAgICB8IDE3
MA0KPiArKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstdmNw
LW1haWxib3guaCAgICAgICB8ICAzMiArKysrDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDI2MiBpbnNl
cnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssbXQ4MTk2LXZjcC0NCj4gbWJveC55YW1sDQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tYWlsYm94L210ay12Y3AtbWFpbGJveC5jDQo+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay12Y3AtbWFpbGJv
eC5oDQo+IA0KPiAtLQ0KPiAyLjQ2LjANCj4gDQo=

