Return-Path: <linux-kernel+bounces-812231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0955B534CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2691882450
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262E32F76D;
	Thu, 11 Sep 2025 14:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="npIWXtqH"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020074.outbound.protection.outlook.com [52.101.191.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9B20FA9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599399; cv=fail; b=vAngxTNYUYaOAS01iQrDJR/PEf0nhrJuy4FAMK4WIJAF8g1lnAgPkZg3RqkjjNmd3m2cQfzNgJXSFXP9xLKMQ+aTvjVSUdr0Z7l3AN+/QhAUkQW+Z4oAMAj0Bs62boU57SEyALTTyxwA8/IrbsNg/wbB9nCNJPmrFDTH1a9jTJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599399; c=relaxed/simple;
	bh=WJMjcuNSGU926R6Fw30T+TxlHblXnTaUiGElN208WvM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VI1+70LnO4kMA5jCZGrnlyaw0kRzoDPN6RJubi5aIeFQmwDrknnmfkUbvbnVi3ww/C58ihAeTihZJzAKjwoe02Eiaq74E2ynTYgbKfdiRqDXWEvlcVsAI78DCBWFcnJuFtXJ6Q7CO+nJFGP8Z23DfuRKDHVNjchL/gDj7u9ueRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=npIWXtqH; arc=fail smtp.client-ip=52.101.191.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa9Vm7qyhk11jd+A++5NVyOrl0OmdBxLeekDlEprlBNNP5e+vT4w82EYA4S6Ty98+AJcOE2ilYtyJlzhMmDW6MSShBjW6Ps2kq924ZUoz8Y6Dl62SZ3XKqzzI7F4kTPvk0F5Sd4L+8ho2/zjyUzjyHqCDdlyoU80POWdyjQxR+3c9UgFhJoMKk6AX/b6yoxm39+rHqlCUYsE+OzunCHmAOdbmQmGmLO5OVLIGH9MVIGXovNok2N7Cbg1p4UuJnbRReC5u9o1bJSofTn/TutoLW4FrtuoSR06UZ5n+WJbeksF6JJPDG5YmhOqo97EDGc0B1UAXaWh+1B5BrSXwSHMSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+4JayQIDoN5JvJ1LJhd7850jN2ARrJRif3PUgUgsKc=;
 b=ox8D2PQ/6RPacBj0lY1snUeSQ41CSr9dL3zfqi2hbMb4E9muX8xRRc8i6pxsitI8l91l9LfBlS8uiikBmChuMiIGsyT+EUjGNar5XQkIkM2BJU8OyR98vLBLLf4gfsKq8qEtLd1lrOKGgzmdJX2lt98WW1XY/h5isMckjeURIWlaayLs9SIAogobY0Rvqqusa3jiTN/HOPAYN8oEgshUj59dH87UbCgscgkCzM7pbN1r5wut6KQYR8kj9HKLvQJV/E7YYEnMs4ibp03pb2TOWHuO5y+DFEh3BEhJa/9Z6Dm+lEPh+RexBkUERpNbGkj00jVpkut7J2/0UlZrd2fCww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+4JayQIDoN5JvJ1LJhd7850jN2ARrJRif3PUgUgsKc=;
 b=npIWXtqHlPigz4xggegEBurjgrdCB5RoI0lLLuLxRHrcHFwgpR1dBE1dFsNOyj/Iz+2LwzP7nx2BIGw2vdP3lGpSS3ReV2IGmSsVAP9oxRl0egIMM60GI3DUx1eh8B0p5WiPqOhL+LWu+LMnBCmPD4jC2JFozUQYR59PfBkKBP1VOjEh8cO6xnalNaGKd5NH9/n5rDS41CaCRubPqC83C+D6VKPdMVcUjMjaTYW23jS8VAQnW8uAjUMjMqxZlINiCKzBpn6PjV33uPsEnBiS2aRyLKUtYJnuLkDUmzL4f4S1nvvoLYPz2Rc19J4EUN2tYMis7lEf411SP1DVD+swgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9955.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:03:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:03:08 +0000
Message-ID: <6e0bcd7c-f842-4db0-b30b-5f6857b45b66@efficios.com>
Date: Thu, 11 Sep 2025 10:03:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 26/36] rseq: Optimize event setting
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
 <20250908212926.929787629@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.929787629@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9955:EE_
X-MS-Office365-Filtering-Correlation-Id: 7426e48f-f549-4447-4633-08ddf13befa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJzeHNoR3k2SXRvR0YzUnJ5NU5YMmlIY3FnVGxYTHY4Qmc0UnBUaXVtdDV3?=
 =?utf-8?B?eHM0dkxSTXNqcnA3eTZLVyt4UHpmSWRibnRlVVQ2dUVGOUd6WlZGVG5BTzE3?=
 =?utf-8?B?Y2NiTjhsNDdSL1NjejI0SGRwaDlVaE11TzBMa0NFVm1MZXhkQWZONzBueS9Z?=
 =?utf-8?B?dmhhek5EL0JMYmljSHRLY2NIU0h1TWRQSjVpQXlNb1YzL3J5NjhhTjFLNEZk?=
 =?utf-8?B?VHFRbUdjdHdlZ1FVTk9OSkxUNEx5ZVZBcm1qbExkVGJzeDUwZ0I2N0RyaTk5?=
 =?utf-8?B?RGZ1K2RsUEcrY2tIUVc5ZXFyTjBpVVE3RCtxUEk0VXF2RVdub2ovYlF4RHgw?=
 =?utf-8?B?UURlbitUcWNiUkl6WE80Zkl5VEkyTkNGbWRpYXhJMUw2dHJZY080SXBaWDZH?=
 =?utf-8?B?TDF6UXczM0R0Ui9VQmtRa2dBVlZrQnRLVlQ3VzNRa0JIT2U5ditwRU4zeW1B?=
 =?utf-8?B?TEVnUWJFdERpU2tGenNQK2dxLy96SkJBRjMrZ0pWODlWYURJOFRZamdlVXR2?=
 =?utf-8?B?dU5DOVNGR1oxTTZjM2xHMWE1N0tZTzg2ZWFFQVMvMnpHeVA3M01nYzlIRlY2?=
 =?utf-8?B?c2JvMlIxdTFNdEsxMkt1VHZGb2VEUUt4VnR6L20yWEtLQ2FuaStoS29kZEQ0?=
 =?utf-8?B?bmNlcVhYajZuZEZxVEdTeDZPZTMxdzMvTk9obUlRT2lvQVpsSERWZUJ3bXpQ?=
 =?utf-8?B?c1VKY1pXdlh0V0gvVllobjdraFJyUWtaSnBCVTRwTFova0Fvdis0RFNlZVh6?=
 =?utf-8?B?V3JEcGZ4SU9pZFcrOVBEMTdiRGd4MTdnRkVZZUFQT1IwU201WXcxaW42clB2?=
 =?utf-8?B?SFlWQ2J6RDJIdGNNcUY4TjVPb0R1eHlkWXAxVzhPL3U0V0h4NWZaUnVUOHM0?=
 =?utf-8?B?QVhKSElRVVVQM3NCOHlqWEtsa1F3UTMxM09tVjB3QS9Ud2pLcEFjTmVyKzMx?=
 =?utf-8?B?aTFMbTBabmZlVEdTdVFtYlF2OU5oNTlsd2N5VDI0VzFQZzB2UVlBbnRMbE5W?=
 =?utf-8?B?d2kvdDlCd1JtclpYcjl4Q1l5ZDdqMlhrWWtzTkFWQ0VSR2cwVTc2N1VRTTRJ?=
 =?utf-8?B?S2xPNEdPVnluSjNTbnlWWnBVVlRMbWNKYW9sc1F6ZlNtQzhZS2JLV1FrL1JL?=
 =?utf-8?B?cnFwbk5hTEJ3ckdyVG1Od3dwMDl3aFMycEo3RnRQSk1wczFQcnZNWEpRSkJy?=
 =?utf-8?B?QW94b24wNmFrSkg4dXZkZEpBUTMzMWF6emFKVndmMmhDd0tSQkV1aWpUWHpP?=
 =?utf-8?B?cTQ5SWFBZjdicEVVdk1rR1UzNmlyVTF0NUF5dTc4R1dpVzV3eEZHelJiVVEv?=
 =?utf-8?B?aUgrc1Z2aTNneDY3SVVSaDdWVlVzVEJlOWRuSnNGdjRQTnA5b05Vb0tqV1pk?=
 =?utf-8?B?TDhRVU5rS0xRa25kUGZIWUdiWkpFNVJFWXA2d0RvQmZBS2pWZ1h2QkRuaURF?=
 =?utf-8?B?eEVmV0VoOHY5Z0svRmdZYXBDRk9WTXZjWFhSK0gzZUJEa21kYUpoTk1jL2Vy?=
 =?utf-8?B?VlZpVm1uZlZ6QnFvN1dVZGptbWRQUFRhKzB2WXVuVy9aVXVHa0U5ZFZ3aHpz?=
 =?utf-8?B?dXd1eGVsUFY5SjhPd3BCNEJYaUZmbWxLMEgySVBRZk9ZUCtQaEtvUFNPd0lH?=
 =?utf-8?B?amRjWTVpeDhzdExaMnJFMW9QWUlEeHZXVk1rbnY2bzhsMTFiTnk5WUl5eVRB?=
 =?utf-8?B?T2J3Y3FTd1J3ajN6TmxDWnRlTkhLZmdSLzd4dmNLYTlleW5hd29XUkFuWDVl?=
 =?utf-8?B?QzlZbW02TkxtazFkZy9qVWV4Y3ZyQTVUalkvMmhKMVRzMFlXaEZ4VFZEYS8y?=
 =?utf-8?Q?nkc2Bd/apc+2ONprJoQM3u8h1VIZsCT7f3abk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTRFUHBGVTV6M3dFbXNqR0hNb2FBRVRwWDFkcVNoOEl4WUdPTmR1SENlOGwx?=
 =?utf-8?B?TlRpT3ZRZi9ObU9EWloyMFYxZFhhMTFlYnVjTVZCN2tQV1Z0aEw3YzJ4b1FG?=
 =?utf-8?B?K0V2ck4zaEJINUl4SVcvQytOSU1MN3hYM093Q2NtNjB5Y0ZhNm1HUWpIVTJY?=
 =?utf-8?B?RkxTZzhMb0tMSDFCVjJ5bXVxd0lEWjZmZkp5VGgyTkVEU3h6R3d0NG1BMm4r?=
 =?utf-8?B?LzFKMWtOSlBlMkpJSE92aElrZnN5SnNDVHVOM0kxaklxSHRNN0pmYURDVHBp?=
 =?utf-8?B?YmJONktBRXh5aHJYMC9lRnNGZEpzSnRUVWFQNysyWVNXeWJxSlRqaEJNclR5?=
 =?utf-8?B?SGxMakMzMThtYjJvSTY0Q0NKSXVKa2RMVWdNS254MlpiZUxraTRDejFjUmxj?=
 =?utf-8?B?Q2RMejlpb2ZWZFB5eGF6akE0NGRLZloyZ29MMmZMWURTeTJJb0FMTHBuc1JW?=
 =?utf-8?B?dVl3ZW0vaklOT3BXY0NacW9hbHFSY2pDdEJERmJCMUlubmlySWkvc3JDOEFY?=
 =?utf-8?B?NjVUbHZ5eUxHTXB1ZTh4Ynl4aFZlSEdMclVvTm1HUTZnSVY1Vm1VMGp2NENQ?=
 =?utf-8?B?UDFNYld3Z21TaGhwMWlqZ0lOOXFtaXJPMWUrZ2FGd0dsM04yeE9QTmhXUSth?=
 =?utf-8?B?VmRCQ081TzV1dDdmTWg3YzhQMmF6YytkQ3pJS21CWnlLYXkzRkpuSnRuTnRT?=
 =?utf-8?B?WmFKZDJ6RmlwdHhFc2lNanNRR252WW9DVTBiOTVtdEc1YkdKUytxd3VDUDNu?=
 =?utf-8?B?RkpLQk0waUF1MGZtQ05FUXBMbXpEd0JON1g0RXhLSnUyUjVwR1R3WUF2c21k?=
 =?utf-8?B?UE85Yy82aHoyVVJHN3NPZldFNGxLNG1ML3BaS21janFtVkVUd1dJc01xRFlK?=
 =?utf-8?B?L3FxU1BPbXpNeDJWczJ4MkxPT2hwVW9UaVVWdWRpVG9OZkpqbVVFeEhiWkJM?=
 =?utf-8?B?bG0xVFkrSHhMR1k3b3BDYUpDaG5NU2UyanlKSDd1OHZoelA0SUg1WWs4VjhH?=
 =?utf-8?B?RjVsWWYzYlk4c0xmZkJzdGk0c3p2S2JnL1JYWDdOT2V1L0JPSnh0dXphQWk4?=
 =?utf-8?B?Sk10S2hmN3pXQ0ZVSUoweGhCcTVtUVowU3pucTgyS1p4aUtBVGRsdlJBQ3Ni?=
 =?utf-8?B?dUNJYzFjb2RsMjBoMTBBQmkyYW5kTzl6ektrc2VZMjlINXRSaCtDcGtYNXpn?=
 =?utf-8?B?OEIyak1UY1RucDZCS20xM0RQMFBkNmhIdWRqZWZFL3NtS3VBUHgveFhwWWVy?=
 =?utf-8?B?WGk2blc2NVNGS1VrWnQ0TW92eWo2allvU0psRWdObEZyQzAvdEJ4ZnNEKzFQ?=
 =?utf-8?B?Vjd4bEMxbUVvSUkxN0RycjlXWGhyVlpHRzBmdHBFaGd4SWRORVNMd2IyU1Vl?=
 =?utf-8?B?L3pyL2tZdFFjRVIxaDVMWXVTWUhrbS9WNVh0Y0pYc3VyOGJMdUdWNW5iS3Zy?=
 =?utf-8?B?cm5ubnpjU3hjVHlURFJwOVhGZGhDbndKOHB6MXhtWmZUTkNUYWZRWXlYQmhE?=
 =?utf-8?B?VHROV2V5bUZOMXh3ZGtUZENpY0hmVVNPWE0rbzYxaUdCTEh5aXJQWmI0VE8y?=
 =?utf-8?B?YWR4b2FnZEs1WnJXYzZVVHh0c2NobThEQ3F1MlRLdDFKcFE2L2o2ejZiVFBT?=
 =?utf-8?B?TlFTcGQ5NUx3YTh3UTlKUmlKc3NsWnZ6MU80NWgrWXh0ZFRzd2F1ZTNjK2pi?=
 =?utf-8?B?VlVuc3B0VHlKNmhHN0E1Tk52UnJCVmFHanVGclhQNmhGZ254d0pTeWZGOW1o?=
 =?utf-8?B?bENaQithNlZFZUlJOEdEYkQrbnpBSkV4bGFzQmhvd0xXZzJ5K0RJSE51dEkx?=
 =?utf-8?B?RXI1a2t5YkZTYkx0dFZlNTd3enJha0FLMXRyTEsvWWRJSWR3UlBUa3BSRE5s?=
 =?utf-8?B?NjZCR2ZXaDMwV21qUlQwVjNtS2FEUVVQaitaamZzNEllakxLK0VzODhMZ1di?=
 =?utf-8?B?VEdPUW5UVklTZ05sNURtZDY4U2wzc1RXWXUwbXNmdllaZ2hiVTJpb2YwK0M2?=
 =?utf-8?B?SzBsR0g1eFNxU1ZwaktFTll5b3NIVXFic2JLdVNiUytmamZDUW1NOTlKOVJQ?=
 =?utf-8?B?WllYVUVKMGJSckZISytJdG8zc2JnampHVWdUWXo1R2YvT01hWm8vU3RIRDM0?=
 =?utf-8?B?cUtKMk9xeVFMUnJjQk5xc0pQK2JjRjRkZFpQWU5URkFRcmJ5WnpvR2hyMzR6?=
 =?utf-8?Q?+BP96Gnny2PW88/88neiXPs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7426e48f-f549-4447-4633-08ddf13befa1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:03:08.3892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4oK0VbXzP4daOV0lr8/zOVO0xxEhxx+60ie7JkpDFJcNR9JCeKCZipP4/2N4IlUIfuXUN0zCyOAyJz+X1/5xwRQw/mNbYHBAzZJGEdMRZN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9955

On 2025-09-08 17:32, Thomas Gleixner wrote:
> After removing the various condition bits earlier it turns out that one
> extra information is needed to avoid setting event::sched_switch and
> TIF_NOTIFY_RESUME unconditionally on every context switch.
> 
> The update of the RSEQ user space memory is only required, when either
> 
>    the task was interrupted in user space and schedules
> 
> or
> 
>    the CPU or MM CID changes in schedule() independent of the entry mode
> 
> Right now only the interrupt from user information is available.
> 
> Add a event flag, which is set when the CPU or MM CID or both change.

a event -> an event

> 
> Evaluate this event in the scheduler to decide whether the sched_switch
> event and the TIF bit need to be set.
> 
> It's an extra conditional in context_switch(), but the downside of
> unconditionally handling RSEQ after a context switch to user is way more
> significant. The utilized boolean logic minimizes this to a single
> conditional branch.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   fs/exec.c                  |    2 -
>   include/linux/rseq.h       |   81 +++++++++++++++++++++++++++++++++++++++++----
>   include/linux/rseq_types.h |   11 +++++-
>   kernel/rseq.c              |    2 -
>   kernel/sched/core.c        |    7 +++
>   kernel/sched/sched.h       |    5 ++
>   6 files changed, 95 insertions(+), 13 deletions(-)
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1775,7 +1775,7 @@ static int bprm_execve(struct linux_binp
>   		force_fatal_sig(SIGSEGV);
>   
>   	sched_mm_cid_after_execve(current);
> -	rseq_sched_switch_event(current);
> +	rseq_force_update();
>   	current->in_execve = 0;
>   
>   	return retval;
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -9,7 +9,8 @@ void __rseq_handle_notify_resume(struct
>   
>   static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>   {
> -	if (current->rseq.event.has_rseq)
> +	/* '&' is intentional to spare one conditional branch */
> +	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)

I wonder.. except for the corner case of rseq unregistration,
when can we have sched_switch set but not has_rseq ?

We could remove a load from the fast path and the AND if we
clear the sched_switch flag on rseq unregistration.

Thanks,

Mathieu

>   		__rseq_handle_notify_resume(regs);
>   }
>   
> @@ -31,12 +32,75 @@ static inline void rseq_signal_deliver(s
>   	}
>   }
>   
> -/* Raised from context switch and exevce to force evaluation on exit to user */
> -static inline void rseq_sched_switch_event(struct task_struct *t)
> +static inline void rseq_raise_notify_resume(struct task_struct *t)
>   {
> -	if (t->rseq.event.has_rseq) {
> -		t->rseq.event.sched_switch = true;
> -		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +}
> +
> +/* Invoked from context switch to force evaluation on exit to user */
> +static __always_inline void rseq_sched_switch_event(struct task_struct *t)
> +{
> +	struct rseq_event *ev = &t->rseq.event;
> +
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
> +		/*
> +		 * Avoid a boat load of conditionals by using simple logic
> +		 * to determine whether NOTIFY_RESUME needs to be raised.
> +		 *
> +		 * It's required when the CPU or MM CID has changed or
> +		 * the entry was from user space.
> +		 */
> +		bool raise = (ev->user_irq | ev->ids_changed) & ev->has_rseq;
> +
> +		if (raise) {
> +			ev->sched_switch = true;
> +			rseq_raise_notify_resume(t);
> +		}
> +	} else {
> +		if (ev->has_rseq) {
> +			t->rseq.event.sched_switch = true;
> +			rseq_raise_notify_resume(t);
> +		}
> +	}
> +}
> +
> +/*
> + * Invoked from __set_task_cpu() when a task migrates to enforce an IDs
> + * update.
> + *
> + * This does not raise TIF_NOTIFY_RESUME as that happens in
> + * rseq_sched_switch_event().
> + */
> +static __always_inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu)
> +{
> +	t->rseq.event.ids_changed = true;
> +}
> +
> +/*
> + * Invoked from switch_mm_cid() in context switch when the task gets a MM
> + * CID assigned.
> + *
> + * This does not raise TIF_NOTIFY_RESUME as that happens in
> + * rseq_sched_switch_event().
> + */
> +static __always_inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid)
> +{
> +	/*
> +	 * Requires a comparison as the switch_mm_cid() code does not
> +	 * provide a conditional for it readily. So avoid excessive updates
> +	 * when nothing changes.
> +	 */
> +	if (t->rseq.ids.mm_cid != cid)
> +		t->rseq.event.ids_changed = true;
> +}
> +
> +/* Enforce a full update after RSEQ registration and when execve() failed */
> +static inline void rseq_force_update(void)
> +{
> +	if (current->rseq.event.has_rseq) {
> +		current->rseq.event.ids_changed = true;
> +		current->rseq.event.sched_switch = true;
> +		rseq_raise_notify_resume(current);
>   	}
>   }
>   
> @@ -53,7 +117,7 @@ static inline void rseq_sched_switch_eve
>   static inline void rseq_virt_userspace_exit(void)
>   {
>   	if (current->rseq.event.sched_switch)
> -		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +		rseq_raise_notify_resume(current);
>   }
>   
>   static inline void rseq_reset(struct task_struct *t)
> @@ -85,6 +149,9 @@ static inline void rseq_fork(struct task
>   static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
> +static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned int cpu) { }
> +static inline void rseq_sched_set_task_mm_cid(struct task_struct *t, unsigned int cid) { }
> +static inline void rseq_force_update(void) { }
>   static inline void rseq_virt_userspace_exit(void) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -11,20 +11,27 @@ struct rseq;
>    * struct rseq_event - Storage for rseq related event management
>    * @all:		Compound to initialize and clear the data efficiently
>    * @events:		Compound to access events with a single load/store
> - * @sched_switch:	True if the task was scheduled out
> + * @sched_switch:	True if the task was scheduled and needs update on
> + *			exit to user
> + * @ids_changed:	Indicator that IDs need to be updated
>    * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
>    * @error:		Compound error code for the slow path to analyze
>    * @fatal:		User space data corrupted or invalid
> + *
> + * @sched_switch and @ids_changed must be adjacent and the combo must be
> + * 16bit aligned to allow a single store, when both are set at the same
> + * time in the scheduler.
>    */
>   struct rseq_event {
>   	union {
>   		u64				all;
>   		struct {
>   			union {
> -				u16		events;
> +				u32		events;
>   				struct {
>   					u8	sched_switch;
> +					u8	ids_changed;
>   					u8	user_irq;
>   				};
>   			};
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -456,7 +456,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   	 * are updated before returning to user-space.
>   	 */
>   	current->rseq.event.has_rseq = true;
> -	rseq_sched_switch_event(current);
> +	rseq_force_update();
>   
>   	return 0;
>   }
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5150,7 +5150,6 @@ prepare_task_switch(struct rq *rq, struc
>   	kcov_prepare_switch(prev);
>   	sched_info_switch(rq, prev, next);
>   	perf_event_task_sched_out(prev, next);
> -	rseq_sched_switch_event(prev);
>   	fire_sched_out_preempt_notifiers(prev, next);
>   	kmap_local_sched_out();
>   	prepare_task(next);
> @@ -5348,6 +5347,12 @@ context_switch(struct rq *rq, struct tas
>   	/* switch_mm_cid() requires the memory barriers above. */
>   	switch_mm_cid(rq, prev, next);
>   
> +	/*
> +	 * Tell rseq that the task was scheduled in. Must be after
> +	 * switch_mm_cid() to get the TIF flag set.
> +	 */
> +	rseq_sched_switch_event(next);
> +
>   	prepare_lock_switch(rq, next, rf);
>   
>   	/* Here we just switch the register state and the stack. */
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2181,6 +2181,7 @@ static inline void __set_task_cpu(struct
>   	smp_wmb();
>   	WRITE_ONCE(task_thread_info(p)->cpu, cpu);
>   	p->wake_cpu = cpu;
> +	rseq_sched_set_task_cpu(p, cpu);
>   #endif /* CONFIG_SMP */
>   }
>   
> @@ -3778,8 +3779,10 @@ static inline void switch_mm_cid(struct
>   		mm_cid_put_lazy(prev);
>   		prev->mm_cid = -1;
>   	}
> -	if (next->mm_cid_active)
> +	if (next->mm_cid_active) {
>   		next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next, next->mm);
> +		rseq_sched_set_task_mm_cid(next, next->mm_cid);
> +	}
>   }
>   
>   #else /* !CONFIG_SCHED_MM_CID: */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

