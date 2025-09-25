Return-Path: <linux-kernel+bounces-831907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D302EB9DD9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8268F3BDD09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ED92E8DFA;
	Thu, 25 Sep 2025 07:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJtCiLAE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34C15DBC1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785219; cv=fail; b=Fd4nDzQ79Bc7QZmL1bgnME/wrfkaIRBjCuuaiPilctiFLxhEeD037A0eXiN66Aiz9O2hyG0zZMI5/tqeacn2crTUs9CR46IShtSrREQ0vYdzf1VrYpXfl+0Rq1l5D1VNWCQnTTxteFg3aINYdO4opStiXJmLMcA3eCGWNuYXglw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785219; c=relaxed/simple;
	bh=e3UL5qOy4EpNXYsfRRNnL3ktl4HhGyWVevtjzx32dxs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=kimA+k0zG9rLAZTdFbsw+sHlSOGDnxz2p74MUFtoiQoedobjkdDFHIsL7TccgTUmphoB6706s89VEd/ixl7CJZFEUTRg7dK81WksLesAFtrgbZToJRWlwMxt5gCrgzK3PCENkYs5hCtzldNQybeMEQy7dISQveLI0+kZcMNqQ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJtCiLAE; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758785217; x=1790321217;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=e3UL5qOy4EpNXYsfRRNnL3ktl4HhGyWVevtjzx32dxs=;
  b=CJtCiLAEUq9Ug6wrMBtXJxRXBEHO9lxCE247P3lLlzQoCeYde+4J3Ifa
   4lQUFJXedHJYm+0deTDn/sK9HHXrUVQwHk6bPrDp63VA/sw/v1Qulu1YK
   Aw2+/SfvnKFxYIb6Vhdg6e0GzhO7DJ48PXCdSTCp8qrKBQ05m69a1cOIa
   SBleunuCvTBRWw3x9Iet3ixT3QXe4I5CO0R2yRpb+xR+qcwLLgoX0/fIf
   rvV/3FJF1+HEjoU+eiXQIk+s+2uobRuyiyyNV1grJLJf599OkC1MQuaqv
   /+6cIBLGrOt52lkhYakX5JyLt7Kq7mEPk+nRScsS1+kfilkScwA6biJex
   Q==;
X-CSE-ConnectionGUID: A2me9lmqS3qVKZn0888L1Q==
X-CSE-MsgGUID: ZhZo9PbaTU2mmNCTS028WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="64934018"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="64934018"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 00:26:56 -0700
X-CSE-ConnectionGUID: MxjrsAVWR0Wj9XjMAZ0mYw==
X-CSE-MsgGUID: zwLEdO0qT3WwLYi2x9x0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181543890"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 00:26:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:26:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 00:26:54 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 00:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD74ihwBiW3zByloYopY68aL/NkILVYod3yqBIp8Eckzwf1bzyT/Dsx9tBDAgAjoEfuSkb7FmFjYA3WSFPts8EjEHN7J8reyhdqcEBWsJR5h3cheAN9Ieg2tMSLn2vogQbWN0BbCSLLq9tAikqitPVh1iBOhkjMDtzzvaOjvQqje5cUf8nITUM0k9Pz2ngp3ZUK/jXrWhH7+y88l8MV5El8Mprb9WMPlCxh16y56a/qdUb69EdD7+PUNR4Fg36AE4pqLA+aVa8e6VmHwzbIg7mJ/ICLohX7+tjQ8xxcpa4x0e+fhSp4Ijd2dqyKywTsf55HHpDz0hNtJ3FNSfnaTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMU4ev6jXkQnF6ggDdid1zyyfLxvv9Wupi5pqRacUlI=;
 b=o2KzKhQhq5fpd7VGCf5Xn/ZAbA2TaDSDt1eN4OVfZONMeNboaT+YWeoHAWPWx/MveS1d874ZEEEx4kCsiGSd+ti6rdnPAXbVNbtL+b/88HtIKdAbTN+jB7sLMSrJJZTZr258arUvnaPlbqnGXDkBaLK3We3BkN9i+k3b28JB1/iKcrHWZC5iiepArOq6TXK6bFcIQRoyv/LaoGTu8RMINSUyQFeVnF307Ty5ZKRQAIgAIwetu3H3NU4aGV2fW0mqmJGe8834MUR3ucCC+J+wow2b65X2k4CYWeODPUjUH4qQj0nzlK5miHuM6ecCOb7w8vAty3loNhRpSxtPb09DRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6490.namprd11.prod.outlook.com (2603:10b6:208:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 07:26:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 07:26:51 +0000
Date: Thu, 25 Sep 2025 15:26:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Fernand Sieber <sieberf@amazon.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [tip:sched/urgent] [sched/fair]  78f8764d34:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI
Message-ID: <202509251504.1f53d5d1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1e2ee0-6c1d-46de-5fe9-08ddfc04e4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?acYp1w14CnAV89nzObQHjwOk/NXzzoqSx+c2+aFVQmg1Zq/H0jqqrHu+GPE4?=
 =?us-ascii?Q?Ry06fdp3HOkZk5rkZT/C0T0vN/0voXAJtKfmbqGGD/qTQ+HfbLP7mDaRloPp?=
 =?us-ascii?Q?2RyPICqwGVTO33m473rI4W/dQB/4Hn0ZKPnFNqqtNlzdYzEYq7VxwMQ8NIJ9?=
 =?us-ascii?Q?iaCJUrfSopGGCH2H+EywKiXQvNslcYDdDqxmAF12Z96jfycRJI/kUBHP/CCM?=
 =?us-ascii?Q?+Re6pWV0Sk8AAHI75wf2Yn31TevHfqwJqFvE50D6mKK9ivRttq5rW1TfHJWx?=
 =?us-ascii?Q?CsmKhE6oeitXz5HkHelsZipgQMBN3osm8D5CFuedHWqR/FtKnUyV/wbSzpch?=
 =?us-ascii?Q?rb06LStHA6R6RP7E64bsfBEPn8Qw3u6Qz46NxJ0Top6Ps9mQ2jjOoJqH3hMl?=
 =?us-ascii?Q?nWxVOk3xf3ruz64SGafWlhzcmKLGGsMFLgOjVSVayefk0mlPjAPjKKRGH9MW?=
 =?us-ascii?Q?AW3kgWPj+wuPDayDGOqHuPqVCiWb1kCXAI5Shk1C16UAeNstySOGILpHsONq?=
 =?us-ascii?Q?JTEsXtugObi9rdz47/YmcwnItBYLVq+evdJ2dU+4ErAFpKiqDSSs9K7FtW9T?=
 =?us-ascii?Q?2zPJLqrE6fRZVqeC1Z6YaNarHHQDEqGkfMxGykvu2qDECJcnOGwgTpeJJ2CW?=
 =?us-ascii?Q?qWRSN60A9VIQ/EKOZgDYi5fnUUH3sOpjUjE2epOmhbQzgiPW9XIO9C/syqnZ?=
 =?us-ascii?Q?o66cymYYEjQGxKXBt1cOQqTIOMOtjmmw5oGVfgDviCrQ+OzpSXfANskh3WXF?=
 =?us-ascii?Q?B5q/i70Dvuoz/zZL+oqpG69FcSrc0Z4niMUAkH13RWD159EOUB7+Ju1oRH1y?=
 =?us-ascii?Q?NpisQXMb3bx4i7907Kb7+O53FO7iOr8vhPcncdq2RHnNnhjy4D+bjBSYvlw+?=
 =?us-ascii?Q?u6zp9hYHtRJgmIsKvxaiB42ZPkrxzc8eLMCg7PeKMP6ttCno00FtjmZMvS2i?=
 =?us-ascii?Q?iJKSCZIsjm3bq2odMumZGSHRPLs+b0cusQV4p4aA9YtvGle4zbkrz8SEnCg9?=
 =?us-ascii?Q?sUnRtmMa4UsjIXDxDlAzpOghr2WGvn0PedLYelXQgESfRxKYO0ncYUB2c8WT?=
 =?us-ascii?Q?Zy55WnMkyzM1+hp7lRKuHno4EvU/POnOJvZ+9jDnWrpauVRrO5S71SmV6KCa?=
 =?us-ascii?Q?tsyNmoW+N6JF87dD97ofoLZeBxFem1pQKCMxDrK0lhovCgAWdU4k7vrr62Zw?=
 =?us-ascii?Q?W+NAUwOVHRj6pSQKZLK0gnQXocdCdsLJcyfXmwS2TEw/TFBxaUIPrREMAAQH?=
 =?us-ascii?Q?BJ6YVAhqR/0BYsM0g5Xk6TNkTQqFhQIlK1uFlR2aVVA8x2sFfMXmNuFMJO83?=
 =?us-ascii?Q?mQVWVV6I94owrfrKor/AJBwOiXo+KNKhBOP3kPUaFjGe7xN4NgfTg5302d2i?=
 =?us-ascii?Q?xUx1juRB8XK57yyoMyFm+/MOEu+k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e96y45wk7tvHZaUTvdZ4ZjbqeMwsjyNd77qQT3n8dqEOlbXXS456jkjli5vv?=
 =?us-ascii?Q?xew8s9tJ5NOVpcb6n6najez0AOzmxDJS8rMcEPQi0jp9u9QDd1hon5hlrK8Y?=
 =?us-ascii?Q?Lamd+5KBEzDK/6yL8VcpmJcVRS7UWi0FLgaUTBXQia/DQaCYrXYFZ/FswbJl?=
 =?us-ascii?Q?vc9IIsh8xT0r2Ecl4ih/jteORzaRBsGmfY3cKdVKCZgI4lDcaIS1xoSziYEB?=
 =?us-ascii?Q?GDjBEXQpHFlIok3OnPwuhOe8oeikD8wCM2meeEzg5MhxhknMWnGL5eEF3dLs?=
 =?us-ascii?Q?NqZ5nuAHPWFXrGpFu72yr8NzLbar4n53brO/RkPx1l8FunjuFj5dKZtQLLh1?=
 =?us-ascii?Q?OUJEYdld0ZBaQ6EAE4geRmEAQuW9xY3tcLu08koI5Sv7sa0X7+QR314cEPz4?=
 =?us-ascii?Q?IVe7n7ALzitiDEVr0aXn7lOZu1iJVr/dt2LRDz5HYITcLdQ20qMlOrC8JgIy?=
 =?us-ascii?Q?++Dcu1iLGx8T+D6hhmNjnU4ZwgYcgjAiIfXx6SOD9RMGlDA4Q/jsGeIFxxdq?=
 =?us-ascii?Q?nSC3zujQIhpQQGnfQLHwnQD3NX6dvjwU1E2KBddbzCHYOjJ55GiL8go476o0?=
 =?us-ascii?Q?Pk9R02el65HAmwvWZVaoe97bWTFDvLvsG4uvqy/ohpdMuT0Z+rCL2Awq2J+x?=
 =?us-ascii?Q?fH6jD7LxjBZvn+j/10DvdCkenpeYpBaoNxxt3MUd91LPf1uWFWsVaNF7Vlai?=
 =?us-ascii?Q?hfKtfmzrQhIgg4INX0Ro+dv9CXA7CAoSR+1Qc2n9hWEQNQ1z238HkDOhPSZd?=
 =?us-ascii?Q?mnGGzIF93EzgK4TCMMGU2TeXw+liIFCxHCBvJttRa+rWgcdOTsv+mtZy3/2H?=
 =?us-ascii?Q?iLl2NqPrNdpE4Eig8u5G1xhLrAQS4ZyCS3M1xmgxH2KXlEsgH6P9YuAZb9PO?=
 =?us-ascii?Q?mHXWOR7exNWvjlNbAdanzGJ2lgbk5Z1PcNr8VZ4OOfuny+QNhTKZ/kiXNi5D?=
 =?us-ascii?Q?/hr7VZrRXWNDRrsfoRcvjpDJNx17weWU9GPMGFy4Tv5RHMB4moE/8RTszlcC?=
 =?us-ascii?Q?x3q98EPwF/AwZLilLhzurDrEYgghs7hDftR/LDy4d6mGaWXXO7c+8o1nt5nx?=
 =?us-ascii?Q?rVzLFzktjgZTuswwvO/XLKObJxKQUeaxT/cc86yZGrdDrelrcFHZMZNp35yV?=
 =?us-ascii?Q?yPRENZ2qZ6d39d+iW4w7D/qnk9M7KOsDcSRpXjSSBjc19cAB/HhTrh5SPX6q?=
 =?us-ascii?Q?BlaTyEFL9tZY0DYFsQWo78Rh0jVjnXvlAZhjlZedcu00ayBBCOdEQVK7dXzF?=
 =?us-ascii?Q?00s8/y+szyWuBopoKFjqEyVpcjb6z6M695yQef4SsouZ9/Sp2Uq29GsKBFAK?=
 =?us-ascii?Q?3Ak9zrGmWfVZCieoOVCy2YzMmc9uPlYDJF4Brr3i3/APPHZCSlEYp00tX6rS?=
 =?us-ascii?Q?RUNfvHiLVYSh2rzxXvbmLsIpk5H/mZStpGSUXV728kdEGQNv9pilH8wgmChF?=
 =?us-ascii?Q?v9QysgIeycyGLJFThEXTT6QxA437cq23PzxHPHEckOpWU4vrQAHcPtCALJyD?=
 =?us-ascii?Q?8s2CmcRave8lVJrGiAyMnUR6av6LewHnu1Aqpup91CeM38fjnjNGoe9xBhfz?=
 =?us-ascii?Q?AGz2WUwiVRuM5gsPL5fdSB+H+M5S5UT/RYV+nGECNW0lMWdrODBQGGITms03?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1e2ee0-6c1d-46de-5fe9-08ddfc04e4fc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 07:26:51.1749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /b+6bzY5TVYLAInUk2zwrwFf25X41Up3GjzhyjbWgon5qT+UAIg5nI09CeYaqccW/iTdQ8NWSDU+chIrMyMR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6490
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:

commit: 78f8764d34c0a1912ce209bb2a428a94d062707f ("sched/fair: Forfeit vruntime on yield()")
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/urgent


in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-randconfig-073-20250921
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509251504.1f53d5d1-lkp@intel.com


[  172.153051][ T3790] Oops: general protection fault, probably for non-canonical address 0xdffffc000000000a: 0000 [#1] SMP KASAN PTI
[  172.156503][ T3790] KASAN: null-ptr-deref in range [0x0000000000000050-0x0000000000000057]
[  172.158211][ T3790] CPU: 1 UID: 65534 PID: 3790 Comm: trinity-c7 Not tainted 6.17.0-rc6-00001-g78f8764d34c0 #1 VOLUNTARY
[ 172.159150][ T3790] RIP: 0010:pick_task_fair (kbuild/src/consumer/kernel/sched/fair.c:5525 kbuild/src/consumer/kernel/sched/fair.c:8758) 
[ 172.159674][ T3790] Code: 74 08 4c 89 f7 e8 28 63 55 00 4d 8b 2e eb 40 4c 89 e7 be 01 00 00 00 e8 d6 f9 00 00 49 89 c5 4c 8d 60 51 4c 89 e0 48 c1 e8 03 <8a> 04 18 84 c0 0f 85 a0 00 00 00 41 80 3c 24 00 74 13 48 8b 3c 24
All code
========
   0:	74 08                	je     0xa
   2:	4c 89 f7             	mov    %r14,%rdi
   5:	e8 28 63 55 00       	call   0x556332
   a:	4d 8b 2e             	mov    (%r14),%r13
   d:	eb 40                	jmp    0x4f
   f:	4c 89 e7             	mov    %r12,%rdi
  12:	be 01 00 00 00       	mov    $0x1,%esi
  17:	e8 d6 f9 00 00       	call   0xf9f2
  1c:	49 89 c5             	mov    %rax,%r13
  1f:	4c 8d 60 51          	lea    0x51(%rax),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	8a 04 18             	mov    (%rax,%rbx,1),%al		<-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	0f 85 a0 00 00 00    	jne    0xd5
  35:	41 80 3c 24 00       	cmpb   $0x0,(%r12)
  3a:	74 13                	je     0x4f
  3c:	48 8b 3c 24          	mov    (%rsp),%rdi

Code starting with the faulting instruction
===========================================
   0:	8a 04 18             	mov    (%rax,%rbx,1),%al
   3:	84 c0                	test   %al,%al
   5:	0f 85 a0 00 00 00    	jne    0xab
   b:	41 80 3c 24 00       	cmpb   $0x0,(%r12)
  10:	74 13                	je     0x25
  12:	48 8b 3c 24          	mov    (%rsp),%rdi
[  172.161272][ T3790] RSP: 0018:ffffc90006147bc0 EFLAGS: 00010006
[  172.161779][ T3790] RAX: 000000000000000a RBX: dffffc0000000000 RCX: 0000000000000000
[  172.162425][ T3790] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  172.163106][ T3790] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  172.163768][ T3790] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000051
[  172.164429][ T3790] R13: 0000000000000000 R14: ffff8881aa616c60 R15: ffff8883af132210
[  172.165093][ T3790] FS:  00007f7ee462a740(0000) GS:ffff888428b43000(0000) knlGS:0000000000000000
[  172.165864][ T3790] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.166439][ T3790] CR2: 000055e445018050 CR3: 00000001bf01c000 CR4: 00000000000406b0
[  172.167095][ T3790] DR0: 00007f7ee272f000 DR1: 0000000000000000 DR2: 0000000000000000
[  172.167741][ T3790] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000030602
[  172.168388][ T3790] Call Trace:
[  172.168665][ T3790]  <TASK>
[ 172.168914][ T3790] pick_next_task_fair (kbuild/src/consumer/kernel/sched/fair.c:8779) 
[ 172.169368][ T3790] __pick_next_task (kbuild/src/consumer/kernel/sched/core.c:6002) 
[ 172.169774][ T3790] __schedule (kbuild/src/consumer/kernel/sched/core.c:? kbuild/src/consumer/kernel/sched/core.c:6902) 
[ 172.170152][ T3790] ? __cgroup_account_cputime (kbuild/src/consumer/arch/x86/include/asm/preempt.h:85 kbuild/src/consumer/kernel/cgroup/rstat.c:615 kbuild/src/consumer/kernel/cgroup/rstat.c:625) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250925/202509251504.1f53d5d1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


