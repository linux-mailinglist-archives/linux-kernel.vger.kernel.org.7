Return-Path: <linux-kernel+bounces-786920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDE8B36DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE981BA7A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF7F28B7DB;
	Tue, 26 Aug 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PQQXvweB"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2096.outbound.protection.outlook.com [40.107.115.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A6199939
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222425; cv=fail; b=VJHi97K6lgVC19TCKMwsr//T97cQiQ23zatfNWDYoUwWvIq3fM0OCUZ215vZQj5sxM9aPLmiyvcgZbMkhGt8EZ6c4thQ2SqmprhY4zOp8TSVg2X7lOJ0JDwFZdjgBdxQiK3UP5vAdV/IQcUk34uaejYoP41jMK8fgBBiQk2ITnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222425; c=relaxed/simple;
	bh=9bsnpeTe2MC0v+S5A+f2ORePtB541t6pzGEOI43XOhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gvLhpwqvOBgziAC5Saqlitr6KDCPuQPSR3Ve9enl0IPveevE4NnT/KodSrGnEP6N6V3k81O8C8je/RawYY6YcTPJudFAqlLDjIQ3xzMfYvMW42Wo7NuMmew1YtpjN/9KsRABBbenbu6h2t79KQpEOBBzwpwPtQ6rLSbrYeSC36g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PQQXvweB; arc=fail smtp.client-ip=40.107.115.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3VakKG44UBtOPhueoaSOWE0R9n0FLgdw8KOkt4ImdJNyPXuK1BCqYnIQiryfyb+1Sm3VImUybnPRO/2AdH1dmT3mvBwsaWZJcmdz4VdfqrBSuTskw0Ah8xrRNokHtovZdE+LFoaZtZYyPZgIa1RTLhRRnwKUlfANo2JLLWgeMuNzsvnk/EaE8gmH3bXw3AeailGmekUlN6q/6KoqBP43SF6Ww1ceCacLfWYAjRw40v/8/CnamgpnyccryfATuSYSK/5J7kWTDpsqOQGhP13GNY5Fe/3mdIBbEpLGsmohwPgnmRCYuwRjf13/up2amD0P1NWcoBILFlUb7gSOrAu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jmSciCcp5tLELtuJAzh24+hrdn6Wy/1cDiixhWVWak=;
 b=X0nqkbHAQZeINUY56QvN+koh1EbkZsxKEAH6fE8BlYFRigM6nohNB6ocwI7XQTAmOSKgexny0ZXJVVL+FpMhoBsCSdPriXBt7jfIIVhgVhZWztYgJ8nNnfFG/S9v/i78pjsWZXhgJxBsO/jFJNM04pz4eB3zfOylwBsUFstXkLbNENA0vPA8MHYg90/HxNT3OnPeRkDOcc/ztzca2IVrbzgd4jq0J3lkw1/KwN6kb9ETb9mha1q3kPOWG2ATVXlsVrVWHm/RmePmtysKyCvzrSnfV9ICgJgx2KBxBmlWVHKCF0acuhuNXCW7rY+nli8UJzduUu5uJ0b/uFdcXEvCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jmSciCcp5tLELtuJAzh24+hrdn6Wy/1cDiixhWVWak=;
 b=PQQXvweBZYDtfLJk3sV4ZSEXdzizRh0YYIM61LGlZdrZQb9+uvuU59kIbtCf/blRTKa7tR0QHUf038mutXg/fCz3Jo0TawkDs8vdrsnw8nI4Qh71hiLIn0pXQCsudktH1yBQARcVdVwKAo22BFFhnX2TCmS4+8eyU0QG3EgIIq7NqaeN0kWeWJ6gavhz1Qls6BN2k6d97Bjag8culxDRiDmG3JApxy/S3kUWqgzprVnh4BVRNiddLXgLDx2IVEzEP3g2W9pXCNWQyoAEuC6AHH/e/RsbCC8Ue/irPHa9fy6J76AopT4jaZSlFetCtTTem+lX7XmuxwAzBjYAmjp3Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB11249.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 15:33:39 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 15:33:39 +0000
Message-ID: <8d2380be-20c1-4c0d-8067-efedcce6c9d5@efficios.com>
Date: Tue, 26 Aug 2025 11:33:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 27/37] rseq: Implement fast path for exit to user
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
 <20250823161655.000005616@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.000005616@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::7) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB11249:EE_
X-MS-Office365-Filtering-Correlation-Id: 693cfdfb-e525-4d6a-0c57-08dde4b5ee3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzk5V3M5VTVON2dybnIwalF6cjVCVDNiLzZaMWtBRUt5VEYvcll5bWFueFVl?=
 =?utf-8?B?cngvUEE1U3BZMGpORUZWYlZpSW9KRjA2eFJnZjYwNjN3ZzhjMGhuU1hvWGxz?=
 =?utf-8?B?Q0tiTVlTakNiaDVGNXhIRFViUisrTzV0TThVRW41blNpOE9iK3dQOXdzYm9q?=
 =?utf-8?B?QlJFdkhLd2kwdkFTK1dIbVhFazQ0UUVtNEo4Uk9DQndMbENvOHZWM1VDcXV2?=
 =?utf-8?B?Y0NhTDc0Rm5sK2hjdXIyYWxXRzZCbmxzK1kzdFIzUVduLzR6U0JjYWhxTDln?=
 =?utf-8?B?dEhxSE5uS04wQWxXMkg4a3I3OXNsYnFzQ2J1Qzh6VDZNcFVxMGUrcnIvWEpD?=
 =?utf-8?B?QUJFdDBpMDA0ZU9zYW5xRWlLKzhJTkpTM1dQYnEwNW1iTStvejAxU1NWM2ZY?=
 =?utf-8?B?NTJQWGNBaXd0OG5kTVo0djhSYk1KN0pJdSsvS0NQejRuUDZ5enljYUJZQXRX?=
 =?utf-8?B?NE9LUThnTytZOTdNdm0zNWFibFNneUpSc2o5VEtncStIcE1HeGRDVU9tMHJT?=
 =?utf-8?B?K3RIdzA4MU1OSVlyOFpnY3lrVkduVEZjRFpuSnZhUWNWWS9iUjJXTXFFREZy?=
 =?utf-8?B?dEk0VDRHZHM5MkRhd1FZNnpGTVUwOWNyOGZSMzRZS2pTdGFWSUs3bENDemRU?=
 =?utf-8?B?eFBnVm41dUYvVVZ5d1pDc0s0ZzdKWFUrbjY0VWsrS0ZYekttbDVEMGZEU05T?=
 =?utf-8?B?NE03TUxRb0pqalREYmh4Q2FCeHdwbVgydU5PaGFtcmdGL0Q5cENBMkNyait1?=
 =?utf-8?B?bDVNVnFZcG9PanVoRWdBVFBLK1BJQU4zMUpDcU5PODBTMVpSelVNeUY5dEZu?=
 =?utf-8?B?RWE0RjJMRVlQTFhqaDFxcUxTZlFuWkhWMWdsKzFhNU9XbG4zZlhUTDE3c0Nh?=
 =?utf-8?B?QittNWQyR0VIcytXci9aUi96cFVOZ0M1TU1McC96dW84cUdFQWRRMFdkejVz?=
 =?utf-8?B?VUw1RHlTUGs3eDJuOFNtRzE1U0lTMjc4akQyZmxZSGlIODdjQVFFUkhmZHg2?=
 =?utf-8?B?TW9NeUQycW1JUFpCWW1FaVJWV29HNEs5R2hTVExuYTFJd0VxR2hNSStYTFBs?=
 =?utf-8?B?K0I2dGxuL1VvR3F5Y25HMkk4QkltL3h2bEVsMFdKcWx4RUlJV1I4TThXUzZ1?=
 =?utf-8?B?OVAxSmI2WGFvb0c3NEtQbGFWWXhtTWsxcllXbm9aKzg3QUFoK0tVVGsxWFFt?=
 =?utf-8?B?NXF6MFFZbWcxRUR3cHU1UUg1VGlsZFRzN3dKQnFIcGpzUkVmd3lPVjlrR3lK?=
 =?utf-8?B?eDZXWlNibkNMUDVJU0ZVWHIwc3IwbWI4cEIySnRzQlV4cTd0eDdKbDhodzVi?=
 =?utf-8?B?WWVtZzNVcmZ6aE5KVTV2K3Z3U21jZUFTazNYYWhEbFJxTXlNREJieEZNUXBM?=
 =?utf-8?B?dzRDTHFzNmU0LzNWOUVDNk9OUUZuNWdzZFlVZWpzeHpBS2U4RElFWlZTbnhZ?=
 =?utf-8?B?bVVGKzBiZDZFZHVGNEtwVjlhU001RVN5dWNkcUJHaWVicE5kYndTQVIwWXJG?=
 =?utf-8?B?UEtvWi9manUyT0dmTVIwdVc3UWhTTkxLNTV4SkQyVmlRRWpNK2RMV28zWFRp?=
 =?utf-8?B?dEpPbWliMW8zNGx6T1lYSVFtY25wUnVWaUZyNkRSbHpnK0gzZ2FmZXVmY3U0?=
 =?utf-8?B?Vmp4c1VDZE54RFFJT3JWUG5ISVltUnB4M0ZzSVJXWlFMZDNIdXpVNm9RTVln?=
 =?utf-8?B?SzV1S0RuNEczVnlmbVJCMEo0MVJ0NEZ1RVgrWU4xa0tUZi9pc1RZTldkc2Jn?=
 =?utf-8?B?YWRwVFBhTWRRTWU4QzRsSS9Gam9YeFBPSVowU1c1RVVjU2lVSG5CUWl0NjVQ?=
 =?utf-8?Q?Q39kOlHNrhe7mrGeQoCgU2skDrGcdmVxCUllk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmVyeDJoRlpPMXBidFQreURjL2JWVWpzR0t2eENvYzEySzNPR0ROeFZrUXdP?=
 =?utf-8?B?K0RZSGdDTE1TZDMzYXBRVlBCcy9jZU1pbnY0QUI0NFZaTlhnWEY4TVlkRWpv?=
 =?utf-8?B?aURpNmFyZU9abXBMM01VYlNxK1JjLzRSUXkxOTZzVnhBRFpIQ21ER3dqVkdT?=
 =?utf-8?B?VHhPbWpZMFVKWk5NYnI4K2pJR2ZwNUcrMXpzWFZScnZtbVdMakVrNk1wemZ2?=
 =?utf-8?B?VktoZWV2VnBEb2RBVlFpWE82N055M2xpZFVsU1ArK21PeEZ5UlgvNEpxOWVz?=
 =?utf-8?B?a3U5R2VDZm55VmdpdWtMREJDVlZvQlErZGtQQVBxUWdoMmVwZTI4eWEwV0lr?=
 =?utf-8?B?dExOdHJFTEtCSHlybW1GMlFQYWJpVkJPdlJ1djVkTG9QK3k0MG40d1JkUHND?=
 =?utf-8?B?M2ZZekFxTzdDTENzdzMvcmtiTWhZS25GWE40L3JGZjJlTDUxR29mSUxvc3lQ?=
 =?utf-8?B?YTdaaWJKTG5FVTVwTVl5YkY1ejNhQVJqK0RtdENyLzFSKzlESEpla3VXWXV3?=
 =?utf-8?B?L0dXYnlXTGoxbUVLcGxaTnJUZzNQOURTL1RSWXpLV3pBekcrQnp3RytpNWVh?=
 =?utf-8?B?aFlqaGtlSkdHVkhpSkVqZk8vbmcyK1U5YU9Hcm14MTl2emo2STVYeUR6ZGQy?=
 =?utf-8?B?YlllZ3I3SytGQzlRMzVzc09VVVppVWY5Y0NjRHk3S0QxdUdoWVBxL1pHZDFH?=
 =?utf-8?B?UUo2cURBUWx0Z1RrNVcvUUNjdEdydE1HNlhXZWdCUmJZUU9yWmVCZUU5UlMw?=
 =?utf-8?B?RG1LQlVhRm0zQWtaeWZCOTlVUDVsclBFV0VsS2NNcyt4dGIyWURJbjIwU09M?=
 =?utf-8?B?TUpFQ0dBL3FTeEpDYVRSazN0ZXNjNDJpa1F6R2FScmtaUmVCbVI4Wk41U21t?=
 =?utf-8?B?bXI2bUlhaGNOUjZCNitabDhROWx5d3N3ckNWeWVMV0VNR2xLZUZLQkp0QjIw?=
 =?utf-8?B?V0VnVEt1U2c2RklCL2JtaS9sNWk1QVNrR0xQL0hJN29DTXBFM1BnRE0zc3RO?=
 =?utf-8?B?bFpFY3BBcFZNWEFjSnk2d05CU0krbWZrQmxzVmpJN0E4UnB6dmpLRC9leStS?=
 =?utf-8?B?THRrcnZ0Q2NCNHlHbW5DcFpKNkwwYXdmV0s4MENIMW5qdDZDWEpRTlZveG1L?=
 =?utf-8?B?WnVVK3poMmJmVHJFWURrcW9GNnlYMGQxd0VwQ1BCMzVSWmRPOGI5bjg1WDh3?=
 =?utf-8?B?bHdMNngveG53ZzAzUmRNM05rOW54Y3R2K3A1N1AvbWlLY1dJSHFRWkRRamlu?=
 =?utf-8?B?a0NqdVM3V0VxUUNRbGkwQjBlN3d1L25rRTVMQ1hhMjFhYVZBcXFnamlTWjFF?=
 =?utf-8?B?WHU3SXl3UXJKNzVSZHhmVVFwRkpFeGZKaGZtVWJrZFdHbGNzQklNckJ0OGxF?=
 =?utf-8?B?RHFZTnlTTUpqbVNuWTNvN0trcXZDU2ZWNFRWYlliV1hJWkdCVkFvc0J3U3B1?=
 =?utf-8?B?aldOOFBqcUMyV1lXV2JNSTk2QXRrZ1dWSUJQT05TVE9Rb2R3eUhCT0RmZmll?=
 =?utf-8?B?Qmh3NEZwVExob2FaclgyNG1WS3lDTXQ5OUF0WDg0V0NudzN6cU9CbGY1V0Iz?=
 =?utf-8?B?bmFMTDhrc3YrcEtyQUQzVjJmdlpWdFdhbmFxZWZDWnRPR2ltcjFVOWh2bUcy?=
 =?utf-8?B?OWF4TkNFd0lvTC9kQU1pNE9lYWNxVHF6Tm5VWVFmQ2RualM3USsyVlBsekp4?=
 =?utf-8?B?dTRHWTBtYUgrZGlSNkZUbnQ3T0hIZGNBVkNWWWdKb05XZC9JNllVMDZkMDVU?=
 =?utf-8?B?eG9SaHh2YzZaTEd3dDZpU0lvb0VwS2FSa3BKQnVkZjM0RWwxTlY3cEV1cHFL?=
 =?utf-8?B?MjNsZ082d3AxS056MnQzZUlqMG43SE41L0gxWUd5b0RxTGFOem9Zb2U3aytL?=
 =?utf-8?B?VDd5NlpnS1JidlJLVEVta0xkclJVaW1KQTdPQ3c4SnlLK003TEVLSk1ISnlR?=
 =?utf-8?B?ODZibjBYMU9jSDNEYklrbmIwZUc0ZFg3aUtRWkVWWW9FT0ViWDRGc1Q2Q3ZP?=
 =?utf-8?B?bGQ3cmJVRWlvS1lLT3JuWDZrQ0h1ZVV0amNlV21DT3paTHlnTVg5SkdBN1JI?=
 =?utf-8?B?QkNCTjROKzduRTUrM1pVNXgzbWJGV1czY1lDZ3d3bWYzNy9Kb2RqN25teFVh?=
 =?utf-8?B?bFh4L2w5cHJTUGxXbS9rL1dwZ242bUFuWlJiYXpET1R4em5WYnNpRTRSOGha?=
 =?utf-8?Q?fjlbOqXMA+LC63M5gJR7jTc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693cfdfb-e525-4d6a-0c57-08dde4b5ee3d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 15:33:39.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Azz2elbYDRF4JByy6MYTrGcnWmvs6lH77Z7xQJpzIsqXTA+y8BQo7PLKe14xjwoH1/X2zR+JUDo/u2gjBQOMoQ/UNfhtWf9QaVpK/ch9cN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11249

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Implement the actual logic for handling RSEQ updates in a fast path after
> handling the TIF work and at the point where the task is actually returning
> to user space.
> 
> This is the right point to do that because at this point the CPU and the MM
> CID are stable and cannot longer change due to yet another reschedule.
> That happens when the task is handling it via TIF_NOTIFY_RESUME in
> resume_user_mode_work(), which is invoked from the exit to user mode work
> loop.
> 
> The function is invoked after the TIF work is handled and runs with
> interrupts disabled, which means it cannot resolve page faults. It
> therefore disables page faults and in case the access to the user space
> memory faults, it:
> 
>    - notes the fail in the event struct
>    - raises TIF_NOTIFY_RESUME
>    - returns false to the caller
> 
> The caller has to go back to the TIF work, which runs with interrupts
> enabled and therefore can resolve the page faults. This happens mostly on
> fork() when the memory is marked COW. That will be optimized by setting the
> failure flag and raising TIF_NOTIFY_RESUME right on fork to avoid the
> otherwise unavoidable round trip.
> 
> If the user memory inspection finds invalid data, the function returns
> false as well and sets the fatal flag in the event struct along with
> TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
> and terminate the task with SIGSEGV as documented.
> 
> The initial decision to invoke any of this is based on two flags in the
> event struct: @has_rseq and @sched_switch. The decision is in pseudo ASM:
> 
>        load	tsk::event::has_rseq
>        and	tsk::event::sched_switch
>        jnz	inspect_user_space
>        mov	$0, tsk::event::events
>        ...
>        leave
> 
> So for the common case where the task was not scheduled out, this really
> boils down to four instructions before going out if the compiler is not
> completely stupid (and yes, some of them are).
> 
> If the condition is true, then it checks, whether CPU ID or MM CID have
> changed. If so, then the CPU/MM IDs have to be updated and are thereby
> cached for the next round. The update unconditionally retrieves the user
> space critical section address to spare another user*begin/end() pair.  If
> that's not zero and tsk::event::user_irq is set, then the critical section
> is analyzed and acted upon. If either zero or the entry came via syscall
> the critical section analysis is skipped.
> 
> If the comparison is false then the critical section has to be analyzed
> because the event flag is then only true when entry from user was by
> interrupt.
> 
> This is provided without the actual hookup to let reviewers focus on the
> implementation details. The hookup happens in the next step.
> 
> Note: As with quite some other optimizations this depends on the generic
> entry infrastructure and is not enabled to be sucked into random
> architecture implementations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq_entry.h |  137 ++++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/rseq_types.h |    3
>   kernel/rseq.c              |    2
>   3 files changed, 139 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -10,6 +10,7 @@ struct rseq_stats {
>   	unsigned long	exit;
>   	unsigned long	signal;
>   	unsigned long	slowpath;
> +	unsigned long	fastpath;
>   	unsigned long	ids;
>   	unsigned long	cs;
>   	unsigned long	clear;
> @@ -204,8 +205,8 @@ bool rseq_debug_update_user_cs(struct ta
>   
>   /*
>    * On debug kernels validate that user space did not mess with it if
> - * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
> - * that case cpu_cid is ~0. See fork/execve.
> + * debugging is enabled, but don't do that on the first exit to user
> + * space. In that case cpu_cid is ~0. See fork/execve.
>    */
>   bool rseq_debug_validate_uids(struct task_struct *t)
>   {
> @@ -393,6 +394,131 @@ static rseq_inline bool rseq_update_usr(
>   	return rseq_update_user_cs(t, regs, csaddr);
>   }
>   
> +/*
> + * If you want to use this then convert your architecture to the generic
> + * entry code. I'm tired of building workarounds for people who can't be
> + * bothered to make the maintainence of generic infrastructure less
> + * burdensome. Just sucking everything into the architecture code and
> + * thereby making others chase the horrible hacks and keep them working is
> + * neither acceptable nor sustainable.
> + */
> +#ifdef CONFIG_GENERIC_ENTRY
> +
> +/*
> + * This is inlined into the exit path because:
> + *
> + * 1) It's a one time comparison in the fast path when there is no event to
> + *    handle
> + *
> + * 2) The access to the user space rseq memory (TLS) is unlikely to fault
> + *    so the straight inline operation is:
> + *
> + *	- Four 32-bit stores only if CPU ID/ MM CID need to be updated
> + *	- One 64-bit load to retrieve the critical section address
> + *
> + * 3) In the unlikely case that the critical section address is != NULL:
> + *
> + *     - One 64-bit load to retrieve the start IP
> + *     - One 64-bit load to retrieve the offset for calculating the end
> + *     - One 64-bit load to retrieve the abort IP
> + *     - One store to clear the critical section address
> + *
> + * The non-debug case implements only the minimal required checking and
> + * protection against a rogue abort IP in kernel space, which would be
> + * exploitable at least on x86. Any fallout from invalid critical section
> + * descriptors is a user space problem. The debug case provides the full
> + * set of checks and terminates the task if a condition is not met.
> + *
> + * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
> + * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
> + * slow path there will handle the fail.
> + */
> +static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
> +{
> +	struct task_struct *t = current;
> +
> +	/*
> +	 * If the task did not go through schedule or got the flag enforced
> +	 * by the rseq syscall or execve, then nothing to do here.
> +	 *
> +	 * CPU ID and MM CID can only change when going through a context
> +	 * switch.
> +	 *
> +	 * This can only be done when rseq_event::has_rseq is true.
> +	 * rseq_sched_switch_event() sets rseq_event::sched unconditionally
> +	 * true to avoid a load of rseq_event::has_rseq in the context
> +	 * switch path.
> +	 *
> +	 * This check uses a '&' and not a '&&' to force the compiler to do
> +	 * an actual AND operation instead of two seperate conditionals.
> +	 *
> +	 * A sane compiler requires four instructions for the nothing to do
> +	 * case including clearing the events, but your milage might vary.

See my earlier comments about:

- Handling of dynamic numa node id to cpu mapping reconfiguration on
   powerpc.

- Validation of the abort handler signature on production kernels.

Thanks,

Mathieu


> +	 */
> +	if (likely(!(t->rseq_event.sched_switch & t->rseq_event.has_rseq)))
> +		goto done;
> +
> +	rseq_stat_inc(rseq_stats.fastpath);
> +
> +	pagefault_disable();
> +
> +	if (likely(!t->rseq_event.ids_changed)) {
> +		/*
> +		 * If IDs have not changed rseq_event::user_irq must be true
> +		 * See rseq_sched_switch_event().
> +		 */
> +		u64 csaddr;
> +
> +		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq->rseq_cs)))
> +			goto fail;
> +
> +		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
> +			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
> +				goto fail;
> +		}
> +	} else {
> +		struct rseq_ids ids = {
> +			.cpu_id = task_cpu(t),
> +			.mm_cid = task_mm_cid(t),
> +		};
> +		u32 node_id = cpu_to_node(ids.cpu_id);
> +
> +		if (unlikely(!rseq_update_usr(t, regs, &ids, node_id)))
> +			goto fail;
> +	}
> +
> +	pagefault_enable();
> +
> +done:
> +	/* Clear state so next entry starts from a clean slate */
> +	t->rseq_event.events = 0;
> +	return false;
> +
> +fail:
> +	pagefault_enable();
> +	/* Force it into the slow path. Don't clear the state! */
> +	t->rseq_event.slowpath = true;
> +	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	return true;
> +}
> +
> +static __always_inline unsigned long
> +rseq_exit_to_user_mode_work(struct pt_regs *regs, unsigned long ti_work, const unsigned long mask)
> +{
> +	/*
> +	 * Check if all work bits have been cleared before handling rseq.
> +	 */
> +	if ((ti_work & mask) != 0)
> +		return ti_work;
> +
> +	if (likely(!__rseq_exit_to_user_mode_restart(regs)))
> +		return ti_work;
> +
> +	return ti_work | _TIF_NOTIFY_RESUME;
> +}
> +
> +#endif /* !CONFIG_GENERIC_ENTRY */
> +
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq_event;
> @@ -417,8 +543,13 @@ static inline void rseq_debug_syscall_re
>   	if (static_branch_unlikely(&rseq_debug_enabled))
>   		__rseq_debug_syscall_return(regs);
>   }
> -
>   #else /* CONFIG_RSEQ */
> +static inline unsigned long rseq_exit_to_user_mode_work(struct pt_regs *regs,
> +							unsigned long ti_work,
> +							const unsigned long mask)
> +{
> +	return ti_work;
> +}
>   static inline void rseq_note_user_irq_entry(void) { }
>   static inline void rseq_exit_to_user_mode(void) { }
>   static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -17,6 +17,8 @@ struct rseq;
>    * @has_rseq:		True if the task has a rseq pointer installed
>    * @error:		Compound error code for the slow path to analyze
>    * @fatal:		User space data corrupted or invalid
> + * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
> + *			is required
>    *
>    * @sched_switch and @ids_changed must be adjacent and the combo must be
>    * 16bit aligned to allow a single store, when both are set at the same
> @@ -41,6 +43,7 @@ struct rseq_event {
>   				u16		error;
>   				struct {
>   					u8	fatal;
> +					u8	slowpath;
>   				};
>   			};
>   		};
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -133,6 +133,7 @@ static int rseq_stats_show(struct seq_fi
>   		stats.exit	+= data_race(per_cpu(rseq_stats.exit, cpu));
>   		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
>   		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
> +		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
>   		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
>   		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
>   		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
> @@ -142,6 +143,7 @@ static int rseq_stats_show(struct seq_fi
>   	seq_printf(m, "exit:   %16lu\n", stats.exit);
>   	seq_printf(m, "signal: %16lu\n", stats.signal);
>   	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
> +	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
>   	seq_printf(m, "ids:    %16lu\n", stats.ids);
>   	seq_printf(m, "cs:     %16lu\n", stats.cs);
>   	seq_printf(m, "clear:  %16lu\n", stats.clear);
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

