Return-Path: <linux-kernel+bounces-836012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD0BA8942
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05471883355
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19134286438;
	Mon, 29 Sep 2025 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UomoNqRF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD28504D;
	Mon, 29 Sep 2025 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137594; cv=fail; b=QudoGQ6DnyNKWWnL2LL/12iXtO+j+CcdnJrYpfd14HEKblJdnZw4McMOly+iJ0pAyqj7ZJYh1hi+xaP0S0dUUvpY9//hw7ncXZaSz3NexIzGBQcksmE9MoUHAKhwZFydpDyhFdotNdPtkORZre3WWKG7Vhel/flpQ9bhnGuUdSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137594; c=relaxed/simple;
	bh=f7l2D3qATFFf5x5l6E/TyaFPpULF0XF96d4DdQI2g0M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjcMNid3vt9iRkr3hCATNkRDSoFBUF8iw8ffCnq9h0DKy24ybXdCyheTjsF1npENpR0XiIFoiEP9nGWHPkw40h5eTxVGmisCQz5xaDcBSFyQlw9+QMcFZjkgSCwVCwDH1Y/CRQ7y8oSeEELX0gP+O7BK7nr8AT9JbmUv9ifvqH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UomoNqRF; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759137593; x=1790673593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f7l2D3qATFFf5x5l6E/TyaFPpULF0XF96d4DdQI2g0M=;
  b=UomoNqRFCxY1p2muQU1KfevQBpeKZBqHhSqhQIL1woWh/zc3/7DjCj4A
   C4mmFs2DebpCcAA43Z8DUiluZrAHVG3XN9sEOhp//PtTbXCqjNCWNOt3m
   FrXzjgbezmwxF77tI43tU5KtCPu9FNosksZk3c+EANcARtjQc/wdynETX
   BcafQHhDsRbYswpl77ApQOMUuc1mJlKfo0vcRiYaNcPYB1g0hCd0MVJMH
   FVW515PUrF8QPFUOLiZAMiu3Yl4/5mfFqFOja3jCmYnH86feGgiCpfkp9
   elJ5lvFq36krqZilj5Wqb3cY9syU55BHgRZ8gdT3oMmNt9iuye+HCbaXy
   Q==;
X-CSE-ConnectionGUID: s/TEg1l7R4W1IPHD7/BPjw==
X-CSE-MsgGUID: c+1B0x1lTlyKC+UNLpKqKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="86820772"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="86820772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 02:19:52 -0700
X-CSE-ConnectionGUID: Wu1U2UhyRRq3Zs5InwE0Pw==
X-CSE-MsgGUID: 6XPhWPfgTfm/ce3fso0NAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="182600940"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 02:19:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 02:19:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 02:19:50 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.10) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 02:19:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JY7mZh0uVZKaXLaiq8fhWk9e989lxBcb8yISFu6M9tHrYsk2VLz5eqij+Y10eKlsugioF641VwoufMolx7VvxeqO7af/v9LjXQ+uYuUdEuyfnkaaCb4YSm4QQGJrZpaWbxSiUShCOpnK9QCrc71LeVuhKoEB7lY/IMLBZKGYJdKaWS8FG4r7OeQ/4d7/iggQYWD4ERl14gfLOJSucf4YZMEqYF+G+zOnCc64yZG652Z45xgUiJ39wXGz1UEfd/sQyRKnPf8yCFBp7s6glWTG6WYa9qUD/LXu7yYqhLsxjMEqQlM0O5vBh91FCGitTBq+5xInp4vAH24WQtzUu2/3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt35fZC9w3LC01BEXM9WmfQsBxsoMUGHGt9t7GWi7YQ=;
 b=VLG649SOdjliobeMivu6m1snKVh9MrHut8b9ajbeZBs1ZcmwOTGeCNiLEcQNUgtlX+MynVbrU831rSo+ferzxbK/nAW6Yybcs5CtTbBPwHQA7CfuP5cq1p6EO67lrMNrG2/3yJ62LiTIOIlJO5338XFvViMDkWhM89t6bIaOOasSP8IX4NQOUlsYJHM51KTyK4XcPMhlW4JNRLcDkPCdBpSbpQksG1Pkvcc6F0J4Y/uSlHAJzONjQm2FloXhs8nFe1Y9nZkUlndiky/qyYkYWjOrOBzdRtqCBCupvd4hnq+M0r/u3cx/pmdvgu/Bfnb0CjaqSdx26HkTWREC9cGZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ5PPF3D06B1BFF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::822) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 29 Sep
 2025 09:19:43 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:19:43 +0000
Message-ID: <02647276-dea2-47b5-a271-7f02666e0492@intel.com>
Date: Mon, 29 Sep 2025 17:19:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: "Luck, Tony" <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, Dave Martin <Dave.Martin@arm.com>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <aNXJGw9r_k3BB4Xk@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ5PPF3D06B1BFF:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d2981d-d1a3-4bde-1d8a-08ddff39530e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enpIUVJHRUtFckNoakxobGNYVmpKMmZsY3c0RDBBeGpDYWpzUWtOTG0rK0Jz?=
 =?utf-8?B?cG9FOStoVndoRUhlQ3FYZDBuNlRxYUdGc3BxeHAyNXdacDRwd1RDSEZJekhw?=
 =?utf-8?B?V0k4VW1lTk1McHQzb2hvMjkrRHJWakZvcFZEcWEwalpFZ3dFcWt0NkwxSjZE?=
 =?utf-8?B?aGVORS9zY0pEOVpPWi84dytoVjVadUNpT0w2VHZRVjFqRjFLaUc3aGhRUTdV?=
 =?utf-8?B?M1c2U0ppMVhON2Z5bVF5QXY4b1l2cWk5YzNlSkd3aEYzM21iUkRNY2xtbklI?=
 =?utf-8?B?TjBadkM3bzNtUWZ1NjVLeXhJMXkwS01vQjRTMDEvdmd0V3cybS9Gc1VXWUVS?=
 =?utf-8?B?UzJIc0xHM2lJWTlSZVAxNlplS2QvdXRheVhEekFwcDA2WXl6SzNOalZaSWlt?=
 =?utf-8?B?U2RrZU10bmJFM0dkZElnelNTNW5kOEFvajVRMDdDZmFiV3dib0hRcTM3Wjhw?=
 =?utf-8?B?SXlOTjRsdnV6SEJaMXRkbk5oZTlLTGdZTlNZaGMrektTQVRqNTI0RnpnN0Zm?=
 =?utf-8?B?bnZ4UUFTZFZjc0hlNTYvZzQ2Um1NU0FFeHZZK0FtY0VHeXpVTzYrMlRqNTZD?=
 =?utf-8?B?RURyOHFBdkdzUDhLZmxSZlVGTEhES1VYR2lGUk5Ha2hhakxxOTgycjhqWGwr?=
 =?utf-8?B?U2UwK1pNK2hPZXROdjQzT05PWGcvTENCS2Z1RU5hSnVyalpxaE5id281RXJ3?=
 =?utf-8?B?QzRVc3JXdkpKYjRaUlVPNEZKNlQxVlpLakE3N0dXUWM5dFVPd0dEamg0S3ZI?=
 =?utf-8?B?TmtwNkl3YVptWHdZUTNVMTZrcm9keGluaDduQzFyUGtaYjkxUld0ZGZSOGtI?=
 =?utf-8?B?N0pYeDZXMURad29zZEIvbVRyeGNGSzZvSzgvbDZIcFN6OVpDYkpUc3V5dGJ0?=
 =?utf-8?B?VzkvMG0zY0RLRlZQOG9qS3VMVHlJcGFQbWxWdkdUZWsrMEY3ZFpwVTh5cG9y?=
 =?utf-8?B?c3dEbk9GSDNBaklSUE9MS01ESitBaDRmTFdiSnZXYUdEU0J3bzZGbVlYbCsw?=
 =?utf-8?B?b1cxMmhXUmdadS9BUDBVRWJjWExuWnVOYlBvZzJBTDVEV2NaWEs5Ym9LaTls?=
 =?utf-8?B?WnBwSDQvM2IwYVpvb0xEYlNWcTBNS3lRRHd1dUpoV0w3VVQvSE9USVVWOXJ3?=
 =?utf-8?B?QlZmcWMyY3dPdHhHMDNaLzByTjMxQzZFb1lLc25GbmFMTjBHa1hvWHNwenk5?=
 =?utf-8?B?b0hqWTVjaUtpY0Ewc0plTjdKV3VjQjhRSVl2OHhmdFM3NnNSUVRlWmZ4VUVQ?=
 =?utf-8?B?Rlpob3NsT2t4OWNlaFNXeVptUmtPSjB6alBXcHNZbkhhMlhWSnI2d1JpVnk3?=
 =?utf-8?B?NmJ1dXgzWG1qWmJjYUkySDRxUE41cmxVblo3U3ZNZUdQNUFSL3R4MFJVWTlB?=
 =?utf-8?B?VVhnbmJDRmZ4aVJFbjhZQ3BzS3VMUHNMUXlmWFhhbkwxZ1hGbU55RXhEa0pv?=
 =?utf-8?B?dWlMeHdEUWg4QUcrTW5HUnpRTllsVWdmRzZ5aDFGRUFPeThaek0xNWR5ZmU1?=
 =?utf-8?B?eE5haW1zVEdqYkJ3OHNMYU5XZWgrSjY5Mkl2SkV0UkhHdEZJVWwwcFVwN3Rr?=
 =?utf-8?B?L1pzbVhZNTNvV1RCQ2c1VzQ5OUFPTnk1QU1jdS9WanIwRUpObitQWXphNk14?=
 =?utf-8?B?Z2ZUU2lIUEQ2aW5GVlBsRUtBeGRtMng4M24xdlVzSW0zUmZaU2QxaCt5S1N2?=
 =?utf-8?B?QmRGV2xuRVdTYkFQZEFXbm5WMDYrbHRyMWp6Vm5KbkZTVnlNU3dRZjIyWis5?=
 =?utf-8?B?RXFWUnFydjlxbVQwWjdadXpCNEFCWnZEcHFoS21IeUI5MytnSHBNMG1oejhz?=
 =?utf-8?B?QjhucHZJRGNpa0NKYjcvNzMrY0RyL3ZJQlN0eDgzZ00rV3c0MktQUUJPYTRm?=
 =?utf-8?B?T3orTHZqN1oydjVSTGJOeUlESVhBbTJ6ZXEvank0clZvK2dxTVhRbnVUMnNx?=
 =?utf-8?B?c1N0U0tMNERKcUR1Tzh4QmxoYzBLMzk2NTdsQUtUaCtNWWZWckxUVkdVT01K?=
 =?utf-8?B?WDFRLzFveTJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU12aGd2Z2hCaHd4WlFVdVNmZXIzcUFkQ3FwSldOWjhVSlBOQmx0K2FaK2lV?=
 =?utf-8?B?S3dhOG90OVRrbkhSWEJXQmIyOHZoZWV4TGwwSHdXckZhenBHbUkvQ0NxT2c1?=
 =?utf-8?B?eXVyczRJOEs5OVE2VTdUM2lqeDZ3Tko5dlpZYUpYN3NsQlZLUHBaMnhTanZC?=
 =?utf-8?B?bnozYVFWemcyZkxSRE1nT2dmandFRnMveFlOV2c5SC9KcDNxa0xTdEdBN0VI?=
 =?utf-8?B?WFpiREtmN1RGRlhkbnNIUkQ0MVBlR0VaOE8rQzBsSUVpbEFBUG1PQldtbEc0?=
 =?utf-8?B?QWxVNlFvUCthQU1URzA4TUkxbGx4SzVHQ1VIU2hkME0ydVI0S1FTbzZrZXo4?=
 =?utf-8?B?UFZtT3h5UkFrbnZ3QTVMNi9tckpQSndlUHUwaHEzQis1WnFUN1EvRllSRU16?=
 =?utf-8?B?K2NIblhXcktsUWNjQk5GSHV6bGQ5R2tVN3dZWVJkNXF6RXNNdzVvWUg2Tkk0?=
 =?utf-8?B?SlBmcGtDLzBtS0R0Tm0yR3dpd3ExUDBZdHh5ZlRNblJLMjBnVllkMlNMT3ln?=
 =?utf-8?B?eXFHcUp5QjFmYTlFU21jcUF1WGhsK3dBckdLZk5leXZVZzIvc0lkQ0ZVdU1l?=
 =?utf-8?B?VHAxUXVkUFAvTGFVRDAvcDhVNHlpRlFNdDVaQzB6VVE5VjBqZWZhOWlDUjRP?=
 =?utf-8?B?dVZBQXBxbXp2TWJ1U0tyaDhIanFRR1VVeWhlTnNVTDhxK3hzSy84ZnRCZ1By?=
 =?utf-8?B?ZkpaUFhWT21tYmtiRzUxTDVTdFFvTHk2RE4vVkh2RHM0d3VkNE5UT1NTVWla?=
 =?utf-8?B?b3YzcWh6YkNjeGNKOGVjN29oRWE3WGdwZVlmcUNLOWRVYU0zbStrUzVyM1g3?=
 =?utf-8?B?N3gyVEhsdWNjYUVzSGdzdXF6WmxTRHI3Q1I3bzdwdWw3aStzdHE1WG1haEt1?=
 =?utf-8?B?NzdMMTZkR3VPWGlEb2hhSzRLaERLazRtVVVyaUk0Y3V0dVBUMDlBTGNVQTRo?=
 =?utf-8?B?bkxGSU1GZ2NTekFHVDVIN0VFNW9Id2N6TW1yMDhHazNzaUhCSmxCQ0EwQkFD?=
 =?utf-8?B?azJWWjIrajNRK05kZzRPSzNXNHlXaHpSVnZ6S0ZqdkpJeEJOWHJQYjF3UUtq?=
 =?utf-8?B?MVg1bmNod01vbnA3Q3BDMWg2MVRuWDdTeTBvWjBHNENUeEZKUGxPS0lTUG8w?=
 =?utf-8?B?V0VDNW43a1FWcEFsT1FUN3Y5ZjhDbFMyM092eUg2UGxMZnd3Wmx6cUh5Yzhs?=
 =?utf-8?B?RFhxMklyMXVoYXkxanl5OGMvNUp6VHo4eDNnd2RTclJVQ1NnOXRGZjBybEJX?=
 =?utf-8?B?MTJXMkNCNmdyTmMwb3FQazFYWlB2MHQ2K09DL3k1akkvVEc0Q2IwODdWNlpx?=
 =?utf-8?B?bTMveGlPaExFU25SS0kybFpKb2hUeHZEcjIrek5aL0ZqK0pzUVFZU3VlMDda?=
 =?utf-8?B?SUNHTVp4TWdvSytsWFdneGpjVGtaK0VkcUFHNURXRjdXQ2pwNG9PV3NhdUlW?=
 =?utf-8?B?RXo2VW1jcGpIRmdnZ1k2eUtLNWNMQ3VOVDgzSmZPV2lMSDhFSnNuQkhjV2VI?=
 =?utf-8?B?R2xmWCtQazVOTTErYllmbmNLS2tvczJVcjQxNXgxQldzbDVlWXFhSHk1cVNa?=
 =?utf-8?B?eUJmQi9kak5kTitCNHppL2JjZUdmVFIzeU96bzhYTG5mRWgrd3F4ZHQ1eENn?=
 =?utf-8?B?TjRaWnhObmR2N20zU09IZ1NEeExpQkdMNjRDTXZRWURNUENxZEllS1lscEVN?=
 =?utf-8?B?YUU0WDg5a09xbGlHSUVEakJVS2wvYzBJSTNvMEU1M1ZxdzF5QjBzRngybUZV?=
 =?utf-8?B?bUpMWW03ZVkzanVaTWdja0wzODVuUTB3aWJiemZEN1N1MkhmeEZSYnBiR2ho?=
 =?utf-8?B?WXB1N3ZOcnYweVZiYWZvUUJGVnk3VHp0dXNIZ2RmOU1JM3E5UDVXbUlqdjI1?=
 =?utf-8?B?Z2lZNmlacXMzMEdSYzRNSm9qZ014eHorTUd4S1FLL2JuTGxTaVRDZG1wMXBm?=
 =?utf-8?B?MnRpS1pySnFKMzZNUEdINnAra0tkOVIzR1Z4K2VFU0RpRm9jM2crOFNnNjQw?=
 =?utf-8?B?VDFJdFJyMUFxblh3clV6eWczVVVGV3hkL3F2SHJVMXdlK2Q0UXZjNUVXbEdl?=
 =?utf-8?B?OHBCc3pPeGxRUmNxNW1OQ3RrZDBpVDNRcHVmMXlwdUhjUFdHZEtMQU5oYWc0?=
 =?utf-8?Q?Lno1koskxO2u0Oy1WZOZyS5ip?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d2981d-d1a3-4bde-1d8a-08ddff39530e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:19:43.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+KHBno5bPkSHDgRHdJGwDv+S2uEzR9761ZYWVxpHHoPQ08f7baQS1V5xcxU5wHPbECDSyZvsoSA3/oEuCDGCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3D06B1BFF
X-OriginatorOrg: intel.com

On 9/26/2025 6:58 AM, Luck, Tony wrote:
> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
>> Hi again,
>>
>> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
>>
>> [...]
>>

[snip]

>>  For example, userspace might write the following:
>>
>> MB_MIN: 0=16, 1=16
>> MB_MAX: 0=32, 1=32
>>
>> Which might then read back as follows:
>>
>> MB: 0=50, 1=50
>> # MB_HW: 0=32, 1=32
>> # MB_MIN: 0=16, 1=16
>> # MB_MAX: 0=32, 1=32
>>
>>
>> I haven't tried to develop this idea further, for now.
>>
>> I'd be interested in people's thoughts on it, though.
> 
> Applying this to Intel upcoming region aware memory bandwidth
> that supports 255 steps and h/w min/max limits.
> We would have info files with "min = 1, max = 255" and a schemata
> file that looks like this to legacy apps:
> 
> MB: 0=50;1=75
> #MB_HW: 0=128;1=191
> #MB_MIN: 0=128;1=191
> #MB_MAX: 0=128;1=191
> 
> But a newer app that is aware of the extensions can write:
> 
> # cat > schemata << 'EOF'
> MB_HW: 0=10
> MB_MIN: 0=10
> MB_MAX: 0=64
> EOF
> 
> which then reads back as:
> MB: 0=4;1=75
> #MB_HW: 0=10;1=191
> #MB_MIN: 0=10;1=191
> #MB_MAX: 0=64;1=191
> 
> with the legacy line updated with the rounded value of the MB_HW
> supplied by the user. 10/255 = 3.921% ... so call it "4".
>

This seems to be applicable as it introduces the new interface
while preserving forward compatibility.

One minor question is that, according to "Figure 6-5. MBA Optimal
Bandwidth Register" in the latest RDT specification, the maximum
value ranges from 1 to 511.
Additionally, this bandwidth field is located at bits 48 to 56 in
the MBA Optimal Bandwidth Register, and the range for
this segment could be 1 to 8191. Just wonder if it would be
possible that the current maximum value of 512 may be extended
in the future? Perhaps we could explore a method to query the maximum 
upper limit from the ACPI table or register, or use CPUID to distinguish 
between platforms rather than hardcoding it. Reinette also mentioned 
this in another thread.

Thanks,
Chenyu


[1] 
https://www.intel.com/content/www/us/en/content-details/851356/intel-resource-director-technology-intel-rdt-architecture-specification.html

> The region aware h/w supports separate bandwidth controls for each
> region. We could hope (or perhaps update the spec to define) that
> region0 is always node-local DDR memory and keep the "MB" tag for
> that.
> 
> Then use some other tag naming for other regions. Remote DDR,
> local CXL, remote CXL are the ones we think are next in the h/w
> memory sequence. But the "region" concept would allow for other
> options as other memory technologies come into use.
> 
>>
>> Cheers
>> ---Dave
> 

