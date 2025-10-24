Return-Path: <linux-kernel+bounces-869623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04A8C0857D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 01:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807093B05E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 23:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815B30EF77;
	Fri, 24 Oct 2025 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj2Bd8Xz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5277C22A817;
	Fri, 24 Oct 2025 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761349453; cv=fail; b=EwlSCY78CSlrmYI82H4WjnIJ2M1WQn7+ou4Y5yj2fSrU+B7IuBlmyHCEe24fjqPpcrGPM6Er73wAXcFYJH5BmTHbU3MBTdR3OUOfltVV3gPoZidY74lohN1jHJ1tx/klBEdKk3SDOuhJc/ZfhBycB6c+TCsAiH02vmUOI1SRAyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761349453; c=relaxed/simple;
	bh=jtRyxJUhEJ/uo+cNPFfIidA44c8ePDqISbI6pgFYsJc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTE0qqphwpATeVsp7goYcFp3KwhvFMGUDSrabHA6t3EgpjnkIbia00rqSMiCIVjhTFpEIjZcbBCAc2/AL56hnC51LyvdtUEp1Yb9Q/dYOWMeebIp8+Q3FHxFb2GOq/XSzantGx02xH9A4scccSDZDc+T7olSte8ggdbYLe2IQls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj2Bd8Xz; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761349451; x=1792885451;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jtRyxJUhEJ/uo+cNPFfIidA44c8ePDqISbI6pgFYsJc=;
  b=cj2Bd8XzI9NrsOTkt7fFVWDd5VgHHEaLDw2KS7ErhPJSOfSjoCm6G0mk
   b2//djBMIjZpFvGPvLwHKJ9wCBGdGZwyfpvg4RXJDcUh7m+og2UUDllLd
   KeFD80WLCQtNoxQscmU3VVV1rYhKvtyEEpek2SWjYaPTIij7PfrEOH9GZ
   qfrfjUw95j9kyfyRH835L0LmwZPHBviIBXeDSx2KLfPPPw+C74OOW3QQE
   sqit5U3oe1WvvOvZuDSaZT1+hdZCg/eEPCXOn53IpVeL2pDwvtcD+f/20
   /SpVv76PGi8HlGFH8El8fEnvWp0bgmlKHylk73Q3lV87baWmNa+GldzA3
   A==;
X-CSE-ConnectionGUID: Ono2cdkuR5+8XEc4JJE+ew==
X-CSE-MsgGUID: GdJTI6eOS8OrR0dShm/Ttw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="89004098"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="89004098"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:44:10 -0700
X-CSE-ConnectionGUID: ENVWcxc0TUqgYM3QL6Qajw==
X-CSE-MsgGUID: CbjXx7FMRwWYu2aeqTUvjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="189675335"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 16:44:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:44:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 24 Oct 2025 16:44:09 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.53) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 24 Oct 2025 16:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+8gQAdIE4I51RNSsnY26/d/oEG3Js0mC4TLJwjszHDB4n43z0TCWa9bYjHCdOJe7C3IThlQgW3o53XkRpt8zRfGmLjpdDerpXexDAI5oFpY3Mf7Y1tRr7SndA+B2GSsXstyHJQePG/YCLgBmC2xzk+7/XDMyeKb6ab7w4tV174shzKz0QULYVbeSj5cYmPjM4H9Jffr09xrD/oG08By/Wl+fkuTFR5Wuf8oTiUS4ZDBJ0JW6FqcPrYAomQvdT8DeOkHU+GdkUpjnJnKPfiOMW1hJ46b19dE98IHzOAJ802zzDa+g5Ziq+AkHEykcQZjZWeBH4olcsowxYwOPJIN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egwPG+ptYhj20q+C8kdTJVJfOL39YIW4vl3jzkcd/Y4=;
 b=BFdPpcK7L7J1DNv4+CBKzImc3L5OPzcetAsE4go2n6ZppzzE9cWYyG/vpOMqjQ951gDYfOgXXrL3rkL8ljie26Y8HMs6H0DY4fQtk9ao77vsOGDXnP8MHT5JBaR+5N+QhrN2c6UFGvzkCN5OqyrRen8cticczKpM+iZdX9rG3lfo8MsWiujPPADLYJ+8cdWEitsSwzvjHMFfG4f1mynVo2EQEEOTowso8aUpF7d+XpuDyazxJGZJVr1dATnHG/fGfJ7+clXc42oG3B+pnkR2shxoCSPO0n2u++iIs1WSMgn1Rv/KMwKzlkrR7yHDK1Put63OooWMDKdy4Xnyk7K6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV3PR11MB8554.namprd11.prod.outlook.com (2603:10b6:408:1bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 23:43:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 24 Oct 2025
 23:43:55 +0000
Message-ID: <6448dc8f-e045-456b-988b-90a6868dec9f@intel.com>
Date: Fri, 24 Oct 2025 16:43:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/10] fs/resctrl: Introduce interface to modify
 io_alloc capacity bitmasks
To: Babu Moger <babu.moger@amd.com>, <tony.luck@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <corbet@lwn.net>, <Dave.Martin@arm.com>, <james.morse@arm.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <akpm@linux-foundation.org>,
	<paulmck@kernel.org>, <rdunlap@infradead.org>, <pmladek@suse.com>,
	<kees@kernel.org>, <arnd@arndb.de>, <fvdl@google.com>, <seanjc@google.com>,
	<pawan.kumar.gupta@linux.intel.com>, <xin@zytor.com>,
	<thomas.lendacky@amd.com>, <sohil.mehta@intel.com>, <jarkko@kernel.org>,
	<chang.seok.bae@intel.com>, <ebiggers@google.com>,
	<elena.reshetova@intel.com>, <ak@linux.intel.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peternewman@google.com>
References: <cover.1761090859.git.babu.moger@amd.com>
 <3a6d3d9dace1a2dec3418eb00150418e9ef7ac98.1761090860.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <3a6d3d9dace1a2dec3418eb00150418e9ef7ac98.1761090860.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV3PR11MB8554:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b075a8-bf28-4d58-58db-08de1357322b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0hCbDJtT2svUHhnK1NOUDNGdCs3SmRtU0F6ZnZtbVRZakcxcWFGVHRRREt2?=
 =?utf-8?B?cUV1KzluRlBIa29KRmxidWJZRTRodVF3Q1pMZWRtK3VHeHNYN2pyVWpINzJE?=
 =?utf-8?B?Mnc0cmxmRW9hamY5Zno4VDJoL3FpcWRuZXF6ano2aXpmSmpWRkNwd2Z2bGJH?=
 =?utf-8?B?S1Z1TUNIQXZqYTB5OVVzWkNQS2FSelNCV01jbklxTTBlcnI0bXU4TTQzOTZE?=
 =?utf-8?B?R2JkejZaNHpPdTNhQ2NTaERHWXBneGhFT3ZrdklTYllnWW10NVRIMlZ0aTQr?=
 =?utf-8?B?am9MeVhKbCtRRzd0cFoxb3I5dVBnNnhvaHBMazc5K2F2S3RUM1ArWHFRMTMv?=
 =?utf-8?B?TFdCbjFTZE1yenZPc1hFRy9jTWNtTGUyL2JDV2dxbmpvaVo4cnY0VElNM1Jv?=
 =?utf-8?B?bU90bTJCVldRcFozNC9RMXJYZzh6UG1TVTRpcmRab242LzVodFRqNThRRllE?=
 =?utf-8?B?VDJFZGFndXBTcEFncEZzUldrQWNoUjRXWFZtRjhQeXd4cEgwOFVGVUVrdFA0?=
 =?utf-8?B?QTRtOFM4WGc2TzdCbFNpL1pPNVplSnZmdzFwTWJvUXBVaysxUjB6cEZyRDl6?=
 =?utf-8?B?ZjNzdHpIeXllbzJsVnFDM28vdFJhQkNKMUNudnNLWUIrVkRUQmxjMXNDaWs5?=
 =?utf-8?B?d05CWWtHY2F6bklhV2xIa2ZpSWhmeFFQVGsrd1k3K0RWcTAxbE1LQUxSQVhF?=
 =?utf-8?B?RWdJN01UVnE4dHFmUlROV1ZnaWZvTmhEVlhleWlDNjMvd2ZkeEo1N0tsYVIw?=
 =?utf-8?B?cDJwR2tWdDN6WmpFOGpXUGpwdXhYT2RhR253SnpTczgveFhPcE9GZHVUb2Zu?=
 =?utf-8?B?V09sZzNhdUVTNFlVRWVYNzM1TW9QTWlvcysrckJnWFRHQnh1Snp2ZXdJQXAz?=
 =?utf-8?B?T0Vqd2ZUbHVZZzR5SDd2aGdZZkE1WE9GY0h5dTh3dUF0a0ZrcW5SN0EwcDVX?=
 =?utf-8?B?VWk1NEVINmkvZHBTVVllU1Z4WDl1U3poa2FCVkZVR0Zaa2tpZHF6VXUzMzQz?=
 =?utf-8?B?d2M3STBEcXQyclY4M0U3cmRUbEtYbEVjQzNDM2dBUHE3MGs3eGFYd1lGOGFD?=
 =?utf-8?B?RjJQVzN5dC93L2Nlekx4NCtjMGpKOXNrSnY1anVBUEJmVmtlZDNTa2ZTZ2FB?=
 =?utf-8?B?QzkzYzNZL2M2SDhWTGViYTcyOHc2SFFPWWNrVzVsenhRWFFRMFR3TlIzeEhX?=
 =?utf-8?B?MThsWG5IU3k2Vnplc3dkRFo3QzNmUEhZYWVmT1hEOXpIb0JnY1BYSDRMN1Bq?=
 =?utf-8?B?YVRLNlJCR1Aya1hjWHJMZDlYbUFDOVRYTm5iQnhEMUo1c3Ewb1VrNzg2ak1B?=
 =?utf-8?B?QUsrbnpYeittQUk1aGFvS0liT1BRNEFNV0RvWEgwWldWSDF2aVhveldBUXQx?=
 =?utf-8?B?QVAzU0NnRjlRaTR0NzRJUkJVVHVzdWRBZWRWME9qRkFIUWM1S2lvRThNRHVz?=
 =?utf-8?B?VjVvYm4zQ2NlM2NVdTFuRTZFbFBWUnFZQktXQTRpWGN3OHFCWndtWjd5dHJO?=
 =?utf-8?B?VkZsNU9DS2FrMlU5WGFlaWN5WWt4ZHpjQWpjcm1TdmZ6bXA5WjZkRjZuUjBU?=
 =?utf-8?B?OUh6M1FWOVlhaGlSZUt5SUFtZmk3bXRncXY5KzFPd0xhazBSelNPbVlvYWtV?=
 =?utf-8?B?dFovSHF3eWNIOFpNTXpabUJjWHU4RE1RcFZsdUpUdVl2SEpUSkkzTDAyUEha?=
 =?utf-8?B?SEg5V1I3WmI1bzNSQjdnRkMwcDdrM2F2cklyQTJtS3hBbjYwVDJhd2pGZzhi?=
 =?utf-8?B?OSt1WC9UdFVwKzRUMzRxS2l0WE50cnhYdThtbWZKWDBiK29hL21BYzg5emNW?=
 =?utf-8?B?azBXVk1XYm5yamp5Uy9qclBjOXpjS3dGaGIwTW5EZWhiM2NYSi9RczVyYi9p?=
 =?utf-8?B?NWRHZWkzNEpwZ0lDZVIyWjVHMDF1czBCUnVKVnEwUzNaQUF5Yi9QRTNERlU3?=
 =?utf-8?Q?hCoYuv4KZJo5OIb7WjHf13DXzUAHBsmJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBYNkY3cHFTMlVzTEhzVGwyaWNhL05GdXUwSmhhYkExUUltT2hhWWZxUHM4?=
 =?utf-8?B?ZzRERDBMYm8zYkY0SHVPbnByRUJ2NS8yY01CM0pJYzVkdUp4WDRsVlN3WXdY?=
 =?utf-8?B?WVNGdVVLMERNK2NGU1FkM1E3MXFMOUNKbUYzT2VuOHlvY29WdGNlMnZyVVN2?=
 =?utf-8?B?MFpDTlo5dHJRR1dQOXVGUGtneks3U2hZQ0tQUXFtcDhXUW1HRjFPQVFtM0V0?=
 =?utf-8?B?RjE0Zk5Wb2RtWjBvTjRnaGUycXh0MkcrNzZCQVV6T1k4NEkwdDdlMTBKYVBC?=
 =?utf-8?B?ak9HT0xaUEt1b1MzeUdpS3crY0tXMWp0NnJLZlc2bzZPakRXRS9Hc3BPcHpp?=
 =?utf-8?B?UzAwWGZoU3A2RU9HUzJuOEpvUVN2TXhzY1ZIaXhORUczbUIwcWFTTmREcndY?=
 =?utf-8?B?NDVLb2NCbmYyRTJDRVhZeFZWNzZrdE1rY3hsaG5Ldk5NRkFtQUpWd3NwQlla?=
 =?utf-8?B?R0t4dUdjVU1KaW4vWFBVbFdISkVCbE9iakU3Ny9uOFE2THdqSlMzQUFNUFhV?=
 =?utf-8?B?dHJNSzAwL2dURndCeUFZVHM4L09sb0RTZWNNMEtZbXRPdlJTN1VxN2M4b0pQ?=
 =?utf-8?B?ZTFPcHgxNmJSd0xaYW9vN3ErYmlBZzF6L1NYZUtIZkFHYjMyMWRaZEsyUkdJ?=
 =?utf-8?B?QnZkeFd2R0kwVDlaZzlBa1JDeGhibXA4RGlDWjI4QWkwSWF0dkZnZTIvODJp?=
 =?utf-8?B?YS9CcUdkcTNXUmJlalkxSEovNTh5YTluRG4remk2YU9PR3dtMkExOGwxTldm?=
 =?utf-8?B?cFhJVGVqajdEdWRsSUhjQTV6RmMvUW9zUm92cnBlMXZGeE41WVRJZ3dwR2ZG?=
 =?utf-8?B?UWxKclZjVlVCRHNjMExqUTMySkkwTE12Z0ZaUGxMZ1pBR0psQWJwVVhKa3pY?=
 =?utf-8?B?SjNsUXRwQ3hvbXAvV1NHOXJ2TkVjYkdIYW1GYzlqTXdacUswOUcvMGVNT1cz?=
 =?utf-8?B?Z2dTdGVzV1BLbk1FWnEycHA3Ukk3RDltV09ubGt2eVFLKzdTWHFqYmZtMXdI?=
 =?utf-8?B?c0lZQ1U1ZkZzbXNnU2VkRTNZMk9IcnUxVnFuWjUxVENMV1pBQ0tCN1p4Szln?=
 =?utf-8?B?c0VsZnR5angwbitaaTJmUTQvdGF6aVJ4di9sNDFNRlBWTVFVNExKRnd6Z1Ri?=
 =?utf-8?B?dVdXSWh3emtFOVBwallpRUpUZ29zVDdJckZaODdSdEY4MVluQWx5K2I0dm54?=
 =?utf-8?B?UWxKT2kzWTdCakc1cXpGREhnK3hWVG8yN09yc2psN3Vnd3Jtd1ZIUW5vYUIx?=
 =?utf-8?B?U2N3MS9LNzV5YkRMNmg3Q0ViVlhkOC9ETUgwZHl4bU9ITkhDL2pPQTVsVkUy?=
 =?utf-8?B?bzlGRy9hdTkvMm9UYlIwOEJpa1ZSL1NpbzZvVHAyM1B2NUIvblBaOFFrM2FD?=
 =?utf-8?B?dlFOUjZaa0pXWGFBZmpjNzhWQk4wOHM4eTNBbHQyOVNiSTZuZGt3czRlY1Jj?=
 =?utf-8?B?Ym9SeW5tS2k2eXB6UFRsM3dOU2hnMGZwcW51bXNKZ3NUaTZWYlQxWUVEZS9M?=
 =?utf-8?B?S2ZXNXErTkpFb2dRMENYdkNZblc1dkhkMUk2RHpJNi92STNubDJLaUhXVWFC?=
 =?utf-8?B?YTE0eE8vbCtoeHRpRkYyR1NtdWNLRXdNZTFpMzJNb09UNUd6dWVHU3JCWlQw?=
 =?utf-8?B?a3lDWXpWbEdtTHYxUzN2R2Z6WUVtTm11TUh6dWlCZTNYaXBpeUdwaFdJZDRx?=
 =?utf-8?B?S0pFajIxTUY0RjQ4aGY0QnpXaWFWbmpHV2NKNzg1QkVhcWxVQjAzYzJEREMy?=
 =?utf-8?B?Y2ZOQlA1Rmt5YjJOb2VNL2ZzTEdSUlZ0YzRhRUxPL0t1L0hvOW1Nak52RVpP?=
 =?utf-8?B?d1lnaWxUN3VNMTYyazZLVlFuWkl4REFQTGpuNHVYTTY1cVFnV3pSOCtWclZn?=
 =?utf-8?B?NVZhOUlySnFkcC9pUGxxS3N0ZUFMOHhPVUZqNnpkVHI2YTVELytkTjBzeXJY?=
 =?utf-8?B?S3NyOHltdGxCSkgwaHV3SEdHK0ZJS2VQWGJiM1oyYU1ma3R3eVR2MmtURUJu?=
 =?utf-8?B?U1VQMzJjeDVRZm0zcFd1Q0lKSnhQM2tSZFViZTNLTzljc3pPUlhFeFpWL0Fv?=
 =?utf-8?B?VzNWZjhuOWdBVkpvL1NRbjZJS092TDdyQWFVT1BlV0xhRzlscTcrNnJLaFVJ?=
 =?utf-8?B?OGN6MlFtTUxrMDhLM25qVVJTWENTNGVnS05MS0lHK2hYOTROdkoySEFzbGtl?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b075a8-bf28-4d58-58db-08de1357322b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 23:43:55.9209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEF2HVln48cIq9C3JeA1HN2isFZY9gGZSsj1IjS877h+uHPm4gHsmfapFqzdg5Z1LJIAzDcMVVKkETILpHjHSPqyDwxmPaWCJn4qm58jtrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8554
X-OriginatorOrg: intel.com

Hi Babu,

On 10/21/25 4:54 PM, Babu Moger wrote:
> The io_alloc feature in resctrl enables system software to configure the
> portion of the cache allocated for I/O traffic. When supported, the
> io_alloc_cbm file in resctrl provides access to capacity bitmasks (CBMs)
> allocated for I/O devices.
> 
> Enable users to modify io_alloc CBMs by writing to the io_alloc_cbm resctrl
> file when the io_alloc feature is enabled.
> 
> Mirror the CBMs between CDP_CODE and CDP_DATA when CDP is enabled to present
> consistent I/O allocation information to user space.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

