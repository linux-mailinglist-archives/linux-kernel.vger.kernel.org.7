Return-Path: <linux-kernel+bounces-759616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66355B1E02B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92FA65822C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06172604;
	Fri,  8 Aug 2025 01:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdJt8xaZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3EB8BEC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 01:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754616518; cv=fail; b=OytMIPsLt9fdOqq69wtqux9po8zKUG0+D9bjmjdkYURR9oAKlmdCl8xHwNprt9EvDV9PGUrRHodjNLjiEgssKV1uxRrDGOgMh/Pirmg2KF1U+VKr8hqzld2C0bI7LX5hIzahMfrgBdFsVyDbc0qIRTy1kyMBww7m5nDv7BhMCNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754616518; c=relaxed/simple;
	bh=Z9sxrCyfoqMx/Z6bPyD2RFs0iTVJ3Kqsm7gVA6kWFFc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVm7dAKCCbx6EqhOXSnbiwqbFBZVLhO9PUqMtK/oY7DZIaqRMt/QR+zOav0JF9ob3alfEIlijbVLfu14MWhLwQ9eH9BysTsAMGs3zDEsJsbTaRauOkkzEiWijp4Pk5obGWaNnk1kuVramhsy+PQaXyIokkQQ3szgMTzONAie0+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdJt8xaZ; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754616517; x=1786152517;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z9sxrCyfoqMx/Z6bPyD2RFs0iTVJ3Kqsm7gVA6kWFFc=;
  b=bdJt8xaZzVI4Gmv7wdVTtNMKR8gTGI2aWG6rKq31VQUemJs+yEL6ULI/
   zYI99Fpiorxbpx5buWv3SOa7LtlZzjr/8AoLaOzNpU4MBTcVxj0tD1xWY
   Buw4FKQ6nApj8J1kL5L5l5IOz4AR4162gPVK9g8o/H3pVZetQpqC6zdLm
   O7r5ENqffiL1oQBov1xoGLUS+hTs8YcqIdjpZicdxh3JBPYY6UgWqL0Fv
   ajUqyWjJqgGtQntW0h5sggdJztmE+h+OK0um7a5rwUPeRvBdCS6ruqFUg
   vDF35hTdYDvcgpvcS0eHQKfhNlf4tbVwzBn5PYJppICu+egX8PAEqhSyo
   g==;
X-CSE-ConnectionGUID: OaGW7nYvSKmBfoz9xpWecw==
X-CSE-MsgGUID: D1k07FEfQ1G5dLJ1gHLqYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56838143"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="56838143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:28:33 -0700
X-CSE-ConnectionGUID: 2yZ94THvTPOzCEDzgB0O2Q==
X-CSE-MsgGUID: YRs1WROOQrKDhqGzRVleug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169418508"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 18:28:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:28:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 18:28:32 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.59)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 18:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+LngKBXxWsWarBDyqWX8fNlo4Or/rD4ZSToigFFd8x/P0t4bAPkBVfiWCtEXCQA7SC/4eC8xyyAEjiXenhTf4SC1FD5eFLgNDuvNJde11VVqfo3JHkXMQCjxB45ej1+9qmmtMFYOlyJ86ossVkQ1/g9KD9sMcTszNIA1h3UdGet3bhtjlvKIG3Q4UiBeUZDa7g5gn+9cLnZ0NNKVBM3P0VOfpIUVfPeRyXO5YQRPlWqnxq0o/eBG4n6U1IH2qafBljCg9Uf6rs34lMyqRGtWi2919fHo4ultZnZiKdQ5n5BeUXJ9OSDw/1NEUodemODm1saG684iZt4y4nMu0IchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK0ti62BRQGH19uzFkui1gGILWDKk1EUgBGrTExalrs=;
 b=GHSf7v3bHAndtkGv/yOtHsgvIcpx4aF6e+vNwXLM8If1qh+RbKyI1Wp7szbpoWwAFIFZNrh71AdO6+qeZQSeO8WAQV7ZxD1OezuJB1IviAm0R7EAnxy6kBzH1KrtE2eTeUsUH8C+S9gON7HGiyeS/e1vsLLTf21pru4Q+mPui+ciwJ3Q43x/nWzp29918RiyOc0jjedOhflQHQG+dF97U9IMrZZIetXgKZva+aprNthltXPGZHRruwZjKECLXwlyK7hKMt12R1CISc4i6qsNP+en2jF8VcADNJJ3Meb/HzwQRKGPR64IQpHUr9Gx9Ki+HZQI826LXo3g9K5C+0IYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 01:28:30 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 01:28:30 +0000
Date: Fri, 8 Aug 2025 09:28:22 +0800
From: Philip Li <philip.li@intel.com>
To: Alexandre Ghiti <alex@ghiti.fr>
CC: Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>,
	x86-ml <x86@kernel.org>, Marco Bonelli <marco@mebeim.net>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [tip:irq/urgent] BUILD REGRESSION
 9f7488f24c7571d349d938061e0ede7a39b65d6b
Message-ID: <aJVStgD9ML6ykdXS@rli9-mobl>
References: <202508071514.CFNi6mo5-lkp@intel.com>
 <87h5yjcxqh.ffs@tglx>
 <d5e49344-e0c2-4095-bd1f-d2d23a8e6534@ghiti.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d5e49344-e0c2-4095-bd1f-d2d23a8e6534@ghiti.fr>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|PH7PR11MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 0622f445-46c8-436d-2e9c-08ddd61ae206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7K45QAXQgsh/dkzP1GHFOZVuYZIhbZVpREpatseSVdvE4lnzuVQJP+m2e+fb?=
 =?us-ascii?Q?TYHu6x6QmoxBRS9U/gZ0aTFpRx6Hi49qcwOGO1JZdLya6w2gH5q/kZs23Aa6?=
 =?us-ascii?Q?eFU0Omz9zksSm1cA6ILnq+oJho0xzcwywDtaUzxey3uRNdE9zP/A/l5bj1v7?=
 =?us-ascii?Q?by/vXmBz+6pbaHgl3GpCkVHkQrECdE4DdvGXsGAm7PkGs5vsobma3ep69sNS?=
 =?us-ascii?Q?bp3Kv+7xI4qTbUeLPB57OckMR71v2VWH8YRYUcF9D9+X5w4b0lVaOEMi6x6Q?=
 =?us-ascii?Q?e/nPJe7dVrJX0bxav1SDjv7lP24gUbhwlTTJnj0dlXX4JMFYcTzn5kLQ+rKh?=
 =?us-ascii?Q?VfxSJEFxYYTPoTat2/dOedEVNOBJdBQw9Gxu6GvZ+D4Yub37NHiYS8ShG6Zk?=
 =?us-ascii?Q?6bKnOGMsRrKJVeVD1prbG9BlXaEFZAsk8iekLdkFoMWjJxFxwICPIJSWgOf/?=
 =?us-ascii?Q?ZESZLtwgHuDLixxHy31mG6F2McTQgS1lw0M5xfmLpc/ANgfEVkh1RZvPV6es?=
 =?us-ascii?Q?45Efbmjtflui7OyA5SShuh7Lt4vJi+rfoO3K4NTJhPHe1QIeYdEJcuyws+0Q?=
 =?us-ascii?Q?w6XMEx0PMc+WCuVdc1czMQAdRw/IAt/K9APdK/f4jbpp6gFRVm062eG/lLKC?=
 =?us-ascii?Q?Y7BlED6yL9ekH845rfdPspStRQgFYfSyw55vrVhhgGHlX2SlDOJCh9rOT01v?=
 =?us-ascii?Q?jTKJx8xJWafPuSx8lgIAnBx786F98WVizswJ/EUiPfAqeptBVT/rphhMwcf0?=
 =?us-ascii?Q?l3nJnY/5cpaSAKfDsvjZrTUsyXn4Kcw3VyPCURAJ4DXP1kFG8OdtTrwcZmeO?=
 =?us-ascii?Q?Cb3Y5Zk+sZYomLKW9DVf3LuePa0yt1mf55vpnbVq68arbyudefdz0/tAIcmF?=
 =?us-ascii?Q?mEWscJFcVLbcHTvGGQGvOuSpV7R3pkoCpsIwoNYhQiJVh52S5ogD0to2ICmg?=
 =?us-ascii?Q?RiLz0uR89SRMm2YEPbBmYMCVu8GeDcbUVaSaCf7jLRHyoiLwbwYBleh0j3Ye?=
 =?us-ascii?Q?4b8Q+RcCA5X5ZhIY493AebBzoV0kbIN4HIL9cAST/X4nafgpy8qujbzngJba?=
 =?us-ascii?Q?+TowCILvF9lrVYCmg92H8qxztWnZP1D3C8xgI5QEF66L/6jLiKsKS6NH0p8b?=
 =?us-ascii?Q?TxfUmvXgtr01fxjOwdV0i/wr+GR93woh6Wof86LPcuA7swkq9e1jEcRkJ/Bj?=
 =?us-ascii?Q?59r4qims72Ou9XaTvCp47hbSdw0SuLumVluwPGf4+KbX6wI5FHk93Uxctjbb?=
 =?us-ascii?Q?jZKm2P8+FO+w/ZNpi5PnyuGyacwQtk22xQ3ubaOW5DGZRhjO9Z2ORKXUudF0?=
 =?us-ascii?Q?ALfCT0Jc/j0frEdGuoLf2/ZJHP6MAZEMlwtXmgyh+sE648hBfxzGogU/DoRv?=
 =?us-ascii?Q?Am8d4x748co7A4vGQPvDBw5mF2JkVBqb08VjTDAh30KMm9rQd9nJyDAmKVmy?=
 =?us-ascii?Q?DYsOGAzM/0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xEMbsR2kT7gMDzBwHEbGOahUA3avBfhA5Z0wqtUB0hrSc8TQHnHLy5oGvdo?=
 =?us-ascii?Q?mPrQZ4HS9jTNbNUUU/shg+ibpk94gJDEtXbuTdRkZNeFnqiqqj/fNZfUbfE2?=
 =?us-ascii?Q?DlODANxIbFafm5m3yGKvmpr3Z6VMWQcNCugPzOg1DLyH3upEJQJuIvyGFTM5?=
 =?us-ascii?Q?FgIJDNZ4ZcVk4xxcYlpMiSn7Jqqq78gP6Hmxe6gTL8AIvHxAkiKvcZ1rFalz?=
 =?us-ascii?Q?mzGPWX1nOk6EuiuiAJUDAjvjSM6ZVYaodqsoQoD4hwrvQDyT4hEkKIuXPbp0?=
 =?us-ascii?Q?zqjQAa/oJVaagdY/eCo4T5ZfZ7Gf92PCAZAVPBFFszC/kuMr7xefjoQvflaV?=
 =?us-ascii?Q?GkOlUNdWW+YPJVEjqLpjY4+JmkgGPxrQ0ggmqIy0pRQi4EwENE0HXUlcGTVJ?=
 =?us-ascii?Q?GaaO1grCtDqh948I3evWn6jiiXNXPVDXXdV6uR9TUzWIDO0IIgR2CVmin0Hk?=
 =?us-ascii?Q?FHJNlXrCl4vGKJb7CQF+ucM2gDGTLoghzUfJ/0zgqGgP1mIQTpv16tmmFPO6?=
 =?us-ascii?Q?z1jkdCbD8BIkraF/coucI4fQVbStOhfW6Lekq9Ua4sRXWVD+aQ0aUPahMsrq?=
 =?us-ascii?Q?LcKmD/hIRBjaENbkSb7VvlEb6GyP0sKrV8lJE9cbpLFcNdiw+lHpLqVHUfvm?=
 =?us-ascii?Q?aeXN9+V5xTPwFVhsdme/KU+WFIizs42UNktZS+6OU4ssW5u5/UlbNA2DABM+?=
 =?us-ascii?Q?dzS/5IgsPrXCaIOouSDtiulOJ/ZKAKrD2Q2YPkZ2KbItlwqImdhDoJoqAAfu?=
 =?us-ascii?Q?3g62GF/IYXdXEaBlUzSXYxtiIEzV0UfTT3/D7UvoVg/Virv7d3f6BuDlPojl?=
 =?us-ascii?Q?luqxTtmLSTlfpapQ4IMTyk/JTUR5rYUmtHWI/po02t8PECPmzTr0BOn5CbcO?=
 =?us-ascii?Q?q5aMPlHFHk97FFG6Zr8exMs3KalPMu6jIcuRivLAowqHJ2UW38+sB/mQq0nn?=
 =?us-ascii?Q?mox7dlHToU/aJ0QVRxNrgdOgE42ent9GOHwtCRvFCSt/NNuDKbo7xKmd/aJW?=
 =?us-ascii?Q?OEj+YQf5Q+Id6LJbFQ7cBp/3A0jKky+6APBq7zZD7znklPwPWBtgVFD9AIuy?=
 =?us-ascii?Q?yIOAIP8XVXsLiqSJod9vL6R+9W5iv+asXl/RRkTpfRRZA1tnbpAAKW+kgj1f?=
 =?us-ascii?Q?j0dumyt65Y9ggvmFXOppIsUGi42CgEMi9gGOSQq7uOoo7ajPx8EjAW7xnEnV?=
 =?us-ascii?Q?cdFtBF9mIwyk0d8G1KPJBQqLDTTsKZory/IrtB+5cm2eH7qhePMgrpuLCjRS?=
 =?us-ascii?Q?kNOJPYOGYadkCWTrNyVIxBoP6j9QKrQeFYDGscAJ62sWshkG4VPn30ZX21mo?=
 =?us-ascii?Q?uMLIjEWb7kzm4u5b1kwu+sHRlPn10Qc/wvyg22ptfGoMvvN6Z14aanAvh4Qj?=
 =?us-ascii?Q?xrFwLLVOlyU9pVOfTI6xSfiGDeXT9jviuEmwM42b27YAAcF4Vq5A+fqqYrCj?=
 =?us-ascii?Q?Mhhv92pUHpFoW0VFrc/Z5h/WQv+UshZzaYRgvcEQNaIrB6l8eUqyilxvsq0c?=
 =?us-ascii?Q?ci+O2NBjjDuQ25VkucCtqIxxXMz7GTZulmMdsIzXPmIcpUASJrhvi4Cx/KUx?=
 =?us-ascii?Q?wluCU2He7MKvHwk3Cw8/8K+Bp5T95F7MeftfWFCx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0622f445-46c8-436d-2e9c-08ddd61ae206
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 01:28:30.8355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7Go5Q9gelUM92ojlTibyamh9RpIm75gHitI0njeSupMQoldKEUY6ZjNLIIXH5xnBSPi8sYTsy0jKnmBp2HqAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com

On Thu, Aug 07, 2025 at 01:48:25PM +0200, Alexandre Ghiti wrote:
> On 8/7/25 11:00, Thomas Gleixner wrote:
> > On Thu, Aug 07 2025 at 15:10, kernel test robot wrote:
> > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
> > > branch HEAD: 9f7488f24c7571d349d938061e0ede7a39b65d6b  irqchip/mvebu-gicp: Use resource_size() for ioremap()
> > > 
> > > Error/Warning (recently discovered and may have been fixed):
> > > 
> > >      https://lore.kernel.org/oe-kbuild-all/202508070607.QKVa8DiU-lkp@intel.com
> > > 
> > >      ERROR: modpost: __ex_table+0x1584 references non-executable section '.rodata.__func__.103779'
> > > 
> > > Error/Warning ids grouped by kconfigs:
> > > 
> > > recent_errors
> > > `-- riscv-randconfig-002-20250807
> > >      `-- ERROR:__ex_table-references-non-executable-section-.rodata.__func__.
> > This has nothing to do with the above commit. That's just a new one
> > of the same type as the ones which existed before:
> > 
> > WARNING: modpost: vmlinux: section mismatch in reference: xp_fill_cb+0x46 (section: .text.xp_fill_cb) -> .L62 (section: .init.text)
> > ...
> > WARNING: modpost: vmlinux: section mismatch in reference: 0x19e4 (section: __ex_table) -> .LASF400 (section: .debug_str)
> > 
> > There are gazillions of them and that's a purely riscv specific related
> > problem.
> 
> 
> Yes that's a riscv issue that was already reported by Marco [1] who also
> found the underlying issue [2]. The problem is that we emit too many
> relocations which overflow the number of possible relocations in 32-bit.
> After discussion with some riscv gcc folks, it appears to be caused by
> relaxations which, according to the ABI, require the emission of local
> symbol. We don't have a workaround for now and we'll discuss this issue with
> the ABI authors.

Sorry for multiple confusing reports from the bot, I will disable the further report
of this is riscv issue.

> 
> [1] https://lore.kernel.org/linux-riscv/960240908.630790.1748641210849@privateemail.com/
> [2]
> https://lore.kernel.org/all/1714337938.319508.1750244108368@privateemail.com/
> 
> Sorry for the noise,
> 
> Alex
> 
> 
> > 
> > Thanks,
> > 
> >          tglx
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

