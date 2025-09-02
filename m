Return-Path: <linux-kernel+bounces-795889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D661B3F900
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E1487A1E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CDDDD2;
	Tue,  2 Sep 2025 08:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Knx9SByL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF932D5948;
	Tue,  2 Sep 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802733; cv=fail; b=b3fQZ/cFD4nA9Lig3j/ZfZcHzAWSyrP0sO6XO5AAeEPBHe/ly3x8FXEyB+uhw7ss8EbqI5Mix4lnmpaTsKXVFuTsjw7fyqbJBdN2FKr772NavYJHKnyT1j71wCgfRGOXq5pNpKwMm2F+FIENJZp34evWnvWlSK92+OSo3rVsfS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802733; c=relaxed/simple;
	bh=+WB2cvcBIuGE7YAkY3QfIodn3jlvtYzR1DE728/ZU+Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ta8xYM74/Ypuu2oO7eeYPi5VmCfHYnHnqGCpIpiq8qlSCtGIJZvshMQkxfkNgaNXlc06H5WrZ5MNXLdacFxvmOIc3bRlRMwNGZk8s71gHFJHdasw1vl7UgmUmsN0TIp7PwNV4eoUgCgBcH2cT20JqvkcVgf59y531znawlVD0pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Knx9SByL; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756802731; x=1788338731;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=+WB2cvcBIuGE7YAkY3QfIodn3jlvtYzR1DE728/ZU+Q=;
  b=Knx9SByLcajwU0ZT4TbKmZ78Cm0R53FSxPxogD+cT8xlAscZdeLqj/sn
   xkFYV3Jw/ILxu3deYKUUFi7xtGmPl7ZdHnykm2+VKcKN6ak9Pt/0SvSgh
   KCK5LMEB3P1aDCC9px0AhfSa+aaCTwgF7r/Hg4FYyKgQVFHmHw3EdTZoI
   ejREf2dLfN4LaZZlD0fL8ODhTklbYXKvx3qnuuxH77JR96JzPjlPGVbw7
   8QLa6dUda12iF5g+20gjIjpX2zJnJ4C6OGaW5Pgc7sTfcrI8ZJZOQhq+S
   uZDJnMh5pYns8zFyASCZPeGQ9tE+kxEMwy4QiUIaexOUE7B9RnZBM49t+
   g==;
X-CSE-ConnectionGUID: SeItThLKT06jD1W6hR45ew==
X-CSE-MsgGUID: Kq8lRsHQRPOdcLuj8p4U2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="70444549"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="70444549"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:45:30 -0700
X-CSE-ConnectionGUID: XaS1Tqs+Qae8ml23Fje5bA==
X-CSE-MsgGUID: sPBCIUPAR3WrkUsa6LB1GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="171661347"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 01:45:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:45:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 01:45:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.72) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 01:45:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPyiJMPuYRl8siXmAw40v9cCUj1hjRuwtDEGF6Tx3//Xvzdo4/GJz3UbMXW0wqPMqJbPChYofZ97ybc3K9tuN6fdLr0j7Pb1yzgelaiqYVzSsyhlYSeXIBG6zKir758j/j4QNEvhlRwTcyH7xr8bI9EHvGlup1eY+hKihFaZ9oCCiSshIj0OvHoiFaYQxusGwlmu3LZODc7DfmY189laS4KHkY6m3MoMvBdO75LWswC8w858FDdzWIeRDyErOxlPn48on42cwvn48ZOU+BCgjuHalBvG7S1j7JxoW8j7N08iglY4JSRWBb9s2ulzBcx5SFdwrJyf9SmyBRvHp2GOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkQIxa5o4JNsGc6cHqtoRlSvtEZFRSUy/Wo78vjmW50=;
 b=dqmSFwlqszeMWriA6/LGIOzRaGGOScY18QT+9bZrnj49vAlPklDHwLFrLw2k2DJUk50mLyNU7cDJttAG5FtP6dOHOibbtEzvu4/y0zb6MntjCanmfOk3H9qZoiUkmoVnRIc3UtbTYIoR0PHVPmzaoXdtsGj/aRi5OzQtX5qMIoTcesfHK1fqiE4W8pxQsTzo47H3P3BsUHxo7zIy9uZe02UIRNaZUWrMQi3qDYW0R3ULxDmkp2JWJ6GHv0ADPs6G5sCKY7hAbFjxVX5yaXPp6sVGgYzOcSydkl4a0Ue7R2WBml31pHi9qZtY0iC0mmenRCe0IWDvmXftAZ9QtqvuAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:45:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 08:45:22 +0000
Date: Tue, 2 Sep 2025 16:45:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Borislav Petkov <bp@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Chang S. Bae"
	<chang.seok.bae@intel.com>, Sohil Mehta <sohil.mehta@intel.com>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing
Message-ID: <202509021646.bc78d9ef-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820135043.19048-2-bp@kernel.org>
X-ClientProxiedBy: SG2PR01CA0189.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ad28d7-3310-4a24-794c-08dde9fd0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R9BxNb1TDiTzgqvXwG4tvjWO3fyXtjF+W8VhaCISMfuQWTpI1rmwcwvzI3QG?=
 =?us-ascii?Q?P2+U6bmBHaPLiGy3xqNx7g/p/PDm+oprPiUTFE6mfRJayHLv3q22gXBpcpHz?=
 =?us-ascii?Q?ZGDNm46GbEYP6TN4+YOBSjG24ME27bGJtc8wvRLeeblAfWkj6Rb0iAfIm3U9?=
 =?us-ascii?Q?htfz6Jw8lJ0olja3xwKU9mj345uiLRksr3T699fM6AKBSzlkrMaV3DNyvUG/?=
 =?us-ascii?Q?b46AsncgmGiiFytYtHkWuctvtZCNZRQK6Rr0bawVH/ySbsNs+5IoE1wNQ/0C?=
 =?us-ascii?Q?OygUDCeg6JmpZdpwLiVcavd9tFZCzBj3rRCXxlfInJVfJ98C8iiLqNUiBdEM?=
 =?us-ascii?Q?UIft0jzMHTa8W7Laix12Imgr4GZcecQhGjjlWOYHtoQL/K2z+4XPkZjfrl9d?=
 =?us-ascii?Q?eXp8KeGxTlqB03urcaAMCVo3NNbcazop2qOJtvM8a1oTGHIE/TDlh74Y2+Ud?=
 =?us-ascii?Q?sC8pFlCsPKk2D4nBVeklz9Oa/ntZJ647t7Sdy9VAOU6tAxOhKWFLqF9eq5L1?=
 =?us-ascii?Q?RNFmJZFnq0kIUHesjjM+VcgSCVKTw4bCpxDRcR7T38DKyKk12zq6u96tLSuD?=
 =?us-ascii?Q?a2bUWc0LlY7MAYCNexzj0Jp97wprjVK8xCO5lcFM9vgAQGdikjaiEqK7DW5N?=
 =?us-ascii?Q?xRaOUxGjRYR4lE51wFmGp63PcvK3fscjZMBoS+riTl4GRuqNXlRa4g6N56Wu?=
 =?us-ascii?Q?42TUN9pxQJ5u34DLBX5GGcxvTCkTIMH58hzEcG42kHE4QQH8Rixb6aAPzkHH?=
 =?us-ascii?Q?fMZI+2nzZ0bxcAxaLlckZjIBAEq7GZcpV1MH219i6R9V0hIz2K0Y68x+doUw?=
 =?us-ascii?Q?btnp/CiDHlBu8H4DdgkoggCYeATVXQrHlBdwzBpz/rjNbfAJDg3MJkq09NhT?=
 =?us-ascii?Q?9zzcHjpVhCmclUEdYvbcU+78mRoYpfMJk+HSDJ07v46QM3zLvaNaPnUSkglJ?=
 =?us-ascii?Q?vQdBeSaboSfzzvorEjHmTGdt+44Jocr4MznIKMZFU+/LZO0+hlS9qhzJQkvD?=
 =?us-ascii?Q?YJGEu03uhLo45EX5nsHZjfQMzuL1y8Lt8FCLGJ3Ce80qMnYH0KEFjhFujIcZ?=
 =?us-ascii?Q?r1GiXVqJmabeeebexi2HjIuvxBvW1jKzfx5vxk/EVejoE543mOWR3I8B0aJf?=
 =?us-ascii?Q?nNwWPVow6gOyq8zK91lSBndPtdYYGo8/K+gfPk9JqVb/aigqXEOe4Ki4Keu3?=
 =?us-ascii?Q?imDL9sK/hdIp7JyWZl9LabeXh8o7N5Z/tPqt//cL+TDlczoNzLWthf/RLHNJ?=
 =?us-ascii?Q?W31LqOaKWf4NmT/EKIm9J9QFnqMmYkJDaXY03PZ2Yx7W+m2lOyTzkqbui8gu?=
 =?us-ascii?Q?D+ltJRFqICiz6DkBKLCT9w+gYCuO/JPUSq22LdZtIFG2Sg3iL13vYnLkCUDy?=
 =?us-ascii?Q?YVajwB0LQzMcEdEV3zbsb1rWb0Vc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBDo9Lk/Gay4QJPrYlhta3UkFoSAGqyA25JQg5xX6Fu08OEbBKtEqRVIpcBd?=
 =?us-ascii?Q?dnV8PbFz6q6i2weZG1A6wibjrmkrgXUN1lntptbqsTJF5Ll/79hOwv0aiFQ3?=
 =?us-ascii?Q?broayOngHLlEBhSkyn+cuV32ZUBQNXQX9wEAnr54dgT+BAPL9N6zmDR9RyWV?=
 =?us-ascii?Q?JODYasPjCP3W7e3kYr9oBCz96PiML00ylHskLRVC5RrAq6CrBraOjFbO31Zy?=
 =?us-ascii?Q?uCRxuhwK2EagiKBTjpkw1B3Y99d/y9QxVc99CsqJiiPs1EFdqXaFnL5TgmiH?=
 =?us-ascii?Q?sP7ODQ3sdPakAUNTiCKCcgH4MNM/YE1GsA52YdRgZ6VPgT6M3u42FafJUaWQ?=
 =?us-ascii?Q?gAed0A2ZiiazakxvoUMItpPNEHRBysK7Qwkc90yjYISq3vrMCwZ5NDO1kzh6?=
 =?us-ascii?Q?MH7csBs7TUZ/2YxC1Q/oCkCSiCL2bciPR+sLbXbVDZbwBN5eYl59Bq30Y4P3?=
 =?us-ascii?Q?+bN+KDUZZRZ52w2tZAVKdUqJsr1OzHxqhQ+gPts8RlV9S8P8iTVr7akQDlvT?=
 =?us-ascii?Q?OwF0VECWqAxusAloagbgsgIGg4gfY6vTSvZS6cKz8jUd9PAqljAKQMZES+Q0?=
 =?us-ascii?Q?UvbchMiQsTSqf+lIaZfuTrWvT8etf6Dl5ZhpDNKynYENptymOV3wYjRMtF6j?=
 =?us-ascii?Q?WKkJqyHjFv8UOqABd00XBMrfOnjuH/Z1Qni5UEyegeg8Hv/xaBgn/lUPUdzI?=
 =?us-ascii?Q?MXfjbjjrgTQGi5YKsVUHlpSo6sJ5pVk1lAwFuOJdJ5TLFFBcL5xsEASXd3Xc?=
 =?us-ascii?Q?zV2kbFcs/HcxawQ6Xjj3aA5jrIGbm5tOZdNedjTRjpL+QAgmvYJECVGnFjT+?=
 =?us-ascii?Q?RXtmBkLzPbJUgYiwbYmFmXd1U5obWgWqYLqBR/BRzY4ISNvKNdDG977LCav6?=
 =?us-ascii?Q?7CO8L+qrkYVVzkPbFFhRL8wdLuBgdGUeVx9DWXqTqve9El1BJ4S75UD6TAGD?=
 =?us-ascii?Q?OqfnibN7aQDxKwjJ/s0YqODLi4iM6DJIvXIDnrAowZT9CbhR9SECfHcAc2/u?=
 =?us-ascii?Q?qW0stlntTDWUq6IjDiqRAlWZH20YJ3CqRmT6FVlR7c/s3Urcf0CS3Bl+O3Z3?=
 =?us-ascii?Q?1Bu2ICu2r8XkJbqa/A/E70yV4+nEgXdWCCz5EtlIESNf/lDaxDBKPi+1sJzk?=
 =?us-ascii?Q?xrT6j7Sk6axldTX6+bPsaWrljuhrMeoOg0LGHKXxobYBxlecM+ejv8cf1319?=
 =?us-ascii?Q?c+ATqgrb/zhZRe12wbLXdkgxnByaJbNV6O9BsyCWkG5xVRmoplJZuDueI6rc?=
 =?us-ascii?Q?T9JBJ8JwsFK3sXKiabQP1eico0xKe1GqTlEXL/5zwMdAigWSub95sKPVGZwk?=
 =?us-ascii?Q?I1K2n8e7ysimsJfiAacybMBpVCV/AZuUjCtlgEAf7SQ+uRucpZIWlIDrRnmJ?=
 =?us-ascii?Q?wJxE2nHHvfZ4PZW6Euy3vcO4Q3OfsbJkIGaXlP0NMIeqq0XFQGaATveG4VRD?=
 =?us-ascii?Q?iq8QSniMXLAU6Tfo2Qg9qzIXF+f/ojaIvtMK0mp9I1fkVZ4gdDBAFPL/ShJw?=
 =?us-ascii?Q?0aKoQ/gQ4P2s5S7CtPn9KWD1TA0R/jF4n04BQ0RsEnfgBPxSQRhTz2dUgAKI?=
 =?us-ascii?Q?S8LXQGLecRGcPMlzIUg6Lnt109YwSFwa8V/Ze1cGf+wMsnUxc7tbtGdm6MXl?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ad28d7-3310-4a24-794c-08dde9fd0d8b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:45:22.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y82zA0Js3+2Lbn27/8llyuNzUlm05Dkhn0iThxtU6aLLiNr9PCayk3JdI/+QbOqqrspI3e6ZYfZmpxctp+sfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com



Hello,


this could be a noise, we didn't see the relation between the patch with the
issue we observed. however, we rebuild the kernels for both this commit and
parent 3 times.
(
our bot chose 894af4a1cde61c as the parent as below
* 19f370d45aceea x86/microcode: Add microcode= cmdline parsing
* 894af4a1cde61c (tip/x86/core, peterz-queue/x86/core) objtool: Validate kCFI calls
)

and for each rerun of both this commit and parent, we run more times, but the
issue is still quite persistent while parent keeps clean:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/group/nr_groups:
  vm-snb/trinity/debian-11.1-i386-20220923.cgz/x86_64-randconfig-006-20250826/clang-20/300s/group-01/5

894af4a1cde61c34 19f370d45aceea5ab4c52e3afa0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200         74%         149:200   last_state.is_incomplete_run
           :200         74%         147:200   last_state.running
           :200         75%         150:200   dmesg.CFI_failure_at_kobj_attr_show
           :200         75%         150:200   dmesg.Kernel_panic-not_syncing:Fatal_exception
           :200         75%         150:200   dmesg.Oops:invalid_opcode:#[##]KASAN
           :200         75%         150:200   dmesg.RIP:kobj_attr_show
           :200         75%         150:200   dmesg.boot_failures

so we just follow our report rule to still report this results FYI.

if it's really irrelevant, sorry maybe our env issues (though we still cannot
figure out for now). and if you can help us to figure out the potential problem
from our dmesg in below link, it will be very apprecidated!

below is full report.


kernel test robot noticed "CFI_failure_at_kobj_attr_show" on:

commit: 19f370d45aceea5ab4c52e3afa00226fb99c3fc8 ("[PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing")
url: https://github.com/intel-lab-lkp/linux/commits/Borislav-Petkov/x86-microcode-Add-microcode-cmdline-parsing/20250820-215624
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 894af4a1cde61c3401f237184fb770f72ff12df8
patch link: https://lore.kernel.org/all/20250820135043.19048-2-bp@kernel.org/
patch subject: [PATCH -v1 1/2] x86/microcode: Add microcode= cmdline parsing

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: x86_64-randconfig-006-20250826
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509021646.bc78d9ef-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250902/202509021646.bc78d9ef-lkp@intel.com


[  453.382281][ T7761] CFI failure at kobj_attr_show+0x59/0x80 (target: nilfs_feature_revision_show+0x0/0x30; expected type: 0x1b8aae92)
[  453.386793][ T7761] Oops: invalid opcode: 0000 [#1] KASAN
[  453.388638][ T7761] CPU: 0 UID: 65534 PID: 7761 Comm: trinity-c2 Not tainted 6.17.0-rc2-00017-g19f370d45ace #1 NONE 
[  453.391831][ T7761] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  453.395231][ T7761] RIP: 0010:kobj_attr_show+0x59/0x80
[  453.397175][ T7761] Code: 08 00 74 08 4c 89 e7 e8 75 90 d2 fb 4d 8b 1c 24 4d 85 db 74 1f 4c 89 ff 4c 89 f6 48 89 da 41 ba 6e 51 75 e4 45 03 53 f1 74 02 <0f> 0b 2e e8 ef d7 08 00 eb 07 48 c7 c0 fb ff ff ff 5b 41 5c 41 5e
[  453.403170][ T7761] RSP: 0018:ffffc90002b57a48 EFLAGS: 00010287
[  453.405399][ T7761] RAX: 1ffffffff11d2fe9 RBX: ffff8881255ce000 RCX: dffffc0000000000
[  453.408012][ T7761] RDX: ffff8881255ce000 RSI: ffffffff88e97f20 RDI: ffff888106a5e250
[  453.410593][ T7761] RBP: ffffc90002b57a68 R08: ffff8881255cefff R09: 0000000000000000
[  453.413717][ T7761] R10: 0000000082bfb03f R11: ffffffff82621360 R12: ffffffff88e97f48
[  453.416820][ T7761] R13: 1ffff110295a3e80 R14: ffffffff88e97f20 R15: ffff888106a5e250
[  453.419944][ T7761] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7ed7280
[  453.422938][ T7761] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  453.425060][ T7761] CR2: 00000000f7795414 CR3: 000000015b1cc000 CR4: 00000000000406b0
[  453.427781][ T7761] Call Trace:
[  453.429070][ T7761]  <TASK>
[  453.430222][ T7761]  sysfs_kf_seq_show+0x2a9/0x390
[  453.431885][ T7761]  ? __cfi_kobj_attr_show+0x10/0x10
[  453.433693][ T7761]  kernfs_seq_show+0x107/0x15b
[  453.435360][ T7761]  seq_read_iter+0x55d/0xdeb
[  453.436971][ T7761]  ? kernfs_fop_read_iter+0x14c/0x4a0
[  453.438770][ T7761]  kernfs_fop_read_iter+0x14c/0x4a0
[  453.440385][ T7761]  ? __import_iovec+0x31b/0x3db
[  453.441900][ T7761]  do_iter_readv_writev+0x3de/0x590
[  453.443609][ T7761]  vfs_readv+0x15d/0x3f5
[  453.445305][ T7761]  ? trace_sys_enter+0x54/0xe5
[  453.447044][ T7761]  do_readv+0xde/0x190
[  453.448551][ T7761]  __ia32_sys_readv+0x80/0x90
[  453.450192][ T7761]  ia32_sys_call+0x2dbd/0x2efb
[  453.451877][ T7761]  __do_fast_syscall_32+0xaa/0x2a5
[  453.453640][ T7761]  do_fast_syscall_32+0x36/0x8b
[  453.455342][ T7761]  do_SYSENTER_32+0x1f/0x3b
[  453.456962][ T7761]  entry_SYSENTER_compat_after_hwframe+0x78/0x82
[  453.459058][ T7761] RIP: 0023:0xf7ede539
[  453.460559][ T7761] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[  453.466394][ T7761] RSP: 002b:00000000ffa4237c EFLAGS: 00000292 ORIG_RAX: 0000000000000091
[  453.469176][ T7761] RAX: ffffffffffffffda RBX: 00000000000000f5 RCX: 00000000571a6370
[  453.471897][ T7761] RDX: 00000000000000af RSI: 0000000000000013 RDI: 0000000000000002
[  453.474598][ T7761] RBP: 00000000201a2903 R08: 0000000000000000 R09: 0000000000000000
[  453.477296][ T7761] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  453.479969][ T7761] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[  453.482612][ T7761]  </TASK>
[  453.483846][ T7761] Modules linked in:
[  453.485501][ T7761] ---[ end trace 0000000000000000 ]---
[  453.487396][ T7761] RIP: 0010:kobj_attr_show+0x59/0x80
[  453.489298][ T7761] Code: 08 00 74 08 4c 89 e7 e8 75 90 d2 fb 4d 8b 1c 24 4d 85 db 74 1f 4c 89 ff 4c 89 f6 48 89 da 41 ba 6e 51 75 e4 45 03 53 f1 74 02 <0f> 0b 2e e8 ef d7 08 00 eb 07 48 c7 c0 fb ff ff ff 5b 41 5c 41 5e
[  453.495522][ T7761] RSP: 0018:ffffc90002b57a48 EFLAGS: 00010287
[  453.497663][ T7761] RAX: 1ffffffff11d2fe9 RBX: ffff8881255ce000 RCX: dffffc0000000000
[  453.500363][ T7761] RDX: ffff8881255ce000 RSI: ffffffff88e97f20 RDI: ffff888106a5e250
[  453.503133][ T7761] RBP: ffffc90002b57a68 R08: ffff8881255cefff R09: 0000000000000000
[  453.505897][ T7761] R10: 0000000082bfb03f R11: ffffffff82621360 R12: ffffffff88e97f48
[  453.508738][ T7761] R13: 1ffff110295a3e80 R14: ffffffff88e97f20 R15: ffff888106a5e250
[  453.511482][ T7761] FS:  0000000000000000(0000) GS:0000000000000000(0063) knlGS:00000000f7ed7280
[  453.514551][ T7761] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
[  453.516790][ T7761] CR2: 00000000f7795414 CR3: 000000015b1cc000 CR4: 00000000000406b0
[  453.519505][ T7761] Kernel panic - not syncing: Fatal exception
[  453.521564][ T7761] Kernel Offset: disabled


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


