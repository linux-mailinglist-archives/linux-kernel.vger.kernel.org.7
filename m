Return-Path: <linux-kernel+bounces-816372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1CB572F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59DF3A9DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6032EAD05;
	Mon, 15 Sep 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZG/wpcid"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000722E6106
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925158; cv=fail; b=Z+AM4BItAbH8ceUSudWtzEjd6d9V/C43EdgQiBSBanNYsIE9Kic8cvHLuDjeaRh+aiamUBEIT+3Sagtj3Ovj77uL6c0JeKVAgB5/KEIy6hvuzjxUeqfVfLZHieE0EY0h3KX6Zc9SsMSEPLOtfEVqNLRMlI880/hvMI4h3OZr5rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925158; c=relaxed/simple;
	bh=Tw6vhvN1yYgWYtU1/03CbtFSa2wGuNcMweW5y94up5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WwyLb3wlgbqSC7c3zsQT9rVo2dGHxAisWT6UdGR3kLFS4Ue+rpmsAmfQOvSEjhRCZeIX2CXs6YkS62YdkSyCDWtVjAHX3AQ51NoM8t7HIkpOR8ajwo6FMS5IiKSFOUzHu8JB5FUn2N6Be3PBus5lnA9Fj0agS77FAgICVzh1gKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZG/wpcid; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTDb6BhDPntDMVNzQaN0H46qQHHdCZw61Xx6DBiGh/d6mM3BY04Ay2ewtMrPfB3ikcFfKyJ3KNYtAReZzXxhc8dxl4H4BR+7//oJZUpdyCc8KPZ4aNeE844I+S5rNkTO1bAV5OCoqCH1lsNyTh4vTww7Mi1EPT/KHbk5mjcWfXuLBJX5TsJjyONcLu9RH+AxCpg7eM8bhPY4ewZxP1cQpMhOQWTdyaqJUVOCD2wsJ4pJCC6JpsHG6apU6O+fqf0Usu4JajDEHUUCU2z3rHNgRX5NV/xzuBGuTHoMoZMbaOVgfkQW/je9ADRCrruFdyKY6VZOgqeiNBW1gao1fqvfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc9nC+Rnbr33Cr5fL+zk9kDZDS5yc7eYVDbV3OG3xOY=;
 b=tpvdtVPId0TJGwW/eU5ffCF5gQNa16rUFwZrrfVpaDtnXoUzpy8IT4HvdOU4lyMPI34XwOmIHz8US71B0krOqw0zliDOrWDHbl2sc8RIX2MSBfy79gMCpkcmVuAeC79tw+W8CSXhWeWlbYrQi3hq8gcLnkNPkbBj9PiumR0jE3aFxXZKHJ0bhO6wgXH42R1/a7FFgiZtDK+NmQxkpwuRUwXLbD/07biqq7855eVotC8I98QqpIQetXUXka2Kp/38jnIkspIulGUwdglKaymNVPrR6dv3kbkKqV896LhXuoxScqPJvj+yRexXsu0usfoc0cJdL7PtyOL8oj2+uhDlHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9nC+Rnbr33Cr5fL+zk9kDZDS5yc7eYVDbV3OG3xOY=;
 b=ZG/wpcidsbVKxsTLikO+NqbQXHuwXR8o7VRFd4YiZ0DFMoWM4AksLnI1yG0Ik/Zgij20PUTrsafVMQaDxieSud/fvSGN/d16MKznBSEqqKXqljLkNeDvOean7z0+UWp7938w1Tr66s0OrIwa0ewLWommVbMzKAtK7gtrXnmrrVE=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 08:32:30 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::5e) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Mon,
 15 Sep 2025 08:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 08:32:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:31:22 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 01:31:22 -0700
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Sep 2025 01:31:15 -0700
Message-ID: <dfc571c7-6bd0-409d-ab94-33e8032270fa@amd.com>
Date: Mon, 15 Sep 2025 14:01:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 3/6] sched: Add logic to zap balance callbacks
 if we pick again
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
 <20250904002201.971268-4-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904002201.971268-4-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: bae87b8c-7174-4510-be48-08ddf432691d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1JWeU5sRmxRNjdZYVBCUVlHb2JsNGdYMVhkL2NGQ3NkL2hYSjZubUR2cU9y?=
 =?utf-8?B?QktrR2hSMndqcmE3WTJGNXh5S0VZeHN5MXMyamdRR2VCWE5iN2YzYnNhMmhU?=
 =?utf-8?B?d2Q4aXAxZVJudFJVTGIvZHNFRXZZcEdHVDltaWJKaEdOb3hVbGE4cVN4bVNk?=
 =?utf-8?B?ZDAvOGZRNlFQOFJPT3JuUjkxMmZCc2lMY3d0bXRKNVZyYXM0VWY3OVl3TmYx?=
 =?utf-8?B?MEVQeVczdHZpNFRiR0diM1BtV3AvOGx4Q25TeVQ1K08xMVNrZHd6Qm8yME4x?=
 =?utf-8?B?UlEvcUJ3S2RsMG8vamNkTUQ2RDNwWE0wYU5FVjFYWTE1T0hBUzF5NHpwNjZ2?=
 =?utf-8?B?RVlrTjNNRUZhY1BleEVEa2x3ZjlMK0xWaXl2TVZiOWJ4ZVRlLzIvaXFqRkpn?=
 =?utf-8?B?ZUtxOUxDMGwxeXk5WUtGTDQyYy9jZ3BCMXppMkFIOHU2TXI3ZHdjU2lVQnNm?=
 =?utf-8?B?K1NCWnl1OUlPTDdnRmpmMWpiQVJndUxwRnRHbmVlY005VmZpMGZVS3lkSUNK?=
 =?utf-8?B?NFlPa0VoQVJjTk1nK0FuZ003WVo4YnZwb0VYdVVySndPRU9ocnNSZDMwKzNn?=
 =?utf-8?B?U255U2JHTVdPSTFORXVpeXJPNFVSa1U2UlFJaWw2eVlZV3hWclFMZ2VlaW9Z?=
 =?utf-8?B?bE5RbDhZelZ5NCtKTnFjMnJXclpZUWZwMFVrOE9CUGJNaG9nTGJXNWhaRDNu?=
 =?utf-8?B?K21hQjJKMVZvS2Y1Q0xvTkNaaTRJZHJaWThyTlpTVUVEOXNROWhlZ1hnZndD?=
 =?utf-8?B?WGZzV0E1TzVjcUNDQ2xRSmxuekgxUVRDWjBtcFNJY2luaXZmdW1WYlRUUkRT?=
 =?utf-8?B?WGU3cXFkMGJnQXROTkc0WEh0anI1MDJhUUFnUFBVY1MzVTA2bEVwS2MvTWJj?=
 =?utf-8?B?VCtZSk95SVFCNWxOdDBjWFIzRGdtOGxZczBSQS9NbUVtWU1LRGU4UlhmNXJY?=
 =?utf-8?B?enZ5SkJTaXJNY1dnQW9QQUZ1VTFnYzhVYVBSc0lVVkxKZjRlQ1V2VEs5YUNV?=
 =?utf-8?B?cjkrdDNIQUp0cGdjaUVDYUd4RjhtRU05ODdBL0dIOWF1MlVxVXIwRTUvZ2JQ?=
 =?utf-8?B?VXpOUHNwSDNHZENpL203Nk9NMEJBQktwQ29tWDZFSkw4eVdzNmV3aFFIUzJa?=
 =?utf-8?B?YlpXa0poOFpDWFVraklodFRnS3dtTFRnYXBtSjFPQjFmRmpOTkdxYjFwSkwr?=
 =?utf-8?B?RVJONTJQejVlbVNDVDRKcElrMU9FMFAybm0wTGhNeXRDZEdKWkMzOUlEb2Nx?=
 =?utf-8?B?b2Zrck5DRzFRc0dmditzcWp5VkZ4SGFFL0JUTHFzcTZ4UEdzaVBRVklnQXZx?=
 =?utf-8?B?a1lHYnZvSU9XY3h5MXFEaW12REZ3cy85MlMrekZsMk00Y2sxNVVGaEJZTmJl?=
 =?utf-8?B?YmJZREpVR3g2YlUxMWJ6WnFNZit0TlRkdHJ0OWd5My9sU29XcGVVVnhaMnli?=
 =?utf-8?B?UkFXa2I5R1c1UlZxVUJXTS9NbE5aYXNHaC8wTUFHeXhUM09aMnBoUFNvREhD?=
 =?utf-8?B?QVhXVi9TMHE5NEFPTTJ3cmxNa2hEbVhiZXppZ21DTHVmSk5Jelo5c0ZqQWZD?=
 =?utf-8?B?VFk2dGNCOUNlazZNdHp2UDVzdUc2aHNHQ3N2VDVTNzBhSGJPbkE0L0JxMkg1?=
 =?utf-8?B?UTNDQ1JtTVhqNnV5R0JmWjdoVVU0aGtrYWV3SWlTMC9samNFd2tKVXpuYW5n?=
 =?utf-8?B?YUdOdHl0K25uRm8ydmhrb2l3T3ZYVW1ZUVJmRUh3OFdKZGU1OFA2Zitjajkr?=
 =?utf-8?B?bmVRYW5Ybm1KdjNWcWx5TS9scFBVT1BVbjBIdThHd1N0anp2c3VSU1ZFSUJo?=
 =?utf-8?B?MFEzYnpVTEswRjY5VlJyMnJPb0JTNkV5dHVIQ080TlNTZmJ2TjNZWkk5a08r?=
 =?utf-8?B?aVpZOFRvazk4aTI4alhzSkNJend0TnI3UHp2UEdKemwxQ2UvYjR5T051bkpl?=
 =?utf-8?B?ZTVCTTJLeE1QYVZnaG9mVVRIZU55bWpHT0VsUm9vNFRKZG1WRmwxMmplUm9F?=
 =?utf-8?B?RXI2S3hwei93PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 08:32:30.5306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae87b8c-7174-4510-be48-08ddf432691d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

Hello John,

On 9/4/2025 5:51 AM, John Stultz wrote:
> With proxy-exec, a task is selected to run via pick_next_task(),
> and then if it is a mutex blocked task, we call find_proxy_task()
> to find a runnable owner. If the runnable owner is on another
> cpu, we will need to migrate the selected donor task away, after
> which we will pick_again can call pick_next_task() to choose
> something else.
> 
> However, in the first call to pick_next_task(), we may have
> had a balance_callback setup by the class scheduler. After we
> pick again, its possible pick_next_task_fair() will be called
> which calls sched_balance_newidle() and sched_balance_rq().
> 
> This will throw a warning:
> [    8.796467] rq->balance_callback && rq->balance_callback != &balance_push_callback
> [    8.796467] WARNING: CPU: 32 PID: 458 at kernel/sched/sched.h:1750 sched_balance_rq+0xe92/0x1250
> ...
> [    8.796467] Call Trace:
> [    8.796467]  <TASK>
> [    8.796467]  ? __warn.cold+0xb2/0x14e
> [    8.796467]  ? sched_balance_rq+0xe92/0x1250
> [    8.796467]  ? report_bug+0x107/0x1a0
> [    8.796467]  ? handle_bug+0x54/0x90
> [    8.796467]  ? exc_invalid_op+0x17/0x70
> [    8.796467]  ? asm_exc_invalid_op+0x1a/0x20
> [    8.796467]  ? sched_balance_rq+0xe92/0x1250
> [    8.796467]  sched_balance_newidle+0x295/0x820
> [    8.796467]  pick_next_task_fair+0x51/0x3f0
> [    8.796467]  __schedule+0x23a/0x14b0
> [    8.796467]  ? lock_release+0x16d/0x2e0
> [    8.796467]  schedule+0x3d/0x150
> [    8.796467]  worker_thread+0xb5/0x350
> [    8.796467]  ? __pfx_worker_thread+0x10/0x10
> [    8.796467]  kthread+0xee/0x120
> [    8.796467]  ? __pfx_kthread+0x10/0x10
> [    8.796467]  ret_from_fork+0x31/0x50
> [    8.796467]  ? __pfx_kthread+0x10/0x10
> [    8.796467]  ret_from_fork_asm+0x1a/0x30
> [    8.796467]  </TASK>
> 
> This is because if a RT task was originally picked, it will
> setup the rq->balance_callback with push_rt_tasks() via
> set_next_task_rt().
> 
> Once the task is migrated away and we pick again, we haven't
> processed any balance callbacks, so rq->balance_callback is not
> in the same state as it was the first time pick_next_task was
> called.
> 
> To handle this, add a zap_balance_callbacks() helper function
> which cleans up the blance callbacks without running them. This

s/blance/balance/

> should be ok, as we are effectively undoing the state set in
> the first call to pick_next_task(), and when we pick again,
> the new callback can be configured for the donor task actually
> selected.
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v20:
> * Tweaked to avoid build issues with different configs
> 
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Suleiman Souhlal <suleiman@google.com>
> Cc: kuyo chang <kuyo.chang@mediatek.com>
> Cc: hupu <hupu.gm@gmail.com>
> Cc: kernel-team@android.com
> ---
>  kernel/sched/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e0007660161fa..01bf5ef8d9fcc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5001,6 +5001,40 @@ static inline void finish_task(struct task_struct *prev)
>  	smp_store_release(&prev->on_cpu, 0);
>  }
>  
> +#if defined(CONFIG_SCHED_PROXY_EXEC)

nit. This can be an "#ifdef CONFIG_SCHED_PROXY_EXEC" now.

> +/*
> + * Only called from __schedule context
> + *
> + * There are some cases where we are going to re-do the action
> + * that added the balance callbacks. We may not be in a state
> + * where we can run them, so just zap them so they can be
> + * properly re-added on the next time around. This is similar
> + * handling to running the callbacks, except we just don't call
> + * them.
> + */
> +static void zap_balance_callbacks(struct rq *rq)
> +{
> +	struct balance_callback *next, *head;
> +	bool found = false;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	head = rq->balance_callback;
> +	while (head) {
> +		if (head == &balance_push_callback)
> +			found = true;
> +		next = head->next;
> +		head->next = NULL;
> +		head = next;
> +	}
> +	rq->balance_callback = found ? &balance_push_callback : NULL;
> +}
> +#else
> +static inline void zap_balance_callbacks(struct rq *rq)
> +{
> +}

nit.

This can perhaps be reduced to a single line in light of Thomas' recent
work to condense the stubs elsewhere:
https://lore.kernel.org/lkml/20250908212925.389031537@linutronix.de/

> +#endif
> +
>  static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  	void (*func)(struct rq *rq);
> @@ -6941,8 +6975,11 @@ static void __sched notrace __schedule(int sched_mode)
>  	rq_set_donor(rq, next);
>  	if (unlikely(task_is_blocked(next))) {
>  		next = find_proxy_task(rq, next, &rf);
> -		if (!next)
> +		if (!next) {
> +			/* zap the balance_callbacks before picking again */
> +			zap_balance_callbacks(rq);
>  			goto pick_again;
> +		}
>  		if (next == rq->idle)
>  			goto keep_resched;

Should we zap the callbacks if we are planning to go through schedule()
again via rq->idle since it essentially voids the last pick too?

>  	}

-- 
Thanks and Regards,
Prateek


