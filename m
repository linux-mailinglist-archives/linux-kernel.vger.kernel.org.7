Return-Path: <linux-kernel+bounces-737408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD7B0AC22
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07D81C430F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81F221FDA;
	Fri, 18 Jul 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6K7i7Tv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D92221FA4;
	Fri, 18 Jul 2025 22:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877280; cv=fail; b=BEQtv85OAitxitzn6kiksEINqwu0LZVtiGLGp02oxaaIlt9QiC4Kp7wFO/SCi6O7BCSbSPDqhyRcVZHcCB3xARcHhbVmlp/i8y+KlRz9DjRvqCaCoOkZMdSurnqaW9voHZLTXxRfwJNvmwiZxmVkl3Lu/9+iHHPBJINogZDOsug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877280; c=relaxed/simple;
	bh=QluAKbrBSuplZDqYRnczbawR6p8gIFDk0V/fw51c52M=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHKKcp5SxTM7enH0NZvBGoZfGBjAExAASLu8x+J0PtcFxhiSkh5qSOSSDeIPd0kRGCWvAC2r5l2BmWkVyt7sMo+JB5uC5s3mxPoH5xe4K0YLKSY24bl/GpNbkaX1zKFsrInP6Up4w9HYKU6USAHdlPq4LdJ9/Jlkj1Bm3mnmcug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6K7i7Tv; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752877278; x=1784413278;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QluAKbrBSuplZDqYRnczbawR6p8gIFDk0V/fw51c52M=;
  b=H6K7i7Tvkd+1r+MapMh5ez/dbpD7Bf8nQbMbdemOuFhaL/W7Ddq73sKM
   HJ3HPTXMHip3qQm1IZCkOE8Nb1VlLwpPFrXVKcuz6MdLEpTMzVYONV8dx
   QoRQYOyEPABtbn9kjMAPiFmciV9azZSLFigXRI3VS8Rr2m6LuFfoB9oYT
   0+q6UTCmopGB9VSZNghS45DG/HwRASFxhNPbuUImHhhjpEevyhy34zqlW
   VMuwhIBWVTPM2y7gG43it+IoGKtMp1QLUWWQr9TKrpgNRgBuIcZhjLiCF
   q9cRYt+S8unNUUheio2Dkj9jGc2Z8X71yEIsjfqRa80vXGw9Q3egAjSMK
   A==;
X-CSE-ConnectionGUID: bErWncnHS3OcD50bRvy2mg==
X-CSE-MsgGUID: Y3R4iXg6TvenY8zs4PuJEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="65439878"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="65439878"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:21:17 -0700
X-CSE-ConnectionGUID: vsyOxOBdQ2q6VY95UTMEDw==
X-CSE-MsgGUID: dTgLW648TyGe3XXxqhQskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="162316632"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 15:21:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 15:21:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 18 Jul 2025 15:21:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.83) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 18 Jul 2025 15:21:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5mkBYhY0FMhVnxiStW33ie0C6GnUKMPS/ROegkkdVDP0r9XCtudFlUkyVIJCd67ebs1PJC5jgr1tydNHxbUPh0MDrofks2OJWssjvGITpWQ8j2uCqWifMn2JgA/PLZAszJf2o9mnAmBFZ1UbpeDa7fpVDEXLTzxHFdmu+xN/vg15MbIxF9ACy7vi4y7wWeOcZkcEBMHFsJZMuQ/MQHiHTa02V6dsbmtvfMSs3V66DwQT6EvZWboEEq6bu/kx4NN33PEo3H4dQTc2sL2jN55WVV+wKTHXLOoAvWhD8mMSsvsGNwF8ed7Jx86Cv19WnN0tDSCQC0Moo56EhpOBelXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJdX6kXIEBbshWC6zE8B72JyKiFAA6Yn84MtmJN4v8M=;
 b=ZiaRkYmfwqRDhqypFfVnRZzolTbgIgY9hEukYhMNFXqg1EruK7x8lSOakrqryyoPwPxjzvnpVBU17Xm0ev3XS3cKzR4Pe6w5ifxfCU20vOAnwujZeQ/cEf3MSlVNc4dUIKoglpVIdnf9NZ4A+SjrMqOOAKoTRaF7+kf3Ed5jdP+NlIsLQ5xBzU5b3P/lNVGnmEEFdeYHiSqdesk8E2kRVN6fbr7s2dXoiw7OjP5qSjW/dtLvIfjwtoQDLujWuntSfLGYr0NYyzwvAQa0m+8TAGg0hKf+Egb0Z3ET1tgtFYi3LeQeQ/Z21ppVSFzzTZCuBXvZOo+DjeFzHdxNDbh5MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.25; Fri, 18 Jul
 2025 22:20:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 22:20:28 +0000
Message-ID: <0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com>
Date: Fri, 18 Jul 2025 15:20:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 26/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
From: Reinette Chatre <reinette.chatre@intel.com>
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <0fda2f958001dec07827f803f0e31158a2b77a8f.1752013061.git.babu.moger@amd.com>
 <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
Content-Language: en-US
In-Reply-To: <2028b020-bb31-421c-b7d8-acb9ac7e9f77@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5250:EE_
X-MS-Office365-Filtering-Correlation-Id: b8468f14-dac6-471a-4add-08ddc6494cea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekxNVjRRMGtMeS95aXVWTnlKaytiM0J1YzZFclpzV1AzOEtOOXJLRmY2SFNk?=
 =?utf-8?B?MUtBRGVsY2lpTUltTkM0MnF4MiszMk1NcktyeTdhSTB2M2szQ1hqYkNaQ29w?=
 =?utf-8?B?RmhSUU9XY01kaDc0MGY0dGdxdkdVazgvS2J5WDgrTEgwbXBDcnBIUERQd0ZS?=
 =?utf-8?B?aGt1ZnpiKytBQUYvQi9qRVRVZVI0Z0IrT0t5ekFlZW1kajQ3N3FyZGk2VU9t?=
 =?utf-8?B?NEg3MXdzL0trbmtLZXlqck9TbTRpcVJwOVBEUU12cUFBY0pnMitQN2FyUUFj?=
 =?utf-8?B?eHNHR1lBaERSQU9KbVB2N0R2R3JHcCs1YllUanZTZ1hKS3h4THIyVU55Q0RU?=
 =?utf-8?B?TmFmSll2WmpzUU9scHRxTHVnTy9HS002V2FwNjNwTThEb2wyMHNNMVRoR04v?=
 =?utf-8?B?R2ZVRUkvdm5XaktvVjl2V0I0MVAxZ3hwSU1tMEU4bGpUN3ZhTTBLaVVXdGgw?=
 =?utf-8?B?TVU0dGo2d1RsV0psdk8wcTFMUldXb1pnVVZWVmVuMHBxQTlaTlBrWmY3UzY2?=
 =?utf-8?B?cnA5YUxxMEU1Rm5GQWRpS0dxeVRPVHVnU01LNnlWUG40MTRmNmEyQ2tvZXlz?=
 =?utf-8?B?dWd4LzUyQURUT1BVM3JRZjh6OFJxaHpxY1hVQWJQMVNHSXFTd3ZPL1U3S3RW?=
 =?utf-8?B?MkxLYjFlWGliMVNnOUJpWlYzejlFRTAyWmNJR2tnMDljRExXSGVJMGtNb0xq?=
 =?utf-8?B?M1RQOVNxanUxYXpvM2Z3WFFXd3lNTHVwaVA3MVkxbzMxOVBEWE9HVXhLdm1u?=
 =?utf-8?B?cWx2a05mVW5XQnZPWXlEemswMnR4dHIrZGpCRk02SkNKN1F3L3VUODRTZDJr?=
 =?utf-8?B?TjJjazZ3eEhaUHhzS2U0WVo2ZUpGb0lKN0NCaWxiN3E5SkdDRjFnZ2R0SjZm?=
 =?utf-8?B?Ti92a0FQbU9mYzRZUXdUOHdlZ1FvdkNtaHB0RER3UkpMWWZ5Sk5JNzlHSW9S?=
 =?utf-8?B?T1ZaeU05T1Q1VExBbHE2VGszWEJJSzluSjFGNE9ualFWQnZCdXJXMHhpRHdi?=
 =?utf-8?B?WUtrcUZWb0k3dXQrT3pKbEpzbEpZOXVYWW44TU1SRFREUWIyL1NvRWdYWEJa?=
 =?utf-8?B?NXI0ZnFaTTZOdEgrQkZYTUZsOGJzTlZpU2N1NVU0WkRsb1dycVlkNGM2b3dV?=
 =?utf-8?B?dEs4YUsvMkkwRXluVnVIa3F5U3dhUXRJMHVyYXdLNWhsRXg5dU1heXhrNUNt?=
 =?utf-8?B?NW5SY3QyT1FDckZZQklHd05USmJMSEtmYTZXT3RMNjBtVlVEQWdOMG0rblkr?=
 =?utf-8?B?WDBjNGNRNDI4d2JCeXhTTU5ibDhDdWc0Q0hyZ3hGU091MHVUZU5mWWJMRHgy?=
 =?utf-8?B?UUNlSDV3bXJHcVpGbUEzT1E2YjVYU05KbVRaN0pudm5iUFVsZXNqd2FTc3NO?=
 =?utf-8?B?ZHNkMGFuNHM3cUxSRTZacEczWjRCZE9YcktZVkpqcTlCNDN0L3Y1RndxTld5?=
 =?utf-8?B?TnBMajZnb1IzdTlwM0dmWXJxTjBjaDlOZU56MXlYMm5BaTFPY0VHMFkxeTdW?=
 =?utf-8?B?TUhFaXFFOG1NSnlodUJHNDBkZFNnR3k0TlMzVHU0TGxMeHRoMkcza2Y1L3k5?=
 =?utf-8?B?RzI4ZGk0eXRIbndPT2l5NE9GdkZUUUVYNHl2ZldVNnJkWXBLSGpQZXBuQXdL?=
 =?utf-8?B?TWo2UXVYQktsY2p0Y2s4VGdMWHF4ZGVZWEI5NUpVUWkzM2ZLRWxvTnFEUFRL?=
 =?utf-8?B?OWowTktFdlFyT1RBRzU5R3BNTGNUS2dQV2ZUa1J0LytiOGdaQmhBWnVzYnlD?=
 =?utf-8?B?TERmbGJCZEJhZVU3eEFtNlRtaUt2QWtycHRZUkx5eFVHbEY3aHFsOFA3cGVy?=
 =?utf-8?B?b1YvU05naU9GNDhmMXJxQkV5bHZlSzlKYVBzRXE4b2pVSEI1eHJZSFRtOXpi?=
 =?utf-8?B?ZmtReHNZeW02MWNPWGZhQjdxVDRJcFpQYXF0UmpWU3RPcHdIM1hiQTY1WHVj?=
 =?utf-8?Q?fs5tA1zNPTc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWVnSGd4RkxBRitXbzBibVhweU55SzQ3Q1N2bjIweXU3VnBteFl6SG1ScCs5?=
 =?utf-8?B?YXhpNm5ibVRhbXl6MWgxMlM2dXU2bUxObS9lT0QxKzJTUVN6OGNKMTdVRytJ?=
 =?utf-8?B?ZkRHNWljZ1FIVzI0TkFub0QyOVYyWDJiZ1J4cVU2VkpkdmtER0E5TE16RVJs?=
 =?utf-8?B?MTJMcjhyQUtlMWFwS1hmcXlzaEt5MCt3OUZwNk5reWdRQ0VXYkkrYWtvTldE?=
 =?utf-8?B?aEVWUjFVcnRPQ0ZGVGRnMUJoVWhZdkRBVmRmLzhrUVZkamdWcGxIWUsxOXNT?=
 =?utf-8?B?TE5XU0JlcGdxb2dZdDN0cklYNmtHOGwwdDFhQVlnT1NSd2tGajAzQitBS0hi?=
 =?utf-8?B?TU9wdmMweFEyYUxLdjZJYUEzV2tUMnZTdWUzSjdxQUdWZ00rWThsMG9HS1Rs?=
 =?utf-8?B?WWpwcitVODhlUSs1T3Z5UGhmYWlGa0xxYTJLTW5PV1N2SjBPeFcrK3BxcW1B?=
 =?utf-8?B?Z1JLRmJDTFZCSnBCZXF6ckp5a0lQMEVJVXVyaXFVRG9YNlQ1YTlKNjZ5S2Zy?=
 =?utf-8?B?OFFpQUREYW13TkZLWDBGK1VZYUlPNkh2N0pUU0x5ejg2L3ViRG9MMXFFeW44?=
 =?utf-8?B?VFNJV1p1UmdTVzRLaTlFZDBsUVVlZ0g0YWd4RzlXNFVoRkdLOTBuc2QyMVFn?=
 =?utf-8?B?djFUSXo1M3lMOUllNUtCQUNPeTYyQXFhK3dMZ3hSQUI5TU5iM1VkaW9CcEhk?=
 =?utf-8?B?dzFzNzBXaFdBaW0vM3ZoeWd3NyszVDhpa0U1WEdwbGtJajE0bEo0NEd4cWdL?=
 =?utf-8?B?RWRDMUJNYlliOXI4RkN6K0EyRXhKUXpSNVYzTDA5Ukl2T2hYUXdJMGp3WXB4?=
 =?utf-8?B?bS9sWUlKQ2Ewa2I3c3RnNVIranZRMmtlNzRiY2N1N3h4MCtpNU4vTUloaDh2?=
 =?utf-8?B?L2N0VVBaZEMxYnU1VEdwRkRFVS82Yk5PYUN0VDJzbXJMMkZCbXpPU1dzZjBo?=
 =?utf-8?B?WU5jYVVuTXhJT3ZSR0NPYnk3NFljOURNdWU1T1lXTW5KS1plZGxyUk9nd3VL?=
 =?utf-8?B?VjdpNW9WM2ZZN3ZnaHlRKzRhUDJYd1ZNWW5pSURoWlRZYnQrbVpvUERmdU5i?=
 =?utf-8?B?YW5oS0ZrWnppMG1qcnlnSnZIMm1mZXVFREUrS0grb1kyZ0pjeFBoUkdSTDNU?=
 =?utf-8?B?QWhNbFFxS0E2S05TR2o2SmtGcnlGaEpQWDRpV3BGNEVJT0QwSUsyNmYvQUdq?=
 =?utf-8?B?RnZtU2R0SXVLMGhXaEdlNnBmdm5mYlFzWlljU1BuVG5YOVVzVzRESjJLcmxJ?=
 =?utf-8?B?dUl6bWxhcWVObThnUHVnTzFHQXJnMko5NWRyYnVMOTVHK280bll1anJ1SXJG?=
 =?utf-8?B?dHY5OTJ6bEVYRi9mblhIN0JUZHJrVTYvTXlyQXdRdXQzUkZ3NWVtTjJxYkpP?=
 =?utf-8?B?Sml6TGNpckxsV0FyandGNTFjRlVJUUFBcGZlMGFCMGt4S2ZjTG9VKzBmbEYv?=
 =?utf-8?B?SmI5T2dVOFhrSCtoL2hURk41S013MkVCZEdlWnpZdjVoblREUWFhUjI1Tlow?=
 =?utf-8?B?NGwxSTE1bVl0MmlvM1dtbEFmWno5MmxrSjc2Z00vZXN6eVZLYzJmSDdnS3lz?=
 =?utf-8?B?aDJWZHZEd2JvR0JrNDdKUWppYmVMOFdzWDl2eW1LMm5xMndrNmJFakhXeDZL?=
 =?utf-8?B?WE9jL3pZbXFRZmNrWnRZN3lzengyWWpMYmo2WXp0TUtBL3djN1kxd2MrUWhU?=
 =?utf-8?B?T1BLcmY0TUhIK2tUbzdoT2pkUkpaK1l2ZmlqUUlIMnd1U25IWDU5V0J4M3Ji?=
 =?utf-8?B?blhRUmM1QVovU3FpUnZSR2VvSXQzUkxpa0d0UjBQcWEzQUVvWVpKOHRiR3JT?=
 =?utf-8?B?WUN2UmhwS2tqTjV3cWx4OW5pc3FjVm9SVmpxME9HMG1od3FSTlBIcExqcDV5?=
 =?utf-8?B?N3REMXphaDV0WUk2YS8rOEsveGNIWW5ITHQ0bkN1UDRuUnRqUFdJZ1VMZ1ZQ?=
 =?utf-8?B?dk9aM2QwRnpGZ0wrcHJaNHZvYTZ0aDBxTzRnMFJVUUVOVjZBSzIwZm4xSUgw?=
 =?utf-8?B?b2w1Q2l0ckZUc1NxNzJ2dmg3Z1ZEbFhFaE9zTG01UDRNUFNWK1NHcmRGR0Nz?=
 =?utf-8?B?SHl6TmJiVHhwN2JRQndIZHE0dXQyMkhxQ01JRVRZSzJNWHBFV3QyU2EwekhJ?=
 =?utf-8?B?dmlCeEdpZDd6QldJcUF0djlNbUU5bVRvcXJrQkpaSnFkcytZTlYxcnVyanFp?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8468f14-dac6-471a-4add-08ddc6494cea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 22:20:28.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMHIYv3ilbIrcVEPvUWmfd1QKK5n4KUvvr0f6ZT4NfZY2yLREWNhLHssiucSEHIFnI9xlxw21LYA5NImzARZDwnVgvlhxDKepY02BFdxNd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-OriginatorOrg: intel.com

Hi Babu,

On 7/17/25 8:54 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index 15d10c346307..bb28ef7e4600 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -86,6 +86,8 @@ enum resctrl_event_id mba_mbps_default_event;
>>  
>>  static bool resctrl_debug;
>>  
>> +extern struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS];
>> +
> 
> Please move this extern to fs/resctrl/internal.h.
> 
>>  void rdt_last_cmd_clear(void)
>>  {
>>  	lockdep_assert_held(&rdtgroup_mutex);
>> @@ -1895,6 +1897,25 @@ static int resctrl_available_mbm_cntrs_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>> +{
>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>> +	bool sep = false;
>> +	int i;
>> +
>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>> +		if (mevt->evt_cfg & mbm_transactions[i].val) {
> 
> mevt->evt_cfg could possibly be changed concurrently. This should
> be protected with the rdtgroup_mutex.
> 
>> +			if (sep)
>> +				seq_putc(seq, ',');
>> +			seq_printf(seq, "%s", mbm_transactions[i].name);
>> +			sep = true;
>> +		}
>> +	}
>> +	seq_putc(seq, '\n');
>> +
>> +	return 0;
>> +}
>> +
>>  /* rdtgroup information files for one cache resource. */
>>  static struct rftype res_common_files[] = {
>>  	{
>> @@ -2019,6 +2040,12 @@ static struct rftype res_common_files[] = {
>>  		.seq_show	= mbm_local_bytes_config_show,
>>  		.write		= mbm_local_bytes_config_write,
>>  	},
>> +	{
>> +		.name		= "event_filter",
>> +		.mode		= 0444,
>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>> +		.seq_show	= event_filter_show,
>> +	},
>>  	{
>>  		.name		= "mbm_assign_mode",
>>  		.mode		= 0444,

I am looking at the SDCIAE series now and it really looks like rdtgroup.c is
becoming very large with code from various areas mixed in. In this series I
requested several functions to be moved to monitor.c but generally did not
highlight the main handlers added by this work. For example event_filter_show()
added by this patch. For this work, could you please take a look if the
handlers can also be moved to monitor.c? I think this will make things cleaner
since the same helpers and data structures no longer need to be shared by multiple
resctrl files. For example here, mbm_transactions[] can remain private
to monitor.c where it is most relevant. In retrospect I think this is what
we should have done for the BMEC work also.

Reinette

