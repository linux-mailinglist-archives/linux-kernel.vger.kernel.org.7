Return-Path: <linux-kernel+bounces-736272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1292B09AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD92A43F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 04:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBD1E25E3;
	Fri, 18 Jul 2025 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggSMKtNo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA11DFE26
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814583; cv=fail; b=IiRp2IHkvDUzLbGLHBSOkBqjpsdGL6nK8QOYlC6iBqp0zFFcLijrLO6DiXHWctXQ5akUqWF+fayP6Ndo2hMR96BIDkepFekwMCOerqDVOdJmdwBKxlyxezQDjZbSb0vY9gEeMUsRUHqubmfhSuMhVcwd9V+plZJyqDjlTWLFuIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814583; c=relaxed/simple;
	bh=t5N3aEJ3BOdt4ZoTqCIIwQeWc4cYyfpBX+CeaUIx+Ds=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JcqlYtOd8bGXq3BQt8O88nU60chH22MMT2ijLbMcSQGNJBLA05n6LuLN+tIDU7mHz77MTqnlJuqr9dOrhtxKXPhfzs1BeolVFni/otJrZ26KSvwKD/qeLkVR5qfM0j2git47AVftNLhhAr3BU1MBoAJPylY/mwsoqdCgw8TkVHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggSMKtNo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752814582; x=1784350582;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=t5N3aEJ3BOdt4ZoTqCIIwQeWc4cYyfpBX+CeaUIx+Ds=;
  b=ggSMKtNobzzl4lpZ/QI7nlcV/wq2Gl/nOBsRjrYLnU6JKmBsWqmypjKk
   GZbWEOO5dyGAe/+9qZRXTM5OOXw3syfwt89bao1gyasvCiRytdOoBRk7N
   BJfEJ5IWbW0KO+sm3vrNNJixhgvbGat1cqxzAnRKuwJOgkI0dEcOuOCWQ
   P1u8lSfIV2Fsf19UNiFa864MGqqACG3VcXuTaq0kfFC0T5WTQhBSsdBwR
   Qyp+wF1QE3p+HSUy//N/Uh3BffHNGDhPN8oa1BjykDRMB5IVPALFz4DNu
   SwPRQ893L+WruXLu689u7Cwgm+Xyrkespoj17AglGUVJwy2SPqVAMpxaS
   A==;
X-CSE-ConnectionGUID: z9rK5h2wRmen+/+Gskz0lQ==
X-CSE-MsgGUID: cp/Jtq10S/OTPSAl7JUHfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55249412"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="55249412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:56:21 -0700
X-CSE-ConnectionGUID: zFnV3YVyRFGz7YJBWN3xgg==
X-CSE-MsgGUID: nS58fzVTRrCOvOBwYufZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="158321340"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 21:56:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:56:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 21:56:19 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.86)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 21:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKO1Y4zFz/2G2XTtQu3SkCgrsYnRpHbyYv53YF/tpC1rMNJsunsBOj2lJCzpC5cmnd2uWj8q6okysvVmvWQaRXeia6nhUIgTDEcmKjCHr/i5eQzW049IzVQPjJB6nG7EcXMx+Il2F6t9DISVcrdigNxTAEgOQ7tPI2o6qCKkTXYhvr0GRlHxQFqEbF3STEM6edXNBAXdI1vVgeS20XIqH7S3egjiUAnvUo8YOOO4IiLSK8N+EPsoH3kPBTm/LN+osyQXi6ev8aNPwiJRW/kaQsvcIbdtcGdc9huJqHGs6dcQioDafeAUlBr9bBD/AG1zR/pnC5nlIeiizA04U010Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3lqWM/xXS/tAKAiCnijNvFwEMRwTgd8H8+uGZJCOe8=;
 b=R8A9bed+tk34e8mF9MnjZYJoJH1m1sT8IO00bSAVdH8aw+aYbWulhcBIohbSo1Z8wCtcsxw9wBx7tjNY687tC8TSW7LbRumfVrzIy1GoqaENPoYGWj04cIL9c1e/PvGcVWHZCfTsnlBlvnHtPS0mKDLOOX+exaQQtdBvmM3y7FthHPyGBfxOdvy4oZUNvf/BEM9+jHEbXhzqoAi7U/j6w7YacTJwPtg4gheGWqzXkTql9bE3cQYUGsE1XRrAq5UIGbGW6Sot/OOC8sDKMNIg3O0dVlmE8yob3Laeog4prQjUqWrzPGieycZyeg3CcNi3hWLVFl2KcvK5PopC0WXmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by DS7PR11MB7931.namprd11.prod.outlook.com (2603:10b6:8:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Fri, 18 Jul
 2025 04:55:37 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::1a0f:84e3:d6cd:e51%7]) with mapi id 15.20.8880.021; Fri, 18 Jul 2025
 04:55:37 +0000
Date: Thu, 17 Jul 2025 21:57:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Balbir Singh <balbirs@nvidia.com>
CC: <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, Karol Herbst <kherbst@redhat.com>, Lyude Paul
	<lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, Shuah Khan
	<shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Barry Song
	<baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, "Ryan
 Roberts" <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, "Peter
 Xu" <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>, Alistair Popple
	<apopple@nvidia.com>, Donet Tom <donettom@linux.ibm.com>
Subject: Re: [v1 resend 00/12] THP support for zone device page migration
Message-ID: <aHnUMTly7pOywJKg@lstrano-desk.jf.intel.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <aHmJ+L3fCc0tju7A@lstrano-desk.jf.intel.com>
 <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09c5ce76-f7c1-41c7-97e1-74448e6143f7@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|DS7PR11MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: b81c9a24-938e-474e-5621-08ddc5b75620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG43UUhPa2tFazVRNnpLQWlCWkJXMXFsZW51V283bms3OTNtVDltK1EzcWIx?=
 =?utf-8?B?bUNIRjJYSjVIcW5QK3lkR25HOWplVHhFM3NBcSs1Mi9Jck8xQWE5YlBaODdm?=
 =?utf-8?B?c0hUQWs4R1RHb1lkbGpDOHl6UEk5dGU3TGRPZ1JXVk1XRzNlK1dLWW1qTkl3?=
 =?utf-8?B?QmxjN3YveDNCVWZGZFgvRkhxUU82dHZTN1FpWDYrdTJlN3gveGhQNW9ZYnJ2?=
 =?utf-8?B?Mk1HRXFFMUlRUXBvajlWTncrRmJBODd5cmRBaVhSL3FVdkJKM1QreTg4NjV3?=
 =?utf-8?B?Y3J0am15R2FkcVBJMWhVbDg4Z3lLMERlMEw0ckE3OElFQm0rSkxXZml5ZldL?=
 =?utf-8?B?amQ2NklCY2NQd2xFTE9JazRZblY4ZE95WEFZaksweFdFRi95eE05Y2c3UFB6?=
 =?utf-8?B?S3YranhKcktoZkpIajJwb3p2NG01SVRvdCtldUZzUllpNDRuUktyalVTZWxl?=
 =?utf-8?B?MEZObHE0ekRlU2hOSyt3elZWb216bWxUdEtaVExIRzZMVENHM1BZUTM5YkFu?=
 =?utf-8?B?V01Ha3lNblFvTGZock83SjdxSzRSWk1FRk9PRFpwQkFxa3VzZ3hDOUQwQk9B?=
 =?utf-8?B?Z2MwL0Q2OUdWVkhEN1hjRy9hM2JuTm5DUFFJS0xjWHVjRzVwWU9vVjE3OVRU?=
 =?utf-8?B?SWN5N2psbW5JUjZJUkFvckF6TlhEK2ZPQ3F5OVNnaDVrS2I5eFVkYXFwTU5Y?=
 =?utf-8?B?bW8ybDVSdVA4L2FCZEFxRHRiajgxS0RaTSt5TkJTRzlpdE8zN3VFdG1PYjFW?=
 =?utf-8?B?cEtJQTI3ZFpnMkZxNVZkZGJyRnhUNng0N1FEMGFENVVVSDJsdWNhajM4c2tE?=
 =?utf-8?B?bUwvVG1waW9LSFJPalVxbmR3Y0NyMlpqSk01K0VGakZ5M3RFNnRyT1NIWFhx?=
 =?utf-8?B?YW12OHRUVEpQL1A0MGQ2M3pPQkt6bG0rall1VGI1dXdycEd6NCtxQ2twOThq?=
 =?utf-8?B?Vko1enArOHowb2pHbjk4bDFKTDA3R3hpcGQweVU3MUFYaldob2NQbXROcVZO?=
 =?utf-8?B?czY5VG1LU3FjNGZ0aWhkVGs0eUdsL2NhWHhiT3dhenFYVEN1UWtLejBRWWpk?=
 =?utf-8?B?SnIyL0xQRmx6NnJGM0ZBNnFnYlRkWWNCUVRwQ1VEWStEZVVvZXV0dStHNzJK?=
 =?utf-8?B?MkgxQmh3eXowUUxodUMwZFlJNGhRbURzV3VrUTVaZWJZWFlkOEg3b3FuTDFY?=
 =?utf-8?B?YXgwWmdxVW1YSWFSV1VzVG1NbHNhWUY3NjVRRU9hOUp4SUZoRXdIeFlsaEVQ?=
 =?utf-8?B?aHdKQ0RTTGgvd1d1aEQ1cjFBYm5EOXBKa1QwMkx4eU93N1lqbUdPM1I4RnFJ?=
 =?utf-8?B?UGM0dFlHb0RUYXpBSWw3R2tzdFp6d2UzVFJhWnpSYS91aUo5N0xuTlROZ0tx?=
 =?utf-8?B?djU4RnBJUHc0dWJMeWNuMytMVGV3U09wQUptRGgwWWQwL0RrbjVMT1ZuOWdz?=
 =?utf-8?B?MExNV2JLQ0tCSUdhYnNuSnA1enVJN1lGUGlVMmx1RDV2eW1qTW9pS1d3VFgv?=
 =?utf-8?B?M0hVamhQbld0aWVHSmVXdUVJbUZPaFRXY3kya1g4R3M5QW1McHJLalBJb2Qx?=
 =?utf-8?B?Njh1endjQnFUQ1FxVEpGb3FJcXRrYU5kL2wrYXA1eThEWTNkYWhYRzRGZzMz?=
 =?utf-8?B?eFlFd2tZdEUzK0hMeUUwSTZTRzdpUFJkYzZjNzEwZ1c5dUt1eVhYeXdmSnVv?=
 =?utf-8?B?QWkycksrRDB5cy9GbDBuWmZCRmVIRlNPYXpaaXBZbUM2a1k4UllOWi9MS0pp?=
 =?utf-8?B?RCtpWTdkVVhzWHU4TTZUSFE5MnpWamFuRGhFK1pGWUQzTjNMVDQ2S3ZHbklB?=
 =?utf-8?B?U29XNTZIRW54ZmFuK2tSK0hxMHdkNThQQjRkMkxEWlprZ1lqblVUYWJEMkNS?=
 =?utf-8?B?OVQ4UjY0aU9zOEZicDJDaTAvdTRlMWhRclNYRklKZDJCRlk1OFFHK0k2aC9j?=
 =?utf-8?Q?NQNLghvKzcY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxEM3Q4RUc4dGxyRk0yRzUvYUtUNjVRRDRXZHF2Wm85VWpVVkltYnZ0MVg5?=
 =?utf-8?B?dXNhYVpHOWQyTUNPb1Mya2o1a1FOTFVEUWtWUkliZE5paUR1NUpWTUZ5VjNw?=
 =?utf-8?B?OTB4bW5DaTlUOXZnK1FuRmxpREt5SUtCUGptWkt4T0hQRFpZVzFLci9EV3Nh?=
 =?utf-8?B?Y0wvOUF0OE5aUldrZU1WV0IzMExQWmxRVnYzRVdMVjBUWmMvbytMT3F1YnNT?=
 =?utf-8?B?dm92N3BiQ3Y5WXU5SzgrQWpGV0hZNklFM2R3c2wyUFl4Ukc5MG1uUDVRMTll?=
 =?utf-8?B?V2NtQmxyWWdscE01T1ZuMGFEeXpiRXJ2b1Uya051NE9OQkhnUkhTdmg0WE5V?=
 =?utf-8?B?aVNQV05KVFE0TEhXa0cwL0hCbnYzcGFoUW5rbWt0VUc2V0hJSDd0Nlc0VTM2?=
 =?utf-8?B?dVk2QjhZZ0tBRDNYdWZTb3hwMTAxSFlCYlhQdEpTU0E0c2ZiV1V4M3lGV1Fo?=
 =?utf-8?B?MG5lQjNUZEhOMnR0cjNpYUVKZkx5NmI4U0ptZGx0VGtVMUl1Zk1ZZmhpYllm?=
 =?utf-8?B?MlhXVkowM1VxSzFWMUNFekVMdDZ5SVpUZ0Mya1FnakRUQWJKOUhWcERJTS9Z?=
 =?utf-8?B?Qmt0YXFPQWxvSFhqWnF6MDE3bUZiVnl1ZHVUKzFhWGtjbnY5OVlQYStGK1FF?=
 =?utf-8?B?a0JSdkk5WWlaVDFjRFVOVksxMFdyZjY5dXFLcjlnUWxGZHFMbnJXc3FHYVRI?=
 =?utf-8?B?S2JJSWd1ejNuSzloWHZXTlZQRDEvZndCSGN6QUlEU0xWbVVMazdZNFFCaFJH?=
 =?utf-8?B?QU5PQ0lIaVUrbmlNRyt0MCtsK25IUlYxTk9rd2VCdFdwYmt0RE5jWUNyWHNq?=
 =?utf-8?B?VG1jNGRlSW9ycE1IWldHbGozbEVaT3hQVGlIV2tmaXdwK3FWd0EzVkVoNGdK?=
 =?utf-8?B?azZ3RXI0SmpzSlpoVlhTVmFkaW0wU0srUmJWUEdBMTRVZ2NoWHUwNVRPdS9N?=
 =?utf-8?B?cm42NHo2bGtJMXB2QXpuWGpWcnBlS0xWYjRzcEVLMGNXd0E0aWdvWHhCOFJT?=
 =?utf-8?B?ZzI2dnFCemMwaXArZGhYOG45OXVXOGtRajNRRWxpeXFMNUZsU0RCVmhHdWtF?=
 =?utf-8?B?WVE5a1RWY3d4U21Nd2s4dFQ4Zkh1TnY4RnhNaXBJSkVWKzB5S0w2VGc5ZDNW?=
 =?utf-8?B?ZGFaZmEwQkhBK0Zjb1NxMXVEaWs5YTljZXNvQjFmSTBYS3VycGFUUVlCOHh0?=
 =?utf-8?B?dXpuaUFaTkZGbThTdXBoa0N0NjdpU2FzcWsrd2tCa2U1bFN5K1NRWk1Qd1pt?=
 =?utf-8?B?LzFuRlk2SWQ3WXBsSGdQMjNHWlpWUGJHZzAvdldJdC83cHdJS1I1OWVJdDlv?=
 =?utf-8?B?TGdZM1dNV2lzdVhDdFhrMlp5R0NKM1dRdng4eGtRYkJ4WmRpYTZOMFAxVmJS?=
 =?utf-8?B?RWxFQVVXL1JUeUl0UjA1UmVXbko4Y00zWC9oL1Q4bGhtdWRyOHkwak9raDNa?=
 =?utf-8?B?VGYxUk5aQkdrdXNsVzNqS01GYWRaeFJlNHBlWkVOVFBib1BCNTZldVlnbWRx?=
 =?utf-8?B?eEYvdUF0bW1SdzdtNlFiZTFEbUFjRUNLc3RFV1lWdHJnNUVQYms1em1mSGxx?=
 =?utf-8?B?d0hBK1E2U3I1c2NQZEppdGhZbE9KQ2E1VndsdjJEaG1DcEJENU1LT0dXZEk1?=
 =?utf-8?B?b0VMWG1wQldENFhvZDE2dEhyZS9YMjFyQk12blAxMDh5YWNhcDFrdjJlYTNJ?=
 =?utf-8?B?WnMxcjJiQXhHSUtwUFh6ZmdKUDJlYkZkSC8yTjQ3bm5pQ1ZENnJUTzlseUM0?=
 =?utf-8?B?ci8vUWJrS0lsMUc2cGtNdnljaDdmZFZzNXRKb2R6d3ZwNUNPM1Noc0ZrUEJj?=
 =?utf-8?B?M3BOUTdhVFJTbUxTZE9lSGF1dkRldTF1Nno1NllISG1NS3lIRFZYQXBjRlM2?=
 =?utf-8?B?Q29kZXFPb1Nma1NoRjFqMlhtSnRSbDkwakdiS3EzNzBtYWFQc1BmZVBSckYz?=
 =?utf-8?B?SE45SXNGdElXTW4zQ2Z0allNZWo2VUlTN1NRWUIwd3hicitRRG9KQUZpK25O?=
 =?utf-8?B?OWpCRFVlb281QVJFeE84aUY0Sjg5V3JtdnplTWhNUVFjaFZPaWt1eXh6ZVZ5?=
 =?utf-8?B?bllSbVRtVDdadlFtN0FSNVdRWVJ6UVI3Qk5sSmdrOXl2N3dpYXplVmlVWVRo?=
 =?utf-8?B?SkNxNVRWODNJMDdiaGltWGlIWCtKWkFFNmZNR3ZWbnF5Nlh6U3YyeWdWdytj?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b81c9a24-938e-474e-5621-08ddc5b75620
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 04:55:37.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNH4S3Vkb1xCTv16ngCr2J3ZeGDEfOjiuZ8JU3SNt3ybeqdFS698kTd7laZXmiqjey5GuIlP4Se+E92nh3aJPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7931
X-OriginatorOrg: intel.com

On Fri, Jul 18, 2025 at 01:57:13PM +1000, Balbir Singh wrote:
> On 7/18/25 09:40, Matthew Brost wrote:
> > On Fri, Jul 04, 2025 at 09:34:59AM +1000, Balbir Singh wrote:
> ...
> >>
> >> The nouveau dmem code has been enhanced to use the new THP migration
> >> capability.
> >>
> >> Feedback from the RFC [2]:
> >>
> > 
> > Thanks for the patches, results look very promising. I wanted to give
> > some quick feedback:
> > 
> 
> Are you seeing improvements with the patchset?
> 

We're nowhere near stable yet, but basic testing shows that CPU time
from the start of migrate_vma_* to the end drops from ~300µs to ~6µs on
a 2MB GPU fault. A lot of this improvement is dma-mapping at 2M
grainularity for the CPU<->GPU copy rather than mapping 512 4k pages
too.

> > - You appear to have missed updating hmm_range_fault, specifically
> > hmm_vma_handle_pmd, to check for device-private entries and populate the
> > HMM PFNs accordingly. My colleague François has a fix for this if you're
> > interested.
> > 
> 
> Sure, please feel free to post them. 
> 
> > - I believe copy_huge_pmd also needs to be updated to avoid installing a
> > migration entry if the swap entry is device-private. I don't have an
> > exact fix yet due to my limited experience with core MM. The test case
> > that triggers this is fairly simple: fault in a 2MB device page on the
> > GPU, then fork a process that reads the page — the kernel crashes in
> > this scenario.
> > 
> 
> I'd be happy to look at any traces you have or post any fixes you have
> 

I've got it so the kernel doesn't explode but still get warnings like:

[ 3564.850036] mm/pgtable-generic.c:54: bad pmd ffff8881290408e0(efffff80042bfe00)
[ 3565.298186] BUG: Bad rss-counter state mm:ffff88810a100c40 type:MM_ANONPAGES val:114688
[ 3565.306108] BUG: non-zero pgtables_bytes on freeing mm: 917504

I'm basically just skip is_swap_pmd clause if the entry is device
private, and let the rest of the function execute. This avoids
installing a migration entry—which isn't required and cause the
crash—and allows the rmap code to run, which flips the pages to not
anonymous exclusive (effectively making them copy-on-write (?), though
that doesn't fully apply to device pages). It's not 100% correct yet,
but it's a step in the right direction.

Matt

> Thanks for the feedback
> Balbir Singh

