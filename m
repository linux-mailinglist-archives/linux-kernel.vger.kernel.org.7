Return-Path: <linux-kernel+bounces-800437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C5B43797
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C87A3AC287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221C42F83BB;
	Thu,  4 Sep 2025 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XeJuNlAQ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66597081F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756979479; cv=fail; b=cLpsu42cL/u8nCYnRPqnDmOU7A5WEKexDZ0aHjsKZEnH4i2LNG8v4LGWbLbX0qU7REdva3/TV25vV7AcoMsV7Xfh6NxnyD3MEw0Ephvtdq2abx9GbIlOcNgMKKqLFd0LcR4FIBbMQkAu2sxnpcCcvisO6Nwt4yZCktoR0XWfdQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756979479; c=relaxed/simple;
	bh=DTanzjedMQvq7HJUvPKrJbQbFUza0xc1VkAr4ZhZctM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CLc1upfkY47Zmr+923WlxnbfWaTdtMcdzdZDl64LdBNQ9kjfYDDCAW/N1ddeFTCGXxPtw3+axhzOW6UUELMqA8lYDcYHTZj1z0XntyLC8ctzRYsbmCoStklD1fMnnMf4T4emLkerueOVncbmQShpyLHk4cBUYu8B2kCumrNBjPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XeJuNlAQ; arc=fail smtp.client-ip=40.107.223.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMFtuxIP3mweqAApXKnz42w7pQZEPoCdKSGOgV+jvuqdHldOMNntbHyOMasXFRbAVUtsz7Zk63ZTjqMTj52Pd/gBVEnDTUinby/LJWJF2osic8mOCAQbQNy2FI2hHuTjVDAjH5nXJxntufcBuUZcAACKkj59SYmWqS9b09BPLMEoJMs3Hs9ZmG1mGXHXdfJHaQCrFdEjgiPc4mNE9HSkdW46kbuXiN4CtVtBOELgArelf7j+X9GdEZ9CG5IyfJjP052po1rrVTlYtNlkF+jBTwSn+F8BA7IFvA46yeMy8ueOhQ7n1RyLrIU8zE617xjUk7kFGDx2hHsl8MxbAXLXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSGevmBJrEhMxXi7RXKCig6pCt1smPNNkXynHlCG1Gw=;
 b=OvhlLHTu15HZLum/N9jgHudp3NsEikL3HVlhUDDEMI6oRMLDa3ys4ce/smcwh7dFXDa4A/Q37DOQQIgfT+lgAO+eYfkZ74ROkx5/foVchrb7W49z8owPvgAmaReF3WcL5851vm7UKvYX+uLk0VUPt5CJSSQGbv5SjtzMFVsuCoXU6Jmy16vXldlex3AJ3PmUUD1gSjgSt1yLI43rtEtSIjwVHPHEjLdWoBEsWqaiH5v59fHMvfLK23Hc81M12dfAaHPPqXw/bssBfYJ6cI1TtqF2sEQbITBKzz74T6cwvvavc0pbMKLtdV49QdttJYpCBG5gd/y0PVu0U7ceKx+i2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSGevmBJrEhMxXi7RXKCig6pCt1smPNNkXynHlCG1Gw=;
 b=XeJuNlAQfjLIwdtXHvNEPcTp/0uthfKP9bsyAJHKO42XKz76BW6CIkAr9oCNWhhHOi9ZhOhgE4i/sLNTCgWKhjiNawRXmXXljcNq3dmBHrzHSlwUXMRzYCBpc6jI0NzpFOEpL9ucGAI4Z3z/Z5SIxcywbVqipUdHM6NZcs/sKyo=
Received: from BYAPR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:c0::16)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 09:51:13 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::b6) by BYAPR05CA0003.outlook.office365.com
 (2603:10b6:a03:c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.7 via Frontend Transport; Thu, 4
 Sep 2025 09:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 09:51:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 04:51:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 02:51:12 -0700
Received: from [10.85.34.65] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 04:51:07 -0500
Message-ID: <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
Date: Thu, 4 Sep 2025 15:21:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
To: Aaron Lu <ziqianlu@bytedance.com>, Benjamin Segall <bsegall@google.com>
CC: Peter Zijlstra <peterz@infradead.org>, Valentin Schneider
	<vschneid@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
	<linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>, "Dietmar
 Eggemann" <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>, Chuyi Zhou <zhouchuyi@bytedance.com>, "Jan
 Kiszka" <jan.kiszka@siemens.com>, Florian Bezdeka
	<florian.bezdeka@siemens.com>, Songtang Liu <liusongtang@bytedance.com>,
	"Chen Yu" <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com> <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904081611.GE42@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b38e332-be12-494e-7f55-08ddeb98957a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWlpcUlvMlpoTUJMNVRpVy9DNFNrZyt5cWhvQ1ZtZWNFRExGdmRWZzloMXE2?=
 =?utf-8?B?Nm1XNDZ5REgzNVRTOHpPalBWOUJiZzJhR0R2T1ZrOFlYcWd6anlXdW5remps?=
 =?utf-8?B?Tmk0amNHS3JlTDYwQU1xSkh5VVlRbXFzcWg3cENCRWJkTzlDSy9hODM5a1FW?=
 =?utf-8?B?S1RDdm1LeWdTL2NUTzNSVlpta2RRdW9VOE9Kdm1yZlM2MmtWRVM4SnIxSXRL?=
 =?utf-8?B?V1BEekdJTlZITzhmaStYYUZoRjN6b0dWaHZJYlJzdSt0aTh1bEwrd0NSNnBy?=
 =?utf-8?B?SVFjNlc4TC9wYm1UdDhRMElLdnVITnVVUlN2Q0RBQ3NTTDFSVnBSUmUrTTAz?=
 =?utf-8?B?M3ZkV3g1TFh2S2YycFc3K1hpd0JYaXZJek80NERBT05Qd2pGRXE4emFCZjRn?=
 =?utf-8?B?Y1ZBRG9laEtiOXJObnhNbXViRHg3WWU0aVJrbUF2dmxmUkw0dnFkSkVMcnRS?=
 =?utf-8?B?S0RQK282Wkg4elpoUFA4ckhDaE1xR25pc1VqT0hsSlNGSDN6aUJVVWR0TVJQ?=
 =?utf-8?B?c2NCR3I5R3o1RFcwcDJLUlFadDZRTVpkZkg4Nkg4cmpVbG4rSFQzcFN6V1U4?=
 =?utf-8?B?ODk0Nk1RdFlaSGlHakd6N3JTTkk0T01FL1V2emFuUnd6eWRTV2tJNzBHY0RD?=
 =?utf-8?B?V0QxRjc2Um1xU3Q3L0JzQk9MNkkzTTAzQW9nSWhDUFpxV2N2MHZiVVhPV3BD?=
 =?utf-8?B?SEZFc2swb29wcGwzS1lNWVpwb0lyaW5XdDlGTjNHOW4yN0N6d1gxUEFlZDQ4?=
 =?utf-8?B?M0M1bUFVaTQvbXZQK0l2NkRQaVJXVmxEOTZwWEZvK2dGQ2MvQjhMLzNXK1pI?=
 =?utf-8?B?THBtaGNnVEkreVpMWjk2RHVpb04wSDN6M3pyT281MDNvdmNPeEJwaXdoaElL?=
 =?utf-8?B?Nm11Z0w1OVFteG13WlkrQXA3bkZuRlhVaWdJOGxRcHFSTzBGTjZ1SmNRL3VF?=
 =?utf-8?B?UGpMWERKWVUvY0FiWFRoMFZEWUJKZGU1VFUvaHN4dUpmaENya0VVREtTQVJn?=
 =?utf-8?B?dXgzUjhuRTRKcnBOaDJmNTdtVzBnZ2ZRUTV2UzR3L3RiUFA1eEwvUG5NczE2?=
 =?utf-8?B?b1JmWWlpM3lnYVFudFB6QXN3SHRpMG1pSWVwQ0UwTEdmRXhqNVRqNUFPb1ZY?=
 =?utf-8?B?N1MrNVIwdml0UEZXR0FuU0ZueVRjQ0lNaUlRVUtFeVBvK293MGx1N1V2YmlP?=
 =?utf-8?B?bnc1d2dKNCtZdE5lTnhJWE1wcVRHWUF4cUEvV2UvalQ1Z3p3VEl5cHl5aW1U?=
 =?utf-8?B?bnBSd1NhNmh1OCtObGhWdjhnM2dvUDhwdmpsSlprS29uSVY3ei9uQTJFTUk4?=
 =?utf-8?B?TGRDMUpncnR6WDc0d2lxNlV5TDFiOXRESFduN0JnK3p1OWNmQ0xYYXNwSGlJ?=
 =?utf-8?B?cDVRaVN0K3VZNGtlTUkrSHdIMnYxT09QK3FlVkNnUWxLMitxaURNeUFRaVJQ?=
 =?utf-8?B?SysyUVBQVlFRdEhZZGdxc2tncEtKVTJmU2pZZUVlRk40dzdiSytlYXEvSHJQ?=
 =?utf-8?B?bUFrWjA3RzE4cFFmYk1mM2NyYzJiL1pWVGJvaWhkem5oSnhQT2V2R1hiL0p0?=
 =?utf-8?B?RDgvU09vbFM4dkJpaHp3eGlwVVJRYXo3Y3lpU0x6Z3Z3VXJXWFVDNU41VjZ6?=
 =?utf-8?B?SVRrYnhSZ3htd28wdTIvOC8zK3lZWE10S1ZwdDNTdkQ2d3NHMWVwN1RNUmxD?=
 =?utf-8?B?ZGx3Z1VaaDE3SUFOdTlhQVc0enkzMmhRdFVDRVpXSWk0azRlMzhFVXppZGhF?=
 =?utf-8?B?YVQvZTV4ejg1NXBnemEvdGxWeVFsSGpYa210NmxIbkZjdFA5czJBYTlUZnpj?=
 =?utf-8?B?RXFvQmFGZFhHanBsNktXMVNPNCtNdFgycW1EcWxUaldmREVmcUlRK09ERVJG?=
 =?utf-8?B?SlJmNW9YMkhtb0lyZEpScXR6VDhhcWhCN0tWeW1zSmJBTUVoRVFBSTM2ODEw?=
 =?utf-8?B?bEd5VnJiZ1hqS1IwU1Z2blcwOEhhVWFUODlmQ0NyZGRtSFg0WFlVRGgwWnBs?=
 =?utf-8?B?YU45MldvOXlDNkIxRWpHSFp2MnZmTWpkdVRNaXByZ3lQODhQdHBjMlBZZjJM?=
 =?utf-8?Q?CMQedJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:51:13.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b38e332-be12-494e-7f55-08ddeb98957a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036

Hello Aaron,

On 9/4/2025 1:46 PM, Aaron Lu wrote:
> @@ -8722,15 +8730,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (unlikely(se == pse))
>  		return;
>  
> -	/*
> -	 * This is possible from callers such as attach_tasks(), in which we
> -	 * unconditionally wakeup_preempt() after an enqueue (which may have
> -	 * lead to a throttle).  This both saves work and prevents false
> -	 * next-buddy nomination below.
> -	 */
> -	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
> -		return;

I think we should have a:

	if (task_is_throttled(p))
		return;

here. I can see at least one possibility via prio_changed_fair()
where a throttled task might reach here. Rest looks good. I'll
still wait on Ben for the update_cfs_group() bits :)

> -
>  	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
>  		set_next_buddy(pse);
>  	}
-- 
Thanks and Regards,
Prateek


