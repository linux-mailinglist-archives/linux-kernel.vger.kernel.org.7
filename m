Return-Path: <linux-kernel+bounces-741835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0FB0E983
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 06:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA50C542A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C7F20DD52;
	Wed, 23 Jul 2025 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nxw0Zqml"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F72594
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753244196; cv=fail; b=Ss1Dn+6Q6k7B22x8u4uGk2KJzOgJUy8T/U2ViXwhu+kjjqYmA02VfN/iXa39/Q4fsf/0qXxKJrFxuRV4A7kaADcDhdJPf3ZyOGL9Fj8VBNphlUM0DEo9czHXlBb9KVSh+MY1jM/WXQq2KD3OYG6dcEQnGRi4N1NkB0+QNsnKK7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753244196; c=relaxed/simple;
	bh=HuF4TTPephnVwYg8fHOOA8geZknBYZxWJV3cnKxUl4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QUCf46oFcx0JdBNZEZWEPBNON54NPkDyeI1R1AhcKLxACc5FJvV2fa6S4KMJGDwaOpdnbSxrYt/GO0T37jSjolMDqsiRgyqV4RuYocPJJcGstPC4eNj3sOVsp5eMHnqrTSv+Ni106pHi+kGV4NaZ0NmiTTFHErJZChCjB/Rlj7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nxw0Zqml; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaP+tN2U2dU2+L7dR4IH904kWqs6jw/88uky/zWm8aXEbksb73u7ILCP2h+Qr7DB5txGVbnO1PCR/9Ua4iyqlNMt/UKs2X/ydJby6xYW5f9EPtLgDE0tagD4CchIlpWOsIb2lmssFGyyDE1LvCcX0KUmnUGuOjImWvJb/mUECVPP1WVkfjoPYNvsryAajZ09E0SKZDNaQc7yhSwnUUFM55+doQSH4x8PBOpZj5Y6tYDJ6W3q7O1ZgHNpoeJhJaKMSE1Nav4eyaxE9HIqNOZ7B0TNHlYBCcWmSFGk28FycD9mY3bVIevDuD8rKvSqb+253qp3sRVmRcFxMPNjXTdUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLFzDMgUCxGrGNR7xTc1o6NJbL4TIV/hACJWZ6OCd1U=;
 b=kRDb1zXWcrdsTU7Iz+QdeIPJAE+GWTFtu0yOSeZMM1hS/n6eM9PK0a1XZNVfnIHhOyP2X3aa+QZ9eB5EE5UDtXvLDBab6mIsJ1t29XB8WOJcEFrSfGDHWCHvpPAs2nu4xHuLb3N3twAGgzkF+JJLqdABpoqWflD7dmSZTGKNczc3+uHofL+sirimgmcYlPbbt35yihQJfQFCnwoZ1n94RVYotyOSbOzumm2M1B3hWA+ehxHqyN5qklRUBYr0NUIJ9UyyK/rGq2C9ebNG01MK0Wd7cXVVAEfa8ugzJaKefw8DmrjDdfcHTAM0Fa+Z8C8c3jYC14pvIHDeLM24RmLwMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLFzDMgUCxGrGNR7xTc1o6NJbL4TIV/hACJWZ6OCd1U=;
 b=Nxw0ZqmlHfE0S1RjbeCL1Iw5agL3fgdTo5gDhRtgL9aEBXzdVxZfux8xyMH56OHXlVka9f2GRi7iDC7om2au6v6s6oJQVcqF1CG0Rdwx6oSE2dng+vFFW628rvZmkrtRIwWP+sdrVz7e8MkOzGGV7sA1rKM3tahbbrg0z1rXSGA=
Received: from DS7P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::6) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.30; Wed, 23 Jul 2025 04:16:29 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::4b) by DS7P220CA0014.outlook.office365.com
 (2603:10b6:8:223::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 04:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 04:16:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 23:16:28 -0500
Received: from [172.31.185.117] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Jul 2025 23:16:25 -0500
Message-ID: <8a500367-2547-47b7-b210-4ea3b22faca2@amd.com>
Date: Wed, 23 Jul 2025 09:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/psi: Optimize psi_group_change()
 cpu_clock() usage
To: Peter Zijlstra <peterz@infradead.org>, Beata Michalska
	<beata.michalska@arm.com>
CC: Chris Mason <clm@meta.com>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>
References: <20250702114924.091581796@infradead.org>
 <20250702121158.350561696@infradead.org>
 <0d86c527-27a7-44d5-9ddc-f9a153f67b4d@meta.com> <aHdMTdPeQ1F6f-x9@arm.com>
 <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250716104050.GR1613200@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sraithal@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: f60e0819-9385-4ed5-da76-08ddc99fb2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2ZnWDloeHdNK0NLbHdWU2dNT3doWmpGZFdDZUZXVHJCaDhPb2Jmb3JOMVJ6?=
 =?utf-8?B?QmFDRjhOYjJPNGZjUVl4V3Jsc3VKM0c4Qyt3ZFhGaUVQa0tTeUtiRUVPcTB5?=
 =?utf-8?B?QWRxNld4dytWOGRNVmJXR2pzNEZNc2hZZVZVRVZhbDlpWFp0eFJWbjl1TDlq?=
 =?utf-8?B?Y0FxS0kvaWVrM3NOSysyWmdVS1lXc1lpRHBNdWZnaEloM0VhYXNPbWpwYTFq?=
 =?utf-8?B?Yys4bGloREs0bHdIN3h0ZXRBNExuRlcydVYwcnFDTEpWY1cvWlIvM3JXMElW?=
 =?utf-8?B?VnJRdDVQdGF2UzFzcGJWSXNkZ3pNNFRraU9Nc2Ezd1MwOVNsTlkxVm1KTkQ3?=
 =?utf-8?B?YTJwZS8wNXJSQzVnY2pzUE81eEc5OEczc2VFdGUrNkY2dkJNdThtdHpOaEx5?=
 =?utf-8?B?M2tFUjhJTld5VmlscCtpTi9CdzU2UzR3ZlNaSTc3RFN2QVJwWGpOSmZ1MUx3?=
 =?utf-8?B?aXlCTVB6MkoySXNZdHZ2c0RoMVVSZkNlNnBiZVNINFNXN3c1OWxFNUVUWnBH?=
 =?utf-8?B?WU9DRSt3cVc1UXpWR0JWL3BQSWRWQWlkdUVzQVZvOXVQbzNyeEdBQ2JlTmhs?=
 =?utf-8?B?R0cwT1lGUDU2dUZ5VHltemlHNXR5dnV6MDdWby9hVmpHZFp0TlhHQVJoM1FD?=
 =?utf-8?B?bWZuTUpVM3ZJOUUyUVArWitvdWgxZGRBYkQ5WU1uUCtiVk9iWGx0Z0RGMXZj?=
 =?utf-8?B?S1d4dm1vUWNEU3pIS0s3RWlLVUtjN0V2cWhWOXVLRXdqNms2dENwY1Z5cG5m?=
 =?utf-8?B?YlpucEZmM2U5ZSthL3JMWnhnb0V6OUYwQ1Y1Qk5POTBESkcvS1ZKcjlINjhi?=
 =?utf-8?B?SkR4bUIzTWs4Y0FpaktjbUtlRVNRNnhPd0pVaCtvemVidm41bGEzN2pob2g2?=
 =?utf-8?B?am9KeGI4RFlNNHJRa2NTbU1heUc2N3NVZlIrQytBaVRBN29HMDBmSnBjcGJw?=
 =?utf-8?B?UFFqYmFDTkxveGIwN3RjYlo3NE9uaGdjWHhKQUVONGthUzVzdnlxZHZnK0ht?=
 =?utf-8?B?aVB6c25yZnRKdHlWZ2dnVE9JNnRxL1pobEN1M0dlYW8ySGZWV29rcytJWVlK?=
 =?utf-8?B?Zy9aZUZaWDJDTnpDWEtyUHc2QW1PcThKVDN5czNkbS95ZENpRnBaVnQ5cytT?=
 =?utf-8?B?OStoVXZvZGlRY2drV2JPRGthQis2enlRVzlFeVY1c3VjWnBURFo3MDdHY1FO?=
 =?utf-8?B?dFFaWTdpVWpjazBqTGp1NE0xRjVwOGxrekJnaFBkOFFVdDBUcG9LRVVBWnNF?=
 =?utf-8?B?ZEk3QjZjajBTY1k5bU9RY2tPMmVFRnlmblNKTDdxMVRjSU5JS0hZRGxmSjM4?=
 =?utf-8?B?d0YrTW5INi9mTWhsOXdGTzFDNWJiNkdJVE9ydnU0NFFzdHMxYVQrVVJZekNh?=
 =?utf-8?B?UGtSVzYxbDhQSGFTQ0VXUnZodDI2Yko1NXV2T3hqVzJUaHF5QXVJY0NLcGVi?=
 =?utf-8?B?OXFiamlBWldWMURnUjF6azdpd1duQVZYaVR4YUFzYnZYSnVUK1dEQVRjMXdT?=
 =?utf-8?B?Wk5QUlYrbm5wQ2JGa2x5SDhWSzUyeXhxRE5iTlE1eVY5aEdRcGF3QlNpR0VT?=
 =?utf-8?B?MW1rS1RVSlF3V1Y0UjhOcXdKd0JET3JWQkd2aWt0R0luZ2s5UlJnTjc3U04w?=
 =?utf-8?B?bkhacnZUQno5WkZzLzJHR2tUcUExdEdLcXRBOUZBWGlrcktrcDE2NEdFTFM1?=
 =?utf-8?B?NDF6a2lkcm45Z3lmL0RPSHN6eFhMNFoyVWNOck9SeE1haHgwTmZyNkpwSEwz?=
 =?utf-8?B?TXM4T2NVZ2FaeUVCY0hQSlVjRzVmNG8zNjVEQTVCWWJyN1pXZitaVWlkSEtI?=
 =?utf-8?B?ZXMxMHdadmRIcUZIUXgxMU5TeTk3cURTRFlUc2daVktaaTNVakdTWEwwdC9i?=
 =?utf-8?B?c1RXbFVGNlBvSFJYRDRWSzdNTFArZDVyZWp3QUJZY1pOd2d3YmNMQjZGZmdq?=
 =?utf-8?B?cjcxTmxSejViOXBISUtaQnZpZFRNUmYrY2lCajEyUndBQlpINC9hNTNXYVd4?=
 =?utf-8?B?Y1J1TmQ4SG5PcTVyN2VWVnJqNjd6cmQvaXhiSnpNd0FYemdwRWxMZVc1VVN0?=
 =?utf-8?Q?NOTMuD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 04:16:29.0405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f60e0819-9385-4ed5-da76-08ddc99fb2ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

On 7/16/2025 4:10 PM, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 08:53:01AM +0200, Beata Michalska wrote:
>> Wouldn't it be enough to use SEQCNT_ZERO? Those are static per-cpu ones.
> 
> Yeah, I suppose that should work. The below builds, but I've not yet
> observed the issue myself.
> 
> ---
> Subject: sched/psi: Fix psi_seq initialization
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 15 Jul 2025 15:11:14 -0400
> 
> With the seqcount moved out of the group into a global psi_seq,
> re-initializing the seqcount on group creation is causing seqcount
> corruption.
> 
> Fixes: 570c8efd5eb7 ("sched/psi: Optimize psi_group_change() cpu_clock() usage")
> Reported-by: Chris Mason <clm@meta.com>
> Suggested-by: Beata Michalska <beata.michalska@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/psi.c |    6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -176,7 +176,7 @@ struct psi_group psi_system = {
>   	.pcpu = &system_group_pcpu,
>   };
>   
> -static DEFINE_PER_CPU(seqcount_t, psi_seq);
> +static DEFINE_PER_CPU(seqcount_t, psi_seq) = SEQCNT_ZERO(psi_seq);
>   
>   static inline void psi_write_begin(int cpu)
>   {
> @@ -204,11 +204,7 @@ static void poll_timer_fn(struct timer_l
>   
>   static void group_init(struct psi_group *group)
>   {
> -	int cpu;
> -
>   	group->enabled = true;
> -	for_each_possible_cpu(cpu)
> -		seqcount_init(per_cpu_ptr(&psi_seq, cpu));
>   	group->avg_last_update = sched_clock();
>   	group->avg_next_update = group->avg_last_update + psi_period;
>   	mutex_init(&group->avgs_lock);

I've tested the above patch, and it resolves the issue. Could we include 
this patch in the linux-next builds? We have been encountering the 
reported issue regularly in our daily CI.


Tested-by: Srikanth Aithal <sraithal@amd.com>


