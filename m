Return-Path: <linux-kernel+bounces-877694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA22C1EC4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89812189649C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859432F0661;
	Thu, 30 Oct 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cGaJvSIT"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE4337111
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809626; cv=fail; b=U5O7bBOtJhoYbbF6faW4P5k/0YdcUaeJ50WiuVMK5pGRTTmZxLOwkh5gij7lJxq3HY+PfrX044NbOQlwrvYuMUqrtLCqlXnfieQbAf3D0e0+IOJEggnP0JUNDUnRQCy1V9AwP7IXKkpaSK5wKu8X1I2rNKxBi4ys73Q8Ql1awxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809626; c=relaxed/simple;
	bh=BEMHKECKbQz/hATj9DDG4RPwjdbJvFGlFeL8mY2Wfi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=km2iXgvyIj5UVlmvy4yKEr6+lacWe6FTA+IYDaUPlpzMqOA0J9QrcdnDuxM6qCg8lctU5DhcVyvLMDZExiG71vzIhrh3KWaZOA7sx/jy7+lBQdbDSY0+rVos1iiU2A57GXTQUBokjQfxUSgVDZuUIGp9SnERYD1l/bPZCGshbFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cGaJvSIT; arc=fail smtp.client-ip=52.101.85.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSOGgx1v/Ib8OlwirtCNjxbmLhF7YssnnwiwVEcCX+p7xRpnhDlJGXT3yOeQX839SaMqLy8F0rWiv6rWsUhs0+VFxmwZEkrmIhPSqpSS45NRGs9LzvO2o4aIF1fXYY526IAkI2ThOqiYpq1M63SELNxXCzruD1hKGQVY3mGmcgcSq59tzQGERvIba9IADgEp0kl/2tQX3aQKcsXLB1Kx22hk47S8yZVcnbqW6JeunszEGNdarq5QNPsN1rvSEJNJ1WAzB2lNPW+FEI82YgJeEc3ImlXrfvW+0sQdbw3N9b0OQ3T6TzZtEYWPIVvEE/nkO3CKG7nyvMg1sm6jQ8KZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmk4BSYEItAJ95jeERlEaDvt3LA4h3/L+PaE2VwuxX0=;
 b=dl3RBcGECUY9slLsG/hDrft12rIWl/XiqKBKSHQ/8CMQFJwvfJ/UBS/cfA/FwFq/SQkVSl/oqBj9mbauDlVIapG+cKDpzT0tSX69YuIvbJ5yyYQuJwWhV+wkXyg9BbBWoDFyiu+AyLg0nr3EkRaRgI6qoyMOlPr+v/R14GiFgInMPLHBJ92+bP+YwrYJ19eOx9JNqLt7VheHBQ6fE7R20IEH2oe3i+ITYCOa+/vq6uZz8nMUvuAVjNVENddoSbMcMN3EgBg23PcWavVl2v+6NkNKf0+Arpz5SZ4c4Xh2W/XvfiVqzhAICIzh6pnQuNXI9V63vH+VY3f3ZRYYnWIrDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmk4BSYEItAJ95jeERlEaDvt3LA4h3/L+PaE2VwuxX0=;
 b=cGaJvSITjTgyc5BnKBsoZIULSJimX0IBuyJa8HnTB3hXIK9DpHtm8HwXy5gPvEF74rc5YfcjnkrqgWDHOCAftjh2ZkxowDYnshysMJX8/fV6mUNLGcnocOLvp1wGea39VUEG5ypwUqpxXfYaM1HCmVS2ccExy0SKN1jCTCLleKQ=
Received: from SA0PR11CA0151.namprd11.prod.outlook.com (2603:10b6:806:1bb::6)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 07:33:39 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::6c) by SA0PR11CA0151.outlook.office365.com
 (2603:10b6:806:1bb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 07:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:33:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 30 Oct
 2025 00:32:32 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Oct
 2025 02:32:30 -0500
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 00:32:24 -0700
Message-ID: <f3c78a55-0f09-44ab-8ce0-9658e534564d@amd.com>
Date: Thu, 30 Oct 2025 13:02:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 3/9] sched/locking: Add special
 p->blocked_on==PROXY_WAKING value for proxy return-migration
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
 <20251030001857.681432-4-jstultz@google.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20251030001857.681432-4-jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fad3df3-7a04-4f36-9a14-08de1786a4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0JEREQ4eTBBRVBSMVFqdVlwWnNZRjBXWWIyNk9ORkduRWVxSGF5ZWFreTdu?=
 =?utf-8?B?Z2pIVXVZSkU0SXN0N0M1MnRnank0YkVURmpHbTdqZTdwK29kdklJV3J5K1dT?=
 =?utf-8?B?OElKaS9vRXlDeVRBOGc3VkFlbGJvUUxJaEdpUFd2M1VRTWw2NEV5aUZjbWw4?=
 =?utf-8?B?VW1wdW42L1RlVWE4WlgwRld3OE5taTlRTDI5U1JJVkNReGtqNW5aaVFDRlMv?=
 =?utf-8?B?NERwRmRDUDZpckNYQWZ2bkl6Sy9GVUxSYXhRNGRoQ3UwY1BoT0Y0RFg4SGwv?=
 =?utf-8?B?UE9ldk9UMzNVblp6REVGdVRvdlorUC9rSmZUNTZXMXlyQWtqK2lOV2lYSVl6?=
 =?utf-8?B?SmVpMEpsZi9rQ0VCQ0hoQkJ5OEp3VVN6R1lkZHlMWjZJSzNYQVNFRi9lRFNv?=
 =?utf-8?B?eUdBMXZ6d1lUaDNJRjczaHlSS3N5NnNEb1Y4RDIxQ1Y1cGE0WHR5UExKTlRz?=
 =?utf-8?B?K0Jkb09ORm40WklXdzB0Ynp2N2xTa0dqUWNudEZtMU5TZDYwWTdQSElHZ0xT?=
 =?utf-8?B?bEttMTk3TkcxbU83SkxxVjZHYkNWL0FQMFBHeFl6S3pwTWVYaGdOaDBMeTJS?=
 =?utf-8?B?dkxrRjk5S2FOSFkrK1pEM1BNUUtjR3JvQ1lTRktkU1VkajFmVlFGRmwrbUd0?=
 =?utf-8?B?ZG1qQTBUSDJIcmlzSXpORUJXTjMvcFh5akVYblZzZ1N1MnlpcTZreWlNZStE?=
 =?utf-8?B?RXgvOFhXQ0FKY1o1MzlPQ3Zsc1hUaGpVek9GSEpwTituSGFuS3B3ZjdzTkU5?=
 =?utf-8?B?aXJDeTFaOThUblE0aElvMW1xRGdMSXhtemNKN1l6OHB6NjBNeEo2L1Q5UDM3?=
 =?utf-8?B?cEZsRVVYSVNINXU4dnVDc3dqMW9Xd3RwSlp1U1JRdmdVVE9laldXMFU1L1d0?=
 =?utf-8?B?NnNBcThVZEZBRldPZUNFSks3OUpzM2dZMzJnck1Uam9PK1BLZEhPMnB2Zkkv?=
 =?utf-8?B?aGF6cVVuZmJwcWYxZ0JSMmVUMXE1L0dhczRHc1ZyVncrT0ZnNWlrT0xHVWxJ?=
 =?utf-8?B?Qk8vVHY2OEtBTFRrT3VSSDQ0dzl1bE1aM2piRUF2QWdpVnR0K1lsRmJaakt6?=
 =?utf-8?B?bHkzSmd2dVBZMTA5S2JVclJFLzBxanNDV2RjMXhYMndNRkRwbFFNRjY4WDlO?=
 =?utf-8?B?YldpcUphNGdiM1Q1OGRUTDFXWUhwRTFLTG1XR3NXakIyUnJQMnFzSzdyYXFP?=
 =?utf-8?B?RTJCUURsRUpyRDdHZzc4NGFLNHRNaG4rRDBRZ29UNk1KSE53cEs2Mnk2OFFu?=
 =?utf-8?B?bHI3TFdzM2Q4M3VWSlMxY0l2U0ZXWE5LSG92Wk1XT2g0WlBkRzJPMTgyVlR3?=
 =?utf-8?B?cEtmbEgxTjFHOXptVDRPMFA4b1ZHRE1QbkRCZGdsR0RMM3l6QmJnWVRkWURk?=
 =?utf-8?B?ZE56Ty9jaFdPWjFHQVlPdHdNOXBTdXVOTkFtMDQ1aDd5M2ZQb2xJSmp4bHQx?=
 =?utf-8?B?eGt3b2ZEUzZLWmU5SmNFR0xTZTJIVVZ5aGVza3ZhRDJ5ZE44MzJ4WFZ1Wk1t?=
 =?utf-8?B?Y0Z5UDZSWDlvRHcxaHpIYWxhL3dyenJhaFU5UEpiT3lFWC80dld5UDM0bUIv?=
 =?utf-8?B?Si9nWW1SakNLZTB0ZjJEeUlUcWZqOFUxK3d4Uk0rbS9GQ0MyZy8xQlc0dnpr?=
 =?utf-8?B?MHgvaTdWR0dkcmdqL3p0SUpBTmY4VkpOUVkxQkx3YThzTHRnRjdXTTNsdjY0?=
 =?utf-8?B?N2VMOUd2Mmc2Ukt5OWh4NVI5TWdjSUZPQmh5UG1vWVp1Z2x5VlFCd0lyR0NP?=
 =?utf-8?B?YUd1TTM0K0cwOWxtMitrRVk4aUNrWFpqL0ZtOTRjVkdzWGFmUmRSMC9scVBE?=
 =?utf-8?B?Q0RHVTJsc1hvUEptTURXbGxxanFzWHQzd1JablZNaUFIU2VzMWN4dExrUjVk?=
 =?utf-8?B?UWYyVUVhVTlwRVRydTJGSllPOEgzQzdnUjB6V0xZN01FMWRhaDV5NVlZM1FW?=
 =?utf-8?B?SVRwUC8zVlFPRGZLb0wvak5XeTQ1MmdhS1ExVjZtM2Ywb09rWVpyZjNScjFB?=
 =?utf-8?B?aG9jV29oV2E2VUk2dVZJNjRJN3pBMDY1MHVvdVAvcFB6YkxQejBIam5oWnkv?=
 =?utf-8?B?c3RLWXB6ZTlaQVlHR1VaWE82aFpvaU1RU3p6RGk4L0gxUG9MNzFDeE1GSHFP?=
 =?utf-8?Q?lsvA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:33:39.0826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fad3df3-7a04-4f36-9a14-08de1786a4cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

Hello John,

On 10/30/2025 5:48 AM, John Stultz wrote:
> As we add functionality to proxy execution, we may migrate a
> donor task to a runqueue where it can't run due to cpu affinity.
> Thus, we must be careful to ensure we return-migrate the task
> back to a cpu in its cpumask when it becomes unblocked.
> 
> Peter helpfully provided the following example with pictures:
> "Suppose we have a ww_mutex cycle:
> 
>                   ,-+-* Mutex-1 <-.
>         Task-A ---' |             | ,-- Task-B
>                     `-> Mutex-2 *-+-'
> 
> Where Task-A holds Mutex-1 and tries to acquire Mutex-2, and
> where Task-B holds Mutex-2 and tries to acquire Mutex-1.
> 
> Then the blocked_on->owner chain will go in circles.
> 
>         Task-A  -> Mutex-2
>           ^          |
>           |          v
>         Mutex-1 <- Task-B
> 
> We need two things:
> 
>  - find_proxy_task() to stop iterating the circle;
> 
>  - the woken task to 'unblock' and run, such that it can
>    back-off and re-try the transaction.
> 
> Now, the current code [without this patch] does:
>         __clear_task_blocked_on();
>         wake_q_add();
> 
> And surely clearing ->blocked_on is sufficient to break the
> cycle.
> 
> Suppose it is Task-B that is made to back-off, then we have:
> 
>   Task-A -> Mutex-2 -> Task-B (no further blocked_on)
> 
> and it would attempt to run Task-B. Or worse, it could directly
> pick Task-B and run it, without ever getting into
> find_proxy_task().
> 
> Now, here is a problem because Task-B might not be runnable on
> the CPU it is currently on; and because !task_is_blocked() we
> don't get into the proxy paths, so nobody is going to fix this
> up.
> 
> Ideally we would have dequeued Task-B alongside of clearing
> ->blocked_on, but alas, [the lock ordering prevents us from
> getting the task_rq_lock() and] spoils things."
> 
> Thus we need more than just a binary concept of the task being
> blocked on a mutex or not.
> 
> So allow setting blocked_on to PROXY_WAKING as a special value
> which specifies the task is no longer blocked, but needs to
> be evaluated for return migration *before* it can be run.

Now I can truly appreciate the need for the tri-state with
that updated commit log. Thank you for the detailed explanation.
Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

> 
> This will then be used in a later patch to handle proxy
> return-migration.
> 
> Signed-off-by: John Stultz <jstultz@google.com>


