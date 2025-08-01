Return-Path: <linux-kernel+bounces-753040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C02B17E04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8CB3A1972
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3D1F4188;
	Fri,  1 Aug 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzLgHG2F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BC20298D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035601; cv=fail; b=gdARRfAuiyqp/ChKmYQUx3SxVasygp6EXDbzA5olW3LaapvFRPmEO39iNgjSr07VdwzkErXh29IBrd8/qShwyhg8MXYALoHdFtzd5C72apPl97NySh5xHD2SxiDhXJNeU00te1/3VC0HaGzCPec/p6/fuTHf9oN/ZVDj8Rhf9EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035601; c=relaxed/simple;
	bh=Gqh8N1iyXG8/jC/1P9085uCqK7o+IFLSvaNVkk4Wt8I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ej5oDAtd42VgcCVvpyrEJp+0Rswy6KoRRdVHbsMUJOdbO6FpWhZOZrZo5UJRm0ljnJLZSBKZIOTaowo67W2w/dRn4pTAIJrpmCgSGI//LNqpNmDVFS9DnA5iJSSRvChV3EsbAoDEdo96r59zFqi4FuUbYRZ8SsPtciJqDQPpOxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzLgHG2F; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754035599; x=1785571599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gqh8N1iyXG8/jC/1P9085uCqK7o+IFLSvaNVkk4Wt8I=;
  b=OzLgHG2FuSMiMKgtv0IUkVOZW7IhEnEUrnfGrB0yluxAow6GbH4jx3Th
   7SDL5KWYN6Ab4rXk5ofe7gz5KjGcyOvjaNgxTfqrhrJngmwqb18Beoy8L
   q0Tc/X6rYEhQJoyMrSJ+vM+ZeFUrn2SqPwyMlSWGUdnAE0OxyR207oMEE
   LrlpFGLrCbMpcyxNN7tvnSLUS1KiHOlDZ8112SAm/eD4gvTov2yg28tq7
   MHa2J8ItFMS1HyVIIyPT+PQtO2Yhgglf4cdRmeWub9SVkbKzBGOMedWVw
   Wl2F9AhAApYLJkctou0EB1f4jB8Y5C4C5/R1AvI5JpFZ01C6FduEOiek9
   Q==;
X-CSE-ConnectionGUID: bSiGYn7ESgmZ6fLWRb2Heg==
X-CSE-MsgGUID: qBUPcVXKQoaOMzAKDizlfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56311394"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56311394"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 01:06:39 -0700
X-CSE-ConnectionGUID: HFyP6NlgRyCbX/7ZBC8Qxw==
X-CSE-MsgGUID: gYBnxn9CSfajIJAcPXuoUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="187172874"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 01:06:38 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 1 Aug 2025 01:06:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 1 Aug 2025 01:06:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 1 Aug 2025 01:06:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFllpVrZJbHJ/fbBKHoBFvmpoc12IxLhhHPNOePZgipAU1iGWPLeveuqgvP/Sq9ROgE4Zp6MaVkiIMZg52/92U4zwl1lhhZITQ77KUVHtN2/RWf4H80SsxYBN1/n+iBebW76LkEN/yo4knqB4pLjZggBalzwxu6sVPv6ZBHT4S6V9Tb/Vh7eYgIE+5RNkSxJzxTb6BdwHrhYH4AYKnaPUVejTw4wtY4wE+vPNBi+Pjy4C9+OmoL338kgq6xGy6Rz7RiTSaB5V0R8OtZBUW2vsId3+gD1pz6drVeX88TnknnisvtlVGesbc2r00AD71NXIuBB7ZClzZBTl3+BxIrOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQUVPxUZ3a50+FKDfwZ8oLAKEBWBbrCwifmnQmVmCoI=;
 b=ciqTmv04tqm+V3nb4A+t29337EEXGQsOP0JCJ9Nx+tESVjfWNfUqkREmZJP1/m328Rre/E9dbMYpgwJ9sVzJk1qfMGQ9YRrIA+05IJskzYYOsHZaOj7ct9nBrkmPm7H9f8pS6Mua7ZTps8CaJHgVrdO4L6z4SMBjD/NCXxTGX9vZHSytIj9EDCwrYE1nDAPPDEhpJwV8hnrFAtDsqM3isfBBrwbo+pRMnuDJ2knrqjBa9pwxDmCm249AhZgNUVFzazNv/7ZbfP+7WEHSXpPRObrYt45F5garTKOTSi42vtVI6zUWqrqXVNUBrKJnt0yGswacOc1n33J0oJhfQCBE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SN7PR11MB7417.namprd11.prod.outlook.com (2603:10b6:806:345::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Fri, 1 Aug
 2025 08:06:36 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 08:06:36 +0000
Date: Fri, 1 Aug 2025 16:06:28 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Max
 Filippov" <jcmvbkbc@gmail.com>
Subject: arch/xtensa/boot/dts/virt.dts:48.6-71.4: Warning
 (unit_address_vs_reg): /pci: node has a reg or ranges property, but no unit
 name
Message-ID: <aIx1hGvud9n35Hx/@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SN7PR11MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b8b5b2-4e14-4fd0-c329-08ddd0d255c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ch97Xd80VAcj1YaCriY6uGcvh4QbUVRofUTr17g8+r+Y9GENj+dFeVCUhREE?=
 =?us-ascii?Q?4SjyBPeq0Ht5QbK9sKswi7MiGPKXNCJuF+DyR5Si6GcNwNUTEqN2uxLJTmUV?=
 =?us-ascii?Q?tNRrhXKk5FiOYLZIWHEIU7RaTRYno3EzKByCogKexcDQiK+REpoSXbbFJd1l?=
 =?us-ascii?Q?pW4gNQtxMEEwMiqprVLugbTdx0z3bI1uWH2aDi/gqTn2md8bIqwsy2nMizDV?=
 =?us-ascii?Q?viiGkzJg2gnLzJ5fvTichFyrlRuKugbbU62C/rx4VsYxbAJqiR9qFLXU6Uxj?=
 =?us-ascii?Q?Y896viXyxxYIMI17c26dE0SoiLCOILWVqdweMEp2aLIXoRjFKQSXRnB3ATTy?=
 =?us-ascii?Q?Jk2K8ThA5fz/ESpMGOQ58gbJW+oN8r4SYyb46c2ZN60xFCwOQz6bd1gRiP0R?=
 =?us-ascii?Q?zwj5DT2nPM+Cm+VuzeMAZ11LEOQkUtt00cW11hCWuJ8e2c+UrMDmPirS+VD2?=
 =?us-ascii?Q?Fb1ZfgzcXZpmbJ7vDawhBdrRdIWxVLMcTpur0Q3csHViqM6rDb2jDhM2R2lo?=
 =?us-ascii?Q?9UoVcaAUPEnrIF/szo2WgnLjtLNZ5yt7QG1+La5hrAe3jOUja9149qfAqyy6?=
 =?us-ascii?Q?1W3Bg/A0SynCtPpU0F6/UPAUcoEMSxV4tu5mylfhNZSTbIn4j64EHhbKJNFB?=
 =?us-ascii?Q?j/cs4cRQ0+z1YdboIWWcuwzd2IrdpjLtYopm98PKAQClGyNzgrcPfndaw24Z?=
 =?us-ascii?Q?QK1/1KHyezZ4v1lNbjSGsW4vGMJ2RZg5r+HiDK42xF2c4UdybRUaYLoDzRz1?=
 =?us-ascii?Q?zoWBrC6DB+QKoP/n/Eseo4waKzNukgaDZIRDtNWbSAnmzHe2V7Dfcv7MjooD?=
 =?us-ascii?Q?jNv0jLv4uq1XSugEbUj+jInPkrr5cvzXpPYgwsGKYLotYP85lkb55ETgCgwT?=
 =?us-ascii?Q?mZofeHzDuE3c3EXXhdcejGw+C9D2WpYsSpnmvL09jqUVEqcMV44j+VPQZTw+?=
 =?us-ascii?Q?RYA6EN9YnXnOc4W3zOL49/oUYV2pLkw0c3mvn9IffeCWy+uQerDH8i99V5pS?=
 =?us-ascii?Q?WQt9qmmH9WVCkZcTR+/4dBcYjWJrVI21LWK+bNsfCMPNkANwYrBGfD+GbLEg?=
 =?us-ascii?Q?661ENsW5gtxYOxJTCFevB2d+H7R2xS0jgMtzANEwtgMK1f0Dez4hQjsj/5//?=
 =?us-ascii?Q?W95LSgVsEhJQapDgKgRvXOUgqXN/YoPNL+kEcp4rk9+6GydwUhqShBoehmU5?=
 =?us-ascii?Q?QUxW5Uc7/rbIGLf/ojg0Hf53mThZOqsNQXNNQFxiq69/Al7WJRIoVmmRFlKu?=
 =?us-ascii?Q?zE1uYI4UJutFpRV5Sd1V7x+c1lGVGZ9FuMr9+vqe9FIOsLmD4bEncXMMU63L?=
 =?us-ascii?Q?VuxkM2NF+vlPb0+i2FKtYZn1z2oZLadfZla8ExLuJavRm3+hSC/8T2BFkC7w?=
 =?us-ascii?Q?+A/onxUDi8z5oYWcuNGfNraJCDF785KosXEFfc3RkWD9b0nId7cDWt0dOQwo?=
 =?us-ascii?Q?0pABABFd27E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zDUE1FQ0GZ2Muyw69dPiuSbTTH+WBsI6WElVJci8zZ75bTGT6/9b0pjvfBPI?=
 =?us-ascii?Q?GAxMG05y3WLhAjJ2dKc76qL9WRLIdM2SyZum/o+OLFaAkgUgUrfz+NadjQ0e?=
 =?us-ascii?Q?P/+NtzsAHiH7CnRm/n5EXgmyDmTwzysoLBxQYa057vipRam1u1kmH+JX76Ry?=
 =?us-ascii?Q?EfChcLQsVZm4BYJHdVM7FbgRIrav7gLVpfuVSl27FvvW2fgGElZqtIHqm+yT?=
 =?us-ascii?Q?FtoSECviOWix8GebuLOpfmCf5t3nxHRr9dA3iQDv12oEBkQ2RvCrBTo9uTKz?=
 =?us-ascii?Q?6qmQeYUIdBm+Y+XmlaphYMe7a7whN7YKUMAj8A1Zhvtwl8aX4iyG3nZlFLNE?=
 =?us-ascii?Q?lbloAxR6vP+lPtEYh30F+xmaLQ8hSfFjjUUBg58Fnf0l70JMDvskgHYeWhcY?=
 =?us-ascii?Q?Eep6N2pZkKVIVu8leucpa6jvDFSqmN7RAySe7aYy4lUCRUC5gwm3vm09+JxF?=
 =?us-ascii?Q?MnchG0rTA+39rdjcQSN4p7+X2e/6nnJyRBr7Mb6OTERCJSL2xYFcMylX6CgW?=
 =?us-ascii?Q?RxycHkKwseDfEjcxvwezdceX93WPkJvQnXTjWLTmq85540OMXLyearac9EZC?=
 =?us-ascii?Q?mwK5ef90FHF8dULoEjMcdUQDZsY1PuUpPbBcAiL/e4+epXgLKS7PPuLC7UN/?=
 =?us-ascii?Q?3wL4IT/Hc3apqCfmZwHSXMRTMzwXiX7yZEDf0nZzwhXL3XN7XFIuXAHoppSx?=
 =?us-ascii?Q?bXEnrBC7mbpFiWZ9Ciq7x0gKBJyrEdxhoW01MOnFkZMQqY8cZfywmtBvoyMo?=
 =?us-ascii?Q?5pX9ewyacQ9GKq7HGCiJBeTPHu9/fNi9qOo27MqolOfFTe29Or5yR0w4N8no?=
 =?us-ascii?Q?rjMUzdiG1QO3D77RUmdSsvyN/XgaLnlsbQNOUSST0glesyNE2GuJUmaE7whr?=
 =?us-ascii?Q?ipvUgxzCgUlWSHeas07YU3OJ+2493YtNIY/ksz3ePuXXq/WNB8r85hh+LPwW?=
 =?us-ascii?Q?gpYy24Hmy7AH0JXXSv15/Zld9w4UZ6uPdfRi8IB6ea+Y8NQZUgH7R4e7hdGv?=
 =?us-ascii?Q?PKgigWheEKx7iwN1lWPWX5PWvID5DBms2xVgV9zBG8QOmBrk908PkyOw5/Fk?=
 =?us-ascii?Q?ZzTjvYF8cIQPL8auPhRP09ts8esQmt8+u7iaU2/+R96edvlz0lb2/DmuqgC6?=
 =?us-ascii?Q?AiOCNRzvfE8v0gVZSbSVXAtkOyzR6aWLndHNnowW77d+CE762FK4UgzTXAPA?=
 =?us-ascii?Q?f/t7mCh/97F98qRHA8ImXPxdl2ZHgJCdJhdHk3pCcwFo80n+YiW3on0yOg41?=
 =?us-ascii?Q?2y9TqWJOgvp1GDhLqbyN2Ff+Dk2gpT67eHwuVGt8hW9nrjB3T9BSJ3mOELGv?=
 =?us-ascii?Q?7jFvHUCB8Kle1mpQggdHMW+fNn3Gwt2wIadUFXaYTuJM51YoVUmjxXZErwT3?=
 =?us-ascii?Q?3nIMJPeAuOYyi4JqSbX5jRtx4IoCEuVcxNHZytp/+k4IeokUav3FOvcYPC9N?=
 =?us-ascii?Q?zc47F4xJfBVZhmXrdY1L6UttwaGSWMP/Fa8xV0UKhy+u7nbOT55FnugDEj5v?=
 =?us-ascii?Q?aTjsswvFbYAgyptuI4Cjpg27WLdWDXh3ff6yQI0A1Hu/2odDA01CFi8abpqa?=
 =?us-ascii?Q?kFSEY9g2jkbMnqLKGt095ir3V5d2U/6inB7ZbAeN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b8b5b2-4e14-4fd0-c329-08ddd0d255c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 08:06:36.2397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIGG0JlZ/Aa29xXfrvyZEkBYagKQmo4BPZRtYHZTnBRXXO3QSChcC1lw9CnnHj1eLLaiXv8Xz8kbudRzcZTfwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7417
X-OriginatorOrg: intel.com

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2d282e1dfb3d8cb95b5ccdea43f2411f27201db
commit: 47812144d39566da3f1dbc7a615f656969f99337 xtensa: migrate to the generic rule for built-in DTB
date:   5 months ago
:::::: branch date: 4 hours ago
:::::: commit date: 5 months ago
config: xtensa-virt_defconfig (https://download.01.org/0day-ci/archive/20250801/202508010555.VHB3uhTJ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508010555.VHB3uhTJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202508010555.VHB3uhTJ-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/xtensa/boot/dts/virt.dts:48.6-71.4: Warning (unit_address_vs_reg): /pci: node has a reg or ranges property, but no unit name

vim +48 arch/xtensa/boot/dts/virt.dts

775f1f7eacede5 Max Filippov 2018-11-05   3  
775f1f7eacede5 Max Filippov 2018-11-05   4  / {
775f1f7eacede5 Max Filippov 2018-11-05   5  	compatible = "cdns,xtensa-iss";
775f1f7eacede5 Max Filippov 2018-11-05   6  	#address-cells = <1>;
775f1f7eacede5 Max Filippov 2018-11-05   7  	#size-cells = <1>;
775f1f7eacede5 Max Filippov 2018-11-05   8  	interrupt-parent = <&pic>;
775f1f7eacede5 Max Filippov 2018-11-05   9  
775f1f7eacede5 Max Filippov 2018-11-05  10  	chosen {
775f1f7eacede5 Max Filippov 2018-11-05  11  		bootargs = "console=ttyS0,115200n8 debug";
775f1f7eacede5 Max Filippov 2018-11-05  12  	};
775f1f7eacede5 Max Filippov 2018-11-05  13  
775f1f7eacede5 Max Filippov 2018-11-05  14  	memory@0 {
775f1f7eacede5 Max Filippov 2018-11-05  15  		device_type = "memory";
775f1f7eacede5 Max Filippov 2018-11-05  16  		reg = <0x00000000 0x80000000>;
775f1f7eacede5 Max Filippov 2018-11-05  17  	};
775f1f7eacede5 Max Filippov 2018-11-05  18  
775f1f7eacede5 Max Filippov 2018-11-05  19  	cpus {
775f1f7eacede5 Max Filippov 2018-11-05  20  		#address-cells = <1>;
775f1f7eacede5 Max Filippov 2018-11-05  21  		#size-cells = <0>;
775f1f7eacede5 Max Filippov 2018-11-05  22  		cpu@0 {
775f1f7eacede5 Max Filippov 2018-11-05  23  			compatible = "cdns,xtensa-cpu";
775f1f7eacede5 Max Filippov 2018-11-05  24  			reg = <0>;
775f1f7eacede5 Max Filippov 2018-11-05  25  			clocks = <&osc>;
775f1f7eacede5 Max Filippov 2018-11-05  26  		};
775f1f7eacede5 Max Filippov 2018-11-05  27  	};
775f1f7eacede5 Max Filippov 2018-11-05  28  
775f1f7eacede5 Max Filippov 2018-11-05  29  	clocks {
775f1f7eacede5 Max Filippov 2018-11-05  30  		osc: osc {
775f1f7eacede5 Max Filippov 2018-11-05  31  			#clock-cells = <0>;
775f1f7eacede5 Max Filippov 2018-11-05  32  			compatible = "fixed-clock";
775f1f7eacede5 Max Filippov 2018-11-05  33  			clock-frequency = <40000000>;
775f1f7eacede5 Max Filippov 2018-11-05  34  		};
775f1f7eacede5 Max Filippov 2018-11-05  35  	};
775f1f7eacede5 Max Filippov 2018-11-05  36  
775f1f7eacede5 Max Filippov 2018-11-05  37  	pic: pic {
775f1f7eacede5 Max Filippov 2018-11-05  38  		compatible = "cdns,xtensa-pic";
775f1f7eacede5 Max Filippov 2018-11-05  39  		/* one cell: internal irq number,
775f1f7eacede5 Max Filippov 2018-11-05  40  		 * two cells: second cell == 0: internal irq number
775f1f7eacede5 Max Filippov 2018-11-05  41  		 *            second cell == 1: external irq number
775f1f7eacede5 Max Filippov 2018-11-05  42  		 */
775f1f7eacede5 Max Filippov 2018-11-05  43  		#address-cells = <0>;
775f1f7eacede5 Max Filippov 2018-11-05  44  		#interrupt-cells = <2>;
775f1f7eacede5 Max Filippov 2018-11-05  45  		interrupt-controller;
775f1f7eacede5 Max Filippov 2018-11-05  46  	};
775f1f7eacede5 Max Filippov 2018-11-05  47  
775f1f7eacede5 Max Filippov 2018-11-05 @48  	pci {

:::::: The code at line 48 was first introduced by commit
:::::: 775f1f7eacede583ec25ed56e58c4483f2b29265 xtensa: virt: add defconfig and DTS

:::::: TO: Max Filippov <jcmvbkbc@gmail.com>
:::::: CC: Max Filippov <jcmvbkbc@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


