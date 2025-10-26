Return-Path: <linux-kernel+bounces-870211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1822C0A31C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6E73B0D44
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A931E51EB;
	Sun, 26 Oct 2025 05:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeM6yrax"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D245A95E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457520; cv=fail; b=tMrWtDBrT/S+dIpEWNM/HicaDQrjOFcc2IEjLhIGpaHAEKDjgQlsuQ73gtE2FD+fSmyQNSSVvjfs6grJok6eDlHtAyID/adi5hCKeKFXwHYU95HPSXbbQeLDLE5gExrenltO5/wsYhSyhAQ6KNLdB7phuD1tvhXeQYI6qM9CxYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457520; c=relaxed/simple;
	bh=JlGuy0YZvYDNo9gyveOOYGf9sEGKZIjcO0u8715RvK0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ewqpmwPyvQoZmiQqmBdmnXmSguFh+40mE0ACiucru+B59/GOyuHujJWarV4sn7g2E809X2Mabjb2mRjtAFhEN1EbEz9ONwyKv1uYPK8O4JSRAIL2aJZPFOc4o4EFd8yep6uArXN9k8YHpXUwkrIK8azttGL6OzGzzXdSdvTcm6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeM6yrax; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761457518; x=1792993518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JlGuy0YZvYDNo9gyveOOYGf9sEGKZIjcO0u8715RvK0=;
  b=QeM6yraxaQ28LgxANw6/E3IpvMgpEOuxNIWh4a4lHnovlJAahKMQBtAT
   NhU95oNiLP99Hc94xzuzkyJvG2W0Npktjncbh/IdSQQaEd8V+IfQ+johQ
   jlW8OykuwAu9cc24dod7d7Hh9syY+BHni2Ol7MtNXxgedkXIJiiZwFSHj
   EsapY/PAPKmcSKy2v1jbL4+MnpKk6eiFWJo15x3dqYD/zrKThgrxeG5tr
   UA0bGSGUsWknjImLJMm/2pnAr/ybBjKP9Rp6LsoiOM63v88Lm0ap+OKzp
   nqT2eA4FXU067BNOGwWa7IxJn0NeM0+YoRqmRbcA3d0MOIyjMkWi2JZMx
   g==;
X-CSE-ConnectionGUID: 5qzBHkqQTG+NJFDLJaLSfw==
X-CSE-MsgGUID: nR8qPMgURF+gCnNcDUF/nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="86204933"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="86204933"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:45:18 -0700
X-CSE-ConnectionGUID: fOnrbt1ATXO5C6UUG7SD3Q==
X-CSE-MsgGUID: lFO3vQcCSZeVYZU79qOexA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="183976246"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:45:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:45:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 25 Oct 2025 22:45:17 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ol3o8fXL01cBntb+VOfi0wiKwZHrxdpp6GolZRhB/CeDRAAD0lAsLkACWPfretbCmLZD0L2QKyQu0rtpwFtaY9ji5LOn9BchgQPWYBx5xcbXlths7bc5NmGhVULCn8uR8ZETgz52Xz3FHf6EJvKikJMZrEluidy6yV8BQMSQREydXQrVAB5/jxpn/vpnEpfgTJ/cuS4yic6owI3e9qs5L51pgvr17zhc4wWUEYr0Z859aOYo5lGPxi2aTgROjIB1VAPRXdVM3tPyswTxNRTeiPxpBqjfU55KOP0ja7zFO0VBxuut+vv/65FzNt0d9kmf3JWOt0ufxv+MLDb0CO9g7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9f4ECtUFo7jxWYbEcea/8vvPYL8rk+Px/p19jGCPtM=;
 b=dhQYF/HKoNb3vFkneu0X1ul8rnUZg/sBLPioaEQBTTzTIc8PBOpFhiq/Ao6x3o6chK2DMbUjScWNXkoIy/OPPgqbUfxYvwZbqe5F5r7kch27+ETg+iDmqMKzXuWbpox+yOCGgb7I4XbRQsQsmuV/sKP2AhFu1yH+59S939Qn1CJh0j6BsUkzsbIpcXE990WuDVAQKA41BqttDSaHruN2/2hf6u44Nfrko8J5gEba9ufMP9CWvmvHxa4uLnUvbts6y4UyKg6We+1v4jf+UWwziplJOwl3UwqBZjEBdI0bcm0MKEaOEaSiLnh61C4X9evWACxYDAEWcb7itKhDtzLoHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 05:45:09 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 05:45:09 +0000
Date: Sun, 26 Oct 2025 13:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Amir
 Goldstein" <amir73il@gmail.com>
Subject: set_layers_via_fds.c:5:10: fatal error: fcntl.h: No such file or
 directory
Message-ID: <aP21XV8VGLFFJOWB@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0166.apcprd04.prod.outlook.com (2603:1096:4::28)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 463a1e53-eb57-4c00-c5a5-08de1452d30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zB2ALkIZH/pd90l0TtBLRP4Dz1SZJ2+bKs4lxW1ypXPF3btnWKxU/x7cQMTO?=
 =?us-ascii?Q?MqV3hRkZp2Zr5ZMEzRCSb6ALdsQgDbjQD0FGblTU/wMFFBlV0TkQEb4ykBfm?=
 =?us-ascii?Q?9MmNQLSsDoVSV0idGnrzP32PlrdeVYaOCqswlr/dHFJod2XzAgg2A7FiyN00?=
 =?us-ascii?Q?jSqpl41LkXKRYiV9+9pNdJHi0X8d/TkjpSe8jNw1DPFaoGkBOBEGvtcoFUV/?=
 =?us-ascii?Q?iUb922DBRofury8PE95ln7rESzKHIsGcMIHCkSIrwIWirWWkMcqNt1hnLf4G?=
 =?us-ascii?Q?qq7KjqyFuLhY7LPP+/+SWU7NqzJVw247E0mQ1N98RqWPmXUVbWVgYX/sYWl+?=
 =?us-ascii?Q?Wc0Zg9MChq0qnyhZPuq6gYaxbTuiADRtszcBvlrpg+6XV/Z1MYdOtsSC/vMh?=
 =?us-ascii?Q?8YL69c4wJ1Ox4Dy0/NMUrCGjjOwXZW9K+0fpAhVjBZeWKchD8QTlhgxfV3WC?=
 =?us-ascii?Q?sHqYk57B5Be6PChJdFCwAgOKOXSQPOJgDwUYSC4qlEDzFMordbz3j7YZpt0q?=
 =?us-ascii?Q?5ihT1qLyA99cz3hcpOu8m1Jjj5w9JkZHEHDwphZTho4RlHsiDTeInQuOAqgB?=
 =?us-ascii?Q?O5KORha0rx5bwEakPuMo8T3WWF5vqEwCluoX0OSRH6kKR7cnVzGUqJGK+scF?=
 =?us-ascii?Q?cH2347n0OHE/hTL9sHs77xJMm30zCepNM9BVl4n4Xe7JSGlVBP7d1fSkOZwQ?=
 =?us-ascii?Q?sxhIRwH3krhE0JOGZuaa7wdJxkIs+pQakNxu+cD6rA7FWkS2uH358FpgLeFO?=
 =?us-ascii?Q?mh2sgAAUsX6agcTjLfOO9SaNuubs/V0fHX5IHyHo6TramJ4bI+qiqSKOR64Z?=
 =?us-ascii?Q?L/dglb8NxN+wUpQmwRSJTYY1YGd1cGe8cqLoRPooP6sdAirlA1rxjr0n4QSN?=
 =?us-ascii?Q?0pyO57rs5xqcO/Bl4C/ghhJBpuL6FVD0B2TL8670v1rzEnll7W6UIFzZw15F?=
 =?us-ascii?Q?hDKL3o0iVPECEcCIojNwcsa9su8wHO47DNr/5AbVGtNrKJ6gpHcKOj4omu86?=
 =?us-ascii?Q?+StR9sIXctTY4vNoO3QgwaWHNRLZtQYwH7+gUKqtnyIgCM76vcRIcrwLq4ys?=
 =?us-ascii?Q?JkWUp9wdS2X1Ve7aaWtQCyiXNsccGedu+DKkoqmRGzmm2llH7f9mf1CcmkeT?=
 =?us-ascii?Q?kZIqXUcjaRyQjthPV19iL0YcUgkstJ3DBjwBUe5mvIlBlUWV1SgKj/c2HyYO?=
 =?us-ascii?Q?KBE24enm6V6MuDR9rrp4SDV1+YNogFsDxMY5YdD3/ZFlP1foqnsWCVxnn3JR?=
 =?us-ascii?Q?cF2dgdWGYf6E7wu4YB8QeJPH/iSQ/EpPQRK7XozC3au7PewGIuaAFah079f3?=
 =?us-ascii?Q?6O11RKicRDA+bTaKjDkUHlfi7KBzOXXNsPJPMrsVkoBkzOS/Su0mytIpg7u+?=
 =?us-ascii?Q?pESRSMwLRWg+YPJ0bR39wtDADm6rCguiZhKGjKdzwzvNhTHtlodMN8AeQjsq?=
 =?us-ascii?Q?a/kZ/EorDH7kI+9GA6ZTRFxy1ZEwjMXgNl7P5k9XqMuMUdNGRHKihw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9TwRAnXQQcc2AdNP4OICW9OwId/XRVbze8+8wTbJ4oG9OzlZJq9DRIMseiXX?=
 =?us-ascii?Q?hjVZZv1jE4LXD7WQemQG1XIU+CuBBVF6wOl2ur0RCUr+JDzSRfh1AS/sYb5g?=
 =?us-ascii?Q?NDMC+SFy+jtKKfDoB3H14Y9LyEDWGcUN8MznV3ifpaLS0GRWNWIqdKYyQjAI?=
 =?us-ascii?Q?R19xYt6gEYDRsbR740RM9FZKFWD+BW2Tb1mPUBAy+xvvtomtcEhiGCVONLsi?=
 =?us-ascii?Q?4sOmtCXaiPApQcA8P1iy6RLmLwab0M4+CjaAn3C6tCxXjyC0J4ioqLoni2pP?=
 =?us-ascii?Q?epNddWFQY5gz4M6Q924AASfWD3cqquA2dF08OLr7n5+nz5aWzOCRYAi3ZHHC?=
 =?us-ascii?Q?LGDTYYw+ZQVqso8O+sYlwMixY8NUmseS4x7UiEnDhT4KfhHiIlBS7uvUpwgQ?=
 =?us-ascii?Q?3H3mOVoYB8GBIufCu5tZ2w9Gl2nAWyPxBx7Bg4o7AOLOKc9LwinhROCPMHLn?=
 =?us-ascii?Q?JX00xxW//Xj+AkdeCZdyoO+5eAC8T41lLsijncVPH61r97Pelj78ZU/yDi6c?=
 =?us-ascii?Q?+exklYhQu8Ir5e0VU4BP06qT5V6nJ9+64eklmZAbdjKDAwz34N+H/WT/Hw4g?=
 =?us-ascii?Q?h4dNoupN3ssHO+afPxuGoTKW34tuRrdaVq9qO5vG4KlwIyEvOLvNSA96Bu5s?=
 =?us-ascii?Q?4YxEHFoD1JPMHtmBbvYsp5cc68BJhH574Awp/IBxZX8bryT/AbWzcg6lEqHl?=
 =?us-ascii?Q?fNAYMzpbC7s7hs/V53lg3fFzyD2dxBgC6dJUFA0IeDex91MhepZypE98on2V?=
 =?us-ascii?Q?ui/PblxFQtJ1UG1De+rxUZ0zG86YqNLMjd1jkWEH9rYA4mtyZ73cnKReHZkf?=
 =?us-ascii?Q?+IQQt28uivTphKqgb7/gcx89C4flKxMtA7DzieHO9FC/TCquleSryYTC+lcC?=
 =?us-ascii?Q?DGdDyVJdSongOnyRTvfRZFXDGmqTJg3xK85c//N3bwyQfskfjSDZhK4rSKMg?=
 =?us-ascii?Q?uOi0iCeSO26wusA+GqfZHuFYBV7LBBEu6f2BNc+sn1A39Jip+hJ+lYI08m8X?=
 =?us-ascii?Q?Z1QrwRKO4m8ka0JEnuOsKyC+ywO5oAAGyoUeUnIWSdnKzqValVg65A7AuFzK?=
 =?us-ascii?Q?C9OUuDfR6rS+h3wG8pi6Pk5JW53DM6LvfHS9v6btNwhzdptRwN93Mqv/iOJ6?=
 =?us-ascii?Q?IJspobvPMDqzMhvje92BoTWzu1ySy6OsW6mJeFMjpPnyw6KwfGzrARgUlZrd?=
 =?us-ascii?Q?INfI+PAzP1PRAHRRotEpMQE7ErV9X0LnudJVNrJth2y7kH8IJkN8sXMwguk+?=
 =?us-ascii?Q?Ynu7Wr9Z8X50FBjSEiEwkpc6fdJC5IJhAA+cBXTFgThXWxeE3c3CwsF045Za?=
 =?us-ascii?Q?LjvmDjWtZb/Q1yYdUh9UH3ViqmNSp5e1jNNMPnPMcPaj3FlpXlfSKO1vABPY?=
 =?us-ascii?Q?ayWfri1CMuvzzdnWHH//MvmD94MZ13BxFTo3vCDJno667DSVK212HPgzmhVW?=
 =?us-ascii?Q?xyohlkmV8mpqv7KkPe6wYMSMBeMu2WsZCvF0DG73C3H1WssAzXFq4jZnQCV9?=
 =?us-ascii?Q?tOtZEEJnS1GYTyS/fF+Rw6XLovjF1E9JfgMkpsWGaEtQ9Z7+RUQjifyx6vp5?=
 =?us-ascii?Q?QtgfYXznxNmAJe5g0t5hDtZgebMxu2xDGuucPHKL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 463a1e53-eb57-4c00-c5a5-08de1452d30a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 05:45:09.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFL/C21C2pgsq8xIcPl2WVv6NOUH2z8Fgz61iv5NJAFN99azL0fuSxTh9Ue6InMOfkTvtdJmMfOMmPSDD1i2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   72761a7e31225971d0b29d9195e0ffa986b77867
commit: af9199145b1977316b3c752e2124543e320f087f selftests: add overlayfs fd mounting selftests
date:   1 year ago
:::::: branch date: 9 hours ago
:::::: commit date: 1 year ago
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510261024.iDAnOFIm-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510261024.iDAnOFIm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510261024.iDAnOFIm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> set_layers_via_fds.c:5:10: fatal error: fcntl.h: No such file or directory
       5 | #include <fcntl.h>
         |          ^~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


