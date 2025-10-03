Return-Path: <linux-kernel+bounces-841737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C56BB8185
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4DE4C5884
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63574227B94;
	Fri,  3 Oct 2025 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RuzVbJYg"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013036.outbound.protection.outlook.com [40.93.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2E235BE2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759522752; cv=fail; b=EyQC347RuNQhvHXuToAqIYfoJ5l2h9EB15e9RbHrEaBIrFrAJ6HlF/2QL4NgsSbJcVzFtb4+USlXQ44oewAzW+KpN3WxmzL6xck+Wr/aWOs6HaRNLA9BQR9z3NYZtdk4tLus2PbyU0dj5P2StAhPZ/MKw5WkNzIzMF0uTSrxpXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759522752; c=relaxed/simple;
	bh=AtdE7khSUxL8zS1Vcc6f9jGP5erZMv0VUKNzGQ3FwTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rqAnVam0NomNMX4GxFZqW7NSthYYdw7GElG7LBMQTpsU/WUIaAQqCyu/ut6JqUSANGFUcjr5wz48yGgt4lKx2d0/GY39SKEgi1nfrEJiYaM4eGWNZP/6Jsf05A05dt4SRUQYoV2P1TEJxEqL4BZUHSpzeTcnujuv/3luPLLXbr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuzVbJYg; arc=fail smtp.client-ip=40.93.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMGTK6BZaAnr4XWz5zmBVWR3+pXeuqe1DIfMpU3VkfdWk8y73SABx1QE1PboecRfVoHrvcRdMgtRp1Tx12bUeL1GOKKzLnn/EzIrfVKWmg1d2NIjrnwVkg63B73tCHwqg9gtk+8G3ko0aJ54UhRHT1y38tRUPwsCICWMf/gyEOiuCfQH95hvajK/tqyme9Qzw0kTV9yAJRwPfLb4hfW3S24oCkt/KfS6jJFp40MyC4GNCwbvecnR1SjrlsH+F5fDJlR4pl2Fs7m4Y+VGUSbrgdxX9biaBpS7ydkm9C9waUD31cU3KCx5kH7keCgZ3L2dsQlfbOT4aBIUXafIP7CMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rghABo8n5sI7iW2Zt+7j5/lZJzM9IHbcshmXdI1nIQw=;
 b=O+CBOFEloBiqMGSZPf+6ZX/QYup1P96gw95HL2DoOIK7qL6hZPWcJwGnapgVYYVaSeFWMrAIkgMFvcdTuAyOBJk51JV8W+UGZydDnz0m+mLpKPoS3r2skHh+Z5BBs5RiGW7h00TVAwGkjQkIeRL3k84NSnN2BQ8R4mA8B0GupLvZXT9h/aFXuWrkZronglJA3dwCExJfissTLTptEZgmKrUzGkquFo868w7fls2311D0+10cEInmTGSpn75TdM0kBW4oBYB2uZDBANxUiFVco2HxxzDw4AVgiaNuvr58fFh7DsHi2GgP257dBahIo0j2IA14GRXUDSUXRt51X8OSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rghABo8n5sI7iW2Zt+7j5/lZJzM9IHbcshmXdI1nIQw=;
 b=RuzVbJYgP2SilTxLTWpyjd+O9fGjpalIKD+Cmvz0tY8M9ix4kg9BYVYJHtXW9ABTJLFfvxSKqMNhBAxMuMuABOI+nu/QaseX7QGpKCKtzHU8CuRF0tgkWCDMWw1XQx18qcRLRZp5FGYaABHeIzQ0bUEeqIos692dTcgyD0p2JFTZNstMy+YmmzZ4GHgpg3rZcbhqR7ieg9vYyNMT8gG/Gv5G+AgJHkbhmrXyWAy54juEp2KepuXkc8f3rD6sP4jaXBOgFD5IVKhNXLhBdkizXRLprEgXjwoF+zGFsZo0nL3FIyE/NsBbhZQaA1MlIUfuWQSdOJmBNwCDfmg9Bktchw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS4PR12MB9658.namprd12.prod.outlook.com (2603:10b6:8:280::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 20:19:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 20:19:00 +0000
Date: Fri, 3 Oct 2025 22:18:42 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Ryan Newton <rrnewton@gmail.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, newton@meta.com
Subject: Re: [PATCH v2 1/3] sched_ext: Add lockless peek operation for DSQs
Message-ID: <aOAvosirYCLYdPrp@gpd4>
References: <20251003195408.675527-1-rrnewton@gmail.com>
 <20251003195408.675527-2-rrnewton@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003195408.675527-2-rrnewton@gmail.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS4PR12MB9658:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e751d4-c7fc-429e-9cfe-08de02ba1688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OQ8xaahXqPnr12ylZqidrHflG6RoxF4PfwXsmIERhh48bBuhyMMOEwSlUxkz?=
 =?us-ascii?Q?FNryn8eD6XInI7FNB6uCXPZx3fw1flkF+Ieo0oMMy//tW3jb/oGm6ByNhp6r?=
 =?us-ascii?Q?gouXro4j/DeWAuq9mM3Hkam9Nf0TsKWAMXFtZ/VsCCQKarcfTcn8NBQf9HTs?=
 =?us-ascii?Q?/5Rnz9fGU0tMGyoyhQqTE/X1VBO8X00jTINocr6fu+29P2K+KqbwL5N70XKl?=
 =?us-ascii?Q?SilRlYUjVzGGczFEvJpJ9Exwr0bBNJzBtpzGIHXsERVdu+Fy3sA7d5cVImhD?=
 =?us-ascii?Q?MMLCpLJvFKp40MHKvLXnkLTP4wqBSPdIo89jo8CS6UxFU7LRYptOGFrXn/1b?=
 =?us-ascii?Q?Bxu/XQ41Y49seWhvC4BHyuMmRQI54yjDjbWNYcoMk+817Zu3hGolHtuGS+i+?=
 =?us-ascii?Q?dSAW3cY2r0ncjuAa4DQu0Vc4TjtQ+EZvHkFE6xSm3GQ0Ci+lrMkvXiS7VJty?=
 =?us-ascii?Q?+KNSEfkQasDzIMPAckaFy6UpOyl2vSO6VJmAOEoLxUFjIhzAXOdinjInMDpy?=
 =?us-ascii?Q?SCngEcEzV8mlPS7h3up19iD4QDUctb4jQS6KdHv3HDgTo5vJexIXp0KfNb+l?=
 =?us-ascii?Q?2XOsqHZ6pbJKOJlEM1tclgB6IoO8EdddXAoNarmglV3rozFiYPdt0UuUoKLY?=
 =?us-ascii?Q?TbRFycGi0bofYAcPWdTuQKHDtmhcf2cuL5AZWDVzXOYHiN7+yyeUKFS6Q+6y?=
 =?us-ascii?Q?x8q9YifXhsWUZbfqh3oudC3G+iMXKdaPA1FWyzoWc7qRaZ2jX2seVOViWquL?=
 =?us-ascii?Q?SmPu/PvPiI6a3XwcKCFd8ZTzVG48u9j1U2StNX9VVfx6qf0BVDV0IKyqsWbJ?=
 =?us-ascii?Q?LTXZ8/gqUuENpkaxVw0Pf4yd+E5eRIC6nHrSY8OpIEs+s5wYTltk8HWReNI6?=
 =?us-ascii?Q?4Jwas8zYcR2e85Ra0Sw6xZYTX47sJOkiSucgrBgeKArFL7ueS2g0+7egMGlz?=
 =?us-ascii?Q?ig2X8+41PcFnGrkjaCZq0xD1FMAYlo0ng+UsBIDWKtcx/79ocPgBVa6OhqeJ?=
 =?us-ascii?Q?4/3Ic83U4QX/ArbNOL9vUKdECsynNSfZa561SpucTjCMsPSzRlk/skEZs/7j?=
 =?us-ascii?Q?jrzWHfHzwwc/xOrIddvlKWq74WZJZEMSbLbIbcxuqbz40HLEL8aUsJLcUd51?=
 =?us-ascii?Q?wq+BVyw1nHtP85YSrZXpuZ3cenKN0oS3NbQJlh8FJ4YG/YFHXhF0fzJ4li0E?=
 =?us-ascii?Q?o5n7CkVE4vTZ85XWXtCCMAs9gbgZSGPsi6ZI8ucOSU1cvF/vmP4GCo4DtSV8?=
 =?us-ascii?Q?Lol19KoQCsonD6CBP6ZIAR1/jhOEI6l+4VqSUcScrZKTQpR66LEgZxXg18SJ?=
 =?us-ascii?Q?MLGzg3gMP84NL5t2wKcvT709Ci5o/00a9Tf+vHBAUPjjWqSJaFM2JSKjg4Sb?=
 =?us-ascii?Q?m45bilvoWOT/ChHRa+aq66vQLIUqheQ8FKaVod121M/biuR2jdMI9PaM82fm?=
 =?us-ascii?Q?xScqxj/wsUeZ58ul1bOrqC2TLDw1GK4l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wNfux7xZ28ZcwEOCUbA2rUzIykNVnAsK/r5gwUEtzt+Ht0y0p36VE4B+TYf?=
 =?us-ascii?Q?Y2iw8dBPyT4WDMQSEkO9VPMol31wHhCwhtYD8FhzpXs1meQdhCccQi2ClX0t?=
 =?us-ascii?Q?HhYyOa0z4W3nVkofTzPrzQ+HzHaWbuI6dQHrCYPcoI2VTLZz0fIH3GKKMsWH?=
 =?us-ascii?Q?3IRQ81ysgE5/ndR8ElKRvNb0gWXNy66+oIDnMr7FhEFzvpZKA5zEzXEGLqCB?=
 =?us-ascii?Q?/dN7o+fF3PFDQMjHc2SyP4SMw+ycXDMAIk1UQFEULFyCwtfn8YCI1dOV+XAy?=
 =?us-ascii?Q?CloZdQwHbXfP3EbxGXa9RmL8/+u/cHXjc8HxlbM0gNLBb00p3aBqijeEx2GZ?=
 =?us-ascii?Q?MXtUfhdcqBAq8j1SGUWQr1+IyEEiYbUq9OtrXcIUeKihSEoS5yAgMQw2PiKe?=
 =?us-ascii?Q?32L5U+plCqgQmkK0yHDYzSJeWmtF8UPil3dkLvKaG4IYVyEnAddNkf3eZkah?=
 =?us-ascii?Q?ND8d67xa87LUYsZX6r7tBHR6FNFyAqUGbjr6vDvfw4MRD7+0eoPlx4zRH4GC?=
 =?us-ascii?Q?QIO/86DOlmHCsEfnjVyDlQMMlOp6s8UkqyHvLOSdYNPkzVgGiQoJJh4QX/OA?=
 =?us-ascii?Q?tYkhl4eaKyUdlUbmH2Nta+wf2fhh6vhLaa3p56f1Ll4+t6Ome0HWQKW/L2up?=
 =?us-ascii?Q?G59ZhkoSlzkyX1UlJckoDbTby6XY7s7JuGez3WMpbPXFPYbzS1JctuVhw+5d?=
 =?us-ascii?Q?qc9akwq9D1EtTG6dhh8chfP979rPYf1q7qvd8Lr2ee+Bqr1uy2L/XDnVJTs7?=
 =?us-ascii?Q?nGMzXCkVI8C95KDKVeV8KA3c1c8mTi//IrtHpUpqjY/EwzJ+y2lHBnO3nmsi?=
 =?us-ascii?Q?LBW0oQtDx631HUojUCRS3wTXtdjIBn4y5UVA0VLyYZ409D1KQuQQoubD6f3z?=
 =?us-ascii?Q?xkPRQgFx/R921Wi9bgSeFe9o59OE6qzKTn5ZmWn+N3Ywk39LmMDWjIhKpVcM?=
 =?us-ascii?Q?+MzhdlN7NCnp2PqqhMvGbzKzuTBtWvnq30hrTsrAV5mNng2br0HytxgMxsKV?=
 =?us-ascii?Q?lFPuPzms0QU6FjlrXQaOwSoRR320t1SBAsUCa4TT4wRvj9D57StyIEcOpe7o?=
 =?us-ascii?Q?X9Jz0qSzl4jf0QOsVSBLLOJFv9swoQgNsgHPDqs/4mGaNQnr39adN2Fe3C5+?=
 =?us-ascii?Q?P4VacWTqG7/6BA1EAJXnCQ0Otun3ba5VOeRcVetEvTMU2aDeg8h1/T+xcqQ7?=
 =?us-ascii?Q?LDjtc9kuLDc90B8qngMbkzz9UIzKLQgCFlDJllxbxvx0NN/5ugh4VD7fbdbI?=
 =?us-ascii?Q?1pxbLgVnVJ706OE2qrQACbvNWA3nQr1vf/28jn066Oe+8pi1Y1jiNIiPkUS7?=
 =?us-ascii?Q?S14nUEvxb7wtkwmm22yhgC0P0ZHVOGLya209Igi/zzeCslUjDmAFiiyvHSdb?=
 =?us-ascii?Q?zgw6ih8eMjNV2zmtMEztRUnXWkyP7XoSxiQUMo4RD2Rz5+z7GBeK7ZtEjasN?=
 =?us-ascii?Q?PIrX82g0E4lWZV8jK73sr77+7VmmOMXHWnl4BmBfASzyA9diRWEsH9473jzJ?=
 =?us-ascii?Q?3mXpcYTvRSu3+Jl912LLuFMxzw/tPuaKczK/9qGIN+AxdPHzLWQU3tT3re93?=
 =?us-ascii?Q?JIrmhIgSFWstwQy9LwL0lgP0r9+enTebnInvlYkD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e751d4-c7fc-429e-9cfe-08de02ba1688
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 20:19:00.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaEW3Vy+WCgV+1Wsj54yE2360pqyPl+9QqECUmdAo21LmJpxKh/gV1jAkRqfEg78mybKmS0PXRwHLfJMBpvasw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9658

Hi Ryan,

On Fri, Oct 03, 2025 at 03:54:06PM -0400, Ryan Newton wrote:
> From: Ryan Newton <newton@meta.com>
> 
> The builtin DSQ queue data structures are meant to be used by a wide
> range of different sched_ext schedulers with different demands on these
> data structures. They might be per-cpu with low-contention, or
> high-contention shared queues. Unfortunately, DSQs have a coarse-grained
> lock around the whole data structure. Without going all the way to a
> lock-free, more scalable implementation, a small step we can take to
> reduce lock contention is to allow a lockless, small-fixed-cost peek at
> the head of the queue.
> 
> This change allows certain custom SCX schedulers to cheaply peek at
> queues, e.g. during load balancing, before locking them. But it
> represents a few extra memory operations to update the pointer each
> time the DSQ is modified, including a memory barrier on ARM so the write
> appears correctly ordered.
> 
> This commit adds a first_task pointer field which is updated
> atomically when the DSQ is modified, and allows any thread to peek at
> the head of the queue without holding the lock.
> 
> Signed-off-by: Ryan Newton <newton@meta.com>
> ---
>  include/linux/sched/ext.h                |  1 +
>  kernel/sched/ext.c                       | 59 ++++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  tools/sched_ext/include/scx/compat.bpf.h | 19 ++++++++
>  4 files changed, 80 insertions(+)
> 
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index d82b7a9b0658..81478d4ae782 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
>   */
>  struct scx_dispatch_q {
>  	raw_spinlock_t		lock;
> +	struct task_struct __rcu *first_task; /* lockless peek at head */
>  	struct list_head	list;	/* tasks in dispatch order */
>  	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
>  	u32			nr;
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 2b0e88206d07..ea0fe4019eca 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -885,6 +885,27 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
>  	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
>  }
>  
> +/* while holding dsq->lock and does nothing on builtin DSQs */
> +static inline void dsq_set_first_task(struct scx_dispatch_q *dsq,
> +				      struct task_struct *p)
> +{
> +	if (dsq->id & SCX_DSQ_FLAG_BUILTIN)
> +		return;
> +	rcu_assign_pointer(dsq->first_task, p);

Do we need this helper? Maybe we can just do this in the caller:

	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
		rcu_assign_pointer(dsq->first_task, p);

> +}
> +
> +/* while holding dsq->lock and does nothing on builtin DSQs */
> +static void dsq_update_first_task(struct scx_dispatch_q *dsq)
> +{
> +	struct task_struct *first_task;
> +
> +	if ((dsq->id & SCX_DSQ_FLAG_BUILTIN))

nit: remove the extra ().

> +		return;
> +
> +	first_task = nldsq_next_task(dsq, NULL, false);
> +	rcu_assign_pointer(dsq->first_task, first_task);
> +}
> +
>  static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			     struct task_struct *p, u64 enq_flags)
>  {
> @@ -959,6 +980,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
>  			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
>  	}
>  
> +	/* even the add_tail code path may have changed the first element */
> +	dsq_update_first_task(dsq);
> +
>  	/* seq records the order tasks are queued, used by BPF DSQ iterator */
>  	dsq->seq++;
>  	p->scx.dsq_seq = dsq->seq;
> @@ -1013,6 +1037,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
>  
>  	list_del_init(&p->scx.dsq_list.node);
>  	dsq_mod_nr(dsq, -1);
> +	dsq_update_first_task(dsq);

Same here:

	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
		dsq_update_first_task(dsq);

And remove the check inside dsq_update_first_task() - feel free to ignore
this, just a stylish comment.

>  }
>  
>  static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
> @@ -6084,6 +6109,39 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
>  	kit->dsq = NULL;
>  }
>  
> +/**
> + * scx_bpf_dsq_peek - Lockless peek at the first element.
> + * @dsq_id: DSQ to examine.
> + *
> + * Read the first element in the DSQ. This is semantically equivalent to using
> + * the DSQ iterator, but is lockfree.
> + *
> + * Returns the pointer, or NULL indicates an empty queue OR internal error.
> + */
> +__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct scx_sched *sch;
> +	struct scx_dispatch_q *dsq;
> +
> +	sch = rcu_dereference(scx_root);
> +	/* Rather than return ERR_PTR(-ENODEV), we follow the precedent of
> +	 * other functions and let the peek fail but we continue on.
> +	 */

Well, if sch == NULL the root scheduler doesn't exist, so it's not too
unreasonable to return NULL (meaning that the DSQ is empty).

What I'm saying is that we either return ENODEV (but then we need to force
the caller to handle that) or maybe we can just drop this comment,
otherwise I think it's a bit confusing mentioning about ENODEV without
returning it.

> +	if (unlikely(!sch))
> +		return NULL;
> +
> +	dsq = find_user_dsq(sch, dsq_id);
> +	if (unlikely(!dsq)) {
> +		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
> +		return NULL;
> +	}
> +	if (unlikely((dsq->id & SCX_DSQ_FLAG_BUILTIN))) {
> +		scx_error(NULL, "peek disallowed on builtin DSQ 0x%llx", dsq_id);

This should be sch instead of NULL, right?

Moreover, I think we can move this check before find_user_dsq(), so we can
save a call to find_user_dsq() that would fail.

> +		return NULL;
> +	}
> +	return rcu_dereference(dsq->first_task);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
> @@ -6641,6 +6699,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
>  BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
> +BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index 06e2551033cb..fbf3e7f9526c 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
>  void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
>  s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
>  void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
> +struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
>  int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
>  struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
>  void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
> diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
> index dd9144624dc9..97b10c184b2c 100644
> --- a/tools/sched_ext/include/scx/compat.bpf.h
> +++ b/tools/sched_ext/include/scx/compat.bpf.h
> @@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
>  	false;									\
>  })
>  
> +
> +/*
> + * v6.19: Introduce lockless peek API for user DSQs.
> + *
> + * Preserve the following macro until v6.21.
> + */
> +static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
> +{
> +	struct task_struct *p = NULL;
> +	struct bpf_iter_scx_dsq it;
> +
> +	if (bpf_ksym_exists(scx_bpf_dsq_peek))
> +		return scx_bpf_dsq_peek(dsq_id);
> +	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
> +		p = bpf_iter_scx_dsq_next(&it);
> +	bpf_iter_scx_dsq_destroy(&it);
> +	return p;
> +}
> +
>  /**
>   * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
>   * in a compatible way. We will preserve this __COMPAT helper until v6.16.
> -- 
> 2.51.0
> 

Thanks,
-Andrea

