Return-Path: <linux-kernel+bounces-798293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD7B41BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948D916F696
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760482857FC;
	Wed,  3 Sep 2025 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rsgvcleI"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B79227702B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895569; cv=fail; b=m+Re5qdt2XgQzNvd/EythuggI493tBF0KYuDtr6ga9eBJqWmu3mcWmE1LpfGjRB9ov/Lc0ggcoS5cnbwSS/viYCDbjxe+6PozCXpEKcyc+13l3BxIkBVTWipCWPReJc6AzNe5A+HVAj/GoQmelrGefa2e9zVGW42Yb+PcaY0e7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895569; c=relaxed/simple;
	bh=KgluvtFt07I2qAHKXv3XPKRBPNLJ+JPKoKkedOmrH8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPt7CMN15EUco8XZzR610PuQ0ICplLURRWLHefDoq4S0Hxx4daaQ/17QDu4fXUKzgXXBaajQldX2P4cl9hANd0mYXimFt61q07d+4wbP0dFebuHIUJNtiewTFy4UJfOFTH4t4D3fSryP2nEliSu+yl5woY1wQZO5dGW8V1KdKVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rsgvcleI; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llEl3w4IgwHfK+4JONxtdY6zaCedfTRR6EXI1KsVcfbF2B7XfTk7knhyYHJpe3DqZZpfeBHx4M8jtzsbrL+n+8+46oUNGVQrALkzZWPRVsD+i6rpnMCIQsY/lMYK2eY84WGalK80J+i7Ava6l7eZ6tEAlUgsdyeyPHUypyetNH3lO8ap76De+lHIty3BGR0Kc9NxhQS/mRYtv0wFDxxnmxBR0sH8jyc8FMIpmlw1Tkp/3e6yMd2w+K2CdR1dNFqcdG/mjqooEj8sqTZMnjQMZcZKPVYxvGnng43FXqXuFV1kAMAijPZvLVXiOD7p8zhVOteZw1XPHeUJOgFOJyeBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AA1jNcohRZkTiaEHuuZDEMhLbPtiTbs3h32ZQVrQZA=;
 b=ukhnPxksM1PiA4m65FDjKgTrS9CFlWcAbez7B0VfGzXC7BR7ocCeYomPkwHjaSiOU2zdAZ/gDy4TGjRexpqC6gnwHOfxW2j1KMuu4o6uksowVXzK4zWjQQOGrxkccyC2w5UnXxeq2iiUHfwi9WnrzV75v7eSAYFWz4KzQUqFNFja2aSUGNgaacWIQVHTgaDuXCaiSnlA7+17D+UeKIiKTzpajQLt+s92UI6AEf8GFlsyWMpcb9qEasAH3Gl1XZIqDcDaNneYLuZSpSilCC1QWw2JK0REMCl8SvVjVHvCZbqvLSlP7XCR7o/clIjUHc+5aI417hjrRal6EBjjXq7wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AA1jNcohRZkTiaEHuuZDEMhLbPtiTbs3h32ZQVrQZA=;
 b=rsgvcleIFTdnkq0KAreJMM/PFZKjljy00SBN5OtZjE5cz2h15Vh7YXPlOJjMNgI8tkFGMzS3Oj9catI9ygvmGCazGmhkAhMwEnBGq35O5jEEYZDC8JCzKU8mV3rFgT68bBdtUJcaS1hpXi75dB1cVe5YNcianry2jTt+pYIbzNSJKHmWohGZsiLIj0kLuNRoL6k8mXFOa7rxFWFhazZfzXcW8v1YZjWVjlzmBnKMnwo+mj7NaOw2rGCrKJVVN67u3cB2fpdViwH25vrpM82ynza5n5Yts5h96S6/aixaFbilvguSKthAY5C4CAUDddjoxDk3RWmVrBheJBwBnUByXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 10:32:33 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 10:32:32 +0000
Date: Wed, 3 Sep 2025 12:32:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, multics69@gmail.com, linux-kernel@vger.kernel.org,
	sched-ext@meta.com
Subject: Re: [PATCH 3/4] sched_ext: Move internal type and accessor
 definitions to ext_internal.h
Message-ID: <aLgZPcwe9UFXw7rb@gpd4>
References: <20250902234817.279206-1-tj@kernel.org>
 <20250902234817.279206-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902234817.279206-4-tj@kernel.org>
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d12976-f736-417c-6633-08ddead530b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVDa5dRzGELuQ6R1NNdmk1ZQEY1U/nAgZt7PgY+VaknAArnoOvWdO6PKdFdB?=
 =?us-ascii?Q?MPopXRX5XkrUi41aulzL9PqMHaMnpKBBPt9i2lODLC12X3WTTY9TlNkNRs+O?=
 =?us-ascii?Q?Rpo+nD6maGwNFuork7L5PY2YdAsBv/Tafv4QGCASO3qEGylBL7bnKl5poii1?=
 =?us-ascii?Q?NOXv1+ikDJ1Yk/ZU8a+tskrZYORbz+HSwK0J6tPD6oeU13dISETN+wRbdOrK?=
 =?us-ascii?Q?P1o5D9cHOQ7rfEEKjioPkFQdqw81isT+kfuYfGQ+a7HKCD9fBgTERn1swcQ+?=
 =?us-ascii?Q?/H1afl5PMCkGXjea75ID3A4ftmhtgVA0q+k5KKsFaQPlncQ9/gtCDWvuQpOP?=
 =?us-ascii?Q?LQsIciiNzs16ezExmYNLOomew+QqZN2EC3DDTSlMT1YAdJvKGRKpNzcbljuW?=
 =?us-ascii?Q?0Pca/xWxWfd30r0Iv+a3fnPYvZeb8toVsSNIIozDtfx1JEcmtY5/AoQoPoKt?=
 =?us-ascii?Q?G9j1ZQ2tEjIxRS4w7urhaq+uR0mXyUkKFym7Vs0yicyXVs+HLhahFdcLnwbj?=
 =?us-ascii?Q?TGMzrYdcH+6jwLaoo8+j7H3+I9rqPPxDdhXqE1/6jAyKYXxTud6T71KvBTVq?=
 =?us-ascii?Q?ss0dONu8HGOiZ6IWkuD5l4ksdUHKvEkbNMMxLOOllQrHkaYvD1zanVdDJ+lp?=
 =?us-ascii?Q?bKNf4VNENUGTxIzPu9Z/ychQXMqEOXmTrk2KuNtWbTpWxDq61iGcYjtk3vDs?=
 =?us-ascii?Q?LsPu3659KAK1uMc0Ppn3ZHT0dm7BCD0aLDnjCPr/urcPCqE+E6B3y+Z0VpOA?=
 =?us-ascii?Q?1t08YyxgnZRpakPTTMettcdVFEA1rRqyCA/U68VC1GyylAeGCqRt8eeOqjUr?=
 =?us-ascii?Q?/sBYYTMEgiWcXasIt2rJ8U3lq87bRS8jOsZkDEjHQKStrHB0Gf1KQhEPFGew?=
 =?us-ascii?Q?lKeL4FHhNHUnt805gVwR1UTtLMATo+a1ZAIu73rcFqQGbz2W/wZiLut6/cc9?=
 =?us-ascii?Q?U0jYvrGEf7kfNPCzQFVouBm2vMpAtkoRzGfFegX5eUfqzIgaxeA98W8gn7gI?=
 =?us-ascii?Q?5hs1ScuGQmHa0Ko8aTRtyXrfSVfwHkdfAgebo4uduJcWzankYTG8Zu/xsOTx?=
 =?us-ascii?Q?Q4W4xGn8DuaD/Ygq6O9HNDGwnpl6q+m+2Xn2z/jq1p3x2C12ODKnGnylSVdO?=
 =?us-ascii?Q?t1HTQB5VspIwlAWIkFRVL+IB/QPkkbYOgqovXHgHNRGMc2Z6xi/Be7n/t+6r?=
 =?us-ascii?Q?ZNGxsTbqKzSKbdyB5vbJyKluHoKO4PELcM6YfR4OFmWlT+Fjtec0H6LcJ6ZA?=
 =?us-ascii?Q?MwyWyUHyWyGGw32xLlQwc/5Ix5zLGqSUpdRzDDZKSrnrM6IGFXiYrZiqWanD?=
 =?us-ascii?Q?bGbomb+p2FLp0cptNL699+DoHt0CvDFRHZ+yWKV7i5sWe7H05A/q2xlG8PnZ?=
 =?us-ascii?Q?rnXkZGDonxIuJaBATS60gPLHHx0JxS+T6nOBTC0h2fx7nkBIr0S17Sg2EjVW?=
 =?us-ascii?Q?Cxv9b8JRfaU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7E4hFlj74SA0vPLUbGynTokGzs3EY8nwwWCa1IvUZvGXbAcnZL0nSkR6xrcz?=
 =?us-ascii?Q?CYfp+MWubY5OjNuphPAZcnQX/uZ5vRH9LSfEjGot4S4SpoxPyz1rnXxBRlT9?=
 =?us-ascii?Q?QcIIGKJlUF9uTcqkwIY2zNyvjV+P/YJ/3uvVkkO/TEMhp5xdzWJqpZIbBY6K?=
 =?us-ascii?Q?IPfhbK++M6bjNoOrBDbAaoBuePujwOXwZrzX2tcn5wkLh27ISj62/WHQCV91?=
 =?us-ascii?Q?27/R/r/l1zT/GjUJyP/lQHYweNWHABvF3J3+0z44ucOw4cGr0b6YrMVF5hUP?=
 =?us-ascii?Q?lE17jJHglEFvh1kMNx3Qym1PlUEVIOuyj/rKSc5Ug0YLugtVkZWzalUbcqv/?=
 =?us-ascii?Q?529Rl6YhxnoLm+UrIpW3A+yfpsJYecXDiUl6mvyey2C7wX8CHDNfT1MxlUZy?=
 =?us-ascii?Q?PSyGuPCOPe+FP743JCdgB+NEStlDrigWcI96vV+NxbwTJbmHldKb7yvWiQYf?=
 =?us-ascii?Q?Ksp20F2n4hI40TzC3oCigXcOHFxz0D46cBjKXUJycXRLI42YxTsBLE6MET31?=
 =?us-ascii?Q?NsUzR6Li+SW0vP9vp5KKpHJVNhs0o9hOajryNIJOQsvtDSBy8uZS14baF3Rh?=
 =?us-ascii?Q?dUQwh5UxBrK5xPG2Z4szpCMto+ms9Np9XQjIGwaBdpWD+wUHf8DDiG1Fklz2?=
 =?us-ascii?Q?GMZ6HopQ0589lhMrNeSiZEEOdMSvkargxAlF1JM+qAM+RAl/kDzTlvTD+jKO?=
 =?us-ascii?Q?1F+L/lSjZheaDmxfAhnszHghIrZyCN4rfgBsUoksK1QjTUcYQXEBDGvyY6UR?=
 =?us-ascii?Q?YzeMBYtRysrhG0jB9SEkDQ0VIyUb3yjOUdwSm02sw0VXQn5jtnryEtqBWtLk?=
 =?us-ascii?Q?SLdOen+XXaN5H3NYDcq6mMgE6hf6HfTFMjERsfJvenIvi6NFdXOeR0TCym9v?=
 =?us-ascii?Q?+vZAKJPwW14JisFLRZzEqyCrkuNspLgEX9i+B90Ri4MwIQ3JpY3eicnAESKK?=
 =?us-ascii?Q?LWcI+Xg57LmTJ+GfTJS3dMRWT6Z7AuGgRu4kBqtwUSs1uY0ezxp9uM5CtQS9?=
 =?us-ascii?Q?OBxhV6vlxqz5ePoPGFiB2Hre4cMG7zLNM448IknjmIc29RxcYB7Dkzd33Hwu?=
 =?us-ascii?Q?EIVnpbAiF0BEK77pNQs6Rar6/DciP/XkNGcfb1JzOtEQyP/w0SClx0MpAUeN?=
 =?us-ascii?Q?BLUIOypHFYbeC7/3/8Avl8mNWpou4PakdygCoR4UHrtWKwCiHfWAO83KQJcO?=
 =?us-ascii?Q?xqyPeH302HlGo5Wc6v0My+aFEZWetR39meOs2z3OMX2Ix1yA+1ta0NjlLHSP?=
 =?us-ascii?Q?R6pEt0DnkSPLZw6NGHZWTTna9G+JnLqr/722Mt77hcTHTwjQpJsUlCJwG+mY?=
 =?us-ascii?Q?2suLEyzFxp8ARvf4Rma/B8Wf3nxf/0U6Pf0X22gMbnZ/NIblOo2UKt2oeohw?=
 =?us-ascii?Q?ji0iQYd+uYOHmb7+Tw9ZBF4ISYNavfo0sQx/9U4CGilfU89YbLdr5fj2qYvR?=
 =?us-ascii?Q?6GWnA5K7wGRg0FFt4cYxeZPn3tXif63JBubVhLe/XkjV7M5TSYO5ku4XkJDz?=
 =?us-ascii?Q?bS6oFimYMakWkSAzVPcMBNm/NaHhH3vKZ5tc2rOMccbj/54YGKO3RU2N3zUx?=
 =?us-ascii?Q?sWMDdpYHINlD2UKEYtoBSjD2NQ8bnphHMhKhYAGB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d12976-f736-417c-6633-08ddead530b9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 10:32:32.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkCaR5u9g5e7EruxtXRI9aDvrqqLioYchgKjbgmTPdeGOb3Zjr9LVYkF4y0v6t+fVrwokcYZSd+EUG9ccNc4pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1

On Tue, Sep 02, 2025 at 01:48:05PM -1000, Tejun Heo wrote:
> There currently isn't a place to place SCX-internal types and accessors to
> be shared between ext.c and ext_idle.c. Create kernel/sched/ext_internal.h
> and move internal type and accessor definitions there. This trims ext.c a
> bit and makes future additions easier. Pure code reorganization. No
> functional changes.

Having sched_ext_ops and scx_*_flags defined in ext_internal.h feels a
bit counterintuitive, sched_ext_ops also includes the documentation for all
the scx callbacks. How about moving these to ext.h and everything else in
ext_internal.h?

Thanks,
-Andrea

> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/build_policy.c |    1 +
>  kernel/sched/ext.c          | 1034 ----------------------------------
>  kernel/sched/ext.h          |   23 -
>  kernel/sched/ext_internal.h | 1061 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1062 insertions(+), 1057 deletions(-)
>  create mode 100644 kernel/sched/ext_internal.h
> 
> diff --git a/kernel/sched/build_policy.c b/kernel/sched/build_policy.c
> index c4a488e67aa7..755883faf751 100644
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -58,6 +58,7 @@
>  #include "deadline.c"
>  
>  #ifdef CONFIG_SCHED_CLASS_EXT
> +# include "ext_internal.h"
>  # include "ext.c"
>  # include "ext_idle.c"
>  #endif
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index fda2b4e85ee3..7e15e852370c 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -9,1040 +9,6 @@
>  #include <linux/btf_ids.h>
>  #include "ext_idle.h"
>  
> -#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> -
> -enum scx_consts {
> -	SCX_DSP_DFL_MAX_BATCH		= 32,
> -	SCX_DSP_MAX_LOOPS		= 32,
> -	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
> -
> -	SCX_EXIT_BT_LEN			= 64,
> -	SCX_EXIT_MSG_LEN		= 1024,
> -	SCX_EXIT_DUMP_DFL_LEN		= 32768,
> -
> -	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
> -
> -	/*
> -	 * Iterating all tasks may take a while. Periodically drop
> -	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
> -	 */
> -	SCX_TASK_ITER_BATCH		= 32,
> -};
> -
> -enum scx_exit_kind {
> -	SCX_EXIT_NONE,
> -	SCX_EXIT_DONE,
> -
> -	SCX_EXIT_UNREG = 64,	/* user-space initiated unregistration */
> -	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
> -	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
> -	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
> -
> -	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
> -	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
> -	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
> -};
> -
> -/*
> - * An exit code can be specified when exiting with scx_bpf_exit() or scx_exit(),
> - * corresponding to exit_kind UNREG_BPF and UNREG_KERN respectively. The codes
> - * are 64bit of the format:
> - *
> - *   Bits: [63  ..  48 47   ..  32 31 .. 0]
> - *         [ SYS ACT ] [ SYS RSN ] [ USR  ]
> - *
> - *   SYS ACT: System-defined exit actions
> - *   SYS RSN: System-defined exit reasons
> - *   USR    : User-defined exit codes and reasons
> - *
> - * Using the above, users may communicate intention and context by ORing system
> - * actions and/or system reasons with a user-defined exit code.
> - */
> -enum scx_exit_code {
> -	/* Reasons */
> -	SCX_ECODE_RSN_HOTPLUG	= 1LLU << 32,
> -
> -	/* Actions */
> -	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
> -};
> -
> -/*
> - * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
> - * being disabled.
> - */
> -struct scx_exit_info {
> -	/* %SCX_EXIT_* - broad category of the exit reason */
> -	enum scx_exit_kind	kind;
> -
> -	/* exit code if gracefully exiting */
> -	s64			exit_code;
> -
> -	/* textual representation of the above */
> -	const char		*reason;
> -
> -	/* backtrace if exiting due to an error */
> -	unsigned long		*bt;
> -	u32			bt_len;
> -
> -	/* informational message */
> -	char			*msg;
> -
> -	/* debug dump */
> -	char			*dump;
> -};
> -
> -/* sched_ext_ops.flags */
> -enum scx_ops_flags {
> -	/*
> -	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
> -	 */
> -	SCX_OPS_KEEP_BUILTIN_IDLE	= 1LLU << 0,
> -
> -	/*
> -	 * By default, if there are no other task to run on the CPU, ext core
> -	 * keeps running the current task even after its slice expires. If this
> -	 * flag is specified, such tasks are passed to ops.enqueue() with
> -	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
> -	 */
> -	SCX_OPS_ENQ_LAST		= 1LLU << 1,
> -
> -	/*
> -	 * An exiting task may schedule after PF_EXITING is set. In such cases,
> -	 * bpf_task_from_pid() may not be able to find the task and if the BPF
> -	 * scheduler depends on pid lookup for dispatching, the task will be
> -	 * lost leading to various issues including RCU grace period stalls.
> -	 *
> -	 * To mask this problem, by default, unhashed tasks are automatically
> -	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
> -	 * depend on pid lookups and wants to handle these tasks directly, the
> -	 * following flag can be used.
> -	 */
> -	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
> -
> -	/*
> -	 * If set, only tasks with policy set to SCHED_EXT are attached to
> -	 * sched_ext. If clear, SCHED_NORMAL tasks are also included.
> -	 */
> -	SCX_OPS_SWITCH_PARTIAL		= 1LLU << 3,
> -
> -	/*
> -	 * A migration disabled task can only execute on its current CPU. By
> -	 * default, such tasks are automatically put on the CPU's local DSQ with
> -	 * the default slice on enqueue. If this ops flag is set, they also go
> -	 * through ops.enqueue().
> -	 *
> -	 * A migration disabled task never invokes ops.select_cpu() as it can
> -	 * only select the current CPU. Also, p->cpus_ptr will only contain its
> -	 * current CPU while p->nr_cpus_allowed keeps tracking p->user_cpus_ptr
> -	 * and thus may disagree with cpumask_weight(p->cpus_ptr).
> -	 */
> -	SCX_OPS_ENQ_MIGRATION_DISABLED	= 1LLU << 4,
> -
> -	/*
> -	 * Queued wakeup (ttwu_queue) is a wakeup optimization that invokes
> -	 * ops.enqueue() on the ops.select_cpu() selected or the wakee's
> -	 * previous CPU via IPI (inter-processor interrupt) to reduce cacheline
> -	 * transfers. When this optimization is enabled, ops.select_cpu() is
> -	 * skipped in some cases (when racing against the wakee switching out).
> -	 * As the BPF scheduler may depend on ops.select_cpu() being invoked
> -	 * during wakeups, queued wakeup is disabled by default.
> -	 *
> -	 * If this ops flag is set, queued wakeup optimization is enabled and
> -	 * the BPF scheduler must be able to handle ops.enqueue() invoked on the
> -	 * wakee's CPU without preceding ops.select_cpu() even for tasks which
> -	 * may be executed on multiple CPUs.
> -	 */
> -	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
> -
> -	/*
> -	 * If set, enable per-node idle cpumasks. If clear, use a single global
> -	 * flat idle cpumask.
> -	 */
> -	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
> -
> -	/*
> -	 * CPU cgroup support flags
> -	 */
> -	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> -
> -	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
> -					  SCX_OPS_ENQ_LAST |
> -					  SCX_OPS_ENQ_EXITING |
> -					  SCX_OPS_ENQ_MIGRATION_DISABLED |
> -					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
> -					  SCX_OPS_SWITCH_PARTIAL |
> -					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> -					  SCX_OPS_HAS_CGROUP_WEIGHT,
> -
> -	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
> -	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
> -
> -	SCX_OPS_HAS_CPU_PREEMPT		= 1LLU << 56,
> -};
> -
> -/* argument container for ops.init_task() */
> -struct scx_init_task_args {
> -	/*
> -	 * Set if ops.init_task() is being invoked on the fork path, as opposed
> -	 * to the scheduler transition path.
> -	 */
> -	bool			fork;
> -#ifdef CONFIG_EXT_GROUP_SCHED
> -	/* the cgroup the task is joining */
> -	struct cgroup		*cgroup;
> -#endif
> -};
> -
> -/* argument container for ops.exit_task() */
> -struct scx_exit_task_args {
> -	/* Whether the task exited before running on sched_ext. */
> -	bool cancelled;
> -};
> -
> -/* argument container for ops->cgroup_init() */
> -struct scx_cgroup_init_args {
> -	/* the weight of the cgroup [1..10000] */
> -	u32			weight;
> -
> -	/* bandwidth control parameters from cpu.max and cpu.max.burst */
> -	u64			bw_period_us;
> -	u64			bw_quota_us;
> -	u64			bw_burst_us;
> -};
> -
> -enum scx_cpu_preempt_reason {
> -	/* next task is being scheduled by &sched_class_rt */
> -	SCX_CPU_PREEMPT_RT,
> -	/* next task is being scheduled by &sched_class_dl */
> -	SCX_CPU_PREEMPT_DL,
> -	/* next task is being scheduled by &sched_class_stop */
> -	SCX_CPU_PREEMPT_STOP,
> -	/* unknown reason for SCX being preempted */
> -	SCX_CPU_PREEMPT_UNKNOWN,
> -};
> -
> -/*
> - * Argument container for ops->cpu_acquire(). Currently empty, but may be
> - * expanded in the future.
> - */
> -struct scx_cpu_acquire_args {};
> -
> -/* argument container for ops->cpu_release() */
> -struct scx_cpu_release_args {
> -	/* the reason the CPU was preempted */
> -	enum scx_cpu_preempt_reason reason;
> -
> -	/* the task that's going to be scheduled on the CPU */
> -	struct task_struct	*task;
> -};
> -
> -/*
> - * Informational context provided to dump operations.
> - */
> -struct scx_dump_ctx {
> -	enum scx_exit_kind	kind;
> -	s64			exit_code;
> -	const char		*reason;
> -	u64			at_ns;
> -	u64			at_jiffies;
> -};
> -
> -/**
> - * struct sched_ext_ops - Operation table for BPF scheduler implementation
> - *
> - * A BPF scheduler can implement an arbitrary scheduling policy by
> - * implementing and loading operations in this table. Note that a userland
> - * scheduling policy can also be implemented using the BPF scheduler
> - * as a shim layer.
> - */
> -struct sched_ext_ops {
> -	/**
> -	 * @select_cpu: Pick the target CPU for a task which is being woken up
> -	 * @p: task being woken up
> -	 * @prev_cpu: the cpu @p was on before sleeping
> -	 * @wake_flags: SCX_WAKE_*
> -	 *
> -	 * Decision made here isn't final. @p may be moved to any CPU while it
> -	 * is getting dispatched for execution later. However, as @p is not on
> -	 * the rq at this point, getting the eventual execution CPU right here
> -	 * saves a small bit of overhead down the line.
> -	 *
> -	 * If an idle CPU is returned, the CPU is kicked and will try to
> -	 * dispatch. While an explicit custom mechanism can be added,
> -	 * select_cpu() serves as the default way to wake up idle CPUs.
> -	 *
> -	 * @p may be inserted into a DSQ directly by calling
> -	 * scx_bpf_dsq_insert(). If so, the ops.enqueue() will be skipped.
> -	 * Directly inserting into %SCX_DSQ_LOCAL will put @p in the local DSQ
> -	 * of the CPU returned by this operation.
> -	 *
> -	 * Note that select_cpu() is never called for tasks that can only run
> -	 * on a single CPU or tasks with migration disabled, as they don't have
> -	 * the option to select a different CPU. See select_task_rq() for
> -	 * details.
> -	 */
> -	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
> -
> -	/**
> -	 * @enqueue: Enqueue a task on the BPF scheduler
> -	 * @p: task being enqueued
> -	 * @enq_flags: %SCX_ENQ_*
> -	 *
> -	 * @p is ready to run. Insert directly into a DSQ by calling
> -	 * scx_bpf_dsq_insert() or enqueue on the BPF scheduler. If not directly
> -	 * inserted, the bpf scheduler owns @p and if it fails to dispatch @p,
> -	 * the task will stall.
> -	 *
> -	 * If @p was inserted into a DSQ from ops.select_cpu(), this callback is
> -	 * skipped.
> -	 */
> -	void (*enqueue)(struct task_struct *p, u64 enq_flags);
> -
> -	/**
> -	 * @dequeue: Remove a task from the BPF scheduler
> -	 * @p: task being dequeued
> -	 * @deq_flags: %SCX_DEQ_*
> -	 *
> -	 * Remove @p from the BPF scheduler. This is usually called to isolate
> -	 * the task while updating its scheduling properties (e.g. priority).
> -	 *
> -	 * The ext core keeps track of whether the BPF side owns a given task or
> -	 * not and can gracefully ignore spurious dispatches from BPF side,
> -	 * which makes it safe to not implement this method. However, depending
> -	 * on the scheduling logic, this can lead to confusing behaviors - e.g.
> -	 * scheduling position not being updated across a priority change.
> -	 */
> -	void (*dequeue)(struct task_struct *p, u64 deq_flags);
> -
> -	/**
> -	 * @dispatch: Dispatch tasks from the BPF scheduler and/or user DSQs
> -	 * @cpu: CPU to dispatch tasks for
> -	 * @prev: previous task being switched out
> -	 *
> -	 * Called when a CPU's local dsq is empty. The operation should dispatch
> -	 * one or more tasks from the BPF scheduler into the DSQs using
> -	 * scx_bpf_dsq_insert() and/or move from user DSQs into the local DSQ
> -	 * using scx_bpf_dsq_move_to_local().
> -	 *
> -	 * The maximum number of times scx_bpf_dsq_insert() can be called
> -	 * without an intervening scx_bpf_dsq_move_to_local() is specified by
> -	 * ops.dispatch_max_batch. See the comments on top of the two functions
> -	 * for more details.
> -	 *
> -	 * When not %NULL, @prev is an SCX task with its slice depleted. If
> -	 * @prev is still runnable as indicated by set %SCX_TASK_QUEUED in
> -	 * @prev->scx.flags, it is not enqueued yet and will be enqueued after
> -	 * ops.dispatch() returns. To keep executing @prev, return without
> -	 * dispatching or moving any tasks. Also see %SCX_OPS_ENQ_LAST.
> -	 */
> -	void (*dispatch)(s32 cpu, struct task_struct *prev);
> -
> -	/**
> -	 * @tick: Periodic tick
> -	 * @p: task running currently
> -	 *
> -	 * This operation is called every 1/HZ seconds on CPUs which are
> -	 * executing an SCX task. Setting @p->scx.slice to 0 will trigger an
> -	 * immediate dispatch cycle on the CPU.
> -	 */
> -	void (*tick)(struct task_struct *p);
> -
> -	/**
> -	 * @runnable: A task is becoming runnable on its associated CPU
> -	 * @p: task becoming runnable
> -	 * @enq_flags: %SCX_ENQ_*
> -	 *
> -	 * This and the following three functions can be used to track a task's
> -	 * execution state transitions. A task becomes ->runnable() on a CPU,
> -	 * and then goes through one or more ->running() and ->stopping() pairs
> -	 * as it runs on the CPU, and eventually becomes ->quiescent() when it's
> -	 * done running on the CPU.
> -	 *
> -	 * @p is becoming runnable on the CPU because it's
> -	 *
> -	 * - waking up (%SCX_ENQ_WAKEUP)
> -	 * - being moved from another CPU
> -	 * - being restored after temporarily taken off the queue for an
> -	 *   attribute change.
> -	 *
> -	 * This and ->enqueue() are related but not coupled. This operation
> -	 * notifies @p's state transition and may not be followed by ->enqueue()
> -	 * e.g. when @p is being dispatched to a remote CPU, or when @p is
> -	 * being enqueued on a CPU experiencing a hotplug event. Likewise, a
> -	 * task may be ->enqueue()'d without being preceded by this operation
> -	 * e.g. after exhausting its slice.
> -	 */
> -	void (*runnable)(struct task_struct *p, u64 enq_flags);
> -
> -	/**
> -	 * @running: A task is starting to run on its associated CPU
> -	 * @p: task starting to run
> -	 *
> -	 * Note that this callback may be called from a CPU other than the
> -	 * one the task is going to run on. This can happen when a task
> -	 * property is changed (i.e., affinity), since scx_next_task_scx(),
> -	 * which triggers this callback, may run on a CPU different from
> -	 * the task's assigned CPU.
> -	 *
> -	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
> -	 * target CPU the task is going to use.
> -	 *
> -	 * See ->runnable() for explanation on the task state notifiers.
> -	 */
> -	void (*running)(struct task_struct *p);
> -
> -	/**
> -	 * @stopping: A task is stopping execution
> -	 * @p: task stopping to run
> -	 * @runnable: is task @p still runnable?
> -	 *
> -	 * Note that this callback may be called from a CPU other than the
> -	 * one the task was running on. This can happen when a task
> -	 * property is changed (i.e., affinity), since dequeue_task_scx(),
> -	 * which triggers this callback, may run on a CPU different from
> -	 * the task's assigned CPU.
> -	 *
> -	 * Therefore, always use scx_bpf_task_cpu(@p) to retrieve the CPU
> -	 * the task was running on.
> -	 *
> -	 * See ->runnable() for explanation on the task state notifiers. If
> -	 * !@runnable, ->quiescent() will be invoked after this operation
> -	 * returns.
> -	 */
> -	void (*stopping)(struct task_struct *p, bool runnable);
> -
> -	/**
> -	 * @quiescent: A task is becoming not runnable on its associated CPU
> -	 * @p: task becoming not runnable
> -	 * @deq_flags: %SCX_DEQ_*
> -	 *
> -	 * See ->runnable() for explanation on the task state notifiers.
> -	 *
> -	 * @p is becoming quiescent on the CPU because it's
> -	 *
> -	 * - sleeping (%SCX_DEQ_SLEEP)
> -	 * - being moved to another CPU
> -	 * - being temporarily taken off the queue for an attribute change
> -	 *   (%SCX_DEQ_SAVE)
> -	 *
> -	 * This and ->dequeue() are related but not coupled. This operation
> -	 * notifies @p's state transition and may not be preceded by ->dequeue()
> -	 * e.g. when @p is being dispatched to a remote CPU.
> -	 */
> -	void (*quiescent)(struct task_struct *p, u64 deq_flags);
> -
> -	/**
> -	 * @yield: Yield CPU
> -	 * @from: yielding task
> -	 * @to: optional yield target task
> -	 *
> -	 * If @to is NULL, @from is yielding the CPU to other runnable tasks.
> -	 * The BPF scheduler should ensure that other available tasks are
> -	 * dispatched before the yielding task. Return value is ignored in this
> -	 * case.
> -	 *
> -	 * If @to is not-NULL, @from wants to yield the CPU to @to. If the bpf
> -	 * scheduler can implement the request, return %true; otherwise, %false.
> -	 */
> -	bool (*yield)(struct task_struct *from, struct task_struct *to);
> -
> -	/**
> -	 * @core_sched_before: Task ordering for core-sched
> -	 * @a: task A
> -	 * @b: task B
> -	 *
> -	 * Used by core-sched to determine the ordering between two tasks. See
> -	 * Documentation/admin-guide/hw-vuln/core-scheduling.rst for details on
> -	 * core-sched.
> -	 *
> -	 * Both @a and @b are runnable and may or may not currently be queued on
> -	 * the BPF scheduler. Should return %true if @a should run before @b.
> -	 * %false if there's no required ordering or @b should run before @a.
> -	 *
> -	 * If not specified, the default is ordering them according to when they
> -	 * became runnable.
> -	 */
> -	bool (*core_sched_before)(struct task_struct *a, struct task_struct *b);
> -
> -	/**
> -	 * @set_weight: Set task weight
> -	 * @p: task to set weight for
> -	 * @weight: new weight [1..10000]
> -	 *
> -	 * Update @p's weight to @weight.
> -	 */
> -	void (*set_weight)(struct task_struct *p, u32 weight);
> -
> -	/**
> -	 * @set_cpumask: Set CPU affinity
> -	 * @p: task to set CPU affinity for
> -	 * @cpumask: cpumask of cpus that @p can run on
> -	 *
> -	 * Update @p's CPU affinity to @cpumask.
> -	 */
> -	void (*set_cpumask)(struct task_struct *p,
> -			    const struct cpumask *cpumask);
> -
> -	/**
> -	 * @update_idle: Update the idle state of a CPU
> -	 * @cpu: CPU to update the idle state for
> -	 * @idle: whether entering or exiting the idle state
> -	 *
> -	 * This operation is called when @rq's CPU goes or leaves the idle
> -	 * state. By default, implementing this operation disables the built-in
> -	 * idle CPU tracking and the following helpers become unavailable:
> -	 *
> -	 * - scx_bpf_select_cpu_dfl()
> -	 * - scx_bpf_select_cpu_and()
> -	 * - scx_bpf_test_and_clear_cpu_idle()
> -	 * - scx_bpf_pick_idle_cpu()
> -	 *
> -	 * The user also must implement ops.select_cpu() as the default
> -	 * implementation relies on scx_bpf_select_cpu_dfl().
> -	 *
> -	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
> -	 * tracking.
> -	 */
> -	void (*update_idle)(s32 cpu, bool idle);
> -
> -	/**
> -	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
> -	 * @cpu: The CPU being acquired by the BPF scheduler.
> -	 * @args: Acquire arguments, see the struct definition.
> -	 *
> -	 * A CPU that was previously released from the BPF scheduler is now once
> -	 * again under its control.
> -	 */
> -	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
> -
> -	/**
> -	 * @cpu_release: A CPU is taken away from the BPF scheduler
> -	 * @cpu: The CPU being released by the BPF scheduler.
> -	 * @args: Release arguments, see the struct definition.
> -	 *
> -	 * The specified CPU is no longer under the control of the BPF
> -	 * scheduler. This could be because it was preempted by a higher
> -	 * priority sched_class, though there may be other reasons as well. The
> -	 * caller should consult @args->reason to determine the cause.
> -	 */
> -	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
> -
> -	/**
> -	 * @init_task: Initialize a task to run in a BPF scheduler
> -	 * @p: task to initialize for BPF scheduling
> -	 * @args: init arguments, see the struct definition
> -	 *
> -	 * Either we're loading a BPF scheduler or a new task is being forked.
> -	 * Initialize @p for BPF scheduling. This operation may block and can
> -	 * be used for allocations, and is called exactly once for a task.
> -	 *
> -	 * Return 0 for success, -errno for failure. An error return while
> -	 * loading will abort loading of the BPF scheduler. During a fork, it
> -	 * will abort that specific fork.
> -	 */
> -	s32 (*init_task)(struct task_struct *p, struct scx_init_task_args *args);
> -
> -	/**
> -	 * @exit_task: Exit a previously-running task from the system
> -	 * @p: task to exit
> -	 * @args: exit arguments, see the struct definition
> -	 *
> -	 * @p is exiting or the BPF scheduler is being unloaded. Perform any
> -	 * necessary cleanup for @p.
> -	 */
> -	void (*exit_task)(struct task_struct *p, struct scx_exit_task_args *args);
> -
> -	/**
> -	 * @enable: Enable BPF scheduling for a task
> -	 * @p: task to enable BPF scheduling for
> -	 *
> -	 * Enable @p for BPF scheduling. enable() is called on @p any time it
> -	 * enters SCX, and is always paired with a matching disable().
> -	 */
> -	void (*enable)(struct task_struct *p);
> -
> -	/**
> -	 * @disable: Disable BPF scheduling for a task
> -	 * @p: task to disable BPF scheduling for
> -	 *
> -	 * @p is exiting, leaving SCX or the BPF scheduler is being unloaded.
> -	 * Disable BPF scheduling for @p. A disable() call is always matched
> -	 * with a prior enable() call.
> -	 */
> -	void (*disable)(struct task_struct *p);
> -
> -	/**
> -	 * @dump: Dump BPF scheduler state on error
> -	 * @ctx: debug dump context
> -	 *
> -	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump.
> -	 */
> -	void (*dump)(struct scx_dump_ctx *ctx);
> -
> -	/**
> -	 * @dump_cpu: Dump BPF scheduler state for a CPU on error
> -	 * @ctx: debug dump context
> -	 * @cpu: CPU to generate debug dump for
> -	 * @idle: @cpu is currently idle without any runnable tasks
> -	 *
> -	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
> -	 * @cpu. If @idle is %true and this operation doesn't produce any
> -	 * output, @cpu is skipped for dump.
> -	 */
> -	void (*dump_cpu)(struct scx_dump_ctx *ctx, s32 cpu, bool idle);
> -
> -	/**
> -	 * @dump_task: Dump BPF scheduler state for a runnable task on error
> -	 * @ctx: debug dump context
> -	 * @p: runnable task to generate debug dump for
> -	 *
> -	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
> -	 * @p.
> -	 */
> -	void (*dump_task)(struct scx_dump_ctx *ctx, struct task_struct *p);
> -
> -#ifdef CONFIG_EXT_GROUP_SCHED
> -	/**
> -	 * @cgroup_init: Initialize a cgroup
> -	 * @cgrp: cgroup being initialized
> -	 * @args: init arguments, see the struct definition
> -	 *
> -	 * Either the BPF scheduler is being loaded or @cgrp created, initialize
> -	 * @cgrp for sched_ext. This operation may block.
> -	 *
> -	 * Return 0 for success, -errno for failure. An error return while
> -	 * loading will abort loading of the BPF scheduler. During cgroup
> -	 * creation, it will abort the specific cgroup creation.
> -	 */
> -	s32 (*cgroup_init)(struct cgroup *cgrp,
> -			   struct scx_cgroup_init_args *args);
> -
> -	/**
> -	 * @cgroup_exit: Exit a cgroup
> -	 * @cgrp: cgroup being exited
> -	 *
> -	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
> -	 * @cgrp for sched_ext. This operation my block.
> -	 */
> -	void (*cgroup_exit)(struct cgroup *cgrp);
> -
> -	/**
> -	 * @cgroup_prep_move: Prepare a task to be moved to a different cgroup
> -	 * @p: task being moved
> -	 * @from: cgroup @p is being moved from
> -	 * @to: cgroup @p is being moved to
> -	 *
> -	 * Prepare @p for move from cgroup @from to @to. This operation may
> -	 * block and can be used for allocations.
> -	 *
> -	 * Return 0 for success, -errno for failure. An error return aborts the
> -	 * migration.
> -	 */
> -	s32 (*cgroup_prep_move)(struct task_struct *p,
> -				struct cgroup *from, struct cgroup *to);
> -
> -	/**
> -	 * @cgroup_move: Commit cgroup move
> -	 * @p: task being moved
> -	 * @from: cgroup @p is being moved from
> -	 * @to: cgroup @p is being moved to
> -	 *
> -	 * Commit the move. @p is dequeued during this operation.
> -	 */
> -	void (*cgroup_move)(struct task_struct *p,
> -			    struct cgroup *from, struct cgroup *to);
> -
> -	/**
> -	 * @cgroup_cancel_move: Cancel cgroup move
> -	 * @p: task whose cgroup move is being canceled
> -	 * @from: cgroup @p was being moved from
> -	 * @to: cgroup @p was being moved to
> -	 *
> -	 * @p was cgroup_prep_move()'d but failed before reaching cgroup_move().
> -	 * Undo the preparation.
> -	 */
> -	void (*cgroup_cancel_move)(struct task_struct *p,
> -				   struct cgroup *from, struct cgroup *to);
> -
> -	/**
> -	 * @cgroup_set_weight: A cgroup's weight is being changed
> -	 * @cgrp: cgroup whose weight is being updated
> -	 * @weight: new weight [1..10000]
> -	 *
> -	 * Update @cgrp's weight to @weight.
> -	 */
> -	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
> -
> -	/**
> -	 * @cgroup_set_bandwidth: A cgroup's bandwidth is being changed
> -	 * @cgrp: cgroup whose bandwidth is being updated
> -	 * @period_us: bandwidth control period
> -	 * @quota_us: bandwidth control quota
> -	 * @burst_us: bandwidth control burst
> -	 *
> -	 * Update @cgrp's bandwidth control parameters. This is from the cpu.max
> -	 * cgroup interface.
> -	 *
> -	 * @quota_us / @period_us determines the CPU bandwidth @cgrp is entitled
> -	 * to. For example, if @period_us is 1_000_000 and @quota_us is
> -	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
> -	 * interpreted in the same fashion and specifies how much @cgrp can
> -	 * burst temporarily. The specific control mechanism and thus the
> -	 * interpretation of @period_us and burstiness is upto to the BPF
> -	 * scheduler.
> -	 */
> -	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
> -				     u64 period_us, u64 quota_us, u64 burst_us);
> -
> -#endif	/* CONFIG_EXT_GROUP_SCHED */
> -
> -	/*
> -	 * All online ops must come before ops.cpu_online().
> -	 */
> -
> -	/**
> -	 * @cpu_online: A CPU became online
> -	 * @cpu: CPU which just came up
> -	 *
> -	 * @cpu just came online. @cpu will not call ops.enqueue() or
> -	 * ops.dispatch(), nor run tasks associated with other CPUs beforehand.
> -	 */
> -	void (*cpu_online)(s32 cpu);
> -
> -	/**
> -	 * @cpu_offline: A CPU is going offline
> -	 * @cpu: CPU which is going offline
> -	 *
> -	 * @cpu is going offline. @cpu will not call ops.enqueue() or
> -	 * ops.dispatch(), nor run tasks associated with other CPUs afterwards.
> -	 */
> -	void (*cpu_offline)(s32 cpu);
> -
> -	/*
> -	 * All CPU hotplug ops must come before ops.init().
> -	 */
> -
> -	/**
> -	 * @init: Initialize the BPF scheduler
> -	 */
> -	s32 (*init)(void);
> -
> -	/**
> -	 * @exit: Clean up after the BPF scheduler
> -	 * @info: Exit info
> -	 *
> -	 * ops.exit() is also called on ops.init() failure, which is a bit
> -	 * unusual. This is to allow rich reporting through @info on how
> -	 * ops.init() failed.
> -	 */
> -	void (*exit)(struct scx_exit_info *info);
> -
> -	/**
> -	 * @dispatch_max_batch: Max nr of tasks that dispatch() can dispatch
> -	 */
> -	u32 dispatch_max_batch;
> -
> -	/**
> -	 * @flags: %SCX_OPS_* flags
> -	 */
> -	u64 flags;
> -
> -	/**
> -	 * @timeout_ms: The maximum amount of time, in milliseconds, that a
> -	 * runnable task should be able to wait before being scheduled. The
> -	 * maximum timeout may not exceed the default timeout of 30 seconds.
> -	 *
> -	 * Defaults to the maximum allowed timeout value of 30 seconds.
> -	 */
> -	u32 timeout_ms;
> -
> -	/**
> -	 * @exit_dump_len: scx_exit_info.dump buffer length. If 0, the default
> -	 * value of 32768 is used.
> -	 */
> -	u32 exit_dump_len;
> -
> -	/**
> -	 * @hotplug_seq: A sequence number that may be set by the scheduler to
> -	 * detect when a hotplug event has occurred during the loading process.
> -	 * If 0, no detection occurs. Otherwise, the scheduler will fail to
> -	 * load if the sequence number does not match @scx_hotplug_seq on the
> -	 * enable path.
> -	 */
> -	u64 hotplug_seq;
> -
> -	/**
> -	 * @name: BPF scheduler's name
> -	 *
> -	 * Must be a non-zero valid BPF object name including only isalnum(),
> -	 * '_' and '.' chars. Shows up in kernel.sched_ext_ops sysctl while the
> -	 * BPF scheduler is enabled.
> -	 */
> -	char name[SCX_OPS_NAME_LEN];
> -
> -	/* internal use only, must be NULL */
> -	void *priv;
> -};
> -
> -enum scx_opi {
> -	SCX_OPI_BEGIN			= 0,
> -	SCX_OPI_NORMAL_BEGIN		= 0,
> -	SCX_OPI_NORMAL_END		= SCX_OP_IDX(cpu_online),
> -	SCX_OPI_CPU_HOTPLUG_BEGIN	= SCX_OP_IDX(cpu_online),
> -	SCX_OPI_CPU_HOTPLUG_END		= SCX_OP_IDX(init),
> -	SCX_OPI_END			= SCX_OP_IDX(init),
> -};
> -
> -/*
> - * Collection of event counters. Event types are placed in descending order.
> - */
> -struct scx_event_stats {
> -	/*
> -	 * If ops.select_cpu() returns a CPU which can't be used by the task,
> -	 * the core scheduler code silently picks a fallback CPU.
> -	 */
> -	s64		SCX_EV_SELECT_CPU_FALLBACK;
> -
> -	/*
> -	 * When dispatching to a local DSQ, the CPU may have gone offline in
> -	 * the meantime. In this case, the task is bounced to the global DSQ.
> -	 */
> -	s64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
> -
> -	/*
> -	 * If SCX_OPS_ENQ_LAST is not set, the number of times that a task
> -	 * continued to run because there were no other tasks on the CPU.
> -	 */
> -	s64		SCX_EV_DISPATCH_KEEP_LAST;
> -
> -	/*
> -	 * If SCX_OPS_ENQ_EXITING is not set, the number of times that a task
> -	 * is dispatched to a local DSQ when exiting.
> -	 */
> -	s64		SCX_EV_ENQ_SKIP_EXITING;
> -
> -	/*
> -	 * If SCX_OPS_ENQ_MIGRATION_DISABLED is not set, the number of times a
> -	 * migration disabled task skips ops.enqueue() and is dispatched to its
> -	 * local DSQ.
> -	 */
> -	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
> -
> -	/*
> -	 * Total number of times a task's time slice was refilled with the
> -	 * default value (SCX_SLICE_DFL).
> -	 */
> -	s64		SCX_EV_REFILL_SLICE_DFL;
> -
> -	/*
> -	 * The total duration of bypass modes in nanoseconds.
> -	 */
> -	s64		SCX_EV_BYPASS_DURATION;
> -
> -	/*
> -	 * The number of tasks dispatched in the bypassing mode.
> -	 */
> -	s64		SCX_EV_BYPASS_DISPATCH;
> -
> -	/*
> -	 * The number of times the bypassing mode has been activated.
> -	 */
> -	s64		SCX_EV_BYPASS_ACTIVATE;
> -};
> -
> -struct scx_sched {
> -	struct sched_ext_ops	ops;
> -	DECLARE_BITMAP(has_op, SCX_OPI_END);
> -
> -	/*
> -	 * Dispatch queues.
> -	 *
> -	 * The global DSQ (%SCX_DSQ_GLOBAL) is split per-node for scalability.
> -	 * This is to avoid live-locking in bypass mode where all tasks are
> -	 * dispatched to %SCX_DSQ_GLOBAL and all CPUs consume from it. If
> -	 * per-node split isn't sufficient, it can be further split.
> -	 */
> -	struct rhashtable	dsq_hash;
> -	struct scx_dispatch_q	**global_dsqs;
> -
> -	/*
> -	 * The event counters are in a per-CPU variable to minimize the
> -	 * accounting overhead. A system-wide view on the event counter is
> -	 * constructed when requested by scx_bpf_events().
> -	 */
> -	struct scx_event_stats __percpu *event_stats_cpu;
> -
> -	bool			warned_zero_slice;
> -
> -	atomic_t		exit_kind;
> -	struct scx_exit_info	*exit_info;
> -
> -	struct kobject		kobj;
> -
> -	struct kthread_worker	*helper;
> -	struct irq_work		error_irq_work;
> -	struct kthread_work	disable_work;
> -	struct rcu_work		rcu_work;
> -};
> -
> -enum scx_wake_flags {
> -	/* expose select WF_* flags as enums */
> -	SCX_WAKE_FORK		= WF_FORK,
> -	SCX_WAKE_TTWU		= WF_TTWU,
> -	SCX_WAKE_SYNC		= WF_SYNC,
> -};
> -
> -enum scx_enq_flags {
> -	/* expose select ENQUEUE_* flags as enums */
> -	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
> -	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
> -	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
> -
> -	/* high 32bits are SCX specific */
> -
> -	/*
> -	 * Set the following to trigger preemption when calling
> -	 * scx_bpf_dsq_insert() with a local dsq as the target. The slice of the
> -	 * current task is cleared to zero and the CPU is kicked into the
> -	 * scheduling path. Implies %SCX_ENQ_HEAD.
> -	 */
> -	SCX_ENQ_PREEMPT		= 1LLU << 32,
> -
> -	/*
> -	 * The task being enqueued was previously enqueued on the current CPU's
> -	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
> -	 * scx_bpf_reenqueue_local() kfunc. If scx_bpf_reenqueue_local() was
> -	 * invoked in a ->cpu_release() callback, and the task is again
> -	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
> -	 * task will not be scheduled on the CPU until at least the next invocation
> -	 * of the ->cpu_acquire() callback.
> -	 */
> -	SCX_ENQ_REENQ		= 1LLU << 40,
> -
> -	/*
> -	 * The task being enqueued is the only task available for the cpu. By
> -	 * default, ext core keeps executing such tasks but when
> -	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
> -	 * %SCX_ENQ_LAST flag set.
> -	 *
> -	 * The BPF scheduler is responsible for triggering a follow-up
> -	 * scheduling event. Otherwise, Execution may stall.
> -	 */
> -	SCX_ENQ_LAST		= 1LLU << 41,
> -
> -	/* high 8 bits are internal */
> -	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
> -
> -	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
> -	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
> -};
> -
> -enum scx_deq_flags {
> -	/* expose select DEQUEUE_* flags as enums */
> -	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
> -
> -	/* high 32bits are SCX specific */
> -
> -	/*
> -	 * The generic core-sched layer decided to execute the task even though
> -	 * it hasn't been dispatched yet. Dequeue from the BPF side.
> -	 */
> -	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
> -};
> -
> -enum scx_pick_idle_cpu_flags {
> -	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> -	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> -};
> -
> -enum scx_kick_flags {
> -	/*
> -	 * Kick the target CPU if idle. Guarantees that the target CPU goes
> -	 * through at least one full scheduling cycle before going idle. If the
> -	 * target CPU can be determined to be currently not idle and going to go
> -	 * through a scheduling cycle before going idle, noop.
> -	 */
> -	SCX_KICK_IDLE		= 1LLU << 0,
> -
> -	/*
> -	 * Preempt the current task and execute the dispatch path. If the
> -	 * current task of the target CPU is an SCX task, its ->scx.slice is
> -	 * cleared to zero before the scheduling path is invoked so that the
> -	 * task expires and the dispatch path is invoked.
> -	 */
> -	SCX_KICK_PREEMPT	= 1LLU << 1,
> -
> -	/*
> -	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
> -	 * return after the target CPU finishes picking the next task.
> -	 */
> -	SCX_KICK_WAIT		= 1LLU << 2,
> -};
> -
> -enum scx_tg_flags {
> -	SCX_TG_ONLINE		= 1U << 0,
> -	SCX_TG_INITED		= 1U << 1,
> -};
> -
> -enum scx_enable_state {
> -	SCX_ENABLING,
> -	SCX_ENABLED,
> -	SCX_DISABLING,
> -	SCX_DISABLED,
> -};
> -
> -static const char *scx_enable_state_str[] = {
> -	[SCX_ENABLING]		= "enabling",
> -	[SCX_ENABLED]		= "enabled",
> -	[SCX_DISABLING]		= "disabling",
> -	[SCX_DISABLED]		= "disabled",
> -};
> -
> -/*
> - * sched_ext_entity->ops_state
> - *
> - * Used to track the task ownership between the SCX core and the BPF scheduler.
> - * State transitions look as follows:
> - *
> - * NONE -> QUEUEING -> QUEUED -> DISPATCHING
> - *   ^              |                 |
> - *   |              v                 v
> - *   \-------------------------------/
> - *
> - * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
> - * sites for explanations on the conditions being waited upon and why they are
> - * safe. Transitions out of them into NONE or QUEUED must store_release and the
> - * waiters should load_acquire.
> - *
> - * Tracking scx_ops_state enables sched_ext core to reliably determine whether
> - * any given task can be dispatched by the BPF scheduler at all times and thus
> - * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
> - * to try to dispatch any task anytime regardless of its state as the SCX core
> - * can safely reject invalid dispatches.
> - */
> -enum scx_ops_state {
> -	SCX_OPSS_NONE,		/* owned by the SCX core */
> -	SCX_OPSS_QUEUEING,	/* in transit to the BPF scheduler */
> -	SCX_OPSS_QUEUED,	/* owned by the BPF scheduler */
> -	SCX_OPSS_DISPATCHING,	/* in transit back to the SCX core */
> -
> -	/*
> -	 * QSEQ brands each QUEUED instance so that, when dispatch races
> -	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
> -	 * on the task being dispatched.
> -	 *
> -	 * As some 32bit archs can't do 64bit store_release/load_acquire,
> -	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
> -	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
> -	 * and runs with IRQ disabled. 30 bits should be sufficient.
> -	 */
> -	SCX_OPSS_QSEQ_SHIFT	= 2,
> -};
> -
> -/* Use macros to ensure that the type is unsigned long for the masks */
> -#define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
> -#define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
> -
>  /*
>   * NOTE: sched_ext is in the process of growing multiple scheduler support and
>   * scx_root usage is in a transitional state. Naked dereferences are safe if the
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
> index 292bb41a242e..33858607bc97 100644
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -8,29 +8,6 @@
>   */
>  #ifdef CONFIG_SCHED_CLASS_EXT
>  
> -static inline bool scx_kf_allowed_if_unlocked(void)
> -{
> -	return !current->scx.kf_mask;
> -}
> -
> -static inline bool scx_rq_bypassing(struct rq *rq)
> -{
> -	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
> -}
> -
> -DECLARE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
> -
> -DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
> -
> -/*
> - * Return the rq currently locked from an scx callback, or NULL if no rq is
> - * locked.
> - */
> -static inline struct rq *scx_locked_rq(void)
> -{
> -	return __this_cpu_read(scx_locked_rq_state);
> -}
> -
>  void scx_tick(struct rq *rq);
>  void init_scx_entity(struct sched_ext_entity *scx);
>  void scx_pre_fork(struct task_struct *p);
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> new file mode 100644
> index 000000000000..76690ede8700
> --- /dev/null
> +++ b/kernel/sched/ext_internal.h
> @@ -0,0 +1,1061 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
> + *
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
> + */
> +#define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
> +
> +enum scx_consts {
> +	SCX_DSP_DFL_MAX_BATCH		= 32,
> +	SCX_DSP_MAX_LOOPS		= 32,
> +	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
> +
> +	SCX_EXIT_BT_LEN			= 64,
> +	SCX_EXIT_MSG_LEN		= 1024,
> +	SCX_EXIT_DUMP_DFL_LEN		= 32768,
> +
> +	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
> +
> +	/*
> +	 * Iterating all tasks may take a while. Periodically drop
> +	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
> +	 */
> +	SCX_TASK_ITER_BATCH		= 32,
> +};
> +
> +enum scx_exit_kind {
> +	SCX_EXIT_NONE,
> +	SCX_EXIT_DONE,
> +
> +	SCX_EXIT_UNREG = 64,	/* user-space initiated unregistration */
> +	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
> +	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
> +	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
> +
> +	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
> +	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
> +	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
> +};
> +
> +/*
> + * An exit code can be specified when exiting with scx_bpf_exit() or scx_exit(),
> + * corresponding to exit_kind UNREG_BPF and UNREG_KERN respectively. The codes
> + * are 64bit of the format:
> + *
> + *   Bits: [63  ..  48 47   ..  32 31 .. 0]
> + *         [ SYS ACT ] [ SYS RSN ] [ USR  ]
> + *
> + *   SYS ACT: System-defined exit actions
> + *   SYS RSN: System-defined exit reasons
> + *   USR    : User-defined exit codes and reasons
> + *
> + * Using the above, users may communicate intention and context by ORing system
> + * actions and/or system reasons with a user-defined exit code.
> + */
> +enum scx_exit_code {
> +	/* Reasons */
> +	SCX_ECODE_RSN_HOTPLUG	= 1LLU << 32,
> +
> +	/* Actions */
> +	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
> +};
> +
> +/*
> + * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
> + * being disabled.
> + */
> +struct scx_exit_info {
> +	/* %SCX_EXIT_* - broad category of the exit reason */
> +	enum scx_exit_kind	kind;
> +
> +	/* exit code if gracefully exiting */
> +	s64			exit_code;
> +
> +	/* textual representation of the above */
> +	const char		*reason;
> +
> +	/* backtrace if exiting due to an error */
> +	unsigned long		*bt;
> +	u32			bt_len;
> +
> +	/* informational message */
> +	char			*msg;
> +
> +	/* debug dump */
> +	char			*dump;
> +};
> +
> +/* sched_ext_ops.flags */
> +enum scx_ops_flags {
> +	/*
> +	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
> +	 */
> +	SCX_OPS_KEEP_BUILTIN_IDLE	= 1LLU << 0,
> +
> +	/*
> +	 * By default, if there are no other task to run on the CPU, ext core
> +	 * keeps running the current task even after its slice expires. If this
> +	 * flag is specified, such tasks are passed to ops.enqueue() with
> +	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
> +	 */
> +	SCX_OPS_ENQ_LAST		= 1LLU << 1,
> +
> +	/*
> +	 * An exiting task may schedule after PF_EXITING is set. In such cases,
> +	 * bpf_task_from_pid() may not be able to find the task and if the BPF
> +	 * scheduler depends on pid lookup for dispatching, the task will be
> +	 * lost leading to various issues including RCU grace period stalls.
> +	 *
> +	 * To mask this problem, by default, unhashed tasks are automatically
> +	 * dispatched to the local DSQ on enqueue. If the BPF scheduler doesn't
> +	 * depend on pid lookups and wants to handle these tasks directly, the
> +	 * following flag can be used.
> +	 */
> +	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
> +
> +	/*
> +	 * If set, only tasks with policy set to SCHED_EXT are attached to
> +	 * sched_ext. If clear, SCHED_NORMAL tasks are also included.
> +	 */
> +	SCX_OPS_SWITCH_PARTIAL		= 1LLU << 3,
> +
> +	/*
> +	 * A migration disabled task can only execute on its current CPU. By
> +	 * default, such tasks are automatically put on the CPU's local DSQ with
> +	 * the default slice on enqueue. If this ops flag is set, they also go
> +	 * through ops.enqueue().
> +	 *
> +	 * A migration disabled task never invokes ops.select_cpu() as it can
> +	 * only select the current CPU. Also, p->cpus_ptr will only contain its
> +	 * current CPU while p->nr_cpus_allowed keeps tracking p->user_cpus_ptr
> +	 * and thus may disagree with cpumask_weight(p->cpus_ptr).
> +	 */
> +	SCX_OPS_ENQ_MIGRATION_DISABLED	= 1LLU << 4,
> +
> +	/*
> +	 * Queued wakeup (ttwu_queue) is a wakeup optimization that invokes
> +	 * ops.enqueue() on the ops.select_cpu() selected or the wakee's
> +	 * previous CPU via IPI (inter-processor interrupt) to reduce cacheline
> +	 * transfers. When this optimization is enabled, ops.select_cpu() is
> +	 * skipped in some cases (when racing against the wakee switching out).
> +	 * As the BPF scheduler may depend on ops.select_cpu() being invoked
> +	 * during wakeups, queued wakeup is disabled by default.
> +	 *
> +	 * If this ops flag is set, queued wakeup optimization is enabled and
> +	 * the BPF scheduler must be able to handle ops.enqueue() invoked on the
> +	 * wakee's CPU without preceding ops.select_cpu() even for tasks which
> +	 * may be executed on multiple CPUs.
> +	 */
> +	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
> +
> +	/*
> +	 * If set, enable per-node idle cpumasks. If clear, use a single global
> +	 * flat idle cpumask.
> +	 */
> +	SCX_OPS_BUILTIN_IDLE_PER_NODE	= 1LLU << 6,
> +
> +	/*
> +	 * CPU cgroup support flags
> +	 */
> +	SCX_OPS_HAS_CGROUP_WEIGHT	= 1LLU << 16,	/* DEPRECATED, will be removed on 6.18 */
> +
> +	SCX_OPS_ALL_FLAGS		= SCX_OPS_KEEP_BUILTIN_IDLE |
> +					  SCX_OPS_ENQ_LAST |
> +					  SCX_OPS_ENQ_EXITING |
> +					  SCX_OPS_ENQ_MIGRATION_DISABLED |
> +					  SCX_OPS_ALLOW_QUEUED_WAKEUP |
> +					  SCX_OPS_SWITCH_PARTIAL |
> +					  SCX_OPS_BUILTIN_IDLE_PER_NODE |
> +					  SCX_OPS_HAS_CGROUP_WEIGHT,
> +
> +	/* high 8 bits are internal, don't include in SCX_OPS_ALL_FLAGS */
> +	__SCX_OPS_INTERNAL_MASK		= 0xffLLU << 56,
> +
> +	SCX_OPS_HAS_CPU_PREEMPT		= 1LLU << 56,
> +};
> +
> +/* argument container for ops.init_task() */
> +struct scx_init_task_args {
> +	/*
> +	 * Set if ops.init_task() is being invoked on the fork path, as opposed
> +	 * to the scheduler transition path.
> +	 */
> +	bool			fork;
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +	/* the cgroup the task is joining */
> +	struct cgroup		*cgroup;
> +#endif
> +};
> +
> +/* argument container for ops.exit_task() */
> +struct scx_exit_task_args {
> +	/* Whether the task exited before running on sched_ext. */
> +	bool cancelled;
> +};
> +
> +/* argument container for ops->cgroup_init() */
> +struct scx_cgroup_init_args {
> +	/* the weight of the cgroup [1..10000] */
> +	u32			weight;
> +
> +	/* bandwidth control parameters from cpu.max and cpu.max.burst */
> +	u64			bw_period_us;
> +	u64			bw_quota_us;
> +	u64			bw_burst_us;
> +};
> +
> +enum scx_cpu_preempt_reason {
> +	/* next task is being scheduled by &sched_class_rt */
> +	SCX_CPU_PREEMPT_RT,
> +	/* next task is being scheduled by &sched_class_dl */
> +	SCX_CPU_PREEMPT_DL,
> +	/* next task is being scheduled by &sched_class_stop */
> +	SCX_CPU_PREEMPT_STOP,
> +	/* unknown reason for SCX being preempted */
> +	SCX_CPU_PREEMPT_UNKNOWN,
> +};
> +
> +/*
> + * Argument container for ops->cpu_acquire(). Currently empty, but may be
> + * expanded in the future.
> + */
> +struct scx_cpu_acquire_args {};
> +
> +/* argument container for ops->cpu_release() */
> +struct scx_cpu_release_args {
> +	/* the reason the CPU was preempted */
> +	enum scx_cpu_preempt_reason reason;
> +
> +	/* the task that's going to be scheduled on the CPU */
> +	struct task_struct	*task;
> +};
> +
> +/*
> + * Informational context provided to dump operations.
> + */
> +struct scx_dump_ctx {
> +	enum scx_exit_kind	kind;
> +	s64			exit_code;
> +	const char		*reason;
> +	u64			at_ns;
> +	u64			at_jiffies;
> +};
> +
> +/**
> + * struct sched_ext_ops - Operation table for BPF scheduler implementation
> + *
> + * A BPF scheduler can implement an arbitrary scheduling policy by
> + * implementing and loading operations in this table. Note that a userland
> + * scheduling policy can also be implemented using the BPF scheduler
> + * as a shim layer.
> + */
> +struct sched_ext_ops {
> +	/**
> +	 * @select_cpu: Pick the target CPU for a task which is being woken up
> +	 * @p: task being woken up
> +	 * @prev_cpu: the cpu @p was on before sleeping
> +	 * @wake_flags: SCX_WAKE_*
> +	 *
> +	 * Decision made here isn't final. @p may be moved to any CPU while it
> +	 * is getting dispatched for execution later. However, as @p is not on
> +	 * the rq at this point, getting the eventual execution CPU right here
> +	 * saves a small bit of overhead down the line.
> +	 *
> +	 * If an idle CPU is returned, the CPU is kicked and will try to
> +	 * dispatch. While an explicit custom mechanism can be added,
> +	 * select_cpu() serves as the default way to wake up idle CPUs.
> +	 *
> +	 * @p may be inserted into a DSQ directly by calling
> +	 * scx_bpf_dsq_insert(). If so, the ops.enqueue() will be skipped.
> +	 * Directly inserting into %SCX_DSQ_LOCAL will put @p in the local DSQ
> +	 * of the CPU returned by this operation.
> +	 *
> +	 * Note that select_cpu() is never called for tasks that can only run
> +	 * on a single CPU or tasks with migration disabled, as they don't have
> +	 * the option to select a different CPU. See select_task_rq() for
> +	 * details.
> +	 */
> +	s32 (*select_cpu)(struct task_struct *p, s32 prev_cpu, u64 wake_flags);
> +
> +	/**
> +	 * @enqueue: Enqueue a task on the BPF scheduler
> +	 * @p: task being enqueued
> +	 * @enq_flags: %SCX_ENQ_*
> +	 *
> +	 * @p is ready to run. Insert directly into a DSQ by calling
> +	 * scx_bpf_dsq_insert() or enqueue on the BPF scheduler. If not directly
> +	 * inserted, the bpf scheduler owns @p and if it fails to dispatch @p,
> +	 * the task will stall.
> +	 *
> +	 * If @p was inserted into a DSQ from ops.select_cpu(), this callback is
> +	 * skipped.
> +	 */
> +	void (*enqueue)(struct task_struct *p, u64 enq_flags);
> +
> +	/**
> +	 * @dequeue: Remove a task from the BPF scheduler
> +	 * @p: task being dequeued
> +	 * @deq_flags: %SCX_DEQ_*
> +	 *
> +	 * Remove @p from the BPF scheduler. This is usually called to isolate
> +	 * the task while updating its scheduling properties (e.g. priority).
> +	 *
> +	 * The ext core keeps track of whether the BPF side owns a given task or
> +	 * not and can gracefully ignore spurious dispatches from BPF side,
> +	 * which makes it safe to not implement this method. However, depending
> +	 * on the scheduling logic, this can lead to confusing behaviors - e.g.
> +	 * scheduling position not being updated across a priority change.
> +	 */
> +	void (*dequeue)(struct task_struct *p, u64 deq_flags);
> +
> +	/**
> +	 * @dispatch: Dispatch tasks from the BPF scheduler and/or user DSQs
> +	 * @cpu: CPU to dispatch tasks for
> +	 * @prev: previous task being switched out
> +	 *
> +	 * Called when a CPU's local dsq is empty. The operation should dispatch
> +	 * one or more tasks from the BPF scheduler into the DSQs using
> +	 * scx_bpf_dsq_insert() and/or move from user DSQs into the local DSQ
> +	 * using scx_bpf_dsq_move_to_local().
> +	 *
> +	 * The maximum number of times scx_bpf_dsq_insert() can be called
> +	 * without an intervening scx_bpf_dsq_move_to_local() is specified by
> +	 * ops.dispatch_max_batch. See the comments on top of the two functions
> +	 * for more details.
> +	 *
> +	 * When not %NULL, @prev is an SCX task with its slice depleted. If
> +	 * @prev is still runnable as indicated by set %SCX_TASK_QUEUED in
> +	 * @prev->scx.flags, it is not enqueued yet and will be enqueued after
> +	 * ops.dispatch() returns. To keep executing @prev, return without
> +	 * dispatching or moving any tasks. Also see %SCX_OPS_ENQ_LAST.
> +	 */
> +	void (*dispatch)(s32 cpu, struct task_struct *prev);
> +
> +	/**
> +	 * @tick: Periodic tick
> +	 * @p: task running currently
> +	 *
> +	 * This operation is called every 1/HZ seconds on CPUs which are
> +	 * executing an SCX task. Setting @p->scx.slice to 0 will trigger an
> +	 * immediate dispatch cycle on the CPU.
> +	 */
> +	void (*tick)(struct task_struct *p);
> +
> +	/**
> +	 * @runnable: A task is becoming runnable on its associated CPU
> +	 * @p: task becoming runnable
> +	 * @enq_flags: %SCX_ENQ_*
> +	 *
> +	 * This and the following three functions can be used to track a task's
> +	 * execution state transitions. A task becomes ->runnable() on a CPU,
> +	 * and then goes through one or more ->running() and ->stopping() pairs
> +	 * as it runs on the CPU, and eventually becomes ->quiescent() when it's
> +	 * done running on the CPU.
> +	 *
> +	 * @p is becoming runnable on the CPU because it's
> +	 *
> +	 * - waking up (%SCX_ENQ_WAKEUP)
> +	 * - being moved from another CPU
> +	 * - being restored after temporarily taken off the queue for an
> +	 *   attribute change.
> +	 *
> +	 * This and ->enqueue() are related but not coupled. This operation
> +	 * notifies @p's state transition and may not be followed by ->enqueue()
> +	 * e.g. when @p is being dispatched to a remote CPU, or when @p is
> +	 * being enqueued on a CPU experiencing a hotplug event. Likewise, a
> +	 * task may be ->enqueue()'d without being preceded by this operation
> +	 * e.g. after exhausting its slice.
> +	 */
> +	void (*runnable)(struct task_struct *p, u64 enq_flags);
> +
> +	/**
> +	 * @running: A task is starting to run on its associated CPU
> +	 * @p: task starting to run
> +	 *
> +	 * Note that this callback may be called from a CPU other than the
> +	 * one the task is going to run on. This can happen when a task
> +	 * property is changed (i.e., affinity), since scx_next_task_scx(),
> +	 * which triggers this callback, may run on a CPU different from
> +	 * the task's assigned CPU.
> +	 *
> +	 * Therefore, always use scx_bpf_task_cpu(@p) to determine the
> +	 * target CPU the task is going to use.
> +	 *
> +	 * See ->runnable() for explanation on the task state notifiers.
> +	 */
> +	void (*running)(struct task_struct *p);
> +
> +	/**
> +	 * @stopping: A task is stopping execution
> +	 * @p: task stopping to run
> +	 * @runnable: is task @p still runnable?
> +	 *
> +	 * Note that this callback may be called from a CPU other than the
> +	 * one the task was running on. This can happen when a task
> +	 * property is changed (i.e., affinity), since dequeue_task_scx(),
> +	 * which triggers this callback, may run on a CPU different from
> +	 * the task's assigned CPU.
> +	 *
> +	 * Therefore, always use scx_bpf_task_cpu(@p) to retrieve the CPU
> +	 * the task was running on.
> +	 *
> +	 * See ->runnable() for explanation on the task state notifiers. If
> +	 * !@runnable, ->quiescent() will be invoked after this operation
> +	 * returns.
> +	 */
> +	void (*stopping)(struct task_struct *p, bool runnable);
> +
> +	/**
> +	 * @quiescent: A task is becoming not runnable on its associated CPU
> +	 * @p: task becoming not runnable
> +	 * @deq_flags: %SCX_DEQ_*
> +	 *
> +	 * See ->runnable() for explanation on the task state notifiers.
> +	 *
> +	 * @p is becoming quiescent on the CPU because it's
> +	 *
> +	 * - sleeping (%SCX_DEQ_SLEEP)
> +	 * - being moved to another CPU
> +	 * - being temporarily taken off the queue for an attribute change
> +	 *   (%SCX_DEQ_SAVE)
> +	 *
> +	 * This and ->dequeue() are related but not coupled. This operation
> +	 * notifies @p's state transition and may not be preceded by ->dequeue()
> +	 * e.g. when @p is being dispatched to a remote CPU.
> +	 */
> +	void (*quiescent)(struct task_struct *p, u64 deq_flags);
> +
> +	/**
> +	 * @yield: Yield CPU
> +	 * @from: yielding task
> +	 * @to: optional yield target task
> +	 *
> +	 * If @to is NULL, @from is yielding the CPU to other runnable tasks.
> +	 * The BPF scheduler should ensure that other available tasks are
> +	 * dispatched before the yielding task. Return value is ignored in this
> +	 * case.
> +	 *
> +	 * If @to is not-NULL, @from wants to yield the CPU to @to. If the bpf
> +	 * scheduler can implement the request, return %true; otherwise, %false.
> +	 */
> +	bool (*yield)(struct task_struct *from, struct task_struct *to);
> +
> +	/**
> +	 * @core_sched_before: Task ordering for core-sched
> +	 * @a: task A
> +	 * @b: task B
> +	 *
> +	 * Used by core-sched to determine the ordering between two tasks. See
> +	 * Documentation/admin-guide/hw-vuln/core-scheduling.rst for details on
> +	 * core-sched.
> +	 *
> +	 * Both @a and @b are runnable and may or may not currently be queued on
> +	 * the BPF scheduler. Should return %true if @a should run before @b.
> +	 * %false if there's no required ordering or @b should run before @a.
> +	 *
> +	 * If not specified, the default is ordering them according to when they
> +	 * became runnable.
> +	 */
> +	bool (*core_sched_before)(struct task_struct *a, struct task_struct *b);
> +
> +	/**
> +	 * @set_weight: Set task weight
> +	 * @p: task to set weight for
> +	 * @weight: new weight [1..10000]
> +	 *
> +	 * Update @p's weight to @weight.
> +	 */
> +	void (*set_weight)(struct task_struct *p, u32 weight);
> +
> +	/**
> +	 * @set_cpumask: Set CPU affinity
> +	 * @p: task to set CPU affinity for
> +	 * @cpumask: cpumask of cpus that @p can run on
> +	 *
> +	 * Update @p's CPU affinity to @cpumask.
> +	 */
> +	void (*set_cpumask)(struct task_struct *p,
> +			    const struct cpumask *cpumask);
> +
> +	/**
> +	 * @update_idle: Update the idle state of a CPU
> +	 * @cpu: CPU to update the idle state for
> +	 * @idle: whether entering or exiting the idle state
> +	 *
> +	 * This operation is called when @rq's CPU goes or leaves the idle
> +	 * state. By default, implementing this operation disables the built-in
> +	 * idle CPU tracking and the following helpers become unavailable:
> +	 *
> +	 * - scx_bpf_select_cpu_dfl()
> +	 * - scx_bpf_select_cpu_and()
> +	 * - scx_bpf_test_and_clear_cpu_idle()
> +	 * - scx_bpf_pick_idle_cpu()
> +	 *
> +	 * The user also must implement ops.select_cpu() as the default
> +	 * implementation relies on scx_bpf_select_cpu_dfl().
> +	 *
> +	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
> +	 * tracking.
> +	 */
> +	void (*update_idle)(s32 cpu, bool idle);
> +
> +	/**
> +	 * @cpu_acquire: A CPU is becoming available to the BPF scheduler
> +	 * @cpu: The CPU being acquired by the BPF scheduler.
> +	 * @args: Acquire arguments, see the struct definition.
> +	 *
> +	 * A CPU that was previously released from the BPF scheduler is now once
> +	 * again under its control.
> +	 */
> +	void (*cpu_acquire)(s32 cpu, struct scx_cpu_acquire_args *args);
> +
> +	/**
> +	 * @cpu_release: A CPU is taken away from the BPF scheduler
> +	 * @cpu: The CPU being released by the BPF scheduler.
> +	 * @args: Release arguments, see the struct definition.
> +	 *
> +	 * The specified CPU is no longer under the control of the BPF
> +	 * scheduler. This could be because it was preempted by a higher
> +	 * priority sched_class, though there may be other reasons as well. The
> +	 * caller should consult @args->reason to determine the cause.
> +	 */
> +	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
> +
> +	/**
> +	 * @init_task: Initialize a task to run in a BPF scheduler
> +	 * @p: task to initialize for BPF scheduling
> +	 * @args: init arguments, see the struct definition
> +	 *
> +	 * Either we're loading a BPF scheduler or a new task is being forked.
> +	 * Initialize @p for BPF scheduling. This operation may block and can
> +	 * be used for allocations, and is called exactly once for a task.
> +	 *
> +	 * Return 0 for success, -errno for failure. An error return while
> +	 * loading will abort loading of the BPF scheduler. During a fork, it
> +	 * will abort that specific fork.
> +	 */
> +	s32 (*init_task)(struct task_struct *p, struct scx_init_task_args *args);
> +
> +	/**
> +	 * @exit_task: Exit a previously-running task from the system
> +	 * @p: task to exit
> +	 * @args: exit arguments, see the struct definition
> +	 *
> +	 * @p is exiting or the BPF scheduler is being unloaded. Perform any
> +	 * necessary cleanup for @p.
> +	 */
> +	void (*exit_task)(struct task_struct *p, struct scx_exit_task_args *args);
> +
> +	/**
> +	 * @enable: Enable BPF scheduling for a task
> +	 * @p: task to enable BPF scheduling for
> +	 *
> +	 * Enable @p for BPF scheduling. enable() is called on @p any time it
> +	 * enters SCX, and is always paired with a matching disable().
> +	 */
> +	void (*enable)(struct task_struct *p);
> +
> +	/**
> +	 * @disable: Disable BPF scheduling for a task
> +	 * @p: task to disable BPF scheduling for
> +	 *
> +	 * @p is exiting, leaving SCX or the BPF scheduler is being unloaded.
> +	 * Disable BPF scheduling for @p. A disable() call is always matched
> +	 * with a prior enable() call.
> +	 */
> +	void (*disable)(struct task_struct *p);
> +
> +	/**
> +	 * @dump: Dump BPF scheduler state on error
> +	 * @ctx: debug dump context
> +	 *
> +	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump.
> +	 */
> +	void (*dump)(struct scx_dump_ctx *ctx);
> +
> +	/**
> +	 * @dump_cpu: Dump BPF scheduler state for a CPU on error
> +	 * @ctx: debug dump context
> +	 * @cpu: CPU to generate debug dump for
> +	 * @idle: @cpu is currently idle without any runnable tasks
> +	 *
> +	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
> +	 * @cpu. If @idle is %true and this operation doesn't produce any
> +	 * output, @cpu is skipped for dump.
> +	 */
> +	void (*dump_cpu)(struct scx_dump_ctx *ctx, s32 cpu, bool idle);
> +
> +	/**
> +	 * @dump_task: Dump BPF scheduler state for a runnable task on error
> +	 * @ctx: debug dump context
> +	 * @p: runnable task to generate debug dump for
> +	 *
> +	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
> +	 * @p.
> +	 */
> +	void (*dump_task)(struct scx_dump_ctx *ctx, struct task_struct *p);
> +
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +	/**
> +	 * @cgroup_init: Initialize a cgroup
> +	 * @cgrp: cgroup being initialized
> +	 * @args: init arguments, see the struct definition
> +	 *
> +	 * Either the BPF scheduler is being loaded or @cgrp created, initialize
> +	 * @cgrp for sched_ext. This operation may block.
> +	 *
> +	 * Return 0 for success, -errno for failure. An error return while
> +	 * loading will abort loading of the BPF scheduler. During cgroup
> +	 * creation, it will abort the specific cgroup creation.
> +	 */
> +	s32 (*cgroup_init)(struct cgroup *cgrp,
> +			   struct scx_cgroup_init_args *args);
> +
> +	/**
> +	 * @cgroup_exit: Exit a cgroup
> +	 * @cgrp: cgroup being exited
> +	 *
> +	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
> +	 * @cgrp for sched_ext. This operation my block.
> +	 */
> +	void (*cgroup_exit)(struct cgroup *cgrp);
> +
> +	/**
> +	 * @cgroup_prep_move: Prepare a task to be moved to a different cgroup
> +	 * @p: task being moved
> +	 * @from: cgroup @p is being moved from
> +	 * @to: cgroup @p is being moved to
> +	 *
> +	 * Prepare @p for move from cgroup @from to @to. This operation may
> +	 * block and can be used for allocations.
> +	 *
> +	 * Return 0 for success, -errno for failure. An error return aborts the
> +	 * migration.
> +	 */
> +	s32 (*cgroup_prep_move)(struct task_struct *p,
> +				struct cgroup *from, struct cgroup *to);
> +
> +	/**
> +	 * @cgroup_move: Commit cgroup move
> +	 * @p: task being moved
> +	 * @from: cgroup @p is being moved from
> +	 * @to: cgroup @p is being moved to
> +	 *
> +	 * Commit the move. @p is dequeued during this operation.
> +	 */
> +	void (*cgroup_move)(struct task_struct *p,
> +			    struct cgroup *from, struct cgroup *to);
> +
> +	/**
> +	 * @cgroup_cancel_move: Cancel cgroup move
> +	 * @p: task whose cgroup move is being canceled
> +	 * @from: cgroup @p was being moved from
> +	 * @to: cgroup @p was being moved to
> +	 *
> +	 * @p was cgroup_prep_move()'d but failed before reaching cgroup_move().
> +	 * Undo the preparation.
> +	 */
> +	void (*cgroup_cancel_move)(struct task_struct *p,
> +				   struct cgroup *from, struct cgroup *to);
> +
> +	/**
> +	 * @cgroup_set_weight: A cgroup's weight is being changed
> +	 * @cgrp: cgroup whose weight is being updated
> +	 * @weight: new weight [1..10000]
> +	 *
> +	 * Update @cgrp's weight to @weight.
> +	 */
> +	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
> +
> +	/**
> +	 * @cgroup_set_bandwidth: A cgroup's bandwidth is being changed
> +	 * @cgrp: cgroup whose bandwidth is being updated
> +	 * @period_us: bandwidth control period
> +	 * @quota_us: bandwidth control quota
> +	 * @burst_us: bandwidth control burst
> +	 *
> +	 * Update @cgrp's bandwidth control parameters. This is from the cpu.max
> +	 * cgroup interface.
> +	 *
> +	 * @quota_us / @period_us determines the CPU bandwidth @cgrp is entitled
> +	 * to. For example, if @period_us is 1_000_000 and @quota_us is
> +	 * 2_500_000. @cgrp is entitled to 2.5 CPUs. @burst_us can be
> +	 * interpreted in the same fashion and specifies how much @cgrp can
> +	 * burst temporarily. The specific control mechanism and thus the
> +	 * interpretation of @period_us and burstiness is upto to the BPF
> +	 * scheduler.
> +	 */
> +	void (*cgroup_set_bandwidth)(struct cgroup *cgrp,
> +				     u64 period_us, u64 quota_us, u64 burst_us);
> +
> +#endif	/* CONFIG_EXT_GROUP_SCHED */
> +
> +	/*
> +	 * All online ops must come before ops.cpu_online().
> +	 */
> +
> +	/**
> +	 * @cpu_online: A CPU became online
> +	 * @cpu: CPU which just came up
> +	 *
> +	 * @cpu just came online. @cpu will not call ops.enqueue() or
> +	 * ops.dispatch(), nor run tasks associated with other CPUs beforehand.
> +	 */
> +	void (*cpu_online)(s32 cpu);
> +
> +	/**
> +	 * @cpu_offline: A CPU is going offline
> +	 * @cpu: CPU which is going offline
> +	 *
> +	 * @cpu is going offline. @cpu will not call ops.enqueue() or
> +	 * ops.dispatch(), nor run tasks associated with other CPUs afterwards.
> +	 */
> +	void (*cpu_offline)(s32 cpu);
> +
> +	/*
> +	 * All CPU hotplug ops must come before ops.init().
> +	 */
> +
> +	/**
> +	 * @init: Initialize the BPF scheduler
> +	 */
> +	s32 (*init)(void);
> +
> +	/**
> +	 * @exit: Clean up after the BPF scheduler
> +	 * @info: Exit info
> +	 *
> +	 * ops.exit() is also called on ops.init() failure, which is a bit
> +	 * unusual. This is to allow rich reporting through @info on how
> +	 * ops.init() failed.
> +	 */
> +	void (*exit)(struct scx_exit_info *info);
> +
> +	/**
> +	 * @dispatch_max_batch: Max nr of tasks that dispatch() can dispatch
> +	 */
> +	u32 dispatch_max_batch;
> +
> +	/**
> +	 * @flags: %SCX_OPS_* flags
> +	 */
> +	u64 flags;
> +
> +	/**
> +	 * @timeout_ms: The maximum amount of time, in milliseconds, that a
> +	 * runnable task should be able to wait before being scheduled. The
> +	 * maximum timeout may not exceed the default timeout of 30 seconds.
> +	 *
> +	 * Defaults to the maximum allowed timeout value of 30 seconds.
> +	 */
> +	u32 timeout_ms;
> +
> +	/**
> +	 * @exit_dump_len: scx_exit_info.dump buffer length. If 0, the default
> +	 * value of 32768 is used.
> +	 */
> +	u32 exit_dump_len;
> +
> +	/**
> +	 * @hotplug_seq: A sequence number that may be set by the scheduler to
> +	 * detect when a hotplug event has occurred during the loading process.
> +	 * If 0, no detection occurs. Otherwise, the scheduler will fail to
> +	 * load if the sequence number does not match @scx_hotplug_seq on the
> +	 * enable path.
> +	 */
> +	u64 hotplug_seq;
> +
> +	/**
> +	 * @name: BPF scheduler's name
> +	 *
> +	 * Must be a non-zero valid BPF object name including only isalnum(),
> +	 * '_' and '.' chars. Shows up in kernel.sched_ext_ops sysctl while the
> +	 * BPF scheduler is enabled.
> +	 */
> +	char name[SCX_OPS_NAME_LEN];
> +
> +	/* internal use only, must be NULL */
> +	void *priv;
> +};
> +
> +enum scx_opi {
> +	SCX_OPI_BEGIN			= 0,
> +	SCX_OPI_NORMAL_BEGIN		= 0,
> +	SCX_OPI_NORMAL_END		= SCX_OP_IDX(cpu_online),
> +	SCX_OPI_CPU_HOTPLUG_BEGIN	= SCX_OP_IDX(cpu_online),
> +	SCX_OPI_CPU_HOTPLUG_END		= SCX_OP_IDX(init),
> +	SCX_OPI_END			= SCX_OP_IDX(init),
> +};
> +
> +/*
> + * Collection of event counters. Event types are placed in descending order.
> + */
> +struct scx_event_stats {
> +	/*
> +	 * If ops.select_cpu() returns a CPU which can't be used by the task,
> +	 * the core scheduler code silently picks a fallback CPU.
> +	 */
> +	s64		SCX_EV_SELECT_CPU_FALLBACK;
> +
> +	/*
> +	 * When dispatching to a local DSQ, the CPU may have gone offline in
> +	 * the meantime. In this case, the task is bounced to the global DSQ.
> +	 */
> +	s64		SCX_EV_DISPATCH_LOCAL_DSQ_OFFLINE;
> +
> +	/*
> +	 * If SCX_OPS_ENQ_LAST is not set, the number of times that a task
> +	 * continued to run because there were no other tasks on the CPU.
> +	 */
> +	s64		SCX_EV_DISPATCH_KEEP_LAST;
> +
> +	/*
> +	 * If SCX_OPS_ENQ_EXITING is not set, the number of times that a task
> +	 * is dispatched to a local DSQ when exiting.
> +	 */
> +	s64		SCX_EV_ENQ_SKIP_EXITING;
> +
> +	/*
> +	 * If SCX_OPS_ENQ_MIGRATION_DISABLED is not set, the number of times a
> +	 * migration disabled task skips ops.enqueue() and is dispatched to its
> +	 * local DSQ.
> +	 */
> +	s64		SCX_EV_ENQ_SKIP_MIGRATION_DISABLED;
> +
> +	/*
> +	 * Total number of times a task's time slice was refilled with the
> +	 * default value (SCX_SLICE_DFL).
> +	 */
> +	s64		SCX_EV_REFILL_SLICE_DFL;
> +
> +	/*
> +	 * The total duration of bypass modes in nanoseconds.
> +	 */
> +	s64		SCX_EV_BYPASS_DURATION;
> +
> +	/*
> +	 * The number of tasks dispatched in the bypassing mode.
> +	 */
> +	s64		SCX_EV_BYPASS_DISPATCH;
> +
> +	/*
> +	 * The number of times the bypassing mode has been activated.
> +	 */
> +	s64		SCX_EV_BYPASS_ACTIVATE;
> +};
> +
> +struct scx_sched {
> +	struct sched_ext_ops	ops;
> +	DECLARE_BITMAP(has_op, SCX_OPI_END);
> +
> +	/*
> +	 * Dispatch queues.
> +	 *
> +	 * The global DSQ (%SCX_DSQ_GLOBAL) is split per-node for scalability.
> +	 * This is to avoid live-locking in bypass mode where all tasks are
> +	 * dispatched to %SCX_DSQ_GLOBAL and all CPUs consume from it. If
> +	 * per-node split isn't sufficient, it can be further split.
> +	 */
> +	struct rhashtable	dsq_hash;
> +	struct scx_dispatch_q	**global_dsqs;
> +
> +	/*
> +	 * The event counters are in a per-CPU variable to minimize the
> +	 * accounting overhead. A system-wide view on the event counter is
> +	 * constructed when requested by scx_bpf_events().
> +	 */
> +	struct scx_event_stats __percpu *event_stats_cpu;
> +
> +	bool			warned_zero_slice;
> +
> +	atomic_t		exit_kind;
> +	struct scx_exit_info	*exit_info;
> +
> +	struct kobject		kobj;
> +
> +	struct kthread_worker	*helper;
> +	struct irq_work		error_irq_work;
> +	struct kthread_work	disable_work;
> +	struct rcu_work		rcu_work;
> +};
> +
> +enum scx_wake_flags {
> +	/* expose select WF_* flags as enums */
> +	SCX_WAKE_FORK		= WF_FORK,
> +	SCX_WAKE_TTWU		= WF_TTWU,
> +	SCX_WAKE_SYNC		= WF_SYNC,
> +};
> +
> +enum scx_enq_flags {
> +	/* expose select ENQUEUE_* flags as enums */
> +	SCX_ENQ_WAKEUP		= ENQUEUE_WAKEUP,
> +	SCX_ENQ_HEAD		= ENQUEUE_HEAD,
> +	SCX_ENQ_CPU_SELECTED	= ENQUEUE_RQ_SELECTED,
> +
> +	/* high 32bits are SCX specific */
> +
> +	/*
> +	 * Set the following to trigger preemption when calling
> +	 * scx_bpf_dsq_insert() with a local dsq as the target. The slice of the
> +	 * current task is cleared to zero and the CPU is kicked into the
> +	 * scheduling path. Implies %SCX_ENQ_HEAD.
> +	 */
> +	SCX_ENQ_PREEMPT		= 1LLU << 32,
> +
> +	/*
> +	 * The task being enqueued was previously enqueued on the current CPU's
> +	 * %SCX_DSQ_LOCAL, but was removed from it in a call to the
> +	 * scx_bpf_reenqueue_local() kfunc. If scx_bpf_reenqueue_local() was
> +	 * invoked in a ->cpu_release() callback, and the task is again
> +	 * dispatched back to %SCX_LOCAL_DSQ by this current ->enqueue(), the
> +	 * task will not be scheduled on the CPU until at least the next invocation
> +	 * of the ->cpu_acquire() callback.
> +	 */
> +	SCX_ENQ_REENQ		= 1LLU << 40,
> +
> +	/*
> +	 * The task being enqueued is the only task available for the cpu. By
> +	 * default, ext core keeps executing such tasks but when
> +	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
> +	 * %SCX_ENQ_LAST flag set.
> +	 *
> +	 * The BPF scheduler is responsible for triggering a follow-up
> +	 * scheduling event. Otherwise, Execution may stall.
> +	 */
> +	SCX_ENQ_LAST		= 1LLU << 41,
> +
> +	/* high 8 bits are internal */
> +	__SCX_ENQ_INTERNAL_MASK	= 0xffLLU << 56,
> +
> +	SCX_ENQ_CLEAR_OPSS	= 1LLU << 56,
> +	SCX_ENQ_DSQ_PRIQ	= 1LLU << 57,
> +};
> +
> +enum scx_deq_flags {
> +	/* expose select DEQUEUE_* flags as enums */
> +	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
> +
> +	/* high 32bits are SCX specific */
> +
> +	/*
> +	 * The generic core-sched layer decided to execute the task even though
> +	 * it hasn't been dispatched yet. Dequeue from the BPF side.
> +	 */
> +	SCX_DEQ_CORE_SCHED_EXEC	= 1LLU << 32,
> +};
> +
> +enum scx_pick_idle_cpu_flags {
> +	SCX_PICK_IDLE_CORE	= 1LLU << 0,	/* pick a CPU whose SMT siblings are also idle */
> +	SCX_PICK_IDLE_IN_NODE	= 1LLU << 1,	/* pick a CPU in the same target NUMA node */
> +};
> +
> +enum scx_kick_flags {
> +	/*
> +	 * Kick the target CPU if idle. Guarantees that the target CPU goes
> +	 * through at least one full scheduling cycle before going idle. If the
> +	 * target CPU can be determined to be currently not idle and going to go
> +	 * through a scheduling cycle before going idle, noop.
> +	 */
> +	SCX_KICK_IDLE		= 1LLU << 0,
> +
> +	/*
> +	 * Preempt the current task and execute the dispatch path. If the
> +	 * current task of the target CPU is an SCX task, its ->scx.slice is
> +	 * cleared to zero before the scheduling path is invoked so that the
> +	 * task expires and the dispatch path is invoked.
> +	 */
> +	SCX_KICK_PREEMPT	= 1LLU << 1,
> +
> +	/*
> +	 * Wait for the CPU to be rescheduled. The scx_bpf_kick_cpu() call will
> +	 * return after the target CPU finishes picking the next task.
> +	 */
> +	SCX_KICK_WAIT		= 1LLU << 2,
> +};
> +
> +enum scx_tg_flags {
> +	SCX_TG_ONLINE		= 1U << 0,
> +	SCX_TG_INITED		= 1U << 1,
> +};
> +
> +enum scx_enable_state {
> +	SCX_ENABLING,
> +	SCX_ENABLED,
> +	SCX_DISABLING,
> +	SCX_DISABLED,
> +};
> +
> +static const char *scx_enable_state_str[] = {
> +	[SCX_ENABLING]		= "enabling",
> +	[SCX_ENABLED]		= "enabled",
> +	[SCX_DISABLING]		= "disabling",
> +	[SCX_DISABLED]		= "disabled",
> +};
> +
> +/*
> + * sched_ext_entity->ops_state
> + *
> + * Used to track the task ownership between the SCX core and the BPF scheduler.
> + * State transitions look as follows:
> + *
> + * NONE -> QUEUEING -> QUEUED -> DISPATCHING
> + *   ^              |                 |
> + *   |              v                 v
> + *   \-------------------------------/
> + *
> + * QUEUEING and DISPATCHING states can be waited upon. See wait_ops_state() call
> + * sites for explanations on the conditions being waited upon and why they are
> + * safe. Transitions out of them into NONE or QUEUED must store_release and the
> + * waiters should load_acquire.
> + *
> + * Tracking scx_ops_state enables sched_ext core to reliably determine whether
> + * any given task can be dispatched by the BPF scheduler at all times and thus
> + * relaxes the requirements on the BPF scheduler. This allows the BPF scheduler
> + * to try to dispatch any task anytime regardless of its state as the SCX core
> + * can safely reject invalid dispatches.
> + */
> +enum scx_ops_state {
> +	SCX_OPSS_NONE,		/* owned by the SCX core */
> +	SCX_OPSS_QUEUEING,	/* in transit to the BPF scheduler */
> +	SCX_OPSS_QUEUED,	/* owned by the BPF scheduler */
> +	SCX_OPSS_DISPATCHING,	/* in transit back to the SCX core */
> +
> +	/*
> +	 * QSEQ brands each QUEUED instance so that, when dispatch races
> +	 * dequeue/requeue, the dispatcher can tell whether it still has a claim
> +	 * on the task being dispatched.
> +	 *
> +	 * As some 32bit archs can't do 64bit store_release/load_acquire,
> +	 * p->scx.ops_state is atomic_long_t which leaves 30 bits for QSEQ on
> +	 * 32bit machines. The dispatch race window QSEQ protects is very narrow
> +	 * and runs with IRQ disabled. 30 bits should be sufficient.
> +	 */
> +	SCX_OPSS_QSEQ_SHIFT	= 2,
> +};
> +
> +/* Use macros to ensure that the type is unsigned long for the masks */
> +#define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
> +#define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
> +
> +DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
> +
> +/*
> + * Return the rq currently locked from an scx callback, or NULL if no rq is
> + * locked.
> + */
> +static inline struct rq *scx_locked_rq(void)
> +{
> +	return __this_cpu_read(scx_locked_rq_state);
> +}
> +
> +static inline bool scx_kf_allowed_if_unlocked(void)
> +{
> +	return !current->scx.kf_mask;
> +}
> +
> +static inline bool scx_rq_bypassing(struct rq *rq)
> +{
> +	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
> +}
> -- 
> 2.51.0
> 

