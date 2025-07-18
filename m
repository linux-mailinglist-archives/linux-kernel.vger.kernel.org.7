Return-Path: <linux-kernel+bounces-736239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A2AB09A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593737BB6B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030F41CEAB2;
	Fri, 18 Jul 2025 03:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dARqhRL9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE11C84DD;
	Fri, 18 Jul 2025 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752811020; cv=fail; b=IovwvmQgiQ1vFMDxm1D00teEg2saliPhiR1JVJUm+V8XZEZ8QOoE/x8FU/5/f/5j7ei0KsGtTH/UWZ0ZFVp25/I34v6jk8n1eLFJBNj0cLN67jFE1PCZnffE94y1RW7+3eFij/C/UmUHieksjeowKNdhNYr+5QYOTHeKdCzjxKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752811020; c=relaxed/simple;
	bh=OK5CgRyGObgjasfcZWS7Sx2Hi3lg7Hew3Oia9thLeR4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=INztW8CP7iPV+XOWy67pD2hdK4xF0sjMg1sCZELqUhTMATlTpuIdvJAAikjliHZDpzVJITCveg+XHwS37a9+ZGO2wh1v+PsypfMBc6a4ds56Y7tfQkcDR8WGPkSVTfykIDOW4kyqIn3+U2IkdgXc8pOVhqx7CRaGdf8sLU7QXAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dARqhRL9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752811018; x=1784347018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OK5CgRyGObgjasfcZWS7Sx2Hi3lg7Hew3Oia9thLeR4=;
  b=dARqhRL99D07B+5fHCS18ehVuCKX/Iszb6UIBRrEHQmUO7QK2q3F1Cpl
   qFHnfKE/jr+bKyLJzitni7dWz5JfcF0sa9IHASCeQ73SQDhrHzQMDhf1N
   reV4hYzr0FvSWqISMWDyBVKx8zAf1OqE4eEEE2FAQYUPhYAi6bnBOkBlK
   RCf3lOpMH1uWb2nIZ02xopgZS6xLMGmkYZu65Tg0AM2ehfKn8a3oNORVn
   IXAlFnoAtxBqo6spTb/KzUlpxlsFAdQ2M0jJ2smYVbBptHLV3Db8vwddW
   fqSXrHZtQTEMQTnU2NRyLxTxegIeY5MqePmIK0heSfryh/Cjpjovcgcj1
   Q==;
X-CSE-ConnectionGUID: tE69A7qKQfOg9JaWQAl1bg==
X-CSE-MsgGUID: zGIuuHJhTdeYBCz5A1yv/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="54314674"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="54314674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:56:58 -0700
X-CSE-ConnectionGUID: zgt8AXY9TjGqDkv0kheSHg==
X-CSE-MsgGUID: xoC7rLllSHuE/7EmZ+IhtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="157636147"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:56:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:56:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:56:56 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwZV+6DTXrx/ORpu4CiCCoB1Zz00m9rqndMNZkQEfjHRYhd8uKI5PD4xghfXaISzcsiOUhkgSik3lE1TxfDvG84h40ROT28D+iB3VytyXyeVfYIKDBv9GNEUsIUIx0WiOTRv/shYayDw4sQQz6v8vGu1A2o66amzIIyZi/3jIQ1P4Dm4BoXKE9Y/283yTw4OY0+x69FKK76IVyf6s5kpENz6w5FNRsRFFDlHZFFV0/rg2j79HcimAr1Z613EGTmLMgwAVOX8AVfSiOWbMTfU2m+x++/Dkbk8r+bGg3AnaNAQtk50y2YCT4A1m4tnb0WT2oZcrN6rpOxDFp30nxoeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfXWHDF5K2LjgkWppxU2tSL8C+k7gkuY8a7+JoQETNo=;
 b=NduGvNgCcMgzsQ4vH4+S7+RCcbWXU2QQurUjyjddXWRqNU+1eNLeSvfJ1SQ9FSE/VKTN6Pkwdi/mRRGw6VWaQtArFcLMmK9nfphq6fcEI/Ua4jzndj+q8K1Q4Olzr3YBvx9HaLcn4LoxIMmo8AZ/+sf0dW8foGPBcQT0ibHwlS4a0zEd98FfI8yTQvffN+5P/OkhBz5a6TKvB00f5va9SEMAKkZ5sGOLF9Kyffhv2SXm9203j6W3BCLicpRgwKkCgke8abIufrf8jgmxc2W7rj8ifXfTCHcftTZ2EfWeqQXUq9W3YoWmlCzoXCjQ0o3p7/w3aSciFIkOmsbJKZACZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5135.namprd11.prod.outlook.com (2603:10b6:a03:2db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 18 Jul
 2025 03:56:52 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:56:52 +0000
Message-ID: <3cf90472-be2d-4800-b3d2-879b5fca2012@intel.com>
Date: Thu, 17 Jul 2025 20:56:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 29/34] x86,fs/resctrl: Auto assign counters on mkdir
 and clean up on group removal
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
 <9c14b9534bb8fb8e7cd1b2e450312061d9c150d3.1752013061.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <9c14b9534bb8fb8e7cd1b2e450312061d9c150d3.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:303:8c::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: e835c2ab-9cfa-4e90-f3fb-08ddc5af2139
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWlnUmNwUE40L1k1cmxnQU9FaVY5a3Q0UjJKQzVCYnI5SmUzcGlNVEJ3REZO?=
 =?utf-8?B?d2huVFhQdnY0WjZHOG5CN0h5T0Y5Y0pJTjcwYnZHNVZjWFR2M0hUUVlMRDBE?=
 =?utf-8?B?a25TWThxcUlYRFIzbVZ6ZEZ6UUg0U1RqZjBRL3VUY1lNV25VdDljNjc5K2NQ?=
 =?utf-8?B?V2Y2V3RhcGxlUUFLRGh0WEhsWFRHVTk0RUlpdEhYZHlNTFl1NGVvLzVLQitR?=
 =?utf-8?B?WXZleTdmZ2U3aGdFNDBLb2RnTG1PTkNwYzgyUmpNdGRCVFl3WWJSUklrM29G?=
 =?utf-8?B?dFU3cFlFbVRhN3YwbEF2SkNKcXRXenNBaVB4YmxNS25rUXZ3aXZveUZVTm5F?=
 =?utf-8?B?WHJFclhWMkNaRWd6Mm9RcWRPaFJVWlR4aTBYY1djMlc2NkZCckVOeFNoNU1s?=
 =?utf-8?B?S2tpK3phR2hBbDVreWVkK0s2RjJtNkFEVnVKUnMxNzN3dEtiKzRoNkZSbW02?=
 =?utf-8?B?bnpURFpCeE0vT05VbUlMZGJmb1Y5Y291ODQ1TjZPNzZrNFcyWk9LOUZsQ1Jr?=
 =?utf-8?B?TEZPWlVqaHJrbkNMRUhFdFV6bHl5bURjVjFVMk82UTYzd3hGZEQ1WkJoMVlX?=
 =?utf-8?B?bXMrZHpQQU55c0dlak1NWGpocEJ0SU90SFU0ZVBoUEcvRFNnSCtFQ2JJTWFD?=
 =?utf-8?B?SDBmMXVWQm5NYTAxMnl5ZWt2K1hGRzhYaDRwNnMyUmlrTTlrWE5TdlFwUTRN?=
 =?utf-8?B?NmNYZTNmTjZzeVQxYVUvVjcvcVdjNmQ5c1dvRm5lOWhHY3dpMjluZVRtM3Zx?=
 =?utf-8?B?cVdCU2xPOC9IWU9CRG95eW1Sa285OUZxOXhHSjhIdHoybDM4akJGVCt1U0pp?=
 =?utf-8?B?Q25RWFpNdGF6eFh4aFNvK2RLbllSVzFLZEV4OFRFUkVNZzNXWStNdU5OS2Zr?=
 =?utf-8?B?STJnMlRSaDNDY0xuWVhvb1BTWHJJcGRjenVVVXIycHY4bmpROU1SWlNwR3VX?=
 =?utf-8?B?Yk94U1pxV2lwb0R4MFFlcVBVSlgxZWNiTVQzTkJpYjYrTitVd2pOZWFMOFA3?=
 =?utf-8?B?dnlCaFA3eU00eXFSVGN3UXV1RkFjdkxiMisvVWJTamR4a085QmxSNHA2N0lt?=
 =?utf-8?B?RUNuSFpyaWEvMmI1RWg0aENVWGVZMnFRMHd5Sm9uN3hrSWg1b0lyTkhJL2E3?=
 =?utf-8?B?cktFNzQ3TjBwLzA5bWorKzVUTVY5RE4xTE1SSFZzdEM5V2IwVzhnWWVjd3c2?=
 =?utf-8?B?NFFGWjFtb3QrN29ZZWJJY0dqSjZnbUNkR1UreGg0VnFPYUNvN0dBWExsOWl1?=
 =?utf-8?B?bHMwRlcvRVRXdHJLZ1E5NVVDWVROc1dqSmRWMGNjRHhjR2ltTTVzWUNudHRn?=
 =?utf-8?B?dnJBWHkrRFMybTJCSjJmV2d6WWhTREROVG1WekdpWUZnbEZ1dzNXdS9wL3V5?=
 =?utf-8?B?L25nTC9FR3REb1c3NFM4QmQyd3VReWNLb0x5K1YvWlRFOG5uQ3EyNkdobnVx?=
 =?utf-8?B?alQ3dlhITUtHTHlnc2dWcmcvVGsyL1M0MDB2WWM4eTdKZWZkZWJMa3EvQUZq?=
 =?utf-8?B?QXFHSk1Ma3FkQjh1V25wV2I2YTFRR2hiVkMreE85UzVPaGJRL3pFcE9KaGo1?=
 =?utf-8?B?SFFWMFNZbjdpU2g0S2tJeEx6dVZxaFFQOUpXbDFKbHRFU1pEM0owYWVlNWNX?=
 =?utf-8?B?amFCWTZHN25BcHJKTVl3bU83YXNUcXpKNGFXeDRmYmh6aUh1VWxUNnhyMnlZ?=
 =?utf-8?B?ZEZrZm45cWhsU0k5SFZmSzBtbjkweVg1Vm1Rbm0zU3BPVXVTUXU1WWVJRjlh?=
 =?utf-8?B?TmZMdHZacnN6Zkx2WStWaWo0QXluL2NlaDY1bnk0bmdVTUl4ZVREK3E1Nmpa?=
 =?utf-8?B?UTBKNTRiMUNmcmE0YnQrZURGTnB6NWxYcVZOMVFBdGxsVE9wRkRheDBLdTY5?=
 =?utf-8?B?NG5ZRUtCSmVMeTZwT2xTWTVnTEFXNXA3VHd4SjI4dnNKY1JVaEprZUoxL1hT?=
 =?utf-8?Q?LbrN3dgrkG0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejdqVFI2SENoZHVjWEI4cDFTUWxJS21ZeXZTbDBJcDlWVUtnT081YTN1eFI3?=
 =?utf-8?B?UVNRWlJMbjhOdjJRVnd3YnZsR0dmejVEa1JlaktuYm5ncEtmaVZDdEUyYVpF?=
 =?utf-8?B?ejkrSG1pSXNDYnNRQUVJTU1udVMwZ3NYdUROSmZ4dG0wbE04eTdaM1FjRnIy?=
 =?utf-8?B?TGZLbGFZQVBLVUE5RHNDNlVidUJSQzZDRzI0a1RiNmNSdUV5NnBWYUkvb1ln?=
 =?utf-8?B?TG1SaXZidE1jOFRKS2o5eHhwaDVLRXFrMWdsZGtiMVJhc2dnWGkxZ01OWGpz?=
 =?utf-8?B?Y0ZORSt5cVpHUkxzZDhSQzUvdHRpTTYzNlBaVkcxZWVKVjEyQjlhVUVEa2F6?=
 =?utf-8?B?UlpkYVFiYnRjeWN2cnNhQjBBWnpsdnpPQ0RDMzl4Qm1OeWwwZnR5TEdXQ1Vr?=
 =?utf-8?B?dHJ4TWtYdTYxZ2lNcE1kVUlxVlhaVjFNSlV6bnltbWxFTjA4TEtEMG9XWGVF?=
 =?utf-8?B?eEFEZkdvVm4vK0RVVUpFWTdCVGJlMThYeXVlOWRhWkhVLzQ0NVJnYkVTSEFQ?=
 =?utf-8?B?RnJaMTV6UlFpSUw3Z09seVVwbWVGdzBTWGUrcEJpVmVoL0Y4dk1sZWE1Wm1x?=
 =?utf-8?B?bTY4U0g1NURXOEtrdm9DV3QvRDJuS2RNRWdNZWNEY2U5Uzd3UzR4dUo2Nllr?=
 =?utf-8?B?T1BCZHFDTUt0VGdFT3YwU0Njdy9wRE1wNU5vdVlrMG5Ldk9NbFpzUmJOejNa?=
 =?utf-8?B?WXFtWWw4OXJQcDRjcjJiUU95UzNHaGZqci8vV3ovcXJray9yTFRQZlR4YW5v?=
 =?utf-8?B?b2tkQjZaTlQzOHZLT01sd2JpemZGaHZTSEh5bU1KREV3VzNOTzF6MEZoSldY?=
 =?utf-8?B?bXBZMEF5TTNJLzlVZkUxRmNpVHdaQjdOcWhSVjRuKzRIT3h1d2F5S3YrTTZk?=
 =?utf-8?B?RGxyRW1mZ1FKeUdZYzBLSjFuMk8rVmFUL1N4c2wwYXFCMHBUS291M1hCMXg1?=
 =?utf-8?B?NVEzY2V3eDdtNFNrM0djdUNvVWVpb0RSSEdGbkdHMFh0V0g1MmVoZXAreTJw?=
 =?utf-8?B?ZHo1MGRlcjEvbU1ZVmxXOG1BaFFZUEdzSGJraCtCOVBDaTVqR0x1ckdrazlk?=
 =?utf-8?B?aUpzVURVeHJrdjRQbDRHdWJRWDFCOFVVdW5kZHFPV0dIT1Q2cUNVNWx2VVZS?=
 =?utf-8?B?OTRrVk8rb3dHN0pkNGVhUllzUzVnZVhaWXo1RzR2V0JNOGd1bXM0TktHdmxZ?=
 =?utf-8?B?UWhhWThiMGl2YXpOUmtKWEw1Z2w2QURaNWxtcUpBV2U0SjlxZjR3elFxZEZm?=
 =?utf-8?B?TUFSaTNJM2dTLzkzYUZQV1NvNzVjVnU4SnJMdGlGSTNneGNHbktCSVU5SXVM?=
 =?utf-8?B?R010Vlk2RDNVR0c0M1NJZ1AxQ0p6WnM1RFRaYVIzSzFJYlVoTThWL1hXdnFH?=
 =?utf-8?B?VGVhc1hkckxVNG9JZ0sxMEcrRUJRNG1VczF1QUtzeEEybjc5RnVoTzNJcjYv?=
 =?utf-8?B?bmFHeWFYTGZlRFRuOUFhR3dJY0x1VWVMUkdEbHlkT0dsTFh1ZnF6b0FlOGhM?=
 =?utf-8?B?N09FY0g5YnkyQlVPQ1haeE5pYWh6bVozKysxNm9ySXpFNkNQMG5FdXJoWEsz?=
 =?utf-8?B?cURzNjI0Y282d2FYby9vdDZCcUJoaG1EZzRnUmxYV1dVd3NmQ0ZDbWZCY3Jn?=
 =?utf-8?B?Mnp1VVhHbjUyUWhpMDBpMjlBSEtCVnVYZUlmdnRVdEFVb0FhTURJOGl3azlq?=
 =?utf-8?B?WXhoQVVxZ2xHbFhKVit3a1d2UkZyVm4rM1NUd3czZHkyMmVnTmdUaU1xZ211?=
 =?utf-8?B?aVF1bUhaVGh4cFkwTzV3V3YxbU54QXdCWGxDck5WY0x2ZnZWdFVRcE8rdi9k?=
 =?utf-8?B?WHVzQjJUeUxiL0Rrbm92Q0E3alR4L3RBRDhFOHg1YmtQZkFsVkFBZHE3RFZW?=
 =?utf-8?B?cWkxMGpUbnRKNnhKeEYyL0h3R1ZZUmdWRmJ4eHI1RkVlV08xV0VLbUlNMGJY?=
 =?utf-8?B?U0xNbDhVVnlBWlZ4VmYxWkQyK3BiS1FnRWdvbzkxMUxUL0NFSlNKSmJlSTNR?=
 =?utf-8?B?TzI3QWF3dmtsUkUxNmNQWmhTcHkzNDA5NjF1TVN1L0F4azdrMFRYR0FWMVJa?=
 =?utf-8?B?Q1J2YnFLY1dac2wzQWRmUDN0bHg5QVBzZFo0V1R3ZHBSYkdMUlU1eVFtSEcr?=
 =?utf-8?B?MnVIeWo2NU9Nc3duM2FxTmJWbTNUR0tUMENSSUJuMlIzWjFzUjZ5OGZmYnY3?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e835c2ab-9cfa-4e90-f3fb-08ddc5af2139
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:56:52.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C69TKXgsQ9jy+5tZhx8YqH3Tv4ZQdNMLc50brzXu0NLkf7ZNkdSnah0RPqnzMnVAtt5vpju2apn2YmI+1SyqXLE39CatvocnfQFHOsEymJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5135
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Resctrl provides a user-configurable option mbm_assign_on_mkdir that
> determines if a counter will automatically be assigned to an RMID, event
> pair when its associated monitor group is created via mkdir.
> 
> Enable mbm_assign_on_mkdir by default and automatically assign the counters
> when a resctrl group is created.
> 
> Counters allocated to a resctrl group should be released when the group is
> deleted. Add support to unassign and free counters during the group
> teardown.
> 
> By default, each group requires two counters: one for the MBM total event
> and one for the MBM local event.
> 
> If the counters are exhausted, the kernel will log the error message
> "Unable to allocate counter in domain" in
> /sys/fs/resctrl/info/last_cmd_status when a new group is created and the
> counter assignment will fail. However, the creation of a group should not
> fail due to assignment failures. Users have the flexibility to modify the
> assignments at a later time.

I find that this changelog jumps around a bit. Below is an attempt at some
re-organization. Please feel free to improve:

	Resctrl provides a user-configurable option mbm_assign_on_mkdir that            
	determines if a counter will automatically be assigned to an RMID, event        
	pair when its associated monitor group is created via mkdir.                    
                                                                                
	Enable mbm_assign_on_mkdir by default to automatically assign                   
	counters to the two default events (MBM total and MBM local) of a new           
	monitoring group created via mkdir. This maintains backward compatibility       
	with original resctrl support for these two events.                             
                                                                                
	Unassign and free counters belonging to a monitoring group when the group is    
	deleted.                                                                        
                                                                                
	Monitor group creation does not fail if a counter cannot be assigned to         
	one or both events. There may be limited counters and users have the      
	flexibility to modify counter assignments at a later time.                      
	Log the error message "Unable to allocate counter in domain" in                 
	/sys/fs/resctrl/info/last_cmd_status when a new monitoring group is created     
	but counter assignment failed.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c |  1 +
>  fs/resctrl/rdtgroup.c                 | 70 ++++++++++++++++++++++++++-
>  2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 026c2e2d19d3..e0706083fe0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -457,6 +457,7 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  		r->mon.mbm_cntr_assignable = true;
>  		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
>  		r->mon.num_mbm_cntrs = (ebx & GENMASK(15, 0)) + 1;
> +		r->mon.mbm_assign_on_mkdir = true;

This is a resctrl fs default. Should it not be set in
resctrl_mon_resource_init()?


>  	}
>  
>  	r->mon_capable = true;
> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
> index b7289ce2b3a6..645245f274e9 100644
> --- a/fs/resctrl/rdtgroup.c
> +++ b/fs/resctrl/rdtgroup.c
> @@ -2884,6 +2884,54 @@ static void schemata_list_destroy(void)
>  	}
>  }
>  
> +/*
> + * rdtgroup_assign_cntrs() - Assign counters to MBM events. Called when
> + *			     a new group is created.
> + * If "mbm_event" counter assignment mode is enabled, counters should be
> + * automatically assigned if the "mbm_assign_on_mkdir" is set.
> + * Each group can accommodate two counters: one for the total event and

"Each group can accommodate two counters" -> "Each group can accommodate two counters
per domain"?

> + * one for the local event. Assignments may fail due to the limited number
> + * of counters. However, it is not necessary to fail the group creation
> + * and thus no failure is returned. Users have the option to modify the
> + * counter assignments after the group has been created.
> + */
> +static void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
> +{
> +	struct rdt_resource *r = resctrl_arch_get_resource(RDT_RESOURCE_L3);
> +
> +	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
> +	    !r->mon.mbm_assign_on_mkdir)
> +		return;
> +
> +	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
> +		rdtgroup_assign_cntr_event(NULL, rdtgrp,
> +					   &mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID]);
> +
> +	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
> +		rdtgroup_assign_cntr_event(NULL, rdtgrp,
> +					   &mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID]);
> +}
> +

Reinette


