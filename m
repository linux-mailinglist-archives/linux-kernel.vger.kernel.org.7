Return-Path: <linux-kernel+bounces-875133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA0C18499
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B0F74EC623
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70EF2F7AA9;
	Wed, 29 Oct 2025 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LASnUTxH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796B2F6913
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761715558; cv=fail; b=F27omL9ZVrUeQm0iMhB3lnayzFEaH6BKIIf5tRsOU4lni1LBzmIBrsf3YpKH4dkqM0hgM43sKa8HBQOd88EK1ZWPOSlPJY+S8gScRSP37VbsXI6K41ZhqJ6tF3zNI+WSkOC40Noyv3tbTthu1yd/PymxmPwpSAb2LiH/AbaV/kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761715558; c=relaxed/simple;
	bh=hRCkCF+uGStDvP8kCNhO/cWMD1HndqUhBZvNfF3uYp8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aXx/+ija7FUVS30W2hzJrWnWg7jg9Ob32QVDTYsUgWgD4/xL6yu0/EOaS/5izM6oaDociaoxGa+EbpZXFHVI5JqTOlf7sC14e2PjsIDFg+CAJ9HhLB1QmYOGr4l34MBgGdhh8CmzEFORDm0yVfWG+aI699xmdGwUUqMDcmrikSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LASnUTxH; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761715557; x=1793251557;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hRCkCF+uGStDvP8kCNhO/cWMD1HndqUhBZvNfF3uYp8=;
  b=LASnUTxHykGskBcZqrbfEG6GC5PoNAtArMIwzpgSmdnb6CJG2LYty03B
   c8YtF09Ia+tqxZ+PeVvGwInx8Uk1joruYTRUrYOxE2w+3fIIqLLojvNhC
   JrQwYXKH/NDtDjmEQ9MtCOFs9MbwjhAaViWOXzA3IoUidFkWixRgLx7il
   wS4OYLOrT6M3sJVl1cHqHYlUVpaBZRS/saz+ARJ8lXcXScBRQ6UGbyfMz
   IeEKUTlf0oAXdMI14bFFrRn+W9+8M9DGlcTB9fWsbli4M0riGlClz/BkR
   DqDG5beiZuMahd/eeX4bdtRuLhJM0QyU4wb5qYNjxaFdyvc8C9CKScrUA
   A==;
X-CSE-ConnectionGUID: 4axMOamPQFGJbGW+lRZT/w==
X-CSE-MsgGUID: W3oKIxLSTDeMOkPa5o0WMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63728838"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63728838"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:56 -0700
X-CSE-ConnectionGUID: avQDLxvHR7i84RifVE1b+g==
X-CSE-MsgGUID: bEjLUm8bTi6UyqVTELCJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="186014718"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 22:25:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:56 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 22:25:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.55) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 22:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iw4noo529ZOPBXIF8pRK5xPSyEE0gE/UakLR5XeJTJlVD3cxhK55TZ1z5YWpHEBzfXufsbnIuYtdzZol4Izr+lYu4joMaqtRpHCwXFLulHeEriUJlQZXg1MA9U2vjTBn7lrcE0GjmpTTfai++Ew/3p19LL2ksjBjvl11EfrUAnGiU09rzCdq/WDcjXL5mSzMe7taxJUblcFkbgPfxJXQZS+84MAPwAzS6FFkexbFpPPZxsLwY3Ns/qL1RPZQNSKJcTiemWpkVLa3ED/ZezdrHjjV14BoTJoajlpuEVVgmMybBM7PDZlgr7nzIonN4hfTDcy4ldvF8M7vuEkOQ5sf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coU+ZmzOA0RA/n8MsXznVzPXftprRwUOIl8ZHE3LJeA=;
 b=Gkr+OQz0YP0UI9PcaiRQb6w1pWZXtWvz0L5BVVnihIaExfR3WCHkcJHfSodCqLqUZ1H8bbDg2QVcIA00IyfyugfpnKy5n8ofk5M+O8clZbFfFKA2fTzbYjTeksT/MNbW4DAxyVSauUC1yEOUkYR/UPaFZWPZXeQp8EzCKeDiycPB7IruLuabXm5A6igTEEFEwAxak0u79thXdGwc4FupO/URTNoVTqK/illvYKOWWxwUf0LuLHCbsXLnEcF8W/i8sfh7foQg8y/JCrNRZzElH15OH5pUc88fXHqGjvneILSusY4GSSfpBf7OIbFWHc3iuVCrI1DAXGIcpTO7tIKMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 05:25:53 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 05:25:53 +0000
Date: Wed, 29 Oct 2025 13:25:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Conor
 Dooley" <conor.dooley@microchip.com>
Subject: arch/nios2/boot/dts/10m50_devboard.dtb: /: failed to match any
 schema with compatible: ['altr,niosii-max10']
Message-ID: <aQGlWUVe4BOZX5+j@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 9847baec-08c4-4793-6abb-08de16aba159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dB1hvcFXvR8XfAtUichMJMNfHMU9pEmhNqRUVqpCL2FFtXTK4Vf4BJP/kMNZ?=
 =?us-ascii?Q?gQZ7nwKtAcvfwus6eSRqE+z74JIsXVGWMS93sXt8f9BEISRAi+viaFNyxzSo?=
 =?us-ascii?Q?3JBph35axi3dK46PyMlCzSc8Ru4rSPsrXMfLxkAFoUr8zhW+HT55y0IMJth4?=
 =?us-ascii?Q?hPqNzvB0tXF1wTeEb9DiNcvKCseNen7hcZ6Mi3oOt+JEYe6vZ2aZ6vlGhyQG?=
 =?us-ascii?Q?XEDTiCk56viHB6hnS09JK3OkLAYSmF4iGrw7nFnF3yNALt+VMI02VCu17WGS?=
 =?us-ascii?Q?l5xrHot6jaL3yJMAUxcNKikYshsYS3Pj7MMwTfOOAm5sZZ10b3oK7vw/j0ja?=
 =?us-ascii?Q?ldXS8mTpy2prxDoLPZH0m4BWLi0XdxVcNur6wMJA1I9GiD8PZvhvYv1f93MR?=
 =?us-ascii?Q?woP8lBGYnNA8gZNnGQ/YApnKShDyQhc/nbhLyZJQDB/EluN7mQjwuxFVi+0a?=
 =?us-ascii?Q?Hf7QQYfskhCpS8mCbnwDDPufLVdJX3+sAOdZPujuU2eeh5CfaIiBGA6XX+Et?=
 =?us-ascii?Q?ztnFhDjXlKJYrHTuT7vOvW/2x1IrHul0TqLMv7C0iPz+oQMf76bLb0PUHJcw?=
 =?us-ascii?Q?IcA3rHzRywh6cLkpQrAIHN107O/XSZXzoIYb7bpUetTXW/y5iOdF6g9ckmml?=
 =?us-ascii?Q?OjdlhOXtbjgIw2mGd+kYPotSoPZFkbmEcA1vpiX0XSbCI7cSC0hDJKTWRkLP?=
 =?us-ascii?Q?rYUe8m3AkFj6BRX/ogVVtuvQ2ySyQ4qfYukrr7D0Pn5luwwQOphxBCilAMzc?=
 =?us-ascii?Q?oAIkFYwmgS+DsGvwUD+YQ4zbpMkv7fxvgSaM8WmLqVNdsnH4ypt4/TfOQ3K7?=
 =?us-ascii?Q?IpKsdNEGh4uvF8/27tVD/P13iI1Fu0n927iaL6a0LlzD82TrZrgcJIybX4yc?=
 =?us-ascii?Q?b7dtLkEpa+1u6fP5DMIkwcW5HDGt5GtSvXtYzBBZAF9Y1nyQeuSgnlRw+vdw?=
 =?us-ascii?Q?FTzWsxWZhaXkQT4GCoWy/U7V0WvHLeaoXfiF4Nbfa6GwoG/s4BMifQOj+x69?=
 =?us-ascii?Q?CPt5gO7NpsDrnx0LIgJ5QQOdN6x02zsw0B/Eq8zG830cPACUu+seZT1RzOBU?=
 =?us-ascii?Q?sVHTVQBexhJ5DkGMAn2tJjjP/PgFG8XqcjdwYSwcxsiX72OHymVMkFM3pA49?=
 =?us-ascii?Q?lVN41cUupjcU+e1EUp90vYYqO/ZEZWIWqTaKjnkZJFF27a07FgdS7KdEyNhU?=
 =?us-ascii?Q?6zGaQgAZAu7IrR7fVIlkGdNe3HEa/20xVLvSSVLIbUNO54ZU1RybG2TqZuVD?=
 =?us-ascii?Q?jd3l1njKqcIoEa2iwGqhSWcAfWDFZI8YuX+vdoHvfCdjoN42taupjtHnqvzA?=
 =?us-ascii?Q?IChnYM5fvOVM6nV+xqJ9ZQLfwRWTDfoXjj1peIHa3eCYZur72lWUHLX/Zpfc?=
 =?us-ascii?Q?JUzWCSg30ksGfbaqyrVs324vUpyIA+RGD2LFoijy6+oXfS65UQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojQkqd+HX29iTf378vkKVEZDyTvNQtb0i+c8iFsj9O/U1ZtYGQNxyrnilQ3H?=
 =?us-ascii?Q?8IK0RxIQ0shdQdL3ErbYfSGraV0dYVAT1aMif3Gqismq6q3o/ooig2ychdTA?=
 =?us-ascii?Q?Rt+O4QKqrBnXXmk4xjjHbhuEAkqC7VGDitjUGABo93purE+8BWZ0wAsNNSrN?=
 =?us-ascii?Q?m/iu5PU65RFcvU5in6XmK9FjzNPaB7iUopsaza6UQgl4q3w9bYXQ8Bb7Bwcr?=
 =?us-ascii?Q?j918GVARSkzKu/KFgvPeA61A6ImEt3WuBFNQaQEITAEUl5yXwKYBBmb8qmwb?=
 =?us-ascii?Q?ICn40S0uUQHbbHj0ORTX0eQw3hQvervNeBmNEeEq7zGt5Y/kgJYFM74LhJiP?=
 =?us-ascii?Q?6SOGMVbRj+TcVcMOMe3PCiIENAczVY6AmfJsQ06MAXGlic2LmfjOGp+O4PG8?=
 =?us-ascii?Q?CiXyGIXbWgPcmMi8p3JRWA6jWN+Nzh7qTTWwGwLaGB3ORniALnw7hdgOU1XB?=
 =?us-ascii?Q?mQXgko4oHTNPSMeNzzDfTkbXFNQUUpadoveoZDFrRXHTZysJzAkqikddlPDG?=
 =?us-ascii?Q?3d7FWUkfU8VHkn08JQpfFh4VRB+6ZHFUdwMJK47YkEA7+uJ5yOXNZqI7+G9K?=
 =?us-ascii?Q?kJg9gFEsYs/AOaHyoEYk2iStly1y239G62YvcCrED+sNoZQNH8zzw09I5609?=
 =?us-ascii?Q?SekTF3sdDf6ReeKErwPKYERSlzP27Fojj8cBh31D5erGZF7fdiRcwqKKiSTf?=
 =?us-ascii?Q?hoin06oyZpJtmWGkhLxiNtgi4eCONiwfSvp5SyS+Cf4qA64Z19wSIf41wFri?=
 =?us-ascii?Q?LejsPfAAAg2oAG9wJhWtkQrSozEWmSHd3lX+I+KdW5APo54gUw6G7kpMWcbQ?=
 =?us-ascii?Q?0lidPyKeuHZ4lXd8CTbdhf5QD2Xv9TJgkKqSComAvv/me44Ey06+OGWqu7PS?=
 =?us-ascii?Q?4mRoNX9PsFyq+cSKasm8ABcOV/sf9JG0Sv3lk+TDxgwzHn7uceQ/6ynTdw7v?=
 =?us-ascii?Q?1Ow2+Bb/elzp8dU3vHSjnXMDhH8Sidxhy+vLZ4wWTkusj4rhSGw90c1ArOd4?=
 =?us-ascii?Q?HlPimtapwFZ474G0cbaQRzQYPyR1pLzpwlcHcQDDjwbul9fJhMoGQvFQHVva?=
 =?us-ascii?Q?zThyzTXs5p9483gZiJ9MFhn2RudR5KHCuu9lTBMAYHkLUFtNXicRKL8bockf?=
 =?us-ascii?Q?+kEmKaewM2b6hKWiLD6U9x6jG1zB2V0b+FUr1B/PClqWXYiyLecCfZ1Wls1p?=
 =?us-ascii?Q?mAHbBuU832mdNTA6K9fGpTX1pW5NohpI+XWy2QLnz6yvI2/MDExuY0xzobCX?=
 =?us-ascii?Q?t2KRMVFm5JX6nSBivoWgGS8tR/C1Nd8wOcrZ0kWuGmpJzjAwFJfus5QWCO/s?=
 =?us-ascii?Q?YrLlRwqg1QLH/LBQ1/68e2uszS4WfzvQhJjesKYXMUxbKK6Q/b62pu33loNv?=
 =?us-ascii?Q?6FtJa1/+jM3JN1RlPJ3QYizsBkXoxsFJZ2DufJfshThR9vMY5MK9i+hhwxM8?=
 =?us-ascii?Q?2BAT7jSus4CgVY5sqy2iHCp4892m1CYjKqa4NRW8VTnmTKRQS+hVfCjW98nj?=
 =?us-ascii?Q?H6hUZukg77CEh0xS/yC8jUv/rFQbRouutvFZ/i+64UCHCizl6VVQM/1ACYZS?=
 =?us-ascii?Q?Wlm1qHdz/1+Mvf7oztY5WWqROr3C8ZHS2Ko2Ik4wcIFGwmlUByToxkHAQ9Lu?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9847baec-08c4-4793-6abb-08de16aba159
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 05:25:53.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLh+myqvCds4y7PhjEK9onUAV+r2OQzJX9sbmDAffMHld6ac9o8c8+05gGa9yL2Cq2Dm2b5XR3llY2B4wcDOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
commit: 61a6ba233fe1198e9eacc9ca1d1cbdb27f70cee5 dt-bindings: Unify "fsl,liodn" type definitions
date:   11 months ago
:::::: branch date: 2 hours ago
:::::: commit date: 11 months ago
config: nios2-randconfig-2052-20251024 (https://download.01.org/0day-ci/archive/20251029/202510290311.mZFp1NzH-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
dtschema version: 2025.9.dev12+gd6be03029
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510290311.mZFp1NzH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510290311.mZFp1NzH-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/nios2/boot/dts/10m50_devboard.dts:44.9-48.4: Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name
   arch/nios2/boot/dts/10m50_devboard.dts:50.16-231.4: Warning (unit_address_vs_reg): /sopc@0: node has a unit name, but no reg or ranges property
   arch/nios2/boot/dts/10m50_devboard.dts:119.21-143.5: Warning (unit_address_vs_reg): /sopc@0/clock@0: node has a unit name, but no reg or ranges property
   arch/nios2/boot/dts/10m50_devboard.dts:145.20-169.5: Warning (unit_address_vs_reg): /sopc@0/clock@1: node has a unit name, but no reg or ranges property
   arch/nios2/boot/dts/10m50_devboard.dts:119.21-143.5: Warning (simple_bus_reg): /sopc@0/clock@0: missing or empty reg/ranges property
   arch/nios2/boot/dts/10m50_devboard.dts:145.20-169.5: Warning (simple_bus_reg): /sopc@0/clock@1: missing or empty reg/ranges property
   arch/nios2/boot/dts/10m50_devboard.dts:208.19-230.5: Warning (simple_bus_reg): /sopc@0/leds: missing or empty reg/ranges property
   auto-flow-control: size (4) error for type flag
>> arch/nios2/boot/dts/10m50_devboard.dtb: /: failed to match any schema with compatible: ['altr,niosii-max10']
>> arch/nios2/boot/dts/10m50_devboard.dtb: / (altr,niosii-max10): False schema does not allow {'device_type': ['memory'], 'reg': [[134217728, 134217728], [0, 1024]]}
   	from schema $id: http://devicetree.org/schemas/root-node.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['altr,nios2-1.1']
>> arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): leds: 'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): clock@0: 'anyOf' conditional failed, one must be fixed:
   	'reg' is a required property
   	'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): clock@1: 'anyOf' conditional failed, one must be fixed:
   	'reg' is a required property
   	'ranges' is a required property
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: sopc@0 (altr,avalon): $nodename:0: 'sopc@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0: failed to match any schema with compatible: ['altr,avalon', 'simple-bus']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/serial@18001530: failed to match any schema with compatible: ['altr,juart-1.0']
>> arch/nios2/boot/dts/10m50_devboard.dtb: serial@18001600 (altr,16550-FIFO32): auto-flow-control: 1 is not of type 'boolean'
   	from schema $id: http://devicetree.org/schemas/serial/8250.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/sysid@18001528: failed to match any schema with compatible: ['altr,sysid-1.0']
>> arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:2: 'tx_csr' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names:3: 's1' was expected
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): reg-names: ['control_port', 'rx_csr', 'rx_desc', 'rx_resp', 'tx_csr', 'tx_desc'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): compatible: ['altr,tse-msgdma-1.0', 'altr,tse-1.0'] is too long
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
   arch/nios2/boot/dts/10m50_devboard.dtb: ethernet@400 (altr,tse-msgdma-1.0): Unevaluated properties are not allowed ('address-bits', 'altr,enable-hash', 'altr,enable-sup-addr' were unexpected)
   	from schema $id: http://devicetree.org/schemas/net/altr,tse.yaml
>> arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@0: failed to match any schema with compatible: ['altr,pll-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/clock@1: failed to match any schema with compatible: ['altr,pll-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/timer@18001440: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/gpio@180014d0: failed to match any schema with compatible: ['altr,pio-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/gpio@180014c0: failed to match any schema with compatible: ['altr,pio-1.0']
   arch/nios2/boot/dts/10m50_devboard.dtb: /sopc@0/timer@880: failed to match any schema with compatible: ['altr,timer-1.0']
>> arch/nios2/boot/dts/10m50_devboard.dtb: leds (gpio-leds): 'fpga0', 'fpga1', 'fpga2', 'fpga3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', '^pinctrl-[0-9]+$'
   	from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml
--
   arch/nios2/boot/dts/3c120_devboard.dts:52.9-147.4: Warning (unit_address_vs_reg): /sopc@0: node has a unit name, but no reg or ranges property
   arch/nios2/boot/dts/3c120_devboard.dts:46.11-50.4: Warning (unique_unit_address_if_enabled): /memory@0: duplicate unit-address (also used in node /sopc@0)
>> arch/nios2/boot/dts/3c120_devboard.dtb: /: failed to match any schema with compatible: ['altr,qsys_ghrd_3c120']
>> arch/nios2/boot/dts/3c120_devboard.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['altr,nios2-1.0']
>> arch/nios2/boot/dts/3c120_devboard.dtb: sopc@0 (altr,avalon): $nodename:0: 'sopc@0' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
>> arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0: failed to match any schema with compatible: ['altr,avalon', 'simple-bus']
>> arch/nios2/boot/dts/3c120_devboard.dtb: bridge@8000000 (simple-bus): $nodename:0: 'bridge@8000000' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
   	from schema $id: http://devicetree.org/schemas/simple-bus.yaml
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@400000: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/timer@8000: failed to match any schema with compatible: ['altr,timer-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/serial@4d50: failed to match any schema with compatible: ['altr,juart-1.0']
   arch/nios2/boot/dts/3c120_devboard.dtb: /sopc@0/bridge@8000000/serial@4c80: failed to match any schema with compatible: ['altr,uart-1.0']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


