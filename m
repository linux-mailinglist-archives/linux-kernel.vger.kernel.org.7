Return-Path: <linux-kernel+bounces-800991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC2B43E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089394840E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F63054D5;
	Thu,  4 Sep 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lLr9asK4"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014772D542A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995670; cv=fail; b=etgNUJsxovE1ZRIFR5mXkfn9tTRsv1xldTDG+3w91aBVaC/Jv9xL9olTxXONwrw3APjv3Ki7QvO9qR41UrU+Wreh9Zauh7jCmXKyVKfSAakp73qmWoVb3yFSv48JIGRGTk9+ZQ5KoYeECjftPmNu2AB99ZxoElWX+vVwE6uQu58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995670; c=relaxed/simple;
	bh=g8dpe1ijw6D+/DxWqrxhAzYASP8HG6gRzMo/i+nMMuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QRLUqM1v0a7iDbFmrewCnMdNEmUdtUpGpodgedCyvZ52p8kTU6+rKEJw/OhjJuJXrNzb4cZQP1X6qpEPBRsTsgOCms5X0Mv6c18xPvyWsaZHgiy3zL8s70f3ZDlVcok4b8oHaReE0IQnNmVR8c4zSorBCkntg997uz0MXJORhXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lLr9asK4; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmk3cAVNQNRgcag0FVZu1CI12LYMR7FIznMyY1sN86wSAwWnGNXSKfIrw3CFAsNmka+4X4vMX+VzitYr66kXIMeJmrzfeyQ7SXHOdJfXuksAtNgkt9SjCUYw9ofbKAXH2tD7xOtkvtDcBIf1vPpFbd4j2Y/cF1k9ukC9aancs9R/jTarPNq3b+BblFCy+ozbZmTJVTduyYofWfA3NJt7+LY6Y9TVdWMf7npKa4Z/3AYIeaB08yiEDvUxgmxchVp9l7pq/NGxLXzJlJgJujnG6OrLbdHCXbx4vRoU2N5GSjhZh9/zltwaPWsz8it7SlvlaguG95tRS2tzr3+deWw3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzll1Y0iNgfP1ib6E/aFAcNgi05D5x6pzMU1eKKEqUo=;
 b=eSoiAPQHS8FnZKzs9vM/z91jgW2EHDdh9GULe5iOorXwvm7NluSNUlj/m3PBFR9FIw5II41JWiOa7ttiMb1PWlcncFdiF8zEmwM6T1xIwr5mm1oieIHSx9MQFmzfSZTDMeOFakppQ/VKCn8Vh2ZWgv5rX8zClu3VhifxsAR0TebPsF29uhgA0pNVI8jlgDTmAOcb7qn8rx2qpa/s4X5V+GrQJ34DhYv+bGIvKPFOoQyMx1cXOvDiOgdVmEbpPcuIMTxXhuthe/Y8WMXw5PhRMQVqxnsKLb71fNtZSAh9o8ROhnH44+SHdBObRo6dI5/Rv6iI+WT3CKJpq7ah1x0Kfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bytedance.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzll1Y0iNgfP1ib6E/aFAcNgi05D5x6pzMU1eKKEqUo=;
 b=lLr9asK4cxTFdvaRB9xKAVIxYMPppRsC6hLEaGsIVLPYkVLfpgM4tIkfml/q3bZRYLa0G3af6al+oqIq5M+PfjP5JRuSSlRaulTX+4ltNID5nahrXtxp5Vzy1FkjDYoIVNZlyjjR7Scza6SBfrcaA1LDJVATerhjM8g6NYEiZ54=
Received: from DM6PR11CA0048.namprd11.prod.outlook.com (2603:10b6:5:14c::25)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 14:21:05 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::1f) by DM6PR11CA0048.outlook.office365.com
 (2603:10b6:5:14c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Thu,
 4 Sep 2025 14:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 14:21:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 09:21:01 -0500
Received: from [10.252.75.84] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 09:20:52 -0500
Message-ID: <3eec5c30-ff65-47c2-9eb9-308fff63b0c9@amd.com>
Date: Thu, 4 Sep 2025 19:50:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
To: Aaron Lu <ziqianlu@bytedance.com>
CC: Benjamin Segall <bsegall@google.com>, Peter Zijlstra
	<peterz@infradead.org>, Valentin Schneider <vschneid@redhat.com>, Chengming
 Zhou <chengming.zhou@linux.dev>, Josh Don <joshdon@google.com>, Ingo Molnar
	<mingo@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Xi Wang
	<xii@google.com>, <linux-kernel@vger.kernel.org>, Juri Lelli
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
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com> <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
 <da9141b1-d717-493f-939f-85e23d46e7ba@amd.com>
 <20250904110504.GG42@bytedance>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250904110504.GG42@bytedance>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 1484fad5-3444-4d3f-73bc-08ddebbe47ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzUwV2Jwc05EWU5rbDhia3dWc1g2Tkt0ZUFKMjR6VkVzV2pQaFd1L1U5VGxE?=
 =?utf-8?B?RVdUVWl5bXlEZG91Z25FcjU4ekFQTGtndTR5dnBhK2tsRW53b1plbm9pWnlK?=
 =?utf-8?B?VGV3VVVQOHltYVQzd3V5VjhCdWl2RSsrUUxwREhQeFhPcWV1ci93K2p5WkZY?=
 =?utf-8?B?dXFGTm02RmYrbDgyZkJwQjE3SDdJcllKa0JCb2N0MVlsQkNuTkxsR1pKT3U0?=
 =?utf-8?B?NzA4dzJMaWVnWlZlMnozdVdSMFFuaGRoZnorS2FaT1lKamRjSDdZSlRSSHFl?=
 =?utf-8?B?S2FvS0ozWUZYOVVPZTJxRW1WbWNPcFJ6OUZPK0Yyb08wbDlOTjFsa0pBOGdm?=
 =?utf-8?B?TmdoamNUT1ZnTTIxSUVHLy9xWkNSdjJDRXhWdm4rZUxpS0hUVjJUeTZLVzEy?=
 =?utf-8?B?VUhYTERkVDBYWjBBYWorUUxjbjZWanhYVGx4MTVyUVZjUnhtWk9ldEg3ZkJJ?=
 =?utf-8?B?TUplK2p4WjY2YS8yeThCYUNoMWdJUTc2bDVPeVovdjBmT1ZOVjNLUElZUmtT?=
 =?utf-8?B?TGQ3WEFvMm1zK2ZVcERPVDlDTmtwWFd0ZVNmamw4NEcvMXNaVU5aY09KTDVB?=
 =?utf-8?B?U0NMV2NySHlTWmlWU1ZDRzdrdG9Fcm8wY2cwZ2hKZU44Y2ttZm5SWHQ4UnlS?=
 =?utf-8?B?dXhDT3dNNkx3MjFYYTF1YzdDbGRwc0duWGNnaGViRE9vU1ZnRjAvdUN6VmVU?=
 =?utf-8?B?OWJWS2x6OWJIbGxWK1FmdytZWUE3RUxWTS9HRXl6cisrM2xSbis0QVRVNWN0?=
 =?utf-8?B?WHdsaVp3YTBMNzE4aEhGaFJNTkpML2d1eHUyMlAwVExTUkE0YVBZaUtqWDE0?=
 =?utf-8?B?WU5tZEFnd1d0NFU2Y2JmR0F0UnVEUU5Jc1grc0NpN3NKWUFKb2NvL2dvYnlj?=
 =?utf-8?B?NlhOUFdCa0I1a1dWUlFOdENpQlVqdGprVDRCRGJjcjcwdVBTbFVOQzNrbGxy?=
 =?utf-8?B?a3Q3dVd6MFh6emxrbTkwSHUxUloyd21vYXBFUysxbFoyMnFlMDREbDRRNmNH?=
 =?utf-8?B?K2NEejhBc1JpRVU2ZS9kZkZKamduQ1BzQkloNlJQa1l4SnBTa3VoZjhOVjUr?=
 =?utf-8?B?TS9rZVdYUGdiL0FkT3FPZVRCMXdwV3ZDOTgvS01sVjRWS0NXU3B5VU83am1C?=
 =?utf-8?B?SlNLY1lqZTdCdzVaS2ppUm4yTERzZHY4RC81WEg4SDUyQnVmeHlsa2poWGYv?=
 =?utf-8?B?b05nL3ArbDdIS0tLMWhKRmxWTHRZUytncXBZN0h6K2VGdnlvM1RoandzcmQ4?=
 =?utf-8?B?WkNDYWxUWHIvbjk4Y3hpQm5YM1E5dWJtWDRJMldNSFhjZzNnMmxjY3YzeEQx?=
 =?utf-8?B?bnBvQjRHR2czeXhIdUdiSkJxRXRtTXpwdHgzMG5PT2I4V0VrakQvU0h5SUZG?=
 =?utf-8?B?Y09IT0d5cnQ1QUVjbHlZd0Z0dllabWZ0eU9lU3Ara3p6U1hZZDhyMXY1TGVr?=
 =?utf-8?B?UFFOa0R6RDJjUEdxeGxHQzZoMDNHcEdaZGRXTjhaclBCdjdIRGpJZnBXemU5?=
 =?utf-8?B?Tm5XNjJEUHFyUnp4MDVCVkpUWTBEWVRPbnRxRzdTTjQzc0l6QVNIZHNTczhx?=
 =?utf-8?B?dElFT2ZmbDM0TzJaVjlRTDRYaHgwRzFQaCtPTnFPMHFBck5HTkFtMUljeXJh?=
 =?utf-8?B?ZXFSOG9lODNzczVpUEtQRlBYUzZMTXhEb1VRL0g4UTl4bzZlRStMUStCMzJ0?=
 =?utf-8?B?UHNzS3J5czQ1WVhTQjYzN2R5WitxTUplS2c5ZHRPb2wvNFU3TzJjRSsvWVdS?=
 =?utf-8?B?NWZ3T3hUbXQzVjlBOFRVMnhUMzlPeTRKSlgzL0tuS05xMHlTaWhGdDcyRzBM?=
 =?utf-8?B?MW9nYUtCaGtWQWNJS3A4SmN2VThZR01jdkY5cHJmTFVHNHZUcGJqNUppWU5n?=
 =?utf-8?B?YWtuTzZNbnIxbHJmblR0aGFLdnlhZjUvUWx1SnM0elVoTHNmV3RkTTVyT2Vu?=
 =?utf-8?B?cEZybnRNaE13UU1rRjB3aFZtNGdORXJrNGpBVnNVcVA2WnBZQnYvVlFrOEZR?=
 =?utf-8?B?a3JUOEZkMXJRLzhpZUJyUnY2Qi9uMkRGb2NvS0pNNUZHTm1KTXZnVVc3NEY2?=
 =?utf-8?Q?uGQlGy?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:21:03.4652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1484fad5-3444-4d3f-73bc-08ddebbe47ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

On 9/4/2025 4:35 PM, Aaron Lu wrote:
> Ah right. I didn't realize wakeup_preempt() can be called for a throttled
> task, I think it is not expected. What about forbid that :)
> (not tested in anyway, just to show the idea and get feedback)

Ack! Prevention is better than cure ;-)

-- 
Thanks and Regards,
Prateek


