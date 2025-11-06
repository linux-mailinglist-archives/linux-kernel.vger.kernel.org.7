Return-Path: <linux-kernel+bounces-889199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7FC3CF39
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19693A68B4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8A350D78;
	Thu,  6 Nov 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfYwF9Vh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43262350280
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451170; cv=fail; b=mfjeLGkGVfIk1e8I5O7Ye+BhW2Esnc/4HPKZM7jg7GZIP2KR15+Ic9eRvDSuU7HhXQQO3mLWnXwvVC0KkMpQuxqcEoRL/ZaDvZMns4c1bMQuJsyfYlXOWTNgtnGAxMCZcJAKwFYspaK3cu8iKGCLDqNd4Evv0GdgXpKlGEUX5dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451170; c=relaxed/simple;
	bh=VpFV8Gp2VfewBECl8FQ1hS2uSFVCSay/I4FFFywqP4A=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3ZV7LdexRB7tx9zJtI3vZezlMz5pWolh+Grh/suvIHn8KTRQbOX2rJh4p6OnuHDYY14+hBn9KRzKcMKZgYhb3mRolQJlZYf4fTibLbGzaNekPPoVTzKjdlXglcoVIf8GGE0taFnbR4V0CDfHeL1ecMmnQFUZrsmxn5vfCdLPu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfYwF9Vh; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762451167; x=1793987167;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VpFV8Gp2VfewBECl8FQ1hS2uSFVCSay/I4FFFywqP4A=;
  b=HfYwF9VhzDshYkPmMXlxxTk77KQlSr/h8Gg87mpQQ7LbKW4ThYzHVtmt
   OPXsS1IhWdXqJfzNU3NSSM4haaIkKR8PmThzFGSlivonZpTfyS6f0YN/q
   SRldR4H+4QZcVISxQ27jhC69HpVLOG9aNaIK3AKCVtUkrqUI5l/+PD0z9
   uiUkzVMkOjK3yBmovYNWI+SEtbsqlZUpHeqkCZvJtDGSfIRpCMjYBEehy
   2uwltjV3GGao9jpydTrBp7sn1hhcS+fEwBV/PwLJeRC1ptstjoUyNb0Ox
   nBlw6wckbcKEx0bF+sDnf68JcW/WS2O1JPtSb/b3j7rH+XX5kd2lGu2L6
   Q==;
X-CSE-ConnectionGUID: 3T3BuG+1R0qIlzhTd24GOw==
X-CSE-MsgGUID: sRt4Ms/IQu2tHHjKISygWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="76046261"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="76046261"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:46:05 -0800
X-CSE-ConnectionGUID: n3JgUHaxQzSrwo+wZrQn7g==
X-CSE-MsgGUID: 51cXfVOeRC6xDWgpYe8qjA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 09:46:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:46:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 6 Nov 2025 09:46:04 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 6 Nov 2025 09:46:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1JA//M+3q3TyqdcEBCyt9zoZ5FL+vbMHG6sCeyYcCbIEVmKS7bgAnZWiVxLVmHv/U1hQocuAg/THlFJYC2ulC3V6KklXGIms+DUhKXlFqOee9cI4qYILmV1K6ZOYgW4B7t8lVJWPS+TO8vg1MyEajCusaEjfQ0IqVn41z5PsnFFFabSsx7K24DUyMQJu+ljLM00lggPqsYEGhh1dyTz14SLFxo7gkOcBFuPOIaGaOf8co1JRQhrra8TfypXjsXNvT/3/ubXNPuwYZ9gdjc5cdcuFrPo/sMUyVCujFaVdFNQPiGO86v/5IShKzG+YKVHrgin3M3OI21ICFLITUFCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF8jrasViXX3A3314JRpzyuBAoXud5QU8+9h1wjMW7k=;
 b=dbDtP7dKAq8u77OGwPwqJNc5jfk34rsfomZkpFHIQruWtHJ1wmlv4OtU7EBE2Ua13InQynJZ5S0pvkElG6D4zIntNO/4gXG5I4cIfmE+nRJprvAIeIC8/kBWSokc1F6Oq/I46llOPm3Y9VU741re98zmMqThlKBIWgWrDOsA5KAd/VPl16YUxbNS2RI2itsgS++h5eYTWqnzEBjOUUiKA3NF+zObtgQeDtmYzcIFEwx9FsJF3EyaFySeXpO+EWbOJdz3gs78K/JUfmtbzI71BeCnvz3RUsdFAze+bPDE0qemVDJpZkRR7TgodnCp+vYgdfn0VrKgp7WjvIsa1fjChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 17:46:01 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:46:01 +0000
Message-ID: <6e8d3645-cb0d-4bfe-a170-6306e3c60582@intel.com>
Date: Thu, 6 Nov 2025 09:45:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fs/resctrl: Generic schema description
From: Reinette Chatre <reinette.chatre@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "James
 Morse" <james.morse@arm.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	Drew Fustini <dfustini@baylibre.com>
References: <aPtfMFfLV1l/RB0L@e133380.arm.com>
 <a9b49861-ff36-4550-ad29-a737eb5c1d63@intel.com>
 <aQOUAeVP9oc7RIn/@e133380.arm.com>
 <08078c25-87fc-43e6-b062-f9945edcee80@intel.com>
Content-Language: en-US
In-Reply-To: <08078c25-87fc-43e6-b062-f9945edcee80@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:303:6b::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: cc942437-828c-4cda-506b-08de1d5c597b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVltMHQzSGNtckJKbDBVb0hyZkR4T3hrOFNtMHd5NlV3UnY2cXp6ems4ZGZ4?=
 =?utf-8?B?c0JVY3J2RkM3RDMxOGJtMWpNd3d0cVlWa21OVDJ3NE05em56ellWamtkU0di?=
 =?utf-8?B?M0NaT2ovOHFKOWhVb0h6TzRhNHZnN1N1cGlzTjE3cHQwZ0Z1VEtpMENpUFdM?=
 =?utf-8?B?Z1d3LzFjL2UvSXdIWjNoaTA2WEl3UG54T2NKQVkzV1U2Vk9hY3I1YW1yMERr?=
 =?utf-8?B?d2RYWmxKOUFKb3RsMkFKY2tjL216dFp1UUY1bG9LS1BXM2VpSEdqQXI1cHMy?=
 =?utf-8?B?Q0JzRUNiYmpONnJVc1g5eXRGbzNaVWVkVmt3N0FuMHp3T2RRb3FEZy85aTdJ?=
 =?utf-8?B?aUc2UWxIUCt3MS94ZU5DOEdNazJvazRnVCtNaVJaSTFnUmIzVExXRDZHcDNa?=
 =?utf-8?B?VWVyQnNrWGdWMjgxM0xHLzlCT29MWTBDNkNDdGRVajIwZGZieTFJQmZTclEy?=
 =?utf-8?B?d1VyRElOYy9xRVJjVXBiSGZNNEhGSEU4dFNUK3hpSFNOVGtaQ1RwMDFYQ0I3?=
 =?utf-8?B?RXpvelZjTndpVDJBK1ZQUi9icC9LK05obzh5ZDdJVlpxSUIxVVY5ZllJN2Nz?=
 =?utf-8?B?SkdmZFdiK0JLbDloZXdWWVFmYTBLRzk0R3ZkVm9iaTNzM01jMk4zQWlvVVl5?=
 =?utf-8?B?NVdhQmZoTllNeDB3UHFFVEFiSFBER3hDSHFSQ1BzMFBIVFlqVGg5U1BiWFJ2?=
 =?utf-8?B?aEEzM1hxaXVMeUZQY1RCdWwzWXZRTkExWE0wV2hPcFNzUk54a1J6b2VGZ2Mx?=
 =?utf-8?B?ZzQ5SXcrRWVsdnpFa244WFAzU21YaFVRdjA4VGRpOU5IVzdxVzcwMFM3STVj?=
 =?utf-8?B?Ym9RYjZYYXBlUEZId29JazdESzlpSjNFSFVEaHg2TUxQSDdqaCt4dkRmYzZN?=
 =?utf-8?B?TStoV3lVS0p6KzdQRWh0ZjZzMHZZRFJxV1JqSjZpTjhVeklZeUlvNHhLWm1s?=
 =?utf-8?B?MXN0NzU5ZUVIMXh3LzFxeVp4N2hqRWd3TW03TjNvd0hub0R1aEFHTkZXbktV?=
 =?utf-8?B?MkxvVnN4ZG5KRmlVemNLeXNwa0VFdTd1RjFmSUV1cTlJTFJwamJDV3RRTWhG?=
 =?utf-8?B?OUNkZkhFOHp2QWZ4NXROdTZJY0ZqM2E0TER4YjZGWDdGdXIvWEZEOFQ2ZWJS?=
 =?utf-8?B?TGw5bi9CTDZSR3puRVArNUFqNEJiRVFZWHlTOEx1ZXhucVV0em15RmZMOU42?=
 =?utf-8?B?OThNQnRvTmhsMVdFYVkyL0FwOWxUbGJsWFJIUFhFcXZzUlpOZGxIalRrUWNF?=
 =?utf-8?B?a21iT1JlYWpGZkUvMiswKytNbnNocUlyMFVvaDN6a1BvTVRVckFLU0xYa1pv?=
 =?utf-8?B?RVNTWE92czFqUFl0bG9vRTd3cTkycjMvVkd5M0ZpekhablVUNVRsRWNrUHNZ?=
 =?utf-8?B?K1ZEc2QyVTAyQVNXTzdtQXdUVjdoYU51anlkbXlxOU4rdVM5NkJVWDhjalAr?=
 =?utf-8?B?K3dXdTVuS1BwZERiYUlpdHVCWk1PVUZJRmZGN3V3ZFozYnlGYWtWT2lPNFkr?=
 =?utf-8?B?WFVCQkNocks4VmJ6am02REZZZ3E0RnNBTnJVcko4SldkcTJiL21YMC9XMXRw?=
 =?utf-8?B?Tjk1UTRQQ2ZFNGpETjNJb0RvblVQa2pTVjBVQjNEL1lVeU94N1NicktEbkpx?=
 =?utf-8?B?WVFSa2pBaHpNbFdjb3VQdjFHam1uaTgyWDdGQTJJQlNpNlNWcXB0c2t3N2I4?=
 =?utf-8?B?bVdSWFAxSkNaTUl0akc5ZnlYS0MrckpSV1VyTVlMSEpPaVdGcEpCZDNzQWdk?=
 =?utf-8?B?a0EyNTNMeGgwQ2ZMT3lMUVYxNFNZS2F5dm1PMlErVWVQTHZGanBFRHV1cGNQ?=
 =?utf-8?B?em9FcEZUTCtyL3pwTTBOMXJvSzVTZ0ZkZWhwaU1Yb0RDZ3N3U0IxMXcxYUJi?=
 =?utf-8?B?Qkk1Rm53OFpTY2Q1emcvaFIxLy9VNndHTDNDeVMzaUh4ckh0WmV0NUYxdlAx?=
 =?utf-8?Q?j8qeug0/4P8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VExqQ3FHNFB5dEpleU1BM1UzeHEwbXltVjZ4cXFmQWFFbTlLMktuejFFQTJE?=
 =?utf-8?B?MkhsZ01DZTRPOVRJV0dTejd2czlwMytuY1hTd3VpcTRBQXlPT2o4ZG5kalQ0?=
 =?utf-8?B?NTdPN0czM1pFT0ZTWWk3MlpPWWxZUFl2V2tqR2xYMTgvNkg0UGhCeXpoUGwx?=
 =?utf-8?B?c3NieURlTzVOTGc1NkhkbEk0ZTJ3Yllta2Jwb3djV01mVDU4UDM2ZlZ2VHhE?=
 =?utf-8?B?ZXZ1bFZZOFZOREhhZ3lSdlIyZ3daZEtjSTRuTTlNOEpRZkJVRUQzYk9OM1lh?=
 =?utf-8?B?RTE5Q0g4MkYvb1J5M214Q1lVeUJ6YmZUUm1va2R6OHE5aFVjM0VZVHN4c2ti?=
 =?utf-8?B?NzdLYVhSTW9ZWlhZQWpBWk9kVDhneFV1OWFxcmxybnl2UFJhRERUZkpURGk4?=
 =?utf-8?B?VHRzY3d1YjhGNDRvcDMrL05JVkJKU2dVY3psMzBpTU84QWhNQ0tNL0t6amEv?=
 =?utf-8?B?T1plbHgvTXBqZEhQbkhjOWtGcFB4Unk3cVBDbmpRT1RYRkVTVkxVeE9BYkwr?=
 =?utf-8?B?aWVwVGJwU1p5RVRWSVpUa0dnYm9GNENiYXhROHk4T1ZLWktKeGFXdFg1OUUr?=
 =?utf-8?B?Mm1qRjBmcHo4cnk1WkVSNzhlZVhzTDcyZ0NjSUx2akl5UE1zL0lMcTgrdXQz?=
 =?utf-8?B?YUF5U0VmVzdsekVVMms0bjZXc1gzWlRndjZrZFVxdk9qTDBieUxxSkhVemFr?=
 =?utf-8?B?NktMOTM0ejNFU2ZxNllyamRrdG1VUEtPUGVxeVA4aFpFWDVSMWxVWGhhVlRG?=
 =?utf-8?B?Yzcxbm42b3B0aDdVSTBpanVjb0plbGVLam5wYysrMTgvUFp0OWtyNWY4NDhJ?=
 =?utf-8?B?SVBrVmdxWjh2RU85d0kwSXB4UzlFY3V6WlY3WE5HNU9uQ3pDTS85eUNUUzNL?=
 =?utf-8?B?WnEwQXlJODR6N0ZDdmFGdjZ3Z3BEdTV0NENEVmRaQ0Nyei9PQk0wenNtTld0?=
 =?utf-8?B?ay80SGc5ZjQ0TjZpSzZNVzZYcEJ1RndUcFFvTEpaZFBBU1oxOXA5YXVtYnds?=
 =?utf-8?B?L0Z1K2MwTjU2eFdVRDZiaHc4YXNyM2szdnBjOVBnNW5EY1VYLzFoUWJuRFZT?=
 =?utf-8?B?QytGSHljU0VZbEhQdVlISnJnS3Rxb1pOQzU2QmFRaXZqbEVpai96SUQ2cGJi?=
 =?utf-8?B?eG5tZEdyWDZGNStZWGJNZE1LVmFzcDJOaFB6UXJkc1gzWEw0ZmxtczVSRm1y?=
 =?utf-8?B?dVlNSjhxNkFMeVE1aURVVXV1NDZaVk9wYm9aNVp0eExxelByV0NIVmFPd3hu?=
 =?utf-8?B?VnBNK2FvNDhsYkNlWVFUN1Rjd3hMbFZkRkc3RkJoekpJR3BvQkFqdFZkcTE0?=
 =?utf-8?B?QkIzU0NQb0s1MzRhVE9LRjVvcGRkSCtCRGJVQTFiOXZ0ZnhHSTJzWElYSzIx?=
 =?utf-8?B?K0xWUGE5VlVZQjFaOG1Bc3dVZGxnMms3RmN4dkJaNkd1Q0FMTWljZjU5NEoz?=
 =?utf-8?B?azZWcENSaUhjeHQ1WFJiVHFmOUJqQzhEY2JhWitieTNXc2ZVVVhoZnM2ZFcv?=
 =?utf-8?B?Szhoc2VpaVorSlBMZkpBK2U1d0p2dUtyeGFvUW1rekh2cDV4ZUJ6Qmh6K2VX?=
 =?utf-8?B?UUl1NlNZajJHSFVMUUdhQ295eHN3dXlqWkhhcG5hdUFKQUlHY3ZyUFdBbHhC?=
 =?utf-8?B?MHVBUEFYZkNOYVhHMHdBOXZseWIvUzNObmNRU2YrcmFsZy9HK00vRm16VjQy?=
 =?utf-8?B?ZnQ4S1lHUm11S2pZQVFYeU9idlNYMXlIeTd3c28zaVY3bVNvd3JCYi8yTDlM?=
 =?utf-8?B?SXUxTUxsbVBwRkZEV0ltZVFtWmNza1p3V1hlQ056L1VNTGRiOFkrVE9GS0dF?=
 =?utf-8?B?TEZKTmt4dEpWNlF2ejBTUkJQZXJEWkx5VU9RbTFxUGdZMXpuMEJId0dlcXBJ?=
 =?utf-8?B?ckF6UXRiYWprSnhOeVdsS2hjNys4aHJKY2JRVW96dW13dHRiZ1JjKzh5eEM0?=
 =?utf-8?B?WkNvaFF2Y3NBREJXZjdDTWkxVndnM25mNVlCelEyTzRrYSsrZzZYZHhkaEsr?=
 =?utf-8?B?TDVPWVh4OTljZzZEbGV6NU84K2ZWb1dzU25nWUxnNDFPdjUzZ2lpVkhSOWNH?=
 =?utf-8?B?NENUTHd6bWt2Sk5RdW03bjROMzBGdnpkTkpIVTJ5aGdqYjJ0VzRrOVYvQk45?=
 =?utf-8?B?Y1VGRlE1UDNmdjdKc2NXUVR0WGluYzRwTS9keEk2K1NIUmsrUFFYUys5Ylpk?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc942437-828c-4cda-506b-08de1d5c597b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:46:01.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X3L75ThDiddG2FrfyJ1YlSJavH1w0nNWVhAI90hkz9w9EqR+bso2hhbQR4HHVRSp5tcfWlzWp7aCCEjPdo/IqnNK8qPiA+f1O9Nd1wOx9f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8047
X-OriginatorOrg: intel.com

+Drew

On 11/4/25 2:26 PM, Reinette Chatre wrote:
> Hi Dave,
> 
> On 10/30/25 9:36 AM, Dave Martin wrote:
>> Hi Reinette,
>>
>> On Tue, Oct 28, 2025 at 04:17:05PM -0700, Reinette Chatre wrote:
>>> Hi Dave,
>>>
>>> On 10/24/25 4:12 AM, Dave Martin wrote:
>>>> Hi all,
>>>>
>>>> Going forward, a single resctrl resource (such as memory bandwidth) is
>>>> likely to require multiple schemata, either because we want to add new
>>>> schemata that provide finer control, or because the hardware has
>>>> multiple controls, covering different aspects of resource allocation.
>>>>
>>>> The fit between MPAM's memory bandwidth controls and the resctrl MB
>>>> schema is already awkward, and later Intel RDT features such as Region
>>>> Aware Memory Bandwidth Allocation are already pushing past what the MB
>>>> schema can describe.  Both of these can involve multiple control
>>>> values and finer resolution than the 100 steps offered by the current
>>>> "MB" schema.
>>>>
>>>> The previous discussion went off in a few different directions [1], so
>>>> I want to focus back onto defining an extended schema description that
>>>> aims to cover the use cases that we know about or anticipate today, and
>>>> allows for future extension as needed.
>>>>
>>>> (A separate discussion is needed on how new schemata interact with
>>>> previously-defined schemata (such as the MB percentage schema). 
>>>> suggest we pause that discussion for now, in the interests of getting
>>>> the schema description nailed down.)
>>>
>>> ok, but let's keep this as "open #1"
>>>
>>>> Following on from the previous mail thread, I've tried to refine and
>>>> flesh out the proposal for schema descriptions a bit, as follows.
>>>>
>>>> Proposal:
>>>>
>>>>   * Split resource names and schema names in resctrlfs.
>>>>
>>>>     Resources will be named for the unique, existing schema for each
>>>>     resource.
>>>
>>> Are you referring to the implementation or how things are exposed to user
>>> space? I am trying to understand how the existing L3CODE/L3DATA schemata
>>> fit in ... they are presented to user space as two separate resources since
>>> they each have their own directory in "info" while internally they are 
>>> schema of the L3 resource.
>>
>> Good question -- I didn't take into account here the fact that some
>> physical resources already have multiple schemata exposed to userspace.
>>
>> I've probably overformalised, here.  I'm not proposing to refactor the
>> arrangement of existing schemata and resources.	
>>
>> So we would continue to have
>> info/L3CODE/resource_schemata/L3CODE/ and
>> info/L3DATA/resource_schemata/L3DATA/.
>>
>>
>> I think that the decision to combine these under a single resctrl
>> resource internally is the most logical one, but I'm proposing just to
>> extend the info/ content, without unnecssary changes.
> 
> Thank you for confirming. This matches the way I was thinking about this work.
> 
>>
>> The current arrangement does have one shortcoming, which is that
>> software doesn't know (other than by built-in knowledge) that L3CODE
>> and L3DATA claim resource from the same hardware pool, so
>>
>> 	L3CODE:0=0001
>> 	L3DATA:0=0001
>>
>> implies that the transactions on the I-side and D-side contend for
>> cache lines (unless there are separate L3 I- and D-caches -- but I
>> don't think that's a thing on any relevant system...)
>>
>> So, we might want some way to indicate that L3CODE and L3DATA are
>> linked.  But I think that CDP is a unique case where we can reasonably
>> expect some built-in userspace knowledge.
> 
> I'll admit that it is not as obvious as this new interface would make it be
> for new schemata but userspace is not entirely left to its own devices. 
> resctrl will ensure that these resources do not overlap when, for example,
> a resource group is exclusive. For example, an L3CODE allocation in one
> resource group cannot be created to overlap with an L3DATA allocation in
> another when one of the resource groups is exclusive.
> 
>>
>> I didn't currently plan to address this, but it could come later if we
>> think it's important.
>>
>>> Just trying to understand if you are talking about reverting
>>> https://lore.kernel.org/all/20210728170637.25610-1-james.morse@arm.com/ ?
>>
>> No...
>>
>>> The current implementation appears to match this proposal so we may need to
>>> have special cases to keep CDP backwards compatible.
>>>
>>> SMBA may also need some extra care ... especially if other architectures start
>>> to allocate memory bandwidth to CXL resource via their "MB" resource.
>>
>> Perhaps.  I think it may be necessary to hack up and implementation of
>> these changes, to flush out things that don't quite fit.
> 
> Have you considered how MPAM may want to deal with different memory "types"?
> With SMBA there is a "CXL memory" resource while the MB resource has mostly
> been "anything that misses L3". From a user space perspective it is not obvious
> to me how users prefer to refer to different memory types.
> 
>>
>>>  
>>>>     The existing schema will keep its name (the same as the resource
>>>>     name), and new schemata defined for a resource will include that
>>>>     name as a prefix (at least, by default).
> 
> We may have to be explicit on expectations wrt which schema can be observed in
> which area (schemata file vs new info hierarchy). resctrl.rst currently contains:
> 	"schemata":
> 		A list of all the resources available to this group.
> With the above in existing documentation resctrl may be forced to always keep
> existing schema/resource in the schemata file and be careful when considering to
> drop them as mused in https://lore.kernel.org/lkml/aPkEb4CkJHZVDt0V@agluck-desk3/
> 
> Theoretically it may be possible in the future for it to vary which resources a
> resource group may allocate. Consider for example when resources support different
> numbers of CLOSID/PARTID and there is a desire to expose that to user space instead of
> constraining all resource groups to lowest CLOSID/PARTID. In such a scenario it should
> be clear to user space which resources it can allocate to a resource group so it is
> reasonable to expect the existing documentation for "schemata" being "A list of all
> the resources available to this group." to be respected.
> 
> On the flip side, it may not be required that a new schema in new info hierarchy always
> appears in the schemata file. Reason I think this is after seeing in MPAM that
> controls could be enabled/disabled (like MPAMCFG_MBW_PROP.EN for proportional-stride
> partitioning).
> 
> resctrl may thus have support for more partitioning controls than what is exposed by
> schemata file with ability for user space to choose which partitioning controls to expose
> in schemata file to use to manage a resource. It may then turn out that in addition to
> (read-only) schema "properties" there may also be (writable) schema "controls" (bad name
> since this would "control" a "partitioning control") where user space can modify behavior
> of a partitioning control.
> 
>>>>
>>>>     So, for example, we will have an MB resource with a schema called
>>>>     MB (the schema that we have already).  But we may go on to define
>>>>     additional schemata for the MB resource, with names such MB_MAX,
>>>>     etc.
>>>>
>>>>   * Stop adding new schema description information in the top-level
>>>>     info/<resource>/ directory in resctrlfs.
>>>>
>>>>     For backwards compatibilty, we can keep the existing property
>>>>     files under the resource info directory to describe the previously
>>>>     defined resource, but we seem to need something richer going
>>>>     forward.
> 
> ack.
> 
>>>>
>>>>   * Add a hierarchy to list all the schemata for each resource, along
>>>>     with their properties.  So far, the proposal looks like this,
>>>>     taking the MB resource as an example:
>>>>
>>>> 	info/
>>>> 	 └─ MB/
>>>> 	     └─ resource_schemata/
>>>> 	         ├─ MB/
>>>> 	         ├─ MB_MIN/
>>>> 	         ├─ MB_MAX/
>>>> 	         ┆
>>>>
>>>>     Here, MB, MB_MIN and MB_MAX are all schemata for the "MB" resource.
>>>>     In this proposal, what these just dummy schema names for
>>>>     illustration purposes.  The important thing is that they all
>>>>     control aspects of the "MB" resource, and that there can be more
>>>>     than one of them.
>>>>
>>>>     It may be appropriate to have a nested hierarchy, where some
>>>>     schemata are presented as children of other schemata if they
>>>>     affect the same hardware controls.  For now, let's put this issue
>>>>     on one side, and consider what properties should be advertsed for
>>>>     each schema.
>>>
>>> ok to put this aside but I think we should keep including it, "open #2" ?
>>
>> Yes; I'm not abandoning this, but I wanted to focus on the schema
>> description, here.
> 
> Understood. There may be some connection with this work if there is a hierarchy
> since one schema's description may then be in terms of another. For example,
> the relationships described via pseudocode in https://lore.kernel.org/lkml/aPJP52jXJvRYAjjV@e133380.arm.com/
> 
> As a sidenote (related to the '#' prefix discussion), while trying to understand how
> this work may impact user expectations I did come across this in section
> "Reading/writing the schemata file" of resctrl.rst:
> 	When writing you only need to specify those values which you wish to change.
> 
> This seems quite close to addressing the concern raised in
> https://lore.kernel.org/lkml/aNv53UmFGDBL0z3O@e133380.arm.com/ :
> 	The reason why I think that this convention may be needed is that we
> 	never told (old) userspace what it was supposed to do with schemata 
> 	entries that it does not recognise.
>  
>>>>   * Current properties that I think we might want are:
>>>>
>>>> 	info/
>>>> 	 └─ SOME_RESOURCE/
>>>> 	     └─ resource_schemata/
>>>> 	         ├─ SOME_SCHEMA/
>>>> 	         ┆   ├─ type
>>>> 	             ├─ min
>>>> 	             ├─ max
>>>> 	             ├─ tolerance
>>>> 	             ├─ resolution
>>>> 	             ├─ scale
>>>> 	             └─ unit
>>>>
>>>>     (I've tweaked the properties a bit since previous postings.
>>>>     "type" replaces "map"; "scale" is now the unit multiplier;
>>>>     "resolution" is now a scaling divisor -- details below.)
>>>>
>>>>     I assume that we expose the properties in individual files, but we
>>>>     could also combine them into a single description file per schema,
>>>>     per resource or (possibly) a single global file.
>>>>     (I don't have a strong view on the best option.)
>>>>
>>>>
>>>>     Either way, the following set of properties may be a reasonable
>>>>     place to start:
>>>>
>>>>
>>>>     type: the schema type, followed by optional flag specifiers:
>>>>
>>>>       - "scalar": a single-valued numeric control
>>>>
>>>>         A mandatory flag indicates how the control value written to
>>>>         the schemata file is converted to an amount of resource for
>>>>         hardware regulation.
>>>>
>>>> 	The flag "linear" indicates a linear mapping.
>>>>
>>>> 	In this case, the amount of resource E that is actually
>>>> 	allocated is derived from the control value C written to the
>>>> 	schemata file as follows:
>>>>
>>>>     	E = C * scale * unit / resolution
>>>>
>>>> 	Other flags values could be defined later, if we encounter
>>>> 	hardware with non-linear controls.
>>>>
>>>>       - "bitmap": a bitmap control
>>>>
>>>>         The optional flag "sparse" is present if the control accepts
>>>>         sparse bitmaps.
>>>>
>>>> 	In this case, E = bitmap_weight(C) * scale * unit / resolution.
>>>>
>>>> 	As before, each bit controls access to a specific chunk of
>>>> 	resource in the hardware, such as a group of cache lines.  All
>>>> 	chunks are equally sized.
>>>>
>>>> 	(Different CTRL_MON groups may still contend within the
>>>> 	allocation E, when they have bits in common between their
>>>> 	bitmaps.)
>>>
>>> Would it not be simpler to have the files/properties depend on the
>>> schema type? It almost seems as though some of the properties are forced
>>> to have some meaning for bitmap when they do not seem to be needed. Instead,
>>> for a bitmap type there can be bitmap specific properties like, for example,
>>> bit_usage. This may also create more flexibility when there is a future
>>> mapping function needed that depends on some new property?
>>>
>>> Reinette
>>
>> Sure, there is no reason why the set of properties has to be identical
>> for different schema types.
>>
>> It turned out that a single set of properties fitted better than I
>> expected, so I presented things that way to see what people thought
>> about it.
>>
>> For bitmaps, there isn't a strong need to change the set of properties
>> already available in the top-level info/ directories.  These can be
>> adopted into the new info under resource_schemata/, but I might be
>> tempted to rename them to remove "cbm" string so that the names are
>> applicable to all bitmap- style resources.  I might also rename the
>> min_cbm_bits property if we can think of a more intuitive name -- it's
>> not obvious how this should apply to sparse bitmaps.
> 
> yes, this is a good time to rename things.
> 
>>
>>
>> Thinking about bit_usage, is that really per-schema?
> 
> Good point. This is per resource.
> 
> This may create complexity if multiple controls are available for a resource. For
> example, if there is a MB resource with both a proportional schema and a max then
> it sounds like it may be possible to program the proportional schema with 100% while
> setting the max to 50%. On the hardware side these values may be legal, albeit with
> unpredictable performance, but it will be difficult for resctrl to visualize the
> "bit_usage" of such an allocation.
> 
>>
>> If L3CODE and L3DATA are really allocating the same underlying
>> resource, I wonder whether their bit_usage should be combined,
>> somehow.
> 
> Related to earlier comment this is done internally by resctrl but not exposed to
> user space. I earlier mentioned how exclusive groups take this into account, there
> is also the bitmasks used when creating new resource groups. You will, for example,
> find in __init_one_rdt_domain() that their bit usage is combined as below:
> 
> 		if (resctrl_arch_get_cdp_enabled(r->rid))               
> 			peer_ctl = resctrl_arch_get_config(r, d, i, peer_type);  
> 		else                                                    
> 			peer_ctl = 0;                                   
> 		ctrl_val = resctrl_arch_get_config(r, d, i, s->conf_type);       
> 		used_b |= ctrl_val | peer_ctl;                     
> 
>>
>> This might be one for later, though.
>>
>> It doesn't look necessary to adopt all existing properties into the
>> extended schema description immediately -- if there are some that don't
>> quite fit, we could adopt them later on without breaking backwards
>> compatibilty.
> 
> It is not obvious to me that it will be simple to add a property to an
> existing schema type. We may be forced to create new schema type when needing to
> do so.
> 
> I also think there may be more schema types that will eventually need to be
> supported, for example MPAM's priority partitioning?
> 
> Reinette


