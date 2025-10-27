Return-Path: <linux-kernel+bounces-870882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C8C0BE5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 666084EA394
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8B2D97A8;
	Mon, 27 Oct 2025 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hfpjOO5z"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255126281
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545139; cv=fail; b=Q2WIzWAJylCXPaDT1as/es4vrjqaUzw7sjpQpkwcXotY+qcV1Sk3ffcUnGzLcKX1EttaVM6f3UoeNf8ElkGocN5Krk70yXMiVhU2htNIvoQUk0fWjqDwZCgXzWTLCqAIpbxrL7w6aRnYirMXIza9t67W1biubbH5Hw+1JyKp+1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545139; c=relaxed/simple;
	bh=A2XTYz3UfkfaaoDZOr5KGsc1et8gpvv3QpQMyww8d94=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qV0kjlKIczYyKIiTW87JQl1uCWG1C0mAh7OqT5wyHfdxvky/Liy7Nop3f03nntrw77B8a2hhMSckimG3eJ0AfjUqaetLxWMseyY0bTbNZRW9ISZOk31l/wtrJsbRH6yBXA7vcVtMfVS176H1PdrpZdxwU7mdPatL5OO8Yiir8FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hfpjOO5z; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+2L6wmP2jLxjyXxmSzPFk7s7UP2LJzYOVh54tvohFJkh+0vYX0NG4WUL1gVyEvTbrE1W+KRCfQ0gYUVSgoMEFt+syERTKfCiLLQaZi8wjqCDkqluY8d+W3nFFXZc8HNABFY9x1ycxBzTk4KWyRne6f1ApAsujR57ym2Q8M47aDJPiXleROHLJVk/+tstJjT1G6rAAT9DIO4Ydu3kcHxaliHQClcppoeTgeBW4ZdiXQn1YCddBOOJGLre8N4ttuTjOmyYg8pRnERkoecKKRyBDtuF9DrKw0NiA9Rgdfm9ghe4ifi3xvB27eDAfCxaydBCwGV9AJsXLl1/+hcboCotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rF8tUBWuIET3gofHLFLts/aA46eEEUpxw5mmOIKVIxw=;
 b=ZYTZAlJ7j3Q5PgdjADLgkeqwrqFr/7tmoj6Z4FoOvB2+2aQyHH3dqlNg2KdWO/F9XHYvuu9WfT+cuXOQNbzvRwoGwWhW9ofE81I5VHhwruXfmECY1TTJg2ishF7guE4RI8J0QpbANjvur0qIJM9SZZAeUO3R/sTleqhIWrN0DiFRjOovlsrzZL7MBGSaZfYwH21SOcvsyqKTB3j7u0QynADXMVucE/+rmKpDdsCuf9pEIUEsiy8l3Mm4MY3TNR1lohJcpKFrw/Z8XaEqccSZMNmKn70rCRgHJWmc7xKOEUU3TfKE0dHxBnzB4xU062Ybz3Rs+gEi3O8hPAvZrp14OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rF8tUBWuIET3gofHLFLts/aA46eEEUpxw5mmOIKVIxw=;
 b=hfpjOO5zRWXTGKjsBZH1/0mOfkArJGgB1wO/W3g8yXg2uc0oySvYBSmH5ju6SQqCV5sFRze2VIF3wOg8+0Q9rJEPXL8TrTds/P5hNVf+ZI7i3BXpjbcu0BnhHfTcJV+UMEbRTOYDPkdUB/S5blxJAQ3GzuLeXs95WMfm/TvajFo=
Received: from BYAPR03CA0007.namprd03.prod.outlook.com (2603:10b6:a02:a8::20)
 by DM4PR12MB6542.namprd12.prod.outlook.com (2603:10b6:8:89::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.17; Mon, 27 Oct 2025 06:05:33 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ef) by BYAPR03CA0007.outlook.office365.com
 (2603:10b6:a02:a8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 06:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 06:05:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 23:05:06 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 26 Oct
 2025 23:05:05 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Oct 2025 23:04:59 -0700
Message-ID: <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
Date: Mon, 27 Oct 2025 11:34:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Chen Yu <yu.c.chen@intel.com>, Libo Chen
	<libo.chen@oracle.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM4PR12MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: a61fda73-cab0-42a3-762a-08de151ed6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|32650700017|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhBWkszM3QyUzZ0Y1BIeFZCa2VndjBORG1ZeE5hY0pOOWV4amhjdEEvOGJU?=
 =?utf-8?B?RzdETy8xMVV3Znl5WUJwRGRwbFhXYkFMV2VEQ2RCbEUzSUpXL25MMlVrRzZN?=
 =?utf-8?B?T3R6YW05NWFjdnY0VS9EM1p0Q2NVWUlaYXQxSmY3VXdVdXVENEhRRndaUjcr?=
 =?utf-8?B?N3Q1a0ZpaTNWczBsZEthUlVPT1FaQ2g4eFhsZE9Eb2dWV2xHOThNSkNOTm8r?=
 =?utf-8?B?TElBOUVDQ0IzdktMWGZUUUJ3NFBHLzYrTXBwbFp2S1oraC9pTlplWC9tZUw1?=
 =?utf-8?B?TUpIaDloazRKVlRQeTBlck94cGJyd2l5aXE2Y2s3bDhMeVBZT1ovRWZZdVc1?=
 =?utf-8?B?QnIvQndxSjFSZmt2bjJYajNCMkE1elZwRzE3ZHcxVTNYNHc1WnpUeEwrMG1Y?=
 =?utf-8?B?QXk3Sk5YWTJkN1Mrdm9ieGZJTGlCc3BqTlk3dUhjb0w0U2RKMW96TkVPczhs?=
 =?utf-8?B?SitoSXV5SjFiM25raStxaEk3dGxwRWxHTEpJVVlybHRzYnJud3JkY2VlZXpU?=
 =?utf-8?B?TEJKdmdJVkRxelhoNnE4MklkQ3k4b0M1Z2t1WEJiaUpheEh6cHlVaGtFbGZW?=
 =?utf-8?B?V1lrWkxOdmhtU3kwSWcyV21PS01UbXFaNlYwSnJxdnFHRWhUUFpGczZVdTZ5?=
 =?utf-8?B?ZVN4SU5TS29ONWIzSWhYcWhHU3pWbWQyM2NMeDVsZjV3aFhTVGYzN2dqazV3?=
 =?utf-8?B?VnRNallkL1VMV3NSN1l4RjcwcHNYOHRNWXdtRDJkTXJNQTZVdzZrQ3ZHRlln?=
 =?utf-8?B?Z1M3Z1ZFSE1pcXZXV0d3WXlPa2ZHbWJYSDhLdnhNL0xwcTcyZURZd2ZQNmtU?=
 =?utf-8?B?OEJYV3V0bUwyWHZBZ0JhaVVzaTRNQkh1QjVvc29nYk1Bbml3V2NtbGtNcndr?=
 =?utf-8?B?ZjFheUt6MTlvZTYxRHJrbG1uelBOUTRpUVhZUVRjZWtGNFdtREtnWnF2SGox?=
 =?utf-8?B?M01HOEtScCsxajluVGtQV0Jhd0hGWmJiVThHdlZrYmo3bnNQa3paUEl6MG5i?=
 =?utf-8?B?bmdlbklpaWNpTXA4enhoRkUwU1B1SXo3VnIwY1hXa0FVbm5vNDNpck9EekhM?=
 =?utf-8?B?cmMrN0RtN1R3N1NTQktQQ3VPZndqUlhRSkZFbXRsNUZGbHpOQ1ZMV3dzK2R3?=
 =?utf-8?B?R2oxYi8zSWUvd2ROUnp2RHUxTGIwMjNibC8zZDQwbXJ5ZVRldDc2UklKL3Uy?=
 =?utf-8?B?NGpHMXVKVkRWYzNtVkdubU44TXphcmRUVU5mdG5ZUlhHR05wYTJMSFJLQ0Fq?=
 =?utf-8?B?REppRTduSEhCNStDb213RWh6bTVMZitBeDNBSGg1NEhCNFV5aGg2eFpHMFov?=
 =?utf-8?B?Z25pUXNJNiszdmlOY1RHTjJMSHN0aVZHUWJIblc5US8wSXJOVG1zQlZ4MUYz?=
 =?utf-8?B?MEg3cjVLM2hvUDRrVFhCZ2RNQXNNN0FwS3p6S0wxUTVUZnpYeE1NSG4zVk1K?=
 =?utf-8?B?RVlHUGtoeEttSkxPcU83ZVZqSjZXbFRsVEtqVFFESVFLemQ2QTNlSG44NzB3?=
 =?utf-8?B?c2lQdEh6VysyS2tLUjFJcDBRSEtvWndycEV0eHJyK3g0ZjZUc0QyQzZESnUv?=
 =?utf-8?B?YmxqM3FNMkwzUEZlOTJyZXhQRmpoSitFWmZ3Qi81cEtiWHBuTjhHT3NRN2Y0?=
 =?utf-8?B?UmpUTTY0Z3dSeU14MGV1Vk1FRkhGaXg2RlZjREhQamlSNWVrZDFUbFVWVHRz?=
 =?utf-8?B?cC9ndHZKcGRMTkxqQ01jL1Y1QTJsOE14bkcvbEdsVDlaZFl0cTNDMU5WYUFv?=
 =?utf-8?B?Zm1BYXplVndmTERSL2gzenpxUUpEK3d2RlNDd1FxeTFPMkMwOWFuanBBYW9V?=
 =?utf-8?B?SStLTXdkR0l0ZmRqUGZyNWg2eEZFSkxpcHhTeXhRVHc2LzBxdnlPV3dHN003?=
 =?utf-8?B?WlVXaGNYM1RJUGJzaVN4bmJ5R3hnM1FFUnJoTzJBTVA4MFZxZUxXV1JKcW5M?=
 =?utf-8?B?YW1MSFlBeTVhSE9BOUhkOVM1eDJISFMwbk1wQTg0aVZQNkdKTDNEcXhwMDZk?=
 =?utf-8?B?bUZaUnFrZWgyM2ZucFZjMndZSVJPMGNTN2c4NEllRkEvRHNpcmVoeFhBR2xO?=
 =?utf-8?B?bFkweTU4ckI4NzhqT1dtVGEybUpEUk4wV3Z0NXRSNUhLWWY0MllqNXVwRllm?=
 =?utf-8?Q?MCbs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(32650700017)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 06:05:32.8940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61fda73-cab0-42a3-762a-08de151ed6c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6542

Hello Tim,

On 10/11/2025 11:54 PM, Tim Chen wrote:
> @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  		struct rq *rq = rq_of(cfs_rq);
>  
>  		account_numa_enqueue(rq, task_of(se));
> +		account_llc_enqueue(rq, task_of(se));
>  		list_add(&se->group_node, &rq->cfs_tasks);
>  	}
>  	cfs_rq->nr_queued++;
> @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	update_load_sub(&cfs_rq->load, se->load.weight);
>  	if (entity_is_task(se)) {
>  		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
> +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
>  		list_del_init(&se->group_node);
>  	}
>  	cfs_rq->nr_queued--;
> +
> +	/* safeguard to clear the cache aware data */
> +	if (!parent_entity(se) && !cfs_rq->nr_queued)
> +		reset_llc_stats(rq_of(cfs_rq));

Instead of relying on reset_llc_stats() hack, I think a better approach
would be to have a "p->se.llc_sched_active" flag similar to how uclamp
has "uc_se->active" and we set this in account_llc_enqueue() which will
still check for sched_cache_enabled() but account_llc_dequeue() would
only check for "p->se.llc_sched_active" to decrement the stats and then
unset the flag.

That way, we cannot have an imbalanced accounting. Thoughts?

>  }
>  

-- 
Thanks and Regards,
Prateek


