Return-Path: <linux-kernel+bounces-798114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79ABB419A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EE0541CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A8279DA3;
	Wed,  3 Sep 2025 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ty0BaPpi"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0427F72C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890738; cv=fail; b=My4hTz/4WH27ST/6Xe6xkm43Et6L4A+HFGANFXPh+mYWdqgXCmGEAA3Cxa1Q7tGeY/o7/wI4zw75jHsG5MJZolGg575OnCgQax5u7xB048oy0qW53aaP9gTYTSpW7vyjNTN57YKOtLFiKfdpGYHDqF4M9cZlI8MN7ZmuQ/Qk438=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890738; c=relaxed/simple;
	bh=4CRn53NAJgYkn5iwK0rhkqi+QQYuaag9VylB2KaGOcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sjFlTzFiu0MElt5rnfVzO9ZrO+Eia07hKaCF1DxTC2xKu27PyElsxfuRLXdEIFqmSjk+G1dEJ3UfuDeuQsiJkVJCPUjZ94CaHsSugCF5AtsPZi8t2SxlqS0shhq1pVm+l5pb6nBrmEwZxMoyUFVtFJq+FLQbKc5ESfH0DiHHU8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ty0BaPpi; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yc68zUYSu3WlulExTxRzi/1YyBnaHvB6FqYtUUTg915yOOWZY26E7dUa9TB0c7Gi2OIwTKhlGCoxhj2IobtrkBgVTVgFy0QgFVFWevl7MW23OqXkh/iT70zgq4iL1EOzptyocTu4PDFrLAYAIIgWWz1CGVMAI98iGfbnFw8ct38GcQhUqBjERRY3DiQbmd98aLTI71f4BytGkyVuUEqZHpSomeJLe2zJ/pwcgIaDRFdf3KXEzTlUUjx+kD08RyNUYH5aqaAYbprTkVfq0XSAXdP2svYAPdbMOmG9JXm1f06ra+Yq8Xy/Ounf5Unmix5Lo61F+gDSPW6i8YbRv31PvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuO7jgI6eQs8iR3SthhhpT24UJpkkQK8uwP0ne75BAU=;
 b=jwDr5wbCd8xzBpjvr0nKSgS0yxM3O+LBnSGqVTBdas3tdGkcf5L/pESfVGMal0ehHNqnZkzYDl6tUG5fmWcP7ButDqmWaFNnDaFVti+YTcVeuz9N2Oy6AnhLOpCTpnoSX9oOU4Hwfkhy0setw1jX4v4a0Zx1rLDQCzGmHinIKhNwyPJU9b9HMh8XGdoEcc31F7dGiBvBKCpikpMD8xFH4SLSL7jLBnNMRVSyyXmX15M5JIrzr2FoduY2w0BW+Ahty0GQhErkc68l62O9vsuHMjKdYv+HlnrhO1uj0tEtvF37pS+be3JRF2j4fd6H8sqHBq/A30wU1l4FtjpTdVliRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuO7jgI6eQs8iR3SthhhpT24UJpkkQK8uwP0ne75BAU=;
 b=ty0BaPpi4t56VEPZ6sTlIxckqz1xdkAfbnZyvb60VCWXXR0F1db8oQwXkvNK7pRJYcReLGCDH9PHFZS5MwjUatV2J1HMd8q9cAspuhT/QCIKTcfOtek/4Na56IMpMpEXPueJkEVDmX1aE/L0OofP29KfuGsIJPjX0739Vd6V9BM=
Received: from BYAPR11CA0081.namprd11.prod.outlook.com (2603:10b6:a03:f4::22)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:12:09 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::94) by BYAPR11CA0081.outlook.office365.com
 (2603:10b6:a03:f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 09:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 09:12:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 04:12:06 -0500
Received: from [10.136.37.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Sep 2025 04:12:01 -0500
Message-ID: <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
Date: Wed, 3 Sep 2025 14:41:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>
CC: Ben Segall <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance> <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250903071410.GA42@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f9d629-3a9b-4750-eabc-08ddeac9f627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWk2V3d1MHF4bnYxZGtiaUhacWhLMXY5M2cvNE5ub3hTdjVtSEI5OHRVWmVR?=
 =?utf-8?B?bURyMHpzc2VTRXd3QjI4aHVYU3UvVjh3dVBXT25aTUJuQnN3eEFHelg4OVE1?=
 =?utf-8?B?MU1BOUlhR0RNSEY3UjF1UTZ5eFdEdytqd1V1OUN4eFVCdmszZVdPK1dCeTdY?=
 =?utf-8?B?cTBxbmNRdW9la2QrL0tLdmZWeEljYmJRS3pmQUNNaVBXQmw1dGNMeHN0VG52?=
 =?utf-8?B?T0hwT3NxZ0kyMit5QWhXbEFnSXhkdWM1UDcvWWxaS3VXQllQUE1NRXQzSmxS?=
 =?utf-8?B?S3V4U1Y1cjlyMUVUU3lFZDNSdWJzUjlFSkhwNVlZVm54djVzMER4ODc0dXJH?=
 =?utf-8?B?eGtqLzZpZ2tGdDZzMEo2eTYvRUZQMXNmMUwraW56dDVBMDM5MlozV1R3QU5R?=
 =?utf-8?B?WmNDb1dCb3JYMDdscVZXeXRJRjFuOHpqbkM4RjlGT0ZQZUJWVUxGWG5YMjhJ?=
 =?utf-8?B?cXFiaEwwTDkwMVUyMElWYTFJejR3VkgzQkpsMVdLODZIdnVyZmR2QUc1VU1h?=
 =?utf-8?B?YkFUaHlXeXV2VzdUOTB2RjNCUWQrWmUzSllHbXk4TmV6WVNUQ2krSHpzQzNv?=
 =?utf-8?B?bzduNHBpaUltNWV4RVBndERSb3pRNzdoV2l1UXphV2EvdHBMaVp1cmRWRkdm?=
 =?utf-8?B?aXd3RGEwK05mNTB5VFk2WCs5OURYK2tNZlVxMXJkdUJ2dkZTOVJyZ0N4My9W?=
 =?utf-8?B?cEF5VjZsczJHcVBsTVZGYWo0MVRNT3Q5dU02SkxKamV5VStPU1kwZXpCa3di?=
 =?utf-8?B?N3J1NzZ2Q2JtbjViWkVQUEpQc0t1WWdwNHJCTXVPdUhPZDBnb2dWWlVVRDJO?=
 =?utf-8?B?Y2JCZGhPZVJCRnNzN0RMUnFQR0lqUFdGMGpXdk10ajdqeEQ1d05uZk0xMFZ4?=
 =?utf-8?B?dkhiQlR5UkEzY05IekZwU1pTWmZ2cHFKWDgyYVdNQzN6UWNYWS9tNkZGa3FH?=
 =?utf-8?B?MFBQL3VlT1BoT3Vzb1h4SEV6RDFFcVBjVEx0Y0VFMWxua3AzOCtJMHlGa1N3?=
 =?utf-8?B?UytVdTg1RWxBTlFMMk84SkRXaFdMRU9pby96c0NzYUNrV1hSZUdianZpcE02?=
 =?utf-8?B?cDF4RHF0UW5QNGlhM2lISFJtOVFJZE56Z0tId3BWUEFrZDZWZXB5emsrT0pV?=
 =?utf-8?B?eHF3c3psTGR3V015TFI1Zy83QlBlNEViQWp6SWRHRUVoTEtJa3FWY3NWNFVk?=
 =?utf-8?B?dkxJVUswWE9iYUwvTnJaZERGVFlTV24wL285ZmkzMWtFTzYxcmRPVllVWkFN?=
 =?utf-8?B?Y0FwTUo1cjl3blp4eTgzQ3VnNFF4ZjdhaVJKbTlCWEhSZ2dHTDlLcm5zMW5o?=
 =?utf-8?B?aWVrMGo3M0kvU2l6ZGpLWWV4QzllcnVZYUx5cWFpWTZRaGNqMFZlOG5nZGRB?=
 =?utf-8?B?bUFNNWFMZ2NTckhiUUV3R3pnTUJCc25TZWVJZEhBVFk5V2J6QVRoZndKMDNp?=
 =?utf-8?B?K29tWkQxYWtPWm1scThuMm5nTWVxREM2WlQ4azYrenVjQTFBQ3RCL3BOalR1?=
 =?utf-8?B?VW51V0xxWUZFZ1d0NEZ0REcwSFNGWlhCSXZSRytSOXRRbmRFVHlCY1d5RTNW?=
 =?utf-8?B?aHN6Z2d2WUhzTThHdmFkZm0yYXNUeTdzSGxxTXh2aXAwZG14dnk1OEowcitJ?=
 =?utf-8?B?RzZYN0xYWG1sSEZsVEJKZ1Y3cmFYSjIrV1gvUXhvbDVVb1M1WXU0Lzk1TWZX?=
 =?utf-8?B?dzI4UzJUck0wbnl5ZXlGNTNFSkxUbkFvQzNMbjBxUnBFemtVMjVhKzJkeHZR?=
 =?utf-8?B?UEtiWUx1LzdQK0VkR2kvM1F1djFCSWhvUkpaL3dLTTlIS2l4bWtURUp3eVJJ?=
 =?utf-8?B?dWVOSnZKbnZ3MWJZMTVQNDkvTmYzUlUvbjhVQnp2azY1dDZsZ2FKZUpOQlhI?=
 =?utf-8?B?NUFVSmtuZHNsN0FrcC84dDVTK0Y3cXdSbW4zTUxsa3BTdnluOHM3QXhwMXVa?=
 =?utf-8?B?UGlXYWtGSVlreUVCSzQ1aW5sM0IwYktNUDhlODQ0SS91UXprdEoxNGI3SHZU?=
 =?utf-8?B?MUg3UGY4RHlYU1lRUkg3b0JQWXZnSHoyaDg2YWtnYllvRlFCZ2dVQmpNTWdD?=
 =?utf-8?B?V25KRmpMeWF2bTFaUXBwbW1uQXdLTnQ4M2I1dz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:12:09.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f9d629-3a9b-4750-eabc-08ddeac9f627
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

Hello Aaron,

On 9/3/2025 12:44 PM, Aaron Lu wrote:
> On Fri, Aug 22, 2025 at 07:07:01PM +0800, Aaron Lu wrote:
>> With this said, I reduced the task number and retested on this 2nd AMD
>> Genoa:
>> - quota set to 50 cpu for each level1 cgroup;

What exactly is the quota and period when you say 50cpu?

>> - using only 1 fd pair, i.e. 2 task for each cgroup:
>>   hackbench -p -g 1 -f 1 -l 50000000
>>   i.e. each leaf cgroup has 1 sender task and 1 receiver task, total
>>   task number is 2 * 200 = 400 tasks.
>>
>>         base             head               diff
>> Time    127.77±2.60%     127.49±2.63%       noise
>>
>> In this setup, performance is about the same.
>>
>> Now I'm wondering why on Intel EMR, running that extreme setup(8000
>> tasks), performance of task based throttle didn't see noticeable drop...
> 
> Looks like hackbench doesn't like task migration on this AMD system
> (domain0 SMT; domain1 MC; domain2 PKG; domain3 NUMA).
> 
> If I revert patch5, running this 40 * 200 = 8000 hackbench workload
> again, performance is roughly the same now(head~1 is slightly worse but
> given the 4+% stddev in base, it can be considered in noise range):
> 
>          base              head~1(patch1-4)    diff     head(patch1-5)
> Time     82.55±4.82%       84.45±2.70%         -2.3%    99.69±6.71%
> 
> According to /proc/schedstat, the lb_gained for domain2 is:
> 
>          NOT_IDLE IDLE  NEWLY_IDLE
> base        0     8052    81791    
> head~1      0     7197   175096
> head        1    14818   793065

Since these are mostly idle and newidle balance, I wonder if we can run
into a scenario where,

1. All the tasks are throttled.
2. CPU turning idle does a newidle balance.
3. CPU pulls a tasks from throttled hierarchy and selects it.
4. The task exits to user space and is dequeued.
5. Goto 1.

and when the CPU is unthrottled, it has a large number of tasks on it
that'll again require a load balance to even stuff out.

> 
> Other domains have similar number: base has smallest migration number
> while head has the most and head~1 reduce the number a lot. I suppose
> this is expected, because we removed the throttled_lb_pair() restriction
> in patch5 and that can cause runnable tasks in throttled hierarchy to be
> balanced to other cpus while in base, this can not happen.
> 
> I think patch5 still makes sense and is correct, it's just this specific
> workload doesn't like task migrations. Intel EMR doesn't suffer from
> this, I suppose that's because EMR has a much larger LLC while AMD Genoa
> has a relatively small LLC and task migrations across LLC boundary hurts
> hackbench's performance.

I think we can leave the throttled_lb_pair() condition as is and revisit
it later if this is visible in real world workloads. I cannot think of
any easy way to avoid the case for potential pileup without accounting
for the throttled tasks in limbo except for something like below at
head~1:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bdc9bfa0b9ef..3dc807af21ba 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9385,7 +9385,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) throttled_lb_pair, or
+	 * 2) throttled_lb_pair unless we migrate load, or
 	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 4) running (obviously), or
 	 * 5) are cache-hot on their current CPU, or
@@ -9394,7 +9394,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
-	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
+	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu) &&
+	    env->migration_type != migrate_load)
 		return 0;
 
 	/*
---

Since load_avg moves slowly, it might be enough to avoid pileup of
tasks. This is similar to the condition for migrating delayed tasks
above but unlike the hierarchies of delayed tasks, the weight of
throttled hierarchy does change when throttled tasks are transitioned to
limbo so this needs some more staring at.

> 
> I also tried to apply below hack to prove this "task migration across
> LLC boundary hurts hackbench" theory on both base and head:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c2..34c5f6b75e53d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9297,6 +9297,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
>  		return 0;
>  
> +	if (!(env->sd->flags & SD_SHARE_LLC))
> +		return 0;
> +
>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>  		return 0;
>  
> With this diff applied, the result is:
> 
> 
>          base'              head'              diff
> Time     74.78±8.2%         78.87±15.4%        -5.47%
> 
> base': base + above diff
> head': head + above diff
> 
> So both performs better now, but with much larger variance, I guess
> that's because no load balance on domain2 and above now. head' is still
> worse than base, but not as much as before.
> 
> To conclude this: hackbench doesn't like task migration, especially when
> task is migrated across LLC boundary. patch5 removed the restriction of
> no balancing throttled tasks, this caused more balance to happen and
> hackbench doesn't like this. But balancing has its own merit and could
> still benefit other workloads so I think patch5 should stay, especially
> considering that when throttled tasks are eventually dequeued, they will
> not stay on rq's cfs_tasks list so no need to take special care for them
> when doing load balance.

Mathieu had run some experiments a couple years ago where he too
discovered reducing the number of migrations for hackbench helps but it
wasn't clear if these strategies would benefit real-world workloads:

https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoyers@efficios.com/ 
https://lore.kernel.org/lkml/20231018204511.1563390-1-mathieu.desnoyers@efficios.com/

> 
> On a side note: should we increase the cost of balancing tasks out of LLC
> boundary? I tried to enlarge sysctl_sched_migration_cost 100 times for
> domains without SD_SHARE_LLC in task_hot() but that didn't help.

I'll take a look at sd->imbalance_pct and see if there is any room for
improvements there. Thank you again for the detailed analysis.

-- 
Thanks and Regards,
Prateek


