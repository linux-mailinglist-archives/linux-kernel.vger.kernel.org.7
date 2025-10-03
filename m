Return-Path: <linux-kernel+bounces-841520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA50BB7932
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 748473470FF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D732C3271;
	Fri,  3 Oct 2025 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5cFFsdG"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D012C17B4
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759509405; cv=fail; b=GEWG9L3tE/FYJcmGwhQ3/ZmVUe0fZs7EJTiGoojlFOZQesTQkX1cJ92ukB+F7YUd65mumzjeAWqxd2rsbJp/h0+4pT0zn2PSULVAhR77N4+O47G7XhIlpZC14VoxAeDdkaMaiaLRxcJPTdGoAOTrEbTv3kp2o0OAkhHplDU+IFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759509405; c=relaxed/simple;
	bh=va6jRoxsh3gOY7zCC6nXh9ECMuxsUjicosedrnO1Lx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C2dSrOvU5g+k0odEyVHBKlhRymXDejNkVZCPxoRUjR1HJZP5KxyUYyJhvaSYKMewJfxiXSikA2ok7zaPxAyzpu8XQh5OcvRNoI9XNETLFUHUZBOaPHobO+OyXCPx5FwFu2L6eHdubEzEfMOokdmmybOOcIUpdDAdqc3y0fhbj8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5cFFsdG; arc=fail smtp.client-ip=52.101.43.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj1gjwRx6qk4UqziCIMjCMp3JLYVsjqz1cnJWz/Aa1TEe/g/lII8WAbS/bwFQE9msCSaUKtrrowoCSCdiK2eELPSLyBWhpQj+SPMCVCx2lhIN+8CLfSPseONc5CiTxEq1dK/VB2jTA96qK1+SA8kiCZm4szSog/OYo7FaDWolIuQsKepCziHVcLxROEqZoRw2uH8BQJ6eJUdji3r01IwZazwaB0gbZSK7N9iwQzxJvISAYLVYIkDbFOuGIiWpnPLjFmRJ8l1cxb53XXaFlQnooL9B2GBWGlk4zxt8cLZxqfBJApfFMvpqhyn/jGZymWJNk8nHGsLUzxc4UCiTXiF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFP3bJ8S3tqGklrYGuFZCN7iwnHy/0Guom7phpFq3YQ=;
 b=YEggNMR9pPamS6wc1+JuMUkT89mJ/dEaMvydE9iY7eGHTE7ceoSFjNWJRWUp0y/ZDKhF1kkQuX5dL9iOY5Ribdamb9EpGxzpD7STsN25Z8gGyYfAuNmMmDnapiueb5j/7AyyFDuc7UZXCYTdASWVI5/SJIBroyIswWTHRGDW9l1RK7N8D8P4iuWpperiN8Vd68NCF9K8FBOa843SRM/OCMFt+yuKRFNc4oR5ISjRvoH2s27ukVfBznre+XLpKtnHavHbXp3666cGQqnwTjStvkjPfZiQVMfXYQvxIDwPx8Zs8uaFMb+Pt8KjJ3Kto4uByUX+iSTfHtBH1E4M/lnvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFP3bJ8S3tqGklrYGuFZCN7iwnHy/0Guom7phpFq3YQ=;
 b=J5cFFsdGrO7zqpOPbwel/TXCSv8PJdAVrmAbN8jAvVF8Jn9tKiCRawLgJeEuQgKlwRwZqKS0bahwxVGDmZ3PYGI4REv5pUHGiSbFbxppZVlNuNYCKhjuQebkugWp2MJsOJtnWmUo5nTol7E1xTF3+5YwqIfz6X7FuD5D9l5hlxjTtDQhpLvDC0IIWwbAK41CancY4u5S2t9iXvJa0hSZphVuVdArylCR0puq+o+XcPrx9ScYauro9LG4zT1oQvz1p+hfl/XZ9DU6R00oLeQfTNkKR+nEdNJ+NmVSZHVP1zT73YYQQU+Hjntr4aTztpzphqdFL1L+rvg3Mn8VHF7U1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7967.namprd12.prod.outlook.com (2603:10b6:510:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 16:36:34 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 16:36:34 +0000
Date: Fri, 3 Oct 2025 18:36:24 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Joseph Salisbury <joseph.salisbury@oracle.com>
Subject: Re: [PATCH] sched: cgroup: Move task_can_attach() to cpuset.c
Message-ID: <aN_7iDbWQq3HXvd3@gpd4>
References: <20251003121421.0cf4372d@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003121421.0cf4372d@gandalf.local.home>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 28763b5d-6da3-4d80-b225-08de029b03d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ytt3+1rqeKagVXkwImLGo4iAbZ1sLhjm8/SSYjGW7/mGwtOpJJAN5M43SI5K?=
 =?us-ascii?Q?tGAkr1UK/kcmFqAd9tv8hoeezAD9P0BFkGC1tMfO+O9+xWX9KNXk0eN6H3FQ?=
 =?us-ascii?Q?NZ42DotGbmkKzjy2j7q4dOOojAjxMpMbm4G+DGJW1U1+pb7Ay6aRqYE6Nh4y?=
 =?us-ascii?Q?mtbiM5EfeXKUVQfIJji4lLIVkM+xEvzgDZ0ZGaOxcLmt3EzL9O+snnoXUDE3?=
 =?us-ascii?Q?BRdoocqqpQQEy/U+4MUQCRyMS4GCw3GcUiw6h6KepFrvv/kv3YVhUUsrHWpq?=
 =?us-ascii?Q?bY/54NvjAMZXJlrC3aAb5mx+JkQ1dzgzwDF3+5LIcWs7GOk7i10IqtAl9Ygt?=
 =?us-ascii?Q?3G2RMVw65oVzHBR9EdDSE8eZCSMBvyRkNu8SelB6PlE86MLx9ag/sKq1FBm2?=
 =?us-ascii?Q?XzzUnDYFtngnSgReDEgzy0yLfkbXzn7+WulH0gExUHw1p/49y87pz4B+MNAp?=
 =?us-ascii?Q?t4ewEQpj582XBZW4+JWdRBexmiPGbCBQx/qGw+zabpJA+9//TlKQAcUm63N5?=
 =?us-ascii?Q?qcnd5YJYQr6X5bI1Rd9fg/VDhvX18iJrwv/9wb3+ODbk6XUwLQ1XDx2ANJgL?=
 =?us-ascii?Q?EIvAW9WiOqhU0r4tffdu1QNLjnJZaLOrXlKsyYErnTpHURxFPzvFSO5Sq/cv?=
 =?us-ascii?Q?icSCBGqFwjHOO0osk7AQloDsQnI49ryzRra1XLpf1/Ap9V3CslXD+C/3ipe6?=
 =?us-ascii?Q?hxjwONxPs9GM6QdAGW60LPXog2yE/pBxnogCaB+TLT1o5uHCvcbV8H55Iaui?=
 =?us-ascii?Q?aOsgZfzV5m6rufulupW87U2yV4OvaoOOGmYSZppzc1RlGgOQaxKr4t/B61d4?=
 =?us-ascii?Q?GAfQp4/8umcGRnFYoYdTSo3pvb4uVN0n8ph6Ie3U3eRWjaHN+VmUd1fkmcw/?=
 =?us-ascii?Q?tSx9x8bK1jP8GJF4ClJprZ75+kiEw7iWPM55aYw+pes1nROFkGsKc5iQNOLE?=
 =?us-ascii?Q?uJDr6EZUbsolSrBN4JFcGgxztDuUTvwQ3geFZfA1qt9fUUx5tZEScEe1kCPS?=
 =?us-ascii?Q?8MbcHCJdLsYjCQr43AYlubmALI1kvxCdjvCmbrQu24A99+6529mcWk56EEuL?=
 =?us-ascii?Q?O/987sn5teNQuEKoozQN2J2IAZln9CiCppW7DsVAwInZGB1Ga43LdVWDOtLV?=
 =?us-ascii?Q?+JU1Bqgx9GjwGFMFq3vAkxO9sI1wuY16jitOYuYbbwhiSj3JVzr+0i0pE8DK?=
 =?us-ascii?Q?Ieixxi8/u2REQ2ZQPhdf5AsXpdFO0P3hrb4//ovAb43wSN7vndg65KASKtbx?=
 =?us-ascii?Q?Auy0ugs6Bw+MmaFgrXyxPgjUum7NiIuRK/b1JSkFV4fygmqlmRrHzJ5l6zJZ?=
 =?us-ascii?Q?JgDTc371dx/JsIV8N9Vh3AP9IX6arW7SD5HywZcvP6LCC4Ig+BDKojCYGCx9?=
 =?us-ascii?Q?HQD/LKAybFot/qFipJ5/0GqNnnIYGYQUN5MOYyoi7LjIvKa4Y1ZniUYKDxK+?=
 =?us-ascii?Q?6RNAJPzJSmPUsiQKkkA2urOwHErvTmyg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i7Yu7emZt696YR7sdYXILrty+csK2skEAKt3Mtfa9zN5WVGYHF9Sc/6H/Ef/?=
 =?us-ascii?Q?0ncfja4sfy28v7fZj7tFTOpbrkwS/gW1Uhv8bI1hHJPB6bz5948Ths3mYwTB?=
 =?us-ascii?Q?2Wc/zXt1gD7dlufHME7N3v1DUBHWlg0YIsZsl373+IE3MhusN4fzJPMnne3w?=
 =?us-ascii?Q?u/aO781O2+Vhk1YR/WtXzec76iCvVXojGzTMbvGRU3ke6PObw/4NXd80QW/Z?=
 =?us-ascii?Q?cIwD+luSjvZkx9nPO1MFCFn0CrPJgU690jznOcQTPVwkYjqDQ7SGP3y6J4d8?=
 =?us-ascii?Q?aSY9zJ3OPRrmJgsfCZc/zTPhFQMcgSJ+Aqk88r1QL1OIGqP8Q2ewjvIartpX?=
 =?us-ascii?Q?w2eoqpGUoi3zCsLKij0KSa4mY6Q2wYVGusvvBhVTg1lsI3qREEOgnO8WymJV?=
 =?us-ascii?Q?B4O30+rNmuQd4Z5aQqWM3C6GIQP6XeKNg1in7cmqSZYPNfrQrLYnkaC5ahx1?=
 =?us-ascii?Q?s/cNQz+O5f1tlWAINd+gsscQKkR7W7S1cBl/lbnqjbdZRWQuoQizN5U27VZc?=
 =?us-ascii?Q?C1zO9CarglFDLXIogr210/RUdjC/cfwbCGvN45/S/mhm5VPeC+Yr2YxY1M9F?=
 =?us-ascii?Q?GjObTqYvTF89zeuZOQ+T6Qe1sMCS5ABrcp/1uDHcPFVCr+xBZJYpVaiQsJj4?=
 =?us-ascii?Q?kRQGLMKanVLvet79b8xtNGAzOFryFREwIEg8FNR+Ix28a6aV0PCH0mDiHrbK?=
 =?us-ascii?Q?GZ47banKRZWU3hSX/yStS4uDbaw7i/qTE59wwz/EvOtNKdjagsyU2XUm97CO?=
 =?us-ascii?Q?FCp7MxQ9EWVa1Y2j2ucEsYnLnce8dVxIgO+bbrxVEvFV44QekkRT+5xcY9D9?=
 =?us-ascii?Q?MXHA6HX18GacVwQQvQrt5P1Ei66//9f7Ra1fMs2qYD7c6yPH3IFC9QEj90wD?=
 =?us-ascii?Q?ZdZUnFyb7u6NkAbiZPtVSGOfYPE1yJjr6RemnMoxqw7vjM+RopKHoOddCSPg?=
 =?us-ascii?Q?UkT9041Qeo3+mYS69aTiVyGOhy6pL/3jH5kOUflgfzNtDgKBFOQsjObLEO9t?=
 =?us-ascii?Q?auk0ZWJhZqlftfuvdmdz1Sy/JWf6WN3L3vyIB+K3emUtpCsqS2TzC3H9tLl8?=
 =?us-ascii?Q?g9c7DO8zoNMnqQHM9NR2gzHLOWNXT1ZBicvuWOy5QzkD5+RxV4nCPBLxZ2T3?=
 =?us-ascii?Q?lYZVI4O++8PaUuWp7y41FWepoPOzro3cZ80dVlga5liIHBMQ+NWe1C74pg4C?=
 =?us-ascii?Q?1dqAsYu3Tbfb+4NUku/iYL6MM8uyba4cfJ2BJVDvvsydm9lRja4A6ME4rFwo?=
 =?us-ascii?Q?3CNjEzPJqn2vE+44oHEwYvputzU6i6Mn5G6+TduF9PV1zJtIB6siDd9kxUPk?=
 =?us-ascii?Q?L/sNNDjPY64m2LCYKtf0+0QNOFwX9CfeD8U2hw6crsoEJ7CS2HXROYUVfd7w?=
 =?us-ascii?Q?kOwYjLEfvuHtWFSbkTCY3Qh7eZfYo9T8gWRR6iyA5uz1BqI/QOz7oOmxJvQz?=
 =?us-ascii?Q?3hsFJSZEWLpNP0jx8PnL6fgCyAUxAKPjdoWHKUDEev52qLdNxEfghJ13g1B8?=
 =?us-ascii?Q?I3EeVbA1/XVXatXxxPxxud3JAQsVmXX++/9Q3zG4bArlllR6v2fw7vhhP3Hd?=
 =?us-ascii?Q?q3N1eX44QRvEXuvQVY4Lt9xXlh1+4OF2uffZvPoR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28763b5d-6da3-4d80-b225-08de029b03d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 16:36:34.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwtSUCpnhMiWqxLQ5hpT9kine9GB1fvQDBPDrYoW67dpWdQvfKWHtUFSBor+gVGkkhUXfVkCwuXdbJ9LTGXWeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7967

Hi Steven,

On Fri, Oct 03, 2025 at 12:14:21PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> At our monthly stable meeting, we were talking about documenting non
> static functions and randomly picked a function to look at. That was
> task_can_attach(). It was then noticed that it's only used by
> cgroup/cpuset.c and nothing else. It's a simple function that doesn't
> reference anything unique to sched/core.c, hence there's no reason that
> function should be there.
> 
> Move it to cgroup/cpuset.c as that's the only place it is used. Also make
> it a static inline as it is so small.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Nice cleanup. :)

Apparently it became that small with commit 2ef269ef1ac00 ("cgroup/cpuset:
Free DL BW in case can_attach() fails"), maybe we can mention that in the
commit message?

> ---
>  include/linux/sched.h  |  1 -
>  kernel/cgroup/cpuset.c | 19 +++++++++++++++++++
>  kernel/sched/core.c    | 19 -------------------
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4ce0a76831e..4ee4fa973eda 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1849,7 +1849,6 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>  }
>  
>  extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int task_can_attach(struct task_struct *p);
>  extern int dl_bw_alloc(int cpu, u64 dl_bw);
>  extern void dl_bw_free(int cpu, u64 dl_bw);
>  
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..21fe872803e8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3009,6 +3009,25 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>  	cs->sum_migrate_dl_bw = 0;
>  }
>  
> +static inline int task_can_attach(struct task_struct *p)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Kthreads which disallow setaffinity shouldn't be moved
> +	 * to a new cpuset; we don't want to change their CPU
> +	 * affinity and isolating such threads by their set of
> +	 * allowed nodes is unnecessary.  Thus, cpusets are not
> +	 * applicable for such threads.  This prevents checking for
> +	 * success of set_cpus_allowed_ptr() on all attached tasks
> +	 * before cpus_mask may be changed.
> +	 */
> +	if (p->flags & PF_NO_SETAFFINITY)
> +		ret = -EINVAL;
> +
> +	return ret;

As we're cleaning up, we could just return -EINVAL and 0 directly and get
rid of that ret variable.

> +}
> +
>  /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
>  static int cpuset_can_attach(struct cgroup_taskset *tset)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ccba6fc3c3fe..a195c4b25475 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8070,25 +8070,6 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
>  	return ret;
>  }
>  
> -int task_can_attach(struct task_struct *p)
> -{
> -	int ret = 0;
> -
> -	/*
> -	 * Kthreads which disallow setaffinity shouldn't be moved
> -	 * to a new cpuset; we don't want to change their CPU
> -	 * affinity and isolating such threads by their set of
> -	 * allowed nodes is unnecessary.  Thus, cpusets are not
> -	 * applicable for such threads.  This prevents checking for
> -	 * success of set_cpus_allowed_ptr() on all attached tasks
> -	 * before cpus_mask may be changed.
> -	 */
> -	if (p->flags & PF_NO_SETAFFINITY)
> -		ret = -EINVAL;
> -
> -	return ret;
> -}
> -
>  bool sched_smp_initialized __read_mostly;
>  
>  #ifdef CONFIG_NUMA_BALANCING
> -- 
> 2.50.1
> 

Thanks,
-Andrea

