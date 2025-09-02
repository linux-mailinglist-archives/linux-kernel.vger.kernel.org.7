Return-Path: <linux-kernel+bounces-796857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F32BAB40867
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF5D14E406F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1953128D8;
	Tue,  2 Sep 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMqlkOiR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A925E313558
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825442; cv=fail; b=m9hBnbCMvttk3A2AxPtgClDXdsm6dn/PS/n0dxD0bw/BTB6nHJ6Uh8pVdt2FheW6JbFw2i/LFd0qSVCH8ATxOlpZu0mglnHXRfnqOzT0iGGfLiDbEwuoVIUDu+essdlXp5W8v3nRno70DjlchNe78CcGfad/m7/5UiI90+US900=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825442; c=relaxed/simple;
	bh=7CMT17eXlp+frvas6mRk50H6MNe2lh81VfATKhv6tAo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LSvfGZ3jNIhq0I37T9/EU2iL6KQv8kNjzfFtbIfEQNjMNc+6h8DVP/Qv9MBcjdLCc/61HIXlpTPPTHHBj+b0pRioa0Vi09LCRgoUEmkmri2pcfodlYfVUnlsmmDL/k4sbopHkL+1wKDxQNPUm5EaJfRsl5hdcgfPDz3hm7yYlnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMqlkOiR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756825440; x=1788361440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7CMT17eXlp+frvas6mRk50H6MNe2lh81VfATKhv6tAo=;
  b=MMqlkOiR/sLKwkDF0oPRZtOAoXtd2SbCtQswC0HDYiTOcnYbQxawUDH9
   8S8v+h//4iUsTGMJJdY/sFzM6G7pAXZS1wW7uwUkOyXEwXUDdzG7ArzRh
   /7zEsyIcNI76Gm/mM4h+WBixlmncdP4TsEtCUX2QGfcINxv1Bha5uQcuZ
   xjWw9fSeF5vV7yXiiwXeCxDFFn1GmTGijrtb6iIalqbJ+pjFbtqAHFXkb
   VjATmw28ZBj0NXEFfSfRnwtj3L7OvVN8vPrADPtoBE9d5dpWft9m438TH
   kDpl1GxIsLBwoCXxVtHJDufvgxBemcQiz0ccNpHBop9FZmOG0Qs4gPG+f
   g==;
X-CSE-ConnectionGUID: 3aXGnSkZQVKyXXMp2OXE1g==
X-CSE-MsgGUID: VJ1iYUiCQmihJ1avRmV0Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="84525502"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="84525502"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:04:00 -0700
X-CSE-ConnectionGUID: QIpjTnxOSkWJ46QRA0sVww==
X-CSE-MsgGUID: 3C65hDlaS/iWaTozN6cahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171269600"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:03:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:03:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 08:03:58 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:03:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s5n2dhIBY1Hvece1LsEQmP3eclZkPtImqfowFoBDWUGyOjfiZ+qEQmFJ3b+MMc4OTP29BbVAR2Plnvw06lR1DFcoeO5Z4+QBkPSI/7qqq/XH7/hYG4qVOppNoRn/4g71Rk4j9zKuwe/73zMtTaMrhrd7XZeJ5pwXlGfTX4Oo2yzD91EdOUnp0ZsLJFmh/Y3z+w41ZjAo+ha0WjLl/kboG1PXor31+0uAc0NPtSF3Lk+U+zNOcKsNBe38pmeshQd2RMcyc0Rr1rdkGMIBV22zW8uW+dnU7mvk3ero18iimKazDamGmRKFwJ9UIpbWTUBpx15gub1LVd0F6cNT0B4QDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdlGoehymYZ+lfQkr0y+0rdJ+1SvoS8Ay0F3F8eXnzo=;
 b=jJYFmBUTSIMDe1S0Z70Rdj95wCqOewr58vVUI9Zh/jV9sgYKoHM9CoycTyEPdfTSwCkKsrVt/+EERRN8P9f4UrjNe9CzxF6p+jKmwGV0omGz1+AJjBTJN9WDL/IbtyqdSAtV1Pf7TYzQnodeskdLuqiT4eFRYJIL+8aHJ4JNLzKzLh7Dp7hqidcWdB658Vvcma3mVTPO+AV4yl6UlIYnX8xn3GprLl5JpmAZQXRU5+bY93H8jbwiXgoiiJv2feve4MlSYzAxEISIcz6T7/kd7y/GdW1CDUU0GX9bfmXaM5gnbHfAMbNu/XpvsmPFkR29Eposs6KcVfAdeBna26aQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 15:03:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:03:52 +0000
Date: Tue, 2 Sep 2025 23:03:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <oliver.sang@intel.com>
Subject: [ardb:x86-startup-confine-v7] [x86/boot]  7d40dc256f:
 BUG:kernel_reboot-without-warning_in_test_stage
Message-ID: <202509022207.56fd97f4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 38edb57c-b390-426f-b5d6-08ddea31eddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3IN/QJDqXlml2Fj2DlHyj1Qi181FJGhHP6h9buFzcQppeQucKfFb0XRWV7KH?=
 =?us-ascii?Q?ilXdBnbfPKvKGLGAIQcFoGylBmD4RMSftqyESN4cEwebQKbch6BNiznxG5N5?=
 =?us-ascii?Q?8QEh3XRabBZqe3og7A+mYLGn8SGEBSn9t1D5W2BhXIKmYN5HrcVC65dlWpGJ?=
 =?us-ascii?Q?aYd13JwM6bDzWwcRopY6Yx59pFPm/j+3hxuJX0vG85fzxZ5fWES6RR3MfcWb?=
 =?us-ascii?Q?2W648ewlljnUP/4JTllJCS/4uSeuDp8zpvGzPWUDKritjgBTwcgGXcYmFQc3?=
 =?us-ascii?Q?CF3Usa2QRsm8iN1+e2a9pv1M78lXv/pL5apG5JVrd7mynS00YGQbozXKIhp/?=
 =?us-ascii?Q?2QKyR4YaFCHGqYhm+MFaus+e76VEjnd79L70OmkXb7aCii20GkG73o8QYQqP?=
 =?us-ascii?Q?cABh2HkQiwReIAESsbkBjRegaq7HnFotRRamFv8KkeVY19BBeu4Vy3EcS9RO?=
 =?us-ascii?Q?pj5/pMyduN+HEIduyfl/1VFZBFkwXy4dyMe2KwT4ksceSXHO61fPg6zxOyhK?=
 =?us-ascii?Q?MNljq7MZ4jRBQHdZcUV62XluyCu2niAWthQzlzDFUEgEKzV8b3itE1MG+UYe?=
 =?us-ascii?Q?n374wr6qTAueihM0CLp/OMvhwgNxdjLFYoKyP6t/BHYK8M6LRWAUEVxOyeM2?=
 =?us-ascii?Q?EQ2lnu8YLtwiQUp1OtmG8l8M0IXGZU3rOvC7TJRgh2kcP95KBeInx9FqKoch?=
 =?us-ascii?Q?Hh2S2FUddEuq5ussseG6i5yzpWJnGeopqdKDUvDlVDYXV21fJjwKwS2z0pOS?=
 =?us-ascii?Q?crz5ULhdc4HBfqWECwa/bIp3rrldyhxV2sU0591a0Q3JITleo5g30clZLp/t?=
 =?us-ascii?Q?2TsI4/nBTrIzDg5XnvNaLTgnGQsmOaBaseaGVjvwm0/1JGd0hYNSpKkqERE8?=
 =?us-ascii?Q?ooZAvkey/a7MtJTg/+G8lexVs8iT5oaocHxXHNXVoNnzc8L6Ptq198SxTd9X?=
 =?us-ascii?Q?EqUKKDrQrw2keseOmuXzxV+Hc1So4HMkeJPXUwWOir/4xwSiFMaA6p9RA6Ld?=
 =?us-ascii?Q?yebbelp8mukU0ANBX+/tbTDPr4SJT8VYKLVGJn2ilpVV3W6dlVloCwvGEoGF?=
 =?us-ascii?Q?Xkd4AFHNgwzDfG4XxvNdvbfsj+wYq6EYM8WBrga4Fh3LoH0qTd0t00to7CNj?=
 =?us-ascii?Q?WzCSofTGJ8k9rjGW0kuknXYAqxZohR4R1J5AhGK2iKQluPXaVNytHOEr7BF1?=
 =?us-ascii?Q?NJRqUfLvKD2MYMKJnEDxt1VACxMdIIvbLV8ZBXYs34UAW/tXOHj5Na2u58Fj?=
 =?us-ascii?Q?l+zycn/oX3P3WMTKUxi1xFUWQlkJfpgRI2YB/nPsgLUFHvajWvZMfYdwD81H?=
 =?us-ascii?Q?4Qr4dgc9NcTzWj86TvB/wYHik46T4fJ81yTt8QN3BXVizk+bsrtqy9mnqGxq?=
 =?us-ascii?Q?iyFuV8UC8P+8LqSxI/DNUuk8k5Du?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DO3G0u4OsXcefxOlfaori53x5dLtHIqIWQvUJ0fiXOgiht+QChz3NBVJ4Y4?=
 =?us-ascii?Q?TyIJpuv1vht3wPP8MysdQKp62H7Cf4K09ezHRvgHZAOgCVFt6ZJYsw+VMaQD?=
 =?us-ascii?Q?ly3LenMv4Z/7NFBpoXob9jHOtUVA6quBi+TztIFoGi/5KfRRbl/uxSXhEzxr?=
 =?us-ascii?Q?KOPRfJFH0rjATNawbOmK1FQt3suRX+e6zoegJEmfXk7z6IOVmUDYOotBtq++?=
 =?us-ascii?Q?021vbmHT8IjfWLSmLP2DTa/zOmjB+4pYX0hnEXoiC4z/byWV8GIR0hPU+7CN?=
 =?us-ascii?Q?3RZ2a0RAsONdoNwAcQLl6+uxg0yss7agwTcxaGFXck9X7zxmpDPSf2SSrmsa?=
 =?us-ascii?Q?0p6i28NdH5pm879ZGA9uHEvJLJ/YRZDYmcDJJdDi4WYTlbLJrtYhdbh+0MSU?=
 =?us-ascii?Q?cYGR9ogNAJir7hbtcUjL24he51EQjFhwwI/52GHH1lMRYFZVcrjOwtaqwtQ+?=
 =?us-ascii?Q?Mo+H5kFjl01OPtvc4RJZCxLOpvRY0VtT65dwFdWpjSeE6ZXLXCfc805KgZnX?=
 =?us-ascii?Q?BHjhH3RfaJXhqv6txUZk67vrFscm9RYaxed8tWMLA2HlabBddH9zcxDB+WdZ?=
 =?us-ascii?Q?6Z4ZBgHVvirGgC2q4rMymobDut1u4MKJIG6KEcZBQI9zciEhO4t9G86KRlwZ?=
 =?us-ascii?Q?74iudT+/Wyw4JGIf8Mv1EFpOyZyn1tDOZDRc6UsOf7TMumxMFkUGOR+Z1gR8?=
 =?us-ascii?Q?drjHQPBtBN1L4eSVXQsSf0DH8iFi2waP1BqB0WbKZ1cnMiz957JxvZS1tLRF?=
 =?us-ascii?Q?HhF7V7MskyDHqAh7rtuq+r3dqQvPP3ost43McJ6qpsyUR5wfmbF9dpG0oZ+g?=
 =?us-ascii?Q?8cxak59kox5kkevogcfUmXfcg5sOqMkqGVjMwKVQgoZIlu4DdDZNvjcoP+5z?=
 =?us-ascii?Q?7OPjWpVYYcmqdtuOjNuX1n40NO4gpNROJBDxXq8XCYAZUPtH7Q7HCGZzyycD?=
 =?us-ascii?Q?xw8zwxdcdvtm6Bpd3saAMTwyJUAYszmYXyP4wiohT4MrRNfnVk48XODw2k7D?=
 =?us-ascii?Q?gPxM28pLGTUoKzGaFP8rl1OGYER2Ew/kL7ToWNljkVScP6QJjn+DzNC5OEVq?=
 =?us-ascii?Q?BRMnRMlfENyqnYnHI2wOPStoO4+SS+LKWDJ7kFTFU6S2TAWUNxAXS8hulagy?=
 =?us-ascii?Q?mzZu510FE2iQYReED/4mG+JH6xt54q6HhAq4FrgOQrUCxDFViyTqb8tVdWJF?=
 =?us-ascii?Q?rF17NRs/+fbz/mTas0NKULVWzkeujBC2rKlzu0bhfELkq6Ernf7MyloDlvHG?=
 =?us-ascii?Q?tgadxEeK4pzH1l5szt1AbBnh4llmIeqmTMHvF4Ca4YPFuOjO4AKFcOiQvPn+?=
 =?us-ascii?Q?QcILMU+Bpcdx6+I5DpXudBnO8LFjBt9dIKfm60p8Dl0tqwJCJeZbtDGFaU43?=
 =?us-ascii?Q?CQCMveov2de3dF6eTMf8N5NrNZ4+N/HSFL2N2FvwJ9lfLAaGAxxBGYUtVGMi?=
 =?us-ascii?Q?Ub4UCC0PY1mFKPrXs8SyUEEKGNtYvsk8+3K63aTZAhzZY1/Y319twc0PuKA0?=
 =?us-ascii?Q?qHWDPb5wy2LYqwUHMquTaVbJDkskf+VwVVhAwwlEkGpFyXxJTBi1PuuBsJNM?=
 =?us-ascii?Q?pzLJ353qszUg3yf3nouNn38HfMNCT/4CPOFpPP9n4S+uyWR4lFHja8WQRVw8?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38edb57c-b390-426f-b5d6-08ddea31eddc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:03:52.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCKXbObgdLtPhyfJLoZUFKSVBlqvyoMreypb9bgKUn4rMRr6/kNeY4vzYBl4M0j1VElnzJrgiEKLC+C2geveEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_reboot-without-warning_in_test_stage" on:

commit: 7d40dc256faa19a66045c7e3147f387e346d513c ("x86/boot: Move startup code out of __head section")
https://git.kernel.org/cgit/linux/kernel/git/ardb/linux.git x86-startup-confine-v7

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks



config: i386-randconfig-017-20250829
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | 7ccec303a5 | 7d40dc256f |
+-------------------------------------------------+------------+------------+
| boot_successes                                  | 12         | 0          |
| boot_failures                                   | 0          | 12         |
| BUG:kernel_reboot-without-warning_in_test_stage | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509022207.56fd97f4-lkp@intel.com


[   46.638864][  T218] 2025-08-30 23:52:51 sleep 300
[   46.638874][  T218]
[   57.574765][  T460] tasks-torture: torture_onoff end holdoff
[   57.634414][   T65] smpboot: CPU 1 is now offline
[   57.663199][  T460] smpboot: Booting Node 0 Processor 1 APIC 0x1
BUG: kernel reboot-without-warning in test stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250902/202509022207.56fd97f4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


