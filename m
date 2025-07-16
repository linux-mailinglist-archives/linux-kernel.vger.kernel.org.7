Return-Path: <linux-kernel+bounces-733906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57319B07A74
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D0D16A16D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291242F4A03;
	Wed, 16 Jul 2025 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NykjO+wE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA32F49F6
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681446; cv=fail; b=N8R0lEINqRVXhZ4/+jshNXSJduxihLwF5LqBEhW1rzLoKW1GG15oUZRUOqFU1TJwS/lWe9LyFGp7RQYAxGYbvftMu/qziG1aZ14i0P5+eIyoVXJ6mTaP/YYc7MQL1SVYRzUyEbPgUP0CkijbhUlZwmEw7CZZdqiUhOWQ2XFMqpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681446; c=relaxed/simple;
	bh=xeeBpRqXoliHILvdZkD6XLJhhcL3XEb7FkXR6EHqot8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PdwfrESTNJvSHn8Gq17pWaqy1Q6eJIxK3eqkpnWnzWx4dVAUC3eexsZlCzQ2vZ10BrhO2w+jwGXRTOHHooiY/oCSeplHMzDXXW4dGp8yk0s8T2SQ+DZWF4AzkWEqgz4WhA4AW1HTWcfVdOJGJ88sjWrSWhvOJz8TCKej9SAyrNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NykjO+wE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752681445; x=1784217445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xeeBpRqXoliHILvdZkD6XLJhhcL3XEb7FkXR6EHqot8=;
  b=NykjO+wEWIzAX5J6iFvjgtLkqRgYKPCGg4vyOv9F0erl5nYMfvHaDT6I
   3iVAJKzmXN+EglimCUNpK57tgSTno9hPybXvZ5LWH0ICTtTGwHbIZue8T
   FRLecfjIW/JdRUABLEdcARH9KFhpK/xwnw0ISvS05Gvb5BBQ6uw0PJAid
   S/n4O9xAsSVdX90prHQeUlynP3cuRe+HcjS4EFEWmyTIIFdZbjFmWm8Dn
   HFWKnHX+lcYH20uVQcsgipNolJL03w8mP0VtA3hSZbJt304GTWpYp1PC+
   lawrv6AAZEL9AWjIigGY1Pdj635c2OGiDA3n0Ek886G43F5H2Y40kFB3m
   g==;
X-CSE-ConnectionGUID: jB+d+7hxQEy8H1R+jpZccg==
X-CSE-MsgGUID: E22kK9+8S8qEcmssA/MfLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55080986"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="55080986"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:56:47 -0700
X-CSE-ConnectionGUID: qrjShXEpTl+y+4HWdPnoiQ==
X-CSE-MsgGUID: FzkbfGQHSWeV68VJW6Pn1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="156948639"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:56:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 08:56:46 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 08:56:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 08:56:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYuvWkL6iRvmMIs7eovqZCYdalWyUJeRosyNfuddAoOtlzKR/kQTgIiS2iRSgWmjQOzcGqRGdfqwUUi1dVX4SkA0bs/swsyy+WccLFt6Jjah/ESF3IxSteceS5VBjTMZa84dY2c+2OGx1NbGGaXlYNTEyTMbmMzwDLuHi8S8mvp827NmWUxTdf8I4DazS3TxP0W3AESv5l79e/oUl1By2Hr+jb6sOehqgjG5sRROv7nTYLHumNVUQgC+0+vp7MJjZWiFH9/h7jJdzaY3WtF0CBrz5lDOVD+WiErZ8LIKslPEKMTPpCUd9Ac1ZuKsu1oR/DWi0U6rKH4dxy3/T/Bf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNgL7zbId4uwen9hPfPxZH2drWkykGXqjRGk42EtuJU=;
 b=HwQXaI/fCtAZGz/HXRLfj+bPOF0UV5hsM7tZYeNE5xMh9Kzfk0TjfdZmrO0exw0yBOKYta8mfzq9nNyv62TtP28KZLByklDj3zAu4vDb616Pgb/ub9z+FvOmsXZIOeyyQwvpvgPKy/gG1OKcpqQBKv/DGuueTZy/yegq1ax8Tg9CHnHy5xmSKRCtjMqk119O+OSMKJ+fT/eEuMrqNb+BXKQF1F3am/e7NEcVtQGHgj/ZI4Km6IC4vt9V37pu7mC5x36S/DUlgYrS/v2QPf77evnfH9yc7MWNbVrsCnf90HCIbODo1tkdAx1Vo+6OWxbpAYu6JAD+MyDXO9R3EEaY4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CY5PR11MB6161.namprd11.prod.outlook.com (2603:10b6:930:2a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Wed, 16 Jul 2025 15:56:39 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8857.026; Wed, 16 Jul 2025
 15:56:39 +0000
Message-ID: <5e9789ae-9a2d-4c95-a1c3-db489d132559@intel.com>
Date: Wed, 16 Jul 2025 23:56:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/fair: bump sd->max_newidle_lb_cost when newidle
 balance fails
To: Chris Mason <clm@meta.com>, Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <peterz@infradead.org>,
	<vincent.guittot@linaro.org>, kernel test robot <oliver.sang@intel.com>
References: <202507150846.538fc133-lkp@intel.com>
 <10abe013-98d6-4080-ac43-0f1e02aa41f9@intel.com>
 <c8c89226-f9a0-4cc8-bf7a-fa65a1fe790a@meta.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <c8c89226-f9a0-4cc8-bf7a-fa65a1fe790a@meta.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CY5PR11MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: ff38cd15-1f0d-4b40-b91e-08ddc481599a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWxnU2FDa0wvcUxwdzc5QkZiNmhyWDBSSFBhb0RIaTJ3aVpFSDZ6UlJzc3pn?=
 =?utf-8?B?Wjdyd1JqTS9sMGZ6aTFBaCt1eUYvV0dMazd3c05IZ2c1MnArWGM2ZXpLQ3F1?=
 =?utf-8?B?RlRzZmk1VHA4NjI2SUh1RndQTjV1Sm4vQW1FVVFWUG4vNDIvaWxuekg2ZnBR?=
 =?utf-8?B?OTBrb2VXWWxMelp4UEExMDd5OVQxQUFtK3JKT25OZ3BZQWtQdDYvb1VjWWVm?=
 =?utf-8?B?cmhkckdsV2U0RTU1TTh4K1hTRndYSjRaR0xDeGVoSUg5ZHFyK0dybFRycGZB?=
 =?utf-8?B?b3JwaitqSW9QN2VUUjA1WjFWbDZrMDFKTjhtcU0vRWlWeXU2Z0s5a0ErMWQx?=
 =?utf-8?B?MHhyWHFEbGZEcjlOOXBiY0oxaGMycUVNZ3c0Qlllc0RZVzJSSWxSaStuUWk5?=
 =?utf-8?B?blZBNUFleUZ6WWg4QU0rL1Z0eWplcytUK1FwRzh3L0Rlck4wSmNSVnllbG4v?=
 =?utf-8?B?UVNycHpHcnNzTzZwWjhWVEZIdGkzM08xUEdyMFNxY3hDbHNrajNFZkRlamNq?=
 =?utf-8?B?QzQ5QUZ3QktJYlJXM2xpMUtZNEU5czl4Q3lsVER2VUpwVS9YV1ZTNTFESDJa?=
 =?utf-8?B?azlORlIzT0trL2FFVmxhc3B5V3A0UlgzL01Pd0hCUUM3Y29GTENjV2FXREJk?=
 =?utf-8?B?ZFVOZjQxSytOR3BENEZScG9iSXhFQkx0YUtPUDBBWENGdUNudHQxcU9qTEpZ?=
 =?utf-8?B?QTZFcmZjWnAwYkxVbUpja0FJM1o2QS9sWitvOHFlYVNNRkdXMncxSDlTQWh6?=
 =?utf-8?B?Uy83SllKMjNsZDM0blFkYitJTW90ZkhrVlVSOXpzclRaSGw5RVk4U0w0SFdn?=
 =?utf-8?B?eEZEbzhqU3F1dktLU2hYZ2U4OWs1ZWN5aWtqMzNOUk1BV2J1WFphY3hDcE9O?=
 =?utf-8?B?QUM0OEg3NVNrdzR5QlpvSiszdjYwY20zdVl1U1ZtbENZcDJvZGc5Tm9QdHR4?=
 =?utf-8?B?S2k1OEpVMGx2N1RpL1AvWEJEQk9EdllmNytSdkd5bmVSdlJoV3BobkFGamFV?=
 =?utf-8?B?WU9QV0M4MG5hNEJ4TmtBVFlaS0ZaNW5lUWhXU253UzRWY011ekRVcU11cDBm?=
 =?utf-8?B?ZEFDa2VMcG5uVGttZjhhRWVweWU1Y0hySkV5UnprenNTVTJBZkdYQWNEOGhR?=
 =?utf-8?B?Z042T1c1dmVXUlBPTkEzVDNPc1NpSVhnQThtb3oyVGZEU2x1bmRPVzVDL05E?=
 =?utf-8?B?UDNOVmZjaXdubUVMZ0RmeGx1V3pCQVRleldUNlNrK01id1B1WVFGUmpWWkEx?=
 =?utf-8?B?WFpkc1ZzeUJPc2NEZHZzTzFHaXJ2ZFNZMkFmc1BZUngzOGZ1dElCcU54K2h6?=
 =?utf-8?B?RzZ6S2tCY25jdi8wTCtEVEgzTGtyL0hlUkFsbGJnR0ZTWXQzQ1UyRXhRYTRh?=
 =?utf-8?B?SjVJVkNGTkhXTy9PUEx3MDBHZlB6RXNKTHlOWHhYTzdTVnhOTVpoTmYzMzda?=
 =?utf-8?B?cWtTNzY2S0ZBY203dEhCWWtyMW5nSmdZNU84Y01EaFJlem9Wd25JUmdtQkVT?=
 =?utf-8?B?VTlpQy9RcUJFZmdvUkFDYnlaSVVWdDBaM0JuU01rT3JpekQ3R2xvVUxoN3RZ?=
 =?utf-8?B?WnBaV3Z1VERnKzBjQVVrTHUvUDQxSEVrSWwrMmN5WWtKMktqMkE1d2VOWTdV?=
 =?utf-8?B?YlMxVmp4SnNaYkFCbXNLeVlVaDMzWnY3dnptcDN0eGROOHBrMlQ5T3FSbkJT?=
 =?utf-8?B?WXhkM0s3Z0NTZUREVnJyZlF3dkEwYmdwQmEya3N1VEx1OVRqWkxFQXJhOWFr?=
 =?utf-8?B?SFp6ckc1RWJINXc1MzQ4elVvUFIwSEN5dTNvWmt0aFZ1TzZSTS9McDFlc2pw?=
 =?utf-8?B?M0lXK2NQNzFHUTFUSDBNU3dSamwyZyt0eXBEVWVnRE9SbWVxMG5FbGZtQ1dB?=
 =?utf-8?B?bjFFZENIOFVGdG5nOXV4bkd3SVF3V1l5eHkwODBNTkJPa1JNYk9FM0lhNzB6?=
 =?utf-8?Q?q2Ygp9WfJsI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGticFdEOEM1bUVkSysrVUIxQTVrVEpkK3Qyb0wzcjVVSVQxcWYzWE44bzhv?=
 =?utf-8?B?cThuU21USS9qTzk2eVkvQjRpMVFOWHd2OFFtSmI0NnJPa2dpT0J0Rm16bzdq?=
 =?utf-8?B?dC9tNlFZWEtQYXFkLzlNWld3UC9ZMDFKL0h6cHp1Y1lSTlZwTkNKRktXS1dn?=
 =?utf-8?B?VjE4aFRsZVJiV2h6dDJUbE50enY5OE1PclZQNTlBN3Q2SFNwVXZocUM5Vy81?=
 =?utf-8?B?Zk4yc3kxNVZ3NC8xelZnK0lydUY2R0xGTlpFdlZUZGVZQzZadDZ5MHdocFFj?=
 =?utf-8?B?Vk5LZ1gvdW9wWnNmSU1RQ2lFVWVkWVFZVWZYREMvM0tYTzdzcWxoRnlzSmdI?=
 =?utf-8?B?aGhiZzQxdUlxUFlaUVpsZUVFZ3owSGVpQitYbXhSaVhLaXFQdkQyNi9KWUNC?=
 =?utf-8?B?c3ZqUFJCVnFRUXpYR1JNRE96cVVxd3dvQVV6V1Q3am1ITkpPbXRNSGRLemEz?=
 =?utf-8?B?b2kvdjR1Qy9CRnQxSEUycnZBUjBGZ2cxS01td1RocEl3OU5vcXp1QklBdGVQ?=
 =?utf-8?B?dWU1RUgwWFhpMzd6eTc4RWpLUkdKVi9GMzJpR1laOGtlbnA5SXVSTFN3YXZH?=
 =?utf-8?B?aDNJV2YzRy8zZkY0azdqSU81c201M0d0UU5sUDQ2VHhkYmhhcVJWNXk2SWY2?=
 =?utf-8?B?a0RkQkJDU3lKcGl5SGFaeXg3RWJLTnpTZjlUdTBNV045QytyaU1pSW5rSHc2?=
 =?utf-8?B?aFlFdlQyNGJTT2lEeVFZQnZGN3FCUEY0ejA1dWgvWWhPbFpJeWhwaXZGa3JS?=
 =?utf-8?B?QWFydVJPcG9ZR0dwVjNQYnJvTHNiaitqREJjbmZnMXZFSjVTUFRlVzgxNUUy?=
 =?utf-8?B?VndBbW5nWDRTSE5CV0xoL2JBWjBQY0dGZXBXR2hjL3N4aUFwVHc5R0I3U25N?=
 =?utf-8?B?NTJ4YVhOTlJTSnovVGhncVhHRjlJdXE1aDBjclVCZ0tsdkRtT3hmRnFFNmlR?=
 =?utf-8?B?TEx5dy9LZi9IejhlNkZYdFo5dVpTQlo3eklrdkh3VWV1UW5PUE9DY3F0VUQ0?=
 =?utf-8?B?bXBZVWZ2MnZkcjhnUnllYkRHT1A1Sk1XUjZSUXV2aVE1UjZnUUFSOUVHU0dn?=
 =?utf-8?B?RS9PUzdvZnBWckdUV29jWTlyRHdLTTgxWWRCZ0F6ZmpSQ0Z3Tmh4RWZONlBy?=
 =?utf-8?B?b1hUdFE4djBmUk5HYkZ4RTVXT2NCbXlVeGQ4V204Q1VvMGxmNnlScVMwd0th?=
 =?utf-8?B?SklGQkdtRG9MaVNWQngvQ0VjYTQwamRQbkJObjdyNlRCOUdaOGRnQ2kyeEox?=
 =?utf-8?B?aXBKTTllYU1GSW5jTmhLUE1XVHFPY3hRdG05VVRsNXdTZGZHdE0vTU9BeEdj?=
 =?utf-8?B?ZVc3aGlFbHY3aGtIZ3YzUWtqZUhVdk8wenV3K0JBSCtLQXRsWFhwdktrM3BD?=
 =?utf-8?B?QlZpTkQrR05STHBOMFVYU0paM3BqS2xrdkZLU0hwSE5hRWtJMERLVjcyRFdv?=
 =?utf-8?B?T0hZVnRLUk8wMDc1cWt2dThoSEtvUlo5Y3hpamNNMlUzVmJSdm9RVDZHQVhR?=
 =?utf-8?B?WVBJTDNlNHF5bTM5RVM0ZVI1M3Qvamh5NVFZSU43eCsxbHlRSmtIeGRvaDhV?=
 =?utf-8?B?NjJ2N0tMTC9xdnhRTkMvWmpSd2V1NmsxWlBXVnY2TUc4N1ZSbko5azlGZXlN?=
 =?utf-8?B?YlZhalpmckMxK290N1dVSFBzTm5tem9IRWcxUnhCNVBZSExSZ1Q0NFlLYkwz?=
 =?utf-8?B?SGI3cjcyZHdKaUtJZmVScld1ZFpxc0FzSG1vNGNmQmhUUDhTMC90K0UwWDRX?=
 =?utf-8?B?NXNqcVUzZGZrQ0dNMUF3amkwQS9lcGVDREJtWWFSMU1MMXNBR1FaWUxVeVgy?=
 =?utf-8?B?dG9OL2JQNFByN01YbmtwV3QzTStLN2ZoVDFXUVlCV2tYOTRmb3p2VDJZN0Qx?=
 =?utf-8?B?MjF6K0N2QUFPWEF4Q3dheEk3M1BybHhhcWtOcnBONHN5UExqVVMrMWd5THZX?=
 =?utf-8?B?bFFGMG5oc0VNUlZPRkhhRXhUSVVPN20vZGYvejZyYjN3NzFWMHJ4cnNmYnV6?=
 =?utf-8?B?bXp3VVpkQng5U0Y5Z1ZYY29FUmtYdEJiaDlhT3BFUjF0V0ZGMUYvRHl5OSsr?=
 =?utf-8?B?RzQ4UE5OK1VoMVJaWU42YW5zK2JSNzJQS0o3YjZCaWV2UHF3VHVZdjZOWlZC?=
 =?utf-8?Q?zd7zin+vgvLd7jQUot7XTiVKr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff38cd15-1f0d-4b40-b91e-08ddc481599a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:56:39.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/SUelOK21eP36JnVzpfcfnGFVp8imazYjDBvEetuB2ZJlWqEQYDlzLqowcL0yQ2W0AuIk/Ef3IbDgjVN2EF8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6161
X-OriginatorOrg: intel.com

On 7/15/2025 11:38 PM, Chris Mason wrote:
> On 7/15/25 6:08 AM, Chen, Yu C wrote:
>> On 7/15/2025 3:08 PM, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a 22.9% regression of unixbench.throughput on:
>>>
>>>
>>> commit: ac34cb39e8aea9915ec2f4e08c979eb2ed1d7561 ("[PATCH v2] sched/
>>> fair: bump sd->max_newidle_lb_cost when newidle balance fails")
>>> url: https://github.com/intel-lab-lkp/linux/commits/Chris-Mason/sched-
>>> fair-bump-sd-max_newidle_lb_cost-when-newidle-balance-
>>> fails/20250626-224805 base: https://git.kernel.org/cgit/linux/kernel/
>>> git/tip/tip.git  5bc34be478d09c4d16009e665e020ad0fcd0deea
>>> patch link: https://lore.kernel.org/all/20250626144017.1510594-2-
>>> clm@fb.com/ patch subject: [PATCH v2] sched/fair: bump sd-
>>>> max_newidle_lb_cost when newidle balance fails
> 
> [ ... ]
> 
>>>
>>> commit:
>>>     5bc34be478 ("sched/core: Reorganize cgroup bandwidth control
>>> interface file writes")
>>>     ac34cb39e8 ("sched/fair: bump sd->max_newidle_lb_cost when newidle
>>> balance fails")
>>>
>>> 5bc34be478d09c4d ac34cb39e8aea9915ec2f4e08c9
>>> ---------------- ---------------------------
>>>            %stddev     %change         %stddev
>>>                \          |                \
>> ...
>>
>>>        40.37           +16.9       57.24        mpstat.cpu.all.idle%
>>
>> This commit inhibits the newidle balance. It seems that some workloads
>> do not like newlyidle balance, like schbench, which is short duration
>> task. While other workloads want the newidle balance to pull at its best
>> effort, like unixbench shell test case.
>> Just wonder if we can check the sched domain's average utilization to
>> decide how hard we should trigger the newly idle balance, or can we check
>> the overutilized flag to decide whether we should launch the
>> new idle balance, something I was thinking of:
> 
> Thanks for looking at this.
> 
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9e24038fa000..6c7420ed484e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -13759,7 +13759,8 @@ static int sched_balance_newidle(struct rq
>> *this_rq, struct rq_flags *rf)
>>          sd = rcu_dereference_check_sched_domain(this_rq->sd);
>>
>>          if (!get_rd_overloaded(this_rq->rd) ||
>> -           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>> +           (sd && this_rq->avg_idle < sd->max_newidle_lb_cost &&
>> +            !READ_ONCE(this_rq->rd->overutilized))) {
>>
>>                  if (sd)
>>                          update_next_balance(sd, &next_balance);
>>
> 
> 
> Looking at rd->overutilized, I think we only set it when
> sched_energy_enabled().  I'm not sure if that's true often enough to use
> as a fix for hackbench?
> 

OK, overutilized is only used for EAS.

I just had a try but can not reproduce this issue on a 240 CPUs system
using unixbench:
./Run shell1 -i 30 -c  240
will need to double check with lkp/0day to figure out.

thanks,
Chenyu


> -chris
> 

