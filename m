Return-Path: <linux-kernel+bounces-797600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192C1B4125C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE0C207E18
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4292AC17;
	Wed,  3 Sep 2025 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBWXssbs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAC139D;
	Wed,  3 Sep 2025 02:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866740; cv=fail; b=V+6QbiiBgFimLyg3PvLubvUPKEeLaKtaw+PJSU+IaENAbmpm4hazV8ZWIP/kKTdLvERdedMUG6X+Obgk2GncE0iJEOE+hKnY1NGvsVHIIaI6XDGpzCOssU4Y9rhE6n6ciy7zooAqo1l6VOU5sygMQ74r9yNxBqZ6uesXblp+2GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866740; c=relaxed/simple;
	bh=+3+8K0KMRbxjRH3KvHajrlaC3xLoxNLceQV23nS54zE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VkvRT9H0T05U/TapaiYzKwRw+cp48saoBj+ADTmUPllu6Yna332Kj47bJOEh+8Cz3DRueA+j/wtsfhs27bSHx+M9qLF5KtpJ5ydkBRohtVj1Wt6XhwExcvPlaRe1dPQxVPGI1GJxf1eTWfxsIyPgoC4/WOE4tdcmKSDN7XjsIhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBWXssbs; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866739; x=1788402739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+3+8K0KMRbxjRH3KvHajrlaC3xLoxNLceQV23nS54zE=;
  b=XBWXssbs89cnk3e9qMkqGOmPavmeUJYOW3wGxowuy1PESNWZ0qsH+Ljk
   4NB/9cnJ1YWZdSfXEJMy5vYa86hLplzFZVmHL8wO6aYyIlJDsZLHy2/sH
   c4HEHTRvMcOfF/TVVUjtWDG20xRi1z54xdmxc4mO304Vf031J7nXDs8h1
   QNANsKJ0/e4TYgrr6UHwq38BQYDO0KWUHD1Qr4pQKOSr0X4qaD8426BoU
   Brp2NL9DEREF0QINPUlY62nryHomj8Xbtd5n3qvvB1TaKKJX8wZu0g3Sf
   32toniqDeTMBMl+F3FhrvsJuateVLsoDGiJzFRcltxLLn9ntXJawZC0Kr
   g==;
X-CSE-ConnectionGUID: Vtssgd4nQbGfxEvBZ1K/mQ==
X-CSE-MsgGUID: eW0zMLA4TDyC9oUrMPlgkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59238137"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59238137"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:32:18 -0700
X-CSE-ConnectionGUID: nZYCcP9lTXeVAWh1wg9gKA==
X-CSE-MsgGUID: diX/LGu1SiabXax+LciMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="208669055"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:32:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:32:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:32:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ07qe8OoXerM0Px/V1z+Ja1crw8GHnIDw6R/GxdsT8IjX3K/0jeRmUkl1vKMUCZlm/oshRrwvlGpEGnUKYyh783EjoqFYaTWnt5O8KEOrCIUjNo+uLWo39Vyi6iNiHyxvT5LI+zJ7w2TQMCZPjGVIG/7uiXnGI1gEEPljkM6gsh9PrI2joDr8/b58FEMtdhvZS4MFPVb9rnkyvnAZFKbL/ri1FGyiDvXFziibJMXZmS6wU3t6gV8xIWr2eqJ5shdSEoWPzOUvs6sxwfb5V6G9Cw6Agwu0pFtCLr2yVkqqRWq0Otq6k4jTy48/FFv+eOPr8Vl9ylxlS06sOUPLOwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0Be8xxiO9Ms0Y4iH0jHBLKZsxkBuo+w7+PEpby+iyg=;
 b=fldvD95dyFx28yv8UCyp6GAvwZEGfM3g7yfMVMmIrasdVh2SVBnsLNcWnbkfEjZxK7PFttcNuuRXmH3zUTU4yiC5d29XVZXscqp3XltQA1QsxiduCNvq1QlCxz08ANU7t1A3suucxpUSn5xbX4N2xGjij0ANcHwa7htCFIrNfVjUUfdiY3dLfxIeOk7nfaSJARvAf/FCt2TVWorE/VLMvNEO6p0W1qufvYuSM7avXmWF6yQZNQmWrOVeImaHw2Ns2yMq6hTV/0qXGjCnnn3SxZX03Vmrv9lvRfwa7SVxMhcS6CgJpbncBQs0vFaEoD1Uh0hMdekOi8bQY59JRqpzuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:32:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:32:13 +0000
Message-ID: <cd2027d1-2e99-4390-b801-11c9ccea7dce@intel.com>
Date: Tue, 2 Sep 2025 19:32:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 15/33] fs/resctrl: Introduce event configuration field
 in struct mon_evt
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <a55d37628c51e7f507f73abe6db6ea0539e4fad1.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <a55d37628c51e7f507f73abe6db6ea0539e4fad1.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0069.namprd04.prod.outlook.com
 (2603:10b6:303:6b::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf3ef6f-5299-442f-9fc4-08ddea92170a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SzM5UGRNSGlvczhpVEhzeUl0L0VSbFJ6S1FDd2EyNVVrYy90K2dINU1Pb3V6?=
 =?utf-8?B?MmFYRDYzVHk1NUFUWG9mamowMDk5aCt1YTFzb3VSKzFvTFhZbVR6amw4L1Rw?=
 =?utf-8?B?eVpXbmFmQ25tdUVIN2NuMVVveGI1UFhrWS90YXkxelZYOWxFOGdLLzJ5TExV?=
 =?utf-8?B?N0cxYml1emlTRjFmV2FmMnpNT0dvMjZQU2dkNTNzZ1VSMGE4clFUNTUyck5C?=
 =?utf-8?B?WWZDeURTbHpjUE5teGRCNCszYTUvVFB5LzkzWmZmMlVqOFRNeU8rNVJ4eXE1?=
 =?utf-8?B?dHgrL2RiNDVXYjRMSG43eC9JdXFvS3FVWjJwSmRWcDE1OVNGazNlejVmcmNC?=
 =?utf-8?B?amRpRzVTSHQ1M2JtWkxkZXNoNFhhYldmYVBlZS8yRnBwOGNIYVk5ejQ3Rjhs?=
 =?utf-8?B?N250RGRrWDNOTnJocGpNTlVFeGppZ2VHM0hGM2FrcllzeUhHL3UyQU9nLzNY?=
 =?utf-8?B?U0FOKzZ4bFAxTGhtQzJnRytTSitTL2szNkxST2k3VDdyWUxLbkMyVmFxRzQv?=
 =?utf-8?B?emVOb0Q4Z25uYzNpL0JjUVpVYXZTYVl2ZzhCSXl4RkwvNVRRVi96SnNBQTRo?=
 =?utf-8?B?QmdPakhQbDluNWQ3cGV1d2tZRzJLVTBENU1tMk9CbVpvVGczcmZ0Q0ZNVG1l?=
 =?utf-8?B?d2grbHQ0ZjNKRWY5d0twaXBCRnVVLzBlekhxWFhraGlMVkdRNlhyM2NSQXM5?=
 =?utf-8?B?YnQyVnBXOG5tQmx1S1d3Q0NiaSt4c3lPY3lGSEVJOEJiczQ5cEJyelZaejF0?=
 =?utf-8?B?WWpPbTdNbjRxR1RaQ1MvRndiSTcrVm1uc21mWmkvTFFpWUh2Z01TNGpPOUVm?=
 =?utf-8?B?OFdORTE3dTN5MEZrc1krWnJRUTBGamozaU9VVHVkL3RZOHJoUEVlckgvV0Vh?=
 =?utf-8?B?NVg2SXA4a3RBUGlzSUdNKzRsRng3a0V0TnZweE5yQ2dIYytEWkxDRVUxSzdG?=
 =?utf-8?B?eHg4M3BDM0tSUWtSUnN3NHVMYXh3S3VHRWtsYjRLR3J0bGlhMkpLdWYwUno0?=
 =?utf-8?B?QnpPOUpoRGNrSGRXT28vQTh0NUJleW54amFCcUViQW9VRWRzNWd4bHNVK1ly?=
 =?utf-8?B?bTFiZVA5Ty9iRTcwYXI1L1FBWTlvWHljL2hNdHRJdFY3TlFVQTNhOWNmSVVq?=
 =?utf-8?B?TUtvYVlOcXo3NnBJekU0STYybXpoL2hnRlQ0S2lKQ09BWTNvTnhseG9wYzBi?=
 =?utf-8?B?cjBOb1JpVXdMLzlHRExTQ3Rtak1UNE9VYnJxTTlWR0dJMkNTdW1zWk5XZHQ0?=
 =?utf-8?B?YmtpK0tDeFVpSTVpNmhoQjR3OGtGTnphV21CWWhpeHNBNy95aWJIaGtKaUd1?=
 =?utf-8?B?WjlldEw1SVJ3V2JGWmREVGQrNWQxQkJlNms3Y3RoRmtVY2hrZHFBQ2pMSENH?=
 =?utf-8?B?NWJzRXF2NXBZdnRZeFdBd3daVjZCa0hWRFJYNnlOV1V0Z1cyTkw5T3hORGph?=
 =?utf-8?B?QVpGN0o3T28zbm9WenRwbUhnTFlWWTFOSjBEblFnNnhqNmVqU0pVbyt1TjZl?=
 =?utf-8?B?UDRHL2RLMmE0ZzR6UWhscks5RmRKaURvUytVWjcwREgzWWo2UnNXVERGZTJ6?=
 =?utf-8?B?SlRLdGRCUVM3S3RTbWltNWZUSnpVb1VONHZ1VVpkeFhrNkhJeG11V0ZORURE?=
 =?utf-8?B?RmQ0Q1BPeXdhK3NCV0ozU1JRRXNjK1k3cGNCQUdYc2FoUHRpWGZxUmNCS1Q0?=
 =?utf-8?B?QXNOTDdvSDBaalZMcUNnVmlpL2YzMkgrb1lVWEpYZURTRXJWdHdvSXNMSm91?=
 =?utf-8?B?QUp3M2dIOWlGUEdLeHltOWZ0Zll0UGhqeGw5eG1LQ0tyNnROMzh5a0pEa0hP?=
 =?utf-8?B?OHJYYUU1cDRsd1RRMytDMzJERGRpdzhRWFo0V1ZXcUJiN2hzOXZXb0pFVWYx?=
 =?utf-8?B?NFE5ZndKbkNoekRRVHY1ak9GeXcyQnBIRDU2MVhtY0UyUVdNWTEwaTJpd2ZB?=
 =?utf-8?Q?ZuSTKsWdJXM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXNQd1l0UTRjaGpoK1pUNWVMM05iMnBuK3pDTDZZa1BTNGJxTXVmTC9DMDRh?=
 =?utf-8?B?Qm1mYXVGNXo0L1d0dUJJYUFJWFFFTUtFanU2ZTQzelh2VFA2Mm5hVWJoV3Rw?=
 =?utf-8?B?czN2NFBUZTBEaXE5aE9YeHVBRk1YRDJDTmhZdTZHcDRUZTA2YjhHWkxVaXJT?=
 =?utf-8?B?UXhmdlFyQzNISmQxcVo2d0xjVUtZOVE0ZHNneDFtb2g3WUZMbk9aN0dZc3Ry?=
 =?utf-8?B?Zjk3WGJvUEpjWnhlRHdJekV5SzNLdWFMSHZmclJzNFZTZThQMDc3ZXgvTnFn?=
 =?utf-8?B?MTRRNytjNHRnSjNqaVdNM1l3RithTExJcTJtNXNCd3dXTm1nZzJzZ3p5MlFM?=
 =?utf-8?B?UDlVM0owY2ttTStjYWhzUjdhRkpncFp4S2NUVzcxNG11MnRRSkZpR2pPN0RI?=
 =?utf-8?B?TlFwQjdCakNrREczYkd6RW02KzgwVFZ5eEpOVWdkTWtxOGxXK09XZyt1dWZP?=
 =?utf-8?B?UndFN09BZm03SFIvL2UxRmtQUW0xSU9YQUpDM2xmSjk1STZvTHJoekZKTm9P?=
 =?utf-8?B?R290YTk2czk2bzYyZGpER3hWSFlBVFVJNWthZG1vZXRMMXNMWi9na3VoOVA4?=
 =?utf-8?B?Z2lvZ2VISnk0VWpYSUpGQjl5U2dxdE02akZNSGU4dzBmNFJZSUR0QXBvL0sx?=
 =?utf-8?B?bmdBeVVoMWh2RWFHWENwaitmTTdYdjJxZE9sbmQvSnpKUm5tWEJKMjAvR3RJ?=
 =?utf-8?B?QzR2RFg1RU1QdHgxNVJCSXZ4Vll2QXVTUVh4ZUQ4NjNMMmt0cVlMTS9LZW8v?=
 =?utf-8?B?TWVGbHJCSE95a1VFd2lqTGtrZDlsOU9NYkF5TEdmNjdhYWtYdnZEZ29ocXBI?=
 =?utf-8?B?NnIwNVM3TkVXajV4SzJCelRJNFpLcHplMTArdzM0RHlLb2p3enVCdFpsK1RJ?=
 =?utf-8?B?ZlpnZ3VQRC9XcWt4eGR6WVJxV3RXNmtlczNFT0JxdXJ4eEtxYmhuSkF1VVpY?=
 =?utf-8?B?RDJsMk9zRzA2TXpBY3FSUjZqbTBmdVVYMmRxTVZCMVE1TmZhTnRUV0laK0ZL?=
 =?utf-8?B?ZWtzemdUQWNIRVh0aG1RRnVzL21lNjV2c3NFb1FQZVZtZ0Q1NzIydnlGVlg5?=
 =?utf-8?B?UTBENEZodDhQTEtPTmNKUnNISlJXSjhTdFNrSXRkUk5BY1UzYk1sdWxsaXZG?=
 =?utf-8?B?c1R2TlJ5QUpJdjZRZHJ4N2puZE5aQmJ0UGpLS3NqWUFUb01wam02bEtQWHlN?=
 =?utf-8?B?Q2F0UlAwZURsU1BFeGVpbXNlY1QvVkhtYnR3MWhqK1c4b3F2UHJKblNZWmlk?=
 =?utf-8?B?dXhVVVloQXoxM2hyMkY2M0ZYQ1VzLzdkdEtsZ3BkbG9lN1VzZlNsNWRwTkZJ?=
 =?utf-8?B?UVV3NDZ1ZXRZaGlkaXI2VFM1WnJOS1YxYWgrTzRzS1pzYm9Tb1F3TmNxazNY?=
 =?utf-8?B?R2lIMzk0a1dBYzBucVdXM1RHeTFvWUVNYnNHcldrSFVGL0c4NGczb1R4MWk1?=
 =?utf-8?B?azVDd1ZoZHFWTXdIZ3BnUkJlejB1RHZqQzFGT0V5RmJtTDB4Z2lSOVJNUnlk?=
 =?utf-8?B?LzM2OUhxSHV5RThkZlkzMGRaWTZUTzcxYURTdjc4cER4dUxnWjQ1MlhFd2RX?=
 =?utf-8?B?M3ZTVmNDQ3AvWUkyOG5qL1ZSV3NOMHlINDk5em5ETjR2c09IaFN4bGprazhP?=
 =?utf-8?B?T0h4WnMydXI1UFE1d1ZZN0hNVERkamo1WURQYzZkVXVUcWF2dG1EZXdxN0s2?=
 =?utf-8?B?MnJ6Tmg2L3A5bEFWWnQvTCtZT1UxcE9wR1d0SUpmWjJGS1Q2ekw5UEJTZmoy?=
 =?utf-8?B?QlBydFpPbzZhRzYrbE5NZ0JlL0dQZVJMVSt6SjZoNnZmZFlNTitLaGwrczd2?=
 =?utf-8?B?ZUNpKzZmbHFhRDVzMkZGZ1ZBRUJPdVdRWk5odW03Q21iYkpjMkMzejl4MVpV?=
 =?utf-8?B?ZnlucDhoMGVhdW9ITXc0Q0IwWVV4SmJoMzVXc2JNNnlYVkdZTkIveXBqSGR5?=
 =?utf-8?B?SFFpMVFuZWZLSDE4U0pnS0JpRUxsRklyNDhlQ0FWOEpRY2xYMTliNHh5YnVa?=
 =?utf-8?B?ZzBkM2RkdnRuZmgxdVNWMEl5c3ArVWpxRFZJYllIMnRodXNXNXJrU2szWlU2?=
 =?utf-8?B?bHdpS0ZvditZZnZ1LzNGTWtVWWx1OWd5Tjd5U3N3VEE0VkhuZWZQUUtKNlBv?=
 =?utf-8?B?N3dwT1d4TldTUTNsMHFaRklPQWprS1lPamVnNXJYV1RTWDdyNmlyVXR0Wndm?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf3ef6f-5299-442f-9fc4-08ddea92170a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:32:13.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwWEG+d2fBGwwLSN1F2Sk6OUg9eAJZDmi5/ut4b4VTgO9Wwc2WO2nt9dtN7Gxk8aV76KgixvbdjaVSDTERR3J4jbsxCp1xTS1hNh/cB3NU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> When supported, mbm_event counter assignment mode allows the user to
> configure events to track specific types of memory transactions.
> 
> Introduce the evt_cfg field in struct mon_evt to define the type of memory
> transactions tracked by a monitoring event. Also add a helper function to
> get the evt_cfg value.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

