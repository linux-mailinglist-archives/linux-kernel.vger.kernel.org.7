Return-Path: <linux-kernel+bounces-772762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E0B29738
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D9AE4E543E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE225D1EE;
	Mon, 18 Aug 2025 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8Mj4Q5I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0A20C00B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755486665; cv=fail; b=b3ycYonWttbQgHWm6JI7JmN62y9VRUI2JGvzE3MRkWXNsDLbEpMfFb4E6HkRrxAw8a1SqNkrmjDNQB7+qk4kfuZZJQIiDAlYHLj/rD8bwoWE6aQg2tgRfRPkQsUHBhCFkiKeOVdRHolLW/HOz6kfZnGr3InHJG0qKrq3aTQQKq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755486665; c=relaxed/simple;
	bh=CEj6U4/FBjsZ8q5ZjZUJJWW34mI83o/lmEUdnPG1uy8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gCMlopbMK4AMSioegNOe+wNJ51OCTS7ete/81uV8f7gGralFw2TOpZzqRLIIW7VnG2LdJUITknbAfdPLmR0C3KMI8P3HREybjHSFHmfJ/3UBRO68kpDcAaHAdtgs9WkOgNc7Us7cggSRPavYZzhfI6CKbfTnRtTr20KpWvDrT/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8Mj4Q5I; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755486661; x=1787022661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CEj6U4/FBjsZ8q5ZjZUJJWW34mI83o/lmEUdnPG1uy8=;
  b=W8Mj4Q5IZPD2HSOgzDTmRP40HIvF25T+dtIuXkw/nHglVopPzLbOTAE0
   X691YAzTi0uVKUWOrLm+9s26fNHP8ag7zoh7ODm3tTiIYqbYlCaDy4G75
   7MQnKOvhxMAz7qO3tvdvwynssRJ2IiLIQ2vJmMbavKLYULdIbFz2sl2L0
   DP9L4alPYzT4HFOgLDIG/VkOF6ZqASBj14LaTX55UCrRJBDeYG16HA0+n
   BvQsSsISS52ae5mti+4ItspGse1djhXrssGEN++TPwLpe2pONwgs/sWEe
   RhdbX+MNWjh2UUgyiJU9UvaU/ji0AP3SFo0lD5oCSOL6FP6xFgBKJhFit
   g==;
X-CSE-ConnectionGUID: goshGNy0TRS5nCXjVivpnA==
X-CSE-MsgGUID: 9L6HrWGgR4KiRAtSitctYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="68306066"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68306066"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 20:11:00 -0700
X-CSE-ConnectionGUID: Py2zBJGOQGG3ItsLw98cJg==
X-CSE-MsgGUID: Yn64Ry0iQKSEEJpII4Y4Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198476349"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 20:10:59 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 20:10:58 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 20:10:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 20:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQD/LXM3ecH0066ILURGgc7kCmq+pq3MFCPI9A25U3UGntwf5aW1gFwQrOehuQxCShrMQLGpaXDa6OuxOeGo5QvIg/tppzUqq59o4OQQ3wObqeBh3gpwhzGCGOs5VVjmLTF3AI7YR06Yrx3iFytIIFHnBOPrdFZRcVpBRLgYjLB3SHKNRWOcwRZLNRTH3fy1gLXxh117RxvjCgWb3EBHwKyfrb0gGgtpU+1Oquv7UrfH2RlDqRLoM8pTQz8wfm5PkpysCOu/2ujRp+3NvzGodT1aAIsvCSItgRPnDKM01vkn31fbHG3h9Qz/BAttokgxSDqhh4r+LdwGm9zRbxiaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vruoN5HfLezUd8GFyjKApA1wY1G+DpgIrG8jRWw0mC4=;
 b=D/qKUv7ItK3WXfzMQSjOqaG9AunL4n6D3/sb8JYv3rrwycamvNe8LUSOV0B8pH7F1watAiadFXCt9yG74tyCTxaC9OLGNtWAfugTA4nXgNNvA08pomPN3E2pUCGaAl7xnRdk3L6bLqqDYIfmo8b+pdZIcSk+oWhYvBVNv58nEAKkr5Kv+y0kL4kNbyqRDaNVbd4A5jibaC/0RGj6b39IEXm2JlpjTVg6w4QTAh2AdnUchMUTQM65a6Ez2wPUFK4osYOfBLKUt98eO/wuEH2fW9vSn3HYq1drLzKoNKItyzT1LLzFH4+zHZBWCr1ZXm5gFrgFBDOP2j2NaPy6qJn13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 03:10:48 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9031.021; Mon, 18 Aug 2025
 03:10:47 +0000
Message-ID: <6c439f19-6569-4142-870b-ae011530f1b0@intel.com>
Date: Mon, 18 Aug 2025 11:10:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
To: Aaron Lu <ziqianlu@bytedance.com>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Valentin Schneider <vschneid@redhat.com>, "Ben
 Segall" <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, "Vincent Guittot" <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <4efdc1a8-b624-4857-93cb-c40da6252983@intel.com>
 <20250818025014.GA38@bytedance>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250818025014.GA38@bytedance>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c06ad19-ddfe-4fd1-35e3-08ddde04d3cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tqSWlSaVc4SW11RjVIMG9xQmdOMXNMdXBPMDY4WHIwZWpvSUwzS2dwbXdX?=
 =?utf-8?B?SUJac1J3VUpLNTJ5dTVveWdaU3pMNWJJbnprYU1ESndCajQ1VURwSXZHVEYr?=
 =?utf-8?B?TlJrZUhmeThsRWp2cEg2YzFEMFhyUHJsamtOVzYvcHJaSFZ0bU9UQS85VlNm?=
 =?utf-8?B?UjhkZEJIVTE0V3ppUkhVSzFya1dEcGRDczBKTkFFNkM0S2tIS1BBeS9WZnJP?=
 =?utf-8?B?cmoyeDJpdURnYlNvbnZXQ1VsYjhEREhNQWlFcjAzeG43YTdWOGRZQUZjeDVI?=
 =?utf-8?B?dVRZcXdGR3FlRU9PZ3BOWFlETVcxOWcybm90T01TWktaM2xGMUp3c2lKT2hm?=
 =?utf-8?B?VEtVaDdFU2VUczZLTDJhbkROWkZZNGJVeUFTbTRJYlM3SWs5cXlFOU5vd2NE?=
 =?utf-8?B?UzkvSXBVQ3hZeUtkNmg2Q1J3Q08vc1RRVkwvYjl4dldpQTBkNCtuNW1FRU1Q?=
 =?utf-8?B?Q0VVdTU1RERKcFlhRE55V1JUYWtOOXpraFRabjN4RlpQUnF5R3IvcjZmNHB3?=
 =?utf-8?B?T0NpNzc5UFJ3R2M3UTJOYWx1UElBelkrdjFNRXdJc3JUR2VYMjU0MGg4Y3hO?=
 =?utf-8?B?bU1rUFlkVmVySlRMWnIzZDV0OVM0WVZsRnNCbGk4UDZZSW9Ec3RVQ1hJZjVU?=
 =?utf-8?B?YWtXYmNCc2dsSE0vanVsaGhoNDNFVUVDdXBweUwrV3JEOEd3dHV6KzhCa205?=
 =?utf-8?B?UWZVQzRYeHQ4VE5RbVZob0xLcDRlNHBsVHQyTHdXbjJldVFEdWZJZ1haTTF6?=
 =?utf-8?B?eFVXNEJnOVdZd2NiUHEwVTNycmZ6aTdEazYwdE1MQTduY254RWVGSVFBVWdk?=
 =?utf-8?B?dmVaSlltbnBQQmg2WUJIQUh6azZsNG1LYTVnMVA3UTFQOVkzMGRySGhrZWY4?=
 =?utf-8?B?NFpUWFplZGY3TDdtd3l6ZGY2UG9mczB4aG1tSFVaN25sSTEzS0VTQkZkb2dR?=
 =?utf-8?B?STV0eWpkVWN0ZEFSY3k0bGtuc09vOU1RK2V4WEpSUEt3aGlxS2RkZGJ0OHRU?=
 =?utf-8?B?RHZqdUt4a1RzNmpTdU8zZGx4aUxUTnRZSDU3ZkUxUU0vWmx3RVk5bEZuMXBn?=
 =?utf-8?B?MERKNnp5VkNCM2xGdjc1YmFwR3VYZUVaeVNrT3ZJTTM1QzdqUmxxczNyLzJ4?=
 =?utf-8?B?aUcrZnJLd0VpUGJLWmR0RkQ3c1ZOSVhaSW4xdS9zL25RY2FuQlFsTU1yWXdS?=
 =?utf-8?B?ZGlaSjh6dFlqUG9VbDg4VUNHSWd0UHRWUGlaRnBnY05CamRCeUNkVWMzdXI4?=
 =?utf-8?B?S2I0bVhoNXNYNEZJWC83c0RsOWh0QUxCQlNqSXFRSzljOTVwS1V6U05ZT3Qv?=
 =?utf-8?B?NVovNk9wbFIvVWY4cVkwV250TEhqYVhZZXhzNVF6SUxnM0tSOUtDdlR3Y1hF?=
 =?utf-8?B?UjJFRElhNmF4T3ZiK0lyNW0rUlhnV1NXcS9rNjZpR2F0YWZFbUJMRC9GTisz?=
 =?utf-8?B?bmRkNlhGNTY5SGpGcjh4NVlXZjExZklMWmNSYmJSZ2dkYTVKYlpjcGI2NXBL?=
 =?utf-8?B?MlJkNFQzd0I2aVNWT2lraTcxMnQ2eDBsVFhOZDltSGFXWm84cnBMMUpxRm8z?=
 =?utf-8?B?dEl0WDNrMmNZV2EzUitmTWt1ZXRRVnA4bnczc1JKeFVwMXNaS2JwckFrNHYr?=
 =?utf-8?B?ZnNsVlBiL3ZoeC83aWtBNFdUcWpBMnVrTE9CNkpZYmx6ZFJmZVUrOEdzdVB1?=
 =?utf-8?B?VjFJcm40T2tNWWNVMDZpM0QxYXNtbWlhdkV5eDAxMTVndWFlU3R1YVg2MHJq?=
 =?utf-8?B?YkNyQithWVdvRHI3ZjJHeEJ6amgvbWcvWWlRcWZOWHRCK0Y1bGgvSFNLbFJh?=
 =?utf-8?B?dEFwelprVUNabmhDK2VzYkFjTHVCZGhLKy9SeE1Uc29XRWlGbUcyVHBCMEpM?=
 =?utf-8?B?OWtjUG5jbnVWY1ZvSThJNGRWRzBTM01udDZCS3JWV2pMWWk0cjdFckNWLzJY?=
 =?utf-8?Q?unZDCeogZ4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEVEWGVFUWlvYStpTzJKMnhhM0FEWElNa0hlbEhxV05iMU9GMGtSeCtESVBR?=
 =?utf-8?B?dmcwSWZzRUlaZWcxQ0NKdTN4cW8xbEhEN25sMDJtK0d0NkRMVHRBaUVqL3lv?=
 =?utf-8?B?WGVDeHhIaDJYZW5OL2p3L1l5Z0ZCQlJULytTZ2wvSDA4SXBPTzJYQkl6OEcz?=
 =?utf-8?B?Z0t4eHdQY0VDMVBJd21jMU9jc1F6ajhLMVFYSHBzb1NhSXlKZERBd1Evalpu?=
 =?utf-8?B?eDloaS9tSjd3UEp3Nlc4NlhldStWdUdnYzlVL1NIdXppZHR6RW90M0RyL1di?=
 =?utf-8?B?cVNGNnFxcnVxcUExeHFOQ3l2MjFBUzB4YkJuZnFNVnNWZDV2SHN3Rmp4UnJJ?=
 =?utf-8?B?RlNKaFVyR0dadWlLWFJmYm9lVk9jTnVUc05SeFd2ZDhSWXh0Qk5ROWtRc0c3?=
 =?utf-8?B?STZKc3MzSldNcWRiRjM5ZTA3T0J1U0RaYm5GZkZ1T2FYSmZNQ245Y2MwdUw4?=
 =?utf-8?B?cm5MT3hzY1pNdEJJUFNjN1M4bTN6QWVVNGRORFhvMnVGOWRIbjV6a3NvdzA4?=
 =?utf-8?B?Y1FJSEtjQkZBbkdKSlQrNlQ0ekdsWXhlL0VnMjEvR2c0cU1Md0daQjkzak5I?=
 =?utf-8?B?T1ZPU25vTEVaT0dBc2cwS2p0LzZSTWVwUmU4NEw0cDEzczFnckcwckRvczBC?=
 =?utf-8?B?MGpwNmx1blpXUXJva0Z0U0VkeWFxdlo0bzZWaENrMHhyVTBtSHdmTklMcGcz?=
 =?utf-8?B?WXA5bDQ1bi8vazg5ZVFsTjBWcHl6U3ZYNHFWNFlzWUo3RHN3ak1LcXUzeDVH?=
 =?utf-8?B?Myt6TEZaVFRWT3JHYVdxaFJSSWljL3k2U1BQSXF1b2x2TE14a2FzMU5KVmNT?=
 =?utf-8?B?ekZKNmtmMk1TNlVjSUdkOEJhU3FTQ2pWMU1oWlNndWxwcnp5empoTndGZEk2?=
 =?utf-8?B?bmdlV29ha3NWem8zVFpnL3owSkVvL2s2YWVSY3F2NGs2aGpRZi9DOE5tbUdH?=
 =?utf-8?B?M2M0MVRQNmxLbzJONDlLTS8xdmloSnF4d053ZFpocHl5L0NUc0g5SDNBejdx?=
 =?utf-8?B?SmY0TXRuaTI1R1Q1SE50SDdOOGl0c0RJUG12YyszSmNvMEc3eFh0Sms1bVhR?=
 =?utf-8?B?TU4rSjcvV1BwUHBFVFBZL3diSy9DUS9EMzFIc0xHMURvNFp4amVNR25ZUDFj?=
 =?utf-8?B?YTFkb3JIUmIrL3RXMWRoZTdHY2szVWpzZFpEbXQyc05SSHNjeEZsZmJ5UnEw?=
 =?utf-8?B?Rkdnc0N0dmIvRlc5bmN6OExsbjVZUGRzNlNJTks2Y05TN09iOE5HUUtaQ2di?=
 =?utf-8?B?eHhCcElOQkJ2NlVjck9VSVE2UjRDeTJrY3lzR1FWcGdkOXVnZmU1cSt1S0pM?=
 =?utf-8?B?ME95bFdQRXRzTkZMZTJkQjBtNFRIV3NRaXhZcldwS3p5amowaitBQ3pZWUp6?=
 =?utf-8?B?NDk4MDIvK1ZDQ3Rsc0FVeVQ3VWlVZ1p5MUp3ODVaUzRVVmZyRDR0cTduNXla?=
 =?utf-8?B?OTl6cU5UbXdGQUIzZm1idnhKSktkaTlIeEtVQ1dabnJuMGlBNUhnQ29rOEox?=
 =?utf-8?B?SHU2WDVRWFNNaGJvTXV6SnUvT1laamlRaVJ3NGdsY01HbmtIQnBtemE4ejB3?=
 =?utf-8?B?VVFodnJVT2tzSk9LSzlZcmNaY3QyMlE2Q3BqUlJxaktFS1B5RllmaExYVDN6?=
 =?utf-8?B?L3I0MktIU0xkVmphc0p1Y3g1emM5cml2MUtxWHZXSnFucGNCb2kraWZDRlNm?=
 =?utf-8?B?T1paN29Wb2tYVXlHdGtkdHZVL3NndEFsckhDSjlxeGRtUG8weHA4QmNqL0dl?=
 =?utf-8?B?VmM2L3FJVUNYRDhtSWoyWENNZTBkZm5hNU03SzJuWDJ4ejJQcXF2YUxmMXRn?=
 =?utf-8?B?cjlJc0ZjZDd0emMxTXNQRXRoeXVOSzR5Q3FzSENTV2lYV2pQcmVBQWpVd2Zh?=
 =?utf-8?B?NThhWHE1OUUwNjQ3YUplS1JJUjlaZVQvSTZpVUhQVFRYdnZrSWtKL2dXQm9m?=
 =?utf-8?B?djhOVGhIZXhEeUkza0w0OFk5RCtuM09BRHFXZUZkL2ViS2hLQTR3RkdKRm16?=
 =?utf-8?B?R3NOOTNhL1Mvc1RNbHBtVmVDMVd4UVNqUWtmNWw0bFo0bjVTdC8vb3RYOGlH?=
 =?utf-8?B?UXdPelhaS3RXVE5vbUlrUGJuUWcwdGVNQmpRVWpEem5hSkFrUjVsOHIzZHRk?=
 =?utf-8?Q?J8pav7yBbYLpu4mztRhjIXqVY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c06ad19-ddfe-4fd1-35e3-08ddde04d3cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:10:47.4867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bzvV/7D4Zsa5f6zZsVp2dTrkvJcQ2FCkH2gypQyew0PtpV5fC66jHA0Rm0F6GTjGyo6ONeSGzny8MEvsFgFz9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com

On 8/18/2025 10:50 AM, Aaron Lu wrote:
> On Sun, Aug 17, 2025 at 04:50:50PM +0800, Chen, Yu C wrote:
>> On 7/15/2025 3:16 PM, Aaron Lu wrote:
>>> From: Valentin Schneider <vschneid@redhat.com>
>>>
>>> In current throttle model, when a cfs_rq is throttled, its entity will
>>> be dequeued from cpu's rq, making tasks attached to it not able to run,
>>> thus achiveing the throttle target.
>>>
>>> This has a drawback though: assume a task is a reader of percpu_rwsem
>>> and is waiting. When it gets woken, it can not run till its task group's
>>> next period comes, which can be a relatively long time. Waiting writer
>>> will have to wait longer due to this and it also makes further reader
>>> build up and eventually trigger task hung.
>>>
>>> To improve this situation, change the throttle model to task based, i.e.
>>> when a cfs_rq is throttled, record its throttled status but do not remove
>>> it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
>>> they get picked, add a task work to them so that when they return
>>> to user, they can be dequeued there. In this way, tasks throttled will
>>> not hold any kernel resources. And on unthrottle, enqueue back those
>>> tasks so they can continue to run.
>>>
>>> Throttled cfs_rq's PELT clock is handled differently now: previously the
>>> cfs_rq's PELT clock is stopped once it entered throttled state but since
>>> now tasks(in kernel mode) can continue to run, change the behaviour to
>>> stop PELT clock only when the throttled cfs_rq has no tasks left.
>>>
>>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>>> Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
>>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>>> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
>>> ---
>>
>> [snip]
>>
>>
>>> @@ -8813,19 +8815,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
>>>    {
>>>    	struct sched_entity *se;
>>>    	struct cfs_rq *cfs_rq;
>>> +	struct task_struct *p;
>>> +	bool throttled;
>>>    again:
>>>    	cfs_rq = &rq->cfs;
>>>    	if (!cfs_rq->nr_queued)
>>>    		return NULL;
>>> +	throttled = false;
>>> +
>>>    	do {
>>>    		/* Might not have done put_prev_entity() */
>>>    		if (cfs_rq->curr && cfs_rq->curr->on_rq)
>>>    			update_curr(cfs_rq);
>>> -		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
>>> -			goto again;
>>> +		throttled |= check_cfs_rq_runtime(cfs_rq);
>>>    		se = pick_next_entity(rq, cfs_rq);
>>>    		if (!se)
>>> @@ -8833,7 +8838,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
>>>    		cfs_rq = group_cfs_rq(se);
>>>    	} while (cfs_rq);
>>> -	return task_of(se);
>>> +	p = task_of(se);
>>> +	if (unlikely(throttled))
>>> +		task_throttle_setup_work(p);
>>> +	return p;
>>>    }
>>
>> Previously, I was wondering if the above change might impact
>> wakeup latency in some corner cases: If there are many tasks
>> enqueued on a throttled cfs_rq, the above pick-up mechanism
>> might return an invalid p repeatedly (where p is dequeued,
> 
> By invalid, do you mean task that is in a throttled hierarchy?
> 

Yes.

>> and a reschedule is triggered in throttle_cfs_rq_work() to
>> pick the next p; then the new p is found again on a throttled
>> cfs_rq). Before the above change, the entire cfs_rq's corresponding
>> sched_entity was dequeued in throttle_cfs_rq(): se = cfs_rq->tg->se(cpu)
>>
> 
> Yes this is true and it sounds inefficient, but these newly woken tasks
> may hold some kernel resources like a reader lock so we really want them
> to finish their kernel jobs and release that resource before being
> throttled or it can block/impact other tasks and even cause the whole
> system to hung.
> 

I see. Always dequeue each task during their ret2user phase would be safer.

thanks,
Chenyu
>> So I did some tests for this scenario on a Xeon with 6 NUMA nodes and
>> 384 CPUs. I created 10 levels of cgroups and ran schbench on the leaf
>> cgroup. The results show that there is not much impact in terms of
>> wakeup latency (considering the standard deviation). Based on the data
>> and my understanding, for this series,
>>
>> Tested-by: Chen Yu <yu.c.chen@intel.com>
> 
> Good to know this and thanks a lot for the test!

