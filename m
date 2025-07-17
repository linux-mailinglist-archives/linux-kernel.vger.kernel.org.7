Return-Path: <linux-kernel+bounces-735844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED9EB09461
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C750EA63FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5502FEE3A;
	Thu, 17 Jul 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/ZWu8Wn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4D213E6A;
	Thu, 17 Jul 2025 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752778024; cv=fail; b=XxPsOuBuDTc/CbgKO7QKNkGE5GfoctRs6CSkV7pBGsj7xbxTUQvjuB43hvCTbj1kEziXweLc6No21Wdb4+o/WF9skM/ZJ/AX8UENJaTsIFnHk8lZNzO3Sy32rEvfJDyjP7c8ioUTUmlFKqecT4rH1PWLZ2+I5d4kx/aa8KJL9RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752778024; c=relaxed/simple;
	bh=xOY6zR3+VRkK8GQkbstKwUPMMhbCv0QexI3wgylSnXk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nY+YmqcnKpfoIWgi2t8/rV9VFxRAHrzvxf34tv2mEgy5I6Gjs8ZJmXrtUQ19GRGQ148/axGfwureqIyyjN+u6fPJDwUKgEc6gVFHMkn4wqgdZVWoWMeGjO7dTq/xAjHW+g/7hov4uVqniG5HSZoj0RXnKA6VJUfUVmDnqXwoBRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/ZWu8Wn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752778023; x=1784314023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xOY6zR3+VRkK8GQkbstKwUPMMhbCv0QexI3wgylSnXk=;
  b=d/ZWu8Wnm/TBgY/9YifJqxwXyg1eZP2LFW70dqI9c8JzEWi7PKmz3ct7
   wQw4YZKwA1CHdVaX1pBvLY2Q1oragr4Q7kiS8Kh6Xm8JN+voR809icZS2
   9nr4oAozyasCGQU2qBn8ecNWYyAYbJHfmPz1EY4+G3pt3BrFSmVG+RL0F
   aIBbwZwVXrd777bZmaSCpJMrXJUlppPWrfrDgMP/ZNWlU4TUkrRsOxJ0Q
   31UvTrukgP6J4Vxt6523yH90FjyDhis/sjRvesfLxy/2/W83izh1G+cGM
   T8wQ6YxTrpquMzti+dFrcgWQA3Ii9Hk/JNajlwoJWgr/A1UKzAoZM4oCJ
   g==;
X-CSE-ConnectionGUID: 6Y3QM6zXTNWyZGSsnfhtQg==
X-CSE-MsgGUID: bKLVA3kQTPKsyNwhuDponQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54781151"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="54781151"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:03 -0700
X-CSE-ConnectionGUID: 20SjuoQVQT2mVx0Ke45Jhg==
X-CSE-MsgGUID: QO3LcTV7S7yIUxyFR0of9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="162401958"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 11:47:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 11:47:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.52)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 11:47:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG30mTzRA0RBDwWzxC0f/pdw7s+3OR9IgnatBFcPuGAFw8P8Z2Z/bXfyZitfE4egpOdsc4x172uD4Oy/P68zMzQbr+JOgtvXQMkEI4NLOaxRvDEwoEYivz1m3Y/16gXM4B3yUVlZWqSkQdxQALpB5XTrfCqXDAcB1O6WoM6/56Co/1Q4LkywU/HAf1QgQOPJfAHRZYh2t0aghYO80g/W81sR+Z/KY4HHFc1fXI0zA0AN15OR5MsSLkHN2hZCONJPZnnXQyZz0O/VGaNuMQQ/1O2ZMYsHmcJ91O0G7/izP6YHhybKy1dfFw0EKFYUzBo25hD1tv25iS98bFf9KDT5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Lq3B5Nza3+o7TsJntavRaNODtfL6eQ+itloFLAhdBY=;
 b=bydF0bhIbvzCvOySroZ/37MlRkZDsFQal1Y/PrGNHDL7N0k7h/pTCDigOeH7GvZd8HwNCUCu/40Cm5XGuslpG3NX9oJS/8RyYI3H4LWBYZC/9+tT+FMIplMHgoxadl1keUBahjs6ZaGx0jU+8lBADM4J3SuRNnNUZr58/sTvNApfBUjijeWlTR6rgcmMSy3fnItFZjJ9Zb0jSezu3/HwD/JPJ6ycZxL1dYqdlaB5qcXZSD8Rr+3jSaAOZAWw54w9FPoa7ZljKZYz02hR9pMYQcK0oKH4UHtbP2bvFw0VvpcEggoISGJZPgaIThuu2m9QNeG1AtdUI0qK+SogRqH7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:46:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:46:41 +0000
Message-ID: <b2966d36-751a-480c-be75-548d29798a92@intel.com>
Date: Thu, 17 Jul 2025 11:46:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/34] fs/resctrl: Add resctrl file to display number
 of assignable counters
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
 <c2d804df633ae7e7a2dfabbfd6b4e2d774dfe394.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <c2d804df633ae7e7a2dfabbfd6b4e2d774dfe394.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a32edd1-6b17-4817-4a53-08ddc5624509
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YS9BZFovVW54dld0MExNM2Y4WDlMWDRhMUoyVVJDT012cVRLRXJka3B1S3Iv?=
 =?utf-8?B?dmlGZVNhT1UycTVZVHBOYUxjWXdoUW5BZHgvelcrWmwybU5kVVQ1UWJKamp5?=
 =?utf-8?B?aEpxR0g4cjBtZ2RRL01XU2FFR0U4L3RQY3pqcUMzeWFKcTFpQzkwOXFINStQ?=
 =?utf-8?B?NE9kaUdRNHI4cGNaaG9YNHk1Y0ZNSVpZMGNBUm81SkNaM3FwZytYUWtJNi8x?=
 =?utf-8?B?QktvRWNtSjh3VENwbHloOVRtdU10Ym53KzIzT1FtRlBFSDhOa2VhZW5BZUlZ?=
 =?utf-8?B?eVQzdE5oZHJlV2JkUkpMZzFLK1hwLzJaRXNkZkYzeXhhQnNKNys2b0lrRHY0?=
 =?utf-8?B?eXlldVdtQk9tLzlQT2dURkJtcXlzaWhaUmVRb0k0dmlKSFFjZkFqS2hSVTBZ?=
 =?utf-8?B?R28vay9XMWZTVnVjUDFxbzFMcG9VM0FHUG4wcld5T2NBeUZ3SFcxNlZwWlE4?=
 =?utf-8?B?MVNtTU1ZSFBlUWNKMW9yQXlTRlJMSnZ1S0lITUkzTXl2S2llTG9nS1RFejA0?=
 =?utf-8?B?MmN6dWJLN3lvdkRHSVdGVHBpcWhic2FuRVB5Y2hrRG5RdS8yZ1UyZ3VyckIz?=
 =?utf-8?B?dDlnNllhaTVZd1Z1T016MVErcDBIU1hCVnJtNVdlTWhaZEZDTzBMQms4T3JE?=
 =?utf-8?B?d1JoeGlnZjhEYzA1RGd5SkNTSmlEbTkzcUptYi9JeWZGY0xONkxwQ25uTkF5?=
 =?utf-8?B?c212Nys2QWkzZWlKdW5IZkxrYjYxOXVNS2ptb1EvZ0FnUnExMEczQmY5VFhr?=
 =?utf-8?B?blllNkhkcEkvWGV5QkdhTERMa2lUN1hzbHY2S2d4UEk0TmtFbmJOT0FEZGEx?=
 =?utf-8?B?ODZIdVZPbW9NSVFLQzRrc1lmVWl4QWlza0ZodG43OHI4dmZsc1AzdjB0dDdZ?=
 =?utf-8?B?aCt5WGxFYldSK1VxVklyNGk2bE52OERVcW4rQlpVWmM2QmdaNHFtRTlnQzZP?=
 =?utf-8?B?UW56YnAyMVU4cFp0d3B6cEtvNndDSGNnbklSSVpkdlVTU2dDNzM4VWZyNTdQ?=
 =?utf-8?B?cGpVYUZLVE1zdERYc0t0by9sckJZa2N0ajNOdE9OOUlSeTQ3UWd3TGFQUTZO?=
 =?utf-8?B?allSd2NRNFdrNW1Bbm5nbmhQUGp5a21kNWdsZU9WMEZFMTdIU09ZZXlYWG1p?=
 =?utf-8?B?dmlEWFJOeDRNMHJGc1hWUTFKWUtRV3pUdXpha1JrVUF2aURZOTJzSWlsbFEw?=
 =?utf-8?B?Rk5ma2JWR0dMWUpvYkRJV0pCUmg0RUFndVVPZGhLcHNrVTEzMFFhVGIwTk5u?=
 =?utf-8?B?ZnRBT3V5elA4Tkl0RWtVZDkwTkdabUlqS3pYY0YyT0pSUnVNZzN1V2tVRVVm?=
 =?utf-8?B?N1NIdzhsZktXZDhNeGNJTjVZOTE4ZThycVpoSTE0SnMwcFNDQUV3a2xhUnd4?=
 =?utf-8?B?T3dRYnpPQkNCK3RleFhFeS9VR2gybFhJdlFkWmQ3Zk5mVlZvWFFuYWRNSFJv?=
 =?utf-8?B?cXRhbVI3aFJrN1BHY3liMFI0d3owZWV1SDF2THVsQzhCNDBKa1ZKK0h5dU85?=
 =?utf-8?B?QjV3ejZJSWE4ck9ZWXk3YzZOYnpTcE9RNUx0OU9LQnZ1bVVvVlRsOXVPUU5r?=
 =?utf-8?B?TFdkc01jaGwxZ3Yvbi9ZSG5XdnE2TG13U242eGVmdHN0MWVrSVNCMlRHb1Qz?=
 =?utf-8?B?NC8yOExuK2J3SFE3SWl0dlJ3RjFsbHQzUTIrVUh0R1RqR2VpOTZROElKWjJO?=
 =?utf-8?B?TEoxb3FzTEFmNzZvQkdNVzFWL1NkMWcxUjBKVnhPNEVUUERYd2t6ZHFCZ1gv?=
 =?utf-8?B?S3llY2F2cE1NbzgySDN5UFgvTFY0ZUhkTFE3c0o3eE5Rb0tDMGNXeTBONURI?=
 =?utf-8?B?cTZSZXVLelJ3dEhWeVk1NGo4U0puY3p6U3VBbzEzS1Btek00R1VaYlR2elQv?=
 =?utf-8?B?M25oUjFDb2dkTWFIeG11Zno2MG52VFpwMnFnM3NCdE5Ub1NOdTY3clU4OXBS?=
 =?utf-8?Q?F6RSvTeSzCw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVVXeDVEMi9yVTZFUEVrN1U2Nm9VaGkyUU16dTVoanIxNUgzd2pjdURIN3hM?=
 =?utf-8?B?UmJlQlJzeVhkTXZZZ3FuOXAvSSt2a1VJaTJWMG5rMmF6bCszRktTcDhGSnZC?=
 =?utf-8?B?TmpGTzFRZXR3K3FBUFJ2cUJnM3JuZlhRcUZsci9GVWFRT0hCTEhSc1UzUURp?=
 =?utf-8?B?Mi8vYnUxcE15b0RNZnd0eEYvd2J6dDBCdHhEWXlrNmMyd0Z6UzBVVUNUbnM0?=
 =?utf-8?B?K3pHbVh0Y1FlemJmRVYvb2dCZVhHclZuVkJ4R21qbUxYc1JoamVhNkN6RUZv?=
 =?utf-8?B?TTdxcWxQcVRNOWI1M2pQc0thMHUrN0MrVUViQ2N6WXUraDZISENTbnRhZVVv?=
 =?utf-8?B?b21qVTI5NTlSVDdqZFJEYi9ZSXNZYmUvQkFEcythS3FQc1V2TVRLeWErQ2la?=
 =?utf-8?B?S0dZMGtVMG9CMEw2OGp3TGhGVkFXMTV4SUc4NTdpeGJ4L3lFd1NrdHpxMW5S?=
 =?utf-8?B?Z0ZoNXYrMDZxYndvUVN5K1lQVVdGNGdheXJDZk15WDRIcWVHcXVhakhNeEtV?=
 =?utf-8?B?bTdlTTAyeE1qM0NzdzRvTmdKUkVEdE5ESCtlbkgvR1NvQXhrRXRnbmtFdTha?=
 =?utf-8?B?cllJTVJteEJvb0hhWjY2cHRRM2Zpd2w3M1JTZStGOTN0QTJkWUpORmJlODdG?=
 =?utf-8?B?RDJaMU1GcUxVREozRUpDT1MxQmpqdnR4M3A4NUErdHpBZUV3Y0ZNMnUzQWd4?=
 =?utf-8?B?UjRtb2RSL1dIYnIwcVB2SzBTdCtrSThyYWFwN2VOYkFkZzVXdHhDNWN2bFpv?=
 =?utf-8?B?UUxiWFFQSFNWdStqaEZiQzJ4ZVFselFESWFXRWRnbzBGQVF0U3BOQ2xTK3lr?=
 =?utf-8?B?azFKeTBDamtXR3NXUzBvUVpUNW5NNVl3dkFQYyt1T2hBbVFUVFB4VGlqdUkw?=
 =?utf-8?B?UVF0elZJeXkvRmtBUkJPS2RhWmJlSmZ5c2dMYVNGT2lFWXpYeDlkOWYwQzdv?=
 =?utf-8?B?cWhPQU1DZDJUZ0lxdzVpcnhub1lJM25TRHRnbzJyK2JQbmswUmZkK2RvTkU1?=
 =?utf-8?B?OGZmU0ovVVdaNXd4SkZmbEpYZFJpTGk3MVRBNHpxTEh3SGFXd1JzU1JlOFdu?=
 =?utf-8?B?Smo1QnUxNFNqd1BVQ0VPMlo3aU8xWi80anI2TW9sV21NWmU4akJvQnJDZjFx?=
 =?utf-8?B?S0hiT3JjVFdiakxJdzUxeUNzVnk2VlNEUkE2eVNNdlJuSm1hQytnN09RQTRS?=
 =?utf-8?B?WWd1ZG1qZysvcDJCaXNweVE4VzNnYUd6WmRJZ05UMEgzSExycWFyWFhtSS80?=
 =?utf-8?B?SnROcllVZ3NaT3BtTkVUYnhERjV1RlQzZ1NBZXNSY3JFcVI5OVJSYmYxODR0?=
 =?utf-8?B?T2c4K0hSM1I5aFlnU0VSdkNRWUN0UnRBWnFVL3I1YlZiTWRjK1pEdU54Q1NE?=
 =?utf-8?B?SHF3dnlvRmViWjNmSEJLeDg4NnRwanZrdVFMU21GTitWcUl4Sys0eVAxa2M5?=
 =?utf-8?B?NE9nOHo0OFplZVR5V2daNERQdmZ3RC80bC9FOEV2cGlmak83LzNXcmxjVHZh?=
 =?utf-8?B?d3FEVlVibnBRZ0s2TXdadGNOcHRxWXVTZ3J1YUlZWllJb0kyY3NMV1J4ZFFw?=
 =?utf-8?B?SjhPVnhWMVVYaHpTQkZXYXF0YnNvQ1o4MVdtMVprelNOYzV0bjROQTU1WWQv?=
 =?utf-8?B?MUxhRTlyRjgvTUhXMjJiUzNVZFVuMGt6RG1Sdy9BZkJmaGx2TjBHb0ZMbjg3?=
 =?utf-8?B?bXJzNTJwNzNKLzYwWC9qMXZaOHU5YS9odTRjek0yQ1pwR2dxNVJPQnRkT1FS?=
 =?utf-8?B?TzJBTFVoOG1KSnRlTjlUbXVqTnF1VklmSzZwZlBWTWJ3QXNJTFNVS0M2d2ta?=
 =?utf-8?B?ajRUcGhWb3haWHBaajJ6bGhtZmRsdzBnK0F0cFhpVi8xbkdxVlNPekREUzRa?=
 =?utf-8?B?RnNoMS9UVXFpMmdCeGpQdExGS0RRN0U2ZjFCanZjZ3FyWUREN1hiaSs1Y2VS?=
 =?utf-8?B?NURmdTNER2RjV2c3QmJ1QVN3WFUvbWFWRUFWTTJWL3I3MXkvaDVlTGwwUlMx?=
 =?utf-8?B?ODJiYUpQZ0VYRFhXcVhXSDBESEhEbFloQW40ODJVS0VZMnVNbEtWbjY3bWVv?=
 =?utf-8?B?YkV0OW1PcDNCanRzWlFzOXdzY3czdzByYUVQd0VTN3RzREhqUTlPMGxyak5B?=
 =?utf-8?B?aGI0TlArenBwQnF1RmJpdWdHWS9aQWdiN0dXV0N5UW1aRTFOTWhrNTBlQ1Mv?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a32edd1-6b17-4817-4a53-08ddc5624509
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:46:41.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1taFLJW0nT9gP0Erzir7Q6coFvNz7+wzkHWxarR9V+bMvIBksw0pb7X8Hk69/sLGmChjEd5iaYtAs2OGdqkBoyCMgD4NK1z1OmOebfbhMcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows users to assign a hardware
> counter to an RMID, event pair and monitor bandwidth usage as long as it is
> assigned.  The hardware continues to track the assigned counter until it is
> explicitly unassigned by the user.
> 
> Create 'num_mbm_cntrs' resctrl file that displays the number of counters
> supported in each domain. 'num_mbm_cntrs' is only visible to user space
> when the system supports "mbm_event" mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette


