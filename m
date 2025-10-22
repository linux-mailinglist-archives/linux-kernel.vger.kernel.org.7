Return-Path: <linux-kernel+bounces-863966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB51BF99D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441CA19C77FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AD81F181F;
	Wed, 22 Oct 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6yM3aXW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6A1A08A3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096827; cv=fail; b=qmmMJtaSsdgsyYkkRlBonyWoHtO15IzNQGpocXOMDAeY+DPoZO+N6b/mLkPQbKru/K3YGj9XhH5HfoY4qhZkRnoG85ysgm+EQPyZXaRkc05tflXssSntHgy6Ex3F1mFY5xAmB725+CvF8l13H5CbVLk8zVrro0tPyZklC6JiWA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096827; c=relaxed/simple;
	bh=Uav4i98d1/TB5r/YEBMKeiWVlraVW20+ExZBscD7lb8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g9nn1CPcabEeOpOErvTWAefHVMcQ8SXyYwpgPp999sAs2WirAnjlZgvEVX1IoZUcYt8k19a3uAKDyraZuSVr4YeVbsI6age5YYpb1Db85Ma7sKJ2vFxjc/xyA5vgyvzaNb3ifwtGUwvhE+H6NwgKpbSXKwKp1Llw9WT+wfHkv18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6yM3aXW; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761096826; x=1792632826;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uav4i98d1/TB5r/YEBMKeiWVlraVW20+ExZBscD7lb8=;
  b=W6yM3aXWVw69tm3g4C+hXdfHbEobeZUViVEP1U9VaBpot7GrGGJZpKce
   ASvmkCz4TV3haDLB5k4wUgSGM+4+hCbSNv/KsYmwVn4TD9uF3tV9CSQFn
   S+TLsxkhSbHBkxhs71TQL0CdlUs1s2i1RtwAFRpNAJ1i7BFZkcGDUVCDP
   B7yXeo/sTMeXfn9rvAdQ84vQ3oMSPSDl4BavZOdo1UM2u92v8TjM8yNrr
   3oGZbdDg6fodWYjkaUdQcGgusn4eBxxemdOgEYjOmL8B1bu/jKOfc9tW0
   51RALFtX/zTYXnkXz8bmOiH0TECu2CuyQFg48Ufxm1b/XMLMbePc94txF
   A==;
X-CSE-ConnectionGUID: yp4SDCj0TjCc6coIpfmt8w==
X-CSE-MsgGUID: y8p6xsrOT8Ccf9aBDa5bZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63131293"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="63131293"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:33:45 -0700
X-CSE-ConnectionGUID: 28F3KyDxTNq1337JTHB8NA==
X-CSE-MsgGUID: 2qotBR/lQaSR3Ql6fvc/mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="188146232"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:33:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:33:44 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 18:33:44 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:33:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYd7JsNSpqXd7YD3t7iv2IB2PvGYZdGWUV0jP+T5mo6b65vUINrHRSqA7NU1qlWGxP7/iOKdVCsOt2M1MtIiZfOXBQlxhabgBiYSM6Hz9GX5d4MQE5U/1NroJxFi7+KzE8ykbgMQFGdyD36d6zwBsA0D2D7YazvJiWSBymohoCDBn1wYhaDurtqNKZW+07j7Spf5JdjIVi+skFJAL0UO3/ti8Zi4CXuFEZ/4SvQn9nSjxr9LAKtwW+HoT0ibD6ro3sYpfkBAG726hduUy3ULf9B8dE6Q691n4BNEcWT+fm9Xlg0ttFdU2k0nlNCsvLIn/ET1BOHBalVC+OewVm+enw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RD3zEKn5cpc07kQ5h2S0Vh3hSsuYhuTYHlFjuKkIGA=;
 b=kCculHAYC9JTmgzS9jApb7Wzvo7L2+MZlivw2oSwGE7BFIHy6A1rnVRTbclnGPasSzBo/9nLq5IXNpRvAlT4ZOO/R9UB+6N4g4GN8zCV7gjpc+NEPkZZhAhLp1nmVDz63wi//3bq8p9Ho3MFd24mzbJiwwan5nKN0Zh57mCT6QYSahW02I3r/5r0Is9stsGXljjw50C+OMwAOHUPMMNa6eAY5fJJYxEX/dQTYsEf2zK9R9Gbk2+bUkzAuiyaijYhDfBrJDaPPhUtEUBqsGVJBGbDPNHBrcJ8sE+le02DaoP+Q4bF2vXIYa490SfbFbnTxiUo5h+HK30zpz1QCIUJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4172.namprd11.prod.outlook.com (2603:10b6:5:19f::15)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 01:33:42 +0000
Received: from DM6PR11MB4172.namprd11.prod.outlook.com
 ([fe80::f86d:a320:27b7:afcd]) by DM6PR11MB4172.namprd11.prod.outlook.com
 ([fe80::f86d:a320:27b7:afcd%3]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 01:33:41 +0000
Date: Wed, 22 Oct 2025 09:33:34 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: mm/kmsan/hooks.c:267:14: sparse: sparse: cast removes address space
 '__user' of expression
Message-ID: <aPg0bprv3TDtPirU@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DM6PR11MB4172.namprd11.prod.outlook.com (2603:10b6:5:19f::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4172:EE_|CO1PR11MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fd5a26-d95f-4548-b141-08de110b0877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnBqtJ+XTrjHYmQ8FGr+Bur5m/KzGTBb/zgzrDdJ1t2Fd1URJCiSMX3cv6Lb?=
 =?us-ascii?Q?eyAX64dX/ClPRsyqePHz60EcQxSxBUaEWuz+k4shiLIf1+AfDaLpL3HjqoEk?=
 =?us-ascii?Q?j3G27nSJzw4X69HMowIgJQhco0oSLq1IKr8hoBUkXbxp+Zxx141VoZNn+mzd?=
 =?us-ascii?Q?7JdtmpoNoex2OjDqvu+f4qMaZrIVMBN7z1jSlO4bKalDS6pDv6Cz4Vj5Wo/m?=
 =?us-ascii?Q?Ub8InBx8to9K8ScyJ7bDkp6hEFxVFaTuTDwPAQZF/0Pot03MIYGx4XG2SMRC?=
 =?us-ascii?Q?irN/imCK3kOms+K0pFNgAngsMLPmUFrPHerex86zEVkRSozwVkssNRxalDG1?=
 =?us-ascii?Q?gwytn/iicbuYKiJZ1CUStTSPdPuBfuyJl6CD5obAAQA4rviKy5lHWCAYt0pe?=
 =?us-ascii?Q?yg5zIhQi7cwqhtCUL9yrtWSPIc4xtvxLSwpjECMLqc0vT0lb8wOVdGNcgyFa?=
 =?us-ascii?Q?/SYdZePOZAIdSFAY+gaW8Im3Pgw6gAO7FCYbQpUf8jB8ka0tdZODfoI0ZPL2?=
 =?us-ascii?Q?QPjGBqFTZgBk7Cwt6G4qbgUwooD9yBn8a8Qv2dRH4Oty2ICNbv+yIsiEyAJd?=
 =?us-ascii?Q?5Brym15ixzshvwL1NCXDt6ijyeDbN6xYSbmdZFWwAU8Z/1TtkkX/lNA7zK3B?=
 =?us-ascii?Q?tuyvLnQPABK6fSP2aEHN2ARU/M858S7wv3b1vh0hl1p0N5uSSk6l2hvhv0xr?=
 =?us-ascii?Q?htCYWmYZB+xbTo6TlrfudcahpPFDr3MAkl7WqtlS+gDNIYYtjtD2aL8BIQeY?=
 =?us-ascii?Q?yFwh2SR/cGYW5cmyMKZQtwGiCFllaQmslBnobjSXOI8BMNKM4RW3614uAR5O?=
 =?us-ascii?Q?WjP2N9DN2uPpZVpwKYcqdb8jcKJC/nh0lRDGp6jA0wZITmzftmX5OOg3zByC?=
 =?us-ascii?Q?8a5GNanHcEjOh3d92+RbDiVmsCp6Z3zOHux5MqYyuc/z8OS8DoW/Yf5iw7mb?=
 =?us-ascii?Q?SHhbEZnBXjTr6w3JUuAic7WROC8xlBC67pY4BjQk4NoAokwjLJtmg8xobbkW?=
 =?us-ascii?Q?+66Q215DyOtht/kzwc5pfh3BifVf9rnEdGm5+YOZnjn2f9tWcuvpfpf1n0/G?=
 =?us-ascii?Q?X4ygiL5B0jWijKVHEiHEO+qURd3lu9TTgjGEKLj8NMvPAUf/tU5Fx+I26Auu?=
 =?us-ascii?Q?PvDJz6yr/Bqo8e4vJR7x5zfEKuBYadbvpsw1UChpcdcsomW5eobboh+i7yJv?=
 =?us-ascii?Q?vTf9bbp9km0ICD5QaqQx9zf0OEWdDKBQ0aW5CBEHma4CDb4c2wUhh9cAvVwz?=
 =?us-ascii?Q?OTWRWmnGdDo1gdWq+X+ByynZ2IfU/q5F1PsdPceSzCqz6uX11yeryxJ7i6tl?=
 =?us-ascii?Q?Hm0UK7VUmAvgwrji5m5k0F5M5q3+tAaOUOlXFISikKoT1Cg9r7mUchlCmF6B?=
 =?us-ascii?Q?8TrRqnlEoBKBIhk/Ozbk4JFM5jHnt6Z74wT+xizjxNdgcDhjHOrtiUDDYBhp?=
 =?us-ascii?Q?BQSwqHk5Mfp/m+x5SDKHm1aYg1XNsCYUGQWQrrOiLQNSLrCIU8Iefg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4172.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ekS0og8NlSKqVDWArlpYVGLFztuzRsvSk/Od0HIppQx6KKqGtwNMqTz5W8dG?=
 =?us-ascii?Q?mhy2kOOVJa2cnbPINmH05PzZzBpP+YwJzMtPc0hZbGbOdyUXSa0ELQ/Ekvql?=
 =?us-ascii?Q?qxxiAAcFwt+Der3vfg8loXDl3+9tFblA54QDP1jBEhQqJDjhWcF4YKgoibDP?=
 =?us-ascii?Q?AMu6PpVZPOK70+2ddfSbLW65hcCuv3lD3VrIfIKiETOzDVozrg95K3XdxFYu?=
 =?us-ascii?Q?yWeJ93fKtu8n0yGhSUblyj/d+4BERAmn07ABmHfyYvLnyg8qE65cnJ2hpxBe?=
 =?us-ascii?Q?O3G8FuqfMeDehKPwGtBUUPmEAQJGqwqbK46Nn+zK20tzd/0ts6b7YrZy1BWh?=
 =?us-ascii?Q?MM5qUL10MBL4adeXOE3CuPbEtcTTUkTJFZKAFovcI+YI5EfCepeQxR/s5llS?=
 =?us-ascii?Q?2Gt2FBjtcQHC007EudZrBFEpmkY+XxBFQiXVIAwF1oCiws2j3tu+PW9ELYqv?=
 =?us-ascii?Q?T5e+rWHirKwlLku6K4Kfeck7yAqp79afcr20QDAoIo4j+9vdLDNW17C8Nc1/?=
 =?us-ascii?Q?6Wkjp1FtgPPOyhvrLEQX5jUj7Dy2AdnRpEwJOCokbCaksVLli9yJgAG7G5Bk?=
 =?us-ascii?Q?RZ95NFVbhUu+XwIsvsvvuO6ig0Glb2NidN/mhI1SqfdNnM9ZzoeqvlGw4nAK?=
 =?us-ascii?Q?DRPryVYxqaj97+4npXa1TsoQw4YKBpXKjFTI2hoIq5XR4mR/f6UsUURgA/Sx?=
 =?us-ascii?Q?6A6fRj73DinSHgz9GPbg3JeXKFPwbu0GX5RPrPeKSkwmM0t0UCLtEkFSpx7P?=
 =?us-ascii?Q?Jtze3z/n+wDaW5otlhIYzW4+sEj55MIU8x/zmRBvFjdfyWpHpjkfUJJj0h1t?=
 =?us-ascii?Q?0evAWypyOmJnCl99kI/7PQbA2tLGQXQoxFgS1qVnA6Lq3C/OiPooRVPfG2fI?=
 =?us-ascii?Q?uJhO/MRsda8aHnlkTVIZEz+R59hZ4YFmZl83ns/44uYfmpAcW3gt6bHqqGAF?=
 =?us-ascii?Q?DZrOPZsOfYlX5ZJTI0x5AzDWddXMGMTbaBeL5vp8Ee7ZxfzDUB3RESzjuKOF?=
 =?us-ascii?Q?7twAAuuf/wrsAdvwgdRSLsa7ogSzGpE+evmFS2f11KrdHjqFRJ7uGzEh51MY?=
 =?us-ascii?Q?Yxn+wT5rFplV0gD462b24wrJWeKCdUf11kfOHAwkZkEsezrCvvRm6vIvj05w?=
 =?us-ascii?Q?V2vuFglBFTWXFYebIc0OU3a51bZbLDbvyEAvQ1FSEfkg2OTY83ddU2eLga1s?=
 =?us-ascii?Q?frYVBzj8cUxQLHoZ1qcdLQNFB5JCmkBJOylr2fLeHAposoyTo+j2rkYSogad?=
 =?us-ascii?Q?x7C+3cN9yCQqtra2jnrE7hxwOK9CBvJ+cYoWf/frVGjxs3ZiIwKPQ9Oysltl?=
 =?us-ascii?Q?5TE7kq3gmzqcPGyCI9FlHplsLtzWKnaeLC0WExPrsguNI/OiQICNEeYx/Jha?=
 =?us-ascii?Q?I8BklcP/0tKy2m9spW893/+q00vUjJR4wXR6KGSF0bhwdTsxGrgT/zBEItWq?=
 =?us-ascii?Q?597hsw3yth3ba/jgOdCmGlfJKkBdy9M0C2vYJYtwdhg46RX4oEZ1I8ebyq9V?=
 =?us-ascii?Q?Gpb/rmwdQKC+FyuBW7j80Wdmrydy3ZZlDs7A0WrSFDh7Hv89Fgbg6DVvywV5?=
 =?us-ascii?Q?rplttUUOwO5V9zuXYH7mgbrgRdTcrQiXgN87Vjl/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd5a26-d95f-4548-b141-08de110b0877
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4172.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 01:33:41.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayFurLlRsacbcg7twXu7G0KiJNnXsfgSXnLiMtmjcsncqlydQeAIDiuR5OxKmkSb51NzfCTPyO2u16tldkGGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6548d364a3e850326831799d7e3ea2d7bb97ba08
commit: 5ff8c11775c744dc5076ce126eb1b3adce0a70ae KMSAN: Remove tautological checks
date:   8 weeks ago
:::::: branch date: 20 hours ago
:::::: commit date: 8 weeks ago
config: s390-randconfig-r133-20251021 (https://download.01.org/0day-ci/archive/20251021/202510212353.1hEG4lJQ-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251021/202510212353.1hEG4lJQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510212353.1hEG4lJQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kmsan/hooks.c:267:14: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:279:50: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +267 mm/kmsan/hooks.c

b073d7f8aee4eb Alexander Potapenko 2022-09-15  245  
75cf0290271bf6 Alexander Potapenko 2022-09-15  246  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
75cf0290271bf6 Alexander Potapenko 2022-09-15  247  			size_t left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  248  {
75cf0290271bf6 Alexander Potapenko 2022-09-15  249  	unsigned long ua_flags;
75cf0290271bf6 Alexander Potapenko 2022-09-15  250  
75cf0290271bf6 Alexander Potapenko 2022-09-15  251  	if (!kmsan_enabled || kmsan_in_runtime())
75cf0290271bf6 Alexander Potapenko 2022-09-15  252  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  253  	/*
75cf0290271bf6 Alexander Potapenko 2022-09-15  254  	 * At this point we've copied the memory already. It's hard to check it
75cf0290271bf6 Alexander Potapenko 2022-09-15  255  	 * before copying, as the size of actually copied buffer is unknown.
75cf0290271bf6 Alexander Potapenko 2022-09-15  256  	 */
75cf0290271bf6 Alexander Potapenko 2022-09-15  257  
75cf0290271bf6 Alexander Potapenko 2022-09-15  258  	/* copy_to_user() may copy zero bytes. No need to check. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  259  	if (!to_copy)
75cf0290271bf6 Alexander Potapenko 2022-09-15  260  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  261  	/* Or maybe copy_to_user() failed to copy anything. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  262  	if (to_copy <= left)
75cf0290271bf6 Alexander Potapenko 2022-09-15  263  		return;
75cf0290271bf6 Alexander Potapenko 2022-09-15  264  
75cf0290271bf6 Alexander Potapenko 2022-09-15  265  	ua_flags = user_access_save();
f926e9326f3a79 Ilya Leoshkevich    2024-06-21  266  	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
f926e9326f3a79 Ilya Leoshkevich    2024-06-21 @267  	    (u64)to < TASK_SIZE) {
75cf0290271bf6 Alexander Potapenko 2022-09-15  268  		/* This is a user memory access, check it. */
75cf0290271bf6 Alexander Potapenko 2022-09-15  269  		kmsan_internal_check_memory((void *)from, to_copy - left, to,
75cf0290271bf6 Alexander Potapenko 2022-09-15  270  					    REASON_COPY_TO_USER);
75cf0290271bf6 Alexander Potapenko 2022-09-15  271  	} else {
75cf0290271bf6 Alexander Potapenko 2022-09-15  272  		/* Otherwise this is a kernel memory access. This happens when a
75cf0290271bf6 Alexander Potapenko 2022-09-15  273  		 * compat syscall passes an argument allocated on the kernel
75cf0290271bf6 Alexander Potapenko 2022-09-15  274  		 * stack to a real syscall.
75cf0290271bf6 Alexander Potapenko 2022-09-15  275  		 * Don't check anything, just copy the shadow of the copied
75cf0290271bf6 Alexander Potapenko 2022-09-15  276  		 * bytes.
75cf0290271bf6 Alexander Potapenko 2022-09-15  277  		 */
e17c1f15b0ccfa Alexander Potapenko 2025-05-07  278  		kmsan_enter_runtime();
75cf0290271bf6 Alexander Potapenko 2022-09-15  279  		kmsan_internal_memmove_metadata((void *)to, (void *)from,
75cf0290271bf6 Alexander Potapenko 2022-09-15  280  						to_copy - left);
e17c1f15b0ccfa Alexander Potapenko 2025-05-07  281  		kmsan_leave_runtime();
75cf0290271bf6 Alexander Potapenko 2022-09-15  282  	}
75cf0290271bf6 Alexander Potapenko 2022-09-15  283  	user_access_restore(ua_flags);
75cf0290271bf6 Alexander Potapenko 2022-09-15  284  }
75cf0290271bf6 Alexander Potapenko 2022-09-15  285  EXPORT_SYMBOL(kmsan_copy_to_user);
75cf0290271bf6 Alexander Potapenko 2022-09-15  286  

:::::: The code at line 267 was first introduced by commit
:::::: f926e9326f3a79f7e01ac790e2361f44d8ca8320 kmsan: fix kmsan_copy_to_user() on arches with overlapping address spaces

:::::: TO: Ilya Leoshkevich <iii@linux.ibm.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


