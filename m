Return-Path: <linux-kernel+bounces-754882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E61B19DFC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6121B7A74A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C223E34C;
	Mon,  4 Aug 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UlYSQkt9"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CC1BCA07
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297504; cv=fail; b=HT1ZoxlqJjfcdkLorm2esbtIs9TLf19wFkS1dSlB9O+BCQN4G7jbcoCcrgFpn4U5DmFTER5t6zNFMnkP/JJ01B42Px31rZ/JH4b75K7t/ie8LiFihzBg7evE8vcLztaswhQyQpbJdzbKka36g6Q0sTRQyuvJjKQvD+2skKTyL8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297504; c=relaxed/simple;
	bh=Y2wERnAThgILnP349xA4zleKKdVrTX9yMKfCgTUtX6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X+2X4Z5H4iDLwYpseb9xk+nLs1wxpu5DnpvpbDrCmMLI7x0PGjP7QfSAQVIVQDVo0CQzrvNUEzBa2tpGh/GpeE5vVSjQfIRDvt6e5WJ2c5WEZoHfdBRO6ppCLRizJdeLqZfSX5odzaGIDejAws4cbXHkxg7ptMbHQhRTDWg7nW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UlYSQkt9; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7z9dpQcUPflO6Qq6/msdsmZoubUr3FVgJZ4WnTvxhBFsIxO4cYejfjjthtEvT1f6YOAXDeNJsRvhur1hRVff2ou6arKf2EKbuZc1TshzY6NEWyVSgIx2ScoTYJP53DIHTGhJLEr2hE/6l42WOscldx4PKDNFOmwV1yMVLbZE4NHjqUhK+Tbq2Zn1Lc8ot+Nx82trXJ2Xq+pwaovSU2sjrF8WOnjmrIvq3jHuX4WSwOVzXwjc2PJcG0c3jlekWnvXsXxLyNUh4DHwO5uYEPuhdse7BPPc90e8nY9TZKOKvV8yBpQkDLqpu4cwklr8l+QrBfrz1m43n23oY+SG5uG+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFQNNKuvND5uw0aP3+FjoQug/tPdIXs5HyaH0cClN7s=;
 b=V14ku4K/7UqdRqoQ8OLabrCl+RbBgKU27ZhrLU+qby/smdCHIRiaYF7+rejvD0hmSxNgNbNKPXdRnAUzz6wTbtFgFGcroOQHZUZo/wlOukLCfbLhnGcHfzNwo7SJAakEqd1cZR+iRE9rQDD6YihxrMCygw8Kc1JKp8C8PQ5vYfrPI4sHKnizn8nzFU+0RADOM2Zg7ZeKMl9XMmqnoGXrvbWCbt4S8MtnI9VR5bU6CYX9UpCMOHpc0sCXDOOY3HhqNtsLRty77QYfidFTwz/qUPzT8hjQYfAmcBf6GvLimGUwgQA6dUvO22Q0QeF1kPa17Qfru/0+9yCdgsj4k+k/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFQNNKuvND5uw0aP3+FjoQug/tPdIXs5HyaH0cClN7s=;
 b=UlYSQkt9p71W3M4WQyExto7sIrg3y9MFMG0djlQWqpPn1keWxZjE+GHB5PhOHzSQLMdOMZ+S0gDAGuNZgN827YEHhWHHff8EWhelfOdqw7XJdzk9OYW5lRvaLKLo6wpm+NrRp0k/0Xsr9buUochoW/AI6Pt/heBSXh+IDCHuVH0=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by CH2PR12MB4214.namprd12.prod.outlook.com (2603:10b6:610:aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 08:51:38 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::90) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.18 via Frontend Transport; Mon,
 4 Aug 2025 08:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:51:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:51:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:51:36 -0500
Received: from [10.85.42.135] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 4 Aug 2025 03:51:31 -0500
Message-ID: <5c79fc39-2a68-4b6b-ba4b-73f6a0f4a30d@amd.com>
Date: Mon, 4 Aug 2025 14:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Defer throttle when task exits to user
To: Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider
	<vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh Don
	<joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
CC: <linux-kernel@vger.kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
	<zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, "Florian
 Bezdeka" <florian.bezdeka@siemens.com>, Songtang Liu
	<liusongtang@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|CH2PR12MB4214:EE_
X-MS-Office365-Filtering-Correlation-Id: 1773df83-c02b-4b6e-5c9b-08ddd3341f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFhVbnRUalNSWkJzbzNqNTBNNnlEUjFPbndwMWMyYmw3RDRtU1UvZUNWVEFX?=
 =?utf-8?B?TFVSMXR0VmFMbTR6NGJSSXZXYUJVZWRNdHVQQnRCMFFoWlVVcnYxWUFJVnFh?=
 =?utf-8?B?anpYRWdtVDVEMllxZ096cVg3ajRTemlCaVh2VmV6N0NiQVBmU3Q1RnhvYUhy?=
 =?utf-8?B?amh5ZWw3T0N0bk1aYWZxeC9DdjhnUnF1MXZnSjk1aUEybHdsVDlNZXg3UUQv?=
 =?utf-8?B?ZVpNS3RZRkEwYVZJamt3M29FS202NWkzbmtmOWlUaVlVK2xMS1hUY243U1hM?=
 =?utf-8?B?ZmlydzBEV1lVY1dCald5NE9mSm85ci9wbkpOWkVzUWNsTFgyUWU3Zy9iVHZ6?=
 =?utf-8?B?dm5vcUhVMmNFRjZsU1BZRkhYWkthU3VQcElqY3I1TGpFeGx0ODFXMWd2OXBN?=
 =?utf-8?B?R3hEcGZLakwwMEVwcFkzeHpHclFmbUd3Z2V0TW9uK2s4SlZFNjFsdTZJY1Ay?=
 =?utf-8?B?RGpJRTZQK0F1RHpyYWozWFkxN0UzNHhUQVZWam83VlZBUmJ1VnpMOWRrQ1Bo?=
 =?utf-8?B?WGxrSDMwQjlBQjhNSFVqNDR0TVFmSFlwNXNYYzN1TXZHVUxxRDJaSjd1eW9O?=
 =?utf-8?B?QzFqUnQvS1R1TTRRNG9HNXBUdTVaNW82NTNoZGxjcC9xa2xLd1hkTGFIVkNh?=
 =?utf-8?B?NzFKT0ZMckJ1b2gxMDJTVHFOSmsxbWlKd2d6TUZJTmdLNmp1OWRMQ3g0KzJF?=
 =?utf-8?B?dzZwekR5RTk2OFlvNm9TVHVRcG8zMzd3N1A5cDRaWURFM1RaemFlUXg0N3lY?=
 =?utf-8?B?Y2ZOZWlwb2ljRzRlWjJGZ1AvYWlVN3VOZ1NPdjROdzF3ZGY2Vm9sZ2htQmlT?=
 =?utf-8?B?dDUvWm5VTUhjaE81OWMwSGYzZ1NEWVQ3aVJVN2JYN0gvOE5ZdUpBUUhsOVNt?=
 =?utf-8?B?YTZTOWcwSkZETGtyaUxvTkZOR3pLWEJoWkFnSHppS0Y3TkNMT09WNmM1b2pt?=
 =?utf-8?B?d1ExdXpjZEozRVBYa3Z5TUtSamVDZEJvaVZMVzdhRzFjS3M4bGp2ZGRTcS9w?=
 =?utf-8?B?MC96SnkzTUNXaXBoSmJZR0dZZVZQSktGek9sQU0vRVZhZ3U2b3djUXM4WTk4?=
 =?utf-8?B?b3VOL0ZKYndqcnQwQ1UwUGpHbVlOVGtBczRwYVZIYkZnWDhoZlFtSzNocCtI?=
 =?utf-8?B?MWdGVmJxK1U1dmVhaS9EczMrNVBQc2k3OTNMMlZHb1ZkdytoOFlmeVlWRURF?=
 =?utf-8?B?S1M1VWFkYzhmbU5DYkdaZEcweDZvUllHTEU3QUZuUDNDaU9yUSt5c1RvMnhH?=
 =?utf-8?B?eG5PTExZeEFvS3NGOHprU1BOMW0wZjVMRVhVNUFMbDZiM3BuKzJSVVZXWGtH?=
 =?utf-8?B?UTQ4Y2tLZjJEYTU0UnFITjBWaDYxdHlFeEY5R1lLblBZSE9QNlFBQnhoVUFR?=
 =?utf-8?B?YUdLR1A2UmZPRTNlRnB5U0o5eXB6enJnM0MvK2ZYY3BPT0xiQ3plekZSdEZN?=
 =?utf-8?B?Y0tXQjJXQ1BwN3ZBa0VVSkhGTkxiUFdoMVE3MWQ1NzdCUW5SUFdpOGVJRFVo?=
 =?utf-8?B?ZEtzMXE2WnErUDgydW9Gc1BCNEN6bG5kWWJEbFNmTkpkb0dqc2FoejBvVVo2?=
 =?utf-8?B?NmNMMnE1NjQ0OVdsT0xxUDhTc3ByTEV2a2lXbitEK25iZzBNaUNEdkVzTU5o?=
 =?utf-8?B?RGFSbDRyS2UzYXlrZEl1anQ1SXk5WjFQaWt2L1JUU1lUWGViVFFicjVxd3F4?=
 =?utf-8?B?c1NLNHI2b0NjMHErWjI4RlBEczRrVDV3aDdjZ3IxUklyaDdURGs4QTdmUXQr?=
 =?utf-8?B?RzBHdTRUVW1oSi82YVBjVFptRkNZZWxRZUIrQjdvRm1xdmc2bEYwWTNhTTNO?=
 =?utf-8?B?Y3MzeHM2c0xZZ1U2YTg0NjdWZERqVlkxbVV6bkVpVnB3RXR4aGJMdkJNZ0cz?=
 =?utf-8?B?OTZaODJpWktHNnc4Mk1nQTBmT0dTZjRHN3lVQjFYS1BDeURVQ0NyM2NuMlE4?=
 =?utf-8?B?YXFHb3Fvc1pQRVdlaFNQT2Z3Y1A3SHdQM2FCd2EvQlZmaUNjbGxoNENEbUp3?=
 =?utf-8?B?MC9aMUE5WHgxL1pncSt0eFhwaDB0M3VuVlM1VlMyTHc3OUs1a3VVK096Rlhx?=
 =?utf-8?Q?VC4nwn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:51:36.8307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1773df83-c02b-4b6e-5c9b-08ddd3341f06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4214

Hello Aaron,

On 7/15/2025 12:46 PM, Aaron Lu wrote:
> v3:
> - Keep throttled cfs_rq's PELT clock running as long as it still has
>   entity queued, suggested by Benjamin Segall. I've folded this change
>   into patch3;
> - Rebased on top of tip/sched/core, commit 2885daf47081
>   ("lib/smp_processor_id: Make migration check unconditional of SMP").
> 
> Hi Prateek,
> I've kept your tested-by tag(Thanks!) for v2 since I believe this pelt
> clock change should not affect things much, but let me know if you don't
> think that is appropriate.

I've officially tested this series so it should be fine :)

In addition to Jan's test, I also did some sanity test looking at PELT
and everything looks good for the simplest case - once busy loop inside
a cgroup that gets throttled. The per-task throttling behavior is
identical to the current behavior for this simplest case.

If I find time, I'll look into nested hierarchies with wakeups to see
if I can spot anything odd there. I don't really have a good control
setup to compare against here but so far I haven't found anything odd
and it works as intended.

> 
> Tests I've done:
> - Jan's rt deadlock reproducer[1]. Without this series, I saw rcu-stalls
>   within 2 minutes and with this series, I do not see rcu-stalls after
>   10 minutes.
> - A stress test that creates a lot of pressure on fork/exit path and
>   cgroup_threadgroup_rwsem. Without this series, the test will cause
>   task hung in about 5 minutes and with this series, no problem found
>   after several hours. Songtang wrote this test script and I've used it
>   to verify the patches, thanks Songtang.

I just noticed this script. I'll give this a spin too when I test
nested hierarchies.

-- 
Thanks and Regards,
Prateek

