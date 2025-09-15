Return-Path: <linux-kernel+bounces-816576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A1B5759F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5695D1AA0C0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2D42FAC15;
	Mon, 15 Sep 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OHm7bB/l"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1F82FA0FB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930844; cv=fail; b=cbYbfQB3+2to7fl6yIeTFNZxxevgVcmxsd5KxhVAmgAa24pKcOawuJ9j8/KFl1GN1JO+h37FU9NFW9yvadgCLtnZzXnQuJmjPobOVwW6btrJKF7NyuK7OoZcbgFFznl7QOsG2maUVRRFzUAMJvt2hSkAoV5yp2YUY0z82yvSw04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930844; c=relaxed/simple;
	bh=fXA0P9ssWRpRL55JBO47wCj/kJ0wD4jvB6nJXml8lrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JEqHoBE4z77DNGc3YQyrSrtCChDDxvkJyVyV9ssbHn0dRf8S494wdccRjPnxZFVAKOrI07ugtcfUKpJlBnR66oDE4NGGbHPOWzFUyZ+aa/98S+MOx5ZozA+WZFVfPyGh9CMsj8PDswxoU+/0yyPLz5vVLoYEA+X2rFXJWTC+ohk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OHm7bB/l; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPleYuNo8lcUmHLvyzWZmwqLSRh7gh8ba9CZk3yhoaL/BLEiZsLVl54ExAkmYwCHOOYiFeYZlP0sAs5f8tkWApEG6dXnIVHaqNjuqafPL3Vc3BgqCGnzv569jA8s2x9erA/bgor6zDSQMvo34O/Rhicux+Vb7OuCIgyHjP/Qff7X0bGBf7j3Y+EcfChFI8aa1D7/+wLAtasQvUsTMD7IsNmD2Xu7IzNs6FG2o/Exz3UGCsguH8x0vqAqoYSe774GBrU0dKvlAkZnvkyFYkcQDNbQPMAdVIbxOxOlvFfqybXpcD89uBLfOfav7IB1OkPY16cQhgFdMRd12XFW/Tt0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QnvuKkE96vYpkxWiCIz85OGpnB0vHfLHGC/8xx5+7hw=;
 b=s0op8mAtnlZBybHrgRwsIcKMB1hNuz9l2VI/3G3sNcU6HZ4+p1uEi7U5959pCuPc6PLCc8gWcL3E4E4E5/s7HP1YOrgSikY2BBMskoczr07aGR0sjIhSo7fJgeYGouc2fdjGUcwYgBffPxzx8PQ8LgYqJLg5dx8EpANOaz5nRauxVFbwKvZPtVs8IR6RkFwZ1LGQXVV1UKg29dBMPsblbxIrgqiJ5L5j0BuJW6j3qiMRP53dFJ9WTzPutxTKhUJPOT0SJucD+a68XhP/fUgpbxGVTW3rPEb5TKJwWJkDFChedAeChMdgPhmWMymAOFpGMnPIxjO9LwZ/YUtppuSLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnvuKkE96vYpkxWiCIz85OGpnB0vHfLHGC/8xx5+7hw=;
 b=OHm7bB/l55V/DlaL+YO9tXp/92FMyYGkwGrk8ggQDBpaSxVqCpmQvmcXajgkK6rPHduAIsnmhsu6YtjjvVdC9gIAFmkcjHHXUMPZzIMeDZJml39+is2lKGzPUksCDg0IdidNfYWNYMGAg5/9CEdna9dyrqt74thujfsSLxykyfM=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 10:07:11 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::63) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 10:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 10:07:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Sep
 2025 03:06:59 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Sep
 2025 05:06:59 -0500
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Sep 2025 03:06:52 -0700
Message-ID: <befadd44-9549-4400-ab28-b8aef55cd73d@amd.com>
Date: Mon, 15 Sep 2025 15:36:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 4/6] sched: Handle blocked-waiter migration
 (and return migration)
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20250904002201.971268-1-jstultz@google.com>
 <20250904002201.971268-5-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-5-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f777c6-b8b2-41c6-0bc1-08ddf43fa34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUt0VFJtK3ZxdFpzZWVWS3BJaGhvcnhueDFzSnRmYnJaSkFmQmRiKzJ5Nmdn?=
 =?utf-8?B?bFBGc2RKNWQ3dVJjMjlHRXpnRE1aL3dGcXZ6bzZqSjZscGd6aXd3YW5LcHh6?=
 =?utf-8?B?VkUydHE2d1ZacmFoVWh0L0c2Y2tSVitzVHdhbFlVQ002QU8vaWFheHNSTmRQ?=
 =?utf-8?B?em84WXhEVnhQUzVJclpwaGNEYnN5N2tsazg4dThxWW9lWFNkbHZHdzlIaUlv?=
 =?utf-8?B?WDVhWTR4UWpkZUZ0M0dLaG5PYlhVOWdxWnh5SklCMHBPSUUzb1ZBQmgxckR4?=
 =?utf-8?B?dHpVQXFTUVU5YlUybzZIaU1kaUhKWmY2Y3M0cHVMbnpMT3hsdXc2N1hCUk44?=
 =?utf-8?B?V0pGd2JLalk1WlpiWW1zck1YaytIN1NZMHE0ZWJWNW9rR0l3bDgvWk42c25l?=
 =?utf-8?B?WGxkOXk5MDNveFIySHR5OFdwemoycHVNVG5GMDVOeDJTbWtRdkZVR1owTDAz?=
 =?utf-8?B?TE5ZVXBadXJWakg3Vkt5c05VOGdacWZSMCs4N2o1Y21JRVNKS3VaSElEeGZ5?=
 =?utf-8?B?bmZOSW5pSXA5eHBaQlRmQ3d6MEJiMFNUbTRJNjE3SU50b3BhQnQ3YjN2N2Fx?=
 =?utf-8?B?eFVwTWJib2pmb0l3dFl2dDE1aGFpVTVyellmK2tJT1FNWWxUd0QrV3FlYW9O?=
 =?utf-8?B?WlJRUklzS0RiTnJlOWZ3b3NZbktUUUlQQ1AxNmYwQlJYdUxRVElFQWVMQ0Q4?=
 =?utf-8?B?bWRoZnJoRURheTdpd1VCQmZOVklYT2E0cjFaV2FXUGdQYVI5UmRpSVhCS3VO?=
 =?utf-8?B?TTAxK09DQ3JsVUMwNlZVYjM0eS9CRXZBcXc5ZFV1MnFmT2ZXOEJzOW1RL1Mv?=
 =?utf-8?B?enNlMWxMRzdxZ3FCZWFZb2MxWVFLcEt6V09UeWlFKzAyNkFSZXJTOUZ0RGJp?=
 =?utf-8?B?RGhIRGF0dTM2cjV0dndocmRMaVVYc2cxODZWSmdTeUZTTTZKdUFseHdUaVpO?=
 =?utf-8?B?bzZ0cE9nd3hVQzZBVXJKQjJya2VTMmFxOWRrbkNTdmI5WUZSdjZJalBPaU0w?=
 =?utf-8?B?dG5vWHJsYmV6Rk9oOHRBS3RGYmNJeWd0eWxhRkpHUk5HY3Y5WDBIZHQwTUNQ?=
 =?utf-8?B?amV5M21mdk95VUdUaHlNNmtXL1VSb1hzY0ZqNHJJOG9meGNEaFhFdk12cm1t?=
 =?utf-8?B?bk1WNU4xZmxMd3VMUHN3S2FTNUxLMDhTRHBmUjBTaDhHSFFWMzZpQkxkdzMr?=
 =?utf-8?B?MDJWNnA0Rng3MC9uN2p2b3JwVERCRFdVdGdZaFk3eXRhcTVicDZSOHZtbEFB?=
 =?utf-8?B?WWE0emhTQS9xdk5nb2E4UUVqNU9uWnMvZmpaT1BzQUFWWndJdk1lODhkVlQ5?=
 =?utf-8?B?Q0xjNG5JSkU0d3h0cHlieWJzR3M0bWFsRnVGN1RnNVUrV1lLMGtSVGo2UHpw?=
 =?utf-8?B?VTZISEJHQ3BNMzF2QmQyS28xMHBQSnhhRXZTVUxvQ05JbUswMGNQdENSR0Q5?=
 =?utf-8?B?QW9JSE91YnFhVUM4LzdEbFlqeEkzbmNmTkh3RFVUTXlka0ZyT0l5UzkrcXVT?=
 =?utf-8?B?aE1seGtjOEJod3RWbG5qZkYzVGxlSzlISWhOU3lHMnczU1ROUFJQWEpNNDFX?=
 =?utf-8?B?WlRZcEs4QXJ5TTJnODA0YlNsSEtTNWpNcDNPdWZVRHZUdElNWXN6NXRkOGc5?=
 =?utf-8?B?TzdCYWxYbUszaFVpRm0rNXhIY3VYYUVXREdRKzIxeTNBc3NnT0RLVnEzQTlU?=
 =?utf-8?B?ZDZpVjQ5Z2YwT1dCOXpMUWxMdVFEa29ZZWRSWmZSSzgyOFlwd1RSY3BNeHFp?=
 =?utf-8?B?Q1loTTJBejE1UXRIYkxOeDY5bk5aOVNuS3IzSjhBOENzYmZyS3lUa0pta0Va?=
 =?utf-8?B?SVU3MkEwZGlmUG40eWY2NzFDZzU5M29vSFN0MWMxTTVYM3J6dE4vWHRnTXF0?=
 =?utf-8?B?bFEycE05RG1UTlFvRm5BRXhOdmxzM0tQcmRkbHliazY4NmdPemdnek8zWDg5?=
 =?utf-8?B?akxDdDhpc3BYVmVMOUJhc1krYnVSeWZVWi81V05VZDhhc01BUDlVZ2xGTjFq?=
 =?utf-8?B?YWNQYStFUG5XUENMeCtDUmhXNzJxZkc4WGNaVGIxOG1BUE55NG1KSzdFY2Jk?=
 =?utf-8?Q?ShWodH?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:07:11.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f777c6-b8b2-41c6-0bc1-08ddf43fa34f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
> @@ -6655,17 +6731,98 @@ static bool __proxy_deactivate(struct rq *rq, struct task_struct *donor)
>  	return try_to_block_task(rq, donor, &state, true);
>  }
>  
> -static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *donor)
> +/*
> + * If the blocked-on relationship crosses CPUs, migrate @p to the
> + * owner's CPU.
> + *
> + * This is because we must respect the CPU affinity of execution
> + * contexts (owner) but we can ignore affinity for scheduling
> + * contexts (@p). So we have to move scheduling contexts towards
> + * potential execution contexts.
> + *
> + * Note: The owner can disappear, but simply migrate to @target_cpu
> + * and leave that CPU to sort things out.
> + */
> +static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p, int target_cpu)
>  {
> -	if (!__proxy_deactivate(rq, donor)) {
> -		/*
> -		 * XXX: For now, if deactivation failed, set donor
> -		 * as unblocked, as we aren't doing proxy-migrations
> -		 * yet (more logic will be needed then).
> -		 */
> -		force_blocked_on_runnable(donor);
> -	}
> -	return NULL;
> +	struct rq *target_rq = cpu_rq(target_cpu);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * Since we're going to drop @rq, we have to put(@rq->donor) first,
> +	 * otherwise we have a reference that no longer belongs to us.
> +	 *
> +	 * Additionally, as we put_prev_task(prev) earlier, its possible that
> +	 * prev will migrate away as soon as we drop the rq lock, however we
> +	 * still have it marked as rq->curr, as we've not yet switched tasks.
> +	 *
> +	 * After the migration, we are going to pick_again in the __schedule
> +	 * logic, so backtrack a bit before we release the lock:
> +	 * Put rq->donor, and set rq->curr as rq->donor and set_next_task,
> +	 * so that we're close to the situation we had entering __schedule
> +	 * the first time.
> +	 *
> +	 * Then when we re-aquire the lock, we will re-put rq->curr then
> +	 * rq_set_donor(rq->idle) and set_next_task(rq->idle), before
> +	 * picking again.
> +	 */
> +	/* XXX - Added to address problems with changed dl_server semantics - double check */
> +	__put_prev_set_next_dl_server(rq, rq->donor, rq->curr);

Given we are tagging the rq->dl_server to the donor's context, should we
do:

    __put_prev_set_next_dl_server(rq, rq->donor, rq->idle);

... since we are setting rq->idle as next task and the donor?

On a side note, this can perhaps be simplified as:

    put_prev_set_next_task(rq, rq->donor, rq->idle);
    rq_set_donor(rq, rq->idle);

put_prev_set_next_task() will take are of the dl_server handoff too.

> +	put_prev_task(rq, rq->donor);
> +	rq_set_donor(rq, rq->idle);
> +	set_next_task(rq, rq->idle);
> +
> +	WARN_ON(p == rq->curr);
> +
> +	deactivate_task(rq, p, 0);
> +	proxy_set_task_cpu(p, target_cpu);
> +
> +	zap_balance_callbacks(rq);

Is this zap necessary? Given we return NULL from find_proxy_task() for
migrate case, __schedule() would zap the callback soon. I don't see
any WARN_ON() for the balance callbacks in the unpin + repin path so
this might not be necessary or am I mistaken?

> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +	raw_spin_rq_lock(target_rq);
> +
> +	activate_task(target_rq, p, 0);
> +	wakeup_preempt(target_rq, p, 0);
> +
> +	raw_spin_rq_unlock(target_rq);
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +}
> +
> +static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p)
> +{
> +	lockdep_assert_rq_held(rq);
> +
> +	put_prev_task(rq, rq->donor);
> +	rq_set_donor(rq, rq->idle);
> +	set_next_task(rq, rq->idle);

Similar set of comments as above.

> +
> +	WARN_ON(p == rq->curr);
> +
> +	set_blocked_on_waking(p);
> +	get_task_struct(p);
> +	block_task(rq, p, 0);
> +
> +	zap_balance_callbacks(rq);
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	wake_up_process(p);
> +	put_task_struct(p);
> +
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +}
> +
> +static inline bool proxy_can_run_here(struct rq *rq, struct task_struct *p)
> +{
> +	if (p == rq->curr || p->wake_cpu == cpu_of(rq))
> +		return true;
> +	return false;
>  }
>  
>  /*
> @@ -6688,9 +6845,11 @@ static struct task_struct *
>  find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  {
>  	struct task_struct *owner = NULL;
> +	bool curr_in_chain = false;
>  	int this_cpu = cpu_of(rq);
>  	struct task_struct *p;
>  	struct mutex *mutex;
> +	int owner_cpu;
>  
>  	/* Follow blocked_on chain. */
>  	for (p = donor; task_is_blocked(p); p = owner) {
> @@ -6716,6 +6875,10 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  			return NULL;
>  		}
>  
> +		/* Double check blocked_on_state now we're holding the lock */
> +		if (p->blocked_on_state == BO_RUNNABLE)
> +			return p;
> +
>  		/*
>  		 * If a ww_mutex hits the die/wound case, it marks the task as
>  		 * BO_WAKING and calls try_to_wake_up(), so that the mutex
> @@ -6731,26 +6894,46 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  		 * try_to_wake_up from completing and doing the return
>  		 * migration.
>  		 *
> -		 * So when we hit a !BO_BLOCKED task briefly schedule idle
> -		 * so we release the rq and let the wakeup complete.
> +		 * So when we hit a BO_WAKING task try to wake it up ourselves.
>  		 */
> -		if (p->blocked_on_state != BO_BLOCKED)
> -			return proxy_resched_idle(rq);
> +		if (p->blocked_on_state == BO_WAKING) {
> +			if (task_current(rq, p)) {
> +				/* If its current just set it runnable */
> +				__force_blocked_on_runnable(p);
> +				return p;
> +			}
> +			goto needs_return;
> +		}
> +
> +		if (task_current(rq, p))
> +			curr_in_chain = true;
>  
>  		owner = __mutex_owner(mutex);
>  		if (!owner) {
> +			/* If the owner is null, we may have some work to do */
> +			if (!proxy_can_run_here(rq, p))
> +				goto needs_return;
> +
>  			__force_blocked_on_runnable(p);
>  			return p;
>  		}
>  
>  		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
>  			/* XXX Don't handle blocked owners/delayed dequeue yet */
> +			if (curr_in_chain)
> +				return proxy_resched_idle(rq);
>  			goto deactivate_donor;
>  		}
>  
> -		if (task_cpu(owner) != this_cpu) {
> -			/* XXX Don't handle migrations yet */
> -			goto deactivate_donor;
> +		owner_cpu = task_cpu(owner);
> +		if (owner_cpu != this_cpu) {
> +			/*
> +			 * @owner can disappear, simply migrate to @owner_cpu
> +			 * and leave that CPU to sort things out.
> +			 */
> +			if (curr_in_chain)
> +				return proxy_resched_idle(rq);
> +			goto migrate;
>  		}
>  
>  		if (task_on_rq_migrating(owner)) {
> @@ -6817,8 +7000,18 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  	 * blocked_lock released, so we have to get out of the
>  	 * guard() scope.
>  	 */
> +migrate:
> +	proxy_migrate_task(rq, rf, p, owner_cpu);
> +	return NULL;
> +needs_return:
> +	proxy_force_return(rq, rf, p);
> +	return NULL;
>  deactivate_donor:
> -	return proxy_deactivate(rq, donor);
> +	if (!proxy_deactivate(rq, donor)) {
> +		p = donor;
> +		goto needs_return;
> +	}
> +	return NULL;
>  }
>  #else /* SCHED_PROXY_EXEC */
>  static struct task_struct *
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c2..cc531eb939831 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8781,7 +8781,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>  	se = &p->se;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -	if (prev->sched_class != &fair_sched_class)
> +	if (prev->sched_class != &fair_sched_class ||
> +	    rq->curr != rq->donor)

Why is this special handling required?

>  		goto simple;
>  
>  	__put_prev_set_next_dl_server(rq, prev, p);

-- 
Thanks and Regards,
Prateek


