Return-Path: <linux-kernel+bounces-876596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C7C1C6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B5803B76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F0346E45;
	Wed, 29 Oct 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="iT8DUU2L"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020085.outbound.protection.outlook.com [52.101.191.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FE7347BD1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753076; cv=fail; b=B8OscoztuoWirmvLK8sFuGMloV5LA+FKn1WM0oV/XzUkLcoe1hUd9bhJyDkzYDubmmJ6debmDw0i9tHURu6izvoAQvTZga0XCywX1SaoRYvtGSXKEgu6+gU5oefLtSJte7+81LN9mcXi1u7tYrSfUJ1Ze9+YY0w7eCOKkLnppnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753076; c=relaxed/simple;
	bh=gW1bDkIYwvt/Xmnpb/MWv6lDmC6SWWqmaTlbViv384U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IWk9Ib55XLzk7iZXhiZdTUmWGzdA05jhsGyki60RoP5hbeIcGOHZDiDJOEsZD24PE178MsgRIM6EyhlRzsT/TRqrLDXpGiE6paAw7nu0FZx/eIKgyiZTlssfamgfWQ4szgLifEBRQYMWFFoO0INAYrEJOfwFMnzM7NbwtJvTKbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=iT8DUU2L; arc=fail smtp.client-ip=52.101.191.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNVLC7+uMI3eTW3ElSrKx26B+TvnqlAeOh3zAnspOZuP3uLph3oYlRV8K6xbodxSZ8GkmjimlFNIB610wAjdOvotLfDRJvGZGma3euHcQVwZ4aaKf6KnKLEmWBOR6/vOW1VDdK3xEkFxmFr6DGwvzKVn5pTJsI043HC3kabd7ntokK+w4qeezqIbsM3RpXxturdW3NZ0feypIj9ALoWdhmZ4JP0CRHSBOiM0MiFtGZonBpDiDLAqXyRRW3DGjLOBdtcNWduwb/AL1fmQg1uZQ7T30c4gH6DY7/bHjXxF7jiNZZG6gD4GpZnM2ysGyKHIQiswLAknqcrdKn7qmWzVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Phw4uUnGFhqFqsJXpWyvt3XfOAtLsYmh708z+pOq5Q=;
 b=l5d7pYywpEAUisLVFJ9Cg1f+QhyTHFcwQkUSOpO/hve0I6UDfUAeCuE+IZi52LcFcAK/vuAg+ZdvKdhUePzyYIpJ9DLZAT6zpm5+95sjT5fnHHEC2lPWTZGsXw63YnoA/EtTtnFAsdneWSVzeRenaRb9nyz/E2UsSs9h2/zt94lJVP97V+Ky0NdWRH50oPpIN/D1TvtPxncvo2beOkezhhb+TtCBbGwSKB9npQaYns61DaF8p1bEs0M6Bqv2O324ahkao0avRvDQ7j63JH2343/V3pyInn4xSPHe/MuEJzaDpWwSwsT01xDWkKzmhKQKfLRPZ2oks6KA3W0VnQGYug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Phw4uUnGFhqFqsJXpWyvt3XfOAtLsYmh708z+pOq5Q=;
 b=iT8DUU2L1JTZJwSEk3OMFf8DC+7O8xG7kZuLtJpEmy9amga5Z8LHYWoLJ2VNN3aQkcmBnQxTOyf5KSr7KdLuKhWt079KKI5eUFWbey2ZMZIOiU/QAhU12vVcNH1t1C8HzFd4PcdTzC2qG1anPfONh1mDRQwSabfT3JuCxSoIRYsGQEM1QV0C+TsIN7B6LuEI2hNptPHCOVvP+e/nVPPAU1Ni1wq6wlBZwOi5A3u6TpMj1ckHDnqafa8MpNtWjJOB0Qb8Pqo6m/QZQsbpD7YmbYanHz3/SfLFYUoGjeHx0EH3PUkOOSRq7ycNtb4c87mxbHIXI83cv5iKQaBi36KCyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 15:51:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:51:07 +0000
Message-ID: <4b807c64-92b6-4604-a277-68d9b1bf972b@efficios.com>
Date: Wed, 29 Oct 2025 11:51:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 08/20] sched/mmcid: Use cpumask_weighted_or()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.780864526@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.780864526@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a57037-50bc-4e15-02d7-08de1702f8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGQ0S3BJcDdyZTNkNHNySzVGZkM2ekFlZldLdkk2cjJGYXF1Y1RqVDNuYVE4?=
 =?utf-8?B?M1dyUDJNSzAxNkRsdWQzM2tHM1VSc0NrVkU3TGF4WE5SenZFRTNpd2FGWHFY?=
 =?utf-8?B?V3Z3MGlxTnlwWkUzVVQ0eEt5VHBRRk5mRmExSmQ4am1ZZ2xkUEVwT3RLd21N?=
 =?utf-8?B?Q1dsdW5FRHJFd0NDWGlBczhxZVJQWWpva1Z2TE1pRlR1SjgxdUc5bW5zNWNB?=
 =?utf-8?B?SDJ1U0pnZURQTStqL3U0bGFlYW9XZy83WWlVZks2djJMRWdIeElmVkdqb0Np?=
 =?utf-8?B?bTZMZS9HZHhGbG5ROFJ1RWhsS0VicFFIbjV2WFlYclVDRTdwNllZeUZFTTRv?=
 =?utf-8?B?NGRSMnJwNk91Njc5RXRKV3BxWXZvUGZVZFdaU1Y4RXhPUUlJR21HZG0wQ1dN?=
 =?utf-8?B?MVlkekhneXVMY3BqendXclNwNitXN3lVV3pIVE1oZFdUZXNHRDE3YTkzWkM5?=
 =?utf-8?B?bTNxWDhKUmNuVm9SOUQ5NVc0MktwckZHS0JFQ2IxS1RNdHYyTkMwY1FkM2dB?=
 =?utf-8?B?NTRrQnpnYmUwSk5LVHZJdlFpbTJ6TmRkZEZ1Y2FyR1RNT0pDM09ITDhLUnZx?=
 =?utf-8?B?dFNTMUhMUi9aWjNweVoxcUxXUmdkamY4KzZ0UzUxUTlNMXh6bmpWVDhFNHJu?=
 =?utf-8?B?U3c2MzVzZXZlVG9BenlMZFgzWVhRR1Z4T05Jb2ppVEEzUSttYWdxM1NkRWpo?=
 =?utf-8?B?WjFDbEZBQkwrVG40Wml6bFNMTTgvVjFmMGFic2NHQ2Z4d2NsODRtbThZM1ho?=
 =?utf-8?B?N2VpK1I1SzArb011L1hPRi9OZ2RaUHZmdHhhK1R0M2FKVjVYTXVNLzVOT0Iy?=
 =?utf-8?B?WWR0Mkd1cG9nZUtlRERjZWJyR0JlN1Fra21FMkpTUmRQZGZlcENNZkhZVU00?=
 =?utf-8?B?cHM3NU9CdTY1NUdZcG1zYUM0dVppK3hZRG9IRjlPdXB4UVhaVndoN3llSHNQ?=
 =?utf-8?B?Q2I1TzdXMk11NldBVDZHY3EyNlBaaEl3UmthYjVGRThEczE2bjBCYkNyZTRU?=
 =?utf-8?B?REd6OWQ3YUpFYTAvcFdheFhTSVpnSnpWNzA4eTdDRHMxM3c1MHhIV0NqRkdF?=
 =?utf-8?B?U05Cc3U0SFl1U1lRUGEzYlhmZlFoaVpqNVozSkZVTmV2OEZzbkVuV0QwL2RU?=
 =?utf-8?B?eERyMmNOT3UwSHpoam9tTitKbnJpNm9SKzY2SWNERXRXN0FJU1hibGxPblhw?=
 =?utf-8?B?UUl6anBIUEhucUFWb1ptb2YrWUtpZ0xOb2dXM3NiU3RvdEVOYVM0Q3gxdS9u?=
 =?utf-8?B?SFUwdjROTzhzaTNKaHhQTFRwNkJCTTl5dkl1OXN1WHI0UEVCRm0zdWRvRlov?=
 =?utf-8?B?U0tHam9aR2VmaXlyOTc4VFRXcGhIbmhCT3RIR0pJblM2Q0Z5QU9VZWk5eDYx?=
 =?utf-8?B?U0l3V0FSUUFzbzN2UlhsUllIUTlCQmtnTStKOHBGUUU0VUpHcnN1ODM1QVJB?=
 =?utf-8?B?ZGxXRFpYREZGcCtPWnNTTHVYbGxwSnVyV1c3VmFyajNSbFM3Rkxsditjc3dJ?=
 =?utf-8?B?VDRYNCtudkowSWJtWk9LaVpTZjFYc052ZWhiVm5rMnJsY25zdU4wZTRtazR5?=
 =?utf-8?B?MTRxZ2NVSU1KVndzZjNxMlNtR2YwcE0ySHVEQm4wdmZxdldJTDcrQ1JJcm95?=
 =?utf-8?B?eXFCcWp5RE9HRHZRQ0d6YW1SMSs4OXRha2s5K2JtZm9oTjJ1eSs5S1dHa0x3?=
 =?utf-8?B?RXNldDRsaCtnL2dkeHhYQlFuNnRTT0tFSllZSzFtcDltL1BoZGc1ZGozMS9H?=
 =?utf-8?B?N2c0ZFU5RkhKWk1sV3ltRjlkSC9yblUrRHUxRGhvZXhHeWkrbFN6cG1LUzhq?=
 =?utf-8?B?U2lnY1J6Z0poM1ZKUHVMejkxU1lJZlg3T3pTaFY1eWxZQ1RtVmZ5eEo3Ky84?=
 =?utf-8?B?Y1VEVTdNWUZma2dXR1cxQjZRbVZiRkFTMENNSThpUlRVT1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXZlbWtmckdBeXN1RWR3WGdnL3QxSkQ4bTRwcUNtOXlRR05aN3JiZUk5d0gx?=
 =?utf-8?B?b0YyVFRMN3NOTXJlMlBGUG1QUnFDanFsMkE1SXpLZHlJazNqbEIyOXpqNjA1?=
 =?utf-8?B?UDBxeVRST1lxdW9nOCtSWUxWbVpqTkNqaFI4dWFJbjhNekg0YktJQXJJY2oy?=
 =?utf-8?B?eFgrKzhha0grT2crdUZ1MU9qL3BCUmNaYVozcENySjdVcU9ZRWIxSFBiako1?=
 =?utf-8?B?eGs2dlptSEwvbUFEcTNQQVZsbFVodHdFejlHWmZGREVMUWdQYTFUUThOWWRU?=
 =?utf-8?B?UHFIbHM0S1NkTGdmTVdtRlhZa0k5aVF6VVRrRUt2eGVTcjJSb2toVDl0SHla?=
 =?utf-8?B?dXV6WXRsaEhWODN0TzcwV0FSdGNzRVJNY24wb1hEV0VFdmIxWEFzcTZIUlpF?=
 =?utf-8?B?RmpLaW4wbzdIZlNBVytTR3BEVVJzVCtVMCtqdnVvRkdpakQxUlNjdmNSVE55?=
 =?utf-8?B?am1IbVFyZmhGQ0Vkd3JlQ2hwRFpWOTNvQTJCMFAzZUMvdlBoaHZ6Z25FN2wz?=
 =?utf-8?B?d0JmU1B6OEVVTW1HWkdjUTAwSWtDWUlLdWh3WExyQkZWUnRKMFJYOVp2dlNQ?=
 =?utf-8?B?d0xrbHZybmJVUjNuMFlBOEVuQjV1UWNqOFdTQ1prQTV2M3R3d0o1Ry9iQnA4?=
 =?utf-8?B?eHVwVnR3YVovNk9HalQrdDZaMU5pQlhLVmVhNnZucFozVzRhUkFyODgxUmxC?=
 =?utf-8?B?UnFRYmlxbXhINyt0dU5hVkZqemJ1YkFYd0JjMExlVm15VU5YQUtsSnpxSTVK?=
 =?utf-8?B?NFU5b09iV1dqUFNwL3ozOStGNGM3RTNSdFJ2aUFwczRBZTQ5TkQ3ZjlpZ0NI?=
 =?utf-8?B?VVNNUjVVZ1NTeko4elg3OUE5bWVGYThyLzdVZ2lXaXg0cExjUkxPY0Z5VWxZ?=
 =?utf-8?B?VUtRYjlZQXk0d2JNMFF1bmVQYmc1dmt5S28wMkZ4VzNmaFFZT0NBN2g4WXk2?=
 =?utf-8?B?N2VLekhxUUNEVWNicGFSUEUrQnhEU296bGkyRDcyZURUUmZ6QzNaYVQxcHd5?=
 =?utf-8?B?TlVlY29zZXhJeUM1MDhhdmFFVU9iNGVIa05DZWtRMUgvY0NqVEkreFVXcGY5?=
 =?utf-8?B?SlZyWHI0bThTbEFkQ0w5Y2UvNmZPNStBSUxWdVNmKzhkY0FybnV5bmFqSVl4?=
 =?utf-8?B?YS9OMERVMGRQa1E0STFobElXc3p2eERqN1pXdzk4UmxYbmwyTm9MUW5YbnN5?=
 =?utf-8?B?dStnZ2hublNGMXQxOVlrL28zdm5hQm1nSWpCWFJJM1MzUmVHamJLSUVyL0Z1?=
 =?utf-8?B?UmxoS045dnhXT3ltaU5sbGFmS3RURUhNeVBPcVlEUEVOc3hGK1I4UG9MbDZn?=
 =?utf-8?B?STlldzRneWNTUmo3MlVDMGRFV0QxeVZpNHBjUS9SY1RHUEx6NlV6c3BWOTd5?=
 =?utf-8?B?MEFIWUp0bllOUXZCTktEWmx0Lzc0MjlNMnVIQ09PZW1Db3UxWFNtZFJjTllV?=
 =?utf-8?B?WUpDNkZJcTNsSWtjU1BTdTFHbVdYTXZseExWeXVzSVo2WnJMU2c1N1N3OGJ6?=
 =?utf-8?B?dFliOTJnSnl5WjZPQ0RqOWhFbmdRcnJ2ZTY2SjFGdnY3RkQxN2FzV3VSMVdu?=
 =?utf-8?B?c1d6anhvMkpFM2lyVTB5RU5CQzB6UUZsbWZLelhNS1ZkMWI0K0pmOW9CbUIw?=
 =?utf-8?B?THo2NXJsakJkRHFOS1lLSGhtTmhyeGh1cUc2K2ZsbUxlQlBnS3N4K29rY3d3?=
 =?utf-8?B?STFpNWRpUkUzdUtXSjlGMTJDMGdBVUdUbTFQRldGWVZ5d3A3T2o0NXFyQUcz?=
 =?utf-8?B?eE1OdFdCbVkzSU9CZnBUT0h4MFN6TWhaQUtaVk1iZGNlR25aRXdwNjI2TFhX?=
 =?utf-8?B?TTFJV3Q3blVxdUlMa2FBK3RSRTc2dE9UZmIyNVlyK3E2c3g0SGhvb211WXV3?=
 =?utf-8?B?Z0FVRlJwNC8wcitUM3JGSnJQYVBwcTBOdXV1RWN3amYvRTNWSitvYW1QUmdJ?=
 =?utf-8?B?R05DRnJQZTlwdTBua3BZejZEZTRDZUduMGNJUTZEdkZPalJKYWZwWEpjSWVp?=
 =?utf-8?B?d1RvZmtIdkc2T0R3ckpaUFZwR2laeVluWGFsRy9waXBaMVVaQ3d2NTM2bVY4?=
 =?utf-8?B?Y1lWcU5NaDMrbWNVYXhRU2xQRXFOR1FUWThycitNNUEvNmZWVTc1d2tUaGZI?=
 =?utf-8?B?c3pEZ0JaZ3k3Y2VzV3VWN2tMRVdhTExsbENmQ245RTEyQldGMGFVV1FiYnJ4?=
 =?utf-8?Q?fw1+RLc1ByYz4xvLIxLnS94=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a57037-50bc-4e15-02d7-08de1702f8a6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:51:07.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/SdC/1gOSxwXZ4ut2x0WgTpcfFETU21kXmjUInrkkoDL9YxLQzJNJWNL//8jLfTmc6majMoglaHrvcNstOtnE5uEiNMtPvf5qX7tGhqZyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9027

On 2025-10-29 09:09, Thomas Gleixner wrote:
> Use cpumask_weighted_or() instead of cpumask_or() and cpumask_weight() on
> the result, which walks the same bitmap twice. Results in 10-20% less
> cycles, which reduces the runqueue lock hold time.
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

