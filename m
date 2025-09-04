Return-Path: <linux-kernel+bounces-800276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD80B435B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849721BC58A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B282C11D9;
	Thu,  4 Sep 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qGUj08SO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD002C11D5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974418; cv=fail; b=H58kvOIm9ajuyhkvH3KqZ+5qpEvZLDLRHiVJ6HmNIgnW8GEskJANiSpk75bxiJRkkm1VtbjQkWMgk7suy1zsInNWBWnr9rAwAYr436JrmXKYPopuAb1CnrGgUPR4Wlv9e+b1ppAHaHHnmjDiKH8yfJ5fPTz5r0yDvdL8wVz4BT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974418; c=relaxed/simple;
	bh=EZckEo4QvqTE52dgtPtAqFGxfxtXNBlj6C8BUHK2vI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=npkqYYaD0bIv2Wv4RyAMuASsqzzgl7nj+NBRKwP4t05cKrqVjQhSuTIu1dPPYbRTC1nX8hK4K4GlXAg3Zm1Fx5twxinYmq8xnhEAMLkAg6+oPs6SXEUS4YedxDiFvYcv8pRnT2s4tHsnWHqB6ur5ZiRsMnm4eF430I1J+2AVFvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qGUj08SO; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2UYQ4+WiXyVRG2B5eGbk83NqxfQLO3ZaUEWMGFNVWxqpiokxSC1cBoHGf+ELLRYVs+b8tqsKUiob8D9gDrP8EnHEIRo+GMx0yXcuInDrqgvfp8/8cTxCRJinUOloUgJaX2dgHaAdOXgJYMwrk4mUGFILn2+2WR8RjQWEevQs6tGVRQVEOpJ0N19voqq8SizbNWOrZXlfgZZjvsBT+AtLuUzQqWzJreQfU44C2CVAV0vNQqfYXGVl9dU8bhtjrb/iuACKfo4orkEwRRoi9dXn1TVqvt4nJsNUh9q34xvii2YylxlkN+uNnNTHsxxSS1EghUyV/5VKiF7X7udB9G05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqIzvB9oW5R+xZxbjIzFRrwRVvt1cLKPbfuscKM8aZE=;
 b=oUdwMwZR7pRP2ELZzG08uJD8vYkfKswBSXSCCXHdQjrxTwH6NRQadqJcdLabHux0Ta51ycwR52zxxLSVTAXNJs8vq3KbUdInntG/WlUU1z1xMOcqNqYDclNTiQqT5iV4YnW+wyTAi3SaPOZNBO6vEHVWHDqbAZqgYaYBs15mfZ+tZ0pAzO+UOAFgqnR3BAcvh6yJX1gNFAEnmd+jxe28/3aAr5Fl6I6P1Jj/vibw3tyE5IjDchdNvIzwtj7Ul5fxdj7IMG9CH8gaWi8bykce/laJoFf4HYgS3bjibgHpE1WFhBkoYSZ0a4680xqfTQxUHivcA3eIAuk2xnpXqNg0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=siemens.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqIzvB9oW5R+xZxbjIzFRrwRVvt1cLKPbfuscKM8aZE=;
 b=qGUj08SOaTA5ydKciz7l8Ween55cBCf63MmjxWo5faOlC8B5CBJrx1gXyAMkpjvD3IpxoIbu7t0gbRG7I5BH218VVeMFiv7WOrwFHlslv6klA1Jt0RlBXlz+XcPgdnf3sEsiUP2mZ53dQOz4AlQhGu2Ut3xE3kf8aqbF0mW1Kw0=
Received: from DM5PR07CA0119.namprd07.prod.outlook.com (2603:10b6:4:ae::48) by
 MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:26:53 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:4:ae:cafe::ae) by DM5PR07CA0119.outlook.office365.com
 (2603:10b6:4:ae::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 08:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 08:26:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 03:26:49 -0500
Received: from [10.85.34.65] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 03:26:44 -0500
Message-ID: <91b75418-c836-4098-9f7e-4b287598a1d7@amd.com>
Date: Thu, 4 Sep 2025 13:56:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
To: "Bezdeka, Florian" <florian.bezdeka@siemens.com>, "ziqianlu@bytedance.com"
	<ziqianlu@bytedance.com>
CC: "liusongtang@bytedance.com" <liusongtang@bytedance.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"zhouchuyi@bytedance.com" <zhouchuyi@bytedance.com>, "bigeasy@linutronix.de"
	<bigeasy@linutronix.de>, "mgorman@suse.de" <mgorman@suse.de>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "chengming.zhou@linux.dev"
	<chengming.zhou@linux.dev>, "mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "joshdon@google.com"
	<joshdon@google.com>, "vschneid@redhat.com" <vschneid@redhat.com>,
	"xii@google.com" <xii@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>
References: <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance> <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
 <20250903101102.GB42@bytedance>
 <13467b08-96a6-478d-bb97-060b7d8887e4@amd.com>
 <20250903113551.GC42@bytedance>
 <bb0f7d900a7e50d173ad462c6ed9f64a4b567785.camel@siemens.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bb0f7d900a7e50d173ad462c6ed9f64a4b567785.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbcee9a-d664-43c3-6949-08ddeb8ccd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkczVXBXOVM2amp1VTR1V3k3bWJzYlgycFZoNUhkbHNhMVE4U1B1NU9IM0s3?=
 =?utf-8?B?VzR0enRBejN3UW5BV0N2TFVXcTJJZGxLRktUZCt6bmZmYWFmRnVRM2dTL1RS?=
 =?utf-8?B?VldXaWl6aHFvVzl3ZkpYUEFEa3NObUFJQjQwcCtvOWJ0U1FNeHRMdkhNb1VV?=
 =?utf-8?B?aGk4WXgyeGtsRUFRSmpnZ2EzYm83OHphQzlqYUk5elUwRSswVlI3bFhkYlVs?=
 =?utf-8?B?Y0tuOGxPaVR1TENQTkk4RWZnNHBUcFpPNlNzT21Qb1Y4ck5NaXJJMC95WWVI?=
 =?utf-8?B?Q0V1Y1BQU0F2WU9OM2Zhc3VFZWtJaVM4WWN0ejh0WG0wRkUrblVvd1dLd0Jk?=
 =?utf-8?B?QnRvR1dEL1RNWUZNQnJRT3U0c25LWHRxMzBHdUZZV0UyQWdFRHowUUhERDYz?=
 =?utf-8?B?TkZLQnBNVVkxaWR5aXFtbmhCbVNvemJ1cmxrQVVEU3BxT3hCeG0wZHNuNGhE?=
 =?utf-8?B?VEhWL1ZIcjBFeFZjZG96WjllRTNndGw1Wk9ZMVM3eXBtWmI3S1FSYVd3c0I4?=
 =?utf-8?B?WkNGR2FjT2cyV1ZmRnJkVzhzc0dUMWtOUEVCR1NXaFlKRkduUTJ2QjY3NXZ1?=
 =?utf-8?B?WDY4V0V4VVlKaUpOUHU3RzZGUjNPWnQ5cC9LSHIrd05KSnIyU3M0RmNqTFdF?=
 =?utf-8?B?MFBmRjFEa3JtNTNGVi9kZnFjL3ZUa3pZQkZFUWxUN1FwUU5yajVYVGRYa0ls?=
 =?utf-8?B?ZVppNythSTk0R3ErRDUrZXBkVUxNS0hjaTNjWjh2d1g1aExhM3MvQXhBSW5j?=
 =?utf-8?B?WnpBOW0ybkV6a3RXUXQvYTRhTSsrMVdIaFhrWEpUTlZJM25TYkxJN2MvZzha?=
 =?utf-8?B?c29DM2kySnF6TGJjY3VPbzVmLytyOFNZeUdrcndCS3AzaEx3MElqa1lTVFpI?=
 =?utf-8?B?aExpd3RQS2I4UzRpaTZPdzhGUjRXZmhNLzk4NHpLUjBoZWxCMlc4YUFRQjZW?=
 =?utf-8?B?QVdNTGpsb083VkhIWi9vdkUvOVh5MEhkbFRvNHpmbzhWbk90OHdyb2FmWkpT?=
 =?utf-8?B?NVVmRWdGKzNEMEhzdm52elNaRHpseHJuZmI5WkRsMVpScXVFT2ZZREFKditS?=
 =?utf-8?B?MzZLYUZvQURCWElWa242cHUwem9NQ2ZFZGdQcHVWeTg2RXFsYWJlbnczK0VE?=
 =?utf-8?B?bUw1QjZDSk5oS0tWbU9FYnJVczB5ZU5sYVkyUjlpcEwwY3VUM05GcU8yUGxy?=
 =?utf-8?B?bWthOW14bU1DdWpHSzlRdkxOVGozazBCTjllWW1nVElXck5XZGdZRS8xS1FW?=
 =?utf-8?B?V01sNzVjUXBxK2FhQTZzaEJXUURQeURBNm9pNndZYTk0MDJuMUxYcnV5bG9F?=
 =?utf-8?B?M2dzUncxcWw1d2wyUkZoVHJBckVmVEZlaUt1djdPV29xcVpYN0Vod3JoUTFP?=
 =?utf-8?B?dWkyMVpGbFdabFBvZzBMU2loRzBLUWF4eTAwTC9UcHlkMlNMNmxucWEwYldv?=
 =?utf-8?B?NmhiWklCb3RZVC9qM1hZQjN1Nit3R1FlR0JQUFVWN3FJUExmMXJBcER1QVlk?=
 =?utf-8?B?M3BYSld1dWRTdUYxKy8rdE1nNmZRam5yeWI4MjZtRGYwRXBhRjdPOSs2d1lP?=
 =?utf-8?B?QUpRMmtNZVFnMUJXRTI0ZE50MEtZYzBkOFB2bnpPTmN0ZlY1SEJWNzZzVFdF?=
 =?utf-8?B?cHpKdXZIUXhDclcrd0JsYktYdmdHa3N3YXlwYmxoZDd5MC9zODFYamhtZjE5?=
 =?utf-8?B?d2d4Zks1Szdjc0g3WDhTL1dZend5dFM2U1ZES3IxQ1ZYQ21RMTJFU2ZVYWdV?=
 =?utf-8?B?OGE2djlENmFPK2V0YUtXK0FvNzRXMXlrV0YyZHZzaFhjc3dXREgrY2tRVktJ?=
 =?utf-8?B?L1FNd2ZOZFhGaU4xZXRFb3ZMRk56d3V6NXliV0pRVmF1TXlaTlBGWUdMSTZz?=
 =?utf-8?B?WE5zRS9VMXdEcCtmSlpoT01PVHMvMFE0S0ZXM21aaDlmeFBTeXRmTWVOcFg4?=
 =?utf-8?B?bFVZdGxkODdDZHZNc1VmaXNBNkhvYUVBZUhheDVtVUVKRlExZjE5dlpEVGor?=
 =?utf-8?Q?9hAifXNUMQvCVRMG3FfEQogTFB0Du8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:26:53.0189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbcee9a-d664-43c3-6949-08ddeb8ccd6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

Hello Florian,

On 9/4/2025 1:03 PM, Bezdeka, Florian wrote:
> Hi Aaron,
> 
> On Wed, 2025-09-03 at 19:35 +0800, Aaron Lu wrote:
>>
>>> [..snip..]
>>>>
>>
>> Just want to add that with the above diff applied, I also tested
>> songtang's stress test[0] and Jan's rt deadlock reproducer[1] and didn't
>> see any problem.
> 
> Thanks a lot for taking the reproducer into account. But: To trigger
> PREEMPT_RT needs to be enabled, otherwise the rwlock in the epoll
> infrastructure (that we highly stress) won't sleep. Just to be sure:
> PREEMPT_RT was enabled on your end?

I've too tested this series with Jan's reproducer on PREEMPT_RT and
can confirm no hang was triggered over a full weekend run lasting
more than 72Hrs with Aaron's changes applied on top of v6.16-rc6
based kernel.

> 
>>
>> [0]: https://lore.kernel.org/lkml/20250715072218.GA304@bytedance/
>> [1]: https://lore.kernel.org/all/7483d3ae-5846-4067-b9f7-390a614ba408@siemens.com/

I used the same reproducer from [1] with small modification to
run.sh to periodically move epoll-stall and epoll-stall-writer
to one particular CPU and keep changing this CPU ever minute. 

-- 
Thanks and Regards,
Prateek


