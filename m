Return-Path: <linux-kernel+bounces-833417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BBCBA1E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F234F7B705E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6692EC094;
	Thu, 25 Sep 2025 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTjOzdSw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDD86353;
	Thu, 25 Sep 2025 22:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758841124; cv=fail; b=s7U4pMDSzXyYm2NEzoBL10MgTUIw91dkTFvmAHARHPergM9n/pJ3I7F1rGKd/BHrthua3TueR+qGmrqVoIiFeLpHyTb/zbYOtgjof2qpshvccTeZ/sOJ8hUWSFwN2d8IaDLGu07Eni1vL5feOFujUheN8gw7GmEeZnvdHsQVlxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758841124; c=relaxed/simple;
	bh=eW9zsknpzWN+Ff8eiD358VKZjTbFqwT7wH+tEaMa/zc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HvioVFc1wxUQ1WnJsgL35eu+NxS27BWBZ83CgEOGDbbME6lkqLGfkAhiJET2nuEUGmjGYC/45kAn6RAHe25hfnJVSl6L+vNf1xIj0y1fZX5rPsQb+uzjA/SkfTWAVtdGj6xrO7B95yolxHKUC9syMTjNVzULcyS4flKHu0o7yFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTjOzdSw; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758841122; x=1790377122;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eW9zsknpzWN+Ff8eiD358VKZjTbFqwT7wH+tEaMa/zc=;
  b=fTjOzdSwIJm3lC7esJvhomxp82AHKeckp6KFTGSC2UugNimUzWmZkB/C
   O8N6cjogtyb4peCOB84ZAiUpZ272L4f2e6qmweJOv+oXiRBhQiY4uhDKY
   9YiulYHtouVYvbjwOanJDsodKjO85qliyKmpnBgoPCumHFfknb9lMEVBG
   BDNa/NGlbM9zIeBNchfbyi4Zloi0/ATTyZk4KU4k/I/vrHkdoeHAqDRkp
   PxcUD1ZMgpzGt7lmBHN3PGhMxBh1DkzDpNBD8Xi1Rxv8FWSe1IbBl47Z8
   PvWTYSLqWt3azv981Cez9A4JqsjcDlAcwiGwNGM9/LUIS/iy+9Quvhfln
   A==;
X-CSE-ConnectionGUID: cVTItLhfSDyIMMjl2t5g2A==
X-CSE-MsgGUID: 7MfhxON6SYycjp2eIgGJTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71420610"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="71420610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:58:42 -0700
X-CSE-ConnectionGUID: uWJRJco7Tc6+XwKW12FtiA==
X-CSE-MsgGUID: +YB1k9xGSk27/ZQKyMhfuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177911014"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 15:58:42 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 15:58:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 15:58:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 15:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1dumepwmz/2FZ38RrLz6CBlFl14a2ItxctsdSMzUf1OII1LZmG5yBqb7y3rpMwBgmWbAGFZcttp7+KkTZIbQPaEOkCO9I6TZDg6ZlXsNexsKqzJmyP2qDwWa7wU/NcMqfZljgGk+u4P+z5FrPgCOQAyrGB+nxBU9pDEDBmgxj9ow9uQ+rQGaVvwu68OG09+RM1Lu4u5zFM35MWagONEHvT6Plmom55NsJY6nstxzE3P7e2ssCm4YUmldJv55Gy9vGOCbg+1lGW00nSwIROauJqnqFuKElkexAbIotSe/PmnoHg3cWx7Ea7GBtVjVxhNK06KmjR1dNkt6gs4G36SMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAzAPpLcVrBtWx/LGS4QQF3kZnPahOb5eskKXbZyCtw=;
 b=ZFO8iYeug2v5XDSSNaRmEIclQSQ7CPeA0BRGHfVT5mYFFTCj9xHs+gefccmjAijgUyFIUkDUp52njxPlFH/rltoHmGdm5ltzbPeTAGdKq/AiMo+ZmJFcwNjp4+NrgA/FpfukPFBZbb8Y1jEN8yKzEptsw8Uh52oposnsEuFf7zUvme2doyPTB1jXh4skbEViRad7Emz3fXovi5VRlj/gjhKkxLw3QSxdMkTkVfctS2eOO8Ir0HUTednmilLehZ5pG/nxzgZqHRv6Q5jwOCLNKc1uso8xAazBLDcsB6XGL9khZ54DzoaotdIffKZJ069dlyIXmaPkC2XVWnEqrY/N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) by
 PH7PR11MB7052.namprd11.prod.outlook.com (2603:10b6:510:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 22:58:39 +0000
Received: from DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1]) by DS7PR11MB6077.namprd11.prod.outlook.com
 ([fe80::5502:19f9:650b:99d1%5]) with mapi id 15.20.9137.021; Thu, 25 Sep 2025
 22:58:39 +0000
Date: Thu, 25 Sep 2025 15:58:35 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Dave Martin <Dave.Martin@arm.com>
CC: <linux-kernel@vger.kernel.org>, Reinette Chatre
	<reinette.chatre@intel.com>, James Morse <james.morse@arm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH] fs/resctrl,x86/resctrl: Factor mba rounding to be
 per-arch
Message-ID: <aNXJGw9r_k3BB4Xk@agluck-desk3>
References: <20250902162507.18520-1-Dave.Martin@arm.com>
 <aNFliMZTTUiXyZzd@e133380.arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNFliMZTTUiXyZzd@e133380.arm.com>
X-ClientProxiedBy: SJ0PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::22) To DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6077:EE_|PH7PR11MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2003d101-6aef-4df1-ee4e-08ddfc8710cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FmjMO44dM4LD2NlPnWzKGgTMGWZF+1MdMop4IG7HAcZhh57x2B4Q6Ew8rQNz?=
 =?us-ascii?Q?QfpNMu/XFvNlsRmgxVNAHUgtwW8Bi44S0mS/MpypoTWQ3/ngrGSobl+ri15H?=
 =?us-ascii?Q?PP4wyeeyBbPTk9YBawcM10dAXZZDfkOhWl1qLOkctYnBIGlWcM5BhHl3fm5n?=
 =?us-ascii?Q?/lEq+tWm2nVfnSow+FNZGYll+vaIuQUV59CQwP1PRHCgDTIw/uwKg+VrFaSi?=
 =?us-ascii?Q?lh5I6Cab+Kp6FErx8pIGuT3amvuIAi6i+/6DFOws2omn2duaLOUs61x4u7ty?=
 =?us-ascii?Q?PfUTwYIwhpzKjo6XNPTGJc3gVQx0Ytg7eEWfmB732UlZYAEbMvYp2+LJpCaM?=
 =?us-ascii?Q?oOc3j5Lni1V/UnGELzac1bqsVXLBzx1Tq9Rv3ggeVsf5Ow3ZTklcRrMpkl0l?=
 =?us-ascii?Q?o7QQP3enAjQxz/xvC7pzANOMHusQxRhcN7+6Aw8rjC1IL9KDoRv0PUuqHJwa?=
 =?us-ascii?Q?jzzvBO59vFI5vuv3cA1bRtg7N8CuHkTUK/U0KiBZBkgj8TMMUMyYtrQl7iBY?=
 =?us-ascii?Q?NHGq8nd6Z/sR2pyqK44OLXfTQqFNUxicFccvz7+TMkiHCM+YDhOAAGyT3f3a?=
 =?us-ascii?Q?nwAue7HQxlDrNeSkvJvmeCjNseZjLh5N3WJi2gvADtXk1kCilUM4q6IIQuzy?=
 =?us-ascii?Q?zGY869ALdNXwDJnFbs9/ylaKdu7qYaBFWxDtFL7C8UddBYU/B8Tq0C5wiks6?=
 =?us-ascii?Q?nVNe66OMt3RQ707rphxjZxCb0n89IVuwqi0Y8Qch1aQ6aSk5u9wGY9JUB8qI?=
 =?us-ascii?Q?GQeEPRCD3DYwdnEtGCZhxMkTDG5VuYkqu2FXr+efZkEFbbgS0cAwIYL0bgY1?=
 =?us-ascii?Q?oI3hUoInNhC0tzoxEDEW0DM//XIOujNxeQY8S84cU+vB2SaIqTschtm0OiBT?=
 =?us-ascii?Q?CD/aOQ3cJs29H2l3EYbybbJX12CiDCUH3pR1h2fiso7nrJshPCdFGpKh8Bjx?=
 =?us-ascii?Q?7zSnBbiAQB0rgN5nwAZ7PObd2bCeOTHE+wZHDXIzxKwU6rC4Bek/X744WUxP?=
 =?us-ascii?Q?zYwbRetu/7GgneCAcsfmeSrZQ0j09BuDIdzzNcgB7eE6FnT1Y/7IpU2/FHwS?=
 =?us-ascii?Q?OdUIh//OWQPcZFTMSIOBi34eXtPgI+C6aRQ6CQLsIfg+N7U7VuMs85JK+NBC?=
 =?us-ascii?Q?N6XuypKK6tgiTmRJnJ6zLHTfVvcwwSYxrrxIe7AjN1wpggL4d5fodgg6Hi/r?=
 =?us-ascii?Q?dEynQ8Ir04kMlpOZYg55+ysCrcbMGwMX859wdh/4sjHCiNzOsjCj1+QJm3rb?=
 =?us-ascii?Q?anvny4TFd483QPfX9SccOimmUfThduA+zatESdQRiLz2TSxWti5d1o19EYXu?=
 =?us-ascii?Q?O4U/llVAwAYxgvAH+JrBnY+ktH11nXXOX28cs1u6CDMtiP4pWWHCTan9wSMX?=
 =?us-ascii?Q?m6RLgTi9qNEEyt1SbfCP/NI4hUDeOMcJHOkWuskWg2m4375qc90Xrt5qaxNV?=
 =?us-ascii?Q?3ketUtS7wmdD8X4nj/U35gEAmZtxwtUa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fyDoze1HnQoNe/B5/yCpBaYZTO+/4UWhRgosCebVYxgg7xLrKSRG8CgOGMCl?=
 =?us-ascii?Q?mKZGD03PL3Q5DrNfQLB/lHi2bUhy9UocHScE00ois2BLQaI5IRQzhHLUvcIE?=
 =?us-ascii?Q?UDVmKVzz/7uQ8To4NSkUy30c3cE100qJkaTBidEkYpbiWLmtgAJesAzqIWgP?=
 =?us-ascii?Q?Wsh+t2yr7N3f9MvdXQBZV9Vb/1+GoYpzqO9CYw+1PpeE9vfSkHonTkbdQUjy?=
 =?us-ascii?Q?vh498O8OFMVpq9320oDzL7enNojkCgsXmHaEOSfWA+MKnxDQATjntta57mAW?=
 =?us-ascii?Q?BrkyaMbmNPc4/6IzFjpDGy46G5zvlGNKt12iScJAaoBOc4caby6Bvg0vSEY6?=
 =?us-ascii?Q?illQKLLIdYaKZd2OxiMdndOX1dJKjmUgfM7zbfjQ8xB/acNC8S8cz2XhBFlN?=
 =?us-ascii?Q?lwPiLFJiWvDqabEHGMJz0cdR/SKTUmapuemMDos8ogVzhrPlg/OVOgJJsWMn?=
 =?us-ascii?Q?3HR1JnwJioh91jLfNBHCfnIcfR3T5liylT4ns+RyeY62oij2lofTaGPpQSoB?=
 =?us-ascii?Q?F46KqhOp6FhGyIR2w7IWe0gLwEBBoi8khC5gPB0gi4X5dl+y2khd4DAUH6Rk?=
 =?us-ascii?Q?xXyHH1oz6Benfe70HxNKqLfxnx1H5LXexZDCnpdXuXcDUKfMvSqc3zew5wSq?=
 =?us-ascii?Q?3odSKMx4GQF6OAAVm3R/alcKM1jT+eYzOoKLM7MoIKSyPe6oeeWiS3icFgFT?=
 =?us-ascii?Q?yauW1DMGsKzm/5qm2+hMplR6BMotgCRbOaVzo9M8Rtlct5gpHrFFd/YFb1RD?=
 =?us-ascii?Q?BxwgYPiJi5Rdg6duzyJzAI61SvkVMc3+s9t6nvkN5FFz4E/B/wgPe7ZETtuL?=
 =?us-ascii?Q?atIoiXGXNuQVPT9iUeOBr5jI8Be32nn/TM+egkEqv0Sfwe11mYEdtch5EH+0?=
 =?us-ascii?Q?5ayG70RUmTVV8+QNagdNiwJ39JPshxD9s0/uy7bjJpZVUgTFueMEDFqloQHx?=
 =?us-ascii?Q?8Xqg18Z0Kmhgyz4rlYsNZ07YciGMujXt5GXrmlNDcKogvxTTn3e6oplih3Qc?=
 =?us-ascii?Q?u0GBqkuq7V3GGSEnqOK6wmt7mtErXYqkQZyGE5YW93eas83QaPIg/kxMJFNN?=
 =?us-ascii?Q?3rLqLXctPGcyNQZ7XmtExP49ov1H603ltW5REMHidHU68lGrmJzij1hiDE2t?=
 =?us-ascii?Q?HGZusmPkconI30vDy8VsdVqaVkEYm7AH5IY7e/NAPHE0Ua6YvneAnE2vSRVw?=
 =?us-ascii?Q?ky+WAHOCX2UXDY5RuX+lNeGoDCcM0I/m1WWBEpKVOo5AsBHXsKI7Oa6SPetN?=
 =?us-ascii?Q?OWVUe8JMJBcZEVdZ5ZW+nLYPhOZSH8EUxFwkJnRnzMrmkWDCGDHIGQnU4HD2?=
 =?us-ascii?Q?arNpocPEoNhydp/7rxa4IWoElc6ig3lhJIXcivtTKF6qoTyUg00GGTSzCC5d?=
 =?us-ascii?Q?ndStcF73blGpMuYcu/JTnZBPP63pvnUOJg6loNjuMYzl09hBRyj474YqTQBq?=
 =?us-ascii?Q?1Udcz1HpTPa11Va6gS2gmCbmbSe5lRgXhImAvNR1p2+R0oQGTy2iWnr6KJpc?=
 =?us-ascii?Q?XuYA7Ms4ZV9mWEOMdoD3VoSTF+Jtg+AMHNiF+4eyLhP4BJ5p+a0Ocd1gaP3x?=
 =?us-ascii?Q?yEsIibY4FrEl2nakZMuPA0o9qoliGRX6CrklHhiC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2003d101-6aef-4df1-ee4e-08ddfc8710cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 22:58:39.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmyOw94xW8DAEp0SDYVtBRz2DjfynYZxVypPhq+QyedTnkJh5F5yvHua+eApgEpd5SoiSCqNsFEIyZgm6xCowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7052
X-OriginatorOrg: intel.com

On Mon, Sep 22, 2025 at 04:04:40PM +0100, Dave Martin wrote:
> Hi again,
> 
> On Fri, Sep 12, 2025 at 03:19:04PM -0700, Reinette Chatre wrote:
> 
> [...]
> 
> > > Clamping to bw_min and bw_max still feels generic: leave it in the core
> > > code, for now.
> > 
> > Sounds like MPAM may be ready to start the schema parsing discussion again?
> > I understand that MPAM has a few more ways to describe memory bandwidth as
> > well as cache portion partitioning. Previously ([1] [2]) James mused about exposing
> > schema format to user space, which seems like a good idea for new schema.
> 
> On this topic, specifically:
> 
> 
> My own ideas in this area are a little different, though I agree with
> the general idea.
> 
> Bitmap controls are distinct from numeric values, but for numbers, I'm
> not sure that distinguishing percentages from other values is required,
> since this is really just a specific case of a linear scale.
> 
> I imagined a generic numeric schema, described by a set of files like
> the following in a schema's info directory:
> 
> 	min: minimum value, e.g., 1
> 	max: maximum value, e.g., 1023
> 	scale: value that corresponds to one unit
> 	unit: quantified base unit, e.g., "100pc", "64MBps"
> 	map: mapping function name
> 
> If s is the value written in a schemata entry and p is the
> corresponding physical amount of resource, then
> 
> 	min <= s <= max
> 
> and
> 
> 	p = map(s / scale) * unit
> 
> One reason why I prefer this scaling scheme over the floating-point
> approach is that it can be exact (at least for currently known
> platforms), and it doesn't require a new floating-point parser/
> formatter to be written for this one thing in the kernel (which I
> suspect is likely to be error-prone and poorly defined around
> subtleties such as rounding behaviour).
> 
> "map" anticipates non-linear ramps, but this is only really here as a
> forwards compatibility get-out.  For now, this might just be set to
> "none", meaning the identity mapping (i.e., a no-op).  This may shadow
> the existing the "delay_linear" parameter, but with more general
> applicabillity if we need it.
> 
> 
> The idea is that userspace reads the info files and then does the
> appropriate conversions itself.  This might or might not be seen as a
> burden, but would give exact control over the hardware configuration
> with a generic interface, with possibly greater precision than the
> existing schemata allow (when the hardware supports it), and without
> having to second-guess the rounding that the kernel may or may not do
> on the values.
> 
> For RDT MBA, we might have
> 
> 	min: 10
> 	max: 100
> 	scale: 100
> 	unit: 100pc
> 	map: none
> 
> The schemata entry
> 
> 	MB: 0=10, 1=100
> 
> would allocate the minimum possible bandwidth to domain 0, and 100%
> bandwidth to domain 1.
> 
> 
> For AMD SMBA, we might have:
> 
> 	min: 1
> 	max: 100
> 	scale: 8
> 	unit: 1GBps
> 
> (if I've understood this correctly from resctrl.rst.)
> 
> 
> For MPAM MBW_MAX with, say, 6 bits of resolution, we might have:
> 
> 	min: 1
> 	max: 64
> 	scale: 64
> 	unit: 100pc
> 	map: none
> 
> The schemata entry
> 
> 	MB: 0=1,1=64
> 
> would allocate the minimum possible bandwidth to domain 0, and 100%
> bandwidth to domain 1.  This would probably need to be a new schema,
> since we already have "MB" mimicking x86.
> 
> Exposing the hardware scale in this way would give userspace precise
> control (including in sub-1% increments on capable hardware), without
> having to second-guess the way the kernel will round the values.
> 
> 
> > Is this something MPAM is still considering? For example, the minimum
> > and maximum ranges that can be specified, is this something you already
> > have some ideas for? Have you perhaps considered Tony's RFD [3] that includes
> > discussion on how to handle min/max ranges for bandwidth? 
> 
> This seems to be a different thing.  I think James had some thoughts on
> this already -- I haven't checked on his current idea, but one option
> would be simply to expose this as two distinct schemata, say MB_MIN,
> MB_MAX.
> 
> There's a question of how to cope with multiple different schemata
> entries that shadow each other (i.e., control the same hardware
> resource).
> 
> 
> Would something like the following work?  A read from schemata might
> produce something like this:
> 
> MB: 0=50, 1=50
> # MB_HW: 0=32, 1=32
> # MB_MIN: 0=31, 1=31
> # MB_MAX: 0=32, 1=32
> 
> (Where MB_HW is the MPAM schema with 6-bit resolution that I
> illustrated above, and MB_MIN and MB_MAX are similar schemata for the
> specific MIN and MAX controls in the hardware.)
> 
> Userspace that does not understand the new entries would need to ignore
> the commented lines, but can otherwise safely alter and write back the
> schemata with the expected results.  The kernel would in turn ignore
> the commented lines on write.  The commented lines are meaningful but
> "inactive": they describe the current hardware configuration on read,
> but (unless explicitly uncommented) won't change anything on write.
> 
> Software that understands the new entries can uncomment the conflicting
> entries and write them back instead of (or in addition to) the
> conflicting entries.  For example, userspace might write the following:
> 
> MB_MIN: 0=16, 1=16
> MB_MAX: 0=32, 1=32
> 
> Which might then read back as follows:
> 
> MB: 0=50, 1=50
> # MB_HW: 0=32, 1=32
> # MB_MIN: 0=16, 1=16
> # MB_MAX: 0=32, 1=32
> 
> 
> I haven't tried to develop this idea further, for now.
> 
> I'd be interested in people's thoughts on it, though.

Applying this to Intel upcoming region aware memory bandwidth
that supports 255 steps and h/w min/max limits.
We would have info files with "min = 1, max = 255" and a schemata
file that looks like this to legacy apps:

MB: 0=50;1=75
#MB_HW: 0=128;1=191
#MB_MIN: 0=128;1=191
#MB_MAX: 0=128;1=191

But a newer app that is aware of the extensions can write:

# cat > schemata << 'EOF'
MB_HW: 0=10
MB_MIN: 0=10
MB_MAX: 0=64
EOF

which then reads back as:
MB: 0=4;1=75
#MB_HW: 0=10;1=191
#MB_MIN: 0=10;1=191
#MB_MAX: 0=64;1=191

with the legacy line updated with the rounded value of the MB_HW
supplied by the user. 10/255 = 3.921% ... so call it "4".

The region aware h/w supports separate bandwidth controls for each
region. We could hope (or perhaps update the spec to define) that
region0 is always node-local DDR memory and keep the "MB" tag for
that.

Then use some other tag naming for other regions. Remote DDR,
local CXL, remote CXL are the ones we think are next in the h/w
memory sequence. But the "region" concept would allow for other
options as other memory technologies come into use.

> 
> Cheers
> ---Dave

