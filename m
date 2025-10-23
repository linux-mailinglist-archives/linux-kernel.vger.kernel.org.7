Return-Path: <linux-kernel+bounces-867180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E1CC01C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4108F505AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6D932D0C6;
	Thu, 23 Oct 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZUkMGHC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F2E32C33E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229633; cv=fail; b=uq5u9OePjwKlyDevwrK97XRKS/vxBAwrW/98U/BYqdMfTIuTGfNXBKRl89ZNNF5Ojo/3OiyaZ6GoDdr9CTp4lDWMyB7RRtUP6Bnwki0L4slA1s9GvIPb/BMng4FFBw8qWBot2eZsG6ZK0N4ttqgmgRWJ2I1mzMsyk4a4zg8d4Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229633; c=relaxed/simple;
	bh=KMhiwj8K1CB7xB90hxHjLk9euYXH4zHxpiMDBxd6nZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HDp7CTFjhW2oEhpeZENJyRa2dAPpBAJuABf/+s2HEtKuV7qA4u4gf1wPY0yOsp5nzBZPha+x/vYXPSLdOC5T35sX4e3sPev+IY8GQS6nCLBw6Fub7tv0GDsX5XelO2UO662GlefSZSMcoKKYBz+8BOXCdPj1YLThUsh8ov3Oy6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZUkMGHC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761229632; x=1792765632;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KMhiwj8K1CB7xB90hxHjLk9euYXH4zHxpiMDBxd6nZk=;
  b=RZUkMGHCfXAgJZNedxOxnqV5FXrZwnBwg7UHIk/ya1h/JtMxHM+vDQfM
   nV6k6ks7HcB3Dh1j8Iu7D4Y+M6cbfj4iia8c9+UmmKCT2CTO3Erbw9MMs
   VcQnW00wO1jKTIvuFvr3Xv/KEDoN71ihTsHLXx0pAhXBVymYNZbpzJs0P
   WVcDyKJl3Q9vrvzWU9oBVq/W7aKmejgCtvPWdZSToMJxUL4+xNRUo5vF9
   gUI9VVDpVTSQyLPQdUD0eC6LQv7LtondfOA7shE2II9lhmd5UHqHJOw4i
   6yDPWRDepOytojPMdiMBzTwJ9zHxwfiLDEnhf3IOSYRILUy1LhNU6Mb3Z
   g==;
X-CSE-ConnectionGUID: +zwDpugJSmiy57PWL9mIUg==
X-CSE-MsgGUID: Y0nG7OXgT9SL7LEdqQR2wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62609597"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="62609597"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 07:27:10 -0700
X-CSE-ConnectionGUID: lyXrWtkLTFOXdAmrlvVH1A==
X-CSE-MsgGUID: CL2UsZXgRVW0tfIVjvyjng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="221364568"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 07:27:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 07:27:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 07:27:09 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 07:27:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxNcFLRcdL89wXJJ5zH57eN+NMkqXAnCexbmYlRkmBo1JOxG9F2AST4mVtV7qZXyuWqf1Bl6FwabowWsx4n5VQSaYEiEVcDX7AFVXzPHHoB0JLV9n+5o0n0+p8fmJwiy1rs2Cpl442leIsZ2FFFSxjTvs1xZfZQTBCG2+QMWv36A4v/hl8Ytl0ks5wAxInbRGdNejaa9n3y5kVbj9X1HqaWDcmeNLz08DufuZ9jvltRFghv/tEEnnqET8kb6AxtfrS/XHsPywMrGKI/dBPl8ByP7nek8M/PtTFUHGI0wYUqEzaiM3v784pk5zKLdRMaviQ20C0nkZVKxQJS6CjEF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+cH92g+aHmOjR47VieuPGQ4cwioYI1uz08JZhaj1uw=;
 b=RUdqQdYwlw6hoCOeYc251HKkWi5xsoGlVTBS8xSNGosMZToYEXEFC1b0UBtwQ4vpelEiXaFqepbY0pLODobBkdEBqzl3hEUP0DOmWSH5V96W25DAiskBVsS/P0yNCxCPD+ATL/Y+tPspOXutkPUA/nPjpN62ONgSjqYloedLSHP4bqPbBs7ICl1j1mlh2wM7spOcNxq4ZRRJCkI09AzZFPoIJO1IKs482lj9QbTHHn7hdZYuDliG+ibpYYQj2qboe0gkRDarnrVG7/GnSY2K1RfPl+abAhM0GTijBd9YUfGzGlW97Y+Z4lLbKMi4o8m/MLrAow3n0YuLuPRFfwpDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB7001.namprd11.prod.outlook.com (2603:10b6:510:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:27:07 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:27:07 +0000
Date: Thu, 23 Oct 2025 09:27:03 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Alexander Usyskin
	<alexander.usyskin@intel.com>, Anshuman Gupta <anshuman.gupta@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>, Arnd Bergmann
	<arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<intel-xe@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mei: late_bind: Fix
 -Wincompatible-function-pointer-types-strict
Message-ID: <qxvmx7nawbqjj5luzzken3psdei7pvgliieiv4vdxgumb2wpkx@p4ckdsds66ak>
References: <20250920-drm-xe-fix-wifpts-v1-1-c89b5357c7ba@kernel.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20250920-drm-xe-fix-wifpts-v1-1-c89b5357c7ba@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|PH7PR11MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: 53adc9c7-9f28-4263-6088-08de12403e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pXKlTBgmXo5RohKsQl2keah1NgBE/rpstxue+jV3loe1oXKCz/mlrd/CqrU3?=
 =?us-ascii?Q?ptfQ/G8g+sYiDskZfxqQl+1xCqn9rpx+m3zTfLAsFKQOKaC4IgdwtpLiV9F5?=
 =?us-ascii?Q?1yP1reNpJiaF1RHZcmxwq5IaETomIovQW4QURI/iqMX/ZoE+7geWqKE2TWIv?=
 =?us-ascii?Q?vb73gCZNm1lQzVeU4aeQMKQjs0iVTBTbgPkQNPcDz5qUqQlb5sBcTDbIl8d5?=
 =?us-ascii?Q?p6KqEVTphhKNYa3j3Cq9NerN5w27npQHP44pnnnAdmbIDVS6HOrjWdzlxRI3?=
 =?us-ascii?Q?B2SDFUH0WdVVOYYOhVRlcVkpg4Hi+MarDPe2h0kiXpm39gLn1/wXQV8qe3lO?=
 =?us-ascii?Q?Gm9wYDTHaoMlqd/DWmPfrSc9sDcErVITF3YBqeMHM0CtDdOsbEgv9SCn5fly?=
 =?us-ascii?Q?/mnC7G59WzUgZQFRKpHdxbhgH8Y/urkMSZPAkTnTG5uxseyFeBRg1cmO2jGU?=
 =?us-ascii?Q?rZFGZo84aEpvIQ56T8XHj2e+4UH1uvLcjmka4lg2iKrx/V59t6ttyT4FIINm?=
 =?us-ascii?Q?Zs2aHlLFj05xyfGYF9BcGCHK6yOYxllTCiAavhIZ23atR5KyBV1Bme4VDF5Q?=
 =?us-ascii?Q?DqvNfIFwYJswHQxO7EhaRHA+M4hwZFelFsyYVjgcozW5KX6YmQ/JD/ZgVjMP?=
 =?us-ascii?Q?AgifRg8XbsSW/mnooaYp5S/JEpnMHwtaIso59zLFKvqcDyVk74Z8agMpC0Tt?=
 =?us-ascii?Q?TJgH7upYkWSeaWqjWi1tVXUlU7NTEitwXqWJLWpp082UrakqbJypVpRbkcHa?=
 =?us-ascii?Q?fK2WlOZylnw5gzjs/nebnnTfZWj4hPI04na6P1ZGEcWtNH2iNeDTBmmOEiJZ?=
 =?us-ascii?Q?O6S9CdlE3xnaFHfaH6pIAnX2TBai7yuyl1c38bO2bygEJ54qZ8ZoAM/bJowJ?=
 =?us-ascii?Q?6UFYxYG+eIRqQK5VbZB6zNbxtFzQ4+bGBHa1E1cwBjt/UjIY6XIcRnMsLAU0?=
 =?us-ascii?Q?IzDobNlm+dIyx4a8OUsZtfTL2UoQDgUmBWGCLCxELDAMWxlAY37aqDKE8KiV?=
 =?us-ascii?Q?tDv2p10m6x/9vd/074xlgAAIwkH/Y8Mu5Q4O66WHjvBcR1MUfDMwQHUSwbh6?=
 =?us-ascii?Q?167vxBCm+CQFsmTt6G1jdArzeeFzAcfBkLMHXcQp/nmYU+OT0//BPbDfqkMG?=
 =?us-ascii?Q?IGage+EchLtMOhHWz3B9SyroDEpwymt1aA6Z244nfiGu6oHoyGUseqF9XvFh?=
 =?us-ascii?Q?B99J51Q6aFLk7SDvuuXt8xr6Xru0HJeH0fP3VvhAi1WpIfDhIL1NHNNLcuol?=
 =?us-ascii?Q?UxBoi8VGTq6SKulNLc0lbDUekrBBvWGrSQ7123jmyQ+4wmpudfL9b4cGi82d?=
 =?us-ascii?Q?DP4KM1CPQBkNBW00zqrM+GXDlAvu4k54v0z8rJ3lg6fgeCa+7NOlRHHCUCnK?=
 =?us-ascii?Q?wMkScmtRaUjemHu3dIiU5Qv9Oe1H7Q/bdm8bKBiyO9v+atzMS5RN0rvtxh/m?=
 =?us-ascii?Q?Iv3A6RlAjkfwcSDpzw2+zPwUpSPsonan?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOCjplIAnyb/xkLhwOmbpO7XutGpZocWUG2aV+ceF45wXGC/Uq8JcnSQh2x9?=
 =?us-ascii?Q?u5z9uh9DDwmg7Zdmguvvqk6Jxhg7VJuroTBBzyYrFk1yBgRj/J+muzDBGMpl?=
 =?us-ascii?Q?fQkcP5qoE52wojP5FBe2NzHASiz2DyfzZKjz+30diRD1FOBrKfwIhmucfh3o?=
 =?us-ascii?Q?sCfJY+WMPqC1HTQHm1XFP+sF/5Kj8gmfz1DiIfzoUGasTp4n1aJ10Ihz+l/E?=
 =?us-ascii?Q?bLQeBRL2qDRXIdoNqLExwpARoMm0ndkJtLrZwGB78cfVaJrJYrJcdzRKMGvh?=
 =?us-ascii?Q?ZtoZUwB91nh2IIH/3ob9pXsYt6nWaBz7z1NzsbDefGDoY8VG+bFOhcQRYQ3u?=
 =?us-ascii?Q?L+DujXpw3MZa43ljeEtBt0JxgE5DZwUyjKnEDtB1hosNqeFEns6G7jiFzHz5?=
 =?us-ascii?Q?c3I8yW3kOdU+hGdMuzvt1hhRuudOP0FUzB9U/lkEVblGMLpdbQmOG939Dk4U?=
 =?us-ascii?Q?8oURrGf4r2U8IdUBMjlPBPnsHUCj+GC1tyY51UCNaea/D9UPmczQfauYX7x7?=
 =?us-ascii?Q?L+4hscGXvVOsVxvz87Pjcg84OYud0ZhKbZLC4aehCP3LsjyFppksavkJts+D?=
 =?us-ascii?Q?hHMJke0JrztJJAsGQhwNRMSOnoGlqjSKL4wuG0TWmyPyBqzSIpwHnKXL0n9V?=
 =?us-ascii?Q?t4Z83+cefqnb1MrrK+eoGNz0GIhTKC23AD6OudRiv0HbGI6Hcl0LDnRbK7zF?=
 =?us-ascii?Q?JkInoG8QmtGW2HB6ZbuHu4B0Vysp65rrU9VXCLiKaZ3Mr3hfx1eZNLT9BCM2?=
 =?us-ascii?Q?KXFuZB6UFmmXhzwuAK3xCSe4EjJEuKJZb4qq6fXwdRuNULSriI32lbaLOdTA?=
 =?us-ascii?Q?9K/ti4y6LU5MDauXubnkSHQ+jcKzLiZl0kcfArsm/VjA0f9+rjBqPN80uLhR?=
 =?us-ascii?Q?EchPBIG7rJqvopGbx6WyOalF9ysOK/LOwaOsfC33gdqryyyMPnh4OQ+HEbBT?=
 =?us-ascii?Q?6clFfzaM62aWRPyI3zCoARjBGzPLsuFDxAK0cpezwVU4mkRazdYDQgDxfUGN?=
 =?us-ascii?Q?Q+togjWvnOMhqrgLAMWT2IvhXEW/lkqI8n7CKiBq1kyCoH6bHr2iTeos2T0B?=
 =?us-ascii?Q?AkwKMm0cGub0yme7jmvPkSZ+hNIFrIS0daC9LL0OxV8jLr9d6+hvDgdWacBJ?=
 =?us-ascii?Q?z4jtGqqRh9jseVLcV0MMAO1inEpKJUHqa4kQxUoYFCYgM6ykPRXpdZNTegil?=
 =?us-ascii?Q?aurWQbyYbOLJZtZz5sdJ6HD8dx4DF+f055Owt4/j1GmDj2IsU5wSOcyu6CFG?=
 =?us-ascii?Q?2WCIfmrC5PpxDEbxXLSDR9Soc3E4kyHuTw4VJ111pB5YgPyAs1Q2sUS+5INm?=
 =?us-ascii?Q?/VIsAKcmu+OWsY2PSu+RyoGX6txI8IBPFlz3Ez1pE8NJsxX5Svg/FTZ9W0fN?=
 =?us-ascii?Q?seAfk4AHaHv+NM6+iijxXyb/sM2C/xgPfyMEg7w/aQDKBU/Wf9DVfTdJKytu?=
 =?us-ascii?Q?MNBbDGyoLIq6fFYXwavlr8r1GVukPWLby/lbPwx349EuIZmlCap0dCAHv3iN?=
 =?us-ascii?Q?CwOnCUwDYd6iZ1JouF7BnB2XOdE3v7jDxNQCrr2bixgs/uX4ulElQYZvYiYl?=
 =?us-ascii?Q?z0l7jC+4/WIdLP20NdqKRmTg6eK6ITuxIcyCn9he2megZNm4FaTfynVe2T86?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53adc9c7-9f28-4263-6088-08de12403e8f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:27:07.2553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mlf4hvqUvIefVeMHAZRHoxQnzq9sl3NauMgc5oqILrOV9KQ+Oct4JVXo8XFBeMzgTeaAzFLWDXhMC76us41eAUaMngglbCDPk+dhWSoHhNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7001
X-OriginatorOrg: intel.com

On Sat, Sep 20, 2025 at 04:17:50PM -0700, Nathan Chancellor wrote:
>When building with -Wincompatible-function-pointer-types-strict, a
>warning designed to catch kernel control flow integrity (kCFI) issues at
>build time, there is an instance in the new mei late binding code
>originating from the type parameter of mei_lb_push_payload():
>
>  drivers/misc/mei/mei_lb.c:211:18: error: incompatible function pointer types initializing 'int (*)(struct device *, u32, u32, const void *, size_t)' (aka 'int (*)(struct device *, unsigned int, unsigned int, const void *, unsigned long)') with an expression of type 'int (struct device *, enum intel_lb_type, u32, const void *, size_t)' (aka 'int (struct device *, enum intel_lb_type, unsigned int, const void *, unsigned long)') [-Werror,-Wincompatible-function-pointer-types-strict]
>    211 |         .push_payload = mei_lb_push_payload,
>        |                         ^~~~~~~~~~~~~~~~~~~
>
>While 'unsigned int' and 'enum intel_lb_type' are ABI compatible, hence
>no regular warning from -Wincompatible-function-pointer-types, the
>mismatch will trigger a kCFI violation when mei_lb_push_payload() is
>called indirectly.
>
>Update the type parameter of mei_lb_push_payload() to be 'u32' to match
>the prototype in 'struct intel_lb_component_ops', clearing up the
>warning and kCFI violation.
>
>Fixes: 741eeabb7c78 ("mei: late_bind: add late binding component driver")
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Sasha, is this fix something you are taking through char-misc since the
commits that added it already propagated through the 6.18-rc?

thanks
Lucas De Marchi

