Return-Path: <linux-kernel+bounces-831962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAE7B9E04B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE12D7B801E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A773270569;
	Thu, 25 Sep 2025 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KbbUY9YN"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011062.outbound.protection.outlook.com [40.93.194.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B426E716
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788315; cv=fail; b=TUxChQDT9LPEf9cUd9w2dHeFCmGtH4Nfxb1YtxU8aP/0tVXHYh7nl5gJKSHGQX9dRx2JVYYK+0KRJgJUiadeESJJXhZduut6P0ZT+1XRjYW4JvPLyROltt3bO0fUbWGis/t5fv9wPZScdYdWUSTA8IlWRtw4TNnKkn5jqa3XuBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788315; c=relaxed/simple;
	bh=bKE9wFOVwvSzSG2No4zCAvdrHGNH/2wg2fN+lWUaa5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S0+hmVedsNXAoMa1urYCQ6ipiSGxpa2mAtv4FkufVBlFTwDSm6cgyRdo4f6/9Edt6YaLA6UDiK+8exy5CKWnMvkpjCdAplbWNeqGW+6PHpwK63HdGevAI/5NWjcAgd05oBqB5Wx3UsePkY++7CIQ6iuUNNScX8CkQtt03lNiVLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KbbUY9YN; arc=fail smtp.client-ip=40.93.194.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOmX5/bttf5wvryA+YDquXd+ZJYu33iqrkAY9QGDLTRS+yZoFuvG7r4555mRqVekPZdQ+/T5VkeWkb2KijJUiTowxKLsRPurqriGh7t87RmRM07Kahis80x7bJitSo8PL4o1zfwn8aCLoHeYXMSO4Dtn20JBw/3NPkKE6ljs7gqafaxgZgh9Sba5UPv0SBTBxfF8O31Qn7+768CpLxqLZX53RFEpb/Kx1iXjOgU0iURPj5yFZsnNqEmvlf9oMMBfCFt58irJr5/8TFmY2KbZ7fR5yvoyogDg/MJ49YL0k/cA/EPY5zQvNSkqounXzHTX/CQmO0ms/Scd6giWjm9dYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYPyvEu90NlIh2yvUHJt4QZWAp3pa8kRPUGgLFjAGVg=;
 b=ih8GC44fsOR8nhGdm/Azfu1cFMtn2fHSvPYHoes81UyoqyD7HQH9jYiQZYViCu3ov5CUo7La3eFYyKzwCLq1swPb+iZyOfyqWG++DYL8GMJ8n+6YOntX29/qoDdWjpaigYYfbxjYOyJMt8b62E2ohDt7g4lCsk6E+FPHL/2XZQ4yczcOa+ctaNy8WmQhvjIXaWw5PCjrc/e0O5UaSB1t/se8Qg44UJkTmvh7IG2HWKxYzNVw17pi9ZzXv07S0xiHdcbaEV2ylVXaEnndI2WA/dsNqLimd1Ne+72az7zlBBUJHVDXjqjP+ILzeXWigevdzbFRJFc/l2+MbzlK+2oxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYPyvEu90NlIh2yvUHJt4QZWAp3pa8kRPUGgLFjAGVg=;
 b=KbbUY9YNDQlf2MSm6iaPqlB0c11LLeni91bjUqHP1erqkYfxEBkcGpuCr1VvV1aZMVqvzGeLD7rseQyQVBLFFc/qn/nMh2bLPHzVPvreQaNqddwXXL+HLXT/PVha0poZ2MJE401VCkrqGMMZOcapjfg1IhdvvTuPTVFrIpLGqGY=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by SA1PR12MB8094.namprd12.prod.outlook.com (2603:10b6:806:336::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 08:17:49 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a5) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 08:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 08:17:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 01:17:47 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 01:17:47 -0700
Received: from [10.136.45.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 01:17:42 -0700
Message-ID: <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
Date: Thu, 25 Sep 2025 13:47:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
To: Aaron Lu <ziqianlu@bytedance.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
 <20250910095044.278-2-ziqianlu@bytedance.com>
 <58a587d694f33c2ea487c700b0d046fa@codethink.co.uk>
 <20250924113354.GA120@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250924113354.GA120@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfc40a8-b913-4257-bc23-08ddfc0c036a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UE1GWFNwV0tYZVVZb013T0NwMFlaU2ppbVBCZlNOb1FPZWJjV1BhMmJKTzFU?=
 =?utf-8?B?YWFBYk5ZMEprckg5MUE4allOUU1xYUhUTVFERjh4TXd1Y3hsRXdFM2Ezc2dn?=
 =?utf-8?B?NUJoRmpvUy90b1ZnWTRaRWh2Q3dpRU43TWNQcXMzVVZwd3p2Zzg0ZEt5MGFB?=
 =?utf-8?B?LzJaTHBnRFVMTXl6V2cwWEhoRk1oUVVJNm1VRWp5UXZyZkkwQ1hHQlBPWlhS?=
 =?utf-8?B?L3NsdmNYQUhMekhzNFFtdkUyTms1bi9EZGZzck83Sk1NTWJjN2hRVUZHWUVx?=
 =?utf-8?B?WXRCa3hiWUVVM1hMSkFRRE1CbmJTeFJwT3BwNVdRU1hqK0R3b3YxOHRaaWdx?=
 =?utf-8?B?dUtpN0MxS20yWXVjd3JYSUhPNkNzbDRTWHp6N24vT1FHSU5ZYW1RcTVFRXdS?=
 =?utf-8?B?OVl6WThCdVZOMGs2OU41dHVTK0NIelhxL2ROZzJMUnpZbFlqS2hOeWZHUTE0?=
 =?utf-8?B?Z0lMbS8vSFVBUVNoWStZZVBLS1JkcjdTTDlwaHBLTWlnMVFIM0lDd3luN3lY?=
 =?utf-8?B?S1ZBeDdqNVhwWnNuY0lGSnFpNU5hVHRFRXFqVU1oTDJMeWlQNFVRcUZZZjlM?=
 =?utf-8?B?NkY4Ylkza2dpbjRkNldISnpmVUJYMHRwTWpoWGE4UldBTzBrYSt2OFZJYkFo?=
 =?utf-8?B?SzR5aXlQd20rc0lKS2ZWanVyazE2NGJ4eWU2NSt1Z3N0UlNuTzJPVUc4b05P?=
 =?utf-8?B?cFZvQUd6aWVXeUoyV2l2enlxWDBodUptN3ozQ3Uwc1ZNOUxEcmxNYWNjTHZU?=
 =?utf-8?B?VHdVWnZDTk9NT0RBeVNUNkl5RFg3LzBrVXZiTVNKQkxqdFd1Zzg2aVR4US83?=
 =?utf-8?B?clIzcVpsUVE3VERxMUwvNFk4WW1FL0k0MC9MQ1UvNFM1VlhrRSt4VkpKbkVj?=
 =?utf-8?B?bHdtWm50L1EwaDQzemc3Q3BLaHZ6UDVFS2xieVgzZlM3bzNmRW5JM2ZJQ0cr?=
 =?utf-8?B?SXBCVjQwMjRJUnFlYzZRdXZ5Q1hWbjErZnU2ZWtvbG1iTzBLWkRVQ2IwbDBv?=
 =?utf-8?B?a3VWZEJHZUNvQ0FhVDZ2Ujh4bDgxTlhqemozVDJwMTlmT0J6Ymkvd21xamJB?=
 =?utf-8?B?NmpxeEFZdEpuazJ3K3Q2WHNxRTFtaXdhVXh5QnlSRC9nZnRtMENzbUNKVFVU?=
 =?utf-8?B?Mlhpa0RVaVRyKzRWUjkwVzBsc2Yvd3hScStOblp6WjNPT3Q2VXFLcCt1QmhB?=
 =?utf-8?B?K1BBQWdoZC9mMmh2TlJvcnFSamE1RmhxM2hzT1cxRkFNclFTekpYaXhzOWF2?=
 =?utf-8?B?MzlEbHduakZ2RG9vMUg3VWRTcGlQajhmYWUrSnozaytyb1ZvRWIyT1pnSlJs?=
 =?utf-8?B?Z1ErUy95RHJXcm82RHgrUEVKYlMralVubWlxYTVSVmZrYURSc25IVUFCQm00?=
 =?utf-8?B?MjNDSVpYMlpjQVRQVEg0elU4UjcvWFFOc3ZzVkc3c1hJYzQ3SWxQUXAwU3oy?=
 =?utf-8?B?M0p6TmxRZ2JvUHMrU3BaS2xPQ1VFS2lkQk00UnNzUWdkT3EyUjhZSWEyaHVW?=
 =?utf-8?B?QzRPUjRaU25QRTNHUVNUK3U3TDZnUkM0c1NjSllnZ2kyNXdsT3Y4M2FsMGxX?=
 =?utf-8?B?aW4yNWx6MEJlcGJhTzBCNm5lWUM5MDRCSi81ZFZPRkdsbS9OaC84VnVyOVEv?=
 =?utf-8?B?RDNFdlhPYVFRU0ZYRVhnYStCM3Z1Z1JZS1lZUFNJUUEyWnBuWjM3OUJEZkJr?=
 =?utf-8?B?Q2ZKZHFGU21xazZQT091c0g1aFY2SjNKMTNEeUNnYzBhRUhxYzkyTmYva0hX?=
 =?utf-8?B?Mkt3MzduczcxUTVhbXZTSUZCdnVKTUIzeDgzS09TMVphQ3dHV3gyWWcvZGQw?=
 =?utf-8?B?SG1rLzBleFEzN2FxTSt6QTJQTG1mcmZWOXpyYmYzenBqLzRtNlI1VlJTSSt0?=
 =?utf-8?B?T29RTHVaWkhIQVdPVU1SbmZNQy9IRUR2T1c5L1JUTlR5TnBEcE5QOW1RYXpi?=
 =?utf-8?B?MXM2Q01NZlNMcHFXcFJwZnpKdGJiWUJIN0V0NXBoT0hoYW96U3hEZXUzYlBH?=
 =?utf-8?B?ZHZVQUVCYjF4ZE1uSWg4WHd0TXJ3OW10Y0thbzJvWGhZQ254Qi8vZ2JwM3lE?=
 =?utf-8?Q?CXbK4b?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:17:48.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfc40a8-b913-4257-bc23-08ddfc0c036a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8094

Hello Aaron, Matteo,

On 9/24/2025 5:03 PM, Aaron Lu wrote:
>> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
> 
> I stared at the code and haven't been able to figure out when
> enqueue_task_fair() would end up with a broken leaf cfs_rq list.

Yeah neither could I. I tried running with PREEMPT_RT too and still
couldn't trigger it :(

But I'm wondering if all we are missing is:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f993de30e146..5f9e7b4df391 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
 
 	cfs_rq->throttle_count = pcfs_rq->throttle_count;
 	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
+	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
 }
 
 /* conditionally throttle active cfs_rq's from put_prev_entity() */
---

This is the only way we can currently have a break in
cfs_rq_pelt_clock_throttled() hierarchy.

> 
> No matter what the culprit commit did, enqueue_task_fair() should always
> get all the non-queued cfs_rqs on the list in a bottom up way. It should
> either add the whole hierarchy to rq's leaf cfs_rq list, or stop at one
> of the ancestor cfs_rqs which is already on the list. Either way, the
> list should not be broken.
> 
>> [   18.421355] Modules linked in: efivarfs
>> [   18.421360] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc4-00010-gfe8d238e646e #2 PREEMPT_{RT,(full)}
>> [   18.421362] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
>> [   18.421364] RIP: 0010:enqueue_task_fair+0x925/0x980
>> [   18.421366] Code: b5 48 01 00 00 49 89 95 48 01 00 00 49 89 bd 50 01 00 00 48 89 37 48 89 b0 70 0a 00 00 48 89 90 78 0a 00 00 e9 49 fa ff ff 90 <0f> 0b 90 e9 1c f9 ff ff 90 0f 0b 90 e9 59 fa ff ff 48 8b b0 88 0a
>> [   18.421367] RSP: 0018:ffff9c7c8001fa20 EFLAGS: 00010087
>> [   18.421369] RAX: ffff9358fdc29da8 RBX: 0000000000000003 RCX: ffff9358fdc29340
>> [   18.421370] RDX: ffff935881a89000 RSI: 0000000000000000 RDI: 0000000000000003
>> [   18.421371] RBP: ffff9358fdc293c0 R08: 0000000000000000 R09: 00000000b808a33f
>> [   18.421371] R10: 0000000000200b20 R11: 0000000011659969 R12: 0000000000000001
>> [   18.421372] R13: ffff93588214fe00 R14: 0000000000000000 R15: 0000000000200b20
>> [   18.421375] FS:  00007fb07deddd80(0000) GS:ffff935945f6d000(0000) knlGS:0000000000000000
>> [   18.421376] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   18.421377] CR2: 00005571bafe12a0 CR3: 00000000024e6000 CR4: 00000000000006f0
>> [   18.421377] Call Trace:
>> [   18.421383]  <TASK>
>> [   18.421387]  enqueue_task+0x31/0x70
>> [   18.421389]  ttwu_do_activate+0x73/0x220
>> [   18.421391]  try_to_wake_up+0x2b1/0x7a0
>> [   18.421393]  ? kmem_cache_alloc_node_noprof+0x7f/0x210
>> [   18.421396]  ep_autoremove_wake_function+0x12/0x40
>> [   18.421400]  __wake_up_common+0x72/0xa0
>> [   18.421402]  __wake_up_sync+0x38/0x50
>> [   18.421404]  ep_poll_callback+0xd2/0x240
>> [   18.421406]  __wake_up_common+0x72/0xa0
>> [   18.421407]  __wake_up_sync_key+0x3f/0x60
>> [   18.421409]  sock_def_readable+0x42/0xc0
>> [   18.421414]  unix_dgram_sendmsg+0x48f/0x840
>> [   18.421420]  ____sys_sendmsg+0x31c/0x350
>> [   18.421423]  ___sys_sendmsg+0x99/0xe0
>> [   18.421425]  __sys_sendmsg+0x8a/0xf0
>> [   18.421429]  do_syscall_64+0xa4/0x260
>> [   18.421434]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> [   18.421438] RIP: 0033:0x7fb07e8d4d94
>> [   18.421439] Code: 15 91 10 0d 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d d5 92 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
>> [   18.421440] RSP: 002b:00007ffff30e4d08 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
>> [   18.421442] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb07e8d4d94
>> [   18.421442] RDX: 0000000000004000 RSI: 00007ffff30e4e80 RDI: 0000000000000031
>> [   18.421443] RBP: 00007ffff30e5ff0 R08: 00000000000000c0 R09: 0000000000000000
>> [   18.421443] R10: 00007fb07deddc08 R11: 0000000000000202 R12: 00007ffff30e6070
>> [   18.421444] R13: 00007ffff30e4f00 R14: 00007ffff30e4d10 R15: 000000000000000f
>> [   18.421445]  </TASK>
>> [   18.421446] ---[ end trace 0000000000000000 ]---
>>
>> [1]: https://lore-kernel.gnuweeb.org/lkml/20250829081120.806-1-ziqianlu@bytedance.com/
>> [2]: https://lore.kernel.org/lkml/d37fcac575ee94c3fe605e08e6297986@codethink.co.uk/
>>
>> I hope this is helpful. I'm happy to provide more information or run
>> additional tests if needed.
> 
> Yeah, definitely helpful, thanks.
> 
> While looking at this commit, I'm thinking maybe we shouldn't use
> cfs_rq_pelt_clock_throttled() to decide if cfs_rq should be added
> to rq's leaf list. The reason is, for a cfs_rq that is in throttled
> hierarchy, it can be removed from that leaf list when it has no entities
> left in dequeue_entity(). So even when it's on the list now doesn't
> mean it will still be on the list at unthrottle time.
> 
> Considering that the purpose is to have cfs_rq and its ancestors to be
> added to the list in case this cfs_rq may have some removed load that
> needs to be decayed later as described in commit 0258bdfaff5b("sched/fair: 
> Fix unfairness caused by missing load decay"), I'm thinking maybe we
> should deal with cfs_rqs differently according to whether it is in
> throttled hierarchy or not:
> - for cfs_rqs not in throttled hierarchy, add it and its ancestors to
>   the list so that the removed load can be decayed;
> - for cfs_rqs in throttled hierarchy, check on unthrottle time whether
>   it has any removed load that needs to be decayed.
>   The case in my mind is: an blocked task @p gets attached to a throttled
>   cfs_rq by attaching a pid to a cgroup. Assume the cfs_rq was empty, had
>   no tasks throttled or queued underneath it. Then @p is migrated to
>   another cpu before being queued on it, so this cfs_rq now has some
>   removed load on it. On unthrottle, this cfs_rq is considered fully
>   decayed and isn't added to leaf cfs_rq list. Then we have a problem.
> 
> With the above said, I'm thinking the below diff. No idea if this can
> fix Matteo's problem though, it's just something I think can fix the
> issue I described above, if I understand things correctly...
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f993de30e1466..444f0eb2df71d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4062,6 +4062,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
>  	if (child_cfs_rq_on_list(cfs_rq))
>  		return false;
>  
> +	if (cfs_rq->removed.nr)
> +		return false;

If load_avg_is_decayed(), then having removed load makes no difference
right? We are not adding any weight to the tg and the sum/avg cannot go
negative so we are essentially removing nothing.

And, update_load_avg() would propagate the removed load anyways so does
this make a difference?

> +
>  	return true;
>  }
>  
> @@ -13167,7 +13170,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
>  	 * that removed load decayed or it can cause faireness problem.
>  	 */
> -	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +	if (!throttled_hierarchy(cfs_rq))
>  		list_add_leaf_cfs_rq(cfs_rq);
>  
>  	/* Start to propagate at parent */
> @@ -13178,7 +13181,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  
> -		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +		if (!throttled_hierarchy(cfs_rq))
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}
>  }

-- 
Thanks and Regards,
Prateek


