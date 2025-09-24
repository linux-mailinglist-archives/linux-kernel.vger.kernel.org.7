Return-Path: <linux-kernel+bounces-829918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85618B98317
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 06:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783BE1B21260
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63A91FFC48;
	Wed, 24 Sep 2025 04:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m0vDuDMF"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB84C85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758687703; cv=fail; b=IDlqb98NSUQiI0a/4LSau2kShVOIA+Ew/2qiy5hBevbb3rwJP2Y98/V4HVH35xWsdXD8Om0sfb5e6dneizHZgwxm903zXYvg2nhJ9vq3+sebKdJxjA2BfCqs2WUvl80CpndMpcdPFr84FOpHXiXwSrgLe/HbmmTiFzCv9d9MrmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758687703; c=relaxed/simple;
	bh=GwF6YfRAj0H8l5RBRjt988Q7HGj3qyuqwQ76pz1FtHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YrcWYgXJyrieaHjMOHsI337aOcigsSGfeJdTwFZY0BeSTF/ccRYXVq5ar+4F8znNkMg3jDsHGeEKWdc0alaNenLEdoOnI1eGHvjsKjxHEKlBMmRgRrBwIhb8Eryk99nDgEJG7+jdRQ6H8jMFqFioNszMTv8YkmNa5UJ4Zb0IP5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m0vDuDMF; arc=fail smtp.client-ip=52.101.62.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4vCRZZOe3WYweeYTj31BpnXvH8fm6iMkfQZvKEnZ9HnQSoR+xKxxsm0rjjeyhkWQeQQ59qCOixud09kLVA7rmNKm6FBX8t85MpfxITG4vI8Th8NDTfOkdcbibTLR0nxICNSFqjf0ElUN+yjS6oIfg+lSly2NrAtJMWmoaRgRV3glSydSplOH20qLAOs2RPMUTBBYHrBUS+C+r5BOQi7vc/uotnkrjuA95PaLcv5HV2LNkevwRsrh1LWnDABclo6LWDut4Eqt0c7ThM0AocGNgrt1w2aIqTRQUsAgdoqdjKMWQbZoP6fHHoyBOcWQlp9YHMohpEIx+F8pX8GhJf7eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/IhMfN98hh/mDRA6wug1wbKKJeKppL7WZkp11+8nEI=;
 b=aJTBo7S6fac9cofIH2GiLxZp2o1ikElvZA9Pprj9KwJW0b52r3N4nJPSwsVrXeaxY72v0OnTHodC+ffYlpGfnHy8yJpAwG7qzwFkNPTBuafs4u0Es06dwBEdCwM+TLPSSOkq7YZhaOKyCa0EEjU4/E2i6bLVWv8n4r7N6dmDZVmsgkqtSAGVwDZS67frK/JUKpjck5iKkb0EKdstIrZhQ0AzF5SS7tuHeQUmB8iYZeBRkAJm47xZoEkra8COkzHtpAjX5IQZf41xvmDcGGPiSGcWwletA8zv5Ekpvo56Rg6O9ZDQL7vKY4UFHZ1XS0UdxF2ZlEiQMNaQRrjR32Rutw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/IhMfN98hh/mDRA6wug1wbKKJeKppL7WZkp11+8nEI=;
 b=m0vDuDMFZHXhtGNjBKF/Cyb6/aKFP32g+DLHdihjy5FUjnXWooABLj0xSJMoopHsdva1ccSze0n8kjlitz7ChFaNIQci3bxKf0wa7NbE2Rt+ZlL+Tm9ik5iWqtBg9ezK6jV9lJ87HSkHnJg86/OxDShciAknTUFHSbFlEReZXL0=
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 IA4PR12MB9762.namprd12.prod.outlook.com (2603:10b6:208:5d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 04:21:39 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::fa) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 04:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 04:21:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 21:21:35 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 23 Sep
 2025 21:21:35 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 23 Sep 2025 21:21:31 -0700
Message-ID: <dc37d8bd-66c4-439e-afb3-e01670f3e08c@amd.com>
Date: Wed, 24 Sep 2025 09:51:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Add more core cookie check in wake up
 fast path
To: Fernand Sieber <sieberf@amazon.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
References: <cover.1758543008.git.sieberf@amazon.com>
 <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com>
 <a1ff6b87-48a9-436a-9b62-8664d5207884@amd.com>
 <20250923093001.1218488-1-sieberf@amazon.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250923093001.1218488-1-sieberf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA4PR12MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: f9efa2c3-43b8-400e-858b-08ddfb21dbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy9tblNiVHlpdUhRL0dVdnFhR1lKQjNtSzJvd2NaOEJjTXhIR2d2Qk45R2Uz?=
 =?utf-8?B?U0JCeUhCbm96MVdXTDlSOXhEVkFTYXBXZjV4ZGs4V3p5MkY5UkVlM043bWdH?=
 =?utf-8?B?ZHd3ai9hUTBCSGgrWVJDcXcrQ0pzOTZjd1NKOXFzeENOUndnZWFTZjhxYm9h?=
 =?utf-8?B?M2w5UnZrQkVvTWJHS29PTGNBSjc4OWk0TXI1dlFibks1dVhhZi9IRzJRUG4w?=
 =?utf-8?B?OGg1R29QNVlEc3YzemtRNDZrbDRQbGxRWWk1cmtrT0k3OHVDTjJJS0p1bldS?=
 =?utf-8?B?TDEwNDJlaDhDL3psWmh4MTZ6UnZjMjVLNXRzdmJnb2wxajJBek9vQVBUYmJZ?=
 =?utf-8?B?Y1BSOENhQTVFUDR0MUNOOUMyUDB6MGttYms1dFpTdktOVlRUV1B5NjBNRDJ6?=
 =?utf-8?B?WGVibFc5RTcrWnpSK2J3VmxOWHIzSDR2S2krcFE1cHoxUldzRUUrUjJJWkZF?=
 =?utf-8?B?MnhWZUNXZ1FjWld0ekRVRWY5Z3c3YTNaQmtCWXlsL3ZTaStVOXJGaXhpR1Jt?=
 =?utf-8?B?NjRURitOeC9LNnQyVEZnVG5weXBVdzBBRTFlZG4xbWZuU3U2OFBrY0YzU0xu?=
 =?utf-8?B?aHNxV09KbVpxUk9jZGdldTNpcXltcktmVHVGa3NNalJlcEZBYUJWR1F6MUU4?=
 =?utf-8?B?eC9CMTBXQVFXSU5ic1ExYzlaZzRnZ0JtVFc1U2lsZEpxZDBVdEdCcmp2NTFU?=
 =?utf-8?B?L2FtY2dqMnZMTTcvd3lJUEd3REIzUGdoSlllb1JmZnpQWGJKVis1b1BRc2lt?=
 =?utf-8?B?RlpWL2JjcndhR3ViNkRId1QrYWpKcGQxdjZUUDdmd0h4aExkTXhKMlJxdFRO?=
 =?utf-8?B?a1l2SDZ5Tko4YmF4VHoyTE1jTDRlKys1aDlLb0hZQVM1TmRTaXdzYUYrbWlK?=
 =?utf-8?B?SnlDUVdWSUkxZUhnU29hRjYwSk5DZ2x4MEJDQjJYdWlpN2VzTkM4cHhXcjFQ?=
 =?utf-8?B?ZnVnYUhMR3B1WUZSb3RKRFVZYjArdzAzTmt2c2QyTTljdzF4akYzMytzVDV1?=
 =?utf-8?B?eHplREtidm9oV29OWVhveDdzQnY3Zjg0TE5vWVNqd25ZOE94dXFoYllRWUxj?=
 =?utf-8?B?TnBCNHdvaUhYRHhKQnAvZkRZSi9CeGdKUkNSWDdmd0I1TmtSSDdhSmdUZW9P?=
 =?utf-8?B?a1FRVkN6YzdnL1NCNzd2VUNCcVRMYWJzZjRTVkRzMzhTSi8yRHYyckg1empa?=
 =?utf-8?B?QW1uZ210YlhBSWRWdXFVUWRwNFlaVldUQTZmVDNlRVZESW5iOXhMQ3RkbUVl?=
 =?utf-8?B?ZGJwbUlsRmRYSHg2NnlPZWxKYWVhSHlzb3kxc2dxSm53ZGJSVHA0NEpwU29X?=
 =?utf-8?B?dUhBYVpjN2cvN3hJVDhzQlpJQzhCZytrMkFya1l1OGUyV0xTRThQMFllWFMz?=
 =?utf-8?B?ZUdkK3pUME1VeCtqSTUrdFVMck15V2xEa0hnNDd5Yk96Y0FvQzE2TUxSNktj?=
 =?utf-8?B?Zk1ycDRYQ3UrSERiU24xOEs3anhNYUkwREdnQXlVbXoxNEdCSjEwQjNEVDZC?=
 =?utf-8?B?YWJJNW95RG1lWWJWUnd4MFdQaTgyUzFadnV0dDUrY2hoR09mZzZCSE90QTc0?=
 =?utf-8?B?RlFQb0o3dDloZE9aRVVOcC9JaDNsSnBES01WVGhvWFBLZDZ3YkprelMvSmpH?=
 =?utf-8?B?d3FpeFlaeUM2Qm1iS3d4aUNRRE9IbXNjSnNVRW1VK1VIZk9Ga2VWV2hUVFF0?=
 =?utf-8?B?eWU5Und4RkFlQm1NUnFqaWM1cGtPTGw4eXlaY1lyQ0w1bnNyNzVSYkt4dFlw?=
 =?utf-8?B?RU1XZFJTeUpRWE9BMmp0Mlp1N0Izc1hjbUd5cXRBbWhHM2l0M1I4UVFid0hi?=
 =?utf-8?B?VEZmOW8wU2JTOWI3ODdwekUrcW9lOGRjYTBUSFpkdE9YTnRIOG1sVTlRTWtX?=
 =?utf-8?B?WHRiSENIR2NzcEZVLzhxYjFJUDc3MDRqeXB2U3ZOMG40bXczVm4xY2l0eVZB?=
 =?utf-8?B?TDhoOE1JdkRKZDlNdi9LRXZJc0F2WllFVTlNY3RnaTQvRDhKRlY0NmI5cWJR?=
 =?utf-8?B?MkFQK1JqVXJnY2djOFhIR0R4UXByR1ZZbWRsZklTWXlyY3YyUzdHZ0RQcmVr?=
 =?utf-8?Q?BQY2k/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 04:21:39.5935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9efa2c3-43b8-400e-858b-08ddfb21dbcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9762

Hello Fernand,

On 9/23/2025 3:00 PM, Fernand Sieber wrote:
> Hi Prateek,
> 
> On 9/23/2025 2:25 PM, K Prateek Nayak wrote:
>> So with Patch 1, you already check for cookie matching while entering
>> select_idle_smt() and now, each pass of the loop again does a
>> sched_core_cookie_match() which internally loops through the smt mask
>> again! Seems wasteful.
> 
> Right. The change in select_idle_smt() is unnecessary.
> 
>> On an SMT-8 system, all the looping over smt mask per wakeup will add
>> up. Is that not a concern? A single task with core cookie enabled will
>> add massive overhead for all wakeup in the system.
> 
> In such a scenario there should generally be no looping because I introduced an
> early return in patch 3 in __sched_core_cookie_match(). Perhaps it's worth
> extracting this early return as standalone optimization patch? Something like
> this:

Yes, that would be great! Thank you. And also please include some
benchmark numbers either in improved core utilization or the benchmark
results actually improving from these changes.

It would be great to know how much things improve by :)

-- 
Thanks and Regards,
Prateek


