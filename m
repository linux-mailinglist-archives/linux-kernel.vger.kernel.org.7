Return-Path: <linux-kernel+bounces-858347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE2BEA533
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B571AE0F93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FED2F12C0;
	Fri, 17 Oct 2025 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBjJf6IV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AA32472B0
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716339; cv=fail; b=gn+KmCWku6sYnctqeuWufkLM8QrE15sK7836K7kW/vt7VrPtVGIrenrIUmmSYq17XuenXZ4AsdCqMK0RiQHLoSgZwj06786aEqlIQXG2nE/EWVatstgdWbw7rk73WV6KezjqEuo251yz1qHbIrBAGXN1MYdwWM02Opu039sm6B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716339; c=relaxed/simple;
	bh=hwbxmGZRw0LhVfsyPSflqdyN9pGXefZuXkyYMZzCZ0w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TmKjA1QN2/01w1SO2JxzPAIPRIxEJePOKnGgNyU6o1JI6Ksmxzi1JX01/2IHhzfnObIOiJeVp2s/6onqmat3RiIBqwZa3gje+MB1A1R3WGSR0riPgdu0e5iQGN1MdNWLPYhuk/TG+uqDaUnUy56VZ/DN921K/TgLiQdiPoke7Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBjJf6IV; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760716338; x=1792252338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hwbxmGZRw0LhVfsyPSflqdyN9pGXefZuXkyYMZzCZ0w=;
  b=dBjJf6IVQwPS2jSmPX+qBP0Pi9fmu2S/SXG7TGTFjOejm272llxCZlra
   024aAYevf5U+Cnmjht0DqUQ6Y1UBQL8M2juLtNUci2KWt+ZqP2sgZ3fJi
   kwty18o8tmxGlwaKnpqjBaChpz++e/rCmP+maIT3qky22JYXZdWb0Ks1C
   RbzWOwHWinxlIROv8hhDexvjaxySv+buoauTO/RH8snJG6W7K/2QnAyG4
   XJqC2en1TFxpdYsCrCGTOoLWNlgxqIoy7h3I429+PrHvS1cKswM55zf+9
   KbS77jjl+1NwnJAYqvOkzZVVJ6CBlgWWMbzbXRUAG8p00gMnadI0IJ7qf
   Q==;
X-CSE-ConnectionGUID: vppeTqzrSl+rcusWTJbi5A==
X-CSE-MsgGUID: 63vyUxDbRJe3iX18NaKqmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="61958338"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="61958338"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:52:17 -0700
X-CSE-ConnectionGUID: 1NnhG4KkQZ+T+v0IN5zKKA==
X-CSE-MsgGUID: oim+FVU1StSv27QSJujHsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="187021964"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 08:52:17 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:52:16 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 17 Oct 2025 08:52:16 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 17 Oct 2025 08:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1LAaRX9+5Pu/Jn0fHMnAMHW+QQsWcWvAg+w4/CbxsCr3XIyQcXKkDh0lpXIDOmGTCWX4AJ9hqPgD61JvvbtI3wxoYhFngZzbXC5ZBI79/A3ze7EjirYKYub5qlyWvCNYlkMnaA77HeGiiMGY5CKq7cWKkg+YdhnWJcYDZiVaIwr1sIGxbz+JR0y0sVznOQE8Hna4tHd5RJ5GE8vpTWgLZv4uZL9yYRu4xz4ntwcJPp4cDc2LhQHVAuYDLwnl3NeBFUoJxTNWrDbkdScLSB3qFvNJ/OGKe380q0c8HmAHGg7gfMtcSIA2Kw2pz3btT6dxE1Iuqbql6TdnDO71KGBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NCnSilZ1/Y0vXQ4Deng1khb4aEtvyHAQCn6NGdHGA0=;
 b=i2jbsMwlwYsjHSjD0AbQMZJ9VJ3m8wFtC34NRnZCFs5p56wUO3812U5/NzsJIvyGoXRKBrn4FaTZ2PGnKxxdLOYa+1epJMPYaa79NL6Yjr8M7dws29DM9xoKD187jvzuftn+ZThBTOiVye6KP7JbISpzFsfS2KuIBf0mdF1g9SlJL82XzAIiPHZjEOSuAWbOqjuQuhKYE1zw/H3z4tOQ13LIJ1mQ4Hppl4IGgY7nJuMRtKzFSCk8bN3zVQO4exkCEGeeI4Zbo9e+7qplixr54Fig84DqL4b27gLuFrOxkKmq9g5cEeAjI4scgI5XLYdOJhrUxGeItr7nu4Nz2F6F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by SN7PR11MB7020.namprd11.prod.outlook.com (2603:10b6:806:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 15:52:11 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 15:52:10 +0000
Message-ID: <ed6360d9-e191-4e52-88f2-70ebcba26cdd@intel.com>
Date: Fri, 17 Oct 2025 08:52:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING: CPU: 1 PID: 0 at arch/x86/kernel/cpu/cpuid-deps.c:123
 do_clear_cpu_cap+0xdc/0x130 on Intel(R) Atom(TM) CPU N450 system
Content-Language: en-US
To: Andi Kleen <ak@linux.intel.com>, Salvatore Bonaccorso <carnil@debian.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	=?UTF-8?Q?Lauren=C8=9Biu_P=C4=83ncescu?= <lpancescu@gmail.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, Eric Biggers <ebiggers@google.com>,
	<linux-kernel@vger.kernel.org>, <1117002@bugs.debian.org>
References: <aPJNPPFKsPKJWlLn@eldamar.lan> <aPJim0ofgtL8RV5s@tassilo>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <aPJim0ofgtL8RV5s@tassilo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::23) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|SN7PR11MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: adb0b750-3012-48a5-48ef-08de0d952212
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVBlUVl3bGxydHl5dzIyM2YwZ2tFVy8rSEFuS3p2S0FKS08ycVpGWGhMZjdl?=
 =?utf-8?B?MENxNkp5SXRqMUJ1UG5aQ1FUY1cveG5CdmJiTjRXYy9meWozbWhPYXFyVlhL?=
 =?utf-8?B?SVg3YXpjUm5WVU5XN3p1QjVoYnVydEhHU2czK1JldnIwVVdLVEhzY3k4amhG?=
 =?utf-8?B?Y1o4c1pBQ0ZVaTQ0anZDeVJSM2taZUJsb0V3Rm9vVzdVZDhvVklGcVlqQVlj?=
 =?utf-8?B?TW9uU2c3aXZFeVQ4TFJIMWk2WDV0RzR2WkliNEtxYlhBMjRZUVZuSlN3YWp1?=
 =?utf-8?B?RXVzUllEcnQxZnlHcE01RFhpQmdyZWp5QmdLWTEyYml6V0xvaXNZU2JnSWVj?=
 =?utf-8?B?SlJCUUh6WWYzbzdrMVUrZDRQVjUwb2NmWnBNVVVtY1hRc005eC94REFBV2g4?=
 =?utf-8?B?OHdOZ2FVekE3cGlnNE00cC8wUnB0STJZdWg1VmhkN3Jhd1d5SUZFN2ZlV2lj?=
 =?utf-8?B?NmJFN3d0SHdwalQ4bW9KYzU0NTVJRTlNV3lFSzVRb3lLTmowaGpMU2FaV1FJ?=
 =?utf-8?B?UUNrMGlpUnlHditwSHBKcWNkaU5FamxkLzNnaCtSdzZqOEZneGs1VmlITzhE?=
 =?utf-8?B?KzNWa3Z6bExQTGFWVkJGRWsxSzFzWFV5eUlRQUVhMGZpL0doMVpJZHFOTW9J?=
 =?utf-8?B?eVljcVgrMnBzMmUrZytHbDdVMC82Q1JPNVhxR2tDd0I0bnAwa001Z3Y0b0dz?=
 =?utf-8?B?Y0NUbTRTaUpQOTVPNjBidm1ka0NMSkZHdWlkTEFXb1NtZEMyRm9KSzMrVUs5?=
 =?utf-8?B?NE9JSVRKa0phR3piem91N056Vk1vS3NpZzdrL0ZsSWRtSGRHRG91SUMvYytu?=
 =?utf-8?B?dlM5eVRCYmdDS284TCs3RzR3V29obDAvVld2aHhmdU5jQm1oSVcwMEtyb0dx?=
 =?utf-8?B?KzhnSkppQkdGQmREbGJIdHFHN2lmb0VJeHZMWHNlKy9RTU9ZNGlIVXdGWEZx?=
 =?utf-8?B?dzA1MWhhdnVPMy9TTnE4cEtYK1JzckRPWUh3dmc3ZHlRbWhWbXM1VjhEL0NJ?=
 =?utf-8?B?cDZISE1GVWxqUnR1MjJZblFhdFg0OTNtMVNMemgya25PTjFmQXVpSzFic0gw?=
 =?utf-8?B?WHo1eldEUGJUZTRpNS9GTDZXL2ZUaXhJZUU1UE1XUld5TTVMUXROSkt5Q3RC?=
 =?utf-8?B?Y3JTSXFHOXA4b0xYY3V4UE52Q1czVjRra01DSG5QbXVjeDhuUFp4cWlEemhR?=
 =?utf-8?B?SERiQko2Y2NaT0wzWTRmT09XVEFYalJoVWdoQmRmSTdMemZ6RmhBaEVWOG5D?=
 =?utf-8?B?MkdKYW55N1J2cnF3K1lMVHRPYlNqMHZtRjhubVlUSG91bDZ1ZHBORnlwTW9I?=
 =?utf-8?B?b3RUMVJzUmVyV1ErcFhOU3NTMEhFT2J3T2pGVWFJaFk0ZVA5UGU3TndkU2ZI?=
 =?utf-8?B?Zm9rVTQ1RUp3RFA2QVUzQTg0NWxBT0hoZkpOaWhCcUpoWGYzTDJRcHhlUEY3?=
 =?utf-8?B?aXhIQ1ZZbEQyTEs1V0hnYmdMblpseTdjL3RGQ2ZHNDlMRXNuYXpyTzNpZHZk?=
 =?utf-8?B?WDlFaGd1TUtmZ3dMN2RhLzJnbVRBZWZ2b2pCS09FbVhHd3U0c3p6Z1VybTBz?=
 =?utf-8?B?dXI3Zjd2WnZRUVF2amNmRUlaY3Y1VjhHYlc5WWJYS0Q4bWVxdXpQcjhwVWp0?=
 =?utf-8?B?Q0xTN3BCaFVrSCtpSytiZVNvTCtTN2VGV2xoYjJCSVJETWdjZUtsNmFVSERt?=
 =?utf-8?B?bkxjS0l0MVV0S1BwQ1p1VlFvVFhZRkFsSnd3eGNSUmY0c2RMeVF2RWxZRmVa?=
 =?utf-8?B?bWFnWjdxblViNm1mR3RTdkRSSUQ1SHF6OUdXaGxIRzk1Z2NOeWxMV0ZCMEs3?=
 =?utf-8?B?aWxycFpReWszR2h5dFdMcGR3QXV4N1JwdW9SQk1Qa3FhUHZvNWQxL21JUm0w?=
 =?utf-8?B?ZitmUDd0QThoWHVHWlRzaW9wbDNXUjFxNjZWYXRzQTlKSG5zdTlCWEF3aURN?=
 =?utf-8?Q?LNCY4CLpx47RANDo19r0sriVkc+rjmeH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9Da3hjUWovdGFIUTF6ZXRGNU1oTFRRdTB3dkc1RFpMcHB6VGorUWZ2MGRm?=
 =?utf-8?B?OThGYlpoSEgranQ4WnM0UkNGNGdENVlrWWZVYnliNVBRZEw2c054ek5qQ1Vy?=
 =?utf-8?B?c1F3NWJhSTVpWkU2OElqUHpVWXpZT2hzdmlQT05sa3o5b0dlWHN0UklSN2ZN?=
 =?utf-8?B?am5UTUFxbk5wOUdNeFBiYzFjSUxlZGJZYkhlbXdVNHhyRkVRS0ZxWjA4YVlp?=
 =?utf-8?B?RmcxVjdhUkpzK1Qxci9EdGJhUSs4K3JpU2gvYlJvbzMybkJXeU9PTW5wZ2s1?=
 =?utf-8?B?RHhOK2FzQk9RaFNOUjExK3QzMVNMZzMvWnRXT29KWEF0TWMrUkRQcy8wMUJu?=
 =?utf-8?B?SnZtVmxCWHcyVkNxRTNhVFc0azhGNFJoaFNmbzVwcTVZclJoRDdYemZSQnVt?=
 =?utf-8?B?Y2xRT0J5THBESE9HRkRHUk1BUXk0ckRWQU5zY3RhRXh2L0pOb0hhRkdFWEFo?=
 =?utf-8?B?ai9EUHI2VW9iUm9jZU1pek4rbHc5OCtPSTRJUWswNnJJUlhKbUJIWGhlQTc0?=
 =?utf-8?B?NWVZcmVITFZaQmgwK1FwbFpiSTNydkI4UVAzVTZBUTRxem8yekFuTFFiWUlE?=
 =?utf-8?B?T0hhWGtZNXVhNVNyMk50NXRkL2J1enptRTZoR3Q1TnhKcjZ4V1VvNSt6NmxO?=
 =?utf-8?B?bXZJTi9XYyt3dFRGRXVob2pUdUJBWHF2aW9Ma0phQXRla0xrZWJncks2K0Fq?=
 =?utf-8?B?eFQ0VWdWU0NtRFJ6ckJxM3lPcVFCTEpYdjNXRWNwYm10d2NITFhpU2xMVmJz?=
 =?utf-8?B?R2RiV1FKZGNUUlZDcGhqdUhYV0dIb0J5MlVnUEl0ZmFwTGdJajdKeFZ1S0lL?=
 =?utf-8?B?NDhYK000NE5KcXZuenNrN011MFZIemtFd29CazFaeCtJMTJxQmFpL0w3NkUr?=
 =?utf-8?B?YU5Sd1RqL0g1SW0weUFVbFNrejZlS1Z1MlZOU1hRNWZHTjdYQnpYcXdYMXJX?=
 =?utf-8?B?S2NqMmNKNUhOTzB3MjU4T3FTbzl6QnV2NkZNT2RUYnBNSkJnMUg2Z2QzTkl2?=
 =?utf-8?B?THRGNkZMWlZSK085TGpCUjlXekVwQ3d2S3NFam5JUTN6MjJTdG5KYnR0Znh5?=
 =?utf-8?B?NnM1dERzUUc2b0NMNEhGdGJzTHFnbWlYMkNHSDRmbURMQWpQb0VVTmlUWDIy?=
 =?utf-8?B?T2E0b09QRmszYUcvYkNGSmZCUmJTYkppNzJRWXNzOURyUGtwYm5zSnRxaVJw?=
 =?utf-8?B?eU5nZ2lSa3grVjVxQWNUYmFHemdiZHdvSWZEMXgwZHhWcEYvckhiOW5RQWtC?=
 =?utf-8?B?ZEhGMU9LaDI5UWxmbzF3d050TjAwTnNNN2VPU3h2b3kvSG9zTG85cVhYRXlx?=
 =?utf-8?B?aFd4UEt1cUhYbGEwRnZON012Q25rNFc2Wlh6SE5TaUlTbXFEczRoY0dmODRL?=
 =?utf-8?B?di8vNDZRYmhvbjhsVjhZcURjYTFYOEVlQVl4ZHVKWC9qdnhZYmM5TDdxb3h3?=
 =?utf-8?B?UzNwNmlzVk5hVWFjNEtYOHVlSlprWFRTQ09qVEtyYWhpeTErcjhFc2M2MlpG?=
 =?utf-8?B?MUtPV1E1QitUVXBjaE5XT1pVcmlmVlpEa0JjZTlEWmRsZXcwTXIzc2NoWkZa?=
 =?utf-8?B?Z1NnaUpSTlBrQWdDZjZIT3MzODVKdWdIVmFHK0FPTC9ZZGdCTjJkaDliN0tz?=
 =?utf-8?B?LzdzQ1BrVE80S2NVTHdYWHA1ZGlLRk12OVp0TkxQcmRrV2MraDZZbU9ESEJn?=
 =?utf-8?B?Y082OHNmejEzZjF5bnpYMFpUeVo3ZDJQMUVRS3dyU09IV2pHekJpTkpIUnhr?=
 =?utf-8?B?Q1dZOFpuT0JYOFBoekRIQVc4YS9vNk4wMGlVSlJ5Ymx4TEJiZUxYbXJpNmVV?=
 =?utf-8?B?dTFxT1puOHhGM0xDUFJibldXMVg3OHFKV2JqQ00zTW9HL1ZuckJUV2R1N1g1?=
 =?utf-8?B?YTlpYlp2ZW1nbDlDMHhqOWJRTVA5cGR5RzRnaG40ZXY4RDFDcS9wT3NsQWJU?=
 =?utf-8?B?TEJQM1JqKzNLeWozdUFIM2E5aUlUK0JzMjd3TTB5cGF3MlhFTExIN3V2RTdv?=
 =?utf-8?B?dEhrc2hkQlJQV2pXMzdGM0tNc2p3M3pyTHFvVWgzYXQ2QzRsay82Y2EzbWFY?=
 =?utf-8?B?dEZHclc5ZUtSQytSSFpBUU51NUtUWnNFT2FLMk9rMmNUWWdUb1pHNGFUcGJ2?=
 =?utf-8?Q?NX1QVmtOUwGM1pgz14sO+7WOC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adb0b750-3012-48a5-48ef-08de0d952212
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 15:52:10.8023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuM4tFi6HNJoyhF90Ptjr+ZY9czwJaX9rQC7jIbTnhizn7CBFZRhFPcpo3+32WF1eGzTzXHb3FumBQIAhWgS4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7020
X-OriginatorOrg: intel.com

On 10/17/2025 8:36 AM, Andi Kleen wrote:
>> [    0.351035] smp: Bringing up secondary CPUs ...
>> [    0.351876] smpboot: x86: Booting SMP configuration:
>> [    0.351888] .... node  #0, CPUs:      #1
>> [    0.008282] Disabled fast string operations
> 
> It's probably caused by that. I guess he disabled fast strings in his
> BIOS and if he switches that setting it would go away.
> 
> The related code would need to be moved earlier in the boot sequence to
> make the alternative patching work.
> 

I am not sure about moving the code.

Based on the CPU information in the dmesg:
smpboot: CPU0: Intel(R) Atom(TM) CPU N450   @ 1.66GHz (family: 0x6,
model: 0x1c, stepping: 0xa)

This code should behave the same way on Boot CPU and secondary CPUs. So,
as Dave mentioned, it is likely to be an (BIOS) issue if it is exposed
inconsistently across CPUs.

	if (c->x86_vfm >= INTEL_PENTIUM_M_DOTHAN) {
		rdmsrq(MSR_IA32_MISC_ENABLE, misc_enable);
		if (misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING) {
			/* X86_FEATURE_ERMS is set based on CPUID */
			set_cpu_cap(c, X86_FEATURE_REP_GOOD);
		} else {
			pr_info("Disabled fast string operations\n");
			setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
			setup_clear_cpu_cap(X86_FEATURE_ERMS);
		}
	}



> But in practice it's unlikely it causes any real functional problems
> 

