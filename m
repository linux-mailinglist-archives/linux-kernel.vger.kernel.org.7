Return-Path: <linux-kernel+bounces-788590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EEBB386E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC807C33C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63732D0C91;
	Wed, 27 Aug 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P5JLPriU"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A820258A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309635; cv=fail; b=mUOaLDP+ScHjNHcgNz0v1VLASkGM0mYSebb1ztwt5VULkCwgDSRoz3etpk0s1wj+ub/00qZemaWpBus6PhGgeWFHYFhR4uzVeAnbbBAVRQEDUVq5rGzEdtPWdOPAV5o68VaMCP01NrYaEuZ+6Vtx/GPyzk708Idiz47J7lhGg/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309635; c=relaxed/simple;
	bh=B4V7esmztU5ChXE3k7/PuFSlreCXa+h9OR3gsJzJz4A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JeN68DU0Vd1MoShNSHXijyQk9ixtyMECGDa3LWJJ1e+9jl9aZ7lNJ+w/m6czJlPMYKvcFg4zlMiwZamQUqqXc2N52IvBo6IOq2qz7LNnrOdWQa9KzOWkqx1kVHwLceK3moEiVkobi5zo6ZMTvXPZmWYFOSkaE2l5EU9unmXOn1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P5JLPriU; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6kTy6cLup3QIUgkBaxkWpyyLWi6tsjq4Kecs6OlDsKyurOi/GS1nNB0r5xs3bE8uN6vjdztLqqFtQBX85w3v5z5EzCVrRpTYJRaW67sktuFs7e6AwQ2K7ezG+F699eeSj3e06e+35buPicHRqAJpGoAf2yHetjIjzw4RDbKTyeNEMQ1cXg/MVHVGfKQK5PIY1t3Shg6oYNZ6kcGDWeDVgjL2pilgbgG/Q9QhPCKhO6BVTDmJ1LYkSr1UwrwocwfLaU49qIiOZ8zd+fLAApt0X3fjaUPlKSO8UT9bWU6JUgB7rXyFhDzb49J8fK0tio32e4dRPex7+Y8JaJGpM+1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4V7esmztU5ChXE3k7/PuFSlreCXa+h9OR3gsJzJz4A=;
 b=WwdQ+WLCpfVOfKfes/3hacOqKDwvM2HLXWB7dtLM1iYn9E3HFEsz9EhUKt1U80EkHLlwhMTdPShYaOewNA5VqvLUzYhaqII5BYV7DsRXmGWgv3ysR5pZ51AUOAVfo+o56AkO8ipWWf9awK3Nr6OfVmT7rChfZZb1rH3he7LR7tvVgo1vqr1jhCoq2FhzNxJcyX6id2JQntrfbxU15H84ECGGllgFEqWSfOxYM0vze/iRxk4LCBLOj2lA5UkOJEUiH4pqbLl2XVjKT15hdBcItB6KENOajkN1Ujk19iYJVStduMd4JjXgRQ5FEs3RR5pVgj0KVWzUPYTlSVrxtxquoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4V7esmztU5ChXE3k7/PuFSlreCXa+h9OR3gsJzJz4A=;
 b=P5JLPriUkfbH6np3BQpZERNd/D/uUKndf5KsuMOCXqCOxXSsLUFsmny43RG6WOKTpmFnBfYM3HX4IOcg85s7IQnFHAp4dWjfm/x4zpXOBy6OG2mE7YrDk/PgT1MDgXhYEhHBQf0HD0AM8gQk1FMxW5wNnJqhsTkb1/uLwR1WxJk=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 15:47:10 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:47:10 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Topic: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Index:
 AQHcEmNJ5LXItfJ3EEGTlLKvZSsitbR2VbgAgAAKGoCAADDXIIAABpWAgAAAcnCAABOMAIAAAq2A
Date: Wed, 27 Aug 2025 15:47:10 +0000
Message-ID:
 <LV3PR12MB9265ABD1B81D759A618A20029438A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
In-Reply-To: <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T15:43:32.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA1PR12MB7760:EE_
x-ms-office365-filtering-correlation-id: 8cf46529-e186-40b2-4264-08dde580fc54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RjZBTTl6MFIzUnROc2pSNjRVbG42NmlEZW5UeTExRThjaFpQK3lxMVNkc3cx?=
 =?utf-8?B?NThNelNoWmZ3TkRZQ2laMGVTL1ltK2J3RDFuMDY0a2p2QkovYmtoaTZ3Sndw?=
 =?utf-8?B?MGdvMkV0bGZuQVUzSzQ5UUk3QmtWRVE2emozU0Q2QTVzZWk4aUN1WHR4SDVG?=
 =?utf-8?B?eWxHbm1EVUJQYjQ4WCt0ZzBkSEhiYnpvM0pxN0FsbklCTWJHNkszSzBLU0kv?=
 =?utf-8?B?UHphQUs0b085SllnRnF5UnQ4NU8rQks2QkUvYXNNRnNzanJTUDVZWFRKNUJ0?=
 =?utf-8?B?OFRuditDSkMrR1B3Wi9HUkl2ZVIwOHU5WHRVMEltLzg5eHJ5ckJmTWZ6L01t?=
 =?utf-8?B?TGh5UHdLVUpGNUVON3Q4dXdEY0F6N3hieGo5WlIyNHhxMUY0RnpUaWNKbW5j?=
 =?utf-8?B?V05jU3VCNC9LL0pma0NCb0ZraWwyTHhaN05CREk3UXIzOVdNTkgwTWpTNUYr?=
 =?utf-8?B?TFN3RnBzcStKYmpSaDNHa1dLK0tZNmhBdm9RNFgxWkZMTjBxcWhSQ1pxK0Jy?=
 =?utf-8?B?bnhpcG03aHQreEt4N2ZTcmVubk1DbVRpbzFWcTRuYU9CejNLaDdHa0FyNkJo?=
 =?utf-8?B?cjRwc3RXYjBXeDE0Y3ZOK2Q1K0JEUTFOOGl1L1JhSWN0bDJHWWt2YXJaWm90?=
 =?utf-8?B?UVVreW00eUtLVDMyejRMR3hUanNtd1FFS3IxK1R6TldMVUk2ZEt0ZytmTWxu?=
 =?utf-8?B?U2RicENoZXlWZTNoQ2FUbE9RTU43NzkwZnFQcFduWUZMK1FzRWM2dnFjMG1p?=
 =?utf-8?B?WkRISWpTZ0F5M1pHVml1Q3docS9td1BhTlNqSWY3bit5dnlkWEFlc3IxQVdJ?=
 =?utf-8?B?dkw2TUpZUEhJUDJJMkJ4V0JZcTgxdWh6aXRsYjVLT3laSTRMSDgyeTN0RUZk?=
 =?utf-8?B?QVpvS1BsdThmUEVDMDF4NTgzM0FQQlZMYzhROTdmaC9wU0VJbXU3QitkOVZo?=
 =?utf-8?B?T1Q5NklSOGNaVUNHRlg3RDdUYUxkMEZVRTdoZlpKWW9vTDNacUlsSmVYVlR5?=
 =?utf-8?B?a09IcklXUXppeG5OWjB4ZFZvMlZvZ2Zvb243MWp2aWpydTUyYzRrUEtNNU9R?=
 =?utf-8?B?cWRFbkdqQ1Jxa0VCR2JqSEhqRUlocXRqSk1iYlA3M3ptcStoWVA4cHRVKzhV?=
 =?utf-8?B?YStMTElVTzhVcmdqdk95Ym0xdEVJMjJaMmgwWHJ1SHRpcWowRk9hcEYzcDY5?=
 =?utf-8?B?di9OUUE4SFNob0QraWV3Ymh4RkVoSFlrU0dGaE9Kb1Fvek9NTm1YQ0NsRHJY?=
 =?utf-8?B?b3dzTVppemFrWFlyald6d0ZRK1djSXVRNWUxdnZUK0VoSDhVZzVmbG5BbWZm?=
 =?utf-8?B?Z1ZwS1lDWG5QTXoxakNHdnZjUEdmdk96czhBN1FJakdtVEtHZmFiMnhiMVFC?=
 =?utf-8?B?MTdvRnkreGRnMHJCb25DTW00YTdHV3JqNjcwRGNxUGFuNEs1bmJpZW1jeldY?=
 =?utf-8?B?emM5aEt2b1E3bGJGaEkxY1gvNDhVQjNRMk9IbGtKdWxucU83RFU3VytEN0tn?=
 =?utf-8?B?WndHV0dyN29UMzVyR20xSExCK3Q1ZGlyd0tnV0dwMms0cEtQUy9RbU5GTHpm?=
 =?utf-8?B?MWZNK1M5TjVZSXlrdng4bXdTaU5kS29HdlVjVlRkWkh6Q3drOG1SVDJvTlhq?=
 =?utf-8?B?WUVkZmk0RE4zK1d0akExRGtLLzZ5czBaMXI0WEdCL1hlM0FGYVRrVkNXQlkz?=
 =?utf-8?B?UTRkQjRiSTRIZzl0VWNhYTJtd2RUNzlYdVhWTU5ORmNIVWs2YjE2Z2pmbEEw?=
 =?utf-8?B?U2ZBTTZ4RXdDcjFOcnZxVTNLTUUxSWM0QnN6bFBuNmFMY240UTljUHA5MExv?=
 =?utf-8?B?aGhVTTRuK0N1RXhUUFpGRDZSaVEyeTgrU2lvMnRmUGxjYlNHS0o3c2c2c3I3?=
 =?utf-8?B?WkkzZjNZUlNNbk8xWEhKNS9RcEMzbVVMMVY4a3NMRTU0S3FtOVhETldTTlZs?=
 =?utf-8?B?bWlzWDNxeEw3eFYzSFhHR1p5V3haRzRPMitHNzNqK0ZiaXN4d3p5S0hob2RQ?=
 =?utf-8?B?eWpYaWJkeWZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFlCQ0w3Qm5QZWJ2R1dQT1k3d0Q1Zk9rSGlob3FnWnZJQW1yVk1LNmh5NTNq?=
 =?utf-8?B?WW5rMlhNWjJGOGF2QU5tU0NNcTVIb2Zzb0FlVjBPM3I0dDhWRnpUTFBUbDY0?=
 =?utf-8?B?M0dldXVuR3RqU3BJRkhsR1VNdktmNnQ4MGdTbGEzNWdaSzJocGVKcTZuU09v?=
 =?utf-8?B?V0pxUkpCalNLenBlZzFGY2IyWnREMGFqVmdHQlVzRWpiWFpuUE14TEU0bnhP?=
 =?utf-8?B?akFwN3VOSDh3NUtnUk1yRWdzK1JKZWhIMW1TKzRSLzA4eXVDeWcwR2h2djFn?=
 =?utf-8?B?bHhLQWE3Q09MKyttcDYreDdqM1V0bFp3RHBEWkNrWVozV0RCeVEvTDk4SmRW?=
 =?utf-8?B?dFZhUHdLU0wxVHNQOWtMcWNFSWdreXFIZnhEaDVGcStxUnFkNTNVYndrb0M0?=
 =?utf-8?B?MUNVMnNBcmg1a25XcmRrb1dUditWSjB6M1Fab0JnL3FtN2ZFbmczemFPb3No?=
 =?utf-8?B?R2phSEhIaFZOZDV3K0o3czR6Z0YwY1N5bEJsaEZZcjNTTm8yRkNhYXI0blMx?=
 =?utf-8?B?Nk9Jc254YUc1WlNlVllIdHdPdjFjUXgxSS9Xa3dsSFNQbEFyaHFHVVArUGoz?=
 =?utf-8?B?TkFTaUdvbkFyaUtsUHB4NCtVUEJGRUVNSUNROEc4Y2hqZVd2VXRuRVNWMWQ4?=
 =?utf-8?B?QlZxTFNiVFVsMTIrWjAvZUZndXl2UytPa214SFVmR1JXRE8rekVkS1JkbGZC?=
 =?utf-8?B?Z3lSczhoaTdCYmpzYWZ4WEZ1VFlWbE5aWDhJVEpqQ2QvM0FTMktnZDdTY1RH?=
 =?utf-8?B?dzFFMnVXNmRCWkVrU1ovV2Y1WFZmUXJzbkNRc3RKZVM0aUpKaVIrbkliRXFz?=
 =?utf-8?B?NzJERWQ3cnZLT0ZOejZpei9Xbm9HR3dFblVFWHJJbnlVQ2M2c21BdE41eDl2?=
 =?utf-8?B?QmpUbU5tNCs5TEgzZGl4S0cxbUR5UkJ4SXZuczRUV1Rva0N6Unc0WGZyRlA3?=
 =?utf-8?B?R1liaG0wcGFVRHZlaDRySTZMaFZvWXltVURNazFYMzA3ejB1VDBkWXlnaWRQ?=
 =?utf-8?B?d282TGFxSkR2L3Q0NGJvVHVuZW5SSTRWN09BemlFaWMwRTBQNlMvSTdTNTlF?=
 =?utf-8?B?dlM2YURyejhLeSs5KzVyVWFlbW4yc0RXZktCSmxkSEd4cW1SZGFiS3ArODhC?=
 =?utf-8?B?U1kxaFVBeUlCNDFiQlgwdjRTek9rMjk0Zit5NjJsVjZJSGUrU0pLSUxndlV4?=
 =?utf-8?B?NEdzMUN6VVdUZHNDOWhWRExiVUlyYmQvblVvOGtQMDd3d1FlbllUYmU1czhO?=
 =?utf-8?B?bjM0d0lvdlZkNHBhSDZCOG9VVk1SNTNzSG9RSE0zc0JPRXgrL21jL29PZ04z?=
 =?utf-8?B?MXcxQmNwQXlyVzg1WDQ3c1ZoNEtCMmZmZ3BWYVhEK2hqanJEN0Zkazg4UlIr?=
 =?utf-8?B?Mm9FSjFjbzNDa000SElvNTFoS2dQbXkyS09ySjRIeUxuUjJGZW9PTHcxSGZw?=
 =?utf-8?B?VnRiR2hmQ3RZcXBmN0paVk0rMlhMdW95dTB2WTR6OWdqZkZsenNzQlV4NGpj?=
 =?utf-8?B?RFJTa293U0NrWkdReUtYWVlSbTFjS3lzMklvOGw4ZnVLcDRtSlpLS0hKVi9r?=
 =?utf-8?B?UkZWUTBNQ3EyaDI3dTZZNnl0UmZNUGNWNW8rek9Ic01kRWlYMEk4TnJjbzRm?=
 =?utf-8?B?MmR1VDRQRDZnVlYrVU1RQXRGMGQ5ZDZJNzNhR05iQnVHc2s0eVo0RUwrYzFz?=
 =?utf-8?B?Vk9tTmQrVEI4UlhDSVlsdHBWVHBhR0ZtZGFtclptYkRXSmFvWFJ0aHBzUzRh?=
 =?utf-8?B?ajI4MjNJUjNpODNvWmFZY21IMkxCbWRvN2VNcTIzekFMaGpZeHY0ejlGN2M3?=
 =?utf-8?B?VFhyV0J6NHg5bFdjdDhBd3BIQVJpZ2tKVVlGaTlBam9YNldpYVlEOGZMYlph?=
 =?utf-8?B?N0ZZZE9JZTIvUDYyOUx3YXBJUGUxc21wL2ZRczY0anhhOVBlOVpIV1MvV2xy?=
 =?utf-8?B?bTZUUE93ak45WE5wMW8rWE1RRWdTTTZVSFZTUS9SbTNCNDNSUkpJeWR1Mklq?=
 =?utf-8?B?SDRJRUZhalJPaXV6RERHR3NIdURNVGpJRkp0ZDRvbEx6dmhhY29MQnh2VGZt?=
 =?utf-8?B?L01VdTFaOVNMb2pub1IyTk5iMVNVakpHZE9xUlZWRUR1dlFKV3NteCs2cVNZ?=
 =?utf-8?Q?HkKU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf46529-e186-40b2-4264-08dde580fc54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 15:47:10.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Abto2H4VCsYnZf9zn6SszLdcmQh8DWPmuSZ15hYlBeeQGLuuytHq/Ko9gBWVhYIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjcsIDIwMjUgMTA6MzQg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogUGF3
YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IFRob21hcyBHbGVp
eG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYNCj4gPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDQvNV0geDg2L2J1Z3M6IEFkZCBhdHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvciBT
U0INCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5h
bCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMs
IGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEF1ZyAyNywg
MjAyNSBhdCAwMjoyNToyNlBNICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+IE9rLiAg
VGhlbiBJIHdvdWxkIGdvIHdpdGggdGhlIHN1Z2dlc3Rpb24gaW4gbXkgcmVwbHkuLi5tb3ZlIHRo
ZQ0KPiA+IHNob3VsZF9taXRpZ2F0ZV92dWxuKCkgbG9naWMgaW50byB0aGUgU1BFQ19TVE9SRV9C
WVBBU1NfQ01EX0FVVE8NCj4gYnJhbmNoIG9mDQo+ID4gdGhlIHN3aXRjaC4gIEkgdGhpbmsgdGhh
dCBzaG91bGQgd29yayBhcyBleHBlY3RlZC4NCj4NCj4gTWFrZXMgc2Vuc2UuLi4NCj4NCj4gPiBS
ZXN0IG9mIHRoZSBwYXRjaCB3YXMgZmluZSBJIHRoaW5rLg0KPg0KPiBIZXJlIGl0IGlzIC0gSSAq
dGhpbmsqIGl0IGxvb2tzIGdvb2Qgbm93IGJ1dCBkb3VibGVjaGVjayBtZSBhZ2FpbiBwbHMuDQo+
DQo+IFRoeC4NCj4NCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vbm9zcGVjLWJyYW5jaC5o
DQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL25vc3BlYy1icmFuY2guaA0KPiBAQCAtNTE0
LDYgKzUxNCw3IEBAIGVudW0gc3BlY3RyZV92Ml91c2VyX21pdGlnYXRpb24gew0KPiAgLyogVGhl
IFNwZWN1bGF0aXZlIFN0b3JlIEJ5cGFzcyBkaXNhYmxlIHZhcmlhbnRzICovDQo+ICBlbnVtIHNz
Yl9taXRpZ2F0aW9uIHsNCj4gICAgICAgICBTUEVDX1NUT1JFX0JZUEFTU19OT05FLA0KPiArICAg
ICAgIFNQRUNfU1RPUkVfQllQQVNTX0FVVE8sDQo+ICAgICAgICAgU1BFQ19TVE9SRV9CWVBBU1Nf
RElTQUJMRSwNCj4gICAgICAgICBTUEVDX1NUT1JFX0JZUEFTU19QUkNUTCwNCj4gICAgICAgICBT
UEVDX1NUT1JFX0JZUEFTU19TRUNDT01QLA0KDQpBZnRlciByZXZpZXdpbmcgdGhpcyBmdXJ0aGVy
LCB0aGlzIGNoYW5nZSBzaG91bGQgYmUgcmVtb3ZlZC4gIFRoZSBBVVRPIG1pdGlnYXRpb24gaXMg
aW50ZW5kZWQgdG8gc2F5ICdjaG9vc2UgYmFzZWQgb24gYXR0YWNrIHZlY3RvcicsIGJ1dCB3aXRo
IHRoaXMgcGF0Y2ggeW91J3JlIG5vdCBsb29raW5nIGF0IHNzYl9tb2RlIHRvIGRlY2lkZSB0byBk
byB0aGF0LiAgWW91J3JlIGxvb2tpbmcgYXQgdGhlIHNzYiBtaXRpZ2F0aW9uIGNtZCAod2hpY2gg
YWxyZWFkeSBkZWZhdWx0cyB0byBTUEVDX1NUT1JFX0JZUEFTU19DTURfQVVUTykuICBUaGVyZWZv
cmUgdGhlcmUgaXMgbm8gbmVlZCBmb3IgYSBTUEVDX1NUT1JFX0JZUEFTU19BVVRPIHNldHRpbmcg
b2Ygc3NiX21vZGUuDQoNCihUaGUgY2xlYW4tdXAgcGF0Y2ggcmVtb3ZlcyBzc2JfbWl0aWdhdGlv
bl9jbWQgZW50aXJlbHksIHNvIGl0IG5lZWRzIGFuIEFVVE8gc2V0dGluZyBvZiBzc2JfbWl0aWdh
dGlvbikNCg0KPg0KPiAtc3RhdGljIGVudW0gc3NiX21pdGlnYXRpb24gc3NiX21vZGUgX19yb19h
ZnRlcl9pbml0ID0NCj4gU1BFQ19TVE9SRV9CWVBBU1NfTk9ORTsNCj4gK3N0YXRpYyBlbnVtIHNz
Yl9taXRpZ2F0aW9uIHNzYl9tb2RlIF9fcm9fYWZ0ZXJfaW5pdCA9DQo+ICsgICAgICAgSVNfRU5B
QkxFRChDT05GSUdfTUlUSUdBVElPTl9TU0IpID8NCj4gU1BFQ19TVE9SRV9CWVBBU1NfQVVUTyA6
IFNQRUNfU1RPUkVfQllQQVNTX05PTkU7DQo+DQoNCkJ1dCBtb3JlIGltcG9ydGFudGx5LCBwbGVh
c2UgcmVtb3ZlIHRoaXMuICBUaGF0J3MgYmVjYXVzZSBpbiB0aGUgY3VycmVudCBwYXRjaCwgaWYg
dGhlIHVzZXIgc2F5cyAnbm9zcGVjX3N0b3JlX2J5cGFzc19kaXNhYmxlJyB0aGVuIHRoZSBzc2Jf
c2VsZWN0X21pdGlnYXRpb24oKSBmdW5jdGlvbiBkb2VzIG5vdCBjaGFuZ2Ugc3NiX21vZGUuICBT
byBpdCBuZWVkcyB0byBkZWZhdWx0IHRvIE5PTkUuDQoNClRoYW5rcw0KLS1EYXZpZCBLYXBsYW4N
Cg==

