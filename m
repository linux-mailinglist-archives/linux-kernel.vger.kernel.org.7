Return-Path: <linux-kernel+bounces-756819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43444B1B9BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D23E174492
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D4C295D86;
	Tue,  5 Aug 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cl9luiiR"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2115.outbound.protection.outlook.com [40.107.223.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F02AD00
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416765; cv=fail; b=YZwWMZLIbf5PywJIEKO8TwiFoSG4pQUc6VVOZpGYVKWHwLmVfox2948QjAXJHGrcEl403Do7f2AFr9fmLSxq7TKXbAmRwkEWNIZ3LVhaKJpKe0cgE5LQxyw1fOHdS/zYpj2ZkzJQQjkb4gJmczSHt9ZT77VEppcAQ57V2UtyKFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416765; c=relaxed/simple;
	bh=672NRwkQobAL3o/LZbWpyzS1/r2Qmxd9M5FS96cCfkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X0pJcbKG6OB+rq7W6w7bn2o/tLBNXsTJO66J8Rk4JajZPhwaA/k3sX1R3rmhHV+6105rKIttNaGSRBG14TvsFClf9MIwHX/Ot4z4Q0yu0lbIy+7+NY2Fex9zWbu3nq0kvuFAJMYfGjo+YXETe8lcqjqMVeGG002n0htNFxt9+Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cl9luiiR; arc=fail smtp.client-ip=40.107.223.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUIcrp33zpBQ06k0Vwd3EOzwMHgC9bX3ksFww525Plrz8a19bMyV15eR/PvJNVCxwPFOQUi4Ugqc9Mv6FbNFnkR8Z51eP8Aer9LwaxVftPQQCenF2ostIsKK09VyHLhJLNWsPF0SRWpwBPEt4G+bu5WEjVX9JLm9p6cxEP6/es3aIBwt9N/eJWsYmPZ/7UHP/E9rjjEO2G0qqcpDVVmmlnUshtpeTt3pEMqGpBaERQm1KKbFOfdcvuwlQS2NAt6TBVrExJ+R38DTqpT89BFcGPfUWNzt285wSdrBqmT9ymCuczylwPCLP6geeul2gfFM9qBgpqb+TOxMWW1CAOyv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r13OSl9CjwM+Bs2e1kbl/bUXaLyJSOcvAgMjtXo2mtQ=;
 b=nuECoAU2Y0brRhtRxe5wCLtwLAV1w0ULb6u3h2ysSNGAa3wNdHfUMH44Wxapd/TDP/b9nRVUF4RrjPN2KoNJisV2dGo2w1/3AIcjHaGon9C1PJJnkMClA9IfE0uB5dwwZfr1zyr8AOg8ne7cvudBYQ5tSt7D+tdkS0RphDf4e7a7G7MG4D64SlnoVwZxdzgF3qS7Ob3D0xG6Q8pXeWAhAgkOrN+BiBxreV+/Ba5qlWzibHlOV3xt1lthWE7d+z4Z14C2CgMnqQDiiwoZu4NoD3LflV2989GV2WpZtyzEs7isxqC0hQvXO4zKq9L81ZAgcTWmjG0lvql8G70NbzVJnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r13OSl9CjwM+Bs2e1kbl/bUXaLyJSOcvAgMjtXo2mtQ=;
 b=cl9luiiRYlVhHMWNwh0p/6lfwW+gACjU9y1GYYuqcj4WaJw8YCG91Xda1sXm5na7/cIM0jBP1aYwWHMu1pSRXi/FUixd6CwKpGPBvGTf2CoxvDU1XTmQ5+DqmK+Ei84M8Uxn3ekhSu5ZcsEiIECar//5FFf2smuD6Z36P2InqXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6440.prod.exchangelabs.com (2603:10b6:510:c::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 17:59:20 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 17:59:20 +0000
Message-ID: <06e63282-771c-48ec-bcfd-b174e94d52bf@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 10:59:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-4-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250805081350.3854670-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: fd73fe50-eb47-4c0a-c239-08ddd449cd53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHRNWGw4YUJhR2p5ejdTRGVmQ3FyKytRTk03eDR1ZmluQmcwL25IZ0EvSmJ3?=
 =?utf-8?B?WHdhaHBnRWthdjlnUVNEZS9FSmlpNXFEWW0ycEFGZm5tbGZHR0xockxCdUJa?=
 =?utf-8?B?emFaMzBVUldqVHNRYWZPWjBvWlcwUmxxWERSTm1DVHdJelk3QzhmNktlVnFx?=
 =?utf-8?B?T1FHcWdjMnBia3dDbHFVcnNCbVZZc2k4Z2RDektWeXFmT0JlR25nQ2trWXRI?=
 =?utf-8?B?NjgrcXVmSTc2a0RCajVEY0EvYWtwNEV5QUxRa3hPRGpub0o1MERQSGRudDd4?=
 =?utf-8?B?MEZhVm5EdFpIS3RieUdvVENQZUh3T01VTTZmZVNmZGE5b3Bjc2V2UjY1V1ow?=
 =?utf-8?B?R25LWlpQV3gxVE81QjBWaTVqZVZ4ZmJSME96dGZqWXRGVSs4RWpacWJGdW5t?=
 =?utf-8?B?M2IzYXJWSG5ieXlSYnozd2l6aXZoY2RjT285L3lGcWx4VkthdmtmL3h5WXNX?=
 =?utf-8?B?YzJYaVpkVUxqcVRzOUF2NnpaRzI0NDhvS2RMLzNPNFZPNFNVdS9WeWg0L2ov?=
 =?utf-8?B?T21uV1RNbWZDclFTZ01zVXJKdHdQeHZ4SUY4bGZmVWIyVUtBK29YZmxkR0xj?=
 =?utf-8?B?SkM5ZXBrRy9BSndEdVNnSHBiVm1LaVNDS2xQbUdnMDl3eGZKcysvSmFxSjRD?=
 =?utf-8?B?aHZZc3BrL1VnMk5vQVp4OW1SL2Q1ekRHcE1TY2tFZU9tdG1Vd0xqRnNHVnNi?=
 =?utf-8?B?R1d0SVJkQmI3V2wyenJ1WUJmaEV2akVSVksxVmU1VlVWcDJBM0hwdHFKQmxk?=
 =?utf-8?B?dFk2ZU14bG1Gb3JBYXl0Y1ZRUnF5a1JnekZQS1k1aThITjQ1MzkxQUo1SkJt?=
 =?utf-8?B?Z3RkQitDZEVGTjRxaTJLUnhmbENRNUJFSm9GdXoyMFZrWGR5eXVyUmQvVmRl?=
 =?utf-8?B?RVdISzRQMHVUUktTVVJ4U0Z3bFFTbUlubkJrdVZoQndXLzNxa1hpQ05RR25z?=
 =?utf-8?B?bFNGWndmNXBvbGE3MElXNjhoa0hDelJUQUpsK045UWtqWm5Sa2F6T0E1c1FQ?=
 =?utf-8?B?UkZ0Z2I0WHRDb1J0cDFTS2c0RWU5MmNQeno0UmZjNHl1TysydlE0WDkwY04v?=
 =?utf-8?B?bjc5K1FEM2hZcGVKS1hvSnNwb3ROZndDbjhGRjdCZHJ1azQzdy92VEtrcHA4?=
 =?utf-8?B?Z1c0dndFQlkrc2pPdzYzTWQrSzdINlFBWStOTTIraUFabUJGSXNhU3RkUDhn?=
 =?utf-8?B?ZTliK1FCanNpd3JMTVg5ZjdqUVBjYlZEbzdFWnNjeXk2VmI0S2tJWW5zNWY3?=
 =?utf-8?B?WjIrckdGYk9hdFdGYUhkY1BKRkZOTVVpYmFTK3FrNHlmNndYRVJLZE1FNitp?=
 =?utf-8?B?ckhabEZ4MGZCWS9GYXJYK3F3dThIYUVYRVFiQ2ltSHZTVE9CSXpvSEttY2pH?=
 =?utf-8?B?MkMxNWJDRHR4SEdveGlrUFZ5MTh4eEdQQlNpN0N0TzZycFlVNWdtMHJVYVBJ?=
 =?utf-8?B?TGNLN2FyQ2VBZ2ZZTWdVRzNaKzVzOXpoNFVCa1A3RERJYWIrK2UyVmFaWUJh?=
 =?utf-8?B?MHZ3RTB0QkdSaHhHUUJMdFNLZUc1c0RhSmxOb1V4U2ZCR3pkeG5xdWNmaWN6?=
 =?utf-8?B?RG9sR1lYRGl3YWFqdEwzMUdpdld1WnN0V0ozT2ZtWm9lbUJxbC8rZVl3eldi?=
 =?utf-8?B?WS9WWWJxM2d2SEIvV2JpU3NGVG0xUUdkYUJjbEJUVUI2aGs5aUM5aGtTemJM?=
 =?utf-8?B?V0FzOGFHQVpPcXoyQmtNeVllY3BYaVVKdTJ1c2RLOGpHaVdyV0cyWjl1REFN?=
 =?utf-8?B?aW9CZXprK3NtajZkbzJyWkVTdzBGZ0JlMXNyWnYvQnJjRTlXSmRiZUt4Z05k?=
 =?utf-8?B?eWYrN3FqQkZGZzVpdU9pNDBnNStUenh3am5FczJxZWxXSG96blZFQXpvRzhB?=
 =?utf-8?B?NVFDaHBDaGdmdHhKdTRReVU4emZLUTVOejNFUVdNN2hjQlYzRkdFL21vMEJa?=
 =?utf-8?Q?AQ8Oyo5qrCE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWpaYm1KNFkrT3drT25oZ1RENGQ3WkVsNC9KdklDVGFsUUEyTG04MmhBaTJW?=
 =?utf-8?B?ZTlHMHg2UEVlWCs3dlRSK1I1dXhPUXJVdXBUWEdrYndrMEFrZVdyaU9iNDZl?=
 =?utf-8?B?ZkpyMTRWQjA2ZFB2WGxmOW1vdGVOOUNTWUhSdE5mWEZ5QU5pVDhML0Frbk9R?=
 =?utf-8?B?SEZPNTVRYjYwMDVhcHdSZjA5R2VKeVExMFRiTnVoN0JvdHhLZ0RkdU9ISjU4?=
 =?utf-8?B?TUg4ejF0TnkvRForQUJteGZtYVc1RmtjNlU1M3Z4b014ZEJROWZsOVdjU3kw?=
 =?utf-8?B?bXUyaCtZL0ZDdXRxbDBRUGg0U3BpVlpXbUtxbzB1QzRPc0N0VldmcldLRFZq?=
 =?utf-8?B?d3p1MkMweTQ2bWZBc1YzY1RiOEhMNi9xaTFMWjhscEg2Mk9TUy91QmZYdEpp?=
 =?utf-8?B?ZVJReVBGaTRHcWFndlM2aWZkWkZKZzhxa0NTQ0JBRmNTaVRPUWNrWWw0L1dP?=
 =?utf-8?B?MUtwcWpGTVIxbHNpbytnd010OUNVTGV1VHF4ZDlSMjlkWU5kUDF1b2x2ZTZV?=
 =?utf-8?B?SWN4VXUvaTc0YlNzWjhWQnVvYXZxWG5rSHk4cndxcXhTdytlQ3FtYnpiQ0NT?=
 =?utf-8?B?RmluSnQzei9HV29lQlJDb2xkbDNvVkRxVXlycWs2VlBBY0lKTkNXbUxZMWlV?=
 =?utf-8?B?UW9BVHNFS0FXanphd0VOOVdib2hMQVdpYytVZnJzWEFmQUhBbGtOSEV0TmZL?=
 =?utf-8?B?Y0V6cnZoZnZrSi9TTURiZ3hwN0NWL0o1K1J0c01OVVZnUHNnbE8vYUZXZ3pY?=
 =?utf-8?B?ZjVLeHZpZm16MkQ2TS9YcGtYMmNQUmhhMk0zWHJTT25vQlYwTFJtWW41a3li?=
 =?utf-8?B?VlJSRGlWUGt5VU4xVVcybVpBVW9YRWhadEkzb1BhQlBhTnQ4NkdTSkNmVEd0?=
 =?utf-8?B?V1FJZkZzaHYvRFpyc1A0bW5IRWdCU3lSUm51NXQwalVKWHA1Rkt0ZWl4cm1X?=
 =?utf-8?B?dFlxL01FRSt1RVZYZzVZOFJkWHlVZk5NQXJUTDh4ZmhzN2ZiRUE2dkozc0F3?=
 =?utf-8?B?V2hTMENLRlBxVUsrVHBLTmNoSjJ2NGt3aTQwMjZvdnQwdGN3Z3BJVStFcW1q?=
 =?utf-8?B?bWNwYTdsUEF6VnVlNHZ1MUowU0FOMFRVYTljbDhuWktpNWtBaGlkdWhVYkFX?=
 =?utf-8?B?WDlxclE5czNkQlZUNllTM1paQzZ5R1JFUkc3RUw3bmJSN0VLT2ljL3h3WnY3?=
 =?utf-8?B?aHZDdDhJMDhxdzlVa0FZQzNxcVNuTFBKREdiYUp3SkVFczI0bnRrU3BROHhm?=
 =?utf-8?B?KysvV3lEWGtFZU9UU3l5RDZ0clFCU09XMGFXSTBmUzBENGZ3c0M2VDUvMEEr?=
 =?utf-8?B?d2g1cElJSjVzaXh2L052TWZZOHM2UFBpNHlOMm50cnRXK2VDUWY5RXBGQVhm?=
 =?utf-8?B?MExYK0s2VndlSmZzSVU1bUxoN2prWUVGWU9wLzFXbHZHbXVKR1puMS9ZbW5o?=
 =?utf-8?B?TkZEN3pvemFxdEc1TkRmRGJSdzZxL2VGSy9PYnJzK1Q1ZUU5dmpHM1o0VEFa?=
 =?utf-8?B?SjFNdjhld0tFcnpEV0lEM0JXdGxDZHd1aUI3SWVkeEU0SXVYeHJZL0ZzajdS?=
 =?utf-8?B?U0VKMThDd25GVzcreGJxM3ZGamU0S3JKcGY0MlN5RFhUaERBWUdQZDV3ZG9n?=
 =?utf-8?B?TytxTjQybUhNZ3lKQTQwcVRxL2g1S21FSFRneUZENXZsMDlZTjFLdDZzNk42?=
 =?utf-8?B?MHlDa0JFQ2pWenlOQkYraTV3eEtSdFVZaXQ4eDU4RmRJOWlNa2JOSlVXOVI1?=
 =?utf-8?B?ZGFESDdTN1pEeFBvZnV5YTdabTJXdXlrT3ludTRTWTNPM2RTeGpmMkQ5QnFO?=
 =?utf-8?B?aHFadXdmTER3MTRIaHlzYUFVZU93MXhaQitWeVpIYVBNZjQyazZpZjdnTDVQ?=
 =?utf-8?B?UVBaK1c3RlNPcDhZbExHS1R0QXh2QktMbzVEaVNvbEFreFkyb0IzTlZjd2w0?=
 =?utf-8?B?UXc1VFJPZTNqdUl3OG5aYUV5R1hVc0VGbEFSSm9veHNxazVMSUk3Rk45ZmYv?=
 =?utf-8?B?QW9Gc2w1VDFjUjdwTEUrdEZYTnh5RGdLNEpXSEpPQUJNUFdSeUMvT1B5SS82?=
 =?utf-8?B?alVVSW9wSHR6Qm9PWHZFemFxVmNwdWUyWUVMZ2VFdzVKREFHYlBVQTRQWTVJ?=
 =?utf-8?B?RGQwc01Yd2RvYWtBaFVsT2UxMXFlZzB4aUdlTGJJckErTG5lL0t6MmxFbEVZ?=
 =?utf-8?Q?GypOatno1r3bInBDxrogySw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd73fe50-eb47-4c0a-c239-08ddd449cd53
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:59:20.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7HycrEoZzhfHZ1p0jvIOQ4I4UD5yd8sU8IZ6OLds1PZQkAFYI3YlUWrisuprkNI37lcy6eqA19R/N9FwB7ljIyKCBRWEP7NGRhOHgDTYQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6440



On 8/5/25 1:13 AM, Ryan Roberts wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
>
> When rodata=full is specified, kernel linear mapping has to be mapped at
> PTE level since large page table can't be split due to break-before-make
> rule on ARM64.
>
> This resulted in a couple of problems:
>    - performance degradation
>    - more TLB pressure
>    - memory waste for kernel page table
>
> With FEAT_BBM level 2 support, splitting large block page table to
> smaller ones doesn't need to make the page table entry invalid anymore.
> This allows kernel split large block mapping on the fly.
>
> Add kernel page table split support and use large block mapping by
> default when FEAT_BBM level 2 is supported for rodata=full.  When
> changing permissions for kernel linear mapping, the page table will be
> split to smaller size.
>
> The machine without FEAT_BBM level 2 will fallback to have kernel linear
> mapping PTE-mapped when rodata=full.
>
> With this we saw significant performance boost with some benchmarks and
> much less memory consumption on my AmpereOne machine (192 cores, 1P)
> with 256GB memory.
>
> * Memory use after boot
> Before:
> MemTotal:       258988984 kB
> MemFree:        254821700 kB
>
> After:
> MemTotal:       259505132 kB
> MemFree:        255410264 kB
>
> Around 500MB more memory are free to use.  The larger the machine, the
> more memory saved.
>
> * Memcached
> We saw performance degradation when running Memcached benchmark with
> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
> With this patchset we saw ops/sec is increased by around 3.5%, P99
> latency is reduced by around 9.6%.
> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
> MPKI is reduced by 28.5%.
>
> The benchmark data is now on par with rodata=on too.
>
> * Disk encryption (dm-crypt) benchmark
> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with
> disk encryption (by dm-crypt).
> fio --directory=/data --random_generator=lfsr --norandommap            \
>      --randrepeat 1 --status-interval=999 --rw=write --bs=4k --loops=1  \
>      --ioengine=sync --iodepth=1 --numjobs=1 --fsync_on_close=1         \
>      --group_reporting --thread --name=iops-test-job --eta-newline=1    \
>      --size 100G
>
> The IOPS is increased by 90% - 150% (the variance is high, but the worst
> number of good case is around 90% more than the best number of bad
> case). The bandwidth is increased and the avg clat is reduced
> proportionally.
>
> * Sequential file read
> Read 100G file sequentially on XFS (xfs_io read with page cache
> populated). The bandwidth is increased by 150%.
>
> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/include/asm/cpufeature.h |   2 +
>   arch/arm64/include/asm/mmu.h        |   1 +
>   arch/arm64/include/asm/pgtable.h    |   5 +
>   arch/arm64/kernel/cpufeature.c      |   7 +-
>   arch/arm64/mm/mmu.c                 | 237 +++++++++++++++++++++++++++-
>   arch/arm64/mm/pageattr.c            |   6 +
>   6 files changed, 252 insertions(+), 6 deletions(-)
>

[...]

> +
> +static DEFINE_MUTEX(pgtable_split_lock);
> +
> +int split_kernel_leaf_mapping(unsigned long addr)
> +{
> +	pgd_t *pgdp, pgd;
> +	p4d_t *p4dp, p4d;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +	int ret = 0;
> +
> +	/*
> +	 * !BBML2_NOABORT systems should not be trying to change permissions on
> +	 * anything that is not pte-mapped in the first place. Just return early
> +	 * and let the permission change code raise a warning if not already
> +	 * pte-mapped.
> +	 */
> +	if (!system_supports_bbml2_noabort())
> +		return 0;
> +
> +	/*
> +	 * Ensure addr is at least page-aligned since this is the finest
> +	 * granularity we can split to.
> +	 */
> +	if (addr != PAGE_ALIGN(addr))
> +		return -EINVAL;
> +
> +	mutex_lock(&pgtable_split_lock);
> +	arch_enter_lazy_mmu_mode();
> +
> +	/*
> +	 * PGD: If addr is PGD aligned then addr already describes a leaf
> +	 * boundary. If not present then there is nothing to split.
> +	 */
> +	if (ALIGN_DOWN(addr, PGDIR_SIZE) == addr)
> +		goto out;
> +	pgdp = pgd_offset_k(addr);
> +	pgd = pgdp_get(pgdp);
> +	if (!pgd_present(pgd))
> +		goto out;
> +
> +	/*
> +	 * P4D: If addr is P4D aligned then addr already describes a leaf
> +	 * boundary. If not present then there is nothing to split.
> +	 */
> +	if (ALIGN_DOWN(addr, P4D_SIZE) == addr)
> +		goto out;
> +	p4dp = p4d_offset(pgdp, addr);
> +	p4d = p4dp_get(p4dp);
> +	if (!p4d_present(p4d))
> +		goto out;
> +
> +	/*
> +	 * PUD: If addr is PUD aligned then addr already describes a leaf
> +	 * boundary. If not present then there is nothing to split. Otherwise,
> +	 * if we have a pud leaf, split to contpmd.
> +	 */
> +	if (ALIGN_DOWN(addr, PUD_SIZE) == addr)
> +		goto out;
> +	pudp = pud_offset(p4dp, addr);
> +	pud = pudp_get(pudp);
> +	if (!pud_present(pud))
> +		goto out;
> +	if (pud_leaf(pud)) {
> +		ret = split_pud(pudp, pud);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/*
> +	 * CONTPMD: If addr is CONTPMD aligned then addr already describes a
> +	 * leaf boundary. If not present then there is nothing to split.
> +	 * Otherwise, if we have a contpmd leaf, split to pmd.
> +	 */
> +	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
> +		goto out;
> +	pmdp = pmd_offset(pudp, addr);
> +	pmd = pmdp_get(pmdp);
> +	if (!pmd_present(pmd))
> +		goto out;
> +	if (pmd_leaf(pmd)) {
> +		if (pmd_cont(pmd))
> +			split_contpmd(pmdp);
> +		/*
> +		 * PMD: If addr is PMD aligned then addr already describes a
> +		 * leaf boundary. Otherwise, split to contpte.
> +		 */
> +		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
> +			goto out;
> +		ret = split_pmd(pmdp, pmd);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/*
> +	 * CONTPTE: If addr is CONTPTE aligned then addr already describes a
> +	 * leaf boundary. If not present then there is nothing to split.
> +	 * Otherwise, if we have a contpte leaf, split to pte.
> +	 */
> +	if (ALIGN_DOWN(addr, CONT_PMD_SIZE) == addr)
> +		goto out;
> +	ptep = pte_offset_kernel(pmdp, addr);
> +	pte = __ptep_get(ptep);
> +	if (!pte_present(pte))
> +		goto out;
> +	if (pte_cont(pte))
> +		split_contpte(ptep);
> +
> +out:
> +	arch_leave_lazy_mmu_mode();
> +	mutex_unlock(&pgtable_split_lock);
> +	return ret;
>   }
>   
>   /*
> @@ -640,6 +857,16 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>   
>   #endif /* CONFIG_KFENCE */
>   
> +static inline bool force_pte_mapping(void)
> +{
> +	bool bbml2 = system_capabilities_finalized() ?
> +		system_supports_bbml2_noabort() : bbml2_noabort_available();
> +
> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> +			   is_realm_world())) ||
> +		debug_pagealloc_enabled();
> +}
> +
>   static void __init map_mem(pgd_t *pgdp)
>   {
>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> @@ -665,7 +892,7 @@ static void __init map_mem(pgd_t *pgdp)
>   
>   	early_kfence_pool = arm64_kfence_alloc_pool();
>   
> -	if (can_set_direct_map())
> +	if (force_pte_mapping())
>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>   
>   	/*
> @@ -1367,7 +1594,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>   
>   	VM_BUG_ON(!mhp_range_allowed(start, size, true));
>   
> -	if (can_set_direct_map())
> +	if (force_pte_mapping())
>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>   
>   	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index c6a85000fa0e..6a8eefc16dbc 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -140,6 +140,12 @@ static int update_range_prot(unsigned long start, unsigned long size,
>   	data.set_mask = set_mask;
>   	data.clear_mask = clear_mask;
>   
> +	ret = split_kernel_leaf_mapping(start);
> +	if (!ret)
> +		ret = split_kernel_leaf_mapping(start + size);
> +	if (WARN_ON_ONCE(ret))
> +		return ret;

This means we take the mutex lock twice and do lazy mmu twice too. So 
how's about:

mutex_lock()
enter lazy mmu
split_mapping(start)
split_mapping(end)
leave lazy mmu
mutex_unlock()

Thanks,
Yang

> +
>   	arch_enter_lazy_mmu_mode();
>   
>   	/*


