Return-Path: <linux-kernel+bounces-892362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B4EC44ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CA13B00CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D020E704;
	Mon, 10 Nov 2025 04:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="InQWitEP"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013032.outbound.protection.outlook.com [40.93.196.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62319ABC6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750089; cv=fail; b=H2p2sBPrZ9IyWuuvTmsGQp5iGwxpDakOUQxH8sDsqB+FDxCpF/82UKsbu+DglH4NPxrdWzSmaF54z7T2xtdHMh6JNhBzG2m8wBs12UBsUFPDF67M50cksOpM2DqAtCg11CdiU3MgCe5JEE4IBNr0p18vU0AywmJ6vuON1IVhNho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750089; c=relaxed/simple;
	bh=6UfV1BiPoBY4g2ADXiVxvNwIjeEoInPz2d9FUGtSPd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i21qIIOVr2Mj/O8bPBkZLhytbGRzpZFlqK2x5UUNCiSIAIDDo3cEXMH/UacW9D5gAdufT4m2RAS+cSoW/hOyelbNEwsHl3O8Bi7qsmxGF6Eb7QpY9M++3yR6o2/TolvId3twVhABQLkoDVjnMIMPsw4BgA1Ok/C6VuIN/hwaYlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=InQWitEP; arc=fail smtp.client-ip=40.93.196.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apreeuSrT65mIt0v0UElzuzB3Hz5pgAHnPGbTpOVfmihmWgX9lLCcbXOMpyaifaRNkGXyn9Ngkp5NIVlyEkdACGkY2vzvGrS+lnfKUOvUxCQcV6l3jllvTzz20tqtKhbRa/ypMlUh67xkdQxXSDnO0O+Kab3kFhR4WvwiwrkivQvKk8lS8DZshW8K57vNo/1Db5Wg6u6ocXcyaDBkyEZUsgv/65uN/xoLBuJKeOTIacnup0DxhxvarslxyYCF/gJDMX9PU/54b1xW8yFGL9lm46IjQUBXkRzJr8sji2pPkMOi/WkUW75YgwcwLVEreIH3EaMtgEAi1dYG8JtsPgAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFJDhRY1N7HFBql8tV4IQAlVg+pj+djikouLufEP+gI=;
 b=tHuui2yGg9vY4POGoUrM3oLiNb6XXIH4jUVBvQbrMXSvjw252ICqYkOA8oleAsYS4A3sorUQNibbnBlaHm6lr5Erwoy5FXAqAvsEK3SmnEn+BXJdOe8HqvwzcFoahuhUBsWUPhZffOlNTTCTsowPVCwcQd/mx9N/mELFIndVs58GqHKxfPBmu4R1NtFlSClFPg1dhn0GVM1YL9x9985MUEoBgkZc1Xp+L9OBPamj/k2Ok8Mpl1846MOhesZt+xa8a62mP9Svod/AqhaV46n98D4pJkBMlBPhgsE2laPP6KYtu9VKT0KUSpWJz8VzASENSqDYMHlEDxH9cZu64Ku1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFJDhRY1N7HFBql8tV4IQAlVg+pj+djikouLufEP+gI=;
 b=InQWitEPM9DvyLxqq0FPoCL8IXJiSi1SsqcgPvdfPDIWxhNJoUFJtyEsbk5qsOWj8ASOcbuls3oNma/KF3vw8CfV5fx2aCBniyad6QwuMwn+uLB2VKNjWD8Cc2SrrjbQspj/GjWqWL98b1o//dOu9f5L9R0wvHaSAikuN2vDffY=
Received: from SA9PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:21::25)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 04:47:59 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::7a) by SA9PR13CA0020.outlook.office365.com
 (2603:10b6:806:21::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.14 via Frontend Transport; Mon,
 10 Nov 2025 04:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 04:47:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Sun, 9 Nov
 2025 20:47:58 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 9 Nov
 2025 22:47:58 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 9 Nov 2025 20:47:51 -0800
Message-ID: <b75d5eab-3211-43d4-8534-987707559710@amd.com>
Date: Mon, 10 Nov 2025 10:17:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 6/9] sched: Handle blocked-waiter migration (and
 return migration)
To: John Stultz <jstultz@google.com>
CC: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
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
 <0c337bca-4ecf-4654-9256-df766573c7de@amd.com>
 <CANDhNCpOdnmC+dB+uwt82XrxFuzx72d+5w1j21eFovSeFr8pDw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCpOdnmC+dB+uwt82XrxFuzx72d+5w1j21eFovSeFr8pDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|BN3PR12MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: 6221a0ab-2e2f-481a-4dc5-08de20145295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzZTN3AzSUdyblIwWUJVaTltMURBTmZFNmYyS0dXVmgrbmZlaUFlWnRib1hj?=
 =?utf-8?B?MG82NDZMRGF6NTBFL3R1dFJRbmZycFJ2R25nbFd2UUYyZTVCby93MGRJb2o5?=
 =?utf-8?B?bGNUREU2ZmJ3Qml1a3VVODlBVCt5ZzAzeGhBQm5HT2xQV1VpYmd6WUNvU3Z1?=
 =?utf-8?B?ZmJ3ZUtjLzJIZDMrdHp3dENmU0paU1JpVVllU3JNeWtyL2V0TFZ3Z29QSk5J?=
 =?utf-8?B?eGg3ZndrQWEvZG45bTZXdUZjTmFZTHMybDVtR3o0ZDZzWjJUaXBJSWhHV05j?=
 =?utf-8?B?c2dBd2d6ZVlqckRnZ2tadG1ZU09ZeUpQSnpjb0R1M0M1WUN4OGZPenMvQzNt?=
 =?utf-8?B?L2pSakJvKzNtaWgrUCtmM09XdXczOUxwcm5TVU1oVmUraklMWEcybWZzb0VR?=
 =?utf-8?B?QkhEbUl2NGc0elovSGM0am1UVzJKbXpuYWg1ZXNLejMxZnE5QlBqYnVQbzVZ?=
 =?utf-8?B?VDVFVk1JSGJYcnd6MFJObEZkNTRoS1l2TlRFd2E2ejM4SzZSaGtwNFg4amUw?=
 =?utf-8?B?Y3VpMFJWa25BTi9LRnVaeGZabHVXRFVhQllBYy8rRW1UaUZvd1M3RlNqd0ov?=
 =?utf-8?B?cG1MZVUzVHFJVnlZTXNXK0xycFFJUDAxNXFGNHRXY0RpYS8wb0xEekV2TWxH?=
 =?utf-8?B?WGF6YnUwZ0xoMjRIR2FiUnBlNXh5amtXbm16djNTTUthMDFOMkVBTlhhTG5u?=
 =?utf-8?B?NW5WdWszc01DVFlxMDhyQkFLTTNEN3QraXo1U2ZSZTcrN3FVUlE5dS9Fb2Ir?=
 =?utf-8?B?QmViVFNtdWpjMEZIWmlkWnRLUmthUGJaUlZpVU1TdlY1cVpRRVdIOEkzcHBa?=
 =?utf-8?B?ZUhRYWZMQXpPbDJhVEhEM0hsa3ZBOWdSakUxSWJ1b2VhSGp1WWVtS1NRNmhu?=
 =?utf-8?B?QVJjTng5OTQzMTc2aVBIZVFGQWtYZm8zVHpiemhTc1FLZFcwMEE2U1FWTkV6?=
 =?utf-8?B?Qi82OHNvTzZkL1ZZQ1FEcktBRElRd3phUTBQdmpSZmpzRVh0RXpoZ0JFM240?=
 =?utf-8?B?QXg1RnJWWUhnK09HRTN3V29tajdXYU5rU3FVRER5a2x4cVVBM05jbkVvbTdp?=
 =?utf-8?B?bmd1OU1uMmFpK2grRStUTFRjMWJ6dHRrQXNaZXBXbjg0bFFrbFpGMWc2ZnRX?=
 =?utf-8?B?RjdDSEd6QmxFUGlKNCt5WWNaSnRwUitoSEhmV1VqbVh0VFYxeFBzNG96VmMx?=
 =?utf-8?B?dEwvdlUzaUVUY0NrWDZBR0JUekRaOGRudXR1L1ZkSDhMcWE5Z1lwUTB5NEVn?=
 =?utf-8?B?Y0pXVnY2T1Z4MkJRYTI1QU5uKzNSYnNmMGhhTVk3SjZCVC9tVmVwRWg4aUl5?=
 =?utf-8?B?RzV3N3B3czMyUkhGbzRURjBWWitURzdScGxIVnlpTyt6c3lKUHFkckZFQjBk?=
 =?utf-8?B?MFhHYnErVUJoZjVYS0dTcXlFZ28zVGg2QytJM1lRZG82Q2hadXFvNUtnZGhy?=
 =?utf-8?B?dnU2SnVWdkdCWDYzdUtjeExuOEo3aGxlMk5vOC9vckpyMDI5SEo2MG94aWto?=
 =?utf-8?B?TzVDK1lBUm9YcDRLdnMwOE8zWm1tbll6ZmxFaHpJNFAwaWYyTFZsOTRKd2wy?=
 =?utf-8?B?Q1NtSzMwRUc2WTMvMmMvN3lTajdpTFA4UjM3UXp5WWYxZUl3Wm1aTDViRGlX?=
 =?utf-8?B?QU5SVEJRK1p4cnRVeW1tQjZNU2djSUNDRURUekMvYVlocnRRTGYzZkh0bkd1?=
 =?utf-8?B?czJQcXFWRmgwYnprbm0yTzNJWncrSTZxektnUFozcnJaM1VzSU1uZ1pGT0hY?=
 =?utf-8?B?T0FyTTNhK3czdS92Yk9ISUNRWGhvc0NIaUZZbFRxT3VhcFIyV0dJVUVWalRz?=
 =?utf-8?B?U2JESXcvalZMWjlxWmY4ZGJ6NHMvMThIczZMMGRxaGNZZmJDaVlLeEF6YnJo?=
 =?utf-8?B?QjNzeG52TldsVklYMzRrOTdLQWJHQ2lKSGp2QW40cUtkK1NLNGFwcldLNHFL?=
 =?utf-8?B?bFY0OEsyekgvaTk3OGxRWnlEQjFEdkpWTE5Pc1FNQVgzeUN0R0ptWFk3VHdY?=
 =?utf-8?B?MUNaMnpML1hPTEY2aDJHeVkvUHByUTZFVjI1T1Q0aGpCSjVuc0pYVEZ3cDFp?=
 =?utf-8?B?S3dMcHZqNzFudWFGZDhWK2FTajY3djFrcCs0QnZaZWJDZzZaNEQ2WXlQTVRr?=
 =?utf-8?Q?Mk8o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 04:47:58.9744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6221a0ab-2e2f-481a-4dc5-08de20145295
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593

Hello John,

On 11/8/2025 4:48 AM, John Stultz wrote:
>>> @@ -6689,26 +6834,41 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
>>>                       return NULL;
>>>               }
>>>
>>> +             if (task_current(rq, p))
>>> +                     curr_in_chain = true;
>>> +
>>>               owner = __mutex_owner(mutex);
>>>               if (!owner) {
>>>                       /*
>>> -                      * If there is no owner, clear blocked_on
>>> -                      * and return p so it can run and try to
>>> -                      * acquire the lock
>>> +                      * If there is no owner, either clear blocked_on
>>> +                      * and return p (if it is current and safe to
>>> +                      * just run on this rq), or return-migrate the task.
>>>                        */
>>> -                     __clear_task_blocked_on(p, mutex);
>>> -                     return p;
>>> +                     if (task_current(rq, p)) {
>>> +                             __clear_task_blocked_on(p, NULL);
>>> +                             return p;
>>> +                     }
>>> +                     action = NEEDS_RETURN;
>>> +                     break;
>>>               }
>>>
>>>               if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
>>
>> Should we handle task_on_rq_migrating() in the similar way?
>> Wait for the owner to finish migrating and look at the
>> task_cpu(owner) once it is reliable?
> 
> Hrm. I'm not quite sure I understand your suggestion here. Could you
> expand a bit here? Are you thinking we should deactivate the donor
> when the owner is migrating? What would then return the donor to the
> runqueue? Just rescheduling idle so that we drop the rq lock
> momentarily should be sufficient to make sure the owner can finish
> migration.

In find_proxy_task() we have:

  if (!READ_ONCE(owner->on_rq) || owner->se.sched_delayed) {
    /* Returns rq->idle or NULL */
  }

  /*
   * Owner can be task_on_rq_migrating() at this point
   * since it is in turn blocked on a lock owner on a
   * different CPU.
   */

  owner_cpu = task_cpu(owner); /* Prev CPU */
  if (owner_cpu != this_cpu) {
    ...
    action = MIGRATE;
    break;
  }


So in the end we can migrate to the previous CPU of the owner
and the previous CPU has to do a chain migration again. I'm
probably overthinking about a very unlikely scenario here :)

Unfortunately, I don't really have a great way to detect it
unless we have another member in the task_struct that follows
task_cpu() for most part and is set to the "owner_cpu" as
soon as we know we are going for the "MIGRATE" action when we
are still under the "wait_lock"/"blocked_on_lock".

-- 
Thanks and Regards,
Prateek


