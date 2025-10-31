Return-Path: <linux-kernel+bounces-879512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B633C23472
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9933A3B6DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EADA2D3EE4;
	Fri, 31 Oct 2025 05:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rjjDT5tB"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239012472BD
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761886996; cv=fail; b=mg9bFq+aVIKwn+gRYFBnhm9hWdZqBYIEeNDQxZfPCfePRHUImA3OwXB1q3mBiTpC6AEWuaB6LrgBzbYVm8sILIenG5S77syoFYCEl236U0sYrIjcvfbVGBo6TvuX6kkVHLPqrz1c8gH7SPn9XsDGr8oWU6BoEUH+IePrLV4UPFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761886996; c=relaxed/simple;
	bh=homOu2L6RlWg0zKw10KIyM64/dij4aEy2Kpjk+eJ4bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kLTXmRYrNH+IwpRVPtSuk+23w0TmH2yM2PjhLOO/5mY/CKDZV1+ypvSOARGuC3i2F1hGWAE747CLVTjN7cT1LRgXRfRf0qPmr1LBNaknwfx4HyM1THowN7YG9YDbNNL+Ar8ep6ZQOUkK9GJ0vv7P1CILArB54QwLnMFpramrgjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rjjDT5tB; arc=fail smtp.client-ip=52.101.56.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X051z0dc9X5dzy04fWatME8ldFtTHCkW0qEQRhj4VdnfJAJCy4b6acBTQ09P6mb9AU0kXbi8gSjFnTmhj8KudLTP+8Q9IJyLDwpqrZl/1XWjl2nt4wp8bD46hp68x8Zl5Ygh+VOLDuPSR0L4QUjM2efJOYx/BnuBWGuH2UJzo7PCko4ST+4Csnh17WrhSnAuPVO8rX4bWyPN2Kqvs8ymQmpyGwuU4RjoQjKx7tseC+QOAs380ryxMevBgcC/qrR/itx/61EZUZVx+v054RuyWRD3paWD1GV4IB43wH1P7FBRaAbzoSVpCuw9GrPe6Bvtf3iXvfHQx58KpqgbE6o1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9gG0BBfdQihQ+jIypHd0CymBaA96uNQGiUllJ92fhM=;
 b=ZXpvkfeTWT2/xZjf1KjgHjb3O8hvAmsOZem3H7cpfGAcK7jAz8RWkOpYYwxLvjh/kKPrCel3gzVYxHIVNKZpkxVHpKWMQTQ3Cqxw2EnhrN533w2A0Etg3t5Qd15vdFr+nQXPhkA1OyPDLExZZkfryO+UbuWPxhrrFJRK7d+GzQOhiv8y/1sQURmFx5WmZkUTBb77G2oVRhEtW2q3l219YLuaXXHgdOpM3AUe99jdhqyy4QwzTmrgCEjxCfWjf+QeAHA0KUWZEioVj6Nuk18IKpCCP7UItBNoxcKoUQbgiLLuKrfBNiwlKQEF7sxkYoMUqMAH7+FUXYKuSJexw56Aug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9gG0BBfdQihQ+jIypHd0CymBaA96uNQGiUllJ92fhM=;
 b=rjjDT5tBPcWuLN3awz+xFWwBITPIgUXIZ3juPZE821zdS0opMo6T0SumvcdYd6gck2pHNQ3gLeybXWthFVckAezb6tqhWXCUk7+6MHL4Zeriji0hgLjD4RW+Ud4aNubdEyqwII3DT0zNki6iQKqsOF2NVPBcNpuPTTwMW8BIPzo=
Received: from SA1P222CA0154.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::27)
 by SA5PPF530AE3851.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 05:03:09 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::10) by SA1P222CA0154.outlook.office365.com
 (2603:10b6:806:3c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 05:03:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 05:03:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 22:01:53 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 22:01:53 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 22:01:46 -0700
Message-ID: <f9b42bf8-e4c8-4028-a977-f324ba2f2275@amd.com>
Date: Fri, 31 Oct 2025 10:31:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 8/9] sched: Add blocked_donor link to task for smarter
 mutex handoffs
To: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>,
	LKML <linux-kernel@vger.kernel.org>
CC: Juri Lelli <juri.lelli@redhat.com>, Valentin Schneider
	<valentin.schneider@arm.com>, Connor O'Brien <connoro@google.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, "Ingo
 Molnar" <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-9-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-9-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c261cf1-fe37-4b13-637b-08de183ac8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDR5ZWpaaG0wdE9lRUFHM0hFcE9zckliL0k3ZGV3TTRQemJrVzlLYjhNcy9a?=
 =?utf-8?B?aitWNHFmc2NRQUdBTnlWVmYwOTFxRmRSSEdPUWZ1ZUdYTXNhd1VzYmViaTBI?=
 =?utf-8?B?eml1dDFwMmVKVm14Qk1nMTlacWVxdWQzQnVRZ1ZnemNkY1JvMVF1cXVjYm1Z?=
 =?utf-8?B?UVZHZFArTVVBd3VHejJXdnNoZTNScmVWMTAxSW04YzJ1cVY3OVFGMVlHVjll?=
 =?utf-8?B?cHRaUWNhTmpPb0d3T3NNalRraXZxZnprcG1DamtzOFpUYVhIL1BZdEFuMHph?=
 =?utf-8?B?emtTYk5VaUIzNENqMFBMUWFmalgxTXk1NHZGd29FYXFadm1vNCt3YysyWkJM?=
 =?utf-8?B?V29IeEM3WlI1NzA4SzdjemFGQXhQRnhyYml0dXVWM2o3cDJUaExRMm5Kb2V5?=
 =?utf-8?B?Qjl4VktEUGUyVjUwYUZ2SkdoUFpEWHEwMG1ZaTlaOEFJaXBDTEV5RElPcEQx?=
 =?utf-8?B?NHlNQTk0eE9NZkppNEE0b09JV3RqVVNqNXBDNzFHZjZPaFgwS1B2QVducFJJ?=
 =?utf-8?B?MXBsV0NqcHRaTEJxNWk2VlZGcDNHUmRRUEdCWVRVSmpoc2pmdDcxZDYrR29n?=
 =?utf-8?B?TE9KcEc5TXpPR3g5djJJdHBoNkdyOFdML1dJWEM0Rm9kM3Z3ckxUcGNIbmVt?=
 =?utf-8?B?aUxpMFJUSThnOXM0QnVPcER1UWpGYlYxSkdhUWk3TGxnWUIrdEVyL2hqN2dV?=
 =?utf-8?B?V0FpUm9LZFI3VysxamV5VTN2RVk1M2V4Q1BtclNjdk9GeXpJbFc4YVVyY1l4?=
 =?utf-8?B?c2ozdnhiYU5nQlFDVEVqTkxCbjlZekI1MThaUndzNm5FdVdlcHNKNDU1VFFN?=
 =?utf-8?B?NHdnRmtUTUhTVjRXYnBUS1kwRmRvSDErdVVGTm53eE9xNnpoYjFSQ1Jtcm1M?=
 =?utf-8?B?NDU1bTlDUzJ6eE9yYi84K0tBbngxK0EwTmh1cGttM2x6OVlpTGEwR2ZvUkQr?=
 =?utf-8?B?T25lRHQzeVAyOHZrK243cFUwOGxVUWFuWXlHUVZCdUJ5QVg5UW1OdGowL1o0?=
 =?utf-8?B?V1h1SDlLbm5aWjFZUnZFbDBCYlQ3cFlLaTQweXV1VjdEUmFoZjhEeUhyMEh6?=
 =?utf-8?B?MUt1TThCb3grSkI5dTVzOHorZFJEbjNNR1BwS0hCMTdHOEJpQmdDZmF6YThC?=
 =?utf-8?B?aVE3WXN2SEpvU3A2M3dpNEV1d1k1ZXVYbEluRzNpTkxoVXFFSTZJcmdMaFg5?=
 =?utf-8?B?TFBsLzBJQ1ZHWUFGWG9Tc3oyb0kvRTFFeEVnZXZZZ0traDAzUXpzb1JhSFNM?=
 =?utf-8?B?eTlGc3U5bjI4WnRtVVJLdE1pMnNEVGlpMExaZHc3TUlvR0UrUHlOemlmTzhi?=
 =?utf-8?B?ajJzUnFRSjg3TFVsR2x6M21rOHlrajdvNG9zVDdSdXN0MEM5STRtc3FDRFcr?=
 =?utf-8?B?QnZBSnBaN0ZPZy9OVUtMOE9Ub1ZYd3VvbWRVNVNxMEhsa1VDNzIyRCtpK0d6?=
 =?utf-8?B?bFVpNkUwV1ZmRUJaWkV2dWJZTlRyV3FsbnBTdWxhM2NhYVUzMGY2dEcwZ0hM?=
 =?utf-8?B?WHlFZnBLYXAwTG1yK3dVSEtIT3lzOW1XN3BILzhGQld4OXRDbFFIOFRxL2xL?=
 =?utf-8?B?TUxrOEJyOXFmc21JSXAxUjNHcE5CQzJOdTkxNHhVaEJOck8rNUx3SjRlV21T?=
 =?utf-8?B?WnBBSFJhdFhvNnpnVkdvM1IrUXA4SC9NN3RmazRJQ3lFcjdJSnBsZ1A5ZnVI?=
 =?utf-8?B?NVNUYnBHTVV4clJCTmlvaHMzOUlidkRpTS9UM2lwQ29aSjdlMW1xOFdheU5a?=
 =?utf-8?B?d0c4WFptZlR2YllzeWlGNmtjMGh2MEorSDIyNDh5dVp2UC85OTYxTzU5c1Fa?=
 =?utf-8?B?OWR3QnRRYXg1VTRGSlFJN0J4TUNObnNZZGgzdG5xSURmRE5INUxrb1gzVVJC?=
 =?utf-8?B?L3NzbUtQU2h4NStJbVRpWC85Vjh2a0RndURhTkVVOFQ1cHVkdHliUkZUTEkz?=
 =?utf-8?B?ejBMc3JIUHRuTnNZeUNsUXRvNE9tYzh5eFZqTGM5a2wvT3hyQllXazFrSFF1?=
 =?utf-8?B?Qk9ZTTcrcytGUjg3QjJuOURRRFRUUFhDMk0rOHZZVXZ5eklYZ25oZUE1aDQw?=
 =?utf-8?B?L3R6TC9HMG5UWUVsYy9rSG1aa0Z1SmFJSEdlVXJtMHQxTGJxbXBYSFdoVTFS?=
 =?utf-8?Q?Za4c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 05:03:08.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c261cf1-fe37-4b13-637b-08de183ac8d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851

Hello Peter, John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> @@ -958,7 +964,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>  
>  	raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  	debug_mutex_unlock(lock);
> -	if (!list_empty(&lock->wait_list)) {
> +
> +	if (sched_proxy_exec()) {
> +		raw_spin_lock(&current->blocked_lock);
> +		/*
> +		 * If we have a task boosting current, and that task was boosting
> +		 * current through this lock, hand the lock to that task, as that
> +		 * is the highest waiter, as selected by the scheduling function.
> +		 */
> +		donor = current->blocked_donor;
> +		if (donor) {

Any concerns on new waiters always appearing as donors and in-turn
starving the long time waiters on the list?

> +			struct mutex *next_lock;
> +
> +			raw_spin_lock_nested(&donor->blocked_lock, SINGLE_DEPTH_NESTING);
> +			next_lock = __get_task_blocked_on(donor);
> +			if (next_lock == lock) {
> +				next = donor;
> +				__set_task_blocked_on_waking(donor, next_lock);
> +				wake_q_add(&wake_q, donor);
> +				current->blocked_donor = NULL;
> +			}
> +			raw_spin_unlock(&donor->blocked_lock);
> +		}
> +	}
-- 
Thanks and Regards,
Prateek


