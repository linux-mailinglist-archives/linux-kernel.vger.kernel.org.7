Return-Path: <linux-kernel+bounces-811374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66BB52834
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A295467F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06110245019;
	Thu, 11 Sep 2025 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p6cUgwhi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E7C148
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569240; cv=fail; b=IijJh4UInSBLj9kuNM5769w6i9F25i9FknnWAWTNW3TUDhnZxSn489qwidKADuFlkrYm53r+eXGltZGIq43spi2DsPDlGj79DUtP2DHz78t3zCAm5rD48p0B0nBc8DR4ZjERLX2SJcUib7DXgXfnPTf0VNhCtg0w0YPgPuJH95k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569240; c=relaxed/simple;
	bh=a27quoBda2QGiO8Z829Wg7QUwFJWpSUDdHGHmqYsTaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yl9n1pOZGQwm7W/UDyjwx+mG2DAkvET7GwhEqjQ/UhfYCslawXvhyh/SLCpNKtWHL6cJ95oSpNNOrVvAeTx8akQ3Gb4d+XVyy65bfEo6ajnhIYCEEMU6bE8iQKj28D3LV31hxmYIwIwIBzCM2Wdkh2oc/5JDLJiR+1sTe5Oa6xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p6cUgwhi; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEKHo4ydIJIj7BND0hfS3kck5egJqxOKEHQ0Q/Fay/hfqRfu0IU3zBrQvDotR7V9X36jxNEbZUG/ffaxP3eoJgQyQPE5BmpJGzcuPVZYXNHVQC6KjrPHnJt8MdtL+qZCe6Ymi/3/exUofcJsnfxmN02sepdB2bKMHb5VAe8ukR7XRdV/bSIpcgjqNzOzjsA1lKMB8OveVYgSzwxUzzmhrCfgO3YGGXywZmU/N0MuX3v1S6h+gi2MupOQMRlqdiz/iLdWwMe7M1Lll2RXCdWBhug83pyhFbC8H68nippFrvz7QYmAzp7/nad8cWXiEvbUEn3++w7rg1wcoVAAYgkcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bhGvvGs6m5OQiJJbTDFDoRknnMkgN6p93h4vs0SkAI=;
 b=PzLG/6PmN2x73gUdEbkC7WOFPn5iOaWvFJ8r5X1ww/KFQ4nSqNFRtHjV2hqLxB95CvQdy8PSMzDyofLtBRI7LJifyc542ZmHLbQarjcBl7ehGT4R9SDNTSBcAtVBHvu0OEj/atdGdc+OfSbkfsCZqw9TCT6qi9EAlOCj2EvpHW5/GZme6fvGnDWHDju0xqZnJwcyk+hOiS3CMge/EbvB5jXyYkfMPkhmquouTpccsJdNgAOiOMEDgLtiWWXOVERan7Strn6b6/UqQbH7J+RjOFwz5NMx9f6S9p3O7sfS/Da0iuj0G5txPQbs6Ghs2IosQ9nVyIzbSlpgKEmQTvzGsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bhGvvGs6m5OQiJJbTDFDoRknnMkgN6p93h4vs0SkAI=;
 b=p6cUgwhiyxGzdQOBwQG3tNh8OgkOex3oygMMMPpebZxSXaqbNaNVTuGPdxhjxNFr2o6AVs1gO4NhfLsdTPHYTPNV1VguUIprBtPT0w5EM9zSqTBRd480l9IpQBVB2HH7wJh+SAgtsU7m8t1zZVQbfGzDom7tevDVqyGcP4QmEDo=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 05:40:31 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::6b) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 05:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 05:40:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 22:40:30 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 00:40:29 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 22:40:23 -0700
Message-ID: <7227822a-0b4a-47cc-af7f-190f6d3b3e07@amd.com>
Date: Thu, 11 Sep 2025 11:10:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/10] sched/core: Push current task from paravirt
 CPU
To: Shrikanth Hegde <sshegde@linux.ibm.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <tglx@linutronix.de>, <yury.norov@gmail.com>,
	<maddy@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <gregkh@linuxfoundation.org>
CC: <vschneid@redhat.com>, <iii@linux.ibm.com>, <huschle@linux.ibm.com>,
	<rostedt@goodmis.org>, <dietmar.eggemann@arm.com>, <vineeth@bitbyteword.org>,
	<jgross@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-8-sshegde@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250910174210.1969750-8-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e0cd82-9c41-4863-fdc3-08ddf0f5b8d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVR6YTdONHVQMHFDTzgxaWhrTlM1RzRSU3dycjc4YTEzVnIzbHlmcFY4WDRy?=
 =?utf-8?B?bnM2QmxJNk9UTkNZb1dBRm84YnAwUXVkdjNVSlhmSHZScjdpeXpta1Y5dXc1?=
 =?utf-8?B?a0tTRVUxU3BpdEd3cEwvVUxFRStBQzUrU3lkOXZFdW9YTG02VEtvdkNtTjJS?=
 =?utf-8?B?NmlGaXYyczl1RWd1cUpUMVkzS1I0bDNxRHNCbFdla2dXeDVtVFpYRFBWNzVV?=
 =?utf-8?B?Z3JlY1ljQXU1ZzY5MnROdWNVRXRDY3M0OEczNmdJUHFrWU9YaEc1RkI2MCtL?=
 =?utf-8?B?RmZHZmJXQnpwbUhXSjBoaHhLbWo2M3oreWJlQmZnNXBnSnhwbmZmR0FvRVho?=
 =?utf-8?B?aDVIc2RuMWpJY3dYbHp5dCt5djZQOVdyeWZyTHpzaklmQUJKRVc5V3MxQlVD?=
 =?utf-8?B?TFVlUFdJR1NwVjcvblhGTTBtQ0c1cFdpZUxsN1NaV3hlM1FaM210eE1ieWN5?=
 =?utf-8?B?dEQ2TjBnaTJwL3VDNVNFaFFrU0EwNWhVT2FiZFl1UlJoQkpYcUlEYWZlYmM1?=
 =?utf-8?B?eEYwUDJFUlBkc0ZrTktJb2FrTDBsZFFpeS91SWVwTWQ4R3NrblBxZXRCV3hM?=
 =?utf-8?B?VVJMMlV4QWVWMXhGN1pLMzl4dUdJc20xa3huQmM3U09UMmc0WnhiKzRzZWFu?=
 =?utf-8?B?RDUvdFdVaTRZT1lSL1dUTmlWQ0s4c0RuL3VlRW9hSXR3OTJBZWR4c0VmWGFO?=
 =?utf-8?B?NDlNVHZKSGxUbE92L3pTSWcxTXg3bmlpUlpiVXJqck1WQVBtb2g3R1Jic0lH?=
 =?utf-8?B?VVRTMUlUWExZeFVNNWlWNnNwZ1lqNklHWWIxcnN1L28xMzNJaFgzcS9VSzBS?=
 =?utf-8?B?Uzkra3lsdWRaL2FubmNJRzYyYjlPSjAvVWt4bjhCdUs1THFqVEhoQ1R2dXg1?=
 =?utf-8?B?SmE0OHpFd0tjS01tcThhTWFVdTdjV05KeUlXWk9vRzNweTdRWllRMlNaRXVQ?=
 =?utf-8?B?RU11UzZDb2xVcW9KVXZPMi9JbEQwUjBCUXFlVDV2SlRsL3ZGTzZxYkExQlg1?=
 =?utf-8?B?Z2hyRWtnbzFFY1F5UFd3NndWcG9XSGY3eHRFU3V4dmU4YUxXM2JZL3FDbk4r?=
 =?utf-8?B?MGpST3lRbExvWENnb3A5bndKdytNQXBJOE9tMlgwNlQ0VUZjRkp5bWZGQ2NZ?=
 =?utf-8?B?aTJia29UY3ZoS1hLTFFLQ0lSRW40K2VIa016ZnQwQ2R3RWJITlRzSTZRY3NI?=
 =?utf-8?B?eGxieExZNzl2YVZDc1pmU0JSZE4zMEc0WGlHbVcwVENGeDdST0d2MHFHRG84?=
 =?utf-8?B?dzFXM3J6enhibGkwUEdrY2kwN3pMQlpsZDExMDMyUUlTZlArRWRZNWxhZzE2?=
 =?utf-8?B?c2pTbUEvNTAvaWl0NnFWRlhTYjFub1ZtQmhFTmo1OGM1b2pmaVZ6ZWFCRE9X?=
 =?utf-8?B?a2VGR3V0dkwwL2FFbDNsUUkza284T3l4TWRMZG5DK1FaRytjUDhVdjUrSURm?=
 =?utf-8?B?MXRBTXRvOHZxa1VmbWl6bng1b1BHZ0tDUU9qeWhxd2VOL0cyNE5tTHNGd2d6?=
 =?utf-8?B?WmlodDlWcjl0OG9iUHByV0h6VVlDdGNjdEhKMFZzQUZtSmNBY0poTGl0MEw4?=
 =?utf-8?B?VE1JY0twZGFoeStQdytVWTA2VjZkV01DSk1aU1NobUh3bUV4bGROUzNyVGJw?=
 =?utf-8?B?NjZrc2wvR044bUlvUmRBeTdUdS9yZGhxVEg0NWlkbFFoQVBZdXpCdVNHRzlk?=
 =?utf-8?B?YnV1b2dRMEZ1L2Z0czZpWnZYZnlnTkNxb3hjMHErdWliQTJuZHMxTGZWTXNp?=
 =?utf-8?B?TUNPL1BXMUhWajBQb24wVExZWTRsNVd4T1lVK1VjeE9HTXBVTUdXblA0Um9z?=
 =?utf-8?B?UXVQVkluK1NLdFRQekpWdFdpY3JpSndTbk8rQ25ESDJ2YzFVU1BJZ3E3bkZk?=
 =?utf-8?B?aDY2a1lFVUJwd2hMQkNmNEU5cXZRRlRJTU5pNWg4SFUwL0RidmZGSGtiWnZO?=
 =?utf-8?B?MlRFclVyQmVpUTJqd1BEcjNxdVBYSHV6akxHMEhRQ0VNWkNEVVowUk1UUjln?=
 =?utf-8?B?SldTWWt2T21WaWpGS3pQTG9sYm5hSm9WQU9oamNzQjlFMUNpWStheS9LSE4r?=
 =?utf-8?B?cDBnWVozU2I4cDZ0T1FHY1luQ1Mzd0t2aGREQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:40:31.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e0cd82-9c41-4863-fdc3-08ddf0f5b8d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982

Hello Shrikanth,

On 9/10/2025 11:12 PM, Shrikanth Hegde wrote:
> Actively push out any task running on a paravirt CPU. Since the task is
> running on the CPU need to spawn a stopper thread and push the task out.
> 
> If task is sleeping, when it wakes up it is expected to move out. In
> case it still chooses a paravirt CPU, next tick will move it out.
> However, if the task in pinned only to paravirt CPUs, it will continue
> running there.
> 
> Though code is almost same as __balance_push_cpu_stop and quite close to
> push_cpu_stop, it provides a cleaner implementation w.r.t to PARAVIRT
> config.
> 
> Add push_task_work_done flag to protect pv_push_task_work buffer. This has
> been placed at the empty slot available considering 64/128 byte
> cacheline.
> 
> This currently works only FAIR and RT.

EXT can perhaps use the ops->cpu_{release,acquire}() if they are
interested in this.

> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/core.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  9 ++++-
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 279b0dd72b5e..1f9df5b8a3a2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5629,6 +5629,10 @@ void sched_tick(void)
>  
>  	sched_clock_tick();
>  
> +	/* push the current task out if a paravirt CPU */
> +	if (is_cpu_paravirt(cpu))
> +		push_current_from_paravirt_cpu(rq);

Does this mean paravirt CPU is capable of handling an interrupt but may
not be continuously available to run a task? Or is the VMM expected to set
the CPU on the paravirt mask and give the vCPU sufficient time to move the
task before yanking it away from the pCPU?

> +
>  	rq_lock(rq, &rf);
>  	donor = rq->donor;
>  
> @@ -10977,4 +10981,84 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>  struct cpumask __cpu_paravirt_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_paravirt_mask);
>  DEFINE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
> +
> +static DEFINE_PER_CPU(struct cpu_stop_work, pv_push_task_work);
> +
> +static int paravirt_push_cpu_stop(void *arg)
> +{
> +	struct task_struct *p = arg;

Can we move all pushable tasks at once instead of just the rq->curr at
the time of the tick? It can also avoid keeping the reference to "p"
and only selectively pushing it. Thoughts?

> +	struct rq *rq = this_rq();
> +	struct rq_flags rf;
> +	int cpu;
> +
> +	raw_spin_lock_irq(&p->pi_lock);
> +	rq_lock(rq, &rf);
> +	rq->push_task_work_done = 0;
> +
> +	update_rq_clock(rq);
> +
> +	if (task_rq(p) == rq && task_on_rq_queued(p)) {
> +		cpu = select_fallback_rq(rq->cpu, p);
> +		rq = __migrate_task(rq, &rf, p, cpu);
> +	}
> +
> +	rq_unlock(rq, &rf);
> +	raw_spin_unlock_irq(&p->pi_lock);
> +	put_task_struct(p);
> +
> +	return 0;
> +}
> +
> +/* A CPU is marked as Paravirt when there is contention for underlying
> + * physical CPU and using this CPU will lead to hypervisor preemptions.
> + * It is better not to use this CPU.
> + *
> + * In case any task is scheduled on such CPU, move it out. In
> + * select_fallback_rq a non paravirt CPU will be chosen and henceforth
> + * task shouldn't come back to this CPU
> + */
> +void push_current_from_paravirt_cpu(struct rq *rq)
> +{
> +	struct task_struct *push_task = rq->curr;
> +	unsigned long flags;
> +	struct rq_flags rf;
> +
> +	if (!is_cpu_paravirt(rq->cpu))
> +		return;
> +
> +	/* Idle task can't be pused out */
> +	if (rq->curr == rq->idle)
> +		return;
> +
> +	/* Do for only SCHED_NORMAL AND RT for now */
> +	if (push_task->sched_class != &fair_sched_class &&
> +	    push_task->sched_class != &rt_sched_class)
> +		return;
> +
> +	if (kthread_is_per_cpu(push_task) ||
> +	    is_migration_disabled(push_task))
> +		return;
> +
> +	/* Is it affine to only paravirt cpus? */
> +	if (cpumask_subset(push_task->cpus_ptr, cpu_paravirt_mask))
> +		return;
> +
> +	/* There is already a stopper thread for this. Dont race with it */
> +	if (rq->push_task_work_done == 1)
> +		return;
> +
> +	local_irq_save(flags);
> +	preempt_disable();

Disabling IRQs implies preemption is disabled.

> +
> +	get_task_struct(push_task);
> +
> +	rq_lock(rq, &rf);
> +	rq->push_task_work_done = 1;
> +	rq_unlock(rq, &rf);
> +
> +	stop_one_cpu_nowait(rq->cpu, paravirt_push_cpu_stop, push_task,
> +			    this_cpu_ptr(&pv_push_task_work));
> +	preempt_enable();
> +	local_irq_restore(flags);
> +}
>  #endif
-- 
Thanks and Regards,
Prateek


