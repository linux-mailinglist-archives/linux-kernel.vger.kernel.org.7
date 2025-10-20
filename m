Return-Path: <linux-kernel+bounces-860385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF07BF0036
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F361892FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB02E972D;
	Mon, 20 Oct 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+NoOv38"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE551643B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949983; cv=fail; b=Qh3i93Ljk4ogRGkYRGqUkdKgFCW/REq3Hsw1Jn/dwfJlcYP95YfGqCIZ63xbnO0hogaebL/G1h1hJEDUf4kyo1TFWWe9dD52yoRIRBrM2Ku+bXlaAYnKOK/Sm6Oh8kkEhJNBnsrNDb7a4U78Zue2DRlpKm8R4k/DtrrNu+svrCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949983; c=relaxed/simple;
	bh=Qh9g2jT449Dmpx45zjso7daVlNb8FUsHdc/p+9nXTXQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oA+4ILJjWEANQqiJYo2zsKgJF4XWLAcRc87FmFiPSfAzA15v2ydz0JihU78u2fFvtsW6TkoZqf8bqOUlohJ2L3nYrXb1sGJ65vqAw/vPbl3bBK0bX7CgrKuxi60tSyM7SKy3R6w+hJmyc6yND+mfK9pJo5pWRL4FsAZa+mMXgkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+NoOv38; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760949981; x=1792485981;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Qh9g2jT449Dmpx45zjso7daVlNb8FUsHdc/p+9nXTXQ=;
  b=a+NoOv38/UPBD54PcwAfdmbq6YNR5KRzPqM8EfJ7xi8tRJX8jjmVIDol
   gxapIJhDDdoAMyam8ys6swTMiPKFsu9T4Thr2yG0GRFPlnJhk4SnZvUzP
   A7kW3IUw38U5lA0nIaNUWWPfu2ZVRSqLtfJC97BJPQIaYaZuKJpKoVB2H
   O8N2m30xvK5y/hlRSsvf21jrrPyvB4JIo3UqfRCZMrtXpjA0PbfNAiRF7
   o26DcS11tdCPas6cvvvfDpHUxDkmmpTCqgdcu3A4UsxIQEgVIbbgAoort
   TO+SDzXajm6xFeiwyjhngLHwq6FpR5QgbQPq1En6x+uq/1KRApFk0ZLdc
   Q==;
X-CSE-ConnectionGUID: iMHlvbAHRECZskENHeQcQQ==
X-CSE-MsgGUID: X1R7tUYKQBGUwue6Lb+zDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62968759"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62968759"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:46:21 -0700
X-CSE-ConnectionGUID: 2JerKGgmSAuXoF3s+Ayv9g==
X-CSE-MsgGUID: VOQIgBxzRpaB3jLWXkZTfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; 
   d="scan'208";a="220426508"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 01:46:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:46:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:46:19 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUol5RxxEMXLXP9/G1Mlhv2CTr947SXGzxx13sDpTBZda54PY6iWdR9rdWGJj4Y2nDMPKG+OZsCCxIUDI98lZopTJzVmxfHrbBFi/kAhz6UoNQoJ/DIwWO/MZByHDROfP5kDTC9mE9/8jGvNW5Eo/4jdQJiJK5PVD06QlOjCjvd/6CTFPSCfZQwdBPJMFnC2/Wz33ROEgM8oi90mtEVGhDN1LLhBLzAIO8ABnpVzKRgnIU3EtUr4AvAPx6sLbSXX91GaKCjsS/ui89Mp8kHjVtlFreZ1GlFKgyQ1ub5hKP/V3Om/Q6QpwjBVjthzLMHZU9TiE/5Btg+jxjka6XydJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW3V7ubGDH0osl16BPrGxnbfCxxonpOIM2aDbN/4nXg=;
 b=DLhU5FUPBy+ROa+kGSiKNXmmZcs/xQ0hpGh7RpRw61GFjXVNLNQygY8sClVcDb01Rzr5LBoPC5MRlU6l7dTVSRvp8ZkVWzwiLL68/3HzylQ4+C37H1F0negnAKRCKTVOHFmdFUpDNQsrUC58buZTQOM6R0rQ+ZSmjb8l7heblu77oncy8XZr25iplx8W/g7h37nYmmEkRkMuJyoOLRNm01dDu2cdgju1LeUmhFuxEyx56MnKLku8XttJFh/mFdCWzA00Z7QZOrZ9u3u6owR63OJ9yHOjJ/c24P4/XWcso906fW/5LSkCZ40fML1sdrYjAZbI/t+m9dV1xEpGT1d3tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6333.namprd11.prod.outlook.com (2603:10b6:8:b4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 08:46:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:46:17 +0000
Date: Mon, 20 Oct 2025 16:46:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Szuying Chen <chensiying21@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Szuying Chen
	<Chloe_Chen@asmedia.com.tw>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <andriy.shevchenko@linux.intel.com>,
	<dan.j.williams@intel.com>, <gourry@gourry.net>, <jhubbard@nvidia.com>,
	<akinobu.mita@gmail.com>, <sumanthk@linux.ibm.com>, <peterz@infradead.org>,
	<huang.ying.caritas@gmail.com>, <Andrew_Su@asmedia.com.tw>,
	<Yd_Tseng@asmedia.com.tw>, <Ed_Huang@asmedia.com.tw>,
	<Cindy1_Hsu@asmedia.com.tw>, <Jesse1_Chang@asmedia.com.tw>,
	<Richard_Hsu@asmedia.com.tw>, <oliver.sang@intel.com>
Subject: Re: [PATCH] kernel: resourse: Add conditional handling for ACPI
 device
Message-ID: <202510201616.6e6b62a1-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017023531.5616-1-Chloe_Chen@asmedia.com.tw>
X-ClientProxiedBy: KU2P306CA0034.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 718a919f-674d-411d-d9fd-08de0fb5224f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5zhHgoldq2kmjVFytmtTHAZZK1zhaAYTVsR92vKoGOBik2oRM3SnMN8aG/Xy?=
 =?us-ascii?Q?K8ti0acR1PWIUWa9Lqmyg+47MTe2yDUJkVShG8gM/a8cDzW/enIo29VOZCKc?=
 =?us-ascii?Q?DRjg3oXKDDhi60ui9WXgph/GXHWufgTRgibGo7G8KwWIzMMENja8DwDFXdJW?=
 =?us-ascii?Q?Ns+CPOmSx56s0+caQeb6qgevh0t+LcHOwq3JcluTODUph6YoEOxc4w/hX6FG?=
 =?us-ascii?Q?PQ/8wXMfMNTOZvzFtFLWPsuWUwcgR0BSBxOf9ezJMRxUXSiiW8X1ntZTS1Px?=
 =?us-ascii?Q?ASEe85QB40tpudUj0ammB6LbhMqbzvy7Tydr0IHOl5TCq1jCtLejgVCqkRtM?=
 =?us-ascii?Q?E5uX3rQiLsbN4aSYdTJYKR6GEu9cQ9AaPX9zBE8IdmHQMAuFU+8d5+VbxelX?=
 =?us-ascii?Q?TFoQ/gtsbuTq0Wlmm2+V68NozuUV4+Q4QyLsq/sHaTn3b8YwXDUpe9ln+nXV?=
 =?us-ascii?Q?iU4CW79WZYAt0gmLEw0jE8FJIT7nIND34cwLMB909jpDUL+IPSMmukG6dT//?=
 =?us-ascii?Q?pGWmgNUdlIiIyGjtv1TTj3Q5ewDhyWaFuQ5JTUOrLjL08Qk8RTlBNprOKyZ7?=
 =?us-ascii?Q?SNm9C8E373qaxZf1jdF351IQ/MR3hRj9rrRez9/hxuAaiHsW55wEqDjIK92W?=
 =?us-ascii?Q?aISsspbibdRfyEGVPJROVHgcNa+TIOyaHIEVHTpL+8BE9m1eItwhJ/1iC0Vl?=
 =?us-ascii?Q?qPvymbenokW9F+3mx8s4T3NNSWiDjY9+3r1GthclJ5bL7Yt5ZFKQk8rdy0oK?=
 =?us-ascii?Q?PaCo3MmAt42+mzdAd8VQjzapHsFKLVKd5/OzN+DCNAAROzMTRYHdT0HnbPHt?=
 =?us-ascii?Q?8h+gy+GqjDOK/j1c5QXCTAu2t/BL+29eFF9BBgmlH0uflHU2zZ1J+1l9fKGJ?=
 =?us-ascii?Q?TyXb/FTehbO0tdorgEZzTCxBNlBkE9qijUg494Eba1kfT7MVdBq3QUb9H2Eu?=
 =?us-ascii?Q?K1Aap+hihnbdTyOMjpZXSVnMHAN3bC72Kdqx0KlVJoVSYEw+LGoWOsyPbN5D?=
 =?us-ascii?Q?CRoN3X1ti8bU8PbwEzC+RkUrNe/C92WKQXrPWUCkMf5ByV6x4UsV3S8pjYi9?=
 =?us-ascii?Q?cslTRhLJPH5X64xZ4PJHv30UGCOZFP1VATlaMeryxlzffOuReyZP6oeErBgL?=
 =?us-ascii?Q?2XWG3elRw9/sfus7lH6SP83ZGOu/swy5F9cDbHgPSMo9nb58bRjPg3WdKH+v?=
 =?us-ascii?Q?XLVicgPPrtwt4f92hjW/awMpmsKVAE8oWHy1fwRxjGntw/wqlBy4RZMx0GJK?=
 =?us-ascii?Q?SaY7s3Q96307LEcXmVFUeV3bkAeEv7w56sRWeNN4Xz0wIYHWQuXB4usaeYcz?=
 =?us-ascii?Q?NXGaw/8xgHGuDU95jk7ZIztm+wz7zpO3kCZnd3kUc2YCfWpaAv0dYFH8ELyU?=
 =?us-ascii?Q?2/Rgftbico55VpmHloBeHrzYa6NDPElN8TO85fBsnrOwbc1Q7KLR88teAzGW?=
 =?us-ascii?Q?NND/A6kN5QZD7CBfjlHO0zaVsWylI4uUoPm8HoRja1UDHcXPV9TAAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I8RV8K/QNWP20NgJChH/XquCvm3Cqr4WAHbdsURq6MZqrxGGrD1vwQM/eSV4?=
 =?us-ascii?Q?uZlKqmMhZdE7601ONUMfTbE3togWDdbexlMllYGZcjubF3kTv0vlqfYNYhsr?=
 =?us-ascii?Q?9Ovk58pe5psQMd3eul0Iz34HA6VAF63eATtypEIBJSbLMNJVdW//yxzDIDfN?=
 =?us-ascii?Q?nYw+Id161NnVxJ6TfVcLrBOMAeHrnSBBCKQoPKmi14EkYlV+9RnkII35tu7Z?=
 =?us-ascii?Q?AbOncYlXyMb9XOkOC7a2/tkKx7EHceh2cPH75YEoYrH2tvovLGSjd+9zfuyd?=
 =?us-ascii?Q?nZ+bDBUH6fgCzmEFLD/0TZ5eBuIC4GR94oxpr2AdWtl2fc+Mo6n8ck4QXy9z?=
 =?us-ascii?Q?j7nkIx2yDp6mVPVzie4EI+PaOASBP9hjgcD9UfEK/mm3D+Q2ib3W0JJZ5Z/R?=
 =?us-ascii?Q?RgpUbONkQmUW0xlCohDfoarZmOejz2whTDKSlSsoiYDWB8XQvCg5V+iKQtXY?=
 =?us-ascii?Q?U1tx7tEhU7WayUBz2gE6P+Haf32f5MmUIBEX4DKHn6+djO6z1/gLxuh5psnH?=
 =?us-ascii?Q?wl8eW5j9kRGZx+dB+iy4xx12zNCSv3nJ8dcg0mNRTARz53s4TIbYR4T22oZV?=
 =?us-ascii?Q?PK0UgoXSPHtz7EAzZGPjSnA/gBMLz7qLwaM6aI4yf1NB/WuFr49ofLvabG+Y?=
 =?us-ascii?Q?3DUMd9IdvzHQtvOcwCmXxcqyfYNFeIsQN1+NV4XHcC25Xud7KLLzCt++Bhsm?=
 =?us-ascii?Q?CNMZacuZBynbkMSsQjsLqIA7ElI3g2TyldFNSBBQyujmtW4JhXvvTzKvJgO8?=
 =?us-ascii?Q?afE+rIBAHrY9yjMIktxhzO063xaZ2V0h6fnkwk5HOUmqlDGWVPqe8/8AGee0?=
 =?us-ascii?Q?UBbP4C5ipZ+rr4LIJhC0TucddmEErL17CYgi/5MY6q8Yk8tsESgC7WU2nnbC?=
 =?us-ascii?Q?DApK+AeTaacXsl8OiPwhJIPgXbB7iL60R9cdm5hYuc3pIn6dCxSsjNw0k77K?=
 =?us-ascii?Q?U1hyeuB+851EAtrzHlmJ9/0o5/XjWtMxZNVcsFq2uQmrBss94j0i8EpSy3Ok?=
 =?us-ascii?Q?X6ZxA8s1Xh1rspdWlJfq0eImrwMoXeEgKYOXmK7ijmtoiXRGGmOdbF+GIPKj?=
 =?us-ascii?Q?ULacJ35X6ZY50ShN0bSn4GFFQTDhBOSe5QvO1fl7DP6IsFU9zmADexp2LiQ2?=
 =?us-ascii?Q?U//te55R9efyPrhM6MoUEwrEItvKTwcN3lNgk/V+s/PDK2zZNOuA22dnCCd8?=
 =?us-ascii?Q?T/UDJEb+Msu9CYobubnYcVf7weJHD6jrJ0Z5l3/erSGQrqMMx6qd1m1nnoT7?=
 =?us-ascii?Q?hXyQb9rR99M8OG1RznppFA7AHUDeCh1gT4tJuVe5piZHGhjdENFbpJynp+FD?=
 =?us-ascii?Q?HaaSEvFTdSgANk+5qwUgu7CQnldiCgN8ps+nXe1CnboSOTUP8pIrozwvrpIh?=
 =?us-ascii?Q?t58LVshbj4NsslH4VuzPdMH3yezp+wl7yYRicYQxAlBtdQk/SFtgCihXb9R6?=
 =?us-ascii?Q?KK6oH3x2HvwJU1to5hDXIL6HwBOKXjKWjN69M6+qckW6sMM5/dZ6vBdT1Qvv?=
 =?us-ascii?Q?t4vqxNx1VQWd8DlxSoT7mXAM5qDe/tUIo/Fq9Vv3/Rjoafz6KFtWUPyocecg?=
 =?us-ascii?Q?IXriCP7lk5arqjmfM3poM3XdOm3FZB0P4X2Ef4KhJJG01g8sTUcRZp7WqCSo?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 718a919f-674d-411d-d9fd-08de0fb5224f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:46:17.4017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVsAClXbXAzH2KCcL/h0f9TpDpm/3PHRc66zXQ+LzobFxbLqH/yrQ9oHHaCO31omJRdcqZmvKB0HJZ/5W/AeZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6333
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h" on:

commit: 871e73eea694be4705a5e3ebc9119e6c76c7b246 ("[PATCH] kernel: resourse: Add conditional handling for ACPI device")
url: https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/kernel-resourse-Add-conditional-handling-for-ACPI-device/20251017-103749
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20251017023531.5616-1-Chloe_Chen@asmedia.com.tw/
patch subject: [PATCH] kernel: resourse: Add conditional handling for ACPI device

in testcase: boot

config: i386-randconfig-141-20251019
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------------------------+------------+------------+
|                                                                               | 4d30e94233 | 871e73eea6 |
+-------------------------------------------------------------------------------+------------+------------+
| BUG:sleeping_function_called_from_invalid_context_at_include/linux/sched/mm.h | 0          | 12         |
+-------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510201616.6e6b62a1-lkp@intel.com


[    0.605114][    T1] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:323
[    0.606472][    T1] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    0.607674][    T1] preempt_count: 1, expected: 0
[    0.608383][    T1] 2 locks held by swapper/0/1:
[    0.609070][    T1]  #0: 82a715b8 (acpi_scan_lock){+.+.}-{4:4}, at: acpi_scan_init (drivers/acpi/scan.c:2748)
[    0.609944][    T1]  #1: 82686c74 (resource_lock){++++}-{3:3}, at: insert_resource_conflict (kernel/resource.c:960)
[    0.611267][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.18.0-rc1-00168-g871e73eea694 #1 NONE  6a82e794814861a45fb7fec961bde07e21f033c5
[    0.611273][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.611275][    T1] Call Trace:
[    0.611277][    T1]  ? show_stack (arch/x86/kernel/dumpstack.c:319)
[    0.611285][    T1]  dump_stack_lvl (lib/dump_stack.c:122)
[    0.611290][    T1]  dump_stack (lib/dump_stack.c:130)
[    0.611293][    T1]  __might_resched.cold (kernel/sched/core.c:8926)
[    0.611297][    T1]  __might_sleep (kernel/sched/core.c:8855)
[    0.611303][    T1]  __kmalloc_node_track_caller_noprof (include/linux/sched/mm.h:323 (discriminator 1) mm/slub.c:4906 (discriminator 1) mm/slub.c:5241 (discriminator 1) mm/slub.c:5626 (discriminator 1) mm/slub.c:5736 (discriminator 1))
[    0.611310][    T1]  kstrdup (mm/util.c:64 (discriminator 2) mm/util.c:84 (discriminator 2))
[    0.611314][    T1]  ? __request_resource (kernel/resource.c:187 kernel/resource.c:226)
[    0.611319][    T1]  __request_resource (kernel/resource.c:187 kernel/resource.c:226)
[    0.611321][    T1]  ? insert_resource_conflict (kernel/resource.c:960)
[    0.611325][    T1]  __insert_resource (kernel/resource.c:896)
[    0.611330][    T1]  insert_resource_conflict (kernel/resource.c:960)
[    0.611333][    T1]  acpi_pci_root_create (drivers/acpi/pci_root.c:952 drivers/acpi/pci_root.c:1023)
[    0.611342][    T1]  pci_acpi_scan_root (arch/x86/pci/acpi.c:582)
[    0.611350][    T1]  acpi_pci_root_add.cold (drivers/acpi/pci_root.c:729)
[    0.611359][    T1]  acpi_bus_attach (drivers/acpi/scan.c:2261 drivers/acpi/scan.c:2309)
[    0.611365][    T1]  ? sb_notify_work (drivers/acpi/bus.c:1142)
[    0.611368][    T1]  acpi_dev_for_one_check (drivers/acpi/bus.c:1146)
[    0.611371][    T1]  device_for_each_child (drivers/base/core.c:4017)
[    0.611378][    T1]  acpi_dev_for_each_child (drivers/acpi/bus.c:1158)
[    0.611381][    T1]  ? get_acpi_device (drivers/acpi/scan.c:2274)
[    0.611384][    T1]  acpi_bus_attach (drivers/acpi/scan.c:2331)
[    0.611389][    T1]  ? klist_next (lib/klist.c:403)
[    0.611392][    T1]  ? sb_notify_work (drivers/acpi/bus.c:1142)
[    0.611396][    T1]  acpi_dev_for_one_check (drivers/acpi/bus.c:1146)
[    0.611398][    T1]  device_for_each_child (drivers/base/core.c:4017)
[    0.611404][    T1]  acpi_dev_for_each_child (drivers/acpi/bus.c:1158)
[    0.611406][    T1]  ? get_acpi_device (drivers/acpi/scan.c:2274)
[    0.611410][    T1]  acpi_bus_attach (drivers/acpi/scan.c:2331)
[    0.611416][    T1]  acpi_bus_scan (drivers/acpi/scan.c:2541 drivers/acpi/scan.c:2614)
[    0.611422][    T1]  acpi_scan_init (drivers/acpi/scan.c:2748 (discriminator 1))
[    0.611425][    T1]  ? acpi_viot_early_init (drivers/acpi/viot.c:263)
[    0.611429][    T1]  acpi_init (drivers/acpi/bus.c:1470)
[    0.611431][    T1]  ? acpi_arch_init+0x4/0x4
[    0.611433][    T1]  ? acpi_arch_init+0x4/0x4
[    0.611435][    T1]  do_one_initcall (init/main.c:1283)
[    0.611444][    T1]  ? do_initcalls (init/main.c:1343 init/main.c:1361)
[    0.611449][    T1]  do_initcalls (init/main.c:1344 (discriminator 3) init/main.c:1361 (discriminator 3))
[    0.611454][    T1]  kernel_init_freeable (init/main.c:1597)
[    0.611457][    T1]  ? rest_init (init/main.c:1475)
[    0.611461][    T1]  kernel_init (init/main.c:1485)
[    0.611464][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
[    0.611466][    T1]  ? rest_init (init/main.c:1475)
[    0.611470][    T1]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    0.611473][    T1]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251020/202510201616.6e6b62a1-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


