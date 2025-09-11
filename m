Return-Path: <linux-kernel+bounces-811447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E77B52934
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BAA1BC5AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E626255248;
	Thu, 11 Sep 2025 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iplhEnno"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAE71DFD8F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573112; cv=fail; b=ApMtjCH9I2mvVyEj3PFqvGs9qUc3MUvscic1oBiea5U42szeSByIbWO6pt0mLkRdijRgvDnPiJ4embHRUnqgA1NYtNaV5xB0APkx+zHMoO/ksBlx6Aa63fp6tlrgk1t5VJ4sXGWwqdF/whQVAeKF+UoPo1PePHKErcs7MX6q40I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573112; c=relaxed/simple;
	bh=M5bl07MIHPee9WRmwWZMWmahMXLrnV+zVog+gT0WBvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bXA0WPKnBr+PdmlIBsnic7SQMxeOuySZCfeZRfHrz0Qmh7hJ879UX8/Vo1LZEy/Ib83W6BQ9bL6tk9/RL5IxiTYQv0/jnnQ8j984+PWLh/AqBa5gKvsRP82fe2XjFq/gNFcKKqrSj4KKk2E+sdBOI5L81s3kCvdTKNMNYqpOjP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iplhEnno; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKqV0coIC1kOfxT+xEJ7dZ9yR+r2mbxErEH7Sb2FVGs/6z5EDZXrCRaIPcL2bSAZnH4hcF2ZDaq/6HoaqEQ6rsMqXc9wBuEZmnQTwgEbyFycC0GUafnGv0S8LA/dIEN1dphdN7He78qsp5sfmDmJ9wfoMtWKJFz2Oq3wEm71L5GfUev3oRJ7YeiNQOkmWBYryIY5NHXUv21HwuGSZC70nc1emm/FFqhn4ju9vhEU/fMdx0FASokyJ3wAHDuo+1iZUAVjN0zXKcFkZ9/leKzF2rD8ht8IrszxyXt6U+zWjF9VuSH3oNBcMIsQWbF1vv7i6cSSZd47SSxiUqyHfYgudQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAAaFzVzdz1xxb7KdcVPmDGcrUaOYUYFyIxeUvj/XDI=;
 b=RVwc2V4EVvXPUnu1lOws7kFdNisN8Lj+r4Ky0RJSH7ijWtKJtjAO8zmoN0Iv7kyqGyBf0DqyBR0O+VOktn+6q3CmcF+SsEajQnuJPNi2O1o01bmyqWk1m1/9gWD7IAquqfIfmcINu0HSSQ64m85PrbztpgGfGqG9Sky883ZGRVoY4t6YDi2WPh/flPhaOpvvWonFTYfu7PZYsilcHXcxPsPc56jDQkiEodU9K8fbZL9V3n2CrQX4HzIK1bOf2ysrhWctsb6AC7xRns2S08oZqewoK9lX8a08LJvKX3m4Gg1prD2MTHFaELNdAW4yG7rOQF9z7LnTzXYJpnFFoaYIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAAaFzVzdz1xxb7KdcVPmDGcrUaOYUYFyIxeUvj/XDI=;
 b=iplhEnno2OEH26IkZl1lhffe2zTTuUYErDxTTs2hawf4tyR1Z1VgrP+V4/acyP9t9EFSCiHub0IUdjIVeyYKc2+px8YD7dqIk8gmtl7ZEF6dB39rpSkXU141LNeT0ze+KEXeWzvWgmhmWD253l271FKD4gP7tmdl0Kfb+xb/SkI=
Received: from CY5PR13CA0088.namprd13.prod.outlook.com (2603:10b6:930:a::43)
 by LV5PR12MB9756.namprd12.prod.outlook.com (2603:10b6:408:2fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 06:45:08 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:a:cafe::5d) by CY5PR13CA0088.outlook.office365.com
 (2603:10b6:930:a::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Thu,
 11 Sep 2025 06:45:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 06:45:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 23:45:02 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 23:45:02 -0700
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 23:44:58 -0700
Message-ID: <1456057a-6289-491a-a776-84856226d97b@amd.com>
Date: Thu, 11 Sep 2025 12:14:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: fair: drop useless cpumask_empty() in
 find_energy_efficient_cpu()
To: Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250911023426.457745-1-yury.norov@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250911023426.457745-1-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV5PR12MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: 98fc312f-8270-44ea-2024-08ddf0febf2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnJ3RTJrVWdSYzhGOGNDTmVTMGcyUWJacUQwRm9QNEo2SmQyeU5qQW9OMVBa?=
 =?utf-8?B?dXpicFlTTDlrWGczUUgzRG1mTm9zVFhsblBjNW9uS3ZFRTRoQ1pmU3RpQzdF?=
 =?utf-8?B?REgwU2ZHRGdlTmRHQ0wyamJ0SVlXajlvcEo5YXJ3YlpKQldXV1p0N3loNHBu?=
 =?utf-8?B?U1hzdWdCK2RWKzM3YlZnWnhlVE5GNk9NRTkzK3g2RjVucUNEeDhGcjdwNWxR?=
 =?utf-8?B?K3JZVkRsSVhKTUNVRkIzWUlxTnZlbFlXUll4eHZxdmZOMTlObTdaR0lTcjAw?=
 =?utf-8?B?TnpkMTQ5UytXR095MnRjOWFIRjNEYzFNQWEwOXJ3cWVsaE9SMEtvcGw3NGNV?=
 =?utf-8?B?dEZhYXkxLzE2WlV0amtoSnNUdENiWGlIMkxLSG9mbzBPaWduTlhIZ3dRVi9S?=
 =?utf-8?B?V2lpaUZ4c0lhTDBpSmN2SkRnZW9oQ28vbU84NnpROFdkL2k2ZTBuS3cyS3Zh?=
 =?utf-8?B?Y3NVLzQ2OFlleXhhM3p1RUhVSkpVeDR4cDZvMENyNERXRHcreDFHc1YvMzFH?=
 =?utf-8?B?YUJZWVg2Y2paUGk3ODYrdysrTUFBZEpENlpLeVE2eTBBM0U5VUxtUGNTVFVH?=
 =?utf-8?B?bWdIa1lxVmc5b05oZmZSZjA1a2FCb1MxbjNBdVkwRnB4c3NiaEFXU2tJaDRu?=
 =?utf-8?B?aTVDQldYV29qTGR1VC9oOXdBdDBFWXk3OTJrSmE1a1dOeG83VXlqclhDYmRp?=
 =?utf-8?B?WWhNaXJGVWVkcmRLeUFYS0h3eW1WcFhMQ04vNWV6TU1lVXYyNllYQ1JQMEYv?=
 =?utf-8?B?dWkzQW5FMVFBSXJJYzBYK2dCVWVuRGdzcnVLbHNVdk56NzdNcUVPejBDZmdt?=
 =?utf-8?B?Sk9nS0VoRXdlSlBHTVNpbVRjT0FKcVV5cTFOUjdTYVlOZFRQb1l6Wkw5SS8w?=
 =?utf-8?B?eDVJemxVVzRjNXFYUVNUL2IweUZuQ25QWmlEOWtGTWFmTTFzR0tuYUVtUnM5?=
 =?utf-8?B?RDFmU2dzdFREQ3h4T2JJTjRaaHcyOTlWT2NuSGZqSiszWkZETG9pUHdrZE5X?=
 =?utf-8?B?QzFDZzRpb3BaS2pPUEYwU2pHTzFDNVBQN2RmRzBZSFhDam5VeTcvYnl3Q2ZK?=
 =?utf-8?B?V1ZCZTh2K2hSR2RRenlRNHQzazFFSUFJazlodmlPTFRvbTBvNnJxcmI2eStk?=
 =?utf-8?B?LzZnTXNYdHRERXM2M0VueFZIOUdtZWZFdEVELzQ5RXZ0YW9PcTdlOHJBbDdH?=
 =?utf-8?B?cmg3c3NJL1F3ZUdQZG9kRVcxMHU1NHRrL04vRlp0Z01HbzNsYTY3bzR2ZlRB?=
 =?utf-8?B?Rk1abzFlcWtuTEE2YnE5RzFhR2g1Y05vOW1DZGpzMzVBbXBnczk5cytISWFy?=
 =?utf-8?B?WTFhY3FEMnJLb1o0UFRmZnVPQXRzZG05ZWcxVHNZU3lYaU9jYldPcDM3VVBK?=
 =?utf-8?B?RGowWU5tZ1V1akZCdXhTTGd2cGRHUVZHU2MySWFFMmMzOWpoVHJyMHVpSHcr?=
 =?utf-8?B?T0NmMldieVNqcDZQMVZ5SWs4QVlqbGoyUk91U1UxWkxwc3UxSTZ2dDgvOFQ1?=
 =?utf-8?B?RnNiUFF0YnRnSlpaeVp4ZDBVaWllWmZia2IrMHRTQzRVMzRsZytWSnZEcGNU?=
 =?utf-8?B?aFNNcGNVNnhDc2hJNnU4ZndlY0JEZk1YbzUwOWc2MlJHSzl5eDBqamJuczZH?=
 =?utf-8?B?ZytyZEJZazBDWWxRVEtRKzJNOUMwbEplNXIwT2VJOGRiZEhuYUlvR2U3LzF4?=
 =?utf-8?B?TzVUSVpTbG83dm4xR2d0SC9OdHRFTm80c2NBZEhyVit2YkczZXlVOHA3MVNt?=
 =?utf-8?B?S0cycnMrSFdmYmFyK3ArQytCemRNUDdxZ2k0bDkyVTl2aHVWRUFVSkhTWWQ2?=
 =?utf-8?B?RnlmblExZmZnVlQ2aDUrekpaNE1jUTZtL0NTam9CVjRmQ2x3VERzMGJLVGhx?=
 =?utf-8?B?T0IwR1lyM1FmZXhHbG9qeUVTY1ZCVU9mbU9EQ0twRE5vbzJFNTNYSlBkR3Q4?=
 =?utf-8?B?WEhCMVE5ejV2dVdHUGU2UzFaOW9vUTVsRnZPbldydHhsTi8rVjBmRVRRckdN?=
 =?utf-8?B?aGRiWk1yVktHVkZidElFdmRTNXpIQ21Ma0NSQk0veFhpMVFEUFVqUTRhaTEw?=
 =?utf-8?B?OGRoU1ZPcnVMT1Q2SXJUOTRYVHBXSmh5emc4UT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 06:45:07.5438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fc312f-8270-44ea-2024-08ddf0febf2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9756

Hello Yury,

On 9/11/2025 8:04 AM, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> cpumask_empty() call is O(N) and useless, because the previous
> cpumask_and() returns false for empty 'cpus'.

I agree. Please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  kernel/sched/fair.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b173a059315c..7229339cbb1b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8320,9 +8320,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  		int max_spare_cap_cpu = -1;
>  		int fits, max_fits = -1;
>  
> -		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> -
> -		if (cpumask_empty(cpus))
> +		if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
>  			continue;
>  
>  		/* Account external pressure for the energy estimation */

-- 
Thanks and Regards,
Prateek


