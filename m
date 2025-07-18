Return-Path: <linux-kernel+bounces-736242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55557B09A63
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B6316A85E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761061C863B;
	Fri, 18 Jul 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GckH0c0W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F63012B94;
	Fri, 18 Jul 2025 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811303; cv=fail; b=PU+qzR8fSFcQyC3hnBgD5GZIl2DpFraYCmkPxvyEKCDJqta8xvGlJP0l96bZphHvprCpfOuaWNJpu2HoqObzMoEupsIrdJddq9dL3buPOETJrAv+WNLhDtscgnwmLSI0K7qpJls1go98oRpCXA5JDgxsrLU1DPei+nGmp1d24Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811303; c=relaxed/simple;
	bh=gP763rvDZU+yT1Fh414Q2j5Yb4mVP8WDX3UAkhMwCio=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jNBzz/+JgVwblCOudk73IK5F5fXSOjOBcFd/DcsLRATpNnuhYAf1pyOgwMcQbzR6s8LbdoGkvTklfJHpa3GGX/X6XZJubdctwE6QNp2DK3EbfmDEz8Tp7n7FHqry+OXYm3bV64aEW48mmglXTexDuWi0ukfbdkajrnR7kC7Tz+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GckH0c0W; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752811302; x=1784347302;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gP763rvDZU+yT1Fh414Q2j5Yb4mVP8WDX3UAkhMwCio=;
  b=GckH0c0WxS6TmrwAsc1qdlzgVrhz76T3MITXxu3sym5jLNMIS6z82XYJ
   0Cb8vU4a0xdH7EiOE5H6FVYvblQ+UJM7hAdfxBE8/ojZQ5Pqf/RlFTy82
   J5/oFwrcfJEEw/alyGS2ddCyrlcilISwgwtxlawL170MWkOwbB78hI4Ba
   vgpaDy9RSiiohOwrID892asRD1lOcx/GQvadwzGFMMPhPM2geD9rYXVJl
   7SSsLjDuFg4ybjUuH94xx3JvZxSVkwW5tpFienxeQJkSjrP/O63typvqS
   1ObiWVDtNw2WjZDrk43Wx/0OWiQaPZQUK1wOLMcG58f9AdNltFTZ3m89+
   w==;
X-CSE-ConnectionGUID: q+KczdRXRJO02JfYbbTqqA==
X-CSE-MsgGUID: OJnQThPxQOC40oXZ30yI1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="58880348"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="58880348"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:01:40 -0700
X-CSE-ConnectionGUID: /C4haXnNSQ6N79n/aMGp1A==
X-CSE-MsgGUID: ya+m4vB9TK+Hv01/9eS5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157636992"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:01:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:01:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 21:01:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.89) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Jul 2025 21:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skVocA/19l9pw1dGnbuAaUn9gPQ+e67ZzdX3qqDnmVKpoFR1sGVjX2yGNA4hG2hJ1qfLMqKMadSADk60zf2VTvsAnnQw2Ff2ltxwCbF/Isifa2QxAcYU3Oubhchxhakr6Jtt/gASmfBIkMJxLv+kSsjYkPEzxem+5IRAfiO87QqJ574gZVpgbq/hbK3MUUoZ3TS/DTikwD0F7A5kgR47a178jI2LYZf+SohbDwk1+u+an9xAlvemGLLllKZZPeIi0KlLGO2UgVoyg8GO7bY+fEhTfDD9o3q9Pjsg8wPKmHzFDA60Dc5PsfaZRa209yv8AHSKt808sbym+ML3r+4Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gpOJxz7d5Wfh8IDqjxQYoroK+ACYUWGe2AE0yl4H60=;
 b=r11Ve1f7zwhiklSch9rk/31A/1ojTC5mD1Cn0QsXECB5jU3RMcLLFdjeLGzfCjCQNgjxZYrQaYy2oGooAwoD+zGu4SSE1UA0NOW6SxX6JfIrjOL7uFmBSqM+DgEIKGGHD6dp43ES2jwdkax8iVIHP+RPqemRBcWaCw0/JUrCPUbyAy5/Id/jLdjH6DjvEPgZ0gwAahrmgoD98l+c3yvjuz+eKE1KH/BJf36/WuC3HNbQDFDos83vEHvd9DLoOH8WyM4d9vwQn58NGlphH3TAeuDGXKgPrwbwaTtQL+RunMxSiGi7niSmeIsiFmmJowNdayq0FyF/X8V0nPvzfJD7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 04:01:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 04:01:21 +0000
Message-ID: <de20ecd6-8cb2-4b3b-ba5f-b38f33fe128b@intel.com>
Date: Thu, 17 Jul 2025 21:01:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 31/34] fs/resctrl: Introduce the interface to modify
 assignments in a group
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
 <0a646cf184a9113c54518b14a5c94984b36cee2a.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <0a646cf184a9113c54518b14a5c94984b36cee2a.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:303:b8::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a38f9ca-6b33-4f70-d8d3-08ddc5afc14b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXh2MEdtWDlwQzNORTgzckF4blJvTWJlU3Y1aDQrMmlLb1Fmb0lIQ0N4QUM0?=
 =?utf-8?B?OFdkUDVQUkVqTzY4VHZSZ29INU5kUzdLZEVGQTdPaFhzMkJaVjJ0djY0d1Vk?=
 =?utf-8?B?dCtKRk5LajllblZwK3c1MEtqc0NNQWxDR0lYM2tsUFlSLzdIbjNSWlJPZEpW?=
 =?utf-8?B?UkZlQyt0ZE9vT2tGMHJqN3FrUFBVOVVCcGhQMHMybFYvYzI0VmtTL0pDM1FP?=
 =?utf-8?B?Nkx4RWJTb1VaeEpGK0U5ODJpYW0yOU04ekcrS0JoMWwzMDZYbE1Iam5adHla?=
 =?utf-8?B?QUhCTkhLNFRURytJaUx1bjlBQktpM1FvSkZSYmdUU2ZKOTc0K2JyRkJFVk8v?=
 =?utf-8?B?dWh6eUZNV0NnWXhFMGhwVTdsUHdoSjdYYytKSEdtVjVvL05DMkY5WHZJWjVD?=
 =?utf-8?B?VlUwTERZcERzWU1BMlI2L0xYcVRmY1JHQmVHWk11OURlRVpTZE5nK0dGR2lC?=
 =?utf-8?B?cmhmKzhPSUZKdnJtTmU2YS8ydWFOaXhiaktjL2l6TTZtcHJDU3lLdmNTandF?=
 =?utf-8?B?RjV0WWxtVEJJRmtpUlgvRXhwRUNGTEVqdVpzeXFrdEdhT2x4bnZRYlJ6eHBw?=
 =?utf-8?B?SHNBNTVoUUZyNXVXODE3b25XZ3lJYkxTNmdwbEZZR0xtSlRLbnNTM1NkcXMx?=
 =?utf-8?B?V0JiZzJDSTRRQlJrV3pBRDVvNFk1NGFMbklJUkl2a2I1djcvcG9GbjVXdU1W?=
 =?utf-8?B?b3g0Z1ZJRmJzcnNjM3FaZEYzUVpWK3czZEZZWkRBbVVwMXkxS0I3dlhxYnRs?=
 =?utf-8?B?clRPR2doYWpkTXVxODFidnhLUS9QMGxNcXpVY0loTDVieHhZbDRobk5kdWt6?=
 =?utf-8?B?cnpUeEE4YnJ3cERxYXY3VUhnWFJpV3JNRHgreEVvbzk5MzM5bEkxWEVNUDR3?=
 =?utf-8?B?b1VjVWRYSlVidEEybk1sWXVJWlA4RnNCSHZ3NC9rc1grM1k5M3VVd3RONHlI?=
 =?utf-8?B?VHo4ZkgrdXd6NDh6cmFGZGV2TzZrb28vOWd6YmpLV2VqQkVJVld6Y0REWE1y?=
 =?utf-8?B?M0luQ01wT2FpaG1MTlNqaGpJZ1JnSUlEUDVhUVhSeFpqUXBENFpNVEJndkdQ?=
 =?utf-8?B?aTFPWXZTdkpjVTdlWWw1eFJmc0c1VmtwaitWa3FlSVFaQ0tkaVF5WGRLTExD?=
 =?utf-8?B?d3YyeUU2d1NhQ2hkVjBGVG54QURqcFNkdWR4VWc2RFpSck92UGlvRHRuR3k3?=
 =?utf-8?B?dDBCUHZOUFZVQ01rb1FMRjlpT2dDYytyR3IzSlpPY3c5OW1nTG1EUlcxNXEv?=
 =?utf-8?B?VDFoTVhLeit0V3JSanZxemdtaVBBYU1hRXJROFZ1QTdRSnVwdEtXQ01GOURM?=
 =?utf-8?B?Nk55QzVQSHJHWTVuQmZqMUcxWURpNXhjcnUyS214aDMrSXhZM1NTenNmRFhP?=
 =?utf-8?B?eHd6VzhYN0diZTNnSnZaUlNua2Vsa2RFUTA4dHQwdzN4YmNaM29JLzBKcUpG?=
 =?utf-8?B?dHBJMnEra3kvaU9STnBiNmJYYnRlQU01YnZDSVczSHlzZmhaR1BYTVQ0bERS?=
 =?utf-8?B?ek9HSjJwQXlsWWlzM2FEUU5hOEJzVVRaT1FiY3Y4anZ6MjFYMkE5ZG41MUk5?=
 =?utf-8?B?MlNiaDVMc1VuUGdUcTdpTVF1cEZrVW9UWGd4MHJLaVl2Q0dmaXVCc3FNMFJS?=
 =?utf-8?B?SHdVcVVCZERvUW9UbUlEQzBjRzNtRUd6elNVWEt4WW94Q3FTVk1wSVhFLzRv?=
 =?utf-8?B?V2VjZndRM2VYOEdzZTJsQ1gvT1VCQkNPaGsrWmVZSlhsSzBqV092MDIvR3Vi?=
 =?utf-8?B?a0dZQkZUL2NIY3phSW4vL2FpRWVwUzB5azIzTlVsQmphODFqd0dITzdnNEFx?=
 =?utf-8?B?QmRSTnR5REtMMDZYdVpDYkRHZWpnMGxjeE45Uzl5ZW1ZLzZkeC9hL1B2VWx0?=
 =?utf-8?B?WjJIYmZFL0FyWjJralpoV240bTM5N0Q3YlFiWktNaGZ5QjI3NHVURFQzbmx0?=
 =?utf-8?Q?5dAwnaC7Iyw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dPRHowc0psUzRxOGlrZlhmMCtLNUhDZmJrTU0ySnBQWExoMHZLc255SW1R?=
 =?utf-8?B?UlJCRmxlVjU1cmxYTXFQL25XVWcyYW1EVVNEcEhnMkdlZHpGa3YvVVQyeWdz?=
 =?utf-8?B?Unp3eDhLdmx0WVFyeXhKbEh6Rnd5SHplaFMrRVdBQ1VMUVZ3WU13aVVpbHZS?=
 =?utf-8?B?WlA1VTZBaEZtay90dEQvZTF1UWw4K2RiTVBJOXdRMUtETExPS2hYYWg4dU1K?=
 =?utf-8?B?dE9xRXRrK1FUU1pUMGc2NXp3UjdXQnpobGxvcWtadmtUMEMxVWI5NVZsbUh5?=
 =?utf-8?B?SWp3MzNYNTV2d3M1TmxHSUF2dVlFK1FyeVRIdFpXUnhveXBhVmptRW9jd3Vo?=
 =?utf-8?B?UDI5QjN0cWhkNkZRdjQwLzZtRTZsa1NyNzRuTytqMG05QWJ3c2JjNlhKQWJi?=
 =?utf-8?B?ZDF1NUVXZWp5WFhKYW8ycE9TM095cHI1Mlc5aFh0cENqV2RyNnJjZVdQNlgr?=
 =?utf-8?B?YlNhUEFaU3IwVDcycHF2N1Fpem5TaWRKaTZYSEUrNUVtZXhJa1B2QmhYVWh2?=
 =?utf-8?B?dEhWSnlOWE5YY05WMlIvTk9Pb0VuSGx0UlNKa0twOWpPRzdRRllkWUVWd2dk?=
 =?utf-8?B?a09IN1ZsS1IvYlVSVngwbGR6RkRjMkZVbGl5YjArRUNCVDU5d0prZGtjeldG?=
 =?utf-8?B?RkU5RW9qSXJEajQ1bVZQaGVackhldUxpQ1RaM0FuL3VEekRVd2JNcmRxcmVp?=
 =?utf-8?B?a2FrV2pTb1U4UUFaVWRlTjQwWUoyQUFzU0FtVjhMMElOV3ZKM2JzSFJuWnFN?=
 =?utf-8?B?NkVNK1RReU1PQkJWUEZZbWxjZzQ2MFgrczNxSGxHbDlGWnk1QXc4SFZGcDlv?=
 =?utf-8?B?T045cUNReFpkRU1NbThZSHJtaFE0YUhKZzN6VlAzOTR2SUZhRG05WkFHTDFW?=
 =?utf-8?B?MVI3SGlObVpNOXpXVnY4M0NZK2JQNVpZY2xlTGQybW4wbGNQaktvUllWUHRa?=
 =?utf-8?B?SG8wd3pDSVpGT0dyQmpDSmlsQmJHaG13TldjTlFIY3JwTFVjVENraGJUbjd6?=
 =?utf-8?B?RHJ3TkNHUWxMZC9Vb2ZkdUh0Z3BvREp4K3RHOHJhVGlPRnVXTTVidEV1YnEw?=
 =?utf-8?B?TEZoSmJRVTcrazFUUEpydzdJak1MN255dVNKS09lMUxtN2RRdythZFhCSXJZ?=
 =?utf-8?B?RDFQTFpFQkVsQ0p3TCtFM2N6YjNIM2xHZ1RCT0xWMzZyWnUrSmNpUGtoaXlj?=
 =?utf-8?B?Tmp3ZDBOQ1Z4TDFQYi81RGlYUER4cUQ2MS9pRDEzMkRSdXh5dTNiWVJWVEU0?=
 =?utf-8?B?U1dCZFdTY1J1RzBCSDJud29TZnJLR3pkTmZZOHRXMHEwNUhpY2h4RXl4MjRr?=
 =?utf-8?B?UTBCa3FVNkJYUGQ4N0lRTDFaNGo0Y2g0SFZKcCtiVlZ4VVEzV3QrT2s0cHhK?=
 =?utf-8?B?cmwxQmdXMjdmaGdZakVlNmdNbElhT1haRjFBWmhLY2dPZ29RQTlzWGc5a0Ux?=
 =?utf-8?B?N0lVSTR3bStzNVVZZHZETzlaekJIWWdOL2FVWlJ5TXNtVTNYTEliVDJRcUVn?=
 =?utf-8?B?Q1BUOWRrRTVmMGdrUjVHelhCWE1aZ2ltdW1JQm5xUjlLTkhra01CSFd5bzli?=
 =?utf-8?B?V3RvY2w3amh2TCtwTkJ0ZzMzUWs5bGR0R1hhQkUvSnlwWXd3OXJOeUJVYmJ2?=
 =?utf-8?B?ckpTSTdpL0xvWVRzcjJvWERvVFhHejl4RjcyVkJkQzJDdUFCNUNiNlRvamFQ?=
 =?utf-8?B?UlFHUjVIZUJ0S2FNTExVMHJCNzRmci9kYVU2TkEvK0FIdU15d3hQTzlnNjJK?=
 =?utf-8?B?TElDTWRGMVZjZEJtRlRaV0FEMklaNCtPTjlEV0w1bXRpM2dFT2xad0EySzda?=
 =?utf-8?B?MXVraGUzemhmbVM3WXdwN1E5RC9UQ09yaXBBS0U5M2tXMzVKc1k5NGZaSTVI?=
 =?utf-8?B?ZEhDTGwwOVhEeFFvc3E0bTU0aUdLWUhReE1MSXlZTXRlclplZmVDYUdTeExp?=
 =?utf-8?B?dGtqOVVwbWhxbFlzQzhyWUpabDdqUWFLNjlMZ0pjbC9Jb2lhUjhVY0srd2dC?=
 =?utf-8?B?TVBFYTZyajZDaUhxN0lBclB0cVJGTk1YMkI4YzR0c3BwRmM1TkVoWWpIbnVU?=
 =?utf-8?B?dzVvNmNDcVBmQ05KbUFzMW8vem83SGFiaHpvUWpsLzZML3BQWFROLzBGVU1C?=
 =?utf-8?B?K2QwcWFpSmRjbTdONHJxeHc5NmMzdWV0OE5HRkdYcHZGR0o0STNiTmJPang5?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38f9ca-6b33-4f70-d8d3-08ddc5afc14b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:01:21.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7kzc6Ev/yQgenWwagaGN4Qc7+PNUbj5cLG/JD7w4irmD9z3WSTvC/CLlN9fhazW2+ebW3mFyZeQGmQEFL37S32FNGbhieJVm4wGM796qYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Enable the mbm_l3_assignments resctrl file to be used to modify counter
> assignments of CTRL_MON and MON groups when the "mbm_event" counter
> assignment mode is enabled.
> 
> The assignment modifications are done in the following format:
> <Event>:<Domain id>=<Assignment state>
> 
> Event: A valid MBM event in the
>        /sys/fs/resctrl/info/L3_MON/event_configs directory.
> 
> Domain ID: A valid domain ID. When writing, '*' applies the changes
> 	   to all domains.
> 
> Assignment states:
> 
>     _ : Unassign the counter.

"the counter" -> "a counter" (user cannot control which counter is assigned)

> 
>     e : Assign the counter exclusively.

"the counter" -> "a counter"

> 
> Examples:
> 
> $ cd /sys/fs/resctrl
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=e;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> domain 0:
> 
> $ echo "mbm_total_bytes:0=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=e
>   mbm_local_bytes:0=e;1=e
> 
> To unassign the counter associated with the mbm_total_bytes event on
> all the domains:
> 
> $ echo "mbm_total_bytes:*=_" > mbm_L3_assignments
> $ cat /sys/fs/resctrl/mbm_L3_assignments
>   mbm_total_bytes:0=_;1=_
>   mbm_local_bytes:0=e;1=e
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  Documentation/filesystems/resctrl.rst | 146 +++++++++++++++++++++++++-
>  fs/resctrl/internal.h                 |   2 +
>  fs/resctrl/monitor.c                  |  18 ++++
>  fs/resctrl/rdtgroup.c                 | 123 +++++++++++++++++++++-
>  4 files changed, 287 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index 4dd1d605d6ad..2b2acb55d8b1 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -527,7 +527,8 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>  	Event: A valid MBM event in the
>  	       /sys/fs/resctrl/info/L3_MON/event_configs directory.
>  
> -	Domain ID: A valid domain ID.
> +	Domain ID: A valid domain ID. When writing, '*' applies the changes
> +		   to all the domains.
>  
>  	Assignment states:
>  
> @@ -544,6 +545,34 @@ When the "mba_MBps" mount option is used all CTRL_MON groups will also contain:
>  	   mbm_total_bytes:0=e;1=e
>  	   mbm_local_bytes:0=e;1=e
>  
> +	Assignments can be modified by writing to the interface.
> +
> +	Example:
> +	To unassign the counter associated with the mbm_total_bytes event on domain 0:
> +	::
> +
> +	 # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=_;1=e
> +	   mbm_local_bytes:0=e;1=e
> +
> +	To unassign the counter associated with the mbm_total_bytes event on all the domains:
> +	::
> +
> +	 # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=_;1=_
> +	   mbm_local_bytes:0=e;1=e
> +
> +	To assign the counter associated with the mbm_total_bytes event on all domains in

"the counter" -> "a counter" (motivation: user space cannot control which counter is assigned)

> +	exclusive mode:
> +	::
> +
> +	 # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
> +	 # cat /sys/fs/resctrl/mbm_L3_assignments
> +	   mbm_total_bytes:0=e;1=e
> +	   mbm_local_bytes:0=e;1=e
> +
>  Resource allocation rules
>  -------------------------
>  
> @@ -1579,6 +1608,121 @@ View the llc occupancy snapshot::
>    # cat /sys/fs/resctrl/p1/mon_data/mon_L3_00/llc_occupancy
>    11234000
>  
> +
> +Examples on working with mbm_assign_mode
> +========================================
> +
> +a. Check if MBM counter assignment mode is supported.
> +::
> +
> +  #mount -t resctrl resctrl /sys/fs/resctrl/

"#mount" -> "# mount" (please build htmldocs to confirm everything
looks consistent)

> +
> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  [mbm_event]
> +  default
> +
> +The "mbm_event" mode is detected and enabled.
> +
> +b. Check how many assignable counters are supported.
> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/num_mbm_cntrs
> +  0=32;1=32
> +
> +c. Check how many assignable counters are available for assignment in each domain.
> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/available_mbm_cntrs
> +  0=30;1=30
> +
> +d. To list the default group's assign states:

Please note that these steps are inconsistent. Some end with "." and some end with ":"

> +::
> +
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=e;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +e.  To unassign the counter associated with the mbm_total_bytes event on domain 0:
> +::
> +
> +  # echo "mbm_total_bytes:0=_" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=_;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +f. To unassign the counter associated with the mbm_total_bytes event on all domains:
> +::
> +
> +  # echo "mbm_total_bytes:*=_" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignment
> +  mbm_total_bytes:0=_;1=_
> +  mbm_local_bytes:0=e;1=e
> +
> +g. To assign a counter associated with the mbm_total_bytes event on all domains in

ah ... here "a counter" is used.

> +exclusive mode:
> +::
> +
> +  # echo "mbm_total_bytes:*=e" > /sys/fs/resctrl/mbm_L3_assignments
> +  # cat /sys/fs/resctrl/mbm_L3_assignments
> +  mbm_total_bytes:0=e;1=e
> +  mbm_local_bytes:0=e;1=e
> +
> +h. Read the events mbm_total_bytes and mbm_local_bytes of the default group. There is
> +no change in reading the events with the assignment.  If the event is unassigned when
> +reading, then the read will come back as "Unassigned".

Since returning "Unassigned" can be complicated, the associated description should
probably just be done once in the doc. I expect this will be in the "mon_data" section.

> +::
> +
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> +  779247936
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  765207488
> +
> +i. Check the default event configurations.

Drop "default" (there are only these event configurations)

> +::
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
> +  local_reads,remote_reads,local_non_temporal_writes,remote_non_temporal_writes,
> +  local_reads_slow_memory,remote_reads_slow_memory,dirty_victim_writes_all
> +
> +  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
> +  local_reads,local_non_temporal_writes,local_reads_slow_memory
> +
> +j. Change the event configuration for mbm_local_bytes.
> +::
> +
> +  # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
> +  /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter

"counter_configs" -> "event_configs" (this was also an issue in previous series, please
use grep to ensure all are fixed)

> +
> +  # cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter

"counter_configs" -> "event_configs"

> +  local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
> +
> +This will update all (across all domains of all monitor groups) counter assignments
> +associated with the mbm_local_bytes event.
> +
> +k. Now read the local event again. The first read may come back with "Unavailable"
> +status. The subsequent read of mbm_local_bytes will display the current value.
> +::
> +
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  Unavailable
> +  # cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> +  314101
> +
> +l. Users have the option to go back to 'default' mbm_assign_mode if required. This can be
> +done using the following command. Note that switching the mbm_assign_mode may reset all
> +the MBM counters (and thus all MBM events) of all the resctrl groups.
> +::
> +
> +  # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> +  mbm_event
> +  [default]
> +
> +m. Unmount the resctrl

"Unmount the resctrl" -> "Unmount resctrl" or "Unmount the resctrl filesystem"?

> +::
> +
> +  #umount /sys/fs/resctrl/

"#umount" -> "# umount"

> +
>  Intel RDT Errata
>  ================
>  
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index b42890fd937a..9881674909f2 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h
> @@ -403,6 +403,8 @@ bool closid_allocated(unsigned int closid);
>  
>  int resctrl_find_cleanest_closid(void);
>  
> +struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name);
> +
>  int rdtgroup_assign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
>  			       struct mon_evt *mevt);
>  void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index e30a867c00bb..61419849b257 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1220,3 +1220,21 @@ void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
>  			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
>  	}
>  }
> +
> +/*
> + * mbm_get_mon_event_by_name() - Return the mon_evt entry for the matching
> + * event name.
> + */
> +struct mon_evt *mbm_get_mon_event_by_name(struct rdt_resource *r, char *name)
> +{
> +	struct mon_evt *mevt;
> +
> +	for_each_mon_event(mevt) {
> +		if (mevt->rid == r->rid && mevt->enabled &&
> +		    resctrl_is_mbm_event(mevt->evtid) &&
> +		    !strcmp(mevt->name, name))
> +			return mevt;
> +	}
> +
> +	return NULL;
> +}
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index dc108c5db298..b26baca389bb 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -2071,6 +2071,126 @@ static int mbm_L3_assignments_show(struct kernfs_open_file *of, struct seq_file
>  	return ret;
>  }
>  
> +static int rdtgroup_modify_assign_state(char *assign, struct rdt_mon_domain *d,

Please move to monitor.c

> +					struct rdtgroup *rdtgrp, struct mon_evt *mevt)
> +{
> +	int ret = 0;
> +
> +	if (!assign || strlen(assign) != 1)
> +		return -EINVAL;
> +
> +	switch (*assign) {
> +	case 'e':
> +		ret = rdtgroup_assign_cntr_event(d, rdtgrp, mevt);

This patch enables the user to assign counters to multiple events in a
single write. Looking at this flow:
rdtgroup_assign_cntr_event()->rdtgroup_alloc_config_cntr() may thus
be called on the same domain but for different events in a single write from
user space.
I thus think that the error message in rdtgroup_alloc_config_cntr()
should not just contain the domain ID, but also the event *name*
(not the ID since user space cannot be expect to understand if).
considering this it seems that @mevt can be passed through
to rdtgroup_alloc_config_cntr() instead of just the event ID to support
this?

> +		break;
> +	case '_':
> +		rdtgroup_unassign_cntr_event(d, rdtgrp, mevt);
> +		break;
> +	default:
> +		ret = -EINVAL;

Please add a "break".

> +	}
> +
> +	return ret;
> +}
> +
> +static int resctrl_process_assign(struct rdt_resource *r, struct rdtgroup *rdtgrp,

Please move to monitor.c and rename to be more specific. For example, 
resctrl_parse_mbm_assignment()? Open to ideas.

> +				  char *event, char *tok)
> +{
> +	struct rdt_mon_domain *d;
> +	unsigned long dom_id = 0;
> +	char *dom_str, *id_str;
> +	struct mon_evt *mevt;
> +	int ret;
> +
> +	mevt = mbm_get_mon_event_by_name(r, event);
> +	if (!mevt) {
> +		rdt_last_cmd_printf("Invalid event %s\n", event);
> +		return  -ENOENT;
> +	}
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +
> +	id_str = strsep(&dom_str, "=");
> +
> +	/* Check for domain id '*' which means all domains */
> +	if (id_str && *id_str == '*') {
> +		ret = rdtgroup_modify_assign_state(dom_str, NULL, rdtgrp, mevt);
> +		if (ret)
> +			rdt_last_cmd_printf("Assign operation '%s:*=%s' failed\n",
> +					    event, dom_str);
> +		return ret;
> +	} else if (!id_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Verify if the dom_id is valid */
> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
> +		if (d->hdr.id == dom_id) {
> +			ret = rdtgroup_modify_assign_state(dom_str, d, rdtgrp, mevt);
> +			if (ret) {
> +				rdt_last_cmd_printf("Assign operation '%s:%ld=%s' failed\n",
> +						    event, dom_id, dom_str);
> +				return ret;
> +			}
> +			goto next;
> +		}
> +	}
> +
> +	rdt_last_cmd_printf("Invalid domain id %ld\n", dom_id);
> +	return -EINVAL;
> +}
> +
Reinette

