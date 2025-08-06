Return-Path: <linux-kernel+bounces-758396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4705B1CE6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F431721893
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4502D22B8AB;
	Wed,  6 Aug 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG3Omg0m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE9B22A4E9;
	Wed,  6 Aug 2025 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515871; cv=fail; b=MKP0OFrS/RnLkOK+HrkA4/X3XNRsrCDnpJ7QXDszYHzBD/CnisJ9WSf1ggtozrj2D5Z+5YyoPmp6WSybGPNysKgApzOU4zKdLh/vxpnMmRUZuLKLClca/UVNmo48dXZniomEHcl2/hVP+GB91l2ubN23GGNMHrbjDW7YqWVaOrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515871; c=relaxed/simple;
	bh=4iDfOzjuOqfcfieIzhngPXvrKIzBWsKR5ohvenBQ1cA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4s7RB7/JdheRB7Qvcfj4DrcXrjIjcztQYcwCP87D2g9EoKsmAp12dyncyL6hXNpgQOSaV1pObmaZ0MUOcOiwtUOOJqpkyI9y08Z16m9m8NlpEnhnO7XJw9GAq0tvWtP+XyOPjoube3l9gBS+enYjeNC/KqTywoRgxALgMnmltc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG3Omg0m; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754515871; x=1786051871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4iDfOzjuOqfcfieIzhngPXvrKIzBWsKR5ohvenBQ1cA=;
  b=oG3Omg0myYp+/7ePGHDVi3TLcg8ZkFFJmLmakTZ/tG2YWAyN8sGfmaRk
   gGbSTu9qFh87HM1yf2vxgwzZLlpe24a4RyZuCQPHDyZ5ge8cERF/Ka/IW
   7pK9UebJtMFk6hWn/cSjV4S6/tMfNtXPpK0PR2010hhceQLAUMO0aw18U
   8wvCPc58iWgAC6ZW5hZSIkJfBlt6K0UUhIHmOTeDuRgTxHnJijVuhZGX3
   rYdEpeXXpL/HLYBdYjgInd0fP7z9iT+rix/KQHBbG7U0WP7N67QVZBJvZ
   2vNHOIdgNhxWC6FkvWNIATMxJ8g0b+B/xXwBnPFY1ef9i4x3MHGPZKRga
   w==;
X-CSE-ConnectionGUID: FZY+jelHSsKsL9CkcF1kcQ==
X-CSE-MsgGUID: Zcj+gPlTR/Oj9aFawHot9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67922682"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67922682"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:31:10 -0700
X-CSE-ConnectionGUID: zFtEFAGCR4eQNbhg3CnAvA==
X-CSE-MsgGUID: GibamArZTe2sVFVpqqwcqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165678592"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 14:31:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:31:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 14:31:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.54)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 14:31:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/mMhk+RllA990zoJHxnNCaS1uCjzRraflXs/QA5Gfs+KMEygDP/mu5DICEfv3T89FUkTEjH5i0HqxDsuVl1Kg1RCngAHQ3x2jsVIbqUp7Yym+cGDzlYl2LITRuBwp/wjOoSpIESsYjf6fqqVd6SMZKL01MqzBlyws1mKbD6VWu2ms5/rSXzDMnM2PLdDKmHRbw4TcYr2j/vVCBx3rD2ODahignmQxUtVPPWoLy0im+bSY6tl981DywVCME4wa1f/oi/osfr9+NHHcDiol6NcKm2xu0ii3apzy1G6tQYD0Fjj0+5mMtVG5XSOI0Y9WcbINLlvwdmEzBxKUZ30TNEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZmYwBmapEIYSceHiF1pRoR5Bunv2y/gz81CkiO9FeY=;
 b=rpLlludK+Yan0osTkEw4/r55Anm7tMc+VIEQw9bO0jK5sQXnFRk1QQDVOuf/Ec8vvs7FvndH8+ZORhnpCmwkhXAUfNty/X9wbS/JBeiXsTm4Mjo7B7+dSQJrTv2d4Kf5F0inKcV64GWLJeZK7uXKIbvsTZSm+R6Nv6bjU+rv/gSgxP/IHfAWifHQVhTouERrNM+VCzBDmX0PPmW7DErhGiBZQblUqqkuUIFv9sWATuocozVO87k2treuaednm8p4jWCHn1cPojbA86hbl9DGUijhNEwRpuIiUjM6kokrWUjrJXC7SfuU136qCGAXcCEkMgq5DVaKocCeRWqiFKNVhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 21:31:05 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 21:31:04 +0000
Message-ID: <36b10063-e936-443b-bb4d-d0cffa66bae3@intel.com>
Date: Wed, 6 Aug 2025 14:31:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 11/34] fs/resctrl: Add resctrl file to display number
 of assignable counters
To: <babu.moger@amd.com>, <corbet@lwn.net>, <tony.luck@intel.com>,
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
 <d1073b4bc959cd57c40d26bd80b0cccc39748123.1753467772.git.babu.moger@amd.com>
 <4b3e158b-2e27-409d-8b23-8fa042939132@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4b3e158b-2e27-409d-8b23-8fa042939132@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:303:b9::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: c929687e-06d2-4cc8-6763-08ddd5308c1b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2R2K2tUZ0hWYlBzcmtHRTVGUk1GNS9kMXJkaHlBYkJzOEh1enNweVRIR1No?=
 =?utf-8?B?TUJGV0xEK0F6K3NabHYzN0xRNXFteG9VZnI4NGdnNFBBTnRuN1BXZGw5QUVY?=
 =?utf-8?B?WDZoNGRFaTdVMDNlL2k0RTVqUm9vb2dRdHQ4OFdramRZaHprUlZiaXJsb1M1?=
 =?utf-8?B?bWxCcm5HTm1ROFNWa2VkS3ZCSFJBM291d1RXcHNuWC8vcEFhRitvVHFZQ09S?=
 =?utf-8?B?a2pPT2JEa2grWmN1UXEyOU5DZUs5a3ZMSWZjdEw1Qk95a1REQTU4bjN1elow?=
 =?utf-8?B?Z2N4T1NvUkFVWTZuMjR6NWZyL2hhRkQ2UjBWNXVwbnZoa1p0a050V3h1NnIw?=
 =?utf-8?B?NTlNejVjMGIwTjFWTWJ1RmV4MXI2OXJlVzZnK1Zud1hxcDRsR2hXK1JWVkJR?=
 =?utf-8?B?OTh1V2ZpejVaaGFKb0FJL0U4UkZmbzB1NHEycTY2bUFOVDVMQWN1UHlIVE9q?=
 =?utf-8?B?YWUyekROZEtCNW5pOXVkK2REWWFwNjZEZGNDODczS2NPL0FPUEt2aWNwNVJq?=
 =?utf-8?B?RS9zWVFycGI3QW00c1ZBRVoxZE5YNFU0SFVJT2x0TmZkM2VISDc5T3FVL1FO?=
 =?utf-8?B?WnRSUGI0dnU5cnlxSDYwUUNGajdjNXRJenF6UUpva3o3YXNKVlVvRS9SRWpy?=
 =?utf-8?B?ZkMwMng1TEJjRWtzY3A0eEdyNkdqWjg3UjFpVnM1TVF4TUVTbjN2R1RDbkM0?=
 =?utf-8?B?aHFHWEdwWlJMa3pDR0NCYzJEY2kzZFcwcHZzckcvdFVkODVMYTNaVnltN1Qy?=
 =?utf-8?B?NmpuL0Z3ZnczZm9EZllrUnRCdW9OOVh1SWdIMkMyL1pndkJYV0haQXVtNUR4?=
 =?utf-8?B?dXdlNjFXYVhjNHBobHZFMVR1SnNVMFNuVjZZeXAzMzk0cnZhMGRPaktKbUVB?=
 =?utf-8?B?T1Nyb0s0Q2k1eEt4VEFBM3VCRUdKRmMzS0lUUlltMFEvcG5KRDM0TW5WQVda?=
 =?utf-8?B?L1ZIYlRucmh1SHV2OEY2T2F2M1lKbjF4bUpvS1poR2tSNzVwSHB4OVV1b3ZH?=
 =?utf-8?B?a3VNSk8welM0RFE5VHNtUU95dkJUOTdOSytQeWQ3WDZQWmVXT1ozZG81L1Rl?=
 =?utf-8?B?MDIwSHdSOUlKaWkzSVVRZE9JdFdYWExySXNYTWhSd2NWSERmRUdZUytoMmVl?=
 =?utf-8?B?RVVHbnc5M29SRVIyUUcrZ3RDUk01NXk1elRvclVDOTQ2WlZ1cVNJQ0JESGpw?=
 =?utf-8?B?bTRKY2p0Q3VQRWR1T0VJR2dWUVNJMWUxcmZNdEc5YVRJUmpBelJWdGRMZ2gx?=
 =?utf-8?B?QXp5RDV6OFIyZVg2d2lsMXZ3K2I0eUVvQnJlR1RuMzd6UEZuajB5SmROSXpv?=
 =?utf-8?B?cDRVRktiNzEvZmtaM2xqcEcvbXh0WXpGUktyVGVXM3ZnOU5VbTVCYmNOaElP?=
 =?utf-8?B?ejdxTC9tRkxmRjZTV2F5c29BTlVDdFN1NkZqM0ZsZzUwekdNR0RhN1VxUHFp?=
 =?utf-8?B?cVFPQkxqK2tQdXpPNFBmZ2NveS9mRk5jVlNaTkVReHN1T243NkMyTEIrL2lx?=
 =?utf-8?B?c2lJVnY5RFY4NEdqbFJpNzZKcm5sRmpsSnZMekdtUXFIcVZPQ00wenJHdmhp?=
 =?utf-8?B?d2UyM0JZVzNaRWxoUzJFTlVsYnZieVBib21DWlBiQjhsV1k1aDFXSXZLQytQ?=
 =?utf-8?B?V0RKU1RZYnZ0SnRFMGJ1UjBZbFpoNTZjQnNrdk50OHIxbkhiSjhOSjZmTUJB?=
 =?utf-8?B?Ym1jT0xaSlRJMTcrMWM3RHVvSnNwRkxWSE1tR2xKbjhvYXo5NjFOazNrWUYv?=
 =?utf-8?B?clNzK0EyT250M2x6bVNNVWZ4SnFNYXBZUVZUdGhzSmZsT3FnMVBXQWlVYkEz?=
 =?utf-8?B?Zm1ySW8vbUhKTjZyc2Y4c0Q5TlNGLzN2YitWRCtkc2g2dUFCaVdIQkhEcjdD?=
 =?utf-8?B?RDFFb0V5a2kwdForK1RkWUdSZGFVZjNDSUhUR08wdVBCV0JIMUVRdnFPaUdF?=
 =?utf-8?Q?WyOJ+DlXvE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJRWlZxbWcvZmZWMkRzVzE5cy8vMEdWekY1TWdRUTNaU1RWaExyeFlzbWo3?=
 =?utf-8?B?TXlkSFJLZXpxT2sya3lOOCtGeEZSQUQ1TWZ1eHBkUUhxanpBdkZSbXh0YlZ5?=
 =?utf-8?B?ZmlyM0ZGMkUxKytPT3RrNEVrVFBUNTNFanVndzB5V09OUEFzQ2pHT0xQeGtt?=
 =?utf-8?B?SGtDQXVOQVZDbmlWYVVaN2dMNkN5SXdUZnQ4aEhOMlVmR3ZJeFZiczNRSld3?=
 =?utf-8?B?RVpQYUt0SW96c0JXZE1PdWU0dmlUSERkWjFWcWZ2VmJoYkFnVmhIbkMyUXl1?=
 =?utf-8?B?L2FUZ3pJWFlzRG4weHVmbnFnYzhSWGU0RUtjS05HazhTY0RWdmYzcnZXc28r?=
 =?utf-8?B?VlBqbWVsejczbTNmandpNS83OE95NFk4LzlYU1NuMHNXYTVNWHlLbTdXRXNM?=
 =?utf-8?B?T0xEcGlEMi9VS3BCR2VvTGpJZkdtYUd0SnQrVVlIdEpqbktUdGE0dUpOUzVJ?=
 =?utf-8?B?eHQxdjdzcEdGbXN0UGcyM0NBSHpsaXh1L0JrM1RhT1YwK0doSC9KTWpnR3E0?=
 =?utf-8?B?S3E3TFJuYkp5N2RGOVpFZlRXR1VMY3dHd0VwTFErUUxid2dTYWJhcUpOV0s2?=
 =?utf-8?B?UVl1L2tsSEFITThDc2pyQXZYQjB0SkRrSklqQkFrVW9lVVdwOStEcFZ1WjVB?=
 =?utf-8?B?TGxKZVNMMDJXWnM1ek50ZHJDc2d2VzNQRWk5dlhZZjFQOWxTanc3TjRGUzE2?=
 =?utf-8?B?ZG50NFBBOGxHb2ZtTlBoYllDUElIa2RrK3ZqYVFycnhnelFsci9CN3JDYjRN?=
 =?utf-8?B?S09NVlJrZ0kvaE9Xend4c2VnQkxNbWF2WklXVm52TkpSdno1UXcyZ0tpTFhl?=
 =?utf-8?B?aDZOeVNWRnJ6TVEvUXNZbzVTb3hLWTd4NG5lK0xRcDlYMXVveGt2RksyY25o?=
 =?utf-8?B?OFYyUDFpa21lZlFCT2tqTWF0UitnNGhPOHp0MkFoU1VxOXZPQ1JCVGMwSEJN?=
 =?utf-8?B?UUZiQ2w5dFJNV0JMSFJJckpYb0MwN1h1VVo2VnJRL3BwdHYrOStTeFdWR2k3?=
 =?utf-8?B?cVExNDRjOEVNaThvM0o0all1Z3ZXZ2REdmVZRnhONWdEeDQzcytMbE1ZaVBw?=
 =?utf-8?B?ZHhkZ0hFVnQxL3pmL2RVRE9JaDdaSWJXdmJYSUpBcC8vOC9WeVpseVdyY0lH?=
 =?utf-8?B?STNwMngwcjVra3RocDdhRTFqa1dQTW1CRzFDUFJEeEg2T1h4bUlZaG1hemhY?=
 =?utf-8?B?dTNCejRST1pGL291eGJ1TnFwUmhxd05QOXZKSmUyclpTZUNtcSt6NWVJYWJ1?=
 =?utf-8?B?S3orZkJ5SVd0RElBcG1LVnJrRlRWdWJHbVhVd2M4RTlrQWJuUjd6d2I0S0ZN?=
 =?utf-8?B?ekV4ZXkyTFN5Z1prTXliWkNzNTNGN1RzVURCWWhnTndLNytUOWozT3ZZS0J3?=
 =?utf-8?B?Sm54WG9KaHpVNlNxcndQNDZxQnhRYjZ2QU44SWxkV0laVGZnZ0tBZmxVYWN4?=
 =?utf-8?B?aHVtTTc3dzVQemlFTUQvUStoQm5kNFpIcWFNL3pQTVltdVB2WER0ZUI1c1pT?=
 =?utf-8?B?VjlrMFpEZkJtYVF6K3VLdHYvd3FucHdkT21KTS9BNDRMQXdTQ1dud1phRWFN?=
 =?utf-8?B?WlFUWWk5Sk9OMjFoOXVreTAyYm01NzZkaEJycE8wTkhIUkNiaThzWE1CVWd1?=
 =?utf-8?B?WGF5eUt3MnN6SXFDRDFEcUUxamhqZDBoT1pHbGhnQ1lTc2w3YkQ0ZmFPRkw2?=
 =?utf-8?B?YTNGaWM5Z3c4clAybG1qR2V6Z0t2elA2N1pzcnNKRUxWVmxRdUR5Q3RvbHBL?=
 =?utf-8?B?eGtKc2xRcENhQ29jakx5SjhiV1V6eWd3TjVrcUlram5LRTUreFdNUW9PL2dt?=
 =?utf-8?B?UXRlRFpqaENKMmhpYkhPSTdiTE15bGxIZHZZTHlkbjlnUmthVkdpLy9jdUFR?=
 =?utf-8?B?SEh1SjR6M0tpNGw3cWlSRERPSTA3MitZYmdvK2tUQzJWTkIrOWxsWGlSVU5y?=
 =?utf-8?B?Z0JhUjhQeEFQeFBSSEpoUlkxQ2V2N01zaEdrdEVTZndXOGpITjVOaSsyU2Z4?=
 =?utf-8?B?S3FCR0V5NmxJL0I3b0N6b1ViTmFCOE40OWJDVHFHeE9vYnkzR2oxRHhSSzBC?=
 =?utf-8?B?SE9uMkVoOGlrckcxdWJYcXZaUkk0V2N2aUlHWHNJeTRNZmNBeHI4WmFtSmR6?=
 =?utf-8?B?Wk9HTm9ZUnFCNmJDM2R4bWxSTVdkbmg1Sm4zYzVTczFWN0dMWnkxUDNEaXdi?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c929687e-06d2-4cc8-6763-08ddd5308c1b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 21:31:04.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fSvGM7a3J3lsq54jfdfmnSminnle7fb3O8gyy2oKS++LjC/xPttqg6KD+kX1ZefTyK4QFTsrkJ9ju0vte9ivxGqioYgZ5xpKKxtWtzpkuYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
X-OriginatorOrg: intel.com

Hi Babu,

On 8/6/25 2:12 PM, Moger, Babu wrote:
> On 7/25/25 13:29, Babu Moger wrote:
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index c7ca9113a12a..acbda73a9b9d 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1829,6 +1829,30 @@ static int resctrl_mbm_assign_mode_show(struct kernfs_open_file *of,
>>  	return 0;
>>  }
>>  
>> +static int resctrl_num_mbm_cntrs_show(struct kernfs_open_file *of,
>> +				      struct seq_file *s, void *v)
>> +{
>> +	struct rdt_resource *r = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_mon_domain *dom;
>> +	bool sep = false;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	list_for_each_entry(dom, &r->mon_domains, hdr.list) {
>> +		if (sep)
>> +			seq_putc(s, ';');
>> +
>> +		seq_printf(s, "%d=%d", dom->hdr.id, r->mon.num_mbm_cntrs);
>> +		sep = true;
>> +	}
>> +	seq_putc(s, '\n');
>> +
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +	return 0;
>> +}
> 
> How about moving this also to monitor.c?

Yes, this sounds good to me. This is what I had in mind when suggesting in [1]
that the monitoring related handlers should be located in monitor.c

Reinette

[1] https://lore.kernel.org/lkml/0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com/


