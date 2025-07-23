Return-Path: <linux-kernel+bounces-743255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FECCB0FCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B13B189FE28
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74A3271A6A;
	Wed, 23 Jul 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FVoiUngL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nl6i3ccM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C01F5838
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309372; cv=fail; b=sreOvC/gQxyraUq7frgq4b4si85Unv8UCpV03ah3ZCxzdGiOOjC3YzL3OtQuD7DfCKUP44qa30dHhNt19kLLd/6fjOtmxmMA3Wh7YT5nAbE53+7Bt4fKNpsN38+B54SS6SYKcrTbDmpvdoTywM8RPAeKQvSXEND6kNA+1wRYGM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309372; c=relaxed/simple;
	bh=Ozr19w8yIoIjYksET90AM0RSCCudJ8v7flsvMmTarcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcqWz0eth7wUydF0esSg48ETPpdsTJ7dUOhLpcif1O3epahGOyzLtck1+kRdNuYt/TcdMEp/Z1wyLouGY0+6VHSXPI8dMfpcDHuCeZczGcYujx09RACH+yxxHM8FZJVoFYGLFPzJxnJwm76PvyglfSQ3g4Ni0N6nk+eNF4g1SDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FVoiUngL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=nl6i3ccM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8cb45dda681311f0b33aeb1e7f16c2b6-20250724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ozr19w8yIoIjYksET90AM0RSCCudJ8v7flsvMmTarcQ=;
	b=FVoiUngLit5EvW765WVIcf3woIfXa8vZh0rLKLn6sbvaT6Jcbh/kIaWZgZvBsUlrfHliH2Es/NC3sD3k+YKqA7MGicDFDDb/OILIwq6ogkIEJRPuwO5Nc22ur3FFNRoKDKuVigFOuhOIvRVJywbpYOYh8JuRXYqrF2NaHC/EHfU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:0a2c8318-6cfd-4e8b-bad7-f43953f79ef5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:25332e50-93b9-417a-b51d-915a29f1620f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8cb45dda681311f0b33aeb1e7f16c2b6-20250724
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <pierce.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 43501006; Thu, 24 Jul 2025 06:22:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 24 Jul 2025 06:22:41 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 24 Jul 2025 06:22:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbSt/lm6yUgQLMDD1CyVvrLC2KOwGP7iS4PypSkksxBMJ+yILgZAxERq5rwA72igj+bckor7LRq9ocoKoRvHWUV1SqN0VT0xcUmXh0F2lOkELk2XsjGveh8ctuRLvplY3DFT63nFKLb1Bz6LAkKBofLtLZ3qRD/7x0hpk2oXcmg8ZU37CfGvQKRN2iN8xy6tDwD4F4n4GuB/sG7/cjjfUo7nmzdYSuuXBl+VpcuIjEv4o6i++vpMcubuK/wrHqX5iWP8F4AmX7N4KSJKCJ7Igag9Sc2jJyiaxJcTjdyyy/xrEzgmr7C/H1sfeNap82iB7VOFhETSAPkBGSFm7nV/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozr19w8yIoIjYksET90AM0RSCCudJ8v7flsvMmTarcQ=;
 b=RA8Fiv6cXHCuGoFREM0Y3dwbMZXfcNvjEl/qEtCLMuZD3i3KmI8NCj5CQX2+6Y113Xazs0nik4ir9ODSJVqMeDUhFoWFGrPq/CFrzQggCcmEP8EMUghFOUC0CqcV6aSx3M9zdyqYvIDuUWV78TFCDSNriB/2o6MBMOw2hHcIMqAgMvB3uVoHwbl87ejgHV/mq9P+VwZaMbfsZ3bsb10ZS3s8zQXeBN7u4wodv6zuhyEEv6PEhaWD1b3RW2axoT26xVEejX1w8NSVBQnrjfSxGsWJise50MZtucIp/ePX2Z3MTUHw1XVE7Makfk7OF7hqcPyjNyVGptD20p4pUSLDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozr19w8yIoIjYksET90AM0RSCCudJ8v7flsvMmTarcQ=;
 b=nl6i3ccMKB+7QXZbwqvndWez+bysMIeltQbjDJ+RrpLTyhSrYFxL4z9xnwLYDZ72wqTIyVnUCpDs2vPkAP3MtX5wZV3fEz6hNTZjSfF41IuqbcaVW1Jen0Zy7uHd2RhIKnE4vRr4fG7U7M/W2ZWGE1dI2LNY3Fel9Zsa0qh45tI=
Received: from PUZPR03MB5962.apcprd03.prod.outlook.com (2603:1096:301:b2::13)
 by SEYPR03MB6508.apcprd03.prod.outlook.com (2603:1096:101:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 22:22:37 +0000
Received: from PUZPR03MB5962.apcprd03.prod.outlook.com
 ([fe80::34ed:9b6a:a173:866e]) by PUZPR03MB5962.apcprd03.prod.outlook.com
 ([fe80::34ed:9b6a:a173:866e%4]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 22:22:37 +0000
From: =?utf-8?B?UGllcmNlIFdlbiAo5rqr5b2l57+UKQ==?= <Pierce.Wen@mediatek.com>
To: "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	=?utf-8?B?S3V5byBDaGFuZyAo5by15bu65paHKQ==?= <Kuyo.Chang@mediatek.com>
CC: "bsegall@google.com" <bsegall@google.com>, "vschneid@redhat.com"
	<vschneid@redhat.com>, "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "mgorman@suse.de"
	<mgorman@suse.de>, "jstultz@google.com" <jstultz@google.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RFC PATCH 1/1] sched/deadline: Fix RT task potential starvation
 when expiry time passed
Thread-Topic: [RFC PATCH 1/1] sched/deadline: Fix RT task potential starvation
 when expiry time passed
Thread-Index: AQHb6uZKUX8xFh10b0CrsHJ5jrqSH7QFycqAgAMYq4CAAX+agIAA5zaAgADPJYCAAMGeAIAzkMAA
Date: Wed, 23 Jul 2025 22:22:37 +0000
Message-ID: <cd10d32b514d2792659fe03ad1235771982a6e2f.camel@mediatek.com>
References: <20250615131129.954975-1-kuyo.chang@mediatek.com>
	 <aFAyN4rfssKmbUE5@jlelli-thinkpadt14gen4.remote.csb>
	 <089882f95b1b910f7feecddd0ad9b17f38394c64.camel@mediatek.com>
	 <aFQM8TdZIIvvGv8T@jlelli-thinkpadt14gen4.remote.csb>
	 <6ec534be0618de3e2b4d81555e5f24155326c0b9.camel@mediatek.com>
	 <aFV8qeH__bw0chWM@jlelli-thinkpadt14gen4.remote.csb>
	 <a1103727ffaaf5f4d1b077bc09a3cc5168c5708d.camel@mediatek.com>
In-Reply-To: <a1103727ffaaf5f4d1b077bc09a3cc5168c5708d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB5962:EE_|SEYPR03MB6508:EE_
x-ms-office365-filtering-correlation-id: 09bc76b6-021c-4b37-2d0f-08ddca376dd4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHkxajBvMmNRSy9OaVBoaWZwVXZrdEN3NnlRYmVZUlFqMW12dDVtcS90SFRF?=
 =?utf-8?B?ZEI2V1crR0hqZWZURDA5anp0dXY4VUd0ZG5qc2U3c3I2ZW5pRkZRbm02Smw3?=
 =?utf-8?B?Vm9UMDVuTE5MRmtvblo0MjVNeW9Bd2lvckdsd2pZODcyWG9IMHFSeWphemRD?=
 =?utf-8?B?K0t3dDQ4R3dTeHppMGs4cCs0RE91TkF5SDQzYVhZNzlFemdzcFJ2eVhDN25N?=
 =?utf-8?B?U2toamoyYmJ4RVlndmkxWEZPNzludUw1dUxJeVBSNTd4elExSGtMWE5aTW5X?=
 =?utf-8?B?WldvVUxXb1BHUTNRU2hoOTdDMm1jUXplbGdtSVY4U3pudzZzUU1FMkZTRTlH?=
 =?utf-8?B?dDdRVDdwb1ZDV05md3kyUDZ6RnBYS1g1MU83dFFvNVRFdXNEVHVhYm5lQTBh?=
 =?utf-8?B?UVl5ODZjSGE2bnFoRWtaZVBpMUxHVFJoOWhMNjdENnpGM0piR3lvWTd0OHBw?=
 =?utf-8?B?ZXJvSzZ6Qzk2VSsvMzZ3RnFvaVJkNGYyc2hvWFdHVzZ4bzdhYW0yUjdoMGdD?=
 =?utf-8?B?MHppMWVDT3R3dFdPbUZSSlE1b0xOdjNWZ2FZVHZTZnZuSVBJSVNIdHZERGpq?=
 =?utf-8?B?ZmJqRXY5eUdBQWRQOWViQmJQd09ObnU2VVl3Qk0xeVB0OTJrMzVXdEZVZmFp?=
 =?utf-8?B?cU43NlNHeis2T2VBMEdGR0VkaWpiRXpGUzRZb1dPeG5GUXFyT0RvNEd3ajQ0?=
 =?utf-8?B?eGlHejQ5aHdXb2o4S2FZYzVvaEMzelBDVjJ5NjVEaHd1ZEVPVmdEZkhGYUxw?=
 =?utf-8?B?UTBFOUJJUzc0TGkzRHlya2lMR3pYVGZudFZNSVRzYUllZ1F3MkJ6d0VTbEJl?=
 =?utf-8?B?alhZTStsSWxXUy9CQ1htMEpqTFY3ekZ2M2g3Z0NBUklGTGdZOHg5TEEvVGdV?=
 =?utf-8?B?TENORWM2UUhaVmJPaEVSRGp6T0pWZGl2OE04QmVHSTNYdU9NSnF5Y1lQeEE0?=
 =?utf-8?B?UWJ1WGxXb3Y0TmRmTVQ0SXo3UWl1STJGc2hwemZiK0hmTGJ5Ulh2QU15cjVs?=
 =?utf-8?B?bjJxRUV1UkFiM1hWUjZONSs2c2lsYmZ3VER1UXNVOStEMWhiNE41UTNlQVor?=
 =?utf-8?B?VG1seXQzMjVqY2RlVHhxVkd1MnlucXJGNGNYMWxseEc1Nnd2N2VRRFo2L0I1?=
 =?utf-8?B?amduZDJLelIvRlJ2R28yZW94dmJZR1pQcFBVQVJEcE5kdVdycTl3RGhZMGNv?=
 =?utf-8?B?UGw4R0k0MmxuRTRsWS96YW5JUlFINkNLRnRDOWZ0cktvRUo4VUY1bDF1dTB4?=
 =?utf-8?B?Slh6MVNHYzZWTDdEQm1GQ0VGc1VpQlEzVDV4a3JybGNSRmZWeVI5em1Wd09P?=
 =?utf-8?B?bEpPWmFRQUtSd3Y2bVZGUmgvMUJjMUtLcHNYSWNhMEFyRFhOOGtBZ1JFNGx6?=
 =?utf-8?B?RkNyWk1wM1lMM2h3TjZKTlVMeFY0QXlpVlZPWXpneFNnWnFObHIwTkxlU0w4?=
 =?utf-8?B?ZUhkMldhMWFWVnlzcWlOdFBqVjA0bm5SSG1pMFBLcDNsS3BKRGMyakMxWms0?=
 =?utf-8?B?VUIrMDJ2Q21MWUlSelhROXBSekxYNUNQY2JDTkhReWtyM0h3aitXbXdzWU1P?=
 =?utf-8?B?MGZYRkxtQVhabDduYXBCRWNLaUoxd2NUZnJYcVFIdUlJcUIvUGRMM3VzckxE?=
 =?utf-8?B?Tzd1Wk0ya2Z1ei9IbjQ0UU5ZdGlDKy9CZFgzS1haNkNsMWdCNkt2U1lyL0hT?=
 =?utf-8?B?VHlvVTU0WmRodlJidmJ0NldqUUppUDNManJjY3M4RUlSbXdJY1pJdnpOdHZ5?=
 =?utf-8?B?UkdEY0x2NFp2d2wxcmRobThOelZCMjRobS85cWg2OFVEQXZUd0VtUDF0dWhS?=
 =?utf-8?B?ZFJJZzJLcUZ6d3gveW1nSmdwZzQ4K1h2NlpBRTgvZmpzUVBQa1VsRnJlMEsv?=
 =?utf-8?B?dUptM1lUMjkzM2dVNDR2SC8wT0xIcHBzZnF2b2hDVklGSHRwVzNVNDJSRlpR?=
 =?utf-8?B?L1d2bnVOWE9GV2YwdWlsb1hSQnhId05GRm5MUlBUMEhaUnNNYUJPNTlCejBk?=
 =?utf-8?Q?iWlADqR5Ci857GsIwcdmQfNY+w8EVg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB5962.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHB6K1ZxemxBdmh4dmVicjFxNk16dVZOQ0dTWFUwZlQ2eVdvaTJwSWV0Q2NM?=
 =?utf-8?B?Qy8yamRVTW55aGNsdWJBR2lEQXoxeFRnTlp6QmxCSEVSOURPaDlTdWkrK2Yz?=
 =?utf-8?B?SnZzQlIwRVNXV0FkWGV3Ym1QOCtXK1prWndiTkEycDFWOXo2ZmMzZGQzeGRE?=
 =?utf-8?B?R1gzNkUxQmh2dEY4aUxIYnZoUXJJNUZMYmdkZDZla3pZeDVSdG1COURHcG1S?=
 =?utf-8?B?ZkZWNE41Uk9oSjZxQU9oNGVIYlpzUzk0bkk0SjN6TnNrWDU3NjBzRGlhSFlq?=
 =?utf-8?B?YjA5Tmw1REV5czRMOGlia1VhY0Vaanhqa2JDWm9YRzlHdTc5OTh3YlYySG1Y?=
 =?utf-8?B?eXhXWklyM3NHdm9jcnN2eWFnL084TW8yQXdROTFMdTNNa0hPV1pFN2x0U2N6?=
 =?utf-8?B?M3l3eExLU2I3NUlNVzRFbFdEQzlhSHMvczhQd1lCUXFLMjNqbTRUZEFHcHBC?=
 =?utf-8?B?eTJ6RU16U2Fsc3B0WlR3eWMzMzNtaGg1Q0VhdldnTEROZjIwdkFtRWpJUjFQ?=
 =?utf-8?B?TWFrSDVtNjEzMFJJL29jK0NEbGhIei9FRTZKeVozUmNkbnk1TldnU1NwSU9o?=
 =?utf-8?B?UmEzUm4rQzRXdGVZb1I3YjladXBhZjFIWFpsRm5ZSXdPRFlGWnNaNkpoUVJN?=
 =?utf-8?B?Y3NFMlZ3blNCVldhNE5lbm42T3l5UXBzM291bk9xRUxFN2JwYTV0YjB2RnZp?=
 =?utf-8?B?bTZxYUZiR3JnRndtK0I0RktWNDNOZVdCQWZxQlhMUEI5cFJWZno0cnh4cW01?=
 =?utf-8?B?Z0ttL2ErTHNGQzdXNXdmZXREV0toZGdhUmd2TFZudkRuUHRSaURJZ2FDSnc0?=
 =?utf-8?B?SzJVOEptT0lpOUR1STlDR2E4NFV1aUFhemlsWDFiQ1JaTnZJSzFiVHl2bDVx?=
 =?utf-8?B?KzFaaXQ4YncrenVpTGlob1p2YmE3aFdBRGNTUDZMWnNsU1JpQlhMM2tKOG9h?=
 =?utf-8?B?cGc4R0RQZmkwU0NFM2dQWDlzQkpqeTBzSXM2NWZYSGlEdU5mSTRZSS84YmEv?=
 =?utf-8?B?UU1UdUxLcmtsbHFSaEg4YVM2Yk1FUDJpek9xd3daNVByZ284STNMenFOM3Rl?=
 =?utf-8?B?eDhoSGRCdE5qNlZXSEdVaTQ0RTlNaG13dGMraTNQZlVLUGRNQmtkYk9CS3Q0?=
 =?utf-8?B?NlRwTEsrM2dxUmFzeUZuRHU2WjVRTFNRRldqUWxwQzM4Y0tKUHlTSEphNE16?=
 =?utf-8?B?TGVtZFFnMXZKTUhCMzlhdlRVZFFITUl4Nm8xL01LSk9ab3ZVMzlhQUxTUmpn?=
 =?utf-8?B?K3MvUDNLWUM3RHlsa0RBWjdYdjhzTCtrS01LY1RoWE5EenNIODlhR1dPeitX?=
 =?utf-8?B?T0hpVDVTV05qbGJvM2NtVnpDTlF0cytycWpOUmVzS1EzaUdBMnIyWlRiWGtZ?=
 =?utf-8?B?NHh2RDVIWkNRWFhFZEJ1bS9HRlhVRWZQaDZ4clhoYVltUjBxRnBocWthcCtK?=
 =?utf-8?B?WGlPYXFIZGx0RHF5ODFTRm8vMVBNVzNFRWlwei9qdktQU3NKN1d5V2g5NE8v?=
 =?utf-8?B?anRZVEk2a3poUmtMcUN3cHR3VWZDaFZuN3NranI3UUI1ejlKVWtXR2Z2WXRG?=
 =?utf-8?B?Ui9NS0VCRVY4NXRpUittWVJJR2NSaFVkeFBzOVR5ZklCU2w1YjEycnd0eGRn?=
 =?utf-8?B?UFlBMlh3RXV5Yk9YSm9NT1ZTbTFibWl1WEV4YWYyL1d2M1pJVVoyZGFWajZU?=
 =?utf-8?B?aEZISTEzUDZKZzNjcmhmQWlqemxLK0lWSkF2dnRzd0x6dklQQ3FaSzJ3cTl3?=
 =?utf-8?B?SjNZVzRGS05BRzZsbXBTbFBGRkpXUW16dTczWVVzN2U3b05GVG1wMzlhV0Qw?=
 =?utf-8?B?SXVsL1ZzeWNsM1MwWC8vUmR4Wm5paUtwM2FERXJmRmFvTElaY3REejZOSHlh?=
 =?utf-8?B?bTQ2TUM3NFdEK1pYeVB5YzVOOVRZK3NLSUpUcUxVNFZabThLNUxoSjAvSFZF?=
 =?utf-8?B?VHRnaGFhRStMT1hZQTcreUdxL01CcW5aQjFMUzRJU3J5dzMxeDVmTjFZU0dw?=
 =?utf-8?B?Mktac1RnQmVsYyszU0EwUlVuMWx2UTVTcm5hNlFKT1NoTGtsRlVuV0lXRVBx?=
 =?utf-8?B?YkQzZ05peGJtWnczN0tWakMxUllxVGowMm1aSEpFNVdYWDFRemMwMHpmYisw?=
 =?utf-8?B?VWZWeFljemxScjNjQVVKZ3crbis5MjV6R0R6S0puZDNJcFZ0UkU3Y3FDR3h1?=
 =?utf-8?B?cmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E2ADF7F996F5B4095B30F38628DA43E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB5962.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09bc76b6-021c-4b37-2d0f-08ddca376dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 22:22:37.0837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhZ2QakIbCcemekDyqA3VKqBPf5OFJPZvfEUKD3qKyAFF5m+lzj72X7rLqQ0WnN63WgjiQz9OeQ1a7hxtpYHEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6508

T24gU2F0LCAyMDI1LTA2LTIxIGF0IDEwOjU1ICswODAwLCBLdXlvIENoYW5nIHdyb3RlOg0KPiBP
biBGcmksIDIwMjUtMDYtMjAgYXQgMTc6MjIgKzAyMDAsIEp1cmkgTGVsbGkgd3JvdGU6DQo+ID4g
DQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMNCj4gPiB1bnRpbA0KPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ID4gDQo+ID4gDQo+ID4gT24gMjAvMDYvMjUgMTE6MDAsIEt1eW8g
Q2hhbmcgd3JvdGU6DQo+ID4gDQo+ID4gLi4uDQo+ID4gDQo+ID4gPiANCj4gPiANCj4gPiBUaGFu
a3MgZm9yIHRoZSBhZGRpdGlvbmFsIGV4cGxhbmF0aW9uLg0KPiA+IA0KPiA+IFRoZSB3YXkgSSB1
bmRlcnN0YW5kIGl0IG5vdyBpcyB0aGUgZm9sbG93aW5nIChvZiBjb3Vyc2UgcGxlYXNlDQo+ID4g
Y29ycmVjdA0KPiA+IG1lIGlmIEkgYW0gc3RpbGwgbm90IGdldHRpbmcgaXQgOikNCj4gPiANCj4g
PiAtIGEgZGxfc2VydmVyIGlzIGFjdGl2ZWx5IHNlcnZpY2luZyBOT1JNQUwgdGFza3MsIGJ1dCBz
dWZmZXJzIGxvdA0KPiA+IG9mDQo+ID4gSVJRDQo+ID4gwqAgbG9hZCBhbmQgY2Fubm90IG1ha2Ug
bXVjaCBwcm9ncmVzcw0KPiA+IC0gaXQgZG9lcyBhbnl3YXkgbWFrZSBwcm9ncmVzcywgYnV0IGl0
IHJlYWNoZXMNCj4gPiB1cGRhdGVfY3Vycl9kbF9zZUB0aHJvdHRsZQ0KPiA+IMKgIG9ubHkgd2hl
biBpdHMgY3VycmVudCBkZWFkbGluZSBpcyBwYXN0IHJxX2Nsb2NrDQo+ID4gLSBkbF9ydW50aW1l
X2V4Y2VlZGVkKCkgYnJhbmNoIGlzIGVudGVyZWQsIGJ1dCBzdGFydF9kbF90aW1lcigpDQo+ID4g
ZmFpbHMNCj4gPiBhcw0KPiA+IMKgIHRoZSBjb21wdXRlZCBhY3QgaXMgc3RpbGwgaW4gdGhlIHBh
c3QNCj4gPiAtIGVucXVldWVfZGxfZW50aXR5KFJFUExFTklTSCkgY2FsbCByZXBsZW5pc2hfZGxf
ZW50aXR5KCkgd2hpY2gNCj4gPiB0cmllcw0KPiA+IHRvDQo+ID4gwqAgYWRkIHJ1bnRpbWUgYW5k
IGFkdmFuY2UgdGhlIGRlYWRsaW5lLCBidXQgdGltZSBtb3ZlZCBvbiBzbyBmYXINCj4gPiB0aGF0
DQo+ID4gwqAgZGVhZGxpbmUgaXMgc3RpbGwgYmVoaW5kIHJxX2Nsb2NrKCkgYW5kIHNvICJETCBy
ZXBsZW5pc2ggLi4uIiBpcw0KPiA+IMKgIHByaW50ZWQNCj4gPiAtIHJlcGxlbmlzaF9kbF9uZXdf
cGVyaW9kKCkgdXBkYXRlcyBydW50aW1lIGFuZCBkZWFkbGluZSBmcm9tDQo+ID4gY3VycmVudA0K
PiA+IMKgIGNsb2NrIGFuZCB0aGUgZGwtc2VydmVyIGlzIHB1dCBiYWNrIHRvIHJ1biAoc28gaXQg
Y29udGludWVzIHRvDQo+ID4gcnVuDQo+ID4gwqAgb3Zlci9zdGFydmUgRklGTyB0YXNrcykNCj4g
PiANCj4gDQo+IFllcywgIkRMIHJlcGxlbmlzaCAuLi4iIGlzIHRoZSBjcml0aWNhbCBjbHVlIGZv
ciBpZGVudGlmeWluZyB0aGUgcm9vdA0KPiBjYXVzZSBvZiB0aGlzIGlzc3VlLg0KPiANCj4gPiBJ
dCBsb29rcyBsaWtlIHlvdXIgcHJvcG9zZWQgZml4IG1pZ2h0IHdvcmsgaW4gdGhpcyBwYXJ0aWN1
bGFyDQo+ID4gY29ybmVyDQo+ID4gY2FzZSwgYnV0IEkgYW0gbm90IDEwMCUgY29tZm9ydGFibGUg
d2l0aCBub3QgdHJ5aW5nIHRvIHJlcGxlbmlzaA0KPiA+IHByb3Blcmx5IChjYXRjaCB1cCB3aXRo
IHJ1bnRpbWUpIGF0IGFsbC4gSSB3b25kZXIgaWYgd2UgbWlnaHQgdGhlbg0KPiA+IHN0YXJ0DQo+
ID4gbWlzc2luZyBzb21lIG90aGVyIGNvcm5lciBjYXNlLiBNYXliZSB3ZSBjb3VsZCB0cnkgdG8g
Y2F0Y2ggdGhpcw0KPiA+IHBhcnRpY3VsYXIgY29ybmVyIGNhc2UgYmVmb3JlIGV2ZW4gYXR0ZW1w
dGluZyB0byBzdGFydCB0aGUNCj4gPiBkbF90aW1lciwNCj4gPiBzaW5jZSB3ZSBrbm93IGl0IHdp
bGwgZmFpbCwgYW5kIGRvIHNvbWV0aGluZyBhdCB0aGF0IHBvaW50Pw0KPiA+IA0KPiANCj4gWW91
IGNhbiBjb25zaWRlciB0aGUgcGF0Y2ggbW9yZSBhcyBhbiBlcnJvci1wcm9vZmluZyBtZWNoYW5p
c20sIGFuZA0KPiBzbw0KPiBmYXIsIGl0IGhhcyBiZWVuIHdvcmtpbmcgd2VsbCBvbiBvdXIgcGxh
dGZvcm0uDQo+IEhvd2V2ZXIsIGl0IG1pZ2h0IGJlIGJldHRlciB0byBjYXRjaCB0aGlzIHBhcnRp
Y3VsYXIgY29ybmVyIGNhc2UgaW4NCj4gYWR2YW5jZSB0byBwcmV2ZW50IHRoZSBpc3N1ZS4NCj4g
PiBUaGFua3MsDQo+ID4gSnVyaQ0KPiA+IA0KPiANCg0KSGkgYWxsLA0KDQpJIHdhbnRlZCB0byBm
b2xsb3cgdXAgb24gdGhlIGRpc2N1c3Npb24gcmVnYXJkaW5nIHRoZSBwb3RlbnRpYWwgUlQgdGFz
aw0Kc3RhcnZhdGlvbiBpc3N1ZSBhbmQgY2hlY2sgaWYgdGhlcmUgaGF2ZSBiZWVuIGFueSBmdXJ0
aGVyIHVwZGF0ZXMgb3INCmZlZWRiYWNrLg0KDQpUbyByZWNhcCBhbmQgcHJvdmlkZSBzb21lIGFk
ZGl0aW9uYWwgY29udGV4dDoNCg0KMS4gQXMgZGlzY3Vzc2VkIGluIHRoZSB0aHJlYWQgKHNlZQ0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBTkRoTkNxWUNwZGhZUzlhZmRLZVkzNEJtdzhN
WHlxS1dDU1R4T1pOTFRqWXJVYVZYZ0BtYWlsLmdtYWlsLmNvbS8NCiksIGl0IGhhcyBiZWVuIGRl
bW9uc3RyYXRlZCB0aGF0IHRoZSB1c2Ugb2YgYSBzY2FsZWQgdGltZXIgY2FuIGluZGVlZA0KaW5k
dWNlIFJUIHN0YXJ2YXRpb24gdW5kZXIgY2VydGFpbiBjb25kaXRpb25zLg0KDQoyLiBGdXJ0aGVy
bW9yZSwgc2luY2UgdGhlIGRlbHRhX2V4ZWMgdGltZSBjYWxjdWxhdGlvbiByZWxpZXMgb24gdGhl
DQpjbG9ja190YXNrIG1lbWJlciBvZiBzdHJ1Y3QgcnEsIHdoaWNoIGlzIGFmZmVjdGVkIGJ5IElS
USB0aW1lIG9uIHRoZQ0KcnVucXVldWUsIHRoZXJlIGlzIGEgcmlzayB0aGF0IGlmIElSUSB0aW1l
IGJlY29tZXMgZXhjZXNzaXZlbHkgbG9uZyBpbg0Kc29tZSBjb3JuZXIgY2FzZXMsIGl0IGNvdWxk
IGFsc28gbGVhZCB0byBSVCBzdGFydmF0aW9uLg0KDQozLiBCYXNlZCBvbiB0aGVzZSBvYnNlcnZh
dGlvbnMsIHdlIHN0cm9uZ2x5IHJlY29tbWVuZCBhZG9wdGluZyBhDQpyZWNvdmVyeSBwYXRjaCB0
byBhZGRyZXNzIHRoZXNlIGNyaXRpY2FsIHNjZW5hcmlvcyBhbmQgcHJldmVudCBSVCB0YXNrDQpz
dGFydmF0aW9uLCBlc3BlY2lhbGx5IGluIGNhc2VzIHdoZXJlIHRoZSBjdXJyZW50IGxvZ2ljIG1h
eSBub3QgYmUNCnN1ZmZpY2llbnQuDQoNCkJlc3QgcmVnYXJkcywgIA0KUGllcmNlLg0K

