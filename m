Return-Path: <linux-kernel+bounces-782749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B2B324BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FC61D28055
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1F27A90A;
	Fri, 22 Aug 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlN7o3k2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2831A9FA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899561; cv=fail; b=hnjgpO0iBuLR3aCMSQdTgkyTQrrB2F9qswK8buniGTpJiYx+NwVse8jtHZrrHKZtgqS0j3BJRWxBXhgvVXuIsDf5QWXCbbmOnbHvsbOLq/VHouk3EdfQCabTj7JCnfapDhytCYXV3idfCNgG+6dBdCtxLL56ATwx12Tp787ezqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899561; c=relaxed/simple;
	bh=wdb+A61DyZvylF0KXb0Jg7ELC44+YLjHrlCOk4oRedM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=awiOkQ1yqqwCmSfJ9Y0c4biPJlU9mLVGZMsrDMn/jZ/DS2vw7cGA/2XwQZ77wvI2HQVBEBlt2Pd0InAvWX2WKeGtGxaQEreYbAKGwSOsnO2GWvnY1d6N4hnbQeWtyq1ofIufTaWvaKxvO1ZDszZUN2TFH/WPTDS958LNUxfNvfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlN7o3k2; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755899560; x=1787435560;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wdb+A61DyZvylF0KXb0Jg7ELC44+YLjHrlCOk4oRedM=;
  b=FlN7o3k2Y9x6K1shAgJ0pnwZJMy1RfarPPux5blsRTR1y55YfU1D0MwG
   32HMf66se53Nl3W5ccxrL5FwPogBreYqmcdN57Oy51ELlRs4rVzNzQEgM
   NJwVcZ/C7PluoO7ko56yEKL/pAAvJJnlLnXn1OlsHKZTpoPQybB1RDEqd
   mHfRMc1KHgc3Pj9o4g/e27CZmUj8TJhOOaq8UHK7mS9usyJD+nbRmO1Gr
   FUX6P1c8URg/rk/gdEiD4sb85gC14sCFdGfVHQjR9t49adR3ra2Grk+j2
   KPsuY/ZKAc/vYZAn7D16idg0JZJ3qABk7E5pBR4vKNT+ose2QAyLUSGXX
   Q==;
X-CSE-ConnectionGUID: VSOJXqWyR+W6E8VAAHIbqA==
X-CSE-MsgGUID: 6synbg4vQpaC8RUBtz1BjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="62044632"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62044632"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 14:52:39 -0700
X-CSE-ConnectionGUID: Qq+KMK8YSm+K+6l9LYY6eQ==
X-CSE-MsgGUID: +vaQe3kjQpeCEA2/P2lXVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168707583"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 14:52:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 14:52:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 14:52:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.53)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 14:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYikzVsB1XhLK+E7oxbGh+MrmaYZK11HaYKUOGNO8B0lpCDzPyaAdd15Nmdj9SkbeToM7bkElw/k5w1C/YgPwfgmEXbokKGoPRh+VvUmn0mRgHJGh3ZZlZT+7POi521af5Ak7Twb/o+b7XDRM7A5jtZeQAUDj5LNcV6QhkVuO80xXKHVCkX1lUVeSzeEqMTPigYAADXCMd2HWvwnv6orTbRtXzfqpw46QGLdoyFNXKhHN8IO7M+GgTOLWwgOo0Tpa2YPSeY4p2ngGopLCdG+FOZq0l0KVyYc/cqd76aMMgycme95bWDDoFI06SzJ6dHwtnoBMILra+gYQZlmR21kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7Fue/1DrV1zzDvEPqAbHXOT6039YSUZ5RTi3T1Gxyc=;
 b=pOcAVO2dBPgOVYsXe2ocfvLPX2HRaELvEXzurjarYWHQgJhxRD1IF/M0YrEx1K5OZvonDlQlag5ksQQA2jYcxFo4mrDhmzavAaPt884kxuZojyf1TVudXDiJ8MSsV3vFh5i0lPty1cLz/NzD4Wrlj2KhV86L8NR0T8Hyx0BpgLqZ5Yk8GdzIG4yXY4LDPR2XKGPNzL89Cxxa2ZLqmXU24EvjT2omFOiiIRPLNTMYB431Xg/ckdcdUeZL2nANGdQ5CXp4oZbIDNkWbFPo0ALcfAs4TvHLTnAuZyWPASDcdb621dNYZzKmsAOoZkyl8H2+iuGFrKWMFddFUo/dV+Arxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DM3PPF529E923C8.namprd11.prod.outlook.com (2603:10b6:f:fc00::f22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 21:52:35 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 21:52:35 +0000
Message-ID: <791d0ed9-27ab-48bb-bacc-8332aba7398b@intel.com>
Date: Fri, 22 Aug 2025 14:52:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Andrew Cooper
	<andrew.cooper3@citrix.com>, <linux-kernel@vger.kernel.org>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
 <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
 <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>
 <20250822182447.GHaKi176wVuSsNMmi4@fat_crate.local>
 <4d5a17d5-f26a-4682-ab7b-5a3b05b5af3a@intel.com>
 <20250822190622.GIaKi_rpJxdNGsbDlf@fat_crate.local>
 <2d677e21-a5a7-4b68-b11c-e73473bab0a6@intel.com>
 <20250822192751.GJaKjEtw5Rf4f0K3DE@fat_crate.local>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250822192751.GJaKjEtw5Rf4f0K3DE@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::35) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DM3PPF529E923C8:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a0b1ef-075f-4bcc-f048-08dde1c63437
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVh4TTBGUlBIZ2dIRUtISno2czUraG5ZM0JzdVcvdzhpTytEeUVZUTgzYkNj?=
 =?utf-8?B?QXpTeHQ1UWZEZDVFYnRQcUVudWJGVGFoV29UdmU5N3ZjaUxYTVM0RHZuMDdw?=
 =?utf-8?B?aGpKd3NTL0V2TzZnZGRGd0hRZDdHUXlod1kvZ2hjbjRBbVBsMjk2cjdaT0dW?=
 =?utf-8?B?VnFOQks1Z0ZlamhzTWpaM3p0c3FFa3pYQmZ0QU1SUXcydytlYlRUd2ltT3Qw?=
 =?utf-8?B?UmdXQWlNcWowdlZDK1hYclk4bkpqelNUS2pKMWwwdUNNdWJtMDZ5YktnbGpr?=
 =?utf-8?B?ZkVmY1pKKzFxMGtRM0hUdW5QWTRzQlEwNmpRRUhGbzZqeUk0K0xDSlcxc2sr?=
 =?utf-8?B?NDBkUXk4TEdabE9mVkxXSE8yWFhXekE4NVhFeHVFSUJ1bTFpVVJuTzBKUUVH?=
 =?utf-8?B?YzJnVG50WlZzMzhBREllanVKMUxGRGNNNkUyZTR2YW5vMFdqQWRhbm9xTXRq?=
 =?utf-8?B?Q0NwVXJod0wzT3VyK2l5WXdqeGlWRFFldG53a3o0WndWdjhsRlE0WTY3cUFj?=
 =?utf-8?B?c05odGNVNWdIR1E0YnBBSHRiRit2bmxOY0VzSTZxUUtlZzB4MENHYU5oUk80?=
 =?utf-8?B?QkxieWdhZmJrSVhUcGV1ZGRYSllqS24yc1N5bDdaVHNJanZPZ1NmOS8vOFBu?=
 =?utf-8?B?NU9iazViVHp3Q2N4VVNvUHhpa1VWMWYxclNuamVXMU8vMExMRFdha3lESCs5?=
 =?utf-8?B?am5QdGpaMytqcWJaN2c1MDhSbk9tR2drSTA1TTNCcUcwdDkwaDRmRFQxY21t?=
 =?utf-8?B?WTdFcjZLa0FhaysrVkcrc3JTWkh2S3haa0NTcHZyME9aNUhkVGM3ZWExUjc3?=
 =?utf-8?B?QTVsQTZZNDYwZmxhdTlVeXNiRWM3YTlDb2F2MzQrVzB2WmpPREk3OXNaQkg1?=
 =?utf-8?B?emR4WWFzdy9PcXh3eTEycVlKcXROWkRENkY5dFdXd1VvWWtCbWNwaE91Snhm?=
 =?utf-8?B?WlI2UDV1eWdvNnNPQlpVQW1RbkpVNUlZaUJHQmNmRmRwNkkyM1NwcVArQ1R6?=
 =?utf-8?B?S3R6cm5PYm5NQStRTlVaK0hCNFJEUFFvM2Nqb1FYM3VoOUtYNWJjQnRMeDk2?=
 =?utf-8?B?QWc0VnBvUkZmT3dOSVh4WVEyZ2pvVmlzTWM4blo3ZzkxN1lidngvL1BPKzgw?=
 =?utf-8?B?bnlVNk1YSWZieStuQml6UXo4Q25TSkRZV0pWRWRwZFJzSlgwOHBlY2hOeWxa?=
 =?utf-8?B?dFY3MEtONU9XYjZkK1BRc3ZQbnAwUHBYblBBTFVpRDZ1OWMwRkRXck1qdWda?=
 =?utf-8?B?TlppSFBJTUE4VzEvV3JmbHRPRHA3Z3lRUVVJb243bm5BTWxabi90cXUyRm9z?=
 =?utf-8?B?dGIxMndrd1dIY29NZ1pqdHlXNENYYml3T0JHVm9JK0l4UlpSUXBZM3EwRXRN?=
 =?utf-8?B?bGl0RUtnd0srKytQRTc2REsvNWFlWjVrMEM3Y1BZMEJublBFeExqQ0FyUWRB?=
 =?utf-8?B?L0tqKzZrV25VRHJGMU1xbnhxZ1Erb3dhOTZsc05WVHNmVmZOckVReEdxVnV4?=
 =?utf-8?B?eGhOVnBsYklpeUx1VFVmRTBYRGFuSTlCZTRaRVdXWjNZMGhRWUIxcTBtYTdX?=
 =?utf-8?B?QXF6N0ZaWHlLUXZIWjdHQW5nTG9oY0k2V2xvazgydUpBQjdwMVA3K0tUR2dj?=
 =?utf-8?B?NldsdzBFaTU3QWI0Z1N0dDBLVlN3U2Ura2dtdXoxRG9xOWtNZ3BON1c2cnc4?=
 =?utf-8?B?aWlEeld5bkh3ZkxyQWdWTFZKSHFURTR5MzZDWUdVTFdVZkFkOSs5TnFLeUVv?=
 =?utf-8?B?ZmN5aHZMZzJDVThONE93eGQvdDFJVXpyc0EvQTBGZFZMRWpFWEpGSDQ4dzU3?=
 =?utf-8?B?S1grRWJuZk9JcmdFQkQ0aVUzYjd3eW5zK2Z0cHBUMENMYmNWY3JrM0dXbVhu?=
 =?utf-8?B?V0pUSUpmVmNzMkY4K1g5QVpWUmxmekF2T1BObzZYNitZK0M3b3FOcDgzSlpP?=
 =?utf-8?Q?VWQ07WeM+WU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTV5VXY2K3F6dnptYXpuRS92bmJFSEhuVWI1YUdxTzRFdkZKVVNoUmRMZklX?=
 =?utf-8?B?TXZyMlIxYTVIRkQvenMyVE9PMHJxeVlFNDAvazJOTGQwOWNZeG9IR1U0WHZ5?=
 =?utf-8?B?ZTZWQlB2UWJjc1FWWmlmUFJZbEhuSnZrOXRLMjVicnQ2UHYxZFhTZlJUVm9q?=
 =?utf-8?B?NWZlZ0cyck5NVFNGeDVEcWd6ZDQxWGtWT0FlblovL29lQVpzWEVvMk4yZnFW?=
 =?utf-8?B?YXNmNFJudkFhQVJBRUQ1M29qRlM3Q3l3MFVwZWdDRzVISi9BZUtrT2ZnYkta?=
 =?utf-8?B?OXRaVmZYYWc2MG56VU1qekF6SktWK2tlTnduclpmeUYrT2EwZVl1cmVQVnda?=
 =?utf-8?B?b2QyT2YxVEE5M3lhUFBYOUdDM3JzczdRd01ocXpueUlFd3FTUGRnUUdnYUht?=
 =?utf-8?B?enA4T0MzTmhEREVGQmZVUXBUM3JXRWRkWWFDQzNENTZmbzdDc3F6MkxUeHBa?=
 =?utf-8?B?U3c4R2JEdTAydTcrdEdGcmI4RlkvMGMxanVTclZxMkFweFhpbXVVT1h6UFlN?=
 =?utf-8?B?Y0Rnb2ZGZjIvUzIrS0dLZG5ZYmhuNnZNd2hCc0RhSWpTOFpEVCtVaGFBa2Ez?=
 =?utf-8?B?TVN4bFlTTEx2alNPODV5emd6bFF6Y0xnc1lzbm1yYTB2THFEbU5HWDZSRlp1?=
 =?utf-8?B?ZElKRUMvc0hpemxNVE5KOVlJN3hvbVU1ZkNXMkszVDI3SkVKRWk4eG10K1Ns?=
 =?utf-8?B?aWIrSUxPL1d4RU91eFBCRHVKWU1sLzJLbWtZREhDUXlnbzZXK0ZOZ3hsYk1p?=
 =?utf-8?B?ZGdPYkVON0p0eTE4WkxmQzFjRk5tZmUwUWJWR0kyc2lya0NjTnJFdXlmTHFs?=
 =?utf-8?B?cEJ1TUVVZmt5VG8vZ3lVSlN0ZTk2SldLM3EyL1Q4TEgxYXJ0NGVNNVlRZzA1?=
 =?utf-8?B?VUpSSDBMZGlSZnF2bzZUaXVwUG5GSDZwL0Y1M0ZNUTk2Z3BtajQ5MDdiQ2ZK?=
 =?utf-8?B?OE54R2ZOZXYwMEdKN2JLNVY2SXVRVWM3V3RySlhWT0tMRjVOcnE4eEtNY282?=
 =?utf-8?B?cWJ5bUUrdkFxV3NzZXVUcTFYamREVVpOWjd3dmp4aThUZFZZUFZhVzN4SnRN?=
 =?utf-8?B?b3ZZbDl2RzJSQnJSRkVOb295Z25YY3laSHhDa2FSYVE2NG9EOXFReFFOZWxm?=
 =?utf-8?B?VlV6UlhiYndhQ1ZPL0I1eTBzbWdCS2JiRW1lYzhXblprVC9JUEdiazNTYlpY?=
 =?utf-8?B?TUVxbFczcEtvcnhvc3VuRWp0cTVkdk5Cd1hhbGtUWUxNTGw5RXRPaFUvRXFh?=
 =?utf-8?B?STl2ZHN3VDVnRXc3Q0NpQkhqSVZ2YnluQXlJMUpnbC93SVBtOGdhOEVmajZm?=
 =?utf-8?B?Tm9YeG9Wc0xyTjJra2tQVUhTdWF1b0ZmdWRuVVBYbW44TUtyMEhKQlFlZFor?=
 =?utf-8?B?SURVMUFtMjRoYVN6MldQQzNRNUNDTTZ0U2E2ekxkM1NBWUpzQVd1UGtTOTJE?=
 =?utf-8?B?NkovUzZBRi8yRjZYaGI3YlZsOFJ3eUUvNEs2RFhZM25sYThUT0paZytNSE1v?=
 =?utf-8?B?Zng0UUx4b0N0ODBmSWZlZ2ErVlpsaFQyaU9RZkhQdkhHSm1pTEVqY2Y4YTRJ?=
 =?utf-8?B?MlIrRGFLcUF4YUYwUWVnY2xqS1I0bDBGOXVnaWVoWENUcmlScDNxZkRDOVhT?=
 =?utf-8?B?UGt3dHhoYU4xU0o1VHZsUi9uRjV2U2lFdWhFVWxrelhaeDZYRThqMS9yK2pU?=
 =?utf-8?B?Q2xGMXUwZXZ3amxsZmZ2UTUvNVp1a2ZxdnpJTndPNnFuZHI3YnVLOEs2SUhr?=
 =?utf-8?B?a0pnSGZsU3lNSXFRbnJ6b0ozNnhNVkJlRmR5Z29uSUFBU1N6U3RRVlhCalFJ?=
 =?utf-8?B?c3UreE5RL3Y3Z1l4Z2tzanRWVytTV2RlbTJzYndISlQxZlFYaXJxTFJET2Yv?=
 =?utf-8?B?NjlRRlJkVnBTODJIR1drNGc2SFRFT1AxUjNRdUFjVkhFaFlCNGFHV0xsVEVn?=
 =?utf-8?B?YnRCamEwUVk4UllUdlZQNXVPK2QwQkpuaGk4M1hQYVp6YkNGcUdOR0JWQ0o2?=
 =?utf-8?B?d21UNXFJMG9HZFYrMzRIVkszRFpzbW5EaGZnZkdZRmlweDEzQ1pjVWhLVzdH?=
 =?utf-8?B?eHEzVGZESWdWTWl6V3RoeHpQc1laSnZPY3NPeGFsYlFFL1NlSkN6QWNJZFJX?=
 =?utf-8?Q?HbyGEA0Y0JM3pFJ+GhWGWZCX/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a0b1ef-075f-4bcc-f048-08dde1c63437
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 21:52:35.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1akfL50fBs0oqKbV4GlmtsvsZzkAe7/PpK1tBiExDpF2Qb7abcL4ANbgNVu9Ktv7qdf9Qh2FGOuca9+2A+EAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF529E923C8
X-OriginatorOrg: intel.com

On 8/22/2025 12:27 PM, Borislav Petkov wrote:
> On Fri, Aug 22, 2025 at 12:16:59PM -0700, Dave Hansen wrote:
>> Ahh, gotcha. Should we slap something like this in the script?
>>
>> 	This script is intended to be run in response to releases of the
>> 	official Intel microcode github repository[link]. Typically,
>> 	someone at Intel would see a new release, run this script,
>> 	refresh the intel-ucode-defs.h file and send a patch upstream to
>> 	update the mainline and stable versions.
> 
> Yap, thanks!
> 

Thanks! Here is the updated help description in the script:

DESCRIPTION = f"""
For Intel CPUs, update the microcode revisions that determine
X86_BUG_OLD_MICROCODE.

This script is intended to be run in response to releases of the
official Intel microcode GitHub repository:
https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git

It takes the Intel microcode files as input and uses iucode-tool to
extract the revision information. It prints the output in the format
expected by intel-ucode-defs.h.

Usage:
    ./{script} /path/to/microcode/files > /path/to/intel-ucode-defs.h

Typically, someone at Intel would see a new release, run this script,
refresh the intel-ucode-defs.h file, and send a patch upstream to update
the mainline and stable versions.
"""

If there are no other comments, I'll send out a revised version with an
updated commit message early next week.


