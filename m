Return-Path: <linux-kernel+bounces-887844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A9C3937C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 07:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79B23A894A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 06:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CC2DA76A;
	Thu,  6 Nov 2025 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aEPXtmTb"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E123D7DF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409255; cv=fail; b=gWAMQ+zPiWIGl/NipSQKck/o5q33vKr3NOZW7y4uJcPZ9mux5EPCv6Av5ajqb5uBMrJtARQ29c7h9WdoUt5qti2zPp0mlIapr4QmJKzBQy8iEGXa5dl2eDSseARDmb8W4NlyxWMKW/Lba87TUzIeRNA53uLA4osRozso+4EEm34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409255; c=relaxed/simple;
	bh=whcycEuEamkHM/3CSQcos/B92BLdojKKgiejhSYxNpU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5eXNAwrkxO5O8TlCUFq+pG/pFNt5wsh7RqME1l7v3sl0BtOvb2cxnJWGvfUb83FvIFuSl0hYSDESOMCQWK/JF2psgI55bvFXcTyJAjPKByeEAJX2ZptwdFOV6HC6WOSUFeWXaTxucCwbNT07iitO1eIXem69xOTjGD/fsVjCjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aEPXtmTb; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2M+jsIKNkB8VGjp1LPgbv5nZuiNXMxpOwBVzKE31pF7VSGOBb57CcyqBhcP2+zXYbAqW9EiCKpb2nWFvZp43EDFVnlr7/OFy0fqrzPPX92yhdA/JFo3K1r33yQ0AybggfBMTvUetMZJAe9k9VlPLReqwy2qqCo8C862oGspsQfXVfESklTdmlT4JaVo1oSbo0miq3m00JDxs7mRqA8DcaDTe3/gKqhRUPfr0L2aeYKC+l9z3gp87KklaXXrQY3+Q21wcvLjHxZrkc9GueHPKpepGbtTh2B+dYhJzYQqw6+SSvvNlANwUcqrjxfSrKi3oQuMArzwEn/Z3EEDdTVqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wFLI9aIBSpz8ZSOqp1O1zPOXT9cpIybOR8pL9H4yVo=;
 b=Nsrnm86qvABJqu/vKafarVxO7SAuUJL8yKz5MT6Yd+PdBodS/c9XrIAY/0X7l+to8N77v+sZ04fcMzqwKy7+YAWPD6V9rFkVdIhHW6hmx8aEl8SlWpmrRwxMbBuTCuBAZPQKVyMoiTmB8a3g0IxNEdaVgX6K2FCkNUqUM5d77pCxiyxJtJQ2S5l57bamJe+tTq/J3LqCo1rgmO/uUeHPZPw6g1LwRkJuTy8wAKM6ptHlfBGdj8Z1e4auV2K+W/jOcR5LFkQ02QJhNYs29rX8TZtVfOnWV4I7lxV10J8IQ9zuoMplCLMNnIjTZLdIQn8WXuK9bLAKQXcSz8ncTL+pYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wFLI9aIBSpz8ZSOqp1O1zPOXT9cpIybOR8pL9H4yVo=;
 b=aEPXtmTbTBJRgAOMx1Ot8ZhVzdWupOnv10p5rjV4Z78LjnKrXRYW44u/ix2o+ECifdYR+a821HtiaYC2IcerHQ1YGRKzL5ra0SB1KuALkAXl2eFb95v1BRPyAtg8QIkiQrfoDTORYlMCPpbk/i8fpyW00Fs07ErzwLOQ/c8MuldfpfnwcGZNrLiZh0p4nFLmSAIpRdfgOm9FA/AeRm5gbyJ5bwQ4vrUEVfB2h8EG0WqhKkjEJjOxCGfjjHG+LIRUK0CQ2pJaoH5NcnhCVQmnYd4pFKpDkOIkQpMCxhftrgAYnfgr5u737n5uMXJ1qJXHmPEETwVa67L6iQuATK1eKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA3PR10MB9260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 6 Nov
 2025 06:07:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 06:07:30 +0000
Message-ID: <b2019235-3fa5-4e38-8a2e-2c3ed955de06@siemens.com>
Date: Thu, 6 Nov 2025 07:07:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: GDB causing OOPS on insmod
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org
Cc: Kieran Bingham <kbingham@kernel.org>
References: <aQvdFfIhcMBpJdmJ@fedora>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aQvdFfIhcMBpJdmJ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA3PR10MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 1902d51c-2090-433e-bc62-08de1cfac43d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXRJbDZJLzhOa3hocGg0QmpnNmdMN2hQZlMraG5POHB0NGprQjJESTV0UE5q?=
 =?utf-8?B?OUJHZW5lNUhQQ2NSNTU4STlXRnIreEdWSHF0VThhcFArNWhFNkhmbHVtL1lF?=
 =?utf-8?B?TUllbWEzUEZHRHQ1bG9NbjM5R240Y0twdU5KRDUvcHN2dDRkRHg2Z0xLdkk0?=
 =?utf-8?B?bDhLalpzZ1NzRTdtL0xLQ2w5emZKYkJNekxZRlFrYWJSSGZCbjNpQXFDNW9L?=
 =?utf-8?B?TElVZVNVMisrNUYzYlU5MWFNRTh3UjZPQThrODZTdXpNSnJvcXRIVGhVb20v?=
 =?utf-8?B?Yk5qdnZ6WStGOStrUVpoV3JJRDZlVlVHQVBzdnJVNkM3YXRzUVJQUjhlT3Ay?=
 =?utf-8?B?MkFWeFJ4Y0Rad0MvMjAvY05oY1gwQU1BUkR3Vnp1TzNObDl6dUozRGNNZlYw?=
 =?utf-8?B?aEFiSHpZcTJSNzFWWHVrV2gzcHFDYitCVG5LNHU2YTViRXJTNnJFd1FnVzBz?=
 =?utf-8?B?UldERS8zZjZxT1AzeWlVcXZpbXNIeDN4cDROaVpGcWR0WkxHbDFqaTZsNHlJ?=
 =?utf-8?B?RHdOTzdmNkc5UUZ6VnQ2STFtbFYvM0l5WDJEY3JodUlMRzF2dEd3U1NBdmtt?=
 =?utf-8?B?Ti9DNGtkRkdEeDJHK0Z2QzJodDJiVVdlemtGTW5MbnkySStJeDdnRUM0SnIw?=
 =?utf-8?B?bWhlOTZkbFV0amJVa0hWSGU5U0QzRmh6Nkxibk5wOW8rTWJCMmk2b0o2cExv?=
 =?utf-8?B?OUlaYThrb0JETW9rVjlFMlpGNTBabUFPNmNiVnVpMUgzRVNnTDMrM2x1eWhU?=
 =?utf-8?B?MGNta1JRZVpFdDRrMDQ5K3lUVGRkUVVPNFYvU0J0bW1rbEc5WjdObmF5RnAw?=
 =?utf-8?B?UGZURXdMQis3eGd1VUJRczROTXlNYjFhZWtZNmNZY3kzc0MvMXowWnU2T3Nz?=
 =?utf-8?B?QzBZMGs1dThKS00ybVBsdmhuWEVSNUlaS3ZaSVdGbE9CN3BsUzc2aEpMLzZV?=
 =?utf-8?B?ZzdqSWZxQ0svY0lSaS8rM3k3Q1o1UWhzejdRMlpOMTZpRTJ4bi9iZkdFQTRH?=
 =?utf-8?B?bUJDc3p0OFNvc0FMYy9mbDdvM25SbnNINEVWRzJJamhrckZ5blBmQUxyWCsw?=
 =?utf-8?B?b2k2WnlBaXcrb0pRSy9lNnpPdEZyc0lnZld3V1JyVFAyWUYxQUpWdDRlcGdz?=
 =?utf-8?B?UlU3L2MxdFcyS3pGbVZYZjAwSnlFSkw1VEsrbFN5UlNGU2g3ZDJ6ZnB5eUlX?=
 =?utf-8?B?TnA0VE9qM0dCbU5VOUxPMU5CMjY2UlcvRWJpMzBGVW1JU0VDSEd2MGk1Yk42?=
 =?utf-8?B?ZUpSWUlLVjFEb2Jua25pTzRuSmV3elVReUkySG05ZHMzdlZldUlVZkhwci9Z?=
 =?utf-8?B?cy95Zkx2ek5VN0hnbzNvOUZ2dng2dy93M1lNRE5xV094V2QxY0tab0gwVlBq?=
 =?utf-8?B?TXJlR2xIbkFweEhxQ0ErUVpwWC9qclNYbEtnQnk3TVF6TWw1em9JVHpkNnZp?=
 =?utf-8?B?TU9jMlloelRjZ1pTYUhDVGtTaHR5cWRtWTZTMWNSR0NMOVI2d2xRTHFPVXdT?=
 =?utf-8?B?RkR0VkwwbndJc1Jhd1ZZazhERHlRNlRJVmRCZHI5QXY0NDhIczk0VVlaU1RE?=
 =?utf-8?B?MWw3WjA3RSszR1FIU3pPa29tYTJIRktWSUZHS0d3RTdwWTFnbnlKVmRDaTg0?=
 =?utf-8?B?V3FldWJ6R3RBN1g2aW42UkxUQzdkVVZZNzFmdnFlWnFRVnB4VWRFMTBTK3lS?=
 =?utf-8?B?MnpyZGpicHJpWmdtZjM4VDhMZ3lhS09xLzlyNm5COXk4NHFKQm4xK1BUZUg5?=
 =?utf-8?B?RnJGTFF3dkdVbFQxQ2pkS1NWTEgrTWoxQVVqeGJ3OU5DbTd2YWZacVgrTGht?=
 =?utf-8?B?N3JWTU5sZFROZnVXUUlGaDltWlFzbVozaFYzdFJOSHYyMFlLdlBDb2M4U01F?=
 =?utf-8?B?Q2J0QU1wanJHKzA3c21QYzRGYnRUYWpSeWVhdTc4S2NoajVMSDZLcDg1Tyt3?=
 =?utf-8?Q?e8cyV9Z9dvqvbY7k2fqQ3FX8h/NA39Iv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEM0bldqTjlVcGUrbkZ5enhWUStQSDhxRUV4TWRvMHZTWmxwcWJuU0d3Z0NC?=
 =?utf-8?B?bHppUFpZMlkxNjBlUnhVYjNMaVo0OUp2RDAzWmsxWDFvcklaL3ZhZzM3RHNk?=
 =?utf-8?B?d05MSGh1ejJrZXl2Qy8wSk1BajNYdWo4K3hNR2QvRDI1V1JvdWV1M00wSC93?=
 =?utf-8?B?a0tiRmpXMDc5cTNPdEUzR2hGQTgzMElTL0tPOXcvRFZFZWR4V1dOV3M2STVy?=
 =?utf-8?B?NkZlYXlENERONk9qcXhseFhHT1JMcCt1WGZBTjB2Zy9mY2ZUZ2luQkFGZWxz?=
 =?utf-8?B?cUxXZHZpWEFZdUt1Qy95TFFRRGdkS2s2aEhRdEhGakwzWUNjRlJuQjREOWsz?=
 =?utf-8?B?WU80SzFGSU5zOWRCb0EzeTh3SUZNRzkrV2hQWW9ObTZDNnZzY3gxMWFVd0NI?=
 =?utf-8?B?UEUwM01wTDBDYXdQNzNTN3pIekM2MjlqNTVaNTFZMFJPZE9wdUhYNUdqd0ph?=
 =?utf-8?B?ZmtxbCtNVGVxY0RCcEkvZlhtVW9KZk5OcVlPLzFnY0FsMUhmS2V6UmROMnlt?=
 =?utf-8?B?TURId1kvUm9JOWNFWldseC9CdGQ5N0JOUUpxdzFJV0c1MS9XekJOaE5RL0hS?=
 =?utf-8?B?eVMyN3QvWGpSZWRMNUlyZkxsMnlGWlYzcEZhdGQ2cVhaZENhK210ZncvK3l3?=
 =?utf-8?B?ZE45YktrSTF3Y1llZ3dWcFh3WGRpZHNCdU9YS1IwcUVaMkVCbUt1dXE1bDNX?=
 =?utf-8?B?YjVrL3B3b2lrTGoxcHhTSi9TQjR6SjYwUTFPWTNGclZqUFAyTklzNDBSelYy?=
 =?utf-8?B?SlQxbE9qN0N6QVpIcDlHT2NwWUtPeDk2QVhNNWFlRWxnT1lmWEVaYkVsYmkv?=
 =?utf-8?B?bkJ1TkVtZ09Na3dMZzlUMVkrcEtwSE5jVEpsSWtCcDRYZzJmdHJvOExYRDZh?=
 =?utf-8?B?czJITGJmK2M4MkpKNGhsUjlCSlVxSzhPeW1QQWgrcjhyNnRVdGt2ODh1dm96?=
 =?utf-8?B?eDNJSzV5N040ekp6UEZ0dW4wanhndzAxa25ON1R0aTNvVUoyVng5YWEyYnFq?=
 =?utf-8?B?bUtLYUJpdisyNFpwRDBmbDl1eE5SdU1aMnhxUnBOSXg5dWQ3SUxTbWt4Qnpk?=
 =?utf-8?B?bzZocnplYW1OaEpQQ2tYS3lqSFNoRXRHeUdUZG5TQmhEMVR3RFhQaUxCYXlF?=
 =?utf-8?B?Q1JuSXRJR2VXUUJhTGpTN0VMRTUyZ0ZrcEUwS0VRRlY5aXI4L0o4SVQzamxT?=
 =?utf-8?B?NGN6cVllN0dmdElQbjFyMlR5RklsNjZKZWtGVmQzTFJaWEhiYVcrK0tGR0tk?=
 =?utf-8?B?YUNDa0RQa1ZsWUVCTDdpeGFrOUoyaGZBREM5MHlSSGpYWDRER05sSUJwYnNO?=
 =?utf-8?B?bHh0clo1WHg3d0xnUGYrMHJkRTFkT3ZqYWVZeHBMcUZrKzdqMlBNM0I1ek5D?=
 =?utf-8?B?WDNZNEM2MTZidk9MV2pzN3lCL0Zkd3kvYnF6aXV0dis3eVp5YVNEWDYrWC9Q?=
 =?utf-8?B?OW4zQkV1WFgxWnFGMXp3d1diRzJ0aXQwVTNXRmRQNUhRb0loYmVpNGxCRmZy?=
 =?utf-8?B?V0l3STVVRWY2aGJXYkZSSWhJQnRDeTdYYVZLcnVoRDZnWGwxdlUwM2lRVE9j?=
 =?utf-8?B?QlRSdENwVG5mZjFrdXlTenlDQ3FvOGFST0ZzWFRsNmFrTE44d0pnMVkrYTVP?=
 =?utf-8?B?blRyNEhtTkpSaDk2TkFTWWl3ZUljdzVUSVVJQWhYeURWTDlxZzVpU0RWM2p4?=
 =?utf-8?B?NEtKLzNDOTV2VU9yajlTWU5Fc1h5aER5TWhUSDZzblZRMHhTRkpPVk9Ia2gv?=
 =?utf-8?B?MzgwV3NvTEJVSzlxZDlwa1FKcTNENnVLTGx4MWpqQzRkLzc1OHgycEk3RmVS?=
 =?utf-8?B?ajhWV2lWZVdERW5IS1UxZUpYSk54ZEVXT1FiOWUrNnFXWnI2Nk9yUmFnQVI4?=
 =?utf-8?B?RGZER1lmN1kyYUsrdVBMTFVVbmo4QUtpVlpPNUt6cVdVMzQzT1ZPcGxRbmIr?=
 =?utf-8?B?UjFVZlZYcDNlSzR4V3c1c0NWUWtWR3ZLbG1GdjVRL0lOR3cyWDVEVEIvdld5?=
 =?utf-8?B?QW02TnA0VXh4anBnY25Na0tNZWo4ZmR5UmRnTDdxenJydWV6V1d3RzNsdkV4?=
 =?utf-8?B?aTlNVVltV0V3dGRGUENOUnVESnBNQXpNSHc1SVVJdFBhL1M3WGs0cFZkVWl2?=
 =?utf-8?B?azd2bWdRb2FQeGgwTHJkK01RbTNmams0bkV4TmE2amFSbXZ3ZTZEckdSTDc5?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902d51c-2090-433e-bc62-08de1cfac43d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:07:29.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqMlA0kuwxQYF3SFw7Qr9vd9AuhBQr2jYEiQEKuJXC8lACB3VHB2qWX2EoTjtWk4nhqfhddUYUR8NS6r6eYUqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9260

On 06.11.25 00:26, Vishal Moola (Oracle) wrote:
> I'm on a x86 defconfig + GDB_SCRIPTS + DEBUG_VM + PAGE_OWNER kernel. Running 
> 'lx-symbols' in gdb Before loading modules causes the kernel to OOPS on
> module load:
> 
> [   13.627373] BUG: kernel NULL pointer dereference, address: 0000000000000900
> [   13.627376] #PF: supervisor write access in kernel mode
> [   13.627377] #PF: error_code(0x0002) - not-present page
> [   13.627378] PGD 0 P4D 0 
> [   13.627379] Oops: Oops: 0002 [#1] SMP PTI
> [   13.627383] CPU: 0 UID: 0 PID: 279 Comm: insmod Not tainted 6.18.0-rc3+ #163 PREEMPT(voluntary) 
> [   13.627384] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-6.fc43 04/01/2014
> [   13.627385] RIP: 0010:__kernel_read+0x210/0x2f0
> [   13.627390] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
> [   13.627391] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
> [   13.627393] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [   13.627393] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
> [   13.627394] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
> [   13.627394] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   13.627395] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
> [   13.627399] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
> [   13.627401] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.627402] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0
> [   13.627406] Call Trace:
> [   13.627407]  <TASK>
> [   13.627409]  ? init_module_from_file+0x92/0xd0
> [   13.627412]  ? init_module_from_file+0x92/0xd0
> [   13.627414]  ? idempotent_init_module+0x109/0x2f0
> [   13.627416]  ? __x64_sys_finit_module+0x60/0xb0
> [   13.627418]  ? x64_sys_call+0x1a74/0x1da0
> [   13.627421]  ? do_syscall_64+0xa4/0x290
> [   13.627429]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   13.627431]  </TASK>
> [   13.627431] Modules linked in: test_xarray
> [   13.627433] CR2: 0000000000000900
> [   13.627434] ---[ end trace 0000000000000000 ]---
> [   13.627435] RIP: 0010:__kernel_read+0x210/0x2f0
> [   13.627437] Code: 00 40 0f 84 bd 00 00 00 48 3b 7f 18 0f 84 c3 00 00 00 48 89 f2 b9 02 00 00 00 44 89 d6 e8 78 6c 06 00 4d 01 ac 24 f0 08 00 00 <49> 83 84 24 00 09 00 00 01 48 8b 45 e0 65 48 2b 05 53 38 c7 01 0f
> [   13.627438] RSP: 0018:ffffc900002f7c68 EFLAGS: 00010246
> [   13.627439] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> [   13.627439] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffff82d47e70
> [   13.627440] RBP: 00000000002f7cf8 R08: 0000000000000000 R09: 0000000000000000
> [   13.627440] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
> [   13.627440] R13: 0000000000000000 R14: ffffc900002f7d10 R15: ffffc900002f7d10
> [   13.627442] FS:  00007f704851c740(0000) GS:ffff8880bba45000(0000) knlGS:0000000000000000
> [   13.627444] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.627445] CR2: 0000000000000900 CR3: 00000000095f2000 CR4: 00000000000006f0
> 
> I used module test_xarray for the purpose of demonstration, but this does
> happen with all modules.
> 
> I have no clue what patch caused this, or when this bug was introduced.
> I played around with the scripts a bit and found the diff below eliminates
> this issue entirely:
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 6edb99221675..8b507907e044 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -44,8 +44,7 @@ if hasattr(gdb, 'Breakpoint'):
>                                "'{0}'\n".format(module_name))
>                      cmd.load_all_symbols()
>                  else:
> -                    cmd.load_module_symbols(module)
> -
> +                    cmd.load_all_symbols()
>              return False
> 
> Does anyone know what's going on here? And is this the fix we should upstream?

Are you using kvm or tcg with qemu? Is the issue gone when switching the
accelerator mode?

And when do you attach to the kernel here? System booted, idle, attach,
continue, load (another) module?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

