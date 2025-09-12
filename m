Return-Path: <linux-kernel+bounces-813089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6090B54091
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BF517A8083
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38F20E6F3;
	Fri, 12 Sep 2025 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qsw+Pe59"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69D1D5146
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644832; cv=fail; b=VU97hqVLXNYwSIouAXkS11lgyMEg9cmXMnd9imF/2TZEGCaenllrH9aLMvzWSMatDSIQuipVW/IyQ4RqVNyFsnfBU142u1E+pXvh4xWtaWlbD/6GHZCwr89WZ72AFU0urN89Moa5LH6q50fawHKBasNRqvGP6IcNAiXtkvqvDJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644832; c=relaxed/simple;
	bh=RoxdYZGxOSrTQOwPrQMbtnBfVDse/K5V+fQl8as/yUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=prJvwVxqS0QnmGzOZE+0dUIy1Iid4jVSnU5zq1/m/eSxeIgWYnxTCU+3Iidh0qTw8gcxgHeGv6MJPbf/jWByyMP2525RgkQcKo92OEcU45oOCjmgYEbaNq28A6JlClf9f2EER8J/rhx/yJobHYwPG67SeeCRr4DjKGTdU/4NDlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qsw+Pe59; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biWDk+Qk6C87kUWT2J2SSVuHhaaeEw9eZ7uR6nRRYDQETWMMHTP8wrqsyYs2qqsQZyfeLCWMpL7AeASoj+uTURFkBYEs0BnTVyKfExrwVJ+a8t/AiHMekwnklSO3I+qfikrK5PEWfauTADmjCFuFJwoOMFPIB4nOs+lm7ilVrpAFVNfNItMwYXA9tBXwXy2Z6Ew3FHWJzcjY4uyqnHTGU18OyW9oeWNwPEqoVYjG2TLVr3klFSQwZGz122UhHNvu6Mwq/5PT5h5SFinRF46d0XKdpzb4WW7QCr8RX/1tO9PsaYhb9FOLogeQW/dapwi9iQSBz5aJaZn5SAuZJvy++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWFQgvbfSFCt5+GWnwfMDQavlZwu8VgPoTmNQaGR9kA=;
 b=sNbp0iLv3CxBiLTEIl7Q+gzH4rDSI/O65uErdUMED8URXfwvHLOnw1a5K22mzVcEBR80gzhU9i9WPaxmoBKVx1KyIlDvG9NnU7jLEhJ3lfBileFKmBSPqMpNtlzv467JhUlQxJvF2kjZQ9C1J04ClFKM0jiEUtaNtIGFbJX/Ss8olb+gpspHv1AMTg1azWpUTmHHmOumJftr7xTlRgJMyRRXga4vGMhDUxrdJ74jUC/z2daoYWXHMGF4VvItvJMEh2ZBosqxsGAZ1g9z1JahlVj+TplwMHbHo9p0HqFNJhNgGW/yINIPJ0MqixHmmWoidOAtzep/ihsgKq5EPuVa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWFQgvbfSFCt5+GWnwfMDQavlZwu8VgPoTmNQaGR9kA=;
 b=Qsw+Pe59FLVEem4XXccjtP+BQfOGpo3rFgtLjCypOqTd6YFI1/BOn60WARg2eom5E4ahYBwdnun1H1e9gu0Xj9SQyaONWG9AO6/mvH9YQW8VlNc6bJ2FXA1o+H3p0WRYu++Vl+p5nvxoyAWbHC4J1X6EilXyWo1AEeYdffrA6rg=
Received: from SJ0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:a03:39e::31)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:40:27 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::16) by SJ0PR03CA0296.outlook.office365.com
 (2603:10b6:a03:39e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 02:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 02:40:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 19:40:26 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 19:40:26 -0700
Received: from [10.136.41.4] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 19:40:22 -0700
Message-ID: <d8bb7091-7127-41df-9a2d-0b51897592a7@amd.com>
Date: Fri, 12 Sep 2025 08:10:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: simplify task_numa_find_cpu()
To: Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250911203136.548844-1-yury.norov@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250911203136.548844-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ae8f6c-b323-44c1-bb8e-08ddf1a5bb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzh3UTFKclNoYUJZM2xHMGMrQUtQTEZaRTlUN3Q5L0trb3NkQzNUL1dkNmRH?=
 =?utf-8?B?THFrNkNqTUo1S3VUanp5QUxGZ25DTy9QUWUwZVU4aDRHRmhMUTRZNXpjaFMz?=
 =?utf-8?B?TXNtaDBMWllhcHJJRjE2NVVlcWpGTjJKT29SZkJyRkFWMVpCcnhWWUI4ZXh6?=
 =?utf-8?B?Z29pbFFYQTF2TWR4eXgzY2pPVnZJYTQxRjJIKzNmUTdTTlBUbmJheE5lcU50?=
 =?utf-8?B?akVYMy92SHhHL0pxQnZrc09MWFNZUWFieWU5dGkwT2Rta05Ka2VSRGRtcWdr?=
 =?utf-8?B?d3lWOXplNk5yUllhQmFmVW40NDhTakV0NHUzbGh2M2ROQVpVV0ZqR1B1TkF0?=
 =?utf-8?B?aElGUnRLYTBseDJMNUU2NUprdGpaREJ1ckFCa1lIZXZSTjgzWk1nS2hva1c3?=
 =?utf-8?B?TXV6TXhyN3RFYnpGS3MwZkFYbElURnBWZDM1YTRVN2ovbU5XSHZPSzBWZ0ta?=
 =?utf-8?B?Zkk3ZGtBcTRTQ1FRVlQzWkQ3c1FaaEZNZG4rN2NIOGlQOTh6Q1A4U1ZjdENZ?=
 =?utf-8?B?bnJVNUtQNEk2S3JlZWdNTUN5cUlOTEVIZGRHTVplZFVPTzNSSE5yNFozdC9J?=
 =?utf-8?B?djNPTEtNZVo5MVJVaFBIb1NYZ2tHY1VpYmtzSVN4OTEzcUEweEZjd2QxT0tv?=
 =?utf-8?B?Y2xyeDJzWXRuRTNrbEh2OG9WQTU2eGRtMnFFQXo2NmgrcTRDcUQrSVJiSXM2?=
 =?utf-8?B?SWJuL3dwVy9wSDBPQVR6TFRIdFpQZTR0N1VzRzJzV0N3aVgxL2xpM3NBbTVW?=
 =?utf-8?B?aEo0LzBGQXlsTUVhRm0rMytLaVJJUGR5V25mTERHcGRQRlArSjZkQnI2dmhN?=
 =?utf-8?B?OWJKRG9DYk9KU3BWY2o1TG0yOTZseS9ITm1uMlU0SjhiM2ppSjU1c1R3My9L?=
 =?utf-8?B?TjZXc2ZOd0VvZDE1SlBVejhQNm5LZktJVmMvamViTm9BZnhVbkp6c1V2bFRD?=
 =?utf-8?B?THVMSWhvM0tUOFNEYXdLc25CV1UvY3Q1Y0VrbUF4U0FnMGhKVS9TaDhzbHBl?=
 =?utf-8?B?c0hUUklXUUN3OEhQclQ3RzhpT3pwUEpYaVk0MkxyM2V2RCs4WnYrSktFN1gx?=
 =?utf-8?B?K2N4Wmw3djRzTWVnSUUzbDRrcEl6UElsTU01R3NvS1pkWHBXOFVWZG9lQTNO?=
 =?utf-8?B?cGZMNjRnVThKM0ZKRDMzZE1ZNDZMWXJySkxqMmhIVWYwc0xXTUZNdnpHZnhK?=
 =?utf-8?B?UzRZMFQ4L2dpSnVhYmlIUjVvaTFheHZ6N2ZuOE9YTjUreE96R2lJVGdEN25W?=
 =?utf-8?B?SFN1WnJUa1pGaFRDUDRTdE5ldkJ1N01zbFJxN2NIeFhreXU3ajk1cnJzNjhI?=
 =?utf-8?B?dUVmZzN6bW5hY1c1SGs4MXZzYTZRZ2ZZbDlOT1A5S1dieWZOY24wWnk1eTFn?=
 =?utf-8?B?SmlmS29FOXFFUUFlUG1XYWw2Kzl4YUF2RDg5aHNBV0w0YlppNnVFTjlLU1hI?=
 =?utf-8?B?YjlJMDBnYndXRVk0S2g4UjlFRUhmMnc0VlhmOU43QktpNjdJV0JpNVgycE0w?=
 =?utf-8?B?elplL0FvT3k3T0VPanQydmRvQWZ6SkxqWCtUOGRRejJQYTVpb0xQWWtGb2RC?=
 =?utf-8?B?K0UxV2VLUEV4dU0xMjhHYTIzYkJnZDhYVExMUnplbm5Kb0Jwb1NQRzluSDMy?=
 =?utf-8?B?NkRnbHZnR0h6eGE5djZlNTRiRWxmZTh4QS9GRTJuSU5YOXcyZVRVSzd5Z1hE?=
 =?utf-8?B?aU8xL3pUY0YxeHhSZEs2OVNiL3ZqWGpnM1FnaWNJRjJvUkl0T1BZSHZ5b1VS?=
 =?utf-8?B?QUI1THhOUmF2SWN1SUJwaEF3ekZDTDhaUStWbE5GOEY1MFBhNnQ5VXBBNS9F?=
 =?utf-8?B?ZmRQRllyZW1QQUxLYmk3Zkx3Y1hXcGRPQ0ZtVEJydUs2UXJyYitJYlR5UmQ1?=
 =?utf-8?B?dURlekkwM2JJeFc2ZkdUeDRtSFN6K0FMS2t1MmI4aXdSeEprL3BwQlh1ejFW?=
 =?utf-8?B?SU55SXNGZjUwVHJ2bmtjNE9Ta1RQTFh5RzZFSUpoaHBpM2RWMVBQMFBnQ1F6?=
 =?utf-8?B?WmQ1SlZEVnNpSTc0VE92MVY4SlpCVHBZdldiVDZJNUFEZ3RrejVkQTdVMEYz?=
 =?utf-8?B?QlFPR3Rna253Qm5SYTZTcTQwd05HVDFLbFV2QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 02:40:27.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ae8f6c-b323-44c1-bb8e-08ddf1a5bb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731

Hello Yury,

On 9/12/2025 2:01 AM, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Use for_each_cpu_and() and drop some housekeeping code.

Please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/sched/fair.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0990ed90c14e..c48c0975fe7a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2474,11 +2474,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		maymove = !load_too_imbalanced(src_load, dst_load, env);
>  	}
>  
> -	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
> -		/* Skip this CPU if the source task cannot migrate */
> -		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
> -			continue;
> -
> +	/* Skip CPUs if the source task cannot migrate */
> +	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
>  		env->dst_cpu = cpu;
>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>  			break;

-- 
Thanks and Regards,
Prateek


