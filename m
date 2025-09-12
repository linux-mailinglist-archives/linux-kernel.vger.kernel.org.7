Return-Path: <linux-kernel+bounces-814828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A90B55911
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03573A5812
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345928136B;
	Fri, 12 Sep 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+uXqqRK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E727B4F5;
	Fri, 12 Sep 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715558; cv=fail; b=HgeZBp4DsFlXJ2KFNrM6HrpiHztgTuA78lQrCpNpexdVHPfnd0uM6/n14pkTDaZikgeCsn8AeseD2ZormLiMH5B3lwf77fV+BMXmbwcK53178q/x/YasowMl9nhuwPfgJOPc+J8Y9mxZ6sCqK0k2mwZ30UdS0sueVMmT34k28GY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715558; c=relaxed/simple;
	bh=OhYIrFuSg33nnOZdHeOi1SREhx2oeyLIM7479biEbCQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bbx0hTBuqVD1aQKQq1eD3x9KYljC/j8UGb+5o1ganVAZK6sk9OweFy6fxPIi7vEMu6eBB8f9gbmbE8oiT0E3j4xYtQEcsxexthV9SFMxgYO0XWtquvE5HLbQTRfsmj/RM28yE5yNbeXPUsU3jHussJDDT57p8i8oH1ifMMfWQeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+uXqqRK; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757715557; x=1789251557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OhYIrFuSg33nnOZdHeOi1SREhx2oeyLIM7479biEbCQ=;
  b=l+uXqqRK6Bikg98NYaH7Sp4kW/nXO6Zg+romigqsjz5y6/gAVQJ/yZTZ
   FKt6MtTFwe7+Jdqk7BinLSgtqXOzVUxtwVaTmpsdydL8C6y4dXVQ0XIJI
   dTGNBZC8bZ2H+PXl2vOk2lsEU/Th1BVOv6uMhymlQ8TCQy230smwvAoFD
   9MI8mZs5ADGywbHjfRQaSnq5BNUqzNLLqrzRJmvUFthfrxdoeUUBISCB0
   TN28mIV6P6ofXUgMgeme20Eim1LYe4izbQc54BSLjax+nTHSBz+dofz3f
   2XWsOiweFknuI7AOKrtIlZ4WkLoT3fWLEhdppGHaFXwxJE2O3Q4VvEejJ
   Q==;
X-CSE-ConnectionGUID: HgTEx1jZRIi33LJHZmf/3g==
X-CSE-MsgGUID: s5LT0FQzRLeveMa0FBToQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60138649"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="60138649"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:19:11 -0700
X-CSE-ConnectionGUID: IP1rhgkFQ06HWvYRHYrVXw==
X-CSE-MsgGUID: bKKnb/hWSLe40qqvxeAMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; 
   d="scan'208";a="173386960"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 15:19:11 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 15:19:10 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 15:19:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 15:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy67CdhnQuexILCX7L7Z/MUHzcga+nYzumJ9AKYS2MPV3jbfrpkwDDv007+zseKpX7JKostCLLq2bMTIYr7mBTG53ypCigCnH/5Fbb9wE3W1N+9JB28LH6eJNhELgVHcpKgExN7pVzdyUN/mM8m1Hv1KHMcY8om+yMUJnXVDdYEVcUGsAGmnlv/urGfx7KTIoS0qqcpzqqwjHAGw+M41W4sXjHfp7GI5guZNMd6l++padsL1mvSqRz2SZ24mzAlOyc8oB2CrHgNepXjPsloANGgzlig9s7L1FIG0yqRyPAePJAwRNIOZrjmCoSTNJcaUxn933LqrK4BVjbgAqIUXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTdnnBDUb+VaQjypTdyzQ456O0r0lLdBH8ZsZzcvgjE=;
 b=lgeekH/A10NeMmgEPRuqHWJGO4U67RGYW2hZtJRRIDKmdZhlUBEvU3dyIcTzPBVoruOxhKQIQS2+yHJ/3KGRNU/us56H//+NSSzWZePvSXVDDES8Vd771WKR48ZbYGqvTHMY6NKQ7ha/3Oqp+ad4+BG0Se/WsKmsc/ZHioHIr3IoK9JsRK3G0mcIbhi3wWiAuOAXjb6MLLCPO47VKvGQhhVZwvvQ6RRL8IrjTC6Q3Y6qH6nonHpNIn3FV1dnMfEeGiW7hQM0xTUTU2vsYEaefFCiYHo4iWQX83kEHN7EjjSGsihUl2Fcya9Q+LY+d96+m5MPHRpzk1vhjYKT5+oi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7108.namprd11.prod.outlook.com (2603:10b6:930:50::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 22:19:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 22:19:07 +0000
Message-ID: <b38f0459-1373-42d3-8526-e8ef9ac4d2e7@intel.com>
Date: Fri, 12 Sep 2025 15:19:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>, <linux-kernel@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	"Thomas Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	<x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20250902162507.18520-1-Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae94b3a-eeb7-4ba6-5532-08ddf24a63b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjQvZlBqNUptMEU2bUV1cUFnUFRQRThYYlYwOTZtdmRwcS9CS2hibHordk5p?=
 =?utf-8?B?T1k5dmF0TWtOdWxxN1ZXT3BFbXBVNGdSM1p1dmhrKzFycWVVTWF5Wk95cVhY?=
 =?utf-8?B?aUFEcUhCMG9NU1d4WTYxR01nOXlTVUJNT0p6SGNyQXpwWW1uSlM3TG1NR2Z5?=
 =?utf-8?B?dW40NDFJNDFVa1J3eFdyS1dHZkwvZUtXcGlNMzZ5ZVAxUlMzNzh1RmkvYmRW?=
 =?utf-8?B?amFFNUh3TU5LdUpRZmc4bnpwck9ScDlibmlKZmozYktoWW5Wa05FY2tJZkc0?=
 =?utf-8?B?ZGFXM1YycWpDSUh1Wk1UYTJOVnRDK21RSG15ODU3d2ZsZTlJalE3UmNOQTRS?=
 =?utf-8?B?M0YvRkhuekVxN1dwdTM1bnl0RUdlU2FPQjF0VXJMMkNuUGV5MitGWmY0bTND?=
 =?utf-8?B?UXg4Q3FidlFQMEpQOVArNlZnaEJLVHAyRHZrTWo3ZTZ3L0RKbHo4b0dWSVhr?=
 =?utf-8?B?OW1oZjN2NGJlb0IrNHZ5Nml1Mk5IS1M1cnlmTVFjLzlsNkZyaTRPTmR0S3k3?=
 =?utf-8?B?N04vTmM1aC9tZG1mTEt6bXZLanBoY1VHZjBzUGJnQkRpQ3RzSGsvRGd6ZTBw?=
 =?utf-8?B?UTV1bEhyVXlZY242QmdmM3VIdENiTUp6OUNSd2k2ZHVRSlJ4aXhBYkxRdHl1?=
 =?utf-8?B?UVpjYTI2dDcrNkpuYzNkdTBuZmx0cmZWZ0xZbTE0ZHJCVjNYdmZ0cU5ZbUFI?=
 =?utf-8?B?cUxDdS9vU0hGNTROQy80VkJDMThoUXU0ZWVyNUZuL3ZEWkl4dzVyNlBmRFNk?=
 =?utf-8?B?dE1DelJsQlVtelQ2NDFueWZueENjU1JGWjlsVzlBenprb2lBdWJKZkhKUUc5?=
 =?utf-8?B?SUhtK0ttL2JSdDgrem1zUWpnd1AwZTh3bFBnRUZOdnFzTzVaZ2YxS0pkQXZ1?=
 =?utf-8?B?Y2hEMkp4NWFLaUt1OUFEdXVCc2M0czJuMCs1SnlGUGtROGZ3ajhzS3lUVmhl?=
 =?utf-8?B?UUloRTNGTW43K25BN0sxQVhpQlF1cm1jeUZadWFWYVZuWTVuWU14SEFrR1dp?=
 =?utf-8?B?QSs1eE9HSnd4UWpsb1ZCaFBHMTBrOXR6citTZ1UycFA2M1A2RHI1QXZvSUx5?=
 =?utf-8?B?VWxTODRNY0FkMi9TSVJxMFUvNkYwMnpsakxuT0VrVTJtVFl2YzhldGo4VjNK?=
 =?utf-8?B?QSswb1YrNzVHZ1I0RmQwK28vK3ZWTlpFRlRQdTNQQzlNQURScy9XZWwzSzB4?=
 =?utf-8?B?dE4zUHhVL09HTkNoT3pMKzhaQVI4cjNmMnFBckowV1lhYy9rcjJXYW9SU0h3?=
 =?utf-8?B?eEIzRHRVNnBLYlk4VEFndUdvVUU5N3psbldGUXUyS1Q1WUYvRWVWWmIrc1Jn?=
 =?utf-8?B?d0Z4ekt4cFM3TjBqS0sxbkpsU3REbVpDM0pDMlJGR1lLKzlVSUlETGFIN2ly?=
 =?utf-8?B?bytiTjBOckQ4dlJ0YWFIRm9IOEVob0VuRFdVMy9UZzBoczRIbjZmbys4Z3RU?=
 =?utf-8?B?bmxrYWI3TkVETlBRZkd5eVdtY291aDFpbEsxYkRaZVVYeGFYcjdxdDZ0SWZ3?=
 =?utf-8?B?OW5qSkFXWjhDOEhWTXdEUGNHcU9UZndNNEJ6OGZZK2dyQjl5YTZqd1AzUEJw?=
 =?utf-8?B?RnpILzNGNy9SbCtUNHBvTjJYRXFkTDRnMjBxZUlsZnY1YWNvYVl2THY3Vzh5?=
 =?utf-8?B?T3dzUEtBMW95OHA5QXN2NzFPOSs2NEJQclZKOElwUWhCYURVUU0wcHN3TktP?=
 =?utf-8?B?WFArMGU2SUVyZmJxWVp3Z2FMbVYyeTVRODhCcW5iRTRPTUFER2dQVVY3Nkdz?=
 =?utf-8?B?aHhMRHZSaElDRjQzOThiZmcrNVYvVDBKdmUyWHdITjljRkZ5YytZdkJMdGZ4?=
 =?utf-8?B?OGFST3V5SERKYVE4NkE1R01rVFAxb2NVY3BxcEU0RWJLODBTNytzNkFaM1V1?=
 =?utf-8?Q?+zhQ6D/KZ0j5E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0pXRDk5SVNkQ3E2VUZ1cXhteXRhbHBoR2pHOUhiRmdyTE01SDNMRDhxbFV3?=
 =?utf-8?B?MHJOT0pBVnBCSng2VFFmSVpORVJ3U2NzYWtXVEovQnpaSG9vUnlGK090VVZW?=
 =?utf-8?B?TmZwSUVRZlNsdmhUNVI4amJUMFNOa2VsN1dYbG1DUzNrSHd1ZWd1Q29QOVpK?=
 =?utf-8?B?OVJGZVNsbVoyRGxOdVNoOXQvYkt5bXNLenFXb0pkZUo2VTdVdDRrVGh0a1J2?=
 =?utf-8?B?M1F2OFFjZjZidWJqeWxPTHZCVUt6cTlDNjR2UDdXejBrYkQ4dk83WStvRVdm?=
 =?utf-8?B?MmZqMDQ2cmhMUEgvNHFZMEF4bkV6ZHRWNDc2SmxQVUQrYWJoWEloVHdWc0lm?=
 =?utf-8?B?YytMd2wxRnR2bWtOazlLY1VtdDNuRVVZSXZibVdKd0h0T05tNWM5d3dkTERW?=
 =?utf-8?B?NHgvVXVPZTdnUDJOSGt3d3h6WW1ITVJ0OW53WUlYNHkrSkxjNmZwQ3o2NVBX?=
 =?utf-8?B?Q3krNjRYRXl4ZXI5ZUJlNjNGMXdpSWVuU1c0a2dtbzl3aXNHZkYxa0lBMmtp?=
 =?utf-8?B?Q1RETCtqZVhldXZZTU5SbWJmSTNsT3RNK3BrVVZ4MVVUY3ZKajc4aTdCTUw5?=
 =?utf-8?B?ZDJLcklkbjlrRHlUSVRpUDc4aWxnYTJzcFJvcW5YOXJZRFV6U3kwSGRrUEl2?=
 =?utf-8?B?Sk15UW82S3VxRjVwL3QrRmp6cmZTSDVReDhYZ0Q1akN5RGdMWVgzaFFINEJD?=
 =?utf-8?B?NUhUNTRCQTJiRms0N1EzcFpabjFXUVVBNnJHeGNiTWFZdFBESWp3bUdEalF1?=
 =?utf-8?B?RzB2ckpJc1ZHVXY2b0o3dlU3VmJYQmt5RVNWejJDZWEzU3k0QmJlRTVCbkdQ?=
 =?utf-8?B?WFZmNklmckhseFhpMW1VTTZkNDBZYWd6UnlXMk41WXFzUU5aOEViVU1xNFZU?=
 =?utf-8?B?cUhOUnFzbDR3Y1czNVZTMi9JVmI3dGJqK2xGVHI5QTRabjVLZjVNSXh6WDll?=
 =?utf-8?B?cGdLc1lNbEFwRko4SDk2eTkrU2xQcEhzbTE2TzhpOVNsWDZPc0RoRGx5OWNw?=
 =?utf-8?B?V0ZKSW0zOXVSaE9mSkQwd1VpeVpjS0hsdzgvSGhnY3h4dFJDZTBQRWh3bHls?=
 =?utf-8?B?N3hlQmpGTUl6aWlCRC81Wm1XVktaYWx6N2xocUt0QlVodEtLQU9HRUFwWVdv?=
 =?utf-8?B?M01mdUtyYVJJZkxpa0N5UTdtM1NiN3VDeklMVkV5RXN0VTVRWHFSeXJrQzlp?=
 =?utf-8?B?V0Zxd2VBVHRZRWkyVld1eVBYeUtxWWNTM3FRN2VVTkd2dnlKL0MwUm90a1Mv?=
 =?utf-8?B?dnh0ZjQ4T0FtNkhSandocUhhSmZDZWNIdWVacWdXcjRudDU4V1BtemNJdFNj?=
 =?utf-8?B?bFdtTVl1SUJDNzByaExEMVJXZkpIV0owUVBUUlQzR3hFSGdXRXgzOFZScXJ3?=
 =?utf-8?B?cnJZRVNFZjl2T3N5U25MeVE1aVA1WlR0d2ZJcjFjN1FjbmorbHZGVmJ2L0Ni?=
 =?utf-8?B?NjdrSlhtdWk4d0ExQmVsMU9STWxTU2VHem1ReVBqcjRpQUpMVDd4eXd6a1JG?=
 =?utf-8?B?S2lRZit0VFlCcnlPNkZoZXhMenp3cWdXczNEOXhRTExnNzBpL3NFeDlnRnRH?=
 =?utf-8?B?L1o4THVnZXlLQ3RSZEkwaGRYSDRiV2E1R0pTb1poMUYwNlgya1VsSlBQWHkw?=
 =?utf-8?B?VnFFQXMyWWZEWGJXNVU5T1B2ak1ET1M3bEZ6ajdGUHVXQXpCUmhoRzZjL20z?=
 =?utf-8?B?enhCTWVsTUNUdjZ4Q2ZsZm4ya2p4UmRlaU85M0l0UkNPT2VLMEVNMVk3ZmRr?=
 =?utf-8?B?YmhtTlF4cW9ldjdSRVhFYTB4QmhBdHFJUThLcFoybzhBSU5KTDR1d1JUL0VT?=
 =?utf-8?B?SURTL0gvWDRoU2Q0REJMSzBod0ZpdzZsT1NBc2JCenM3UlArcDVPYXA2enlt?=
 =?utf-8?B?SjdkZU1kT01SNzdFS2tNWmZDcTlBc001Y1Q1UklrVGtlN2pjS3ZWRzZhTUIz?=
 =?utf-8?B?WEE3VzBTU3YzSEtFZUQ2Mmx0dGIxWEdMVGVaR2RTL2dGWnZxN2ZIbElUNkhn?=
 =?utf-8?B?Si93L1VLeTh4dEVVYTJiaXkwQktqSGxnd2VuMXBWdGZFUEtZZm5jNENWOGor?=
 =?utf-8?B?UFhpcXFpQ3Q4K3dENkZWT1dza3RsNjAxNFR1bUNEQmsyVUtVcWw1d2l0SVVx?=
 =?utf-8?B?QktYejlOODlXQjBXU01zbnlLZEQ4enRpcWU4b09GejJ1dmQzelJyZ0I1N0s5?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae94b3a-eeb7-4ba6-5532-08ddf24a63b0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 22:19:07.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/8vhU7L8DdRu0tZLel525T0etlsxDmjg1dZEKrVjd5QngJBlDRT+ds/qF0s6o5/t24GmcrGXzgpeK+zWMg9dhtEeSi3Zt9FqKjtICjFicA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7108
X-OriginatorOrg: intel.com

Hi Dave,

nits:
Please use the subject prefix "x86,fs/resctrl" to be consistent with other
resctrl code (and was established by Arm :)).
Also please use upper case for acronym mba->MBA.

On 9/2/25 9:24 AM, Dave Martin wrote:
> The control value parser for the MB resource currently coerces the
> memory bandwidth percentage value from userspace to be an exact
> multiple of the bw_gran parameter.

(to help be specific)
"the bw_gran parameter" -> "rdt_resource::resctrl_membw::bw_gran"?

> 
> On MPAM systems, this results in somewhat worse-than-worst-case
> rounding, since bw_gran is in general only an approximation to the
> actual hardware granularity on these systems, and the hardware
> bandwidth allocation control value is not natively a percentage --
> necessitating a further conversion in the resctrl_arch_update_domains()
> path, regardless of the conversion done at parse time.
> 
> Allow the arch to provide its own parse-time conversion that is
> appropriate for the hardware, and move the existing conversion to x86.
> This will avoid accumulated error from rounding the value twice on MPAM
> systems.
> 
> Clarify the documentation, but avoid overly exact promises.
> 
> Clamping to bw_min and bw_max still feels generic: leave it in the core
> code, for now.

Sounds like MPAM may be ready to start the schema parsing discussion again?
I understand that MPAM has a few more ways to describe memory bandwidth as
well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
schema format to user space, which seems like a good idea for new schema.
Is this something MPAM is still considering? For example, the minimum
and maximum ranges that can be specified, is this something you already
have some ideas for? Have you perhaps considered Tony's RFD [3] that includes
discussion on how to handle min/max ranges for bandwidth? 

> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Based on v6.17-rc3.
> 
> Testing: the resctrl MBA and MBM tests pass on a random x86 machine (+
> the other tests except for the NONCONT_CAT tests, which do not seem to
> be supported in my configuration -- and have nothing to do with the
> code touched by this patch).

Is the NONCONT_CAT test failing (i.e printing "not ok")?

The NONCONT_CAT tests may print error messages as debug information as part of
running, but these errors are expected as part of the test. The test should accurately
state whether it passed or failed though. For example, below attempts to write
a non-contiguous CBM to a system that does not support non-contiguous masks.
This fails as expected, error messages printed as debugging and thus the test passes
with an "ok".

# Write schema "L3:0=ff0ff" to resctrl FS # write() failed : Invalid argument                                      
# Non-contiguous CBMs not supported and write of non-contiguous CBM failed as expected                             
ok 5 L3_NONCONT_CAT: test                             

> 
> Notes:
> 
> I put the x86 version out of line in order to avoid having to move
> struct rdt_resource and its dependencies into resctrl_types.h -- which
> would create a lot of diff noise.  Schemata writes from userspace have
> a high overhead in any case.

Sounds good, I expect compiler will inline.

> 
> For MPAM the conversion will be a no-op, because the incoming
> percentage from the core resctrl code needs to be converted to hardware
> representation in the driver anyway.

(addressed below)

> 
> Perhaps _all_ the types should move to resctrl_types.h.

Can surely consider when there is a good motivation.

> 
> For now, I went for the smallest diffstat...
> 
> ---
>  Documentation/filesystems/resctrl.rst     | 7 +++----
>  arch/x86/include/asm/resctrl.h            | 2 ++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 6 ++++++
>  fs/resctrl/ctrlmondata.c                  | 2 +-
>  include/linux/resctrl.h                   | 6 ++++++
>  5 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c7949dd44f2f..a1d0469d6dfb 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -143,12 +143,11 @@ with respect to allocation:
>  		user can request.
>  
>  "bandwidth_gran":
> -		The granularity in which the memory bandwidth
> +		The approximate granularity in which the memory bandwidth
>  		percentage is allocated. The allocated
>  		b/w percentage is rounded off to the next
> -		control step available on the hardware. The
> -		available bandwidth control steps are:
> -		min_bandwidth + N * bandwidth_gran.
> +		control step available on the hardware. The available
> +		steps are at least as small as this value.

A bit difficult to parse for me. 
Is "at least as small as" same as "at least"?

Please note that the documentation has a section "Memory bandwidth Allocation
and monitoring" that also contains these exact promises.

>  
>  "delay_linear":
>  		Indicates if the delay scale is linear or
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index feb93b50e990..8bec2b9cc503 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -18,6 +18,8 @@
>   */
>  #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
>  
> +struct rdt_resource;
> +

I'm missing something here. Why is this needed?

>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 1189c0df4ad7..cf9b30b5df3c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -16,9 +16,15 @@
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
>  #include <linux/cpu.h>
> +#include <linux/math.h>
>  
>  #include "internal.h"
>  
> +u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r)
> +{
> +	return roundup(val, (unsigned long)r->membw.bw_gran);
> +}
> +
>  int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
>  			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
>  {
> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
> index d98e0d2de09f..c5e73b75aaa0 100644
> --- a/fs/resctrl/ctrlmondata.c
> +++ b/fs/resctrl/ctrlmondata.c
> @@ -69,7 +69,7 @@ static bool bw_validate(char *buf, u32 *data, struct rdt_resource *r)
>  		return false;
>  	}
>  
> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> +	*data = resctrl_arch_round_bw(bw, r);

Please check that function comments remain accurate after changes (specifically
if making the conversion more generic as proposed below).

>  	return true;
>  }
>  
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 6fb4894b8cfd..5b2a555cf2dd 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -416,6 +416,12 @@ static inline u32 resctrl_get_config_index(u32 closid,
>  bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l);
>  int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
>  
> +/*
> + * Round a bandwidth control value to the nearest value acceptable to
> + * the arch code for resource r:
> + */
> +u32 resctrl_arch_round_bw(u32 val, const struct rdt_resource *r);
> +

I do not think that resctrl should make any assumptions on what the
architecture's conversion does (i.e "round"). That architecture needs to be
asked to "round a bandwidth control value" also sounds strange since resctrl really
should be able to do something like rounding itself. As I understand from
the notes this will be a no-op for MPAM making this even more confusing.

How about naming the helper something like resctrl_arch_convert_bw()?
(Open to other ideas of course).

If you make such a change, please check that subject of patch still fits.

I think that using const to pass data to architecture is great, thanks.

Reinette

[1] https://lore.kernel.org/lkml/fa93564a-45b0-ccdd-c139-ae4867eacfb5@arm.com/
[2] https://lore.kernel.org/all/acefb432-6388-44ed-b444-1e52335c6c3d@arm.com/
[3] https://lore.kernel.org/lkml/Z_mB-gmQe_LR4FWP@agluck-desk3/

