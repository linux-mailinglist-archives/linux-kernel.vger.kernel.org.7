Return-Path: <linux-kernel+bounces-739980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8FB0CE28
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8956C5CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2F246788;
	Mon, 21 Jul 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/nI/BI/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA712459DD;
	Mon, 21 Jul 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140565; cv=fail; b=nPFDMp0gRQ4V7Nf9nvFAMk62W+O95aA1JIS0jgJwc78Smhe0bqJuGVfooSFAezQHJcR30HHIYNjU9v+TqLAE48gbC4BjQDa3bgQ6f/dmkEH50B8141Pn/jBR+QwsIkjMU0wDKLAJjID5Bzb2FLXlY0Ol1+eQWv7uaq5aUhujneU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140565; c=relaxed/simple;
	bh=GPRHSFnbUjXjsys1Y6S6V33GbsC7LqHHr1VGWGceSb8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aGKUNB1XcH5YuOjgqKiXh7/xwhMHXJ0QfZk3RYxAWmsS0ZpRc7lroAYN8h30kdV8VKNDYeX+wb04uavJGiyoLQpouDp8YxVob4DKdEE9EOd9NqBO9JfzB1p6MQ5IeUrFujU8HVeonNDU3upoCLDhYfYKhVcV2A1/pCZWsU3IlEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/nI/BI/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140565; x=1784676565;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GPRHSFnbUjXjsys1Y6S6V33GbsC7LqHHr1VGWGceSb8=;
  b=c/nI/BI/CvS4xgLxwkJLr/irkgJbiz/d9YW3GySunB37t31NoLL70Ce9
   xglKFpHcRAmGjuFtMYzoeb423wEEh3wcbXk3jwXPxW7didiuFWsSYzSt8
   BlkIzMdzY+PMawlKAutq8oKrDsRjBd2gUIyytyiDcmpXLzbwVJbxsExGP
   U84gZkKDOj6N4wv+yCzBmt+dp4TTerMw6zVCYk0nUTM9V2+HOR9ztW5eq
   rtgBaEeJO6CtoxsqDd74y14dVp98lniWkdnGyVh5uXt3XcPH6ZVe8BQ2z
   oATF1B9FBSeUJrv10lIDK+heAz4LaGELmmlhYxQ3HZoo/Ge9A3vV4t84K
   w==;
X-CSE-ConnectionGUID: osTq/keQT9qTz9B10KCAkg==
X-CSE-MsgGUID: dkTIGPIKRzm9P+6xEnxrOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="80817899"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="80817899"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:19 -0700
X-CSE-ConnectionGUID: UFhJ2yZARLGB2jl5UUbKtg==
X-CSE-MsgGUID: QxpD/H4lTAeqegDzh/01IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="182688240"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:29:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:29:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.78) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:29:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mi00O5kV/jxlqLbMyoW5bfhSzxGr/Rd64+7tjX88LyBT2H16SCBvEiEVgi1p/CL0MJQP8KjViVbxSEGEYXSw7IuPm9zAr0ai5npCgrHK02PT+VRDAExzGl3nPuRIN13HhDS5oW9NGxHI4JAk0Dum+S39758RkojKM1pcjOFE8waI+s8WPxAkTTS8gRlXAeFpCWFwU7KRJrxZhMhrDwr/VpsZz3t5kcIJ7ZArU68K/zIW7jLYfioWamjfw0vILL9FsjfblJrAySsFOdBD5mZZaRXUuET8HS3HM2pNf46Q9irPuv5SAI2q+sHSZyJM8G0LvCnAxxfg2HzS0YpRZNSD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHBwaDf5QiawrHg+vp0tP8WSu7kPVPJoPmy67+MiAxE=;
 b=t6dgX8B3UiXQ+O3tZ9ejIUoxKLwcVAUAcYV035hmHPFwnWxgNXQjYnXv8oHgtKizBLDT6YCfEVi1a4BzDI9S5yVjJD9XaY3/p/W3NdshPo2rrMvvwitZVlNW3T+m47ofm9uLwNeoCKgsPE4k9Ed7Ww/jaTJICw2KDWHDBNQX52O9ICFUEBNCv/Z25KRKqmiwfuoy+NRB5mUUmI2uy5WQ1nPyh6A8Pi3kt08wrKemXRvXfVbI/iF750sBe9iY7no2SClWU3rkWV7IyBHUkOBj8NM565xjt8GcTlmEWb5Fy5k+NRcfbt8taBbzfr8N2OKx+YTtJQdgEr9LCI3hGrmadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7255.namprd11.prod.outlook.com (2603:10b6:8:10d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:29:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:29:11 +0000
Message-ID: <cb7c6520-e774-44cf-8328-08fc19e8815b@intel.com>
Date: Mon, 21 Jul 2025 16:29:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/10] x86/resctrl: Add SDCIAE feature in the command
 line options
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<Dave.Martin@arm.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rostedt@goodmis.org>, <Neeraj.Upadhyay@amd.com>,
	<david@redhat.com>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <pawan.kumar.gupta@linux.intel.com>,
	<yosry.ahmed@linux.dev>, <sohil.mehta@intel.com>, <xin@zytor.com>,
	<kai.huang@intel.com>, <xiaoyao.li@intel.com>, <peterz@infradead.org>,
	<me@mixaill.net>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<ebiggers@google.com>, <ak@linux.intel.com>, <chang.seok.bae@intel.com>,
	<andrew.cooper3@citrix.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1752167718.git.babu.moger@amd.com>
 <f3b1e748c13086a7183ffd159e667d07a4ff6cab.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <f3b1e748c13086a7183ffd159e667d07a4ff6cab.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 07e4a35c-7434-4d0b-36d7-08ddc8ae6574
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGcyY1lGOHNrdko0cWg3czg4Y3QzZzlMRU1IOGJBbzhCS0ltQk9neGIydmhD?=
 =?utf-8?B?ZGNuK04xNzVqODhnUlhBUDFTWlVNT2lweVh5MDZnWDY5ZlYxQ2U5NVpwcU5Y?=
 =?utf-8?B?R2cwRG1GNGQrZDBOSGJtUGY0clBLUDhyb2wxWTJJSVpwTmtQSjNLYXZWa01r?=
 =?utf-8?B?NG1vWnAvbWN1MGU0ekh5TzJzOFpMdWowTmhHZFFXSzBwbGgyNzU1Y0RicGtJ?=
 =?utf-8?B?R0V6N3luRkFNZ3BkSDAvTUFwOUtPa1E3NWFibGNjaC9PTmJ5TU1CeENPNjU1?=
 =?utf-8?B?OVVoT0pQWkJ2WDRTNTNkSk02b0tnckl6UVkxR1RxbmYxWnpnWjVwSnFlekRI?=
 =?utf-8?B?ZlZQdG1lSDNQZDg2Tk1nY0o3R05XS05ZMkZlZXNUOVlCVm9HRCtiTy83Vysw?=
 =?utf-8?B?NDVYMTZoZ281ckZ5c0dsb21UZjRFZUEyYkNXeXlSbFo3M1dZRkV1M3NwODBo?=
 =?utf-8?B?ZlUxOHZFRFZpc3ZzRTlCeFVLN2Nja05vUHUvdmRrK2RpREZOUkVhNElRcWlj?=
 =?utf-8?B?OVEvUWRjSm5PRzREUFRUQ0owTGVlR2hUMDJvNTVRSmFzWG43Y1hRTXhuby9r?=
 =?utf-8?B?Y1FJVy9jQ0R4QlJpcEhRcVRVMFQ3eTNqT0o3RllUOXR1Q2tTVElKV1VVckFv?=
 =?utf-8?B?ZTdNeHBYZWlseWk3NzgwZFU5V0x1d2VCaFBMQjkyR3JjNXdwcFJIVWxhdUFZ?=
 =?utf-8?B?TFhoV2JmWVFJdVNSbWJmaFpXYlBkd1c1a1ZhVE8wZTBLa3dGMW1OV0RULzdq?=
 =?utf-8?B?RWpvREJaeFN0M3hYUVhadnNWeHRIOFhkN1VZNkpvVzVES2FpMzJ2RnJXRnEz?=
 =?utf-8?B?TjdDTkxBbk9wZUhJelJJdU5YMVhzWU5GVmtwNWxKL3E3cU8zd0NJcmtEQlQv?=
 =?utf-8?B?R0NkbXlVcFNiNmhyelhJc21FU2JtU1Q4T1BUQ0V2Q05lck8yVjJRQThCNkds?=
 =?utf-8?B?ZXc5Yzl6Znc1RGg2WW9KVjJkU3VMUkF2RU5vSWVTODM0bmNUUnJoV3krOUk0?=
 =?utf-8?B?VFZEcktsS3ZabGdqbTZ1dlBqb2NCYkRpdm85QzhRMXl4THA2Rmd4OHRHRDdj?=
 =?utf-8?B?Y0RmdTE0R0dpTVdJNjZYRk5kRVVqVTU0M0IvVzg1VEZTWm9BQUo1a0g1N1du?=
 =?utf-8?B?OTI3MTlFTGxaTkZ3RUJRVk5obWp2SjhCejRzWWVqWXJiRnlJa1RvU0hNUlB3?=
 =?utf-8?B?OTVrdnZXNkg4U0I1RytCYk9zMmVJVlAwNVJVWFNFZUxXY3ZxYWdGNFFMc3Nq?=
 =?utf-8?B?dHZNNGkybkwwL2dJMVl5NmNxNlF6Mi9YSnJLcUw2VWJnRDZwQk1Lb2l3S0pa?=
 =?utf-8?B?RXJ4Y1NuMk5oQzY3NjAzZWo3NU5HRDV3dEJsR1ZkbVIycEw4NVM4Y0JEMUlO?=
 =?utf-8?B?SnE3aU1NR0ZIVkU5MjZFSmVXZEorZVl0N1hQblF2WDN5eEV4OUVrM25uL2Q0?=
 =?utf-8?B?V3ZVdDRHclF3ZVpoK1IyL0VBWnhYSDVwZDJOYzFyOFJjOTF5aWhtamVPZUZK?=
 =?utf-8?B?QUQvdWZ6VDlqOXhxMmZ0NlBjbzU3KzgzZ1Q2RittcjZ2VVEvMHhGdUk2eFMr?=
 =?utf-8?B?TjQwZHV4cGkvOVhzUUlNQlVvVjVCSVJpYW53cVB0Uy90a1ZsS3VDdUZhaWpN?=
 =?utf-8?B?UWREU0lrWld5cVZ0UDZHYjJyYjNON0NHNCtvNUhXZ1VHcG1pUmxYUkxobTFV?=
 =?utf-8?B?STJCaWVOZDNUcU1QdDZsUE5pSTlHWE1WRzdsUzZSRUZ6Q3gySEZja2o0dDRP?=
 =?utf-8?B?dWVEL2Voa3NtMjNRVlBLVTkrdk1QaTUzMS93OXFkbzUzWlVDTHpvZGozUWJR?=
 =?utf-8?B?R0tZSUxyaTlIdFFwRFArcFdwYXdDNE5KTlI3Qzhqc3h2SnNWc2FLeEQ4SmE3?=
 =?utf-8?B?TGVMdEIrNE96dEVqZTFPVGpVRGhHN2lTdlV3Y0xsNlh2UkhYUU1GSEozakVS?=
 =?utf-8?Q?qSICV04yzvc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTdWd01rRGZKbXFOYUwyNTlVUHphR1NuTHVNNkt0eHdZa3Q5RWxaNEhqZEFQ?=
 =?utf-8?B?YjNWTkR2VnE5VVduNFFWa1BPamhzTnZTd0dVZWN4c0hIaG82U0tzblZmOGxq?=
 =?utf-8?B?blVibk5oV3VwT2Y0NTllZExIbDIrZTJjaEk3YStWYmNHZDBjNGRhc1VUSlM0?=
 =?utf-8?B?dlhudVR2OEgzWDR1VFVPVmVZa1hPUWRKdnRlYkQzbFc1K2RxRy9FNmxVWmdW?=
 =?utf-8?B?UmYvNWxVUTZQRVpaSTBvQi9zMmM0M2IvZEQ3Z0k0MmJ0dWhreCtOSm91cC96?=
 =?utf-8?B?aktGVzZxYmhLamp4R1UrMEpscnVzVWFPSk1iN2lvYnVwWEV0R29qWm4zdW5s?=
 =?utf-8?B?WjBSMGQxZlppL0E3SXFyaThMUHdhbWxLUVJUYzdRdjd2eXNYR2FwaDBsMVhL?=
 =?utf-8?B?R2x2L2VQcFU5OWtqcWlBeXVsbEN2cXNYTE1SU295d3pDakZFQVZTMTNWR01O?=
 =?utf-8?B?U2ZBSURTZDEyOFNFZVFmRzVkUllYSVFDZGJYUEpFSlo1TExzUFd3U25wZVB6?=
 =?utf-8?B?RUJ0QkdqNXFvaWpVcGsxY3k3cmtOVVhHeUZHVzFwUmsyNEhhbUVMN2hNNlc4?=
 =?utf-8?B?ZUkydVVObno0a20rd09PNlc5Zkp4ZFM3TUlVWHVOcE0xcEpsNjRYanlkRjQv?=
 =?utf-8?B?cklXdEZYMUZlTWpYYTQvV1krYXp1YlJOUVVIRHFmb1QreGFGeDUzbWNaWTRZ?=
 =?utf-8?B?Mm1WNm1ZRDZNMk80YnhPb2MwRllVWUQ3OWczTjM4OXcweVV3L2IwSHN6U21Y?=
 =?utf-8?B?RnVJcGdUOTVzU2F2R1pvVXE2RVlYaGpsR1ZyQ2dQK0piZ1BjYy8vUDB2eUkr?=
 =?utf-8?B?bkZGOWJIaEJGVCtBVm1vb0ZQUUpxaGtHOExkY2lZS3RLLzJISFJKc3dUYThz?=
 =?utf-8?B?WEZpUnZmNVVDb1Z3MXFIM3RmR3JpRUFSckdhUjVZejlENXJJWlRkc2ZxRnZj?=
 =?utf-8?B?Nlp4VGMvUG4reGs0cnkzN0FnSWtGV0xKNFh0MEpGS2cyYWsrZ1NyeE1WN2hh?=
 =?utf-8?B?Y1ZQWC9IdUI2emdnZXVsL3NmclZXN2lTNytqSVBMNGp3UjVPMXBIWHFRT09K?=
 =?utf-8?B?NDRNaVI0b2ZiRGt6Y3dmbittVzY0a2FrbFF0U1k2aUZYdGtkZkM5VjZSRWVE?=
 =?utf-8?B?RzJNUGVnUndHVTdBcEg1M3dCalExcll2ck0wN21oSGtZeFpnRjdSYkNkOGpO?=
 =?utf-8?B?NGIybDZQRzFEdm5Xa0NEZ0tlRkpSV3JSY293c2NRVnkxdkhLRnR2d1FpbUV3?=
 =?utf-8?B?RHJ1R3dsdEpWVzJxbW5WZCtFTlJuUzh1UTNyeHhjYXEyOXVqbytHQkYxNlFR?=
 =?utf-8?B?cTFoSjEwTHdJMmlIZG1neENUeFFYWmsrd0toUzBFaytDRkRJY2k1TERnbVZX?=
 =?utf-8?B?OFNPWU5sR0hBNE0xMGFHVHpkakdOaE10K0NySkFBc00yMVpYRWlvanBNYU9u?=
 =?utf-8?B?SUJEdnY1QXhpMjdLY0c3ck5DYUx4L2NaaUlvYnNrTkNiaCs4Y1BzVFQwNjQr?=
 =?utf-8?B?T3puanZyOGJ4c3ErU0RUYkxyQVlIR0NCWlo1NUtFRVQ4Q2tOQm9UOVZ4U1BT?=
 =?utf-8?B?Vm8zR2d0eWprZjlpcE5zVkVDcnlTOTBnaWNMQ2U4aEVhQ2JSZlJKSlYvQ3o1?=
 =?utf-8?B?ZnFOWThxR2VsQkUzZWowM0I0a1c5blFKRXdNOVBWcjVOQUtFOVBHcTRNRkp2?=
 =?utf-8?B?NC9hd2xUZE9JYm05K2dNaGFyUzBOSTlLUHJqdHR5U29XQTI5MDJJdGRhbzd6?=
 =?utf-8?B?aENOZ1JUZTBvYnRDQmFnWk1EbW9YKzA5OG15M0NkeFc2U3BNaVAvRk5MNEZx?=
 =?utf-8?B?aXgwY2ZuYWJONHVJMFRDbGZOMEU3STNIK052OEFSeDZNdCtMemJiT3BzZ3NV?=
 =?utf-8?B?clNUclN4Ymp2cTdOOHFrR295aFJvSVJ1a010Snc5bERiMDFLUVVrQ21hT0R1?=
 =?utf-8?B?bGZHd3dFaWdSZVNuRDBjU1NDT2ZFMFNXWVZ4Z3cwOVc3cjJQTU1aSGY4UE9t?=
 =?utf-8?B?QWlXSFNBY0VpeXk3TitSMmw4MHpHR1IxR0Z1ODNQakc2QVRWRHZ4MDhFMnAv?=
 =?utf-8?B?MXdjemswUmtrYmZxd05pQkhQWnkyOFQrRWVJTGJaTXVQT2tmQ0R4TFFsdXdZ?=
 =?utf-8?B?dmtPTDlvVkVOTWlHdjVzQllaNU56TTRjWFZGT2lwc1JPcG04RE5yK3FEcDBK?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e4a35c-7434-4d0b-36d7-08ddc8ae6574
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:29:11.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PofH6iLszm82STVDWaihMJCNJE+veqdCp3Dv2a+aoJE7Kj/FBOlMstMwRU/dva4vmcjKlf22PTO5RlXs4zpNo8nmoKBBzMqFOm9owg0TGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7255
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> Add the command line options to enable or disable the new resctrl feature
> L3 Smart Data Cache Injection Allocation Enforcement (SDCIAE).
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
...
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Could you please also add associated update to
Documentation/filesystems/resctrl.rst ? For reference, the similar
ABMC change:
https://lore.kernel.org/lkml/00cd603997e3ee6a389f83aef066fe7313b1abaf.1752013061.git.babu.moger@amd.com/

Reinette

