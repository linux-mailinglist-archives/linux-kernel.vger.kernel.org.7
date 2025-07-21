Return-Path: <linux-kernel+bounces-739989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B842B0CE46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82FF17ADC54
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C2A24503B;
	Mon, 21 Jul 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnHzOzNb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3554723BD14;
	Mon, 21 Jul 2025 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140964; cv=fail; b=kq25e8FDzOQan8AJPo+ZO/uxe1jnM2WP4jYbyksksJEm+kHphHz+oiXRYKdAsjTejBDR8yj2zB0xYKAet6U3Vbg/KLvDcG7xHO+huH+kokFbapYB1h/HAf23To+TEWg9lv6Z2e/1L7s6RsR7M5E39ysMgRZFGGd7VaNV9XtgrRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140964; c=relaxed/simple;
	bh=rvpJ7E1W1vo10BSKxT0yWEolkifVXaGbus4B0IH6wlo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q/QNw5O+rSCYRJnXJPb4I7wUCZEzkmlRyLX4ubGy0+e85oku0Amvaw0fqk6D7e5WcoGzeD8lFgzF1P4lbN+6IwQCDdUQrSjrtGrZGFOsrJwHF0YzaIG3XZyZ7wCEzgx9gPnRFSUqi7SsVgd9bWtEl+T+jUhBK4QBvIwWBskygtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnHzOzNb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140963; x=1784676963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rvpJ7E1W1vo10BSKxT0yWEolkifVXaGbus4B0IH6wlo=;
  b=OnHzOzNbqjV1Jq5EdfGE1+UGt2WskO3UT+GzoB6oHtXOlcJwaR+OdKmJ
   AXhfrM9VXh4g/grsdtaJ07DS6nBqPlsn9Y9udU7x9C83tKR5uuK8lh1UL
   Tv/He15NJjdgO0YyNqFXCAo1XHzEnC6yMTMAuESyfW7H+p+1wPJRo1iey
   7GBYb8uG/HFszXnb9Kq7Nk+NzBlJulEsDgBR7GCxRU8m+pTMfV3202OAn
   0VQkf1ZOlCBBZSFCUWICjQI1KEYVoGi+EbmZdKOCbq63YEq97eVc4MxBb
   mnvn/7gZ0pu4NfHmvHrOB7hJEj9Vl/dT1/PDJVxd8qfR/V8+yOnHJX6/w
   A==;
X-CSE-ConnectionGUID: kqbhzjuTRV6VxdPNsxNcKQ==
X-CSE-MsgGUID: ceCUnx0oR/yXkNE/SCyuBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59033939"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="59033939"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:36:02 -0700
X-CSE-ConnectionGUID: uRJH7DYPROKiKZdHHtV53g==
X-CSE-MsgGUID: EjSQFMO0RMGJFSAhlU59Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="164637545"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:36:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:36:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 16:36:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.74)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 16:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov1YilCxpmOcBAtDBXsST1fiYfpkrIVb0zTJZNlj3OTLpVUW3OujFjrW1sroHx2x+kBoiNjsGPDCIaHJF/X3zUS4+3VG3ezpz+4R6b1G5ELKDE+ngxmPhhoPOJZoHuCRuYuKEg/38LVWq/Z52WBeOkAEyWzfkZn/w8+1YWopUVvY7qO7YLA/EmTref1st2vHxPZFoPjTTePPjJ9llZlzjgwfoSQVf/J46QjiqxjAjC4L0J7Vd/DHDM/xyvrNHSoBSUE/J5ufVtVR8fN1LXVctPvG4bKPoU55+gEbs6yGg3chnDmmLBVpujMxjLyUCent//U1aHs5ZRzy/GUdJO/MlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW3QyIjlahOqnuQ1TVK/39lO/eADKuL+7wwJMU1xWbY=;
 b=cBERxRN2iXFnd3dvQZM1N/hIlhsN0B5l61j6pkILj8gVQrBVWhuvO1eR/oLaB6IyZ2Gax5yqKZzujRMT+70vyRDg/Naplg3g/42RGUw5n+Wa5BVpbf1Qj4UuUxcU6rRjnIplGOKmMJ0b52TakKMm2OBhkTB+X88ZJblXxV7ozmB8rVq3g8Ejt3GWzCpI7dBRq7+hfJNi1sE45HfE6i+s8rBUlSYNE0B9vkv8JhRXi1wyfT4PYSKtRIeK4vw7Hmb47IGHQWEvnRLcvbLJALIxDcSP3YJsxOr88x/i94bsDxovJbaM+vNGkU1V8jYcCJOv9k4NQspW0NgWEo7XUyOe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 23:35:18 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 23:35:18 +0000
Message-ID: <94d075e0-6703-449f-9c0c-8e5973349dff@intel.com>
Date: Mon, 21 Jul 2025 16:35:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] fs/resctrl: Update bit_usage to reflect io_alloc
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
 <87e1a53201f3e539fc917a5d901f09bce432f720.1752167718.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <87e1a53201f3e539fc917a5d901f09bce432f720.1752167718.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6249c3-c81f-41cb-3cf6-08ddc8af4080
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWxkVmR1Ny9uc0FuQ1dkRVpFamtaTkYwdDFWNjQ0RU56TktaYXBIby9pTWtQ?=
 =?utf-8?B?VXNlcVp0ellNUG5KUllweVNnSndDQkRnOVN2MmVpTzdRRzRGQkJKWk9sYUdo?=
 =?utf-8?B?dXM4TzVCYWpmK0tpdnVHOEY1TnBITFlKMEdzQWFmRWpJTmVtb1RmbG5TalRv?=
 =?utf-8?B?YU13NkRUUTlHY3pxU3BuakpBLzhoakFKeld2bFVoS2xwekoyYitJUm40WUpT?=
 =?utf-8?B?TXRYRnFET3RRWWZ6ZWVQNitsdGdWdDNGY1JCMXcrSHVhM3FxSjJTNWpDNzlF?=
 =?utf-8?B?WnVqTGlHa2xSSWVYcC9zanROOEtwUHdJaTE1U2QzTTUrRHZTR2FsMG9TbThP?=
 =?utf-8?B?MnpWU2NLc3Y3QzdYeFl4M1RwLytna0kvWmozMzBCM1VNWHBXOFZDaXVtKzlJ?=
 =?utf-8?B?cVIrRWJYQ0lFTUcwT21MQVB5cFlXcGNJVkVLRHZNNDlhc0hNT3NJc1lGd1JC?=
 =?utf-8?B?aDRZaHBpbXhaVmVPVFByUFduYWNQSitKLzhValU5RlIzRTdYRSswbmxIM1ZU?=
 =?utf-8?B?VG92c2lQLzM2d3JYU3oyd2djSXNrdnhIQ1lpdTNlT3gwanI0Z1BERkI4ZkVX?=
 =?utf-8?B?d2JEUUFra2tKbktyZGtrZnFZQ1BRSDRKSTBrQlkyVkhSUk8xMjVod04vdTRk?=
 =?utf-8?B?Kzd5azdOcmJVWWFnTnIwWWM5Sms5dTlKdnRVS0hzTUNCVVMvSzNuZ3F1NGJ6?=
 =?utf-8?B?QjVHZDRoNHp0QlNIRVp2S2loT2I2MHg1MUtNZUZSRUpYZksxUzczS25JZnlY?=
 =?utf-8?B?d1JIenh0ZytMaDV3Qm4xL0FyN0xFK25RaW5QajMyMjR6ZDlsVU5tVE1yRWRj?=
 =?utf-8?B?dXkveXVCTjczdEkyS0pUbEtpMjh3YVZTaW5kdjZEbldzS0ZOK0pKNGpsVFNh?=
 =?utf-8?B?dy9laTRHTFEvUUJyOUhpYTlRSStFMDZyQStmY1J1cEVBQUZ5VGJJM2V3R3Jw?=
 =?utf-8?B?ZWt3c0xObkdpR29tbkx1R3p6WGFjeTd1THV5WnVHY0s3ZFY5TUlmTHBEZElx?=
 =?utf-8?B?TDJlOE13YVJtVytZV2ZmZk9xakJ2NnRiQUxOKzZrajJ3dC8xNHMxbktOWDJY?=
 =?utf-8?B?c21Jcnc5UmZ2V3V2dlNQOVVFam5jT0dUZk40REhhVGZIdE5yTit4Y2o0b0NN?=
 =?utf-8?B?TzNXc0M1YUVtRHpsMEk0d1dXZzB3WmF4OEluZDZVWUlkcCtFMjRFWW5WaGIw?=
 =?utf-8?B?UHlyOU4vV2JmbVYxOXFCRS9aTFFKR0t3aC9Ic3JLVmx6Wmh0dXJtVnRFZkJp?=
 =?utf-8?B?TnNXZWgyMmdkd29IUjBwNDQrbVppMyswL3R4VGtqSy9COG5uSllaanZXWnpS?=
 =?utf-8?B?VzRpbG5IeVN2STE2ZWh0ZTZ4YUtyVWRIWWNGMnhtc21GUENCNjlDVnRYYnJY?=
 =?utf-8?B?d3oyT2NtY20wL0JpWDhCcGxZSTVHUGxDWU9TcWU4dnoxTU1WOG1OVk5YRjE4?=
 =?utf-8?B?VVZ1ZDZkK01xTWNCYjlEVXg5YmJwYVlmWng3VjBYVEhGSzVoZlAxUHR4U0xl?=
 =?utf-8?B?bDRtd3I5N2lKV2trT2NSM3NoSCtIUDIwMm8vcDk3L0duSGtXM2RsK0hjSXYx?=
 =?utf-8?B?c3B5Sjl5SXpOekZXam1yMHFTTHRCSHgxaXJhbXJuTFErSzBtNkFORU9vRGpG?=
 =?utf-8?B?SlJIWktKU0pkelBrek9YQ1QraUxBT21SQXFqc3p1Q2NKYUU0WHJ1WS94RVRW?=
 =?utf-8?B?dThSQ0NmUzlWejdUMk1xVUF4YmlLVFFnRUd5OSt3TnhkMVRnK2VWbURJeTA2?=
 =?utf-8?B?K2VwYWN3djRQQVgvY2txeU95SHcvdDBoWUNYUmdncXVKM1pCc1V1dTdWNWNl?=
 =?utf-8?B?MWR2NjZLMnNLOVNpK2t6Y3RpN1RNR04zc3kxM1pJQWdkbUUvL0cxazhFWUll?=
 =?utf-8?B?dEFsUFZZcTBBc2g3T3JZVFB4TktRdXJrK29iQ2lHTkUrTjlXT3VGMmJwZFhI?=
 =?utf-8?Q?jJ20K5M3JwI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnJrMXFXbUN2eHlDT3pOc1RONWp2WXZxejBOYkptcDhtdmpWNjhHRXVJYTND?=
 =?utf-8?B?YVNQRWZQdWx0SjA1SnBySDBiem9YaHFaNllNeTdweE5BNkxyYSszV05mYzdz?=
 =?utf-8?B?bHpub3lNMjdzWEFwYit1aFFUV0VCVXU3eUNsTXBqZG9FdDY5Wnk5cHVjTTJw?=
 =?utf-8?B?TDk4SS9QY0J3ajhGck5yMkZjeGpEOTdyV2tDTmZRbXNBMVpvOGZXNkt0RUtL?=
 =?utf-8?B?cEtUUzRLTG12aE1FLzFaT0xUR3RKMzlSSFQyeUp3Rk4rU1QyQjB1NXFEV0xI?=
 =?utf-8?B?TzJlVjc1YWFLdXlibDlvOWtQRVNta1hMSXhsWHVrNi9DZ3l3cXRuZHRkNkZm?=
 =?utf-8?B?WFZLU1lENnhOaFFxN3hDS2U5VnE4eSswc3dvazZLdDhBRERoYVc4b3pvd0xM?=
 =?utf-8?B?MFNnQVNmMkNEMDVMV2F0QWlaMTJwbWRjdEdvNFEzT3h5ZUpQdWdQdFpLTFpq?=
 =?utf-8?B?OXhCRjVueFF0aFVqUTBaUU5YTzNJUGRCQ2dwU3pRNmorNS9oL1RmZDVzVU9w?=
 =?utf-8?B?Q1VXREs1ejhUdjRQWDlEUTUvRXFvVzZySndna0phWDFSdEtGYWhHdUdSRVZK?=
 =?utf-8?B?dlBTMjlTWVNvdkw2ejJDL2pSRHFjYVdjNm1wb3ZVNmZENklIN25LaXNFRFo4?=
 =?utf-8?B?YlZjQ2hiV2dNVTJ5cWp3dHRMMXk4NUhCazBIRXg5TGJZaXd6T0M3eGtkcS9O?=
 =?utf-8?B?YVJjR3RyZ0h6SkV4OFNwK3NjZUFuMUdVZVB1UVBtdTQ0U1ljSmhNeWFUaWdv?=
 =?utf-8?B?STNHZTRWZTBLQnNUdWJPKyt4NFBMenVRdmtyWmp1T1ovMi9neldzWVAyMHYw?=
 =?utf-8?B?V205czZvemZkNGdLYjZBbTRGUnBlQ1RPOTNTeWJtRmZQTllVR3NXN01vS3VM?=
 =?utf-8?B?V1lpeEFDSkozL24rcG03NVJiUVJBWEMraERWWHZ3U0tDQ0VDMHh2Z2w4M1lM?=
 =?utf-8?B?aEt1aXFUS0RTeXZSa3g5UFNabFFwQnVqSXZHek5BTGg3TG1MT3B2cHhJR1pk?=
 =?utf-8?B?dmU0dG9nbDVkeVh5U1Y2MkVpek5NR0E2aTFzQnBCSTRoR0VES29pSVF2cjdE?=
 =?utf-8?B?dWpzUkt0TngrY0d5ZnB0V29teCt5SUJVU3RCcE9wTHNCMUUzdlAvdllTZlRu?=
 =?utf-8?B?U3poaS9sR2pXUEtpMWU1VUhTOUlMdi9RNXQxWWRydWdrRi94M2ZOQ3hmaEl2?=
 =?utf-8?B?bTRQOXRnc041VzlFeUI0d1UxUWxKR2VSZGh3U0hTeG8rZGE4SnFwc3p3bE5u?=
 =?utf-8?B?clJIallPblVZWEdJeXIyYXlZanlkSnFmeHJ0MXU4cU1QSUlqWWtlNjcxdnhs?=
 =?utf-8?B?d1dyZnRFMjB2elJ3am1ZY3pSMU5vVjk3d0E1aXN5OEttQjV5OFU5djgvbDRX?=
 =?utf-8?B?Wno3aG9LVlM2YUhoVEpFa0ZtaGNrczRwSWtnSUFmbngveEw4ZlY2TUZVZ1dZ?=
 =?utf-8?B?QnZqN1VmN3FSZVlvOHBsMVNodDYwS1F4VFg0MlYxTjNDMFprYVVXZTVPSVJq?=
 =?utf-8?B?YkkrdHd6WDBzbHljYnpYNnd2cXJUZW5ROWFmTGM2UFBRU2k5TE5EU1d3UEJ3?=
 =?utf-8?B?SlJ2YW9TMDlKeTVNWXNCUng2anRCakJ2bXdxQTVISURqdlRFR0V4Tldyc1hq?=
 =?utf-8?B?ajZ2VnJ3Q1F0TVdtbmVJOUFhT0tNK2dFSzFScFhtZEJpMVlLQmFFdG96bFd5?=
 =?utf-8?B?c2kyNFhOc0gwQzVOQ3hENUVQdDdwNTVWbmVxa2hPK0h4VDNuclRkMTk5bk85?=
 =?utf-8?B?U0o3cE5EOS8xaDJTS3o5K2hwRTIyQ1pMR0xrSWRQYWE3RUVSVnk4VHE2bVRS?=
 =?utf-8?B?WTdiZzZ2QmcyWnY0UjlpQ1B5QmVKaU9FQjhzeHNwT2JjVFFxck10WUJOZWpG?=
 =?utf-8?B?MmVsdkdnSkY1cjUzRDZ2MTNGalRIOHg1TWJZYUJoNmtLMFBCdVk5K05UbzNH?=
 =?utf-8?B?WFpDMWhVVC8zZGlpRDdCUHY4SEEyYU1qRkgvQk8yMGxZKzFDQUh2L0k5cHZE?=
 =?utf-8?B?THNuUFZVbG1OaVo3ZERTdU9HdWUvUWlGdnQzZnBDS2NHTDUvZ3BuWnN4cURK?=
 =?utf-8?B?TVhvQWJOZ0xvNG5leDV1LzV1U1JubVJ1S0drWUpvMW14clFxV0FEbmNnWmtX?=
 =?utf-8?B?RlRXaFJ1NWR5YWZydEYwR0Mrc0d2SXk4bFRUN2g1SkFINWo3RGRxVm9lWjU4?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6249c3-c81f-41cb-3cf6-08ddc8af4080
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 23:35:18.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiTQG6fJQ/+EtZ12wTSuWvZMPr7BD7DiNsIJmebriy8KVo1vNPYgQz6+LUlFE8Gt6rAi2tSa7y0Mdnn25d+WW4hfVHr76qXgiA7nQW6JlR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-OriginatorOrg: intel.com

Hi Babu,

On 7/10/25 10:16 AM, Babu Moger wrote:
> When the io_alloc feature is enabled, a portion of the cache can be
> configured for shared use between hardware and software.
> 
> Update the bit_usage representation to reflect the io_alloc configuration.

This patch is early in the series but also relies on capabilities added
later in the series. This cryptic changelog leaves a lot for the user
to decipher. For example:
- How is the "io_alloc CLOSID" chosen? This is mentioned in cover letter but
  not here. Doing so here may help explain the hardcoding of CDP_CODE done
  in this patch (which seem unnecessary, more later, but a lot depends on
  changes that follow this patch).
- No mention that when io_alloc is enabled then an associated CLOSID will
  be allocated. This is done later in series but assumed to be known here
  where rdt_bit_usage_show() implicitly assumes that when io_alloc is enabled
  then the "io_alloc CLOSID" is supported AND allocated (otherwise array overrun?)

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v7: New patch split from earlier patch #5.
>     Added resctrl_io_alloc_closid() to return max COSID.
> ---
>  Documentation/filesystems/resctrl.rst | 20 ++++++++++-----
>  fs/resctrl/rdtgroup.c                 | 37 +++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index c7949dd44f2f..c3c412733632 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -89,12 +89,20 @@ related to allocation:
>  		must be set when writing a mask.
>  
>  "shareable_bits":
> -		Bitmask of shareable resource with other executing
> -		entities (e.g. I/O). User can use this when
> -		setting up exclusive cache partitions. Note that
> -		some platforms support devices that have their
> -		own settings for cache use which can over-ride
> -		these bits.
> +		Bitmask of shareable resource with other executing entities
> +		(e.g. I/O). Applies to all instances of this resource. User
> +		can use this when setting up exclusive cache partitions.
> +		Note that some platforms support devices that have their
> +		own settings for cache use which can over-ride these bits.
> +
> +		When "io_alloc" feature is enabled, a portion of the cache
> +		can be configured for shared use between hardware and software.

To help distinguish how "io_alloc" is different from "shareable_bits" this can be:
		When "io_alloc" is enabled, a portion of each cache instance can
		be configured for shared use between hardware and software.

Please merge these two paragraphs.

> +		"bit_usage" should be used to see which portions of each cache
> +		instance is configured for hardware use via "io_alloc" feature
> +		because every cache instance can have its "io_alloc" bitmask
> +		configured independently.

append " via "io_alloc_cbm"."?
(but io_alloc_cbm does not exist at this point ... another motivation for this
patch to move later)

> +
>  "bit_usage":
>  		Annotated capacity bitmasks showing how all
>  		instances of the resource are used. The legend is:

Please note that this "bit_usage" section contain several references to "shareable_bits"
that should be updated to refer to "io_alloc_cbm" also.

With all these new terms introduced as common knowledge it is starting to look
like this patch would be easier to consume later in the series.

> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 77d08229d855..a2eea85aecc8 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1030,6 +1030,20 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +/*
> + * resctrl_io_alloc_closid() - io_alloc feature routes I/O traffic using
> + * the highest available CLOSID. Retrieve the maximum CLOSID supported by the
> + * resource. Note that if Code Data Prioritization (CDP) is enabled, the number
> + * of available CLOSIDs is reduced by half.
> + */
> +static u32 resctrl_io_alloc_closid(struct rdt_resource *r)

Please move to ctrlmondata.c.

> +{
> +	if (resctrl_arch_get_cdp_enabled(r->rid))
> +		return resctrl_arch_get_num_closid(r) / 2  - 1;
> +	else
> +		return resctrl_arch_get_num_closid(r) - 1;
> +}
> +
>  /*
>   * rdt_bit_usage_show - Display current usage of resources
>   *
> @@ -1063,15 +1077,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
> -	hw_shareable = r->cache.shareable_bits;
>  	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
>  		if (sep)
>  			seq_putc(seq, ';');
> +		hw_shareable = r->cache.shareable_bits;
>  		sw_shareable = 0;
>  		exclusive = 0;
>  		seq_printf(seq, "%d=", dom->hdr.id);
>  		for (i = 0; i < closids_supported(); i++) {
> -			if (!closid_allocated(i))
> +			if (!closid_allocated(i) ||
> +			    (resctrl_arch_get_io_alloc_enabled(r) &&
> +			     i == resctrl_io_alloc_closid(r)))
>  				continue;
>  			ctrl_val = resctrl_arch_get_config(r, dom, i,
>  							   s->conf_type);
> @@ -1099,6 +1115,23 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
>  				break;
>  			}
>  		}
> +
> +		/*
> +		 * When the "io_alloc" feature is enabled, a portion of the
> +		 * cache is configured for shared use between hardware and software.
> +		 */
> +		if (resctrl_arch_get_io_alloc_enabled(r)) {

Here is undocumented implicit assumption that when io_alloc is enabled then
the "io_alloc CLOSID" is allocated. This is also outside the closids_supported()
loop which adds the other implicit assumption that if io_alloc is enabled then
its CLOSID is supported by resctrl fs. None of these concepts have been introduced
so far and is not mentioned in changelog.
It is not obvious here that an io_alloc CLOSID must be supported (this is just
something enforced by later patches) and also not obvious that an io_alloc CLOSID
must be allocated from same "pool" as other CLOSIDs. Without a good changelog and
context of later patches this is hard to understand.
These are motivations for this patch to move later in the series and then the
changelog can just refer to these assumptions as fact, making it all easier to follow.

> +			if (resctrl_arch_get_cdp_enabled(r->rid))
> +				ctrl_val = resctrl_arch_get_config(r, dom,
> +								   resctrl_io_alloc_closid(r),
> +								   CDP_CODE);
> +			else
> +				ctrl_val = resctrl_arch_get_config(r, dom,
> +								   resctrl_io_alloc_closid(r),
> +								   CDP_NONE);

This does not look necessary to me. Why not just:
		if (resctrl_arch_get_io_alloc_enabled(r)) {
			ctrl_val = resctrl_arch_get_config(r, dom,
							   resctrl_io_alloc_closid(r),
							   s->conf_type);
			hw_shareable |= ctrl_val;
		}

Since the later patches keep the CDP_CODE and CDP_DATA CBMs in sync it does not matter
if the io_alloc CBM is obtained from CDP_CODE or CDP_DATA and just providing the
schema's type to resctrl_arch_get_config() will have it retrieve the right CBM, no?

This may also be easier to understand/claim if this patch is later in the series.


> +			hw_shareable |= ctrl_val;
> +		}
> +
>  		for (i = r->cache.cbm_len - 1; i >= 0; i--) {
>  			pseudo_locked = dom->plr ? dom->plr->cbm : 0;
>  			hwb = test_bit(i, &hw_shareable);

Reinette

