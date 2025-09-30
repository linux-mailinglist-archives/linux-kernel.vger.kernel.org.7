Return-Path: <linux-kernel+bounces-837096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ADBAB5FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FAE24E1A83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCB222560;
	Tue, 30 Sep 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqgsoXnU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFF2CCC5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 04:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206715; cv=fail; b=glhi69SKc+WMnDFsh0W6y3NXWhRx8X/GYBldB2Yit9ACADmEnbBtS3dKyQrqqBiexbhSr/gnYxdTzbUg5yTvRGhT9Rp7n0+fv1QSP37lUa7/xlRFCOPpMnWj1tKwhOQ4F9N2Q6Ct+0q2gvgJfpaxPZII2Xd+GOvI3rylP4kErcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206715; c=relaxed/simple;
	bh=ZDetvlqZEzmElb94h/vQYsOoqYdvVVxBG+/li42fy9w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKLS8vN2cqF8p5dqcJX02UCzoryrdPk3d8HVvtXScvUTp4HESGIbJbe2+uu0eatsBQeiyVHkWprog9XvJCk9iAg2c+ljDHaBOOQzpmymRElf9XXpGN3tpOs3lQPQlvVTM4P5NtNSpA2aRT8JA5gkhQ+s9RGM0mX+//IbFLim+Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqgsoXnU; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759206714; x=1790742714;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZDetvlqZEzmElb94h/vQYsOoqYdvVVxBG+/li42fy9w=;
  b=VqgsoXnUw8Rc+3/JpiJVK0sIJkhRK03mq7h1ujBmhUSeoJzQH9XFM9xP
   IHdUidFnEesREi+LEDeyh5xTozUF7FKWskDhASRqgSUVQGX3hbNIINV9m
   SeTkmTqKO+qAm9zFYd/2x6MsvGFD0Pv/wwB52kck0cyekvk3LfdXjW7mv
   fTmBMZz9DAjxKY+DWhSJnruZWys8GmoYn7uwmgplGyvzBPZpyc+5ArLss
   OTWwseMzh4duR5ZeDDAJrA2+jMhB5DFm8K1r2zezCgPEDWnkqIiRYdSun
   B/mfXb1yQAypQsabNUk08WUgdNZ5F35z9xutJU5ZFLK8dtU2cMkto70WO
   g==;
X-CSE-ConnectionGUID: hNIQYeAnTN+ls4FhS01obA==
X-CSE-MsgGUID: Em0zV37BTre54HQu19Jf3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61413462"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61413462"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:31:53 -0700
X-CSE-ConnectionGUID: N5zdzCLfT5CyM4RYSBpHrQ==
X-CSE-MsgGUID: 8z60wDTaSvaUnsGb5rSACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="178208786"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 21:31:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:31:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 21:31:51 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 21:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gts/7wWhnQWQGpNAkaZLU53cZNwVjdZhrhNh53BQibrdz7eF4Yt6Uz7shZcCOWonxftfc3kYEUwYqCnwkpfIH/6E09RYygBWOhqGJX28rlfZ7gdx2/+fUwG1+Qe2Rn2BeGN9BxbIA7NLq9xZ+drQ8eLJn9D5mZaELZr73YCnrLOABipD7Vz2LtlPSbypHYUuS37tOAfhRaXHG2SFLsla8iNPG8nbwGUTPdtwkIL+Jg/ekQYS7QX5unDeVC8bFH/bnL/iBLCOXvFTOZ8z2y/7Om53nwefBO1T9dnkIm7PM6U70b7fmE15HKRvbRcvC7mAoOV1XvpgepG3JuEx+MwojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBwEh0W71y7nKju3FYaMyFhDbzpdzFd6NVsMClGBrLg=;
 b=j6YAyVmKCKLpUxu2VEnLOr6FSUPs+tktWQflYAiVm1/yS7USHUhRvbSibR4GH2DdyYa6f+/z4FoTJUQhyoTVQSY7CqyZtRUefny5Qc+ngp8bHSG99MF3p594EpkrhnB/ATqsya/NzsEiL57+pxISugVV8RIjWYZG0N/TYZKp+QGjtUfuvUe46R9f8s7fb2bnOvCAc0PfMhoRUsCq64QcTxjalvBA87wkWy8tGF/YReYVbOucUnWf1cAh7gd7NnUDnCgnwaO5Rq4vEvV4lCLI+xRcQ4pAyd+h5NcrZ1MQgfQeD/YDhkQK+cTCSPq5vEPrrF6xk4qSqy1O1IPw474QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SJ0PR11MB5152.namprd11.prod.outlook.com (2603:10b6:a03:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 04:31:42 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 04:31:42 +0000
Message-ID: <11b8de67-ce3d-4c07-a5b7-1c8e1f58f71c@intel.com>
Date: Tue, 30 Sep 2025 12:31:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 05/28] sched: Add hysteresis to switch a task's
 preferred LLC
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
 <e51f8a6e172606d520c91c94c0c14b045639217e.1754712565.git.tim.c.chen@linux.intel.com>
 <20250929134447.GM3419281@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20250929134447.GM3419281@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR04CA0025.apcprd04.prod.outlook.com
 (2603:1096:d10:25::15) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SJ0PR11MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: 6200bbe5-75c1-42cb-80aa-08ddffda418c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk9Id2QvOUNpU1NuWldJV2dMc25KSDZRNGU3YTU1UWVmN2YweENXNjVjd1Ji?=
 =?utf-8?B?aXFucmExZ3NCUGFBQWJUSW5yWEtrVHlOYlJKcFhrUmxEaEErMXlqVDNpaXJh?=
 =?utf-8?B?cEpsK2lFVmdHMlpyNTA3ZEhESWpDeGVYbVU2YU1weXdBcFU3STFxKzRoekxM?=
 =?utf-8?B?ZUxsMVZIUFVTTGlDcXRUUW1lOEZJaGgwRS9VUHFoUTZuWnBaUDd5OWxselJl?=
 =?utf-8?B?c1RSNVRvZXFkNEpDeGJvOXhYMHQwVFl1MWR3TzIyRWNHKzFweWpNYnFmcU9V?=
 =?utf-8?B?RzRRaHphVG1PcklJeDVBbnY2Y3FvcnpCcFoyZ2FnQkRDRFc0ZmIxN2YzRk9z?=
 =?utf-8?B?R3RRUWRuVjQ3UmZlRnM1UzBJZjZrSEQ4Q1FIWUtkRG9DMnhWY3BjUjVIRVJY?=
 =?utf-8?B?SExTK2tsR2JET3hpRW9WdHFPcGhIeTlmMHE2aHE5aUJ1UGRaU1BtRGU3dXZv?=
 =?utf-8?B?THlvZlpiTThZNFc1U2RoS3cvQ2NtR3dOSUpGeXBhK3ljNGZXdGJ0NC9nZTJv?=
 =?utf-8?B?TEVpQjk2MGhGOUl3VFZCd2t6N3JvczhvYlh5NzErOHNCRTgxZDkxRnZPZ083?=
 =?utf-8?B?cjMwSk9OaldIUWtBWHZqUkxYS2I3UUxidzl6Q2ZHMTQ3KzB6SW5TcjhLdC8x?=
 =?utf-8?B?SmZKOUFUd29QYXorN2l5c3hFMzJHT3IwdVM3OG5Ib0o5NWhEeG55Z0Q4TXVm?=
 =?utf-8?B?TytMUzcvZk9Ta2c3ZXJVS3kyTW81S1R0VHZMbG5DODFuR0xHQk5hSWQ5NmpL?=
 =?utf-8?B?eDZ4akN6SDVoeDFOSkE5UGxJTm0zdmJ1Ujc1SVF4SlNYaHM1dFJlaUI3SG5R?=
 =?utf-8?B?ZGpaTDBuMXp0UFFvRS9PK3RwMGk3VzhQMTlCNDNwcE4zbXV6L2w0QjMyb2hp?=
 =?utf-8?B?akx0UkJKc2dyUExSdFRRWDJWbTQ3M21BSUpJcEpObHVwWm80NU4vV0VDV0c5?=
 =?utf-8?B?d29YNXU1K3BhcU1yclN0aFFXOTJjVktpWFdGTjJpc3JPUkJPV01lT2w3ODBE?=
 =?utf-8?B?TUE2NnpwVHAwVkJ1NE1sbHZ3cld4c0xGNzNtcHEwM1ZqeVAzRjUySUxZR2g1?=
 =?utf-8?B?MG5FS21vVU5UN3BpRU1pd3NoNDNVejYwU3dJRHNicmZ5QUx1V21xN1dlZW5z?=
 =?utf-8?B?U2ExZGRRNDJaYXRVa2FpT2wwWmJ2eDFLVEFMQ0xCekRUOVJ1OG1PRURGRExL?=
 =?utf-8?B?OThKM2t6MTdIY1libnpWazZma1VHVWV1U1h6WXMxblpiOWszVzJlMGhIMkZs?=
 =?utf-8?B?QUFRaWM2R01oNlZ4M3YwYWZTM2dhM1QxdjNTNmh1QjFYNHNlWjFWWnRJSEV6?=
 =?utf-8?B?TDdqUVc0dy9oVE55L0VrTXYyOXVMSExXN2kyMDRXS2VsS2s5bzdLYnNtSmpx?=
 =?utf-8?B?RTI0eGtnakJaS1lyY2w5VzRqOHdzcEtCN0lncExNYzdnV0VhdE5JYmdVSnAz?=
 =?utf-8?B?RlZtMzIxR2xHVTBLdDhJMEhiSUc2M21QQ2VWQ2tYRko5SjZKclFHV3JlQVdN?=
 =?utf-8?B?c3FvM25xNUR6dzlFTUI4QWdQMGxpNEZzUEdZcmkzWHVEM1h0NUtHZnNxS1Nu?=
 =?utf-8?B?a2JaVC9ZcFNTQTVtYzdtR0NmalZzRnpKUHB2SG05Vzl2dlRGV0tEczJmcVB6?=
 =?utf-8?B?ZVNoNlVZU1BQU2pXbG95aUlHZHFtaEpMWTBwVnlQVUd1S3Y2bWhKZFZGS2JP?=
 =?utf-8?B?NUhkMkJrT0pldk5TYlY1d1R5Z05GV1FSSkRHZTUrOUpZb3R5alB3TElseG5U?=
 =?utf-8?B?c1c1RjQvOWpiR245VEhPTTRxeU00NmJEZXNmam1TMVFyTGlxL3c1b3BQS1NW?=
 =?utf-8?B?ZzIrT004dXJMc3FkSlBrRDlUdS9BUm4xdzBPUUw3UVd0WUNhUzRyUERxbVF3?=
 =?utf-8?B?WDF3Yy9FQ3BoS2pHWWljVnVIRGFweENGVlcxMitpVGZXYmoyL29nME82OFNR?=
 =?utf-8?Q?F8Ay+l+2T29uZ1dzagdpfWUrIj6Nx5qD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWdzTUVCc3lYdlc0eHl5alAxMnJFUDFzZDBGY3JlcGR3R0dUVnJITlVoMCtj?=
 =?utf-8?B?Y21ydlZjelVtVTg3eE00Z0twZ3JveTJCeWVjOU1ySWhQcGRxbytjMVg1OUhs?=
 =?utf-8?B?N29FOVVlN3BaREY1REdVd3VWcmZKSkRKT2lJRFJ0b0w1dndoM2crd1Nmczha?=
 =?utf-8?B?MkFLZjNXWm1zYTYzUHV3NzN5bHl0OU81LzFlY3oxbm1zMUl0Zy9MelNMbHU3?=
 =?utf-8?B?N2lCSGRYNnE3NkFTb3BnWjY3ZVNFNW04eUk3MXozcmsyN2tJMjY5a25jVVN4?=
 =?utf-8?B?RURUY25iRW56SS9iOWpScXBWV2UrcmZ1MjRXb3RrY3VaTnZndExjT1FFZndM?=
 =?utf-8?B?NVhSa3JZTnVTMVJqRUd2d2dnMVA5TEpzT3RRTVlaclJEN2kwcElEQ2ttWkZJ?=
 =?utf-8?B?ZVJKMS9TZ0tOYWo1TlNsZkdyT2ZOMmZnc2NzRlE2RnVvRTUwdlJTbzZYS0Nw?=
 =?utf-8?B?a1N4RTN1UmZSUkwzbzZEV3BMT1hXZHVnc0k5enFqWDVMdGRLYWJOUmxFeEpN?=
 =?utf-8?B?QitvK3E5Z1lQR0liazF6OXdldUE1VzQ4MVdwa1VIRFBBSjY3bXFpc0NVRC83?=
 =?utf-8?B?S21zVjI1dWl4aEtDWC9xMVQ0Ukg2b1FhaGZjWjZuRGxsSHFBaSs1Y0ZyT213?=
 =?utf-8?B?bzlPYVZkSzZXdVdhZU5sMHEvc29rYVNFVlRqNTRlUHkySSs5bWhtS0h5OWNF?=
 =?utf-8?B?NnFkUlR2aGhJQ3hZb3hOUjBDbFZDSmZwazZuNjl3aVdSSGxyODhQSHVCdFFQ?=
 =?utf-8?B?SUl4VjN6WDhaSmR5QnlteXhPNzE3SnFmMjlRTlc0Tlpvc2E3cUZFc3RTTEkw?=
 =?utf-8?B?Y0FmR1VmdnZ0b2tGYmcwQVo2WjRqekw5NkxXMzc4d3ozMWZ4cDdCVGNDUXc0?=
 =?utf-8?B?cUlHNm44OHgrdnBHV3BveWZIRnVRcWZWdTB0S2NPcXFidk5rT1hxNEh5ZHdx?=
 =?utf-8?B?VEUxd3BYY1kxOWkwSXlsV0FXTHR0cGtxQ3lXT2FGRlFZTDQyeWx6TGVURkYy?=
 =?utf-8?B?WXZkbGhVRkZxcjZGQ1pLM3AyeFp5a1g2SXBiY1ZrRC9IK3lGZlM5bWpSZFRz?=
 =?utf-8?B?a0k5cm52a0xKVlREWEZ0TFdqV3lBd3lsdWR1eGYyOUlGb2N1ZDJGekxPajN3?=
 =?utf-8?B?VXFSSUpoTlNHdmQrN2t5TnFibFhwM1JraE9CRWZqSmxCdnVKU2xEb05xRS9R?=
 =?utf-8?B?dVJkL2xNSFNpRmRUbXNwcjF1bXIvLzh5K1R1dGVhZTVRUElVbVVJU1lnaE1Q?=
 =?utf-8?B?WHV5aWk3U0tuOWQ0cjdTczVrU3VsQ1VPOVdjMVlLVjJoalRDakhCQlorQ2lF?=
 =?utf-8?B?azIybWU3YUFkVFdlRTZUQk1FOXVPYkhSVXVRU1BjN3NqeVVnZFNvSC9QT25k?=
 =?utf-8?B?WFVwcUZvam1wbFJXbk9TaE9NbWpxWDIyUkF1U1dVS2JpSy9jNjRBNG9jZWUr?=
 =?utf-8?B?NnpLMVE3M2IzR1Babm1BKys3aUJQVXAyVW9xZFZENVJPaHBoVHpoaDg2TjlJ?=
 =?utf-8?B?azdwMGxoNXh3TEVpS0Q4SVF0VUhOa3d3S3kxa1ZRc1JGNTJXNXU0NTAxNUU4?=
 =?utf-8?B?WUdEQllaaTZOR2RaTzh2b2pEbWFXOXZ4dG1OeW55dUwxWG1ZTnhVUVhFUHB1?=
 =?utf-8?B?UEdURWF6MjRCaDNpN1JqTVdYNkxBYkZkMmRIVU1yY3VDYXIwTUdFZUdWeDBS?=
 =?utf-8?B?aWZCdE12bUllZjNXbnpEeTdXWVptSTBacVRWWlp3bDFMRkkxNlcrOXVHRGFF?=
 =?utf-8?B?VHFSZWN4VThLcUdOUGFCT1JRNFE5NTg1bmEwN29Ed3ByVmJSZ0FuK1ZzRzRk?=
 =?utf-8?B?OWNmQW9UZy9YWHhqSEJ2QU1va2dwcEZydlJ4dVhhbkdiTjZxcVlmczh2ZTlL?=
 =?utf-8?B?VDY3VmdtYWIyMEI3YnFrOFBlUFNiME5wOC92K2RtRjlYVzJqNFBCZ0xUV2RJ?=
 =?utf-8?B?cDhnNnpkWjJ1UG9PL3lWUlZFeVhhTG1wR2NXOVhhelY2MFpjd0xENkFQeTJt?=
 =?utf-8?B?NFQwemUyMjdmZ1FLRjNhQ2lSeWZXZFRiQW1DVWpPUDVmTVpCd3Y3V0pSMzlE?=
 =?utf-8?B?NVVabm5jamEzSmlMbS94M1cybllxRmhObndwbHplUFFsN3dyT0kwRWZjeVN5?=
 =?utf-8?Q?ibzaC8TLCwaNgarOIbGwcZStu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6200bbe5-75c1-42cb-80aa-08ddffda418c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 04:31:42.7907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbCOjH0pP3WFM3oAyggpRL7cUTg8JHfP/bGoadAfwjwjctqWqnAkpxsqhMn0iQ28OCEo0NE2UllNzcQQIXmEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5152
X-OriginatorOrg: intel.com

On 9/29/2025 9:44 PM, Peter Zijlstra wrote:
> On Sat, Aug 09, 2025 at 01:02:18PM +0800, Chen Yu wrote:
>> From: Tim Chen <tim.c.chen@linux.intel.com>
>>
>> Switching a process's preferred LLC generates lots of task
>> migrations across LLCs. To avoid frequent switches
>> of home LLC, implement the following policy:
>>
>> 1. Require a 2x occ change threshold to switch preferred LLC
>> 2. Don't discard preferred LLC for a task
>>
>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>> ---
>>   kernel/sched/fair.c | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index a7be5c5ecba3..9e3c6f0eb934 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1175,6 +1175,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
>>   #define EPOCH_PERIOD	(HZ/100)	/* 10 ms */
>>   #define EPOCH_OLD	5		/* 50 ms */
>>   
>> +static int llc_id(int cpu)
>> +{
>> +	if (cpu < 0)
>> +		return -1;
>> +
>> +	return per_cpu(sd_llc_id, cpu);
>> +}
>> +
>>   void mm_init_sched(struct mm_struct *mm, struct mm_sched __percpu *_pcpu_sched)
>>   {
>>   	unsigned long epoch;
>> @@ -1307,6 +1315,7 @@ static void __no_profile task_cache_work(struct callback_head *work)
>>   	struct task_struct *p = current;
>>   	struct mm_struct *mm = p->mm;
>>   	unsigned long m_a_occ = 0;
>> +	unsigned long last_m_a_occ = 0;
>>   	int cpu, m_a_cpu = -1;
>>   	cpumask_var_t cpus;
>>   
>> @@ -1345,11 +1354,13 @@ static void __no_profile task_cache_work(struct callback_head *work)
>>   					     per_cpu(sd_llc_id, i), occ, m_occ, m_cpu, nr);
>>   			}
>>   
>> -			a_occ /= nr;
>> +			// a_occ /= nr;
> 
> This seems broken.
> 

The original thought was that not dividing the nr might help in
an asymmetric LLC scenario.

If there are 2 threads in the 4-CPU LLC and 3 threads in the
8-CPU LLC, it might be better to choose the one with 3 threads.
But it wouldn't be the case if division is done by the nr.

And the NUMA balancing fault statistic behaves similarly:
it compares the total number of faults per node rather than
the average number of faults per CPU, IIUC.

>>   			if (a_occ > m_a_occ) {
>>   				m_a_occ = a_occ;
>>   				m_a_cpu = m_cpu;
>>   			}
>> +			if (llc_id(cpu) == llc_id(mm->mm_sched_cpu))
>> +				last_m_a_occ = a_occ;
> 
> Not 'last', 'curr' perhaps?
> 

OK.

>>   
>>   			trace_printk("(%d) a_occ: %ld m_a_occ: %ld\n",
>>   				     per_cpu(sd_llc_id, cpu), a_occ, m_a_occ);
>> @@ -1363,13 +1374,10 @@ static void __no_profile task_cache_work(struct callback_head *work)
>>   		}
>>   	}
>>   
>> -	/*
>> -	 * If the max average cache occupancy is 'small' we don't care.
>> -	 */
>> -	if (m_a_occ < (NICE_0_LOAD >> EPOCH_OLD))
>> -		m_a_cpu = -1;
>> -
>> -	mm->mm_sched_cpu = m_a_cpu;
>> +	if (m_a_occ > (2 * last_m_a_occ)) {
>> +		/* avoid the bouncing of mm_sched_cpu */
>> +		mm->mm_sched_cpu = m_a_cpu;
>> +	}
> 
> 
> The whole double thing doesn't seem right either. That means that
> anything over .5 will never be able to change, even when confronted with
> say a .8.
> 
> Also, while this is a threshold, this is not in fact hysteresis.
> 

I agree 2X might be too aggressive. The threshold here was intended
to avoid switching to a new mm_sched_cpu too quickly, but it is not
intended to address the back-and-forth bouncing issue that hysteresis
would resolve. Instead, the task migration bouncing issue is solved
in patch 7/28 via a hysteresis.

Maybe the comment above:
/* avoid the bouncing of mm_sched_cpu */
should be changed to:
/* avoid switching to mm_sched_cpu too fast */

I'll investigate an imbalance_pct value that is less aggressive than 2X.


thanks,
Chenyu

