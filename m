Return-Path: <linux-kernel+bounces-832314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B644FB9EE46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50DF19C7286
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D162F7AA6;
	Thu, 25 Sep 2025 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NybZlpv2"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D220CCCA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799359; cv=fail; b=UwQYPxAB0HV5LEPKS5HSF0BmJAdwnqnDYN6C5VFUtwT2t18cZW/lQPOJsGIRn5bec2+EdLL0qD6OwOg0UqZHThTjTSmht3qRTAkK0ABhMsgzh57cdKlBY2WhW2YEUfSJlUMq9ntU9WrETKwlMnXBpl7mO9B4OR8SbNvBrKdFymE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799359; c=relaxed/simple;
	bh=E/iP9lxiV1obaQX2H+WSGkMAvp7rsLYFPGZC11gGzU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DvHsX0SVKEs1Rk7tbcbMGP9t7gwmUGWUxjDfpuIqaFIgxbvht1W7qyc04NwSl+Qxw+vlUmY4UH/yQ98l3XDqDE7XiPadE7pJM0aRQ8QSDznec9utQy8K4no0MmhPqkywC9NwnNFgGdNTXrwY7KpfKuaDiHNU6PeBSS1Wjm7WNl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NybZlpv2; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwH0IeXpZusyzMdFfAglk1tjKWY8/l4D7ZUkkAFGVf/xR92jkNBHq8dwhUWocsfcQSj96wtNysSmfwyBKTZKoYbjeu6eNsa0Dgs4SMuRWTMa+3+D0sKxf7VgCMjKfbJttZpPecjIBN+sH9irnkO6zDBeWsX7laE3VRfXGZMxhRJkevY18UpUc4mOiw2abqC5zI3jbAk1csAifxkYkj7/uK3f7MiqrqWHWSgCNa1RviLDM8uytTGoBZfWKTWjVhnOmrAtGWeWvmLyaWlFw5TDyzARYLhivzu5w8EqtnEz+vuV6zTdvR+AwU7zFrShoNudHiyMv+c4U7tCcNawn0b9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rCuZE4KW+kgCRzvvU9ejnaAYidNYkYRGzYIAtjOxo9c=;
 b=Gr7VIP5kYPLrUNimyyAV0rlMcqEK7cnjruUWbB1PfZfhpY/u7IXO6wjbhS2RGMDMjYDxlufR2yTRG14xfNPKzZYboPcPDbjjA4FqE6JQ4O2MTAToLVP9o2inMnAEYM0tUlsRagEbwqIM2I9HVp+e9IgW98VHnGySv8ar8AFeAIwNMAkfha3T0GawHdDlG6u1zgGJLnqnQZ7LWIyFNODIMfaoyBNJymRqIMFi4wgzKjqD/6J7/3OG+s4Jsiwyn6Qgf+JREaFo3gGzyPJEiyEB0j5mbS43IQvgHD4PgTTa5DlyrJza+gbHFKz/F3JTe/qZJ2JSp36oAVLgCciTBrUFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCuZE4KW+kgCRzvvU9ejnaAYidNYkYRGzYIAtjOxo9c=;
 b=NybZlpv2oNcUWyVTmhziImRfvk+ojfWea08WTdtUg2T5T6VT6GMArhrMiwc23E0YtaVnp7g0U5pj+eF7dWv/aCH9ipHxK/6KtvHP9CLh6ri5Ez/lBHbUyklyb/sZzNuE0oQ4M7hBYv8ci5yEVXQ+UatCvz89QAZg31VRIxIdOPs=
Received: from MN2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:208:234::35)
 by DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 11:22:35 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:234:cafe::4c) by MN2PR16CA0066.outlook.office365.com
 (2603:10b6:208:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 11:22:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 11:22:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 04:22:34 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 04:22:34 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 04:22:27 -0700
Message-ID: <72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>
Date: Thu, 25 Sep 2025 16:52:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Matteo Martelli <matteo.martelli@codethink.co.uk>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>,
	"Chen Yu" <yu.c.chen@intel.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
 <20250924113354.GA120@bytedance>
 <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
 <20250925092938.GB120@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250925092938.GB120@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DS0PR12MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cc35f3-97c7-4414-de81-08ddfc25d369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFNVbG5uRjNLN0QyODhkTS9xUzBJbE9Va3ovZWF3YmpHcnMvU3lMKzJxWVRZ?=
 =?utf-8?B?SFJzUDRYOG43Qzc4ZGphNDlhR2dLc0l3N1VLYnhjMGJKZVE5TGhSUk9GVGlx?=
 =?utf-8?B?SU5MWmdoL3RrazJjaU9lSXpLMnQyaGh6WWZFNVlPL3dyTXU4VUFDdm5oSXN0?=
 =?utf-8?B?Y1NtSUVJc2xqNjJyNDEyMmE1eWxvR25kNlpnV3ZFa0ZpUHJOdjRVU1FxaldL?=
 =?utf-8?B?RkVtemQ1NjdkdEhlN3cvN2RnRkdxVjkwTjJaOXNpQXgzckZFY0duUVE0WEZH?=
 =?utf-8?B?Nko4SEp3RVgrMlV6RFNGYU4yK0wvOUEwVzlTNG1OenVwTWFZUlF6b1pSbXp0?=
 =?utf-8?B?Q0FKdFhXRUk4SXNZOVB1MnUvMkhFVzRjVC8yTWhYMC9odG5JNEVlRUZDY1No?=
 =?utf-8?B?RUFGU2kveXp4VUxTSENkN2NjTzBpNXRUWFUvSlFldDRPTVc0NkcvWm9FUjU2?=
 =?utf-8?B?RWc5NzlNYW9GWE9HbDdrTnRNbjRnR3BwZEZtZ2k2NlB2S2RvTkM2RTNIbTJw?=
 =?utf-8?B?UWc0NFE4Q2wzWUpRRkdLeXgzUk5vRWpySlZ1YWxVcVlicVR4TEtEbGZKZGx1?=
 =?utf-8?B?d05sWEcvSzRIQjgyZHovWFhwRkxCdlBmblEwWDE2Z0lVeWdQVjlSMFBEdEhp?=
 =?utf-8?B?TDhiMU4wVTlKcDRaQWthbTlCeEk4blZDRG8wamY1M25nYkEzdDJZMjZtN2J3?=
 =?utf-8?B?dHkxUno1bHI0cjlpUzZhUTRGV1gzYUNOc3JhZ3hRMWVaZHJtdmtoTmJQK3lp?=
 =?utf-8?B?MUJJOEQ4ekdRUXNCSDFGRUZERkdjY3Z6T251dzZpVEFUVytsK1lMeS9ESHIv?=
 =?utf-8?B?YnllMFNDWU1ZRDIzTTdsdXUrVWRNUVh1MU5uSU5SM01HbHBTaU4xMmRycWV0?=
 =?utf-8?B?U2hSSCtHcWdsWXUvcWR6WUE4aFhSZmh1NHZLV2F0Tk0vdXZ0M3hXUm55NmtG?=
 =?utf-8?B?VkEzWERKRCtISTNrZzFjUmY5cXNxdFVSbEpIM2RkdmpJYjFLeUJJMUdJKzlx?=
 =?utf-8?B?ZExvaUk4WUwyRXNzYmFIRFVrc2pJMDFQdU9tMWR2WlVRbmIySitTd1NZNlBG?=
 =?utf-8?B?cTZmQTFiNkpMRnhnYTRIV1VVZm01Z2UrNUJqQ2FNVWZUdFloeWVna2tFY1ph?=
 =?utf-8?B?SFM0L3VnR1VYUWJRNThOWHk0amdKei9sT0liUnNIZEhUSjYzZDAvckdHS2Z6?=
 =?utf-8?B?WENKNjFNWXl3VFZ3eXFORDVGT1A1RWpnT1RqNktSRjRNWk9mUE5Beklya1c5?=
 =?utf-8?B?OHlKQ2MvR1FuUmgvVjcxYmpOME14Nk9PMW9Bc1hFM05tdnhIcGNpTUp3b3A0?=
 =?utf-8?B?RS80aGF1OUU3S0VRaWdDaWI1c0VRVW1YanVVTk9CTHJ5ZXB3RFZjSFhjYnND?=
 =?utf-8?B?VWNVQk9tdTFKeExEMElwZVlSMjFxdVA4ZW5RYkdSL0ZYSVNFWnJHQ0tYaDdW?=
 =?utf-8?B?cHppN3c1SkZycGRZRUt6L0c3ZkMxamtmYVRQd05lTVZLZTFlUXB1SXdBQnpQ?=
 =?utf-8?B?dENybUV4dGx6U2NKa2FIYzRja2VnaEdpVzlBRlIva1NSVFJFazRoRzd2bzgz?=
 =?utf-8?B?Tkg2M3krRzVjbUJkZGZhbVpyUzJZY21jdEl2WVRmakhaUXVPQzhpQnVtVnBr?=
 =?utf-8?B?YXMvVFRPb0hIYVNTM3h0dmkxRTZoc3BIUXVnZTFDencveE91c1RQZVBQOWZ6?=
 =?utf-8?B?Y0w5WVpjMmFWMWhRYlVWMXVHMWV6YWs4T3FHcWNhOHVndWpVS0RHZGJsaG1x?=
 =?utf-8?B?M2dDMVl3SlBhK0o3VHRGS0ZLU0NaVy9jSExac3RhTjJIT1g2SHo5N25qU0pw?=
 =?utf-8?B?cjFKbk4yTW1ORmFmUmU2Vm5KZWR0dU50Rzk2Z0NRN252NlYzSVBJemRhM0Zu?=
 =?utf-8?B?TGJGMzRmRHFzMWZkQTZmTlcvVzhsSE83ZFRXRXpVTE1JWGZ0SmdoSEtCY25R?=
 =?utf-8?B?Zi93RklLSlZacFZvS3QydUI2d2U0VGNWdUR2SCtvME5oNWFZMTNvaUkrYWI3?=
 =?utf-8?B?VXRMU3lNSnpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:22:34.6990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cc35f3-97c7-4414-de81-08ddfc25d369
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6560



On 9/25/2025 2:59 PM, Aaron Lu wrote:
> Hi Prateek,
> 
> On Thu, Sep 25, 2025 at 01:47:35PM +0530, K Prateek Nayak wrote:
>> Hello Aaron, Matteo,
>>
>> On 9/24/2025 5:03 PM, Aaron Lu wrote:
>>>> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
>>>
>>> I stared at the code and haven't been able to figure out when
>>> enqueue_task_fair() would end up with a broken leaf cfs_rq list.
>>
>> Yeah neither could I. I tried running with PREEMPT_RT too and still
>> couldn't trigger it :(
>>
>> But I'm wondering if all we are missing is:
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index f993de30e146..5f9e7b4df391 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>>  
>>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
>>  	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
>> +	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
>>  }
>>  
>>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
>> ---
>>
>> This is the only way we can currently have a break in
>> cfs_rq_pelt_clock_throttled() hierarchy.
>>
> 
> Great finding! Yes, that is missed.
> 
> According to this info, I'm able to trigger the assert in
> enqueue_task_fair(). The stack is different from Matteo's: his stack is
> from ttwu path while mine is from exit. Anyway, let me do more analysis
> and get back to you:
> 
> [   67.041905] ------------[ cut here ]------------
> [   67.042387] WARNING: CPU: 2 PID: 11582 at kernel/sched/fair.c:401 enqueue_task_fair+0x6db/0x720
> [   67.043227] Modules linked in:
> [   67.043537] CPU: 2 UID: 0 PID: 11582 Comm: sudo Tainted: G        W           6.17.0-rc4-00010-gfe8d238e646e-dirty #72 PREEMPT(voluntary)
> [   67.044694] Tainted: [W]=WARN
> [   67.044997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [   67.045910] RIP: 0010:enqueue_task_fair+0x6db/0x720
> [   67.046383] Code: 00 48 c7 c7 96 b2 60 82 c6 05 af 64 2e 05 01 e8 fb 12 03 00 8b 4c 24 04 e9 f8 fc ff ff 4c 89 ef e8 ea a2 ff ff e9 ad fa ff ff <0f> 0b e9 5d fc ff ff 49 8b b4 24 08 0b 00 00 4c 89 e7 e8 de 31 01
> [   67.048155] RSP: 0018:ffa000002d2a7dc0 EFLAGS: 00010087
> [   67.048655] RAX: ff11000ff05fd2e8 RBX: 0000000000000000 RCX: 0000000000000004
> [   67.049339] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff11000ff05fd1f0
> [   67.050036] RBP: 0000000000000001 R08: 0000000000000000 R09: ff11000ff05fc908
> [   67.050731] R10: 0000000000000000 R11: 00000000fa83b2da R12: ff11000ff05fc800
> [   67.051402] R13: 0000000000000000 R14: 00000000002ab980 R15: ff11000ff05fc8c0
> [   67.052083] FS:  0000000000000000(0000) GS:ff110010696a6000(0000) knlGS:0000000000000000
> [   67.052855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   67.053404] CR2: 00007f67f8b96168 CR3: 0000000002c3c006 CR4: 0000000000371ef0
> [   67.054083] Call Trace:
> [   67.054334]  <TASK>
> [   67.054546]  enqueue_task+0x35/0xd0
> [   67.054885]  sched_move_task+0x291/0x370
> [   67.055268]  ? kmem_cache_free+0x2d9/0x480
> [   67.055669]  do_exit+0x204/0x4f0
> [   67.055984]  ? lock_release+0x10a/0x170
> [   67.056356]  do_group_exit+0x36/0xa0
> [   67.056714]  __x64_sys_exit_group+0x18/0x20
> [   67.057121]  x64_sys_call+0x14fa/0x1720
> [   67.057502]  do_syscall_64+0x6a/0x2d0
> [   67.057865]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Great! I'll try stressing this path too.
P.S. Are you seeing this with sync_throttle() fix too?

[..snip..]

>>
>> If load_avg_is_decayed(), then having removed load makes no difference
>> right? We are not adding any weight to the tg and the sum/avg cannot go
>> negative so we are essentially removing nothing.
>>
>> And, update_load_avg() would propagate the removed load anyways so does
>> this make a difference?
>>
> 
> You are right. I misunderstood the meanning of removed load, I thought
> the load was transferred to the removed part but actually, the load is
> still there in the cfs_rq when a task migrates away.
> 
> Having a positive removed.nr but fully decayed load avg looks strange
> to me, maybe we can avoid this by doing something below, it should
> be able to save some cycles by avoiding taking a lock and later dealing
> with zero removed load in update_cfs_rq_load_avg(). Just a thought:
> (I had a vague memory that util_avg and runnable_avg should always be
> smaller than load_avg, if so, we can simplify the condition by just
> checking load_avg)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f993de30e1466..130db255a1ef6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4788,6 +4808,10 @@ static void remove_entity_load_avg(struct sched_entity *se)
>  
>  	sync_entity_load_avg(se);
>  
> +	/* It's possible this entity has no load left after sync */
> +	if (!se->avg.util_avg && !se->avg.load_avg && !se->avg.runnable_avg)
> +		return;
> +

This makes sense. Maybe we can rename the current "load_avg_is_decayed()"
to "load_sum_is_decayed()" and extract the condition from the
WARN_ON_ONCE() in it to "load_avg_is_decayed()" and use it here.
Thoughts?

P.S. There is this other patch that also touches this bit
https://lore.kernel.org/lkml/20250910084316.356169-1-hupu.gm@gmail.com/
Maybe we can use load_avg_is_decayed() itself here.

>  	raw_spin_lock_irqsave(&cfs_rq->removed.lock, flags);
>  	++cfs_rq->removed.nr;
>  	cfs_rq->removed.util_avg	+= se->avg.util_avg;

-- 
Thanks and Regards,
Prateek


