Return-Path: <linux-kernel+bounces-892331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89452C44DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7233A6726
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF128C864;
	Mon, 10 Nov 2025 03:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l4pvAM0Y"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441428A72F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762747132; cv=fail; b=f/8EX6TVvYCZ1lvKz7XkFhwwV2nG5QwdE8HH5cbozYQK/ZCjy/4nRBJ0+1BnFDDLwgOcZ6wgxtcAnOTIbLePvbYybg5z9nIPpCXhIbqO24uchdmmfXrftwrcSp0T1USlhdKNi2pSxaY5aoWMqq5vslO7CbSeugta0dsD16ojnTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762747132; c=relaxed/simple;
	bh=6aylg+5ruWC7S+EnbHkg/04cDuqt2DL0frOUmD+LuKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QApzUHUZuXd45K2ca7ALOcMLavB+dc9c2GwqQFtaXmqDS/PPLJr9a9ZAJT1DVxsOSVabOKZyYFGtcw/kl8HV9VM1iVaRaoIWsExcc0W8vHRcVAoYhF+k+a9UPRVWMnjz6k7Xf9kYqB7oVRM4zk4rF/uZR6uVoUhgchX4/wcLoCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l4pvAM0Y; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7hwo5UXJpBpUULjICcOEavGal7TXR1Cq+AtJuhKEAR3Snq23qCs1NT0Q/q2GusYCLOfrgbP9okWFzSZuTBMIqUYbqKJo15+nFHY0oPsykLzKAgRIArsId7XO+oKsmbPEyCImHxqIRe3tosg2ALNXquTtLz9IXJU9q1TFXba8Y9xL+1Ox39ZvX/kXDHXjmU05L4q00PXfctADSOPBpXcBbaH2bGNx2fvHOL2KM3JbOT9IqePtpdTNP8Ry+EgjCzeCz0+4XrJrjWVCRu4H9DrO9h2ia448DFqXEAgkyiYoog9C4FZ3boJ2cLSVJkdM3IkXydpbogldU77BIU7ogXIGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Zfi4V8poG1bE9n2IGnh/hBXbObI5ERsnyqGHY5V39k=;
 b=A1kN5WxflfTFiz154kmu8r6FrxKG81UQrVxJt8W52TEk1269JW0Dbes2pFvWtXVkckAsxxyMEFvuuX6TkiSd4FzuIbDhw6/nf1pt6fvZ6rbSJsVdI/3l+XGgwLCVYaWg84ApzudkwhKHhylNnJZea6kT5sQtfcEMDB6jzqBygCR+ZCTS/e5wg/yvdyxhnSqvsaoOgcqJkzWB9xijf48lZpi43MY8xuJUcjeKpPY2nR8oQG58poA4beLBWt4AG6BAVC6bN7iuZ96cyLwy/vShafgB5ZQBJEZtt8P48jONPqaqYcmbKjeoEpUkGWrLJp8OlXuw1wjM8yx8oY7QzMJzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zfi4V8poG1bE9n2IGnh/hBXbObI5ERsnyqGHY5V39k=;
 b=l4pvAM0Y1NQtnCFUjyOHVo/veNQULMY1pti15ELEg2JDYOoeOeISGn2AesyVABxJAVghBqubJmenI+/UBSw73tGsUGAc7kqNQcJEXyBiO3/IytrbfqQfeDp3sY5T5LbXAAcLU/1WdH9hU/VZZNWiL/XV2rJKa1fyKzUAAZ1EP+s=
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:58:47 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::56) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 03:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 03:58:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 9 Nov
 2025 19:58:46 -0800
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 9 Nov 2025 19:58:43 -0800
Message-ID: <df068896-82f9-458d-8fff-5a2f654e8ffd@amd.com>
Date: Mon, 10 Nov 2025 09:28:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>, Doug Nelson
	<doug.nelson@intel.com>, Mohini Narkhede <mohini.narkhede@intel.com>,
	<linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
References: <52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
 <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
 <2edf1a85-4736-4e8b-bfc9-003dd1f34be7@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2edf1a85-4736-4e8b-bfc9-003dd1f34be7@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: f62a24ea-dec3-4c83-a4b4-08de200d7335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1U1ZlNnRVU4SnV4NzZnOUUrV0xzYnkxYWtwYkFDb2hFSjZLd0VlWDhHcmhS?=
 =?utf-8?B?UGhhbFRUMXhEQzRqYlRldU1FRGdWeXlHMVZCTVdJWS9NdFhOMDhKbFpDQWc1?=
 =?utf-8?B?QWxOem8rZ2RybFpXY08wR0QvWHhqWUFQYjV5KzNWYWk0Q2J5aU9ici9MM3FE?=
 =?utf-8?B?ZUw0OGtsNkV3QlZSeGVGdytuRENxck1uSmNsZ0hKdzB2cTZXUE85RSsvYTcz?=
 =?utf-8?B?WHJHSWpPSWszOXI1b0c5RU5hYkdsNm93amovZ1RVSGlTY2s4VWUwVDhwKzE2?=
 =?utf-8?B?UnNzVFlUdEVvOFZBTUhuVHh1T1RqbnNJSGpyRGFIa0VWQTkxZllLYU5sWkQ4?=
 =?utf-8?B?TWJCZmhzUXBKZUNZYUNTYnN6eStXODdMbmhVSGpFeHlhalZkYjdHMWhObW55?=
 =?utf-8?B?T1F2MER3UStpZXJ3cmczTVVHdXBraHE4djNwTlgzanowd3VpWFlIQ1lrZzd1?=
 =?utf-8?B?cXd3Unh4UkNqWkdDaDdYMkFvUzhqbzl4WXZVQWtmejBVcjRGZDhBa3kza1Fj?=
 =?utf-8?B?SXBnTEwzR2F0aHB2K3VxdHlrMG1jR2ZicU9kZ3NFMFQ4TWg5UUw3aUdORUwz?=
 =?utf-8?B?cnRzSGxyQ3JKRlFsR0Vub0x0UWN0T3pxZDdYdUc3UHhmd0pyZzBma2ZwKzZ3?=
 =?utf-8?B?OEx1cEJWN3ZWRlJWZUZNSzJkeFRQZXdWTWNrUEFyVTFwaWRxT1RUYmtLSm5z?=
 =?utf-8?B?R2d2YmxpaXJPZEtsWWMzVzdiTUJHSWZiSEMyMisxRjI4Wnl6ODE4MmVZaWh0?=
 =?utf-8?B?cURaVWloU01NR0czVm5qYm93SE9XODA1VThzR3RSYXN5eEhwQmo3QTRpa2I1?=
 =?utf-8?B?R0NtTzFOakRoREQ3S0pGclE5RDk5Yy9aYW5vTHhwYzExRWtROG82c0V3NUhG?=
 =?utf-8?B?QUZlb1JUc3MxS3V1aVVsTUFDdytEQ3orem9ES05xUkdWYjZXczhBcm93eVNo?=
 =?utf-8?B?bVlnZ0ZEbDVaVEt6QmMrRXR3TWVPVlZjWGkweVdNK01mb2NseHNvcmhkOEIw?=
 =?utf-8?B?RW5SZmpYMzIwLzJVd2hKeWY4SnhQVjlpd253cWYrZTBjWVRYMEUzVGtDZzkz?=
 =?utf-8?B?bWJ6dUsxTW5IaVdsaGNVa0FUci9iRlowUFphS2lNcmVWM0NwaUhoNG93amsx?=
 =?utf-8?B?YXpEbjJVRHc4b1FkTkVVSDA4bVI1MzlmUmRwTTBscWhYdlhlaUFCUjNSRXhy?=
 =?utf-8?B?eEJZMkxSSTVGaG1UbDFVLzlWM04raXhEdWl4MC9veDVOWmthekErdlFndTk1?=
 =?utf-8?B?QWdjbXQyb3NWWGtNQjU0aWcwYWxIeW9Xd0JHdDk0MzRFa0dCSG0vd0lFYWlI?=
 =?utf-8?B?RW1ndTdHOXJ6R2JjNjVTYkNYb1RHV09sMTNoWUlkV29SbUZSS3lhWnRMZW1u?=
 =?utf-8?B?UWVCbnBsL0hrLzB2aUk2SDFuRUdlNnMrS3grMnRqOE1pOTRCWEdSMnRVYlk1?=
 =?utf-8?B?Tng0ZnhaeU5oeWxBNnQvb3V4NVFxQThMUFBseW40WHo2QzZPQ2oxU3JmS2hN?=
 =?utf-8?B?MTFHeWRvNEpUVm5TYURWTWRBdE1kM1NpQksvSFVCb0szZ1RFOUJxZU5ObDcv?=
 =?utf-8?B?N1pkK0pCWFQveGFWbkFZdkRvWDRlYmlnYUhjWVlwUXVHcEJNY2N0dzF0L0ZQ?=
 =?utf-8?B?T2NHUkV4QUdwbGdUOGZNZ0hvVC9haitYUHZscFRKVGJoektrUmE1OC9tVTZk?=
 =?utf-8?B?MDBTN3RxcjdqSG92UTNidUhqTURWakhwSThkYWRwb0VTV01IanhQTXNHTjkw?=
 =?utf-8?B?eEwxQjNXWXRJS0VCcVFTaWZyKytrZG8wWTBjL3ExSkZCeW1qS1VTUTAvWjk5?=
 =?utf-8?B?THlqNkthNEgzVEVDSXBEbjl1ZjhwcUY0YXNydklIK0pqNXVpSCswMThNZERr?=
 =?utf-8?B?MDlUN3lBcWNKRWxlRnZHVmZETm56OTNRUm10SnhmT25WNU1rRXZMWGxnRFdn?=
 =?utf-8?B?blMvVE9wbzNVTUVKdHdCdndxRU5WRkNCSXNDRlU5SFhPTWxtdkJ3QmJQTnBa?=
 =?utf-8?B?MlI2aDluamtvZnJ4RlN5S3VHNzUwQlA5eXZUd1hEeHA1WG9MdWVQNStRelFM?=
 =?utf-8?B?V2hzTXA1eVZYQVRNL2twL3BhMUVpMjZ6SjN3cmViUngzV2wzdStoWDd5UmNY?=
 =?utf-8?Q?IAVM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 03:58:47.1404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62a24ea-dec3-4c83-a4b4-08de200d7335
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

Hello Shrikanth,

On 11/7/2025 2:27 PM, Shrikanth Hegde wrote:
>>>   @@ -11768,6 +11784,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>           goto out_balanced;
>>>       }
>>>   +    if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> 
> Can you also try removing "idle != CPU_NEWLY_IDLE" and see the workload behavior?
> If workloads don't observe regression, it might be worth serializing it too.

P.S. In one of my previous testing, I had tested only serialized for
!env.idle (__CPU_NOT_IDLE) and I didn't spot any difference in my
benchmark runs compared to always serializing.

I believe the "max_newidle_lb_cost" along with the plethora of
need_resched() checks we have help bail out of newidle balance if
there is a wakeup on the same CPU.

Idle balance too was okay with a greater number of search. If the
first CPU of group fails to pull any task and remains idle, all
the other idle CPUs simply bail out at should_we_balance() which
is probably why there was no difference in the set of benchmarks I
tested.

Serializing all shouldn't make it any worse that what we have now
so I don't mind either.

-- 
Thanks and Regards,
Prateek


