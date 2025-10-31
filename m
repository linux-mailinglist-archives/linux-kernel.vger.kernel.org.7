Return-Path: <linux-kernel+bounces-879465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E5C232F9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718F04EAC94
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A636025F7A7;
	Fri, 31 Oct 2025 03:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLE8HtW8"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B6F433A6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881594; cv=fail; b=HMHAm9V/DtYWINSGFeWNkmVZ2Er/FuPSWyhMi5Jh8lJby3tVJHYg2oha79h68R2khTqijUs7P4ElzZ4T2i1FP3y3zI28nMYy4EEV3a+1TvIaCDZ4YmDqazyAHVgA1XZHmEuOK3x8N8/eI8ZMGLz5UMsLrDOZKce0oXxpnAViPoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881594; c=relaxed/simple;
	bh=HqHZKJCAJa2P3Nu1yaszkf4rO1XWEX54jUrAWR+eIpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jprFLWRHjwJM3wo7e9ssyGvlowWdkr2K0IBOfemQmxqqwiUyeqLNs+tZ6BoUUC1p4qzqxtS74mcUWaZxclfJd9WDgymOXlbRXNQKzfzInvrRbJlMoZ5yxUpYU4/F/9ixFs9louJEkWR+t7sKgcISpQruzhEilzKv+51vDPbVw0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLE8HtW8; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEoBjZ7zJ/S5itC8rhQdmIWIAegE7EboX+SZaSM4EQSqzqZ9L2IXTKQfaLkJnoxEHLmDTNIO4LoYjJyn/O5A7yd/eUZbULuyiU8qkU75dBLAmjlyDDmC6U6hOd2aKk7fH7Wn0O7v+Pb4J07sOHWRm65vlz2PCnpZV5JqG5m44I7suWpHzZFwBaHp3wy9VaySSu6u2lgCfueKh1LkKOWBPHieezI36A6ILSf9vnT7C6+0uigXGrPYfqup3LnQc0H8B/dxjNWt2ZpOs+7dt9roEuNapmsGCimJIH5v77rZm1XqdM0VKRyn1rj0iYzikeVuX/JglV7kcBULzVFwaegWvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSCgbelBhc8xam6X0c0gYoNtPkIdKZcf28CdxjSjHKY=;
 b=ECj1pHqfXPljD/tlqLkbu0agZC6Lx74swBG9mool7dtm/rX4w9yWKHhLalNOcLDjP/s2TAXn0Q5m3QTpTs9oIYGYk4b0UZ8Vl+bG9HGrb/ZprLv6tvmKxMw/LGn7fuy+Amlxuwv8sDmmv9+McYVwA3JtuHkQOGyUTPVHIbYBSruoAh5KEXtLTJLgoqRYsVzgkywoDmbRcuF2YYmpX0sexyUQmksyuOMCESMy8EcWXdv2CYy4sDhlVpgg8r3j5hd7i4AcX8rYF1GouXgvsRaox88cyN/MruKtjEhVOLS6y6K+WcfZNh1QxGKFO5tw/0i/sBuqDB+7XLXzIacEhnljig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSCgbelBhc8xam6X0c0gYoNtPkIdKZcf28CdxjSjHKY=;
 b=lLE8HtW89/Z4pmAruGs7HgNMqlaiGgkVKn+xgbj0rdt8W/1DN1YflARnfrEfcUkN3h9TiNXtx1M6WRKcyBYDGld55tRg/igoNqwa7GbjKLvOxjWOETL0c92scpaHpMlhRwZs9+liRYPt/+SodWEKz8Gp42cokb6KZAdv4P+joEE=
Received: from DM6PR12CA0024.namprd12.prod.outlook.com (2603:10b6:5:1c0::37)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 03:33:08 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::51) by DM6PR12CA0024.outlook.office365.com
 (2603:10b6:5:1c0::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 03:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 03:33:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Oct
 2025 20:32:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Oct
 2025 22:32:13 -0500
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 20:32:07 -0700
Message-ID: <c67f70c5-1082-47e7-8270-f4b8ae05eace@amd.com>
Date: Fri, 31 Oct 2025 09:02:06 +0530
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
 <2c57d76f-fb31-4e1b-a3ce-ca13713e1b86@amd.com>
 <ebe994addb5624089db71df8fee402a664f8800a.camel@linux.intel.com>
 <53f9a8dc-c215-405b-958b-9cdd326dbfe3@amd.com>
 <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <c85e242d55da1f12419e2c2dc2bfa3fc942a848e.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bec0b28-0e15-43cd-c957-08de182e3534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|32650700017|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVNQSTY4UGNsMDVGZk15b1Q4ZThMTlpPWmhsQ0tva1R6dXgxWnl6NDkvdDlS?=
 =?utf-8?B?dDlwQktETkJpMWdlRm5YV1hmWlNEV1Z6S3hNaUU2NDNuNTQ0MkFIWlFKZ1l4?=
 =?utf-8?B?S0IyWTNTTFduUUhVUm5WRFVzYzV0VGFpU1ZlQWQxSm43V2FpVGZnd3VBMFN4?=
 =?utf-8?B?L0c2Zk9sYVBhcjQwOUNDcXZPWndERmZjNitoTXNNeTZ1MVNJWExpOVVQQytY?=
 =?utf-8?B?ZjJxNDUwdlRnanNUbHJmNHp5OGhDKzFmb0pPTnhYNGJWTHphNFZCQWZpY1Ex?=
 =?utf-8?B?VlNuYWxjWU15cisyZGoycW53dEVZbmxYMWV6akdzZEVTVW44UE1VZEpnM2Jj?=
 =?utf-8?B?QXFnUnRCR2k1SFFpcks2akJjZEtxNkEwWGpQNVMwMmFXZGlucXJ5OGliOVJ1?=
 =?utf-8?B?bHFkcGdFdlRhVXpxYUwrUytGMnpLWEJadnJHUkxDSTVYQlBQL3h3aTJKRnB2?=
 =?utf-8?B?aGNFSWdoSHRLQk1xTVpjbG9PZ09ucWlFTFVHOXQ1cjduQ0p5TWtWazY5MjNn?=
 =?utf-8?B?Z3kvVDZ1NnhUbzZqaUVKZjRaNTQ5em9DWWVqczVpRDJPMThzWlRNN3hOSGlj?=
 =?utf-8?B?eVU3b2xXSjhmRDJJa1JLRGhtQ1QxSSs5VkZESFUyN0tISGs1L2xaYnlPU2l2?=
 =?utf-8?B?VjBLeER5QUxLNXpBK0ZoV1F0QkFnTUQvbFV1OS9BVk5GUnNQSnBVd1QraGdh?=
 =?utf-8?B?UmxORERtYW1NdUVRdlpDUzJBdEZlamhQVU9WcW9VMW10VSsyaEFIbW5NQjhh?=
 =?utf-8?B?b0FQbVgrVjFWZFFONTlreDhvREs0ZmwyaEZmZTFFM210Y1RlRjNJZitxMHRE?=
 =?utf-8?B?UXJQdXBmbm4rVmhCQW45T1YzZDhodi91bjdGdW9EZWVqTnZrbmRhdkt5MVd1?=
 =?utf-8?B?TnFUTEluUEFMUmRhaitUY3JCSnZUd1lWc0tzUWtaSFEwUDhEd1k2SGpXbEx2?=
 =?utf-8?B?RE00S2VQUjJUZzh2dVFObGpndGdlT0gvR0c5L2YyUGpYMnRIOVNncWFBT2Q0?=
 =?utf-8?B?NFduSlAwczV6RmJaM3JJTFV3ajhGL3RmYmYyaGh1U0Q3ZFhJMjNIMHhLVWxS?=
 =?utf-8?B?MDZMWTRDT0R4REdYT0Y3L3I0RUlIdWZsZms0NkQvelhxNE9JNmdUM2tud2p1?=
 =?utf-8?B?WjhhYmRDQnBjRmlOR1JCbjhUYWhoQ1gzV2NnYk9ndmdPdVZFZTlTOUlqdnRC?=
 =?utf-8?B?bmF1OEhCS0VDQ3cwUVdjKzdyVVBzemhKNDBxY2JpTUdvOUpSUVl2U3QwOUVx?=
 =?utf-8?B?dGh6L2Y2bmJaOGZRZ0ZZaGdCNWNwWDFSRGdYZUd1UGZRemFaV09kOExQdmdX?=
 =?utf-8?B?YnBFM1F0MGoyd1RLMHVTVDE4OEJteCtFOWt2ZHN4bE5WVlJ2TVg4cTZSR2lQ?=
 =?utf-8?B?YVFRdkJkM2RFaDFBTHlsU0FBMzVWa005WkJTYmNobTM0SW41ZEpBY3JUM1JX?=
 =?utf-8?B?OVBIMUxWQW0yZzVJTkUrZjkvS2FubGJ3WElWWEdPYnVmaEdYUTFUTHBJQXRR?=
 =?utf-8?B?eUdHNW5mU0NQTEx2QlJjVW1IMnBGZnoxNThlajRQNUFBZmZ4N3lLbHAyQ1hp?=
 =?utf-8?B?UTlCYWI5U3p1bjVMOG5Bcjl3bHdxV0g3bWQ5RmVrYzN2bVpKamZ4TnBRekkw?=
 =?utf-8?B?UGMyaFJCMmNLcFVPREI5UnBGUEc2bnNJWEhMSmsybHBFeXMwREZBUFR4NDVQ?=
 =?utf-8?B?TjFtcFpnL3VYRUd0eFFwcFBXMmc5NlU2b3Y4aGhpZGZXRCtrREtZb0tCWjRo?=
 =?utf-8?B?d0pzcHJqK1FwSHZBUGl1NVM1WS9hTzhpOU1OdTJ3RzEyNnl4dzNrUlFFUTdv?=
 =?utf-8?B?d01lQWxaU0VFdHBmMTdHQWZGNkxqLzd5a1k2UWtEK3A4eFlSVHEvd2Z4TVh5?=
 =?utf-8?B?UG1hZDUzWjJWT09jWVljY3dQUVFCTEV3Vks5WnovZWhzNjBySjVCY1A2RmFM?=
 =?utf-8?B?WXA3b0p1YkZmd3dGbURTZFd4anFRUmJPVFJCWXZIMlFUL3p2U096THpwNFNK?=
 =?utf-8?B?cXo4NFVFQ3BReE1zYmJ6NlowRXU1eVArWjlhT2RSQ2NERW5XbWlBNlRZeVlj?=
 =?utf-8?B?YTc4V1BidVFYdDE0bU1LaDgzcURETTdXaEcyOGh6VGVpanVTZkVMMU1oTm5R?=
 =?utf-8?Q?pmrs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(32650700017)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:33:07.2604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bec0b28-0e15-43cd-c957-08de182e3534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

Hello Tim,

On 10/31/2025 1:37 AM, Tim Chen wrote:
> On Thu, 2025-10-30 at 09:49 +0530, K Prateek Nayak wrote:
>> Hello Tim,
>>
>> On 10/30/2025 2:39 AM, Tim Chen wrote:
>>>>> I suppose you are suggesting that the threshold for stopping task detachment
>>>>> should be higher. With the above can_migrate_llc() check, I suppose we have
>>>>> raised the threshold for stopping "task detachment"?
>>>>
>>>> Say the LLC is under heavy load and we only have overloaded groups.
>>>> can_migrate_llc() would return "mig_unrestricted" since
>>>> fits_llc_capacity() would return false.
>>>>
>>>> Since we are under "migrate_load", sched_balance_find_src_rq() has
>>>> returned the CPU with the highest load which could very well be the
>>>> CPU with with a large number of preferred LLC tasks.
>>>>
>>>> sched_cache_enabled() is still true and when detach_tasks() reaches
>>>> one of these preferred llc tasks (which comes at the very end of the
>>>> tasks list), 
>>>> we break out even if env->imbalance > 0 leaving
>>>
>>> Yes, but at least one task has been removed to even the load (making forward progress) and
>>> the remaining tasks all wish to stay in the current LLC and will
>>> preferred not to be moved. My thought was to not even all the load out
>>> in one shot and pull more tasks out of their preferred LLC.
>>> If the imbalance still remain, we'll come to that in the next load balance.
>>
>> In that case, can we spoof a LBF_ALL_PINNED for the case where we start
> 
> In the code chunk (with fix I mentioned in last reply):
> 
> +#ifdef CONFIG_SCHED_CACHE
> +		/*
> +		 * Don't detach more tasks if the remaining tasks want
> +		 * to stay. We know the remaining tasks all prefer the
> +		 * current LLC, because after order_tasks_by_llc(), the
> +		 * tasks that prefer the current LLC are at the tail of
> +		 * the list. The inhibition of detachment is to avoid too
> +		 * many tasks being migrated out of the preferred LLC.
> +		 */
> +		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
> +		    llc_id(env->src_cpu) == p->preferred_llc &&
> 		    llc_id(env->dst_cpu) != p->preferred_llc)
> +			break;
> 
> We have already pulled at least one task when we stop detaching because we
> know that all the remaining tasks want to stay in it current LLC.
> "detached" is non zero when we break. So LBF_ALL_PINNED would be cleared.
> We will only exit the detach_tasks loop when there are truly no tasks
> that can be moved and it is truly a LBF_ALL_PINNED case.

So what I was suggesting is something like:

@@ -10251,6 +10252,7 @@ static int detach_tasks(struct lb_env *env)
 	unsigned long util, load;
 	struct task_struct *p;
 	int detached = 0;
+	bool preserve_preferred;
 
 	lockdep_assert_rq_held(env->src_rq);
 
@@ -10268,6 +10270,10 @@ static int detach_tasks(struct lb_env *env)
 
 	tasks = order_tasks_by_llc(env, &env->src_rq->cfs_tasks);
 
+	preserve_preferred = sched_cache_enabled() &&
+			     !(env->sd->flags & SD_SHARE_LLC) &&
+			     !sd->nr_balance_failed;
+
 	while (!list_empty(tasks)) {
 		/*
 		 * We don't want to steal all, otherwise we may be treated likewise,
@@ -10370,16 +10376,15 @@ static int detach_tasks(struct lb_env *env)
 
 #ifdef CONFIG_SCHED_CACHE
 		/*
-		 * Don't detach more tasks if the remaining tasks want
-		 * to stay. We know the remaining tasks all prefer the
-		 * current LLC, because after order_tasks_by_llc(), the
-		 * tasks that prefer the current LLC are at the tail of
-		 * the list. The inhibition of detachment is to avoid too
-		 * many tasks being migrated out of the preferred LLC.
+		 * We've hit tasks that prefer src LLC while balancing between LLCs.
+		 * If previous balances have been successful, pretend the rest of the
+		 * tasks on this CPU are pinned and let the main load balancing loop
+		 * find another target CPU to pull from if imbalance exists.
 		 */
-		if (sched_cache_enabled() && detached && p->preferred_llc != -1 &&
-		    llc_id(env->src_cpu) == p->preferred_llc)
+		if (preserve_preferred && detached && llc_id(env->src_cpu) == p->preferred_llc) {
+			env->flags |= LBF_ALL_PINNED;
 			break;
+		}
 #endif
 

-- 
Thanks and Regards,
Prateek


