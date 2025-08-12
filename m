Return-Path: <linux-kernel+bounces-763928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED2B21BAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B321919040C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 03:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2002D29B7;
	Tue, 12 Aug 2025 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAi+ql6e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC31E5B7A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969835; cv=fail; b=lqwVAKPpSzP72ooLc+rk/1Cp0sinb6yrENCD1+y55Dl4pas3i8Z2NrO9gURbUXqqVKyCW4WQMCdRWl7qpf3ljxFO5VQ7w9bNhJIkNz6gYROjeD2qAXj9YnddZwsn2A3+KkHYhFFdBq2xt5o27PR1/oFUDHHNYd0+sulvg+d5lVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969835; c=relaxed/simple;
	bh=BaCcvO+SnjV8rqYpcMJJEh0rbChId0nrSFbtm2lRHlg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EIXbnOcLpWF+kuWOt9qIs3bPzZb/2TgR0pO7QDPCQro8+yUXh3nhg2WvVvv08ZxcfKOcjL6vIqeXMeZ+iMRs5BJBPaBa0ajkKNu5aTVO6k7Uwes6HBRHqy3hwoz8R2T96n7Jhj9gNUA0IO2IlYnJuDYXg3Ar/Ymu6Mqm92ghcs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAi+ql6e; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754969833; x=1786505833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BaCcvO+SnjV8rqYpcMJJEh0rbChId0nrSFbtm2lRHlg=;
  b=TAi+ql6eXmY1iJD+cryJ34CgawJIuGWnsoeNuFh5beZQpDRiaFb4Q8SQ
   6FJCGRBgDMMolNnh/iQqpjnzfmqVOrYFI7GzKq87EOVnu1MV6R+GEPeMl
   DG7bOYFPn4OJmDJgK4iOZlOktpIDhsWmcEPbqCilFGSVUxGjP0naeAe6R
   P5vhZbxbYiUpN1cQfgwEI5pD+FuAIQJchcMsU55ah7VveITWn44/VPREO
   FgTNg1N3pfhE1g4EVhCjZ15gmHzp3ltR77DZswaNoRYYLjfBlrs3T7jzo
   UaLqjl6wkQMcTFULKxS0sj9XiLfa7u91ck0oIivY8fImeb/Sp/rkDoVS9
   Q==;
X-CSE-ConnectionGUID: 4BW6e0HbRFS4qNG6ImzE3w==
X-CSE-MsgGUID: 6grkCkdyTm2nR9gmYYz4BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="61034704"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="61034704"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 20:37:12 -0700
X-CSE-ConnectionGUID: unBAaJuvQMWvw9f308jM+w==
X-CSE-MsgGUID: k/k6ZP0kRsWpBCvvndeZCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165713389"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 20:37:12 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 20:37:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 20:37:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.60) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 11 Aug 2025 20:37:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNlALypUd5P3bgEll5pEMXi82PvgeSex8RkVhblzFVKwEuTuZSkFSvxR/Ybd318WeFtEynaxaGYpbxWsUBRaz4b8UcCp8/OjcLy70fMTkk1M2nF6IdsSIP2YKl0nnJt9+dypYXP2Rnr/jbUwYRyULfd6Bxy7TEpKLs6ddPbC4guhQ4oHbXji4f0IZ7QGlz7OFAs236TyktsCgjaSM66yu8Zu7i2pacl33y2IJfwaR7e7lo0lsG/V05YCyvK6zdVZm9xUvy3lza7ogZczBE8NyKwXcimUO/cGfpxSJrP3BpqDtt8Us7XIn6SYwX3OH81oPzSMQNybgwWEyduSnEZOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EArHKh4LHEFFpfoENApxBYQzki21h7qJ8AB+GN+BwM=;
 b=egDXa4x93ip8E2Q2AkdOmaMsk2niRYn/Vw985N35BR2dCkFJ1YFeKLUnW/oknsAX/lAJyYVQtm/VDbhkQJPnWikhASfDkLdN9f5mJDIDTVx44cw5pyrLIg86l94JT4IS4aPz8QfeGA9TsGO3U952qidDbmFC2wdLCo5jNKQ/i9iFv+XYdN5j1TA+AhKZrCwXpnB7NaUKPyOYsDlZcOTAb/9F3NuZe+T5xyr12j9oepX9YodGvusbEGS2vNvq+zWkzepLo/J1zDPfuQPI+6GH/g/bM3yckxiSqERkEfzriWPWrMHDuZLrb3P+bzDLuKc+M8wnOR3dt3px+eH6UZe8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 03:37:09 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 03:37:08 +0000
Message-ID: <9c38cc6e-9105-4326-82fd-417d2e67074e@intel.com>
Date: Tue, 12 Aug 2025 11:36:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 23/28] sched: Scan a task's preferred node for
 preferred LLC
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Libo Chen <libo.chen@oracle.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Yangyu Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern
 Hao" <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>
References: <202508120315.19f6266a-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202508120315.19f6266a-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a60470-08cb-4a55-81bc-08ddd95183da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlFHcVJhNVBwRG5OUHRKZmc4T2dJc0JjMlpLZDhsMzZOWW12RkNEUmcxbHM5?=
 =?utf-8?B?QVVkUy82OVpHaFdJOWJKQWtYQVhtRHdxb2tsSzNWdUFmV0sxZ0ZjRkxIL2hU?=
 =?utf-8?B?RWtPNmEvMmN6Mkk2SS81eGJHdkdiaWFvOFlaNjd4YnN6NkZHN1lBdk1RU09E?=
 =?utf-8?B?bTJZcWZGc1g5Rm9zVkZEakYxQUZUd25ZcU9sRWRHUVVYYXpzSFlSV3FCekxR?=
 =?utf-8?B?NEFtaGNWZ3lYWGdaU1FudmhwL01IaXJ4a3RJUTJWM1dUR3hmOG4wRHZHVUpI?=
 =?utf-8?B?ZWJyOEFaelhBekJnL2JqcFY0K25kRlJGbk9uTUVQNDk5NytzQXEwTkZqMHFO?=
 =?utf-8?B?bDhqWHp2MldQQ1M2MzRuRDhSUlkrUjhRQ3g3aFpicllRN0tqQU9xWUt0R1dL?=
 =?utf-8?B?QW9YbkRLWFY1SnJ5U2JGbTFieVAwYlhhQ3JDd1ZmMERKRXFtVHJZMFZYUWMv?=
 =?utf-8?B?WTl4UXpFUnBmTUIvU2FpT1ZaaDlodGNZcDVPRFFDdzYveVR3N3U0TmozSUVV?=
 =?utf-8?B?UTFVM3YvWlIzejBBNmF3T1Vmd1lBRDMrQVp6V1NvbXNVTmtBY1JkdWxRUzV2?=
 =?utf-8?B?MDNRdW1qaU8xdDFYREI3Z3VZVkREWHU2YXVWOE1BWVpCN3JFSnZ2WmlSckNJ?=
 =?utf-8?B?YzFJUEtjOWo4dy82dWhsaWVYblg1b0tqZU5RK0ptTVcySHhGam5ua1ZYaWZi?=
 =?utf-8?B?VG1YZm15NmFWSnN5R2l5NTkxejBiQ3dLOVRFb1U3RjdpVjZLeUlmQkIwNWZv?=
 =?utf-8?B?d2EwdW9qWkcvZUNNY0RCdW9GWWd1VWxxWkdyRHZXMmVVVi9mbUZyMTJLQmdB?=
 =?utf-8?B?UUtObFVTTVIxYmFVZnM4Ukc4eTlGQXQvVFRjbi9QV3loY1BmVytFMFlBWnd3?=
 =?utf-8?B?TmljaXZSVEdJRFpoQ040MWtyK3plUHRLNGVZVnBjMlIxemRtQngyUFAxVzhV?=
 =?utf-8?B?SEo2cWszWXpoZ29Icng5QXJrUFFsMy9mTGZxT0NuU2dmc3h1MHo4V2dMbnNZ?=
 =?utf-8?B?alF4R2FGU1pRUW9meWlUT0VuSk5xZjQxbzFlRjZ5bWpDMHJMZDRvdzQ1Um9p?=
 =?utf-8?B?ZmpOaktTTHVPK2pyNkdKZFFxYVpqSktyT1RVZ3lpa3VjZXZNQXhoQW4yY2lK?=
 =?utf-8?B?T2tMYzNlaDVJRnJ5N0cvZmVmTHlMd3Z5YkkrdkYwWTVtOEZoUFNld3AyWlht?=
 =?utf-8?B?L2krWnVFSEt4aWxnTk9MYnUzV055V1cwQUM1VzRIMC9sdTU2eXFZbzZZZTR2?=
 =?utf-8?B?M0pxN1VsczdWMnFtOFZhWE1NaHdjTWhUM2VzSzFFd0NYN1FJekMwNEZnamxR?=
 =?utf-8?B?U3NpNVIzUWltOU80dGZXdDZhSnVWUlo3WHZGZ0hobWV5eXJnd2p1QjdNUUR0?=
 =?utf-8?B?MjZHU05FNld5NVVBQm8vbjg3akpjMGpMUFA5ZU16MHdUbjJTblFyNDFoQmpk?=
 =?utf-8?B?UmhtbTh2ZU9YYmQvNHJ2YlBOY0RzMjAvellNNHlvUDJnNDUwT0NjTy9GaDBR?=
 =?utf-8?B?SDVXWlgvak5JQU8wdjdsZmdBVVpLeWtFb3AwWEgzVEsxcWgwOTBhY1o1S2xM?=
 =?utf-8?B?dTZBRDRRaDN2bXBGTkltOUVHMkc2V0RyRWEycDZEcVE5bWtoRDdVOWxWcEs2?=
 =?utf-8?B?a3JiWjkrdEtZKzVoTTY4aUtvN0JaSFRYVHRwTUhWN2h5a09JcXB6dWE0TlF5?=
 =?utf-8?B?aDBMV09OTFJvd1BjcnBqeDNmMTBYVnM0WXVzK056VFdMdnVabjM5S2sySHJX?=
 =?utf-8?B?bzF6dmhMSjZuUnBqcVZUTjJaU1VVZFNYditFSzRFbVF5alhMOEF6Mkcyd2V2?=
 =?utf-8?B?TEZ4YSsySGRLbnptS1BNdEhIdjdvVXdPaVF2KzJReGZ6UmtJRVp6SHd5ZmNs?=
 =?utf-8?B?T3oyWGpWcGp5bkkwNHozaFNCV1F3a1k0UW5NVHBLcjVmbjZPWWU3ek1lcnp0?=
 =?utf-8?Q?rwrGQn7aGWU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0Z5NmplZzhLMzJKS3pxejljTEtSWUxXVVhpK2JPa043aHhzN2hpTmNGNWto?=
 =?utf-8?B?bS9EL3RuQ0c5YXpwbFJnc29IQ0ZaZ2F0OExiVjFBUW1jRWV4RzFqYXJITm1v?=
 =?utf-8?B?Mi9UbWxyMkJCVlpTSHJGTUY4dHhxc3ZPTG9odG03NEFLWFVaRWRRY1hialdC?=
 =?utf-8?B?dEI4bUxDRkJxdGQ0aHR6Tk03NHltZFdCYXJLblRWMlpRdi9JRU1ER2E0NUxZ?=
 =?utf-8?B?bUFLd2NSbXFrdkJicmlkS1dMZURRU2dGakowV0hmMzBwTEQ3Q002MGFwQVor?=
 =?utf-8?B?YzZoODRhSmQvQ2R6QytRbS9rL0RRNlI0dm1Ra2ZHTmlzdnlvMzlQeU5VKzc5?=
 =?utf-8?B?anBpTkIvd2J4SVhOT05JRHRaUG1pL1RNWTVWeHduL1R6bG11YkVtOFBpbW1n?=
 =?utf-8?B?c2p1bkpEZS8xUHQ2Z1l6V21aU1FFZlNscVpDZWNzQmJvU3dScjBBenh3TlJH?=
 =?utf-8?B?c3FlL2ZhcDVRSytrT0FlQnFrWWlJOUQ4UVFWWVkxUUc1RzBKUVc4YTFtM1Uz?=
 =?utf-8?B?ZE9RNkMwWHVneng5K3VkUmVjWHlpbkNzOXQvZjFKb0p4RGl5czg2MTdBWUIx?=
 =?utf-8?B?Ni80WTJKaFdJRUFDbFA0QitpeUZyUVBDUUZKL1pkRFFaSVUwUXZqb1J3RHdx?=
 =?utf-8?B?SW5UcnM4TysvdDgybjU1QmR5V0lnOVR4dGt0LzdRTndFUFV4Z04vTDhqdkZX?=
 =?utf-8?B?ZmxXdmxra24wY0xPUGdiZVgvbEoyUld0QjRmcy94UlBvOEdvNGhMT2JMZlFt?=
 =?utf-8?B?WHg2VEhFbWwxYlpyd2VWZFg3S0lwaU82OStGNHRuY3ZsYUhHWThDYlpWVGN3?=
 =?utf-8?B?THNSN2d1SjRycUc2WEpmRzd0MGZFOFVRZmpzRnlLY2t5TElaaElsdWVORy9L?=
 =?utf-8?B?QUg1bGRhRkx5V1AxTVdXMVcySEZKcGl0QWRCZXlaZDQ1bnJtdTNueDd6VXFr?=
 =?utf-8?B?anRNZ0U4aTV5YXJTbDNkRVRyc1RoUWloclkrWDRoWVl2ejJJNmlxd2RDVllo?=
 =?utf-8?B?b2M4L244SDBGSnhUUkxkV3lHRUlzUVpRekVFdkZuelZmV1JQdk1iQkcxZlpR?=
 =?utf-8?B?dDhUWEthWGpLRFJkMDFFZDkxbEYxdHUzYmJlVEZSMUVEOUdwU3RDSWM0MzZ6?=
 =?utf-8?B?ZkNpRUNUd0hQcURKQXo2QkEvaEFlS1NBbitqZmVVdEVSVHNjL1NaN01wQUFI?=
 =?utf-8?B?OEpLRGwyUS9ka1dMQlAwNzNOSElwV2QxTVhxSUJ5OVE3azdsY2NqNFlyZFhV?=
 =?utf-8?B?K3RlTlJOYUlXR2czNEMvTnhCWWVPOG9pdk1vd0pZS2dMZ3cwT0Q5cWdkRHhR?=
 =?utf-8?B?NmRrL29PVjh1RFJVeWFzQXZFSitad0FLaG5qZkxqNisrQzZaYUpMckxkUUpk?=
 =?utf-8?B?ZEJMSnYzSlp3S0VRS1grZXdNRE5xYWl2QkI3RHVyc3hzQXRYek9sZVEyV0Qr?=
 =?utf-8?B?OXluRFFWM1duZ0J5NWFjRzZuSExLUytnOWM1TmtOb3FXbXBxdVdmdDZmREt2?=
 =?utf-8?B?akttRVlJSm56L3pxMzF1aWV0ZktBZklQVTEyRjJ3Rk9LWVJWWVhOamR0N09T?=
 =?utf-8?B?dmlJdXdvOFZIbElLYjE0SzliTXdJUVJ2UEdVM3hIR1A2NWtIRU1NSTFPZSt0?=
 =?utf-8?B?VzNuNmxDVXNSV3ZUaHdpdGc5K0ZzNGtTWmlCVVl0dVlXTmFQdEhUSGgveStn?=
 =?utf-8?B?NG81alJ6UDNkM01UclB3Szl0ZUtaRm9nWHB4a0tCK2dCLzZpaXdHYUpZNHl2?=
 =?utf-8?B?V29lRjR0Rm51cVd0VHJuY0wzZDN6MEptSExuZmYyUFVPaWZjUlhoUUsvbDlp?=
 =?utf-8?B?OHlzZEZjRHFIem1uR3FrZjFJOUJVYzV1MVdZN09sallsZGtkTkIvdUdkWWh6?=
 =?utf-8?B?eVhidUhMQWxmS3k3dFRIMjhoRVM3NW5IU0tjVUlzVWx5MDkyYlVrVnRtTVFB?=
 =?utf-8?B?eWtVNTlpQTQ2OFB3MHRTZ2FSNHZ2alhlVWZWWTN2RVRQaHU4eTV2N0dkWjFw?=
 =?utf-8?B?bWNTZDRMeFBqWmIzSkF3Z2FmWkh2Wk1wb1NtVkdFcEZaNjB1RHlWRGVnNTlC?=
 =?utf-8?B?U3ZtbzVrM04zU0daMldnUHZBazZnaHNtQ0ZybVdRV3I4Qk5QcjdrdUs3MmFs?=
 =?utf-8?Q?7RQkArx5k8GoyZ7rE1WsHk5TT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a60470-08cb-4a55-81bc-08ddd95183da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 03:37:08.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI5kHxdl9VGOr4HeakkeFTPyCOiIya/+df9473+WenSpVyu6xRJsjLwzxGHoTaflyJTCO1pB328VGHFS20ooPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com

On 8/12/2025 9:59 AM, kernel test robot wrote:
> 
> 
> [   19.177186][   T64] BUG: using smp_processor_id() in preemptible [00000000] code: modprobe/64
> [ 19.179622][ T64] caller is debug_smp_processor_id (lib/smp_processor_id.c:61)
> [   19.181347][   T64] CPU: 0 UID: 0 PID: 64 Comm: modprobe Not tainted 6.16.0-00023-gff797757d658 #1 PREEMPT(none)
> [   19.181372][   T64] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   19.181385][   T64] Call Trace:
> [   19.181391][   T64]  <TASK>
> [ 19.181401][ T64] dump_stack_lvl (lib/dump_stack.c:123)
> [ 19.181440][ T64] dump_stack (lib/dump_stack.c:130)
> [ 19.181465][ T64] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53)
> [ 19.181494][ T64] debug_smp_processor_id (lib/smp_processor_id.c:61)
> [ 19.181514][ T64] task_cache_work (kernel/sched/fair.c:1422)

Thanks for the report, will use get_cpu() in next version.

thanks,
Chenyu

