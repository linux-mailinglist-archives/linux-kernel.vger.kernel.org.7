Return-Path: <linux-kernel+bounces-836978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DDEBAB033
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD1919243D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE920B80D;
	Tue, 30 Sep 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IurS/WiD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71422069A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199350; cv=fail; b=uu4/yIrT38zljt2YPN/6WZrKr8NeR9vxqQJk/nzotQe92qMu4fYRLPxbnzuPuMhdRs9NNsgbvUfDtYWeJjitAl8ZL58NrAWL87TjWbHeO6LIwSkEIGzgq/kaRR1crPVd3CQbiX3NrLb6HnTRUNdr/8cnxrqGsdCo9UGZkUXMzfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199350; c=relaxed/simple;
	bh=uTST/1eJNEEFfTRXxMc0tHWn3EG7DYV/zIuf/JKcf6k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TIx2QC0rCrj/EfRvtnD9ZDkL3/9Y8k1KqCVMddU00F9tUUhF5qVNcMjH7rsJuk7FE9dlZjqW0TR6So/t+6B2gtTQpkLYoCF0pTlaFlwBFZ7RF5YoWt77EPXpCamJpFqMvG1Uqvnf7ptdW38wdJEWtfe0dllGJIhiY+Nwxv1fPC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IurS/WiD; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759199348; x=1790735348;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uTST/1eJNEEFfTRXxMc0tHWn3EG7DYV/zIuf/JKcf6k=;
  b=IurS/WiDxQ9ks70nfphR0qX/fvLfZZM6JcOQyEaD5PKirK3B6tZsrTG6
   nkztf7ZbZcYLmb1srLg1V8xFF/zCtwXpgwEFvV6gZcihHqeMPr9o3aGXZ
   KmO/o30TeO+D/px0+mRpkTU7ZoEBy0OIXsQar2E6NsOwXmK1Cf6hIoxk5
   hf/2v26bT0PcRK6tSeHM3uuPGnMXbsLLO9kn+74C6zudi+UqPhgdXHYS4
   X5P8K7UWEG9Oc3Ud8gOLnkGyHDL5oXaCIOOS8nhCO40Rnm7/ajFzfyNAf
   dkt51dT+G6W745gh2I4dfhk5jeIH4Nit/TvQezES74jCB3S8mFMWIlz5r
   Q==;
X-CSE-ConnectionGUID: Ap5l4c9hR4KbWZdy5KGRZw==
X-CSE-MsgGUID: JzVOkD0TSquIMr+K6Pfoaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="64070946"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="64070946"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:29:07 -0700
X-CSE-ConnectionGUID: u6i8mX+cT/ecQGlNF6Uh1w==
X-CSE-MsgGUID: 7O8zajSASzeCncGIZKilhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="178779856"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 19:29:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 19:29:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 19:29:06 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 19:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbZ6YALjGqO0oh2KsU+DtGlxe8v7tamnqZENDvsDb/bqmveegP2j5y8HsLEVRmRaA+33CY6RlQvm5WTeE1QSMpBAIOe5WZhLuxfagOUHz2UZ8SBDKpaQWipcRkAXLcJxCpcbWq1GUN05k4/KkpOYp5BPUhnaYUdnYzMuZrl6Y2GuTLqT0iAQbioOHOP8O+J49l1wh0EvfCA3gBxN5uUH+WwvUKz3FEmmKCH6FzjyaOfRCREH2KSdyq1lYSB+UftJkaMXQk689zvzoPzbJcCcDsk/DMcENnlC1c6VAu0jo72jUE1/D9tK4ukIAF+9ziv7TVtWyHjyODc421creH9fdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ/C7SAccxRJ7YzSGOLBIerxwa+0Rwse7u7nbs9D9IY=;
 b=pAXwhDu6kUHhvROeqiH+605RrdMNUurjhaKb+mCW9kBR903cCZ0zLG3IJ65tyHN2L2Q/s2REm0lzZn8R+EaTEGWGtyqa8ls4cIYbQD0SJqqzLhTtsM/5g3m67W/prAzM7JmgRblTZmvR8jRw9G/e18X9cLIm6+zGgCeBoz2kXk+iCWqzN+YWHhb428O4c4XIcruDqg7T+0AyBUF/3fSN/Tw98xFPcwu+NuwkDonD51e0uwaVbTju8Z21sbxZ9F9G3fqSwzkPydHH3rRVMPk0Gf5XxVHVf+UTl6VyJhmiW2D5Ij1lVW2WFpBwA13uOhsCsk42j/+LQHWeTdjrOK3wLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.17; Tue, 30 Sep 2025 02:28:59 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 02:28:59 +0000
Message-ID: <79db86a1-dc75-42ca-9cff-927539dc2104@intel.com>
Date: Tue, 30 Sep 2025 10:28:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched: Create architecture specific sched domain
 distances
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Len
 Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1758234869.git.tim.c.chen@linux.intel.com>
 <990005f249897c6ef2e7d998c68836eba604f346.1758234869.git.tim.c.chen@linux.intel.com>
 <6a650359-d106-453a-a5a3-24b3750a05d2@intel.com>
 <861e15234270eb3678390da2b0ddf3a7162d98dd.camel@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <861e15234270eb3678390da2b0ddf3a7162d98dd.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0057.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: cd08f5f7-5de5-4e6f-eb69-08ddffc91ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1AzNTZ1ekVEVkorSERxWFIyWWlxZDE0cjlSQ1ZyWFVHN0JyVEgzN3BpNXd4?=
 =?utf-8?B?c0ptVzZ2a3BoQU10b3U4YWpNS3N1bHNydmp5MXFWRVlqTlI1ZWVCcUFxUDJJ?=
 =?utf-8?B?T1lYN0JIZ05CU240dHhhL1ZvR0xIWTJqc0QxbGhJT1NPR2JqVEtUdUZ3TmVq?=
 =?utf-8?B?SFhoOWJLZ0UyY2kzSzAxSnE4L0s1VENkZlU1WWJSRi9rK1F3eXVHL25hRyt1?=
 =?utf-8?B?UGVTZWh2NVdFSW43bGgybVk1MVR5bVczRE1GK0x3WnhBMVUwMWZHUEU2bUll?=
 =?utf-8?B?RXdsalRKYURDOTNIY3Y0MVVvaXJiS3UzRzBvUFJTZExiVFltRXdSOUdWb2FV?=
 =?utf-8?B?djUxN0xJT0taMzhNVmxNa3JmYU1jaXRWcmVNTFdkODVWZWlmb05kQUxWZzhF?=
 =?utf-8?B?ZkdMQlY4c1BNUkZEYXFtWHVIRTJoU0Y0bGk0M3pGblRpSWZzMEN1QnhWZElC?=
 =?utf-8?B?bEdLYTNjWEplYlZ5OEtic2FzeVh5YUNobFFhMGltTTdFb01KdTFYTEU0c1c4?=
 =?utf-8?B?TVNldW04MEpRN3I1V3M2c1YzYmJMSVNDWHRLa3VEamo0aUdwNHJ0S0UvSWVE?=
 =?utf-8?B?Rjl1bS9oLzVkNGhvUHVxWXdWbGNzd0xBZi93NCsrQkplK0pMRTNsVExnNldo?=
 =?utf-8?B?YVdPRUhER2I0eEdONUFwbnpjQmoyMlJBVDlUVmVvYzRHZmZueEw1bzhqYk5M?=
 =?utf-8?B?Z2FtMWE3Vm9xL0k1b3RONHhQMFBxdS9vTVVYWm1PUUZoT1NtNEl2UjZKWkxL?=
 =?utf-8?B?RVdBRk1lTHp4cWhoandmWEw2Z3VYbEkwWUw0OW1GSTBEYVlzanQ1UiszYU1K?=
 =?utf-8?B?M2xWbWtrNHg2a1NXajR2KzNURGFpWTZaY0FlMXJ5bnNMbVcvTVVmeTZTeVV4?=
 =?utf-8?B?WWRPY1h0NFZKckgxVkhrSzBSaUpXZG03cmdEaS9yZGttOEl1NEdOdUFHTFZP?=
 =?utf-8?B?Z0lBc2ducXl1bXhNN1FxNHJldjU1MUNWd3QrMjgyR000N0JJK3phUnhHK3E4?=
 =?utf-8?B?Y01jT2ZTc3psTEZnS1RoK3IyWWc3QWFkUmFFUjdiczBIZFZCK2tzODh2RFUr?=
 =?utf-8?B?bUxJMkNyaWhnU1JJeTc4Z3R3dkhZRXVIckxQNXU4U3cvTnZFZlBVekkxZ1Ro?=
 =?utf-8?B?TWxsT1lPTWxWT24xd3E2NEdSVHBjZUh3SWNwc0dEaWRoOXFwS1lvczJZZHpa?=
 =?utf-8?B?UG5NVUpCYXR1R2cvMW56b3hmU3kwVW5yWklSNUNiVFMybEZlTENoTnVyOTd2?=
 =?utf-8?B?cGJKZ0R2WnkxQXdzR2J6TEY2SGdsWHJLWEdrbTdZSE1BOWtDOXVXZm5RYWVv?=
 =?utf-8?B?OUlSTkJkZWl2VWMxYXRDNHR5N0JkUm5nNHZlbWpSdW5MQ0xoUFBaYzRXQ3h3?=
 =?utf-8?B?NTljcGVRalE2bmcwU296eE82WXo0RzJtUWlOYjhXMzZpQTRteEpBeWY4ZkxG?=
 =?utf-8?B?T0Y1QWVwby9DTU40RDdaZEJIeWFJQ0prZ1BNbFRFWjdicHBrVncwS1JXbHVY?=
 =?utf-8?B?dFFEc2ZmNUUzSDhFdjlZRGdUUG9IajdlLy9hdGkvclFQVWtNUjdHZ2dLRkp2?=
 =?utf-8?B?eStqZndBZU9JYmlJOFAxbExNK0hYMDFBbUFjWnJ6MUxWV3czOCtQSUdIOEg5?=
 =?utf-8?B?YzhCYmxPbGw3a2FXWkNoWmF1bEg4dXZSUThpTVNFcVF1RkRJUTVlUnpjSDMw?=
 =?utf-8?B?bXBSSVBnMkhpWkFEWVBMUXZjRnpLUDU4NGhOR3djNjNNZndjMER6ZkI5VExN?=
 =?utf-8?B?ZFBuaXIrU2ZsVEFFOXhNQy9SL25zcmExYVVnMFUzSkg2OVBjemJiVzI1b2Zm?=
 =?utf-8?B?NXYvZXdJVVd6WU5DaVcvVS9rdlRyZXJmNmZVVmJlL3czSVhkYVN2UEVuN0Fv?=
 =?utf-8?B?Z0xTZUlkalRkN1AyTEVzcnBKcFZqMVJxRW5WRVZoZjlkVDE0MzRiZ2RvSEZ0?=
 =?utf-8?Q?yY3YRv9Mgfv9HzPyis4gxHWXyTB0fy35?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ylg1Y0htU2FQK1ZkNGdaT25GS1h6ekVUMzRuVXlTSm1QUXZTSUpQSEtoaFc2?=
 =?utf-8?B?dzlWTnpVbVlSOEdSSFdCY1dnaGVMVFMyZDFzcThjSmNoSXhHenJnMmdPYlZt?=
 =?utf-8?B?UTdyeC9odjErdUFNaEdCNmN4RitzRkNrcTFoQzFZaDNVY21KNmhyL0pCaXgw?=
 =?utf-8?B?U1kzaDRZWnhXMUpEc1VwYitNWmlzL0xYODMwVUdYTUpxVFNLRGRCVzBlcjND?=
 =?utf-8?B?TEVxNEtZdnJ0RlNSaU1nYXdwMlUxSHkwdStRTUhueEZQMis5UTNPdkhZQ3ox?=
 =?utf-8?B?My9SRk5XelhsTkI5QmNiWHdndGNlMThKcXdkckZicFRPN0RsN21PSmhTOHBp?=
 =?utf-8?B?MXhPU1Y1WkVrbHZQSVpyMkxLSm5PaWxSUW1OMFl0NHQ2R016UFpnQlNJcHFH?=
 =?utf-8?B?MnZaeklPM2x3K3ZoUVRmUkw5N3YraHdHMjh6ZkowcnQ1bFhzenZJVlJUdnYr?=
 =?utf-8?B?eDFZcjRTN3NyQXloMHF4aUYvcGxtQW1hcHF0bVdlMDlqQ3daVlZPTmlJVkVC?=
 =?utf-8?B?OVg0WW4zbUpZek1tTGU3MXhHa0VVZ0NnZnFLMVZxeE9iOW9ZeFl6cm9Bbnkw?=
 =?utf-8?B?UjlhcjFvTVZhSnE0UDcvOW1zOEUwODVNeCtHandsN1pxZWxRZkFHbWdqdEJU?=
 =?utf-8?B?R3U0aXJWNXRpZW1wK3AwMmFYSklLL1B2UEFhVU5kSEdoV2dicFZ2Zm42TkNM?=
 =?utf-8?B?emJSSi82UVg4OEJ3U0FiOEtaMjUrb1lVazNSTVhTTDkwS0x6eVFDbmZRR29D?=
 =?utf-8?B?TWxiakR0SU1EemNUM2JDN1A2eHZGVjVVdHh6VHl0WUEvN2dxSzRodndrTWUz?=
 =?utf-8?B?cHVDT0dsYWE2elp4Y0dVeFlkcXlOMDZjZXJ3VHZVVncxR2Rlbkg3aFFEVngz?=
 =?utf-8?B?NG5WRjE3d3ZKanhhREhaZ3J1NERNM2J6aElHcWpjL1JYOFIzVnlaUFNQeXI4?=
 =?utf-8?B?QUI0WExWTXF4Yys2bkZsV01GYTlpQTFvNlJqNVRRRzVEek1OZCtFb0hIaXEw?=
 =?utf-8?B?WmFQeXQ4VExrT3hUN1gzbHU4SmR5SXh1aEZsUXd6TzB0UTJTSWV3SDVTbWkw?=
 =?utf-8?B?Y2Ivb1MyN0lGN0FGK0Y5Z1RKLzVGUWlWSnkwWWhId3NxYTdqNFhSeEhPZFpn?=
 =?utf-8?B?ajNFTFRTdmtoMXdRN2xpcE5QU29IdG5VQ0ljeVF0eS96d2p0Qmdsa3d2MERO?=
 =?utf-8?B?QnZ5V1pwWFFHVEc0cXdVTlFMeUorcmI1OFpleVlKSXJpRitSTEI0bk05b3Fr?=
 =?utf-8?B?U25VNzJsQkFsK3EvSmVjTFhBbHFSVUpJcFpTWUUzOEp3RTUyOTJMdWhkVHd6?=
 =?utf-8?B?bGp4MzdlUVdRTkEyMGw5WHBtVGJqeWhEUkNlMlFrNC94RVlreHFERkM2T2Rk?=
 =?utf-8?B?YTJQbEpFSnVXVTFOeUNNRGcvTUo1ejh4ZnFmRm5odmxqSEFLUU40bkMyTTRp?=
 =?utf-8?B?YkdQWWYwUnV5VDVLRWl3Vlpub1pQdmtYeGxyVEZUREFmdlZRcW8vd0JNQTcv?=
 =?utf-8?B?dmduUGhoeHZPWHhzc20vdWJ4MUtPSXdzWFp2Z0NXUUlUS2VLOGRmRENiOW83?=
 =?utf-8?B?TTd1MytaU1Jjcm02bmtDSWFEYnVwWHdqQVdiOEY0RVdLeGlKSUZnVUd3d2N2?=
 =?utf-8?B?ZFU4bXN5SVVvaUd0TnhqYUF2UDA5YUloOS90VGQ1aDlWZ1lHZFh5N1lOQzgw?=
 =?utf-8?B?am1lWGNnVlc0ck5hcGVuaEVnaHhXZHhNcHZieHlZYTM2ODdQMDJoRS90Q0Vu?=
 =?utf-8?B?S2JFa3RFd3JkWXZVVWhNVzlRRURqQzNFa1hRSUFGZ2dFc3JnazdsYUhmRHZT?=
 =?utf-8?B?d0ZkTGF6bDFTdGZqSXVsVzdZMFYrOFcza0kydldCaWVMbHhzMzVGL2NkTGJR?=
 =?utf-8?B?VDdiSzQzeGVPK0NxeHVYVWRrUkxBcm1xVnJZeXJUb0Q5SEZhWlZOeE5yRUhv?=
 =?utf-8?B?Sm9GcWl1dUlrVnovd0xYazhkZmF0TjhVQ1oyMCtuWmM4c1FtVDJIdFduWmJa?=
 =?utf-8?B?OXJuNTZpTVM5RHhPZ2JQcldYSEFMZml2bVVqdkMwbWdjWnNweTZWR3FGeWlh?=
 =?utf-8?B?TG1oUmoyeDU3RWlDMEhORWovZU81YU9qZ3p1V0lkeHZVandIK1hpZk1VVUdo?=
 =?utf-8?Q?pI/YQOndpOyVq57G7u+N0g9ha?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd08f5f7-5de5-4e6f-eb69-08ddffc91ca7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 02:28:59.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/C+9C40lGToCIUEbu7/Ud4XuV5xNBPlf3pClQfeWXbUCHwfVWXl5N5thir8PYMqvb5T7Kxx3lumHN+iZlsB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
X-OriginatorOrg: intel.com

On 9/30/2025 6:18 AM, Tim Chen wrote:
> On Sat, 2025-09-27 at 20:34 +0800, Chen, Yu C wrote:
>> [snip]
>>
>>> @@ -1591,10 +1591,12 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
>>>    enum numa_topology_type sched_numa_topology_type;
>>>    
>>>    static int			sched_domains_numa_levels;
>>> +static int			sched_numa_node_levels;
>>
>> I agree that the benefit of maintaining two NUMA distances - one for the
>> sched_domain and another for the NUMA balancing/page allocation policy - is
>> to avoid complicating the sched_domain hierarchy while preserving the
>> advantages of NUMA locality.
>>
>> Meanwhile, I wonder if we could also add a "orig" prefix to the original
>> NUMA distance. This way, we can quickly understand its meaning later.
>> For example,
>> sched_orig_node_levels
>> sched_orig_node_distance
> 
> I am not sure adding orig will make the meaning any clearer.
> I can add comments to note that
> 
> sched_numa_node_distance mean the node distance between numa nodes
> sched_numa_nodel_levels  mean the number of unique distances between numa nodes
> 

OK, looks good to me.

>>
>>>    static int			sched_domains_curr_level;
>>>    
>>>    int				sched_max_numa_distance;
>>>    static int			*sched_domains_numa_distance;
>>> +static int			*sched_numa_node_distance;
>>>    static struct cpumask		***sched_domains_numa_masks;
>>>    #endif /* CONFIG_NUMA */
>>>    
>>> @@ -1808,10 +1810,10 @@ bool find_numa_distance(int distance)
>>>    		return true;
>>>    
>>>    	rcu_read_lock();
>>> -	distances = rcu_dereference(sched_domains_numa_distance);
>>> +	distances = rcu_dereference(sched_numa_node_distance);
>>>    	if (!distances)
>>>    		goto unlock;
>>> -	for (i = 0; i < sched_domains_numa_levels; i++) {
>>> +	for (i = 0; i < sched_numa_node_levels; i++) {
>>>    		if (distances[i] == distance) {
>>>    			found = true;
>>>    			break;
>>> @@ -1887,14 +1889,48 @@ static void init_numa_topology_type(int offline_node)
>>>    
>>>    #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
>>>    
>>> -void sched_init_numa(int offline_node)
>>> +/*
>>> + * An architecture could modify its NUMA distance, to change
>>> + * grouping of NUMA nodes and number of NUMA levels when creating
>>> + * NUMA level sched domains.
>>> + *
>>> + * A NUMA level is created for each unique
>>> + * arch_sched_node_distance.
>>> + */
>>> +static bool __modified_sched_node_dist = true;
>>> +
>>> +int __weak arch_sched_node_distance(int from, int to)
>>>    {
>>> -	struct sched_domain_topology_level *tl;
>>> -	unsigned long *distance_map;
>>> +	if (__modified_sched_node_dist)
>>> +		__modified_sched_node_dist = false;
>>> +
>>> +	return node_distance(from, to);
>>> +}
>>> +
>>> +static bool modified_sched_node_distance(void)
>>> +{
>>> +	/*
>>> +	 * Call arch_sched_node_distance()
>>> +	 * to determine if arch_sched_node_distance
>>> +	 * has been modified from node_distance()
>>> +	 * to arch specific distance.
>>> +	 */
>>> +	arch_sched_node_distance(0, 0);
>>> +	return __modified_sched_node_dist;
>>> +}
>>> +
>>
>> If our goal is to figure out whether the arch_sched_node_distance()
>> has been overridden, how about the following alias?
>>
>> int __weak arch_sched_node_distance(int from, int to)
>> {
>> 	return __node_distance(from, to);
>> }
>> int arch_sched_node_distance_original(int from, int to) __weak
>> __alias(arch_sched_node_distance);
>>
>> static bool arch_sched_node_distance_is_overridden(void)
>> {
>> 	return arch_sched_node_distance != arch_sched_node_distance_original;
>> }
>>
>> so arch_sched_node_distance_is_overridden() can replace
>> modified_sched_node_distance()
>>
> 
> I think that the alias version will still point to the replaced function and not
> the originally defined one.
> 
> How about not using __weak and just explicitly define arch_sched_node_distance
> as a function pointer.  Change the code like below.
> 

The arch_sched_node_distance_original is defined as __weak, so it
should point to the old function even if the function has been
overridden. I did a test on a X86 VM and it seems to be so.
But using the arch_sched_node_distance as a function point
should also be OK.
> Tim
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index d6b772990ec2..12db78af09d5 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -545,7 +545,7 @@ static int avg_remote_numa_distance(void)
>   	return sched_avg_remote_distance;
>   }
>   
> -int arch_sched_node_distance(int from, int to)
> +static int x86_arch_sched_node_distance(int from, int to)
>   {
>   	int d = node_distance(from, to);
>   
> @@ -918,6 +918,9 @@ static int do_boot_cpu(u32 apicid, unsigned int cpu, struct task_struct *idle)
>   	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
>   	if (apic->wakeup_secondary_cpu_64)
>   		start_ip = real_mode_header->trampoline_start64;
> +#endif
> +#ifdef CONFIG_NUMA
> +	arch_sched_node_distance = x86_arch_sched_node_distance;
>   #endif

Above might be called for several APs, maybe we can just call it
once in smp_prepare_cpus_common().

thanks,
Chenyu

>   	idle->thread.sp = (unsigned long)task_pt_regs(idle);
>   	initial_code = (unsigned long)start_secondary;
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 2d2d29553df8..3549c4a19816 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -56,7 +56,7 @@ static inline int cpu_numa_flags(void)
>   {
>   	return SD_NUMA;
>   }
> -extern int arch_sched_node_distance(int from, int to);
> +extern int (*arch_sched_node_distance)(int, int);
>   #endif
>   
>   extern int arch_asym_cpu_priority(int cpu);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index f25e4402c63e..7cfb7422e9d4 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1897,26 +1897,17 @@ static void init_numa_topology_type(int offline_node)
>    * A NUMA level is created for each unique
>    * arch_sched_node_distance.
>    */
> -static bool __modified_sched_node_dist = true;
>   
> -int __weak arch_sched_node_distance(int from, int to)
> +static int default_sched_node_distance(int from, int to)
>   {
> -	if (__modified_sched_node_dist)
> -		__modified_sched_node_dist = false;
> -
>   	return node_distance(from, to);
>   }
>   
> +int (*arch_sched_node_distance)(int, int) = default_sched_node_distance;
> +
>   static bool modified_sched_node_distance(void)
>   {
> -	/*
> -	 * Call arch_sched_node_distance()
> -	 * to determine if arch_sched_node_distance
> -	 * has been modified from node_distance()
> -	 * to arch specific distance.
> -	 */
> -	arch_sched_node_distance(0, 0);
> -	return __modified_sched_node_dist;
> +	return arch_sched_node_distance != default_sched_node_distance;
>   }
>   
>   static int numa_node_dist(int i, int j)

