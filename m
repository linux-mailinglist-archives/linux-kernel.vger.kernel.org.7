Return-Path: <linux-kernel+bounces-854597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B274BDED29
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F2B3B2C06
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8840D21ABC9;
	Wed, 15 Oct 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vBNUihcN"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9504B1A3160
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535949; cv=fail; b=lPsR37cVLChn84g6yW0NjPwx52H6Z1pjgsMPor1frbkY9Y7pzsvwJax3+tSvVuMlRv7RUAKZXljBaN+dU4GvbyqFeBRzNvyZOy6cRdyV0SuNw5xYc1MBuvN2FWRTYRPBbGFS1hEgsnLX1pOhS7RQDoNFyzR57edZ+PYh2bZCe9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535949; c=relaxed/simple;
	bh=Ejh5osJvmQytzrGntVvK7ggsq5YMmV38E0f//ffwckk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZD0HTunVCNXwZNJXV54S2tEmH7ZZodXbXdPfYVEWpEDeKA9UdHIlDQbbvGmDpaCXwAvpdC/alThndB4EeiPDZIDjJwbUAUzbkBZ83wrdiZHZ6cpi2e08oi8fcIngm+wpDHgdMlfFOHeCpWVM04ggw7cve2lzQUzDVTEjt2C0aJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vBNUihcN; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j01qF+WgNzFCrCztVid4g2KRODoSyEkl1rgP5NCquwbPQsUqLTt2MpT7EPJfr2oJWouOAlA87bqhMMyH4sgDwyWdFLYMgVO0EPornIgeM/KHqqOG3bQzoZ8DEQs7Ee9nZvuZqPemxM2fonK00QXhJqsiMIbdRkgxvsFaDPxkS9sIhLVI44m2vQR6G9pXBdEpNiBMs+ID42aBBS69emKht62G0A5OUhFiwF0Ma2RmKmLEIyDUh9DzMpsESkptINpkRFiOSqiGiFVY3QxuhqXjn40udFpq0tPpo9+i0fVaDA56dW3DVFeaHAUOWk2Ze/FFQZFYJDu3SK98Ta1lXzeZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejh5osJvmQytzrGntVvK7ggsq5YMmV38E0f//ffwckk=;
 b=A7bPgvHy87ri3kzbk38rKyCP7wciuMndn+TCjfbFc4i6yeOvRGpuMPcfOsP9hgNh6tybfcoy9bPovghnWO249cK3MzH6hU9Kr68Q0zp7IqgFNFvnFhj+7BaAmUEkgA/QBRkny1kOqplGGGH7u65XPqItBGz4kYnXPE6BFrdAC9/iYS+t1Uef3BgPhkooJWBN2zKaC7TjnN/BaEGtuPGr95ULYpeASOL65NPe0MC94BXIbRmmDZhvcJ0eWj790kGYb6fcBvFsYksoY9E+ZwpqbSgG6pWGameStPQdFmTgHqH9az3+rFYnLOiGVrDiTYq/zAnlW3eu1igW8FP7edNunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejh5osJvmQytzrGntVvK7ggsq5YMmV38E0f//ffwckk=;
 b=vBNUihcNlay6co3vlT2wWvdBvK5RVGepKpUIvVdduAZuHfM1QF63wQhQ4Ol8dNxVpCg84gwdqOycwIibe3nE4eiBjHqTr93T1FJVWrQAmp8UBe39CS/sBxnqmKOhv9ZWNHd5fvqIeBuki1d/G6zkP95If8+t3kULgq4dDewhbAQ=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 13:45:42 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 13:45:42 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Topic: [RFC PATCH 34/56] x86/alternative: Save old bytes for
 alternatives
Thread-Index: AQHcPb/dNJRwYJelJ0iZ+pcOgQN837TDNq5g
Date: Wed, 15 Oct 2025 13:45:42 +0000
Message-ID:
 <LV3PR12MB9265295ABF26898CA59B86D594E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-35-david.kaplan@amd.com>
 <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
In-Reply-To: <d897be07-ed59-4538-aceb-53c6512aeccf@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-15T13:39:12.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA1PR12MB6186:EE_
x-ms-office365-filtering-correlation-id: 715464a6-a523-4320-7435-08de0bf1226c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YktVcmFhT2dWMkQyVlJpc1lYVXhkY0V2UExIdDMvNVM4bjZvY2grWlpGd0VV?=
 =?utf-8?B?SzYvcHllYUNxMnBrQ2crRkk5UDN4QTBCRzdIR2Y2UCtlU2NXNmlhYVdkUU41?=
 =?utf-8?B?cXV4S0ZCcHhKRGFvUVlyOStSZE0xZzYrTUV3RlVVaGVncWdRNC9jV1NQdW1j?=
 =?utf-8?B?M3RnOTk3anJFRU5lbnY2eWJ6MnRKeWpDb2hNbkNGc3JBT1l3ZCtDTDgvR2d4?=
 =?utf-8?B?U0xwdE02SFBlZC9DYmd2SkJwSHRDY2hRaWFiZG0rS1BBRjFuM2NRTHNRWmZP?=
 =?utf-8?B?NDVZZlVPUDlIVFZCYTlwa2g2ZlZZYWp4TGwxcThMU24wdWhjcWJZckExTGM4?=
 =?utf-8?B?Um5PNG40dDJsNkRkUEMydk4ycnFsUjU0alF6TG9CT0Z2QnVRS3piQ0JpZzdz?=
 =?utf-8?B?M2l1SngvYXRJNUYrMWVlc3RvZDUzV1Z6L2piUGZISzc2RWZPOCtYU1Zmd2hX?=
 =?utf-8?B?Wmo2Wlc1anRsKzBLZERaVGxxYTdyWHdDT1lab0kwelJzYkhXd1V5cVJLOE1E?=
 =?utf-8?B?OFo4aDV4M3BNd29iR0JMZGxlcTlhSVdubEF4aFRJOTgxM3pZczREeFZPakFq?=
 =?utf-8?B?c29GaVYwVTZoZGFKS1p0OUdvOVhOSEJUZ3MyNGRKRVVNTVAybVhERjVnTVow?=
 =?utf-8?B?bGE4WEZqakExQzBZcE5EUjh4VkZvY3p0ZHo2QnFZNGFsY0tWTDdsRjdPbVBD?=
 =?utf-8?B?bHgwbnBBanRRemZQUjFOM1B0dWxiNDNHWXMvVWxReVVTWk5WaFdKZVppMi9V?=
 =?utf-8?B?QzAwdVBYbkVEdC92OFRDRnE0YUc1UlRxNDBCeE45emM3a3Y1U3RFdVNycW9n?=
 =?utf-8?B?VVZRY01Vb3IrclFpWUhmVjRFeG5OUnVPYXZ0eGh4QTZsdEhCaWlPa3Q5UmJo?=
 =?utf-8?B?c21PY0RObXdGQ3VrNytpdXdaWG80RlBCRmlKYUs4dXJKeHJ2MjJuK3h2UTYx?=
 =?utf-8?B?Y1ZLeWE2K2tPSzhBSkVvN2J5YlAzaHNUZlo3WHFHWjYxbHdDSm92bXRyN2kr?=
 =?utf-8?B?QlB4NDVVUyt5RWJ4V0dvbVh0cTUwdjhCYTFMQUQvZ0xXeVZHVnVqNmZPT2dm?=
 =?utf-8?B?Smp6eVRWbWM3bVYydUI2NFk3U0Z5UHdzL3BZNnp5NjJkWVNYSXRvRnB6Sm1u?=
 =?utf-8?B?L1BtWXR2d2dlRXJlTlhYdkJyTGhZZ044N0FqRHNzOFUzTlVrZUp2ODBxN0Vn?=
 =?utf-8?B?dURIbWFsejB4c3R5RDdsVVhEVEIwU0xmcjVGc29BMHVTcXZBdDRvNFU4b216?=
 =?utf-8?B?c1FZUkVlRjV6ZTROcXdvL0VIb2o1Rnh0NVI4cE41NWttTUtwS1dYY2xTMkkz?=
 =?utf-8?B?NEdWVHRBN2pjOGxVeHVTR3BzYnI0ZVJNaG9uTm96VW1DV01xbjVSR2VyTDVz?=
 =?utf-8?B?U01Fc1BMbWpaU0dPSHFVNlRTdGloQkZQLzFRbWcrTzdOWDZjNkl5RVdkeW9D?=
 =?utf-8?B?dW1hUlNyWDA2VjFYcjQwLzdGNXBaVXVmb28yVFpJRnFsUC9PQTg2WHJPRTUw?=
 =?utf-8?B?WmtOVFlveVVSWkkyZWRDTEh3bzJVR01ZL1RQWnZTa0Z5Z3V0SXg4QzBqdXdC?=
 =?utf-8?B?VTZDV0xzSWpURi8zSE5sME45RGI4OVBRK1phdmdKTkhrK0ZIVE5xZFlTTThW?=
 =?utf-8?B?SnJoVTk5Z29NSkNCS1JTQUtGZlVCMFRWR3h0RnlUY1BGK2IvN2N6ZnM4ZWxk?=
 =?utf-8?B?NExJU3pVZFRrYmlVKzUxNTZ3dGNPaE1pL1drWkNGdXFwZWhDZ25CaUU2bUJq?=
 =?utf-8?B?M3Q5dnA3Y3BicGVvWHVnNHJmRERBbVR5alpyN1FON0dZcXlXbWVkS25KQ1kw?=
 =?utf-8?B?alpVTUFYSEpJSmZjRUthNXJjd2Y2NWZxVUg0bktlZVUvSnUrUmNzZUlrSWFl?=
 =?utf-8?B?bVpjMFZURW9hQXV3emoyQS93eVVnUmJJQUxTRGgyQ3VNbnU3bVlSRzZXeEhV?=
 =?utf-8?B?ZUpVK2lCTkVuWkZ5SkQ1bVpFOGhPVHlXSWFBWHdISUIrMnR5T3hZcisrbzVa?=
 =?utf-8?B?VlAyVXppakwzRCs5cG9VVHMzeXB3UnlhZnVZTFNVN0h1aUZaaTdoMStodzhH?=
 =?utf-8?B?MHdPaGRESW43WFJXTVJ2SEFBZTB5MzNRcmE1dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cktScWNIYThCYWNTQ0xjTGJUL1dKQnRLTzg3bWJhOVlPSEs5SS85TTBBN1lK?=
 =?utf-8?B?Z2k4TTIrb0dLNDQ5aVFvYjRJY09uQW45WGdQQ0pZWkZFc281T2VUNlM3ck1T?=
 =?utf-8?B?NEcrY2wwdzJKMGJjUmhQSDBtbHdHcXF3VVY5WTNSeFZSV3RZZi84U2dxVnVX?=
 =?utf-8?B?a1cyMUpQa3RUSTVtaktRRThvYkk5NW5KTVBVNVVxK2k5RVBqQWhVSDkxSkV6?=
 =?utf-8?B?bGRmTHpYaElUc2Y2eWo4V0hGUiswWDhmeFMrSitvY254c3JlWnF4OTdtN1lt?=
 =?utf-8?B?RWdEd0tpb1FPUFMrbmFURGtRWVdWcCtUS1lkUisvYSswNk9aWU9LSlArK28x?=
 =?utf-8?B?Uy8rRjJUWnFDRjhJVXprZlFIckJyQWpTbmpVYkpDdkFSb3p1WlIzYjR2QzhK?=
 =?utf-8?B?Y3htb2xLeHVnL1FhUUhLZ3lISXFZZGxCdHUxUm42cE0zTHNObnc4b1RORG5Z?=
 =?utf-8?B?YktJUDRDWm00bFgvMVZlZ1dNRUo4dmNtd3JVbkFWdjgwT3RFSHoxWEgxaXNJ?=
 =?utf-8?B?VUIyVEJnZ3NUNTVrcVQvbmhGS3Vzd0ZxTGpGQmlZN3krTEJFU1NCRW1xNFZt?=
 =?utf-8?B?N0pJVit5QmY2REJ1VWJ6bUZFMkpTUTB1SUE4eWFTc3FVRGtNNkhOSGlJUU4z?=
 =?utf-8?B?RjlIaUgxV1M3UGRpYjdEODhFT1JLVGNLVkFieXR6dEdRVFVZRldhVnFDWHNJ?=
 =?utf-8?B?VGIxTW1DRnFtUm9TRVlMT0pIekNibWVVeForb3FkczBpQmZkRW5aSUdoQzF2?=
 =?utf-8?B?Q0lXenNoRXdWSlRLR1FGeXZnbjZreXNhUE85aDlDZ003bjhSMm9ranRZekI5?=
 =?utf-8?B?MVlnTURSeUZnejk4dEh2cTNoQ2phdUFLcTVNTjZoZXBQa04xOG1XUXB3TTNB?=
 =?utf-8?B?TWlYdWpONTgwMWJmcUVJVTJ5YzJHM1NGNjBOckVVVkhzZEtEYzNHUXhvaFJY?=
 =?utf-8?B?Tm41NmQ4RW9zRis5TElMVytlZHNHZUdqSW15bWI5QlBYT0FCeE5uWFZGK3lv?=
 =?utf-8?B?SUFoUU0xLzJoZE5VYVBOZnpWeE40SDBldENad0YwZTVsMit1cUszVEdwOERE?=
 =?utf-8?B?TmdRUTVrdTNTMndraEdRUmtvVGE0Wkg5a1dDQWlJckJpeGoxdCtIZnlkRUtE?=
 =?utf-8?B?cDJwRHhLSmhvSkxUYkRwajFiODNYanJpRmJycXoyZlc5UEhrRkE1UHc2QXND?=
 =?utf-8?B?S1lPR21XVXYvRm1tb0E2U3E2aTQ5SG9qOGhxZnpQSWtPYjBCU2xlNEIxaTE4?=
 =?utf-8?B?VnBhLzZwZzRtWUlTY3U5d0dGL0tETVJuQ1p1bmNKUytHdDhDeHhMWDNRTUxm?=
 =?utf-8?B?YWhnYVFHZlpMRzFMN0tjVnFyLzlkZnB1WGUyUzVrME1uWkVUZTdZZ1JPdFpX?=
 =?utf-8?B?S00zSjR6ZDFCaW9qLyt5eEdwWXBkMnpXUGJYZy9RV1hmbjUxMGI3QkRUdTE2?=
 =?utf-8?B?NSt3ZnE0OG5pNzljckNPWGoyZVowdGJRRFBicU1pNm9IWSszaW5uZlFCTzlI?=
 =?utf-8?B?dWlrOSsxaHJPeGQrdzZIZUdqcGgyL2JLRnY2QWNMbmw2Zi8wb1k5Y1gwS3pu?=
 =?utf-8?B?Z2lQK1FQMWdnbUx2UHp5TjNESlRrNDNvVGsvNXJ6Z0FvSWhGclNWUVdjUEJr?=
 =?utf-8?B?ZHJUaTM4ZjNrZVlIdWNGdllzcHIyT2tMVkRUMHRuaGJ5RjdsR2RJSWdxeUxN?=
 =?utf-8?B?M3ZWQkRkVWZ2dzdtMVg2TDQ2aWNHcUFFdXNEY3pjQWRwQmQyZDA4bWV0MTNF?=
 =?utf-8?B?UTd4TXRLSkIyV3hZaUNOU3lCZk1oWEU3aGpTQ1BIQ1BpZzFTMVNpb2hKYmtT?=
 =?utf-8?B?S3JzNFlzVGRGNGhXV01hMTd6UVJMQkFhNUh4ZnFBR0RYZmNBdmt6VExTeFA4?=
 =?utf-8?B?VWpqaGM5TGNNM2JhOVV0TmlHcThYYXVldzZGOWZTVFZBSFdwcDNQeEYvWlNr?=
 =?utf-8?B?RGFxU2lSYnBUbHNLbVpyREp5YlREdStGdUFPSGRRdkFDS05GemV2M2FMMC9P?=
 =?utf-8?B?MnVRVzdicFFzS3hRTkdGcHhobTZQNlRIUkJ6Q3R4czlURTl4ZklyZlNpakhB?=
 =?utf-8?B?TkJzNmVkM0pLSGxCVWlTRXZ4T2NqWkowNGFlalZheWF4a3dyWlBGc2lZZFhq?=
 =?utf-8?Q?nARc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 715464a6-a523-4320-7435-08de0bf1226c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 13:45:42.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rTdDuS5QHhQgLUWPRb6KzHLaTjtTIuAcK3BdpCOBPUOAuyQcdvU8wyNyUI5APAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAxNSwgMjAyNSA1OjM4
IEFNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT47IFRob21hcyBH
bGVpeG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGll
bjguZGU+OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBKb3NoIFBv
aW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz47IFBhd2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1h
ci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47
IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVs
Lm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFAenl0b3IuY29tPg0KPiBDYzogQWxleGFuZGVy
IEdyYWYgPGdyYWZAYW1hem9uLmNvbT47IEJvcmlzIE9zdHJvdnNreQ0KPiA8Ym9yaXMub3N0cm92
c2t5QG9yYWNsZS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBbUkZDIFBBVENIIDM0LzU2XSB4ODYvYWx0ZXJuYXRpdmU6IFNhdmUgb2xkIGJ5dGVzIGZv
ciBhbHRlcm5hdGl2ZXMNCj4NCj4gT24gMTMuMTAuMjUgMTY6MzQsIERhdmlkIEthcGxhbiB3cm90
ZToNCj4gPiBTYXZlIHRoZSBleGlzdGluZyBpbnN0cnVjdGlvbiBieXRlcyBhdCBlYWNoIGFsdGVy
bmF0aXZlIHNpdGUgd2hlbiBwYXRjaGluZy4NCj4gPiBUaGlzIGlzIG9ubHkgZG9uZSB0aGUgZmly
c3QgdGltZSwgYW5kIHRoZXNlIHdpbGwgYmUgdXNlZCBsYXRlciB0byBoZWxwDQo+ID4gcmVzdG9y
ZSB0aGUgY29kZSBiYWNrIHRvIGl0cyBvcmlnaW5hbCBmb3JtLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBsYW5AYW1kLmNvbT4NCj4NCj4gSW5zdGVhZCBv
ZiBzYXZpbmcgdGhlIG9yaWdpbmFsIGluc3RydWN0aW9ucyBhdCBydW50aW1lLCB3aHkgZG9uJ3Qg
eW91DQo+IGV4cGFuZCBzdHJ1Y3QgYWx0X2luc3RyIHRvIGhhdmUgYW4gYWRkaXRpb25hbCBvZmZz
ZXQgdG8gYSBzYXZlZCBjb3B5DQo+IG9mIHRoZSBvcmlnaW5hbCBpbnN0cnVjdGlvbiwgbG9jYXRl
ZCBpbiAuYWx0aW5zdHJfcmVwbGFjZW1lbnQ/DQo+DQo+IFRoZSBuZXcgZmllbGQgc2hvdWxkIGJl
IGd1YXJkZWQgd2l0aCAjaWZkZWYgQ09ORklHX0RZTkFNSUNfTUlUSUdBVElPTlMsDQo+IG9mIGNv
dXJzZSwgbGlrZSB0aGUgYWRkZWQgaGFuZGxpbmcgaW4gdGhlIEFMVEVSTkFUSVZFKCkgbWFjcm9z
Lg0KPg0KDQpUaGF0J3MgYW4gaW50ZXJlc3RpbmcgaWRlYSwgSSB0aGluayB0aGF0IGNvdWxkIHdv
cmsuICBUaGF0IHdvdWxkIG1ha2UgdGhlIGtlcm5lbCBpbWFnZSBvbiBkaXNrIChzbGlnaHRseSkg
bGFyZ2VyIHRob3VnaCwgYXMgdGhlIG9yaWdpbmFsIGJ5dGVzIHdpbGwgZXNzZW50aWFsbHkgYmUg
ZHVwbGljYXRlZCAoYXQgdGhlIG9yaWdpbmFsIGxvY2F0aW9uIGFuZCBpbiAuYWx0aW5zdHJfcmVw
bGFjZW1lbnQpLiAgSSdtIG5vdCBzdXJlIHdoaWNoIGlzIHRoZSBiZXR0ZXIgdHJhZGUtb2ZmIChr
ZXJuZWwgaW1hZ2UgYnl0ZXMgb24gZGlzayB2cyBydW50aW1lIG1lbW9yeSB1c2FnZSkuICBBbHRo
b3VnaCBJIHRoaW5rIHdlJ3JlIHRhbGtpbmcgYWJvdXQgYSByZWxhdGl2ZWx5IHNtYWxsIGFtb3Vu
dCBvZiBtZW1vcnkgcmVnYXJkbGVzcy4gIE1vc3Qgb2YgdGhlIHJ1bnRpbWUgb3ZlcmhlYWQgb2Yg
ZHluYW1pYyBtaXRpZ2F0aW9ucyBjb21lcyBmcm9tIHJlbWVtYmVyaW5nIHRoZSBjYWxsIHNpdGVz
L3JldHVybnMuDQoNClRoYW5rcw0KLS1EYXZpZCBLYXBsYW4NCg==

