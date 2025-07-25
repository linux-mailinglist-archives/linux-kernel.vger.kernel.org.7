Return-Path: <linux-kernel+bounces-745513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2D3B11B03
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B48584722
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B94F2D3759;
	Fri, 25 Jul 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekp86VY2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A19291861
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753436486; cv=fail; b=PN/2JIqs4mQAXbrjllqNLQM4CW3phTq3hBBbW3FD+H+K9Z3FGnseHeDyEvAUQYD6wz61vBxGmNaGqiUl0/8A63dVT5kOBH2JRqgMJa5JC5tANcwJ3vdSS78Y7INJ6EVH3H5WGjkUOoCRmjbB1/LQUH7m5qKfsLTqgIHqXKjpfTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753436486; c=relaxed/simple;
	bh=38PnFCzwTQohVRz4pmfqauMvbO354akfCerl8IngIDA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NOp4aW1YdCcwtWPpW+ge8x0toq4spNUkgjf8XYtaMQj3MptOqW+YnBI4UNatzzB3v394LhjLAZAP2yUkTTcyAIQkoOYHgiMIbjWXwLMmKexTx9c2urE+Vd6vWtDvOVL5Gqrt/trwvLktHSSaHv/iXoQKxlNdF/hIb0crhbjYkc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekp86VY2; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753436485; x=1784972485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=38PnFCzwTQohVRz4pmfqauMvbO354akfCerl8IngIDA=;
  b=ekp86VY2dQ2aUFVLFXSHve4LRD8WPQwOAm3vXuBZ8F6Xa+vzHOsqOvL2
   rAF/TRewSp2B8PX3CNZdYOVHnRtevLx8+OfppiIXOxWFhzHBmmoiSVsrK
   H/oO2LuE84sVUDRwJ4aQOlGtNVP/vHKtNm4q4JhwDOlDzWMSyg23LwOXg
   IFkbXiJqvJgU2DM05yqAsz0gSTZMi3wsjn//ZAR+BjY21bTteoOP2WcZB
   9dveUBfvjA0mnsJqhCZ09pvTlYI1y9XcAKWGxTsnAWzHDKeofn/z6X3zO
   6Y5gOtNrtcYUYMI3TEi1Nr9BGSXElXM/GjOCcYibp8nq8xcjXz8y6nsnx
   w==;
X-CSE-ConnectionGUID: YhH5gUbbQsGU7JNZf8SLNQ==
X-CSE-MsgGUID: B4WBL/gnTCylagOmunCYEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="73226005"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="73226005"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:41:25 -0700
X-CSE-ConnectionGUID: mVKDU8ZMTXi6gGh+jDUSdw==
X-CSE-MsgGUID: JoA9s18cTC+dwzMUeJKN+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="191793474"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2025 02:41:24 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:41:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 25 Jul 2025 02:41:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.87)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 25 Jul 2025 02:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+cgIJMq5veIQV5tjqaUejzOtPbCmwHVpOomVCpAQb+i34MNAdpzfRTfEeXHgv/529dX4PMJ7Mmcw4xQZQjxZ1e+p1viHH0Iqor9PsC7yHv2VtHdIL747NytMOt+ygGfxqt5sgJWkzOKKC9sK1GIPape268mQ2cxhjYv0kmm4plhDrxtdrhv5or/shMEiXrtQCV7Bg7GYJh0QUYZxOH0WiPTaNm5KewzQ0dFBhw+nyA3pa6JFTbjC4DkZiGDf/CgQJzKkZrNknmLJhRuDWiuIUtwbd3TFiHM7X/Prfk98HOrIweV1NM6eOxklaFP478VBPo9JWaI4HxxxGDuIFGn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlIO2Dqwah6B8nc+3fWs3PUewAojvOl204Aosun2QJ8=;
 b=ZQOaoRiog/IYjbzDuaTzl2e3dNY3oGfzBUxTyFsdFz4G0Xwt7UCwy5ZcrfBImSwhKByOykvDJ3e0vlsyeYTd7PO/tSqidSlM367XjIaLNfVNWYcWkuKYHfdhPM5zioyoYSmNX40xfz9Xq81nsBNjPEDvKEpxl/8y9b5ma2PlDnZeNAoiUIcvdRknYup94HEo+q88q4HH0cR5Lya+VvU7s5PjKeLoAWw23zweqtu9P5fgBG8UTbtMdNf3zCa7S14iMZDDyjzKYd8MSJuwV7mDKsymqfpSOYpviQxRwqKU+TvKJJRqn/qIbkYOlIvKvwV/3YOfeOWBULPQUc18sD97XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4902.namprd11.prod.outlook.com (2603:10b6:510:37::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 09:40:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8943.029; Fri, 25 Jul 2025
 09:40:50 +0000
Date: Fri, 25 Jul 2025 17:40:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [drivers]  dc1771f718:
 kernel-selftests-bpf.hid.hidraw.fail
Message-ID: <202507250945.a36cd041-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e56914-d9d4-452d-1a0f-08ddcb5f5761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D4nM9vA6Lxda+MdOFMqwhzEasyacCq5z8WeNPEfHA6DkN4+Y/7aYDCLUElu5?=
 =?us-ascii?Q?KFtbEJ0PtZE/c8aDgQfxQwVaP2y2KMFXmhKS9dS/gA6D6tArnfMNyxv67DDb?=
 =?us-ascii?Q?1KM58dXboq2UURTgHu4cw8NM1922/sbbYdkgtISxIQ+4KtEpI2HNZlp2zQV7?=
 =?us-ascii?Q?sj1RdcnsXfAYWMiUhEsrp+O0/wFsNlPGAaTBiOzdmXjEKfyPTiX05B4/CBJh?=
 =?us-ascii?Q?nHAkG9OBvugeaPhoGocFeaGjA/lQCyr3OObDM6fAkpGCySIp9xjt+WPpH9EZ?=
 =?us-ascii?Q?e1pfD/0RNX1aOwl/pw0UARLow3sJ5nELszw9gBr0D09JpT+ljZEOtBfFifS1?=
 =?us-ascii?Q?CTtCSbQeTpvXFftmooUz9IpFrRifcF0IVbiTQD7Yzrx7ihNNmoSH/D7HAw2I?=
 =?us-ascii?Q?eoHsLWb02q9WjbaU3vJhrwMVaW0UmG2SYVyRrFHHkN1a8dtGY2GP9S2fGecn?=
 =?us-ascii?Q?iESnD1Xl48YTjkuUf+Zo+grpu/vn62I0J5Nu3nmOJf9v78lTY63FnImy4DFE?=
 =?us-ascii?Q?DRxcB/aZC3Gw+V4Wx5+azlQaNBW2DSvROxYNp8oVxBgJFyecStdZb5DYgcdO?=
 =?us-ascii?Q?OgiJDA7msj9nlUF+jXPCA6DF71kxpvK7Ydk7lT2HT4/j8Mur2qxB1zpCQaun?=
 =?us-ascii?Q?olGPCrXxVXvQS4usXypUwAgLumdlpiHkWljodGolRlrMzqpVGn4DpfLAa08U?=
 =?us-ascii?Q?zLpyPLgw8pv3Sf82MIH8ggygO0xiHIep46wio+WawveETl6da81qLheCBSaw?=
 =?us-ascii?Q?rzkEFucp32IONbc4Q3l8Qz/MEahbSG+FhoVoky6D/Y7ENtQ9eaX7KJWWabsM?=
 =?us-ascii?Q?vhL1BoAVkWxPPA1sacQ3CZbKskgl2Ls937nlbPRvyllMh7iBmCWQWRJilZKG?=
 =?us-ascii?Q?7Q603+Tv5OWq0ie9PMj6TKz8lxhOvhdOfW/vOg3PRT//udRVEWp4YC/dzmBQ?=
 =?us-ascii?Q?Ij/EXlkM6HzCTIxyZ9Uod0RaqSIh5j5TzoX6pNWxAiBNylZFiJSdb/y44dSm?=
 =?us-ascii?Q?qrCtdDKoTncjBHvTOOKm+Zve2jl/QKfpRFYiz8aXC34pnnefLCM/01CzxrTW?=
 =?us-ascii?Q?Ne62cYO4zL2RxzeYrBnJzAa81eUnZ8j8N974vwvDZkCIyGLklF2ZrIJ36iHj?=
 =?us-ascii?Q?b/lsCn3+hDmsC51ZWwyO/jje+DdH0MHlkcKC3AdoLkZHslkBHJeiSdo2bQF4?=
 =?us-ascii?Q?hWL+GOXxlM9GX8sdpawuEH7ae5sORMYgIEzrsJ/HN1koF1uAjviF75Hvh/gE?=
 =?us-ascii?Q?dhY30OvlczsuWUdAGw/vXkP7LpNKo/D+ihQyDHglstbD2TeexJ4GOHuAY5mw?=
 =?us-ascii?Q?yI7794y0fD0TxYjvYHlq5qwqO1OtUzM5VIFd80ywZvZ4RiakyvyKrJpYQj4m?=
 =?us-ascii?Q?OHhHB+6B9cs+gd2H4tPS868VYYO0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8NSyAWZ9pyt7/rAbye5fJEb1P64o2ml3TzG64vdFYWE5+8mfZPK18hROsBfZ?=
 =?us-ascii?Q?DT45nrSRIa9YWeKQsZ4JjTBCCS3+w30ZKW41K1a3pykHrW1eWKdehRzbPhIG?=
 =?us-ascii?Q?UPgWbhO2xya6vXULtKxF4coUD78AxA1sPQ9RCAC1JADzMjLIT5ha5xYEJflu?=
 =?us-ascii?Q?1K5Jed/BjA0P3uav+kuvHu+P1MIxqp9a1Yp2sY5jmtH7pxWOJ7PfKSY141I0?=
 =?us-ascii?Q?gMuj570O52ji33Mzt/zgBNPw1XN9shFOYQU2dippU6wN8VuIQmoBzgU6t2XV?=
 =?us-ascii?Q?qostYpybAzE1AqCJa/AX+W0YFj/sq17sLH9/ez/mlubPttfbnIqNIHF4Lozu?=
 =?us-ascii?Q?hM2hSwwlWkmXUPBuLaIhKcJOz0y9jvnMWmKg39c+kNugOpzLWPuwI+UuadBW?=
 =?us-ascii?Q?gjVUQnMPauhCdHrNHXT9Ppkjf5FlwG2WjEjkulmnjXqy8M+PZFTpG36RzB3+?=
 =?us-ascii?Q?gQ8odPuTSmXUk0aWKpCzC0RCivMGirfpDZ8SQ58b6il4rsmcWEdVEgwguQxU?=
 =?us-ascii?Q?NzXtfBPjH1gds2q+HeDS6Jy1ABK63qQ1D+xnpJkclrnJ+0n8mAX2alrKGMbw?=
 =?us-ascii?Q?C3WaCQ0w0DlEMRGk/dnCB7MZ7FXWOi6vp6aYp2ert8cgR34hJT2g0Vht0eTr?=
 =?us-ascii?Q?tNo7jj2jC8nQAkPcZJ+GdykeSmV5mcvAkQcAyH4LsEF2ov3C7WVkWp15mrnH?=
 =?us-ascii?Q?1L9gwACQNn7RzY7MHjIW/T81jn0ayAu4XWsHXW82VQCz7o5F0bQLXrIWyOh8?=
 =?us-ascii?Q?d5BeLxc2vTJwx8NaIg398B9biedwEMwy5Aa/T9vRrLO60+bk2hLtLXHbe0N1?=
 =?us-ascii?Q?+EUYj+yoz2NOJLgIx3Q3+rxT5I3nT6BLaE35SOCICz6A+R4dGLLYSwqIfqly?=
 =?us-ascii?Q?PAgBcZVYfc3lcpgf3l0tV3vaGSs+yP6TXboegO6CMqC64QN83iFHY+ZIUxwD?=
 =?us-ascii?Q?05Ip9Bxm5ueiCTCJW1Dh3ByT1ChPj0vS5gKwUmw+JYY8GOk4Tgp/Wbre2xvI?=
 =?us-ascii?Q?fIv13kJI+a8v8qdkMY6KGFcmGohIL1YAZK2LFbi6thlkhx1QHu7tlwpIXAph?=
 =?us-ascii?Q?xnn6V8L6m0e483SmOSdOTCHrApofk+WcBcORy+hac0WJdjEYpAYVyvmLuvsS?=
 =?us-ascii?Q?oGeh7pRopE1rKJIcJ++13iTEZdS4IIINd5VkTxER1UhDjk8lJP33feXa39Hd?=
 =?us-ascii?Q?lPegyUOKQAGJNEK+gxIo5uRtsJDpnQH8WMFNq4L3Ij/tpvrOMxFnNUuB6n9b?=
 =?us-ascii?Q?FcMqkzMoSdsI7leDQAgSotLF0mD38sVpXY6oEFYpXqR8TAZ/pHCJJmUoFvHf?=
 =?us-ascii?Q?HUBeb17EvrUkpiNNFKnEqr3OnHsRFPI51BelI3/D4jGRoWo8Y6jvLZtq47VJ?=
 =?us-ascii?Q?Vj0UgySJRZKMT8mqBZCvBuSc/AjzMASr201WuIBqosLp4RKmvjvkrkoaDw4E?=
 =?us-ascii?Q?stYL9kgFl/x/kbee10x7MgEJ9aXFxXNTBUTPFuj2BGJ8XXetSLujYY1SiHax?=
 =?us-ascii?Q?IfoILUV4ofAugdnUUi8WcRveOoP/s+MPWRce6+FsbMF6XNM1yoWcgI/g90Rt?=
 =?us-ascii?Q?MQUNIWHseIbNCx6uAcXi5tWKQgt4FbRpxMzlqSnP9io32IltL2ZVz3tqxMIU?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e56914-d9d4-452d-1a0f-08ddcb5f5761
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 09:40:50.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTdg78LApNkV8/yOQqvUPFcPj7jEgBkVBO0td0afzrKcFKCe7QoBUgSiMZIM9z/qBp3nFNopIQBAzrQsOHA4gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4902
X-OriginatorOrg: intel.com



Hello,

just FYI, in our tests, after this revert patch, some tests randomly failed

332ec18d57de2f77 dc1771f718548f7d4b93991b174
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          70%          21:33    kernel-selftests-bpf.hid.hidraw.fail
           :30          20%           6:33    kernel-selftests-bpf.hid.hidraw.hidraw.poll_revoked.fail
           :30          43%          13:33    kernel-selftests-bpf.hid.hidraw.hidraw.raw_event.fail
           :30          30%           9:33    kernel-selftests-bpf.hid.hidraw.hidraw.raw_event_revoked.fail


kernel test robot noticed "kernel-selftests-bpf.hid.hidraw.fail" on:

commit: dc1771f718548f7d4b93991b174c6e7b5e1ba410 ("Revert "drivers: core: synchronize really_probe() and dev_uevent()"")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      89be9a83ccf1f88522317ce02f854f30d6115c41]
[test failed on linux-next/master d086c886ceb9f59dea6c3a9dae7eb89e780a20c9]

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: hid



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202507250945.a36cd041-lkp@intel.com


# timeout set to 200
# selftests: hid: hidraw
# TAP version 13
# 1..6
# # Starting 6 tests from 1 test cases.
# #  RUN           hidraw.test_create_uhid ...
# #            OK  hidraw.test_create_uhid
# ok 1 hidraw.test_create_uhid
# #  RUN           hidraw.raw_event ...
# #            OK  hidraw.raw_event
# ok 2 hidraw.raw_event
# #  RUN           hidraw.raw_event_revoked ...
# #            OK  hidraw.raw_event_revoked
# ok 3 hidraw.raw_event_revoked
# #  RUN           hidraw.ioctl_revoked ...
# #            OK  hidraw.ioctl_revoked
# ok 4 hidraw.ioctl_revoked
# #  RUN           hidraw.poll_revoked ...
# # hidraw.c:152:poll_revoked:Expected ready (0) == 1 (1)
# # hidraw.c:152:poll_revoked:poll return value
# # poll_revoked: Test terminated by assertion
# #          FAIL  hidraw.poll_revoked
# not ok 5 hidraw.poll_revoked
# #  RUN           hidraw.write_event_revoked ...
# #            OK  hidraw.write_event_revoked
# ok 6 hidraw.write_event_revoked
# # FAILED: 5 / 6 tests passed.
# # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 2 selftests: hid: hidraw # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250725/202507250945.a36cd041-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


