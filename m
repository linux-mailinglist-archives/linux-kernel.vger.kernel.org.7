Return-Path: <linux-kernel+bounces-856442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA2BE42AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67553189162E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2840E32860A;
	Thu, 16 Oct 2025 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q9toGj9r"
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2897619E81F;
	Thu, 16 Oct 2025 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627817; cv=fail; b=WI00n4ci2knEws45g9NBD8SbWbSpXtfJt9z/c7zot2dOkSLSCUuGolXukSFC/4+Ecf8TekU0lNEOkfdNea7dkzbp9GDnpWUGcGu3g93lLja1ARfDrknYr7KZPXEY00Ajx2VB59idgxS3Nv2lDMC+6Qm6LBPVdkiUtLoy3Kl6uxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627817; c=relaxed/simple;
	bh=CHPW+ZJAOxODTxSnsB20GkLCZ7yIEE17UhVC/KlAZOQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=TVFfpUyaUy+BOwzoTvMDdXRAICWbbfComUQl68+kJjC8uMrKq6c2CjMBvYdasKr0uw1goSxgQMRS7q77ANc/25d3vwjxaZguRTUeKHjswpZPR+KTs65xrE+nxdCCMzsYfLcFgN50QnP18tVTj3qTcXqb+UawX4+JmbW1zB7/ygY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q9toGj9r; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0/Dwwi1rQln0Ij1qb2vsaTVdHKMj23N365PPWtvR8giz0blNfq0cq43/V6WYlr47R8bs24bZZWlej0rgPWikxSg9ACX2DWEnbujslXEuSmAXsgljHfUEZR7M4uupskPAI8B6jtw4dIBqIVtBVIKexviDrOzlKdgRsvtkNlrqsHwqAfOD7gjq51G/9BE5ZxIqONTyZ8pDyHkYp4cTDi/uPnQf3S1Sr6+u4vsyX/YrWjVX2Ot00mhnBG3lw1T+0l65Fw9Yb8rObozD5UATiTTbfAsy26VGSwkbdewsGoZtDFrlJc5t2RPiTRVdiRMbxwPAsYqi2CypF1e9e5yJtRAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uz2fEuYgTOx++cZrDH5IghXxukbCYD5NQwbAVzh9NoI=;
 b=GmxFDEcPYx5LKeI8zaXxjRy0SoSWygl/DB1tM5HtWdqKjLSmp55b4suJU4xsNBF3SBpCi1GFEUn2/PyhXlFiwJIgH3+yJHAtxjVQEfG4gc01J/svS8fzLRewraye8ICYOwGxkiW9dqmgsV9iPU8p/sOa3N/hFnDjtncRJ6dStm2hAzq3XIpJyuJElvApqc8nd/MxFOXwwo5sR8HnEUC+uGrF8M9uG5tYiX7qG7Gw2SR3SkHrOD/bfOYoxqDTCDGkrN6dvcmoDc2liHxqAzSU047VN4tQeTNCA4KNOU2kutfO1kXUjswvKshtXgFwNb5Rkct7njJ4TTHkOepVgy/gdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uz2fEuYgTOx++cZrDH5IghXxukbCYD5NQwbAVzh9NoI=;
 b=q9toGj9rGMJ/sdIkLGev2V4+H5EaW80AGGderE8bKDfxIQykNGvagAiXJ7scDnDoOO72Sn7vs0Z2nTUSaDyJ1L5o5rFMvsg4qK6/U5BO/DaOIP/hCAhQjt0+I+4zDP8FrcPxBYic8STU2PxqwnqR8YlOJMWzh+nBiXfHWrIzTyc=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 15:16:50 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:121::4) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 15:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 15:16:49 +0000
Received: from [10.252.200.214] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 08:16:41 -0700
Message-ID: <262c742f-dc0c-4adc-b23c-047cd3298a5e@amd.com>
Date: Thu, 16 Oct 2025 20:46:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "D, Suneeth" <Suneeth.D@amd.com>
Subject: Re: [PATCH v8 15/23] maple_tree: use percpu sheaves for
 maple_node_cache
To: Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
	<cl@gentwo.org>, David Rientjes <rientjes@google.com>
CC: Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo
	<harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, Sidhartha Kumar
	<sidhartha.kumar@oracle.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
	<maple-tree@lists.infradead.org>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-15-ca3099d8352c@suse.cz>
X-Mozilla-News-Host: news://nntp.lore.kernel.org
Content-Language: en-US
In-Reply-To: <20250910-slub-percpu-caches-v8-15-ca3099d8352c@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c9176f-9df3-4c4f-b8aa-08de0cc70795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjZyd0J5UjJ5VWlTQkZ2RkROY0pmSzVLVFZvVXE5czdNKzBodWFMUXkwMmQy?=
 =?utf-8?B?TG9sWDArYkl5RURlS3JJZ1lOSTVDT2ZRSUNnL2hSZVN3TUcyRTlaL3I5MTVP?=
 =?utf-8?B?M0dyZ1YybFVyWFN4ZEtNZk56S1UzQTgzUGlrQk9hZ3JGQXZGN1VqNFU1YXlW?=
 =?utf-8?B?a1g3WEJMSUprV0hNemZlRVJIVWI3bDB0VEJEL0REQjNMaDA0aGtyc3ovdFZW?=
 =?utf-8?B?eElQWkRRL1lNMThSRnpDSyt2OTJyTjZIaUlqclowL05zeVF1dGJhMmtzRG4v?=
 =?utf-8?B?QWtLWTdkd0p2NU54ajE2VkJkaTJuQnpWbTIrMEoyTVhLMm5PT21TQnpLdnBX?=
 =?utf-8?B?Ny9KSG9RVEFwSytYcUN1WFZXa2E3ZVAzLzI3b1Z3c0hMd1ZnTy9vcktKUVcx?=
 =?utf-8?B?MEF3ZzNTVmZTZ1lyeEdGakpDalU2WmVmbnBFZnJKbVhyTENlWWpCMFpQczUv?=
 =?utf-8?B?SW9TQTFRdmovMzVBdEdWVzkwMTFkUmhVOXZEWWxnTDhyK1ZpTDY1bzNjWGM1?=
 =?utf-8?B?cTRhNUNoSGtTdkhjQlBVOWFpNm1QdFgrRHJyRXhwT0d3Rm1zay9nUUdvKzg3?=
 =?utf-8?B?KytKdzN1UjZVdm96OHlWTWdCMkJSSmhqcHdzdjh6aFh0dHVKRmUyOFJGdUVT?=
 =?utf-8?B?UjJOYW5kL0FNenk0NkdpZzFieWd3V3IzUk9SazBxdUdsY3dQb1llWUVkNitP?=
 =?utf-8?B?MzVtQzQ5M3NZZ2N2ekJ5V2RFVUJ1NzlLRUZsSVUwaitiTXFsWVNBVkYyUklD?=
 =?utf-8?B?Y002UHpOcWxlMU9OK0NtWUtlbVhMVDVvUndlNUJJZGRWaFdqRDV3S0h0UFRB?=
 =?utf-8?B?d0JKTDhtbjVKUElxWFVST3BBbXRvQm44WWc5NjUvSEdZN29HMDJJOWw3K2dw?=
 =?utf-8?B?TmUySXRhY1RRcE05ZkxZTmw2WXhhS0dheUg1dnZMVW8yWFVXQUZ3NWVsUFl3?=
 =?utf-8?B?YVZCOXJCU2hpTmF6UUR3Q2NpeW1xMlFMZ0VPaTVhMjdaT2dHam5lYjQ4NGEy?=
 =?utf-8?B?WDg2bjNsWGE0V3pMdW5LQlIwV2dxejdIRHo5azhRenlpdzhYS2RJTFFMVnpT?=
 =?utf-8?B?UUxnKzkzY1VRWUlBbFVseTdETFYyL1VMQW9zZlNuREdGUVVCc0tQS3p2aERD?=
 =?utf-8?B?UUd5bkdaK2VoeE8wN0NTQXpvaTBGWS9veE5ZMEVKVE1HeFdRVkEzcVVUMW8y?=
 =?utf-8?B?amp0RWVRdy9mSVIyRTlnL3gyZmp6Zjd0bUtHWDNtQUNWNXBJS29iMTQyVEtW?=
 =?utf-8?B?VUxOWVcxOVd2NGgyN2ZlVVgxdFBXR292TnpOWWJhcVdRQjB5d0twZWVtL0VN?=
 =?utf-8?B?SE1hWW9xaHlMN3A5WDQ4ODhUVFpxSnM2RzREU3lOcDZYMmhoWnRoVnplU2Jy?=
 =?utf-8?B?TFNQS2NXUk12S2ZaTFhOZ3BLbHprVThMTjFDRkZTWkNaeElsRk1DUUFLdnNZ?=
 =?utf-8?B?Um94cVlsOVVZL1dCK3MyL0VjSzl0UUFkb2xOSnFvM1dWbFZ6aGQ2N2t4WHp1?=
 =?utf-8?B?K1dRRzUxWFhqU1FVUTNUL0E4dHZlMEZZamNxRGxuWlF4eDZPTko2enZaSW9q?=
 =?utf-8?B?cUtzTFBvK2Q0c1RLY0VyZ0trdlJnRmFXb1kyVGE2eXkvNlBpZ0ZJVSt5L3JJ?=
 =?utf-8?B?cjhmV2dFN3ZJdUl3MlZ5VEpQZWJ6aFJrREtudzhVbUJ2UVI5THJvMGNFaEFN?=
 =?utf-8?B?TVREVWUxZjhLNDRmMVd5d2xWcjBaVnhVeGhiRHdsNDNkVmNPdDRBNXFDWE1M?=
 =?utf-8?B?SFIvdWZUMUplSkdtZC9FNFVRRTRkeGh6cEJ6RFNFT21aRWNQZ1lIZWRrSkJB?=
 =?utf-8?B?MjRUNTdnZ0Y2R1NtbXUrSGhGWkFhYVcxbzc5M05QNHgzMVVBKzF3Qk9wTXVL?=
 =?utf-8?B?aHU5dHZXejY2cWVwbHF6dFNSdGJZRzVnTWdzQnI2bDJ2cG5qZ21aUndRRS9s?=
 =?utf-8?B?U2h1TldoUHhTRkhaeXVIUkdZMU9yRmp1emNNN05mV0N4NXdIZ3V6bGpQdlBx?=
 =?utf-8?B?cDZ2MC9nVW9iUzAxOXA3UVlWSjZOOEVPa1l1Rnpmd0M5Zlc0Y0xDUVFXMjls?=
 =?utf-8?B?M1RnaEZyRWlGUGw5WGlIb2E3bStkN1pERXZSc3ZCMnkxekI2czhVVVh4WHh2?=
 =?utf-8?Q?+TmWNhHNo520nANKhpbHypcI8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:16:49.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c9176f-9df3-4c4f-b8aa-08de0cc70795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

Hi Vlastimil Babka,

On 9/10/2025 1:31 PM, Vlastimil Babka wrote:
> Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
> improve its performance. Note this will not immediately take advantage
> of sheaf batching of kfree_rcu() operations due to the maple tree using
> call_rcu with custom callbacks. The followup changes to maple tree will
> change that and also make use of the prefilled sheaves functionality.
> 


We run will-it-scale-process-mmap2 micro-benchmark as part of our weekly 
CI for Kernel Performance Regression testing between a stable vs rc 
kernel. In this week's run we were able to observe severe regression on 
AMD platforms (Turin and Bergamo) with running the micro-benchmark 
between the kernels v6.17 and v6.18-rc1 in the range of 12-13% (Turin) 
and 22-26% (Bergamo). Bisecting further landed me onto this commit 
(59faa4da7cd4565cbce25358495556b75bb37022) as first bad commit. The 
following were the machines' configuration and test parameters used:-

Model name:           AMD EPYC 128-Core Processor [Bergamo]
Thread(s) per core:   2
Core(s) per socket:   128
Socket(s):            1
Total online memory:  258G

Model name:           AMD EPYC 64-Core Processor [Turin]
Thread(s) per core:   2
Core(s) per socket:   64
Socket(s):            1
Total online memory:  258G

Test params:

     nr_task: [1 8 64 128 192 256]
     mode: process
     test: mmap2
     kpi: per_process_ops
     cpufreq_governor: performance

The following are the stats after bisection:-
(the KPI used here is per_process_ops)

kernel_versions      					 per_process_ops
---------------      					 ---------------
v6.17.0 	                                       - 258291
v6.18.0-rc1 	                                       - 225839
v6.17.0-rc3-59faa4da7                                  - 212152
v6.17.0-rc3-3accabda4da1(one commit before bad commit) - 265054

Recreation steps:

1) git clone https://github.com/antonblanchard/will-it-scale.git
2) git clone https://github.com/intel/lkp-tests.git
3) cd will-it-scale && git apply 
lkp-tests/programs/will-it-scale/pkg/will-it-scale.patch
4) make
5) python3 runtest.py mmap2 25 process 0 0 1 8 64 128 192 256

NOTE: [5] is specific to machine's architecture. starting from 1 is the 
array of no.of tasks that you'd wish to run the testcase which here is 
no.cores per CCX, per NUMA node/ per Socket, nr_threads.

I also ran the micro-benchmark with tools/testing/perf record and 
following is the collected data:-

# perf diff perf.data.old perf.data
No kallsyms or vmlinux with build-id 
0fc9c7b62ade1502af5d6a060914732523f367ef was found
Warning:
43 out of order events recorded.
Warning:
54 out of order events recorded.
# Event 'cycles:P'
#
# Baseline  Delta Abs  Shared Object           Symbol
# ........  .........  ...................... 
..............................................
#
               +51.51%  [kernel.kallsyms]       [k] 
native_queued_spin_lock_slowpath
               +14.39%  [kernel.kallsyms]       [k] perf_iterate_ctx
                +2.52%  [kernel.kallsyms]       [k] unmap_page_range
                +1.75%  [kernel.kallsyms]       [k] mas_wr_node_store
                +1.47%  [kernel.kallsyms]       [k] __pi_memset
                +1.38%  [kernel.kallsyms]       [k] mt_free_rcu
                +1.36%  [kernel.kallsyms]       [k] free_pgd_range
                +1.10%  [kernel.kallsyms]       [k] __pi_memcpy
                +0.96%  [kernel.kallsyms]       [k] __kmem_cache_alloc_bulk
                +0.92%  [kernel.kallsyms]       [k] __mmap_region
                +0.79%  [kernel.kallsyms]       [k] mas_empty_area_rev
                +0.74%  [kernel.kallsyms]       [k] __cond_resched
                +0.73%  [kernel.kallsyms]       [k] mas_walk
                +0.59%  [kernel.kallsyms]       [k] mas_pop_node
                +0.57%  [kernel.kallsyms]       [k] perf_event_mmap_output
                +0.49%  [kernel.kallsyms]       [k] mas_find
                +0.48%  [kernel.kallsyms]       [k] mas_next_slot
                +0.46%  [kernel.kallsyms]       [k] kmem_cache_free
                +0.42%  [kernel.kallsyms]       [k] mas_leaf_max_gap
                +0.42%  [kernel.kallsyms]       [k] 
__call_rcu_common.constprop.0
                +0.39%  [kernel.kallsyms]       [k] entry_SYSCALL_64
                +0.38%  [kernel.kallsyms]       [k] mas_prev_slot
                +0.38%  [kernel.kallsyms]       [k] kmem_cache_alloc_noprof
                +0.37%  [kernel.kallsyms]       [k] mas_store_gfp


> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   lib/maple_tree.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4f0e30b57b0cef9e5cf791f3f64f5898752db402..d034f170ac897341b40cfd050b6aee86b6d2cf60 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -6040,9 +6040,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
>   
>   void __init maple_tree_init(void)
>   {
> +	struct kmem_cache_args args = {
> +		.align  = sizeof(struct maple_node),
> +		.sheaf_capacity = 32,
> +	};
> +
>   	maple_node_cache = kmem_cache_create("maple_node",
> -			sizeof(struct maple_node), sizeof(struct maple_node),
> -			SLAB_PANIC, NULL);
> +			sizeof(struct maple_node), &args,
> +			SLAB_PANIC);
>   }
>   
>   /**
> 

---
Thanks and Regards
Suneeth D


