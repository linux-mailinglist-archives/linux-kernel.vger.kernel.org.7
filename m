Return-Path: <linux-kernel+bounces-731229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C29B0515D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0966A4A6AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D92D29CA;
	Tue, 15 Jul 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hGKzCkVt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hGKzCkVt"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F62D29CD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559154; cv=fail; b=gOW+5izo/jJerQW9+ejkjD2N8K3QWWc5ncgJxxDIx0cm6c2QXAjEise+loFBQ9/qv+qkLflq1gkaG6ViobMtn8e/2x+8fu/T3r3YG+pqBS6jRtjY30wAM+0Kl4AeUHcyDoca95jistf0Vb4su9/ZHCS7UAbgojD+zP+Q9c6VENw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559154; c=relaxed/simple;
	bh=LpXoxFsEZlW590L9vPa9N1kKI5pr9WNHq9/LeTm5p2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CAZ1Sog01wbkmNmfiNdsx+woOGpayIRA50TiynzlF6+7NKfGEN082Z/p87pn938REORj5X7C2h8r6ThvRjBJqZmOsF05x20EB47thWUsFarkjLW2AEs83MoGXOFiXRxcV595XmUaqnXzTsKVMd1TEcerc8iBz3MYg5BDJKtXOz8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hGKzCkVt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hGKzCkVt; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ZjWGKx10FyDI7mhFdJLplBkDyaXUuL98Un7uVSc8wRsIDjEf19ejPJFb31TzSl3QeYVzOmjXbx6qB4k0PqHLvXHhaHXTntxgaKDWrI73ZNs6rm+Ho1bFV2NjjFQV/LVW2E32cJwNMiyAXyszPOr/hei+pJpWg+QQ9Wjwl6taqMwOL/3e0iOoJtYhRD9iNDiUOMBu9HazMEoQQ5Fvgs1P9JrO8YuL7PDcPTuhmTsnNT2LPWXGSOnjf6AuqBM5COPUuJfaF5/94LOmdK8LCTgvAZAbtgYKWWV99NxC6TMIHzAdkLhOJz0maARv/gWRpCkfFAqR7SkQ+a84ou/tSy5h5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ4618sI7z4OgiGU7RpsHD4MnPnqXfnqBOcajbUm7sM=;
 b=b4w4+bTOy+A1Bwbw4HsArjaTDblrezUJH4pvjy2aJw9cW/2ehzOZT+VQhEwMI1gpmqDUSMOKtVKXLwTbKtXTtUyEXj9j81TeYXk6j6gBErGXvCWuIc5GCvNoR+z1txKhiVZSpbf854yFBK2m9mSzOji7CqKLGCHKsis3iyZ3wk4SDUXQlcUoAXzYEv1glP0MnSboQtfloEcsMA6icXgaCZxQnO+SCXt0FBSwyYZBNjD8CPrDmuf7VhiShZl01J60X8fCTOv+Zcwwy05icMcuHIN98ul+uxnrJmjwhdk3IWIHR6+WXp4cyO00a5+pEAs9FAEVBOraHHZ3sHmLcdUzjw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ4618sI7z4OgiGU7RpsHD4MnPnqXfnqBOcajbUm7sM=;
 b=hGKzCkVtp7v+DUZeH3PBBTBZUKX8cainbP45id8elf4JKbeA5UYdylwr3vvo1AHK1Q3I0lu3jcqrGZw2yQM7riPvSgz5RyxFuBLtO0KbBSouKgfAK60iySMn/hTtWyjU8ltxsNLd5BxBl3lBPnbs5ZO+baVD2rbFlTT0mMUxayo=
Received: from DU7P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::13)
 by DU5PR08MB10849.eurprd08.prod.outlook.com (2603:10a6:10:522::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:59:07 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::ff) by DU7P191CA0009.outlook.office365.com
 (2603:10a6:10:54e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.17 via Frontend Transport; Tue,
 15 Jul 2025 05:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via
 Frontend Transport; Tue, 15 Jul 2025 05:59:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaygG//otc4rr3+qlLPFQXrM6qULHrW5S9u7ZfpsnEMFHpDgwIhiTZc6llvWUwM7xVN+uLw0xeVGBDD/LInzUlPhdzxYXwMVtu0ObikJC0nlSS1IwKQJd0PXdcV9BdKE/dDt62ODN8YDFd8bzBTuedxqr1t7PjOtX0vhAyq0Te3reYkhHNnUtC5T6zN8uf95u9zRCWxUMHgvUXgAHI+qihtZ7i+woB3Dp3AfZUbu+9TxUAGQeS1u84b80xlH+G2jEl62I1XR9NEXqFDywqVQ6lc9IrwMXXEbhb92UaAtxqpzaTrr+nGp7ZM2/Jm5ZFdkglI7XCfUkgkKy4TYOjeryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZ4618sI7z4OgiGU7RpsHD4MnPnqXfnqBOcajbUm7sM=;
 b=CeODBXl1HOq+kuKLPRco4caDTDAbHGyDIhydjY+2yAJdShGsUez7aS7qLQjipNuSpi2K+eNIOu+doAHlEdp5PMSrHNHFOmNey8U0DXh5dBdkMIF+hkGdL9A3KwtB8LEJIeRwXFdY6A4k8IhdxIQQ8xPL9Mw0OP1UxcUv2Fa5k4xzhIGD2N+GncFU5Gg+CrZfDwEU1JvvhE+MbgnsFFXNxojThzriVSAizsbd16FZwbfz4rvlZIxJBFg6++N2U6+SlM0Z4wpLkoWd6DqSgd5lIFIkH1dWyRDerZmcomsbYbvPjjTalrm2SIfK0UsyG1MDCpZxjokVRsO7zdTHMu7BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZ4618sI7z4OgiGU7RpsHD4MnPnqXfnqBOcajbUm7sM=;
 b=hGKzCkVtp7v+DUZeH3PBBTBZUKX8cainbP45id8elf4JKbeA5UYdylwr3vvo1AHK1Q3I0lu3jcqrGZw2yQM7riPvSgz5RyxFuBLtO0KbBSouKgfAK60iySMn/hTtWyjU8ltxsNLd5BxBl3lBPnbs5ZO+baVD2rbFlTT0mMUxayo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB3PR08MB9898.eurprd08.prod.outlook.com (2603:10a6:10:434::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 05:58:32 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:58:32 +0000
Message-ID: <e10e0fac-a81c-445e-8036-9db2b63b77f7@arm.com>
Date: Tue, 15 Jul 2025 11:28:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Drop redundant addr increment in
 set_huge_pte_at()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
References: <20250715043922.57195-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250715043922.57195-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB3PR08MB9898:EE_|DU6PEPF00009528:EE_|DU5PR08MB10849:EE_
X-MS-Office365-Filtering-Correlation-Id: a3828660-796c-4f1b-7d0b-08ddc364b52f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?clRuUkgrcmUrSWNMSkQrbVR4ZWp1RUdOT3dVSDRPSFoxbVFtNDR3UUowbDU3?=
 =?utf-8?B?bzhNeUpnSytZUUFOc2FKRkQvVE9DSnFVWFFINnFUdk1vU1FqK01XTjhsNzZa?=
 =?utf-8?B?S0F4NmU3a2pIRlh0MXZLRHp2dlptUnIrQ2o5Y3dVMklrSUUzTXFzRlE3UlF5?=
 =?utf-8?B?NUp1TzQ5OW8xVnEyUlN2RDNBQy9IeU5OZk5zUmFKUXpwVTJSRWt4dWpTckp5?=
 =?utf-8?B?SFFEOVpodC9ESXI3Z0JkQk42cnkxWW4xclBaLytsVU1VTHU1ZzNwYjRneGFJ?=
 =?utf-8?B?OEpOcENreVIrSVJIRzhVcUlxdjMzTDFqdkZIcTB4SGg5TTFvTTd0Zk9RbHcx?=
 =?utf-8?B?Mmc2SGE4TU9uWURDUWtncTB6U3RsWEs5SGZpYW5RTlZYb0RHLzdTcXlneG9D?=
 =?utf-8?B?ODFYNWhKN2tQSk55aXhsMXgyTm45UlZ0dGNteUNDVUFLMU1JOVl5L0FQS0tP?=
 =?utf-8?B?N3prcGdScUt6ZWplTjN3UzA5MVJSWUszWWVkSlBZRG1jVC9Eb1ZlSVBSTFBo?=
 =?utf-8?B?VDJ0OUVOamtVRndKTWtjb1J0WVBFbklhT3pOcXlzWWwyd3ViQjdLSmlmZ1lu?=
 =?utf-8?B?ME5PbFBwL1N4UlZ1MStxajI5SFBSdlZteTFzR29FT1NBd2NOZG80cFd5NDla?=
 =?utf-8?B?eGsyNTM5QXhYRGxCYW40RnJCRlcyajhtS1duanp3TzdzVlk4UUtWSUx1SHEw?=
 =?utf-8?B?OVNqTW1SRDMvUVIya2pQMTl5R0pmYXU4UW9ORTlNTUJ1Q1ltSXVEWE9LVG9R?=
 =?utf-8?B?d2xwS3IrbTZpSVZHYmZoOXpNK3RhNDlHTlR0YnNFMUs0SGNyT25DWmIvTFE3?=
 =?utf-8?B?S1VwcmpiVnBBRFNpa2M3OGRzZktEUzlyNVZUUFFmb3ZFZFBEWm0xYllBRlFB?=
 =?utf-8?B?cGpXcUlOMHpDaHBwcDl3RnNOMUZBZTBKTU9Fa3hLQVV4cFVmMDArT25uQUxo?=
 =?utf-8?B?SGxEQ1MvZnpRNEFrb3Z6dzQxcUd5TGVqTVQ4MHR5Qmx6UFVOdTQ0QXVnZzFs?=
 =?utf-8?B?cnl5eUlhSHdmaDhhd1JmTFhMVC9ZYUp3TEQ1K2dMZDFYaHptUWk5Rng0Rm1o?=
 =?utf-8?B?T3hsekVpQ3hJUnd5WEpkRlRhb2xoRFhxQzkvQ2JiaUJCZGFtVWw2R3RxV0Z6?=
 =?utf-8?B?UHVMY1paQlNvTit2LzVPU3czV3JsLzJTTlM0dVdDNDFIK050ZmFKV2k3M2h2?=
 =?utf-8?B?Tlh4a3lLRW51WU1iQkM5UTV2bkxNQTU1WjVpZHdhQTJudDVtYVJSUzlHTjFa?=
 =?utf-8?B?UlhPM3NEbXl1ZkI0clJMcnpVNG1tb1VUQlF3MXZkKzVRYXF3eGhTVWV5dlp4?=
 =?utf-8?B?TkVZTThmYXl1ZDltdEpYdDJpSlFVQjJoU3crR3pUdHA4N1hOcUVPS1QwM0cz?=
 =?utf-8?B?OTBuT2RnV0lBOWN4MmY4bEdNcXQrWk4vNmo2QzhabjhjMklhdHlncngwZFVE?=
 =?utf-8?B?ZXRTY2VKWldSbVpPQXJmdHhXSjR4TlRyQTA5dzZUdXdDR0pvQWpjS1RjZnpI?=
 =?utf-8?B?YmgwQ1pvZ0VmS1hFM1hUZWZ5Rytva1QrdnZxOFVkNzFLMUE2MXJtcmNSRU04?=
 =?utf-8?B?eVFRSzFBc0gzUXQ1WlUzSEpBNzBuczY0MlZmbHQ5b1RXaUYvR2VJbGFQYmQw?=
 =?utf-8?B?WGR1K1VUUS9OUy9FVGNJbjQ4aVJ3d2Nxbno5YStOUWtneXlXYnFXOVNiUDBt?=
 =?utf-8?B?SHg5TlE2RFArdVIxUFUwOWFGNDdJQnNZc21nNXpvZ0ZyYm5yUFpGbE9YUVJ6?=
 =?utf-8?B?WjNsY2RQQnpWM1A4ckkyTFI4M1dIZkV4SFQyQWpMOHpmWEU1eXNkeGpBeXNX?=
 =?utf-8?B?R0tHNm5sVXBVa0J0VlVSU2FqSW9PQmpEUjA5NXZTakYrZHBvZFB1SUp4OW8v?=
 =?utf-8?B?cUx4Ti9IQzRVZlRyRW1vMEJFeG9MWUxNWWZOS1pDTXhSWlE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9898
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f41c4103-73c5-4fd2-02d9-08ddc364a0e8
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|36860700013|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?citMSVd6REhGN3YwQmx4c0ZXMXFqNTdYcktJOUJHY0hreWlTYTBZOVhJS2FU?=
 =?utf-8?B?R2xqMEZmVG9PVHE1VDVEYzREVWdsWld3Zmc3WGlBNkJ5SHpUMmo4R2VJb0VC?=
 =?utf-8?B?eTNpa0xCeXpSc0tjaWRaaHNaS29rQVJRRDBOR2dMVFd5RnZDR2gxQ1o1Nkpa?=
 =?utf-8?B?TE43dThIUVZKNkxGMENtSHlUb2QrcTJMdEJpc3d6eGdFeXNtYWp4ZnoxZVov?=
 =?utf-8?B?cy9sZjZpSWVnZzNGdmZ6Y0hoNklDdEdUZGhjK0hPOGdDdGQ4ZFd4SnE0RVg3?=
 =?utf-8?B?cnF4U01ydjNubDJjaHBlaklTNWUxR1huVFdCMEQrb1h5ZG0yUGRpYXRHN216?=
 =?utf-8?B?alNuR3pMejVndmVlbVVNS29Scm1sSlNLYzk4dHM2TW9QWDkwTnVGRlVOZVB6?=
 =?utf-8?B?VHMvV09LS3NoZEUweFoySnRwdnBxbEUyS3JnS1J0ZVRkeVVzOUt0Nmw5Qm90?=
 =?utf-8?B?REZLSTdNd1hlUTFpd2cxWHVicEZ5YzA4YUYrdkdDcXpjWUc5MkVtbWoveDZ5?=
 =?utf-8?B?alREWjdkeEtGbDlmaGNnMUxUcEhhRzFoS2dLZVNvcFM2a3JleXR1ZWl1d0NT?=
 =?utf-8?B?WEZwN01qZ2NMQ3Y4aXZwc2lBbWhRTXlMaEJaL0xvanVXWkJwT1VQVDJXc21R?=
 =?utf-8?B?UWhucGlCYUpMaVJFcG1XUmtON1l5LzJOYVNoOHRLaXE5YjNTR0lkbEd0V2NS?=
 =?utf-8?B?NWdiNnJUNTB4OHhIdGE5cXNjM0FMZXpUa3JJRjBsMVRsa2VTVXF4RUlyc1pW?=
 =?utf-8?B?ZEtHamhiZ0V1R005bTZpSzQ2eWVxZHQzd0Vacm4vWTZoN3BCQXR6Z010MXpT?=
 =?utf-8?B?UXh0S0I5VmZmWG05cW5QQVI2d28zZlVpV25KaGVJcFZhYW1QbHJkN2RNUWF4?=
 =?utf-8?B?Ykhqak9xd0ZlZlo1UjJuNDhCMFlHTkI5S2lXd05rUjVBMWwvb1lwMHl5c3FP?=
 =?utf-8?B?QlpGL1ZZRWVqam1vL1RqTzRDNFByVzFZa04zSDFBWHJ3Z0xOMEdhYU96aVFK?=
 =?utf-8?B?WGlIUXVIdXE1WTVvVWNNWThIZzA0WWg2NitBOUhzWWN1VmllblY3NTlVdnk4?=
 =?utf-8?B?aTJQbGI5VE5sYW1mV051ZTJNVUNNakZPZFR4MmdpRStLQW5mWGh5TDFySXk4?=
 =?utf-8?B?SXFOZmhOaS9uZjFoWUhaR2t0SDRvd2dsckYxM1dkWDU4d04rcy95WWdzMVFJ?=
 =?utf-8?B?Zm0ycGJOaUFqNzJwdjRYeGhYK0p1WkpITWNKbERMWjRmSEZNTmMxRlArbWZx?=
 =?utf-8?B?OTBxSXErOUVQWWkvTzR2UGFsT0VXblJtRGtWc3RpQlk0Y21TVGhsV3puOVR3?=
 =?utf-8?B?OFNkbXkramllRjZWbzBGcUpxUnNvd0x3U1lXQ1N4N0RqOFJtUjFWejBTRCtR?=
 =?utf-8?B?T1diQ2V5VFd5RWw5RmMwanlWY0E2aXNiMDRXVUV3N1cra2NjeGhrZStFaVdr?=
 =?utf-8?B?aUtia0VYYWhaNzF6a2VneXlIcG9PU2F0TXAvcC9RS2xYL0t5RFZpaGJoNmpJ?=
 =?utf-8?B?eGV1dEFDOVNhaXJZN3l2eEpNRTl6d202Tk9IeTQyUFlidUZrYWRLYjBBTWNl?=
 =?utf-8?B?Y1p0Qy8wQm5Yb1N0ZmVEWFN3cXRxUnk4b0F6RkRueXp2bnpIakxRRm5yZktn?=
 =?utf-8?B?aDVLV1Uvd2FsYVBmYUtGVlcza0M2b2lGdzBJK0Q5MHJRR0REVHMwVTVHN3Nh?=
 =?utf-8?B?VFI3cW9rcVdWaU5qYk1ZNFpPUUxSTkowemRudTZjeGQ0Q1FITk1lTkZVSVFI?=
 =?utf-8?B?TGlPOXFmTUZ2VVZuN3Rwb1RzUWgvOHBxbFJhRk9GbVV2Q0dEVjRPQlpNcC8z?=
 =?utf-8?B?dzFRaWRTcHBNT1hKVHc0Y2VhSnhrNEx6TFE5SE5ES3NNYlF4cWpCMlpmaEZG?=
 =?utf-8?B?VVgyeXBMOGxpOElkTmFuSGtVNVZRNXM3Z3pwR0VpSzRiaFd2SlV4V3ViS2g1?=
 =?utf-8?B?TnhGbkV1K3R1SC8vK0FsdVR3eUpoZGVjYVEreGxUUzl1V3BxNjN2TXFvaHdE?=
 =?utf-8?B?a0I0Rjl3LzRqN2I5ejdFczdhSCt5cDNQUkMvcGJ4akt1Y0U0OS9qSU8vMnhM?=
 =?utf-8?Q?FUzitz?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(36860700013)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:59:05.9432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3828660-796c-4f1b-7d0b-08ddc364b52f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10849


On 15/07/25 10:09 am, Anshuman Khandual wrote:
> The 'addr' need not be incremented while operating on single entry basis as
> BBM is not required for such updates.

"while operating on a single entry basis" should be replaced with
"when transitioning from invalid to valid pte"; BBM is required
for single entry updates when the cont bit is set, as described
in the comment immediately below. In fact, let us not even mention
BBM at all - the reasoning is that the code is written in a way
that, the loop incrementing addr, immediately has a return after
it, and it does not actually use the addr, so let's drop the
increment. It is not immediately obvious from the commit description
that the addr is passed ultimately to flush_tlb_range friends which
is involved in BBM.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/mm/hugetlbpage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0c8737f4f2ce..1d90a7e75333 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -225,7 +225,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>   	ncontig = num_contig_ptes(sz, &pgsize);
>   
>   	if (!pte_present(pte)) {
> -		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
> +		for (i = 0; i < ncontig; i++, ptep++)
>   			__set_ptes_anysz(mm, ptep, pte, 1, pgsize);
>   		return;
>   	}

