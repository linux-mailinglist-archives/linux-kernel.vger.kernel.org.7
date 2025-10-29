Return-Path: <linux-kernel+bounces-875094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4FC18357
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 04:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 516583B7894
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395502EF662;
	Wed, 29 Oct 2025 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n6Az/6yG"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DEA2EDD50
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761710057; cv=fail; b=FKdCtZ50/FXDXXxp92z3nlq+j/uGVXLr3WyDq0kMseo6S+vcR69t6VB3eP1lk6FmswxOmNFpcVUuJrqDltG9PBG9i4BwqFO37Y1VfG1fvmapIAw7GzE+MzHgjm4Coq8M9sBsIyUso7i4fxU3WYnbZCqua1GC2iVZTNQIoRQ4Cb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761710057; c=relaxed/simple;
	bh=MDNq4UPMeLy8f0/1O22rGbkUEPSLk5g9p7YJRC82blY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UTCBhElZ/lF98ZQm+RVB/Qu+eVAlEUwcYAa6iY57b3cQFluWxNeuJ8iBXEYU4R90AHq6rjJ7TJCYJrLzuBIiwLpdkD/MKsVAQ8CgEDlQ46yi8I3OuON+MP2wrkwihzRNUj+rGZjNlCgGEZDnYvqvX4s5kwC8mwpGW4Z1N1qS/I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n6Az/6yG; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uf2bgIcUxANmsnmHQDUiIzGwT9cNZGfepKZQmEHK2ZnGxjkDMNOs3hzLcSdZdTBYE/WlndrXrb07auiJM6NoJzKOFhuDcz6UL+Jcooa7D8fJqmgEPP6kzRW6zaPfCYOrEZt4BpLkZQBr6Wjtv+PsFQyfZyBHnOCZ8FjAGEvDNmzSA6hiIs/dMhHuv/ex5Vxg0FXzoiaZV+veTCk7E1MPL9NMR/wcOO6+r45tqNuWnCy5orQPRp2VUTVWAS1aupiD2A7vxTlOouEfGI+2fNyyPG1Xnvkx/lwhTTuaQTv3zrU5ozoc4sSCSzNnXI5555j9IGSA9h0n43NUiRoc11nzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uG9KnCoJFkmsI1zPGxmLTXT1YI1mtbBOgN9pE8uPWg=;
 b=TNFivuB85evFC07n0qgIiGmpbhfe0z3TH8DOVMLAXd4ErcBfyX/KDAvPyJmmdIzCFQoL1qAJ3bmcNwjeAF0Gb8O88wE49aQnQySn9WZl1WN4fp4/k60oUmZmTsQhzdaaslI3yrXNyUk/nVQubYXnqTfCIPJfSI0KuuCjR+1l0DSsMo8bC7wXhnrMudxvVA/mkWRa4aA8wTR7Xwdt+ok6+62MWupB9sWUVuaLDN1z+sPePePLrH8NH7H/+0ClJ9Cj/2SlNgacDplshINaT+hc2yMUN1H+T5CDTiJh91DuEi/rxvSdYvChzOc4Hf4XbfKYBmeOQj7tHeKWIzpqgQVBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1uG9KnCoJFkmsI1zPGxmLTXT1YI1mtbBOgN9pE8uPWg=;
 b=n6Az/6yGw+3fnd+Y8u/nX4uTnN904EhAB4A/9qloNVfYeQm4WxNK4rH7mOM1SQd0h2IMjAjwOP/JDuOpGYKK5SA/kWx58GcYCI9vKdrbfG7Arabi+vEhEgsrJlY7HeJBR1uCrDvtTag/cEYaug+ZqSd+kUU+J9VjskX1bNjBZGc=
Received: from DM5PR07CA0113.namprd07.prod.outlook.com (2603:10b6:4:ae::42) by
 CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Wed, 29 Oct 2025 03:54:10 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::a7) by DM5PR07CA0113.outlook.office365.com
 (2603:10b6:4:ae::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 03:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:54:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 20:54:10 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Oct
 2025 22:54:09 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:54:03 -0700
Message-ID: <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
Date: Wed, 29 Oct 2025 09:24:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] sched/fair: Respect LLC preference in task
 migration and detach
To: "Chen, Yu C" <yu.c.chen@intel.com>
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
	<tim.c.chen@intel.com>, <linux-kernel@vger.kernel.org>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Gautham
 R . Shenoy" <gautham.shenoy@amd.com>, Ingo Molnar <mingo@redhat.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <d3afcff5622222523c843f5c1b023bfe43f9c67c.1760206683.git.tim.c.chen@linux.intel.com>
 <5cdf379c-b663-424d-8505-d91046e63c20@amd.com>
 <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <0a81b5be-6edd-4231-859b-0c6d06c61595@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: c5da4439-3828-4f02-0260-08de169ed15e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|32650700017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZUVG94Y3JBTWNCNkpDTFZzcDkrZmdwS0ZMaEJ3Yys2bWlOaHB5S2ZiZVNB?=
 =?utf-8?B?QjBmajJyVUIzZFoyYWFMM21VTlJvUEJUdkJCMEFHVkdBL2tlaWpwSVhWblNQ?=
 =?utf-8?B?Q1YvRW1vK2ljUW50MGltZCtCWFVIM2piaWJOcTRtSlhEaG85aDJNbEdVVGwy?=
 =?utf-8?B?MVBpSVYvbXBzbUU2QUhxT1lJc1FJaEZaZW9SRTltZG15b25mNlpHUEFKRjlw?=
 =?utf-8?B?Ymdpd1FaRk1FSTNHNXFyamNSaDdoYzl3S3Qvd2E1R09sSGg3RnQ1N2F4aDA3?=
 =?utf-8?B?bTBYQmdGQkR3ZDEwWHdZTHJDU2UzSTA2ZEhlU0JCcDNBcDliSGJMd3M5aW1u?=
 =?utf-8?B?YVY0WGN5YmFxZmFnNVQ0M3RzUGwvZHdWeEg3bUptTWprYytjTlFoZ1dKOVZv?=
 =?utf-8?B?amN4TFhJaVROY2tPcUwvdTF5MVhya2ZzSmxVa1RxTmYxdTNCdDM4SXpQcHM2?=
 =?utf-8?B?ZkdpYlJYenFRVUtsRGE0Q09KYmtJSVJpUlNIeGxmQWUyUkt1d2VVaWFZWWFV?=
 =?utf-8?B?Y2lzWW1ad3NhalFRSDdkWEVMMWlmRS9Pa2FlQng0K21FajBMMXdVYmZUMXRZ?=
 =?utf-8?B?a0JGa3Y5SWV4STY1a05WbE9zc1Z5U1c4TldNVGRGRzV1emVmcytFY0FWekVx?=
 =?utf-8?B?L0xxZ2taZ2k3STN2ZXlIZkR4djcvYi9lWHNnT1c4aFFIckp0OFdzZTI5YlNB?=
 =?utf-8?B?VU1rUTZhcThjSzJnaTZpSmhUaFVEczI2OW5TWmVBL2lpRk5Gc2R2ckh3ZjZB?=
 =?utf-8?B?YmJDWk90cHY3bE5LNzJzN2pCdk01R3Z1UnRpMjhVVy9PUHNXVnhuVWJvdHFy?=
 =?utf-8?B?OWNreU5ESCtLTEdxL0pabWUwUjdYTTRVQUxoWG1rZklhK2psOHNOTFRqRzRj?=
 =?utf-8?B?VTdDZmx2MzhDWk5RVUNOTnJ0dFFiWXR2eWRaY0l3dndlbEhNZyt0dXBacmJ3?=
 =?utf-8?B?Z3NCeTA1aU85YTFhVzBXOFcxSzRqMVpJaFZJRlJsR2tZQTN0WWJaSWFYQ2Zh?=
 =?utf-8?B?c3kyNFVMU1hxMk5kSDg2MzFxeGhFbEpZZUk4TzErbjJKT2NyUG9UNDhRVity?=
 =?utf-8?B?empwWGdEUnpwSUN0MkkxZ3Z0UElsMjZlWmY4RHhxWDcyblRpTWpLbTlGTEZX?=
 =?utf-8?B?Sm5QMGVKQTVaMTlCS3pyVGFkdER4ak03eGtLMWVPbVpPWTJlYnRnOVRLeHE1?=
 =?utf-8?B?eDh5ZUNHdDZSRmRobG9QWkJBdlU0YXVURmw5a3hLY1VxWHA3Z2VtRHVYTGRC?=
 =?utf-8?B?VklXYnh0Q2VrVHYwUVJNRGYwWldzOENmZjdBWnM2THBKZSt4b2pUZG51K3ZN?=
 =?utf-8?B?L1d4ckRFWDEyRU1iaGplYnNnd2hPTVAvcG1jMVpFdmR1MXNjUkdVd3RZSnJi?=
 =?utf-8?B?QUp1M2dQd3lMaVF0cGxGWXQyZ0NNVDBDR21sSzdLamErbGVSNzhhN3Z0cVgr?=
 =?utf-8?B?OW1rKzF0d1lXckR2UXhWSmUwdXp1MWh6UzA4c1hnOWIvYndxdW9GcDdWSHJQ?=
 =?utf-8?B?NU5uOVovR3B5bEVGc29WVGxPc0NRbUdwQ1NObzBMcjUwdC9INXVFc3F4VEho?=
 =?utf-8?B?MUZTVzZYQTRpaXJZcVpVZlZJemVnbmlUSFZSZzByS0t3YjNET01va1Y3S0po?=
 =?utf-8?B?VE1VUkROek5Ic2ZuL0ttRTVncTlXNkVlb2g1RStvQWpxUWwxcFNlUmFaWThu?=
 =?utf-8?B?eEpTZm04VTBDdWNCSU9JcnNKVDNGVGJCdHVhNG9CK2NEWUIrMHBsOXlrTXRK?=
 =?utf-8?B?MzI2c3lGczZWSkdQS1FBYUx0VTVUenBzKzhzTzZtcTB3ZGdlVVBDWlBkYnJh?=
 =?utf-8?B?Q0hEakdSRWszM2hKS2ptOFo0elN3N0d5WWJzZ1FLT1hhSFhIbXozOWJueGpO?=
 =?utf-8?B?YStYYVM4VzlQRERhUDR1V29lVFhiT2RLK1BSZTV6ZkNSL0cray9OMkh0TmQx?=
 =?utf-8?B?Z1BEeU1iUFhvWStTb0crRDczREgva2ZzVVg0WTlnUGNEZE1tS2x3bkdHWDA3?=
 =?utf-8?B?Mmt4blAvMklpam1vNTlPbGJzazJ4QUJSVlRGRHU3VDRYUUY5R3J2Z0Ixc0J0?=
 =?utf-8?B?MUQ0WlE0dnVERUFvR3B1TE13dHlITVF3NG1zL0tXVm5CMnIzV3BEV3ZOUUFq?=
 =?utf-8?Q?KU/Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(32650700017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:54:10.5637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5da4439-3828-4f02-0260-08de169ed15e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620

Hello Chenyu,

On 10/28/2025 5:28 PM, Chen, Yu C wrote:
> Hi Prateek,
> 
> On 10/28/2025 2:02 PM, K Prateek Nayak wrote:
>> Hello Tim,
>>
>> On 10/11/2025 11:54 PM, Tim Chen wrote:
>>> @@ -9969,6 +9969,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>       if (env->flags & LBF_ACTIVE_LB)
>>>           return 1;
>>>   +#ifdef CONFIG_SCHED_CACHE
>>> +    if (sched_cache_enabled() &&
>>> +        can_migrate_llc_task(env->src_cpu, env->dst_cpu, p) == mig_forbid)
>>> +        return 0;
>>> +#endif
>>> +
>>>       degrades = migrate_degrades_locality(p, env);
>>>       if (!degrades)
>>>           hot = task_hot(p, env);
>>
>> Should we care for task_hot() w.r.t. migration cost if a task is being
>> moved to a preferred LLC?
>>
> 
> This is a good question. The decision not to migrate a task when its
> LLC preference is violated takes priority over the check in task_hot().
> 
> The main reason is that we want cache aware aggregation to be more
> aggressive than generic migration; otherwise, cache-aware migration
>  might not take effect according to our previous test. This seems to
> be a trade-off. Another consideration might be: should we consider
> the occupancy of a single thread or that of the entire process?
> For example, suppose t0, t1, and t2 belong to the same process. t0
> and t1 are running on the process's preferred LLC0, while t2 is
> running on the non-preferred LLC1. Even though t2 has high occupancy
> on LLC1 (making it cache-hot on LLC1), we might still want to move t2
> to LLC0 if t0, t1, and t2 read from and write to each other - since we don't want to generate cross-LLC access.

Makes sense. That would need some heuristics based on the avg_running
to know which LLC can be be a potential target with fewest migrations.
But then again, in a dynamic system things change so quickly - what
you have now seems to be a good start to further optimize on top of.

> 
>> Also, should we leave out tasks under core scheduling from the llc
>> aware lb? Even discount them when calculating "mm->nr_running_avg"?
>>
> Yes, it seems that the cookie match check case was missed, which is
> embedded in task_hot(). I suppose you are referring to the p->core_cookie
> check; I'll look into this direction.

Yup! I think if user has opted into core scheduling, they should ideally
not bother about cache aware scheduling.

> 
>>> @@ -10227,6 +10233,20 @@ static int detach_tasks(struct lb_env *env)
>>>           if (env->imbalance <= 0)
>>>               break;
>>>   +#ifdef CONFIG_SCHED_CACHE
>>> +        /*
>>> +         * Don't detach more tasks if the remaining tasks want
>>> +         * to stay. We know the remaining tasks all prefer the
>>> +         * current LLC, because after order_tasks_by_llc(), the
>>> +         * tasks that prefer the current LLC are at the tail of
>>> +         * the list. The inhibition of detachment is to avoid too
>>> +         * many tasks being migrated out of the preferred LLC.
>>> +         */
>>> +        if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
>>> +            llc_id(env->src_cpu) == p->preferred_llc)
>>> +            break;
>>
>> In all cases? Should we check can_migrate_llc() wrt to util migrated and
>> then make a call if we should move the preferred LLC tasks or not?
>>
> 
> Prior to this "stop of detaching tasks", we performed a can_migrate_task(p)
> to determine if the detached p is dequeued from its preferred LLC, and in
> can_migrate_task(), we use can_migrate_llc_task() -> can_migrate_llc() to
> carry out the check. That is to say, only when certain tasks have been
> detached, will we stop further detaching.
> 
>> Perhaps disallow it the first time if "nr_balance_failed" is 0 but
>> subsequent failed attempts should perhaps explore breaking the preferred
>> llc restriction if there is an imbalance and we are under
>> "mig_unrestricted" conditions.
>>
> 
> I suppose you are suggesting that the threshold for stopping task detachment
> should be higher. With the above can_migrate_llc() check, I suppose we have
> raised the threshold for stopping "task detachment"?

Say the LLC is under heavy load and we only have overloaded groups.
can_migrate_llc() would return "mig_unrestricted" since
fits_llc_capacity() would return false.

Since we are under "migrate_load", sched_balance_find_src_rq() has
returned the CPU with the highest load which could very well be the
CPU with with a large number of preferred LLC tasks.

sched_cache_enabled() is still true and when detach_tasks() reaches
one of these preferred llc tasks (which comes at the very end of the
tasks list), we break out even if env->imbalance > 0 leaving
potential imbalance for the "migrate_load" case.

Instead, we can account for the util moved out of the src_llc and
after accounting for it, check if can_migrate_llc() would return
"mig_forbid" for the src llc.

-- 
Thanks and Regards,
Prateek


