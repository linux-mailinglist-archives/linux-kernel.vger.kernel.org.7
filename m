Return-Path: <linux-kernel+bounces-751292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61935B16753
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48BF1C201A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9551C20D4FC;
	Wed, 30 Jul 2025 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dj3Ia1Lj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E61FFC55;
	Wed, 30 Jul 2025 20:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905843; cv=fail; b=o8Zq8uCq5NBZzxsejBedG3S7q74HtoqyB+CvkEN3rvrBO7bcOojwmM+VOobFUoO28COOKjLvEmjp0esrUcQs0Di0bGBEXVvG75aC4wtcSh+4rFZgPA9TDVY3LDOV/RitleKOgC939o//02KxyUZRRzeHpW6CKUlcJ2VRfs3gauw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905843; c=relaxed/simple;
	bh=tM6np5gr+Njsal0WQskXUE1jadSfJz9j1nsoF2OyHFg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SRKftAwcALm/VBZfSR5TXL/DWxl+DkpqXNLULzDlhf8EODx1P3vVaDsnvfmA1e2G2ZILWfvIFgnh0aON3lRupD+HwMqVCVufLuR0tOgwPCt5n30CLTlC7abzwNP9vzBM7YVqII4NS73y0k9do9kTnNpJNGl1FZWh3ov7dNw+ZzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dj3Ia1Lj; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753905842; x=1785441842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tM6np5gr+Njsal0WQskXUE1jadSfJz9j1nsoF2OyHFg=;
  b=Dj3Ia1Lj19YzPBOm0uXUTeyBppnKwRASuqfnTwIlXRrUqxfon+k4bOCg
   NCa4+97KZsWA+faHLjB4tqLZ7yIwJvAkuGWnuZ/gl/oVgAYJ4M916SBay
   JkBr5j2qUs6RLTTqltfXYcL348B+XzFgL5LrPK+7Ht+oS6FoiGfy6RFhK
   wkmSHXbV7pwycM2bEg0drIix56YdDNUMEKE+rUVDiYFnIRyg3bsskgiS5
   rnwTIjLMh7hl/qpEhW1ls4wHY0DtTmFaOX2VnC5dYFqwjQfTN6LR5vWVD
   RR8QHpBVQTb5xKlyiPoeZJi0ta55SX7BIIeBURDH/V+sZqXGYppxyFX1F
   g==;
X-CSE-ConnectionGUID: olttAqeoQUSUTlX8DT7M3Q==
X-CSE-MsgGUID: mIuJ+qKHRxKNRTVqP/yEkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="73677890"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="73677890"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:03:56 -0700
X-CSE-ConnectionGUID: Wn/KSn98TIK+53TSycj+2w==
X-CSE-MsgGUID: hepWopoASSSFHWEkWGPExg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="162786984"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:03:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:03:53 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:03:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.87)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:03:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twfJ4qmeUuxtam71jqZ5NU162wzVp4LnCC/sla/pL/Cz4Dxtx09ftBmftlMR2mRcVCO1uSOLXMgwWnaRhh5AKQ9RjviNQs1fT3guZRrTfbJOhjRaGrh/3QhF8nmEzJJppViRRNuw2KVBVC/c1s3vxHWpJjMJLPLnAMd5YGB5jRm0NKSoozj/J/4fhVscmIbxZq2i2YpC/g5QBMUQCQzrYXLF1nJtGFknAqY6S2omclZQ/5l8CBnQ+qiefOgpvCj/Bbp+JbstaleyvLrhpCN07uqwDlqW6hlhRMuOPbTy2wGLWwGznSzLViCiZ45lgHQPxVM3jvsC4YQrhf1Y3Xs8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fjm/k0QRqnvBpranD1GmflyIesLDBGCz1UVfKDwho0=;
 b=guYPQwicBHhhILCT2veViIrg7PjaiU5lzaphexC+PfqnpvYjW+tqwnyriAhrLTka9UxHvD5V9NJr8gkW4/3ndtCenb8P/HdNPOei4wB7ysjxzyodAm45j2eZWx/3+OONsh+qgXTttfFe1+D9MttseoaUJI6cUA3ACosNLkgR1nLxSdau2vMYIjnzGvgSj4AqJAq6fddERuYFzKlCBRylHTRoEqN2sdi/Ph8ws58fLMjJPuXn/VzOMVilhGhMF/XkTsjDt9Ep0wwlmueREK9RsaSCD3u6hzKB6SrjBDguUgXWyUiCZXD05COxeBxBvElCN7qxxOAiTTDKM8t9PwtDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8582.namprd11.prod.outlook.com (2603:10b6:408:1f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Wed, 30 Jul
 2025 20:03:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:03:51 +0000
Message-ID: <368b7310-6ee4-4fa7-ad8b-428d05136328@intel.com>
Date: Wed, 30 Jul 2025 13:03:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 24/34] fs/resctrl: Add definitions for MBM event
 configuration
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
 <b32329e151c841f2b93987edf72ef39d2cde9191.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <b32329e151c841f2b93987edf72ef39d2cde9191.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:303:6a::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 685f0d9b-22ba-4c2b-fc9c-08ddcfa43403
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkcycHI4clNVUWtYa21kUHNJU2xqNjBYcUNOVXd0aUZMS1EyNmNFUWNHYWpz?=
 =?utf-8?B?dHB5dDlBSER2MGxQMnQ5OC81cUJ5RzJsc29HRW5WbVpLM0xQMFp4NUR2Vjdz?=
 =?utf-8?B?aWNnYmVqK3Z5Z2ZQejNxUUZ2QkJCM3RuSndVQVRPdVNVVTJ3aHozOEw5ZDFs?=
 =?utf-8?B?M0szdXV4Tm9STnJLcnNyNjh1T3g3MUZjckNVd1owR250SUxteXRNNXdzWUJQ?=
 =?utf-8?B?OU43NVd1dm1NZmVDUFVNM2puVllvbGd2TklXU090bFQ2TFdMR1V4Vm15VHQ1?=
 =?utf-8?B?UE8yVmkzaGE0T1FRQzgweVVSU21qOUU4Mk9VcFROOWZTdThwd2lhRkZlTVc0?=
 =?utf-8?B?Tk1TR2dQQVpOdzB0Qm9iMzhOWjYycmxKWGtnY0FGRXg5SDN3VXpYTUk0Zk5Y?=
 =?utf-8?B?aHpKZ0tsRkhCbFFuTzZ2cjN4WEtoeU5YN0NUK1NFdzJZSHkzVjBOMkRVYWMr?=
 =?utf-8?B?cllBYlV3QjlGdTRSbFRwZHdvamQvSVRVS2ZqaFBDdFhmNFFxSC83YnFJOXRz?=
 =?utf-8?B?Q0poeUMzN3J4SjhXUE56UndOQUZlY0NacUhmOHl5Qkc0QUZ0MkNjS1R3YWhr?=
 =?utf-8?B?Q2VibkdydTFzd3p1QXM5VlY4QzMzY0JGTmY3Q2lRZFNUWTJ6RkVWOWNiNWVs?=
 =?utf-8?B?QVVrcmk3RjJaQVNEZWxDN1FYaWtYZ3Y0bDFRUmNEU1FjRnVnTXlxbnRzUVBl?=
 =?utf-8?B?Wko1SVZaTDlCRmxsWDRGKzcxdmlsVmNUZlNVNXoycVdISS9MRWdLRUhzTG9l?=
 =?utf-8?B?Nis5UnJnUGtyOUdTZCs3RktWL3d6YUtwNVpkSVg4ZWNOeGlzRC96cDRNZG41?=
 =?utf-8?B?ak8zZW5yQm9sdGhxTjMxN09OMStQdmZ5L0c4ZEU0cWFQZ3Mzb3RKL0tKWmo1?=
 =?utf-8?B?NWdUUG4zaG5zNEUzSDNBekk2ZW9UUUJCNTFtVDR1Z0JoQnJ4Mnk3WFlDVmJL?=
 =?utf-8?B?ZGhWRjhRektrV1hBZDIvMG1sRUQrYU1OV002Ym9CVG52RGI4SkxGZHBmeUk1?=
 =?utf-8?B?VWJpejRKMG5YUU9OMmc1ekFaMGJrTGRRWmkwc1VDb0M2TlVFY0owQ2hFNTdU?=
 =?utf-8?B?OUx1ZkdNalA1VzMvR3RpalA3R3MzcERycTNqWklzSHB2eFRyNUk4NSs1dGVV?=
 =?utf-8?B?dDd3cytCdlR4TjFmRFA4UG45ZDBRSXBWbXJ4b2NtbVF3ZDZBaVpNaE84d0NY?=
 =?utf-8?B?cnYvaFduM2lVYnRkY1A3VFp3TmR1U0l0b3poc3hSUkhnSmJidDdydFZkbGxt?=
 =?utf-8?B?U1Rya0loTy93T0tMNDlJQm1DNURqN0t2SzNKeUgwUUFMRzF5cjVKZXE3dHI2?=
 =?utf-8?B?NDNmckliN3ZRd1lRMmFrSVJ5UklRT05Ub2QyT3lKcis2OUEwVXNoUXNrQmhN?=
 =?utf-8?B?THBwSC9LcFM5OEdWYWVXS1Z4QUl2T29yVG5tVEV2a0VSMVVNaWtQZ0lhOFJU?=
 =?utf-8?B?OTV4RWhrZFRpK1J0UW8xdHlMdTFmZXdtMnhXMnRUU0lPMjVDanVYWWhram9F?=
 =?utf-8?B?RlF3dDZ0TFFmQ3NsWEQzYk5aaS83eldPTWdWM2hlR0NndE1UQWJIR2p1Z0Vh?=
 =?utf-8?B?S0EvSXd6R1JzUUFnSEFaM1hDQjQvOHVwSmgvUmQ0MDlyWVk0MTFVUGY2bUcx?=
 =?utf-8?B?SWZFZXV3ZHczaUw3WThvQ3VBc2x4UlltLytFUFRhU0U2RlFxTlpBWkx6M0lp?=
 =?utf-8?B?ckttcHVuRFo4b0E3RnpXQTdqbjVtb2JYTFViSFZqMk9aanpabElVdEtqdFNt?=
 =?utf-8?B?WEVheHd0dmx1UXBqOVk3emZkdFRrR1RZbVFXZCs1Zk9ndmc2SCs1dlB0R2hM?=
 =?utf-8?B?QXJNalRIbUx5Mk9NSDUyME9HZGZkbDVnaEdiWlZ2OTVXbkZXM3BGRUxJN2hW?=
 =?utf-8?B?Wk1EWlkrenVGNWpLTk1MWVFPU3dWM2J5aFcvdlFHbW1Vd2lqMzEwOGQxdjVj?=
 =?utf-8?Q?MrZqrTcptT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFZEYnZmazQ4SHdGWU5aYVFGNDM2OUM1WEtFQm1LZVpoNlRwNXM2dFVMRThp?=
 =?utf-8?B?cURHaTgyek5CMW9SanI0VEo3ZG5SQU9UWHpYUFBXcUtxTE12dHlxelRtWHlN?=
 =?utf-8?B?dzV5aFBnM0NxazlFQVlqRmRuSU5kd3JtQ2w1Rm9lUHFjOVRzOWROV0E0UWxC?=
 =?utf-8?B?VCt1Um5GejY1YzNjNFY1Zmt3TTBWS0EyT04zdXdEbm9RWktNYWVWak50eHU3?=
 =?utf-8?B?M3l0U3lvUHJkSHBVdlp1aFhxay9UK2g2a3dFYVZVT3YwcUxIeVBxK2tJc21Y?=
 =?utf-8?B?QXZhYXg0cjRLZjRxTFRZZnc1b3ltS1ZZcDlvV1pBWEl0RTVjcW9JRmRrcXpn?=
 =?utf-8?B?MC9IVXM1bktHVUhpNnRkOWs3dC9tSkg1MUVnT01oMTBsck1UZmQvVXQ3KzRl?=
 =?utf-8?B?OXlOUDN6ZWtnbXZJV1o2cUlwWU9vSFppQjBOb2p6cVRTR2NHTmN5bCtmMGdG?=
 =?utf-8?B?OWpOMzNmbm9yOUYrZVpmdGNhR2M5anJNVlZpWmZ1Q2JUcE5NK3h1TGNYZ0c1?=
 =?utf-8?B?ODlyTjZUWU00a1JlcXFOeEpQTk9VZ2hnWCtqSEk3MjlPRVhMZ0lrUDQvWlpu?=
 =?utf-8?B?U1lhZ3RsVkthOENhSVNZL2srcXhEU0FhMUFVckllMWlzaklaZm9IQ3BwRlR0?=
 =?utf-8?B?dkJ1SDdWTGg4cXhucjNPaTkxeFQvVkNlUllVQ0tOOGI1WkdOOWVhWWI4dTJK?=
 =?utf-8?B?eTNPdzFtN0UzQ3VrNldYMkFhY2V4UVlDdGd0S0VJNFY4NE5zOXNiSFA3OUtM?=
 =?utf-8?B?RG5GMTRBNFZvSUV2Zml5MVRDaFVEa25PZlE0SHVZb29wam0zeHd5TDhRdHZW?=
 =?utf-8?B?M0ZNSVpYSXhZU3M3NjNCSENTVk9yMXVlRGZSdGVnU2kwRGVQSVNXaG1MT041?=
 =?utf-8?B?Y3c2T3VwdThFWEFZZTRkZTRJemVmSzlOSEhGU1dlb1hicEFqcEw2SjVBN25k?=
 =?utf-8?B?TDV1SDZJeFhFZXFvVXBLVzE4SjA5YlJBZHlMbWxhbVJhY0NuemJSNVZxcVlj?=
 =?utf-8?B?S2QwdlFTL25LeW1tQ1lob1E4V1ZkR3I5Q3BQejhPS1c4dTdsUWhLOWZIREpj?=
 =?utf-8?B?UHlkcTB5VTlxdnVudjN1ZXV0NHZMTlRwNGRKUUg4bC90YUR1UjdaMTkzK2Na?=
 =?utf-8?B?SDZBMlF2VGtTSzVOZytzZjR1d1lYcjlnTFlyYTZBUnJTRExXU2VGSTJjTjlJ?=
 =?utf-8?B?czN2cHg5Ylk5aTBvUlA1Y0EwSk9sUHZzcjNxMmtxMGtnMDFkTVJNL1B3MC9F?=
 =?utf-8?B?MHBqbk5yTm4ydVcvTFZZbmkwNXIyZ2tDS1VzaE9DQnowNS9IdDZ1ajBONlFk?=
 =?utf-8?B?QUV6S1hvU2tIc3YrWmxNd2pic1JGVkJ4OEJReDgvL0lNQVBWYkRWajZxYWNZ?=
 =?utf-8?B?T1lxTi9Eb3d2VUtsaDlzbmcrK1Nlc3JyOWhpUzQ5a0lQZ0p1SEJTRENWcFI4?=
 =?utf-8?B?NGJGZ2lNMk1Ielo4SUUzREZFK1A4L1p6MEhOeDBIUlBHMU5lOEMxQyt2cFhw?=
 =?utf-8?B?K3VMcXpVL1llcVU4enl6eHdOem9keVB5WjYzZUdiVTZBYW9sY2w1Ty9SODQr?=
 =?utf-8?B?ZDBTUDJ3QTh1WENhNStlQXpnaWxNM1dacllxYkk0ekJ1NHJSK0lNT3JOMUtq?=
 =?utf-8?B?UVY2YXdRREQ2V1dIN0NJU0RjQkFNUXJ4NHZDYXREVnRtTU1hK1lNbmZtc3kx?=
 =?utf-8?B?UkhUOWtBOUVFTXYvakNuRERCWFU5ZkJpRDJPU1RtUzRpZThVU2w1clhTaDRv?=
 =?utf-8?B?dm44OVpQNStJU0FYcDJvbDNYRkltUmRtNWZtTkZaZHhHSGhVbG1wNWhhNFR0?=
 =?utf-8?B?SzlmZFRUbE5QV3VIbndYRkdmd1Q4WmkvbUVnTUZ3U2dSUU1aWDRxcEM1R09N?=
 =?utf-8?B?a0JjNXh5Vk9KdnNMaHRIWDI0V0lUMmdVR2liL1NPckRZUU5mV1FUaFZTUjF2?=
 =?utf-8?B?OGFQOU5UWFNpL0I4Y3R5OTZiczhZYktPNXlyS0RCNk15N05GTHdZM2EvTm1a?=
 =?utf-8?B?VU9jdXMvK1ZlbThzS3dDSGo2V1FMenA5QjJKdDVQdjV5MjMvWnRkSW1TemdO?=
 =?utf-8?B?WVdCS1M3c1dJanBZNG0ya1VEUFMyL0M3a2hkUUVZakkrUVhQWnltTmJPQVdN?=
 =?utf-8?B?d3cyY2VMeVQxMittUXhOQXo4eDBOLzV1ZndnbzlabUhVQ2J4d09uYzlNRmd1?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 685f0d9b-22ba-4c2b-fc9c-08ddcfa43403
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:03:51.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKLLKEiE1M6P+MPnJBnWxXESz1VBQc9FWOlcJFOmxxferst9edsZTUZFVaQBbbUkvQNjrxPd8j8aRteqMxiGEpH5DKNjbrexNO10CXdJQx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8582
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> The "mbm_event" counter assignment mode allows the user to assign a
> hardware counter to an RMID, event pair and monitor the bandwidth as long
> as it is assigned. The user can specify the memory transaction(s) for the
> counter to track.
> 
> Add the definitions for supported memory transactions (e.g., read, write,
> etc.) the counter can be configured with.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  fs/resctrl/internal.h         | 11 +++++++++++
>  fs/resctrl/monitor.c          | 11 +++++++++++
>  include/linux/resctrl_types.h |  3 +++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
> index eeee83a5067a..693268bcbad2 100644
> --- a/fs/resctrl/internal.h
> +++ b/fs/resctrl/internal.h

Looks like only monitoring code in monitor.c needs to know about
struct mbm_transaction so this can stay within monitor.c ?

> @@ -216,6 +216,17 @@ struct rdtgroup {
>  	struct pseudo_lock_region	*plr;
>  };
>  
> +/**
> + * struct mbm_transaction - Memory transaction an MBM event can be configured with.
> + * @name:	Name of memory transaction (read, write ...).
> + * @val:	The bit (eg. READS_TO_LOCAL_MEM or READS_TO_REMOTE_MEM) used to
> + *		represent the memory transaction within an event's configuration.
> + */
> +struct mbm_transaction {
> +	char	name[32];
> +	u32	val;
> +};
> +
>  /* rdtgroup.flags */
>  #define	RDT_DELETED		1
>  

Reinette


