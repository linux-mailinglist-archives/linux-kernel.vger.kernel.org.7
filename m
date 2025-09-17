Return-Path: <linux-kernel+bounces-819854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752FB7CFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2FA5231E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 01:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9F219A79;
	Wed, 17 Sep 2025 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCXzIsKh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE1A55
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758073082; cv=fail; b=HQ+2CX+40b0xg90tDINTFnd4C5t5bXcCWMceml/xSUNfc/f/ham0Likt+d/5M0tpMH526PfeyXYSnkz7ikQXpiFd21UBB6V6aiJHmK9i+sb7LaE+9JurHHlQdFSY/LPdmqZEGkYoYDYHPEfubOXwUkkgMz6wFx6YlB1QXfifZ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758073082; c=relaxed/simple;
	bh=IQc2H0L09k4ZmAhqZ6AbO437WdHkkKtQuQx5K60Bx6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrAfNJ4oJ6VW6rAH1dGvPsQSqielD3+KiS4w/OY9dpt1au65SK/r46CvlJT8Ai3I/Rl0QHDewxRCFEkqtvqyOrRIHwUYv8GuDirVr3mnEQQhh2279jQfy88/km+zDm31tzuAY+MqkJYtwBNDcIDeBRBpt195OUg6AWcVqRBm4eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCXzIsKh; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758073081; x=1789609081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IQc2H0L09k4ZmAhqZ6AbO437WdHkkKtQuQx5K60Bx6w=;
  b=HCXzIsKhzTYo+akM/etidBxJ97Kma7z719w8Ly/cAqscRBFX1uWieHo2
   ixxprTjJ3HzjIEAHxXKGUEYFHUmf8EfW/WAP8rmBqJrIxkvLrNZPITpLa
   aFalvEqDy7CljgUE3nWTevVL+SMxQuFhMWvkG5+Zt9eXWGx062Q+YB7e6
   ZqBokXEj5L6CjelxsuliWQa4itHiyw/zbd0r21galu6HTHR7v78NKFlX9
   W5XzEEa1MiVi+0Axifb+BWw+IHrb8z7CyMXQzNZ2gHA02019Hs3tJYbeI
   UsExjdbn8uy5jX/tDJa1w9h4Fwc0MG2MJdIj0cZ8g5IIs3wCMljsJtjQw
   w==;
X-CSE-ConnectionGUID: UJ0F08skRdacmpyrcDp4IA==
X-CSE-MsgGUID: lmZRuQD4RMmw+QSlNZb7iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60316786"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60316786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 18:38:00 -0700
X-CSE-ConnectionGUID: 2zIugeQIRMWfVl1+In7x+Q==
X-CSE-MsgGUID: jeDmdV5BS46+5Nq1G/GHmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="206057235"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 18:37:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 18:37:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 18:37:58 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 18:37:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaDekfFp2I8ss60VvHnB59gGQpYkCdM+0fp7Wzqt8ekREp/WMF2f2qXyG0qATFeI3OI2PvdDq15UWbaNc49BrDSC7vPK+qnhAm+zVsN2gzbGu+JNBw8N2DKix3vWIY0lYUCOfkI4s7RgjYGm8KSXeOmgrCxZas258B1nAbvg6W6N2JkmifXyYfFNhfUUIP9lNLqiiuC0PrwXD6YY3IjFk3Hn+d0oMfyvUhh1xmvbtKwSNtKM5v1zb5plsgYY12SvQC6kcKY4d2pNoxQAbse2t/JO/cz5EcMkyNKctF8es51fki6fFwsw7hkLizPD5g4YGKKdapkr6YDwhzmXsg+8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZX/C7bK8W4FCg3SrzA8JSoDRCeiZ0+sL/qeMvvSYMwU=;
 b=MyVeOh4bG8NtueJIXN0iHmVCTJxYKkp9sDuV7X2i0X+CjOqD8YPooCGoQQq6SHsXTxXaNBU6mU1LNKx0DLjVEcSXC+G11CCaobATqWNSWwwlsHdJLP5p1TjBV+27+ptjZilQXEWCYUeJv/XZtUM5R8XP3PB3lu5M4NBtayjyBPagtVp2VQ+AeyD+18D86y0JJxdVDzrO6T3Lsswp13z7Vbn69P6f04l/lsax0Xfo6kNVY8WF3mMf7UmbYV450ycyS0zs1zdW1KxG6174NP61c/N6ZdKv38Y7Yfp16o8ABTzFrv/ngAEJNpPeI92UmjdB2JMhTlA8JAGgDyIVML34eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6457.namprd11.prod.outlook.com (2603:10b6:208:3bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 01:37:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9115.020; Wed, 17 Sep 2025
 01:37:50 +0000
Date: Wed, 17 Sep 2025 09:37:39 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [sched]  8671bad873:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <aMoQ45j4KniTXv9H@xsang-OptiPlex-9020>
References: <202509051010.e06823ab-lkp@intel.com>
 <aL8NGXiYUAukMCGY@uudg.org>
 <aMoCYelz87V8bSzA@uudg.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aMoCYelz87V8bSzA@uudg.org>
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: d0400260-21e0-4994-3747-08ddf58ad008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XNu/5k/LDOrws96QeS5crkR8S+oftRnfBMl+f08tR8xxiRVJ9cwHPWeUuRc4?=
 =?us-ascii?Q?VbUsjgGNtEQ6kbu4hNkjnuLBhol1P3F+1aR5eze6LMjGMG1iZxkjLuHaINEs?=
 =?us-ascii?Q?UEOB3SEjMPVslruectYJHg1HrLr4XVvxy2HXdyLVgPsp0Ccl/r2lIzUDqKEZ?=
 =?us-ascii?Q?k4hpr3OnNQICvfnYRirW/rGWDGjxaL8FclygKoHO2xv02WsdiZ/mirtlxmb6?=
 =?us-ascii?Q?oAO5IuZwMRDEzbj3boAktYVQ1AdSbMfoHrHMMG/GyvY4U03IuRbAB1KGolqN?=
 =?us-ascii?Q?gn2g+n6dNG8pvUnCoCCz31doRqrtbXN/0f1p/Ka+sR7WuOiAUpYJSwAnh+zR?=
 =?us-ascii?Q?dpzWTiuiWuWkSwJV9/9iCbRMb/csJ/KGgp0GGtlfjF3b+ddOhPnoHP2JWJDE?=
 =?us-ascii?Q?YXndHUCOcei4kSOaLggluEXXSw3JIsmc1WZiwxX7Mr+VXC9YSQO8NeuJlYB7?=
 =?us-ascii?Q?LSiEaITGpHG5pjCqhVPizTyuQXdhw/afBpv4Dj/Atl4zcSRKluaBBtBFUmlL?=
 =?us-ascii?Q?W95XJhyWEnc8lOG89HNU3X6Nb2tEbUF1M2BzXh/OuxFIoIgSv1DSKSFWEZBg?=
 =?us-ascii?Q?H0Ezfvw+IPfUSEZYI7UJMix6eWs2zuXsdxGPOgYDEOXfQ8u7qut6mQArtWqs?=
 =?us-ascii?Q?tQzEx3LGXI2sndmDVBtJXQ9l3OALyS8FMz0QK8z3LlhsftSKju83by4KSSG6?=
 =?us-ascii?Q?v2LvqhHb9WD8XoWjzX3rSE+yN798EnxhTC1GOiGDkXg66rZj9LrkJGaRjRO9?=
 =?us-ascii?Q?ZZNEZ0IvxroEECD1f7031PZzASk+MatId1VKX0yf+8uCAIoh5J7DRidsSbzK?=
 =?us-ascii?Q?XDDEu/rw+2+q2wXsN9KmkI5kSxXFveKghlcCGUaJ84hTFkUcVDXWDN2fB9cl?=
 =?us-ascii?Q?tg+1dgrg2jKdDSFJCqBUYp2MkQp/iKCmImnfdXD0P0CFzRuYbpA3meurU101?=
 =?us-ascii?Q?guxUB0aiEKiE4fXLv36fUlKEoSNMUJ78LtxIRU/dEHlbW+Fmr3hfC7B7eZHJ?=
 =?us-ascii?Q?lB2hjtNzZ980P2gwyneUI7mLKHHFzNBOdMOLft9JL0C67WXE9zx185mQJL1G?=
 =?us-ascii?Q?us83hdkhYBDTBan1vPlWf3j+1ceUnCTBbjeBfKCu8Fnwe5VpTJI9rhGGX8zu?=
 =?us-ascii?Q?U2C/2WKQ0SdCX1LxlLlXpznkna0L02lHRUWyS8pPqeblsYFustdWLEgD0WOI?=
 =?us-ascii?Q?oQqeqMOgCpxUjOfMDSo3Cyix6bSBMJZGSEPpSzE1hw/oWri8lX90+ivrcFlK?=
 =?us-ascii?Q?2gQBnIDpuHeBAjI9zOFV9HfWbJIgSjMRoARyvQDexw5WNYJgDHBnLRLJEI8T?=
 =?us-ascii?Q?hpJfTKxMiY9wpnr97z44kmhNJrd0kArBxgaOzjz3eVVgX1OWC6U/P9D4AqDn?=
 =?us-ascii?Q?90p68zuh269u/RTxBKPESHENawUj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3gHmEfR3pqbbl2y5Jwmq85oVrb81f9Z2LpqUyX4Zh7jpPXZqx9xQBpVtk6Iz?=
 =?us-ascii?Q?mX26sJlHRYwbH093LVK++1bv23IBJYLVcJ4rdMTRSnyUb1sNwCAqhH4l+UbF?=
 =?us-ascii?Q?S6drNM/jKo6qkCSP6TZGN12QwCdhsWoLnt2KGaS2ElDPPIX/uTnVQwxZGfC/?=
 =?us-ascii?Q?oW8kv6m0bIHz5A0MJHdtjwpQ30wL4Pt8wzQ4NoYWnPhm14ZEr+4lNrjIo5al?=
 =?us-ascii?Q?GYTG/N+XLM8vWFwKx/iz+ZwLe6h0fnpb1IgumKXGyUu2J2gLhzXIuFdOyKQY?=
 =?us-ascii?Q?BUn0O+PKfwq6cJ4C9/obdn/bHgBqQRzmcsRJUDdhpmcLcvNVasD0wC0d9JUi?=
 =?us-ascii?Q?g8zBxHkLlglAR5PaB6NwxLQju5TiLBmvZKARIW3jad9l6bzw6/pkGqJUHpbX?=
 =?us-ascii?Q?oDykDCtDwHyg/MhFBlHBBpjd/ns8yThiO+0bdmdEIOn4F2PRYMuhgA5eW2cx?=
 =?us-ascii?Q?kIwDN7aHo0uYzlm+lPR6pw6fdtPPHiwMVi8Nwg5aSdrA6cWz3do8QI7vs+Bq?=
 =?us-ascii?Q?EqGVz0KArr3zz2u+NyNd+7krPk8Qi4wsIyx3a/8krXnzg2dv2ZNTLvo2nTW8?=
 =?us-ascii?Q?1car9olfDgQ/756zuWlVFSYL25qnQM3Saa33sjWt6oc2yVaUjSNhBF8E4Ogg?=
 =?us-ascii?Q?Z6elfw64EIUkNhGyaNGR1iVZaZRR1P987uhGaWGeCjNsLkU7XcIWQAqcHL40?=
 =?us-ascii?Q?fbvUIB90bv8RqUAm8AkQIAjMnsGleEYfLB3g9x8s78nqBrVxM1530U5iwClB?=
 =?us-ascii?Q?AkucWbV9jzXwNFuTwHUqVcN0pweNY/BgCZ68IU17UrXJEocshqyb+sAs8X4p?=
 =?us-ascii?Q?YrBom0hnhyoxYDbfv8kjXPfj1n7n+FNKDv2m1cgGeZXc3HRaoeRMijlpIIbL?=
 =?us-ascii?Q?kLWmjPIc+evELmQ/H2GHA32J/HF5241WuHvu+6fZbsR2Oi0Fx2ICeWfN+w/u?=
 =?us-ascii?Q?wtxH4jOdQSIVDZLDqOjYPqOdISM5NPT6sF7JKTV44h1QGyMxRefha3Gh/uu4?=
 =?us-ascii?Q?4FJIVbpEvr/0ThdUksx4rSSSFskVaTM4WDiV5J6ojydihJ4APTkRF6JHqOB5?=
 =?us-ascii?Q?Wk+HT8UODXyAar+QXiBPSqtyAyUGHXqISMQMI/01cRPGpIw+Jrg1nXiCibYB?=
 =?us-ascii?Q?EpCIGr0K0BaN17VRpi6S2Bp7Tfkd/b/VG1szStNUp8iQgRztaC8cPVIvQuyV?=
 =?us-ascii?Q?V25MBttsSPkppNfCJtgTb+ReoF5oGkYvu7SS8YNqdFvmOo5g2TcUictSbsSq?=
 =?us-ascii?Q?Bazv/ZcaTR3Z0SbJfWlmsUC1K+RHMs5eg98Er/pZ5V0cnwsP8ue9ob0b16/E?=
 =?us-ascii?Q?QKS/k0P72hJWdJTA+USI8fPJ7VW1TAxnQNggn7hVka3Qp34xlZjrn41nJlGE?=
 =?us-ascii?Q?04xC22YgwaAyTJz+dUzvVK1XZvolYweeP//zauTNOAQdbYPwsB06vtQxabbP?=
 =?us-ascii?Q?BtF6I4f0AEDEW8MfbA0/UxEmheenSNR0Qw9KmevaBqvaUDLTlSoUVyYqljZo?=
 =?us-ascii?Q?PISPVnKjVrMQEhTYxKRqH93Y5AiGxOkQsweWLHRU9uMrOU4qD89U5w8LRndd?=
 =?us-ascii?Q?PI664ihs3T0KBeeET8R9nV0HgGJho/2AiQMywvoMae1PefjUd3N+8ViL5iER?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d0400260-21e0-4994-3747-08ddf58ad008
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 01:37:50.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SngnpNq82V4SyZ87ChdX1Z7aa65Vw5mClPmSRz3nXOUc0upUBoC+nH5YuSvKdqy2VSHkCMxDJqz+Ovfdah1bGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6457
X-OriginatorOrg: intel.com

hi, Luis,

On Tue, Sep 16, 2025 at 09:35:45PM -0300, Luis Claudio R. Goncalves wrote:
> On Mon, Sep 08, 2025 at 02:06:37PM -0300, Luis Claudio R. Goncalves wrote:
> > On Fri, Sep 05, 2025 at 10:49:35AM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:
> > > 
> > > commit: 8671bad873ebeb082afcf7b4501395c374da6023 ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > [test failed on      linus/master 08b06c30a44555a8b1d14950e4462a52bfa0758b]
> > > [test failed on linux-next/master 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7]
> > > 
> > > in testcase: rcutorture
> > > version: 
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 	test: cpuhotplug
> > > 	torture_type: tasks-rude
> > 
> > I ran tests with the boxes I had at hand, x86_64 and arm64, and was unable
> > to reproduce the problem. Tomorrow, when I am back from a holiday,, I will
> > try to reproduce the problem with x86 (32 bits) VMs and x86 baremetal as it
> > seems to be the case on the report.
> 
> I have been trying to reproduce the problem for a week now, on both
> baremetal and VMs, x86 32 bits, without success. I tried to limit the
> amount of CPUs and memory, to mimic as well as possible the test
> environment but that has not changed the test results at all.
> 
> Are there any other pointers to reproduce this problem? Other than what can
> be extracted from the log excerpts available, I mean.

if you have any debug patch, we could test it in our env.
the original issue is really quite random...

> 
> Best regards.
> Luis
> 
> > In any case, I sent a follow-up patch that isolated those changes to
> > kernels with PREEMPT_RT enabled, as initially intended. That should solve
> > this case (if really caused by the commit in question). The patch I
> > mentioned is:
> > 
> >     [RESEND PATCH] sched: restore the behavior of put_task_struct() for non-rt
> >     https://lore.kernel.org/all/aKxqGLNOp2sWJwnZ@uudg.org/
> > 
> > Best regards,
> > Luis
> >  
> > > 
> > > 
> > > config: i386-randconfig-017-20250830
> > > compiler: gcc-12
> > > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > > 
> > > 
> > > the issue happens randomly and we observed various issues in tests by this
> > > commit, while parent keeps clean.
> > > 
> > > =========================================================================================
> > > tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
> > >   vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-017-20250830/gcc-12/300s/cpuhotplug/tasks-rude
> > > 
> > > 7de9d4f946383f48 8671bad873ebeb082afcf7b4501
> > > ---------------- ---------------------------
> > >        fail:runs  %reproduction    fail:runs
> > >            |             |             |
> > >            :200         16%          32:200   dmesg.BUG:kernel_hang_in_boot_stage
> > >            :200          0%           1:200   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
> > >            :200          1%           2:200   dmesg.BUG:workqueue_lockup-pool
> > >            :200          0%           1:200   dmesg.EIP:kthread_affine_preferred
> > >            :200          0%           1:200   dmesg.EIP:lock_release
> > >            :200          0%           1:200   dmesg.EIP:tick_clock_notify
> > >            :200         12%          23:200   dmesg.INFO:task_blocked_for_more_than#seconds
> > >            :200         12%          23:200   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
> > >            :200          0%           1:200   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
> > >            :200          0%           1:200   dmesg.WARNING:at_kernel/kthread.c:#kthread_affine_preferred
> > > 
> > > 
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202509051010.e06823ab-lkp@intel.com
> > > 
> > > 
> > > [  994.935251][   T26] INFO: task swapper/0:1 blocked for more than 491 seconds.
> > > [  994.947414][   T26]       Not tainted 6.16.0-rc6-00086-g8671bad873eb #1
> > > [  994.951523][   T26] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  994.960576][   T26] task:swapper/0       state:D stack:5016  pid:1     tgid:1     ppid:0      task_flags:0x0140 flags:0x00004000
> > > [  994.972581][   T26] Call Trace:
> > > [ 994.998429][ T26] __schedule (kernel/sched/core.c:5354 kernel/sched/core.c:6954) 
> > > [ 995.035758][ T26] schedule (kernel/sched/core.c:7037 kernel/sched/core.c:7051) 
> > > [ 995.044863][ T26] async_synchronize_cookie_domain (kernel/async.c:317 kernel/async.c:310) 
> > > [ 995.050698][ T26] ? do_wait_intr (kernel/sched/wait.c:384) 
> > > [ 995.059798][ T26] wait_for_initramfs (init/initramfs.c:778) 
> > > [ 995.067798][ T26] populate_rootfs (init/initramfs.c:789) 
> > > [ 995.070767][ T26] do_one_initcall (init/main.c:1274) 
> > > [ 995.074441][ T26] ? initramfs_async_setup (init/initramfs.c:782) 
> > > [ 995.098384][ T26] do_initcalls (init/main.c:1335 init/main.c:1352) 
> > > [ 995.136744][ T26] kernel_init_freeable (init/main.c:1588) 
> > > [ 995.136744][ T26] ? rest_init (init/main.c:1466) 
> > > [ 995.158663][ T26] kernel_init (init/main.c:1476) 
> > > [ 995.177750][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> > > [ 995.178146][ T26] ? rest_init (init/main.c:1466) 
> > > [ 995.230129][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> > > [ 995.230129][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> > > [  995.268743][   T26]
> > > [  995.268743][   T26] Showing all locks held in the system:
> > > [  995.336987][   T26] 1 lock held by khungtaskd/26:
> > > [ 995.446697][ T26] #0: 830cce10 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks (kernel/locking/lockdep.c:6768 (discriminator 1)) 
> > > [  995.464546][   T26] 4 locks held by kworker/u4:2/29:
> > > [  995.470758][   T26] 2 locks held by kworker/0:3/38:
> > > [  995.498593][   T26]
> > > [  995.599251][   T26] =============================================
> > > [  995.599251][   T26]
> > > [  995.729940][   T26] Kernel panic - not syncing: hung_task: blocked tasks
> > > [  995.729940][   T26] CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.16.0-rc6-00086-g8671bad873eb #1 PREEMPT(full)
> > > [  995.729940][   T26] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > [  995.729940][   T26] Call Trace:
> > > [ 995.729940][ T26] dump_stack_lvl (lib/dump_stack.c:124) 
> > > [ 995.729940][ T26] dump_stack (lib/dump_stack.c:130) 
> > > [ 995.729940][ T26] panic (kernel/panic.c:382) 
> > > [ 995.729940][ T26] check_hung_uninterruptible_tasks (kernel/hung_task.c:311) 
> > > [ 995.729940][ T26] watchdog (kernel/hung_task.c:470) 
> > > [ 995.729940][ T26] kthread (kernel/kthread.c:464) 
> > > [ 995.729940][ T26] ? check_hung_uninterruptible_tasks (kernel/hung_task.c:453) 
> > > [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> > > [ 995.729940][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
> > > [ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
> > > [ 995.729940][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> > > [ 995.729940][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
> > > 
> > > 
> > > 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20250905/202509051010.e06823ab-lkp@intel.com
> > > 
> > > 
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > > 
> > ---end quoted text---
> ---end quoted text---
> 

