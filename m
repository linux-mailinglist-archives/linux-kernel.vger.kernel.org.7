Return-Path: <linux-kernel+bounces-797625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8ECB412AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDFC616742A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5302C1598;
	Wed,  3 Sep 2025 03:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaFB5P6P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3722853E7;
	Wed,  3 Sep 2025 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868513; cv=fail; b=hk24t4k0PBYISnrxV2rHI1SijHZD3yMoT98gK+S1h9/95lHRxKUp2eAAZ2YrwpqKrT0bI0WVAf8ZXgNrZQJiqywhz1O5sq/UgKT3XyCX2/Ji9pGkHOwWLowvu5TFn46m8yEuxZsLuReY4tdWpL5B0QiHHxJCTsCQSNLWr9U4IZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868513; c=relaxed/simple;
	bh=OZK+5xW31Qua/AkWCcrRd7iCiBHyeAALjpFNdot66u4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WwQdNvHm3m2WUnnhtgFkwJSWsvrgU7NqP5p6a+9mKxo2fAJp+9kw5unUDX59F9PEgZZLdzWscKBIm6k+5ep6FVAn9FIGv1YI5LDcHI8Dt+4TOm/qXmpt1hjR6IwPKMJES3clDBfCpz8TOF9SO/phnJWXtQOtljnEz1/HTlU7elk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaFB5P6P; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756868511; x=1788404511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OZK+5xW31Qua/AkWCcrRd7iCiBHyeAALjpFNdot66u4=;
  b=YaFB5P6P3GYKBjU8R1po/+kl1u23JLaO6GtfwPywT0XwwnHv2YtHzQfd
   zGh0j5wgJWWj/gfcCFB/yNuDzmP1Oyw+lJm/08ote1ACQXbxPQ3vnd4ti
   OSRcM3EoqNbMZ/S58oqYNPIFm4d90Cf9nLo6sWvYCnhr5b/j2lADc7mr6
   joBMhejZIXFP+dObbQJ+k6yRj+wWosENfcTHpL1TYtLBplEMcTYe4slxQ
   EPRPOWELHDa08w/7xR9+c90BBa1wz8zs5s5uPWdmWadkndb6MobjOHSnD
   fEKZo82FLRsTDfXXPEjR6aGZXikiJCjocotkbYuV/XgFV9be8CX0T0DSt
   w==;
X-CSE-ConnectionGUID: M+W61viRQBSbKMlsFN9COQ==
X-CSE-MsgGUID: 79G87gtQSNazCDeVDPgA9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58867709"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="58867709"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:01:50 -0700
X-CSE-ConnectionGUID: i2byaHwkR5aQmX4u1ZzCRg==
X-CSE-MsgGUID: F2TZHGxUQgO8e08iohfJFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="202412417"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:01:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:01:49 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 20:01:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:01:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycqlXxDhbjmTBtA+miaNuIUpYApEbDncQmdibcOaS6DzkuZwPgNJ+2eZcZSTNlQ95P8BQmajpfi8XSC1BrhYerjV59q/ckHJiSidROVnb+6uORd4r6X91iGo1jIomToMdfyLJM5dvWM0Z0mr9SUYWJrMJR2IeRXnCa4CbXbkGMvzb9Cfz1baakN4aB1gqo0bgcdIx1tVDY+slg6fCKAHxRvDhCn/cfIHWtzNlulsSfBa7FHxUvKPk+z5sKbeOwYDhSjI/P7vORreenB1a5umNZV1FUCkl42NEBMot4QXYvuCdTwg1CWv3IJzdK3pr2YSvN+adVllrPV8HCdUWWy2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK19aTrTo17ExPQUWGQChmlCvOj7w/8AhEODCudlbDE=;
 b=mFR0gSOqwiUN5Kfgv7HHKpHQdOgGeZd+2qdSOImhR8YlJF0e7BjehzmnIE4jL/HrIxomDeA6OASXdopBYnvpwT7quS58HwI2fW6IEHZDVV/AO85YWB5CBqTriBQGzxvWtaFHFefkG0YfCPx0qSwt+sorx06TTZkeKmcY6CMgSsDWv+aPEbOB5kj9nW7TdK/0T/s01GLFufNmrdiSYJE7eMSMLMsOvZI908IymaMFUtMVQ8/WaBtXHr1pNgpyhUkcSDVMwO2uyy6OA1c5lXJayZsEph/gynlnjDM3UaAtHw7fIC5q5OHRdIp77a0Sy7NXIiYT/mbqV/I47q8Ktzx5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 03:01:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:01:41 +0000
Message-ID: <78e5640d-b290-4a9b-a410-c44290f14e0b@intel.com>
Date: Tue, 2 Sep 2025 20:01:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 30/33] fs/resctrl: Disable BMEC event configuration
 when mbm_event mode is enabled
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <Dave.Martin@arm.com>, <james.morse@arm.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <akpm@linux-foundation.org>, <rostedt@goodmis.org>,
	<paulmck@kernel.org>, <pawan.kumar.gupta@linux.intel.com>, <kees@kernel.org>,
	<arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<thomas.lendacky@amd.com>, <yosry.ahmed@linux.dev>, <xin@zytor.com>,
	<sohil.mehta@intel.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<peterz@infradead.org>, <mario.limonciello@amd.com>, <xin3.li@intel.com>,
	<perry.yuan@amd.com>, <chang.seok.bae@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>, <eranian@google.com>, <gautham.shenoy@amd.com>
References: <cover.1755224735.git.babu.moger@amd.com>
 <ad05cc52241731d5ae0546e4a632b264ccfb839c.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ad05cc52241731d5ae0546e4a632b264ccfb839c.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe209c1-dbd2-4218-05f5-08ddea9634f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VG9sSjVqcFRiTmZzUGVzNlpmbzZObmFoLzE5dHF0M2JmamVrRU5ma1FLckEv?=
 =?utf-8?B?L1cwbEJIUnJsd1QwMzFxd01HQ3NuUm41SU5JblhBOXVtclJQYTJodDFoK2NS?=
 =?utf-8?B?MWZ3cTVIUzFYbHcrVUxWYnh0OWM3NDdIRFBSUkpQOHMyUC9PNjZYcVU1ZFND?=
 =?utf-8?B?SmdNdUowdndYUlVDN3ArYmFFT0hXSDhZNzMvL3RKQmMzSDlDOWM3VnhzZnRL?=
 =?utf-8?B?SlVEclJzcTFKSnNScENEdWdhU1gzdlp3RzF1SUFYSmdiYXd4U1Y4M3JGU0JK?=
 =?utf-8?B?R0VGMlc4MW8vTmZzKytTcmE5bUpQWTlGeEtyMVVKa0pPZmdYaHhGc28rZFpE?=
 =?utf-8?B?UmtVc1A1ZFkva1dJbmV2Ync3VXJ0L3ZvajlTVXVPazFGMHhWU3lPeTRDQlN5?=
 =?utf-8?B?Wk5mWWlxekkzdGFmSjJsN2NTUWE2d3cxRk9sYlJJdUw4ZjNsQ0xuWVAzUEEw?=
 =?utf-8?B?UTBHMnQ1ajRibEIvTWJEV25iZWJxczBGSFVCQjZGZklteGpjclZBa1NuSGF0?=
 =?utf-8?B?amkydU5rNkFOWkhkZXdSUkRXcXJaRHMvUWE0UVI5bXB0eHc2bUxWeWVtamxy?=
 =?utf-8?B?eHczTzJpWlBQUU53ckpDNGFHREdqN1JPZW9YKzNPMEx3RzJ6cEVwbmtPV25z?=
 =?utf-8?B?U1ZxaGF0c1JQUmFtd25lSThWb1BzdmF3SmZNZXhOSnFBRllUWlVWbkVxSDZQ?=
 =?utf-8?B?NTZ4YmVwdG9aSjhOUVl5K0FXRjV4TGZiMzFLNE5ZYm5BWFpMZUp1azB4Zmd4?=
 =?utf-8?B?VEdDQWoyc1FXMFg4WGJSTktqa2h3N29xazNwL01INDNBMmpXM2Jack9oK0E1?=
 =?utf-8?B?ZlozZHFUVSs5L2NLZ2xXdTRLcTZjZlpKSkkwT2pibjhGWnEwYkFEK3JjSGxU?=
 =?utf-8?B?eDZob2xJdG1iOVZHbklMeVRiVEd6b2Y2clFsejcrOEZ6R1VEYnUyTkpkOHU0?=
 =?utf-8?B?eU15VVgwTG95dTN2cFhrdVRiWUErNGpHblNJeThua2VtWVJ0WUsxMjcvanUv?=
 =?utf-8?B?c2RmSnFwMEtzaUVWWWk4OVRXb3VKNm52MHJLQk1FbmRtR3pzeVhBUHlib0VU?=
 =?utf-8?B?ZW9rdExnUzQzUGo3b0ExWkw3NzVmNW1tVDFWVlRxY25YVWdTdC91d2JGdCtX?=
 =?utf-8?B?eE1nTTBhUk0vbnRSN0kxRWgzZjVvWFNnQTBTRjJmUjhVdy8zZVo5VG9wdUZ1?=
 =?utf-8?B?dnJVWWMwc0lnbDUzMWh4QklPdlJhYXdpeGp0RnJZVHZVb0VhZUYzOXBPSWVO?=
 =?utf-8?B?c205UUVBTFZBdzJ2RzlTSitFWWhybXVsNHVuVVpSUXdpcFE0TE5Kei9WYmpP?=
 =?utf-8?B?VDlhTUJQOUlpVUI3WFF1aElVRVpPa0NTa3ZQYTJPLzhXQjZDY0tpTVcveEU5?=
 =?utf-8?B?UzBPd0lMV2JRZmhTMysraHFKMGRIV2hYamRndnRpNnRXbDRJL2dlZTh6Z3VE?=
 =?utf-8?B?WXpJM3BpM2FNMG1XS1dGcEtrcUJwYy9uVGZJV2xSbFVLeks0WTJ6Vi8yRDNh?=
 =?utf-8?B?VXNEZERHblh3SjV6T2xmVGJZazgvM1d2NUxTV21YWHg2Y215QmMzUDNSVFlW?=
 =?utf-8?B?a1VmUHRLY3NuV1c3ZXhhamQ5UXU1THVFRXhsdGdMeHlZMXN0VVFvVHg1NCtS?=
 =?utf-8?B?bGFBcmhGYjR1VFJjKzZrajhhYkhLL0ErcDcxUmVGcGtXL2kzaEF4bVVoS3lO?=
 =?utf-8?B?UTlLU0sydEthUUZUc2NBVnNUVDVxdUh2UW5OdUtqMWNWZGdVbTBNc0RZQnJk?=
 =?utf-8?B?MDJ0SHZNaXo3R0lPZ05IVllWZm8xTWwrcUJwbHRNOE11S2ZDWlZQTy9jaXZW?=
 =?utf-8?B?RkkzbEFQUWMxTmlJdlNZMHpBblEzL1ZSTXhmT2g0bjU1Nmg3K3d2dEsyOW5s?=
 =?utf-8?B?VGd4aS9SZXBOemwvK0J2NmZVck1NdmVIcEFNVk1RRVpLTDZkejZYczZ4RmN2?=
 =?utf-8?Q?8b/namC64uY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZsbENNSkdmQ0xWSzk3Nm5jaTc0bHNpczBObjN1bitaVmlHVjJBUHZYdGxJ?=
 =?utf-8?B?ZGs3a1R5dlArNy8ycmZtL0hYemZRYTBrQzEvaXRqVDFoYy9ENEVxYjRHTHI3?=
 =?utf-8?B?NnRYUGNlLzc4cE03Y2YvSyszWnIyWFF3ZEtNZ0xPZHUxdmxpZThyaWtTRnkz?=
 =?utf-8?B?R3pGdFp6Yk93ejVOQ0s1Q2NEZmUzV2lKaXdueWJnZWYzQkpaY2M1UkhnTDda?=
 =?utf-8?B?dVNDUWo3b2xKRmd0aTFKSGJvc01vVzNOclorQ0xzbVpMVGZpc2gvWjhOV0hU?=
 =?utf-8?B?dld0c3dWTnVCV1NsUnRyWk9hb0hKMXdBWWFhTjBVY3g5ZGFTT2RaKzNmUlVy?=
 =?utf-8?B?VFFiRlYrSEtNT1ZKMUMzZlQxSU9KbG5SWW5CNnN5eG5SbUFXY2tnVjRQbDlS?=
 =?utf-8?B?eW56b1hydnBNWTdIYWRGVlFYMVl4cldCOFE5eVdGditCbXhUZnB4QU84MDhm?=
 =?utf-8?B?VnFKMUFUYlVEblY1eHV2cWhLb285L0VKTWU4VEJNdDdzUWEraDBzQXFsc1pN?=
 =?utf-8?B?WFdKYnR0MjVyWGp3RkdHSjdkM0hPR1E1NEhkQ1JuanZSQ0RQN1ZyUW5CUnRL?=
 =?utf-8?B?R0dzTGdtMlh1L1EwazdLNWhEdVFISTJOa2NLemRDZmZFNlBHV3lpalVyelJ4?=
 =?utf-8?B?SlpueVJ4cjV4UFkxRWRVb1lUMm9pOHBGbE92T3R6MW0yKzlZeWJ6N0s0a0lq?=
 =?utf-8?B?alVVanJrZWh0MitqcU9CVVZvamNuQmp4eXNVbmc4SXMrR1psSkdEa1Zwbldi?=
 =?utf-8?B?bjdQcm1TNEVBZjhSd0NmYzM2VUN5L0JPRlJZWEVyazFSdHRrc2dTbTFTdVNQ?=
 =?utf-8?B?K09SWTRzYUsxSjhDTVpTT1UyOEVadGhGZUluOCt6Wk5PZlJabUtEZ3R3eVFW?=
 =?utf-8?B?bkFKTjJIc0VhV3pnNUc1cWZJTjU0VG9IOW80Szl2SkQ1cDhRcVV3TEdLdFZn?=
 =?utf-8?B?c3laQ3YwdGhEcVcxRFVJc3BNU2N1bGlQcVlKeHl1Ylk2dVlza1I5anI0cTc0?=
 =?utf-8?B?VnA0Njg0YWk2MlBKbk1EWmVsK1ZDNVMyN29WQVlraEhsYWt6eWcyM05zZVJG?=
 =?utf-8?B?T1lPbUJEU1R0aVk4d1dBNHg2dUZzYzByM0E5M3NucFB4SE9qc2tPZUFkTEFM?=
 =?utf-8?B?Mk40aVB6WlR0b2UzYTU2QlNqNDRORko2eER2UVZmc3huWSsydWJ6dEdWcTYr?=
 =?utf-8?B?S04rQkt0S29jcnYrSDhpMDN5c0NtdStCNFpDb3AvZGs4ZGZzdzg5ZmtRdDFk?=
 =?utf-8?B?VTZVcGdjSGpObEpzUS93RnZEYlE1SENnOERzL1N0dUp6T0lBQk1WeHB0Zzht?=
 =?utf-8?B?UjlaKzNwWjdsWG1WWUxqSWs0MURZOFpMZWtSYVM0SDNxZUFPTlBVM0gwSG5D?=
 =?utf-8?B?amVVNStsYVN1a05WUENqdXhFS3RTVmpFWDZuaTdCNU9ORVVIZHh1ZnZ0S2w3?=
 =?utf-8?B?Q0R1K0hkSDVqZW9yUG5RdWZrQ3ZKTnAwUG9ydTRLbUQwOHRBM1pPeVdyU2lj?=
 =?utf-8?B?aS8wWlJLVU1UbythbDlBRmNCNlBFc241T2JseUYwc2xvemExbmEyZGRXL3RF?=
 =?utf-8?B?N29KcjM3ZEo3SUtuUnhRMGt6dU9BaUwrZ2hFYmZES2lsWXNnb3UzaEFlTEJj?=
 =?utf-8?B?U01FZGRtYkNPMXhXNWx3N0pIdGhqTzVIbVV3bnhoVUxrSUdFemRpSm5wNWhL?=
 =?utf-8?B?eWtiZStheEpFZHVuOFp4NTF2cU1nMGhYK1FsYW1qTWR6WDZzLzI5ZEZ5YjRO?=
 =?utf-8?B?ek9MMGhXWHA5eXJPaVl6MHZFZ3h5RWQyNWYzYjBGYWF6TlN3RlUvVXdkQ0V4?=
 =?utf-8?B?VHMyNEcyZVBJWG9KZGd6QzJSWUhnZndNWm91RlU3ZElDeTd4Ry9SWEp0RytP?=
 =?utf-8?B?Nk92ZVBsRjVKcnZkYWZiYlB1cHFPS3lwWDYyeUJpczIweENSUS9pRUZxSVZJ?=
 =?utf-8?B?VEFJVWlBekhrTWFwc0t5VU9vWjV0aThEWkRBb0pjVHFTbmk5NUVVc3g2YlJr?=
 =?utf-8?B?Y0hWZE5LOUNUN3BlUmR0bmIvenhJT0lZQUkxUDdmZFBoZ0YvcWVqWXVuanVm?=
 =?utf-8?B?RS9RZ3lNY0hkU0g2ZUhsTVZyR1NQNmorR1ZBVjYzc1pKaC9OVkorTGhsendT?=
 =?utf-8?B?TERSZE5vUFc0allUdytnMk5NR2dpL0hjUkR6dE5qSUt3YTFTaVU3ZStESG1s?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe209c1-dbd2-4218-05f5-08ddea9634f4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:01:41.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/PdX42tzrSCsADwpIdQZFa6IK1snvmnLKK0fulxm0oEUEnmaeKixLVc7O5wlP6/niZjY3WcX5kFS28q/oAKuG5I8/T5lRY2KVgIQ3pidfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7410
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> The BMEC (Bandwidth Monitoring Event Configuration) feature enables
> per-domain event configuration. With BMEC the MBM events are configured
> using the mbm_total_bytes_config or mbm_local_bytes_config files in
> /sys/fs/resctrl/info/L3_MON/ and the per-domain event configuration affects
> all monitor resource groups.
> 
> The mbm_event counter assignment mode enables counters to be assigned to
> RMID (i.e a monitor resource group), event pairs, with potentially unique
> event configurations associated with every counter.
> 
> There may be systems that support both BMEC and mbm_event counter
> assignment mode, but resctrl supporting both concurrently will present a
> conflicting interface to the user with both per-domain and per RMID, event
> configurations active at the same time.
> 
> The mbm_event counter assignment provides most flexibility to user space
> and aligns with Arm's counter support. On systems that support both,
> disable BMEC event configuration when mbm_event mode is enabled by hiding
> the mbm_total_bytes_config or mbm_local_bytes_config files when mbm_event
> mode is enabled. Ensure mon_features always displays accurate information
> about monitor features.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

