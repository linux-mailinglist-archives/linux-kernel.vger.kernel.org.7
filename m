Return-Path: <linux-kernel+bounces-769456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E83B26EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 20:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4855E4E3576
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE4227B95;
	Thu, 14 Aug 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcpIXEJi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40462217734
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196252; cv=fail; b=mYmnWq9/VrRIkZp5f5Bk06IJukiERnNj/fjFlJzH6bOxaH/g2BWD3i2a2dP/f/P6F3l/DZ+xx/7F3xcjClepefLwTNIVrJ9wXPqcowLYYd0lDZbefKAWV+dCXnV4q2vLruMulr/LBgv5D64RO5bMLd9cxaW4JyqDlcYxF8ZoC7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196252; c=relaxed/simple;
	bh=omNurphTFuK5a5/FNPEfcwmk8t0cjDJzWGItlUA27Fs=;
	h=Content-Type:Message-ID:Date:Subject:To:CC:References:From:
	 In-Reply-To:MIME-Version; b=JXukbvR7lJS/wBRnQm+SE588sxVscY96EPPBpUyv5KOn7vdJIrMYAIa5d0eI06Bq/v0+9b5qnAwpz275+oR6Rke7OEHY7ts//7Zp4V9uuaR5j0ZH0fTogFfdL8/z7mn6HveM0VEHPFjzQQc/E3Gx6zmH2eglA3ETjJC0PuNiEwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcpIXEJi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755196251; x=1786732251;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:mime-version;
  bh=omNurphTFuK5a5/FNPEfcwmk8t0cjDJzWGItlUA27Fs=;
  b=GcpIXEJiRGp0brvAFJA0/+bXUFo3Ml66cD5UVwfQlYhEoB6c3Lj7s92K
   Ez4SiuFb/F0lLVvkOLiTkCZxc/FULrzYXNhpUh8KYxr5haEG5kf/PsepG
   nlpTgQd9bG8ZELd5e2RZE3E8+OKwKDoJjsYLYn8Nr71805YwiO+E2DgPy
   z5zLgVyKmdeBw9SzrO3VU8LbvLq2Z12P7NdQ6OihfehEbAjHTUPZ5n5sH
   lHlYU/mxW6M4mX+3lnBBsj30RyFxmTJEX4d1lQquVodyTd+/jxNeA7DXx
   yLaa2rL2OH8StfTh+kWcqDS/vxa68bEeE8kwxcCULQ547ua/GTULcZIbT
   g==;
X-CSE-ConnectionGUID: mFsNyehOQNW9v5Ra4c1Z8w==
X-CSE-MsgGUID: TVXVdTAtRH6TAx2JaN2ItA==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="74972746"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="diff'?scan'208";a="74972746"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 11:30:51 -0700
X-CSE-ConnectionGUID: 9tGNdI3CTYOT3Fw9piIv+w==
X-CSE-MsgGUID: cSQSnMElQIK7vXHg0eIfxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="diff'?scan'208";a="171026993"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 11:30:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 11:30:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 11:30:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.84) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 11:30:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WUJruKPuAixz1l5T7Oepc47FVeET8O3S6zwiy53nBeIC5nHh7WUJB/FrEsS/Hjnbz5/nxyeDEGfPwjhea765sYpsoQsUNUHHEDsHnfbl5QxHgq9RU5+jN1lszhTcDTtg0NHk++THPNrythKSiK8UheZ/2G42+of8j1VbPxs38bNRHUezMD09c3M3X55oGSHLm8cloSrV0T09wxN94YyBQ2SiJoLDWn/A37nfIzmCWf2msNsC7WeH/fLtchY9MYvBykFuaWZXD8HIMim7wJA+vVIW+fcI/ilROP+Z5aVZefbOTz3gvG1F0oEj4ue10WSTcZ7mnUzPfPNc5xzK9p0n9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8TkN9N8nV4pd/7v5k8AN/GIho61HuJncl7tQbVN/5U=;
 b=lkpaiMnpZF3q5gRt/ewlKjI9mhm58KKYJahHXV99QuZUewNaNfaVr2nE8jbV61MYu9tybhZXOljQRbuoakyROK3RVnFUa4g0UrPmPeVza+QMvnC8fxL7AEGSbTQWXKHGfAfN++zVBzZUkEvQaLPtB6kmGP7X6/LI0CH9YPGPi+3HbEdvtgFqYWfoIzdxhFgbOnC/5YUxQI90YPYelG6f0Ga7V34k28zyi7zgf2+aGNQNNM+CZoiwJpEiP/InlANYjWeqAJW9ipC0pvr81MqgxGT7jxC3PgCSFD7K7REkM/pX5r3tqjrO4QQTcXmxZXiahRXJMVKbLcxwU7uI0hjdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 IA3PR11MB9421.namprd11.prod.outlook.com (2603:10b6:208:578::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.16; Thu, 14 Aug 2025 18:30:46 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 18:30:44 +0000
Content-Type: multipart/mixed;
	boundary="------------xpSmmnH9FrmiXISKsZ0j8Fzf"
Message-ID: <5873ddb4-c219-487a-9ccb-0d3eda02d97b@intel.com>
Date: Thu, 14 Aug 2025 11:30:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] x86/microcode/intel: Establish staging control
 logic
To: Dave Hansen <dave.hansen@intel.com>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <colinmitchell@google.com>,
	<chao.gao@intel.com>, <abusse@amazon.de>, <linux-kernel@vger.kernel.org>
References: <20250409232713.4536-1-chang.seok.bae@intel.com>
 <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250813172649.15474-3-chang.seok.bae@intel.com>
 <06d43a86-204f-4658-9759-d24b7038b2d3@intel.com>
 <776e439c-60b6-474e-ac47-f33357c272de@intel.com>
 <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <04cb59cb-e9ed-489c-b36f-6c6209b2e93f@intel.com>
X-ClientProxiedBy: SJ2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:a03:505::7) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|IA3PR11MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb392bb-6114-4828-6f02-08dddb60ae0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mnpnd0VScUNvanR3MUhJRkx5K1p4cFNzVmNZancrdi9WcTFadkdiTHZJaXls?=
 =?utf-8?B?UjJ1Wmx6QkZtOWJLQVBray9pMmplcTFkZzkyMG9Cd3FRSEpUdDZLOE9IdnVq?=
 =?utf-8?B?emhkdzhjQ0lHNXJ6c2pnak1Fd25DK1VIWGpWT2NSTnZ1L3FPYWdHL3NnRnB2?=
 =?utf-8?B?Z0llb29aSy9ZYndzSGNGOFlOY3kvUFhPTHhGaHJDR2NSc0tuZWpYMkdObllP?=
 =?utf-8?B?RGVpZUVTam5pSkpBMERDdGtLbUc1UzhQT2RqenRWWHU4UmFMWTEwSVVBMmJT?=
 =?utf-8?B?Vk1vakl1TkxKOWtVL0RjditqOURJSEtDWjBmSmZkY3BtRGo0TUZWZHcwc2FU?=
 =?utf-8?B?MnZHOFpDd1RxUHQrWDU3WnRNR21CVHkxRmpmL2d3dUZjVHQ1VEI3R3R3UDVm?=
 =?utf-8?B?dHFzM2VCWW1QVVZQQ0lvNG1Za2YrT1kxWnAwTWtaUXUyZFdNT0ZwMVk1Ukxv?=
 =?utf-8?B?VEFKQ1JMNnE1MjNSdGVUYkVLc3h5NlU4alVSNzYxSWcxTE9hTXI2STlhM3J4?=
 =?utf-8?B?bG4rWHA2WG5ZbVIrYnh2SlVScVM4ZGJGZUErOHNDS29YZWM3NDZEa2U4RjI5?=
 =?utf-8?B?WExiaFd0dlFjNlhFWTVtUXpDOUJ3LzgvK0xvcHdUc2lDUk4wZGN3bXNVcGUz?=
 =?utf-8?B?VktqL1ZiWkhRenlmQVJMSkdaUjk5aW5zRDlJMWxNdkRONWpQYmVBVEpFYWpy?=
 =?utf-8?B?ejI5S2pyeDIrUVVlbDBFOHNFVkFPMFpxempaajlyRlRuRFkrWXdoVFd6azE0?=
 =?utf-8?B?UVZrOTBoOGQxVFRQeUI1cnBkWDhMT0R5QnR0TmdkcGpYM29GMFVXblA3SnA3?=
 =?utf-8?B?d3JwemtONjg4OCtUR3Eyak1FL1FPMlNGdTI0eHQwNmRWb085cHlxWlVhOGg0?=
 =?utf-8?B?Qm05Y2M0V3RRWmZSSUl6N3FuTTZVczk5OEEvTTBGRmcxLzVYcStUNy9Sd0hi?=
 =?utf-8?B?ejJ1V1NreVRGbEJkeW5kdXVQMUxOeWVTY3ZvL0Z0NDlOSHZ5RXp5U3dhMEIx?=
 =?utf-8?B?dUI4dk0wSHh2NGxSVWZ6ZnZQVFl4RjkrOGFtS2M4WExwbFJoc1hhQVV0U1Bv?=
 =?utf-8?B?c1lrai90ejRIbmxiNjZGQjRlNWFFM0Uya3RKRG9EVnNwZmV3OTJJeFd5cUZp?=
 =?utf-8?B?OWVQVW1HK3dCeG5xNk5iV2ViVlZueXo0UlFYOEtIaFRJREI0OVRSN3J3dXZP?=
 =?utf-8?B?V2ZKRkMvcU53L3kreXlLVTFTejRqK1ZNUlRKUVZ3UmErVUxvcGRGM2dCOVd1?=
 =?utf-8?B?eWZDaHR1L3h6U3hleEl2SHBPWU5wc0Y0ZlFqWUZFRiswZFp3d3Z4U256NDhy?=
 =?utf-8?B?VGZpNUovbWkzeTFpaTdqNjFRSmhuREZrdVVpVHVlQVRneDZQL2VqYjRmVk5X?=
 =?utf-8?B?UEFIKytjMitmSmlicklDYWMxOVpkcXlMNExCZzZRNVhTcUltQTNhTnJ6M0VX?=
 =?utf-8?B?UUdEV3lZUHFJem1UTnhic3NDaW9JcDlrbG4rZnU3T3RSSzhucWpUSHFzemUw?=
 =?utf-8?B?dlJFbGJabU9vM1hVY0IwRVZ0Z0x4ZFRjRmFMSHFyV0tvbU1UUkEzSUw1MlBU?=
 =?utf-8?B?RHE2VXI3bUZHYmhZUEVMaHkvc3lveHJQaEprNUI2V0lOb1NkalJnNU9xNkJu?=
 =?utf-8?B?aTgrVUQ4cTEzYkkvL0lzNzVnUFpUcnhFSHlYRlRFWThwVXlBTE82b0lUYkNZ?=
 =?utf-8?B?Vk5KM0dqVXQ1d2JtSDAwVW1Fb0pPT2dCS0FIRG9nV0xydzZ4elpMZzhmSVZm?=
 =?utf-8?B?L2ZKSDN0ZFp2RXFlUG41cjdBOVBTcXhlZXpLS2xJSGp0Ny80Tlo4UzZKS2RT?=
 =?utf-8?B?YXQ3WjNnS1czL3kxWmtmVzEvdnQ3emtFcHh0SGtTeVNCOFhxK2xHTTgxVThC?=
 =?utf-8?B?L3N0NHdBTzd4SDJYU1J6aTdQeXBWQjZyeGpPeEJUQTQ0eEhRa0pPcGZqdU9r?=
 =?utf-8?Q?1gtn85jIqro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzI4WFp5Wkw5NXhlMG5GVithSXcvNktqUm50WEtNT2U0elRpL3Vjb1FNYitv?=
 =?utf-8?B?ZEszdW5OUW1VSVc4MVJNUFh1R1E5bjBUZDVWblQwcFppTWdiQVVLYzZ5S3kz?=
 =?utf-8?B?cEswZ1ZhZ0I3QmpRSHI1THRpUlllK1pwMUVDT3oraVZOQVppZ3hEMXpFbUI0?=
 =?utf-8?B?YlFRWmUzZHZ6enRGNjduVEV4OC9pKzIyNjBxTlVab0VRanRIMkF3aTIvM0R1?=
 =?utf-8?B?U0VFbkc2TUxUMUMvcVlqUFlNemtYMlhLM1g4NHlLNUJxcWc1d05NTWV0V0xX?=
 =?utf-8?B?bnBiT0ZOQXJtbWFrZXBPRG4zWWkzVTFNUFZ2YzdHakoyd296YlhDWExmd0dU?=
 =?utf-8?B?R2JjN2FoSWNoNnoyUFdyUW1iMWlHeDJiSitGblJKRS91RytmdSsyWWo5ekYy?=
 =?utf-8?B?c2V6YUJ1eURjS0hPaFVSdEthR2FKMTVUUmlLbkxKUlVJbHkwNGhTL3pyeFhV?=
 =?utf-8?B?STlqK1ZLMTBWU005VExuVStvcnl6dzdDNjZLRFZoU1pGenZBTFBQUzFST1ZU?=
 =?utf-8?B?cEVYYXA2ZmZFQnZjd2QxZlRyM1NDL3dpTEdJZFhxeW5JOUlHYzJpMDEzMEFM?=
 =?utf-8?B?eXcrYjgxeCtxTWdUaWNHdVU3c0RKL1Rrd28zT1hMakRFbjU4Q0UwNW8yQ1JJ?=
 =?utf-8?B?b1JzVmE0ZHdaSkNuc0w5QWxDWHBvV2hFZEZ2Y252N0p1cVZlK2RtSngxZlBV?=
 =?utf-8?B?cmhXT1VicFF4VVhFeXVMbnJSRU5lQkpVaFdMcjN3S2t6MkJFNEx5bDNCOWgx?=
 =?utf-8?B?UjJGY2g3NUd4aFk3bHFzem5ZQndaaFhuQi9Ga3dEM0RiaVFmRVl4dCtoRHlK?=
 =?utf-8?B?bjNZMFBXTmpIWFBZUyt4V3ZUZWQ3UzRSd0V1ZDZlanlPWWoxd1dZOUlwL3JI?=
 =?utf-8?B?bFcvalBLWUIyRU1pUHpJNmh2TFZJUlRxQXN4YlRCa3pHUWJCZ1FUKzFFNmpy?=
 =?utf-8?B?YVJwT1JjM2JaMlQySGVmYWV5bGE2UFJwa3FNRGRkaUo1WU11MGZlR0p3ZHhx?=
 =?utf-8?B?RW5aSFdySW5ISnEwbnRNSG1vaGNlNGZOakJlcHRFOHRaRmRwbE9zUkRUcjlQ?=
 =?utf-8?B?QkdOS2NhbkdSak1SaGllOHFtckRRWnhvOFYxc2ZMUnJkMjM0TytOOXV4cDBi?=
 =?utf-8?B?WmlqRmVuNXl4Ry8vcVMvbWd1WFk5VzVnWFRsWkkrcDJQWXFqaHJ0a3JIQy9F?=
 =?utf-8?B?VFRVV2QvekdCNkVYaFRocExqVUhySXJNZU85UDZRMHRBZ0dZLzBFL2E5NVFu?=
 =?utf-8?B?QU5VaFczMnZPYjVhYW9HNmpnWFUrSU95YXBjUDZzN216aEFxMWI3SkhIOFpU?=
 =?utf-8?B?MXdSMGtJaGxuYS8xSkpIRkFNQktVYWhHUTRDQ2svNkFNOVpvNm5iQ3VkM2RH?=
 =?utf-8?B?UmZXTzh5MUhrQTlMVFgwQXJCRGlWVi9CU3dtdG5zbEJGUE9yT0VKWUVubWxR?=
 =?utf-8?B?R2dONDBDejdCd0JvWlhJSHAyWVlMS1V6MDFzRUJ6ajlRVm53Tkk4NkE5amxR?=
 =?utf-8?B?ZjUvNlBJRmhLa3daY2VHdHhmZXFPcXVIMDhqT1YxcllhWCtoQzRtWlp5bWda?=
 =?utf-8?B?aVgwRVVjNndKQkVBVGJuMFl2a1gxYTVQMDBMY1BxRUUxUnEySVNUcTR2VWRn?=
 =?utf-8?B?QURSVHZYRk1PQnU3M3FzdW9ibUlXRWUvOWlma24yNWFHNGNiR1N1bTllVHBO?=
 =?utf-8?B?TjdVY2ZkcE5IMW5tcHB1ZU1Ca3NSS3lZS1g3d3dwQS9ndkE3bXdjZkN2Z09S?=
 =?utf-8?B?N0tZUEtGbTdtUEh5M0Z6disvcVV1bXc0dG9scGpZcUJqN2RCcU1GL0ZBYjZm?=
 =?utf-8?B?QTJWQmlpZExFSkFnODhESlVSdWVtaEpKeERmNFFHS2lYQi85RmZPOVFyd00y?=
 =?utf-8?B?QmpqWDVBMkdINUw0LzB2MHZ3OTk0dDZkVjRYOCtCdnd5VmR4bHRMOWdOSFFh?=
 =?utf-8?B?K2oyQ2lUdm9mZmE4V1BDTlQ0TWlqbkU2WEhoNFhZVkV1Z3dkdlBlNU5LUHNE?=
 =?utf-8?B?WWxMbFR5REpjMitqb2pqZnhta3dXTHdkNitZcTBDUTE2eGdkMjRUZ0YzRnlK?=
 =?utf-8?B?TXlDNFlvUzdMT3YrWWxnTkhQTVlHMHE1dEs3c1o1RFdNNlZFVHhDOU1KVFVh?=
 =?utf-8?B?UEw2eEJDNWs3NTRPTDRudWRWVUZWMlRxRkphZjVjTDlXRS83bXlaZElUd29o?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb392bb-6114-4828-6f02-08dddb60ae0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 18:30:44.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfm8bWs1WqonVdThJOK75dZMJbI2bwD5xLkQm1F2IZ8asFHpB4kw13HGUdy06AUd7SzPtVkdgz9qtUkTMOfBpGVHb8eAmshLtL6D4SlWRqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9421
X-OriginatorOrg: intel.com

--------------xpSmmnH9FrmiXISKsZ0j8Fzf
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/2025 1:55 PM, Dave Hansen wrote:
> 
> But that's not the problem. The issue is that this line of code:
> 
> #define cpu_primary_thread_mask cpu_none_mask

With CONFIG_SMP=n, on the core side (include/linux/cpu_smt.h), the code 
clarifies there is no SMT:

# define cpu_smt_control               (CPU_SMT_NOT_IMPLEMENTED)

This leads kernel/cpu.c to return an empty mask:

static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
{
	return cpu_none_mask;
}

On the x86 side, the definition is explicit that “primary threads” are 
SMT threads (arch/x86/kernel/smpboot.c):

/* CPUs which are the primary SMT threads */
struct cpumask __cpu_primary_thread_mask __read_mostly;

And via ifdeffery, this mask is only available to SMP kernels.

So it seems I had been subscribing this model -- no primary threads 
without SMP.

> reads as 100% bogus to me. Even on !SMP kernels,
> 'cpu_primary_thread_mask' should have one CPU in it. Right? The _one_
> thread that's present is a primary thread. If this were a mask for
> secondary threads, 'cpu_none_mask' would make sense. But it's not.

Your confidence made me take another look.

Digging into the history, I found that x86 used to have this in the !SMP 
case:

static inline bool topology_is_primary_thread(unsigned int cpu)
{
	return true;
}

That stayed until the recent commit 4b455f59945aa ("cpu/SMT: Provide a 
default topology_is_primary_thread()"), which now defines it in 
include/linux/topology.h with this telling comment:

/*
  * When disabling SMT, the primary thread of the SMT will remain
  * enabled/active. Architectures that have a special primary thread
  * (e.g. x86) need to override this function. ...
  */

This comment basically supports your point.

> So could we please make use 'cpu_primary_thread_mask' is getting defined
> correctly whether it's really getting compiled into the end image or not?

Given that, I’m thinking of simplifying the x86 side a bit -- by making 
the primary thread mask configured and available regardless of 
CONFIG_SMP, matching the behavior of other cpumasks. And its relevant 
helpers are also available, like in the attached diff.

I think the change still aligns x86 with the core code -- especially 
with the note in topology_is_primary_thread(). With that, the user may 
be introduced here.

--------------xpSmmnH9FrmiXISKsZ0j8Fzf
Content-Type: text/plain; charset="UTF-8"; name="tmp.diff"
Content-Disposition: attachment; filename="tmp.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmggYi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS90b3BvbG9neS5oCmluZGV4IDZjNzllZTdjMDk1Ny4uMjgxMjUyYWY2ZTlkIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90b3BvbG9neS5oCisrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RvcG9sb2d5LmgKQEAgLTIxOCw2ICsyMTgsMTIgQEAgc3RhdGljIGlubGlu
ZSB1bnNpZ25lZCBpbnQgdG9wb2xvZ3lfYW1kX25vZGVzX3Blcl9wa2codm9pZCkKIAlyZXR1cm4g
X19hbWRfbm9kZXNfcGVyX3BrZzsKIH0KIAorI2Vsc2UgLyogQ09ORklHX1NNUCAqLworc3RhdGlj
IGlubGluZSBpbnQgdG9wb2xvZ3lfcGh5c190b19sb2dpY2FsX3BrZyh1bnNpZ25lZCBpbnQgcGtn
KSB7IHJldHVybiAwOyB9CitzdGF0aWMgaW5saW5lIGludCB0b3BvbG9neV9tYXhfc210X3RocmVh
ZHModm9pZCkgeyByZXR1cm4gMTsgfQorc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgdG9wb2xv
Z3lfYW1kX25vZGVzX3Blcl9wa2codm9pZCkgeyByZXR1cm4gMTsgfQorI2VuZGlmIC8qICFDT05G
SUdfU01QICovCisKIGV4dGVybiBzdHJ1Y3QgY3B1bWFzayBfX2NwdV9wcmltYXJ5X3RocmVhZF9t
YXNrOwogI2RlZmluZSBjcHVfcHJpbWFyeV90aHJlYWRfbWFzayAoKGNvbnN0IHN0cnVjdCBjcHVt
YXNrICopJl9fY3B1X3ByaW1hcnlfdGhyZWFkX21hc2spCiAKQEAgLTIzMSwxMiArMjM3LDYgQEAg
c3RhdGljIGlubGluZSBib29sIHRvcG9sb2d5X2lzX3ByaW1hcnlfdGhyZWFkKHVuc2lnbmVkIGlu
dCBjcHUpCiB9CiAjZGVmaW5lIHRvcG9sb2d5X2lzX3ByaW1hcnlfdGhyZWFkIHRvcG9sb2d5X2lz
X3ByaW1hcnlfdGhyZWFkCiAKLSNlbHNlIC8qIENPTkZJR19TTVAgKi8KLXN0YXRpYyBpbmxpbmUg
aW50IHRvcG9sb2d5X3BoeXNfdG9fbG9naWNhbF9wa2codW5zaWduZWQgaW50IHBrZykgeyByZXR1
cm4gMDsgfQotc3RhdGljIGlubGluZSBpbnQgdG9wb2xvZ3lfbWF4X3NtdF90aHJlYWRzKHZvaWQp
IHsgcmV0dXJuIDE7IH0KLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHRvcG9sb2d5X2FtZF9u
b2Rlc19wZXJfcGtnKHZvaWQpIHsgcmV0dXJuIDE7IH0KLSNlbmRpZiAvKiAhQ09ORklHX1NNUCAq
LwotCiBzdGF0aWMgaW5saW5lIHZvaWQgYXJjaF9maXhfcGh5c19wYWNrYWdlX2lkKGludCBudW0s
IHUzMiBzbG90KQogewogfQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9n
eS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jCmluZGV4IGUzNWNjZGM4NDkxMC4u
OTQ2MDA0ZDdkZDFkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L3RvcG9sb2d5LmMK
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS90b3BvbG9neS5jCkBAIC01Miw2ICs1Miw5IEBAIHUz
MiBjcHVpZF90b19hcGljaWRbXSBfX3JvX2FmdGVyX2luaXQgPSB7IFswIC4uLiBOUl9DUFVTIC0g
MV0gPSBCQURfQVBJQ0lELCB9OwogLyogQml0bWFwcyB0byBtYXJrIHJlZ2lzdGVyZWQgQVBJQ3Mg
YXQgZWFjaCB0b3BvbG9neSBkb21haW4gKi8KIHN0YXRpYyBzdHJ1Y3QgeyBERUNMQVJFX0JJVE1B
UChtYXAsIE1BWF9MT0NBTF9BUElDKTsgfSBhcGljX21hcHNbVE9QT19NQVhfRE9NQUlOXSBfX3Jv
X2FmdGVyX2luaXQ7CiAKKy8qIENQVXMgd2hpY2ggYXJlIHRoZSBwcmltYXJ5IFNNVCB0aHJlYWRz
ICovCitzdHJ1Y3QgY3B1bWFzayBfX2NwdV9wcmltYXJ5X3RocmVhZF9tYXNrIF9fcmVhZF9tb3N0
bHk7CisKIC8qCiAgKiBLZWVwIHRyYWNrIG9mIGFzc2lnbmVkLCBkaXNhYmxlZCBhbmQgcmVqZWN0
ZWQgQ1BVcy4gUHJlc2VudCBhc3NpZ25lZAogICogd2l0aCAxIGFzIENQVSAjMCBpcyByZXNlcnZl
ZCBmb3IgdGhlIGJvb3QgQ1BVLgpAQCAtNzUsMTUgKzc4LDExIEBAIGJvb2wgYXJjaF9tYXRjaF9j
cHVfcGh5c19pZChpbnQgY3B1LCB1NjQgcGh5c19pZCkKIAlyZXR1cm4gcGh5c19pZCA9PSAodTY0
KWNwdWlkX3RvX2FwaWNpZFtjcHVdOwogfQogCi0jaWZkZWYgQ09ORklHX1NNUAogc3RhdGljIHZv
aWQgY3B1X21hcmtfcHJpbWFyeV90aHJlYWQodW5zaWduZWQgaW50IGNwdSwgdW5zaWduZWQgaW50
IGFwaWNpZCkKIHsKIAlpZiAoIShhcGljaWQgJiAoX19tYXhfdGhyZWFkc19wZXJfY29yZSAtIDEp
KSkKIAkJY3B1bWFza19zZXRfY3B1KGNwdSwgJl9fY3B1X3ByaW1hcnlfdGhyZWFkX21hc2spOwog
fQotI2Vsc2UKLXN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfbWFya19wcmltYXJ5X3RocmVhZCh1bnNp
Z25lZCBpbnQgY3B1LCB1bnNpZ25lZCBpbnQgYXBpY2lkKSB7IH0KLSNlbmRpZgogCiAvKgogICog
Q29udmVydCB0aGUgQVBJQyBJRCB0byBhIGRvbWFpbiBsZXZlbCBJRCBieSBtYXNraW5nIG91dCB0
aGUgbG93IGJpdHMKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9zbXBib290LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvc21wYm9vdC5jCmluZGV4IDMzZTE2NmY2YWIxMi4uNzgwNDE3NWQyZDg3IDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvc21wYm9vdC5jCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9zbXBib290LmMKQEAgLTEwMyw5ICsxMDMsNiBAQCBFWFBPUlRfUEVSX0NQVV9TWU1CT0woY3B1
X2NvcmVfbWFwKTsKIERFRklORV9QRVJfQ1BVX1JFQURfTU9TVExZKGNwdW1hc2tfdmFyX3QsIGNw
dV9kaWVfbWFwKTsKIEVYUE9SVF9QRVJfQ1BVX1NZTUJPTChjcHVfZGllX21hcCk7CiAKLS8qIENQ
VXMgd2hpY2ggYXJlIHRoZSBwcmltYXJ5IFNNVCB0aHJlYWRzICovCi1zdHJ1Y3QgY3B1bWFzayBf
X2NwdV9wcmltYXJ5X3RocmVhZF9tYXNrIF9fcmVhZF9tb3N0bHk7Ci0KIC8qIFJlcHJlc2VudGlu
ZyBDUFVzIGZvciB3aGljaCBzaWJsaW5nIG1hcHMgY2FuIGJlIGNvbXB1dGVkICovCiBzdGF0aWMg
Y3B1bWFza192YXJfdCBjcHVfc2libGluZ19zZXR1cF9tYXNrOwogCg==

--------------xpSmmnH9FrmiXISKsZ0j8Fzf--

