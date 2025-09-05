Return-Path: <linux-kernel+bounces-801938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A322B44BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F481C21F7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A956236457;
	Fri,  5 Sep 2025 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyfXy2y1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3421C9F4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040593; cv=fail; b=nfKRHk8tcNEAe/JRvMaI5czdvbTQ4jAKRfcw28+BPYBd5GTq1H7eqNIAFNMbdi1eHwoW3b3NYTlQ2qqm+fSdIfOJZzAHbHiyg/ZJK3I0wOeG7Kl9GUd8+ru4yUxZTVHSftvTePsidnpQkC1hGQ/h75LZxqaDW5jae9CJB5TG3hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040593; c=relaxed/simple;
	bh=xBaGUKf+Ifee9B8jc0/ROKy9XJJWpyxTJ31RjBomjGQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=jG4m9yBjYzmv0K7u/oh/hZt8ebchdrHECGY0Y7EvgkGS53rNYOQR1+ha5OUerR3FCXOmBkxhhKkTxvDwgiE1tLM49qqu/cHHVKJk5CPT6Vn8wnFYvxc0P+52ettJ0+wfbhVLVSKIrX+rcjlDS9s/bndTNOfhVBqxk+a/ROrza3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyfXy2y1; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757040592; x=1788576592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xBaGUKf+Ifee9B8jc0/ROKy9XJJWpyxTJ31RjBomjGQ=;
  b=eyfXy2y14KfuTskDuqU3O2iqOb19hYT74IqGj09MBLY776IaWiUVaGYv
   jrET8L9ERGpX5eaEuxO4zFmDMwpN6NlgHEkeDrtUtZbVeX5SLnxcvln2X
   KUK4pHiLIhPiJ9M4lfX7KmTf+Th3Uhvu5E+a56PASH9CarTHgvgrZ1zsZ
   mX7ycIijmbezZjv045G0Pp2sjp+3JUl7wTyFMhFYPZUZ1OiK+iYQO/t6k
   +WK18dqEM/oMfljUmjT3vP61z0l+4QJtDY+KDhDmNwU52QZBNLVpSWp3P
   nD+eoMuPReoCxWz66SNwEsAkcajasZGk83x/3jqTUmTNuh27WkNt7PUx4
   w==;
X-CSE-ConnectionGUID: U4bY42//TFCzmXU0AfeaAw==
X-CSE-MsgGUID: s0GnaplxSlSsyWWk585EDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="59090712"
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="59090712"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 19:49:51 -0700
X-CSE-ConnectionGUID: 8fjS45tOR5KGBPaJgVm2wg==
X-CSE-MsgGUID: 1AtWNo+ETJGLQRMLEOpgsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; 
   d="scan'208";a="171629303"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 19:49:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 19:49:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 19:49:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 19:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN5seRgRakWtIuX/6/0oVzgXBRMvdeaVCtiSuAOXR0ojI6PsBeULQNFQeXa3pcOT/qvx/mqjADCJzX/cVrj8lS2DEzR3dOqiSS66VR/L0E3ZUvvO65GQoklGQX9SpvwFckSWbQq4YmlOMwfbhtyJH9kZFL3/axg92swU3QUrs7ZcoM9crZsniDdMm2vNEPxO0YbnF3RPp6Jen5YyVaVXY5G3NRlr3ylPFS6nqZRctt84DTHEDoX89Hx1QdtzOqysozimFWIbds6dCE+shHV4lzOViU2wv+nWTIQ+mSdTPpkAOaSCrMPhMCId9pEBcYr9kV2wx3l7nGsGhVdlM9jT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqM0Txc6BipwPNAD7WOvrOtj7v9rubxHtqJqa9plSnI=;
 b=P3UXfJbdjx83y3pDCaTKf1VpaQa9ukz9cou0E7YLhjJbOOvR+mXVJR8xetXv1oeDdWZ4DRqPf+toRuRipd/4D64BJ3wreBueycilkBYe6Q5SHn6VJSPGh7NOgcoypsEiZ6MbVfBLxjxf14lR7WQvL1B2R8CGo/xFZ9mLIBD9Zx7npoStI62GQhpkxWAcCp4zkgl0ATa2GDno2m6o+Ia/EKi6y0GBqmLSJ5zjCTQzh3PL9h7T7nx7Zb5+hpTk4zGYyFmeEr0Oyj7kXp+JLJBQAm1w7N/OUXglZj6guYiojSnpOvFMzjUw6MIp24CEJdXmMDU0LMrj3u4dqEuqqBhYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4699.namprd11.prod.outlook.com (2603:10b6:303:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 02:49:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 02:49:45 +0000
Date: Fri, 5 Sep 2025 10:49:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>, Valentin Schneider
	<vschneid@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched]  8671bad873:
 INFO:task_blocked_for_more_than#seconds
Message-ID: <202509051010.e06823ab-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1bb589-362b-4a67-1aeb-08ddec26df19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HurEiJjSwagZrH893Pll9QWsxsBCdj2VpBabSm/xzl5ll2cvCYHsrVPhdHA9?=
 =?us-ascii?Q?7fkuhLmOSmlWBEWRhrN2ebVnga97Ah75OMAc9Om9rGS46cEUrPUZHWm9gkBw?=
 =?us-ascii?Q?RasfClOtA/rEa6e/1btfA9IOHqTLWPrNe7hwYXfHcyIkPLFf9eXN9OJ3Ij4b?=
 =?us-ascii?Q?usUKpodvO1tXhgkJAWiOM171M5u1aIP9j5mL7356JdLjL7+D3Uqa/HB2ugv+?=
 =?us-ascii?Q?3z3w3Pyio9cciSGLuzqi/DWBjEO08ehiWdFWHsBqjvqzolB22IfffiDCmLhZ?=
 =?us-ascii?Q?x88XBcPEmu0vQEcQ9QZz+4El4qwpk7tB5K41sUIYn5AptaMnibBKdV+cdR8Y?=
 =?us-ascii?Q?S6yIenfgbzHG+372g5nq7MX/k7fjP2KPg/qB5e+L8zyT3SzSdnu8wedM+/lh?=
 =?us-ascii?Q?DdlWGnXtDdj4GJTb3LIDlRATT1phD+MLYbhnmB8V8YT2Iofxjg2IzryKw7ZL?=
 =?us-ascii?Q?rQe8EPwjV5sz5WPQW2U+7al+1ku2lalxMe1gI1RSweoL+us27U/skVKCXerh?=
 =?us-ascii?Q?uaOAzl6DOTC1EE5J7M22NxlvDKrevdDAFKsRnHnkOTxoiwkWXXj5Bfyv83bD?=
 =?us-ascii?Q?n+Cy5H+xF125BkDOfo4WGyOIatUZ0z7a/9d2j6N/n+c1TY/6gWuc6r1NSulO?=
 =?us-ascii?Q?6MePIDqEmhCzTMkl/GzoyimEDAiCBdwjpVUTKKBZ8VzwGTSENSHlRnq+D60o?=
 =?us-ascii?Q?gFhPv/w4F9XBmX8hTn7FvRDnxfYgeaKUAUyNdgeb709AtFY06LPPLDNsAN2t?=
 =?us-ascii?Q?lIvLW9cLrASbJgb6GCdWeLfYCHskFZZw6ghARDs8JPqKG0E79E9wS52l0BMa?=
 =?us-ascii?Q?85vOngITTzhAs5tzmrv1VSCE5oYvZaWcvdWrZdIEqlahke4HPeg25oeUzweJ?=
 =?us-ascii?Q?JzDDoBj7P8SQiMfse+9anLHjTzIhfttUTkny73Zf6+/ScglaDbslhBmLr/3B?=
 =?us-ascii?Q?fI3HSy5myfDLEw0UVQ1/LF5Z6TGUdlVLk7gCFmSS6wD7yrAl2t9Y8uAAduy1?=
 =?us-ascii?Q?c8jN0s+vXpM2v8M1lKvLEe8tDTxRyUbOAY6sV/IbS5/5JBCja6vJfjU7pDkA?=
 =?us-ascii?Q?Z5uQnGNzVMFJ5SBbckGPvfGoI1SJyRk2TXUPiyHOfobKJhOVMTxUVfyr8WfD?=
 =?us-ascii?Q?vUT+PeoRQNbrfhOFnAuwzXAq3F8kVhARbF7e8GKkwZDnXu6049Nfc6ZDR9hZ?=
 =?us-ascii?Q?SjsdRfwlsVH4UnYkWUAvjX+jCQhcKD6/c6Sb9TOHinokMrukb5pZJovXczii?=
 =?us-ascii?Q?0Y9oNo/okJXfIdk5tnEtTQH799ZphoIBrJ8baYs3b13+wBpL3jDya7D6Ivlq?=
 =?us-ascii?Q?MhU/N/z5DoTaIG25V1cUhNZC3DwKqH2dmt54uoeKv+v8Ax6Cc7vVblUzT1+Z?=
 =?us-ascii?Q?jzyTtqMCFQFG9rAMIElKtjg4achA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVMzHMev2F+3Fk5yoQjbm1vf0lihODAgVaSIh65MYsGkfbmvEuEzlcsZAMS9?=
 =?us-ascii?Q?ECxZrL4rdM2gWexsNW675/E8ctCD+ZeeOGA45g7PauusmkJ9JXOIZVhvVcuY?=
 =?us-ascii?Q?Mr3NM1bb/anpLtOoD1/Fy/enBRbf+gBVjXIXfMswNQguGYKjf3R8+49bVvPT?=
 =?us-ascii?Q?FsG0NEl8Q6WmRuX3KRoBxVl44FaC1T/mPRRhgujyv9DHxDzoHuSkJ3thcH3Y?=
 =?us-ascii?Q?DQU5NnKl+Hf6AD0kA45nTSwRv9WqGzR1pFOdjcBhPYLrcvSbCtaScQs/Tu7o?=
 =?us-ascii?Q?/0xjRn8j/gnRtRro9RZJ/vLtBaYIc+LPDfcyNklAxoin7vE8RUd4G6ZjWVXR?=
 =?us-ascii?Q?jeu5Qj2W6BCH2E/5Si8lJbPMVoMbKKUMlhCPgHT0o7odx0UxzDxMlogGlspR?=
 =?us-ascii?Q?nZdNQyWrnwYXDHnprdi4yrQRIk5dmizFvxCe2BZYgnd8x7TLDm1iKyY34ECk?=
 =?us-ascii?Q?Azcr8/jEKr2x/HVwPnLOpwXS/ZhQE7FIBVaCAF7zNFDQq3pxsTnJ8umLEugF?=
 =?us-ascii?Q?9L6vUzQbM7ZgizIQwVTXHQfrhZ5gpV0iFKFJDQ916IvLfqkfwGG6zzSRef48?=
 =?us-ascii?Q?nWojMqyWOm+n8lOo1s6LlluTTHr+aZphzORB6snVfyqQV5KeXJIyaD+gkzHU?=
 =?us-ascii?Q?4GUFjTRCevc8eCGsgBiuK2n2iGN3L+67mKkRx0nczXM1V1qETFDinMJgz9qE?=
 =?us-ascii?Q?nLHnUmbA4xoK/lrXFp1WX+McJVJKmWC2z3wEyu++/7/tn49Ih66K5k3+MjbN?=
 =?us-ascii?Q?BUzweUjQzmdTMKTU/g2lLNNeTXX7khD3k5UhXZRkgOQ1/OBajWyrNHRmhhlJ?=
 =?us-ascii?Q?mCM+eGFrmHMATqUvTCPXJcMo3OjzRMm6by+v1yTCf9qSttieYwPyoDkpDZU4?=
 =?us-ascii?Q?Up71i0IMQIZG1rpYfJOATUpsYJxvhmbvQV6jhpt8ZlfqnAOPMi84uDRijPFN?=
 =?us-ascii?Q?IQN9g1pzXPMmqQ9dzIb0pRI5kZJcC3ZBTGPF40IS2qLqyjIlJjgyJ67Sy5rl?=
 =?us-ascii?Q?i9zaLx9etOWOUMZkEzwkjKfrTbaCEczYQK6d7P3dCaHrhlFMwOFNaAUVI41v?=
 =?us-ascii?Q?xgo9bdIQ4OU5z84S7Ky0Scr1qGAUxyuq9YlbtdiE4EDKZXLzBuWg2Zf23/oh?=
 =?us-ascii?Q?fsXvSLcWxCYsy0faoTRtu2CERs9w16NeWgEqGm9iFmBos1/zlLD3Hc8uDvb+?=
 =?us-ascii?Q?e9U8mntqTsXHjgefmrrD+EHcBGPoEub3fgO5LsvsxshHw4ImNoIyxYxqdc6e?=
 =?us-ascii?Q?246fCLNxDLTzgMG5h4er237Re4Esm1gVhzhxMU8899Q+eEvVc7VpI7bSL+cI?=
 =?us-ascii?Q?DrRTKNgDWR1Q25VWAH/GYeEyhCUsvuvd4naTnLP5fz4eeHjcBX71JNT4gDWu?=
 =?us-ascii?Q?kMwc90q3yKuliKfzwEcX0KEc213VcJA34NWJraosCH7VrnxSnXm2lCi+CcTf?=
 =?us-ascii?Q?69nDWwrW8uiJtJR0MR80trSJwmMfVAseLyI7uZgOLd85ugUhOqBk9QnYkpbh?=
 =?us-ascii?Q?u1GSbXhvgtT9vy9ZQa5o4qdP6aCREt0s8XvZ8n5PX57tEc7ERLElX1nl+Pmd?=
 =?us-ascii?Q?qIdnx6N84Bpjmi3C6afLmuhq0/53idZrJ1lMR67JzJ6LNPaSZoiI2y6k8+Jc?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1bb589-362b-4a67-1aeb-08ddec26df19
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 02:49:45.4204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +B42p4/YMf8I2MA02vpEUSy9dbg8VFhH9JKq7/EshmNVOWYKEc1pXhn2tV+j1AtZG0GRsg4IiV1uixKhd/zYFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4699
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: 8671bad873ebeb082afcf7b4501395c374da6023 ("sched: Do not call __put_task_struct() on rt if pi_blocked_on is set")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 08b06c30a44555a8b1d14950e4462a52bfa0758b]
[test failed on linux-next/master 5d50cf9f7cf20a17ac469c20a2e07c29c1f6aab7]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks-rude



config: i386-randconfig-017-20250830
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


the issue happens randomly and we observed various issues in tests by this
commit, while parent keeps clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-017-20250830/gcc-12/300s/cpuhotplug/tasks-rude

7de9d4f946383f48 8671bad873ebeb082afcf7b4501
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         16%          32:200   dmesg.BUG:kernel_hang_in_boot_stage
           :200          0%           1:200   dmesg.BUG:soft_lockup-CPU##stuck_for#s![swapper:#]
           :200          1%           2:200   dmesg.BUG:workqueue_lockup-pool
           :200          0%           1:200   dmesg.EIP:kthread_affine_preferred
           :200          0%           1:200   dmesg.EIP:lock_release
           :200          0%           1:200   dmesg.EIP:tick_clock_notify
           :200         12%          23:200   dmesg.INFO:task_blocked_for_more_than#seconds
           :200         12%          23:200   dmesg.Kernel_panic-not_syncing:hung_task:blocked_tasks
           :200          0%           1:200   dmesg.Kernel_panic-not_syncing:softlockup:hung_tasks
           :200          0%           1:200   dmesg.WARNING:at_kernel/kthread.c:#kthread_affine_preferred



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509051010.e06823ab-lkp@intel.com


[  994.935251][   T26] INFO: task swapper/0:1 blocked for more than 491 seconds.
[  994.947414][   T26]       Not tainted 6.16.0-rc6-00086-g8671bad873eb #1
[  994.951523][   T26] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  994.960576][   T26] task:swapper/0       state:D stack:5016  pid:1     tgid:1     ppid:0      task_flags:0x0140 flags:0x00004000
[  994.972581][   T26] Call Trace:
[ 994.998429][ T26] __schedule (kernel/sched/core.c:5354 kernel/sched/core.c:6954) 
[ 995.035758][ T26] schedule (kernel/sched/core.c:7037 kernel/sched/core.c:7051) 
[ 995.044863][ T26] async_synchronize_cookie_domain (kernel/async.c:317 kernel/async.c:310) 
[ 995.050698][ T26] ? do_wait_intr (kernel/sched/wait.c:384) 
[ 995.059798][ T26] wait_for_initramfs (init/initramfs.c:778) 
[ 995.067798][ T26] populate_rootfs (init/initramfs.c:789) 
[ 995.070767][ T26] do_one_initcall (init/main.c:1274) 
[ 995.074441][ T26] ? initramfs_async_setup (init/initramfs.c:782) 
[ 995.098384][ T26] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 995.136744][ T26] kernel_init_freeable (init/main.c:1588) 
[ 995.136744][ T26] ? rest_init (init/main.c:1466) 
[ 995.158663][ T26] kernel_init (init/main.c:1476) 
[ 995.177750][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 995.178146][ T26] ? rest_init (init/main.c:1466) 
[ 995.230129][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 995.230129][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[  995.268743][   T26]
[  995.268743][   T26] Showing all locks held in the system:
[  995.336987][   T26] 1 lock held by khungtaskd/26:
[ 995.446697][ T26] #0: 830cce10 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks (kernel/locking/lockdep.c:6768 (discriminator 1)) 
[  995.464546][   T26] 4 locks held by kworker/u4:2/29:
[  995.470758][   T26] 2 locks held by kworker/0:3/38:
[  995.498593][   T26]
[  995.599251][   T26] =============================================
[  995.599251][   T26]
[  995.729940][   T26] Kernel panic - not syncing: hung_task: blocked tasks
[  995.729940][   T26] CPU: 0 UID: 0 PID: 26 Comm: khungtaskd Not tainted 6.16.0-rc6-00086-g8671bad873eb #1 PREEMPT(full)
[  995.729940][   T26] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  995.729940][   T26] Call Trace:
[ 995.729940][ T26] dump_stack_lvl (lib/dump_stack.c:124) 
[ 995.729940][ T26] dump_stack (lib/dump_stack.c:130) 
[ 995.729940][ T26] panic (kernel/panic.c:382) 
[ 995.729940][ T26] check_hung_uninterruptible_tasks (kernel/hung_task.c:311) 
[ 995.729940][ T26] watchdog (kernel/hung_task.c:470) 
[ 995.729940][ T26] kthread (kernel/kthread.c:464) 
[ 995.729940][ T26] ? check_hung_uninterruptible_tasks (kernel/hung_task.c:453) 
[ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
[ 995.729940][ T26] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 995.729940][ T26] ? kthread_complete_and_exit (kernel/kthread.c:413) 
[ 995.729940][ T26] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 995.729940][ T26] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250905/202509051010.e06823ab-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


