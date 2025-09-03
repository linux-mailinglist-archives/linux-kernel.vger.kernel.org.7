Return-Path: <linux-kernel+bounces-799146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221E7B427A9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A441B24C25
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16731A57A;
	Wed,  3 Sep 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lxIAXV4V"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449862C08CB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919541; cv=fail; b=j+mSYUt449NWERFUxljCXmoF3hCqPIhXgtL6LMyAw/99KWeDV0rOImmOZ0dMH8qxYSSIS+jInVPlInLVN5ILvCxbPH7VRJX10Fp37itXUPezXueVOZZtg7HTZk4BU3Zl52beTEKhY2AswyaGqzpVhGs3VW/E8oOMlD7cUjhdE+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919541; c=relaxed/simple;
	bh=HlBoyxZj78UMwRXBUWhm9a4HFmgjLOJ181WIBSUqC3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r0D9oVgPYSFloGSVCxh8+ta4wWRVTW+Mb++QkdiV2ALCqrmoLZZX6VPKwnOODPnVsHegGiXqs05rkRmmK1Fx82jOgDXayTTzeD2qCFAR9nZanZl5w01Bz3rjioJ8tLXq7+4hLIplA+LRMUlEKgE1gwdKWMgDMB6BUUOS/vfGZJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lxIAXV4V; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eu4t/JgdP6JZNywNXr3rYxRb4mp9bj/5fjXJ2Jk2YS5WMKtziqIpUa2Z+XkD8Du1kzQADxyFEGDW/aAed1gND1sYsuYCjwjvmrZBHHADXF7x4Y/0aT2MS7NYE2MMEkiNnEjaVgUHUJVSfi+b50/69HcZF2m5zBzuMlOPLfUa1Kb5TXlmvrTRo8xypu0WSJMM3PNBcCk2xvsdiFfWIzuNYjwtarzKfyNDgIGUBoDAso9i9OSa9WaxL1iDNi19SebMjrH6kIrszNKQRQJGvIJg6MwhoOLaiRWKPPEJCEBaxWOrDaaSC0P3Rr7EjMn6RbqQEHdyf+mQSUGzn46dzVGtRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vX9XIwceD31yBzYSEGdm/FCBfjJ/4PPcH0md4z1TedY=;
 b=eTvXyFML0SZvRba2HPBBf5Ez7AmbTdOo6J6AmZwr4HJDMwhiQkdNwHigNwxPFsL6KU7r7pIW3eSE4Q3qyvvMsN9/QZRc2L64FwXya631f+NJ8T9HXSlE8faOmGKQyemzjujZOU/1T7Ccpvah5YQJIE/AFeizJ8MbCsfp/H4FY7M8eAOL9Qh5q9xtU7dkUuHeEHyEq692gwRX5iwhrz+fpvmetGnibDCJUVKdAO4YOJ8FiVmvW+v3X5KOl6Kc7FMRoWX9DHM6tgUntMjntXoEfLspUkEFTz/9KqtI6EPgAMs9AtSTZEak5cKKFwdVhwHBPUxbrO3JJjmBd5KrZi3juQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vX9XIwceD31yBzYSEGdm/FCBfjJ/4PPcH0md4z1TedY=;
 b=lxIAXV4VUI2xkhRHsND0gmgAdb3IkKVhGoyjCaku44ZA1Oo230/4qfkS0zwQ19OzEcWAIVGhO6vgQ4tyNbqNiO4BvjF8VSevsYji88k0dezvHc73eBv+YKNwv3OHYQoeM+eBMxyflPpSiCRbyaTK+hSk5+VHs0jRdsyzxzWG1js=
Received: from BN9PR03CA0406.namprd03.prod.outlook.com (2603:10b6:408:111::21)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 17:12:09 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::89) by BN9PR03CA0406.outlook.office365.com
 (2603:10b6:408:111::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 17:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 17:12:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 12:12:08 -0500
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Sep 2025 12:12:02 -0500
Message-ID: <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
Date: Wed, 3 Sep 2025 22:42:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
To: Peter Zijlstra <peterz@infradead.org>, Aaron Lu <ziqianlu@bytedance.com>
CC: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>, Chen Yu <yu.c.chen@intel.com>, Matteo Martelli
	<matteo.martelli@codethink.co.uk>, Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|BL1PR12MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: b70b65b1-110d-4373-0233-08ddeb0d0462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2E0N2xJNGlJa0tIRmt6WHZuQTFpN2syQVdRaWE0WXBUUkJQZW8vM0NYTlQz?=
 =?utf-8?B?WWxxRXZqYjNmQ0hyalFDZDVjUllMdExxZDZwdzFOSWZ2dGFYb285dDdDS00w?=
 =?utf-8?B?eWtxczFZQ21zTndkbTdzL0pkQUpqeGoxL2xyZkRCdHpqQkM4NzFyK05wMlJE?=
 =?utf-8?B?K2xTYkU5N3B4ZUZTdzhxMFMzRDBZSWJTZTJ6Tm1hY0gwVXVQZDNIL2ZwSS8w?=
 =?utf-8?B?R1pUVFlWeHdVMDQ2M1dCQUhibDRNbThtNktXR0hLZDZ4b0JFSDJGS1AxRHYr?=
 =?utf-8?B?NXYybDkvN3hsc3hOSTlWcDVWdFVaNnFqTGtMRCtxS1czUXBZNVJUUEp3cVZy?=
 =?utf-8?B?RjlNZEdtR1Z2djZUeTFWMllOaWtRdkVyandQVXpaNHh1MDJDVmh3N1dPYXZH?=
 =?utf-8?B?YWJRSUdxTC9hVUt2ZlRwL2lQK202aVV5Rkk3WksyWElIMlhlMTIvMzVrRW1v?=
 =?utf-8?B?blJZQ1pocnpwUTdkcHpRdWEwNWxXY0RxNUI0enZhMXBWZHlnbTF0anJwa3JN?=
 =?utf-8?B?TkpQQnlrQ2FxS2pZMHZMbUdyWWlVYzlHRXVjNHhGdkxRZmZvanFxL0V0cVVS?=
 =?utf-8?B?Z3FJL0ltU09Rd21mT1Aybk8xOTZVK2V2cUE5WU9XbUVDSWZoUGRCeUpWV0My?=
 =?utf-8?B?SnRNdkwvZU9qeGRZOWEyU0VlaFVqTUJkNlFTWDEwZ2NpY2xTMzdGb01ocTNR?=
 =?utf-8?B?bTN0WTlTbzZtaWd6WEtZc2RqaFFWTGw1T1FzSnhlb0twVzdWaHNzZFB6Y0tW?=
 =?utf-8?B?WmdMTlowdHArU3BsMlJZNnEwOVpDL1N5YTRadXB2ZW53SzlpL3krUmxrOWVO?=
 =?utf-8?B?OTVxRWlRNTJYL2ZzV1c3TWhiTXQwN1dPN1JDSjlkMFZMQk91TFByMEtwVU03?=
 =?utf-8?B?N2l5UkFkZHgrR2VxdUVSR1N5OVg1VkljWUxERmZSNkpGV1J4cnB4RHJuM3N4?=
 =?utf-8?B?eHQ1REJVVjhXUlM0Q0EzUi8rT1cyK0RjSFVBQTB3WUVwKzBZYktpbEFmSkpi?=
 =?utf-8?B?eXI2VTZBUkNGM1c5U3ozRS9RelB5R1lkbitITmZycTJHVFRYWmpDamE4enI2?=
 =?utf-8?B?UXZjdjNBeVRVeXA3azg4OXdlZDhUVXFxOExXT2F5M1lpOEo1RFF3Q0xZZWRu?=
 =?utf-8?B?L0tQOG5jTzFLclpWdUhHeE1tY3FEWjg1a29ob2QvZW5aVFVwNE1FUGtoNllT?=
 =?utf-8?B?WGpPV2hBVVdhelI2YUc1S1J6cUJKcnhzcE15NjE0Zzd1SzkxblJHcExCRTZp?=
 =?utf-8?B?MVFpaTFRODBQMCtoWFloUkprNU9zL1liSE5FV2toSG9SZjdWQytJck1qdEx1?=
 =?utf-8?B?ZEpNMWFkMGF1M0g3dW8rT3M0UHJ5VWtxTGRIOElrNVN2VlBiUms3Um9zQ2U3?=
 =?utf-8?B?UVVkS3gyaERnc3p5b0NabVpMRytiUVozRmNkZWlaQ3pLRjNnK0J0ZzRLUVI3?=
 =?utf-8?B?dkFNWStJdHAzS2pLWUFXYThwdlNQWjRlYWxVSE9ZYXBORnFSc0Y5NjdGbHFC?=
 =?utf-8?B?WVBHSnhjay9aSFI0dzdaVUIxSnZzUWxpNHhNMENha1ZmaEhSblZ3ajZLOGJK?=
 =?utf-8?B?L2NiRjRzb1VPMkVRT3VUTTF2K2lyQzJmbHVFV0RhcWcxQzVrMTI4OVdScStL?=
 =?utf-8?B?dnVCaWUrUnRkc3FVZjlmTGl4R3NJSXIvcnI0KzlpS1ZmUVQrdkNtVzlsMnBS?=
 =?utf-8?B?dUdCcXcwNWYxYU16WXlTd2FCelB6bi8zUTJSNmZLNGNyZCtmNVJqMGpQUzdK?=
 =?utf-8?B?MWRJWW5TR05rcmlwRkNSNFY0WUdrR215b0RSTWtLUjRYelEvdEZqRjFNY05D?=
 =?utf-8?B?VVFnVEQ0TUxUc1MvYnRvamorTzJvbjZDeHlmWXpXbjBJRjRBT1R2M0VKNjha?=
 =?utf-8?B?ck1yT01Fd2F5QWpSd3IyOCtXSStXTmJqRkFSTzZYMVB5K0lLQXV5TXVLaUxU?=
 =?utf-8?B?TjUrZnlmaFB2UGJwWk9iMEtUeC9vbHNYM3B0czhyUU1tODFVditKT1dVVVN1?=
 =?utf-8?B?aVNBdXNydm1JM1pybVZ6MjRvaVJmY0ZGbVdlckdRNk9sMXdiKzBjVXFIb1NZ?=
 =?utf-8?Q?lbAwh6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 17:12:09.6669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70b65b1-110d-4373-0233-08ddeb0d0462
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947

Hello Peter,

On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  {
>> +	if (task_is_throttled(p)) {
>> +		dequeue_throttled_task(p, flags);
>> +		return true;
>> +	}
>> +
>>  	if (!p->se.sched_delayed)
>>  		util_est_dequeue(&rq->cfs, p);
>>  
> 
> OK, so this makes it so that either a task is fully enqueued (all
> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
> its tasks are gone, and unthrottled when a task gets added. Right?

cfs_rq (and the hierarchy below) is marked throttled when the quota
has elapsed. Tasks on the throttled hierarchies will dequeue
themselves completely via task work added during pick. When the last
task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
that cfs_rq.

When a new task is added on the hierarchy, the PELT is unfrozen and
the task becomes runnable. The cfs_rq and the hierarchy is still
marked throttled.

Unthrottling of hierarchy is only done at distribution.

> 
> But propagate_entity_cfs_rq() is still doing the old thing, and has a
> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
> iteration.
> 
> This seems somewhat inconsistent; or am I missing something ? 

Probably an oversight. But before that, what was the reason to have
stopped this propagation at throttled_cfs_rq() before the changes?

Looking at commit 09a43ace1f98 ("sched/fair: Propagate load during
synchronous attach/detach") was it because the update_load_avg() from
enqueue_entity() loop previously in unthrottle_cfs_rq() would have
propagated the PELT to root on unthrottle?

If that was the intention, perhaps something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e..4b32785231bf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5234,6 +5234,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq);
 
 static void
 requeue_delayed_entity(struct sched_entity *se);
@@ -5729,6 +5730,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6727,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -13151,7 +13162,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
+	if (cfs_rq_pelt_clock_throttled(cfs_rq))
 		return;
 
 	if (!throttled_hierarchy(cfs_rq))
@@ -13165,7 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
+		if (cfs_rq_pelt_clock_throttled(cfs_rq))
 			break;
 
 		if (!throttled_hierarchy(cfs_rq))
---

The PELT will then be propagated to root either via the
update_load_avg() call when PELT unfreezes or through the
__update_blocked_fair() path after unthrottle. Thoughts?

-- 
Thanks and Regards,
Prateek


