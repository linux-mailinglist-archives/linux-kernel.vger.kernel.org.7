Return-Path: <linux-kernel+bounces-813111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531FB540D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C4BD7B7364
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983551FDA61;
	Fri, 12 Sep 2025 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rvLISrT0"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781F1A9FA7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647428; cv=fail; b=f8Bj9tXlpuh/U52zmAhHIWJxTNscQwNdxEpH7LvWRJeuTK05U9pyKs/DFA0eIicrq1MoP1tSHagRMQHVkDyixr1z8Mmofh03/mq0u6ig6KfD/fSBA1McsTmiXMstUxkjRccEzLMy848VjG/LioyMQo9byPND+lSVGan/leRVs7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647428; c=relaxed/simple;
	bh=9NYYVaunbWmsGWWFATC9fojix7OyOo/sdP8ucWLeWqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UCRyZxiNR4XE8ZygR+FKt9VdgteNLDgVI5Balx7IrfMB3ygsVBMxWJOCbq5TSgZjLjViX6aiWYpqdZm2tM3Z/z8FO7aAPq+eNCuN17bXiudsiY/OOrFg7bqHQfo+6isHxYK4P89cKYSnEAuoy1DbvtXW4YiIdD3K6EFSb/aOl8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rvLISrT0; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGy4P09bQgVT/gMpiwIa3HvATZ0xI1s/yNUw4uC7oJWYbDxC+8w2OLkpF83iNVwa2u+NalyjfoLFPOly6ulklb5TWGs8R0utMCqRCXphtjgUJpSXsChEyBtwpjBnLQcHTj0+0l3NG63343f6XLK6EP6xU/YRw1y7WMIfoUFa+TSfhgcOogqOcN0mtWm/0Twg0soQitkgLiriMRKcmnIE7WcyIpHagH0Fr36kcjTO34ggj0v87lcU7pBTgiytWpjUnVx1jklWbVc33FNeGXHTPad4yWY3b1gboe830TRL+wvj2F0a99nmNRLhGCVqM9B2sqf9W7yLfilLZZdfvDKDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4oiWbqY6w2FiTdx4GWJJ9/55mIIw2UgnuymC+ZGmzI=;
 b=G/5qkexT5RkaQxQYZRsotMzhOlzsgdXTARc8i/rAHrl2ErobQD06s9FiWBc+SY3fNVjRYdP7ycPgofgCLR3PMKq9Ri0RGF9daFAqOaoC3omFxAoW9j+crUYdwAhGK2nF6JCi/Kjy38935oRnU+66MMP48aDcXcWovZd94QS876WWw6oMFckgG1fGpKUfKmIwTDnz/zcs85ZuIjIPp0x/u8jnY2DAypM0MOKe0DwMUSgAbN8R4rU83gtH2vSlk1uJVJt2Ok9R5dlnMG6nolFd1WZ+NHblxyezM7dUxq+nRCtdr6eYn4uZPlHucqf1Jpazn3Bddh0ZxuwBrhfPF6jETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4oiWbqY6w2FiTdx4GWJJ9/55mIIw2UgnuymC+ZGmzI=;
 b=rvLISrT0FeSV8jSqTtxGgMDBldzFsCxoKCsHCZyZBBabRo5RU0kitakKCQA9Vu2+Kksm5zrMAI12n58bkopF90/Eprduio1UTA5g3bIGhXfuc07XjZf30j2VPnuzh5acb7E4lPr7ue9TemnwkFGGyBmD1T+BzH4CgqedKgQGDsQ=
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 03:23:42 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::ae) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.18 via Frontend Transport; Fri,
 12 Sep 2025 03:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 03:23:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 20:23:42 -0700
Received: from [10.136.41.4] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 20:23:35 -0700
Message-ID: <e11163c7-9e23-4556-9a3a-962222978686@amd.com>
Date: Fri, 12 Sep 2025 08:53:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sched: Create architecture specific sched domain
 distances
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
CC: Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tim Chen
	<tim.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, "Libo
 Chen" <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>, Len Brown
	<len.brown@intel.com>, <linux-kernel@vger.kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Zhao
 Liu" <zhao1.liu@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Arjan Van De Ven <arjan.van.de.ven@intel.com>
References: <cover.1757614784.git.tim.c.chen@linux.intel.com>
 <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <1aa0ae94e95c45c8f3353f12e6494907df339632.1757614784.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 4076dce7-3f67-457b-4a9d-08ddf1abc644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTM1YXNObGw1WUhQK1ZzTGpyUWNtT1pCSmpQT0pJMXhDVnZmZ2UyZmxiT0dt?=
 =?utf-8?B?UEUrSG1jWFR5Yldrak4zbkxsVGhuT3dBa2d6UEdkOElWcktYQTNIcjNaZ2RE?=
 =?utf-8?B?WXczTXViWm1nV2trWk9uN2NmRTdEQkQwcXNXZkk0MXVVQVFyeHlFN1JBNmIx?=
 =?utf-8?B?K3FTMURGcGhveDhIK3hBeXp0ckRlakpsVG5lTjNMTGw2enFSQzZLY2J3VzFP?=
 =?utf-8?B?K0Z6M2FiYVVabmdiS1BtWDQvU1NxQm9VbVlsQm9TU0dzTjYzVFI4MW83c0FH?=
 =?utf-8?B?N3NwbVh3d01zcitXQTBZZm9nMUttaUFucUJPMUZ2SU45S0RmUFVVaEorZVpy?=
 =?utf-8?B?b21QOTlCeFF5WUZEOXVzUW1vSGFjWW1XNEFjUjJ3V2cxaUR6ZGV1MGR2b3Vr?=
 =?utf-8?B?Sy9UQ1FmOEJoc08vN3d5R01DU2xUd08zVEJpSTA5N2M2LytuZEttM3F6Mklq?=
 =?utf-8?B?Z1Jod3psN09hZWZqUkVoNks2RmVRWjQrVXJFbG5UR2R3bkhMajFya01YcVEw?=
 =?utf-8?B?QWRmMml0a0dwRy9jTEZEOFlhSG5NZXBOQ0l5TStGZFF0MkJndUtrbU8yMWI0?=
 =?utf-8?B?dlJ5VlViMnpXd1E3L1llSDBGU3g2RitsMHNIMkQ2bFB0SUk2VEFRY3FDNGcw?=
 =?utf-8?B?M3o4cXUrVVVTUkU4SC96RXhWcUpreGtBekdIN3Y0VmdNL0hOU3ByZGkwK3pJ?=
 =?utf-8?B?aTN3R3I3am5kUk1WcDBOcDVCOGw2WXQzNEFickVqdFlsUXFlNTNRMEFQcHg5?=
 =?utf-8?B?MGZKang2ME5GSjdGR2xRQUs4R3NXdkFRMXdaY25LQ1RrcWRrOHA0UW44eHJu?=
 =?utf-8?B?cUErVWh3Zk5ydTdSRjhZbGpsMUNYSUEwdUxlWmZOVTZuNXl6dHFQYWVtWkg3?=
 =?utf-8?B?cjdVckR0ZUZqK1BiV1hoemxQRERmRSs5NmVkenE0RVZtL2hnZ0poT0pDT1Fu?=
 =?utf-8?B?bnA5WTU1T1kvRjNkeDdaQThrOWp0Q2VZOHdtSDRwVkc0SFpycXZBeDlGSmxH?=
 =?utf-8?B?MDBYWjNhaFFxZFNQbUhsU1JpcHA5dlFDZWhNbkNGR2hFM2Q0ZnZJTERxSFU2?=
 =?utf-8?B?QlVRMHVNek9qNUFhQjB1VlB1cE5NTU9EcUNOZnpQbWcwZ1hSNUlranFSN1hM?=
 =?utf-8?B?WmpDSkFTWm1jUU1ZYkxHemR5RFpGcVNDY2p6eXM4dVliK1RqckxoeE1iaUxE?=
 =?utf-8?B?a1g4TmJCajhneEQxRjBpVnZWd1pCQjFxOHI2VmE1ZFdXWS9IZ3lWOEF2YS9N?=
 =?utf-8?B?em5YcElTaGRDb1c5SXdKSXl5NjNFWlI3Sit3TlJvUXZWM0psUTFhWjJCMmhY?=
 =?utf-8?B?ZFhMN2RhOW94b29VYlRWZXgxRmV2TVQxL1N5b05ESVZEdkZrQzMvcGhPeExN?=
 =?utf-8?B?NElTNko5UXNuUzZ5aGZRSy96NUxOc1VZaFdJd3pzdWF4OVlOeHpTUDczWEpC?=
 =?utf-8?B?TXIyTU94M0xjOXM3K3ZLM25TeXo5K2pDL0JCQUZ4MTZTd2ZIeUZtTGZhT0tY?=
 =?utf-8?B?MGFENFN1YmNMK3YrR25CUlRkdGY0alhUeFRRVXNFenFUWTVSVHM4b3NneStn?=
 =?utf-8?B?NWNjN1VMcU1NQ25MSWZSZnVraDFFMnAvbXg3TjVTTFl2OG1MOS80bFZLMXl1?=
 =?utf-8?B?WTlzYkhIRDNORUJTR3ZCajJvZ2F1eWpKRmN0Q3EvazdWNTF3bSt1NFdiMUxq?=
 =?utf-8?B?WW5VZEJObzJBVlRVV1ZuVGtXMCtvaGhZOWs1OE1uTnNXU08va21jNE9DYjRB?=
 =?utf-8?B?ejhhNU9ldU9OQUxySTNON2ZXbVdOK055UFZLZHpLczVaQS9OaUFidE1tM3Y3?=
 =?utf-8?B?YkJHVExveWxEeWU3a3dSRHg3eTkyRWk5OEFwK2hDMFNoN1RBMzZvb2Vma2FW?=
 =?utf-8?B?MkdwaEdaWE9DRUZxQ3oxYnRtRDdJd2RmRWpidVFLWlpUNmphYkFkUjU4aFh2?=
 =?utf-8?B?QnZBSDZtaDFiLzU3eUVkUzNRbi9nZXY3azFyRmxST2ZUYzlJakF3R0pMU0lR?=
 =?utf-8?B?U3lFLzJHNTZWVGhVK3E5S1pGSGJpc1VqV252dWNXdkN5cGFkZms3R3FPUU5D?=
 =?utf-8?Q?9D4asM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 03:23:42.3985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4076dce7-3f67-457b-4a9d-08ddf1abc644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568

Hello Tim,

On 9/12/2025 12:00 AM, Tim Chen wrote:
> +static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
> +		int **dist, int *levels)
> +

nit. Is the blank line above intentional?

Also personally I prefer breaking the two lines above as:

static int
sched_record_numa_dist(int offline_node, int (*n_dist)(int, int), int **dist, int *levels)
{
	...
}

>  {
> -	struct sched_domain_topology_level *tl;
>  	unsigned long *distance_map;

Since we are breaking this out and adding return values, can we also
cleanup that bitmap_free() before every return with __free(bitmap) like:

(Only build tested)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6c0ff62322cb..baa79e79ced8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1910,9 +1910,8 @@ static int numa_node_dist(int i, int j)
 
 static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
 		int **dist, int *levels)
-
 {
-	unsigned long *distance_map;
+	unsigned long *distance_map __free(bitmap) = NULL;
 	int nr_levels = 0;
 	int i, j;
 	int *distances;
@@ -1932,7 +1931,6 @@ static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
-				bitmap_free(distance_map);
 				return -EINVAL;
 			}
 
@@ -1946,19 +1944,17 @@ static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
 	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
 
 	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!distances) {
-		bitmap_free(distance_map);
+	if (!distances)
 		return -ENOMEM;
-	}
+
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
 		distances[i] = j;
 	}
+
 	*dist = distances;
 	*levels = nr_levels;
 
-	bitmap_free(distance_map);
-
 	return 0;
 }
 
---

>  	int nr_levels = 0;
>  	int i, j;
>  	int *distances;
> -	struct cpumask ***masks;
>  
>  	/*
>  	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
> @@ -1902,17 +1923,17 @@ void sched_init_numa(int offline_node)
>  	 */
>  	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
>  	if (!distance_map)
> -		return;
> +		return -ENOMEM;
>  
>  	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
>  	for_each_cpu_node_but(i, offline_node) {
>  		for_each_cpu_node_but(j, offline_node) {
> -			int distance = node_distance(i, j);
> +			int distance = n_dist(i, j);
>  
>  			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
>  				sched_numa_warn("Invalid distance value range");
>  				bitmap_free(distance_map);
> -				return;
> +				return -EINVAL;
>  			}
>  
>  			bitmap_set(distance_map, distance, 1);
> @@ -1927,17 +1948,66 @@ void sched_init_numa(int offline_node)
>  	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
>  	if (!distances) {
>  		bitmap_free(distance_map);
> -		return;
> +		return -ENOMEM;
>  	}
> -
>  	for (i = 0, j = 0; i < nr_levels; i++, j++) {
>  		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>  		distances[i] = j;
>  	}
> -	rcu_assign_pointer(sched_domains_numa_distance, distances);
> +	*dist = distances;
> +	*levels = nr_levels;
>  
>  	bitmap_free(distance_map);
>  
> +	return 0;
> +}
> +
> +static int avg_remote_numa_distance(int offline_node)
> +{
> +	int i, j;
> +	int distance, nr_remote = 0, total_distance = 0;
> +
> +	for_each_cpu_node_but(i, offline_node) {
> +		for_each_cpu_node_but(j, offline_node) {
> +			distance = node_distance(i, j);
> +
> +			if (distance >= REMOTE_DISTANCE) {
> +				nr_remote++;
> +				total_distance += distance;
> +			}
> +		}
> +	}
> +	if (nr_remote)
> +		return total_distance / nr_remote;
> +	else
> +		return REMOTE_DISTANCE;
> +}
> +
> +void sched_init_numa(int offline_node)
> +{
> +	struct sched_domain_topology_level *tl;
> +	int nr_levels, nr_node_levels;
> +	int i, j;
> +	int *distances, *domain_distances;
> +	struct cpumask ***masks;
> +
> +	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
> +				   &nr_node_levels))
> +		return;
> +
> +	WRITE_ONCE(sched_avg_remote_numa_distance,
> +		   avg_remote_numa_distance(offline_node));

nit.

Can add a small comment here saying arch_sched_node_distance() may
depend on sched_avg_remote_numa_distance and requires it to be
initialized correctly before computing domain_distances.

Apart from those nitpicks, the changes look good to me. Please feel free
to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> +
> +	if (sched_record_numa_dist(offline_node,
> +				   arch_sched_node_distance, &domain_distances,
> +				   &nr_levels)) {
> +		kfree(distances);
> +		return;
> +	}
> +	rcu_assign_pointer(sched_numa_node_distance, distances);
> +	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
> +	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
> +
>  	/*
>  	 * 'nr_levels' contains the number of unique distances
>  	 *


