Return-Path: <linux-kernel+bounces-826608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54529B8EEA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F587ACF2A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E62D94B3;
	Mon, 22 Sep 2025 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DJhOxCAX"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191061548C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758514499; cv=fail; b=EgvmbCRlfL34JzozWLD5pnBG0g2a5R9zlEcoG1Sg4o/U1ApBo/+g05scgHCLFa7CwfAEY4eKAKKJQLef4Bqz1zoTdn1jLv/OG8Z3IyXvEGE/MNDLaxlb+5LqwZXNYGVeeUC1tKSKO7Ef02raZYcnwNX0+sAfshFtf2vV3sl7Wwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758514499; c=relaxed/simple;
	bh=H5rDH3GPTY9PKBp2efDPIxepHTVJkuXMRF82GyUCqCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Uq2Ht5u/WQ4TeJNfiVTGdretHyAO0Z7T0L0oScpql3fq6sV3Q+OSBZOLu1i2Gn1rRIJzL+sO5v4zt8eCXII6Z6KKL6eekmGfWtj0UJwYFUlCXkTwODB2r0VnzR9lYCdWT25x71K3VfQh0bZ2tKg3/u+D+Ik1SC0WxEOEKW8ruzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DJhOxCAX; arc=fail smtp.client-ip=40.93.194.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiEqnhmU39btPtbECNHQBr/uYfHYxDe4NPyOY/aWRqxXhYhBZi2rUMJxuEJNdCDFc70/hL/ehE31t7+v+fGLOYxitMHWG0mgJ1IlR+lvRu0xMxoOL8WXhOQKAbu29t169Pt1ocZAnOS/sv56iANNpmEzCRJC3UCuK2j6nrLIkTJ/nhWX6o2m4tw059byYCjVdj8K5woQXGG7Msv2RZt/KVdS/tsr5gBz+q5UieHm+coAIgNsMPfoX0vBjivSnpMzDTTv6Oz7aLHvepiAmgGRbgg2gLKjTPVNRVWPUzoI7KiZRCgMhAS1PilPrtE8NxVBJvUDnbNt3PKrAKGKna3t9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpMUyz4R0N84fNFAqybC0olAzAlEbG3uAIjbUsqCN/I=;
 b=Bn+gzphzdF0SsaAbl39k3uF09EgHmqEV0EoNqwM2gUWVd5ZBU/D4ne241FdoOGQPxnh8BIkG+PH9MANoD0cgdcwsnMHkxf7TSc6kfHrJW3fVURp+feBjjwWATQUSFnf6xn4U2hQnWzzGLlHWD4CrT7rmUvNwqpqJKFUdEaIx8EuR1ievzPhP/Oy1+51ChwfmcpNYMaWB2Y4Kf1Qtrh0QYYeHdr8h8FCwx26wWp0LM6V1a2QBf9soPvoppit/NAFa9/DZoEC4es2hAOcw0ntXTGx4hJlHeAuF3ekrs3PXO/1knMMIV6AGZAOzpdiloFOkSUDcUip2kwRTlUGqy7wBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpMUyz4R0N84fNFAqybC0olAzAlEbG3uAIjbUsqCN/I=;
 b=DJhOxCAXI+CnD1DE5nLZPYKdpB/Mhi72jKiBCOOEF7gj7rI5lZ9Jf81UrfCwUK0lX969uIE1sIk4FcAKR++7GAAyHBMsnwWNMyNC6WhB33Q5kGUxGv3Z2z2XKVmaB8E3nDp4f7U8pLsA/XiQE3/8+VGEZH5AMPJair3+1GSnZ+8=
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 04:14:53 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::f2) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 04:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 04:14:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 21:14:48 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 21 Sep
 2025 21:14:48 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 21 Sep 2025 21:14:40 -0700
Message-ID: <044fae5a-20a2-4b65-83c4-2ba985543232@amd.com>
Date: Mon, 22 Sep 2025 09:44:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 4/6] sched: Handle blocked-waiter migration
 (and return migration)
To: John Stultz <jstultz@google.com>
CC: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
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
 <befadd44-9549-4400-ab28-b8aef55cd73d@amd.com>
 <CANDhNCphG8LzYEM321fXpg4xCXL8kqfKbtttV-HN+e1tZCGahQ@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCphG8LzYEM321fXpg4xCXL8kqfKbtttV-HN+e1tZCGahQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: cd63e073-ecaf-4bed-5af9-08ddf98e945f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEVPQThiaW0wTWJKMGFBT2V3ZHdZOStsclJNdC85WUd4RW5FR1g5K0hZdkxP?=
 =?utf-8?B?MHhmeEVQa1RJTTViTXdqU0ZlT05OdmN5WmRzYm9ZTERUb090Lzh6KzRTa1Nx?=
 =?utf-8?B?K3dNeFp5M3E0MkcydGFneWZnU0JmdmpzemIvR3VmaGp6RGRWaTNnU1NYRWR2?=
 =?utf-8?B?RGEyQmFLQlRqd1RyNDdOdyt4TEQrMzgvUDUxNnJIbTJmRndFSkZIeE9Vd1lK?=
 =?utf-8?B?SlhMQUY5TGp4SlJNRHZOaWtKaUdkT3h0ekErelNtSXU0N3o3VEFhZmpnUkpB?=
 =?utf-8?B?Z01UcEdzNHlsUHJROFVNNnpkTE4vTTNVbXRwZzBWaDZDRE05Z0w3dnV5cDlo?=
 =?utf-8?B?V1pQTU9xQTFkdUpTYUF6anhMcjFEUHEyY2R2V3JvZVVuOGhXUUQza1ZGTjEy?=
 =?utf-8?B?cit5Vmt5b1hrNnpPNDdRMTFaczltUzdBZCtlVVlma1lCVkdjWmNmSTdoWVhB?=
 =?utf-8?B?OFZVU3oraG05c3VCQUt3ZDZQZnlCU1V3cDk5S0hjTllNcDZwbU95ZWJwZkF4?=
 =?utf-8?B?V1huVVU3b0dYMnd5Q3gwSnpTRE9SQjg3WVl5bk1Gb2hxRjAyRk41OU1uUmxH?=
 =?utf-8?B?bEg0Vm1QUExhZER1aTJuVmdhb2NFSU1qL1hKbVNmaVAwSzllRE43eS84ZHo0?=
 =?utf-8?B?K2dsVWE4ODVOeVduZXRrRE9KREM0eEUvekdobk1qa0cxcjNLV3Boa2lRNktZ?=
 =?utf-8?B?Ynd2Vm83TWZpUmZ1aU45dllHZnBjYmZSbWNMNVUyZDMrZnMzdkJFcXRrbjFv?=
 =?utf-8?B?WjlweW5iQnhHRmZ2dGhmQ2dFTVJ5MmFLZ3F3bGxpQ2RFcnorZjlDMnNTN0Ix?=
 =?utf-8?B?aGd6UTdLWTZpV3VBVzF4dWdPL3I0RmNPNGhtdmtIY2FZUUwxMXpMRGwxL1hv?=
 =?utf-8?B?cnZCbVk2VzhScWJaL0ViTFJROU1CZGtRTVdHNDUxNjV4VXBqQVBVeFZCTlEz?=
 =?utf-8?B?eWhKK2VmM09sUXlpd3VzTUJiZ3phVzV2MjhSWjdpc0xkazZWVWdCVGhGK3Bq?=
 =?utf-8?B?emRWbnRid21QOUpqNzJUU3hHM0lRd2JLOER0MG1pY1o5ZGgyMlpVQWJlOWE5?=
 =?utf-8?B?YmZPUHI3eXZzZjh5MlZOSnYxQkYwbkRnUG5wdEVRV1g1eDVRLzRwTmdRK2E0?=
 =?utf-8?B?SGtRK0hMRjBCWjdtT0dSanN5Zjk4U3VFeGZzYTE5ZzcyeXZ4akI5NnFUMnAw?=
 =?utf-8?B?bktEZlB3ZWU5Um5pNDZRZWpNTVg0SlV3SzhSVkhIdEVUWWpWajJKRFBCU1dY?=
 =?utf-8?B?dDMyalNxTzdwT0ZXelVkRk5ZRkVTa3RuWVo3NUwxbDRNaW1rdWtGSUlrbmpD?=
 =?utf-8?B?WUZJL2pMbWQ1M0dFN2VEM2xJb1daVlZlMUM5SzM4bU9pNkJYcVNHbnhPNVFk?=
 =?utf-8?B?RXRkdmdCSG1KRERSdTM0RmNxWDg4VnZzbE5vK1RJRk83bWpabFl6STU3WWRw?=
 =?utf-8?B?Q1kwNnIrcHhFaGpKQ3hyVVFmek9wcEU3Rzc1REY1UmpPWmVUU0dUNGxCeHVz?=
 =?utf-8?B?VGdJOTJBd25sU1VDTTBjRENBaXp5RUl0UHNuendjTk0rR3J3NUtaenQzV250?=
 =?utf-8?B?Ukp1ZlM4cWUxQUtnM2p0ek9FTUlobE53QmViQzhNcGxkMUVQaGVoZmcrTkJG?=
 =?utf-8?B?ZG1YVGVBcTlIS0pSeWdGNGllZEpJbno4SXJiVERXZUtXWU9TUUJ2OGFvTCsw?=
 =?utf-8?B?T0o4cWFFYk5TamdmT1RJK1BCRE5obEJmNzdVaFAzVXZ2dlI3V2dqY2ZqTFJp?=
 =?utf-8?B?TU9kUWpMYlJBRk14YmQvREd4WlZQOHgxaFd1bVpxTGcvT1N6TEkrS2RydFU5?=
 =?utf-8?B?Rnc0ak5nbVI2N1h1WEc5RUM1NkNWTFJ3eW4vNUw4OGlFczUrdUd6K2pZWnpH?=
 =?utf-8?B?MEtEWk8vckxyQU45dHREV0lJb2tyOGM0eFFCZkRTdmNQczBYYnZRSnpzTkFp?=
 =?utf-8?B?V2dsMGRRLzdmeTFkUkM3NjZ3THVvOE5OM3ZzeWFOUFI3QXJGcDVDTHVzTndU?=
 =?utf-8?B?TzBUT3RwT0xHVkU0dkZHRGQrTmJIV1ZucXVPZnJud2FLTTlUSUhYTDJNQXdS?=
 =?utf-8?Q?5EJSZr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 04:14:52.5710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd63e073-ecaf-4bed-5af9-08ddf98e945f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604

Hello John,

On 9/20/2025 8:08 AM, John Stultz wrote:
>>> +     put_prev_task(rq, rq->donor);
>>> +     rq_set_donor(rq, rq->idle);
>>> +     set_next_task(rq, rq->idle);
>>> +
>>> +     WARN_ON(p == rq->curr);
>>> +
>>> +     deactivate_task(rq, p, 0);
>>> +     proxy_set_task_cpu(p, target_cpu);
>>> +
>>> +     zap_balance_callbacks(rq);
>>
>> Is this zap necessary? Given we return NULL from find_proxy_task() for
>> migrate case, __schedule() would zap the callback soon. I don't see
>> any WARN_ON() for the balance callbacks in the unpin + repin path so
>> this might not be necessary or am I mistaken?
> 
> So unfortunately the issue is that when we're letting go of the
> runqueue other CPUs can jump in via sched_balance_domains()  ->
> sched_balance_rq() -> rq_lock_irqsave() -> rq_pin_lock() which will
> trip the
> WARN_ON_ONCE(rq->balance_callback && rq->balance_callback !=
> &balance_push_callback); case if we leave callbacks.

Ah! That makes sense. I overlooked the fact that we have *other CPUs*
that can take the rq lock once dropped.

> 
> So we need to zap the callbacks before we drop the rq lock.  I'll add
> a comment to make that clear.

Thank you!

> 
> And yeah, that means we do call zap_balance_callbacks() again after we
> re-take the lock and return null.
> 
> I guess we could remove the zap_balance_callbacks() call in
> __schedule() and instead call it in every case where find_proxy_task()
> returns NULL? Or we call it twice in the migration paths, as it should
> just have one entry the second time.

I think a comment would be good enough with the current flow. I'll let
you decide which is the best option based on your understanding of the
complete flow (I'm still slowly wrapping my head around all this :)

[..snip..]

>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index b173a059315c2..cc531eb939831 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -8781,7 +8781,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>>>       se = &p->se;
>>>
>>>  #ifdef CONFIG_FAIR_GROUP_SCHED
>>> -     if (prev->sched_class != &fair_sched_class)
>>> +     if (prev->sched_class != &fair_sched_class ||
>>> +         rq->curr != rq->donor)
>>
>> Why is this special handling required?
> 
> Hrmm.. that's a good question, as I haven't thought about that in
> awhile, and I'm unfortunately forgetful. My instinct is that its a
> concern that by checking the prev sched class is fair, is assuming the
> prev task was selected by the fair scheduler's pick_next_task last
> time around. But since we may have picked a blocked RT task as donor,
> if we are proxying, we can't assume prev was previously chosen by
> pick_next_task_fair(). So we skip the optimization just to be careful.

My interpretation was - since pick_next_task_fair() selected the
scheduling context, it shouldn't matter what the execution context was.

> 
> But this may be overly cautious and looking it over I don't
> immediately see it as necessary. So I'll drop it and do some thorough
> testing without it. If I do find an issue I'll re-add it with a much
> better comment so I don't forget again.

Thank you! I too will do some testing and let you know if I see
something go awry.

-- 
Thanks and Regards,
Prateek


