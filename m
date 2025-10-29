Return-Path: <linux-kernel+bounces-875113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A01C183C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA77E1A61883
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF02F5A0A;
	Wed, 29 Oct 2025 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mava5GSS"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188EB19E82A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761712413; cv=fail; b=tJqDUC59UKUef7v+9miwjSf35dcUwRi2fbFUGdJ+IHu997JFwnidz+IE0pPYTd0FcNWx+562pvWwkHHLn+nQg2HnmbiD/D9pmhWORpqw3ID6NoAjsqdg35ycXNbLNxJfiBYNXrw/gOvG8Rja60YRfvQtdP4AbFoZZkpjMr2Srso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761712413; c=relaxed/simple;
	bh=48bz3/JfCwPlOf8BcAbnBOn6xaPUBr3PNhi9vljaDMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jEO1LX2LPQqfaCgwwp+zBAgIc70tyUQZ8/AolnPbRnjToG1vBenqS0aqwUcK0S9xnKluz8qiIWYuTKhVdAHkwc+/f6dqjlvwmsqaR1+MYdmuFiZ42dtepuXSDgns7ZDaum6tIAEmjCWzlaRmwcBoaMDVl+wQoB/uQaHCg3GZ640=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mava5GSS; arc=fail smtp.client-ip=40.107.209.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuTO5JLDWcirqpGrU4Y6pOEDbYXpIpIKrrryW6fYmeTHHjaRgR1Ox5OoGK1Swi4AnlyVtau7eo+kXIHaCOQYnIe9CvQwgmlTYMOiAyLL24qYb9U3KK8Coq/TvLJyiIQM3W1i+SGqYYooJstnBu5kXRPV6LtOTpPdoymx/6htzk/6fPVmtTFoZpA3bWMX6EQUD6IiQ3ykNzLJgI+ovaHQArWDfUND/lgvZgbDvtZOtKuRc2Acm4gS83feUx0Vri+4py6BoR3tSeMfX9Cn/oODHDhpYqFGB+q/We8Sg90IXAc5jRQtqInwdQE/rjerUgtZNBVoqahD9A6hSPJXIXshFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4bLyLhdLCKOxRsTDtp4bM7FfukmuqJU3qCuhxFHUTE=;
 b=lAm95YWXUr01PwwT6mJqb8o4n5wOwRMD9jkFTW9kpimi2Jc4DavUH9xQPW1GBRMD8MyakYWvurTsUhke3EpV5ZuyTzzA9r821KzsampKi1BeatX2lGZZ/TV19rvK/eKCPiKUsc1DmmEb1A/aIvxLES9dQxHHePz5YlqQ4UL94wB/VBwvD7bIhjEwD2KBLpk7gDkqlkOUiNK4JHMedNCj1cHrOGK4+NBCgQxy8rbfnLbqlkJvAdtkjvgrYZS3aNsRmtOfxI6ByGgoNZFc0BWuLXcFnnCfvo8LA/RyefgJ0GYK2hABlJN74KsIl5DVdD7Q0C4/SaDj9ciufWAhMi2mHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4bLyLhdLCKOxRsTDtp4bM7FfukmuqJU3qCuhxFHUTE=;
 b=Mava5GSSttFkvJEieP0uixZoDhXxCzXnGH0HKm0EhVWJsbUZFpIGqg5MwyC5S/TXgLgZ/+uzfv79EG2LT84k5pK59Da1f5GGCQxZ+CJgB3AWtXe2mxSvR7EIn70TfREyiNUEO0+SaD/5gw3/LXsb30NtF1dlAt/sbd0DKtLyVt4=
Received: from CH2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:610:5b::29)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 04:33:27 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::1f) by CH2PR07CA0055.outlook.office365.com
 (2603:10b6:610:5b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 04:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 04:33:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 21:32:08 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 21:32:08 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 21:32:02 -0700
Message-ID: <522c6c09-9d07-4417-b9d3-925bd2224627@amd.com>
Date: Wed, 29 Oct 2025 10:02:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/19] sched/fair: Track LLC-preferred tasks per runqueue
To: Tim Chen <tim.c.chen@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>, Hillf Danton <hdanton@sina.com>, "Shrikanth
 Hegde" <sshegde@linux.ibm.com>, Jianyong Wu <jianyong.wu@outlook.com>, Yangyu
 Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>, "Vern Hao"
	<vernhao@tencent.com>, Len Brown <len.brown@intel.com>, Aubrey Li
	<aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Chen Yu
	<yu.chen.surf@gmail.com>, Adam Li <adamli@os.amperecomputing.com>, Tim Chen
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ccbfda37200b66177a1c1add4715a49b863ac84d.1760206683.git.tim.c.chen@linux.intel.com>
 <fe5eeffc-ff8f-4bfb-b0a1-5b25731afb88@amd.com>
 <ab01cb87-71f6-4893-833e-136e7acd777d@intel.com>
 <094de5bd4f1b5cd4552ae024f9254df26c9e47be.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <094de5bd4f1b5cd4552ae024f9254df26c9e47be.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 0152bdca-4d5c-4ae7-0271-08de16a44ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|32650700017|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDM2SHB2cHFUdEV4cDcrZUVGaU1EK1ZaRVJGVTRqcW51M0JpUmNCWXdIVk5m?=
 =?utf-8?B?aU5MamNYZmZGbVVPeVBPdGMvZm1EZytQRTlWUkpZQ2JwMUhrbXlGTTRvcjRh?=
 =?utf-8?B?N29nRCt5Zlg4RlNGcFo0eHowRFdZME5lc3Mwd09Ib3Z6LzAzaXFhWUdZczBa?=
 =?utf-8?B?d3ZETGdIeFA4NVBPWllHL1k2bG8wK2FjaWNyUlVBN3QzMjBkcmk5b1J3elBJ?=
 =?utf-8?B?aUtPTUhJQnhQZ1pkWXBGbjR0ZlgzUzZNbFNHOTVmTW1WS2NvK0E4dTRlQW9Y?=
 =?utf-8?B?dm9pRmtUdVBkeXEvUHdjRzEyVHVMSjdQcytpTHZsdE5Wa2ZXMml6Y1k0aVZU?=
 =?utf-8?B?cm1uQ3pYa1VxdE8vQ0ZOZXVMeDgxamhmUUM2QWFBM1hPc1lvYUpvbllQc0NF?=
 =?utf-8?B?SksvRDRvTmVyeU5IdS9yVEk2STYzQndhWWJvZHlVWTZPV01DMlRsd0xXbSt0?=
 =?utf-8?B?UVBvWm1FNThBakhQS0I0WmVOSnRUMVJXaks1TjkrWlVEUi9pVThDREhPSmhp?=
 =?utf-8?B?TlJ4VFNtclRUZTd2a1ZYK0pYdmc1R1NlOWJsc3RnaEVTNk5jTklsdVhQTjcy?=
 =?utf-8?B?Z1JCS09BNzh3WUt6Q3QxdWxoTHRXTDRmay9RU3hGcy9ZT1B2azdiaUhIRFpW?=
 =?utf-8?B?SVg4L2FFU2RlMy9CRzJON0R1eXMvajd1V0M1OVZJbUJ2WWtldGVPVFpaSHdz?=
 =?utf-8?B?MXZNYlNxMVFMYVo1VGdkbjRKTUxVdmdoWUlRUG1ZQS9ONDA3UUlaZ2x1b1lW?=
 =?utf-8?B?K0tTdHc5RW00L2s2WE0xY0wrVEpFRmhockhQTGwzREswMlBCMHFZeWNwU2Zz?=
 =?utf-8?B?MUZMTDl4bGliV2xiTGkySWNCTWRLeFVocTRSTTVHZmIrMjVRQnkzak5LQUxk?=
 =?utf-8?B?RXlTZ2FFWkhWYXB1M2F6YnovcldQa2NQWTVKZk5nNkl6QmhxK25qRGtpQXdk?=
 =?utf-8?B?UHBPUmR6YWQ3ZVJPdFRDMkdmWE95Sjl3MFQvck83c3BuaHNOMEhMY2crWlV4?=
 =?utf-8?B?N2h4MDdrb1pxUzdQa2xGeWZoUmVYcmFiM1UvYVAyUVpZTTBNVHRKOWJwdjRF?=
 =?utf-8?B?SkNqNTc2Q1dkMDBnYXJWekJOTFkwSlpjbEFtVDQvM3oyWHRGV29RTE5mMEJT?=
 =?utf-8?B?L0xBS0lLNGtpa3FBQXMyRnhoNXh2Uk5nTU8yMjROaE9OTWl5TnpwOUJYRDl5?=
 =?utf-8?B?Nk9jK01GSzRsSGc5SFRVQ2VzQ2k4TG1zclRHWlRtcnIwR0dpVnRReTVUS0dO?=
 =?utf-8?B?YUJBSkQ4SlJHSmJVeUs3ajBqUWJxY2M0STFhQjNOVGxtdHhRSFd3QWt1TW9l?=
 =?utf-8?B?MDRSdkV5Tk4zUDVVVWNiZzR6VkRuLzdMeDJTL1MyYTVmSnlMZzg2NHdTRUpE?=
 =?utf-8?B?WWxrNmxsSjcraXRIV0V4dUFoNDE4THZobGEzNS9nS3lndkE0NWNDZHRVa0Y2?=
 =?utf-8?B?NDJBV2NrZGFFYTBLQUhPajdtcUMyVGs5UUlOWDA1MzVDR1h2UGx4eHhsb3hz?=
 =?utf-8?B?WGk0N2FyaTNFN09Vc2Q3MXpCMVhRV2ttYW5KYjE1Ujh2NGNkL2lkY0FsWUlv?=
 =?utf-8?B?ZkRDWnhjYSsvRTFwYmVJN01MNGIzbmczTFd0YXJ3M2g4Ty9KN0JXWUxVQ2lx?=
 =?utf-8?B?UUswTkw2aTZtaHlXbEc0UndEeVI3MFQrK0dMM25CSzFocm0wblc2RGFJcFRB?=
 =?utf-8?B?bkFxVkhseUhjNmlZUTA2bE16YnpoZ3RzM2tZYkg3RFRIaCs2dTV0OEp5OVBQ?=
 =?utf-8?B?Q2phV3VCK0I3dGVwK29jV3V5SzJ0b20xL3A2bld1VjZDbndNK3VZRFQwMEZz?=
 =?utf-8?B?d3NWRWZiMXphRnA1N3locWp2QUFJSEpCMVpPSCtRN1NtUjJwT0kweVVMSFZ3?=
 =?utf-8?B?VjNYNVRiallwSUtYT3BYRkduWURPS05ncjlLelEwczUxMDBlMzJYY1RLNlZZ?=
 =?utf-8?B?NE1wZlJKR1ZYTzVKNkJLQXFCRVBkZU90L0JyaGhTVjFMQ1oyRnZLTGhBblJm?=
 =?utf-8?B?bGJPeWJOYldzRGpISU9sa0ZoSmM4citrV2tEbFR2OU1RU2V2RldJVFJQU0FC?=
 =?utf-8?B?dURkcHNrOGF6UzROZmhSQ2VNUVpWdkdqbUl5TEthTS9Ddzg1d1cxd0hGSzVU?=
 =?utf-8?Q?SVxs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(32650700017)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:33:27.0481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0152bdca-4d5c-4ae7-0271-08de16a44ded
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023

Hello Tim,

On 10/28/2025 9:16 PM, Tim Chen wrote:
> On Tue, 2025-10-28 at 23:15 +0800, Chen, Yu C wrote:
>> On 10/27/2025 2:04 PM, K Prateek Nayak wrote:
>>> Hello Tim,
>>>
>>> On 10/11/2025 11:54 PM, Tim Chen wrote:
>>>> @@ -3999,6 +4038,7 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>   		struct rq *rq = rq_of(cfs_rq);
>>>>   
>>>>   		account_numa_enqueue(rq, task_of(se));
>>>> +		account_llc_enqueue(rq, task_of(se));
>>>>   		list_add(&se->group_node, &rq->cfs_tasks);
>>>>   	}
>>>>   	cfs_rq->nr_queued++;
>>>> @@ -4010,9 +4050,14 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>   	update_load_sub(&cfs_rq->load, se->load.weight);
>>>>   	if (entity_is_task(se)) {
>>>>   		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
>>>> +		account_llc_dequeue(rq_of(cfs_rq), task_of(se));
>>>>   		list_del_init(&se->group_node);
>>>>   	}
>>>>   	cfs_rq->nr_queued--;
>>>> +
>>>> +	/* safeguard to clear the cache aware data */
>>>> +	if (!parent_entity(se) && !cfs_rq->nr_queued)
>>>> +		reset_llc_stats(rq_of(cfs_rq));
>>>
>>> Instead of relying on reset_llc_stats() hack, I think a better approach
>>> would be to have a "p->se.llc_sched_active" flag similar to how uclamp
>>> has "uc_se->active" and we set this in account_llc_enqueue() which will
>>> still check for sched_cache_enabled() but account_llc_dequeue() would
>>> only check for "p->se.llc_sched_active" to decrement the stats and then
>>> unset the flag.
>>>
>>> That way, we cannot have an imbalanced accounting. Thoughts?
>>>
>>
>> I suppose what you mean is to avoid the race condition between
>> enabling sched_cache and EQ/DE_LLC, similar to uclamp:
>>
>>          enqueue(taskA)
>>          // sched_cache gets enabled
>>          enqueue(taskB)
>>          dequeue(taskA)
>>          // Must not decrement rq->llc_pref for taskA
> 
> For this case, task A is already on rq when sched cache get
> enabled. But task A's preferred_llc is still -1. 
> 
> If we dequeue it while its preferred_llc is still -1, it won't
> affect rq->llc_pref.
> 
> If we change its preferred_llc to llc_i before we dequeue it,
> then rq->llc_pref[llc_i] will be incremented first.
> 
> Then when we dequeue task A, we will decrement it. We are
> still accounting rq->llc_pref[llc_i] correctly with current
> code.

So what I really disliked was having reset_llc_stats() to
reset the stat but looking at it again, that too is guarded
by sched_cache_enabled() counter so I think the counters can
still go out of balance if:

    /* Cache aware scheduling enabled */
    enqueue(TaskA) /* nr_llc_running = 1 */
    enqueue(TaskB) /* nr_llc_running = 2 */
    enqueue(TaskC) /* nr_llc_running = 3 */
    dequeue(TaskA) /* nr_llc_running = 2 */

    /* Cache aware scheduling disabled */

   dequeue(TaskB) /* nr_llc_running = 2 */
   dequeue(TaskC) /* nr_llc_running = 2 */

   /* nr_running == 0; nr_llc_running = 2 */
   /* Cache aware scheduling enabled again */

   enqueue(TaskD) /* nr_llc_running = 3 */
   enqueue(TaskE) /* nr_llc_running = 4 */

   ...

At some later point if nr_running reaches 0 again, then
"nr_llc_running" is finally reset to 0 but until then it
can show inaccurate value if users repeatedly toggle the
feature depending on the workload running.

> 
> The trickier case is if we need to dynamically resize
> rq->llc_pref[]. We need to make sure that we lock the rq
> to prevent enqueue/dequeue, switch it to a larger size
> rq->llc_pref[], copy the old data over, then switch over
> to the larger sized rq->llc_pref[] and unlock rq to keep
> the accounting straight.

When that happens, we'll have to modify sched domains since
something has changed in the system / cpuset and rq_attach_root()
could be a good place to do it at when rq is offlined and onlined
once again with the rq_lock held.

Only issue is if the partition splits the LLC in which case, we'll
have two LLC index - one for for first half and another for the
second half and we'll have to re-account the task to this new
index.

-- 
Thanks and Regards,
Prateek


