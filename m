Return-Path: <linux-kernel+bounces-735846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B9B09465
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AF9A64C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038BF302048;
	Thu, 17 Jul 2025 18:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrEsyGRE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F820B215;
	Thu, 17 Jul 2025 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778048; cv=fail; b=Rv0sh5hPZsJzGvbsYVrVMhMF9iLT3prqGLRYvovorhryHrHvPCOoAPYQD9RDPWDeGUktLKxZyUK647hI7Mo24rBxFMjPllpsDz4rhGhM2crRC3uTqd32G5pcPp9ZHURKnLZeDt2ZaeKfR6CQ1G6XhcIihwh7Wft9wp5PA34esio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778048; c=relaxed/simple;
	bh=S60zfDGwH20OAD79GlBAR2sylAzCDk3jGsDmWakcuFI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUxwI+pATPCgqwjSVOe6ZZOuacjCuBMmbIqewh8S0c8tTyOC8+xWyA+wn7KAJ6E2B6X3xpKEwNkKZePDybzd7/oznE0L/UoPxBbA1vIBvYoiGvUnG+oTJu998G1l94021pulfdinJHBZFgczbYQm3U3aqHsgx/aX59tsjmZqmRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrEsyGRE; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778047; x=1784314047;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S60zfDGwH20OAD79GlBAR2sylAzCDk3jGsDmWakcuFI=;
  b=JrEsyGRE5pZMyt6vaa0NKT+d/OVMXj29XY+ALADZbwC/jjtp3k3AHavp
   8QtIGCG1ZLAAi950rnDRkuFt1NGiob6zleZLxrrpGO/SaMHAQhkHFvQfn
   wVMpaPMImoYQoRPwg/3cnavz7L1c6PMuBaDMHaFq07QDCmbfe7mI8nAOn
   LJMr4P3LhyQ+wxcNXXqgePZhjixVVB9u6NM7TsxC3Q0Nb8mW6LUmMh/Ke
   j0DS7ZjgCm/aQDTpUw9+3djtyScwZJZErHmfjOkFF4WG2n+9YTfqOku7p
   QEAVAPWB98BVlrQLz44r93aV/Uw8uCg3puLMpfmbGM5Pzgg0lZc2I4ofG
   w==;
X-CSE-ConnectionGUID: X+VRqQEoTEusvM9m5qijjQ==
X-CSE-MsgGUID: h2ge0VgSScWRndQHfrUGow==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54926040"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54926040"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:27 -0700
X-CSE-ConnectionGUID: N+25nNiDQo6BD9k2PeID8Q==
X-CSE-MsgGUID: hR63q/i0TJq7KzOzg83UnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157257817"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.43)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVGiOCN3WjIknOsXovbvDh/AB3UGu2U74sFZ14flhpxua7c+nPqHlHn2SOpyeXHkzR5gWYX4D/IWeYVX7HYqQ4ilKAWKyqEQYWc8cx6yBqez+seuxxsO6Nqzn+CX8eXXLsSJXxttFHctKs0ulMC6NAq0caP2xHa5q3QmITyB31TdDV1BSRj2dhzRghjth7Vgxfgs//KgAvjV8KpdGhUwv4rRpX5B10Jlas7v75BBRR56CCAQki806za3uqHCZDBx7KzUJ9S/laSkXGaFq1hDV/cheTPqqQNx0QLPyuitEklSd2Mfvr6YwZqpuuJD5w55X+3U7L7dshmJkY/uumcoYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXQvCxCnhgdSoN2y00is3LwgA8FcsnYhyGYF2oXRM/0=;
 b=j8QKT3Skjn9OHrL9/AirQgjbvZAenjqDCXLuDFIs4uhebC1vMHAcj1yqE4fRHQPDcUeLaFB2VeU3sJajKkT1tXqKHsRTgOm/Q+PY6d9TMWDYGKsgsyjm9SZseHBgDWvAnooRcPpyD5BkIPc2+HqgvBtg49c/C0/QvD4KAPOJ0D6WvJE+odZFRedpOV4/Wy31EoRDnZP792QdweSvq1L9ytO40hhPWL95D5KpWp+UJryT8dqP1aJvVJ5d0qO16nnW4P0fhtapjt32fGwTiJPP2nyEeMDrPAmpeZlhkrnS+X/6//V98OMit2M69ofjXmfe2ooKa+tR3H5mDkZUMueW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:47:22 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:47:22 +0000
Message-ID: <78ad760b-7130-4f14-b0cb-a38645c13d6e@intel.com>
Date: Thu, 17 Jul 2025 11:47:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 14/34] x86/resctrl: Add data structures and
 definitions for ABMC assignment
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
 <994417126eae21f7ceb7994a875b9ec9bc553784.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <994417126eae21f7ceb7994a875b9ec9bc553784.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f37360-5eea-45c2-0cd8-08ddc5625d38
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUFlbTBMZU9vYnYrcmFGMHlSSWs2bWZSWU5LeC8rLy84R2hwVmdFN05MRXBv?=
 =?utf-8?B?TUJPTVhXWXBhQ090VjdFaW93U281NU5Vc0d6YjN0ZzdpNHdrZDF3MVR5OU1B?=
 =?utf-8?B?aHdTYUdyTzI2b2FibmZ5WkJCbllXRU1WSnlYWjM2Tll3WGthaG5TMm9yNklU?=
 =?utf-8?B?eW11dDlOdURieXd1UWtrQjkrUmxOTWtGNnNNWi9Ld2g3NG1pRSs3MHFyL1Iv?=
 =?utf-8?B?eW5aUUtPOUh2L0ZWMUhaRzJ1Nk5uRW82QWRGRGtQMk5zODlrOEI2Mys0UGNF?=
 =?utf-8?B?VTQ0YmI3U2hQZFpBRXF3bm9DbVRoQ01Yc3kyTWg1TSs2RUEzVlUvbWlOeTE5?=
 =?utf-8?B?MHRRWCs3Mzh2TDFZd1EzMHVKOUxOM2t2bncxakpWbjlTSUp6dWlLTVFKYTBs?=
 =?utf-8?B?Vng2OFJtNTBiUFZrRGhjczFvNXIzeDVJcU05YjZNMnFMWlJaMXBvdGVPSmNI?=
 =?utf-8?B?OUNzT0pueXpFUzJBNFZpQVhNd0tVSFZBcGtmUmMwZFdIMllpOWZZcFBIMGx3?=
 =?utf-8?B?TXJjNVdUb0Z4ZW5yZEhGSFJxQW5nYUxYNHYrTHJzTVQ4NXdEdmRZQmJyRUNw?=
 =?utf-8?B?a1lpN2NFSFEyK0hoUjRVM1NsRGx0NFI5OGpSSlVCZlRKcXdjTlY1czB0SGZJ?=
 =?utf-8?B?UGNORFRCWFAzOFdFYUpZU1lGbjhuR0Uvd1c1NUkyS3k3VSthOVRjbkFmenBa?=
 =?utf-8?B?aFMzc0tiMlFUQnhXd29sNXFaelIvUWlZVEhlWFZTbHc1TXppZmlIdHFTWWZt?=
 =?utf-8?B?YjdnTFBhdG5KUmVjblcrYlF6anA3ZkV5eG9vdWNFZUdZL1kwaUhNNzZrQVB3?=
 =?utf-8?B?eWZKVjFxVEtwNHN6RjFwVHVvYi9nc1hqUEc4Y1A3aVdYeThUNlFtTElnLzh5?=
 =?utf-8?B?S1hUbFEzc0d2R052YWVCMVZBYUtteXlRUnptZUltWjFhWUp3MUxVWm54Z2xF?=
 =?utf-8?B?RWVrNGVmdDZtY2tKcFJCUEhMOHhodWhLRGdUY2JhemkvaDRhMEJTWDRpcFVE?=
 =?utf-8?B?bDFlb2xXSGlzUjR3ZHlhUUUzZ3JwSm1IM1dSc0NzbkxmSG9ySEU1WWNDYnd4?=
 =?utf-8?B?b0NUSk41U0plbDlmMldlc1ZGejdOWFJ2eThzTFViMm81a0RhMWlRa1BSOEFh?=
 =?utf-8?B?bHRVaFd3MHcwT3ZOU0tYeGY2VkJkbHhjSVRyVC9RcHFydExuR2RMeWhvNTRY?=
 =?utf-8?B?MmQ4TmJicFk4OEhoYTljMDd6YUdTQktDRXJKOWxQb1ErK00yZzVkcWhsa3d1?=
 =?utf-8?B?dGJSV0dKWFlxRDFlU1dTbDNjd1lLbmlYb2svQWlRc2o1L1Q3eDdXVW9DVUda?=
 =?utf-8?B?T3lMditJTVY5MDl6b0IvaXA5SEZDNEtCZEp3ZlFONWJhY2d5MkgwVXVQZHFM?=
 =?utf-8?B?ZEhEZ3h3MFhxNWNteU9mQnVmSFRmSXRwbWFoV3NqQmt3UXhCa1NRNjJBeHdY?=
 =?utf-8?B?YktUYzBrNnBTTmwrS2F3ZGV4OFhiSHN1UEZIUHFyTHkrV2JiS0xwampyVytC?=
 =?utf-8?B?clhHcVhhRmNENHluNHFzaUhYTWRGZ0s5RTF2UHdrNU5CT0JheUtEcWcxc3BD?=
 =?utf-8?B?akR5eTdYV0ZmTGkwS2d4RTd1R3ZJZVZ2UFdLaE92aGxTcHBDZVNxQXRFT0pv?=
 =?utf-8?B?a2FsTE5XckxBUUFOS0pGRHNyNjRxcjJ1K3FDQitiTFVhdzg1bVNaMnhPVkJx?=
 =?utf-8?B?UE85SlVSQXBXSDNEU2hwVkVGeWQ5UzVZNU5CaEwyOHl0RWY0SlhobzZzb3NR?=
 =?utf-8?B?cFhaZ3RCanRreDFNczdMMzhjWGZHQzJzUG9ZMVlVckRSc0VibjlscUVMdDZi?=
 =?utf-8?B?VExsd0JZWGRTNWoxemRvRkxWUHBSQjJaM0RzNWRySkhTSnk5VTc1WFJLSkts?=
 =?utf-8?B?b0craHJseEFUdzZRTzM1WHpndXloK0l2Ni82QldRMTFsK3Q3U1RtUmVqVUcz?=
 =?utf-8?Q?tXVmKR6563c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkc1TmgxNVFNZTZtZDlFWkZHdU9IOUlsQ3Rna0dtS2FpbDlrSUpjbHBjS3ZH?=
 =?utf-8?B?UUxpUjBwWFg2NzJ3WXJvS2U1UlN5TGxNRjJwRld5Z2lMNWZMdVFJdXd4V1Zx?=
 =?utf-8?B?U0FnNGIrcWloeHZPakpzTkIzcEVsT20yRXk0djJvN0pKZW1IYzB0dTlLWnFI?=
 =?utf-8?B?aGJNd2FEb0FBTTZJSUQ1b3o5ZWdFVWNpVFpmaWRkV0g5U0Exdk1qSm9nMGJ6?=
 =?utf-8?B?elZ5azVqUGo5MC9EOHFEdTN3b0NVSGNIUEZDN2EvRUpxVytWRmh2R3lFK1Av?=
 =?utf-8?B?OURTL1k3QmljVE9wTjg5OEdFemFJZjR6dHd6bWlDbzNmUjlmR1YxcmRqWFBT?=
 =?utf-8?B?ZmNVVFgrVEthekhISi9qK3lxVGFVV1FjTW1WUWFNcGxQUFlwVGFSelpSNzlQ?=
 =?utf-8?B?VE9nQzZtSXFoQzdldGdXcldleVg4NllxN2NqRHcweW5nbDloSVRIc1NtNmlC?=
 =?utf-8?B?SlVDZ3BlNDVxZnNkbndZdFJYWmptRXV3dTZqNVg3Q3VpUVVDdTNNZHk3N3hO?=
 =?utf-8?B?M2oxeE03MzhpRENkM0wwU014MGdPK2ZsZWhOWUNmNEhmV2xtbFRFdWpHRlJm?=
 =?utf-8?B?Sk9nemlUVThKUUpXb1BIOWNYb2x0dUxYaFlVZUVKTnBMeEpTellHZ3E5amc1?=
 =?utf-8?B?dzhyTEE2UHpOWXpUWGhBM0FudjBVS2JDUXFRRjVHaERoeUZwakZHTHFEMEYy?=
 =?utf-8?B?TzhFajAxM2VRWitoVXpWUjZ2aHpMVEZZUW9JaUZTM3BicEZQb3BqSkc5NUt5?=
 =?utf-8?B?RmZRZWlvblcyOU5IMzFicW54TlNnQXhjY2hOa2ZMMkEyNUpoZ1VQS1dPbXhO?=
 =?utf-8?B?UU1KNGtucXBVRDFBVzdWRTlDZW1oR0wxWnB1cDcxd1gvWFhXUUJtVWhPVmVm?=
 =?utf-8?B?dk44M2Nac3ZESENEN0VEcWxwQm1HL2djRHVxVldjdE10MVVadmJrUndMSm1s?=
 =?utf-8?B?L2lwNWJhQnFJSWs5R0tyOHZIdTJWdVJ2dThiQnFRcWFKZCtXTU5Ha1NsNW9W?=
 =?utf-8?B?dW51NWpPaGR1UWhqemF5b0JwcHdsZEkrcnRWVW03UjJHUmVtNGxzcnE3ZVBR?=
 =?utf-8?B?ci9VWE0vVDcyME55NnpQMVpsajRvS2ZYa0FNb2h2U1BZMkw3MUxtWXRUMGgv?=
 =?utf-8?B?b21VaUkrUS9qdDZrY3ZPVzhhTFp3Q0hvUzdSRnpRdUR4N2V0ZjhTczgzU3pV?=
 =?utf-8?B?ZW1ZWTZ1OVhlL1RLT0JQd2FQWGZNOEpjZy82VVRlSlViamo1YjljUzMzcS80?=
 =?utf-8?B?R2J5aEg2b3ZiaWFFQnFOa2JoSnVYd1k5Q1BLSW5vQUdQRWl1UHNrdm5RVUdm?=
 =?utf-8?B?NFZUNG5GQytOUlhYamw5WVUxRG12RUdwSW54M3hkdWZaT1htOW5Ka2haZnVr?=
 =?utf-8?B?ZXJoVEFZTitlZXNtTVloVGNORXl6RU9TbzRWS3FJc1hBTFRqM3VLNzJkYzFN?=
 =?utf-8?B?UEMra0hzN09IbmxQdzY4b213Z016WmdFdHV1Uk9YODB3WmlhZmRLYVFUVktL?=
 =?utf-8?B?YUJBWUgwanhka2xXOUh6UmRJQTJ1RWxYak15REhxZktWUHVveFpSOUcxamxs?=
 =?utf-8?B?REhmMWpCbnlwc0xaT05leUpjeWRNblN4N29CMDNNTzJRc001WXkvS2ZSdWRQ?=
 =?utf-8?B?VEhvRnJIRHJ6S2JXSUdRVVRGd0xIUE1IVTFhUXM4WUNLOWRKS2ZtdHZQK3JQ?=
 =?utf-8?B?NzFaekt2RVlCMFhiWGJYam55TWVTeG5uSUxsUXRVbzZydjBtYUlYUVVicnEv?=
 =?utf-8?B?S05rbFQ5L0ZWa25Md2g5NGhOY2xVZ2dzSGhqaUgzc1ZKTWgyYi9mQWJDeDEr?=
 =?utf-8?B?K2p1UmprTWl6OHVjRU45QzdNT3NJMWJIMS9ieXNqamFHT3A1ZmlVelo4YlhD?=
 =?utf-8?B?WTNEMEtxOHl4Z2Y3YkF3OWMwTUNDSkN3akI0TDlWM0pSOEtiM1ZhTS9KUHk4?=
 =?utf-8?B?VG1ScHNMSEhGSXlxVDdyL0hOU3pacTVzYXhkNUx5YlFkM2FRTnVJcFdOcmNK?=
 =?utf-8?B?cStYOEZCNVBEOHBhT29RN3ZzSVR3WU9KeTRHL1BOTk1yYXEyWXlCQXNQVjlR?=
 =?utf-8?B?bHVEb3NkOXduT3pOQm40MEhickZpUkVXSDdTZGpITnR0b09rcVh6WlZlamdT?=
 =?utf-8?B?MkdLdFNxaWVCZ0dKZ3c5WHZ3VnErcFVXaVBHakEzMno0S3krb09uMnBoRHFI?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f37360-5eea-45c2-0cd8-08ddc5625d38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:47:21.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qwtfeyi05yeyRKrN6CgxinPan4EM55ON5rFIsW8AAkzxRJ7is6I2kNS6GMulEkqSrxeP/pnh+9my43c7SPycj46zPOniT+4GSijVFIo2kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,


On 7/8/25 3:17 PM, Babu Moger wrote:
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user.
> 
> The ABMC feature implements an MSR L3_QOS_ABMC_CFG (C000_03FDh).
> ABMC counter assignment is done by setting the counter id, bandwidth
> source (RMID) and bandwidth configuration.
> 
> Attempts to read or write the MSR when ABMC is not enabled will result
> in a #GP(0) exception.
> 
> Introduce the data structures and definitions for MSR L3_QOS_ABMC_CFG
> (0xC000_03FDh):
> =========================================================================
> Bits 	Mnemonic	Description			Access Reset
> 							Type   Value
> =========================================================================
> 63 	CfgEn 		Configuration Enable 		R/W 	0
> 
> 62 	CtrEn 		Enable/disable counting		R/W 	0
> 
> 61:53 	– 		Reserved 			MBZ 	0
> 
> 52:48 	CtrID 		Counter Identifier		R/W	0
> 
> 47 	IsCOS		BwSrc field is a CLOSID		R/W	0
> 			(not an RMID)
> 
> 46:44 	–		Reserved			MBZ	0
> 
> 43:32	BwSrc		Bandwidth Source		R/W	0
> 			(RMID or CLOSID)
> 
> 31:0	BwType		Bandwidth configuration		R/W	0
> 			tracked by the CtrID
> ==========================================================================
> 
> The feature details are documented in the APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


