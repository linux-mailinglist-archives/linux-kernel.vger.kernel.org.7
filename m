Return-Path: <linux-kernel+bounces-784538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60222B33D20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B49B189DEFE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38D2D97B0;
	Mon, 25 Aug 2025 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qnqBNtGi"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADD33D984
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118886; cv=fail; b=VlNeajrnFeAoOSRyyVcIx0Ga8oqrS57vuxLTGjXX4xUMD7eNGA4Jl8egkscfxYjAqQS/hkfNhTOqpJLEM3JXe4kWUpJ56gydQQlTwqkMooEwqph66dzvRmwK2YwYOJ/JYmUP+nyWX+V4VEMmSqzEVcgSz8ie9hB8LA7EasPP6gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118886; c=relaxed/simple;
	bh=8ZlEvEqrpuOD0jqQjev68/wPIKevJKMUxRlJTZ0bWIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XSVZdz1z5Zx9jrE+mApNaVoD1pq1GK5str/judIO2uIhlmdW/OfQrFFFtOX8xwLjepteIRvAOeDQ4EXWj50WP7aSczQZMW9QPFDS++8+/5fb1OfWiBxXjo4HnGN9JTu3i4e/rKRDdGDIoP92LIY2Xu83nqn1klUaqvG0lbNxO+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qnqBNtGi; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkEUBci32L6G4GNTHU694/bd5hcaEDs9VR2WWz5w1cC/w5F/jVDfdc4JiBjgEDlmpJJxNd6dPzzJBNCK7cAk9LAmH362TDcRQ7evx582fBNsyYSHQVyuT1bYQcvs7AuWvgoStV6UVomtZhN34QaAS6GwCGn7D+OynZ58w/gSdLEqxbBXk9PQjkJrSH4Ga5akw/uXWj/q82U2urDRX6Tp7OqNfQzTYUOFeIGXYD5HSyEQBW/2TY9lH9a/iEbRbmPc69kZJfvM8rJUQgFVzQYg3vOZi7rMLQ8QvHYM64s5QE4WniVeCSXWZ3AWrxxHjOt3ST4uDftLrTKz56KmY9NKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4pmnyTR7KRvi5Fj9GSDfCb7oTJS5pwQHZggNsRLXUQ=;
 b=A6cQ5EZS07aGKo2sk7edUdfLikWQNf0AoaFtl48TARfHkBBe5SWbjzUaEck7a/JK0DKk2zvn0o4N6g4gZQsCFxSYEV19p30q9fewPJs9o/eMsiTgmglHe4FyMGrBuPICYl2qGxbsgQ5KjP4LHTzZMQSOzb97+8smcEOqg74Cl5PFeCT+3MP+FKI2snhYK/2Mo4iEB47IGU0eMU7HvfsTdwAC+xEkZcMcmS0kF2q24CPNE2x2acLXwnFZ8+6tuAPGmWWRK1UzT/t81CAKVSzfkJ4bFCLzXG/qsw7YHWZ38UAq2VPnfgwM/B4GaI+uCCkixDEwDjBQ9sOGC+/uOXA5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4pmnyTR7KRvi5Fj9GSDfCb7oTJS5pwQHZggNsRLXUQ=;
 b=qnqBNtGiHGahXNe2mxaQUB0a/7nw+ECnblcdwM5vAqguyWH3Bb2sdmutwiXkiytUa8/T7/yPiih5HHdHPICqCEu+DuSSFiusKpU5JPgZlAJIbt6d/v3b6kSGjJq/n4Q6xp0Fw/ao1md5P4wHl57o11XV0m29piR9mAKNaT+gtL8=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 10:48:00 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::d1) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 10:48:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 10:47:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 05:47:58 -0500
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 25 Aug 2025 05:47:53 -0500
Message-ID: <5940cd15-b207-416a-b4e4-b5953f4cbf47@amd.com>
Date: Mon, 25 Aug 2025 16:17:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Valentin Schneider
	<vschneid@redhat.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, Steve Wahl <steve.wahl@hpe.com>, Borislav
 Petkov <bp@alien8.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, <srikar@linux.vnet.ibm.com>, <hca@linux.ibm.com>
References: <20250715040824.893-1-kprateek.nayak@amd.com>
 <20250825091910.GT3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250825091910.GT3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a892a3e-36f3-4b0d-7051-08dde3c4dbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHcxUUtqemxybVY4Qm92QjNhcENaSERxdXhqeEZIclhMTlcyc2JmUkxhRnlY?=
 =?utf-8?B?V0hIUTNUR204WWRZcHU5dmo3Nm9xS0RqZmk2ZVR1cm80M1kyc1Y0Z1pEZkli?=
 =?utf-8?B?a3BkM2FEYUV5ZjFVVmFaZ3VCQlFNelZGcklIbVNUT3BxYjVKSVM2YUVMT2dH?=
 =?utf-8?B?aE41MkJSai94Zlh4YldqTkM2WmJ3Rm0yVU5VRFBwcmFxS1JGNUFrNnU4bjI5?=
 =?utf-8?B?NXNSVGVzQVdWcHV2Rk5XZk9IWHBvbFk0SWV2Q20xWU15VDJMRWNNVUk3SldB?=
 =?utf-8?B?VGNEdDFsNHhDQ0VqQUdGaGlEdFVrUGxNVnUrRndaRUdwcm9TRU85TG8zdEVJ?=
 =?utf-8?B?ZXNWZXBURVhDL1pPZVh1UEZqSXhMMzlWdHhtQUtUWlVOenpHRDZ0TTNuMDBC?=
 =?utf-8?B?V1ppeEdLZllwblBjWEE0UUlJQ1ZubmxySWRFQmY4N0F5bEg4MUR0WlAwQmFz?=
 =?utf-8?B?bHlidnBBNzMxR2VHNHpEMDdyWHFkOGtaYTJzR0VsYWZuSjA2UGdMcWl0WGtT?=
 =?utf-8?B?VTRCR3dYeGpwN0FUZGs0VDhYb2JDeC9vV1BCa0JjMjBsK0tvY2ltUmR1TGV4?=
 =?utf-8?B?U013ZjhtSzE0M0V0TVI0VlJ0TlRrQTRyZEtYWURLeXJMaHlHWnZwTjhwb1Iz?=
 =?utf-8?B?bytRSk8xVzhyeHp2LzdzeUp6ZFFqdUV0RUlXR3ppYkFPdjU2dmIwbm05bzUv?=
 =?utf-8?B?WlRJQjl5NUJOTkhXejUreEVwb3RxQ2s1dE9BeHdUKzIzU3FQd05zUlJRZk9C?=
 =?utf-8?B?VkRvMm1QWFExc2JRWHVpQWJ2eUorVnpkTUF2TlBKRjhBMnpGSlhITUllYnhD?=
 =?utf-8?B?aTNOYVl4WEtickg5aGdCQXVwRDZJd0dlVjEvL2RJeWNoVEJnRTh0bjdkUWJ2?=
 =?utf-8?B?OEw4WnJsalhpUFJxN3hGWk9YLzNzQXBzTTZWZlh3QWNpS0o4cjlDSXdLZExZ?=
 =?utf-8?B?WWdRYk1NYUJWZVRTZ3RPbFhEL1FXYW1rK25qRG94ckNuUnh2S3pRVVRLYUI3?=
 =?utf-8?B?NkR2WmJNRzZkNUVFQ3p0MktVT2ZpKzBRN2RjS3M2WXJwWk5iOEVMZmEwV3dz?=
 =?utf-8?B?SzhKdHFZM0tzVndKb3FPVVp5a1AveERZVUtSeCtDQ1FmRXRGSjFQT01RU1dY?=
 =?utf-8?B?bk4va0hqWFErSFRLRmlNd0swV3RyRGp1TDdnUzZyUjY1ZlFXMTE2b1BoYVI5?=
 =?utf-8?B?S1JnN2VVT2htR1V2OFl3SEVmbU9kTHo5bmNCNEl5NWRYdHRwQ0dxMUNQWlpz?=
 =?utf-8?B?SldlVW5DSHo2RHNQZ3VyL3VONjB1ZGJYS2lqT2VxcVhPM2Q3aURkRFhnOGxG?=
 =?utf-8?B?aHlSNWVvTGozbkpLYmluNnRFQUJMT2t4RkFSZjZHcU1WcGw3UlBXQ0k3OEhn?=
 =?utf-8?B?YVEzNlFsaDVHcks0Vmg4MWUyTTlCV3pKdkFlUWNqNXluempzYXowR2JrTGhi?=
 =?utf-8?B?L24xS0l4T0RtanlOQko1K0NOcVk2SGpZUkVrRW5TcGNhQUV4QU5GOFkxV0hT?=
 =?utf-8?B?M2E2bmhlR1NHVmx1Uy9DcStCL2cwTGFYbFZISkxSc2tZMHJaakpJUzB1aSta?=
 =?utf-8?B?dGJTcjgrSUtzUC9Cb0tFTExJRVFpOHNxSlpQVW1Dai9nUW4yQ0VSMjM4REhL?=
 =?utf-8?B?Znk5VGJjYlZVVGlKWE1pOU9vazBpYkt0emZneDZyc1h4TmJTd1FEMDZTNlBG?=
 =?utf-8?B?Wlk1TEtrc2J1Y2RQeEFHb1JVZGNiWVRtbFQ0emJwYWVJWnA3TmdjZVR6aHVs?=
 =?utf-8?B?Y2NLclkwTG5zM0x2dGQzbG10d1J4cmNuNGI0bFdZOWdJMnFLNTdORGlRdFZl?=
 =?utf-8?B?SWNtVVdkaDVNckNwZnhQaFlvUXRtNENFaHR3UUF3RDdXRXdVcVRyYUtTWTF0?=
 =?utf-8?B?TklvOE5EUEsrTDU1R256SHJRMDFncFN1aWN6VnBack0xNGJWOVdaY3IrMDQr?=
 =?utf-8?B?WjdVQ2xRKzIyRjBSY3BjeWV1d1VELzhsVHIrTmVuaEhkTEhEVUF1REhONjdX?=
 =?utf-8?B?NGpjTmtDVE5veXJkQ0VDcUxnK3hLM0hxUjZMT3lpMWlIdzlGeDNIQmpONnd3?=
 =?utf-8?Q?P3CCKL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 10:47:59.6838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a892a3e-36f3-4b0d-7051-08dde3c4dbcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

Hello Peter,

On 8/25/2025 2:49 PM, Peter Zijlstra wrote:
> We should either set ->mask to NULL for NUMA thingies to make sure we
> don't end up using it again, or bite the bullet and fix up the mask
> function declaration.
> 
> Something a little like so?

Both the QEMU VM from the above commit message and my 3rd Generation
EPYC are happy with the changes. One concern:

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 977e133bb8a4..8164ffabcd31 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1732,22 +1724,42 @@ sd_init(struct sched_domain_topology_level *tl,
>  	return sd;
>  }
>  
> +static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_smt_mask(cpu);
> +}
> +
> +static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return q(cpu);
> +}
> +
> +static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
> +{
> +	return cpu_coregroup_mask(cpu);
> +}
> +

The above helpers may need guarding behind CONFIG_SCHED_{SMT,CLUSTER,MC}
if I'm not mistaken. Possibility for some unification and cleanup with:

(Only build and boot tested on x86 on top of tip/master + your diff)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 0b5897fff687..a0eeb6e39304 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1054,16 +1054,6 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
 
-static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
-
-static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_node_mask(cpu);
-}
-
 static int __init init_big_cores(void)
 {
 	int cpu;
@@ -1718,10 +1708,10 @@ static void __init build_sched_topology(void)
 
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =
-			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
+			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
 	}
 
-	powerpc_topology[i++] = SDTL_INIT(cpu_pkg_mask, powerpc_shared_proc_flags, PKG);
+	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index df036ab83920..68d22cf3c604 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -530,17 +530,12 @@ static const struct cpumask *cpu_drawer_mask(struct sched_domain_topology_level
 	return &cpu_topology[cpu].drawer_mask;
 }
 
-static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_node_mask(cpu);
-}
-
 static struct sched_domain_topology_level s390_topology[] = {
 	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
 	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
 	SDTL_INIT(cpu_book_mask, NULL, BOOK),
 	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
-	SDTL_INIT(cpu_pkg_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 31a3b57314ef..eb289abece23 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -471,26 +471,6 @@ static int x86_cluster_flags(void)
 }
 #endif
 
-static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_smt_mask(cpu);
-}
-
-static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_clustergroup_mask(cpu);
-}
-
-static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
-
-static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_node_mask(cpu);
-}
-
 /*
  * Set if a package/die has multiple NUMA nodes inside.
  * AMD Magny-Cours, Intel Cluster-on-Die, and Intel
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index f0a53b0e67f5..c7457ccf05c4 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -30,11 +30,19 @@ struct sd_flag_debug {
 };
 extern const struct sd_flag_debug sd_flag_debug[];
 
+struct sched_domain_topology_level;
+
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
 	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_smt_mask(cpu);
+}
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
@@ -42,6 +50,12 @@ static inline int cpu_cluster_flags(void)
 {
 	return SD_CLUSTER | SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
 #endif
 
 #ifdef CONFIG_SCHED_MC
@@ -49,8 +63,20 @@ static inline int cpu_core_flags(void)
 {
 	return SD_SHARE_LLC;
 }
+
+static const __maybe_unused
+struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
 #endif
 
+static const __maybe_unused
+struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 #ifdef CONFIG_NUMA
 static inline int cpu_numa_flags(void)
 {
@@ -172,8 +198,6 @@ bool cpus_equal_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
 
-struct sched_domain_topology_level;
-
 typedef const struct cpumask *(*sched_domain_mask_f)(struct sched_domain_topology_level *tl, int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8164ffabcd31..18889bd97e22 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1724,26 +1724,6 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
-static const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_smt_mask(cpu);
-}
-
-static const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_clustergroup_mask(cpu);
-}
-
-static const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
-
-static const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_node_mask(cpu);
-}
-
 /*
  * Topology list, bottom-up.
  */
--

Thoughts?

-- 
Thanks and Regards,
Prateek


