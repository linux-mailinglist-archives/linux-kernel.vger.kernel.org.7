Return-Path: <linux-kernel+bounces-785461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E1B34B11
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9C3A3256
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAA2853FA;
	Mon, 25 Aug 2025 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PDx5OeII"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2113.outbound.protection.outlook.com [40.107.116.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6C42741DA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151021; cv=fail; b=fiscxNC/DWcYDwlu0jKuuJ57JlSpsl/nsRysyjKKLVQASz9G/yzWQOKvEIU95inb9183c7IxzOyBAB2UX889XFhXQkRfB3rYtUgImdMUzCtqXMTECwmYfLdXxuB28X6l/CITgvhUPv3/58WsdArDI/xlQKA0u+lnhnCiN+dOWDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151021; c=relaxed/simple;
	bh=GRjK6wSNmpnkJXeYQgMNHcmN+6COAbQOK8g2fDfNr0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IngXjSVOv/x8R4GJoH2yi6KmYXuwq7EvEBsPvQHHxQd3u+MNuB+hLCx475wIswh0lu33EfJMqV4DiUYsTR0r4gkeWmvMI73dmHn0nhO4zYV+xoJUb+7e58Vbhfaleyont7yMBQr2OUJ3DWYp7yEWXUToC/AVFyb4zqaCPaT4VaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PDx5OeII; arc=fail smtp.client-ip=40.107.116.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJ30f+AK+oCXQDK3NkpY1buRSiQQ1XHszxYyXFXxlO7zg+Gr6znc7S75X89otvHZusWZQgXlEEYU8gNeh6UhyQgD6yGG0haRpKAu8gfMzV5CHAm7LFUXKhUqP52sHEi1z/PsQ8LxRzFv3yO04RsEHhcSdRgcvAeeWaBjKqEZf88rS67E6x1BkmsfJRQWhkMVR2egDvUOlFO48wo2nsHxjXFDWjtTr1AjkPLl4yihCJv0vh7HmrAiujcjafiqefFCGv4Jd0MfiLuCH/PCiiQLWFY4+9+cRrl+7gG69RenEFhA19pY3Wiyv6IRuQy2vtpJa1zxo9+ms16EjTtfnIcIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS9B3UoPfQvLegefm0AKd7nC0y+IaQCOeN5ccuYjk/k=;
 b=axqAopnYXGVQ0zXKfUDlYxeF6KYJUxfwhxkZgYQ0+AHnLjuZcgbLGBHuPh4dVqmlfwBsa5Sds9QfO+uHqmN/GGNN+BvnFxQcsTD82dkZ3suapqm4ulUH4LDAoY+USClukneXPBEKT6ywiU2EyxhlR1IzcBEIDkpAndLMBswEnyAPyiYOGcOmg/O1viu6HSMZs+SsnKHYGqktjqhIETuw9vLxiu0XmCu8Oa80wHbxmrsynTpb1Mjd/RZzqsFP8T+oB+h4VQu2c9zmodF9HB1MNeFJaVnu5oKUR+9JLNMiDbmsse/3HFQOoQaO6t8KwT5rBF/bgrkrTHGxyM6KwXH8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS9B3UoPfQvLegefm0AKd7nC0y+IaQCOeN5ccuYjk/k=;
 b=PDx5OeIIeVYhYjxa/d1g/kquQYL3rErwnn2R/AZAq0HIZH14FItS2JozQ/UsGp8SEZqa6wJythv7+wushfrKQV1wAwQFDJMpQMReyhQJH60aGfuAifYZvsyZCRtfFR9tTkQSzQl5DwnF+WC/iIAtRLBKbUv4RLv4IOFgHduqr1jMURkAqc0a2mq67V4at9SrRJeAPcpfHr16X0YfyabnP0jKNAOPE9o6O+TTULSAdGsyR2UC2UMInrp+dMlrVqcDXkl1RiBJ3Cy/VDvmlN7M7XvP4sYRHwHevaRMwguRfd7iosLlI2Aj2nQv3nTq7burZklWtHD6LDIQA3jo01/krw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10568.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:70::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 19:43:34 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 19:43:34 +0000
Message-ID: <0090fb14-e78f-4b67-8933-bf9ef89ba0d9@efficios.com>
Date: Mon, 25 Aug 2025 15:43:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 37/37] entry/rseq: Optimize for TIF_RSEQ on exit
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.651830871@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.651830871@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0249.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10568:EE_
X-MS-Office365-Filtering-Correlation-Id: 7634fa7a-b37d-4724-f00a-08dde40fad83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVB2MTVwZ1YyUG1xcGo4enRsbG9WNXJmdmYzMG1KYm9JdnFzc0FzVUxPNmpj?=
 =?utf-8?B?bVBub2lUa0FReEtIVlVkaE9VSWVsR1hJTXJRY3FRRWlvQnB4cENhQVA3WUVv?=
 =?utf-8?B?WkdhbytBTENnbTFGSitXUjYyS2lpcWEvSTdoQXNOdFpxQm1kMGdTN3EzZ2FT?=
 =?utf-8?B?eTc3ZzJIWXdVRzFnSGxqVGdmV2xGbmN3S0tXQ1RWT3ZPWi9wN2pudW5lbkVq?=
 =?utf-8?B?cTN0WUd2MUlrOFFCdTVFdzFNUTZnbm9xZ1NycndQNTVWWER6bmJINjhsYk1O?=
 =?utf-8?B?a0drV1laNHFQS0FINGZsYzE3d3g0U1RNWENpZDJpUzBpWkVsVzhxTDFjcnZH?=
 =?utf-8?B?SFNZZU9XT25ITURLNlNCa3k4SmxkUnRkaHh1OW90N1BCcSszT0M2enhMcTFn?=
 =?utf-8?B?Q1FsSjhIa285bDlHR3J5RjZETW8xb3pCTXlYcFJYNWVKcXVwaUJISXhFNFdW?=
 =?utf-8?B?RW5WQmZsdkpzREcwQzA0V1VjN1J0K0dMMHVQSWphUW43Yk01L2pMOW56VEFH?=
 =?utf-8?B?ZksyemxwUWw1aFRkeFk3VUtoc3l2K1JDdGVmcERtWE90c2pzWUt5d01ITnpq?=
 =?utf-8?B?UmNxNWloZnZoUWRjK2l3OXkxbmNYY21FRWVjVXcybStKRlAzaVFteGlVb0Vk?=
 =?utf-8?B?VFRYVkMveEsvd2d4L3ZCU3cwVS80S2NCZFk0V05BVUh2endXZEZ2bUhZeVJC?=
 =?utf-8?B?OHQxenpweEo5YXFjR3NJZlNWMnFOUXZpdXVuQzAzeGdhWUljYzhub0h4L1Zu?=
 =?utf-8?B?QytXNGRhbGNGRnlsMFN3UExsWjg4aEg1azZac0xTbHVSdGFqcDhhdGEzam1h?=
 =?utf-8?B?dmxvSjNENjNjcE1vUXJQcDl5UDZaL2NSOG5MMkdYejhYR2tCN0R3bTNxUHBW?=
 =?utf-8?B?UUhqUGpIYk82YVJ5c2l2SUZzQWtsUGRrMUhUbksvV1dJbkJ1cFBhWXh0UzBW?=
 =?utf-8?B?elY1N1VTQ2Joa1pXRVZIZ0JMdHZsZm1kNGFUNndxMEV6UlBhcTJaQzMxQVBx?=
 =?utf-8?B?cXNsNW9rYmVYcU9La255V2RxQzc3TXpGQi90OGtvV24zS1FJcVo2cGVHUUVz?=
 =?utf-8?B?amRZTUpkS2o3M2E4NjczM294Rm9RcmVMRTE4VFFxYVFSSzNMZUR0RFVnS0wx?=
 =?utf-8?B?TXR5bXBmWE83M21sVlNJSWJMejJKckxSL2ZoRkgvY1psd2QyTVh3YmZSUVA0?=
 =?utf-8?B?ZzVsMHlTS2pvMkZSYTFFZElaV1dJSFJRZWs2WmlYbVhMOVlnYTcwdC9zSUhx?=
 =?utf-8?B?VnRROXR0TGRLeXVieWRjRW91MTdWY3NDaVM5MzFMMjFBbncxVzdDckZyNXRU?=
 =?utf-8?B?NFJxaytoSXlXR3V2OTk2cmdPVGd4cHlDb21JMlZrczQrYkFlbEIyT3YxS0RV?=
 =?utf-8?B?V2dZZk5CV1ZwV1dnNWFxbThRMHBFeXlDZEFFNmJhNTNkWWU3TU15enZLVWUw?=
 =?utf-8?B?TG1ISEdHdjBtSzIzS2RlUldvM0FUTHRyRUJsQ0dwanJIbDFtMHF6TVF3MllK?=
 =?utf-8?B?OS9pcm9VL0E5WFRNenlwSGNZMWtSMmE1RkdVRHdhcytxOGdzOWszSmpIQ0Zy?=
 =?utf-8?B?d1BiVHpGRTRQVzBzdktsYzRyUkpLZFEwbGJRUU1KN2U3QmpzNDdIWmRmS09w?=
 =?utf-8?B?L3l6WmhQZFVOMW92OGVFQldCcnQva3VzTHJhTTJTRnNUeWNTbGxrMW9LT1Y2?=
 =?utf-8?B?bnZWSTgxZjlicHBoRVdMTTZsY000TVppSEgyMmI2NkRCWGIwYVpyYzZZYldN?=
 =?utf-8?B?Y3kvN2JQY1cwcDg4VkVaUnNSZGdmZVAzVGpCMFlueTQrSElCRW1nZWJUM2dL?=
 =?utf-8?Q?cmxOyQGDYkaR1CSqC19WDb9KC8ZQWwzPFrwrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVQvcGpGc1FBdVJvOHRZcmJjeTFCRTRTTFcvWjNBbS8vZUEyQUkzMkM3c3pW?=
 =?utf-8?B?ZkpFZjRWYVNVekFQYXh2SWYzQkxhYjZvbGdUNWdkM3kreXVnMWNsU0NsaWxq?=
 =?utf-8?B?Q3l2eEVqamlTNDJQQXVzTFJGK2ZpYUEwUFduWlplL040WW9DeVpyUVhGdGpF?=
 =?utf-8?B?bjdyV0sreUxYRG5UeW1Uc1dCa240UDFyZGhpbkE4eFRRSS92R2dYM0RRb2ZD?=
 =?utf-8?B?dStjSndVZnA4MGhXYXJjbm9NMHV6Yy9HbjcvOTIwa25kaGpkcWhkM25FdnZh?=
 =?utf-8?B?emMvK05OQ3Q2cWxMU2p2RGo3TFRYWTF2RnllWEZDN3o0dzVzZTlvTGMrL01r?=
 =?utf-8?B?L0JQSTF6ZHBDUjJmT0U3dXV2ZzJjb1crdkFGdHNzZ051VEE1L1ViRU0yWG5T?=
 =?utf-8?B?M1daUzFpMWRtZ2U5TTNKYjBkNHZJZnNiK0pHdEo1cURsQUdNWDN2UEZxaHhR?=
 =?utf-8?B?WmhtcVhLU0dBS0M4YkZieTNhQUdWUnFpM21zVnZiaEoxTmYwTXRiN21HMWp0?=
 =?utf-8?B?SXZPcjJ6aE9nU1B6YlNNZHVIL1I5MmswS0Z4WnIvL1NNL2lMR2Q3bGFleXhE?=
 =?utf-8?B?Tzl4d1ZWMk5EYXhVa1lXellIV0ZaOUU3NkdBSU1xRHZVR2NUNjY3OUZZMFBj?=
 =?utf-8?B?KzV0ZGtSZzZKdlNrdXNnTWJMOHVIai95QmZmcTRmZlJMbmlCWTBCQVFuc2dG?=
 =?utf-8?B?WjBTbTd2cXhoV1NJNkRybHNpRVZHTEllTU91YlJGck11QVNvbzZhTWQwUytW?=
 =?utf-8?B?YVlpV3VOOFdZcnUyTW1JL0pKR3JiVUxOOGIweHVrYzF4ZlN5SWs4ZHYvZVlx?=
 =?utf-8?B?RjgvTUNxcWp6NDhnT1pLS2pENXVwb1RpV0lYV2I0NHhDdWZMd293cXdESjY2?=
 =?utf-8?B?UWJwdjBTbDFzY3JaVmFBV3BITXFzeDVDaWR2bHlYVTRMRlA1MlpmbVM4RWc4?=
 =?utf-8?B?aVcxMXZtYjVWeWkzSWpvNTBubE1nVlRySWRyNXJKS1lkeEVrNXZoejB6Zlkr?=
 =?utf-8?B?cktTTGYyOXltemhmRlJLZW9Md0QxS2hjUW55WXBxWGpKSlExUUlGWUEwcm43?=
 =?utf-8?B?UmV2S3VJUDBMNVBHSDRaVHd1U3pCY1R5WkhySWVLV0JxM1ZaTzF0NWhkQlJE?=
 =?utf-8?B?NzFkRHNOcC93azNORkg0dXhhUkNYVjVkVmNCa1lLL1A2SHBVVzF3ZlpVQzdk?=
 =?utf-8?B?Z05tdzhrOTl6cWtWVWZmb08xYy9MTENMSjRnNi90YW1FeTYzTGs3TzFWVDJT?=
 =?utf-8?B?ZmdNMk1rOXVGNEJ6UWprdHQvdEZMVGFIcXhkK012QmRQWGJ0bEh6QzJTREk1?=
 =?utf-8?B?d0JOOC84Qy9nUmlvRUdKcitzZkc0ZmJXYlkxMXF0LzdyZFpWZWEzR0FtN09T?=
 =?utf-8?B?cnQveHo0TnVyQTN2ODgvQzZXQmhpVGlJVVRkZGJBbzlYTEdyR3lOajlpa0xw?=
 =?utf-8?B?dmNNTklSZjBFN3F3YXZVTUZIWE8yZnJVem1DWkdGRm5ONmczWGZZbzNmWFJT?=
 =?utf-8?B?bG5CRTUwTlZtWDh4NzdwMWpWRGhHRVhUcmRFdEFlWlF1WDBCMGJhaTVkeFl2?=
 =?utf-8?B?S1FUUkpNYVFsbUFKdG1YN2Vod1RyTlRSL0ZVaDJwNEVac2NDT2hHaFVab1cr?=
 =?utf-8?B?dkFYcWlNSzFQZFNSRForcG9RVjB1eG1JZEo0cUdDZEVUVnJ1VE9QQXdYZGtR?=
 =?utf-8?B?QkpzNmFyL2I5OGd1VGtiZnZlaFlEOTl3MjJzSmNzaEpGL1NNSmtyVmQ4MWxC?=
 =?utf-8?B?SnUycmtRM2ExWFNKZk05Wit6VWZUajk3bkNNTDVMb1pGcExaL1VzWkhxeHNH?=
 =?utf-8?B?azNYeCtRd05Ka1d1T2RCQ3Fpd1I0blZDUUswUkF1SC9zVXBXclRsakp4bE9Q?=
 =?utf-8?B?V3ZYb0RpNXNpOFI1VXBVTnY0VUE1UmRReHhMVkJZTnRZVXlLTjNoZjQvT3VW?=
 =?utf-8?B?SE5waFg3UisxNEFLNGY4Y0Z5cjhvdDdMWEFlVmRiTGd4MDhtNkxsMmdQelZX?=
 =?utf-8?B?TjB0RndRbFVkcGFseGk1bUV4V3hzaWdaNE1oZkExMWpaZVV3S1lKY1Q0WjBQ?=
 =?utf-8?B?K3RBbExJUm5mSGk3N2dDOHJwQlRURy9NVzRieWpZbGJ1WDZ4Ri9ESUJxTmRp?=
 =?utf-8?B?dmxJdjdSNUtYUkdOYlhLSnZqVUozSFRnK3o0dDJBZzdUK3J4Ni9OdGtwR3JC?=
 =?utf-8?Q?4SWxR2suMUBj7xMvaDZlxfo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7634fa7a-b37d-4724-f00a-08dde40fad83
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:43:34.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsXGmz4DtkvO//3Py1mPZh0O1/H/NcQb0BU2L2ogzEm7lq03Uwp77NaVlyCnulCbxkmdSoUnG7qCQF9dmoXEBZTxUnD1o5d/6tv9tSysAYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10568

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Further analysis of the exit path with the seperate TIF_RSEQ showed that
> depending on the workload a significant amount of invocations of
> resume_user_mode_work() ends up with no other bit set than TIF_RSEQ.
> 
> On architectures with a separate TIF_RSEQ this can be distinguished and
> checked right at the beginning of the function before entering the loop.
> 
> The quick check is lightweight so it does not impose a massive penalty on
> non-RSEQ use cases. It just checks for the work being empty, except for
> TIF_RSEQ and jumps right into the handling fast path.
> 
> This is truly the only TIF bit there which can be optimized that way
> because the handling runs only when all the other work has been done. The
> optimization spares a full round trip through the other conditionals and an
> interrupt enable/disable pair. The generated code looks reasonable enough
> to justify this and the resulting numbers do so as well.
> 
> The main beneficiaries are blocking syscall heavy work loads, where the
> tasks often end up being scheduled on a different CPU or get a different MM
> CID, but have no other work to handle on return.
> 
> A futex benchmark showed up to 90% shortcut utilization and a measurable
> improvement in perf of ~1%. Non-scheduling work loads do neither see an
> improvement nor degrade. A full kernel build shows about 15% shortcuts,
> but no measurable side effects in either direction.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq_entry.h |   14 ++++++++++++++
>   kernel/entry/common.c      |   13 +++++++++++--
>   kernel/rseq.c              |    2 ++
>   3 files changed, 27 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -11,6 +11,7 @@ struct rseq_stats {
>   	unsigned long	signal;
>   	unsigned long	slowpath;
>   	unsigned long	fastpath;
> +	unsigned long	quicktif;
>   	unsigned long	ids;
>   	unsigned long	cs;
>   	unsigned long	clear;
> @@ -532,6 +533,14 @@ rseq_exit_to_user_mode_work(struct pt_re
>   	return ti_work | _TIF_NOTIFY_RESUME;
>   }
>   
> +static __always_inline bool
> +rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
> +{
> +	if (IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS))
> +		return (ti_work & mask) == CHECK_TIF_RSEQ;
> +	return false;
> +}
> +
>   #endif /* !CONFIG_GENERIC_ENTRY */
>   
>   static __always_inline void rseq_syscall_exit_to_user_mode(void)
> @@ -577,6 +586,11 @@ static inline unsigned long rseq_exit_to
>   {
>   	return ti_work;
>   }
> +
> +static inline bool rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
> +{
> +	return false;
> +}
>   static inline void rseq_note_user_irq_entry(void) { }
>   static inline void rseq_syscall_exit_to_user_mode(void) { }
>   static inline void rseq_irqentry_exit_to_user_mode(void) { }
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -22,7 +22,14 @@ void __weak arch_do_signal_or_restart(st
>   	/*
>   	 * Before returning to user space ensure that all pending work
>   	 * items have been completed.
> +	 *
> +	 * Optimize for TIF_RSEQ being the only bit set.
>   	 */
> +	if (rseq_exit_to_user_mode_early(ti_work, EXIT_TO_USER_MODE_WORK)) {
> +		rseq_stat_inc(rseq_stats.quicktif);
> +		goto do_rseq;
> +	}
> +
>   	do {
>   		local_irq_enable_exit_to_user(ti_work);
>   
> @@ -56,10 +63,12 @@ void __weak arch_do_signal_or_restart(st
>   
>   		ti_work = read_thread_flags();
>   
> +	do_rseq:
>   		/*
>   		 * This returns the unmodified ti_work, when ti_work is not
> -		 * empty. In that case it waits for the next round to avoid
> -		 * multiple updates in case of rescheduling.
> +		 * empty (except for TIF_RSEQ). In that case it waits for
> +		 * the next round to avoid multiple updates in case of
> +		 * rescheduling.
>   		 *
>   		 * When it handles rseq it returns either with empty work
>   		 * on success or with TIF_NOTIFY_RESUME set on failure to
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -134,6 +134,7 @@ static int rseq_stats_show(struct seq_fi
>   		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
>   		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
>   		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
> +		stats.quicktif	+= data_race(per_cpu(rseq_stats.quicktif, cpu));
>   		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
>   		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
>   		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
> @@ -144,6 +145,7 @@ static int rseq_stats_show(struct seq_fi
>   	seq_printf(m, "signal: %16lu\n", stats.signal);
>   	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
>   	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
> +	seq_printf(m, "quickt: %16lu\n", stats.quicktif);
>   	seq_printf(m, "ids:    %16lu\n", stats.ids);
>   	seq_printf(m, "cs:     %16lu\n", stats.cs);
>   	seq_printf(m, "clear:  %16lu\n", stats.clear);
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

