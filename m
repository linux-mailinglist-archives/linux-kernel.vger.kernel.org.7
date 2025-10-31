Return-Path: <linux-kernel+bounces-879478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE1C2335C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E44033AA3E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71111280A56;
	Fri, 31 Oct 2025 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vvs5ItPb"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD527F010
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761882658; cv=fail; b=Gfu7qBK4kL6RLiR71FP3A7e2Rmft1yojDFney6wTXO2dsy8sGYTPKeIE/B453JVLHoA2luh1P+3EfBjgpj7fnj/Fj2cxMs96X0NyOZUI2c/ZIe6jqIx6LioMDW7DXwhY+16TUekpKkjty7vAh0bYxbuBlGEePe13OPoD5B5Ys80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761882658; c=relaxed/simple;
	bh=vBjiusg7b3e74LfjwkUhNoraMKJHLiDSUJ9QFI6w+Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TcZg1r5vU2/s1T7eAiBiNp39qpiongSZp9vlHgrjOj0twQjqN+8kdmCiIqG+XtMdcfvlKN8m+XXh5hhpnQRLNkWleYdo1uqwBqsRuK3qNhTtdsQ623OxGY3j8K/kDg+ZJu1duU7wqx+Y0ZlVvFKLb44FlXv8q4N6XkB9NomRBi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vvs5ItPb; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l16SqNE3/Oh/7A5v/q/ChIDsl6/Cn3hz4WrHbimNmksfuwZ5ec4V6YcLUQPnYRI9iqiQDNtAGeSPLX+tOH5dGig1+EgWg8lTsKjav3DH0JBBr9Mf0JhNq77jXz2KGS/0Uk/IwCepZGZhupeS6DpTnqeQmiRVLPBdmdfWFRA5BMAqEjaI8P9SC28RngLMJ0txdkvUcsz0LfY1waFqQwpFbfDF8fYMfNUA1kdjZ8wl0wApcoRAcZuPl4j/j+ov8sxDhfVCH+gE2jfSgey2TB8tk1i/GVVgwBj+tgNQHVGtZC763EmCRWV2c84XyNGC5J2KR67VG5A3RgXV47QtdCbgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q58Yi5VTvg+dSHOdCMpLMClHdXjGUwkvB0BsW1pKWgM=;
 b=LrqLlazE0849w61PyIgxP2m/3hjl5WhBHLT8l7nFQ1XMafSpZGJYBxAXNc1xfJ26ITbRahLCZewXfjWw4AqAmhAkJReJRKTDMHfRQJHSi/AtHr+pBmMa7o4liwaH4wquOBN1ZR7KeujjsuEzoCxFLcUWTMDvbJFwQ6wJOjHNRN/TWJKU0e8C835NohpxciAf+s6TX8NU0AZ2Nkj50ChgTEvCPSvuVHsvjwlkYOW6bDMj3CBLW9PlZmP4gZvJufvzlA1vjnysQfdAX3htoD1M9ZDNKYFtzh6njkw+MZ0MCH/rVa4gObpEmkRN6EQ6vtmYVrax9nTZHjDIcRLv5VUaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q58Yi5VTvg+dSHOdCMpLMClHdXjGUwkvB0BsW1pKWgM=;
 b=vvs5ItPbGuRgC70OCAv/AkYWpBGX6zoalUeToRUl8GobsOl1JWOmUIQ9YHZKXH1yZBxuftM3Gjt1Qlzz+jtsrXx7WzWxKOQnOTKCc/ZKCIfTZVYQzpktIc1VC9yU+yKmq0eaSBtgxw3pQC5SU9AnEI90SQqhxmrmDmpPmjOcC1k=
Received: from MN0P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::15)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 03:50:51 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::9b) by MN0P223CA0013.outlook.office365.com
 (2603:10b6:208:52b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 03:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 03:50:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 20:50:50 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 20:50:49 -0700
Received: from [10.136.32.170] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Oct 2025 20:50:44 -0700
Message-ID: <986aca02-af4b-4453-87f8-0d75672301b2@amd.com>
Date: Fri, 31 Oct 2025 09:20:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 5/9] sched: Add logic to zap balance callbacks if we
 pick again
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
References: <20251030001857.681432-1-jstultz@google.com>
 <20251030001857.681432-6-jstultz@google.com>
 <90e556a4-59d3-4be4-b4a8-5e7ef4b523d1@amd.com>
 <CANDhNCo4bLw1sYqVVXUji4STdj68xV6OTu2tVosqUXmkN0r4ow@mail.gmail.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCo4bLw1sYqVVXUji4STdj68xV6OTu2tVosqUXmkN0r4ow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: fac70e3f-387e-4779-e636-08de1830aed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDFPb1dTakNyWGQ3SVFjVEZKaDUxbXFFSEZleWVkMFZGTS9renlvUVZ4YjNW?=
 =?utf-8?B?aUtheFZvQzVlejNLTlYzT0tsbnBWNEtNeFRBbDUyMmhtN0V0cWFkWHUxY0Fl?=
 =?utf-8?B?anB2SmlNSDFVQlY3cnNmWHRuQ0JIUWdQUllIOUkvb1h3d3JJYVZkakR6QlM3?=
 =?utf-8?B?R25NcjRDanRIWVNtL2dtTHd1aC9yTUdXOTA2bFM3TGhwcHBleW1WWDRIK1JV?=
 =?utf-8?B?ZVNPelJTb3dTR3llQ3VBY2hRcis5S1JVMGdFOGJPeUx6bWNQSFIyc0dqWXVs?=
 =?utf-8?B?c1pheU0wQVQvaTZjUW9iMmh5SVNkTzVTb0UwSmhCRnBVNEV5OHBXT0Ficngy?=
 =?utf-8?B?TjVGQmVROGVWUWFBbTlNeS9LR0tYU0RQME10a2FXMWRrRVhUeU5Ua1dYaHov?=
 =?utf-8?B?ekM5em5lUUt6Mjlpdyt3eUU3UVQ5cHdGSytqa3liSVNOUkUzU2J3ZmFSSEIz?=
 =?utf-8?B?SHZRWndNdjZjV1V3L1VwUmt6d0Iyd1ZNYU42WXRpSWVRSmYva2NZLzVpcWVQ?=
 =?utf-8?B?RDRUZ3ZkenFma3FvaDhhcXBnV1pRM3l5dmxGY2ZuTFJaaS9lS1JhZ2c2VlpB?=
 =?utf-8?B?MExwSEV2cVNSMU56L2pXQmg1N01URHVQVjZtcmJPRWFWTEtRQ3VTZjhodW1J?=
 =?utf-8?B?OUlsQlN6M3FUT1VaVGgvT2Qvaml0aVZlUnZJZktsT2tqc2lnMk83NHdYYzhB?=
 =?utf-8?B?dTZlTmMxY2lsL1FlOGhrMUJIVlJINk9udXNOWVE3OHhXaTJFSFVJaDcxdU1S?=
 =?utf-8?B?alJ0NUk5cytRZFFPYjFHUUNCT1dibzVwTC8wSkVHRHUyZEwzd1BFMWJVaGkx?=
 =?utf-8?B?Sm40YUxWVm5CbnZFSkQyOHVzdDgzNXZnNlVsMzVLUXlrUGdzL3pPSzR4TEw2?=
 =?utf-8?B?cDJMdzFHa0w2U3haeXdFYTNZai9PNmdGalZoR3VGK0pFeG43Sk45MFE3M0sv?=
 =?utf-8?B?U0dWSUpLVCtYTC8yRWIrSCtYWGVKVzRZZU5hMnFVeStzUG1UQzhqVzlnWnhQ?=
 =?utf-8?B?SG5TWnJNSHQxMTJ1KzZJWXB0WmNHYnhrSTZLU3ZJZ0dQTlZ6dVVDUFc0eTdO?=
 =?utf-8?B?M2V4SEJxOC9DVVJsT2V2VURMbmRHaFJwbEFDRWFoQVRveEtQd3I4QmpORUVC?=
 =?utf-8?B?RWRNM2NvWXFWY3ZhTGZ2cDI4YW8rMjNHajFIbjJlc010UG9SRTE4aFFSV25w?=
 =?utf-8?B?Y2hqNWhKc0tIQXlzbnA3OU1hRXBlR3RKQ0dJa2tBMldIREZhMmoySFpTVlNV?=
 =?utf-8?B?R0d1WUk4NjhxK01jdzVaMkh2SWNuUWNtTGJJN1ZrQzRhQmpwMk1uK1hhd1Rx?=
 =?utf-8?B?ejBqNnJ0VWREYWs5NE55c0RDME5aenNXU203ZXI2RmU4M1dPQnFacnZiQ1Bm?=
 =?utf-8?B?L09MbXJqMXZnVFJWN0grOFlQK1VnKzRIY0NTNU13dWM2MHhxbTFaNHR1SjAy?=
 =?utf-8?B?bXg4bDB6ZFVWVjZDbUw0U0RGSzlZRnl6RFNOVm41bGNuZVVoZzJTNTFueUhz?=
 =?utf-8?B?ZmVFNUIrenVjc1JkWjc2eHhENlg3ZUgrUExCRVNzQURjM3lRSEpnM3Z6Q1dr?=
 =?utf-8?B?Y1lXUjFpQlcrTUEyNVNTOWFqUGZGK1RDdEZuVTYvejIvT1VNRGJqbnFYcnUv?=
 =?utf-8?B?cFFPL1BNMkFTTXFwc1JhZ0MydDBJTnB2WlFTNm1uN2YzVkRiMjNMUkxVMmQy?=
 =?utf-8?B?N1EyT2lLR1F1ZFBGTW1rb2VpZlRZcGRFclFtNTVJWFMyMkJsd3RVWW5tZ3ZY?=
 =?utf-8?B?UStqdllqcjh6SVFmcnliMUo5aW9NeFlCMkY4Q3pEbDBwc3hqZlBxOFlydkhH?=
 =?utf-8?B?dmtrd3d2TnRxSXVtMi9hSXhURC9ycFRlQ2xKVGlEcWdEcEVCcTliWEVOclAr?=
 =?utf-8?B?NE5QUGNlU1YzNDg3MEVjdXZRdjd2TXQ1Z1V1Y0xlWEtTUWxUNWR3THhpZ0tF?=
 =?utf-8?B?Z292L2VkREFQQXk0cjJaN2FZNlpQUVdaWTZwajdMU2o1dVlsUjNNQkZtd0JM?=
 =?utf-8?B?OUFHS1R0Qk1PelFBNEx6U1pKb3VVZHM3UmVkK21aamhBZ203K2dIZmNucEI2?=
 =?utf-8?B?aUl2YTJ2K2Y2OGZuTFJXdUtmWnFHSGlwWnZUOXNuYVhCamVscWRmOFN3NzVv?=
 =?utf-8?Q?tvVY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 03:50:50.3521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac70e3f-387e-4779-e636-08de1830aed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

Hello John,

On 10/31/2025 8:45 AM, John Stultz wrote:
>>> -             if (next == rq->idle)
>>> +             }
>>> +             if (next == rq->idle) {
>>> +                     zap_balance_callbacks(rq);
>>
>> Also I would have preferred to have that zap_balance_callbacks() in
>> proxy_resched_idle() but this is okay too.
> 
> So my initial hesitation here is just we call proxy_resched_idle() in
> other situations where we might return NULL from find_proxy_task() as
> well. So this avoids calling zap_balance_callbacks() twice.
> 
> But thinking some more, later in the full series we often call
> proxy_resched_idle() in those paths where we are briefly dropping the
> rq lock and we often call zap_balance_callbacks as well there. I'll
> take a closer look at the full patch series and see if that doesn't
> make sense to consolidate then.  Not 100% sure it will work out, but
> worth looking into.

I don't have any strong feelings btw. What you have currently works
well. thank you for the additional background. I should go back and
take a look at the full tree again to get a full picture.

-- 
Thanks and Regards,
Prateek


