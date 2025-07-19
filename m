Return-Path: <linux-kernel+bounces-737904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41090B0B1BB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8058E17DEF2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915862248B0;
	Sat, 19 Jul 2025 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItlzQLKM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6291422DD
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752956082; cv=fail; b=mshnUoIwz27eC/bHrDJUadVSF9EetPd4ndSWSOta6uH7sSxfzQkH/k4vhdA1zoBsP6vkZ0A38ZLrTdBwJQet25I5i99QwbX0fZkFxQTcxV3G8s5LQusc/PlDBYLlzCLE87GGeWrYhHyxX6T95yi/7goP4x6UfyF5Rx3rRwKJm/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752956082; c=relaxed/simple;
	bh=mJq/nl7+6d3dd9wlzNpNjtmFD5lpxKHXGKdhlEZnm+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gd6cM4lQtS+Xys7Yxj6CTym0Z8gHfuwI+NnLjYVolgpywbJR383ZgXy/zL4iZotpfuZnLBFAFuaY+mWhcDZ/eFXzvKgomvUzPk8S/vUoxm2fvRc1e/XtZdEB5mOLt21bu1Pk7H+Ytj4GwLE+zYZEy9KBjcfZizSKM8bW7TpsMzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItlzQLKM; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752956081; x=1784492081;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=mJq/nl7+6d3dd9wlzNpNjtmFD5lpxKHXGKdhlEZnm+k=;
  b=ItlzQLKMPntSEBFZkrFvdqTEZsxbS79UETTo7dcsPpMcZxhlsrRavrXu
   jbVlH4F9RarI7QT7ThwRg92C6rUcroy00EFDbfVPCa0Du6j1FOBFMCceL
   0oaNYTUi++kTccuSnZUMYiYRs3WipPlEB8eQ443i7GkkfLCXh5JE2LkzZ
   cyZLIzRILq11d07Kh3aPa5W19oYuxLbj5MoeJ11PybXDEpIoCO0TOXwCm
   kHmnH5Rq5I4748PlHEpdmoUe7ELpbFZjdEc3tOCdrngMmwPakbBk8e26V
   mdeFJ3KZBnLP9dDjmVo6YWMq049blR6AbwY2Sud++psI/OXVACwneqPGY
   A==;
X-CSE-ConnectionGUID: fmpplIibT8u/YKYii4lXHA==
X-CSE-MsgGUID: 0zUX9zB/R720fdOV026RGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="72785289"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="72785289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 13:14:40 -0700
X-CSE-ConnectionGUID: D69Gpu9eT0Gfs0htrBcr1w==
X-CSE-MsgGUID: Xa5E45YGRaGD9nqCOgjbWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="157819807"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 13:14:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 19 Jul 2025 13:14:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sat, 19 Jul 2025 13:14:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sat, 19 Jul 2025 13:14:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttzEkcsVKKMvPpyfjf/5toagPx7ac0XffwIF5WTa9z3jtZUsuMEHTz+Ru+4faeRCNiAFd21hwIuHuzfCO7ZPByPQ0adb2IW5THm555/Wokx9hfm14xL7ijz6iu4+flhS1KzqZ9DwSotCBxnOnfvA/YrP8pwuogpuERpDRAOwTo4gG/bqIl6QF3GmNemj6lwc7nTk/sO6Vx1l3WGMG5NeeSuMsorcwb8SDXR7K9rqSflaKdhGEkC/zzBATCArEo8LJ+bU26EZDjxU60pGwQJbLl6opEF03Eat+kKBPGK2T0km88H8Mor2Xiu0hJZK6zPpYSsBTEIVqdL3m2s7J5BZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amlR14WoS9U99eQNnUYWcSTYXbEUJ4NyqliAE2mFpvw=;
 b=q1OraV/OcVDda+p8zvAPCK3ilspqaK9mtMr6rs4Ta54r93RUhTqRJNhHNoRvdG8/I5Y+KpQZ1+TYVeZwTucXzhpwX9d4PDDuUkxRxZrixJSxiM8dRUb9VVW33IRTosZI06WuACmlyPkY4uepKgl6T3KJ3HvpP8j85sqQPbcyvdY3/f2swXHVLgx1mckVat1AcPOZ284IOrHYBIKEuCp7HqTTlgWN5pn49dhsMXnV1r4S1/bTFRlWr7gfFEhO3GMfp753h5zukydxXyJeLMv0PAmlLvUiGgMkZt69GQOPVZmNU/s3RosM9tXK1TiWGbYXs48AQDQZTvzeYnDPvgrqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 19 Jul
 2025 20:14:37 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Sat, 19 Jul 2025
 20:14:37 +0000
Date: Sat, 19 Jul 2025 13:16:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, Karol Herbst
	<kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
	<dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, "Barry
 Song" <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Donet Tom
	<donettom@linux.ibm.com>
Subject: Re: [v1 resend 02/12] mm/migrate_device: flags for selecting device
 private THP pages
Message-ID: <aHv9FeQDsrAvCh3W@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-3-balbirs@nvidia.com>
 <ln75hcgtiuutmlbamc4yd2sbwcada35daz5zufrrz3ad5ids3x@vtq2kntpg74s>
 <6eba6c3e-a579-44ca-af59-b8adc7dfffe1@nvidia.com>
 <aHv6veBV7TumQA6f@lstrano-desk.jf.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHv6veBV7TumQA6f@lstrano-desk.jf.intel.com>
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 41cd9546-cd18-4266-280e-08ddc700e273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1N2S2FEVTZMZ2VFYStBTHdBUzF4THlzK0pKVU0rTTlIaXMzSW0vdWN1Q2Ri?=
 =?utf-8?B?UGMxRi95WDNnTy9kV0RoTXZzNEpsZkVRNUxYMjhaZDJYdWJseWxiYlVPT1FE?=
 =?utf-8?B?c0R3UkdiU2hBSnFyeDdnMHRCZXFyM1VnQk9MRDByTGhDRUpVWEFQSEFGOE9W?=
 =?utf-8?B?aWozaGtxQUM5WGUxMlE0REJUYmxwbVBkbW9vcHpaaGFZSDVwaVhqQTBKbTE0?=
 =?utf-8?B?dS9YazdrRnBkK3BsS2l1MW9NRC9aZGs3cXJMeitUYWxTUGd6L004WXRFYXN3?=
 =?utf-8?B?S1pmNFVOdC9WeTlveVdYN2FSUDdQeDNpV2RZYkVRR3VaeE9QOG5lWmhMWGZQ?=
 =?utf-8?B?V0FKTTJFNWk2RDRuNm1MV1VJc2ZkOXNDSHk0RFRjSjdHOWZaQnlHbThNbGt4?=
 =?utf-8?B?OTRIN0Y2cUlxR0VGM2pWRG51RmwwbytXV1NIN0FPdjRBVVdoUWFtQnhXZVNx?=
 =?utf-8?B?WVhMTU9qNmRCTEtwR0tyN2w3NjdQT1ZJdFViOUdhamJEQWFxSUtoUUdoY2xG?=
 =?utf-8?B?SzNaamRIbERvNFBoREtMT2FTa2ZsdytqZldwV3R6ZXJGQTRtZm1mSFdxS3ZI?=
 =?utf-8?B?UHFkKy80ek00RFQyb2praDF1M2RBQVVheFd3R0JwTnFTWFJJVXY3b1BobjJh?=
 =?utf-8?B?TjJJdVZlTWR2SnlyaFpzenZRYk8wZHJmVzhWSDFZWmxoU1FZS3Z3NERLMTEw?=
 =?utf-8?B?aFFsUnkralJiR1Rqb1poMnRDamJoZzZMQWRqTDBzby9TL3RVOU1hRzlQZkNS?=
 =?utf-8?B?TG1oditiZTZxN0RjZGpwY0hPb2F4bkVJNFJxbzBUdXNFeklLNVpQbkx5andK?=
 =?utf-8?B?OEc4cERyUU11bWZlckxhMDlVZWZWZnd4Q2svVko0a2NBL0pkdUNYdVBGdFNq?=
 =?utf-8?B?VlpYSFArd25wQW12NnYyd3ZUT0NRZTNZblQrRmtCODVaMDBWYldGSHI5MnFU?=
 =?utf-8?B?ZGhpMVdHK0R6VUpJZXNKbGMwaVhaOW5YTm56M05KdXk1ZUMzWUcvMUg2aGhu?=
 =?utf-8?B?bzloV2VvLzc0M0toeVg3OXJXWEF3eHYwWGxpTldJYnhIa1BhaEwyMUxHWGRx?=
 =?utf-8?B?dEpyRzZsaU12bmNCNVdWSTc0Tmh5aVhlV052M0Iwb1dySlVGU0N6OHNZRzZV?=
 =?utf-8?B?NkpyTUk4dWNINXY2NldHcGkxeVVnZWNSdHRjcHZURDNOZWZCV2ZOZ09MRFBQ?=
 =?utf-8?B?RnZUSlp1akJ6MXN6Q0M5SXVrOTZWeHcwQ1oweXo1VzFsclBZVG9TbEZyUE1G?=
 =?utf-8?B?b1R4SGRIQmdzM2hlN3Ixek1QL2hWTFIwVGFyUlpZMFhiQ2JQMFEzcXkzQ2Zj?=
 =?utf-8?B?V2tvaUN4UjNITEJ2cUk2SmVJNkgwMGtTRE5XYitvSS81ZzV4ajZOLzN0TVdz?=
 =?utf-8?B?cUJDTkJpaFlSdXMrK2g1b01CaTdsRDNYSGR0ak1nb2FObml1RTJKUHJtdEF5?=
 =?utf-8?B?TjNTZ0M0KzRHNmtlc0prdDgzRDB0OVRLSHhXL2thdDF5YnplYm05NCtMRmlN?=
 =?utf-8?B?dGhmQksxeEZiSjZqVGRCR1prK094aUs3d1YrWGxhbzFJOTRGcVFvSllxUWw0?=
 =?utf-8?B?VXZIeEZubWZjNzdlaERjSXQrVTRlcVpuREdaUVo3cUplZ3NKdmQ0UFZYUGhi?=
 =?utf-8?B?dGNoNXNRNmdJR3JlU0oxbHZyOHQ0c1F4YnJmWHVVSDFoM0VVUnl4T0l2UkI4?=
 =?utf-8?B?dmVtSW5CN1dReGh0MFU2Q1B5enMzUjlWYld5SWdzVVR1NE5zMmlzdHJaRFAw?=
 =?utf-8?B?VUh4WmVxNzdESHFjdlRWa2VxVHd0NituRjJvWW02VlF6MlFwYnoxNWc5YzVE?=
 =?utf-8?B?S0g5d041L2xwR0hmYm1pRzVLUTNPU2lNUkszd09uRzlwWTNWZGlINGZxSXh6?=
 =?utf-8?B?OE95S2JhSXl2OXo1S0dqWXpjeXJXTHZtdlRpZVA0OXR5T3Y1ajR6UlhpU2o4?=
 =?utf-8?Q?P8ATziCrNk8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEV0VXZjTWdDSDhKOHowbzRuOTRaNkJwdngzSXhqd2dWencwMjEzd0hBSUpD?=
 =?utf-8?B?Uk1xVTVxQzkxd2dlOWFhU01GOXRXcUEyS3pXM05jK2t3d2p5a2t4T2RiRkkx?=
 =?utf-8?B?WHZRYWJhU2FIUlh1SXpaUUZLK1dtT1BIVUlDbjdac0JlNXBwQU14c0tVbHlh?=
 =?utf-8?B?VlVicTVVZE5zbjNPc0xQVnQ5OGZEUnJKV2RYeEhyZytiREtVczZHSC9DZDRK?=
 =?utf-8?B?bUlzd1FtYXJEdXlLZm5SbUh0Ri9ZWnZrTGdhNTIwQWwrV1c2NU9XdFF3dnhC?=
 =?utf-8?B?M2JKUHZEY3JOU1lnbE1xWjV2SkRHcnJ0UzVFVFdtQUpWdkJFdW9pc0x3d1Bi?=
 =?utf-8?B?NnArWXIwYllvZVNOVnZaK2dGcHhSU0RrS0FHUk01UDJYQW1Ud0hXeWc3MVBy?=
 =?utf-8?B?NWFYR2UrVUZXUVNYZXVNOEQxcllEUk8yRlNGU3Z6czVXTm40WmJyMXlibmpt?=
 =?utf-8?B?Syt3b0tNNmsxa3psVGtRZzdUalJ2OEk1dnNLaUY0OE9LcXJrbzhDNk1qWXdz?=
 =?utf-8?B?SGdpbmV1VmNyamJtcDJtR3ZUYktEMnBYZ2pkNXNNdm1aWWoyeHBLa1hNazJq?=
 =?utf-8?B?bzFkMXNnSmM3bTE3aURhQi9MZTUzbzdaUTUrUEkrN3YyZXRtZmc5bkt3QS94?=
 =?utf-8?B?dXFVRXUzMDM5U0d6OW5uVVc1S2tDa0o1aXgxYTlaUTcyUlQyNVBubGtsQnRh?=
 =?utf-8?B?MjJpLzRwRlJWTEMzcTBkQ2UyUmJqaDlMWGpxSGxWOVlYK1RwVm1Hd0g5UW41?=
 =?utf-8?B?TlhnQ2Myc3Fqajk4MFd1a2JYY2xvYUVhMXozRnFkS0FhUXdkblQrMVVGdmdu?=
 =?utf-8?B?R01kRkJFaGV5c0NGc0w4L3ZuQ0ZBS2tZVXlMK2VmUURSZGMyZnd3dmp6OVlX?=
 =?utf-8?B?UHplSkM1Lzh5TGJEUUNXaTJ6a2QzdTJwL0FxUVFBaGloNkRNaFpXcitTZGxS?=
 =?utf-8?B?UFgybGlvbU96V0VOQjVYemdRS2UxcjI1cnZkT1ZJbXJpa1RvZi9BN1dMU21r?=
 =?utf-8?B?bDh2dHdaQVZJcUE0enQ1R1VZUkxMblZxL3Zja0tuZkE2eVpFbVpZY3F0S05K?=
 =?utf-8?B?NjlQQzhZN1hJVkxJWWllL0hZZy95S2U3WWN5ajlhOVdTMXZyNzRFUEpQQ3Fz?=
 =?utf-8?B?cFpnS3JidGh3N01BR0ZLYVM3Ykpzc0Vaek0yTU9WUXgvSjJmR3RtWUtPbFNB?=
 =?utf-8?B?MVUyekNzcTMwSTBaeU8xNmtwZ3lKdkIyN1hacTVkZ3FrenovMytwSzFZRjcx?=
 =?utf-8?B?RHQ4UklqcCtIYkNKTUtya3Bua21QRWZReWF2RWR3R2l1cVZuRlN3dytUT1Nt?=
 =?utf-8?B?a1hST0lWL1F4eGRuZEtEbVZjK1BjbkVicUYwcXc4NVp5SG5EcTVhanlKcys2?=
 =?utf-8?B?OHRzTXprS1gvbzNUN0RhZmo1bXovc25SRC91RWFRazFlN01PNXFNa2owQXdZ?=
 =?utf-8?B?MTR4MEtmNVEzaTVhaHB1UFI4WmtKYy8zZDlwa29lQXkzTnJCd0V2SEdIaHI2?=
 =?utf-8?B?eSt0TkgyNGNOd2lYSmFCYlM2dk1BaHRSKzJHYXF3cVczdkd5anAwN05vY2Yw?=
 =?utf-8?B?TlFTOXZWNkVuTjNjL2Q2bXhjSkdzdklpZStOQUN6QzhBdkFYYlgzMy82V3ls?=
 =?utf-8?B?S0hEblAySko4d0FoL3hwaklaWnQ1Nmxhb2NFM1BHa1lCYU02Y21UWGdzU1hz?=
 =?utf-8?B?eGh4blNuMW1XQ2ZBMzR0N2NxS1VHeWtTc2dZRk5HYjNac1Fpdmg1N2x5SVhH?=
 =?utf-8?B?ZmhROHpXajFUeXg5YzBveXhOVk1EeXJIWDR2eUJQTmlVT1d5YktEZVBhKzRI?=
 =?utf-8?B?WGV5WlZSZTBCTXY4Q1pmdElUSFl6RC9CQmJVb3ZlaFBKdjdKU2Y5SUY0VXYv?=
 =?utf-8?B?WlBPWlh0Q2txZnp0SFhqeDd5VGVUM21TcDlrcXVWc0RlNCtZT3kzd3p4L0hh?=
 =?utf-8?B?eHRNQ2I0TG4rNVUwd2JDRVY2RjJwTjdlTXJUQ25HTkxJVXlvWHRkc09nUWZ0?=
 =?utf-8?B?ejVqYnFmVTk3amFBc1NqWlc4VXFwVFlpMzk5dHBGY3hBZTdzU1lQVm5yTWpG?=
 =?utf-8?B?bWoyZ1pQZEsrUUVEWlY2RVhHNnFxa0JJc2t4bTZ0U2tPbTZJdkJEYVBLQ2dU?=
 =?utf-8?B?SHhRMmhWTXM5RGRwTW1rMUJIV0JXRjJvOWo3cWlob3JRM3grZkhwUUZKOXFK?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cd9546-cd18-4266-280e-08ddc700e273
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 20:14:37.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkMImU87vl9j3RGAsJbBzELSKqPClOgOVsAXrOwpevrpQLgbfwgNJJC7/NxJbVaQTgzkweTYV+3BshCeAr7g2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com

On Sat, Jul 19, 2025 at 01:06:21PM -0700, Matthew Brost wrote:
> On Tue, Jul 08, 2025 at 05:31:49PM +1000, Balbir Singh wrote:
> > On 7/7/25 15:31, Alistair Popple wrote:
> > > On Fri, Jul 04, 2025 at 09:35:01AM +1000, Balbir Singh wrote:
> > >> Add flags to mark zone device migration pages.
> > >>
> > >> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
> > >> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
> > >> device pages as compound pages during device pfn migration.
> > >>
> > >> Cc: Karol Herbst <kherbst@redhat.com>
> > >> Cc: Lyude Paul <lyude@redhat.com>
> > >> Cc: Danilo Krummrich <dakr@kernel.org>
> > >> Cc: David Airlie <airlied@gmail.com>
> > >> Cc: Simona Vetter <simona@ffwll.ch>
> > >> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > >> Cc: Shuah Khan <shuah@kernel.org>
> > >> Cc: David Hildenbrand <david@redhat.com>
> > >> Cc: Barry Song <baohua@kernel.org>
> > >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> > >> Cc: Matthew Wilcox <willy@infradead.org>
> > >> Cc: Peter Xu <peterx@redhat.com>
> > >> Cc: Zi Yan <ziy@nvidia.com>
> > >> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >> Cc: Jane Chu <jane.chu@oracle.com>
> > >> Cc: Alistair Popple <apopple@nvidia.com>
> > >> Cc: Donet Tom <donettom@linux.ibm.com>
> > >>
> > >> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
> > >> ---
> > >>  include/linux/migrate.h | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> > >> index aaa2114498d6..1661e2d5479a 100644
> > >> --- a/include/linux/migrate.h
> > >> +++ b/include/linux/migrate.h
> > >> @@ -167,6 +167,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
> > >>  #define MIGRATE_PFN_VALID	(1UL << 0)
> > >>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
> > >>  #define MIGRATE_PFN_WRITE	(1UL << 3)
> > >> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
> > > 
> > > Why is this necessary? Couldn't migrate_vma just use folio_order() to figure out
> > > if it's a compound page or not?
> > > 
> > 
> > I can definitely explore that angle. As we move towards mTHP, we'll need additional bits for the various order sizes as well.
> > 
> 
> I agree you probably could get away without having an explict mpfn flag
> for compound pages and rely on the folio order everywhere.
> 

Actually, I thought of one case where this is a bit useful—when a PMD is
not faulted during the call to migrate_vma_setup in a RAM → VRAM
migration. This communicates back to the caller that it can create a THP
device page. I suppose the caller could infer this based on the src
entries being unpopulated, but I thought it was worth bringing up this
case.

Not sure the MIGRATE_PFN_COMPOUND flag alone helps in the above scenario
with mTHP though. In that case, you'd probably need the order to be
encoded in the MFN as well.

Matt 

> Matt
> 
> > Balbir Singh

