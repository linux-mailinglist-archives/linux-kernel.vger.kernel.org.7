Return-Path: <linux-kernel+bounces-724811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E1AFF72D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 04:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8D0516A50F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30AB27FB28;
	Thu, 10 Jul 2025 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNVsKJAj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A227FB37
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116355; cv=fail; b=Sn65XTabK7L3TB44MgM+wUA9XEnsDGtinfywxzjijewtdwbtroPTmI9PBE/U1YqVBDIKyYNDBJHq+KlKXbCKp9M8opN8Rf+ZTjwyFsNEeQVH1Ml1Ah2qlC7g14ktR3hO95hE36Zx3FE2dRHX/LEzSrxwaTdGPiH+UnfKCq10WVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116355; c=relaxed/simple;
	bh=QzIxbHvHRbzvFow8OvldZ4dpI+Mu27tP1EeoAyRHO2o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=b/OZtZTLuG0s4MyptW+LB1xQZBvfeDmciaMVZM3rZdAJ5JTbTDQQwtgXTPPOQPBtFu68Z95iGw3Yc7vZjMdW6JLilqk8QHXqDBygMjyD0schnk8s6uSd7DL3+ka11LB9qdS9PXR2bNLhpsVpv8tZGGa20kmDGPWlhrj7XLIvV3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNVsKJAj; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752116354; x=1783652354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QzIxbHvHRbzvFow8OvldZ4dpI+Mu27tP1EeoAyRHO2o=;
  b=gNVsKJAjpi+G4E8yrNgbhV7+LP0ET1HelE+JS9IcIhyuzSqfghuRdChj
   2VmXyD1N83chfdEwHDf3u4fviwaEggmyapeM0kbwl8uXIjQCS4qgZ/lX8
   pv6UagjlMVqapu9sf2cXuvmQHYegOpMG3cwaGJJdpxfsUM+TjQguVV/XT
   8+WIctT1G/EUWiSkz99NOt3BAGkUEVEHZFzVSOzht9QW6xJM4RZiPescF
   xOUcj020S9Kssue9PpeH88p17N5UwbPRcz+kd+wAvm+tziScxWpteqNsR
   Z/MhTUzT1FAzN2ep1ZirL6+TEKhCMTjd1Owq/Yy+iahB/Kda3Rp7l26A4
   A==;
X-CSE-ConnectionGUID: 9W3n9undQHiJ2n1Ckc4tZQ==
X-CSE-MsgGUID: cWdt7dD4Qguapy2LOoae3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="58053173"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="58053173"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:59:13 -0700
X-CSE-ConnectionGUID: 1kiGD/ZJTOeEHTHW4Z8PZQ==
X-CSE-MsgGUID: LYDxtq9iTK+6sDVqu4iLEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="179654785"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 19:59:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 19:59:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 9 Jul 2025 19:59:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Jul 2025 19:59:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wy/2qYw864rHlhpfdvU7qGhrA657QaV+q1GojVma822V5pt2dUHTAmQVu//8V9ueiDQHkH3ktoG4Qu96ayEM8inziwtk224+ijWxmxSA/XgifoilkQv9gQFSj4kDZ/RgJSBG2kPgc35hsJ5T+cUprHgbhhuslk4QoOxVHM3SnN1LoJdxJn/Of1SNGR9Q/iMWwwSz0O52qQQSNXY4vXUPvmBwX7QHD0WXEJ4mzx/mH4++jFAwULIPmzZCTiNjC1yP1fg68p2rzkfLZo8dNIEJM87NfhkRs7pvrcZ4cUEdjkLAvevmHcDfpWfL3tWTyzvAgXamk3QQxFu8ptx3v4FFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LV/gxZ3qLZWfTGEM8hjttUqmCq21zkE6BQVgV17v9g=;
 b=yuvxi7aiMQe+Oxx3yhk9ZTLBWIUUjnKjzN/w5/b6oMq8inr4et1byoVVll8KqiF4JTqfloHh9NH3mOfljqsgrKaAQC6PKMXsUUyPlRx06ViKB00CwtZiKXjbOVUlvNjtiQArjh0CaLgSrB2S0N8qfXkzgKVNJZvVdQgJGQa3U9gGnY6/zrFkbzmK8sXpPHd4bCnwIkXtemktoobgIHssSPeG+SEYJNrHM/R0TsEevb2hGbjaTg2kieSMtEbf/7BgZcPaAFS/H9O7NjRyMPEMXBfHUtRRUtLMKHcHNn3BOq75FvLXi5VorMARH/CYYcPDcUdF2dB3sD4OkvxI2vUXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ2PR11MB7453.namprd11.prod.outlook.com (2603:10b6:a03:4cb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 02:58:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Thu, 10 Jul 2025
 02:58:24 +0000
Date: Thu, 10 Jul 2025 10:58:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Valentin
 Schneider" <vschneid@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/core] [sched/smp]  06ddd17521:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <202507100448.6b88d6f1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ2PR11MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: f3588534-2501-401a-12c8-08ddbf5da2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6qalEB8X2Qp81kefwUQXBldvNW6BQe2BqYXswm3QutFU0Y0GbTMU50lp0iiP?=
 =?us-ascii?Q?ib64UcapIivZxVvlyaIpYDCH3FL2fhuHz0cX6lMLMiLYMcNO4HoYDKB4Up+F?=
 =?us-ascii?Q?78GfpSnse2ETnh8URW8vBfZGFwk5VCXfHlmdkUDj/t0wTmUaYZZ59wbnR6S1?=
 =?us-ascii?Q?x8h95BXfyFMKIh5+jMWWgD/Pf0My7z59CT9hG/78UGsGXeu2Yu8tNdZcIaOr?=
 =?us-ascii?Q?HH3UNBTSN9YJbXscSh/pExOfgWE2jJQH0euDkorSWilS5z0dW80Fj/p/3UyV?=
 =?us-ascii?Q?Mjte5NdBW42hdxSG/KjTLkj3+hCZW7TVGqq/Qli3SBLOAiZjL5F6UDoTG82K?=
 =?us-ascii?Q?moAAS0Q/aqYvcMbGTlZJXxwBnF+sr2rNs6Abf9bCZ3aFxVeyzqhff/lv/l/1?=
 =?us-ascii?Q?SdvdBMjWdqZXEvPTxFUFFEv35I9kV/BrTVl57MUqI1PGRsV1gzLWLC2t0sNI?=
 =?us-ascii?Q?t9eJjMDMcBX0lTP49FR9/UTcinwFAQnNYLPi4DkWxUfmQRja5QFX9vrdbDz7?=
 =?us-ascii?Q?t4sV9wZuSgr1ZPrtJ7ME8RmEhfGESj0faIojFtT++sEbV+w7vXru1ZRxgF0P?=
 =?us-ascii?Q?tFL6iD/EPPIfz955QkqB2rekLFM8uwoERQKvGRIsLYvlEJGSzuuFj8UUhKTW?=
 =?us-ascii?Q?MyxV2xRX0BooY3tfxqrpKlkpCfeNYpayQQoU2F0tB3q3uS003+dW2oqDPqA1?=
 =?us-ascii?Q?XIl78rqupBl/EIAlR5eZs1gke3pT09UQG/R7+2AA+fHLyS8Q3Q1hVmkpt8jf?=
 =?us-ascii?Q?1Fqfjfp/vqHAvEulI/UhrGhYuG5sqNg3FKTBuo1qU5H1UzbiMZAtCWfMEyCf?=
 =?us-ascii?Q?NMqSFD340p+4XwcYs8H3yFIgrzar9tOwVMeSfWx1IhEDeDouEKPuFc1+9AsZ?=
 =?us-ascii?Q?yZA+gKj53bmL5y14ABPtL3hoTkfFQZ7R1m332I1LsAMCUUh5t+1vGwzuJqfJ?=
 =?us-ascii?Q?Xp4k4IFsNqGyo7WCd3EDEjVCYyO6EeZB1hAhJZA1noQg5McpY5uvErskZEPh?=
 =?us-ascii?Q?QnqzGmzBJc9NU+MC0APbMWJ5nei/T11B4ebPQAlc65bG1qMZtwcFQQO+PR/t?=
 =?us-ascii?Q?FdH66j6dXnkLYL8tDAisNdNgQNSvHs/zaI4l2bqJAt8YqqX6v61MIX6FxxOF?=
 =?us-ascii?Q?wMSZdqMi11XF+S0RFAKektjKImWgeRKWx6M5lDSRISkClRKeVOPsKhlKOJN/?=
 =?us-ascii?Q?+hEiVhmm8bojj9QE0Pjx+NcrVffc2Rzbre0yrFoNQlG8yE3OfwgMk/iA/A4T?=
 =?us-ascii?Q?WMugNNjR8sfijCOKaSBUya+Dm9+cT+VQEnObpaGQ+qwT0VEsY+FiimjWb0+d?=
 =?us-ascii?Q?XcuWeS+tqZZ7YajzBesfuRRUeRvpQ740odDBZvkMzpS8MhnMaSs3MmTrCtQ7?=
 =?us-ascii?Q?UquuL+3G5ewuWAo0oYaigmbOlsvl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ld9r2B/Xlehy0MkoWRP62eDFttjPgabEpEFcT//Xaxi1IRrf6lZwTcFgzpwR?=
 =?us-ascii?Q?drtRhQwfxbr1MlgwRovyOIvW+oChPPdzwhCZYBD6vMybbzCsH7RhQjxjFT7j?=
 =?us-ascii?Q?LTVWz5rvtyDfszrrnxsvZYPU4+Zujl+/mOie4acWT0JaHWdmAOzndRhzBhRa?=
 =?us-ascii?Q?wRXPgZ8X6J4aQazWengR9NksY2/qs+TGdXTaHRco8Loa5Go/eu1dzr92+A9L?=
 =?us-ascii?Q?Did5Hew7Zo5CtKJGgMqckshsOfOkNgYnx3wr+IcW/HbnNOwNJDAIVcaIIzeK?=
 =?us-ascii?Q?6JW+ooGbQS4lHlTp0YzOHd1if0pFj6sLOQX+X3DtVaNXqfRaCzNN1I3ooExI?=
 =?us-ascii?Q?tartDwEfyYdIW2kdZCvpkzlk55wZDhchwPZv3jouw6iM/sx0GEGwW9FvhJXf?=
 =?us-ascii?Q?ZGZ96PyOGtyKNJbP00bB34+0+xO7IM+fKZqrvdgzMpp2Fkz+8LvcIPZtEEpI?=
 =?us-ascii?Q?0sOxLb0rYXpbYg9vohf4dXWm86mXvL0PU46x6yP6Pg68klo+yEQV0pf8i1T9?=
 =?us-ascii?Q?uBm6i+3kSHwIDhygPNv2/OMut7/dVWForXaGEP5cSYB1b98HqbEygPLv3/fL?=
 =?us-ascii?Q?O9mVT+/xwK4haBAApTEzSsSA/rFuAso8+lLbWFE2TuJL67cteCtkBoAMc9Hl?=
 =?us-ascii?Q?f2tf34Z6pXdgtHCxQHoR4u48dAeQMzDxrC4tduEQ8Onkr7ImaQhdQ81mlg3D?=
 =?us-ascii?Q?KKQm8tminKOgRqFxpxogT2DcWL+A3siC6pl4zhsolrZssdnw8m4eVIJX8+Zd?=
 =?us-ascii?Q?iBwwrMBKf53dHZmc+kf85+q2Cs+hd3X2xCNaVxKPcepIa7kiKJ3HFr7Fb0hg?=
 =?us-ascii?Q?aw0ZqSx9ncY4AhL65j/OtSqGCPBAkiVJ5Qj7EVd3Rw88mPo4neSdXHwMkdha?=
 =?us-ascii?Q?p9moyTt0D1pnzSoOOzSm83Mvq8gyioqCWSPIh4b+g35EDJ41pXVhiiu7HRPT?=
 =?us-ascii?Q?9AXyt2w18ype9onp9HmOhJTNra8t+NFJP+lx1ghUzk/QBib5DCUy1nnPmtTF?=
 =?us-ascii?Q?eEMIW6DdKr2D6MCcxL7GeOV6+6japW9wAIcZcxCEFudDM8gUZSIBjToxcLV9?=
 =?us-ascii?Q?fIXobxy1vdU8NJ32lFdCiV1pMh2PjA8KWRzsq3Yc4sMzZI+52EFXw7rgx312?=
 =?us-ascii?Q?XTlOg21/25DvViW4tkuhOq1en4Pv0a5GfDOsLuF48r468SVkjtDCT5x8OWCl?=
 =?us-ascii?Q?ehwMHUL2XyNmaeElh0p6fqR8keges8eyYwQJGU9+V6GB3NkJ2YCEaanMMLcR?=
 =?us-ascii?Q?ZAuvqOdqrr/9+3HKYcrXcayPTRgwxjoEwLBZoOKd9tcoqbAMK+dIRG1ldFtD?=
 =?us-ascii?Q?FMebCSVBr5HL8PpHGvZsjEIZ6X0p4Vd6wqdDSAagdGuYOpO9q5ySx4WSEzNQ?=
 =?us-ascii?Q?A7k2if/8SmnnJKvBcm5gwZMhd54X8TKYznOciDOOq68EpNZCUBH0e4C6lmiB?=
 =?us-ascii?Q?uSkpHbnDKOobIWNd89uzKqiFVWxqRm22XV+RJcgpJIm1S05rm2lSOxnA0vA+?=
 =?us-ascii?Q?g0jVLfSDF0k/skPd9FC5sYrc6HCw4GwxQPFVgGkOsWR3VYbdowjZf3gpuREF?=
 =?us-ascii?Q?ifZCRgV0WR3DyIcQsOevjqtr7zjBqAvWETlEi49xr0rDGl97IbuXkvFKYXEP?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3588534-2501-401a-12c8-08ddbf5da2fb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 02:58:24.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVv5IWPK7p0nKcvv71m8m4p7JidbZIXHunAXdOHbdNOLnEvxG1Fsxa7iiGdhAXH8MmRQMX2s4CHDybES+Uw2Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7453
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 06ddd17521bf11a3e7f59dafdf5c148f29467d2c ("sched/smp: Always define is_percpu_thread() and scheduler_ipi()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/core

[test failed on linux-next/master 835244aba90de290b4b0b1fa92b6734f3ee7b3d9]

in testcase: boot

config: x86_64-randconfig-123-20250702
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------+------------+------------+
|                                                          | cac5cefbad | 06ddd17521 |
+----------------------------------------------------------+------------+------------+
| boot_successes                                           | 20         | 0          |
| boot_failures                                            | 0          | 18         |
| BUG:using_smp_processor_id()in_preemptible               | 0          | 18         |
| BUG:using__this_cpu_write()in_preemptible[#]code:swapper | 0          | 18         |
| BUG:using__this_cpu_read()in_preemptible                 | 0          | 18         |
+----------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507100448.6b88d6f1-lkp@intel.com


[   25.232998][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[ 25.233645][ T1] caller is __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2789) 
[   25.234128][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc1-00023-g06ddd17521bf #1 PREEMPT(lazy)
[   25.234931][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   25.235357][    T1] Call Trace:
[   25.235357][    T1]  <TASK>
[ 25.235357][ T1] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 25.235357][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:53) 
[ 25.235357][ T1] __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2789) 
[ 25.235357][ T1] ? __cpuid (arch/x86/include/asm/paravirt.h:179) 
[ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 25.235357][ T1] vmx_init (arch/x86/kvm/vmx/vmx.c:2808 arch/x86/kvm/vmx/vmx.c:8653) 
[ 25.235357][ T1] vt_init (arch/x86/kvm/vmx/main.c:1072) 
[ 25.235357][ T1] ? pi_init_cpu (arch/x86/kvm/vmx/main.c:1067) 
[ 25.235357][ T1] do_one_initcall (init/main.c:1273) 
[ 25.235357][ T1] ? trace_initcall_level (init/main.c:1264) 
[ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 25.235357][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 25.235357][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 25.235357][ T1] do_initcalls (init/main.c:1334 init/main.c:1351) 
[ 25.235357][ T1] kernel_init_freeable (init/main.c:1587) 
[ 25.235357][ T1] ? rest_init (init/main.c:1465) 
[ 25.235357][ T1] kernel_init (init/main.c:1475) 
[ 25.235357][ T1] ? rest_init (init/main.c:1465) 
[ 25.235357][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 25.235357][ T1] ? rest_init (init/main.c:1465) 
[ 25.235357][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[   25.235357][    T1]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250710/202507100448.6b88d6f1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


