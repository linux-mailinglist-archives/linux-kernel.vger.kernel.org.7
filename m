Return-Path: <linux-kernel+bounces-782553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84299B321F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DFB62800D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417362BD022;
	Fri, 22 Aug 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sh95fXen"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6011DFCE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885800; cv=fail; b=MAPBXw9L50cwX9F/UoXbxoVEMjBUPsOibVfSdYcZJykm06raKDG00J7PbVfEVoI3XA2dVB9gg54iz+KoGjTIw2R3fJgOmFod45/Z11Dzd3HpAhWDjdfebTsezgmBeYmJEmz1wJtULKQklSNu6oRHjh9CY9dlDbNUb75QGvFL7qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885800; c=relaxed/simple;
	bh=Enh+KbJVoQIkMSja0Tw9gPi/gXTPUFEispIXKMMA/uY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8HPaAAV8QMSNkWS/Q5Bvp3579QxhC6plwPtzK180xAjyfF5R8g7YNEcaFviaVDZJjF8Mvsc1iIQG2Y1YQi0uYKx1q2DSbeLq+rtIltBQ9PZnhsiDU1QCKidCvYakKZveTo34Wa2MQZlXxtXzKd0WAmXEqSGtwvyCvlfubaIXbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sh95fXen; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755885799; x=1787421799;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Enh+KbJVoQIkMSja0Tw9gPi/gXTPUFEispIXKMMA/uY=;
  b=Sh95fXeneX0y8I4MiM8BX4XhY4N2pxghTU8G4i4ZHMOTicpKcuv/kDyR
   ZN9W5GvZf1U5EuOzcoDyykV7aD6P7+P/gR0EsI4CmolIdqQP4kSQ44EqS
   Kj6480ksn1yIxnQfCwYu0jCqT5NvJXHQPY6F2YTfJbJ8f2Ll8aCJiAE3b
   mYRCWsTeO+GVntVDX3up8tjf4biX4ySAX8hzLDrE9mLzkW6RmZSUg4Kaa
   0YHTQ0k9PR/wTVtWkM18MVH4jKgTHzoNwBkYuOfTSRBBK14ZL1oxxGqs2
   nq8IX4Bt9vzACo7/quJrF0rdzcpEmMM+nGOINsQUQi/xeDAtynRadtuTy
   w==;
X-CSE-ConnectionGUID: ZaEjc0uKTUujhZkpX7g6qg==
X-CSE-MsgGUID: 5+jJTLpJRS+PNncags/QRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58267951"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58267951"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 11:03:17 -0700
X-CSE-ConnectionGUID: /U0wCjXqTaixPvPH3KcYRQ==
X-CSE-MsgGUID: 0ooWS626TbW3xbVXT+nOqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168273543"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 11:03:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 11:03:16 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 22 Aug 2025 11:03:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.72)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 22 Aug 2025 11:03:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmsE/Qcz9bm1gQQ+6dxpP29WERWgulEiYb1SURdgJQy3EC9YnLSXkGyCN+dM0iZxi072AKj0LKNuf4MjITrNG4heEtM24qW877W2hqYn8lAAyn+lvCKnLQD8lCHDGSheN5j3GuknTceZdwukkXsIWPs9n0SJyxdACSEIU1bTGpWwIq2vJjmiuLra3M5IHoXjCPdVlMihmk9C8hsM3jd6pCTAoI00794RE7DH87tqHNXAFsZZFvXnWJKcJTjcN8MNoJm5x0Ku4HLXLwyg9kDrBd2OncB02hfT/AcgntGGhVx94Kza4Ger3X4CMNHPZZZA3mrKufM1YRj8puYEDg6Ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrlqZVjCMmz8M+TV//LfJP93LizNEW10OeF2SiGuph4=;
 b=KI7bwtMmE6VHOiz76xSEjt+wELurxFzCYA7IKbUbiUNY8F9tT+vO5Q/oByn9VDndW+rvY9MO0gqgTDzi377MfQ5CmkxnoKSy3bYENU5TacZGeXsQBEuSCYjjFiZLfeuq+QFxsZZabhKFy3mE+pSWCGhvXr1IdVVWseXvk6GUeQEZXbaPnVEXHgP8mCodWndyJOKhhrrR9OsnQjGHql49wjY/8NIWDqhqCVMEtgHfE/u7kjV75abRkOH+EDeY+4y49io5cv2VcEwHi1Hod94MQEdxMLUd8rPdvP1GrXwYismMdFdj0Ux1EqvTIg5i8r032HwyVszOl9X2Z77clAeoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7997.namprd11.prod.outlook.com (2603:10b6:8:125::14)
 by DS7PR11MB8828.namprd11.prod.outlook.com (2603:10b6:8:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Fri, 22 Aug
 2025 18:03:13 +0000
Received: from DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c]) by DS0PR11MB7997.namprd11.prod.outlook.com
 ([fe80::9105:2b7c:b256:7a6c%6]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:03:12 +0000
Message-ID: <aaed72a9-8dc8-4744-96ae-ac3db9fb4d01@intel.com>
Date: Fri, 22 Aug 2025 11:03:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/x86/intel: Add a script to update the minimum
 ucode revisions
To: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter
 Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, "Dave
 Hansen" <dave.hansen@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, <linux-kernel@vger.kernel.org>
References: <20250822004422.2908427-1-sohil.mehta@intel.com>
 <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250822100949.GAaKhB7ZlYxjpfcIit@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0056.namprd02.prod.outlook.com
 (2603:10b6:a03:54::33) To DS0PR11MB7997.namprd11.prod.outlook.com
 (2603:10b6:8:125::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7997:EE_|DS7PR11MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c6b52cd-e19e-4cc0-b533-08dde1a628fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2xUSjYveHZhV2NHNC9CMGsraTh6WmdQNnQybWpTYit4a0ZuT0NheE8wMGlx?=
 =?utf-8?B?MzRYelN3UUNaZm56aEx6NW1kMDEzN2FjbWhycitaeDVOUnB2blBWTC80b2I1?=
 =?utf-8?B?dFVYNnB6SVU5OG9FTUQvZTdwOFY3UzlNcTJxbnRFRUVqMGN1RWNGVDJDa0lV?=
 =?utf-8?B?U280ZlBDekJKRHdSMUhvLzU0NDBGUGRTTElWRytURUQ2bjVNSWdsQmYxMW1z?=
 =?utf-8?B?TlloKzg4Ni83Njc3YWk1b2dScERxU2hRMEl6dVNoS3F2NFIxTFEyQiszZU5u?=
 =?utf-8?B?WUZ4Rk1WOHpwOGhoMlMxRms0b2hsR0tlcWFyOWJsM2VCOFpWYVpERll1SU1q?=
 =?utf-8?B?VnNSVnlLK2ZseG90WTBBcXI5bUtoTGwyMHdFRUttVy9nOHYrdEZQTmV3bEVY?=
 =?utf-8?B?RGNvb21UYjRyc3hrdDh4SVZSWCtDNzFxVFBqR1dyZVV6RFk4YWpHUEFsZ3RI?=
 =?utf-8?B?emQ2blNaSk5CTTVSYmx2b2R1TkF6dEZuK2dmdklHSEhjOVRObHdHWE9admRt?=
 =?utf-8?B?Y2ZtVFNnWnRFZ3hXY0tpYmpkVFFicEVEMGhLOTlIM2JTTy9Udk5xWURSMzla?=
 =?utf-8?B?WFpYNHByVXZjM1R1a0loN0VNNUpLVVR0VU5GWWZXVmY5ZG5wNE0xRkhEMnBh?=
 =?utf-8?B?bHR2a01TS25UaVlxUm10cm9EMDJJVkwydlNBZFhrOTVJKzdBbWRncytYYzlK?=
 =?utf-8?B?bjV5UUVBYWsyZnNkNFBwNms4LzFSQlp5ZngySWFXWkJES2pPL2NyeUp1Q2I1?=
 =?utf-8?B?ckdWaEZDQXJtaUdQUkFmNWRTZUM5THlSMzV6Q3lEbWRQUldKcldRNlB2TzRt?=
 =?utf-8?B?N2VRVUFKbmpsTVBrNHVtMXF3N0Npd24vYU5lMHVQTkQzd01BTFhyK3RCc2Z0?=
 =?utf-8?B?REVGbFhranQ2ZzBrNjBROW10K1FrRmhWYTBWWG5vNmtyTWxKV1VrMGNMUEFl?=
 =?utf-8?B?VnRoMjdWR2RZVG9penlOV052ZkJ6MWtueGtqNnB4YksyNERHV0V0YlpOL1do?=
 =?utf-8?B?NFVKRlJXWEZ4b3BZQ0NKQ0JyUDF0SDRmYkZFQnlyazdOOUw3aVBLNnlzVUlj?=
 =?utf-8?B?Zld5c2FnNW9BcmxLSlZOVW5FYkRBbDh2T09PZFZhMVNHWnJLb1ZwcFBqT1lw?=
 =?utf-8?B?aUc2Q3VaNlZYcVViVldWZjRpMmwyaW1RODZzNFhYK2RsMnJZN05nVkZ5L2JN?=
 =?utf-8?B?eFUvZG1PdVRsd3VsaTdEcmtCcDNsZEhHamthSzQ3cUUwR2hJZnI5dFBDeURU?=
 =?utf-8?B?MWZqOHlsYmdGcHJOYjVKdmRvSktrNHg3bURWVTM4ZU5MelVLUGFDVGpLSEIx?=
 =?utf-8?B?NklmL2psNS9mUThsaE5iV1FCM0ZkLzVaY1pJZERHMzEwa21tSWlCdEhzODN6?=
 =?utf-8?B?aUhsN3IzdjBJUEJtYml2eTFsSWlDSmI2MElHaTRxdnlWNEdWYmo4MUVBTW96?=
 =?utf-8?B?TDJQZTZFN1lDYWJvU0V5a21CSU1GUmVHM3Y3NFhTUmwyTlpXVWdxSVF4V2Fu?=
 =?utf-8?B?NDFDYmlJUEFMZysxMm1SYUlwVytRamVNNUozT0Q5YlFDYUZkTk9oOEdXWGxm?=
 =?utf-8?B?NHdFbGhFaForNnVoYkNURW56eXk3UmozMm10TjdIdzVlT3BrVkZ5bUgzWmFk?=
 =?utf-8?B?U29TRlRwQXJ6elpyVDhtMGpVNmhqdk5oMXorN0ZmMUhRaERzbnlsamVVaVgy?=
 =?utf-8?B?RDAyb0hjNStIMzQ2MXoyLzZMcllvSm9ibFBaVGRTQjF0enQvRW4zMWdCN1dt?=
 =?utf-8?B?b1dCQlJDN3cwbDhrNk5qb083Wm5pV1dteG5DdWwrY0RTL2JSL1I3cE5nTTZP?=
 =?utf-8?B?U2RBWmJPQ2thb2FZOE5kYlhXODdZZ2QrdlNwUXdqOW5LVlpKMjBQdFBlTXEy?=
 =?utf-8?B?VFRCUGNEL052Rjd3VmcwYkpBNDU0UEJSN3ZiS2taUmk3V0F2dFhmNkZXSTk1?=
 =?utf-8?Q?bCdX9T5HKPA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7997.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2UyazNNYm5QbUlYVXlXT3Z2UkJIK2FLdGZ6UlhGTGcreUwrVW9ucHRvQm1G?=
 =?utf-8?B?bkt2UWNYYW5wMExiZTFaRTMzUjFVVWk3SW42WWdOU2NvNzIzK0xGMWtrVGVZ?=
 =?utf-8?B?Y1JsQ0NZV1VpVzlaOHF2NWpmcGxFR1V2dWJJWkw0R3FORHBkWXVKY3crbG9V?=
 =?utf-8?B?QnlVS3dSZGYvV3ZiUFZMQTRsQ3VpQ0RNV0oyRnVqbWRnZThRY3NuNkUweVZJ?=
 =?utf-8?B?eWpUcDZYRStRUVVlZDU2ZUFCNWFrbDR6bUxCQ2xrUDFldjhHNk54TVdMRWkw?=
 =?utf-8?B?VTJ3bEYrUjN5eXhlMFp2eDliM1VBK2VOM1Y4aGl0bnB3dGtGaFpwUk5LeFJG?=
 =?utf-8?B?ditRNG9BZU9mcUxDNjhXTUVib0xNYzdTOXdiSndiZ3BvMDdEWDNpYUxwZk1I?=
 =?utf-8?B?aitZQ0hIcmpGcGpiS0NqUHF1K2VmRDNHNUhLckNsRWRmMlg1T1NoSVZQbGRS?=
 =?utf-8?B?RG5hTTJMaUJLYlVGdXU3b09YNk9lbncyeXRVdm9CcWFWSmNwQ1RZMmtaQzJv?=
 =?utf-8?B?RXdoWGxHQVNnMTYrcGhDRXlETGRhTVBqRmlHYlAwZjBUZFJYL0tFUWFPSUZO?=
 =?utf-8?B?WTJPdjBCbkJQbThtYWx6aXR2a0JKVlZodnBkeXJGZTJVc2d1K2VrTzZBWHZJ?=
 =?utf-8?B?U3oxVUxSaXRodGlOMFNIVjN1NkNlS1plN0tSUkg1d2xSU0I1d3VTQXJaMW1o?=
 =?utf-8?B?NmY4WkpvWElJWkVJR1JBanZ6Tmg3MmVFYVJKTFBCWkI0SXY5NnBUZ2VaVEJO?=
 =?utf-8?B?dm1EVFJST3psM294eVZEVWdIaENyRDlzeXZTTUx4SE1CU2Mzdmg1QjVjOFpj?=
 =?utf-8?B?UkF5d3ZRdU9UWHZDeVRobGxqRmRsN3Y3RTcwRi9KdU5pRlZONzkrbVorTVFa?=
 =?utf-8?B?YkV0OVZxOW1NUTE3eXBvOWphWWZUSTQyNE51dmtCV25RYlM5ZUVLOG1XWWtx?=
 =?utf-8?B?RHBDMlZ5Y2U5ckpFTS9QWHQrN092UVk2YnMrMzQvTytPcU1MUGlkVlJMK3Nz?=
 =?utf-8?B?aE9GcTlvVWlOaS9EclFaRkx6Y3puSWw2bXhyV1Z5U05FMjlHYTRMd2xRSDd6?=
 =?utf-8?B?ZjVBM3h5cTg2ZWY2SDhxbGRJanRVUWhMb0hsbFh3WlVDdTAvWXBtV1pvWFcy?=
 =?utf-8?B?UmVzaTJDWVBEMWh2MnJvazN4RUcybWpvSDJ5Y2YxNWZtVmRFcGdzOTNWajNQ?=
 =?utf-8?B?bVI5Ly9iUWxnNVh5aWQwaW1hT1ViRHN2V0tnczUrQlZXc0dvZUdFcG1PZ241?=
 =?utf-8?B?Qk9yVVlpOVc2MDJHZE52QXhHWjVoUXkyUGJBa2xVbkkwYWVDOXJXNGx5Y3hp?=
 =?utf-8?B?WGdUUUtyT0o2K2xKVnNqRTlqcTJJRkJRUitKS0s2M0IrVThqeVN0cTluUHUx?=
 =?utf-8?B?cUx2RHVyQ285dTdPWU5rUVI3alRpSHlVcEZ1cit1RVp3elJTRmdxT2lZZlov?=
 =?utf-8?B?YStudWczZi81QXF0STdDMVhtL3BRSXJ6eEtTUFRnYkM4SGVyRkhqSTIraGwv?=
 =?utf-8?B?V3FiZ0VWYTRVbDJTazZRVFc3dytjbW9jQVJtMXZiY0F6aW9kc2ZORldzVXd6?=
 =?utf-8?B?L2c5aVdHNWw3eWlOOC9Idkk3VzI4RDAwK283UUVDRGRPZ0Q5NjB5Sm9EYjRq?=
 =?utf-8?B?NHA4aXZJbjdUUmJ0TnhFelROQ3IwU3J0MUFjUk84TE16YjUvNnA2b3liY09J?=
 =?utf-8?B?WHdXcklxYlBUWjJMZUpwa3k2bkFzVFQvMVpxQ1RHaWRDTFpsMG90K3ArUm1Y?=
 =?utf-8?B?amVFdWRNS2RialR4NUVjcGNlYVJsWWxFbUw4OFhCcVdLMWNhNTFGelhYbytv?=
 =?utf-8?B?UUhtVnZyVWlNb3pGUFQwakN2TlBFQnRNRkUzWXk4a1BYaEc0ZTBEd2JYY1lq?=
 =?utf-8?B?YTBUb2tDQjNzK0NJYWJBTkk2NEJxNkx6MFhZdnpKNW85WForSVFWWi9DekNt?=
 =?utf-8?B?ZGN6NFVyei9qVDAxTVE1L2IveEhta3J3YkhBZ3BqcitCWWx0WWhGL3RiTlA0?=
 =?utf-8?B?NFdPbk4vY2Z3aWRWWmk4V2hmdk15ZUl2S2lOd3lRN2Rvb05MTjcxdmgzajlo?=
 =?utf-8?B?TjY2Y0VCU2tIZHIrR0owTjFVV2VEcEcxemQwMzZyVVhrVDY5UHI4QjVSdHYr?=
 =?utf-8?Q?pPG005Cw++WB9w6aUdzdFNNKk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6b52cd-e19e-4cc0-b533-08dde1a628fb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7997.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:03:12.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5HP+A0Npld7DDZaxnlfupKTpDqEwdsJ9ZiddRLpecJ63f9mY5IsDmDGjApxbYouvfOFaZaFLYWHeaJ+P8p6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8828
X-OriginatorOrg: intel.com

On 8/22/2025 3:09 AM, Borislav Petkov wrote:

> What I don't see in this commit message is the "why". Why should
> this be in the kernel?
> 

Currently, we have a static list of microcode revisions that determine
old_microcode. So, it needs to be periodically updated as and when new
microcode releases are made. Also, some folks might want to have a
custom enforcement of the minimum microcode revisions (be it stricter or
relaxed).

The script makes it easier to update intel-ucode-defs.h by generating
output in the specific format it needs. Having this live in the kernel
makes it easier to find whenever needed and also be in sync with the
header format if it ever changes.

If you agree, I can update the commit message to include the why.

