Return-Path: <linux-kernel+bounces-813210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE4B54206
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379647BAF6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52C2275844;
	Fri, 12 Sep 2025 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9cOGdxC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF1274B2B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654681; cv=fail; b=NU6gxNdE0yiGLk9Q7UPa5IJBn955Ej8sRO5N4wKxa+r8W7USEp1KOVJO1qhn0jdjR/M/z0kK391WtOyikG0l2AWu1fmAk62jd44cRfkgdzMoO/y3xXNv5fOpFZVv7jIN0rA4gokA5c26qEfHCRFozE7xrolF0Kcxy2swV3eVUuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654681; c=relaxed/simple;
	bh=NITYE/TnATaMMEQpTAxX3tNMT53qP3tQ2bC/DtYDpBM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IRtm0ZlCJnKGy2t7JjaMLDfuTBfWEGg2SauqEcnj9YuCz6t3GodL+bhFCMwcOgbVYsZEgd0mtzotftcjhhk7WH+JHEk+HD4ZwVjm7NxJaPC09WJUKUu2U809NCGiWIubhjX4kA7P5/rCiBK6KspfR8304+gWw2rbrbgxETGbI7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9cOGdxC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757654680; x=1789190680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NITYE/TnATaMMEQpTAxX3tNMT53qP3tQ2bC/DtYDpBM=;
  b=R9cOGdxCqzS/vWPXd19FsRgsLevrLCT5BYXX97UPQIvwHAVOFNsFaNz3
   33rJnHJRUe49axKBnZUgCrgIb2zSxirZ5L/9OAr+/m3N57D/XEguavGYv
   5KwHRHEe3udk33t0dZcckEqZzJenVJwj8ptF4gqIsTbr453xrIxsjyBlD
   Vg0btNfhmAq7DU1nPmfSquE4l51YVQzM41OO7rR/oVLHQpnYGqJ/9rfw6
   h8DRtrqls3vPa6KuA0eXUGOw+Yj+jY/LDCnGDLVpZNpgmD16aJ50AvpZv
   Tl2OKObaJYkNhuVj+H9zQ5ZmYiqbQw1dKPTnXbZEKXBn3Mo5TKe1rTJvz
   g==;
X-CSE-ConnectionGUID: YT29E2CWRRWy0sMpNjYflw==
X-CSE-MsgGUID: meCy2eVBTUynvVe+ewxY6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63820036"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63820036"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:24:40 -0700
X-CSE-ConnectionGUID: qvzpG5l5Q9Gifl3vSykblA==
X-CSE-MsgGUID: iffshJNLRkC7JVoD0peOTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="173422226"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 22:24:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:24:38 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 22:24:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 22:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+MLc1YgI4nW8d9NyrpB3lhQXVRnudgerr4H1bAKGzqfs7jlZa7Kh+S763b6W2Nb7xwcmgTwLAR84TnjAysoVAqdOnmVSdxipqfrArjkMfP/QKey8Kgu2CuFZ/tfcAoCVhG8nsgyzu3wfo3rP+ajBjDwHdbKHy3g55wGnvV2fuGHnauU/MJUDlRk3ZN7xA5sHzCtAE7dgZWkcW50Q5tEybI2OHcVhHn4bNIzRrNRK+cQbsn1iLn0MJ3u34okc7Qa5swpH5K5Eq9hwxptz95CdIWgkhV6tutVnNccpDEqEd8hMXSHF8SioH44E/8DgmQXCmWz6EkF4j72mlQz9z8l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1n+DYr+0ftOZezaMivdDjFsnfbDOYM3qwf12oHhHrg=;
 b=ndx5eHRnkrWX1KWbmEaCNDZFfN6mQR9N1yY5cdsuERW27nG9ClA/8pss90YlQUaBZC5Rz9355QUN+ic+r3+o9Wk3+6ux0ByFmU/FfXnnRWG47WEZ8O4WKQsFwEurZAnDmnyYAZQ1pU+89d0dfJt+YSY1JaahQP1duc7ajqCU7Wc+qd9CSgMx1BFk1UGQTMZn5EhmG62TWibH53ncc+hUk1b/1HYyC2OiiOg2fC7XLBhCaUfE6VLLO0lexMJv6yLmaSIf9OVWNJ2XZOlUX51IOp7GbIDClFAH0M2vdcNiW/VkXNBm+j7FAYpQfXnc1blk06kpIy/qM/eB9aPKdpKpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA1PR11MB8859.namprd11.prod.outlook.com (2603:10b6:806:469::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 05:24:35 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%4]) with mapi id 15.20.9115.017; Fri, 12 Sep 2025
 05:24:35 +0000
Message-ID: <857e86a9-9007-4942-b005-1574c919ad6b@intel.com>
Date: Fri, 12 Sep 2025 13:24:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	"Zhao Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA1PR11MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 24195b6c-8361-4f6e-ef59-08ddf1bca94d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCtNR05QcklLR3RXaGJDTFROL1VHOWIyU0d2NVg1LzNWWmdWVWpYdjd1R0Uz?=
 =?utf-8?B?T05iYzZBUzZ1S085eWRiWXZGcXJ1dTJwMUY2aWpMelpsRURyVENwMlIxd3Ju?=
 =?utf-8?B?U3ZUTE5nbURxZFVGSDVzSU12SHpldGNzalBkYjFYTkgxZDNTQmt2ZVgwYVNr?=
 =?utf-8?B?YWRGTVpPY1ZvczBmeUJXZEhtYkQzcThWRFlvTnVoYWZ4c3FlZHNwQWVWSnVT?=
 =?utf-8?B?OWtyUWJrcHV4R1ZwUW05aGp3UmJCNlBsWTlUNHYvYW03NUtxWEpOVHlsL2N6?=
 =?utf-8?B?MzhYMHJOWlpKdFNpZW5YcUNQd25KZDcyTHVFUWt4eXVsdit3N3J6Q0N2cVN3?=
 =?utf-8?B?ZWR3SmFvMFhZV0YrdEk3RDhhVzBKZWxDazFuYkZNbHE4UlpkWE5Wd2NmTFRw?=
 =?utf-8?B?VFBTY2YzeStZTjFOUzVvZUNrMEZXNUo4bkc0ZC81M20vbUpDY1llVFhac0ZQ?=
 =?utf-8?B?M0VIcXp0VGJyUVhHc0xzLy8zWWE4M085VGpsZ1VuVmovRWhheWRNMnFlZEht?=
 =?utf-8?B?ZFhFZHFyTHNwLzJ1b3dqb0xMRUFrTWg5bzZBNGFKT2IwRldlUTJ2YjJMY1Rn?=
 =?utf-8?B?VFhHMFlvdVZ1Z1djdVliQjUyQ0svVVRMaFJNaHordmUrNlNLWEUzVkVITGxX?=
 =?utf-8?B?YmFHSkRSaW9CY0JReDNPcU5NZWlaRlE2cXFwVUgyd0FuRXhlL1FraUNER1pX?=
 =?utf-8?B?QkViRzU2dTZ3VTZXcjhUaVBaMXhDMitqTElpSStVcU9KVTI3WDhQZ0pVcmpJ?=
 =?utf-8?B?ZWtnWW5DamJyd1Nmb0NxUENYUTFQVVBmMm9vYkdTMTBhL3FXU3U1c3FFaUto?=
 =?utf-8?B?bFo5cVNPci9LVXZOaG1nNEFsYUVGTDVqSGVWT0cyTTFBVjhWK0FqRFJ1Rkpl?=
 =?utf-8?B?eGlxNEJZTnVpLytPb1lydTNpOXRRd1h0T3pyNmUrQWtlT25TVDNFcmVCNU0r?=
 =?utf-8?B?NitnRWg3cURVMzVjOExJSGtWM0V4dVBwbkc2MjdObmEwWW0rZFcxQWw5U1li?=
 =?utf-8?B?bEFxemdUWElZeVR3bUswZVBySUowYzUvUXpmaS9ZZWlRQXJQSER5VWZySWlM?=
 =?utf-8?B?KzNUaUlFKzNWVVJTM3F6RERSZVNTL1lZOEMzLzVXZTVsVWRxclFyakg2ZnJx?=
 =?utf-8?B?Q0ptckRMaERwTHNMejExcDB0OVNobmhvdHNnM1hGaTFhNmY4MVRGVTZHbHlM?=
 =?utf-8?B?RkNpNkRVTjdqeUNid2dDay8xU0srbmFsNGpDSWNGTERLbXd2RWVLZmZ2MkZB?=
 =?utf-8?B?aXRsUC9pK0lHdk1VR1FxT3pMZE1WaHlLWjhTdzlPZkRpd3JaMFNzQ1JqaW1T?=
 =?utf-8?B?dUp0Z2Q4U1BYaTA0ZXhjcjgza05lNGJOWEZZNTJXZU9ZTHNyUXNIckhrN011?=
 =?utf-8?B?ZmhwcUI0MUhNeFFyK3d6MjFSRHIwNUxEeEJLcU04WHVYV1JCVUQrMXJCNzVV?=
 =?utf-8?B?NkVnWnF0WmlJTnBTK3Q5REx2Zmw0TUt6NU9KSitNczVRK1BPbUFxakRTUHVE?=
 =?utf-8?B?YVVuLzY3Z2xTRkhjbHVIRjd1Mkp1d0d1UUNzdFd5S29hR3l3RHJIRVNzWm91?=
 =?utf-8?B?OTRBdzZIK29OSGQ2eE9La1Q0dngvZXo1NnB1Wm1ycTFDQUppNi91dURNS283?=
 =?utf-8?B?Z0hGTXM0QXZVRmI0REF1OUgyblRzalZ2NmNEVVNZMXkxbXFFSGV1OWcyTUJ0?=
 =?utf-8?B?aTZnWloyM1JyWXhqaUpFY0hlV1hIb1Y3NXhnWmFsajBYWlVERHE1V3lycER6?=
 =?utf-8?B?dFRtb0l0SFBGa29uUExOTWNWajI0N0l6bjVwWEd3aHRVSE0wTXdUZmd3YnVl?=
 =?utf-8?B?TXZrV2J5RGxPZjhqaFAvdFozMUFoUVM1L1VxZS9zYmh6UXJwUVBMdnlpRDZh?=
 =?utf-8?B?WXZ3NUtaWDRxVEdTb3F4aHhCbWNDNS9NQzNxMUVFVXFobDhLNFlJNThYbm1V?=
 =?utf-8?Q?j5IJXrltx/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2Y0aGllaFJ3dEIySmJCVmp3L0poRjd4dXhvbGhtR2NHYk0yMldaRmFUL1lM?=
 =?utf-8?B?ZFRRM1kwRER0MWl5VFRGZlRYRlA0NFJVblhxZlJoMkc2SFBsRlR6TmR4RzY4?=
 =?utf-8?B?VlRld1JjMzB0R3h5SjlxckpCaXd4K1BrRU9hY3pXdXFoQ1QzMitFRlRjd1RK?=
 =?utf-8?B?Y2RLcEdoNWREQWZpa2lrMmtMNzd3c29CdlZtSEdDNEowb09WKzNEcHN0UHly?=
 =?utf-8?B?YVpRZCtlQlJvZVdvWnI3T2FFOER3WkczaytoOHFENCtRdnJFN1ZRTEUxQjhz?=
 =?utf-8?B?LzhYeUdwVEtYTlAzZ2VaY0pDRTVDYWtRbUJrK2FreFZoV0ViY0lYcUdsZjBH?=
 =?utf-8?B?ZVNpVnZTTjN0dHVLY0NqbFpEZWIzUXNWdTdoNFlOanFDZEpKSHNXdU1UZTA3?=
 =?utf-8?B?QW5PeTllNXVNM1czazFuZm9nbnQreGorRDNadkRxbEJ4djErTFY4anFVTU9v?=
 =?utf-8?B?alc4b1ZwaDFXZlpGUWp0cDhRWGgyZHBPYU1rVjF5bElqaHozRzZUVjF4NlZm?=
 =?utf-8?B?ZVpvV2JOREpvZnNrUGpRK0xZZDkrK1d1M0tPYVVidFVVdHFNUmZ6R2ticmUz?=
 =?utf-8?B?NmtMRGVOQU1aL0pZQUtRQWZnNnM4bnJRdTR6UzBFZ1Q4SXJPazBxVXh2L1cv?=
 =?utf-8?B?SmEwYit6WWJlM3ZlaFdzckJQV0YvYTVuei9ObFdRMHgzQnZEcEdaVC9uVkZm?=
 =?utf-8?B?UjhDUStHN1dIRGUyVGpwVW8xbmwyVEhLcm9XZmJFd29DbGtKYU1aZ1R5Q1dt?=
 =?utf-8?B?Z0N1eTVKNS9qUlJaS2h5M1lyNW50ZW9PalZoWEo4Qkk3ODJGdDNLQzVwM2hm?=
 =?utf-8?B?K3RjdHJ2WC9YcnN3Wkx6cERFNmVUaUlFbmM2d2JEZmRNNHlNWGRmUFFaWnlU?=
 =?utf-8?B?WHl2bEQxcUYrdnZ5TUpKTldvbWZOdWVTVTE2Z0djVFFBS09RQlhPeDJhZllP?=
 =?utf-8?B?M1JyT2R0ZWJzeWNUb2pQSEZKalVUUTljeVdLZ0pKeUgzNWpiMkN5Qnh6NENL?=
 =?utf-8?B?OWVTV0dQZjhxbWFNYnVjaHVUcndVU1lvcFRVVVN2OUdRcUN1K0IwNjZEQ0gv?=
 =?utf-8?B?VWJJNEFnMDdnYWk0SmVDbkJFWTBmSS9sZkZ2K3B6bjd4SjdMK0tXa1JoWlYv?=
 =?utf-8?B?SVNSaDRoTTY0QllBOFJESFVsTmtsU0VYbG9NalkxUmNhc0hxT05OUWpBdFNG?=
 =?utf-8?B?UndWTmFnUmZONlJ5bmU5TEVlNkJET1lLenEyN2JNTXpIN2hEM0ZSc1ZoL2Ra?=
 =?utf-8?B?YnBXcUJkN1RYOXhCYzJiUzhMVWVzVFczNXJBTUxVUDJnR2huQVlZb0RlQlZL?=
 =?utf-8?B?WnE0Q1Y4YWN6bTZDeXlyY0Zma1BZbk0wSjFMeWZkald4ZjdHM2lYLy84LzBu?=
 =?utf-8?B?UG1uOWY3bUljOEw0VHdSU3NYM2VKazFqcnlUSzNMeU5yYUlhQ09wVG5uRHdE?=
 =?utf-8?B?Q3Q0TEd5eXJrQ1VVSnpQQytHNFpRbkhkb3VIWjVLZEE0Q2dEbW9qOFpFTFB3?=
 =?utf-8?B?cmpUSk4vQ0pTZ01CREwzZHY0dkF1ZU1oV2NVSURkK2pFcGtxR05Hd1lqcEtZ?=
 =?utf-8?B?TW01U1JETTVoY3loUDVTQVdhRnBUOWtWVzg3KzhFYjNlMGNvQS9RSk4yRTkv?=
 =?utf-8?B?U3htb3BKZ1VVOG1vbEV5Y3NyZnd2RUpvckZkTjJvek85QzV1MFExTlZwV3VL?=
 =?utf-8?B?VHlHeFdZWE42L0g3enVNRmhnMkNqTGZDZUlDSkFTQVVmOGxKTUpZb3RZM0dx?=
 =?utf-8?B?MGJJM3FUdGJreEphaTNMMXo5RjhJMmMyOC81dzZGb2x5bTFML2xsQ1JFR0Rz?=
 =?utf-8?B?VjQ1NlRVTmM4RHhsdXJTa01NTFBCVHVGMnhUNmU1MTBNcGE1RzkwOEJYL0Z1?=
 =?utf-8?B?RzVub3VtODcrb1gxY2RJbHplQklva2cwQm92Tk0wZmpwd1J6OHdDU21WM2lq?=
 =?utf-8?B?N2t6NWx1RDExZXo5VEZYZ3BOSmRCVEhidzN4bTV5UEhsL01XaXY0NWxSZnlK?=
 =?utf-8?B?U0I1eWlEM3U0L0xuOW00dTZRSGVmWi9XeTFPQUFhSzdlK1FUMXFESTJ2SFNO?=
 =?utf-8?B?NXB3bEdTbklkSWsydEQ2UnVOekVGbUJncDk4cHM3di96b0dEZ0s4TVE2YUFn?=
 =?utf-8?Q?9KWSRWeUZL/f/TCtnycW5H5LL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24195b6c-8361-4f6e-ef59-08ddf1bca94d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 05:24:35.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7Urx9fLAz9NQWX1pa1mkf2QCXv+4BAnYwinG3+Jn9ELC8W2D3o308nzw2peyB9btyM+SY+bB0B9lSh1X8Mcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8859
X-OriginatorOrg: intel.com

On 9/12/2025 2:30 AM, Tim Chen wrote:
> Allow architecture specific sched domain NUMA distances that can be
> modified from NUMA node distances for the purpose of building NUMA
> sched domains.
> 
> The actual NUMA distances are kept separately.  This allows for NUMA
> domain levels modification when building sched domains for specific
> architectures.
> 
> Consolidate the recording of unique NUMA distances in an array to
> sched_record_numa_dist() so the function can be reused to record NUMA
> distances when the NUMA distance metric is changed.
> 
> No functional change if there's no arch specific NUMA distances
> are being defined.
> 

[snip]

> +
> +void sched_init_numa(int offline_node)
> +{
> +	struct sched_domain_topology_level *tl;
> +	int nr_levels, nr_node_levels;
> +	int i, j;
> +	int *distances, *domain_distances;
> +	struct cpumask ***masks;
> +
> +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> +				   &nr_node_levels))
> +		return;
> +
> +	WRITE_ONCE(sched_avg_remote_numa_distance,
> +		   avg_remote_numa_distance(offline_node));
> +
> +	if (sched_record_numa_dist(offline_node,
> +				   arch_sched_node_distance, &domain_distances,
> +				   &nr_levels)) {
> +		kfree(distances);
> +		return;
> +	}
> +	rcu_assign_pointer(sched_numa_node_distance, distances);
> +	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);

[snip]

> @@ -2022,7 +2097,6 @@ void sched_init_numa(int offline_node)
>   	sched_domain_topology = tl;
>   
>   	sched_domains_numa_levels = nr_levels;
> -	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
>   

Before this patch, sched_max_numa_distance is assigned a valid
value at the end of sched_init_numa(), after sched_domains_numa_masks
  and sched_domain_topology_level are successfully created or appended
, the kzalloc() call should succeed.

Now we assign sched_max_numa_distance earlier, without considering
the status of NUMA sched domains. I think this is intended, because
  sched domains are only for generic load balancing, while
  sched_max_numa_distance is for NUMA load balancing; in theory, they
use different metrics in their strategies. Thus, this change should
not cause any issues.

 From my understanding,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu

