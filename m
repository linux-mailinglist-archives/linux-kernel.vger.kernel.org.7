Return-Path: <linux-kernel+bounces-785424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 132AFB34A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E1027B3BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201163054EB;
	Mon, 25 Aug 2025 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BUlTpSIL"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2104.outbound.protection.outlook.com [40.107.116.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550319D071
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146984; cv=fail; b=f1MCq3WdyTfE9/lHKE2rtrQtivuxyu2lG4jAwK/g6XkeTeAUNT1P8ODQPRxAxPkexCDM52MTlYi7l7PDXmkS+yNyAwZS6vElxwLZco6Es/EWVKAlo9XTIQzG541WbHc8jej8qp8SR33/tW3tfcTou9JKYukM6BqcWnAEp7+upO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146984; c=relaxed/simple;
	bh=9F3zzW+/QODSuvm3hFKq9GiUYayC0/LXetddOjO1Yg0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6j5Jbu4sF/OgP9K+2ZQiRRVMiVnXizCwRAQo74XEzHtRSEfR69ppEXqzzBF0IAy2MzgEyF5Ca5jFIWHG/xQQBkiGEC4drEn4gucbfAdlPGQc3HfCE3dtkH7x9US57Mz23Whl8uLp6jNfIm12CodhOoEGK8AECmEvQnDO5DfeeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BUlTpSIL; arc=fail smtp.client-ip=40.107.116.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsUl5N8FQuzUz+adpNy2jyvq8AZUIKxBB9S2p2uklEflFJMicNkFxtKhwGrVpVzaEN+J2JEfGQOD+j4V4Spp8XHaLi57uVrP6ypCHFB0ewU59JwG1JPNkv3Xvmj0NXcUrbfPLWwVj9gtQ1xrHv6Z8QU7Ff/qSFvmlNTiUDVcUahkJOOs7ZYOnSnYYY7u9XBvLQRdWV8lbk8PoQpgIxtNKR2/PMFz2X0E5rCn48djaGyQWmYptVXH1NV97EOWtg7ysiqX8xQc+7WqlZGAmWVVJ4HLSvX1CI+GaWk0YDbB6ySLbKvxVCwc5eJV7SmbNZ1lkp91XRwB9hz6yvCL6io0rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MML4aJelrkrrzcxufiS+MQMQPMVR8NXFHZASVOnxgow=;
 b=ny4yqweJUnAjBECOluicPmc9h5vJ0LNvcGGyx72UUcnr4zXgWRWwD5wuZI3PDvr3FNiWZJYONhBqFCl4iudwX+9gb8ePpflm3tf2NTwYpMGhPKWrJ8NH7l5kKEKP9QLQ9WqCJ1hMSins2egTe7TDgye6yUV0KT7cf6jVea2hxF+JKolDooIrAxnmq9ZdsJSg9FL4gamgvy0eTGwnHRxx4RUHDVxKtB6h0gz99/I0ujUhJAbUA4EsecE1ZxF8mbdP9dbh+5S7zuGPj4WbaHtA81m2k5cnQP4tZuPlZw8ryIw5xQ1RpthBA3gxCAWhCCl8TfGKUP40Oe1a1pYjCsdvhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MML4aJelrkrrzcxufiS+MQMQPMVR8NXFHZASVOnxgow=;
 b=BUlTpSILBBxo6e/OoweZW7CYbA5PPyTtj9J51pfj8gYAg4qyPZ3dOqCLT2oULJOs4BJTThF3ZBJG6QIYGWQYQcmmc3o6jxsBLV3Pp/Qu49rN3H6td4XB0IHGSuWADJ6evAKW11Lo5X+aHM6RJ8Gyc3UEEQIH4jx4t1vovA5ZsRNikRA7T6hsvzKuDhxIif8uOmFQB95B+anAIFnLhLI+Zk9ByppkDOMFD7xCDidLz25kFsOrrWUrTHXrS9PnE9XqWXEzGo3Vwu9+p7BZ9pnlXSCrPILf96Z9qxZvOumzUHCBMNKkSIj109MX3nSwC013OvG+cDFpJsGjNtGBXFUOGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9478.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 18:36:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:36:20 +0000
Message-ID: <9df7c462-f77e-4d48-a220-aa9486f4e53c@efficios.com>
Date: Mon, 25 Aug 2025 14:36:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 18/37] rseq: Provide static branch for runtime
 debugging
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
 <20250823161654.421576400@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.421576400@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ae5bb8-8896-453b-a6c5-08dde40648e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajhiKythQjV5Y1ZkSUZlUXNMT1JrT3E1eisxM2x1Nnd3YnZJOSttek50b1Jm?=
 =?utf-8?B?bFQzUCtSRnBpcFg3THVHV0d4aFpmZXMzWGxJL2F1Q1hNbFEzTDhYRHJud3dz?=
 =?utf-8?B?a0FpTHFUWG93ckdMU2F3cGc5T3FtQTdwMFdNRmZNbmxoL0ZWQ0xvd0cyemJO?=
 =?utf-8?B?MzBSTTRYbnF3b2g4cTdKT0wzTFozZENPVjhsN2dwS3RxMEFmNlM2bFJONU9z?=
 =?utf-8?B?emg5TTIzN2NZdE92OTZXTXRuc1pRUXhxL0J2VmNIZmlYNTVRNDc3QUFUUkM3?=
 =?utf-8?B?TnRQWXl5QzF1M2NZNzh4YXRkdkxGNWxBUUx4QTBldlhuODF6TCtuaDVWbzZt?=
 =?utf-8?B?akMvUm42YW9JanQ4djQ3TjJGaUFKVDdLZW9LdjcxS29HR1FNK0lGRUtDZzBq?=
 =?utf-8?B?eWxnOGxYMDVGR0tTTEZ6WmVrd25Ub0pXYmhKTGkxL01IcjRrdmhlWEFlbzh4?=
 =?utf-8?B?R3FLYU9OYjBZM1haQkZVUXRhSUo4SmllUzBQYzlMUUphK2tBeENLVTE5cElz?=
 =?utf-8?B?NnBzeFJrcmZIMXNvQnRURlQ5b3I3L3BRMTlhQXlrMlhQUlVzUFBCNEgydEZI?=
 =?utf-8?B?M0kyQnM0by8veHpKbmx3Z05PZ1BjN3VwVXBhMUYxekFTd1lMNHRINkxlc2lH?=
 =?utf-8?B?ZFIyVVJ0NzA5UTkvRmhzVHpscXhXODd5K3dLSTF3Z2MvakhmY2MrdnFiYkNF?=
 =?utf-8?B?TWRnclgxY3hnR0daU1NQQ0VJN1k2NXFYNlBJZ1dZNlF1dE5rQW52RmpvSlo0?=
 =?utf-8?B?MWF3Yi93RFRoVUdtUzg1bEYwOUJNSWZaTnhKanZ1OStET0FEWjNVaEJwOUdt?=
 =?utf-8?B?Rk11K3NiSlMvYWxLenFTWDd2MnYwL0g1Zko4UkpLZkdwWENMcnEzVkpmY1NI?=
 =?utf-8?B?RWgwY21GL3dTNU0zdWRWM1BhcHVkNFBpV09jV1E0bTQvekhFaHB3ZllRZkdR?=
 =?utf-8?B?ejJIRkQzZ29ncCtxMDBrQ0hJZmUyYUpBcG1BRGU4RFUzWXJ6OGlFbGlSWFo2?=
 =?utf-8?B?bmFxSTZSOXJNN1BMMHBWeUVaL01PUkgzdEd3d1VJdzNuTWZkUEVRNzllZTk0?=
 =?utf-8?B?ZWFsWE12QjdHb24yZVRFVUIvUVBhMHhkQWJ2UzBMdi92TmFZZStMN1E0UkMw?=
 =?utf-8?B?elRDblhmU3JUTHNmOHVUTmJaWGRXcWpxVHgxZmlkVVZBSGpRVjhIdk1pZSt2?=
 =?utf-8?B?VG5NWmtXZkVWMlNhT0Y4MjZmaExaSnFYWm40UzkyTU9kZEx4TlF0WnFBUmJU?=
 =?utf-8?B?SXJqdHNUQzY5SjV0UHIwdG9vR3lyWllhQ3R5Zlpvd3hGZmNGVm9mK1p6SkFk?=
 =?utf-8?B?K1NBTVpYSkZlOWVTTmxOMkRvYVVWMEhzSHVaQnExWjhRckNMOE1SQ0kxQ2hB?=
 =?utf-8?B?T2orRHlpKzN0cDErbE1QR0oxeGdOSldHeUFGdmx5amJDaUt3NUxvM25ZNGl2?=
 =?utf-8?B?QllSZXlzU2Y1ZUhmbWZQWEJqVkpYaHNiM1JTUzJKdE9CRERYY253dVNzN0Ry?=
 =?utf-8?B?VFZ0WE41Vm1KczlNeXZKT3pUN2t1SFAvMDIyK2xtY1cveVBoZWJpcWZ1c00y?=
 =?utf-8?B?dUw3RDZTb0V5QWJSRUxrR3hWUTVJSnVIV1ZHcVZndG96Z2YzUStlOE56ZkJG?=
 =?utf-8?B?UXY1MmhpdTdXYXpyblZodWt0Tzl6MXNKN2NoalFmdWw4YW5uWWRmZ0lOM3k1?=
 =?utf-8?B?TVB4V1N4QjV4cjY1SnpyeXFoN2w0VUlYbUFNYkw4V2wyOVRSMzBoWkxERndz?=
 =?utf-8?B?WklnQWN4a1J0N3NPNEx3Nm43bnN3VG0yUzRycVdWK1dhMVN4MWgxY0dCZUJX?=
 =?utf-8?Q?z5GJaHO73Y3chkDfq2lyrTP8tcz5F//sxa6MQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTNnU0Z5QitFMVpJZHllR3UvM1lTQWViYlk1RVBFY0hYZ3ZHZzhSMmM1L2dZ?=
 =?utf-8?B?MDFFUE5PNGQ2KzgvcVlCZHVQNUVEdlhyN1dpOGlyTTZ4SWE0ZDVVUkU4WEYx?=
 =?utf-8?B?N1hOVTRnd3ZQbmFQSTZmbUJpVGpacWVhdWdYb2Q0KzRHRklUYXZPT2pUR0k2?=
 =?utf-8?B?Q2J3TmM2ZE1CMjVEei95NDRiY1pIYlJQLzNsR0VNZHhUMjVZaGRhTTYyTnF5?=
 =?utf-8?B?R3FqY0MrWFlVWXl1ZGU0dDZGMzRZMStZYXRaMSsvOVlkNHFTOEJKVmdRbElZ?=
 =?utf-8?B?Qm9CNjEvS1djbG9RVkU0ejd3elVPYlprSjBOZFdqaFBkWFQxT2c1NktmZDFj?=
 =?utf-8?B?OXpaaXJkKy9SYUxDWVd1djQ3M2dZNnRzV1VtSWFoSTFoaWRXZS9JUFZrYWlK?=
 =?utf-8?B?MS9GSG5yelRVbjZRQjFJRnpOWXljTFBRUWVWZjdYckJNSlNNWkRYeEQ0a3hI?=
 =?utf-8?B?NTRwWFNsaFo1U1EwcUxPQ3Z5bWtMdTRlM3pkVVBXV25JQXFYRWhUbGVpaW9M?=
 =?utf-8?B?a1VpTlVnbVF5bVpoYWRqZ09mOGNmTU9ubmdTU1Z4Y2lhL1pDUTQ0aHdzSnNT?=
 =?utf-8?B?QWNlbm9qUHllZkozNXdQU09semYwcnJLSytYc3FrZ2V6UjJCOE1DMThqcGNK?=
 =?utf-8?B?dnErM0pxRjU2OUxGNGpLUHBXaWxBQ28ramMxNWpWTEFLTURoMTRETHpjSndi?=
 =?utf-8?B?SnE4S0tRSFFtMnFuSEtqR3UxbGpQUExrSkJoRTNMdVErMmFOUkJ3TVN1c1F5?=
 =?utf-8?B?VVI2a2NVeTIxRmVSS0Z2SWFKZGxrNWl0MXIwOWE1MTlKUFY3eTVyOVYzSHgx?=
 =?utf-8?B?Q0NIbDN4c3p0bGJteURVd3RHcDBLUHl5S2pRdEY2TGVaS01SV0ZGMnY5VFBm?=
 =?utf-8?B?bDZQZEEwUXNSckk5WmY4VWpHS1RQbm9nTXRGVmxHaFVKd1JpTGViOE9hcXlj?=
 =?utf-8?B?MFU5S05GMGZqaldKR0F2MUpEY0pURVY4UWtDazRLWGxhUlpIeWRqZ3JzMzVM?=
 =?utf-8?B?ei9oclFoUExFbEdhYzJDWHk4eDU4UzgyenNzRkdpbHNyYUYzNDRYWW0zRTIr?=
 =?utf-8?B?SmVub2Y0eElheDk4N1VIeXFaZTd1VUViTjRzcjRQUEJCMGppTEUrSEpCVE4z?=
 =?utf-8?B?RE1MbTRGeE1BWHdTdk1WZWorVksrWDlVVFhmM2ZoL0M4Q0tCTVUxcndhcG44?=
 =?utf-8?B?M0o2MjU0bk1YQkJ0ZUxaNjV6MXVBVmFBZDBNOG54Zk4yUEt1SDNRWHJlVmdu?=
 =?utf-8?B?SnhoM3hWd2ViTjNkUEhSVm43eXhTTGFOVzZvK1psRVNzUTlkdkJ1cXFYZC9k?=
 =?utf-8?B?c1d1VEhzQ3ZIc2hXWGNYVjhkUkNhUDdjLy9TaTFqR3ZqMERkYnl6WCtram9P?=
 =?utf-8?B?eGZnSTY1eDZXQ21oTHJIOStQcUl2Vi9jUXI1WjF2eCt2U3A2bUNUdGRVbmFl?=
 =?utf-8?B?dzN0cU4xcStNOFoxTzNLSjR6ckVGNjVCaTRXYzFEWHlDRE1sM203SUptckk3?=
 =?utf-8?B?RXdpV3FZN3hsNmpYSkdFdTZkU20rM2ZhbmtFQldRbi8zcEU1VmFkOEpvSGJy?=
 =?utf-8?B?am5XQXFJenpjZ2lVRVBXTmpPNHVIRzU2R2FhUG5OUVJYK0FQYmJ3cnpDeitM?=
 =?utf-8?B?enNuWHAwU2RhT2NjMG53V2Y1SHdZUlJnQ0JOZmNyd2RLejhvL0Q3d01FZTNj?=
 =?utf-8?B?Qy9keG4wZTRyNFRWWGViTFNxZFhTaDdTUWpmT25wUmJLSFUrOUlaTk9GdmYv?=
 =?utf-8?B?bS9wUCszMFY2Qkd0U0wxUHlybnhQRHZ6NUdCQ0NKWFQwcjhSTkw1TFZHbUtQ?=
 =?utf-8?B?SUIvdzd0WjBzdUJZWU5lSzhDVWNhaXlTNTVEMElabjNZRDVIU1UzS25LMnMy?=
 =?utf-8?B?UnNNTU1oWGFpelBuUFJTS0NLQzg1dkhudEpmZjJ5N3EzQndBMVZBeE9DR1pl?=
 =?utf-8?B?cHp0VWwwZDdFMGpqQktrUUcvQWNlSVV6NHppWHkzbjdQc3hTZjRaQTlXNGZW?=
 =?utf-8?B?MWZNSVBPMC9BYW9qNExnUkRJekdMa0IvOW1MV3hnL2FJcVVVbi9EN0F4dHF2?=
 =?utf-8?B?cm1QTDRiYmg5NFc0bVVPZzRYNVozMm9nczIrNW84U2lWUWdCVjZZY2UxclNB?=
 =?utf-8?B?U3BkMC85L0hrZ2k4aVdzUEF1UFRCa2JMb1RNUzV6REZLK09Vbys1Y2ljc2p3?=
 =?utf-8?Q?IaBiCoqsF2+wGAFXCAJGE/E=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ae5bb8-8896-453b-a6c5-08dde40648e5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:36:20.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTReKFSBlOtiEpN+tU+UtPLAqT3LA1d1WDOY9Ndt/44iCfbtAUwZnX9FzzFXtGq7KqdFinErYvNTF4QU5TUIWRUdkrdlQ1I0MefTiHFuCFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9478

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Config based debug is rarely turned on and is not available easily when
> things go wrong.
> 
> Provide a static branch to allow permanent integration of debug mechanisms
> along with the usual toggles in Kconfig, command line and debugfs.
> 
> Requested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   Documentation/admin-guide/kernel-parameters.txt |    4 +
>   include/linux/rseq_entry.h                      |    3
>   init/Kconfig                                    |   14 ++++
>   kernel/rseq.c                                   |   73 ++++++++++++++++++++++--
>   4 files changed, 90 insertions(+), 4 deletions(-)
> 
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6443,6 +6443,10 @@
>   			Memory area to be used by remote processor image,
>   			managed by CMA.
>   
> +	rseq_debug=	[KNL] Enable or disable restartable sequence
> +			debug mode. Defaults to CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE.
> +			Format: <bool>
> +
>   	rt_group_sched=	[KNL] Enable or disable SCHED_RR/FIFO group scheduling
>   			when CONFIG_RT_GROUP_SCHED=y. Defaults to
>   			!CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED.
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -34,6 +34,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
>   #endif /* !CONFIG_RSEQ_STATS */
>   
>   #ifdef CONFIG_RSEQ
> +#include <linux/jump_label.h>
>   #include <linux/rseq.h>
>   
>   #include <linux/tracepoint-defs.h>
> @@ -66,6 +67,8 @@ static inline void rseq_trace_ip_fixup(u
>   				       unsigned long offset, unsigned long abort_ip) { }
>   #endif /* !CONFIG_TRACEPOINT */
>   
> +DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
> +
>   static __always_inline void rseq_note_user_irq_entry(void)
>   {
>   	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1893,10 +1893,24 @@ config RSEQ_STATS
>   
>   	  If unsure, say N.
>   
> +config RSEQ_DEBUG_DEFAULT_ENABLE
> +	default n
> +	bool "Enable restartable sequences debug mode by default" if EXPERT
> +	depends on RSEQ
> +	help
> +	  This enables the static branch for debug mode of restartable
> +	  sequences.
> +
> +	  This also can be controlled on the kernel command line via the
> +	  command line parameter "rseq_debug=0/1" and through debugfs.
> +
> +	  If unsure, say N.
> +
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
>   	depends on RSEQ && DEBUG_KERNEL
> +	select RSEQ_DEBUG_DEFAULT_ENABLE
>   	help
>   	  Enable extra debugging checks for the rseq system call.
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -95,6 +95,27 @@
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>   				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>   
> +DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled);
> +
> +static inline void rseq_control_debug(bool on)
> +{
> +	if (on)
> +		static_branch_enable(&rseq_debug_enabled);
> +	else
> +		static_branch_disable(&rseq_debug_enabled);
> +}
> +
> +static int __init rseq_setup_debug(char *str)
> +{
> +	bool on;
> +
> +	if (kstrtobool(str, &on))
> +		return -EINVAL;
> +	rseq_control_debug(on);
> +	return 0;
> +}
> +__setup("rseq_debug=", rseq_setup_debug);
> +
>   #ifdef CONFIG_TRACEPOINTS
>   /*
>    * Out of line, so the actual update functions can be in a header to be
> @@ -112,10 +133,11 @@ void __rseq_trace_ip_fixup(unsigned long
>   }
>   #endif /* CONFIG_TRACEPOINTS */
>   
> +#ifdef CONFIG_DEBUG_FS
>   #ifdef CONFIG_RSEQ_STATS
>   DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
>   
> -static int rseq_debug_show(struct seq_file *m, void *p)
> +static int rseq_stats_show(struct seq_file *m, void *p)
>   {
>   	struct rseq_stats stats = { };
>   	unsigned int cpu;
> @@ -140,14 +162,56 @@ static int rseq_debug_show(struct seq_fi
>   	return 0;
>   }
>   
> +static int rseq_stats_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rseq_stats_show, inode->i_private);
> +}
> +
> +static const struct file_operations stat_ops = {
> +	.open		= rseq_stats_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init rseq_stats_init(struct dentry *root_dir)
> +{
> +	debugfs_create_file("stats", 0444, root_dir, NULL, &stat_ops);
> +	return 0;
> +}
> +#else
> +static inline void rseq_stats_init(struct dentry *root_dir) { }
> +#endif /* CONFIG_RSEQ_STATS */
> +
> +static int rseq_debug_show(struct seq_file *m, void *p)
> +{
> +	bool on = static_branch_unlikely(&rseq_debug_enabled);
> +
> +	seq_printf(m, "%d\n", on);
> +	return 0;
> +}
> +
> +static ssize_t rseq_debug_write(struct file *file, const char __user *ubuf,
> +			    size_t count, loff_t *ppos)
> +{
> +	bool on;
> +
> +	if (kstrtobool_from_user(ubuf, count, &on))
> +		return -EINVAL;
> +
> +	rseq_control_debug(on);
> +	return count;
> +}
> +
>   static int rseq_debug_open(struct inode *inode, struct file *file)
>   {
>   	return single_open(file, rseq_debug_show, inode->i_private);
>   }
>   
> -static const struct file_operations dfs_ops = {
> +static const struct file_operations debug_ops = {
>   	.open		= rseq_debug_open,
>   	.read		= seq_read,
> +	.write		= rseq_debug_write,
>   	.llseek		= seq_lseek,
>   	.release	= single_release,
>   };
> @@ -156,11 +220,12 @@ static int __init rseq_debugfs_init(void
>   {
>   	struct dentry *root_dir = debugfs_create_dir("rseq", NULL);
>   
> -	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
> +	debugfs_create_file("debug", 0644, root_dir, NULL, &debug_ops);
> +	rseq_stats_init(root_dir);
>   	return 0;
>   }
>   __initcall(rseq_debugfs_init);
> -#endif /* CONFIG_RSEQ_STATS */
> +#endif /* CONFIG_DEBUG_FS */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

