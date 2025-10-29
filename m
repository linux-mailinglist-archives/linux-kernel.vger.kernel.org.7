Return-Path: <linux-kernel+bounces-875171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CFC18613
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 07:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFE540094E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A397F2FD7B2;
	Wed, 29 Oct 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o/yy+MjL"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F198F4F1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718131; cv=fail; b=rkRgwlHJVJ87olL/8QAPN8QYZx44eLeZNljuVLKBQPw57BtEl1co+XvDTocxNyrtm1lUh22RXwipZ7BIt3XfZYZR73V4tmTS9ZpxdEnAU1o8erVewpic6Ns2s4Yv5fIuwiB/drh8Ons890aBJpcC4TWeqy7F1Za0H0ewBoScTWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718131; c=relaxed/simple;
	bh=aIQktAg2K3YY9wf30ldJGwiIieAmRW6wmzMSU6IR38I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tBu0+B16pWaXKgrCG2h6lJA/lpzC4jyZ5YLxHk88rmHG9BB1e26e2btZo+2hxuBCeEdFiKljW1b3BopRfMy3xN/a2yvYGCvoXUODeMzLGXSjnf5DeJrrZOGf6hbI/g3NUaUYIy9pGks6kX7ggbIZ3JvhJpSmn29ED/e9CJm3S6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o/yy+MjL; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYj5qGv9HUfkSx93of5oGw9QZ9Z+3hsfwJq1Tw0mBIfPNfpMtNXuj+TVkCCJLR2pyinm9I/5TlyZ3pnDOSyWHrd4DcSgXbfKvOvcVlKIcy5sb2qRzgO/87u+fEWgfPB3l33Vs6T5EOvqwpxROF72HJJ395dQbU4kdICJXWIm4WFFdHbx7oOEaxfRmDIVkTGG+xMPqmhDo1is0XrXmKgVOmDyRSPrCdRhsRBE5AOe+6umxSv0Mm+QETyk0CrwQaVywLX929dZUUF3h/ppIR2IBQssts4PYkzEzWI2LMPyPrflJDO/HeJCpHQcLlqDl6uUcDTW25tpog7mYNGeGl2WMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf2pksGozU2PzHkKjS8iLPk3w3bSpiy8VFoltIQiG9E=;
 b=VDTSjJm1mx30m/DhHNQyCdDsDnPE9LhHnRCufFgC5v3NhIrgSzMed+vUUgzh5gLyTpgaQ5mwCYex1p/hfoZ3gFjB4rReV+81/aizS9rr6618VQGnjAd5bbyvhmQUNIOIL+024tXlLJwJZFcEI/fim12iOXXpLPjhr12a/D5yGN8jfkwbiUBVpxEnyrBdnGVs7riUuQfQ0is/9WEthf4/XDL4By8jBPmm3qtvI2ckOFywArZ164JJE5QAuyjYj2yl45FjBDli9VJLG8ZjrGnYQ1B1L+YMtxKtgjfUSyJeF4I1DIt9FhIB6StFbnRfgkYafHEYnVP7MmnYbjud3Bfeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf2pksGozU2PzHkKjS8iLPk3w3bSpiy8VFoltIQiG9E=;
 b=o/yy+MjLxyvoYOLXXvEuwszjtrOVsIHWJ4/jt8VzjceAb094oDWHhAW4pW1wKE6kyWboCBqjXCsNb4HrQO6QrvVJ/rr5kyRsksofGc9jaZg2uq7yWiof7pOff2VPFbKTz/K1UmDwmSymN0Za1vgboMalSXaqsEl+BmaSyV6JxBo=
Received: from SA1PR04CA0010.namprd04.prod.outlook.com (2603:10b6:806:2ce::16)
 by BN7PPFCEE68E7BF.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 06:08:42 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::64) by SA1PR04CA0010.outlook.office365.com
 (2603:10b6:806:2ce::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 06:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 06:08:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Oct
 2025 23:08:41 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 01:08:41 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 23:08:36 -0700
Message-ID: <48f6372c-5cc6-472d-b2d2-31e151d85652@amd.com>
Date: Wed, 29 Oct 2025 11:38:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched: Feature to decide if steal should update CPU
 capacity
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Srikar Dronamraju
	<srikar@linux.ibm.com>, <linux-kernel@vger.kernel.org>
CC: Michael Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>, Ben Segall
	<bsegall@google.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dietmar Eggemann" <dietmar.eggemann@arm.com>, Ingo Molnar
	<mingo@redhat.com>, "Juri Lelli" <juri.lelli@redhat.com>, Mel Gorman
	<mgorman@suse.de>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra
	<peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
	<tglx@linutronix.de>, "Valentin Schneider" <vschneid@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
References: <20251028104255.1892485-1-srikar@linux.ibm.com>
 <8ec843b6-ac7d-4cef-a0b1-12b85470fde8@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <8ec843b6-ac7d-4cef-a0b1-12b85470fde8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|BN7PPFCEE68E7BF:EE_
X-MS-Office365-Filtering-Correlation-Id: b02e6c79-fadd-40a1-36ab-08de16b19c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3dGQmFjd2t1TDVkV2NPVStOeVBGVVVTR2Uvc1hPQXA0VEZrNk9hWFJBaUtv?=
 =?utf-8?B?YjArSVBLak1pR3lJVExHVTduZXlaeXBMc0UxQkN6azhTSUplUDgrY0w5bERr?=
 =?utf-8?B?TGJPcU5LWUJRWnhMVnZpOUQvVit0Qjl0V0NoV3VSd1d6Vml2RE5QYzg0cWpR?=
 =?utf-8?B?VklYcmZGSEppUksxSGtkbXBvVlQ5emUyWUlwWHVUTWdaUnhZeGNyaE40QVpl?=
 =?utf-8?B?cWsycEM0OW8wRkNlTkVGRmY3TEhpeHozVDVOMTAzQzgyTDdNd29vaGx1NXVy?=
 =?utf-8?B?VWYzNU9DVm1UN1JscVZzYXlxZHZGYUxXV1k3RjR1ZWdqOXlZVHQyZzQrSDZF?=
 =?utf-8?B?MjdKbkZBNFppZXRjQzVUOGdjdzJRbVBEZm1yWUNBb1NOOWJtdEI0YnJ5cTNh?=
 =?utf-8?B?NXBOb1djaTMyUitkQiszYlA3SE5FVU9CUEkyNFRocU92QklhU0JyZ2FDeThZ?=
 =?utf-8?B?UHhUTXVndHloMkVqM0dSMTYrMTlWak9Md3Vqay9VcVNlWnZDbEpOSzkxTVhX?=
 =?utf-8?B?Mk9EWEdKQnFZcXVJTXlzSHVwWUZicXZpSFNJM3VzckZVOEg1QmtEVkVvc3k0?=
 =?utf-8?B?K1R6b2Qyb3RGam1WeXJIMUhhb0lQanArL3Rob29TaHJPMGE3MFFmSlowcXd4?=
 =?utf-8?B?aHp4S0hFb2JjbnIyQ0g5TmlqR3ptc0IrQW1xY0RyQ1VCZVVIQ3VsQURnZGsw?=
 =?utf-8?B?aTFoU1lNaGZESkcvS2pJM204Z2k5RnRYdzFPSzhObDNldVRUTXBVRmo2S3Zy?=
 =?utf-8?B?bWgzdyttZGYvZVBHazdvNVlTbnB6akxKeG9IWmk5K2QzaktPM1BLUllaOFF1?=
 =?utf-8?B?U2hhUG5OQUFocmdHdk9ha1d2SHBDaDBndGRSYXJyVHlEMkwyMXVsM3p6ME44?=
 =?utf-8?B?SlNQdDJOTVhaYzU1d1NNS2o3RGNDVWpCR0xNeVMyS3l0TFVSRHlHY2Z5RStH?=
 =?utf-8?B?YUw1SndVQmt3VzN4V05CZGZIZ3FJZjZFZk5BNUQ4NlN6c3FGL2I3c1ZtK0s4?=
 =?utf-8?B?aTNEUjBsSmpURG00MElZUDJmdVpUTWpkTjdna1lZT1YySlBnZ3pkRGpmY200?=
 =?utf-8?B?WWZzV01IbCtYOW0wcE1zV2ZuK0pXbFk1bTNEOFQra1NUaitkMHc0WnpPNGpy?=
 =?utf-8?B?U0ZUdWppMW1rQkJmT3dwTFpMWVZlUEpLbGozay8rM2FyRk5yRXM1ZnM4cVdS?=
 =?utf-8?B?a3RhWmpEL0hhS3dWOXh5VkxwUytDK1FQT0pJSmp0NjgzQlozcWpyeDNDR2N1?=
 =?utf-8?B?a3lnTDUzaTlZUVA5b0tFekRrdHJ4S1dEcGVIUEp5TVk2TitEdEVyTnhJVEQr?=
 =?utf-8?B?LzhhZUo0TGlJZW1NdU9HUTBrUE40WjExL242R0g1SmJaZWVJOGM1ZVg2UWln?=
 =?utf-8?B?YWZ3bXZrSWQrSkxBaHk4Y2xOZVZZeTYzcStaRUZXTkEremxyYUhzallHY3dE?=
 =?utf-8?B?cTFyTm42ek1qYjVpQ3FzTEdRVFBrazRXazdhV0JhakVFTktRcjdtaTgwZDYy?=
 =?utf-8?B?Z0NHWE1NSzhIMzR0Vm5qeGhhMDBKWmM1T2V2Q3F1VFVBSXJxYUFxVUtCVnM1?=
 =?utf-8?B?WTlPaHZGa2ltS0c3dTArTTVIc1dJczlyWEFiYUxNWkZuSG5Mc1h3RE45VlAy?=
 =?utf-8?B?Rm5TNUlCSlpKQUh2R3RCY09RUXJOQ3FMd3B0ZUNCMjBNWXlLSkVlaXlJb1V5?=
 =?utf-8?B?cXRNeDdONFNlYWtaQ1pNY2FuNUp6RGJsRjJCS1JxWEFFS2w0cmxhTWo4WnBR?=
 =?utf-8?B?TnBuSWhmb21wZHhlNjBFbTdTeVk4RHlLZGRiOTBvZTJYV2RQOW9FbzJoelVa?=
 =?utf-8?B?cDUreFUrMzJxdUNGSXk4SFZVMGNHTmpWQTQ3ckpUNElqai9OM3VEZTlFRjY2?=
 =?utf-8?B?cTdhb2g2L2U5QnRjL29XYUdnOUQ0S0JxR0FlZmZOUkxrQ1pBYVA2UXNQNXF3?=
 =?utf-8?B?ZXIydkhQR1FRS2NiUWNJQ0htT3QxczhibVo3SS8rS0duTUdocVUrU0JLd0M2?=
 =?utf-8?B?QWtPckdiUUVTK2JLKzFTc3BLUDdSM0luckE1cFBVTkZKNnFkR1c3SXUzN1pi?=
 =?utf-8?B?ZS9YS1dVaEVOOXlCSEJMWkJxalF6SlNGWGE0bmg3MldoMzNSNUZnMnNIK051?=
 =?utf-8?Q?J/LQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 06:08:41.8618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b02e6c79-fadd-40a1-36ab-08de16b19c3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF

Hello Shrikanth,

On 10/28/2025 8:35 PM, Shrikanth Hegde wrote:
>> @@ -792,8 +792,11 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>>       rq->clock_task += delta;
>>     #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> 
> Curious to know if there are users/distro which have CONFIG_HAVE_SCHED_AVG_IRQ=n

Some arch such as s390 doesn't select HAVE_IRQ_TIME_ACCOUNTING which
disables IRQ_TIME_ACCOUNTING and HAVE_SCHED_AVG_IRQ.

Checking the Ubuntu 22.04 6.8.0-86-generic config on my machine shows
CONFIG_IRQ_TIME_ACCOUNTING is disabled by default. Same is the case
with 6.14.0-34-generic config on Ubuntu 24.04.

-- 
Thanks and Regards,
Prateek


