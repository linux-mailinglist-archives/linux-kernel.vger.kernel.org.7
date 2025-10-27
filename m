Return-Path: <linux-kernel+bounces-871703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE3C0E1D9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BA3C4FA580
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B691308F05;
	Mon, 27 Oct 2025 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8j8U7Mc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB926CE2D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572175; cv=fail; b=rTFPT2eoaMCvi5+PQptjlIQP16moCP4TATlDE9lGoatzwiB8NCcb34Hv/VJo44WI+9UpWw++p/hoom9kJCgemHktszj7KljU6NMj/RHYE9czMkETqzEv3c2LS0pqdiOvoudZRyNt/tCeevHbBIND46Eib3r/0nJ2HR/ovo93yzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572175; c=relaxed/simple;
	bh=rHn17/kgc0qg2CAc54cJ+1OJtgO9967jQySQuSGr5TY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r5X5pvHcYhDMomVUoC+xTsJJFRasV0/7RIHwe3XI5xgN2sHVeXDt68weDgKXwLoNHFO9M5eQdRaBORRpstYTWCQ/YjFHE1i7sVOXaRiUukhsCpRphoGtrHR6/qyK3zxt0xw/rNpPebB085qOh0r/LudgXDJqTML/5MrwDxQVIOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8j8U7Mc; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761572172; x=1793108172;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rHn17/kgc0qg2CAc54cJ+1OJtgO9967jQySQuSGr5TY=;
  b=B8j8U7McCxGdsSzmq0KJ1jRoD66BKME9M1OO+TOeG8YDvIK5j4zYUZew
   aSUTQZ4AcNIUbbxNaH0ygoQLUSBXEVrkLGKbSmRiGZ1LgetQPiEtZsXCY
   KOgMiIbVOAczOW263LqbuBTYKOhZr+k9UrpczF2RikNhDWQj0tBsNxAwn
   f9Yq56SQ3znfItxnxzYAiJJGcwWyxjMx/HH9WNUFFge/lh9UpfHs/Jt2m
   FbWGLZJqO25J0aCM5N3f3nTod1GcmvYA9aCUxzwy2F2RI130kjXbIwLgb
   bOivyiubC9f6/WL4LdxBmHMsF6Ulgu5lRT8Ks8B87Tny4qeMeD3Xc1ZHL
   Q==;
X-CSE-ConnectionGUID: 9weFEXFHTtm9R37gwSeroQ==
X-CSE-MsgGUID: yQiGF5Y3RPqp7cWG1/tTnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63549575"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63549575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:36:11 -0700
X-CSE-ConnectionGUID: s35W0/tvS2W5foc6tecP3A==
X-CSE-MsgGUID: ypDldApHSmCmUNtSxIt6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184939057"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 06:36:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 06:36:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 06:36:09 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.66) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 06:36:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDHAipI3w//6vvnHG/RZDNxGyfWh6DgZC0kCOAsNEaNkZNEAbMKJOWTwTq8isuiYu/URCUq7l5QvtwTwfsU/iez79amcq8CA32HapiJFY+SE7aEx9FXDpZogA2BFeRnFpXo7VYL/44VgED7IZ2yOkvFbGaKkFDrRXoaj5ULNal7mmpQcXysXDPLCQ7NsnJSG+q53EzVTI7oq0Z8KX4AvOhEWSQlUkd1A4qvP21gEAYiUs1DzRYOYNzUr1pADfs2tW2Lvh7q/grzggyr5tGc99mGRyCbqgPwQcagQsevUmfjGhURFnKsowTF5atKRYNLkZ+AAjFt9Lqtlo5faNpn1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otQeLRAfnQl2Lx8Lp0VIOX9z+rEPIEqqrmJz6gDp62s=;
 b=AnPwgyGG3Y71OampTWTbtzjXlICn4zqy9Sm1pkM0c35lYMxRygSxT/waEVZ9A1kdyBCTu0wYn6wiJImcTA8XO9gYOrAfbhwEo37hL0TxISTi8aD4avpiRQAeR8/4tYWF1a4QG6nNkVZk8TJz5ls7CgXuR4nG1LWfET2/YzcwGYduQK1w3qQTnTh5/01IE1+ZnUbJuEI6KWlj9HMQwAKd1YvOXsdudqRd0TAOPwfcPY8vfB23JLyTNfGRRg7nVlAmxzFGNzjQZ1dMkLrLq9PCV5Nvov0pYZ+B4OdeJ8NECXZDDeAE0EdX5xEG7NWqbJdQW8GkZZMy9L0jAyHbWNXGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 MW4PR11MB7161.namprd11.prod.outlook.com (2603:10b6:303:212::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.19; Mon, 27 Oct 2025 13:36:07 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:36:07 +0000
Message-ID: <162a912b-668b-47c2-be8b-86f896afa7c0@intel.com>
Date: Mon, 27 Oct 2025 21:35:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/19] sched/fair: Add infrastructure for cache-aware load
 balancing
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Ingo
 Molnar" <mingo@redhat.com>, Tim Chen <tim.c.chen@linux.intel.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <865b852e3fdef6561c9e0a5be9a94aec8a68cdea.1760206683.git.tim.c.chen@linux.intel.com>
 <78c81f74-7b27-4f28-9ca2-0d1e27ed9c56@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <78c81f74-7b27-4f28-9ca2-0d1e27ed9c56@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|MW4PR11MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3c7ec-2ad9-45a7-52e6-08de155dc845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzR4WHlxN3dJM0tJMDZlQ3o1VCt5eWI2cmFibXY4d2FHSkFFT1ZyNWYxOXhN?=
 =?utf-8?B?WlVmTThETzR0ZHNLRldidmluQll1ZEU0dllvbTBjT21zSVViVkdCTkI0NXlS?=
 =?utf-8?B?QW9JSHBrZ2RlMGg1WklQT1Y1cHU5RkU5MUJaQncyYTRLNlo0dkNvL0kwaXNT?=
 =?utf-8?B?N08zcnFQa2dORlNlVVMvMkIrREQwelJieGRtNlB1ZDFtL3JjdCtwTFcwNHZ0?=
 =?utf-8?B?dmtWUm80VjBmc012YzZxQ3JQZDhhV0NrMWUwSEp1ZW9VVTROc2JjQXhtbEl2?=
 =?utf-8?B?dzZrbWhaMmxjbHA2R29JUjg2bHhLZUZEL3UrQXNSWUJyU3ZNUGRSVVhPTjlS?=
 =?utf-8?B?OHBKT1dxQ0piM21xVzQ2eXU0V25DeWRMSTVhcE9KRFdXN1RYU1VvUlBBdUZI?=
 =?utf-8?B?Umk0QXUvY0RTdGhEdTVMb3JWRFFpSEkzRlpmQkhnN2k3TUJtNlphay82R2tD?=
 =?utf-8?B?WE83TzJJWE9qZHNNU2RYSXJoaENWMDl0emJ0V3NKeDR4bUIwdWhxcjVLbytO?=
 =?utf-8?B?c0JSTGpmS0V0QWhLbk9hdm5hcGkwM2VUUERZVk1PRFdndWFmR0wxZlQwYnly?=
 =?utf-8?B?c1FJZzFBbUMzZVVPV2Vwa1JmSmt2WElRdjBTcFo5eU00Y1F2S0l5OTNDdnhQ?=
 =?utf-8?B?dUdLbTh0dkJWYWVsV056di9zZzhqZ0VpWEhiTUk0QjN4V2tCYThJNnhyblpx?=
 =?utf-8?B?V3dwZjZWWktES0VGQnJGekhWTXphbzJpcTZ4em1McWRrb0twK1pzbnFGTDhn?=
 =?utf-8?B?N2VvV2J3ZWUwZ3pCZWFndmFONFZMVkFoVDBBTHN5MlFKY3ovTVR0MWw3UEVr?=
 =?utf-8?B?TXhLV213Sm5vMkZ4R2xjdWlidXp2Wnp6KzhVK2VHOHZ1RGxmb0dDMjJyS3h2?=
 =?utf-8?B?MFB4U1RabDNlOWhxa216UE5yL2RHa1ZJc1pQeGY4WjhkYjZoUG5mV2NOVCtj?=
 =?utf-8?B?bGIyclk4R0l1NFRHREQxdEZ0RThReUdYR3NXNjh1NzhHemtIQW5FT09tSTNU?=
 =?utf-8?B?YjFUcUFxdzhWOW45RUNSOFgwU1Rpeld5Nmx6eHBGTmxySTJ6WEx3OWVjS2c4?=
 =?utf-8?B?M2p2K3FJVUZaVVYyRkNWNkhHZGh0aW45QmgyTU1WS0k5V1RLRjJ3N2tJbldF?=
 =?utf-8?B?VjZURGxjYm1QTWRUSDJMZmZUSDc2V3o1VXdLeC8vcXJEdDRTWjIrY1lpM1hJ?=
 =?utf-8?B?ZVlQRytWWmlRQ09idXhIMitPTE9Fb3FLZXNkempRU090cVJVeXZDL0ZjcjZ5?=
 =?utf-8?B?eXozQTlGdmpYWXFuT28yMUtPRVNUK3lodjFMTEhGSlpodlhXUnlSVHNCU2Vj?=
 =?utf-8?B?SlZFV05hWVdXeFY4cFgwaENPK2tXT2JVYmtxdCt6VHhJTXdKUVVFb1lqUmVn?=
 =?utf-8?B?OUd4ME9pUzNLQ044Yk5MWGd4WW5rZnU2WmdJMTFvT3Q1TlV0SktiK2gydHA4?=
 =?utf-8?B?ci9lc2M4SkRSLzVzNFgyRHUvbmpjODQ5NGJZcnU5enkwWFJDSzFSQ1d2STVr?=
 =?utf-8?B?UnpTNUo4emhRR3k1czlDaGpjM1BsRVdWUnhXc1JMM3k1UlN2UkZab1RUWHM3?=
 =?utf-8?B?UndEcWowc1BiOTBVTVZqY1VvYXVIdmhyZERkQmNaNG96bGVBRmxyV0ZqZjN3?=
 =?utf-8?B?Q0F4cFRtSHpuaW1CcXovZmtZaDNSMmRhaGRPQTAvbTNOcU5FRDdZNXV4ZVlC?=
 =?utf-8?B?bG8rR0hVbHpXdis0V2NzMnNJaUJoL21LWll2eXdVWlpFRnZnWVpjMUtKOTNT?=
 =?utf-8?B?akwxeW9KYUhHRzhRSkpqUE9GRkllRy9maDdPd0FSQ3lxLys5cnN5MWFudEU5?=
 =?utf-8?B?YmJwS1FCdlJGSmRJRkVncm43dS90TytoRFowVm5ZU1dJV2FSKzNoRkVqL05O?=
 =?utf-8?B?TmFMWVRBY29UVVhubklpcUl5Y3VoSlEwbWc3Y0xUQUQ4ZHF2SnNoQ0x3RkFi?=
 =?utf-8?Q?zPmd9ZyWF/VH4udpHqh0tbYMmyf5PcfM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Lzh4bFJpclh2K1dWY1dWRXpENGUwVmtSWDhaOWdaVStjc1ZDMFkySnoxTmdN?=
 =?utf-8?B?WUZXQUxsUTQ2UnY2RUgxUjJtRCt2UHc4K2NrN29wdUVpMy83NXUwUFdmMG1X?=
 =?utf-8?B?cUtuRE83RlE3dXA3Q0xwMitBRHllMmlDcmdVWGMrTENUbjRjWFQvYTQvNlJw?=
 =?utf-8?B?QjRRRzRmWktTallIOG9NN3piSWplamxjSGFEdXVia05pbG9PMG1wWm8rdGFQ?=
 =?utf-8?B?c0tUcVB3WXYxblRrbHh2NDNMZTROSXliTU42THIveXR4UXlGWVhzdzVRamdG?=
 =?utf-8?B?aDdUcGNPcGEvbVpCK1pIYjIwL056bHpTK1haSEVKVURDQTFtNW0zRmIwb09v?=
 =?utf-8?B?bnc4bUx4SlVhTS9SaGM0UEF0M1cwc3IxTXRCd0lOaGZPeS9UeXVQclpCTUhk?=
 =?utf-8?B?YksxUG1SazA4TkRIdGpUZlRjY3F4Q3Rzd3RnMjU3aER0dysvYWR0cWhGTDFw?=
 =?utf-8?B?YTZnemx4QXdseEF5THhlbkVEMW5RVVBwTjVLKzBUWDdkWUNJZStwMzhUVml1?=
 =?utf-8?B?RkhuQjcraWRsSkR0MWpoMStMUmNFWk01cFZsakdjV0VKSmIwU2FmSFFHVFpS?=
 =?utf-8?B?UUZzZ1BjckNKOGNsZko0eDlUTnh2MmR3dmc4ZzJnL0M4RndqYVVLY1Naam5E?=
 =?utf-8?B?SHlKcG4wNjlkSFVxYXNuUXE4TXFNWU5YeGlhTnpYTDI3NkFxalB1SVNROUsy?=
 =?utf-8?B?NHAxbm0vYnpIdGIrcTZodzM2MkxmS0hZeFpPZElvWEI3ZUZFbk1CbEJGWDFH?=
 =?utf-8?B?L1JVUnNWRXpzV1FXb0hPM2NicklERUNadFNYaUxlSGo0WHNDRzhSKzFZcFR4?=
 =?utf-8?B?T1ZhVjgrYnJkWmhLdno0RmJXVzVSWnpUY2w2bnMzeUJsaDU5RzJWc0FkZ1F0?=
 =?utf-8?B?bUJrY3pmY25ENStGM1BwVlhqY3Z2TEJPbzlldktlQnB5UHI2NFRNenVuWndJ?=
 =?utf-8?B?SDdWZ2ZiSG8rK1lGM0hNSlQ2NDNrT2VRQnVQRmFmMHMrMTdhaFhSU1dsdGtq?=
 =?utf-8?B?Vi9lVCtmY1R5NHdoZVlKbjkzSjVjOFFqaXFMQ0k4WXhZcDRlalNzUDgwZk9j?=
 =?utf-8?B?ZmhWVzFQeFVsZ3VPelpFTGh6NzVPd0h0T0JvZng0cmFjdjIvdFVjNThBUk1C?=
 =?utf-8?B?c2xKeE1PV2U3K2cwSVJGOW45NUU4ZW5SbnQ3c0V3L3NLWVZSZ3czeitoQ1J3?=
 =?utf-8?B?V3FQdDVmdFNzVkt2aFk1QkpnVi9rNGcrdXQ5RjdpZC9uL3RtVFlGRUQvUkhm?=
 =?utf-8?B?cTdibm5WOGUrRlQ1MmxrcENqK1B4T2wydmJMVmhpSURJdk03L1ptRXFJZGRj?=
 =?utf-8?B?d1krMkxLWTdSei9qYTMwR3pQWVJTZHU0VnIwU1lXNVBJd3ZkYVNwaTczM3dt?=
 =?utf-8?B?R1dGbHpmRkNZTDhPa1R6MG1lMHExNmgyaFhNQUpmWmVoUFpyc2owZ2ZTbjBa?=
 =?utf-8?B?ZnAxbTk2Rk5xbW5zOHUrUUVZR2gvMHJpZ1owNGVuRDRoKy9tL1M1UzMvNUFt?=
 =?utf-8?B?SkcxNnltRmpLOGw0UFBkZmdsZDdmcWc2TG5MNW1iUGtDVWJmZXk1S3JRSS93?=
 =?utf-8?B?WjQrazJMVUcxQytrbGZITlZ4YjJyK1ZkU0lUVndkRW44ZDRQT09obWhBS0Rj?=
 =?utf-8?B?Mk0wbXo4QzZLd014OEVHVjV4VGlDdGsrWVNGQzhCeEVnSFJhSWc5M0RxVWNX?=
 =?utf-8?B?c1ZtNkd0bUI0UVZkL3VXZW92b3pCdWFwZlNneFBlMFNlNDFPNXJOak80WWlQ?=
 =?utf-8?B?YTM0ZGlBaDZSOUh0eFA0WkZycHM4Wk1tUUlXcjQwQVV6aitzUWUzZHlCSHI2?=
 =?utf-8?B?UUxSd2hGQTdNR0dpTTd4QWFYejVwNHNZZ0JkR3FBSWhYMTMyZ1NYdWtzRmF1?=
 =?utf-8?B?eXNCRFExVDdoNXJ2bUpFMDc4ZzAxOFc5N08yNDJLRWVrTmFvdGdBZjNvVHph?=
 =?utf-8?B?cENaMU9HVDJXbDlZcnIwYWovODJqazlWdmdZSmF5c1hHOTRucHhTVkM1S0FL?=
 =?utf-8?B?a0NTYnN4UWJrVWFIdEUrSktiVHFEZGNFMzFRdGtwTnh0N0J0L1FGKy9td0NM?=
 =?utf-8?B?OGZRWXBxcy9Uc3d4UjkvSG90cGQrU0hFVlJKWjEzcnFRN3BwK05xV0ozejZT?=
 =?utf-8?Q?Z2GWm2TMYAHpDhLibJfZSxxc4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3c7ec-2ad9-45a7-52e6-08de155dc845
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 13:36:07.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fos1rrE0iX/ziAagHPWjUe7Ityh3jVFAfZKB/R9w35UGZDmdh8Lr+i8bXZ0qwYnQVTr280XXOqAG52RaP8hUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7161
X-OriginatorOrg: intel.com

Hi Prateek,

On 10/27/2025 12:47 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
> 
> [..snip..]
> 
>>   static s64 update_se(struct rq *rq, struct sched_entity *se)
>>   {
>>   	u64 now = rq_clock_task(rq);
>> @@ -1174,6 +1176,7 @@ static s64 update_se(struct rq *rq, struct sched_entity *se)
>>   
>>   		trace_sched_stat_runtime(running, delta_exec);
>>   		account_group_exec_runtime(running, delta_exec);
>> +		account_mm_sched(rq, donor, delta_exec);
> 
> Shouldn't we attribute this to "rq->curr"/"running" since that is the
> task which is actually running on the CPU (with "rq->curr->mm" being the
> one that is being used on CPU) as opposed to the "donor" which is just
> providing the vruntime context?
> 

This is a good point. I'm not quite familiar with proxy execution,
but after studying commit aa4f74dfd42b ("sched: Fix runtime accounting
w/ split exec & sched contexts"), it seems that if it is related to the
raw running time, the duration should be accumulated to rq->curr, the
  actual proxy task. If it is related to vruntime - which might be
directly tied to the task selection/duration strategy-we should
accumulate the delta to rq->donor, whose context is being borrowed. Is
this a convention, or did we encounter any issues before aa4f74dfd42b?

I think it makes sense to change to rq->curr. As in "[PATCH
16/19] sched/fair: Exclude processes with many threads from cache-aware
scheduling," we use rq->curr to determine how many active threads the
process has. We should also change rq->donor to rq->curr in this
[PATCH 1/19] to keep them consistent.


thanks,
Chenyu
>>   
>>   		/* cgroup time is always accounted against the donor */
>>   		cgroup_account_cputime(donor, delta_exec);
> 

