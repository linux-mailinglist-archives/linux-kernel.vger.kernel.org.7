Return-Path: <linux-kernel+bounces-870214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CAC0A326
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09B318A2649
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E611E5724;
	Sun, 26 Oct 2025 05:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHjs5Pzx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28B3288D6
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457846; cv=fail; b=DwX/lnzC+3QPNAqV+xzHwshmelZ7jAnN6KrR0RVGeklA4S1/1VZ+CMQJ7zdgNwh50DpN6zvxoGkW4mPIacrFPJ8KC+Y/ZhCamoKXcUDfmFEHwp+UuJLjgKp5wlxE/MHFwQrc9ynVEEFH++qw5cdmMRKRga20RKId1lbG/YECZyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457846; c=relaxed/simple;
	bh=v7l18ovgwBjK1ey4fbloQY8Acnnb4l0uzJgrmbOUxms=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aun4Ejas4zkE6PAwBDt7bZbUq2KF/5fSRa9TA5QdZvJcfLfSno399FrEi1gBBApMMDnEFcoy3GTFfzYhS0/JiOmhHgoH+YHCEXRrv4XN+VKQQ0/SWT9pfTMsvAOkXt0swwjSMN12MT2ld4TVP5LT9p2WcVHJdDPxdvoqTPdjvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHjs5Pzx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761457845; x=1792993845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v7l18ovgwBjK1ey4fbloQY8Acnnb4l0uzJgrmbOUxms=;
  b=lHjs5PzxYDY661hYI5bvPxNl9O2GU6CGESsUIJQa4uOpvB3CRSOeabUN
   aDcDCab/KK+9B8IHWpzCmvmF//7PPP8boAuwHn3Z0oax16Eb9QaXdVANg
   rZNCwCgnqXm99lrk8LdRk++sIZBY8dg+townp1nF0l1HOTdoM9hN0WWLH
   k7vtH5FCupZzxXSeUrZ6a+ipjeQyVT585pg011iSX2b+AKfMtdof/plMV
   koGQbaDro2tHb3qsIiwlBFllVX9jKVjCx9p3ECiwRcbpGmh0x6+PR+lop
   F01h5X933hQAr//ySfs3qI/yTf6+fZ4CmZ3l0fxUxKGLuXisSavXr/OJz
   g==;
X-CSE-ConnectionGUID: dRuBJ4KqR8CO36bGmAmYiA==
X-CSE-MsgGUID: /kdeLYZFQvOOnWF7onjY1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74176631"
X-IronPort-AV: E=Sophos;i="6.19,256,1754982000"; 
   d="scan'208";a="74176631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:50:44 -0700
X-CSE-ConnectionGUID: lNXYGGlfQh6KSpZL+3UPVA==
X-CSE-MsgGUID: gkjnF4TpSIWhnC7aV6TesQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2025 22:50:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:50:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sat, 25 Oct 2025 22:50:44 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sat, 25 Oct 2025 22:50:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cp46gSn0omusHmN8aM7qhFqqhCgB8fXZZEr09RPMwBShCH9NI03vqyvemfrI9pL2EcS8G4qTSeDCUv8CkRdU0yEY40YRoJeW7kFbJqBrHU0z/Xn/cBGxg93muHaNgXzDRt8G0T8PS9UuKUJNZA4JcKwB4mZ1Y50uULC5GzUQzyiu60UjiqlZ+s9M0FfG/C+NczXP0d0S5oovipz3fjoUiGJiXKnLbqbCmnqfKoAPzAjMPv/WAf3cerPYteN159PEFWjRc/BvRV7uqikw5pHSreR1UaEECMByoQzNqDiMEUVxBj6ZWfk0tfM0328HBmkC0shocHW2MhNdZyXvzGClhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9aUXET+NJo8AMHW4IBI30nHg7APjh1NoY9sOnSJxk4=;
 b=BUOoyY4rRegQtcxLynB0TtzEdaDnkJxwNs3hapBymaAdLqy3dmLiNy0FG0Dp6DNjSR6A42I56mMm3Br2AkLUZAmkUn7KaRF/7gzVLG6m0/PyqBWIXPsRYvJZnv5dvzGkZ0UkT3wbRqKL2Rk0jKe4KMtdMls3e3cDriH+zWOJqRNOdQTpVuFAO6+dRq+jMbqZZqpdxBuMwBOcqMtJELQYHyuyrCqsou6SmESQAB2mHJYIBzrqLTI15syecvlhzDNEwsXEKKgUh4gojWKYCQ3I1CeZrnexYjzZ/3h2FSoYyaRpmDZtBO5so3Sv25/+mXeEAcOuY9+6koMeEDhljldqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5991.namprd11.prod.outlook.com (2603:10b6:8:72::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 05:50:42 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9253.011; Sun, 26 Oct 2025
 05:50:42 +0000
Date: Sun, 26 Oct 2025 13:50:34 +0800
From: kernel test robot <lkp@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Palmer
 Dabbelt" <palmer@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>
Subject: pointer_masking.c:216:25: warning: format string is not a string
 literal (potentially insecure)
Message-ID: <aP22qrhDBtMs4iIn@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
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
X-MS-Office365-Filtering-Correlation-Id: 15271ada-e57f-424c-d1db-08de14539935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VKLLgoUQS9S6WChgEsu3qP7ddYs8Nl7EM8kVuCDOepdNDeoZFcQjOrEP6mFU?=
 =?us-ascii?Q?YUoxyBAJxC8MotVNb67kpXROSG6uP1BghK3cp4Tm1dSLSGrzCCtgGrTUvp/5?=
 =?us-ascii?Q?De5ga4DFDHsbKS/euxK9A3jq5nQe9TTaRRwIj4ynKZPcaK/s/Brj726tsQ6L?=
 =?us-ascii?Q?qstFiJLTzyx8fGmDIbEyXodKjyK/vCNfNQWBipD77MEg3yaPlDyd8HrSKYPn?=
 =?us-ascii?Q?xWqM8CIyBXSHVI/D9UP0pYmBsqNLxBvV0h01NAbj6fo7Vg7d4/xtlqHl6C+a?=
 =?us-ascii?Q?D7Uxwr1Jr0HYHX6rIwdCWWKGWrbMvGvcFlWn29U2yiDum7Jq0KFCduKyFGTd?=
 =?us-ascii?Q?TN4yQG19axT5Ah0X0TESWKwKzMcmH6QU+1BXgLqmyiGAd0AHl3jLP+u4J/4D?=
 =?us-ascii?Q?LiTXb40zEfXgbKsYDduGxgaFOg4PUTwRwBum5EE3dg/BA4nC1VlCNdzVQRKm?=
 =?us-ascii?Q?rdylm4v4WJxU+NrwL6b8flr6ZCyxgaEcIQSU4gd7HF822tXKfvpSulNobY7W?=
 =?us-ascii?Q?Tk96+Pl64+YFC+/6AIbnJD6cWS1H+Ed7vNxGkBzAhdMbMxyQYQos4Jkl5EoU?=
 =?us-ascii?Q?gL1Z9pmxe45yb+Fl/fvhDygqG7c/kVR5GXz45zlnpaozzpW8vd46euIrh5kj?=
 =?us-ascii?Q?+8snGyNmJBt1CaHiVEpNva8EBNC39A75/Hpz1tFv/R4VKrI5sp3YSrOCiPtV?=
 =?us-ascii?Q?+dj8gDU39ekURnvRirhu4bLUb3bEWROq8voL9eyTYD/T3ija2+rQKMhA2fCB?=
 =?us-ascii?Q?x5yqudYlXqNGpszb4msM9KixIgfaaeSiQSO93RzSQRp7GoZLQoZQRgIuBdQX?=
 =?us-ascii?Q?zhYlUd4mKD7zr6AzUlM9+fl+bEIMFqmUO8avEgOB/yLcF/t2dgRCTMxyjYBe?=
 =?us-ascii?Q?SoMviWGASaP4XfmgWpoXIGT038zT/ar+ZqzTXs97THxUPo/O+g5iz0sqZKHG?=
 =?us-ascii?Q?gZaXiDYmhLS+bmN+C1RC1/Xpgz9YPB/lryB5Oogr0RPH96FF23mXiwIgtZef?=
 =?us-ascii?Q?gLTbWM2rkOZW/vqt+jOMnuRmvICxH4FHk9wTojmKxXkGGBSzefhmH8KfnfMV?=
 =?us-ascii?Q?cfaRolCXDnNNz2oqudiIIHa4IKcvo0DUoM1jA8AFG+s/EnpmrvdaWL/k9tur?=
 =?us-ascii?Q?z/1lRM6kKQe8DfeEsbcHvvrQMFs34WYo3wTxmI9d0c/a4jAZihgH0d90/Jem?=
 =?us-ascii?Q?UYuiK1Xx1EkoSu/TJYI6RCJ4wqT5wfnADiP7GsWhnrvxXQoWBTA7IO+wCR71?=
 =?us-ascii?Q?3jdDIiqUtgk5KisMo+O9ILjY1kmRDpT3KCIcBagrWd/Lidmp/ecXljUZLTvG?=
 =?us-ascii?Q?sTMrHun4yTcYok+1ZxXLyYoMWIWtz2gS7cBYUzPlzEv71N06sX+Ll3N+VU6e?=
 =?us-ascii?Q?gz2mR5r/Y503szC8YNG5M2q20Mn7THjIlA+gqJ+2Qyn9lDIgFFG1TCp15cST?=
 =?us-ascii?Q?sG7vRBKqchtqOnevc+4BPuRGVwwDSkXW7fK2F+l8GaoRne/n4TQUvQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NdBNyac9jrcqNG33xburnu12r1D+xBp0Dy/zJ1v6VlWw8+QRi+UbAok/L8Xh?=
 =?us-ascii?Q?TpLacW84IlHxnP/fG7M8lBveG7MML3fN7kBQ1U9nYEWgKITQSLUf+MttgkPW?=
 =?us-ascii?Q?u8giGVij37kdaP/K22u47WuPRLGkxzUChAnjR4evPrHbQcthgtlwrSP/FOgB?=
 =?us-ascii?Q?73bWrGo1C9buT1ChCyZkb5vK1neKp+Ngg9V1IEV6AKJXiDtst1AncDW6MJJ+?=
 =?us-ascii?Q?QBOk/El8MS+ATKC2jWYTKYoXQpOIe8AQR3tfpPhh5OBpx84nQjUOvDnXL05J?=
 =?us-ascii?Q?OMG8SyaDv/XCqEwYDpSoT69opQV2VNOIT/Celx4HGC0YXeOjdaylSo5qCMDW?=
 =?us-ascii?Q?LrgeChOab6NHp8SVtzwVGs63zF8FDzhHBuCwb1gn++IM5ZG3mj1Eo+nAv4vg?=
 =?us-ascii?Q?DoJVzF0eSac0q1wmnSUm0sYr3yX1zVtOiw3p+3kAFOo/vS+UqL973jSSos4W?=
 =?us-ascii?Q?+84IHZoPFmFQGvtV6UJdIuyCq6/zi5HzwDQsp83BLBO+zFuAtE6+NZYyGc3G?=
 =?us-ascii?Q?TKskz8VatZ52flLOvJMIV6nIJh3gGJOdtd6iKnRNqS54/AtRnTt6yDaev5n0?=
 =?us-ascii?Q?fjMQ8io0aLCFzjHQvdju78Kar+Y2zgzle5IcodBEN3fHMIOKdwbGm1w7Gh34?=
 =?us-ascii?Q?rnroK0Bgjh/bKsbiC/R8PbUF9XunJSXMgEvnt6BG8N4tzVByK+VKfkd+mjS8?=
 =?us-ascii?Q?8K6X5lP3b/7gU9AmPE6qsuLXh76did9ZNdux191hzJNMLcZKTt8op15j0lGy?=
 =?us-ascii?Q?nqTC4Q7w66i6MDmuHLVI2ir7C/xFK/jX1ObkKTu3WOouXc6IVe7g+1dj2bih?=
 =?us-ascii?Q?RU4Ml9Pv3iuaI7327cXFvNuqpITLsD2NJ418Zfe3X4Lcl011ItIo4jhU2DDu?=
 =?us-ascii?Q?Bk+uuUu0Dzz6kx9ROZ5JlUqZ3M0kGwCMU7Cc7K/uSFXufVpjp40il3AtUhWn?=
 =?us-ascii?Q?f4DMgUMgZkdUJctNXTCWTZfSzGIHFUs33Q7/EwciCEZE8F7vi608lIzypxvH?=
 =?us-ascii?Q?w0U1Sh9SBcqJRfLwoTQ6EkFBLRR3+lYVxRORZZ5ZiI+Kv5O32/Baz1f6OFZx?=
 =?us-ascii?Q?04PD/qoB+D9asbWJ0ePRnYFkkN3743iPG8kyMmn7tDDe3bWiAv3dSTlaBxqF?=
 =?us-ascii?Q?TohMHTy0IUJVKCEtuvlCiYBeGftgducKUrpAizc0JSnDSOlNEh77DVS34MLA?=
 =?us-ascii?Q?5ndAQxJf/VmZNmo4gn8dsjYnLop3lTwCLACQoJlKvCX19y3bUJMn31aGyXZ9?=
 =?us-ascii?Q?Sa71D2xaZXHXtYiT7ercSmtNIvvpoj6Ze1cn/p5a6g8Fr5k35tF94EOj2tHq?=
 =?us-ascii?Q?0EWHSYRVwS29Fp2JF7uPoCb5julWeq2+ReTHhkzsiyaSg3opdjuPwZcsQP1P?=
 =?us-ascii?Q?tuBBzCRg/jdTQ6qu1wTDIoMxirlvU4KZzSx+uagXIfzmefjpGCRt8zSYxWoR?=
 =?us-ascii?Q?7tmwn2k+dehYHsKIwS01oIan+ZfnByBwWGETtIKutJRMXj5lBy/h9NuYFnWM?=
 =?us-ascii?Q?9fy+AaFUz/tQ1AC+SYepa5BSBsy3mTmXr0Lx9OcpytaFp96uG2ERSsdm43pG?=
 =?us-ascii?Q?7D0LOn3P1TMZytxvc0JiXMnuRz98XF3TwPH/nc2j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15271ada-e57f-424c-d1db-08de14539935
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 05:50:42.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSGHXaoaoLQv6OUHZZym7m3u52rvZOotKKIv1KFzvixdT3oZiQHEaT7dTQEPxxz8x0W/H0S4qcw4Jy4Rzhhq7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5991
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bb956508c9d94935bedba4f13901fb2b7468e91
commit: 498d5b14db8c9118be139f668720c67bea2dc344 riscv: selftests: Fix warnings pointer masking test
date:   10 months ago
:::::: branch date: 3 hours ago
:::::: commit date: 10 months ago
config: riscv-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20251026/202510260342.qQLArXOY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251026/202510260342.qQLArXOY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510260342.qQLArXOY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> pointer_masking.c:216:25: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
     216 |                 ksft_test_result_fail(err_pwrite_msg);
         |                                       ^~~~~~~~~~~~~~
   pointer_masking.c:216:25: note: treat the string as an argument to avoid this
     216 |                 ksft_test_result_fail(err_pwrite_msg);
         |                                       ^
         |                                       "%s", 
   pointer_masking.c:223:25: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
     223 |                 ksft_test_result_fail(err_pwrite_msg);
         |                                       ^~~~~~~~~~~~~~
   pointer_masking.c:223:25: note: treat the string as an argument to avoid this
     223 |                 ksft_test_result_fail(err_pwrite_msg);
         |                                       ^
         |                                       "%s", 
   2 warnings generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


