Return-Path: <linux-kernel+bounces-767109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04FB24F62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BFF9A2C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30F246BD1;
	Wed, 13 Aug 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BKhV59ca"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2100.outbound.protection.outlook.com [40.107.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0DC24290E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101671; cv=fail; b=IF2vrGFT7v9lTGjZiig1OufaYbHkfWyCaLkEq56aTx1Zky2S7KVgf6i/GJ34MeJqDUdrsD0MLbMUs+vksBked5SdDYDZvVzaVVZEYvW6Gis1FWGh+n970Gm5pd4DMKYHIOD3fK3eR5+DLWnRDH9YAMkI1wmgGuFgs2nV5rvqfRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101671; c=relaxed/simple;
	bh=DXA9Yif2ZkJzGmuT/x5SIVi41OWwtakonr9wl11UXcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fZeSDf5Dv4hxkM7i7v77/Kl54T9R2AbPeJiDGK5Bzi1urkm5mO1v2LWu2w8wH9VOMTIUoAQKxUNJfBi6f8EMbK9nSRwmGQZgKtu3uSaLxLhrZSOZR81SdO8O2Q6XUZnnYR/ZAQg1hRuEmHXms0hZLGvmSyvKPFqW4Oyy87vAe2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BKhV59ca; arc=fail smtp.client-ip=40.107.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsFuUtxVUELegnFNsT2uZpLRXw1rZatz2vprGxZkI0lc6TN6w93B/VzleYvDGHRdXaiukV/IGdhPEWdyJl3kAuRVVR3RCUcor9aLkyCzpSp41mDbzDAfTXWS2dkbkIwBRTrjnc1rBa7YxQzahVtt3yI/Jidus67NOAMCljd3iHC5DtiK7Lo/huzGVlzq/3BRZIZlmOZ3qdA4vF/JJd78RMXCwvcpotTWrSOUPx2AGfmqu00F5uBtLVPMgd4tjl6JS964qveorMN5iotDgZ7g79fMAMGXXGRR/9k4wzIpNNo9Er3IbnIi6eI89Nl/60buc9T8ut4v6UAdi33ntUsD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NplJr/3QPU3ykzRMEY2RZj89s0fmqRs6y8/gO2XaS1c=;
 b=sAQHFpncpOl1atqjJX0w/h5CY+OIyFzQ7pMo/lUayQokAncWXkbNNOCmibBCUaQUGPc9V43s1B9x7ppGxYzjW/FzOdQ1VCv/IiI0sdFJ6l7IOKzxWXm/rMFnjPQUBhOPLkl5UlviawHSel/HJXY8sH5Dy0v3qBsPmxOKMvCDTVCzOosG+W22/mzOVIoyDhMhjXZ2/cTvMD3VHWk3AE2yCC7CoopSa9HFfEkSJyqdu4tUUNP3ZKuGT/S1N+M3yRA8MO/T6v4OnGhXmYnn1aig3rsEIUiZibpb0OLgmzp0Qn8SOqTHYH2COP4MqZgBr4zYgNjCnwPkchYagTQ0PCcSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NplJr/3QPU3ykzRMEY2RZj89s0fmqRs6y8/gO2XaS1c=;
 b=BKhV59caahzzWRaQEPx1rVsxBvA56GM7NMHV+T4nb28f70gFVg6RLfRLHsyUlFJW5dH9aYpWpIofAFpFg33Q04x27juwKXMYLoPRLvdhsuRxWXqxBvHE6eZynCzOG1vbVPetIGckBiSOTgDhBtnXWxcIuEF+WKAK0Vd8stVcmVyUc40nw1SXIp9R1FrMzb4pEgGs20IIjjfkSzPv/FKrCMSbyGKppUc2L6KejKgl4QDXg7cEDjLMx04kSzk97Bh4rUZ8rujGiqB0KcX/Mz9CnhWYAWm2w/rY4LRI9oUussTkGBGtTJU89GfBjIqYhxEfxiNmL6kjkIEVmJg1hOsZtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 16:14:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 16:14:26 +0000
Message-ID: <a3e82f54-f2b8-4843-af26-eeeb7f27b25f@efficios.com>
Date: Wed, 13 Aug 2025 12:14:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rseq: Protect event mask against membarrier IPI
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <87o6sj6z95.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87o6sj6z95.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a08e45-2ab3-49e5-a0c2-08ddda847938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGp4cWFLQkhlRjBKajV4TkZlQTRNNy93QzF1dnYvdTZzbGF6SSt5NllGQkVK?=
 =?utf-8?B?d3V4Nk1Gc1BUM1FFL1ZVZ2tqbE9OcnRyeFFwWmdsOE8yU0RPWW8rU2FidnNM?=
 =?utf-8?B?VTdyVEs3NTBGSHNOZEo1a2tTTk9uODZPNGN3R1VSd2JYWWMvL3o2dGRzMTIw?=
 =?utf-8?B?eE1vNzF5ZUl1THlxR2pwdWovSVNhemtTT2VXNXR6WkdubjREZ0cyRm14WDE2?=
 =?utf-8?B?bHBIam5rSXFGdWdXNDFxTWQveGtiQzNyMFh4L1IzM3hNcFA2aG5HMGZPS0hO?=
 =?utf-8?B?K0Y5RXhDTytFUzhDWWZkSWxNb3ZTUHVwVmJ2RU5nS2lsS0NYV3BGMmFiTXVO?=
 =?utf-8?B?VE40TjA4eFdadW50L2c3TzFpN2dLSEthQ0RLUVRaVUt4NFRtQ0F6NGRkaU1o?=
 =?utf-8?B?NWI1VmJ6cTdvZVhRTjdDYis2RmdHN0ZydDBCclUvR3RaVlQya1l4M2xEdS9R?=
 =?utf-8?B?UmhQcGhZNmhaOS94QUtSNGxqdzJ1eTI0RFVObEJoY0hncndLWkZqckg1aFlR?=
 =?utf-8?B?b3BPWVBaakVHTm5IaXVqaWNDd0VlL28rUHgwazVoRzBvVE14UEgwRC94TUdF?=
 =?utf-8?B?OHFUdGxyL201VzVSSFJ6R2xERjN5QnM4aTdzOXhKT1RFdE5aMHhoSnpDMzVs?=
 =?utf-8?B?Z3RCZ0J6amllY0pWYk5hQ2QrTjhaa0R5MFZ0Y0N1d2Z6Nk0rbUE4S3ozWDF1?=
 =?utf-8?B?bG1ldVA5S1FXazliR0E3WjQ2OHRsZlRHeWpxMHdxNENNN0tSQ01INXR6b1hP?=
 =?utf-8?B?UlNMbWE0VkpENUkzbE9uSzN5RFF6cTkwWXN3dVNVekpqMEg1RGJXZ3BUL2hH?=
 =?utf-8?B?QzMwV3B0dDdaRmM1RlBGbklGZnNTbmFBd0RJcm5xVzllMzhsaFJwSk9QVFpq?=
 =?utf-8?B?YlhwdGVoV2J0VFNHWXY1dnJLOVF1c3VVUVpLQWl3d2V6dFUrNTBRRG9lNURo?=
 =?utf-8?B?Y1lZdjZPYkcyTVVtYThOSUUrdW1XUm9WNHN3VkRVYWxxb2tKZlFGVG1ha1hZ?=
 =?utf-8?B?VXZOMnQvWkZKTTZwelJGSTZHSEEyMUlQcDdmWStJVzFtZzZzOUFaRkdwbXJ4?=
 =?utf-8?B?TWExSEZ4czBZb2xuSDdtY1JKdkRpakE3dnVKeFYxK01GT2xJampuVlFjSTZN?=
 =?utf-8?B?NVdvR00xY240eFE4cFVwSG03QU9mUXVVQkhtbExrZWFRbDM5ZEJPbkhoMXJm?=
 =?utf-8?B?dldrekQrckhFWTVNQ2kxSFZyN3JtcW5HMExxT3lmOFNVeGExc2dwTndaa3Rm?=
 =?utf-8?B?SVhNNjJNcU05Ukd4ZGZLU2NUcFhrSWtxTGVya0gxQWpIenRlTVRuWHdkdkxw?=
 =?utf-8?B?dFU5TjJOOGI1RGozSy9NTWtnVWtjdVBsS1lRa0ZnV1Z0R2wrRUxRT21tWC9o?=
 =?utf-8?B?WGE0R3JMQ2ZidmhlV1hkdGJFdm1SeU1zTVhadzVCYlprVEFvOW1JczJ3cWt0?=
 =?utf-8?B?aWx2dEsyZk1UZ1NzSUJNZUFLdGF5TXAvR05rTlVZUEdCZjVDNWtoR1gzNXhZ?=
 =?utf-8?B?V0NnRjFtNFJRR2JhNnZQL3kvR29URy9XTERJOFdyaE85T2Z3YWJZVDdDcUZv?=
 =?utf-8?B?Tnk2aDd3S3h2b2NxUjNhdkNMblc4YnZqTnR4TEQxTlI1VERCVGlzNzZhSy90?=
 =?utf-8?B?ZlVjYVhBNUFUZUlGYU12OHRHTW1WaXQyOG0rRnFSZ1BZd3pLY1pkbFh5WEJk?=
 =?utf-8?B?QlRwOUsvOHVROEpUTXc1UnhDN1VCd1lSZEhmTXBwQTRiZ0Nzc1pHSWpENFJr?=
 =?utf-8?B?RDFoM0VDaUw0YjBWVDBiVHhVMENmQStsdHpzZ3lHQS9TMnA0aWhma1AxdGl0?=
 =?utf-8?Q?Xth4VORG+SmC+ogSUeEckwz/dD8ceHT+dJk4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnBHYWlJTkl6M0pCSURGOTlJWHBkTFpRL1N4SDlQSStNU2dmMS9WRHhYOVZr?=
 =?utf-8?B?Q3FDcFhVc1lyS3JWcTA5d2pxNFM3OE5udXJrWWM2TURtWDArQS9xaWxGc3N1?=
 =?utf-8?B?Yyt6Nk9wYmVaeTB1d1lrcFd0TURQL080Skwwam01VmYyWVFrQWJ0TDJIT1Vs?=
 =?utf-8?B?LzY3czA2c24vN3EzSVNWMWNoa3haR21WMEpSSVNBcW8xdUtJN2pHZ2pGbzha?=
 =?utf-8?B?WVpRa3VFN2NPVGNwTU9yVm4vRXU0d2g4eFYzcndrZnBWQnRrbnZORkJqZlpH?=
 =?utf-8?B?UmNOem5TWVNrNWRMbjZOMkJUcEdTdnZjb2lNU3lrekgrblV3UUR3aHA2QlAx?=
 =?utf-8?B?WG9yYmErU1AyQ1lBbU8wNTRZL3hhbHI1amVTZjBFNTlEZjhmMmNVUForOUQw?=
 =?utf-8?B?NFRzeEVsOXZkckM1bFlLcUROYWZsTE9QWjRHRWIwemdFcG03RU5ISWdyemxj?=
 =?utf-8?B?NjV3YWlqVDNLc0pod3lGTWl3dkJoZnhjVlFKT3hBYW5tQ2lWSGNya1FYZm1z?=
 =?utf-8?B?SkJhRVNLMDZJUm42VGFiMFV6eTB1K1hKQjVhU2FzWVJpdk5LQ1dteGo3S0Iv?=
 =?utf-8?B?Y1FjV0JuOEdVbC9ONk9mQjVYK2d4MUxNT0l1Q2owSU8vSmg1emFZZVdSR3Vm?=
 =?utf-8?B?dlowZnF1dzNiQ3JUeis3aURYWWw2Ky9lMlNFVnBRVWJEdk15VHNZMGpOVktT?=
 =?utf-8?B?MHgyOE4vMS9neDRBR2VhQ25KaVljV0lHZzIrVmNsd2thK3JDQkt6UDJGQkVu?=
 =?utf-8?B?QmxaOUpYQXp1ZUZXN0VEODVVdnJEazAwY3kyQjgzR3JYN1NUYWdqNkdWNThp?=
 =?utf-8?B?M2dkaFJoZXlNblB3cHZQa0IydlBBSG1HY3p0Y1h5aDFZejl1YkNJYkl4ZElO?=
 =?utf-8?B?Z25sNkZHOSt0Um1IaEd3Sm11UHhZNVF0aS82bzRYd3BnbTY3QmJvZmRua29B?=
 =?utf-8?B?YUdkREVJczJSak85Qms4MTlMajlSREwwVS82OUZsRXFYWTA3M0hLa2dvWHJa?=
 =?utf-8?B?cHdEeXY5TWRMeG56NHFWdXUweEJPMzNGYnhQdDMweXYvMDJrWTh6OXIzbVlM?=
 =?utf-8?B?YTZVWG5rL0t5SldhU2U5OUgzeDJXR0Zhc0tQeWQxVDhyYUwvbjUvVVlkSzZM?=
 =?utf-8?B?d3BZYzVBVWhVM3FTbUhvejlzYXVmdm1UelRVRU0vMGsrNmh0R2lMN3JldERH?=
 =?utf-8?B?RDh1VWhlS2RBVnhtejNFdGFRUkMyNGlwQzkxLzczRjNDRXZDNlVLUXByQ3hk?=
 =?utf-8?B?ODR3WmpZcWlPa1g0VHBMYXIxT2dRalhQNTQzeDd4Y1V5Q014MDhSK0s0VHhs?=
 =?utf-8?B?WUxndGtWZ3lTZ1lTajIrakZ4UWd4a3dGS3YzbWxkWGplRWpVZGRIWTkyRVVG?=
 =?utf-8?B?TURvNlk2dWhxbXBTQWdNdTB5YkRYOE00TVVjMFBBbzBXSW9JQzE3aTEvK2VP?=
 =?utf-8?B?MTJMdWIxZTZkeWNYUkdrMjZwaHMvWDBuRU1lK2gxcEQ2OWUxalMrV0NieWpC?=
 =?utf-8?B?d3RRVXltZmlKNnVuQ0gzSHh4anhQZE9WWDFjTTkyNUlwbUo4dmFwU3pEbEE2?=
 =?utf-8?B?YWRrTit0TllrVVFYNExCelJZM2FaQmVCQ1hHL2dpTlpaOHpwdW5DNFR3ZzNP?=
 =?utf-8?B?WUFvSG5nY2hMQkNYSnNTbmNCaVllWnUzVTgxNk1kTXRkclNwcHF5NkRDT1pi?=
 =?utf-8?B?OVJOV3ZiTUtlTnBTdGtkczFndUtSVXVvejlQYURKd29WRUplQjM1cU9yZEJw?=
 =?utf-8?B?NU82OCtGUG8vSkVvS0xVS1NWQ2NFSzVEVXk5TjVHTTJSOGVwZnB0Z0w5REt1?=
 =?utf-8?B?V0ZKRFVyRHlWZkl1V2M2T3dLS0pDOTdJMEllRmRmNzRHczI4VCtjbGdsRzJu?=
 =?utf-8?B?Zm9zS08ySEs4WDkxTFZudDN5VDBndVZjdHZvUzE5Vys3aWV5M3RIQlNOZy9J?=
 =?utf-8?B?RUZzcUdaVmV3Uk1jVWN0dkQzemF5eWtoY094UUNsaU9MQjFjeVpUdklkVWdX?=
 =?utf-8?B?VktjOVJwWmVNMm5YSEE2bEZscHZrWm5pUlNoUHFkbmFadVJrdlZQNEZlSXBU?=
 =?utf-8?B?UlBWZmhHSUhUL1ZtaUhnOUc3cnRJd015YlFEaGxXN0xBQmpXbXhxWjI0aE9G?=
 =?utf-8?B?aFR6T2RvYXdqZ2tOazYvTGtjYXZGRE1vamg0OGllQnh2SG5UNGx5YVc0Q1gv?=
 =?utf-8?Q?op9k50PCqW9ydHnTbaXOc9s=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a08e45-2ab3-49e5-a0c2-08ddda847938
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:14:26.2273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoPMX9qCvjDBG/JZLr+IcwGX4jWDoCDFF2CFq4XIAzu52+51nbEycf5+b2iK8khN5W542dFCRBZ73LBemU9icXvgpS+skokCsfce4uHP1lU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6099

On 2025-08-13 11:02, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 12 Aug 2025 16:34:43 +0200
> 
> rseq_need_restart() reads and clears task::rseq_event_mask with preemption
> disabled to guard against the scheduler.
> 
> But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
> from the IPI, which leaves that RMW operation unprotected.
> 
> Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> 
> Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>   include/linux/rseq.h |   11 ++++++++---
>   kernel/rseq.c        |   10 +++++-----
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -7,6 +7,12 @@
>   #include <linux/preempt.h>
>   #include <linux/sched.h>
>   
> +#ifdef CONFIG_MEMBARRIER
> +# define RSEQ_EVENT_GUARD	irq
> +#else
> +# define RSEQ_EVENT_GUARD	preempt
> +#endif
> +
>   /*
>    * Map the event mask on the user-space ABI enum rseq_cs_flags
>    * for direct mask checks.
> @@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
>   static inline void rseq_signal_deliver(struct ksignal *ksig,
>   				       struct pt_regs *regs)
>   {
> -	preempt_disable();
> -	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD)
> +		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
>   	rseq_handle_notify_resume(ksig, regs);
>   }
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -342,12 +342,12 @@ static int rseq_need_restart(struct task
>   
>   	/*
>   	 * Load and clear event mask atomically with respect to
> -	 * scheduler preemption.
> +	 * scheduler preemption and membarrier IPIs.
>   	 */
> -	preempt_disable();
> -	event_mask = t->rseq_event_mask;
> -	t->rseq_event_mask = 0;
> -	preempt_enable();
> +	scoped_guard(RSEQ_EVENT_GUARD) {
> +		event_mask = t->rseq_event_mask;
> +		t->rseq_event_mask = 0;
> +	}
>   
>   	return !!event_mask;
>   }


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

