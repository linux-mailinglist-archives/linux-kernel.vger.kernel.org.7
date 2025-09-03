Return-Path: <linux-kernel+bounces-797637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57D3B412CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 05:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB8317E8CB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 03:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35812C2AA5;
	Wed,  3 Sep 2025 03:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRHI9wj6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A730265631;
	Wed,  3 Sep 2025 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756869127; cv=fail; b=QY/3nJ9HVPwOL4D+O0RBVVqXeZ6upqI/xCImcrcvq10H0TnUZ3D0Dd2x4dTFzPOyHZRct7o4dSzj8hyqi/vxZHSbWTzsriNJvo5xguNpSYya1XLnqlhbL1MQDs0qb3tqCOBPrUqm5bkOH42qLe8qBvP/3ltJWIYVi8xnSWuAZIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756869127; c=relaxed/simple;
	bh=6c6CH+myavRBGCz8J+ctG38Ni/7jG80Qkg4Nle7QIFk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lgI3DsyBMezoqze0WWr4gsk4MepH2I4aTE89OLk9GD9pAPJhl+noD9kjTJvg4sCPJa0MhsaMUUn2pd5nDfE/CtmvGxk6xd3uYZUgbrmG40HhtHfLswHlKuLWHx+hXWduVIdDE3Mk+cNJhH/DCAl1+uGnaoOWkLMrA/cj2nWt8Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRHI9wj6; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756869126; x=1788405126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6c6CH+myavRBGCz8J+ctG38Ni/7jG80Qkg4Nle7QIFk=;
  b=PRHI9wj6uGWDLdlALqFEFi80/VKQASkplxNIpGUIY9CFqQQd1d+x8DT8
   wqtFx1W7d0B4iFRC2kQNt+pGm5rZCRplYdDtkFWrYkzYaNMzN75uZSKCK
   h18/f3StpOdk0d9r+a+2+EJKJJMS5LHcPzZGKd20N9VqhEN14chZrN+0j
   g3T0cXpUFDJdTJQCDbk41ZOLtb9sYlJVPrbihKLi9KmxIAjwSBuAwxTLx
   dbmTeoWcrJWN9uWfuR23213GgoyHH87pfHfR7AJXivfZA9JGTZBfH2LAj
   qnqSyxU0KI4+uvT+g7yWwj44se4HoaAphMqdw+WjGlz0CpUwNLzU/IOY6
   w==;
X-CSE-ConnectionGUID: 7RYYdsh7QuKa/lO8QsNdPQ==
X-CSE-MsgGUID: x0GKOcYCTRSe3aFbVVLoGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69782450"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69782450"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:12:05 -0700
X-CSE-ConnectionGUID: 7sObmmv8R7e2VJVkfUZ9Iw==
X-CSE-MsgGUID: U80I32KWS/SZDYtwugqi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="176749486"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 20:12:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:12:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 20:12:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 20:12:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwTiTrAttkI2RuWyYi7YOFDUSnnVedBtIjsB3bWyTeTFBEH5qfPYEGQ+3cTygdxzuGOUG0y64cehozlK7bIYKrCRKhZ9g3LqS6CjVAA5FT56HW9j/kto3MZ1PxFrIqO7JVdCL+LMp1UrQ2sVxJ1dVlgwho+3FhXDdFNCKt5N9fceYXL7myox0eLL6gDMJ03kPMAnty0JrpRj188fyxezZSqyN5+R2X/qLGUM4Re70wzQTWD+h/rjTSNqZ7UVlJUg6lAf3yeX5a8dKv5D+anVjGkghG1yok3BXyJAsxLqzRGSlAu0UoL8T9Y5nyKDOjkL9hiFJNTdzWv6dWUcl/n7Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WZyLf1LrvVuBJWEQ9sUM1gRMYINoLxiupnGgdgBtjU=;
 b=r5jFRWi7LHfu++0QZBXdf/CGi4xfkvj/azUxROwjFxFIKJmp+ilXUo+OZGf6ntfixM5FXCKY6zGUTAdt+sVBicrfLmm2PNFG/QWthM1dybTemeINfCoeBEJLkT8z4vnL46e4oO5SLHBfo42B0/z50eVMEY+Th8RUXL4QN8C2Blo+LLyWaDB6BgHuiBZ+g6pzhVnTq+M+w26ja8hnOFMAaZA5u+k2bcVNssgoAt+Opa0QPoGvTXnDTNZm0KFdR14vuMc0nGDInSxps3cI9vcgrSQwjVtrsykJAGeEjDLwdBBhqFiuw39BIh84Xr6YoIOgKu2bOEnSVWbntvUZEH+yYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 3 Sep
 2025 03:11:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:11:58 +0000
Message-ID: <29743495-f16f-4844-9121-49b510390cea@intel.com>
Date: Tue, 2 Sep 2025 20:11:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 31/33] fs/resctrl: Introduce the interface to switch
 between monitor modes
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
 <68e9c17c6439f46fb4535cb2b89b380420645db1.1755224735.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <68e9c17c6439f46fb4535cb2b89b380420645db1.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:303:8e::31) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA4PR11MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5b32ee-8ad7-479d-6836-08ddea97a4e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEt4Q1VOOTdnaDY2eXJIclc3a0NMdklpQ3NXZkc2QUZ3WkpLUTIvV283Ymhq?=
 =?utf-8?B?eVBEMC9yemtCL1JWdEhqaTBGQWd1RWIyNVhWT3JJeXB1ZnFORXBJLzFSQ3VP?=
 =?utf-8?B?M3VEWHpDY2prdzRWdlY4S1NMNG0vV3RCQzVCa2Y3bjVOcGdMZkhsV2ZxZGtX?=
 =?utf-8?B?ZzVsUHgwVU1JajNLdytuN2cySThyT01IS2hZNXFXWU1VUnRGWEpodjhrUjJV?=
 =?utf-8?B?T2dSZW9ueTJnWmluYVdvOVhNNktWckEweFRGLzVFeGIxbHRCMldGZmRKQ1hO?=
 =?utf-8?B?Rk81T3N5akNVTlJSa2R5UlRBOGowM0dqbjRQMjBHYlVueGc3ZTRDUmltYlVi?=
 =?utf-8?B?TWo1ZVBYS1JpQ21rd1FZWk54UDh1TnljQUFUNDhWR1lWaUo2dm4rRWttRkk0?=
 =?utf-8?B?MXB3S29EMlRvdXV5Q1VoemtGUXJVUDZpZzg4TTZPdlhPMmNnMkVLN3JqN0Qr?=
 =?utf-8?B?cWRURGRiazNXeVpXT1loejR3d0NESjNhZ3ZXVFF6WkY2MmtXcnd1bjZYVzZS?=
 =?utf-8?B?VTgyelAyKzZUZWZLQkVwYWZpQlk3blZzbXM3UVlHcVNEbGU0cTB1TGlyRlg4?=
 =?utf-8?B?d21wYjgrUTR4c1VTQnluUUZ1dkxudm9MdGx4TURteHlYR0xYZ2h0L1dSYzhY?=
 =?utf-8?B?UEZzMHQyeGR5clRIbWpuN2l4dlU3MEFaRSsrTjd0UDZhd3dnb0ZWTStJZ3Ju?=
 =?utf-8?B?ZVRtT3owZHdqbkplQWNOSDQvSDZQMjZQOVVTbVIxOEV3eHR5bm9JN2R4dU5p?=
 =?utf-8?B?cStQVEpFblB1eDlFUUE3RDVHNVBJWDBSWXBEc3J5Z2RCL1VXcTZhdTc4OCtE?=
 =?utf-8?B?ZUFWZ0VHR2l0THhrYUUwOU1nMkcxVElEbVFOV0tyTmZiSmpuTlNwTlF0MW1h?=
 =?utf-8?B?eTZ2WEdXaCtTTTJCWU42ZVdvazFvdkNVYXZabDZ0K2NXcUwvVG9mazJmeUdp?=
 =?utf-8?B?WWk5QXFUb2FQTytiWGdSSVBSQWVPSERqT3Jsc3FtNGlnQUR3dU9zeWRDZ3Q4?=
 =?utf-8?B?eGt3VzJOa05MbXlrVGsxNTI5cVVyYjRlNVBsZnJxS0E4UEROdkIxZUN1bjBk?=
 =?utf-8?B?Ry9Ea0tqMlBQbUlPeThaU3lKdlA3RWo2NjBiWncvZnVxM1I3cDFxTi9Ld0w0?=
 =?utf-8?B?V3F2UFpQRzA5ZUdvWGlEUllrZ2VwTG5IMGdMbG5WQmRreUd3QkpaZVVNZUUv?=
 =?utf-8?B?QmZMQ3o2WSt3aG5BcjNlTEhjMnNmajV6QjBlcFRwTFB5NGM3RnN4dDhBQW1z?=
 =?utf-8?B?aUdLSDZzdnZwaUtwSUVtMStBMW1MeWJhMm15djdjcklkVUdoOHdZWTZKVWda?=
 =?utf-8?B?Ymt0YlVtalYvZC9oVnprUGtWbU9zZ1pxRzI3bVdKNkZpUU1JTC84djdxS1VU?=
 =?utf-8?B?S1JRWTdiRkhLYUdpOEI5N0pQVnkxdDBXNlpvb3hlNm5jK2Z4ZGtjbFpPYjFX?=
 =?utf-8?B?U0JGRzZzU1dpSFJGQXlSVEFXcEpURnhWYVdXdUlOQ2k1U3hQQ3lYY1o2ZDdv?=
 =?utf-8?B?N2swQ1A3TDNUa0ducHBSNDlqTlZjdGZvT0xSQWYyUkFHaGE2WUw4OWVMVUgx?=
 =?utf-8?B?TlJLbVhxd2FHZW9Cb0lSR05nZXZCUnJXRVVJMm9EQkFDZ3FYbGNWMm1RYVJK?=
 =?utf-8?B?cWpLYlVJSThTNC9oQUp1cjFkbGJRRElxSU1DQVBPSW4wQXZoa3lzZ2h1U0Fx?=
 =?utf-8?B?bThyaFVJZ3F2S2lmRXI2aWQ5SXZpQ09DT0J0aUhwVkc1VytqY1BZWUUzVm1S?=
 =?utf-8?B?L25xaFU5SWdxSDBNZ2M4TUdXSnBoM1FhZ1JTU2E5eWl3UkcyRVp0ZnJaaVRP?=
 =?utf-8?B?cHZsR0dtdUlwOUpwNTdQb1d1dHcxQTF4TEFWaFU2WmJ4T1VacVFHZkJMa0NM?=
 =?utf-8?B?M1J5czhtU1cvaEpJcVZzM1FtSWFPVSsvTER2N3hXQUp0WUMxZGl1cG9xN1Bl?=
 =?utf-8?Q?Gg5Oabjymhc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N01KSTFKc29hUG9NYzJZcDhuUTQ1dndlUXFDNkJac1RIL3JFL002S3BqRDJQ?=
 =?utf-8?B?Z0NuNzNFbzRKRDh6cklubkxzMXJ1Y0JMM0V1L2xPalZkeWJCSThid2puUS9v?=
 =?utf-8?B?bTBCdUxiemRlSzdva3BLK0haR3dGZHpFaThYNGhQejNmeEhXQzcxSkI3Tm5W?=
 =?utf-8?B?djJMbytDMTV1K0d0aTVZQnpBdjY0TDZNWjhOdXhDQXNEL3F6N2RLc2tTc2U5?=
 =?utf-8?B?UG5qVmc2ZXViOVBvdU11SXVoWVlWcWFENWZVT1RGejYrZHdnVTVHazc2Wnln?=
 =?utf-8?B?Ni9sY004cjg5SlJxMFVoZFVDUjluMkxwRUE4UXlBalRwUmw0eG1WNzUvd0d1?=
 =?utf-8?B?dFd2RG5XMHIrekdSc29hdzBNSUY0OHk5NDJ6TWlCZkdIeVJMcisxSFJEM2lO?=
 =?utf-8?B?b1Vxb2kwdE04RE1mUUh2R25XODQ4T1plcTUwcWNraUpjbWhSVHlXUUhBd0lu?=
 =?utf-8?B?c3puTWxMZTNwKzZBOCtJb3V3b1gyRDVWa3V1ZGRJVFlicVVKOTdJTHJwdW1r?=
 =?utf-8?B?SVA1dWdJNjFSNHVCOGJMZklSSDVSaHFpbTh1RFBEdTFXeVRWWUF2eVoxSzFZ?=
 =?utf-8?B?SVNCajZhV1AyVHN5WTBxcm1WYkFTZEJSZ1JxdDNpbnE1Q3RQdjAwb0tFTnpE?=
 =?utf-8?B?KzZZM0tMellPUjNWZmttRzRHcStkaWxVN0ZScnV2azJmYitZbG1xZDIzOHdt?=
 =?utf-8?B?Q2k5SHg0ZHRYeEdMOW5DSTlPbUpWNGRuY1lrdFRBTFVhdC9zS0F4N0t5LzBQ?=
 =?utf-8?B?eEdtd2pDYjVaNDZRd3ljOWVNSGpJa2pxbWhQR2tDZ1VjMTJNcm9yb2tudEc3?=
 =?utf-8?B?VmdXWHgveURHOEpkMXVkSlJ0NHhJZm5rQkJPaElxczR2Vk5GN1l4SHlNOFhs?=
 =?utf-8?B?N1AvZzJ6L1pxK2F2WVVBckQ4RUdVN3dCYkxCV1VnaXBKc1A1VGFmZHJvTGpl?=
 =?utf-8?B?MEpKYjdJZTVaWjVvdEc0aFUvdjY0cmxDUUhwMlNFSzdraEJucTZuUW8wS3gz?=
 =?utf-8?B?R3NxQXZwb2JQWjJRME9MTGJMVzQ2RklBb01MTHJWQVh3eG1DVXc2WEJHcTRq?=
 =?utf-8?B?WERKMnhxY0tXZVB2anNyQ3J2UTlKc3lQR0wxRkhxMkR0SkpIczM1V09TUytM?=
 =?utf-8?B?S3hCK0Y4RDU3bytNMzZGcC9hK3VrOSsxMWhIY0dESDVDcDNuaGE3cFVEZjU5?=
 =?utf-8?B?SFZmQStnYzJmc0lLbE5RV2Y4REt2Nm5jUTk0TXAxVjFNZldvcnRQQW1YTU9m?=
 =?utf-8?B?cjk3MDkrV3dYR0k1Rlc0NEwwR2JNVXFEUDlJQnBScUFNc2ZKRGIxRkNrSVBz?=
 =?utf-8?B?cGcra3VxZVhvTmFYNHJYeGQzYnFya1NYMUpBSURJei9nNDU5aXY5NnBKUGZ6?=
 =?utf-8?B?NWlrZ3RPQWVBeDBsMEM5TVZyVXB6R2ZrQmdmdG9mdHRoNkYzeXQxSjhGWDJT?=
 =?utf-8?B?RXRKRmlHME0rSnoySkRQOWJycGZXcEtJR2hDY2kwNEUyckIxSVNTUThiT2l3?=
 =?utf-8?B?TWNEVzV1WVRqdHFUTEFjZWNwYnVUbnptZG4wcThyeGJ1L1JMekJUZ09QSncr?=
 =?utf-8?B?OTdpQUlFYUdpN3pTUTN5SmRoNU9UbHV1NXpFaFFTOUh5bytLMmRYZFEyNmpn?=
 =?utf-8?B?TEUzdTczUUd1Qjd2aEx0djFZSUxiTENlUmRxUEhMQVJuWlp0T0ZRcnhpS3oz?=
 =?utf-8?B?N25LeCtLMXBBakVROFNNSzU5UWd2eEtRMjBYMkloUDVzMzl1cFVTL3MzVXlD?=
 =?utf-8?B?ejNDOTRZMmV6VXk2RTl3ZkFoUmxYbUFyUUVvLzhuNVgxWUhmNUhJdmg3TmRt?=
 =?utf-8?B?N1lJU1I2L1ZFejZPUHJuVUZ5L3NJUlc3VXZSSVQweDlhSnJ4dVZhZW14UUE4?=
 =?utf-8?B?cFgwVXE2M2RSalZra2xKTWxvQmZnMjZ0M3NUeTRuUlVqVGlVckNPYnVwcVlY?=
 =?utf-8?B?RW9sUTdObUIxbmdWdE1qWHc5Z2hVNE42TFVUdnVFT3JzeUZoNmZ2VXNJQUdK?=
 =?utf-8?B?eCtxd0hTQ1VtRWY1LzBzdVJBK0c3NDMwWHhQVHptYWtCbWNHb3lacnhhNFp0?=
 =?utf-8?B?OW0zMlhESlpQSElvN0VtQlU4MzRycCtZZDhCeWRLcUpvOWltQ29tblI2cjNm?=
 =?utf-8?B?WUZvQ05lYXNLdklwS1cyYlU0YUZCRmJvY1BzSlY5dS9FcmQwUG0rREZGSEFS?=
 =?utf-8?B?d1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5b32ee-8ad7-479d-6836-08ddea97a4e3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:11:58.5050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5dspJu+XUcBbsUIWzRNBlXoh1XsF4jk0D7fGUyu/a8MZJy7vLtbHtjOX3gOEy0gvjzMNU23CxQWEkfmmAQ2jBDYnoklvu543HXswWGmTfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9131
X-OriginatorOrg: intel.com

Hi Babu,

On 8/14/25 7:25 PM, Babu Moger wrote:
> Resctrl subsystem can support two monitoring modes, "mbm_event" or
> "default". In mbm_event mode, monitoring event can only accumulate data
> while it is backed by a hardware counter. In "default" mode, resctrl
> assumes there is a hardware counter for each event within every CTRL_MON
> and MON group.
> 
> Introduce mbm_assign_mode resctrl file to switch between mbm_event and
> default modes.
> 
> Example:
> To list the MBM monitor modes supported:
> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> [mbm_event]
> default
> 
> To enable the "mbm_event" counter assignment mode:
> $ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> To enable the "default" monitoring mode:
> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
> 
> MBM event counters are automatically reset as part of changing the mode.

Needs imperative, eg.: "Reset MBM event counters automatically ..."

> Clear both architectural and non-architectural event states to prevent
> overflow conditions during the next event read. Clear assignable counter
> configuration on all the domains. Also, enable auto assignment when
> switching to "mbm_event" mode.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

| Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

