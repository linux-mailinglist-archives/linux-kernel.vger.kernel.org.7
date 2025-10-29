Return-Path: <linux-kernel+bounces-876727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1302C1C1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EB01885099
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14634F491;
	Wed, 29 Oct 2025 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pNA/QvDu"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C8234FF62
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755223; cv=fail; b=pRQy5xh8JhAAYO1d6IQ3f7zwbo/7IkFSczTWhw9vPZlizTR1pDhS6kCnkAr6BjUKvyaJq0PfkAijSG2xvsS97udy9ZKFZoL4djaIj3h2nVP95cJc76S89df/zWUojgxIUTaQV1z/x41PC8ole6poJbwMh5mF7L93j3N9MKsOkyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755223; c=relaxed/simple;
	bh=AJm6UyqTd1z2cg2CVe4DZIjzz/IGfNRuNNYB8LDXFL4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IaSIIr4WACFbnc7mbF4Tw3RKVsfmSJrh9RoogjzgorR1/Q+MwjXiiDRIdsYT7gY4BQEeQFbIxTtJ4KeAj+7WBPkDhJmZxpHV7dLNiuuycA9dFQf1ARoHQPWxwmCfCdaJRDqjOeT3nozWKgiY1Jp/vEi4W8RfpcsTK8+THUQt+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pNA/QvDu; arc=fail smtp.client-ip=52.101.62.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRn4w6pWCqzmHTvoQHCTTK30CCKo9gCPu7qKEmUcM72oUaK8hv716IB8tBozL7FJGZdIFW3OJGh3wJ9iEPGj0kFc9DORLtR+qzCJhWeHmUwjhGVxLyZ0lokkV6AVmDcl8C17aOTVTi5ppbV9NyBkxfvRhldib3v93IG6AV8BOOwpo+ojRKETowTdAKpEF7kNz4EKeT/dYsCG5yh+O7rFltTmNsSLBwwgxteB1F5lQd6XstGNgnXDMDiOoMDJzrVW2OYmeCGxfS9tE071BUXi1AXn8eRcnACW+FrB7MeML28Z/bqPBTPq791Si21IFJel3D9Vvti0pfQc/hF2hh6hQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJm6UyqTd1z2cg2CVe4DZIjzz/IGfNRuNNYB8LDXFL4=;
 b=StVo94if3WBBfX9BL51QtfYntasbisHiKzPaO/K5KOAK3AtpotTkrmh29iE/A1JqlTQUUfhKP03xKtCzu3Or8CJu53rY5dzAvQCbJ9sOzrIDXTFc3dCOsl5nDdgC9XQL0k2miJDxXsVrEhMwH4Np/bfd2rzxN/Qd434t40oNkMjp/s9EYreUkLOrJ/HLp5VGPapGX2kzQHRK+kH6VmJppqlJtghcde4WUhzsNb7ARxAbEOG9XNCZJjuED34qZkGnkjUBXCLqW4kCsfAdpR+YuoqkhRt4g4aCKXGe7aCVCNfG3btOzmQXulVIfMZwukTRgg/Z3OO3TR1NEzzqtmvS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJm6UyqTd1z2cg2CVe4DZIjzz/IGfNRuNNYB8LDXFL4=;
 b=pNA/QvDuX4TT0x00zvJ7Kgqr8Gsc6Q/22PcUSf2gqmOuen3gD0SO43VjeCBeae02lgQi9ftkABvV9pSePNv3iEPIIEH5ip1NWzSrywpQcpb4uSL4GGdaBVN08meGIAjod2JzdmQfHyR+yzG9XT/XmIpypXIbAuUVDDHC1HkVCW0=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 16:26:58 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 16:26:58 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter
 Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Topic: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Index: AQHcPb/dNJRwYJelJ0iZ+pcOgQN837TDNq5ggBK5IwCAACi5EIAC2zOAgABxyTA=
Date: Wed, 29 Oct 2025 16:26:58 +0000
Message-ID:
 <LV3PR12MB9265295E1470ED9C5BE9EF9094FAA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <754ee3ec-8819-47df-8251-dec2906a020b@suse.com>
 <LV3PR12MB9265E559972E1C6693AAE7E794FCA@LV3PR12MB9265.namprd12.prod.outlook.com>
 <5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
In-Reply-To: <5f1fa90d-5c84-43e6-a99e-ef4a215b5055@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-29T16:24:34.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|LV9PR12MB9829:EE_
x-ms-office365-filtering-correlation-id: 18172e68-10bf-4afb-7ce7-08de1707fb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2ZnRVVzcVIyOC9OTUYvS2tBT1V2cnEzaU9Od1hYK3RMenZqTXZKT3hoak1E?=
 =?utf-8?B?cllkcUloUTQvazRMK2xBQ1FiYTlPc0VYOXJLY2hvb0RpMmQ2ZVV3a0pWVDJR?=
 =?utf-8?B?bDgwN0dMeXVUcjlJS1k2U29KbjFnT3ZZYUM0SlM0VkRhMmVyV1dOcHZLNDkz?=
 =?utf-8?B?MUpXODVEUEZpekx4UGlNaU5mRnpXZEt4b3hFQXhUaklFcUp5SytPZ1dETWZL?=
 =?utf-8?B?U0lKYmdtOEUvelFZOWlpOXVvRTVjR0NiQklwa2YvK1pFYWQrSHZjV2F2Q0xa?=
 =?utf-8?B?eDM2Z0ViY1pwcDJlRnc4ODJUaVhINTI4T1FiY1Z5TFZjZzRmTm50bXdhaG1q?=
 =?utf-8?B?WDBMLzJmT21wOVh6WWt5V2M2WXkwK3JyRWVMOTUrN3ZkVjl4LzArYWIzYjd0?=
 =?utf-8?B?MWJxK0FKMitsQUFlTmM2bGxjczBETXh3cU5aT041TW5JZWFQWlhrbnhtRnBR?=
 =?utf-8?B?ekNDdlZIR0pZb1hhTk5Lb1U4dm1Eblp3cmY2UCt6aXBmQTB6U0RYeVVSSllq?=
 =?utf-8?B?SkpwZDRIUlJTZkJzU2g3T3BYdWNDMkRNVW5CVXJoSGtVRTh3SmpMVGJJazhK?=
 =?utf-8?B?R0R1SDNWcjc5V2RSaFBtYjZYdDhJVkU2L1N5NlpGa1A0L2JHNEk2MmdMS011?=
 =?utf-8?B?bEJoVklIKzlROGlTOUxkLy9KejR1L0NPK3RyR0puaGxXb1pMK0dibWRMZjJk?=
 =?utf-8?B?TDVpSTVpVlN3eEI0YjJtMHcwQjQwMkMrcXFldFhSaS9MaWpOeFdiRXl5QWJ1?=
 =?utf-8?B?TkxwMmI5SUNzdUdRVnJ5ajg0bjUxQ3Y5aFpEbkZYUnhOUDJPVWtXRmhkR0Yw?=
 =?utf-8?B?dU5JSFFwQkUvM0NKTHk1bHNCWEdISDV1Q041cFppSm9rb0FyTmVjUjMxVFFS?=
 =?utf-8?B?QnJwKzlaWkpjMk5mNk5hdXQrZXlmMWhrRTZPeklpNG9VQnJpQlIzci9hU1lR?=
 =?utf-8?B?RENudWpOYmx2dDN1VHFzcnRibHZLN2dHVmUzY1UweCt1aXVIQVJEU1FrbTNI?=
 =?utf-8?B?UVh5aVRTMDcvME0xdjJIVXU0bGg1SS8vWjdITXRSMlI3a3loT1VtWWxMcXhh?=
 =?utf-8?B?UU1CbjNHUW11VDlMY1RoY3hXVkZuQkVVd01nTy9KWWdMdzE0d05QeE92aUk5?=
 =?utf-8?B?SWw1cDAwazlRN3kvT1hsTzM2VDJxVk5wN2lzdENjWVk2QmFPNnhwWkNVUmNQ?=
 =?utf-8?B?NDJuNjkwZ1EzeElqSFlENVBJNTAwOHJiNVV4Q2F4ZUo4ZnY4d1NhejI0WWUx?=
 =?utf-8?B?NklSUG1CTDdzZ1d5NzVHei9GN3hXWURmNXQ2NzFGaG0vRUZnS3QxTnkwZ0Z0?=
 =?utf-8?B?bE9MUGU4bmQ4b2NBYmZCVDgybndRL0dUSDlOd3ZhZnZoeUM2Zk5DSHo0REJo?=
 =?utf-8?B?bk1xM2xmRGw0aWFSazdVNmNHYzhNQzZFRUxxVUlqd1E5dWtXVElpUys0TmdW?=
 =?utf-8?B?bmN2dEhDRTB5b0NQQVI2emdRTGp2eUQxcFVJNlc4VHVnSG91MGNZYjlHWFdN?=
 =?utf-8?B?M1NUbkFjRFE0azhHalRQTWtYU25VT1duMk9UVmZraVIyeGw3ckc1bmtYeHZl?=
 =?utf-8?B?Qk56ajBUbkVNS2NnZjRzbTlSMFdHUzRYY1c3VVF4YU9sM1hHSGJWMzR3bGRG?=
 =?utf-8?B?SlZhQWJpT0hRRHJKVVBxMVptaWpaSmtsemFYNWJTMDNxMnNla3U2bDRZWmoy?=
 =?utf-8?B?SWR5a1J3TmMzWUJMVjhya2drc1E3VFF2RVNKVWZ2NnRTdzVyeDN1SW92RVNl?=
 =?utf-8?B?L0hSOFd0aDl1eFFaRVdvZ3JWRzBKYjhWZlRMNEdYUzZ2VCtIK0NpMlNLYlds?=
 =?utf-8?B?OG0rT25MalIvZHRQVFJ0Y1BlMkVmc05ndC9Ed1VnVU1jTjI5MW90d1Q5dlFZ?=
 =?utf-8?B?MXJHb29DSUN0eFpyS3NFNzlGMUxxQ1pmZG05Qzd6Tng5bXZ0amU2TUlMS0xM?=
 =?utf-8?B?NHFCMm0rdk5UUkh3NWRvRVVGSHcveVhjbWt5M3VoMTRweUNpamgrdEh0WklX?=
 =?utf-8?B?NFR3K3pqdUVZMzRwNGJ6S3FkblFiK2VOUVlpTzg5UHAybzdUaDVla1NRaE4r?=
 =?utf-8?B?WFo4Yis4VkFNNFRzMEIvUEl2VUJVVWc5bmtuQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXIzM2dpQXl1MlIwdTB3NTJONnBjd1lzSENkRnIrUEovck1ZSGx5bXJUNm03?=
 =?utf-8?B?Yy83U2tqMUxCTnpJZXduRmpQOWlQYWNoL2QzKzM4SCtUQWtlU0VlN3JMKzlW?=
 =?utf-8?B?RUJaUE12Z29CUWw5bjNJekYzaWQ2Wld2eWMzcEt2d085MFpYV3JkNFNLa3du?=
 =?utf-8?B?STBiaE9FaUZ3ZzZoQVJ6RDBuVDQxY3F2MXNNTUxaZDJSbUhFN00rNkVWOXBs?=
 =?utf-8?B?T1VLTUZwL05zMFhnM1NVa3BSOXZieFplL1cxNVlLdTNXUnZiSklwZ2Jld1py?=
 =?utf-8?B?bmJDNVUyQ1hTT0kzTTA5MGdHSGk5Ri9mTFU4b29ZdUlGc0lER2NhWTNKKzhK?=
 =?utf-8?B?ODMyM20rdHptNHVNck5rMnpNMDFkSG92aVZ4anI2eGFCUC93R3NPQjFBTldD?=
 =?utf-8?B?STMwcVFndklobWRUUGZkMnZtVjdGeTBDUHh1ZFpIVFVpL0Y4WUdBVHdRQks2?=
 =?utf-8?B?Mm5JQk5tc25ZcVUxYTJOWlNieWt5Y1hMcllUVXU3dUx5L3gzZ1pzS1NNSFhu?=
 =?utf-8?B?dXY1REZaNXBRdklNLzVoOHFsdlgvL1diMHV2am5vWFZGaXRxY0hXU2gzYTZF?=
 =?utf-8?B?VVBFN2dRY3lTMytMZkF2c0t1a2VQQ2RLZE9qWlNhdmU4bS9ZSXczSmlXc1ZF?=
 =?utf-8?B?cUVtOVUxMjBHZEU1dlBjaFp2ZWNPeEdLVGdIejV5Qmt3QnVJaTVBamdLTk1p?=
 =?utf-8?B?NXNvR0lYUU10MXdGZjU0enNZL2MyU0RrRDF3VXMvZ00wNG5lbVBOeWlLTm5z?=
 =?utf-8?B?Z1FpcHhaRE4yaDBIUzR2aXd5UXoxaVFISVNROUNqMWFhOHF0SDczMDFjRUZK?=
 =?utf-8?B?UWVWeUt1bHQ0WklTTk5teDM0QUVwRGlwZE56QUNveGl5YmF0Ny9Dc2hROSs3?=
 =?utf-8?B?Q3lrM3I1S2FhL0VlNU01L0s1OERqejd5OWljMUZxSytzOXZBekRYd2h3MTh0?=
 =?utf-8?B?S1VyM01haXVCK3ArUFlwYi9IVzBQcWlyNDFWN0xWMkowLzBKZmhXZGF6c1Vr?=
 =?utf-8?B?RVVXTFVXWTlxT0ZkblM3SUNHMUhqYlBTMkNQNEJCNUNHank1eXpCczNYUXJa?=
 =?utf-8?B?a0xXbGF4UEM3MWkrNVMyUVNmUTltWVNxbjBra3o2Zm1BaWdjTGlXdDArRENa?=
 =?utf-8?B?RHFQTmQzQm9rck5tRU5PRFN3Q2YxOExVMEV5WjlVcllyVHhBWGtoZVBYYUYy?=
 =?utf-8?B?ZnJTVkg1T2FuajhLSkMzR1VOaXU0b21tZ0wxSmplMUtJMmRsYmN1bDJxQ0tj?=
 =?utf-8?B?WFE4T3NqSUNUN2k4endlOHFFemZaMmpXcDRhVHU1aEl1SXlISlllajBkYUhG?=
 =?utf-8?B?SGJ2Rk9OR2dQS0g2L1RmVGM3VDZHZDlDK2F4Q3BZTVBSZVVaQ1FhbWF1R0NQ?=
 =?utf-8?B?ZzlmK3ZkcDd3bHF0NjFoWlh3dVBHbWxOeXJYWFpuL1NOT1FhTTFnZEpBYjA5?=
 =?utf-8?B?VFdTcEp0T29oQzNJUUYzOURzZXNQTWo1eDFuRjMrYzhZOG1HdmgwUXJ3dWpi?=
 =?utf-8?B?RlZzb2hiYXE0ODZsbzJCSkZ2TjZpSStaNldGRFJxS1hpcVA5aGRUY1hMS3Vo?=
 =?utf-8?B?cm10VlJlM2t3TlB0dzBEdTZMUVdPcDFUaTBRY3phNk9PZTJmbWFLaERiOVlD?=
 =?utf-8?B?bExEb0EzUERqNllTQWlCUzU4S3pCcHBsM04wdGtFcXkzd25wMlUwazlXWmpC?=
 =?utf-8?B?QVdNTEtRbmhlSG1ZWThhYlNqeW1SbUtqdTVDS1h4dFhVejR4S3pYUmh1b3Nt?=
 =?utf-8?B?YzBUdW9jMEtSQU1QNHNoa2F2WVc1RVlienpjUE5waVJoeG1ZNU11MU1nWWt2?=
 =?utf-8?B?bzZvWFU2UGFBOE9XaGpVamtFdlhpbUdSL1ZubVVjWGphRGhVekVid29JVWVC?=
 =?utf-8?B?Ulczc2s0eEo5bEg4OGYvZHNJUDFPWW9FQmE1MVl4WGRHYXZpT05kdkZmK25t?=
 =?utf-8?B?azRRYmUxcFRJdEgzbCszTGpVK3B0cVJ0OE9seC9qUWd4MzhOei84dTIwMnl1?=
 =?utf-8?B?dkw5TlJKek5GLzFObUVTbGZZTW4vRk1LdjhXT3o5d0xpeFhIeWRmRVh1MEFB?=
 =?utf-8?B?WHlDNjhIN2Y3UHB6RTAwNEdNNGd4L2taS0F1Y3JCUS9MNDY2QU1SSi9LSEdW?=
 =?utf-8?Q?8wag=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18172e68-10bf-4afb-7ce7-08de1707fb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 16:26:58.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UF/iUaSoT2w/PRyScxU2dzjQnCYJdGAB4qzsIXREKWXZpL+J0Q7qbmYyVpSjt90D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjksIDIw
MjUgNDozNyBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBK
dWVyZ2VuIEdyb3NzDQo+IDxqZ3Jvc3NAc3VzZS5jb20+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdg0KPiA8YnBAYWxpZW44LmRlPjsgUGV0ZXIg
WmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYNCj4gPGpwb2lt
Ym9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YSA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50
ZWwuY29tPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbiA8
ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsNCj4geDg2QGtlcm5lbC5vcmc7IEggLiBQZXRl
ciBBbnZpbiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpv
bi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAz
NC81Nl0geDg2L2FsdGVybmF0aXZlOiBTYXZlIG9sZCBieXRlcyBmb3IgYWx0ZXJuYXRpdmVzDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTAvMjcvMjUgMTY6MTksIEth
cGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRl
cm5hbCBEaXN0cmlidXRpb24gT25seV0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBOaWtvbGF5IEJvcmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPg0K
PiA+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUgNjozNSBBTQ0KPiA+PiBUbzogS2Fw
bGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBKdWVyZ2VuIEdyb3NzDQo+IDxqZ3Jv
c3NAc3VzZS5jb20+Ow0KPiA+PiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47
IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gPj4gWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+
Ow0KPiBQYXdhbg0KPiA+PiBHdXB0YSA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29t
PjsgSW5nbyBNb2xuYXINCj4gPG1pbmdvQHJlZGhhdC5jb20+Ow0KPiA+PiBEYXZlIEhhbnNlbiA8
ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBB
bnZpbg0KPiA+PiA8aHBhQHp5dG9yLmNvbT4NCj4gPj4gQ2M6IEFsZXhhbmRlciBHcmFmIDxncmFm
QGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kNCj4gPj4gPGJvcmlzLm9zdHJvdnNreUBvcmFj
bGUuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+PiBTdWJqZWN0OiBSZTog
W1JGQyBQQVRDSCAzNC81Nl0geDg2L2FsdGVybmF0aXZlOiBTYXZlIG9sZCBieXRlcyBmb3IgYWx0
ZXJuYXRpdmVzDQo+ID4+DQo+ID4+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZy
b20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gPj4gd2hlbiBvcGVu
aW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4gPj4NCj4g
Pj4NCj4gPj4gT24gMTAvMTUvMjUgMTY6NDUsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4+PiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
PiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gPj4+PiBTZW50OiBXZWRuZXNkYXksIE9j
dG9iZXIgMTUsIDIwMjUgNTozOCBBTQ0KPiA+Pj4+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5L
YXBsYW5AYW1kLmNvbT47IFRob21hcyBHbGVpeG5lcg0KPiA+Pj4+IDx0Z2x4QGxpbnV0cm9uaXgu
ZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+ID4+
Pj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5l
bC5vcmc+OyBQYXdhbg0KPiA+PiBHdXB0YQ0KPiA+Pj4+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51
eC5pbnRlbC5jb20+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47DQo+ID4+IERhdmUN
Cj4gPj4+PiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwu
b3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPj4+PiA8aHBhQHp5dG9yLmNvbT4NCj4gPj4+PiBDYzog
QWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJvdnNreQ0KPiA+Pj4+
IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gPj4+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzNC81Nl0geDg2L2FsdGVybmF0aXZl
OiBTYXZlIG9sZCBieXRlcyBmb3INCj4gYWx0ZXJuYXRpdmVzDQo+ID4+Pj4NCj4gPj4+PiBPbiAx
My4xMC4yNSAxNjozNCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+Pj4+PiBTYXZlIHRoZSBleGlz
dGluZyBpbnN0cnVjdGlvbiBieXRlcyBhdCBlYWNoIGFsdGVybmF0aXZlIHNpdGUgd2hlbiBwYXRj
aGluZy4NCj4gPj4+Pj4gVGhpcyBpcyBvbmx5IGRvbmUgdGhlIGZpcnN0IHRpbWUsIGFuZCB0aGVz
ZSB3aWxsIGJlIHVzZWQgbGF0ZXIgdG8gaGVscA0KPiA+Pj4+PiByZXN0b3JlIHRoZSBjb2RlIGJh
Y2sgdG8gaXRzIG9yaWdpbmFsIGZvcm0uDQo+ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6
IERhdmlkIEthcGxhbiA8ZGF2aWQua2FwbGFuQGFtZC5jb20+DQo+ID4+Pj4NCj4gPj4+PiBJbnN0
ZWFkIG9mIHNhdmluZyB0aGUgb3JpZ2luYWwgaW5zdHJ1Y3Rpb25zIGF0IHJ1bnRpbWUsIHdoeSBk
b24ndCB5b3UNCj4gPj4+PiBleHBhbmQgc3RydWN0IGFsdF9pbnN0ciB0byBoYXZlIGFuIGFkZGl0
aW9uYWwgb2Zmc2V0IHRvIGEgc2F2ZWQgY29weQ0KPiA+Pj4+IG9mIHRoZSBvcmlnaW5hbCBpbnN0
cnVjdGlvbiwgbG9jYXRlZCBpbiAuYWx0aW5zdHJfcmVwbGFjZW1lbnQ/DQo+ID4+Pj4NCj4gPj4+
PiBUaGUgbmV3IGZpZWxkIHNob3VsZCBiZSBndWFyZGVkIHdpdGggI2lmZGVmDQo+IENPTkZJR19E
WU5BTUlDX01JVElHQVRJT05TLA0KPiA+Pj4+IG9mIGNvdXJzZSwgbGlrZSB0aGUgYWRkZWQgaGFu
ZGxpbmcgaW4gdGhlIEFMVEVSTkFUSVZFKCkgbWFjcm9zLg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4g
VGhhdCdzIGFuIGludGVyZXN0aW5nIGlkZWEsIEkgdGhpbmsgdGhhdCBjb3VsZCB3b3JrLiAgVGhh
dCB3b3VsZCBtYWtlIHRoZSBrZXJuZWwNCj4gPj4gaW1hZ2Ugb24gZGlzayAoc2xpZ2h0bHkpIGxh
cmdlciB0aG91Z2gsIGFzIHRoZSBvcmlnaW5hbCBieXRlcyB3aWxsIGVzc2VudGlhbGx5IGJlDQo+
ID4+IGR1cGxpY2F0ZWQgKGF0IHRoZSBvcmlnaW5hbCBsb2NhdGlvbiBhbmQgaW4gLmFsdGluc3Ry
X3JlcGxhY2VtZW50KS4gIEknbSBub3Qgc3VyZQ0KPiB3aGljaA0KPiA+PiBpcyB0aGUgYmV0dGVy
IHRyYWRlLW9mZiAoa2VybmVsIGltYWdlIGJ5dGVzIG9uIGRpc2sgdnMgcnVudGltZSBtZW1vcnkg
dXNhZ2UpLg0KPiA+PiBBbHRob3VnaCBJIHRoaW5rIHdlJ3JlIHRhbGtpbmcgYWJvdXQgYSByZWxh
dGl2ZWx5IHNtYWxsIGFtb3VudCBvZiBtZW1vcnkNCj4gcmVnYXJkbGVzcy4NCj4gPj4gTW9zdCBv
ZiB0aGUgcnVudGltZSBvdmVyaGVhZCBvZiBkeW5hbWljIG1pdGlnYXRpb25zIGNvbWVzIGZyb20g
cmVtZW1iZXJpbmcNCj4gdGhlDQo+ID4+IGNhbGwgc2l0ZXMvcmV0dXJucy4NCj4gPj4NCj4gPj4g
SXQncyBub3QganVzdCBhYm91dCBtZW1vcnkgdXNhZ2UgcGVyLXNlIGJ1dCBhbHNvIG1lbW9yeSBw
cmVzc3VyZSBmcm9tDQo+ID4+IGFsbG9jYXRpb24gYW5kIHRoZSByZXN1bHRpbmcgZnJhZ21lbnRh
dGlvbiwgdGhvdWdoIEknZCB0aGluayB0aGF0DQo+ID4+IG1ham9yaXR5IG9mIHRoZSBhbGxvY2F0
aW9uIHdpbGwgZml0IGludG8ga21hbGxvYy0zMiBidWNrZXQsIHN0aWxsIGhhdmluZw0KPiA+PiB0
aGVtIGFzIHBhcnQgb2YgdGhlIGtlcm5lbCBpbWFnZSBlbGltaW5hdGVzIHRoZSBhZGRpdGlvbmFs
IGFsbG9jcy4NCj4gPg0KPiA+IEkgc2VlLiAgSnVzdCB0byB1bmRlcnN0YW5kLCB0aGUgaXNzdWUg
aXMgbW9yZSB3aXRoIHRoZSBudW1lcm91cyBzbWFsbCBhbGxvY2F0aW9ucw0KPiByaWdodD8gKHRo
YXQgaXMgdGhlIGttYWxsb2MgYXQgZWFjaCBhbHRfc2l0ZSkgIEFuZCBsZXNzIGFib3V0IHRoZSBz
aW5nbGUgbGFyZ2UgYWxsb2NhdGlvbg0KPiBvZiB0aGUgYXJyYXk/DQo+DQo+IFllcCwgZG8geW91
IGhhdmUgc29tZSBzdGF0aXN0aWNzIGhvdyBtYW55IGFsbG9jcyBoYXZlIHRvIGJlIGRvbmU/DQo+
DQoNCk9uIGEgdHlwaWNhbCBrZXJuZWwsIEknbSBzZWVpbmcgNjQyNyBrbWFsbG9jcygpIGZyb20g
dGhpcyB3aXRoIGEgdG90YWwgc2l6ZSBvZiB+MzZrYi4NCg0KSWYgdGhhdCBpcyB0b28gbWFueSwg
YW5vdGhlciBvcHRpb24gY291bGQgYmUgdG8gZ28gdGhyb3VnaCBhbmQgZmlndXJlIG91dCB0aGUg
dG90YWwgc2l6ZSBuZWVkZWQgYW5kIHRoZW4gZG8gb25lIGJpZyBhbGxvY2F0aW9uLg0KDQotLURh
dmlkIEthcGxhbg0K

