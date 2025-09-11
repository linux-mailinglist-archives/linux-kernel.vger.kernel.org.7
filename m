Return-Path: <linux-kernel+bounces-811369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78428B52826
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889131B273D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C5246BD8;
	Thu, 11 Sep 2025 05:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZeqzCKza"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAB1168BD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757568238; cv=fail; b=rqTuY/rT519Yx3y2vNx5XIbhgIV5aOKQBYJ664XzqakBZl70FinrxUlEWKvQlsFwCjZacpvMPOUsEwT7p86KtFqzVmiwZlgjDuLbj+usD8yGaaEUMBNFdnRQuWjmHOnL3cxxb2q6ySDhiwbH44yX1gpzgdKSmr/0pZG7nFahLj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757568238; c=relaxed/simple;
	bh=jNs5TC2BLT2Feznk638QNVtxbqGW8R9FaGSu0KrZKj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aBId8rG3LVGPb0PiL+NepeHsfNV5PRYG7BTR2CDV/0bTDSZZqiHyaBkyo0+o9/m40v2HYi1m1TDQOIWVS0WzBID6RV+oOmAZFAHc8+ionAPDV5CyRkbZUq1scLmYslgb84epBpqAYk61dgfZ9OXZnIqK/pAUiE66zBNu7CXLFb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZeqzCKza; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtFr9RCIvp+LrUm2TRsU/WbQPkcRZ/bI77eqPsADbRi/J0p8w45Dwu8FRq77FJC/sdxElOG6JjC+UTyJa1VbbdyWRMFi0nItZUSRa7ihdKEj7hYFrSuB38uP1W2T3CaUwGkkYD2IGkA4BE3NsemZERYgu/Lc9RC2XXcy8Oxqjm7KRMLa9wTZPGivVatxQjNYKMdT7RKCMlYUWLZOsUw4Jjv/wmE3vC56A7SykTJ4GvIRSNNnBLzVGsgNgpAQepDsQqgWa4j8qmq61e0pEDS2Obd91AnOYagSEqgpn+n4dPphRzuFrwdvyS0hQi9VKcpiMP6guK6SxcyphDNl8awD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvEITJGt4muzZ5ZG/2EuHbpuDGgYN8xsxL+TkBrreRY=;
 b=GD1QOiQ4zSZsR6xdsLR2YRp0/AVbvLQHPEWI7K/n2e//RGbhs/PFnZSXKWd9HyzD+UcPwFW9xRXFk2kdLD8jAuAmMWHDqcnMqz6tR9IG9plfumnHjVzfRicho9tx13mVFv4JnHejiZ4szfs3luIdIiOK42txykLvY2KQqpvq7YVttt/9OKmFxqwD78OElUGe/TLoySGq9vG2qvg8GsN66bA8EcXM+96EyevjYn06wLysxbSEysUtJxGN58lAxMddHwute6P9EdBFpKJSaY5M749ajt1gpZFtJQlldZ4sX5D/IwfKU8udUQhnbH5Z3KrjDXuo7b1VOnudhNplyOCyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvEITJGt4muzZ5ZG/2EuHbpuDGgYN8xsxL+TkBrreRY=;
 b=ZeqzCKzakELZcyb4Smaj7htPjnICiPIT+le34WmCwFIhZrUQuX1PFFO2nKfGF6scxv3MrY3KgdZSlAT6NBPzeDctZW3zrCfwSHLLuEqkvAaDkHsIkVU0pafNoESRMQsvtIKGx5Q+r2e3rWsZIDguwQlnz4mnIetEa0mFvjSD1uk=
Received: from CH2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:610:5a::36)
 by SA5PPF37951B1C9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 05:23:54 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::b6) by CH2PR08CA0026.outlook.office365.com
 (2603:10b6:610:5a::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Thu,
 11 Sep 2025 05:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 05:23:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 22:23:52 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 00:23:52 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 22:23:46 -0700
Message-ID: <d0aa1a34-2097-405c-b431-907fd973ad96@amd.com>
Date: Thu, 11 Sep 2025 10:53:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/10] sched/fair: Don't consider paravirt CPUs for
 wakeup and load balance
To: Shrikanth Hegde <sshegde@linux.ibm.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <tglx@linutronix.de>, <yury.norov@gmail.com>,
	<maddy@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <gregkh@linuxfoundation.org>
CC: <vschneid@redhat.com>, <iii@linux.ibm.com>, <huschle@linux.ibm.com>,
	<rostedt@goodmis.org>, <dietmar.eggemann@arm.com>, <vineeth@bitbyteword.org>,
	<jgross@suse.com>, <pbonzini@redhat.com>, <seanjc@google.com>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-6-sshegde@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250910174210.1969750-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SA5PPF37951B1C9:EE_
X-MS-Office365-Filtering-Correlation-Id: 0abfbc73-fd64-4e6b-507b-08ddf0f36635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WitqQjFCRnZGeXdsSDg3eGJKRW9Sb2E1MWRBWml0QzM0VmUrWTNxYmJJUm0x?=
 =?utf-8?B?L2JSMFgrN1ZQcGhlZjVJL01PQXdwbm4yTWxQM3pZZEVZK0V2aXk3bXVobGJE?=
 =?utf-8?B?SldaVXN5dE1QSWNSTzhXbWtLRERSZXpGRmUwOXdLWmRDRGhNcDRMY1hybmdh?=
 =?utf-8?B?ZCtyRVFpRTlLeGRlTm1FQlZUMHo0MzRZUnJKMEZteU16a1NOMk4rbGQzVjdU?=
 =?utf-8?B?UlhlanpDeEg2dkpnOU5od0dRU3ZRZ29OWnU1ZnRXUzFsSDE0U0crV010VlRm?=
 =?utf-8?B?MUdXeTBoTHVXUXBHNTNkRWljKzd6RmlqY3pOTTBZR3lkSWU1dnJ3SWhya0NJ?=
 =?utf-8?B?WlNHcSt2a0xQZ2dFVzRIcmN2Mk1nVGlXSUI2cEkwTzFMaTZEMEs3OGFXS3hv?=
 =?utf-8?B?ZHhsZmlIRUVEeTloaXpOSmhhcGEvbmJMTjl3c0hCdDZYSHAwVlJ2WEJKaTh3?=
 =?utf-8?B?NVlxeStOU2tGamYzYjlwS3NoMGM5VG8zZXVuRGkxOWJqS2QvamkzTkF2YWJG?=
 =?utf-8?B?YWNpNVArWmV1OCtsMFNUZ0lqOWdMN0M5SG1UOW1rNjFwbUVDc1lYVGl5d3lj?=
 =?utf-8?B?Tm5Xa2IrMmR1aS9sT0kvRy96WjJSSlNUYUdzUU5TMkhkWDF1eVlxYTBwa0NB?=
 =?utf-8?B?ZXd1UDZqWkhmRThXVndsbDdMQ3ZMOFYyK2Rad1prR0M1OWpOT2p4T0RGbFhy?=
 =?utf-8?B?eHgvb3ludVd3RkZsL1FEeCtvOXVaZ1VLNUJWdVFOeFNyTGJrS1djcFdBbVhs?=
 =?utf-8?B?K21PM21pRDhNUDN0aFdHemJJb0hlaGZFRk1ESEdvMFZnVE42aThyV2M3dDVE?=
 =?utf-8?B?R0pzdzlVQm5CUmQ4eStZSG9MZ1F5YnNNRWF3VW9hZzJuV0pQMXVsZzlwb3J2?=
 =?utf-8?B?YlliSkNvR2dqWTZ3cGlFa2dzZ3B0bG1uSDc1cGVMMUs2em02TVg1S1VDMWdI?=
 =?utf-8?B?Tm56ZlM5dndoNlhSVlNnWmJFYy80NmdDbVFmWEEwQkV6L3dlQ0U4bWdhVFRo?=
 =?utf-8?B?a2wxQjc2QjB2NG1XWjNNeG90WFZVZ3c4NDZBaUt1bnhBbGkyV0lvN1l5Q0I1?=
 =?utf-8?B?SkpSQ3hXY2ZXMzlLMkNwWjIvWHJrUFNEUlpHc1NKc1pPMDBPSWJIWThaYnFj?=
 =?utf-8?B?Q2RJNE9hQzVrd3huL1dFZkNYRjBuRE0rYnVnL3dhR1IyVUJJcTBHbVErb1NH?=
 =?utf-8?B?dWNKVzBNNHBuM1JjVzR5eEIzWXdQY2FvMUlIelo0aFRwUXhCMDdleUxlQXFv?=
 =?utf-8?B?bmU3U3MwdHFIMVgrOHNrM1NZNE1CRnltbkp6S0paYTVOS01GZDFBSEkyNHFS?=
 =?utf-8?B?MXlZeDNPRzFzQ2lZY1ZiM2JvSld1TFA1Zzc4ZS9xdVFMVCs0dTN3TkRqdWVu?=
 =?utf-8?B?NlNteVZRRmRQRWNlQldwdVlrYlk2ZzBBd25TUEY3L1V6WEhNTzRYdlpId2Jv?=
 =?utf-8?B?TXVaTDI3aHRTSzFxcHJrNjV2NTFXVTlZZVB3dGZhWHpRTFpMbUZUTkdWam91?=
 =?utf-8?B?Tkd0MlYyNzhGbGVXb3J1aXlkckwzVHR3dTZOK2RucmdHT2JPZ2ZZSy9KZGIr?=
 =?utf-8?B?NXUwcjdkcUU1allwT2xSU2FpMnQrQkxKQnROTkdsT1NyaTQrZUtjZUc1bjE0?=
 =?utf-8?B?VUl4bmRrb1oveHJXSC95WWEwbkJMbEdiRlJDeWNpYnpIUUx1WTMyMUhmdGZX?=
 =?utf-8?B?eVB1OXdDZDJKc0kwaTJkZzBtSStBUENzM2JaekduWWFrbUM0elBUMElEbzVD?=
 =?utf-8?B?VHI1UU1La0ZSSVNuQTdrcExVUTFlMzRyemVRRzQ4eUV4ZWpjZUIxNzdtSkFy?=
 =?utf-8?B?NDdIWDVTWDl6TzMwY3JERThkZlc2cEtDVFF1UjlzSlZpdm9mdGR6ZzNmTDBN?=
 =?utf-8?B?cTNwZ2g1WDN3WFNDQVJObG1wOFJFUitGSlRXV3ZmWTBFU3h1OUg2YlVGR2xE?=
 =?utf-8?B?UDdLQlRGQ1p4S2c4VFYzaWxHSDQyUlFtUlh3VlVpVEtDQ3crd0NFZGRkRXZV?=
 =?utf-8?B?S0h0L0hVSU5SL2xUYjA1dFR6ZHdlTDNHVUpieVE0cFMxZGl2Z1U5aTZXa3Jm?=
 =?utf-8?B?RjYvbmRXSVQwaE0zekZ5NFlObVg5dkRWQVR2QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 05:23:53.8412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0abfbc73-fd64-4e6b-507b-08ddf0f36635
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF37951B1C9

Hello Shrikanth,

On 9/10/2025 11:12 PM, Shrikanth Hegde wrote:
> @@ -8563,7 +8563,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  		if (!is_rd_overutilized(this_rq()->rd)) {
>  			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>  			if (new_cpu >= 0)
> -				return new_cpu;
> +				goto check_new_cpu;

Should this fallback to the overutilized path if the most energy
efficient CPU is found to be paravirtualized or should
find_energy_efficient_cpu() be made aware of it?

>  			new_cpu = prev_cpu;
>  		}
>  
> @@ -8605,7 +8605,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  	}
>  	rcu_read_unlock();
>  
> -	return new_cpu;
> +	/* If newly found or prev_cpu is a paravirt cpu, use current cpu */
> +check_new_cpu:
> +	if (is_cpu_paravirt(new_cpu))
> +		return cpu;
> +	else

nit. redundant else.

> +		return new_cpu;
>  }
>  
>  /*
> @@ -11734,6 +11739,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>  
>  	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>  
> +#ifdef CONFIG_PARAVIRT
> +	/* Don't spread load to paravirt CPUs */
> +	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
> +		cpumask_andnot(cpus, cpus, cpu_paravirt_mask);
> +#endif

Can something similar be also be done in select_idle_sibling() and
sched_balance_find_dst_cpu() for wakeup path?

> +
>  	schedstat_inc(sd->lb_count[idle]);
>  
>  redo:
-- 
Thanks and Regards,
Prateek


