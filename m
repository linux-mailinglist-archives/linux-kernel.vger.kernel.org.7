Return-Path: <linux-kernel+bounces-813906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF9B54C92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613F37BAC88
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E69305063;
	Fri, 12 Sep 2025 11:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jU+vyyHK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CB304BDF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678392; cv=fail; b=cRD3uC5KURthwQPLBhnAqRUXPmbU1xt7f6aegiHDW8r1xBOdQi8UvCBPROzSYCzSOg2OdkqlEELOt1w/WJwb2tuHXuguXMO5KZjdgo2UAFrK/Hqa9GaABEYHj8o1Isb68PAT4YrucvOKQ5uLb418KnkCS2GUYQNczbIk9hrLBi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678392; c=relaxed/simple;
	bh=vOn5UQUCI3WDT9RwNN5DApSOtTB6L/T7bmsvm/xZbQY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tFI61hDeMiogLD3UoQ/SRnklAO3GKSLVPBpBSJW9aDKuBkimCfLDrMBhCAB7GHTF4pzR8NcGV2WPV6DihzhtrPIpALYdAq+8UWRPbkCMFkopfa5108Xu6UNUaV8PJedKgsDFXQ8uJf3yUqmArutH2dlewwNb52C+WmqUhyh1+dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jU+vyyHK; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757678390; x=1789214390;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vOn5UQUCI3WDT9RwNN5DApSOtTB6L/T7bmsvm/xZbQY=;
  b=jU+vyyHKTjtFy5ZYlV5U5cLIqQPTL9igr/jMT4urKGQ3NgBDpmWRYXVY
   u5zuhl5Y6ehV3zZuvN9sBrY2q7Yn+MnlRP+Du9JDI5ycPraTPHUc6Urd4
   myQ9UJCFjopRDyLiZp29ZJflD7HOvUhmd+X9rpWmsfSvxmEtzjxxKcUM3
   5NMJYFiQBbdLJLNmnjybH/666v/U6as4TdUsYee5FKTVWVac3KoAc+tSe
   GbDmOf2zy7h8qpVb79pIiyvfVu9kCD+cZSHlmrhzfwiQen+PjaslotbaC
   u7i06r45XeQp49YVJyyEtQPcL5iHyr3vmmU7QLmJegQjsMslH79UrwIQw
   A==;
X-CSE-ConnectionGUID: ukY438zvRgawTeYZ1quQxA==
X-CSE-MsgGUID: /8I3ZJzCTd6Th1V7gZYvwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60084710"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60084710"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:59:50 -0700
X-CSE-ConnectionGUID: vgQWs2PLQIuP/Ru5CCrLYA==
X-CSE-MsgGUID: pVWomVyGSFCi0Ewi/CdKpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173780471"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 04:59:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:59:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 04:59:49 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.40)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 04:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLmm9Df6H1rW10PVIFCzRVf4XU82KUZLtLeZaNOe90+FFw9dK185sybJFuMAuVnEr9pNuSZXikURBmXzZ0pFONpyXgNZdJWXABX6qxBkfZ0RqfINpBdSlgm1njJN6f7e0NlqSKJoXr84WvIlFvnJ077xPqUfdj0vlqHY7hItm+BoiYCoxMyZFt0b8EzIoJwHhjrlFRmAUvsX3aTBLahTxVMCDUWFhPzCIwEbjAW1aBk7DIInJG42Su2DCF400UYsREOvWIlCvFrtg0voi45OTCGVpV64QXHgIZpZblsc5dVUKN+J5pOdddW9vb8VHkKzUr85lIkVC3Rly88HEqnDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NwA1DxNuYQ1Z3IxnrWAnKmkSxf4DOwN1IKJUWgpBWE=;
 b=CE+PhU/pZw9jGMniWrX2868jnLXbGwmbbYxW+GTV2NoO8Bb3Gv6U/iTlQ07cIQbOnLRvRo4SUrnNqEMSjpim9y6l28YwZB3DzMILwoeK4qUd/zEeoF7pCU71f2EZFPA+vY2wN0JAw+sid8DVNURqeZA506a808xnm8FSCYJP5FjYY2xcAd3nweqWUqZlop1+Ae4hEuecLadMkNgCUEHn+FNYm6Eay69eWHVya5Me9leLXu5XY2HGJ2hxP9dlrWWlRkyYMsMyL+jBp0horJtqcFaZgnuWAM+LKKgOmGa36xcJMskCP/RQ99aQ9XomtwomWi4xWS6t31T7gAwa1OPJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Fri, 12 Sep 2025 11:59:47 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 11:59:47 +0000
Message-ID: <11ae46c1-9a4a-4b4d-9e32-6213bb43f4f8@intel.com>
Date: Fri, 12 Sep 2025 19:59:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
To: K Prateek Nayak <kprateek.nayak@amd.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>, Zhao Liu <zhao1.liu@intel.com>, "Vinicius Costa
 Gomes" <vinicius.gomes@intel.com>, Arjan Van De Ven
	<arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
 <9b45b33c-3bd1-4075-98a3-d8f5cfc08785@intel.com>
 <71b7352c-2c27-49d1-8bff-c0500cfa21f1@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <71b7352c-2c27-49d1-8bff-c0500cfa21f1@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: aeaa100b-a572-4999-1309-08ddf1f3de90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2x3SmFMQ3JDbUlwV3NSYXZnQ2dHcERLUFBXSWYvVml1REl3WVZQa1VDSDlp?=
 =?utf-8?B?bkY5TjdnSUFlWlQ2TFJlYkRxaS9lVHRQenlvSzl4bVVDbUhvWnh6OVZic29V?=
 =?utf-8?B?NE93aFR3cEhpVUpYTWtNM05TQXBQckxBeDltNEN0VU9vZzd0QW91TkgxQTNB?=
 =?utf-8?B?YUFISHhSWlVKQWhTTlZLaTdHcmk1aWI1SkM5WE04azVMa1pXUFdvQTd4RWY5?=
 =?utf-8?B?MkNubEFKQk03S2tJeWNSMEsyaUliZzZkUk5TS3hTSDNPZTlEWGtZTnpTdFYw?=
 =?utf-8?B?U0w1MkZ1SzcxQzVFQWpTajJ5Uk40ZlJTMG1TQnF4Y2Q3a3RrRkNXejZTMEtO?=
 =?utf-8?B?SCthVFNBeTgyMCtPN1lhOCtSb2RjQy92YnRKMDMrMzRFR045cXZ0SGNVUU9s?=
 =?utf-8?B?V0pzN0hxK1FQZEk5Uk9MTERVT25VeFEzclVoWHBzd2dHSnV1YjVXTldQZDFa?=
 =?utf-8?B?T2ZEK1h3c3c5R1RMYXViNTRaMzQzZUl5S2YwbWJTSEpEODFhQkdYTmRuSTds?=
 =?utf-8?B?NkFKZ3FRUGpwRG1FM0NmWHJTdnRTcTgwTURId2ZEMUdER2d1MXcrSGVhNTRl?=
 =?utf-8?B?WjIxeXpYbUU5b0w3OXRrQ0ErUXpQSTBLaDc2c0crSENVV0VXWmtrZzU4TXJs?=
 =?utf-8?B?VHoxbFJYOEJUQjNnK242NmJobSttRHZxcEdMYTh2Sk9uZ3lrbE93VWhGSFVt?=
 =?utf-8?B?R1JhaDQva1RRWTBCQVVoZmtpVG10WUFVbWdtRmNmMUVTa3NhV1MxaHBRNzB6?=
 =?utf-8?B?VEtFTlZBcnUwYkRtbDR2VWFkeXQ0Y1F0L3NuL1BCRXc2S013aEdTYzI2ckph?=
 =?utf-8?B?U2w4d3lydVRaWWMzNDRLT2lvNGkzY1lnQ0Mvd2xibEVxVVRUTzZ6d2xjU0xQ?=
 =?utf-8?B?RzUyY0hkNStxdXB2cW10Z05Od2NKUENIWDlXUG5sSTRxdWpnZ1Q0OHd4TlB6?=
 =?utf-8?B?SzFzYWdydnRwNDNzdUd0djFHeGZ5WlplMjVjeDV0SUtGY2lJWEIza1JNb2o3?=
 =?utf-8?B?cVltOUM2dzJFNUpIUnBtVnp2MzR3SzUxN3FMdmlicHU5eDlNVmJRRlN2UklM?=
 =?utf-8?B?WFJYQ1VRcUIxeTRQMzZJbE05TWRmNGhhWTRtN3cyUmI0UE16eXZVa3F5S0Jm?=
 =?utf-8?B?VlB3ZG1aUm5sWldCTVBtQ3FXWDE5OVRlaXZLbDk5UzN6b0dsZ0N0Slh4OER2?=
 =?utf-8?B?QWpvdVR2TWNVRmV0YW5RKzZKWncxWVRFb1pyaXdzRS83ZzF4T09ack1pMTJq?=
 =?utf-8?B?RVljZ1ZwOFJhU3dJUWJQclFYbWl4c2wvTjdKSHJwdjFDSVNodlNuRGhHNGVo?=
 =?utf-8?B?Ynh2N1czY2QxbjZQZEk3QnFFelErQVM1U2UwL3Bqc20ycGlMQ2hMaWRmQVNo?=
 =?utf-8?B?S0dac1IzRUF4Wm54N2lhZngwcmE0LzJFa0lteUU2MllqVlZHaDAzVVV4cURt?=
 =?utf-8?B?akJwNVAreTl6NzB6eHQ0SXBTRDRiZTlXaDhkbnRGV2hEQjJFcXU3SUswUENQ?=
 =?utf-8?B?UUJoNnpnUzFPdVpMbi96RlFINkxrSjFQVFNoVmJpWUROK2h3VDJOVTVwbTNa?=
 =?utf-8?B?TFBMd0pDeWxqVm1CNmljVUdJekdNaDBvbk5hc21WUWJ0ZnN1YmpaMGFSTGhi?=
 =?utf-8?B?dDJOajlWNFh4anFRaFZKQklqTWNJR0pidnU3SnRtVDBlSlE2cEt1cy9XMmZ2?=
 =?utf-8?B?bFQ2ZmpZekJSZ1V4YWtDMDlodHR2elhlanExUUdQMjFNUE93blhWOW9zYnpu?=
 =?utf-8?B?eTVqdmxmbEIwZVNOTSsrN29Vd1NFSzAxaG9CWHg2MWtpNStFM1BORytEczZo?=
 =?utf-8?B?NHlJN3FaZmVxL1cyV0N1dTdOZGFta0ZSdWYxVlBBL2lRaHNyQ1ltRDhaUHBu?=
 =?utf-8?B?bDdjdEQxdTY1VE00SUJlZUdNNzNhR3d0K2pocFl6Q2RwV2oxMGg3S2hKTWlx?=
 =?utf-8?Q?mdOOoyqU6IA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXE1KzgwTll4RVF5Smtvc0s2dEJWeEtJQUJOWFREZFNIdU53SEQ2Z2JaT2dn?=
 =?utf-8?B?SkdIWnU3eG1TRlF2Q3ZLWGs1K2hUQlpBdHEvTWFraUM3SzdNR1l1ZXYvWk1i?=
 =?utf-8?B?OXpKaE5Ib3ZsNE91am00Snh0dVp4aTJPRHBOQVFOeTBwU0IzS1FkWVN0c1g2?=
 =?utf-8?B?M08wYTJmeVBnRFNsbGJkQkVUYnF2ZXMwRDQ3Z28xaTRSSDFPeGRjV3FKekhv?=
 =?utf-8?B?SHR1RDZjcmN4b3dUZzZOT0p2eTB3MWtDT0NhWktLWFJSRkFtZnhSc2ozaVl1?=
 =?utf-8?B?Yjd6ZGlhM3gwamNzOWF5Q2YzZWdpRS9KMzN3Y1hJb0t5eVl3SUt6TGp0U2l5?=
 =?utf-8?B?M00yeDdlSFRCeVUrcUgxMEZrQWtQRE9qVGRFaFg5QWlxQmFBOVo1YkpvOHR3?=
 =?utf-8?B?YmhMc0s5ZnRPV1ZLUm1mb2hickk4VURiRFpXTXkrV2lFZ2hSSEhZd3JPZkMw?=
 =?utf-8?B?SVJyWjlPQ054bXVyanFJV2ZGVDR2NVRvV296THpLVFVrdTJQYjd1MFZQTVd0?=
 =?utf-8?B?dnhUSGpFbUJFa0pYS1JCbDUxV01QcmFoUVUwRVNyUUJjK2lkMHlDQm9lS0VX?=
 =?utf-8?B?L1lGMzhuQ1F2Qmc5T01hdnNpZ2xEOGs4cmNEdzBFWnF2eG5qYnUxRENRdFMr?=
 =?utf-8?B?cS96bUkxbzBoeWJ6bmlYOU5QVVZld051c3RTTTdzYktuU3BmQ1BWSzRLZC9U?=
 =?utf-8?B?VTB1STJwSy9vS3llVDlPbnpnSjVsUUN6Nloxc29sK0F1dTVCR0ZaUkpibjBw?=
 =?utf-8?B?UDVaR3c0cWZaenBPMWgvV01LZ0dWMjl0d2o0MmFyTXRTS0s0TzBYais2TktQ?=
 =?utf-8?B?UGVNV3lqY0JWSXpqbHZYbGNWTEp5cEVQZGNPajNDays3ZzdwTmMzMnRIS1BC?=
 =?utf-8?B?WkN2ZUFKaGJnRDdaV1ZqUUVHOXYyem8rL3ptS1Fja0dwbzVsMDNPdWUybU1M?=
 =?utf-8?B?NXY2R1FpR1R2Q1pPcXZ2eGhNM3V1UXZCdzE0dUFTZXE5MWdGYVU2Mm5Qc1hC?=
 =?utf-8?B?MUlNQmJ3eVlKanAyaW5waHA5b2l3TTFzY3NXc1dQbGFqRXViOTRvakdYUjNo?=
 =?utf-8?B?Z2thNHd3cG9OY2QzMlFpV0ZxUUlIUWk5bWZTekFuVHlGdThTdFVXU1luMm96?=
 =?utf-8?B?QUpLUXlTekxxNWs4SHlVM2ZDR3I5WjdiUW41MnppdVY3Y0kzdVhRcmN5MEpa?=
 =?utf-8?B?V3BKQnVDMlZETzlOOE5XUHVuTTlCL1J5Zm9GWVA4OXFyajNsaFJnazJzalZH?=
 =?utf-8?B?dFI3V0tIKzFkTkNYWG5tTVhyUGk2ZmNlQjB4OWprT0Q3Y2xja2JaQlhXYWIy?=
 =?utf-8?B?QmxuTWZNc3RGeEVGbWVOaUdFZUpiVERzRXFaTkVlVzVIT1lPbjQvbmlqNFA1?=
 =?utf-8?B?cWJsUjRLWUxUWHJnd25XNzlmVmVVaW41ZnhFLytVamNWL1ptd3BEaXB4dzhu?=
 =?utf-8?B?N1RZZ212ZjFsV1p5dWtlZ3UzUFVtWWhiU2NDVy9lcFdRWE1YU2VHS2VJa3BR?=
 =?utf-8?B?RVdNc1RiZHQ5dFRPV1hFQjFKNnRQZGR6UHUzc29PY3FmQkZVc1NMV1ZXMVNG?=
 =?utf-8?B?MFBqVlByRTk4RlRvYk9uc2dPSzExeTVndVZuZE8vYjllUmtTb2tONGd6NVda?=
 =?utf-8?B?VXRwMng5MWloTS9GSi9zeTQrOXVQVUZrYXJIRU43emJLVDd6cmV6T1Y0MEVX?=
 =?utf-8?B?TkRBOHQ5TXcyTVl4UVU5THhNNkoxZWV1M3V6Wmk2VmtyQmtXS1k2YlhabXdS?=
 =?utf-8?B?c21YamtTQTlNSXBGVWszdmxIRDYyQjRaa1FSUFJEU3AxamhhOVl1d1liQ2Vo?=
 =?utf-8?B?a0ltbmVIRi95bExFdnZ5RVhxcEVRK3pjZUlmSHZBcE4zbmhJeDlEa1NIN1NS?=
 =?utf-8?B?UlVJSXMwQnI5MzZKZEw4K2NhRnU0UVdPdS9rNnNTdVBvUk83N3JXYXRWT0Zh?=
 =?utf-8?B?ZlArVWhVcEdvRUNLNjA2SUFudGVoTmI1QWIwY1FHUy9tUmFtSTBlWkx5WVM5?=
 =?utf-8?B?cS90T1VlTS9OSkRmR08wVHpJWVBFeExMWXZQN3VodEVQQmVMeUdxZ3RhS0do?=
 =?utf-8?B?S3ZPdE5HaTdwRXJMejNLbERQaklQdzBMcDZoNTN5MldvUFM3TFFBdHRKT0pF?=
 =?utf-8?Q?lHe2q1dVLR1TEI+5j3U4fTbR+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa100b-a572-4999-1309-08ddf1f3de90
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 11:59:47.1639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfZ7FW1LOyG8jjVb+L452W9mVx2u2mO3oggemZ4/0sUGQ5b70EbUjCGk3JP6hAhUmPRh3fbz/Niy4QtVlpjHYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-OriginatorOrg: intel.com

On 9/12/2025 5:23 PM, K Prateek Nayak wrote:
> On 9/12/2025 11:09 AM, Chen, Yu C wrote:
>> sched_avg_remote_numa_distance is defined in topology.c with
>> CONFIG_NUMA controlled, should we make arch_sched_node_distance()
>> be controlled under CONFIG_NUMA too?
> 
> Good catch! Given node_distance() too is behind CONFIG_NUMA, I
> think we can put this behind CONFIG_NUMA too (including those
> declarations in include/linux/sched/topology.h)
> 

Exactly, only NUMA would use this function.

Thanks,
Chenyu

