Return-Path: <linux-kernel+bounces-751295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C932EB16758
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288757ACE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4121CA07;
	Wed, 30 Jul 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+knOoaw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C221770D;
	Wed, 30 Jul 2025 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905980; cv=fail; b=nNYJ6Sh81V7MeWKWmB23+dW75JICBDTaVfiQ0JG4dHztAAkZqIFVg66tr0P/uIiUNW2n8CA+bS+SLaE/Xz50RkdSM8eDJE5z0O0Od+aahNta0P1nZXaencXZll6nDO8wmPPsferFzBL9sQvrjcGcMm5bcowYGONVrPqBs7QKaZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905980; c=relaxed/simple;
	bh=vlTexRNxNvpfZa4y2dpEl3UnB9gMcLUIZffXQNtKL6M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OgdHLbJsOpVrDD5PAfvG3NQ9G8dbUIlHPprPpH+VErGuvggv/hJz2gJ11+Juc5BEd69wx0in8aJ0JVQMSvgtDisUGiS5iYUFXqP1/f7il7+t1a7OzkmDxYuwyxWXk8BCtU1UJtXo6p/QB4cMs9qWFeiNi+aIQVGP4PA61b5wfQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+knOoaw; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905978; x=1785441978;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vlTexRNxNvpfZa4y2dpEl3UnB9gMcLUIZffXQNtKL6M=;
  b=G+knOoaw9ZWgJ8epVMZnwQ1QElPIFrMXIYsmKb3qxdPPeCatQvLZCKkd
   SdKLAYFXkINOuOei+PDN7dXOuIAcJ/aOIBYHFC0lEMRw4nddgMOUh2ws5
   /u6feIMiJW0Ssb4e/vxK1V6C4crh8/mmHZuaobTAK/ubXq4YV8EqJtsAm
   sMd44SqCzRzwsek3LFjgx89ZKNZ1jiS3uy8lqSLQDLWmMjqUDn3c3OjZx
   N6fNHUWWRkQqzci6+U9fFd4/Dp6JxeAiZIAhB4t6V2jvzizvw5J1A1GIj
   0n9TjI70MAr9Bbiq4ZFCT18vJxKerppvqCXvZH0i5dBlk+COIAtgefaQD
   g==;
X-CSE-ConnectionGUID: eDOoAn9WSOC/A3VZ8KAwYA==
X-CSE-MsgGUID: N6Y478FeRNCKzYqC5FNjUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73678172"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73678172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:06:16 -0700
X-CSE-ConnectionGUID: 84B2LMUhRvuHE1cp1DCPSA==
X-CSE-MsgGUID: nJxbadu+SPOKmVy5CpwbiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162787514"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:06:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:06:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:06:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.76)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kvx+ADOcSRm/TQ6IeYYnRF2YkYRGkUa5B89+lG8LNA+2mLBD8I46Igwr4cx2Nx1l7WnFfTs98a4kJnWhP2SbDRCn9VTPwGqnlBkP/b/qzAWGT+1dus3KXEXGv7cZCAwmWDgJ5S5yxVWfG40BClqb6LL48oaSGPckJnntUFyenp1hrbpPsxmW9GejiZcvftZ1lm3a0JzDpFnIV2DLKhb7/U8bNYtnuIOuTP+kF5BHm2LApDshcjqOiHl3B0i0IdVQ0mcWGAb+0zdALw9OdU5PDhnu5mhZoIBdlvJqK0g8OhJ+rCsvwYoyU/Uy6FOqfBQU/BtEqmtkc1WE3Ge5UZvd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHqDJ7G1RfCkVNKqaH4VlVxhB0rkVGTEZpxJdvyqzl4=;
 b=ZmFxDHPgsRmspN7i+0JKwcW6Ch6mCwWrpnS+7dKRhF9+Ts7/oqpgwYTPvOWbLTLTI8Np4mUZi+c3SA2w5HL2ufwmjJLaRns16sezR+dqJTuAaIPlgcBfo/lIfBbz1x8jIhaGsuV/WOg5YBnOKCXzs5Ha2kIh3k4yuKxEoSbIYPiyPk9h//x4WQFcqPRXdPdRRuDa1n2lVaZtCl2hAXbo0q9gt+vYdgQykdsEzNmDqdJAI4TKGHZC6FcemkPOn35ComfNrRMxLG7pImf1tf25vW89/DvZcxmMywl2fhEEyYyyJVlUjr3bAzGktY3Vl/JAr6tzkk2A59CArpkIh1qTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 20:05:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:05:45 +0000
Message-ID: <9887b44b-4813-47b8-86aa-ba72de3c96da@intel.com>
Date: Wed, 30 Jul 2025 13:05:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 26/34] fs/resctrl: Provide interface to update the
 event configurations
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <15ecac1be290452ff119f67f640c26b8203a4c01.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <15ecac1be290452ff119f67f640c26b8203a4c01.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:303:8e::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5322:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b4490-5c69-4031-e624-08ddcfa47843
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXIyeFVhNzFVQ3lwZEFnQzQwdFdGeEZkTURQcGNzUlNhTkorNDcyQkFNYVZQ?=
 =?utf-8?B?Zmd4eWFnbEo1ZDVFejRKTUtyZDc5aHBPLzBlUlBmT2RQNnc5VWxIY2grNFJk?=
 =?utf-8?B?dDRZYmNPdWRIOEd1OERRaWJNcnE1QlkrWUpSQTNUY1NPWGVnTEM1Z0NNV3Nk?=
 =?utf-8?B?WU91SDZNcFd4MnhibmtOL3ZJeDE0SVk2L3BrV0dWY2UxaDR2Q21KVkN1Y1Rv?=
 =?utf-8?B?UndwUnlCVDBSazFHdUhWeE9vMG82YWZ1ZGZxeUQ4TERVZm5WaWhaVjBFQXFq?=
 =?utf-8?B?MFhsaGliUUZjQnNoNnFFQm9DWk02TXJvT3liOVlWTlZvREhCZURUdWl3ZXh5?=
 =?utf-8?B?TWhOZlQ0akRBeFg2ODFrYlBMOFlrMG9GeC9qRW1USHB4TUNFQUVnYUd1Mjh1?=
 =?utf-8?B?QmNqWW1wQk52b1ZxVzhqTndiZ0kxYWlLM0k4TWV0UFFUSDh4ZUx4NTNWVTdJ?=
 =?utf-8?B?VFJJRHFjcFVzZHI1SHV0TUVPT0t6M21aWWlibXZ5b2VuRjVsRCs0R0VNUU4z?=
 =?utf-8?B?WlRPNE8rZXZTVlNzNzltOXVDVmVGbVBVVEdPYldRTWZueWZRNktJK1R2VDVr?=
 =?utf-8?B?NDVkNHI3V2Y5ODQxM2gvc2Zjem1udzlRTGNxQ0dlSWtWa1lacmZGUEhVMm51?=
 =?utf-8?B?bXc2MGZ0RGpOTmd1ZmpmbVk2YkRZWnJuUm82NzMzUjFYVTBUL2N4eHQwVC8v?=
 =?utf-8?B?YTBUNW8zNi9XS1U0cjJjUm9tZkpTc3RSZVNnRDF2VEdITDRxV0JOVXpSMDNy?=
 =?utf-8?B?TGVXTnV0K090S0xuL1FZUDlkWlh6MHdMY2FZbXBMbWNtUVYreUtIWlp6Skts?=
 =?utf-8?B?ZmFJMXRYZHBFeGxMVHJVbDFaZVZMMjVBMy9odWt6eUhVSXo3N1dyUXNFU21L?=
 =?utf-8?B?Yzd6QVY2RjFmUmllbWxlV0lHc2lHQU8yOE5Cb0RxZmttMnVsZ0hLczFYOGY4?=
 =?utf-8?B?STJnNEFvaGZlODA4aEZ4bndzWElxbll6SkFaY0Yrck1QNUVkYjFUVFhUYWZL?=
 =?utf-8?B?Q3ZPZDRRRS84OXNoL3BwVmR3VFZuenlGZUFsRWkvSkJOY0xJUndaS05VWnYy?=
 =?utf-8?B?c2NPSU1NbkhETDhZb3lGZS92eUV6RUdUZytCeVNVMGlRN0xJKzViamR5SmJu?=
 =?utf-8?B?eWRTUWpIdzBaYTBNcStPMTNBam9yQWJQWE5naU4vbTU0c3drOGxSN1pyWTY5?=
 =?utf-8?B?SlJzZHBpa2x2bXVsT0x6cVZEcFJPV3h6MzJsc3JmMmZMQU5CTEhWdjNxWDhL?=
 =?utf-8?B?MUtyMUZ2Yk9qTUJTR085MW4vcDg0amc3VUE5L3N6QnMrT0wycVBEZlJxclFz?=
 =?utf-8?B?MHRtUlN6Vkp0RXV0bGZoYVV1R3VINW95eVVJdURWRE82VFVqeVcxWXJJTWYz?=
 =?utf-8?B?WDZBN3dMekJ2V2Y4bXBVczIzM0N3MHBUMHBibmw5aXZEb0xBa2o1VW90RHB4?=
 =?utf-8?B?bUxERGZyYTA3ek9BTk5KbE5nZXVjZEdNQ1p2ZXJuT3dkMmNIZU11czA4WVda?=
 =?utf-8?B?OXgxSUh0TkJaS3VLd3o5cjY1Yk96RHhVVmZSR296aGNkbE50Q3FjdFJuQy8r?=
 =?utf-8?B?TUluS3NwWUZUNnFEQjRtRmtFUURQbVN4c28vYzhiMmlYbGxUVkRWaHNkbjF6?=
 =?utf-8?B?eUErMHZGREdpKzJWTTJFM3MvVEJkK2xNcDdZSENVeUFTallwUllwL3k0eFFP?=
 =?utf-8?B?S2FtNXRMS3dleS9RK0dSUmtrWXE3Z1FwTTlRazUwWGxlNytvZDd1dEV3WXYz?=
 =?utf-8?B?OVZ4Nmd2TjRsTnJ3dm9wUmFOeVBLOXJlZWY0TEF3Wk8vMjdxUUtKb2N2c1gv?=
 =?utf-8?B?cThDa2p0bllxcUprdUs5VHVmSjZ1cDdoMVN0Wk45YVBKeVB6U2RlbGxkWlNl?=
 =?utf-8?B?KzFJQXRxK282WlMzV1dvYk51NUZ5R3NxZ1ZrcEd5NTNlTkEyWXpMUTUzcjNN?=
 =?utf-8?Q?Ewg6dcjpghg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHUxN1hZU3Z3RVN3YzNyQnVhNUJQSW94U0Q0T1doWVJhNnBBc2Y4SzJXL3Bn?=
 =?utf-8?B?WGJ1bkNlYWhIVWlZWllrekVidFZML3k1MnVwQ3M4MHhCR2M1TFlEQ0hQM0hC?=
 =?utf-8?B?VEl4WE1qSVNrWXRheHVMcjJLOHRXc1JRUWszVklKY3BMalFlY2xWY09lWjY4?=
 =?utf-8?B?UHRmZXZwblkrQ1JlWW42aVFnOXQ4T04xc1UyUk5XKzZoZEJHV3dIVHF3Y0tL?=
 =?utf-8?B?cVlldnF1ZGV3U2FsNGpIajhqTkZwMlFNL2lycmJOMnlBVEJrd0JsaHFCWk9X?=
 =?utf-8?B?SUg4Q0FyN2kzN3B0bER2SnBHdndBQ0JVWUJqUnI5QUNhMUt0NzZCUUxnU1Rt?=
 =?utf-8?B?Y0ZwamZuVDJudWdVTEZxMTVmNUlqTXByZ1A2dktMUkdGK3h6dTN5L05FbTdU?=
 =?utf-8?B?Z3VKNGoxVGl0Zy80TTBFSmgxeWZ0WDlFT0NaZGE4VlptYi95MWZGamFJUVlw?=
 =?utf-8?B?MjZteGhXYURKRUkva2RQY0dLM2JuVjQreGFlVEYvcU9icjIwZ0I1MklVQTBq?=
 =?utf-8?B?S09KdjNoMFZEczlPTGRqLzluNXhRUkJERVo3dGd6SHZaRDEzUFF2ZDlzcTJ1?=
 =?utf-8?B?NmpmQ3duOC9NYnZ2RmRlVE5WSEowTlIwblIvZkIzK2hGRkliTGN1Tk9VeWlz?=
 =?utf-8?B?ekNwOUVLYXZNaE15VXMvd0p5R3lSU01jL2k3bUxTTXc5eWNoMDlmOWhicDZ2?=
 =?utf-8?B?Vmx0b2Q3NmQyTWxFTEV1b01JVFhtQ0xmY25JWVdiZTNtSEVwUUwzYmR3TU1H?=
 =?utf-8?B?TjVEUmRCTkZxZTRnKzNTU2ltQ2QwTHhsWENRMGMvTEtIVlV0RENEWGRPek81?=
 =?utf-8?B?NW1QajZ0MHJsNmlLZm5pRDkxN3FJZnNHNDdRS1NHczhaMElBU05FRVprYkt6?=
 =?utf-8?B?RTUzN21wK2FnWkhDeHFaQWhKeFM0RTh6cFBtVTJ4NUxnWVE5T3VHOWdhL0Fu?=
 =?utf-8?B?a3hqd1pqMk5rNjNBK3FhUWVyRXhzSnlyeW5EM21JdFlMTnRud3pGRmJwSjNv?=
 =?utf-8?B?ZEtoUmpuck9wMFA5WHdhVVgzVEUzWmw4ZGdOS2F3OXh3djNpWHhjeG5aRklB?=
 =?utf-8?B?TFkvbExLdm1JSDZHOWRUWWcrZWtVaExqR3BJSkpnaGRiRlo3VkpRWHhmNUxx?=
 =?utf-8?B?V3o4ZmlZeTNncWxtZjUrY3V5Y1BKNU1qVFhQK2NFNXd5QnhPd3FYc29YbDc1?=
 =?utf-8?B?dUdBTXN4RkJzdy9WK3RsK1I2aGNEc0pWSWhaY1A5N3cyZTV1ZVFENUpnc3ln?=
 =?utf-8?B?M1hNbjYrV1pHaENaV0lyb0FrQmFabEFNYzUvWmNURjRyMHMyTFZaUHNJekd2?=
 =?utf-8?B?WnozNW14ZVp5Z1Zld1BVcWJkOTB3L2tEVHdER0V1ZVd2dnNTUDFWT2lVelRG?=
 =?utf-8?B?NFREZGlXT1lyVGc0OXdhVUxEMzdXY2lFUnBKREpFL0VEVHZOcmNVMEJJeWdE?=
 =?utf-8?B?RGxSMVY1TmNoc2FjdWZyUjJwTVJsVno1ZVNxS0o3WkdvTk9xWGRVQ1lUZkpo?=
 =?utf-8?B?M3NzZlRhaVd3VFRycTB5U3Y1Q3JIZVdINW9ZWHVQRGJuV2Z5ZE1XQ2t0ZU9D?=
 =?utf-8?B?UHNiL0pzQXdUMTkvZUFDb1dKemsrRzVYbTVpWXNybWtDRlNYQTZqdkd2eVY5?=
 =?utf-8?B?YTRBWkY3KytQRmVESTZkMzc5UzBkWDhRWWV1MDNMVENzUG5rcURyQk1LdG16?=
 =?utf-8?B?UVMveXpZY3V6Sm03OGpVUjRYdHRGUTZZc2w5VEZOamlkLzkwajBGNkgrMXJS?=
 =?utf-8?B?dk1QNFJ5WU9HOEY0N1A3UkRFclN1Wk0vQXJ4bnJaVG9tb05iUHVjM3NFUC9W?=
 =?utf-8?B?TmVUbG0rVFFlSUxDejFDcWlMZVEzUDczYW96eGt5Tm1KWkhYTDdxQWV1RVZh?=
 =?utf-8?B?ZDEwNGlCK3BXQXZxYi9samlaRzQ0a0J5RWMxTm5wamtkL0FDY1daUWQ5d1Ux?=
 =?utf-8?B?Zys2bTNpOTVVZlIvQm1pejNiZjJUTjE3M0JkS1R0RXBrWFU0T0kvZ1QxUFU5?=
 =?utf-8?B?RnVnZ2FLamxyRi9vZlpuL3M3MGVoRFZLUXVLa0ljZWNLc2VsRU00aEduSGIr?=
 =?utf-8?B?RHYrREpGL3hJQVN0TmRWMTlEK1RJRFE5NmY2WFVrbzFqUCtYOUFDRml2bWo0?=
 =?utf-8?B?OUIzS21UbnJHeDR2V24ydEJ3QkRQSjlSeGhiTnVRS2V4QXBtbHFmUVRTRVlo?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b4490-5c69-4031-e624-08ddcfa47843
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:05:45.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9icvOVhUPhi10gwYs6+0ynCImEb1wEw4G/MrcUKLGFeQ/rfw/nLn/9ChquIwPbkHZjZflRDn4vvcOUjmtQ7FDECJrVIr/12lOZciU6Iy2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5322
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> When "mbm_event" counter assignment mode is supported, users can modify

"supported" -> "enabled"?

> the event configuration by writing to the 'event_filter' resctrl file.
> The event configurations for mbm_event mode are located in
> /sys/fs/resctrl/info/L3_MON/event_configs/.
> 
> Update the assignments of all CTRL_MON and MON resource groups when the
> event configuration is modified.
> 
> Example:
> $ mount -t resctrl resctrl /sys/fs/resctrl
> 
> $ cd /sys/fs/resctrl/
> 
> $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
>   local_reads,local_non_temporal_writes,local_reads_slow_memory
> 
> $ echo "local_reads,local_non_temporal_writes" >
>   info/L3_MON/event_configs/mbm_total_bytes/event_filter
> 
> $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
>   local_reads,local_non_temporal_writes
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst |  12 +++
>  fs/resctrl/internal.h                 |   4 +
>  fs/resctrl/monitor.c                  | 114 ++++++++++++++++++++++++++
>  fs/resctrl/rdtgroup.c                 |   3 +-
>  4 files changed, 132 insertions(+), 1 deletion(-)
> 

...

> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index e082d8718199..e2e3fc0c5fab 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -409,11 +409,15 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>  				  struct mon_evt *mevt);
>  int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>  		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);

Is there some code ordering issue in monitor.c? Looks like this function
is only used in monitor.c so seeing it here is unexpected.

>  
>  void *rdt_kn_parent_priv(struct kernfs_node *kn);
>  
>  int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v);
>  
> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
> +			   loff_t off);
> +
>  #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>  int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>  
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index fa5f63126682..8efbeb910f77 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c

...

> @@ -1193,3 +1264,46 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>  		rdtgroup_free_unassign_cntr(r, d, rdtgrp, mevt);
>  	}
>  }
> +
> +/*
> + * rdtgroup_update_cntr_event - Update the counter assignments for the event
> + *				in a group.
> + * @r:		Resource to which update needs to be done.
> + * @rdtgrp:	Resctrl group.
> + * @evtid:	MBM monitor event.
> + */
> +static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
> +				       enum resctrl_event_id evtid)
> +{
> +	struct rdt_mon_domain *d;
> +	int cntr_id;
> +
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
> +		if (cntr_id >= 0)
> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
> +						 rdtgrp->closid, cntr_id, true);

Should non-arch MBM state be reset here?

> +	}
> +}
> +

Reinette

