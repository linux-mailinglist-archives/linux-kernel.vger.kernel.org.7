Return-Path: <linux-kernel+bounces-874147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21959C15A03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1423BD914
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD44346778;
	Tue, 28 Oct 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g5yt3aMQ"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7673E34676B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666462; cv=fail; b=Od+ciUF+J1PtsSFIvULBoIuaRsmoPtXh6BmHoNjSKmS84na7M5YS05iCaCkl6oCHFVGrW2bIiB/aQ/4EEt68CnEa9dhwliiAfpgPEu3ecAHUl36uSYZFPmn+HaRzjm9GS1IxxXR4XEobyDqMA06R8zFAbeits4AWKzx/fdWdlCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666462; c=relaxed/simple;
	bh=ZgdLwV4TWbaLdUHAgLAdVDcYGIezfJObXCWxpfd8q4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kikTcXVo4DvBHDtMdd3I2evgKh54F46LeARithktckaMy4EaCRoWPaOwqete0ZuCNDun9KHSBUycuQDa2IZuqR6gUMKx4qxiOoref+gPpo/tIE8Dh9hZAcPkZqPJKd4PJb/QbX6dWGdFCVENbyZZ3ApV1nyDD+D5JfpMlhagKzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g5yt3aMQ; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChbwUaZgaYfybGqrfzr/bLfsQyTDYbioMZqE3Bjop/rzAIFF55gsOWdV0xO6stOflnqdO0G10O4rliF7OAhLDafUKRFK3d6R6Wicl96xvDLZCJ3einXpOJfR9JgolaRmrMzwIrgjyw26a48+IISKo6HKiPt0FQvDFp8HPxOYcvL02810cezRYTdiKaKUf8RuY75X09HwKDHpFbTHuUjgvmANo4gbKJJPDngVjvIB/be0sBfk8QLB+bAoCdKdfgNwHTCwi4EXcVEHaHYVHTap+bsbqvkE/Ljvus9XQRUCWIJCSLWS2RRgCQEl96hdlwJFmJLqZqpm0XxN+sRVxnDZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK+eRcSl3BdLiUb7fe4VS78mzCpUsSQneNNFV5xcDQM=;
 b=WJ4enynDPJ/p/IBVozKgDXQQGSraPINOfCMoQkY20dZWHSXFHYR/A7Sj0iJpeBXdOTw7MM0LlQXash78Vpy7kLHkvcf/6J3MzuwDw+f/F3MRfhUJnZB75pB9fq7tv421HGRrH1hhQmPeES4Xp0Y6WIJZsWe7sPDh/hULLDviAltvRA7jNvAIXYfSZZquVaHpx0GHvKJ6FNWY7lMZY9lFRJEJmshkEcsgkFqBA5yeZRo+1BH3R3KyOlJE0VTv5F8re1rNaJtv7UPKqsQ1bk70/JUe4YDoiLqwNhFzkDVwxqBYS4h9K1h0m4hCBNUqfxwaOrLIuF74YRORsyaQ/gNrqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK+eRcSl3BdLiUb7fe4VS78mzCpUsSQneNNFV5xcDQM=;
 b=g5yt3aMQhFpgeakGl1unCk9M72y+Zx9p9JmP60JMzCr3YtSRHsLbKhjcd58CX2USDj5N6GFGLI0H/ImpF9f+rGK3XIL4oB0HOuEvBNsg2o3NjS8uKOdSI0tkKokACHPRVywoY6Fn+7eohRcFR6M9qRqnM3UlLT/20ykkKuHrZiprhqKT83EBqSpi0xUzE/5XFciZXYRo1MDns5DkETXPKZTSTeXipL39cVpr7a+K/D9Q9iKrRHeoZrudJmU+GaJZTI+rEKHsz1B2k05bbFUjhdhUe1B37kgAi0vhpqfwx1U0iuv5rbiVtlvh9Yjp6QYEyEhJlDAsSTzzgxuLwut4pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB10542.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:47:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 15:47:30 +0000
Message-ID: <cfeb812e-9f28-436b-a825-3fcab27a88f4@efficios.com>
Date: Tue, 28 Oct 2025 11:47:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 23/31] rseq: Provide and use rseq_set_ids()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084307.393972266@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251027084307.393972266@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB10542:EE_
X-MS-Office365-Filtering-Correlation-Id: 0990d558-38b4-4ba9-d42b-08de16394d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUpHN3RpYTdRdXUzeHVrZjFYbDNvM2JEbFIrdWRyT1hxUVN0djZnQ0tydFh6?=
 =?utf-8?B?eVNHbDREbEVBRXdlTWJWdmh5UHRmYU9uV2FFeDU5K3VPOTVTcTFHS1psdnhY?=
 =?utf-8?B?Y21TUFcvUGUreThObTVMSkdpWkhUcFd3bFVVZ0VIZGFTdGhVeWRuMnhnc1dE?=
 =?utf-8?B?NnZtUU9DdW1rM283NzRlK1RZWFUxaVZKNkdKeXoyVUFOK1pQWStIRVo5VGwy?=
 =?utf-8?B?aFZhbmNNaDVYTEdUdW90V1BCWlphNE12MnZWT3FZTzlqZHhSVlk1VDBIZWs4?=
 =?utf-8?B?SlZXd0dUYTIwYS9Ba0pNaXVsVnpIUWE0YmlVK3pXR0lMc2NkVlBtT0pieDJo?=
 =?utf-8?B?NWU2aGZLbnEyUUkrbGh2alpwKzFsN0cwTTZFVUp1QmhoZFRMME1td0Q1Y3Nx?=
 =?utf-8?B?VFVmalMwNVhpamJ2VGNpaWhFWkZsM2RXOVFhVGVDbnFwcWNTOHBEMEwrWVVB?=
 =?utf-8?B?bC96VW02QWRrRXFWWFJBMklFUDFBcGI2Q1kyNE9SNUlDWVQ4VDNKNWUrUm8y?=
 =?utf-8?B?RlVCSkN4SjJaQ1NCZmxmdVpKVHBOSWtkZjhjYkF1Sks1cjhqK3Q0VjZTMjE4?=
 =?utf-8?B?UzlKNWg1WFE1Z3FVKzVkd2Qxb2dKODB4aHhKYVUrdHptRE5RaExnbUNSa1U5?=
 =?utf-8?B?S01lcndUTHdMb0hqNndKVFRUZ0FpbXB5RjJwUDBvc21pR0Nua01mTlFkR3du?=
 =?utf-8?B?K3YveXF0NkdEa2JFUmJSTkFCY0xtTWlLbFNLN1dFV0JkdW5EaVFYdWdhc2Jw?=
 =?utf-8?B?Q0lKVzd5OENLWVNFbitaNnQ1SnVwUEEwZ01mbjVzRHVHWHd2eENWR3Y3ZTh5?=
 =?utf-8?B?b1lEc1BQZ1VSZVpuRk1ONjU2U3Q3NVZDVlg0SXhqeXVaNVBGUnljWVZOUnJ6?=
 =?utf-8?B?a2U5cmFoNzgvSWVETkszNnpXZzZmbmg5RDloZFJCcU51dXlvVHUzYXRQRHhm?=
 =?utf-8?B?RklSbUkycG84K1B6TklZUjNWOEQ0NVZWOUJ3OExvSWNaNXEvNVJPa2cwZmNM?=
 =?utf-8?B?Z3lLdHZDVDZEdVFCWi9Ja0lRSkJSeCtqK2ZhTjF2WDgyTTFNNDhqdDVwV3hs?=
 =?utf-8?B?Z3ZMbjhrQnFONTY1WWc5WEg0Z09mdW9UUkYvbk8wMDF0dEJSWEg2M3JKZnBi?=
 =?utf-8?B?N01IcXB2TkFOUGJYR3BtaEtFKzB4eWM1dE9xZ3VQTThaRzd2Qlo3ajNiRHRt?=
 =?utf-8?B?ek1YS2dPTzQ5TnVnRVcyUVpiRy84OUNWaS9ZcHdTVU5QRVVUWlFQb2NsajFi?=
 =?utf-8?B?d2dUZnRUMkpITTdMS284ZHpETmxJZzBrbEwrZlVqKzRqQ3NseDc3Y3p2L1Rw?=
 =?utf-8?B?VDNQa0hMd3F0UXloeWluRGNzc00zTkd3c092SVd5b3ZhTFZWODdVa054SDRl?=
 =?utf-8?B?ampEektnQUx1cEMzWWQyZ2c4VmtobjY0Y3BTa1J5czRsRWd3bk9yNytkT3pt?=
 =?utf-8?B?SHI5ZVJuS3AzUGtsY3RZWGVDUXdIZ3FjNjhhNldnc3ZMRXNYRmVwZHAzV1JS?=
 =?utf-8?B?TWdTY0Q0TEYvQldPblhoNHNQRTNRUkVlTDhpZG9DNDkwWTJsS0t4TXIrcjVY?=
 =?utf-8?B?QW5EMFdkRzdxUitib25EbGVVNUdJaWpodmd5VE5FaG1tVWhMR2FZeUxkOHlI?=
 =?utf-8?B?dE41cEtVQmV5NS9YSnBCMkdHcjM3Q1hsUFU0SjdiMWJBTVJCdWs0YkJPZXJm?=
 =?utf-8?B?NUd3dEQ1V0F0MjMxSkMvYjBkZjdUMm4yREtGaGpsQ2hIMWlrRkcvN2lqS0lJ?=
 =?utf-8?B?UWV2ZnMzMEFjbFB5RXA2eDUxM0VBWDdKWmJHVnV1Ujh1RCsvcDB4a1hnbk1W?=
 =?utf-8?B?UmpxbFdMVENwWVY1WmVMTEsrKytONXlMcnZzQUwrcGRCUmxMSW9kV2ZmRlhm?=
 =?utf-8?B?RHFTblAxTkFCOUFrYnRhQ2FrSGw5bUIzT2Y3eCs1YWc4ZFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjlCd0dxS24yT3BBQjgrWEF1dmppTWJIWi9lN3lOcHA4ZzJFUmtiejBMbW9M?=
 =?utf-8?B?VG5ycXYwVW80TWJKdXRvWllnUGI3T3lYZTFDVXZlNnExcGprQzJLOEE1RDZy?=
 =?utf-8?B?ajFpM2hXK1NZT21MVUNvWFNlTng3WjVxUFBhMlptM0R0bUR0dWNnbHJiRUgy?=
 =?utf-8?B?cm8rMXhDQmtNZitOSGM0dFI1cTJ6ZkxES3NKTUdpdkV5dmRNM1JtQjMwNldC?=
 =?utf-8?B?cStVWFZIZFd4TVZreXp6eWphbGVtamJDTHJNTjBRTVVwVTkrOG9YNU9mN0tt?=
 =?utf-8?B?eFY4cjV5dTlTM0NGdGRCUFMyQS9KczBmZlJ0ek5XU3ZibUxqVDJBV20yNlRt?=
 =?utf-8?B?U1RaUjQ5K3ZncFVaMnErS2ovN29Ib1BRZEhDajdQMHFIWSs2dFRrWkg5dEE1?=
 =?utf-8?B?VzR2eC9RSkk5VUsySmpJd01UV0o2aEZSei8zYVpvUTljVG56THNib0tIMzlm?=
 =?utf-8?B?Ty94d1RBellNK093NXZmOUhLQ1RoTlFodGZxV1hXSkNwUWJucGo3VkNwb2xH?=
 =?utf-8?B?UnlRdkQxVWJGYmhKK2FHdHZpbWRrQkhpbW15cWRZU0tCcjVtczBvakZDcC9u?=
 =?utf-8?B?TzRxV2hrNzlIVDY0TUFGV0NKVVVoWENoSFlIMzlWWkNXNTFVZmpvWGpwNjI5?=
 =?utf-8?B?MTZGaXphdWFhWExRakNhL3pwbW1sWjVqU0I1NFl0dTZEbkpraXJCaC8zeEl2?=
 =?utf-8?B?ajVVSUlHVGxLcytVRzYyZ1FDRnM0MHZTVzFITFcwVXZnWkNwMFpUaTExZUNn?=
 =?utf-8?B?Nk5VaVdRVGg3MnIrRTV0VjhScWdCUmIxQ1pKUUhUNmE0ZFRkUTdrUHM5YXpN?=
 =?utf-8?B?SERoU2NneXZjKzRydFpEdFNtdkcrcHVHSnUwMHlieVFJYVpwalMzUE85b2x1?=
 =?utf-8?B?eEJubXpYZGprYytPNG95bExkVElHY3lablRQaWtSY3orOWdMMjN2VCtzNjh6?=
 =?utf-8?B?NDdjUjd6K3RISWJxNnpINmFRSVVnRFovZVMrendyYWdTcVlVbUlYNWdjNG1h?=
 =?utf-8?B?THFOYWRheXpSZHdsbGY0eFlCck9QM2dISi91bGdnVkpYR0dvR3FJZzNPYmlu?=
 =?utf-8?B?VXpjTi9yU2ZCRzNLeVNEVklHVjlWOG9tbUVpZitNYzlBZUZFVHNLb3dqTEF4?=
 =?utf-8?B?bnV3bFJ4Q2IrdityN0FoUjE0M04rbUdVMjJnajFkeEdnRExCMUhDVytzbXE2?=
 =?utf-8?B?aXZ4K3hSalh5bmE1YStrT0dFOEJLbUk1QktYZ2poTVRGbzlYWVpMUG00ZjlK?=
 =?utf-8?B?ZDlocmE5WTl0YjJ3bmI3UHV4TURVSG9BRldjYWhpdDBpUXBCK1lDaFlOcVZR?=
 =?utf-8?B?ZDg4VTExWjdLTTJyVUR1YVYxVFIyTk1DWm1GT2lUQkhrTE5jTlV6cFBBS0Rx?=
 =?utf-8?B?UmJQUmt5OHpjVmE4S2RWdXVEdzA3NUViZ0tRZHlOOVVPL1A4dFpQejAxbXdy?=
 =?utf-8?B?SThHR1IrcTlqc1gvRTNhQzh5bVNzY2dIem50NnljaXF0N0RoNFpFTjF4UDR6?=
 =?utf-8?B?dWRjaGVMeURLSVBmbERGaFpCYXNkaElZbjI1Qmc1bjZtby9wbDB2NlQwS1hl?=
 =?utf-8?B?SkZjeCtZNzRtWkhuOVp6R3RmYkdVTFpGSDRHSzMzcy9vQ3oxNGxCQXlsYWYv?=
 =?utf-8?B?QVoza0xzOGlMUlVIMWZMTldMVjMybzhMY2hVU3EyNlJtOHJCT3BXeUdOVzMx?=
 =?utf-8?B?OVJNNUxlVVpUZzZxOHVPdlZBNStEMm5NczFlRlZpUHFnTHNwOGNlSDhvZ1pO?=
 =?utf-8?B?dDZhejZBdkM1UmozZkptQnhGRnVBeEYxY0RMaFVnSHI4MlhXWUlCcThVcE9S?=
 =?utf-8?B?UEppUXpnT0pvNFZ5em0wWWlqeU9pZEN0Q0x0MkU2d2tnQkRnbXBFcVNlSy9M?=
 =?utf-8?B?YnNQZmZFL2hRQzJLYUF3ZmtMczlaaWhYUUd3S0c5SDRRVnV0T24yZnlRUm9x?=
 =?utf-8?B?SHVveDQreHJOb0J1a2haQXNIYXB2U1JyYXMzMi9WdXd6ZjVmT0tNcHdjUWxw?=
 =?utf-8?B?ejYrYkcvYkJjNGtVL0V1bW9BYkloZElIUmxTbzNsQ2NJbHZ1YVBCNjFKbkRE?=
 =?utf-8?B?dUt4azNkY3N6ODVJUHRHaWJPdFRHZWVLLy9QSTBlbnRQK1pOMUpDd3UrOUMv?=
 =?utf-8?B?dEFzd2FJNXUyVDBxWWxCbUd3T2lCUFB0TnJTWDBicG5nZ0hsZnQ5SzVCa0NT?=
 =?utf-8?Q?LZh0hDPh3VkPEN6ImtnrvSE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0990d558-38b4-4ba9-d42b-08de16394d39
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:47:29.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcOHNii34VN14dlLXGhF4gE7xzQ6qtTWVoHISPRdMhWqZ8mJqu10LbRz5acDbBPm7d7SpcPYAtp+/rI4Kk3rMKK4VqO7gwf0rnMSd48Izs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10542

On 2025-10-27 04:45, Thomas Gleixner wrote:
[...]
> +		unsafe_put_user(0UL, &rseq->rseq_cs, efault);
> +		unsafe_put_user(0UL, &rseq->rseq_cs, efault);

Wow! You really want to make sure it's zeroed. ;-)

Other than this:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

