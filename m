Return-Path: <linux-kernel+bounces-848531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8BABCDFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC17546942
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29F2FBE12;
	Fri, 10 Oct 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cd2zPRmu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0F26657D;
	Fri, 10 Oct 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760114909; cv=fail; b=kZXfIO1t9b0wMTQQSSVf6zOcWLL4lG7ROm4lAHGiXSoWE6V5bHFW0f/yo2li0YkqJweG3zYtOiX0fZBVN3N52VeA8Oz39WlRQRhIHXOnsSUJhb0gBGRFsRc+lyw/WCblTO+O7FVplaHRj9JAFvNo0g6MSFcXoHAmytecEGwZwaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760114909; c=relaxed/simple;
	bh=w3m8aYEB9FkAkZ8jVlKq8J6Z2KGXEb15FNUfYnAItmo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FgK813yYO90ye3sr2M9PSsH/5ZWYlINXvN+L7SeE3BC+B0j68lSBDvpe1CjyEobpDH9pEI/VAA4eywZcKO6Tw7rK9ZNuhIWhd5AHofQHn/5XYuLV3w/AwZh/TuyxUfuJDXa1fcLVBqziIWgLhHdfFx6fBzFZ9s5NajvGoAj6LCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cd2zPRmu; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760114906; x=1791650906;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w3m8aYEB9FkAkZ8jVlKq8J6Z2KGXEb15FNUfYnAItmo=;
  b=Cd2zPRmu3nM9jwaqYZs2QqWk2hXre5PVqz1XGcDYfEGpHBkaIMfrod6Q
   dsZomwBobOksG5i9Y7WIh85zKwzUE53ol2fllFhYghpWvJe2nSc+lALbR
   Mk7u6CBSGfMESvbl7A7eLswijNh54vuRoin1807EdHDqhYD+KlG14GSao
   FTA2Y4WcEMB+Q24YcxWvXXTNXWc/zT7FRA2KDvG74sZBUtEBwehkQngEG
   jVRQQJyVF+wspnvV17ik387g154MEZI73qZLtAi4UMi6xje5ikly2pmKz
   mdiPdATrXEjHjjnohPpqenSVpwvbaAaUcUkZW9RLWzgNU578QI4A6ukte
   w==;
X-CSE-ConnectionGUID: hux+a4LlT1Wh6CZlZc8Iqw==
X-CSE-MsgGUID: N5C+q/ZrQq+mRfPg0qiYqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62257110"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62257110"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:48:26 -0700
X-CSE-ConnectionGUID: cRJ4XPj4StayGSdRvpPpng==
X-CSE-MsgGUID: IAGkXHSnRvus0dfjdOSuBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="181447661"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 09:48:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:48:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 09:48:25 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.61) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 09:48:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5DSSLjH0N+RvOPUvD6jZvrSdzEFo7BmrYuY+emlvNtVhcJaiZmvRULQo78bh0N3vxry97fjmUXEkbPrUxo0yRICy9sKJ6XRA02764HL7Cljj4L2mdQF73z/ZDnNXHHSXPN4Kfh4N9L5LBvX9qnW/m4iIRtJUm4q4YH29P2eletMeX4bKKAA7SzToBXmM1zFNY+gR2PiBwoeM8ueJRTnSfiAu5wPR7tnpWWRS94b1II2kJx3WRBHNqQnl5x6fm++4up+WZxCyg9C9DkbJ4N1JQRxU6upITsD2ELkuPemzRfJSxug/ipVR/+OwlaFaED4At2zH6PNJbqOYYdgJnhkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cb9lwrNGtyU8G7CB4tWSev14xn/yQe2fEXe9bMaQV8o=;
 b=HJx+7wuFo673EpbFJok7xUGTDaXRNzTdXpcC5RAlaD8kXeXimQMnnZmZfyfUc0A5D4v/TPs4M2eA7TAr5WacsodBXcW2fnD1Y20J6jxkBTS2i6gxo2A+AbsVe7PzKwH3O4MYzfF3jFx9mqXXHlsnCPfujl/1LcQGfmTFEd3Atbe+N3ZZRC6LQdtAwb2l1I8Pxhpk8gjmGiDDTIUxf7nOQBE65JhE363S5ZMqhIu4ZBpg27Jm1v2kerUJ1Ewp7GKRaKKmNEzG6ZcuSE+Ey4TXM9tbFpAzTK0syrSU3hTqNrLljWQc9PtXeq4GTM0/UiLn2Cuit8PX8U5x7Z0ioGMfRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 16:48:23 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 16:48:23 +0000
Message-ID: <1c4b6b46-16f9-4887-93f5-e0f5e7f30a6f@intel.com>
Date: Fri, 10 Oct 2025 09:48:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
To: Dave Martin <Dave.Martin@arm.com>
CC: "Luck, Tony" <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>, "James
 Morse" <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <x86@kernel.org>, <linux-doc@vger.kernel.org>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com> <aNXJGw9r_k3BB4Xk@agluck-desk3>
 <aNqQAy8nOkLRYx4F@e133380.arm.com>
 <d15d97d1-286c-4857-8688-4d8369271c2c@intel.com>
 <aNv53UmFGDBL0z3O@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <aNv53UmFGDBL0z3O@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0212.namprd04.prod.outlook.com
 (2603:10b6:303:87::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: a87159b7-d4ad-4790-6c81-08de081cd325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0JHc2paTUFSU3R2T0UySVpLZEJORGZBSXAyRmFmbG8vT1RUbW5ZOVpCcVpX?=
 =?utf-8?B?NVFFaVdaMWMveVV4UE1UQU1MOXRiUTF6ZzZZSU5DK3owVWVoRVBXWjFVTW9w?=
 =?utf-8?B?N3hnZnREK1pQUzdoRUhWTXZxc0JpMm1Gczk2ZUpOTDZuZTZOOXc1NWJzdlV0?=
 =?utf-8?B?VnNYMmNGbU1xNU8ySldZNml5QUhHMmV2a0ZkbHZvbEhzUFc3OTVsaXMrVmsr?=
 =?utf-8?B?NHh2WTZyOWRqa2xQclBEY25ySDAyWlZOUlkzdEhjTHFSNFpJcmcycExFaitK?=
 =?utf-8?B?UzdrenJ5U1pvcGxDNk5XRXR0bXhYb1NXUUx1enoySFNkRWhyMEVPWExUZTc1?=
 =?utf-8?B?c2lLRGc2L3JGUlBzMWo2NU0zdXo2dUJuSU9Ock9oRUJxdzhLaGxnZUlRYWNT?=
 =?utf-8?B?cEVIUmtaejdMbHlvb01YUmpxZHlxRS9IL3lnZ0FyTGRsVUVKREEwUStlTUJl?=
 =?utf-8?B?cVcvWmJwYUM2ZjNoR2E3Vi95SmRjVXR3Vk1tZ3dJZVlqa25rdkJCWVhjMkRP?=
 =?utf-8?B?Z3N3VTdRYzJEdnNyckEzZGFDVHl0NU9LdTNlejEwb3d0UFRiYTJXbzdkQTNt?=
 =?utf-8?B?eHRmcUhydkw1WmhjQ2xKMjJWa2ZCTzdteG4vb2FXUTJsZ1pYWkVFMVI0ZVUx?=
 =?utf-8?B?WnVSRmt5UHRZdnF5WmRQc0txR1RWbmtwMERsc1pSQ0JjcTlYUDVpSDVQVzBk?=
 =?utf-8?B?RXpCUmtkbHVmNlJZU0gxVUZkelVNbmRnelc3NWdsaWw0MGF0Q3RNQ3FlSWV0?=
 =?utf-8?B?M3hreVRxL0o4TC9xR1YzQW1BV0QrU0xLWmtiZkswbERKL2ZnNXZnUjZwUm5s?=
 =?utf-8?B?YUFhWHdvZllZOHRhQ1FsU3RIMUM5SnYrZkFlK05iQkJCY0JOdmxMV3JNRUFa?=
 =?utf-8?B?UTV4eng0RkpjSkI0R3RRSEsxVVdXYnk2NFByVjc4d2xpZHd0bzFvMEdpSGNL?=
 =?utf-8?B?QzU0b0FBZkQwbjFoQTRrUk54NDFnWnVvVUt3aHo5VlZuNnYzQndSTzhZdllT?=
 =?utf-8?B?dlQvaDNnbkp5alJkSlBGTmxMNFhidmNsSWlUdk54WHN4MHVwMUI0bU5YcVA3?=
 =?utf-8?B?Q3ZBQUlnWFpGS1FyZEVsMWt1Mk83L3BoUld2RGFhbExGY0hycUFrYjZlQkFo?=
 =?utf-8?B?REpaeXZuWjZpVTdMYmtBa3VyMGg2dE5hU3c5REtaeW9wTVJ2MmR5MndRck9V?=
 =?utf-8?B?K1M2R0luYStTMnVmN3plaGora3B1cVhHWmd2c1RGNDlvQWxUK3NDVEQrMVVW?=
 =?utf-8?B?ODBSdXdFVGVYRlovN3g1MVhVcURLTnRVTWpZbnR1aDRmUm92SmozbTdMSmxF?=
 =?utf-8?B?NXpYbFViSDJtVU1kZ24vS3p3VUtqd1dRd2ZnYng4bGo2SE84alZOWHovQ09M?=
 =?utf-8?B?TE1WT0ZwVDRjcVhQcERpSkpFVGZWTldLeFdXUU45a3FUQ0JodXZmYURGVzJR?=
 =?utf-8?B?WHVsWlZRRlpGV2JnZlFXN1JDRHVZdHJSTnFUSTJWVzlDR3NiamxSUmpFejVO?=
 =?utf-8?B?VWFlZDJoSnAxV2FsOEtKRUZORlZtdDJIb09GVVhqaHpnS1RMNzVDemNWYWFZ?=
 =?utf-8?B?STdhVnJzeUV5eGNKUmhnSmdIVGk3NWpoZEg4R0pKR21KYktpa21Janc2TEdD?=
 =?utf-8?B?K0dJNTJoUEtVeHNLZ1pGZjkvcXBOWHo2RksxTUt6U0VKcDBqR0pkK04xdUdE?=
 =?utf-8?B?SnVvSVNCNmgyUjIxTnpNYit5eVlvYW16ZXVpbUJ6MGo0cm9teVl0VFpxdmwz?=
 =?utf-8?B?OEpVUTVTYUs0L1lHYno1U1VGMlJXY1JUT29IaXcxb2FRTEYwWmJ2ZVhhaUVC?=
 =?utf-8?B?WVhhWENuUFFzQ2pUQ1NSeEF5MTZ4ZmxYVjlmZi82bzFQMm9HRFQ3ZVNjTklr?=
 =?utf-8?B?TmxnQjE4em01MGo3K1Q3OVhQNEt2cm9teThmYXgwNzVmdkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WENHNVY5eVlxVlBMaWZzQjBxZjMxQ0NkWXRzZTRiazNzd2VIZU5TNm9HVUNL?=
 =?utf-8?B?QTNpbFNFNXlWN2U4UnNHcE15MVBlRUlsT051akNjSFoyanFzWDhxSlRYWVcw?=
 =?utf-8?B?NWpraTJ6b3NidzllRTViMXlKTDVjNkc0aitJdGhyOVdDWitoTTBDMmRqd0VP?=
 =?utf-8?B?NnBHTkkzSGdod0dCYVRNd3k2eFl4ZmJ2K2h0aStNZXZac3l0VFE1clNEWjc4?=
 =?utf-8?B?ekp3OGwyRk5lTmIrWHovZXluRHQzQ0tSaVZveE9kMWs5YVV6djRQQngydkpG?=
 =?utf-8?B?SjhyVlhkb1BPekpkUFZENFQyTUNaUGdIVkhJZEdSTzdaVWVnVERYNjIwb1R4?=
 =?utf-8?B?M0d6VnFud3lsT3JIUFRLcGx1bnI4QnRRVjhpRUdqbjlPYTJOMXFrMVBWSWNs?=
 =?utf-8?B?OTVmeDhIY3oxL1ZPNHovQU5Ldyt0RnUyRDJCN00yNVI3SkRqT3AvZU15MWJT?=
 =?utf-8?B?cEM4M2hxMUJqVHh5aEtrREdGOXFJb0Vvb0VocUhPeHN5bUd5VVBYWVg2ekxP?=
 =?utf-8?B?enJXNnNja1k5Q3BQeTFZUFFoTU96bkhGMGNMczFlUy9GS1RpMWFHM2ZXZjFa?=
 =?utf-8?B?clFMZjFib2dZbkJIdkFjNUhpVC9DQkNsNDJZOU8zK2ZlbE00SjJwczJ0THc3?=
 =?utf-8?B?aHFkTWo3WmczTzljcmd4RFZkR082TWFod0NMTml1dEF0SXQ1V1ZKTVVhYW1U?=
 =?utf-8?B?TnptcjZoeWs0azUvNGtGKzJXeE5pVTRYZHozNkFEc2FFb3JESFBsalpaU1BW?=
 =?utf-8?B?WEpIbkRJR09TcCtya0x3bnZUQWQvSHFjc3pkdzl2YVkxNktKVGJNTWI5OXVn?=
 =?utf-8?B?TTRybkNOUDhodmI1SWFJb1AreGtlNzIweVgzNDgybUpoZG5hWkViajVLc0Vq?=
 =?utf-8?B?TE0vTEZXVkNWLzJuVnBkajI4TFMxd3Ztb3FIUGtqTGorN2VTRUJGNEFBekVH?=
 =?utf-8?B?ZmxTUytDQXVad1M2VnJKYzBGYVpYY2xNNkxxVXdwenpjbEhOSFJ1TjF6aWF2?=
 =?utf-8?B?QkFjdVRpTlQwK2V3ZlhINU9kQlQ4YXdWQ2VzbGhoMFBuby82MFlPOHNsbi9I?=
 =?utf-8?B?R1diSzRPR0YxcmdLSjlTckxwRWJNZUpsaHBTVmtoRnE3Mmo2UTBYZXlZZmEz?=
 =?utf-8?B?VmZkd0FERlAvSE5vQ1kxVkdNWDNJRng1Z3JTTWh2dWJFQkU5Tzd2SW05NlNq?=
 =?utf-8?B?NlFQdmF0TWU1Tm9VbzlPWCtSTG1lM09nNkdEZFRCUEtzbmdPN3BQQk5QeHJm?=
 =?utf-8?B?enpNOTlhN2hzdWlNT0o0bjQwckFkZGJFMnhmRE9jSFVVQml1WnlEL0pmeGJY?=
 =?utf-8?B?c2lNZjMramYrRnY5emFla3FoWFVDcmREZmNmQlZFb2dFd3I4TDBUaTV3NThh?=
 =?utf-8?B?c2VVRWtoZEVJUlZlYmVXQWJHVVFYQ3hPVFoyaEFaS0ZBNENSK0JNOUN6SmdE?=
 =?utf-8?B?b2FRZUtvdFh2bHlKVzk1Ry85KzRxL3l4Y1k0UFJ4TUcrK0ZqU2ZKRHJ4R2pp?=
 =?utf-8?B?eG5UNEp1R3I0Sjd4N29XQ1AwMDV3ck5yT2dXNk9HNnVHZ0V1WVArakRSbjFp?=
 =?utf-8?B?cDZDVENETlQyamtNQW5tb1REamhVMmp6aURidERnaThNNGc2LytKdForTUtT?=
 =?utf-8?B?Tm1mRy9LQjAvc2wwRGt6cmV6UmxmQnVZTCswdmJ4bVlMZUovWHRVc2Q0Ti91?=
 =?utf-8?B?Rm91YVZrdGpnclR0MXpzRmFrZ1EyQ3owdkE3b3RZSTY4UmxYeW9udEJmR2Y4?=
 =?utf-8?B?cnBFQW5zVktkWXVpV0RvQWtaVU1UMDhUWk9GdWwzc0FiVUZBNmVZUEwwanJK?=
 =?utf-8?B?dkR2SHZSbVIwZ25sTDJydnpTV1Vmb2JzMytmYnZtWUdibEpkLzdQNm1jUERt?=
 =?utf-8?B?S2VVT1dGbk9LU1hRakJhYkNxYWp1V0pFaEZ0WFJEQVZvZ1N0SnFMLzBtYVBp?=
 =?utf-8?B?ZGl1enE5Z3BwZUVCRDRUWmlFeDJHVmFsaXp1Z1ZPVEh6UXVmLytxNGJPZWtt?=
 =?utf-8?B?S2hHa1Fsc3BvZ0ZSdmlEclp2cy83QjIydzM3Y2FicXpLOGlXaWxWNmJ5WUM1?=
 =?utf-8?B?TjU3dk53eFZjRGlDSHp3a3NyQUNvaDYvQlVZOW5TcmZmRlZsWXdvN0VZbUwx?=
 =?utf-8?B?UUZ6L2pRUXJ3WUZUYUM3ZThuUTVJUUovbDVaVDBzL1BsVW5iV3JzZG8rL09M?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a87159b7-d4ad-4790-6c81-08de081cd325
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 16:48:22.9615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5een9Q9unt5FZ+kfsLXKV0dk7g8dRcy0fh29R+itabo9EIwLPkoamxDvjamRpYg61hp6/jApfNZs9nuMlCRAiXG85IzIEOZNsc8Eyzr2h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com

Hi Dave,

On 9/30/25 8:40 AM, Dave Martin wrote:
> On Mon, Sep 29, 2025 at 09:09:35AM -0700, Reinette Chatre wrote:
>> On 9/29/25 6:56 AM, Dave Martin wrote:
>>> On Thu, Sep 25, 2025 at 03:58:35PM -0700, Luck, Tony wrote:
>>>> On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
>>
>> ...
>>
>>>> The region aware h/w supports separate bandwidth controls for each
>>>> region. We could hope (or perhaps update the spec to define) that
>>>> region0 is always node-local DDR memory and keep the "MB" tag for
>>>> that.
>>>
>>> Do you have concerns about existing software choking on the #-prefixed
>>> lines?
>>
>> I am trying to understand the purpose of the #-prefix. I see two motivations
>> for the #-prefix with the primary point that multiple schema apply to the same
>> resource. 
>>
>> 1) Commented schema are "inactive"
>> This is unclear to me. In the MB example the commented lines show the 
>> finer grained controls. Since the original MB resource is an approximation
>> and the hardware must already be configured to support it, would the #-prefixed
>> lines not show the actual "active" configuration?
> 
> They would show the active configuration (possibly more precisely than
> "MB" does).

That is how I see it also. This is specific to MB as we try to maintain
backward compatibility.

If we are going to make user interface changes to resource allocation then
ideally it should consider all known future usage. I am trying to navigate
and understand the discussion on how resctrl can support MPAM and this
RDT region aware requirements. 

I scanned the MPAM spec and from what I understand a resource may support
multiple controls at the same time, each with its own properties, and then
there was this:

	When multiple partitioning controls are active, each affects the partition’s
	bandwidth usage. However, some combinations of controls may not make sense,
	because the regulation of that pair of controls cannot be made to work in concert.

resctrl may thus present an "active configuration" that is not a configuration
that "makes sense" ... this may be ok as resctrl would present what hardware
supports combined with what user requested.

> If not, it's not clear how userspace that is trying to use MB_HW (say)
> could read out the current configuration.
> 
> The # is intended to make resctrl ignore the lines when the file
> is written by userspace.  This is done so that userspace has to
> actually change those lines in order for them to take effect when
> writing.  Old userspace can just pass them through without modification,
> without anything unexpected happening.

Thank you for highlighting this. I did not consider this use case.

> 
> The reason why I think that this convention may be needed is that we
> never told (old) userspace what it was supposed to do with schemata
> entries that it does not recognise.
> 
> 
>> 2) Commented schema are "conflicting"
>> The original proposal mentioned "write them back instead of (or in addition to)
>> the conflicting entries". I do not know how resctrl will be able to
>> handle a user requesting a change to both "MB" and "MB_HW". This seems like
>> something that should fail?
> 
> If userspace is asking for two incompatible things at the same time, we
> can either pick one of them and ignore the rest, or do nothing, or fail
> explicitly.
> 
> If we think that it doesn't really matter what happens, then resctrl
> could just dumbly process the entries in the order given.  If the
> result is not what userspace wanted, that's not our problem.
> 
> (Today, nothing prevents userspace writing multiple "MB" lines at the
> same time: resctrl will process them all, but only the final one will
> have a lasting effect.  So, the fact that a resctrl write can contain
> mutually incompatible requests does not seem to be new.)

Good point.

> 
> 
>> On a high level it is not clear to me why the # prefix is needed. As I understand the
>> schemata names will always be unique and the new features made backward
>> compatible to existing schemata names. That is, existing MB, L3, etc.
>> will also have the new info files that describe their values/ranges.
> 
> Regarding backwards compatibility for the existing controls:
> 
> This proposal is only about numeric controls.  L3 wouldn't change, but
> we could still add info/ metadata for bitmap control at the same time
> as adding it for numeric controls.

I think we should. At least we should leave space for such an addition since
it is not obvious to me how multiple resources with different controls or
single resource with multiple controls should be communicated to user space. 

To be specific, the original proposal [1] introduced a set of files for
a numeric control and that seems to work for existing and upcoming 
schema that need a value in a range. Different controls need different
parameters so to integrate this solution I think it needs another parameter
(presented as a directory, a file, or within a file) that indicates the
type of the control so that user space knows which files/parameters to expect
and how to interpret them. 

Since different controls have different parameters we need to consider
whether it is easier to create/parse unique files for each control or
present all the parameters within one file with another file noting the type
of control.

I understand the files/parameters are intended to be in the schema's info directory
but how this will look is not obvious to me. Part of the MPAM refactoring transitioned
the top level info directories to represent the schema entries that currently reflect
the resources. When we start having multiple schema entries (multiple controls) for a
single resource the simplest implementation may result in a top level info
directory for every schema entry ... but the expectation is that these top
level directories should be per resource, no?

At this time I am envisioning the proposal to result in something like below where
there is one resource directory and one directory per schema entry with a (added by me)
"schema_type" file to help user find out what the schema type is to know which files are present:

MB
├── bandwidth_gran
├── delay_linear
├── MB
│   ├── map
│   ├── max
│   ├── min
│   ├── scale
│   ├── schema_type
│   └── unit
├── MB_HW
│   ├── map
│   ├── max
│   ├── min
│   ├── scale
│   ├── schema_type
│   └── unit
├── MB_MAX
│   └── tbd
├── MB_MIN
│   └── tbd
├── min_bandwidth
├── num_closids
└── thread_throttle_mode

Something else related to control that caught my eye in MPAM spec is this gem:
	MPAM provides discoverable vendor extensions to permit partners
	to invent partitioning controls.
 
> MB may be hard to describe in a useful way, though -- at least in the
> MPAM case, where the number of steps does not divide into 100, and the
> AMD cases where the meaning of the MB control values is different.

Above I do assume that MB would be represented in a new interface since it
is a schema entry, if that causes trouble then we could drop it.

> 
> MB and MB_HW are not interchangeable.  To obtain predictable results
> from MB, userspace would need to know precisely how the kernel is going
> to round the value.  This feels like an implementation detail that
> doesn't belong in the ABI.

ack

...

> Anyway, going back to the "#" convention:
> 
> If the initial read of schemata has the new entries "pre-commented",
> then userspace wouldn't need to know about the new entries.  It could
> just tweak the MB entry (which it knows about), and write the file back:
> 
> 	MB: 0=43
> 	# MB_HW: 0=2
> 	# MB_MIN: 0=1
> 	# MB_MAX: 0=2
> 
> then resctrl knows to ignore the hashed lines, and so reading the file
> back gives:
> 
> 	MB: 0=43
> 	# MB_HW: 0=3
> 	# MB_MIN: 0=2
> 	# MB_MAX: 0=3

Thank you for the example. This seems reasonable. I would like to go back
to what you wrote in [1]:

> Software that understands the new entries can uncomment the conflicting
> entries and write them back instead of (or in addition to) the
> conflicting entries.  For example, userspace might write the following:
> 
> MB_MIN: 0=16, 1=16
> MB_MAX: 0=32, 1=32
> 
> Which might then read back as follows:
> 
> MB: 0=50, 1=50
> # MB_HW: 0=32, 1=32
> # MB_MIN: 0=16, 1=16
> # MB_MAX: 0=32, 1=32

Could/should resctrl uncomment the lines after userspace modified them?

> 
> (For hardware-specific reasons, the MPAM driver currently internally
> programs the MIN bound to be a bit less than the MAX bound, when
> userspace writes an "MB" entry into schemata.  The key thing is that
> writing MB may cause the MB_MIN/MB_MAX entries to change -- at the
> resctrl level, I don't that that we necessarily need to make promises
> about what they can change _to_.  The exact effect of MIN and MAX
> bounds is likely to be hardware-dependent anyway.)

MPAM has the "HARDLIM" distinction associated with these MAX values
and from what I can tell this is per PARTID. Is this something that needs
to be supported? To do this resctrl will need to support modifying
control properties per resource group.

> 
> 
> Regarding new userspce:
> 
> Going forward, we can explicitly document that there should be no
> conflicting or "passenger" entries in a schemata write: don't include
> an entry for somehing that you don't explicitly want to set, and if
> multiple entries affect the same resource, we don't promise what
> happens.
> 
> (But sadly, we can't impose that rule on existing software after the
> fact.)

It may thus not be worth it to make such a rule.

> 
> 
> One final note: I have not provided any way to indicate that all those
> entries control the same hardware resource.  The common "MB" prefix is
> intended as a clue, but ultimately, userspace needs to know what an
> entry controls before tweaking it.
> 
> We could try to describe the relationships explicitly, but I'm not sure
> that it is useful...

What other relationships should we consider for MPAM? I see that each
MPAM allows per-PARTID configurations for secure/non-secure, physical/virtual,
... ? Is it expected that MPAM's support of these should be exposed via resctrl?
Have you considered how to express if user wants hardware to have different
allocations for, for example, same PARTID at different execution levels?

Reinette

[1] https://lore.kernel.org/lkml/aNFliMZTTUiXyZzd@e133380.arm.com/

