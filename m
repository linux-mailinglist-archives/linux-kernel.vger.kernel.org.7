Return-Path: <linux-kernel+bounces-840249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DDBB3EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B42419C369B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2375A31079C;
	Thu,  2 Oct 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+/qbiL1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA32ECD01
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409514; cv=fail; b=XVWmIgaD1+xT0czhLHLXSY3Da/YBmEchryD1MMK2swBvaAV8HNMISJU91Kc7zBx7FT/dDWGorWuXTcUUbB6P8f8ldbSM+NC8dtTWaJETpBtZOXS7xQ4He/CWqM7uE4+qJBCbV8SWEEdG0+ifDta3pXpHyeJP+4nIG/RREbHLFVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409514; c=relaxed/simple;
	bh=6XZm/qQJLcmolG3KSscHBQUWzKtiY8/06HLQfbnShVY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X4+jP+XbqVQT4Eep2+omDz6RJ89wGv9TLPluoP4ERSHQkG1pE7Mp+RO61N1/P0mz0vG/bWD2xhm0eX1G8a68YL6mPZGMizAwsyH6Qt9/O1++5ZIDIbmmtfA0xSKnK2NJ51KALu9rOzTK9KIM06zXIoDADtTTjqJG7VTRUw2/V6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b+/qbiL1; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759409513; x=1790945513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6XZm/qQJLcmolG3KSscHBQUWzKtiY8/06HLQfbnShVY=;
  b=b+/qbiL1v7CB76yrPBcNFGYChEQ0ucQDiAfsKSiHoQo6x9h1vDi8fnVV
   /WIvEG1n+ZF11nkaVuuPSImLrMloSWD+TgEsxOzWBVZ11pTjtiBy3hMG9
   eQvY++4WdQu8spE47SjxXz0v7Mi+xM3LrGt9YCbyhIYSDCos1Lt80gVSA
   sdfwM1z28fULypXqLGoGWDShf87atw/2CP7mVa7AD55iorT5LqxTWvszw
   R7qdPcDljrf1URUipufy+jqR964o3Hc+725ArpSOjzq2Ebh75ZKKMwTHF
   r5URM4JL8sJpjBxr8kpjnoiOeYPOTVmH4grScb5/TvVMLHKWqXnWOXMvM
   A==;
X-CSE-ConnectionGUID: TiuWe0OOTFWDbN2hSo24Ig==
X-CSE-MsgGUID: KX+V1mFZSwC/+VFoU1osXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61792848"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="61792848"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:51:52 -0700
X-CSE-ConnectionGUID: FM9VheP9SOW666WI2eJ15w==
X-CSE-MsgGUID: KImMtWHNQFmI8O25/3ys6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178987075"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 05:51:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 05:51:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 2 Oct 2025 05:51:51 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 2 Oct 2025 05:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DC4lEWGKjGy7n4pxMCI0SnKWtME9YcQG63KXa0KWLRZOoI9johlCGLlq8s12+tw7TyhyD2gBrB+EV3CMy1Sdan7E4WhMiJko0GKvIEokz+ipwZV8DvfS+LSn3AV/2VxNyLGJXVFxZY2A4mUR1uoCoKEC5Ynr6pRde0rHT7CEZNt3rpHwQ1bJQkSrpfBMXpcnQVPAaDFWMOG5Nh9wAanVBR7hhhdBrCrq/zoEqxjN7DbDVR24X7nAzqy9fteOwnmhKE2Pfu9bExj9sSRoEUZ6RyTMSBymN/hmmw2cbIQsz1nPn08NUafoZwSxwBVku7Pej98efZTNaQ1G/eGUaW1TeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSFN8coY3e5xKYqmrgphNCSNWmedRDWR+6gBbmr0Wv0=;
 b=QeUMZFgRo0S5ll5+1sDQF7SplKponNAHf+9oNhj9MQgAXPO7ehfglPn06cFdxmB3M+bTvMUoe5uWRJFzSFjQjjzXQp139376+RdZZGrHS/59iCCoNvpjxZGoB+DMpl40UdGXe51DBettZ+Yq+6xgAXx+LxheWRwL0gxXxDQagHETKLiYHfQTqtzlDK5NyLsdWzJR0Ub/M+4UUG7IpSSEvuasSTvCE/JdLRLQnsULCEJHH5K1XfptUXiVRNMZkqNFi/6cSmt8ETk22SqIQY+kr7y0iFOS2PtNz4iMZS3hvH62muR9zg1r3XS4xrf5Yq5o4W9pd+eeei6+xI0CYZfFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA4PR11MB9347.namprd11.prod.outlook.com (2603:10b6:208:565::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 12:51:49 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 12:51:49 +0000
Message-ID: <10d84ae7-4c33-4f58-80bb-612221d24ec2@intel.com>
Date: Thu, 2 Oct 2025 20:51:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/28] sched: Add helper function to decide whether
 to allow cache aware scheduling
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Libo Chen <libo.chen@oracle.com>, "Madadi
 Vineeth Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, Jianyong Wu
	<jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>, Tingyin Duan
	<tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>, Len Brown
	<len.brown@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, <linux-kernel@vger.kernel.org>
References: <cover.1754712565.git.tim.c.chen@linux.intel.com>
 <701c7be7f0e69582d9ad0c25025ec2e133e73fbb.1754712565.git.tim.c.chen@linux.intel.com>
 <20251001131715.GO4067720@noisy.programming.kicks-ass.net>
 <89c777b7-33bd-400d-8b6f-4e6d697dc632@intel.com>
 <20251002115034.GS3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251002115034.GS3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0058.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::9)
 To DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA4PR11MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: 535ce9f0-63d7-409d-59ce-08de01b2737e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTE2UitUQzR5Y3krK3pVamNKa0VMYUt0dm1yNUE5bEdWU3hRUTZSdDB0RFZp?=
 =?utf-8?B?aHAvUThBdEQ4Z2JxSE9XeHhYaWtNV0ZRWHlaaE96aXJ0bGFzU1J1b3pNYmNZ?=
 =?utf-8?B?Nnd0VHdwb3ZhZlZubkNqMjFRWEFzVmJLYnZaNHlFWXJjcThPUFRTMmlueUc2?=
 =?utf-8?B?dHduMGk5U3pqSTNCVDhOOHZ0Tk1TTnJZeE5McTJodUdLOFVKUk5KNWZ5SStx?=
 =?utf-8?B?a2xuNkozYzRwTWZKUFcrQVA0bURQa285QUxWOTBPaHFVT1lSWk1wN3htMFlM?=
 =?utf-8?B?MkZCU2lWNjJnTXdwalZOQU5ubWU4S0YraWtwWDZvZnZ0SXQ2STNMV09GcUdj?=
 =?utf-8?B?T0k1T2lWZnhqNEZ5dHJwOElpUGxvNFcxQnhTakxiTGswd2NGZlMzM29vd3RZ?=
 =?utf-8?B?Sit6RDhLUmNuQkZTWk9uUWpOcUxUd0JlYjgzWis5bDloREdTQVVCd1BpWDYy?=
 =?utf-8?B?VVlPUGJtY3BaOTQvcjV3Sysyb1VhZ1BpVGFuY25ERFpraHF5V0VzcGJjNStG?=
 =?utf-8?B?Rk9RUk5pZGNzRkNlMFNkVy93d0sybnlmbHFwSkFMblc3dXlQMEJ0ZEF4Q0tj?=
 =?utf-8?B?R2dhV1IxcmNmTWlKd2xHc1MvUWNUOU5qbnlBajVqWm84WUNWV1ZaVlM1ZDVr?=
 =?utf-8?B?YkZaRXhWd2ZKQ1FnMCtNbUFVSXpoVFJrVVRFOHdHTXlXWXJKK1hqaitXK3Bo?=
 =?utf-8?B?UjRRWWRSWDhkTXI5cS8reGhURC96b1lyTU9Gayt0UllRa1NzT3ovZklibC9Y?=
 =?utf-8?B?MFYvWDRWaXFMSUx2N215VGw3WWRsZU1NNjFZa0g0S1JnbHhCTTczaGV6bGZv?=
 =?utf-8?B?aldWUmwrUW1DZndEdndwZWcxek1mNXhJSDI0c2VMUU5BbWVCbWx0c01RRnRw?=
 =?utf-8?B?eDBReXNibjFCNHNNOG1rVkExSWZHbWZJY3hDQXVFOXIvUFdlOG9NZzVQUGxy?=
 =?utf-8?B?QU5BeDlWTE9PcW5kMFBFZklSS2Q1V2hxMTV6M1JnbWVTRGVBQi80bzQvL2U0?=
 =?utf-8?B?NVZ4UlNZV2VodE92TGJKaW41cGJLL2JPaitoakwzN2ZhdFg1TFBnZHIyaE1B?=
 =?utf-8?B?VlNqdW1PU3oxdzBKNjE4Y3lHVlZTcG5zYmVPNDF1em4vR3VtTDkyVzFpTnRX?=
 =?utf-8?B?cVJvQjBnZzRITjdOVVo5R2F2NDRjcEQ5d2o0b0dPK3cwRlppNStRU0tRUHgv?=
 =?utf-8?B?MjVOK2dtZHpRdkpPUDVkcm1aOVRhYVNiZFZmQytRVWxQSWJJcTZwT0JWMzZT?=
 =?utf-8?B?QktGWjJWYm5wamtjME1GL2pFMEdvWlozNURoZEt1YkpYT0FJcDRjYjFKRXFa?=
 =?utf-8?B?WXhGcWk5THgwTXE1c0gwZ2xueUpWdGRrUlhidWNQVkx6R2VBOHJYb0V1Q0lP?=
 =?utf-8?B?VklteVdnSmkyOWRlU0YzS09zMTBSZlJyMlNlc1BqcVhtSTdOcUxoV0hMMkI4?=
 =?utf-8?B?K1NRQUVQRXI2REJERm5MZWxQTG0vbFRBRCt2akNiRi9DSnBNemZFVUFvaHRF?=
 =?utf-8?B?SFhDWWxkSE9yODgxU2N3K0xLcU1sTytzbnpXUW5hZVpFR2dMQ0R0cENRZ1p4?=
 =?utf-8?B?Vm9jcSt1Z0NjNmpMdGkwNDdzVFpTQmNqNTNWRTl2U1I5U3VtN1VwN211WDhS?=
 =?utf-8?B?TGxQcG4xOWxrQjBEMUoyNGdULzRYU0thbk1FREZBNmEvUlhxYWRqaGphN3dW?=
 =?utf-8?B?cGt5UGZVRW1iTmIxbXdPMi9odFRRUVN3cHhnZTF0Nm5BVHA3TDJCYzc0dFVT?=
 =?utf-8?B?dDJyUndlVG1sQUtPM0wxWFlyTHdoVTFFeml5RWxremc4VWFPU3AvS3ZjTldz?=
 =?utf-8?B?bmRRMmFTT2I2MGJwYVJ4aHl0NEJHQ0NyNmxrdFNIT1ZxZjZVYUovUXlERWEy?=
 =?utf-8?B?VDFvbjl1alFYZUJxTjJnVWVRY045b1NrZjcxendLRUlNeVVtQTZjQXNvaXFG?=
 =?utf-8?Q?gpaCB6qXfxLtDWDC+CF5+MlP/wuoBIva?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVptQlVpek1mVnJiMDJYdXdKKytQeHUyaE52REZJM2dYTnptNTBGQ2RqQmNW?=
 =?utf-8?B?TTBNK1BpY1JoZ3FKbkJ0L0c1UmNZa0hHSGZSYjQ5NUdpRlRsYTZpOG50dlh2?=
 =?utf-8?B?RFJCa1dWSFc5b3JXWHcwRis3NzcwSjBhZDBxK3d3V3laUGJpTi83aU1WYlls?=
 =?utf-8?B?RmtEdjFYcEV0NzQwVVFSSEtnSy8vSTc2eWV2RkJCclRRS1p2Z0RraDlJOElD?=
 =?utf-8?B?VVdqa0RKKzVIRHNZZzZZVi9qcGVibGVqNGpDd3lwODVmTzE4YUw4c1NObURM?=
 =?utf-8?B?V2orRmVabDVxREZVc0k3YmdwVHB0NXBsNHBuNU13Nk9ReXV0elp4eUN3S3I3?=
 =?utf-8?B?bXVSV05GdTU4dEM4K04vRGN2RWEyUFlCTDZpWnU5UmpXbENjc2RxVk5GSEZq?=
 =?utf-8?B?cG56Ti92bDhia2t1cVovMkVLMU93SXZhVWdJQW03VGF4eW5ualY1cTZ5LzZi?=
 =?utf-8?B?OVl3YjNvdHBFYkQycGhMdmJhTFp1cTl3b25ISzkrc1Q4cmltOXkvUG9TOW96?=
 =?utf-8?B?VkI3Vkx4dEI0ODZMVjZZMzd2dXg2aHJWVC91YUdkalFPRTYzWUNPMUJQOWZH?=
 =?utf-8?B?RitwMzhIREtZYzI2a1U3SWswYVYyM25lcEo3MVNjZ0FmajQ4ZDc4ajVlNWc2?=
 =?utf-8?B?czBZbHpvZGZ5TFZzS3JLUGEwRExQZThCL21wMjQrNVZWb2xCZEY1OWhQY0g2?=
 =?utf-8?B?V2prbDZneEVleFN5S0NCSXYzS0hpR3N0bnBEWm5NaHNETlR2SklwQ0hJS3Qv?=
 =?utf-8?B?akV2TS9Zc3F0ZWZoQ01hQWpqeGlGL2pFb1dyWGhPbXVVUytUMk0vdFN2QUZD?=
 =?utf-8?B?T29kL0t5QmZJSEx6S2p3ZkErSFNmeEtIVy8xdkdtK0VodEhpMGZvaEEyTURP?=
 =?utf-8?B?L210WUZ6QVBESGYyZEJNTkdXOHZJRlRiVTNkVkdPaUpHOVZrK1EzZEUyYXNx?=
 =?utf-8?B?eHlNa0N3cWNBbm1ycHVVY3JTR2VRbWNvaXpwQVZUZmpHMkxHbVlXVVBYc2lD?=
 =?utf-8?B?OGZ3ZERSWE9qQTA3NTNEa1VOM3didGhGV2c0Q3k5MGpxZWhwSzdJS0tySnNZ?=
 =?utf-8?B?UlZacFQ2cHFNV2x5SENkMVRtbVhIaVhXSFVodi9mcnhINndXcUx6ZUc4NXlH?=
 =?utf-8?B?N1dWNWlUa0dJZEZxMytDN0xFTEM1SzVpYUh1RHpCemxJZzJneEdnQXgvZWJv?=
 =?utf-8?B?RXhua0d1RXhnVHU4a0NLYTNFTW13TnFqL2JUNGRDNG1BNkVWWFNsTTM0YTFT?=
 =?utf-8?B?WGtpc3IxU3VOVGlCSWwrcXFUZ2JDd1p6bEYwZ0VHbjdQNWp1QnFNNmp2RXNl?=
 =?utf-8?B?d1BpTWNhL3hZbEJzRWF6QkZHcG1hb2Yyc3NOUEhQTWhacjVrdStCcGFqb3pB?=
 =?utf-8?B?ckZHbnhCSXlNZ1NzTXh1YzAzYW9POGN3MGFkQ0o0UlRGN3l0dnNmNW5oTjVO?=
 =?utf-8?B?cnV0V3BJYkFmTFJBVDZJUFBadnVXelNuWHVWVVdVdTJBL0ZSNUNDV1phUkVs?=
 =?utf-8?B?ZEV2clh6RmREc1FKQmdlQ1lDS21Xa2ZwNTNZcS9pOEJMMzVrTzhRcTFtQTRw?=
 =?utf-8?B?S0h4cG9oOEF6djVaMWZuMGlKS0ZPcWpWT2IzUk1hVnZXYXpYMnRFRnpUSWpm?=
 =?utf-8?B?Tm1ia3RHOWVJRDFEMUgxNXpZSzJUVHU0WDU0MEJma3NMU0xmN0JaSWx0cUov?=
 =?utf-8?B?VFJjaEx1V3NSSjRpMWl3MXh6UkQrVWFDdFBJdGJ5aURZS3hEMUVDMVVSdGRW?=
 =?utf-8?B?NTVnRnI1VlRhaXdmVzBWQisrc3JnY2VieHViMGRPZmRkR3hvdHFSODBrUkFB?=
 =?utf-8?B?cEpzRHpPc0RWall0clh4SlZoM2ZaOFpWRmV2QmZjQ2lqKzd6eW5NdVNQaHBw?=
 =?utf-8?B?MmE2Z3BhV2paelBxd21OUWpsNVRvZWxZbFZzYkpBaElHVURwQVpDQnd0aUl5?=
 =?utf-8?B?QXJSVE5kNUhEb0NvbXhBaHN0aThmYlY0TTBlOHFldkJCU0NscHUzcm5qRnoz?=
 =?utf-8?B?Y1lCNDd2a3krVEkrRTVqaU1xU0ZicVRVU3l3SkcrQzNlaThLV1NkUGJFREdT?=
 =?utf-8?B?aHR2RmNYNG5HMFU2aFBFdGkvdCtTSEVTSHVHSDY4SFFlQ0d1M3kzTnVham9L?=
 =?utf-8?Q?2iF8NNTZk8bWOBuiBi/sW4h6u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 535ce9f0-63d7-409d-59ce-08de01b2737e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:51:48.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X+0XSGXZP6hlriz4dhN7iXBXeHd2XlVRh+OveOy2Uy6mv65iDmHjYt/sPXxADyCdVpFYx4tmRrmEdX3B16H68Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9347
X-OriginatorOrg: intel.com

On 10/2/2025 7:50 PM, Peter Zijlstra wrote:
> On Thu, Oct 02, 2025 at 07:31:40PM +0800, Chen, Yu C wrote:
>> On 10/1/2025 9:17 PM, Peter Zijlstra wrote:
>>> On Sat, Aug 09, 2025 at 01:03:10PM +0800, Chen Yu wrote:
>>>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>>>
>>>> Cache-aware scheduling is designed to aggregate threads into their
>>>> preferred LLC, either via the task wake up path or the load balancing
>>>> path. One side effect is that when the preferred LLC is saturated,
>>>> more threads will continue to be stacked on it, degrading the workload's
>>>> latency. A strategy is needed to prevent this aggregation from going too
>>>> far such that the preferred LLC is too overloaded.
>>>
>>> So one of the ideas was to extend the preferred llc number to a mask.
>>> Update the preferred mask with (nr_threads / llc_size) bits, indicating
>>> the that many top llc as sorted by occupancy.
>>>
>>>
>>
>> Having more than one preferred LLC helps prevent aggregation from going
>> too far on a single preferred LLC.
>>
>> One question would be: if one LLC cannot hold all the threads of a process,
>> does a second preferred LLC help in this use case? Currently, this patch
>> gives up task aggregation and falls back to legacy load balancing if the
>> preferred LLC is overloaded. If we place threads across two preferred LLCs,
>> these threads might encounter cross-LLC latency anyway - so we may as well
>> let
>> legacy load balancing spread them out IMO.
> 
> Well, being stuck on 2 LLCs instead of being spread across 10 still
> seems like a win, no?
> 
> Remember, our friends at AMD have *MANY* LLCs.
> 

I see, this makes sense.

>> Another issue that Patch 7 tries to address is avoiding task
>> bouncing between preferred LLCs and non-preferred LLCs. If we
>> introduce a preferred LLC priority list, logic to prevent task
>> bouncing between different preferred LLCs might be needed in
>> load balancing, which could become complicated.
> 
> It doesn't really become more difficult to tell preferred LLC from
> non-preferred LLC with a asm. So why should things get more complicatd?
> 

Besides distinguishing between preferred LLCs and non-preferred LLCs,
we might also want to distinguish between the ith preferred LLC and
the jth preferred LLC—this would help avoid task migration
bouncing between them by using hysteresis.

> 
> Anyway, it was just one of the 'random' ideas I had kicking about.
> Reality always ruins things, *shrug* :-)

Yes, multiple preferred LLCs is a promising direction if the data
shows good results. We are planning to clean up the RFC patch and
send a refreshed version to summarize the current status. Meanwhile,
we will evaluate the multi-preferred LLC approach internally.
Thanks for providing this idea.

thanks,
Chenyu


