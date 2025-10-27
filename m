Return-Path: <linux-kernel+bounces-871469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F33C0D5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE49F4F3BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FC52FF656;
	Mon, 27 Oct 2025 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U0OzOie3"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E972D595A;
	Mon, 27 Oct 2025 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566341; cv=fail; b=tLHw0dafI/hbdruhgcdsJRSp/qpBpfq6obSi9CGgFRZyP+vot6482HzWlX+fsrDE4djWTLBmfTf1BaZJNg7NHm+vGKRFsbxk0wFTIu6CGuM4JkJn1qkBqflohRGtcrYwOAsLI8rrFxSb2sE/saoJc1kE8hGGZs1NXWIF1GhBk80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566341; c=relaxed/simple;
	bh=zVv/3KPca2cnwUFT8cbyw8SL2QKAJcWh+kiTvfXT8Y4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EvD49ssLGieNSYfZhnuSlKjoe55m88PxkFpC2kE9YN/IAMNw29mBTXNEjtfc5bzmrkhk4APWPzzzjWna1Yuj3BuTV/OiNSVVqixfcehL0dNCLZsFZ8QCDImKeb+fg3DT0mk3KupwYONH3RTU2lPmqC2l18ttHaFOU9wxI4txxEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U0OzOie3; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9sklPFSXZtZygqyQL724Bl0UACuAQlHhYF46pArJ9clAHynvMgnuB9Ilw401hPUz0qF4kDQamzqwpmmw296rpxJ9mzw5z+fJfXp2yTcvR/ZNs+/1Notz64pWQu/QIE+/Gh5QOvUKd7rHq251wlgc3vfGgxgU3f3fumY80QYgja/TFAHPUy9H379HAwjPCHGxjofcNIjRawOLrCpYD08jyPl61e7Wkmpr13jTpRBPH0Ljv2pm8Sr2HCFft+XFCDXAyAuxyWDjJlcbUUkLV0YGm97xiKbAa6kwlLkG0+r2CjEsJO4jZOduqDD/UnMGVqvA9TgJGxKciPZQfKbNdae6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ72XvfR+RPvpbRtsb0EQRjByckUtUte8Az1ZiB5YC8=;
 b=v7VPgNlna3jmxFtVoIGFFc6qraEB7hUTvyqe442n+G8xAHVpTkNScD5Mgv7vnK3tkFB2e8fxfJwtvVYfh0UVucs9CHwgCieZbzOhyZZdddMkkKJN8+1veuL/9XMwMB32EVz5hLxb7+MUBoUXputfcywQzR+hGjFd4X4RKgWAQvMafSZuXTBgSWVZrPSDuzuVvDH++RmOkgeok3fF+uZ8E/wbnm96HZosgPrjMcWyn+oGtuumBpG5lvanHl5KmlPUUhhZ5AHtNR2XGc5Tx3UjzpXe6kp4qwmJDNyIp1a5bH70X7CrFiwOSIth7I1P+iBnL+xjvy8mB3/Q109gORUsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ72XvfR+RPvpbRtsb0EQRjByckUtUte8Az1ZiB5YC8=;
 b=U0OzOie3tKMzgTERh/sQ3zJnLT11Qv47pyos6YzoPEqjit8H9IAzK8L/TdM0N5j752ut+tHvxpGMnJYHhnpfEM2NUyMJ65SxQsLigUyl+ffpxjc8jmDE4yvd1LgHPVbkP+/DVEsjCa9COQ71syThLlRGL9yBhpiYuMQnYO8bERNFlpCjThePd6dJ6yetNo8fUkjkv49mKIKgNIQ3YUBl6C9WLEIg+SYgnboTWISuJRWfVIdEOIHp9P3LT1UrbACgnMzQSJuhzFC+WqFUC26+ddiNSClPHtUDBgs5PBaBNKVr33Dw1M/4L3PHXsKcE0Wt8eIvuDlga/gLVCAceU9o+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BN9PR03MB6201.namprd03.prod.outlook.com (2603:10b6:408:11e::20)
 by PH7PR03MB6994.namprd03.prod.outlook.com (2603:10b6:510:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:58:58 +0000
Received: from BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e]) by BN9PR03MB6201.namprd03.prod.outlook.com
 ([fe80::6b16:5fd0:112:ab8e%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 11:58:57 +0000
Message-ID: <9d427a5b-952f-4140-bec3-e8f22b34985e@altera.com>
Date: Mon, 27 Oct 2025 17:28:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 0/4] stratix10: Add framework for asynchronous
 communication with SDM
To: Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Gong <richard.gong@intel.com>,
 Alan Tull <atull@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Gerlach <matthew.gerlach@altera.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250924-sip_svc_upstream-v6-0-c88ef68bf24e@altera.com>
 <aab92ea9-60a4-43e5-bbee-96484d15f3a7@kernel.org>
Content-Language: en-US
From: Mahesh Rao <mahesh.rao@altera.com>
In-Reply-To: <aab92ea9-60a4-43e5-bbee-96484d15f3a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::13) To BN9PR03MB6201.namprd03.prod.outlook.com
 (2603:10b6:408:11e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR03MB6201:EE_|PH7PR03MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee6acb8-5b09-47f3-ac3f-08de15503565
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWtGNndmUVBFd1ZzRWVGTWxhTmlXc3pRTFdiK0RHQ3R4QXBIMWtnWnZlMFMx?=
 =?utf-8?B?bWRIYVdtbVV5VkhTUW81d2xyTWl2V09mSjBJOFNFS0NjMlVQdWw3YlJES0RB?=
 =?utf-8?B?RVlzc3FqaTVPWHp4Tmd2T1pueWpnUEc3QlgyeXZKcXM3NUtERGs0eEpvbEVY?=
 =?utf-8?B?SnlqcDVZckk0M2NjaW1uMytDZW9hd1REbkhLNXhVVkgrQUR5WStMQmdvSGNW?=
 =?utf-8?B?RG9MblJaVXJzdkU1Q3BBVDBKSS8rc0JlcHhLRjFFWG9FR2lPblBkbWowSTNX?=
 =?utf-8?B?OTJZY2FIMitxdnBoc001emI3OVlzSy85N1BaSzBpa2lraDlUMlJoclVzVXhz?=
 =?utf-8?B?UFNsZXFDYXpqUzlWc2d6RkhTSllJZGdjS2dkWUp0YXNqUTViMUwxOFpPSEky?=
 =?utf-8?B?QzM2SVJZUm14cU9PTkhBQkpNdE8xRU5yS0swSENRN0xjNUFtKzRKUEVZejQ4?=
 =?utf-8?B?bjZiSndJcFRZQjQzZHZBWGNNeTRSTUZlYkY5U1drY0docDhicHE0Q1lmT2tC?=
 =?utf-8?B?cUtlcCt0alNsUzlFeGtWQkZHY3RtTVhYQW1QOW53cUppeE9sZFIvY1NSYVo2?=
 =?utf-8?B?THJkY0d4Q3FuQlNvOXFvSmt3UzF5Z1FKMFJzVlVEelMrMUVldFVKUUVIYWt2?=
 =?utf-8?B?d3VrMDNta1dhZ2hadzlqaUh3U3FMa2dITHRsV3FPcUYzL0xHejFnRnIzVVRD?=
 =?utf-8?B?VDFId1doMFptUkJQaUl2emJFeG1waUFySWd5cDV5RnBQbjJRMVltZmdMdld5?=
 =?utf-8?B?ZFhSQkpBcnVwejNadHZBYlp2Y2ZLY3UvWFlITE1FRHlFNGRJZ3ZtTHg2U1lw?=
 =?utf-8?B?UzFBUi9TdlpkK0JWcS8zak5wMDFLQkJGejBEMVU0cTZORXhlbnk4bXBteHNF?=
 =?utf-8?B?TkVBSnd6T1Rvc2FTYzFYWDh3cHI5N29Ma3JKWDlWNjF3NlhkbXhsK2lNKzRS?=
 =?utf-8?B?VzNkYXVZenlJOFJTTExJZlQzVFo2bmFqZEw0U0pGN3d6WG9IWEJlVGorMzNL?=
 =?utf-8?B?dENrRm5Kb016eGgzeDY0RFlNSTA2S2JINXF0WktBTE1VeStwVHpwTmQyTW1B?=
 =?utf-8?B?cTR0UGhxcTRXalFPKyttQ0JROVkreGtYN1dVdGNRdHVFQ1RRSW5JRU40cFVj?=
 =?utf-8?B?VEhWY2h1c2FyWG9vSVFlNWJ3STJHMmRvWXhLWjFXWVB1Y2RCMXl4dXJFL01E?=
 =?utf-8?B?aldRMnVhcWgyOTBJNXpEa0NxandQam9CZDNZazdBQjl1alAwZEc5VFJxSHp3?=
 =?utf-8?B?eWIycy9sQnd6RDRHbTJ5YnZuYWwrK0J4c2RLRHpZZDcwMXFwZXhtZ1NFV2Jq?=
 =?utf-8?B?dGZoYWd3cGYrTWl2V25xa0xjVzU4Y3pvRGVWUmx0NTFQMzBDYnJ2MC9JMlpW?=
 =?utf-8?B?L3RiM2JEVW5vRUNUQXN2Q1pic0hPRnlUU3M0bklzNFZCY2JpeFNEV0dHTGtE?=
 =?utf-8?B?RWxoaVB6TE5iN05tbjlNOVNBNTJ3ZERDTjhCbEVmMEhpek93TVludllnV2ZY?=
 =?utf-8?B?VTh4VFRjc0pYdmQzNFZINWtMNmJQaks2VlNCTWRIK29ZSWFseHh5RkZ5a25z?=
 =?utf-8?B?d1J6K21lZC82YmJnWTRhUWtJTE5aWkp5c1pPbEF3M2x0M3JGZGFYK040US9X?=
 =?utf-8?B?c1Z0MExiWjhEVDI3S2tUL0Jnc0M4dFFWUzkxUEtJcE5ick5JcksydlhyNjZW?=
 =?utf-8?B?ZW5sQjduR3JjbDR6bXNGV2ZWYktjb0hqeFBQaUJsWU1meFYvQlh5anlaWW90?=
 =?utf-8?B?V21oWm4vam15MjdBQkxJQ2d6cWttYUw3ZlkwQXk3V09mQUpmZFlOeG1PMFli?=
 =?utf-8?B?dzZnMW16L1lreEZ0bTVJMnhqcTdUVkk0aVZxRjZnUmFHRjd1SFVEZk15OHVl?=
 =?utf-8?B?eWZlWnBjVldGUDc3SDk0RG85QUJ0NEt5OEswVVNBUUI0b0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6201.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1pEZzg1c2MyZ3MvVmErMHdndVdIaVNTSGJBeS85b3EycU45MUpBMTNLZ2li?=
 =?utf-8?B?RUJUNEpTdjJTZnhkWmZpb0Q0U24rUFlDMFlHcFJsMmcxYnlrT3IyODlqRUY5?=
 =?utf-8?B?ckx5UHNsUkVqUFFxT0x2a0hFMm9aRU1FVHhRV2FKbXc4UFR5aEZPY3JKcHF6?=
 =?utf-8?B?cXVYNW45RDBmSmNsbDhqMGlsYng2emtoZHMzU2Zib2MvK2o5UGpSTldHNFQ1?=
 =?utf-8?B?emtCbzVQQU9xazI3NmhqQWZhNHk0ZzVRcVZZRmVRYVZEM1RWQU4xMldWVXFa?=
 =?utf-8?B?M0F4TnE3bFFYUU4xc0FmL3ZubXpkOXV4TDhEWVRFS085cEZKQVhmc1FRM0Q4?=
 =?utf-8?B?dnJaUE0wZDRkLzBxcUZUMmpPY2tkbklsV0Jvc2RObDMyaEVHOU5ZZ0pJSnhk?=
 =?utf-8?B?bjZlQUNVZ2VMSm8rNisvcmJrV2dOSDBWZ20wYXJocWFlVnNPNVNXZ3hTVnpT?=
 =?utf-8?B?b25ETUtVN2VtUTlUb1VDcHFOM3BDek90YjBnSk1ZaVJVQ2hSbzZHc3hyVHZG?=
 =?utf-8?B?M29wNjhtVUx1SEs2RjkxV0NscWE5Y3hxemtNODJpSHVHYnA5VTV2MFhQbWRl?=
 =?utf-8?B?U2xGdzRXS3MzUDhCSnNUT0twWlhsN3lyeXR5SS81WHlrWkdUUm5Zb2k4RC96?=
 =?utf-8?B?VW1mV1hmQVVjd2tHZ2M2L0tvMzNuaWdqZ2NqcC9DS0pmcE1YanNSSzIvZXBn?=
 =?utf-8?B?RE9YU2pWOHNRNDZMYmgwVkZxZjFvTDBzTWxJay9DWmlhRWQ2R2g5NVNHQ2h2?=
 =?utf-8?B?YmJSc3ZQNHVlZFBNaEZxd2lQNmVub0dtWDFSblY1L2lrUnNPN1BkSk0wR3pG?=
 =?utf-8?B?MEpRQ0FuZ2VSdGpGQkx0THhGZWFCdDNJMnpyWFB1aDlHNDJVMGFpOEtTRVJP?=
 =?utf-8?B?T1NvamJ3WUlCNXg3bFN4NVQwQ3k0T2lhT2NCK2JtVzhFa3lxTjVVcXZxNnJK?=
 =?utf-8?B?RTJHVmM1TkhqZ3ZFY083WUQ4Qy9QSGRoWUVTN0VNT3hISjdua21VbkRXUGFn?=
 =?utf-8?B?dnJmaGhvRnh1VTlrUURpb3JrTS9rcW9Vb25mditlWkRWQVJxSW9HdzJUSERV?=
 =?utf-8?B?dlpjdHdRcXdlajhTcXlndEZYUEpNVExpYWJNUUNoVWVyTXFpOUxINEx5U1hz?=
 =?utf-8?B?OHVPcFFnQXRQRFd0S1Q0L2lQcHZscmV5ZTk1ZG1jM1hDMWdNcWtTQ1BJSGc0?=
 =?utf-8?B?WGhhYjUyYWM1Y2VweHRUNzdsRE8rUmV0MHVQUUJCaHEwRjhCd01QS2pzT0FV?=
 =?utf-8?B?UW9XelFNVGNsejgvSXZ5dHNZNHNDK05qUlJXQlArV28rcFQyOFA4dnk5RS9z?=
 =?utf-8?B?dHZaY2J5a3U2UEFYbXZWcDQxN0pESTU2amRkbUk3VTR0YXVYNUVqSHN5V3FS?=
 =?utf-8?B?K1RsQWNVd05LQkNmQ21tV0VnbW95clZ1QmM0Qyt1RTBSK2NIQlBoZnJSUXBH?=
 =?utf-8?B?RlpqZkRwbUYwMHZrSU9GeFNOM0lnS2dvenR3Q1ZFa3VGRmtwWTN5VnVCKzRM?=
 =?utf-8?B?cnpwdkVkZ21qOHFUNFI1THlCT2UrSHBJUkI3cVlZbG9FUE9uZ09zeVRMTmQ1?=
 =?utf-8?B?TmtNY1IvQzBjK0dPQW5aT3ppZTQ4OHpwR1E5VUFyRHc4ZlA2V3NpdTVvczZt?=
 =?utf-8?B?NkRXZWUrci9FUTJvNTJIMzZzL3pWcHlRWVRZaCtQc0FLQy9MS1FoUzNYS2hY?=
 =?utf-8?B?T2RWVGhjN09zcWNZcGpXU0RZKzB6SHNkMGU1WXJBajRkRDFldWliN1o0aFRt?=
 =?utf-8?B?eWEyb1JyTmxJaFgzdjdrNmQxSzlWQys0d21kcFAxVVdnckdMeFNYNEZjQVlp?=
 =?utf-8?B?Nlp6N3VLNCt5ODJ3aFRBMVkxeWpZOTNEbXhOUWJwV3lhelA2Sk1nVnM2TXBq?=
 =?utf-8?B?Mlh2RnROU2oyTEFtd2Z4UTZmSHFrbE1rTWlWRk1PTFFOb0RNbndkTndzWUgy?=
 =?utf-8?B?VjdNb0Njam43amRNRm53L0hFeEJjTnNFUTFDNWl3cUgwWkppRWdITEttaURt?=
 =?utf-8?B?Wm9iTU5jbkR2ZzdsTzViVW91dE90QUUwZEFES2ZnY0dqZTdabkZjN1MxWTJn?=
 =?utf-8?B?WEpuT0RyRjJBeWdzL1kzU0s3ZUJmVC9HY3RCSWJvQ3JlSFRlVEZsam54Mk9P?=
 =?utf-8?Q?5mGIiyAf8YjVFR5JTI/UztGy1?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee6acb8-5b09-47f3-ac3f-08de15503565
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6201.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:58:57.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JI0BQgkqom6VKed43C+rQQH29lQbNk2b+UQv8E/KGE1Rqjv3xaFTe1+QGe9dXvCDom4vwnjdEJH0h8asLQcGEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6994

Hi Dinh,

On 20-10-2025 09:33 pm, Dinh Nguyen wrote:
> 
> 
> On 9/24/25 02:39, Mahesh Rao via B4 Relay wrote:
>> The patch set includes the following changes:
>>
>> - Add protection for querying memory objects in multi-threaded flow.
>> - Add support to generate and maintain message id and client id for
>>    asynchronous communication with SDM.
>> - Add framework to communicate with Secure Device Manager (SDM)
>>    asynchronously by sending a request and polling for response.
>> - Add commands for performing Remote System Update (RSU) operations
>>    asynchronously.
>> - Migrate RSU driver to use the asynchronous communication framework.
>>
>> ---
>> - Link to v6: https://lore.kernel.org/r/20250901-sip_svc_upstream- 
>> v6-0-b4db7f07cbb2@altera.com
>>
>> Changes in v6:


>> - Added support for RSU commands to asynchronously
>>    communicate with SDM.
>> - Migrated RSU driver to use the supported
>>    asynchronous commands
> 
> Can you please rebase this series on my latest tree:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/? 
> h=svc_driver_for_v6.19
> 
> Patch 2 is not applying correctly.

Sorry for the delayed response, as I was on vacation last week.

Sure, I will rebase the patchset onto svc_driver_for_v6.19 and re share.

> 
> Thanks,
> Dinh


