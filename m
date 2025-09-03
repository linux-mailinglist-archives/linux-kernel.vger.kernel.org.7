Return-Path: <linux-kernel+bounces-797612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86402B4127A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4209A3BD217
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14808221723;
	Wed,  3 Sep 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GegnbfDR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E61DED4C;
	Wed,  3 Sep 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867517; cv=fail; b=JAj1K/4UCx39oQz6Mm/NlJlWRLL3mk+hM2FmpB7V/zAzIEFtArXdFM0EmQP3iOzQJyG4ZwgNdeBVfmld23nLr7ElCKWPL+JyUJP3hBPLajWUeDGVTFi9AVi+ixutXZCA0uwf2d3blLPZq93Hduxs2hL6GufVkSRN38/6vlJikmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867517; c=relaxed/simple;
	bh=LdZNiCLaEVWc1zSk7n9BetyA957+66WM9T4qcfM9Cdg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lxF4duropipQCi8ILX8Nh6QGsiamcucP5Ru6MZsNLOLNbWiX6ZcZ0NH63fJqE6Q8BnDZuf2RZKPcf9I4YZZkBkPFbEUFh0MkzY1ZwXDsKI8hLy/U/+8M6/sOIiRD5hiLATJV9vm0YuBhny1mLRBQjCfeCJBjUDEbjuH/MFAmFew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GegnbfDR; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756867515; x=1788403515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LdZNiCLaEVWc1zSk7n9BetyA957+66WM9T4qcfM9Cdg=;
  b=GegnbfDRRXttLXROz6LMtYN5HD6VvlpK7YKnaV+VWZmu0o5v0MGgu7Im
   4lW/Svw/9cDGfXG00w1R4Ffqp4CSO4LwQgWRbU2mHevA1T0y8pNj/1ILE
   ch09l7K0ZHcZfKYoNF7alEg61XXh+/o9MZCBY4CbhVf6T12zk88NIAdGV
   o5qUN6EBSElTvFofcG/PAujUh8GAL3cfjnlI4lk5QuSn10O465jkYTC4m
   J/NmDW7Tu7j4rPaejzSXh+Mm4T8mqk8jYGlxC/Ehqum7zd+PeoNoP0lQX
   7f/kFuggAhc2TC8RGwwHwEtves4okLKdTcoteDDudaMLKAPLKw9Eg2WkG
   w==;
X-CSE-ConnectionGUID: FH0/FoRuTWetorH7xc6EHg==
X-CSE-MsgGUID: kHjQgjjATj2xFcRyk+PBkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="70600021"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="70600021"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:45:14 -0700
X-CSE-ConnectionGUID: U9RTct6EQIi+f/pL/PR7zw==
X-CSE-MsgGUID: kIJLjWcWQBKbnO6TEaDaqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171342874"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:45:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:45:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:45:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.66)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDblOjgAZitHt+1dEhp0U8ypY8nZJtq7TLnvfJyKWNzNlUUCdCEdOoXJC2jeY9+4IvP3kEuzrZHkxESI+NE/W4nec6/wpZ03qsNgk/aqE9moucXoQuAZrRj87PoDG6w5F8TS10t/BHPn7t1qy3flRb8aLOC5iEm9D7byMVfJQ0OYjrxg9M6HM3TtUliXCEcTr0z5abASey48z+mB91vP46nbpwmTW2nXNYumwxABbXUNpQTJdHSVKm8ycg8VKgFQz23EXfFKttBcjZ5XQFwLMjzRmcU1HaEWnpt0htBSsaHZEB5E2JWXF2QDYQF4FkJfiWlyJ0PNuTANlkbwpd8slQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDImsosZxa2oRyunBQdyRH/fy7AiUBIMphWfP1mdkag=;
 b=HdRy+X40yF+NdChaVERGysYHZQixVMVa6gdvUw5i9Ft54z1jtgHb+j7N/g1HwkBgPSgU8txjEAirELvQWB4X7kKSDHCqDLUavLarSxyyIv4EFajZpxL5bXrnQYmAUxX9NZYAKi9jtxv534mM0vDsYbKzHmozPL1yEs4GZsNifeVUUHwAHhgBenG0wPX/SjLoZFpWBmZ9TpeXyfSQuVOtu/81WiflJYngCvvwy+iOPKzRIUSjwLyTwboHx9Cv2k24mh8tRGyxuu3nal+Mch3HqHKvHoJRStwcXgwWM9viTkI747RSPpxFASOgc5GOLsIj+KptGeJq47nsnsq/mkFHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:45:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:45:00 +0000
Message-ID: <8620418c-d414-4b6a-bb27-bdb835c76a38@intel.com>
Date: Tue, 2 Sep 2025 19:44:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 26/33] fs/resctrl: Introduce mbm_assign_on_mkdir to
 enable assignments on mkdir
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <1966b499476d38cfbed6896dfbc50cddad35a126.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <1966b499476d38cfbed6896dfbc50cddad35a126.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0386.namprd04.prod.outlook.com
 (2603:10b6:303:81::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: b2007d4f-4476-4076-cb96-08ddea93e0a1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUE3eFVjZndJWWtPWW5JV3JUNjV4dkNhV3pteEREazRIdjBmZkNROTc0eHRl?=
 =?utf-8?B?UHkxcGlLZHkyd0hsTllPZU9jT2N3SnU4STJlUjZBTzRCdzdUWjBkaUE4QzJM?=
 =?utf-8?B?UCtBMGtEOVk3d0dMSnJCMUZEQWRwUHBvd1dGM1FIUHZZVUhaRG9DWFYxL0ZH?=
 =?utf-8?B?MjRyMzJEeG9yc05XaFZPR2h5bGR2Z3FwcUd1NXJFSDBSVEpyT0d3ZEZCTkly?=
 =?utf-8?B?RlBpOElieGdVM1dOdHRkYXBwUU9TNGFQLzdwb0pIdmxXZk83eS9RcHE2Lytm?=
 =?utf-8?B?NEcvR2FwNHR1bDVnNXJtZW9jZDF3bjdERmo1Qkw1ZDBha1F4MlJCM3Rzd1Yv?=
 =?utf-8?B?TmZlUk9mNE9iUFV2MmZxL3JqZHk4U2xyWmJYS2RpNlFOTlM5Y2RaK1RDdnIx?=
 =?utf-8?B?MHg0NVlMMVJVTXR4aGNuTVQ0MHpDU1BtZHlrUTM0ME1QR3ozakNkQXRpV3Q2?=
 =?utf-8?B?RWNlZEJSdzV2bkpUT0ZRK1N2cTBQZnhNTisxdEhWWEcwOGVqVmxvZ21aTkFF?=
 =?utf-8?B?dU9pL1RVYzVPWnBhN3Y4RGs3ZjEwT2Zlc0c5VUFjWEZjQXFXdXZqRWM1aFR4?=
 =?utf-8?B?eVdHTUM5M1Eyd2VDU25Hc0g3YXFPaXZwZXk5UXprNDBlNDAvb3BYSHpSOVoy?=
 =?utf-8?B?U1NxUFdkTDYxRzBaRlRCTE1YZjlkVmdTYVVzN09aS24xdGs1ZHJPRk1vRmg4?=
 =?utf-8?B?Y3Vvc0dWNys1azYrQzUzd2lrVkVHR3d1WDc5T0c5RUNFZStGcjdLNit5UmlX?=
 =?utf-8?B?VVZPbThMVUpTcUdidUhYeDRYUko3V0JlZWNsVi83ZnU4c1FNUFNEdGgrRExm?=
 =?utf-8?B?elgyR1k3QzY2SUwzMWdvRVVnK2U1blA3b1VRcXA1cnRjQ2J3NmsyU1pzRUsz?=
 =?utf-8?B?STc1NzVWR1R5RjVnaGRUcDBabzZ1S1BqVWR3eTRQNEN0RXc0VWlPajBlSW95?=
 =?utf-8?B?ODFRRVkwVFJDQkpYeFpkTHhQMlJnRjlpV2g5bUkvY1Y1VkhBYzdncU5zY2JZ?=
 =?utf-8?B?c0orTFdSTHBZcWszekNHSGtHelZmVG0vbWI3Z05EanErQys1QnYxQnFNb1NT?=
 =?utf-8?B?VGJYR0NqNTc0TzlmekhROHRWTW9GSWI0TGhMTVYzc1pYVXQvOWFGdmpWL0s2?=
 =?utf-8?B?TnorSFFlK3pPMFlvSmI2aW1VNS9xUWNmOUJlK3JZeUVpZDVTWW5rTDlIV2Z4?=
 =?utf-8?B?cEpDZUY1dU1pSThHMk9NYmtJeStKaVIveFZFM1l4a295SDh0MWJDbjN6RE4x?=
 =?utf-8?B?VU55QVVwK3FPb2JVdzBPSURXVFNKWjNOaXRlME5hbE42OHk2S0RmclZzenVU?=
 =?utf-8?B?dGI4UzBWUUFkb2FITDRJNjVQYWJ0TmFocHRVV04rek03QlZ1YlJzNFc4UVdO?=
 =?utf-8?B?aGtKb0tJcGpoYTI1R1JURzJIWDROcTBKMUVGUXV4SFRHMWR2NTFFb1g3VVdB?=
 =?utf-8?B?eGJrV09IVVVqeElUOTUvQk9hakNvdHNCM3pmalhpcGQ4azB1eDFSVWtCQXo5?=
 =?utf-8?B?RVRlZ3hBMFFGSENTa3l6OG5hYXkyeUkyY0o4SzB6RTU4MmxpYlNNQnpiSTBI?=
 =?utf-8?B?RlhuT2l4K2xoWXJQa0JXUXI1MWpZY2JUOXI2dk0wMEJ5a29qb2hCRkF4Q1BU?=
 =?utf-8?B?Uk9BYWR5TXFaNW5XWTV6K3czSVY3KzJPbVA1c1NwUEJrNDZuelo0bTNZZm93?=
 =?utf-8?B?eUN0Q2s0dVkzQW5HVnpNRmltSDBwNk5yenBncmxUQzZaVXh3M0Vad2NvaWFj?=
 =?utf-8?B?ZnFscGd1Mk4xbGM1RWNZR0RtVS8wZTBYQnFmSXc0b1BIYlo4eHFRR2hrak8x?=
 =?utf-8?B?TXFsVkxhL09VelNDUVhwbXlySGh2dElNQTdVWERJQ3MvNWZ6TTloRnVEQ1JL?=
 =?utf-8?B?dU1leTU2aEdTNlVEUFB2TkF3a3AvQ3UrNXA1dmxQZnJWSnRxekVLNmE1RUZU?=
 =?utf-8?Q?RcVEhKPCrG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SldCOUlZZVduWlhPQWZ5TDdaeDFlQ0lqdUwrY1lsTnlGNklPNjh5amJNSUxm?=
 =?utf-8?B?THBVa054VUV0OUtPVU8rMkErVVI5d3ZnL0lmS3Q5YTlsSHFJUWQ3Tlh2dEhM?=
 =?utf-8?B?MGJDUEdEZmI3dUZldW1zYXBBQ1ZHR3p3ZkhwdFV0R0FHY0tOTmhkUHJIbW5I?=
 =?utf-8?B?ZXZhQWdBUnV0U0NDeGtJQlhxZklkTzdVR2loTTVSRXQxQmFpa3lWSGRyalVV?=
 =?utf-8?B?aEpGR0dJM0JYZC9OM0t2Q1J4WUw4RzRWY3BRaERIUi9IVWJJY1pNcFBzWU9Z?=
 =?utf-8?B?aWdSTG9hYjd3NnhESEJ2dlBMWjgxU25tV2x6TTRTS0dQa0ovS0dWUUh3SENm?=
 =?utf-8?B?UFBDaFJzc3pmNlFHT1BNVzJaYVZEMVVtVEtOLzByRnJZbCs5WnRyWkF2OTVT?=
 =?utf-8?B?dzRjSEp5U0pCRmJjc05WaS9xQ0dqQndUV0pjUkdPY2VNVjFQZFErdWpCOTdm?=
 =?utf-8?B?QmY3NitlZmxIL05oRVRYenRkTUwrU3dpR0duR2FwLytNMGlJYUMySzRoVFhz?=
 =?utf-8?B?b2d2c0FCS1NVT3dBeWt2c0xqYXgxTTNXUmJ1QmdTbHRDczhoSWxoWGc3U1BX?=
 =?utf-8?B?Ujg5T2NPK1NqRWY4MU5MeFlPNGFzTHVOamZ4Mzg4bFBvUTFBbjRhbjFQMUZ3?=
 =?utf-8?B?WnhwWXg4OXFRUHVHN2lqL3E5Z0QrWDk5aXRwSlVyWElQRFlORUx2aGRkZnRl?=
 =?utf-8?B?emprcFlCZm50bTJncUg4MDlicW9yRVlTWE4yeFljRTlpdHoreXdrenFGR3dM?=
 =?utf-8?B?eDE0TE9kK3hVRUUzcUdDS2dWeFlSOFBnT0prdXJqUnFmdTVjc2JJQUdtQVhh?=
 =?utf-8?B?Q0pGZjdyUW1PRFFONjlkUzlENmc5Z2JWTkIzODdJV1lFOVZoNEN6WHh5V3lP?=
 =?utf-8?B?dGJXVDdQdjdzRnk4WkViWEJ2S2pLRHZIZHBnS01Qcm1uUDdLcDJ3OUF1cDBS?=
 =?utf-8?B?eThzR1VHeUd1dlM0OHpURDBmU3NEM3Uyd1RJcTlpd3JpRzk2b2lFZFdWTzNy?=
 =?utf-8?B?bXFLZksyVzJxSkVLMG1PNGp0T0NzOXp1VmVoMTVJWHpPZWV3SUtmd01idFkx?=
 =?utf-8?B?V0RSZndmSTFQTEJ3NzBpeVdQUVhqUDlzOVBxYU5yUkEwWWk3S0hidXFKRWcr?=
 =?utf-8?B?RWJEV0FwUjVxSGpiM1hSZm1uYWNrdkJjeEdlcE83NHdROUR1bjluSFBRWWkw?=
 =?utf-8?B?cXJrQjI1NkxKZWVQTVByYVcxU3RMRW1HVCt1YzZkbmVQcVBWRGJMTGF5Rnkw?=
 =?utf-8?B?R1hucEw5aXh0SE50VkJIMUUxRXMxRENuMlZTSkpBQUplTWxyZjZWakdGTzdr?=
 =?utf-8?B?Q3pLWWdhbkZZK1ZrNlNYK1RhbDBDQjc3M2NHOGswNVV6d0pZQk5Gbjl3Yk5p?=
 =?utf-8?B?SjZDdFRLYzhvaGE5S2VLMkJzSElLTWZsSkVoTVlLQWZtalNvNUgvWkdtWGJG?=
 =?utf-8?B?Nlc3V1Z5V04vOTBHTFhqcFkyZWt4TlBFMTNIaTA4NmFrTzdZMDNzelM0WlRm?=
 =?utf-8?B?UnR4S0NOTEZVK1M0L3BuNXUydWV4TFdIdWdha1BUUE4vUi9RWXRheXI2WUFJ?=
 =?utf-8?B?eUpnWiswR01yWFFnWDZZc0E0NnlyaEg4OWJLemUxWThxb2N4TVVpRVVmVU0r?=
 =?utf-8?B?N3poTm9UMW1oeTNRcm55Umg1akFzMzVoOTB2QzkxcUN3VllTMGVwOWlOSTVk?=
 =?utf-8?B?TW5QeWN6WDd1N0JOSmlXaHBmQVJ2VkpWbDBNcjdrOEYzSS81QW5LaGR1alRE?=
 =?utf-8?B?bW5iRmFMTUg5NXdRS05NVHpNemtkUGtGWUhXd1c3L01QODBCYWVkZFBuMHBz?=
 =?utf-8?B?U3NscWhsdWE3Tk9SbTd4emlGb21oY2FOK3N0a2VUTVRpZVBLbElxcDk2REl1?=
 =?utf-8?B?M1BXbm1MbFVQQWhweG0yQVNubDhrZGVZWmE1WVJQYWV1VWdMTFZNMWVTZkth?=
 =?utf-8?B?d25JUGtpbWtaczJObW0yYWxSUSs2d1NrUVZTZUp4NGlVQytZYWZ0cXJXYlF0?=
 =?utf-8?B?emxObzU5RXo0dDgvM01FSGxJcllvZndUTG96dGg2OVVOdEs3N2Iwd1d3WWZ4?=
 =?utf-8?B?TnZyUDdWemJwcGFBdS9hbVEyT1VXdTF2dklIbkdraHY2M3VUVkVWYnFSWFVz?=
 =?utf-8?B?WERxZEtJblF4a1lVMVRSMGJnTlN0ZmZnMjZkMlhWWjdyL0JJMWQxZ04vYmcw?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2007d4f-4476-4076-cb96-08ddea93e0a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:45:00.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dz5OlogMIKmbrlA8/p4oYiH+g9/OZGD4llHoVG/ROW402xMvWcDPfZY1f0luG4ORJc9t1YUAKYFAwSkEDVCq61Zkyr49T/CGLIac9g7jx20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor the bandwidth as long as it is
> assigned.
> 
> Introduce a user-configurable option that determines if a counter will
> automatically be assigned to an RMID, event pair when its associated
> monitor group is created via mkdir. Accessible when mbm_event" counter

Mismatched quote: mbm_event" -> "mbm_event"

> assignment mode is enabled.
> 
> Suggested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

ps. If there is a re-spin, please consider adding "mbm_assign_on_mkdir" 
in cover-letter under "Feature adds following interface files".

