Return-Path: <linux-kernel+bounces-758043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB83B1CA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165017B0531
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542342951B3;
	Wed,  6 Aug 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EKPfhVvI"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020112.outbound.protection.outlook.com [52.101.189.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995A5CDF1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754499467; cv=fail; b=YzaAtNngzLM5Tggvub4dwEHwOPkQsONHPDhydQlDerurwGyYcK1LxK79eMbUa6FWSmiBYPxMaubb1/3F33bI2ENYGw3jDpsfvXbkfvjR3FnoWQezoYRvGLgGdEiFyH9AxMVGoZDTWCJdnZfmfRRVIgEMT0QSxkjiGdXnKfQbQUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754499467; c=relaxed/simple;
	bh=g6mgOnAKstKDwDdRTu7oAimN/bRkG5bNX3eVxIaKdJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bVcWj7pFOeR5K/I3YRQp1b6sGHN2VJkiADOd8DiUaC9NugQ6P2n9ipTQicgM/gr/MSiukdCr1VLNt4Th/QwcxgiKlDYLkFnQQ6qwd3nHGmHXonXRxWfTHCppUHK3tL8rs6GXWE1iiLO5Y2Md8QSbmFNvWUyXMyZZSoVV84CMTco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EKPfhVvI; arc=fail smtp.client-ip=52.101.189.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IV9KAAz0+mE8cRc4MyUCE7bnGLJ1iBsotR4GKLdoka+iLbVHSpg44Zxt8t4gv349g+kDw5/c0SC/UG2rLcU8W1Bk6qSpp3+gPMiAggGbYm4+HZyTwhPkTE9enpAut78+QcnMDjLJ4elE+RFSCS2iRj3QDoZQX+2ZfBlR4JM8udBDRavc6fwVo4xiX1P+eaQ9AtQOt3xZJS2bASMjb6PtYy6uIWM284Mx/sFv1J9kczqBlqhMorSVL7Z9yCuwrE5TXVyy+ky2gygbpvkLC9AvqnXobg2wZO6k2h571UAE7sdKsDawXFENkkQ0ES/D8OIboO6RD1vUhD2SW4ymB7UG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oQ7Kz7JxjRzLcytg8pJc41XmTWwGCNj0LaejlYtXBk=;
 b=deMaPeY/Ds3iLJpslEC6BEp8GvA1zVjidGzzbD1notO03ghTrBeGa16dRuJYNRyn/6U/IEKspBoYLXZKlLYK2gUFUspPi35k8EBx+JNkeIUkH8ha/VQlFemGIdzD9dVXE+HmyUD3J6LnHrvS2hye0eE/L8H4EhJfGST9ZjcksFxmQ+S2IV+NBxfzG04m0ComX8MPkvkAhyDGyBpzl/iZ7SQbSMBCaH5RF7w9nj+c19dXikx1vaO5bc0LbI+l7VhyI4mwtckwgW+mytOo5Fuze9RGAaaJWrMjPTr6lE5vqto42qJS35kvxM1x4MlbCXHvCtHN314Gmjh+rp4wk51ePQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oQ7Kz7JxjRzLcytg8pJc41XmTWwGCNj0LaejlYtXBk=;
 b=EKPfhVvIckPBOenyuo3ihgEmEy3V8I8mjFn+vr2tWL7Ya7aKBd3YOin3h+EDuwqWOq/lVuLhaj4LtI3mVADeVkcjLNNTOa21aqxHE1Xvou6UOcUw/uAAkK2hiU98IRpaKaJGA8F2JtNOXni+pws5JZFEITRoAfEdZ64scpvO1qiH/Xko72/PlcmBc3t5jdvNLNY0Ez/zhHIkYCa81P2qYh1wzHUZBwZI3E0UfLvgRp/KWR2dKBIRWiFWAYCAFv/7LKeNapbWGMGWvFuXb5hbeHNh9031+le+7QXqeXvN3UEUyZ2RDWodX4QFeB8VX8Be/AI2KZv5/F31ZMu+fmhuuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8193.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 16:57:41 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 16:57:41 +0000
Message-ID: <6144e652-7599-4b04-a08e-9f059ff81e26@efficios.com>
Date: Wed, 6 Aug 2025 12:57:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] sched: Compact RSEQ concurrency IDs in batches
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250716160603.138385-6-gmonaco@redhat.com>
 <20250716160603.138385-9-gmonaco@redhat.com>
 <9c72396b5a9757913e061c0aa7f3d488b57a8a64.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <9c72396b5a9757913e061c0aa7f3d488b57a8a64.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d478f96-3888-46bf-3a55-08ddd50a5af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QisvNy92djVjMDFhbUxSSHM0YTdOSGp1RkhlWXZiclY0RjcyYy9ad0hVMWoy?=
 =?utf-8?B?TGVRNXBmc2o1aUZZTEtKbE15L2dTbVNXZTdSQmJRTVZCR2RoeW9hMUZKVXJm?=
 =?utf-8?B?V3dlNUNUOWpyRUE5cDduOVZwWFpPa2tGRzJwaHp5V1FMZGUrenVYcy8rV1VV?=
 =?utf-8?B?c01NaVlDbzNiUVhsQUxUWUxQYXp2V0MyUjlxT3pQZnp6WS9sV29EYXA2bHV4?=
 =?utf-8?B?dGo3Q2R2TWF5UDl0SmNraWp3RklCSU1nc1ZSQmN4UjZXb3pLR24xMWQ4YXBx?=
 =?utf-8?B?NkErcmJRdGVEKytqTmdYRHRXWmIrMmpta2h6QWNDRytKa09FSTRLYWlTbldB?=
 =?utf-8?B?UVREOWJsSmY5b1hLQk9FR2ladysvOXFSa1QzMVdYY2Fkb1NwOW9HdVBDT3JX?=
 =?utf-8?B?STJ1UFhveWsxaSt4b1VUVmxBVS9ZWlZ6N2cwTmcvbGRya0ZqZ0lHM29idi9L?=
 =?utf-8?B?eFR5RHBGWWlVSTRGVWdrMlNIR1lDZUxNeW10dG15NFpuaHpRdU13elJvR3JO?=
 =?utf-8?B?Vk5hbDZnNVduSitnZWZjdGtjYUgwbFNjRUlQZlFza3pObWI5WDNYVGt2NHpO?=
 =?utf-8?B?OWpIaXhEQklZcnRRcGFCc2g4VjVwam1FNmpta3JONEhWRFlyTHNLOWt4UWV2?=
 =?utf-8?B?a0hKeEZkSmZmTTcwbVZoRkFkSkp0ZHBpeHNkb1l0akhNc1NDeXQrWVdDSWR4?=
 =?utf-8?B?UzZOVThVLzZSQjlhVGdZNWVycVZYVjREUGM1ZnhaNmxESGRQNVpHNG15ZjVI?=
 =?utf-8?B?VU9Fem1URy84K1BBMUg1MzhXN1VscmtydWNVbTRoLzRZN1pHTGR4SUFKMk4v?=
 =?utf-8?B?b0RRYmk2eEtqMHlINVFBN0NVMS9JYzRLSzB3S2VBTjdQRzV0VVRxcVNXTlZ4?=
 =?utf-8?B?RWwvbVJVTkhmS2tCV3B3aHIwOStHUXg2cEdvN3laMDFFVERBWWVNQWdlQmZs?=
 =?utf-8?B?dUwzNmhLOFBkSUkxKzBjUzBwd3dWbDNnRVFWUWFSMFVsNXo1VjN2WTUzeDlP?=
 =?utf-8?B?akVZWXFFTHBvZXkxTFMyS3cwSkRacTVRS09Fc1huRy9sT0o1QWNpZFVDVkRX?=
 =?utf-8?B?ZDhmRE9wZW9zRWRqd0U1Q0kyVktXWHdIOXp6b2lWZnUrWlErSkx2U0gzUHc2?=
 =?utf-8?B?QzN6U0E5blp3NGtYSWVpQTR2VjEvcXF2S00rbW1FdFBXbUJVNnpXK2pRWC8y?=
 =?utf-8?B?NlU2NW0zREs3ZjRrTUNUNzRPMWZrQUVWTldxd0VLQUpSTDc5bFNPazJmdXNC?=
 =?utf-8?B?bUV1ZTZyTG5vRWNJVEhvWkpFOU1EYXdKYkwvd2l0ZU1Ua2M4cURVdzkybU1M?=
 =?utf-8?B?RzQ4Rkd2NFdKS0ZUdHluUEFKSFdTRDJROThyb0tkN2UzSTZPallUbkt1YUVK?=
 =?utf-8?B?dUJ1S0RMYWZ2UTlyQTFvYkJ4K1pVWmV6d3dhVlRyWkdCWWswSm9RY1UxTHlz?=
 =?utf-8?B?MHZlNlorWUFDQ2xzYk5jR3VhTUlYNjYwNHF0Mzg1WVhpZmpnT0Nnak1TT0Qw?=
 =?utf-8?B?bW0zRlFLcjVqTjRnbUtWcDVaQ2VkdzRPckNOVEJaQThqRzM4QXAvYjd3SU5Z?=
 =?utf-8?B?ZXVpKzVaYkhqWk51Zk13MmV6cTVjMGNSSUZtY01yU3Z5Z1dtcjdhYUFlSENa?=
 =?utf-8?B?Q0NsczVEY0s1aSsxeC9SeVk2TjgweUpiS0JaakpkTEZneUpiakc3WVRyMUtx?=
 =?utf-8?B?cTJMb21uSVgvVUJlQ3YyZHpvekdXMlVHUXYrNXJSNEpheGcrNFAvSXNwa3lW?=
 =?utf-8?B?dTF2RGdpN0pDb0tEQk1aUW45d2dPYmhlY3ljSERwU1JuTEUxMnRlTFVBYTBT?=
 =?utf-8?Q?TaAMgAOIgP2L4ON85GEcxmIHbSPRzJbFv95eQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJiK2NDaWQ3RGF4ZDFlVjkrd0x4bFZCbGFkYTU4eXF4TjI1VHNpZWU2S1pY?=
 =?utf-8?B?VW9tSmFCR3NuQkc0QUZwaHN3YlV4UmhKUVhIV1puWUNlUGJFbVZPaDVHbEFZ?=
 =?utf-8?B?N0VNZldwdHY5NStBSE9tR3JUTm1rS1p1dFY5bUhGMElIR1ZtVnBPSnJjc2t2?=
 =?utf-8?B?c0ErYlp6TnA1MTZ2NW1sZEpMbko5VnUzYU1KcS8zZkovY0NRbHh6elNoY2pE?=
 =?utf-8?B?ZXFkbXlxUThCYWNmVDEyWW02NjQxMHZKenRBY1F3VVZxVi8xTUxhbDBxZ3p5?=
 =?utf-8?B?WjhocEpXYktTazRySUZKc1VUN1JQSGRicm1oVkpVT0R2STUxazdTNWQ2MHFv?=
 =?utf-8?B?NW1xcjFwcHljemdYV0s1RGZRSS9pUVgwRWFSSkNJMnZMd0tTWkRnSkFIaXBJ?=
 =?utf-8?B?WVA1NWhRVnJrNGJhU0pXYjBHbXc1TUtzMzRXK3ZJdDBwdEhpaHQvY0RnMVB2?=
 =?utf-8?B?VGNkSlE1b1RnRFlYZXYyUWhTQ2VDUHJFK1FhbzVPVFJ1QzYveDE4RlFoa0t0?=
 =?utf-8?B?bHRjeEY5azZWckwwZTBkQnVNcDRyZGh3MklOR2dTcDdhSlZKb09lVE4xelNw?=
 =?utf-8?B?NmhYV3k2Z1Q0SkJiTDlyb3ZXV0dHQVB0bmpZczNxaGhHWWFPZDZwVWtvKytF?=
 =?utf-8?B?cm5QMWtaazJ0SUF1WmVXbWtpY010N3JTZE5GTjlDVFRMNk1DakFwcTdnbEE4?=
 =?utf-8?B?OGlxQmZtZ3k5bUhmTEs2VnFBbnRLcjltWis1d3hadE82ZUxTTFIzZFJkVk1F?=
 =?utf-8?B?VnhoWFUxQjJRR1hiN1BpQmhuaGJaVTMwaGJpczBqTC9qd0pqbkV2RHF1OHdO?=
 =?utf-8?B?SC9yOWFyN1RxR3htSXJYLysxb2lDLzk3alU5RnRUeEJxRXVRV084cW1UZVR2?=
 =?utf-8?B?RG5PckdIMFBXQlNMSm5tSGFRN3hNU0xEeDZKL25RY2dzdmJsaGlUYjFmNEp6?=
 =?utf-8?B?eUpUMmNPNmF5ZU1XaVVDam1oaDQycHR0YmhkU0hoVHNQVEJhYzIxTnNGNEFM?=
 =?utf-8?B?K0R5OHVkc3hKZWIzenFkSHUxQko3aGtuRVlPdzJWYzR4a1d5akRwK2p6dW4z?=
 =?utf-8?B?dWE3SnRTTUNjMWpCTVFyM2JxMmNDcDhjRmI4VSs2aHppK0F3ZXJZT3o2SjFQ?=
 =?utf-8?B?bFQrSlBWd0lqUEJRcElxeFJ1RHpwWjdDNDlxalVMeFJTamh1cmpaenFHQU4v?=
 =?utf-8?B?WE12TXVWRUpNOFRGZjBYZ0ZET2VvNjBNNmNsT0k5RHhXTUF5b1hqOXluT0dw?=
 =?utf-8?B?b2Nqcm5BRExnK0Q1a1pkRXBGKzM0SHpGeDY3Y0NtTjJwZ0NMT2JFZVNRaGRB?=
 =?utf-8?B?aTFyRjFWczVDVXhqMC9IcHYzWnRkNWw4dnhFZWhEZTZBUUFmUzJkbzh4MVFL?=
 =?utf-8?B?MUlXU3FvU1llUmI1TklIcEJJWTJvYVJWM3ZpckgrZDlIVDJCdlBZYWxVQk56?=
 =?utf-8?B?YUZCYzFNMkVzU0dpNXE5bDc0bGVzaENqMnlXQW9ZU0M1TVRWU1pJWWFacEVO?=
 =?utf-8?B?NFZrcThpUVFpMFl0eU9EUW8ydVFTL1RneElBcXVFMGlTbUZ5R2d6dkRpb3lK?=
 =?utf-8?B?c204cEgybHZDd2hCeTk1aU5TSlVhZCtXY2YxdjEyU05Gak5hVU5RNkc2Z0gv?=
 =?utf-8?B?T0ZjcHRna3MrOHhQc2M3Tlk1TEtHaGNEek9xMjlvTVhlY3pkZTI4dytERmll?=
 =?utf-8?B?M2dNSG9WRktYRFFpOTZqK2Nrb0V0cE5aUHQyZzBFeFdqNlZ2WDNBU0xMTE41?=
 =?utf-8?B?a3I0eTUxbFltc0t2Rlg4amVZVnArQ1FTTWlHcUluVUJ2Tm1ZckRZWXEvYWgx?=
 =?utf-8?B?TnhoQnVsVTRWRitNcnpVeDN3SE5JL3JxdVpyZ3NBNTJJclY4V2RselhTMlVn?=
 =?utf-8?B?ek5hMjZ5b1hJYXhFQW1tZkpiTTdVZTZ1K1haZWlZbDFqOGxMRFUrY0s0aDAw?=
 =?utf-8?B?TlFJd240RDVhVloreHdMVklkcDBUcnJLWTFzUlkrVGJvSisxZzIxVzF3U0U4?=
 =?utf-8?B?Nit0dzJmUmY3UTdYamdSM25Jam85dnVlU2hsT2pnTGU0NHoyMXlPOGEySnBi?=
 =?utf-8?B?NVpTbUNLeFNBUGVoUm8vcGRhSnJoYnhGeXArWDZjRm1QN1M0Nk5ZOFBIaVo5?=
 =?utf-8?B?SWk2anFqeVJHYThRR2Jtb0JJcTVrSXUxTzErVW8rTWJVTU1zNzc4a3pXcDRp?=
 =?utf-8?Q?lCSuIZLMWxzuzUMUDo8vtOk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d478f96-3888-46bf-3a55-08ddd50a5af2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 16:57:41.0439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlKi6XBNx32G5VTzADoS7p78F1fGom/dWt7w9CIRVwoKUyvk4p2jxJzpyP7dkgZJmLerhL+M/tmR2YlCHo2rL2U5yL3IU8HAiBPvV5id0Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8193

On 2025-08-05 08:42, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 18:06 +0200, Gabriele Monaco wrote:
>> Currently, task_mm_cid_work() is called from resume_user_mode_work().
>> This can delay the execution of the corresponding thread for the
>> entire duration of the function, negatively affecting the response in
>> case of real time tasks.
>> In practice, we observe task_mm_cid_work increasing the latency of
>> 30-35us on a 128 cores system, this order of magnitude is meaningful
>> under PREEMPT_RT.
>>
>> Run the task_mm_cid_work in batches of up to
>> CONFIG_RSEQ_CID_SCAN_BATCH CPUs, this reduces the duration of the
>> delay for each scan.
>>
>> The task_mm_cid_work contains a mechanism to avoid running more
>> frequently than every 100ms. Keep this pseudo-periodicity only on
>> complete scans.
>> This means each call to task_mm_cid_work returns prematurely if the
>> period did not elapse and a scan is not ongoing (i.e. the next batch
>> to scan is not the first).
>> This way full scans are not excessively delayed while still keeping
>> each run, and introduced latency, short.
>>
> 
> Mathieu, would you have some time to look at this implementation?

Hi Gabriele,

Please note that I am currently on vacation. I'll be back shortly
before the end of August, but I'm afraid there are other tasks I
need to focus on before I can get back to this. I'm adding this
review to my todo list for September.

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 
>> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by
>> mm_cid")
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>> ---
>>   include/linux/mm_types.h | 15 +++++++++++++++
>>   init/Kconfig             | 12 ++++++++++++
>>   kernel/sched/core.c      | 37 ++++++++++++++++++++++++++++++++++---
>>   3 files changed, 61 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index e6d6e468e64b4..a822966a584f3 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -995,6 +995,13 @@ struct mm_struct {
>>   		 * When the next mm_cid scan is due (in jiffies).
>>   		 */
>>   		unsigned long mm_cid_next_scan;
>> +		/*
>> +		 * @mm_cid_scan_batch: Counter for batch used in the
>> next scan.
>> +		 *
>> +		 * Scan in batches of CONFIG_RSEQ_CID_SCAN_BATCH.
>> This field
>> +		 * increments at each scan and reset when all
>> batches are done.
>> +		 */
>> +		unsigned int mm_cid_scan_batch;
>>   		/**
>>   		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
>>   		 *
>> @@ -1385,6 +1392,7 @@ static inline void mm_init_cid(struct mm_struct
>> *mm, struct task_struct *p)
>>   	raw_spin_lock_init(&mm->cpus_allowed_lock);
>>   	cpumask_copy(mm_cpus_allowed(mm), &p->cpus_mask);
>>   	cpumask_clear(mm_cidmask(mm));
>> +	mm->mm_cid_scan_batch = 0;
>>   }
>>   
>>   static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct
>> task_struct *p)
>> @@ -1423,8 +1431,15 @@ static inline void mm_set_cpus_allowed(struct
>> mm_struct *mm, const struct cpumas
>>   
>>   static inline bool mm_cid_needs_scan(struct mm_struct *mm)
>>   {
>> +	unsigned int next_batch;
>> +
>>   	if (!mm)
>>   		return false;
>> +	next_batch = READ_ONCE(mm->mm_cid_scan_batch);
>> +	/* Always needs scan unless it's the first batch. */
>> +	if (CONFIG_RSEQ_CID_SCAN_BATCH * next_batch <
>> num_possible_cpus() &&
>> +	    next_batch)
>> +		return true;
>>   	return time_after(jiffies, READ_ONCE(mm->mm_cid_next_scan));
>>   }
>>   #else /* CONFIG_SCHED_MM_CID */
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 666783eb50abd..98d7f078cd6df 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1860,6 +1860,18 @@ config DEBUG_RSEQ
>>   
>>   	  If unsure, say N.
>>   
>> +config RSEQ_CID_SCAN_BATCH
>> +	int "Number of CPUs to scan at every mm_cid compaction
>> attempt"
>> +	range 1 NR_CPUS
>> +	default 8
>> +	depends on SCHED_MM_CID
>> +	help
>> +	  CPUs are scanned pseudo-periodically to compact the CID of
>> each task,
>> +	  this operation can take a longer amount of time on systems
>> with many
>> +	  CPUs, resulting in higher scheduling latency for the
>> current task.
>> +	  A higher value means the CID is compacted faster, but
>> results in
>> +	  higher scheduling latency.
>> +
>>   config CACHESTAT_SYSCALL
>>   	bool "Enable cachestat() system call" if EXPERT
>>   	default y
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 27b856a1cb0a9..eae4c8faf980b 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10591,11 +10591,26 @@ static void
>> sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
>>   
>>   void task_mm_cid_work(struct task_struct *t)
>>   {
>> +	int weight, cpu, from_cpu, this_batch, next_batch, idx;
>>   	unsigned long now = jiffies, old_scan, next_scan;
>>   	struct cpumask *cidmask;
>> -	int weight, cpu;
>>   	struct mm_struct *mm = t->mm;
>>   
>> +	/*
>> +	 * This function is called from __rseq_handle_notify_resume,
>> which
>> +	 * makes sure t is a user thread and is not exiting.
>> +	 */
>> +	this_batch = READ_ONCE(mm->mm_cid_scan_batch);
>> +	next_batch = this_batch + 1;
>> +	from_cpu = cpumask_nth(this_batch *
>> CONFIG_RSEQ_CID_SCAN_BATCH,
>> +			       cpu_possible_mask);
>> +	if (from_cpu >= nr_cpu_ids) {
>> +		from_cpu = 0;
>> +		next_batch = 1;
>> +	}
>> +	/* Delay scan only if we are done with all cpus. */
>> +	if (from_cpu != 0)
>> +		goto cid_compact;
>>   	old_scan = READ_ONCE(mm->mm_cid_next_scan);
>>   	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
>>   	if (!old_scan) {
>> @@ -10611,17 +10626,33 @@ void task_mm_cid_work(struct task_struct
>> *t)
>>   		return;
>>   	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan,
>> next_scan))
>>   		return;
>> +
>> +cid_compact:
>> +	if (!try_cmpxchg(&mm->mm_cid_scan_batch, &this_batch,
>> next_batch))
>> +		return;
>>   	cidmask = mm_cidmask(mm);
>>   	/* Clear cids that were not recently used. */
>> -	for_each_possible_cpu(cpu)
>> +	idx = 0;
>> +	cpu = from_cpu;
>> +	for_each_cpu_from(cpu, cpu_possible_mask) {
>> +		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)
>> +			break;
>>   		sched_mm_cid_remote_clear_old(mm, cpu);
>> +		++idx;
>> +	}
>>   	weight = cpumask_weight(cidmask);
>>   	/*
>>   	 * Clear cids that are greater or equal to the cidmask
>> weight to
>>   	 * recompact it.
>>   	 */
>> -	for_each_possible_cpu(cpu)
>> +	idx = 0;
>> +	cpu = from_cpu;
>> +	for_each_cpu_from(cpu, cpu_possible_mask) {
>> +		if (idx == CONFIG_RSEQ_CID_SCAN_BATCH)
>> +			break;
>>   		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
>> +		++idx;
>> +	}
>>   }
>>   
>>   void init_sched_mm_cid(struct task_struct *t)
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

