Return-Path: <linux-kernel+bounces-797606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD7CB41268
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877C7208155
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F209219E7F8;
	Wed,  3 Sep 2025 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STq5a190"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9B221727;
	Wed,  3 Sep 2025 02:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756866856; cv=fail; b=H5ZNQrzHZtLvlmZCOacdSe2KW8Jl9lrFAD6Ddw3P20MQmnfEP4diI03D2wx6oSlaGz0Kx9BbddLqfBLP8i36x/nyKc4SdHNGA5WgmvXoEaDuMLaHxhbPFnF2P7aKrRBsUspOflcATHd0nuO1Y5aM5Zk0fbNkXih558XGieNJMOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756866856; c=relaxed/simple;
	bh=vwVMHlUG9iJ3m2zeEjLelU27p9Fpbp6gi2MckeZ3VJo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJhwXn79zv0FpFOHtyStnBOEqT0aVLeOngjJomKbjv2xDXS9ZjXSL+IZcG1b7N7U/c+2l7Z9Tg0QvGnD4F3T6OOgQotxD1/FrrkQgr22DRq4YES4oulKkJnteME7UDvfXN0Kw9lQLsVcIEafhumsr8AGprxMFnDKFj/jHC52GNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STq5a190; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756866854; x=1788402854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vwVMHlUG9iJ3m2zeEjLelU27p9Fpbp6gi2MckeZ3VJo=;
  b=STq5a190hd6RXvb/taXMGyG+O6cGuXuGsQlcGJ0/JG/Bl6rA6/7uGi5c
   paN1iBuOHT2DFZs5OHh5u6/OeFdm6aWRGCnAAnhRuhWoMGkChbn6L7gFS
   QX1QcQW5lHidu4pxjSXZaCP4kcaHNbv9C7pJUBAY0TPlsnPPceBkmSVGt
   7TFd1/CwC6SlLsu+EPkCM5UqHGud+LXRJbxgb1BYgkakPFxQmX/Pt2t5G
   fh50AuI0IksvbNBxwvy1qS5oj2M6lGpttk7p1TjkdUDSd0GxTjVLLx1PX
   xhksK1FBfOhQ4iZis3rZaAShO6tkypjy7LoNut0hinq1+7cK3v+K0sYJe
   g==;
X-CSE-ConnectionGUID: k31y58IOQ+i5aYtPOz7ReQ==
X-CSE-MsgGUID: pNIjgXxuR267DjshIgAZsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63001856"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63001856"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:34:14 -0700
X-CSE-ConnectionGUID: ZqFoz9cdQbeFa/regSu7mw==
X-CSE-MsgGUID: cD/j8dvyT1y2BKuEe6x8AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171009783"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 19:34:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:34:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 19:34:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 19:34:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeAOfXgd4QxetMc65PF6JlM4QwgwLJIbeUQepvgKchEeec5Bekigyie1VDgJv8Mq3MtoAOfqQgiPviqHWsRRsbr9udic3HqGAs7q2cQqxReJGKkC1mRxl8Mmqq1FdjHT6YT7zLnXqY9MY3Up6m02Kos3MRtLwxkP2ww926WGylbjc9cun/9td6gVBbCQlldRK8p0ODkW5EXkTyILDpx/zMMBlZQ/ajSzTlCUrrEsKEf83a3rDs2eunu5wI2LTSrAqpwgK5F6V4QyLRsYno5tHNlknBBiu06y2bs2OQymfla4iER0wtwiCSPtM84jweqUZEiYdjEdWZMLfLzGOYYUvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n86XsIB6aC6Y9IXMMo5R2KtMHuPDGKzdT+rdNtanmKo=;
 b=RRnl0XuCaxgKZdApRIthOB7ovh7lOrVEybb9c/MGuBwMSGMKa7+y09lS61XgCwGsYVN1JQ8Eg5gDS+v0ksp7/4M75WVjbpcVSmiL7b/mOBCwvzaqd4RlYcm3wsBzn8qKPx2+UlgfLWIjrl0Qrwb8MwTxhSRknHO6/8egYVV7pcnE4KQ/G+r1c5W7xgLTEyaM5Ez7KnnO8O/SZ7k7mBz2mOuWeOCMoXPGREC+wo7W9a6BsIIqvS+nXuCTsVlx9QM3BmmQ3kiTBtKawhfD0oFy4jl5Iuzx/yZFKLnZZA+kZeoZBz1O2GLp/LVPqoKDpN/nCm1EZi01z5J9Y5xgYIQDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 02:34:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 02:34:10 +0000
Message-ID: <811782dd-3240-4af1-a42b-8a6cf49739e5@intel.com>
Date: Tue, 2 Sep 2025 19:34:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 22/33] x86/resctrl: Implement
 resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()
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
 <327c88dfdac06a536c73ae0664d5bc2b9a86043a.1755224735.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <327c88dfdac06a536c73ae0664d5bc2b9a86043a.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1733b2-8ac6-49dd-013a-08ddea925cd7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTAra1U5RURqdk8zNFRNeXlOZHA4M1g0NDBoM3JVNzh2UVZuNm44Lzc2NXUy?=
 =?utf-8?B?MTU0cWo3Vmg0TUpHa2w2dEF2bE40MkRPOHErM0RqcDRFVlR5OWk1bW1keWpF?=
 =?utf-8?B?cXlmdlVEQ0llTFV4QjZzSytKeGlHRXkwaDgvRFJ5aWdrMmJtMmdCdG5QMEFR?=
 =?utf-8?B?QXpENE5MNFhSblpFSWU4OFBpeStJUVk5TjlZT3VwdkIvdzVPWEE4NTZvOTcz?=
 =?utf-8?B?UDY5Tmxid1I2NHREN2dDSlh5bU9zQldCUHBsNEpaVjN1VHNlbk5hNHFkVWR0?=
 =?utf-8?B?UXhuWUZMY3k3WjdXWWFJTVd6NlFkYUVrWHgxMFN5WXlWSEd5UTlpRlFoZHlk?=
 =?utf-8?B?MUREdStGejA4NHFnR20zek84d1JJNnJiOHFuQjRHczRtZkRUVHcwT2tyS2N3?=
 =?utf-8?B?dlhMY2ducElLdXJPaFVGSDBlWXlzeUdsQ2FjUjVyMjltQVFJNzVudEhhRGs4?=
 =?utf-8?B?d2FuZjNwRDJwMDUzaVIwWWp2MkUydGRaM0VydVdEb2MwckFLK1JjQUFkemZQ?=
 =?utf-8?B?Q2pBNis1V1FmTnovYkZIb3JrVTFna0Z6T1lHRzRSY0xtUjdZdVk4UUhlVWti?=
 =?utf-8?B?S1dsNmVJbng3RG5PMDRJRjRRNE4xS2g2L0pWUXpSZFVVeUluZ2tnZHFiQWtG?=
 =?utf-8?B?dmk1UjhXSUIrVW5JNVFOTWRjajlmTURMcnB5S1krRGNuNDc2MnFjTy8ycDl6?=
 =?utf-8?B?SzlvZDNuZkhBMUhyQWhTQjZCVVFpR1pNQlNBMEs2Vzg0MW9RSHp5U0xyaXZX?=
 =?utf-8?B?cVhxWWw2L09JL1Uycm5ITFQ2WGxOcEhlOUVzM3NaVG1BNnV4am4vR0hBbWg5?=
 =?utf-8?B?dm1iU0wvWHBMTjNXY0tMSWVUTlBOdWRVamlwSFhBbDFDalZnOGV0cHF2bENR?=
 =?utf-8?B?YXBHRURmVVpVSHV5Y2dwRzd3SEdDUlZTWXRJdnZyYmlqU3dsZzRpMitFemtX?=
 =?utf-8?B?eTVtaStueVVtdFhGY3czUm4zUHhEUTBsdUxVQ21vL0QrMElrTkxUQk1Vd01W?=
 =?utf-8?B?MEI0cmEvdXE5VTRLWGFjelA4RVhIcjFZTFdDK210blJGRjEwL3lZbXI5UDNy?=
 =?utf-8?B?VmZ5OStFdmJGWXlUWEJuOFl3dWVheEg1UjZ2RnlSNnhKMkJLMy9BclllN2Jx?=
 =?utf-8?B?bEJSREFXR0RjRjZPN0NYUndONUNpdllRLzUrL0FCMitjSTRaY1J1WlhBWXBa?=
 =?utf-8?B?aW8vQmZDL1pxTmUvN1pxVXdvYm1HUkJpR1VtZUNUMjZ4YnFDS2gzWWhnOEtE?=
 =?utf-8?B?K3FsbUVpSVJVcHhISDFUejc2bDlnYk9uWVkzVkhWVDhEdFNYOUlPckkyNVRG?=
 =?utf-8?B?cW1vWGJsYmh5QmtvaDlpY2FNMTdQVHZpRGZRbG40UWRSNUszNVZWSkZkVDRH?=
 =?utf-8?B?aGF5aDFzODlDK0pyNXdqR3c0MGc2L2VwSmFiamhFd2ZYTlNTOEJYRHBybVdw?=
 =?utf-8?B?R2M1WWFBV0VuazRwM1dpenhvSXhmS3gzOXJHa1kzSWxFNW45M2t6ODNtNzhq?=
 =?utf-8?B?VjlYZXo1NFM1bWR6cXF2dndaRy9leTl5M3paaldScTB5dWZWUWwxUUdjR3B0?=
 =?utf-8?B?Z2prMmlySEpyZHcreE5PZHBpd21OMG1qK3BvbTFiMnZhQ3Z6QnhaNTNJT3l3?=
 =?utf-8?B?RzlHV3ErNy9sNCtkSnlhS3MzMTZQd0hLRjVWR0VnN0lFcTFFMkRUanpSNWlU?=
 =?utf-8?B?bWM2bWtPY0FEMytOSFR0WHliNTgvRGhyWU9vMzdZRHhsVzFDeUZ3T2VjR2xs?=
 =?utf-8?B?dVh1a2FxMGw3ZHFJL3FGdDhmRWFpazBGMEo5UGV2dEVIc0NOM0UyUWl1Qnc4?=
 =?utf-8?B?bkVsTnRRZ21YZnVOQ1FCeW8zNmg1cWNZSm0xUnJabjlmZjh2Q1UrN1N1TEpN?=
 =?utf-8?B?U2RYMUhHN0ROeTkzZzlQTFJqTUJ6YlZwRkdnZ3NJWkRHOVY4TkpGOTZOL28y?=
 =?utf-8?Q?yCIVw4RV5R0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01TdGlISS8xaUpORVJEN1Z5RjBueFdZUUdNRERCQXZjNkR6MFY3NVhPSSty?=
 =?utf-8?B?dXlSYzJDaXpKSW5pNUloSElod1pGRnMyam1CTjZCTUJPYjhMUGJPWDNPQUFD?=
 =?utf-8?B?MXpwdDFRMHVuakdrVUpaZDNjQ3Q4Y29kd0tkSnVRaVNlS3BtcEZRVFgrclg3?=
 =?utf-8?B?VC9rKzZ2VXkvUkhRVzdSRlViU2Y3WjdFaHFDcmRVVVZTVi9UUWthR2Q1M0tU?=
 =?utf-8?B?a3dQTlpsVzdRL2JqdVZSN01ZY2lGWGlvemh5QXE0SW5nRUJvSmVqendsQ3Vu?=
 =?utf-8?B?c0g1bWdmU2NMc3VCOFV3M3pKbk0wR0k1NGJsa1hZQVNIZVJoNlh0ZC9aRVhn?=
 =?utf-8?B?alVSM2V1c0lhUmJjd291VGordXJsVXlNQW52dDJIL3lqOEJsU1FtcWtFNFZz?=
 =?utf-8?B?UEhVY3BBTitLa1JZbE9RcFhoTkJJMzlzTnVtYWlmeW1GaUFVNk43YzR5Uk0v?=
 =?utf-8?B?N1NMRS9MYWhrYk9hRWxXdzhKdkQ4OXArZUh0THZ2UklCTU5YVlZoNnRDNEY3?=
 =?utf-8?B?MUU0VTV0VS9TVm1DTXRqU25aNXl5R3BDWTRyUjRXVzRyWkpRN1FPUVRidzdQ?=
 =?utf-8?B?SjkwUkRUZ2hmNkNMbkVGSmJOK3cxcGFWYUxNaDV5YU9QWGovcmpxcGJBaVQ3?=
 =?utf-8?B?emtQMEo0RXRyV2F0dko4MUV5Um9GSWs0SUlsOWw5Vm9nY09JTG5nM0x4YzZx?=
 =?utf-8?B?VytLV2l4UWwwM0Y1SUM2R2c5QzIwMmgzeVJPKzVxdzRwSUZpcHVKOG9mM1Bi?=
 =?utf-8?B?WlVTNmVxeXBmL3haQmRPbDR2K1hteU9oTzFHMVZUV1M2SEdNNlk0Uzl6dmxZ?=
 =?utf-8?B?REdFZ3liWmlla09IRmJoczU1WWE4anJaeTI3dDkwaVpZTHBYd0txY2JRVFcr?=
 =?utf-8?B?NTJBUllhUUFUY3RobEdqMjFrWWJRY0t3ZGMyYXRCOGQ5VEozU1U2VWxRTXpo?=
 =?utf-8?B?cjFidXlyK2ZIU0Q4ODBmLzdXZmpLL2F5WTVzY0k1Z2NucVhmdDBXc0ZBUDkv?=
 =?utf-8?B?ZnowWUhPMXRTelBvTzVseUFzK0ZmcWhUd2VRMElLOUQzWXhxNFlYb2dDejRW?=
 =?utf-8?B?ZUZoMEZHcjVRTlArNGhRbzVKN0diTWJpbWNzMUdDYVFwWUxNZVo3d09rWTNF?=
 =?utf-8?B?ZkVEa29UODY1MVJ1TVNodUk3ckFrOVRvbFhiOHlpNmFIUFF2M1RsZXZJbS9X?=
 =?utf-8?B?ZWJTSk5oNTVzMGFudzJxTUNVK0NaQkJqbU1KNlM4OC9WWU5lMWpUNlRmTnp1?=
 =?utf-8?B?Zi9XRDMvRVkyaU1CNGJCeVBPQlZhMFZVSFNkbmlpNTZzMWF4dTlNYmx3VUFR?=
 =?utf-8?B?VVpySlRMSzAzYU4raG4yZUJYQzA2YzhickQ5d3piYmMzQ0tMWGJVeWV4RVNL?=
 =?utf-8?B?K2xRQWs4TlZsditzcmhhekljMnc0YTJmSDNyVnp2Sit0UHRBSmRncGxsOGhh?=
 =?utf-8?B?a0pXclRYZnluaXBKdjZzVGk3UFpMWHZJNTlnVnJhdXdRS3NYelhzOXFKWjY3?=
 =?utf-8?B?NUkyNm9ZM0szQUNNTVdTUkRINFZOdktaL2xWZC93QlFjSi82MC80Zms4RkpQ?=
 =?utf-8?B?eTZ6M3VwV09GTzNubFYvV1RFYlJGNjdwL2YxeFM0aGd5dHhJb1B1T2JBUnNz?=
 =?utf-8?B?NnFDOUk3TGprTC9aa1NIYnZrZ2V5QnREdkM1OWNuNEhXZ05BRDVTVXdsVFZD?=
 =?utf-8?B?am1tSk4xU0Fka290T2VUTlY2N2dxay9MZHIrY1EwQVBFcFdUVENCdWg5RnpP?=
 =?utf-8?B?WEVpak4wNGlkL0x3VUk4c0hRbksxeGY2cStqYkp5Q1o3LzduSVFEOVJ6cGwx?=
 =?utf-8?B?QldjbEJkMWQ2ODlTTS8wenl3bkxUeFJaNHdKNk85RkV0STB0QjB5dlVqWTZO?=
 =?utf-8?B?YVRja0JrUElLd3pRdWtybUU4RFhNa0VxbGorR3lBbXEyNnB6cDVWSDRubE10?=
 =?utf-8?B?K1hSdElMUUtjbzgrc0wwbmROM3Via1FhMjhHTnkzc0RlRVhvU1IwWEZRR1FP?=
 =?utf-8?B?d2JTT21pWTE3WkNWMEpxa0VUT2hpNldBR2U3SGU0aFl2ajRSTWVMNTc1cm5n?=
 =?utf-8?B?K0MxcUtWbnpzTURxY1dQNUpOUWZiOFU0WmYzK0ZGQ1N0SmVWYWlMdjNncm1C?=
 =?utf-8?B?bWxBQy82aGZwb3ljK1BjNUFYSlZGUmUyQ0ZxRGozUHI0VlJ2TnR1TlpJb0Jr?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1733b2-8ac6-49dd-013a-08ddea925cd7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 02:34:10.1721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F9TBGxoiOmDeTwfnUJ+knoJO6aQx4fEH7kSkppVLJHX8lpAn4KOQzS3dNGy5V5F/b96MQmKibif6cWwg5qnp1sBKrqyU6jqSLB9Ybi8tws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> System software reads resctrl event data for a particular resource by
> writing the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and
> then reading the event data from the QM_CTR register.
> 
> In ABMC mode, the event data of a specific counter ID is read by setting
> the following fields: QM_EVTSEL.ExtendedEvtID = 1, QM_EVTSEL.EvtID =
> L3CacheABMC (=1) and setting QM_EVTSEL.RMID to the desired counter ID.
> Reading the QM_CTR then returns the contents of the specified counter ID.
> RMID_VAL_ERROR bit is set if the counter configuration is invalid, or
> if an invalid counter ID is set in the QM_EVTSEL.RMID field.
> RMID_VAL_UNAVAIL bit is set if the counter data is unavailable.
> 
> Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset
> and read event data for a specific counter.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

