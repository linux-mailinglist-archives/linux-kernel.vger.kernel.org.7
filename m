Return-Path: <linux-kernel+bounces-879496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B9EC233F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1C194E3C10
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778BD2BEFF1;
	Fri, 31 Oct 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EdsokV+0"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E772BEC2B
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761884891; cv=fail; b=lNOz6G61Bh526rOAgT31vzLn4gV6WqtWtd3RuWtJ/oipjJcCOKEIPjErpZLsEFS1BzQ33C28A0I98vZ/kQ1pJWzmAju0yTpkH7AUeStnhZVrNtYNt4Eid9PsvYBFU5R/XJx9C/oULdBgRKbmEMNf6GZ5K/MlGFLq3GB+bodgg7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761884891; c=relaxed/simple;
	bh=Wz304JdNYdhhAJJh5+Zh3F8UrRq/XqkSjU59gyHXyWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xm92MJrpzluOzZIT5UroO//rahNBs9X2cPWBwUJX282kO/U3Q4Qib5iTjST5W36ulyRF6NnheJA0ekwGWUTEgOfsHHiAMqLMGEruStj47pzW9HqOvf4yLoTQgPNxHfkTAiu/TFVEN5yv0PWRpVPh82Sf+iSHRqEkwuKqx0ZlUFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EdsokV+0; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ric/YomEaznUxgVrf8wqIL/n0JTkn5dw/+Cm6VJ11eRC1PL5wzsTl6ZxBWZquhieyg+6KMW06oxfFtzd3QPi5NbYcuiLlarNvV9dpQGnCjBI1JdhXd+FlwZDj4DtxQ5rsKZ2OOkncdnUptos5gQ4m+wgsvNDom0NK+G5emuxU2xUrWqvEy3Zju39h+gf/XnlwZ9qC+JeWoAWjJsGbDUNXdbK19/KU9A4kOp/TY5Tsjgup/jwoRRiS3vRxLaOyscTdtvHtXOdKW7mwcnl8D3VhIvsssvT/PGMaasIi9TkEJMMBJV0HSF0oxjgiNWwLGvsCqosxqWYCeFCFteVlZoUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4KQM6/w+YaPLRuTucRtQz97SeRd8V953LKDu8i9P6k=;
 b=gX+y68MYXc9Ui01gCHkGXdVDC4/RkjEUzIXkgaivPTtivS9nQUc+5QPORskWpt6SjpN7s2muuOn6E93P1s8cnjkIYzbEib/FWU/kSnDLOIWmfXn0WfB/MCa1SQtSu7lDnNXTznJQsUwxbfB1dzebUAWu0pk4Cmamc9JtrW1pws1dL5++B0OoOSPnExNZlVR1aTfG2RrF0ayE+6ag5Z9Ojh1jU5ZnWsY7c9Vel02vgmSkGB4j6i94hR8pp/KLnGgMQU/B0xiuLDUYHTc+wbCI+wCpcpgGdUB6kUU2XojMNuPrHO4rH5P8KlYrKL2VWhHciNYL9BXvC4S+pu2ehNPhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4KQM6/w+YaPLRuTucRtQz97SeRd8V953LKDu8i9P6k=;
 b=EdsokV+0Ei2ht4llTxaO9TvirkRhSeLs+elWaF9jx0zjuXrCEKUqwnW8L4pV6EHEaXD26pqIbiNOb2g5n+VSTWXxyvTQEiYBbP1x7hljyjwAbzrN1SvbhMZRr1J4XSicrh8M/dGK+X3kGH8pLFpYFrTWhPUnJ/3vePudAC9h7Sk=
Received: from BLAPR03CA0178.namprd03.prod.outlook.com (2603:10b6:208:32f::32)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 04:27:58 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::2b) by BLAPR03CA0178.outlook.office365.com
 (2603:10b6:208:32f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Fri,
 31 Oct 2025 04:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 04:27:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 21:27:57 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 21:27:57 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 21:27:51 -0700
Message-ID: <65135fff-f347-4d31-b980-9dd5488fa094@amd.com>
Date: Fri, 31 Oct 2025 09:57:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 7/9] sched: Have try_to_wake_up() handle
 return-migration for PROXY_WAKING case
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
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-8-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-8-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: edaf3dba-9ae4-4877-15e8-08de1835de7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tzh5Q1BPR3F5UzhoRkRHdEhzWFNCQUMxeGhaU0xNUlh1UTRqMEhESGV1NmMy?=
 =?utf-8?B?VTdCMHFieHdtemRnSVA3OXNGMmtFc2paWTg3QVZvK1BqZzNGci81YWJNTUV2?=
 =?utf-8?B?M0NSMGhjaFlPck5GcWl6VkQvRndWQVpDeDc4a2x3ZjI0elFFeUwxaDZKTGdt?=
 =?utf-8?B?UDVTQ3o4MWZXbi9oanV4dnZ6RGtoWlJmT2p5N01VMHZGMGVoS09udWhiVEM5?=
 =?utf-8?B?YkpHaUNEM1NrMTdLb1J3NUMrME0vbHZWTXR3ZGtPTUYwMXh4VUxUQTJTcHJT?=
 =?utf-8?B?WWQ2QUtLZ3pVb2FFT2VSWXU4MTd3VGttK3lPcXZQOXZLVGFOeVplbEV1S0pD?=
 =?utf-8?B?Z203dlEzdERJMGh6NmhqUnJYZ3hTNmVWQTRtcEY3TDRMMlR2NTROQk5GUXEx?=
 =?utf-8?B?Q1RQWXdPd0pzdlVWNkNCZUJtN3JUVisvYW56emVuMDBVUnBSVloyMXFHbFF6?=
 =?utf-8?B?d0tYMWlQLzNoWHkrajNOMjFRdmloWmk0Tml6a2V0WllDUUJlUUFyaEZSSDE5?=
 =?utf-8?B?RmJzVVNWUG50Y05XVXE2bzh5Y0lVOEwySmVTWU5pcllYOGNKQ0piQVpXRkJa?=
 =?utf-8?B?WlFKeVNxcm1BM3RRam5ncDlobjZmQmcxbWZ6NGVvVVplYkpPci9jakdvY090?=
 =?utf-8?B?bHhMSHdITlNERjMzWXF0b3dmRkNCMnF1c3pvZHVWNUlBMElsYWpWVGJKcCtq?=
 =?utf-8?B?cDc2Ym9CMUI1bVZNek9XTXFNSWErOXAvVEpQRkU2bHdQN0RReFA0SUgrYlRn?=
 =?utf-8?B?UFppcGxNcHVrWnZWU0FSNzVYdEF3RWhZNzRnNzJNSVJkUGNQSGNZUk5WWmFk?=
 =?utf-8?B?Y0VhWnpFM2ZBTFE3aUFjSVV3M1RnYW0vaWU1WkxCK2ZVU3Z2UE9mc3duNDU2?=
 =?utf-8?B?Q0ZISjNKTE1MQzdFLzEyRzhtSlJuOWRQNUp1di9EendHUzV5N1lKQlZOdFRI?=
 =?utf-8?B?RHBUaVJKcktGeGs5dVEvcUV5aEJldzZ1ZTBxU1VIanh4d21RMjRQUzk3QWtT?=
 =?utf-8?B?UmdERUtxaWxIK2pUcVhLWGRSRHpQMTUwcHFqa2pYNTR5QnMxQU9rK0dTM2dX?=
 =?utf-8?B?L2VZNnJOMTNoRjdnVGVobDBLUlVaOVVvbFVXWmY3blIzbVpxamN1VzNBNzVR?=
 =?utf-8?B?TmdZZ1hZeDhrV2RvZzlsNGVSdllPRVRmWHJxcDFaWVY4YlROQXdldmd2NDEx?=
 =?utf-8?B?bEZpSGpyNUt6QmtDVVZlYjFHakNjVjNEcGhSRVFqOHVVVGdRcVV4bmdaQnkv?=
 =?utf-8?B?WkxFS3loTEZ6SlZVVW9zYWMzY0ttREEyZjZyTEx6YWVkYnFRdWREYlBPRWJi?=
 =?utf-8?B?SDNocllhNHQvNGZtL3J5Tk1ha2IxU2FPWlh2ZFlseW5uckczRVd5eWdKSFJW?=
 =?utf-8?B?V3pLTWlxeTRaMy9VU0JvQXBITkxPUUlUSjlCdG1NL1ZwTmdWKzFCOTlzVWd0?=
 =?utf-8?B?TzJQd1BxK0hOTnZnd2J4dGl6aG9YWVhlWitHSm9Idk93SGljU09NcmhpeG42?=
 =?utf-8?B?S0xvVnJWK25xMEJHZTBWcUl4T3l6SjBNcWNmeEQvbXZOS3BjbUhEbnNlNjFp?=
 =?utf-8?B?NmxONGEzZGY2MTVoV2pPMnU1V1JyMVJwTEhXeEFPWlQ3ekwySUdncVpMaHJP?=
 =?utf-8?B?Y0ZIa2U2aFdVbW1DTWZ4a2tOZzhMRDNmMXkrenFDOEQyeHU5VVEyQ1Zuc09Q?=
 =?utf-8?B?MlVGNnVOTnRyM0xRSUx3Q3VVSlVweFdLdGUrSWRodXEydzVsMGVvcmVudllH?=
 =?utf-8?B?aG52TkY1OElSMUtuTFY5dzd1a3Z0VmI5d2FYRnRNeURWZzBFUUZTV1JtYXdx?=
 =?utf-8?B?WHk5UjlEWmIwd2tpN1dPcE5XbG91a2lsa290SGh5Y3YyZFVBbXNPUlJUTzJa?=
 =?utf-8?B?SWVnYXJLSnFkV2M5YzRCSVRCd0lPVm1rVDJSejArOFF6aEYxYlp5dk1HQjc1?=
 =?utf-8?B?RVZ4V1hLWk5mOHFJaFdYa1hsdyt1bmVmdHFFQzl1TTFRZlBKR3poSloxNjRa?=
 =?utf-8?B?TkEvTXdLcC9xUGhjZFRaMXBVTE1WWERXS0dIcDMweWRHL0NuMzhPOXpOQTA3?=
 =?utf-8?B?WnREUVQ5cUxwbE5IdXRWOGMzZFZialRuZmZUNjhzY2RkSzZSYWpVekJPUm92?=
 =?utf-8?Q?3n+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 04:27:57.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf3dba-9ae4-4877-15e8-08de1835de7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> +/*
> + * Checks to see if task p has been proxy-migrated to another rq
> + * and needs to be returned. If so, we deactivate the task here
> + * so that it can be properly woken up on the p->wake_cpu
> + * (or whichever cpu select_task_rq() picks at the bottom of
> + * try_to_wake_up()
> + */
> +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> +{
> +	bool ret = false;
> +
> +	if (!sched_proxy_exec())
> +		return false;
> +
> +	raw_spin_lock(&p->blocked_lock);
> +	if (p->blocked_on == PROXY_WAKING) {
> +		if (!task_current(rq, p) && p->wake_cpu != cpu_of(rq)) {
> +			if (task_current_donor(rq, p))
> +				proxy_resched_idle(rq);
> +
> +			deactivate_task(rq, p, DEQUEUE_NOCLOCK);
> +			ret = true;
> +		}
> +		__clear_task_blocked_on(p, PROXY_WAKING);
> +		resched_curr(rq);

Do we need to resched_curr() if we've simply dequeued a waiting
owner who is neither the current, nor the donor? I would have
preferred if this function was similar to ttwu_queue_cond() with
each step explaining the the intent - something like:

static inline bool
proxy_needs_return(struct rq *rq, struct task_struct *p, int wake_flags)
{
	if (!sched_proxy_exec())
		return false;

	guard(raw_spinlock)(&p->blocked_lock);

	/* Task has been woken up / is running. */
	if (p->blocked_on != PROXY_WAKING)
		return false;

	__clear_task_blocked_on(p, PROXY_WAKING);

	/* Task is running, allow schedule() to reevaluate. */
	if (task_current(rq, p)) {
		resched_curr(rq);
		return false;
	}

	/*
	 * Task belongs to the same CPU.
	 * Check if it should be run now.
	 */
	if (p->wake_cpu == cpu_of(rq)) {
		wakeup_preempt(rq, p, wake_flags);
		return false;
	}

	/*
	 * Task was migrated from a different CPU for proxy.
	 * Block the task, and do full wakeup. If the task is
	 * the donor, ensure we call put_prev_task() before
	 * proceeding
	 */
	if (task_current_donor(rq, p))
		proxy_resched_idle(rq);

	/*
	 * (ab)Use DEQUEUE_SPECIAL to ensure task is always
	 * blocked here.
	 */
	block_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SPECIAL);
	return true;
}

I would wait for Peter to comment before changing all this up in case
I'm terribly wrong and am missing some subtleties. Also reason why we
may want to switch to block_task() is explained below.

> +	}
> +	raw_spin_unlock(&p->blocked_lock);
> +	return ret;
> +}
> +#else /* !CONFIG_SCHED_PROXY_EXEC */
> +static bool proxy_task_runnable_but_waking(struct task_struct *p)
> +{
> +	return false;
> +}
> +
> +static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SCHED_PROXY_EXEC */
>  
>  static void
> @@ -3784,6 +3834,8 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  		update_rq_clock(rq);
>  		if (p->se.sched_delayed)
>  			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> +		if (proxy_needs_return(rq, p))
> +			goto out;
>  		if (!task_on_cpu(rq, p)) {
>  			/*
>  			 * When on_rq && !on_cpu the task is preempted, see if
> @@ -3794,6 +3846,7 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
>  		ttwu_do_wakeup(p);
>  		ret = 1;
>  	}
> +out:
>  	__task_rq_unlock(rq, &rf);
>  
>  	return ret;
> @@ -3924,6 +3977,14 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
>  		return false;
>  #endif
>  
> +	/*
> +	 * If we're PROXY_WAKING, we have deactivated on this cpu, so we should
> +	 * activate it here as well, to avoid IPI'ing a cpu that is stuck in
> +	 * task_rq_lock() spinning on p->on_rq, deadlocking that cpu.
> +	 */

Sounds like block_task() would be better than deactivate_task() above
in that case. Anything that is waiting on the task's state change takes
the pi_lock afaik and the wakeup is always done with pi_lock held so
blocking the task shouldn't cause any problems based on my reading.

> +	if (task_on_rq_migrating(p))
> +		return false;
> +
>  	/*
>  	 * Do not complicate things with the async wake_list while the CPU is
>  	 * in hotplug state.
> @@ -4181,6 +4242,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  		 *    it disabling IRQs (this allows not taking ->pi_lock).
>  		 */
>  		WARN_ON_ONCE(p->se.sched_delayed);
> +		/* If p is current, we know we can run here, so clear blocked_on */
> +		clear_task_blocked_on(p, NULL);
>  		if (!ttwu_state_match(p, state, &success))
>  			goto out;
>  
> @@ -4197,8 +4260,15 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>  	 */
>  	scoped_guard (raw_spinlock_irqsave, &p->pi_lock) {
>  		smp_mb__after_spinlock();
> -		if (!ttwu_state_match(p, state, &success))
> -			break;
> +		if (!ttwu_state_match(p, state, &success)) {
> +			/*
> +			 * If we're already TASK_RUNNING, and PROXY_WAKING
> +			 * continue on to ttwu_runnable check to force
> +			 * proxy_needs_return evaluation
> +			 */
> +			if (!proxy_task_runnable_but_waking(p))
> +				break;
> +		}
>  
>  		trace_sched_waking(p);
>  

-- 
Thanks and Regards,
Prateek


