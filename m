Return-Path: <linux-kernel+bounces-894911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA82C4C6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0D4E0719
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059CC2DF136;
	Tue, 11 Nov 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f6K1z8cM"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8BA23535E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850171; cv=fail; b=NheZ/+GPp5ygvQiMKsms6+yt742OGH+r6Fp1WYIQMkUch7gFjFbm/xCzvJcycMKXSWcdFxUnnt99bDXEB3wbsPcKqIjWUCdFPZGjR40pQEaSICfXrZMmwygpIeAJxH6aU0drGNjg0Viw7qBd00yZ4lmARIPS5WuS9r5fAkE8jJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850171; c=relaxed/simple;
	bh=Q5iCgifaLffqPiSYm1h4BCndR5pJC7sXlGQ9f8hYE+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S4RwWtWpLKbwVS2zzOlpczTMGEi0gdSsdYJ84znzrU8fRPZVbKxa9XC0ca+HOQCAXTnrhEruu9M9R119wPoN1L1Xzb/vPXaLW2nNo/1G0r6BZuqZsUEVipE2PbG74TqgdfywnOL50zNEMvudUMsNFmPEJgW57ECqK4zgGlRW7Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f6K1z8cM; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUe9cmcpOnav4yskrFCCoKTYQGbte1/Ux3oNUdjAuG7l2W229WaLv6GcvKtDgZQ0aAcTe10LfAtOIEX5Bx8sWLhwXNwQmGsF3OB9CIgb3CKLyrpfSG8ZdEgegI/Kv3YmpASgO2/UAIJvqMBFnFkIVRhsiptqqi6O/QERmnmVtxvcCG3jJQOuwgqpK6z2rBN4QWlPGKCWZLzj3APrIlXNnoyB1LEq+2c1lYs3S5jVUUbLzqo9hYb2qo9+FIZaFA0VqJmc7NuqTJarae3SG8q12e6d9fKuF/B6bWPi2Nqpjjzx5rowUJa77ZoYjqaYzOwSSkblzjWq/KuzB3Ryj+svyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfd3rT9kEv3FSD82uJW2RumBhiDrp6SpReUYvdKI8/Q=;
 b=CPxDdzMxH6y8/GBLDvf+3/TlLWIa58i1oZGxOZp3gyvro2kUQaZvVTJzHCVL0Musb0ABsnv5WbP1hkFeHdV6Cv5lnLMsM/1R4YMMsrawXCwcz1tTdvTOoXQ4Enzr+tIJz7wMjUOd6LccTX6di+9xu+RgVQ3ANNo/5wcrwO0T7QIEMZLFcuC7jMXVxZvW8ZbwiPqQLDEOcCqBUQvI7T1Pu/K6Z3Be4tqf4OVjQgmVdzjYcnMm4Rl9YM108PM3aheHUuuqnqFT8TYHgdiSjcyrJ+UopfxuunV4F2haPucb2qdtBQlIwJJ+ApDbbocb9NYcfnQyysIJx2gYwAVolCJVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfd3rT9kEv3FSD82uJW2RumBhiDrp6SpReUYvdKI8/Q=;
 b=f6K1z8cMTJcd/j74ssJx18v5qUrQrwmklL3/dSUKXW1iRqjtYP/Nm8f0OKIYf9AWW192VXFNbRINK5/IRyxlS/UHYFmlUSi5nusrf6wrVqea+vDr5XBxNJgPna/QG4TrYjrGGezr969PXL+7xjur043KkOlgSU0A/JJkWYHMUmQ=
Received: from SJ0PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:33a::20)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 08:36:02 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::3) by SJ0PR03CA0015.outlook.office365.com
 (2603:10b6:a03:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Tue,
 11 Nov 2025 08:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 08:36:02 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 11 Nov
 2025 00:35:43 -0800
Received: from [10.136.37.117] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 11 Nov 2025 00:35:37 -0800
Message-ID: <3039bc9d-442d-41f7-93fd-fc7eb3a6fa40@amd.com>
Date: Tue, 11 Nov 2025 14:05:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 8/9] sched: Add blocked_donor link to task for smarter
 mutex handoffs
To: John Stultz <jstultz@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, LKML
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <valentin.schneider@arm.com>, Connor O'Brien <connoro@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-9-jstultz@google.com>
 <f9b42bf8-e4c8-4028-a977-f324ba2f2275@amd.com>
 <CANDhNCp=zbjcy-eCwKHcbgLSJjgzqz8ZLTMyZzNMkuXtLXseMg@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCp=zbjcy-eCwKHcbgLSJjgzqz8ZLTMyZzNMkuXtLXseMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0a5830-2c25-4c62-4e57-08de20fd58e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkViejU4RGFjZmhhZ1JiMlpsZGJ5ZVh0WDdYbmlpa0ZHbTdTbVNQeEIreFpW?=
 =?utf-8?B?MVRHRWxlTVZCcTZPUXI0YzZMSy9yTkhTZE5ySm05ZEwySXBlREpvNjVQQk9H?=
 =?utf-8?B?RVE2cVhiNEdZd0NwQW9UNWxVT3l5UTJDU0U0dmRUVmN2VDE4ejJDeGhVdjBM?=
 =?utf-8?B?akZKaE0wRjBPbFh6MDZGaEg2bTB3bmEza29zSVlTd3lnUkxTazdtM2M4WGU3?=
 =?utf-8?B?L0lVdkovbkg5dW5WcGlRcU8wc0pGeTF3VmRvcjROQzJjZ0hFOTlsV1RGYmlU?=
 =?utf-8?B?SnhzNitXcE1XYitGd1lKZUxIQlN2NzBrSURjVk5DMFYwcFRKUUZwc0JNODdT?=
 =?utf-8?B?aC9xRWVJSm5qWlNHV0c0WjFOTWdvOVk2MVFhZ2FtNTRCaHZrUTVtWEtzTXpJ?=
 =?utf-8?B?U0xhRC9LVHF4TEpaMGg3TlRubXJnOXBSYVRUWGVxMlN2dmM0ZkhtVkthMXlq?=
 =?utf-8?B?K0lLU1A0Zm4vaXN1RUtna2JyZjhBWjRoMlZtZXNOb0VhZHM1c0pna1Y2dnZy?=
 =?utf-8?B?b0RHeHNHbzNFekZ1UDYrbzhWT0lDazZxQjZFd2h1YUFpRSswbU43WUVpS2lk?=
 =?utf-8?B?Um9CaXNGNTVrKzU4YXFKbkZQWmk3V0tVYUREa1RJaDErdnphVVZsdVREank0?=
 =?utf-8?B?Zlkzdlg4bTFGemhRM2RaY0RtVEREWVlLdW00MjFuTHl1TWp4NE9Qa2lyRW9N?=
 =?utf-8?B?L2ZTdmR1MHZPQnEvYkZWM3p3MVMyZzRhRG1LQ00xSDZCckhRTlYzemU5UmZx?=
 =?utf-8?B?US9GRGdwOXlkSmNhekIyZ3gyQVFmbXdIVE8xRGxZZGtJTUJTWkYzVzI4ZGl0?=
 =?utf-8?B?TG5oSXk0aDNnRHdHM0N5U21TS1JoSEJOTHpOS0FCV1RXL25PN1lxd0xrWGlZ?=
 =?utf-8?B?dFM0OFM2a2RqUDdTSGdYYzRFQWl1RkJ4QXR5aE5rQy83RnZLNTFwc0pDRVp2?=
 =?utf-8?B?QW53QmhQclR2SUx0K2dEZDFCbEVTVjRGb1JQZHZJSGx0a3l4Y2M5NG5xRWtx?=
 =?utf-8?B?RnRRRCt6TUhkM1E2ckhHSjdEa1E2bWhYUC9wVFhpYnBxcXFWWllDdkhDN1h3?=
 =?utf-8?B?cGhzUGNxRHk0cXdlTzRINUhhS3BNdzRVWFhiWlRkcWx0Wnk3a1lOK295K2Zu?=
 =?utf-8?B?SHlGM09Rb2Jzd2dVOURabWQyR0hpbnVaK0UrYmhad1dzOHVKbXF1SzYvaGxw?=
 =?utf-8?B?cHJ0enN4bDdEVGJ0OEdMQjBoMEcvMGhnQi9BbFcxT0czRGp5UmhkNWhPeWpX?=
 =?utf-8?B?UzBpdWVXcTQ0QnFZMjd5ZC9lbEZDU1ArQm10UTBhbjdmTm95SGZST3FiZXky?=
 =?utf-8?B?aWFwdzYwY1lLWERMSlBRUFI0OU5TZnBEb2FRR0U0NHY5OEYvUC82dm1ra2JI?=
 =?utf-8?B?V3JDZzVXUGRteWxscFRMTUQ1dzBLSEw4TzB6Szl3MDBlOWg2RDBteHcxcVJr?=
 =?utf-8?B?dFkycmdUUUFRRFY5a1RYUy9oTXJ2ZEw1eDN1eFd0eXJ2bXpyVS81d091WmRJ?=
 =?utf-8?B?WEh3SDZlVStnYnE4TkpTU1ZXWUFDZDdWQ1dlNCtxNmdBb2QrMjB2M0s0Szhw?=
 =?utf-8?B?aW9QemJOblBtcE1yaTA4UFBlSTZhZGg0R1U3alFIL2haS1h3YmdWQWVEdzV6?=
 =?utf-8?B?OC82YUhSYUNXeE1RRk5Ia0hRVmpGUVRicW96MzhRR2NkRlRYVjlzdDQ0Qzg4?=
 =?utf-8?B?Y1p6UjRjSFdva2hpOEZGZlZWRy8wSmlZOGw1dnlzWGFGVUI4bzJ5MGxaVzZn?=
 =?utf-8?B?elV3RFdsVHBSTGVmVFhqLzdNZVBFdkI1dVZZWVJSR051UVI2dHJsdVR5ZVNq?=
 =?utf-8?B?WXBvTDB0Y3doc2ZXRTY1VzJnQXYvQmxacHFra1VoMTBYYXdBbHlwaS9Fek1C?=
 =?utf-8?B?bzlCNml4UE9laFZSM1JTY3ZHYys5WnhEN3p1aVZacGF3MGM0a0lHdkRjWXhE?=
 =?utf-8?B?UDNqUWhXK09kZUJPNGxOR2l6Q1IvUFdSakhwMmtrKzNqR2NyWlUrWXhHaGxS?=
 =?utf-8?B?YVlndWdnNkU5NGFvSFpCWVVzNU5YU2FpSFJOMHFxMFJ5VTJ1ZEJTWEpsK2tY?=
 =?utf-8?B?RHFpZEFyTWlwZURJMm5LTHNXQmJHK1VRRjYzWlFzc1ptNnlBQ2tPcnVSR3pa?=
 =?utf-8?Q?IaYY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 08:36:02.1771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0a5830-2c25-4c62-4e57-08de20fd58e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237

Hello John,

On 11/11/2025 1:20 PM, John Stultz wrote:
> On Thu, Oct 30, 2025 at 10:03 PM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> On 10/30/2025 5:48 AM, John Stultz wrote:
>>> @@ -958,7 +964,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>>>
>>>       raw_spin_lock_irqsave(&lock->wait_lock, flags);
>>>       debug_mutex_unlock(lock);
>>> -     if (!list_empty(&lock->wait_list)) {
>>> +
>>> +     if (sched_proxy_exec()) {
>>> +             raw_spin_lock(&current->blocked_lock);
>>> +             /*
>>> +              * If we have a task boosting current, and that task was boosting
>>> +              * current through this lock, hand the lock to that task, as that
>>> +              * is the highest waiter, as selected by the scheduling function.
>>> +              */
>>> +             donor = current->blocked_donor;
>>> +             if (donor) {
>>
>> Any concerns on new waiters always appearing as donors and in-turn
>> starving the long time waiters on the list?
>>
> Hey!
>   So I'm not sure I'm quite following the concern. The scheduler picks
> "the most important task in that moment" to run and we just want to
> try to to pass the lock off to the donor that was boosting the lock
> owner.
> 
> Are you concerned that new waiters would somehow always be further
> left on the rq and would be selected as donors before other waiters on
> the rq?

Something along those lines. Say the first waiter on the wait list
has been around for a while but a new waiter keeps appearing, starts
proxy, gets the handoff, runs instead of the first waiter, and the
cycle repeats.

    owner: A (unlock)
    donor: C
    wait_list: B->C->D

    /* handoff to blocked_donor C */

    owner: C
    donor: C
    wait_list: B->D (->A) /* A appears again */


    /* C runs out of slice; B, D and then A take turn as donor */

    owner: C (unlock)
    donor: A
    wait_list: B->D->A

    /* Hand off to blocked donor A */

    owner: A
    donor: A
    wait_list: B->D (->C) /* C appears again */

    /*
     * A runs out of slice; B, D and C take turn as donor.
     * Whole thing repeats from top as C is selected for
     * handoff since it is the blocked donor.
     * B and D keep waiting for a long time for their turn.
     */

> I can sort of see the argument that "new waiters" would be
> running until they try to get the lock, so they may have timeslice
> still available to make them attractive to the scheduler as a donor,
> so maybe they would be re-selected as a donor right away. But I'm
> assuming at some point the fairness is going to cycle any waiting
> donors up to the front of the rq to act as a donor and then have the
> lock handed off.
> 
> That said, I don't see how this would be very much different from
> new/running optimistic spinners having a better chance at grabbing a
> lock then waiting tasks that aren't running.

Now that I take a closer look at optimistic spinning bits, the
"got the lock, yay!" path in __mutex_lock_common() doesn't seem
any different in behavior so I guess it is alright to hand off
to the proxy donor.

> 
> But let me know more about what you're thinking of, as I'd like to
> better understand it and see if I could contrive a test to produce
> this sort of concerning behavior.
> 
> thanks
> -john

-- 
Thanks and Regards,
Prateek


