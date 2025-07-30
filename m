Return-Path: <linux-kernel+bounces-751305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 318CBB16779
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C4188FE53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B8121770D;
	Wed, 30 Jul 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsJ5QaMc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62421FFC55;
	Wed, 30 Jul 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906453; cv=fail; b=WJh1hOdVTrHRhvrYryE3TyaTfmq1R6GTkkdziVdHSNPcSHAyMmeKFo2aA3SiqZZoN82USjC/mmzk6oBFB9GRBACEsxYPdAa+fxkF/ikjQ1BgXeEjt/AVB5L6kCY7XAe7P0wiKr5gz9F6weoFf2G9GHgLrBAyazSqdDUwQr37tn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906453; c=relaxed/simple;
	bh=HPVQ0YPqb+rPjc2eh3EDhiRsHe72HuuKPYK4pZa8u/g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R2XXE52qDbk/n8H83T90X38c58qnE+uQ0btydlgqEbTLEMQw17GaBnqiY2tErBpElwNo8HV7Pq2DNmAvnICGck9EvPxTaoWWn6WQBgkPCDLNrBx24r+Eh8iO2/u3g/RcOVM9eoi+9BtweKM3J/EwSGtttKAdgm4txdRQBwFPzeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsJ5QaMc; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906452; x=1785442452;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HPVQ0YPqb+rPjc2eh3EDhiRsHe72HuuKPYK4pZa8u/g=;
  b=hsJ5QaMcP074AzKtvlmfZfSq6zB1dgqemai6myohR0wLKnEAE9HUINv8
   QHCGOrbczo7w85GsfgUD2QIwdhcPsPRwrDNVKmNcGlcHdEF285/92Qgw/
   In+JaQ8/rvfrH6lyhnIIxeJBbqmO09D9kUf+di77Iwm5qB9qrdFvHDdXj
   3Gci6LVBBqJmEjq3mvx7TPh5MsKdkzeildFXLYfD8GfvTlosrynZ0O3Iw
   sHEt83HGt2Bh2eQxgaGvhbTn6KfigI1s4lcPmKZ6YiCRqbyhJgSu6BRj/
   42ZmPSjrOMellebRefQWR7Du1rhn7DTHRE8Zn7o/qF357KOuFcWXxDKxD
   A==;
X-CSE-ConnectionGUID: DQ95LuGrT6CqCwNEG57J8w==
X-CSE-MsgGUID: Ugsu3FyRS86rpiKPnqPzkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56087682"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56087682"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:14:11 -0700
X-CSE-ConnectionGUID: bmyk0G+LR5+2/V/2B9Ydbg==
X-CSE-MsgGUID: 1TZ4dCz2T9GkY8LNVQZfaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162360428"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:14:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:14:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:14:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:14:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBZDzSeb+eViTQOwK3ckXtkQEKEKu2irf+d41tQy8a/wTdcHSWQFjWZRCz09RF2TSEQQ0AoNLh9DhtJlHjLMe1+rX+sowCACLWRmsXA8zZUhH+SX5/IpbVMYm4aaKwnDMmeqe/di/xWP4GWV1SmkIB2Cv1wO//a5XOfXfr6r/Timtxf+5+89An7dX3MUn4MhrxK2dAtBbEXxkvJbTD9D/YSNrhYwYtdfWN4Tzfb/RF8B3sM0hIPZGRSmBOMuq8rzMn2Rrwa+tIJo/LLzPbuwVWnphuFhJ/8GIrOPDlitIMwaPFQKUz6x8iECWEsFH0AErebEiRGcHeCSDabsH9aOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fMYFB4dwjGxcZ/xcgD3PTx9BUiP8ZjOVaytHxqpqiI=;
 b=ZyLgnly0XAnFOrkY+zJZsFX4F5yzLnk5UqhwdRbURxOyvNgKSkanNNE8D2K7wrTfN6TZi76sJANwTU9gKG26McZ775RZ17o8yqpRSQrEGmt5tQr08CZehL4ijdhHdqEe/kl50pJwn54tM8OQKlcvsUWbOauSUfwOVUbB5LGp+lK8/Yz08WbQwnb6T70Zjv0eC8nexywWAM8/RkvkNVDR7MozatmeSkhdXDUc+JlR9Q+wyGXcDKyDqhJdWfX9INbe5xNuK5nB+HOLIDtzgZWz2riiQlgkcoLAwfPjrZ4zXVxEdOkSuwIpbjyhElmYhcpb7eMnGERBmbkACrSxDw1f+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8515.namprd11.prod.outlook.com (2603:10b6:a03:568::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 20:14:08 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:14:07 +0000
Message-ID: <12501ece-0106-400d-93dc-de5f05a03acf@intel.com>
Date: Wed, 30 Jul 2025 13:14:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 34/34] MAINTAINERS: resctrl: add myself as reviewer
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
 <716f7dd7550b7cce8d4a3b1b29904cdf7224a090.1753467772.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <716f7dd7550b7cce8d4a3b1b29904cdf7224a090.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:303:2b::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b60134-a9ba-40cb-c615-08ddcfa5a392
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXpNRFQ3MlEwdytrM2szQ3VHMWxBZmFkZFBXV1ZlZGo3U2xFNjkwZGxRWVJ3?=
 =?utf-8?B?TFZKZEtLVy82Wkl5b0dybjZhbHN2VE5GRURnRDRDMmhzMnRydldCK0JEZEpQ?=
 =?utf-8?B?RVpUajc3ZmQ5ekYxSS9Pd0pFWitITkZIbkY5d3hvYmtxVWJSaVZDNWJ1cEth?=
 =?utf-8?B?bXN6TStxU09rRFhhT0VFdUx2L0x4YkZLT1VLcWE3eUdhQUZIWEtGYmhuZ3RT?=
 =?utf-8?B?emZJVnB0ZEJ4QTROWm5xejZCL0UxN1FOWFpQNXF2cFY1d0tNV3M5bnM5TVRN?=
 =?utf-8?B?Ynp1TFpUangwRG0vN1dCUFBLZzFhbFo4b0pYVFVVQk9MZ2dCeXhiTTNKdUt5?=
 =?utf-8?B?UXpNZkd1TDRacEdpUDkxSU9VOFFVYVpqVnhYeGl4Um9BakRLUjFxbXVaaVNG?=
 =?utf-8?B?UGVqakFscmhoNVVJOCthYUM0dllYcmt0NWh2eVBSTGFhZnoxYnB0TmR6UmFy?=
 =?utf-8?B?R205dVVwWUJzWFZISzBoaDRhSDlCRDNGZXpNcUxCM01IQkpNeDJWVzVSd0hz?=
 =?utf-8?B?dlZ3bU5KdVhocXNMMXBFOXROQ0paaHJBU0RIbkFKVTJsZnBITU9sSklUbzBj?=
 =?utf-8?B?ZDNsMEJJd1JCWHN6L2JYaEtuQUlXMTBPaU0yY3NaSXVreTFFVVp6SjkvcjRK?=
 =?utf-8?B?S1NiazdXVi95cFY5b0ZSNXVrSFc5QjN6RSt0VWJzVWtlb01UQlMwTDBZVHM2?=
 =?utf-8?B?cDlnM3o5VUNHMjZTLzFvc2xpTENqcFVncmYzNUtUejd6S1MrcklVQ2REeXFG?=
 =?utf-8?B?RTkzWm1QcFFaR00vMGVtK3Arck9kWG5xNkE3eUNFVEZaTnpXdVdVMlh2b0Rl?=
 =?utf-8?B?dUtRYU1UdXM4RUJ4NzVIcTBKZW45M05JRWlPeXUySitURXMrcmJRSkN1REVE?=
 =?utf-8?B?OGtVSVlQRm5XbHZTekk3VWFHanZId2lpeDRHbjhVQ05NQmR3WHIwakFOUnhZ?=
 =?utf-8?B?M3JDd2MrM3ZSVDEwVElpNk9WVlFhcE5GMFhkdUxRdDNsRjFwb3ZRczFvejRM?=
 =?utf-8?B?bWpTNVFZWGJURjV2aFVuenZRN1R3NnFBMkpBeWo3MzBldzkvRWNyZlVqUTBv?=
 =?utf-8?B?Rnh6T2dTKyt0alhQazYvUEVOWkFDTi9mdmVnbmxaVEwxS21zaUZQRDBKendY?=
 =?utf-8?B?TC9zTndYWmZkNDBBa0dsSzJOSUNnVVNubGh1SmlGd0I3WG5oakU3OVZyWklN?=
 =?utf-8?B?a2JEYmRYbmlHSUZaTlVpZGdWUE5LMFBrbEZnQjVKdGRjRGNJU2ZuV1VCRlZZ?=
 =?utf-8?B?NSsxY1Z0Vzlka0ZQUjVPVFFocGZncFhuNVVKZERDMEJkZlNuN1hwcVJXdWVW?=
 =?utf-8?B?YUhiVGVHUkpQLzBzd3BTWDA5MDRDMStMUmJXdTE0Yzc5R2NPK0VKa0N6Q05p?=
 =?utf-8?B?M2dvQUFhbzRvUkQ3a1BHam8rR2Z2M2Jna1ZVUXRESTlSbjZheFNsdkNia29q?=
 =?utf-8?B?cWIxekhWbVdhaGdzOXpQQVMxSGs3eHBja2hINUkrNmJFWS9LTEdOMEZUS2E4?=
 =?utf-8?B?dW5XVGd6eWhOdFdiaXh0dkRpbk91eEtvZExHYy9hTDEvcEJCaGJlckdyRzAz?=
 =?utf-8?B?ZW9aZzU4cmVNT05sOTRmM2RnQm1acEVXN1E1VnlVUUlpaXJhOUF6c3ZSVC84?=
 =?utf-8?B?NnY0U3d3RVEzMFBKY2VOU3IzdEEyOXgza0xlUFVQUHhNK2JKUlR0anBiendW?=
 =?utf-8?B?cngyODJBL3Bkb1loZXJmNFkxTUtEU2VzSENoWFRNRngrL00ydm91S3IzL2cv?=
 =?utf-8?B?NGZ3dDNpQVFJRUxJc0RYdjRROXBUQkx5SnlJKzdrWSt2MU4waWhQOXhtU21R?=
 =?utf-8?B?QjV0ZjJiR29EdW5JNkV4Q2hGczNNeG1QemFrWjR5UnhyclloRVR5d0I0b3Vx?=
 =?utf-8?B?SEpvRUhFU0FzVDZEcnlESDFNYUI0NkFQSVgxVVNKeUtYTEJaR0dvNThaZXp0?=
 =?utf-8?Q?gLTm5MgI2JM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckQ3dlo5T3RyN2FIRkF4aHdWc1UxS2pkM3dnWlArUHYrQnlPYUI0anljMjJw?=
 =?utf-8?B?WDZhdGVxRE4wVFhFRTgrTEtyZDU0VHluMDAwRTNSWmpJb25jUzhBRlE3WFg5?=
 =?utf-8?B?aHI0V3BUSnFkcXhidU00T2Fzdy9KS2lHeVdQRkpINGNISW9nMWRDeTNKU1BG?=
 =?utf-8?B?ZTJUWWtXV3RmWlUyZ3p3MnZrZWZjb0VtWHNhaG1QYXFxbTVXQWY5ZHlsRlhs?=
 =?utf-8?B?WVFjODRBZHlaWDZhTkNkMkdmc3VqY3RPdjNhZElqOXA0UWJ5d01jcFlsQWly?=
 =?utf-8?B?SmNlT2JqQ3NteVdKZWVPSHhyUjRoVmlQeTB1ay9kaHMrdlZzZHF2dCtGTlU5?=
 =?utf-8?B?c3FFUkkzWVhaZHg1ZEVZNnVXMFMzVG1nSm51ZUgzNEt2NDN4b3pyOHhKY0hN?=
 =?utf-8?B?c05Vdk12TGNxUkdjZWV2RmYwSUhkZVRMOVR3a0xNZE4zbm5CRFhTZndUWlZG?=
 =?utf-8?B?aTJCc2t1QXJUS1NuYStaOWloM2ROYW54TnVubktxb0ltYjMxbXk1OTVYRzk2?=
 =?utf-8?B?VGwvbkQyeUJxOHFIQXZEZUhCYzhzT2ZGQkhpZzJSaEovbEg1d2l5c1kvcnF1?=
 =?utf-8?B?ZGJoYjZ3MllyZGVRZTZ1OWl6amlQTEVRNGpxZW1IMVNaajBiQVVoOUdKUEls?=
 =?utf-8?B?R21RRm80V3d0U2d3SzZoL01mM0J2MWM1UDFCN2xjK3NjYjFWSURXSVpPNWZC?=
 =?utf-8?B?T2Y2OWFyU1czR2YzdDhqQ3FseVdqSEhwajg1bHg3WEluQlhYSHZNelgxSXRp?=
 =?utf-8?B?b0NOeHNBblFGaTdnUTYrYVN3N3ZVRnFxc01sdUR5SlFaUmNoZGg0TC9KN0k4?=
 =?utf-8?B?b3dMeTBwWVh0ZWt4RzM4Y2w2WUhZN0Q2aGw2VzIyenRmZlI0YlM4UGFHNUhI?=
 =?utf-8?B?ZFNHZXhmNDdkeTkwK244TWJtcXdVbnI4QnlsL3ZWalZSYWt2MFVuOVB3N2xK?=
 =?utf-8?B?SUhOUFA1cFpYQktKeDQyREE2NnVUNFdnWGtEdjg4ZG95NVgxTngyT1NESlg2?=
 =?utf-8?B?Z1AxOTA0ckxUT3IxSVdsKzZNRThDbisxajFoU0pQeE9SVThud05NSmx0eVZX?=
 =?utf-8?B?cjJaUXBseHc3TWI2VkFONUp4NXZlZzI3V2lqeUZiQUNIZ0VFWDFjOGkyOEo2?=
 =?utf-8?B?djJNQldaUkFXWkhMdHlLRnM4Q1Y1eElQUnpoUUp3MHZJalo0bTN3Ujl4OWgy?=
 =?utf-8?B?M0sxWmI2NFJvVmhaUjg5OHVRbmdVQ3ptWk15RDBQT3I3RlZUbUNqRW5xVXdi?=
 =?utf-8?B?NnNTbDJuWGFyT3NqQTZDSkVKdGptLzFVUUZSK1ZSdmdNWUhQTnBFRUlRVlVC?=
 =?utf-8?B?ekNOK2h6MFF0VVZoTG1sTnBubFJvWXFjZ25zaWVKUS9WRzNXZ0c3cjhkOU9Z?=
 =?utf-8?B?ckNnU2lHS2ZBaGxpT0pFTFExRDlhbDg3Z09TMDJZbUxpVjVFbGVkWXBONVpr?=
 =?utf-8?B?N1BIM3RHTEdaZGJyejdzb0xWYUlzanNFN08vQ25pSjFxeHhEZHBkc2s4Zy9a?=
 =?utf-8?B?cUhHclJDMlBrbEw3emFQRFJ5aUE2Mlk2MkJHYkRRSlhlak1EVGJGOEVoSHJn?=
 =?utf-8?B?eDFjSU9QRHF0K0pFMWRRN1J2Q2ZUODJNaXFzRmdLMVpTbGN3aEw5Mm9WR3lt?=
 =?utf-8?B?QU5VTWk0VWUrb0FpM0VkTjA0NDNJeGd5THVpYTE5UHVwTy9oTnBtdkg3cFVH?=
 =?utf-8?B?OXhlTnBEKzFaSk9nc2VQbW85OEFSY1ZTei9NbTA2empQUndILzNxUkVXRktX?=
 =?utf-8?B?SkpFOC9tQXhhZUtUZVhFcVN4U0c1K2FLcHhBcHcyS2c3ZGJTVHhtaWZWNThw?=
 =?utf-8?B?L24rZG1xTXhvcUZqMGxqUzhYYXFZZTBhVkNDQ1FVL3VaOHI1Z2pGNVlQaG9h?=
 =?utf-8?B?Z2pYdFVhdm1DSDJzZ0IzOTg0alg4Q2p1bnNLRDdQbURKSjdQcFdvODh1YnU4?=
 =?utf-8?B?eWNhKzA1VmdCMUgreVVwMEpVVVhYMUtWWVpHaGthS3d3OGFiOGFXWFVvcitU?=
 =?utf-8?B?dW8xcU9HUVdFNFZyaDQwK3VIL2Job3dOMjRTeHlCQmJVdU43WVcyT1ZGOVF0?=
 =?utf-8?B?ZkhVZHJabUdMemsyU0lkNUVGaXptZ2RtTmFQSDNJbDRTY01UakxpMHRGanYw?=
 =?utf-8?B?S2t2a0c1SGpLNE4xV0QxaGZQRkt0YlZ4ZEpwT3IvQ3ZzTEdpT3FVNjE4TzFp?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b60134-a9ba-40cb-c615-08ddcfa5a392
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:14:07.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHqZ2hnaU3OvcVznVslgyTKYKHECJdVnZZtou2Vr7xdQ87QA/BxWa5rQcM5BCLNxpfc0g5Xsr/vriC5LQ2dDKM6JGVDPoecl8HVZqQyiPXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8515
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> I have been contributing to resctrl for sometime now and I would like to
> help with code reviews as well.

You do not need to be in MAINTAINERS file to help with code reviews. I do believe
it is important that you are cc'd on all future contributions since I am not able
to test these new features you are enabling so having you keep an eye on the health
of these areas is greatly appreciated.   

> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v16: Reinette suggested to add me as a reviewer. I am glad to help as a reviewer.
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f697a0c51721..70a2f83145db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20866,6 +20866,7 @@ M:	Tony Luck <tony.luck@intel.com>
>  M:	Reinette Chatre <reinette.chatre@intel.com>
>  R:	Dave Martin <Dave.Martin@arm.com>
>  R:	James Morse <james.morse@arm.com>
> +R:	Babu Moger <babu.moger@amd.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	Documentation/filesystems/resctrl.rst

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


