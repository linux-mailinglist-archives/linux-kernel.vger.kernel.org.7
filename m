Return-Path: <linux-kernel+bounces-818059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A2AB58C46
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9181BC235D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13AF246788;
	Tue, 16 Sep 2025 03:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XkGemdV6"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F1E571
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757992801; cv=fail; b=XmQtfh25yyiEeTvB95eSKczUXfKOl8+Kk/+xVl17cx2UkuU3uSu2edKOObV5vpYwc5LUf08pT6IQChTpcy02fszd2R/ZX2CITrAil2r8OLTEBmMtZCBpUYP9F6+9IEi05ASki3E9fag5g8cEyqnX3NfXzOKBg48aSMGctNiKkUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757992801; c=relaxed/simple;
	bh=ZiyD643Gb2skZDxulnm1qyI3rjen2rTYoCIiQ36kX70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PBHTDU/OhO7C55aqJu2H+pCODkWAez5B0UuNN3XIu4CbO9s9mGkSEYY1N6EIXGGdEsoTyImvN2em+KqiPUV6b1f4bo9qyR/9SJjf6ZryXwrB+ffimArQjS1pY/qXwKdLEXE4sRBGEUbyhy4N1Z3aDz9FBdZloGCLXZ7URfcolzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XkGemdV6; arc=fail smtp.client-ip=40.107.208.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZzaT9xLW1gkO0TSnoBWXdgctm5u7uW4o9Xh5FgisWXJD5qmx1gBBCr9E7ysOt9HHoFg9QUI9k9n0XBqi4hSNsfmf32dc3ZdhovEoy5eyfN5MzUHOf41JOrQzEfWipXmL+3kGd1ZjtBSOZBvyFDyp2r5Z8wt8JKBPUJ1Qzu0qNQG4F160b6Q5vrOt2lVh6ha9i914k+wLJY+FPvnEiQtcq3p/4qYPoNUxisFTpZiz5bZnJJGTFCjoXux7b2ttn1z2hNzzKViI5Gt7fHcAU9m7D+17dwQTcyOki/aAFzBWvtWszIHgTjLa3jest/uhEKuQLmaSekvlYhtEgUCXF7plQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3gjCtp/hCM9VdGoVExEIHaPCRM/JkotJ2yRrTV6eGM=;
 b=ThD42T0Ft0tfl3GhWhrKECTMnTuo9AB0wtktFmOG6GPaSvIw1KmUFTI6kCRJqZ0ezPu1eKXSak+4ybstxORHYy1r3F7xFWEPCF3dOOFKMMfDR26K4kB/CYK68WiedQ6vBkHLje66bBwO98DbzQoPJfBBPmAMaZOTuSCaiz95L5seD9fC8zltyaSM0yxCw6hwqV8lea3eRh7R8iuVlRmUZMGD6sDfn2QKiYRLp3Jzcx703W4GdabvU8JwwL+6HDqumtyVLfeQVchS8eJaxfhjtaBabbinmpZ+EOdGM+ru2PyCLP0kDcEaAkrE8fgnIkFBQ43GXLZyRHLEvus8pJNNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3gjCtp/hCM9VdGoVExEIHaPCRM/JkotJ2yRrTV6eGM=;
 b=XkGemdV65YHaSajpJ0O7kpjyAkSE22vqIjMhbX10D2V3V2b5KnlVGH9dZABcNiaG5ehxbUC1mpLizX4LwcskzsTM8PDFNq9lFQxbEi+SUQii1Yv5ZIjCCPH5hVOOsujERuMJnxSQ7S+CnT2RDKdABsZ6GiBUqNdKCj+p/pEsZCc=
Received: from SN7PR04CA0112.namprd04.prod.outlook.com (2603:10b6:806:122::27)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 03:19:54 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::f5) by SN7PR04CA0112.outlook.office365.com
 (2603:10b6:806:122::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 03:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 03:19:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 20:19:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 20:19:54 -0700
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Sep 2025 20:19:47 -0700
Message-ID: <02dcdbfe-605a-4acb-8f51-6ccae7fbee65@amd.com>
Date: Tue, 16 Sep 2025 08:49:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 0/6] Donor Migration for Proxy Execution (v21)
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
	<vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman
	<mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan
	<xuewen.yan94@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, "Daniel
 Lezcano" <daniel.lezcano@linaro.org>, Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	<kernel-team@android.com>
References: <20250904002201.971268-1-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-1-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b7d20d-18ca-4f5c-33fc-08ddf4cfe827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0MxNkUzUjNjVnJKNkwvcC95d0JOaGx6bEtyU1dEcVhwNU80K25nWVY2cWE4?=
 =?utf-8?B?SE5rMWNIbjR5NThhQUNQMWVGb2FkdlNqbk03UGtlM1pUTkl3RVRveGtuWm1J?=
 =?utf-8?B?ZkFWdmhiT0h0MTVOVzVaektSTjk2aE93VUdublZsQ3JxY21ma1Y0N3MwK1V2?=
 =?utf-8?B?ZE1zMGxVS1pSeUYyU05CaHdUQlpsaDZsaWhYTWF4Nkk1Z2docjJjNEpUeTBM?=
 =?utf-8?B?TUlGUmVPdm93VEpvU0c2WDl3b2Z1MTA2dU9ndDdINU5BV0lVdE5ZeTVtZ0Nn?=
 =?utf-8?B?a3o0dG4xVUo5TkExR1k3SVY2d0FPOXRRcUUydml1SThwYjU4bXk4R2tLcTE1?=
 =?utf-8?B?WXdvU0ExMGgxNHlaeFloUUZyZFo3Qm5TT2tNTXZRMmlySnB0eFF5OEorblFk?=
 =?utf-8?B?U291bnV0M2J3RW5weTdoK0lJZUZsSUZSQnJsTHpHV0drbW5CN3VLR08wa2d6?=
 =?utf-8?B?ekJ2MjFqelp3dU5tajNrQ1VBQkV3ZHBqUGZDVEdrYzUwdWJRck5LOG5ieENm?=
 =?utf-8?B?Y2NzNjdGN3BHanIwc0dvVFMyaFdoS25PT0dJT1hwSFIxY2doa3B0UDB1dUJp?=
 =?utf-8?B?eFRVa2hsd0dOQm9xWnExb0oyMXVnTEFMNEM1ZmR4blk3Q1RodDBES1MxSTlv?=
 =?utf-8?B?OXRVdTZCUHVqWVdReU50UG9PQlJRcUpFMXNtMExYbmJwQ3BML0ZVUmlFZU93?=
 =?utf-8?B?bXprWkQyZDBON1JjK1pLQlpCTmhManNjTTlLMzZ6VGNCNksrYnJtaHNScnRn?=
 =?utf-8?B?bTJIZHp1ZVRIQnU0VGVlRXAwb3BPd2lHc2trUmttL3JmdXpNVktnNjZaMDdD?=
 =?utf-8?B?Z00zZmJ3Qnk1Tlkvb3BSMFJXamd4TGNFWFRqYnFRZmg3cVpDVk83NWhrMUpw?=
 =?utf-8?B?ZkFBWEQyTHVvZ21MYmx1REJ6OGdhUEFxMENoNkt2U29JRzhlVFN1alZRU1Rs?=
 =?utf-8?B?WnIvaG9lUFNiZEZ1Qm5mYXFYOVVpUUloSE52Q09pR2VOanh5Nk5CYUI3Z1VO?=
 =?utf-8?B?OTgwbFFZUVNlZWNUak1YaU5ydWh3REFiK3J0OUlFekR2aFcyZEhha1o3dUFw?=
 =?utf-8?B?RlA0bHJKcHREcTNLQ3JZQ3Y3aFhBcGdpNklqMnpiS2VnM2pEdzJjaEg1UEds?=
 =?utf-8?B?L2llWWtCMFJia0hpVU1rdG9jaVZSUHh5ejlrK0FzMHRLT2s1R3pNQm9WRmhF?=
 =?utf-8?B?a3RPQllhZkcvSUR3Z3pWcjN5b3c5bjZxN2ZGckdYc2dWRjBNbHA5ekkzVmRS?=
 =?utf-8?B?Zno0bnM2anZXSzRMZ1N1ZFBwL3ExVUVweWd3WjM3aEhHVGlNMno4a0FodjdV?=
 =?utf-8?B?eFdvNGcxTWx4L2IxY29oZHJWZEY0Z0JkdCtuYW1NazZXMjFRcGMxU0Z0VnAw?=
 =?utf-8?B?NVRkVktDdFVhSEl1dWRBQ3ZHTkt1bElIVVI5Q3h1L0FHQjQrTE9qb0FITDUy?=
 =?utf-8?B?MnZOVTJPaFVJdHRrMjM4Z1NEM1M0cWFGZCt4OVh5bnY1ditFdVZJYUxxemZn?=
 =?utf-8?B?VU90RTVuekpKbnIzdnZGM2pVMDFxTVBCVWIrNXlEcFhsRERlenp1YXY2TlpF?=
 =?utf-8?B?bDUxRnhSTks3Y2pTTkw1MVNTdXdPWHc2ZDlHZUhhZ2l5SytHc2VZdXNlTmNa?=
 =?utf-8?B?WmR2V2JDNXdpaE1xMlZaQTlmbEJhVlh4eUg0WkFxK1RGcW0zY0hKK2NtRFdl?=
 =?utf-8?B?N0xIRlBleEN4b0lzKy9uRlpBYWJvanNwdXJQbWFUZ1JEMTB2bk9jMDlwaWZZ?=
 =?utf-8?B?OEtEVW50dW02ZU9BSzJ6VVovdUwrb3BXaEpXTTZ4dlRkM0kvb21RMlhiVVdl?=
 =?utf-8?B?WWlxZGZLdnpuZWRTOTI2UkNNYmRGcWVxRS9SU3kyRytHNVJIdzllWGZTMlBZ?=
 =?utf-8?B?NHBBdUM4dm5OdVVnQ1Q1K2hBOVhla2ZVdDJPN25MelNNNEpOUUxEQXRSVXAr?=
 =?utf-8?B?Wlk5YmxnWmJpNHNWRXpPWmcwUnRMSWxzSEY2WTdoQVlNZVZkaDVEKzVDVGg3?=
 =?utf-8?B?QjJlRVVlUG5tMEwwZ1B3WlozR0hJbTVqSmYxVWhHeFl5M3c5bGtwS3VTcGU0?=
 =?utf-8?B?UlZKZWo4Ym5Ib2tsUzBGTXNjUk9iVncvVnNrUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 03:19:54.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b7d20d-18ca-4f5c-33fc-08ddf4cfe827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
> Also you can find the full proxy-exec series here:
>   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v21-6.17-rc4/
>   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v21-6.17-rc4

tl;dr

This series seems fine from performance standpoint but the above branch
may have some performance issues but take them with a grain of salt
since this is not all apples to apples comparison.

For this series things are alright - my harness for longer running
benchmarks gave up for some reason so I'll rerun those tests again and
report back later but either tip has some improvements for
netperf / tbench or "proxy-exec-v21-6.17-rc4" may have some issues
around it. I'll take a deeper look later in the week.


o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode


o Kernels

- tip		tip:sched/core at commit 5b726e9bf954 ("sched/fair: Get
		rid of throttled_lb_pair()")
		(CONFIG_SCHED_PROXY_EXEC disabled)

- proxy-v21	tip + this series as is
		(CONFIG_SCHED_PROXY_EXEC=y)

- proxy-full	proxy-exec-v21-6.17-rc4 as is
		(CONFIG_SCHED_PROXY_EXEC=y)


o Benchmark results

    ==================================================================
    Test          : hackbench
    Units         : Normalized time in seconds
    Interpretation: Lower is better
    Statistic     : AMean
    ==================================================================
    Case:           tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
     1-groups     1.00 [ -0.00](10.57)     0.94 [  6.24]( 7.88)     0.91 [  9.46](10.11)
     2-groups     1.00 [ -0.00]( 3.33)     1.02 [ -1.75]( 3.16)     1.04 [ -4.17]( 2.51)
     4-groups     1.00 [ -0.00]( 2.41)     1.01 [ -0.87]( 2.29)     1.03 [ -3.03]( 1.27)
     8-groups     1.00 [ -0.00]( 2.67)     1.02 [ -1.66]( 2.10)     1.01 [ -0.55]( 1.45)
    16-groups     1.00 [ -0.00]( 1.83)     1.01 [ -0.82]( 2.30)     1.00 [ -0.25]( 1.72)


    ==================================================================
    Test          : tbench
    Units         : Normalized throughput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:    tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
        1     1.00 [  0.00]( 0.81)     1.00 [ -0.13]( 0.16)     0.92 [ -8.06]( 0.39)
        2     1.00 [  0.00]( 0.32)     0.99 [ -0.84]( 0.66)     0.91 [ -8.85]( 0.54)
        4     1.00 [  0.00]( 0.32)     0.98 [ -2.37]( 1.40)     0.92 [ -8.28]( 0.28)
        8     1.00 [  0.00]( 0.69)     0.98 [ -2.47]( 0.53)     0.90 [ -9.58]( 0.36)
       16     1.00 [  0.00]( 1.24)     0.96 [ -3.94]( 1.51)     0.90 [ -9.83]( 0.69)
       32     1.00 [  0.00]( 0.60)     0.99 [ -1.47]( 3.38)     0.89 [-11.43]( 5.60)
       64     1.00 [  0.00]( 1.22)     0.99 [ -1.33]( 0.88)     0.91 [ -8.52]( 2.67)
      128     1.00 [  0.00]( 0.34)     0.99 [ -1.48]( 0.99)     0.92 [ -7.51]( 0.13)
      256     1.00 [  0.00]( 1.32)     0.98 [ -1.75]( 0.96)     0.97 [ -3.35]( 1.22)
      512     1.00 [  0.00]( 0.25)     0.99 [ -1.29]( 0.41)     0.97 [ -2.90]( 0.17)
     1024     1.00 [  0.00]( 0.24)     0.99 [ -0.59]( 0.14)     0.98 [ -2.36]( 0.33)


    ==================================================================
    Test          : stream-10
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
     Copy     1.00 [  0.00](10.90)     1.07 [  6.53]( 8.21)     1.07 [  7.26]( 7.22)
    Scale     1.00 [  0.00]( 9.62)     1.04 [  4.00]( 6.99)     1.05 [  4.71]( 5.85)
      Add     1.00 [  0.00](10.17)     1.05 [  5.07]( 6.14)     1.06 [  6.03]( 6.56)
    Triad     1.00 [  0.00]( 8.48)     1.04 [  4.34]( 5.09)     1.04 [  4.07]( 4.40)


    ==================================================================
    Test          : stream-100
    Units         : Normalized Bandwidth, MB/s
    Interpretation: Higher is better
    Statistic     : HMean
    ==================================================================
    Test:       tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
     Copy     1.00 [  0.00]( 1.38)     1.01 [  0.99]( 1.21)     1.02 [  1.68]( 1.50)
    Scale     1.00 [  0.00]( 6.19)     1.02 [  1.94]( 4.34)     1.03 [  3.00]( 1.19)
      Add     1.00 [  0.00]( 4.42)     1.01 [  0.94]( 4.17)     1.02 [  1.58]( 1.54)
    Triad     1.00 [  0.00]( 1.30)     1.01 [  0.61]( 1.37)     1.00 [  0.18]( 2.65)


    ==================================================================
    Test          : netperf
    Units         : Normalized Througput
    Interpretation: Higher is better
    Statistic     : AMean
    ==================================================================
    Clients:         tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
     1-clients     1.00 [  0.00]( 0.41)     0.99 [ -1.03]( 0.34)     0.90 [ -9.96]( 0.46)
     2-clients     1.00 [  0.00]( 0.31)     0.99 [ -1.17]( 0.72)     0.90 [ -9.77]( 0.78)
     4-clients     1.00 [  0.00]( 0.57)     0.99 [ -0.68]( 0.32)     0.90 [-10.21]( 0.89)
     8-clients     1.00 [  0.00]( 0.46)     0.99 [ -0.69]( 0.32)     0.90 [-10.20]( 0.70)
    16-clients     1.00 [  0.00]( 0.57)     0.99 [ -1.39]( 1.28)     0.90 [-10.37]( 1.34)
    32-clients     1.00 [  0.00]( 1.03)     0.97 [ -2.53]( 1.92)     0.90 [-10.00]( 1.23)
    64-clients     1.00 [  0.00]( 1.23)     0.97 [ -3.15]( 2.94)     0.90 [ -9.94]( 1.52)
    128-clients    1.00 [  0.00]( 1.14)     0.99 [ -1.07]( 0.95)     0.90 [ -9.91]( 0.90)
    256-clients    1.00 [  0.00]( 3.73)     0.98 [ -1.80]( 3.66)     0.97 [ -3.41]( 4.47)
    512-clients    1.00 [  0.00](54.79)     0.97 [ -3.03](48.98)     0.95 [ -4.63](51.77)


    ==================================================================
    Test          : schbench
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
      1     1.00 [ -0.00](30.14)     1.11 [-11.11](35.78)     1.31 [-30.56](42.87)
      2     1.00 [ -0.00]( 7.87)     0.93 [  7.14]( 8.45)     0.95 [  4.76]( 7.50)
      4     1.00 [ -0.00]( 7.87)     1.07 [ -7.14]( 7.36)     1.14 [-14.29](12.73)
      8     1.00 [ -0.00]( 4.59)     1.08 [ -8.16]( 5.09)     1.12 [-12.24]( 7.44)
     16     1.00 [ -0.00]( 5.33)     1.05 [ -5.08]( 0.93)     1.05 [ -5.08]( 2.75)
     32     1.00 [ -0.00]( 1.04)     1.00 [ -0.00]( 3.12)     1.07 [ -7.29]( 4.49)
     64     1.00 [ -0.00]( 1.04)     0.96 [  3.50]( 3.78)     1.01 [ -1.00]( 2.24)
    128     1.00 [ -0.00]( 5.11)     1.06 [ -6.11]( 7.56)     1.09 [ -8.60]( 6.26)
    256     1.00 [ -0.00](19.39)     1.29 [-28.73](14.92)     1.15 [-14.71](14.83)
    512     1.00 [ -0.00]( 0.15)     0.98 [  2.02]( 1.85)     0.99 [  1.01]( 1.66)


    ==================================================================
    Test          : new-schbench-requests-per-second
    Units         : Normalized Requests per second
    Interpretation: Higher is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
      1     1.00 [  0.00]( 0.26)     1.00 [  0.29]( 0.15)     1.00 [ -0.29]( 0.30)
      2     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.15)
      4     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.15)     1.00 [  0.00]( 0.00)
      8     1.00 [  0.00]( 0.15)     1.00 [  0.29]( 0.15)     1.00 [  0.29]( 0.15)
     16     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)     1.00 [  0.00]( 0.00)
     32     1.00 [  0.00]( 1.86)     1.00 [ -0.31]( 0.28)     1.00 [ -0.31]( 2.12)
     64     1.00 [  0.00](13.62)     0.99 [ -0.77]( 4.78)     0.81 [-18.52](11.11)
    128     1.00 [  0.00]( 0.00)     1.00 [  0.38]( 0.00)     1.00 [  0.38]( 0.00)
    256     1.00 [  0.00]( 1.49)     1.02 [  1.82]( 1.63)     1.00 [  0.00]( 1.19)
    512     1.00 [  0.00]( 0.75)     1.01 [  0.71]( 1.65)     1.01 [  1.19]( 1.53)


    ==================================================================
    Test          : new-schbench-wakeup-latency
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
      1     1.00 [ -0.00]( 6.74)     1.00 [ -0.00]( 6.74)     1.12 [-12.50](19.26)
      2     1.00 [ -0.00](11.18)     1.00 [ -0.00](17.21)     1.50 [-50.00]( 7.45)
      4     1.00 [ -0.00]( 9.94)     1.00 [ -0.00](19.26)     1.56 [-55.56](15.78)
      8     1.00 [ -0.00](10.68)     1.00 [ -0.00](10.68)     1.44 [-44.44](28.77)
     16     1.00 [ -0.00]( 9.68)     1.00 [ -0.00]( 9.68)     1.20 [-20.00]( 8.15)
     32     1.00 [ -0.00](14.08)     1.00 [ -0.00]( 5.34)     1.20 [-20.00](14.70)
     64     1.00 [ -0.00]( 3.52)     1.13 [-13.33]( 5.26)     1.27 [-26.67]( 2.77)
    128     1.00 [ -0.00]( 1.79)     1.07 [ -6.56]( 2.70)     1.07 [ -6.97]( 7.71)
    256     1.00 [ -0.00]( 9.89)     1.04 [ -4.50]( 3.81)     1.02 [ -2.00]( 7.78)
    512     1.00 [ -0.00]( 0.00)     1.01 [ -0.77]( 0.34)     1.00 [ -0.00]( 0.20)


    ==================================================================
    Test          : new-schbench-request-latency
    Units         : Normalized 99th percentile latency in us
    Interpretation: Lower is better
    Statistic     : Median
    ==================================================================
    #workers: tip[pct imp](CV)      proxy-v21[pct imp](CV)   proxy-full[pct imp](CV)
      1     1.00 [ -0.00]( 1.33)     0.96 [  3.89]( 1.46)     1.02 [ -1.82]( 3.02)
      2     1.00 [ -0.00]( 0.14)     1.01 [ -1.09]( 0.24)     1.02 [ -2.44]( 2.73)
      4     1.00 [ -0.00]( 1.24)     1.00 [ -0.26]( 1.69)     0.97 [  2.65]( 0.14)
      8     1.00 [ -0.00]( 0.54)     1.00 [ -0.00]( 1.02)     0.99 [  1.31]( 2.16)
     16     1.00 [ -0.00]( 0.36)     1.00 [ -0.00]( 1.70)     0.98 [  1.59]( 1.00)
     32     1.00 [ -0.00]( 5.51)     0.99 [  0.73]( 2.09)     1.01 [ -1.45]( 7.52)
     64     1.00 [ -0.00]( 5.38)     1.09 [ -9.27]( 0.88)     1.09 [ -8.56]( 0.11)
    128     1.00 [ -0.00]( 0.32)     1.00 [ -0.36]( 0.32)     1.03 [ -2.54]( 1.15)
    256     1.00 [ -0.00](10.51)     1.14 [-14.23](11.19)     1.00 [  0.24](11.42)
    512     1.00 [ -0.00]( 2.00)     1.03 [ -3.27]( 0.94)     1.02 [ -2.41]( 1.96)


-- 
Thanks and Regards,
Prateek


