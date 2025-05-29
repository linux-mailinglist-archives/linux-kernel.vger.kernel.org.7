Return-Path: <linux-kernel+bounces-666490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1750AC774C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438E6501168
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5412459DD;
	Thu, 29 May 2025 04:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKm/zMj2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F611A2643
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493934; cv=fail; b=Q21mfQJFF9smiUghZhvwOZJVTO8LsRW5KHD/MIXxihuyh7Q72fBZL4BrMtbXMasvvP9nog6eFSflp7Zo63qIARnsWHNqUI+kpm/MnqCmWf+YBmwLspBg5y6Qwc+zMd/h7PYKGziOm0pLl2GOkYJfhFF94XtTsD3s0PhaBJLiieo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493934; c=relaxed/simple;
	bh=w/2ZNc/Y3HjOV4V939DzhLJ+mY//ZqvQVFxp70jLRxo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MJpoN059Ye7DI8bJ+G0dxXV9ijBFhmGq8MWbcD9wc4sKlObrA7HlOdJUNdPdwuvj1PoXzxvKI8TFbi+FjDBUb982/TXWtQf141lPTxyO2W7GEiHFE2MMWcmRz0wm7UAYayqjCxS4I2X3I3CkZwoXVJ9J6uGY6F1OGO8YwYdlxT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKm/zMj2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748493929; x=1780029929;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=w/2ZNc/Y3HjOV4V939DzhLJ+mY//ZqvQVFxp70jLRxo=;
  b=mKm/zMj2R78JM9lc5H6l1YrYZYuRhFdvb41yB8cUA71ut1RJJy1TxVn0
   VH2J4AGzNvpE27HqgHskC8LSal6htbzUigVEkigZWbsJz5mMmacwL8+IW
   KRKqu33bgVj1kTEtlDpVhRcAIrSvFOwNvSua6qATk6aUe7sLVeCpQJZo9
   K6hqJOGiFGBhJ0xjpmqWiXq5THsimcgcCDsxazSc2wPGalwjq/XjZWaMP
   lKwRFL9rQNUYrnOLQYoDC5RsW7DtiZe/kKTqgUGkRGmCX4JTnwjR0YFxh
   rS3pWur2umOIJD0+xwepPc7L4uDOfeUnppAejE+IZRLoUoseL3/c8RVO2
   w==;
X-CSE-ConnectionGUID: JKNxIA4QQvyt5sEsQESUiA==
X-CSE-MsgGUID: M8kp0enFQWm1PK0DFfLCug==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50645433"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50645433"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 21:45:28 -0700
X-CSE-ConnectionGUID: hxXPkjgJSw2vnIWLAWu/6g==
X-CSE-MsgGUID: FnSo5K1uRnWCPdv/uQe9Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143469955"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 21:45:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 21:45:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 21:45:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.69) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 21:45:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ix5EXxvejhmh372nV7kGkVZ/uegpX54DgP7f5tITH6S06f5F2Fu1PLlN/VH3QscjBrMDXAEs9Ohm0RHdxXfdq3vuSC9rzFphS76lTgORkxv8BLt2C62FugWf2mSWYkQxp8jQQCFxpBBWpdpb6ftTyCbRGjDpqtMuvoQtoVraALVingpOQhi+jGfFPynz7yEjyWRkfmHHIK9YcUZJDx3k+BToet+86V/lYnHdKnAmgwhm7UMC/Qj7TSd8c2bMxP/kz+hu9mM670Bl7/zffDbgcnBCTZ86e3vNF3YvewMccqageITDB6b5h1BPWgDWyCH3o1edn11tdGBE7oyPT9GwHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7QnXuxgdyd7lc0W1NVJEMzA5ilA/dmzfX5JRsy+Pw4=;
 b=m+/ElDrwx5vE5LQ5xAoUzK360Rwh2YRmpjp70yyujUr+5TGsHWgCiolsu0cua8gPKxuHXvVFfey+sX37e7L98+4nYywsM4OJvb7Fwn2jwD60RQ13gtawCXynlmz/6KTisG0GvFXhW/YgDTW6B2xWQxvLdECesj8II691WB2873nH5jD1xi8y9/ETwPdw5kX/rNwS7degbrSRWaxRb5LWUQ6ZWH/azGsQgznxGZEejtoK4KCMDr17RAEU4b+085+qyYbBD+49ao2y4JhdJN02fS3ij8Vrs8iuAsDSciEND5RWXOU08WvDvqv9UoE9u54bYVi/fSRvO1o4XEYMGlRRlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8680.namprd11.prod.outlook.com (2603:10b6:408:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 04:45:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 04:45:21 +0000
Date: Thu, 29 May 2025 12:45:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <linux-mm@kvack.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [futex]  bd54df5ea7:  will-it-scale.per_thread_ops
 85.7% regression
Message-ID: <202505291038.e861f1d7-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0084.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::24) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8680:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca41eb8-5ee4-4acf-7994-08dd9e6b9df8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?tE668smbSKXc9PsM3CwtJLCQePgtI9dmX0o0awoaFSugYufTdNAOhV4adT?=
 =?iso-8859-1?Q?+0uN66JXUFZS3sCK2kw4kNdSfYIlhpIgkiCr5YEk1fNNXrH3OzbFJd7/VG?=
 =?iso-8859-1?Q?52fUQOHguSBhWYXZWoByknTzO9iha9yqpE4OuEw0wxxCvT7m69Dc++3Xkj?=
 =?iso-8859-1?Q?w8AKMk11xpJCVLq3wE5NUNVk5a3VMhdUbFnzvQJaShdkNgT7kweHBAe0c9?=
 =?iso-8859-1?Q?t3ej/k9xTRn9ErXjfroF/7Zy17RcKy+X1vZq54017wQnvIf68C6jV4K9t9?=
 =?iso-8859-1?Q?wfDih72EMqNrszweJwBvfxoiJjNVVte8a8jW4FeVWszuxngKQ+AlDQ61CB?=
 =?iso-8859-1?Q?e9v6N7FWcgxHDptRD3TG0DDVHfWLx1N0QzW/bKvMeJNDxhxgbkgRwjvvoz?=
 =?iso-8859-1?Q?SfqMQBvKr3LxYZNqRcsEjb7Gcql9P54+GzTpXrbcU/0ftPRs5fwAle9bHB?=
 =?iso-8859-1?Q?DG65i2v+zagO14N1QWVTAEtAMAyOvbG3C8kGcfh3y4TI8rVj342Uy4k16q?=
 =?iso-8859-1?Q?kx8BVGRO3MXez73DItUrhKMpkg0lthp5wvmUgrx1yl4K3dIv69MqgjOtuj?=
 =?iso-8859-1?Q?rBrNiahOX6UsvKsvdEJGDubr+UStaISw9/GXTWM9KxdGOEmV5ruwNjfPpg?=
 =?iso-8859-1?Q?91uRPK2iNkJASFo4KW5JHUPU5ChSaWk3BK5/QydEwKpkDM2poiEVGzArJC?=
 =?iso-8859-1?Q?plZw5URm4kNA5xA/OmKLsReszGzabJwxQT6tOUxYLD21jIgHMWMDSishHB?=
 =?iso-8859-1?Q?SvlUdlye9rv5+VTMY/i0Ys4MJfPzwlboXqUt8ekBliKevy80MrHI0ZoRqT?=
 =?iso-8859-1?Q?tCiJ29Qpz8wTkN4jgRLQPqiSK0oR9xzXg1IdrVGc9xBdSUfWZsRVjjGUbN?=
 =?iso-8859-1?Q?q3jJXylshOxUeNNPOBRUl/vYLZhTRtiqErTLc1baGm47iCJpvyfF6uAsY6?=
 =?iso-8859-1?Q?x/9eDTrh0K6lxmEz5RwsCVkUQR7/RNFnBl+y07HidJzIej4Y1mRLaDFPF2?=
 =?iso-8859-1?Q?53dHPRxOfJ/a+JJzDoKVgFu6otkbDx7+aVOFMWZJVbA/jEM/tiTOFjbnGL?=
 =?iso-8859-1?Q?swE0Bz58uZgOmKDqf5DSQ98i8CQzcvnBFi9YVZx1JNojZi8PVpWvyXTjfy?=
 =?iso-8859-1?Q?6Y+Uf/KCSuTyFyYgLJRBmd9OkFbNV/XqJtvHV7y/nyw8zu0mmTNLB6GcLS?=
 =?iso-8859-1?Q?BIEam5UGoNtAIAyg6q7EPzKA0zGcDkmxOzC32V7VsexkUZbGe6aDUWVaVt?=
 =?iso-8859-1?Q?wXtTrjBcf2+re9mQ3ZaxFMqEgA+lsQ/X0PvlfaEA1DSp+ptMa0HXA9QmWt?=
 =?iso-8859-1?Q?NPLKMsqOlDlWgY2b5cRg+xXF9aZ/hIsLsw9MjJW+4C+1tkHT3yh1yUt86F?=
 =?iso-8859-1?Q?Bd8c4rnFfk6Qhc7kYuQm3h/Dx8rEsm1ArzhDsBrY/7Jkmo1Esk5MJA4n8m?=
 =?iso-8859-1?Q?C4JPO+oUPoXSeUpx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oB0BiwWr3nzURl/UNZdXVzY1DFz4O+yM30mrmhxbE5xj0q7zmHKlLfKnv6?=
 =?iso-8859-1?Q?0IXmxaBrrrEmjvHEfWrLR2c9FNRfzH2sDHwYu3vCm6tgOBNWTTUYVz5G0w?=
 =?iso-8859-1?Q?XVbekHLCtKLvN9bZwDCXVUnljTjdAh+DjT56V2Y8jPNiMT+2ayW3diEcPy?=
 =?iso-8859-1?Q?tCp7KBNQRdgdYHVnL+kpRWn3rufVlqz9561+m2kaWRvrFVRZrFfbsLG5dq?=
 =?iso-8859-1?Q?aHkPJLSgF1mci8kWszDwYPznAjFRqanKyPNNnyxRoQIyIA1i0wDU0Ckl2t?=
 =?iso-8859-1?Q?v65yzE6wyvuHSJJKlfD+SEgR0qSb65WwMkuT05SB7JODPO3qhcEl2jN7rd?=
 =?iso-8859-1?Q?zBnwPME1Q6XMtXdWSRxtUr9bXnmX+4T5LArh2ytoeUlJwawnCrFmhtvVFP?=
 =?iso-8859-1?Q?LhNYXxN2RNuy5pKbd2HGYUh/6nYK6H/ro4nxYtbcVCmGqnaIKBHXV4nfOd?=
 =?iso-8859-1?Q?V+sdJtLZuKA1kxHFS5ncUFMmOx22xtFsqyGLsn43Bd4tClQufDO2K2Z3KZ?=
 =?iso-8859-1?Q?MyyieAlNM/6aF23x8DBg9S05e43cE3TStoJKCelHSctYBX6MVAws+YpemM?=
 =?iso-8859-1?Q?COISo+UvyFzGz9KXHZ6/ZW397HMOWVJIi7BVIyspqcogmvFyc30dHuiklQ?=
 =?iso-8859-1?Q?HfZlGiaYmgiIVHSL5DB5/i6cNvalBYwbJ3m2VLRJu2qlP9fzIut/4dAttD?=
 =?iso-8859-1?Q?flhnA4gb/vnYXeH5iImTYDKQ9ea4CiIOZ5ZUARfFeJ9dHpcJdQ/xCPowWV?=
 =?iso-8859-1?Q?0VlnihFB3bIXDJZwuuKcJgmwkbbFYduDGk3gIWDxnhqWDJM5uiN9y0r1go?=
 =?iso-8859-1?Q?z7Sz/eDInjEaKwlr8RB6nhgu13UGWBzDwmfnoNmvIZAXAwn/sbT2NCxD3p?=
 =?iso-8859-1?Q?1LtV3Cul3Ns0Cntiqpq08L2CHIzv7lrhB6H5k1/061neW+/UQ6muhlOHUC?=
 =?iso-8859-1?Q?YhDZ6dVa86pbYP/VfLhkXMhstTVlcAxa/3xS/j7XiHxdrd+79GWxmaAZ+6?=
 =?iso-8859-1?Q?U1cD3ZL+z2Ax1MOSZ294jv5mn1Wea7z4agY0VB/s+yUerNNf+giaN/FdHS?=
 =?iso-8859-1?Q?Cyq0G7iQ2Wz19v9nUCJwDf8bq9quvkoqUFk2qo6LusLfA0l/hK3rkEMT9i?=
 =?iso-8859-1?Q?4j0ONwpCWmD3PQ29GU3YvdOqXc6G20bAHHYO1wbsq92EzNNTDe9Uj7sEj+?=
 =?iso-8859-1?Q?lTN77aJF/hDObI36jBynjLfwXewcfXMPDbs6X+25wRcKzUbJ2Vm4PV0Phc?=
 =?iso-8859-1?Q?hItb+xmdnnMHXpD42MvCHaiAQRHWqbnikJIXxIx5ANc6Ox/TTYWjqffcTs?=
 =?iso-8859-1?Q?NOM+PD4/wJIswLakQ/ejkYCbRyAjCTwOoCFt5rIlSkz2cQ1bo80HW8t2fi?=
 =?iso-8859-1?Q?HUCFXqQzwGCav9ZhK1M/PuetCskRkE8QHhCU/8+tLa7GCIHF7BrZ/GOGvz?=
 =?iso-8859-1?Q?XoQE8iLLJQyvlP4H1rVwY6//DaPAsNyqv9msM/eKyWJNqKXS77nfB1qT0E?=
 =?iso-8859-1?Q?skm3TTRILJVMSHzvFgFHER9u0hBKIdf/VxWJsfCdM7008z3rn/e0VaaNBt?=
 =?iso-8859-1?Q?fuayxXp9G4W+fn6crBYUVHxIJ89JylI0hTmiC8RsWmMudzhrM3rO2bh186?=
 =?iso-8859-1?Q?C1KdzI+gLajeyqv4GaZuSoV5Cpi81eKjCT/SiWtMpJCOhHyxF8QV80GQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca41eb8-5ee4-4acf-7994-08dd9e6b9df8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 04:45:20.9493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8s1SNFf4jvEBnVaiRpTqwJfXXDD0mcFnyDcqTGhE7ftUn2dYTowv5f+8aeXUIT6Ln5wa1scFeDtqc8RqQUDx9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8680
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 85.7% regression of will-it-scale.per_thread_ops on:


commit: bd54df5ea7cadac520e346d5f0fe5d58e635b6ba ("futex: Allow to resize the private local hash")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linus/master      feacb1774bd5eac6382990d0f6d1378dc01dd78f]
[still regression on linux-next/master fefff2755f2aa4125dce2a1edfe7e545c7c621f2]
[still regression on fix commit        094ac8cff7858bee5fa4554f6ea66c964f8e160e]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 104 threads 2 sockets (Skylake) with 192G memory
parameters:

	nr_task: 100%
	mode: thread
	test: futex3
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | phoronix-test-suite: phoronix-test-suite.memcached.5:1.ops_sec  3.5% regression               |
| test machine     | 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | option_a=5:1                                                                                  |
|                  | test=memcached-1.2.0                                                                          |
+------------------+-----------------------------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 33.9% improvement                                 |
| test machine     | 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory  |
| test parameters  | cpufreq_governor=performance                                                                  |
|                  | mode=thread                                                                                   |
|                  | nr_task=100%                                                                                  |
|                  | test=pthread_mutex5                                                                           |
+------------------+-----------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505291038.e861f1d7-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250529/202505291038.e861f1d7-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-skl-fpga01/futex3/will-it-scale

commit: 
  7c4f75a21f ("futex: Allow automatic allocation of process wide futex hash")
  bd54df5ea7 ("futex: Allow to resize the private local hash")

7c4f75a21f636486 bd54df5ea7cadac520e346d5f0f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    338452           +13.8%     385002        meminfo.Shmem
    332062           +13.7%     377427        numa-meminfo.node1.Shmem
     82957           +13.7%      94282        numa-vmstat.node1.nr_shmem
     42.06 �  2%     +40.4       82.50        mpstat.cpu.all.sys%
     56.95 �  2%     -40.3       16.68        mpstat.cpu.all.usr%
     42.16 �  3%     +95.3%      82.35        vmstat.cpu.sy
     56.55 �  2%     -70.7%      16.57        vmstat.cpu.us
  79060974           -85.7%   11319830 �  2%  will-it-scale.104.threads
    760201           -85.7%     108843 �  2%  will-it-scale.per_thread_ops
  79060974           -85.7%   11319830 �  2%  will-it-scale.workload
    193.33 �  8%   +1739.5%       3556 �  4%  perf-c2c.DRAM.remote
    576.67 � 13%   +1875.7%      11393 �  2%  perf-c2c.HITM.local
    177.33 � 10%   +1821.1%       3406 �  4%  perf-c2c.HITM.remote
    754.00 � 11%   +1862.9%      14800 �  2%  perf-c2c.HITM.total
    256705            +4.4%     268126        proc-vmstat.nr_active_anon
    964485            +1.2%     976128        proc-vmstat.nr_file_pages
     84606           +13.8%      96248        proc-vmstat.nr_shmem
    256705            +4.4%     268126        proc-vmstat.nr_zone_active_anon
    935363            -2.3%     913404        proc-vmstat.pgfault
   1013658            -2.0%     993799        proc-vmstat.pgfree
      0.67           +25.0%       0.83        sched_debug.cfs_rq:/.h_nr_queued.min
      0.67           +25.0%       0.83        sched_debug.cfs_rq:/.h_nr_runnable.min
      0.19 �  5%     -11.1%       0.17 �  7%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      6440           +26.2%       8125        sched_debug.cfs_rq:/.load.min
      6.00           +24.5%       7.47        sched_debug.cfs_rq:/.load_avg.min
      0.67           +25.0%       0.83        sched_debug.cfs_rq:/.nr_queued.min
    660.69 �  5%     +25.4%     828.58        sched_debug.cfs_rq:/.runnable_avg.min
    124.93 �  5%      -9.6%     112.94 �  6%  sched_debug.cfs_rq:/.runnable_avg.stddev
    567.81 �  8%     +25.4%     711.86 �  6%  sched_debug.cfs_rq:/.util_avg.min
      1358 �  3%     -12.9%       1183 � 10%  sched_debug.cfs_rq:/.util_est.max
   1042028 �  6%     +43.9%    1499082 � 36%  sched_debug.cpu.avg_idle.max
     13.32 �  7%     +71.5%      22.85 � 10%  sched_debug.cpu.clock.stddev
      2202 � 74%    +348.7%       9884 � 79%  sched_debug.cpu.max_idle_balance_cost.stddev
    979.97 �  6%     +17.8%       1154 �  6%  sched_debug.cpu.nr_switches.min
      0.00          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.avg
      0.17          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.max
      0.02          -100.0%       0.00        sched_debug.rt_rq:.rt_nr_running.stddev
      0.02 �  4%   +6643.2%       1.42        perf-stat.i.MPKI
 6.361e+09           -82.1%   1.14e+09        perf-stat.i.branch-instructions
      0.31 �  4%      +0.4        0.70 �  2%  perf-stat.i.branch-miss-rate%
  19810336 �  4%     -47.2%   10450408        perf-stat.i.branch-misses
     16.06 �  4%      +8.3       24.34        perf-stat.i.cache-miss-rate%
    789989 �  4%   +1103.3%    9505850 �  2%  perf-stat.i.cache-misses
   4418710 �  2%    +782.4%   38989894        perf-stat.i.cache-references
      1803            +1.4%       1828        perf-stat.i.context-switches
      7.35          +497.9%      43.93 �  2%  perf-stat.i.cpi
    172.02           -12.6%     150.30        perf-stat.i.cpu-migrations
    757174 �  3%     -95.9%      30876 �  2%  perf-stat.i.cycles-between-cache-misses
 3.938e+10           -82.8%  6.777e+09 �  2%  perf-stat.i.instructions
      0.14           -82.1%       0.02        perf-stat.i.ipc
      2745            -1.9%       2694        perf-stat.i.minor-faults
      2745            -1.9%       2694        perf-stat.i.page-faults
      0.02 �  4%   +6887.3%       1.40        perf-stat.overall.MPKI
      0.31 �  5%      +0.6        0.92 �  2%  perf-stat.overall.branch-miss-rate%
     17.85 �  4%      +6.5       24.38        perf-stat.overall.cache-miss-rate%
      7.35          +481.6%      42.77        perf-stat.overall.cpi
    366856 �  4%     -91.7%      30485 �  2%  perf-stat.overall.cycles-between-cache-misses
      0.14           -82.8%       0.02        perf-stat.overall.ipc
    150266           +20.1%     180400        perf-stat.overall.path-length
  6.34e+09           -82.1%  1.135e+09        perf-stat.ps.branch-instructions
  19745655 �  4%     -47.4%   10395167        perf-stat.ps.branch-misses
    788134 �  4%   +1102.0%    9473157 �  2%  perf-stat.ps.cache-misses
   4417634 �  2%    +779.5%   38852012        perf-stat.ps.cache-references
      1797            +1.3%       1821        perf-stat.ps.context-switches
    171.49           -12.7%     149.66        perf-stat.ps.cpu-migrations
 3.925e+10           -82.8%   6.75e+09        perf-stat.ps.instructions
      2735            -2.2%       2674        perf-stat.ps.minor-faults
      2735            -2.2%       2674        perf-stat.ps.page-faults
 1.188e+13           -82.8%  2.042e+12 �  2%  perf-stat.total.instructions
     29.53           -22.5        7.01        perf-profile.calltrace.cycles-pp.syscall_return_via_sysret.syscall
     14.37 � 11%     -11.9        2.44 �  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_safe_stack.syscall
     18.82 �  2%     -10.9        7.92        perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.syscall
      9.67            -8.6        1.08 �  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.syscall
      0.00            +0.8        0.81 �  7%  perf-profile.calltrace.cycles-pp.write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.00            +0.8        0.81 �  6%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.00            +0.8        0.81 �  6%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.00            +0.9        0.86 �  6%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.00            +0.9        0.87 �  6%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.handle_internal_command.main
      0.00            +0.9        0.87 �  6%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.handle_internal_command.main
      0.00            +0.9        0.87 �  6%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.handle_internal_command
      0.00            +0.9        0.88 �  6%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
      0.00            +0.9        0.88 �  6%  perf-profile.calltrace.cycles-pp.main
      0.00            +0.9        0.88 �  6%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
      0.00           +24.6       24.64        perf-profile.calltrace.cycles-pp.futex_hash_put.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
      1.26 �  2%     +45.3       46.57        perf-profile.calltrace.cycles-pp.futex_hash.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     30.29           +48.4       78.64        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
     14.49 �  3%     +60.5       74.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      6.40 �  2%     +68.0       74.41        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      5.32 �  4%     +69.0       74.28        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
      4.52 �  5%     +69.7       74.18        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     29.72           -22.5        7.22        perf-profile.children.cycles-pp.syscall_return_via_sysret
     15.01 �  6%     -12.7        2.28        perf-profile.children.cycles-pp.entry_SYSCALL_64
     19.96 �  2%     -11.6        8.41        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      7.67 � 10%      -6.4        1.28 �  3%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      2.57 �  7%      -2.3        0.27 �  2%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.99 � 11%      -1.8        0.22 �  2%  perf-profile.children.cycles-pp.get_futex_key
      0.43 �  2%      -0.4        0.07 �  5%  perf-profile.children.cycles-pp.x64_sys_call
      0.15 �  5%      +0.0        0.17 �  4%  perf-profile.children.cycles-pp.update_process_times
      0.17 �  5%      +0.0        0.20 �  4%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.09 �  8%      +0.0        0.12 �  4%  perf-profile.children.cycles-pp.sched_tick
      0.02 �141%      +0.1        0.07 �  5%  perf-profile.children.cycles-pp.task_tick_fair
      0.21 �  6%      +0.1        0.27 �  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.24 �  6%      +0.1        0.32        perf-profile.children.cycles-pp.hrtimer_interrupt
      0.24 �  7%      +0.1        0.32        perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.26 �  6%      +0.1        0.35        perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.32 �  6%      +0.1        0.41        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.2        0.18 � 13%  perf-profile.children.cycles-pp.generic_perform_write
      0.02 � 99%      +0.2        0.26 � 12%  perf-profile.children.cycles-pp.vfs_write
      0.00            +0.2        0.25 � 13%  perf-profile.children.cycles-pp.shmem_file_write_iter
      0.02 � 99%      +0.3        0.30 � 10%  perf-profile.children.cycles-pp.ksys_write
      0.04 � 71%      +0.8        0.83 �  7%  perf-profile.children.cycles-pp.write
      0.00            +0.8        0.82 �  6%  perf-profile.children.cycles-pp.record__pushfn
      0.00            +0.8        0.82 �  6%  perf-profile.children.cycles-pp.writen
      0.00            +0.9        0.86 �  6%  perf-profile.children.cycles-pp.perf_mmap__push
      0.00            +0.9        0.87 �  6%  perf-profile.children.cycles-pp.__cmd_record
      0.00            +0.9        0.87 �  6%  perf-profile.children.cycles-pp.cmd_record
      0.00            +0.9        0.87 �  6%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      0.00            +0.9        0.88 �  6%  perf-profile.children.cycles-pp.handle_internal_command
      0.00            +0.9        0.88 �  6%  perf-profile.children.cycles-pp.main
      0.00            +0.9        0.88 �  6%  perf-profile.children.cycles-pp.run_builtin
      0.00           +24.7       24.66        perf-profile.children.cycles-pp.futex_hash_put
      1.26 �  2%     +45.3       46.60        perf-profile.children.cycles-pp.futex_hash
     30.69           +48.5       79.21        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     14.68 �  3%     +60.7       75.36        perf-profile.children.cycles-pp.do_syscall_64
      6.49 �  2%     +67.9       74.41        perf-profile.children.cycles-pp.__x64_sys_futex
      5.40 �  4%     +68.9       74.30        perf-profile.children.cycles-pp.do_futex
      4.68 �  4%     +69.5       74.20        perf-profile.children.cycles-pp.futex_wake
     29.66           -22.4        7.22        perf-profile.self.cycles-pp.syscall_return_via_sysret
     16.27 �  2%     -12.4        3.88        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
     13.65 �  6%     -11.5        2.10        perf-profile.self.cycles-pp.entry_SYSCALL_64
     19.78 �  2%     -11.4        8.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      4.86            -4.7        0.20 �  4%  perf-profile.self.cycles-pp.do_syscall_64
      2.30 �  8%      -2.1        0.24 �  2%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      1.94 � 11%      -1.7        0.22 �  2%  perf-profile.self.cycles-pp.get_futex_key
      2.60            -1.5        1.15 �  3%  perf-profile.self.cycles-pp.syscall
      1.07 �  2%      -1.0        0.12 �  4%  perf-profile.self.cycles-pp.__x64_sys_futex
      0.97 �  6%      -0.9        0.09 �  4%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.74 �  2%      -0.6        0.10        perf-profile.self.cycles-pp.do_futex
      0.40            -0.3        0.06 �  8%  perf-profile.self.cycles-pp.x64_sys_call
      1.48            +1.2        2.70 �  6%  perf-profile.self.cycles-pp.futex_wake
      0.00           +24.6       24.57        perf-profile.self.cycles-pp.futex_hash_put
      1.15 �  2%     +45.3       46.42        perf-profile.self.cycles-pp.futex_hash
      0.00 �223%  +28429.2%       1.14 � 57%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.08 � 12%    +159.1%       0.21 � 11%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 �100%   +7759.4%       0.90 � 45%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.66 � 91%    +263.5%       2.38 � 13%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.02 � 31%   +2073.5%       0.49 �163%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.01 �  3%     +97.3%       0.02 � 15%  perf-sched.sch_delay.avg.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.68 � 57%    +142.9%       1.66 � 13%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      2.89          +107.9%       6.01 � 45%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.08 � 35%    +109.0%       0.16 � 26%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.02 �  4%     +80.4%       0.03 �  4%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.09 � 25%    +284.0%       0.33 � 53%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      0.01 � 11%     +36.0%       0.02 �  3%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.01 �  8%     +69.7%       0.03 �  8%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.55 � 11%     +64.0%       0.91 �  5%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.58 � 10%     +33.5%       0.77 �  7%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      0.03 � 13%   +2621.6%       0.86 � 46%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 �223%  +35991.7%       1.44 � 62%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      2.88 � 29%    +236.6%       9.70 � 65%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.62 �160%    +283.8%       2.39 � 28%  perf-sched.sch_delay.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.01 �100%  +17714.5%       2.05 � 47%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      2.10 � 48%   +8993.6%     190.59 �198%  perf-sched.sch_delay.max.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.02 �  8%    +176.3%       0.04 � 17%  perf-sched.sch_delay.max.ms.irq_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.55 �187%    +444.1%       3.00        perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      3.79 � 16%    +470.6%      21.63 � 27%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      8.61 � 71%    +162.4%      22.59 �  6%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.83 � 13%    +135.1%       6.66 � 85%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
      0.02 �  2%    +142.6%       0.05 �  7%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.34 �130%   +1108.0%       4.16 � 52%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     12.56 � 49%    +140.3%      30.18 � 19%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      4.20 �  6%     +57.8%       6.63 � 25%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.55 �  3%     +30.8%       0.72 �  8%  perf-sched.total_sch_delay.average.ms
     17.06 �  5%   +1093.7%     203.68 �182%  perf-sched.total_sch_delay.max.ms
     81.49 �  4%     -13.7%      70.33 �  5%  perf-sched.total_wait_and_delay.average.ms
     10823 �  4%     +17.9%      12764 �  4%  perf-sched.total_wait_and_delay.count.ms
     80.94 �  4%     -14.0%      69.61 �  5%  perf-sched.total_wait_time.average.ms
      5.78          +108.0%      12.02 � 45%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.16 � 34%    +109.0%       0.33 � 26%  perf-sched.wait_and_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    394.00 �  3%     -87.1%      50.77 � 58%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.09 � 18%    +203.9%      12.42 � 13%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     11.44 �  5%     -48.7%       5.87 �  6%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    544.37 �  3%     -15.3%     461.13 �  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     99.17 �  4%      -9.9%      89.33 �  4%  perf-sched.wait_and_delay.count.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    112.33 �  3%     -12.5%      98.33 �  6%  perf-sched.wait_and_delay.count.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
    577.00 � 18%     -52.7%     273.00 � 50%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      1463 �  4%     -58.2%     611.83 �  4%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
    624.17 � 31%     -59.2%     254.83 � 30%  perf-sched.wait_and_delay.count.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
     13.00 �  7%   +1356.4%     189.33 � 47%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    412.17 �  5%    +105.6%     847.33 �  7%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      3134 � 12%     +74.3%       5464 �  6%  perf-sched.wait_and_delay.count.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    373.67 �  9%     +36.1%     508.67 � 13%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    537.63 �  3%    +124.4%       1206 � 35%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      7.58 � 16%    +470.6%      43.26 � 27%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     17.22 � 71%    +162.4%      45.18 �  6%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      5.66 � 13%    +135.1%      13.32 � 85%  perf-sched.wait_and_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    306.84 � 13%     -23.0%     236.34 � 15%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 �223%  +28429.2%       1.14 � 57%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01 �100%   +6763.8%       0.79 � 58%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
      0.58 � 94%    +303.8%       2.34 � 17%  perf-sched.wait_time.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.68 � 56%    +135.8%       1.59 � 17%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown].[unknown]
      2.89          +108.0%       6.01 � 45%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.08 � 35%    +109.9%       0.16 � 26%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    393.72 �  3%     -87.1%      50.73 � 58%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      4.00 � 18%    +202.2%      12.10 � 12%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     11.43 �  5%     -48.8%       5.85 �  7%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    544.34 �  3%     -15.4%     460.27 �  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 �223%  +35991.7%       1.44 � 62%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.62 �160%    +283.8%       2.39 � 28%  perf-sched.wait_time.max.ms.__cond_resched.down_read.walk_component.link_path_walk.part
      0.01 �100%  +16615.9%       1.92 � 60%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.getname_flags.part.0
    537.63 �  3%    +124.4%       1206 � 35%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.55 �187%    +445.6%       3.00        perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_exc_page_fault.[unknown]
      3.79 � 16%    +470.6%      21.63 � 27%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      8.61 � 71%    +162.4%      22.59 �  6%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.83 � 13%    +135.1%       6.66 � 85%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi.[unknown].[unknown]
    306.82 � 13%     -23.0%     236.31 � 15%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread


***************************************************************************************************
lkp-csl-2sp7: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/option_a/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/5:1/debian-12-x86_64-phoronix/lkp-csl-2sp7/memcached-1.2.0/phoronix-test-suite

commit: 
  7c4f75a21f ("futex: Allow automatic allocation of process wide futex hash")
  bd54df5ea7 ("futex: Allow to resize the private local hash")

7c4f75a21f636486 bd54df5ea7cadac520e346d5f0f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  71701486 � 12%     -29.3%   50671505 �  3%  cpuidle..usage
      5.83 �  4%      -0.5        5.31        mpstat.cpu.all.usr%
   1025120 �  9%     -27.8%     740162 �  2%  vmstat.system.cs
    259599 �  5%     -21.3%     204388        vmstat.system.in
    669110            -3.5%     646020        phoronix-test-suite.memcached.5:1.ops_sec
     90456 � 15%     -44.7%      50004 �  4%  phoronix-test-suite.time.involuntary_context_switches
    225.50 �  3%      -6.1%     211.67        phoronix-test-suite.time.percent_of_cpu_this_job_got
    274.36 �  3%      -6.7%     256.01        phoronix-test-suite.time.user_time
  26283864            -5.1%   24931229        phoronix-test-suite.time.voluntary_context_switches
      0.12 �152%     -97.9%       0.00 �223%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
      0.40 � 40%     +58.5%       0.63 � 30%  perf-sched.sch_delay.max.ms.__cond_resched.__lock_sock_fast.tcp_ioctl.sk_ioctl.sock_do_ioctl
      0.12 �152%     -97.9%       0.00 �223%  perf-sched.sch_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
      0.93 � 50%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
     26.12 �  7%     +18.3%      30.90 �  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
    182.67 �  4%     -13.4%     158.17 �  4%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.93 � 50%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
      0.81 � 36%     -92.3%       0.06 �223%  perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
     26.09 �  7%     +18.3%      30.87 �  4%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2.05 �  9%     +33.5%       2.74 � 14%  perf-sched.wait_time.max.ms.__cond_resched.__lock_sock_fast.tcp_ioctl.sk_ioctl.sock_do_ioctl
      0.81 � 36%     -92.3%       0.06 �223%  perf-sched.wait_time.max.ms.__cond_resched.__release_sock.release_sock.tcp_recvmsg.inet6_recvmsg
    183.75 �  6%     -16.6%     153.29 �  8%  sched_debug.cfs_rq:/.runnable_avg.stddev
    176.68 �  7%     -17.1%     146.40 �  9%  sched_debug.cfs_rq:/.util_avg.stddev
    185.68 �  6%     -17.3%     153.53 �  8%  sched_debug.cfs_rq:/system.slice.runnable_avg.stddev
    185.56 �  6%     -17.4%     153.35 �  8%  sched_debug.cfs_rq:/system.slice.se->avg.runnable_avg.stddev
    178.74 �  7%     -17.7%     147.03 �  9%  sched_debug.cfs_rq:/system.slice.se->avg.util_avg.stddev
    178.74 �  7%     -17.7%     147.04 �  9%  sched_debug.cfs_rq:/system.slice.util_avg.stddev
     10.19 � 28%     +75.4%      17.88 � 25%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.avg
     12.79 � 35%     +78.2%      22.79 � 25%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.max
      8.62 � 28%     +76.3%      15.21 � 31%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.min
      1.17 � 43%     +88.1%       2.21 � 29%  sched_debug.cfs_rq:/system.slice/containerd.service.tg_load_avg.stddev
    840226 � 12%     -25.1%     628975 �  2%  sched_debug.cpu.nr_switches.avg
    865809 � 12%     -24.3%     655733 �  2%  sched_debug.cpu.nr_switches.max
    729559 � 11%     -23.2%     560221 �  3%  sched_debug.cpu.nr_switches.min
      0.00            +0.7        0.69 �  5%  perf-profile.calltrace.cycles-pp.futex_hash_put.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
      0.00            +1.5        1.45 �  4%  perf-profile.calltrace.cycles-pp.futex_hash.futex_wait_setup.__futex_wait.futex_wait.do_futex
      0.00            +1.5        1.49 �  4%  perf-profile.calltrace.cycles-pp.futex_hash.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     83.64 �  2%      -2.3       81.29        perf-profile.children.cycles-pp._raw_spin_lock
     83.12 �  2%      -2.3       80.84        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.41 � 11%      -0.1        0.34 �  7%  perf-profile.children.cycles-pp.futex_q_lock
      0.52 �  4%      -0.0        0.48 �  4%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.00            +0.1        0.08 �  8%  perf-profile.children.cycles-pp.futex_unqueue
      0.18 � 14%      +0.4        0.53 �  7%  perf-profile.children.cycles-pp.futex_q_unlock
      0.00            +1.2        1.18 �  5%  perf-profile.children.cycles-pp.futex_hash_put
      0.20 � 78%      +2.7        2.94 �  4%  perf-profile.children.cycles-pp.futex_hash
     82.56 �  2%      -2.3       80.29        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.40 � 12%      -0.1        0.34 �  6%  perf-profile.self.cycles-pp.futex_q_lock
      0.18 � 17%      +0.4        0.53 �  6%  perf-profile.self.cycles-pp.futex_q_unlock
      0.00            +1.2        1.17 �  5%  perf-profile.self.cycles-pp.futex_hash_put
      0.19 � 81%      +2.7        2.92 �  4%  perf-profile.self.cycles-pp.futex_hash
      2.84 �  2%      +5.9%       3.01        perf-stat.i.MPKI
 7.081e+09 �  2%      -7.5%  6.548e+09        perf-stat.i.branch-instructions
  74795847 �  5%     -12.2%   65682517        perf-stat.i.branch-misses
     26.36            +1.2       27.52        perf-stat.i.cache-miss-rate%
   1041600 �  9%     -27.9%     751158 �  2%  perf-stat.i.context-switches
      6.57 �  2%      +7.7%       7.07        perf-stat.i.cpi
     40782 � 12%     -26.8%      29848 �  4%  perf-stat.i.cpu-migrations
   7021013 �  3%     -13.0%    6107192 �  2%  perf-stat.i.dTLB-load-misses
 8.047e+09 �  2%      -8.4%  7.373e+09        perf-stat.i.dTLB-loads
 2.876e+09 �  5%     -12.8%  2.508e+09        perf-stat.i.dTLB-stores
     37.20 �  2%      -2.5       34.66        perf-stat.i.iTLB-load-miss-rate%
  14970466 �  7%     -18.2%   12253183        perf-stat.i.iTLB-load-misses
  31644049 �  3%      -4.6%   30187584        perf-stat.i.iTLB-loads
 3.132e+10 �  2%      -8.1%  2.879e+10        perf-stat.i.instructions
      2252 �  4%      +7.8%       2427        perf-stat.i.instructions-per-iTLB-miss
      0.21            -5.7%       0.20        perf-stat.i.ipc
    190.02 �  2%      -8.7%     173.48        perf-stat.i.metric.M/sec
      2.46 �  2%      +7.5%       2.64 �  2%  perf-stat.overall.MPKI
     29.56            +1.3       30.82        perf-stat.overall.cache-miss-rate%
      6.73 �  2%      +8.7%       7.31        perf-stat.overall.cpi
      0.09 �  2%      -0.0        0.08 �  2%  perf-stat.overall.dTLB-load-miss-rate%
     32.07 �  3%      -3.2       28.87        perf-stat.overall.iTLB-load-miss-rate%
      2100 �  5%     +11.9%       2350        perf-stat.overall.instructions-per-iTLB-miss
      0.15 �  2%      -8.0%       0.14        perf-stat.overall.ipc
 7.056e+09 �  2%      -7.5%  6.527e+09        perf-stat.ps.branch-instructions
  74481811 �  5%     -12.2%   65413115        perf-stat.ps.branch-misses
   1037883 �  9%     -27.9%     748724 �  2%  perf-stat.ps.context-switches
     40641 � 12%     -26.8%      29752 �  4%  perf-stat.ps.cpu-migrations
   6996630 �  3%     -13.0%    6086667 �  2%  perf-stat.ps.dTLB-load-misses
 8.019e+09 �  2%      -8.4%  7.349e+09        perf-stat.ps.dTLB-loads
 2.866e+09 �  5%     -12.8%    2.5e+09        perf-stat.ps.dTLB-stores
  14916761 �  7%     -18.1%   12212715        perf-stat.ps.iTLB-load-misses
  31534987 �  3%      -4.6%   30091319        perf-stat.ps.iTLB-loads
 3.121e+10 �  2%      -8.0%   2.87e+10        perf-stat.ps.instructions
  7.11e+12 �  2%      -8.0%  6.543e+12        perf-stat.total.instructions



***************************************************************************************************
lkp-gnr-2sp3: 256 threads 2 sockets Intel(R) Xeon(R) 6767P  CPU @ 2.4GHz (Granite Rapids) with 256G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-9.4/thread/100%/debian-12-x86_64-20240206.cgz/lkp-gnr-2sp3/pthread_mutex5/will-it-scale

commit: 
  7c4f75a21f ("futex: Allow automatic allocation of process wide futex hash")
  bd54df5ea7 ("futex: Allow to resize the private local hash")

7c4f75a21f636486 bd54df5ea7cadac520e346d5f0f 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
  23570282           -32.6%   15883630 �  2%  cpuidle..usage
   1862635            -9.3%    1689404        meminfo.Shmem
      2110           +19.0%       2512 �  3%  perf-c2c.DRAM.local
      0.16 �  4%      -0.1        0.08 �  4%  mpstat.cpu.all.soft%
      0.63            -0.2        0.46 �  3%  mpstat.cpu.all.usr%
   1264859 �  2%     -47.5%     664434 � 62%  numa-vmstat.node1.nr_file_pages
     38897 � 10%     -47.8%      20323 � 48%  numa-vmstat.node1.nr_mapped
    206687           -33.5%     137401 �  2%  vmstat.system.cs
    427708            -8.0%     393532        vmstat.system.in
   5060133 �  2%     -47.5%    2658326 � 62%  numa-meminfo.node1.FilePages
    158778 � 10%     -48.5%      81837 � 46%  numa-meminfo.node1.Mapped
   6620342 �  2%     -38.3%    4086741 � 37%  numa-meminfo.node1.MemUsed
   9566224           +33.9%   12810946        will-it-scale.256.threads
      0.18           -11.1%       0.16        will-it-scale.256.threads_idle
     37367           +33.9%      50042        will-it-scale.per_thread_ops
   9566224           +33.9%   12810946        will-it-scale.workload
      0.00 � 15%     +29.7%       0.00 � 15%  sched_debug.cpu.next_balance.stddev
    124704           -33.5%      82964 �  2%  sched_debug.cpu.nr_switches.avg
    230832 � 52%     -38.2%     142628 �  5%  sched_debug.cpu.nr_switches.max
     98911 �  4%     -33.7%      65543 �  3%  sched_debug.cpu.nr_switches.min
     17307 � 60%     -47.4%       9105 � 20%  sched_debug.cpu.nr_switches.stddev
    672002            -6.5%     628169        proc-vmstat.nr_active_anon
   1345624            -3.2%    1302363        proc-vmstat.nr_file_pages
     41725 �  7%     -16.3%      34939 � 12%  proc-vmstat.nr_mapped
    465688            -9.3%     422425        proc-vmstat.nr_shmem
    672002            -6.5%     628169        proc-vmstat.nr_zone_active_anon
   1956811            -2.5%    1908264        proc-vmstat.numa_hit
   1692181            -2.8%    1644262        proc-vmstat.numa_local
      0.20            +4.3%       0.21        perf-stat.i.MPKI
      0.05            -0.0        0.05        perf-stat.i.branch-miss-rate%
   9101814           -10.3%    8161953        perf-stat.i.branch-misses
  14404131            +3.7%   14939924        perf-stat.i.cache-misses
    207911           -33.5%     138184 �  2%  perf-stat.i.context-switches
     65204            -4.0%      62625        perf-stat.i.cycles-between-cache-misses
      0.01           -95.2%       0.00 �223%  perf-stat.i.metric.K/sec
      0.20            +4.2%       0.21        perf-stat.overall.MPKI
      0.05            -0.0        0.05        perf-stat.overall.branch-miss-rate%
     63438            -3.5%      61223        perf-stat.overall.cycles-between-cache-misses
   2250086           -25.7%    1671327        perf-stat.overall.path-length
   9086343           -10.4%    8139691        perf-stat.ps.branch-misses
  14400345            +3.6%   14922252        perf-stat.ps.cache-misses
    207422           -33.5%     137839 �  2%  perf-stat.ps.context-switches
      0.16           +99.2%       0.32 � 95%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      1.66 � 12%     +17.5%       1.95 �  3%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.vfs_write.ksys_write
      0.08 �  8%     +37.8%       0.12 � 20%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 � 12%     +47.5%       0.01 �  5%  perf-sched.sch_delay.avg.ms.futex_do_wait.__futex_wait.futex_wait.do_futex
      0.09 �166%   +1763.7%       1.74 � 65%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.09           +16.3%       0.11 �  3%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.98 � 14%     +28.2%       3.83 �  4%  perf-sched.sch_delay.max.ms.__cond_resched.shmem_inode_acct_blocks.shmem_alloc_and_add_folio.shmem_get_folio_gfp.shmem_write_begin
      0.18 �  5%    +248.1%       0.61 � 63%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.15 �186%   +1714.0%       2.76 � 49%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 � 12%     +45.3%       0.02 �  5%  perf-sched.total_sch_delay.average.ms
      2.91 �  2%     +61.4%       4.69 �  4%  perf-sched.total_wait_and_delay.average.ms
    556081 �  2%     -37.0%     350186 �  2%  perf-sched.total_wait_and_delay.count.ms
      2.89 �  2%     +61.5%       4.67 �  4%  perf-sched.total_wait_time.average.ms
      0.01 �  6%     +35.6%       0.02 �  3%  perf-sched.wait_and_delay.avg.ms.futex_do_wait.__futex_wait.futex_wait.do_futex
     18.90 �  3%     -15.5%      15.98        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    541651 �  2%     -37.0%     341352 �  2%  perf-sched.wait_and_delay.count.futex_do_wait.__futex_wait.futex_wait.do_futex
     11.50 � 18%     -84.1%       1.83 �223%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    253.67 �  3%     +17.1%     297.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.09 �166%   +1763.7%       1.74 � 65%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     18.79 �  3%     -15.6%      15.85        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.15 �186%   +1714.0%       2.76 � 49%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
     43.55            -1.5       42.06        perf-profile.calltrace.cycles-pp._raw_spin_lock.futex_wait_setup.__futex_wait.futex_wait.do_futex
     43.54            -1.5       42.04        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.futex_wait_setup.__futex_wait.futex_wait
     43.83            -1.3       42.54        perf-profile.calltrace.cycles-pp.__futex_wait.futex_wait.do_futex.__x64_sys_futex.do_syscall_64
     43.83            -1.3       42.54        perf-profile.calltrace.cycles-pp.futex_wait.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.76            -1.3       42.48        perf-profile.calltrace.cycles-pp.futex_wait_setup.__futex_wait.futex_wait.do_futex.__x64_sys_futex
     99.06            +0.2       99.25        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.05            +0.2       99.24        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.03            +0.2       99.22        perf-profile.calltrace.cycles-pp.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     99.02            +0.2       99.22        perf-profile.calltrace.cycles-pp.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     54.99            +1.1       56.14        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.futex_wake.do_futex.__x64_sys_futex
     55.02            +1.2       56.21        perf-profile.calltrace.cycles-pp._raw_spin_lock.futex_wake.do_futex.__x64_sys_futex.do_syscall_64
     55.19            +1.5       56.68        perf-profile.calltrace.cycles-pp.futex_wake.do_futex.__x64_sys_futex.do_syscall_64.entry_SYSCALL_64_after_hwframe
     43.83            -1.3       42.54        perf-profile.children.cycles-pp.__futex_wait
     43.83            -1.3       42.54        perf-profile.children.cycles-pp.futex_wait
     43.76            -1.3       42.48        perf-profile.children.cycles-pp.futex_wait_setup
     98.55            -0.3       98.21        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     98.59            -0.3       98.28        perf-profile.children.cycles-pp._raw_spin_lock
      0.37            -0.1        0.26        perf-profile.children.cycles-pp.pthread_mutex_lock
      0.60 �  3%      -0.1        0.49 �  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.58 �  3%      -0.1        0.47 �  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.20 �  5%      -0.1        0.10 �  9%  perf-profile.children.cycles-pp.handle_softirqs
      0.18 �  5%      -0.1        0.09 �  6%  perf-profile.children.cycles-pp.sched_balance_domains
      0.21 �  4%      -0.1        0.12 �  4%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.17 �  2%      -0.1        0.11 �  3%  perf-profile.children.cycles-pp.common_startup_64
      0.17 �  2%      -0.1        0.11 �  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.17 �  2%      -0.1        0.11 �  3%  perf-profile.children.cycles-pp.do_idle
      0.17 �  2%      -0.1        0.11 �  3%  perf-profile.children.cycles-pp.start_secondary
      0.11 �  4%      -0.0        0.07 �  5%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      0.11 �  4%      -0.0        0.07 �  5%  perf-profile.children.cycles-pp.acpi_idle_enter
      0.11 �  4%      -0.0        0.07 �  5%  perf-profile.children.cycles-pp.acpi_safe_halt
      0.11 �  4%      -0.0        0.07 �  5%  perf-profile.children.cycles-pp.pv_native_safe_halt
      0.11 �  4%      -0.0        0.08        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.10            -0.0        0.07 �  5%  perf-profile.children.cycles-pp.__schedule
      0.11            -0.0        0.08 �  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.06 �  7%      -0.0        0.03 � 70%  perf-profile.children.cycles-pp.futex_do_wait
      0.11 �  3%      -0.0        0.08 �  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.11            -0.0        0.08        perf-profile.children.cycles-pp.cpuidle_idle_call
      0.08            -0.0        0.05 �  7%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.futex_q_unlock
      0.07            +0.1        0.12 �  3%  perf-profile.children.cycles-pp.futex_q_lock
      0.00            +0.2        0.17        perf-profile.children.cycles-pp.futex_hash_put
     99.22            +0.2       99.40        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     99.22            +0.2       99.40        perf-profile.children.cycles-pp.do_syscall_64
     99.03            +0.2       99.22        perf-profile.children.cycles-pp.__x64_sys_futex
     99.02            +0.2       99.22        perf-profile.children.cycles-pp.do_futex
      0.00            +0.3        0.33        perf-profile.children.cycles-pp.futex_hash
     55.19            +1.5       56.68        perf-profile.children.cycles-pp.futex_wake
     97.95            -0.2       97.71        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.37            -0.1        0.26        perf-profile.self.cycles-pp.pthread_mutex_lock
      0.18 �  4%      -0.1        0.09 �  6%  perf-profile.self.cycles-pp.sched_balance_domains
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.futex_wait_setup
      0.07            +0.0        0.12        perf-profile.self.cycles-pp.futex_q_lock
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.futex_q_unlock
      0.00            +0.1        0.08        perf-profile.self.cycles-pp._raw_spin_lock
      0.00            +0.2        0.17        perf-profile.self.cycles-pp.futex_hash_put
      0.00            +0.3        0.33        perf-profile.self.cycles-pp.futex_hash





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


