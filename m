Return-Path: <linux-kernel+bounces-824787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52BB8A25F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4E116A708
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC9313293;
	Fri, 19 Sep 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dx/BXi18"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5C1C862E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293962; cv=fail; b=ok12Se69zKVbEuivY6TiVRkeAqPwA9NTrX5xGggxhQmQ9MJxESwjSa/x6YMCZj7TX/Vda34xz20Y/S7a8A7QD7thOyzpx6aPs3R+xaOnGEpE5PeHKeoOvQ7JXNZwNuQ9WpLWJzPXvNbZDjbB9pDQRVhEFr0cala7QryOG61n9Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293962; c=relaxed/simple;
	bh=MmFLyjjF0L/coJm/9FNGY0muGA6vidxmycmOXYwFDPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4Kw6mYjjhsFL5kcHSPMyd/yqT11fFRIkb67DZOCCLG5En5biWhJEvBbUJTRATHp7YG4cYh4+WQ9Bd0TTAq42j4NNGEH2A6sLajtfozGr2cRWwpd0cxoYmDFqnn1WJTOTpzvYMbaU00Q6uMhMiCUGLmsKiTGWL0nPw9fjDd/tKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dx/BXi18; arc=fail smtp.client-ip=52.101.48.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHj+v5/PBOaI7pLlNQM8abgtlpv/bNJUY/4ADOKc11VPF7OGZT73WWCojeIebni42UFS8z4/gC1FYlG6VdTf0XmyJl8VS2K2R71Ag62LYiH5M//wB2Vx3rNc+DopYOA/cSlJ40BHVTApg+8pLed4V8Oj8rwgPI3/hqyJK2quJUMUEZptg0bqWuvipJQW6BSR4TY+Eh8b+4GOizTfsc3LGqzPUH6hhYgxr6gGGRtUN2z8gdy/4TAOsY4skwao/eCgu38tRa9gmERQ/jQ9Cm0DNw/Xqsequp6r8tKbG+g0mWKlrKR1vvBYq8eToblj3IukMGBzUgTb05pFXtLErRBEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tV1FFAgRL4Syhxn50jBGBcSodA8QR/wtRr9cCtbaNU=;
 b=J6Ar1sVU7IMuL7G1G9igZV0usd0akRpbiZhUrMWVqIdsoWqtnYnRPHLQ0FZg6P2d0tcLTGFFJmQwPGBZPemkezmur2uhocvt3+iEAP2JP/QpnyoVYNTB83Q3VCMups9gX5UYbUHG1YwqxhPUcH+Bb+2wGzmjRonk/G28WUo8RZVjQXpCp0ffnaghT242wRuWuNW6OTo7hm35RlvJuzOM7kCUI7umxWrc6veKE3ilxxoK4jaxP83XY+g9qqivk+jIahKdu5L59h18DOUQb3tYgcW9gzhQEtOgzJ8BNzTGZXPEIN4pVI3WaztnllSTrfHKeaCrLxJxEUupg31U+iow+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tV1FFAgRL4Syhxn50jBGBcSodA8QR/wtRr9cCtbaNU=;
 b=Dx/BXi18nnYZVcNdDnJsJ/xAd7PJJ7WS/RjgKHlplEIF7ayWy+EjJpcDFZzzWlMhkLvQwwH+unSuPb9dPizmA+c6wQU4e0ixOsfJiPnChvdTWtPO5c3fPN7H56qiiGqhhTLyyi9sXRPGUQ8aEUWAcntIzwro3nFisofnz+y/AGs=
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 14:59:16 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::f9) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 14:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 14:59:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 07:59:15 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 19 Sep
 2025 07:59:15 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 19 Sep 2025 07:59:10 -0700
Message-ID: <ce1243d6-365b-42e5-b8da-7eb821d6f4a2@amd.com>
Date: Fri, 19 Sep 2025 20:29:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] sched/fair: Limit hrtick work
To: Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>
CC: <arnd@arndb.de>, <anna-maria@linutronix.de>, <frederic@kernel.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
References: <20250918075219.091828500@infradead.org>
 <20250918080205.563385766@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250918080205.563385766@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: fffbc9e3-6c50-498c-32e0-08ddf78d1a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tYRUY3NnJOa3N0VWZvQVlYUVJlUHp3TVRqblgrWFQzVHNkQ3NoT1k1RVVv?=
 =?utf-8?B?QmVPTWQ2N2h4a3prK3d5aFBQeDFwRnhIdUM3MjJteWNJVXBoOWhuVC94Sm81?=
 =?utf-8?B?aWxaOEtnRUt4aGtsOGVEWTEwZTJZMTdKeE96d3JVK09LcVRKQkJXQXhDdnBH?=
 =?utf-8?B?NFpIQUFoVHFnUDBrSSs2UXgvaWJTdDVjVzV3dzliZjltWHRRQnlEU3JwZDBG?=
 =?utf-8?B?V1NxZkhWUUtYOFBwV1A1NlZpSzJMZG9XbW1WeDRPWWpXVHdNVjhETUlyQXJt?=
 =?utf-8?B?aU9HVGhuU3BqWmgzRE5iV0xmcTZyOVVLZ2hrOUJqbzNTTnoyN3p5MFIxN0ZF?=
 =?utf-8?B?UGR1UVRJejNlVkw5SG5BSk0vQjh0VUhFSFdVVlRkT3RvYkNQcHJxOE5vWTIx?=
 =?utf-8?B?VFR2RzFBUStaWHpKaG92QlAwQUhITWQ3SEFIaUVrNnlTemttVFlaSGJHZmhp?=
 =?utf-8?B?WTNhb3hISHBwdm5XeXlUWEN0MTlLZzEvZWpNS1psazZjdDU3VzJkN0l5WVEw?=
 =?utf-8?B?eWd1MWpOQkQ1QTU3dzhYdVhqR2NjcUthYW9KUGpqSUJUY0hLN3l4MjNCbUNm?=
 =?utf-8?B?TnNwZHNqSEtYaWY2QkY2UXFlR1lHdnVlbkY2VTB3MmMreXNEcTlzSlY0VEs2?=
 =?utf-8?B?ZHpnajI2M1lneE1vUzJWUnJjM3FvL3B1bXE1ODJGRTh0Sm1CNTRpaDZseVJ3?=
 =?utf-8?B?Qnd1RlpRdjY1TDQ1WVhhQkd5Y0s1WjBaOVg0UlhCNGtTOXBXLzlZUnhOUHJB?=
 =?utf-8?B?RnZqS0E4VmxjUmlGSHNNQkFWWUV4V1UxamdibFJjM1NRdTZVYkZMMCtCYnVK?=
 =?utf-8?B?aEJ4SzRzSEVaeGFzdTk0V3o3L2d3RWpYajhMK0VHSkMyRXpRUXdGU1NPWnEz?=
 =?utf-8?B?SmljMlFPbWNabk9RN2I5QmRuV1o1bDR3WW5jMStkSGk1SURWcm9jcFhFN01y?=
 =?utf-8?B?VGErRWZjVEdqWVErZXNtQlAvdmZSMWlUL2FmTTY1dHFFNHgzRUtUa25IcVBP?=
 =?utf-8?B?Lzh1Y2pCUy9qMWxUK0lGQjdqeFRFRFlZVS80QTBOZWhWVmZBRnBXY09PQkVx?=
 =?utf-8?B?RVlucDlZa09ralNaeitrWkdRNEdjWkxBbk5JVzhpM2RaTG9FVUNPSXZkZUxT?=
 =?utf-8?B?cG5qU0FHanFweGNyQmV6U2pvWmtzSGlKakcyNDFHd2YrR0g4cSsrUGhYbUEz?=
 =?utf-8?B?TUVoVS9Od09aTlRvN3ZqWGk3R2hLNkZNWVorQitxSmp2bkdPTG1ac0ZuZ2NO?=
 =?utf-8?B?T05DN3MzR1F0Wm5COE1mUUo3eU1JOEZoZVIwQkNUR1ZzbFpiOW42NVpMeVpa?=
 =?utf-8?B?YWFyaDFuSzVDcjBLNlVLYmVKbXNsU3QvZUp5RGFKOFVBcTRSZHk2M1M1Umt6?=
 =?utf-8?B?RGlqMkJsUWJDYVBCQ3VvMldFQzFNMUxIUWdyVzhqS0lWaFlaVzVhYU14MkEr?=
 =?utf-8?B?Y3B6OUtTdllyMHh0QjY4NXUyZzZ2QXRqSVNzdGlNdmJ2NnMzN09PNFRsQXRk?=
 =?utf-8?B?NFdWQVo0VERjS0FDUlpFZTVQZkVCYWw4VGlzN3BueE1VT2g0bHY2eTk2b3NM?=
 =?utf-8?B?ZmZaeHVvOUk5Y2xZZWFyRG5PNDVFQVpBcEtOQzlMdmJROUM3bjQ1TUwydVJ3?=
 =?utf-8?B?YkNtRmJLVkp0d3FILzNiblFDTFhmakswUldxei9TNUZXTVo0QnFjaGVPcFl6?=
 =?utf-8?B?TEUwUkFxRjJ5ZU9jZ0hKS0JVUzNiZGFHaUFPQ1pjMFEzVjdsb2UxWFkyRnho?=
 =?utf-8?B?d0hQR3hpbm5nTUF3M2htNW5sdFF2UUlBOXBoZ3Y5Ymp2Qm5rSEZqeUdiRzRC?=
 =?utf-8?B?Z2pvMUVsQWh3R1lZY0lzMWtGTmVkSEVMVlhkd0xPRTJCNm1kWEdZSmFNOEY1?=
 =?utf-8?B?aVpUZjFPU1AzUGVXUmRnL2NLRkQzYlp2Qjd3U3dBN051REE2VlZYMTRpSXRY?=
 =?utf-8?B?QXVScnR2dGgxbmFRYWRrM280YXdIelhMNDV5NTdyaVljdWpXODZnbTg4WUp1?=
 =?utf-8?B?QjBXT2NiK1U0Nkh2cXVQZloyQkwxcVNrOUcrdUk5V1JhN1hYbnRTRHBlbnla?=
 =?utf-8?Q?+yJIhb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 14:59:16.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fffbc9e3-6c50-498c-32e0-08ddf78d1a8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

Hello Peter,

On 9/18/2025 1:22 PM, Peter Zijlstra wrote:
> @@ -13119,6 +13119,12 @@ static void task_tick_fair(struct rq *rq
>  		entity_tick(cfs_rq, se, queued);
>  	}
>  
> +	if (queued) {
> +		if (!need_resched())
> +			hrtick_start_fair(rq, curr);

Do we need a hrtick_start_fair() here? Queued tick will always do a
resched_curr_lazy() - if another HRTICK fires before the next tick,
all it'll do is resched_curr_lazy() again and the next opportunity to
resched is either exit to userspace or the periodic tick firing and
promoting that LAZY to a full NEED_RESCHED.

The early return does makes sense.

> +		return;
> +	}
> +
>  	if (static_branch_unlikely(&sched_numa_balancing))
>  		task_tick_numa(rq, curr);
>  

-- 
Thanks and Regards,
Prateek


