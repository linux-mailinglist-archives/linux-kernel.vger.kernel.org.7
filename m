Return-Path: <linux-kernel+bounces-866272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F2FBFF59A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5FF04E7F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ECD28B4E2;
	Thu, 23 Oct 2025 06:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lMHyfn18"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8D8248C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761200976; cv=fail; b=vFe0ky1O+EUM3u1YPe2kAdER9gTx4IenPRZLc2go75KGrSQ1mJyaBo8UM/tM3vG0dyphA+6FYsUPjKkQbT2wILnRV4LbMvE7DyrKkB4ktNbzmRV04en4ITI9kTblTZSYi6zwV81BYxe7igTGDQz3INf2Kx1iBLlvJ9SSMUsXyno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761200976; c=relaxed/simple;
	bh=o10zEpd2DQAAONjaU2TjUJTO2sl4G5EMEORjkg8yURc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X8P9ztWszEolB/sKQiv/EV/nzpMuKFTjrtKKNGyT6UicmOZqxo1HwB//HKsbuEcQnbNlKd6QAO7LsBsBNBJ++y8fE+CDSdqLVwCARFtMPgEZwD3SSG+/OJajqkXSSIH7+n0MIEDCJZnP+mF/1+8rxPtfOycz5xlQatRrGDktX0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lMHyfn18; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4afRll6L5vxy699yIX9qpYky+Wy2tTaNuvqWBcWz9s9bhA3Xb1ZEaYprx0wQy59dG2eiDEVow/jZBbfg61Ccm9C9OVxxwqrKwNuhVu4/H4dLSJp+A2BwEJ/MG76R2hEeomLgs11NBgDbygY8y2bs/1t27LIZSjAPpulC49FHWRBqdbb7GbFjJDTtiI04PdnQ1rzsW/yHz0+hWNoyFaFaFd/wugg6LUbQHaC9nK61imR+NZf1pMeQie2+DYlh62l/wjXwKRsHlehsXDygrfXseHcz5zuKBpfWl9j8NadwKCTkimTgE3icg88OgyCgEeVcEeaXHtPiv+RZV//mkx1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jkNaqf1p3TnRn3Z9oF8ki6Dk22wl78QfacpAS85G+g=;
 b=DViwcJ6KpJJsDkQzrMZZy1uqj03Y+GSe4iBqOaHrrAQx/y1tIaLVzgcoyBqm39X8cn9Wj8Tb1zvZIWHHqevy/B599A/QTTmbvsH1qXxWw1vdYe9ZmulF6vPL97QEW1N5gYAxc9j74wLFaUIn8UJ41zyRrXyQ+FrignqIUfM0RTYZ8Ji5ZakE+ivFzzqY1Jf/AirunOKSyewFCttqMwen2qP7KQ+CFoTR83jCB842MCLqm1Gwvcbm6w/q8b6to60ExI/R0Rm9NRAXZXn+hZiLad3KnmfipN4rSBETuava+KG3rJTxUVd9ZYZ3xTDt9F/FkOsqMiQLAynnJUElXtrSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=techsingularity.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jkNaqf1p3TnRn3Z9oF8ki6Dk22wl78QfacpAS85G+g=;
 b=lMHyfn18g7qxa+GVQfefzmUBvQbLw7bq9MtzuIg8u+s2baZTLa8P7wWUdixqEqAZvFe7e53GEj62AcAK+4JT69q3m7mRuAEgUpnXYZkhpxHxnoejpp7LzAtWa6qYgv7XzEbA2PaVrYp/6hBLskVYm65aC3cX9d7X6yde/u5pcek=
Received: from SA0PR12CA0018.namprd12.prod.outlook.com (2603:10b6:806:6f::23)
 by CY8PR12MB7316.namprd12.prod.outlook.com (2603:10b6:930:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 23 Oct
 2025 06:29:30 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::61) by SA0PR12CA0018.outlook.office365.com
 (2603:10b6:806:6f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Thu,
 23 Oct 2025 06:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:29:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 22 Oct
 2025 23:29:29 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Oct
 2025 01:29:28 -0500
Received: from [10.136.36.69] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Oct 2025 23:29:26 -0700
Message-ID: <a6296e85-4140-4199-b260-dde3d8c4209a@amd.com>
Date: Thu, 23 Oct 2025 11:59:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
To: Mel Gorman <mgorman@techsingularity.net>, <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, "Chris
 Mason" <clm@meta.com>
References: <20251021142824.3747201-1-mgorman@techsingularity.net>
 <20251021142824.3747201-3-mgorman@techsingularity.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251021142824.3747201-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CY8PR12MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ece9610-c6af-4fc1-37c4-08de11fd856e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUV2OUYzNWNtYXgzNmdGTzJHQkhuT1Y3VnYrRUhVOWVvLzI3OUhZTDN6WThv?=
 =?utf-8?B?ZXExUzRKbXZTNVVCQlhwMnk5dEo3TG1uTHZRTHZEL2o3K092RzBrUlgzc1Uv?=
 =?utf-8?B?MkdNTExKMWRSR3FDQW5WZGRsQmo3ZFhibDYxN0puQW5nMktwbjd2WUJVOEZF?=
 =?utf-8?B?L052bENYK3NxUmZFVy9qZVYyNEljcHRkaEV6U21NT1lnQkVOOE5SdHUzTXBz?=
 =?utf-8?B?SVdqcDl2YXMzTmlpMVVCL1YvNURITDB3SlJKVkFaeW00bHNBcFdNUVJ1VDZ6?=
 =?utf-8?B?SU1OZnlTajdSc1lqNHYyS3JzWlJZVzhJWHkvZG1hM1ZFSUtrM2FJS2NUZGhN?=
 =?utf-8?B?NTkvRzRaQVoyaURjRElxYWczc3U0RTk3dmUwK2dEcVVEQ2R6ZHpWN292cFZJ?=
 =?utf-8?B?eEJ2eHNHZGY1WlN1Qnpvc2htQ2RQc2w3N2FkNDgySTdlWTlvMGFFdSs1ZU5w?=
 =?utf-8?B?cjM3bDYvRHhOSzQ0eUlwK2hBdTd0Q3p5UE1uQ3JLdnpxZG5VaXJEbU1QV0J3?=
 =?utf-8?B?aFRuZmhNK0JEUy9pU3AwVHF0TFRQVTFIU3RKT05leExNV3FOY3VKdHBtOVJJ?=
 =?utf-8?B?VTU3MS9PQ3J5MVdaRm9lRDMyWmdzMjhqOVlHb0FCUXRvQmp1N05pNzdpSy9Y?=
 =?utf-8?B?aHpCcVVkRGtQMkNyQm1Hb2YzbTEyZ3h1K3RxWnlKOGZyazQ5ZVJxWjFOUUIr?=
 =?utf-8?B?WkMrM2kycG9XZFBiUWRTRmMrOWcxd2NoOGU5WGxSVHhXaTRzK1Y3ZmNSUEVh?=
 =?utf-8?B?dDlqMXNZNHIwNENhMUZDZ3h2SGcxUlc3a3pZU01iSDlaMzRTOHovbW91bElv?=
 =?utf-8?B?ZXRrNEJOL0tmbmRiaHRkVDBrM1FDbmdBV1h4dlY1RExjNUlLOFR0Z0xYTExM?=
 =?utf-8?B?QUw4cUVJUGw1WlB2ZEg0RXdyVVRSaGQ4STlSTk1OTkNMWUF3em5FNzdLcGhl?=
 =?utf-8?B?Y2JmZDZuVWVZZmFOeWF3YkN1aDhWNXAwQUNPZFRiM0RlV1oyNHRBQVlLbnNG?=
 =?utf-8?B?cnRqQ01jNEFickZGQzdxaTJ1bVp6QzE1MFJ3ZThaNTBIeEFNeTZPNlVxcDNC?=
 =?utf-8?B?UzZoU3hRdExvZUxrZy9WU1pxSHhEeHQxUlBiL1IyeWFVek9qR0cwQUp6dnYv?=
 =?utf-8?B?WDVtU3prekI1UlhJTXJtZjF3elFyeEE5ZmlxODlDWDI5U1dQbEdEeU04VUJD?=
 =?utf-8?B?WkgzYWNHY1JneVA4cEFHbndxY3hXeENRTUhHdS82UVIvTStFM0F3UW5taDNW?=
 =?utf-8?B?aHBaUXF0ZGFIdGR1VktMeXp5K05GVDkxeFZ1MnF1akFjRitVOXdzK21Gblli?=
 =?utf-8?B?SVlPQWV2MDZBMGsxZ1RUNXp0a0dQRUVDRlpPYW1ZcmsxZE1mRENhanFUWE92?=
 =?utf-8?B?d0wxc0JUaStnM0lRaWZ1b1lkR0ZTeU41QVZDa1BjUDlqZnVYWnVMekRXUnFN?=
 =?utf-8?B?YVJnRURxZjJETVUxMWhwLy9kT3c5ODFKYVV3cTh4UFRVTUNZNXpCZHJsdkpi?=
 =?utf-8?B?LzlGYi9NTTc1OWhhYlFxaHJmbGpSVE55N1lKODZnQ1ROQ1VMRy9rYkFPcGpT?=
 =?utf-8?B?WGREa091WjBjZlFsNWQveFZEc050L1JyUG1ibUhRTWFNZk5Pd1phSGdYb2FU?=
 =?utf-8?B?c3k2OTJwZSsrMkZFOXZndC9uck1DNGlSeWlhdHFTbzZISG5jM21BU1ViR2Mw?=
 =?utf-8?B?aVBZRlFzaVltRkFmQ3V6cGxSeElzREk5TWRscDVzeS9GMmk5R0NDeWpLeXJn?=
 =?utf-8?B?aFpEZjE1YitDcldnZUlsRHp2dFVvbTdOUHJiYWdhS1VHQVVDWDl5UVlHSGpP?=
 =?utf-8?B?bEF3TTg4ODlHcmF5SldmR0RJcU9oQU1uWkZkbVc3L0N6ejJkSXRXS0dQdk9r?=
 =?utf-8?B?NzNOd21UM0tOMzFkQWY4MjNTRFBkeXF2VXdGZVRkQ1ZJMGxjR2E3clJURHR0?=
 =?utf-8?B?UHVMODYxVER3UmdibHVpS0RXNnJ2ZFZKN1IrL0M2NVYyMi9QR2EwOW9ySnlp?=
 =?utf-8?B?T0hCVmpINGw1YmYxR1c4andla3Ruc0xuems3Ri94ZjFVdzJmcFJJRWFCYkJ4?=
 =?utf-8?B?Ym9wVGI0UFBRY25idlc5VUs0S1IrQkxCRXZnS09ZT3djdithVm80ckcya0NR?=
 =?utf-8?Q?94lo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:29:29.5528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ece9610-c6af-4fc1-37c4-08de11fd856e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7316

Hello Mel,

On 10/21/2025 7:58 PM, Mel Gorman wrote:
> +static inline enum preempt_wakeup_action
> +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> +		 struct sched_entity *pse, struct sched_entity *se,
> +		 s64 delta)

"delta" is only used within __do_preempt_buddy(). Might as well compute
it here.

> +{
> +	bool pse_before;
> +
> +	/*
> +	 * Ignore wakee preemption on WF_WORK as it is less likely that
> +	 * there is shared data as exec often follow fork. Do not
> +	 * preempt for tasks that are sched_delayed as it would violate
> +	 * EEVDF to forcibly queue an ineligible task.
> +	 */
> +	if (!sched_feat(NEXT_BUDDY) ||
> +	    (wake_flags & WF_FORK) ||
> +	    (pse->sched_delayed)) {
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	/* Reschedule if waker is no longer eligible. */
> +	if (!entity_eligible(cfs_rq, se)) {
> +		resched_curr_lazy(rq);

This is unnecessary since PREEMPT_WAKEUP_RESCHED case already does a
"goto preempt" which does a resched_curr_lazy().

> +		return PREEMPT_WAKEUP_RESCHED;

Should we update the next buddy before returning here if
entity_before(pse, cfs_rq->next)?

> +	}
> +
> +	/*
> +	 * Keep existing buddy if the deadline is sooner than pse.
> +	 * The downside is that the older buddy may be cache cold
> +	 * but that is unpredictable where as an earlier deadline
> +	 * is absolute.
> +	 */
> +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> +		return PREEMPT_WAKEUP_NONE;
> +
> +	set_next_buddy(pse);
> +
> +	/*
> +	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
> +	 * strictly enforced because the hint is either misunderstood or
> +	 * multiple tasks must be woken up.
> +	 */
> +	pse_before = entity_before(pse, se);
> +	if ((wake_flags & (WF_TTWU|WF_SYNC)) == (WF_TTWU|WF_SYNC)) {

Do we have !TTWU cases that set WF_SYNC?

> +		/*
> +		 * WF_RQ_SELECTED implies the tasks are stacking on a
> +		 * CPU when they could run on other CPUs. Only consider
> +		 * reschedule if pse deadline expires before se.
> +		 */

Code doesn't seem to match that comment. We are foregoing preemption
if the current task has run for less than "sysctl_sched_migration_cost"
even on pse_before.

Also. looking at the comment in check_preempt_wakeup_fair():

    If @p potentially is completing work required by current then
    consider preemption.

Shouldn't this check if "se" is indeed the waker task? Despite WF_SYNC,
wake_affine() can still return the CPU where @p was previously running
which now might be running another unrelated task.

> +		if ((wake_flags & WF_RQ_SELECTED) &&
> +		    delta < sysctl_sched_migration_cost && pse_before) {
> +			return PREEMPT_WAKEUP_NONE;
> +		}

Above checks seems unnecessary since we return "PREEMPT_WAKEUP_NONE" if
we don't enter the below condition. The two cannot have any overlap
based on my reading.

> +
> +		/*
> +		 * As WF_SYNC is not strictly obeyed, allow some runtime for
> +		 * batch wakeups to be issued.
> +		 */
> +		if (pse_before && delta >= sysctl_sched_migration_cost)
> +			return PREEMPT_WAKEUP_RESCHED;
> +
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	return PREEMPT_WAKEUP_NEXT;
> +}
> +
>  /*
>   * Used by other classes to account runtime.
>   */
> @@ -5512,16 +5598,6 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  {
>  	struct sched_entity *se;
>  
> -	/*
> -	 * Picking the ->next buddy will affect latency but not fairness.
> -	 */
> -	if (sched_feat(PICK_BUDDY) &&
> -	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
> -		/* ->next will never be delayed */
> -		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
> -		return cfs_rq->next;
> -	}
> -
>  	se = pick_eevdf(cfs_rq);
>  	if (se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> @@ -7028,8 +7104,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	hrtick_update(rq);
>  }
>  
> -static void set_next_buddy(struct sched_entity *se);
> -
>  /*
>   * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
>   * failing half-way through and resume the dequeue later.
> @@ -8734,7 +8808,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	struct sched_entity *se = &donor->se, *pse = &p->se;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
>  	int cse_is_idle, pse_is_idle;
> -	bool do_preempt_short = false;
> +	enum preempt_wakeup_action do_preempt_short = PREEMPT_WAKEUP_NONE;
> +	s64 delta;
>  
>  	if (unlikely(se == pse))
>  		return;
> @@ -8748,10 +8823,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (task_is_throttled(p))
>  		return;
>  
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> -		set_next_buddy(pse);
> -	}
> -
>  	/*
>  	 * We can come here with TIF_NEED_RESCHED already set from new task
>  	 * wake up path.
> @@ -8783,7 +8854,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		 * When non-idle entity preempt an idle entity,
>  		 * don't give idle entity slice protection.
>  		 */
> -		do_preempt_short = true;
> +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
>  		goto preempt;
>  	}
>  
> @@ -8797,12 +8868,31 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		return;
>  
>  	cfs_rq = cfs_rq_of(se);
> +	delta = rq_clock_task(rq) - se->exec_start;
>  	update_curr(cfs_rq);
>  	/*
>  	 * If @p has a shorter slice than current and @p is eligible, override
>  	 * current's slice protection in order to allow preemption.
>  	 */
> -	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> +	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
> +		do_preempt_short = PREEMPT_WAKEUP_NEXT;
> +	} else {
> +		/*
> +		 * If @p potentially is completing work required by current then
> +		 * consider preemption.
> +		 */
> +		do_preempt_short = __do_preempt_buddy(rq, cfs_rq, wake_flags,
> +						      pse, se, delta);
> +	}
> +
> +	switch (do_preempt_short) {
> +	case PREEMPT_WAKEUP_NONE:
> +		goto update_slice;

You can just return from here since update_protect_slice() is only
done on "do_preempt_short != PREEMPT_WAKEUP_NONE". With that,
the "update_slice" label becomes unnecessary ...

> +	case PREEMPT_WAKEUP_RESCHED:
> +		goto preempt;
> +	case PREEMPT_WAKEUP_NEXT:
> +		break;
> +	}
>  
>  	/*
>  	 * If @p has become the most eligible task, force preemption.
> @@ -8810,7 +8900,8 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
>  		goto preempt;
>  
> -	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> +update_slice:
> +	if (sched_feat(RUN_TO_PARITY) && do_preempt_short != PREEMPT_WAKEUP_NONE)

... and since do_preempt_short can only be "PREEMPT_WAKEUP_NEXT"
which is non-zero, changes in this hunk can be dropped.

>  		update_protect_slice(cfs_rq, se);
>  
>  	return;

-- 
Thanks and Regards,
Prateek


