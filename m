Return-Path: <linux-kernel+bounces-826756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C470B8F42F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1015B3B1833
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844F72F3C2F;
	Mon, 22 Sep 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G/rYBBhY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c8HVJ9tK"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C951917D6;
	Mon, 22 Sep 2025 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525477; cv=fail; b=jqkffcC6IOOBzlTJS2SsUu/G0PWrC6XtSVv93EdjWVuNCJSO0G7yGFfLd+OFwVf/+JfF6QWLJG84aH9AdTUWwqGqyRLOFZb/jaZllyIE0Pm/RFDw6LTex3P1wCDxEX/ldlCRcKSgj3d1s2HQL9frJRLvVpym9yUv/3wFqqGkF/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525477; c=relaxed/simple;
	bh=w0hc0QHiHck/2EpGQ+0HWzEvlzoWdV9ENuxTBUHRXbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQWZTHal80pAa2FGy5NJb9mZOB6PJrJzur5yALwRBMSJyLVFuWyM5Fsq+h/mdNyPoadd94WI1j1Osng3qbKx39tHCoachbQCGFPD0XpK+uyJn8C2O/aWkQB9q+9zKW5kIXuxh83gurLJYlxyyvvWPRgd4WO78FVlEaOzDyWtYIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G/rYBBhY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c8HVJ9tK; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36756fb8978411f0b33aeb1e7f16c2b6-20250922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=w0hc0QHiHck/2EpGQ+0HWzEvlzoWdV9ENuxTBUHRXbU=;
	b=G/rYBBhY1MWZoSNaQLITRmJG79mtL9dlADDmWRIgi7mWCB4XNkuoIytM3m+mYXtvH8foq0A5lCLVInvyxs5EijX2+jHMZSp9tz8NJEu3lpxXpb30HdmVYOGjMbwnrsMImoUz8s9cwyGbl1MEHKN4e4I16rGP1IhZOnwcNFhrUx0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:9224a5ec-efb4-4e70-89e6-d40bac415c53,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:8ba6b621-c299-443d-bb51-d77d2f000e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 36756fb8978411f0b33aeb1e7f16c2b6-20250922
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 870776789; Mon, 22 Sep 2025 15:17:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 22 Sep 2025 15:17:33 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 22 Sep 2025 15:17:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcC/RnQao2BWb4vnyW4wr+vqVlllxN2KWUU3GJKBzF+uM8PJ+9ejLjW8JdK2e4xDkR0FGEsTkDySmhPVCRIZzA3EhawgstyBy8olr/d2DZXx/eLdGNPb+GOqVE2A87SWy1c30dcI6Bkn2VThv+dHGFBxcPgx2c3HdJO1EG4D4cJ7D81VYg4VIZD8a1M6uGAJDsduE5TqpFK3VC2u+1DMBo9K9t6YB8d6LoWJpFl/j9Y9hsS1tIbR+Z7hvJn6ylsNbRS9yM1lh6tyZBHVJrQgJL/lntH8/eCmSZu5YlXO40w+qfC12ZdKhBDLvsMgntdZPhCOGuH+O3FNUyKxXfO0dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0hc0QHiHck/2EpGQ+0HWzEvlzoWdV9ENuxTBUHRXbU=;
 b=VZdvWT+lWrQRnF5NPRywYHeVV6PnwkkTQpZy29++J0FWY5lc25VjBHbBzR24OC9GRKRTHbkc1qvLhMwWvCMWFBVZYtd/sCMwxUaPOve2gfR+X+I+DAqnTBe6UJIkYgEo7uN4dl7bInp85MCADF3pAuDP7MufjiEGg93RPaQSpktS1YmRnCfB3XyFYnJ1CWaXH3MidA/SgeJ12z33BzPcqIelQ92KqaE3RCRPs3aJaMvX1NNFUHwer76SMGaawwimAFrwNte6gqoOVX28Hju1S3POfEB312ENzNg6Wwn3iC3q66sJBoB7/et6fDWwZNTMsar6HspJIVIAzLKwdoRCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0hc0QHiHck/2EpGQ+0HWzEvlzoWdV9ENuxTBUHRXbU=;
 b=c8HVJ9tKMvKk1w975X2RG3fursBdnc+tQG4xJmht/tL7Y2RM3DQRdmDUMHSZ9yzusiJ2TGbtteb9ePIWU52ypMbPCiCEXvwKnmHHCRLwAQjbkpLSyDJTli/pH0jQ/Wm2V+lH9288M42vvZUpgUOWylJTvCuQspCUqVuq9WwY5RA=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by KL1PR03MB7849.apcprd03.prod.outlook.com (2603:1096:820:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 07:17:27 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 07:17:27 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"nicolas.frattaroli@collabora.com" <nicolas.frattaroli@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgACRkwCAAIY+AIAAKeQAgAIpV4CAAcjDAA==
Date: Mon, 22 Sep 2025 07:17:27 +0000
Message-ID: <a9dd348fd7df95ebd5ad9cc58d57b588a18ccc9d.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <CAGXv+5F-L2+4PGixx7OG2+vp2yXc_2885yMzqWtkQDwhxVAPxw@mail.gmail.com>
	 <CABb+yY3N2=01yKJon25_6_vmihj09H=T9pLwzdGPrqY5h=hRFQ@mail.gmail.com>
	 <5789241.GXAFRqVoOG@workhorse>
	 <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
In-Reply-To: <CABb+yY2Ay+KqviJvOQC8X8kfzJN6-fQT04A+TCJAkLnWx+XwZg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|KL1PR03MB7849:EE_
x-ms-office365-filtering-correlation-id: 8aa91e94-830a-40ae-b30f-08ddf9a815f0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U2FZaFFndDIrNjdpWWlxZWdCRUtOUUNyblA0MWJicTZ0MDN1alBEZWp1Wndy?=
 =?utf-8?B?dk50ajh3dm8xYWNoc0t1WENWbmNaS1YzeWtpRjJCQjV1bGNMM1ZWTWFSSmY5?=
 =?utf-8?B?VnRrUmtRSHoxMlpqak5GVno5cjE1a3NRUzhWYXBrREp3SEYvRzcwTm8zeC9X?=
 =?utf-8?B?cnFvZUJwVmM1MjBEUXA3SFZ2V3NlNTdBZWk1dWN1cnZZUzVlUDlWTm5MVG82?=
 =?utf-8?B?TnNhM3F4NzN1SGZrY1ZzdFZPSk8yOFVlLzdJUTU4QmswellJVzNTNCtIZFNp?=
 =?utf-8?B?dkdEdlBsUkNiVmt2RjV5Y2d1Q3BNSXpMR1Y4Sm5Dc2hBei9LM21Zbnd3cEFr?=
 =?utf-8?B?Rm9EUlhyN1Z6d1AxYlRVTUhWbVN4azdBS3lvVlhmSHVsczF2bTV4L0RLVmd4?=
 =?utf-8?B?QW5raTYzazhSWTVlaWV6N0E5MWVyMDJGQjZONk43KzJ5WVRvYVV6ZVd2dVM5?=
 =?utf-8?B?Sk5EUkhkWlkra2lhclkvQ1g1NnZGcGdZWjV0S2NMY0poWGNVdVFwazVXU29F?=
 =?utf-8?B?RXRDQ0F0VzVodm5YSnVySFNVZmFXdU9zZE9DSUZZNjltUTZINHgwTXVhejRw?=
 =?utf-8?B?dEcyVkU2bjJXRHJNU2tGSlVmUFFMd2MvakZUd1RUKzFIRm56ZWI4RWRUMGpQ?=
 =?utf-8?B?V2VaYkZtL3FZWkM0OU1jMUpyQVZyNUFFV2diTWZqOUlkYTVkYnRIMklFUGRI?=
 =?utf-8?B?T3VyclY3QWpPTFJUTEx5MlNSbDlwWmU5MUtwQ3ZXSHpUaGhVU0I4VFdaQm5o?=
 =?utf-8?B?cGMvUkdOZmtTZkpaY1pkVTdrV2tNMkNlb2IwQzVNNkVuVFR2dWlrdGxCK0VD?=
 =?utf-8?B?cHhQR1RwUzQ4QjFhaWk1YkluNXJvSTY1RlduQjZkRVRka2l3RWFvRHJqMjYr?=
 =?utf-8?B?WTAvODVvTWZleGFxY1pJa0JvSkFkL3ljdmpDZCtTaFBlSEtQaGpHOG8rN1or?=
 =?utf-8?B?VGFTWVF0OFJTRUp6MGsydVlUclZnNnJRV2tBcXZkTHdkOHRZNC9PNEg5VWpw?=
 =?utf-8?B?eDRKZHJ1V243WXBPOGE2WTdBVUlLQS9oWGFWTVNnN09sSGU2Z2RJMWdzUEsx?=
 =?utf-8?B?Yytzd2JDckQ3RXQ0dmNSR01KaWJmWitFR0RxMy9LS3RQNTVJRnZCUHgvaGta?=
 =?utf-8?B?QXNiSkthM2JlSitkZFg4aURtU0ZPaEd6QmgwaVJZQlJkbk0wQjBlZnJSeW5G?=
 =?utf-8?B?M1lWYy9mM1hvTzdhT3RyNytpTForU3ZtWVpuZGl2Z1pOTnExUmh5WVphaXgw?=
 =?utf-8?B?TjU2YTNTWWVGY2E0bWV5TlNNeTNZYmVTUUgzY3ZBUG93TjFKUllzSDVqcHpl?=
 =?utf-8?B?RkRTRERvQzRJb05lV2p1YksycGZsc3BtUDBFQnpxY01rQ1RXakR4UjE1YW9h?=
 =?utf-8?B?YVpDTSsrc1NQTGRRdkRpNTRXWG5kNGVIZm5IS0llbFZrZktuYkpvczlsMzJM?=
 =?utf-8?B?bEkwcytSQldFcm5MUzVGMW9JbGJlOCsvamNibzJodThSc3cvNG9OQWl1NytY?=
 =?utf-8?B?bUhQbXdIZ0Z5OWFMSCtiNlFyOEZpMjBSeGxMYmdhOUpZZ2doL3FNcWZCREhC?=
 =?utf-8?B?QTVUUlpJb2ZZcG1UNFRld3pTR2V4QU51MzI3c2RxNGgvNGJzT1NQR0Uwc1Ez?=
 =?utf-8?B?RmVjT2tzRzJzdDhwVExPRnhkc2RWRldoTENlTmprUEtQZUJmelUzbUhrb2JI?=
 =?utf-8?B?T2o3UHBqUGhFYmF0aXY1WUR0U01IdlpKNzJyUkFBeURMb0RvazRhQUpGT1B5?=
 =?utf-8?B?MjhIbU5Jb1lhbHRaQzF1VTFqeFNRR3QwaElscjJMa0NRQVhDcFN6dkdNTlpW?=
 =?utf-8?B?MnJRZm9sT0VZaE5PSWtnQTZYOEJHaVZISVBzb2FsYnBoRlBEVnlIVXlWZkdx?=
 =?utf-8?B?aGErVlFMVkw4VzBCa3Vjb2lNRTFNU1M4ZFlwY1FNT0dLaStuR25OWU1ncHNW?=
 =?utf-8?B?SUswT3R3VlVWSXlrbVlHdTFiazFHQThSNGZxR2daNnJ4RjYwV0hGZ2JxWlNL?=
 =?utf-8?B?RmRWeXNLMkVBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW9acmI1NlRYSUdNL2lKdEtJUWRYUmVXUWpkTEJFNHF3K1A2Y00yNFZzeVlM?=
 =?utf-8?B?WEtjMGc2OGdsRWFKV1g1UERBUUtSVEFqdU9WZWc3WmY3RVJneDdobGpBR3lV?=
 =?utf-8?B?eUNhN3dHNCtSU2JDemhkL0pVZHlvTXJVSG1sc09FT2NLaWQyTlU1SE85cjE5?=
 =?utf-8?B?bFhSS09leEdGZ3JLR1lqdUhCdFltZXZ4dTdMVjNNMzZ4Z0pvU0lWb0pmNS8r?=
 =?utf-8?B?aU9SdlczWGo1SW9waGtLUzllN05hRDh6LzFtMHl6VVdtOWZGUVViNHd0bTla?=
 =?utf-8?B?WW1TQlp4SnNSbi9iaFF2NGgrcWRvQ1o3ZS9xblhxM2ZUMFFiRzNVdlljeU1p?=
 =?utf-8?B?a25YK3lCbTZOOG95eGc4RmVUaEFPUmg2QzhmaGJ3NXN6Ynpjb05MMmpEbnho?=
 =?utf-8?B?Z3c2OUg0OTc5YXFuaXJZcjJnZi9kRERTRU12YVltSGxBZ0c5aC84WnhpWkps?=
 =?utf-8?B?bTVHcW9DdURMd25IN2JRMmhTQUpUbXg5a2JvWWQ4ZmVQQ01IbkJMVlNKN2I2?=
 =?utf-8?B?QlNKZDVoZ0R6aE8rY1FaS3pYNk5qdGZDUEt0cHBWVTJ1UjMyRm5kTHdhQWth?=
 =?utf-8?B?YkZtL2tyYnhYNjNxa1NGQ2plMmhtdkYyTzRnYmtMbFFHN0c0Mm9vWlRsRGc2?=
 =?utf-8?B?eS92dFNJQjYveVhuLzVrRWN1Snd0czZuTHRnS1IrOFdubE0wSjY3TDFRaTdh?=
 =?utf-8?B?NUkrRGpFVGx3czRYRFlrUnBySnBrOWV2eXNod1paSHhyY3NNdGRzeUQwbWxV?=
 =?utf-8?B?dHkrMk1OVWlnWVJnTU05bkNnclF6a3dKd0FZdTJCSU1GWjdDTUlualdvNWo0?=
 =?utf-8?B?NzlPRWlFc0Ewb1ZGc2VrcVh3dGhMeTBtMytiQ3h1WU8wamhwb1BQS2d0dGtz?=
 =?utf-8?B?LzJUYXQ0Mk1pY0JySUh5cnRxZlhGUGZ5VmJmUlpHOXE0VDFyMFdTUC81YXlW?=
 =?utf-8?B?aG1Rb2NUc3o1M3ZOWTlzYm42cUp0UXVGS09pczl6RTVtdWU0SG9zdTcrYVAw?=
 =?utf-8?B?cThqZVNhWDdVMjdZVzBZNkJTaUZsR0I3YkFxZVBERVV2YUZxWDBpQndnblZV?=
 =?utf-8?B?MlRGOEFvdTR6bkYxdG1mOHNlOHNPM1Jwaks4YzhJOGxRMzYzZlhMakVBWkZI?=
 =?utf-8?B?QWxmdVRyMWJmd1RuMVdnTFd1dXZySkZ0SXAwMDFQdTdsMmlVeVNlc2hJTDBm?=
 =?utf-8?B?L24zKzMvbm9tVjZPdlNTMytNVjl5TUFyRjVKeXBpcllYalp6TXd6SFVRWCtJ?=
 =?utf-8?B?NFpKUG1jSXZMV1IvaGlrTTZjc3ZYaWRiV0JUVEVPTVJFVXlnbVd6WFc5eEFq?=
 =?utf-8?B?NCtubVhNRm5OQnNCMzZHa0xtVmNBOVFrdnZNV2hja1Zmb3h4MUpPbHdHS29j?=
 =?utf-8?B?TTZEbE01WE4vbHYrb2IrSlJwU0tDSWZ5RGh3cHNUK2t3cmgwNWhwSnFESFZz?=
 =?utf-8?B?MCs2M3hpWm5HdnU0anlvRFR6QUFVREtHNEE3WE1seHZTQm1EUTJGNk9pa0hN?=
 =?utf-8?B?YnF2MnJlVkdxL3JpOHdac21mV2RhVVRXRm9zSnp4MFRBVjlrRmRVSnY5MDV3?=
 =?utf-8?B?UTUxVXpKdFhMMzRoeEZ6OWdaOFZGM3F0bVdISVJYR0tvU1N2eGg3T0NOanU4?=
 =?utf-8?B?TksvRXhWam1DY2ZPU3ZiYmNNR09KRjNsVXVQTVhsSnVVb3ZQTERodElLcFdJ?=
 =?utf-8?B?SmZvM3dKMkoxRUJDU0x5eG1qbGllUEdmWGlPcEFzTTNRd1V3WnFzSXFXTFpt?=
 =?utf-8?B?RnVqaWd0WHNIOE5laC81ejUwT1Vsd1R6d3d1cjcyZG9PVDdXM3lGRFJSSHVZ?=
 =?utf-8?B?cnkwTG9pVkIyZDI0akVDbVRQSy9DM0RzbnhKOUliMTVLeGVTTm1PeTNETzRL?=
 =?utf-8?B?elRPRkNPRVArOFhQNW8vMGhoMEtUY3pLNXVPNlBpNEViODVmSDhpaEtRbUNu?=
 =?utf-8?B?a1hOS0hqSFk3UXJXT3ROMVFhSEFIVzJxTDR3bTZjZ24vNGtpQ29XTWFLUnBQ?=
 =?utf-8?B?YzhpRWxnUkdQOHBNYVM2YUt2MUZ6ZEhMUW1NQllNTm03Mk1IazZ5WlV6M0dl?=
 =?utf-8?B?SHN0cWhTQ01zcGlwRlZ6T2E2VTNCV3ZuMThtTTJxTGFQbW5RK01PakxQUElD?=
 =?utf-8?B?cjhja3E1ajV2U3g2bjdacko4WmJsRGV6NlduWXZvUlBrcjdhRWVMTi82amdC?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7FFA589F25A07439381443F4D57A26C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa91e94-830a-40ae-b30f-08ddf9a815f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 07:17:27.4292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRiEMS5UzNInwTukKgoOmgZCw92mC1esZ8pbnI3BDKrsWnDdJq4I9rqtPfWGt9K2DBTba7bJN3eM0NOAdfoiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7849

T24gU2F0LCAyMDI1LTA5LTIwIGF0IDIzOjAyIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIEZyaSwgU2VwIDE5LCAyMDI1IGF0IDI6MDLigK9QTSBOaWNvbGFzIEZy
YXR0YXJvbGkNCj4gPG5pY29sYXMuZnJhdHRhcm9saUBjb2xsYWJvcmEuY29tPiB3cm90ZToNCj4g
PiANCj4gPiBPbiBGcmlkYXksIDE5IFNlcHRlbWJlciAyMDI1IDE4OjMyOjEyIENlbnRyYWwgRXVy
b3BlYW4gU3VtbWVyIFRpbWUNCj4gPiBKYXNzaSBCcmFyIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBT
ZXAgMTksIDIwMjUgYXQgMzozMeKAr0FNIENoZW4tWXUgVHNhaSA8d2Vuc3RAY2hyb21pdW0ub3Jn
Pg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBGcmksIFNlcCAxOSwgMjAyNSBh
dCA3OjUw4oCvQU0gSmFzc2kgQnJhciA8DQo+ID4gPiA+IGphc3Npc2luZ2hicmFyQGdtYWlsLmNv
bT4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gVGh1LCBBdWcgMjEsIDIwMjUgYXQg
OToxMuKAr1BNIEpqaWFuIFpob3UgPA0KPiA+ID4gPiA+IGpqaWFuLnpob3VAbWVkaWF0ZWsuY29t
PiB3cm90ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAuLi4uLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8
bGludXgvb2YuaD4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNl
Lmg+DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiA+ID4gPiA+ICsN
Cj4gPiA+ID4gPiA+ICtzdHJ1Y3QgbXRrX3ZjcF9tYm94X3ByaXYgew0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IE1heWJlICdtdGtfdmNwX21ib3gnIGlzIGEgbW9yZSBhcHByb3ByaWF0ZSBuYW1lID8N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+
ID4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gPiA+ID4gPiArICAgICAg
IHN0cnVjdCBtYm94X2NvbnRyb2xsZXIgbWJveDsNCj4gPiA+ID4gPiA+ICsgICAgICAgY29uc3Qg
c3RydWN0IG10a192Y3BfbWJveF9jZmcgKmNmZzsNCj4gPiA+ID4gPiA+ICsgICAgICAgc3RydWN0
IG10a19pcGlfaW5mbyBpcGlfcmVjdjsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBNYXliZSBhbHNv
IGhhdmUgInN0cnVjdCBtYm94X2NoYW4gY2hhblsxXTsgIiBzbyB0aGF0IHlvdQ0KPiA+ID4gPiA+
IGRvbid0IGhhdmUgdG8NCj4gPiA+ID4gPiBhbGxvY2F0ZSBvbmUgZHVyaW5nIHRoZSBwcm9iZS4N
Cj4gPiA+ID4gPiBBbHNvIGlmIHlvdSBoYXZlICAic3RydWN0IG1ib3hfY29udHJvbGxlciBtYm94
OyIgYXMgdGhlIGZpcnN0DQo+ID4gPiA+ID4gbWVtYmVyLA0KPiA+ID4gPiA+IHlvdSBjb3VsZCBz
aW1wbHkgdHlwZWNhc3QgdGhhdCB0byBnZXQgdGhpcyBzdHJ1Y3R1cmUuDQo+ID4gPiA+ID4gU29t
ZXRoaW5nIGxpa2UgInN0cnVjdCBtcGZzX21ib3giIGluIG1haWxib3gtbXBmcy5jDQo+ID4gPiA+
IA0KPiA+ID4gPiBJIHJlYWQgc29tZXdoZXJlIHRoYXQgdGhpcyB3YXkgb2Ygc3ViY2xhc3Npbmcg
aXMgbm90DQo+ID4gPiA+IHJlY29tbWVuZGVkLg0KPiA+ID4gPiBJbnN0ZWFkIHRoZSBiYXNlIGNs
YXNzIHNob3VsZCBleHBsaWNpdGx5IG5vdCBiZSB0aGUgZmlyc3QNCj4gPiA+ID4gbWVtYmVyLg0K
PiA+ID4gPiBBbmQgdGhlbiBjb250YWluZXJfb2YoKSBzaG91bGQgYmUgdXNlZC4NCj4gPiA+ID4g
DQo+ID4gPiA+IEkgZG9uJ3QgcmVtZW1iZXIgd2hlcmUgSSByZWFkIHRoaXMgdGhvdWdoLiBCdXQg
SSB0aGluayB0aGUNCj4gPiA+ID4gZXhwbGljaXQNCj4gPiA+ID4gY29udGFpbmVyX29mKCkgaXMg
ZWFzaWVyIGZvciB1bmRlcnN0YW5kaW5nIHRoZSBpbnRlbnQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+
ID4gPiBBbmQgaG93IGRvZXMgY29udGFpbmVyX29mKCkgd29yayA/IDopDQo+ID4gPiB0eXBjYXN0
aW5nIHRoZSBmaXJzdCBtZW1iZXIgdG8gaXRzIHBhcmVudCBpcyB0aGUgc2ltcGxlc3QgZm9ybSBv
Zg0KPiA+ID4gY29udGFpbmVyX29mLg0KPiA+ID4gDQo+ID4gPiAtag0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiANCj4gPiBXaGljaCBpcyB3aHkgaXQncyBjb21wbGV0ZWx5IGVxdWl2YWxlbnQgYW5kIHNp
bmNlIGNvZGUgaXMgc3VwcG9zZWQNCj4gPiB0byBjb21tdW5pY2F0ZSBtZWFuaW5nIHRvIGh1bWFu
cywgY29udGFpbmVyX29mIHNob3VsZCBiZSB1c2VkLg0KPiA+IA0KPiANCj4gTm9ib2R5IGlzIHN1
Z2dlc3RpbmcgdHlwZWNhc3RpbmcgY2ZnLCBkZXYgb3IgYW55dGhpbmcgZWxzZS4NCj4gVHlwZWNh
c3RpbmcgYmV0d2VlbiBtYWlsYm94IGNvbnRyb2xsZXJzIGlzIGZpbmUgYW5kIGFyZ3VhYmx5IGVh
c2llcg0KPiBvbg0KPiB0aGUgZXllcyB0aGFuIHVzaW5nIGEgY29udGFpbmVyX29mLg0KPiANCj4g
LWoNCg0KT0suIEhvdyBhYm91dDoNCnN0cnVjdCBtdGtfdmNwX21ib3ggKnByaXYgPSAoc3RydWN0
IG10a192Y3BfbWJveCAqKWNoYW4tDQo+Y29uX3ByaXY7DQoNClRoYW5rcy4NCg==

