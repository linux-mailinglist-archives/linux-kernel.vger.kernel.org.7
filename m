Return-Path: <linux-kernel+bounces-831578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A34B9D0EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A897AB149
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0B2DE71D;
	Thu, 25 Sep 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFI9x+Fe"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632023ED5B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758764941; cv=fail; b=fdkIU0SXdZZTx6Pe837ygpJ8XgNmR5XTcABkARERmx8Gu6EfrYNcUNs/oHn9pgxxfFYWeVPX/QDmCpA/34B1o5dJhSwvsz73vyzVg41oEcB23sAEggg4Ep/ma7zwJ35gArmMtfr+3cLNJFvMfyTZ07M0FsBhcbekr3L3PeOnpbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758764941; c=relaxed/simple;
	bh=rNwgJ7XkOeXOhIa3zW1AVk9zJ21hJOY6DA4vtLcDd1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qHqbAaQIeArgS55y9oUKVFzBK0P0njFEG11oQzIR5fkMBK2DI0rWP35kjwv8svg1f69zlTVeXpANtEQzCyueG3Tvf3rwLi/HrMrWZ09ob5oxw9NFAqwWq6UmuPuo1vDB5Dhx2RzbVTfh/Sp2AjU5VWRcoBKqnDlpqSjMZ7kxJUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFI9x+Fe; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7UGZdOmI85AvkxzGyDueSGeEL62HKppKAOJ/jyjQrNszuzywZojdLEFu0oazxgIWSToSoY67N0T1L0HTrsUKSxD2EbGoV0llRfsW1ZyyMnlhzRf5STIL6Pt++zhDmOiXwbxO4R51VecdwqQm3Rw27nUQs4vOYrd7y8ai+ytZLlZ0H1M6UtH3/W//Efph9rrDF3n0oMXMtUUFQh9EevaD5e6qwVNGGsUnl+YZF8B/sNNrxjYxQQlwiNyc6Mg6o85o8kkPDKxsDZ8LmGthoVCvP8UBh9x8Xk9lS0tktOV54xnZd2DemL1Yt7ZLiksMVU/bn1mgNq+AHGFR/VQvvFarw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X63Y1Q5vcJFBRHZThwgCieWP1u+vXS/cohyf8EdGqpQ=;
 b=pFSWHrxPE3tKQcv2tX+4R0M7uEtjTRcxWlB7y1gMenT4dThq728yVSSnfUrsucgHq2rJclAfiJWfxsITbw3HhDb5CG+MIM5r5UYwaZv22MwJmjhRH2qzzTbBrgBfsUNbEzShNTn3JEXzkyIvDr7KpYKbhfT0T7SJZjvkoKvkO2xvIKN8AYJIIIaiVhKGRrLiDBwDU/ExfMfNC9tLls4R6UzZGLZgZZxGw2aIcJ3iS0EEc9k6FoB6Dmo51FyEr3Hx1bNbt+Lu5BAwZWyE6VNXlkEHprVZVpAOMffcALCLpc+JkTGQPhC6ofyivFU+VV/ZLMHZ3xujF4rW17kr73pqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X63Y1Q5vcJFBRHZThwgCieWP1u+vXS/cohyf8EdGqpQ=;
 b=ZFI9x+FeR57Ciu8YtJBk6iBkt5UIbpt6TWTDVgjrNHBB1XfBJKWXZOpdaFtNJGTd+fbK/He8iQDi6lA1RQDmuqzA7vCLaaWvkNJXZLUSdAbeNZA4hGFzzYaa7+qAKrlxAHmq5IV3PLX/UeoiNGFdB7Pbd4YEBjAhEncmgHM93yM=
Received: from MN2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:208:1b4::43)
 by MN6PR12MB8470.namprd12.prod.outlook.com (2603:10b6:208:46d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 01:48:55 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:1b4:cafe::cb) by MN2PR15CA0030.outlook.office365.com
 (2603:10b6:208:1b4::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 01:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 01:48:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 18:48:54 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Sep
 2025 18:48:54 -0700
Received: from [10.136.45.215] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Sep 2025 18:48:49 -0700
Message-ID: <7f8db11e-35f5-430d-93a7-35c0e9ec8dc7@amd.com>
Date: Thu, 25 Sep 2025 07:18:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/19] sched/fair: Use rq->nohz_tick_stopped in
 update_nohz_stats()
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
	<frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-4-kprateek.nayak@amd.com>
 <409bde01-720b-4602-bde9-a04262ea2c73@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <409bde01-720b-4602-bde9-a04262ea2c73@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MN6PR12MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: e10c8f89-8ae6-4bd1-f6b8-08ddfbd5afc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1lDV2xCb0w0THA2N3o5NllkRXZGTHh0SFhuMm95dnhMVnlIbmliT0JZMlZh?=
 =?utf-8?B?QXRDaGhyMXRNWXBHV2ljRmFKWWhpbmdRUTk0U0ZidXBwbHVrVkVtYTBPbGxM?=
 =?utf-8?B?VjVPUzNEN0ZxQXlkSW13OWVQQmsrKzA2d3F5N3RNT3RiUGgvbUZkUGY5OXlY?=
 =?utf-8?B?UmtzZ29GVHE3RmltK3JwZElCNzlVOXFKTm1SRTdZTVhacEZaVXRlcVppeFcv?=
 =?utf-8?B?c1FRZDFwemJGaVJXVWJQM3laQkJOL00zTmVPeVYyQnBOOVRRVWlDUkMrN3pz?=
 =?utf-8?B?VFd5U2lEU29wRy9YeWhESmtVNkJDQVZ4M0ZVNW1ibmZtS250VGI3V0ozdU14?=
 =?utf-8?B?VUk4TXpuY3pKM3FLa2RIZy9CWWNBYkRvMjhFYWE2eVJSaXhkY0pTRWY3aCtH?=
 =?utf-8?B?ZzVjcXdSaTFYVlpHUzFrUXN3V0ROMWV3c1BqQW5ray82dmNmSzBzS2Rkcmxu?=
 =?utf-8?B?VXhtYmk3T1BMVExqcVlnWDdqK1ZFZUlXS2plbmR1bW1sK0FpYS9odE4yVldX?=
 =?utf-8?B?bStoVkpaaURsOFErd1BCdVVYNVc5cXdIcW50cERlNXhKaFVyRVA0Tlg4WVZI?=
 =?utf-8?B?UVIxODFYYldOSmFtdjFsYTY1cVczeEFQNWVFeWk0TDNSQjBJYzVyM0NmN0V2?=
 =?utf-8?B?blM3U3J3NlpxbmFGbDlpYm04RHliUmpCZHA2SUNVdmRaZlpIcGRmWW5aZG50?=
 =?utf-8?B?OHFSYWhmbHpERG9lb0s0aFRnMGhCaUo3VmlScVlJSzdlSnJ0TUVoNGJjWHI5?=
 =?utf-8?B?bnM3bUkyTURoWHBFTklMQjBWbzQrZlFjbFFlVXozK1RQVktHUkMwL1p0YTg4?=
 =?utf-8?B?SHM4K2d5ZWZtYlFuZlNsMVNuRzZpWmV2c0w0VFkyY210U1lsOS8wN2treFNk?=
 =?utf-8?B?VG9ENTNYOFdwcjQ4RXYwUHJuS2I2dFRLWU1SUndRK3VncUtYZGJIbHNpUCtB?=
 =?utf-8?B?NHpyUUxYSzN1NlpFY0VCVDdYQ2w1Y1lvNnQ0dmUrWlF6QjRBWTljOFQyejBw?=
 =?utf-8?B?Y1VwT3IzV0hUQVVRRlFHNFZ5R2J1WlV2L2J0UVVaOXd0OXhhOEpXbnRqUEph?=
 =?utf-8?B?WVZERTVYd05YanNTK0xaWTVmc1dZQ2xKYUF1c1pvVXJaemdlWG1Eei9oVllW?=
 =?utf-8?B?UHJxN0FpbWpFOGN5Y2FuVnBIOGdiWXlwQjFvdnVVa3lrVHNJcTJDa0J5U2Na?=
 =?utf-8?B?bzM4RTNaM2MvSk1GZVJqUk42N25peTAzTm1NcGtRbzA4TURKK09WR3FWKy9S?=
 =?utf-8?B?RmNzQmI1K3lKb3JFb0tuMkE4SVRCanZiTEpvLzRkSXEyMEljNUUxOXpaYjJN?=
 =?utf-8?B?WnpzQUhJVjhJUHpsMGY2WlNKYUM2TGpOZG5IVnc2MzdzRzI0bDJHQlhlRHlk?=
 =?utf-8?B?UzdGVy9vS1ZFQkRLQmNHRjNUaWZNK2pBS0hDK1RYSVNnVHRvbklEb0p0ditq?=
 =?utf-8?B?YlErVFptRXY1cUlTSVh2NzBDTzJhd2RtbjQvSC9zSWxENTFaWU43VHFsZzBZ?=
 =?utf-8?B?VVB2QkVZWFJ6eVZUSCtBKytRa0JNdWVvNi93TjJielFwYzdwR29MN2Fnb0Mr?=
 =?utf-8?B?ZThUSWd2M24rSWx4K3ZvbFYwZnhPa0dTeXZ5K3hITkpLSHcrYVJ0K0V2ckxG?=
 =?utf-8?B?WW9aOU5Mc2NsY21FeksvL2E5Z2VVRHFEMHR3RmtUUTZydUFBUG94cjJhQVho?=
 =?utf-8?B?dzFoM0I2eUxxdTdnT1lNYlBTWkJ0bmJvZ0FsNEdQdXpHeFQrYmZyeE1LZHBQ?=
 =?utf-8?B?eGxQRGxzdzJHUTZCUTJJLzArVjFDaElPMm5OQWlIRDR1cEpSalNQNGZLR3pS?=
 =?utf-8?B?SjZHRit5ZTRwVUhOdXhXN3FEZzZKZG56REZpNU9KdGhoOEVXb0RUb0lxR2hI?=
 =?utf-8?B?QzVwbDhJZTZxM2xFNVY3TitmclZ3UTRzbkovdHFWSzZmTTlVeWo2blAyZDBj?=
 =?utf-8?B?MTM3NzBZZU81THlmUDRySDdQVm5vTGlWT2tPTlJwU2tWSjVBQUFIeDlUYWVj?=
 =?utf-8?B?bFRYU0tkQXg5QVBTTFFpa0FSOVU1dXRwMG40dUR0VGJ4YlFYd0FVVHhHbEtx?=
 =?utf-8?Q?TyQtEz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 01:48:55.1323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e10c8f89-8ae6-4bd1-f6b8-08ddfbd5afc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8470

Hello Shrikanth,

On 9/25/2025 1:47 AM, Shrikanth Hegde wrote:
> 
> 
> On 9/4/25 9:44 AM, K Prateek Nayak wrote:
>> "rq->nohz_tick_stopped" always follows the state of CPU on
>> "nohz.idle_cpus_mask". Use the local rq indicator instead of checking
>> for the CPU on the "idle_cpus_mask".
>>
>> Use READ_ONCE() and WRITE_ONCE() for "rq->nohz_tick_stopped" to ensure
>> update_nohz_stats() always sees the latest value.
>>
> 
> Is this ever called by remote CPU? If not, is READ/WRITE ONCE is necessary?

Patch 6 looks at "rq->nohz_tick_stopped" to correct the idle mask in the
sched domain rebuild path which is done from a remote CPU.

-- 
Thanks and Regards,
Prateek


