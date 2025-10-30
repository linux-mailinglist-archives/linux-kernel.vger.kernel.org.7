Return-Path: <linux-kernel+bounces-877907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31B0C1F520
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59413BD6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7F7343D67;
	Thu, 30 Oct 2025 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vNOjH+zS"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A322D0292
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816805; cv=fail; b=m+1DuZ04xAsaMv59GxmJl1mcG73TMuwCeFWit1NjzzSLaUGKXf6VFWyZs/oEexrZmKJ5aJxz/QnFW/prcROls9o1tpP/Xrk3V8PVuW/1ktmpOCb4FMIls11F5xPZC5REN1ZSw/aphDeLbu6VVgpzhopyT2Nlv8vj5wv/1qdsios=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816805; c=relaxed/simple;
	bh=a5/cmnIX16O/e72ombO5/ArivuF6aPyKlvbPlMjKWhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iZL52806p7bjI9bvGApS7CxZPs3IQS4iHN0Z05khwmsDbg31CMrMsqjkmY/sVBpOPfCIR1Qdx2HR+1XwkGO7WHpBxbHTbP/hhvE/gOO5DV7bgWExOUr0Og5u9bcoRTy32bqibP1T246TpKG1GOI5qEao4XZ3uinI3/P+BtYyeeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vNOjH+zS; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKe9gacuZf9pOdsLwrqPQ5osLWTHkkxNr5dwUKFgJJ/YbKnEm6gtqNy19uSD8Bo98BedPDculSvwuolkMM7KpaA+nJFoOM0eFwqSY+qYEaHvL5J9/uLJRKvRTynQdX4AigzjebV+WbwMIWnC9bIRLcPSfJsQYk3XsJuLSZA7AAzIcTZ3ZGwEe3Mo0o/cSuUoy38tdl01o12T/PXIllcDd8LeWiaZWjIU/rjewti0UKmAw9IuDrv3X5fxScPKHjfRE5NcjHd7wkRZYKNr5RdMISChJTUpW4H+a6xQeUzr9cp0aIIKoW5opQ9AdX/aFqhgtP+++FdkmV/TW/BekKhr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vywXWJEOx0Bbh/uV06jaecTNSdk8qAJwNE23+FCkB5c=;
 b=L6a0N9unEFm5AylttlxZYKIY9cb0D03RDyw+HbLYuvtzsuz2AUhRYuddyskL6esXFi9oDEySFrHLIKMaY997waQ4sJ5qx32ShcXeha8azofD/w/yObGye/WP8fU/vheHBzR+u5DnA40X98ulQJPF24oR3kVGZsAHPInL0wL9YXATniOMOFAl9hu3hLytDh5HxA4hNkdVT4Q2qjWXweTQNuAhGmQQvR9B0kdR1h0X4H2TTyZ97N0ArMoiAuX0DFPaEQdzsei5eG8Gs5HeGDWcC2ei9rQh9DgovzCQhnb7oIOtAQAH4YyC4Xyr2n/+UU+4zgT1LdKm3OANQLLrAfNsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vywXWJEOx0Bbh/uV06jaecTNSdk8qAJwNE23+FCkB5c=;
 b=vNOjH+zSar0J4hnT9uVnTHxfV9D2DQMggM6jWFqudnMK4lIOLDRgNhQpdzU6+ydsxrRRIGJHt1yXbY78P4kWgjF5AQxaeZ8XaMja2D0sW6EfYgYy04R97Q/s4+gQEFP4cJgUfe4Sb8P7YbL4j+75F3NVZocnaLHr+nl5LS8fR6k=
Received: from BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32) by
 CY1PR12MB9627.namprd12.prod.outlook.com (2603:10b6:930:104::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Thu, 30 Oct 2025 09:33:16 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::6b) by BYAPR01CA0055.outlook.office365.com
 (2603:10b6:a03:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 09:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:33:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:32:52 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:32:52 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 02:32:46 -0700
Message-ID: <0c337bca-4ecf-4654-9256-df766573c7de@amd.com>
Date: Thu, 30 Oct 2025 15:02:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and
 return migration)
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
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-7-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-7-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|CY1PR12MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: a6069d16-4978-495b-b5c7-08de17975b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEpPNEFKb1V0WUhtTkJmVUVZQnNDTEFNYytJOFNnUTlwc01QUnpDM2l2U2FT?=
 =?utf-8?B?WUcvaUt2K3hpanRFVVNCcGFJenN0aUZZK2hvUnMvRkk4QnRhY0JzOWIvOVFL?=
 =?utf-8?B?blg3d0k1SWlCOHJOcHVuWFEyekVjL0U2S3NQY29Mb1JYWS8xTzVQTUVRMC9p?=
 =?utf-8?B?cndVV3M5ZkxtbVlnUkJrYkpaM1pNUkV0NnpWNTUwOUpKTWx2OUFOM1lmWFlT?=
 =?utf-8?B?dXIyNTNrQ2xEK0EvR1RObS9lQm01N24zUlI1NWJsRlJPMjNudUpSRldScm1m?=
 =?utf-8?B?UHRyaldidGlveS8vR09pUzBSMjhhMnAyRFh1RVpOMVM4MVBlTEc2MXJrcWNp?=
 =?utf-8?B?WnAwcGFzdThiSXUySEZ6ekRjQjNxNytWZnRFY0ErdVdyZjNnOU5SWU9KWDRZ?=
 =?utf-8?B?NzBUMHRVMlNPckVpanVxMGFHbmY0N0NBOTJ1cWVranAyRjFhVkNVS01qNkZL?=
 =?utf-8?B?TEdkQmR1aitsN1RhUGNTQ2RnUGRrUndweDQrb2hNUEZpSXcyekxXTTA4SS9Z?=
 =?utf-8?B?QWlEK1BXTGZRR2F3RlUyNy95Mno5Sk9RSmtjYzJLcTVIM3NDOEZoQUY1VHcy?=
 =?utf-8?B?TVIvVDNNSWxBR29hSlFrcjZ5RG41L1Mxb05jTThITURIMDZ0aHJLamVSMDVR?=
 =?utf-8?B?Vk9Ca2kxZUs2MFB1YzdrMFpIVTRzYytZYmMwSGgxTWk3M1JTaHYxVEpCRmtr?=
 =?utf-8?B?OVNodjhrVU0raFJQOUtkU0pSOCtUOGtwbDJmN0JPZnhZSkNxZzA1VExRMXRE?=
 =?utf-8?B?RU92U0dtWWx0emxWZjNoN0xvNTR3ZkZMbEswTkpyTWhnMWVLejVIZ0gya2c1?=
 =?utf-8?B?NXlldVBFR1c1a0k0S0Y4VExubjIzMnYweTFtSG5XV29iN2JPT0ZYeXNRamFI?=
 =?utf-8?B?by9XTTBnOVhkNjlSc251Nkl2RzZmVktzVFNYQXR4SkdRRWxiTGFyQnQwdlU5?=
 =?utf-8?B?alZ5L0x6VzBDQzEwTEd6OW9pUnl1T2dWSUhmYm1LY2VyN05KN0tYTnpFQkc0?=
 =?utf-8?B?OHorNGZ0bm5HVVdPVjlDbUhxbkNRKzgxWUtsbnplRzd1WTk2cXJqTm83RnpS?=
 =?utf-8?B?bi9WTVlYNXh3WlFtd2drMEoxU0RLSUgxTlBTZk9NbHN0cnl5QkFNUHNYTVFW?=
 =?utf-8?B?WndWdkhYa0U4ZVVVam16QVJGTFdudWQxUlE5bWxNcWFsMlYvTGZIL1lkZ0tr?=
 =?utf-8?B?NTlETnpkUVV4MEVWQVJNM1pTYWxLUW9YNE9Jd3FWd3RUVm1tZ1grcGZzM1ly?=
 =?utf-8?B?d3FNclFGOE9qRlA5OFhWYWV2eTI5Qzhsa2pYV3lYa1R1QklMOGlRbXR6cGFT?=
 =?utf-8?B?cUZvQ2gzNW83SVZHZ3oyb0J1NUI5UUV1d21HSkMzLzlIVnlvamUyVE1SK3dt?=
 =?utf-8?B?UzBYSEVyK1N2QitSMGtzT3JYRldOVGxOaG83U0dFb05UQ3dubng2Uy9tZUtV?=
 =?utf-8?B?NVNJZHdkQVBJTFRiMFk0NkxrZlVZRlEvVDNWSmF0bjkrVmJQejhiTWNQYmZ5?=
 =?utf-8?B?OW00MUlZN012MGtlZm1JQXJPSmtGN3JZdm85YVZrWHdiNzh5MmQvR3pNTTlP?=
 =?utf-8?B?b25zWWRGMFB5KzdObVpPTzNGL1Rmd2tkOHlBMXFJSUh2M1htb1RSN0pmb1Fm?=
 =?utf-8?B?WExWNWl3YmU1N1BhcWhpTTQ4dDAvQWcxMjkwZE8yTnRUZ3B2NE1naUppY0FS?=
 =?utf-8?B?Y1dkTlFqa1l3NzBlUTJZNTE1Z0tGWWRscDkxRFN1UW5QMysyUTM4S1A3N0g0?=
 =?utf-8?B?a2taNDJNaE12aGZhK1BJZXpjUGxiQUFaUzVCZHZWY0xBYTJrcERvcnBwUmF0?=
 =?utf-8?B?S3hUQzcrNnZmRnpEd2FUaFd6Z1R1RkNOd2NGZWdWaVZSVTJOdFRNNjRJTHRF?=
 =?utf-8?B?QXEwZ1k5WDl0d3dvbzZsMlRxYVJxWUZ5RDVRQ2Q5ODVQcFNjamtJMXVsTHJY?=
 =?utf-8?B?ODRVQVByd1VsQTVSRzBSZGd4aXdlLzg3RzFFTFJqdVJSUzRlYzU5ZGo0V0dX?=
 =?utf-8?B?K0ZuNnZ2K0pxbU0vaTF6cnBNblQ3SVZDSkY1Q3BIclU5c0JsaHdTenJFRHNW?=
 =?utf-8?B?ZmxLbFBNL1FTcTFUelRNeXBKZzFHSk1ydjE1elkyN3l0bmI3Tk8yZ0JkMFg2?=
 =?utf-8?Q?//d8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:33:16.7268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6069d16-4978-495b-b5c7-08de17975b08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9627

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> -static struct task_struct *proxy_deactivate(struct rq *rq, struct task_struct *donor)
> +/*
> + * If the blocked-on relationship crosses CPUs, migrate @p to the
> + * owner's CPU.
> + *
> + * This is because we must respect the CPU affinity of execution
> + * contexts (owner) but we can ignore affinity for scheduling
> + * contexts (@p). So we have to move scheduling contexts towards
> + * potential execution contexts.
> + *
> + * Note: The owner can disappear, but simply migrate to @target_cpu
> + * and leave that CPU to sort things out.
> + */
> +static void proxy_migrate_task(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p, int target_cpu)
>  {
> -	if (!__proxy_deactivate(rq, donor)) {
> -		/*
> -		 * XXX: For now, if deactivation failed, set donor
> -		 * as unblocked, as we aren't doing proxy-migrations
> -		 * yet (more logic will be needed then).
> -		 */
> -		clear_task_blocked_on(donor, NULL);
> +	struct rq *target_rq = cpu_rq(target_cpu);
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	/*
> +	 * Since we're going to drop @rq, we have to put(@rq->donor) first,
> +	 * otherwise we have a reference that no longer belongs to us.
> +	 *
> +	 * Additionally, as we put_prev_task(prev) earlier, its possible that
> +	 * prev will migrate away as soon as we drop the rq lock, however we
> +	 * still have it marked as rq->curr, as we've not yet switched tasks.
> +	 *
> +	 * So call proxy_resched_idle() to let go of the references before
> +	 * we release the lock.
> +	 */
> +	proxy_resched_idle(rq);
> +
> +	WARN_ON(p == rq->curr);
> +
> +	deactivate_task(rq, p, 0);

DEQUEUE_NOCLOCK since we arrive here with the clock updated from
schedule().

> +	proxy_set_task_cpu(p, target_cpu);
> +
> +	/*
> +	 * We have to zap callbacks before unlocking the rq
> +	 * as another CPU may jump in and call sched_balance_rq
> +	 * which can trip the warning in rq_pin_lock() if we
> +	 * leave callbacks set.
> +	 */
> +	zap_balance_callbacks(rq);
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +	raw_spin_rq_lock(target_rq);
> +
> +	activate_task(target_rq, p, 0);
> +	wakeup_preempt(target_rq, p, 0);
> +
> +	raw_spin_rq_unlock(target_rq);
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);

We should perhaps update the clock once we've reacquired the rq_lock
given we are going into schedule() again for another pick.

> +}
> +
> +static void proxy_force_return(struct rq *rq, struct rq_flags *rf,
> +			       struct task_struct *p)
> +{
> +	struct rq *this_rq, *target_rq;
> +	struct rq_flags this_rf;
> +	int cpu, wake_flag = 0;
> +
> +	lockdep_assert_rq_held(rq);
> +	WARN_ON(p == rq->curr);
> +
> +	get_task_struct(p);
> +
> +	/*
> +	 * We have to zap callbacks before unlocking the rq
> +	 * as another CPU may jump in and call sched_balance_rq
> +	 * which can trip the warning in rq_pin_lock() if we
> +	 * leave callbacks set.
> +	 */
> +	zap_balance_callbacks(rq);
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_rq_unlock(rq);
> +
> +	/*
> +	 * We drop the rq lock, and re-grab task_rq_lock to get
> +	 * the pi_lock (needed for select_task_rq) as well.
> +	 */
> +	this_rq = task_rq_lock(p, &this_rf);
> +	update_rq_clock(this_rq);

I think we can delay the clock update until proxy_resched_idle().

> +
> +	/*
> +	 * Since we let go of the rq lock, the task may have been
> +	 * woken or migrated to another rq before we  got the
> +	 * task_rq_lock. So re-check we're on the same RQ. If
> +	 * not, the task has already been migrated and that CPU
> +	 * will handle any futher migrations.
> +	 */
> +	if (this_rq != rq)
> +		goto err_out;
> +
> +	/* Similarly, if we've been dequeued, someone else will wake us */
> +	if (!task_on_rq_queued(p))
> +		goto err_out;
> +
> +	/*
> +	 * Since we should only be calling here from __schedule()
> +	 * -> find_proxy_task(), no one else should have
> +	 * assigned current out from under us. But check and warn
> +	 * if we see this, then bail.
> +	 */
> +	if (task_current(this_rq, p) || task_on_cpu(this_rq, p)) {
> +		WARN_ONCE(1, "%s rq: %i current/on_cpu task %s %d  on_cpu: %i\n",
> +			  __func__, cpu_of(this_rq),
> +			  p->comm, p->pid, p->on_cpu);
> +		goto err_out;
>  	}
> -	return NULL;
> +
> +	proxy_resched_idle(this_rq);
> +	deactivate_task(this_rq, p, 0);

This should add DEQUEUE_NOCLOCK since we've already updated the rq clock
before the call.

> +	cpu = select_task_rq(p, p->wake_cpu, &wake_flag);
> +	set_task_cpu(p, cpu);
> +	target_rq = cpu_rq(cpu);
> +	clear_task_blocked_on(p, NULL);
> +	task_rq_unlock(this_rq, p, &this_rf);
> +
> +	/* Drop this_rq and grab target_rq for activation */
> +	raw_spin_rq_lock(target_rq);
> +	activate_task(target_rq, p, 0);
> +	wakeup_preempt(target_rq, p, 0);
> +	put_task_struct(p);
> +	raw_spin_rq_unlock(target_rq);
> +
> +	/* Finally, re-grab the origianl rq lock and return to pick-again */
> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);
> +	return;
> +
> +err_out:
> +	put_task_struct(p);
> +	task_rq_unlock(this_rq, p, &this_rf);

I believe as long a we have the task_rq_lock(), the task cannot
disappear under us but are there any concern on doing a
put_task_struct() and then using the same task reference for
task_rq_unlock()?

> +	raw_spin_rq_lock(rq);
> +	rq_repin_lock(rq, rf);

Probably a clock update once we reacquire the rq_lock since we
go into schedule() again to retry pick?

> +	return;
>  }
>  
>  /*
> @@ -6655,10 +6792,12 @@ static struct task_struct *
>  find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  {
>  	struct task_struct *owner = NULL;
> +	bool curr_in_chain = false;
>  	int this_cpu = cpu_of(rq);
>  	struct task_struct *p;
>  	struct mutex *mutex;
> -	enum { FOUND, DEACTIVATE_DONOR } action = FOUND;
> +	int owner_cpu;
> +	enum { FOUND, DEACTIVATE_DONOR, MIGRATE, NEEDS_RETURN } action = FOUND;
>  
>  	/* Follow blocked_on chain. */
>  	for (p = donor; task_is_blocked(p); p = owner) {
> @@ -6667,9 +6806,15 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  		if (!mutex)
>  			return NULL;
>  
> -		/* if its PROXY_WAKING, resched_idle so ttwu can complete */
> -		if (mutex == PROXY_WAKING)
> -			return proxy_resched_idle(rq);
> +		/* if its PROXY_WAKING, do return migration or run if current */
> +		if (mutex == PROXY_WAKING) {
> +			if (task_current(rq, p)) {
> +				clear_task_blocked_on(p, PROXY_WAKING);
> +				return p;
> +			}
> +			action = NEEDS_RETURN;
> +			break;
> +		}
>  
>  		/*
>  		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
> @@ -6689,26 +6834,41 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  			return NULL;
>  		}
>  
> +		if (task_current(rq, p))
> +			curr_in_chain = true;
> +
>  		owner = __mutex_owner(mutex);
>  		if (!owner) {
>  			/*
> -			 * If there is no owner, clear blocked_on
> -			 * and return p so it can run and try to
> -			 * acquire the lock
> +			 * If there is no owner, either clear blocked_on
> +			 * and return p (if it is current and safe to
> +			 * just run on this rq), or return-migrate the task.
>  			 */
> -			__clear_task_blocked_on(p, mutex);
> -			return p;
> +			if (task_current(rq, p)) {
> +				__clear_task_blocked_on(p, NULL);
> +				return p;
> +			}
> +			action = NEEDS_RETURN;
> +			break;
>  		}
>  
>  		if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {

Should we handle task_on_rq_migrating() in the similar way?
Wait for the owner to finish migrating and look at the
task_cpu(owner) once it is reliable?

>  			/* XXX Don't handle blocked owners/delayed dequeue yet */
> +			if (curr_in_chain)
> +				return proxy_resched_idle(rq);
>  			action = DEACTIVATE_DONOR;
>  			break;
>  		}
>  
> -		if (task_cpu(owner) != this_cpu) {
> -			/* XXX Don't handle migrations yet */
> -			action = DEACTIVATE_DONOR;
> +		owner_cpu = task_cpu(owner);
> +		if (owner_cpu != this_cpu) {
> +			/*
> +			 * @owner can disappear, simply migrate to @owner_cpu
> +			 * and leave that CPU to sort things out.
> +			 */
> +			if (curr_in_chain)
> +				return proxy_resched_idle(rq);
> +			action = MIGRATE;
>  			break;
>  		}
>  
> @@ -6770,7 +6930,17 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>  	/* Handle actions we need to do outside of the guard() scope */
>  	switch (action) {
>  	case DEACTIVATE_DONOR:
> -		return proxy_deactivate(rq, donor);
> +		if (proxy_deactivate(rq, donor))
> +			return NULL;
> +		/* If deactivate fails, force return */
> +		p = donor;
> +		fallthrough;
> +	case NEEDS_RETURN:
> +		proxy_force_return(rq, rf, p);
> +		return NULL;
> +	case MIGRATE:
> +		proxy_migrate_task(rq, rf, p, owner_cpu);
> +		return NULL;
>  	case FOUND:
>  		/* fallthrough */;
>  	}

-- 
Thanks and Regards,
Prateek


