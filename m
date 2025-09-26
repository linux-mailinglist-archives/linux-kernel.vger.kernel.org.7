Return-Path: <linux-kernel+bounces-833600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB0CBA2629
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 06:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA907B8BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 04:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8674D26FA5B;
	Fri, 26 Sep 2025 04:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZcSl03mY"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307D288A2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758861196; cv=fail; b=IqP73NvRrI+/xDtwSwFFXZ3akrSlJkxCpffuIfjnXyH4NyZ3P4PgNB3Hh2LFaiW7iSB/VUeP4ITO2Q5JFq1nUASgnUix+KCt2lJgLG9EZ+o+3qjnNxJPHKTbEo2j6bb7sP4CcqhWl+9eO7Lnj+vrnbIMlHPGigP/EI6Gml2rRtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758861196; c=relaxed/simple;
	bh=9LeAqeFDOwywbSUmkZk/GDghe1nd7nCP2C8828JMmGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S1Iruxfm/r5jFZ5CYAl4S1rkMMS34rMOPl31/i/Ros080bjo65S7Xn6xD2lgV7+szLrBIaeG8ac9qcKLUXvFJQIoGddLXssStjJvsQGp14lGPIfNPj/VC4CvgXAKSVI/b7wbymmCy20LxSKUh3RjK2zkqFwMFlBV+bkLALz7geA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZcSl03mY; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=utCsf6w1tkZ0q/B2vdHLTrj0pWx7bacshEDS6lJV8t3Q/51Juqt+uHvWq87nP9nrLSSZlNCExJyczzUAmtMEU0DWf8ve2hb1PuDhMzU1lbq/09zo3SD6G0vJJnM61SG2n3/bIx06y4M2l54jYft65IRWB94Z8n/EKY3Yz60vJVmuruXkmrX00hM0zyPVRIDgo6ru5rJjE06uUVwZNSoykKVbs1U6XpRIz4iS5PiITRq9bYumERe4xjQXHYLIzTrGVHaQAZxItn2o2GDHakpLQQv8MSHqnNqLHQIflxGnRnTBqnPH2OsXhoRf5h+4S3mvUryMVHyDaIChSo41cQW4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzWcm5PBnm6B4HoSiE9y9T31OL3VeNo252LAlG9/tqM=;
 b=OR7Nzn5hPBu+k6qxpHz5G9Qt+i8UknWjCF+0Zs9KMkbyWNcMCd7FRe9yB+VQFGFEbbLPoWwbrW1GgGtKqYif9srS1TyaNNOkF8rJnPRufXJ5NkPdo8gtQfgerwo69I3KwtpGJGkZ7lQRy+OFKKa2vTN7bqPFUU9Ee7Fel3YKb0OgjnZgx1KHFIPWGMUdR19NkGFsfHkpEpgvLkrbG52xpR+RUubcitv5guM3sTWo2FizJ3DKU7xkROz8gBi3Y0/7u3nUJ6UUAh7AcRjvydTdrW8bQoahw8J2Z3IGXAuB4j9FZjbFc/6FUZJeoANCjd0Jzludd1dj5Vxwcgb2w7V8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=codethink.co.uk smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzWcm5PBnm6B4HoSiE9y9T31OL3VeNo252LAlG9/tqM=;
 b=ZcSl03mYyzTsfRcVYfg+vV3pcMECMVDv0QTMi+joePSywdlFwMjoslvYtINOKVZAHirwRevjumKKeKP7nKT6rEhJ3vJ0SUQihwHWA5CAIUR3tLoSLrMISTICTj+/goA64JmrTmW0QcMXyg13/YyxGcvAOeWgYNuJRoApwerAgJg=
Received: from DS0PR17CA0002.namprd17.prod.outlook.com (2603:10b6:8:191::25)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Fri, 26 Sep
 2025 04:33:09 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::73) by DS0PR17CA0002.outlook.office365.com
 (2603:10b6:8:191::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.11 via Frontend Transport; Fri,
 26 Sep 2025 04:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 04:33:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 25 Sep
 2025 21:33:05 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Sep
 2025 23:33:05 -0500
Received: from [10.136.45.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 21:32:59 -0700
Message-ID: <fb530c13-9ff6-46bd-b9fd-6e9a8ddd66c1@amd.com>
Date: Fri, 26 Sep 2025 10:02:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
To: Matteo Martelli <matteo.martelli@codethink.co.uk>, Aaron Lu
	<ziqianlu@bytedance.com>
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
 <db7fc090-5c12-450b-87a4-bcf06e10ef68@amd.com>
 <20250925092938.GB120@bytedance>
 <72706108-f1c3-4719-a65c-c7c5d76f9b1e@amd.com>
 <20250925120504.GC120@bytedance>
 <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: b776ea93-9fc1-4841-ee21-08ddfcb5caf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3VwdFVhR2JnL1BaUWdQZHgzV2JORXVLMERGSW9RMlFQOXZacGxJQzdvUW9X?=
 =?utf-8?B?VWt5R2ZZNENRd05ib2VSWkpIWUZJbFRtL01PZFhRWEJmSnRlWWg5STlCS3BY?=
 =?utf-8?B?a2RWS05zWEhTRGpiVlZWQ3Z3c0liREUvUTlQTTZwTTdTejE5bTNMUlNTcmFE?=
 =?utf-8?B?ZCs5aWxuY2ZqVC9rb0gzRjB0eUlrWDJLYjFBUE40SEd4TmErRkwvcHBLVXVM?=
 =?utf-8?B?cC9oKzJRSm16NVNCbW5CL3pWOGdqN3p0ZlhXNU9LaTl3RzJKZUJwOWUxOWVV?=
 =?utf-8?B?TzF6UUJVMHB5QTNBTDE0dWdEYTlPRFBrK0w2V0VNODltMlRkcHJOZXU2Zkph?=
 =?utf-8?B?Wjd6V2pIdVdYWlBXQXhLNHVGQktpQTBpTGNVWmRoNFUxQi9jUWlpM3puYWlK?=
 =?utf-8?B?bGZCSXYxUTNYUkZjMGJmZXRldWtuQk84ck5lR2lCYlRuZm1aam00ZUdHRHVG?=
 =?utf-8?B?Yzl2enMvQzhMNURkKzdkdlA2aGtlQnpmRzZrOFpzWHFqOFQvcXFBbWR3dUZ3?=
 =?utf-8?B?UUVpYzB0aVhTeFVxNmhmU3FVRUxFQ1FjYkZROTlFTUg1eXFoL1l2YTRTREls?=
 =?utf-8?B?T2JDOHFGakphL3RGd1h5bk9FTEM3UUo1ZjY3SUU3Y29ZRVN4b3gwQm9VdEc4?=
 =?utf-8?B?QUU5T1V1c2JibHB6YXNucVJZODF1eVpNbmhsL2pLdmd2VVlJZmJDVFArVExr?=
 =?utf-8?B?RmY5SlFOL2o0MFp3RVVpVk54amliUk03NFozNGl0djZENm45N1Y2VzhGajhw?=
 =?utf-8?B?WFk2bmRZalgwcENCbjBtUERBZjNaZ1hCanVTOTBhZXlDVE00aWFBRGJqWXhY?=
 =?utf-8?B?STJ5akZ0QzJ5QndjSFhacEdYZ2RWWTZ2RW9UeHljVUNVWGFpTEU3YS9DUnVs?=
 =?utf-8?B?ZS9CQWJXODRRMFNCdWtVV0RiS0tIUWpySmVsWnZnUUl6T1RrZWN3VnhvTWc1?=
 =?utf-8?B?alo0dFZBblB0TnhETVVZd1VwQUFheUU0R2lqa0x6Y0FoeU4xa1NVWmF5NzUz?=
 =?utf-8?B?Ym1LSkZNdTZmcnZVZm1MYnd6dEJwb0JoSnVpanRCcVZKMXhJWEpLM3EzZkxh?=
 =?utf-8?B?Z24xSlpXdW0rVVZodkkzMHFRSS9sbUtvNXhieGllVkJZVTVZNGhFR0xKODMz?=
 =?utf-8?B?Y204eXoyNVNRNkdtQks4MFBXUEZQRHZzQzI0ZEd4dEdYSjhaaVhyc2w4MGll?=
 =?utf-8?B?dkdma3RPSEV5Y1ZUYlJPR2J1enU0MXFvR0JzSnFKSjRqVWRHKzRyM1JtUDhR?=
 =?utf-8?B?RU0zakZIejBFKzJTcU1oamE2WDVqOVEyMnJtbmh2UTE4MTdYMkwveFVHT0cv?=
 =?utf-8?B?UWl2bDFUMHdBQmhmTXVEdVdsNHEvT045WlVpc2ZmQ1pIcXNFV3NIelVWVnha?=
 =?utf-8?B?SjFKR1YxWVVLSEJueXpMVzkzdmM0UGxtWDJiRlI3V293MHlBRnRyZE5qeElB?=
 =?utf-8?B?eFNCL0NMQ2NJdldQM1hELzZYZXdFMU9HcnByZGQyY3lmUUJaK1FDWHhEeE5K?=
 =?utf-8?B?ejlhMEp3Y2NHRlpqRXlWMWM5bnJWTHByU1IwYlZNMDBnYmw1R09RMmpQK09o?=
 =?utf-8?B?RGFpR0VjeFphMXE0VHBIaG9KczI2bE5BUVFmWVNHVk8rcy9Rais2UzFUampP?=
 =?utf-8?B?bm1jeG5wdGgramZKTDRDRk1rSlhLd05paHIyVnk3TFppM0JtOTFhcTZOTE1y?=
 =?utf-8?B?SnU4VGpqL3F1aHkxKzIrMTAxNHBzMWQ5T0tQeXgvL2dPQmZjelEwWjhwdFlP?=
 =?utf-8?B?NTgrV2lJejVHcTBXc1gxMUdqYzRjaXF3Z3BCc253T1NSN2xabGVaMUd2ZVh2?=
 =?utf-8?B?c2JWa2pYMDVJaW0rTDRuT2hzWk12R3dXYjh3d0ZzMGVoUVpzYUlRMk1uWHBE?=
 =?utf-8?B?TUtqWDdYSHZmT3VOV2J1RUJXSDNDNDhjZDZKa1plL3RReHhpemFRakdMV29m?=
 =?utf-8?B?cjVBSEZxL0NkenI1OHBzeGdQV0tRNjE3ckQzSUtmeUd5MUdzZDBnNi85K09O?=
 =?utf-8?B?WWZTSURDWDhPSmNIbjFzK2JLeXJFNU1IQUV2Rm9PZ204RkhuRXdrbVY1MUor?=
 =?utf-8?B?dDBnbzVPUy93U0p4T1NBUkRHZ0JReHBsZWl1WTkwMUtCS0doN3JTOFM3NEti?=
 =?utf-8?Q?zjYs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 04:33:08.0119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b776ea93-9fc1-4841-ee21-08ddfcb5caf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620

Hello Aaron, Matteo,

On 9/25/2025 7:03 PM, Matteo Martelli wrote:
> Hi Aaron,
> 
> On Thu, 25 Sep 2025 20:05:04 +0800, Aaron Lu <ziqianlu@bytedance.com> wrote:
>> On Thu, Sep 25, 2025 at 04:52:25PM +0530, K Prateek Nayak wrote:
>>>
>>> On 9/25/2025 2:59 PM, Aaron Lu wrote:
>>>> Hi Prateek,
>>>>
>>>> On Thu, Sep 25, 2025 at 01:47:35PM +0530, K Prateek Nayak wrote:
>>>>> Hello Aaron, Matteo,
>>>>>
>>>>> On 9/24/2025 5:03 PM, Aaron Lu wrote:
>>>>>>> ...
>>>>>>> The test setup is the same used in my previous testing for v3 [2], where
>>>>>>> the CFS throttling events are mostly triggered by the first ssh logins
>>>>>>> into the system as the systemd user slice is configured with CPUQuota of
>>>>>>> 25%. Also note that the same systemd user slice is configured with CPU
>>>>>>
>>>>>> I tried to replicate this setup, below is my setup using a 4 cpu VM
>>>>>> and rt kernel at commit fe8d238e646e("sched/fair: Propagate load for
>>>>>> throttled cfs_rq"):
>>>>>> # pwd
>>>>>> /sys/fs/cgroup/user.slice
>>>>>> # cat cpu.max
>>>>>> 25000 100000
>>>>>> # cat cpuset.cpus
>>>>>> 0
>>>>>>
>>>>>> I then login using ssh as a normal user and I can see throttle happened
>>>>>> but couldn't hit this warning. Do you have to do something special to
>>>>>> trigger it?
> 
> It wasn't very reproducible in my setup either, but I found out that the
> warning was being triggered more often when I tried to ssh into the
> system just after boot, probably due to some additional load from
> processes spawned during the boot phase. Therefore I prepared a
> reproducer script that resemble my initial setup, plus a stress-ng
> worker in the background while connecting with ssh to the system. I also
> reduced the CPUQuota to 10% which seemed to increase the probability to
> trigger the warning. With this script I can reproduce the warning about
> once or twice every 10 ssh executions. See the script at the end of this
> email.

I have a similar setup with a bunch hackbench instances going in cgroups
with bandwidth limits set and I keep creating/removing cgroups on this
hierarchy and keeping moving some tasks between them.

> 
>>>>>>> [   18.421350] WARNING: CPU: 0 PID: 1 at kernel/sched/fair.c:400 enqueue_task_fair+0x925/0x980
>>>>>>
>>>>>> I stared at the code and haven't been able to figure out when
>>>>>> enqueue_task_fair() would end up with a broken leaf cfs_rq list.
>>>>>>
> 
>>>>>
>>>>> Yeah neither could I. I tried running with PREEMPT_RT too and still
>>>>> couldn't trigger it :(
>>>>>
>>>>> But I'm wondering if all we are missing is:
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index f993de30e146..5f9e7b4df391 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -6435,6 +6435,7 @@ static void sync_throttle(struct task_group *tg, int cpu)
>>>>>  
>>>>>  	cfs_rq->throttle_count = pcfs_rq->throttle_count;
>>>>>  	cfs_rq->throttled_clock_pelt = rq_clock_pelt(cpu_rq(cpu));
>>>>> +	cfs_rq->pelt_clock_throttled = pcfs_rq->pelt_clock_throttled;
>>>>>  }
>>>>>  
>>>>>  /* conditionally throttle active cfs_rq's from put_prev_entity() */
>>>>> ---
>>>>>
>>>>> This is the only way we can currently have a break in
>>>>> cfs_rq_pelt_clock_throttled() hierarchy.
>>>>>
>> ...
>>
>> Hi Matteo,
>>
>> Can you test the above diff Prateek sent in his last email? Thanks.
>>
> 
> I have just tested with the same script below the diff sent by Prateek
> in [1] (also quoted above) that changes sync_throttle(), and I couldn't
> reproduce the warning.

Thank you both for testing the diff and providing the setup! I'll post a
formal patch soon on the thread.

-- 
Thanks and Regards,
Prateek


