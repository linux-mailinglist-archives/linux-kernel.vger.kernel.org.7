Return-Path: <linux-kernel+bounces-823964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7183B87D32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BE1C87FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302834BA42;
	Fri, 19 Sep 2025 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="meieclFq"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F078F54
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253100; cv=fail; b=dc8enRrQWmgtyGd7VkzvvsL65HO+MzoZ12RZItz5PhsbkTBmK1mGPDQDizE4qWU4ylIv9XKa+etZC/lPqKQ4MQ3l8FbmxAzRFgxU+wVM1xszNfrIFGZjo46VMBvauCNQrv98ZuvjsYrCOmwdnkBzhFpPMzwERWLHRk6xzOC1YTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253100; c=relaxed/simple;
	bh=56zkTX5IxhdWo9gBoDtjYdAwTa8aKhyTJyz4U6kBSzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Werh0qUfLQReaF8dsI/SNbUVtrm8K6CxKE+EgYk4RzgWHdAOpC6XxcWoBt6/Jk51zsteiL7AcHRfvyPRU652c+pCGKJ18poJ/LwdoIfOiCXzN4MpHgqcP4cbByr93jssFn1CGS1Kqpc142Kxleq7T8EBQKFar+fAmaIsErgeBVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=meieclFq; arc=fail smtp.client-ip=40.107.208.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0rHlqoRnU+9DRLl0TIYAjeTPyqPvvjzMyxcq586GA4rQbRPSlAfFr+tMPJeZNVlf9C08dBxTIZNLPcr8MqXk0GVYLPfL1/Up+24Kp6FhOWsmc730SG0UBI9qebHV+BDz3X1UQOsa3lRypog9sAbroTlt23x7hH5DQzFi5/UAX3ETuVyiO4Wl3Iisz+zNQ9MTzyUeGiYyx5qEH+j6NzgMvVYCIbtoI5xR2ldMeeC6xzsAUffxNCsDEODOApt8DYPq9ecocyvcqRtwW1G9GMl9vn4rjoeTBRhzNkkNBW9f18/Uq4HfGUIEd8SMt8ke5XPLg0cnRikbk/pkX56n3lzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNh8cZZaT/f4o9eGeTwkUm3YbVJySACRYwUd9FNuQLI=;
 b=kjCj3n35QOImJPKj4CdF5YLP8OiJJq4NT/JuU6/gsCAazA2ciIHnT4HNAKmGFjluqNeaUlkUBC9OjhxQpcF12c8FkkLCLXs9pRlGrlIoNcMWu4uGZA97y0GF4fSWcsXdPK9qlE66VR6EkJHnB3mww0OJ6YL5PWXP/KtM72nH//Fgd26SBGdVT00v0EVBJhtepg/jx62J1rJjWq3pRxWWowpCxCnIByuH2Tjbu3lHk5V8ivfDbVL9lm+iyWhil/4P4TqJAlRCiBBtkpj0+rhZoQaXzMEGJG6B5dWi/vxlYkDqzZw7C0/hiXJ79iJyj+d2lYNncWNXs9QlUezpUoCjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNh8cZZaT/f4o9eGeTwkUm3YbVJySACRYwUd9FNuQLI=;
 b=meieclFqR4oLLyvK601sCA1/4IW9k4wCCLHBPN5gCyZnqANhK3leUiFJmhmewfg4g6MIq1DlrTDGFCZUgfW4YmspNoJQQQ5pjIXHh0DSb+XthDqFQsX54/xmP17gmPLjKYSX0dkAIEsWIqAbFOyWhDmdDUuSpuI1ciDpQ1BSgGQ=
Received: from SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::7)
 by MW4PR12MB8612.namprd12.prod.outlook.com (2603:10b6:303:1ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 03:38:11 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::47) by SJ0P220CA0001.outlook.office365.com
 (2603:10b6:a03:41b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 03:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 03:38:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 20:38:10 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 22:38:10 -0500
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Sep 2025 20:38:03 -0700
Message-ID: <93f47a95-6205-41c0-b0f9-8cd92f79e56c@amd.com>
Date: Fri, 19 Sep 2025 09:08:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v21 2/6] sched/locking: Add blocked_on_state to
 provide necessary tri-state for proxy return-migration
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
References: <20250904002201.971268-1-jstultz@google.com>
 <20250904002201.971268-3-jstultz@google.com>
 <7bead244-f366-48dd-aae4-380d32de173b@amd.com>
 <CANDhNCo87Xq1-5vhVCyZ3780J+_tGVAjT4d=Z13WsfyQh3oaYw@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCo87Xq1-5vhVCyZ3780J+_tGVAjT4d=Z13WsfyQh3oaYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MW4PR12MB8612:EE_
X-MS-Office365-Filtering-Correlation-Id: 57455512-d0db-4af1-2247-08ddf72df4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alFwQUFMSWRnZHhvSGFXQnRzVnk2U3ZYQ0g5NVZUaForNy84Y2VtWGc5Slhu?=
 =?utf-8?B?Z3NnVzFDR3VUTEtYM3FaOW1vUWZzay8xSitwdkJBK1ZocUtNZHJFTFlCZHIv?=
 =?utf-8?B?alRRaEljLzdkSEMzTjZOdTdtQ3duOGNXd0pWWHVIaXRyVTI5MjFIZEJDbHFI?=
 =?utf-8?B?eFZpUUFlaXBKcFVXbEhUc2VDUXJpZ01hUXR1QUJzT09SOE9yWXgzZExDYUFT?=
 =?utf-8?B?ZHc2dGJwUUV4YlN5aS95KzRmRjJmc2JpN2FvbmE0dHBjVldvdGd3ekFtOVFu?=
 =?utf-8?B?bGpFWjhneUtPc3hGdEE3bE1LeXJKZzl4RE04UDBFK2hWem5WYklybUxYWkNC?=
 =?utf-8?B?U2wrMlpHTm5uSXBJeTUwbk1wM2V1cjI0cHdXa3d6YkdObCs5bFdLVE94YStl?=
 =?utf-8?B?amFIQ2o1NEpBVHpwZk1vU0l3RHpsNnIwOVVPUVpsN2h3bHhaOFpiSmpOYTUr?=
 =?utf-8?B?Ym95S1hZRlJmOVEzOVByV0RvRC94aXF6cktHRDlNL1VYNk9LNXhKWE1zZ0FR?=
 =?utf-8?B?Uy9vUkVpTXgyaVBpWHdqU2VrcVdVSmNYeWgwWGI5eVRNWnZNV3NrY05oOFVZ?=
 =?utf-8?B?OUpHVnkvdnp3SmtweHVCdnRzMFZ2R0E5ajROMUhRbmdlNEpLUURDZVBrQzd6?=
 =?utf-8?B?RHhMU1hVK050WFluQXVMM3NlWTJFMzVTRlRiM2JaSU5DaVJ6WVZ2aDFDV2FC?=
 =?utf-8?B?L1pXNkpWK2Q4SHVEWGtyRi84dnNYOW02aCt2UTcrUHNLVkhwRjRFZWFUaW5H?=
 =?utf-8?B?azJsd3dwZVZuOTJ4QzdoZHBQa3kvcHhFZ29sZW1uSDNRV3V5VzZ0TXF4c2Fn?=
 =?utf-8?B?WWcwMnFiR002U0xjN1RidkNhUThRbDJWN3NvZ1IvRTFiK0thZWFqdjJNak84?=
 =?utf-8?B?bjg0NEo5a3dsV3RDaVc5aTBsQ1VZajBLdGo2YlNuUlBzdDFGR3N5a2JLYjY3?=
 =?utf-8?B?bmJqYVNsZmFiR1pQT1pvYnlpc3dXMW9UQTYrQTNHTmdBM0lVSXN3NXJSMXZ1?=
 =?utf-8?B?M1FiK2JzQ1hwb3UxdjNoaWN0TmFkcTZ1RTJJbFhHMDhNSXQwZWNsM2ZjWE03?=
 =?utf-8?B?c24wamYzdXNiYVRlakxGNjVrdVdXSm5FbFZ2K1ZRYk5Eam5EWkR2TWJzYUhK?=
 =?utf-8?B?OGhjZ1UyZElCYTU5OFNWZVM0blF4ZHJsbXY0Tit6NGZ0Ung5N0Vrek5FVDNu?=
 =?utf-8?B?SGFmTUFCL3FYOUljZXlEaTM0Z0t6aHpTS0NNV0RRV3ZwT1lqK2Rqem5UTzlS?=
 =?utf-8?B?M29PaVByYUM3SXh4ZFArNUsrUTM3VzhyODFzRVJYeTNpeTNDSzhjdGltYjRD?=
 =?utf-8?B?RmdBUlV6aVJ6OTByQXp5K1l2ZHR0ak90S3ZCczd6M21iOU16TVYyUlBQYmJT?=
 =?utf-8?B?alJKdnE3YldWai9vcU5PUkIrKzNycThKSk5NOFV0SmRrNlBLREZqODJ1WDhE?=
 =?utf-8?B?L0lFRXMzK042VE1LcXQwV29hUWhrNVFVMUZndi91akR1dTRQaGJsU3M5QXVB?=
 =?utf-8?B?bEUwamxmYnQ0YlpBV3h6YlNFRElzR1ByY0E3YisvWVVZRCtZM0Ywcmc1S2FC?=
 =?utf-8?B?NVJOOHhJTnpmTHVtTGphK0YwcFg3S1hvUmlmOEdXYXJ2eVJEUUJPMzg0U2hl?=
 =?utf-8?B?WStyZXk4c1FoSmhZUEhtbzBpL3FaUzUxN3d1MDlXN0FDTmlsQzcxM29iTnJT?=
 =?utf-8?B?R1hwazNjLytTYnZ4QUhIMnFMTnQrTGZvL2tMc2lLVGNYVkdzVnBERFI4R21O?=
 =?utf-8?B?aDA5bm95SS9sajRiSWY0RGVjUzM0MFVSQThWR3YvOUQ0d1pDLzRNRHlvZFkx?=
 =?utf-8?B?eVRyM1pISnhXYjBJcU9zbmhlS29IazBZOGo0UlZ6R1hSUjBHei9McTNGQ1ht?=
 =?utf-8?B?K25NVUhZVHlyWHpxdFVWaVZndFVLNmU0QzlZU2FUcnFXMHdVWiswSmNycTRD?=
 =?utf-8?B?MWV1c1c5Y1VraGtrcmd3eVdDMXdLRzg0bkMwcHFBaUNHT0dHaWk2UVQyYk8z?=
 =?utf-8?B?aHAxVzYyMHhrVVVGMVhUS0hndnAyQTJoWElCVjl0OUxhMkh0dlgvSnZ6d2Nr?=
 =?utf-8?Q?fLBI5H?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:38:11.1423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57455512-d0db-4af1-2247-08ddf72df4fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8612

Hello John,

On 9/19/2025 4:37 AM, John Stultz wrote:
> On Mon, Sep 15, 2025 at 2:05 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>> On 9/4/2025 5:51 AM, John Stultz wrote:
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -815,6 +815,12 @@ struct kmap_ctrl {
>>>  #endif
>>>  };
>>>
>>> +enum blocked_on_state {
>>> +     BO_RUNNABLE,
>>> +     BO_BLOCKED,
>>> +     BO_WAKING,
>>> +};
>>> +
>>>  struct task_struct {
>>>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>>>       /*
>>> @@ -1234,6 +1240,7 @@ struct task_struct {
>>>       struct rt_mutex_waiter          *pi_blocked_on;
>>>  #endif
>>>
>>> +     enum blocked_on_state           blocked_on_state;
>>
>> Is there any use of the "blocked_on_state" outside of CONFIG_PROXY_EXEC?
>> If not, should we start thinking about putting the proxy exec specific
>> members behind CONFIG_PROXY_EXEC to avoid bloating the task_struct?
> 
> So yeah, your suggestion is a decent one, though it gets a little
> messy in a few spots. I'm working on integrating this and propagating
> it through the full series, and hopefully I can clean it up further.
> There are a few spots where this and other proxy related values do get
> checked, so wrapping those up so they can be ifdef'ed out will require
> some extra logic.

Looking at the proxy-exec-6.17-rc4, most of the direct references to
"p->blocked_on_state" is already under CONFIG_PROXY_EXEC. Only the
functions that modify it needs a stub and a helper for the usage in
task_is_blocked()

-- 
Thanks and Regards,
Prateek


