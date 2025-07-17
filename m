Return-Path: <linux-kernel+bounces-735556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53272B090F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2687B7B5F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719312F8C56;
	Thu, 17 Jul 2025 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHrg9O/x"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623735963
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767502; cv=fail; b=kn2fqNPSArIypL8VpfxpSPPnKYJU1V9+M5K3GkO08t8Js/WPMnAkvT6djTfRb7PO//lxif0XOCIphGIG51zIeZbw6ezatEpU7B4tJca4XRfhM59v62T13wGKswpHhihcWr6ehXio0DW8/ipdq5moJFAt3X1RIWwrTvB06R+T4k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767502; c=relaxed/simple;
	bh=A7uG7DhLvKolzFZtGomCTWqILQT8fe4+D2j9lHY9L3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+xN+1l12kOIPJHpKGhf1NxLD8zQE7tR2cwhck1Oqxw6xLafAYzFJ/6NSuGwGVmTC3Prz4HhsP/5Fr2BzLnzc5LzXPxBOXWyTeKiD71mdu425OnL1oBhJfyk3ij4L/gtC9X5kng+kwyAE50zZLYBgcPgEdf5XE+qYD6259cKYQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WHrg9O/x; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nccpF+f2gS6RAHoYiLyuj4TuajA8iIqBpr3Cv8LydRpTSTbHMdmV4i98LjJtD/NnWm6FQ304SppQVFx0A6f1EWX67AysygwmiZRNkZfArNyt2kg26RVK4nqF4DGrOAmZsygPYmA9Q53ZuMTLf+9UluR2M9TXDGsi8WHNkreZ+kpzCTWYSQ1t+QJFu95+YL/DgUxtcuSI7Rh2Vw0M8VL3JgdCBW+O8Xd36GBZZmi/4fViq18MtsX3+KLsDUwdk+Ux9j4XU+V6intlvv57Ib9d58OZlIhYdbRr2VRy3VFiBdeCbqnA0NKMOOWIVZ8cfiA/dyVUZaqasb17lJhq8k0aVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGcEy2Fo+PKGHaZ6PrlkVCKj/opl+OtiHPKqPtAeit0=;
 b=lU+h+artDkpIoXsgzyiIdroEyn4aDsgZgh2x6aje8UKsn+nmprI/GISX0tFyOEQxrgYsEmOVeNp7zFXjnacUjui8C9lPlnzNoXcOVi3PMIdzsX+L9rUK8WdJQn7sWe/9q+HiBnXSNmM3fBUIlKSRbO9tDwo2eQhrQOp7+qd279uzJWppMlMVC2vixA812DfTMkpbXfRMZRd+WRpYu/mc1ktKZ3/RnFaLHJuR10LZE6rzD8W9NHm/BMzn4ganYZUMgYkapaRNn3AbD13dVY2x1DoX9tOxl2wuxXtahjhhETYoBLX8GiFLzjvvVugdcKha4xF28z0m2OFCWj2aBSkdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGcEy2Fo+PKGHaZ6PrlkVCKj/opl+OtiHPKqPtAeit0=;
 b=WHrg9O/xu/2GSSvW+tcW/KQBrm4X2hjqYfHKbLFXiXqe1cNg2gWYoswcXba3hmb/IVkf37g87jewF78/IkLkcngSpYDHoFvS/J7fdTEOfrfsm0XQBo51GIlYR3W9tOBYed1DsykRKoo5DrcfSwPtjH22WvYGrT6LcRCDAzVgMJ4PfBYNmcFj5LpFFcsI1KpSXVmdtDZKUs04aSVI9NjR/7xN5wJiV/dPKHHzVwIc5X/s3blp4dbV217io8rvjYDgFoNkU14MEKUXDW+hFAgHtGVSi+/Sbp1v8EnmTRB3bx51lkMmGaQ+ryy+29cWTn74lMA7flXgecMSAYmPHYV2Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:51:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 15:51:38 +0000
Date: Thu, 17 Jul 2025 17:51:29 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: Re: [PATCH v6 05/14] sched/deadline: Return EBUSY if dl_bw_cpus is
 zero
Message-ID: <aHkcAYN43ImECWQ2@gpd4>
References: <20250702232944.3221001-1-joelagnelf@nvidia.com>
 <20250702232944.3221001-6-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702232944.3221001-6-joelagnelf@nvidia.com>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 3618e87b-d742-4e45-afa2-08ddc549d0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgIHDW9wl++l+RmkS7s4njpvgfT5G8IAIE+GFnILs5D2CfaZonGXcved2abX?=
 =?us-ascii?Q?dxSgDjDCaf9QVZCHHrKLPTTiMhuna7LUbIIOJlftgJMtFzIJt9lfd6MJJc1p?=
 =?us-ascii?Q?EnpM+M1gI3oJ5SxjfFvgsMEPEKsEK3pFW5a9X9oEhPvYQZX2mydYaS+P0e2J?=
 =?us-ascii?Q?JLlUOvpHylZBukDa0MOmbiUOOPkJyJjxzm5rFdEkNekvmrTSRydIgy2ysRnn?=
 =?us-ascii?Q?IdLXYOJC4/wYhZwd4blxKZjRBsFjrVkYSdZnIJc4QjEbcoUW/Lf5tNWojfKP?=
 =?us-ascii?Q?PV+FmFO0jHnTVD3kD4oLO+WJuSTsPRB9rgcvd9q4BYps4kZ9k5rj5qOqtk7N?=
 =?us-ascii?Q?ZPDtBv3Ei42p/1xnCa5tDjVb4l1KVrcigYIJfIfnYG/YC0T1zCd4Y5wfkWi3?=
 =?us-ascii?Q?QkFDZQwdnCeuVM+rI0RWwFX0EBx4QK4HPRqqYW0dhiasCb1lwqNU9aBdT48H?=
 =?us-ascii?Q?5fgha3Rtctrtd3T1uip8d+7mn8OCdaidivXkX2zXh+ZiKH2q1MT5DAakZ59F?=
 =?us-ascii?Q?pgSL3/3hxN70/z6JOBN5wR+OCayKFia9E4R3Wj97un3rLBX5sHhIBJQZsadJ?=
 =?us-ascii?Q?o1kGmQfAMYlxPXFJN6JjbObRluIH3aQ+Y/pEWHF5uJSju9xlKbZKSxPhIORP?=
 =?us-ascii?Q?Cc0CVamgKzdGHMKKqYVptbpzbUEeiNNLkT/61nb6Bi9xybqGhLGJJeg4SEu2?=
 =?us-ascii?Q?eND+W/BvyaKtwVM4ZVdvo7TDhEZcVKNe3R/nxyTg0rTvNayDDwT/FG38mMPN?=
 =?us-ascii?Q?GSILzHIzw7K7HPgDgr2RWVnhUWegkiVGSxmm4uflAXPyDPHRZvwxah+h0fIa?=
 =?us-ascii?Q?sd9vSqKS7pQ/Erc1EMy/DC2846SMiH/ylITHGtOjd9CgI/UjfJhWGCZmP0k1?=
 =?us-ascii?Q?uubLY7+ulQi2kHj2hd9KqgW0M+91GBcqQhT3S2LkNfQIpF14Awp7OhHCprVT?=
 =?us-ascii?Q?5Iv+uSyqZ83FBSxIobYhesXBgfuqhDcMDrCI6oAu17bypfn6KmznbllX6Gmj?=
 =?us-ascii?Q?fNQiY1XhKzEPW8PqcvxNIpdqtvTsvMIHEn4lPZCLzEZbgTfKctX4b8UEiMgA?=
 =?us-ascii?Q?GYXo6ri7ycJX89EjFUqiT15ign+4G9zWJ1mxjJA3F8Q+ESgvh/4DMbKJhuet?=
 =?us-ascii?Q?27vV9NNFuubVbrwhH2QNFSZ4cvUmWBM1+VLircvXc+JXEMLE/60gcrMD+EYf?=
 =?us-ascii?Q?/w8935xHGyjrDcB/d2FTe+oynMvSVTtY2VAW7JwQycm5EffDvfERQYQV3G10?=
 =?us-ascii?Q?3npCvY2bmUCkJOJwNGwwg2jddOZvXvk5CBH1IJSYhcmbZT/1WQdN7Grtlg95?=
 =?us-ascii?Q?S33jJULWNJqbMdhVH7XofWp1lAPeqJFGgqRqY08m3vXTnj2V09KLVZ5IwMvd?=
 =?us-ascii?Q?OGtbUIPvjqeptI1z/f5v9IF4dEkwshDleOh/zfFWrtS3lfMBALUmKi27AOjd?=
 =?us-ascii?Q?Y4l1rOpQFL8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8T3BQc5A8458xAMrnh0vjkvrJ+GO9GPjRkpiUglrFlVEcrrjeRwmFkTP1Hlf?=
 =?us-ascii?Q?3fZc7B1+AVx1UFDGHd5sEkPXfaZjtNSfvj0lcjcIbjo1vk2sZMs/GbnBGWR0?=
 =?us-ascii?Q?zk1bWzvtlsQjte+qoTg9iS222uwugZPsoPkoKpGAkco1hZt8dhz/IgbAqEgo?=
 =?us-ascii?Q?bR4Kk/sXlIUchDE+QDLiyghRlQtPoURPS77ozyfB7GtUu/fd3EcuaVPfYVzr?=
 =?us-ascii?Q?EkFc/pyZ3HeyhCb2XbBAiPrOk8DTBRUqn8BrItiEXvOANeIPuzW6aHhZl/3E?=
 =?us-ascii?Q?vYSprv+xDezeqk5GhZOnUSCGRpxXaOzXaoIDdb+YOuhwIJZwuXZUwz6Jbzq0?=
 =?us-ascii?Q?/FxRjruCXpzkwHK+gZUf/j+j3ZrjeFDdbDc3npWM3V94HU7xZ7MFUjAOgc2/?=
 =?us-ascii?Q?nD1Hr9atCx8HMGz/vsrFLx1eKaTmxWnnym8AaIm3r8ypXkLTvxI52FLrZiUd?=
 =?us-ascii?Q?CGb7qTb4wT7urQo454v/nw5cZA+jiWzmzo8anrRVDNXkEUiznAjL9C4XX88I?=
 =?us-ascii?Q?HGFITDoiBxxvpeSd3Aahr21qtz7p3F/2wtBZu//4pwwn/Gdnh+ZCCD/sA087?=
 =?us-ascii?Q?f/bAcLqQ4JLpcRvK0KxOiTFHvsvyLrvJJP8CC1MZ+fmgjmTkwUjelMuW52JT?=
 =?us-ascii?Q?bWlO/649OkzlBqeBkFckJw7uI/2GzU+bYqT1HEscZ5jeaqSKVGyC4zouaFnB?=
 =?us-ascii?Q?exBLmqF1tAmVvMHyXAPZUymq2pp5q6KKSFbdhmfpaTLDrjFPPWAGwzkAr2cv?=
 =?us-ascii?Q?NiipNQ1xYuPyH9Pxo6gxuwLhdzwTDGYE53L1e/UFeI+oFITg1l/jxz7UNjki?=
 =?us-ascii?Q?WmY9yFmFcWZpYlH7t7dzJMFIrDVaYPyrb/NwZCt9Kxf9fyw0TWPpmwosxqOn?=
 =?us-ascii?Q?ousLLmCY7Lau1EGpcw+VtlnnXg3ofOgolV4/2XIOOH5MyZ2LqS9EOHwxM6nS?=
 =?us-ascii?Q?D29u1ru2dGk5VZtRTodLoNaAij+heB5lMfkagzyW3OTCjeaOvT5XtekPFwy/?=
 =?us-ascii?Q?aheiaDUq/ri4rGQUAT1rhgdNVAXmhgXmTnujxYANTzqrpz1Mjn0WTcgoMUDI?=
 =?us-ascii?Q?FEPZngigsZM6MiBe48LyMEWUt81IKVkkeKk8gvtYeFKBOWipEGN4ncjp76PI?=
 =?us-ascii?Q?Z592NAM1pWJs0HY+QtSrVCMiTfcbVP+Ca2WcNa+ht3p6JfUtBv7ZYFjKEDX8?=
 =?us-ascii?Q?PI/QpbObfs474Gb/YtE137r1zgHXq8W2gXeOrBpLKGtJyKZAW4k1PvVSOE+h?=
 =?us-ascii?Q?NFtLzSmB7Dbu6pwTs5L/wCp3XkneBZM4a4+DyQlE6OuE8u1DMUEjpHV1RcuN?=
 =?us-ascii?Q?3CA2ei3xjcY8gfrh0JrkFVJxrX+dfMh8WkmnEFR/f2IfqzkppmKMH9IrTXq4?=
 =?us-ascii?Q?tjBkyIpm6XOiezxd4d1kjMt2hXt6zLkAzKwhF+vyotjQaIGySsbS6nZyYMM8?=
 =?us-ascii?Q?HQ/wJr3DdehMv3iOHHrWOkgeV1jrx9FT0Ot08cbSX0TgTmckvDPJ8nUBNw4R?=
 =?us-ascii?Q?qvugcHuG1Td9qwk8pUfd0UdL882tW7hvFbLhXzKAIEZCJiX0TqJmvWeeGnX6?=
 =?us-ascii?Q?rZoVcQyxdLypFZtHNkrS7ohTpt4ZGerx2HN8bTAe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3618e87b-d742-4e45-afa2-08ddc549d0f2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:51:38.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hUqUCjOBHj5gyLZOUfqlvFm5v5c/FQTaL3eFtmNzQ2yqKoGN6UYi/OJ3WJ5Kj3PrWSBG1d6SuD3ZmjWrZ0e/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565

Hi Joel,

On Wed, Jul 02, 2025 at 07:29:30PM -0400, Joel Fernandes wrote:
> Hotplugged CPUs coming online do an enqueue but are not a part of any
> root domain containing cpu_active() CPUs. So in this case, don't mess
> with accounting and we can retry later. Without this patch, we see
> crashes with sched_ext selftest's hotplug test due to divide by zero.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/deadline.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7129b61d548b..0e73577257ad 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1725,7 +1725,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
>  	cpus = dl_bw_cpus(cpu);
>  	cap = dl_bw_capacity(cpu);
>  
> -	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
> +	/*
> +	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
> +	 * root domain containing cpu_active() CPUs. So in this case, don't mess
> +	 * with accounting and we can retry later.
> +	 */
> +	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
>  		return -EBUSY;

I can trigger the following with the hotplug sched_ext selftest:

[   61.731069] ------------[ cut here ]------------
[   61.731241] WARNING: CPU: 4 PID: 2191 at kernel/sched/deadline.c:1591 dl_server_start+0x9c/0xb0
...
[   61.731552] Sched_ext: hotplug_cbs (enabled+all), task: runnable_at=-1ms
[   61.731555] RIP: 0010:dl_server_start+0x9c/0xb0
...
[   61.732216] Call Trace:
[   61.732239]  <TASK>
[   61.732262]  enqueue_task_scx+0x2bb/0x350
[   61.732298]  enqueue_task+0x2e/0xd0
[   61.732333]  ttwu_do_activate+0xa4/0x2d0
[   61.732368]  try_to_wake_up+0x2a2/0x8e0
[   61.732406]  cpuhp_bringup_ap+0x72/0x250
[   61.732441]  ? __pfx_cpuhp_bringup_ap+0x10/0x10
[   61.732478]  cpuhp_invoke_callback+0x1b0/0x650
[   61.732523]  __cpuhp_invoke_callback_range+0x7e/0xf0
[   61.732566]  _cpu_up+0xea/0x1e0
[   61.732601]  cpu_up+0xc3/0xd0
[   61.732635]  cpu_subsys_online+0x4b/0xd0
[   61.732678]  device_online+0x49/0x80
[   61.732714]  online_store+0x9a/0xd0
[   61.732744]  ? sysfs_kf_write+0x2b/0x70
[   61.732780]  kernfs_fop_write_iter+0x137/0x200
[   61.732822]  vfs_write+0x264/0x5e0
[   61.732867]  ksys_write+0x79/0xf0
[   61.732901]  do_syscall_64+0xbb/0x370
[   61.732939]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I think we can simply ignore the !cpus case, as it's safe to skip
hotplugged CPUs that perform an enqueue when coming online, without
triggering a warning, and we can always retry applying the server params
later.

Maybe return -EAGAIN when !cpus and handle that gracefully in
dl_server_start()?

Something along these lines (on top of this patch). What do you think?

Thanks,
-Andrea

 kernel/sched/deadline.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 5d5819d445fb9..78d2a3b0a4cde 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1587,9 +1587,14 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_server(dl_se)) {
 		u64 runtime =  50 * NSEC_PER_MSEC;
 		u64 period = 1000 * NSEC_PER_MSEC;
+		int err;
 
-		if (WARN_ON_ONCE(dl_server_apply_params(dl_se, runtime, period, 1)))
+		err = dl_server_apply_params(dl_se, runtime, period, 1);
+		if (err == -EAGAIN)
 			return;
+
+		WARN_ON_ONCE(err);
+
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
 		setup_new_dl_entity(dl_se);
@@ -1662,7 +1667,10 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	 * root domain containing cpu_active() CPUs. So in this case, don't mess
 	 * with accounting and we can retry later.
 	 */
-	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
+	if (!cpus)
+		return -EAGAIN;
+
+	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
 		return -EBUSY;
 
 	if (init) {

