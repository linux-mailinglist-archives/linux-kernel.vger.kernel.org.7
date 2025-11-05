Return-Path: <linux-kernel+bounces-886427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C302C358F0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7010462659
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA5131326B;
	Wed,  5 Nov 2025 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbdhyIMR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969F191493
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344408; cv=fail; b=ZWFN+7CmH40WUg9wufKhC0b1p6K5at9wvhVazetEPwPzWa8G84Ooyl1Lnt5XrhCXFTu3QS/w4gqaZlTJfCBoxjA/kerH0kryGZa0drCehXPH5knRa/VxgIC9cltQ/79/usg9fBzU4qLqcm32q0ds84iM6bKVdxXPcN4c1BN+59A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344408; c=relaxed/simple;
	bh=d/UKxGgmSxTw1RD9a5JFak+bFCNJwPHs4xrc5hQil/Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evFh0pjAPUWfIg9T2LRVsQNzL3eR0jzgiH15vcLXBpMug5e2U90MWivqtF3y4G0JhrK4YSvxB7+OLJVrUtOs1CmZ/ZyDXZCetcr63mFWO3e6bbqFhji3l1tuNjGojy0+3zeKcg8RasacP4CL4CxoLo8HSZd9/ZNDXm1Zlv3wtvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbdhyIMR; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762344408; x=1793880408;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d/UKxGgmSxTw1RD9a5JFak+bFCNJwPHs4xrc5hQil/Y=;
  b=GbdhyIMRID1f5xmnh2coq9O3Gl1HeJewXvUkWq3MFgqrgrvHGl6tyKE8
   X4v7inOUHpvxzH6gLGbFdXjNPQftHzRtcpWJKtGcKQP7mGBesxALhdMHW
   fKNOCnuo8K4ZQmKOO1vFIVS5dLmxwkvSJnuj/i7xblskHLZMKjRtngW32
   pvU/CHOcoZzQygN/vzLHlfclVEVQorv5U230iCMnDU0ubIeggqky8o/Mu
   RKfmZJKscglnBypAZJa9HLlRjwlK22UbjGwAz23FS45Y61DI2zW57ktx9
   J7asVqPJ8KQ8eHP7Pi2dN/JOYbrlLVbfC681ykhDOVEU2p3vv+vEpBzI5
   A==;
X-CSE-ConnectionGUID: aStcIlkqROub6GTIW2YgBw==
X-CSE-MsgGUID: p7dqmrV9RUavtU8T836wfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75807393"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75807393"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:06:47 -0800
X-CSE-ConnectionGUID: XMmageQVTtS7dgQc7kzeeg==
X-CSE-MsgGUID: 6WeqJAzCRIecGOvsFsjgCQ==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:06:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 04:06:43 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 04:06:43 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 04:06:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSmpYlfWtk+gZoVwjonzENGvFpqHw5ZFlrtvgIJVqlqPLu010PQpUYAEq4/Y6NAXLpI15P3/IlihBb4joQ6EUkTpun3iRPBL5Ydd/RhFvlyqsbQG4uBTu6txfEZObS0tXgxp5GE3miYq36j6KUylCf23T/qdMNrF0NjBNXwq4p+yjcfWnRc4vemgfjjjDhVY12L0xnF+nhF6cgOhD6JzCei1CLYFKVJsJGtm7gPPH04hOxqUae+d6pZ+DsFmu/mNhq+S8K1/Urh76ZoyGczc/pBLizhJWC7LRphk7ZVAbMFNCxcI1F7F59oRQSUlUNBY9OazzKVTiUn9pd0ytAwzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/Za+E1bhV0WxQJAh8jHJMVQXIUJBqjuF2pG5Zyg5xQ=;
 b=eAxIqVgLf6Jnwq65r1l+4tbhUgLnpZyIL9c8iyDkKhV1yGJ4R2zwNYp35CEiO/rrv4uqmsiZUeJzOcvdaAXikV/k0Dnc9PcNux7eplT4/Gsp9lP+whubcvQcbP/mZoD71EfTabFwWBFDJlMd36EANuWGxmJpRVZgqOcdteMm74qLPXQpUnmM6PsK5v4dwuBrOECG2cEQAV6VDWAGLEPeGcnV0i4mG2g2uk4blnwxLL3+0oNdTxRL1umxpreD0A2IXFEm8fBot3TyfCh64PXqLtbxC/cAeKQ6JXzNkrmqcOYqrxe45aeeQtkaTl4aakzmRd2BvkOaqdEIHVrG9icNFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 by SN7PR11MB7511.namprd11.prod.outlook.com (2603:10b6:806:347::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Wed, 5 Nov
 2025 12:06:42 +0000
Received: from BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891]) by BY5PR11MB4165.namprd11.prod.outlook.com
 ([fe80::d9f7:7a66:b261:8891%7]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 12:06:42 +0000
Date: Wed, 5 Nov 2025 20:06:32 +0800
From: Philip Li <philip.li@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "Chen, Yu C" <yu.c.chen@intel.com>, kernel test robot
	<oliver.sang@intel.com>, Fernand Sieber <sieberf@amazon.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <aubrey.li@linux.intel.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <aQs9yFQloF9aFCbA@rli9-mobl>
References: <202510211205.1e0f5223-lkp@intel.com>
 <20251021110449.GO3245006@noisy.programming.kicks-ass.net>
 <20251027125453.GY4067720@noisy.programming.kicks-ass.net>
 <3b30e40b-f1fb-4145-b4d9-a9279b9602d8@intel.com>
 <20251027135516.GA3419281@noisy.programming.kicks-ass.net>
 <20251027140718.GT1386988@noisy.programming.kicks-ass.net>
 <20251027140959.GU1386988@noisy.programming.kicks-ass.net>
 <e9f705f3-3a8f-4952-b5d5-e36f4fa1515d@intel.com>
 <20251105110026.GI988547@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251105110026.GI988547@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SG2PR04CA0156.apcprd04.prod.outlook.com (2603:1096:4::18)
 To BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4165:EE_|SN7PR11MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9986ca3e-9663-439a-42cd-08de1c63c7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yeGg6mZ23UHctOqVaMADQXSvT4q4/V47kTZDabgN3CWs2D6RqrDzfUWTRI/k?=
 =?us-ascii?Q?mI4SORJAQp4uK8Lvy+NtEYK3GWaCT5fzTPL0DqdIq/kua9V6kmk0Fq/45l7R?=
 =?us-ascii?Q?2S0BC3LL/z40kZlvvkFdzYr47kuitThPIQknVNPrOpCm9RU1VLiRBPXHDpad?=
 =?us-ascii?Q?DVlUyNu54bxOXXh1kMsThubfZ+jlfkgEomsHFSs2kKqTbjv5ivBHUqTU1Jht?=
 =?us-ascii?Q?imBOpJt5n7r8qEiK3tUMBdpGqUNsn1hoVhiMp3ifKZ9smYBNzmOdgEPxdjtX?=
 =?us-ascii?Q?YdeDdS8kgoctPuI83rFQdszLywFDOly2h6JWwRyLGUdvHT4ixkW5hx+JejJT?=
 =?us-ascii?Q?Hfxw0YuEnH89guKnDDmpsNN0hLXVsRSqIQVf1Yy7/YvKo2omuOn5h1HMzPBA?=
 =?us-ascii?Q?+JrZs/0L9E5//SZz1iUdh+qApZLpv7OrF3WCimZL5UiaS1WEXB/JLabCR4Yy?=
 =?us-ascii?Q?wN9SvakZN2TZmdhokkg9IyJr5XGk9IrsWwmo+cz4rpTmQbWD/J4YtoNBBUQG?=
 =?us-ascii?Q?oEyKnJHTrHUFLh67vVDXB+lQ7C3Iie86LLmgUKe1n3dIUsxiK8HGb89FXz7/?=
 =?us-ascii?Q?hAWjrfsXVZltuFIw6pxYuptlZTohvOHXFgDETRWEixUzOAuM9Kdm6rdYMaDz?=
 =?us-ascii?Q?eqd33s24AjO+cEq7OX2IvLSfQ+jLTeidLe7A+xg/Zjzz9n+uKtYgiMOymOzQ?=
 =?us-ascii?Q?DdTokA6J8UySBG8x4okMrMJREzxXxNlIGqgdF/dMtvDi8irx64NEQkyZtNo/?=
 =?us-ascii?Q?331oHWnQJfHJfk2fd9mcO/2fEiS2IbvdGxMt23TUdVvcS6KtVmiEmKOSHD5G?=
 =?us-ascii?Q?jINceNrKLxJ5rf0bjYUaJYbPSN6iuNTiEDGj3B6ViFNavLU/5o+Ydv26iaHY?=
 =?us-ascii?Q?vryG/M9KPkLvQL0IdTNdmrYKcZSMqFTZm2/RKfz7SIgV+qu2UbMhMUab91OH?=
 =?us-ascii?Q?/r2kQx7rPsxORSP0VSxlKzYWUA5PC2q5QasRljj77ZrK/1KwdpViZfATMIv8?=
 =?us-ascii?Q?C7sKQqqMrFGJC3+FeEcp2YBewO1mQTSZA+Sz3rjHHFLBRP1ztFOH9e7yvqta?=
 =?us-ascii?Q?HdBTWxJFNLOgOBQ2Fq6RLNS3D5AWOm+HGquodQWMvo//b3fl5kp8BBiiM6gK?=
 =?us-ascii?Q?7uraNYRnSZDkA6sqx6mVEKQfRYh6o+8HtVA1VJF42r+4sbcAC1MKPBrlas7r?=
 =?us-ascii?Q?nUSW0GiisvMJ7lF5Xi6d7kxLJwn4p2IxE7j9XFsQ1Xa6zbZfsqSMzPLetbF3?=
 =?us-ascii?Q?FT9JfFkAFwItJs/wMxw2D/VyPiM3t/7GMQJ3qfxt9sn/9K3lEgcShVxU5sFV?=
 =?us-ascii?Q?gXgyeePKwOKcymBmpt1bGQnUq3qspJJktTV19baFeOmG2TBMmatPYbh2vK3g?=
 =?us-ascii?Q?hHSxXfhCMuFz5fL4h6IVhFxew1+P02Zt/EGnieM05IUfFymtUEBBTzKI0BjP?=
 =?us-ascii?Q?QE06ZccwJucD2y8OQpGLtTUb+t/O6/43kfF0zuVH9xdaL9wai7yTyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4165.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0tO55EhGyTkpc9LiU5dq3jA1aZZK/cmP4DyKcZG4Op0DjSvZpGgOqpMgSx4z?=
 =?us-ascii?Q?5RIvCBokb/kG6D+W3PGnkGBrGLGNUvDAapQJNlDiV7bYjuYly4A2jJJ3FGA6?=
 =?us-ascii?Q?U8ljwO4WDkqNp/KSmeQMl8NlQVn2EvlTEjPr9HkuqgbU+x/A4T93edhwnRC9?=
 =?us-ascii?Q?0ZI35VeCchp84N+xiS/0E2G9PDKgfe6g1Fv3alOYyoYRvJlSGjk/2w8tBoo4?=
 =?us-ascii?Q?P6NXslE7rYacHby0lw/bMub6qxTP7ekzghDjG8OSyajwbYIYjDyQkLBU782/?=
 =?us-ascii?Q?wca2FONqLifyWPKX93JLC8Ln/wcui+r51sqlOqLZIvWSaAz7sUOxXVtrhW1u?=
 =?us-ascii?Q?+Uv57SwhBEMZyY27nsFt8kRu2r8Yy86vhRdLZ7RP4vuzXrNAp0uskUPAXRkV?=
 =?us-ascii?Q?L9VEwCh7zq0Y+hVz6mU2GZ10Yypi+7wQe31vHm7yLvCOIg08GwhNHA+Xu1FS?=
 =?us-ascii?Q?UbO4KgzEJ7bH3MSd86vbDqJHZm+M3z/ULWuHa8AGylJE8kYxznInFXFg4+iI?=
 =?us-ascii?Q?FE3UTjSFoYetzwSab5ObrJcgJW2dJwalh4/Kb4Th7TSLB1ZCNqL2ZOJJOhGN?=
 =?us-ascii?Q?eyTKBF4twFFyKGKplb3/cyNzLWzACcNuzj17p5WBHXsNLrmAaDmA/a4MPRAx?=
 =?us-ascii?Q?N/Mn5AXf3BZUMNqawrgJVcxOAi+UEJ7lIUOLnQJvW9hstdoTg7b0nbKkxKxH?=
 =?us-ascii?Q?OWSdI7BWMdQSAdyULzKAqGWXfZ91/4LCYIug5LOINqw7trcbruzwaKsKxhsL?=
 =?us-ascii?Q?h17m8yDF3vwe8dMbPnk4G6GE5uS+qCL7EOU0NsbG/EOowQP6r/kDCRcgIMxl?=
 =?us-ascii?Q?xF2W9xZNvPGz8cKWmG1SBcUxk99QvRqG0ovbBguk2a3SOodwJQc9wBeuUSuu?=
 =?us-ascii?Q?2L83c9yDcb6S7BjqJb7ncNm2Pye5nt99vqfGX80oC+ze8z4l0qujlkku5miF?=
 =?us-ascii?Q?dDxHZ8ki7b4BBbDpU1JdUGQtzWEEya/dRm9r/gdzn4BdFsYSFy/BBrAQ5e8K?=
 =?us-ascii?Q?OGTM3FNvUQvMjE9H9G60bHgbYbXhAKjHONfVp72jfjVnRpvfLTOEKLsojbmV?=
 =?us-ascii?Q?8Gr2Wabi3Ez7VnxoiHJkP4DS/V66as0IuUnXV+bUSdHWYOGjaEIFhfuiiRRn?=
 =?us-ascii?Q?HtYuAA7ILIvVwKhDh9XqVherSidhEWhighEmp0ph6QuSKChDbFTXMIyEV4nl?=
 =?us-ascii?Q?9IBQpztF9CAG+FSWP7CGrEmwj1OcBJ5kQASO/gtJ+SlRxGBQKV3bVqQDAzE4?=
 =?us-ascii?Q?aNPQEwFYPcuDFBLr+K5mxyt583S43YJTqGAdByThCKFm20xwEK20CS7rZ+PZ?=
 =?us-ascii?Q?HG3doM3GZwWUafdsJR/v7m/2WIvneEOM1HoXP/NFyE0sBiWz1rMWVvm0o/KJ?=
 =?us-ascii?Q?NU9cwioia0HRiWUZbSe5btkkUUyy58h+HAG3TzWP9cgsI+BrcOtI5jpreBV8?=
 =?us-ascii?Q?zT6jXUuIyMGyCx7uZansPidyipWC5TkT8HphxRk7i9DyjMcO9VeCjhLsrUs4?=
 =?us-ascii?Q?HIDprNU+tm/P/bziYQEd2r8icY5rUUMUhPn9sBQ98fiNJgAigRb2/2mSVWgN?=
 =?us-ascii?Q?6s8Wr/HRyhgD038CdJFAv+S5fEWUStaBCcq2VDv6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9986ca3e-9663-439a-42cd-08de1c63c7fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4165.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:06:41.9006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GXVEYeHaIy3/wQnCRe6sw5M5vV/uaQAZKFDtvjXJQDUCswSsScFvfQIN8jf0+XFKOuQG52em1fZaSp58nXPgNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7511
X-OriginatorOrg: intel.com

On Wed, Nov 05, 2025 at 12:00:26PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 28, 2025 at 10:30:08AM +0800, Chen, Yu C wrote:
> > On 10/27/2025 10:09 PM, Peter Zijlstra wrote:
> > > On Mon, Oct 27, 2025 at 03:07:18PM +0100, Peter Zijlstra wrote:
> > > > On Mon, Oct 27, 2025 at 02:55:16PM +0100, Peter Zijlstra wrote:
> > > > 
> > > > > > May I know if you are using the kernel config 0day attached?
> > > > > > I found that the config 0day attached
> > > > > > (https://download.01.org/0day-ci/archive/20251021/202510211205.1e0f5223-lkp@intel.com/config-6.18.0-rc1-00001-g79104becf42b)
> > > > > > has
> > > > > > CONFIG_IA32_EMULATION=y
> > > > > > CONFIG_IA32_EMULATION_DEFAULT_DISABLED=y
> > > > 
> > > > Yep, deleting that entry makes it all work.
> > > 
> > > 'work' might be over stating, it boots and starts trinity, which then
> > > promptly (as in a handful of seconds) triggers OOM and dies. Not
> > > actually reproducing the NULL deref I was looking for.
> > 
> > Change the following line in job-script
> > export memory='16G'
> > to
> > export memory='64G'
> > ?
> 
> Yes, that seems to help.
> 
> > I had a try and can reproduce the NULL except at first run:
> 
> Took me two runs, but yes, I can see it now.
> 
> Anyway, this is two bugs in the robot, can we please fix all this to not
> happen again?

Got it, I will dig into the detail to understand the difference of local
reproduce and internal cluster run. The image, kconfig, and memory
are exactly the same for actual robot run and provided reproduce instruction,
since the attachment is reproduced from the job execution. I didn't find the
cause quickly, and i will be back to this asap and provide update.

> 
>  - .config has 32bit disabled while robot provides 32bit images. Clearly
>    the actual robot runs 64bit images and the reproduction should
>    provide those too.
> 
>  - job description is inaccurate in the amount of memory required.
> 
> The reproduction steps must exactly match what the real robot runs, not
> something else.
> 

