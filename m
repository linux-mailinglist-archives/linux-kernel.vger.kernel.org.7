Return-Path: <linux-kernel+bounces-863965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA851BF99D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3176A34361D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408881F4190;
	Wed, 22 Oct 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="noqRKmbA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EDD78F4B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096804; cv=fail; b=qdaWPW5wmL/ihvDor16fiWtXhCyaywyyDZ89jvcSRHhZpgvxPipHf+JXbCv6RnuqA6T+Q9jFC64kmcqgRwIVkNbYAhGrPXF+ECZwQAdZjMtX+Py93cv0B4rpk6VCYjoO1yUdXyo2tyhdEwBkzNF+rdrpxuBEHjoZFlxPtZ37FuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096804; c=relaxed/simple;
	bh=15BwvHVmzqaHAhE4U4o1wrlLRnWiX12wc6VUzy1GtNY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=B4FluSSo2YHKJNRQPH9MFGtmMAehdFYV1scP3tGfrDR8zaFfIr5CJZoEMSmxCEEsC4xYCOdNSB5d6pS9ovKAoIu2AzAa3e1QwQ+bW8sToJ/NxjXwIErQcWVSng7SXnlAfIxrw28G2IVivj18DSwz+hr9yZclVIVBgWEkSYpi0c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=noqRKmbA; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761096803; x=1792632803;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=15BwvHVmzqaHAhE4U4o1wrlLRnWiX12wc6VUzy1GtNY=;
  b=noqRKmbAQkf42isXNlD5M1EjSdPSeBYw+fKSfCgyw+RPmGHQ2oXX9fdS
   irTDGZpET0Z8d9syQkV2bcVtjEflTZNH7FKuNn3UJrl5gAry2iA8MnU1/
   oT3er9I3dEKgRhzLgUokG4Ig74IiOZn7gArGK3umMIvkoc+CwYZYfbVN1
   lChR3Aebrne9gP3OMn8Nnd/Ofg+lpr4zcOrNRdvW+zy+0J8DepMmyPcTT
   CrdTtxgwSt7WA5VfJQRGirPVqDlXWL704OrN33FkKNk18RAMR16rrF935
   PTdFX0xd9wS49K5vWP5hJ0040jZ7pxkSDfU+PYIn/U2uTSCUuWZDQSHi+
   w==;
X-CSE-ConnectionGUID: c7vIg1T+QzOEpicQmQc5AQ==
X-CSE-MsgGUID: 5Pq0xSJTRDCPVsxqvMeIpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66875726"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66875726"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:33:22 -0700
X-CSE-ConnectionGUID: P5jS3cNBSN+NGSmE8KToew==
X-CSE-MsgGUID: C1FZoSLcTuetMHqTFBfgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="187777993"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 18:33:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:33:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 18:33:17 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 18:33:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KyMCP95XYWfniwl8LHY7trRNHXyjr86MszLVmATmLZw9P0JNJi0CgzV2jH5Co/Cy5gQDwFUEiFk31Jt2LmdYRcbpZz7bvJScib4keZNH9yef/PKftnHv4vhVW7R2ZFcEyGXd74eze6AqCxmg4dxOwCM4mKYAuv1BJzMOVjYhgttqNWUG23iCp9tLzzUdw9pK5hmSioodLndPP9hjK1S9vD8howBRDgoZO5VtpytvNP+csTt+Tu8jclFBrlDl+A5hAi88zMfTd2t6N0peuIcsFqjw5vw7FKrk9s5+7mP/JauSTaHkm1beO61IKAClk0gs3i3UbappnizlfNBozb4GHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s67idW1bX+skiSZF1G5gH74MFTpkglGmOZZF2TJfdCU=;
 b=xHrUUbxRMUNJ8GbgzyIeg16Z+8Kr0q5m8tDXNuovT0wr7jQMULYUtDubzioayEPZ7KKO6ZI4mGG+thscgmzDcLQHQkx5qWHeAlZOBUVzyvNyZ4jfrncATQJ1ugjWZlEIpaWFtfk+roiNEZtXMQJiiZOriPikSZmUfVKrkeQkPgwmP3TC3qAtOVvAF8QUdwvqrpJkr7192M1eSi759TtgI7bAfhs75AL2OWqQtQwWMijlJNVNp5ScH51nP+R2sZISUZvRFSqsx2zUEX615DovLcry55kTob+ScmHOYshLmgij4wrTMudtJmEpfWKmre3PFazs6BkzuSrSL7HUTH0lvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4172.namprd11.prod.outlook.com (2603:10b6:5:19f::15)
 by CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 01:32:59 +0000
Received: from DM6PR11MB4172.namprd11.prod.outlook.com
 ([fe80::f86d:a320:27b7:afcd]) by DM6PR11MB4172.namprd11.prod.outlook.com
 ([fe80::f86d:a320:27b7:afcd%3]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 01:32:59 +0000
Date: Wed, 22 Oct 2025 09:32:51 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Kees Cook
	<kees@kernel.org>
Subject: clang-16: error: unsupported option '-fsanitize=kernel-memory' for
 target 's390x-unknown-linux-gnu'
Message-ID: <aPg0QxoIH8Nh23ba@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
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
X-MS-Office365-Filtering-Correlation-Id: 49cafb6d-c61c-4702-90c6-08de110aef28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u7F7ooEWVD56EJGGSeu3PD+2nJMI9PmiCEu9n/1Lsy9QYnHR8WexaMjaNv2O?=
 =?us-ascii?Q?ltqFtElgkNslLJfdAlD+GXh+9yvMQpGcUKRoLXcfObRIP7NRPc8geuN8qsnC?=
 =?us-ascii?Q?SbnPAXU3JGmFTrrbljKelc2B+fyKB1W4IR2qdbMFlmtj81G5Y7i4hQaKEcRB?=
 =?us-ascii?Q?6wCMhJb/hdDUy0q4pGTLVBzsgHsYKM+nsAy3ofU/oUjiftFVe7mUJrBmciWj?=
 =?us-ascii?Q?ojh5gILek26kY5Lx/DhEB9Jj2/Z3YL8FyQPy1GFKwnMCJLXDCuW7035hasXW?=
 =?us-ascii?Q?4MNVsYmXEQaApydTrli4vpbjqn3mLkNCd0J1vaupDzv2+mj36lfTTJZFKWAi?=
 =?us-ascii?Q?CHNDA/B+EliUsHV+qokETGVPMEp40INQwPfYrdVMHAZtJvW1dh5RxCz351kV?=
 =?us-ascii?Q?MD9Ul2hbvo5nMWqUwLk24JqBJ4FP8cp6J/GTlMx3NK1JHObpm8TjAy2P43jr?=
 =?us-ascii?Q?1RHv4Z1f59fHtDCvXa2yA5gscYiAmUHnQtkknSbYX9mVuSiz6M5gWN33x2lE?=
 =?us-ascii?Q?OsdEsbzG1bH3r4Z3B8Yq1WJ4NBQ4A4k7E/HbJ5r8u9J6w4Bzzk+tL2tZZct7?=
 =?us-ascii?Q?GbdfG347ZplDLzCxupmzusI7+DmRH21/y/WNYU0xo+V2pzif6W0W+1rG5su2?=
 =?us-ascii?Q?T0CdnvXNyaOAO3JVNkUuc/sNVQ1Mmeb18UJA8AsRRjsof23fmNYDcXEsXSQ4?=
 =?us-ascii?Q?EdxrozmNLmWJX5Etwn/osBYyOlQQN5nKdGJn/twY19xPeBmAx/6ln/9IQBQV?=
 =?us-ascii?Q?0+tZBOCIRfgaud8d5okR9g8rfI3kHVKQs6imelFmkn5/cx6B4nZIMp0ARwaj?=
 =?us-ascii?Q?ct0frBjGZ77WvlGjS2J385AqJP+0as1mSPKM6SnIf+WNBH4+OeU2NT2yEI38?=
 =?us-ascii?Q?GW442MaQQlLT3GEAROCeDhDaZ/lOx/hnYzmNaTqRVbWkqES3BQ2OZC+Va5J3?=
 =?us-ascii?Q?ybUmvJllkzm7adKSwcOEULZQQcYzYza7Do5fPzHRF251jmqdg3NZsjsxF2y+?=
 =?us-ascii?Q?WFCyC6jHtnnTG46tEuG/CpxpkBnOMqXTviHHUSqMv6YCoNraSgOmXwsvT0Jm?=
 =?us-ascii?Q?20JDhM2Ra2FRrbd8DbM4eue8A0+ngEnr5jP4ouy3T8OKE/Lsy1P0SzKkAB/B?=
 =?us-ascii?Q?kAfV/KNxeNCNxWmqHNaL8X1G/HCCz4JRiek7LXnn6NBTIg2izv5edxxFqLXj?=
 =?us-ascii?Q?SOCPJqxn8g0Xrc50dwivMFh27Re9BL1YPb6mLNhpC1uMur+6sWNQ0NW8dv2N?=
 =?us-ascii?Q?H1yyaHHsMGRc4t6o+DdZCvl7eLIY1jDV36iFHRsyswVD75htoAySGH0idbOi?=
 =?us-ascii?Q?ZqzYI1TWzAy8FCzta3rqjSG8QSP6ZCVoupxUB3YFTXAhx3KHjaOcUJ1F3232?=
 =?us-ascii?Q?VZxVYwKezgVyW3flojJ82w3U7x6uwa6YuP7kx03ltNN/T/Vw40C+XCG7nK6R?=
 =?us-ascii?Q?wiRkOK0tMi9sefXgnElNRyoJSMagAw3CerRxpd/fii2ojruQR6So0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4172.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVQ0BNFv2i2HgomeX4ma6b9IAU3XoyuG7fDTu6p46pjGQJhPgEaRvL/ewFQB?=
 =?us-ascii?Q?hH1Vg/dDbekmOcFGUkUdY5cApKVSK0gL3oz2PLXJMjewvHwOhGXx3sIiUKfO?=
 =?us-ascii?Q?aZBQWfQ+7a9fTiA2chhCthItAWHjk09J9N2vKRzWESlk9G0JLfO3XoW826Jp?=
 =?us-ascii?Q?pHDjEAkO47FqrBmS6SfIkZtgplvzHwFQcjrZ/DViu+816t+4kfSHpFiF8uAQ?=
 =?us-ascii?Q?U9Plu3BnOBcoqeI2HFyefWWVGru3heGXaRYXC2cJvB0HVKLlJU3eSRLHMzo6?=
 =?us-ascii?Q?iaPin+ssCyu3oC3uuAG+sTPAPZq7qD5Yu1DUS8nZZZtKF2+dgkmrOnmai1D5?=
 =?us-ascii?Q?Fgl0ErVUqw08nXGza0Hpb4O4YsMm+bwrt8vMZkRrGCTVO4owg7iQX6rPDbIG?=
 =?us-ascii?Q?Ixl34KbwdgsysUDcumefR/tmH67Dj7Pfr4uIVn3W5fG15NxB5W00smZyUdrl?=
 =?us-ascii?Q?AJXLUltHQPNMLwoRYok9qaMZIOsN4F3I04zbhcADM2VwDR2TePEU4NPzUQ5C?=
 =?us-ascii?Q?jkGIxqhz3m1XPh9+c8eFPoyQl3PW4HaPmgLEie1dPKySEo8u4vJrKKFZi7cK?=
 =?us-ascii?Q?ld5wKXdsSg/unAvXXipj+1XLvB6bTX4kMg3/NVwNuVkQcMaQk3bYjVe1UYeY?=
 =?us-ascii?Q?yZxeId6Zj9s9utcVapbT9oN2z7MQPdCPjJYH/dn7cIDe2S3k1HF2wwHwEyZL?=
 =?us-ascii?Q?RQXsblaAIrEUf9OMr0vmIBjJ6t7hp7DC106HitaShMoh2/SU9Sg2WhebSUQj?=
 =?us-ascii?Q?nI/ZGw2T4Upuhsml62Hg21nV+AwKHrglkYDLUDIK3j6srNs5/IDdy+YocHMr?=
 =?us-ascii?Q?Bu8gm9d4a3XW3ZuizliS7VUHKzoWsYBHoR9MNkBTTPhby0bGKElucuJ5ZL0W?=
 =?us-ascii?Q?J7xvdDFe8keU6JwCcnBI0axn+iYGg/ypHdPzxOFND9hGdV+pYUxW/k3L/IiL?=
 =?us-ascii?Q?nkEo7KcHD+A34s+aofvlGVHjVh6maGnD3KduClb60ML5z9xLNU1uYaOifT03?=
 =?us-ascii?Q?LUG01Sfm400+3AAKIcJuw8ROBH2MqFF/vLXuBMwCQpt1Dk1bOpn3u87bM3mR?=
 =?us-ascii?Q?YP04iAiFmfwBXFPvZPuHcMpSnuy5x5k1Gw+k4ORx8OBKuw170rbRiRLqQUc5?=
 =?us-ascii?Q?5qeF7qSkF5x74MC0MqTQwYSA4p8SQ66/du2oi7KvuGL4T6j4Kbj8yTGhpH04?=
 =?us-ascii?Q?KDJl/GDaCHgRnQOCbJCw0MSt/wZQ/Y7Gf0R4vivrYHlIXL8Bg5ZtK/NvrcRf?=
 =?us-ascii?Q?8iDR1tJd6WIKYIJcqmkKLMC8cIP+9baGkIWbgj1HNIMFy3yQBK5urX1YldEz?=
 =?us-ascii?Q?N3jUsPfoDypsKsFLphc4yRUQ/gDRsRE6gFCgO+O6fw0mL4xXHYVf69CeIgR+?=
 =?us-ascii?Q?NJHmOgqdDIfzaplRLkEwyxopNDfmsgJs1RjFr2Z1M9GL0hdghX9TPy609/Ob?=
 =?us-ascii?Q?qbvZz/GDt/oAxGyhNxdMqqFAn5mxuXyQLNjCvKs5GPZqHz51IqmVeOhl6dPf?=
 =?us-ascii?Q?XfBfxAQAfQhDSvM71tGcSPxNeRAHXpLKrfUmfmFA3tWxxqop/Rp92yvQGfjd?=
 =?us-ascii?Q?CsVtj0lLdCL1GM+cA/vCVfFCQTss9csEE17no+cp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cafb6d-c61c-4702-90c6-08de110aef28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4172.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 01:32:59.4644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9/o0omMKEbW2wdIaIeBIVyKJ2dpXZ6y/wATvtdxfRxh6lskke6nIwdTdUNLnFvW+nVK0X8e85FVBtsZCDX8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5073
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6548d364a3e850326831799d7e3ea2d7bb97ba08
commit: 5ff8c11775c744dc5076ce126eb1b3adce0a70ae KMSAN: Remove tautological checks
date:   8 weeks ago
:::::: branch date: 23 hours ago
:::::: commit date: 8 weeks ago
config: s390-randconfig-r133-20251021 (https://download.01.org/0day-ci/archive/20251022/202510220236.AVuXXCYy-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251022/202510220236.AVuXXCYy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202510220236.AVuXXCYy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> clang-16: error: unsupported option '-fsanitize=kernel-memory' for target 's390x-unknown-linux-gnu'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


