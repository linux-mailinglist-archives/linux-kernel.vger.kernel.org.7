Return-Path: <linux-kernel+bounces-785366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28AAB349A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C322A330F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A62305E00;
	Mon, 25 Aug 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mrJnFV28"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2116.outbound.protection.outlook.com [40.107.115.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8018E02A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144942; cv=fail; b=hcN8WdkYnjCh3S/HCtZfwQqWQ44RnXLvbBFn8hOZkupkKLEQwT/L0KkO5l/4zn3ycTIeSrk1dNosvCABtwEgk3vyyHuz81dMdItDpizpG00hL60AmHmee1fcNsPy1f8h5PWkcawKgVnbTFLFjdtl9Lw9OnboOtms0Zq8JsKRZYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144942; c=relaxed/simple;
	bh=5tEyMu20xySHOwKGLQC8qf9+119RIScGlHa9oWNvxnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=latYBBQmuJDBbdp3B0PPZaamVTv81sVSuvnL5siMba3sTyyW20QhVystyCAK5fi/WCbB9lBLF4j2gQqR1UA2l9Upy+BUydLBaGNLB0rnrjHsLPwko+Y3sZCMlNThffVb+oRn77DI3GkyPwZ3JLwLLxEq/rzs4ILDsIz5dpCb1xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mrJnFV28; arc=fail smtp.client-ip=40.107.115.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dw43nfKRsua5/8aQYScVVQRShWnok25iW4Rbi7TpTOwq5sSKAeW49W0Vc5GEHjB6W+EI7pXO/QlgVO03sGCyqDVjIoTB9akXc5dH6RjBXNHY4IGpqn49I+QWlpLh9vl6K0W/QgM2hNLnwWYzHNzlIEnv/+0RKLUTfcIa+WLVLZlQ2YcBFGGZofsWQyKVuqKDiIuMetqRgyAI+3WWAbergy/gAwgd3rzlhqOoZQrLYR7mUZ5yLWs/oJfUfCGBKd5dy+xGARat/Ue4Je0bFXfQtg1lvqAeSyY9gFHwqcVjUmCzbQOho8BrScNPwyzThKv2Wv1xvqf1ykry3j24yRHFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU6qUxCCbRj00NJv52WQ2+9mEqModnLZDR4jsxDa0H8=;
 b=JKqxB9Etim/Bf1CO3rDzEkNWQAmr2snROyFpH645h9vJMUN0lzt68/Oj1l4tX7OZNQ87QJZWoqHoFNoeZBrallzkUgWnsWRHwIHU8ST4wI8DwVexuhO9H6LUcjcnK08KUk+8QOouUrt+kozBJT6sg9zsoeogQhsIZT6T7iYK2JNCp5LMro1L8KP8fIz2Vp5Cj4JrblRRazqllA2Iqu5gFzeL6xeFFnvNGTxvCuuEP+fAUCliyb/w7kPpok2DmbiougaFO+t1gP+TUxRz0QHuBNqegP+AeRPGxnQZinzLNdJ+5553R6heYfX4U7W/IeAKgHsG6rs0vmijaR0rIjwKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU6qUxCCbRj00NJv52WQ2+9mEqModnLZDR4jsxDa0H8=;
 b=mrJnFV28QUy0wyU9ezhj0lUO736NZToryYc2E2od3V2L+drP6ovhpRmzjAY6CskAgD4YbQrkzBo5H0fC/Fi5fc8XSom9qb76hE/iinVQFygJZjcWzD37Gccp6XhHy3fxYsts2BWm/A6kPirKD58LW5clc0t++bgb1cVuK2oW8BvGUly46lXRv9nVE/ldixTn6kTDIc3P529vKJs8OJ3iDdwTUrbht7ZEYYZaeXVG6ODuXqsSPFQg3eut+XoL6eHVEfDdk2tszmvWvI7FzVIkuVWm7uKAA/Qad3JLhdckir7osmTNLobMpsN+QbOt06M5gWMqcn8M61V7paJBvxvPHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8543.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 25 Aug
 2025 18:02:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:02:12 +0000
Message-ID: <566bd13f-54b7-42e3-808a-619a58ce05ab@efficios.com>
Date: Mon, 25 Aug 2025 14:02:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 08/37] rseq: Avoid CPU/MM CID updates when no event
 pending
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
 <20250823161653.778777669@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.778777669@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8543:EE_
X-MS-Office365-Filtering-Correlation-Id: 5914c6fc-bdae-46f6-89a7-08dde40183fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzhpS2hUV212UmJqMEp6VmNPUkFsaFpUS0QyUkxkTHRyL1JQRGwza043dzNs?=
 =?utf-8?B?R0c5TUxMMmJXaWVWWmJFWlgyOTRkbHhka3R5V3o5YmFDM0Fxc2lIWFNpenpU?=
 =?utf-8?B?NnV1MUROWmFkSEhCWlkxUlhVRUttSnVZNEZHR1Y3RXIwc0xqcC9Mem5aUzV3?=
 =?utf-8?B?QVlVNHlJZU9UcFpuaVNlaTFmQ1prbHdNNGR5RjJKSHhaMTdMZDdXN0VSSFlq?=
 =?utf-8?B?ODRIOENFNXRYVHA0d1MrUk9CWk9ta3Q3QjFCN2VzakkzSXBFYWxhN3B3KzZ3?=
 =?utf-8?B?VEhMSWpGbG5LWTVVR1NJaVNZVkZMb2RpSlh2ckhoVlE0a210UnFOcXJlYXdC?=
 =?utf-8?B?cmQ5R0pNOFpZc3c1VHJyM3VaZkFuOUgxZURYTUxlN0pqbnRRL3c2bDRoSWNz?=
 =?utf-8?B?dkJva1NCMDVGR1V6ZmhpSTlIYkY5MnE5QU5tK0QxZ1dLcjBrdEhlRmRuek1P?=
 =?utf-8?B?N28wcm9TQ1NsdEMxSnMxNXMzdlplV1diNmJ3ZXRFU2dwSk1MRGNiNnVlaDVz?=
 =?utf-8?B?T2ZNODRZc0lrOXJmNFZSSllXY0ExbXFRMGF0M0Q2SkRNUTYxS21saVlaa3dv?=
 =?utf-8?B?K2hTREZFVWNWSDV6bzlMTG1UMVFmQVo2SFBZcUg5dmZJUk1Eb2VtaTJqWDE1?=
 =?utf-8?B?ZlhMbDFBZGZNWlV3Zjc2R2tsbEU2ZXVMYVlkWU1NM0EwTDd1bkR1Y29IaEdM?=
 =?utf-8?B?ZzNaV1Q4bVdxdXRpU3puVWh4YVgydGk5Ri9pZlp2bmpQNDRjdWNsTE9RczFB?=
 =?utf-8?B?RHJDTGNLVERzcEFiZmZJRGlvZVN0SXJYQWlaWUF2a3Q1Y2l4aExPcGhlb3Bs?=
 =?utf-8?B?Y1dVYTI3dllsWjhHdGM3cGQxNytIOGc2SDd0TG5YNWlpdHhUU01BYVJsbnBv?=
 =?utf-8?B?YUlmZENSR2NvaGdwdTBBNStiMHQ5QW1vTWY1dWtjcVQwMkFldmZrcEpUMEhB?=
 =?utf-8?B?MUFVQlg2cVFidGx6bXZESG1KQTd5OWdKMmRZQVRtUXFTSEsrQTdaM21Qdlhr?=
 =?utf-8?B?VC80WnFOOVhML3hna2IwRk1YTUVXcVpnTGpGUFp4TEh3UkR5czRjckx2aFd0?=
 =?utf-8?B?VU11c3ZZZXIzOWFDbnVKNDMxSFFnYy9TWlNQOGdSbzNPQjN6b0FYdW5XemhV?=
 =?utf-8?B?bmxrUHV0S3hzVUtHdHJ3aHp6ZjlROTI4TFg5SDQ0YVM3VG8xaFcyOG01ODky?=
 =?utf-8?B?VTRuL05SS0E2SW9LU0tsVlJYdXEwWnlOVlJsbldYbkxCM2NJdmZ6eE1MaVN6?=
 =?utf-8?B?dGlOdUVWYkpMelhhUW0rbGQyZmphVGppZ25DVmJncjlaaTdMbW9PdUt1QWN6?=
 =?utf-8?B?Ti96bGl2aEJuMGFhTHJRNExoOGZ4VVprcU5xejFUdkYrdXF2bDBsbHpKZkNy?=
 =?utf-8?B?UzkxVVlEN01EWDNoQ3cvVnF1Y0NJR256ZG53MjdDZGF3dW1ydmlIMXZBTXpP?=
 =?utf-8?B?c0dMZ2w5TkJzSktqdGRhUTUvMjh2Wm1WSm9MdVdFV1l2Y2hHN3ZSVVpMME4r?=
 =?utf-8?B?Ky9RT0I0UHdaLzRPSTB4Wnp3NGZOYys2UXVpMFU3VmdudTRsSDk0MnBqOXpu?=
 =?utf-8?B?QktONERtRUllSDU1Z0hVZkRFNUprQ05nMkE4U0UybUtUbCs4Qk1MVHh6Mi9q?=
 =?utf-8?B?MnFOL0lzSTFrdS8yUkhjSmRXVnM3T1FzMm1MRzdjVHpYVnZqUkR6bzhiWWIy?=
 =?utf-8?B?UHAvRGdHZDU5MGRiUXJpZ3hDSE5pZ3I1NndmN2R1eGp0aVo2VWRGMCtsVkEz?=
 =?utf-8?B?Uk05VkF1U2pBVWtGSFRGSHZTNXlLQkE5dk14MFVGcTJhcjA4U2hPUUFWajJs?=
 =?utf-8?Q?p9rO8sKdcfyzrt6be1uXFuQFvCtIa8TZzJkjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3k2cGRuaDVaRW9Menpreml6b3YxL1h1M3pLV0V6WlN3RkJBN0tQOXNOQmw0?=
 =?utf-8?B?b0h6eTJUMzFUK0o2ait1QVpUQnBYMTEzbWhDOG8reHJqM1d3WHhTckJDbUxF?=
 =?utf-8?B?TjlPQmF1WFpQUlJFcEpUd1JOMElzUUVyR3hPM1hBQWpXaTJiZ1cxb1EyQUxE?=
 =?utf-8?B?WXVWWG1PekJOWW9wTmkxQzVqeGg2ZGJLMFpqcmYxUmJ4QWF3bjdGUjA4aUxP?=
 =?utf-8?B?cC9ESzlLV2ZMRUZTdHdOMmZjZDEvcEhXWVNkYjVraW53eDZ3dzVBRU9idzUz?=
 =?utf-8?B?R1I3emJlWUNyYXlRM0xCdHBDaWZjYTBXVUI1SFNLbENySllyYVhzUHArM0RC?=
 =?utf-8?B?OU9kdnlCRGNtNFpUV3ZRcjVLdGZNSDdyV1NjcFpScXZNZU91a1FQSUZrc0Q5?=
 =?utf-8?B?RjRqdG8xYUpJdEhZaXg4MkswNGJEL09JYm85TlA3eFZZZm9XSEhXeEhhMGZa?=
 =?utf-8?B?a1RabEYwWUgyd2YzdVVqd3E3M014VVE1TnJRVUJmZTBEcGhMbjdNVDNZb0xa?=
 =?utf-8?B?VXBnRGZBR0h3T1JFOXJobitGY1pETGJYc0VwYWlRNmNWVUtiQ1o2c3JzMkNM?=
 =?utf-8?B?WTlUWGtUN1ZrdisyQlZnTGZHT0daMCt2UDkrK1pTZFBqUU9uMnJWMjR5aExY?=
 =?utf-8?B?azdXZnpiajc0cE5RWUwxUXdwTjIzd3lqUmF1OEVUd2U1bFR2Y0IrZjB3ZFN3?=
 =?utf-8?B?RnRNWFZ5cGowNlpzTG5ZNHVjb25LWHVKNW92bVVzSVJZVjJsSi9zWWRSMHo5?=
 =?utf-8?B?MmxRamYrZU15WmtzL1ZsV05UZGRGOXpUS2VSL1VUSXFVbHFMVnVKZ21lU2Rh?=
 =?utf-8?B?bXRqbWk2aHNaNTBUb0dhTVBHNDJrdzZxdUtaWDkraWRiTE1GVEVHN1dMdVov?=
 =?utf-8?B?a0JCN3ZHSGtmek9XUndXQ012UXVpU0J5d3piSUFWanlIWDhGazhTZWZOUlhr?=
 =?utf-8?B?YXp5QXQ0K3NjY0U5ek9Ic1NsWlcvNnZvQkVzaUNyZ3I4ZEkramZIWWxRSlpz?=
 =?utf-8?B?SWtnVkU4NkZVL2lTUkkrcmZBQ21KUDA2clM1TllGcDVqdUpwWmcyOGxNUThU?=
 =?utf-8?B?dHc5ZFlDY3YwUjVyZ3hqOXRYZE4rMW1aZEJ3K2dNQkNUK1RIaHM5VEw2U0JV?=
 =?utf-8?B?cmdVYlBaRHlmTHJ6WkVyRndwWmdMQ2pITjZBLzcwR0NpbkpHb3lWQ0J4N3JU?=
 =?utf-8?B?cmhuREluOCtNdkswNE9nR3l0Szc5VisrRDVCR3FuajhoWTVHY0w1THBpanZ5?=
 =?utf-8?B?TVhKeVFzZTVrQ0NzT3BmcXZyZGkyanRVVlV4K2MvRi9sZVFzK2VqMCt0OXU1?=
 =?utf-8?B?T1ltYVlleUlFTzNRd0p4UDRzL3EyVUxrdDBhYncvRytTU0c5bU5XZEZIbEs3?=
 =?utf-8?B?N2p0amk5TjdNZTZBbGlvTHkzaUVaSVNOZHlSRHN4SW5sZVEwYzAvMlEvekYw?=
 =?utf-8?B?QnN1RUVHNWc2b1YrMEUrc1JlcFI4eWxkck9JTUEvb3NQemcvR1dLbTdidHhJ?=
 =?utf-8?B?cnp1K2tES3BwcFlqOXh6MlNkUlJ1V1o2WWpBdzM2bVNaZ1A2T1BFVkQyS21U?=
 =?utf-8?B?YTV2UmxIOXE4eU84TlNPbG9FTW5FRXNxc0lnK2p6R0ZlWjBWV1d6MFVwS295?=
 =?utf-8?B?cC90M3VRbjdGajRCQ0J5YXJnMFhQRFo3V3VsbWxjU2Z6ZDZZR1d1bHFSR0lS?=
 =?utf-8?B?LzMyb0NXMXhkUlpxQXBlWnhsZVVnd1RDVnBrUjV5a3BUVlVRRDdzSlhyWUFj?=
 =?utf-8?B?OG5EN0tLd2Vndy9DQXkxVGtEVG5GSi9YVTdxL2F5S2x1ZUFIQjZrM2Rra2cw?=
 =?utf-8?B?UjdoSU42aG1HZ3lJSkhlKzBCM1FvLzdWRlpQQ0FDUGc0ek5FTmJiOGhqUTlW?=
 =?utf-8?B?ZGFzRmRERTVVdGpVV0NEcFNNMHdILzQ2Y0ZkWkhFOW9GVmVaN2VJYTdhcHdp?=
 =?utf-8?B?ZnBwMkFPUVNkVVFkWjlyRUVpc28xYmQ0ZlNYQk5GYjh3RDJSV0kvZUpTTUph?=
 =?utf-8?B?dzRqT0pweGNROWdNSXZld09hMzZBbzdkWm4wL2FGMWlWT0pudVhMR1pPOTZz?=
 =?utf-8?B?emZxV0l2OWFPRUwzaTFGTjZKVHQwR01SM3haSmd4Q3JDbExURkxBTlRPSVNp?=
 =?utf-8?B?TjlKQXAvNi8wcko3Mk91RFRtZ3ROSWt0OUk4Y05lUHJIQ01LS2Vzdjd2dTI0?=
 =?utf-8?Q?efJL060LVSV4WoHKYpQazxY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914c6fc-bdae-46f6-89a7-08dde40183fa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:02:11.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKPA7f16fhhuNgqWs78l74gJyNQYK7ymBOMTr/0ul/RFvmT7G6URwS0W7sGjbjgW0ZI1LIOxIppgdqkSxxtHyEzm/uEQ4u0U9YX5ZvaVsHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8543

On 2025-08-23 12:39, Thomas Gleixner wrote:
> There is no need to update these values unconditionally if there is no
> event pending.

I agree with this change.

On a related note, I wonder if arch/powerpc/mm/numa.c:
find_and_update_cpu_nid() should set the rseq_event pending bool to true
for each thread in the system ?

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/rseq.c |   11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -464,11 +464,12 @@ void __rseq_handle_notify_resume(struct
>   		t->rseq_event_pending = false;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> -		ret = rseq_ip_fixup(regs, event);
> -		if (unlikely(ret < 0))
> -			goto error;
> -	}
> +	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> +		return;
> +
> +	ret = rseq_ip_fixup(regs, event);
> +	if (unlikely(ret < 0))
> +		goto error;
>   
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

