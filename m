Return-Path: <linux-kernel+bounces-798290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E892FB41BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD3344E4B67
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C5B2DECC5;
	Wed,  3 Sep 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FazSIooY"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3238FA3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895478; cv=fail; b=TVUiDwCObbdtzShtvwhz398FPXPZr0fc9QEWben2IkRjZs03Bo0ITrK5iPO3jRrSKwo4WQfXRjLdsgFSKgIPgDdCJ61HtkSdcYO53slzDTgiYrKQH5CjfHAI3jC7jjvrx3qtvmy7oPbo6H9InUdsUR5/ezAQy2673gO0zMDziew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895478; c=relaxed/simple;
	bh=FciU0HQPARth2+sNK9Ll3jIfl3nousWcUOWcBE2yeqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h8XWrTg4XQo/6C7ODS2Qu8MNtq/pj38tVFolayQNsi7rgSWaRPDE1LqhJe+EqPmT48u8hZaqOjoFUSotGoJas37ujuvzSw3NiOyOOFQ/Y+Xc7GecwURiKOH5/xbscDpbXO5qwsem+YB385JPgLIO0OAb1q/7Xsih8e7wd1Rj3RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FazSIooY; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6R+SX6nokXDyO3WpOHnwkW9xSAB7+T7Byh3rUE+2wbVIzouZb0aoKnintWgJBL4njHLqbMXdv8MIhZT/EK8e4cbx97dYteWtelgOYMbqKZIUcdUICF0XLDR5VfPxE8cGR3f/NieYqwyIb2kKqeiamca74dkUdfXjfX0HY9vddWMp6tj2IeJiV9vcih6f97xtblgLwIJGtdoDPvhxH3TZNnTS8PPx3QTDRIMo5h3Dj56PFvDtOfor2F0U4UgSPmh8LCqqBez/Y3QQXwR1T1r+2aetrNwYyvCuyVI5RBWfrQ8/EFdq2oXlChI3jdrrVIl0tFqbtpdK6iybTNprlIhMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYFgfZalzK+QPCoHwYpbQ75wZS6t8hSpmPJnE94ssJc=;
 b=zI8Y+Jzo5N45VR1qUjBh0R+Vc7vP1JoExoRpyfmWoQtAgUtY4LVKMCoXx0/0jIYzKZHktwYT+RNrFsCeF04/VsPjHi+XyYIv3opWjzajt0j6raWVjk+97LWLmLB/rwaLxPk40q3E40jMHiKupjErv5y8SJhTtrACs4xun6hygsAAgYBte89fRkd+fJUo2CzeekC63rf3kRT8VK617OXiara9uXWE1jCi4yoiKM1A97yjHEizI9IuwuKqHFubRWfxW+rkPEfLIkoSydMFck6/hQyCA1A/WQXp0oAjnYCZp17HXmd4toLO8x4nuXfTh5xIrBtVHP3pfAmy1jHAuVcFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYFgfZalzK+QPCoHwYpbQ75wZS6t8hSpmPJnE94ssJc=;
 b=FazSIooYnTy5n989MxmXQhzfNjufXFE++XIsAXvQp/xXfd5sE4bBNZUvmbMq/QIXGBXmhWqRIj4NRsAMVlyFWSKT0f+hRenMlpScm0ejXl7Ow1OyMD2TdcWzwMk97Zncdn2bSJ7MeRXKNy3vgzVl5PFIrMeMXAv8/tFrLNn+t7k=
Received: from DS7PR03CA0336.namprd03.prod.outlook.com (2603:10b6:8:55::20) by
 DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Wed, 3 Sep 2025 10:31:13 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::9f) by DS7PR03CA0336.outlook.office365.com
 (2603:10b6:8:55::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 10:31:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 10:31:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 05:31:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 03:31:09 -0700
Received: from [10.136.37.163] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Sep 2025 05:31:04 -0500
Message-ID: <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>
Date: Wed, 3 Sep 2025 16:01:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Chengming Zhou
	<chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance> <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
 <20250903101102.GB42@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250903101102.GB42@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ea15f9-8f1e-45d9-fe80-08ddead50169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3Z0ODloVCs3T1ZpenY0L2tWbjc2T2NQQ0pTZmJrZ0tKT1B1Zk41akt5Tlpl?=
 =?utf-8?B?eGdZdmZWNGVEY0QxY1BTOTFKQndtSERycFdEZnliYVc1YS9zMDI0ditJd0g2?=
 =?utf-8?B?ZTFkQW1ma0hYcnRmQ05JdHVwYlZmYWRYMXFxK05xU0t6RUYzeU8yTjBZVHRG?=
 =?utf-8?B?cFZtdnVydHJlc3dTcEp3QmxsSWlXYXRPamVqUE9HUy9xYldDT1dDZ0ZuL3Zo?=
 =?utf-8?B?QjROaHMzdTV4ek5PcTcwY242MlVrZDFBWWRFMUh0VlkzUzhiS1d4bVVwUzJr?=
 =?utf-8?B?N0RWOGRReTlTOEtOWE1xL2d2OUhvRE54TzBWNnh0N1MyRTM0ek1HQTdHd21J?=
 =?utf-8?B?N0JNamNEamlPS2tvMDhScGZYaUV0ZG01Ni9ldm54a0g0aVpXU1NrdXc1MUNN?=
 =?utf-8?B?ZmdtZm9VaHFheVNOZVBlOWd6ZCtKVXhjS29xM0tIL2ZhMzNUVU5sYngvSFQ0?=
 =?utf-8?B?ajVHd3VHeURPU1JmWFVPd2Q4Q1hacUE5WjA0R0MyT1B4a2p5Z1hkVitKZTE5?=
 =?utf-8?B?MzJORFdNRDNZVlVUTVJxekhHaG5jeTlHbUUzNnIyOXJNNVJxaXZPWGRDamFs?=
 =?utf-8?B?Ulo1V21KTnVrQmVLY1hpd0RXQjk3MDdZZDkwZW1kS3BMOGhhR2lKdjZLajJ0?=
 =?utf-8?B?NkJYTnhhL1I2Ujczak55UHgrcC9vdmgxT0dnUzY2YmdSNlBGK05ySThNbExR?=
 =?utf-8?B?YzBPSXVYd1VOazZXVXlCWTdOVUk0UlNhSWpXeVJnbG9wcWJjZnFJQnRZbkc2?=
 =?utf-8?B?Tis1QUdIR2ZLY1c4U08rYWQ4MUVUOEdEa1JUL1VZeGF5dHU4NXBzZ1dtbWVR?=
 =?utf-8?B?V2lSZmFQQ3hOM3lTc1Ayd3lhalFzOHpsd1hHQk0wNEVUTXZvNGk5NDZ0aUw3?=
 =?utf-8?B?RTZ5enRKWU9Ka2dtY0xITXhrZDkveTVQcUJiTGRWRCsyd3RlQ082MEhac21X?=
 =?utf-8?B?a1ROSGJpQjZjU1VRbndua2lpWXdTQXcydnZESDhFVVhKVWZmRGRObTY2MkRY?=
 =?utf-8?B?UG11dmt2Z1YwMzllWHpMeUFwa0F6NEpKZUdQQXhkWkFvVENhdXBicGtRQ2tv?=
 =?utf-8?B?ZWg3N1VOVzFVTXgzb05QVkUySFEvWUthQU5lSTZkaDdVWm1uYkZxbzhQSmpS?=
 =?utf-8?B?cUloN1c4WFZUUEQzWExLUXQ1emJKaHpJTjZuN3J6dUxNM3EzeVVMV1BYc3Q3?=
 =?utf-8?B?SXVBUFJ3QUlBaXJITmxJQllmMTZHcE1zN3UyaU5IRE1HeEd1TUNNWEpsZHFs?=
 =?utf-8?B?dFNpVTFZQW5vZi9JOUlMNzBOaVZXU3hoZCtJY0RSZ1Jnd0pSSWVwd2ZsR29I?=
 =?utf-8?B?R1VLQnFNdFBOdU5VUDRlVzB5eENJOTgwQldNcGpIcnpwNjdSUVdjejNQSFcy?=
 =?utf-8?B?WFdCbmJycHJLNHgxbHBrWVdKUFcreHJrUEpkRFBvVFphYzNqWjcrcVZiSm5m?=
 =?utf-8?B?VHVIeExlMkx3cVdkRkxBZFFHUUs3Zm04WU5HaUtmY1ZzL2pzcmNnRSs3Y1M1?=
 =?utf-8?B?bUVIRGsrbS9oRlhVZlNUc09FSVNxakdLREt0Qy9mMVRDYkVBTXpqVkk5U1Jp?=
 =?utf-8?B?YmU2RE5nT2lhVjVBNHVhWXozQkFFWmh2ditjZElBQTJ6L3FMZHphaGd0TlAy?=
 =?utf-8?B?SHRia1F0Y0JRdXJKVDRwSEY1NU5weUN4VnYzY1NZaWRSR2dJVHdEUjVYUzA2?=
 =?utf-8?B?NFErMlRpd1ZPbXh6YldxTkI4T1p0eWFmZnJoY29NMGhaQVJLUTlKQVNYZENZ?=
 =?utf-8?B?QXpPZkg0cnlYeFZvaHFHZUxoN2VxMmxTQjV5T0xjc1FpSkFXVUlEUGlmWkRZ?=
 =?utf-8?B?N1ZMdm5lRERJRHRwOWtaTTJHaURZdy9hb0o1ZitSZlZSeDhOVStZNG9ta3dJ?=
 =?utf-8?B?VVg3bENUTWxKOVEvei9WaW9DcnNONTkrOGNDc0ViR2ZMWWJIRytQSHRiN3NG?=
 =?utf-8?B?cGtUaGYzcXF6cjJPd2RQVFJvenZ6UVdXaHFhb0FBZDNFczVXMVBFY3dtaU9v?=
 =?utf-8?B?TUptOVlEdjhrZXMzT0JlMzJlVXk1OENNaUVDdWRRcXZ4V042WkdHOUxLZkR1?=
 =?utf-8?Q?0ZlRUN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 10:31:12.8321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ea15f9-8f1e-45d9-fe80-08ddead50169
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

Hello Aaron,

On 9/3/2025 3:41 PM, Aaron Lu wrote:
> Hi Prateek,
> 
> On Wed, Sep 03, 2025 at 02:41:55PM +0530, K Prateek Nayak wrote:
>> Hello Aaron,
>>
>> On 9/3/2025 12:44 PM, Aaron Lu wrote:
>>> On Fri, Aug 22, 2025 at 07:07:01PM +0800, Aaron Lu wrote:
>>>> With this said, I reduced the task number and retested on this 2nd AMD
>>>> Genoa:
>>>> - quota set to 50 cpu for each level1 cgroup;
>>
>> What exactly is the quota and period when you say 50cpu?
> 
> period is the default 100000 and quota is set to 5000000.

Thank you! I'll do some tests on my end as well.

[..snip..]
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index df8dc389af8e1..3e927b9b7eeb6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9370,6 +9370,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
>  		return 0;
>  
> +	if (throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
> +		return 0;
> +

This makes sense instead of the full throttled_lb_pair(). You'll still
need to put it behind CONFIG_CGROUP_SCHED (or better yet
CONFIG_CFS_BANDWIDTH) since task_group() can return NULL if GROUP_SCHED
is not enabled.

>  	/*
>  	 * We want to prioritize the migration of eligible tasks.
>  	 * For ineligible tasks we soft-limit them and only allow
> 
>          base              head'               diff     head(patch1-5)
> Time     82.55±4.82%       83.81±2.89%         -1.5%    99.69±6.71%
> 
> head': head + above diff
> 
> I also tested netperf on this AMD system as well as hackbench and
> netperf on Intel EMR, no obvious performance difference observed
> after applying the above diff, i.e. base and head' performance is
> roughly the same.
> 
> Does the above diff make sense? One thing I'm slightly concerned is,
> there may be one case when balancing a task to a throttled target
> cfs_rq makes sense: if the task holds some kernel resource and is
> running inside kernel, even its target cfs_rq is throttled, we still
> want this task to go there and finish its job in kernel mode sooner,
> this could help other resource waiters. But, this may not be a big deal

I think it is still an improvement over per-cfs_rq throttling from a
tail latency perspective.

> and in most of the time, balancing a task to a throttled cfs_rq doesn't
> look like a meaningful thing to do.Ack.

-- 
Thanks and Regards,
Prateek


