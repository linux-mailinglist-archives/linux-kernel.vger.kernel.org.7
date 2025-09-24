Return-Path: <linux-kernel+bounces-830526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08EB99EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082A04C771E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07A2FFDE4;
	Wed, 24 Sep 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TPYK4T0d";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uVgnelca"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45600305E00
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717688; cv=fail; b=p2FjN1YDU/GBDfHWYbyRgIjlR5KM9eJ6r/pOL1BG8+hfmNu99nl0QI4tScIhV2oZg8rif00CnY1oetFAKJx3AmA8kfLTuBto/cwuiaQ+l2IeBqcftsh1o+SOcBvkzhwnukBZf2Nndmg844E2m45qGieYenZiJ7i9/qwR0SIhcp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717688; c=relaxed/simple;
	bh=J0RTU4dxH/q1zbRA1gbF5OKMTJxy1tfqB6P5phodNqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ERWz7h5dutlG+oV6H7808m8JWhk1GNZCO3P6sxdpW+rQrrWbJxbiQh4+DUWTZ0eBKa+zJWowgSNYwBUnpT7fx7GERBu7f4neu7PJdhoovi2npSNKMJkoUM41IY/FmDTLOgZTMOaoP9phxCHAP1w196a6GJ6Mmn2PeiO1rd1T0R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TPYK4T0d; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uVgnelca; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c3863372994311f0b33aeb1e7f16c2b6-20250924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J0RTU4dxH/q1zbRA1gbF5OKMTJxy1tfqB6P5phodNqI=;
	b=TPYK4T0dJCoLUfsj7UAg9BSIjK+UhLUQInkFDboHUVeC23lziKwNROrkhl6T+4iALX+2MWVA3O1eyKMq6ce9iWPmfJ3SOnKSdBXFqo7T6f3iU7jxKHh6M/fiLMmOBfaggWOAH1J95bCQBj/mHAclDMrHDel89IDztv1P4DWvfn4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:0387a146-f19f-40a4-8d8a-c7e3d6987225,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:04fca4f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:nil,Bulk:nil,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c3863372994311f0b33aeb1e7f16c2b6-20250924
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1655723649; Wed, 24 Sep 2025 20:41:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 24 Sep 2025 20:41:15 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 24 Sep 2025 20:41:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn4BGlSs49uR/STD7yCqIZpipDH8/9UOLKsGzDkdXxrlIcLOvDlWUzWqkTu0k3fK8NyPvyfSdZBO1xkiyvwBy4Qyib5Hyk3zu6JkE2GMzO8Hm7pSojar5jCb/C0XZaTwXsKmITEAB/OWxO2hCANZ1XbMyifNVWO8EOeZQ1k2omAkjzV7zl6QtVIOaTSplfGonUYV+RBaVuIQ3+qjWtGJ0LAy8Zs4fHyRqcrxe7st/BP2dgiRC8mB70fJwnCKWjzEOUTMJIy9rvtbjQw7ZURzs2duUYEeXxNSXoYhW9rqkpQpNmHM6/s09nJErVAZTtIaZ7YhV6iEew4HY7y/abRzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0RTU4dxH/q1zbRA1gbF5OKMTJxy1tfqB6P5phodNqI=;
 b=k/v38HqDvVq09AgeuX3SPZtgWriADRst5TtxbLRcvODPzMayL34VuUtF2GYtwtksmMd3Y5NTw+Ej0OSypMpq7eYXXjzgdmace9lUx7qmgvqZQHiuQjANKe9n18uldCyT5lkP/VoxsMoR4Zl+Tigjv9okOw/GGjulShH8Ng/EyfsTu69T7FzbquxBsWdiz+W+MK/yOdsKatwdTjImnOXqkD/O5Sr6qzKDxOwdKNFURtZA7LQtabYM3FxJdDz8tQXhVwl3NBfrWVhbFKqea4rgHNkYlOnajCWzzzzg8xMcmvCvnw62qBLpsiNUSkRGsY97XZ7ORAEx4/fPoxy7hNWQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0RTU4dxH/q1zbRA1gbF5OKMTJxy1tfqB6P5phodNqI=;
 b=uVgnelcaoiwoZkkhVCSDYV5WDimcQjNNpVPnmjFEX8TKrztkxAz0r98y3tf0EE9vwa2ORZ3fvQ7C+ihJ5qo0CIuokTELuHxR2YTiCTn4leLvt+MLJIkgV+zQ/omAao8A52MdoQuQI8OKInQraAE7i+8MP4QhJYoNf5NRzhnybVY=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by SEZPR03MB6594.apcprd03.prod.outlook.com (2603:1096:101:76::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 12:41:10 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:41:10 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "ada.coupriediaz@arm.com"
	<ada.coupriediaz@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
	=?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	=?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "andreyknvl@google.com" <andreyknvl@google.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>
Subject: Re: [BUG] arm64: KASAN + KASLR may cause reserved page to be released
 during module loading
Thread-Topic: [BUG] arm64: KASAN + KASLR may cause reserved page to be
 released during module loading
Thread-Index: AQHcBUiCfR8eQIm1sU+Zqxe5d9hbarSE2KcAgB29yIA=
Date: Wed, 24 Sep 2025 12:41:09 +0000
Message-ID: <cb9760e573d57072a28a45014f2c7938c083cdc2.camel@mediatek.com>
References: <6065525d47bf338646d53182b9bbc4a25ccfda82.camel@mediatek.com>
	 <cc9b8e02-e287-40c8-ad9c-34efd5e5e3f6@arm.com>
In-Reply-To: <cc9b8e02-e287-40c8-ad9c-34efd5e5e3f6@arm.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|SEZPR03MB6594:EE_
x-ms-office365-filtering-correlation-id: 007a8cd1-7db7-44ae-0077-08ddfb67a377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SFNqTUJaN1duZzduMHBUT2RPMjgzcHZUR094MzdmOXB5N2I0RFRSUjlzalhw?=
 =?utf-8?B?RU56ZFNORSsyRlN5eE1MYlFQNDMyRklnNXg4RE5XTHJrdnNFNllEYlBDc3JY?=
 =?utf-8?B?Zis4YnArUnhxT0NMUWc2ZDFNN25rSTBFSXhNQmtacWY1RVN3Mk9HZXdaUjJa?=
 =?utf-8?B?aDgvamZ1YllYQ3JGOXU4OWl0Wm1CZ1BMY1k4RUwzazB1L3RWcVdSNEludXF4?=
 =?utf-8?B?cXpEeUdtZ2tlSU5NalB1U1RaZTNlS21hamV0UHk3aGk4amcwWTJXQ2VPbTd6?=
 =?utf-8?B?MFVEc0pFYitOYTdqc20yOCtKMnBWRDVTc1RrcjFrYUZvek5ZbmJHVzJnbXd2?=
 =?utf-8?B?aHh4enFEWWIrWUVWM0txVTVpeGtmdEo0QVVVUTdtS05SWjJ1R0RuQkVXTS9x?=
 =?utf-8?B?dGJrV0EvbXAyY3BXNVRqU05CRW90Q0JLTE5aazVvQ0lRcXJsYjRtVlRNaHpD?=
 =?utf-8?B?U202eHFCL0c5ZVBaYXliczJmRXhQbTdrZ3czWk93ZzFqYTQrTm9nZ2xJSWJW?=
 =?utf-8?B?VHVqcysyWHZiQ05mUHdzeWx6ZnVCZDZocXRhY3RXMU1HK0N1MVJtS0lGdWhi?=
 =?utf-8?B?TTFsQ2pLTW8rSTFGMGM4L1QwamdqaE9wbUlaZVBOckxWNFYvdE9nMVdpTThm?=
 =?utf-8?B?U2IyZXg5ZSt0WFcxbzg5S0Fzc285YTV0a2pBSmVnQzQ3T3hwSFVZaitFRDZu?=
 =?utf-8?B?RjFEakxVUlovMHpyb2E1bjBLR2EwNXcvbG9pWHcxYzUraUFOdG5qQkVMUmRx?=
 =?utf-8?B?TzRGTCt4TlE0Y1IrUG9qeDNBTC9iWURGa0p1UmlrTEhFSnhwYmprcXNwcm9w?=
 =?utf-8?B?OXhWR2w5MnhFOFlPWGoyWW9qUDVvd2p2Zmhkck0yaGVxejg4aktmTGd6OEs3?=
 =?utf-8?B?cWRnbjRhTm1MYjY5MkVTSStiK0VQUzlKWWZlUERpSEtIcmI2cVpDMXZ0ODBM?=
 =?utf-8?B?RW0reXlkRGRpWllyZVkyWFp0YkppM1F2OG40SjV2QUVCdmVsYzdaMExIUUlT?=
 =?utf-8?B?a2V3UmNYRnEycys4NHg4VkE1WnRQZVFqRjF5cHVGNjlBRnNaZlpoZG04Ny9X?=
 =?utf-8?B?TGZEb1ZCbUZ0Y2pjcHR6RUZXcExjR3NDNk9QRXZRTVk4djVzOW9EZmtlQlhQ?=
 =?utf-8?B?U0o3d2JjOWY2Q3VYR1BzaFpwR3NsN1hnM2VwNTlPL1FsOWZKbnFiWlZrbVVS?=
 =?utf-8?B?bUh3K3BSc3NIVHd3eWRuY2hyMTh4TVp0dWhqbEFRcHp0b0s3NSt0NUwxYjdS?=
 =?utf-8?B?S1o2d0pTRWpJSnF2dnI3MVhPRURyaHZNTHJnNCtlbXhjVkVudmVkdG9aLzhp?=
 =?utf-8?B?aWNxZE9TZldVbkhOMGt6alJoR2thSTNiWVVUR1p6OTg1REhWdjMybEQ3amQ2?=
 =?utf-8?B?emY1WFY0YmVCNWRZREFxaVFmTW16cjZLb2JJb0hkRHdJT0tsMjdsb0ljQ0V1?=
 =?utf-8?B?U2lMVUFCNGlEODd3VzJpUXFQV2NWRVh0VnI0YXhMeDM5REFlZm5jaTFLODdL?=
 =?utf-8?B?ZHgwelBNRktaOFhPV0d4OHU0bGl3Uk5jYWdDaTg3Yy8wckFKblVKdks3WlQr?=
 =?utf-8?B?cTBWUGF6dVlLMXlYSVE1TFVjaTc3YVB6WGRWeUNuYmlBSGRjaGNXUE1HL2tI?=
 =?utf-8?B?VUt4MFh5VkE3bnBNeS9FdmxCQzUyajJBTHJ6UUozOUFPRndoS2VKSmZCQjNR?=
 =?utf-8?B?aXEwQTh2TDdCZnRxSDRGSThuNFJnV0tYOG11ZmRWWUEzbGFCSDBESnRoTDRV?=
 =?utf-8?B?S29qbXdUREhhZjRud0RVWGExdGZjSTNiak1obGxlTHlob2tzMW5LUzRNWEQ4?=
 =?utf-8?B?VkZKd3JIWWJBSllsZzJnVmlKUVE0ZFF2K1RtVUJ4YkVwY25IamMrQWxNeXMx?=
 =?utf-8?B?bEJPcFFYZ1gvYVlHUTVSNmliR2QzQjB2RlBuWGFpRkozT3dQdkxGaFhwQXVB?=
 =?utf-8?Q?k7fLCv2vP9GcE5ZieHK6NWrXgWGuCi3E?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGtsN2hGck1iZ2gvUDJ3aWIrc21LVVVVVGRQR25vMTF2a3N6MjZYSXZSbXRH?=
 =?utf-8?B?NmFqWWFSa3FXYjFCOGxRY3V2dFpkc0FKcFZCdkpLVDlsV1FxZ2gyVnU0UXZQ?=
 =?utf-8?B?Y1JxSE9raXVsTDJQOHN5TVBHcHRPY2FzdnFYbjhrT3QwK0FDcEFkeEdGekxE?=
 =?utf-8?B?aDBDYkxiOWNvcEUrQzAyWXRDdTgwU2xPN0ExVXgyNkNuVFNkQlZ5cjM1ZlF2?=
 =?utf-8?B?SHlNSkg4Z05JTTFGV3N6WkRJdERXVFBwV0J1ZVJHcHNiTUlWdlFWSGpoc1BG?=
 =?utf-8?B?azdPYnFNSVRGbXN2VEVOeFNmdXhTRkNMUnZHeEVWeGkydFVPOFAveGQ3V3Vo?=
 =?utf-8?B?MHRQNXNJT3NNRWIrU3QxQVhDQ0FHYkk2Q05sWmZSVno1OXJOVEwzeEQ3REFH?=
 =?utf-8?B?VmZkZnNCRDZBc0J4Y1VzY3VZTVgwdW9jQ3FmTmF5dGJMbkhaakxadUYvWnlH?=
 =?utf-8?B?SnM4aUhTelFCaWRwWW1ZU1YwMWhHdFpZK0ZCZWhNRUwxZjdwOXppWTg2dnVh?=
 =?utf-8?B?emJ2eGU1cExlay81ODZ6SzUreW1oZkE1UllRaWd4TlBWOCtqcnhOM0dFVCt6?=
 =?utf-8?B?TzJmdXBxaHMyNjB0Q3g4dHdBNXFvc1hjbjV2QUNBZnE3TERSVWNRRlJ1NERC?=
 =?utf-8?B?VzJLQU5Tekdxb1hVeldYVkFKVzdrTU44dElwTUNVSXY3YWJET3JYZFIxcmNt?=
 =?utf-8?B?d2QvUFc1NW81U1BzampZc1RJb0ZZbHp5RENwaTRqalB0KzhCTHB6MWlHYUph?=
 =?utf-8?B?YmRicDVTcXQwQ2tYenYyWHhSNVkyMVJibU1CM2JLM002dElEcHJraUpkMGlJ?=
 =?utf-8?B?eHQzSFdHeFphRmxCamxTbjdvNkFwNy9pdjAzdk9KZVVpRTIwc1E2ZlBlMmFo?=
 =?utf-8?B?OCt0L0lIMnpDaDFXRDMvVTR6RTV6dGpmWE1KTHhTWHl5eVlTelF3WFQzQlFz?=
 =?utf-8?B?TjhleWZDVnBZdk5GWG9tSGk0UHAyWnMxQWxwUTFXRytIRnM0Q01rSUwvOXFI?=
 =?utf-8?B?R3djbkovT1RpdU9MN2paRkR6NTd6Ly9xVmZ3Z0RhSVp0WEdnbHFIY3BlQkQy?=
 =?utf-8?B?SXFUR2xYeFN0Z3VuZVFZVDJublczampFdlNvbHhrckJZb1lQZU1jNE1hYXI3?=
 =?utf-8?B?RVRzUitRdUJOR0NWMGIrYnI4NnpiNHdzR1p5SXhteVVvbVloMFNwdUJjSlJq?=
 =?utf-8?B?S0ZYYlZGVXk4VUFlZ2dlWS9UYS9OT2ZOWEdMd2VWeGhZeHR0OHltOFM2YXVF?=
 =?utf-8?B?NnlNUC9DeStZaG5vQkJpbVZMQUhVaVJickJtd2ZrTzB0cVc0T3c5UEVVQUV6?=
 =?utf-8?B?Z05TaW9PakJWckRqdmVkRVBxZkU0WWphbTVSYWZPUXc4ZDVCaVVwWjVxNlhw?=
 =?utf-8?B?c1JpYW92TjMrTHlXc0lJM1pNSWMybVE4ZjhHODdWRjM0elYyQ3pTZkVJVlBs?=
 =?utf-8?B?cTJZeEhGc2VUTmoxSGhBTWxBbWtFR2s0ZFRtNFJ2MmtyUDVNYjFxTjlmTTBR?=
 =?utf-8?B?VVVtekI5V0w5WTFXcTQ0cFB6c0Z1aU51ZUlObklmZXUzcGpXeFJ5eTFuRGZ1?=
 =?utf-8?B?anFERUQ2azhUbHpTMStsbUdodHlSR21vUXI0b2ROekh0NFpIWFFkSEx1WVNp?=
 =?utf-8?B?cVJwTnRXeEFZb0tuYVlsTGw1OVJJU21FbjhrZjJjZlgwYlN2RFV5QjNuZkI3?=
 =?utf-8?B?SHBmc0xRaXlzLzB3WmhqL1ZHYTcrYTFDMXdTdys3VEF0ZzlkVFRrT2tFL2Ru?=
 =?utf-8?B?NVBhNzFjS1NFR1NENkpwbE41dFdVWkNSKzczN1VwcjBOV3l2OVJQY2FZSmc3?=
 =?utf-8?B?Y2s1c2p0Ym1iVk5zYU1MUnFRZTNTSGZrSk9lQi9yUW9SVXJSdjhwc2tsZ0sv?=
 =?utf-8?B?ZTdMK3FueFcvMHRqajZ0ZUh5Tm1pc0FBeFgvOWtKU01CZGEzMnBuQm5vdWUv?=
 =?utf-8?B?ZlI4NERIWkhlVDhsRjlJN0l5RUlJNm50azlFKzh2MGhVbFMvRVpPMkFkODd5?=
 =?utf-8?B?KzFGWFV0a1J4V0E3RUFkRDZIY2RSRmtGbC8zZGR5OWhCVzJKeWxIaFR4U05X?=
 =?utf-8?B?aHR1WDBkNGhudUp1YkwyaXdMSjMyVEpVTmkyMUhJRUFNZ0M3Nng2b1RZWFpq?=
 =?utf-8?B?MEdZSEhwUGk5NEJwUzd1M3hPY1REbkhWWFNSdFk0TXdnTXF0bnFNNjlUNGFw?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04312C64E168014CBA53A1820B4802E0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007a8cd1-7db7-44ae-0077-08ddfb67a377
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 12:41:09.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSnqVu7fz1ZSCPgAe6rGf7BB077wWL1tExgRhGxr9fTTixAZItxBtnPINMQAsNCrdi2QKAqfuJmdcLicppdZgIC9IvcKZpM1FjYq+ABrKzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6594

T24gRnJpLCAyMDI1LTA5LTA1IGF0IDE1OjMwICswMTAwLCBBZGEgQ291cHJpZSBEaWF6IHdyb3Rl
Og0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IE9uIDA0LzA4LzIwMjUgMTU6MDMsIFF1
bi13ZWkgTGluICjmnpfnvqTltLQpIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFdlIGhhdmUg
ZW5jb3VudGVyZWQgYSBrZXJuZWwgcGFuaWMgb24gYXJtNjQgd2hlbiBsb2FkaW5nIG1vZHVsZXMN
Cj4gPiB3aXRoDQo+ID4gYm90aCBLQVNBTiBhbmQgS0FTTFIgZW5hYmxlZC4NCj4gPiANCj4gPiBL
ZXJuZWwgdmVyc2lvbjoNCj4gPiA2LjEyDQo+ID4gKGFsc28gcmVwcm9kdWNpYmxlIG9uIDYuNi1i
YXNlZCBBbmRyb2lkIGNvbW1vbiBrZXJuZWwpDQo+ID4gDQo+ID4gQ29uZmlnOg0KPiA+IENPTkZJ
R19LQVNBTj15DQo+ID4gQ09ORklHX0tBU0FOX0dFTkVSSUM9eQ0KPiA+IENPTkZJR19LQVNBTl9W
TUFMTE9DPXkNCj4gPiBDT05GSUdfUkFORE9NSVpFX0JBU0U9eQ0KPiA+ICMgQ09ORklHX1JBTkRP
TUlaRV9NT0RVTEVfUkVHSU9OX0ZVTEwgaXMgbm90IHNldA0KPiA+IA0KPiA+IFJlcHJvZHVjaWJs
ZToNCj4gPiB+NTAlIG9mIHRoZSB0aW1lLCB3aGVuIGxvYWRpbmcgYW55IG1vZHVsZSB3aXRoIEdl
bmVyaWMgS0FTQU4gKw0KPiA+IEtBU0xSDQo+ID4gZW5hYmxlZC4NCj4gPiANCj4gPiBUaGUga2Vy
bmVsIHBhbmljIGxvZyBpcyBhcyBmb2xsb3dzOg0KPiA+IFsuLi5dDQo+ID4gQ29tbTprd29ya2Vy
LzQ6MSBUYWludGVkOiBHwqDCoMKgwqDCoMKgwqDCoMKgIE9FwqDCoMKgwqDCoCA2LjEyLjIzLWFu
ZHJvaWQxNi01LQ0KPiA+IGcxZTU3ZjBlNTk5NmYtNGsgIzEgZWVlODM0YTU3OTg4N2MwZjk3ZDY5
NmQzMGM3ODYyMzNmNGZiZmNkZg0KPiA+IFsuLi5dDQo+ID4gDQo+ID4gSWYgSSBkaXNhYmxlIEtB
U0xSLCB0aGUgaXNzdWUgZG9lcyBub3Qgb2NjdXIuDQo+IFdpdGggdGhlIGNvbnRleHQgcHJvdmlk
ZWQgSSB3YXMgbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZQ0KPiB3aGVuIHRlc3Rpbmcg
ZGVmY29uZmlnICsgZ2VuZXJpYyBLQVNBTiBvbiB0aGUgZm9sbG93aW5nIGtlcm5lbHMgOg0KPiAt
IHY2LjE3LXJjNA0KPiAtIHY2LjEyLjIzIFVwc3RyZWFtDQo+IC0gdjYuMTIuMjMgQW5kcm9pZFsw
XQ0KPiAtIHY2LjEyLjIzIFVwc3RyZWFtLCBjb21waWxlZCB3aXRoIExMVk0NCj4gLSB2Ni4xMi4y
MyBBbmRyb2lkWzBdLCBjb21waWxlZCB3aXRoIExMVk0NCj4gDQo+IChJIHRyaWVkIHRvIG1hdGNo
IHRoZSB2ZXJzaW9uIHRoYXQgYXBwZWFycyBpbiB5b3VyIHRyYWNlKQ0KPiANCj4gSSB0ZXN0ZWQg
b24gYm90aCBRRU1VL0tWTSBhbmQgaGFyZHdhcmUgKEFNRCBTZWF0dGxlKSwgYnkgbG9hZGluZw0K
PiBhbmQgdW5sb2FkaW5nIGFuIG91dC1vZi10cmVlIGtlcm5lbCBtb2R1bGUgcmVwZWF0ZWRseSAo
YW4gQVBGUw0KPiBkcml2ZXJbMV0pLA0KPiB3aXRoIG5vIGlzc3VlcyBvbiBlaXRoZXIgZm9yIGFs
bCB0ZXN0ZWQga2VybmVscy4NCj4gPiANCj4gPiBXZSBhcmUgbm90IGNlcnRhaW4gd2hpY2ggc3Bl
Y2lmaWMgcGF0Y2ggaW50cm9kdWNlZCB0aGlzIGlzc3VlLCBidXQNCj4gPiB3ZQ0KPiA+IGhhdmUg
Y29uZmlybWVkIHRoYXQgaXQgZG9lcyBub3Qgb2NjdXIgb24gdGhlIEFuZHJvaWQgY29tbW9uIGtl
cm5lbA0KPiA+IDYuMQ0KPiA+IFRoZSBwcm9ibGVtIHdhcyBmaXJzdCBvYnNlcnZlZCBhZnRlciB1
cGdyYWRpbmcgdG8gNi42LWJhc2VkDQo+ID4ga2VybmVscy4NCj4gPiANCj4gPiBBbnkgc3VnZ2Vz
dGlvbnMgb3IgZ3VpZGFuY2Ugd291bGQgYmUgYXBwcmVjaWF0ZWQuDQo+ID4gVGhhbmsgeW91Lg0K
PiBUaGVyZSdzIG5vdCBtdWNoIGluZm9ybWF0aW9uIHRvIGdvIG9mZiBvZiBoZXJlLCBteSBxdWVz
dGlvbnMgd291bGQgYmUNCj4gOg0KPiAtIEFyZSB5b3UgYWJsZSB0byByZXByb2R1Y2Ugb24gYW4g
dXBzdHJlYW0ga2VybmVsID8NCj4gwqDCoCAoQmUgaXQgZnJvbSBrZXJuZWwub3JnIG9yIGEgImJh
c2UiIEFuZHJvaWQga2VybmVsLCBsaWtlIFswXSkNCj4gLSBBcmUgeW91IGFibGUgdG8gcmVwcm9k
dWNlIHVuZGVyIHB1YmxpY2x5IGF2YWlsYWJsZSBlbXVsYXRvcnMgPw0KPiAtIEFyZSB5b3UgYWJs
ZSB0byByZXByb2R1Y2Ugd2l0aCBzcGVjaWZpYywgcHVibGljIG1vZHVsZXMgPw0KPiDCoMKgIChT
b21ldGhpbmcgYXZhaWxhYmxlIGluIERlYmlhblsyXSBmb3IgZXhhbXBsZSkNCj4gLSBXaGljaCBj
b21waWxlciBhbmQgdmVyc2lvbiBhcmUgeW91IHVzaW5nID8NCj4gDQo+IEl0IGlzIGEgYml0IG9m
IHdvcmssIEknbSBhd2FyZSwgYnV0IGdpdmVuIEkgZGlkbid0IG1hbmFnZSB0bw0KPiByZXByb2R1
Y2UNCj4gdGhlIGlzc3VlLCBpdCB3b3VsZCBiZSB1c2VmdWwgdG8gaGF2ZSBhcyBtdWNoIGluZm8g
b24gdGhlIGNvbnRleHQNCj4gc28gZWl0aGVyIHdlIG1pZ2h0IGJlIGFibGUgdG8gcmVwcm9kdWNl
LCBvciB5b3UgbWlnaHQgYmUgYWJsZSB0bw0KPiBwaW5wb2ludCB0aGUgc291cmNlIG9uIHlvdXIg
c2lkZSBhIGJpdCBiZXR0ZXIgIQ0KPiANCj4gSSBoYXZlIG5vdCBzZWVuIGFueSBvdGhlciByZXBv
cnRzIHNpbmNlIHlvdXJzLCBub3IgZGlkIEkgc2VlIGFueQ0KPiBwYXRjaC9maXgNCj4gdGhhdCBz
ZWVtZWQgcmVsZXZhbnQsIHNvIEkgZG9uJ3QgaGF2ZSBtdWNoIG1vcmUgdG8gc3VnZ2VzdCBzYWRs
eSA7DQo+IG90aGVycyBtaWdodC4NCj4gPiBCZXN0IFJlZ2FyZHMsDQo+ID4gDQo+ID4gDQo+ID4g
5p6X576k5bS0IChRdW4td2VpIExpbikNCj4gPiBRdW4td2VpLkxpbkBtZWRpYXRlay5jb20NCj4g
VGhhbmtzIGluIGFkdmFuY2UsDQo+IEJlc3QgcmVnYXJkcw0KPiBBZGENCj4gDQo+IA0KPiBbMF06
DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2FuZHJvaWQuZ29vZ2xlc291
cmNlLmNvbS9rZXJuZWwvY29tbW9uLyovcmVmcy90YWdzL2FuZHJvaWQxNi02LjEyLTIwMjUtMDZf
cjVfXztLdyEhQ1RSTktBOXdNZzBBUmJ3IWpkYVVYN0Y4NUZ2WkpxWFgzVWh2NUp0VWJCdFZTMUox
S0ctV1k2b2REY0tmRGpnSkVHeUNURE1VSU4xRFZoOHVUSm4wLXZlMW4yRWpUQUExMW5zTFhpdDF0
Y2lhJA0KPiBbMV06DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2dpdGh1
Yi5jb20vbGludXgtYXBmcy9saW51eC1hcGZzLXJ3L19fOyEhQ1RSTktBOXdNZzBBUmJ3IWpkYVVY
N0Y4NUZ2WkpxWFgzVWh2NUp0VWJCdFZTMUoxS0ctV1k2b2REY0tmRGpnSkVHeUNURE1VSU4xRFZo
OHVUSm4wLXZlMW4yRWpUQUExMW5zTFhtVVV2Tml3JA0KPiBbMl06DQo+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3BhY2thZ2VzLmRlYmlhbi5vcmcvc2VhcmNoP2tleXdvcmRz
PS1ka21zJnNlYXJjaG9uPW5hbWVzJnN1aXRlPXRyaXhpZSZzZWN0aW9uPWFsbF9fOyEhQ1RSTktB
OXdNZzBBUmJ3IWpkYVVYN0Y4NUZ2WkpxWFgzVWh2NUp0VWJCdFZTMUoxS0ctV1k2b2REY0tmRGpn
SkVHeUNURE1VSU4xRFZoOHVUSm4wLXZlMW4yRWpUQUExMW5zTFhrel90ZWc0JA0KPiANCg0KDQpI
aSBBZGEsDQoNCldlIGhhdmUgcm9vdC1jYXVzZWQgdGhpcy4NCg0KVGhlIGlzc3VlIGlzIGNhdXNl
ZCBieSBhbiB1bm1hcHBlZCBnYXAgaW4gdGhlIGFybTY0IGtlcm5lbCBzZWdtZW50LA0KaW50byB3
aGljaCBtb2R1bGUgYWxsb2NhdGlvbnMgb2NjYXNpb25hbGx5IGxhbmQuDQoNCjEuIG1hcF9rZXJu
ZWwoKSBsZWF2ZXMgW190ZXh0LCBfc3RleHQpIHVubWFwcGVkIFswXSwgc28gdGhpcyBnYXAgaXMN
CnN0aWxsIGF2YWlsYWJsZSBmb3IgX192bWFsbG9jX25vZGVfcmFuZ2UuDQoyLiBHZW5lcmljIEtB
U0FOIGluaXRpYWxpemVzIHNoYWRvdyBzdGFydGluZyBhdCBLRVJORUxfU1RBUlQgKD0gX3RleHQp
LA0Kc28gaXQgY3JlYXRlcyBzaGFkb3cgZm9yIHRoYXQgdW5tYXBwZWQgZ2FwIHVzaW5nIGVhcmx5
IG1lbWJsb2NrIHBhZ2VzDQooUGFnZVJlc2VydmVkKSBbMV0uDQozLiBUaGUgbW9kdWxlIGV4ZWNt
ZW0gcmVnaW9uIGlzIGFib3V0IH4xMjhNQjsgdGhlIGtlcm5lbCBpbWFnZSBzaXRzDQppbnNpZGUg
dGhhdCByZWdpb24uIFRoaXMgbWVhbnMgZXhlY21lbV9hbGxvYygpIGNhbiByZXR1cm4gYSBWQSB3
aXRoaW4NCltfdGV4dCwgX3N0ZXh0KS4NCjQuIF9fcHVyZ2Vfdm1hcF9hcmVhX2xhenkoKSBkZXBv
cHVsYXRlIHRoZSBzaGFkb3cgKHJlc2VydmVkIHBhZ2VzKSwNCnRyaWdnZXJpbmcgdGhlIEJVRy4N
Cg0KS0FTTFIgaXMgbm90IHRoZSByb290IGNhdXNlLCBidXQgaXQgaW5jcmVhc2VzIHRoZSBoaXQg
cHJvYmFiaWxpdHkuDQogDQpJIHdhcyBhYmxlIHRvIHJlcHJvZHVjZSB0aGlzIGlzc3VlIG9uIHVw
c3RyZWFtIGtlcm5lbCAoTGludXggNi4xNy4wLQ0KcmM3KSB3aXRoIFFFTVUgKHZlcnNpb24gNS4y
LjAgKERlYmlhbiAxOjUuMitkZnNnLTl1YnVudHUzLjMpKS4NClRoZSBrZXkgaXMgdG8gZW5zdXJl
IHdlIGFsbG9jYXRlIHRoZSBleGVjbWVtIGludG8gdGhlIFtfdGV4dCwgX3N0ZXh0KQ0KaG9sZSBh
bmQgdGhlbiB0cmlnZ2VyIF9fcHVyZ2Vfdm1hcF9hcmVhX2xhenkoKS4NCg0KUmVwcm9kdWNlIHRo
ZSBwcm9ibGVtOg0KMS4gVGVtcG9yYXJpbHkgaGFyZGNvZGUgZXhlY21lbV9hcmNoX3NldHVwKCkg
dG8gc2V0IG1vZHVsZV9kaXJlY3RfYmFzZQ0KPV90ZXh0LCBzbyBtb2R1bGUgYWxsb2NhdGlvbnMg
ZmFsbCBpbnRvIHRoZSBob2xlLg0KMi4gQ09ORklHX0RFQlVHX1ZNPXkgaXMgYWxzbyByZXF1aXJl
ZCB0byBtYWtlIHRoZSBlcnJvciByZXBvcnQgdmlzaWJsZS4NCjMuIFRoZW4gaW5zbW9kICYgcm1t
b2QgKGFueSAua28gZmlsZSkgd2lsbCB0cmlnZ2VyIHRoZSBwcm9ibGVtLg0KDQpJIHBsYW4gdG8g
c2VuZCBhIHBhdGNoIHRvIGV4Y2x1ZGUgW190ZXh0LCBfc3RleHQpIGZyb20NCmthc2FuX2luaXRf
c2hhZG93KCkuIEluIG91ciB0ZXN0aW5nLCB0aGlzIGZpeCB0aGUgaXNzdWUuDQoNCg0KVGhhbmtz
IQ0KUXVuLXdlaQ0KDQoNClswXTpodHRwczovL2dpdGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxv
Yi9tYXN0ZXIvYXJjaC9hcm02NC9rZXJuZWwvcGkvbWFwX2tlcm5lbC5jI0w4MQ0KWzFdOmh0dHBz
Oi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9hcmNoL2FybTY0L21tL2th
c2FuX2luaXQuYyNMMzA5DQoNCg0KIA0K

