Return-Path: <linux-kernel+bounces-828153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B4B9410E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 060B44E2B17
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36723242D92;
	Tue, 23 Sep 2025 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kBmawToC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="v2/dwr9e"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E72264BD;
	Tue, 23 Sep 2025 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758596909; cv=fail; b=pVMLurqfZ5FrJy+7n8nbJ8bVz8zfZfpdUQgOp93cXnBvn5O8tNuB8CsAe9sNspE0jBHmfquJ269jS/SB6C1g9AwzVS0Pa9CZSuyo3ji8MmHlg04nwQW9Ca913U78LKP8t3aBqs1ONxSf8QOtj4jOzN3gKenbE7xczMwKousgQjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758596909; c=relaxed/simple;
	bh=GiR2mDEgZ9dfgBsSIcdx75UBEUjxa3tlE4KmgfYoAyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scTzIZd34kRJIqlji22YMtvg1hx9QYIFPyzwf4SEjwXAOjwi9SHeV38i6dEva4qRXvpdwqnYWi9Xa5eZQD3LttNKvjYPU8kG1/a+ALo66Z7Eu+A9m613sp/7F0g4f1xrLvA5HYcR97mY+bgLryyaPiwtL933Wmsbm9NVTU9Z5NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kBmawToC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=v2/dwr9e; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 907ecdb4982a11f0b33aeb1e7f16c2b6-20250923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GiR2mDEgZ9dfgBsSIcdx75UBEUjxa3tlE4KmgfYoAyI=;
	b=kBmawToCS6XUukT0OR9bLdLbm6yYOTubHr2EAYXH0q9E4lqVy/axjGEWDB8l5t0Y0omhzgCzmBG1x35vsuHHs2i0dPHcN+wLtNt4OdTjGB7QlgzUUBeAvTgV5b+V8MKwjS8pvKWN5ZhvNk/VnJ9r1Mmi9KA9YyOFokT4GYDtwuU=;
X-CID-CACHE: Type:Local,Time:202509231036+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:d20e43b8-36d7-40b2-a47a-a9a83c275d86,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:27a6d66c-8443-424b-b119-dc42e68239b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 907ecdb4982a11f0b33aeb1e7f16c2b6-20250923
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1718156317; Tue, 23 Sep 2025 11:08:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 23 Sep 2025 11:08:21 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 23 Sep 2025 11:08:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t48BqS+mEDZeaYZyiYilFL3oj9OReRYfOgDBDCdRX7JKl+aMurMG8H7gOsKDLA+tAqNUZoG+f6FxMhKUG73Apv49om3hL9pt50QF7TP5Bnakq1EBq7Lxy89OvzBBSux+kUYsu5Kwiy93WaDcO2JStNds7N2IHu0qR912QChL4unRljjcFCy/ijI9/XrYzI44M3bTLWtF2fEtm04TEoa+vm1EOJg4P7AVwMib4ru/cm4xwGryqvY/Xi7ZxEmOehdOfg0rKBLYVB9we+a0F4M7lFMzVU0d0O3EaoBAGKismbnQt7KU4ntwdgnjhMqvN/MjpLLugt1P7cLUn/KCmbS7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiR2mDEgZ9dfgBsSIcdx75UBEUjxa3tlE4KmgfYoAyI=;
 b=gLJOKW5P0vdxn+lREo7n42yqlDcGGXGdOoLCv7RlteJ4hYpSQZEHRXrRaM1jalazGz/d2zKRX8aoCATFrc3ccIDq3Nqmp+/uanfMpAvOXNSJ8+TIjfxWard/nx394l2zvw2Mu8e9WoFSKJA+i0sm5BVd/DwazkOjIS/xbnohGT1HQxCgg1XnMs7T2aQVsRqWLJpvTkwXSACsXr+8gy8W+7PSONoyDviLch/tSwmcz6NZNUJ5u7Yc44pxjj/fQpWe27O/hl8N7ixNaiRkfjQV9zrOjWWfhMGFGKSfbcCx9Vn7/bMFOGbl8bd8aV+vDDeXQ/caZu1CkiKQR+TB/qgVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiR2mDEgZ9dfgBsSIcdx75UBEUjxa3tlE4KmgfYoAyI=;
 b=v2/dwr9ezkVqS3BqGIInGlDqjh2yNrzN2z0kA58PSy1Go54mVz6rJjUgYq85dqWx/4R8IZUILTXKB3ZJAkGO9MIeAsncNOuq+Q+A+8V3BjDkyOybG79eY32s9f23VZDyr7jnf3ueTOPU34e1wXUbBVWoqbM358fetY8wYnDxTAo=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by JH0PR03MB8666.apcprd03.prod.outlook.com (2603:1096:990:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 03:08:17 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 03:08:17 +0000
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
Thread-Index: AQHcEwpW87Sc9bspPUqF1pf91CjDQbSZyAEAgAaAhgA=
Date: Tue, 23 Sep 2025 03:08:17 +0000
Message-ID: <7090b3362899b37c33288ff035352016d8c56432.camel@mediatek.com>
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
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|JH0PR03MB8666:EE_
x-ms-office365-filtering-correlation-id: a16e3f6e-366d-4b5a-6d8f-08ddfa4e7151
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?bStnT0RlcVRuREF0VmhqL0YweHFSWkZudGJaNmdsWmRabXZLaENKNGoyN251?=
 =?utf-8?B?OUdUSWZIMzR3VWt6RG05dE1WUmxBekliQUxVWEc4SlJrbldDMUhYNStLNExm?=
 =?utf-8?B?K2JSYnlsNjdJK3V2VkdGQ3huc2wwc2hLVjhYWlhRTHZ4cU8xaDFpRnB3dXFm?=
 =?utf-8?B?eXN1UERrUC9lK3Q3dU1BdEZ3M09RSDVFYk9kTUk3cnpScEQ5cm04T08wYWN0?=
 =?utf-8?B?SDdpVWIvUlZlaVBhWkRoSk44QUNQSTBoMzA1dmx1aGUrcjJWeHd0VWNyS1Zq?=
 =?utf-8?B?TVkyYURSS1NEdTBJT2o5dUtTVXhhM203QWphM1BUMEZRSnJFVXA1V2h5MXpr?=
 =?utf-8?B?RHFHYllaTE96VURSM0NpTUpFS1hZbFk4ajl0Mnh2anl2NlQxTDM3RDFUVzJ6?=
 =?utf-8?B?dFRYak1Gbm5jUzZ1bHFqaVBGTFZzc3FsRFdvSXhLSmZDOVI1ZkJQYi9VY2t3?=
 =?utf-8?B?MTZ2OEdORjdjaStYNEhrRG5lbENBUG5vMFBnSHVjN3hTQUZyNnJXWFBqRnhZ?=
 =?utf-8?B?ZWNuTzRMMENpTFBhVHdQNjRhN3ZlMlYwdEpwNUxySW9neThDSit2L1luSnNV?=
 =?utf-8?B?T0lWTk1oUkJVd21GZDlLbDI4bWxIeHRRMk9Hb09JU1VRZzBIL2tTcDVGQTNN?=
 =?utf-8?B?bHkrWTRkQndQRVJTV3UwTHFvemVRNVY2YXpFQ21vdUFtczZTWWtzRmxVQVZM?=
 =?utf-8?B?SFMzL3MzdDhYUFBTeHZmUHNNbWN4UHlXSU1MeFFwRGJmdy9jbzk0dTVKeTBp?=
 =?utf-8?B?bmRRbnRqQWZ1YzRKTjZULyt4RDRVdk1Qd0RMeDRFblBIMFhYVGtiZHhKL29Z?=
 =?utf-8?B?QStIOXhLQUxwZjhqcGRDMnJRMi81bTA2Vkt4eWliZHFyQnJYSG80dGd1UFNU?=
 =?utf-8?B?cllLbVVaSmxCd2crZnV1WmxJbEIxUzBlMmRubi9qaE4xcWV3V016bXBvOExW?=
 =?utf-8?B?VVRBaUpRRk1NR0RMUGRxQ3QxV3AxWDNGakhLV0JuVldaZG9pU1RUeUtlSTZo?=
 =?utf-8?B?MGN6dndKOE41UXNKekF3am1YNWlIelk2cHluamdWZ3BFU1Z3STJtY1diL1ZK?=
 =?utf-8?B?dzluaXZBdkVEbUZKWWJGbnRuVjVCRHg2MUVqTGxsQkhTSkx6bGV5cUp3MGtW?=
 =?utf-8?B?c1UyZEZpMFRFOEVCZ2lvanMya3A0YzlaeW5QVmtjbjdFL3FoQmxJUE1tMFFy?=
 =?utf-8?B?Z2dpcG9JRnhOU2NQdjVDR1ZzaFQ3ZGUwd2tRdlZQV0RmUFB0eTJ2NE0zMGl1?=
 =?utf-8?B?cU5STm1lcS9JZzNha2hzaWtmMjcrZ1pSSElBQmRsVzJlMWxXMnk3b1dTalg2?=
 =?utf-8?B?RDE0eEZ2N3RpREFzeDNKdkR1ajRqdkZRdm0rc280Z0t2UDYwc3FuWUZwaW45?=
 =?utf-8?B?UXlJSlhQcXN0Rnk1YW1QT1owQ0lTdVRyaUVITk1MWW9lRG1PWWUraHVjWE9Y?=
 =?utf-8?B?dWdsWEZlQSt0L0xRSGw5T0hWYmxvQUVQbURVTzJEVWJ6QlIvNVlTVHpEZVpQ?=
 =?utf-8?B?SVVMTmp3YW1tVDJJNFp5K0E1cElrWHJPdFNSb1hXa1Q3R1Jwb0FxSGk5SGVy?=
 =?utf-8?B?M0J3NEhhUkNPdDJSYVMxYnlTWlh4OVdXOGhnb1BCV0ZkYW11d3hrQmJvZmJz?=
 =?utf-8?B?T3BERmFWZjFFSGU1TUxZZlNwOHBIYTJpckZVR3VrRGJrc0R1b1QyREtqQkZK?=
 =?utf-8?B?Mmp6Y3hGT3RLNzc0SkVuWGFENXF2UzdNV1FtOG9jZzFZSDRjTktXMGpESm5o?=
 =?utf-8?B?bnNpTXc0NnU2alJHR3JwZWRaTmQxc0FxUjdEVmVhUlRlM1kzdVVDd2FPNml3?=
 =?utf-8?B?UU1zNDJTRkZZUHRiQXlSazZIamVLMFFGVWFIQlVyWGVwRDdVWnJSa3Buc0dL?=
 =?utf-8?B?R1M1dDdOY3dEcnQ4d3NJaHBRWis5cGlSdkd0U2xMa0t6MjgxNDJ4SU5Yc2hv?=
 =?utf-8?Q?riSZKRK2g/c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWZqclFXVzVYZXpIRHU0YTBZMGhQVytldG9nOUZYSGRrRmtWVHBnaTkyVE5l?=
 =?utf-8?B?QkE3Ykh3U1ZmY1BSOVEwczhNbU1TMjlCeStqem9GSjJBOVJCWjlvWDVZbVJy?=
 =?utf-8?B?MHV2a2c3TWhkQUFsTzhZMHEzckJQTmcvcG40MG9GeW9yOWhjZ3d5OVQ0RnE1?=
 =?utf-8?B?b3Y2UC9YR1Q5M2JnMko0ZmF3NGhyR3hCWkxyNElkNi9hT213b1J4cy80YUNr?=
 =?utf-8?B?SDUySXZ2RWxtV1M2WklYVVBEcXBxZlEwZmh0K2VPVjhhaG5TWDV5TTBhZUZo?=
 =?utf-8?B?akJWWFpFbGRKQUYwRkVHai96cnlzbkhZSXcyYXpDQUxYd3Z0TFhQV0lsVk1R?=
 =?utf-8?B?QUxqUXJoV1NrT3phdTVZZHBrWEhYRnh6ZDZYV2dtS3pMc2lXT1JuZWI0UzVX?=
 =?utf-8?B?WVNhcG40M1RSNStWdnJMTGVxQjJoeWI3SkdnNERJd2syRzJod2g3NjVFb3ZV?=
 =?utf-8?B?bUtyREtvTmtwUGRtWDVCUUUzb2gyNFlTdllsK05WbXdXamV3RGJwM0dnTTE1?=
 =?utf-8?B?MXVRNnQzK2NIZHVQN0loTmFVQU9tSExNRHBGYS9EQ3BDeUdGUnR1K200VWJl?=
 =?utf-8?B?NWtaWm9hMnZ3NFh2TUVYZVN2M0YyNjhXOU5xTnFLeW0vKzlyY3h1M3NQa1hr?=
 =?utf-8?B?Q1QxQmpsTFZMVm9ZOEhpL1NYSEEvSlRCRk5pbVJmeHJFcDdUblRzVEtDc2lk?=
 =?utf-8?B?SStyQW5MSzY2TzNLNktuUklwK05ZTG56c0FWR3liRSs3UmIwaEtCck5oMTU2?=
 =?utf-8?B?clhZZ2VIejBBSzNXK04zMTA0K0hFMTF3dDFkc05GM3l1YzE0czY1RmJGVTFa?=
 =?utf-8?B?N3BPcXFmeXc3MkxXRlBLVjdmZ0d0NUJ4akxZUkppVVpvbjBzSXBwbFIzRHZT?=
 =?utf-8?B?UGtFcjRORklRanUxdWdzelJac2xoVWJ5aW9RZlg2K2VGbldjOFdzTktDTTZw?=
 =?utf-8?B?ZVlLTnJWb1JUWGV6dVpRcUN0NzdSc01QQVdKRXJjTUZIdTBpZ2lSaG5SOWFy?=
 =?utf-8?B?ODN1ZkMwWEF6ZTRFOVBRT2p0cmJUcll4ZktlcXNTcHVnL3g4UXdxQjRIZHZk?=
 =?utf-8?B?TGM0VVFiamFYcXhhRXFOWXVpOExsam5oOGJzV2poRnFQL3lsZWRkVGpLYlZo?=
 =?utf-8?B?M3YxOXhqTjhVWmNoSkg4SUVmZVlaenlUbklaTmlyT0xzNG9rNEs3TkRhR082?=
 =?utf-8?B?WWZldjhBbk1Fa0ovbkFtS3A2bVpPWWY3YnpFZTg4Q2tWb1V4RFNDWHhqbFp5?=
 =?utf-8?B?S2w4ajZJYlhXZUNBMHZZOGdJVGlJdjY0RTBhYWtyMElYOHpMTDlTbTEyYWM0?=
 =?utf-8?B?OXQ1d0NSRDFsdXhvQjhOZGUrVDRnOVIwZ3ZUOGxMcmxFZ0xhQ0VZU0l4NjJW?=
 =?utf-8?B?MHlraWs3c3U3NEQ4M1RWaDI3SG45SEFjV3FIVlNzMWZJZ2tSL2p0S1FoRFk3?=
 =?utf-8?B?MTNBU3l0bExldkJyUmlFbFBPOXRvU0ZpQ3p6WFNGd2xXOVd1VGNmR1dlR0FT?=
 =?utf-8?B?WU5DeUFNbGVUcElGN01FQnF4RnNRQTJuMWI4R3p6UE1TYTVDWjUwSmpwT1pJ?=
 =?utf-8?B?RUk3d3hjSHpzUUV3SkZNZFAxYzFWQkpzb0lPbCsycXRheXpJSTBaUm1jcDNm?=
 =?utf-8?B?TmJRSWxUSjRORXRiMXlVVHhaNUV5N29XeC83NXdFMndDNVIyWldqZFUrM05D?=
 =?utf-8?B?d1JiMnBVUHM0YnVGWHhVclAvYmhRSDlKdy81Qm0ycUk0WERVV3N4SkFLZzVO?=
 =?utf-8?B?U1NmcnExc2IwN3c3VFFEc2xMR0FFZ1EzTVBZSVRnWUoxUEF2TUJuc0lJSGIr?=
 =?utf-8?B?b2VUcVExbk1tdmpDaHJ3cUIzQXVqcXVyUkwwMEVmdWhhNWZpRFhXU0pYYWpt?=
 =?utf-8?B?V20zY2xkbUtiYUdOU2hvWGQxZ1lBU1ErZ0NGTXJLdFBjWlYvNGI4ZlEwaDdV?=
 =?utf-8?B?OWF3aC96YitYdmRVOUN4emMvOVptZEJWY0FrSHVrRW8wTnVrWVBYcHhxNVA4?=
 =?utf-8?B?TVpjTE52a3B6aWdOTVh2SzJxWnlUT0ZaUWE3aVVlaG41TDB6cm0xOVVLd21l?=
 =?utf-8?B?dHFEdTNHUE84N3ZVUmJJWWJ4NmdNQ2tiUWJUT1NuTFZCUjdNUnVDcEtuaG5P?=
 =?utf-8?B?WWloNHlodjhJNCtHQkRENW04WC9vZHYydmYzVUxtaFJaTHRLQnQ5TTc4VTlJ?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <686E9EC1AA9670459F57E2CAECD1F262@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16e3f6e-366d-4b5a-6d8f-08ddfa4e7151
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 03:08:17.1940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9pPOZmTlWg0Bpk6WRg7vlA9wYWOxMQlKK8pm1EK/SSh3K9O19GLuIchzIfC7da1ZQbBp+banaIRYuTbY9hzN7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8666

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
bmcgbGlrZSAic3RydWN0IG1wZnNfbWJveCIgaW4gbWFpbGJveC1tcGZzLmMNCj4gDQoNClRoZSBk
ZWZpbmUgInN0cnVjdCBtYm94X2NoYW4gY2hhblsxXSIgaGFzIHN0eWxlIGVycm9yLg0KRVJST1I6
RkxFWElCTEVfQVJSQVk6IFVzZSBDOTkgZmxleGlibGUgYXJyYXlzIC0gc2VlIA0KaHR0cHM6Ly9k
b2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVyby1sZW5ndGgtYW5kLW9u
ZS1lbGVtZW50LWFycmF5cw0KIzgxOiBGSUxFOiBkcml2ZXJzL21haWxib3gvbXRrLXZjcC1tYWls
Ym94LmM6MjQ6DQorICAgICAgIHN0cnVjdCBtYm94X2NoYW4gY2hhbnNbMF07DQorfTsNCg0KSG93
IGFib3V0IHRoaXMgZXJyb3I/DQoNCj4gLi4uLg0KPiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBt
Ym94X2NoYW4gKm10a192Y3BfbWJveF94bGF0ZShzdHJ1Y3QgbWJveF9jb250cm9sbGVyDQo+ID4g
Km1ib3gsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b25zdCBzdHJ1Y3QNCj4gPiBvZl9waGFuZGxlX2FyZ3MgKnNwKQ0KPiA+ICt7DQo+ID4gKyAgICAg
ICBpZiAoc3AtPmFyZ3NfY291bnQpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0K
PiA+ICsNCj4gPiArICAgICAgIHJldHVybiBtYm94LT5jaGFuczsNCj4gDQo+IHJldHVybiAmbWJv
eC0+Y2hhbnNbMF0gICBzZWVtcyBiZXR0ZXIuDQo+IA0KPiB0aG54DQo=

