Return-Path: <linux-kernel+bounces-871786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34993C0E5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880FA421F13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB4E3054C4;
	Mon, 27 Oct 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eThisFRp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69330B519
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761574094; cv=fail; b=tOJyY5dzRzXflqWUMQljzGl8jdg+P/fTL7RkQzPvOErM3h9+f6HwJbfQ2WWwsdZAwa0qwZNXhkZCiGJz8ycK3dJlqqofT/l1zpzXi/LwP6fcsTpicDc1sbuXRm4JBnYfPpYFQEPnSAMp5yQaaXh7dXDuET5viyVpKCojYhhpP3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761574094; c=relaxed/simple;
	bh=HHyEpI0YCXtQP+MuK7yRzyqTrV4Ojt1FW+DWlFptdzo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q7Z3HoIedugXSGOV2n4iLlo6a3ypJKnMEzAZ92b0Ixo5A4thZK1hPRIJAYJM0qbuMwyrf1S4sVuZumMuwmzmGbmTgvLWXG/I3YfyxLQKC8UFMXaWqYwgOudPxGk+KI7GDdlnCBOr1Bcv3aX94VTJ4pZuXV6pab82wTBeMIUdb1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eThisFRp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761574093; x=1793110093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HHyEpI0YCXtQP+MuK7yRzyqTrV4Ojt1FW+DWlFptdzo=;
  b=eThisFRpPkV0mkprDpnYrv7WfMKXwuCrmecaHCkR04JYWZi4b5pLdYRA
   +VYwRRRk6tj5BC6rTy+ixs9+qzWi+IEPEuHXRS0ei6F5iy4+65LWjgS5k
   iVMbv1u/yAM6WE31vD5K+WegOnuY0s68Oby6VlH4dsPlh3dtIBZ4/ca05
   ZKH9OgYQ0nQkpOjooPkI1Ks827uNhYc6saktIx+3k4TRCX8xh5vGWzLkT
   Rtb26SwuLs2LaGocsTwMqyvn8lTIHb3AYdftefCC8JzZGFc5I+Pl9ZtJl
   Za35xjpet3umzKm0MtZ2M/6HqwIW7GAqefXT39vtvuAkO8dBFnWPbbj+k
   w==;
X-CSE-ConnectionGUID: Q+/RchPFS8KBxbdAyFYcqQ==
X-CSE-MsgGUID: 3RklOEPrRS6SkJHPVEKRuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51228897"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="51228897"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:08:12 -0700
X-CSE-ConnectionGUID: kHOxqi9vTNGRn/Bn3BoYVw==
X-CSE-MsgGUID: WtOZacocROOEdZjwYEszBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="184948143"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 07:08:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 07:08:11 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 27 Oct 2025 07:08:11 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 27 Oct 2025 07:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEPZ6KaAKHNDRVa0hu204U5gI65RG92L5hTws4tWdnPmMAZr/V/X6mNZcGGG3+7HZEW7JCn1KMnsTHGtrtqOfPknSWjdiGQQE85mjXetFc8PghYfZcF1uOxegCTuuSX04tSEADowq0YoC/l3SnKKdHizfQR+K42WZptYT/Hyq9j035yv92geC0l3chkzg126w2oZw33X8NwjTLmf+ScBpeweoI0cRx6viD7YizCHNiNsiXeE/OChtYu96NjjHWyawftQPl1h6n68kCEFKVnxW4c35pMhjxtcf/yE9atwMBNsNKwUUAXiz8tGXjZW/4wt2vm5pu0YcPVWpb3en5wCJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tv9vcEY6T5bWa2tRd+5KJZP7b3HyebC+DGFn7XQhJk=;
 b=Ddvl34nX6Q5Y+Ho+4/B8c2aggla//ZhdDnKA6UJV05rm2cpZZDQmsO0PINKYe5wqrqwSauN9DV0PZi4gp7/Fhf3EHQvTYFsx6xEua0hBQCFp6lEQEfGiO9JDuaygk4+ZUaOGIFT2pCU5osjNfx7DAI4VzHORbvtsohztoW44lO19368edhsWgB/w+69F4X1qD1X+x3owbLPAi/GjTX/RNBP27eOnJvTcqVt3Q9VMebD0BGy++Vr50lGyE9XalLvYQO+8oqUEH/dAZzTsRZ3knNGKXNPahmGvPSz++EM5ynJzMS3rsIe//Ko7sQw9peWbSBNUFnTAt13dyta9lYCo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 LV8PR11MB8485.namprd11.prod.outlook.com (2603:10b6:408:1e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Mon, 27 Oct
 2025 14:08:08 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:08:08 +0000
Message-ID: <ea646ffe-908e-4730-8b3a-69c9318ad5d0@intel.com>
Date: Mon, 27 Oct 2025 22:07:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide
 cache-aware scheduling decisions
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Ingo Molnar <mingo@redhat.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
 <5f97134b-71b6-44fb-85fd-5cff6725cf9c@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <5f97134b-71b6-44fb-85fd-5cff6725cf9c@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0069.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::8) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|LV8PR11MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aa1288-0a81-4864-3c36-08de1562415c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGdrbmlKQWMxWU1MK1JWbWRrRnFWZ2NWcFFJdjU2Zis5WVdJRVlqUFdudEZy?=
 =?utf-8?B?ZDNPT1pSdms0ZzJFcjc4bytsb05QZ0NNTFBMVFV4UGNiTVNKYVVKcTJLeUZG?=
 =?utf-8?B?Wm9XSGpLZzl6cmxwNWM4OHpWb3kzcHNDTjFFcWZOM0E4V0wxd203WmVHSnMx?=
 =?utf-8?B?eHdXclRYWXVxY1JscEluMG5ZczRMNkFSelVCcU05bGgrU0FBaUpwTXBXSjhr?=
 =?utf-8?B?QlMyU2hNY2p4Nk9mVGp5djVZTUthVndQUkE5YTA4RmN6bzJOSVZXa3BVYjhY?=
 =?utf-8?B?UHJjWENseGR6Znc5WnpWWTZoajdqMXpMKy82NzN1U2c3L25ndUJUSFRTLzBU?=
 =?utf-8?B?dnZxTlNRWHBReGlJNzJCUFdZNTM0MG9hRWIrRER2K0JNdFFsNlFBRW1uaUEw?=
 =?utf-8?B?OEhUR25HQm9xOU5QbnRWRXpURjR1b1FWdG1RelRFdTcyYWU2K1NsdGVMK3J1?=
 =?utf-8?B?NGFYWUNCMEliR2IrZ2djQXgwdkNzUXFoSWhVeXBweUJHb0lveFc4azYwN0pE?=
 =?utf-8?B?a28wZ25XM1NHclgvdXUvdnkvemxGYVhJcFVZZnVzRUNRTWNGZGtNVWRPSVAz?=
 =?utf-8?B?aHNzczhEREVTTURPSDdEOCtFV1pTeVQwVGcvc21keFU4bEpEYVFKb0NjMnlU?=
 =?utf-8?B?ZE1Kc3FMMERxdEM1OWpqWWIvWjIrZFRHMFplb21QTGpXNVFNMEU3UHNMUDZB?=
 =?utf-8?B?Um9CZjZBd2JISExncVg5bzdTWDNrbzZxZWFzUUhqUXdOTHRXcHN1azJXM2kr?=
 =?utf-8?B?VGMrUVJhcDU5d3VvQ3dMaGViWU5Lck9EcHM3TGxTZ3RuN0NLaTFBYTJITi94?=
 =?utf-8?B?bFZpRm41MC9iUTc4OVJIWnlyNFRBQmx2b2tDVC9oeDgxK2RMQWxIZDJZcUcz?=
 =?utf-8?B?dUY5K1kzTTdKVzhYV284aHFjK3VCcnlpNk1BajNwTm43RXRIc2J3U0hZaS82?=
 =?utf-8?B?YjlKUlhtdjVtd2puYlY4Mnh3Snh4R3UzUG5GekkxMGpoRlhPREpIWU13M1dp?=
 =?utf-8?B?SW1SdTFPb3Q4N2MzMlAxbzFMazg2R0h3dFdKUThYME9leG5BS0ZiTkk2Vkkz?=
 =?utf-8?B?MlhMcDBrR01MV2RHUFhwbUw3V2dTZmUrMEc3NDJKZDlSdVppNWFvWEJGUzM2?=
 =?utf-8?B?WXphZmRiWExXTHB0UzA2Y1lWUzZTOEFXNUZkc1M3d2xMRklod0VOVjlaTmNG?=
 =?utf-8?B?T2JjYlJaZk9HZkU5WG1ZYnd5OXNCNi91d0RGYzJ0cFBtd2lUNkJYS00rbHQz?=
 =?utf-8?B?UDhjelFWT0lwMlJidHVDSTB4eTRLR2doaDJ4ZytpQjBaS002a2J5MURRaU8w?=
 =?utf-8?B?eTN4ZTdvZUFkYUV4cFBxWUFITHhKWkczTk5XNEhhZDZQNy9GZCtqclFwdGxE?=
 =?utf-8?B?eUI0UFE0TG5oWWkvUzR5SVhLL2g2dEd5U3ZEMU1obWg5bUdSbkV2am5veTFR?=
 =?utf-8?B?VndyWXVkZ1owaU4xWHlVa0wwd2ZUSGo4ODFNbEc1TWVla0xXVGI3ZW8vREVC?=
 =?utf-8?B?N1cyN2xBeW9jSnFBSWd6M2NYMjBITy9pVVRLRm1rUUxVRUduVDFXckM5bEtZ?=
 =?utf-8?B?SkRMQVBnbUdTRTM2QzI0VWJZRDZvU00wR2s5b04wMEU4YncyTVJXcmdZcGRQ?=
 =?utf-8?B?N1Fvdzk2cGlQcFpDMkpuVzMwdUJHTEh0SFlhRTROMzNMZmdMRVRWekxMUTFK?=
 =?utf-8?B?WUoxTlZSbmpIZEpjY0NtRUJFRE5qNFJYa3ZyNVFIWU90NUU5VHgrY3grQ1ho?=
 =?utf-8?B?WlZWTHNyMURlcTkyd2tWSjlVdHpZTHg5Wm4xU3ZZc0dMRXJGRjJZMThWYndh?=
 =?utf-8?B?M1ZpSXMzKzJLRGNZOFlOTFBNR1FvYmc5MzQrZUxEMGhER1o0VjJOeDVDOFNR?=
 =?utf-8?B?MmdpTlZUaHRHVTR5QWZtRmlrOFZaN2NGYTVvUURUQkN4TENzMmJsM3NOdVk4?=
 =?utf-8?Q?d/ezqZENnhZ1Hkpsu+VS0GN6RFYNB1/J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xZVjFsbHJWdG5mSnhqdlE2aVRvcHJFOUw2dGR0SHBrOEVMSGJEbWNOTW16?=
 =?utf-8?B?NktLMkI5c1lESnJReGNZVGl2U21EdEhXSy9zOUtuRkFRT2hMTEJGT2lKRFBr?=
 =?utf-8?B?cnYySDRZNDdnK3BFanB4eGQ3QVZOVGVqVXE1TmRBRndiK3dwK3lVaVJrTUVq?=
 =?utf-8?B?VDZOZ0xlNkxRM1JhNXNxejh4RStONHRsczZvWlNWOURCdnlTb2ZlMm9jT1U4?=
 =?utf-8?B?a0U0YzU5MWFnSkZXcUVaTFZHYXcrS2Z6QWgrZEpEU3FFcDVCeVZUeW0rUGFO?=
 =?utf-8?B?dkw1TmNEWHY5ejh4RE1PZkdvbzRjZGtXSkUzeWFQbDFyencrUHBZYitNZS95?=
 =?utf-8?B?Smp3bzd5WjlJeXltMDMzT0h4K1NvdG9GUENFelNKYUI0MGc3ajMwTWlzTVZE?=
 =?utf-8?B?MDgyeVA5YkV2cllLRU1VNERHdmRYMlIyRWdHazZmeTRmZjFDOE4weit4ZkI3?=
 =?utf-8?B?Vi8vSHNiTWxWR1FEbTAvL1Rid0tLaExNczRTMVVxeGo3ZGp1aXpFVnE1bk5R?=
 =?utf-8?B?QVlKbkVqZkxSMHZRbXBaN2k2MnNLZ05YSWw5VG14Tkl0aXZoTTR1QmFmWXBv?=
 =?utf-8?B?NlhpeDR0TWYxN0g2V3FScERLKzVKc2NOL21FZXRnNmJvWEpzNkR4RUJ3R0pz?=
 =?utf-8?B?TmZsbjMvVDBPN1hDUFNPQjh1Mm94eFJLUDJYbnEzTk5sd29WNFUxekxRUVg1?=
 =?utf-8?B?SmJiQlR6SUkxMWVxTDRsYm9oU3ZGUGVTRXdrMGp1LzJndHFuWXlEWitFVmc1?=
 =?utf-8?B?Nlp6TnhvM2RNUkxaMXh6Um9xWHdjMEE3ZXUxZTJ0UGhlbEFUUVJ5K2pqTERk?=
 =?utf-8?B?VUZiYXlUeTBxMlVKOVNreVJPcUcrWHlOZDBPZEJMZzhERVBhOHJqUkFBZG5Z?=
 =?utf-8?B?YklRcE1WM0YvUmUzQ0lHdmRIMGFRelhzVStHNHh6U2IyMTRHOTZmaGNmMXQ4?=
 =?utf-8?B?Q2xLVmY1TDdnSW9NRFRrZ25tQWdMbExKTGcyMC9FYWowUVg0a0c2c3lGd0Rx?=
 =?utf-8?B?RCtWMS9FTE4yajJUTDRpWjBaL1lHWnRMb0FGWTNUS0djQklDbDlySXVpSGQy?=
 =?utf-8?B?QW1sMFY2c0k3UnF3alpCcEU3bkZ4dVpqSnEwZzFPeWsrYnJsMkZRYXVaMG95?=
 =?utf-8?B?emlZcnppV1ZmRW9JM1VGYzQzenlFS3VHanpLYVZxVm9sSWdVMlE5MTFaekcw?=
 =?utf-8?B?bElIT0xaYm9aNUlyOWFvMWhKZC9WOGpPQTZ3dmVDRnUxZk1TQzNvVUdmWlBX?=
 =?utf-8?B?TytzK3pYaDFVeXhvU044N05BcDRTUkZ3SUlDdzc4L01NYnYrSmJMZ01QTVlh?=
 =?utf-8?B?Z1JpZVk2UEx1L3piNlgyQWN4M0cxRzVlRm5DRjhKU2dlZithTDJEbk16aVhT?=
 =?utf-8?B?U1hHZkYvZVk1TGlmZ1JpZURQYklXZlk1STRIMUNuK1pJQmdQbWZJWFpVd2lM?=
 =?utf-8?B?TE05M3RiZHpxSVEvKzU4ZTJXZE1XNkYzOHgzeVBNYzd3RWp4WTMwbWFZWHU3?=
 =?utf-8?B?TnFKV1QrQURibTJTWEZQYnJZUm1sUzNmNHExNytJUUk0ZzRtTFg5VkFOSFNs?=
 =?utf-8?B?MDZWN2srSW02NFVEZVhvQjZZNmZONHRhYWVLbTJIRzg1SSsybGlVOU1lcDc2?=
 =?utf-8?B?WW5yMkdHU0NibmU1cXF6Wk5VT29FKzV2T2d4bk9RRnBOTG5RajZwU0FjN00y?=
 =?utf-8?B?cVJac0RtcDBqSk8zRzZha2hMM0tLNzVMb244KzVsTHZWT1M2NHZFb2U0UDQ1?=
 =?utf-8?B?b0x0TThYRElwbTlIS0xBNDFmWEVGV3RTTFAyTGZkUWk5THVmbU95SHJiV2sr?=
 =?utf-8?B?bk1RWUdDQjFQcVNmcGRnWWZZdzNCVzJpblJ5OGRTa1ZrdXBtSlNPbmgxeWdy?=
 =?utf-8?B?K29WMGpnelFKelFwSjQzTHowaWY0UElFZjV1NVg5bmtpNXRkYnRjK1VRWGpX?=
 =?utf-8?B?UXl6S3I4Q1RpdDQ0akZxQmFKeWNKa0RRSEduS2Q5NTZSMndmaDB5VHc1aE16?=
 =?utf-8?B?QWp1L3pGSXo2dEczak9KdGs5bGRheEI1WlVubnN0TTl2Z2V1ZzFVakt6SWVh?=
 =?utf-8?B?M3MyWDJGdzdIZTVVYjM4QzFLMjU1dDZuZUdlQzcrMEY0V0RVbk1mR0tKWGM2?=
 =?utf-8?Q?P/jmMB4GlvJ/2M77JJn+3vldw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aa1288-0a81-4864-3c36-08de1562415c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 14:08:08.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAVo5N5eCU9X4HE8vAI6chZdi74WgkMBMouWOxVBYx9NtwbWR69Lc0vmgDgGT+CJgsqPKeOXebDCAC5e6/KMLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8485
X-OriginatorOrg: intel.com

Hi Prateek,

On 10/27/2025 1:01 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
>> +#ifdef CONFIG_SCHED_CACHE
>> +/*
>> + * Record the statistics for this scheduler group for later
>> + * use. These values guide load balancing on aggregating tasks
>> + * to a LLC.
>> + */
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
> 
> Was this intentionally done to limit the update to sg_llc_stats to the
> load balancing period of "sd_llc->parent"?
> 
> Can't this be done with update_idle_cpu_scan()? I believe it is more
> frequent, "sds->total_capacity" from caller gives you the equivalent of
> "group_capacity", and "group_util" is already calculated as "sum_util".
> 
> Checking "sd_llc->parent" there should be sufficient to check if there
> are multiple LLC domains or not. Thoughts?
> 

The original idea was to calculate the statistics for the CPUs within
one LLC, and set the tag for that sched group as well as its sg_lb_stats
(but not at the sched domain scope). With this flag set in that sched group,
we can perform some comparisons in update_sd_pick_busiest() to determine if
that sched group has any tasks that need to be moved to other LLC sched 
groups.
If we do this in update_idle_cpu_scan(), might it be a bit late for
update_sd_pick_busiest()?

thanks,
Chenyu

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
>> +	if (!sd_share)
>> +		return;
>> +
>> +	if (READ_ONCE(sd_share->util_avg) != sgs->group_util)
>> +		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
>> +
>> +	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
>> +		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
>> +}
> 

