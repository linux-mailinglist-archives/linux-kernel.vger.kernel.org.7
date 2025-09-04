Return-Path: <linux-kernel+bounces-799979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA64B431EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A495479D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA423D7D8;
	Thu,  4 Sep 2025 06:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="znOLV9dN"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A1F22C355
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965851; cv=fail; b=ncEQrSdScZT7sw9j8y9/ToZ1D1U7ytQon4N4Z3VY/hbLYEVNWHFyR9GFTBYsSFR44kdo9qwtRtUTGvW8y4lkfiqb80uELqt5p1XeNPs30w7Go7zWC2wYZIWO770VtvV+fn2vYIU8fsmF3fDj//g4tZGbbE80TEKZmBqXI7g1NMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965851; c=relaxed/simple;
	bh=/FK8By/YrK7Aj+HX7oKOncq+TZefm1WnSDvOfwTFgms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mZMmCVty/GFoPZAEXqBuvwKMtOxoNcNABQ75lILF570NwDTqApvEsHEjGw99SRGI5+b1lIvzXMjVnbDo/ipoDRkqfKUKS4r1fe0JkQUJrHtiKrPZkmY4yuFHVSvF6G58buCH6bKJ8nCCMV9fE+oc+S/njQFG43tUIAmUJOL1WnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=znOLV9dN; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rErxrqRo4sZ2CgGc+I1slP/geNl3UP9F8Wv9gHL6QBkdHOqekgYXpjFMwapkZH7gQMQByjl9EHGQYH/W6fRlcM0RPoQK7BU75oXa8KP3HrdelrY1DiecgAYWKjEGbgff1tGkuPxrKRr4gbRK3AY0axqCc9ToCwjTL7wJqz+BCqkViOuKV6VVESV2psBg0NHcgLBR2ZDSZPnIriNhqLrf0Dtvpt5CcQ3v+42WIO8IKkg8W+ETIX+IVcRqnANIbya/9G8veeQSAl1yNWZ/P51g2KcG03zlW6CVO/xtB+iv3g2LuN0epDCx5ZdEj+ttUFOgbRNPdHpB7xKBYecTAbMLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe6gGiKcPxBrL7BCxIjMLKZVecPTxkaEw10ZGYyG4G8=;
 b=GHW/RelEOC3Og4jny9UrHmwxw9LBtis7FPVGVZ3PmR5UpInz/Pv1ICc+rmB8Ua1IRvyAwSoogeWpZpp2idlPxcNxAEr4DFgSRER0YiH/n2ADfjCw6+Xt36bsRaYciqaGv1ujRNVlIa529ZNc2I15zjm0k4i1XwH+8fzN5/I1rPKREAOnJOMk8TK+ocqIfFnXkgb8fjM3zAb7sXm1EQcEOsM8kbb5byy1/GydAKDsdZAzDo4bf0so04Pl06K3A9EaxiqXinVlKJgvlVI+eefZbTGZ37Z+f8hGJiefN9vYSe1D+kOmXvkJuGVDaZVrxtqVowQwZvtXJSwHELC0tf7Pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe6gGiKcPxBrL7BCxIjMLKZVecPTxkaEw10ZGYyG4G8=;
 b=znOLV9dN8UgXflKzGh6s7TDDlzP3zUr0XEs/hkR0M8C882xmRni0Vq5A3WaRGCAyKYlmQ/VkCr6mQrv8A1Lkmijcr55Z2l9xTWUWAVc4m78KQpfFD8hvvNNUpdI1eS5wA6Sz22ud6KA9NqHXKyrTbPneiAG5BfalhAXbpyQn+WY=
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:04:05 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 06:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 06:04:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 01:04:01 -0500
Received: from [10.85.34.65] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 01:03:56 -0500
Message-ID: <a5dd474c-5436-413c-a72a-38dfae9121cb@amd.com>
Date: Thu, 4 Sep 2025 11:33:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
To: Benjamin Segall <bsegall@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Aaron Lu <ziqianlu@bytedance.com>,
	Valentin Schneider <vschneid@redhat.com>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com> <xm26o6rrtgav.fsf@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <xm26o6rrtgav.fsf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: a7462906-97fe-4a42-4d4c-08ddeb78da55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVR4ZG54UVBDb3dZRVNTOUdXN3pKV3NZbmd2dkpYV09TSUlnS1hnWWlZT0M3?=
 =?utf-8?B?Z1BwSEY5TUo0Y1BvMmNvQkFhNG5kSmdsRGhlT3FiQ29ESjdxZXF0dHpXdGd4?=
 =?utf-8?B?dTYzb2gxaWJXOVQwaDNyalpvaTBXV0lRTU9xZU5PdE04ZTJzY09lUUMxSys1?=
 =?utf-8?B?QjNRWmE4ZHRjT3FzaTkxdUR0SDhDQTlXM3VMbURTVHRQaFJtQ1ppcWFYNXcz?=
 =?utf-8?B?N1pWeHcyUTN5WEdJSzE5OExNZFc1NnQrWU14cTZ3ekNDaDZtZURDVkxPZnNI?=
 =?utf-8?B?cFJDZ0xZWEk2eUl4ZXBuTzNHeHRBSkJzc2I5S0ZCbnkwV3VEaFU3MW83RlFa?=
 =?utf-8?B?TDhoeW5wMmM2LzRLZGRjR0FwUjkrWlREbHFsZVppY1JzaWNibEN4dEhhSGVs?=
 =?utf-8?B?UXcxaFA4UEFjMmtESWUwa2VDNWs1TnkxcTlJZmswSmtwaG1ITDVaNE4xZzNo?=
 =?utf-8?B?NWtueHpYSWFoMXhDQVpha3ZCRkFNVEVVVDA4bUZmdTdrY3BTQnhnSkIrU1NB?=
 =?utf-8?B?d28zaXlpZ1hoQnVxd0xSakFFTHFuZ3JTUDdpOElXRUdxYzFReitOTHIzeVFP?=
 =?utf-8?B?TWVRbXJXb3d0WGFBTTUzKzY0cTgzVFk1a0c2eEhYM2g3aVUzUGJwZ3dJdmRt?=
 =?utf-8?B?Q2ZGWndzSDcxZUtMZUVvbWdWbmdSdVdjVGhpWDlZRTJCOWV6N2IxbE1scVc0?=
 =?utf-8?B?OW1mYVdUcC9zemRtWnpvK0xmc2loTTFjTE42THNacTR5VlBFZHRFVUdjaDIx?=
 =?utf-8?B?Q1FWYUsvZU1UUHAzREJHczhCVmdqeXFSNFdONEF2MnZoSWhsTExBL3N2Q2lx?=
 =?utf-8?B?TWZoSVZVQXpQMDhpQ0hHVjJPTjFiWWN0Qlh5SlNFbGRMUGY0eks5MU1pQkth?=
 =?utf-8?B?NmJxNEg3WHVNczArQStMbCtJSytDSUFCZjRlaXQwRkN1TVF0WHFBTy9Od2M2?=
 =?utf-8?B?U1ZTbTNWdU5tUjlOUVBPSm85aTZUWlF2WEtmQldTa2VYSktNM29OZ3NoS2VE?=
 =?utf-8?B?ODZEWW5Fd216czQ2Uk9yZDRYSGYvQ2tKK29rMGpnRDFRWTJhUGpxTHNpZXlo?=
 =?utf-8?B?dndYZ0hNNnJ5dWt0R0dwdzlGUTZ5K01hT0FWTjNtYUZYbjdPaFVqTEZ2cUNy?=
 =?utf-8?B?UjhtbG9wdGlsaklWQndKSFRXeGtrcmhiMFJoNTVRUmtuaUpnU2I0eGpIV3M0?=
 =?utf-8?B?cWNkOXF6bFQ0WU9KeWlpZkdZbzlwelJwcGpaMmVNUG9RU1pPM3A5N05EN1BL?=
 =?utf-8?B?R1JxV0lWa2dLZElHZXJzK3JoWkRHZnZlMnlHUVFnVHpHT1lOQm0vN2tvTGRC?=
 =?utf-8?B?VzZjb205SUY5NjRYbXZaNzJnSkpGU1ZGcmZWM3JPVkp3cWlRK3czTks4SGVN?=
 =?utf-8?B?aHNPS2ZxUEY4bkhONTRqdDJQZEU4V1EzcEhoOURxSzR3Vi80WGNpYUhPeXVR?=
 =?utf-8?B?UHhCaU9xMVJ3Vm9LVGtsL2ROZGUvSjVoY3JoaEZ3eFR1YlBpU3ZoQUxaWndQ?=
 =?utf-8?B?eldzMStoL3N5ZWVzSmtxRmFDbndqWFNHSFAwMlk4V09zZElvcWZkMHVSa05W?=
 =?utf-8?B?bEIrbTNMOWw5cG9hbnVVajltYzBQTUYvWnMvY0wzOHV6ajRyaEExWW9vRkVa?=
 =?utf-8?B?UWFGb2ZpVU1ubHZBYjNUd3F1b1U5MC9mVDkvdTVBcW05VEZBR0pTZ3JNcjV4?=
 =?utf-8?B?MDVBY2VUSU5DZGdXc1F3c1JjdDZPcGRRbmc5QUN2clZwT2VxdSt6ZjVuRkgw?=
 =?utf-8?B?eWFHZWFBdUV6dCtLYmNHcE82YXZHUUQ1djRPTWVXVEhod2ZHU0pEQzRCSlA4?=
 =?utf-8?B?dmJVd3VjVWdnd1lLdVR3bUNlLzhyb1V5cGN5MEhRMlVlUGRvcC9IM0hZc1NY?=
 =?utf-8?B?Qjc0Y2ErUFdmN21PR1hFQjZucyt6eTJPdWF2UytFY0FkZ0pRa1B4YWhFTFlC?=
 =?utf-8?B?aWRiMHZERlRiT3lqWWdobEtNbTN3NkRRclpFMWZYci95amI4eHRkNWVMRHF2?=
 =?utf-8?B?WFEwTitRT3R3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:04:04.6762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7462906-97fe-4a42-4d4c-08ddeb78da55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100

Hello Ben,

On 9/4/2025 2:16 AM, Benjamin Segall wrote:
> K Prateek Nayak <kprateek.nayak@amd.com> writes:
> 
>> Hello Peter,
>>
>> On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
>>>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>  {
>>>> +	if (task_is_throttled(p)) {
>>>> +		dequeue_throttled_task(p, flags);
>>>> +		return true;
>>>> +	}
>>>> +
>>>>  	if (!p->se.sched_delayed)
>>>>  		util_est_dequeue(&rq->cfs, p);
>>>>  
>>>
>>> OK, so this makes it so that either a task is fully enqueued (all
>>> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
>>> its tasks are gone, and unthrottled when a task gets added. Right?
>>
>> cfs_rq (and the hierarchy below) is marked throttled when the quota
>> has elapsed. Tasks on the throttled hierarchies will dequeue
>> themselves completely via task work added during pick. When the last
>> task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
>> that cfs_rq.
>>
>> When a new task is added on the hierarchy, the PELT is unfrozen and
>> the task becomes runnable. The cfs_rq and the hierarchy is still
>> marked throttled.
>>
>> Unthrottling of hierarchy is only done at distribution.
>>
>>>
>>> But propagate_entity_cfs_rq() is still doing the old thing, and has a
>>> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
>>> iteration.
>>>
>>> This seems somewhat inconsistent; or am I missing something ? 
>>
>> Probably an oversight. But before that, what was the reason to have
>> stopped this propagation at throttled_cfs_rq() before the changes?
>>
> 
> Yeah, this was one of the things I was (slowly) looking at - with this
> series we currently still abort in:
> 
> 1) update_cfs_group
> 2) dequeue_entities's set_next_buddy
> 3) check_preempt_fair
> 4) yield_to
> 5) propagate_entity_cfs_rq
> 
> In the old design on throttle immediately remove the entire cfs_rq,
> freeze time for it, and stop adjusting load. In the new design we still
> pick from it, so we definitely don't want to stop time (and don't). I'm
> guessing we probably also want to now adjust load for it, but it is
> arguable - since all the cfs_rqs for the tg are likely to throttle at the
> same time, so we might not want to mess with the shares distribution,
> since when unthrottle comes around the most likely correct distribution
> is the distribution we had at the time of throttle.

So we were having a discussion in the parallel thread here
https://lore.kernel.org/lkml/20250903101102.GB42@bytedance/ on whether
we should allow tasks on throttled hierarchies to be load balanced or
not.

If we do want them to be migrated, I think we need update_cfs_group()
cause otherwise we might pick off most task from the hierarchy but
the sched entity of the cfs_rq will still be contributing the same
amount of weight to the root making the CPU look busier than it
actually is.

The alternate is to ensure we don't migrate the tasks on throttled
hierarchies and let them exit to userspace in-place on the same CPU
but that too is less than ideal.

> 
> Assuming we do want to adjust load for a throttle then we probably want
> to remove the aborts from update_cfs_group and propagate_entity_cfs_rq.
> I'm guessing that we need the list_add_leaf_cfs_rq from propagate, but
> I'm not 100% sure when they are actually doing something in propagate as
> opposed to enqueue.

I don't think this is required since the leaf cfs_rq removal is now
done via the dequeue path and if the cfs_rq is not on the list, then
PELT for the hierarchy below is frozen anyway.

> 
> The other 3 are the same sort of thing - scheduling pick heuristics
> which imo are pretty arbitrary to keep. We can reasonably say that "the
> most likely thing a task in a throttled hierarchy will do is just go
> throttle itself, so we shouldn't buddy it or let it preempt", but it
> would also be reasonable to let them preempt/buddy normally, in case
> they hold locks or such.

We can (and should?) consider it as any other runnable task until it
isn't IMO just to reduce the amount of special handling in those cases.

> 
> yield_to is used by kvm and st-dma-fence-chain.c. Yielding to a
> throttle-on-exit kvm cpu thread isn't useful (so no need to remove the
> abort there). The dma code is just yielding to a just-spawned kthread,
> so it should be fine either way.

Yes, this one can stay.

-- 
Thanks and Regards,
Prateek


