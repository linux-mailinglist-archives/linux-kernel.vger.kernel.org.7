Return-Path: <linux-kernel+bounces-751303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A9B16774
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3517189581C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76021A453;
	Wed, 30 Jul 2025 20:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1Z67CWy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4475421128D;
	Wed, 30 Jul 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906296; cv=fail; b=guqeZmLQUnO+M2XoIVM4DTfm+S/kiGp9N1G5Fi+czvspfZaQFnNU88+44IzRmhnrU81cjW8BrHRyj04naYIajoag28uJtpYCikkK0tCEQRVWe5m2PBd6wQ5vXFZPPRvtqBO1U/M6JSo14ZIPiMpbOm5PSKc5arUkn+FpYkd/5Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906296; c=relaxed/simple;
	bh=OKHsUhKRO4d4SMSUVy53E3QIOBvNHNOJyCM5F4dbqHc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QNDMq+L7S2fzUqIu2PROQPo23pDXSivH0bWTznq9kZZLGfbt/E6uiABx1xxtms3kmfUrFYBU010kqn2IJLqzWQCS6X2FAev5G5ytjhzF1tE3++4ShOsI407WyGgJfi+5TEIJ/fTIjZ5FCpEeIY5Pm8yn653Xut1J4AbZwlTGI40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1Z67CWy; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906295; x=1785442295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OKHsUhKRO4d4SMSUVy53E3QIOBvNHNOJyCM5F4dbqHc=;
  b=Z1Z67CWy1KNyJS14QuGMdgX57+b1P6obMnxcF/9VWxq10+kK9RI/8ZNi
   2iMV+U9+sJEdNPlq6dOA3zBvkmlYSAE3VH7bS/Ia3SzEL+E+qxRJr9z4f
   C0j4W7+KIbitNnKnW+xszF4BEle11Ad8xc07Ztig0ycbpfFN0jq7NglRK
   CkgMWg8B9QFPb8zDWNLbntsabAmKW3oiG0zYz23LFxYJAn/wKqQH+x9NR
   JwcxJ75INkbnFtsSDVwY77w/x7/bBoJlQ/78t3Mnfq/vbB20n/Z3kWzpQ
   jYoJKGvP/OLu3c0Mq+M+KrhA+Vq3HjQ7S8DuXeg7QhiuXbnGI8NRWAEw8
   w==;
X-CSE-ConnectionGUID: e36EgyQpR96e4hVPF/Ky8w==
X-CSE-MsgGUID: 7rKwSoJWQLG2BbmvElHUhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="55921089"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="55921089"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:30 -0700
X-CSE-ConnectionGUID: xGk1UE+QRqOo876xNvIGUA==
X-CSE-MsgGUID: bLulJyZNQi6BiDzR+2mpfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162359821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:11:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 13:11:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TM1LG2kLTFBKDBhYlFmO5GGlBT6P6S6GRGtL5zDeNnLHzxewcsY5DBS1whQeDPT1z1HnDScsP/nAQy8nfO0I6A8YO7SLYXS41usI+d5JCruhOklDf1w30v0H3p1SU4SrYMIUuUsvdo6bzrqBtx7My1Ft6HiVj8w5AdWoRPJj0URC9afKkFrIB/UianOqtOucT4Kc8hm+rm75K3wlsnXH1gjP9SQE20ZQYl65sR7JEXNFu92ucinfN+J7xjfByIOZ+QyuCUd01i2Yr+NQr01ASFqcmQn9skR+FyX3EdQ5QHoApKp12S8/wc+WU0PizKzVXK7nIz7B0Nn/RuZ4YoQyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaR1YeXFtba2Vxaf5t1m4CjlsE24tjYOTIO7S6b55lk=;
 b=wSO5Ir7HZHOlFuADf93z4XT7PwvQ4el230VZxK5w0a4tQqX5V6Rv6p08LDf9/NqLD48V8+kV5+aL4o/JzrNBMJubx15kp9fZqdv+dGsoliZzapRptm4s1jZvcfekBNqOmka6616uC+X8XPSd8Urz74297qGitt2QPPW3dUtKPIWp2Ps4QGMQ5CvF2cc1Ol2y8640V4qZSeyk89DpVsQCEklVrMAugCc5vkbTY7UP4ru0Nh6QuEvc/Xp3q3I9qqISaNvFa+vb7CdClcBILr4QMfWkSI7DEnGHWZLo0zLCpMPIpNlV1CaNQXgOqnxPOk9QHnHBbnsC8Zm75wtIt39Spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:11:26 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:11:26 +0000
Message-ID: <fa0276f8-a732-4c15-b55a-7e459cac4811@intel.com>
Date: Wed, 30 Jul 2025 13:11:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 32/34] fs/resctrl: Introduce the interface to switch
 between monitor modes
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
 <9f7816ff6cefbffa2a9a701d2fd3bffbd9777736.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9f7816ff6cefbffa2a9a701d2fd3bffbd9777736.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8a7187-ed13-4a84-7503-08ddcfa54319
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zy9mNTZKN05EeTNRbDYrbmtKamVvVDJLYWFxM2s3Wkt3bmJ5aTFnQ1AvTFNx?=
 =?utf-8?B?bmxLam5IdmlHZ0V1S094aDV6N2NPbTUvNHBqMFVPZEhBd0c1QzFoeHlvTStp?=
 =?utf-8?B?elNZMVlQdExNc1hPaU1PMW11cjVTd2NJd2U1ZC9nV2dmVEptZTUxdjRoT1ND?=
 =?utf-8?B?WU9oYWh2enBya1NiMHoxVjZzWDYrVHlMdnVQVHZtaFZmbTdmU21tZnFlLy9Q?=
 =?utf-8?B?WVQzczNtMFl1UUpWZ01uVzZtU0w4VnlDaXFUSnB4bWNIdW41bUxtUUFHcDcy?=
 =?utf-8?B?R3gzTEVYTEV3alJSQkxxTzl3TVVJaU9rQWJoWU42TGlQV0JQT29leUpkZ3Jv?=
 =?utf-8?B?b1ZZTWExK3NpbjJqdGZ2QlRySWM1UEc2NjF0ZmdkSmltM2dUNkVBV2t0VGg4?=
 =?utf-8?B?Zk9ZZDBHUUIvc0t5YVBQSnEwWnhCMTlKSUxQYjByRTN6S0NpL0xRV2NLcEs2?=
 =?utf-8?B?ZERVYjBkZEJ2Z2hGTTRqcWh5eXpMNHk1T2JCNFNHM25QdmxEcFhPalpudDcx?=
 =?utf-8?B?L29wQStZM2RBUFZQNFZkbDZqcitLeVB2Y0IvNjEwdkxjd00yeVhhb1pVbG93?=
 =?utf-8?B?b3YvQmxlSFdoU0YvT3hYV3BhU2pmUysvcVhZSGNLTHdlc0ZkRE0zaHBYcndw?=
 =?utf-8?B?SnFZVEpmZDRwWlI5eUd2bzFkS2NSUGlRekNFMGswb0owRnlHYUFZU0V6TU1O?=
 =?utf-8?B?aEZ0K3BtWVNodjh4eVBsVFlnSVJWOC8zNUhXRVdYUENVYjVFUHZjNUc1RFBn?=
 =?utf-8?B?Mys4dWFKUUgxUTdOL2M5K1c0NGVkWWtHcENkOXlyakhWeWx4Q3kxS3RHZXp5?=
 =?utf-8?B?ZkQ1UU8zTXg3UU5UZWZLQ0R4dk14dmd6T1dOSU9HMWo4M2ZWNFB0RGtpcjlT?=
 =?utf-8?B?d3lpRTI2WWtDTzd6Z0NuOVBnNDZIN2Irb1p6R016ellMUm43d3lmMDFHWnNz?=
 =?utf-8?B?eEExeHIySDFFVWowalErcFZ2MmRBTy9vQU9ydEo1NnY3RTZ6dTBGMHJ5bjlO?=
 =?utf-8?B?UlhzT0l5MGJzUnFUdHZYRzBaUnhjZGp0Vjd2VzdQTGNweHNDbDN1RUZkd2h5?=
 =?utf-8?B?dUVEN09ReUs2enBuZ0Y2cWQ3QkV3Szh4OVJLajdmNFh0UWlXejdEM1FZRm8v?=
 =?utf-8?B?a1BUeElKTzl3UW9keDBCSEdKUjYvVGlPNXFHS240REpGVkVvc2oxUVN2Y0tX?=
 =?utf-8?B?SnlySVczWWg1NVQzZVduWmR5VW9qTVJXaVZWSTdST0JCWGtLVGs0K2hhdzBs?=
 =?utf-8?B?L1VnOGtyam4vSVh3ejQ0RWlPcVFVOWlGaFgwYXBLYldPemVPZFRwZGpHbUx4?=
 =?utf-8?B?MHZBYXBxT3o3UG94cWZ1UHczNW1VK21zRWJ6NG5BNDFNMTc3LzREV3M5YkFC?=
 =?utf-8?B?NEFvRmJEV3Frc0FCei96NTQ4YnRoVXJQM0NiQkphL1lNRkVlSFVZR0daTGxp?=
 =?utf-8?B?cTdlR1crWi91d3RPZDd2V2lYQ2tYaWVyTU1idWpGSjBRK2xUOWFhWTJzN29Y?=
 =?utf-8?B?TVdTMGFLcStVVVhaYkhrOE9qZmtzeFRmUnNKVWlQQytramNCKzdBYTJCZHMx?=
 =?utf-8?B?TTBGVEl5ZnJJK1VHalN5ZjJvRjY2TGNHaWtnRTFjbVZDT2xrWW53SGFkT29v?=
 =?utf-8?B?cVJ0cElFUGtsSlFOV0Q0VHNhT3RienY3amo5VWN2blNFNndjd2w2VEs0eWM2?=
 =?utf-8?B?aHVVMFd3VVdFK3ZRRVZxdWVrMGNqZXk5VHRQOTNlVXViUEdkN3duQ0k1cmFQ?=
 =?utf-8?B?Vm5ZOVhTclRIbWhBNFUxdmVuWjQyQmhxVEY1Y3ZrNXU4S2ZLWTgwOUZNM21F?=
 =?utf-8?B?Y25ZcUtiMThlazFqcUVVY3NicEtqamZVbzFlVlAxcmNLQU5KYTRrMVlabjR1?=
 =?utf-8?B?T3h5dFNGQUgrRjhnYU5HSy82NXNscGxXODQ2SlRLSjdtbHdzaDA3NUpyUjFh?=
 =?utf-8?Q?CS9zPYnBmxU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRtcGdUNXZGYlNlemlFTEQ3cHlsaEMyc3RWQUVoYWFQSUNmaFBJaEpKTC9T?=
 =?utf-8?B?N05VdTY4cHNPajlXNEVUVlAydGI4bER3c09uYXhDR1k0MWJsZ1R1NFY5aEFJ?=
 =?utf-8?B?K21CaXh5azhwSWl0TzlOalJIcFRCZGowZVd6MTVkbzNpNEF4UndFYlZYTlNG?=
 =?utf-8?B?ODBjTlBvTjRmOEJ1U0NXWHFEOGJ0K3VERVRYRWxxV0tCdUpFZU1YQmpnYSsx?=
 =?utf-8?B?amZsUlFvVGh1L1dWZ2ZsUkNuZ2U5aFdEb3Q3clBaMitiMjZoZ1h4RVJTU1dE?=
 =?utf-8?B?RkwySWtPMzBtZmlLSlBJYzJiVEpWc0RDQzMwMkdVVWIrNURWSERtclRxdUFN?=
 =?utf-8?B?UkdvY0owanFQSzFIaGYwRUVjSjlJcUk0NU5HaDM2MVZ0MmdrSjJFTllVeVQr?=
 =?utf-8?B?clE3WmtlNEN1Y1cvQ1hTTWRVdUwwWVVhVUVqRjIwWFJhSjZnN3V0MHdyNkMw?=
 =?utf-8?B?R204cXFteE9PeG9va2J3cE44NEFKaU1vS3Bjb2dGRkVRTzY5TFdldnZTWkw2?=
 =?utf-8?B?citTc1d2TENodXVCRWZvOVAyRW5BT1FQZVpHNXdnSWIzeXFGNFFtWEw4UDlT?=
 =?utf-8?B?TDNQOGRJYWRxVXVuV3FtT2Z6WGVheHJaMVpuY0VPQ0lpM3VLeGI3V3UrUDY4?=
 =?utf-8?B?NzQ1K3hQVjFxK3NMM2lNR2h5blBpaC9RVWNGWWxEdHBWSThJOEM3b0ZUWjl3?=
 =?utf-8?B?MUVSdnlIVkRod2JNTU5oV3JIWWtGb2R2N1RrbXhOWnMrSGFRMTJXelRJNHd5?=
 =?utf-8?B?cnd5OStPN2xnV2ZJODVqSkJHeGRSbEdGbkpQd2hmM1RFbmRUcXZESWU2am1E?=
 =?utf-8?B?OTBDRXFEZ3JmK01ESldya0U2N1dvdzZHYzFxQVJkZkZXYzJQUXo5cTR0eGIy?=
 =?utf-8?B?NUpoWGUwWUFkODNmWkhuUnJ1bVB6WGJLNlA1bGRRckFvM3JRcnRyckNKQWY2?=
 =?utf-8?B?dXpMemFhNVlMUXBSYXZQTXM3b0dIMU1XeERXUFRRL0I1MGZsQ3RLSzF0SXBu?=
 =?utf-8?B?djRsTUJ1Ui9IdGdqcWFzNGVZdllWdXc2THNOQXlGUXlGekUyRW9FTEs3UmxY?=
 =?utf-8?B?a2s1bWxKTEd0WDJHdFdZQTdVeUlYeWF0RDFWbDZsdldrNFNZYWVHamMwRU16?=
 =?utf-8?B?OHhQRW1LWVRyNm45ZmxVSktteEdYc0xqU0I0S1NnWGV4YUVtNHpKdDZ6VFgx?=
 =?utf-8?B?RUtBbDFjZXJWZXhyL1JKTkdGZnR5ZUFhRkF0c0lGR3FMaUlHOUlydEhpVGdJ?=
 =?utf-8?B?RkdrcFFaOU54dkNVT25RUFIxVldJNCtnRkZseEFpc1hydHprQWN6RGtlZFBW?=
 =?utf-8?B?OTVWY2ZPV3JsRnYyYmI5aHRiajZKQ1p3MEl5bUhBSFhqeVFXRGxYc0V5UEZ3?=
 =?utf-8?B?aWxKM1lQdGJhakZRczQ4SUozSVM0YkxBTFc1UU1HdG1IMG95TTltN0I4dFh2?=
 =?utf-8?B?N1NyMGY0aFJPVnZONjRPZnN0UFlvQU9zaEtqMlFvcU5ySnpMWnFKOEJkVDJQ?=
 =?utf-8?B?OTBsSGVjMVRhN09QRkthWmFvcFNWaWE0NEUrWWpKTkVadEtpQmE2RTRVQVYw?=
 =?utf-8?B?UXNCMGs0NEJiUnhNdzRMMmx6a3pTbnMxRHdmN0V5VWtRMm5PWENjeStteW9F?=
 =?utf-8?B?eTZkZ1dJU3d2cXZ2eHVVMG9TaDJQbkJwMWh3Qkc3bjBpY3dYTS9zdnAzb2FV?=
 =?utf-8?B?R3pWMWFMUEZqRi9TSW9CVURTcjkvMVBvYTltczN6VEQ2NDJRU1FMUXc5MGlo?=
 =?utf-8?B?T1NnTEsvMXFmTExad2t5aFJXY2k2aDBCT0x1QU5LSmxFQmpUczlxNWp2UnZ0?=
 =?utf-8?B?UXp3VURJbEk3R1g3WmhMZWljTVU1bS9MNDA1RW5lbitBZktvbVlkVHZydU9t?=
 =?utf-8?B?cm1Za0dFdmo1SStlY0daODFDanZiL2F4bllUU0VPMnltWi9XdFk1YlRRYjFS?=
 =?utf-8?B?blorMitCWjBOTU5rTjNFVVVzVjVBTFM4aDNUanJNM2Z1WUZlSHFSb3NBMUFv?=
 =?utf-8?B?LytISDhEQmtsdWRPb0ExRGNvbTYxbnRvdVV6U0E1Y3lxdGxWUGx3anBYNEhB?=
 =?utf-8?B?TlIxTEFoYlJpVlhQMnhqbklOcDR1WHZZOUV6cVZ0cHlSNFcyU0RPUnppcWMx?=
 =?utf-8?B?RjJwVmJwU3BpM0N2aE5WTE5pWVBZZnpRVUdMU1dDZ3YwTnUrVHRjbUdrdld0?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8a7187-ed13-4a84-7503-08ddcfa54319
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:11:25.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/Rx+6NNx+0TmURF4z2nMhw+dxzFqf3QrWwERaL5q6kE9gbGUP/CV5aSPrOfhBDYHKqByu3Qp7xSJGAtKpMDzXYXEgWfMR9Q+/Bg4MI2OJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index 1aeac350774d..68ba08e95a54 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -1865,6 +1865,75 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static ssize_t resctrl_mbm_assign_mode_write(struct kernfs_open_file *of,
> +					     char *buf, size_t nbytes, loff_t off)

Please move to monitor.c

> +{
> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
> +	struct rdt_mon_domain *d;
> +	int ret = 0;
> +	bool enable;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	buf[nbytes - 1] = '\0';
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	if (!strcmp(buf, "default")) {
> +		enable = 0;
> +	} else if (!strcmp(buf, "mbm_event")) {
> +		if (r->mon.mbm_cntr_assignable) {
> +			enable = 1;
> +		} else {
> +			ret = -EINVAL;
> +			rdt_last_cmd_puts("mbm_event mode is not supported\n");
> +			goto out_unlock;
> +		}
> +	} else {
> +		ret = -EINVAL;
> +		rdt_last_cmd_puts("Unsupported assign mode\n");
> +		goto out_unlock;
> +	}
> +
> +	if (enable != resctrl_arch_mbm_cntr_assign_enabled(r)) {
> +		ret = resctrl_arch_mbm_cntr_assign_set(r, enable);
> +		if (ret)
> +			goto out_unlock;
> +
> +		/* Update the visibility of BMEC related files */
> +		resctrl_bmec_files_show(r, NULL, !enable);
> +
> +		/*
> +		 * Initialize the default memory transaction values for
> +		 * total and local events.
> +		 */
> +		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
> +			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = MAX_EVT_CONFIG_BITS;
> +		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
> +			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM |
> +									   READS_TO_LOCAL_S_MEM |
> +									   NON_TEMP_WRITE_TO_LOCAL_MEM;

This needs to take into account the configurations that
hardware supports.

Reinette

