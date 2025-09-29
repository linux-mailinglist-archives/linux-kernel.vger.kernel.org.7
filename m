Return-Path: <linux-kernel+bounces-836068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854D4BA8A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A6018938CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A77288510;
	Mon, 29 Sep 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fdrtopG4"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62F1714B7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759138459; cv=fail; b=p6pNr3QxISZn/nFpIwumX8FRwkJ/F/6cByWFrFP/g3s3SYxp4aL2GtOLPgu9/jmWsv2Wxg9y+D6dHNd4LIEkrxvDnDkDf+5pcyG2K9CRq2NbIToDMpnkXSYe2bzMbTQfv5lejN157ha9fteI27hQR39G9KOw/O0zuV1H8908LKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759138459; c=relaxed/simple;
	bh=zyId53XsfVtQVGzB5eFWUef4dgeIeyg+2T+XG1N7gKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lruyP3U2hbZrsLFuNChQ1DLJLWGEieCrcDhBmJd1aGQN9CHP6vV8kU/LEmRrVuxq+etGli4L4dhhLeXs649poNGmqRLzTt1LrGyEfmlLA+DC+M3IBIZTUIrbDDrS+h0E8M2JfCU1F0tReS6DzsN95XE60E7b0JPJYDCpLiz+zxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fdrtopG4; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvyYV3H0OOKq0tTObxQ345ZLbxX73NKmArRxW9Cnb4x2pVzxQxjR/mi4u2jkZoJsbkabJf+uTTJ3IOgxV0LilSS8KHRw1WuY0MsG7l4cX/86SSTuixvC080XT3Qf4dITJgiW2ILNA1LxRTDAwXNFRjL3kpMurEhub4kleDC87zAjTMEh4oyIhpS9NU5SfcZzy8nFjlLJWF8/3v6J2q+Qku+TUnwwJmaV95hxPAp9iDdNRH4SnYfaJ5Uv65upuSuWDANvZgikEF7d9gueFMOezz32GGP4UiTgFSXswh/3SqGnoCwpjBzABwvGNVOUbLWOBq6hR0QP+nLOR+qIQXCtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Djt2wBM+nA0bI0bn1CJbMYGbTPM2sKZztVZRzvAFk=;
 b=bsv686nUbzyiHyjmmVKkY6mXgdvIIf/lUoWoc30kX9em6bfarUJJZDl/EMrA0QSHwpkM6LCgFevi9BczB/JcBoOIbpzSYbbTp6vUQqJRgm8FSR8j9vu4xuFfhYKQNTqigx7eciKeb/vytIS6KZ2UFLj7GPMF6BG2UglBhMUC/CWtlrijluRGN2DCLgn68A8xZ2pcQtuu4LmsVC3i+kLEJTkwQoz3YCXyGC2yWO83Bw23DX9J7pzO+3dJeiH8swjSe0nYZcX6Jj0jZMUpR0Rn12kdcRAYwSLQ/v1crpH4iHcQX/KDzIc5Q0u2hWwmO147LhUtA3olzXGszkHOngJbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4Djt2wBM+nA0bI0bn1CJbMYGbTPM2sKZztVZRzvAFk=;
 b=fdrtopG42GdGMj77WC7UJ0SNFtnwiSnkP0mEkB4fo46Bvx3XKNEHtW+t5RZjiwDZz1WpM5e64P2feFZySU9VwlL6PQXTIgCJGW9kYoJNgFdHUE2RrZta0BBVDmxOlMAd3Wmvvah3UGynZ5fKRPA+uh706/ywlr0dwSRHYCypvLU=
Received: from DM6PR17CA0034.namprd17.prod.outlook.com (2603:10b6:5:1b3::47)
 by BL1PR12MB5826.namprd12.prod.outlook.com (2603:10b6:208:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 09:34:13 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::94) by DM6PR17CA0034.outlook.office365.com
 (2603:10b6:5:1b3::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 09:34:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 09:34:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 29 Sep
 2025 02:34:11 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Sep
 2025 04:34:11 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 02:34:04 -0700
Message-ID: <7c93d622-49fe-4e99-8142-aed69d48aa8a@amd.com>
Date: Mon, 29 Sep 2025 15:04:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
	<mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250929074645.416-1-ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BL1PR12MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c10655-89dd-48fc-cc3e-08ddff3b599f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1FDb1FRUE5iaTgvUlJhN01kQWd6SVZHMzdWaVFBNGVnZmkySHpOL3NYRkpl?=
 =?utf-8?B?YWFPVEJVS3o0MytEYTl6SDFrMktURlZlYTRSd0RkanJRNXlwcldhZy9TQ29J?=
 =?utf-8?B?SFNKWDZJRWthSEZkcGFJVG9UUHM2M1FENDhteDBDVXhoVU5lNmhySjFOTEVa?=
 =?utf-8?B?Mkc1STljY29MQ0NidzlqYkpMKzRieDBqUGdreDJtd1dTZUpQMnRJVVk4UlhT?=
 =?utf-8?B?UjNSOUVqMm5BMGl2V3A3Yy9SZ1lxbVZ2UUxIOXQxcVl0aCtDZFBWMXVOMlpj?=
 =?utf-8?B?eVl0N1EydnQ2N3dzZXMvSXNzU2NUa3h5TTB6WDBHOERUV3kvczE4Tk9ULzBy?=
 =?utf-8?B?VFdNbllaRThHREZUZzdoNkdqWUlrbFdENDNOYWZKY0VRZTRaMTRENGlhZklv?=
 =?utf-8?B?dlhTdXhTQ244UXAzQ244Nmc1VTRjRWljSytwaC9jelRWSjV6UmpKS3J3THpG?=
 =?utf-8?B?RGkrZ1BBZDJGdENkWU1pZG5nMjVmQVVMTUN0dFlLSnNQdDJQdXdOMmR0aGhp?=
 =?utf-8?B?K012ZE5FY2lXdmkvMUM0MERqU0ZRRFRIbjhBOXVWQzJqN3VUQ2x6TTJMYU5v?=
 =?utf-8?B?ejBFeWtGSzRDdkkxTkVYWGtFNzVHRUNPSkhDQ3QwbnMyK21ORUErRHZTYWEx?=
 =?utf-8?B?bDRYREhIbk5WRUk3Z2IwYXFBbld6ZXVwamcvalRQU0pMak1ReGZicWJIUUF5?=
 =?utf-8?B?QlV0MTdOeU5LaGdkTXp0UkRhTFIrQXpYSEF4eThKSTlONm5lam9mU2ZHa3Zn?=
 =?utf-8?B?UUF0ZWRKbSt3QlR3Q2dXeUcySXRaRGpDVGdYNnRuNk54eHY1UzJPOEhCVHk3?=
 =?utf-8?B?VWF1bElnUEhuVWpDekRpRTlhUVJSbDIrNFRrZHQwa25IUDRJQm5CR0M2VWM1?=
 =?utf-8?B?akY1THR3dlU5R1pNeTdvdzJjbXJUV2JZQnk0UnZVNkdkaE80Y2pRL0ZyWkg3?=
 =?utf-8?B?bnYyb2RUUmRlMVBHb1MrNlJBTk9sVjNmaUJTZ2Y0eEh4cXZTV1ZRWW1NUU5Q?=
 =?utf-8?B?cGJLTGZRWWJBSkRUbEYrdXl1SUQvOGFwN040SU1ZQmlWczFTMENVSHc0MXFL?=
 =?utf-8?B?UVdiUW45N1VSUHRkYjlLVjNMT2R6MDdOemliUkxiWjdYbkZvTTc3aVo0V1V2?=
 =?utf-8?B?SUlVSjFLTVNNdTRBZWx1L2I3eisxcGlPakFYbFNnNEZ1TWR2ZW1KNlg0aTY2?=
 =?utf-8?B?RjZIYjZJdTlNTXY1ZEo2dHpYWlFrZWU5eW5kU09tNC9TNXVHS2FYUjB6M25W?=
 =?utf-8?B?MHE3cTZveW9yQ3NNQWc2Mkg0bWFLRk9YZVpkUElZRFh2RkJLcXRONnRsSHBD?=
 =?utf-8?B?alZ5UjhYV3VtektKZ2UzQmo5M0ZaZEdvdUxST2Zidy9vcXgzaENBTUlBMlhV?=
 =?utf-8?B?SjdhTlZYalJsV1lHcFZVd3ZRVVhCWHIydzVMNlVCbUp0alJEWnZXY01ibEhG?=
 =?utf-8?B?SG1UVVdubU11cXpCV3JMTlkrMU4rKzlFOEcrVG1IK2lXVTAvTmZiN1FmZmhS?=
 =?utf-8?B?WXRpWXBMdmE4Wm85bE12ajZndG0vY0dLUHpBcGNIMEFjWUhEa2lQWjVOQUFW?=
 =?utf-8?B?SGFmeUdSbHVSM0ZNdUhxWXJ4aUlwSCtZZG9nVWVXQ25nWWpwWkxtWWlRTWdM?=
 =?utf-8?B?Y0tTWlV6TDlhU2gxN3pYd3EvdjUweG9MVTNZVTE1QzJxTHlMMlZZa0xLYWwr?=
 =?utf-8?B?cmRmSEl1aThna1ZkZzhISmYyQUlHYWFFUTR1OFViOTVrL0ZuRXhmUnRsREVp?=
 =?utf-8?B?Vm1VQ2xVV2ZCVzZnRlNManJrRjlaRDZ6YXg1UTBNUStuSVZOS3FnRWR6aDIw?=
 =?utf-8?B?RFVuc3J4UmZYMmEwRzhNcW5kaDNPUTFHZHB2ZFpPQUdqT1JrNDgrTzF3RDRO?=
 =?utf-8?B?Q09lejFWMDJPYXZZamQxTWpHejlCVmI2TnlqZ0FCZHpYOGJhY2xzbTRZdTdB?=
 =?utf-8?B?WUJVbUxFN2tidGp3RkcrWlk3MGRUc2k2RWpnWU1oOTNZZ2tzZEFSdkk5ZVpV?=
 =?utf-8?B?ZlIrc25IOHFqZXE4R0VEN3N2V0paVFFoSWl4OVd5dmg1OURhdGRLdGNjcWpm?=
 =?utf-8?B?UlJMM0RRN1hkY0F0SlptRHdveEFucUZFSzZqNUZKYjhrMFJORDJneTBockR6?=
 =?utf-8?Q?mzec=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:34:12.7007
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c10655-89dd-48fc-cc3e-08ddff3b599f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5826

Hello Aaron,

On 9/29/2025 1:16 PM, Aaron Lu wrote:
> When a cfs_rq is to be throttled, its limbo list should be empty and
> that's why there is a warn in tg_throttle_down() for non empty
> cfs_rq->throttled_limbo_list.
> 
> When running a test with the following hierarchy:
> 
>           root
>         /      \
>         A*     ...
>      /  |  \   ...
>         B
>        /  \
>       C*
> 
> where both A and C have quota settings, that warn on non empty limbo list
> is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> part of the cfs_rq for the sake of simpler representation).
> 
> Debugging showed it happened like this:
> Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
> cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
> equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
> *multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
> group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
> called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
> these throttled tasks are placed into cfs_rq_c's limbo list by
> enqueue_throttled_task().
> 
> Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
> tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
> runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
> can't get more runtime and enters tg_throttle_down(), where the warning
> is hit due to remaining tasks in the limbo list.
> 
> Fix this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth()
> immediately after enabling bandwidth and setting runtime_remaining = 0.
> This ensures cfs_rq_c is throttled upfront and cannot enter the enqueue
> path in an unthrottled state with no runtime.
> 
> Also, update outdated comments in tg_throttle_down() since
> unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
> 
> While at it, remove a redundant assignment to se in tg_throttle_down().
> 
> Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
>  kernel/sched/core.c  |  9 ++++++++-
>  kernel/sched/fair.c  | 16 +++++++---------
>  kernel/sched/sched.h |  1 +
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7f1e5cb94c536..421166d431fa7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9608,7 +9608,14 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
>  		cfs_rq->runtime_enabled = runtime_enabled;
>  		cfs_rq->runtime_remaining = 0;
>  
> -		if (cfs_rq->throttled)
> +		/*
> +		 * Throttle cfs_rq now or it can be unthrottled with zero
> +		 * runtime_remaining and gets throttled on its unthrottle path.
> +		 */
> +		if (cfs_rq->runtime_enabled && !cfs_rq->throttled)
> +			throttle_cfs_rq(cfs_rq);

So one downside of this is throttle_cfs_rq() here can assign bandwidth
to an empty cfs_rq and a genuine enqueue later on another CPU might not
find bandwidth thus delaying its execution.

Can we instead do a check_enqueue_throttle() in enqueue_throttled_task()
if we find cfs_rq->throttled_limbo_list to be empty?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18a30ae35441..fd2d4dad9c27 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5872,6 +5872,8 @@ static bool enqueue_throttled_task(struct task_struct *p)
 	 */
 	if (throttled_hierarchy(cfs_rq) &&
 	    !task_current_donor(rq_of(cfs_rq), p)) {
+		if (list_empty(&cfs_rq->throttled_limbo_list))
+			check_enqueue_throttle(cfs_rq);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		return true;
 	}
---

> +
> +		if (!cfs_rq->runtime_enabled && cfs_rq->throttled)
>  			unthrottle_cfs_rq(cfs_rq);
>  	}
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 22e6dd3af82fc..3ef11783369d7 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5976,7 +5976,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>  	return 0;
>  }
>  
> -static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
> +bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
>  {
>  	struct rq *rq = rq_of(cfs_rq);
>  	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
> @@ -6025,19 +6025,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  
>  	/*
>  	 * It's possible we are called with !runtime_remaining due to things
> -	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
> -	 * unthrottled us with a positive runtime_remaining but other still
> -	 * running entities consumed those runtime before we reached here.
> +	 * like async unthrottled us with a positive runtime_remaining but
> +	 * other still running entities consumed those runtime before we
> +	 * reached here.
>  	 *
> -	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
> -	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
> -	 * throttle, which is not supposed to happen on unthrottle path.
> +	 * We can't unthrottle this cfs_rq without any runtime remaining
> +	 * because any enqueue in tg_unthrottle_up() will immediately trigger
> +	 * a throttle, which is not supposed to happen on unthrottle path.
>  	 */
>  	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
>  		return;
>  
> -	se = cfs_rq->tg->se[cpu_of(rq)];
> -

Ack on these bits!

>  	cfs_rq->throttled = 0;
>  
>  	update_rq_clock(rq);
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b5367c514c143..359bb858cffd3 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -558,6 +558,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
>  
>  extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
>  extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
> +extern bool throttle_cfs_rq(struct cfs_rq *cfs_rq);
>  extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
>  extern bool cfs_task_bw_constrained(struct task_struct *p);
>  

-- 
Thanks and Regards,
Prateek


