Return-Path: <linux-kernel+bounces-811450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3FAB5293D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2FE467EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555A623E355;
	Thu, 11 Sep 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BfUHFvJl"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C21DF97D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573554; cv=fail; b=swuGs+lx65r15ok21DTwtnh1JenwPq/LkmZZ9GTLIKCdWyNWDhuN2d87smvcMMJ2K/vd09vEH6eQPgwQmKcHFvrUguU2JZue3d3w17C9IRsv3fhQU/L0VxkNdQl9tHQNPzEyNbn9+nyPe/T6acJhHR4401Oig/PEyfepAEA4xgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573554; c=relaxed/simple;
	bh=jmgzLAQzoK/SF6VdcMClra6u26JI9jOcQ1LhHLh1diY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p2badkIqCb22eJU7/pTqINBlhz1cPLhocFmWjFfu8YR4U6yE2N5FumQvV52I/njwrZSEaijakxrLROTTUE80aMwj7n2NmOuraU4JGEWzPmSXCT+SxRCBzT+/30SHmw3YVJ2VUH/epjDl5es0r+bzGuYhrxlcPeAIzLh5gezSe30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BfUHFvJl; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGmg4AuS93KgyfJM2QFO8ooT4OjiWy8YSumSEz82z3+TLYyqyntyzDQJAyLMF35Cs/h3hkR4Apj4aJVxr548sWj9Vk1yWHvnVwyFqnRoEzjNT9YaOtjaXUf3PiH6BvCU95qVHTLuCD1pIViJm0ct1tQEoMOlQIGpLvXHnAM3mrvCroEdwSbAEnOUD0BYLdBuAIkGm2o0g6zb4rLmuWCwKTQI+U9GAW7wqzpXJmCGIIuQKhCLs3er06eat3FqFh0tYdpHbFIU2CQVZjbMRV9FUmsPH/jk3b+ddowLNfDF4ytZDpvYC7DNzlL+LKwrVKYlrPEK/3hFLm/1VgCI1FIm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxPM18u9L/TWZyYAUklhIemM2z8hLEMm7HGtIwBeR+c=;
 b=IwjMFngLYL9o8PDRDeljB/sD8stYX72IP55yfz6hEtO6l9iNwuM/36vgM/BgjQW1FSsWVNJxPDIRq903Hu/mhSixk6lLQAY4ml41RQJO3BmmXYhrDx+1c2AXIc+Ad/psBe1TDEL2VIaAeKU4CJkZc8qGCP/Sq+E/SOAK/py5sLGwhV4D3xJ++YvzBSdQY1DKHYmMKHZ/PiCFYl7kntfWy4apwf4jaMTspkLP1+mnYZ+/ZQ/uvObK2OPOZbusrerSuW0IjB84d/6oR7Afzknda40Tl17eayz9Bm4lBUtV0YN7jXaOqzkxlT6nZPgysRjCnynVSO8bTqdlgIU/OSnKxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxPM18u9L/TWZyYAUklhIemM2z8hLEMm7HGtIwBeR+c=;
 b=BfUHFvJlE+8nyBKoI0W9b2bIfV/Ry6Xb8Etm0QAoJ9Wnjj2SVjzYNi+Ntx5VQmsUeSWZp6XmGozb/KUXNAxF30HFeWwv0b3nhNPkai+OhogYe9PZCyonap3/VegrWZ6OTSIPtJ8RhDENsaVj15Rm0VX5g0eV8DqdHMJgUlRM28Q=
Received: from BYAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:a03:c0::25)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:52:30 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::64) by BYAPR05CA0012.outlook.office365.com
 (2603:10b6:a03:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Thu,
 11 Sep 2025 06:52:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:52:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 10 Sep
 2025 23:52:29 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Sep
 2025 01:52:28 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 23:52:25 -0700
Message-ID: <1198e424-cd1d-407d-8050-c561e57dd2b3@amd.com>
Date: Thu, 11 Sep 2025 12:22:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: use cpumask_weight_and() in
 sched_balance_find_dst_group()
To: Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250911034454.494852-1-yury.norov@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250911034454.494852-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: a7901b14-e97f-4428-5140-08ddf0ffc6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1AvaFNkNVRZdXNVcUpmL0lOOHNJTStrZTFOam5WeUZnMEg3QkJXOHk0eVl4?=
 =?utf-8?B?M1BpUU9XN2syUm1nN01KMnJWOXl5YjQweXFhL0orMU9Vcnc1dERlbEJKK284?=
 =?utf-8?B?bVMvRXRkY0FFdTZaaWJid3F1YVFZb2VGY3U0WDBjY2lxRTM5NmZicHhTSmwr?=
 =?utf-8?B?bjcxSFVNMDdpbVJ2MVhLcUp1SWRlRlJCd00xS3B0Z2hSbGh1SnpYRHd0ODlH?=
 =?utf-8?B?NmFtQzI2eDJwYURXR1VwUDVySkMvYzlLemNBWnplWHc0Y1J3ZlV0b0Z3Z09G?=
 =?utf-8?B?bXpFZmtERXg1MStKbW5wdDRJS05nYUVqMmw3cHVSWE5Nb3pETkhaYloyalM0?=
 =?utf-8?B?RXZmQkZEWmJPRVdMam9BUVU1L1NxVzhlTUlqSHJ4YUVlM0JyNk4yb1lhS1lp?=
 =?utf-8?B?VjZMOHB1WkJnbndXek9MVCtGNjE3eGhxUW00bnFLd3lUSGdaMURuekU4ck16?=
 =?utf-8?B?YktYeWRJRTl1Z1ZaY1NCbVY2SXhqL2JCNDZUMTV2Z3hSQTZuRkdKM040WFlV?=
 =?utf-8?B?MkJJRkhNN3owOGZDT1ZVaVZkb0ZLSGdlUkRFZkl1SXlFU1BkL0lpUVBNaEhH?=
 =?utf-8?B?dkRyQVF6YXJsZ2JtUlVpY3Jwbml3MWN0TDh3S0svNlQxek5PR3AxZUZYcHNO?=
 =?utf-8?B?T3NqRVhnVWx1U2IxNEdsRTRaek81dDBvbHpzS3E4eGJWaGJENGhtL0o5MWFq?=
 =?utf-8?B?akgyMld3NTBYSkVCb0h2Y2d0OHR1cDd4LzRLV2tSajFvTUlKelFnR0h5dzBh?=
 =?utf-8?B?OW4xZXBZRXhoZjZKcmxyQzFjM0szSUhiSXlaaEpmWEpkbW9WWkJCRG45TFhX?=
 =?utf-8?B?OFl2dFB0aEJHT2hCQ292M3pnZjdUdWxzSTRIRTdOZ1JDbllkby92bW15ckVJ?=
 =?utf-8?B?VzZDV0VYN09GcDR0SDRHZVliZnNRNHVjbzgrMk8rTStnWU16TkkxWEJ5QmZQ?=
 =?utf-8?B?OVladnBYTkpFKy9YSHlUcDJtVERWM3ljcEFjS1NCSUh3ejU5L1h4SXFTZ2pZ?=
 =?utf-8?B?L2FITEpTb05OaFgrTmdIWUlkaXI5QXc4d3FKUDhrUFdMaTBGN0g4VWxXdWZI?=
 =?utf-8?B?dEZVM2pNR1JSd2Y2NnhIOUxzWDdabkxZdldnOU9ValE4NDQxRStIMjYwdjFN?=
 =?utf-8?B?NFZUd3oyUG43ckVmS2hGT0JGTkdGVmlwMzY5WlFNazgxR1pDT1NnQnhDZStm?=
 =?utf-8?B?SGZUeGNMRE14cHpoMHJ3cTdFZ1VmM3AyZXYvc2Q0ZzV6RENQVUc3NTYzc3Qx?=
 =?utf-8?B?QzNGNS9PRkhtczR2VTdnNm15MW1wYm1CMUozMHlzTVd4WjUza2lXczRkTEdG?=
 =?utf-8?B?UVYzSmpXcGROdlArUk1GNXl0dFUyQ2wrMEpyUk9XcGthbGIwbnFOR2lYTi9Q?=
 =?utf-8?B?QTVEUE5aSWRWRTZCOGU4WmtCQzFkSDVHSWVBM2JxRm1yMnZQcnJmWWpsbXpQ?=
 =?utf-8?B?dHMxQkJqVDBmMFY1Z0hMRUJlM2tqSUV4Ylh6ZnlCWVBZbkJ5UnhrdC9JY241?=
 =?utf-8?B?QXJncmpxM0ZNa3NQRm5kbmpjbDBQYmNLZjhqbnRIMVk4VlVQb2QrZkJ0MDRX?=
 =?utf-8?B?cThOeVY0UEhsbXp6U1RwenZYdURraEptMGp6Qm1JZFdyS0MvQlEvNVMwRFVF?=
 =?utf-8?B?bWF0MHQrUmZHa1laWWVCUXFMQ2k3a0FwVUxtTHJvQ2JCNEdrblpaNkE2VE1F?=
 =?utf-8?B?WDVYWkg4bHR2NWtnL01EWHI1RVJlaGVWcVdZUFhhdmp4aDJzNEIwY3NEckYr?=
 =?utf-8?B?c0grTVdybng3TlA2YXp4Qk1Vc2FZZnNLa3ZzUHlSbzBTYXNLNzVQTU5RdkMx?=
 =?utf-8?B?Qjd3a2lNQUYwc1NJNnprUnpXWi9iTnp0bmp4WHNicEpNZTdCVWFSTVVlTWdv?=
 =?utf-8?B?QW1RVjdVVzRmOCsxdWVFaHQ5c2k1ZytXNi9RQXJEcThJRFBLTkZnb1lwbEU5?=
 =?utf-8?B?b2E4RWZLeHQ1bHExYklXVEFPa09yNFlsV0dRbyswNTFYNHh1Q29oZ255cFh4?=
 =?utf-8?B?a0NFV2xFNVFVdnEzbmdOaUh3R3kwbTN4QzVyc3FXUFl0Q0h4SE95MDFxMkty?=
 =?utf-8?B?d080Z1R4RHlLZE90ZGdOTFMvZkxBR2Z1bFhFQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:52:29.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7901b14-e97f-4428-5140-08ddf0ffc6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554

Hello Yury,

On 9/11/2025 9:14 AM, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> In the group_has_spare case, the function creates a temporary cpumask
> to just calculate weight of (p->cpus_ptr & sched_group_span(local)).
> 
> We've got a dedicated helper for it.

Neat! I didn't realize this existed back when I added that cpumask_and()
+ cpumask_weight() combo. Please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/sched/fair.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7229339cbb1b..4ec012912cd1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10821,10 +10821,9 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
>  			 * take care of it.
>  			 */
>  			if (p->nr_cpus_allowed != NR_CPUS) {
> -				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
> -
> -				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> -				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +				unsigned w = cpumask_weight_and(p->cpus_ptr,
> +								sched_group_span(local));
> +				imb_numa_nr = min(w, sd->imb_numa_nr);
>  			}
>  
>  			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);

-- 
Thanks and Regards,
Prateek


