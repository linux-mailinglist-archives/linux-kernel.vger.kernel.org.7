Return-Path: <linux-kernel+bounces-823976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49069B87D83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053D03A9D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626724DCEF;
	Fri, 19 Sep 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oceL4icw"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6151021FF45
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254051; cv=fail; b=KUfeFuSb0aBNrjqJZIjfv5VXOxDHtOmFa/dhrWklBHR69+6GPMHJ6Q/eQRE2D1Rg1mrlAJE0LRsIebxO37ODPjPL6GeXxRjviwVl628oAMrMfXBByya0QCUN9EnV2T69osFgjD1SASJrYs0oneD8FQ7dpgHk85b/HAn5REhZ+u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254051; c=relaxed/simple;
	bh=IFpZEZYB8rWjHNvJYcsExLjaOcDJl9TP1dmttGCTzbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mq5A4Sf3XwA7J5oigjo5AyXAv3rS4RBKqjRq2enzSiWvIKX9Ef7/etS11G7ixitd0JEinan2V/O3btxon+pMFEtkX4LYb2Qdf/hmgeAfXb1I4UtkH/TwPI0P+tRIPDj2wnCb2uDYqpjQ1B2kd8s4hxFfVp/RmF1AaQsoI2Ntnxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oceL4icw; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZHMDD08gA1vHd45EvryCGmClVRXohlKogwVowq8IfJV6hBpRTitZUDNyci2/j8fop7u7KuqPHMd4sj+2BUkh83DtIyjrmum9ermH08FI2SDZHB5312ODhegg0cFSfE1JD9CtgfzlFTa+MRs9fVKCVcFXCGzEgyMEDNoT4Ohteae1ZwhLPSKz+8bXX9m5wi0Du9D6WSH7L6iUuicOnEZWA4zwPE6r+ySuERabIJUASNNjVvRkFWy4Sr3cQiTc2qfNBCE9tPsvk3qBWCdyr1mK8pJFLX3WstpXVwnTfwlFfnCXmTMTwB0e+S92JHz+9iADtM8Q4Zi4XlJ5MMaXkRFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYsMIuE1baQUmFpPoTXXno01UOExHpcyYL3GJmOrMBY=;
 b=qA9KHrhBSpOHngHnWKgKcsiaZVL5IufsMTd8YraWSIFWEKjoNiz7/oX1LYULeGb/3u+bBE4DVaRyzskVdrtKvpHgTqXIg59/CJV8Zxq2E2y7TrX4hmjXaFUq0GuL3tNJ3Gk/0ToagSabJFir+TMwuwe7lR5c2/U/s5t8Z2x2S30b1UlFvldGU5mz/kLTgQkMU4raI6UgJ/ehcgpSPhGaRTt7WnYipAPqQQWef6P4nIGMF4O3cOxxAXO4cSExQtNMG8e7seuRgv3I212l4ct98LqHCoew1+0ThH4bivYMFHXcuvrS/qNkM7wM3a1kha7HKdTC/auPtRbtXHGHER+nSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYsMIuE1baQUmFpPoTXXno01UOExHpcyYL3GJmOrMBY=;
 b=oceL4icwqW0EgxhsMwzcXjArb97eW4lU8FQF3lJKdWi5dXqrzU5ZRtdeLTUZZh8YPodmp4LloU5GXVWFvQGuBXKFB9C9D8VGLeVOPDk6v0UyBLaZDO40d8NhK1d4gEp/cpKZ++T9jkT9uCVEKdgES1UBxWyJqV78uNggdUCmSHo=
Received: from CH5P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::16)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 03:54:07 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d9) by CH5P221CA0012.outlook.office365.com
 (2603:10b6:610:1f2::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.17 via Frontend Transport; Fri,
 19 Sep 2025 03:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 03:54:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 20:54:05 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 20:54:04 -0700
Received: from [10.136.41.20] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 18 Sep 2025 20:54:00 -0700
Message-ID: <7c827f3d-b9ed-48f7-bd61-98a128db81e7@amd.com>
Date: Fri, 19 Sep 2025 09:23:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] sched: Fix hrtick() vs scheduling context
To: Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>
CC: <arnd@arndb.de>, <anna-maria@linutronix.de>, <frederic@kernel.org>,
	<luto@kernel.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>, <jstultz@google.com>
References: <20250918075219.091828500@infradead.org>
 <20250918080205.442967033@infradead.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250918080205.442967033@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: d16e14c7-d65f-4609-2632-08ddf7302e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bG5UZXFvZjNYMnp0cHhQSGtMbTIvV3V4MUNJd210eGdwaHlBeGxxM2tUUDBq?=
 =?utf-8?B?ckJGcm96Ty9WSGtlYldJNkVEdFdXUkxyUm1CRklLVU5BUVpIVy90MFhnTGVp?=
 =?utf-8?B?M3pwVHJZejlpeVFhSlhIMkd2VjFhZko5N0VpZURpbTZIK0I5M2ltMk5Ta1Vt?=
 =?utf-8?B?VFBqUDRqaGRJa1hHcHdxMG9nUWZpT1NTWkVlWVV2Nlk4bWtLVW9CSzJlTG1M?=
 =?utf-8?B?WHU3SW1VYUxRdy9sa0I3a2RSdC84ZmxmVVhhdHJ1bjN2TjJLcEdwcnc2Nk1Z?=
 =?utf-8?B?UDk4U1JuczR5d0s0Q1FPK012b05yZzkwZWwwRityTjRiVEs3WG9rN3FRakhR?=
 =?utf-8?B?ODhZc1g2Qng2V2xZL1hZb2tSVXI5UXNLOURFTGpYYjV4MnorMFE3aGVCaXVT?=
 =?utf-8?B?YjVyVXhqSG9XaWRsQ3d2RWxYQUJiRTVpbkYvR3FqRFpya3VYM3R1czIxRmNL?=
 =?utf-8?B?UWVIV0tjOUpWaktjRDcvNTJQUFdIMHl6QnhSK3BNSithVVVNbnBQczl0RE1h?=
 =?utf-8?B?dU5VYWdmeVAvMEErbWI5KzlpT0FPWjBEcjhMZ2pvL0FJWllIbVNha1p6alQz?=
 =?utf-8?B?WWxUQ1pPd016OWNNeFFtb091TFpiOHdRN0ROZkQ4RkNKQUlIWVZkd0JwQnVS?=
 =?utf-8?B?NUdFTWNCT21HZTdWWVA3Q2s1WEFZb2c3SlArbFhLVXU2YUp6Mll4cXdZeVBr?=
 =?utf-8?B?RjJzQmZtNVdQY3NUM293WFRsRFhKZDVUTlZjK2hGK3BWSUN5THhZR3dZUi9G?=
 =?utf-8?B?THBDbFJGYnN3SjdmK1MvTWE1MlJuREIrR1BjRUswNlJQWXl3YldJcWFyUmxZ?=
 =?utf-8?B?Rmhkc2lRMlkwRk9SZ2paS3JUb0cvZEFFbytvVE04OWJkYUtnaFpXUXgvZTdp?=
 =?utf-8?B?TXNNcFVBUlAzaTRKSlpTdllnV1dZRTVrY1NFOUJsWEdHcytUbTZxTHZtcVlh?=
 =?utf-8?B?ZnJGQjNCZzdWK2FMTlhCUnJLOU9oWkhXUUVibThaZm9yRTVQVDIrS3gzNFJ4?=
 =?utf-8?B?LzBFZzhTOGFPSVR1MmFVOGJYQXgzVENvQUl6TStGUTBLeWdMK3dDUi9NNGlV?=
 =?utf-8?B?ai9CcUdFTW45bDBSQ240d2kzNEx0d0k4NnowbEY4TTdvYUtrUFNPNys0OVV5?=
 =?utf-8?B?SFlTYllFTWoyQmduVXgrNmZrQnlLOSswQnRNYmNTVkdJMFJlbGpmZExLQytP?=
 =?utf-8?B?SVFkbUlRcmNMMW5XNWV6L2hmTjBoRHRwUGNuWm1Wb2dVaTkyL0dpd3FBNER1?=
 =?utf-8?B?MHdES2MwYzdtblRPVnZJcDZyOWxVNFY2OHhvSFBpTTRRblBkZzZLNUdIRW1k?=
 =?utf-8?B?dlNuQmY1RTRvRThNTHNJaEtxVmo1bEVMYisvN2c2NzU5UWJJaDZFOGZqVEE1?=
 =?utf-8?B?LzM3dlVGYkJtUndrMmswY1Y3N3BvWmpzZEp3YWg1dTJwMnBNcFRDdUpUNFdQ?=
 =?utf-8?B?VG5rcjJRWHQzaHVZdjErdzRvVHBNWnJtc3ZGbnlLUWZRcXBhYWZnTTREd2lD?=
 =?utf-8?B?RGQ0eEpXSjRmTGFmdW94UFNrVmFLU2Z5eGg2YmFTNFI5QllxSWp6Vk80TFZT?=
 =?utf-8?B?T216ZGFtRDV6RWY5V1NUcHo2dE5rcGMxQlpyV0tmQXdaWXJrRmMxYWN6S09x?=
 =?utf-8?B?bDVyQysvNnZmRkp6MnFwZ0Y3cG5Oa1JYK3hOaUVoYWtDZVUySG1jZHIyWVlm?=
 =?utf-8?B?QlZFWGtpQjI1SlZxZjRmSjdDKzVYbGhWSWV1b1lqTzBKcVlQTm9KZ1djMFE1?=
 =?utf-8?B?djhWL0ZMN0kzWEpIR05XRjA3ZnMzQ3NRdkMrMVZkUWUrelhlOVEzalpMcTBz?=
 =?utf-8?B?MW1tYVpOaTYrMUx0TUYxemRXdm9ZbTFrb0x1V081RXhMWDRkdXBuQitnZ0la?=
 =?utf-8?B?cDBpYVBWcC9NRHpJTEpqUWdzQTJDQmZWaHEvN1VidzRCZ3VSa1ltVEo4S0E5?=
 =?utf-8?B?THpsM0lRcjJVcFZZdG1NemIrOWkyeDZVNUI0QlFyRytMMmFvOXpVT3FGS3hP?=
 =?utf-8?B?MWx3aG9xV3pBU09QRzRoQ0ZTL2svSkd3NThCTlFMYmlDSEFzUG1GblZlYUpu?=
 =?utf-8?Q?yQ6iha?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:54:06.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16e14c7-d65f-4609-2632-08ddf7302e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875

Hello Peter,

On 9/18/2025 1:22 PM, Peter Zijlstra wrote:
> The sched_class::task_tick() method is called on the donor
> sched_class, and sched_tick() hands it rq->donor as argument, which is
> consistent.
> 
> However, while hrtick() uses the donor sched_class, it then passes
> rq->curr, which is inconsistent. Fix it.

Can we add either a:

Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")

where this starts making a difference functionally since single CPU
proxy can have rq->curr != rq->donor, or we can target the same commit
where task_tick(0 in sched_tick() was updated with:

Fixes: af0c8b2bf67b ("sched: Split scheduler and execution contexts")

Other than that, this looks good to me. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -875,7 +875,7 @@ static enum hrtimer_restart hrtick(struc
>  
>  	rq_lock(rq, &rf);
>  	update_rq_clock(rq);
> -	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
> +	rq->donor->sched_class->task_tick(rq, rq->donor, 1);
>  	rq_unlock(rq, &rf);
>  
>  	return HRTIMER_NORESTART;
> 
> 
> 

-- 
Thanks and Regards,
Prateek


