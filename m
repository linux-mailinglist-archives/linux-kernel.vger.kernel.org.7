Return-Path: <linux-kernel+bounces-874189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359DBC15B80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD2A3A18EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7AD346784;
	Tue, 28 Oct 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YWOXdm8+"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020075.outbound.protection.outlook.com [52.101.189.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478F34321C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667796; cv=fail; b=VYcpP9s3No8DH2mKS2eKLciTG5zsqiL7mOE6quSzZBFv9Y4ourQEOufAgHi8tBVZLM3ITUDsyKFagc8U+9nvfAVLCuiF5oAZHkuZwSbbV/sMIz/uPPiZNZ4+mKLEvAvIBRYpisRMZz2zWll8G8GRdxQ+xh73MmGyI8DmtMHk+9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667796; c=relaxed/simple;
	bh=rcjqcCSjIgidAHehYlY9lBjmCyfIAoTudHiU2Ob4jII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g9nQAueXEtNNdN87XVK75aKFnFiYULTEvzD4/i7mqbyAt/AQA2d3sZuCxnpCEZW0tEe6h9WPOnt9m7u9NwDI392Sg0xbdLmwC8w4cgH62XtwQ6N9pHvRkOlqUKxRhVPPrWu8dZxPu97dhpcZeRY9S610BZBphaet/l8ywLc9rFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YWOXdm8+; arc=fail smtp.client-ip=52.101.189.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSsIoLd3RGvOoKAasaGzVoK0MTCgzjLLUxp6Y6dsWEGL1f7H/BBaOQbo7duUqrWkWYQ77mPfqtv9DQ4jNUe1ROY7NvVHRxqX/kUD75z3fX+T0KV58pxMv/WD+QnqUVddCmcHQXBPmIM2WDFABGJ9qZwWenjo6vReiglHUW+gqcuHN7clpJM88RzIA8CD3ugWNQF/xVdmvQodMBoUYTticN/ijCsARtefEGaiwpVi7C7YF9Z3LtNHbz9QjwM3SEk8xbg00jOQagJagKIo3bEtqbQdpN7MUjYw6GL4Q5HBtdijosxer6LYm8hmmgMzLlXKr/c33JBYO24G32x76zp27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3f3V75ONDFIpJEcNHGXkHGLN9fOuHcl4m7AVCRxgak=;
 b=b7LE7AIn+BFTm5InSU55aAF4/XIcp0+nFNihmTrIhf18/53Ephcg01y81nIdW8T5b8R5JY/Tg3aLOjmVHv//+MBEyJIMZ9uhJ9Atbf/fe2INGpEibAQSRIsZDyCkoeqLaDxH/xhx6WNWhQL9glX7aFEbMXJIRAgcLpc7+UH9YrgxLDBfaUa9yBHqBpnHUo7G1oU7y3QKrszfMNCHqoZ/Wxi97/D2aE8fABIdAf7Ja+3a7cFEMq8f5RPKUwl6IwvfmMFsGv2CuT0CLXaNEGirSVnQomwrTE9EEvwHPUh/e277ewS++cuoqqZyvjSQwfUMOptwinoqJQGz6ua2G9vyLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3f3V75ONDFIpJEcNHGXkHGLN9fOuHcl4m7AVCRxgak=;
 b=YWOXdm8+mmvvia/CLpsQrMGpZoVOP2qAJV76QOaKOQzxe+doDgzboZblMqbYYRsk0Id/r3aIksZfXp6ziFE6JvDq5P3RWTfJ9Um51Xzd3BPB/uw47/qRKcPVdt4cfvzLviN33sHsWpM+W7LnlExWPgENF+iToAZZn5NKiUyujEALIT67aYCp1L0turvqqX+OKseYmCoDU1NlcUShdelJPXxy+dm/afDeNkCWEp6rAC9b56GEPL5ZSLJ0e7V5XHQkElD/efbw2SzyMBHGQ8z0O5d/HNeK4jCbFWBiGFIi54MViThlu4gdQAO9HR4EmWmSfI69YRcI1yKGjeDSbiYAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9357.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 16:09:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 16:09:49 +0000
Message-ID: <87cb6011-bf01-42bc-8dc0-aa709809b050@efficios.com>
Date: Tue, 28 Oct 2025 12:09:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 27/31] rseq: Implement fast path for exit to user
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.638929615@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.638929615@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0041.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9357:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b5786e-9575-4c4b-11c6-08de163c6bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxFRnJVZE1udTdpMmQyeGxuTUtQa0hqVUpWQW5OMHBFMjNjeUsxRlpCcnF1?=
 =?utf-8?B?N2V6eTRON2hwZGZYRTl3NUwrUFRzVjdmV0hGenlTZGVJSk52akZoMTFIcDlt?=
 =?utf-8?B?d28rdTBqMUZyczZpR3dtRXRQckhncG10VDh2SjNscTVtamZPakxFbkIveEFr?=
 =?utf-8?B?YXN1RWttemo3c253UzVRV0w2UmEwZUdjWDBZSFdxQkVZZnQrdGVrTXVxb1dk?=
 =?utf-8?B?Q3pLdFI2N0Z4QThrZ3ZHNjdIWC9HWTY1d3lnMENtYU40TjdRcUIyZGpXdDRv?=
 =?utf-8?B?UktEUExwRkNlVnowYlU1RCs3Rk9KYzdjL0dwekJWN3NHNDJKVFdGTlNMY2Fw?=
 =?utf-8?B?cWJoQVhaOXM5d2RQL05qcndhQk1jcjNZQTFRSzVDWFFQTXRpNS9HRUp5TWJx?=
 =?utf-8?B?eXM0SEw1TndmTkpReTZBdldER0swTEREQ3hORUhoTnB3MGJtdWZjdEtKMFJq?=
 =?utf-8?B?K3dhMmpHZGFudjF1QTJkek1aVnNlTFpnSjdpb094V1EzdXNYWE1iR2JLM1lM?=
 =?utf-8?B?UDJlamE2YlFraGU0dmJTME85Y01HQmdxcmF2c1kzQVJXZHNWTjE2eFlTTWkv?=
 =?utf-8?B?ZHB1ZW56d0pGV2NUKzNKTU5iTmUzcjMwZEZSbWdTUTV0SlVmTk9JSWp0VWU3?=
 =?utf-8?B?Y1RyYlB1bmJPUFBaM0VEVzBuL3hSL0puRjNUSjA0TjJOSjE3aHd1UkVZNGkw?=
 =?utf-8?B?MmdJa1UyamFvS1UraXE2RTlKTTExQStmemRicmlyRFdRUExCT2diaFpCWWlY?=
 =?utf-8?B?RmhiSFhCYW5VbVI3R2Q5OHIraWl3bTF5K0pUQzVGNnB2RFJycUlhSWRIWjdU?=
 =?utf-8?B?bGFzdWJOM1NUb1M0aytQdG5XTVM1YU9WQVFNU1psaHNKNjl0bEsrdE5VZGhY?=
 =?utf-8?B?cllMUmJVQmxVbWU3R05OeG1uK25FL296VEZOd0FqRmg1MktIeThzRHVUMzBz?=
 =?utf-8?B?SGhKc3k1WlZsTjZxZWZVVzFZbThLdUJLdm1GOWlneWlsR1ZJZ283dndtNFlo?=
 =?utf-8?B?akg2VlJHdHlsblJ6U2ZhMStRQU9JZkNYZFkxV0RzaUVwNE4zdTVBOUt0R0xW?=
 =?utf-8?B?TUgxeFpJeWFZN1pCV1FRc25sNkg3WEJuUVZtQTI2ODBvQnBsaFg4Vk12anRS?=
 =?utf-8?B?VlR1OWpveHJhL2hqYzJSOExLMWM0SVdzVVRxTCtjRENpYmJreTNBUVdWL2JW?=
 =?utf-8?B?YVVVaVY0M21DejVMajY0NEZsbmdORy8vcnJYN1NWTzQxc1BZN21TNFp4d0Qv?=
 =?utf-8?B?UDlnY1djL3dyWC9tV2VIL29JK00xZDNkTWRJOHR3cDZSVS8raXFBa1FrZUp0?=
 =?utf-8?B?U2dXNHNhSHRmRzhMajBxdTJZVk1EU0hVZVVscUdzcnF3b29HTlUvdkp4KzBp?=
 =?utf-8?B?cVhYS1E4SktON3crY3lyQVZqOVBuajlDMmxuVG9xNE44TkliV096azFiQndN?=
 =?utf-8?B?L3NNOTU1NlJJdzdiUnRURkxmMS9JdmY0RzZXaytWZ0NHakNQSG9ub3N6VWxr?=
 =?utf-8?B?Q3JCTWd1VnhES1pGVUNJQ0dBMXJXTjlMNGdOTGhhMXV6bi9UbzVMeEdUWUtx?=
 =?utf-8?B?LzJZTzdBdS9xc0ZDcGlWNDk3TXd3cXM0TlF6aU9lSnBKV21PWEhSelc2TUpM?=
 =?utf-8?B?SkwzRjRpK3NSMmRSNWgrSCtzUGdUZnZpMURwUHVXQlRlbEwxUGRUZEJwUzho?=
 =?utf-8?B?Z09nTVE0SFBrT3prRmVuL1lMcUdNaE1nV2MxMHZuaGN5MkFvcFd2SnZPTmk1?=
 =?utf-8?B?NXk3a1RXYlBmQTdUNWhNemV3MkdDVlZmY0tKQjFuaDBTWGY4UExDUEpvcGpM?=
 =?utf-8?B?NytHbHBGNEN2VnBzaDRhampTTmlQMHlLQUdYY2NTOXpiVnZuMVBsTkFYM3lI?=
 =?utf-8?B?MzFQTTI0MDAwa3drbXR3cGgrZExGODlzRHdtcnNYZmEvd0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFZEbW95LzdhT1hHUFFtOUw2K21ROVJKS2xHOUxpWDNFWEJNdUZFR1FmWlkr?=
 =?utf-8?B?UE50SWZkRVV2cElkWEVRdUpuTVA2NXhvMXZUaFpCRlByOEdOQmpqZDNOK2ZD?=
 =?utf-8?B?YVFwR09FYWkrbkZDbVA2R295ZUpsSUhoYVpsanlBM2N4a29BVEtNZDZCdHlT?=
 =?utf-8?B?aWRHVTFHRk82Vk9YMlBxSkcxeUVIRVpJbEpqNndFbFZlZVJYaFVNbHBIN0c2?=
 =?utf-8?B?YUF1VktKRmI4T3JpYmo3TUxFUG55R0hzd2kwemxTYS9LU3dwOFhkZC84U1Az?=
 =?utf-8?B?Z01pd2dGMlVhQ3JKRlBCMWJkaUJETmkzWjEzOFBKT0lFK3FEd3MvVDY4cFpx?=
 =?utf-8?B?WXpNNGhCWmxZbEsxZXROdzlWY0lhLzh6R25EZElkdllFbmVlaDVnZ3k2QmJJ?=
 =?utf-8?B?QjM0SXdzcG4zWlJYaDBQK1ZjaFdWdndyOHYxRmFMdWxkZFhrQXV3RGVCbVRz?=
 =?utf-8?B?VlhuNnJmbXg5NTdTTTczRDR1RW1WZE5jSjN4QUo5SCs3WStrUHRpYWt6U3NB?=
 =?utf-8?B?NFg2c3FnbkczUDZsQVJIYmtsNUlrZDdpU2VEaGp1WDhGMGRtZmIvVzJPTzN5?=
 =?utf-8?B?bEs5dFR2aFordEdNR3B3MWtkck9WQnZ2VkdGdFdiQTJpOVhBY2MxbmI1RVA5?=
 =?utf-8?B?TzVydmpPZHRTUklnVkYrSHl1dUtPdmdiRFl1dmVHT3ZWVjFnOEY2cWNZMEts?=
 =?utf-8?B?WEdpMjg4K2w3SlVkckRibTJlNW5JYVF5cjV6SS95MXdsQjFrN1NCOFpjbTNX?=
 =?utf-8?B?VDZ1Z3RGS3ZuUjF2QWo4SVg2aW02c0ZlU2x2aXREWVpmTVJOU1ArRTZ2bXds?=
 =?utf-8?B?TmpySGtlMU91LzJlZkxnbTJpUGZzS3orVllwMkV0bUNGZDdmSkV4WnAvbEY1?=
 =?utf-8?B?VWloaXFMa3NtRm1BYlgzWWlSNnh6MWpmQVdSNjdDZERudHZzZUQ5WnNJWFh3?=
 =?utf-8?B?aFhJeVFYN1NRcVRhcDJDMGlyd2psQTRORUFnc0dHVVZrV1ZnQWs1amdwaFNp?=
 =?utf-8?B?Z05icGVJRXNEaTJ1RHpLczNXK3dtK0RONkNGcnlRTGt6NmJCK3hnWE5FZ0dw?=
 =?utf-8?B?WWxwcS84b2dScERPTFhmTHdwbXQ1WHpuVkIySFIrS2Y1NGpCTm1XYW5teGR4?=
 =?utf-8?B?NTNyZVRZV013c09mQjgzb3BzTER1QlhxYWtEWThJdnRKdnArY0lIbStlRWlR?=
 =?utf-8?B?Yzh0ZUhDY1BMQlJ1ZFNvT1g0cFdBbHFNTkp2SVZESzhqaW1zWTBxejU5UkxB?=
 =?utf-8?B?bHdkOTZDeXVwMW1GUW5JS2cwWFl0MVBES2g3bGNRWS8xTEIzRm9nL1U5QmtB?=
 =?utf-8?B?cWROVWlLWk42MGVDbUd5aUVFR1VVK2h3UXdTc2poTUhtWEZ2cWozOUlCTkQr?=
 =?utf-8?B?UGlORnJFTjRxOUlsTWxpNlcxeFp3TFI4aDdKYTROMjRGYWk0RVBvb09DOERl?=
 =?utf-8?B?M3o4THZrb3ZnRGg0NE9JNXZHWU5iVk9lc0J6amo0LytIN1k0YmRHUzhla1Zl?=
 =?utf-8?B?WFVKK09UT3RNNm8rTnd6TnpPOU5LQURUOWdBa04vcVFKdFMxZzJBb1lubTk3?=
 =?utf-8?B?bHJsZVRvb0VmSjA4TjltbnNneE9lRGw1Q05RT2tDTFlCNlZuVGFleHNIb2dX?=
 =?utf-8?B?SUFSek5pY1l5VVBDY0JzM3ZnRllmSjc0VFZ0UkQxeDdRS3JmSEdwVUVpaWVu?=
 =?utf-8?B?Wnh4U3FhVE9kOGR0M1N2WnMvbFZETEZTNlZCM1lySk1xdWtSUUpsSldxZVo5?=
 =?utf-8?B?Ty9XTlp3NW53ZnhZRUdRZEg1SmVGUGp4WWU3VHQ1NDU1eEtFN1R0MlZhN051?=
 =?utf-8?B?YzRwQ0l3N3k1OFVKN2NtdnBsR011MWFsbElRLytGT0VmcmNUMUo3aW1TVnEv?=
 =?utf-8?B?d2FxL1FFVUROSmJ6Y0xNMVdabys2Z043K24xMGJGdVgzOThpMkN5c2dueHQ5?=
 =?utf-8?B?NWd6R3J6ZGJZSklPTHV2NXhlRlVPMHltaXBpTEhhMkMrdmgzWHNwVXROVkRZ?=
 =?utf-8?B?ZDdkcDB3ZHpWRjdwdFFCUGdET0U4ejJ2Vm9CNkpaQlpGditMT3FXc3RSbk9a?=
 =?utf-8?B?TW54YmpmaGFqNTNlM3gxUVJ0THp3dldlcE1qZVBTOVlKUDcwbTQyclhUd0lV?=
 =?utf-8?B?dHdDYzExRUhXdFZOSXhaY1Q2RnlFM1ZKY3hDZGpCa09lejJ3VmZRdEdtUzM4?=
 =?utf-8?Q?FrIZCbXP3UW1rzp/091sM5g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b5786e-9575-4c4b-11c6-08de163c6bd9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:09:49.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjhBAM2+8OUDrHgrIuB9U7cfi6RyTI5lZ5UGrao/wHSQMQbLLD5qgLwsPdooEHbSa7GJMELLxMqxcTHVgA5h1MAyD9Vxp2BXfpJctrdt1X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9357

On 2025-10-27 04:45, Thomas Gleixner wrote:
[...]
> + * would be exploitable at least on x86, and also against a rouge CS

rouge -> rogue

> + * descriptor by checking the signature at the abort IP. Any fallout from
> + * invalid critical section descriptors is a user space problem. The debug
> + * case provides the full set of checks and terminates the task if a
> + * condition is not met.
> + *
> + * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
> + * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
> + * slow path there will handle the fail.

fail -> failure

Other than those nits:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

