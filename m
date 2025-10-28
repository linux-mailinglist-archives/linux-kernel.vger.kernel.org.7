Return-Path: <linux-kernel+bounces-872952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 729F4C12B16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D2D5635454B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9B2773E3;
	Tue, 28 Oct 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJAyp+07"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1468199252
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761619851; cv=fail; b=prvKklLHNyQLfsKigvmZz3CJQ1x9hyY0KqXT5SazRqcHsBAkRsuYCREIdal+GhZJaxk0doczB/1DeK4teN+DituNJ7K6SGI82miiWLSmL0YhbplFQ46/AoO8BGNoi8uW8+lEQeHrhWZ8YI3spnPXAilVe9qtlQC/ReGM0eqaqlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761619851; c=relaxed/simple;
	bh=wn8XlhWxTFbS47VMIFpC6TUkRyn9FqpNVdMGyI8vyTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DxVwpJJrRfkzoM40kGatSOjpAUcp73OzjbQ3S4LP23NCDrf064sKgo7SaddMJs2pOQHyZKGGhIxzKG+NRwxn/ltSg1jz8g1XKYRFsWVh+JUzxzGL0m/mRzeLrMj2szJfe8/tJKh8yqKDa+lzkii/G83Fqpvt00Ocb1dranAXr2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJAyp+07; arc=fail smtp.client-ip=52.101.48.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgP78febteO2dmPR67lfuQkYWlWGLWmhPWYRVywIYfuxMC5HEsi/Tz0xxLyXeIDpKSUmE9HzuIEBNh/k93HcmvVQ7+X41UtE8o95FOyEmGcZKlmp4k01Hgo6smm8rrdk+C/TUyPEIhh434F+H7b+n8w9UAQkaM+Oq2Tt9rA/2a1P+wPk41mHy1q4tp6fhcBm2581cXhdvTV+GD10wSHZj09QNqiNy68oeXQHJmDZ5eU9hNIsyGt4BG9+DCEdxfIPVn2CTHj2pw9LztS0on5HmbWkc6WrWLmEP7xnhEpZInasIq8Q7iJIF+JEPpQHghN/Hivkk/D7Rw186YVp/tDo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiJTkXAWZ0em/lkxKN8iAmF3MpVMPdtgFWN64M8jXVY=;
 b=iR9ui6uvDKrAMtSMdNfmslIqAUgEvkkMR3Z76ZyDU2M6ANrSOPE0dz4iIm3rnFlwkBMrSR95ZVMEwSM9ECEVyp7It67TVQALrArwgShr7LDHyZFiHddPLSEE7Ak9uZX1A2K47WeVkYBy9wYtDhhDKzwSxMYVWCej1LjXIPmrppko1Y7BAMgq1LkcM7SJHGlVo5qfA0BIfiGBVngL7hdTP18tnetxjR9Q8IJ+b4MDjWHKvzo1BbKDdZ5nSaB9UHLZv55Poi691FXq5qunUt2zvLyDmPwK6f5ta7VFA5jnlS5acqOtXRC/sJa7yXWgVvcwKaUJME4usnLF6zZs2LwxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiJTkXAWZ0em/lkxKN8iAmF3MpVMPdtgFWN64M8jXVY=;
 b=uJAyp+07ArV1xGA0J3Oso68WckwygkcTyJ/S6Z6LVPyWPZDplsObwxpce+m98lMSX69yvCTMwrOkD/63J3p9+RevDlEnGTxAIx963ssyhqlKYkhitpCezFxh36Ej6jUXk4u0UR2feWbhHGkh4p9qXlXmzoodbHuCJaMoKH06+eE=
Received: from PH0PR07CA0015.namprd07.prod.outlook.com (2603:10b6:510:5::20)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 02:50:45 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::c3) by PH0PR07CA0015.outlook.office365.com
 (2603:10b6:510:5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Tue,
 28 Oct 2025 02:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Tue, 28 Oct 2025 02:50:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Oct
 2025 19:50:44 -0700
Received: from [10.136.37.11] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 27 Oct 2025 19:50:38 -0700
Message-ID: <0eb2cb1e-2076-4165-9ad7-aa775ab3205c@amd.com>
Date: Tue, 28 Oct 2025 08:20:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/19] sched/fair: Record per-LLC utilization to guide
 cache-aware scheduling decisions
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
	<yu.chen.surf@gmail.com>, Ingo Molnar <mingo@redhat.com>, Adam Li
	<adamli@os.amperecomputing.com>, Tim Chen <tim.c.chen@intel.com>,
	<linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Gautham R . Shenoy"
	<gautham.shenoy@amd.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <7684e7381c61a2a0d0580790340d4daa5349e48c.1760206683.git.tim.c.chen@linux.intel.com>
 <5f97134b-71b6-44fb-85fd-5cff6725cf9c@amd.com>
 <ea646ffe-908e-4730-8b3a-69c9318ad5d0@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ea646ffe-908e-4730-8b3a-69c9318ad5d0@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: c292c651-2ed2-4378-99d8-08de15cccac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|32650700017|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU9EN2QvV1NTZGoyNFB3V2hXNnR2M2ZIWkRUc1FmQWFqaFhtMHdwWXQ3TUR6?=
 =?utf-8?B?cnhDVGxlRC9DdGtqUnRNMDAzcDY1Q1NwWTBiOXc3U2p1NlZRRjFlSHdiSGF5?=
 =?utf-8?B?aVhUUG0yUVd4aTViZEpQNlY0eEl0SWdFcjVxOUhMVEdJTnFIMlFDTFR6Ry9S?=
 =?utf-8?B?Z1dPNUtVdmduNnkrb3JBNkZZL21rcFlsUEdsZmNIZG9scGozbmRFdDN3UkJ1?=
 =?utf-8?B?TjB0SHZ1Yk1GNHllc09HT0VmRWhGMzkyRkcyeGgxL25oaE9DOXFyaWZBSTRU?=
 =?utf-8?B?VTJ6TTlkV2owOTVUa0JLRGIyVnJwQ1BrNmh4KzlESkxaRTh0NGR3WnpURnBB?=
 =?utf-8?B?ZlBPZ3FxWXQ0bENtbTFSZVRrRXBBVllhTUhaU1NMZDFRcEFqKzhTRnBVOXY0?=
 =?utf-8?B?MzM3QW9aTTFwQmI4bWxGVXlhZDNBYkpKS3BraVVsM1VuWXk1bW5EYTJ6V1l0?=
 =?utf-8?B?NWdoaWRxa0htMmEzNS9oZERMYlNRYW1Jck1QeXlSWXVHaVBBejd5QWx5REY1?=
 =?utf-8?B?U2hlZEEzam5JTU93T0pnU1A5bncwSy9hN2lFRjQ1VythU0FmQ2ZVSklUek1H?=
 =?utf-8?B?T0ZubWhXc05VSXBPVWlsd2dNZFZiZzZLZ01ZQXY0MEFvMEYzczJGYzYzbisx?=
 =?utf-8?B?RDBVRmMzZDJVckYrOGNQemFiK052dERCMEJ6K2dYczVyaTIrQTNpdG8valVP?=
 =?utf-8?B?NlhnekJ6eVRtUnI1THd6K1YvMVRnckF1UnRISnBCYkJKNHRMQ3E0T3Uralkw?=
 =?utf-8?B?eFpObEw5aUdoRVVpVXQ0SkwxQXZ5WU1TdWRybVYxeWxFNDVoZnNwaUxqQ01O?=
 =?utf-8?B?L2UyazFNNm9SYVNCSUxrbEQ2OW15MmdOdUJCQk5vc0Z2UFhkb1h1alFOSzRS?=
 =?utf-8?B?RUVoajNpWFZ2RlVQR1RROTg3QlFlZHNlRlZ6d05qNmlhMGFZVHR5NmdFU3JN?=
 =?utf-8?B?RFovMUZCaW9IYThUYWJlbnAxalR4VHk1ak5sT04xT1EvaUtzcGQ1VlVGaHR3?=
 =?utf-8?B?Um5DeC93ejF0ZWZQVS9IVjNOVnB0ZW5qd1I3NmtLR0hyZlRBSUlpUSt5Z1V1?=
 =?utf-8?B?TFBERk4wbEJDaEp6RkRnR3dyY1ZHSWdYYmJsbVQzUUNZNm9qeGVXdHNOL1l1?=
 =?utf-8?B?WVNIMHRQVDUzVEV2K3BwMlQvY0Q1Z21EV3ZsNlhoN0R1dktCVWdOUzR4MkdG?=
 =?utf-8?B?bGRhYm5nODdhbTZRZGVWSjdWNStuLzVseTI2ZDhnR0xOTDRJWmc2dE9sR1Rl?=
 =?utf-8?B?bDR2cVVWTStpWDhOT0lXTXVaa1hGdkRVcjdHdWl3RmhZYlFMaHpMR2kwa0l0?=
 =?utf-8?B?RXZURlI2YlBKYVdFTkpScnY2RklXMEZEam94SjU5WGZMaVJPeXpDZEhHY2sz?=
 =?utf-8?B?VVNyMmVZbE5NZXVINFljemlpUkU0Qk0vTkx2TjEzelVxMTE2ZVpobDEwTGRP?=
 =?utf-8?B?eERlbllxRi9hS2JFdzVXOWwza3RHTTdzNWJMZk04bHNXMEFEVjFJQ21DUm8y?=
 =?utf-8?B?VkUwY2MrWkdva3pDdlRxL1FlbW5JR0tuS016eS9IY1JCaVc4TEwxWGcwT1hr?=
 =?utf-8?B?NVVMWEEwRktialZZTkUxL0VSbEpTUnB3Rm9SYkRIb2NURkJkUlArVzBHd09R?=
 =?utf-8?B?R1NoL1RnSlA4YXJBdXV2cUZVbHRjUU9TWCt0a3Z5azdHWHNEUGZVYU9XY1Jt?=
 =?utf-8?B?ZGNRai9EUjVpNkxESHJCU0dBbk4zQnF6OHJCVWJNTTkxRHhlSksvanR5dkxk?=
 =?utf-8?B?ekR5NW1EN0RXK1duN1E2UldYV0FONk5rOEVKWGFHSDFJV1NHdDBjMk5Ua3Ny?=
 =?utf-8?B?WjdRY1NZVStLTlcwNURDU21tU2EvenNCZmJmYm1LOUxQMFRuanlGWVk4NmpD?=
 =?utf-8?B?NmRZeGwxQjJWTS9uYVJFa0MwaTNSSTRLYndNNDM1WDdqVGI0OUtGMVloSzgy?=
 =?utf-8?B?Q2NkOEJuUGZJdTFZZ0VKUkpPRTVIK3A0cjA3eWoyUmhJalNQNE1NRWk3SnQw?=
 =?utf-8?B?NlRDZkdMdW1GZmwwMXRLeXRmcFUra3RNcFpuZlRFVFcyUE1UWlRVSVU5MDUw?=
 =?utf-8?B?MHo1cTJ3eWtVcFJCczN3ZWdKdFloeTZFRXlSZEk0clpCWW92a0NIdThOMDVn?=
 =?utf-8?Q?E7tY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(32650700017)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:50:45.1449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c292c651-2ed2-4378-99d8-08de15cccac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

Hello Chenyu,

On 10/27/2025 7:37 PM, Chen, Yu C wrote:
> Hi Prateek,
> 
> On 10/27/2025 1:01 PM, K Prateek Nayak wrote:
>> Hello Tim,
>>
>> On 10/11/2025 11:54 PM, Tim Chen wrote:
>>> +#ifdef CONFIG_SCHED_CACHE
>>> +/*
>>> + * Record the statistics for this scheduler group for later
>>> + * use. These values guide load balancing on aggregating tasks
>>> + * to a LLC.
>>> + */
>>> +static void record_sg_llc_stats(struct lb_env *env,
>>> +                struct sg_lb_stats *sgs,
>>> +                struct sched_group *group)
>>> +{
>>> +    /*
>>> +     * Find the child domain on env->dst_cpu. This domain
>>> +     * is either the domain that spans this group(if the
>>> +     * group is a local group), or the sibling domain of
>>> +     * this group.
>>> +     */
>>> +    struct sched_domain *sd = env->sd->child;
>>
>> Was this intentionally done to limit the update to sg_llc_stats to the
>> load balancing period of "sd_llc->parent"?
>>
>> Can't this be done with update_idle_cpu_scan()? I believe it is more
>> frequent, "sds->total_capacity" from caller gives you the equivalent of
>> "group_capacity", and "group_util" is already calculated as "sum_util".
>>
>> Checking "sd_llc->parent" there should be sufficient to check if there
>> are multiple LLC domains or not. Thoughts?
>>
> 
> The original idea was to calculate the statistics for the CPUs within
> one LLC, and set the tag for that sched group as well as its sg_lb_stats
> (but not at the sched domain scope). With this flag set in that sched group,
> we can perform some comparisons in update_sd_pick_busiest() to determine if
> that sched group has any tasks that need to be moved to other LLC sched groups.
> If we do this in update_idle_cpu_scan(), might it be a bit late for
> update_sd_pick_busiest()?

Once I got to Patch 10, the location of record_sg_llc_stats() became
more clear w.r.t. the following call to llc_balance(). Thank you for
clarifying and sorry for the noise.

-- 
Thanks and Regards,
Prateek


