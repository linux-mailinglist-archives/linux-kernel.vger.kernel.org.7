Return-Path: <linux-kernel+bounces-887529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E303FC38742
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C016F4E5450
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A117BB21;
	Thu,  6 Nov 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hQ9eqGzl"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96603F50F;
	Thu,  6 Nov 2025 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762388394; cv=fail; b=dFoaFJF3qqLRyBVlfBWXHv71jiRW5mn7nqtkYC0ythZKLzBIbyMHEv9gXKpGZryo7thfwqQGNExLSbN5l4zvdM7pjHhS8CrHsDAegYchjS9VOicBtHiVm1glnmQO+ca6YE9jW4CUKtkqNb1KZSBjFzdlg9+lhsaPS2+mEQgk+U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762388394; c=relaxed/simple;
	bh=J0ySIykbhzeJQIfsxtEnNQrnMfdBgI93AnV5pTymmcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KxCljxqM4nUXOCSIW1GRM5HyfvOwAIcU7Kw0cleEPNDiOanyLalH+b/K07+jQmcT6doD8KJeZMbBynEW1wwCLsHdMUYtYXKVYUzrWWlCn7o+v3EPZdHD5uMfFTElSbSwnm90CxQQmIrEHrZyWUK7SUseWBNUVsETHpEdjmRBZ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hQ9eqGzl; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5KEZnKxkF9ybytb1zBFqoM42g1LNnnL7GK3bKO+rA6cX208/3rsROSZfYfUKwy/HjQGKjWWw0Qf3NsXWli2FCrhLl5UDvyAS4V9S5hlztLfiKjl0B69xv+qWEUjxjM99SNUE5z8HP5Ew4xlI22+fOIVVMzYZ6bNlWpbkxKz1Mf2tKb30NRlVff5F99wHH4e8me8U5Z0fhe6FNjXhgaps+O/reodMw3oUJG0OuRdRDEt3JgxjVjIiEV1tGTjd8v5Tq827XvYt6gpIyM5jtyIwRdpLKOmzkyWbafe6JyOjHP77ajEf13z90GXYMiPYQ63jMMD4znwKou6qyhQSHogdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbVXTEepWsFqoMtkutB3ZfPwR62hPC0Uo75DrP9EyC8=;
 b=cN5XcLvAhuM3JCVFzzccwcWUzym8bNlABDoQSkHK5uLOD8Rbm480AieXKFpWshn4jd15mnajv7psqJd+9IuRLRRZWEoeR8mlSagoan2n1UWw6VuJMccxPPVsJzx8TSz++HVibCqW/Ii7uruh9uoANDDRJQUUAYPpj4FuZApcGA89gRGy+7TuP/jWQnmaoe6t1z3uTqPkrM19UHOhlztDWo/dptjWtsaiYfdYHgtzpx5DnPyGc1RB8OYIRAdbNvWRTSTojL7f23OLSkm9cpcTqHYuBOXYEFqFHsPGedmDbN12wmstJB0egyLa1KYzQSRtkGPuecfbpHcK21DnC+itgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbVXTEepWsFqoMtkutB3ZfPwR62hPC0Uo75DrP9EyC8=;
 b=hQ9eqGzl6mD3MpmJUtyhQuFcdZzr+rpC1xzreYh8xtHwaxx/x//nOK7xIIIxTgeFUjpl0o8wOF+P3YonZNV5nPHtjivMsMf2m6HfRpJOWG2sOKa9kC3SSTUGeuExK2WkBf+w2pm1cSiL16l8h3f6i+FMoBqDjMi2Hi+n0pEue25dPiRaEpGv1rK6nflJ10aoSrXgBAJgzONvToGS0HUIGnku1nmh1cYYjgx+SwpF8/V39iAQ/EJQx79jCrGxuWyE8w0gJ/GoES020XZlyqm0qYcTO1JLl1yLtv0NnW5cSGIqg/97D+0mvGV6p68e39/5x8kbRsoeujuS+gkVhza+cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Thu, 6 Nov
 2025 00:19:48 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 00:19:47 +0000
Message-ID: <7107432f-4d0f-4544-9592-76a5e5c6d220@nvidia.com>
Date: Wed, 5 Nov 2025 16:19:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] rust: cpumask: Bindings for core cpumasks and cpumask
 iterators
To: Mitchell Levy <levymitchell0@gmail.com>, Yury Norov
 <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251105-cpumask-iter-v1-0-7536f906d7ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::38) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: b4247218-bcb8-43b5-be3f-08de1cca318c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNPTVk1UG9meGtiWS9xWC9DQkFhd29pNkVDMGxFTkpvamwrcjNIYlVuRWFV?=
 =?utf-8?B?TEFER1ZjbitERm1VVVF1czByMHdsY3BXTmtsVHdKYTNUdGUyV2V6ODZMZW1a?=
 =?utf-8?B?MURYUFM4N0FCa01OTlN5UG44N2NlcnBUZ2tHT1BvWUZlZUpFWTFsVGQzWjFH?=
 =?utf-8?B?ek5ycG9nL2RYN0hCWTlZRkdUTmF4OVNtc01MazBaSVFaNklQeVR2Y0hxYlgr?=
 =?utf-8?B?QmRrcm9FMUlrbU52aHNNMTQrWjR0a0xmR2YzNWwzYjVaY3liNitxT2c5MkJP?=
 =?utf-8?B?NGFCUkRyVTJNb1VoYzlTSmQ1S2dWL2QxVXJpWUh0aXlKSHFlUFNCY3MvVXha?=
 =?utf-8?B?bWswcjlVRS9aYjhmbER4TjlCVFdJN2xXc3lILzZDUWJkSUJNelB4SmVQcTND?=
 =?utf-8?B?bmtWSjh2aXRTdW5iaHRqUGlyNkdpRU50Uzl4a0NXc204VTJKTk5BMkJaUGlJ?=
 =?utf-8?B?eEtDWmpIbzhxVmlSZml3ZnFzZE81UVJta01UcDdtNnpudUZaRWpCSjdwTUlW?=
 =?utf-8?B?TEFPZXNvdFU1WkI5SERNZFI2eWtRUjlLNDNBd1BsYTVReE9JRjBpVVN2RzR0?=
 =?utf-8?B?ZDJ5SkdPSjhGYzl4dkhCTCt2NXlXWEhYNGxBNVlJZWpEODBUYVRWRkhMRzdt?=
 =?utf-8?B?V0FTYTBPci9ZZmVaU3M2L2s0dTJScW9mRDVtZFMrUTN6SnpWaXBxMCtRNlZ3?=
 =?utf-8?B?M2J1bzdxajd6cWY1NkVJV2EvOFJ2YUtVUjNUZndKTEwvN0x3MzBFVXlYenBn?=
 =?utf-8?B?amhMVWJIbVZZRUhWWXNiMWRsV2JVbisvNmhIR1JyUW4rbVJSVEFKeUsvR213?=
 =?utf-8?B?RlZhdDEyQXkvMDV5Y2djWDRqcXBRN0pabjRWWEtEMmNUek83Rlh4Nm11YzhV?=
 =?utf-8?B?RGo4akVjY1RHYWREWjBOcnF3a3BWbkdkSDl0bkhHOFQrTm5rSmduMWVOUks1?=
 =?utf-8?B?eFpUb2tsR3hHUDRvNmFiRmRmeThyK2lHYmZXSDdyR2Q2U3Q1OEM4T1pEZVlq?=
 =?utf-8?B?SU1UZmlTWkt2d3FyMU90YXBETC95WnJjZEcxZXR1SEt0L1krdkVjTFB2UG5a?=
 =?utf-8?B?S1NiczIyS1hnbThMb21BWTc1blQyalRtWDJxSWR6aXNZS2RGQ2RGOXdCcDhs?=
 =?utf-8?B?QUVNbDBzekh2V0VJSHRYRm1mQmxyRGlZZzliUVpkQ1piakVhWExTVk5DN3Rz?=
 =?utf-8?B?czZ4ZjhjV0xraUNNT3RQNGp3VUtyaGVBajVqSTJqbjByVWlvVzVpQmlpMEQw?=
 =?utf-8?B?TzJYbXFyRjZtak9NN2ZISVZCOExNMVpiNlVJYU8waG90VnIvOXBjTTVGYjdO?=
 =?utf-8?B?bG5LMHBwZTlhZE9ML2MraGJ0OG40VWlrSngybWtSOXpsdGttcUl4djQzQ2pl?=
 =?utf-8?B?azl2emV3SnVsME9xU2ZQSnRMNnFoK202Smd5WWpUSUN4dTBNM0JZZGVWRXB2?=
 =?utf-8?B?S1NySlJYdjBndTlEalRlTU0zeGJRa0NyeWxLMFA0MCtqUXUweWl6QVZXREl2?=
 =?utf-8?B?S2s4NnIxakcwTGxoZU5mZlZqR3B5YzNZUE5FMzNYQ1pybWN0OFRmMmFqYnNK?=
 =?utf-8?B?T0Z4TjAxT25vczByNTlja0lGQmdmTzl4bUsxazhNd0JTRmNEN1JUSVJDa0JV?=
 =?utf-8?B?bVI0Y25oQnZocFJ3VTdjRDd0c05xSkNhYTVrUm5Ma1lKTGhuaytEVVp3YkYr?=
 =?utf-8?B?Q0RFWENyZHVFL0lnOFJpS0hJdmtpb05ZTkkrNkQ3U3Y4RzAzYTBHQ2pnQm83?=
 =?utf-8?B?Vk1kcHdOb3pGNHRVa2FVZGdhTllrKzVPVEcwREorQ3BZUm9ORGZHaWRmUzNx?=
 =?utf-8?B?bWZaQjlOZGlKcXVaQWxtRHo1TEErN2hKa3RxSDNXS0JzejA2Z3pBbXVIaTdD?=
 =?utf-8?B?eTJSUStEdlZJai9tOEVaZmVUL01mS1ZZbE5KMFFFUVRjNElZQ01LMzI5bzkw?=
 =?utf-8?B?VWp1OEt0cU12RklTNFpsRlZSVjlLMHZnWWZoTFp3ZjNwQlNxZVpNMUtRTSs3?=
 =?utf-8?B?S0QyOVJSeTRWTmV6VEhKUDNETTZsaTNFOWY2Q1VxWGJLcmRxSWZnRkJSbXpO?=
 =?utf-8?Q?uPXTpb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE1YZ3F6R3N5LzV5UHAwNEJ0b0xGNFBSbkFUQ1l0ZktabHlNSldYeko4QWVh?=
 =?utf-8?B?MWswblNibW9QcUYrd0wydkw5U0c0QmhWaGdYTGZOUE5lZ2wwd1Q0clEvd3NC?=
 =?utf-8?B?NFViUmQ0Vzl4eHl6TzMrM0dsckZWanFRZEcvdEt5SDBWekVTc2NWNWRZS3RN?=
 =?utf-8?B?WmdpZCtwV2JGblRJMmUzVlE2bFltb2JzY0VQVVUyRnp1Y0h1aDZCN3J6RTls?=
 =?utf-8?B?blM0RmU1Q1U4ZnE4MHF0T0p4UmV1cnRkUFdQcGJhT3hkUzlwNmI3bUZCdWYz?=
 =?utf-8?B?L3JKUnp0T3lHZzNTZ1VjN0RqekxkOWZ5RXl0YlE2NzdzeFAvckJDRE1TbkZa?=
 =?utf-8?B?cmg1TCtYbS9ZRGlscGhKNmlzUDZwQTM1SWx0bUpLVTl3R2NqdE82NldaQ3RL?=
 =?utf-8?B?aFZoRkg0dURyWmhNZnFLTkxqUXZvY0g4UEFSOGRyZTBUeEdzVlNHckdYKzJJ?=
 =?utf-8?B?NFljSlhuR2VwTm13aW1qN0RHUFJqSnJvSFBoa2Z0U05XbUlQRW1LWC9ERm84?=
 =?utf-8?B?cHNodXlxZHQ5djBLZVovZGFhNVl1SlA1UEd2QkRqd1hpLzBuQVFOWTdnYU1i?=
 =?utf-8?B?M2prOHFBRSs1VVN3cGpJQnlvazhweldVY3JQT0xEeHlUTFpPbzJ0cEM0UWE5?=
 =?utf-8?B?Y1F1NFJ2ZmdIbzFqb0w0dkZmOWZRRnFpL2NBOS85Mm81cjd1d09MeGt0bUxa?=
 =?utf-8?B?VEtGYVp0bUZGTkhaWlcxVE5ncGdpNDNZeFlDZVA1OG5pOTdLTGNRTkt0VGpH?=
 =?utf-8?B?WVN5VytnNThTK1FwcXh3dThHRlB4ZEZTSFlHY1RHQ1dEU0g3WUdOakJvVVJR?=
 =?utf-8?B?THQ3NCtWWThTTEtaeUxJcjdBdkhmMnZtRXU2bWFSMkwvT3JETk9xUHBkQTZI?=
 =?utf-8?B?TXNBSW95MTZsMHpRNDJHQU5CMzlUYzFiYWFmYWFTdjB1REwrMHdjOW8xWUw4?=
 =?utf-8?B?SklKZmFnQ1RqZUtDbklNN1p4Vy81MnNMSEU5QTYzYnNQdk5Td21uak5xamhn?=
 =?utf-8?B?aTdGQTFqTXFVaDBaUlRzZEtTQjM2YzlqRVJMODc1ZUxrbWR2Q1ZPdlZTOEJs?=
 =?utf-8?B?UDVaRmJGUlBLbmswY3BVUWRTNHN1cGJ0SFk0VUNZWkl1QUdPK09IblhLL3Y1?=
 =?utf-8?B?N2pMVHc3TEIyQUpMR0hjL2N2QlVuVHZPVWtLWTFqUi9hOFZsZ0UxVm5yTUEr?=
 =?utf-8?B?LzZOS3EzSm13YS9lSXZWeUwyeEs5d3dDejhGdm00K0FZSytrbVZsU1psNWpC?=
 =?utf-8?B?MHhXYUNDWjloL0RBNiswQVVpbFRUMURTc2oxZVpyUDl2MENJcjBDbHdmdTRX?=
 =?utf-8?B?d3Z5c0hHaGh4M2p2b2ZtbXkzYUhqTHRoSnZKOE1tRHNsUkFWSWVXVDFSaUFk?=
 =?utf-8?B?MVpWYkVabWtoSUxFaUoxYW5jNUxBeHRVbE56TU9wTHRGTlBtcjR3dERXNGpK?=
 =?utf-8?B?Ym1Hd2F4UkQyTmtlVXVpY0NnWE1ocy9JbVZkRmxjWW9MT0pFOS9WQkdkN1Na?=
 =?utf-8?B?WmlGQjBNQVd5YkkySTVCMHphZFNHazV0NW56UWhLNUFBUFRjR01WZWU1c0s3?=
 =?utf-8?B?Z1FEcG5vSlhIWTlOZE9UcGU0dC9OcjNoSExyRStjZ0diWWtxQ1hqaThTU3dH?=
 =?utf-8?B?L0NmaXM4RlJydFQ1Z1R2QWQ3UDVBZ2p1SmJXcFFVOTd1U0xtaU55NXBad0J1?=
 =?utf-8?B?S2NhK3d2amhad2JPMklIR2puMzFBOXJUZHdEVU9xVzRsODhIZG8yRkg4RGJC?=
 =?utf-8?B?OE01TVc3NzRMaFFZSGNqL0JaRTBzalZ3dlk0LzlBa3praElaUVBrRzhHMmFY?=
 =?utf-8?B?LzNMUW5jWkFyM2RoUWQ4WFRrNndIWnZoNHdtaURwWStTRm1pbWltVXdwL3Nu?=
 =?utf-8?B?RG1SeHNNT0p4MlpjRXBmK3NvUWtPaS94RFlIWXU2UStMcUNpajNsaUFGQ3E2?=
 =?utf-8?B?c0x0TXRLS0VxN1doVUhkNm1EVnhsYndtVHA3VWt0NnNoK2NRamdhb1ZCWk0z?=
 =?utf-8?B?THdqNE5PT0RZQnRPUGN3WjBrWENCM3lZbVdKUFE5V2tlaXc0RzRRb3pNWURl?=
 =?utf-8?B?SEw4Nlp0eEEwV2EzcVppcG9NTm1JSXQrNm8wZnIxbkJvejU3Rnp1UDVuMWpz?=
 =?utf-8?Q?SNy+V1rYcvAWBX9y4Iv02X+Rn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4247218-bcb8-43b5-be3f-08de1cca318c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 00:19:47.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcnzJwfPORI51yMrMVs/3k1GkaHYzJxWa0yTxzjEAyhpCghIO+GSTpUbdL8mXtsYt5fUPnJsAeyDDlUigCyZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278

On 11/5/25 3:16 PM, Mitchell Levy wrote:
> The kernel provides a number of very useful CPU masks from the C side,
> including CPU masks for possible and online CPUs. In particular, these
> are very useful when some operation must be done on each CPU (either
> each possible CPU or each online CPU, etc). Therefore, it seems to make
> sense to add both of these functionalities at once.
> 
> Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
> ---
> These patches originated as part of my work on a Rust per-CPU API [1].
> Boqun suggested to me that these may make sense to merge separately, and
> it does seem like these might be useful beyond the per-CPU work.
> 
> [1]: https://lore.kernel.org/rust-for-linux/20251105-rust-percpu-v4-0-984b1470adcb@gmail.com/

Even though you are trying to get these two patches merged separately,
I think it's best (for reviewers) if you post a patchset that shows
these things being used. Otherwise it is potentially too unmoored from 
reality, and hard to be sure that it's exactly right from a caller's
point of view.

In this case, just posting that 9-patch series might work, and just
say in the cover letter that patches 3 through 9 are not ready for
merging.

Something like that.

I realize that Rust for Linux is being built from scratch right
now, but including calling code in a patchset is a really valuable
kernel convention that helps validate the code.

I say this for the benefit of others who may be reading. :)


thanks,
-- 
John Hubbard


