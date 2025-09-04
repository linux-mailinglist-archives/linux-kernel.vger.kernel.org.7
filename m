Return-Path: <linux-kernel+bounces-801427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7869AB444E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379B516E235
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A5321458;
	Thu,  4 Sep 2025 17:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sP9b6hGI"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2101.outbound.protection.outlook.com [40.107.116.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D5F3148C9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008470; cv=fail; b=f+365TxOp9VeZuIUFdXoWt2bDq56UVcXsVP+l+4soH40j9KYYW+BjC9BDqMh3BF5C3CwxWun+SC6t6qip83nBgFd8DHfiqtqL3rZCNWIE3BqFGSOSxjj41X8DuJC1ngEan9VKccZfKmat8Cwd1/uyMyL4TUzjaYrxXGgKXpy82E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008470; c=relaxed/simple;
	bh=yje1nLpBf7xbUJMsDwMlOG7OhrXxwUBH9hoCx0ebMoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kBu3DXMCmkOEz80zxDFzaKZ9ATgc3k37sfX0fsWHKPbYG7RH/mBWR7Jc6L1F++QuAJQmyytK4VjqvBt099Vb5cRYIsN8N/K2vJevyELPfa2ErkYYVkbrnZfy/Pr1VU9dC8TSrcQbwfg2hT0S6jZejnWuTvPGhSELIUCP4XIDaI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=sP9b6hGI; arc=fail smtp.client-ip=40.107.116.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHIGqwVR/rRCAvR0G0kHWGFjGIXQWicz9DdYlv27sNIZM5zZXehQcYvX2/nPc9tk03a3v3dS8M/lDtzZEf++segUkWmc+6/ii3oZad2O7VQIJgbfcP1Af8Px73a8KfIYKMHXnXOj8zmKIEntV6SPGao23cDtnIN5RzEKn76G9Gb62KHKsxW44ZLXvx9JIRAlY/6L3SmyJuFnsOa2fV2u/qJnju9b0nmqOrssrtwWs/ib0xbgM3E/9+Ewi6GfsP5pGTE32n2lCxz/7JA3O4gYjzqUWhWpQbHcNWCPk+UsRj9au5+zSl6EoIOJPl1TVcNoO3mC4XWysYWE//SmXFURsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2MHql5D7kdnyIww4v+/8J7Ru7ppfDeKeNfhsMLCFQI=;
 b=CUQuz0ymtmWlaqKA9evlPBi1N+0r9irz/KHNSjearmVOutEYw6y7vAdXOH/cCtxNukndQIVjhdh6D99Fv/qhRo9L2qeVQomrSpFqZmBDin7GKSbw/F7AWN2S3PBL0FjcFPaNhBZfvTe06LlK0MLGS3CRR9f/SNE3bMUojzawM/K7p0lZ6lYW+TwrL5TQon83uAgbMC0S63xi6xF1FjwgLO7bnz++NrygOiB6rrVRVSxPa6fjZ0kjwaL8wN3Kc1zeO46qMArSIvmtWCmvVjh0jC1PVr0qVgAIEGjErcozFeGlO41aeLN1Kdt3rZRA/nKGD5cReotRsUcCRA97vhDI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2MHql5D7kdnyIww4v+/8J7Ru7ppfDeKeNfhsMLCFQI=;
 b=sP9b6hGIZLKHexFtUt6pjmvyzAljpjWBGXkAkY0s2qm8MnYC/N2s3He7V8h1Wm2gCBXzhFO0mgyqULe+X3q3dQOBf9xHHFfkAPuar0ry5gkxTsZNgzAeCWOpBRkjrlsYXC9yXec4eAf9KeS3GvUkoZRUuK1VJGEVeWHXF/VkLiPxxV8ddgjhxYB+8zy+uLONyMkdsP/jYLRmsS1J3TVIwvqE72WVRn9XAtNWltKHRrkqNjv7RNlpvFo7purRQieP1It49A2+Flk7QUOPoZUd0A4+T9SaLS0FBAKQgvSRNNp0OqacA0yx9BKFEsyY+HfBmTgIQsoQbHF28kBdBDbrPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8271.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 17:54:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:54:23 +0000
Message-ID: <a5eaf7fb-bf09-4d66-90c7-03cc5803ff68@efficios.com>
Date: Thu, 4 Sep 2025 13:54:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 28/37] rseq: Switch to fast path processing on exit to
 user
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
 <20250823161655.063205235@linutronix.de>
 <bf216d3c-9d9a-45e4-b7a6-64c0c3cbe6ed@efficios.com>
 <02e74cef-f2fe-4590-8921-ef4df2b24786@efficios.com> <87iki0zooo.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87iki0zooo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0e24ed-ad9a-45c8-4761-08ddebdc1528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEFJaHp5MVBRcW5ISDZwRUNENnRYeTVIdE5FWTdiQjBFSGQ2L1hoUi93QzFP?=
 =?utf-8?B?Mk41bG5OdzZzeW1wMlhFQ3RUZFRNVVRTQkwwYWl1RE9maFdsd3lQK0YxeW82?=
 =?utf-8?B?cy9WVGlOcVNJbysvQWlFM2tvQkdtY05BRmVXYnpYa1BpT1Q3Ni9UZmEraEpu?=
 =?utf-8?B?cXdWWUVkeTR6YlFyQzk0TlVHRlVYQmtjNk1tcVZRdXFvL2kzeWhnVVM5RmNE?=
 =?utf-8?B?MWFhblRVZUczVUozbjJIUUx6bFY4aEtSM2NoS0ZJN1NNNVU1MHRIcXAxREww?=
 =?utf-8?B?MjYwQ3N6aWl6aC9mbFdkV3RwajEySStNL2FnTGV0Q0VzL0c4N1FKOTZ6NUp0?=
 =?utf-8?B?ZitWR0ZEUWdSRVduVy9iQ3dFb1d1SnA0QXMyd2hBRmd3YVVITUI1ZHlDWEVB?=
 =?utf-8?B?MFpNSmNKYnpDRkRPUUdvb00vRmJlUHZhZU5LdnRNN3BOTmlnaXRVaFUwV2pL?=
 =?utf-8?B?QnlOWmZIZ1c5cDdiSmhnMndVcnFXRlVtdzVQQ0VUa3ZZT0Y2c0RYNWxUaWpU?=
 =?utf-8?B?NTZFcUpJRGVXN0daendxbzJWaFowRVJRTXRNdUJEb0JqN095NGEwYW1KMVhw?=
 =?utf-8?B?U2Y3Z1NKYWtsa3JpQzA0SjY1cDZHbHdRVDlQRjVSNTZYbnQrc2s3Y2RqeXJp?=
 =?utf-8?B?ZXRRT09VME54TjJkcDNRc3hGa0d3UkxXV2RUNTFLSWlteUVyeGl5Vi9RR1Vi?=
 =?utf-8?B?T0NuUGdmc1dGdC95SzlmZjM4WnhTRzNsNkdwSWNVaWJJU29ad2o0ZjlVYjVW?=
 =?utf-8?B?akwzSkhZUjRZNy9OVG1PY3BaamVuT1FKZzNYeXJwamV4M2U1VVd1ejJ2RXF6?=
 =?utf-8?B?TXJLUmRlNWtadlVZQVVIU0RpWTZiaFB0N1czV3ZDSVV2SjcxeitCQUhzc0x5?=
 =?utf-8?B?Ukd2WUt3UGhCbXNzZXdoS0pyRjZVSFdqd0g3Y21yUFlEa0tNNk5UUXhmakhI?=
 =?utf-8?B?czhrNmNGS29ZZFFMYzhvRXhlKzI2UkhOV2lXeGQyejdHa3Z5NER3cmlUZkpB?=
 =?utf-8?B?dDBNY21NT2N0VFlKczc0bUx4Z29vNkFTKzFCOVd2Z09tTVBPTjM2S2YraHFU?=
 =?utf-8?B?cFg4Yk93MnBwUm01RlhRcVI5RnRRNGZZNUoyTjd2eFBBZVpDdXhoRmdMN1RC?=
 =?utf-8?B?MThKSTM4cG94djlZSUt3WXdaejRTVVAwS0Z3OGoxbUR2YmtBSnk3ZmVpMHRv?=
 =?utf-8?B?Nmp5aGtTejF1N1lyTFVOTUpBblJjTWtqbjJJUnFvbEJVUnd0bnJiTEQ5aUFn?=
 =?utf-8?B?NUNhVWppaDBYOGllZm0vTU82T1ZDYURkL283RlpVY3dwN1Q5L3lYNi9XMi9Y?=
 =?utf-8?B?L2FqRnIvNWRiTkF5SXduUk9xbk42d3ZTZThkSVJRQ1BVdW9Od3lyWEtzMmp5?=
 =?utf-8?B?c1JONEpWVGdndGRlVjltZE85eE5uMHlXWHRza2gzZU9OWkNZTW53Rkk3eXBO?=
 =?utf-8?B?UjdXL0lQK3RLVFdVeHlHS28vUGRXNm1ZMmNsdURJUnVNMi82SzVmMituL0ti?=
 =?utf-8?B?eWYxQWVIdUxITHV6UkdVZ0k1WEx0SDNCMHUrM09XajExVWxzeGYzZlNGTEFS?=
 =?utf-8?B?ajFBN1FtdmpuSktRYkhmWnlNQzZGUG8vdUhIZkNERUQzR3A1MEY1d1FjK1Iw?=
 =?utf-8?B?Wjc5bmZnTitpRUxkd01EYW02WGg1K2FkekRiZTlhYmNWMG53Um9zWHRkZy9p?=
 =?utf-8?B?Yk13NXJRdzBXeWtqVTVuNU44WlNpYXpvaDZFenhOVzVpMzUwaGY5NWliSFhm?=
 =?utf-8?B?b2plMlB4OEovd3FUT3IzWHUwN0QwR2VWS0dPeDQ3WTk0S0ZhZGVkMS9TaHRu?=
 =?utf-8?Q?aeIN/RS2PXb/kT0fOODxtY2mDwsHVNHz1H9LI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXZ2RHZ0ajB3c2R0dEhrdW12Snl6VGl1SEZENXgzSlpXclBheE9sYVZNc0NH?=
 =?utf-8?B?Sk04TXJHOTFBS0lwdDJqWHZZWDU5eHdmL3p5cVByaDNQSmtlM0g3bWJUWlpO?=
 =?utf-8?B?S3lhQmgvdjcrUHh1bDlFSkthMHB0dHl2WThMWm9BNHpLZFplanNvYk9LZEI3?=
 =?utf-8?B?N2pjRU1HakhydTdMR0pLVUloZmdtMmFxajBCM1RuN2N1L2g3bDJpVytsU1Jh?=
 =?utf-8?B?UVdzM0Q2NDhheDYvc2JYMWJodU5tcWQyRGl3dGdjdzNoRDQxVnRBdjBYa1pX?=
 =?utf-8?B?M1NiemZycDgwQk8yNndrOE5SSkprYTFxL0xXVkErNTNGdVF2SFE2OUw4QlNV?=
 =?utf-8?B?RHZLRXNSWGoxMFZqbDhDczZxR1A0cXY0UFkvTzFQVWhrTXRYNFZ5WGVtVkh6?=
 =?utf-8?B?eGNLRm1iS0xkTkpRNmVaeUNMOHczZ1ZtQk1BQW9vbVVOcEF5WUU4dWJsNkVW?=
 =?utf-8?B?dU5lZ0VVb2syeVBqT2lpMTczT0EyOSt3d1VZRkxlR3VYRTlVbncyejBadlo3?=
 =?utf-8?B?dlJIdEYwVDIvazJTSWxqZVZoczV6OUwyVnd2MGw4RDlHTHNhbHljZVk0d3hN?=
 =?utf-8?B?TWdQWFhYWUY0SmhJZ2Y5dytIR1I5KzR2cmhXMTgrOXdyMHVvWnJ1Y2pkUUk5?=
 =?utf-8?B?VlY5blMxTndlWGtKbk5BNjhGelFtQ1piZURITGRmTHJDc3E2c2dhY0crYzVE?=
 =?utf-8?B?aFRSWHJkbEY4Ky9aaG9Od0pGeVhZak9xTittYis3WFo1RnBpUkd2VXlkQlEz?=
 =?utf-8?B?b3Fib1U2T2QzOTMwcDd0QlJqaERYRTBvMzdBWHE1T1BlZFA5S203YXNjWUlI?=
 =?utf-8?B?UW1yVkRsYi95TnBNWHA4SHIvanRsWUhmN2dhWmpNeWdiK3ArK3pCNXBkSzRv?=
 =?utf-8?B?WTNMZ29PLzNLRWVHNWxzRDdPb3R1LzJ6aWZQRDFBOHhiTHJRV1V4RzVxNW15?=
 =?utf-8?B?OXRPdy94Y3IxMHQyVUdPVTA4a05USVM1bEd1K2lrQW9jY2xwNDFIRXZqemFT?=
 =?utf-8?B?R2FRdE9Dd21kMXdKRGpLeHUzNTNObitZcllwKzVYL2NPaVgwbndya0lUTzN6?=
 =?utf-8?B?Y2xPeVdFMGVGRjhnQkthdk9MaFBTalRaeVRJZWhBVWhnRWxhZlZUMEZlYlBI?=
 =?utf-8?B?V3grcDN1U2Znd0JHVXFZK21CdlZiMTU5Ui9UTTRGbkFlcUUxUDhEMXU1U09x?=
 =?utf-8?B?bWlMeVltSXp3aG13TlNZK2Y5dHF6LzV5cmpvNkpCbTJaR2hzZVE1emloVGl3?=
 =?utf-8?B?Ui9tMXlHY1BGeTAwUVJkMDlZd05Qa2cwYmRyMzI2SFhFL01uVmpSeDZXK3Vl?=
 =?utf-8?B?eVhOVVl6Tk1GU0pzSVJwcExzSnY1Q0czQkJrWWVEZURkaWxHdXRXYi9MVGZU?=
 =?utf-8?B?NjBKMUVWczVtWkJ0SXpkQXdZL2xydE1kMjFrUXhFZG1qRGhRYkZ5RTVWYUhC?=
 =?utf-8?B?ODNDVTdxczJNMTh4UWpHTEFUZUVDVlZQc01NYUh1a2FaYmtDUnppUGh3bXBZ?=
 =?utf-8?B?VnRndjk2MzIyS05Uck1USTlyRE5FYW9ucG13UHNDdWNTTzZRZGNLTkVSenJm?=
 =?utf-8?B?azNjbVZQVEE4RjRTaURKbVcxajdTSmlqamFXSCt5Q3VMZWtOREJBVGcxcWlH?=
 =?utf-8?B?UUlsNGhsWW8rN0ZtMGJpTnk1cnJHeXNheUFvUHg5WTRNWG5Bc2hSV1ZKQVM0?=
 =?utf-8?B?NWFCcEZiOEswRzN4ZmZ0OHJwZUllZWZySWRWSlVYMjRyaTY0T0dFRmFRcVNY?=
 =?utf-8?B?NUNtMGR1OXFUNjZ1OXkvQ1RBd3RTU0tqemtQRS9FdU11WnoxQVlzRHplR0NO?=
 =?utf-8?B?SUtNb1oveFdmd1Qxa3RBc1FvRUw5SHNscFYxU0t1SE9oNHhRT0lTY0J3U0t2?=
 =?utf-8?B?U1VrRnd3MFhPWENvbHNJTWsyNHpZUkpBS3dnME4yZ1Bja3cvQXRWaTlVNWpm?=
 =?utf-8?B?anl0U1VNOVJaUld2bDAwVEFNWkdtTXFGU0t1MEJKYjI3dXh5U0JndmxJdlhW?=
 =?utf-8?B?d0tZeVVpWFVVSTZGK3ZpNFd5T05rajl4Q2NBVS9qV1VGNGtHWUNrTzR5NVVO?=
 =?utf-8?B?T2daQXlBOHB1dGMrT0hpd3QrdVlwVXVoL0FoT1o5aHZJK1lJNFkwbCt3dFll?=
 =?utf-8?B?dUlCNlhmUi9Ob3gzNHFFVExjcVNkQnN6N2xScVhzR0J3YlI1cnJEQTdmTk5l?=
 =?utf-8?B?cnArS0NZNE5BQ3F5L1h2T1F2ZkExWUJxSmlNMFQ2NXc2aXNXakk1Uy9pM3dI?=
 =?utf-8?B?dkVUcmVaamJWUWM1eEVYZkxJZGdRPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0e24ed-ad9a-45c8-4761-08ddebdc1528
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:54:23.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDhCTDP9mkQgoAA39gpdpptl/cjwHJi6LAdMoqXCPJQO6dF+lJcwOu9+ZkfC11Vqm7YSwav//MvgJ2P4PeN6FzbMxSfbnmhkTkeodXGHmQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8271

On 2025-09-02 14:36, Thomas Gleixner wrote:
> On Wed, Aug 27 2025 at 09:45, Mathieu Desnoyers wrote:
>> On 2025-08-26 11:40, Mathieu Desnoyers wrote:
>>>>     RSEQ selftests      Before          After              Reduction
>>>>
>>>>     exit to user:       386281778          387373750
>>>>     signal checks:       35661203                  0           100%
>>>>     slowpath runs:      140542396 36.38%            100  0.00%    100%
>>>>     fastpath runs:                         9509789  2.51%     N/A
>>>>     id updates:         176203599 45.62%        9087994  2.35%     95%
>>>>     cs checks:          175587856 45.46%        4728394  1.22%     98%
>>>>       cs cleared:       172359544   98.16%    1319307   27.90%   99%
>>>>       cs fixup:           3228312    1.84%    3409087   72.10%
>>
>> By the way, you should really not be using the entire rseq selftests
>> as a representative workload for profiling the kernel rseq implementation.
>>
>> Those selftests include "loop injection", "yield injection", "kill
>> injection" and "sleep injection" within the relevant userspace code
>> paths, which really increase the likelihood of hitting stuff like
>> "cs fixup" compared to anything that comes close to a realistic
>> use-case. This is really useful for testing correctness, but not
>> for profiling. For instance, the "loop injection" introduces busy
>> loops within rseq critical sections to significantly increase the
>> likelihood of hitting a cs fixup.
>>
>> Those specific selftests are really just "stress-tests" that don't
>> represent any relevant workload.
> 
> True, they still tell how much useless work the kernel was doing, no?

Somewhat, but they misrepresent what should be considered as fast vs
slow paths, and thus what are relevant optimization targets.

Let me try to explain my thinking further through a comparison with
a periodic task scenario.

Let's suppose you have a periodic task that happens once per day in
normal workloads, and you alter its period in a stress-test to make it
run every 10ms to make sure you hit race conditions quickly for testing
purposes. Of course this periodic task will show up in the profiles as
a fast-path, but that's just because it's been made to run very
frequently by the stress-test setup.

Running busy loops within rseq critical sections is similar: they were
made to trigger aborts on purpose, so the aborts happen much more often
than they would in any workload that is not trying to trigger this on
purpose.

So yes the work that you see there under stress test is indeed work
that the kernel is doing in those situations, but it over-represents
the frequency of rseq aborts because those are precisely what the
stress-tests are aiming to trigger.

This is why I discourage using the loop/yield/kill/sleep injection
parts of the selftests for profiling purposes, and rather recommend
using the "benchmark" selftests which are much closer to real-life
workloads.

Of course if you are interested in optimizing the rseq ip fixup code
path, then using the stress-tests *is* relevant, because it allows
hitting that code often enough to make it significant in profiles.
But that does not mean that the rseq ip fixup scenario happens often
enough in real-life workloads to justify optimizing it.

All that being said, I'm perfectly fine with your improvements, but
I just want to clarify what should be considered as relevant metrics
that justify future optimization efforts and orient future optimization
vs code complexity trade offs.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

