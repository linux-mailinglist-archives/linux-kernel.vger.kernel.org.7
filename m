Return-Path: <linux-kernel+bounces-801851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BADB44AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EBF1B2115F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384BA182B7;
	Fri,  5 Sep 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9YNLiGO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7820134AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757030785; cv=fail; b=m+pmWZ+VBVysXdRq6VQxFKnawBahjeI6FbIkULQNoQ5DdznXYCjSUVT/LWuQfXtn62tSSIrxZjWOJUAb4ad8OL31RnuurAczsr4VZm8cpqrnPFl5oEYHUO5ot1/A/sad/UrDG9LK5mKbghd4n9tgcsQX97t3RBMDpiXN+Yhii7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757030785; c=relaxed/simple;
	bh=+L7ULuLeDvh7twenaMe+1j36Er8cZ66Scl6kwHZ+k8s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4Gnjl8Vu08HMyXvInEB8FQY5U0DNk5je4vxYQm8+WGn8JxYolNaz9IdL7YvDxzn33VqkMfiIE0QlkxLqH5nd2e6aYjesZLtEBreK22DftXAma9oZZKQMNmmQMJ9c7GYdOiFRoVen3MLxlBqWuhpwdP1ozK0COSg6ilQ6Y2aJTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9YNLiGO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757030784; x=1788566784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+L7ULuLeDvh7twenaMe+1j36Er8cZ66Scl6kwHZ+k8s=;
  b=h9YNLiGOwEkbQ4iCBPtxhUCxVcJkUtsdNEyH1LK5FhUiKTJYcltsDQ8u
   9d2bpVpkpkGcMs0fQd9ABispxbN1msS6vOQ9YnHUfS1AAY7RAIFTDjf7l
   CTkiVilbzIjhesJBVtkhG7flvR6aZ6dDK3cEKXtLSyFuHIHqL8fgH4ddT
   g0xSKkoxDtUhwIrIawW5dYfkf3aeJ4UJGkmAW7YRDngaAAHUSKeWvPB3A
   +S+g8D0eq3SWZtBaM9uYk2ZBIwid+GlOWcnz5gQmRnIsyxUqBKyX7bGTU
   moNT7WyQnipHCXt1z7AOmLfo0QLnhzEGRkIuYRLKjK+7hZirRi8QGHiTx
   g==;
X-CSE-ConnectionGUID: PNFYhqGoRumnArGtROcrGg==
X-CSE-MsgGUID: PdO5cuwqT0esn9AGGWfyyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59531852"
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="59531852"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:06:23 -0700
X-CSE-ConnectionGUID: YAYfe5jaQvaSIhoY+r62Bw==
X-CSE-MsgGUID: onXLVcAbSCe7Zj5Zoavk0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,239,1751266800"; 
   d="scan'208";a="171319807"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 17:06:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:06:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 17:06:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.61)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 17:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD4On5Z4fBI27qnja7g/hNXH082XXSqgPbDgIEm5D1SMvCVdGs0iYshUUClMaDNaWOE7MF+cxD+Z0z6wj41SsCwcz4sR9I5AuXdr0haS2oFE8dr+acuA9jaoVWR2PBDktJdMOcWSEXu6UiTLYd4U2RqIDs/kHfFB+IyXM501Pem5MjMKhbm4OPb/mJ7LqYy548mUh2uScy2xkKnN01hyTK7CKlH3ESi+/wDHJAZObOEht9KogJEWdVtHCxnmROFKJI+TaSWiexxVH4QDr3cgylQ/QMcBSOqG5DerF8pg9dyoFaRJJXPUjNb/rXKXwLfw3PiGyV8LCDd7Q80bX9TdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh/16oUKbeDeH9sjE2Sj1aQ3+nETfxjhCkyjAXzIgfg=;
 b=Fj/KrZLQOCAntKBfeqf4T/srdlLCBJd27KCPcC0Ho06LKlOC3pRceHXL5PYJt2C0yZM9v/p1cUp+ES2GjPkE8zHIbmgP16lPsQA+o1xm1J7p+6ZjPKmScy5bIcZYI6jFvyikoNKBDnREpaR8OfPlU/hPYwNmMA9K0wj8ww3btSEu1Bjjy7htrNKvCJIQqidPp53TO9vzxBiosyLQQqI5i+kfB4ZIb3jxrq4IhRO5VIA3SUcne/lR8gkozZCL+xMmRBPlkNoGOD5nUWtGUapuo8l2yumukhAyhJkzFkv6u5I2jnw0RUXrR5RMXbwyAyei5BafimwyLh+cUcdRy0WF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MW4PR11MB7030.namprd11.prod.outlook.com (2603:10b6:303:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 00:06:19 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::b1ef:c95b:554d:19c9%6]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 00:06:19 +0000
Message-ID: <1c7b6ff9-4636-431e-95de-c853bb3b01c2@intel.com>
Date: Thu, 4 Sep 2025 17:06:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] x86/microcode: Introduce staging step to reduce
 late-loading time
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <chao.gao@intel.com>,
	<abusse@amazon.de>
References: <20250813172649.15474-1-chang.seok.bae@intel.com>
 <20250823155214.17465-1-chang.seok.bae@intel.com>
 <20250823155214.17465-3-chang.seok.bae@intel.com>
 <20250904120810.GJaLmBKtFBh8wke2Bo@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20250904120810.GJaLmBKtFBh8wke2Bo@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MW4PR11MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ca48a20-1626-4438-0a00-08ddec100a2e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDRTNEkvSFBXM3phcmdheGl1NklicWRPblBxSXp3Z0laNmFpblZvT1l3OVR1?=
 =?utf-8?B?QlJFNFZOUytzaEZXOG1GdXQvMktIZjk3elRJWHd1VnhDOHFqNGovUDZTejdy?=
 =?utf-8?B?a2xseTlBY3EwcUl6Z0x5MHd5TzkreGdGSXN4UldENjVucS8rai90WWx4SCtX?=
 =?utf-8?B?bm0rSE9YdDczQW1iL0hoYXlDL3lscWljd2c4RlBRYVFSYzREa0JXd2M5Vjdw?=
 =?utf-8?B?NE5yRGxNWHFRc3dZTzNxYXNGUTR4RzVxdTJmdGh3K3QveFlTaGNrTTc3cHg1?=
 =?utf-8?B?UmNPd1VWbGdBeHBtbldya3k0T0YrNmF1andkQ0JXSFJXcnlqcm9lQzJuaTNn?=
 =?utf-8?B?ZmxPbjJmRHV4T2lnUEMvVXlkSnNhSjZRRTloR3ZmMjMrUVJDd1VhVGdwbHRM?=
 =?utf-8?B?blpxMXhobFc5MHpBVVBlWVV2QU1jSWs3VHNhRmNseTBKb0UzRVJCdVVyeGdS?=
 =?utf-8?B?Q1dCYnNzdXVuQzdqbXV0NE1FQ1dHc2o3R3d0VkpWbGxUZWc5bndVMGFkR1B4?=
 =?utf-8?B?MHlXaDE1cW1OZWxucGJtelFwYnRzbmJHZVl5dThKTmF4NUFOTkk3L1RUNGNP?=
 =?utf-8?B?UGpDbjd1bmxPbzZXdWUrUnhMM2R1Z1dLK2lHU0xkWjJwSUZGeDIxalZrYmVC?=
 =?utf-8?B?eU0rY0hrRHFHdTN4anRPUjhXd2daV3U5dTRvVGZOSXl0TFBFRUQrVWl6K2Vw?=
 =?utf-8?B?K3lUSm9UemZGME92MzR5MytoU2V1dXIrcmhOZitvcDJmZkF5TGNKZWlxZ0xI?=
 =?utf-8?B?N0JPNmc5RVdQMmRpWVhUaDVGZGxGd2tnZC83U2RIbUowRThMNVkrN3hoZm1u?=
 =?utf-8?B?RmxXZEwzTTdsdXlIM3VNbmJZdmp6RHRXN3RPbGZaWVVoSGJwZ0ZUVk8wQXVn?=
 =?utf-8?B?a3BEbmJ5a2s1by9wV3VoL29qUTZGY1IxWVRaZm5iZEJpdHI0dXVTUitCVUZC?=
 =?utf-8?B?a3drb2Rmc1hINEdxWlNkdGptVkVjQlNZT1JKZHUyMGxPK2lUWmF5RU9hbVhz?=
 =?utf-8?B?NElrSHcxOGZkTzBRSktxY3g5OGZQdTFFT1VTc210ZFpIRTRvSTJkUkx5dTRv?=
 =?utf-8?B?SDVwNW5DU0gzNzhUR05xMlFJU3R0U2t0cm9wam9HSEVQS1NFRUZkWlJHcGJT?=
 =?utf-8?B?MFJqdzFtQXlXbnFQRzY5eWhpUDFHQlU1VU1nb28xVTRNenFCcXMvREpnTHEv?=
 =?utf-8?B?VnRvSm9RVkJCemhObjFHUWoySjNLMG9tbjY0OGt4bWJUQWE3bGNOa0JqMVE3?=
 =?utf-8?B?R2xyUTJVL0tSUW9YZ1I5R2JxeEhSYktvTlk0R0l1bmpSbCtNQ2VjWVV2OEpV?=
 =?utf-8?B?Rm93ZTYvQjd6TUN0VHBmb1o2U1VWQiswYlMyUW0rWkhmc3piOTl5czBNT3M3?=
 =?utf-8?B?ZStLK0ozMnlZdjJnL2dHOVFuNVZiN01jQk5nVERuTWk3VGlaM0pCTzV3Q0Mw?=
 =?utf-8?B?SG9wNzVZbEc2TjZIZVlOTm9BWXdsN1RSRnRJYTljUXlidDhoQldrblg1WmQx?=
 =?utf-8?B?MVcxc3J2RDhpZmpRM3F4cHJ0R0xhZTFOOVBEN0lScEl6dUQxQU5SSnRyc1F0?=
 =?utf-8?B?RThNMDlLMHVjWTQrYUI1bks3ZDA5TmNLbGFnL2FQaXhWeWxBQkI5TTIvdzNL?=
 =?utf-8?B?bmJFbmx5b05DbHBWU1VXcy9SWVZKWWw5UzgyTGRTcC9KNTk1U1NIYjVJYWZJ?=
 =?utf-8?B?VnJIeEE2M2ViUEQyY0dPYS9SSWlOMjV5ditkeXY5RGxVTjVIS3hBc0xEMWRW?=
 =?utf-8?B?MmRlU2ZqdHBBcE4wTjRhR2hvVUYraG5kaHV3ODc2bEpqUFBGcU0yaEpBU0pS?=
 =?utf-8?B?OEs4YjZPYjVwN0l3RG0yRkJpL3ZPeWpVN3J4aTJSTHVqZDdXUlFVWlAxaVFh?=
 =?utf-8?B?TEdGb2I1UTdqcXg5SkhDcWVmSVZWVk5vQUp3Z3hqZ1J6OXdmLyt4WjVmYk9P?=
 =?utf-8?Q?LseOnPT7uyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVY5VFZOZmpmVFlYUGNxYUZLZ2RSRkg4NjdyVXk3RFlmd243Q0d5bGg3Q3Ns?=
 =?utf-8?B?UGViM25zS3NnN01hL3JoT2lWL2gxLyszaGhxenF2bkhBQVZPUk02bGRpVXVl?=
 =?utf-8?B?NnlUbm84RTJ0cUhYcmRxY1o4WjNkRUlDQzBzcC82K20rYWRLVUhKMFhjS2Ey?=
 =?utf-8?B?SVhYN0U5Wm9yQUhyTTBLWndzMFYyN2RueWpySGhEQWs1SEpKY0N1RmU1L2wr?=
 =?utf-8?B?QW00OWV4M2Fkc21uVmdtdFM4N1ZsY0JSUjYzZWQ2cUZFdWVsREwwQVdOZ0FH?=
 =?utf-8?B?aG8wYUN0YmN3WG9rZEtERUpqY1FONVhER0NsK1RtbFR6c3Q0bVg0bWlsbm1P?=
 =?utf-8?B?V2l0Q0xCNDRiWUlzMTJSRzRQYkN2K3ZhNXN6UTZnbis3QzU3V0pqUUJYaWdR?=
 =?utf-8?B?MGdxWjl2bE1EZXJVaGNuTmN6Z05mZlpmamdtcG5oN0JCVEgxc3hOY0Q0Mlgv?=
 =?utf-8?B?aHRwTkFHbE5BUTFVZ0VCQ0xab2RpZzEwY0ZrUlRYdU9ZNnpZOFcvSWxLbWlU?=
 =?utf-8?B?RUV2N3M1UjBsOTVucFNTNEVad0QvZWcrcC9MMzBnV1U5YVRTdlhIN2FKNWVu?=
 =?utf-8?B?eVdHcWtQN2hKSFdVaFB3ZzJ3RnBSUHhZQkdZR0VvZlZxSWEweHNVY0pkaVU3?=
 =?utf-8?B?bjBFTlcvYjZsMEkxZ2JaN3VlamZlaUcrUmJJMENpL0Q0N1FGcUJqcjZQbGlK?=
 =?utf-8?B?SzdKaXRYc2I1UWM0KzZKYkJsTmd6L20zUEU0ZUZGaVRjTGp6M3d5cTJHV3FH?=
 =?utf-8?B?bGZMekh1cEpCaXdIdVZTcUp1VnVMcXFYakdCWm9JczVTQTl3ZlZ0VllpUVFt?=
 =?utf-8?B?RnNMaUlQUjFyb0pCVzdUb2tIUG1iLyt5RUYwdS9CMnNsNFpheFAvaUxic0Ft?=
 =?utf-8?B?YWNqVDRFeWw2ZG01b2JSeXpDQnJ1N092OTlwTUt4RHUxQWZScHI5THMxOFBU?=
 =?utf-8?B?bVJmeTFkeHloY3hFZFlpUE4vWGNVd2ZMeXl6L1BDbmljY1hXMURmTXNCcTNH?=
 =?utf-8?B?eEQrYW9lQXVrdnVONEc1SUQ3MXFxcU5PcDNDb3FXVStpZ1F2eWJXNEpMSlM0?=
 =?utf-8?B?eVRSTyt4ODZXcERYcDczRnVpUzNrYk5lME1wV1NBcVZUcFlmUkxsQlVBUyta?=
 =?utf-8?B?QXg1R1ppNCtGajNJUGV1QzlzM0VaNW1GSTRaMlpIci9kRnVtakNpYzNpV2Ji?=
 =?utf-8?B?Umk3N1p6ZnJRU05CR2F4VG9TMnlMcjF3TStyL1F0UTRnSGQzSWM2U0Z2VEtU?=
 =?utf-8?B?MU1HeVAvY2hrbHIyem5sa3FYdXUzaEVaSmpJUTJaZkFXUXk2TFdkdkJZbElK?=
 =?utf-8?B?UkFzQ2Z2VTBFUzVCUHErc2VqOWNtUWtYTXBCNkxMVldlR1ZRcWZmb05JSFUx?=
 =?utf-8?B?bTl4bDFSOWhEem1qSjJ4QmFqaS9SOTkrcXNKeVVrYTBsUDF3aEZCVThPZ2ZM?=
 =?utf-8?B?RWk2Z1hNTkl4WXBTMTlYcEJyNjhMNWM2U214Q1l0bDFzZitBUGNyMGZtbC9O?=
 =?utf-8?B?NExBTFVYb1EzNWtyODlwOWdrRnBScGFJVFU0RVVwS0R5WDhFUHZrQnVOTW5x?=
 =?utf-8?B?dms4OW5sRVJOSTVERlZ1b01nR2xsOWZXWEZWRVQrcyt1NjQ0NXRoeUtxVFFs?=
 =?utf-8?B?ZWNxMXFRa3Zaanl6b28wV0tIQUhpL2VHeDVYMU94Q1ZsY0p2RmU0eWlXaXA3?=
 =?utf-8?B?VDhWRkF5eXZvVEdmbGs4aVp2Y1l1aDI1K05YZWFJQzV2QU1zbFFsaTFXbGpT?=
 =?utf-8?B?ZGNFcUpmVVNxM3I0R0gyZEcwMmt5eGJwQjhGSVBSM0dpUVhsT1dheFp4WjVP?=
 =?utf-8?B?cE0wM1crQ2lXNnZlMmF0V2RKNGFZbGZ0ZzVSM2I1aTc1L0VWclRncGdLZ1l0?=
 =?utf-8?B?R0wxTUlHMGpva0c4K25lbkEranM2eXpmOUxBZEZxUGtNWVpYa25GNTlpUWts?=
 =?utf-8?B?Qm8rNVNlZGJQd0o3RUpTYno0a1VqQW1ncytZamlUYzV1QTBuZHRlUjNZN3k0?=
 =?utf-8?B?UW0rWEg4cGVnS2JDY3NvY3pQcXR6YTNVWkhCL1RpT2dXS3hhaEg0QVR5Um53?=
 =?utf-8?B?ZkdLdnlLdGVnQnNhWHh0R3hBTERhL1lFdHdMQWIrMFpzUE1yL1BwdTIyUWtZ?=
 =?utf-8?B?VlVaakpxVU1hdmJRMkd1dm9ldWFuMFgyU2R0cSs5UW50UGdMRXVNOWdPQWk3?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca48a20-1626-4438-0a00-08ddec100a2e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 00:06:19.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaGQ4Qip8iREMFZMMP8RWRhB4dgbXStFveGBT2K3OM6sUuePMQdnvSK+3auCf3HV7Cm9Y2pBBG8RRorlueVM8SOz5N6H7km++NigSfqEhrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7030
X-OriginatorOrg: intel.com

On 9/4/2025 5:08 AM, Borislav Petkov wrote:
> On Sat, Aug 23, 2025 at 08:52:05AM -0700, Chang S. Bae wrote:
>>
>> staging can significantly reduces latency spikes.
> 
> "reduce"

Sorry for the type. Fixed.


