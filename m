Return-Path: <linux-kernel+bounces-854875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CB7BDFA70
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FEA188376E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8157E3375DC;
	Wed, 15 Oct 2025 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+vcuNkK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22572AE8E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545695; cv=fail; b=YycgEWEQz5/7eVYuPX58aa70lvhCyKDyLsCTq9wTtxvW0h+ApFtcXQn1mkR69PnTs9sfvU/934lL9dXuxJzLd3rmpauZNPRqMo+2W8odoaoM2dWZbdgR8+9z6zhWxp5kpCxTu0dwE4pJwHAHnvYa2+ab2reBg/ZQbELtvyNEdHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545695; c=relaxed/simple;
	bh=XI6l+SPCCL/8h5VwX2iEp4o6g28yBykQ0l/cMi8KR3A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRAk4XdUhLpjcy/bkBT4YsBgGiC4SAEgBdYf80CxxjGlthDVRTgMUklUa6c6bTQJ0Ck+C8DXS2xqNS5S7cYv0Y7OBcf4XsRMeY1LPhmfUI0YzxnbThYwopBWGdqGHw7DS35KpvZtShlha/HEZk8X8eH+XWn2i71sAgRCZwb6f0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+vcuNkK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760545694; x=1792081694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XI6l+SPCCL/8h5VwX2iEp4o6g28yBykQ0l/cMi8KR3A=;
  b=Z+vcuNkKTy0TtLIwS9rLMS36KAc0zFzgYgHhfS7iYWbSHcMy+h37qlIY
   N8SYDvJrBFRBLNi3PdlbBiLrh5iY8fJHb/iQHLR/sCMHZmTJIlx/yM7sM
   311yDKUsyFxNkif8rYiXkLiumiMWCryARSuVXqkH4l0s1umm4iX1eMftg
   MOfvjck9Q38AcI7MXQcfbTTKn9e21r9bfIjNquvCU7JsSImxWfvRFEpRP
   Q1rdVNGRgS0IIqKPNPHeDN7skRYSN8si6joY91c2UivgqcOzfiVfd9EPR
   k5UV/YR+ycmBX3LNVxOx6/3rwSwa0MBjlU1+LxAw/ABzlTbVywlcOd76W
   A==;
X-CSE-ConnectionGUID: U0sZq/lBRt26PotAF+9OfA==
X-CSE-MsgGUID: Bw6e1pbKS0yn7A5zhwB5+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73403462"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="73403462"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:28:13 -0700
X-CSE-ConnectionGUID: Ocjw2JyPQ/WUGD188XVBAQ==
X-CSE-MsgGUID: uem4brAMTOm2XA63maXueg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 09:28:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:28:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 09:28:11 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 09:28:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfBP2c+9hK+74e0LeX1WtSFo5LLhIeRsoL6P45A7UJpzC8oVT7jEP4ymppejPuo827OTxVmfekWjiXcDZtRLlFvgm72Kkhsq7kd2tZ7WbNoGwrvIkO8Go9IbVSVry9wTpVMYo57honLdG6QRGgoT5Tr9746G1P+ui18m/fhm5AnVmI0QqlBZ9ywSIGg2EGpHLHvSSuSQ1Am3Tz0Sc9YnSQDFTfD3HJpmHFJDEAkgeANpvbcHbgyYKi2MvJrfwyExz8qkpWjM4ql4aMR11pHca/P3kXGiygWTCERv0gdXkvDMZZlBwO1rJU7ZK4pY7rdYjb6hARLmwHfbBhOby0PqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYlFtp7Ktbi2TJqOJbOuBWsG+34Slw2txhFaX4kNIxQ=;
 b=CSQAGdfua7WCzKu1I7fdZhLZHZqCnzbuG7KKmXPHPcurIw4qvpGHxidFjK/xu4/lo4Z2JOeevrDTMmB4APi/tObmWaxvr5HDIdPhYu3Np4Skqh6mxF+ocdNmKoSa81+umLNhdVIdyMRYXDxM1ZEDsAVqUb2eqZrCNgmyd72TJgqHd5AfCoIXHB6iyxabilRca09qMrMO+7n7JotUWk4AWiWK7r4YFSFEnPUAtOAQ1gfKmznmspmT1lFHc04lqPuDe/CZUqCbzIt/sYkvO4pjVC0zdUrLcpJI+HtzyKNHjHT23UBI6DYoVf76UBPyPLVq4AYm6+YsBeHHFWHFGniccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ5PPF0DADD6EFE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:28:10 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:28:10 +0000
Message-ID: <95cb85d9-f018-4e71-88bc-f4129227bcf2@intel.com>
Date: Thu, 16 Oct 2025 00:27:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide
 cache-aware scheduling decisions
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015101519.GN3289052@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20251015101519.GN3289052@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::35) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ5PPF0DADD6EFE:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c01e4c2-c672-4ac7-ee9c-08de0c07d456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlUwM3JZUHV6eXFtbVl6UUhDUklJTWVnMEpPdEgwOG5WenZULzNjSjM0RGdk?=
 =?utf-8?B?cWpxczQ1S3RIbkJ5ZWhSUVgyZjZvb1FhOGl0MmhmMW51TFZzR21QNnFjRE5N?=
 =?utf-8?B?OXdkazNFUkZZRzFYYlFyR3dkay9vSkRjWXdjK2NGWG5pZUtuWWZJNFk0TnFk?=
 =?utf-8?B?THlBQW9ETUdUV1I2RVh0MWhYUmZnTTExNHpqWm9Mc2h5b1gxNzBESDIzQ1ZT?=
 =?utf-8?B?N2N0MzRwNTg5ZXhGWSsyS0lpRlM1NXo2WUw5M3pJVThsc1RNTGpmTlV1Yk9R?=
 =?utf-8?B?d1FjdEpxZW12andpWWdYa1ppUDBjZ3ozb2xmMWpienpCem1kamVGSGM3RVdH?=
 =?utf-8?B?eUp4UXNKL2xwSFBGZmlVY254R1IvNXh0RGszZzJuN01nWlR3ME5qNEZ5Mmtq?=
 =?utf-8?B?ZktFd1E0OXRQMGtmeTM3eGJmd1F1Njk0M0ZOTmlKdVBiNzFxcGNpd1l5UnJ5?=
 =?utf-8?B?cGxDOHlTUGdjVkJ0eW1qQk1oWnhhRGV5NTJ4U1pHWlF3ZitHcW8zYWJrbE9u?=
 =?utf-8?B?dDFiUnZTenQrV1pML3JqUkVqWkFtTXk5cXdndjJYTzhTQm9CeU9wVUdaWC9D?=
 =?utf-8?B?RUl1cjBLRDdrbmFWaTFpVTUrczRiZXB2OGJFaStiMGVKT2hNemgvSkhRU01P?=
 =?utf-8?B?QnNTbUs1dXNDSVEzWjE4MEU0ZFM3YW1UODRoeFc1N3ZnSUhVenJkT29ReERC?=
 =?utf-8?B?TWZwOVJUcjBOU1JxYXRLMlVuU2owUm5mcExKb2FaSG9aM243WlFIQktSckZx?=
 =?utf-8?B?a1ZXeVh3clJxMEoya2JuTEZRVFFKNXpaM3FsakFoZ0pSL3Q0OHExbEV6RzhP?=
 =?utf-8?B?S0R3VjltU2tlYkJJRUc3a0habFljNmIxLytidkExSU1hNEtkdXY1RE9lZzlN?=
 =?utf-8?B?Z3R5YldxSUJCL1VjVVhzcFNqUnFyRkp1elloWlcxYWtUV3BCZnFkNmVSR2Zr?=
 =?utf-8?B?RFlKU1A3dUdOdUZxQVhJV3J5MFJHVVNTRitzNkI0NVVLMW1xY2dlMDd1Q3RS?=
 =?utf-8?B?M0plQVc2aXM4RXVBNHE4dFF6NmFqdzh1TDBrZml1UTdESk8vbDJIdjNMZ0dS?=
 =?utf-8?B?L2VBZG90ZXJqYnZ0aS9qcG5DVEdjWnpqdy9UK2ZXQ2NMZzl6d01QclZna2dZ?=
 =?utf-8?B?VDZQbzEvNDQveERZR2lnZHZBQ1NicElWY253bWIyK2RhSzIyOHdMRGdsNjVx?=
 =?utf-8?B?d2dpbG5kUHR1d3o3UGtsckpZYTltMHRVU0RndUZWMHFlSFlTWG15TW1YMFd2?=
 =?utf-8?B?eCtRWGFlUHhkT3k2TDdPdE56Y0VSQ28rMDhVWTRDRE4vTzEyT0dLMnhiQ1Rt?=
 =?utf-8?B?ekpZMjY5MmJxbzFLTEZDQ0UzOXpkcUFxb0VTTDBZRFRLNmNORnpqbVJEQTNT?=
 =?utf-8?B?T08rZ1BSeElsZTBBMFlKWVZWUFl6NGZLWGhEaHRMeXJiYVBHNVpoTExFcFZ1?=
 =?utf-8?B?ZVBkemhUeExyVFl6T253U0srbFVpdldGOFB2cjBRY1Z4bUFLWW9kQVdRRm9n?=
 =?utf-8?B?Mmx0MkhCcTR3d0IvS1RvWUtHWWJZeE9iUGNQUnJUS2M5MEovenF3b2VlZUs0?=
 =?utf-8?B?Z3dvZWpyRE5YdXVBeTlLbWUySjlZZ1ZEY3VQaFk3L3dDbGl3TUNJbzVyd3dr?=
 =?utf-8?B?cmc1T0pYWGFiTWlPNmRhQjdBUFVIbzRMbGIvd1BNcFRQOCtYZ1JtYk9DRDRa?=
 =?utf-8?B?U25rWEZvbCt3RWpZOTU3VlRWMnZoeWJBbmozOUxTajJjcnk2bkRLc2Q0V2Zr?=
 =?utf-8?B?VnF6NGhsV2JXRktzYndqdW8vMTFNdTVMUVZtSmlEd1E0RWRCRWh0SHBDTTF0?=
 =?utf-8?B?ZDRNS1RmVkw0L1ByWWtFOGlqQ0dvVCtxVkZvcjZjMEM2dVMxZml2Y0ZsSzBG?=
 =?utf-8?B?R2U0RjBiNHFTOW5pTGN5MlZVNHlLL2dNQUxLdnZ3Z2JVRFB3azZUS0dZSXU4?=
 =?utf-8?Q?VTys8iFplMHW7lrrOggoM3eWz0P3BZ8M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG1GQ2VoUHFlS1d4dndaaHF4MVFBUk1ObTEvTnRoL1hQSENzcUhGYlFxa1BT?=
 =?utf-8?B?eGhaczVCdkgyOVZjdkY1L2VuTmJIMWpkb3dFV05UQU5qemo0ZDJrOTR4Ymdp?=
 =?utf-8?B?SHpUR2x1YmRRY2MrYk51RStIVkdTNWgycHBLdUF1QThGRjFaNnppZVhGSXZO?=
 =?utf-8?B?TjNYVFRQc1d0Y3BFbjErK2MxU1BUWDUxeWlEbjMzVWpWUnV4bWtURUNFNlpZ?=
 =?utf-8?B?b1U2NFphYkJJQmVzL1BBYkFiZDJsOVZVanQ5c2E2WWlKSyttbHhDSmR3ek12?=
 =?utf-8?B?TER3SUpWVWxqOWxIZWRuVkxnbDlDMjhZN3pYM3crcEVFQ1NPVlk4SHFBQnFT?=
 =?utf-8?B?R0QwbTdCdGFIS1RyL0MrbSs0R1paNGVmbzJvb2wwa0lsT2w4TW1IZmYzUjJq?=
 =?utf-8?B?REtKaUtjK21PMzBWWk9HSDhleVBPOXFYcU00Zmk3dzF6OFp2aXVlUU9HQ1lm?=
 =?utf-8?B?QnRoT1ZrRVBiN0twU2Iva1piUWMrb1ZVOUpWWEJrODNWaVpoMGdYb09uLzlw?=
 =?utf-8?B?OGxWZVFYcStaNFZGczFpdE5UUnFxSGlVelpPYzJnYnBmVXpUYTNXakVoSHBV?=
 =?utf-8?B?WW0zM3lzcnpHK3A1cEdIOE9rZ01LV3ZjejBLalE5ZHNJeFR6eFZZbEtJcm5m?=
 =?utf-8?B?WStHTUhidEw5bG5meVkralNuWm9UMXAvOVk3OHJZZUFDOWZadE1jbExjYjkw?=
 =?utf-8?B?SFh0Y2FDTGRLWHRXd2hsRWVGS0lQL1pFM2ZmOU9USUZXWmQrNTRaMTZLUi9P?=
 =?utf-8?B?Qms2WEtXOW1CTUUrbXFXN0dKMnM3MVY0NmFkaHNFRHlmd3RqU0dQNlNJQ3J5?=
 =?utf-8?B?Yk1zWk14c3BWaTN5cGREOEJYVWZUZnFOSDNTa2tHb3VXdGhaR21lQUNnTXZl?=
 =?utf-8?B?TW42OHpHWTJ4b2l6MDJiM2I1RDUySTdEVm1FM2FyNm5CdXR5TkVuajFwb0g0?=
 =?utf-8?B?eHBXdms2aE9sbDdPY0puNER6aHlDdkgvUDBlckFhYmxyeFh0QVVmVUlxZ083?=
 =?utf-8?B?VTA0NEhvWS9oZHI0QmJzVm1kWE5COE9YZjhCU3RVWnZUdFdLeitRU1I1WTE4?=
 =?utf-8?B?RlJ3a0ZySFZCSUZPV21SUlNUem9tdXZaMUM0T1ppVzdtNG1IMlBaNll3VzRs?=
 =?utf-8?B?TEdjY2FwLzM5NE81K0w3MVNEQTAzMzk4RDlMN0tWeUVyM0VtZGRaWWY0bTBY?=
 =?utf-8?B?TEZhWmlTNTE2bWlJb1Z6N0RnK3lkVFdrSC9QQ1p0Qmp2V2E5MEhsV29Uelk0?=
 =?utf-8?B?V3ppQTlkVHRyRi9hNmVXUDZaaXEyZ09Gazh0cVB3MkpaaGEwOW5LZU1jaElh?=
 =?utf-8?B?aDVHczBRa3d2WGk1a056bzk4VlNzeENIcnRaRGppKzdDSDlId2JsVnA0TGVF?=
 =?utf-8?B?YkZWU3JqcHAzdjRtOUZ1ejk0OUhWOGY5U1Y3WFI0NzRsYTdzTnhDVEpVQk5T?=
 =?utf-8?B?OXZ1R1Y2ZGI5dGZtNWRPV2M0TVpDZy9TcThMUnhCMlh6dGZYSWpxRU5aci9y?=
 =?utf-8?B?czVaZlpwZXNoT0Voa2hNb2VpQnc4amJ6aE42MFlXQkMrYk1nU0JETmt4RHhv?=
 =?utf-8?B?TUJINFgwMTA0d3BocTUzOUVLamVUc3NDNzJ6ZzRJbDlmTWhXUjU0VVJ1Y3pM?=
 =?utf-8?B?L1oralVGbjJ4VlQvNXNOdHlJbUdRbThNcmFONUpqOElaS3RPZ0xjUEYzY1JT?=
 =?utf-8?B?M3dwV3NSUGhwbHE5ekJURlQyQmthMzIyekd3dkVBSXI2UFFQM1hnTWJWQzc2?=
 =?utf-8?B?ZFkvQnFJZWhEaHN4TkxqQVYxMG04RllWVmNoN01hUEFvcHJOOUtlSTZ0SVRI?=
 =?utf-8?B?L2h2elFBR3RsV0RtOUx1WlU0YStqOTRvTEx2ZVRyV1pWZm9YeEJNOTlibzVH?=
 =?utf-8?B?KzJncEswclFBQ2kxZHVibno4OXBTb3FNeEozL1lZb2ZlMHRTRWRYb0dDNm5N?=
 =?utf-8?B?V1lWeDJydGdVYU96alkvWUo1RjRhaVVHQ0dCcEtmUmd1U2ZrVlJIem1Fbkp6?=
 =?utf-8?B?UTBzZ3Q2MHlDa3lQclJhN0h2NEw1cWQ4ODAwZ0pCVHhhQjlxWjNsQnoxL0c3?=
 =?utf-8?B?UmxUN05ZeXc5U1Y5T3lsZ1REcHhveFFVMjN1Rk53V2Z5SE1mRHB4WWtNaThh?=
 =?utf-8?Q?abldTzQuIQqhHMLCLMqVT6aUD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c01e4c2-c672-4ac7-ee9c-08de0c07d456
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:28:10.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fvvjXZTsfdEpOyTlsEK03U5PNAdM1i/yxWhHL025FHE5UtlPAYIaSjAJOPByxfQi8QmsJKuwIKEwDzlmj9PvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0DADD6EFE
X-OriginatorOrg: intel.com

On 10/15/2025 6:15 PM, Peter Zijlstra wrote:
> On Sat, Oct 11, 2025 at 11:24:39AM -0700, Tim Chen wrote:
>> +static void record_sg_llc_stats(struct lb_env *env,
>> +				struct sg_lb_stats *sgs,
>> +				struct sched_group *group)
>> +{
>> +	/*
>> +	 * Find the child domain on env->dst_cpu. This domain
>> +	 * is either the domain that spans this group(if the
>> +	 * group is a local group), or the sibling domain of
>> +	 * this group.
>> +	 */
>> +	struct sched_domain *sd = env->sd->child;
>> +	struct sched_domain_shared *sd_share;
>> +
>> +	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
>> +		return;
>> +
>> +	/* only care about sched domains spanning a LLC */
>> +	if (sd != rcu_dereference(per_cpu(sd_llc, env->dst_cpu)))
>> +		return;
>> +
>> +	/*
>> +	 * At this point we know this group spans a LLC domain.
>> +	 * Record the statistic of this group in its corresponding
>> +	 * shared LLC domain.
>> +	 */
>> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
>> +					   cpumask_first(sched_group_span(group))));
> 
> Isn't this sd->shared ? Or did I loose the plot somewhere?
>

The sd here refers to the domain that covers the local_group,
which is derived from env->dst_cpu. Meanwhile, sd_share corresponds
to the domain covering the 'group' that may be a sibling of the local_group.
Our goal is to update the statistics of this latter 'group'. It is assumed
that the local_group and its sibling 'group' have the same CPU weight,
meaning they each cover one LLC. We check sd simply because it is the
only domain we can obtain via env->sd->child (apologies, but I haven’t
found a way to get the corresponding domain that spans the 'group' itself).

thanks,
Chenyu

