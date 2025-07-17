Return-Path: <linux-kernel+bounces-735848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C20B0945A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA5118841B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D79302065;
	Thu, 17 Jul 2025 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHjY2afX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2B302044;
	Thu, 17 Jul 2025 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778050; cv=fail; b=n0BoBAuSXR3HLjhoCstnYtOV0pLx7C1EY8mcGLYphDP4FBU61JKD/ArTN74uW574r9/3S+Ryyr+hJIw6hkYmkmk4XYTez4BnPPj9/AejGAtDLhkBKUNCg67RmfvzSmyfNxERha1zy34M2bXhLTCxjLvPAEaBFo36jFZWQeOTz3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778050; c=relaxed/simple;
	bh=iw9+HYK9ASqRPVK2rFVS/n3E5qwyMNH/efGd1pZ/UwQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mf5gSEZ7HlLpki1kjNc6ATn3mUJ+qBTBVAyVDnDM0jPnToZOrH5G63/24VFUemWRtFj+P8pG2tyei6H8Ru9fsXwm6cv+6cl1lkEXwPZ3KF5zVY8h0JCILLV174aM4fUEzAyWLtabbLeVJEgKoQKWc5Af3P6GrpENkas8xjAi8H8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHjY2afX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778049; x=1784314049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iw9+HYK9ASqRPVK2rFVS/n3E5qwyMNH/efGd1pZ/UwQ=;
  b=cHjY2afX5gACvAnH8wqVygxWtjw2pVPrC9BmpTX/8QMo0qksnsTXwX2g
   9f8ZDdYAaMnyRoQoLFwCK9JeOfFE4np79WE2i/2a9g0ABq0oExEwsRM5J
   8sUHqdeMMdHBVthJmuhi+pEwqBbbjW/QMj0krqs36sfy5kVUGz6gu66s4
   KEynapDxkioZKOd5cWS2kYbP8Ksz7d+2v7V8JH8C7WQm0RO5e2k4U0USz
   3FKa71OWV660GilsjcHGpW9HSyk9FBODP9zC10oPKl9oWp1QtwVCfwnfJ
   XlcQtSqqVGT3lJDmm+UvOn0pr9m0Yj615qxdw80f7goamfcp0+8ZuoBDs
   Q==;
X-CSE-ConnectionGUID: 2ut4jbk6RyWG/oD58UhioA==
X-CSE-MsgGUID: OmWesJyoTZuB/s6AAPSVHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55192260"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55192260"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:26 -0700
X-CSE-ConnectionGUID: LjowbE3oSSCO1dkDts0kkA==
X-CSE-MsgGUID: RjwQWOFRRo2/gcsOuFhxjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="158440793"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xd1fVpVlXte+Yej126JH88lCCBSkRFR7F1zohw8xnQSo3b8qhGhvNB2MxqQGAPL87kaHoFyHHVbbB1J7gE4HClxSvsogpUH8Iw5KVYlcuqBwzzxnn9YS68u3KMmPNVhOz7GAuXyC6LXc3ZB048YDtQcGKs8wgBAJUCuU1OHh8Swhq/Xwbe3lFtawNvmr6D1isE9uJI1Ca7QP1v34CHlWxlDeut4Cxe+APdHcijM5vFPjMbX83RaA5P54Hn/ePa7TLXiyhif6BWQ0XtS7bsOuuqGjut6c/Rcx2LlH04Qp1ajLciBLs5+FU4DV0qRHlIfk9xdYYD3fpj/W6nac41HFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Huwcp8WXURfTZnae8pbQy2SC/7QgdBrPMkUNBXzc5ms=;
 b=WKGGkeBtMgHGUvtlZc4BCkt2xJQUkY2ups93hSp9i2ccucK0wdydETTdoITByxCLqJy29kbNTQnYjzeYB3mKC9M5EhhwTXUjqOWERlP/o/T2Yvh2nhlBSTuQKd50/cIDb3RIXdJW1YME/H/4uygZIkYDsq1AGbzSzJ4evnu3fTfFaABKtEPkqsxw2lzLc3+C7XMa+QuUxRi8T+I4bgENXI1sBQweGV2gLrE7yiCQ3Xbs9BP/nlVibdpVwvvGlvzfXkjpyNXLc/gtlWH57vtGkKsGQWMfBMvXJtFILMpfOMbzEDF6Z0X5YOKc9rv/m5VQTkyz4JOdQN5HWVS828X7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:46:55 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:46:55 +0000
Message-ID: <684128bd-282d-401b-a94a-69318bcc74a4@intel.com>
Date: Thu, 17 Jul 2025 11:46:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 12/34] fs/resctrl: Introduce mbm_cntr_cfg to track
 assignable counters per domain
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
 <566cf42c23f7f5548d2a96bc0339f0444f9f1d86.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <566cf42c23f7f5548d2a96bc0339f0444f9f1d86.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 45dfaa24-ca0b-41b7-5154-08ddc5624d5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZyeDlVNjFZWW56UzJLbThHVkpsUnRvbnoxTkUyYzZHUGVyZExqTlFvWk9J?=
 =?utf-8?B?UEx4Wk9EVjBWQWp3T2pVdU5ITGJjeUVITm1RT2dISTY2V0YrN3c1N09KLzNL?=
 =?utf-8?B?ZVhQZ1YwQmxmZW1aejVYTldEL3h3cms1N0VVKy8rUzE3b3I3WWVRVXd1d3h5?=
 =?utf-8?B?V2lnNzBITnFWS29mMS9Cc0cvaU9DdElVdzZ0em9xbllRQ0xHYkFpdDFHWmt3?=
 =?utf-8?B?Z1pSbDRxS0hwZGxIdlJQZ3V1c0J0Vjk1TDBkQ3RiR3pEZzd4TTJDcWFtcnJE?=
 =?utf-8?B?QXJZTExBT1BqdlJob1UybkhnTU5vRFRoQ1FTalV6ODl3Q2VmTEdna0hXcXVm?=
 =?utf-8?B?dWdaYi9OenRqWExGeHU5ZUJjVUo3TnlQWHc5WGwybHNjSFNRVWNiSU1MN2Jn?=
 =?utf-8?B?N2hpTlJ0MU4xdnZiZ3lZRUtvejE0Um1pQVpVL0tHbFdZOGpxYnVkY1pRTzJX?=
 =?utf-8?B?RTB5V3ptdEhTT3kyOUhoTUpFK0Ftems5VEJ5Z1BpRDhyNWh0Z3FqdWRLZ0Mv?=
 =?utf-8?B?ZW1yZytGOFFQR2hnQjhLZEIxMjg3cURSVG9SeXJ0MHFhVGUyZktHV0VYZm1E?=
 =?utf-8?B?R1lOTEQ2dEhKcE9SZzlCb0RhTlpHbVA5VXBTaGtZaDdMVEpFV3pYK1lrRHVn?=
 =?utf-8?B?cVB6emtteldzeGt0aTZ6Ri9pdmdVeWE1b2FyUXIvcmgyWGNZdnJnVG5qVGVT?=
 =?utf-8?B?bDNnTXBMRG43MnBmc0hSeG91WTVhdUhVZ1dZVEl3QzFteGdOL2FsMWN0M0FW?=
 =?utf-8?B?VExDcUxWc0RoTHA4bEJRb2xUdFlmNnltNFNZdWg0U2xGaFZJR2xBMTJuMTVU?=
 =?utf-8?B?TVEzOEZVT2ZDdzRRdlpscGNKbjh0Y3JlMFVWUlowQ1NlQjdJRTFiYVlUeGhm?=
 =?utf-8?B?b2FYb0U3OGp1WVBmMGg4V2xxOGRpblN1QU1lWVZZV2N2ZGxMQnZpU3duUFhD?=
 =?utf-8?B?VG9oYzRnUzdBTjlhWFV3VVJGRGdhVVBHcklrN0VtRTVlTktwcEpRQ2pKQ0FY?=
 =?utf-8?B?VXBMU1EyQW1YUzRPQjY4Z2svbElZNE5ndUFlcU4ybGhuamdTWEQ5dmtVVFNt?=
 =?utf-8?B?ZmRDTU1mYTN3UlVYRFNSMzZRU1o3Wk4yVldZU3J5cUJCNTRZK2tCb3dpSlRR?=
 =?utf-8?B?dWxzZVNEZnBGU0RPOGNPRlN2V1BSOXRVZjV1RnFQTHBZWnhUdnA3UklWeVQw?=
 =?utf-8?B?cFNmbXpMUXk4cXpDc2czazlpbWFnYlRyQUkrdTgvM3N4ck1PcjRXTE1rVGlS?=
 =?utf-8?B?WkxaV2c5U2ZRKy9aYVFzUkRCeXVHeG9uenhsK1d6dCs4UEZRYm90dHR5TEky?=
 =?utf-8?B?N1lzYzcyS1JHRGNLNmtMWjhKWXAzM3RSSmEwMTJsR0Rzd3lHMUU3amxocFJq?=
 =?utf-8?B?LzNmTzM3QlNOKzBQK2wzRFBUdDB6eHRnRWpIUldybVJLK0JuVklWZFZmanBC?=
 =?utf-8?B?aGVPdjFTL2dZR1daRmEyN3RPN005ZlUxcTJWbkJadkpaSUMwZ3NTYWo1UUZY?=
 =?utf-8?B?ZkZRc1ZwWVVZWGNraDNZbXNyd0RVOUxpemo0NldDWHFFOThIRWUzU2pOS2w1?=
 =?utf-8?B?V2JPbzV5a21EYWY4aDUwMTNRejNVcTU5SFBPNm1QczZCblJLd1JuL25vUmh0?=
 =?utf-8?B?ZURzd3RwQkxkQzVXaGxiSk9WRFgxYWNEdldySEtXYThxMXA5T1QwVG1wYVdy?=
 =?utf-8?B?S0RrelAwVkJteVVaWkx6Mk5ESURhNGhYMnAraUsvWGtHYUR4NjNDWGd6MkZl?=
 =?utf-8?B?MEU2bzVJUDNLUGJHODdweUdBeEVqRTFtSWt2OFJGRFN1K0pDSjl3OTBWNlhB?=
 =?utf-8?B?eXJ4dU9kOXZ1QlJGeXlrTGhjVHdhaG1MQWRLdnh6S3F6dUtrM2ZyckRIZVZt?=
 =?utf-8?B?MENCWjVNWmFDcTIwcy81L1lrWEVhT0pWNnROTlFCMWRUZFladjVQaVBEMTI3?=
 =?utf-8?Q?ftI174in0Qk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFacHZMSGNYMHkrWCtoV0dBOVNpbFZwMXpXTlZ0dzE1SjB5R3VZQndlbm5U?=
 =?utf-8?B?bjQ1bHhpYnNLU0h5MUxVVDJxRm9BNk8yUkNVQWJBNkxTeUZ0NHo1UlRuT0RN?=
 =?utf-8?B?UW9hY3JSWHoyNWtPSnFTWld6bURwb1ZSMFZiMjNhb0VHYjZ5UjZnZWluaFUz?=
 =?utf-8?B?WUVtU281eDlMZU1DOTZRTjY5OVVUSHA1Zml3Ymd6ZlhZdG9yTnZzaktyWGlR?=
 =?utf-8?B?clRiam1ScVBkOUdmcUdnajRobWtJZlJ3TTBKR3I1Wm12NzJUZlJ2cUhldFJ4?=
 =?utf-8?B?eFd5SDliKzlvemxCSkc2S0lXOGxJVFp6eEUvUVdhSXhXaVRxZWRlWE5uQmdL?=
 =?utf-8?B?dXlpeEFsMlY4MXpMb3QyTHJaZEl2WTVZOE9LV1VZQkFDYjNHRWRES0ExK2pL?=
 =?utf-8?B?K09BMFJHNGJKSVNjZW9OVjMwUys1MHRPelRRYWxJbzZYQW5vWnZqU0dETHYy?=
 =?utf-8?B?OUhhSExlQjJrN1BoMzAraTVkNUlKdGJ5QlBFcXpSZ2hHUk82WjBZa3hSVXNQ?=
 =?utf-8?B?Yk5mT0JadFRvMzNENGZtYk1acVZYTUNFNUR3L1N0a3VmUDBWQ09nVFdsWkI4?=
 =?utf-8?B?bDAyYUNZSmIrT1hMVUY5c0FIVmNucTlNRTNNeGJGUGNmdTN2M2xVcFp2N29C?=
 =?utf-8?B?ME9yYjQxVnBrcDc0cng0QmRva0FCWElhTXhRZTRhQkM3R2JJQzgrZlBwdnNi?=
 =?utf-8?B?aldqRlhFaFZuRXVab05xVkFyNG5Yd0lzc2xReHNQTEVDMlRPUkRSdkUvMWI0?=
 =?utf-8?B?NS9rUEh3WVRTbU5WaW5odjh2VkRpZkJHeDcwR05ja2xSaUdZazV0L1VnNTJy?=
 =?utf-8?B?cjNFeVBwalhuTFFmRUlBNXNIMkt4cGRHWWphQjF1Tko0SCtpbEdhMG9aaGZq?=
 =?utf-8?B?bllxV3UvTTNSNnV3Y2hWdVBjeWh0UThQWGtjby9BS1hnbFluYmIyT0U5RnRQ?=
 =?utf-8?B?dHFDRU1Cei9NSGtSblhHL1NqQ09NSGM1ZXpSdHMxMlBWbURlQUNtRHM1QTBM?=
 =?utf-8?B?bXZxcExlY25NdVFpdVlDNkNZa0ZtaGZrOW1mNUNPYVpzd0hkelFvL3p6K3Jq?=
 =?utf-8?B?TUlzNDcyOHNTMVhuT3lpRW93MFM5YkR1NkJhbndsN2U2WkFDcDI4VkU4OGQ5?=
 =?utf-8?B?dkxWdXBoNXJRZWhrTWRIRExOM1ZxSVZXTzYyQkZMVzhhaEdoN1NpOE93cjFp?=
 =?utf-8?B?V3l0S3NNTXdURmRJeGlEOXk0NWZzQ1RuRW5kNmNZSUVCa3g5WGh3NVFNM1Yw?=
 =?utf-8?B?a1VpOEpGakZoL1hZNkRITGpwSmVxdUFTMDluUG5mZEZBdldKelFYT2c0bHdH?=
 =?utf-8?B?OEVnVXkwZTV5bUUrdTN1R2JwZElhUVZRZ2lQNFU2bllOaXIvMkRMYTRTeExT?=
 =?utf-8?B?YVFoTEw4N080THlYeHV4Slh6dlprNDhZSmRUMStsdW5DRitmRkl1LzNxNEFG?=
 =?utf-8?B?aVhSUDJtSGJIbG9pK24rRkU3RnJ2WHZ2UlQ3bkMzTGUydEJKcWo5UHNsWHlS?=
 =?utf-8?B?UkpOVmNieklIdmNYM1dRYWdJdTZvTWhsSThQTkdwMWhCczdtVzNSTlkwdkNM?=
 =?utf-8?B?R2lnY2xmclhzdXZrM0ZOaEZIekErR0tJV0gwZHJDSkJDWkd1ZFV2eExYY24v?=
 =?utf-8?B?Y2RJTzhKRVpxa0RUVExHN3FqYUpWNnRvZFFnZWF3ZTdCWkNhbzV4SitTem5y?=
 =?utf-8?B?WHp0TWt2WXhNVTU2WlNXeEw2MFhGMG9oSmFES01QZE10dUsxbkVGeTRXWkJD?=
 =?utf-8?B?SDBpbVFTUHpIbHJrcURhQW5DdW1NU3FWL2Z0T2Z2Ujk0d1hnUEtJREJPODJ2?=
 =?utf-8?B?VU5Ea3dpUk05dlVIOXpLVlFCRFh2MnpQWTg4MWtPU0JwZEl2b2xjV2txOHFB?=
 =?utf-8?B?T2UwSHVmektia0h2V3Vxbm11NUYwNUQrTVpMRm9saTlyOGFmRXRUMEpjVUx4?=
 =?utf-8?B?MmxLU0NPRFhJS3NVd3ozbmZGcGxNek5Ba1ZzWlFvdkFyajBOdTZVMjZwclc0?=
 =?utf-8?B?S1dVOEE3OTJEaURSVVV4ekdCWU9XT0ErZFJ1RkVYU1BTb0oyeU9aTEN1bDdU?=
 =?utf-8?B?RHBLU2xTZTdZQmw2Wi9wN2E0Ym1XZHovTDNPMHo2MlcwRHgyWHh4RUE1RHll?=
 =?utf-8?B?SHcweTVVdHJITUZoUDFmRDlhUTZjbzV1QWVNbkMzRnQvdm0wa1hydVJhUGQy?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dfaa24-ca0b-41b7-5154-08ddc5624d5d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:46:55.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlgOPl6r7a7iWi81yAPEakaIYhWXLJIXQ+CSgzsUdU8iR9Nd495pGyJW0ynicKoym7igkJqvmjg9CKg6aH1aL3CjeMHToFC4w38MvXrhCG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned.  The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user. Counters are assigned/unassigned at
> monitoring domain level.
> 
> Manage a monitoring domain's hardware counters using a per monitoring
> domain array of struct mbm_cntr_cfg that is indexed by the hardware
> counter ID. A hardware counter's configuration contains the MBM event
> ID and points to the monitoring group that it is assigned to, with a NULL
> pointer meaning that the hardware counter is available for assignment.
> 
> There is no direct way to determine which hardware counters are assigned
> to a particular monitoring group. Check every entry of every hardware
> counter configuration array in every monitoring domain to query which
> MBM events of a monitoring group is tracked by hardware. Such queries are
> acceptable because of a very small number of assignable counters (32
> to 64).
> 
> Suggested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


