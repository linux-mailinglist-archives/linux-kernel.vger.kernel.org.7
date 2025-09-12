Return-Path: <linux-kernel+bounces-813223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEF0B54223
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2716567DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6326B942;
	Fri, 12 Sep 2025 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoI6SOw+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B60C275872
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757655602; cv=fail; b=Q/aIcT0ogtr6AU1ki1sljbkoxsNp66lm1VM4gj11pkeV7IMoFUdHO1wb4ohGgu5wGzw26V4FKZGB+GjNdaiHtYrJIaG1l7ltrTwVc+IjQmHbNVHxRS3higQMJnqaV/ov+OM/aZQ2HI9kVVS77cACsov7uVY39zm48KSuanqfFes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757655602; c=relaxed/simple;
	bh=a/1so3+TTGWH3J/+NeTcnz0fFbhnJAjmmZIYKPqV76g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m2BRvDZG107kL9GHFnySIvnp4hiC5OvDyHv6c11dW71nsaCsTpA63W8DmQJdZ4yaVnkqzGZCiJSx4bGm0PyG38wsnqoTocu1YHy8yKPACU7VJFVKnLp1kaNev5uKUCH1dlNK1ogxQY6aX5JPsCR/aqV5DVcgWJ9aulMBrkJbNfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoI6SOw+; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757655601; x=1789191601;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a/1so3+TTGWH3J/+NeTcnz0fFbhnJAjmmZIYKPqV76g=;
  b=JoI6SOw+WpA3q8+ViYlQwQ6wlfcsAcYF2afsIYTJSSGtxaVDYAhJoJ9V
   SajjufosL3/1yDjfzC/3bBCVVwFXxuTsMY9CO5++bFarndF5UAiER0nVL
   xyC+5zwgtSZ+k/hMy7jjywWU/PzyIMx2akdOIRra1Jgp4N5BtwLc1CGfU
   cvgh5Bb78NBqVWCLPrzIgSG/A1x/qFkZe3YD4LWfFK1Bw59IvSBEkGd5A
   Kz4eCyzEpT1TKan6D0tlyHRq3LBlz9WW8JrdvOv1/0chwL+CQ0hhyTUdF
   xkGEamnSfh3K1kUlTskFS4CUSp53YjW0iAfcdZc8qpU5kXraC5rvbQhVm
   g==;
X-CSE-ConnectionGUID: SDUjVkFKSd+HD0yclH7JQg==
X-CSE-MsgGUID: 3bv2Yhy0RKyyTm2q+iD5AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11550"; a="71424029"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="71424029"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:40:00 -0700
X-CSE-ConnectionGUID: KvyfKhc8T/Gk+6n2c+i6lg==
X-CSE-MsgGUID: 2buSTcSaQh2POcqdNcm3QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="204877349"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:39:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:39:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 22:39:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.82)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:39:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqk7YXMT/eYhumDy3Ew52mNvz/mQ+Wy3nEz3TBYhdGay3GME4PAhDNW31PgprsE7HdNrRZZ4xjrVKS3HHNq28Ou56jrGFF49Md9wtw1g9GVjmqUTTmsOGmqAnw4ymM+7cQmLJT4MzPSdHRoQydYbFx9bQk2K7DSlqtPVe9/2g2UMI2Tiplqi+Oh/I3InVio9rj0qlhica7ZUIhjMt12mAwQk4KSDF+4dd1a2ahJfyafXJQ1sIXafL/kWylyzxT/9zgf22pm1YCzMAH9ptMCr8sqh202t6jBmFqECWbrC7c0rOwVPKilGXBG2/5cADCtDYacaTTK/WKvyCtEUdb8pyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNr6K8+tYjKYtKXuYcMZ55rDqGQv1qjWVjhfEV5sVpc=;
 b=tqrD3EvScMnY691AqiGUj2CL11PTkhspnuxSe6+FqjU/4xFFSTh7Fy04+Mp8yl1xLcIaalM4kd4+pLeLxtUevqBLydAnzihaAFpcyAkjaFya1Qabi74GG3GTyza0LwxB0bC8DcFWe1up/xTae2mXZ3LV6VxQP7z/EVb+j7BjbjzqqTh+VaXfxhudeGSAXcRzO5RPalg6qH6N5QmUi7MuHY8GgAy4vYJj/St3qaObyyGTW4CkSuCTOLr6hlm5tj68Au1xFqQKq5Snbu5ozWJf9nRXSP//PeFualHsJkXZpY0En1qKyHMOTM2hj0qDUttI36x/aweXbyVh6AfCxBe0Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS4PPF0442004E1.namprd11.prod.outlook.com (2603:10b6:f:fc02::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:39:55 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 05:39:55 +0000
Message-ID: <9b45b33c-3bd1-4075-98a3-d8f5cfc08785@intel.com>
Date: Fri, 12 Sep 2025 13:39:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched: Fix sched domain build error for GNR, CWF
 in SNC-3 mode
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <208a0a8278a28521e7bbc5114cf9899d31875d15.1757614784.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS4PPF0442004E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 31557fa1-5488-4220-bf63-08ddf1becddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ZNRHVGVmRVMndyVnFUdGFhTkpTZ3Zsd2VpNlBhdVN0QzUvckllVWJyRXk4?=
 =?utf-8?B?UldIYkxaME0yc1pRRnFCcVVaVVRTTzJMOHMzTThrVGpEcCtqM3p6VXovWm9V?=
 =?utf-8?B?R3RhOTNQWnR0TXRjbDJHcmFON2RLYno0RkJ5dWtqU1lEYnpXelpVWDE5bUJ1?=
 =?utf-8?B?TTdBWFFZc1hxajZud0VMZHJlbkRHMEYzNVMwU01USi9hRUxyc040ZXYyeUhW?=
 =?utf-8?B?dktYYS9JKzBlSlNkd040dDNBbmJPM1pWUzdhOHJlMEpVa1VhY1phS2VINEl3?=
 =?utf-8?B?RGRKb2NVZ08zL2d1RXRVamsyWUhtaC9Gdng4SW9qZUNtRkd6b251SEdUejlh?=
 =?utf-8?B?WjZBaHgvUEg0VkFQTzhFYnNuZ0ZpVkhrL3dSQU5ERzJseXd2NEdjcG5iMlZw?=
 =?utf-8?B?eWJ0ZloyY0xQRld1NjQxbENVM2FaMmpLZTdkcWNLbzdmSnRYbWpyeWhGeVhv?=
 =?utf-8?B?S25xY1g2SmRZNUE1d2syclg5S2RSNzNWYisrZ1BvU1U0NDBmditnUVZ2WExy?=
 =?utf-8?B?UmVIRndJMjFURXlLdlhzTCtVZDE2UG5LL0RtdUh1K0l3emhmK0hmQ0Ixc2hD?=
 =?utf-8?B?dEtPZTc0WkkybmZNUElWaUNSWVJoN3NLcmE0UVV5SkJYNk5GaWhYcVRqekhE?=
 =?utf-8?B?aXBYSmgxNGJ0dElIZkw3TmFaaTh0cnU1SHNaVDREcENiTHlHaFZqRXRGNlp3?=
 =?utf-8?B?MHNIa094TmJ4MG90cVhSY09FWTVhdlc1MjY3VE8rRXlzRUlpV2N2a0crZ3hp?=
 =?utf-8?B?aGJhSVozRjBSYlo3MUtwMkNGZXY0SW5NRGVsYkIvTDQ2WXdhZ1YyZGNUYjVl?=
 =?utf-8?B?cTh2YVU3WXZUTi9HSFEvT2Rubk9uRXdQaW1tNml6c0pTb1hFMWlYL2I4dWdN?=
 =?utf-8?B?d1hwWXNmMGpSUVhCVWxDSEZBTU1QNXF1bzRyQmxLdk5tL3htdjZiUDdnTU5I?=
 =?utf-8?B?M3dGbEhLaVg1QkI0cC9qUFY3MHVadTU2MWpPdDJ5K05PU1dRd0RkSnlFUDVF?=
 =?utf-8?B?ZmNlT1M4dDdCNTdSVlZRWVRiaHhNYnBhWVlpTHhOQVl6VjFqTmZ4bmczT2RK?=
 =?utf-8?B?NTVON2M5elpET1NvTDcvdlV2MG53RVlZaktzdDV5UVdnRThxQWZFSHpsVEhj?=
 =?utf-8?B?TXNLaFJsV2R0c0hma0c3UnRzTU1YYzl4aUlpN2p5MngvRU54a20vejVoc0N1?=
 =?utf-8?B?M2ltYmZDMzdUN1Z1RUh5Mjg3Qk5NcUgvN1AxaEp2TGNiVGt0S1VzOEpwZG53?=
 =?utf-8?B?K3dKbUNIN1ZTTm1aVGVnRW5rUEpWbS9McGNVa1VpQlVjSnludEIyb0JOZlZ3?=
 =?utf-8?B?Mm0zL2I2aGczZmd2SHlpOWdZUWNqV3U3RkV1SEFrVStObm5XTFBieG1tN0VG?=
 =?utf-8?B?bE85QlFhb1BIRm5hWDFudkdNNm5aNWF5cTJVWUFWbFpUblhlT0kyQzBqNUF5?=
 =?utf-8?B?SGVxMWs3ZWV2R1g1MElITDdFUzkyYlNMZHhCaEJ3S1pzUExRL1l6SCtha0RO?=
 =?utf-8?B?WTE3NGlLTDBaZHZ3OWljYWorYi83TStZTjk3K21Bc0svWkdEWTlJbjBjWDFN?=
 =?utf-8?B?Ry91cXB3ME5WdmhJWXhrdlN6WFc3WURIYUtDdHlyRWdPb1lhY21XMW00UzBs?=
 =?utf-8?B?bzR5YjB2a3llVGdjZE5IZmtqL2tTUWRHZlJqcGpXdFJwNzhrOG41NCsxQng2?=
 =?utf-8?B?bmRRTE55ZG5FdkoyT2VtdlY0UjRlVW5WVVdUS3pra0dPNTRYT2NucnlOOVFz?=
 =?utf-8?B?L1FTd3pNR3VZNWtXOXJyWUM0KzRKK3EyN1hxTkFqVGIvOU5GMldMNDJFelBu?=
 =?utf-8?B?ZDRKYWpVaFpBVFFnVUpwSWNDQmFwN0NlektSeWgzM1NQSmlNSFM3Q3V1RTZM?=
 =?utf-8?B?dGpTaWMyZTl5aTlnRGZPcEhTTUQ5Qm1LRUFhZEl4ZU8vZkZXOW1ydHliQktw?=
 =?utf-8?Q?8YUrVM/1gss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3grSEE4S09tV0xKanJoODRQajgreVh3TEM4eDR1ZlJrVkJBd0ErdFJ2bUp2?=
 =?utf-8?B?Mm1lbG1pQ0V4eEIxWmIyY1RCbGFkMnJkZVhxZVZaQTM3aDhoWUZHS1h3MUdD?=
 =?utf-8?B?citabEVLd1Q0SUQ1NEQ2bnAzdklPMjMyeGs2VHZZU0J3WEMzQzFMN25OQWxZ?=
 =?utf-8?B?cEtpYkpiblRXaGZhekd5enNrYzdKL2RNRHRReXJBY1VUS1Z5VStWV0c3YkF5?=
 =?utf-8?B?MUNOUWpWeVFZRWtIN3FpbThqRTl5aW81K2J4eUhJTC9uZUEvOGIyU1lDZXYz?=
 =?utf-8?B?bFp3a1JCMDhnWkdQWmFsVjAwMUpwQ0drNlRkM2tuc1B1V0lyTUhVZWlLVE5D?=
 =?utf-8?B?MTFXaVIvOWxyNVJYeTVaVEFDbGdwSklzaDgyNmdFZVlzSmdtSVpYc1BpSXhw?=
 =?utf-8?B?SUs5bUlJQi9nS1YreXk1ZVI4dDhNWk9nZXNPVnJMNlAwb0tlbGRYZGU0UC9v?=
 =?utf-8?B?alp4am40OHQvMGxJbjN0RUNXd25lTDlqUzNDaFFvQjh5THpPMFdzcjAvaTh5?=
 =?utf-8?B?T05XMEpBR2FaaWJxVHY1OTBWVnBrNjFlVlhFWnpmQXZZd21mOGhlVHB1RHo1?=
 =?utf-8?B?cXQ3V2hMeHpoeWRyNk9WNUJnbzFVd0orOHJ1NmlSZmxZc2E2Rlh0NktpK0RI?=
 =?utf-8?B?SHZEcG1jNll0Wi9WNk9LcEVCOWFZUXBBdmttTjZ0cnJaVDlSS1J3d1o2OXc4?=
 =?utf-8?B?N1hjdTNwcmdxUWRmVVgyTGJNZzlrWFlqcmpuSTNjNTVCM1VCUEY5TVlRVXZo?=
 =?utf-8?B?N3E1SU5YNGxCOUlSNnFGemlFR1YyQjQ5TDRoL09Cb094NGFsZjU4eGxIK3hP?=
 =?utf-8?B?YWpvOXVBSmRGRmRLbytKK25wTjVwNThyNzJKYVRwS2lUaEpxRC9FbXV2RWRO?=
 =?utf-8?B?eGdWZkZ2dFhpemJRYzdnZUtVQXF1MXBEVWFJVE91TTJZQ3ZlSDJmMi9zUGRm?=
 =?utf-8?B?RUp2U0JqWWk5dFZNc0ZIN01XWWM0OUgySEcrS1FOOC96Ym5zNHpLYzZEOVRw?=
 =?utf-8?B?NGVpTjM2QzBiclBEZFhIbEtVMmlVQUxBZGE1dm9Fek5HVDQwY2tGVWQzZmpS?=
 =?utf-8?B?dE8wamo2MUFadTJWMG5ldFl6d1l2eG5rU0ZoZjdiUlFoWVhkMlJ6Q2E0T3pi?=
 =?utf-8?B?R1JaVWRIU3B5TjJYS2hWUjhLeUkrMGNGakNuWkl3d1RtejJsYWZPMXQ3OS82?=
 =?utf-8?B?b0paaEFNOTZLemd2bUQ3RnVQdXZHbjZYZ0JYRTZmbmcxTnRKeVp4N3F5YWxG?=
 =?utf-8?B?OHhmQk5weXR3Um1MenlUZWlUVGZYOUNZbVR4Ry84d0FzK0FMSXVCWXBJbVpo?=
 =?utf-8?B?QzJtMWwzaU9lUC9zN3djcm94bCtZaDlaRGdpbEhoNk5EV0ozd3NvalJwZjJR?=
 =?utf-8?B?TDU2NWRlTmpOYnRRWjBCMTZQK3UyZVNpUU53ZS9CL0ZjS3E1TEp1eEt6UnUr?=
 =?utf-8?B?K090VXRrQzczdmgrek92bXlOaUFpTDRkWjNKUlloK0dGNHdoZk4yNENkVVVq?=
 =?utf-8?B?VkkzbWZxeUNQUU1MdkdEYmlhTHBBOFZQSjhOSWdPNXBlU2Z3aFpKSzdCRldU?=
 =?utf-8?B?ekJxM01aakJqQTZ5RjRUTTBUS0IrZU1acXlTMGszWG1WcmQxVjlkdHEreTdY?=
 =?utf-8?B?UGhzRnlNcFU0VkNVVDZyWTU2T3hjWTVSdzJCeVFRellXc0F0cXk2YUdhZUNH?=
 =?utf-8?B?V0RPaFN3YlFPbVEwQno0LzlnVHRwOXBtOGhZQzduZHpBZk9pYkIrMC9namxh?=
 =?utf-8?B?MVFjS0hmMGZ0dERDTXVPRm5haVNRNmJEMDMzcGV2NDB2VnpiMUtwclgzTyt1?=
 =?utf-8?B?MTN1MC90K3lMbzJCT0xsclZlVVJsOUV3Tm9yWXlKeUs5NHZPUjZsalVPbi9n?=
 =?utf-8?B?cm1YZHdYMitJS1F1L0E3QllPK3YzbzJBWkx4aW1zZWFJcHByMGVsMWh1RVd1?=
 =?utf-8?B?eFVYLzN6SDV3dFFRc01SZVd3TXpueEN0SUtwQ0FLUUVlZlNDWFZHMm92NktG?=
 =?utf-8?B?NWxtcVYyQmFUUndWNGpUWUJCVDlpSU4wYlEvM25XZ3ZqdUdYUFNnOHFJMzl3?=
 =?utf-8?B?aGlUS0U0OGJqc1Z2eGF5MkZJdy90NzB6VjNGbGZVZTZBVXJrNnRneTZSNjVO?=
 =?utf-8?Q?yvrpirZ/NOPcmJHfE3MaxbjOM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31557fa1-5488-4220-bf63-08ddf1becddb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:39:55.7652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMA/2KJW5PCQfvdYVEy8gPcJaZXRRCKbcFslPI+SOSds4FDukDhRfx93YnOulIHWxnSV3RzcoQkl4GdVNYScFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0442004E1
X-OriginatorOrg: intel.com

On 9/12/2025 2:30 AM, Tim Chen wrote:

[snip]

>   
> +int arch_sched_node_distance(int from, int to)
> +{
> +	int d = node_distance(from, to);
> +
> +	if (!x86_has_numa_in_package)
> +		return d;
> +
> +	switch (boot_cpu_data.x86_vfm) {
> +	case INTEL_GRANITERAPIDS_X:
> +	case INTEL_ATOM_DARKMONT_X:
> +		if (d < REMOTE_DISTANCE)
> +			return d;
> +
> +		/*
> +		 * Trim finer distance tuning for nodes in remote package
> +		 * for the purpose of building sched domains.  Put NUMA nodes
> +		 * in each remote package in the same sched group.
> +		 * Simplify NUMA domains and avoid extra NUMA levels including
> +		 * different NUMA nodes in remote packages.
> +		 *
> +		 * GNR and CWF don't expect systmes with more than 2 packages
> +		 * and more than 2 hops between packages.
> +		 */
> +		d = sched_avg_remote_numa_distance;

sched_avg_remote_numa_distance is defined in topology.c with
CONFIG_NUMA controlled, should we make arch_sched_node_distance()
be controlled under CONFIG_NUMA too?

thanks,
Chenyu

> +	}


