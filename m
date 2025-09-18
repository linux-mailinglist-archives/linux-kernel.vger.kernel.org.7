Return-Path: <linux-kernel+bounces-759718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2C6B1E199
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6481118C2FCB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82031E5B68;
	Fri,  8 Aug 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fphYxQ9F";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fphYxQ9F"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3D3C17
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754630426; cv=fail; b=scqy22ARNiR4NvP7CzymsJdLmHawZZgJ46GUgo72ZOC23zmiXMWY53lWyzetAMyRfUwcwu0G8Qdqm4G3LeRvrQxl0NOw2jc7M19QC3INhchdll0CcWZBkILUIctKCKmboTyJQIPMVpfMq8p8Hr968chK9EH44iVSb8426yuGy/g=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754630426; c=relaxed/simple;
	bh=yYvCcXVJUfo9o5cn5c8K9AJQCBV349QBb3tx2gxdE+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DuIeTJLgPn8AZqg1ABZ0Fa7Epv0EfqswkmrA2vahfEO3+ELilk3KtV4SuIbG1i9ioeooeav9sbS/eKfUynRyEmcOJsS1hTIOfHFza4F7/JCfWmhwJBs8lzTgydBIQ7/weRKYWaHHEEqFwaUMuNjdLcXN3rvSiFVnQSes453COks=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fphYxQ9F; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fphYxQ9F; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=iE09yVUsYR4czkjAh5TBMhXhazGTqVI8AMn3+iILbmgtUuKvYImNlXXmu3pAq0Jpx2FP0JewbcHFIPyd4t386KyurJy6fvCysfyfEQAlGARdRBMUkz4ShWOY5TVWztmBO+DU7EXcr7UHlmUufKoNFB0MzsDMoqqbF62XTxDGYZ3bi08LGnjS0oCEgnV1I0zMH0nfBkVX3sYh7WnDiuS8j4mEuNGaj78Qx+vvrVo1tUzqmhZSIr6mTaiYtp9rvWcz9TOBNoohhnbabr2TLH7xW4oeBfBJJxHRBP0i7k3BHixs1OoDTJp1R32aMKei5Wcj5PfLEYz9v893uKF4bPBK3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3+fKgEGif7zcDVGYKNXEE9yBO2U7b3WQ/Zj9UDELn4=;
 b=MVdtqm3kkrK6Ke54yBrj77FuowFSoJyxFHDztt6ItchMqzDvu4TfX+TbH1FiXoeuUbtAuSfMVRp+N2vFQ/bdu1WJov4Qv8wfXC+OeR9wAv5R5xzsn/Yxc0sGyKz2lklmo9dsDb4hifIYF3vaUV4qysdVjVcSg34Hw33gJQSTNLb58bQIme/a4BpofVU611U5gg01AEs2TCsSLCFT3C8OfDZ0Wh6/Mx4galdFxBf3E6Wjpt2QoBN3tAR2qzkXYc7M/b/wrMigonvIl0wjQAIvPeDSCe7Dh2ClaQEXnPYg4B2TmflWqIaOHVbZzanAmUNFKrUGOpcqRsI96Hh+qwlgtg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3+fKgEGif7zcDVGYKNXEE9yBO2U7b3WQ/Zj9UDELn4=;
 b=fphYxQ9FkpQ0ySrIl7XE0z/24LmQG4dOA3ZkW87e8ibJNjHv2fRdtQ5cuKSQjWHl/jpMU++o6znMKZKbZhiLDHrSUHXAyU4IwgnCcsSKRMozWelbG48bSOFaKC1EH0qErKkQEm01146h0dPniZ4axgaWZYHOpMDFntfBUwpMYcg=
Received: from AM0PR01CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::36) by AM9PR08MB5875.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 05:20:20 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:208:10e:cafe::3c) by AM0PR01CA0095.outlook.office365.com
 (2603:10a6:208:10e::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.15 via Frontend Transport; Fri,
 8 Aug 2025 05:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Fri, 8 Aug 2025 05:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiSDTJMkGIwdtkCulKIFXIzGKQSv19/HW3fpPrBgyZPSBqC6IQ8O9c5Xh+HlUvL+Bfo7+yXDCkqzXuUeGFaWXROUqyGtQu9U9E5JXMwQ98HRmHMcGuDSLinh7O8A4vYBygxjt/7j0Xq1NFzwNEGyusQQyvJOswkLAo7eM/YVbODp345bMIMDTAQJNuD0rc4CK9TFCx2YPaXNHfEg1E7YJjVD/5r+QjQmP5OpHub76TS1mC+B4FIOowvHK+RKWmAwC+s6izrUYJ+oQHTL7XOH44CUiU7ZeKtZTiEy1FIBA+45SgYR6fertrN39AOZB3jmGFw5K1Yx6P7D++2VaN/5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3+fKgEGif7zcDVGYKNXEE9yBO2U7b3WQ/Zj9UDELn4=;
 b=kdBdUCH68q1dcpn3Psm3J53jEFAremawmcxyEvh1RUSguAsv0+CF3hcuhPJA3S0Is240coJ0eDDw4vrBVwUXoNepTPyTyFwczGjCRt+8smFqhBfsqu/LemRcJFdS5gwkJKlxJ7FzZQw8iC+5nmH/fvRurW7X0k7rcUbLlmEwbpLpT3Z499mO6h0Cjqvt9Tuku42+XTBD+p0DeuavW7TcS0k9tJt+z3msPq6COnw/Z1gzr4SLZKAiVY3UP/w2zUuCr3nnFzRJ4sVFP1GU1NnRRECF4K0FHPXL92Nt0UCmgPlUrIXyrC/H40nLIEluYByAsKvCgVcTtMkKAhiJqIXUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3+fKgEGif7zcDVGYKNXEE9yBO2U7b3WQ/Zj9UDELn4=;
 b=fphYxQ9FkpQ0ySrIl7XE0z/24LmQG4dOA3ZkW87e8ibJNjHv2fRdtQ5cuKSQjWHl/jpMU++o6znMKZKbZhiLDHrSUHXAyU4IwgnCcsSKRMozWelbG48bSOFaKC1EH0qErKkQEm01146h0dPniZ4axgaWZYHOpMDFntfBUwpMYcg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS8PR08MB6312.eurprd08.prod.outlook.com (2603:10a6:20b:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 05:19:47 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 05:19:47 +0000
Message-ID: <35d7337f-191b-4387-ae11-aad16e93157f@arm.com>
Date: Fri, 8 Aug 2025 10:49:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS8PR08MB6312:EE_|AMS0EPF000001A4:EE_|AM9PR08MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: d65572cc-406b-4b5b-3c53-08ddd63b44c3
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Yko4c1BCQjQyZHh6QUZ2SFJyNHdlWURKOExhV3V3UzAwNmdKK2E3QllLWWdp?=
 =?utf-8?B?R3VxN1M1QVI0NjlDWXNQOHlSNjBiQzlydVlGYjZ1TlVBZ2pkbHhyUXpEbGlZ?=
 =?utf-8?B?S2p4d09EQ0VwdVVvZU5IWDkwTVk0ZWFSazhETUdBQ3E1dDEwQnF4MjQxblM0?=
 =?utf-8?B?R1lUV2xVR3B5ckxTb3oyMlJkU2x2VlBBVzRKSXpnNzEyeGRhOHVZUCtoSXhh?=
 =?utf-8?B?enAzR044akNnTVRsK0N6QzFUYmtTdkR6OXk3MzF2L3duM3ZwRXRjd3RMd2NL?=
 =?utf-8?B?MVdnRCt6enhoVHpNWVBhUUxMZll1aUlWTC80RmxLM2sybkc4aWtZNTU1d2Vy?=
 =?utf-8?B?Z2llMHJUa1pBZWIzRXd3NFhBWUJYTkE4RlJLaEVjMS9kRlN6dXA2ZkFiWWNK?=
 =?utf-8?B?d2Vob29OaDVHUDQybWp2UkR2b25jY0Q5RHR4b3ZkNmQ2dVdHQWtWRFYzMVND?=
 =?utf-8?B?WmgwSkkvWlNKdldGZDUwaEdlZE1rSnJHaGt6WDVNanQzS2wxUGIxN0p3Zlpa?=
 =?utf-8?B?QURnRmhTS3BvTmx5NVBOV2YycEw0NnZNRmVMQ3JJajJGUnhkRTJSRGNOeGhD?=
 =?utf-8?B?dTJiZWptT3ZYT3lkaUFJdEtqN1B0RkloK1NjNUdSWjRtS2VvZGxwSkxQcjNj?=
 =?utf-8?B?cFdITzY1VGhGK1U0WW1TNmZVaUFna2ErWEg1NTRqQStkMUwzUGVHVTB2VEN6?=
 =?utf-8?B?eWt6ZGZEQUNVRVVmZmp2eFVFZkcwMnNRMldiRlNLRHM1dFVaYVRWNUZJU080?=
 =?utf-8?B?ZE1hZ1lBSFNtQTFhYzY4SHAzdUxRU0p3VEt4aGVHUXNzV25PZ1J4R1FZQkVB?=
 =?utf-8?B?Nis4cis1aGxiaU9JVmNETkdweXZkS1dibGZWNDNhTUxmR2wvNmdJM1c0ZkJO?=
 =?utf-8?B?ZE40bXpnbVpBaEY5aWRFVnJzclp5ZWthdFAvZTRHZjdTZFZwQmRVZVptd3N4?=
 =?utf-8?B?VTZYeXdQaXJkdCtkR3luSVRUbVJ4YUlVT0xSTWlLWmdOY05zZm1ZbXBHMHZm?=
 =?utf-8?B?NkVOdXNoQ0RzU1NkUWIxMFpjRER6UEZxMXZZNHRjTjlrUDEzcm5yeTZwdm9D?=
 =?utf-8?B?Z2d5WnhBUGxkS1phZVBnSjlNQVVhQ1AwN3U4NXdnNFNBcjc2eGRKaXRNK1Zw?=
 =?utf-8?B?a3BrazgxRUV5S3RYczFxZ29yZVVlQk50VDliYk5EQXpQZm9ETUt4RHBnZExX?=
 =?utf-8?B?M0hIOGR3RTNPRS9mRXVicDN2OFhsRDdiSDlGUStPNklmYW9VbU9kZk9nUnk3?=
 =?utf-8?B?aVlRek1IRzdGTVBESlAzUnRPZkdGWi9SMDltSHdZYnZoRlNpNDAzaEJQUDMv?=
 =?utf-8?B?S2pnZFBud1Y0dGtaSGsyNzE5R3VCcHNtaFd4RlpmSW1kSTdHR2pwZ3NpS2Fx?=
 =?utf-8?B?MG1BWnV1aDhZM0tCQ1ZWU3ljUEtoc3FlbjNJOG9QdXo3K2RTMTZDQTkzOGdL?=
 =?utf-8?B?VUpZQXUyMFZqeWlGa1JYUjZLNXY3Qk5YYzFiQ3IyQ0xzS3FENUVrcUswMkFY?=
 =?utf-8?B?NUU3U3hFNSsxUS9ONVFYRGpnenBia3JoWEtDMEM5OW55OTNoMWFsd3lmRG5C?=
 =?utf-8?B?VHYvUW0vaXhjUWxITVVvUU52aDdJSTF6UnZ4YVpOd21xVEMyaEFoN3gyT2Fa?=
 =?utf-8?B?Ymx6bWk4MW55RFlSM25TNDM1Wmd1cEF0Nm1UVi8yL1ErekJ2ODdVREF4Vmtv?=
 =?utf-8?B?bVk2K0JPbktLQWt5SlRqZklYa1E4M0ZreDNSUTI0bmJoeWxhWWVEMWZFZnZC?=
 =?utf-8?B?YXRyc0N6Y0l5TU1xcXdzWHcxY0Rnc1N5Y3VTK3EzN3FPMk1mdEd2V2ZhZlZE?=
 =?utf-8?B?OEJIVUR2SWp3WGt3SVJDQlByeDFtWjhaUUU3ZE5JRTBrZUlUS0tQcGxZYTlw?=
 =?utf-8?B?eFNyazNTVDA0VWNwTWVoNnFjc3RhQTRzUkhSL3o0NHRQUWdFUC9ROWw4Nm5P?=
 =?utf-8?Q?3RznHmacdB8=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6312
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	82708a3f-e956-4ce2-13c0-08ddd63b30f9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|35042699022|14060799003|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2ZmYUNPQmFXY0FGbWNlTXJxcnBFdHVzSzJ2M1lOQWk5aXUxUEQ0WFE2UUl1?=
 =?utf-8?B?RXBxS09DRGFTQzlUeGs4SGNrc1VDMTJCZUNYcmVnVFFib2lPY2NsbnR3Nkdv?=
 =?utf-8?B?amhBeDZvSnROd0QxaTRIRHV6RDBReDAxVnduZGliUXJETkxxSVBkM09HcEZr?=
 =?utf-8?B?emk4aTdKdW9raXVhYk1sQVF0c2dCcURmYzBSV3J2NmFUdk1sdCtLUlRMWmZU?=
 =?utf-8?B?ekMzQ2xOQ3B0RmduM1ZZWVdwekZQajhxaWZ6cGE2V1U2YUxKUkpueElDN25K?=
 =?utf-8?B?K3pPdVJuUXFvQWYyQ3doTjc1VXFPZmRiR0o0c0FKK3JxMTBRYXpjS3YzWWpx?=
 =?utf-8?B?OFQ4aGNoYnNLYTZLeU80UC9XZkxSMFFrVzdEME9YNE5UaFNkNXlqZmtJVVEv?=
 =?utf-8?B?Wis2OVhFbG9UZXlRZ2xBUVgxa3BmZ3NTZjUrL1F4Vm5qckdIZTNtd1UrT1RV?=
 =?utf-8?B?b0N3dzJsTzZxUHBqMTkxVmQ0UVhLWno5YW13QjZaOGZqUjBJNVJBRmt1Q0s3?=
 =?utf-8?B?eTcyamFYWVQxdTB5OS8xVXA1V1dlWCtsamJ2TlRyVXRxYVdZS0lpbm0xV0k5?=
 =?utf-8?B?bkRYSlpZbVRZQXArU2J2SFRPcUtxdzdFRTRmQzhrckRnckVTZVllOHBNT1lR?=
 =?utf-8?B?S2J6ck5QQWxCczVuamJtcjhDaU5tZ2FxNnlyVi9icFFsOXN2Mm9vNGdCSHB0?=
 =?utf-8?B?RGdzTms1em4yK1Ric1RPeWxlc2ZPOWZacTVIRHI4dG5aV0MzRDY0WnZBSzBI?=
 =?utf-8?B?bnpFeDZ4TFdtcTVWd1BUd0tBc1kvMGRyb2F6TllBcytHNnZqcUVWZUFreW40?=
 =?utf-8?B?TkNWSnRYTFpKWDF5N2Z4LzZUaDBPb2MwZGllR2pPOEVPQVZqZDZ2cXNJMk5y?=
 =?utf-8?B?ajkyTlRhZi9JT282bndUUmJpczJ1ckNwQVoyeEN1ZWE2dlR1cDd2U0tnSnho?=
 =?utf-8?B?MkJyNUUvVXlHMFJESHZaWTFhQmJrd281UjRxVXpOb24rbHE1dWJqY29DS0pT?=
 =?utf-8?B?cmVBak1HSll4RHhnQkR3YVhpL1ZobmxhY0hDY0RHejI3M2lON1cwRTdNN1JL?=
 =?utf-8?B?bUVsSURBbVpScjhnTmpiSkowYUhNVHY0b0E4Z0tPUWxZWUJZNGhaVVNvZUV2?=
 =?utf-8?B?bXFhK1hQYWVPUXJhQ0JjZk50SFFTc1pjcFRjTWJnZmRxME0xYWtHQi9kYURy?=
 =?utf-8?B?aGo4QXRTSnNBQnJZTzREeE1yZWhWYXNkdnVLekhFMmxhczRxRVRxeFVSdGV5?=
 =?utf-8?B?OGhCNVdCaVFqbUkrMmN5d0dSNDM3dFBzejhzbmhGbkI5ZTlzQk5VWjJ6UUgw?=
 =?utf-8?B?UlZjMit6UmFoTUpEYlJ0aFVIeENjcFFjWGRtdFFCbEJpOUFCbGhSQU1XTGhm?=
 =?utf-8?B?MHZ0NmF4UVB3Vkt1SGVaYmhnKzNrMVFRQWxLODRETzFFTVU1K1VTZzdUSHJx?=
 =?utf-8?B?RjdMcnJZTndYZnl6YkkwS3A1YWhWYVdldzc3WWd6M1JjTU41VTM3UDR1K3Fk?=
 =?utf-8?B?NTRUTlpHOVNqRWlCdVMrb0J6V0kvQ3h3QkJmVVFiVFQxVVg3TjBZeXR1UENs?=
 =?utf-8?B?b0ZoaFZrbmtmbzRrYmxsTlpRb09Pc0VBVG83VTJJRnViRk1ybG5naHFMUXRv?=
 =?utf-8?B?Z05uVVphTDgvdkJHVTZzTWtnZG9HZkl3VTM0UldMb1pvTDA5N0ZhVVlkR2R5?=
 =?utf-8?B?aU5ybVN1QVVkZTNFNC9pbWsrS0g4elA1REFCdWdlTFlyRGtRK0hrRWs1Nm10?=
 =?utf-8?B?S3l4aUtMcTFBOGFIK1g4WEdxUExtczlZRURYMDNVcncrMU1QSnlEUmFMcnY1?=
 =?utf-8?B?ZlJ2c0I4SVJ6ZzdsdnFoZzdFaGl1ZjgyaU1EbDlYN0NMeXpra0ZNbmVZVk5Z?=
 =?utf-8?B?U0cxSTMxaStrVGc0YWpaeFEzaGdZd1FvSXJZUnVVd0ZuMkhMV1VmTzNIcWQ1?=
 =?utf-8?B?RWU3ckZZWWdFV2Nnd25tMlN5OURvV0dncEhTMTAxNGU5aS9DN3YvZCtHem1s?=
 =?utf-8?B?dVEvdUtsYjhNR0JyVnlXUzRqalh5QzBIOTJuTEZyZXdJSE1NTG5kU2NkYkFH?=
 =?utf-8?B?dUNscUpTRmFsc1Z5L3RlTG92SHFLWUwxbGx5UT09?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(14060799003)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 05:20:20.0641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65572cc-406b-4b5b-3c53-08ddd63b44c3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5875


On 08/08/25 12:28 am, Lorenzo Stoakes wrote:
> It was discovered in the attached report that commit f822a9a81a31 ("mm:
> optimize mremap() by PTE batching") introduced a significant performance
> regression on a number of metrics on x86-64, most notably
> stress-ng.bigheap.realloc_calls_per_sec - indicating a 37.3% regression in
> number of mremap() calls per second.
>
> I was able to reproduce this locally on an intel x86-64 raptor lake system,
> noting an average of 143,857 realloc calls/sec (with a stddev of 4,531 or
> 3.1%) prior to this patch being applied, and 81,503 afterwards (stddev of
> 2,131 or 2.6%) - a 43.3% regression.
>
> During testing I was able to determine that there was no meaningful
> difference in efforts to optimise the folio_pte_batch() operation, nor
> checking folio_test_large().
>
> This is within expectation, as a regression this large is likely to
> indicate we are accessing memory that is not yet in a cache line (and
> perhaps may even cause a main memory fetch).
>
> The expectation by those discussing this from the start was that
> vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely be the
> culprit due to having to retrieve memory from the vmemmap (which mremap()
> page table moves does not otherwise do, meaning this is inevitably cold
> memory).
>
> I was able to definitively determine that this theory is indeed correct and
> the cause of the issue.
>
> The solution is to restore part of an approach previously discarded on
> review, that is to invoke pte_batch_hint() which explicitly determines,
> through reference to the PTE alone (thus no vmemmap lookup), what the PTE
> batch size may be.
>
> On platforms other than arm64 this is currently hardcoded to return 1, so
> this naturally resolves the issue for x86-64, and for arm64 introduces
> little to no overhead as the pte cache line will be hot.
>
> With this patch applied, we move from 81,503 realloc calls/sec to
> 138,701 (stddev of 496.1 or 0.4%), which is a -3.6% regression, however
> accounting for the variance in the original result, this is broadly
> restoring performance to its prior state.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202508071609.4e743d7c-lkp@intel.com
> Fixes: f822a9a81a31 ("mm: optimize mremap() by PTE batching")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/mremap.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 677a4d744df9..9afa8cd524f5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -179,6 +179,10 @@ static int mremap_folio_pte_batch(struct vm_area_struct *vma, unsigned long addr
>   	if (max_nr == 1)
>   		return 1;
>
> +	/* Avoid expensive folio lookup if we stand no chance of benefit. */
> +	if (pte_batch_hint(ptep, pte) == 1)
> +		return 1;
> +
>   	folio = vm_normal_folio(vma, addr, pte);
>   	if (!folio || !folio_test_large(folio))
>   		return 1;
> --
> 2.50.1

Thanks for debugging this!

Reviewed-by: Dev Jain <dev.jain@arm.com>


