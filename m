Return-Path: <linux-kernel+bounces-741527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9470B0E550
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DA017F552
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF4A283CBE;
	Tue, 22 Jul 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhKFkwyw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847506F06B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219018; cv=fail; b=MYIE7/BiUsoOKiLwMhSGovGQY9EqN/RgJz54X4P/f686bPpZFy5gU2RQLCwD+hrHeMiysZ2HcSVzbl1h3IlBimqNIYvrLs+o4lQvBuI+IonJxVZmnt/yrKcFQ5fq9VFK+kepBiTIb4zxvWdou5S9cUPInw3CSB16WLb9pnr+CNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219018; c=relaxed/simple;
	bh=H+1/a3P1ldzyt/tGqcxoYXgDAlp+sYLCX5qRvjKlCpE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jOj71SkCv1sVsPf2/Eljz9HB40wONuQGfQJkuQvm4vyG0UoZE+q6oPyC18AhKPZPD8jiI20Zf8aQCaXSjhbuHDsW41EsgM5RsF6nMikFC9o2HvshtSet5PNivDTbLYRio7ZdcTdjaGtH4W4T/aAGBluZd/bYamFhGHaoOnsA+UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhKFkwyw; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753219017; x=1784755017;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H+1/a3P1ldzyt/tGqcxoYXgDAlp+sYLCX5qRvjKlCpE=;
  b=mhKFkwyw82NZV+/KA8o2QnfcHulHPOLRnHO2bxAqJ2fIXxUwCmQNKZue
   Axw/oFptFHVcLK9wGJSPw7bV8Y5C+80yQOqBB6thYP6VdrY3j7WE+tXDr
   FRO2PC9mLo0GTVbIylIsp6yPdtgZv6yVw2gcaZJiICs2qe9bSc9uUl8jZ
   OgKh+lYcCmDKe0mNaBZBebdPaEN8AbPGKtE2A1ETWCjZ9/QaV/s2yawBY
   MA+DE4f7VpohZ3Mn3vnMFSdkbx8wUCMLJKz1quWja/8ZTrreN+StRQYqU
   rnleM1K7pdhFSiGhGRNHtgvtemd0sCzvGvy5htwyRtHZSqGSXZ4UmM2dB
   A==;
X-CSE-ConnectionGUID: eUnMLcjcR6GQIh1J0uLbPQ==
X-CSE-MsgGUID: 4U+A1ytITZyxhIT9Ltg9FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59143419"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="59143419"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:16:56 -0700
X-CSE-ConnectionGUID: 8nKKHuukQYyEJL0KsApOQA==
X-CSE-MsgGUID: 4hHEm+IwR2WGN6b/6BHpSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="159296510"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 14:16:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:16:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 22 Jul 2025 14:16:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.64) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 22 Jul 2025 14:16:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+05OLBHOKY5kecHAhRRl1SH2aSnMbya9xnrzi4EoRluxsccFL9WephI87lqJkaw+ZX98xRvIMVag+pT0jI0cDdW724TgBjyOEdXX4O6AhBKwJCoIkwGMuCqsvawUcy93Z+FQ3GppHMklrTrYIZH9q+C/83SiF1MI+GVY7m/ISZci8pxXbRBOc8iAu9jzPvV53zpkG7dJqWLG/qhCb9CbDVnpb8BLjF3gU33bv63oVVIZyqYC28U/6ra2shS1jU5nLnPeARYEUes1zm4b0tGweydMUarZ0tzA0yn2ay5xYkypkAX51OiiDKa3hTG2rKKB3a73vWnKg4wITrQfwc8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQqZXD7XT4PqdD3zPmw8UMD8ZUQ3CPRwDsA2A0CUouk=;
 b=kYiYYKSH/WM8gLZ5ELErYUZG4rBWw/7hFuwmKMRmaXiDZlKrzlUeh7iq04nvdq+xbQr6Mz/nSUcTjiS73Bc6adrcmhb0zCHIVa33EfLJa45TWuDgYSQf01bz7lokE812TT4JQ08mG5QMTGBIZDYe/IvGwjJrI4Blr8QpeH1dvKP1n/j0rQjZlshqwpUUUWKL7dX19yQ1Zm8rLeXeD3EEX7Kz9NHBxV0uvQw1o8mFXVYMPDuMewjxIqwDw/rBOVzyXvr4zGqtWhP5NBFEkZl6YhA/LFHXA1hWWuyptZE1iCPsb6PjXincliegGjeLAUZC9oTGPTVmYfG8xZFgdgrwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7735.namprd11.prod.outlook.com (2603:10b6:8:dd::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Tue, 22 Jul 2025 21:16:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 21:16:38 +0000
Message-ID: <2249977a-e291-494f-8c84-f16ec9fba10b@intel.com>
Date: Tue, 22 Jul 2025 14:16:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: avoid divide by 0 num_rmid
To: Barret Rhoden <brho@google.com>
CC: Tony Luck <tony.luck@intel.com>, Dave Martin <Dave.Martin@arm.com>, "James
 Morse" <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
References: <20250721180051.3645697-1-brho@google.com>
 <c4518fe2-dce3-46d1-8d79-cd63377bdcad@intel.com>
 <dcc38ba0-cbb4-494e-bc10-2df2b4aa2cb0@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dcc38ba0-cbb4-494e-bc10-2df2b4aa2cb0@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3df044-8f40-4c57-8881-08ddc9650b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHV5WG5lNklwWHdNZ3U1VktFSmV3a2puSm5rUUlmRTVHM3E5d3o3UlVqZmVL?=
 =?utf-8?B?ZVVVZSs2T0w2MHg0ZFZ2bDlqZnVvcDFycHpjR1Q3dXpIZWU0eC9xWXpLcThC?=
 =?utf-8?B?THB5ZzcyeE83UmxxaHh3UmxTL3VEdHBhSVZEVlJ3ZEpEV2dzVVlmYTExWjFn?=
 =?utf-8?B?ZEJYcDBSSjlSNkliTW5VUXdTNXp3UnQvajVpRlNZRnVRamkxdzZ6UFRFdXo3?=
 =?utf-8?B?VlNERVdyV3JuWTVycDkza3dQeTZqeEgwT0hYbXJHRXZGRzJobTVmZE92MXd5?=
 =?utf-8?B?VDd3VWlPODJCSjhWdEFGZXlJZEt4azlUdDV3YUFkSnFKdHJDTmhaSjhCendV?=
 =?utf-8?B?Y3c3RWY2UlIvdDd4a3R1R2tRY01qNFhaWk1KUEVtZjVpeTU2TmNDOUZpTk5L?=
 =?utf-8?B?cVo0eTZrMFBEVVlXcjF2T2NXNjhlL0JNaDdseGpBZldOM3RsSjEzWjFwYW9E?=
 =?utf-8?B?TGgrRlpJTmgwM0VOUTNzMEFWZHFGRzltZkhMZ2NseDhPTDJTenBFU1hGTzAx?=
 =?utf-8?B?U3pROWVJbTZXVU9sNlhoc2xRSWFvdWdTempCQ205S2xOU1VnYVlJbzZYcE54?=
 =?utf-8?B?S0JnU2JDWXlyV1J0N3R1cmxaNkJjdnp4RlM2M3BFLytwcEZHejhkTExmSmM4?=
 =?utf-8?B?T2xMaGNtNi82M1FCaFN2TEZJclRkTStrSFpOdVhtUHJYd3RKYXJHUVk1alhH?=
 =?utf-8?B?eGE4aWZsd3EyZmprY21BZFpHTjNJYk0vZGRrUVZQbTBDN2RMUmlrNkY3Q1Ew?=
 =?utf-8?B?N3lBbENXVkJlR3ZabFN3L2duQkFUN214d2d5c0ZzZzRISmR4SjBEQ1oweEI5?=
 =?utf-8?B?d2V0VC9zR1czcnR2a3l1eFo4cDNIOGdpbitRVE9sS1VPbnBOUC9QeGZzK1Fj?=
 =?utf-8?B?UEwzNlZMaE54OVNoQjdHMysyYm9pbTIvU21XdWZ5d1JZMWhqekRjaERxRWJp?=
 =?utf-8?B?cFhnTllueFIxRWFhUjVIWTJwNDdKaDJYZnE2bGRCSW53bkI3QzJGTFZJL3U0?=
 =?utf-8?B?Vi9sVU00SytqY0hCUk14eUtnZEkybEU3ZmFEaU9xSUZlUjlTaDFRbThGakZU?=
 =?utf-8?B?NmRRVVdKZlZ6L0hEUUtrV0RxRUxRZStRNWoyMzBHOGYxMXNibmR2NUJUZ1ZV?=
 =?utf-8?B?OU81VkM4UGE1dFJWNG1DQXl6QWNlSkVJdlZMZzdMRC9Wc0dvZmNCYXNETFEw?=
 =?utf-8?B?VWRaTG1CYkQ2MzM1YXUwUDdsOEx2OGlxZ2tPdGE2Uldsd1RramhuRzVrN0l0?=
 =?utf-8?B?Q1FPU2o1QnYyN1haeXNRTytGQnI3NWttUXBSYVd5YlBRNXVjUXFyQWMwYXJw?=
 =?utf-8?B?RFM3bXJyNW1qbWRoMHVRY29nNHRjcllpWVYzZk1WdXNZWlc0ZmdVeHR3WTFO?=
 =?utf-8?B?ZGNxVlNYMEF0a040VENLdmJMQlFqT1BMOHZaSWY2OGoxSmppOTRheEd1cjRW?=
 =?utf-8?B?MDc5WWVMZlZkWHBhbm9ELzBtb29XaXh5MmJNUkc2cjFPK1FnT1RjcHVvUTBO?=
 =?utf-8?B?TUJWbUxtaWF6SjVZQ1l3R0tkLyswVlFXSGRRU2dUOGVnSmRlK0syMVlzLyt5?=
 =?utf-8?B?d3A5a1FxZFJhYmVzK2VlTUF6ZEdzZ01rQ1pwUnV4N1lhMzlxbjZSTG5zK09p?=
 =?utf-8?B?NEZpY3M0TWVEa1p1bDNVK3FxUTFwQ2xhTjhCdk5MVkVFVHcwMXkyZy9TTUxn?=
 =?utf-8?B?eDNUTGtiUm5nVjB3TmJpTm5yVEMwR1BwK3JSYXc3bWdLcWtIMUJKUTF1amNT?=
 =?utf-8?B?Ujh1bkhzeWphWUtXVThYMWZCZXFjYVJITTFjQjI4K3NXakE3S3pmbGhoN1hP?=
 =?utf-8?B?WGVkYkVXdlJaM3kwNC9FT0U4S3FLVGhMSzZVY3k3RFVjRmJuUXVoelpzamZo?=
 =?utf-8?B?d0FuSjNFSzFvT2JCSytOY0g5Y3U5bmlxaHliZG5Fc3d1SkY4VTBIUWYvL05r?=
 =?utf-8?Q?WMmyqiCgbqM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNjN0duc3lQN2hoUlRKRFlJSjVIU1pLMWMreGY3MmdVci8yaHIzeEMzNFNn?=
 =?utf-8?B?RFc1Q0Vja0c1cXFGdmczZ2JEVldxVmx2VnArb1FySk10MDNhc1ZjenduRFo3?=
 =?utf-8?B?ZlpUNCs5UEQxS2prNGJIWm5BREtrWTJPZ1k0NzBzS3BZTDIwRERzOGpZMHhm?=
 =?utf-8?B?WmhTdDdQSXhseXM3SXhkTmpOWTc5T2lJemF6aVV1a0syWFd2UWprRCtBVjNB?=
 =?utf-8?B?SHZxZ3phVGxvSkdrclJuWnAyRkQ3TUFGYWg0K293eFlXYlpMc00wYVp2QlFu?=
 =?utf-8?B?eERWY3E1aG9OdnR4cHM1am4raVN2KzliS2t5Zm5uMWwycGkwNnRzenVTcG9K?=
 =?utf-8?B?Mm5ERjdaZjdteVJxeGVNbi9EV0NlYUwvb2cyTGxvOUNFL3NWZ1YwZlI1TlJX?=
 =?utf-8?B?WnNEZEpXQ3lyY09hNVlZNDlwZGlwUnhHUGRYbk9vSzBMaDRlYm9SdkRKRmx6?=
 =?utf-8?B?U2xsaUlKRis2bFcwM1MxSFdwK2tRUjZSYjZFTmVFN1VTLzFQcmlNZHhpSFZR?=
 =?utf-8?B?Yms2ZjNHQVpMRDkxVC9HaDVnK3JhdjFuQ1dyRGJocjFOa21qMStQaEM5RG9v?=
 =?utf-8?B?VUFzTVV2SzNFQW8zdDBoR3owTk0vbmEveGo5SnZmRWEvR1U4NzIvdDYreGpr?=
 =?utf-8?B?blo4N1VxU0FwaXdqbmdHZTNNTTdRVFFkSWc2WlZqNG12bm15L2lxZmlnR1Ax?=
 =?utf-8?B?ODhnbmhESVFzR1dHZHJtYkJ2bG9Ib2NsMzFQdWR5SS8vaDNRM2lMcll3YUVj?=
 =?utf-8?B?VEV2bmkwT0tMb2htRDBUTW5CYWR4SHBIUlJGNEwxcXZseEFOelRqUGpQc2tK?=
 =?utf-8?B?M3VpZlFNaTR4RldreUpyM1JiUURWd0ZHeDVkdzhZcDJxYWE2SzdyaUdNLzBS?=
 =?utf-8?B?SDF6THRRSnlZMG8wZE5BT0hEYSt3cU5qbGlWYjBRSzg0c3VscUxnNUtjZ29n?=
 =?utf-8?B?Y2ZOUy9FVmNaaGVmOHI5OXRiTkx4VjdpMDdqb1E2WjdDSjJZS2pMVHJIZElB?=
 =?utf-8?B?Qm5QUklwSkJIOUl3TzFNVjhtdVpQak1DU3VpMkU2TW45eG1XY2drVVJtRzZ4?=
 =?utf-8?B?TTRFbzdYMTFDb2ZsZ3RIa2RpR2E0YkpBcUJkM3FlUWFoNG1wclhXYnV6c2s1?=
 =?utf-8?B?WlF6MDFOQkhxb2ozVFFIaktKemM0ZGMwMndKeXFweGEvV2FJVzB0UkdFeXY4?=
 =?utf-8?B?clBDMHVkakVXTGlSeUM0a1ZyUHJwWU8zTTltak4yZitWNXRFUTF6aHdYWGlH?=
 =?utf-8?B?Zi9YWHYzblFHVzNsbi9WeUFaSVliQmRmNmpnUjNDSzFoeFBkZU9TMUpiVXdM?=
 =?utf-8?B?YlVNeVkvN2FCbGV6OUlwZitpdFprc1ZXc0I1a1hHZkFGbnFLZGNlZmxWbVVC?=
 =?utf-8?B?QTZOdnZKWmhHYTdObUJ6UmtWald0VmZNSExqVWgvYXF3TXFlUlJ4ZHRkVmdy?=
 =?utf-8?B?OWRVS0JxTUFYTlJrV3hpRS9hZGQrRnY3cjN3Y1ZoSm9McHNtS1RYc0srWC9i?=
 =?utf-8?B?dWRsc1Q0L3BZSWYrMDV2Y1ZCUmFpYTd5WWY1aDRvWTlZT2tCZnBuY0tTM2px?=
 =?utf-8?B?dmwyYkFCSTBHVERUODdDczVKd1dQMmFGTU1kcXh3UnV4ZkZFTTNkcmdENGJG?=
 =?utf-8?B?bHhEM2xLandZUU43blkwWmkzckR6cDJYM1JZUmtpSjN5NFVkd0l3NEZ6QWk4?=
 =?utf-8?B?VWY2UStyTjZVOUN3VEpnN21aL05FSTUycUlSYkl4eDNYaWNwd05QK29iRlMv?=
 =?utf-8?B?REhOaEo5TUp3N3E4VGY0c0JnT2Fqa1dSSWtnTWNFY3NVNm9OSWtCcEQvTmln?=
 =?utf-8?B?NGk1TEtiL1V1VENrN0FVRzVLcC9ZN1lXZHNCeEE1UnR1c2FwdHBLVTI5V0lL?=
 =?utf-8?B?S0dEWHVJR1ZWTzVPMkhsMHFzY2hQaG1QSVRkYUpCckoveHZsdmp1NFJPMzNL?=
 =?utf-8?B?UjBpSGROSXpXMVRiSmZVNVJmRmIxMW81MWQ4bWxmdGpCTDQ3NDBFS2ZjbU5k?=
 =?utf-8?B?MmF2K1N1T3Mrd3d5ZnRPWlQ3WU01clptZjhZNm5FeWdQL3ZJU2dSTHpZNWNR?=
 =?utf-8?B?L1h1Y005bHRlK3czUy91UnFkOVFTQWdZL1JtWmpSeGs5MWVzZmFoa0hSbkJP?=
 =?utf-8?B?c1ByZko1Z2xJTGY0WTRsSXZQU0lsWmpEY1lQSDlOQk5ZYTNDbHFnSEFESDFx?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3df044-8f40-4c57-8881-08ddc9650b5c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 21:16:37.9590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0uN89vswqQf+e03vvBQtOutJ6Q2rTsBYuswDJJRH+g+55/8KWa6Y7pOokkW681digWje2usSyJovnCI9tVszLQ8G0wZobJyrZJGVCUrr20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7735
X-OriginatorOrg: intel.com

Hi Barret,

On 7/22/25 11:51 AM, Barret Rhoden wrote:
> On 7/22/25 2:19 PM, Reinette Chatre wrote:
>> Hi Barret,
>>
>> On 7/21/25 11:00 AM, Barret Rhoden wrote:
>>> x86_cache_max_rmid's default is -1.  If the hardware or VM doesn't set
>>> the right cpuid bits, num_rmid can be 0.
>>>
>>> Signed-off-by: Barret Rhoden <brho@google.com>
>>>
>>> ---
>>> I ran into this on a VM on granite rapids.  I guess the VMM told the
>>> kernel it was a GNR, but didn't set all the cache/rsctl bits.
>>>
>>
>> The -1 default of x86_cache_max_rmid is assigned if the hardware does not
>> support *any* L3 monitoring. Specifically:
>>
>> resctrl_cpu_detect():
>>     if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>>         c->x86_cache_max_rmid  = -1;
>>         ...
>>     }
>>
>> The function modified by this patch, rdt_get_mon_l3_config() only runs if
>> the hardware supports one or more of the L3 monitoring sub-features
>> (X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL, or
>> X86_FEATURE_CQM_MBM_LOCAL) that depend on X86_FEATURE_CQM_LLC per cpuid_deps[].
>>
>> I tried to reproduce the issue on real hardware by using clearcpuid to
>> disable X86_FEATURE_CQM_LLC and the CPUID dependencies did the right thing
>> by automatically disabling X86_FEATURE_CQM_OCCUP_LLC, X86_FEATURE_CQM_MBM_TOTAL,
>> X86_FEATURE_CQM_MBM_LOCAL, not running rdt_get_mon_l3_config() at all, and
>> not even attempt to enumerate any of the L3 monitoring details.
>>
>> What are the symptoms when you encounter this issue?
> 
> Linux crashes during boot with a divide error, and the splat backtrace is in rdt_get_mon_l3_config().
> 
>> Would it be possible to send me the CPUID flags of leaf 7, subleaf 0 as
>> well as all sub-leaves of leaf 0xF?
> 
> # ./cpuid 0x7 0
> CPUID for Leaf 0x00000007, Sublevel 0x00000000:
>     eax: 00000002
>     ebx: f1bf2ffb

Looks like X86_FEATURE_CQM_LLC is off.

>     ecx: 1b415f7e
>     edx: bc814410
> 
> # ./cpuid 0x7 1
> CPUID for Leaf 0x00000007, Sublevel 0x00000001:
>     eax: 00201c30
>     ebx: 00000000
>     ecx: 00000000
>     edx: 00084000
> 
> # ./cpuid 0x7 2
> CPUID for Leaf 0x00000007, Sublevel 0x00000002:
>     eax: 00000000
>     ebx: 00000000
>     ecx: 00000000
>     edx: 0000003f
> 

Thank you. Could you please also pass on all sub-leaves of leaf 0xF?

Thank you very much.

Reinette

