Return-Path: <linux-kernel+bounces-847175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C12BCA280
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EA43A817F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0121770B;
	Thu,  9 Oct 2025 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYW+g9ps"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6D1F4631
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026804; cv=fail; b=D1br8U2YsF89VB56xqD+b0pOFZYiYAe657FBLl4mXiS9/GyGJutYl0d07zKGBwKNmku14yWPUpvVtKbMBCQXk4gQz5iZ+ptLZVJ619Gth9XW2PtcbWQfBBZzuy8jvkSu3ML6Cq011nCYszokTND2S+SwmCp3+j6LSATdKtur+jA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026804; c=relaxed/simple;
	bh=ZVMoHwg1hvGzoizf3FFI/VvYR9Db6+lEmnurTrmJbFM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TLyswhb414OlUjiWrBtb0lpvAQyv/s1LOHJsC3d3wOnd+z3q3MFL3jsdhKOO/ie6Flm++3nCC5poANRNh7Gl6Az1aix077qFUyFx86psbtNJxDAIMzU3jlqn9EZU+gXTLug4qYDQ0PBpVLJSzlUjj+7FCuQu0VuIMOb7gAYmQJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYW+g9ps; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQxU0NyNwkbUAWlwYX9WolV0xFtajKSs/3gKNe0m3H4RwmR8qtOjabGYTJ36usDFzRbhEVKfl4kHCezAmCQBKifmAvodJotfgTmaMqaQSU6SNbe3RYaZNe+z9kUnitZ1cddvX+ZrzCx8YiMZAbmB/cpJ+Y98Er83FUUribBSMitpsVITZM6pZDHDez8ulztfZIteeya6/NATsvV2v5fjdIcM5J9OBttpmIG/yOXeLzab3wpshpNcGyNUs8jyueTzZC2FaRGlmGxduScGhg5Nsk0j+TjoQplbFRZ9PL8wzmeSOK54Npnfh+bFcZFZizpBEoCxXULhR+EAt1ZQyI/yCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSDMQi3grtL6XxjABEr5KBNrf2QmhudGzGLLiNzutUo=;
 b=elJZcrEskQHmnQSZ3CN/Pr1YWwGQFWY87qpYE/pl8GMYjXJQ/04eAVAEhYbNaUbF8aQsuhbPYGZmmmhVsvF+A626yGfrmJt4c46uD4wrB3rBB4fiLw9WUpelqbtEL7KxvF7y8X/e6Svo3QDNA6faeku103pnbwPRD/J6s1uK9JbS2PqlSIXBnALBtMWP0LoLnv2kSx64CrPa11Uu3W+o2KvKYxRfOenwnmmLSbicMExhO4YaDPmqaCEelGINg9saVXKp/qzEtPSyOCJgax50QWlpM8jD2+bGVIVDrxcnY9cAX82MUYADBlR/qsAZtX+wt9563mPtCi9PMhx/LHGU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSDMQi3grtL6XxjABEr5KBNrf2QmhudGzGLLiNzutUo=;
 b=xYW+g9psybwjyBGDAX1zdI3TBomzEHG1dxVAposP7WQvQ1XMkDiS8abieS68ZFDKoyL+NOTLPaq0dIekIvB4FJ+bgd2ltNm0fLLXKx5nru3YR0pn8qzM+2cDnFWkoeOM629lLZKk3aA76UV/8GYLJlk4ut/4Dq8zZuBN9D6iHTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 9 Oct
 2025 16:19:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Thu, 9 Oct 2025
 16:19:57 +0000
Message-ID: <bbc089aa-934d-4dd3-825a-53f8e98dfd3f@amd.com>
Date: Thu, 9 Oct 2025 18:19:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Permit DC_FP_START/END only in non-FP
 compilation units
To: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
 Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20251009150621.3886079-2-ardb+git@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251009150621.3886079-2-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN8PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:408:ac::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 78eaf1b3-ac8a-448e-9b0d-08de074fb038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vnowdm9PTFM5VWtQa2U5bFJJMzVaMUp1MTcxY1ZUUDErK0p0dGtSNGFrQnNV?=
 =?utf-8?B?Vk51WTdtV3I0NGE4QlNqamxKQ3h3RmlrZ3RrZ3pBZjhzc2dibmNrM1ZJeC9t?=
 =?utf-8?B?SWt5ZllTdXc0cnkrLzFrZVkzaG5DSTUxYkdCZ1VZMGV5S1NndlloM1NNdGN2?=
 =?utf-8?B?cDMzWnZEc0cwMlRLaExCWTd4cjRvYldqV3U4Qjd1b21qQU9CM0VPdU9KZkdY?=
 =?utf-8?B?czhDOUNETi9FTExNdVhSZVJBZUQ2U3VrSDRwM1FuTGZvNFZlbU9KeTBUVFdK?=
 =?utf-8?B?aW9sR2tEOTQ2WDdabjFFZEZXc09Zd0hKZHdpUW1NZkFZeGdBR0daZnRMRUI3?=
 =?utf-8?B?TGh6eXJmZG5TODhpRHlsdFQzME9MOGRDVVFhYzNFVC9CUFM5dzRYMkl2bHRC?=
 =?utf-8?B?cm9RTjZ5Y2x1ZU9HRGJxSXNGUWllcmgzWHdkQTJta1hMRWpxVmFMc2RQOURL?=
 =?utf-8?B?YzE4YUg5N0x3NklUcW01dFFjc2k5bysrbHNJcEZSMURlTll5Y3dIWDVaQTIx?=
 =?utf-8?B?OGF3YnlnWFNCcWFoZHQ0cGsyWGNhaDZDMHQxZFl2Nm9jdFNvenVkYUxzSCtR?=
 =?utf-8?B?djhHcjVNanNtWk5RT0xINjVmQ0hIdUMrbVpCOXN1b0k0amRnV1g3MGR3VmIx?=
 =?utf-8?B?YzQxbVlneXhMWnJWRGZTc2srMjVVOVhSanRqenhkL2tOTWt1bU1UWGkySWNX?=
 =?utf-8?B?S0ZKRnV4VzJBWEtrSTlhSHFSUndFSXJYWDFVTzN5QS8yQlFBS1lGMXZmcnNu?=
 =?utf-8?B?NDhoOUI3ZGdoV2ZzMDBLcUxLV3FGcGVOUzA0OE96ZUlBSkREVHkvTzZPaVdt?=
 =?utf-8?B?cCtnbVFZTmtxZ1FVWGIvZjZsMFpoRkRDK2hrMTJjVkE5Sk5Ra3BPak5FUW8r?=
 =?utf-8?B?ZTR0bytiWTd5dERMcXZaY1lzekRUOGoySmhzK1JpUFFqcnZwV1BLeEpVQzEv?=
 =?utf-8?B?SEJFbkdIRUE4QmpTdVRPYXAwUDRPVkdjMzV4UzY0c1dJSTJBZlFIZFYwdEpw?=
 =?utf-8?B?eWFpWENrSWJwVFRNbU83TWRQQzN6NkFPZVVuQ0U5MjBsQ05MTkZzdXM3YTRy?=
 =?utf-8?B?c0FIYlk2UnY5WlBLczlTZEJMNThwNzJiMnN1NDZJRjRPN1JmQkEzTlU4M0g2?=
 =?utf-8?B?emFPU2lCT0ZBdy9NRU1tN04wNnhMNUpGbTl2NVo5cWw2Y0NxYXM0STgrbGU5?=
 =?utf-8?B?ZGRKUWNLdTdFckIwYVZPTHFndGpTWWp2MVh0WmVXZmhzWnJxQUFjSlpFVEFF?=
 =?utf-8?B?MWw4MDBGOW8xOG9OaVlJTDgvZkM2V29qRzhXV2tRL0g2ZjdLRHcyVnhzV3RP?=
 =?utf-8?B?T3hqdlEvUC84UzVZZWNQWHZQczdZeG1wdjgzSkF6VkRvRWZYczN4dWdCMzFk?=
 =?utf-8?B?TlpmNGFzMWxOZXpDaXovd0dWS2FpUGtQVUlpeVI1TDBXTXMyUWFjZXE1M2JG?=
 =?utf-8?B?bXh1Z2dDZitQMjNyZkFNdEJNeXNSbGZ6QW5oOXA3eHFVSTVZaWh5cWJpWDBZ?=
 =?utf-8?B?OStDNjlraGZNcVRMMUUrKzg4c2c4c3lXUWpiQ1VaT3FjbU5PNlpzb1djcmRv?=
 =?utf-8?B?REczSzdvUVlBcEEwc3FvOEFiWGdMTExSU3FOSDhtMHlPbmZXNHVFWVJNa3Er?=
 =?utf-8?B?MjlCaGZydnkyRjlIUHdlQTI4K2RETUdLUHJidmRzWmpyUE84dkorR0tRNjgw?=
 =?utf-8?B?VFUvbkE4VllhMGlwN29Pdm8yVGZHNlIya00xQVF4T25EZ2czb0RUKzhVeU9v?=
 =?utf-8?B?MTZDWE5pVitmcmg0TnZjVWxsYy96VVIybHp2dzdjMUFBUHFlZ3p3VnZuUWlD?=
 =?utf-8?B?cWFlcVNINGRZZWdzMnVldUJjTE9XaDR1LzN5ZzM5NWVzSWZHTitRR2FDUlBk?=
 =?utf-8?B?b2c3N25JOXdtenZsQ2c4UUVaUTR4OUo3T1NpbjNidURmNnJRZVpXaG9CVVNC?=
 =?utf-8?Q?Trr25O6jwRnQb6OMqTQio+3JTDP9eZk9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTJzeVU2cWp2RWg1cHRlYzU1RmlSUHJpT29PcFZlRlJucjMyYnFTQU1vOVhw?=
 =?utf-8?B?a0h4QjBzOFR0ekJRVW5GcEdwNitzS0RxTVZTTWEwcjFpWmxlRXhOMzBoMnVM?=
 =?utf-8?B?VXNSR3pJL20wcnE3Y2pib0I0YUJZV2R4WDRUc1VhSXMyRE9PQWtCSGx4eGtq?=
 =?utf-8?B?WjkrT041eTNXbzAwc1ZZbVlvZnNjY1dJZDZETUpYQlVPZXBMeVFGV1gyNDQy?=
 =?utf-8?B?WnVQWHJpU01EZUZTa3oxQlpzTmJ3c3oxWGo4c3R5alFwUjY2V1hsRkZTRzFh?=
 =?utf-8?B?YWdDb2ZOWWlwV3NQalFFUGt5RWgxUlZhYXp1cFJLSGVSWVZobWw0b0Q0UTh4?=
 =?utf-8?B?a2Y2OU9wVUM3Wm5rNXhHTGlIM2IzN3IxS0dxSE4yRG1VWHdySlMwaTh2ckZM?=
 =?utf-8?B?NVQ3eFpaT1Z4OWZKY01LOFZTUHZvdDBhMThiZkR2S2M3QldkRmNSTjlpRnVK?=
 =?utf-8?B?M1dBckhkOUNFbmpjY1dsWFJncU4rRERDQVJXN2hIMVpzWHF3SUN0WVc0bjNL?=
 =?utf-8?B?WTRVMmtUdjY2Z3dacTNjVzJhcUxjMTRYUGFKcmZDQ3dtUmM0QWkvdDhlNHdj?=
 =?utf-8?B?VWdxb3krc1JJaXViVllSVW9rL1hCaFFSTGcxSndBOWd1NE1qZGVRdnhzbzRm?=
 =?utf-8?B?aS9vZE1rcThtaGw3amNldG1tUTlSV2x5aVFRemtLZTVPYm5KNlF2UEp5cnVp?=
 =?utf-8?B?ZlAwVFVrQTFrdEpjZGxWTmhtQ05PZDNJeTcyZmhpS2lyNkhDTXNiTGY0Sm9p?=
 =?utf-8?B?QkJOSkozZnpPV0htd1ZlWGIyalNWZk5Gc1dwODNhVVgyL2w5NStFcjFiZnBh?=
 =?utf-8?B?ekNzdC9KTnl3OHB4eTVyazhmL1FRMitkdXZwc2dSL1VIcE9qdjlmaHY0d25j?=
 =?utf-8?B?T2IzQjdEUXcwVUN5SXRXN2huWG5NbzYvYVY1eTFncWFJNGcvck9oNDhQMW9Z?=
 =?utf-8?B?eTBkWXltNFBIMkRBTkFBZDdiMFZKcERhYncycURsQS9lSXB2VnlJWUlCQ2l2?=
 =?utf-8?B?a1RTUVI4MEhzSUdFMVRKSGJHMm4zbFJzeXAyRnRYT2pTQVJ3UlNOMVE1QWNL?=
 =?utf-8?B?cm9CenVXVmc0a1lyR2txTnpuQTJLSEJGQWdqeHRhbmZVbERMN2FmTFhFdzlk?=
 =?utf-8?B?cWRCcG42Y2hHRFBOaWRsRzRReEV6cVlpNDNvQjgwZThYRStGQ2tJa1dPM0lp?=
 =?utf-8?B?bE44NTRpTUpmWWNueXZpTmYvOVNxRzRNZ0hSenpIdGZmRldHNHhwdnJwWFhs?=
 =?utf-8?B?blVUZnd1UTRaSVhTems0SERHT29UczQ0U05mcXRTM1ZiT2lLdzhkR040WHZB?=
 =?utf-8?B?T3pIbEE3WTl5S1ZtZUVYTFRFUzZoVTc5dlMwM1JWbUhGUFJidWdpeTBtNHlE?=
 =?utf-8?B?YXVWZnRqNFVyMmpaeC9DOTdaeEE0blYxbk5vOHdTU3RBeHc0N2lodHlTbFFu?=
 =?utf-8?B?blVJenVCU3RhVDRoVk93WVdBODA1RURxYWdKblpYbUxkdUl0a1MrdnRkMUJB?=
 =?utf-8?B?RFI2MDdJSlhYVnJtUXdicmVKdjJ4dTRINDE3SFZHRUhvampHYmRQK3pLZFRm?=
 =?utf-8?B?Yis1QXp0NVNSY3k3Y2xPRlYxcWc0REpmNCtaeVVmY3QxSDFuWXVEejBjN2NW?=
 =?utf-8?B?RTBuOGJETzlLZzkyWXovUlZrbldHSG9UK1h6UnNvWlYrSnNGK0FNVmdjcEVI?=
 =?utf-8?B?YzBWbnhVU0hrZlFLMDVBaVFJWVQzWEpnZEpSR0M5US9zMzRDeEdDVldrMWhm?=
 =?utf-8?B?SDVZRXpjY2ZkditHTHMwT010NCtYNW1kQlB2RWVwZk5RWlZwSDVzS2JTQkdv?=
 =?utf-8?B?d2NJR2ZvcWFpM1VIN3F1YmFXVUZ1dHNidFllcTVLM2JwZ0Q4eFdNWm1kS0h4?=
 =?utf-8?B?L0l1dHdmWnlMY3QzSGpBRklmMHlYRnp1QkxQOUMrVnRJZVR5WDFDVE9yNHRl?=
 =?utf-8?B?MUN1eTJEYzBKYmE0ekVRYll6eVJ6UG14L1VJYTdLSkwvNTlkV2NqaXBHc0R2?=
 =?utf-8?B?QzFNTkhPZ0MwUEY5c3piQStTK3BjcXBUdkZsbFlJUFl6Rno2bzFZVEx2eklR?=
 =?utf-8?B?SGE1cjZ3TjZMQ1hIcW4xL2dqM1FjZURkUUxtTDFucDJLK29xMGdibFltUE9O?=
 =?utf-8?Q?1Q95jFxDa403fWLAD4RDwlntN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78eaf1b3-ac8a-448e-9b0d-08de074fb038
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:19:57.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1gDWaenoSmpmsb6F0Slcno5pq6BDMBDYTpAiFy1Q8616JyIf1GZSf/wNUidPxWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041

On 09.10.25 17:06, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Test the existing CPP macro _LINUX_FPU_COMPILATION_UNIT, which is set
> when building source files that are permitted to use floating point,
> in the implementation of DC_FP_START/END so that those are only usable
> in non-FP code. This is a requirement of the generic kernel mode FPU
> API, as some architectures (i.e., arm64) cannot safely enable FP codegen
> in arbitrary code.

If I'm not completely mistaken that is actually an issue on basically all architectures, at least x86 is affected as well if I'm not completely mistaken.

> Cc: Austin Zheng <austin.zheng@amd.com>
> Cc: Jun Lei <jun.lei@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Anyway, patch looks sane to me but I'm not so deep in the DC code to fully judge.

Fell free to add Acked-by: Christian König <christian.koenig@amd.com>, but Harry and Leo need to take a look.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h | 8 ++++++++
>  drivers/gpu/drm/amd/display/dc/os_types.h      | 2 --
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> index b8275b397920..4e921632bc4e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.h
> @@ -31,4 +31,12 @@ void dc_assert_fp_enabled(void);
>  void dc_fpu_begin(const char *function_name, const int line);
>  void dc_fpu_end(const char *function_name, const int line);
>  
> +#ifndef _LINUX_FPU_COMPILATION_UNIT
> +#define DC_FP_START()	dc_fpu_begin(__func__, __LINE__)
> +#define DC_FP_END()	dc_fpu_end(__func__, __LINE__)
> +#else
> +#define DC_FP_START()	BUILD_BUG()
> +#define DC_FP_END()	BUILD_BUG()
> +#endif
> +
>  #endif /* __DC_FPU_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 782316348941..6af831710489 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -55,8 +55,6 @@
>  
>  #if defined(CONFIG_DRM_AMD_DC_FP)
>  #include "amdgpu_dm/dc_fpu.h"
> -#define DC_FP_START() dc_fpu_begin(__func__, __LINE__)
> -#define DC_FP_END() dc_fpu_end(__func__, __LINE__)
>  #endif /* CONFIG_DRM_AMD_DC_FP */
>  
>  /*


