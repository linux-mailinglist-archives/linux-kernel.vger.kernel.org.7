Return-Path: <linux-kernel+bounces-877508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF7C1E51B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E88CC4E4133
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40EA2E3360;
	Thu, 30 Oct 2025 04:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e6b9jNhD"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774D6D1A7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797054; cv=fail; b=ar1dENNtq7dw9Vdom7rHfHYShKapqFN3a6tOVPjgibGMMVBzzUjgf+PYD3zvIHfa4oPPDuhd1pLM6wh4BG4qmuntjcJph4YC1PXdzjJx7wmJoKzhtHrOopbmXujE2CP+SjkwTTToogijzswLHH0fh7GTIaGwUpyTVM4W57K+0aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797054; c=relaxed/simple;
	bh=pdgwV/czwcZMDC03MyfBf0Ep8xJ/y2dj2ttpT1h7Pao=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LaM11jHbp0p8VOW5DDnEja6r4Wp5KMD3aFb/Ieq7psQA1ffhWPw+XrzT88ewF360AfOPsOvwjlTnQHVedlpTXS0Ke4/9CvryXczWVeN0BjHxNsMFZd7qyyJFhLN7M7Afwh8FLOHz6S6CWJR4NJie5sUNo59qYQVQ1RQzeHxu34s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e6b9jNhD; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3ceb6DK5v1QufddL0EQC3qt+CyyQ4l/z0xKguQn0ZeutmHv9k06TQzZ637YK5KTgvcxYO6xvGZoxZj7iVByRclcsc4KSLLvFuaEyzT567mmxrWIDBU5xe9vQxSjIxvhsqu9aC7faKDqE0Orcm8jICrZItnwFZVpqBSuGJ/ggru0AvBpwezQjkirLv6mfMNyStkvq/3V2S7QIoM8VKU1eYGSy9ppqSBrpnSsx9fagfVkVt0BQPfE15oOAQT7VUduVKwBCxEyf1l6sK5EWlLZ6cSASGV2W4xMgkIoJOoYMUl3f/T8JkzOC/8BiEoGXeUY4UJn2E9b+MPTofv41KNnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySZajJ0wZdXivaBJQVBuKqac2MJ3XL55Ky5/deISggg=;
 b=ZNgzJ1wKBophc/2wbEK7Wc3f3MPowuknOGOtjrdBqq4A6ztoIGA0RjU6Qql6gbIjqaPi9bshbvzgbHl7Fl53KgEY8WSzYrKAH5FbxfT1ZaaORVG+zfQuW5LFn1nayzYVNnyj+6YSJTjqArudntQNqOiPNXVysAXonu5YyqR0EsNAx/DHK1b8Muul0iuRnWlrltj4DvvN74zYCUPoroPOXef91wz+DkMXnw3F4rOPRH0YwYSkrzG2Dzp6MSjRvdYunbp6se4KSWqJ0mwq5GVcSgmNbtarfBAyZgIT3BhU+s9N0UkUCLeezzjIZjb8lR3KjIfmUU/yyG7sQKsmbHuKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySZajJ0wZdXivaBJQVBuKqac2MJ3XL55Ky5/deISggg=;
 b=e6b9jNhDWGFcKDajynyELDQ+jRZRnBUKle7LjXtU8sbaUidLhDneHioP4oPttEEeV9AwTQ67fmCGka9tJ9OCSgMy9+f6Gw6E71l+FGcxUtmjuMnHDSImeZwa0EUJFQUyMSjxn/np36i3F10bDDWu/X6yq8d0hWl4NBvg+uvYlGg=
Received: from BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 04:04:06 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::e9) by BL1PR13CA0283.outlook.office365.com
 (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 04:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 04:04:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 29 Oct
 2025 21:04:04 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 23:04:04 -0500
Received: from [10.136.32.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 21:04:01 -0700
Message-ID: <ee2746bd-1baa-48b1-bdaf-89c14a21b4fc@amd.com>
Date: Thu, 30 Oct 2025 09:34:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Remove double update_rq_clock() in
 __set_cpus_allowed_ptr_locked()
To: Hao Jia <jiahao.kernel@gmail.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <mingo@kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Hao Jia <jiahao1@lixiang.com>
References: <20251029093655.31252-1-jiahao.kernel@gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251029093655.31252-1-jiahao.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CH1PPFF5B95D789:EE_
X-MS-Office365-Filtering-Correlation-Id: c9069c01-77f2-4382-2c9f-08de17695ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVJNLzZIZlZ5bldkMTFkQXdWN0JWeUIvZXdyZXFOSitYb1lGMDZNNnMyeTlu?=
 =?utf-8?B?MFV4VXJ2Z3k5ZmtwRDF0ZEdGekxrWEFJbFVrYmN5Q1AvSHBENzdYL0RwQzlX?=
 =?utf-8?B?d212N2h2Q1U0TmVmbzJzLzJmZGNiYXBqdXkwcnRkWGc1QU94Z2Rxa3UvYjJu?=
 =?utf-8?B?WGJObnllMmpuOTFlU0FVKzdzRWFkQnJVZXNJZkg5WncwRHo0ZHBHbVo1UEY3?=
 =?utf-8?B?K1JXK0tkNnpVcFZtcjNWcXJaQ0I2b3BraTFEVGRsUTFpS0dhVnY0QllLZDNU?=
 =?utf-8?B?MWYrMFU1LzZiUkRlUzFJQjc4aDBocC9pQ2VpVHZWSHB3ZG45NWVVQTZMKzFh?=
 =?utf-8?B?L3EwNHZWOXNhSm5MU0tQNjNFbUhxUFk0cVpRb2svaEJCV2lPTkZwbTdYeVhH?=
 =?utf-8?B?NUlySlkvNlVadFN0N3J4a1R2K28rU0Nxd3NCbVBtZm4rdjdQUE9HUUMrMmV2?=
 =?utf-8?B?QkJ4ZXV1NHJjS3NkeG5ERnNIc0VmK0habXNkcVRPdE8vUWx1ZHRBVTZZVUEw?=
 =?utf-8?B?K2ZhQmpBV1loOEFPdEVta1YvOU5oKzU5NWtwbDJ3VGRBcFZFcG5waVpGbXFn?=
 =?utf-8?B?NEEydXlsMmJ5SWpwWGJac003RUhvcEFMQmJ0US9yaFRWS3ZOdVpaZ2VxZ2NB?=
 =?utf-8?B?c1MwUk9haklQVGMrOHJuaEhIeWF6NXpWUWxDejVaYWN5SktzTnRtOGxaYmdU?=
 =?utf-8?B?QlY4SHF3dkFKMGRybUhDOGY2UmRYVHpQUXhMWktGTTZIdmgrUzZ5WFhsaUxO?=
 =?utf-8?B?ejZzZXI0NElxTzMrcy80V2RKUlR2OEUzTzZZL0xNUHF2TE5tVG1IangweXhr?=
 =?utf-8?B?OXNDVEd2WUJmbGZENEFGb2RaclRpS3FuUk4xQnIvdHUxaDNOQjkvcTZTS0k3?=
 =?utf-8?B?dVVxMjIwakxrekIvSEU3ZzZDMGJtMFJUQjdDRFROalZIdmp5K0dHS2N3ajAw?=
 =?utf-8?B?Q0FKS3cyd2JNRWorQ1pnSm1ibGhUVEVPVmkzZS9zVWRJR3JQZEROVlBmUFJh?=
 =?utf-8?B?QVl6dDB2aWVORTB5Uy9WOUhnWU14VFNLY3FwRzRpYXZPeEhBaDl3MWZBTldG?=
 =?utf-8?B?QTJJRHIzSGpWNkNKWnF0cHBVSWpSMTVqSGNQR3lKVy9nSU9ab0thSVk3Wm5i?=
 =?utf-8?B?MWxJWWljeGlxdXFXazEzK2NlakVmZ2JKaldwWTJXZ0p4MTlCQXRJRVg4enJa?=
 =?utf-8?B?eXNpWXBOOFoyQzJQcmh1QXA0Sm5zZmU1NXRrQTB6NElubnBDRTJtcXpYU2Qx?=
 =?utf-8?B?VDUyazhUNzI0eUVlUlpCUDlDcndWeFFRd0M2eXNzT0FQNTVoYm5URVpxS21l?=
 =?utf-8?B?ZHV3WkR1cUtydi9GWTlyL0ZyNkRmS2d1RmRuMVZxVnNTbTR0UzVMZ3dYOUFM?=
 =?utf-8?B?Qk1nQ3NhNE4zcStyUDFvVXV2dWQ2RmZLZ2dpZHVxYXA1QXZxekc5QWRVdHg5?=
 =?utf-8?B?RlpiN3pZNUlWUzRyNUpFbXkzejBiWG55M2R6b0tMM0pCTlFBeWNUUVgycWkr?=
 =?utf-8?B?UHozTDE5NUpnek85NU92MkI2eGpid1hwV2haaHNuR2xERlFJUFpXUEx5Rk9s?=
 =?utf-8?B?N3l0ZUxUM253SmVUNU1SdFNyVnJBVkVwU2FLVldPRllLUzBtK0dodmNwYjBO?=
 =?utf-8?B?NFNNSHBYd2htVk1nenZDQ3Q3c2pUR0JuNExSSkxPekFZN2ROREN2SHBEa290?=
 =?utf-8?B?K2ZKRjZ1dHlnT1ZybEowK1BFS2lNY1I4ZXZHYlVKb0xhZVh6VXY5a0dsbXNu?=
 =?utf-8?B?bGRsZFV1TzhkYnVNcHh1Z3NmcmhSYzFsY1BjdHB5VXhzY1dHalE5L2IzRzdM?=
 =?utf-8?B?QXFCYklMK2Q5VEFpbEhHSHEzZExZSm5VQ1ZOMEpzMUJ6anZ2YXVzOUpYRTBD?=
 =?utf-8?B?dncrYVlwdng2WWFxeHNjWmVqSWs0TlY2d0pVU2RPK2RaczM5N2liQjVLc3NS?=
 =?utf-8?B?VU5CVzY5VDRudVk5djFFTE9XZ09qNVY3OUZzVVdsZ2Z6bCsvUDF1R3cxbUQ0?=
 =?utf-8?B?TFB0UTVWOVNObkxNZHpPTTBMNHJ3eGwxRHpsOUkyNDZrTlMxaDFpKzJ1OGl6?=
 =?utf-8?B?TXJSNGpsU2ppR3YzSWhKR2RxbWhXcWkrUkxPSE5UcExEZEJGY0FnOURXRndF?=
 =?utf-8?Q?EMX4W8eRhDOfGG3zKssAcIgI4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 04:04:06.1942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9069c01-77f2-4382-2c9f-08de17695ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789

Hello Hao,

On 10/29/2025 3:06 PM, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> Since commit d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage"),
> update_rq_clock() is called in do_set_cpus_allowed() -> sched_change_begin()
> to update the rq clock. This results in a duplicate call update_rq_clock()
> in __set_cpus_allowed_ptr_locked().
> 
> While holding the rq lock and before calling do_set_cpus_allowed(),
> there is nothing that depends on an updated rq_clock.

I couldn't spot any dependency on rq_clock() until do_set_cpus_allowed()
either so please feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> 
> Therefore, remove the redundant update_rq_clock() in
> __set_cpus_allowed_ptr_locked() to avoid the warning about double
> rq clock updates.
> 
> Fixes: d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage")
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
> ---
>  kernel/sched/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1842285eac1e..1123cd0ddffb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2999,8 +2999,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
>  	unsigned int dest_cpu;
>  	int ret = 0;
>  
> -	update_rq_clock(rq);
> -
>  	if (kthread || is_migration_disabled(p)) {
>  		/*
>  		 * Kernel threads are allowed on online && !active CPUs,


