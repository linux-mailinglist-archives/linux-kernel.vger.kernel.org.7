Return-Path: <linux-kernel+bounces-751269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3469B1671B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020C64E23E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D01F78E6;
	Wed, 30 Jul 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dy3cahXQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870CA1E5711;
	Wed, 30 Jul 2025 19:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905053; cv=fail; b=Wtqcconi2Lts1rQP5mZFO3RM6Gd1izYPmFCIB/dBHeap82UTrdZDskeREUlxOzysxH8/J8a9ysN+lR9WnUZvGmU4RVegb8oVLg7Lzp3nY5Bpex4AgwDSC82RQkAJHymL7KarbKkaCKlFgt4Rs6eVpkLkLMBzmwRCc9+Ku40Jvwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905053; c=relaxed/simple;
	bh=HxW4hKmDMNHr3r97PCiMtiftgKvPRb+nr7abuhgCm24=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gYRb9qnEZFR8QE1PdnSwpvmMDzBriuLS4uhMJclZi6wUPx+cami/cqKWjkDIBiNG+xkvvz8dNveAfM1X2gG9yDFqzw3Wa5EAilp0Ik4yfBF/uZ1+BfeduTxP7eW+yp3ATB5vi4LRXAY21ygmGJKCDz0OinFZVnZ1/5wX23KpXR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dy3cahXQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905051; x=1785441051;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HxW4hKmDMNHr3r97PCiMtiftgKvPRb+nr7abuhgCm24=;
  b=Dy3cahXQV+gplWqRT2oIf9Hx1vim8vrr6gUtfB90q9DI7ZAfXR4O5iLi
   eVTVYIgzPyiHMXXAysiaGAqlewNiRh/+ZcLBnrdyu2yM65VEppXd+1K/K
   KnesHLprjr0bi/JwlP/kHlzp/2D3KJ5jqLhXmVhCqiVtmCFsbtaF0tCsv
   tMwe/e8S39j6N4ATv7A3U5ijJVxfkW490tNpEdPkxJ9QQkTzJ0PuQPB+4
   jWpM4nYx9qfksGVY7E7ls4V76BUGPqu67gs+QefVXB5uTgm8Bb+54nA0Q
   4gWj0bCCKovvds34RClEXW1nw2Emc/WjXfDvrY5Sx6Hxfjx3jVSjoOnbd
   w==;
X-CSE-ConnectionGUID: CWjnI7IrQlae4Zj2owd4Fg==
X-CSE-MsgGUID: L18cRaXASrum+TQg9YGlRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56150550"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56150550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:50:50 -0700
X-CSE-ConnectionGUID: s9e8aaMLRbSFdP0sOvbfSw==
X-CSE-MsgGUID: f9SKrmhUQ32xKxj+Ae3eNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162335591"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 12:50:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:50:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 12:50:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 12:50:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2GrLXwNgFG5e8OA1WfYw3brvydChqEtrkRtS1aGWYEqykY5e2zSv3YYHmP19uGI6R6by4T9a4ogiXpWltLCFL7jCUHBxMwHUSwj5Cpu7adWt/Sv9IiBo+b90mDi6rFdfppGbrICgJlGm6osQhHJadGbySXACHheX3ta9eRwwvKpCOE0WgInHZH6HRIjd/2LjS+5NVeaaMTZ+GkcyB1CALuejWsywhPujo2P3Fv1RJUEPLurcoeSoIexMr2VoGn5Bv16TNt1euuCU1CfkIKtJqCyHeoz124RVx0x5q5eEoyMMrZ/5Yple36TdOqY7JIjHW9ifEKpnylOlua2XQwsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKrykmzwqJy0Zd1VnKnwQONjA5eUgAey3vaEMNAQNu8=;
 b=uW3AoEaZSpQVyBvsOnwlKvqxdE2VHQLzLr++DVdhA5kIKw0kM4NJpSJ3oabm8+4BfORQFzamvzl5gBhb+rDHPZdVQGFSyhY3OmHYHE0aC1CGBZyl9uNhO6YJxwQLQ9z6cQlLrv/vKw6fwqtPEzKl+jgkMK0GVLKI3mMiaj7ecdvC7aPu4sIHfg/3lAxurdQ74MAzCUboECl3uFoo8Ay7OYX/ZU64LamHgoMrju7wzdC4vCnRt2tXgb7Ar8TC/UmV8hlfBLt/8y7VdT3xHPEkEuXvMGnYjA0fM5AcwQS0d6EZoKQJ3sUwL3/GelqfxdHM6WOVBJ4UQbHkNQpI7fhkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB6422.namprd11.prod.outlook.com (2603:10b6:8:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:50:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 19:50:31 +0000
Message-ID: <642ff1fc-3a79-4aff-b226-599d1a089516@intel.com>
Date: Wed, 30 Jul 2025 12:50:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 16/34] x86,fs/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
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
 <5ce91d983fdb22648e13727866b0b5ebe1428b32.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <5ce91d983fdb22648e13727866b0b5ebe1428b32.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:303:b6::9) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beadf04-a17e-4a62-b17e-08ddcfa25770
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VERFUzRoc3lqb2NjWlBUQ1NoZlV5a2dNaEFVMXpIUnZZLytRSy9UUnZFb1VY?=
 =?utf-8?B?T2lwV0w2NVJ3b2FDQ1dDOVA1a2lhN0VkOG1GQi9qMVVrVERBcU0xc3hWU2Vp?=
 =?utf-8?B?QUtDdHkzTFQ4MHQ2Q3RWcSs2bXk5SERCSFNOdHJ2VzQzZFduNEY0ZTk4RHc4?=
 =?utf-8?B?MlNTWjAwdXNuTk1GZ2FFWVdPTmttbHlTeWM5WGJwTXo2M0pVUGRuY3o0UTFm?=
 =?utf-8?B?dnY1bmEzMUk2Qy9FbnlhTEFrTzVRSUtiQ1ZVWUdnSWx5aXJqVzBaVGpJZjkx?=
 =?utf-8?B?NXhub053VzZnQzIxNFF4RlROajVGWDZhem5tMWp1UXVJWUI3S1dVVmxmd1RQ?=
 =?utf-8?B?YVJBZjJoTTZJaERCZGVCUjVJVlNqZWFrdW5tN2N2Sm8yQzhPTS9rRi9ORDlO?=
 =?utf-8?B?OU4yaTdZUnVncUVjczhNRlRDcU9DOFY1Q3VaczBZRHhlaVFDVytlbnFmSU5v?=
 =?utf-8?B?ZExtenRHbDR2U1YrS2JWTW0wbXVsb3dCRE92WE4wMmtCb2RJVFNpL3p3ZU1u?=
 =?utf-8?B?cWE2VFc5WG1xZXRDS2tnc3ZFQ3h6RHRHQU4wdUU2WjduVE5rMmFjWnpsZGFl?=
 =?utf-8?B?WlBVSXNuTG9yRHhQa0tjWUtFSFFsOWNsUnhhcEVXYUVwNFltamovUGF2RjdY?=
 =?utf-8?B?YkY3TzhvY1RwZktZUU1UVUlScjIrRUlxMlBVdnV4Mzd4aWxtQkk1QmpTNTFY?=
 =?utf-8?B?dlJ0YUZkV3pjWlZuYlhHTFRhK1BRMGlSZmg1MytzeWxhS1BSN0JyMGdVWFls?=
 =?utf-8?B?UXN6Y0R1aUFTVG02WmV5NEJjTnNJdlJpaTRUSmpFRWVUUi9YSXkvKzhZMnlu?=
 =?utf-8?B?emE4Nm9LZkFWbkpoZXB3SWkwOHJ4ajF2ZGNiSkpoencxQ0dydkpueGg2UEVx?=
 =?utf-8?B?cjl4NHJWcHhLaHNDOGkzbFFJK2dHZ0FVc1RydTVscm9GV2pVekRuWHJhSjBV?=
 =?utf-8?B?ZVpHY0Z3cGN0NkdGbzY0ZmwxNE4wWlJiTzkzV2xLMVkvY1YyZHNYMHJXRnE0?=
 =?utf-8?B?WjJMTThIRldRaXM3WjJQMkVjdXV5dFdOelNlaFgwdDVsOUZzeUYvYzlHWkRS?=
 =?utf-8?B?SWtzakhYdnZPbDgzR29ZamxaOS9jZXlrdjR5TWpCVDRkSDRzVHByN3NwcklJ?=
 =?utf-8?B?RjdFaGFCUHNTVHlkWGhTTGl2UnRTSEcwOWZubFhSU2ljQXNTUGpxSEV0Y0Uy?=
 =?utf-8?B?T29DenA2d2g5RnpLZG9yb20zS2wrMHhFaDZZVll3MVlya093VDQzTTJnWVZt?=
 =?utf-8?B?VnlnMFQ4cU1qUk9uYVdvbVBUSWxxWllDeWFQN0xzTjNRNFpjQXE1eS92bmNS?=
 =?utf-8?B?SW8vL1BPa082Wkp5cUhnemFLYUZlR2NITmpxMDQvOWtuS2FwNkk1NkorcU5Y?=
 =?utf-8?B?NGxiVjhqZFgvc2x1Mko2RmcveEprZEo2QXdOV0dlSXJxVjdDV3F1WXRhWWtH?=
 =?utf-8?B?endGdUVhUXEyakhBaEQ1d1kwR1RXc1d0Q0F2UVNvUEx6dUlveFgxYmdaTTMv?=
 =?utf-8?B?YUR1VitBenNsbkRTYjAyZ0hrcEZJbjQzME5RdkdJRnZsVys2SmJHd1d2TWhO?=
 =?utf-8?B?S2YvenJXMW4vSklxUG93eDczSEVFTHV5a1V3R0FuTU5hOFhkVEdKTU9aaHE2?=
 =?utf-8?B?dkRIVm4xK2Fzek13ZU1ocVEvL1pIdUhBTUlTdmJiMXFYVmd1eG9XT2p5K2RJ?=
 =?utf-8?B?bEtaaFdsRWhOMDJTZHJ4VXpwMkZIcDJqaVNYdHVLNFBidWJGanBMRHBJUUdr?=
 =?utf-8?B?MkJoWjVQcEtOYzVrcGMzcnpSaVdRWi9pNnRjSWZxQjdVRFNHcDU3c0pJYWtR?=
 =?utf-8?B?cjhUc3hvbm5yd1E4SjRmOVNPN1RpYkxIdnlOUFhiaHNvcElIdlFOQi9FVUpZ?=
 =?utf-8?B?cWE4NmFXZ2dMVkdKWFFqcnQ4K0htL2U5U0QyM21mSVRHZjFQb1RUZmJFSjRI?=
 =?utf-8?Q?lx1/aCJ4jcE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnV6YzJ4UG4yWmJzZVZMaVNTb0NYd0lucU10UHhLeFhveTRCRWprZUV6ZTNM?=
 =?utf-8?B?bEhuSkhkZjZjeHM0ekE2VlJhTno1di9VMHdPV0RVU1lmMWxSaFVZR3ArRWt6?=
 =?utf-8?B?dlBraVVLRE0zb0lYeFB2N2RNUHk5Q1I1WklxVHVscEFFWkVJZ0FQUVpRbE96?=
 =?utf-8?B?eXN6WmdQZitzdVpncTVoMFE0a3UzUFRlMFR0UUI1MDljak5mOTVFalJRa1N6?=
 =?utf-8?B?QnYwZUlOMVNKVmIvMXNRMElEMnNBMWRCVFJxWlQ2RklMbmV0VlFTWVQ2b2px?=
 =?utf-8?B?cUdCMmo1VU1zdytSbG1FR3BrbVZnbGd1T2N1Y1hJM1RCSFhDYmRwZDl5MnNI?=
 =?utf-8?B?NmJjR3dVcUM0TWV5Z0g4NFZQeHE1Y0VMNTI1RkhNSXk5MVBvN2tncnhPTnBO?=
 =?utf-8?B?NWo5NXozV3Bzb3JjbEhJdHU3M3h2Z2luWWVXRGF3dWx5M3dpWUErcEwzemZN?=
 =?utf-8?B?TlQ0Z1JlN3U2TUc4L01iZWdQOXYxUlVmYmg0ZkNhOTdydWQxcjFQTENtRC80?=
 =?utf-8?B?anRpeTY1RGhlVjJEVzNpSUxlanBWVG5UOTJDMk4veDR2bWdxalQ1WG1NZERp?=
 =?utf-8?B?V08zNEttVHgra0RiajZWOFVYaXkyR05JOXZ6UUV5YTArTi9ZRWNWYWQ3V29O?=
 =?utf-8?B?T0U4QjhBV3dLRTdUbUE5Y0dTSmJNNUFEdnZYb2duMzRZaE1pcHN2Ly9tT2xx?=
 =?utf-8?B?eDU0QTA5aFZqTHRQS1gwbWFUTWlpSENoWWhCVHBPUFlZRWRXUjcveU1lc04r?=
 =?utf-8?B?bkRRdWE0aEp5WHNjTmEvamROWHdkdTZ6UHA0ZEtWUHZHZjNxVVlVT3dWRUZn?=
 =?utf-8?B?YVdmaG0xREJKeHoyeE8wQ29LRFd3bzMyMDZKMkU4cVlBbk1rdWpBdHpVVGZs?=
 =?utf-8?B?Ym9TZGsyRmNtbDczVHMxeWJQcS9wMzBUOXNqMm94Y3pEVCtwdjEvMXErbFV2?=
 =?utf-8?B?dUR0SGJySG9YTDJYVGJYd0xTeEVxZFJMWWdCSU42aWpucyt6VERnVm5UOUJE?=
 =?utf-8?B?cU10WnMzdVBwUnZvOFVoRm11cStXR1dDSnBLaFJTV29EWGhDMEZLbWt3Sjky?=
 =?utf-8?B?cU5WaVFBd1FESHdvdGhHeHRhSHBwTXVkSUVFZmtUYythZ1BGbzUrVDFlOWhi?=
 =?utf-8?B?L2VCcnBmdS9TWHRWSlVMUlBTaEo3SzA5bjhvNzN3bVBSMWlhaXpMSWJua3Bv?=
 =?utf-8?B?cnRtV0E2TkhRdEFJS3JreW1EZEhWUEpzY2N1d2hOUkZCRFZqR2UwZW5BZjJl?=
 =?utf-8?B?RjV2d0lHejhHRnpiYy8zaDE3N0pCVU9hL0c1c25CcFZBb2gvbkNZMTk4TTA2?=
 =?utf-8?B?MXozNU92aG1hZytqWERHWEdEWHZpU0tyMVBWV2dhcDJUWUR6QU8xQ1pLc0lJ?=
 =?utf-8?B?UHN6ekhzM2NCaFc1QVhic2twQXBTOG1XQitrcGJsSS9rSnNDWUhDTEZDK3Fn?=
 =?utf-8?B?YTdLdlRmVlEzcVBMbFZOQTg1dk43bEkxR09SbGxleDBqZ29qREVqUGd6WlJO?=
 =?utf-8?B?QlpNTjVqZml1Z2tXNVhhVTNXZXlmdzRadHpiaG9hUmQ4UjZhVytFUmZoRzVm?=
 =?utf-8?B?RUN6d2RCSkZBcmdBRUhFWnlmb0pWOExmSUJOZ2cvUHhKOFdOdlVpUndLVXJx?=
 =?utf-8?B?cU5sc2FhQXZpd1NjSzF4RnlHVndob0IxM1FtUUxDcTJtaFlZOWY3SlllODBq?=
 =?utf-8?B?NVJ4cVJRTUo0eXZSV3RWRHAydU1Hdm5PUmtKeUtnalV0Q05Zd21HN0VXS0o2?=
 =?utf-8?B?RE0xaldRMG5Ub3dmUmhMT3llOTFjWUI2alBtbTd4Z0lid3pyZ09wWGJNY3I2?=
 =?utf-8?B?SS9EQmx2aUhWKzJqT2M2VE9DL2ZtZ3BLbkNYc0JIUFdEeE0yaUZrNDNuRkxB?=
 =?utf-8?B?R0RxcTR2SFR3aVliY3VGa1p2NGU3WDdxbU9pb2pOcVJDSDlOQkRwOUVOMFFJ?=
 =?utf-8?B?ZXVjK3cwbW5LMXdRcWwxMDdHbEw4WTlJNWtnUEgrdW1KVEtpZVZVQ3Q2aEc4?=
 =?utf-8?B?ZEsrK0FhelY2ak9JSmpyeHJjYWZaaGlnNjErNDRGWDNMVVlLZ01wMDJUcmJ6?=
 =?utf-8?B?ZXNoWnBCWVNGa3I3ZW1VM0VoZ0FJWlBqL3dnWTgvNjd1Z0ZrS1FHYUp2cHdQ?=
 =?utf-8?B?YSt6Nm02NG9vM2NWb3JzMXZlV0xLK0lKclVsNFZpRmp6MGRGNzFuVUdTWUVy?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beadf04-a17e-4a62-b17e-08ddcfa25770
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:50:31.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYOYkr1mYh6BLo50zYzzO72ONUGrDzsllghhRIXI0dKH81ub9jXQaxjot3cM9CLDhQ7sAi+xc02CNpYh+7Yaphoml9EHb7HiJq/47fSpPqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6422
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user.
> 
> Implement an x86 architecture-specific handler to configure a counter. This
> architecture specific handler is called by resctrl fs when a counter is
> assigned or unassigned as well as when an already assigned counter's
> configuration should be updated. Configure counters by writing to the
> L3_QOS_ABMC_CFG MSR, specifying the counter ID, bandwidth source (RMID),
> and event configuration.
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>     Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


