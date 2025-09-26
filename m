Return-Path: <linux-kernel+bounces-833893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F2BBA34D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16E862601A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204F02D979A;
	Fri, 26 Sep 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m2NyuqGo"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96B279359
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881493; cv=fail; b=IEKw4yJ5lC9PEZo0YmN0ZqfT+whfq1Ao1GjeNN6G9MIy+TROl/OatF+4limPP3BOeoVxkHMotihnUWJQu0/oV1bWLUC1JeddJiixAaxnfs/DWr9TUPIkFpfk5b6mNKrkaFQkWtWwLoZHh19Ke/AN2TdlbBOoqW5tuzJRwErVi3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881493; c=relaxed/simple;
	bh=SgdbQm0zNFhaczMdqWcECvHQBl0SQ0dcgEarVfHHIUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sk/eNVTWCj2mcNXqESv9/lz3rBD2QFAVGdFTdmh9C8O4hwscdTa5BTxRUM5I53uu6bdQDhPuF5k9m53R1xqZ4ND13dNY3mQ1HroEVkEovyNzOLaw5xhKXeok0ThPk7e7l92fphxaPuDMKen8GUcB5c5ppec9x6D64+vyXvVkBeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m2NyuqGo; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tftxPLMsED2+eOWMEml1hrn/pfJyktDWVqeROL9KG2k4IR24sPzJpMdZMHXoUe5rHeB6XT63dVejDyOELS8S07WPt2Zjm70+mcVdzORczNCCbWF8Mh1g7W9nit41wOSWBXxMPveDG6Nmyt0M+Sy9H/Y0Lpmp8rKa/z7ZqQA2djwzFkdOO7jxcg/LRSkc4kFJPCZoK2wAeMtzxkBg8X5CrYe5JinJBuEU2ZRWP1qCzhGmFRjijQ0FbnnELzLaCbTpxuESNUSAngINU4mDgPU1zvF4NhroUGikdsWQ/S1BFSyV7YLtPh50XnS9v/xnGGWkLcdLPVCK+evk0lCcz7pyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APzIA5eKAZ73Zvv3Yut9O/dV2m1Phm07oBGRXP7GfBY=;
 b=oapEzS08s730rTbLno6K09dQMVD4mozErBFK9I6kHFsRFzPRvIy+BpSqdr+qWkdPCRN9T4gJLWRnsTObmeIwFTJ2tzJsHhfTbIZDfjg8oe2alF+0lG1IBA+/7o8ScZkgNRkej49dBYjP3rCOvKqccJ2QaHTgvL/WpFOxvsuGGEs0aduLx64IOfNhb9dK301YEY+WG6RpW6BycgTlWFcLUwb62zl5sHVP+yZU/gR++SNtfB0x9ij6a8bZX/NcXsnb96743VaE9Xy3SQZPX6m73vYw7OSNbtx2qiXvHfXMlAPxnHHsZOAIR8D/cPwnRKl3Iew2L/3YciZ/+riOv8+JZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APzIA5eKAZ73Zvv3Yut9O/dV2m1Phm07oBGRXP7GfBY=;
 b=m2NyuqGoyDhgIIj8UBjTVn1zniCtSuw51+OEYwpUEZ9FtHVIRgxI0L9uIjp18+NwhotHs0UAXAJJa7k/7fY/Lfg2sLUU1zm3+Lg74NP1PQAVfzAovHR0vawiNzPZfqLikRr6bOJ2QUVxV1m4EXCgoBrMmRSHWb8qFezrRFG5pzo=
Received: from BL0PR02CA0096.namprd02.prod.outlook.com (2603:10b6:208:51::37)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 10:11:28 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::47) by BL0PR02CA0096.outlook.office365.com
 (2603:10b6:208:51::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 10:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 10:11:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 03:11:26 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 26 Sep
 2025 03:11:26 -0700
Received: from [10.136.45.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 26 Sep 2025 03:11:22 -0700
Message-ID: <5b947108-9cc0-4b33-abb2-482825756911@amd.com>
Date: Fri, 26 Sep 2025 15:41:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Start a cfs_rq on throttled hierarchy with
 PELT clock throttled
To: Aaron Lu <ziqianlu@bytedance.com>, Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, <linux-kernel@vger.kernel.org>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>
References: <e2e558b863c929c5019264b2ddefd4c0@codethink.co.uk>
 <20250926081918.30488-1-kprateek.nayak@amd.com>
 <20250926093801.GE120@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250926093801.GE120@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 232f0bc9-c836-451e-d6a9-08ddfce50e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS8rS0NqWFF6Ykx6UjVqZ1laTnVrVnhvVXZZUStIaDFtZ0JjSEEybVl5TWlP?=
 =?utf-8?B?SjU5VEZ1MCtiOS9FdHNNY1hvYnNEeFJPZ3dIUmQweHZzSHpPSkd3UlYxRDBQ?=
 =?utf-8?B?TjV4TktGK0Voc25IK3lBaEdUOW5rRVhwZkRpeXNtODV0R2syWUxGdzllMVFa?=
 =?utf-8?B?YndicWZ6WEIwbUlSZkwrUDNraXpoL0Q3ZVpsSE9KOU03TW5rSHp4T3pwOW5n?=
 =?utf-8?B?S2hQRGFsaGoyS1pQeXhPQzl6NDd1OEFyeVBKN0VkaTZLRXpJNTgwdVpTR2hH?=
 =?utf-8?B?VUxDVnA0akQ3YnZuUTA0NHU0UjkxUUZZMHlha2dDVUpKQ2xUU0prcmVMQ2du?=
 =?utf-8?B?TVZQOFg0dDZLdjdmcmd0c211V0prck5BazdWTkVFR0xIWVY0UENuSFhEc1hD?=
 =?utf-8?B?alJFa2p1QWw3azF4MCtOdEpGdTF5SVVsTjVjOEdKVVpvT0lFWW94LzdVV2tW?=
 =?utf-8?B?cVdDMW9qWGw2RTFkMG85dTZlTThDVmR4MVRiN0tHZVpYYmtqMW43VTUxS085?=
 =?utf-8?B?MnhqMVNFVWFhMHBMejV6c2hLWXBvY2lldGxzNUJGbS9HQzN3NTJxMHNnRTBP?=
 =?utf-8?B?bVdtOXk4SHpzWDRtV1lueUdEMzZYVm9obkVVemdvY2ZMRnFDS1dTeWYvSWZZ?=
 =?utf-8?B?bDFmOUljRXhHVDBicUdxRDJMUHpoNHFDcmtGQ3dpZkdpNXJmTHUwbDlibDBi?=
 =?utf-8?B?SGxYSUtXUXZ2S0FsbVN2bFk5UUZkOVBjYlplemQwMXUvUXQ1OXlUVmRKQWUx?=
 =?utf-8?B?eUxJQ1RybC93Y1o3ZjJqdnBxZVV2U3hOa043a1UzSEVEdUVlR1REQzFqYkdk?=
 =?utf-8?B?aVFJOXB0SVlZK2xTM0cvVVdwNXM0SW1vTHpiZWRpVi9pb3N1VW5sTk85NTFp?=
 =?utf-8?B?MkRCN1JJZVZER2VGSGlqZGMrYy9OV2xTdjI5amp5TmVjdWFqdTdyMWtKY0dq?=
 =?utf-8?B?N0s3ek5aR0kyajd1RlF1bWE0Q3k1SGtmSHRaWjBBT1VmeU4reHZlNk8vaDJ2?=
 =?utf-8?B?Z05TWjlNUGthN2pHK0RRSXhqZHJwS0hUZklYdk1Jd1FSMlZmT05EUVV1R3Fh?=
 =?utf-8?B?SmlrTkJKcnZ3cER1NFZkbHVrZTlJZFYvRk9FZFd3NXlWcjlTR29jQzdOL3h2?=
 =?utf-8?B?blF4SnNVcTVEbGpTajJsMkpGUmszMlorTlcxVE1rNi9GMWdJcldlK0FPRlc3?=
 =?utf-8?B?Mk5IZDBVTy9TV2w4S0V0RVUwODBNQ0M4ZS9mZElITUpES2dYZjhQTHpKb2Rv?=
 =?utf-8?B?aFlCRjk4RjVwVEVDeXJSOS9KeUpmMTByOGNaYmRKK3ZueUxPY0o1WU1aQ0Ez?=
 =?utf-8?B?Z0l5ZEJzZmV4aSsxRDdvSG9scVFTdVhPeHJ1bCtidUJjWjBKYnN0TXVyVjd1?=
 =?utf-8?B?dFJYdDlvNkl5THNqT1Y4cTFpMGhpQTcwMVhiQnE0Z3NaN0JlZ0t0ZitaamFk?=
 =?utf-8?B?RGJkRmJlU052ajQweVVFVmYxS0ozbFhMZExxczNZNGp1TVg4Ykdxa1EwNTZ3?=
 =?utf-8?B?LzVud1dvN3pWZXllUGRKSDdJdWVNbFpiUkEwbTUvd1NkK1c0ajRXZ2s0OGdN?=
 =?utf-8?B?aTFiK2lZMTZ2OUl6eGZSWEdIa05hdTFPdzFtWFQ4K1luck16Q2NqSXcycXIr?=
 =?utf-8?B?cHJJUThLUUdXa3NqMExCdzBQbjRSY0Y0UDVxb2ZXd3BBYjd3MU1WN05NWlps?=
 =?utf-8?B?RUlxSVlsOGhFT0xqc1VHU1VYYWpNVHFRREdqSUxIQnR1a00yTFdYM0FaK1JY?=
 =?utf-8?B?Z0tpODdwcUxGcHdRT3FQamIwb0UwUWpsWFZsbTV6c1doZjJoMXU4S282eTFS?=
 =?utf-8?B?dGw5R0FkazF3ZnpmckxSVUtKVkRmL09RVVphU3VFNmI1TGdnbS9LVmNyUUla?=
 =?utf-8?B?eTdCN2tvNldKYlZuSXlFMEgvaHFUZUpTL0pENmNmckthbWNXcysrY2NQRnE4?=
 =?utf-8?B?cGVqVXJsTHdxQkVaUjNmZEtwRXF4L1lIRzArZ00xTURLMDlBZmRoS0VkWDFO?=
 =?utf-8?B?R1gvelpLcytBSnA4Nk9WN3FsemdrcE45bXhKZWJIR3B4d3BYTE9kQldCSVE3?=
 =?utf-8?Q?dEJLkX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 10:11:26.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232f0bc9-c836-451e-d6a9-08ddfce50e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798

(+Chengming for the discussion on the PELT bits)

Hello Aaron,

On 9/26/2025 3:08 PM, Aaron Lu wrote:
>> Syncing the "pelt_clock_throttled" indicator with parent cfs_rq is not
>> enough since the new cfs_rq is not yet enqueued on the hierarchy. A
>> dequeue on other subtree on the throttled hierarchy can freeze the PELT
>> clock for the parent hierarchy without setting the indicators for this
>> newly added cfs_rq which was never enqueued.
>>
> 
> Sigh...

I had the exact reaction when I managed to trigger that again (T_T)

> 
>> Since there are no tasks on the new hierarchy, start a cfs_rq on a
>> throttled hierarchy with its PELT clock throttled. The first enqueue, or
>> the distribution (whichever happens first) will unfreeze the PELT clock
>> and queue the cfs_rq on the leaf cfs_rq list.
>>
> 
> Makes sense.
> 
>> While at it, add an assert_list_leaf_cfs_rq() in
>> propagate_entity_cfs_rq() to catch such cases in the future.
>>
>> Suggested-by: Aaron Lu <ziqianlu@bytedance.com>
>> Reported-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
>> Closes: https://lore.kernel.org/lkml/58a587d694f33c2ea487c700b0d046fa@codethink.co.uk/
>> Fixes: eb962f251fbb ("sched/fair: Task based throttle time accounting")
> 
> Should be Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle
> model")? "Task based throttle time accounting" doesn't touch pelt bits.

True that the issue is seen after e1fad12dcb66 but I though this can be
considered as a fix for the initial introduction of indicator. I don't
have any strong feelings on this.

Peter, can you update the commit in the fixes tag if and when you pick
this?

> 
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Reviewed-by: Aaron Lu <ziqianlu@bytedance.com>
> Tested-by: Aaron Lu <ziqianlu@bytedance.com>
> 
> Thanks for the fix.

Thank you for helping with the debug and testing :)

> 
> BTW, I'm thinking in propagate_entity_cfs_rq(), we shouldn't check the
> ancestor cfs_rq's pelt clock throttled status but only the first level
> cfs_rq's, because the purpose is to have the first level cfs_rq to stay
> on the leaf list and all those list_add_leaf_cfs_rq() for its ancestors
> are just to make sure the list is fully connected. I mean something like
> this:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 75c615f5ed640..6a6d9200ab93c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -13170,6 +13170,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
>  static void propagate_entity_cfs_rq(struct sched_entity *se)
>  {
>  	struct cfs_rq *cfs_rq = cfs_rq_of(se);
> +	bool add = !cfs_rq_pelt_clock_throttled(cfs_rq);

I actually think what it is doing now is correct already. A part of the
hierarchy, between the root and the first throttled cfs_rq get the load
via propagate and this needs to be decayed, otherwise CPU might appear
busy.

Consider: root (decayed) -> A (decayed) -> B (*throttled)

If a heavy task is migrated to B, the load is propagated to B, A, and
then to root. If we don't queue the lhem on leaf_cfs_rq_list until
distribution, the root cfs_rq will appear to have some load and the load
balancer may get confused during find_busiest_group().

Now, if we place A, and root cfs_rq back on leaf_cfs_rq_list, each ILB
stats kick will decay the load and eventually the CPU will appear idle
and post unthrottle, the load will start accumulating again.

>  
>  	/*
>  	 * If a task gets attached to this cfs_rq and before being queued,
> @@ -13177,7 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
>  	 * that removed load decayed or it can cause faireness problem.
>  	 */
> -	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +	if (add)
>  		list_add_leaf_cfs_rq(cfs_rq);
>  
>  	/* Start to propagate at parent */
> @@ -13188,7 +13189,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
>  
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  
> -		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
> +		if (add)
>  			list_add_leaf_cfs_rq(cfs_rq);
>  	}
> 
> But this is a different thing and can be taken care of if necessary
> later. Current logic doesn't have a problem, it's just not as clear as
> the above diff to me.

Ack! Ben, Chengming have better idea of these bits and perhaps they can
shed some light on the intended purpose and what is the right thing to
do.

-- 
Thanks and Regards,
Prateek


