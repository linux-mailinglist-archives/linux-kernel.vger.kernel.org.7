Return-Path: <linux-kernel+bounces-859525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA13BEDE4A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 07:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51DF14E20CB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 05:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584821AAA1C;
	Sun, 19 Oct 2025 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPeG1kQx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7C1E520A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760850459; cv=fail; b=fQVWnghD13nuoj270Bc/+OCCJjCPhkxo0U7s3soxQe1dpbDT+4pAiKhWywypQ06hzfnkbyaUUeey4E3gksEDOpxh1SEfTcsoNz+kWQC6A2ZYT9DGRrwH8PX5+EmtctYRDHbBT7x4WvhcM2WO5LDRZiB3ZYMYBh0Q02O3UvLi34Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760850459; c=relaxed/simple;
	bh=UmsOZuppTWL4BDrQz3EgulrQYiNLeRRz3IcXd3QCN1o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o8zKEntZLgyv5B+eg9ThoZuHknmEmRzyjRXR5V/FjPox/f99LnCGbG6/0e+1/UvjMJ0oTPcuzBBxg20wb/UZFHDegJ75/ickNST6NXKDiqYJKbEJkx1A9hakT2FwkAEZpXjnPVCWUiELUyNsuY9DWtgEExlN5zYCLLRPklwLK+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPeG1kQx; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760850458; x=1792386458;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=UmsOZuppTWL4BDrQz3EgulrQYiNLeRRz3IcXd3QCN1o=;
  b=FPeG1kQxh5zlaK2oe5k5K7C9zl89PmaOQAJUBJr3EzHW8po2PYcOCST1
   UxblS/A5A0ZcP8AqrwbpBDqshQ9alIxY98XpZQqW4YYhEMlz7Yb7zLNsf
   gChfEyS7grHcNzV6pgN7J5tOArrBUOcTUjro1sYYl3osHj3RKEHh6BZQj
   LJdQYg+DaXRvEy6XF7Z6mDx6b+a/sMuyjI3d+q4nHoecoWCODiSgH4O3A
   CM2pz07viUmsdAewUHMBfErnK3D0hiYhutVPs1jK4Bf9M2+r8tn4tFzQT
   9GyZo/xgyNWuUY0poV4Iewks8Wbko065auQrIlyyRI4BdEsBaBoQh9lZA
   A==;
X-CSE-ConnectionGUID: kmxf8bdBRL+FPHy72aINMQ==
X-CSE-MsgGUID: UMpFNvwvRb+++nzXZinsPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62907786"
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="62907786"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:07:37 -0700
X-CSE-ConnectionGUID: ytzGQ3paTMeQGRAglW4azg==
X-CSE-MsgGUID: Wpm0MTciSJW5h9gv4BvQDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,239,1754982000"; 
   d="scan'208";a="182766528"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2025 22:07:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 22:07:36 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 18 Oct 2025 22:07:36 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 18 Oct 2025 22:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0sMLIYJz2pfh3IaJn7KgTHy7uI0ud2/YDI/jgFwdYBhEGUDbxJb6miUKRaE6KNmMdf5tRTWuH+rzR42bWKFv6QtY4wRKuri3835TYgPOXDY/g5ZdjUPoE0esQXNUAq1MuM/uAIIJn/X4fUkyTsBKnay7Tyjcq9QrTobQwdN0yJBp+dng+f6Lf5ecKOq9QwpHkicA8U7kZG4JqmKI8ndzvn2tnI7HcPgvjC6w4Xb87R1HENpd3OXoDf8/1dSgWeGK0DL+W+xoUKUGSn+IHDk6Mze/TxBrXoWqR8u2X3uitXzSmL+n+NCnDNRI9QpRmG8lx0JPLkCurDyhiVFoxxZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSZjgVYvL7A0YdGfoFOYP94J3IDkN8VTqzj6QsR5vk0=;
 b=hESw812lqGppdnLKwk+NkjNWKadUPqoYWTrCZ6jpUVJZLhalA7H/y3A4ta/NEarzZHjaw51l0Wyg9Ez5FFxSWWutodwOXbSpC6veM02WNGYdpagGdUlIMeL1Wg80prrctzCgob3JowX+hbCmmoH0ACeVon3ZVERTcfufXOIU5Q19TE9MXh1fVbgH6Vfgk/XKTKX6imjweByEPGIyaQw77tEtzTgckYaWKzp0zvWlGjON9cUKYIRE+eqYH+QCNBRRa6uOPxFqfJjnectJtYcX3sG2kVvlb4cQJWMGmaadX3N41Azg2CLxisOVBmvIAobf78auvu0CjuXvthwB7C1HzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by PH3PPFEC5C0F28D.namprd11.prod.outlook.com (2603:10b6:518:1::d5c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 05:07:33 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 05:07:33 +0000
Date: Sun, 19 Oct 2025 13:07:22 +0800
From: kernel test robot <lkp@intel.com>
To: Borislav Petkov <bp@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, X86 ML <x86@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>
Subject: Re: [PATCH] objtool/klp: Add the debian-based package name of xxhash
 to the hint
Message-ID: <aPRyCq55erNhA8CI@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251017194732.7713-1-bp@kernel.org>
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|PH3PPFEC5C0F28D:EE_
X-MS-Office365-Filtering-Correlation-Id: 874d6dc5-f92f-4b87-d108-08de0ecd6807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?THXC3QrVAIqkF6eYB4sSCGDLwAGQv5Vlfr/ydeHeDsoxT4WFWiL0FPWZiMiz?=
 =?us-ascii?Q?wD8tx2F0CeZ8LZQeRWc6Xl/8bEdNb6jCFRocFX2bTtBxCTd158UQzi4Q8bNj?=
 =?us-ascii?Q?4PRvY9qGhu1aIM3CtXW4mvxbbCg49DRKdIWI5rKnUwJm4h9LeQ+Jg/dyyuI8?=
 =?us-ascii?Q?/CJnNgVwAcvdNMjONud53RUJVVsRI4t+e50Vw+0uK8S45GyMR4I4VDnUblH+?=
 =?us-ascii?Q?lrBCQBN4tnBG3syC9Kkggo2VTvwYbcioCiInwcPoook4YR961vG5x7+ws0t1?=
 =?us-ascii?Q?wqmzEdBNoi2I7UjbKkgAfaw+PEY3Y+0t662GVZu9WE892YHpu+wUrJxsIemN?=
 =?us-ascii?Q?n44HzBAoo6DHc//aDi1CmrbG99URGGHOUz/HjxcDOTMdtxYYhO+HUjQWivlB?=
 =?us-ascii?Q?dfh88E/prUZk1aF+shC0o3OLJ0DZaPfVMf78lN+Rv6vnhaC2EPiSQLrVtNRY?=
 =?us-ascii?Q?TwXDlUrw2xYchKBxkgZ9XqHgtmA/dlraUDBY+7bU6FakRXhqFlAetl91O8fe?=
 =?us-ascii?Q?Rwb/LapmZ3TtSg2+Zy/uXQ/ZALyDefvI169AQg0+n3FqmQNdhwASdaFAN7AT?=
 =?us-ascii?Q?luBBgR+wRHEfA4LhB8fOt9d5gbJjO/pDhgwp5ek18AMdN56u6sCTLuAgZ3JF?=
 =?us-ascii?Q?1K0LtOwrcQoLygRUOTaikXEDic9sxMGJg0d4gEBuBjnpTtmB7e5oMYo2eLE0?=
 =?us-ascii?Q?YYik7TUk1+72DP/HqNnxuf6Xs5VxJ1PUpnfbVFLjeUNtcgNWSpLw6COIcSCb?=
 =?us-ascii?Q?TKCNrAyFg8E+ExjAKWVxb1acmFNNCAEfBnLzktz2xtfCIob77JeGEEljb5bc?=
 =?us-ascii?Q?PU1U/HmRLedAvFrR/+eWIKQKah4IvsBYdYoIFgkbHiF9K+9GT4ij1j0LVlku?=
 =?us-ascii?Q?wJj1SQh+lu8pd+H9YYAEzXvzuRUkDWbaU8/ixeyEUvGBTEM+Q4gfUqd6Mthn?=
 =?us-ascii?Q?+pB6xDY6Ni9SVdanCMIpT+91uBgSX7Rlkui0iq1eROJsYIPfAl8nGVpr/WZG?=
 =?us-ascii?Q?lshfj9wEWn39mMkx9g61gdb+Lj2mJg9zGZSzQCrcrbigrLSNNvryd+la9fD2?=
 =?us-ascii?Q?kRHHVb3vrbvK0bUOEbES0ZhBpwhICxiXtaJe/u91+8jNzETCQMnT6bk0bgFv?=
 =?us-ascii?Q?g1cbGa/Quql064j/FINqFmiQDInNxa+yqyi7yAfIGQ6mCoyK1G4xxv3DPPVU?=
 =?us-ascii?Q?TeMzv+pgHDptJE9J1IPq4dY1A/Ork5Xjs5UzQ4XXjivkX6Y5xUkEr19OiRji?=
 =?us-ascii?Q?48AxYPxUCYbjvpXVDUg5gGh5rclp/PKv0pK/4wnwIjY+o4b+FjrdHTeeTU6N?=
 =?us-ascii?Q?hB5Ig51I+CD4l9G1h1qE3TEdB3lePmZaWcQHDlqg9t08wwL9IT75rm+QdpyI?=
 =?us-ascii?Q?sItSZmYaTBlvT7E6djxYfQSEKFV/vevWA2xjhk8u66yPNXZi0vh+W/8pw1Zr?=
 =?us-ascii?Q?q+fXII0dwOsl7PMfzPA5qColvldZQgBCGTpuG57UTrEPEGyRwcwVQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LS7qknvsMfFeDo/sf6rhj0V6Pc1I7NpMawW0f31dW+cnXgMylpxQ3vsP6RQ0?=
 =?us-ascii?Q?/1U9NgQthx80srq3+ZXd67ohwIXBUUT4XYQd7bs4iBm4FT/CX44V+hjWD1oM?=
 =?us-ascii?Q?3qEl7zvVZivfQQT9orH38fF11nr+hxt5t9PMCNEfa7SYFqO9cb8hv1+72S/M?=
 =?us-ascii?Q?BKIM9myYmMx4nIAMCcwj1xb/HVAX0tP/KY7gp8OVzj6d7+vSoG/eEri5MlLN?=
 =?us-ascii?Q?l/v0fhwHHE7pKFRHaE9swG6KFMG42brQi7ElkFCTcCyMPO24dmh9k+3LO9hl?=
 =?us-ascii?Q?XZIF+gXLqkZJmRGqPu1WgZgFysiJLvWZ0+lfYbzRL0pLfUdDzRSy2wTwCUh1?=
 =?us-ascii?Q?G8EBH3sYA3F9vrOo9YADcOQGXsj0LxdTmzWdirMcuDKGc2MaT8mVCMRA/THo?=
 =?us-ascii?Q?yz89d9N+W4tQvB8/+pH7FzMF5zmzvKNr1S3wUPEuVypKpyvH6vQseHkSjXlY?=
 =?us-ascii?Q?IOWLCuLwQwKwOI4vHAtXq+xEgolvwz0j5jdkSQsaNhW3XgIP/mFyRNyUi/oP?=
 =?us-ascii?Q?a0r+GgoiGem0h+rlWQHm64JPB7hGtcJbmA0s/x7/A/UFgYciZA/OwoMWDDic?=
 =?us-ascii?Q?t8FgVY7+KHt10Iw4SzI0AiSkEeV+Hdb5C8KY9UGV5uwB1Bs6FPZqbdQ7Hn6R?=
 =?us-ascii?Q?iUxbptSxvVCAK4XS8vYSGPLxq8aFRXUpmgDzxH5nesgmpOcENjWDx2z8sl7d?=
 =?us-ascii?Q?OA+yGOc2dLS7x5ISg/+NwKC0BoRybAOB5tDtZhuM2VzSuDcET38/N2p90ZzY?=
 =?us-ascii?Q?t5bVd/gSCg4+tLHYLOkopjV51n/5KeftV04jjnXufx36EbNyu4HRv/cyFz5Y?=
 =?us-ascii?Q?sTKMMLIbSs2UVFKByiqmGdQki/ANcUJoQyvMMYJFt9uxU61ivU1rpWLIHbZ0?=
 =?us-ascii?Q?SwV+A4hzOnXbActEYF6l06HmiNU+rrCxD35KPodT0ZCITtGgTs5gdAGmx166?=
 =?us-ascii?Q?CXchDeVgMwYPbGqh1u4n8R+cMDPINpBEWl5x+3jQ/DM5mdfkbD/llqI6uYXb?=
 =?us-ascii?Q?g9JAWmORHUNZG32/yCovalgnzvUCbCZ7aFOrcrWMG1e/HAdKTO29Pw52vEyU?=
 =?us-ascii?Q?JhxRgl/wj/mvWIhnpMvh2I2d9ixK6r47M1mJu3QVhhMjIMYdCoWOoQL7Mqvh?=
 =?us-ascii?Q?H0q6o2cvmO//CeqS6GLe9gY7Y2arGBtNuX5P4IXKkSgOkrwBHronZUcrOpFg?=
 =?us-ascii?Q?k11KHxIh9+byveKleewRGvw123eenpaygZmqZxDcnT8muiEXxUzmdA3EVhl8?=
 =?us-ascii?Q?xNztMgl679kA37OKIwat7/PRHuM0W7+BIdoZyhQ1YO4sNNd0STWgODtb0L5s?=
 =?us-ascii?Q?8iQuUajdp4WCKr6JAlUhEh9noOTERB8HF8ye8Oys8+TmEMnMNOchmIcavJMj?=
 =?us-ascii?Q?NKzZriqI1rraA2/InSfGU+CT/KxXSDko5Hpy2ICmIHJOH+Y/EKac9uHjVNor?=
 =?us-ascii?Q?e32e4viaP1KPVT345aYmyzYWxPPuSEiMVxkryUspbBYPAHDYaRzV82qklnHI?=
 =?us-ascii?Q?6M2607VmtC6GhhYQ8PRmnO3Jb/GakZN2xlhCPKYtKuKJZAm2H11fHLscVF3o?=
 =?us-ascii?Q?cavrISe3IrCez6fjla1W3NZoNShUkqptDgyzDtqL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 874d6dc5-f92f-4b87-d108-08de0ecd6807
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 05:07:33.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apo9UYgNESij4RnBNj/85W8UivEZ+nl/pz/VTVDBZ0DeYAaKdeKeCVnjiy/12AENLQbJqrt+eGn591uRqlq3ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFEC5C0F28D
X-OriginatorOrg: intel.com

Hi Borislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20251017]
[cannot apply to linus/master v6.18-rc1 v6.17 v6.17-rc7 v6.18-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Borislav-Petkov/objtool-klp-Add-the-debian-based-package-name-of-xxhash-to-the-hint/20251018-091553
base:   next-20251017
patch link:    https://lore.kernel.org/r/20251017194732.7713-1-bp%40kernel.org
patch subject: [PATCH] objtool/klp: Add the debian-based package name of xxhash to the hint
:::::: branch date: 25 hours ago
:::::: commit date: 25 hours ago
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251019/202510190931.1SovbysA-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251019/202510190931.1SovbysA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510190931.1SovbysA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile
--
   drivers/message/fusion/mptsas.c: In function 'mptsas_issue_tm':
   drivers/message/fusion/mptsas.c:4791:26: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4791 |         unsigned long    timeleft;
         |                          ^~~~~~~~
>> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile
--
   mptsas.c: In function 'mptsas_issue_tm':
   mptsas.c:4791:26: warning: variable 'timeleft' set but not used [-Wunused-but-set-variable]
    4791 |         unsigned long    timeleft;
         |                          ^~~~~~~~
>> error: objtool: --checksum not supported; install xxhash-devel/libxxhash-dev and recompile

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


