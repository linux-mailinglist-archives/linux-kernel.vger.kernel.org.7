Return-Path: <linux-kernel+bounces-724832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6864AFF75C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794D11C44EB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F2280A20;
	Thu, 10 Jul 2025 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFfSXexR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8223AB9C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752117527; cv=fail; b=q5zwZfp1tb/rFJkeqL71sOfUjvCeCsA5Bs953QMllXISRJ6h2gioJ4HG7CGyyjRazfcV73mBxu/acfi5iP1VqhCD5MnctEM+eAG+bBepS/tQiGTWg6Letat2mXIY14vMBek3mdCmfVDmoCN/VruOxNPRQveIlcbI3VlLhMXJQs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752117527; c=relaxed/simple;
	bh=rW5yrLa+rBVdak4JP9AHH+1NfwU5amxL9Dsh+Anu+fI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=od2E6vIbiMEOY2USm0TwopWVg6uQnvh6qnJXQhPSYr7mUJBXVVwpoxpGwv4P6q67QVFsmNcdbP/goMZWXBV7DbneRE/QZifnD3jWOPMdjDuAlaM4M5RInBEnNdEWqCmKXmLFX952hjSxjyWAkeBKoBL7lxFEI0TGHeSxNm2O6tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFfSXexR; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752117526; x=1783653526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rW5yrLa+rBVdak4JP9AHH+1NfwU5amxL9Dsh+Anu+fI=;
  b=LFfSXexRDIRnQLJgj7PjuB4kOnJ24ZNVYSdy+ZjWvyApjMSw8lGdpeVF
   Vjmdcpt4gwaIguYb+gTQ7J5D9aWqlDAWHyYwVbNf77ScVNkh0CFec+knm
   cMVxylA9gcBW7Hjjk/0FaL7T+6wxb9nhxK/OWBeQQlUEi3Bh0uLWV6+4A
   dmMldlqT3jkTpU+ZIjPRAPp9RMj/nCKoR+I0FVPdDOEXMBeP9mxw0Tnfl
   Qgp4n/tdkCsdUTrzU/bu3jBxWvmK4rxmyB/kx3BFpaFmc1ziNPzBPYY/8
   Be8+NnbSqFTvTepKJwJp5Phd3eA32IIC8QReu76b3uyCVLgMTwqf6mDIY
   Q==;
X-CSE-ConnectionGUID: encPBQHETSeFp7+AyReGEg==
X-CSE-MsgGUID: dcuU01bwREaoGb/ZZJva7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54108400"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="54108400"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:18:45 -0700
X-CSE-ConnectionGUID: qsuiWkpySqyq8gk4IWSGqA==
X-CSE-MsgGUID: izW47sxTQC6xjMW65PUBlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="156431223"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 20:18:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:18:44 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 20:18:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 20:18:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6j2FDqAiZPmh73bA6MP7YUa69aa2yseU9DwvEzAbmtkY2kIBMfECzuYlzbuc62RxwrsENg27Qrgg6gLT3uoWzJFeVEFt+1PjFOVIZE1r6P09G7p8cst82exVkYPkHy5qb3w/+SvuhkoR/qThBzMAnEcbYVL23txwQpMT1essraxXCA9kb1GsSlqI7j3OREiA7Q9CuXIWK0s8RToiySB1M+RalHcydGMImnAC81nESXpvQvKUajN6AlIOz93NlHjTM7hk+RhFp8LzCCRAdCx3VNgBYi/IBaptVxrCNoOLT+7vtdsEM3lrf4CVD+DOJXe55pVTp5j0hQQqXb+0tVxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPr8FgoaJSjtEpmtN2M38WRY5cFnSmKGc8EmQa9CoeA=;
 b=WnJ1Ep/kUEtmLKKln3cPqjiZCKnEdd/0UVsfbbKO2/dLThR02nWmZO+DnfziXBm2eSEo59ot7RZeq1ZOchcKd76m5JzcqqKxriS4WRZS/nvj6OJVoXcKcFARveuAwj87D2tvaLyRyRcuIGe1P4+RauEL9YYNoTbE5MxQb5UAIpbnumViymWfZgtwdzPBj7YO0sQ1/BgL+gqOwPLGyLzUaMzKUmQt3yruB9evO2hGp67SF3hhN4WloB3oiUUCw7SZgAKHuZMTfE8Qa1ym+j6Z9qM+ANgsqjYjtLaH44MP06ImYCpyNLUQvi+jhnlqMu101fbL/hxi4RpHOVCTn3jn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MN0PR11MB5987.namprd11.prod.outlook.com (2603:10b6:208:372::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Thu, 10 Jul 2025 03:18:41 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Thu, 10 Jul 2025
 03:18:41 +0000
Message-ID: <6cf071f3-ff5b-4025-8ce7-2f2cceb03984@intel.com>
Date: Thu, 10 Jul 2025 11:18:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:sched/core] [sched/smp] 06ddd17521:
 BUG:using_smp_processor_id()in_preemptible
To: kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Valentin
 Schneider" <vschneid@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>
References: <202507100448.6b88d6f1-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202507100448.6b88d6f1-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MN0PR11MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 02f8aaaa-4d59-4e66-5003-08ddbf607814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUxGZFNsOTQrOVRzUFJYbTRlbXhYMWRxREhZSE1DSTMyNGFMS210OFM2R29P?=
 =?utf-8?B?K1BCd1FxTytPc3VwZGxkdlpjQkxuWVRFRUdtaFowYnRpbk5WRmhxSFFiM1FJ?=
 =?utf-8?B?azh1SzFRUDdFL2Q5UkZ4by9hMmRKV1V0N3NkSC83K2haZlUwbFcxc0tnR2hq?=
 =?utf-8?B?Vk5jYXZsSHMzQUZUU1RpTThUdnBmTnJHVFhmemllY2pWMVR3OTNyc1hXMFdZ?=
 =?utf-8?B?dWlFWGpSQTZlSVJjVUliZXRFMXhMTWY4NVFoS0QwUi8wNk1OZnVsRjNFVktm?=
 =?utf-8?B?SWVWSWpuclFMb1VZbjFJSGlzS2FkczZYbE5TMnRmVmdHSHlGWjNRYnRIa01o?=
 =?utf-8?B?T0I2dEx0ZHp3YWRqNXVMRnVnSmgwOHNEL2dhWkE0bFN6TlBQZkJWc3drMDB4?=
 =?utf-8?B?Q0ppUFN2VTRCY3lBMFlQemdCdHZKRTlpTW9SSlBPc3FYZCt0QVdXS2M3ZjJL?=
 =?utf-8?B?QXZLMC95M0dacG9LdUh1ZDZPZm9YRXhTU243RWUrWm1lZG8wWmNNYUVLKzA0?=
 =?utf-8?B?RGlhMzdTUENueFV5RnJZMWRoZm5IdmRBUHNNaERkaitIWm1Ca2JYU2xEdHRX?=
 =?utf-8?B?OU14N1g2Ykl4Vkdja1ZDN1VZd0ZGd0o5ZXQwdkhPN0hZaURCU2YwMjlkUWto?=
 =?utf-8?B?VGVQR1FoV3R0bWZFTGMrVE5OV1ZJV2diZjkydERyc08rM3l0T3QxSDJFN2Fy?=
 =?utf-8?B?Q2NqOFcyVGQ2cDBRZmhpWHZETjhlVHhueTBsT242cEYzY1k4TlloQjJaeCs5?=
 =?utf-8?B?TENocWs3U3FNMVNzUVVIUGtDcSsyRUhmN0daMVB5aVIrWE1LZFdmSzIxbm13?=
 =?utf-8?B?b2JJdGZxWEtCMHZONmxJMzNTN0ZrUlFkRlNHZ2lET1YvaWVMRGpYZGE2R3Bq?=
 =?utf-8?B?THVPNGZpRDBFWDFPL1BBMXlMOVhkdm4xMlBSVVE5Uk1uUmx6QloxMUtEV0xC?=
 =?utf-8?B?Mno5ODNTNzV3Skh1dXMyb09PcFNjQUk1bEN5VGhYRVFvMG40emg0WFdBcktz?=
 =?utf-8?B?bU45VUFtWEsyVFhGOVcrV3c1MWsyWlJSTnhsTDR0RFdSQzVGL2dQWmk4WGYr?=
 =?utf-8?B?NTNVb1FhZkw3YTE4dmFPUXI0cnRKdE5XbksrWHdqdlIxSGw2R2h3WnlnQXI1?=
 =?utf-8?B?ODR2QWdSaWpsaWE3VVBzODE4bFZCbk9sdDloMVppZUFJVkNlaGdPNTNtZGdG?=
 =?utf-8?B?Y0JyL2J6WUZNMjB3aTV6d2NDbjV4QXE2b3phZjdxTEtuSElGeHBvc1laZUoy?=
 =?utf-8?B?SGYzeWFXb0gxSHNOQ0JNaXBKWEhWMGllNHhScU1pQzZIRlNOa1hQVitld01K?=
 =?utf-8?B?d0xGdml3VUZucXNxY3NzeWhUSHMxTlFtYldmY0JVWGxRekowcWd3R0FZbzZ4?=
 =?utf-8?B?eE1pY2RMMzRwVFFwdGdHanQ2MDB1eDZ1QnJuWmRjZ3VPVUM2VG0xeDZrMlBl?=
 =?utf-8?B?OVFVZnlOYlY5SlZ2WHJyMndWWjVEWkVzUXA5VFZrRDBiUEt1Uy9PTUNaZVFx?=
 =?utf-8?B?bGlGbTI3OFcrMnNaaldpV1NCU0lIUlF0TTFQYjJ4S2Exbzh6b0I0L2ZXUUJt?=
 =?utf-8?B?UXI3bmhyZ1JlTHdMYnVFZXF6QlFxWWdOWG9PbW1jSU5nRE9Gc3RDdTFtT2pN?=
 =?utf-8?B?SDgwRFp5bGEwS0xnVEV1cUI2T01HQUxnWTBoTEc5bEtMTWU0TmdwMnNpc3lo?=
 =?utf-8?B?K3IxTXZNako0cklNTXQ4OUVzY3l4Qy9ZMXU2MzdBVWora1ppbC9WeW5SdC9O?=
 =?utf-8?B?bGFDWkhodDhzTjY0WVJJRjB4R21oRzByeDQ1RDF5QWxneWc1UDhJbTJBRVNk?=
 =?utf-8?B?VjZzSHl3NVlkU1V2Y1p6SFZMdytQclRYWkV1dVNyZWZOLzc1c0pqclFDWmIw?=
 =?utf-8?B?eUxZdUwvU3RydFI4L2tUVUVuTG84V29iQ0R5SzdkNG45alVPdXRRNjZXblRP?=
 =?utf-8?Q?M9pzk6uzBww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndMM2hpeHpxRndIenlTeWFvcDV5SEx1UTNxTm1PTEFuR0ZEYnJ1YTZmN2Ra?=
 =?utf-8?B?K1FtV0R0c2QwK3JBNVV6SzNIUk9nZXMvVXFSUndkSHR4ZjdYd0h0UkJPMjRI?=
 =?utf-8?B?eEVNa1N2UHRBMnBOTVBHV3VpdlNmUDVJKzRaQ0txNittK2lscWJqMjljWG13?=
 =?utf-8?B?c0dFR0VZNGNrc3NwRmhNY1FLdnQxVi8vb3Y4a0lZdDUzTG56WUplbDQxVUpm?=
 =?utf-8?B?VWpFU0ZURXJqMkRoSldXbk9lSDRIZFBiZzhHTzlKeGMwcGpEQ2dER2R2TmlR?=
 =?utf-8?B?LzBGcG9yNkVQOVRGbVA0RXpIV3VCVjhNb1RZZG5uT3V0azIvR1pWcmhEcTVQ?=
 =?utf-8?B?NTI5c1BVVlpOOE5HdFFVNWxjOEZnR0RTSzZBbnYwQlYyVHpJeEdYTWdhR1pr?=
 =?utf-8?B?OWRMWGRxc1dDT1NqcnFVcVkzOVhHeE9vb0FvR1E2TExNb05WUExScDB5anJU?=
 =?utf-8?B?TnFUY1JDOC9BYUo3M3o0bUN0Z2xhRCtJQzJzcG5VdXFET2dsc2JCV1V3bTRv?=
 =?utf-8?B?VlQzSk9EWmVzK0hXUmFndEVUUHRibVVzcTZSNTNlbVIveGludGdoa3NVQXdM?=
 =?utf-8?B?cU1yTGk0TUFGcm1KVDZEbnhWTEI3Z1NsVy9ISE9FOXRmZ0YyL3VrZlNuR1Nv?=
 =?utf-8?B?RE1TR2UwaFRzRk94czAzSndBNitaWUpFa0xIUHhUYnpZaktNMVh6NHZHSWVu?=
 =?utf-8?B?OFhyaWVCaGF6L0J3ZlptWGNoNkVLNWhleTVlb1ZHRUNMMnpBczZLSkRVeU1W?=
 =?utf-8?B?UWFPVHgrUHAwdHI1WVV0MU1BNFBQa3B5aFRlckZURHBTNlZkSEIrMHVPNHha?=
 =?utf-8?B?dStrMHlBcGxhTTFIRnh0Vm1JTmRxY1FlR2JWUHZZMUUxdFlqN1B6YlRVMXU2?=
 =?utf-8?B?aUhRRUF2S2xFMno2Nmk1WFNta2h6eUROcWRxTU5laU5BWDVZSlYrSnlwcWpx?=
 =?utf-8?B?OXU3Zy9Dd1ZGdnRZM3ZSV2VJMFJJWm5IZlZQSUN6aDMrNlZ5MHJKVjNJSFhC?=
 =?utf-8?B?T2lxTFlRMkxmazVOb0trNmtGYmFGRWhtdkQ5MllKK3E0dkxQRG5iZVNkaFdp?=
 =?utf-8?B?b1BXdUVqdHhjeG9vTlpiODRjamMxUTRGaWw0VkVkQXFGQWFWM1dpWGxXVGIx?=
 =?utf-8?B?SFFjTGNUVkt0MEdpSFlPZHRxeU1SUVluNFkrZGxUUVpQTUIxaXRNd3A2WW15?=
 =?utf-8?B?UytLV2VJSi9sWXBaTXFLM0h1MDI0cW5qOHAvRXBvOXhYNzFSVVpqTWFpQ0lx?=
 =?utf-8?B?WDFiNVNNWkRWeGlzVGxqcVNmZTFEbUx5K2Npd2tudjhQYVlzbSttL2lNZVh6?=
 =?utf-8?B?WllRNEpWejkwdXB6YjJKS3oySzZZQVp3RDJUaUYxZDV6NTFxVEFScmZzejVs?=
 =?utf-8?B?R2ErcXZHTEJJdGxtK28vbVh2L2FsU3FWUzFJZ3BocHQwVTQwNldTMTdjYnRs?=
 =?utf-8?B?VXBaWm50T3drVGdHZUZ5T1I5TCt4dHlCMzJ6T0RuV2JqNThZYnhkRy93bWtN?=
 =?utf-8?B?bUJuSWdMVkRvMjVWTmx6ZUlZUFJsaXdSOWltNUxObzZaYkFXUyszSzZMMWhj?=
 =?utf-8?B?TGVNcGRrTjJ4S3hXUVJIRFYzaC9CZytDRkkzaVdJR055cHBkbytzS2hMWHR1?=
 =?utf-8?B?TFU2RUZhdjd2S2RQbCtBY1BNUGpOOVM0a0w3QkhEM1Y5YTBpN0NaTGt5MGZo?=
 =?utf-8?B?emFDc2NVNUJLNW1yMVpzcUMwMnFBWnlyM3pGQ05iemlnRXlVNjZnM0c5UGQ0?=
 =?utf-8?B?eFJ2bDhpQkZGY1F1cHc1bXhQRERqWWhDcEJjdFFEazlCMzkvekpjYml4V3Y1?=
 =?utf-8?B?ekdiYzhjUXRRTlMya0lKTGVXeWNndlZveUdzQ1FHNlNGd1dmSDZQdFRSNkhP?=
 =?utf-8?B?Y3M4enhDR0hCN2JhNVAyRjlCVDVidnJsd09FZjBqTjhxMUJkR0QxckozK0FG?=
 =?utf-8?B?ckRBbkplbEhOOFF1VzRLd0w1Wnk3aXZyY1BPZXk4bXNEcmRSZlRsWVlxODdN?=
 =?utf-8?B?c2dKL1RTUmV5d0dwbkNQY05BditsbFAzOUZscElKbkl1K0xMTCtNWXNOT1Br?=
 =?utf-8?B?RG81TnJkSjJXZ0VQVG5UT1VJVDViTVR5TjQrdHVnNGp4RVhUZXNWQnpOcmVU?=
 =?utf-8?Q?P8b4X3i9J8g/t8xAHQoI5j1lq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02f8aaaa-4d59-4e66-5003-08ddbf607814
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 03:18:41.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZiChFWdmaSBRSr+/aDdavMx4o+zDYnF+oyiCTFlXBd3wun3TIinnN5dMZoFtroAE+5JQxzgZpsY/lvlvWJGTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5987
X-OriginatorOrg: intel.com

On 7/10/2025 10:58 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:
> 
> commit: 06ddd17521bf11a3e7f59dafdf5c148f29467d2c ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core
> 
> [test failed on linux-next/master 835244aba90de290b4b0b1fa92b6734f3ee7b3d9]
> 
> in testcase: boot
> 
> config: x86_64-randconfig-123-20250702
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +----------------------------------------------------------+------------+------------+
> |                                                          | cac5cefbad | 06ddd17521 |
> +----------------------------------------------------------+------------+------------+
> | boot_successes                                           | 20         | 0          |
> | boot_failures                                            | 0          | 18         |
> | BUG:using_smp_processor_id()in_preemptible               | 0          | 18         |
> | BUG:using__this_cpu_write()in_preemptible[#]code:swapper | 0          | 18         |
> | BUG:using__this_cpu_read()in_preemptible                 | 0          | 18         |
> +----------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507100448.6b88d6f1-lkp@intel.com
> 
> 
> [   25.232998][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> [ 25.233645][ T1] caller is __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2789)
> [   25.234128][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc1-00023-g06ddd17521bf #1 PREEMPT(lazy)
> [   25.234931][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   25.235357][    T1] Call Trace:
> [   25.235357][    T1]  <TASK>
> [ 25.235357][ T1] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1))
> [ 25.235357][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53)
> [ 25.235357][ T1] __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2789)
> [ 25.235357][ T1] ? __cpuid (arch/x86/include/asm/paravirt.h:179)
> [ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223)
> [ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223)
> [ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223)
> [ 25.235357][ T1] vmx_init (arch/x86/kvm/vmx/vmx.c:2808 arch/x86/kvm/vmx/vmx.c:8653)
> [ 25.235357][ T1] vt_init (arch/x86/kvm/vmx/main.c:1072)
> [ 25.235357][ T1] ? pi_init_cpu (arch/x86/kvm/vmx/main.c:1067)
> [ 25.235357][ T1] do_one_initcall (init/main.c:1273)
> [ 25.235357][ T1] ? trace_initcall_level (init/main.c:1264)
> [ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223)
> [ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217)
> [ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223)
> [ 25.235357][ T1] do_initcalls (init/main.c:1334 init/main.c:1351)
> [ 25.235357][ T1] kernel_init_freeable (init/main.c:1587)
> [ 25.235357][ T1] ? rest_init (init/main.c:1465)
> [ 25.235357][ T1] kernel_init (init/main.c:1475)
> [ 25.235357][ T1] ? rest_init (init/main.c:1465)
> [ 25.235357][ T1] ret_from_fork (arch/x86/kernel/process.c:154)
> [ 25.235357][ T1] ? rest_init (init/main.c:1465)
> [ 25.235357][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
> [   25.235357][    T1]  </TASK>
> 

I took a glance at the warning, before this patch,
is_percpu_thread() always return true when CONFIG_SMP is not set.
After this patch,
is_percpu_thread() checks the current task's CPU affinity.
So debug_smp_processor_id() -> check_preemption_disabled() ->
is_percpu_thread() might not always return true anymore, which caused
the warning.

Actually the issue is in __kvm_is_vmx_supported(), should
we use something like this below:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5c5766467a61..9cba7b061892 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2787,19 +2787,22 @@ static int setup_vmcs_config(struct vmcs_config 
*vmcs_conf,

  static bool __kvm_is_vmx_supported(void)
  {
-       int cpu = smp_processor_id();
+       int cpu = get_cpu();

         if (!(cpuid_ecx(1) & feature_bit(VMX))) {
                 pr_err("VMX not supported by CPU %d\n", cpu);
+               put_cpu();
                 return false;
         }

         if (!this_cpu_has(X86_FEATURE_MSR_IA32_FEAT_CTL) ||
             !this_cpu_has(X86_FEATURE_VMX)) {
                 pr_err("VMX not enabled (by BIOS) in MSR_IA32_FEAT_CTL 
on CPU %d\n", cpu);
+               put_cpu();
                 return false;
         }

+       put_cpu();
         return true;
  }


thanks,
Chenyu


