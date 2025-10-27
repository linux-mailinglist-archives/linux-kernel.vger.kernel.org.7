Return-Path: <linux-kernel+bounces-870832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D924C0BCC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA72189FAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FE222575;
	Mon, 27 Oct 2025 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G3y2G54z"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9D28682
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761541382; cv=fail; b=HlkBT3/P+Ch8XilYC0yZGBJkc07M05V6qfq705o+lmFlYBVqyKMqzkamyNODG+X+cxwGdJOEq+JJJo30u0GtA659XeZ5nTi7tlatqopleE/YuLiZFtQ6DQq9FawFgkPEQ2WSX2JYY460D5RCYInPtbWO8tYXfHpzjc3ny0biYS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761541382; c=relaxed/simple;
	bh=JOuAgSp0zB0ZQyGMNUiZl7PegYajEnqHjfJ3Gzr2Ee0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NdvUxStzeju62iy6zHnq2A0oZx4vbHUAMGBTzY7OV8zroFHT95wVIr36fhfKGoxLAKuok9ZholYpNwnJd+T8W8a87zzrozQFveaSFWQGMtdph1M0Kw8DdG3c5IFwtdwUxMWIQEreo2LRuXey/RnJvlkEqP0ES6BpWqyvDpFJ61o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G3y2G54z; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/rZhe5mDkH/AutpVokt85KuTNDE2jVzpFeNEnjfZgzd240a772GCnxokHSBiN9PWAepOnZcz5nJzBFhmUXocRnvTCpjAadSTOY5yaYj/VBBQ7fzTOOfLxg+z4R8LEo5+/X2W9+GlV8gklXE5JGpM+e6p/LCaDCcyzLKMv6buFX5QialssQnTwyi1J4MY7qC/mmz0p4CkJSFHeGKmPJ128xXgKA+Idc5gokfezH0mKud6vJTZsFrkdbVzhxiicCMz49wFEz2UdMPvMWWswdaL5gYDxkA74M4f3vZktsAK5pD+PT4AM9qD9MaYd12HYuy4t8ZmBy9JokkWjqlE/wdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SMFXHy6XpX12/GUHA7PapSzqC0b+G/2kGC0Erl1/9E=;
 b=zLLIqOe8qjZ98V9GbhXM/kXvKfLqATDdo9GbGBzK5P8UUstPNuEhWL/bSKTGTtpQRyv9F2nRSv9wsIK0ygB9K2hrom1+N3w5y/0SmIor4b+FYEVB/bg+s2DprHDzd0fFGCzuzNW6wYobI9WoknoG1dDiY4985Bg17jea+BGfz1rnO01KyborMBRcYWwktSYK/RE/5zMCnRGFMosHRLzC7YlltQzUsp+2nHNifBJD01MkboDVPtPC6OH1VWB7E76xNy1WBu9hbVeXa7h1uF19uo9QxGNaCBh+HrBqCx3I1spfh6MExbt5DFoEupnOKDWQ9tQBMtwagwEx3MD0vxrkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SMFXHy6XpX12/GUHA7PapSzqC0b+G/2kGC0Erl1/9E=;
 b=G3y2G54zyhEBhz38xk3DjWhWGWIkBmpzpM7RjI4xrMhTmJRM952egPIZpMI69vUKQX1gRKW9u6bQCttFsvPyU0kNlNDMGc9NY/MhtfrISGlvab2LNDGQrixqpR/9gda4Ocl6sFf9/jR30YaYfLGW74sjOPMJtNU5TxuoN1J0R6s=
Received: from BN0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:408:e7::25)
 by DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 05:02:57 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:e7:cafe::85) by BN0PR03CA0050.outlook.office365.com
 (2603:10b6:408:e7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Mon,
 27 Oct 2025 05:02:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Mon, 27 Oct 2025 05:02:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 22:02:11 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 22:02:10 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Oct 2025 22:02:04 -0700
Message-ID: <5f97134b-71b6-44fb-85fd-5cff6725cf9c@amd.com>
Date: Mon, 27 Oct 2025 10:31:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide
 cache-aware scheduling decisions
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Chen Yu <yu.c.chen@intel.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, "Valentin
 Schneider" <vschneid@redhat.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen
	<cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Libo Chen <libo.chen@oracle.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 3204580f-030b-42ae-ca40-08de151617ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|32650700017|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3pZRmpwZlVyYWlZdWw0bnIxVWxCNzc3RHR3N3plNXd0Znh4QjkzaDY2ZEFm?=
 =?utf-8?B?NUhteE0yVjVjMStYMk16WnlzRTk4U2J3dS9rb1V4STBEbU80dVdpRnJadmxI?=
 =?utf-8?B?ckY4UTdrQmlJcFI5bldtSjdGelAvSWI3OG8xMjdlZFU2UnhTVnVQeVhqZWNC?=
 =?utf-8?B?RFQ1YzFUeEtra2djenFHWjlJQ3R4Zi9LKzM3ODRCemxCWWE3RmdlUXhKY2w5?=
 =?utf-8?B?OVZyd3NDT2xEbzdFWG1ydWZRWUNMUDFVbGptUXNnZytoaHdHUjQ1akpLZTdW?=
 =?utf-8?B?YngzYmYzbWF4NGNEQXIxeTNqa3llc3k0N1I3N3NyZUJEUjBJYXo4VHFEcCty?=
 =?utf-8?B?REVqaUdud2xwY0pCaEpQaEk3MEt0azJYYWgzVmNFN0VOUzNpL1ExYkMxS2hm?=
 =?utf-8?B?YW8rM2RZMHBTb0xScGQ0RkxsLzA2Rko4SzBpWXozYUcxTGRFcThtUlo1V3Nq?=
 =?utf-8?B?ZlY5c0JxR1NPaEtwTnpxdWNXM0E1WTJ1cWliSEdSMVV6cXNjOEc5TnV0aTRv?=
 =?utf-8?B?ZjM0WjVjMmtsNFc4N0NHakp0MDd5U253Vmh1SjlYVmFMcFo0aUFmb280QmtE?=
 =?utf-8?B?Qi9mMC80eWNaNGFjRlNBYmJSZXZMbC9KTERNZnJTcG5EelZGMnk4ODFxSm5P?=
 =?utf-8?B?VlNKS3ZFb2YvZExVVEEwQkJJNHZVVGsrSENhMmdaTXJsVmJVMVNlTzN6Z2t5?=
 =?utf-8?B?VDFScVBBdmFTNEQ0Nll5ZHE2RTZzelRZRmFnb2o5UjBpVEdVdmNZT0hlczN1?=
 =?utf-8?B?UC9MYnJ4bFRFbkJWMHNHbzZCaUtFY01WaExLbzJKajVGZ0gvZUphS0hFVmt4?=
 =?utf-8?B?VUJTcFVaMHJHVWtMRE5uOXhpU2YwZjhHZXNrelF1dHE5NS9wVHBjSm5CZzlP?=
 =?utf-8?B?WncvK2Y3SndaeFA4UFpYVzhZbC9kMU9GUm5pRjgwellId2hZbElGMDZTUXFR?=
 =?utf-8?B?ZWkzV1ZGeUhvZi9mZUpURThScVJXdENiamRPUzZscGxWOGhXb0ZiakNqVENz?=
 =?utf-8?B?bFpTeElzWWVJQ0VUUTVHWGZBU2VCazJPZ2xETHQreUFPYmRQVzM1ams1ZVRx?=
 =?utf-8?B?MGhLRDArRlZQVmRiVEIrbXdNdWljS2Eyd0V3czVDbDdRNkdHaXVxd3A3Vlph?=
 =?utf-8?B?MEJ6WkVKRGNINXBRdDhaVXU0LzNhOGpDaldSOTVJREhFQmR3MndJNmZJNVpN?=
 =?utf-8?B?dC9RT0NzS2I5KytES0Q0UEx3c1ZtREVhK01EQ041QldEMk9IVlNVVWorTEt5?=
 =?utf-8?B?eG9nOG9pSzFGai9sWFl1SkpJTU9wVmxXTWRSdTh3WHVQZE81SENFd3RVK0kz?=
 =?utf-8?B?Q3NmZFo0VWhXYXNHNmk4SDZOd01DbVB4bE5SM0pBY1lHZkR4VEtTWXZTcmRu?=
 =?utf-8?B?WUUzNTVJV2Z1K0svY0hQWEkrbWg0T0dhM0JrUnVneEs1OW5qcXdlV0xTMklJ?=
 =?utf-8?B?STVnV2xUWlAyQW16QkdNbm8yN3ZSb2Q3VGRvbis0dHVlZitsMm9WQkdDdkN3?=
 =?utf-8?B?MElCUzV2anRlck4wRmZoWmZaY2xwVHRtRjFQQ1ZqUkd3c1I4Z2tHK1BpQ1ho?=
 =?utf-8?B?Y1FhNTNZeG52TG40UW1EbTF2R2ZOWTVHbDJzOFRPcm80cHlVOWZhKzd2Zmlv?=
 =?utf-8?B?SHg2VExvRFRPajdpSDRjT3ltdDIyM0xUaXQ4MHJJNmV1bk5zQi9yRGVDUXBZ?=
 =?utf-8?B?YkppNnYyd2twWVNLNlM5bzRzZHF4V3B4N1BKRisrRElrbW16RWRRY21kZWdG?=
 =?utf-8?B?eW9VblZZTXJLQnZmUDhaNHU0aVE0ejZKZGptM016dVptZUY2eTR5T1gzL1dH?=
 =?utf-8?B?bElaK0FHNjZ3Y0hpOGNDcG0vQXhzYkZ2MzcrVHhuZzRZaTVpbjhOZ3EyUUxq?=
 =?utf-8?B?VTlPcnc2a3lWVDhYVVFhYlhxbml2SENpMmlRZ2twbm1DN0x0ZlAwaUYvTUR2?=
 =?utf-8?B?M2JWdW1iMEQzdTY3K01qSDFqTHBSaFNDeVYzZGt4NHNjRERFTU9DRGpDRkx6?=
 =?utf-8?B?NjEwODdrOWtDYStSSXExRUl3bmUzSUxxTVpvWS9IVThXb1ltZWk0SW1rOVlh?=
 =?utf-8?B?NjFqd1R6Qm16Sk9mZkU4SUkrcWx6b1BkaFk3RDFBVHB2Ynp4ZzN5Qk9wTVlN?=
 =?utf-8?Q?Bmh4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(32650700017)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 05:02:56.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3204580f-030b-42ae-ca40-08de151617ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> +#ifdef CONFIG_SCHED_CACHE
> +/*
> + * Record the statistics for this scheduler group for later
> + * use. These values guide load balancing on aggregating tasks
> + * to a LLC.
> + */
> +static void record_sg_llc_stats(struct lb_env *env,
> +				struct sg_lb_stats *sgs,
> +				struct sched_group *group)
> +{
> +	/*
> +	 * Find the child domain on env->dst_cpu. This domain
> +	 * is either the domain that spans this group(if the
> +	 * group is a local group), or the sibling domain of
> +	 * this group.
> +	 */
> +	struct sched_domain *sd = env->sd->child;

Was this intentionally done to limit the update to sg_llc_stats to the
load balancing period of "sd_llc->parent"?

Can't this be done with update_idle_cpu_scan()? I believe it is more
frequent, "sds->total_capacity" from caller gives you the equivalent of
"group_capacity", and "group_util" is already calculated as "sum_util".

Checking "sd_llc->parent" there should be sufficient to check if there
are multiple LLC domains or not. Thoughts?

> +	struct sched_domain_shared *sd_share;
> +
> +	if (!sched_feat(SCHED_CACHE) || env->idle == CPU_NEWLY_IDLE)
> +		return;
> +
> +	/* only care about sched domains spanning a LLC */
> +	if (sd != rcu_dereference(per_cpu(sd_llc, env->dst_cpu)))
> +		return;
> +
> +	/*
> +	 * At this point we know this group spans a LLC domain.
> +	 * Record the statistic of this group in its corresponding
> +	 * shared LLC domain.
> +	 */
> +	sd_share = rcu_dereference(per_cpu(sd_llc_shared,
> +					   cpumask_first(sched_group_span(group))));
> +	if (!sd_share)
> +		return;
> +
> +	if (READ_ONCE(sd_share->util_avg) != sgs->group_util)
> +		WRITE_ONCE(sd_share->util_avg, sgs->group_util);
> +
> +	if (unlikely(READ_ONCE(sd_share->capacity) != sgs->group_capacity))
> +		WRITE_ONCE(sd_share->capacity, sgs->group_capacity);
> +}

-- 
Thanks and Regards,
Prateek


