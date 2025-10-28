Return-Path: <linux-kernel+bounces-873712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB39C14825
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70236586F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A7314D2D;
	Tue, 28 Oct 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JacW7mLl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7B311C39
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652756; cv=fail; b=athgAr8OfF09hMB7K0mQLwxY85rJN/njYVYLEjqwDUmPLxLPdO3PoG2mF0snELy3XxgE4QZq/bzVpqZvLrwkJlE/yyLs5ozxWy2YsD7YpdUsRMcuARippepG6wMaGc0qycNihU2uODGTo75CUP5wzyGI+OfgoaA/xfntuxWe71M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652756; c=relaxed/simple;
	bh=PDIkgPoTCUW+Bj/dwwJpMPh3vfNvjbJ16+B7hjg+C1Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cgQSGUcr++qE/rCxYxhJMoD0N1fSZhJahNzeQJ6ds3EXvutLWNngE1jHDzTdyHesLA3YY1yqRgDupVYF701np+Eagz/dn2JgdjaEGdpHVppa23fYDO1zqH+wj33fMiztQdD9MrBCCMAtyw8UPewRC0yyu32fNFn5RazNwFThwJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JacW7mLl; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761652754; x=1793188754;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PDIkgPoTCUW+Bj/dwwJpMPh3vfNvjbJ16+B7hjg+C1Y=;
  b=JacW7mLlbbKJ7knIW3x8hq+nmDaSQk+dlfZINVLE/a7afnzC6rGURP/A
   kwkivGRJYkdhfZl6O6kqOzb0A2I7k/eB927LguATS0oCqA/3ausb+eF0n
   qPnizHtyeNQWTCV3//czVGjcYEyBjTB8iPZdYoOFX2xYuyHXfPUsMBBmK
   1FXjXxOuhm8qiwz9PhnaFBlx/0C5YCh4Rf3VQ8h/mx+I0vHySbydKVoFC
   ZSsysI0UGqPM5BvpQ/Mk34cmCikkMOFsKxMkzVPZu4MASbw2AlaExbnK0
   g/kIjNB16gQlwzYkIKHF5s8DPZ09UxW6pm7k9Rr9UJS3au7zYkH5dzC6T
   g==;
X-CSE-ConnectionGUID: Is83dJxrSnml25H7G/VYyA==
X-CSE-MsgGUID: k8YUjb0cRiy1k8vIW0HHtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63638065"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63638065"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:59:13 -0700
X-CSE-ConnectionGUID: pvy0qjOjQn+sXXKLgd/6aw==
X-CSE-MsgGUID: YiRt5CcCTxeiYz+/TFU1+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="215984248"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 04:59:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 04:59:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 04:59:13 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 04:59:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtQiyQh32FLUlcQddyI2MQnwlC3ehtRshcsuDbr78sYDOwbfyDaCAVPk5FcsGKlBD7/RF43Q86exUbjaHB71CzqBfrYq4jb+Vps5A5WmxKBNOpa3qEJuoad0l9KWlrBWB78XMKjd1Qm5lwJjq4MdhLynru7f9kq6bkWzEP/z/CCxtsp+gvBiSXu5xXsNJgr2DpmeJ3NUWZ7nCLu0Crg5C6o69kmYFo2RaNEubYXFjWcvyt4JGhpv6RGB6+FVgvsmiQIm6K+3Nb03G4ycU9Y6sPIyKup+PejANi7epISsCuXLSuTvffitiJyw8pNFBqc3BLpfIJPKA/rX65JbZuWLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7svFTtGj7iwnfX1Ss1D/HCq2MgJtWfU7EKDJDVTsAg=;
 b=cyDJOql+wzvYNAa6Vyzff5QUHDJQPhiY9RovriJgBoEdE5I/Svs+N4GcMrNTUwxNSP2Xlxai4ficWjraaEokpqsrZZzWCCpR1fXZNUyEG0uXeWMldawZexoM3WKN7Z4HaU4QuQB9uaeNuXQ7NC2ulg7H1JccjlsFGZnzN2cbSrOtil5x7NiRLKlq0qaP8DhS0gxd5+cbfqN8zRpr3JcgxRI2zFHfAKeM31yeixozzEtVPPHm7Hq2Ha92m1OPoiuUj9mc21OKR/YW0LHFUnW7vwX41+fqMDETHec+xFT2tFrthg14VBF1NIpKCJ+Xw30bBced3G1I4823zUPAHG7DKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 11:59:11 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 11:59:11 +0000
Message-ID: <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
Date: Tue, 28 Oct 2025 19:58:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
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
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0046.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CO1PR11MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: c4383225-bb2e-4121-1ff2-08de1619680b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjVFK1ErTzJQOWpIbVFVRDNlSVQ4VmUwZU5ZZlY3di8rTzEyR05wdHJOUmlF?=
 =?utf-8?B?TGtxYXltTkZ6ejhlSkI0RGpBNFdWZGFyTUZVVDBRZHZGTVRmV3MwK1lFQzNJ?=
 =?utf-8?B?eW9mZG83aWxqcGdvOWE1a25xOGl6ZHdwUDRhUHdzaCsyWTNIREFPd1AzY3dU?=
 =?utf-8?B?QzdKT1BNOTFMNWp0U0F6NHgwbWI5N0tGaHBJV29XWjl4Um5LS1ZKcmF1MUQr?=
 =?utf-8?B?N0dyMUNLTlZQUTFYVGVMZjVEcm9LVmFlRWJYbEVrMy9JazN1KzNwNUtZZWtL?=
 =?utf-8?B?ZnEwZU1xczVaOFFCRUcwcjFLUm9vaGMwa0JVRFVXdFBzNWhyS1lRSm1Hcmhr?=
 =?utf-8?B?ZmN5TnRYZllVOC9XTHlrRUU0RXNraGtGK1F6SHZXYXNQcTBqdDlsdFYyalJu?=
 =?utf-8?B?b2lIeEVmdmZrWndZcngvK0VncTlISmpUYStkVTFCWU1ZVTdCMEVqN2VMOUNs?=
 =?utf-8?B?SGNjKzN1YTRBRVd0L3RJUmpwV1FEZmFWbFdoVHgxOXFUL2lYVk5rRit6RC9L?=
 =?utf-8?B?UFF6eWJTMnFMOXdpK3B4TEFRSTZjL3BiMXdhRnVWaUIwNklUWVYxNzVsRFUx?=
 =?utf-8?B?ellIYnVZQmZjV0hma1k0VzRYeVhYNHphb0xQUnJ0MUZpbFF3WEtMaVBlVUx1?=
 =?utf-8?B?ZHAwMkF1alJPbDFRdEpkeWJPdHlUUHJLdHJzWm81b2x6Q3MyL3RtZ3BzQVJq?=
 =?utf-8?B?eXdPZDJ3TEp4L3VZeEZmUUNncG9aWkNmOUZpdGVQRHdJSkM5eVliVDJjMkxk?=
 =?utf-8?B?MEIyNXprTGRkdmo5RE5yeWdzSVFtamNPWXZyRzNIMkRZOXZpODFWSUR1SVhy?=
 =?utf-8?B?dTNPRmdyUzRoWXRRSVBhWEZSOTgrNXYvRWVNeEhLcFp5Vm1PVnlzcUJ0TnVK?=
 =?utf-8?B?YVlTVFo2WjdpdWJnTk0vZDJFT3NzaHZuS1JJUFBrbTkxSmJBT0JBQkhQTTNV?=
 =?utf-8?B?SktrLzVkRjdQd2ZkOUFWczNTWFVtQkJEUm94QitlbXRTT0xJbWgrTmZEWDM3?=
 =?utf-8?B?dGtiZTltelpxOXVrenlRTjcwYW5HeFl5VFZtMHFHamF1OHg2dVlHWVJmYVVU?=
 =?utf-8?B?OU1GVzVZT2sraDVMR3oycU9yZ292VTA5bUtmUDNZRDhxSlZTTnR6MkRzTmRh?=
 =?utf-8?B?SVlRYk84WEZncENyMWkxaXJ2MlpYSVhJRDVlL1RGQ2FNZS9JUVpqQzlJTHRC?=
 =?utf-8?B?ZFowWnVMS0xwZEdJOENlaXRZR2VBVCsvZ0dWYlNTZmR2WFFKOFU0TEZEeHBM?=
 =?utf-8?B?elc0bkdWNHZSeTRzd1VSa2ZPZWxtVWZnN2VOTklmRWZaczBncEEvOUdVc1cx?=
 =?utf-8?B?c2M4YUJjTGdBbGp4MVhBSHhlckQxeFZnV01nQXVBMEFDRC9SdUtvd2x3S3Ju?=
 =?utf-8?B?bFdQcmxjT21KRldIOWFBcG5qa2xmZS9IbHppdkNKQ25CWjh1V0xEN0pwYW9K?=
 =?utf-8?B?RGNNSEJCSXdSNmE2RWl3dGZGRmlyS0grOXR1Y01VenYrSEdLeHhjY0s5M1R2?=
 =?utf-8?B?STU2OGUrVzRvM2I1eUdkeW9hRTZGcHowNzMrb1RhRVY2MCtabHR4NWhNQU4r?=
 =?utf-8?B?bVVmOXFySGJnZWU5UWlFUDZzLytGbndTWng5YnE5dVphTi9mY3lSNGFPSmwz?=
 =?utf-8?B?bU9VQlJuU0dYeUZQY0U1Mk43NTlyOHV0ZVZ0WEY5c3B1Mnk5RVgzKzZzT1lw?=
 =?utf-8?B?ZCsrM21YVHQxbkFhUXFlLzFoMlVpOFNUMlBiM05tZ2xrVXJUZ204Y2krcUtM?=
 =?utf-8?B?ZHhDc2ZpT3ZPWG1sTVpMZ2wvOWxxTGk2c0wvQm5zUkJGNGhXbk0zMmpBbkw4?=
 =?utf-8?B?eHFCcGlLRUp6RlpsNTBwczUyZGVNb0VqR2lwME1kWXllOGNoMUF4RzBYOEFp?=
 =?utf-8?B?NE9RMlBQVkY3MGJYQU9DaTBMaHVqQWdpejVWaVpYZEQwZjVkQzE4QzZKUERR?=
 =?utf-8?Q?o9G8jxnzUHZzUzfQuptRl+DPrpD8emeg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWk4RzBGY1pYOWlvUjY1bzBsU2MrbytKS3hBZFA3QkZndDVycGpsRjhCYUxx?=
 =?utf-8?B?MkhRWnd0ZklMeHVjbFBaZDBNbVZsNER1eVNHZVNsZ3NmczBpMWw1U2krQmtH?=
 =?utf-8?B?YitIeHpGdytKaVdORFFROS96RkYwY1djd3BabjU3QWFwUHdVK29PQzJEY1FX?=
 =?utf-8?B?OWtZaElUdTZSeTJ2WkhCLzkvMUhBOTB0b3RJWm9BVWg0MjlDb1hZNDAwWTFF?=
 =?utf-8?B?anZHU2lDdDVWSkIwWDQydVZxdDExaTQxemVsdHFVaWloazl3S1lqVHVSMkhP?=
 =?utf-8?B?bEFnRDZkd2s4cW0raTZaOFk0R1FEdkpVNW1nL3J6bmNpa1Izbm1SME8rT0dW?=
 =?utf-8?B?cHp5L2hwTWp3eHMwQlAxaHJ0THJCeGIxd3R6c1VjSHV6UTA5YXlwQUxuVDdV?=
 =?utf-8?B?WG01eitTSjJkZy9BdXMxSFdTUE1WTDVXTDRkK3U4NzJ4Yk1iM2t6UE1UUWMz?=
 =?utf-8?B?K1pxNDAyanhhcW0yYmNSTXJiQWFRUGM5TDRmK3d2cEVONVJnSTNqeDg3VFlF?=
 =?utf-8?B?YkhhSVEyVW14N1JkRmFlZFNDTWJvUFplY3dYd2NldjZpcVowblJPQnp6em96?=
 =?utf-8?B?ejladGdIYS9pSTMxZ2t0UEVPYlNaeEk2a3JCZ1N2YlNVT1pxWlVLNEhhU09J?=
 =?utf-8?B?UTRtZWRpUDUyZTZpeDZGZFlCeHZ3ZWdJQXpMK2hzelhVNnpEbDV5NWd6aEJm?=
 =?utf-8?B?dEdRUFc2UmNXYUtjTVJ2dWpTRXJEQU5BUHROKzI1VFJHMFRzNGh3Nk9PQkl3?=
 =?utf-8?B?TFhYVzRMNTBnYkk2UU5CSUYyM08zcFROSmtTeDEyY25KSG1yT0pFWXhFRHlW?=
 =?utf-8?B?ZXo3bWdGaGNITnU0Z3hJVkwzcGh2c0tkVGZhQldrWC9mLytER0NiRWtkbTV1?=
 =?utf-8?B?VllCcFNDWlRjZVVSYjlobDBDbURoV3NlbWZLbTRwUDlVdUlkZmdPdHZZdUlE?=
 =?utf-8?B?OUh5NUo5elkvZmVDc2ZHUmJXeXhvS2wzMVVGQjVUWUFQcWRSVHV5b3dlVEFT?=
 =?utf-8?B?RzF4NGFMeGQxYStBNkFFL2g4dHJETkI0K0RneURoblE0N01SRmx0YkxTa3U4?=
 =?utf-8?B?cXBtU0J4eEFkRkJJaUlxa1J0OGpLMVk5K0NUSnRVQzFnZW42NFlQWVhDRUsw?=
 =?utf-8?B?MCtTU085ZzJMd2R1cjRVRm9aOUtRd3BVNVNTbGU5K0hzeUIwLzRXcHpVT2hT?=
 =?utf-8?B?QllHWE5uMUdPSGtiMmZWWVdCYVNmbUE5OTI0ZTFxTjZvUHdHNEhWZVRaU1Fq?=
 =?utf-8?B?aDRwN0VmQ1dndnJJMEN4T282MlJBc2poUVFSL3F6dzF0bVBLVCtvK1RhV04w?=
 =?utf-8?B?YUJMd1QzY3lacXpqMEFZMEpBaDZFZ0dyMGJ3OW5qdXpKcVdPRUd2TzRhNktr?=
 =?utf-8?B?OHdPWWcxOWxRRGJhc2liMVVMc29hNW5wUmNMVHc4M0IxSHhZSTZ4L3RSYUZw?=
 =?utf-8?B?Q3VLSGR5TE9ETlp6Rmh6NllsSDFtbGVVQ2Y2c1l3U1loT1dsV0lVSC9odjhX?=
 =?utf-8?B?TFJMK1pUNHZKT0JHZlE5Vm43Q3g4WW9RMEpVRTVqUDFHdzgxM1B2VlRjZDh3?=
 =?utf-8?B?aWpXa3d0amhvU3A2cE5sZTVSTURTMjI3OUZxL1dFVzBNd3F1ZXNzZmhrUW9i?=
 =?utf-8?B?RGVHeHFjQUpyN3hFUkVyUWhFMUdQZlFyWVNZOUFKTDdxY1hoTHl4V2VSc200?=
 =?utf-8?B?dFVaeVdnaU5QVGJKZktZRE5ic25wTXc2cjhkVzRPY2R4ZTI2cExsdEcyM2t4?=
 =?utf-8?B?Vm9GOEcwNzg5U2NCbG9PWjFsaHo0NDhKKzYwVndjTlVwalFrUWlDZkxpU0x3?=
 =?utf-8?B?M0tTUERPUlB5aGw5aFBYUG5XMEdka3RCYkpmeG4vRGx2dCtPRWQwVndhLzYz?=
 =?utf-8?B?eXVqWEU2bU02UVFhVHd2M3pkMzNqSEJvdTBlUEEwcXRBcm1ud29SdUZXbXds?=
 =?utf-8?B?WWtFQVBYKzYyLy9LRGNVVDFEVE9aVVJFZzVMOEpVZ0pPWE9JZEhKVzhlTFFS?=
 =?utf-8?B?R0R1dFVoR3NxTzN1TVMyRGgyaGt1ZjBUY2RZVEsrSnBqVlpUdDkwcTBWc1Fr?=
 =?utf-8?B?djR4cWJQNk1pWDBpdWtJb1lqVzVQVGx5SjQ3UmxOT1ZaYXcyckpqcjVSOHVO?=
 =?utf-8?Q?gA9re3UwBm0iOtjnhoCO64L7N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4383225-bb2e-4121-1ff2-08de1619680b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 11:59:11.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koaU2OGFO3iPa5WlhDs2cE8HgeAqBmXkGEcqomscjzchuTvsWvRKjjI2T3leC9Oq4qUBNu/CRNOt8ZXDlzn63Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

Hi Prateek,

On 10/28/2025 2:02 PM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 10/11/2025 11:54 PM, Tim Chen wrote:
>> @@ -9969,6 +9969,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>   	if (env->flags & LBF_ACTIVE_LB)
>>   		return 1;
>>   
>> +#ifdef CONFIG_SCHED_CACHE
>> +	if (sched_cache_enabled() &&
>> +	    can_migrate_llc_task(env->src_cpu, env->dst_cpu, p) == mig_forbid)
>> +		return 0;
>> +#endif
>> +
>>   	degrades = migrate_degrades_locality(p, env);
>>   	if (!degrades)
>>   		hot = task_hot(p, env);
> 
> Should we care for task_hot() w.r.t. migration cost if a task is being
> moved to a preferred LLC?
> 

This is a good question. The decision not to migrate a task when its
LLC preference is violated takes priority over the check in task_hot().

The main reason is that we want cache aware aggregation to be more
aggressive than generic migration; otherwise, cache-aware migration
  might not take effect according to our previous test. This seems to
be a trade-off. Another consideration might be: should we consider
the occupancy of a single thread or that of the entire process?
For example, suppose t0, t1, and t2 belong to the same process. t0
and t1 are running on the process's preferred LLC0, while t2 is
running on the non-preferred LLC1. Even though t2 has high occupancy
on LLC1 (making it cache-hot on LLC1), we might still want to move t2
to LLC0 if t0, t1, and t2 read from and write to each other - since we 
don't want to generate cross-LLC access.

> Also, should we leave out tasks under core scheduling from the llc
> aware lb? Even discount them when calculating "mm->nr_running_avg"?
> 
Yes, it seems that the cookie match check case was missed, which is
embedded in task_hot(). I suppose you are referring to the p->core_cookie
check; I'll look into this direction.

>> @@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env)
>>   		if (env->imbalance <= 0)
>>   			break;
>>   
>> +#ifdef CONFIG_SCHED_CACHE
>> +		/*
>> +		 * Don't detach more tasks if the remaining tasks want
>> +		 * to stay. We know the remaining tasks all prefer the
>> +		 * current LLC, because after order_tasks_by_llc(), the
>> +		 * tasks that prefer the current LLC are at the tail of
>> +		 * the list. The inhibition of detachment is to avoid too
>> +		 * many tasks being migrated out of the preferred LLC.
>> +		 */
>> +		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
>> +		    llc_id(env->src_cpu) == p->preferred_llc)
>> +			break;
> 
> In all cases? Should we check can_migrate_llc() wrt to util migrated and
> then make a call if we should move the preferred LLC tasks or not?
> 

Prior to this "stop of detaching tasks", we performed a can_migrate_task(p)
to determine if the detached p is dequeued from its preferred LLC, and in
can_migrate_task(), we use can_migrate_llc_task() -> can_migrate_llc() to
carry out the check. That is to say, only when certain tasks have been
detached, will we stop further detaching.

> Perhaps disallow it the first time if "nr_balance_failed" is 0 but
> subsequent failed attempts should perhaps explore breaking the preferred
> llc restriction if there is an imbalance and we are under
> "mig_unrestricted" conditions.
> 

I suppose you are suggesting that the threshold for stopping task 
detachment
should be higher. With the above can_migrate_llc() check, I suppose we have
raised the threshold for stopping "task detachment"?

thanks,
Chenyu

>> +#endif
>> +
>>   		continue;
>>   next:
>>   		if (p->sched_task_hot)
> 

