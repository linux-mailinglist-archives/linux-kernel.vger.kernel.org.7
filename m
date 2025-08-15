Return-Path: <linux-kernel+bounces-770094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C6B276A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EC260186E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FAC29C326;
	Fri, 15 Aug 2025 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HI0Pl2H6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBE72BE034
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 03:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755227898; cv=fail; b=usvFgR4VAdVknaMMvtMoTMn6e0otT1PeXPxkupg1i/OqncWvOV00z1MauisM91Kv34WuI8gDu4wsIR7lB7Av1NDMUuiW2Zi6vsiO4nKM31qhpmfHIuqpG/iklb0ucXqMY0ztb0tRtysjUQk/QdHwDmaDLoAyEdAvD4e9rMZLoco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755227898; c=relaxed/simple;
	bh=LyuC1dPrQ9O5xKesJEb3zN/xO0ni6Opcl9UyiSwWf7w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ye+3TCdhneiEvHs23PHe0S9cjuVakDqANEQglRCZuGygdwa5QQJKEcvJvGwC9g6s7O1F1a+LsqXdDJz774OFD0YdXwQJQsEDXk/gT+FMYTg/ctDkV6Ey5EuN8GdpXaQotfpuHu3EzIGRkLlz22GRaGAp+0iuxCkaKC1r5NoytNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HI0Pl2H6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755227898; x=1786763898;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LyuC1dPrQ9O5xKesJEb3zN/xO0ni6Opcl9UyiSwWf7w=;
  b=HI0Pl2H6t4yEQ0rwE4AFeOhRyfvF54d8Q32mRfbe6qTD9VCpLJw70KJc
   XcaIYi17cJwCdSmGLS7ixBg8Em7hFZEYAk9wFXgWcLnOZInphbYVY/As3
   ogQ+VH+U1H1GqiwtMlld5dUkqqV6mIriMRREFmdI50M44V+E270wR97io
   A2lmuDZ91NsxtefFyBXjpsdD7eYGbr0l4w3MmSCANW7QRKkLYWNYMmhBS
   9fWu7oQ+PuitvCBw67nSmiuGu3x9IO+6GJGc57F0ZwW7uDrWTDUrdHhnd
   dU1iIKNA6hfgrZZVUwgKkZ32UmOxqIO4fe6FSpgiNGZkhNuncZDenJ/OO
   A==;
X-CSE-ConnectionGUID: YJwWooezSB2A1+NIM75qBw==
X-CSE-MsgGUID: Qg9Yx+zWQHezwufsyecUPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="67823873"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="67823873"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:18:18 -0700
X-CSE-ConnectionGUID: iwleZipGSQeUDJx3/dLVqA==
X-CSE-MsgGUID: Pxg7WPD6RxywcTja+7erhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172145369"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:18:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:18:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 20:18:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.40) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:18:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osWTMGm61/NVwZUhHl+KnszRjPX/eMlSWqHZniRnufMssgh+ukKIPzpnpd575e9Lp1PSVf4AToobYYTJrsp6x2VlyAS6XqV6bBspJMiEXNkGYc8gWqh1SxjP10RwxUPfM/z2i5UJXmUS85QJuYm1hVY2LvVS0m65OIHO4xWdIFIgHuPAlWOmlOecJ4XJ1cwuy3esYeONbCKltH09dCh44CdmkTnjdRynsp7zLgdr2OXoEd/mcISwHkqc4LbyFzq1UY4J+MBll/9Wwn0RDoQSzHXrFLe7l4uyg1iv2A4L6erDq7vnMuiSIjX65ZlpEiutXWj+2aKX2NKRJMokvdWBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLqJYHxl916RSa8Q5KOL2/Xws9fnzNUcURqGlbscOhk=;
 b=b0a0cTLocs2CRMr9gRFaRMjF1P/lwrANEEv4UJxxMulbrnOS82k2CfKujULmeCcsjTdk2TNJodUrVieB3VMONxuLpvATMM0a1bAAa6dawx+/g6nB+Ujql5hYw+UfgcW7kkOJCDW4FvG3ZiVUlvaZvQnBh7oklvYuwBQa/CDhxkAd25aUXkDjga744iFwQribwmmY0JFbWYKu53SwbXHCXW61K4AY+X84vruajEsGW/ESXUZWSWvQBWSUKlM6IZR6NWsMVX6FyPFo75T8ISB/foF2gFRohoLOyjkiVcZr87zuXdezfP7xxsx2Hlt9GT0WYSgfYN4Girk0KMscGSfoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 IA1PR11MB8224.namprd11.prod.outlook.com (2603:10b6:208:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 03:18:14 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:18:14 +0000
Message-ID: <4b552080-5299-4234-b101-eab04b21bb74@intel.com>
Date: Fri, 15 Aug 2025 11:18:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/fair] 155213a2ae: unixbench.throughput
 23.2% regression
To: kernel test robot <oliver.sang@intel.com>, Chris Mason <clm@fb.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
	<vincent.guittot@linaro.org>, <pan.deng@intel.com>, <yu.ma@intel.com>,
	<aubrey.li@linux.intel.com>
References: <202508150416.d7153a48-lkp@intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <202508150416.d7153a48-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|IA1PR11MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba1e8cf-de12-4eaa-8a3a-08dddbaa5e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhCU25kejE0RFMxRHNDcitmOG8rei9TQldnNlplRjJPb24zMVJ0Q0p4aGJI?=
 =?utf-8?B?Sno1VFZ0THMrMVR6MXlRZkc4Yjhjc3dwUFl4Z0JydTMralB0TGx3YXRmMnZS?=
 =?utf-8?B?UVFsajY1eXhHaHlCZkFPNTJFdVpxc2xiQ0dqbDUvRFVRTGsxYU9hZ3dYeGl1?=
 =?utf-8?B?STlpaTU0aVFIUVZTOFY4Vi9lNExjMXJTaXhZNkZVT0tuTUpDVGVNeE94WTBB?=
 =?utf-8?B?WHpMbFdjcUlSQzZGbTlxTnNUZVBCVEp2TEdhcm14cVF3L0lRamk4c2F0MVUv?=
 =?utf-8?B?VlZMdUtrOHVNWFlaOWV4dE9SYm10V21ZWFI4dFIvekVSQnVOYTNHN2pOcjNL?=
 =?utf-8?B?alE0a0dBSE04MklCVEpCUWZqeCtQNXJRYlVBZHZaWEU1RXBwWlAvS1lHRTV0?=
 =?utf-8?B?TjkvT0dVQUFDWWEvU1BSQm1idEZJb3YyM2Zqd1ppaXVPeFd3T3U2SDdVVHli?=
 =?utf-8?B?N1oyMGJVQ1BGcjZNZ1BEM1BQQnJOTEZINkkxVUVEa1VRbWwxUnVmSXpsN1pE?=
 =?utf-8?B?K0NTWkZlL0F0cFFWVFpxaHoyVTFxTUpvSHRvWDgzZXFoT2NRN2Judzh4ZVVw?=
 =?utf-8?B?U3lyb3F1eVJuYWgvN2F2bEVRd0M4R0sxenZKUHY3R1N4ZFp4UDJZUXAzK0t4?=
 =?utf-8?B?b0E1YjVWbU9IUkQyb081RGJqdWp6UjFiejBrUFJxWFlLZG44Y2NZWWM5Nmcr?=
 =?utf-8?B?eEF4OUo2QzNIejEzQkU5emFmZ1hoMVJucXlic0pOTkI4UEFKbE9kVURPRnB5?=
 =?utf-8?B?eEJheisxVXhvb0xaNjFsR2E1N0RVRElwY3p4ZHQ0ZWphL1dWa29FZS91bmhq?=
 =?utf-8?B?Q0VGWkZ6Q0RMTzZLb3FFWTRPTmR6MmIySElBaHgvdjFwK1lIZ2VidEJKbjlo?=
 =?utf-8?B?Z1ViTmtGNEgvaU93dmNwNHh0a3RBaGJrck8xaitJRzNCbjBTNjJBZmdBQ1dH?=
 =?utf-8?B?TE8wTG5rbmFXaDJjaFBrTE0zbjZvSHRYckNqRXhhVU5VTk5zSFhIUzd4SmlL?=
 =?utf-8?B?b1FnenlXcnlxN1c2Qzc0Q2ltYlkwNVd3STV3SUtxZVpCWlBROTl4UFBPcmxq?=
 =?utf-8?B?bUJ0L2dyeHdzZ1RoL00vWlA4RFd5N2R0NFBTbEZXMGFsSGc3VUdCQ0F6dnBX?=
 =?utf-8?B?NVBwdjcwQXQ0UkJlUzdtamVMYjNNbE1JOUFPRGtyMEluNDE0ZFd5M3o4NDZS?=
 =?utf-8?B?STlhcTF0T3A3L3dIK3F3SzR1WGdRR0Z3NzJWUWMzZDRENHI5bGplaFBVcmtQ?=
 =?utf-8?B?V1RSWmxtMkE2aGp4NkgyK1lPNEcveGNBNy9VU25BSjltaWdxWWZ6dVJrNnEz?=
 =?utf-8?B?STA1SGNlWk44V0NHa01nNjJBdFk3V1RqQ1Y5OGV0M1UwdTRrSHB0czJXdzdt?=
 =?utf-8?B?bGtkMUpuc3pyS29jK0hCZ2NpVHpKc2JrR0FZQit4aGdJSjRSSC9RSW9VWlpS?=
 =?utf-8?B?a0RhSjhGYXp6c1I2R1UxQVlvMkxXZk5Hd0dVejBUT2ptbnpuSEdZTTE3dUln?=
 =?utf-8?B?ZTNmUmlzVmQ5SWxzUFgzOEp6VEJ5cXE5b24xaWlQZU5vWFNTNGVGY0RHejZJ?=
 =?utf-8?B?WHMxeCtCWnR5ZWc0L3NuMUprZFlXb1pLYXNWVzJTdG9UMHRvZ1JGWjg1cXY1?=
 =?utf-8?B?YXZGS3VNUUl6bVRKdm9WVXdOOUpZUGxBNUxOMzJLdzRRSUY1UktHejM1QWNk?=
 =?utf-8?B?dXIyMVA3K2ZIU21MSnhLcHNYWTRiR25XMXB3ZnZoOWlqdnpoZldDMjZlUkVo?=
 =?utf-8?B?NkNwQzl2c1doRUU1NEtXMS9NTGxwRHZsbFFKR1B4VDVzS0tlZVhaRXdrWkVv?=
 =?utf-8?B?NkdUcVFXMEtCem9YSDdRazlxbTd2eG15MnpkZm9xaWJSbkxPTnNTYk1HK0d6?=
 =?utf-8?B?Ky9nQU4rblIxNWw5UEIxZEdTMlFxbjBKNFUwMGNYd0xpSU04dmxNZkJTdnBY?=
 =?utf-8?Q?ETnrsOmUH/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhmYWgrUEJBTjhCRXpsRTVvVjVIaE5IQkVHS2lWOVFkdWtScnMwWGV3MzBa?=
 =?utf-8?B?SXRvK1FHK2ZVMGRBYlRqbk15TGxselR3NW1HeFowMHdqT256cHNWNFhCZmg2?=
 =?utf-8?B?a0JaeVgzM00xUDJwOGVxVVEzWUFLVlo1eklBYjVuUytBSmhkRWU1QjVxL1FH?=
 =?utf-8?B?WTYzdHI1V3NFaHB2b3hZK1FZZHdNUjhKaWxCMEFtT09RTFFVdi9ObGM4d0oz?=
 =?utf-8?B?ZlF2OVVpTDN2d0hLaVBoVjRLSjVwV2dBbHplMURqajBxUFRqUkVjdXl3ZTZQ?=
 =?utf-8?B?Z3hiOTFuaUZPaDM5OGZ6NCtjTE1OVDl0MTkxc2VDemJxR3ZTQm8zcWJJM0c3?=
 =?utf-8?B?Q1pKUFdqTmJtOXcrd2JWOU5FcmRPOTJkZ1BxcDl2Y1B5aWtjNDFGaS93L01D?=
 =?utf-8?B?UU5CbnVlU25XME9JdTJURG51aDNIQnpBcGdxc25ISWovajRVcWNRa3VtVVlG?=
 =?utf-8?B?RTgya3QxMk5xTWcraXBxN0IweWV1eEMyaktXL1ptMmpwbGYzeVNwa0IyY25k?=
 =?utf-8?B?YjRUNFE1dHZOT0VGeHpEYm8zRUNyWElqWHBQdnNLdXBsUHdMNW0xMFcycHRn?=
 =?utf-8?B?d05LTTBHMEMwZCtkdmhvbTdKVXJ4T0cyZ01zZmNwdzkzT3czSHdOdDR4aTc3?=
 =?utf-8?B?MkxVUWF6S1hnbngwZldoeXVGTUdoZjYxdDdkS1BQWUZINTRIR3FoRlpUc0J0?=
 =?utf-8?B?UzRlMFNOWGR2SHhSQjRteWhEYzU1OXRHNE44aHVqMTZvUkdJTnlzU2FMa21K?=
 =?utf-8?B?ZmIzVnpyY1Z3V1U1SjVZaXhPZmhOODB2MDlBL2JJUm5aVUtkMjRlZVZnWmZ2?=
 =?utf-8?B?NU05M3BDOXU2Ri9YMzBqUWYvdGQwRURhcUxTV2l2bXhBYStMQUxFSHlCeGdU?=
 =?utf-8?B?VnRqRFNwU0RVWXg5cUk3andZTmxuajJHeWI2NFJRRUV6TXBZbjY4ZXNGM0Ur?=
 =?utf-8?B?dE84K3FTaXRhYzIyeHd1Q2E2VTNxUlNtUTZxRS9TWitaKzB4YnBIMzJIajJs?=
 =?utf-8?B?UnYrK3o0N2pEUytIRXp2OVhmSCt3UzZzTnlLeUh2d2ticzJrczBaMVZwdVps?=
 =?utf-8?B?N3RUZVg5UldXeE5ZTk5oRDErSFhLV2V2YjJPaHlQQ3hCNjkvYk5pamNiSUZ4?=
 =?utf-8?B?V2hZbGdFNy8vWlpEcUQwLzFSNDdSalhMcmFBL2MxWVE5RjdLeHBJbjN5eWlj?=
 =?utf-8?B?MTVCVWZHc3ZrTGE2M092TURvZGU4cjNKeCs2RGRxTWtQL0h0TDZteW10a0JV?=
 =?utf-8?B?bFdaOXhUd1l1UVE2WmZCS0tiYmJxQjBxOEwxdmtXcnlDN0I1a2pJcjdtMmVM?=
 =?utf-8?B?TFBLUGwyZU1RajEzZE1ldGNFeUtVUDg1aEdQNGVUZEpVeFBLWTZKOFI0bm9s?=
 =?utf-8?B?d1BzRG5oNC8zSE42aUV0TG9QYjJLaTUwVyt3TEgvYURsV2Zxa0dhcjhZZ1VS?=
 =?utf-8?B?ajRsbGlQUkl6c0lZZUF5OU94T1A2NXVQYTQ2MDJDS043cVo3MHFaMFJ2d0I0?=
 =?utf-8?B?dlBlcks2cHhFU210VjBKNmdZVW5hTlk3bE9HaFBKdisvV3dSME41YnRGVGI1?=
 =?utf-8?B?Um1FR1ppS0hvRmNXallLS1lVb3BoVmphclFHZmljam9rNXJmSExJMjJsMXpu?=
 =?utf-8?B?SmIzVmJhaFphZFpycHRQOWtUNU5XZU80VVlTUWhUQlFCRGlSYjlxMUxHN2M5?=
 =?utf-8?B?SUlKYWVyc2N6Ri9yMFdsQzBiZzF4V1ZoZXp0dE8rcmhCcklPWWhYbWIycHVZ?=
 =?utf-8?B?L2EyR09ONll6UHdQZ1FIVGtJUVE2U2UzL0VYSlBWZkl0TklOZkExbEk5Y3E2?=
 =?utf-8?B?NHNrOVRtdUlMcDFXd3RTZEx1VXRLd2RSY2M0a2hYSFlDdUU2UEVkM1dpa1FH?=
 =?utf-8?B?cVZWQUxrVnExamJ4R3p0KzJHOTV3UE9pV2UrTS94WFJSRGFyK25CSWtMUlFh?=
 =?utf-8?B?RUsrTDZxMFp0bUVwUlVOSTlYSE5NSi9vaDc3UWdIdVd1U1hQSEFRU0ZrN3hq?=
 =?utf-8?B?R3dJeXR1MzRYbmFSekVjRjdodUFJMnZiVmQwS3NvT2E0MUgwWHRlZjZBSTg2?=
 =?utf-8?B?RFBDamhUMlZHQmVSTFpueFVYYVNDemJzVkVmMS83U1RYVVJvcHR1aytxTytB?=
 =?utf-8?Q?pgatvc+rsNckkzxGZo4Mi7QcO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba1e8cf-de12-4eaa-8a3a-08dddbaa5e98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:18:13.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt5JMmAApdOK5QgipjSK/gGhzUC9fbdj5VfIa+7AIdKbrwcjVlpWAXnjMKgci/M7332FXG7O0KXLzyWfV9wqsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8224
X-OriginatorOrg: intel.com

Hi Oliver,

On 8/15/2025 11:14 AM, kernel test robot wrote:
> 
> 
> Hello,
> 
> 
> we reported a "22.9% regression of unixbench.throughput" for this patch in
> https://lore.kernel.org/all/202507150846.538fc133-lkp@intel.com/
> where there are some discussions.
> 
> later we also reported
> "[tip:sched/core] [sched/fair]  155213a2ae:  unixbench.throughput 20.2% regression"
> in
> https://lore.kernel.org/all/202507281046.e71b853a-lkp@intel.com/
> 
> 
> since now the commit is in mainline, we rebuild the kernel and rerun the tests,
> still observed similar regression. below full report is just FYI.
> 

Peter has suggested some directions for the fix, will take a look next week.

thanks,
Chenyu


