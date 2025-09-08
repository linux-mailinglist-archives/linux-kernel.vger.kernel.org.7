Return-Path: <linux-kernel+bounces-805060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC7B48396
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6BF177C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F5C2253EE;
	Mon,  8 Sep 2025 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgKP/UQu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA408632B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309113; cv=fail; b=nEgSNQ/xUzFmOJapZnmJ5K459VJc6OrdPoVhjJlZSNjbXVvUnNuHfRlxgtcS7oh52qiBa6YQNNovKmx6Cb+e5aszNzr4V2DMk3ftEpWakLyoUKqCcfTt5PNlyk2pu/Dy4zTQcxavN/mT+DmXOWjGsWRPA7z1WhxRyygmW1W4kgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309113; c=relaxed/simple;
	bh=ODrxHSyS57q8vZD17gHEUcUFHY4lyVL33yNlZkt9jzw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I+aeowt2Cbw3m9/ZbLCZwClQf3aO/i8eicoTkUpUAc9XDbtSmCrjO8A18wP93BSTyMa+WW9YBFeYhKOD1UJHuFKyY1co+fnxnoqNiZYPZ7J1VHKM8sRNbY86ByptGQoUB9i+52u7CrhgHPle/61vWSuRm3iOekF2xSxwVABcYTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgKP/UQu; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757309111; x=1788845111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ODrxHSyS57q8vZD17gHEUcUFHY4lyVL33yNlZkt9jzw=;
  b=VgKP/UQuUIQlddCx+zA6kdimvGLcokRLR1LjVRYe3u8GfhbrNNsukE8L
   zhpNsfIXpzPtRs6WiKXm4Jdtlat+aBDMzhte0o/Wryksa8bFWEaHsDdmM
   pw0bntTRl8LM9fMtVtNpLW3zQtwFvRVmTW+6pk3t/T5MnoW3PxR8NQvfA
   LusPvyJEwtLHyLxo1cF0bOfJ0p+4cu1BAtXEfS7A/5E510d8gjltJ77Js
   fsWwtn61TDy4OnyrPkpLCKrgbU5BWPFAnIhSSW8RGn9ZzyACIbDGOcZTt
   rOq+n6i6cDZsZbGfCP0ZmbvPSBT0rJ2fTlh59PNcoU/bUg9AU70JLELiZ
   g==;
X-CSE-ConnectionGUID: NhANP7W0RmCwXVy44CACzQ==
X-CSE-MsgGUID: QVTYlWQzSwGkp5wT8NTjgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="69811426"
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="69811426"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 22:25:11 -0700
X-CSE-ConnectionGUID: wiEXh1QOQuWfm1yTij8Qtg==
X-CSE-MsgGUID: 5+3Pa2wGRc6BDDLOZkkLkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,247,1751266800"; 
   d="scan'208";a="209854137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 22:25:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 22:25:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 7 Sep 2025 22:25:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.70)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 7 Sep 2025 22:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAaPAChtzjNGLS4kJ39xXD0RkekDO1HVL91lWuYpVgHIZSWdhV8L7FE+g33W2HtAHT3dtPF955ZBa1qfHGuZFV2iOPP794BAEuSnX+vRPMPkllFI9Ty431AAanXVPgyYr1NTnpyCEVQVKDQhQRhaVHfX0I6M6d63UjIokls4NaARncgaiiMJNADNMMbqKwxe1SkdYY/ARke9GTqy1waOL8RvX8PODAYewSEMeD2HghhsVUeHiO3BA2y1FKY8P1kHDkP+VG0OFSiE2wReBCnElHXQ0zG1QqX3Ai+UNg2nJDRlw7aLw4Vgn/aAatvYQ3M3jxzSPz8Cm7nto3wB4PpGyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVie3w4L/5IE5PIu+akBB62B7hUcYmKR2lHPAJHJ2Ms=;
 b=yTO42KkwKElrvqoTXCD9/kMQmm8UVBMjXERwGgaeSQpHAzN8Y0E+ECBLIB6JRQKWl9Y1EMQDUvc7W1m0e9U1FfcMs9c7X/d2M7/XqDU21yMNCwsJCvcQMey1qM0JSrPNzad85DM2ppYoiUc1opwdmnM5grFvVrLjJTdl7z06dRL+kw1+ttH8zKyXC4zd2R1+hInN8AweWF/g4fhbN+mEpeyj1LL1fI6Ibkti/lL6mZWf4mfHsXaN50jw7AwRZ835WR124NUOm6YDq6bOzkr5cw9psZYchpYCAMtffwYtmwQdACxbQFcyDSErITbGRJ/B0ES+92mU8mqOfsN3s3HHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 8 Sep
 2025 05:25:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 05:25:02 +0000
Date: Mon, 8 Sep 2025 13:24:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [peterz-queue:sched/hrtick] [entry,hrtimer,x86] ebf33ab570:
 BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]
Message-ID: <202509081329.81f1ed82-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ec2b62-fc17-454f-20c5-08ddee980fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZ7rb3KZhbKMprrqNJtIQLRiAHjEWmdAhLQ40G4SQ/2BF9Cv/OMP3JwQlmgP?=
 =?us-ascii?Q?mnbLkU8g95gnmVhYQjmm4J5lkm5jDy7yvKvpwTrYdvEujBzDL1F0/+UZkqzb?=
 =?us-ascii?Q?sVmifYqYSdW6aT37NY69U2ptG9TbmXtNgLXgyY7KaHewbQBprm/aCXU81aZF?=
 =?us-ascii?Q?LbVyxaB4+GjwcazVhGk975Irdzh43V4TyyZyF+tRrkrF5ghrhz+q7sHlvy0f?=
 =?us-ascii?Q?Nkqduc5JG1xZ0UqtsjYucGCdOZVpS0mk7oiseFnlzjnedpqVjPWV0t7ofRrm?=
 =?us-ascii?Q?3CGZA5T/ztuA5lfwsdNQ7GYT0LkEI3x8bc4hoM62xi/ybVC6sFkwHlnsYifB?=
 =?us-ascii?Q?fMsaHjvcXgZkj7hoMWn81pkJ4S3zbYXUea7TN/uIg+ll5gKhdVQhSwyyZpEM?=
 =?us-ascii?Q?wdla6hXRnm8s1udbW2G97FjOD5Bs649/10mX0UTeivljeUcYmRFiGXDhtjrx?=
 =?us-ascii?Q?gjm5JRe9gRkp0DAJrhoDMelICKlXZlffV/skExfwpW/6uI2OxYCVnxRZAEx5?=
 =?us-ascii?Q?kGYeCYIDvLTK/LcXSZEjjXr4KjYk+hs/nxZVxjM1S8g280NDKF22QI3wlA0f?=
 =?us-ascii?Q?TwbWNgCSMGnM1591xZG64WiqaQPpoxwQMj4fPS/j+oLgKq0krg7wSE+Y+9Ld?=
 =?us-ascii?Q?Gzuty3RQphZX6frbF3fOma+JNwlWvxtTPvtiaIQHaFV9PaRA02SBLHtqahWE?=
 =?us-ascii?Q?YdItDWvFXvnA0DXYY8nrVomGD7hhsmmN2r0IbD8IfJy5nzWe3NnK56IpjchJ?=
 =?us-ascii?Q?6oTwKbi9mxe063MGJ3NWHl0VEbxivKYIYJT+BFTM2QpYkCDHdSZFS8cjOyZ3?=
 =?us-ascii?Q?FqnG8rUL9fRMwEWegXF85FMiSHijwcrHLlpVCm9ryA7dwIUuDlNWQAUewCZg?=
 =?us-ascii?Q?zgKziMIUEsGO5i67sEtbr4x+jWNte3uM623VWHh2f3NlTidQza9G5YhPzdYQ?=
 =?us-ascii?Q?nmOyfB9la75tNDAlUEx0EC/woPeMS5xmSbWbdyTj2uwyQMIt8KnJ38sMv76J?=
 =?us-ascii?Q?jsDznubm78weLkgAQxaq7RhzvjagavvtTCdUj15D/vmR+KHtjesJAhxqBCo/?=
 =?us-ascii?Q?Zrw4pclZStbNhw66OtcTfYbI6drWqtQgYIyhTdmPFDxA8DOc7/CuyZU0D9nC?=
 =?us-ascii?Q?+jlTXlkNFtN58aq9ENy67vSpsixpGHtEoL8d631AoRuje/9UasbCgNSZIxip?=
 =?us-ascii?Q?I0MYrl6CBXnmvtK4sDmLxPvzmPKp3dOrFAyUx9xotsykAKUU4RKrfTHNPBel?=
 =?us-ascii?Q?1ejjSJ29Thmjk7I8Swzyt0tTBl2i2BhJYSdvNu/LcUqR3LeEEQBod+4G3yvs?=
 =?us-ascii?Q?lHmEYopAJSOigkzW9RoYEhfm04+2qYLoVIviz6FIvpGFMRswj+2KgTpYxYz6?=
 =?us-ascii?Q?9I+ln3M96uMo8ucOphYuzgkCaJlr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/OdIcUJOv5kjUTijBoJTX3UHS9C4c8Rmejs71iavrN+QBZZ2OTWO/7tYuNSm?=
 =?us-ascii?Q?gB2t99EEDlm772TinszwG2TwTnHVcrys6Q/zdAvHcl1+pyEBs9Bxnn111+fI?=
 =?us-ascii?Q?vk9D49H6+FHsq3MWu+uxvYtXVUSj2YaaeoNJphZzy4FM8vrZKikxROiztuiP?=
 =?us-ascii?Q?7JKk88dn0PDyig/t3wWH2rY/YCWakHEk+MUPodEPOgVbECcRVIqS+tDzDXr6?=
 =?us-ascii?Q?KwoFj5jyFopV+gW414wMuKPWyNGf9vMl9OaY7l0w0DA0ihBu0YcBDmagrsAm?=
 =?us-ascii?Q?7EDV4GcLmi0nKhXhCed/gS1osUjcxQElaGRKHuNlHN+koy3iGD7TgSb6LYzS?=
 =?us-ascii?Q?W2uMvL3ruLI3PbRl0ZY5VXiDcybMHuYK6wapwFNv38Re1qP12EzcFoeAwrqM?=
 =?us-ascii?Q?uCfN+LQJpzqpz3uM8XmgFwoeG7CBCYLB/OSpDN1xBog8EFWEF/E5FOFvDdbV?=
 =?us-ascii?Q?GE2dspp+QrDEovYm5N/7If/w3ITXRHUkO7OK8DLtxN0ZddiE3Kq4T7gzoH70?=
 =?us-ascii?Q?CFlar/nj0wXIDkgOWcDLrZ5gnOoEN5F2hfr41ni02EYnQrDk6YVjfhVB6WQ4?=
 =?us-ascii?Q?OZul+bQTtyPCT1T2BKGJqa0PVG/hCJRDsaLuEH1DGp/DvyTuZvPH+T8fbS+S?=
 =?us-ascii?Q?lm8SF4Iu7KC63fa1kwSdAY2Vi7r+0+fYDaKpczxYwwXn05mEnc4dOZY+Z8EN?=
 =?us-ascii?Q?e9Mxi0IIzPaWxmEX8ptThnlkEzQdG6X2ncegG3RGdaXq5hclDmJ9GxCftEL+?=
 =?us-ascii?Q?foh8GOj7EFgeea9ajQrLja1g6jJ+DgFEeCm4VksfAxUbx9cxm27giRJkB6Cm?=
 =?us-ascii?Q?gsLQrujmj2rocCE6AMC3I1q1a5CANSHE5xetAGD6ABw73MH2MjkY5FVZfx5O?=
 =?us-ascii?Q?gMhfaI4AoMujEz2IXIa0Te9w6foVzxJWyIfUiI1bAqeyN6VRcYJTsDkeNJYK?=
 =?us-ascii?Q?1Au2n3wkHIxyGn2IJWC8YYnNKtt6YPJ5PMa/QFjJ7sAM5mltKsKep8lBkOwh?=
 =?us-ascii?Q?8yNekq9kM0Ypd6Rr9LVSPwiC5pdTwunWZUxZCR7PuWtVnftLR9WRCVLvrqBK?=
 =?us-ascii?Q?DPhw6PY0CH+7qdp9Rj/W5J1UMq+OTH/YC7IpqUJmwReNBdxxdNkukuT+3rEx?=
 =?us-ascii?Q?VJBiSpS7XAAioguzVjkBuORIteeEcoIaQojLUoX4nw7or6zKDGMuM6GIFszx?=
 =?us-ascii?Q?8UtgMQqlfxx5/wvpI/XXdmSc/OJLw6xSLbmfj8PZOzmM99Tl/VSsnC1I4i7Y?=
 =?us-ascii?Q?H0Z9ha1XgwoKIma6DU5Mx+V3UD8J/u5BJFyNgulzghmjrhnv/zOPj+nrnYvs?=
 =?us-ascii?Q?nFb0/5ql3lq4uzPBlSBAQwgEvuHx3cxCq/jq+g03kb/In6MzckGGxlELYxAA?=
 =?us-ascii?Q?KZxgx1P0XemM42a26ipOPC36Sgq5km1iQ25mCS0ctQwVi4Blrqxu90TJRdBq?=
 =?us-ascii?Q?VJ42jb3uMJQlJp9q/7qtrAKVncGI9vj0bYpBB25DVPzP3lZncN4qjruD4vdG?=
 =?us-ascii?Q?cwJMKlZP1yLlxp2ukV7ox8T+1c6OWDs+jBsZY2cerauk9c/9Bm87tOqEWiPi?=
 =?us-ascii?Q?8lHudhYreh0PW5MYXAAtj0KB/tyJDi3Bm1KkOUml83Z/x/g98UqrPinkX2ZF?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ec2b62-fc17-454f-20c5-08ddee980fbe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:25:02.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpNdtjgVMpD0TgrAWawtIJwti0fqZRo8AckaLtkZH+SmS9bMDa8E9bXptKspepMqnByiso0DzGPaJca++VhuTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:soft_lockup-CPU##stuck_for#s![pthread_mutex1_:#]" on:

commit: ebf33ab5707c7c9ea25e3c03540b1329ad9aff1d ("entry,hrtimer,x86: Push reprogramming timers into the interrupt return path")
https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git sched/hrtick

in testcase: will-it-scale
version: will-it-scale-x86_64-75f66e4-1_20250906
with following parameters:

	nr_task: 100%
	mode: thread
	test: pthread_mutex1
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-13
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509081329.81f1ed82-lkp@intel.com


[  138.658008][   C24] watchdog: BUG: soft lockup - CPU#24 stuck for 23s! [pthread_mutex1_:6650]
[  138.658013][   C24] Modules linked in: ipmi_ssif intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common i10nm_edac skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel sd_mod sg binfmt_misc btrfs kvm blake2b_generic irqbypass snd_pcm xor ghash_clmulni_intel dax_hmem rapl raid6_pq snd_timer cxl_acpi ahci intel_cstate ast cxl_port snd drm_client_lib libahci nvme drm_shmem_helper cxl_core intel_th_gth soundcore mei_me isst_if_mmio isst_if_mbox_pci acpi_power_meter ioatdma i2c_i801 libata intel_uncore nvme_core intel_th_pci megaraid_sas einj pcspkr drm_kms_helper mei ipmi_si isst_if_common i2c_smbus acpi_ipmi intel_pch_thermal intel_vsec intel_th dca wmi ipmi_devintf ipmi_msghandler joydev drm fuse nfnetlink
[  138.658060][   C24] CPU: 24 UID: 0 PID: 6650 Comm: pthread_mutex1_ Not tainted 6.17.0-rc4-00007-gebf33ab5707c #1 VOLUNTARY
[  138.658063][   C24] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
[ 138.658065][ C24] RIP: 0010:native_queued_spin_lock_slowpath (kernel/locking/qspinlock.c:291 (discriminator 3)) 
[ 138.658077][ C24] Code: c1 e9 12 83 e0 03 83 e9 01 48 c1 e0 05 48 63 c9 48 05 80 20 e5 83 48 03 04 cd 20 3e bc 82 48 89 10 8b 42 08 85 c0 75 09 f3 90 <8b> 42 08 85 c0 74 f7 48 8b 0a 48 85 c9 74 81 0f 0d 09 e9 79 ff ff
All code
========
   0:	c1 e9 12             	shr    $0x12,%ecx
   3:	83 e0 03             	and    $0x3,%eax
   6:	83 e9 01             	sub    $0x1,%ecx
   9:	48 c1 e0 05          	shl    $0x5,%rax
   d:	48 63 c9             	movslq %ecx,%rcx
  10:	48 05 80 20 e5 83    	add    $0xffffffff83e52080,%rax
  16:	48 03 04 cd 20 3e bc 	add    -0x7d43c1e0(,%rcx,8),%rax
  1d:	82 
  1e:	48 89 10             	mov    %rdx,(%rax)
  21:	8b 42 08             	mov    0x8(%rdx),%eax
  24:	85 c0                	test   %eax,%eax
  26:	75 09                	jne    0x31
  28:	f3 90                	pause
  2a:*	8b 42 08             	mov    0x8(%rdx),%eax		<-- trapping instruction
  2d:	85 c0                	test   %eax,%eax
  2f:	74 f7                	je     0x28
  31:	48 8b 0a             	mov    (%rdx),%rcx
  34:	48 85 c9             	test   %rcx,%rcx
  37:	74 81                	je     0xffffffffffffffba
  39:	0f 0d 09             	prefetchw (%rcx)
  3c:	e9                   	.byte 0xe9
  3d:	79 ff                	jns    0x3e
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	8b 42 08             	mov    0x8(%rdx),%eax
   3:	85 c0                	test   %eax,%eax
   5:	74 f7                	je     0xfffffffffffffffe
   7:	48 8b 0a             	mov    (%rdx),%rcx
   a:	48 85 c9             	test   %rcx,%rcx
   d:	74 81                	je     0xffffffffffffff90
   f:	0f 0d 09             	prefetchw (%rcx)
  12:	e9                   	.byte 0xe9
  13:	79 ff                	jns    0x14
  15:	ff                   	.byte 0xff
[  138.658079][   C24] RSP: 0018:ffa0000028f0fbe0 EFLAGS: 00000246
[  138.658082][   C24] RAX: 0000000000000000 RBX: ff110002532e1204 RCX: 000000000000001b
[  138.658083][   C24] RDX: ff11003fba032080 RSI: 0000000000700001 RDI: ff110002532e1204
[  138.658085][   C24] RBP: ff11003fba032080 R08: 0000000000001200 R09: 00000000aba99bcc
[  138.658086][   C24] R10: 0000000055565000 R11: 0000000001e15159 R12: 0000000000640000
[  138.658088][   C24] R13: 0000000000640000 R14: ff11004075be6000 R15: 0000000000000000
[  138.658089][   C24] FS:  00007fff967fc6c0(0000) GS:ff110040361e0000(0000) knlGS:0000000000000000
[  138.658091][   C24] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  138.658093][   C24] CR2: 0000000000479ea0 CR3: 00000040483ec005 CR4: 0000000000773ef0
[  138.658094][   C24] PKRU: 55555554
[  138.658095][   C24] Call Trace:
[  138.658098][   C24]  <TASK>
[ 138.658101][ C24] _raw_spin_lock (arch/x86/include/asm/paravirt.h:557 arch/x86/include/asm/qspinlock.h:51 include/asm-generic/qspinlock.h:114 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 138.658104][ C24] futex_wait_setup (include/linux/uaccess.h:244 (discriminator 1) include/linux/uaccess.h:261 (discriminator 1) kernel/futex/futex.h:336 (discriminator 1) kernel/futex/waitwake.c:627 (discriminator 1)) 
[ 138.658111][ C24] __futex_wait (kernel/futex/waitwake.c:683) 
[ 138.658114][ C24] ? __pfx_futex_wake_mark (kernel/futex/waitwake.c:135) 
[ 138.658117][ C24] futex_wait (kernel/futex/waitwake.c:715) 
[ 138.658119][ C24] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658127][ C24] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658130][ C24] do_futex (kernel/futex/syscalls.c:102 (discriminator 1)) 
[ 138.658132][ C24] __x64_sys_futex (kernel/futex/syscalls.c:179 kernel/futex/syscalls.c:160 kernel/futex/syscalls.c:160) 
[ 138.658134][ C24] ? futex_wake (kernel/futex/waitwake.c:163) 
[ 138.658138][ C24] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658141][ C24] ? do_futex (kernel/futex/syscalls.c:107 (discriminator 1)) 
[ 138.658142][ C24] ? __x64_sys_futex (kernel/futex/syscalls.c:179 kernel/futex/syscalls.c:160 kernel/futex/syscalls.c:160) 
[ 138.658144][ C24] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658146][ C24] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658149][ C24] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 138.658151][ C24] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548) 
[ 138.658158][ C24] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548) 
[ 138.658160][ C24] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  138.658162][   C24] RIP: 0033:0x7ffff7de9eab
[ 138.658165][ C24] Code: 07 41 89 f0 83 f8 02 74 0b b8 02 00 00 00 87 07 85 c0 74 3b 44 89 c6 45 31 d2 ba 02 00 00 00 b8 ca 00 00 00 40 80 f6 80 0f 05 <48> 3d 00 f0 ff ff 76 d7 83 f8 f5 74 d2 83 f8 fc 74 cd 50 48 8d 3d
All code
========
   0:	07                   	(bad)
   1:	41 89 f0             	mov    %esi,%r8d
   4:	83 f8 02             	cmp    $0x2,%eax
   7:	74 0b                	je     0x14
   9:	b8 02 00 00 00       	mov    $0x2,%eax
   e:	87 07                	xchg   %eax,(%rdi)
  10:	85 c0                	test   %eax,%eax
  12:	74 3b                	je     0x4f
  14:	44 89 c6             	mov    %r8d,%esi
  17:	45 31 d2             	xor    %r10d,%r10d
  1a:	ba 02 00 00 00       	mov    $0x2,%edx
  1f:	b8 ca 00 00 00       	mov    $0xca,%eax
  24:	40 80 f6 80          	xor    $0x80,%sil
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	76 d7                	jbe    0x9
  32:	83 f8 f5             	cmp    $0xfffffff5,%eax
  35:	74 d2                	je     0x9
  37:	83 f8 fc             	cmp    $0xfffffffc,%eax
  3a:	74 cd                	je     0x9
  3c:	50                   	push   %rax
  3d:	48                   	rex.W
  3e:	8d                   	.byte 0x8d
  3f:	3d                   	.byte 0x3d

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	76 d7                	jbe    0xffffffffffffffdf
   8:	83 f8 f5             	cmp    $0xfffffff5,%eax
   b:	74 d2                	je     0xffffffffffffffdf
   d:	83 f8 fc             	cmp    $0xfffffffc,%eax
  10:	74 cd                	je     0xffffffffffffffdf
  12:	50                   	push   %rax
  13:	48                   	rex.W
  14:	8d                   	.byte 0x8d
  15:	3d                   	.byte 0x3d


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250908/202509081329.81f1ed82-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


