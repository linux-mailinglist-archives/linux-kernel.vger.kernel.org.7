Return-Path: <linux-kernel+bounces-875106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3548C1839C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B4C420D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6632797B5;
	Wed, 29 Oct 2025 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4scja2m"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D4E19D065
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761711344; cv=fail; b=ae5Jx03ss/LEoPlOn7pqV8tN9ZI0OESejVZCLTEYUAd2AMUitkPiyNDBmRudHaSjBtLxXqbH1rkzMw5yhIKPuAjVnVEmaBsjkHJ75mmR3NThjcX+jA+2exUTEBlx/rXOaIAwgXqTQEiSkvU2/nheFSEj/D3eAlyrF/nhMmQSxlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761711344; c=relaxed/simple;
	bh=eNTHIbV0Jc6XcLUwn4foSc6mQmgj3PVadMfEd8y+Hhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ssKuu1i5muWjTsE5Atzmk8UDjXnWSHWXTVtpmQ1gY8Yr3QQdA3kwJA2EtO3s07BnmEbS7x80AZ+1i3g2JvRZeL8O7CwabptW3D04YGVF43j1/wo5R394aekFO37hre36ZUeofY7P/tgnW0N49xYuzzLaPS7I603Tj29hwx/YJTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4scja2m; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tK4BwkpAaJ/HcgbGYjFSwsc1kjwBYqciwtT6sc3caxIO3ar0XkoL9CYwOoCy1F8AOgyVjivl88lzhzikfZeiQJetQY40rHMtZazYC71x1k326y9Leh2uUYZ5bDsavs9iPbxn9QizXiQcuaSyswCZAjW04hwEa5VseoOAoCYAI1KOIcRrctCKqGblXDhTZpdL54r6VTMd0qY1GbnXpjOhD11ccHVywan4oTkMe6NR9sMbwiz0U5tEhdj8448YBQY8JXJQJzFmp3GdBDbf0hYtSIvu6ZvSNK5/aLNnZU3PBxtSMTUb1ddLRYZbbBFMEPZ3hdP15NdxIYnloMyOrP2RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0863RSbB5j6HEBTx3NeoOZ0hLYQ9bw3bpBR3+ZqS4g=;
 b=ZsIyUT90JUOcTwJrEwmUJK8FDiGzCJRn+xJH59+SCHKJscCcdF8ib6ZpwEVpmL6j0WT3FwCVjfF55oxsNr6/Gm6iII/fR/zr0CNcSau7NHri2HbtLDWMdU6c+7QpsT7VJQmBFLx+macnYZLwKDyFk9fkiq6/m0ZGCwWz7hyAbG34lmlO7vJyVLZqC6VXff52e1nsxmc1C/P4gjDoYjzHBAHH92xKjDCdZrTtOYHgQ9cSGAZ7D7W3wmQCaoxXogObU5croVZnDPK6BBUALCwqXD53VPtfmf9vXMrEXOYoChHZZL6YFqZ0Ai17tGPro2nzc/TVvWZ0OJENzpLavbdHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0863RSbB5j6HEBTx3NeoOZ0hLYQ9bw3bpBR3+ZqS4g=;
 b=u4scja2mx4yXyCMDtu1UyDCxmAz23nvtrjP6Un5AgL3+wLQgx1/rw7dkuthsNPL/WNxb7dgrjqs/MC1fTovdEE/QdzQv+7HsdkxhZs7MX/0mXEFwT7jhL1khbycriXeX6CMukImUT/p09n8+xKyA2xQju2C4m5SNSPezWTXUGX8=
Received: from SA1PR04CA0011.namprd04.prod.outlook.com (2603:10b6:806:2ce::18)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 04:15:39 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::c4) by SA1PR04CA0011.outlook.office365.com
 (2603:10b6:806:2ce::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 04:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 04:15:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 21:15:38 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 23:15:37 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 21:15:32 -0700
Message-ID: <d1dc82c4-19d1-4897-b4a2-438512969868@amd.com>
Date: Wed, 29 Oct 2025 09:45:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
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
	<peterz@infradead.org>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Ingo
 Molnar" <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
 <4560ffb7eab64f7b9c6f7eb2ad7430827e19f849.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <4560ffb7eab64f7b9c6f7eb2ad7430827e19f849.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: a01702b4-426f-4792-26ab-08de16a1d114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|32650700017|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NkWUlUVVhJM04zaFFVWXo5b2tUTVgxUXhMNXUrNm5WUnhIbUtJWEl3UlBN?=
 =?utf-8?B?dmlkb01RMm5EMU9FZzlIMVdyWlJGZzdaMFRUUU5oUyt6NjVsRjdDa3I3YzNl?=
 =?utf-8?B?WG9IRkVFTlM0MUZOTXZteFVIczQzdUM2UWRSazR2RjJqSkdKNUQ0SGhGRHZL?=
 =?utf-8?B?aFpLTkZyRmovekk1TFVYNThIRkNYZFh5Mjk3bXd2aXpRdVVZWFNUbms4ek1T?=
 =?utf-8?B?WWp6eU05dlAyOU15YnZJTE5xRTZMUDN2aE9YQzgxcEk4bWJSa3dTUWVSTE02?=
 =?utf-8?B?SzI4dStIZHJxTlo2YUZyWFdQT3Z6aERqcjNReXo1d1lXNGxjK3E5MEV3WnJD?=
 =?utf-8?B?VUhwTjkrZnVkOU8xT1FnMzZlS0N3RldsZkVxS3FOOEZmVktaVFl4eVQ0YVA4?=
 =?utf-8?B?VG15V2FtYWYzQTlIakFOYmc4R3pGdk9nQ1ZvZk5VYlVjMTlDZXFBMjJxK2px?=
 =?utf-8?B?akNKejlVVzJQbU90VWhGZHBrS3JOblJDWTJscFZvbkpYdEkrek1rRzN3bzJL?=
 =?utf-8?B?QnZpV2tISWRGajhKTU10bmJnZ1ZGNm51SDM1RjFTK3hmU09ZMEc2SmhuN1Z5?=
 =?utf-8?B?SXpMdk9nV00zQWhobkJWaXd5NGRMeUk5S3V2VlZLVXhTRFVweG1KMUFUbm1u?=
 =?utf-8?B?YldnSjRGRVJvZFNydFRNd3N5aDgxWWIxcDczbEpmeVRaSG93MG1YNTBQN1ZG?=
 =?utf-8?B?d29WdEtYVSthV0R5M3ZHL2pTV1dWb2FnK0VFdnhOT1BsK3VDaktSVE5nQlZm?=
 =?utf-8?B?bjFpaHNQVVVoSXNOWDRrYldack1hTHpsOTNRWWVoVHczOFdVWWhEV2dINWFP?=
 =?utf-8?B?Zk1RL1NBL1IrSy85SElaU3VQZDVtRXVnRUVkMU00djFaRk1EVFd0T2h5bW1a?=
 =?utf-8?B?VWpRcE5xY0Y1ZW05c0RoblZndWNyMS9oeVdpRlEwSmd5N2VRZmEzNGV4S2Rn?=
 =?utf-8?B?VEpqZXFZQW54dEpWOXJDY0JPMWUyYTUrb0ZRbVRwTURzM1hSbmpJemQ3ajVt?=
 =?utf-8?B?T1g0YTczMldsMjFyMHdzRC9IMlNzWWdEd0YrZURaZk1yWTFyWkNGT1plVlh3?=
 =?utf-8?B?N1dPUXpNcmdUYWViU3F6QVUySVlYNU9VaEJOU3BWektDSXBza2owZWtvRWxR?=
 =?utf-8?B?ZXhjSnZGam9ENFlxZ3U3WUJ4L3ZuZEV5cWdCYWIzUWNQdkhpeG9BbXpjZzdE?=
 =?utf-8?B?Y1c3TjJLUXlJTnl4YUpxMXNHRmIzcFlGRDZXR1FnSmtIamVTZ2xLbFVyMHJC?=
 =?utf-8?B?UDg2amNUc1Z3a0VoZ04xcEQvWHVURzZvdmtaTVowSGMwblZJeTZaNkIwVStW?=
 =?utf-8?B?S0lZUG9vT0Q0Y3JHQXoxT0ZYZUE4TXdKS3krdmVyY09lTThZZWIxcVR3YUw2?=
 =?utf-8?B?K3pzc1VEVld3Y01hd2VYME52Tnk2Ky9aZitZMWVMeDlXZU5JNzVsc2h1VHNB?=
 =?utf-8?B?RWpqK0F3Wk05MFovd1d0RC8ybzJPMk1Ka29aV0NpdjE4U1l2SStDQnoyQS85?=
 =?utf-8?B?b1FpTzBvcWlRY0NqY1VWb0xNeVovYVVHTWRubmdWTGxGVVA4T2lkWWFaamt0?=
 =?utf-8?B?QnhjdEEzeklZQjJka2lqS213T2E3SGloT1ZBZU1KUG5vRW9xNTRDaUw4ZzlM?=
 =?utf-8?B?WkQ2eGRKeWNSKzlvVnVKblZwM2Y0dzlZTnVnaUJISkFVV0FLN1RJMXhGdjNQ?=
 =?utf-8?B?Mk52eERtMElFRWdEWG1DKy9xcGdSeEI3WHAxRG9ER0ZWRTU2MzJnTXRhb1A0?=
 =?utf-8?B?QkpIVUY1SUM2WjdTQTYwdDhUM2p1RndJRU5oeitDMGFpai9sa09rSHp6My84?=
 =?utf-8?B?dFE5N1BGWXhCZ1BoelFsOXhZcHh3eGN1ait1ajIvcUFydFJKOUtKaTI5eDFu?=
 =?utf-8?B?VFRlRlpoSVJEaUFvTzBJVUk4WkVIMHhvR2ltVThKdVk4TzJqUGJvek0vVEFj?=
 =?utf-8?B?QUc0aGozenhPdGNzZTFGWVJ3TVhlVUI4TVhzUzBmcnY3RXI5SUMvdlRPaDYv?=
 =?utf-8?B?cU1pMFdMelhwQnowS1ZvN0FHYWQ3Mm1vL1pIczh3U0M1WHoxQVJ5cEZERkpO?=
 =?utf-8?B?WkFEUW1JVU5RVU4xNU9vbXBlZWlET2R3dHZhSmw1M0RnRTFYMDZwSlFsbXg4?=
 =?utf-8?Q?CtO8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(32650700017)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 04:15:38.5872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01702b4-426f-4792-26ab-08de16a1d114
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726

Hello Tim,

On 10/28/2025 9:00 PM, Tim Chen wrote:
>>>> +#ifdef CONFIG_SCHED_CACHE
>>>> +		/*
>>>> +		 * Don't detach more tasks if the remaining tasks want
>>>> +		 * to stay. We know the remaining tasks all prefer the
>>>> +		 * current LLC, because after order_tasks_by_llc(), the
>>>> +		 * tasks that prefer the current LLC are at the tail of
>>>> +		 * the list. The inhibition of detachment is to avoid too
>>>> +		 * many tasks being migrated out of the preferred LLC.
>>>> +		 */
>>>> +		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
>>>> +		    llc_id(env->src_cpu) == p->preferred_llc)
>>>> +			break;
>>>
>>> In all cases? Should we check can_migrate_llc() wrt to util migrated and
>>> then make a call if we should move the preferred LLC tasks or not?
>>>
>>
>> Prior to this "stop of detaching tasks", we performed a can_migrate_task(p)
>> to determine if the detached p is dequeued from its preferred LLC, and in
>> can_migrate_task(), we use can_migrate_llc_task() -> can_migrate_llc() to
>> carry out the check. That is to say, only when certain tasks have been
>> detached, will we stop further detaching.
>>
>>> Perhaps disallow it the first time if "nr_balance_failed" is 0 but
>>> subsequent failed attempts should perhaps explore breaking the preferred
>>> llc restriction if there is an imbalance and we are under
>>> "mig_unrestricted" conditions.
>>>
>>
> 
> Pratek,
> 
> We have to actually allow for imbalance between LLCs with task
> aggregation.
> 
> Say we have 2 LLCs and only one process running. Suppose all tasks in the process
> can fit in one LLC and not overload it. Then we should not pull tasks from
> the preferred LLC, and allow the imbalance. If we balance the tasks the
> second time around, that will defeat the purpose.
> 
> That's why we have the knob llc_overload_pct (50%), which will start spreading
> tasks to non-preferred LLC once load in preferred LLC excees 50%.
> And llc_imb_pct(20%), which allows for a 20% higher load between preferred LLC
> and non-preferred LLC if the preferred LLC is operating above 50%.
> 
> So if we ignore the LLC policy totally the second time around, we may be breaking
> LLC aggregation and have tasks be moved to their non-preferred LLC.

Ack! I have replied to Chenyu's response with an example of
"migrate_load" case that, as per my understanding, would be restricted
by this condition. If I'm missing something, please do let me know.
Otherwise, the intention looks good to me.

> 
> Will take a closer look to see if nr_balance_failed > 0
> because we cannot move tasks to their preferred LLC repeatedly, and if
> we should do anything different to balance tasks better without violating
> LLC preference.

Thank you!

-- 
Thanks and Regards,
Prateek


