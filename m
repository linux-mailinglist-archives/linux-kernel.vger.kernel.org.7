Return-Path: <linux-kernel+bounces-866094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FA9BFEDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9793A4948
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831E1F0995;
	Thu, 23 Oct 2025 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b4YM8B5m";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QINaZq+o"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0881157A5A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761183587; cv=fail; b=pRwBR63UW8pvtV7WV3eCou0olG0xA7ImlYqrNOy7wbDeCxjBQpMXfaQ+UZKanV5LG/n94WUrq9/hsQq5oyDrYA2XJuGoBEf8js+j1f6AO7yT/tJfBdiPrt3YN7zelDAYAAxJ2uoLLY70KGubEsBmnThDxWMDdtqkrmL4TUQrNwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761183587; c=relaxed/simple;
	bh=2lqSHeOWwbZDU/2cb8c+ULNZLr1XhiqIYGsfHEFlNZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1gg/E03QKkwuN6wJgjmuP8KlL6+DNJeUfnsC5MkahFa/U6n2OxamiFGlpuotp2sFsOUuYd2ZIDmdkjDqqh4GZSryVdsgFk70NjkO7yDID63BXu9jfm86w6gmT8t/cgvCr3DGqGCgGHefpxuh0XDTR4ZK+uWoiQpmHkDidXzwJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b4YM8B5m; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QINaZq+o; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1f4470e2afb111f0ae1e63ff8927bad3-20251023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2lqSHeOWwbZDU/2cb8c+ULNZLr1XhiqIYGsfHEFlNZg=;
	b=b4YM8B5mCLKx7ByUyjc+6XrPgI1hSp4qeZyCrzFhIqe59oKDsdYdcWkhvUMO18paYP7l3uAi1MoSG8PPP9f7crBCq+DNN7Gy1ikWRqKl3gYdmG5TJK7YWcPRolz1cYSRghi1Hkg6RcFtmIrh3MSlRsVjYFuCT/hAg0taYbhjwR4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:1d839a0a-0bcb-4512-878c-ecb204379034,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e965f0f0-31a8-43f5-8f31-9f9994fcc06e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f4470e2afb111f0ae1e63ff8927bad3-20251023
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <xion.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 832232688; Thu, 23 Oct 2025 09:39:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 23 Oct 2025 09:39:29 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 23 Oct 2025 09:39:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMWuR7heP8mECplibAJximM3LIhpvxntW/CIjt+bPDl2tvEWuvl2bDWnynHADJsJLDydMZSVxpW8z11dxkTUoMJf3Mon9MfUi97F1gLkEAksE/VO6UVeojo64NwQO15+0aqoiDByr1gUzl7u//0dDNtvbpfxSUM5lFjTvIZ5WfcJEDR1C6r5qHBN3oCDQ0UnwjL/5z25e++jsqtnM5vqeo8RWi0vTeftRPwG//VWP+0AOIF5PhBh4gUjUC6SiOJp93+i1gj18oK3vmjcO2n5MV8jSt72XJSIug64cblr7gYwq6yhCYX9FDyX+iE1RXOG0t6Caz1Yh6yzjNDhbp0Hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lqSHeOWwbZDU/2cb8c+ULNZLr1XhiqIYGsfHEFlNZg=;
 b=oZ4DsizH04ZTfK3qznH9t7fMROSY+AQQs+e61qdEVne8YeeWdUSr4HqStk2oXB89XMW8etnXWCCdvrhQClEFNB9Lf7FSwQcLQoeO6TuUJE6cgSpHwkP8+TJDavWDd5DA9vek5mr3+yFL7ZEEz3nsxdodYzjU6Xp+FwNEsAbe2inBpfBY0V0ZrFCaz1omxWQxViC8SenCCyUJiN5XM09Aar6fI9C1d5tNEItptU5UI9fslIkk2bGLG2fhdKdG63PT0wjb6eY9+Mmhc9IriVlwCAZ1mlC5hwTWWi9voCIS3o9qtH1VfX2+v6oPqRUA1eGvmjq0eJfTXL56+443czptQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lqSHeOWwbZDU/2cb8c+ULNZLr1XhiqIYGsfHEFlNZg=;
 b=QINaZq+oygZXU+Rad6pwvQf9V5v4kM5EoQm/of7BG837Hmdbee6MsNow53NmXXD3reziZeyGyu9NdgkFlXvxkzITlTg2R1tntn9lCL/ihY6Uag0g/NzWUQ9wWmFG8AHheknwGG/gZXyobDZe/FbKxGpKfCbsDQ5etT7bYonvKeg=
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com (2603:1096:101:183::7)
 by KL1PR03MB7040.apcprd03.prod.outlook.com (2603:1096:820:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 01:39:27 +0000
Received: from SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7]) by SEZPR03MB8122.apcprd03.prod.outlook.com
 ([fe80::e130:f417:b0bb:f2b7%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 01:39:27 +0000
From: =?utf-8?B?WGlvbiBXYW5nICjnjovpkasp?= <Xion.Wang@mediatek.com>
To: "omosnace@redhat.com" <omosnace@redhat.com>,
	"stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, wsd_upstream
	<wsd_upstream@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?SHVhZGlhbiBMaXUgKOWImOWNjuWFuCk=?= <huadian.liu@mediatek.com>,
	"paul@paul-moore.com" <paul@paul-moore.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 0/1] selinux: export current_sid API for use in other
 kernel modules
Thread-Topic: [PATCH 0/1] selinux: export current_sid API for use in other
 kernel modules
Thread-Index: AQHcQyVZqEcKDmFbPU2Gdikj+ke3erTNz7AAgABJFQCAANyqgA==
Date: Thu, 23 Oct 2025 01:39:26 +0000
Message-ID: <f85fc1bc2bc72d13dd45f97d3014bd307e481e31.camel@mediatek.com>
References: <20251022072729.14820-1-xion.wang@mediatek.com>
	 <CAFqZXNuPqwfqA23LH8NOG6KM1Nb7WvW77wnpp-vZ5omU40j_qQ@mail.gmail.com>
	 <CAEjxPJ5BWjvDmQ37PPLHrmcTwRnOy6eW_uNoKG=ERZqRMAc3dw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5BWjvDmQ37PPLHrmcTwRnOy6eW_uNoKG=ERZqRMAc3dw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8122:EE_|KL1PR03MB7040:EE_
x-ms-office365-filtering-correlation-id: aa2fdb2b-b7c7-4b4b-1f8a-08de11d500e1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WlZ6OVRzZnEyY1FMT3RSQmpVVVJGVjBTeXhsU2dWNDJhY0tWWjBhd2tyME1m?=
 =?utf-8?B?ZzdpVVg0ZUZpVkpDajBzUlFKTVI4Y0cyc1ZpYzh0Q1cxM2gvTTkwQ2E0UFM2?=
 =?utf-8?B?K3kwUTYrNS9aWXVhSkFWbytOQmpEVVRQWjVLdVNsL3EzZ0dWSUlFV1N1MmJo?=
 =?utf-8?B?ZnYxT045NTBPVEpETFZuV3JHOFprSlJWaDUrQWtFM1QrcFFoa3RHQTczckpW?=
 =?utf-8?B?V1duZHNHQU93UTFJYkRlazIxcHBZVFFWNFFLOFVma0tRS0ZlSENJRXJZVTlm?=
 =?utf-8?B?N3B3bmdBRDFMUitZYytPeFBjelNqUzRVbStNSVRodTdxcDVzMFc4MFQvcTdI?=
 =?utf-8?B?SW9QL0tIT0EwMXVENlBVMTVSOGlRMHVha2piaW04RVpSTkNhaFlFZ3luZEhE?=
 =?utf-8?B?SFdTeDhDQmVMVTk0akNIRjRTT1VZZkp1MkhubkE2T3BiVWZTczdDR0UwTGJw?=
 =?utf-8?B?RTl5VFhSSk9MT1pUd3FMZ2NIN2pBck5CcFV1SEp0cU43ZEFZZ3IvMnlqcnZH?=
 =?utf-8?B?ZG9IY2V2TVd6WUJ5YzUrSnBIMXpVZDF1a2JabUhJOUVSOXNNU24wT3dMWmxR?=
 =?utf-8?B?cnYwNEVYaXZ0bFVUdG9mQ0hoeUdBVkxETUNjODYxN3BLSjYyYWh4dlBwTkk3?=
 =?utf-8?B?YjVJU2daeXJJdE9NRWV0cmxJZzNOSVZlOXkyZ3lKNlZVR3BNL3M1c1NmRWdJ?=
 =?utf-8?B?SFI0d1RvMDRsU2EzT0oyUnVMNjY4cUpXSUdkVVdEcy9IR2VTdWZXWk1qTWpr?=
 =?utf-8?B?T1pWYVR3eTFVaG9RMTNuZnQ0RWF5bGhHUlVmWTVZUUVDSmFwVlRkZzNZWmRX?=
 =?utf-8?B?Z1dnQkF1QmZYTFF0eUVWSSt3KzNONTdBUTU1K2xaSUJpYWY4cTV3dUV0Nkc4?=
 =?utf-8?B?NEF3aGVDVWVicFd1bFpGUUxCNE5ndmROd1g4WUtmRjE4ZVpPbHVPSnJNampT?=
 =?utf-8?B?TzJEcDViZUV4elZSWnU2Z0FPYXZTL296dDhaZEcweDVLNU5HMW01MFA1TndF?=
 =?utf-8?B?c2JTSkNXb0FiTFR1cXluSlhjKzQydEZVU3E3TzgrWXBqdk04V3V1RnNaMXUr?=
 =?utf-8?B?dlZ4VDdYMzlOVE5HL0tWcHZTelJ3bmxxcEZIeXFabkx4RkNRU0lIdGZiZlox?=
 =?utf-8?B?b3ZnNGtXaUp6b1NZRVpBZERGL3E0bmRPN3RrY1FKU0NNOEw4c0pQd1A4SWpT?=
 =?utf-8?B?QjBOT2RwME9ickRjWVduT2Z6NjFtdlRCQ2V3azNJSjJWeWRWZVlxbVZMaFpQ?=
 =?utf-8?B?MUdueVltYmd6QS9lUmlSSzdnWERZSDE0am12Y1U0K3ZySUIwMk9iZmZvcWtC?=
 =?utf-8?B?SG5hZGszblFpUGRiQXN5bU5FYTVmc1U1RlZQZU92cUVUc0Z5eVU5Ukd3eEZH?=
 =?utf-8?B?eHRyT0I1aWFQOEVEYXpwcEZRMUJYSm1KTmNJZ1IyUXREOTNhclUzWDIrTGNV?=
 =?utf-8?B?N2FBbnQvSzJBWlBVOHlXNXc1ckJFcDQ4ZzltSnVMb0JSTEphNXRFampDY1ly?=
 =?utf-8?B?U1BUMGdWWFBvc3p6ZmM0dUg1VFdvWWxrK2J6TXVVcTlZQTNwVmNqU0NHVzhW?=
 =?utf-8?B?UjNjK1cvbngvYjdUZXN3RGtsZldGaUJ1Zkt6WlRXTDJERGRjMlp6ei9wbEdv?=
 =?utf-8?B?N05VU3dFRmY3dWRqY1RRUVJ3WUw0Q3RHQmRhK08zSCtTd1VHNHBaOXUyUUNU?=
 =?utf-8?B?WmVBSUlFamNDbmtkTGllODh0MGFjeEtobXRJc1kwUDYrZldOQUxkWE9tUzEv?=
 =?utf-8?B?YUlmVWhFbW5jWVVyRlducm51VDFvS0ovdVZuVVNwN3dwR0d6b1NmaWZRdTRM?=
 =?utf-8?B?eHRwMHg1SEV3c0ZpNy9xeW1yeVIyMlFoU3Q1bmsvWTJwVDAvOWp4eHBzbks1?=
 =?utf-8?B?R1VBNzRHbGpJNHpOaTlWdVdxNzRzaFJvVFZHUkxMOUpzRTBiZ05EREtYZndp?=
 =?utf-8?B?RWFqUWpud1ZEWDdqcWtJZzhRaVpVd2xxK1JGaG5PcVhodkJ6bVVIbE5hM0ly?=
 =?utf-8?B?enR1K0pjbzhXbU1oNkt0MXNRMFBDbnhHbEwxMnhnakovSUJUMXFhZjM3RnQy?=
 =?utf-8?Q?3F3BIK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8122.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0xRRWtUeGhHVSs4MG1mbGFnelZvaXNVWTJBM2tuUENFeHlISWFJUXhCcXht?=
 =?utf-8?B?NFo4eHh5SDE5M01VOUluaDhjdnhwTUR2ZkxjNzV0M2F0RzVxNTdYZTVNbGhr?=
 =?utf-8?B?aFFna0xXQVh3NWsxVFVwVVcyM3dkeE1UbU04RzlWaExFaGdHQXRIUTZFcXpv?=
 =?utf-8?B?SVNsV3lQR3BxWTg3K21uUlIrZzd6cHVTSENkOUpUZmlCcy9mNmhlRE5HWmRE?=
 =?utf-8?B?YkIwMC9qUDJnSzFKME50R0hRSXZsaDN4T3p3RjhjL0VVY25aRXNQbk1MRGc1?=
 =?utf-8?B?Mms4ZUxaVDdTc3pjVVFsVmhIY3c5dGFVSExxV3RnVkZjUjRFdnl3QjE4WVda?=
 =?utf-8?B?cXBHQjBrbkJZVUtRQmZ2UU03OEFwbVNwcDVLRkcyVlhscnc1eDFWL3NYQjRi?=
 =?utf-8?B?VVBFS2tmZU5RNTEyVXVPQzlSbWJSMmpJWHNneW1YKzF1Rnh6Nm1lZ2FJa0VN?=
 =?utf-8?B?NlJyZFF0cHAyL1FFMVpWOEV2bllnZjJjZ0ttbnRMdjRJdkZRYzB0anQ3NG5p?=
 =?utf-8?B?SXRGVkUzTDhPeFVrZXJUOUpBQmhxYU9MVnpDYTBRL01Ed2FPeU0zY3ErUDhQ?=
 =?utf-8?B?RlM5VURzWDhzMjNNZi9qbmdzUExvSkkzbkwyMVBuTUN3Y1FZN0RFSUpTdlBE?=
 =?utf-8?B?NnBIb2piMmgyT1p4d3ZHMnNWd2JTYWhhd3ptTmZ4dFQ2aTREY1VCOWtCM1dI?=
 =?utf-8?B?R1U0T2h3UFpmaEdRcEtZYjh0M25qSmsrTUtpVkJUY3A3YWxEeFZyYnl3cmEv?=
 =?utf-8?B?ekx6M21IRk9UZURFZlFRR0g3eGlxU29lRzhvOGlZOHpNckQ1LzA4aS9wZmdy?=
 =?utf-8?B?bURmZmhpQ3kzUEpsZ084eGJTUUNSdzN5U2NkRU1QMi84WFRGVXIyQjNCOEk3?=
 =?utf-8?B?Wk16eCsrYzhjdVF4WFg4R1ppeGFyR0xpYVRDU1ovWWk1TnhTYUNmTEtvNC9z?=
 =?utf-8?B?ekFmN2hqdXB4cVNUcmNHbnNEeVViYnk5UmF3Rnk5eW1ZUmVWZ0V5NlkvNHRo?=
 =?utf-8?B?YWYwN25FZ0VxSndCU3F4YnM2SWZrTG5GQ1l3d1NNbDN6MTVXbVNBNDJSeEFP?=
 =?utf-8?B?Z0RESmlCUXo2a1RNV3V5OW10akFZYy9QQU5jQnV0eGdsKzNNT2RaWmNnK0ZI?=
 =?utf-8?B?ejAyYWw4OVpZWkdMWWw2ZFNRR0RIcWhOTWFxRHRoc05xR2ZwMG1EaWh5Vk1Z?=
 =?utf-8?B?bmIwNU9KNHcvZGJRcm1Dc0ZXdXpuS2VEOGxMT1ViSlRCaHlYTEZSSnZ5dTkw?=
 =?utf-8?B?OFFTcUhnQW5jN203YkZiRUI4bW5tR291cFdYTlhZZnhXak1tcUZCZmg1c3lI?=
 =?utf-8?B?RjdpbDFMZU1PdTRxRk0zTHh2T285ZFFDRFdRams5alNYb2E2STRmMm1wOUxK?=
 =?utf-8?B?QXJzYklITk1Kcm5oN3RJS0hlZWM0RUtpT2Y1N3A3OEtsU1RHZVhtRFlCVTF3?=
 =?utf-8?B?NGJnV3lhTFpKL3JWKzdYRTMxR2JnMUtWSWNTUmdTY3lxMnNFUUpvamFSMUF1?=
 =?utf-8?B?VTVlMDA0UzdUSm5DdEpyQTFURk92VE1oQmFFeUdQTlNvYzgzYXNCRDFtM0lt?=
 =?utf-8?B?UGZrQkVLcXl5emUza2tWbzhaKzZVRlFkalpGTTRmMkdTQlFyUEtZY1UraG1S?=
 =?utf-8?B?WDJxUUNoRU5XeVBBY1pyTDJzUk8yc0dhbUIzSWNqdHk1YytIcVhFTmpmczla?=
 =?utf-8?B?ZjU2SFRYdm4wbDZwVDAvZzhEWU44diswQ0FRT1o0TDZFVlVhTWpVallpbGpM?=
 =?utf-8?B?ejE3RWdWVjVaaG1qTXhFcFo3RmdURm5ONzJ5dk5LSnJmRXZpMlhXOEZ4SUo5?=
 =?utf-8?B?OXVmVkYyNXYwclZ4NzlZbXNuUUdQakdJdVlJZndsQ1VGcHl2dVFpN28wbUFD?=
 =?utf-8?B?NFVkbTBBVHo4S2JTOHFYOVBzK2ZSemxZMUZ4ZzFkV1BCU3BUb2JmUUkvUUhq?=
 =?utf-8?B?ZnlMRCtTNlVIeDNPamducysvOGZIdFFkWk9nd1lMTjVFS0EyQWhtOGkxSmdI?=
 =?utf-8?B?ZldFU093M2tVU0hQN1lSZXNkeXVvTjZHVHVlS2trTnZ2VzZVK2w2UXV4TWFF?=
 =?utf-8?B?YVRJV0R6UUVrTmZWQTJUYU9IeTl2dVQ3YUYySXltaytBK016b25kc0lwWFBy?=
 =?utf-8?B?WXdPM2JEeGIxQ0ZvL0QrdEFZbkpaQnNGUk5pOFY1WjA3TGVyNmNxQlhlV3pJ?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F9BADC28A960442991D6274FFBB0965@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8122.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2fdb2b-b7c7-4b4b-1f8a-08de11d500e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 01:39:27.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCy1wBvInlUTb1iiFHYzQFGePbAIv3vszf9Pr/6lSWHlOQ4OjeZYELqj8hxbp3hph6nGYZrv0I+90Wt1U7AeEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7040

T24gV2VkLCAyMDI1LTEwLTIyIGF0IDA4OjI5IC0wNDAwLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6
DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+IA0KPiANCj4gT24gV2VkLCBPY3QgMjIsIDIwMjUgYXQgNDowOOKAr0FNIE9uZHJl
aiBNb3NuYWNlayA8b21vc25hY2VAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24g
V2VkLCBPY3QgMjIsIDIwMjUgYXQgOTo0M+KAr0FNIDx4aW9uLndhbmdAbWVkaWF0ZWsuY29tPiB3
cm90ZToNCj4gPiA+IA0KPiA+ID4gRnJvbTogWGlvbiBXYW5nIDx4aW9uLndhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gDQo+ID4gPiBXZSBoYXZlIGEga2VybmVsIGRyaXZlciBkZXNpZ25lZCB0byBt
b25pdG9yIHRoZSBzdGF0dXMgb2YgdGhlDQo+ID4gPiBBbmRyb2lkDQo+ID4gPiB1c2Vyc3BhY2Ug
d2F0Y2hkb2cuIFRoZSBpbXBsZW1lbnRhdGlvbiB3b3JrcyBhcyBmb2xsb3dzOiB3ZQ0KPiA+ID4g
bW9kaWZ5IHRoZQ0KPiA+ID4gQW5kcm9pZCB1c2Vyc3BhY2Ugd2F0Y2hkb2cgY29kZSB0byBwZXJp
b2RpY2FsbHkgc2VuZCBhICJraWNrIg0KPiA+ID4gc2lnbmFsIHRvDQo+ID4gPiB0aGUga2VybmVs
IGRyaXZlciB2aWEgaW9jdGwsIHNvIHRoYXQgdGhlIGtlcm5lbCBkcml2ZXIgY2FuDQo+ID4gPiBk
ZXRlcm1pbmUNCj4gPiA+IHdoZXRoZXIgdGhlIHVzZXJzcGFjZSBpcyBzdGlsbCByZXNwb25zaXZl
LiBJZiB0aGUga2VybmVsIGRyaXZlcg0KPiA+ID4gZG9lcyBub3QNCj4gPiA+IHJlY2VpdmUgYSBr
aWNrIHNpZ25hbCBmcm9tIHRoZSB1c2Vyc3BhY2Ugd2F0Y2hkb2cgd2l0aGluIGENCj4gPiA+IGNl
cnRhaW4NCj4gPiA+IHBlcmlvZCwgaXQgaW5mZXJzIHRoYXQgdGhlIHVzZXJzcGFjZSBpcyBzdHVj
ay4gSW4gdGhpcyBjYXNlLCB0aGUNCj4gPiA+IGtlcm5lbA0KPiA+ID4gZHJpdmVyIHdpbGwgZHVt
cCBrZXkgcHJvY2VzcyBpbmZvcm1hdGlvbiBhdCB0aGUga2VybmVsIGxldmVsIGFuZA0KPiA+ID4g
dHJpZ2dlcg0KPiA+ID4gYSBmdWxsIHN5c3RlbSByZWJvb3QuDQo+ID4gPiANCj4gPiA+IFRvIGVu
c3VyZSB0aGF0IG9ubHkgdGhlIGxlZ2l0aW1hdGUgQW5kcm9pZCB1c2Vyc3BhY2Ugd2F0Y2hkb2cN
Cj4gPiA+IHByb2Nlc3MgY2FuDQo+ID4gPiBhY2Nlc3MgdGhlIGlvY3RsIGludGVyZmFjZSBhbmQg
cGVyZm9ybSB0aGUga2ljayBvcGVyYXRpb24sIGFuZCB0bw0KPiA+ID4gcHJldmVudA0KPiA+ID4g
bWFsaWNpb3VzIG9yIHVuYXV0aG9yaXplZCBwcm9jZXNzZXMgZnJvbSBzcG9vZmluZyB0aGUga2lj
ayBhY3Rpb24NCj4gPiA+ICh3aGljaA0KPiA+ID4gY291bGQgY29tcHJvbWlzZSBzeXN0ZW0gcmVs
aWFiaWxpdHkpLCB3ZSB3YW50IHRvIGlkZW50aWZ5IHRoZQ0KPiA+ID4gY2FsbGluZw0KPiA+ID4g
dGFzayBieSBpdHMgc2VjdXJpdHkgaWRlbnRpZmllciAoc2lkKS4gQnkgY2hlY2tpbmcgdGhlIHNp
ZCwgd2UNCj4gPiA+IGNhbg0KPiA+ID4gZWZmZWN0aXZlbHkgcHJldmVudCB1bmF1dGhvcml6ZWQg
cHJvY2Vzc2VzIGZyb20gc2VuZGluZyBraWNrDQo+ID4gPiBzaWduYWxzLg0KPiA+ID4gDQo+ID4g
PiBDdXJyZW50bHksIHRoZSBjdXJyZW50X3NpZCgpIGZ1bmN0aW9uIGluIHRoZSBrZXJuZWwgaXMg
ZGVmaW5lZCBhcw0KPiA+ID4gc3RhdGljIGlubGluZSBhbmQgY2Fubm90IGJlIGRpcmVjdGx5IGNh
bGxlZCBmcm9tIG1vZHVsZXMgb3INCj4gPiA+IGRyaXZlcnMuIFdlDQo+ID4gPiBwcm9wb3NlIHRv
IGV4cG9ydCB0aGlzIGZ1bmN0aW9uLCBzbyB0aGF0IHRoZSBrZXJuZWwgZHJpdmVyIGNhbg0KPiA+
ID4gY2FsbA0KPiA+ID4gY3VycmVudF9zaWQoKSB0byBvYnRhaW4gdGhlIHNpZCBvZiB0aGUgY3Vy
cmVudCBwcm9jZXNzIGFuZCBkZWNpZGUNCj4gPiA+IHdoZXRoZXINCj4gPiA+IHRvIGFsbG93IHRo
ZSBraWNrIG9wZXJhdGlvbi4NCj4gPiA+IA0KPiA+ID4gVGhpcyBjaGFuZ2Ugd2lsbCBoZWxwIGVu
aGFuY2Ugc3lzdGVtIHNlY3VyaXR5IGFuZCByb2J1c3RuZXNzIGJ5DQo+ID4gPiBwcmV2ZW50aW5n
IHRoZSB3YXRjaGRvZyBtZWNoYW5pc20gZnJvbSBiZWluZyBieXBhc3NlZCBvciBhYnVzZWQuDQo+
ID4gPiANCj4gPiA+IEkgd291bGQgbGlrZSB0byBhc2sgdGhlIG1haW50YWluZXJzIGlmIHRoZXJl
IGFyZSBhbnkgYWRkaXRpb25hbA0KPiA+ID4gc2VjdXJpdHkNCj4gPiA+IGNvbmNlcm5zIHJlZ2Fy
ZGluZyBleHBvcnRpbmcgY3VycmVudF9zaWQoKSBhcyBhIHB1YmxpYyBBUEksIG9yIGlmDQo+ID4g
PiB0aGVyZQ0KPiA+ID4gYXJlIGFueSBhbHRlcm5hdGl2ZSBvciBtb3JlIHJlY29tbWVuZGVkIGFw
cHJvYWNoZXMgdG8gYWNoaWV2ZQ0KPiA+ID4gdGhpcyBnb2FsLg0KPiA+ID4gQW55IGZlZWRiYWNr
IG9yIHN1Z2dlc3Rpb25zIHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0ZWQuDQo+ID4gDQo+ID4g
Q291bGRuJ3QgeW91IGp1c3QgdXNlIHNlY3VyaXR5X2NyZWRfZ2V0c2VjaWQoKSBvciB0aGUgbmV3
DQo+ID4gc2VjdXJpdHlfY3JlZF9nZXRsc21wcm9wKCk/DQo+ID4gDQo+ID4gVW50ZXN0ZWQ6DQo+
ID4gDQo+ID4gdTMyIHNpZDsNCj4gPiBzZWN1cml0eV9jcmVkX2dldHNlY2lkKGN1cnJlbnRfY3Jl
ZCgpLCAmc2lkKTsNCj4gPiANCj4gPiAtLSBvciAtLQ0KPiA+IA0KPiA+IGxzbV9wcm9wIHByb3A7
DQo+ID4gc2VjdXJpdHlfY3JlZF9nZXRsc21wcm9wKGN1cnJlbnRfY3JlZCgpLCAmcHJvcCk7DQo+
ID4gdTMyIHNpZCA9IHByb3Auc2VsaW51eC0+c2VjaWQ7DQo+ID4gDQo+IA0KPiBJIHN1cHBvc2Ug
dGhlIG5leHQgbG9naWNhbCBxdWVzdGlvbiB3b3VsZCBiZSB3aGF0IHdpbGwgeW91IGRvIHdpdGgN
Cj4gdGhlDQo+IHNlY2lkIC0geW91IGNhbid0IGp1c3QgY29tcGFyZSBpdCB0byBhIGZpeGVkIHZh
bHVlIHNpbmNlIHRoZXkgYXJlDQo+IGR5bmFtaWNhbGx5IGFzc2lnbmVkLg0KPiBOb3JtYWxseSB5
b3Ugd291bGQgaW5zdGVhZCBqdXN0IHBhc3MgaXQgdG8gYSBTRUxpbnV4IHBlcm1pc3Npb24gY2hl
Y2sNCj4gdG8gc2VlIGlmIHRoYXQgU0lEIGlzIGFsbG93ZWQgdGhlIHBlcm1pc3Npb24gcmVxdWly
ZWQgdG8gcGVyZm9ybSB0aGlzDQo+IG9wZXJhdGlvbi4NCj4gQnV0IHRoaXMgdG9vIHdvdWxkIHJl
cXVpcmUgdXNpbmcgYSBMU00gaG9vayB0byBwZXJmb3JtIHRoZSBwZXJtaXNzaW9uDQo+IGNoZWNr
IChpbiB3aGljaCBjYXNlIHlvdSBkb24ndCBuZWVkIHRvIGZldGNoIHRoZSBTSUQgc2VwYXJhdGVs
eTsgaXQNCj4gY2FuIGFsbCBiZSBkb25lIHdpdGhpbiB0aGUgc2FtZSBob29rKS4NCg0KDQpUaGUg
U0lEIG9mIGEgcHJvY2VzcyBjb3JyZXNwb25kcyB0byBpdHMgU0VMaW51eCBsYWJlbC4gQnkgcmVj
b3JkaW5nIHRoZQ0KU0lEIGFzc29jaWF0ZWQgd2l0aCBhIHRydXN0ZWQgU0VMaW51eCBsYWJlbCBh
dCBib290IHRpbWUsIHdlIGNhbiBsYXRlcg0KY2hlY2sgaWYgb3RoZXIgcHJvY2Vzc2VzIGhhdmUg
dGhlIHNhbWUgU0lEIGJlZm9yZSBncmFudGluZyBhY2Nlc3MgdG8NCnNlbnNpdGl2ZSBkcml2ZXIg
bm9kZXMuIFNpbmNlIHRoZSBTSUQgZm9yIGEgU0VMaW51eCBsYWJlbCByZW1haW5zDQpjb25zdGFu
dCBkdXJpbmcgYSBzaW5nbGUgYm9vdCwgdGhpcyBhcHByb2FjaCBlbnN1cmVzIHRoYXQgb25seQ0K
cHJvY2Vzc2VzIHdpdGggc3BlY2lmaWMgU0VMaW51eCBsYWJlbHMgY2FuIGFjY2VzcyB0aGUgbm9k
ZSwgZXZlbiBhZnRlcg0KdXNlci1zcGFjZSByZXN0YXJ0cy4NCg0KDQpUaGlzIEFQSSwNCnNlY3Vy
aXR5X2NyZWRfZ2V0c2VjaWQoY3VycmVudF9jcmVkKCksICZzaWQpOw0KY2FuIGNvcnJlY3RseSBv
YnRhaW4gdGhlIFNJRCBvZiB0aGUgY3VycmVudCBwcm9jZXNzIGluIGxvY2FsIHRlc3RpbmcuDQoN
Cg==

