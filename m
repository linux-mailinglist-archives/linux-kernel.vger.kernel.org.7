Return-Path: <linux-kernel+bounces-835734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0DBBA7F09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4D43B9104
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922461E511;
	Mon, 29 Sep 2025 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H4FrW01P"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A834BA50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759120665; cv=fail; b=ID1Tj2DxPWkPrCcrvhimuBxjtKOxc/G+Dd2/CJ6jXW+2/8iTLDbH3asBPjT5NubuMC3kX6HUmEOSVrv3gBat9yDI9QSqJVaSD5w/RV0AsuAuKxz+XYQlQvPHcHu88nn+ttQJqbgx2GE1hnFksYrXGzER367f8sj/p46XNtn+w7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759120665; c=relaxed/simple;
	bh=vB1LbgmZVJCHhyb2JiyyiwDbguXY7Wtodf/G6SxjCrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L5DiWa2b5abVNXspJ/P/Nn/GlWyezccnL+9wOK4oPqrW7t5Ue4sd9UNWzSnXdy1tZIYq3kEZcrJwc8dgmQZx+FmFP3iBVwk3NKDcLk1ydMtJJi0FO7sZSNK3ZxTeTvsdb3yAvJEEMfWJ2GjeG6rPdq1djpRTgbe1Vas0CxNSby8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H4FrW01P; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcUaZq8ieavE1Ga5guTOiLKmnQ4q3nli54Danc5weg+nABr4kpoTc5nu5p4dtLoVmCYOJjK0k+vqHbyc/1Km9tpqwfIVdqtXdQJ5CNYmEweWsIxY4vuXPGM1O2vpVDq+CIn/85d5yT5TBQHyD/sQahmvLP5yczUFoFW68v7TOeOHX//WifqDv8lfxu/xixW4M3ZYk7/XlPq4pSJs/MKcRJNPdS+ECSc6nz5rvxgjojaVlkoQuQTyYqM36t0mRV/24YZBnXcQPdOZQDBdw/mOlzUHxqFy7S6NMpIWT6Ew7N/ve0GKzM8NMiwlaXLWiwrOPI5+i5fWAfHglbZBZXXvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac3T5wbSAGPzvyXW8bdrbftEu7hVDIbqaoZ1GNaXsYw=;
 b=hxLifBZV6+n8KFgyxalGg0Fa+fsI8dYoh60u4DHZvdxt6B2PeWH53g+ok+7CAKQTzj6Omwl/qn9bgbHGtG0mnJKrUVwhMYlYw6bDGz8eD8FK0bfHmaKHiCVJUVAI6w1BHAOYpcCLOqxbIM8gZmWtk9rmQ06uULoP5Yzwp0SsgenUju6+IkwqOiN4XGJ9sLkzdwUPOvlOGGAt3TMq1rfC5M9+spE0yqD+pPhlkmiF/JPAs/pXdkABBGhH/yNOnQaIdjigMEewvAJNitv1KXFCRyvLAizGuiMN2Rq75UC15aoBSKKvzqAyflXjZrRtxwxjwHGQfG/j6zmQVSbWMx3JVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac3T5wbSAGPzvyXW8bdrbftEu7hVDIbqaoZ1GNaXsYw=;
 b=H4FrW01PRyFSCmBUHgluP1opGjYukwnD5FLtGm+iaWANjAWGGP04uJNY0wYmpGQijZSPJFOGtYX9qErh92tUyvH3xuv/Qzk9OsszHhVUVUTyJSvoXinhF+Qtt8mKnP94Zmk9zTMl53BfitSvzBkoYpT7VASn+kIO4hfSd/tmhYc=
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 04:37:39 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:2bc:cafe::ac) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.10 via Frontend Transport; Mon,
 29 Sep 2025 04:37:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 04:37:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 28 Sep
 2025 21:37:38 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 28 Sep
 2025 21:37:38 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 28 Sep 2025 21:37:34 -0700
Message-ID: <c8864652-d763-48a3-9292-24c29c25838d@amd.com>
Date: Mon, 29 Sep 2025 10:07:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Add _TIF_NEED_RESCHED_LAZY to __resched_curr check
To: Jemmy Wong <jemmywong512@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski
	<luto@kernel.org>, Kees Cook <kees@kernel.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <linux-kernel@vger.kernel.org>
References: <20250928151421.60919-1-jemmywong512@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250928151421.60919-1-jemmywong512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ffed1c-c2cb-4d1e-7c43-08ddff11eba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnlNaldMdkp1bWxPUEZCelRFYUN4OFZFakFzVVNTYmNzTVkrQU9NZGxQd1hG?=
 =?utf-8?B?K1BLdzhBajRncjY1c1RYWnBMdzBIa3ppSDhFaHVUN216VERGNU02S1RWRHdx?=
 =?utf-8?B?Qi9ockh4OVdxUEEzNGRZbXAvekpVM2lYdnFiV0dOUUpNV29Qb2ZWMzlxUG1m?=
 =?utf-8?B?UnhQL3NkZU80VmVBeGVRQU1QLzRoM1N3MlNUZTY5VXFWOWlCVVAvczEraHM4?=
 =?utf-8?B?TWVRaWVvZEZjKzEveGRGN2ZOSzZvWnVvZThpNTczNjlEZ1VzN1JtZHVDMG9u?=
 =?utf-8?B?bzlMSDBHbzNadUpBZlpBUUtWbzlTekVHbFlXMEM5RnRmcVhYSFhaN1BWNExm?=
 =?utf-8?B?akxkNlVEWE5TNVhxdDhDRjkxaEJvZTFORTJNS0xFVmVIdVFsSTY5b0FPV1pN?=
 =?utf-8?B?a0oxcmdmYm44ejhVNHVCNDFIM1o5MkFjcm8za3pNZDVCdGdBazZSbEljcFV4?=
 =?utf-8?B?OVlNRy9hRHROeDNsMlhyTUJvZGphWWJIdG85UlFDdTJ6amwwTHJOdkl2S2VJ?=
 =?utf-8?B?c1JmZ2Jyd1NTK0ZoUGo2R1JvNml6Y08waWY4NXgvcko5RmluTGk1SWpEblUw?=
 =?utf-8?B?S1d0Yi9sTlV6UWtSbjAzVWY3Z0I4VmJLeXMva085SUIvcDRjMHZGdmZLMEs5?=
 =?utf-8?B?Qkxkc3dwVWo4SG1IUnp6Y1ZaaHE3SFNrK0d2bUJBY0kwN1FGTnE4KzhVUzIw?=
 =?utf-8?B?U2FDdFB0RExnM0RFclp5dlBjME8xU2ZTa1dKK1Z5WFNWbWltWWNjU0J0M0U5?=
 =?utf-8?B?YmZVclc1VDdUTisxK0lXM1h2OXBZbDNMRjRLQ2k4TDFpalJMSWFlN0l4OENa?=
 =?utf-8?B?V3Bxa20rbDdDem1VbDZFRXBHS3laeDg3WUZXaGY3amVvYVc1NGE4RmhYWHZJ?=
 =?utf-8?B?RDFBN3V5MnpBbXZjRUpJS2NzQnI0RFdJLzRCU1lPdWJTVzhDNnVBOXdvTUhv?=
 =?utf-8?B?SUM5NXR4ZmdFK0s0UmpxMjhHWUFyb1BsSmdjQVFjM01sWHVKVVFjS3F6ZWtC?=
 =?utf-8?B?ekFRd1RXa2o4ZXlXVEdTOUdISVVub2dkVkZVK3QzazBJeUdXOHE3SGpMdUNx?=
 =?utf-8?B?bFRRK2pJeUJFdHJiYWVheEZnajVhSWFyK2ZoNlNxSCtETEM3VXdUUTNBWXRS?=
 =?utf-8?B?ay9kT1Y5QWp1ZytqVzJrM3hhaUhkL1lCSWlPS00wdDhvUHM5MFVNemY2NnQz?=
 =?utf-8?B?TWw4SDdJQ0krcFd3OUxnRUNDQ09tZEZuZU9NQ09EY2twV29oSVJpRlduNWU4?=
 =?utf-8?B?bDJ5cUd5MEpycm9PZlMxaGJwL2Y1QkVMOFV3ejc0Wk4yVnRYYklKWVBHNmZ4?=
 =?utf-8?B?aHU5Uk8rZHZiNDA5VHhHOHRhMk9vdUoyWjFUbTFlcG5OL0hyU3hCeHdiNzhM?=
 =?utf-8?B?VzV4OUN1Y0dDb2NlZ2ZXUXFNZmhLc2dHOVdsR0xGbnlldVJ1RER6TlQwNHpm?=
 =?utf-8?B?cFNYZU9EODQ4R3hpZ3FNc3JObEtLU1Q2YXVlRXZZWUV3cjh4RnF5eld2MkNq?=
 =?utf-8?B?ZVFCYmFmeDBoTlZla3M3VVFSekNPU3cwbnZ4Z0dIY2pxV3hQaVkrLzUxTGxo?=
 =?utf-8?B?TnJYSm5QSGVkc0Zka2Jrb1dIcHRBYWdsZDFpL0sxbkVBVkIyM1lBV0dYV1cr?=
 =?utf-8?B?cnNxeGg5dkMyQnNBb0NUUGM5T0plVmNhT0pucHU1em5rZG83Z24xRldMeVBV?=
 =?utf-8?B?Q0kvSWt6TnA1ejBzZDNkSmtXMjIrMS9CM1RtWEVaeHhwa3IrSmZkUDhaT0RP?=
 =?utf-8?B?RlZzL0Z4dzBIYldjT0NwTVdjcmZvRzVtVDcyT045OUN0ZW9tUDlDNGQvZkJL?=
 =?utf-8?B?WVZNaURqTmJwTEprbjBtcUlTTnZqU2hzemxBV2ljN2FvL2ZHT2llTUp3Q2cy?=
 =?utf-8?B?ZEFGQXZsY1NWUkZCTWR0bHZ3Qkk4V3RIbDkxeUJSeG5ZY1dwQjFMdWg2U1hV?=
 =?utf-8?B?eFVMRk9mL1p6YXlVTG5SbXlzb3EwUkRKajhZQTNrdDN1K2RyY0s5bDJzSHFL?=
 =?utf-8?B?c2E1VHdHZUVJNS8zK0RGRE5yM1dONTFRY2liMXN1eWpxRHZ0dmFORS9HcDBI?=
 =?utf-8?B?a2YyK01Hb2RTa0xJZFRDcEFNVTRVV2oyMHFocUV0LzM0a00rMWwyS1M1R1dK?=
 =?utf-8?Q?rRt/v5LpCEVT/mmmoOA6QgRyi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 04:37:38.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ffed1c-c2cb-4d1e-7c43-08ddff11eba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

Hello Jemmy,

On 9/28/2025 8:44 PM, Jemmy Wong wrote:
> The TIF_NEED_RESCHED_LAZY flag can be set multiple times in a single
> call path. For example:
> 
> entity_tick()
>     update_curr(cfs_rq);
>         resched_curr_lazy(rq);
>     resched_curr_lazy(rq_of(cfs_rq));
> 
> Add a check in resched_curr_lazy() to return early if the flag is
> already set, avoiding redundant operations.

That would have been a decent idea but then you decided to put that
check in __resched_curr() which makes it plain wrong.

[..snip..]

> --- a/include/linux/thread_info.h
> +++ b/include/linux/thread_info.h
> @@ -67,6 +67,8 @@ enum syscall_work_bit {
>  #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
>  #endif
> 
> +#define _TIF_NEED_RESCHED_MUSK (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)

s/MUSK/MASK/g

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1108,7 +1108,7 @@ static void __resched_curr(struct rq *rq, int tif)
>  	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
>  		tif = TIF_NEED_RESCHED;
> 
> -	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
> +	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED_MUSK))
>  		return;

__resched_curr() is used to set both TIF_NEED_RESCHED_LAZY and
TIF_NEED_RESCHED.

By putting this check here, any effort to set NEED_RESCHED and force an
early preemption will bail out if NEED_RESCHED_LAZY is already set which
will delay the preemption.

An example:

    /* New fair task wakes up. */
    check_preempt_wakeup_fair()
        resched_curr_lazy()
            __resched_curr(TIF_NEED_RESCHED_LAZY)

    /* New RT task wakes up. */
    wakeup_preempt()
        resched_curr()
            __resched_curr(TIF_NEED_RESCHED)
                /* Sees NEED_RESCHED_LAZY is already set. */
                /* Does not do a set_preempt_need_resched() */

    ... /* Added latency */
    sched_tick()
        if (tif_test_bit(TIF_NEED_RESCHED_LAZY))
            resched_curr()
                __resched_curr(TIF_NEED_RESCHED)
                    /* Again bails out early! */

    ... /* More latency! */


So, the tick doesn't even upgrade the LAZY flag to a full NEED_RESCHED
and the only time you actually schedule is either at exit to user mode
or if a kthread decides to yield.

Going back to your commit message, something like:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f1e5cb94c53..3275abce9ca2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1164,6 +1164,9 @@ static __always_inline int get_lazy_tif_bit(void)
 
 void resched_curr_lazy(struct rq *rq)
 {
+	if (task_thread_info(rq->curr)->flags & TIF_NEED_RESCHED_MASK)
+		return;
+
 	__resched_curr(rq, get_lazy_tif_bit());
 }
 
probably fits the bill better.

> 
>  	cpu = cpu_of(rq);
> --
> 2.50.1 (Apple Git-155)
> 

-- 
Thanks and Regards,
Prateek


