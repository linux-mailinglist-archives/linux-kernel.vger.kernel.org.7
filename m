Return-Path: <linux-kernel+bounces-884499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5910C304C3
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774E33B66C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AD306B37;
	Tue,  4 Nov 2025 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SO/+JJb4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="doQldKWC"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE923EA9D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248575; cv=fail; b=GvLilB+yjfuT2VQmvxRM6DvxOyQhZe+Qpo1vx/bLAUZ44xmxdJCb7hv3qaLqGQNw8OD5murFcCx40AixC4yaQBXiZ/eWqfYKbvcFWnqilGrtai8zOfJuuA9OLuAmeALLHumw0GeSbhudeauwBkaMTOKif+xHGY7+AXCpdAIlcaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248575; c=relaxed/simple;
	bh=nsWqlGvOTHmJEeqLDeYMyMDRlSEqzlWIE47fTC7la8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ha3oPFppnCl2XDR59t+Kcuq5Znm79wxLpOxsH6jyeExJM9hVGEbJ41xs4qMOO73Mr5S0ycAJ0T0mkm23/sv6fA9NkqfU7w8sM2LC7BdWC2rFwrve99uMug/AVHrrSl+4K3c7R8ysS2IhjAVwNekiCuJsgcAPTFFvjaZ/maD+86E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SO/+JJb4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=doQldKWC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c19aaf24b96011f0b33aeb1e7f16c2b6-20251104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nsWqlGvOTHmJEeqLDeYMyMDRlSEqzlWIE47fTC7la8g=;
	b=SO/+JJb4vKEmEizN9cfKS5qCA075RWv96q2vVXpusA6SUfv1QpkLEboORK6vckBBh2av2PNySY9XtTPWvwZD8X3J9n+vk+k22AgS/N0TAxB3P0lLpYj0m15SgxvRohYas73DgIT/IIiYUtNHJledBnmNmQ4Aa36cV1JiuFycxJk=;
X-CID-CACHE: Type:Local,Time:202511041729+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:a4d1ee57-71cd-4283-a749-a9cb81effff0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:1eaee47c-f9d7-466d-a1f7-15b5fcad2ce6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|51,EDM:-3,IP:nil,URL:80|1,File:130,RT:0,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c19aaf24b96011f0b33aeb1e7f16c2b6-20251104
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 496550146; Tue, 04 Nov 2025 17:29:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 4 Nov 2025 17:29:25 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Tue, 4 Nov 2025 17:29:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Quh4nERzWEYjyEpTZw0aw54raxUhWjN1yvyb4BbeFK+696Owd3Gr5lBKGcJxewSsKDOtgneUke0qATUBw7CuVId0FhhpO94G75jaQ0aw0SIwhYtRZqspsoCsX+2lgl0Q+8GvChumMLAlBYSqYfMOKJCeNMOhDBtwQgH+OQ7ZJNvtyFSHJIlcZ/uojIabv+zRGw0BOk39S1N3TWTnmUh0Qf763YpSPTT8pkvelBkNSK/AGq1loabes19fkQ83xITELLYRFl9p5m06KXvaFCaeYveKs2i+E54U23eXGyodj06p10BeEDp/g7OO6ttUW9pSJGlLMeezhLzstLkt8wzdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsWqlGvOTHmJEeqLDeYMyMDRlSEqzlWIE47fTC7la8g=;
 b=m4km40ztMjRh7B0i+ZzeeF/R29bjj2GrSIShK7xl5O5iQAaBDrGdXYIFq3aglqs/qK5t3spJqc9aL+pXtByJzFtmFeYvZhgubqhQYfp1e5t2iPysswsTvp/HmBS8NSaL0M9l6PRLk3pHFBk3fczhIyNAUkCImfQQ2gIndMyHzOSAdy+Pvz2gvI40HLYhY0Pj8vv5wCmLUmT/EkKLdCYwn7b1j5d0XhdtUBPKY123jbIE2MiPb0be5alo8Vjz9dj020jCXlYOFOgp8G54j69SgsQ1bq70NNxcOBr2jBi3BTUUf40XrBOjJKmejYzo7/zwG/dWLZ0bzjv3PyNyNHU5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsWqlGvOTHmJEeqLDeYMyMDRlSEqzlWIE47fTC7la8g=;
 b=doQldKWCy9DGB/S6JVsrVvmXX9pTdHvb7Nwgv/NOZ9irwZfmE1KeFRUZSJvBJJzYwVyKcl7zgwC4HAfQvlZsgx+LiogIUSDo3pcrQeGAjW1XAHDwqfLSzogArbBrgc12aGLkVT39DCYRWytW90QUABoVN5pbsDOWfMvD9cBnfGI=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by TYZPR03MB7289.apcprd03.prod.outlook.com (2603:1096:400:41f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 09:29:17 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::7a62:8e4a:b62a:3c13]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::7a62:8e4a:b62a:3c13%5]) with mapi id 15.20.9275.013; Tue, 4 Nov 2025
 09:29:17 +0000
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
Subject: Re: [PATCH v6 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Topic: [PATCH v6 1/1] drm/mediatek: Adjust bandwidth limit for DP
Thread-Index: AQHcE10aYjRcK7oUAECwQJj9ycuBWrR996KAgGS8mwA=
Date: Tue, 4 Nov 2025 09:29:17 +0000
Message-ID: <155234efaf55f5e481ab97f48dad321037a4add8.camel@mediatek.com>
References: <20250822120506.15486-1-liankun.yang@mediatek.com>
	 <e6337c08e2c40653b4a6542f1dd9fc350036b8c5.camel@mediatek.com>
In-Reply-To: <e6337c08e2c40653b4a6542f1dd9fc350036b8c5.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|TYZPR03MB7289:EE_
x-ms-office365-filtering-correlation-id: 01288404-8ee8-4811-db11-08de1b84a09a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info: =?utf-8?B?NU1YTm81QVY4YUhZSitHbDYrVzh4WjNHS2dySDFGRDJwZU12Y2xxMlgrOG5S?=
 =?utf-8?B?UGI3RjRQZzhTUG5RZEtzSVRQb1gyWVNWZE8rUW1YK2xaUGpualNCeEJVRDhD?=
 =?utf-8?B?Q2xneTVURHIxTkhaRDBXWDVTZUtWUUxZNVlja2N4bUJ1YWtXR2tLU3NFRFJz?=
 =?utf-8?B?bE1aanRaTFV1dDFhaFJKL2JKQ24zSisvK2dickFmeUdEdWFnaEVXeTJqZUs3?=
 =?utf-8?B?L3FIRlBjRDJEOE9NYlJaemVQZmZ0bmJiTnFFYTFhMTliVm4vSXlJekVVMEc5?=
 =?utf-8?B?emp3MGYwdUxkcjR1cHM4RGMvQ0ErZ1N3bWw3MXdHejlManB5c2t3cVpnVzJm?=
 =?utf-8?B?QVZ2Y3RRdDRYbm1hTnZsUzUzYnUzckNPUklmTGhINjdhYkFBR1ZuUFJOOG02?=
 =?utf-8?B?SVkzQXJxQUFybmZvcTJqRkpHYXhnWnllYjB0WmNlTVpCRVFzcnlnS1dIZnJY?=
 =?utf-8?B?L0JaalE0RUZ6cXJhZ3p6RCtTVVRtazJYUFF2RnFPOHFzRTBCNThsU0V3VGVP?=
 =?utf-8?B?bVNmbFBpZHU0WnMyR3IwczlNbFdlQ3o0QjZHbTJxSmorZk1objN2anBUN2pl?=
 =?utf-8?B?YlFUek1YNnVSbW5NQzZWbkZ4TnoveXY2NUlMZkI0UVF3RS95b0xGb0Y5cDFB?=
 =?utf-8?B?ekthVG0wSEhqZldYYUpDbzkycGhkdTc3ckxZYTBvNnVEUVJFS1p0NUdxM1Ft?=
 =?utf-8?B?bFJVZ1lsNmJRM1lvV1dGR294cWl4MHBnUzJrT3BiRDhZYUhFVDZpbDMwSFND?=
 =?utf-8?B?eDlGVFZ3MExlTDlDK2Q3aVY4YmUyeHBmT05VYklRMytaM0lSVTBXaEpoQ1ln?=
 =?utf-8?B?bDN2MmdhSlF6V2liaUNZK0psZytXRFl1UjZDV2M0WG45Y0UwWVJlTDdhSVo2?=
 =?utf-8?B?MEUzZ2J5RjhGV2hjbmIyYVpDWGc3VTFQWkZuVWliajMrckdyZTNBVWZMMFFY?=
 =?utf-8?B?SkJWcUJrbHMzamJ6VTM1aU1ZeHV1dGl4ZUdaT0JoVXdsVGhsdGVQckRDYVdS?=
 =?utf-8?B?aTViNFVLWVlpcTIva2tPclljZ2dxNEhpeEpSSk55RnZtaFNzOVYyS2tVSWtI?=
 =?utf-8?B?WVhoYUtGUnMzWWcwYW1FODI5Q1R0SkF1ZSsxTWtESGRtKzNZVTViZktLbys5?=
 =?utf-8?B?WWUxTUx6b3VZTytUYUpMc1VZeGJvc01KUk9YTGtwc01tcE5PNEFLckJSZlk2?=
 =?utf-8?B?YVJ0UzF1S2hZdERXbWsrWldHQVJIaVhyb1YxbEI0N1hWd3V4SndvTytQcW1W?=
 =?utf-8?B?am9MTmlrMnpnRzlKdHNjcDl2Mmg4b3lxYkoxTHRBSGlJZW1USE9hcjNOcjZz?=
 =?utf-8?B?RGpSeVlzc1VIUDIvRUMxT0FPbmthYkx6bzhOcEJzTXd2R3IzbTR5OTBxTGNQ?=
 =?utf-8?B?SVd4Y0xMdENMY2k0UVhNczYrRzg2U2xEaTJJbGNaT1QrOW1RV1hCYmRSWEsw?=
 =?utf-8?B?bGlqR2xDV1lFbFhUQjJKRnI5MjJRb0FIUGpjQklNMTBYSGNqQytWR0JNOFM2?=
 =?utf-8?B?Y1pmZ2VrNE1OYWZNVFFCMlBxaHRSbW5GNEkyREZHQ3Y1cm91NnRQRVJQU0c3?=
 =?utf-8?B?SHk1aWZqbzNlT1N1MExXSnFFN1Jrb2cwUmk1YVpLaG5INnpwcExsaUU1eThO?=
 =?utf-8?B?VHhucG5LemJYR1FzVityUjNwYkVGejBxVElQRi9EaUZzRWNTM2lwR3BKbVR6?=
 =?utf-8?B?bmx5K1JzNU9VV3ZUdVFFZlRvS2hZTFN2SzlHVHdpNUtpVXZscGxpejFXYzVp?=
 =?utf-8?B?b0J5UmdYZ3ZFeFVPeHQyVGpOeHZtWHViUmI0bUlENU9WWFF1aHd5UEFERVpk?=
 =?utf-8?B?OGZUS2JTc05HWGJZdWoyd3JyQTFScVlkZEZubkFGZUdzcjhpTExleU5CS2oz?=
 =?utf-8?B?MnI5WEF0cVhrOUl6bDdBaWlSRGtzZkwxeHdQbE9kY3ladEhsMW0wZ0ZlM1lF?=
 =?utf-8?B?K05YQzBiTzdjR0RDd2hQV3owZUx0eHVuYmwxNEk4M1M1Q3MwMHN2Zys3Q05D?=
 =?utf-8?B?ZTViK2FwT0JQTFdzTWIyWDR6aVZGSjZmNE1DYVYzeGdSK1o2UkNrci9ETmI1?=
 =?utf-8?B?OUhyRG12QnliaGlLMTNqNmN2MzB5Q01ocGtUUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWlmT1dueStVT2lzY1FibkFCS0xiOEFzVWpUWkI0ZXFPZG9IaGtPZ0JWcXhD?=
 =?utf-8?B?Z05JbGhCd05Gem96RndWTzNCTUpBMzJHWFY3Nyt6aGgyM3ZuQVpPVlVmYzdl?=
 =?utf-8?B?Z2NBYmU5Ui8zQ2pCeGxNeFFNdTR3YU95R1RJRkx4UFBMQncvR2F1WEtNa3VS?=
 =?utf-8?B?eU5TSFF3VnVkdTFGekFsUFNXeG1haTdVcUlzRkZMRG41K1JUQ3BDb0xwU09i?=
 =?utf-8?B?QW9iQnR4VllxZWlOZ29yOU1UVW1pUHJOb0ZaRGdXNTZkbXFsQjBFY3dvbWtB?=
 =?utf-8?B?QWtEZG1SZFNjS1Q1bWZucVdqOUtoK1BRS2JFaFhpZkhJem1KWjVjbFF5a1ps?=
 =?utf-8?B?QjhMSVFRMXMrOVRBSFdBU0ZmTGNSQzFySm9nZW9Hd01uUXJRamU0VFMxUjB2?=
 =?utf-8?B?TjNHZlNzYWdSbHFXMmNMRUV0cTlvbUlBRml2T2VIN0hkQXZYaHZIWjhyY1Iw?=
 =?utf-8?B?WlgyY0R2L2grWks1SjQ1QkhWRThXQWduN2VkODl4Rm0vL0g0SXNqODZLcHZP?=
 =?utf-8?B?Q3pXYzFnZFRpbExWQjZveDFLcFl5KzNzVHJQSXdpY2cxaTIvc2VvN1huVjNh?=
 =?utf-8?B?UFNGL2pVU0dmeG5ta0VsNlJsUVpyaXVSRjhZZlQrb0hIQ1pCYUpvMWFCbmZR?=
 =?utf-8?B?aXJlem9XQ05BcWlkNVdyeFJnYldQRTQ1MmZZQ0JDWXFpbzJwYk1XTVZCRUp2?=
 =?utf-8?B?MWZENFpiUFd4SFpQbnQ3RzNDMUhLUnRtM3FBazZQU2F2Y1VYUEIwekZ0b3NS?=
 =?utf-8?B?T2RnQXNpNmhGMjdoVC9kQnJNb0VibEVTMkFhVDMwcVJlcUtNcENRUm5HMnE2?=
 =?utf-8?B?QnNpZ2dsZmt1elQ0ZXg0U1hVKzdFODBod1QwU3BPKzdtOUdjcUVEaVp0bVpX?=
 =?utf-8?B?cDFSRktrU3c3U2sycE82SkQramhBQmJwNXliOXpnRGIrQmt3YjVrZUExTDBl?=
 =?utf-8?B?SlNrM0IzVzFlVTNYd1owVzFKaFU0dnIweTlLNDgwSTNtYS9XUnNJek1zbTdV?=
 =?utf-8?B?QWhYVlFocVJ2bmxBSFpvZUVvbWM3UlhEZHJwU1loUnA3MlVvN3FSZ01nOC93?=
 =?utf-8?B?VGw3NzQ4MXBNL29LUGRDcVdjTEtoT01ROFFsNUZ4eEcvYUpUZ0k3K1o5c0VP?=
 =?utf-8?B?VmNhc2xPalIwZUlrSVFCYkxZQ0dkOStOU215STN1QzQrWW1qT1JJQ1VPWHBM?=
 =?utf-8?B?NEIzanh0cU9TTmZ6REhBUk1VZitEU1RsQ1JDdXVTenRJT1JrK3FoemJ1VERI?=
 =?utf-8?B?SzVnRExSMi9McVdhSXRGbFBGekFleDZYK3BFNk9wdTE2UDZyNmdEaWVXY3ZY?=
 =?utf-8?B?Z3NDRUgwTUVxNFJyalQ3akhFdVJhT0RKbWdDTlQwMHNwNXVCcUlXUmNFVmIr?=
 =?utf-8?B?cHF2MGwrRzBmcjZ4K0U0L2p5WW5JWGozYzZPdW9VMTlDNllnYU1jcjFuNmow?=
 =?utf-8?B?c2VVZFNabXpzSE1NWlNOSE03cTJtTmQ3WUd1MWI1Qlo2SHg5T2hpTHF4REs1?=
 =?utf-8?B?cDhrSVNUcWFSaUNLTnY2RldnbmhkNmpWUFdFcTFtWld6a0ZGaHdmaXZpeW1o?=
 =?utf-8?B?dWF0Q3dJSzZ1VUxiSzNYRE9iRlpFSWFZeTVLTXlVRlFMZ0tQTHdhdGhncXVL?=
 =?utf-8?B?bTN0Mks4dU92dWdBa0pndXMxMW9RNkt3d1Nmem14b3JDQ091WEFUNlNIWUlF?=
 =?utf-8?B?cFhrQ0JUTDkxbDI3UmZpNWVYT0w3Tm1jZFg4VFd6aDlVbC9sWkpRZzVNaWtO?=
 =?utf-8?B?eDlodE52VllmbEpwdm4xU0Z6bnRVc3k5Vm8rRGE2WWQva1NkbHRBaEtyUWE5?=
 =?utf-8?B?N2V2dkFrVWRHY08veTZXL3Y0VEJHUzBwV2JMODA4TTMzcm9GWGg4NC94S3hN?=
 =?utf-8?B?NVVIWVd3dFV2VFZUQnZtMVdScVoxa003djd5L2lteDlRQjgxQjdQMC83M0Nr?=
 =?utf-8?B?U2RBY0Z3c25DbnFXWUZMc2dDOGtTUitnVGczZEF4a2Q3Q0VNU1QydlhnUkta?=
 =?utf-8?B?cnIxMzU0dEhGaHFHZGsvM0JlSUtWN29vOGhzbERrVG1La2M0R1lhOVd2MlZQ?=
 =?utf-8?B?NkMwWjd2aHN3UDVBeW9HbXh6emtJWEQ4WTRwTlhqOXAvNXB6UTRKc2RxbTBX?=
 =?utf-8?B?dG1jdVY2UHhHdzZyd0R3Wmp2dUZKM2RUdHpLYXl6V2c3Z24zOFVRU2QwNG9J?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84ACA49577FA1340BDB0487657C8E572@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01288404-8ee8-4811-db11-08de1b84a09a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 09:29:17.7118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnY2u+mDVXAgvtP6UdNBpMnE1Q5Rlqv/7hJqZXIZ/1CVDVWvgmx3R/cAEecgDBn1rRQd5eYOjJ6VLIQ6QJMO7RcjxLF2dMqzZmetaxsBgBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7289

T24gTW9uLCAyMDI1LTA5LTAxIGF0IDA3OjA4ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gRnJpLCAyMDI1LTA4LTIyIGF0IDIwOjA0ICswODAwLCBMaWFua3VuIFlhbmcgd3Jv
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
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaWFua3VuIFlhbmcgPGxpYW5rdW4ueWFuZ0BtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlIGluIFY2Og0KPiA+IC0gRml4ZWQgcG93ZXIgb24g
aW4gYXRvbWljIGVuYWJsZS4NCj4gPiAtIEZpeGVkIHBhcnNlIGNhcGFiaWxpdHkgZm9yIGVkcC4N
Cj4gPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91cyB0aHJlYWQ6DQo+ID4gDQpodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjUwNjMwMDgwODI0LjcxMDctMS1saWFua3VuLnlh
bmdAbWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWtTTHJZX2VoWHRJSjIxYV9sam5Y
N0VtRHREOTJuOFJmalc5SmVlNnFSZkt6Qzhla3BrdnZSY01vSlJJbzAzV2dRQW1fTDdSM3pLcnI1
a1MxRlVLTTZhZyQNCj4gPiAgDQo+ID4gDQo+ID4gQ2hhbmdlIGluIFY1Og0KPiA+IC0gRml4ZWQg
dGhlIGlzc3VlIHRoYXQgdGhlIDR0aCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCBjYXVzZWQgRFAgdG8N
Cj4gPiBoYXZlIG5vIHNjcmVlbi4NCj4gPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2aW91
cyB0aHJlYWQ6DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjUwNjI1MDk1
NDQ2LjMxNzI2LTEtbGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJi
dyFrU0xyWV9laFh0SUoyMWFfbGpuWDdFbUR0RDkybjhSZmpXOUplZTZxUmZLekM4ZWtwa3Z2UmNN
b0pSSW8wM1dnUUFtX0w3UjN6S3JyNWtTMU54LWZzNU0kDQo+ID4gIA0KPiA+IA0KPiA+IENoYW5n
ZSBpbiBWNDoNCj4gPiAtIFRlc3RlZCB0aGUgaW50ZXJuYWwgZURQIGRpc3BsYXkgb24gTVQ4MTk1
IFRvbWF0byBhbmQgaXQgaXMgZmluZS4NCj4gPiBQZXIgc3VnZ2VzdGlvbiBmcm9tIHRoZSBwcmV2
aW91cyB0aHJlYWQ6DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjUwMzE4
MTQwMjM2LjEzNjUwLTItbGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcw
QVJidyFrU0xyWV9laFh0SUoyMWFfbGpuWDdFbUR0RDkybjhSZmpXOUplZTZxUmZLekM4ZWtwa3Z2
UmNNb0pSSW8wM1dnUUFtX0w3UjN6S3JyNWtTMW9zUDFTRzAkDQo+ID4gIA0KPiA+IA0KPiA+IENo
YW5nZSBpbiBWMzoNCj4gPiAtIFJlbW92ZSAnbXRrX2RwLT5lbmFibGVkID0gZmFsc2UiIGluIGF0
b21pYyBkaXNhYmxlLg0KPiA+IC0gUmVtb3ZlICdtdGtfZHAtPmVuYWJsZWQgPSB0cnVlIiBpbiBh
dG9taWMgZW5hYmxlLg0KPiA+IFBlciBzdWdnZXN0aW9uIGZyb20gdGhlIHByZXZpb3VzIHRocmVh
ZDoNCj4gPiANCmh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDEwMjUwODMwMzYuODgy
OS00LWxpYW5rdW4ueWFuZ0BtZWRpYXRlay5jb20vX187ISFDVFJOS0E5d01nMEFSYncha1NMcllf
ZWhYdElKMjFhX2xqblg3RW1EdEQ5Mm44UmZqVzlKZWU2cVJmS3pDOGVrcGt2dlJjTW9KUklvMDNX
Z1FBbV9MN1IzektycjVrUzFNalE1R2lVJA0KPiA+ICANCj4gPiANCj4gPiBDaGFuZ2UgaW4gVjI6
DQo+ID4gLSBBZGp1c3QgRFAgdHJhaW5pbmcgdGltaW5nLg0KPiA+IC0gQWRqdXN0IHBhcnNlIGNh
cGFiaWxpdGllcyB0aW1pbmcuDQo+ID4gLSBBZGQgcG93ZXIgb24vb2ZmIGZvciBjb25uZWN0L2Rp
c2Nvbm5lY3QuDQo+ID4gUGVyIHN1Z2dlc3Rpb24gZnJvbSB0aGUgcHJldmlvdXMgdGhyZWFkOg0K
PiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI0MDMxNTAxNTIzMy4yMDIzLTEt
bGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFrU0xyWV9laFh0
SUoyMWFfbGpuWDdFbUR0RDkybjhSZmpXOUplZTZxUmZLekM4ZWtwa3Z2UmNNb0pSSW8wM1dnUUFt
X0w3UjN6S3JyNWtTMWlKSHBNelkkDQo+ID4gIA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4g
PiAtLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RwLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiA+IGluZGV4
IGJlZjZlZWIzMGQzZS4uMzg0NDk2ZTQ5MTE4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHAuYw0KPiA+IEBAIC0xOTc2LDYgKzE5NzYsNyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QN
Cj4gPiBtdGtfZHBfaHBkX2V2ZW50X3RocmVhZChpbnQgaHBkLCB2b2lkICpkZXYpDQo+ID4gIAlz
dHJ1Y3QgbXRrX2RwICptdGtfZHAgPSBkZXY7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0K
PiA+ICAJdTMyIHN0YXR1czsNCj4gPiArCWludCByZXQ7DQo+ID4gIA0KPiA+ICAJaWYgKG10a19k
cC0+bmVlZF9kZWJvdW5jZSAmJiBtdGtfZHAtDQo+ID4gPnRyYWluX2luZm8uY2FibGVfcGx1Z2dl
ZF9pbikNCj4gPiAgCQltc2xlZXAoMTAwKTsNCj4gPiBAQCAtMTk5NCw5ICsxOTk1LDI4IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdA0KPiA+IG10a19kcF9ocGRfZXZlbnRfdGhyZWFkKGludCBocGQsIHZv
aWQgKmRldikNCj4gPiAgCQkJbWVtc2V0KCZtdGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZywgMCwN
Cj4gPiAgCQkJICAgICAgIHNpemVvZihtdGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZykpOw0KPiA+
ICANCj4gPiArCQkJbXRrX2RwLT5lbmFibGVkID0gZmFsc2U7DQo+IA0KPiBJJ20gbm90IHN1cmUg
ZURQIHdvdWxkIGhhdmUgaG90LXBsdWcgZXZlbnQgb3Igbm90Lg0KPiBJZiBlRFAgYWxzbyBoYXMg
aG90LXBsdWcgZXZlbnQgKG9uY2UpLCBhZGQgZG8gdGhpcyBvbmx5IGZvciBEUA0KPiANCj4gaWYg
KG10a19kcC0+ZGF0YS0+YnJpZGdlX3R5cGUgIT0gRFJNX01PREVfQ09OTkVDVE9SX2VEUCkgew0K
PiAJLyogQWN0aW9uIG9ubHkgZm9yIERQICovDQo+IH0NCj4gDQo+ID4gKwkJCS8qIHBvd2VyIG9m
ZiBhdXggKi8NCj4gPiArCQkJbXRrX2RwX3VwZGF0ZV9iaXRzKG10a19kcCwNCj4gPiBNVEtfRFBf
VE9QX1BXUl9TVEFURSwNCj4gPiArCQkJCQkgICBEUF9QV1JfU1RBVEVfQkFOREdBUF9UUExMLA0K
PiA+ICsJCQkJCSAgIERQX1BXUl9TVEFURV9NQVNLKTsNCj4gDQo+IFdoeSBub3QgdXNlIG10a19k
cF9hdXhfcGFuZWxfcG93ZXJvbihtdGtfZHAsIGZhbHNlKT8NCj4gV2hlbiBwbHVnIGluLCB5b3Ug
Y2FsbCBtdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKSwNCj4gSSB3b3VsZCBs
aWtlIGl0IHRvIGJlIHN5bW1ldHJpYy4NCj4gSWYgbm90IHN5bW1ldHJpYywgYWRkIGNvbW1lbnQg
dG8gZGVzY3JpYmUgd2h5IGl0J3Mgbm90IHN5bW1ldHJpYy4NCj4gDQoNCkhpIENLLA0KDQpUaGUg
YG10a19kcF9hdXhfcGFuZWxfcG93ZXJvbmAgZnVuY3Rpb24gZmFpbHMgdG8gYWxpZ24uDQpXaXRo
aW4gdGhlIGBtdGtfZHBfaHBkX2V2ZW50X3RocmVhZGAsIGlmIERQIGlzIGRpc2Nvbm5lY3RlZCwN
CnRoZSBgbXRrX2RwX2F1eF9wYW5lbF9wb3dlcm9uYCBmdW5jdGlvbiB3aWxsIHdyaXRlIGZyb20g
YGF1eGAgdG8NCmBEUFJYYCxjYXVzaW5nIGEgZmFpbHVyZS4NCg0KVGhlcmVmb3JlLCBpdCdzIG5v
dCBzeW1tZXRyaWMuDQoNClJlZ2FyZHMsDQpMaWFua3VuIFlhbmcNCg0KPiA+ICsNCj4gPiAgCQkJ
bXRrX2RwLT5uZWVkX2RlYm91bmNlID0gZmFsc2U7DQo+ID4gIAkJCW1vZF90aW1lcigmbXRrX2Rw
LT5kZWJvdW5jZV90aW1lciwNCj4gPiAgCQkJCSAgamlmZmllcyArIG1zZWNzX3RvX2ppZmZpZXMo
MTAwKSAtIDEpOw0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJCW10a19kcF9hdXhfcGFuZWxfcG93
ZXJvbihtdGtfZHAsIHRydWUpOw0KPiA+ICsNCj4gPiArCQkJcmV0ID0gbXRrX2RwX3BhcnNlX2Nh
cGFiaWxpdGllcyhtdGtfZHApOw0KPiA+ICsJCQlpZiAocmV0KQ0KPiA+ICsJCQkJZHJtX2Vyciht
dGtfZHAtPmRybV9kZXYsICJDYW4ndCBwYXJzZQ0KPiA+IGNhcGFiaWxpdGllc1xuIik7DQo+ID4g
Kw0KPiA+ICsJCQkvKiBUcmFpbmluZyAqLw0KPiA+ICsJCQlyZXQgPSBtdGtfZHBfdHJhaW5pbmco
bXRrX2RwKTsNCj4gPiArCQkJaWYgKHJldCkNCj4gPiArCQkJCWRybV9lcnIobXRrX2RwLT5kcm1f
ZGV2LCAiVHJhaW5pbmcNCj4gPiBmYWlsZWQsICVkXG4iLCByZXQpOw0KPiA+ICsNCj4gPiArCQkJ
bXRrX2RwLT5lbmFibGVkID0gdHJ1ZTsNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+IEBA
IC0yMTY3LDcgKzIxODcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9lZGlkDQo+ID4gKm10
a19kcF9lZGlkX3JlYWQoc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gPiAgCSAqIFBhcnNl
IGNhcGFiaWxpdHkgaGVyZSB0byBsZXQgYXRvbWljX2dldF9pbnB1dF9idXNfZm10cyBhbmQNCj4g
PiAgCSAqIG1vZGVfdmFsaWQgdXNlIHRoZSBjYXBhYmlsaXR5IHRvIGNhbGN1bGF0ZSBzaW5rIGJp
dHJhdGVzLg0KPiA+ICAJICovDQo+ID4gLQlpZiAobXRrX2RwX3BhcnNlX2NhcGFiaWxpdGllcyht
dGtfZHApKSB7DQo+ID4gKwlpZiAobXRrX2RwLT5icmlkZ2UudHlwZSA9PSBEUk1fTU9ERV9DT05O
RUNUT1JfZURQICYmDQo+ID4gKwkgICAgbXRrX2RwX3BhcnNlX2NhcGFiaWxpdGllcyhtdGtfZHAp
KSB7DQo+IA0KPiBJIHRoaW5rIHRoaXMgbW9kaWZpY2F0aW9uIGlzIHJlbGF0ZWQgdG8gd2hhdCB5
b3Ugc2F5Og0KPiANCj4gIklmIHdlJ3JlIGVEUCBhbmQgY2FwYWJpbGl0aWVzIHdlcmUgYWxyZWFk
eSBwYXJzZWQgd2UgY2FuIHNraXANCj4gcmVhZGluZyBhZ2FpbiBiZWNhdXNlIGVEUCBwYW5lbHMg
YXJlbid0IGhvdHBsdWdnYWJsZSBoZW5jZSB0aGUNCj4gY2FwcyBhbmQgdHJhaW5pbmcgaW5mb3Jt
YXRpb24gd29uJ3QgZXZlciBjaGFuZ2UgaW4gYSBib290IGxpZmUiDQo+IA0KPiBJIHRoaW5rIHRo
aXMgbW9kaWZpY2F0aW9uIGlzIG5vdCByZWxhdGVkIHRvIHRoZSB0aXRsZS4NCj4gVGhpcyBpcyB0
byBpbXByb3ZlIGVEUCBmdW5jdGlvbiBub3QgRFAuDQo+IFNvIHNlcGFyYXRlIHRoaXMgdG8gYW5v
dGhlciBwYXRjaC4NCg0KPiA+ICAJCWRybV9lcnIobXRrX2RwLT5kcm1fZGV2LCAiQ2FuJ3QgcGFy
c2UgY2FwYWJpbGl0aWVzXG4iKTsNCj4gPiAgCQlkcm1fZWRpZF9mcmVlKGRybV9lZGlkKTsNCj4g
PiAgCQlkcm1fZWRpZCA9IE5VTEw7DQo+ID4gQEAgLTIzNTUsNiArMjM3Niw3IEBAIHN0YXRpYyB2
b2lkDQo+ID4gbXRrX2RwX2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpi
cmlkZ2UsDQo+ID4gIAkJCQkJc3RydWN0IGRybV9hdG9taWNfc3RhdGUgKnN0YXRlKQ0KPiA+ICB7
DQo+ID4gIAlzdHJ1Y3QgbXRrX2RwICptdGtfZHAgPSBtdGtfZHBfZnJvbV9icmlkZ2UoYnJpZGdl
KTsNCj4gPiArCWJvb2wgZW5hYmxlZCA9IG10a19kcC0+ZW5hYmxlZDsNCj4gPiAgCWludCByZXQ7
DQo+ID4gIA0KPiA+ICAJbXRrX2RwLT5jb25uID0gZHJtX2F0b21pY19nZXRfbmV3X2Nvbm5lY3Rv
cl9mb3JfZW5jb2RlcihzdGF0ZSwNCj4gPiBAQCAtMjM2NSwxMyArMjM4NywxNiBAQCBzdGF0aWMg
dm9pZA0KPiA+IG10a19kcF9icmlkZ2VfYXRvbWljX2VuYWJsZShzdHJ1Y3QgZHJtX2JyaWRnZSAq
YnJpZGdlLA0KPiA+ICAJCXJldHVybjsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQltdGtfZHBfYXV4
X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gPiArCWlmICghZW5hYmxlZCkNCj4gPiAr
CQltdGtfZHBfYXV4X3BhbmVsX3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gPiAgDQo+ID4gLQkv
KiBUcmFpbmluZyAqLw0KPiA+IC0JcmV0ID0gbXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+ID4g
LQlpZiAocmV0KSB7DQo+ID4gLQkJZHJtX2VycihtdGtfZHAtPmRybV9kZXYsICJUcmFpbmluZyBm
YWlsZWQsICVkXG4iLCByZXQpOw0KPiA+IC0JCWdvdG8gcG93ZXJfb2ZmX2F1eDsNCj4gPiArCWlm
IChtdGtfZHAtPmRhdGEtPmJyaWRnZV90eXBlID09IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsN
Cj4gPiArCQkvKiBUcmFpbmluZyAqLw0KPiA+ICsJCXJldCA9IG10a19kcF90cmFpbmluZyhtdGtf
ZHApOw0KPiA+ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZHJtX2VycihtdGtfZHAtPmRybV9kZXYs
ICJUcmFpbmluZyBmYWlsZWQsDQo+ID4gJWRcbiIsIHJldCk7DQo+ID4gKwkJCWdvdG8gcG93ZXJf
b2ZmX2F1eDsNCj4gPiArCQl9DQo+ID4gIAl9DQo+IA0KPiBpZiAobXRrX2RwLT5kYXRhLT5icmlk
Z2VfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKSB7DQo+IAltdGtfZHBfYXV4X3BhbmVs
X3Bvd2Vyb24obXRrX2RwLCB0cnVlKTsNCj4gDQo+IAkvKiBUcmFpbmluZyAqLw0KPiAJcmV0ID0g
bXRrX2RwX3RyYWluaW5nKG10a19kcCk7DQo+IAlpZiAocmV0KSB7DQo+IAkJZHJtX2VycihtdGtf
ZHAtPmRybV9kZXYsICJUcmFpbmluZyBmYWlsZWQsICVkXG4iLCByZXQpOw0KPiAJCWdvdG8gcG93
ZXJfb2ZmX2F1eDsNCj4gCX0NCj4gfQ0KPiANCj4gPiAgDQo+ID4gIAlyZXQgPSBtdGtfZHBfdmlk
ZW9fY29uZmlnKG10a19kcCk7DQo+ID4gQEAgLTIzOTEsNyArMjQxNiw2IEBAIHN0YXRpYyB2b2lk
DQo+ID4gbXRrX2RwX2JyaWRnZV9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fYnJpZGdlICpicmlk
Z2UsDQo+ID4gIAkJICAgICAgIHNpemVvZihtdGtfZHAtPmluZm8uYXVkaW9fY3VyX2NmZykpOw0K
PiA+ICAJfQ0KPiA+ICANCj4gPiAtCW10a19kcC0+ZW5hYmxlZCA9IHRydWU7DQo+IA0KPiBpZiAo
bXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZSA9PSBEUk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiAJ
bXRrX2RwLT5lbmFibGVkID0gdHJ1ZTsNCj4gDQo+ID4gIAltdGtfZHBfdXBkYXRlX3BsdWdnZWRf
c3RhdHVzKG10a19kcCk7DQo+ID4gIA0KPiA+ICAJcmV0dXJuOw0KPiA+IEBAIC0yNDA2LDcgKzI0
MzAsNiBAQCBzdGF0aWMgdm9pZA0KPiA+IG10a19kcF9icmlkZ2VfYXRvbWljX2Rpc2FibGUoc3Ry
dWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19kcCAqbXRr
X2RwID0gbXRrX2RwX2Zyb21fYnJpZGdlKGJyaWRnZSk7DQo+ID4gIA0KPiA+IC0JbXRrX2RwLT5l
bmFibGVkID0gZmFsc2U7DQo+IA0KPiBpZiAobXRrX2RwLT5kYXRhLT5icmlkZ2VfdHlwZSA9PSBE
Uk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiAJbXRrX2RwLT5lbmFibGVkID0gZmFsc2U7DQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiAgCW10a19kcF91cGRhdGVfcGx1Z2dlZF9zdGF0dXMo
bXRrX2RwKTsNCj4gPiAgCW10a19kcF92aWRlb19lbmFibGUobXRrX2RwLCBmYWxzZSk7DQo+ID4g
IAltdGtfZHBfYXVkaW9fbXV0ZShtdGtfZHAsIHRydWUpOw0KPiANCj4gDQo=

