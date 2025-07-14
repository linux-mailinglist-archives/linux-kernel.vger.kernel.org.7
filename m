Return-Path: <linux-kernel+bounces-730678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6E4B04803
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F0D16AAF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760722AE5D;
	Mon, 14 Jul 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WZONtNCb"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2130.outbound.protection.outlook.com [40.107.115.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5031662E7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752522074; cv=fail; b=G118w69ph61MT29UdTx4g7waUZHnMiUpyF0G8cnTqmVwMdsCxV05tnbsC7HFvVFVBHAMYSVZQYU92fUPMgA62+dXymEpUu3xW8ColWnRZQX+/FAWVh3o86MTBRctP4TQt02QskLqNElYLE1Ah5j3dW3jIl14GvPw+/w+JDZtjjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752522074; c=relaxed/simple;
	bh=qI6uUzxdf3vBy9zO8Aeb2uGZKtvqg4nvF8ZUVf3j94k=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=i8sGH0FOHLlHlIKAiXByUMOJNOVRicX9fMv9Q6TMm3PzEQdfNLKbOATDBzks2t+mERhouZcT/+QnYH7jryBFd8DtTBlbTlb82/y1sGrqk6B6Ikm99CXgzxCbnpLDWEh4Kinw56KfYWezNM3AACPIIIdCjIZLtwdFJqYt7IHCFA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WZONtNCb; arc=fail smtp.client-ip=40.107.115.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlX3FcF8Qpqldeny674Pw9pZaK8ii3EhSPNjVnC6egLSPN2v/qW1Yhf82f1i1qf8hNWL8WFkU55X+hPqUBfSJ0skxHyd/IBSNdSl5b+8NYShFeDe1K5mpJKB+HBPoIGcvbTS5ypOAijoa+l7qYre1XlbOoQf58ppgAqh8GRzpYQMsbtU1tf8S/JN5X+uQpwUMhc25wYwbuouOFLaILk/8jXtLsI5qKvWGiU6v658TM7p/PjrUSkiw9jGgd76yI/6aY8BULfGzWekGxLk8lpIPlO9pX70pucphF+SNzn1o8z7lG527xy+RuMicenId5r/9VcSlyQUX+SnyM5za3R4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKDHuIRnUCxcEvQj6hkJgcyOW/ZnWqcon5CorkFnu1c=;
 b=Wds9pO8AOKpkb6yU3j/Ax/BuC3g4CKkxnLiLrGhzch0KBU/qrm1pqarjFZiBvbVVoj5CSWwzMOe4oIf1q78UvBuYFpO7YHYpJPAdSX96oEW5DuSwmJ3bu6iHphKHBaDwpkcG7mTNdMzacLDZalQ1fyocqs/UqkEZ2jsr5c6oNZ7GI4oskTYrjqWDY1v1M+RsOb5AOumvptBVRZmwIZ9/Ulrhhk/3O8XzWUjhF/SimuzKDl/rCKOtPp2seCxZhCc6KsM9PbXkEdFAoj003xpCA19NyZjvzNEfdgE6ikV1ukGWMguzyvaZP/F7/aHGwrqysdq9kaCg0yl9sK7NxqMISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKDHuIRnUCxcEvQj6hkJgcyOW/ZnWqcon5CorkFnu1c=;
 b=WZONtNCbuDcOlcqwbXLK67BhxFcZklAaZTRo/mpzvd5XaIoEd740fLk59a/LqwtMfwZgo957hvxmivNsQYfVurYS+oB7PoYliv/GhEJC3ZeAoIdJHXoA10xcsIqJWvzOv3TjiK9GgAAWo8sxt1dypLh988d5zhOvWhBh4zDouPI6QbtI5AqXfmn2fPdA+gxuRVYA4s7FyhFe4yaXpTpBfnlU7vBoFqz0Es9QlcliV2+FA73lmHd/GbqAJ5yJp+Mjs8/NaUL5EsLI/68Ys+FFlJeKTdxiDWziM9WNGkNP/wrS376TEN0q5L8shGC6u76WuHs4QOfj/cdG8mvKaeqEGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5241.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 19:41:03 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 19:41:03 +0000
Message-ID: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
Date: Mon, 14 Jul 2025 15:41:02 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] LTTng upstreaming next steps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::42) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdd89f1-ce8e-46cd-1746-08ddc30e5e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnlwOUhPVWJscW8xNzlnei94UEx1djlpUDlWcytzNk9ZRjladE1pbGllSjRk?=
 =?utf-8?B?RnQyOWszTFhWYzNMckhNcEIyeFk5cHZPV1NLdXdvbmFGVUx1d1JFYWNtdStM?=
 =?utf-8?B?T0lIdDFRRDdoZjVPeW1HTzZhaHVQVkNJS25FVXh5bUZRdmFzRSsxOVpOMXRL?=
 =?utf-8?B?a0RVWXNTanNDNld2YVhyQXhJNTR6ZmdyT0dzL1RFZGsvclp0M002VkJJTVJ3?=
 =?utf-8?B?NGZXNjJ1NVVPYzNOT3pFc2xSYkNSVURsK2Fnc2czKzQxZjA1QjFaTjlZM3da?=
 =?utf-8?B?VU9mRzVEd1l3M2xidlVhN1FJMVlMYVhKZDhNZGVrdGh2TGFTdGNNUEYvVjVz?=
 =?utf-8?B?b2pvS2ZudDBnZEZBOUVRNW90ODRrc3hnTVlvVEdiV3pRUWtCOGI2T05wQjhn?=
 =?utf-8?B?YjdNdjhJZkNoQ0NMbGtuRnF3WGsxOFYreHVDWkZ1QXIwQlk2cllLREI0akgz?=
 =?utf-8?B?Z0xmM2twVXhHVUVYbW0yWHZLcW9yNXR1VFF6djJteFhZeGZITXlQQS9iTWF5?=
 =?utf-8?B?ampnanZ5S0VoSmovV3orUXpITkRVZ2VHRW9jSWJlQVVMSTV2UmVCSlNUNkJ6?=
 =?utf-8?B?bGxYcUFOa3BnUStDZjF4T2tOWFVtVlNiVkdIbHBpc0FYdnN0ZDc1N1VBNWdk?=
 =?utf-8?B?bWJVemE5QlFob0ZiUXhuSkhFVGhhMXN4ZjF3M2t0YVZ2azFyZDlwRWxzdmpE?=
 =?utf-8?B?WWRSS0pjSzF5OUM1NUlENHRsV2VNMEVPQVRRM0phQTRiOVRlRWVXYUpmckZ0?=
 =?utf-8?B?RVduZlJtbzBnTnZPNVJMN0R5OUJHajJnY2gvbGY1U21XMzZqaWNTdlE2Wm00?=
 =?utf-8?B?d1NjeUxHQ1dQbFc1enpwYkZqWmY3cWZQNkVHSEF3QmlxenEvVWZLMDNvSFdl?=
 =?utf-8?B?QzQ2aU1XRCtDeGIzWVUwcXlIVDhRWWh2ZDgzQURHYVRqblIySG4vZWpOTStz?=
 =?utf-8?B?ckV3eDgyQzh2WG9wT2hLTHA4VDIreXp3cUw5b1ZLd2haU1Bhb0ZacGtLcGdK?=
 =?utf-8?B?RmxSRGtWNEduN1duUzVwWjF1SFZTSGdySVdXaHl4OG9aM28zamt3TFNYY2Ex?=
 =?utf-8?B?T0NVamkwelBQNnFXMkFOaTgyL1ZZUCtjaFFRaDZnVUxxTktXSTNUQU9YVldT?=
 =?utf-8?B?MWgvUFQ2YUhTWHMrU1lodzRIQzNGNVVzZGhEbXN3US8xSTdoczRUYldnUGNT?=
 =?utf-8?B?Z3UwbVNLNXE3T20wOFo3aEpjalRZQTEzTlcralc5VFRzTGl5a0UrWXRKWmkv?=
 =?utf-8?B?VUhLaDdKWDkrYWUrTXBxbzM1QnUyS3FRajd1UUNFcFlvNy8renFUendZTEZV?=
 =?utf-8?B?RXB4TnVRNXgvbEJCamdDRVJINVJWRmY4OEtPT2Q5VTM0NEdSK2NRS0tmUnVE?=
 =?utf-8?B?a1lneCtFZjhwS0ZFTmNIc0dQcVIzRkh0YzFZdEJwYUtQaUlwckEweTBWOU52?=
 =?utf-8?B?U0IwdWlDS2ZSSEx0MU9tR1drbEc5VU41QnJwdkJGVTg0cGxpc1VQQ3BaN0hn?=
 =?utf-8?B?bVloQkJpT3ZPb3AvSllTaEdpS29Pb241eW5TdE9BaFlUSDhUdWQxRUlJNXdl?=
 =?utf-8?B?cnNndHpuZk9jc1lDRDhJTmI2UzBJSkI0TDlWWU5mdjNHQ3U1MnRYdmVxb21Q?=
 =?utf-8?B?ZkdzeUhCR0NSdTRSK25FeExaNEh6Q1VFOXQzeUFxQ1FpRGFHeHdlREc0ZVZy?=
 =?utf-8?B?aXZyaTZIY05YU2x3T2RPeDZQZmZzY2UwZlEvc3JGK3N6QW5KNXFaUDdqTlBG?=
 =?utf-8?B?U3l5WWRod1dESzVKRnd6NnkyNEsrcmtDVVF6RmREMnhWTkgzR25ZejBGRUkx?=
 =?utf-8?Q?KlU+eemtXliS4fMTfoTdxAic2TDdHz9FhffQE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZUZTJieHJ2K1hZOS8zbDhrWkVCK2JqWFFVTUNmVGlRR0lvWVAwNlhHdmRy?=
 =?utf-8?B?dHpxYTVIbWZZbWNRZ1l6ZFI2VW1mcWZWYmJHLzVNZTIrd1hZQW55UC9vQU9K?=
 =?utf-8?B?b0h6Sm5kanRvcVhRN2V2SEE5S200R2ZUeW5kbk96NTBsY2RoWDBTSjJjaXpu?=
 =?utf-8?B?VzlvQWpMdmZpVElqRjJaajJrVDRzL1JOckMwdmxyOFlkVDQ3OTlPWWRrM3BO?=
 =?utf-8?B?My9zR1lNK0F5ZElHTmo1Vng5UlVQbTVGbytrZzBkMTk0Q2NFdVNOOEliNFZC?=
 =?utf-8?B?eWhzcUh0MUtGVjNTVDl2MVpxOXUwT0NodGpUejZqQ0RYUkIvTFNRb0hYRmhC?=
 =?utf-8?B?N05YSHlpdjJVanZiSTVreGR0dnJWNUNKZGM0dWtoZS9UTjYxd0FhZ3RRN25n?=
 =?utf-8?B?RkhYckQ3T3R0WHU3ajhIZW1ydHdPRkpOQWt4K0Ezak1hOWJMUGtCZlZFcldQ?=
 =?utf-8?B?YTBYY0xsZWQ5WVptY2FTL29zSU96UjFndmltN2RlNnF4WGp0eFMvZXhxRXRR?=
 =?utf-8?B?K3YxVnFydnBvMDVRSkJ5YnpYenM1cy9XSklKM3R4Z1VhRGRzVnhyOGUyV1gx?=
 =?utf-8?B?aHMwc25yaFM0V1lsdC8rdWtmeW1XWUFoVVJoVWZxb3k5eDBPZGY2bFpnaERx?=
 =?utf-8?B?MXJEQzF3aUFUbnNxN2VZRlV1cU1DR1kwM25qaFJuME9QRkJJakdoV0I4cEdl?=
 =?utf-8?B?SDN2R3MrMnZ0QzV4L2dXcFdDRmNhb0xqRk5IM2gxZnlwbFZab3NmNkFKbGxy?=
 =?utf-8?B?bXVnSzVwNUlqTTlmVHhRbnUrZ2tkQ0lDeTFmZVJNakNOdklWaU1OT0ZUeVVq?=
 =?utf-8?B?M0JQQy9IUCtwV0tlZEpMS1ptR2dzUklGVnZjZGhBejBuTU11QmhELzdTNG1D?=
 =?utf-8?B?WlprSUxSeHd0SWZuSU9ObC80WE5ERHNqWll0dlcxTUl5enZCVEFFYzNzbWNi?=
 =?utf-8?B?OFRIRXFVT1VCdDczYU1Xb0hiTk8zRmcvcFVRVE9rSmZYa2VSb0NvS2dxUUl3?=
 =?utf-8?B?Q01EczBIbnJ2SG13Nkg2SGVxbnNDREhWUXpFTjNnTXU2YjBlQXRLeStwL2Nj?=
 =?utf-8?B?WG02eGpqeTl1S0k0enZzaGMrelloM1Y2cEFYUkd4UTdxaTd0R3NBaHY1TDhX?=
 =?utf-8?B?cC9uZXAzazhhZFlQNUxWdUI1S2xyNlVQK0c3VWc2U29kQW5GemRNNFR2dkJi?=
 =?utf-8?B?bmU5Y0plb0szWUdpeVAybEpRQzBzV1hJSUVXWG05eEZjclhweVpMbGVnS0Fo?=
 =?utf-8?B?TEV1S1hGRzBUbzdvQ0R4Q2p6aVVXY2VtcUJvaFJmMzhNVmVZNE1xT1l5bjFJ?=
 =?utf-8?B?SmJGbENqaDhUVURvWkdUNThic1ZXYzBmYWpBZWQyNjhwK2s2QXpjNGZnWWI2?=
 =?utf-8?B?TXJRakhhMk5nVVJ2SVNJOWdOZ2Vhc3RJRkJVcUJ3NmZqSkw3N3ZSZTB2SmJi?=
 =?utf-8?B?MWNnT0dmb0NaT2JUSTNPS0lqd3B4eURyK3hIZ1hadmFVczlXT2hnOWczNHVk?=
 =?utf-8?B?UjJxaHhwVUJhTHVHWFB3TXo3c1BJQmVHclFMemNKTXpWWElIa3VjNUZ2UUlu?=
 =?utf-8?B?WmtJT0E5Q0dCalVieU1rMHBZamxqQ2V5VjFRYzNMREx6V1c3NjNpaS90dVdr?=
 =?utf-8?B?STA4SHRxZCt3NW12aTlJdjRRZWhsaHlJdUdzbzVIcjBhYUlOek5iUTFpMWZk?=
 =?utf-8?B?VHhPbVg5cWh3Rm9RaGhRd0JYYVgwdkd0eTJkUG5ObWN1RmZZTDdaZzFGK2N1?=
 =?utf-8?B?NVBtRzBjL3NGekQ0NFpma3RlYm40dG9sbnB4NnFla2xBM0hUQUpsTTNWL29F?=
 =?utf-8?B?TlZxc1FybTFHZW10VUgzOURtdCtEaWdyczVxRloxaFNJRFlQKzZhTWdnZm1k?=
 =?utf-8?B?SUY4azFpem4vSWhVYW05alZQRDE0RVpGbTVPSTdGb1grS05JY3plQmxxTlB3?=
 =?utf-8?B?dXlkNnR2bGl4SGEyellseVV0eDZ4UUtTU1E1NG5KTUNySnNNTkNua0h5Y1FT?=
 =?utf-8?B?NHBKZzR2cWVxTmFiT0ZNaW1lTDhkenFRUHVpaUkzMjZKNTJFMjRGWDdqS0Fv?=
 =?utf-8?B?Z0xFTnFNVmF0Q25KTlhLcUNGd1p0eksxY0JRcVVtOGpEczJyZDgrWDUzUU1F?=
 =?utf-8?B?Z29BcGFmK1IvVnZyN2szYjZacHpPYjlMU2kzcjFHODJicmNTTGhWUUhiTWVJ?=
 =?utf-8?Q?6+OFvXRa7F0QVO9oasmHPkc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdd89f1-ce8e-46cd-1746-08ddc30e5e57
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:41:03.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqlfAcNG88v5ZR/W+IYcH4FdsEn2M2aH681ht2mzIaw12wO410WbZB9vhiWRp989VmBhBumgrlwSJeKSQ/YjJD22+3d/rKqZD5kOvC7a3d0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5241

Hi,

It was suggested that the LTTng kernel tracer be upstreamed and become
its own kernel subsystem in a recent LKML discussion [1]. This would
allow this 20 years old project to move its development from kernel
modules within an out-of-tree git repository into the Linux kernel tree.

The LTTng kernel tracer repository can be found here:

   https://git.lttng.org/lttng-modules.git

Considering that the most recent attempts to upstream it were not
successful due to the size of this project (~75k LOC) and lack of time
from tracing maintainers to review it, I'm sending this RFC to ask what
is the best way forward.

The LTTng project has been maintained for 20 years, being a kernel patch
series from 2005 to 2010, and an out-of-tree kernel module from 2010
until now.

Over those 20 years, we have tried to be good citizens by actively
contributing to Linux kernel within the following area:

- Tracepoints,
- Restartable Sequences (rseq) system call,
- Membarrier system call,
- RCU review,
- Tracing review,

LTTng is available in most Linux distributions [2]. We have also
contributed to help the tracing users and developers meet and discuss by
organizing 14 Tracing Summit events over the last 17 years [3]. For the
past two years, we have hosted monthly HPC tracing collaboration
meetings with the HPC community.

Past LTTng upstreaming attempts
===============================

Please keep in mind that this is only my personal recollection of the
LTTng upstreaming attempts.

- 2005 to 2010:
   - Several attempts at upstreaming LTTng 0.x were made between 2005 and
     2010. The original LTTng was a patch series, and it predates both
     ftrace and perf.
     In 2007 and 2008, I contributed the Kernel Markers and then the
     Tracepoint instrumentation APIs to the Linux kernel, so make static
     instrumentation available to all tracers. Ftrace and perf were quick
     to adopt it, then making it harder for LTTng to justify its
     integration upstream.
   - What made Tracepoint accepted by kernel maintainers was the ongoing
     work on asm goto (used for jump labels). I have been actively
     involved in its genesis through redaction of a desiderata document
     and various discussions with both kernel and compiler people. This
     led to the existence of asm goto in gcc.

- 2010:
   - The upstreaming plan was presented at the Collaboration Summit 2010,
     discussed with the community.
     - https://www.efficios.com/pub/lfcs2010/desnoyers-presentation-lfcs2010.pdf
   - I attempted to modify TRACE_EVENT macros to suit the needs of LTTng.
     My changes rejected because not immediately useful to in-kernel tracers.
   - After this first failure, I moved the focus on libringbuffer:
     - libringbuffer was discussed and planned with the community before
        beginning the effort, initially aimed at replacing ftrace ring buffer,
        creating a common ring buffer infrastructure for high-troughput tracers
        (ftrace and lttng). It was rejected upon submission upstream by the
        perf maintainers, moving the goal post to cover perf as well, which
        is significantly different because it focuses on sampling use-cases.
   - After those two unsuccessful attempts at upstreaming and running out
     of funding to work on kernel upstreaming, the focus of the
     lttng-modules project changed and aimed to become a standalone OOT
     kernel module. It was officially announced 2 years later:
     https://events.static.linuxfound.org/images/stories/pdf/eeus2012_desnoyers.pdf

- 2012:
   - I attempted to merge LTTng through the staging tree. Ingo Molnar
     opposed wanting LTTng to be integrated into Perf instead.
     https://lore.kernel.org/lkml/20111219104915.GA19861@elte.hu/
   - I just did not have the available resources to undertake the
     endeavor proposed by Ingo, which was to rebuild LTTng within
     ftrace and perf to make its code base common with tools which have
     only a partial requirement overlap.

- 2020:
   - Steven Rostedt showed interest in helping me upstream LTTng.
     After discussion with him, I prepared a "v5.7-rc1-lttng-upstreaming"
     branch. The initial plan was that he would provide a few rounds of
     feedback privately before I would publish it publically.
     He never had time to review it and provide feedback, only mentioned
     that it was more code than he initially expected. This effort did
     not lead anywhere.
     https://github.com/compudj/linux-dev/tree/v5.7-rc1-lttng-upstreaming

Open questions on how to proceed with upstreaming
=================================================

My goal is to move the development of the "lttng-modules" project into
the upstream kernel.

There are a few possible approaches we can envision, just to list a few
choices we have:

A) Bulk upstreaming

    Upsides:
    - The upstreamed LTTng kernel tracer becomes a drop-in replacement
      for the lttng-modules project. Allows to quickly phase out the OOT
      development model.
    - Preserves the existing LTTng-modules userspace ABI.
    - This moves the status-quo from "out of tree" to "in tree".

    Downsides:
    - Not developed from the ground up with the help of the kernel
      community. This rather becomes an after-the-fact review of a large
      code base.
    - Brings in backward compatibility macros and ifdefs to support
      older kernels which are pointless upstream. This can be easily
      mitigated by doing a clean up removing this compatibility code
      as part of the upstreaming exercise.

B) Piecewise upstreaming, basically creating a "new" LTTng kernel tracer
    by reimplementing the current tracer differently based on feedback.

    Upsides:
    - Allows the kernel community to be involved in the
      "re-implementation" of LTTng within the kernel tree.

    Downsides:
    - Large commitment. Not sure if funding this effort is feasible.
    - Uncertainty about the result: after all this effort, there is no
      guarantee that any upstream maintainer will be able to justify the
      time needed for review.
    - Requires to still maintain lttng-modules OOT for the forseeable
      future, as the upstream work is not a drop-in replacement ABI-wise.
    - This preserves the status-quo of LTTng-modules as "out of tree".

C) If we go for the bulk upstreaming, we can either:

   - Try to keep the development history of LTTng-modules. This may be
     tricky because the lttng-modules git tree is separate from the Linux
     kernel. AFAIR this has been done in the past when integrating Btrfs
     into the kernel tree:
       commit 4b48d9d44ebe ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-unstable")

   - Import LTTng-modules as a set of new kernel commits, e.g. one commit
     grouping a set of files which implement a given facet of the tracer.

D) Should we integrate LTTng through the staging tree ?

    LTTng could end up into kernel/lttng/, or could go through the staging
    tree while we remove the code which is not relevant in the context of
    the upstream kernel (e.g. older kernel support).

E) Keep existing ioctl ABIs or move to new set of ABIs ?

    If we choose to go for a piecewise approach where we want to redefine
    the userspace ABIs, we would have to use new ioctl numbers to make
    sure we do not break the existing LTTng-modules ABI guarantees.

F) Integrate the LTTng-modules "core", initially leaving the tracepoint
    and system call instrumentation out-of-tree.

    Considering that the LTTng-modules instrumentation code for
    tracepoints and system calls represents a significant portion of
    the SLOC, we could keep those out of the initial upstreaming and
    focus on the LTTng core first.

LTTng Kernel Tracer Overview
============================

SLOC    path
----------------------------------------
11231   include/instrumentation/events
25667   include/instrumentation/syscalls

5090    include/lttng
1767    include/ringbuffer
1246    include/wrapper
396     include/counter
11      include/blacklist

23334   src/*.[ch]
4645    src/lib
865     src/probes
273     src/wrapper
207     src/tests

The largest piece of code is include/instrumentation/syscalls
(25667 SLOC), which contains the generated instrumentation code for system
calls which allow fetching the system call ABI fields from userspace for
the following architectures: arm 32/64, mips 32/64, powerpc 32/64, x86
32/64.

Those are included from src/lttng-syscalls* (1687 SLOC) to generate the
syscall tables for instrumentation.

A large chunk is also the tracepoint instrumentation
include/instrumentation/events (11231 SLOC), which reimplements a
portion of the upstream kernel include/trace/events in ways that are
compatible with LTTng filtering. Those are included from "probe" files
in src/probes/* to generate probe modules (865 SLOC).  Note that a large
portion of those instrumentation headers consists of backward
compatibility for older kernels with kernel version #ifdefs, and very
fortunately be removed as part of the upstreaming process.

The "wrapper" include subdir is mostly for backward compatibility with
the supported older kernels, which can go away as a cleanup as part of
the upstreaming benefits.

The LTTng ring buffer sits in include/ringbuffer and src/lib/ringbuffer,
for a total of 3589 SLOC. This is a generic ring buffer which was
originally created to cover LTTng-UST, LTTng modules and Ftrace. The
LTTng ring buffer "clients" (templated C) wiring up the ring buffer
library for LTTng can be found in src/lttng-ring-buffer-* (1455 SLOC).

The other significant portion is src/*.[ch], which contains the ABI that
exposes LTTng-modules to userspace:

lttng-abi.c (4190 SLOC) implements the userspace ABI (LTTng ioctls).

Note that the other relevant portion of the ABI is in the ringbuffer
code:

src/lib/ringbuffer/ring_buffer_vfs.c (381 SLOC)

All the src/lttng-context*.c implement the LTTng contexts, stuff like
pid, uid, perf counters, which can be optionally enabled by users.
(2947 SLOC)

The LTTng dynamic filter is implemented under src/lttng-bytecode*
(5028 SLOC).

The LTTng support for CTF 1.8 and CTF 2 is implemented under
src/metadata-ctf* (2082 SLOC).

We also have src/lttng-events.c (3742 SLOC) which handles all the
session/channel/event object model of LTTng.

Also relevant is src/lttng-statedump-impl.c (601 SLOC) which implement
the LTTng state dump, dumping kernel state at trace start and when
requested by the end user (e.g. list processes, interrupts, FDs,
namespaces, network interfaces, cpu topology), block devices.

Note that src/tests (207 SLOC) is fairly small. Our testing is mostly
done from the lttng-tools project [4].

Your feedback would be most appreciated,

Thanks,

Mathieu

[1] https://lore.kernel.org/lkml/20250711142834.73b2864c@batman.local.home/
[2] https://lttng.org/download/
[3] https://tracingsummit.org/
[4] https://ci.lttng.org/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


