Return-Path: <linux-kernel+bounces-786788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D3B369DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5490A565390
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628C352FC3;
	Tue, 26 Aug 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NBQuN1zC"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020092.outbound.protection.outlook.com [52.101.189.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A59350D4E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218120; cv=fail; b=aFXdCkHy1F+txz69WQ5CN1M8njP4G9Sc2ApW6exlv2rCRDBeAkk1mrtW6vOR5TLuhUeGDJ/ydMdpUn38l3kVUDNaKs38jUkyGN41RBnF0xCYsbl2nEvxpjexpNApfQV9tiW+OOLuXRC88lnVlws67r0DQdBzLcSXWjGMIYvTsqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218120; c=relaxed/simple;
	bh=J9Bf3e/Gn2XuSdESMFfIZrNhBpD/lvJXzYrN2uNF8j8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NbjHqbowjl/oOIV9//YB5/Iwb/akNr5IsRFQBJDEVScBDePj+bciqt+XOjFsQdQq+ayzY5UcSJwoAv9IKfdo21XJON2xV/ZlrnCJtrZG0dB2Ywwk+CGOCl/CH51qSZAWjXQ9GYGvY6fdbrsv4rSlqUR62VXcFn8YgbMyuk8NWFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=NBQuN1zC; arc=fail smtp.client-ip=52.101.189.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDNlnRXoKnIC0KuV6BSZQOOH7NBwKuD+UNjWMgCeeTllnuuOPqEDm+iftpwkVt/I//CAOkDBwmLU2LGlqDz2lxLaE/KlFVJg+Yjmh5/yxoBCq6Ug9KP0/HOOlWgkPW/Dw/ZikFxHrkQA5NmDktS2ZVtxF8XbObgt2ePyGG+TMN6e5hRST9duxnF3B7mFOmOh3o+bV+Yd/RgErT663jMrxZqiLGRoGJcrXJmvLdEkKn7qbJAjuZupjJkz94PCTbmF5LZhpUEs/aUnU3vW9hJDrJZj2Drcao37B07pdW5R8KFr4k0LUwa27Fwc848100fYb854GIu06Kk9v0jT0DyTRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5Wm9BFw936gPbmVf64smBvM2ULWz4XWoa9eYzckJqM=;
 b=maRJjKl8jNHx8RCNFk1KLRNDiy8p6NxuS6gRtoJy4okgbPx5/TsAXy7cregIYIn5nUYtTaTIRWsqOmYowQaYr+sE+ePKQDJuwXtOY9adQVzQ95TenflIdPQ11pNaYncinUnsUYR+W0Hcgc8BbSio15PVua5k6OOiB8xpgM6+e3eYDijWAqVkBcBoNBuFdYdDob9le57iOnwiCU3/Fx0k1WLsT/uiEkTvss+k0LuWO8RQgbTfXaVEccNZgbGYzBjgEDui82YxXaUMwy72zvqZzAReo+cqN0x75DDwnDGkNHZb+EcExZecNR6BtTqbtjC7n86Ft4zqqwdaLksua+Ps0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5Wm9BFw936gPbmVf64smBvM2ULWz4XWoa9eYzckJqM=;
 b=NBQuN1zCbHlqb7XsyrKjrqvV35xrWCegsJI4yRsE6MifemaSANMxCP8Lnby+TZd5dgIPqfusslFYOFSZcZ98OI37KbY+PsjzewSwgLrammTxVmBIVVkZPi2GdOvWaOfYJLMEqPU4j7SmgfJcJnkQ5iDZ8PZdvp3hZf5YTJyFzlQCRoz6SdfOBkbZUjW1bekGw1bAfZ0ajLqKXYiiZXGep3o4NUJUHVGPfLJ6jDjpo+mNxgSd5zxvST2uak+ohVWCvxeJg9/eGhLFb5uWnA1HmElQTkkZF0EbKateHHIkCr7oPn0nvohMb3craykedk8VpzUjNFJcnseif+1XPsmatw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10295.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:21:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 14:21:53 +0000
Message-ID: <a3bd4b4c-75fe-4031-adce-b7c8c3bb631e@efficios.com>
Date: Tue, 26 Aug 2025 10:21:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 20/37] rseq: Replace the debug crud
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
 <20250823161654.547589855@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.547589855@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::32) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10295:EE_
X-MS-Office365-Filtering-Correlation-Id: 25180db5-abea-4788-12c1-08dde4abe7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGpTbGhraFhrc2JnN0ZZeUREekZCNkRqaWRnM3VWRnFibHM5T1o5cC81UGdq?=
 =?utf-8?B?TWE2OU9YUjA0OVpGSkFNSE5nQ0pOMy9UOWRhNk1wbUlIWW5iK25nSjBoZStm?=
 =?utf-8?B?eUdyNzdmWWpBWjRFa2FQdHR5OGZrVk90b20vYjI0MmV1MEVqME1OTUtrQlhZ?=
 =?utf-8?B?U3V5ZjhFMGJaaFdqV2U3QUNEU1kwMHFlTTlhaldvNUtYZjVUaThKNG55MEVy?=
 =?utf-8?B?Wld2NzZlZU5sYkZHbkdla09qYm0rbVN2L1ZwR0hmeGpVajZjYVRNUEJGMnB6?=
 =?utf-8?B?N1NBQVFFcHdSWUlmMyt6RnllVy9PYW04UVdyU2ZTNTFxUWlEU256WFcvMS9V?=
 =?utf-8?B?TFdUdG1MZWxMV3N4NFlscXhESWFLdjhpZTJlaEhGMHZ0Qy9tOE9WUzc3ZWcw?=
 =?utf-8?B?MGhHdTdvYnRkaVRTN1N3bkE1MU94MHBPRFNQKy80b3JiOHBRZEpCa3BhV2ZU?=
 =?utf-8?B?N1lVUjJiS1QxMFlVNkhIOU5MWHlxRk5QbW1LTVBaQ1VOdUdCMGtkK29VWG5r?=
 =?utf-8?B?U2oxejhkcElSU2FONW9uN2o4RGlDdE1aMit4MXg2TW5EZjBuaWxhN3VUS2w0?=
 =?utf-8?B?REZEbVlrYjlIaUlYVW9HVjg5RmlxRnZYMUhiZ1FkN2phVTRHNlNZTXpMampy?=
 =?utf-8?B?QnRHWWpTQzBOeWNaM1prd3o1bG81WUh2dDRvMCsxWDNTTnVqVEcrQXNvWmxJ?=
 =?utf-8?B?QmNsMTE2WUpIdU93OWRsbTArU2lpcTBOb0VveGcwdVlVVDB6Y3BCU3lRK1Ir?=
 =?utf-8?B?QlZmK0xSeUlNQUdhQVJQbkY4eW9EbmwwdFVKNTNBQkd1bC9iOExYWFhWbCsz?=
 =?utf-8?B?Rkpma2hkSGVYQ0x1bitCVjBZZi9GN1g4am9RWWZWM09yYktYaG1FTmVpNDNI?=
 =?utf-8?B?SVVQa01ObUZTSncvRjFFWDB1L1ZaU2FISE5HVGtCZ05zcGFpQ1BJSzhrTnR4?=
 =?utf-8?B?b2hBSmNTbVFORnQwWGVZRE1Ldy9UNGQ5UWlIVElLS1FLakpPaGoveThrQlZo?=
 =?utf-8?B?cE0yV1JiK3NpUFVvT3N0MXFDaFFWendUL3Z1ZEJnYVUwLysvUUhlcVc2Mmlp?=
 =?utf-8?B?K2lPSnJINjg5elZIMzZtaGJ3aFZSUVF1Y3RyZmx0Q0dRdVZMSnBsUXdNNW00?=
 =?utf-8?B?R1JUa2lVR2RBR0UvWk9nbVk2TlNTOEpBK1psTkpHWnZFSHU5SzdRbFZWaEww?=
 =?utf-8?B?QnNXU3lCdzBDOGtwYUxpSlBHVUhBOWhlMmpLRnF2MndHTm44WTlxUS9MbFln?=
 =?utf-8?B?Zk1EVTN0cmpDWDNKckY5Q0VkajNoYnJFZHBMUllRZXNia3MyMFZVbmdsL3hy?=
 =?utf-8?B?aFhVM2RWTVBIak03SzFmU2FKV3JNdkxybjlRTlJveFE0azhXS2tESTZSV05w?=
 =?utf-8?B?cW1vQ0o5bmlsMGxTQ2RHNE9nTzJubkNKUnFZc3dCZFpMV1A0VDA0V25WbDlS?=
 =?utf-8?B?Sk16Y0dLYlFNc3JqRVdHY3lqRUl6ajBCK1o4VnVVQm03dXgxN1Z0UExpb1lQ?=
 =?utf-8?B?OGNYTmt2M2hoSzZoMjUwaXFwRUpVUzN3eUNzVFF2L2x0UjlSMWZkNVdJRnpP?=
 =?utf-8?B?aDh0UDlHUXdEN3U3Ty9QaERwUGorenV6SzBqdGJXUlRtRGllUDFIOTdpeDJ3?=
 =?utf-8?B?UzlETFA2MHNiNnIzTTU5MjRaVmd6VlVCaXUva1V3bUJjNG1tOU5qTDc3V2du?=
 =?utf-8?B?OEVuek45OTBRek5HcW9uZHBIT0RRcXVRY3VFRXdpT1pYWnB3MFdGRk1jTk9N?=
 =?utf-8?B?RkVHSVpSOG5jZXEvUEpUbDIrZFJZUVFsWGZPSE0vcWVBdVllUlJ6NzNWTEhk?=
 =?utf-8?Q?KBlk/CkknfN8Hbp2PaqSsYXAuzlaaiVgdglxU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NJd3NSYTVTQU5oUy9hQ05FaGVGcGkwT3d1dTdNc1BveG4xVjJUNnZsdmJH?=
 =?utf-8?B?MGoyN2wzVE9neW00bzMxZnJFY0NxQW1ITmRkTUdlOG5rKzdSZHhQWFdFM3pG?=
 =?utf-8?B?dDJqdnp2ZUU5YTlYSHlBd3dEanpmMEFaSnhUU2Z5NUJOQ1ZoTGoyNE15N0gy?=
 =?utf-8?B?T2l5clNQdTFhMDlPbjB3ZmllZDVISDVlYWF0bmlOUDF0bTA4Tk82bjNUMGY3?=
 =?utf-8?B?UFRvSzZ1NmZiRmdiWWNMcStGQ01scVg0YUZrMGdaaDdiVVhmUm9XK3hxbXJp?=
 =?utf-8?B?NWFuSHhIenpqc1dVeDAzOWZBTENsZnNza0UwVFo4Rnd1MHQzOUh0eitENG5X?=
 =?utf-8?B?WmE0NndKbHNmTUNSc0w2eHJCVDVvWHpYMnBVU2s3MkJmcjNzWGdaZWtldDdG?=
 =?utf-8?B?aDEyQVZxMEJGNjJCOHdxaE1CSEVYUE1uRlVOaWZqYk9vSjJaZW9wSFJ0UXZC?=
 =?utf-8?B?eDBPejZHQzdwckcrSVQzWXZIMEYzUHhkaVZYd2ZndnFrRnBZdU9sQjVKZ2N6?=
 =?utf-8?B?bGdCRzQ0VGVwNE91MTM0bGxjcTVjUEdzNktoWW9ScGlBc3VqdVlGVVJHTW5R?=
 =?utf-8?B?RE5RY21hajhVT1UxWjBIYlVyQTJGdjFrOWZLb1dkM2pXM2FXT0VwRDUwL1Vt?=
 =?utf-8?B?bmY5VGdFeHVCaHpMVFBoUEp2R0d4d0l5RTBJeDdVeERBeTlsMzI5bXRGbU5Q?=
 =?utf-8?B?bE94WTN5YzhLTFVlOGRGZ2llM2xUSDg3ZEdKY096dU9QOHA1bnhYclY2TFk1?=
 =?utf-8?B?RS9JTGRFQjF6YjhWK3VzSkFyZE5IbUVXOVh3RytTRC9GUmVWdlpDN01jNjFh?=
 =?utf-8?B?L2xaMWE1ZTJtRnVXeFdjbUYramUwaW5SRDBMRm90SGdsV1FHTmpaSG1pdlpy?=
 =?utf-8?B?dkhlQmtKSUNMWkw1MHorak9HTkRKZ0NOY3pDdlYydCtZR2czTFhrUm1NT05I?=
 =?utf-8?B?YkhscldqVVFhcVJaT251VXlxWEJLWFcrVFNYM3pTUlp1akp5Vys1dnpqRktI?=
 =?utf-8?B?Q01GdEE2RTBRMWtZejJ5WlV0UmJMLzAzWFNwUU03WmZHS3hLTHdxS3lueGo4?=
 =?utf-8?B?amJDVVBVais5SVBkSFNtd2tIKzRwSnI3M1BEWEpTQTc3ZkJ2OUR3Ui9xY2RQ?=
 =?utf-8?B?SlhONS80ZUU5d1VVN2Q3RTF6VnNmZEc3eXBkU0lWUUZEUnl6VFgyblZwNlVz?=
 =?utf-8?B?d1lUaklPN3h6bUU3dlhkNGlidXNtRHYrd3ZqQ0lYbHAyaFY4NVdvcVlhOUFz?=
 =?utf-8?B?bFduOFdZOWNTWnJKZENad2lzc3pTVVRxTkQ0aXR4SFlZZWhZb0VXelRUVmFh?=
 =?utf-8?B?K04wSVordlVMbzBCK0NFenBNbGRuVTdKdjIzSFZTNFVNNXdvU2tEL0V2WHVa?=
 =?utf-8?B?STFqVGE4TWwvUFpGK09yRC9FdDR4RG1UN3ZmTlJHTTBSYWp0Z3duVStacTA3?=
 =?utf-8?B?N1gyUnRXOExMUkI4TXk3dFhrbUVFdFF5YU95VkdZYklHUUZwZytjWkF5cElj?=
 =?utf-8?B?WDdxcjB2NEJhc0hLNjJBeXV5K2lqd1pZQTdrbC8xMmxzSFV3VnQ1WWQ0Vkta?=
 =?utf-8?B?K1hUUms4aGZlanpYMVlOUEpmclQzL0QzYmZQd3laQmxIa21rVmcrelc1bzF6?=
 =?utf-8?B?cVd4bDZ6bEdyOVgxcjdvR0wyY3JONUY2ME03RDVEV0gzLzNKeXJsK2duODNE?=
 =?utf-8?B?WlB2Q2JpYzd4TTIvbTNsSGJWT3ZhRkNMM1M3MWZXNm5yaEVoRVd2QnF1SE9O?=
 =?utf-8?B?L2tFZWRnNEJJbGlVZStsUTFaV3NRNmtIRHNFNkE2dDBSZkhhdnJtUkRVVDhn?=
 =?utf-8?B?NXV4T0plaUxsVkFZMTlQSXEzV25NSkNab05zWUFTWGZqeklaZE9BbFRGeW5S?=
 =?utf-8?B?cFBaSEZ4Rk9kdnRYcHk5WVE2NVZiS2lVTS9WQ2lmYUtrRWpMVG5ma3R3VTVK?=
 =?utf-8?B?cTgxRjBGZ2pDM1dENnkzcGE2MjRETFZCejZZWU5zdjg0SHZua24xeHFaU1Bi?=
 =?utf-8?B?VmZMTzFxdFRyeVdkc2JuWkZvQWZyejYrV09oQTh2RUgxMUdGRFJadUZ3TGt2?=
 =?utf-8?B?c1QvYUtLaG5jeG4vbjJrMGozZXB6cTYvS3VsOW1GeENNZ1k2Zk5lWWMwd045?=
 =?utf-8?B?aUtsVkd2RW56ZFNmS08rY0ZiaWwyeUF2MTNELzFaMDZDa0t3UDJ1dm5MREdi?=
 =?utf-8?Q?BcwMLzdBeAD/y4KYVxUPh5E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25180db5-abea-4788-12c1-08dde4abe7da
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:21:53.8329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X24NzLGsQfmZMD2bWVM8doUlqgdBKW+I9rkWLPG150e+5CeX9JRU9utRY3oUCd/K9O8x1pYsmgCPJnCvBUc/GwNYlyLetC78o0vnvfpAZj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10295

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Just utilize the new infrastructure and put the original one to rest.

I would recommend changing the patch subject to e.g.

"rseq: Replace the syscall debug code by the new infrastructure"

since I don't think the pre-existing debug code qualifies as "crud",
even though your proposed changes are certainly improvements.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   kernel/rseq.c |   80 ++++++++--------------------------------------------------
>   1 file changed, 12 insertions(+), 68 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -472,83 +472,27 @@ void __rseq_handle_notify_resume(struct
>   
>   #ifdef CONFIG_DEBUG_RSEQ
>   /*
> - * Unsigned comparison will be true when ip >= start_ip, and when
> - * ip < start_ip + post_commit_offset.
> - */
> -static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
> -{
> -	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
> -}
> -
> -/*
> - * If the rseq_cs field of 'struct rseq' contains a valid pointer to
> - * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
> - */
> -static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> -{
> -	struct rseq_cs __user *urseq_cs;
> -	u64 ptr;
> -	u32 __user *usig;
> -	u32 sig;
> -	int ret;
> -
> -	if (get_user_masked_u64(&ptr, &t->rseq->rseq_cs))
> -		return -EFAULT;
> -
> -	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
> -	if (!ptr) {
> -		memset(rseq_cs, 0, sizeof(*rseq_cs));
> -		return 0;
> -	}
> -	/* Check that the pointer value fits in the user-space process space. */
> -	if (ptr >= TASK_SIZE)
> -		return -EINVAL;
> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> -	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> -		return -EFAULT;
> -
> -	if (rseq_cs->start_ip >= TASK_SIZE ||
> -	    rseq_cs->start_ip + rseq_cs->post_commit_offset >= TASK_SIZE ||
> -	    rseq_cs->abort_ip >= TASK_SIZE ||
> -	    rseq_cs->version > 0)
> -		return -EINVAL;
> -	/* Check for overflow. */
> -	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
> -		return -EINVAL;
> -	/* Ensure that abort_ip is not in the critical section. */
> -	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
> -		return -EINVAL;
> -
> -	usig = (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
> -	ret = get_user(sig, usig);
> -	if (ret)
> -		return ret;
> -
> -	if (current->rseq_sig != sig) {
> -		printk_ratelimited(KERN_WARNING
> -			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
> -			sig, current->rseq_sig, current->pid, usig);
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -/*
>    * Terminate the process if a syscall is issued within a restartable
>    * sequence.
>    */
>   void rseq_syscall(struct pt_regs *regs)
>   {
> -	unsigned long ip = instruction_pointer(regs);
>   	struct task_struct *t = current;
> -	struct rseq_cs rseq_cs;
> +	u64 csaddr;
>   
> -	if (!t->rseq)
> +	if (!t->rseq_event.has_rseq)
> +		return;
> +	if (get_user_masked_u64(&csaddr, &t->rseq->rseq_cs))
> +		goto fail;
> +	if (likely(!csaddr))
>   		return;
> -	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> -		force_sig(SIGSEGV);
> +	if (unlikely(csaddr >= TASK_SIZE))
> +		goto fail;
> +	if (rseq_debug_update_user_cs(t, regs, csaddr))
> +		return;
> +fail:
> +	force_sig(SIGSEGV);
>   }
> -
>   #endif
>   
>   /*
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

