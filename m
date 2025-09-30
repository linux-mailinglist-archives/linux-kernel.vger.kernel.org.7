Return-Path: <linux-kernel+bounces-837743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D3BAD166
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72F01642DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010E238C1A;
	Tue, 30 Sep 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yXQIbxMZ"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911104D8CE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239514; cv=fail; b=IR3WMV1KzrZAVHeM6y7iNJJAzcieFumNscVGBci2sLXHzzS7l4DLxrwUHhK/6pEMMEpENQplGrD8OhU89qGb7RQu0oPhHSUe73FwnW4SeHPEtJM+RhodJA46KNLZUwrPCKxkc5UQATfbJ5P6I0eK5Uti+qrVWKI/F0ku8s4aVfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239514; c=relaxed/simple;
	bh=dB5674iqUuZCZMxwRjKTFi7Xc30L6b1P5jMnV0MJhIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKJKPNe1GAxYrgN0jJSGD0AZnJFOZ4X/88fF0M5kUyGX+GCw/HvTwZ/Ukyu7b8CubIPV3h8/KyJv+AiijrCort0E9RBZtfEV9rDtaJ3WapfHGIiO8h/uAFpI4Fde0qeod/BAYPqX2WcBeRYZ+HSS91RCW504pfp3AIF8o9Yt/rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yXQIbxMZ; arc=fail smtp.client-ip=52.101.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rt9m84YQI9Y6eNWyZ3TSR4DAsjdQcVSbgVSoWLOPxfIU2TIeWKwSVNdTr3ERSXiG6O1mbacakVoMHTM1Bjas6TrUokdEsxIZR7MM83sBpXZfxSTeRCZcacaeJlYvL1bcx+XrfVyCwt9CylspmRz+Z/xhwAqn4ipnco0Strcl66AL3guK/mUHQj4Qe+mcGHz0Hj0W8NiIrGMIhrHVQuTe20LPkR5Yy016CB7YbrS3oXzrlLPfjyV5PBAL1jUibd+283h+GshH5fZeeKlX37Fl9a1bXbcjJmzDabXpx97SNJhu8MQ6AUmCxNGW6GauEa0XEPt64rR4IUpKvtCUqCZ8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/BHgS3w2xTWPAL5ly35SF61bDMEdMNcRocZOswgmr4=;
 b=f2eOuXJzh66pWBVLykiLWx3uMxkFjLCFNsh2uY+Q12bfgVDj+AMsSyNgYwj2r1eeurmlu8SRfJw9z87XxumMqEuH3o25h/Fk9295rqVUMuDviumBMVIhUUIjji0xr6LY/8ybFIfGZUZbIB1ncV2UJSCebNdoMIBA0Uxs9CMZAb5X9Qm4InMsHJe6RDa1Sme4+B6Oe5rbWo9ODf5vk3xOnggZn6qJ8Q2lfwuTkTdUtGM8Z8yyd4Dm9lCBly6HXsfUqj+QBqtzYlBs4e6AlB8xi8JquKpoYc73mwDRqqqj/IpH5KNC5NDOKzWlohi+dQjjAz2+w9SnSlzsadXUYaM/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/BHgS3w2xTWPAL5ly35SF61bDMEdMNcRocZOswgmr4=;
 b=yXQIbxMZiPm+CXMzV6w5LqstVla2Gubtg65lq8vigk9guBzqOZok1WK3NnWCPyj27iex5zmZ1GtoZ5fT/VvO22wBWicm4cdd+cG3W38p2XFRqXYMVZFeaZor7og1yYJPmXFnR5/fOcco+Rv/MR7J5QFkpNa5Mp/tdrEbxBgqL7g=
Received: from CH0PR03CA0442.namprd03.prod.outlook.com (2603:10b6:610:10e::32)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 30 Sep
 2025 13:38:29 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::56) by CH0PR03CA0442.outlook.office365.com
 (2603:10b6:610:10e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 13:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 13:38:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 06:38:28 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 06:38:28 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 30 Sep 2025 06:38:21 -0700
Message-ID: <dc328049-b1e6-4558-bb9b-e2e1d186daeb@amd.com>
Date: Tue, 30 Sep 2025 19:08:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
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
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
 <20250930075602.GA510@bytedance>
 <658734b1-b02b-4e04-8479-ed17eb42c1f2@amd.com>
 <20250930110717.GC510@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250930110717.GC510@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: ade695db-f5c5-4e6e-c50b-08de0026a394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yjk5RXRIVWlwV3o0RGM2SjFZMk1TVUZBQnBNakVJeUJiSFBMdnh4cG1DOWtF?=
 =?utf-8?B?bHhqVk9KOUM3WTd2RzRhSTJnLzRiWXpkRlU2OURoNEt3dFlEWGJNN0haYkpL?=
 =?utf-8?B?Zzg4RGxBRnkxL2pRdTFPcUNyMnJ0UTQ5bHhDMmVZcXQ5Z2xVTUdYTDJXRFls?=
 =?utf-8?B?RUhPd1h5SFpXaWFSN3NSUzY1ckxlc2tpQUtoVWp5TVg5MVU3ODdvSE9zYjR4?=
 =?utf-8?B?WDMvenNPZUVjMDVzbHZDU1JVNlUzVHdkYW5ZcnJUSUh0UVQ0RWRtanlVZ0RW?=
 =?utf-8?B?T1pNSGcyTHEzR0o1WUg2MXdCeEx5eE1mcjNYMnBDbUVRWEEzSXlNcFNQRm9k?=
 =?utf-8?B?Nmt3bTBWeE9PdnZVZ3RLTGdDRmhGWUQybk9QdWJ5R1htTFN0NkVDNW9xTDdr?=
 =?utf-8?B?aFNZNEU3ZXVEdmJ2aWRmSzYzeHdIekl3V05EdUVTUmpzWDF0dC8zSitHalRj?=
 =?utf-8?B?RXpZMXgwSE9WcXd1ZlpsTzN4NXlObXhtWEphNWJiUlZrZDlzcE9DOTNWSGEr?=
 =?utf-8?B?WFIzNUJuVm9wOWZyRVJXSGZqVy91aDkwUXlld1NPem5mbGpDYzdjR2RmTXdR?=
 =?utf-8?B?Tms4WFJIUElVVmxSa1JIZzB3UVBBVnRSNEhpNkZFcWVtbUZPaDZDQU1veWY4?=
 =?utf-8?B?NEVXS1E0NElzb3Q4TTMyQmxQdGo5b1lpYUREdHRBZzhLS1BBaUwxNExqdG1x?=
 =?utf-8?B?YjhnaUdwTnI1Y2lOZGJBVzlld2pMS0NrNDZSZG02L2Z1RTMwc01XVkRGb2FV?=
 =?utf-8?B?UElyM1lIckJvT0YwMldpb0RwUVlralA0K0ZNWllaYWQzRXRXcXUxUkxCRmFw?=
 =?utf-8?B?a1NYSGtRKzRxQWFPTlJmU0tvbG1qM0VtdnNySlVRSjhMOUpReDBKdjVDK0FY?=
 =?utf-8?B?UmhvY2Fva1lkdFNHcnIzTTBkZGJzMG1oZDRSVzZtV1lNNU1FcHdmUWVsVnkr?=
 =?utf-8?B?VEk5VkJRRTkyb2M0NEZ5OFNSVTJKOHh6SHIyaDVTMkpidnN5VWtqNUtpUVRL?=
 =?utf-8?B?aTVMa3V4RXY3TjJ5MTNEVkd4VnVEelljaWN6dytpSWd3ZnlISHF0UE1qaWlp?=
 =?utf-8?B?TldwZXlYL25aZEh4WHdGeC9QUHozZ0htdXVNeURobVFuWkxKbzRrQ2tsZG9U?=
 =?utf-8?B?ZkFrekxjR2VmVGY0ZlY1YUczdTRVVFZyNlh6Ky9tK21iZnpBSWdTb1BlREJp?=
 =?utf-8?B?MUt1b0JKenIrMjZZOU95MUZMK1d4aTYzc2tBYVdLRDhFTXdOYm5wQUJQNkNk?=
 =?utf-8?B?dkY2VmtPOFBXWWlmMVBiYSs0MEJaV2gyOEZ2VmhRSGRPNDJ5T085amphZGUy?=
 =?utf-8?B?Zk1XcDZyM01HQkVleVVubm1Zci9CYjBsbjlyek9hUEVxT2JlWXBGemRUNnFX?=
 =?utf-8?B?T2dNVFRxMEZ2ZDNmY0pwNTRuK3ZYdVY2cWRCanpaZmlXa2VlN2MrQ1J6dTFo?=
 =?utf-8?B?WFV3TDRONjNxeUNmTVhzQmhrVWNoMEdnNXFxTEh4aUFJQ0RoRVVIYVZjSERY?=
 =?utf-8?B?T1lSVG91YzNvZ3RLVmZBckJYZHBpNzFMdFV5NEIwSGpuUU15di9WZjByUWNB?=
 =?utf-8?B?aThzQmJYLzluUFZQQnhGOE1sbkpGS3BHNktwRHUwaFY1MEdOaHNiTWRMRlE3?=
 =?utf-8?B?NW5aSXBSUHBnVE44UVlsR0dqQm1xbmpxWkhrRGtvcUN4YitRUDNSQ3F5akhl?=
 =?utf-8?B?TDA0WlhEa043cWF3Z3lLdzBtL1NrQ2Z1c2M1WDNHOUY4Ti82NXhoUWdTZ1RM?=
 =?utf-8?B?bjNLU3ltTVBKbWluUWN6L3YzMU95ZjlnT2l1TTltUjNCZkZ3eUZQbFRCemR3?=
 =?utf-8?B?TXZVQ3MyTjJWaUZSQVQvTGs4cnF5RkV3WmM4WHNyWlBKYVE4eFM0ckM2RjFE?=
 =?utf-8?B?WjFvbnIvSW9oSkd5MmtCN093d0V1eSsrL21hK1cvaytTRWQ0VFRZTE14Tm9W?=
 =?utf-8?B?eE9CeEF5RXdaaExzeWc4cHFuMnZwczErSFF3aWp2RHFkUFlOaU1jL0tkOExh?=
 =?utf-8?B?cHVWSDZQcmlHeit4U2RST05kVHpoSDMxQ2ZMWE4rSEYyOVBVWFZ5bC9MYzZl?=
 =?utf-8?B?Ri9IZHpsUCs1dERCOFl3VWJuYmZ0elFEOXlaMHJGaDNSREtSSkdnMWR4SUdU?=
 =?utf-8?Q?Ja+o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 13:38:28.5651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade695db-f5c5-4e6e-c50b-08de0026a394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

Hello Aaron,

I'll merge the two replies in one.

On 9/30/2025 4:37 PM, Aaron Lu wrote:
> So in my original patch, cfs_rqs will (most likely) start with
> runtime_remaining == 1 and unthrottled after calling throttle_cfs_rq(),
> which will also start the B/W timer. The timer is not needed in this
> case when no cfs_rqs are actually throttled but it doesn't hurt. Looks
> like everything is OK, we do not need to do any special handling in
> enqueue_throttled_task(). Thoughts?

Now that I look at throttle_cfs_rq() properly, we'll only move the
runtime_remaining from 0 to 1 so few usecs worth of bandwidth
distributed at max should be okay. Sorry for the being overly cautious!

So your current approach should be good. Please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

As for the other thread:

On 9/30/2025 6:09 PM, Aaron Lu wrote:
>>>
>>>     root -> A (throttled) -> B -> C
>>>
>>> Consider B has runtime_remaining = 0, and subsequently a throttled task
>>> is queued onto C. Ideally, we should start the B/W timer for B at that
>>> point but we bail out after queuing it on C. Thoughts?
>>
>> Yes agree the B/W timer should also be considered.
> 
> On another thought, do we really need care about B/W timer for B?
> 
> I mean, when C is unthrottled and gets enqueued on B,
> check_enqueue_throttle() will do the right thing for B so I don't
> think we need to do this hierarchy check_enqueue_throttle() here.

So what I though would happen here is that when A is unthrottled,
you'll enqueue the task and only then realize B doesn't have any
bandwidth and start the timer then but had you identified it
earlier, distribution could have already added some bandwidth to
B and then you could run the task without adding any further
latency.

-- 
Thanks and Regards,
Prateek


