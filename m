Return-Path: <linux-kernel+bounces-751298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2A5B16763
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468EC177360
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F2421FF27;
	Wed, 30 Jul 2025 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hiYW5rsJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D0A21C19F;
	Wed, 30 Jul 2025 20:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906149; cv=fail; b=nkE6Gz1bY3RdaB9/snmUoOXLmsEjuIHqaVqu+o3La/mPH5kV4b8QUePbgV6RZEVbhoQU3zWZiOub7LQsbAgB1dG8uyYS0/9b0gajIF3D6PmF9Y0uDXr0hVC71c8rzuJsMMx+LwgcUmSHwA0Y6WznQzY8NC3OnKE2BrTyvYUeyj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906149; c=relaxed/simple;
	bh=OTzjc7odW+vvPWSXDkvcb+LhA19Hk0xJ+/3f5tEytGg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IT1cdWCizJwF21iqn6tdbaAMEkI8/ckmJenD1hK/0XEwtp9IpAbcKdcSqBqiR6HHg8Tdmv5NhiRl+X84mwo3rRaGfBJziB4CREPln65khzeqnZwU0MxzkZZCAMZNvwg3jpG8gKZaUvlkb+ED8OyrF2AH9Z5ndvZWrFlOqvYePFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hiYW5rsJ; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906148; x=1785442148;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OTzjc7odW+vvPWSXDkvcb+LhA19Hk0xJ+/3f5tEytGg=;
  b=hiYW5rsJdQpjWhAf8u6Z1vqFD4hmt9IM26StPJUVL0Ph0DYMo7DDpk7k
   jCzWbdDUyCQWG7J58O7mYZDY5qt1TcV8/cJK1rbzboeLXcXGMqv34B6qp
   dQfNlvjmqoZOT1l0P2lzlNLzrMOXiLZsEHlhzoFTVKEGnQBsdbk85sX93
   i7SqNQ4I+j6EQkq6DAfbiNIKZ1NVwwiBDKh3Wa4GGFznhtwpKxw3jFp59
   W/Wre+ptXZ9mcbmSdNhSPDxTLBo13iwHkkf6zL6x93wGv+fi0jTmVQojS
   neWVm8waDdpNGTxOvo9HRI+vscN5g8sQ8/Aye+0To4xcrlqK54dfhCKL4
   A==;
X-CSE-ConnectionGUID: e6N6jRlTT6GJE7K44me/IQ==
X-CSE-MsgGUID: HhdU+/5wTyWbUlorHQXutA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56185671"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56185671"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:08:54 -0700
X-CSE-ConnectionGUID: QodkIVIKSNCNd1x1BxhCnw==
X-CSE-MsgGUID: PcsnG6u1RFqhmlp6xaKDqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200243515"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:08:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:08:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:08:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:08:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryuepiqgJ0o7pcBr1TiIFWYxXdn9wnKZscZRZtj3/zyPY5gk24+WNWUjlKUnzix/8uXFK47aVoQd0OWhCQBCeWe3kWf8//Yi1XbEfxV6kRrQCULMnbKkkEJ6A8+V+dTHBt8BMba+WDKsIdpvPFV1g0/3We55vbodyZuLagVHiKc1k/qfWKipRzGOlpO2Mvtp7EwLnesqk6BlrgXk7exnszC7O2hWpb51zCMTaJmoPKtvejbK4ZRUPrRCTzLjqnXVSdvZFqIImzjymkjd3CZq8bzrLK6nHUuf3t0PuyeXd6ekvhBfdAZ5hkchJrneUHoNhqfYR/IyVUrAx7p4KUlPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfOcwn6Ob4IXbiMRqvXXOWWuY4tgzNA4fJLAhabobX8=;
 b=MLFDE9V7Go8Wkp9DOG97DO8awuyz8vm/6A2ldQunscd6HaNmAQW0P9cQKfvmna9WB02+siPosCzBwRbjLJ30LIlHL7ET8rWs+TVp79y9zFlSysh+vnMGC1lFItXqj+Yd/F0g2rlAF//L7Uh6+EXHF1l587IkBa4pkZhQO9TCrenwPF6dCqrrGVvv+1ZSoQ9pyGWo2JOxX5xomSsyzQvBt9CfoZ0QGSdxS8/6RqNipFCl0EY73VvIoiLwYtG2UhUUhLm3z21KGhyKi5tLE8lIDdqmIyJnDHmuk0vp1jhQv+RqAoajHLevZw5oc6Cd11BV1+u014/0aEB4RqzYv6gHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:08:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:08:38 +0000
Message-ID: <dbae9388-3fdc-4f26-9a1e-dd7abe73b0b0@intel.com>
Date: Wed, 30 Jul 2025 13:08:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 28/34] fs/resctrl: Auto assign counters on mkdir and
 clean up on group removal
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
 <df758bfeb3f8a3e975891029b3a0ca90da3744f0.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <df758bfeb3f8a3e975891029b3a0ca90da3744f0.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf9ef36-b969-4494-88e8-08ddcfa4def6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDNvdmhJa3BxcGx5eDFTcXNlVEIxQ0RMWEdJTFBlL2xhbS9nUzg5ZGNjZkhT?=
 =?utf-8?B?cUFvWnU3Z0lHRCtVVlo2RlhjM2N1a295T3IvNkxYUXdJaUJJUmpkS202WnBu?=
 =?utf-8?B?Ulh0ZEI3d0t3emtNR01Kdlg4Z0VrZmV6NndsbXBRNWh4RnF6TGlJaVVIbE5q?=
 =?utf-8?B?UVppcWIyZmQzL09ET2s4cU9PdjVFQXl5bXNYdlNLSU9NWW1nV1I5UFpIRUNN?=
 =?utf-8?B?VlNFMzZBNVZiUk9yZkY1NWlzYUZtdlpta0lSQnVoVWhOajM5Y0kyTzc2VFNn?=
 =?utf-8?B?a3k5ZmJpRDZ6T3RZSzgrdGp0YXZKOFVaQTNDblhENFBTbHFtVnJDMXY2V0ho?=
 =?utf-8?B?Yk5HWHkrQTJMUm5udkdzM3dHWjRPSWFwQWR3UmMwci9SWitGd1prempyMGRM?=
 =?utf-8?B?dzlpemQvdFRnS0svTGpBRE1MVGNvNHJOU2pHOHdBdnE5L2dFUXp5NWRXaXJ3?=
 =?utf-8?B?cEhQU05WNmg1WStodHRKWStmOWlhQ1hOK0xtODdVU1NINWZPaU1OMUg4eno2?=
 =?utf-8?B?OXZZRitzR1ZucUpOd2xhbjRTcENlK2s2RHBHYkRSbHlWbUJBVzhxSHlhSFpy?=
 =?utf-8?B?alZaYTFHc0lqMzhZN2ZXemxnNklrUGpQc3JRWGFXQ0drNklWSXZZRWFvdU40?=
 =?utf-8?B?QTBNdUtCUFlKZlF0T3lQK3JMdlhOLzNRclpvOXVqUjlBK1RkUDJnNTZtMFJv?=
 =?utf-8?B?cVl2YllYdGhGTUhld1k2TGJjbTJQSFNPd0pnT0JRVHI3NDRBSVNoOTVuVnhK?=
 =?utf-8?B?aGxWQmNiRE8rZDFuUmt1NnlkUmxIRzUvR2w5OVcweHFpWmJ3MXdrNVA1Q2Y4?=
 =?utf-8?B?MWkza1pqTEJlVkw5bkdueUJueXRWd0pNcGVleXg2ZHYvdzlXaWorQVNsRTRF?=
 =?utf-8?B?VWRHb2hpcE1wc2doaXpkSTltQ0M1aXgxejRIVEliYUkvRCt0OGxuTks2UnJ0?=
 =?utf-8?B?L2tGN1ZEa1JUeTZRdGVrbGMrSmdrWFJRUVhsMSs3SXZSSEIybmdnWUdwWWZ0?=
 =?utf-8?B?czEvc2ZyRFlxNDRtMjZYb0ZJbWxLWktFcHNPQWNtOHp0cnZLYmhPSmI3ay9D?=
 =?utf-8?B?V2VQcWk4TVVTUWV5M2s2YkdBR2Q0ZXpNc1ZMdkNkUk1CbWdkNXRLKzZ5a0g5?=
 =?utf-8?B?aTJJRW5aWTAxaHd5VXZFZUZDdXltKzNwemdQNDVzN0Q0WmRtNHEyYm5jVTZu?=
 =?utf-8?B?NUlEL1FpbzVwNEEvUnprRmFVdUZHUVoxQW1ha2g4YjQvRnl5eEFhb1RwNjl4?=
 =?utf-8?B?QTRYay9HOVIvbCtld2JZdEE3TFFPS29nSFo1bUxTQWR4Wm12V0F5QVVEY09H?=
 =?utf-8?B?SDd5T09GQXFmRzFab2xVam1UOVcrSnNPUDU4NzdmRjZMdXo5QlRYcVA0N29L?=
 =?utf-8?B?bnRlZEpoNkZpSFRWOW9lTm9keTBYWENETlBaMEpIZ0lUejArai9QRzhDc0Rq?=
 =?utf-8?B?WTRuaElrMWo2K1A5Ui9Rc1VCRUtsMStpOFE4SUNXd0MzV0ZnZVlxdGVSazBX?=
 =?utf-8?B?bisvVlNrMmNiQTJodjRhQlIyc3p5Umpnb0JxK3dlU2lGYlNIZWdGbWxvWGZ3?=
 =?utf-8?B?RGtEOGFWRGZ1V0JBRkh0OFNGeURRaENsT2hhQm5MZTBHclQ4a0pOSFhJSFkx?=
 =?utf-8?B?dUNuL29jMmhsTzd0RWovVFJBMXNPc3NDZEplRmRnWE1nU1RLQWNrcU5VNFQ2?=
 =?utf-8?B?blE1V3dHcmdjQWhyclNYeUp1dDlhRG9uMjUzNW1nZDJtMDQzR0FHd1pQcnE5?=
 =?utf-8?B?WUd1WWtqYlZzMEZhY3B5VG5BUzU0em5zWTVNNHFkZ2o2bDhzalJoR3k4Sm5D?=
 =?utf-8?B?TUoybk1TZHFjZWRZSm4yQ3VFMktTeEZiTU91U1BaVGpZb2dBeG9neC9DTWtm?=
 =?utf-8?B?WVRsMW9YNnh2RjM0YzUrVlhUaDRRVS9LenJCVmRPNnRSTmk4YlJRZFRXZThG?=
 =?utf-8?Q?DTXNW5Ymb5A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3h5bmhWWnN4SEdBZWpxdFhZNUlMMyswbnkvWjJ5dzN0S2NLRmdDQlFxdWRK?=
 =?utf-8?B?YzJYQTVSWkRLRFZPd2tNY0VDRzB6WjBLVTczS1IrNlpDSWxwMWRzUGllMktj?=
 =?utf-8?B?cnFXb3QvNkZmOFVEZGYzTHBrakpRMzJYUC9JcVgzRXVTMDVHY0J4VDJwK0JX?=
 =?utf-8?B?SG53TXJ1T2x1UWJmOW9BeFRVU0wyZkZvaWJrUGpkSXJZb3VCS1ZWUXZDNEcw?=
 =?utf-8?B?TTdQVTYyM1JFR25RbEV4Ly90ays2YTI3M2VVTGRrVDNYbVNaTkZjT3hneFcz?=
 =?utf-8?B?bXE1MSsvd1RtcE91WFFDMWZHZHpyV2ZURjlGL2dtLzYrWnlNT1NTZjFSakJv?=
 =?utf-8?B?N1JWcFk2bFA5UFB5K1dzOWdRTWhwbklUeEdyNkFhSEN2NCtuRXgvYmJFVGpJ?=
 =?utf-8?B?dVA2NTRhVGlGa2dkUjc4aVhwM29CcGlQRUxJSXZ3SFluRXpLTm1RUVBITUg5?=
 =?utf-8?B?bHdYb0lLTFgyY3puWUlKQnpMeGd3NEVSVloyeUpyUDRtZ2ZwcVdNK2lrbURh?=
 =?utf-8?B?U3FScjc5bTVzbVNVcERzckZ6SnpONjlxSW5RZCtoa3V3dVNHeHc1V0c2QzBq?=
 =?utf-8?B?eGQwMk5rRVRaOTg5V2RFbloyaHBZMGkyQ3JGM0JKWkF5TEJwQkFoOWhvR3p1?=
 =?utf-8?B?Wi9wMEZSSHR1cENmaFhTYlpvbkZnUEU1NGkzbUJSOXVDZm1RbERRMXNFeklX?=
 =?utf-8?B?MFI2QWIrNkEvK3JidzFmZHdLM2htRW1WZFNuSjhFTUNrM1dqV0l4a2dFb0dO?=
 =?utf-8?B?dXBrTGFEdTh1MnZsTnAzVWUwdHVnaXhpTnp2cmprUlB1NGdtSWIzeGVIWFdU?=
 =?utf-8?B?eWZjTURBVmh5ZjBHcVZ0OWtSNXdXY2I1dkRvYnlabUxuL01kUi8yR1pCMTha?=
 =?utf-8?B?dzhsbVQzM0d0RzdWOEhQREE2Y2VndWRWTVZlWkFNSGF2YUZiY0MyWm1WZnRi?=
 =?utf-8?B?Tm1NWEgwM2VraUdRN1NJTEFiRlM0WE5VN2Zmc2NvRWJTdFNac0ZqQTBSdEQv?=
 =?utf-8?B?QnpkSlVJaXBFcjlwLzIyRW5VQjkyamNQL1VSWmdtWmt2UGtoV2hSVWpIem5i?=
 =?utf-8?B?MkU1U2lHV2lMRkZ0TGxNWlg5MEVCLzEzdldsdG12c1k4K092YlJYTUJIVHdz?=
 =?utf-8?B?RGFyaHN2Z2NtZGJNYnIwWHFaOWVRR0VXODdxQitIWXBYZkF2ZFNRT0tJVnlB?=
 =?utf-8?B?RDlPUUdzKy82NDJNdFM3UGw3ZGJ5SWpNcWw1TTRLdEdJRXY2RWhXTjJCT1Zx?=
 =?utf-8?B?NEh3RVVLQ0dwMTA5SEJVZjR6QkJXNmxGZnBOZ0JwelRTSWh1Q3UvNGhaT2tn?=
 =?utf-8?B?TCtRQlRXa2JnQy9UVmdwc1AwSHdNdjh2TnJaRytVQzV2VWJDUURucTF5LzdL?=
 =?utf-8?B?RC9USDB6VVk1aW54WjgvKzR6RXZza0VKaU1Ja3dvZzBvUkhoNlJaL1gvWE1T?=
 =?utf-8?B?dUNEVFJza0R3TjJkL29xc1hyYnlVTm1jeGVaaU83NmF3bXJKMGhVU3kxRERy?=
 =?utf-8?B?cTh6Tmw5OWtwOUVSeUptODdESG4rSW1WSlBsQmpSZ1EwSElYNVpNbmZkRWdn?=
 =?utf-8?B?eElwejJMeGtyNUsxbzlSdko2WVNPWTBRS1N4WjhhdUgzTVd1M05JSW5hbmEw?=
 =?utf-8?B?WTFFbVphMWxtS1AzMFdyMWJVWDFJRGVDRFNFa0N6enZLUCtYazBrMzlWT3Nr?=
 =?utf-8?B?dC9DVE1kQmZHcVJueDkwR2xXTUo5QkMxaWYrMmVSRE05elFsT09SUFc5a0th?=
 =?utf-8?B?NHpNMmNnRW9qbXN2MXFIRytVSmFaeVZrOVh0d0dDZTlpUURyS2wzQzZITWJE?=
 =?utf-8?B?Wk9SWjhCa1FtUzFsalNhNFFDVW51amlVYm1ZWmU1ZGJNQWhkR1ZLWFFQR09G?=
 =?utf-8?B?OW1iUkJ5M3BsWGRsdHEzaSt3VnBGZWJzMUJTOENybFZWQ1VwK3NGMWlmWkk1?=
 =?utf-8?B?TVUxa1l1OWFkc0hSVllCL3VEVmpjVkZJakJNVVdBbVF3MWw3c3BzL0RLMUFQ?=
 =?utf-8?B?aFdEU3UyTDAxNDd1TkdDdDd6U0pWcWhkSS92QXRqMEtDKzF6VjlKa0xNNGRt?=
 =?utf-8?B?V2kwVlYwZG4yRTVVTWc2WGZaS2g4bWRtdllxazYrcUJlUmNyVC9nRW5DMXpO?=
 =?utf-8?B?bU9PalBtdE9wSFhjNlo0WGhnNEpoUDA1cjJvanh5UGlQV1I5TDE5NUVSVHRZ?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf9ef36-b969-4494-88e8-08ddcfa4def6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:08:38.0484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNg0c5fm6HcDdhBGVEmBrLfIn26PosFr32NAPwqnQsCYc4Rkenh1knkNkfpxrn6/7Sf2cLkj9KqPzmwWGZsDbY+ksg/bsWN5gPJVazrmVKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:

> ---
>  fs/resctrl/monitor.c  |  1 +
>  fs/resctrl/rdtgroup.c | 70 +++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
> index 6205bbfe08fb..5cf1b79c17f5 100644
> --- a/fs/resctrl/monitor.c
> +++ b/fs/resctrl/monitor.c
> @@ -1072,6 +1072,7 @@ int resctrl_mon_resource_init(void)
>  		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
>  								   READS_TO_LOCAL_S_MEM |
>  								   NON_TEMP_WRITE_TO_LOCAL_MEM;
> +		r->mon.mbm_assign_on_mkdir = true;
>  		resctrl_file_fflags_init("num_mbm_cntrs",
>  					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
>  		resctrl_file_fflags_init("available_mbm_cntrs",
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index bf04235d2603..d087ba990cd3 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c

Please move rdtgroup_assign_cntrs() and rdtgroup_unassign_cntrs() to
be with counter management code in monitor.c

Reinette

