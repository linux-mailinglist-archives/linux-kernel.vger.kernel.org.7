Return-Path: <linux-kernel+bounces-783933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63655B33476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19ADF481CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE022A1C5;
	Mon, 25 Aug 2025 03:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PzHZ4KHE"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E787213AA2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091929; cv=fail; b=EtlihRT0nyH2jFO8GOA+LtPg4JhazsCzFiRyTPVAXq5CmynljdA1WeCWhKLMT+GpLdBKW+lzvLBCBd4DeJuQz0n4mmGy3ywuf8ZgMwZZJy/lspZr/drmwrMTYu77MyzuRoGN6KC6nqR/M4F2d+ohR7L5nAIiLRYkgDYH62dcd2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091929; c=relaxed/simple;
	bh=L8ah935Zd/ItrLwCwIpip6XL2iOGjMzRaeYXp/TrWVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A9D7xTVVT5TYsDCnNPSY/meUR75dL7U+r3eSf5mm1UA/OG7+ut5ZhLdch4rXjtKoY8hCYo7wb5P79cjYl55tJvQSG728QQrNjA3/FN4ND9756iwiD3igl60xxXJ1Crb9kk1v1MnR/HnxMLr0+Z6xzIdTn0qQWV2jeD70XElMBH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PzHZ4KHE; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqpJV2tuQCw3KSEUIAPQfovHbtd4hKUZobR4z/8N5hTNyRSVQEklB/43ixQm/3erJD4MjZD8jEe+ONoo7GZYxORlhxON/7uVvrGK5foNdadkmeV8GRxyuhSgt4S/dN8I9RFH4R7sj4GqU21tyE3xvWGIaB2D5kQ68UdILXcdImmgLlFDNqOUKNkbJuA9PZDu+39a5k1lgJat2t9T3HOuG4+IB7ahBanyrnitFYaIfU3FAcvWdgXAmXFI51Uqes6l1z5seVfALrVHijAcccUd2HT9TZsXFtorjeorIX/BfqJPB75qCmbowJTlVkI+jnQyG6Jscai4cbeywZF/9Tza3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIMGusoJgXFJH7zJBW+QKTxFYzelAD9WLx4l06LEMD8=;
 b=xjqVKdDgwQIUfJXVFvylsW8iHP9f0zp9L7DSc/c2Iy6r2dd2EWr4/VTZ0+NcsS5WccHe4TXLvz/6QSEw8EY6qor5yyKXRkpHm1u9DBc2A6tReg4U+eYhEwtXaiMIS9DavXe+UhAru9bdoUzkshy6be/C3/KdVPfu/9mlM0lsJC+1cXlMCN3H+oVfDgMaQ2svqyOxjuGe+kt8cfK6yaDdKTnKv/S3lg3uDq32MdQkrcz85rxJc5e22AalzOlZUkURz+8FK2qf5ITjWEADtRIyg4B07/bQ4z4R6xh40JQXw+FIymA2CHHLIbCXXV1D2F4C8nAi5cb6xJL1M83Eu+vc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIMGusoJgXFJH7zJBW+QKTxFYzelAD9WLx4l06LEMD8=;
 b=PzHZ4KHEGXXFeI2suOlDw270aiA1BtzsUX12jzkI0nWwx0UxrGW7E/ufx5gkOMIckZzP4G1L5L1GFiFVcpBGnSR5ORrHwTypDuPqIyrJcEdWPapjMTSyE9tweR2jhsYRd+ecNLqjdcqIBpjQ7GzZJ7FueeivA5ovp4LrIQZTU9A=
Received: from BN9PR03CA0187.namprd03.prod.outlook.com (2603:10b6:408:f9::12)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 03:18:44 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::bc) by BN9PR03CA0187.outlook.office365.com
 (2603:10b6:408:f9::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 03:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 03:18:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Aug
 2025 22:18:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Aug
 2025 22:18:41 -0500
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Aug 2025 22:18:35 -0500
Message-ID: <67c2b6bc-7a05-46a5-a409-a51f28f94c64@amd.com>
Date: Mon, 25 Aug 2025 08:48:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: topology: Fix topology validation error
To: Tim Chen <tim.c.chen@linux.intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Tim
 Chen" <tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Libo Chen <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, "Len
 Brown" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Zhao
 Liu" <zhao1.liu@intel.com>
References: <cover.1755893468.git.tim.c.chen@linux.intel.com>
 <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a3de98387abad28592e6ab591f3ff6107fe01dc1.1755893468.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: f333cece-c0a4-48de-f6b7-08dde3861856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXJidDJvS2dWRnlNL242VUt4NlVvNGR1Ni8xQjBnZXFRaTVaWFdHcmdDamMw?=
 =?utf-8?B?eklYalJlZEdoTnlvbW95bXZaSGlkVmJ2d0tUdkY2aU1tNGFnUHJCUlU5WG5R?=
 =?utf-8?B?QUFxc3MwK3FJMnhHZDVkN3R3R3J5Rk5WMmw3eGVJUXBBbE5ad0pvaWQ5bWpE?=
 =?utf-8?B?Y1kycEtXWjI0Yjl1MmlQSDF2Wk13THdUdFdvSUdFcmdPWm5oSGY3TDVsWmY4?=
 =?utf-8?B?YkJKS2NJK1ZNcmUxaStyM3pid3pRbnY2cE56c0tXNi96TmJaeXlxQUJxR3p4?=
 =?utf-8?B?UDJVaDZTVXRTNWlqRHhjNnEvTWlXR0IySkNXTTJsYzV0am04RnkvZlFTMkgy?=
 =?utf-8?B?YUVyWXQ0NmZxQXF1N2tTeFBIYUp3NnJUWlRwYS84Smdwd1NRVE45TVpKb3Ro?=
 =?utf-8?B?ajdtM3pMT041MjluSjdYaldyYkx0OEpmMWhqZUxDM09OMS9UYXo4bHE5cXpT?=
 =?utf-8?B?cnpZMUdzb1N1L1BERFhpVURPYTUyZEU0a3p4dTlBeC8zMVNBR0ZHdnYzV2FB?=
 =?utf-8?B?cmdtNWdmdFVwSTRwVWlOK25sQ084UXFOamZJSzZsVWt1dlh1cGhYME9QbXp6?=
 =?utf-8?B?SWkrdEpyUTJubzFFVlBtVWR5bk9LSFNjQi9lNjdmK1NXd3N2VGdvaGtJN2R2?=
 =?utf-8?B?djZRWVU5dXJKRjM5V3ExVnVPbk11eG02VktwU3VBa0o3NHN5UHVRWitOZi9y?=
 =?utf-8?B?RUpMSWhOblJNd2d5d1BjZEdOOVpUajJCamFUZG9oU2I1cWYwY0t0ZVVtSGdZ?=
 =?utf-8?B?VVJOMHZiSVBsODU0aUxQZGlCRXpxUERTbmJkTDVLSW5uL1ZWRVMvZWd6V3lQ?=
 =?utf-8?B?TFludVdEOWcxeEFBV25KQ0xNeXFlN3psckl4WkVwVnh5TEQwMFcxWk1uZzRZ?=
 =?utf-8?B?MTBnUU0vdkR5OGg0clA4Y3YyTTBhd3plTkVwc1hOZGEyT292dDRmOU9Wc29h?=
 =?utf-8?B?MzdxOXNwa0g4RzhxZjE3S3ovSlU0QzZ4bFhaaUtTQzF4ckFqVHlTck5kSytS?=
 =?utf-8?B?ZEQ5T0ovTDFTbURwTjRFWHJkUE9YVk1kYlZ4NGd4eE44MGxCUytzbXk3Tzc3?=
 =?utf-8?B?OFUzR3paUUNMU3F3NFBjYmRwN05RbHBSdmhuRmtGT2MvYklNRGs2M3NQTHN3?=
 =?utf-8?B?N3Zrd1BTSmlGWW9RTUtyaXJ3RlMvQTJTL2RKWWNnYlU2REhBaTkxQzcyaGo1?=
 =?utf-8?B?Z0o2S05rMmhLTEllRTF3SnpFVWxuNEFNVjJTUk8yYWN5andNSlF6RmtoY2V5?=
 =?utf-8?B?MjVCYTU1eElMZ0p0enZJU3F0VFlTMklacVQ1UE4rV05JRkZTTU81QXEweGl1?=
 =?utf-8?B?QllhWFBFbjVROW41MExBam81U0JOTCtRejJJQyszU1VvYWFscW9oVFl5b1RN?=
 =?utf-8?B?QzF5WkdsWWZrL2Fhck9idllwWDNIN0M2QnB1NEFleFZGRTBGTkpLV2JHbjhu?=
 =?utf-8?B?dnVpZ3RVSStqS2NpNkNSNENJSXJFcllWOHZyMXRYaVl6emo2UVJvUXBGbFFi?=
 =?utf-8?B?YnB0KzRDSHFweHBMT0IzemdpNmpEU2VrYW1IS2dGcGlEdW1JYnF4SldnMzZm?=
 =?utf-8?B?U0RmclJjdU5yUkxtWlQrNUtZZkJ5d2VuaHJ5SVgxTGs3RDlGSncxanRwNG5v?=
 =?utf-8?B?dGpPSFM0Y2ZXUVFrUlNpUUVPbnFKSWlaTCtWVjBBTlc2V05Ma3dtOGs5RW1h?=
 =?utf-8?B?RTlMVlZlS0Q1cUNVTFNMVER2d1F3ZVBDbHFJL3VDMk95VFNpSStxWFNUYWk4?=
 =?utf-8?B?QWZ1VkM5aU53UnlHZ0hLdzV5QzlEQ1p5bHZyeExJaWdxb21MYTFOVkhSd3Vr?=
 =?utf-8?B?cndXc3BFc05QandQbDZsUndpdXhtZnJDYkhBeFhySXdJcU9lYytkVXp0RmlI?=
 =?utf-8?B?eU5BZC9GRDNWakovZE9ONUR6a2NXcFBWanR4alFWZWJlT2tUQVRQb0x0K2Mz?=
 =?utf-8?B?NjcrdTBEa0RmcGxSOFVhWkVTR3F5Q2dDL3R3R3JxOEZ6M3BGUy9OSVV6K292?=
 =?utf-8?B?TDgrMkVIMFlMY2R1VWRnejljbXQrMEhHNjFCYWdoekk4UHh0VXVwUHR0QWtL?=
 =?utf-8?B?T241WlV3OUQ2RXV0RmNMREtjSjdtS2NwdUhIdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 03:18:42.9510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f333cece-c0a4-48de-f6b7-08dde3861856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445

Hello Tim, Vinicius,

On 8/23/2025 1:44 AM, Tim Chen wrote:
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2394,6 +2394,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>  	for_each_sd_topology(tl) {
>  		int tl_common_flags = 0;
>  
> +#ifdef CONFIG_NUMA
> +		/*
> +		 * sd_numa_mask() (one of the possible values of
> +		 * tl->mask()) depends on the current level to work
> +		 * correctly.
> +		 */
> +		sched_domains_curr_level = tl->numa_level;
> +#endif

A similar solution was proposed in [1] and after a few iterations, we
arrived at [2] as a potential solution to this issue. Now that the merge
window is behind us, Peter would it be possible to pick one of these up?

P.S. Leon has confirmed this solved the splat of their deployments too
on an earlier version [3].

[1] https://lore.kernel.org/lkml/20250624041235.1589-1-kprateek.nayak@amd.com/
[2] https://lore.kernel.org/lkml/20250715040824.893-1-kprateek.nayak@amd.com/
[3] https://lore.kernel.org/lkml/20250720104136.GI402218@unreal/

>  		if (tl->sd_flags)
>  			tl_common_flags = (*tl->sd_flags)();
>  

-- 
Thanks and Regards,
Prateek


