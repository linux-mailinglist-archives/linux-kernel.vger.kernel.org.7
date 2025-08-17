Return-Path: <linux-kernel+bounces-772416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DABB29257
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 10:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA46D1B21738
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453D221B9C0;
	Sun, 17 Aug 2025 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzG2nBF2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702EF1991C9
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420671; cv=fail; b=EZQLNX8NHueDGR2Ot0norAsOZW4I/g0s+YE0oWoeGwuui4tFiCxclswvSM/oJbJSBsfr8ZXl4B/8t9CHRcZpWB0rKqIUkLv/M8E2mktb9U1cbPl2ezVJDMrkv6iir+2f6X6/9BmZ57E9ZVSuWL8JyZRojR0bbi9bNiPDvFv4sXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420671; c=relaxed/simple;
	bh=8JMQwzQYfQsVgdIlC47zPjepi9bZ3Mb1EP+cjNVctGc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Th1VaI5kasBSFYKc0ZqqrzdFlYbtf/zYXPQUfziCmvqfRlAXbG/1WPQ80CrNp/BsKF3xUEyc4jQXaiP0e0ohVeg2n3J9f0NhbWUxEXm/Wn+6xQCnNfZ7IKUpFf3mkUNhZjyKHMMYyiIzd6FVCWedhKR4kFkmBsvJUGecCn4+uvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzG2nBF2; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755420666; x=1786956666;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8JMQwzQYfQsVgdIlC47zPjepi9bZ3Mb1EP+cjNVctGc=;
  b=KzG2nBF2vMqIg51JdLw54JBLr667oPbn+NsPp5bohPfnUWkJTNXN2gxx
   1cUvrGmE3L9+VKG3oHbuA1muCAYQJVYTkw6WrTG8jfYy2/q7+KbzUXwI2
   jrFaknfa/l4sHPi1VIAgZeoeK65j1PpHxj7K1Rdq2oFfgQwn84NyCJMZo
   vDT+VFHqjx/7R073qWTWpS8EOiIIQjjmcjjURujYvdulcdrTKtD/5eSw+
   8cI0I4kLf8d0sFJj9l0F1/0U3NotYx35BYZ4cwlKT3s9uQ+qRDjW8NFUx
   h6dePYBYkXLZjOQbvG/tXCKzGQF3znya5b/XT57fV50QyWATuPhdpX/Lx
   Q==;
X-CSE-ConnectionGUID: +J4IC6FiQZi9Y82RDdOyzA==
X-CSE-MsgGUID: NYoM16iAQDCkDoOfsJmRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57602831"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57602831"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 01:51:05 -0700
X-CSE-ConnectionGUID: enLqeaoGSs6mrRqvDuo1WA==
X-CSE-MsgGUID: cTZu0ML/Q+KZoE0S9AN8+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="168150927"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2025 01:51:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 01:51:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 17 Aug 2025 01:51:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 17 Aug 2025 01:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxG8mNlLYDar+K21QQfrGKVkVHc3tBUaVJ32hiix3zeMMGdipvBqLMCFBE9bKIFk7WVCy+8o/pyi/c/EKtb+OvoYBu6CzvWftvKF+hts9eusUyalJE+S/t6VECA6r2g87BcpSydCPE9SmVwVMAg5mTwK8sGjUR+SbrzST7A98mqz64pGsswtVuZUt9RfK6aSa93ZlU1VVbGcFD74r39gaatavt7UszkISj0hX+MKYmI1U3staQYXuieE1WqgvF42/jX10U/TcjXYMt6uS66liF3ocGkOYcwSs8QkDMa8ruYLwl/yZtEdDUyrKQNB89yCoHo5/H6k1EtIsdVyGHVBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2eVOJI3o1Vl7LwsUy0iqCIpaoWA6SwHejeQNRaZHGI=;
 b=CXtyiBFVxMj1T9Y5v1Qx7t6Lq6544wu+V2i0iPE2lGJhr9ijrB4H1m73pzqvlTwT+AT5hNd0zLgQi/hlcuLWbRldz0aT+C4dgLn4BI36/dZY0sg33rCih9coONWUwEG/bRF4BreB1Ue7GC9Mtdk+aX+oivMaVreVRa7vClxndrUdaB7C4jeGGRfsjf3HJGxe7HfPEFyqeibi31oP0beBU+md/DFqxKAH2T9CYF60qleGUOwYD0Fc0Kw5mADja53ncqa1ABzW3MmsRqdY1yZ9ZCnpU+usVMYUL8ouNYkd4UuR4Y3yex1qerUIdi7rpWjGb4IxNPwvk0m2Ugp5z4Ty3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.13; Sun, 17 Aug 2025 08:51:02 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 08:51:02 +0000
Message-ID: <4efdc1a8-b624-4857-93cb-c40da6252983@intel.com>
Date: Sun, 17 Aug 2025 16:50:50 +0800
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
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250715071658.267-4-ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cc40ae-5ff9-4596-d61b-08dddd6b31e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTZ1cTYvanZiVWJlTWVIMEw5eTlwbXpKTDF4dEV4YkZCMHlXSHZBbEg1SlpV?=
 =?utf-8?B?QTFPODhjTG1IWlZabHZYZTI1L1RWa2k4OGNXc1ZSdW53a0ZHL0poYWVwQWRZ?=
 =?utf-8?B?V1MyZE9DZlpuV2JLSW9ndUtvZFdLMU5NZUs3SUZQQzZtMS9rQlc3amVKUlVS?=
 =?utf-8?B?eVZXMVBoTG1LWWhSWjIyODVNam9abFBqQVdkZXFvZTluQURHczBkbWxvSENh?=
 =?utf-8?B?VDJCYlppSDdYa2JtNU8yTjlxQ3BpbkEybUtGK2YyTzlVdGx6QktvYmtvcWRt?=
 =?utf-8?B?amk0aVVKOFVnc0lrbnpTazV2VHY2RFRtazg3dlZnME5kUmNJZzZFV2tSOEow?=
 =?utf-8?B?Um9JdEtZS3BNbWV3OUUxYWJkNlpRRU1KSnJ0cGR2QnY1U1A1eGtEM2lvaXN3?=
 =?utf-8?B?Y29LSDIxSVdmTFM3K0VoblJxOW1VckdtbmRZZmtxMEd4TnhpUTkzYTVnelJK?=
 =?utf-8?B?RHoyZjRjZVBrWkhhVVRZY1d3QjZMY09KdCs0d0xsam0wcTdaTlhJOUt6T0FC?=
 =?utf-8?B?U0VYSy9YM3lMMmVhMVZ0S2FCRUdUVjlHQUxqbTBWQkxKOTcvTlo2azVXSG9s?=
 =?utf-8?B?OWpvOW1idk13SVZDQ0hGYXc0Tno3TlhpdXNCRU5KL0tWL29TZTBqNWx0QkJo?=
 =?utf-8?B?UjJCT3J4MktpZmRYc1dqN1hKUlpWT1VCU2dyL2FCOWpQV2JHRFBwVjZ4YU14?=
 =?utf-8?B?QUNWZjRJYlJZc0JmQXorTjZyU3ZFRHJ5Z2g5bTVpL21vdW1tUlg0MHhXbHZX?=
 =?utf-8?B?MVNBUXNjRHF0YXd5dUxVRXFCb0lCNDdWTVM0dDNVNmpLUTJQOE1SeW16czZh?=
 =?utf-8?B?Yk0yczVNZDVEZVRYY0t4WlZWbW1VUjF1UGUyOHlXR2hteFd1QlovMW5nOHZ2?=
 =?utf-8?B?VFRqd1hIS2Q2UXRPRTRMVXFOcHZYUzNuSjhNUU9KYnJTaEFQWHU3SFNUdXM1?=
 =?utf-8?B?eEREMG42TWc0djU5bm80aUMxV25ab3VwWjl6TFVvN1dPazRKU0V6VGxkaWt4?=
 =?utf-8?B?eTBsKzhLTGV5Q2xkc0RxZ1dxRHNzMEdFL0tqT3QrMUVnbjNWOGpHeWpIK09v?=
 =?utf-8?B?ZjQ1UENjVUhiWmxLWk9rcnpjekJCM1IxME5vNlJLVzFCb3NDakhuQkpvdlZx?=
 =?utf-8?B?MTQyMHUxaGNwMkMyN1FoNnRNSEYwYTNEazdTU2R4LzRiMUYyK1VBOGRRQUFB?=
 =?utf-8?B?T2xlSXQ0OEU2RmYzbXBzeXFFWDBTUU5POWJHL096SnF4bzFHS3hqcnUwWEpY?=
 =?utf-8?B?dlNaZHA4N2FUdU9tN0Q5ZXlHSnZVQTRVTmhSQlhUQVVlbGp5VmlGbzVKTnBU?=
 =?utf-8?B?d0YxSnI4Q2ZNdkU2bGpRZFlreGY2TlZiWkgwVUpQclhOK3hvS3NiYVpPckZM?=
 =?utf-8?B?aWwxS01TU09uTDZuelQ4YUxVQUFRL205RmZoREVtQmtFbWp1Q0p0UjVEYy96?=
 =?utf-8?B?dmhjaEtvaDVCbVlaUHoydURVR1FieW1NZ0d0SnZaRUN3YkdwU0lvSHNBcnRu?=
 =?utf-8?B?ZkFwbWw1dlZLNGxYVEJjOGRWekpRV2hIQzJPR3JpMDFpd1VKZm84cWVIa0ov?=
 =?utf-8?B?c0ZTWnBxVEl3RS9UKytudWpMK0dHR2dHdlFnaC9BOWhnVGJoajZlQklhZHE4?=
 =?utf-8?B?OUpWd1p3cWlkWUhaa3phRjVad1o3QklMUWh3Q2JkbGZiTjV6ZXBmOHFnUUV2?=
 =?utf-8?B?bDYvTWI3Z3FSWVk3NU5BN0VaZHJScURsNG5iNEZ5N2Q3YjRrUE1OdS9XWXlW?=
 =?utf-8?B?V3FlQVVJSEdlZEFjV2s2azBKK2ZzYi9qcFFKSk42QWg1NzdiTE1Tb1VGeHlN?=
 =?utf-8?B?dEJmTThmTWhYWjZrekE1TE1TODJ0b0p4WHd6aTFEZExnbUhzeVFBSHowS1hX?=
 =?utf-8?B?WEQyZndZS2pEYjU1N2p3T1lTY213Y1paZWpMY1Yyc2Q5TjV0UVlVK3gvU1Bv?=
 =?utf-8?Q?kAc6YOBTqdo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STYrdVRJYldxaktRQmlGUVNoMmlVRVlkaVYzMUxQdEdZUE9MVUhheGUvVkJI?=
 =?utf-8?B?Y2JGTzlsd0lXcTVOQVJ0LzI1ekZRQmd3eVZXSXM4eE9BSVNQS3NSbWt0RFhy?=
 =?utf-8?B?RXpkUEhFTEFmcDlZUEFLSmQ0SjU3eVExdHNVbzJGMXRZWjVJbCtKcktUK0VL?=
 =?utf-8?B?MlcxangvZzJjOFlqbmRjVnFMWjVGOTJVUXl2NnU5NlM3cU9yS3Iyb2VSdGlN?=
 =?utf-8?B?VWdtZ3l3cU5ZVDkrSjNYcVVzaWludFlCcUxBak5UUzRYTjBpb0prVjR3M1BC?=
 =?utf-8?B?dEVNaHdrNTJjRkk3V2t2M29Nd1hDL1F0ZC8zV2FXVlpkVEUyMHlyakFGa3hm?=
 =?utf-8?B?UFhORHlOajBqdGpFd0doWUt3TU5JSnNQQlYySm41azR1aWRpTGZoeGF0MlIr?=
 =?utf-8?B?VGhlanpsTkI3alZrcG9QZDc3OTJxY1RiWitycmc4VlJ3RWE3MFJ1bkJnZ3pQ?=
 =?utf-8?B?NzVTdkg5YWlONGY5aWtOMzlkaEVkcWticjVBUW9TaXZPeDBmUEsxUHV2cEU4?=
 =?utf-8?B?by9pUkNkNWY1R3kwa3FNYmJnN0E4ZHQ0cEVqRkNuTWJ3NXRzUUk2SFprSFgz?=
 =?utf-8?B?dEdHMURuUG1uT1JqaUx1SFBuM1BYbDlYL0dWd0VJamFINk5EZnBOZzFFSWEz?=
 =?utf-8?B?ZXZEL2p1M0N4SzFPODRFWERkWnRRTm5BRTRBYUVsbmVuVGZKRVdXdTFyZSsy?=
 =?utf-8?B?dUdWRkZRcWxMN3N2RnY4VWVDSVY3NnRvcHorTTRvMXpyK01zTE5lUjV4TCtM?=
 =?utf-8?B?WG9pV0FKYjROY1JaZXg5STZoOEExSmhTQ3luSG5RbjN2R3hkaGMvVkZTWjMr?=
 =?utf-8?B?amR3ZGIrbnIyUGxaUnlRem9VNEtUSzNaYU5meTNFN2xTOUYzWnJETVFIRnVY?=
 =?utf-8?B?dDY3MG40anZHNU50S0huR21jZEFoL1ptSUxEcUJwZzhyUnU3a04vbW1YVkth?=
 =?utf-8?B?L2p3dkNRUUZyWE9RK0pvTFhZRWNtSGFQRWxDOTg0QUYzRDZiS1hkQjcxTEZW?=
 =?utf-8?B?a3F4RndFeDNWcWFsTy9aRVYyNmR3OXZOV3M2NlNLWXVhSXlYRVIrVGl3N1Zm?=
 =?utf-8?B?UkY3aCt2dDdPVmZPRVd0MkdLQW1SaEYwMVZrSjk3R1Z1N3VtMWlpdFVoaWRn?=
 =?utf-8?B?a1kwUHlOVThDWGRQU1dFWk5KT29nRjhDdzYxQ1oyV1lZQkF6TmZhTWw1cFFk?=
 =?utf-8?B?VDhxUS80WGpmb2w3UVpsM2x1MmdWWmcvY1Bhd21MNUpoZXc2dktQazBwZzdW?=
 =?utf-8?B?VVpCUDBLbkpUQ2R1REpqNWhzL3VhelVKUUh4S0pxQU84T2tGVjdqYmJpR0VH?=
 =?utf-8?B?SzNBMWZFY2kyNXA0VEJYLzZCSlUrYUFFYlQyM1hNOHFxZEdQSEg4a2h0SUVx?=
 =?utf-8?B?NHVxK2g3eXpBcDZzclpWOU5TWEdzcUhEbDBCRTdPSnFyUzlaUkpBYUw3dklT?=
 =?utf-8?B?dGtNNkpkT0xWWmVGNHRwQStxMkk2Mk43Zm9xR01sNS8rM256SXh6YzZWakgy?=
 =?utf-8?B?dmg3MHJwSklXRU9QMmh5RjNaWDZWSytwNXZPdEQ0R0NudnFlNGt6TkwwMDVF?=
 =?utf-8?B?RTRXOUIvQm41Z240UThFTzdXVDl4R054TDA4dlpyUGhDNUJrLzU3NXh4Um5N?=
 =?utf-8?B?WFpoekN1ZDlxcmRmWXlwd25WcW1zMEF4bHpSdXRHREJmbjIyazVFcW1ydUxD?=
 =?utf-8?B?VUh6NTdUS3RxeU9iSTZidVI5Qk11ejRoam9jMXBoSUZCby8zTEFyVEt0dFpN?=
 =?utf-8?B?Uy8xaFowb0V1Ny9tLzhtdVBWZG5nM3BhS2UyRU5HUXYrcWhMSkUwY0FJUEFH?=
 =?utf-8?B?K3pTWXpaUEE5VVpuTEV3azlJUFZ2SFc5ZXBKTzhXWHFVWm1hREdGdXRUTVR0?=
 =?utf-8?B?c1dpYVBIRFYrbW9LOEpOa0FJdGNtdG9tWGhPOW82WEwwemF2Ym1LTHdYcXRj?=
 =?utf-8?B?OUlNV1RNRkFsdlRuZlphUllMaE5HOXJ0NEpPeEpmUHp0QXFhbEFHdkFmR1RH?=
 =?utf-8?B?TTM2TVFrdm5HcUIxUzAxbDdGOSswQ1lzSG9ocklTV1U3OTJZTlRRL0wxMkFR?=
 =?utf-8?B?TnRKMGlna1Q5ZTBnTWxycnd4ZU5XYkgraGc1azdkMTZ3UThiN2ZxKzRTVXVE?=
 =?utf-8?Q?JCZTgvByWpzXQKvJaiqRDKpl6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cc40ae-5ff9-4596-d61b-08dddd6b31e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 08:51:02.6231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3jldGlaz9lmYruWMVJQoMSdvLJ0v3IWfH9X5CdhFXjXqBOHSsHGUcMFQsqVV4SIZYn65Rl02lF17OT0sAzj+qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

On 7/15/2025 3:16 PM, Aaron Lu wrote:
> From: Valentin Schneider <vschneid@redhat.com>
> 
> In current throttle model, when a cfs_rq is throttled, its entity will
> be dequeued from cpu's rq, making tasks attached to it not able to run,
> thus achiveing the throttle target.
> 
> This has a drawback though: assume a task is a reader of percpu_rwsem
> and is waiting. When it gets woken, it can not run till its task group's
> next period comes, which can be a relatively long time. Waiting writer
> will have to wait longer due to this and it also makes further reader
> build up and eventually trigger task hung.
> 
> To improve this situation, change the throttle model to task based, i.e.
> when a cfs_rq is throttled, record its throttled status but do not remove
> it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> they get picked, add a task work to them so that when they return
> to user, they can be dequeued there. In this way, tasks throttled will
> not hold any kernel resources. And on unthrottle, enqueue back those
> tasks so they can continue to run.
> 
> Throttled cfs_rq's PELT clock is handled differently now: previously the
> cfs_rq's PELT clock is stopped once it entered throttled state but since
> now tasks(in kernel mode) can continue to run, change the behaviour to
> stop PELT clock only when the throttled cfs_rq has no tasks left.
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # tag on pick
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---

[snip]


> @@ -8813,19 +8815,22 @@ static struct task_struct *pick_task_fair(struct rq *rq)
>   {
>   	struct sched_entity *se;
>   	struct cfs_rq *cfs_rq;
> +	struct task_struct *p;
> +	bool throttled;
>   
>   again:
>   	cfs_rq = &rq->cfs;
>   	if (!cfs_rq->nr_queued)
>   		return NULL;
>   
> +	throttled = false;
> +
>   	do {
>   		/* Might not have done put_prev_entity() */
>   		if (cfs_rq->curr && cfs_rq->curr->on_rq)
>   			update_curr(cfs_rq);
>   
> -		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
> -			goto again;
> +		throttled |= check_cfs_rq_runtime(cfs_rq);
>   
>   		se = pick_next_entity(rq, cfs_rq);
>   		if (!se)
> @@ -8833,7 +8838,10 @@ static struct task_struct *pick_task_fair(struct rq *rq)
>   		cfs_rq = group_cfs_rq(se);
>   	} while (cfs_rq);
>   
> -	return task_of(se);
> +	p = task_of(se);
> +	if (unlikely(throttled))
> +		task_throttle_setup_work(p);
> +	return p;
>   }
>   

Previously, I was wondering if the above change might impact
wakeup latency in some corner cases: If there are many tasks
enqueued on a throttled cfs_rq, the above pick-up mechanism
might return an invalid p repeatedly (where p is dequeued,
and a reschedule is triggered in throttle_cfs_rq_work() to
pick the next p; then the new p is found again on a throttled
cfs_rq). Before the above change, the entire cfs_rq's corresponding
sched_entity was dequeued in throttle_cfs_rq(): se = cfs_rq->tg->se(cpu)

So I did some tests for this scenario on a Xeon with 6 NUMA nodes and
384 CPUs. I created 10 levels of cgroups and ran schbench on the leaf
cgroup. The results show that there is not much impact in terms of
wakeup latency (considering the standard deviation). Based on the data
and my understanding, for this series,

Tested-by: Chen Yu <yu.c.chen@intel.com>


Tested script parameters are borrowed from the previous attached ones:
#!/bin/bash

if [ $# -ne 1 ]; then
         echo "please provide cgroup level"
         exit
fi

N=$1
current_path="/sys/fs/cgroup"

for ((i=1; i<=N; i++)); do
         new_dir="${current_path}/${i}"
         mkdir -p "$new_dir"
         if [ "$i" -ne "$N" ]; then
                 echo '+cpu +memory +pids' > 
${new_dir}/cgroup.subtree_control
         fi
         current_path="$new_dir"
done

echo "current_path:${current_path}"
echo "1600000 100000" > ${current_path}/cpu.max
echo "34G" > ${current_path}/memory.max

echo $$ > ${current_path}/cgroup.procs
#./run-mmtests.sh --no-monitor --config config-schbench baseline
./run-mmtests.sh --no-monitor --config config-schbench sch_throt


pids=$(cat "${current_path}/cgroup.procs")
for pid in $pids; do
         echo $pid > "/sys/fs/cgroup/cgroup.procs" 2>/dev/null
done
for ((i=N; i>=1; i--)); do
         rmdir ${current_path}
         current_path=$(dirname "$current_path")
done


Results:

schbench thread = 1
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
//the baseline's std% is 35%, the change should not be a problem
Wakeup Latencies 99.0th        15.00(5.29)          17.00(1.00) 
-13.33%
Request Latencies 99.0th       3830.67(33.31)       3854.67(25.72) 
-0.63%
RPS 50.0th                     1598.00(4.00)        1606.00(4.00) 
+0.50%
Average RPS                    1597.77(5.13)        1606.11(4.75) 
+0.52%

schbench thread = 2
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        18.33(0.58)          18.67(0.58) 
-1.85%
Request Latencies 99.0th       3868.00(49.96)       3854.67(44.06) 
+0.34%
RPS 50.0th                     3185.33(4.62)        3204.00(8.00) 
+0.59%
Average RPS                    3186.49(2.70)        3204.21(11.25) 
+0.56%

schbench thread = 4
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        19.33(1.15)          19.33(0.58) 
0.00%
Request Latencies 99.0th       35690.67(517.31)     35946.67(517.31) 
-0.72%
RPS 50.0th                     4418.67(18.48)       4434.67(9.24) 
+0.36%
Average RPS                    4414.38(16.94)       4436.02(8.77) 
+0.49%

schbench thread = 8
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        22.67(0.58)          22.33(0.58) 
+1.50%
Request Latencies 99.0th       73002.67(147.80)     72661.33(147.80) 
+0.47%
RPS 50.0th                     4376.00(16.00)       4392.00(0.00) 
+0.37%
Average RPS                    4373.89(15.04)       4393.88(6.22) 
+0.46%

schbench thread = 16
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        29.00(2.65)          29.00(3.61) 
0.00%
Request Latencies 99.0th       88704.00(0.00)       88704.00(0.00) 
0.00%
RPS 50.0th                     4274.67(24.44)       4290.67(9.24) 
+0.37%
Average RPS                    4277.27(24.80)       4287.97(9.80) 
+0.25%

schbench thread = 32
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        100.00(22.61)        82.00(16.46) 
+18.00%
Request Latencies 99.0th       100138.67(295.60)    100053.33(147.80) 
+0.09%
RPS 50.0th                     3942.67(20.13)       3916.00(42.33) 
-0.68%
Average RPS                    3919.39(19.01)       3892.39(42.26) 
-0.69%

schbench thread = 63
Metric                         Base (mean±std)      Compare (mean±std) 
Change
-------------------------------------------------------------------------------------
Wakeup Latencies 99.0th        94848.00(0.00)       94336.00(0.00) 
+0.54%
//the baseline's std% is 19%, the change should not be a problem
Request Latencies 99.0th       264618.67(51582.78)  298154.67(591.21) 
-12.67%
RPS 50.0th                     2641.33(4.62)        2628.00(8.00) 
-0.50%
Average RPS                    2659.49(8.88)        2636.17(7.58) 
-0.88%

thanks,
Chenyu



