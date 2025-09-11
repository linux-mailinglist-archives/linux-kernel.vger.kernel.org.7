Return-Path: <linux-kernel+bounces-812587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BE1B53A05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85D37B5A13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601335CEBB;
	Thu, 11 Sep 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FYe1A0wN"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021072.outbound.protection.outlook.com [40.107.192.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F0329F05
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610836; cv=fail; b=LTAaep1x2oUH2pVPuk4XqbVLb0gSX6YfM3xQTFfOcqP9yAmmsuSC5S49P9asMaLKd7Xo7IB32kkJ5H42K3UQXf7BZC8GC0fkxfWNV0FIxZqJCnXzGl611W6oHyS8KEsTD0PRVGi5IC+cYwK9gjy4k7IPdwJsgU8NFl5FLhTwk1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610836; c=relaxed/simple;
	bh=1oubTEEVPg2y9huhDcXq7+/XNerZEnXPLhLwFwXhcas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eX45RAmHy5/D9zgaw1/h2CAY0jVZcb7EFdH5PriZrVR4O1ipGuPo1OcYs0qcHSiI7CgEJ5tSwTjYS4z485vmmKK5dyCw0c6aXJs9bHya+S3MjhXAi1KsQCS68i+/ECNfvRDKO/h7qwmYnTIJBGuR9wMPwL9nNKwyNUGCcbuTHVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FYe1A0wN; arc=fail smtp.client-ip=40.107.192.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXuJoXji+74K45phaQRQA0PxLB8hJS2Kqnsmjpb1haqFetchOeyDJfrJPQLyDdkrKYyEsyDDOnF8vdMZc90NZEKhhWh3EApcdY/t5VDAjX6pRPIVfqLQUsPUGr7klBLFd3FRC2YfuJVqwivav4FJ7Z1AMKm8MW4zLi1X0OG+wZNfCxLJpcSqCMfWyj1LDnu25Pe6SEAKFGp4QxyTqOSmG2t7zu202gb5GIt9FPwabCpziZV4ZvXX4BvRsKymsNSAVqSlrTqZ1DhS4iaXEpdrisZy2SznW73XbMZjjlIrzksJ1VWirRGR7LML7t4hC5g22cU/KcQxwW3ZamnhefdlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90JiosGrctJHFHr+EJOLiGBDL14h7DUntdENQcy4X7k=;
 b=KND0WwqgiIhWGAvIdfdrPWHs1+9V45M5DqHH8HiymWacI+hpO85lJuHUcM52kpkV75gRlKb43fmbP9UW5aypIXR2hIAx38I68s5ZpF02Zx1b2pGqDjCOk9nHefdt6U6Zp9AuVArkCuCuP1FMgOxYgy/1QKHn5FRJbhDrxWDTXDSkMdqjxtd+cuLXalfli8Y004h8Y52QbmjfZHxEvv7iUkwQSB2lW6uJzt2jUtT+sU96vm5rMUni+a2nUjR1xKQcsL5GGY4Hz/yFnrR+HP9hiAdlYsIm5QcYr/b35wD6PGLbzuGeQMpZZuxMQf79SsLGa5/kAGnrSv43Kl8sbmp9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90JiosGrctJHFHr+EJOLiGBDL14h7DUntdENQcy4X7k=;
 b=FYe1A0wN26H31nDPFBXh6FIXHQGDOGeRR1qkZ/j7QLRegy3EY0dQWlLR15d2IiTu+fb/WSlPbtxGei517bvpx9V95Em/uu91bjBwqpOXPxRl/8k+zJuMpm4Fn5QoSYey9C0N5IIs7HuMdiFqBUXEI2Ihrw2mGP8xtbmJKsFBlVtK4CBoSO41ThuzhGyCJOTavrIvZjDLOmXgqqDzzioUsflT/eBdUNthquqt2E4Hzjx1Sz6Vtxf1SVrcuL3W+5iSkVe28Ti7oFo90insyd2YKuWkkaYX6zPyFMS7Z+O3kIyRfXCzVdjUkuCpZONnvXI82E/hud0mGptGe+7VBztV9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5639.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:13:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:13:50 +0000
Message-ID: <0a74c723-3d65-4f5f-a7c6-36255e94e6cb@efficios.com>
Date: Thu, 11 Sep 2025 13:13:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 23/36] rseq: Provide and use rseq_set_ids()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.738408636@linutronix.de>
 <a5b70b86-ce87-435e-9ba5-407ea98e8c8b@efficios.com> <874it9rn8b.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <874it9rn8b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f1e420-8be9-4a13-9af8-08ddf156936d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2lidm1vUUp2eFN3NDJMNlB3SEJ1clU5UHBMUVIrYkVMaFdhNWtIS0F1TzM5?=
 =?utf-8?B?cUVBYjM3N1Q1V1VVQW5ha0RFZHBiRHFmRm1qZSthN3phTnp4MGxRdlNlclZR?=
 =?utf-8?B?U2VtRldEU0ErQ242Y3V2YzBzT0V0cDdxOTVOT0kzdm5LUG5TT1UzdTZQVDc5?=
 =?utf-8?B?RW9VMm13VFFFQU5nNm40dFhoQk5VbnJzSWxVVU5xbis5QlpaVnFFNmM0Snpk?=
 =?utf-8?B?cVB6UXNHU0M1bWtrNlRETThjNTU4ZWZSV2dPNCs2TFlpWGZ3SmdMakJPR0pw?=
 =?utf-8?B?SE9BTkE5Yk5EaWJYZ0xjYk9nOUlzcW1hRjFMWENlVDJaVGh5TTJoSDJycnY3?=
 =?utf-8?B?V0h0YlVZQ2JobzMxdHJSUWZyREpSWUNEV01KTDhjODhEZFpxTjQzVlVQcG9p?=
 =?utf-8?B?T2hwbmRJVmtvY21uZjRuRXpTZkdrQnJkOWpBSUhBblpPeG8zcmFTRTZLeGlI?=
 =?utf-8?B?ZWJHbVMzdUdwZDNiVVh4Z0J2dk5vY0d4bG96elU1Wk9NU0QvQlJLalpuSU9o?=
 =?utf-8?B?aXV5czZTbWtOaWV0NXg4RWpKR0pXcjBsTG5JUW5zZm1jKzFYUnJoM01LRk9N?=
 =?utf-8?B?V3dHWnIvZlpHKzVzSmNhMTMrUVg0V3hUN3F0MUNGaFV5NVhneXl0Y2NwN2lI?=
 =?utf-8?B?YUhTSU1YaVpVT3BHK0Y5S1grM1pkRUF6RHFibjYvMmZ4TE9DSUdua0FMUTVK?=
 =?utf-8?B?UlcvNlFOanU5NndoSXFZenVmc0txcHZWVXhVMmhhSzEzbUFDNEV1YVVSeWcz?=
 =?utf-8?B?L3RHOXcxbGY4aGYrYzd6Z3lDdG1RSjQ0ZjZSQnJkeDlHMUFzaVo3eUU2ZTZU?=
 =?utf-8?B?Zm41bVlCOUJ6VkpSak93SEMwd20rYkdLZm5HZE1UZ1N5V3Y1dkNJYlI2SUlB?=
 =?utf-8?B?SWw4SkhleHRTZHRYY3FzbFUwb1RJaStENFplcm9PQVAwMHN6V0QrMldpcmhy?=
 =?utf-8?B?S2dOamNONDdYWHZlaGFrK091Z0dpWHltL2VoOW1EMFhndXlGL005T0dHNWxT?=
 =?utf-8?B?ckZSdXlrVjdreTdkUFdzalpPV3djQzZEZVRZZkhDMEgrQTFlZ3h1MzB4TGVl?=
 =?utf-8?B?SFlqMEMvSzczN0xmbTdpZzBsNHJ3dEdWMGZGLy94NjkvVnZieFhvdjFzWktv?=
 =?utf-8?B?MDk2OE9WMDBnZGxOQklEYTJLbkU1T2g2SlNCaE5scWthcnd5Ui92amQ5QUNn?=
 =?utf-8?B?eXRCdmVveld0Z0hOTWdKUGt0dEhFMWNlVGVTbWwzTG0wUEt0eXFIcmg0Wlhn?=
 =?utf-8?B?RUN4d25vQjlHK0I1cjUyb0FEVEZWNDVzcW9pM3FBbHpxVjc2MzNDS2VsRWV4?=
 =?utf-8?B?WFJMWURtSDkrdktFRW84aU8ybUhyQlhCYkhtT3RsZW9CbzRSME4wb1ZuNTcw?=
 =?utf-8?B?SEl1ZFpnV1ZKbmRiWFB4ZUNwMnM3TnRQWGZxNlY5Y0NxaTFXRUhtdE0rNzBO?=
 =?utf-8?B?d0JLanNMK01vN2pHWGJuOGl1VnBXcFpZRHB1Uk9lNVo5aDBWWW42bFdNK29o?=
 =?utf-8?B?NlVXRDFsa0d1QlI1TzVWUmEvUGUxejlDQ05XbFo5M1RNR1JQS3dXcjFWODJG?=
 =?utf-8?B?U3pFOUtFK204dVQrWVlmc3VLT1hWRHhlQ1pxTWx4MmdSQVhVM2lyMFRkeGN4?=
 =?utf-8?B?SlpZSXdYbVZjVjNaQlFncms4SnZOemVzV2Y3dHpQMVhFZmVrN3dFeHB6UEY0?=
 =?utf-8?B?Qm9ybTV2QnhqOCs0RTBZVVM4OTRTWmN4aWpkcndLSTRLZ1k5ZWVmbUxsUmJR?=
 =?utf-8?B?d1VpV2lzd1lFY1RhNGJCNDBYUFhHYzNsak9IWU5Uc0p3YmtoQWFWSmZmTmgr?=
 =?utf-8?Q?nejkQ9r9KXPwyvYVBmXdKUsd2YN+54xjyp86I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjJuS3phck1taU5uLzhxclM0K1g4RmV0cGtYMUZJTXlaeU5UU0RTTlU4OFpv?=
 =?utf-8?B?NFlYZEpTOFVMZWY1eHRFV3RXZlJWM3dxQU9xbjVLbE9FeWllMFpuMFpJMEJW?=
 =?utf-8?B?alFuMzN4Z2hSMmtKWFg4MkdTSEw3dThkYXRNNHNEdmpUT0VxRmt1bjJCYVEw?=
 =?utf-8?B?YThuQngzclhKUUkrZ3Rjb2w3dEQwdHBVUWlrQUtJVjVOQkV0S1V4Y3lVWmM2?=
 =?utf-8?B?NVoxSlZoY3k3c3QzNzNqUjQxOTdXVkhuNnhNOVdsS3BFMmQ1KzVieUxYK3ZN?=
 =?utf-8?B?ckdDbkdGamhNYU1VR01PQ1FBZWlRclZBbTkwSEVrWEVLYnRPR2YzSXo3akh0?=
 =?utf-8?B?MU1mS0xoYzhPY25IQUNxRUY5QnErVVJCQzFEYk5qZytoZDU2LzBMRVRRS0ps?=
 =?utf-8?B?YVZEMGJpdGxEMHJaeDAzRlQ5ODRoN1U0UDV6Mmg2aEpnVzZmTmlWRHQ0bHZO?=
 =?utf-8?B?NFR6K2xQL1VxT3ZyelgvR1YzQkowYWhiSzkweDN1ZGhxTzM4SUViMnFqZ29I?=
 =?utf-8?B?YTZ3cDZjRHU5ZTlORGNoZ2xKK0drWnNWd3F0d1hYWkdxdjhPYldYVXZHR29y?=
 =?utf-8?B?WkE5WEVMYk5xOWlWZG1GNXFrNTlabkhFczJOa1lJS1FCc2U1eFgvTTRhb3Mx?=
 =?utf-8?B?UTNHaWUxZ3pqdVBqaUxabGV0NFJrZExEU1ZsSWxVZE1JdlFxbEQyTzNyVU1Z?=
 =?utf-8?B?OGpIcXZYY09ZVlB6WFF6S0xJV2ROR3dnb21lSFk5TTJnTUFPOGxvNWYrbzNX?=
 =?utf-8?B?TStyQXBTbEhCMllPcFB5K29INkRBYlJGU3YrazllazJoODh0bjQyU0tKYy9V?=
 =?utf-8?B?TTlIbTZSbCtoYjNzb3ZtMUQvT2ZqWlgrcmc4dEtlbW1QV2VEY1laMmVOVkNY?=
 =?utf-8?B?YVg2REpoUVlFdXRyaW9LNUdtUDMxUlQ3dlhBUi9QZWJNRUNoWG9FUE44N0NG?=
 =?utf-8?B?eDV1U3FCc2dDcmRKcjVIeHFKeFlIbWNNNTM1NnNuVVpNQzZVQXgrRkJ6a3J4?=
 =?utf-8?B?OXMxYjdEOGpjSWJPanlTTVYwUTJmTTV2dnhCaVYyK3EvdU9WSjZ1Y1QySTl2?=
 =?utf-8?B?dEJKOEhjODYzTVhwdENCN1dTNXNqbVhUWjhpem1Bdy9WRnRlOTdRM2JhTkZW?=
 =?utf-8?B?czZ1Tk54ZlpLL1dVUExUVmNHS21TRVNieTR0Y0hFVHNmOGxUejBsZlRuaXFV?=
 =?utf-8?B?Tzczc1ZUKzhJbFdKeFByTlo5U2xUWXNOVGphRkpKNytUbE1nM216TUwxM2xz?=
 =?utf-8?B?TWZTN1V3TFhWNGJCaWdDd3k0RUxrTDZlcXZqT01KNnVJdnZRM1BYTUJNMnpu?=
 =?utf-8?B?VC90NWRTdjNMTmt6aVFxNWcxSDU3T2RXQTZBM3dVK0dXbzRtMmc2NDM4d1Na?=
 =?utf-8?B?RDVKRVlSejNaNkNvMTdoMisxS0F4TVR6OUlUK3NkY05ZcDlMUWF3VGJtdFcx?=
 =?utf-8?B?MHY4N2ptcmwrVWVkQUJvLzRKdmJpR3IwUm1TNzY4SXk4cCtvVlRsWUtrZ1Mx?=
 =?utf-8?B?Sm03RGtCL3ltTDBod2ZBaUd5VnpCZ1BEWGJKZGt1bGl4T2NKWmpYbTdSZFdJ?=
 =?utf-8?B?YWo5YVJLNWtHK2JSbE1DUHhZZ2tPMWxuUEdxeUpreVJKSGNNakRKTFZiVlZV?=
 =?utf-8?B?cm5SMHV0ZG9lM25MM1o0Y0FFOUlreXcrL2ZlSkZlcnVrMTlIRDIyblo4eGhn?=
 =?utf-8?B?SGR5ZGp2T3hHbFliUys1WTNRdm0zVDhBK3BnVGpDOXo5cHZkcG1vQjJMNmdU?=
 =?utf-8?B?Zno0SCtObTlEaTF0VWNyNnB1eEJBWHllUUhNWWdkUG9lUFpIKzJpRUNJRU1W?=
 =?utf-8?B?YS9jeHNIeTZZV1FxWGpOWDNkcVRSWDJ2R2JOcUV2RVA0Vjc3UEl0RzcvWXc0?=
 =?utf-8?B?d3AveXhobmMwOS9uSmx3eCs4MmNoSnFmQ0l4TGZrbXNtdE9qMjVGZTE2YVlX?=
 =?utf-8?B?Y1VCckVkb3F2M1g5dEFYVXpObGlJWnE0QnlLdHRQd2xFYWdBS1JIeFd6d055?=
 =?utf-8?B?RExWczZURDdkN2NhOEJsTHdYY3pleTJsOEJWV3d6cHpxeDFZb3dJV0hIQ2xF?=
 =?utf-8?B?OFlaaHVCKzhHRHJvMlN1RVdXNi96SWhOU0Rwa2hpeXZyMVQ0NGJiSTYzb2c1?=
 =?utf-8?B?b21jNzBOYmZZUmJieW5xZFpqN2lTUWp0RGplNlVLZHMxdU5Hdk1qY1o3Rmtq?=
 =?utf-8?Q?VlseV7D6TtJNdDaOYQ9LcSs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f1e420-8be9-4a13-9af8-08ddf156936d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:13:50.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: meh/MULGEd9tEX5dWOyvDuPlC/6FVJmC7pnLGRD5yAADe3qoEze1ul3CMLVobLp2O7P5XGawo/RN3q3GjH/cOv+8K0oOu4iQdr83fB+WnUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5639

On 2025-09-11 12:02, Thomas Gleixner wrote:
> On Thu, Sep 11 2025 at 09:40, Mathieu Desnoyers wrote:
>> On 2025-09-08 17:32, Thomas Gleixner wrote:

[...]

> 
>> Also why does rseq_fork() set it to ~0ULL rather than keep the value
>> from the parent when forking a new process ?
>>
>> Whatever was present in the parent process in the rseq area should
>> still be in the child, including the rseq registration.
>>
>> Or am missing something ?
> 
> Not really. I just made all those cases (install, fork, exec...) behave
> the same way. It's harmless enough, no?
It does prevent validation of the rseq area content across fork in the
child process. I do not expect this to have a significant impact in
practice though.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

