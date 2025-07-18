Return-Path: <linux-kernel+bounces-736234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04158B09A51
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD1F7B87D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5511D5CD1;
	Fri, 18 Jul 2025 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvuNGK6v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30272D613;
	Fri, 18 Jul 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752810876; cv=fail; b=Ex69QB1lLK5arZT23UMeI6Yb5SKmlKHI5x6qEibBj7rQ+F7L9eKSDewnC9Op5NSiiF7qvmIhd9Oo5pI26hHV8PFnSiRtv/kObpPXZ6IReK4rborRXS0UlMRgCV5+rnG1OI2mtsj3xVykZK7TM5VolJXDh8Ri+oYW4GBnRsNleCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752810876; c=relaxed/simple;
	bh=yQg6j9ZodCYMN0lAN0VgAqCbZwlvMu//ZceDAH8S56A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KVC05+KZ0zIDTWpaeMs6PCJkX2Aqa27qa/tgxVXyeDgYn26+fmFgLIiHnl7jjWnNhNSkYfCtfx/df3+7URCDU9xsT9v2/hkRqyr7Hgk8DodsysJ/lrWeyCiCTjk7+FW8Z6jDlTNrgkJd8LdwJI2BtoQT/DzUIMr/3DM2AMps1zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvuNGK6v; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752810874; x=1784346874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yQg6j9ZodCYMN0lAN0VgAqCbZwlvMu//ZceDAH8S56A=;
  b=cvuNGK6vRTRJpMPHO+slET3xNWAtrzOK3ffr5GkyOlvsQS6CLtEkx70f
   ueRMDMzJ0Sgj5im6OL21ueCDSBfai+qv1z3y1b+HtLffd3+1hjYsgnCBP
   ZqfuCoKno/PGIjKwf2DlBb7RkXGguxAupdIichP9aywpw6K/JyDMPG+iH
   +pICA+EyGzCcnPY66yqst8PpGtoKIF7L551mDGNfwU7kRJCFCz4Tp3QR7
   IkiUp+T2rbpQMQj80hGfbeqMZdE9ODqAiZep8GvVt3SwVnjRTgzgNFv2S
   UwinvrHplxO3PPcgH3ybKygoDtVDQmYMXASNUrYjt8o73kqEn3My7b0KD
   Q==;
X-CSE-ConnectionGUID: 87ALqcbhQc6eiJP+7evXVg==
X-CSE-MsgGUID: oKdtlccGRp6cWGd/0DvoVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55040651"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55040651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:54:27 -0700
X-CSE-ConnectionGUID: kKbhyA8dR5KPZaykeoarpg==
X-CSE-MsgGUID: Jp8DbTMERBeBnCamzFZhrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188941015"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 20:54:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:54:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 20:54:25 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.48)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 20:54:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9K/98o/uOPFUxG75HNwJ3UqVPcfXMLOpOfYll7O2de85JTuGGDbkvrQK2BPS7roD7tb+dLJNjMUrh+t7wK6vN1xI025kepPol473BlPssAob0XPuHuEJ/JEX/6iNBjaDckQ0b7unQZlNFxovxFZjZKuWKW7PrjvdtFC14cB+CakAE0c1PO7VS4ToKXgFa9xVhDDeiP2Mdmnfn/q5M9xU40+cKjtS5WRgKsuY6o1mOWNWt2YdcvP3wdRtdxYpj/QYHXDG2Zo35hjidxgk03NrJJUQ9ZqN3F314rC72pQcXOsrL7tmhVj7gTp0bQJMrzV3h733R7RKrrM+cqcv5t48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HVF6pnm6kEajNRTUlSDrh5EOLAVB4/mJcXDwl8WL1E=;
 b=FYBD64afAy2KkmD8nosU4l0zkZBo5J2dsGhSn9Vs9keriQdYbSqGvtXk4qTWK6Jm8+j3tBkP16Bm/p4bITZB6BjhedJbhIH566RYZ5QfipmtARHrYBEsAyhWRyj2o3w1dh9cgFa8M0xyyTSSzjgkZWqI87HxMIBxS7EhqFDxkYCQOpfU1cFuS1ohW1YvG0D+5EuYuVb2B2MQTGMs/25I+NDELU7jKTbP6Xj/xalOx5oEapuLSdGGxHsoNIldkXpY7zPcke79Xt25r1rmAX6QY2DZ3Bb09/7DMQkdeCoHVzNWjWOav6eSVBto9yurjRonXwU4v49Xg9THEi6YCEEAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 18 Jul
 2025 03:54:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 03:54:12 +0000
Message-ID: <c52cf3c7-6dea-45ce-8cb8-28ad230d54e5@intel.com>
Date: Thu, 17 Jul 2025 20:54:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 19/34] fs/resctrl: Pass struct rdtgroup instead of
 individual members
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
 <5b017f308d3bff1b746c8904d0dfde0c11706fc1.1752013061.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <5b017f308d3bff1b746c8904d0dfde0c11706fc1.1752013061.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: e224b43b-110a-4faf-7668-08ddc5aec1ea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXBxTS84SjJuRHBZRld5Y1NZN2RlM0lBSzJJVGZNZWwxUVdsWmdqRVk1Uk8v?=
 =?utf-8?B?NzVnUlNMY0h3eldJbGpTdnlESXlhYVkvVE02d0pzZnJzOENOa3EvR0dmdE8z?=
 =?utf-8?B?SkxqR0xub21FMEppQVRJc2lQUUY4aUZqUmh3aC9BZFdjUjBMUDdJNjRJVEt4?=
 =?utf-8?B?WGpZdnlMUXlvM0Z5NUZHVmg4VEFQQ3JkZ2RZRzd6S3NXMXM5ZHQ1NUVyZUpR?=
 =?utf-8?B?UEdML1Y0TGJBcGt1YVVZTmkzSSt6QUlKT0VqaG02c0k0Tk52S2lwY1JPZlU3?=
 =?utf-8?B?ZkluMTM0NDlzMzZjbTRncXpCSnlCdUx0N1JJdzdXZXdWNWdId0M5TGlCK3NP?=
 =?utf-8?B?Uk9YUER0Z3dYK0M1TEo1VW5iRkdkdnV5cWJOZ0JhSUR4UWFBSyt1cmw4VmVR?=
 =?utf-8?B?ZzJRZCthTGhudktvQ2o2My9oZzE5RG9kTnN4ZFNyOHdIUUFXS0xmSWdWMmJJ?=
 =?utf-8?B?TmJQUC91RktEbGlLN1RCcnpGREk4VlpZNzZYQVJSTFFyYTZXbDE2SG0ydmh1?=
 =?utf-8?B?am1XZzErMCtBdE53dTVUYndUdTVrK1luS3lSTFgwWTNKTEl6YjIvK01ZSGpp?=
 =?utf-8?B?TERSK3NSM2hyaWttWTNRZGhYdmhmSzRZek9qNEprL3B2UzJ1OGhZOTBaUlNP?=
 =?utf-8?B?UjRYdG1rWDRKaUZoa01qMWpacWFEWWt3KzhmZ0QrVk1KZi9DTTN3dE9kMm5r?=
 =?utf-8?B?ak50aWxBOGo5ZEJiMGUrL0ZQN2RpeWlpM0svUzB5RnQ5SElYNGltNXVjLzd5?=
 =?utf-8?B?WVVOdUFBMFdDOHQxTDdMOEZHWkxjV3FaWGlIUnZpWVhIY215QmprMUNTRDJV?=
 =?utf-8?B?emJIMVJ6bGZDbUZTK3VjWHEvTzhDTlhka0UwZm5td0k0TWNqbHlaODlxWjR3?=
 =?utf-8?B?NWFOVGJkQ0w5aTlwOXBNVjI3Z21uZnp2SWJUWTBGME5VdGo0Uk9uQXg1YXA2?=
 =?utf-8?B?WXRLN0ZvbEFkWWxHWHl3Y1lmSmQ5TEdUMHNjS3NhTllOMXo4NHRXcCtxOFUv?=
 =?utf-8?B?T1NERWFXT0hCdWJHMzRnc1JtVDJNYndlOVRSNFh4NjV2eUhpYXl2N2RYQmJB?=
 =?utf-8?B?d3ZzQVVsbEtPWXhOcGZKU3V3QVd5MGcwdkF5ZjNWTzdybHlwellHNS80WDZB?=
 =?utf-8?B?SmJQVWRYL1ZWMlpvRzQ4VHp1RWJRMklBcmdGZ2s4cXJmcnV3anF5a1Y3MEc1?=
 =?utf-8?B?a2xsODgvN2lSZkMzbFhyV0MzU2FBSXI5RzJGbUNzKzFUZlBBR2VYUWJYNHpC?=
 =?utf-8?B?U3lCUmNSZjhNVEJGZXlKYXlUYjZLSGRFamNzaFJ1K3FJdDdaNG9xSFhqMWMy?=
 =?utf-8?B?TDJhSmF3QVVmR09ZZ3RONTVkcTEwOUlKNXY4alA2dlNRbk5JMUZoVXJ1b2M1?=
 =?utf-8?B?L2xYaEo4QUV3c0VDUkZJS0VGdzA5ZG1tclRUb09uOEdrSDNjL2taU0M5S2xi?=
 =?utf-8?B?Sjg5NVlVbGYydjh5OVhRNWQ0RTRDZWpzWGc0WTI5SW1OY2E2WVhtWnVQRUxO?=
 =?utf-8?B?bTVoOFVudHU4Qm9zODRVK3E5OE53TlBGSUJWVHJBcndrVGF5VEorWmxBRDA0?=
 =?utf-8?B?RmJsNU1mUlNmSUh6NTloTWlmUWVtc1Q1ellydGdOQ1B0OEtNR2xqR1hOb1Bl?=
 =?utf-8?B?Z2hVNVZ4YzJ1M0JNdXpxMDRUU1VFU3JNTkFFS3dyQTJEMmM2cUJKaUJDYXJu?=
 =?utf-8?B?ZHA5Z0lsdHova0QzeXpKTWYzMWZhejgwWHk0eDlIWExEemRFWnNPd3dlYVY2?=
 =?utf-8?B?TFg5ZTJHbDRreHNZQkR3RU5mUmgrUWxKQzZoZGpEUEdYNytCcnNObWFEdTFB?=
 =?utf-8?B?c0FwMHJNU3loQ3NodGFNTUZQN1gzN25Sc09oeDVXTFRUVVczck1jbHliYzg5?=
 =?utf-8?B?bUdUcTNvZHIydmUyazVWNlRuNU5iNGZTYm4zclU2bTl0VTZRWm0xbjVCQ3Nk?=
 =?utf-8?Q?rMMLD6k3ZUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hQd0doQkRBdVBpQlJiSWxtd1BTZW9ZclM3Yzd0WTE2S25XMURGNWpNOTNU?=
 =?utf-8?B?c1BiM08wK2wzOW9ZRmV5SlFVNlBRNzlrN0x5V1ViZkNkclVWYXUzQTkrYzdp?=
 =?utf-8?B?OS9Yd2tBbUdZb0N0eVduRXFJcjBiN1I1ZllSb1R1NWI0d0JOaFQ2N2JreWN0?=
 =?utf-8?B?dklkVmVlUFZQNzgwR0dPdkROeG9SZXc4UVBnb1ZhTWR2eTJQckNVTk9nWDRJ?=
 =?utf-8?B?Y05yZjVWWDJpM1FwRnJHL0pmdzk4U2xWQ1dxand4Vmx3UTFEblZ6SUw2cEJG?=
 =?utf-8?B?QXpkWlpJZzcrRURuSmhRNDRKTnJ0dXhlZVhzZU14OWZhNmFRajk2OFdGRjNa?=
 =?utf-8?B?R1BrUXhYSHlVZWlHclZzVHBPR1hBWFBMTUJWWDMvVWZ3ZXZGTEl3ZCthKzV6?=
 =?utf-8?B?LzJ0cVFEdS93VmQwMXUwTHhyVFhjdk13VmdDOE9Pd2J1MGwzRkJISjY1dnBI?=
 =?utf-8?B?MTVOYzlva2l3ZmpMM2dpVStadVRVSVFCZHZINktaZyt1THFxRnJLM2Q5anRP?=
 =?utf-8?B?eTRKdnRvQysrZy9GSlN1cmwzYnVJVkdBM01zVXBWWHJVeERaZ0ZzYnpZUSt6?=
 =?utf-8?B?NE5FNUlaWmxmYklNSUJ5USs2bWNkV0V5QWhkU2lsVGRoWGk4MzVWYkE2VCtl?=
 =?utf-8?B?UUM0UFFoL2FmSGdOTHJmWlFYMytqMUNBVXBlbE4xVGNPMWJoVlJsUWZtWEJS?=
 =?utf-8?B?b21oZFBGUWh3dWZCamFST09FdFdPY01YMWloNnZKQ1BuVFhtdE9reXZqcUFW?=
 =?utf-8?B?RDFyU01iS0RIK01jemdFaWtkYndjRXVLMk9CRDRJYmZpZWdGN2haeVdKMzNM?=
 =?utf-8?B?TEc5TDY1bnU5UVk4UmFYdUZMQi8xaFB5VmE2MWs1ck1TemxSRkpoK2o1YTlW?=
 =?utf-8?B?WDVWNjhTajVVVEJRSWFIVlIzaUYxWnJud0ZWMkRYUEEvQ2xGYWw5UkJiUTd6?=
 =?utf-8?B?aldUQnFWVDEwUGxtWDJxalozZ3pKK2kzdENWdHJiWEZkdVhSaG5OWERwUFRK?=
 =?utf-8?B?aFdVQXFMVFpiRnB5bThaSmNCK291QndUQ2ZVQXlnWDF4blVheGE0dlNFbDlC?=
 =?utf-8?B?Z2ZqZzRNbHo3UlFKVHdXV2pyeGE2WVlsTjJ0ZjJRa1YyQXhCbWpNbmJmaUpC?=
 =?utf-8?B?NHpQRTZPcWtvMFVoVUlpLysrSlFBbWE2MTNMOVYrWU9kaklQTUdJYlFwcGg5?=
 =?utf-8?B?dnJsdmVCc3FoQ3EwZmN4YnJsNDVmNDZDV2tlcUJxM2RvZlZkQnQyQi8wL20y?=
 =?utf-8?B?Um42TSt3VnBuR3FQN3ZnQlRMNHY0MTZWaytPT2N0cTNWV0Ryczd3YWE3Q2ZP?=
 =?utf-8?B?Q3RaTU4wZE8xSSt4MWxPSmttcllrWFZTbVFYYmxqOWxmTktyUjBRWjJ6Nk1M?=
 =?utf-8?B?MjNVSE9UTXgvVEpRZThMd1FLZkhMV1J4ZHNwOGtta0pnYU5OQnFYMEM5UHdr?=
 =?utf-8?B?bUowa3JjMm9KVW40emFobmRCN1JnVlM3Qk80Q1B1U2g0K3ppMzlKNTJtNkor?=
 =?utf-8?B?cTNueDFFR0lqVHg3V0NPKzI2N2ZwdCtEcVhPYUFvMVNDallza2pQblFsSWx0?=
 =?utf-8?B?MFJKOVVGbjVNVmR6TTVZeTVmTjc5SEh6eHIzOFFWT2dZN3pBcWl4QXJCRFUy?=
 =?utf-8?B?RmdIV1VpKzdReUsyaHpqR2ZYbFNWZ1crTzdkQ3hWSExVL3ExQ05SSHVtYTZP?=
 =?utf-8?B?eW9GZkR0TVFoWEFTSHUxZXE1NzlKR0VESmJYSzR1Tm9tUHJhZDZsNTRETEN6?=
 =?utf-8?B?VGJaQXJQR1ViT0JjZEQwYUxpMWI5VzFlb3JLR21KQlFkdndSVzI2ZFFQL0cz?=
 =?utf-8?B?MWRqWGhacUp0d0liN2cvbFczeEQ4b3QycTQvK2JEcCtRcy9xQlQrbE0xbTRk?=
 =?utf-8?B?OExFYmtjWmtvOFk3a2ZlMWVabHdWdWJHUTZjV3YyWU5WMDR4aDRkVW9BS0Rl?=
 =?utf-8?B?cFV5YVpZTWQ5eHl3U2NFNVRvRDJFeWF2ODlaVTBFZGhrdVBPZ1JBZCtMMURE?=
 =?utf-8?B?TVF2V3RtbTZteG05M3RUYllOT0Myb1Q2bWUvOFVpemhzVXk2K3NmRTVPbGVa?=
 =?utf-8?B?Q3ZicElpU0dXMVM0MkUyVkxGNGRzenh0SzdqTmNqUHhBTnRZSEV3Qy81Z1U0?=
 =?utf-8?B?czkvd3JLYzVWM1ltWmpYeG5ZRSs3NXJEczg4NGRIYld4VzhlOGR0dXU3ZnU4?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e224b43b-110a-4faf-7668-08ddc5aec1ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 03:54:12.6502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRo2cF3vt31bwDQlUWUzslvwFmLbejGYcsWpwBCa7iS576q6MbbNroh02V84iNDaxkb3uotygaenKajMzSE68yCVxzfIL+KYgxtuF0nr2R4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com

Hi Babu,

On 7/8/25 3:17 PM, Babu Moger wrote:
> Reading monitoring data for a monitoring group requires both the RMID and
> CLOSID. The RMID and CLOSID are members of struct rdtgroup but passed
> separately to several functions involved in retrieving event data.
> 
> When "mbm_event" counter assignment mode is enabled, a counter ID is
> required to read event data. The counter ID is obtained through
> mbm_cntr_get(), which expects a struct rdtgroup pointer.
> 
> Provide a pointer to the struct rdtgroup as parameter to functions involved
> in retrieving event data to simplify access to RMID, CLOSID, and counter
> ID.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

...

> @@ -429,9 +431,11 @@ static int __mon_event_count(u32 closid, u32 rmid, struct rmid_read *rr)
>   * __mon_event_count() is compared with the chunks value from the previous
>   * invocation. This must be called once per second to maintain values in MBps.
>   */
> -static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)
> +static void mbm_bw_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)

Function comments need an update to match this change.

>  {
>  	u64 cur_bw, bytes, cur_bytes;
> +	u32 closid = rdtgrp->closid;
> +	u32 rmid = rdtgrp->mon.rmid;
>  	struct mbm_state *m;
>  
>  	m = get_mbm_state(rr->d, closid, rmid, rr->evtid);

Reinette

