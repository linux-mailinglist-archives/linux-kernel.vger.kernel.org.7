Return-Path: <linux-kernel+bounces-869624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD4EC08580
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB273BAD0E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4B30EF88;
	Fri, 24 Oct 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NnrP/TAW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC2288C24;
	Fri, 24 Oct 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349453; cv=fail; b=lTW3+T3vOCkNAoNnSDWoPTjiQwok0ZqH9oqKxDrykf9VY+Sf5bKsWlo8nDcyResjQbw6YXAk7Pg2o6jWgr2Q87F+PxAca5kwpJizoY/iv0UZ2tc8Vg5oEeSv83Y75Da32FblLHSUvlqIrEfKE2pMcwbyYqgunOz79D9l28sXZAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349453; c=relaxed/simple;
	bh=C3iPsnQu4yQWkBCrshyafslI/Ibgp6T3p23+nDFFwcI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YApnIUOHHcZPTbnNTnNcSRPpy/pcSOcAgvLDQ2JIN756CarocCr1Nq/bFhfKkfRUBLTGmA3S+QP8bmptQX1Zqr71uyLBCWWQ7+PEzlpdp6zYxdGvA/T2/cLNXHFGqr9MQ7XqH4FCMGxdk2LYRSlcjY6nhAztRSqy8qRVn6KsXrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NnrP/TAW; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349453; x=1792885453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C3iPsnQu4yQWkBCrshyafslI/Ibgp6T3p23+nDFFwcI=;
  b=NnrP/TAW6aZt1bPpRJcML4OB0RIId75eEDEF4+FsbuB0INkwG+oHUyeC
   zSAbhwcjinyw5hToT2uiHVBCCwwc4xoDPXE22FhM+CJfirZJhlFUWkthK
   Q+rrPhvc5epG3GK7HVN9tGDA/2/kUyxjrFfh5CVffTDiN6bwuY0m+H0U0
   WQl0iIfTTJHZAYCmD2AYcFCXzcqpSrdJANfAME/txvjlfsnQiWXj3I71f
   UGSTu6KChPPFnD79PkV0Pbt0cdbuqrUghpl/raT2fxOXGGsQWcWSkN+Vy
   NY5GDcznlCu7S5/lj/MJ9oKSDTTgXrINPIwFR+DKhhBRE/3VfsOvG/HQQ
   A==;
X-CSE-ConnectionGUID: RzzW+xK6Q76ABz+1q7rWHQ==
X-CSE-MsgGUID: QR3qJ9+0SBCRCSnN2I2mGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74208158"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74208158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:44:12 -0700
X-CSE-ConnectionGUID: I6AyazxRT4ar9vnZmwtwsg==
X-CSE-MsgGUID: EqcGO5xCTuOsTCUVSITrng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="215202994"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:44:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:44:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:44:10 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qra1JAZgEhKFi3+L/MwYHtRoN48bdGIG7hXztfug71QwwhFPVl2U02y8RZgUR768LIIVZcwUMFatRyNK+/iql0A74o0zbNJtCpjXj0KRa4Hl/dN+9nuz4RMGMYGeM9wnx3Ys9RapMpMiOkdm1LYVOIepd8AQHW2ViysGGkk67r4ev7jx5DdDiim0hDGZjs1qPeiaqSH6QRNIptjktMQZeX37Fwjajh/L6FhQk8JEvc7d29Ha7ulkRbTzkoi3CTmvm80c/Qr/hw9GB8Te3i815K1rL7UIxpVfq/o4PKde1n68EVA3q2KJN0poYdrcR6ZU4cDKYEC0MKU66YEqI7R2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24arXm5u7z0t8xa27SASShT1ngFNhJJmU/DpaYSkHQA=;
 b=vx8K6sKP76ImcetZmPRfc93oAZiwsugGFoCelNCgXpFEplwSP0wbFUT9UWiAkp2BgATxD0U38hdOi5YORuNsNQPumPj0z1Z+4f/rei3uMXYDtQF7KBtK6t34RkMPG+DcH1rgrex+V6x9ucUKYWqPFeKlxwzp4iciG00wga06qJRDXOdQjsz+3EivhSXe38ktvpvOUYlah8q28PbUujWnArHA36nzZjg4F5WNDAh7BscZ9eJUQ212X0Ip3I3D0uIQCeNz2mWlZ6zm3mc9xLpBfVMZBrOVo2JfBWwStvm480q6fBFjhwo+DjUGhSYdx/Surbx5tSdfYtKqYJMIDllrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:44:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:44:07 +0000
Message-ID: <a0c92e00-447c-44dd-b7a2-895534cc94dc@intel.com>
Date: Fri, 24 Oct 2025 16:44:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/10] fs/resctrl: Update bit_usage to reflect
 io_alloc
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <022b992dd61b4456220c0ca1fac75d73374922e9.1761090860.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <022b992dd61b4456220c0ca1fac75d73374922e9.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9f1e60-64ab-4c11-1093-08de135738f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1lNckE3dW43R1Qra2dzeDgzMUo1OVNrUmRDZGFiV1krVTZEeE1LWmtpOUlY?=
 =?utf-8?B?RkZiZWlQZldHRGJrQ0w5cFhsdUY4QldkRER1VTNFT2tvaUw3WU5TcGFlTDkz?=
 =?utf-8?B?K1NuVmVHUzh3ZlMwbzdScWxtQ2FCRkVlUFhoRGNMa1FZbklPZ0NULzJjRGJW?=
 =?utf-8?B?RFAvRWd1eDdoTFNxRlN2MzlFYkFtV2F2K09XRzJwSUltMmJNMXZNenFJdlZT?=
 =?utf-8?B?ZUdUUVZvcXM5QWZVdS9jbktUT1NDSUNPaisrUndTUENYU2dkYnowZXdRRXhJ?=
 =?utf-8?B?UXlPQmhOUTA1ZC9pSmR4azFWeFpPSncvYWt5dDRldHJKZk5zNEcxb2pNOThj?=
 =?utf-8?B?ajZkZk1Ec05HTDBrbGFJSUlOSktSZzF6d0dFUWtISDdOUWZIRk1FUEMvZFNq?=
 =?utf-8?B?ME4rNW1ZdDh0V1piZ25jQ29OQ0c1ZU1YZ1lIaUhIeGxYL1JsaHZvVndWdkNp?=
 =?utf-8?B?WVBlVElaRlVyRHBpWXRpc1FRTXFvQi9jaWhvNEtDNEl0eHJadldjM2puYzQ3?=
 =?utf-8?B?Tk1CaHFNRVk1T0d0dW9zclhhY2I3YzM5VDhLSlJqWWU5dEVpWlBONU9UTXl1?=
 =?utf-8?B?Z1crdmlOdVZVNGY5a3lsWWdLUW0vcUl2Wk1wbnl2WEFneVRJbmYyclc5cy9K?=
 =?utf-8?B?V2YwY2pJck5lY3NBTCtuZ0pRN290L3EzdjRHaUI5Mm9BVDBXazhWZ3ErNGQz?=
 =?utf-8?B?dXdaM0pDYi9wQ3VseEl3Y0lMY3VJTEgzbUNBLzVyVzk5Y3hxRmI2bGdhNHZ0?=
 =?utf-8?B?NVFYazc0YnREbFArQm52eXFEQkdYL3A0aW9UejdYcmFUMy8vSTljVFR4QjJK?=
 =?utf-8?B?eGZKREk4dXZOekZUUUZqc0hmcThkOWFWUGtJRmlOci8yWnMrbTI2NDd1MjFT?=
 =?utf-8?B?cldRaGFxWitYSVBKaU9xUGtDWm5idm9lVGh6RzJ1SmxTbzNvVVJsbTM2RzVI?=
 =?utf-8?B?SGVRWU04NUJIT2R2ejRNQkJ1ZVF4VllZNTdyc2FUeHJmazNFaGZTL1p5SnhB?=
 =?utf-8?B?clppR1liTlF4ZkhiaEVpMGxScHdiMVBxcnB6Z3RBaUx2N0RWOVZqcnJuSzRq?=
 =?utf-8?B?M1lwRzZsRzBwaTg0R0hoRWdhV1hSaDR6Q3BLTDkwRFlHWWpMbVFIMUZyVWZo?=
 =?utf-8?B?aHlzdlQ1ZWxtWmoyRjRLRzVlMGdCTm9ibFdibHpiS2xoeHBhRTFZQm5TNHNz?=
 =?utf-8?B?RXlqTVRob2JlclliOXR1MXpLNzBDazBmeno1a2crbHRlalBRMGRtWkdja1pN?=
 =?utf-8?B?RGcwbm4yeEgyZzNJNHMxWnBBYmY4a1o1RG1WUm44bzBobVNlRFBDV3NUOUFF?=
 =?utf-8?B?WkVKcU1Xa0xIalphY3hDKzg1VkU2QkQ5a3JVM01DSGgzVldaUXAvVGRXa2dM?=
 =?utf-8?B?Z2hsenN6cDkxbWJneFk3aE5vV203cVlaUncvTXZ4dzNKU0ZKbE9uVWdRY1Bu?=
 =?utf-8?B?MEF5Zk5yMFQ5cmxKbktoaW1JaklLOE9XMUFMc2QrajhpYXhxeEdSY0hvUWtQ?=
 =?utf-8?B?Nm5TWUtobGpFV0MwcHJMcjNHclZKQkdMM3QvN0pJWGovNlFDQUF4THNXcHpk?=
 =?utf-8?B?K1luYXpNQm5TdHBJanlEZGlsY2huemxrNXp4bTQxemRlTXhrUllvMmJaYWZE?=
 =?utf-8?B?VXo2Q05JSzVSWWNoRXFUa3R6cFE2RkF3U0pvc3BTRzJvVmVuVFVORzk4N3FQ?=
 =?utf-8?B?bDV3OFhaaTlveFhER2dud0syQmNBYlgrTzB2N29kV29rM2ZMR1pnYk9hVlU1?=
 =?utf-8?B?VjNuUm5DeHl2Sko0QmdBTXUycDg5M3pGWlR5NGdyanZSb0VBTEIyc0JuTWxi?=
 =?utf-8?B?TlRqWFBhWmh2eU9vbUV6RXIrNDFoMHUza1hQOVlxR0hHNGZzWFdCaDA5SHdT?=
 =?utf-8?B?ejIxRFFBUXhpakxQM2RMUzVJYjVrZ2ZhbWNMbE5NUGVFaDQzZGNEUWNQS2d2?=
 =?utf-8?Q?K9pcJo5r5TE1RdxoY6UkXPlmB+cxdyNJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm1hY0c2dnk1WkFKakRnR2Jhak9JNEJQRXVhQ284WXJEWWQrSXFPdDR1THVK?=
 =?utf-8?B?YTRSRURYUVBtSzF2ZDBmMVdqUEhTUWJvelo4MHpYdCt2UjFFV01hSjlsZjFX?=
 =?utf-8?B?YnNNZ05IN1U0R2Z5azZYdk5qeHZJRXp0VkErU3RmeXZEUEVLK1pYdDJZRUFl?=
 =?utf-8?B?WHNLV3FqbldKc0ZMc1FqbGtGYzl6RitoWmR5L1NpY01DTGxYdmpMNzdwcnE1?=
 =?utf-8?B?TW83YzdEYjFmVGVJcHhYbk8rMHFJM09UakN5NGFoK2NoZFpidDU2bi9rV3N0?=
 =?utf-8?B?aXY3S1lvQlRIdWtwbmVXcCtUb1R4UGFuZkNwVmhZQ2JNOFU2VnhtNWJaOWFa?=
 =?utf-8?B?Tmh5WE9XZlNsRzdGWTVoU2taWDU4M2p3Q1NOWlNtbjFlWDFxQ1ZWNDR5ckhF?=
 =?utf-8?B?dlBnZjJSZWljUktoSk93dEMzWWMrTXVZMUFzeERUcjBxOFhvNEdXeFpqRTBh?=
 =?utf-8?B?UGV2ek43cTJsVXczQlpXckFnWlB3aThsZUE3aEw5WW42RWROUVNxTjZEWHhJ?=
 =?utf-8?B?dGJud3YyRWRiNnA4Vm5oQm5zYUdMc1JISXYveGMwR1l2QWxaOFY4TWdoZjJN?=
 =?utf-8?B?UU9sam1wakRPY2l6SjBDMGxRTGxzbkZ4RXpHdDBZWXJQbDNFMUFRMnpaT2Jt?=
 =?utf-8?B?cHJodkVXekhNV0xvMnU4U3RrVWRlOW5GQy94NjFuSkdyNGxhWnlTTWdDNER2?=
 =?utf-8?B?U08zcGhRQ3JMaHQ3V0tTdWRVVExyRTNKbnpaZXlCZHZIZm9uTUZDeVVRdkdR?=
 =?utf-8?B?alJJSm1Nb2lBTFpFeDVjYUUwMEVpUUhvYXlqUk9Pek1ZUlBwN0FtZ2kzSWo2?=
 =?utf-8?B?Y1JMdWcrOVYrc3VjSzFQL1M3aHVhekdObDVrYTh2WjdDNmpzbnk1VkdsVDVr?=
 =?utf-8?B?OExialNjakpWY0Z6NzJqK3lZZlRtelVQU2wzKzNKNFdmWXRWVnJwWENZT3JW?=
 =?utf-8?B?d2UvL0xQVkw1dmQvTkdoM0NwUXVZYnVmYUh6WHQ3bUcrUHp6UkJpRGhmaXQ3?=
 =?utf-8?B?Y2pvY2ZXeXM3S00wSmhaT0l5OWZtNEc2SExhazB3Y1pma3ZoaUpES29NbjBU?=
 =?utf-8?B?UGx2R2NWeDVvVm13Y0FHbjk2VGE1Yy9tdjhsY1VWT0t1bW5WNVNoelBGRmZw?=
 =?utf-8?B?Q1pyTFl4SDF2UlVZNE15R1dKaXdsbEoyekJlcWMyQ1c2QXRzdEg2dE83c1dU?=
 =?utf-8?B?QzJIclc2MjFSeHpCeHJuYmw4b1JWUld5SVdzeHZveEk0dkhORm15Vmd4bTVF?=
 =?utf-8?B?TmEzM2hZZmpRRUZUK1YwVXBqS0dlSGVaNGp4STl6R3JyNXFWVmJVRHRQNGZw?=
 =?utf-8?B?NTVnajJVNGZrZWMrOFdJVVFGNmk4RUFsL1l6OG5rQ1hsdjZtY29YK3QvZXkr?=
 =?utf-8?B?UkR1NU5NbWNQUjZObFlIdUZteUdXcC9xZUJhVmdnc3JTN2NwZlNVRmZ1aVlq?=
 =?utf-8?B?LzFwKzFHOUMzZlpHMHV4WHV1cnVrOGJjNW40UVM0djYxbzA3ZjdOaitVRDc5?=
 =?utf-8?B?T2x0M2lHWHduOTZxS21SbWlKMW1EVno1WGVBVEd0NHMzU2praTFuRmR6WlU2?=
 =?utf-8?B?ZEUwOEJsa1dmQnRnRE52Z1E3bWtneEFPT2ZUd2FGSDlITHlJOFh3dXlvZEZT?=
 =?utf-8?B?czBWaVAwNEpCUStOazZwZWlDalk0WFF6V2FTTStLeHhTeGFHbWx1ZFJhaGNO?=
 =?utf-8?B?WjlHYkxCdENOejNGOWRkTTdSbjk5LzB3V0hTS1N5cnVmV05jZ0tYVW1jZ2xS?=
 =?utf-8?B?d2J6TmF0K2ZVZGZwZFllRE02ZVNvejVUd2MwaTk1cFd2M3dHblZKZEMwQnIy?=
 =?utf-8?B?aUxhWnVxQ1FiUVpCekw3VjR4cEVQanZEYXdoaS9TR0ZZbndUZE9GZCtFcnUy?=
 =?utf-8?B?cWcwMTZpS2dxRWxQMlJsVXh0eTdaamJSZGlkZkVtRjcvcTJVMHZ4Vm9OL3JE?=
 =?utf-8?B?QUM0SVBDeXFXVHhKUmNHSHpmTW5LMHhmNm9RWmZzVGpXZVNWL2dCV3BqSktZ?=
 =?utf-8?B?VVNwMHNkTWFrK01MTG5wSjl6Z1VoWXZMQmhiSEV0a0xwbW1HeXdZalErKzU1?=
 =?utf-8?B?WExsNzNKR1lNNG9ZcFhBYTA1dFhiL2U2dEorVkx0UTcvMGplUkN2ZExSMC9G?=
 =?utf-8?B?TGF3QmZqS0d0aXFTaG1qOHp6V3o2cUpnQkkxcU03SnZVZlBqcWYvRzBjcnk5?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9f1e60-64ab-4c11-1093-08de135738f9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:44:07.3149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHmd+oPJNd1SkQL2Ekuwmnx62rm/Jnw0nNvJtgkjX9wra1VTytmdLr18YXepGXWQHS9HVHYsV16jqHofbLSRbuDbOKbDM2yFs62DzEmfEho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:
> The "shareable_bits" and "bit_usage" resctrl files associated with cache
> resources give insight into how instances of a cache is used.
> 
> Update the annotated capacity bitmasks displayed by "bit_usage" to include the
> cache portions allocated for I/O via the "io_alloc" feature. "shareable_bits"
> is a global bitmask of shareable cache with I/O and can thus not present the
> per-domain I/O allocations possible with the "io_alloc" feature. Revise the
> "shareable_bits" documentation to direct users to "bit_usage" for accurate
> cache usage information.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

