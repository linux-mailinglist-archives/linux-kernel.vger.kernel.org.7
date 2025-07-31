Return-Path: <linux-kernel+bounces-751732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F8B16CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7B33BEBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C0208CA;
	Thu, 31 Jul 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="en2BCzPv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2F2BD00E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947729; cv=fail; b=GlxcaiEozMd5u6xkNrB/HJns+eCXlrQ+OkUYoc4/jJrbwDKRMt3hycbHyRbWN4KnOZWs6vCFYUjpmMk3TKvqgecTHwg5uTR2BgHWfDtPl/6YIBxXWFt823h0lJpaMiBURQhUTXmZEVH86LqYVrVjFwjOtxjpiipLhUZY1zlHsIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947729; c=relaxed/simple;
	bh=oH78EcjIiw1zIphdpSOxPR9smc5Nah5+mZ3eB45QzL8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WD923giJFhVCPmuDCZEbklh+qfFp+uqTi69uyHEGpwCFaBilNBlIuuNgAavPKw/dAzKFRL2tObJIExFppKDK4rPQrdnys5MovXKKXoWG0IZBSvLyzv8aqvypySi/KViSe0S/8910rD9WWI1LOgmsHU8xhKJ3S5nywzKKjoODNFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=en2BCzPv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753947727; x=1785483727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oH78EcjIiw1zIphdpSOxPR9smc5Nah5+mZ3eB45QzL8=;
  b=en2BCzPvh2AM44PZnOr74XqmJr8n98edYPhKMgnLl+VwdjC9E7VWkJ1f
   p1gddglcNt5G+1233skoaggHbWQUrQ4mjem7W0/tvY/MUyhmPtkVlbJng
   +D+enu6WGgjyhPhtTDV8lKVLDeZS73u+I0v6tJNObq3eNxHNBhJaJUp2H
   Ml2Ygfncr8PzSxj7pQrRuoAZ7Yvd7ZPlrNZ69c0f42+sIkZKNBgKT/DBz
   QM7dU32/RPGaKhZEQX5nfMJnv+im0vumF4xeiXKBhwoJdWkkTb4btxGG8
   qPgTvCRY/IrMo5l5zFXYdO/mCpecVZa7CZp/oKTiMoK1G5jlCTb9+8epZ
   w==;
X-CSE-ConnectionGUID: 5/jcOYvyQjGzWM3ZBM5nXw==
X-CSE-MsgGUID: QOp4iNPEReOZri/TBsMsWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="56339512"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="56339512"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:42:05 -0700
X-CSE-ConnectionGUID: PSFw42vQQCG0nXIaXs0Gog==
X-CSE-MsgGUID: 2l5aFv2pRM2AEDqTqFXF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; 
   d="scan'208";a="168590732"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 00:42:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:42:04 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 00:42:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.41) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 00:42:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KItbX2Vy17vwbiRKDiOQeyNOu25sZ+jLQ/Yww3RHrwk/EGmZRd71zkJzpXiIO6PvArvugE5WkBzl2DTQIW8iPL1mDA0yBteZPpSqvnnZMoEhzrJq4ilsPxbqE0lLSeoBzxB1OYYAqruWu5mGitXLY2rb21/XBzh0S4QzvFLKgelUMpnx7qRnuSSGL3s9hYmoBwoR9KFCLa+VSK1Hbh1AixnYIBbsfqEkKMmtAzXb7WOeaD9MRrtIcBEJY4R6qBG199XTwE9JayS/vrl5MLaeqLjlUGyIlQOZS3CrpO4eNuJQ/FKQkhzivnM6gpK7Po1ec/cWR/WFbZwTIz5BY6SdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1EL4UEeSFoKfv/kjSHPGiv/NJ+yhalv4Qp3KwrESmY=;
 b=bLk8OUSkYzsf01nOqc+ebYQ9cNhJYVLYxbatlFVvkeXtdfpV2k84nLy23TcCiT5d1FM6kJPW6vR/e9B0cVGXDCDV0LuNDGMWMli3OfpY8SgzeBrk5f7sOeKuDiZSN5NkkQ0AQKtkR+lOXsjbaIZKfdTfpq1vaNND2dDUZP3i9YK+o5/HFQTI7ctOrJ5Dxhp1MS96iM25wdQ/oWfEDEvEXt2vZZ8FfLiIzhsLmjrOZ+hYy9jTA2iAHhrjr1t7+SuMLqVjT6EDTdaf6L99NQsVOqdhK+PZ9NtxJAXE4k1Z2ub3i0xBKn5fMwd3D6hPFNM1VZ6DB/sd02ry8byNC/QErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 07:41:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 07:41:22 +0000
Date: Thu, 31 Jul 2025 15:41:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ingo Molnar <mingo@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, "Valentin
 Schneider" <vschneid@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched/smp]  cac5cefbad:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202507311445.69f901a3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::30)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc21f54-bafd-4965-7b8f-08ddd005a510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lobf52vWt6lyp/pzkt4oEEbFbb024xh9VWC2z8RzDcKAjS+1KUreNxc1hR5y?=
 =?us-ascii?Q?DDVmDo+soXamup81TySu2QNbXaufYJUl8t6cReVLvejczlZQugTLeZ9P/DQz?=
 =?us-ascii?Q?5PFgDiCNhvQNN2QUT4EsVwiQeTLFxDzL62CN3HiNwUgb8nDUkiK6VbJ/qdnD?=
 =?us-ascii?Q?350mOWaWOlV1J5M5il5nguJyYVm7DChod+A2b5QiMRAOv1t99+cvyiqie8md?=
 =?us-ascii?Q?8NdmITKU6nsgqHgAH1VpIC5EKr/HUvRlaPvA9x7W4pVjgJzS8vJYm7aW2sia?=
 =?us-ascii?Q?A1GP/6pNBClvq10eRyew6RMd5M/s7W01u7ZBACy0FODdQrLPioFlTePQBSfp?=
 =?us-ascii?Q?11SUF2mV6sRD/6r7O3Gs5xkXI+8sWFKXNvHyRa01VahKImGbfefYoZqj1csA?=
 =?us-ascii?Q?HZFM0jQtMU3dwXpkA41jVvVAAwL+GutfgQgZT5LMM8JX3/glcFe0vV70+ix4?=
 =?us-ascii?Q?kQnebLpnhmGuqu4Yy/JnmkjenE9jfAuwkw95yzoOXO2XwTMZnUS9Ep/bgx8P?=
 =?us-ascii?Q?ELWn1y8oS8df8gkyXv2shlSBNlwtMwkw5YimEAHOx5NGh6bdA84KOBGQWbB9?=
 =?us-ascii?Q?h4zu7U6ezlLsqZwH9VyOU4DFaKP9HvbmAvoTgnzw37Dw81vStvekPX1t6aJJ?=
 =?us-ascii?Q?xEa4mkSZG5u2eOY/eEPYHIZl6P2t3ppt2SKmoCTcJEPu9ppLI1FQhGSJ4OJI?=
 =?us-ascii?Q?mrlNZzsjNLuUQ4jM+NAgAHOO8h0I2c3y9kGgNkoJW065ohOeNfwylfSxZ40G?=
 =?us-ascii?Q?zZ03DHqwUiiAGtRawqUnr4VZgpBjAYAwYoxcWexVHli4aGeVcEyjo1axtZGD?=
 =?us-ascii?Q?n18n2/SbAv49Tgn4ObuDWm7YRemdxBoYysuc0i9RHTzrlwzLq5d4HG2++6x+?=
 =?us-ascii?Q?AdQvNN5pdmydCrIkCl/1VsPTk2nyHzPpxwj+HESEaf3BuH6KnTnkiQL5bsML?=
 =?us-ascii?Q?fp/NVKleKQFdhI6NG4a5xx4KKYcuLBS7tOYT9j5jOhjW2xOliBZrKVpvjd7i?=
 =?us-ascii?Q?7oP/2jWy0wL5i+QccA92mEu7dfROVbW5JWgp0BkiDlIt5dCR8kI8v10VCb+K?=
 =?us-ascii?Q?DZ8BGv+rwMbiKh0ZgjZiZJ5RXhQTEyFSn4fHedCbePjoYzjXVF8gjrXFz8Jv?=
 =?us-ascii?Q?4mbSmE3Wm6/DeYqCiL4sfAQ2gj0s8WUwAP4E9xAejcbtO3H9AlQU1Fh3w6Ap?=
 =?us-ascii?Q?pc/Okw6sNFPsC2MY8yLPb57X/DQi84zlXHX6+J3T8snSEwHUKW2xcRDEsNrT?=
 =?us-ascii?Q?uGHKyt6jO1LgCdc3t63liq9oVsKC1zBTbImqsyoTPMuteH967/fgjRAeBBlS?=
 =?us-ascii?Q?Q0CBDKWdpNBi6vlZMb6sHBgt51DerbEed3ZIqA3pQFe3NBMJnqZ8BUVRU9RW?=
 =?us-ascii?Q?SD1UvHSwQmWYR4XFG6wSoREGollD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZjyT5q+EOxTgCe4knZNTkxaotS06Tcsp6OkHl6TTN+YEdY2vHOw+1lffg2S?=
 =?us-ascii?Q?0fnqcRogBcxgiJV2qwvhbetYvPn9EOvDXnCh5R6/Bs/wh5eciN+mBaQ6cjUC?=
 =?us-ascii?Q?wUbsDv+Rbp9Tim2C78ECMgBTNYoyVsQ2OkDcewub6HJJSHNbC5sOIJbbc05r?=
 =?us-ascii?Q?nqVtIP1I8IkLTLN94UxAcYuLvDokjhDmC9Rpew9RA9ur4Y6Gnewbp1VJOCDE?=
 =?us-ascii?Q?l0+UghQ/0A64NxrqzqCnwFEdLtH4lUlGOjyPCwrwrMDwBo4quVLGM+KntTeV?=
 =?us-ascii?Q?Se/8FjqMIfXcB55Dbu12x7svetpFSsu9/Faxcl4/MSu6If7DeMiE22CiYWvL?=
 =?us-ascii?Q?TgW4DEpQsfgC3WdLYAdYiZdsghLh89O2U6WBN1w2g07d1CWtMay3qUKllIGA?=
 =?us-ascii?Q?rLv4AQIWc05xbeJLud4V4BrTZREw1vKIXj0FcZkA0DkyqG7rRb2/pAXu1gak?=
 =?us-ascii?Q?l7wEvbR5dg5lEqgyv7fJyzCW3NAUMPl8sYSkuxakhWqiNsFRJ7eDcC53Dc33?=
 =?us-ascii?Q?v6QPlWgjvnbOapQxYLauHRMr4nPXh7iIKwLrca1qW3wGVAsVysiZ0AMYPCRL?=
 =?us-ascii?Q?5NzVZ/DtN0bxFz79kbc5ogEXwiXaFzK7Y286/Gt/WaC8LFom0owXCkJ2j3W+?=
 =?us-ascii?Q?yI2cBLZJsg41eFEt1I8vkO8Gm3auBgT0fshKHXk8v7pDL38bx9FiArcotFUn?=
 =?us-ascii?Q?ghnNi7V2ZwI4fgKdkCDprAWdFt5DHqKftpk1jQT2WN7IV+f+OutJLelXVVVi?=
 =?us-ascii?Q?J54AUlaDVX+jMplOtdTRJgkLyBWLb575OA5ugUZXBEKZHJMN2+UaBXlnmXQq?=
 =?us-ascii?Q?lytwc7gNR+13IskF7WcxqKqNFh+JZ6Ecx1/uHrFbPMclliFoUAnK/D28v++a?=
 =?us-ascii?Q?iQNXe0PPRUgswU44BLaEwcCmOJdVoKYPraM4jfIvRQlisk6hs+r5y2VnGO19?=
 =?us-ascii?Q?Dedyz3z+JsHAxg4NsOB/YpZ5+ycGbK/N+jGATvA6bOZ97XAk++rIHsjBCBBg?=
 =?us-ascii?Q?oMNnF3K25nFEJ7UwCx8rDNMySltoPt/Z4utIH/GBAfIWghihfBkXv9VO8KV2?=
 =?us-ascii?Q?RDbfFu0f0kdx6umziAExYFEtyIjkYveM7tGo6jA3UDtpNHnIkxPH90YMVvh6?=
 =?us-ascii?Q?Nk50b8TaD6VmbVzmXKHEbull5wI6+W0jlMXMEXd2nOkd6NzUputJVH8c7gz8?=
 =?us-ascii?Q?4SW96uqwmowRW4tU7cG5O9afQkhcJhmgW+Zq8osKGDCNWC1O9/bUQxdsBQG/?=
 =?us-ascii?Q?Qd2P7fHn6JyJClcwJ64VMBtvjoGOaZm6WLHN4i/66PLYdRFnbfDzyHxmBlye?=
 =?us-ascii?Q?A8iIMaOV3PmVAEJWwsJpkbI4OZtELC/eenWhV2+RqqIyR7i9kbG/PtiSpq2z?=
 =?us-ascii?Q?jVWpJotI/69niusR5vTCfpTPYlHbgZtbI7sduJf2T7kod/xnzr7BNn6127EM?=
 =?us-ascii?Q?xAuNQZl7dBVRq6aVWTrIX+qfScoEhNfHDtUzRM88JYEjigEVxm+kUsjqskz0?=
 =?us-ascii?Q?uMrmmaCO0r5sIHc1eOza3Lpo58rk8Srte5rjMg3/kZDi1QJ81b7n75kZ9BuF?=
 =?us-ascii?Q?AV9QaqO1DglWbBefrd5r/W55HgHIAnQ6CzTxoG0ibREpgGKOH0OQV/+D+zHw?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc21f54-bafd-4965-7b8f-08ddd005a510
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 07:41:22.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSG+QqCsmfHpr7SZ3qRjSMptNPbPRpI3o0C0ybi9u33ZCndKdK9e5a7B//TTbt8VB5H2j1Mwg4oatLtEb8Eg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7869
X-OriginatorOrg: intel.com


hi, Ingo Molnar and all,

this report is just FYI what we observed in our tests.

the randconfig (https://download.01.org/0day-ci/archive/20250731/202507311445.69f901a3-lkp@intel.com/config-6.16.0-rc1-00022-gcac5cefbade9)
has no CONFIG_SMP
# CONFIG_SMP is not set

so cac5cefbad and parent go different pathes in boot tests.

we don't have enough knowledge if the boot failure caused by some changes
in cac5cefbad itself or just exposed by it. thanks


Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: cac5cefbade90ff0bb0b393d301fa3b5234cf056 ("sched/smp: Make SMP unconditional")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

in testcase: boot

config: x86_64-randconfig-2005-20250721
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | 5202c25dd1 | cac5cefbad |
+---------------------------------------------+------------+------------+
| boot_successes                              | 6          | 0          |
| boot_failures                               | 0          | 6          |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 6          |
| Oops                                        | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 6          |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507311445.69f901a3-lkp@intel.com


[    3.998720][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    3.998877][    T1] #PF: supervisor instruction fetch in kernel mode
[    3.998877][    T1] #PF: error_code(0x0010) - not-present page
[    3.998877][    T1] PGD 0 P4D 0
[    3.998877][    T1] Oops: Oops: 0010 [#1] KASAN
[    3.998877][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.16.0-rc1-00022-gcac5cefbade9 #1 PREEMPT(full)  c1cc10a5b834db7fda46e0874391a29691b85f16
[    3.998877][    T1] Tainted: [T]=RANDSTRUCT
[    3.998877][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    3.998877][    T1] RIP: 0010:0x0
[ 3.998877][ T1] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================
[    3.998877][    T1] RSP: 0000:ffff888103647a80 EFLAGS: 00010046
[    3.998877][    T1] RAX: dffffc0000000000 RBX: ffff888104243800 RCX: 0000000000000000
[    3.998877][    T1] RDX: 1ffffffff0909fd1 RSI: ffff888103647ae0 RDI: ffff888104243800
[    3.998877][    T1] RBP: ffff888103647ab0 R08: 0000000000000000 R09: 0000000000000000
[    3.998877][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888103647ae0
[    3.998877][    T1] R13: ffff888102a78000 R14: 0000000000000000 R15: ffffffff8484fe20
[    3.998877][    T1] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    3.998877][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.998877][    T1] CR2: ffffffffffffffd6 CR3: 0000000004ac0000 CR4: 00000000000406b0
[    3.998877][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.998877][    T1] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    3.998877][    T1] Call Trace:
[    3.998877][    T1]  <TASK>
[ 3.998877][ T1] __do_set_cpus_allowed (kernel/sched/core.c:2757) 
[ 3.998877][ T1] do_set_cpus_allowed (kernel/sched/core.c:2786) 
[ 3.998877][ T1] ? set_cpus_allowed_common (kernel/sched/core.c:2768) 
[ 3.998877][ T1] ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:88 kernel/locking/spinlock_debug.c:115) 
[ 3.998877][ T1] ? _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163) 
[ 3.998877][ T1] ? kthread_affine_preferred (kernel/kthread.c:888 (discriminator 3)) 
[ 3.998877][ T1] kthread_affine_preferred (kernel/kthread.c:889 (discriminator 3)) 
[ 3.998877][ T1] ? kthreadd (kernel/kthread.c:858) 
[ 3.998877][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 3.998877][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 3.998877][ T1] rcu_thread_affine_rnp (kernel/rcu/tree.c:4116) 
[ 3.998877][ T1] ? rcu_boost (kernel/rcu/tree.c:4116) 
[ 3.998877][ T1] rcu_spawn_one_boost_kthread (kernel/rcu/tree_plugin.h:1237 (discriminator 31)) 
[ 3.998877][ T1] ? rcu_thread_affine_rnp (kernel/rcu/tree_plugin.h:1216) 
[ 3.998877][ T1] rcu_spawn_rnp_kthreads (kernel/rcu/tree.c:4137 kernel/rcu/tree.c:4179) 
[ 3.998877][ T1] ? rcu_spawn_one_boost_kthread (kernel/rcu/tree.c:4175) 
[ 3.998877][ T1] ? __sanitizer_cov_trace_pc (kernel/kcov.c:217) 
[ 3.998877][ T1] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 3.998877][ T1] rcu_spawn_gp_kthread (kernel/rcu/tree.c:4549 (discriminator 31)) 
[ 3.998877][ T1] ? rcu_spawn_core_kthreads+0x180/0x180 
[ 3.998877][ T1] do_one_initcall (init/main.c:1274) 
[ 3.998877][ T1] ? trace_initcall_level (init/main.c:1264) 
[ 3.998877][ T1] kernel_init_freeable (init/main.c:1378 init/main.c:1572) 
[ 3.998877][ T1] ? rest_init (init/main.c:1465) 
[ 3.998877][ T1] kernel_init (init/main.c:1475) 
[ 3.998877][ T1] ? rest_init (init/main.c:1465) 
[ 3.998877][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 3.998877][ T1] ? rest_init (init/main.c:1465) 
[ 3.998877][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:255) 
[    3.998877][    T1]  </TASK>
[    3.998877][    T1] Modules linked in:
[    3.998877][    T1] CR2: 0000000000000000
[    3.998877][    T1] ---[ end trace 0000000000000000 ]---
[    3.998877][    T1] RIP: 0010:0x0
[ 3.998877][ T1] Code: Unable to access opcode bytes at 0xffffffffffffffd6.

Code starting with the faulting instruction
===========================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250731/202507311445.69f901a3-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


