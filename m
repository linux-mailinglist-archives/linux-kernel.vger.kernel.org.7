Return-Path: <linux-kernel+bounces-741647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1538FB0E731
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 01:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C37A8B89
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921F28C032;
	Tue, 22 Jul 2025 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjT8GuZM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2CC28B7EE;
	Tue, 22 Jul 2025 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226847; cv=fail; b=knF62SVqcT/YhAa9D1jOMI7jd/88KpHhgUu1R1B1XmbuKVx9Mr6lJQUEBSWXlRsPOYm+6UQGzTGGk0AYm5i60l/7fL9BtzHyK0lZpLK65JnjoKZxm7BXLUiqG07MoYQVAdaCMmWnmpgLptDzoDfIltU+JRqOvARQUPJwyR6b1AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226847; c=relaxed/simple;
	bh=PZSSUz+X2TiT4oXbBMHq4JTdgdVzbeUD3bzKPBerSKY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gkw1oslL3pM7jzDiWpjBMh9iqXEUIyDmmRGF9C8ybKcpcKtFy6jOZV+AZJTzV2l92ezYdprehCMo6LSvn0pD0RD5Qvv6jIihNBUpeY57VsdEC6CkXcUgFBLLsoTQwXtlk4qzpUi6s7zRHi8/Ss9jxZzm4HaRwZOyhIqmaTi1YD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjT8GuZM; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753226846; x=1784762846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PZSSUz+X2TiT4oXbBMHq4JTdgdVzbeUD3bzKPBerSKY=;
  b=IjT8GuZMPDWZq51kW3Nnd/lKOSf+m+bOFCTvRVg1NiTCOnWYnOGGsuty
   afnWVT74mTPXkDgRIeeyXHrYvaeqoJMr25kGc0zBQbH0Aa/bFJEJgSj3Z
   BlMD1uB8aSSisfyAPJGQAlt2Dd51ICTflixxLUgAo/qWEzx+CVoDggp9F
   Uufle4u3o+dFyGkF2csMLNRdhjffPbcXqGORoek0tMY98/2QiTL7ttFcq
   L5KutiYTOiwoz+sL4UwBwK7rSF4E0wICdTUKvw1namDWmwEIuWIfPRFcT
   c8HYIC1X5vs/8S5LwJGLTUwzPUHwfLRAvcjoGugyILgSsfF0NLRWBzZXy
   Q==;
X-CSE-ConnectionGUID: 240pkk5URMyrl70o70swWg==
X-CSE-MsgGUID: Z1CuiHvSSyWckfdtO5x1uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="55199453"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="55199453"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:27:25 -0700
X-CSE-ConnectionGUID: Gk9vMVuXSK2xjnTTbhJC6A==
X-CSE-MsgGUID: D7+WEuffTT+59DQO9T8QXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159831325"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 16:27:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 16:27:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 16:27:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Jul 2025 16:27:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFztOlcYIvOff78DU3ceTeOSzWjBKTCUWFNg0leawLwJVRqHxWvRlteg+NHSa7Xp2N7HNk0BThs34TvNeHZw76EzdZK0bRqWrOoAmnglPO1OonEBfEmVJqHqbwLt9/0Tso3/j6/dSF1S3K+gD75+06XhrhRJzVgvy4+yhD1SeF+ygX1QwdZhDMyacsdmAFR2G09o+Eie6yBj66SNmxV56sRkZ5pNnr7SI6kyphdY8dAgYhcq8cO5nj/GXYS5Yd3jfUreDBwUynaVMETTxbw25Wip0oKJ/7VPyR9PFBgCUpLI2e+Dde0X8DTz/RBBvI3g+31PiDgn4O+CirjqG7sHBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzh6xSZkqj8UMDILAzILxMUCeg1PQQrzKJknbOLIfRU=;
 b=D84itO9cer21XNWb2vMk3p0oeK8kwxcOxV/ekzul3/w4m3PsIcmj/NNfOtoZjC6U4vky9bhN7BX1zCOaiXkBmIVIBkq65onAuyFC1T8VPIsqrdsyP7hl+cJfZus7ZbOPPXSDZjSzkvYC22zeETOw4RT8+ipwMukK+qIgU4k1tD00c3ofjV+mv3CHZgFBU0EM8Xdp+rcGv+hMCnnMcCJIu/rVLAsvgsniFt1VXbEwzYm//Br4LQIX8RWBcK1EXw7QRY1Ir7HqY1SCP4s8t3H/X1EHB/II3zjwHiXTdIZ08pyi0ZOyDEpNpaCo6mHPxPeSrSLb0SykFqsPaSwBin0QOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB7103.namprd11.prod.outlook.com (2603:10b6:303:225::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 23:27:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 23:27:19 +0000
Message-ID: <bdb5dd0f-e60d-4d79-9543-ed7352414df6@intel.com>
Date: Tue, 22 Jul 2025 16:27:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/34] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<akpm@linux-foundation.org>, <paulmck@kernel.org>, <rostedt@goodmis.org>,
	<Neeraj.Upadhyay@amd.com>, <david@redhat.com>, <arnd@arndb.de>,
	<fvdl@google.com>, <seanjc@google.com>, <jpoimboe@kernel.org>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<manali.shukla@amd.com>, <tao1.su@linux.intel.com>, <sohil.mehta@intel.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<xin3.li@intel.com>, <kan.liang@linux.intel.com>,
	<mario.limonciello@amd.com>, <thomas.lendacky@amd.com>, <perry.yuan@amd.com>,
	<gautham.shenoy@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1752013061.git.babu.moger@amd.com>
 <d31ab6c51a57591423d3aa7b8e741972cd66eb91.1752013061.git.babu.moger@amd.com>
 <272dc6d5-eb63-4dde-8201-880acc9a3846@intel.com>
 <1e8b0a20-d12c-4f1b-9fc5-c4dfafb7c1dd@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1e8b0a20-d12c-4f1b-9fc5-c4dfafb7c1dd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:303:b7::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 56322660-93e9-459b-3988-08ddc9774d55
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDliVlNZKytSWnI1T09Scm56Sy8wRHo1dFpMM011Q1J3Q2ZET2pCd3R5ZXBz?=
 =?utf-8?B?WHFUQVI1RnlxQ2plUVc1U25uZ000c0VoV1A1djRVWnZaVnBQRzdNaGxjdTZx?=
 =?utf-8?B?Q29zQndPcnhaZEFBU1hXZGtUMXpRcnM0NURwNDRzK2FlOEZmSmdWRitNVW0w?=
 =?utf-8?B?NHJreVp3Sk9mOHVnbTlIYWN0Zm5hYUp2UEVYbDNrV0dUQks4aEpjT0lrMndJ?=
 =?utf-8?B?RXFSOVBkZ1BZdG9wT3h5MGk4MUQ0VHFaYlFLay9QUWp0UE9LRmI2emQ2S3Ju?=
 =?utf-8?B?cTJtakVpVHp2YkpoeFFkY3E5NGJsVVJyM0RoS1FnMW9zNHBTL3YxUVZSYTZK?=
 =?utf-8?B?bzhLQmxnTmVHN2lhUW9saTRUb254Y1pyVVZJNWswYm5hdXJBeDZUME5oY0hC?=
 =?utf-8?B?eTNiekt5bzdqT3IvNEtXR0syb0dlK0pVVERhblhBVFlhZjVXVUFUN2c0SjNH?=
 =?utf-8?B?N01vTEhDZWUveXBTMzJNdmhxUDZza1hiYndsTmRkdFpMd2V0NnR4Z0JKL0pQ?=
 =?utf-8?B?TWd5dFUzTkIvR3dIUHNVTmlxOU5BQjYyaWdTWW54MU5vUlFoc1BpMEUvdlcx?=
 =?utf-8?B?dlZYNTRYYU1ha0sra3J1ZlZWREpHd2VoUTlRSitlWVVoME92b2FsbjhmY2ts?=
 =?utf-8?B?d081WnhpdzlQcUVFSnh1c2FZd0FIZVZ2WCsvN3RyeURoM3JmWHprQjI0Qjgv?=
 =?utf-8?B?V0s5azkyUDI5YmhDM1ZFcW1tYXNFZWkzaHgzcFd5NWQ1MWF1ZVZkNFZzWDBW?=
 =?utf-8?B?LytBZ2tpZnFERFlUK3BZL2FyV210ZUVkdHNUYlN3Tm16cDZLU08raHc1Ni9F?=
 =?utf-8?B?MmQrZEI3UXprS0RIQTNTTFR5b1RyVWgzOFpUdi9zTEFoQ25qZlFFczhRQ3I0?=
 =?utf-8?B?SjQrTW1hS2l4S3hleGRwVFpPVTZYZ0djb1BPMVdVSXJPYzhlai91WnlJRjRQ?=
 =?utf-8?B?QVpKNlQyMEdWOE5CU1ZkRDllRFpJL0twZ3BneGpQd24zR1U3cVRXRitBUUtz?=
 =?utf-8?B?NHRQMGZVeFNrZlhMTTFwaHdiWi9OY0xyYjF4dnljWjdyZzBhZHpvVkxaelNS?=
 =?utf-8?B?QmtjcHlaaVQxZW1nTElrb2I2ci9zMEFyVVpqdzdBbjA0aVFxOXhhNGJNcGlt?=
 =?utf-8?B?eWxtNHMxLzVveERUSWhGQUlYRlZOcHBxcXg2bUxDK3R4ak1LcVoyU2RnVkpJ?=
 =?utf-8?B?bFFMaEJHcFVNUzE4RFpmR1FTRkt4WjlTN2htMUFweUt4anVUMDFobWZyKzI3?=
 =?utf-8?B?Qm9FYTUvT2FKakZoR20xWlJrSFlrZXQ1dTY5cHlHM2RVYVBVWnFtNXQrUzcx?=
 =?utf-8?B?SWdvWjJ1L2pvU2VmcnIvZEhPd3pyZm94eFZhdFJiYUNWMGpNWlRlZ3ljWjQ5?=
 =?utf-8?B?a3A4WXJMYzZDZTFjZ0FzL2JJVTZSajJSTDlZUXlYaGNwSUttL2pJNEp1bDNG?=
 =?utf-8?B?NHFtQi92NjdNSFRKRTQxNmFtY0hxbEJDOFFMdCtzTzhKMk85ZEg4UGJxUGxT?=
 =?utf-8?B?UnpOcXNVVC9vY1NxVHpwY2pGRjF3YnpKeHRkcUd2ZHZucFA2Q1MzNnMvTkMw?=
 =?utf-8?B?SGorNGpJbWFOeFVTSVdkWHE3ajg2YzlUZUVTRWlFYUl5NzlrcTk5ekhyNDZq?=
 =?utf-8?B?ZDlRTUZrZy9maUZRZHRaak80azFjR2tHZFV6ZmpEZEswV2ViZHIwYVJnUDAw?=
 =?utf-8?B?eE93NUlYQThWU0ZWQmFHRmlXeWVrZmU5THVNY2ppTUdkcjc2RFRudHhTdDQy?=
 =?utf-8?B?QWRXRzdEVkRya3pmcTVncldkVjFQeFIzdzNlckxLaE16d3VtYVkrRS9xVDZ0?=
 =?utf-8?B?UmhpM2pDQUh2cE1Pb2ZRNmRCMUlmc3VqNEVqMDNWZ3dvYTRoVGx0R1J1WnJ6?=
 =?utf-8?B?bEN2bEVhS0lOL0Vock9oakdoeFpZQ3BGQWxwTWRaMnlSc2hRaUpyVzJZeEtW?=
 =?utf-8?Q?S55tTlcc3L4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFQvK3RPNFdHY3dJajhiVkJKaW9Eb2YxQWVLZ1hYbTZ4ODBBNHIxUHl0TnZn?=
 =?utf-8?B?VkVYMlRmV3RuQUgxOFlYQWZhVWNLbHhYZWl4dytjUDFmVXNhVFFMOFVMaWw5?=
 =?utf-8?B?STRWcExyUk5IQmNkT0VaWHp6d1N0aHU2NElvd2tPZ2ZFdG1nM2NibjZHNWhS?=
 =?utf-8?B?T1N3T25KRTRYa3JlcFR3emlQTXZwbloveEgxQUMwUEtaL0ZOaXhRckhkUzFM?=
 =?utf-8?B?NENqMXozbTFpblFxalo0TFJFU1JLYis0SXVqNDdOUEQ0NmRiRUxFVUR2QW5P?=
 =?utf-8?B?aDNobWt2aC8wSmpDckhJajhwMjUrNjh0bmVEZmZTTTFnMTkrTlZKSUZldDlP?=
 =?utf-8?B?VXpjK0hTSGF1dE5zbkgrWkJqR0NRU2tqRXFGV2hUTDhxOEtBWFN1QWN1Vmdk?=
 =?utf-8?B?aHV5S2xyd2NCWDM0dkpvY0YzS3ZML1p4MU0wenZlUytuUTJqWktlQUwwdjU1?=
 =?utf-8?B?VTZOTHU1V0lWWTFISHltTUE3T3Fka093bzZvNS9GOERyMUl2Z3pyMGdYdVpu?=
 =?utf-8?B?LzU5WkMvVmt4NXFtL0x2Sm4yY0RsTFJXU29KWmZLUm1sL3E5YTUrOVJrdGts?=
 =?utf-8?B?MjJ6YTdDaUl6WHRMaXpma3dIejgvTkdwbkxnUFVMcTdyK1BqYzF4Vm40bGJa?=
 =?utf-8?B?RkIwMU1hdVJ1WkZ3bFp3WUJQSVFzaDVRTGdjeXJ1akZ6WmZ2OVNuY0xnSktS?=
 =?utf-8?B?a2RzZmZKVFE0NjNua1lCdTY5cGN5ZjlUdHp2OXlMSElDM0ZTcjY4Ulp0Sysw?=
 =?utf-8?B?YW1UT21lK1JTbGxPWElXYUJHU1lXb1VMTWtpL1B2bElYcVJuc2RLYlJzdXk1?=
 =?utf-8?B?MEJFcElxa1lkUkdIa29xWU1FeUZhZGZUZVNLNDVodldYL2Q2K0ZCWmprZGpB?=
 =?utf-8?B?bUNLVTFvTjJPbDJSclZFdHZPQlRCNW51R1k5MWlod2ZDTGJJczVXWnU3dXhh?=
 =?utf-8?B?RTVDZWdIeXdpQzUxSzF2UzRGQkMzYi90bWV2Z3J4L095eldJUmRFd3krVUJi?=
 =?utf-8?B?ODFGcWZjTkNYakhGN2diYk1OZm9GV2ZjbVI0R3d5YUxSeElkNi9aUWc1K0NR?=
 =?utf-8?B?Yy9VdmFnZ0h0U1pXLzZiYVlMTWkrUUpRMmZLK1B3WFp2NE1XRms4bGNiL2Vj?=
 =?utf-8?B?Qlh1OVJTZTZVVGdFVlBRYUdYMU5WT1UwTm9taDFRaWpRQUN2V3hGZ21ZaSsz?=
 =?utf-8?B?SnZRZHVNZTd3aldsOWR2UVBBWUFDVlU1eW9mNVZZbjA3dTU2UURvdjlVelRj?=
 =?utf-8?B?azgwd3pjN2w3ZlpkbmpDbjhaMXRIUUcrZG1XY2tRbFQ4MXZXN1hLd1g1cHBU?=
 =?utf-8?B?N3JDNUUydlVwWjJDVW8ra2p5bkVxQ0JJYTNod2REY3lnZWlZVXBad2pnRGFi?=
 =?utf-8?B?V0w0SXdlOGFJQVQ1dW9lekZNWUlMMkZWLzYwTEYyUU1ZTHRMdGk4NDkwc0pU?=
 =?utf-8?B?akkzRmptbWU0MFB6WGtVN2cxdVBYU01ZeDN5RDlzYTNRZTA1OWc3R1VvVUIw?=
 =?utf-8?B?cC9XTnNhZXp3K1JIRjhjQ1UzY3g5cE5wYjgxWGVMV2dOdnhsa3Q4VkJGb3F6?=
 =?utf-8?B?R2ZsdmZuQzFUTDQ1M0llOGFnMEEyT3pCUHNqcHVybG84bG9kOUV5RlplalU0?=
 =?utf-8?B?Mk4wdTlhWkhNSWs3Q05TcmJEeXNRamphSGxZbTRPeVloM3YweG9BdnNvUllk?=
 =?utf-8?B?bE9QMUplNWlVYVBZM2ZWVVdDck9TeHQ3R2x0ZGNJL3dTdStaY1JIQXJXeUM2?=
 =?utf-8?B?ZUVlQTdhcXJ1UTJCSTd6UnpaUmhIUXVHVFlEeTJsOFd0bzA5RXZWT2NGRnJY?=
 =?utf-8?B?NVd3aWdkRDU0cHdyeGdLNWFncHgzZDRoenFOTXBrc0JpcTM1M0dFODgwNXJw?=
 =?utf-8?B?WkVnSGtHYkNTUCtsTnFQcVY4c1ZQS1c3WWJFWUNZUldjd010K0l0b20xRXNm?=
 =?utf-8?B?SHNmbUYvVmI2YXRxNDB0bGppa0V0NzU2YlR3c3J5TllLblNERk1GZWdPVzBj?=
 =?utf-8?B?QVk1VHdMQkltcnNoRTM1UjNIa2NqY2Z3VWZJMXJDYUlyWVQrbHUxaUJYTy9t?=
 =?utf-8?B?Y01zUm1EM01wYW1vZXRQTlJ2NnptK095aHUzaTRFaFJWekVVNW01WmxVTEpT?=
 =?utf-8?B?SVBLc2RZSlJpbFVWNHk5MWFQV1NKcHZSVmtpRlFhNEtja2JhU01TbVBhQ1gy?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56322660-93e9-459b-3988-08ddc9774d55
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 23:27:19.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KlUbRtwDKeLOXULSxx4mCC7Qw1nYKX/DWHPi9vdu5LIRoF82BImRxBJ+ADfQZ3lNTZINdN/HanU8CZtuTxFt5Un+oMyTsnYBfgGFBnN8Nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7103
X-OriginatorOrg: intel.com

Hi Babu,

On 7/22/25 8:51 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 7/17/25 22:51, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>> System software can read resctrl event data for a particular resource by
>>> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register
>>> and then reading the event data from the QM_CTR register.
>>>
>>> In ABMC mode, the event data of a specific counter ID can be read by
>>> setting the following fields in QM_EVTSEL.ExtendedEvtID = 1,
>>
>> Seems easier to parse when "fields in" -> "fields:".
>>
> 
> Sure.
> 
> 
>>> QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the desired
>>> counter ID. Reading QM_CTR will then return the contents of the specified
>>> counter ID. The E bit will be set if the counter configuration was invalid,
>>
>> Where is "the E bit" defined?
> 
> QM_CTR MSRS bits
> 
> Bits        Mnemonic    Description.
> 63		E       Error on access to counter
> 62		U       Count for this event is currently unavailable
> 61-CNT_LEN   	_       Reserved, read as zero
> CNT_LEN-1:0  	CNT	Count of monitored resource or event
> 
> 
> The bit 63 is "E bit"  -> RMID_VAL_ERROR
> the bit 62 is "U bit"  -> RMID_VAL_UNAVAIL
> 
> How about?
> 
> The RMID_VAL_ERROR bit will be set if the counter configuration
> was invalid, or if an invalid counter ID was set in the QM_EVTSEL[RMID] field

It is not clear to me why the comments only mention one of the error bits handled
in the code.
The motivation for hardware counters is that reading of RMID may return
"Unavailable". Does this imply that reading a hardware counter should
never return "Unavailable"? Why is this error handled as possible when
reading a counter though?


>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index a230d98e9d73..026c2e2d19d3 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -259,6 +259,76 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>>>  	return 0;
>>>  }
>>>  
>>> +static int __cntr_id_read(u32 cntr_id, u64 *val)
>>> +{
>>> +	u64 msr_val;
>>> +
>>> +	/*
>>> +	 * QM_EVTSEL Register definition:
>>> +	 * =======================================================
>>> +	 * Bits    Mnemonic        Description
>>> +	 * =======================================================
>>> +	 * 63:44   --              Reserved
>>> +	 * 43:32   RMID            Resource Monitoring Identifier
>>> +	 * 31      ExtEvtID        Extended Event Identifier
>>> +	 * 30:8    --              Reserved
>>> +	 * 7:0     EvtID           Event Identifier
>>> +	 * =======================================================
>>> +	 * The contents of a specific counter can be read by setting the
>>> +	 * following fields in QM_EVTSEL.ExtendedEvtID(=1) and
>>> +	 * QM_EVTSEL.EvtID = L3CacheABMC (=1) and setting [RMID] to the
>>> +	 * desired counter ID. Reading QM_CTR will then return the
>>> +	 * contents of the specified counter. The E bit will be set if the
>>> +	 * counter configuration was invalid, or if an invalid counter ID
>>> +	 * was set in the QM_EVTSEL[RMID] field.
>>
>> (same comments as changelog)
> 
> "The E bit" -> "The RMID_VAL_ERROR bit"

For comments to be accurate, per the handling that follows, RMID_VAL_UNAVAIL
is also a possibility, or is it not actually possible and just coded to match
RMID reading?

Reinette


