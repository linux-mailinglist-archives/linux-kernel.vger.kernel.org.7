Return-Path: <linux-kernel+bounces-829857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E475FB9810E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72A519C6857
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620A21D5B3;
	Wed, 24 Sep 2025 02:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nctCMtIc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="giYl57g7"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420ED192B84;
	Wed, 24 Sep 2025 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680493; cv=fail; b=enhmhYR5q2BtNAE2m1eeQq1gU4nvkQiKjU2BDtoGFz59ri0ZUapRdOCvmBZif2bbiYN2dv3NlDJBU33cho1nDCfbPSDAlaSGRrTk4jPm04jTKfksUQxaUOnyb/3JzktLnGwj0OSVARZCxMG47Vym6d4eXcXRwEGUmnnFzEpHNzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680493; c=relaxed/simple;
	bh=g71oTCEbIKshX4pKwDD7nxtV5A/kGXiZfyNiMHGruhg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xyz36BhVx9QCmH9zdi5ivQIJYZ1aECCNTHOUxsKJ1zpbzycvqKjwX7/neQ4OKmL8/9QzCA1lJdUCOrXJJlRN6dsBhWha1ZjujQz8rpk2JExskd8HqbRqhrJ9GtkRQ2i1p6HAemvBWpPcEi2rwv1WmP2fCkWl1DPAw5t/smpXf0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=nctCMtIc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=giYl57g7; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2bccc40298ed11f08d9e1119e76e3a28-20250924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=g71oTCEbIKshX4pKwDD7nxtV5A/kGXiZfyNiMHGruhg=;
	b=nctCMtIcKZSVdFBuQZ4lugr7jeFMOw0hFBky08eFOVfSdBsd7R/S7GeOVFjgeWyhHyj9w2qFyoIlShRMLEderQ9spMv/IU4xqJ1GOkzBA6cK4cK8jA1NwYjnH6VRjwUttUSXf5+IN+NUt6fOrzQ8oGknqyNI5CHWnbkaJhWHQb0=;
X-CID-CACHE: Type:Local,Time:202509240942+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:523e6e44-c912-408a-a174-1e2c8682ba26,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:17e69ef8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2bccc40298ed11f08d9e1119e76e3a28-20250924
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 566987449; Wed, 24 Sep 2025 10:21:25 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 24 Sep 2025 10:21:23 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 24 Sep 2025 10:21:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlE2FMcHzkxUUW/Z4+3uE1Ke8Zl9EetQqxfSW4DY9wzKtWDXIjH4Sh8tEMcP+nLCAErlAL+zaxxksaB8fhzj6Svq9IyBrs9nc4B/Oe22vil5poxwPQ70NhuaYF+cV/0t2xwJeG5zgxo836bMJaUQ+datw1Iqc2OSArVOcsndn6VS6IJ8mqmsCGoTGQWSFTYUuCnMtDvHorUKatX/ahiuvSDn4c88DluUcDC/AMZbADTEyQlCYZVeloY18AvObBTYk1r8yCXAR1JIYnpmHqHpW45ZQ+loGjj4cuo0JZVygvFWf+tlLm8VPEbtHkyyugoPA5CgVLIP4s09G7k8QuPblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g71oTCEbIKshX4pKwDD7nxtV5A/kGXiZfyNiMHGruhg=;
 b=tGZ78H9Aae9KqFiTVPDvzicKr1H2xanZ4LetkXmy0EVxhKXLgS9QjiOL53HhXn/6m4a1auWGbyjseFCffmlQXl7U0tb8Diu6IVzzhPrThYYTlYeE7PQtKoqxml9/rOpoSQ596InlxcMjS/8QaAajwLDQVFShlErrc/XJRtt7iZspBWw4JDiJD1TtoEna3LToDZQvpAWB0Q/DIZnufPDSsdUzeTHQTmFKXHD5+VjneCHU4n73voW0s61OEGUoqvjupP362h0ebkXD9IpUoe2xMbNqsOaVtX1UjkA6g5wHrEkWSaZ+HcdC3yu7vRbeM0EpiHk0NOv7sY5NXL2ON67wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g71oTCEbIKshX4pKwDD7nxtV5A/kGXiZfyNiMHGruhg=;
 b=giYl57g7oI4qw5E8LrAjsYJOikBiCr/yuCcawgfIT0b+cg278RmnBW/keXtwJJqYfL8ImOY/BxoD7pfyB/MGMAdOXfGdQCsJ4uqyTistjWJKCuYb6Gc8etrE3+3cWKDO9Xl/wuOjIONLG5egU5tSfrmaI5k0K4OQSKFJeBkKaEc=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TYQPR03MB9408.apcprd03.prod.outlook.com (2603:1096:405:2f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 02:21:20 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:21:19 +0000
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
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgAa9iwCAAGuGAIAA3KsA
Date: Wed, 24 Sep 2025 02:21:19 +0000
Message-ID: <90882536d8307a58b6e5787225c07335689bd490.camel@mediatek.com>
References: <20250822021217.1598-1-jjian.zhou@mediatek.com>
	 <20250822021217.1598-3-jjian.zhou@mediatek.com>
	 <CABb+yY16DPJwVTHap4F6n5YJoOJzQLtqKiCQ-2MUm67pzF8uXg@mail.gmail.com>
	 <24a916ece6971d3ab9156dd8277eb23935e9cb13.camel@mediatek.com>
	 <CABb+yY0njdWUd=HWT1rSYSpNM9QoO_jf6piY9ny1enB+rZZF+g@mail.gmail.com>
In-Reply-To: <CABb+yY0njdWUd=HWT1rSYSpNM9QoO_jf6piY9ny1enB+rZZF+g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TYQPR03MB9408:EE_
x-ms-office365-filtering-correlation-id: a9c3463f-34a5-489d-6538-08ddfb110c67
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QXVzdUhsMFJzNzVPNVNoOUV5Z2tlN20xYTlBK09WSEt6bUxvdDlQZ1B5SFk0?=
 =?utf-8?B?R1hNWmZ0N0REclJTdnJjT2h2aXJwQW5DOC9OWXFqWU1QeGJ6R242Q3J6MTh2?=
 =?utf-8?B?RkU3T0I2RTBHcE4yak5oeUF2M1JwUEFCcnpBL1M0dDFLeFIxNTVyd0MrZ2hk?=
 =?utf-8?B?RkNhMXNHUGdzb2FtQ0dKVEx3SlJXQWk5Z2xwSWZicFlSNzhCZnY1dkt4dGxZ?=
 =?utf-8?B?eE5Ib0pGUmdJQmZESEhQMVgzQjg4UFZjWjBTVlhYczlLdytuNmpnTC8xcDlO?=
 =?utf-8?B?N2tXT09JY1BvcVp6NGVOa0tpeTQrSDZiWWVRWUJJTGUwbW9rNDd5bTBtK2sw?=
 =?utf-8?B?K3hLVzZpUExZcjMxQmx3VW0xMmtvYzV3WTJGOXhyQi8rY2UzOEROV2JUb3lY?=
 =?utf-8?B?NkY0WHVsTHhKMnVVRVZCa3pPbGwzRjArNytLcTVKekNvK0RiZHhUaFZPUmdR?=
 =?utf-8?B?aDdaNHRwcFd2NmorUVpVR1NQRlpUdEswV05vMXZzMFBQeG5VVWhSK3p3ZVVl?=
 =?utf-8?B?NFpNWng1TDhTK2JzbmtnSmw3TVZPb3JVenJOTEhLYzh1QTJ5akhQbFN4MEJW?=
 =?utf-8?B?U3NWd016MXNHT3lFaENwVFVGSmRQRWMrQnFQNHpqTmR4OVlndFNwRFlIclBL?=
 =?utf-8?B?dWFqZDBNNGdYQjZyQ1psb0JPVDRhOWNWelRtaWUwWU50NFB5bURid3RXRHVw?=
 =?utf-8?B?VDBkbVlDS2YxWFpMajBCbDB4dFpMRFBxZVZzK3FZZ2lDME5nV012TWQ2R0du?=
 =?utf-8?B?MWdITUxpZ1JjKzhUK1o3VlRXSUxjRXpDMkVOZ0xUakJDaERPN0g0Mk5sWE9S?=
 =?utf-8?B?UldEZWZGUzhFZGhzUHJvYlJhOHlxOU00WmRnMjFXZytnNTVtR2RFMlBGZkMv?=
 =?utf-8?B?UzVSaEZjTFdIcjlTRUNnQWRabGhNMEQ4Ry83QUkrM3JzOGNsZW5wN1l0NXJ0?=
 =?utf-8?B?cGJhaWdQQzF4a1hUcDIxcTlWR2JjdWhXTnF3b1pkRk9OSEIxUUhkYWVUR2h6?=
 =?utf-8?B?eHBGWTlxY3NiQnhITThhS1lDQWJaZUMrOUkrMFd2VFl3ZUp2T05SUHdJb1E2?=
 =?utf-8?B?TTdzblZwOFBEUjBPcFJrdkxxT3dSUVlxMzlsazhGZVNYRmFMOGswbTJzWmFV?=
 =?utf-8?B?VWhkWkxBN255ckpyYmVUbGJmakgyQ1FBZmRWUjJFSWZVa2hNV3ZKVUUydnRQ?=
 =?utf-8?B?SkpJVGpieUhJYjlqa1EzQTNiaFhxMzhYWlQ2cnlIbC9xNFBhalJSamNzdjFU?=
 =?utf-8?B?ZzJueUZwWW1MbDBFRnlEdE1JNitBT3llUFVBdnRyM3o0czFUdktEVHVWbmFQ?=
 =?utf-8?B?dWNNc01UNmVDVGE0MUlid0pGZ25hc25YQWpnNmgwejZNV3lrK244d0dESS85?=
 =?utf-8?B?NlJaeGc2NzhIa212aVYvZWhwSTFBTmxZdjVVR3dkdk9CNkw2ZCtVbS9LYklP?=
 =?utf-8?B?bXFBckNQUjlqeWlHREcrMkNQYUUveFRTdDh5aE44TkU1a2NzU1VuZk5aNStx?=
 =?utf-8?B?UThBMG1PM1prRkMzdGZRS2xrOFpZS0J2NHlydmJwVTBsUjIrUFE3R1luRGFU?=
 =?utf-8?B?K1NQUmErb0UrZC9MTVZDa1JjYjdsWmoxV2UydzRWcHBRc0hrZk9MWmhpK0Zt?=
 =?utf-8?B?dG8rdXh5V3N6Qlpva2wwQnBrcU4yQys2SFhVc1Z1Um1vc2hXRXdCamxqR1ZD?=
 =?utf-8?B?VWN4Rkk4V1I5cCtoclduQ25CK3I5MUd1cU1PdW90cnpJby8rL2VOODcyYVJT?=
 =?utf-8?B?cnIyVTVFVlZod1M3a3FmYk5FRTBwb2l2ZDlxek9SS1l3cHpId0dLcXJqeXA4?=
 =?utf-8?B?RSt5TFlFeUZ6RGNSQ2VSeVVZbjVsRm5KYUkwREw3OHhRRTc1QmFEY3lJbU9O?=
 =?utf-8?B?OENiL2Q0Tnp5cmhxREx5ZG5lUUJ5SVZzRnVsYW8xcU1zSkIxTEVZNU44OER5?=
 =?utf-8?Q?KuNM75okT1I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFkzT2NsTzh0MDRQL25kYXpyM3dHTlRPaUJsTlhtVjZ0aHppTnBFUjh1d1ox?=
 =?utf-8?B?TUZvMjQ3UlorNFVEcExPQUg0TzRPR0VaZ2pxYmdQUEFzZzlxNTZRa29QVDlt?=
 =?utf-8?B?SlBIMEovL1pvL0hHd0VibU03ZStJVUdpbkRzWFFhQkpPakNjdGZYdEN4TldZ?=
 =?utf-8?B?dkpGUHVMZkNDd1ZYbVQ4eEs1RlVMOTdlbWdGN0VRR0twelhJclQ4MU1QVEJO?=
 =?utf-8?B?YVhSaTlCRGp4ak5CbW1yWGZFWEFJTGUzdXVYS3lCUEhCUEgxS1VGMEowTHc1?=
 =?utf-8?B?UXR1U0hmREE3WWl5Q0Z3b0l4Z1phQ2hkZ3Q4SVhCczNUSW96eUF4djhydjhG?=
 =?utf-8?B?Tk1pTThYeGdFbUJ1UnM0NlRGaWpMZGhTdHZQdC9nWEJCRlNBb0tlNXlFK1I3?=
 =?utf-8?B?VWhpSkhrQWxGdy95YU1wR2lSQjB3TXYzdVhXcG9oaENPY1B4eVVwWmpwQVR4?=
 =?utf-8?B?TC9McWs4ODdveEorUlFFeW4zZ3MvdGlHQTJITm9MR2RndEsxbEoraVpuWG0v?=
 =?utf-8?B?QkRsaEpxc0I2Rk14WVl2M1AzNnpYMEs2Z2JUbVEzVTlkMEFzQXJQVmdVMStz?=
 =?utf-8?B?VVE2NU1EeGZPV1E2WWdBLzluU01hbjhacUtjRExIaDl6dXV0NktXUlI0Tkpq?=
 =?utf-8?B?RDFMYyszOTlBS2N1UDVJZTRuNXd1cDkvaVcvTTluUWRIdmNObHl3Z3FwNjF4?=
 =?utf-8?B?Z3pUbTRUbHBrakZiOW10aGJqV3VNK3Y5R2Z6eTVSWkJCek1CbGFQTENYKzZD?=
 =?utf-8?B?RnE2VmJocUw4OXJabUVQR2JhUTRwd2l1UWJ1WmpVaE42dWZaTDVSd2VZNnF4?=
 =?utf-8?B?V2daM1d3RUF3MmtZenhPcENXYmd2S3RVZkRRR3YyVFZaQUdKZjM2NFlwaTBG?=
 =?utf-8?B?WEtMc2M1RDNLWkY5dFVBYkZ3K2thQWJUS29zdUdKSUFoa0VBaHF2YTBkYzRL?=
 =?utf-8?B?Y2cwb3I0VHVjcDI2cU91ZWsvMjFmUDhJVEpQTk5OVjdJVjAzWXY0MXF0c09L?=
 =?utf-8?B?UFcxd0tsMTV5L0ZySGNOSHpXYlp4Q2g3MjJvaUVLdnpIZ3FuSzZDaWVZalVS?=
 =?utf-8?B?UkhxajhFQ0tRUXJ6T2xSZ2RIVVZuaVZjblptMngvYm9lWmJiblNzVGdYandw?=
 =?utf-8?B?SWNLRDNncTBpNkJPcS8rSUw4QzBaL0pqWlFOYXB2V0R4d1hWNjFTeHdhaWF4?=
 =?utf-8?B?YmNLMTBPWGRKU0d5YnFUR0pNSVM4VHhoVCtsY2hya0wrVFZMTFhLVHlxSTll?=
 =?utf-8?B?VEtpdDdQM2hYSnNjWFhMaDR5WUt2Wm5KczQrWHEzL2NNYkhWV2J1R3pyeHF5?=
 =?utf-8?B?N2I0OFl4V2FJRmdXVC9JNEZleUw4SEpEU0NVNXlSdEE4dW9PR1laWWV6dmI3?=
 =?utf-8?B?V2dmc05kZ0VzUXBRak5ocDNjNGt6NXMxbGh6WUZtbFp2UEZwOTFCVWhlUU1q?=
 =?utf-8?B?ZTlCdkhzZEdTY3V1MjBBK0p6NEV6ZVljRFVUa1pFanhTREs5ZFVzK2tsU29w?=
 =?utf-8?B?dlF6eGFEczVnQldnOXd6WmRVb1NuVWxTSFAwSWR4ODhCdS9tV1VLa3JqZkFa?=
 =?utf-8?B?RkZBZ2dsbTVjRVJhVWlVSndIWkJkU2RqamJUaEZxZWVIM3VvWFdqQU9FU2lF?=
 =?utf-8?B?M3R5dUxVeUdMMExkcTdua3dFOVQrZHdJUUVWRDdDbk8rQXZZOXR3T0k3cUlK?=
 =?utf-8?B?Sm4rK0ZyNFFZcjREanM4U2dPdCs1Q3RIcndTQ1NvRTlVYys0eVBkd1NCRCtE?=
 =?utf-8?B?Zmd4Y0lvSFR5QzBOYnc3ZjNDdmFxcHI4RnFCN0RjU2k3cGRraVlEdHFONWFw?=
 =?utf-8?B?NnRlbEtxR3o0d1M1K0psWU5TLzU1Nk44QXR5dCtQNHZEQkpZV1FxQW9mdkZs?=
 =?utf-8?B?MmxsZHY2dWtDdGRHdWJIQlIvdlJkc0VxZ1haeWJFS3NPa0N5d3VrL1lXcVJw?=
 =?utf-8?B?VGpoNlc5R2I4NUtnRnBDZDNDWWZ0SnQzNnNHOEhVWDFQbUN4RERZb3VST1c3?=
 =?utf-8?B?L2FBcFZRTHN3Vk1lY0JGNGQvME1ESUx1b09aU0VQT2s0NlZmVXRIa3B2cUJ4?=
 =?utf-8?B?S1IyTWQwN3ZIaXBrdUpEb0FQaUxacUJ1MTdFaEdRcDB4V054YWZZRFU0eWZh?=
 =?utf-8?B?OGVWZm9TY0J5RitvTFg4TDBBSFZUYUdHVjdUMmdGeTdUU1hYWDRwclFFSHFE?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB51678F2B689A4FB8A9BAFA4998E71A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c3463f-34a5-489d-6538-08ddfb110c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 02:21:19.7432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwRvCQS61LdpFEWmDcveGI0KzEk/v9CowElgkRYHcLA18Y2kZJAwHf3LDu6bOOFHrhuHyfQWG8XNaj46S0nm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9408

T24gVHVlLCAyMDI1LTA5LTIzIGF0IDA4OjExIC0wNTAwLCBKYXNzaSBCcmFyIHdyb3RlOg0KPiBF
eHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KPiANCj4gDQo+IE9uIFR1ZSwgU2VwIDIzLCAyMDI1IGF0IDE6NDbigK9BTSBKamlhbiBaaG91
ICjlkajlu7opIDwNCj4gSmppYW4uWmhvdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IE9uIFRodSwgMjAyNS0wOS0xOCBhdCAxODo1MCAtMDUwMCwgSmFzc2kgQnJhciB3cm90ZToNCj4g
PiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIEF1ZyAyMSwg
MjAyNSBhdCA5OjEy4oCvUE0gSmppYW4gWmhvdSA8DQo+ID4gPiBqamlhbi56aG91QG1lZGlhdGVr
LmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiAuLi4uLg0KPiA+ID4gDQo+ID4gPiA+
ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2Yu
aD4NCj4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiA+ID4g
KyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0cnVjdCBtdGtf
dmNwX21ib3hfcHJpdiB7DQo+ID4gPiANCj4gPiA+IE1heWJlICdtdGtfdmNwX21ib3gnIGlzIGEg
bW9yZSBhcHByb3ByaWF0ZSBuYW1lID8NCj4gPiA+IA0KPiA+ID4gPiArICAgICAgIHZvaWQgX19p
b21lbSAqYmFzZTsNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gPiA+
ICsgICAgICAgc3RydWN0IG1ib3hfY29udHJvbGxlciBtYm94Ow0KPiA+ID4gPiArICAgICAgIGNv
bnN0IHN0cnVjdCBtdGtfdmNwX21ib3hfY2ZnICpjZmc7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0
IG10a19pcGlfaW5mbyBpcGlfcmVjdjsNCj4gPiA+IA0KPiA+ID4gTWF5YmUgYWxzbyBoYXZlICJz
dHJ1Y3QgbWJveF9jaGFuIGNoYW5bMV07ICIgc28gdGhhdCB5b3UgZG9uJ3QNCj4gPiA+IGhhdmUN
Cj4gPiA+IHRvDQo+ID4gPiBhbGxvY2F0ZSBvbmUgZHVyaW5nIHRoZSBwcm9iZS4NCj4gPiA+IEFs
c28gaWYgeW91IGhhdmUgICJzdHJ1Y3QgbWJveF9jb250cm9sbGVyIG1ib3g7IiBhcyB0aGUgZmly
c3QNCj4gPiA+IG1lbWJlciwNCj4gPiA+IHlvdSBjb3VsZCBzaW1wbHkgdHlwZWNhc3QgdGhhdCB0
byBnZXQgdGhpcyBzdHJ1Y3R1cmUuDQo+ID4gPiBTb21ldGhpbmcgbGlrZSAic3RydWN0IG1wZnNf
bWJveCIgaW4gbWFpbGJveC1tcGZzLmMNCj4gPiA+IA0KPiA+IA0KPiA+IA0KPiA+IEVSUk9SOkZM
RVhJQkxFX0FSUkFZOiBVc2UgQzk5IGZsZXhpYmxlIGFycmF5cyAtIHNlZQ0KPiA+IA0KaHR0cHM6
Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvZGVw
cmVjYXRlZC5odG1sKnplcm8tbGVuZ3RoLWFuZC1vbmUtZWxlbWVudC1hcnJheXNfXztJdyEhQ1RS
TktBOXdNZzBBUmJ3IWtMbFg3MUhldFp3WE1aOVVtZHR2TUVLS3lrYlpJTklVTlZXNW5MVmZvenRk
a1NKTWxhYTNRZmJ6WnhHS0lrU2dxbUhIYzJMdmZ3cGo0VVJzT1ZDdGVrTkNGaDVMJA0KPiA+ICM4
MTogRklMRTogZHJpdmVycy9tYWlsYm94L210ay12Y3AtbWFpbGJveC5jOjI0Og0KPiA+ICsgICAg
ICAgc3RydWN0IG1ib3hfY2hhbiBjaGFuc1sxXTsNCj4gPiArfTsNCj4gPiANCj4gPiBDYW4gd2Ug
aWdub3JlIHRoaXMgZXJyb3I/DQo+ID4gDQo+IA0KPiBJdCBzZWVtcyBzaW5nbGUgZWxlbWVudCBz
dHlsZSBpcyBkZXByZWNhdGVkLiBXaGlsZSB3ZSBrbm93IHdoYXQgd2UNCj4gYXJlDQo+IGRvaW5n
LCBsZXQgdXMgcGxhY2F0ZSB0aGF0IGVycm9yIGJ5DQo+ICAgICAgICBzdHJ1Y3QgbWJveF9jaGFu
IG1jaDsNCj4gICAgICAgIHN0cnVjdCBtYm94X2NoYW4gY2hhbnNbXTsNCj4gYW5kIHNldCAgY2hh
bnMgPSAmbWNoDQoNCkRvIHlvdSBoYXZlIGFueSBzcGVjaWZpYyBjb25zaWRlcmF0aW9ucyBmb3Ig
c3VnZ2VzdGluZyB0aGlzIGFwcHJvYWNoPw0KV28NCnVsZCBpdCBiZSBzdWZmaWNpZW50IHRvIGp1
c3QgZGVmaW5lIGEgJ3N0cnVjdCBtYm94X2NoYW4gY2hhbnMnPw0KDQo=

