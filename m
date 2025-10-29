Return-Path: <linux-kernel+bounces-875099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F0C1837B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD4F1C28495
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7498C243946;
	Wed, 29 Oct 2025 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YvgcK702"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80E13AD26
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710436; cv=fail; b=XxbhFqAh4hGG8yI0MU56nE/c8MC9BqaJ/jN05DHWAJ/DEcBNfSA1hYDv1VZqQ4fnPL5nxR98IHhlI7VueTg5iTld7ETb8oU5i+g/pev0lBHHWkTvWn3J/DTxKG7uGafsLRVHk+1myVFodikUL2GCO9ABiI6qBh2nKDqUZ2qJQQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710436; c=relaxed/simple;
	bh=1hFpsTxir2nWLJzrk7BeP2HlLLZIZyuofMOY+ThlzGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gEnQ0lej9NNqpKrSR4CfpZiGpj4VQOAAM+JeM3O+ij8hb5NQvewIdkxJLBrWgfOT9BGTsT0eGz6ssSmKKNrdRETBO/etmU2gTFmrRFONnSb8I6K5IlKRAXdsk8SjtY2YuDsbFELqq1qcsPrGT6AsBomnbUIdRSc6exmjlVQ+1Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YvgcK702; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7Sl2WL3DPdJP7a0glWuRa2cf9JToCOwA9YSsUoQ69ud10wILe8dtDH8+tHMkFgmHWvRjEA2HVoaMQmfZfd9PwcoLUOSI04H7XZP+9i+Eg8udjltyZYPJKo/oWA+SX99Ur25hOAFvIc5CgzCVx5jz9q5IpLh2MJFsyKVXcrKnlXQ5tXNbiWJfR96qp/Ludt80dMjViRAImo40ToakeNxbn6v5kVZGy5w/est54muArKWAluyMxEEXfHREPes4wswzVuY+APTqU01+rVTfHob96ZShD45oXeUeCMxbvEwnpRmPCswwO+SnU5izWInn0opPjYjnpeD9N3RUX51E/0W2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp1JnYUEOeTa0Ju7kA/RXiJuwLoLWYFmN3dQ2ICKGv8=;
 b=kwEi87qr/v4M0a9ZU+fywZF1PmyPyhA00gm7ZcECR4TNGm9E76KkY4NGUFFNEFLFZsXYTgQHFS/xMMIgQXmkm09B2vNMTc8XnhSJ76Tr2TjbtJyZ2+vdSfIu5TrQ7RN6a8dkANeTCmQnPIbw0tfNAWifcKTjXwIHpKDEsbM2POwcPg3M4F9k61XjRz+LrDA+XGrnpmD50mZIz6NZyR9oWEI2zvC12HHILTMfHvHPIYBLkyC3vA4Z7TK4ezofrXt/dFj76WLx18vTXSK9IC5Lvignkuf30yoFHYQlGrhseZCYQOCiUwQJpAzptQ8rRQWlJi0JzDn+855ibfRInIYH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp1JnYUEOeTa0Ju7kA/RXiJuwLoLWYFmN3dQ2ICKGv8=;
 b=YvgcK702BaCvDuKJBQJQZL1Ah05Q8td6Y5LD/Y+jybjUPgQSKwqbP/5MM20MwuBORvJo6bUc3RF2KIIUGsL3Cb2e0vfNsB5BltrQeXjk5/wa6d9hCMP2ANTWm8jVb3Z9h6G6aPxNp7wymPtQRbd5TFa0c8gKC05LOOaXAqD8i80=
Received: from BN0PR04CA0126.namprd04.prod.outlook.com (2603:10b6:408:ed::11)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 04:00:32 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::40) by BN0PR04CA0126.outlook.office365.com
 (2603:10b6:408:ed::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 04:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 04:00:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 21:00:13 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 21:00:07 -0700
Message-ID: <7363e7bd-942e-4e6e-9147-86b620a62120@amd.com>
Date: Wed, 29 Oct 2025 09:30:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
To: "Chen, Yu C" <yu.c.chen@intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>,
	"Yangyu Chen" <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, Vern
 Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
 <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: ab3664bf-9bc7-4ce9-75b5-08de169fb4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|32650700017|1800799024|36860700013|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0pRUWpqckVmN3RlQ1phMUwwclpQNmttRGhQbmtNR0VYTG1DN0dENFlXREM3?=
 =?utf-8?B?a1Q0a241UWp4ZXArZHl5M0NOOGJ4WW82bVdjMW5RR1BKcVpiVEQ4bGdxVy9X?=
 =?utf-8?B?ODhLVmNnZ21sbkZzVTEwR2x3dzI5RjJYSWJSU3R5QW14T0prbWxqVG02ZC9v?=
 =?utf-8?B?Z1lOZ2dtOFZMd0VBYjVjdGh5Mk1BQTRHSG5hb3FKZm16Z0xsOE5SaHRPY0ZM?=
 =?utf-8?B?ZG5DRm52ME41NkQwSzJYTGpjVGliWjBGVVZOK3pES0xJZUgvOExpWGNLRlRC?=
 =?utf-8?B?RHMxVWpYNERqWGZOUTcwSU9sUndJZGJQV2tZb0dpWWRlUDJ3b21wL2dGTnJR?=
 =?utf-8?B?ZmFuTHNNWVozSHEydW4vMGhGbCtpSFVBYzRXSStUY3N6TkRtdXV4WFl6amVX?=
 =?utf-8?B?WURwd1lodVh2cTJWbG1oaWNzYXBITUtZc0pHQU5xRjVBb1lvQkhQajBZRENt?=
 =?utf-8?B?d01BYkxtOVhjOG5xVU5kckhUVTEzR05lMTlhckJ6K042N21RSGt3djIvZExE?=
 =?utf-8?B?ZEs3KzNEU2JSbmltV25YTTh5NEdpZkRnK04xT3MwajJKOEJLd3lGNzFVVi8r?=
 =?utf-8?B?U3hnc1o5RnVyc0xTcElFTWYyVkxHRzNaM0EvQnVJSG4ySjJMWEpqUVc2MEZa?=
 =?utf-8?B?RFNFREs3WXVsK0Y4UThzdGJJQUJ0MytZMklwbEZXU05MeFVCdnc4eFhDZ3ls?=
 =?utf-8?B?UnFOVW03dTIzbDhsYWxUb2JUQ1Jvb2ZTVUhvdGw0RVZQZ3crc2ZiSDZyb1hj?=
 =?utf-8?B?Sm1OU01mS0ZUN0tHckg4V1ZrY012aFFGMlNjSXltbEh5SHhWTG1JZ0l6WjVu?=
 =?utf-8?B?UmZkNUo1RjVDZnNDWVdnWHFORVUydWRWdnRkZ0l1WUo4ckFsaWNPbGNtREcy?=
 =?utf-8?B?NElWNWpqcWlmUGVxaDJIVmJISTB4MTlqWUNGMVdscFBnSnZjeG5kaENSYjBu?=
 =?utf-8?B?V0dTeTBwdDBFeW1hZ3NVVEJUSjNFekx4Z1RBaG9VVWs1cGhBK0I3ZDhxN0ta?=
 =?utf-8?B?dDNLVXJYdHZQZnhUMy9qMVV1WWZ4NmV1NGxqc08rMlBMa2QxaFMzSVFKUmlB?=
 =?utf-8?B?YzBjMC9wUURVa2VyY1Btb2tIa2hrdkVNdGdHcGR4bXV6K21IckRjdVBWc01u?=
 =?utf-8?B?bDlVSHRXam5FUlMwRm4yZEgwT2FCZFVxL1FtNUJkQ21aMjVNVXJUcVZ3RER5?=
 =?utf-8?B?WHZ6MWRmZFNWRzgrTjdzakdkQlhPTVhCZm5oVWptUis1YjBqL2I5dkloRm5H?=
 =?utf-8?B?NENyQVBJSGlhYUY0MnBsRGQyWHJVRkY4V2t5cGlIWXQ5SFlJTFd1R3hNclg0?=
 =?utf-8?B?S3p5UWRVQXR3cENtQ1RwQ2E0UStDR0gzUXk1NGY2UGpUSzU4aFh3RlVQRzdG?=
 =?utf-8?B?R2NNcEdCb3hYcVlWUmx2b1JIUDczUTY3ZDM1ZUxYYUl6ci9KZWtLKzdXdVpq?=
 =?utf-8?B?TFlSWHlOMnRZL2szWmdQWWNKSHJiMSsreUpYdXVsNk9YcXdSOUFJb0t3czlJ?=
 =?utf-8?B?b1dpYkpnYWtGR2V5dU5qVnZpY3RwV0JLRWw0czhuV3k5OEFrSmxsL1ptclF4?=
 =?utf-8?B?TWZTNlhnNzJ5YkVFOXA4ZXJxMlZRMWZOSC9Kays5YU45NlFlc1YzSFJFa29P?=
 =?utf-8?B?SjV0WEtnYzBWckdhZEVyVFB1bUR5Q1VpZjlNbTJ3RzdKcGh6eU1DWitGbzJv?=
 =?utf-8?B?eUNlcHcxUkdoZzVDUEtmMktMaENCSzYwMER0amp5ZTBmU3RnSWFob2hac3Jv?=
 =?utf-8?B?UmJRS1Y0U2lqcDdXcklOK3N5VENWRytkaUhaRTQwRnIvVFFMWkhOcFNPaXVC?=
 =?utf-8?B?MUZ4bGQ5TFgyK0JFVU1VbmVUakVhamExclZPN2hOYm9RdEwrTmdGRUZISW54?=
 =?utf-8?B?YkhiVXJ6Sm9FMktUMWl0SmkvZGJWRTZmeWNTYnF0YysyQ1lxOUFvQndJODVn?=
 =?utf-8?B?OEVvdEhnQW52YUc0SzZ2Ylk2d2FVZGhZOGZSSi92cXI3MGhlRGx3ZFpTZW4v?=
 =?utf-8?B?WVp6c0lWTm5GY3AyK2R6ODdsTDd3L0JZSnI1NDNocEhHcGxPYUx1Vk41RDdB?=
 =?utf-8?B?Q0NwTU1sR1BvUWl2U0hPQUV1NjlVS01RS0tiUDdMOE10aEZUQ0JkSU15NlZz?=
 =?utf-8?Q?BHCI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(32650700017)(1800799024)(36860700013)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:00:32.2457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3664bf-9bc7-4ce9-75b5-08de169fb4d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567

Hello Chenyu,

On 10/28/2025 8:45 PM, Chen, Yu C wrote:
>> Instead of relying on reset_llc_stats() hack, I think a better approach
>> would be to have a "p->se.llc_sched_active" flag similar to how uclamp
>> has "uc_se->active" and we set this in account_llc_enqueue() which will
>> still check for sched_cache_enabled() but account_llc_dequeue() would
>> only check for "p->se.llc_sched_active" to decrement the stats and then
>> unset the flag.
>>
>> That way, we cannot have an imbalanced accounting. Thoughts?
>>
> 
> I suppose what you mean is to avoid the race condition between
> enabling sched_cache and EQ/DE_LLC, similar to uclamp:
> 
>         enqueue(taskA)
>         // sched_cache gets enabled
>         enqueue(taskB)
>         dequeue(taskA)
>         // Must not decrement rq->llc_pref for taskA
>         dequeue(taskB)

Yup! We can have

  enqueue(p)
    account_llc_enqueue(p)
      if (sched_cache_enabled())
        p->se.llc_sched_active = true;
        rq->nr_llc_running += (p->preferred_llc != -1);
        rq->nr_pref_llc_running += (p->preferred_llc == task_llc(p));

    ...

  dequeue(p)
    account_llc_dequeue(p)
      if (p->se.llc_sched_active)
        rq->nr_llc_running -= (p->preferred_llc != -1);
        rq->nr_pref_llc_running -= (p->preferred_llc == task_llc(p));


We can also have a single bit for "llc_sched_active" in the
task_struct next to the "sched_task_hot" bit instead of using the
hole in sched_entity after "sched_delayed"

-- 
Thanks and Regards,
Prateek


