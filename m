Return-Path: <linux-kernel+bounces-885439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD9C32E31
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ABBD188F19D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89202367D1;
	Tue,  4 Nov 2025 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PDY5Ki0m"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021121.outbound.protection.outlook.com [40.107.192.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05583EA8D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287447; cv=fail; b=laVUPE3Xr1eBRh7dPvCRDvwEdz4jabKyMVbpw9y01BhFglkL6TN5HpIE+jn+dhX0r1fxqP8wwJd5rXYqSmI6JdQpL/FMtV6SpF8c1Sp1rF5BiXbBLm4BRIXy9qo7egkJg5Z9eKIyeEjoEi7fwW8Nm6tLkcryTw8Rklt1Xsqo3PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287447; c=relaxed/simple;
	bh=mjtTw2N5XTMSS/AuB2ACB0dEtH7PBjV/Ozy7SOBLYss=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=eefFNVjXFy9w4cMB8QnQNJ69LlJUf9wepfydBdWYO3Nc3MSonSz1BqPwnTDQ/fNeMEwkFk8u0PLTO6ecfFjLgYq7hpIAdjTOgoqob9Ycn31/XCIGC2TK/MUApdjm1JPmYHBIeYUXt2HsJKykzRz1zim38mSEsr9l6u1pOjuy2fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PDY5Ki0m; arc=fail smtp.client-ip=40.107.192.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhO/wZi2uR3qpMRpBhy88gGOzCTpw+Tg6+tzYDTG8wKlK+8xFgBjGGD5wK7nh/hE9y9Bf3WWDcvmKCnUQp2mGYPai+2Q8dgl9Q0In3uZ7HRYb5Q5tbke6BM12m4/NWlrsEwTnlBIBCviopr6t90EGP/pu4UhWyhtVtuP+rVpSFROgfYDvKzd+6cd+U3Q6bFGrKDuhvVfPZ2EJi2VcnQZmAjAE6aPBjLUjmEP/Gn8k1VtmpKpJUwEDSeVWhaUPHqyuEU0z2UI4ja7KYq/IZ2ERZauYmn6QbxOjlSNkrVPKt3bdz9bcdHa0RaXXVQotRjDaUt5wMxAZ+XTAd44R1TD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HNOfikLJOGTo7hkLPmB9+B4GFyLkxXP85HqJ8oeaoY=;
 b=ZVCWiQnCuynKV2PI2pFZYzdmZUiFJRVA3x/NQvyIB3SwkxJWljwJBJNBCrfwamK3EBmV+qUDfaGlkuLWjFD3AvyXZJ42QvuWr//1/f9z/dIq2ClcOGaECLGJiK1LXGzsDNk3/Jh6ULpkypUdKTQj6XEHj0quj6B18I7PtH+oklrOv/WjoZA7YqWw16gBY3D4+/zu8HzXYoKTk7kMhjEWgUIndkd4foPUijHU0xyX+CU33CU5wfRbPmW7IphM6cYAiBSfAZsTcN/5YDhCNLYyKRjK9exXfxhu8rdha8poXdK93NuQxBPQ6XY7/JQekovNl1ObRcGHuoAfuCWaQjJaKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HNOfikLJOGTo7hkLPmB9+B4GFyLkxXP85HqJ8oeaoY=;
 b=PDY5Ki0mfxj2VUd9HE4/dJL+YRR8nExs4ylLDbymedBychsKsiN5ayLJFmYqwXlOXB4MbQIpNRIFQe2gSc5wcxUh5pKGChv5tRGBAJYxCSBGyEcZJDV2pAfObrCl5FXaUoYzyi4YfbtKWMlhfuT26NWsiTliSku/0kyM+FxnHgF9NQvbr41yzCWRmxq7hqsdd40VPOX2ifogB9EBFadUJb3K8HU4nE2BPUu6CrCPE4+07iZcZJJx6SRGMqlSbLF+BAwDkqYeRFb925bww/mFnmyifCf/1grbEpJF5q7FXboWXu67O4o0DvlGzNNmrDCJytdB4xy3pSFlC1TyoOzrvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFEC9C76D91.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::49f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 20:17:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 20:17:19 +0000
Message-ID: <43ad1f76-3682-47f4-b3c9-62a94053db3c@efficios.com>
Date: Tue, 4 Nov 2025 15:17:17 -0500
User-Agent: Mozilla Thunderbird
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
To: linux-kernel@vger.kernel.org, lttng-dev@lists.lttng.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RELEASE] Userspace RCU 0.15.4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0402.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFEC9C76D91:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d281a9-3adf-4f8a-08f2-08de1bdf277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ty8yYXg0OGpkbmNxWEpNK2RFUVZ5Mmdia1FlYjlxVTRmUWNKZ2l1bUJCVlNM?=
 =?utf-8?B?RnMxV2t3ZEQwemkzckhHMTAyY0gvVzhlM2Fpay9EQkE1UTh5anpOQ0dUVHI4?=
 =?utf-8?B?dHhPcXJnR3NadHNkWEdZRHhTbWJycjA2REszSGsxQnJ2bS81KzRKbXpKdHZZ?=
 =?utf-8?B?UkZUY05JMUxOZERoSXJFeWpJRHYwejh6RUp2VWVVaHV5Q2tBc01TelNtTHZO?=
 =?utf-8?B?VUZJNGFnWkFzSDY2OUl0N013MlJiYThLMDc5dHA4SFNvVWtuSW8ybVR3R0tr?=
 =?utf-8?B?aXh2UnFNbENSQlVQU3NjRlJ2bDIvTUdUWVNvOVpwdk84MlVxVlFwck1PcG5i?=
 =?utf-8?B?S1FTSDRZdWROaXlYblZXU0ZGNmpIY3lzcERDOTUvcXJwcG1ZV1k0V0JWU0x3?=
 =?utf-8?B?NC9EeEJNeEFDT1Q5SmNudHdhY3FseGNTNUVQbUplV2VXRlg3WWNaWndWTVA5?=
 =?utf-8?B?TUxNQ0lvMnhNVUlLRkR3b2lwZ0NITENhbVI4VTFoQzd2eEM1dmhXeTQ2aC9Z?=
 =?utf-8?B?ZVIzeDlBbVdIQUFoMmlacmlpVVBwbTdObTJzTmJaSEdGYzFSVG1SMnFySjR3?=
 =?utf-8?B?ZHh0a1JzNXVZNFVyUUVkcW8zci9VaFI5dEVIKzdjcHF4eklManNndTYzQ2ti?=
 =?utf-8?B?RUEwV0hvbGF5aFpDV0l6NzZsVEFOMG5rSXhjNXEyejFDd2QrYVFtdEJCWmJv?=
 =?utf-8?B?VFZtUFh2aGZBeWxTbzNrR010dzdHbDAxNHJJR1RUMFhaWkR2cUszcHcxUjUr?=
 =?utf-8?B?SnJVU1FLUUVYVStGRTN2Wmt1OFY0Mm9yME1yODFmcU5tL2p6bTA3YitqK1ZG?=
 =?utf-8?B?eWZTQ2UvRVhMcmRqZ1hoOWdZT3pkWXdpQTg0ZFBJMU5wdm1pR25IRzlvOGdG?=
 =?utf-8?B?NGxmK21veEl4UlV6NHpzM2VycGo1MG1BV05VdDkyeUlRc2diV3krQ0p3ci9Z?=
 =?utf-8?B?YWVSZ0h1Q1FLbFNWYlRpWUY2dFVSMU1hV2lMd2JsMUF0Y0c3WlFURzIvNGw1?=
 =?utf-8?B?VFJtZnk5UDhYNjBHczVvYUJ4WnhZd0p6cmJ2SlcyVW4xdG5hbDRIVDY5TlZO?=
 =?utf-8?B?dERBTS82QVYyL3ZLdmc0NHNuU3oxaWJyOHdaNkJsRnJ1dDY4VmVCaGtydSto?=
 =?utf-8?B?enhlOGRhcXhGTWlnTllycVFJUG1MYnA5UmZDZmNRWjdGdHhBYzRmTFNhWE1x?=
 =?utf-8?B?RVJwNDRlNWJFVy9UNXV0NU5oZjBwOHZKY1QraTRNNHJOZ0NUS2dzZ3gyNkkx?=
 =?utf-8?B?NXpMV2I3aWxwS1Q5YytoMGxLVGJqQjMwUUNicGZSWGdBUUMwOGliV1RrOFVu?=
 =?utf-8?B?cmp1WFJ0Z2lSL3dqQnpETUdzTFpyZE56b2NmVWF5Nkdtd1dWZXZEWVYyc3VG?=
 =?utf-8?B?SlhYR05uK3ZETmxXSTNzTzR1VUY0V21YM29qWWxVZnk1ZkpKODNEOVNZVGsz?=
 =?utf-8?B?aEI2REE0UTduRE05VlgwcUVCY3BLbjNSVWJydXluemdFMVFyRDR0Q1YzZWRO?=
 =?utf-8?B?VENtTG9xejdBK2dFb3FZdVh3eTZDZE16anNMbklKOVZKRjJtTUVyMjNtajlK?=
 =?utf-8?B?TzhoTkJqbEdZOExLU2d4aWE3cGlCbEoza2J1bXBVZXBkcGpBV3RZZDdhYjFa?=
 =?utf-8?B?cE5adTN3UVhna1BhZ05obFBTcktrS1o2UWYvUXFocHNxU21PSGpzYkdXZ0tR?=
 =?utf-8?B?bS9wSjFiUm5jRDF1alZpdXNkOXNtNU9EMmc4NjFzRU1WYXp5N0VMcEp2R3FC?=
 =?utf-8?B?SktiMWI0Zkt6ZkZmMjhpZ0NBVmp6cDdhV2IxZmRCL3FEbkpqaS81RUt6VHRT?=
 =?utf-8?B?aE9sc0dTTXROekQzWE54a2wwUEFmN3REQWV4c2FySFJFZTQ1UnY2YUZSMm9u?=
 =?utf-8?B?SkNXSmJKdk05L1Z5YWVVT2pkM3VjR2FiMVBscUNld2JHTmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NERtU3V3WSsvSXhhZlMwQWRXZnZtZzJ6YXZwdXl0YkwrV3ptRHdYRjY0Y0xk?=
 =?utf-8?B?djlKQk9TNVkvYnNja0xDU2Y2cmlXby9IY2xFWk5MeEZ2anFsUE16eWt2MTM1?=
 =?utf-8?B?YmVrVUtlbFRkaGpheHJFOGpuSlZmVmMrelpQZDBZYnl3R0F6Y202VWtGYW44?=
 =?utf-8?B?TVNFbEJDZGwxNzJDRURiTlhnRFM5UGl6OGtybHJnenAyanpHT1FLUUJweFV2?=
 =?utf-8?B?b29ZTDc2dmJxdWxoMm9MYThoNk05T01qRVhDWXpYOGtPTUdsb1R0b0dmZnBs?=
 =?utf-8?B?Szh1TXkvMmU4RWUvYkJzWDlaRjI0QmNIRThWMHVQbUY0Yit5RDh2bGVhOVYw?=
 =?utf-8?B?cjhIWkx6MjF4enRQeTJqVTJUMjdmY2hvWEREQXYzQVJDN0h1RzBtbjl0ZUtQ?=
 =?utf-8?B?TzdEV2Zrd3FNZTJVZEVmZFRSTml1NG5yQjJpTHdSMWtDT1pSemJGZ0hsUEtY?=
 =?utf-8?B?M1hHRGRQRUVwaUN1Y2Z4M3dWdktvNTZ5SVAwTzdDd2R6aTBnWW5ZSVlVaVBF?=
 =?utf-8?B?ZkNPRmU0MWdPNnhmYm1uNytCOWU5bUtQNFphbGluOWhwQmJZMG5VdTA4dlFq?=
 =?utf-8?B?UEZoNnBjMVFGUUZmZ2hmSzFMNkVvSGdncnQ0eEVXVGIwQ2QrMFF5WEJRR1ZN?=
 =?utf-8?B?QkNHMDcyR2NwZVBhTTJWZVlXd3dKck93akxLRjBiUG9waUxLcHlONG1GQVgy?=
 =?utf-8?B?T2M2YnZuMkdVc1pEQ1RsZHpkd2RTYjNWMWJlN2NGR3ZDK2xrSWZsV0E3T3FP?=
 =?utf-8?B?cDYzQWNpMTc4bkFHUnJzYWx1b2pmbE1wMnBFZ1BwdjJQRkZyQ0E3S21wRWMy?=
 =?utf-8?B?blZ3WjM2eGZENC80Yk9EM1IwaSs2TFZtYngrbDFSNXJLbERuUmg5cm4walVr?=
 =?utf-8?B?TGVhRHZBYVpFZnU2eUN3b2duUHBucjJPSXFydlBGdThNaytIeFAzZ2h0cFN0?=
 =?utf-8?B?NHBpNWlyVWNrSDczeEhmSmIyZkpYa1M2Tzl6ZDdhcEVoWjh4dW9nbjEyTXk0?=
 =?utf-8?B?OUY5TkpEcllocHJpMDI1QVQ5RGMwWGJneTg0QTJDVkpNSU0zTkgyKzIwVVZW?=
 =?utf-8?B?WnhqZjRPTW5mS3ZDMk9aQUp4ZVk4Z0NRQVZnZWhJaUwrOERzSG9QTDdBQzRi?=
 =?utf-8?B?RkZMQ0VubkJVRGpWdUt4RXFrL1pjelFwRmtnRHViT213bmg3UUFmS21jeXFW?=
 =?utf-8?B?cDFjQ0ZjNC9uNkNjcHYzNjIwYStvOTNFOGplTHM2aGZCZWtQemdPc1g0Zis3?=
 =?utf-8?B?QmJrOEJWNUttNTBuejlOSHdkbVM5NEp4ekhkRWlYLzJHRnBZTWdQdnlWZUt2?=
 =?utf-8?B?dFFUNVZhYTI3RTh2Qjh3SElpMnMzLzZ5L0NMTEhIajVwT2JCRlY4cm0zYlJH?=
 =?utf-8?B?OGhvV2dUdmlZNjdQQUVrRDhURERvWmxYdmVyQjRDcllWM1dZQ0VUZ0tyQkts?=
 =?utf-8?B?WUdMTGgzaFA4aktWNE1TOGl6K2hpNm0wZmQrbVpvT3RCS0t1VDdsMzBQUVNn?=
 =?utf-8?B?ZFFnMDVCRXZqekNKSVdFUkExbDBGWER4Nm5mUDFPWWF5bWhEc2FjU0ZKa0VF?=
 =?utf-8?B?dk5oVHo5NEVhN1BkcDJDbUw3MWZZSXdEZDlqNkxBS1BQenhCejlINCtDU05h?=
 =?utf-8?B?M3NZUkVRVWdscVowSVgybWQrb2t3dlZUSVBUZWM0MStDcXVteGJsUXpLanlo?=
 =?utf-8?B?MDZZdGszZlFxMmVIY0JjMkFtTzZkTzFqVE5zYlRpaVhtd2tMY081aXBZRkdk?=
 =?utf-8?B?dWpRT25JODVFNVF4VW1UV1ZBUXBQaUpSVWh2MXpsZFRJalJHcXZTaExoUGlk?=
 =?utf-8?B?aWZPcGExMWJDM3F5SGhVQTR3QVJheFlmVHlwNVhjTzFURHk1Vm90aHZWS2lS?=
 =?utf-8?B?T3d4ZmdTMmYwR2paYjVnZko4cWl5UTcwSGRndHJ3c2l1M1dxT0RHTExOVDJI?=
 =?utf-8?B?bUJWS1k0Rkt3Zkg4RnRPVVVjU1prWkhVb2U2SkNsVHVXazZyL0hiWTRCSUV6?=
 =?utf-8?B?OE1iVHFveWVUVmlzQ3J0bW1sZE5IQUdUTGIzbUJLaW81clBLZGVQckJJOXZ0?=
 =?utf-8?B?eG9SRGZUZXpuU0cxVXZ6VDdMcnAzR3NCS3pOOVYvTG9BVXJNRytIOTRLZlln?=
 =?utf-8?B?WUFZUW41cEx0aXhaNnBVRUpYWVlRcTFVbS8vZE5Takp0YjJkdnQ4V0tJVGxr?=
 =?utf-8?Q?adF62zWW1J0RQuLvbPkxaAY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d281a9-3adf-4f8a-08f2-08de1bdf277d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 20:17:18.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqTP4W2aE0HjjbSkMjz2PZ16HFaLf0numu+e4d9OI1z04GwyUS0IAiqxsSty3cox2TYiKubfH6yWQKysroXl9UQb4nAxt24qYDp6aI+/tvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFEC9C76D91

Hi,

This is a patchlevel release of the Userspace RCU library.

The most relevant change in this release is the removal of
a redundant memory barrier on x86 for store and RMW operations
with the CMM_SEQ_CST_FENCE memory ordering. This addresses
a performance regression for users of the pre-0.15 uatomic API
that build against a liburcu configured to use compiler builtins
for atomics (--enable-compiler-atomic-builtins).

As a reminder, the CMM_SEQ_CST_FENCE MO is a superset of SEQ_CST:
it provides sequential consistency _and_ acts as a full memory
barrier, similarly to the semantic associated with cmpxchg() and
atomic_add_return() within the LKMM.

Here is the rationale for this change:

/*
  * On x86, a atomic store with sequential consistency is always implemented with
  * an exchange operation, which has an implicit lock prefix when a memory operand
  * is used.
  *
  * Indeed, on x86, only loads can be re-ordered with prior stores. Therefore,
  * for keeping sequential consistency, either load operations or store
  * operations need to have a memory barrier. All major toolchains have selected
  * the store operations to have this barrier to avoid penalty on load
  * operations.
  *
  * Therefore, assuming that the used toolchain follows this convention, it is
  * safe to rely on this implicit memory barrier to implement the
  * `CMM_SEQ_CST_FENCE` memory order and thus no further barrier need to be
  * emitted.
  */
#define cmm_seq_cst_fence_after_atomic_store(...)       \
         do { } while (0)

/*
  * Let the default implementation (emit a memory barrier) after load operations
  * for the `CMM_SEQ_CST_FENCE`.  The rationale is explained above for
  * `cmm_seq_cst_fence_after_atomic_store()`.
  */
/* #define cmm_seq_cst_fence_after_atomic_load(...) */


/*
  * On x86, atomic read-modify-write operations always have a lock prefix either
  * implicitly or explicitly for sequential consistency.
  *
  * Therefore, no further memory barrier, for the `CMM_SEQ_CST_FENCE` memory
  * order, needs to be emitted for these operations.
  */
#define cmm_seq_cst_fence_after_atomic_rmw(...) \
         do { } while (0)

Changelog:

2025-11-04 Userspace RCU 0.15.4
         * uatomic: Fix redundant memory barriers for atomic builtin operations
         * Cleanup: Remove useless declarations from urcu-qsbr
         * src/urcu-bp.c: assert => urcu_posix_assert
         * ppc.h: improve ppc64 caa_get_cycles on Darwin

Thanks,

Mathieu

Project website: https://liburcu.org
Git repository: https://git.liburcu.org/userspace-rcu.git

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


