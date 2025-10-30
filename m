Return-Path: <linux-kernel+bounces-877701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55452C1ECE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6658189CACC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F9A337B81;
	Thu, 30 Oct 2025 07:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C5BYV1CT"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CBD335BB6
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809916; cv=fail; b=tgqgKLWq73gRvPlabZpWITywBgHpFQ6GVtJjLCVkXfNlDJwnU3PkkOH1bECxrBsp24h29h6KdJ7vMkfRSu4uUg3vDQgjxG3l++fNv2anP8/QwuPnKbGdNl0qGzBDyTUSyB0K4AGuCPFPmttGUs9eKeBXk0o+9wJemIkC+yqoOrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809916; c=relaxed/simple;
	bh=Egzk1qINe4UC1i4sGuRN2DP7WrM8H7acPO/V53J7p4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C/nN8aVKeXkssdX/Za7PHhbwa8OYgOZ8FnT4JnN4fPV4sQjL965NI8Kr2ng7KeY+Pe8NiFMpwjrYx/72uvMWBriD6exqX82xGy/1Ihb0yhgw0K1Bz462LKqQ2qPumIXtTYq4LcorFQrkUV0gP6G38sI/4exTpJ6wk8UMKM8XlmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C5BYV1CT; arc=fail smtp.client-ip=52.101.85.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRamGRJ2TXvP1G1HRCXR206E2Cd0dzbJ/hqpcVIvrL7olzez+ivm/S0Fn318yPt/heEZVozSfZkgSlyM3I54D2NeCLS/LPRuMGWoDZVVyQsNNuwy4ZxNi7HYJvBHoPUUOWC9O+o71Ndk07v4+a27nGb4C6mZ8Gkrakj0ApfBzucMmOszFBwVJxy+B1nn8heIxPnTPszPLihsadYPQAY6k6js3Rk7xIykTiy3ceA4uaBMZ4PSSieOHCnF6xh/LsyOn3a333KMQk8Kdv329Jt2XzmqucFQqckUy+vSKpgOm7IGbJyPl4AVfnLRh9aESmflf6/EC8Ml2lJSXV83klZouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/rIC+zQds4ewabz2akcWDRjH1ToYM8seKGeEKcleB4=;
 b=huwoJYOc1dTog6bQhbFQUfxWi1J1gLjVZVyEpSzltnYpqEfqnBJe5FCLTU1SO0d4qn70EtiNbNN6rhmvIRW+ok0Xoj4xyUHXveBCnrPyuAVOThxN73mwq+NqIZ/owJeYQhqLsWg0pV4zGlaOr4Q/oVJYSHLfI/igJiKbb64vNlnrauMdquWVHIaR0ETjRY2jvKkd+LMi92DNQVfs1BxIyiAlGWyg3fdkFzRCMhjHHvXfPnAyFWlLTa41Ec4vF6Ry4pxX4w/lX4Ebwp4EhlfWn5qWdzfQmkzwJVCP7Qz2xWnB5bowU0mqEEmAxnkWf4BhGQ/GT7GHXxE3j5+bmB3JEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/rIC+zQds4ewabz2akcWDRjH1ToYM8seKGeEKcleB4=;
 b=C5BYV1CTKC4NMEgX0BSw8SeWaVqBQCU7G4/lQNZs12wqyOJqTkVRGbS4S/2EzqlYuDBju4kqR4+hrFQG42yiWGXxknpJORvsZvye3vxFsQ6kT2M2r8RRESlLW8VnIuEqNRLzAsRLsxjhD2JDhMMWSrTqdslLyRONfJQ5eplAiQE=
Received: from CH2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:610:60::19)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 07:38:30 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::14) by CH2PR14CA0009.outlook.office365.com
 (2603:10b6:610:60::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 07:38:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:38:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 00:38:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 00:38:22 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 00:38:16 -0700
Message-ID: <a0d1ab59-1f2b-4410-9396-3fddf4865bac@amd.com>
Date: Thu, 30 Oct 2025 13:08:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 4/9] sched: Add assert_balance_callbacks_empty helper
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
	<zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
	<will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
	<Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Suleiman
 Souhlal" <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, hupu
	<hupu.gm@gmail.com>, <kernel-team@android.com>
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-5-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-5-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d05996-cc3d-49d6-bc97-08de17875268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q29kU0wxNUttUUNvbmY5L01mZmpjaEE4VitPR3dHY0tDb1VrSm9qNnU4RTJj?=
 =?utf-8?B?K0E0dkFaTVB4K0VYLzluVXBLN3huNngxNHBtRWNUby9ROWZjTzhWOENrQkV6?=
 =?utf-8?B?alU4c0hwa0pNZDVhN3ovVkJqWnd4WTdVOXFyL2FMTlVvWllkeGRsWUJVSHJJ?=
 =?utf-8?B?cTlha2I3NHl6S1lTcFRaYmtsRERDOE1tOVNtVU5hQlFGRGFhdjB1MGIrWVdC?=
 =?utf-8?B?UmpKWWx5eEptOXNyVXlsaUgvREdBQitlQXpxRkYzWk5IQW5xS2NPaUVjV1Fh?=
 =?utf-8?B?WGpXbGU2N2RUWmQ5SjdYYWRQRkFjRlZrTHZzZjFCc1l3N2JoeHN6RTNKa1Er?=
 =?utf-8?B?dzdFOVlpeVhoeTFsVTVWd0JBaEZlWXZLL2xIaWYwLzMvWThLdGhrb1NDOUNX?=
 =?utf-8?B?NFI1WkNLTTJFVzR6MlFmdlh6YTU3bDJ6K3B6QUhCcitqNEdWTFg5eWE5cyth?=
 =?utf-8?B?cWU0RjkvM0R3VDBYa05nemRQK2tyZ1hZM1ZZTWxCYlhwTDBqbzA5ck1mek1j?=
 =?utf-8?B?VEJ6MUpiMFJSMTVYcWhnMW56cjNsTWxhTDdZVGlmdmFqaW8zbTdmbEMwS1NO?=
 =?utf-8?B?VVpIZzFYNWpkTHR2UUtzb1RxUE1RQzMyazBjOGtyTkk3Zm15OEVOTzVVaUEz?=
 =?utf-8?B?Q1VUR2FkU3cyZTBDZGwxZUVIN2xPMU9CbVltNVV6MlF5cEsvSVBCajJnTHZY?=
 =?utf-8?B?UXQyaTdjSk9wdlh3RnF3MXAwelJXTDRBUHFYRllEVTNLNmRUUVNVbHFONE5n?=
 =?utf-8?B?cTdVNjk3UEI5MGp1ZkZ1bERCSUkwdjBVdlYrcWorR2dPRXhkQjF6UzI4NDVh?=
 =?utf-8?B?UHpiYjZtblB2Zk5XMDBpYmpkcVJIcHhCejBkWXFLNDU1M3p4TStFQ0xIY3ZD?=
 =?utf-8?B?ZHZaTytIemUwYmVnV2JoRnJVeWwwbDhWSXArdDhIQlNVbDZJcHNGYXZUdzdJ?=
 =?utf-8?B?UWh4NGRMS2V0dmlHQ3k4anFiNTlDcWxnTnVreWxoNzl2TjhCOHhHNWZKSDBk?=
 =?utf-8?B?ajJXTkhTd0t2Umo5WjR1WWs4Z0JZdTVtblJPQ0xHL1JLZ29aREFmUmwxQnI0?=
 =?utf-8?B?N2NJSVJXTEhCcEF1L0ViSzBQNlF2b0Q5eElwRllDRit0Ukx5cktqWUJLWEFi?=
 =?utf-8?B?M3VHQ1FhR1lPaGZrdnpCK0RXOUVVQUxIWHJlRTZTRmhlaEZZYlBtZEZhalFh?=
 =?utf-8?B?b1R0aHZNTklNNHdPSVZTalFja2lNb2xBVFVGRmZTR0Nxa3RHak1CQWlFNmU5?=
 =?utf-8?B?WTFwUnhjeEFrSHozQ3BmMHRpK0I5WUVHQzUwdWk2R1VJRDN0L0FPaDBaL2FB?=
 =?utf-8?B?Q2lBT0oxMkI0UG4wUk9EUzNxdjV2eWdlYlVQRnlRekVvOStKVWV2eVBwWVdx?=
 =?utf-8?B?a3ArSTJpS0RMYkpnWitYYkVwOUNrdDE0cnNHSTk3d1hLaWRRVU00UzBOOU5P?=
 =?utf-8?B?YTF6NU5ESDZURSs0eDViWHQ5OFNhZ2RYRnNXUXZST2Z3dDBRV3RTekNJTXM1?=
 =?utf-8?B?SWtxYi9EZmdKbWJYQWdIczNuYk5OWnc0VEd6cTIwZktvdDJnSVZKYVVzNFc5?=
 =?utf-8?B?NU1HTTVoQXp2N3FEQmFmQzUzOHBuamNMTSt0bFRBeVY5S1VCTWRwNml2Nk5F?=
 =?utf-8?B?TnJqS0dmNllKOHgxQWZob3kraUs5V3hmc21YdkFBSXFaRExWMGFOYS9Gd3Jz?=
 =?utf-8?B?K0lsUExla243eWt3RUZUR0pqVWl4aTNua2QwRFZUeXF4UGhmMUp4bFNkMVNT?=
 =?utf-8?B?NlVZbDZxM3lQbmJPYi9IU2hJbWdxZjdXODBrWENXOGt0cWpVYlYzU3dvZDc3?=
 =?utf-8?B?MnIvYU1jbys1c2diSUVBZ2pwRi9OUTBwSWwzdlRaSjFuK0hQQ2JJSEk1c1pr?=
 =?utf-8?B?Y3dKbDVMRFJGWUxjY25YMGdCOE5kejU0cDVRbVltOVk4bWVFZE81UmRtK1gz?=
 =?utf-8?B?OEVQbncwNDZsbHpCQlRDSGlEdEE2MnllWDdDTDMrM1l6TzdTY25oYjhFYWlZ?=
 =?utf-8?B?ZFZmNHNlUUpYMXFxNnZRQmQraTd2TDJhYXY2YmRKbHNVSGdjTGVyVGlZUkJI?=
 =?utf-8?B?a3NnY0N1SzA3alUyaFlaelQ1OU1ISzMreDBpSDZkR09OU2ZZOU1uQlVUbGl6?=
 =?utf-8?Q?Si0w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:38:30.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d05996-cc3d-49d6-bc97-08de17875268
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> +#ifdef CONFIG_PROVE_LOCKING
> +static inline void assert_balance_callbacks_empty(struct rq *rq)
> +{
> +	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);

Can we instead use "IS_ENABLED(CONFIG_PROVE_LOCKING) && ..." and avoid
the empty stub?

I see similar pattern used inside WARN_ON_ONCE() by RCU and
context-tracking bits so I'm assuming compiler is smart enough to
optimize it out when the config is disabled :)

Apart from that nit, feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> +}
> +#else
> +static inline void assert_balance_callbacks_empty(struct rq *rq) {}
> +#endif
> +

-- 
Thanks and Regards,
Prateek


