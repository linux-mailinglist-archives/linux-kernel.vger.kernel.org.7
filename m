Return-Path: <linux-kernel+bounces-838860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A863BB04A8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CA816E850
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E562E8E13;
	Wed,  1 Oct 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="knEePYVN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982D537E9;
	Wed,  1 Oct 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320842; cv=fail; b=LE6LYv0WNWy1ep7Wde+GF+fPSs//edy2OK7BARifkPFen28VX2Kp5t2VQtUyN2JhONImLzrJQxaEsq8ugpKeYtTRsUY/Dt3bDzMxEEkNEDH3sK7ofGgHLDD5YGVtqNTYPIuj5fF7UdbvoRqEqSVJgL/t3iASXP+rHNEVsIUXeQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320842; c=relaxed/simple;
	bh=nh9IkIzTrR1UlSE6zgyWqKYf1TMU7r0/ZmHlAX6azwI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jd98XTupZePDx7wsSSjx//eBl/ZKGppQWrY5sl5Rvk892SWl8iSbQdG2aERCGhSw1vpX3YqxA4EGWJlYK8F7HYSVXybbesYLzSJtcXf6ig7rakSADN2oGPZSuNYFWd5U9fTGkw8Y5vXJp2roWrZ3PfR8wMH1Fx48WHTmlcsAjjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=knEePYVN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759320841; x=1790856841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nh9IkIzTrR1UlSE6zgyWqKYf1TMU7r0/ZmHlAX6azwI=;
  b=knEePYVNpx4Kdyk0a0BZbuR4Je8/gpT6h+ZcPBgAZHIFxKLPLwED8uYq
   1mp5F8WgnLlNOZF3rN3pP/c/OqhBP9MJVUjDbkCTrQtwRuimdCjlDuARw
   +aWvOXy93KBgpfyk6y8JgMV7lBKRpYZjfK01DS/hLzFjSFhzkEgV3q6a1
   8WkSzhU/k+3fJ60Nepe58ys/SX/n6laPkPiI8v39/6+q+gabSYktR3Eun
   mvV+vFNnl6yx2Boe+M3TQlbfEFq8NUEgnB0VUT2SE/mZOUMZLszYJvd86
   Vx08rJpU4epjdJueSTO+MQkWOS7ySWZ8a5siQGwlVmPG7ZWfS1R6abW3a
   Q==;
X-CSE-ConnectionGUID: rTT7z/rST/iy/MHUrRk7mg==
X-CSE-MsgGUID: myBiUwlhSf6rolGw+QYkPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="84211076"
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="84211076"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 05:14:00 -0700
X-CSE-ConnectionGUID: g0TAFL22RECH/LBbrW8LOA==
X-CSE-MsgGUID: 0xqurrxEQ1eKzXT3TOm1Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,306,1751266800"; 
   d="scan'208";a="215898256"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 05:14:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 05:13:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 1 Oct 2025 05:13:59 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 1 Oct 2025 05:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8EX0Wk4cB/ULyH7+p9SlGKHB04lIpKoFYQ9To5cd1eABc0eDTJv8udiFKlf94TTlKxAA8kMmq3cpZxbdNAP3pcs+kWCbtTkRXtu/CxzaDNIdwOOYWFZABgmIPdMbYLIGct360Q1S3rGMAcMfmt36xh2lUOcrOLWe9+KsmafWg6F8TfUrcaCBIzKWRIinkKxn2k7uREc6Hoq69hVdtP+NUeVjyejTwicATXPM9/BW7R+BTkaHMgUISdRyBtv/C0xonUfQ5ayl5Br8ay3JseITIY53mT/CUs0ieRp0gVOup8FHQOLtfLDvru5TB5I3sHQP0ezQqDFcBpS3juRjKO4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KXD8ZwxVQZEWTjtOZch7eiJVf22oCuEFtRiKQ787p8=;
 b=OqSmGFz3nzna/5DspGgWnRiEGYqObyMwBDlGuO09P2XZYPWVm+BXAr2CJapAxVP4Rbf0FAjay5Fe0UAsND+1UIxZvib3jnYs3wwVSj2DOy7u9hG6oMZlW2JOdRZ0/HVZBMcCA8md1ggW9YVNyErRwrsZfl8qvJaE7kK8osjYfqHJA06eGP5oBCNdkE8Zl/uT8qCM1wqw4EIvjC7gC4u7G5ddyzX+XK/LuuyA9PPpelrtFF5G1dUKRFHmxEsH8CKUjIa5SBe1+MNKraJXYpfPyt2iPDGsLhALuk0w7UTNv6x1qm+PNAObrXpvHayt6Lrxo/bVeTFCABIlSemMVXF7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6899.namprd11.prod.outlook.com (2603:10b6:806:2a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 12:13:56 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 12:13:56 +0000
Message-ID: <38569247-431c-4b0c-af0f-aadd6fb26849@intel.com>
Date: Wed, 1 Oct 2025 20:13:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>, James Morse
	<james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
 <aNqUACFbXHjURWir@e133380.arm.com>
 <541fb538-0c22-4ad2-9c6e-83ada7f2240b@intel.com>
 <aNv9cA7W+NNZuDSc@e133380.arm.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <aNv9cA7W+NNZuDSc@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:d10:30::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e38f83c-e7f9-42ca-2a2a-08de00e3fe41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmlWZzVTeEZvdjFoQ0xqK1dMZHBlRjFvTXNhRDFkWWI4R2F2YkgycSt4WXJE?=
 =?utf-8?B?VEtCeWZiLzJ6YkZaMlV2QkJ3UVNrWWpUMTJaRGlWSFBEM0I1MHg3ekgrVUhS?=
 =?utf-8?B?VW9UaGdmV0gvUUl2ZlRQYTR0cEVIL2NLOVJ2TkpuZkRsVzR6Y1hBK283MEpz?=
 =?utf-8?B?TTJEaHRxdStZdmdhV09FTmxRZWNmVnRUeUNucWdQdHY0cTNBajNBM1ZUb1pD?=
 =?utf-8?B?NU9mTEJnaG1Ha1I0RGlWbngzMW42enlXeHkzWVRUaFE3L2o4Z1hFWHVsM2I5?=
 =?utf-8?B?NEI2YnRqZGlLRVY3WkhQak1aQ3ErbU01VDEyaGdlNDMxRDVBOVVxRmRXclp1?=
 =?utf-8?B?VmxER01GcTRVdHVWbWNYVUNqb0Uwa1BmN3UwTUo3RWtvKytJYkMrTXJ4cFpM?=
 =?utf-8?B?OTBxUWdGL3pKTHBhOFVpVllsZTBJaHlNQUNLTTlqaW5PcVc4c1Npc3VJc1pQ?=
 =?utf-8?B?ZlBteStpWHk3RzBRV1pyVUVuT2hVQXZIMGZVMktzMlkvUHZNUDgvNEVnWmcw?=
 =?utf-8?B?S1h0R2NOSnIyWjhBOElIZWVodlIvcS9WcUJieU5xZTlWUThCNjFGbm1NZE5U?=
 =?utf-8?B?VnhlaEJVNWpPR2VRM3RlTjJxWkZWUk1WaWpmV29jZllVQ0VDRmdYaDVLM0xl?=
 =?utf-8?B?MDQ0UkMrUVpIKzNEWmNlNDNxTWIvOE40bndPQU42UzBtUG1uWHQrdGJzK2ph?=
 =?utf-8?B?K1AwNTNWenNlWk4xWlU2TGdMTUlzeWhteFVNVkxzWnhBMUdwckVkUHQwaXps?=
 =?utf-8?B?ZCtxZ21zbExLYmNFV3ZYMXVrKzJ4NW85bFRuVmZ4MDczTGxOWTd3ZzczUi9Q?=
 =?utf-8?B?d1NSSTV2aGVJaVhtNytIc0lEVGgyZ0pJZnVCRkU3QU10SWFmTytLc3RRZFVo?=
 =?utf-8?B?aVN2R1hyTXZHaHl2Wkk1QkR1MzExT0dZZWpjeEZPbWlWbVE4T0RNNUl1SEow?=
 =?utf-8?B?Y28wUHEzM1EyNkErUlNyK1RLeVk3RnQxTmJRVExrRXpXR281R1lrTktsK3NY?=
 =?utf-8?B?d004NEt4VUVabmllaCtTVnJUVm9QSmdLQWJMSVBhK21Ub2x5Y3c0bzFQMDVh?=
 =?utf-8?B?Y3lvSU1tZnBiaXU4NjBldjhKOXhoS29EbWczSmtqRTZMZ3ZjSlhNYVRTSkxB?=
 =?utf-8?B?ZnkwTFVpa0p3dEVJSXBLTytTNlcvRnVDa2ZCVXpwUXhGVFRiNEd0YzZkMmor?=
 =?utf-8?B?MFVLUTVUOXpQbHhUM2FVRDcxSmlDYTRENGczbTBmTEZxMzVrU2gvM2pPYnJX?=
 =?utf-8?B?TnRQY0R0VFgwQzhFWDEzdk5ZQ1lXejFTUy8zdFIvSUR0TU5EZUp1cmN4bDJi?=
 =?utf-8?B?MjdaS2NWZTYvcDFjSGdGZWptbnNDUXl4eU9qQ2M3am50cmhTRCs5T1hva1lm?=
 =?utf-8?B?TXRvVGthd0p3dlpRL1dsb2hPZ1EzUlpZR3dDZWNralZHUTMvZmhNUXB5UkxN?=
 =?utf-8?B?bzZiVW0yeFdreUxlWktZbmlIKy9QZFpNNTZ1QWFqV0t2R3VXTDliVERsMG44?=
 =?utf-8?B?a0o1RHk5d2hPdnhvVDBkSlhqa0hhWFpUMUVoWGllMm1uTUdzV2JUSGJMVFpJ?=
 =?utf-8?B?MFUxb0VYb0R4czh4N0RJZ0w4R3R6SkJ3bXQ2T3MzZnZvUSsxTVk3TkRoZm4z?=
 =?utf-8?B?cE41UkhNclBDaFQxdW9wMG9QS20vWGhUbStjUk9pTy9DZ0pqU0w5cXBjaHpl?=
 =?utf-8?B?QkpYek5SRDRWT0xoZzFLekFwVGhwUWRBKzJWckpYVnNVOGI3QmNkYkhNdG9s?=
 =?utf-8?B?MjVseTV3TnV0bDhjemRlYmlNK1Y2WS9OZHdkbkpwNVl6YWFScTdlSUtaYmx6?=
 =?utf-8?B?QkRaOEZQUDlQcWZIWmxNeW5NODBhZml2L3BOV0RxZFlTZ0R3aHpBcW1pMjdu?=
 =?utf-8?B?RWhWRkh0KzdtWDRmOG1oYnNBdVZTM1lkQ1BjanM4T2g0VDFMNVIwUVdTUjZy?=
 =?utf-8?B?Q2YxeFpMSjQ2U2toNmxzQ2FQMkRudnEwZHNlTmxveTFNQnlueFpENlVJeHRM?=
 =?utf-8?B?MTFHY05lWHZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pmWVM4QkRpdFBjaWtBQjlYOHZJc0V0VFFoQ1JHKzZENkxhVXJiKyt6S0pY?=
 =?utf-8?B?YTR6NVJHUmZVNUhsR0t3akFBSnVPSEhwdDFXUDViTEF6UHNLQi9SdzFxTFls?=
 =?utf-8?B?SC9Za3IrYnFpZGkvSEJCM3pwMW1tbGxsK0dWbk85blJnWlE3NXBiUFJhdHFR?=
 =?utf-8?B?Qkp4dENDY1cxZTdoa0FLaWMzWDB1WVBkdnNpVnlPL0hlbUhrb25zSmgxNnNy?=
 =?utf-8?B?ZW92dkYycElmZWhLYkFxTTA1enBJb2wrRllLZGhzRFBUbFQxM2hnOGdYdmVI?=
 =?utf-8?B?SDJSeng4cnhiUXhxZUJldjhjSnpGU0c1dXNTeFZ1QWozUkdFaUIybFo2OVNJ?=
 =?utf-8?B?QW9sMktPYUM4bkVXbUtiN3B0T01qOUlpK09HT3czSWR3QXdJaHhHOXdjR0hm?=
 =?utf-8?B?MGIwWWlSTnpVMlY0cWRhTEhZZjhIcTVCMHpvQ2ZPYmhteFlMQmYwNmhidTV2?=
 =?utf-8?B?anpEemZMVUVkQXNGTEZvYjg2TXVBTlhpWldxSHhMbS9kN2pNQkRTY2c5cE80?=
 =?utf-8?B?N0c2eDlSYlhiekVTbVo3M1VxMUN3akoxaG04YXNuYU1hcW1hUk5GcnVJbitz?=
 =?utf-8?B?cCtCcjdtV1RLRGRlSkY1ZWM5aUp4S2RwNHlQZGR0WjdJekZpRVIvMUpzdy96?=
 =?utf-8?B?WlpFNkFoK0pZVmpucVNvZytmcXA4dlhPOXF0WnoxTjQzdVl2OGlHTHVzcjAz?=
 =?utf-8?B?d3hTaUZBc2VBWXVjeWdDRSs2QVdrdGNyRENkYkNFdXQzVFRtRUVza29LeFZ6?=
 =?utf-8?B?WE9Wc0JDMUNKc0cvZFIrQUZUclBOakJYNy9SSFBHcEFrT1NTMks5ZkhxZ2hE?=
 =?utf-8?B?K0V3bHFTd3publFEZk1kZGJtdE1IWENHblFhMVhnL0lnRUtkZ0pGTUx2NHE5?=
 =?utf-8?B?bHZ5OUs0ZndDd0lJVEJ2cDJhbEkzTEEyclExTlhKSDJPTXpSdkl2eTdnQ0tU?=
 =?utf-8?B?RDh0MTVSelRmQk41Zlp2Zy9xS0F1Z09hWXNLWVphMEpLUFNadmtFeEk2VWZN?=
 =?utf-8?B?ZlczbEFCRkdRcmdMZXlaNGVCYUFxcGRUd3A4YW13QlNEV1Y2TE1PNThtSlVR?=
 =?utf-8?B?eWlvTWYybkNnRmQ2bTE4MmkzdktCaFNvNXMwdTdrcnNnVUhSS2FWS1RyN08w?=
 =?utf-8?B?aEd0VG5vRDhJeEpwbXIrUXVrbmhZZ25ycklrY2dsbWlNdnlwL2JMYlVSeW9M?=
 =?utf-8?B?ZUwvTzhDdis3WnBJa3B0THpvT1Axbkh6ZERZeVJuVW5nK0NUMzZuVnIxWG5w?=
 =?utf-8?B?Vmp3eU0yU3JZdTY1NlRDVFRQYlZMSzY4UW1BcDBNM3FNczQ5OVI3ajYrL2JX?=
 =?utf-8?B?TTMrb2Fid203cW5XRDFKSURXZFVPaVp1WmdDNE5QOFJCZEh3ZWgxK00zeGhR?=
 =?utf-8?B?OGZCYlJ3NXZKaGRJU1FodEMwVXVpOXlUK3JwY2MrNjhQckZUZ09XQ0tUNnlO?=
 =?utf-8?B?WEtpeWVWTjNuTUFFUGVhUmxycmI4RjJrKzRlaUgyVzJZci9FVjdIUW9CN2hs?=
 =?utf-8?B?UDAzMXlIaERBZStpWUtJNW1GYUZHeGMrR29zQitjSUxNTzFjRXVMc2RZTENR?=
 =?utf-8?B?akRJSysvTGdyVzJDZ3ZsSjB5TVNuMDJUTWtaTi9ZNzUvalFxN1FLZnNwMlBB?=
 =?utf-8?B?UWlGZ2g4dSsxZWFBZmpVaVZPQVpOWFg5V0N6a2E4WU5DYXQ3azluMDRJVFdI?=
 =?utf-8?B?dHN6aHNLWXBNYkNvNDNwa29naEJJYjdKR2xlY1Q4NUdrVEZmTDIreGdYV2Vq?=
 =?utf-8?B?OVNiSDAzaVFGdEN2Qkg2c2FrcnJHNk5WVkcyOUhKYWN4Z3k0TWZTbytrUTg0?=
 =?utf-8?B?RmdmR2xVZUJ1NkN5NGNVSThyTmZyZGpoc2NveENkZEVqZzE4UTc5WTNGMzds?=
 =?utf-8?B?VzAvdDIya2VkNk5ZV0pIVlRxVmwwVEd3RmRoM0xCQlc3SUdkL2cvUURGY1BL?=
 =?utf-8?B?T3grZWdvMHVUN0JnOU04d09mSkpFaEFQYmJxZEZ3dVZDOE5oS3UxWng2UTZt?=
 =?utf-8?B?VmtXTExVMzYrNHVJaGoyazh6dzFTZy9SLzIyUGEvb3JjZjRJNDdQbWc1Z08v?=
 =?utf-8?B?N1laelRBOXEyYWt3VDFiV2VycnNyS0d4V2VMNEZGeEFXbFhqZzYzQzVJV2x2?=
 =?utf-8?Q?9CbDcif+BRJFpKHgCxGWTk5v3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e38f83c-e7f9-42ca-2a2a-08de00e3fe41
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 12:13:56.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1x4qtru3UJpG3KLMkD1xkyUYx6B7OoGEL/HzvdavhMJAAlXtnDRsC8O+JvXWHbuRhc0LouHRzfQsQcUv7X5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6899
X-OriginatorOrg: intel.com

On 9/30/2025 11:55 PM, Dave Martin wrote:
> Hi,
> 
> On Tue, Sep 30, 2025 at 12:43:36PM +0800, Chen, Yu C wrote:
>> On 9/29/2025 10:13 PM, Dave Martin wrote:
> 
> [...]
> 
>>> I guess it would be up to the arch code whether to trust ACPI if it
>>> says that the maximum value of this field is > 511.  (> 65535 would be
>>> impossible though, since the fields would start to overlap each
>>> other...)
>>>
>>> Would anything break in the interface proposed here, if the maximum
>>> value is larger than 511?  (I'm hoping not.  For MPAM, the bandwidth
>>> controls can have up to 16 bits and the size can be probed though MMIO
>>> registers.
>>>
>>
>> I overlooked this bit width. It should not exceed 511 according to the
>> RDT spec. Previously, I was just wondering how to calculate the legacy
>> MB percentage in Tony's example. If we want to keep consistency - if
>> the user provides a value of 10, what is the denominator: Is it 255,
>> 511, or something queried from ACPI.
>>
>> MB: 0=4;1=75           <--- 10/255
>> #MB_HW: 0=10;1=191
>> #MB_MIN: 0=10;1=191
>> #MB_MAX: 0=64;1=191
>>
>> or
>>
>> MB: 0=1;1=75          <--- 10/511
>> #MB_HW: 0=10;1=191
>> #MB_MIN: 0=10;1=191
>> #MB_MAX: 0=64;1=191
>>
>> thanks,
>> Chenyu
> 
> The denomiator (the "scale" parameter in my model, though the name is
> unimportant) should be whatever quantity of resource is specified in
> the "unit" parameter.
> 
> For "percentage" type controls, I'd expect the unit to be 100% ("100pc"
> in my syntax).
> 
> So, Tony suggestion looks plausible to me [1] :
> 
>   | Yes. 255 (or whatever "Q" value is provided in the ACPI table)
>   | corresponds to no throttling, so 100% bandwidth.
> 
> So, if ACPI says Q=387, that's the denominator we advertise.
> 
> Does that sound right?
> 

Yes, it makes sense, the denominator is the "scale" in your example.

> Question: is this a global parameter, or per-CPU?
> 

It should be a global setting for all the MBA Register Blocks.

Thanks,
Chenyu

>  From the v1.2 RDT spec, it looks like it is a single, global parameter.
> I hope this is true (!)  But I'm not too familiar with these specs...
> 
> Cheers
> ---Dave
> 
> 
> [1] https://lore.kernel.org/lkml/aNq11fmlac6dH4pH@agluck-desk3/
>>

