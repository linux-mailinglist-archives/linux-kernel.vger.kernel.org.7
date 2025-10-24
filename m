Return-Path: <linux-kernel+bounces-869617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094FEC08550
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF983AA459
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917D730E84E;
	Fri, 24 Oct 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z/BuO5dv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AA2EF677;
	Fri, 24 Oct 2025 23:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349222; cv=fail; b=BbIxMMkEmaxSMU+EtV+ZmTOYmawX+8aF1I0jWFT8rGDgyk2Xd4CTYSss/WDliRFt8ePSn2seTI09DI6BzmTsRqS5yaqmryY5wHcew4UH59zh2MlknuAU3LYx2+L453Fv/NT6KyF/wlte3lmqQ6PI1EIVzd2d8S0+p05RrhFxJ90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349222; c=relaxed/simple;
	bh=5l18GDTB4jC/oC51GK/Jo6rrMkwGQ6Qd+8M1lioh4+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iC9t+7D8LXaS9Y+B8LelVOX42Y2ZUzrnog8E6oepY2W0va+4+ettvl5x4dJALKsSNtf5O0GnEj8EuhjG0jHMo7Wqb6szEwIhbPCB7Wf3G36xWM+GkISixbY9t9O/kqiBA+yxTOakfXvcfBREqu96rS48hfHc3t1rYIXQFAzVoJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z/BuO5dv; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349220; x=1792885220;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5l18GDTB4jC/oC51GK/Jo6rrMkwGQ6Qd+8M1lioh4+Y=;
  b=Z/BuO5dv1bxAyb6p0umF2kHsDEcKK1qLOqCJNgLrjN76cvrBl7qSiAml
   zq+owGzXEKBlGsNnO9xmmx1QEgXPVuqwZXO+ey1y+ihty3pFPygu71nJn
   xgld3eNqFodSkGGzrqjKJAoMYxJX7thkDlB9OPKn6pSV/ImG6YudPtlaA
   FP92JFeLsYojV+qd81GQZ+2Jqf8J1NsqyX/v/E+MpZeQNCmdIOMcXDN7m
   fZlVwFO9aAEO8izgnfp+Z9NwUv/Yx1SwLrXa9SODsNoei2MoaV/skf7Jq
   74kSIs1SapIOw4Cv3SLhFzMNFaIp8DMucYPtIKK8mburnKKdICdxCBHbN
   A==;
X-CSE-ConnectionGUID: TQ0zyEfCRBuhhcqCbCGfDA==
X-CSE-MsgGUID: jj+JAjQPTcKing2W2kltzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74651240"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="74651240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:40:20 -0700
X-CSE-ConnectionGUID: bWVR6qR9SKGxl6OdKQzCFA==
X-CSE-MsgGUID: ySbd0HayS/yw5S00fEIz8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="215202369"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:40:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:40:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:40:19 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3FYwZRX5nj+sfFHtQbrLVTI5ZDVDJ5RpMTmJgtWjHpietrDML/S0rtEXTj6qglTizaEQhO6hdLC7adqt8BaYXx24djol850HYQ5JG3t3nyKPxNSNZKRi8e5VB1ZvaJ3euNa3h6TqnugAJBI9xKQHE6DgohTAWMJ6PwwDunwi4O+z0leaEOmrmVgjjr9tfRvc5TM+2byQ0tsxgUN80ynx0d5hps/cXr6knnyzAoNXElHSLnHffWNdS251B5Ka1MtwxyZ3DQQbmYGMIMB7/+kU7oyub0dELzTdiARb6JNrucjACLgyU0By5qiJOBqIxNwCZNBgj+IixXj7xYHDS1jEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRf7xM2Usvj/IklWx1tFyacAIfvuWi/dvSM064PS7cs=;
 b=eXDHkCnkdD72tvnaKsn8R7HrVnqdfmNZlJTpJ+0hApWL1PRR1hKNnITWxX7lWGIABfV+/NX7KHOfQ2UVoey+mN/gX/Nt3s42HU2QB7x3cX5aTJ1lkLZJL9xMnt7oGMwqMym4GCXbJdXDONusHJmkFqacy0EqfR+D0l2qtXsVtm2C2Z0yiRdxzovmiOt6njxb5RdHME5p4Dn6GMxi0g41Gs3fMwJHHiIKZO8PY2mJ5TxU31DcaFsejay4a6lXK5WVOFpjg1IjQCvYOsJjh5L55nDsmvAiGdmYN0yYLkEnk7Hd/3BKEPLThsSWSsRJ1x/cxOwhuyxiO+O6irv9wASAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:40:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:40:11 +0000
Message-ID: <c6afde47-2af2-4e13-ad2f-353625e2f708@intel.com>
Date: Fri, 24 Oct 2025 16:40:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/10] fs/resctrl: Introduce interface to display
 "io_alloc" support
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <a47ba310e232e01d9d892ea30d570f73de3f8d8d.1761090860.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a47ba310e232e01d9d892ea30d570f73de3f8d8d.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0301.namprd03.prod.outlook.com
 (2603:10b6:303:dd::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: 210667fd-b1dd-48fc-591e-08de1356ac21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVRwRmNDR2VNeGtFWmo2UEFkc3ZGdE91ZS9NY2VVcTdBV25FSVBFdzFndkJQ?=
 =?utf-8?B?clBpSjlrNUtaV2MrZjdLNmxscTdNcFVzR04wWGR3L2FjVlYyYzNWRk9tZFpk?=
 =?utf-8?B?LytuUmtIRmFnczFyUko1RGFMYVRRTnVpRU5WOUxDYWZxMXpNeHBHektMUTVR?=
 =?utf-8?B?d1lEb1czTGdWcVNINGN1a1d2UzVMSG5wVVQxS3ZZZE5MMTFVanNlZnR4WVBk?=
 =?utf-8?B?QlkxbGU4Ri9qS21RK2dRR2N2K1l4YTAxZ0ZXcXhhQlI0YXlQbTVLWXBFRS90?=
 =?utf-8?B?WVBhSlkrdnozb0tPMXYxK0VyU1lrdm9EaW9uTHFUdVY5dDNXWnRBU3VVb1ZD?=
 =?utf-8?B?SGw2MTRDS1B3Zy9JenpmMkJFWlVVQkFBRG0zK0dlMUd6ZjNyQmpENFlyR2dK?=
 =?utf-8?B?Y2ozTkwweHFBdThScWlaZURFMjBmbHBKd2VucmtKUDZyN3JTK1l1WjFhUjk3?=
 =?utf-8?B?ZWRpakYrdzh2OTJTWGVVQ1JCUVFlcmJuSjE4VkcrU3RvdzRwMC9wUnd1VThu?=
 =?utf-8?B?Q1Q4S1FBVXNSU0lTV3B4TEprZXA4YnJIeWRERllEWE0vY3Q1U0pKN0xxK0dQ?=
 =?utf-8?B?b3F0ZTg4OWV6Rzh4MnlGOG1kK0FsTFRHaE5qWitUQjZoS29mL2pQRlpCMjVI?=
 =?utf-8?B?VW1mYVJ1T250NkVKNUhpa3lIbWcyTzZNbFRpRGZ6UEJIMGtZZmRwWkx1UDVt?=
 =?utf-8?B?MkI4MXhEYjhidXlHZXdOQXZ2N1lXVjZaSVozcmRuZkg1TmYvN3hyN2xpTG9M?=
 =?utf-8?B?MnJqVGtYcTNDS3BVbGlqY0Z3TWVtdDZQZzZ6MGxacnlPQUdEZFN5dVFhcFMy?=
 =?utf-8?B?bjd5NkxVRDVpbmdacXB5eUh1b0VXUGlmWFpvRXN6SFU4M0NwbFI2MTdSMUxT?=
 =?utf-8?B?T0lVSUlNU21CTU1GTnlGcWRUMGFFQVRuZW1IRU5WUjJMZExUdDNRK21kVGpw?=
 =?utf-8?B?UWNpekQ4ZTBsazlMQmRNY1VpSEtWRXhkZFdlRXlQem5vQ0pSdVNxbEsrSVhE?=
 =?utf-8?B?eFR0ZEFQTmNya1NSMVNMYzF3RXBjbUo0bHlEZk1CZkZVTzBsVlF0V04yQnF0?=
 =?utf-8?B?dWFudDZHbEE1cHEvNFNuNTRzOHJYcHRjemxHMkFXeEQ5cHFCaTFhbDBFMi9L?=
 =?utf-8?B?M1RUa2FUKzBpQWNJVGpmRERlbU5Weng1aWRFZDdUTzhIV3crMURDR2xxcXE4?=
 =?utf-8?B?bnBKTDh5aUNBcU4wR2xGNnYvUmw1ZG95VG1nWVFaY1dtcTkxVW1rbWFJVnN5?=
 =?utf-8?B?WkdXc1FCaEtaY2x6cTh0V1hEUDZ5L3BhOG94VWpkbFNlM01jQzR5cVphek8y?=
 =?utf-8?B?bGZpVnNLalpic0ZVNDR1bjZkdHQ4SjNVc09FZHdXWEgvMzVwZHhjL2lnRGxs?=
 =?utf-8?B?VXpFb0dpSHZnZjhwR0kycHNwTW00NnJqWXN1b2N2WG5FR0YxNGU1UW1PU3lF?=
 =?utf-8?B?ZHRrNlVhT0lYOEhWNUhwSExLdFpMMURaTHBQdW41Ni9WeVJNT0hZRUx2RjJO?=
 =?utf-8?B?VmNkREJzRFBHdWM3R2l3b0JZKzBsS0paRlZ4OGo5L3pEdDhJUDg5UTA0dHpo?=
 =?utf-8?B?bFlLTlRTTSt0ZXVCWnZwdzd6cWtmQmFvL01UMjl1RXFUUzNhdG5WWTZmTGdn?=
 =?utf-8?B?eEhaSjB4YkNpMjYxVE9lVlJJdVVNSEhNaG8zMXB1VTc0d1RxNXZUV1k0Rjdh?=
 =?utf-8?B?dDNmckdJVEVPQWdPeHR4QjV1UWJtdkp1TFFDK1R2cm1nSEcvRWFFMDNKODJV?=
 =?utf-8?B?dGR2NTVlamUrVXpYdFJ3S1dCRUlPZGd0RVNwdU40ekJvUW9pMm5CeVV6eldt?=
 =?utf-8?B?c0NSQlh2eUlXeWJMTCsvdysrM2JMOFFDdjJuNHE0eXRFWXFpZ1Zid3M0blVq?=
 =?utf-8?B?S3ZFcStQajdVUC9pb2FUZ0pwdXc2RkFka0ZEb2pDOENmSDExRUlUbXZIQWlO?=
 =?utf-8?Q?XiqulaAxMRILjABFebPpkv71GYapkRHc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE90a0pwVFBnc2pyTjdPZFEvQ3MzbjB3VkxoRUdNL3FTNW1RSlhJb3pRTzFF?=
 =?utf-8?B?R0YwMkcrcWEvNlpZM2tMblQrNDZTMnJQVy94eE45UnFrQXQybUk4MEI0VGlw?=
 =?utf-8?B?YURvRDJLS1B1QkZoeHpvdGxCZ3pVK290NVhSK3RBM2dBeTA3dUwwVTd2czlI?=
 =?utf-8?B?OXNhQ1M4bldLWDdEczBqa1FWNno3bnlKWW1qN2RCTnNxa0NYTGZEblVzM2hj?=
 =?utf-8?B?WXJSSStjbU5DelV6VE1BdHhvajJqbUFMcGFKQ2FFTy85YWpkNlVqcThPUE15?=
 =?utf-8?B?S3h1RGVMaWNlQndoblRlSjNsVmlzVkJPNElMM3I1WU54OENMU1RzRXNqay9q?=
 =?utf-8?B?c3BnMURVOUhGWHM5YTFlR3AyTUhXd2VLSnphS2cvTmlGeXdOUXN1NHlXbGVa?=
 =?utf-8?B?cjlJSlhpYVp5ZW4rR0FNY2RKVTJsdW14ZHpRZkFoeDcwSnBFWFVEWi8zblZq?=
 =?utf-8?B?RnFNdURQRGMwVFoxM1FCZTJZMjFtWUNkN3lZWWJ6REZjRHhpbnBlS3RSMFU5?=
 =?utf-8?B?YS9obEltbXZzSzhkakJOUm9LWXpVNWg3amJVOU5tMzRqancxWFV4eTM5L1BY?=
 =?utf-8?B?UlBiQVRhSGgvVFljc1dvZHNrYTVSMUJOeUNnMEFGRGNmMlZZOW9qWXRaMDY4?=
 =?utf-8?B?U1luay9EcjFQdUhLQjkwOEFnUVgxdHNFY3VTLzY2QzdrblhYMXpsYnJHclBo?=
 =?utf-8?B?eGFmQkxTb05GdWplQndHeWpkNzR3ZGIya0thK0svWUZ2NUU3UVBXMXhKT3ds?=
 =?utf-8?B?dDExNjJhTXFubUk0T3VSMTVEaGdEdE9xejE0SnNSUGhGVjdKamJESUVpRDJ2?=
 =?utf-8?B?RHBNYnE4MmpHUHRuQis3NjVOZUNVTk9JSlJxM0UrcmFJcWE0d0FkeXo4WmF1?=
 =?utf-8?B?OVo5aGhhcFY0cmVOWDJOekNjaFVUS2FEVCsyeHRqZzNkWEcvcm1ZWVh2QlV4?=
 =?utf-8?B?QnVtQm44ZEdSZTJUVm5zYXFnd1k3K2JvR3pRMTFhVW1ZS2V0aEtPMEd0OWJ4?=
 =?utf-8?B?QmFPY3pnZUxOeTNlRDlQUys1MEgyZ2Z5Uy9uSUVqRUx3NjVGODJYbXVURFlh?=
 =?utf-8?B?NnZWc0lpbGREMHFWMXBheHFJTDFNbjJiR2FwM1piL2RTTWZEYTFvYnFvM2dH?=
 =?utf-8?B?dmw3b3RxNGxkR2hIZno4S1ZxTVlRZHRMUUd4RTg2OFM3V204K3pOTTFVRWRJ?=
 =?utf-8?B?UEpEMUVWWVZQNnp4aldQRlRZNlBSM3dNSHdIbjVmeElOZUllT1h6SHYvQVZ6?=
 =?utf-8?B?TEpQU0NGaElFL2NhMHd3czhUVWg2dTAxck05WTdlbExHQTJpWVhuU3BiK2xB?=
 =?utf-8?B?ck55M3RPOEhCOG53WEM0eXpwczdiNE1jLzJHTjRoc09YTGw0Vm9CYVFFejI3?=
 =?utf-8?B?dll3Wm9WZjhKWHN4bWpKeFFaQ04zYWNycUk0TGNKUjUvaFl0cmRuMUxDcFRJ?=
 =?utf-8?B?V1E2RWdtaitwTVZnVU8vZkowT3A5L21YRjBxaHUvR0VZZStDOEZvS2NnWDZo?=
 =?utf-8?B?MnZCQ3pNYncvOS9BeXRwZjVXcHdPNDFmVnMzeW1uMHVXNExuNFJNV25XN3Rh?=
 =?utf-8?B?RzVWZ3NQaEludUUvMFhMcVRxYlVpdEg0WFpMUUJEZDJHSGdpQkF0Sllqa2Ry?=
 =?utf-8?B?WGxZYWZ1R0VoWlV0Nzh2RWI1N3Jud1V3M09naVpUUE9zMW9jcUZPL294WVVT?=
 =?utf-8?B?TVNqR1lYb3VodmhQRHRkblB0RjdyWTFNRVdzclZ5NUZiWVNlUzlGN0JlbmQ0?=
 =?utf-8?B?WlRFb09EcU5VeGhmSk1peEpVTDVVRjBLRTBlNXRSdHkwY0x3L3hqL2pMZEZU?=
 =?utf-8?B?cE4wajJPQ3VFV2hUMFJJeVF2QUthRER4R2hOcmhuNUdyNWs4aS9SOTBIejVu?=
 =?utf-8?B?ak8xemJwWDJ1WCs1OGNZaFNBbFpxRXU5SC9XZHVOS1JYbTlPNHd6Vm1odmRh?=
 =?utf-8?B?UTdMU3NNcTFvZFVrbVQwRzlwWFRKY0Z5WWw5bGRJZXRmK01lK3Fvc0lPVEww?=
 =?utf-8?B?SFhTMU1XSlZna3VhS0NwZXJ2cnRNSW1hQXlNNTNNbnhWOTdqaDhCWW5aWjZu?=
 =?utf-8?B?WEg0cGRwUHM4L3VSM3ozL3Z2YWRZYW5JQTUwSlJJbmxxVFAvNTFxVkRBOVp4?=
 =?utf-8?B?SVdDZEprbjhHNlF4RFVwNENCdzg5alpnWDEwTmtsOGhrdEU2WEpsTHNTSlp3?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 210667fd-b1dd-48fc-591e-08de1356ac21
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:40:11.0291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ61+SI77wsMYHJRG/FxzYvaNU3cG1rnm7kVQqAG095uq0FC29dviYtlWEYFDIM5JvpewMqeGOflX/UmIeCzp/gUJgWHZVNTZYZhl1CPvbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:
> Introduce the "io_alloc" resctrl file to the "info" area of a cache
> resource, for example /sys/fs/resctrl/info/L3/io_alloc. "io_alloc"
> indicates support for the "io_alloc" feature that allows direct insertion
> of data from I/O devices into the cache.
> 
> Restrict exposing support for "io_alloc" to the L3 resource that is the
> only resource where this feature can be backed by AMD's L3 Smart Data Cache
> Injection Allocation Enforcement (SDCIAE). With that, the "io_alloc" file
> is only visible to user space if the L3 resource supports "io_alloc". Doing
> so makes the file visible for all cache resources though, for example also
> L2 cache (if it supports cache allocation). As a consequence, add
> capability for file to report expected "enabled" and "disabled", as well as
> "not supported".
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


