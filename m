Return-Path: <linux-kernel+bounces-751304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 308E4B16775
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379771896E85
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86321B9F5;
	Wed, 30 Jul 2025 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9jYy9h9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89704213E89;
	Wed, 30 Jul 2025 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753906307; cv=fail; b=CVh5jNrsh7ndm6a1Xwsee5fTZuT4bN5Xt97GhdufLWCwvW7RUNhqBC2/W1of/57JrguwWHsX5JdHs9+LBz9wrZj921VEZ17srJPSqe9fwt8kf1YPUPv8S6gmu79JRBSZktOG30nO9nXHg6DNxTypB+rGzBL3YMO495AGkRurytA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753906307; c=relaxed/simple;
	bh=LbVs6D0/lqWVp7yfbqxr9S6ABGfnoKLHPogLGWV6frc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SbW9UXTXz5sIDJ7rE9RNiC77wAXWMR8v2g3n/WPHuRpdeUgk5D+yz4BD9vhCbYRHyJSpuaaHsNTpc94FSr/SR5Dx8hL1S+2uTNHN4ISmGIZsG4X3LC8KbT7jVXl13ZX2F1XRBKjG7BsMHcrQgJQ0QtKKSG61RmY83UaPTFRiqzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9jYy9h9; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753906307; x=1785442307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LbVs6D0/lqWVp7yfbqxr9S6ABGfnoKLHPogLGWV6frc=;
  b=O9jYy9h9PIqAwImL0iYXBtemHgVr7zidPOItyTVQHc1BCXaVinGWrFEc
   eYqFjC5zIi9pfiiDP/H403t7lbEjg4RHgWIjAFxvBxbrPiZDQzDtnUSwp
   42vL/jmvBcBptTsuuJQFhoK0Hyd5t5SKng6/zPC1MhF3a/1QOVL5rI/nR
   vCVX2DXLUmg1XMwhVZlSFH/v+2sMQe7547kAR6JAr3Z/8/jT0QVBqcjHa
   jZNhT8ploZonBNhb+XLfOpiIj/V6K2MHrSo3DeNyTj/6jSpDW2aSfBtUJ
   ywAPI8ONOPriJBvRJwyV+LuAIU0miwZtQgDqxbDQjPtxKgfO4V1wWAKuI
   w==;
X-CSE-ConnectionGUID: rgbwDK3tScOk2ttXm2RpGQ==
X-CSE-MsgGUID: CRBkVjOeS6mKvIxLDKiIQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67300517"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="67300517"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:44 -0700
X-CSE-ConnectionGUID: 6JoDz4EzTbmFmPcdjE/Pnw==
X-CSE-MsgGUID: 2LafCqAhRIKKKUxbX445uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="163864593"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2025 13:11:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 13:11:42 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 13:11:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 30 Jul 2025 13:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE47NGQD6ju3vcqXsKpiKVR1Lb013q6cHw79kJQ9WndrepfCdDbx8LbuNjwPh+q1aAn/QajVlzDuoDwqHkIlpJFTgSdghO5apHvYvf9wVCgDl3Uoi5AfF4IcL8rddmYWfy+3PMkQsX00JtlAyE6zXdL70KPjkkOBLN2xHzKOsDiXb66l/O8ykYlzNE5NLYLDoT2RGSquV7w2oJUTlCZQdI9a3NooPX8w0vUbzgGnex6Ti3XGs8frnBWe1re9+JBFk5Zif5wO81olyUaHkrOxhGkwbwuB2PXu/rVh+dQvxNbm1O6IhFqngLee1nEpjT5aDhqWBpN44/Ccdixgn0p0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4q6vfqliKrFMFuhnh/kktUDP26me0j1y+FkmSq6ZSs=;
 b=Agw2oBeCv29d1scur0fPzgkJskiZVIwzM71G68+KrjBM+YvicFeOUftkLvTSYWhvFeO5vUw1s+ZpWjntb4jBZK5IKtclPxziMuEzlvzTnceBcjbgb43/k6S2nSItznGpVKMc0j0OnesQK1sYbTsWFqZLOTIIuKoIPxy2mhLk7TKqI/OxL1x1mYmlH2r08TEA4Ju1jrLi63KJPtLw6r8WNbFG/VRjFnuadEt5wgDYUbjTfx3qJf1/6IpQmp3g45L79g/NaEYbkSqGrPeMyGyjs2wPRivFIeQ9jwG0lDMA39RBCEdNGRBnJGZo68DuEZbIeYPg8tEACOAIjiBMwHCNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 20:11:39 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 20:11:39 +0000
Message-ID: <bb734538-4280-4748-9192-5bfa5ca8c8ab@intel.com>
Date: Wed, 30 Jul 2025 13:11:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 33/34] x86/resctrl: Configure mbm_event mode if
 supported
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
 <dff9af435f3103a2e3750a563c753f65658dfebc.1753467772.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <dff9af435f3103a2e3750a563c753f65658dfebc.1753467772.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CO1PR11MB4993:EE_
X-MS-Office365-Filtering-Correlation-Id: a086ee20-9361-4bed-4dad-08ddcfa54b40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFNja0QvMlcyMFdlQ2tHZWtOek9yNlYydS9YWUpLaHZ3aDd4Rm01L3JiZWpx?=
 =?utf-8?B?N01WT0IzZFp6Sks1amswU2syM0JZcUZXUERiZWJ5a2h4M1VGdExRbU5WdEcx?=
 =?utf-8?B?T00zbWhuaDlJeEVGbStJd1RjZmlYeFFJeHY5OXA5YTVNSzUwWTg5S1NIdlh2?=
 =?utf-8?B?Z1ErZ3dDajN5VVgzK1dkMEg1UHhla0Mvc0F2REJSVE9BRnBiUlY1Y25MUGhM?=
 =?utf-8?B?NGc2OTk4KzVOaXRuZGQ5Wm40N3B5ZVFkVVJPaGIyN1p5NlJHRlFtSHRzaHlr?=
 =?utf-8?B?YlZIK1Z4M3FGMWlSQTdZM1ZqQ3lPaVhCT2NOc00rMU1RcFVNYVhTT2xobG9r?=
 =?utf-8?B?VjNLTW5JWkJyZHBIME9MbTB4RjcwYk1aOTFFWk02V3VuR2dLVnZrY2lIRUxa?=
 =?utf-8?B?b3ZsSmpybHJjdy9nNlV5Zko4SE9ESlZ5KzNZSERhTys3R1RRMElsWHlnV2k5?=
 =?utf-8?B?V2l5c0d3emt5T1o5MllnTFFkMTcyTU1yOC9hYXR2VGhpOFE2dFRwQ1VlMGFV?=
 =?utf-8?B?S0xzNCtoZDN6eHlEcjVLUVdPRGFWZ2ptckhaaWp5clpxL1kwVkFKaTliWWFQ?=
 =?utf-8?B?SjdseWNXa2FMTk93cVh4WGZkcXJMTzhZeENMd3NYY2VGSDEycVF4aGNPdU5s?=
 =?utf-8?B?YWJSK3praVZWeFNRQjU2djBJWVY2eGN1VzQ2Rkw0eHZuaXlVRkVObE1PWWU1?=
 =?utf-8?B?T2RLdmtGd1NYRjVESlNsU1FSWWxMLzVhdUljdk5ldjdCUXI1SzFVc3F0SFh4?=
 =?utf-8?B?WnJ0RXFqZU1sUUt6RG5VTkhRTDNmdjU0YkttYitqQnRaSWtYN2NZS2Z0N2tW?=
 =?utf-8?B?T3Y2WnVaNmpYM3RreEVodklCeHFHeVkzNEtKUElxWndmVXltRS85U043cWFH?=
 =?utf-8?B?TjVXMDdXTjNLekZ5TFdmNDh3K2l5K3Fnemh0dlpxd0tGakFycnBKYmtETVhT?=
 =?utf-8?B?R3FvZmZqeWJpWHFQWm5WeVR2c2E0T25WQUdhbzJsS3dENXBkNnRxYWdKNm1B?=
 =?utf-8?B?UittUjVsaWFkeUYwa1FxYVM0MFhQOUNXNkdHSkdPSXRSeFN6UXpNUU5UNkg5?=
 =?utf-8?B?TGxmeDZmd1ZTdThlamxyWHpxSFpUcXJTc0IxUkx1cmNPUmI4Q1lkRWhsaHZE?=
 =?utf-8?B?TlhmL1N6V0M2alFQeHVmSnk2cmhvMGNtVWd0YWpXS0FXVW96aDVSNGVyaGQx?=
 =?utf-8?B?V1E4L0s5Nm5LZFA0TzkvQjhZN3Z4b1RyQ05sNGJYbzl2VUhORFRob2l2TTFq?=
 =?utf-8?B?am5XQ2ZYMEgrYkQxYkViRlRQb2tKNnJjK1VINXNlajdMMkdJMXV1Nkp5OE81?=
 =?utf-8?B?VThvZWp0UVJ6aW1ZZHR3aTZsMGpyc0dYRWJ2dGhRQ0dONkNHQmNLMzV4QmpK?=
 =?utf-8?B?SFkwVkRxM0FoQlFaQndCc0lDZ2dNbm9QYmRMaVdPbEh3THhKbFlPV1ZkQWFo?=
 =?utf-8?B?OEdyNjQ3K2ltT3NCemM4YlVWN2FKQ0RoaWpLcnZxZFVjUC9KRzhNMzE0SklN?=
 =?utf-8?B?bHlNajBFZWZzK3pCOE1DOG1VSFpDMHdxNWsxL2RJNkF2MWN0eE9QSU11SVFn?=
 =?utf-8?B?OFdwTTJzOHYydzJOdHJPZnVvRDVUMWNycDRKK0FqdDVJMTdPV3Q2V05uUGNW?=
 =?utf-8?B?R3dOYWxaWXpsVHVSWkY1ZERMWkhUc1VLYnlmRktrQ0l1MzJOUkg1dWMwc3FN?=
 =?utf-8?B?UmZpdm9DMHA2bzNIRVY5Y0p3N091OUhFczRCL25zYTlyTXBOZXlBZ2xuQ1BO?=
 =?utf-8?B?dzl0cFBuZ0dpVTZGQUg3UStYR1lNU2JMcXFPMzg4bHI3RUpUOTk0bEdjVFNX?=
 =?utf-8?B?Q3R0ZndnOUlyMW5CM1RWMGgrcnhaZHY2bE8rZlBYL2lWdnRFZjdaQ0g2a3o5?=
 =?utf-8?B?SUVsWVQvS2dIZ2VoTldiTnR2bzgvUFdqc2JPQTd4UlZmMGw1Q1FuRnNmcGxx?=
 =?utf-8?Q?mIk8wi9ggzQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0hiQUJRaFpEVGFhZVdleWxXcm5yZU1OTjlTb2tCOC9nQ1NYOTdqUGdveTF3?=
 =?utf-8?B?TnVCaTY5SzY2d013WDdmSG1lMUx6RklqR3lNV0s2U2xydThBK2dqMnhrZ1dS?=
 =?utf-8?B?K1VSdUNIdGcyVGFwK3JvQ1JEYnkxOEd1Q3FZNlZsUjJQU0pRUDJrUjJBakJP?=
 =?utf-8?B?VDFIV2JzUWlsNTZ4TjNwMUVMZzdmenlDNmJ6dUg2OHQ4ZnZQTmhTQnNZZjVB?=
 =?utf-8?B?cUEzZVF2K29CenJDSzVFcm5HV0J0QzI1UmZTYk96N0pzdjdWOExkak9uOTg0?=
 =?utf-8?B?TC9wZlhaOVdJVUZYUGdBMjA3S2hpaDJtQnNjazYwd2RPSGt2eVdnL0tLK0xN?=
 =?utf-8?B?UUdOL1RPWTVrdnJsU1V3TUVaVm9jaHBzbE5oU2hJLzRpcTBtSUxrR2xPVnVP?=
 =?utf-8?B?eVlsNGIyY2xPbzdsa0xsYnh0cFBzQkN1c1o3TnN4dzlZTW1BVmFKa3YxME1U?=
 =?utf-8?B?dklBUzVTT2c1eTRGVGtPRUY1aFo1azE1VVRhQ3czMHIrZlFwNEpKc3BjeXBS?=
 =?utf-8?B?a0tQNGpjT3VSQVpLenNZRnVSVFg2VE5YL1VsUlZrVytHNCsvbEIvYTNPR0JC?=
 =?utf-8?B?RzJFYmltdXVxaFVBM1FwTlZzTlRLdzc2cGZrTElaSmp5ZE41VXVUUmtxa3N3?=
 =?utf-8?B?TVE0UEhDUk9YeE1INDlUOGxaKzlsdHVzYTJ4RW9NVUVzaklhWGU4Z2o4UDlT?=
 =?utf-8?B?REdKY08wa3FEVVF4RUhNeUdyUkZsaStkY2NVSGY0OWJ2dUtWcDJXUVlORTFk?=
 =?utf-8?B?eWVEdnlCRkJwYkN2WmxGYTg3Rld0V3lQMGduVmJDT3dqazNGMmVkT0FUMGNo?=
 =?utf-8?B?bi9YbG5wOFlyb0xRc2dZRVhwZk5LSDdFSVQ1b2NVZG43UVdQRklEdk92bDJv?=
 =?utf-8?B?T1EzbDdIcTZqTFQ4REZEZSs3UmFlWmlCajJaczY1RzExa2pFcXZXc0hTK296?=
 =?utf-8?B?eGNGUlNteURld1ZGUXY3Q21aZkRqTjhTcUNDbDJoVUU2YmtNV0dVdXcrS0Rh?=
 =?utf-8?B?U2xIS2E4bXF4ZVg1TExiZkdJSmlsZkNPemtSbnBUdnhtQkkyeUJmMU1DNXk5?=
 =?utf-8?B?eGErbnBmYytwMERWWUhUYjNoUHU5dWhjbzVoK2J1aHB3L2Y0aWZ0VmpEQVJ0?=
 =?utf-8?B?K1BCc2N1TWtEZU52WnFHUmtpSTFZQ0UyM1BYTENlbVIvS2NmbDNBZTU0V2I4?=
 =?utf-8?B?bllUODRFRUNqaFk5SzdoMVBpcDh3TG9nOEVSR2lpYnU4MnNoYS9oVC8zbHp1?=
 =?utf-8?B?bEI3NVkrSkh2YXZndkZINERoZFhnSDIrbEMzWXoxNzJpZGplM25yQVlzd2VN?=
 =?utf-8?B?cXdpTHlLTFEwTEVCMVlJVUc3OEJ0TDk0aVNLd1VKL1dibkowUklQMEFFdndh?=
 =?utf-8?B?YTh6eHhJS0g0akUrMnRlcmE1Y0NKZjNnWjRDNGdiQi9ZMUNMWEtCVW0wZUsv?=
 =?utf-8?B?UDdRcEpHeE5yV3dNd1dEWlJXT3Nld1kzVGNiQXB4cFl4ZnBkM1RaU0FQUThZ?=
 =?utf-8?B?M01hbVhmQVZKN3pBUTJQZkpRa1ExNjRwVjY1Y20vM1pyRkg5VE9BSnBnaEM5?=
 =?utf-8?B?RW8vb25GVDFrdU9JYjNzVnYrRVZ4Um9Ga3BLbUJvZ3I3MUJSWWFRS0hwZTRK?=
 =?utf-8?B?eFZHam5keUhONW5GWHE2ZkNXYmlUY280YVNVY0l2Rm9Eb2tvZUd1bWp3SDBj?=
 =?utf-8?B?U2lYOXNPSHhPVDF5bzdOWk9DSGpiQjh6cVp4YkZyZDJpZU96blpwQjVTT0x6?=
 =?utf-8?B?TlBOMTMyTkorQ2VaUmYwdlg3dlZYSk44V1Zob0hXSzNkdmtqRUh0Rjd0azJW?=
 =?utf-8?B?aVFSRURjMmNZWnhNNWFXY1hYU1FpYlR6VzRYcVlVZHQ3a0phWnRVcjAvczhB?=
 =?utf-8?B?OXZWODM1NzVGcHZZaHpuU3hsOTQxczVJQ0JWTGlPaHV0QThCb2l3ZmNrajEz?=
 =?utf-8?B?eHpRa1k2c1dKZU95Tm9KKzM4VjdVc3NWOGxqKy9lbU9EZXJpY0kxRFZjbm1z?=
 =?utf-8?B?ZUlRdWUwcTYzdmpDdDBzK2NURGIvbUJvL2laUHFMZzZNdlpzd3NFd0cvdVlB?=
 =?utf-8?B?UnJXY2ZnUEpUL3N2Mk1JTnNPRExVdXg2YnJvS1VMb3Q0c0l1QU9IU3BIRXdG?=
 =?utf-8?B?T2ZOSUVqa2ZmdUF6bFRmRTl4Z0cyWWlQNlN1RmVhVnZOL2QrOHdnNDJ4ZkpN?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a086ee20-9361-4bed-4dad-08ddcfa54b40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 20:11:39.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ltYfQsWvBRkKpex+shorVcqaDpq4iA5RqLUnB0guMEpVQOg4F3gJ7DHZqe+8PkuMUHadunTle+4+PGuJ/N2IdX69IYLoFp4JJEinPjRWHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4993
X-OriginatorOrg: intel.com

Hi Babu,

On 7/25/25 11:29 AM, Babu Moger wrote:
> Configure mbm_event mode on AMD platforms. On AMD platforms, it is
> recommended to use the mbm_event mode, if supported, to prevent the
> hardware from resetting counters between reads. This can result in
> misleading values or display "Unavailable" if no counter is assigned
> to the event.
> 
> The mbm_event mode, referred to as ABMC (Assignable Bandwidth Monitoring
> Counters) on AMD, is enabled by default when supported by the system.

needs imperative

> 
> Update ABMC across all logical processors within the resctrl domain to
> ensure proper functionality.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Patch looks good.

Reinette


