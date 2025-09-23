Return-Path: <linux-kernel+bounces-828648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E03BB95176
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EC13B3748
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6831DDBB;
	Tue, 23 Sep 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JmZTBQHk"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0231812F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617736; cv=fail; b=UeGsY9WB+tfHiutPqCKwsttOWgU5G2cgpy7gEcUuqybKyUV9CDF8ZtIsCkxE+OK/nlU88rAdmpNKLpr6W6J0e4qyxt5x4vK1GRU+cdTOgwYAFzY3yLQWT5hqknZ80p8nXpOLxIwN4BrNetK6HAmkfaWYke0bi7ed0I0hZk9/BG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617736; c=relaxed/simple;
	bh=GYyjXhm0fKzmhvLcxX88tAaKaHttSPocMDOsV3rs7Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s67GAMU1ijgbUfMauwpptZmRy/rC0ppUGYLYka8zePWZUSGFAFOMwlVHf0z3vQ0NP8zbWiBdjPpa0bkQWC6at53j8uzHniyiKeNKraJHMy4tjDGMH7Tg6S5QEcZnJEIjbUb5ue+Dz5BJxZNKsnzf3ITzXTEfUm5CSYOp7ndireE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JmZTBQHk; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVpSqr5ODNz4QN7MlJftTO0esNGjcDH//kdk7sMfMY42QyNuHZotNWiPJAMR/NrS6hNuY1zJlT4jPnJzM0SoaYDv3SnYfunIDqprPn+5vrmdZ2yBGDdXUXQgAGmou+Cbd6Thyo497Pw9pSG5pMa0ok+PO+lrORPafqsybqHljd1IIxKVt2uh07CU5PXaqIQ2w5LgRPFq4BT9dDAjjqdrj1Vxz32Q6G4QXMZpU8W6mS1Q5yDjyF6CmMQLWJ0SPYDMalAlqHPR8fQsSnZvbAGjzL2xJ22J0rJjoLoY4Modu+/TRY1tuyfJQGbnmby8irPs4SKzWF20AyXfJfTxzY4sXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWGSG+UEufXkHIitUtulNj1m1fXCQie9PqSCHiLa4Ns=;
 b=hH61YAs659fA6ZkhPdcgbXA6NdyOvSTJGoH+2NSG2zhVyuEJbbFJfYoX43MJBzAvfyHuZKZ1EDTalfX2Ol/A53Mp97mvkpXqM5uWl4xTU5mUo40E0r+3tVRimxtUFgaq1NxoEYCMUqaNXy12EqOZ/AxkDsrXuksZqyolq+le4iMet+vFUCDnqMvDGt1XH1+561DZJeaMJcmn8k60aK/5xFIok1EEnYMlNco4WDgxOadASyUTUpwpez5QpPsK0M5jI/FL/TT81pkao2ZI6HSkHKpzRiUHwvv/fAGKXvvpIGxavwF/cN2jtA+aSFybwHtkqTx2ckNMNPkEHXUP+eFS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWGSG+UEufXkHIitUtulNj1m1fXCQie9PqSCHiLa4Ns=;
 b=JmZTBQHklEfBBASzLbSFEkuD8xRM2S7hFWhp3pLjBXjOcAlOhR84DgFhBZPlJZPwkYxZtNNpHYXaG6yO8vA86y/HdjDKaSm0huqRoWC8krHZvO+r8YD8I/lQnreEYP6un7V6BdfGxQF7+XH1prE8430ietM9sK2yRgjBGaOpGIQ=
Received: from MN2PR14CA0003.namprd14.prod.outlook.com (2603:10b6:208:23e::8)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 08:55:30 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::80) by MN2PR14CA0003.outlook.office365.com
 (2603:10b6:208:23e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Tue,
 23 Sep 2025 08:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 08:55:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 23 Sep
 2025 01:55:29 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 23 Sep
 2025 03:55:29 -0500
Received: from [10.136.47.65] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 01:55:25 -0700
Message-ID: <a1ff6b87-48a9-436a-9b62-8664d5207884@amd.com>
Date: Tue, 23 Sep 2025 14:25:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Add more core cookie check in wake up
 fast path
To: Fernand Sieber <sieberf@amazon.com>, <mingo@redhat.com>,
	<peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
 <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: f66447a9-6f42-434d-0652-08ddfa7ef2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yys0QW5NZFdKaVcvSGZWZDgxckNQZjBhNEFKSDhVZllxUG4xNkt1amlZSjVC?=
 =?utf-8?B?VFhsaFY2ZVhubHZTR0NXVlpILzlIQmI5L0ZCNXlCdjVtZ0ZHSXF4c0lnZ1Ra?=
 =?utf-8?B?b2FnODhDSk0yd2lPeU9Ca2c4WWRrc3Bwa0RmNXgwR0RHeWZvTkQ4YUlNMXky?=
 =?utf-8?B?VG1Od1VEMFNHd2tRbnF5bG1XbGRsdmloOFpzMFRrRjVjYk9yVGw0cnBVUTlD?=
 =?utf-8?B?TjlXbWxoZUJVUW9jaWZPQW5FUlhXMDAydEFIUHVIeDU1VTd0UDZMR0NwcVhs?=
 =?utf-8?B?UVN4RHdzWWhCdzk5anJ2eUk0by9aSWd6bmwreDJsdWFQWS9YWVR0ZVpueXlZ?=
 =?utf-8?B?U0x1VGVVZGlLM0VMbUpaU1RlMEVSRWl3OERFUkNhYnI4NlQyZWdzdnhLM2xr?=
 =?utf-8?B?VlFUcEpHTGltMlo3V09BK0V0cWk3SlhNV0t3dnplNllMVG9qSklOUDRvVTF0?=
 =?utf-8?B?WDlEOW03RSttN0syLzRaMTQ0RkhKcktXZlJOQ0kvZFhtSEZUYkljZjdMRjhG?=
 =?utf-8?B?aUxKaWFjbG4zcStEZFpLYm9iU3JiNGZlQ2tIS09mRll5dFA3N1N2TC9aZjJ3?=
 =?utf-8?B?cGRpV1UvNXY1VXl4cnJqaDhoSDdUVmU0elBtREc2aHJOMVd1S3kvQmtUanNT?=
 =?utf-8?B?S1pLSE1XVHJWY2hseHQ2eFhLWlN3Skg2aElPTzN0VEk5b0RnWmxaeVJGTVVP?=
 =?utf-8?B?WG1VTkpKZ0lvYXp5ZnV6VXkwMW9yekhSUmphc2hzSHdKSWd3dE5jN3dicDNu?=
 =?utf-8?B?UnUveXR3d21EcTRWWUExQTBUQWI3dzFVZFNNb250RkFnQkI4ditwS2x5ZlNZ?=
 =?utf-8?B?cUk4c1hKbXhEY2RMSUFkTThZVWZQZ1lpY1FJZG9DZUJndVR6c0wxYjEzRUlJ?=
 =?utf-8?B?WXc1NEUxbmFBU1lNVTBLcURJRjN0Y3Fld0lQK255NUV2Wm9LbGZLUUxKcS8x?=
 =?utf-8?B?ZWZsZitOSllXck5pUk1obStqV1hjTmFBbi9YZXg5S0VKaFR4WklLSVoxUWoy?=
 =?utf-8?B?bXpldG9OYzUxRFZQVXdoeENBeTM0dTlHcnd3Z3UrdzlIQXFHZFVKMEFvZWQr?=
 =?utf-8?B?d3cxRXRETmxIbFB2cWwvMGdtZk1EaTljZ0g0RmlnemVwM0FDUnFWTGN2MHFw?=
 =?utf-8?B?d1VwenVuNTlzdHdkc015bmpzOGFLRXpQekpFeWxrV3NMdlRuVFcra01KdXEv?=
 =?utf-8?B?Z2VCOW03OUhQT3FEWFdTN0lyYlhYcHhYVDFiQWx6UWxjTStoczEwUVo1UnMx?=
 =?utf-8?B?KzdXNVIyT0lQakY3bGRyR2NqUkJWRXdmcnROWUdYYkdlOWsxeS92aEdjZ2dP?=
 =?utf-8?B?a1NKTHJuOGY1UGpTRWZkWERJZUlvVmJyQkFySCtDM1FWSUd3NWJtam9RRytC?=
 =?utf-8?B?VkUzRUV2RUU1a1ByNHRaam55dUhiNHNvQnNTVnJxa3Q3cmxGUnA1VGNTSHcv?=
 =?utf-8?B?SUh3ZXRhMW9MYWJsRDdQS0RKNUJsUjRlYm9xRVZwZjJUa2pOVG9QVkZ2a2pQ?=
 =?utf-8?B?L1NlS0lwNlhLYTFCSEpXT0cySnZCNUltalZkTDRwbVYvNDV3bUFuSHhpRW0z?=
 =?utf-8?B?R1o3RVRsUm9EaktGazRIeW5GM2xkNThNQ0hqZjB3NE5xVWZXOVU4Qm44OWph?=
 =?utf-8?B?clgrcXFNRlVnUmdZTEJodEVRSHdMSmkrNDdwdDVDcGdUOFFZODRKU3krOW9G?=
 =?utf-8?B?VkFuUDFVdm9haENlMWgyMk5XeU9DQWU0RHg0NXZaZ3dxalJ3SEhidkduVkJX?=
 =?utf-8?B?T01kbFRQS3JoNzYzMDQ2a1M3VjdLYjFUMlhReGMwNkdxMzBkNy9TV1dmaFpn?=
 =?utf-8?B?bDFaU3FDVDBSRzdhYW52UWlFcGdTR2Ryd2JuM2h2UEpCVE5JNEN0YWJIemRR?=
 =?utf-8?B?aXN0UVdTQmduY3oxOEtKOEJVbk9BRG9VL21jZTNha2xMRUE4QndEVGxJQ2VW?=
 =?utf-8?B?Z3k4ZnlMekpTUG1HQkIxeDdWWDdHYnNRVjVLWm1BMG9zZGphbGVFNE1DQ2Fk?=
 =?utf-8?B?MTNwNDBYRXVlWmZaTUNvTUVjR25UOWZFLzZ1amd3UWZoWnBKWEFjRHA2cVUw?=
 =?utf-8?Q?1iKyIh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:55:30.1874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66447a9-6f42-434d-0652-08ddfa7ef2c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549

Hello Fernand,

On 9/22/2025 6:09 PM, Fernand Sieber wrote:
> The fast path in select_idle_sibling() can place tasks on CPUs without
> considering core scheduling constraints, potentially causing immediate
> force idle when the sibling runs an incompatible task.
> 
> Add cookie compatibility checks before selecting a CPU in the fast path.
> This prevents placing waking tasks on CPUs where the sibling is running
> an incompatible task, reducing force idle occurrences.
> 
> Signed-off-by: Fernand Sieber <sieberf@amazon.com>
> ---
>  kernel/sched/fair.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 78b36225a039..a9cbb0e9bb43 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7578,7 +7578,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
>  		 */
>  		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
>  			continue;
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> +		if (__select_idle_cpu(cpu, p) != -1)

So with Patch 1, you already check for cookie matching while entering
select_idle_smt() and now, each pass of the loop again does a
sched_core_cookie_match() which internally loops through the smt mask
again! Seems wasteful.

>  			return cpu;
>  	}
>  
> @@ -7771,7 +7771,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 */
>  	lockdep_assert_irqs_disabled();
>  
> -	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
> +	if ((__select_idle_cpu(target, p) != -1) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, target))
>  		return target;
>  
> @@ -7779,7 +7779,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	 * If the previous CPU is cache affine and idle, don't be stupid:
>  	 */
>  	if (prev != target && cpus_share_cache(prev, target) &&
> -	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
> +	    (__select_idle_cpu(prev, p) != -1) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
>  
>  		if (!static_branch_unlikely(&sched_cluster_active) ||
> @@ -7811,7 +7811,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>  	if (recent_used_cpu != prev &&
>  	    recent_used_cpu != target &&
>  	    cpus_share_cache(recent_used_cpu, target) &&
> -	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
> +	    (__select_idle_cpu(recent_used_cpu, p) != -1) &&

On an SMT-8 system, all the looping over smt mask per wakeup will add
up. Is that not a concern? A single task with core cookie enabled will
add massive overhead for all wakeup in the system.

>  	    cpumask_test_cpu(recent_used_cpu, p->cpus_ptr) &&
>  	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
>  

-- 
Thanks and Regards,
Prateek


