Return-Path: <linux-kernel+bounces-760739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F4B1EF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204427AC9FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46BD235046;
	Fri,  8 Aug 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="niFXLi/y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7B198A2F;
	Fri,  8 Aug 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754684821; cv=fail; b=oqJKWAzcPozaCWsqRiSp3fSV5FcE6qcTbX5mkQnovNONpi/wD2RZ4SoOzcKwsbc/W30jwFpUo1WXOqBBXNOlCO+FhmY23V5v2PjCa1ryFGVHYcfh7iccfu8fTmW/1BuxPliFib1fUhJhOzPsEscQ6iakCNDdcgEoS0+VZcKbxwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754684821; c=relaxed/simple;
	bh=gY8hxRP9DgoIu90Q7eNwf/7uTS9oUAryHVKFpsN+NnE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KCZIgLB5XKyr2gwOjTU/LtToFgrF8aMtrXRV3x63A1msw6y0Sp0FNBy/vTD5M17yjWJyFERcUnpcelFzt5cO0AB78VIRlQgQI1dwiNUN9SJDQhGVXm75ekt5SBX53Qh83dPwO+OkJcQK+FYmVUhf8hr2elcijmQzHQ9PSnJJEyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=niFXLi/y; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754684820; x=1786220820;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gY8hxRP9DgoIu90Q7eNwf/7uTS9oUAryHVKFpsN+NnE=;
  b=niFXLi/yO6cxbnqb7EoThlT1RZ7adXpvjomC+o7dEUujvlqyJuuWRX/z
   S/UdFHGGCBvlb4wgUSOAKbIKAoUW9m20bRe/C+ma8ESdHqfwni2gicASa
   qX7prU4KphXoyfX0GXFgNC/9cVRaCBcj+jNlo52r0iNbOep4l41X5oCZA
   FQZTAGXhY8IZECH+HdL7BplaTnVg17S5SOPmQQwLmItu/I1qz8ZpgwISh
   yNTmRJ+WGCZqhifGVElSawgSMzq0Y19A9YhAKVV5MMU2CepgjS2Hg/b3M
   Bnz6EVICUikJ8jwxvceNCn+HoSExsNt4+ie1RA3MypJ9q9YGBg4UKZxeX
   w==;
X-CSE-ConnectionGUID: js37Ha4SS3WlhTA6Eu1I8A==
X-CSE-MsgGUID: 1MmFjEEPQwyv5YR7brDilQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="44630892"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="44630892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 13:26:59 -0700
X-CSE-ConnectionGUID: 1uUMM+ZhQC+7HvGU8bV+HQ==
X-CSE-MsgGUID: 2WFAHp1mS4Skem7lCfodBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169615663"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 13:26:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 13:26:57 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 13:26:57 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.75) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 13:26:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2qt4uZ17Ure+rSs9Um59bPWgT5W4FW4kX51zhT0tasBUkak4fE87UYxFWpzF6FeZiuPdXjHgQ1BkjZweDgxkWV0BMid+0UFZT/KG1pwkbfT3zDBBoLzYWlZTlZia5WjRnB7gsPcb8fl45nEJ9wa2BY2MxxkstExSy0FP44jR4lwOwwt6zc8ldCspQXgQ6RtbQgUsx1e/1nu2Uqc9XjhMPykDQySIANbHN8R73QbZ57fuDgQGD2G4WLXOtRAXGEYnIwUX+CUIYDiMUQMbmAqvLNinn7PmZ9bAKLctq+Py32mpZoraus4FVRs83QCECG25UNyzMrGBnUl2jq8E9yo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eDIhRbvemG5E3VwwEb1mOjqgZEXZX6MytdZGUetmBM=;
 b=OP7dJlY8cTE6Gyf5hi39P7DVb1P1ctfF3j7ub1/IcsoaAfz06oZtM4S8oMXFCoqrgCw03xmEkzHUu+1bDJ5/YacicZjjZRsEnqU7bIZWAZU69zQFTrve4O71Q4u3MX3KXPI0jYE1iupnL4CAH7+sJ61aFtPs0QHB4R07FyvxE7B0mhy+L0eurnbLjJPayff2EQOkHCs2qly9xEY4If4fHkfF1zW3mQ3EMs6pjQkKl6VV7W5RP/68Kj1C5ziyy4hw51wpYojOnMbuvcf+iwYyPOs8pEDvPVDAXymqMloZZSo9q8eMImRe8rMjc58AyzXoIbR+NjNMFXrOcZpdxoThnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8159.namprd11.prod.outlook.com (2603:10b6:8:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Fri, 8 Aug
 2025 20:26:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 20:26:54 +0000
Message-ID: <47c777dc-0bc2-41ee-8cb3-8a76363d037c@intel.com>
Date: Fri, 8 Aug 2025 13:26:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
To: "Moger, Babu" <babu.moger@amd.com>, <corbet@lwn.net>,
	<tony.luck@intel.com>, <james.morse@arm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
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
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
 <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
 <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
 <0ce4f15c-40aa-49fe-82f1-3a30d3e56f35@amd.com>
 <c2245bbd-1bf8-4fad-9c1c-9f0848c7da39@intel.com>
 <965b7252-5b9f-43cd-bb12-c0e0b203fdc3@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <965b7252-5b9f-43cd-bb12-c0e0b203fdc3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0321.namprd04.prod.outlook.com
 (2603:10b6:303:82::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 507ff204-cf5c-41bd-9008-08ddd6b9ea0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkJQa1VRcWE0aFBmZkpkaEY3VWRqLzBQZ1VQMWZSSWFmZjI0dlp3ZlVmclU1?=
 =?utf-8?B?a0ZxTEtoZ1M0UUphWmZrMXU1d251UnlrZmFRMFVESC92UFdGZFRPdmNIR2h1?=
 =?utf-8?B?cDJGcGxoWUROTUMwRUIzZTNPNkwrS2lJd1U0Q3pNbjlMdTdCZnBob3VPTGJZ?=
 =?utf-8?B?aWRLYVM4YkR2eDVHM1I1S1ZUUmdLQjd6TjVVWXZHbUk5KytFS1BBa09yU0FO?=
 =?utf-8?B?UG5iR1hHR3hCMU5VVmV5L0FGMG1vSEpYSjhLUnR1Vk9CSStIZTV0SG1zWDlI?=
 =?utf-8?B?ZWJLQ2xGd1ZlSzNJZk9rOGRsaFJLaEJiY1BtT2c2SzZSVG1mM2pPMVg3S3pm?=
 =?utf-8?B?UDl5d0N3bDlzN0hLSzhMbXI1NDVINHdoU0NNUHFpRllIVkN0YXNrdndjdlVt?=
 =?utf-8?B?eUI3LzdSVEFBandlRjd6Z3p1MVJZZ0xKa3Rwd0NJeEM0M21EQWdVRDJHMFJP?=
 =?utf-8?B?S3pMNEZkU0N3cGNPOHIvT2I4VnFteE02KzYvS3lpQ1JUby9WcFl6MW00WTRQ?=
 =?utf-8?B?ODlFMFpuMFJPRmloNmFyazU3UktKdy9KM3NPNGdSUEFLZ0E5UFRFTFFBVTF0?=
 =?utf-8?B?eGNvdmxtdWthUVFQTzEzSUJZNU5rQkdaaFA5TXAxVDcxWGRSeFJDUVRSTjU4?=
 =?utf-8?B?Tm0yWDc0OERpTFpxOWIxaUtOSXJFSTg3dHc2MFRxSFljZW1wQjgzY0Q2eHZU?=
 =?utf-8?B?RFBHSG41TDZpZ203L2trT3NFR211VXJGVGI5R08rM1dCcS91K3gyb2NpczJa?=
 =?utf-8?B?VlV0b3hiTkkzc2prV1ZobHd5ejF2VGtZMU4vcTVjTkoraEFicWxvNGtUUktD?=
 =?utf-8?B?OFZwdS9WTHlMQmV4RGV3eHc3VFl3YjVtc09GZGVCRi93TTZMMUNzYXFLaWZZ?=
 =?utf-8?B?Y2svMXBOcE1VQy9oQjViVHJ4K0ZRQTZsYi9VbDhNM001clBRenlmV3A5eWxQ?=
 =?utf-8?B?eHRjUlBZVHN0QWk2UFBPdFA0TTYrL3J0em1tMzVIZEFiRE5XVnBYdGJYa1FC?=
 =?utf-8?B?Z3RtcFJkZlRlcE9SbkhBWkJFZWdzODFEZXBYUzdhazdIdzNCZHNRY3N4WkE1?=
 =?utf-8?B?c2RYZlVLNHh3WnRPdFVjOEJoUEhaTGd0djA5MXJaL1p5YWZBNTlqOGNvTy9z?=
 =?utf-8?B?NndmNjlNYVM1V3VNSFJzRVFDSWEyenNwNE5VRVU1R3VNNUlCY24xejZDeVhv?=
 =?utf-8?B?RWVkN1hPbnVWMWI1WUZ1SC96QTQweVNHc3B4YUpFdGQvYTRSWmQrUGwxSitr?=
 =?utf-8?B?NlMxM2hOUW5FMDhKYVgwSHN2b05aRXZUU2FvZy9RcTZka2hiVGlQc2hVekZB?=
 =?utf-8?B?NS9OdDROYkJzWGl5WDlWSFBTSWUwQ0locTl3SUtsUEhOMzc5NjFMTDlDaFNz?=
 =?utf-8?B?dUFpdVdxN01mMzRzUVBlQ0NPRXBHYWhxRHlyUWFBUVpOM1Z1VGVWQ292Qi9r?=
 =?utf-8?B?U2hCb2pYenhCVmVocFVaTTZ3eGRCcTV2cXRqYTBFSGowZmVHVlgxQUh4TGpE?=
 =?utf-8?B?cVlwYjZFTWFabVhLaStCRVRaZEZqeFlQaFFNWHYxYTNDNjZRNHlrT3RkVU03?=
 =?utf-8?B?UnlrNG9DQ2tQVnkrelBabHdtbjVpV0l2bE01MDljQVdvU3V2WEN4ZVZnUnZW?=
 =?utf-8?B?dVZhSjIxeTlVYkptaVU4WW9POFVVVUlLdEhTcTQySXdmYnMzdXRiKzdFdjhl?=
 =?utf-8?B?V05lbTI4NXUzUzh6UmE2M0pTeWI2a3VKU0hybUM0cFZaQzdTYkFCang2VlNN?=
 =?utf-8?B?Vy9DTzhYZWh2SkdxNGtKZ2ZqWDc2cGJvRWxPUVhYL0ZNVXg4NG9CZmNCRWRO?=
 =?utf-8?B?eU96bC8wVE43eGUwTnNGWEl6T21LblRPYWVKb1pYWk9GQ2l0aExlSG44YWhL?=
 =?utf-8?B?STk4RWlxSjRuMXlkU0orWjJsR2tVRjRYRmk3Z0lZR041aFNLcGdqaU9aOXNZ?=
 =?utf-8?Q?YMrv6I9I9F0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RuNTVpblB4M09keTYzNWNkY25NOHI3MFBhUjdEV1BQWEp4Z3BlaTNRNFVF?=
 =?utf-8?B?aFV2cWxUTmdCcEpKSUFETGQ3MzJVN3grQmlBb1Bac0RQTGQySWVKSjFyeStK?=
 =?utf-8?B?RUZTS3c5QVljTDVYT282VWNZa1hreW9BSE0rN1pLYUFrTHc0cnRTSGNWYldS?=
 =?utf-8?B?NUYrdkNXTm55K2oxUVJKZGpDRXJjUzI3am1uMlQ3UFhBazE5NmpmVE96alhH?=
 =?utf-8?B?NDE1STlQaDdVcjJpVEJITFEyVlpzU1B5ZGROeU1OK1lFOVlaajl0MDlGdTRt?=
 =?utf-8?B?U0VPMkxqNVVFN1JNbDVxODYrVDlzaHNXVitmeUlwY0VhK3E5KzRoUnV1amtU?=
 =?utf-8?B?V0dIWHo1TkRQQTRMZUhscld5dEpTdUdBU2FyTkNuU1BXa1pHdmVpQ0UwYmww?=
 =?utf-8?B?ZUZZRE9iK0I5NlJIMlByd2VKNlYreEY0UG9CS2VaU2hxVHlhbS9JTGRQdHIv?=
 =?utf-8?B?SzV4UzI1cHRMYmJNWER2T1NrOHBhdlZJejBYUDFrenR6QmY1N0RZaWVUTHp4?=
 =?utf-8?B?USt3RzIyNXJzcTZtbjRKWFF5bW9XYU5OMmx0Tlp5c0k3dXZuQkJLMnYreG10?=
 =?utf-8?B?VmFxcmpqQVpLditkVElnQ203Mkh2NG9zanhPOHRkaW5PZTB3KzJHVHRxQjJx?=
 =?utf-8?B?WDVRcG9icVRLSjFDMUxsa3VPZzdqeFU3czl6TmR2MnNkRUxXWGprRWhUa2RZ?=
 =?utf-8?B?YXBYOUY0b1JCMkdCL3A3dUk2dXhneDhSSlRmNmt6cU5mU3E1MU16ODdkL25m?=
 =?utf-8?B?VFJVeDROdm91NU5qNk9hbnk3WDc5eTY0Q3FoR3VhNWY0bTdxVHEwZWpvMXBW?=
 =?utf-8?B?YmEvZzlGWHFBQlJkdVZlK2hwT0tDR0l4NkxnQjlRd1BtTEhNM0M4cFViUHE0?=
 =?utf-8?B?TUhndlZKU0J2bWQ0REcxWDFIa0dUTFhjNlRzTnlhNi9pUlBieW4xNzR4elBG?=
 =?utf-8?B?SFlvNVU1WnpwSlBlOFdWVFdsTktQaVdTaWxzTWtWQzlZQ1FZNlE5di9BS21S?=
 =?utf-8?B?YklhaGhZVndwMmhwYVFkaHBBbVlrc01mRGF5VE9MSUVwekx0TDR0RHhreDZo?=
 =?utf-8?B?U203QnI1am9KQUp2REw2M2tGZ3NNeWI1VC8yQ0tGall6TFhqVkJHcng2V1cv?=
 =?utf-8?B?emdSWVZKM05JcDc1UExJbVI3NmN2QmQza2JYT3VUaGYzZi95TDllZEQ5Z3NM?=
 =?utf-8?B?eDVYQzlGUWVxdVpQMGlocW1acnBLNDNLUCtjVEEwdWJTZnNzS01sZ2VmVEFv?=
 =?utf-8?B?V0duQSt2d2wrOC9pdGM5TzdMVzhXanBCSjNRMktDc2N4ekk5RkR0cHpHS0lX?=
 =?utf-8?B?Q1lnYlptMW1TaS91Z0o1VlNRYjB0RmZObXhFZWZmVi9SYWNtWW1HT0RXckNX?=
 =?utf-8?B?Y1l2S0dUdklCK1psM1ZzY0h0d0ZteFlseWk3WTByOFNQQ3N5SHY5RVFkbVBw?=
 =?utf-8?B?VE1tWkZMVHlJbUY2Z0NNMXZ4b1hJUThzYlI3T2Q3MW5USEoySnZ6K2FXRWt1?=
 =?utf-8?B?SUludThzMFl5QmYxM0NVVS90R2k2WHJuSFF4UWhSaGpJblF6VGIwcTB4QjBr?=
 =?utf-8?B?RThPdkhCZkg1dVZWaEtFQ1RuVVpwbzJiZWQ1OVZNVy9iSjg2QzN6OHQrbGVr?=
 =?utf-8?B?R2pJbGo3eThuOGFtN0FlbFd2VnJRRnUyQ0U2TWF1cnhzRHFCLytyMngwNVBw?=
 =?utf-8?B?bGZWTDhyanV6bHhTZTVtb010bllwU05GbFNSVkFOZXE4R082WWJMdjJld1ZS?=
 =?utf-8?B?UldMc0c5R0psOFB6Tzc3UTc0RWdGVnE4cGpYNEJrMXlTWTlRdU9mTDBMekJL?=
 =?utf-8?B?dHVNWkd6eTZkWmcwRTdTN0R4MTVaM1FLWnRJekNPR0krNnR6MXNZY2pKc3I5?=
 =?utf-8?B?ZUtrOEVOc2lpS2M3TTVwekdnZ1ArV0t1cmlLL0s3eHVHNHdwT0NiazBTQ1hO?=
 =?utf-8?B?MjFPYXNEUW8xc0dUTWhlSDdQN1FCRXZtOTJJN2d1Q1RTSTYwcWVYdi9UMGlR?=
 =?utf-8?B?cXVlM0RUTXhYdU9Ta0V4SzEyWm8yeHlTank5dXlFSnFWSG12UkhkWnA3ZnRQ?=
 =?utf-8?B?RkZTckd4amxJZHlpMGRnWjlQWmhOK2lZNjI1ZS9aVnZzTUpmNlVGbmFaUU5G?=
 =?utf-8?B?Y0RVQjdCbFZXQWpENUpCeHR5UXd2QWRNYmdTNmFUVVhseE9iSENZVWFZTTdn?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 507ff204-cf5c-41bd-9008-08ddd6b9ea0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 20:26:54.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4v6M0bAeoqVR/bCNIBaCA2JqbM+q8UR6ilibQQoV5GdvZG05wA2inlGN1AI2Znv9m/FoFsrD81FZhzKsxMEE1P7BYIEdHUNYigJJqZ2JaSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8159
X-OriginatorOrg: intel.com

Hi Babu,

On 8/8/25 11:48 AM, Moger, Babu wrote:
> On 8/8/2025 1:23 PM, Reinette Chatre wrote:
>> On 8/8/25 10:47 AM, Moger, Babu wrote:
>>> On 8/8/2025 10:12 AM, Reinette Chatre wrote:
>>>> On 8/8/25 6:56 AM, Moger, Babu wrote:
>>>>> On 7/30/2025 3:04 PM, Reinette Chatre wrote:
>>>>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>>>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>>>>>> index 16bcfeeb89e6..fa5f63126682 100644
>>>>>>> --- a/fs/resctrl/monitor.c
>>>>>>> +++ b/fs/resctrl/monitor.c
>>>>>>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>>>>>>         {"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>>>>>>     };
>>>>>>>     +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>>>>>> +{
>>>>>>> +    struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>>>>> +    bool sep = false;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    mutex_lock(&rdtgroup_mutex);
>>>>>>> +
>>>>>> There is inconsistency among the files introduced on how
>>>>>> "mbm_event mode disabled" case is handled. Some files return failure
>>>>>> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>>>>>>
>>>>>> The "event_filter" file always prints the MBM transactions monitored
>>>>>> when assignable counters are supported, whether mbm_event mode is enabled
>>>>>> or not. This means that the MBM event's configuration values are printed
>>>>>> when "default" mode is enabled.  I have two concerns about this
>>>>>> 1) This is potentially very confusing since switching to "default" will
>>>>>>       make the BMEC files visible that will enable the user to modify the
>>>>>>       event configurations per domain. Having this file print a global event
>>>>>>       configuration while there are potentially various different domain-specific
>>>>>>       configuration active will be confusing.
>>>>> Yes. I agree.
>>>> hmmm ... ok, you say that you agree but I cannot tell if you are going to
>>>> do anything about it.
>>>>
>>>> On a system with BMEC enabled the mbm_total_bytes_config and mbm_local_bytes_config
>>>> files should be the *only* source of MBM event configuration information, no?
>>> That is correct.
>>>
>>>
>>>> It may be ok to have event_filter print configuration when assignable counters are disabled
>>>> if BMEC is not supported but that would require that this information will always be
>>>> known for a "default" monitoring setup. While this may be true for AMD it is not obvious
>>>> to me that this is universally true. Once this file exists in this form resctrl will always
>>>> be required to provide data for the event configuration and it is not clear to me that
>>>> this can always be guaranteed.
>>> Yea. It is not true universally true. I don't know what these values are for Intel and ARM.
>>>
>>>>>> 2) Can it be guaranteed that the MBM events will monitor the default
>>>>>>       assignable counter memory transactions when in "default" mode? It has
>>>>>>       never been possible to query which memory transactions are monitored by
>>>>>>       the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>>>>>>       so this seems to use one feature to deduce capabilities or another?
>>>>> So, initialize both total and local event configuration to default values when switched to "default mode"?
>>>>>
>>>>> Something like this?
>>>>>
>>>>> mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
>>>>>
>>>>> mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;
>>>>>
>>>>> We are already doing that right (in patch 32)?
>>>> Yes, but it creates this strange dependency where the "default" monitoring mode
>>>> (that has been supported long before configurable events and assignable counters came
>>>> along) requires support of "assignable counter mode".
>>>>
>>>> Consider it from another view, if resctrl wants to make event configuration available
>>>> for the "default" mode then the "event_filter" file could always be visible when MBM
>>>> local/total is supported to give users insight into what is monitored, whether
>>>> assignable counters are supported or not. This is not possible on systems that do
>>>> not support ABMC though, right?
>>> That is correct. With BMEC, each domain can have its own settings.  So, printing the default will not be accurate.
>>>
>>> What options do we have here.
>>>
>>> How about adding the check if (resctrl_arch_mbm_cntr_assign_enabled())?  Only print the values when ABMC is supported else print information in "last_cmd_status".
>>>
>> Did you perhaps intend to write "Only print the values when ABMC is *enabled* else print
>> information in "last_cmd_status".? If this is what you actually meant then I agree. I think
>> doing so places clear boundary on this feature that gives us more options/flexibility for
>> future changes.
> 
> Yes. That is what I meant.  We have same check in event_filer_write(). Will add the same check in event_filter_show().
> 

Thank you. This makes this specific behavior consistent and addresses the
topic that started this thread:
	> There is inconsistency among the files introduced on how
	> "mbm_event mode disabled" case is handled."
Could you please check the final work to confirm that the new resctrl
files are consistent in handling of "mbm_event mode supported" and "mbm_event mode"
enabled vs disabled cases? For example, they consider same scenarios as valid/invalid
and return same error code in invalid cases.

Reinette


