Return-Path: <linux-kernel+bounces-816332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9E9B57283
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF2D3A28A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDEF2EA489;
	Mon, 15 Sep 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gHAcw1fI"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C222135B8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923577; cv=fail; b=lyxnNUivsUWV1ulBc5CquFEcD+CsvCh7bDpFEqYXWob5Jfb8ACHKPupaWjpwjQh1lK6CHLUDdlrfzPt6nrBcKCis0WX2VFe6G7TJbUHkhjVh1sEj+qlugN2IGotTMu0gAxmBMgYfprTaA0uPAREYO3KTkRg6DBQ2ZXLQ8U0Z6Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923577; c=relaxed/simple;
	bh=iNCq253EKasdzPLvVOMdUdENSykaPTVp+iB1vtMEREs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IO5FSgJGgm00bymoOoOERJ/LrEwnAT027H9peMRMEbc2EpH7yA+GD5rQHzYGQCNihBSSt1GpJeNpcBJSBN8/7fEC2sYvcNQhCcNxi8Dd7SEMZhubj0/Xl9DoEMR9dPER2CHoVDQkpjvDS1g8qK6+E2VP/ZV22KBFYI/ie/sf3aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gHAcw1fI; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPo2McalhlPgQ6V33cp8OWEQEb9ubtS24azJoDJ57nEX3vP/pmVGmZ4ZpXyFXjSEF56DFvgCWR19dZr+w/MKRA4Hqjo0wgbszSiGCJrRnS3gimqEKgu6Id05EnQ8rpamcxLKl0Jl00MhMVHmYVDGcYBZUUg6Xq9AbUOCxBsdPyi6yOSBI57BkTRNuTuYgiKExH5k5wZmC2bI4OXhizWbcT5jYl7pQxnb6rQVawzRoB+i30Zp9AQwxpD00FZz4X3nwKa5URdsJ67/Ne2VYtYv3T+k/oz2we1/aV3udHRIW9sJSqhC9QyFB0H/FNthQJOMMenfZPhqMBE6YoN11bp49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcyczbfOAL7UWP2bLxo1C8g5tWXMkewslqC/qctzS4A=;
 b=pBw3ToAYsL8JcxV9tj+qaTmXcASbL/uOKZiKkL3ZSk1IW5zUXL1JrjQOEZY9ZKrKW0cJXe4pHNZoo6syLty6teAovmc5L7HcfoVn/e+fVjzVWo0wlWLs5IJ4JRUvMkRF75aSZ7egVzyrF9abVhnj52/giW/FCywv2BXUPCM5B0hMxJrfnWMN76/H+nQ03xskRfSJv+q2bIqayFLhxJPtdBvjO5RM3G+6SZ3kGEagrCFhQKcrYZiKZH6WZCxnm8NKLidVyWtQEFmnRW8xanJQCV7lZYlnOi7LiaWew+SieXZ27Ys+doasnLc2RXYN9MebiQYXXOH+visFFlmV8zlxvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcyczbfOAL7UWP2bLxo1C8g5tWXMkewslqC/qctzS4A=;
 b=gHAcw1fIadIfqz9RcezqLTKqL7wCpQHaRllV0ooDBQetTZQZH6l7pVzOF5o2mtmxpqHgpvdxjF+bOU1Hh97pk7saY+JXPJCf4VqJPgbGiLzueR6kQzxY2Xhu0kLlcuQKYlRPPzagBZHrz5NXxmRqao+fEBnbUFs3dVxSqd87gW0=
Received: from BN9P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 08:06:11 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::c0) by BN9P220CA0007.outlook.office365.com
 (2603:10b6:408:13e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 08:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 08:06:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Sep
 2025 01:06:05 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Sep
 2025 03:06:05 -0500
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Sep 2025 01:05:58 -0700
Message-ID: <337322ea-6efe-4814-a813-e55d4c80fda7@amd.com>
Date: Mon, 15 Sep 2025 13:35:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
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
 <20250904002201.971268-3-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-3-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: bd71dbe8-789c-41a1-afa5-08ddf42ebc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUhTckNNako3KzRrYWNmUVpCSGRYaWMzUU1EN2htOHJHR3RTemR2VkVxYlRG?=
 =?utf-8?B?TDRqSCt6TTdqWFpGZUoycDdNbDBnVGNLOWp2dlRzK0Rkby9MbUpqMHlJcVF2?=
 =?utf-8?B?RFc0WmhJbmtETEdDTGxUeTIyOW4vWUd5YjFTcm5JK29BZXJUNVZKUStDdVd5?=
 =?utf-8?B?aFY4YnVtY0xUdU5PVUt6NHd2S1JIU3RJR0t4VngrNGZ6cGFvMGZLdnZoay8z?=
 =?utf-8?B?U1loc3QvZS9LVWxCT1NiZUNhbFI0dnR2TTJTUHdVWGgwWHFBODJxTzNmMWln?=
 =?utf-8?B?MzNoL0l5VzNSSmNDb2ZHU3RrQ1IwQmJTL0h0T1BJeW45Mmk2UEVrd0xiMVdN?=
 =?utf-8?B?ZXJBYW9acm1FOWNoQkZjZjRzRTNmMEhEaWRPZllSM2NzWk9NV0I1aXQ1aUlB?=
 =?utf-8?B?ek9GQjgwbkY5TDB4Q1N4b0QvbnVsZUgyTnZReWVRbkFVSis3eFBnRjgyb3JN?=
 =?utf-8?B?Z1EvbkZLck4wVU01K3pJSmZ4eldzazBDNXQvei8yaFJ4MXZNT3kxRlNObHJB?=
 =?utf-8?B?bXdsQ1pMM2I2aFJ1c0RxNGI1dHdzQ3kyR3VzN0x5bm9LRlB0SEJycmpydXN3?=
 =?utf-8?B?eXVDY1FnbjYvc1MxVTUrYW9uMElEUXlhaExLajNtTzR2djlEZW1MdXB0S285?=
 =?utf-8?B?a1JRZElObENFODFhejlMb05aMHRUTmxBZTJCNzR6L3ZyVW9yTithY0YvaVdx?=
 =?utf-8?B?cHRhdWFRazJuMGdVUkdsc2JzcnMreS9uQ2R0VHRBRmFsOS9FUDFLMDMybmpZ?=
 =?utf-8?B?NlgwOXFIbzVEdVRpRElncHU4eC8ybXBFQ1Avd3lLUk54NWtGZndFaHJUcGhB?=
 =?utf-8?B?amIwSkhBeGdKdERyRFBFSXRhbllZbTJBWmhjT0xNUlBWcXJqelQ2SGgxK2hS?=
 =?utf-8?B?c2xJMmdDZmw4UGw0QlNJWUduWGxpLzJ1ak51VUtjc0hNelFPTHNQV0VNUkVw?=
 =?utf-8?B?VVlnT1gxSjRPekZHVklYWGw5cU5LUG00ejk3eDQ0eE14aWxHR1FoUmFkcFBP?=
 =?utf-8?B?R1p5QUZtTXJwb2FsVk83YUhma3pXUm14OVNYR01FYlppeXlybDhHWllTTlNT?=
 =?utf-8?B?TktvWmoxVXBiSEhjVWZpRmFHYlJGM09FT2lKei9EL2JSNmlUZ1ZVUVgxWW5w?=
 =?utf-8?B?b2QwajI5MnAzRTlFaDdlVlVyc2paUEtZM1A0RVhpcVYyL1pzK1FwbmE0L0Jy?=
 =?utf-8?B?YjhaOHBmYnNmN2pYaURaTW9JaTYzWEhGcFlFc29VY2RDL25seFc1R0tqTFdY?=
 =?utf-8?B?dzNzTG5IakFTdTY3NkJOZE51aW5MdDlML3pBaWcrRFA3ak1FWEhTanlsM1p4?=
 =?utf-8?B?Q2M1cUJRTC9HdXlzVGc0Y1krN3Q4NWdLaU5qMENHRW04S29TejZTOENZdWx5?=
 =?utf-8?B?K0pjWVc2Yk5YNC95bm80cWNDaGkwbmgwM2ZobkgvRE83eWRUQkJydk01dlM1?=
 =?utf-8?B?Y1M1VlRCSkF6VEFmZ2I0ckZDOTkrdWExWXJNY0VQR3BndFdaVTRxQWg5aEJZ?=
 =?utf-8?B?WDU0UkZlVVVUYjloOUFYSXNDWWdidUQ4cG5qYk4zSFRlYnBNZzUwSWRVTUZz?=
 =?utf-8?B?MEs0TzhQR0FDTi93VWx3K1g3YUhLVzlGUjlnaHlDWTczTkovdk42MElSblAv?=
 =?utf-8?B?UWIwUENFL0dCZGpqbnIrZU5MeEtYQ1dQOTJpUXQ1eUxsV3ptQ0F4RGJPS0tv?=
 =?utf-8?B?N1FrY1BwUFZHSlU2ODkyY1VSMzcrdkE4Q0VpcTBZOWd2L043RUx4dHRSTDZ1?=
 =?utf-8?B?SXcvQmNpbnhLZlRZQTc0ZHNXaVBuRE5sUFNiM09NT3pIWjdET3VCSDFacFJq?=
 =?utf-8?B?VmZJQVo3NEF2VnpzUE94b2wwRHZIRkxBZDZYRk9CWFJUdklSMVZnU1RkQWx2?=
 =?utf-8?B?a3BqWlVUTlBnb3BVVGk5TU5MYmo0cjJRQjlMK0lFV25PQmdKQmZidGRGNWhC?=
 =?utf-8?B?T2d3ajlzTnhOMlg4MDlqbFhrL0lzRDRhSkxnYnU1RjE5aC9yQnVmUjFiZFlK?=
 =?utf-8?B?WkRZdGx1MHM1Vnp3SitsbUxJd0N5TTl1NUtxVnpLTWwwUy9KYTl1c2dJUFNC?=
 =?utf-8?Q?qw1+XJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:06:11.7931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd71dbe8-789c-41a1-afa5-08ddf42ebc1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
>  static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
>  {
> +	/* The task should only be clearing itself */
> +	WARN_ON_ONCE(p != current);
>  	/* Currently we serialize blocked_on under the task::blocked_lock */
>  	lockdep_assert_held_once(&p->blocked_lock);
> -	/*
> -	 * There may be cases where we re-clear already cleared
> -	 * blocked_on relationships, but make sure we are not
> -	 * clearing the relationship with a different lock.
> -	 */
> -	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
> +	/* Make sure we are clearing the relationship with the right lock */
> +	WARN_ON_ONCE(m && p->blocked_on != m);
>  	p->blocked_on = NULL;
> +	p->blocked_on_state = BO_RUNNABLE;
>  }
>  

Maybe it is just me, but I got confused a couple of time only to
realize __clear_task_blocked_on() clears the "blocked_on" and sets
"blocked_on_state" to BO_RUNNABLE.

Can we decouple the two and only set "p->blocked_on" in
*_task_blocked_on_* and "p->blocked_on_state" in
*{set,clear,force}_blocked_on* functions so it becomes easier to
follow in the mutex path as:

    __set_task_blocked_on(p, mutex); // blocked on mutex
    __force_blocked_on_blocked(p); // blocked from running on CPU

   ...

    __clear_task_blocked_on(p, mutex); // p is no longer blocked on a mutex
    __set_blocked_on_runnable(p); // p is now runnable

>  static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)

Of the three {set,clear}_task_blcoked_on() usage:

    $ grep -r "\(set\|clear\)_task_blocked_on" include/
    kernel/locking/mutex.c: __set_task_blocked_on(current, lock);
    kernel/locking/mutex.c: __clear_task_blocked_on(current, lock);
    kernel/locking/mutex.c: clear_task_blocked_on(current, lock);

two can be converted directly and perhaps clear_task_blocked_on() can be
renamed as clear_task_blocked_on_set_runnable()?

This is just me rambling on so feel free to ignore. I probably have to
train my mind enough to see __clear_task_blocked_on() not only clears
"blocked_on" but also sets task to runnable :)

[..snip..]

> @@ -6749,6 +6776,15 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  
>  	WARN_ON_ONCE(owner && !owner->on_rq);
>  	return owner;
> +
> +	/*
> +	 * NOTE: This logic is down here, because we need to call
> +	 * the functions with the mutex wait_lock and task
> +	 * blocked_lock released, so we have to get out of the
> +	 * guard() scope.
> +	 */

I didn't know that was possible! Neat. Since cleanup.h has a note
reading:

    ... the expectation is that usage of "goto" and cleanup helpers is
    never mixed in the same function.

are there any concerns w.r.t. compiler versions etc. or am I just being
paranoid?

> +deactivate_donor:
> +	return proxy_deactivate(rq, donor);
>  }
>  #else /* SCHED_PROXY_EXEC */
>  static struct task_struct *
-- 
Thanks and Regards,
Prateek


