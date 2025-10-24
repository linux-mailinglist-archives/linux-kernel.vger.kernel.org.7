Return-Path: <linux-kernel+bounces-868075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14911C044B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18BE24E3A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4783279DB3;
	Fri, 24 Oct 2025 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="POgetCVj"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470FB274FE8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761278421; cv=fail; b=JOX9VLZna3sNWeXXvTec5k3EaFD6Dp8LuzKexRC1EOkgwdw90/OTGNaKUkDJrDEqbDmurnW1gsvkWqpFytjmSXbJBsBV/Z5ApFGgb6Edkb5OucjT/oj47f5FBvhX9wgDFvlTIp/Md49dgYkWjMscpScecvJqdRhFCM0w79fhTHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761278421; c=relaxed/simple;
	bh=3jrvSR/A1WYZAZCm7KzmM5PlQ1PoXFgrYJOIBfz/rvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cFRo6pNXrQ79OGfW4Yu+5udPCdxoLj5ncs4JcHEOQcVZWfaDAN3r8XuMm++sVSadPpMMCV2Drf29zP6WKx4e6lwnr9ius5+E8Nmt1E1XSFCAmkFyVLAI+voK4KviXvH8gajEuGE3TR0c/iM/iuvVgJWJ/6qyCSnA5eipfdTuB/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=POgetCVj; arc=fail smtp.client-ip=52.101.61.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc1ADsUzfX28ON5HWcNj0FmW+dGInp3dcYMEjtbVI1lJzHlL54VEt/0N1KOlZGFWJPT9xdCcLUX5fPzrJCmYBuM4L6F7ZgTrUeI4sTYnuVgPvZV93ZYN39y7//L51/WftPjLmuc729KNF1ecQrldvjXNTtdLSQMp+vrr9T/PZ2UaiX+jpY+Bc8yb16GM+HF5EywtSgwf+woO6nS8LmXOooz6hrhpmfE5r9zhw3oRRG9mwV3QJOzFKa2Gzt8x8+wS7qZL/n5y7brosw0m3zI2DYQwpY55Fc2BjDg0/bqCvoVPQzBp2QCYXbxYFuO4GNeRdxr9bOEizFWxCeSzUNZxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adyzwE05n2AZXe026ytqdSt7BuJTUfcblt5oksk6zXI=;
 b=VBBSHy0JxrxiLrRVpDEIpabl3PdljCN+rot/ciqJZwe27tXZaarrmnohlxMlwH/cWxvUqhAtMaHql2q/MT+6PIRmW8rNannGEdSq3eTCiiEGrczzugg+taAQ0739+FjHZfQXVR+u8KTBImR4SvzOgT4lxP0WbgXe+yGUNq+LAnD5ybQIyunZw+HZkLV1/eHlKyVza1bFBqWmy5kIapqNbn51+Dgq8603FQnBrCI8eB+AXv7kkVNyZYFjmh525WC+6fo/JwwZrNoLCgQt7UZ54b9J2GFeAWewBgV4MqDAfMokT/wqGV18EbDd7k4N/RU7kufz+xyNV5ytbgNESQHWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adyzwE05n2AZXe026ytqdSt7BuJTUfcblt5oksk6zXI=;
 b=POgetCVjDC1GrR3pZQSCiKKRlHuFf5RadDZyH9VhhEntT+yN91p21xhlAzRzOW1X0OwXJUXIsDDd6CKu+BV4vibUrV8jKZ9g4aQX0x1qjqqJYTKGC4obVhVk0103TzQdFz9POMG14xiscZuwmyWzhRJcV6gIMj5vjZ2WxfPTk5M=
Received: from BYAPR06CA0032.namprd06.prod.outlook.com (2603:10b6:a03:d4::45)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 04:00:14 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::5) by BYAPR06CA0032.outlook.office365.com
 (2603:10b6:a03:d4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 04:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 04:00:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 23 Oct
 2025 21:00:07 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 23 Oct
 2025 23:00:07 -0500
Received: from [10.85.36.188] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Oct 2025 21:00:04 -0700
Message-ID: <1fa78304-b194-4d34-888a-c387859ef72d@amd.com>
Date: Fri, 24 Oct 2025 09:30:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sched: update_entity_lag does not handle corner case with task in
 PI chain
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Shizhao Chen <shichen@redhat.com>,
	<linux-kernel@vger.kernel.org>, Omar Sandoval <osandov@fb.com>, Xuewen Yan
	<xuewen.yan@unisoc.com>
References: <aPN7XBJbGhdWJDb2@uudg.org>
 <20251018195730.GJ3419281@noisy.programming.kicks-ass.net>
 <c10f6fda-aa8c-4d8e-a315-3c084af08862@amd.com> <aPgm6KvDx5Os2oJS@uudg.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <aPgm6KvDx5Os2oJS@uudg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f10aa79-3c8a-4dcb-203e-08de12b1d520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmVMRmhYdlRtUnZjT0dDY251RzFFQ0ZhTk5yazYrZGx4b1U4Qytub0phSklQ?=
 =?utf-8?B?OElidVgwVXBUNjB6cWtmSHJLN2lQNkZSVktWSDYvaUNDZ3YvYUdkcDJHd0JW?=
 =?utf-8?B?ZkdtTTg3WHRDcGJTb3NNQ1NCdHVnaWFOVEFPV3Ura2JlRjBqb1czMkVlVzNH?=
 =?utf-8?B?cUk2SXVSVTlsRDRMOGRhc1NMdmtXaGR3NkhxSUdxcjJWVnA0NE9KcmUySFk5?=
 =?utf-8?B?MmxCZldsQS9RYkJ2N3VJemJLU20rRE9ZTExGdEFMbjVSdk4reE8yc1hkYmFN?=
 =?utf-8?B?QXJ4VDdRN3p5RnU3aHp2RkcxbWl4REhyZW00QndNaVI2dUJvVWovS2NzMEM3?=
 =?utf-8?B?Y0NQeFUraVRFNkZHQTFlWWFBMEN0WXhzSldoYTFra0l3OUV6cEd2djJ6ZWZ5?=
 =?utf-8?B?MVNyNEF3dVZCTVIwSzh4ZjBXcTJLR2VDTEo5YzltVzZqV1ZOMTgwNHc2em00?=
 =?utf-8?B?UGhKRC9tZTNtb1Jkb3huUXdVVU9qQStncGtMa1pJZjkwZEVUYzh4SUNQS1k3?=
 =?utf-8?B?YTZLWG5XaUlYTlVtOE1hV0FKUlVTNkZrc1ZqMGlxOFVmaXBSdUdlejhIK1NP?=
 =?utf-8?B?SU1lUE5FL04yZTFydkFkWDhFeWFMMG5JRGVvTEd0WTArMFJVcmpWOHhRYm9p?=
 =?utf-8?B?cTRrTDd6dmQ4WDE1S0ZFNWJMR2N2VGZIanlQSmJWejRkbStwd3Q0Qm8reGhX?=
 =?utf-8?B?cG9UeWhSM3ZLQ1JHaVZ4V3NNdDlzQzhNT3E0UllLWlBVK1dZWEpOVTdUVk11?=
 =?utf-8?B?aHRLV3NicFNmZEtqcDRGRng2NXROaW5jTmd0eGg5NGNTSnFWbWR6aWFld2xY?=
 =?utf-8?B?YmpNVWxpRFNzakhKb1I3c2p5a3B5TXpWVWF5d01oTVNPR1k4Qmw3SUNkT0dJ?=
 =?utf-8?B?dDRWYkFLQzBnRkZUWG9SQ2UxZ2ZRUlNXRnd3Tm9aZlEwSjg0Yit5SWh5ZzVt?=
 =?utf-8?B?R01CVlBneXJUWHhVZnlaT3dQS2NadG1QT1pPOGk1VFF2V2p5NGYxYVhLVUJG?=
 =?utf-8?B?WEUwbE5CZVZVWU5xZW1wRWlXSkV2MjBENWNnSXJXWEFHT2ZQaFZQOHIzU2Jn?=
 =?utf-8?B?eUlPN1p2djF0TGZPYVRYaFJpdnl2MXNyS09rY0ZVZGFDc05JZXdnUlFvaWd3?=
 =?utf-8?B?L2hxNGZkd1BXSkhxYStjekdnUXR4YlVpME15N1crZmdYMG5scE5sMURMVm82?=
 =?utf-8?B?YkhnSHdiT0xlUlVGRlVESytENk8rbjhUSlcrREFqcTBLMHBUOWJuTWxYYVY2?=
 =?utf-8?B?alRHUXJ3Z2dKN0dzcFZMWDRQcG1BZ1dURWRhUWIyaFN6T0JRV1NNNTVuT2Vj?=
 =?utf-8?B?Ny9vNlRGR3ZPdE14SUR6Y3gvK1piRCtYcmJPUmhJaHdHRC9HcllIZzJSVjdF?=
 =?utf-8?B?ZlRDR0dXaTNBVjdIcmhzQ21aYU8xd0c4OFBCUHM0KzM5UEVxUFZFNXNoRktN?=
 =?utf-8?B?dTFKYkVNejhHSmVwM0pyWDI4bjJYaUlTWmFtRVJ3QiszaXl4ZTFDTy9YSjQ5?=
 =?utf-8?B?T1YweSt5TVp0eS8wMVV2RVhXS3ZrdkdiYm5aV3JQU0VNZEt3NkJ4dlkyRmor?=
 =?utf-8?B?VmtTZGlPQ2UzNENTVE5wNmdyS3RUR0EyQVgrM3MzcFRYTGlSR2lrUUt6Um0z?=
 =?utf-8?B?bXRHWTJQSXMydWo4NWpkeUU2SzB5NFdISG9MTUN4ZTJNWWdEU1p4bHR2YThh?=
 =?utf-8?B?YzkxeEF0SkgxcUZ6d0wvOEl2Zy8rTVEzbkUvK1RQbDV5UXA3TWRaWEVOUjdM?=
 =?utf-8?B?UUlIV2RqSWdSbVM0dzhYbTI1WFR0QTVzejdsVksrVGdhcUUxcFYrTmxPd202?=
 =?utf-8?B?ZEhBditCWFNLQ3ZqUGhtK241RmR4VzAvOFRHeHV2RjBrd1VwNHBDZUJlV2tL?=
 =?utf-8?B?bzdVbUZMSjNLalFVbEVUblg1WE1saW9zZXp0R3FtK0JsalVBcG1sUnVrVDd0?=
 =?utf-8?B?YjFHajZxOHZHcThzWm9wNzNyS1ZJK3AySW0zSHlxZEJtSWMzOFZXcVd4cUdy?=
 =?utf-8?B?anlFQjkwUllmM1JpZGRGU1g5UE5SZlA1L1N1WFFtYzNFeHpTSTZIV1o1MXR1?=
 =?utf-8?B?RUhIWEQ0MCtFSmJkOTZSRG5BaGMvU05HdDBGdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 04:00:12.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f10aa79-3c8a-4dcb-203e-08de12b1d520
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

Hello Luis,

On 10/22/2025 6:05 AM, Luis Claudio R. Goncalves wrote:
>> v6.18 kernels will get rid of this issue as a part of per-task throttle
>> feature and stable should pick up the fix for same on the thread soon. 
> 
> Thank you! You were right, your patch in that thread seems to have fixed
> the issue I reported.
> 
> I read the thread you mentioned, built a test kernel with the patch and have
> been running tests for more than 6h now without a single backtrace. As reported
> earlier, I was able to hit the bug within 15 minutes without the patch.

Thank you for confirming! Greg has picked the patches for both
v6.17 stable and v6.12 stable so the upcoming stable releases and the
RT releases based on them should solve this issues. Thank you again
for testing the fix.

-- 
Thanks and Regards,
Prateek


