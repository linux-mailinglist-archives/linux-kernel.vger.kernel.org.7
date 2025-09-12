Return-Path: <linux-kernel+bounces-813160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A0B54153
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB3A16B597
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E126AA93;
	Fri, 12 Sep 2025 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZxVdzLAX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC627703C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757649446; cv=fail; b=lP0fxbFg+He/QhOoAaVIjOMtTZyQzzIbu3eDbicvwlyak1WsCdooK41chciHNq12NfqDDs/JsA6ee+bCCTnyZKAIOJzBdTnVo56MdXCvNpJz2WUr/AjsqeNxVsHsKP69w8WrPQPk6AiHxRhgOC7vZ0hPQ14XQMbDXfwhIgFf82U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757649446; c=relaxed/simple;
	bh=Jh08AA6eJnC9sVrQnkc3JPMAlB3fbxrLaT7mGZSzUIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C1XRK60oR/qLTg/4H3sEWvsNBSxM7eAH/rpiieOW2AN5l4hS9egMFIepkmZvgEmR1FfV3S4rwNNEj5HojxLpH5Dzp44tqtx7pE5R2pk5Vm1wCOE91pscy0chQG5AlrukmBZiVk/NP5kxWgPIQoH7u9oYYjpKRfspeOJpLPVfPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZxVdzLAX; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2bK2UDn1XlBZ0TQqBYQXPoyR5Mk7qyaucKjWKT/aV8cjhHK2B5sDtMbmhZ2Xh0jgKwiwhAoFOG0KWSskbukifhfy9D46Ur4ibpmWy53sIYzjQLuqEFuTiiZqAkCgAfUTIG5jBhroiwOAP6p5AdNPyjtqvovFlrjiGTh3c0tjDYtvXgvHLvqpI5jqARNxC+MlHZrmnBnOOucWtNW5eZfs5ZQCzvyuHygZqaKI6h1Bq34txtl1Xsj28VWLEkpJyWAuUtUtgcizpf2KPqmdTLhOhoa1fXwBnD2T/8oG+5mXzYdgP70JxbAnUap8hdu67Ds9RtLSdOJzYAR2CTTEmKn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmV/WV3YAcUsHvT0VyP/lhgp0/jf+NZCRqYS8ampl1Y=;
 b=aaqcj59Tzv3IGuaerCB27Ky7R2SqRFHf5NzaglcLBDf1xfDSSLlISMPxkT6MGJe6K4p0c7H6fJs8wiwI1MDjWCYDpIBWVpbnk7IDaO7d72IdGFApfPVcBZuNgZtkU76WpNgrl4IiDGStLwsfk/Z0jwkc5EB9a1Gra8xfYAILH7a5xOzwI85R9/LmGf6GBEISXp3XIzfo0Q2lYIf8l9ppRRUi7wRMno8cHSkzrAzOlMnxOAKrg+GoPSGfVeehvPxCtrzwKnSHVY/LtP0779X1oqT93GqhVw2gOXXC1FIHFwjDVIYPZAcrT37suwa/glumxMcvr9D3toYj54uG8vMZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmV/WV3YAcUsHvT0VyP/lhgp0/jf+NZCRqYS8ampl1Y=;
 b=ZxVdzLAXn3Q2j+2ekgltMz/iw1PgsUBsr4C5o4Ma7i/Ew/hAAvLMii0WOU12x5sjqt5qSVLjOdSdDzUDrZ7BB/t76NVDp4uiOFsvJLXi2/9VLxzr76xwRwLp19858SMa5NQkwe67O/eI5fN5NIk8N1oYcRXXFVc8nygvl0al3z0=
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 03:57:15 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::5b) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 03:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 03:57:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 20:57:07 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 20:57:07 -0700
Received: from [10.136.41.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 20:57:00 -0700
Message-ID: <676b2b4e-2c89-4b80-85a6-29f9a39d1694@amd.com>
Date: Fri, 12 Sep 2025 09:26:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH update 4/4] sched/fair: Do not balance task to a throttled
 cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>, Peter Zijlstra <peterz@infradead.org>
CC: kernel test robot <lkp@intel.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>,
	"Chen Yu" <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250910095044.278-5-ziqianlu@bytedance.com>
 <202509110908.a2P8HZ8A-lkp@intel.com> <20250912034428.GA33@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250912034428.GA33@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: cbcbe985-d1ee-4cea-09e7-08ddf1b075cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUhqWnN4WmZmMGpnaVpvaWlWUVFmVXFwOWlidExSV01KR1RYM2N2dVNzNk82?=
 =?utf-8?B?TnZ0NkVqejdGd01nalIvU2ZGaW54R0dza2o3NlcxREdPRkpVc3dWRHB1YURl?=
 =?utf-8?B?VTlDVE1US1hqdG40c1d3WmhQQ2ZydFNQVm9YODZHWk1iZzhpTjhOY05hbXp6?=
 =?utf-8?B?R055RGVoSi9xWWc1MVZnM25UVG5qR3M4VnUzSmIwSXhNWUpGVnU3V1F0WG9x?=
 =?utf-8?B?b2tkT2tQQlJGbWVpa2lhTFpsbUJFdkRSN0tnMGtqV0RpTTB5dlQ3UWZkclR4?=
 =?utf-8?B?UEZOZWhlVCtNNWdVeXZtVXZLSGU1QU5zS1pIdzU2d28vSS9PRGZGZXlZRUtO?=
 =?utf-8?B?ZjdOQkF5WkZZd1NLbDdlejVEcXNibHViSGRUVnRjTWhBR3V2bVM4bnZ1QWJo?=
 =?utf-8?B?bGNsZE1sSlMwK0ZJaWQ5RFlYZC9HdUIxQkhPMk1idU5aWTB5QnozTlpaejh5?=
 =?utf-8?B?VUdlZi8wVXIreGtmeTVYMVh4TWF4ejUwdVJnVmdjUlc4NVZRTWJGcHZIVEU3?=
 =?utf-8?B?bWpjUXlCaHZYZTlKdWlRbjQ5akRybzg0SG0ydGxZRm1rN2JhMjVmR0RLUXQx?=
 =?utf-8?B?eHNyRi9ZOGZTT3o2UUlSb1YyRDUrOVpFY3pBWFdhcTMxY2JLbGhMc3RpUk5i?=
 =?utf-8?B?NGFMS3ZHY2FtT1A1MGk4ekRXeDVibjhuOUlucDNjTVFKbElCUkNTRm1qZ3JK?=
 =?utf-8?B?SGtROUprNlJYK0pLRjNlbHNkcnZXY3ZDN2ZYTEhzdHBYY3VwTVI0OGVrWUhn?=
 =?utf-8?B?NnFLazh5M1ZBWnZaMW5idCswN25kdlF4VDFVcG9DT3F6VnNnb0RZTjZyYTVB?=
 =?utf-8?B?KzBpZ2JkSkE5Qi80ZUtPbVZQS0dPWXFwdEFXYndwVjRDdEJnQlE4N1ROU0Js?=
 =?utf-8?B?eGo2R1FXMGxCUmliaTA4R05SeEtKUGkreU5FaTc4cXdtYkMwaElaMGNqTXB1?=
 =?utf-8?B?RUVKNXMwS1FocGg5T3VGSlQvMERMYmluNzFGdHora0RBQ2xMSHNmNithTHNm?=
 =?utf-8?B?MnFBN2dJTDlVYm42TS9TVDhRYXRMOFJtdmJwV2JPbSt5SkV0dENCZnEzR1pH?=
 =?utf-8?B?bnlOSnJkaDBTZmhTMmhhOWRtdEY2VlJ5bkhuWXpJL0o1Ly9kbTBDQ2dQVEwx?=
 =?utf-8?B?UjdkUmU4S2JuTWprakZVd1NaaTl5VWJ2dHhXZEZTYjZaam9kc05pcXVqUzZ2?=
 =?utf-8?B?QXRLRnMvV2lacGlWb1BIelo3Wnd5RHdKUm5STzA3SzBMMVQrRUREOHRqQ3pa?=
 =?utf-8?B?K1ZMM2N4RTgxVnlyQ3N4OE5GODdUd0xReUJjMWxWdmEwSHVqTkN5Zy9LT29L?=
 =?utf-8?B?NFlHT25tOURXaktaZk81dVRXM0ZrNngvZGV3NU5DNlV1QVIyNExmS0dGZTRQ?=
 =?utf-8?B?M0RLclA1cC83SS9jRkprd2tNK09MV2pLRjFZdC9lb1lJVTQwdmlteWQ0a05h?=
 =?utf-8?B?b3ZZMUNDMXRtZmtVaWtMajhmTnBBM1YyMXk1ZGwvL09qNFJTUWFXZnRGUFlJ?=
 =?utf-8?B?WEFoOVNhd1pZU0NiRHlrcjdPb2NFNUtYQldOb2hwVlE3UkkvWTRGdERCblZj?=
 =?utf-8?B?byt1eE1nUi9RakNsNGlFb0FySGZKWlN6Q2tJSlhLR0FBTkhWQ3F6eGRKRC9R?=
 =?utf-8?B?RXhKYXQ1OGFldXVLSWNONVdGMWxWeW1GY3NqZjNIRXd5TG4wYVc0UkVBT2cr?=
 =?utf-8?B?RlhCZm00ajBqcHV2aGRidFY4U0FMTVFtK3A2NGtGTnU2aWRIUzloTDhlNk9z?=
 =?utf-8?B?aHIzMlNsZy8zQkRLTUNWSXJLa1UxOVowR1A4Q3pQMUk2UEc3Wk5sTkQ2NjQr?=
 =?utf-8?B?ckMzYjRMRGp6TkFTalhzek5abWF3b0RNVmttSmZ2bUluYTdES0gydWMycmdI?=
 =?utf-8?B?UjBFK0l2alZQMlhzc3YxU200Z2lXMUl1YWRDVnFVNlRTZUJuVGZ1NmxjYU9B?=
 =?utf-8?B?TzRzSEdoWjN3SVplSGNzOWhVaEsxTlFpdExWb3F0b3JmeTdJWWZSRUsrTFhp?=
 =?utf-8?B?SVlFaitaWjVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:57:14.7910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbcbe985-d1ee-4cea-09e7-08ddf1b075cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

Hello Aaron,

On 9/12/2025 9:14 AM, Aaron Lu wrote:
> When doing load balance and the target cfs_rq is in throttled hierarchy,
> whether to allow balancing there is a question.
> 
> The good side to allow balancing is: if the target CPU is idle or less
> loaded and the being balanced task is holding some kernel resources,
> then it seems a good idea to balance the task there and let the task get
> the CPU earlier and release kernel resources sooner. The bad part is, if
> the task is not holding any kernel resources, then the balance seems not
> that useful.
> 
> While theoretically it's debatable, a performance test[0] which involves
> 200 cgroups and each cgroup runs hackbench(20 sender, 20 receiver) in
> pipe mode showed a performance degradation on AMD Genoa when allowing
> load balance to throttled cfs_rq. Analysis[1] showed hackbench doesn't
> like task migration across LLC boundary. For this reason, add a check in
> can_migrate_task() to forbid balancing to a cfs_rq that is in throttled
> hierarchy. This reduced task migration a lot and performance restored.
> 
> [0]: https://lore.kernel.org/lkml/20250822110701.GB289@bytedance/
> [1]: https://lore.kernel.org/lkml/20250903101102.GB42@bytedance/
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>

Thank you for updating the patch. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> ---
> update: fix build error reported by kernel test robot when
> CONFIG_FAIR_GROUP_SCHED is not set.
> 
>  kernel/sched/fair.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 3dbdfaa697477..18a30ae35441a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5737,6 +5737,11 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  	return cfs_bandwidth_used() && cfs_rq->throttle_count;
>  }
>  
> +static inline int lb_throttled_hierarchy(struct task_struct *p, int dst_cpu)
> +{
> +	return throttled_hierarchy(task_group(p)->cfs_rq[dst_cpu]);
> +}
> +
>  static inline bool task_is_throttled(struct task_struct *p)
>  {
>  	return cfs_bandwidth_used() && p->throttled;
> @@ -6733,6 +6738,11 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
>  	return 0;
>  }
>  
> +static inline int lb_throttled_hierarchy(struct task_struct *p, int dst_cpu)
> +{
> +	return 0;
> +}
> +
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
>  static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
> @@ -9369,14 +9379,18 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	/*
>  	 * We do not migrate tasks that are:
>  	 * 1) delayed dequeued unless we migrate load, or
> -	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
> -	 * 3) running (obviously), or
> -	 * 4) are cache-hot on their current CPU, or
> -	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
> +	 * 2) target cfs_rq is in throttled hierarchy, or
> +	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
> +	 * 4) running (obviously), or
> +	 * 5) are cache-hot on their current CPU, or
> +	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
>  	 */
>  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
>  		return 0;
>  
> +	if (lb_throttled_hierarchy(p, env->dst_cpu))
> +		return 0;
> +
>  	/*
>  	 * We want to prioritize the migration of eligible tasks.
>  	 * For ineligible tasks we soft-limit them and only allow


