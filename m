Return-Path: <linux-kernel+bounces-801366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC8DB4443A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134F93ADD4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ECC30F527;
	Thu,  4 Sep 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fgVBZPdM"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020073.outbound.protection.outlook.com [52.101.191.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6330DD02
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006523; cv=fail; b=l4cf5f9EsZufdS9o+EVd4us+ygF4atrDUcRdOIt3ZAvLsehvd3ytnKUFFWbe2CKd/eeEYojtbthhbkT/qcV4/RNEYotDMDgnpSVXThRzlmM4qfVBiXdmzPd/iRmFyu0RxcoaHd0vI5CYfpp2nEkfoy19CDUsCABzDAA6rwcB1u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006523; c=relaxed/simple;
	bh=VKPQ2yfIPvZVSdRaUBMspsZDXn9n4OIYN3wHOMFAp8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ANn+L1P1f50Xm6ulYcRcuK1dMHmQFfi9h8GqRY7/MY6KwMHtjUUVs56Lk/JrbZPniT7L7NZnw5flFKX3JDtrA8/MOp3A3urfCsRCgMxQKas1iGgzP+ArzHoEcHDUiVMeaw0S5barRR5Evq1qqiIS8aMWLIu5WGkHZs/T3IhSglw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fgVBZPdM; arc=fail smtp.client-ip=52.101.191.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCE4uWUTTNGkEME1SSfzwXvHAle/QgX5XVBNavYMtKocW6xjuoVPuhG2iNwhSdTmzoweMCODKNSB4dL0UIUmZpDZDEfjgNz8J5BUTNSNWfImjiU+LZsQCHLtePnfiVXKOAAas5d16ORc5mO82p+uZf3yWxuQv/xAf3BH6Rc7TDuBaollIbUhC63kpeKB64U2qJs1w0292cSvR/EyFEM1ZEcD7XOWWxl+UnxkH6YHIgmxa5VWnXuB3g+MCkSeQ+IY95kzgAjR5hyGruUQRZbhiygWpDPDv6RsRNZi095jPgNttOX9/HVdOgKDf6kK8emvvTyE12SJdvFwMYReaNpWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfAgxrQSZmUuKaujSEgGhvizWWigTuOUJPdONzHT9Z4=;
 b=nBOSHsYHwgoQRj+dhB3LFFCPWY+z5tsaoO0laTgvd/qyLlaXG5VcQI5mjbGsiK8pSHYHF3MCke/rFrOE33UFmV9ojSfiFnKZqQmPXfJa4GG1kNnYwzAOP44gf14iL5vKs73x5sIC2Y5mZRtJuZ0ic96NePgg3r9RXPTW9/GvfkR/28hMf8+Z/Iu6379N9ua+rSQZKJ5zShO1IwVz+xE/NtCw8k4f1Bqga1oUFs3lxmLqOjkgi34QTUIgQaLjSUrn6u5wADjmlQcl7sr66azV/eUrTqpLCIQGyFQVTW4AYwoSUAZ8VV4v0m2DHYHHfY4al8rejvAqAd3fl7IAVkjlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfAgxrQSZmUuKaujSEgGhvizWWigTuOUJPdONzHT9Z4=;
 b=fgVBZPdMu2ePwerTPvNChqjSgeDAI5C6TOcKCbrS4hJmPxzLl5IxtSEsxgngoxeJ4JB4grt7zVPrQtZnNW37f4cWs3R5OcTMP6nxOD+XW3c2c8sk5WWm+CxQNbjrPAeEg6n1Lm92wfaNceV+IdhVcucRiLCxc4v9TJNTBfYila9pwT5muyF1att/7m5eUJv6JdBiHJGpJDRO6rcse1ydz86Emahn/DTA5uuIVe3fLJq5w149mnrrHWJRfzXPGxAotnQ/yQCZSe64u+chlgdAz0R9fmW6OBIighs6wlL2frtvpYoANxw+EPshBYcy3Na3Kp6jNrt8w/Y36sxQy4fTGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6669.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 17:21:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:21:52 +0000
Message-ID: <dd6755e4-a266-4a4d-847b-f1815c046fcf@efficios.com>
Date: Thu, 4 Sep 2025 13:21:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 14/37] rseq: Cache CPU ID and MM CID values
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
 <20250823161654.164761547@linutronix.de>
 <130e2d99-6c8f-471e-9a72-d858431741ee@efficios.com> <87h5xl0xv1.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87h5xl0xv1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0010.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: da552bec-ecea-47e8-d394-08ddebd78a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkIwa09pdTZBeG5rQW1aU2ZGUHppTGtvOWJQYmJmejNCYnFRUHUrWUlTSU54?=
 =?utf-8?B?N2JCYVhCUmN6U3EwTHU4NTNBTXIwd1A0cndGcFZJcGZtRkxLMzhnV2JicGNH?=
 =?utf-8?B?Tjh0L0l1ZzRnWTI3S3pGZURSVTA2aGN4T1FPV0NqMkVPaWpCNVpPb1RhSVlK?=
 =?utf-8?B?SXRwdXE2N0p3czlQeW5URFpITUpEamNueWFFZzIveXJ0cjlVOUJzL0tvajR4?=
 =?utf-8?B?bnc0U2l2ZWVKdlZGWWtrVU0xWUVtKzVXOE9Yc05IcDFiSXZyTzZMdVlycndj?=
 =?utf-8?B?WUIwR1hjOTlTU3ozTUF4MXBncitnYjVRN1pTZzdHRGVkcUNDcmQxRW5wcWU2?=
 =?utf-8?B?eklrVzRaaURVaWFhWTZmL3dXWnR0WFZoMEw5UXJkeENHcGNLd2pUdExXTzdo?=
 =?utf-8?B?VW1lSW1TdUxsVGlYbWdIRUVMVTNIYWx5RkIxeUd4VHlGRTVKUUhVSWRIcFBV?=
 =?utf-8?B?bEhtSEJMYzB2RWYyN0dkaE41OUlpM1RBNmhpcFU2cWVZcG1KWDhEQ2I5WE1P?=
 =?utf-8?B?bDdKTWFZWW9lV0xndW1zQkx5Z0R4NWgwWTRBVlJlK2dRcjBZZDZ3QWJBWVlF?=
 =?utf-8?B?WWxDVUE4VU41U2lER0xva1pIalpqQXRyQWpoQitrVDU4dWx0MTUvejM2alhy?=
 =?utf-8?B?dFhwaEVEMTI0bzJobm9oM3hNaUhzOHk1eTFwZ3YrWk1PdkZ0T0lGcStSdU1q?=
 =?utf-8?B?U1ltN2lIaEdBMUg2N3JmZkFqWmY5WkNnczg4WWVpYm1GbytJdWFGVmJZdkEx?=
 =?utf-8?B?QS8zb2wvMHFsdlhLc3dZbEdkS1kyWnZjTkFTdmRVYjErUmVLK01nSkExRVcw?=
 =?utf-8?B?eVpLQUczSFRQTnlmaTM3bWYvdkdRRnFtdSs2SEYyRmNmOXl5QVozZitGOW9F?=
 =?utf-8?B?Sm03MmNCeUJnTWg3RFMrd0FPMzJqQ1NWRjloaHI2Tm9kTjhEeE9jVXh4T1Bu?=
 =?utf-8?B?SlptSEovYmJvSkhVTEdDSE9SZ3M2UU93U3RwbFhGQnN3c3RHQzVnSlpGcnA1?=
 =?utf-8?B?b01sUzhSb25YUXM5cE41RzIxaVNsSzZsWndsKy9FNUVkeHVBVUtnZjJYY3hm?=
 =?utf-8?B?ZVBCS3JDUXIvS3dBZXhTcUF4ZDNEcG15TXFVeDRXTW1na1FCNTVHRk5tZzhU?=
 =?utf-8?B?RjBsYTRLNHVodFZYbU1MTzk3d1M4MktSWXZpZEZERm9yMkNKSVQ2NVJHci93?=
 =?utf-8?B?d1Vxbk54cEtwVHdiU1J5MW1SNGlKNEJ4cWJweDhKVEsxVTlMMEY1bE5YQlpQ?=
 =?utf-8?B?MWlsek1sejExVHZsejJqNEh0N2txNnpRNDdvTndBY09JWkNPMktGNWhleDBJ?=
 =?utf-8?B?NTl0OXBoYnZUaEpiZVRaRmJxaEVNWlRnRjZPWjQvSlpGZ0l3WXJ4NGlYTlhN?=
 =?utf-8?B?L01kTkJGaUNCcGhvTlVkWEpSZXNoYi9HSHFlMmVscGg3YUQzQXlNZUlpV0dL?=
 =?utf-8?B?SGlHR1dqVVhBdEYySTY3UlBmQ3UwM2hwcFNWb2hHNTgvUWtIdUo5VHRvdG5w?=
 =?utf-8?B?b1QrNW5SMGF3d0UxbG9RWnVMbjFvd3hERVZxN2RObVl4U3NNd09pWlRETFov?=
 =?utf-8?B?WmpYcjljYTZsM3hqcnIrYU5XSzNOZzc0Q2ZUZXZ2Z08ySVBpYmo4N043YW5X?=
 =?utf-8?B?b0gwM0NSMTVLR0ZUVERmdDhYcXNiWVhTK2Z4eFJMRzNHMm9TRXEyaHo1WEps?=
 =?utf-8?B?YmFQK2R0cWpUL1I4S21WUStyVTFvVDJYRVhCcWxUbDkyNnlxeDc3M0FrZzVY?=
 =?utf-8?B?SUFTaUxTaUM4QkNwZWdPTU5EWlFrVnhacE9zZTlYWXhOMzdqNVl6MVBQRTBo?=
 =?utf-8?Q?mewVc9wRAnjnw+LDc2vK8j8kXGUmgZJKyPr+A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmR0M2J5Rjl2L1l6SWc1REpUd202NzZhWmJjRkRPL3ZxTStnWWhtUFRkajh0?=
 =?utf-8?B?SkdtSW11ZVV4SmZUa1YvSGt5cG5wRGVHVkdFeSs5MDJIN0tDeGpOMUozU2xl?=
 =?utf-8?B?YUtPcHFBbUhLTjYzdE9haURZN3NEZ1p1bEd4Yy9zNVJ6eisrRHVKZENORHJX?=
 =?utf-8?B?Kytud0tIYktBSyt3YklyWnBvcU9wNjdmTkFjY2Z4VFZhSVk3OTdqOThEV1hX?=
 =?utf-8?B?ZFM4RkNLc1Y3REVad0ttUDUrWThYUlhZRzhTbE1zU3ArWVpvbW1xakQ4cGl0?=
 =?utf-8?B?WnJxeFFIbFYra05vd3V3djVrekxEbm93Z3phWFdITFFMK2JBeWFJckVNYi83?=
 =?utf-8?B?TkpLZCtJUmE5UlM1VThqS216b2IyVFcyc3hzelVhM0xHRURJL1hpUkU2MlZ6?=
 =?utf-8?B?bzZrajVmV081SWpYN29WdmxqbGhlcWRYU0NCVmp4cHp2eklyc0MrMUdjd0M2?=
 =?utf-8?B?TlZ5ODhMZk8zWFFlMi9tSVZGdG1MbDNqdnJqekdwMjN0alhzRGxwbWtEK3JB?=
 =?utf-8?B?cWVEbUc5ZHoxbVoyZkNRSDJLU3JnZVZSN3c0TkpvWnJsVFJ1bU9rSlZnb3RF?=
 =?utf-8?B?OXZFTkZqa0JHYUQ1cGNSQlNQeVpxMU1YZDRYQmQzOUg3MmJmT0ZJcHRYZTJq?=
 =?utf-8?B?ZStHajFoU0JKOFFLclp2bUxnR3RRbFA4YzRxUm9YMTNOMlEveVBVMlZ6Nzgx?=
 =?utf-8?B?dE9TSzFDVWQzbllucFF2RGNuSEcrRENzVjVSdkg5TmJ3a3o3cXhyeVRoL2kr?=
 =?utf-8?B?RGpMZ3hmeW5CZytIeXNxV1EyWmltcE1lV2xnNGN1d3EzNG54blUwbHI2Rmlh?=
 =?utf-8?B?WitJWUFhOTBmbWlDUHQ4QVVCVkQrOUJGeHhFM1g4dEpQVFhWM0h3Tm1rRHkw?=
 =?utf-8?B?SklNUmVRVjBKZmJxY2hETlUyQ1FIZlJkakJHUko3SnR3MXcxWUFUNWJXOHQr?=
 =?utf-8?B?a1VBaWxVenNiU2VRcWozbGFrN2hzeUFGTkpjeURvaHd6SzNERE90VFdBMERh?=
 =?utf-8?B?TFc1cTluV3Rld1JySFZueC9VWUZzY3RrNmMxRndWZmhKYmpNVWg2ZDFwZGJr?=
 =?utf-8?B?Sno4QnY0cUVoRkFqTGFPL2ZkRVY2NXgzZjE2VFh5VzBNS0RPTTFTdGNaQkRV?=
 =?utf-8?B?blR4TktTYlBOc2szT3BPYmFFa1ZSdEZTVjVwNmxuUDhGZG8wVkExYmcrSTJp?=
 =?utf-8?B?Y1c0MVZFT2pqUmw4MUloWXJ0U0NlM0tYTXk5UjI2Z1N1SW8vVTVyUEEyQkV5?=
 =?utf-8?B?QTdDU0Y0MmxLenRINis5Y0VxOHNIWU4xaWRRVkM2eW9sNTZONStleGdrZ2ZJ?=
 =?utf-8?B?NjdQMW1pZFJsT2dqQ25LTURBZERjNHo1VUM5ZHhheHB4OXdxSU1UK2t3RlF6?=
 =?utf-8?B?VFhub0hjV0E1VGVVZTJTd3RrN3NVS0tUT0ZJdndza2J4U2NMOUNCVSsybXRa?=
 =?utf-8?B?bStxR3o1NVNndnFQQXVHNnJGYzY5cmlPTXh5QzM2eE1odnhGemRiTE53UU8v?=
 =?utf-8?B?ci9BdnRxMjg1cGlsOVVNN2hWeG9DMnBBQTNKc2lZY3BVRWV4cjdtSHNuSkg0?=
 =?utf-8?B?alVJM1RWOHFEazZJRnFZSWNVd3pPdk5MZ2tGMG1xZXhac3RmdlgxN2ZBRGVS?=
 =?utf-8?B?S29YSmdVdUgvbjNyNVNuWmJESkVHeVl2QVVqbnh2cC9UYmhHNG5OaFgwTFNw?=
 =?utf-8?B?WGw2OUNhWG1ILzJucEVjOERlbTZ5QUtsajNWUUpxTGlWcklHQ2hxbXI2SVdI?=
 =?utf-8?B?WnlPV3lIVGVHZG9oSE52K1pFejM5Zmp4YW9vbWVJYXE1WTFybENTOXIrYlV0?=
 =?utf-8?B?eHZPTE4vQW1oRk0zeXo1eFNWcnpmTndTb20yZjVtVnphdkFwS1pGSDM3Z3hp?=
 =?utf-8?B?N3IzNkM1eTQ4bm14US9qeGsxU2pOMVY1ZkVYZUx0c0dvUUk5V3MyZi9YY0tr?=
 =?utf-8?B?anFCQ1dwYzZncU1yRHRHa2xxKzVxNXk0TC9mRWJudTFsT05NcXpHK0ZQejR1?=
 =?utf-8?B?cmpnU1BtRExrYkhsTW9PQ3VCYlpZTGpCMGUrNU1JTnh2QkxZTmk3cXlvVG40?=
 =?utf-8?B?QkJZbjBUckVzNGVEVjZGbTZwRW1ubHVQUFZXWHUwdzJSc2FEcEJRU2tUTHUw?=
 =?utf-8?B?UWp2eVd2dTJYRjdJUDFkd2FWUEFNVis5UEQ2VXptMVVCTGEvcnU3UzNDSHNO?=
 =?utf-8?B?cXhmdzBXdFl1V2VXZXRtTys0cFdOUGZDZzc2UWV4TERETWUvaGh4N29RdDNu?=
 =?utf-8?B?NG5HTW1ySTdqVnN2L0drbHJ6TTl3PT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da552bec-ecea-47e8-d394-08ddebd78a1a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:21:52.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7TAw1s5JGzqoKdAYOz2TPgRD+y52IeRLRslDU2Uzrps69Mz8IPaZ5c743BCD2d8cD0BGHBYBXs61jjE7XUqVTY2r4zPQJMggqDwM5XQFmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6669

On 2025-09-02 09:48, Thomas Gleixner wrote:
> On Mon, Aug 25 2025 at 14:19, Mathieu Desnoyers wrote:
>> On 2025-08-23 12:39, Thomas Gleixner wrote:
>>> In preparation for rewriting RSEQ exit to user space handling provide
>>> storage to cache the CPU ID and MM CID values which were written to user
>>> space. That prepares for a quick check, which avoids the update when
>>> nothing changed.
>>
>> What should we do about the numa node_id field ?
>>
>> On pretty much all arch except powerpc (AFAIK) it's invariant for
>> the topology, so derived from cpu_id.
>>
>> On powerpc, we could perhaps reset the cached cpu_id to ~0U for
>> each thread to trigger an update ? Or just don't care about this ?
> 
> It's invariant on powerPC as well after the CPU was [hot]added to the
> kernel.
> 
> Otherwise any usage of cpu_to_node() would be broken on powerPC, no?

Agreed. I've added powerpc maintainers on the other leg of this thread
to validate my understanding.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

