Return-Path: <linux-kernel+bounces-827258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AADB914A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3665B18984B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353A730AD1C;
	Mon, 22 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OanEM/KA"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020101.outbound.protection.outlook.com [52.101.191.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A813093A0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546392; cv=fail; b=LFRRfkw4Dhfd0yAO2f5TM8jrqDYMIINh2EysgY+Us0yiYPTBXs5eZdp0KMJeJmHOKQvr3U7K20HmeETPABoi7H7guWDruhr/8xgBTY1koFir44opQfdOqrRKFYoNq5FEpCcsw6xMmAx1v51xeBgrR4YMQsAyEpVu9kyL2GaODq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546392; c=relaxed/simple;
	bh=MiWFnD4vG3nuD4aqAwJFsNUhAteuDz/cXKX5M+KHGac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QwwGhqkKtK7Yebc+X1VZj5bUhhfQC5TqpOYRdNU0mcQ4nDwM8bPUcN8I8bAspy5JnqJv5ZBcg3pmVYDC2tW8gaUyViN3bXI/hftj4UiZlWGQtaRJfYmgTmhTrhN80G5YXxJ5LoV6BxGKFj2vJcz+q4V928ao8qY7ga+P9OTUvTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OanEM/KA; arc=fail smtp.client-ip=52.101.191.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pcibYnHbmtfVftJq//l6AccyBntkYMOyKecdftkhcRWLjY2/xBZYTq/0EskSvyRRDfoUk9GlHUBQ2Puqldl+Z4GVrTb0MzZpO17MqUAWf605wxO1uGIzFTmUNXniuMZr3QeP+KOij6bNvl4wn9AIXwZwVOLi+xGZPnoOYT7KZVUmsE8fusean51iMg8yD+4j37P8UwrX6DCk+zf/A/uf3lbdzzw+ZpoVKhjU4KT74z/Am0+mSMaku+05D5jLbkGYIUBD3qad8lbc5CfgyFcDF5LIqX1+7iKBpu6/+hZdK6NA2cB532N7G6b4WAA/F4CofZxjZ7kQLT4YR7Hd7GSQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zUB6aFgGSAy5Cn4v/4Q/rJdkpC3R8c9Qbnb56I3YdU=;
 b=QXdC6RC+P+ZzEsaHK9G1N+PwndXahQY8NPqxDELcDKn2jRAogTAp2O7Z1rz2LuyqEUQFtbxXByXywuZN10/LRtLEwRylfcVKc4F1+08xcDgM9FkA6UlC74UNF6QqQrZNQ4zMnZJIlmoRCZrX5v78HoLgtOZTIg3KTciDImnl16yLC50B657DK424cj+n1MpLcI4Tv94UpmtCYIY6n7yIt5m0GSnCwtCJpJ3z2IhFRnRsT6X2/mMkqEO87P2IZI6nCEuZvxULcwG8Wmp2R+mgIyGR02YiudT4bH+diaEFFXTMblvEdSn1IOhf4ICk7akJje3Sa/Oeo+kSAGofpYW4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zUB6aFgGSAy5Cn4v/4Q/rJdkpC3R8c9Qbnb56I3YdU=;
 b=OanEM/KAVkxE9pHQh0Ao5ULlv7ueMjX1OWcnJgOr9NyBxwDX7JS+X6stoY/FsX8MEwvYXMdCViDdZx4B//8IfphaUGH2Bq9M/CthMYX5l+pg9zOVyiHC/U2o3NVFrdZlx8HDBYEa36rrcLITft1Ja9t/L343Kqo+Yl9uAVCmHycIwaLt4WCTTY2O/tFpNXIRXbxG2ixQ5/khlxhI54Tzz8tza0H3aQ+VPg9RRro2Ucemj7GjJ7/2u/9wT+qISCAYF+xnzdJsmpAuxe6JqLmqHQ23iBQyOIKiG+HlTbC7kbYaDqdbHq2/r+74iNJ4EVQHn2Xuo/Lo8ygi3+vFeWjQTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPFC1E5F08CC.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::28c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Mon, 22 Sep
 2025 13:06:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 13:06:23 +0000
Message-ID: <00b90f80-5ad7-4d5e-aef7-a81d88aa76d3@efficios.com>
Date: Mon, 22 Sep 2025 09:06:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: tglx@linutronix.de
Cc: dave.hansen@linux.intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Stephen_R=C3=B6ttger?=
 <sroettger@google.com>, peterz@infradead.org, boqun.feng@gmail.com,
 hpa@zytor.com, aruna.ramakrishna@oracle.com, elver@google.com,
 Dave Hansen <dave.hansen@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, mingo@redhat.com,
 bp@alien8.de
References: <cover.1747817128.git.dvyukov@google.com>
 <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
 <CACT4Y+ZcQV3JWEaeh7BXNwXUsoH6RcVRyG2iNUA+_mrOBOHfNA@mail.gmail.com>
 <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
 <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
 <6e737bd5-1167-4cc8-96c3-abc3d3598d2d@efficios.com>
 <885a517e-fe3b-436a-accf-9d8c6b991aee@intel.com>
 <CACT4Y+ZtFPSaNyp9m=cU-QZNeRz1GoUHE08TDq+X-8yAz34Rcg@mail.gmail.com>
 <CACT4Y+YQdjRyrQ_=sR4chrh1J5yRykXf-ck2ygNB9rzpAiyF4Q@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+YQdjRyrQ_=sR4chrh1J5yRykXf-ck2ygNB9rzpAiyF4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPFC1E5F08CC:EE_
X-MS-Office365-Filtering-Correlation-Id: 135f6856-64cc-459a-6549-08ddf9d8d48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHN5b2VxajBrVytPWElKQkFZNXduMTZ3SnBhSDRYSDA2L3hSSVBNWXdkanFP?=
 =?utf-8?B?bCt6Y1JUZVRhc01OZThEdDlXSlV2RlhNWkRrOTJTQjVpanh5QlFrWXZ4aXlP?=
 =?utf-8?B?RDl6OXIwV1dNeHNNUmpYaGpQZGxLZVFHdGlmcFRkTDNWbnlUMlp4T3FaSlNx?=
 =?utf-8?B?UTk3Y0hodDdiVjUwRXNuL3c0djJvOHUzVFIwRTFWRFRBZkZDUU8vUVpyQW1F?=
 =?utf-8?B?YTBYODdUMXZiQ1JETHdMTHBzZjdDNWtzNVhMdzdYQWNqZkdoZmQ5cGhNNjEv?=
 =?utf-8?B?TDFQVTcwT0FTeWJ1aFQwK2FWS1BNSXhEN3BkQ1ptVklpR0prQzNRWUxZSzEx?=
 =?utf-8?B?QTFUdTdnbllxdGMwVERnd2VKRWxpcU9sOTJNSDhWaFZFQzROaHNZU2lualMz?=
 =?utf-8?B?aGkrbWtwRnkwRjNYM1ZPUE1TZXYzL1dJeUZCcFhFME1Jb3RTUDNUVThNVmh1?=
 =?utf-8?B?TFVaQVVNWEVDOUhIZTFaVE51UktQaTVvUnpPdEwrNnMyUDdYRzhwYStmeGIw?=
 =?utf-8?B?U0RHLzlIVXVyUkMzU3ZrTlJlQVVYZ0VtWlZJNXpXd3RnVWtobkM2SmJvMU9K?=
 =?utf-8?B?TU9QREhlclpHNWl3RnNJSTlWVldzc3h5ME42WExRNVgrMWNPUWhhOUlzYlZO?=
 =?utf-8?B?LzlBQUxUYjhSSURVY2FyL1kwaWl2dlZKUFJzdVpGdFdpbmg3K044QUxhdmhm?=
 =?utf-8?B?TVlPWlNuKzRLam93cGJzTGhpdGYxTU1WRmhGQ2daM0gwSzlxdGRSWjBBVCtw?=
 =?utf-8?B?Q0dwcmhuekl0S3NJL2kzdzU1RmloSjJGYU1lclBveFl5V0g4VzlObnNmdnJz?=
 =?utf-8?B?U2lnQ2hiTHAwSGwvTTFwdmcyVkpLNGRlbEp2ZnNYNlFGTUlxWVVSVWVkRzh3?=
 =?utf-8?B?Wk43MVFiMG95Uk9Xc3IreUk5TzNnc2FPWTVKSUErUjVqczJadUFwSFJmcHgw?=
 =?utf-8?B?Vm9QY0pjNVVXa24zcXJkd2JBblJ2dzdDd2hVT0NaN0J5bExIQWZ1cUtXYXll?=
 =?utf-8?B?T2pqNGlFU3NQd1kzNjZhQnd1RGN0dzkwNzRWaksramVZTGhwa1RIL1ZLZ2xG?=
 =?utf-8?B?a0R5aUxpWGkvd3FvR1oxdm5NOEZOeXh3amQrakxNTlo2dnFjRGxJL3FNMEx5?=
 =?utf-8?B?eDhwOWNtQlM2UlI0ZzJRUmx6aWs1YllqYk5EMUhGU0VOTzNaL0hLYURxOHZw?=
 =?utf-8?B?c095RW1NTUdoUU92VktMU0JLREJLQ2UxUGlTNHgva2M3Zk5UWURMaTQ5bHNY?=
 =?utf-8?B?OHovbTFWS282eGdjVytFT0h6RU5IZ3NBaStaUVE0czFFalV4dUhjSENaOSt5?=
 =?utf-8?B?RVA1MjBybG80T2NzeVNDa283TWpVcDdPSGxhcUdsUGNISmt6T1dYbjJEZUd6?=
 =?utf-8?B?cVhIRWxUQUxYWUliMzFYR016a1Y1MkNDWGcxLzhYRW13cUpOa1FpQnpsSGI4?=
 =?utf-8?B?a2pXRGZSVzh3NXNBTDR2U2hCRnoyZmRWMEx0OVhLWXJwRDJUSmxJcldRM0Uw?=
 =?utf-8?B?dFhBVGVabGRRWk50UjJnTWxvN0t3WnJUUzRLc3ZQb0xITGtoMFRiaDMydEln?=
 =?utf-8?B?ZVkxTW9RZ0JCYUIrWSt0VWdFZ09DUHI2Rm9NTGRSTW9FTVY0c25SN3BZVUFz?=
 =?utf-8?B?bWx0SDI0QUVxVmNac2tDaEhWa2g2Vk5XZmcveGg1a0U3QkNlRWRuOUloSWlK?=
 =?utf-8?B?Zk84QnRKd01NZm5PSzRGRzZ3MVZFYzh4aEZlSUhHNi9qK29mV2M4aXJXWk1C?=
 =?utf-8?B?L2wwd0REWDJhSjZMSjNZZ1NCTjV3YTd2aTg0eVdNTzdEYmpsTWVwOHBVL1Rw?=
 =?utf-8?Q?6iANkMEZsnuzzgOtxNYUNEYqnfsr1NI6LZcX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUI0TDB2NGJRWHFVdnN5UmVQa1FSZzVWcWdxYmtZQ0Z4NllnZmN3Smh6MHlZ?=
 =?utf-8?B?VHdMQ0wzcXA1STNsbjlvZ0J0Z1UvSDFOVlhQNmNFY0tCc20zWGh4WDJzWGpY?=
 =?utf-8?B?SEpWRGV4ZU0vTkl4dW44a3BCdjU2K3ZpVjBzOFBqeWt0UWc5SXUwOWJqL1gw?=
 =?utf-8?B?NlVNMlJjaEZvMnNzYmNpa0dFcmRteng3WlRsd0svaTNJNi93alA3VVdpM25Y?=
 =?utf-8?B?ZDdaRnlQZ3RVK2RNUU1GOHBEb1g0UElMRHZwYmhhRzF3b05KRU5KK2VxY24v?=
 =?utf-8?B?RDdzLzdFSEFlN2NVTWZ0am9kVGU5cVR4bmVFcTV6bUlsOHBEZFZHNzJacExU?=
 =?utf-8?B?VFQ3TjBuandDYWRNSmFTRFJJYThZRExRd0R2OTQ5R3RYSkc0UkZjcE96ZmlW?=
 =?utf-8?B?eDJSeU4wa3Z6SzZxcmZjSVhGZDFXdy8vZGJaVTlpM3pYODU1V2ZsRklRTGh6?=
 =?utf-8?B?Z3c4KzNkM0pZdHJvZE92bEF6RklkZG1LQ2diZGtKcHdnRkJ5c2trMjl2NkVv?=
 =?utf-8?B?T056N09FMmRpeCtGZU5WYU1QWGgvSXluS1pMOG1VNTRxeVQ0V3VHc2hrL2Fs?=
 =?utf-8?B?MDFlTXl1TW5DMUN5Ny94YXREMDNhS0QrWThDZVpsMWRHL29JckVIRVEySHVB?=
 =?utf-8?B?b3hBakw2djdmOXlYVUJkUlFWSlBZelNRazRmM1B4NE04SmZDTFRhM2Z1ODFi?=
 =?utf-8?B?THkyMzNRTnVEcEpmVDlsOVFOQTYvYUducUc2TDQ1cUZNWElvODJCc2NxUUY0?=
 =?utf-8?B?UmF3VFloT2Qwb1dmWWgrWjBZV3lvSlNRR2orNzNENHVOb2dWYk05M2QxcWRh?=
 =?utf-8?B?bkpINHNod3VaMFFMMjhCMWxRTmJIVUJ2cUJoMmp6Vkxod0Y5Y3lJejZiR1hX?=
 =?utf-8?B?YU90VVg2QXA2d1JoSDV5REQrZmRKNXFCblhZQXY4NUNrMFFINkpGLzZWWkNX?=
 =?utf-8?B?VG1YWXlxMyszTndsZkZtYjVBSGtZR2RaR3NWMTZXMkw5Qm9VVC9jMWdlbUp3?=
 =?utf-8?B?MlVZUXR5eHRBT210R0twU1hWS2E1L3ZyMEJHNmtxQi82WGNHaGxnaGs4L25y?=
 =?utf-8?B?dTNXR3R1RGR0SENLN05XT0YrWFhzYVUrbktrVEJWYzVpTFJSU2pSZEF4cHE3?=
 =?utf-8?B?NjcwV3NQd2FvczA3c20zUVNtUTZNcWZtQ2lpQ3ROMDRWdk5FSUZrRDBJalBE?=
 =?utf-8?B?dkFVNVZIOWl0SmVQVWI0V0tkY2ttU2JoUkNBaWJTQ2JSS2NDSG9rQzEySXRO?=
 =?utf-8?B?eC8vT3lnWHRHSS9Wd1JEMUVDMGs0K2t1WUlTaUFXZjZaUUhteXdqQ2I2bVI2?=
 =?utf-8?B?UE9iMzQ1dTFBOCtCNFpaS2lyaEFkVUdLZHZCUzFVdDVVb3REamx6UVk1dEw1?=
 =?utf-8?B?clVOVEJiM21uM1dFdmhEdXA1aDQ2L081U0s3K2s2elp6ZlpsNjcxTlBEUElL?=
 =?utf-8?B?UFNVV0R0enVJL0o2QVJUbnNXUkdSQ1dvU2IyZjhzSEsvQzVUM0xhQ084elIr?=
 =?utf-8?B?amlsb0RTWDNjSGd2Q21qUFFNNnBXMkhKWDZxUHFMUlVsN0hCVVRoZWZ3ckhk?=
 =?utf-8?B?SmFMa0VWeGR6OTlSdlVjSDRMZVo0V1lXenRySVM3c0hXTHJ2dHRVb0dkK0hE?=
 =?utf-8?B?eHJIaG1kZVpid3lWTGt4cE1GelhUNjBDVVRJOXNUbEdaY0hMYmw2T0JBWm1Q?=
 =?utf-8?B?Mm03cEw2elRlYTZGZXhiVnUrMzdnZGxZT2FPWFR6TjdyWFd2aEVqaWdpcEFo?=
 =?utf-8?B?NngzUElUMmFRbEdIZGJOK2dxMTJXbFlXcStGWXh0KzA0T1IyeUl3RXQ5MjdO?=
 =?utf-8?B?eVFuSU1JQ2hEZUJON2hPUE1RTWhTMHBoTmNZdVZ3OTgxUjFtSmVXTlFLUHNj?=
 =?utf-8?B?RHYyVGpsTSt3RmJsdGU2UWhnVUNEQ0d5eFYzaWFiN1NjUExsM3pJKzVwTHBJ?=
 =?utf-8?B?WHhpYlJVdklmUDUyTE9PT05Va2VrV3VFWUhObDQxVmlNdG9sNStYT0FjT041?=
 =?utf-8?B?TGZIMVdnQngvdHROaTQ4M0Q5Y0VHSjQxd1B5cTVBN2JSMzFIb1FpTC9TaVZC?=
 =?utf-8?B?NUdGSzg5NWlRaWJNMkNCUklVYklWb0hTajM2UVVubkIweEhUdWc1M3NhOTk0?=
 =?utf-8?B?cDIyN2t5T2RETWtvREw5dHJyY3BJRU5SVytvMHRZMEJYN1NZblFQcTNLMVhI?=
 =?utf-8?Q?ZvOuYyAIOlNVxTWh5nVhwTU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135f6856-64cc-459a-6549-08ddf9d8d48e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:06:23.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+YE+hWN3vm4AuOR2C3AWLG+x7juX5R7E8cbJU/B1MdCTFvOZLAuTPjFDHH3mZumeRTOS2IyrgR6xzcla3BFbU1xrwm6lSs4ifgsCPA2DfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFC1E5F08CC

On 2025-09-19 09:07, Dmitry Vyukov wrote:
> On Thu, 21 Aug 2025 at 17:12, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Mon, 21 Jul 2025 at 10:41, Dave Hansen <dave.hansen@intel.com> wrote:
>>>
>>> On 7/21/25 06:25, Mathieu Desnoyers wrote:
>>>> This series looks OK from my perspective. I think the last piece that
>>>> was missing was to get a review from Dave Hansen.
>>>>
>>>> Dave ?
>>>
>>> It looks fine to me. I think the best thing is if you folks send it in
>>> as an rseq fix. I'm OK with the x86 bits. For the series:
>>>
>>> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>>
>> Ingo,
>>
>> Now both Mathieu and Dave reviewed this series.
>>
>> Can you please take it to your tree? Or suggest who can take it?
>>
>> Thanks
> 
> Ingo, Borislav (not sure who else maintaining tip tree),
> 
> Please merge this change into the tip tree.

Hi Thomas,

This series from Dmitry is at v7:

https://lore.kernel.org/lkml/cover.1747817128.git.dvyukov@google.com/

The initial version from February 2025 can be found here:

https://lore.kernel.org/lkml/ffd123bb0c73df5cdd3a5807b360bd390983150b.1739790300.git.dvyukov@google.com/

What are the next steps to get it upstream ? We have not heard back
from the tip tree maintainers since June 2025 after repeated pings
from Dmitry.

Note: it will likely conflict with your rseq rework.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

