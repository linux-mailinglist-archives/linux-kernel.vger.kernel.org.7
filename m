Return-Path: <linux-kernel+bounces-785455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE06B34AED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038445E61D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A9F283683;
	Mon, 25 Aug 2025 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LR1eSCA4"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2107.outbound.protection.outlook.com [40.107.116.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AE721FF25
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150413; cv=fail; b=swfpR2soDIpoN7Oo0+b0yydSsXrPF1ROLjvm2QhLf/c5Z7tui5f4pZEvgrvmJKlK+Iu24m9Bp1RhPReXjwQ5zxlB26qPiU/wGq+ocRL7Xi93EHrFvKIh0b7K4UgsglsV/xQvrVi9mI2HRE2h556ze8HUzJ1b4vh8G0RDanWhNLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150413; c=relaxed/simple;
	bh=//mJkXVpKDEr1RpnZNIfsiIIfbGUlmq0Yk/omF1JJZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NiWJmKlj0ckH7YrLtP3M105DFab3m6fBtdo4wKAIVWqktQ9bPK+jtakOS8nw+3wq1zE3E6ZEmqgh9cDkET9bp/OaHdULJ138Q5k7qqsTVnf+x1q34uLZGofEXrLSuQmLc9BCLXHgae5bNSxAsoFsNuysIOGMrx4eygMlmghPejo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LR1eSCA4; arc=fail smtp.client-ip=40.107.116.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK3STZmP3sQCl3jZB/7NrsMigZjKmMeH7jU0YhUNxUKPw/3ZImuahaSXx58deG71Yi28KgNj7uRNWM7ymKW2FOhMIG2zDv9u+//0AUaI//0BYrkGRkDwf8O6YQSkB//B1ZHtxakeeoA0y8WHL/XyfvjCKd2CObg2SSQ8x+7TPzDy2v52Cbixy/QVojT7TUgPMkG6hLohSGaAMqWxValLKDtMa5A021bAnaMcsP+c3N9XUFcZ4yNYhrpnp77LVuKWiqYujcP6y7DoL6+/5rLtpKOrPBpooImqIX4mPT/2tNHF1C2sxb+YzUTS9yzWBvpUnIetOKDYjEcDnRsjm2EwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3tFWYFWscegcr9F8eou8Aog90xmXQyIEB87tjWbNl8=;
 b=iMgyaqJiY3/5ytHfb58FiqrBjeTifERu8BZ1vGT/k9pCV0a7hXyLOq4CCMLUMXi4ppMgIAuPhnw+DgzLqd7JwkQHUJe8CMgfryflapS7Gq7xPYq7zTrmXSSAss70C8unZZrt88doRAQyxFR37KB/rL8NAEbZM6kfve4XzrX0uAu9yYaa6tf4iT3QA5dymBIObfxrWULl6gyRAHplg/PGhLvjFq9Jc6d9cgiYQQnv4ecGSltW59ujAaJPfY6ARYyCtqqzWELvIhC4tiSjOcnl2u5EKSgOmrzircXXna+7lv9akP4lb5BQyJXDaJnOIhWrn/FhlF5Bmd2doYBaHm1gkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3tFWYFWscegcr9F8eou8Aog90xmXQyIEB87tjWbNl8=;
 b=LR1eSCA4HTFyyozKP601oY9ZMQCfAJIiKEZ7NY1dS4mAaebH2HWZSevg7KHnA24dmcXxMj0PwjifQYavV0znCHVvnLhNXLJqRbyzhYur9ZRWKieYqn+n2SCpsnSCLA7Lx/7Bn8DXL9cSs74sUznqOlHt7Yeo4TtwbtLipnltJRGJ45jAPGUlEydgq0VK3OUYopeOw+vFETisMogjxv2GLzsYru/12ZOFvIaBmG38+mwnXDt7mJ+SgRRU0mR/yJY8Yc+W+iEW6EbPsdNMplyd5tveAD7NHQ/hePOPwxkHqd8LrStFckwYQ1ibOswOwMW8Muvi+PzEaEA8le6fqVOE+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB8777.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 19:33:27 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 19:33:27 +0000
Message-ID: <ed52565a-be0b-45a7-a838-a9c6f8d5359d@efficios.com>
Date: Mon, 25 Aug 2025 15:33:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 31/37] asm-generic: Provide generic TIF infrastructure
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161655.256689417@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161655.256689417@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c90cdb-9955-454e-3c82-08dde40e4365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFRhMlZTQ01qc29vM0ZZZ2pXM3h3MGlkcUltSWRyWVF3U3RiM1oyZC8xaUZT?=
 =?utf-8?B?QzRsM0VTV1UrU1ltMFl6Q0wwbnR1R21sRlRHSFF2a0pVVmQ5OE81b1NCNWRI?=
 =?utf-8?B?WVNnTXRYUnlHclZmOEQ3d3RHdHhiSWlERXZKVmEyV1E1RHVyeU5FUUdCaHdt?=
 =?utf-8?B?QWY2M3dpZ2xENlFWclBKTWl5QmFiUW1wU2JPMmxBa0NobDlOdmoyNnVjUHJi?=
 =?utf-8?B?MkpOVkNpOExjVCtwTXBqcmsrYjkvVUMxNTdPQVluMUh0RFlKQXRUUktQYTdD?=
 =?utf-8?B?ankzUkJkakxSTE82UitvSTNMNjVTSkl5RkVpdW1VYVR4cVNpeDFuTUpvRHFS?=
 =?utf-8?B?UURQT2REeDFuYmU2MWVubWRLbUxSL0w2TlhmRjVRSS9aUFlIc2tSYnFsbVFx?=
 =?utf-8?B?clU1a092RE9wQU9OUC9nWEdhOTE1SVRTYkJpOUJmVXpwNE5COXpGUDJlM3Mw?=
 =?utf-8?B?WmtKTTJWaU1hbmh3Kzg0SUhCL096YWhYNnBVbTdyWGFueUNJcXRWdWxRSlo5?=
 =?utf-8?B?c0pWcGJMbUV6RE9OMDkzZmdpbXVqU0ZNRHFhbzVWK05CWWo0cW1IRjdaWlFz?=
 =?utf-8?B?dGNvUThvQTI0dnl3QkFFSTJNb3k5NmNIMmF3Ymh5MDFjY0E1TlVUVUZJbzly?=
 =?utf-8?B?UUNhWjVJRFBvR1o4NzhxRFFETHBNSVI2c0dCSnNLaHNyeDUwRVBicy9kM0dV?=
 =?utf-8?B?UWJEU2ZhRWpJbXhhdnp6ZUJsd3NiL1gwY0RQQ3g0bjlYUHZzU2FIQm1SWDdJ?=
 =?utf-8?B?UE8yQWxCVVBBQjhPSVJvbWo1RnRDT2JkTFhyQlgxVTB0b3FhbHdxZWFIZDBX?=
 =?utf-8?B?NjJ4WDRYVmt0THVZcGpHM01Ha2V6MkJwQk9DT2hhb2w0MkpwbVQ4cGVkVTh3?=
 =?utf-8?B?RXJoYU9IUzhMN1EzMkdBVTJocHB2TFMwMEpVSXhOSFora0NoWFBOd3llTWwy?=
 =?utf-8?B?SnZIUDRvK0gwcTN5OExNM0ZaN1BnSXlEUmZBWk5IVXlKTkExS2RoRXlyVmxW?=
 =?utf-8?B?RE9qOVNLb0F5dFJybFJZcHpteThNWmpZVkM3M1hPeDBvWENiUEJNN3B6RTdS?=
 =?utf-8?B?Z0hudHdYN2JGRWVYR2EwWWpoZlFmZzhIUHlaMFRNeStiMmlXSnQ4VFdtVnBB?=
 =?utf-8?B?eGFPWlZWOU5DYVJTSUV0VzFkRGxZeUJqa0YrRFZlNVZoVFFJWThyQTBpSnNs?=
 =?utf-8?B?OGtqeS94MEVjNGNpdnBHOEh0cWhmUG1YMVp0WVlPVzdCdUUzME5vQ1Y2R0FZ?=
 =?utf-8?B?MWYwczlLdUhTVmFuZGxNTDJjTXBKUHNXKytHYks2ZGd6TERsVmJwRWhENk9R?=
 =?utf-8?B?Mm5DYmYrL3hqOWVIc1ZuQUhQeFVPOWJ6blY4d0VFdkNsN2phUC9MWDlJcExT?=
 =?utf-8?B?aXhYUTU0cUV1UDQySHhvbkYzUS91ZnRVK2pqL1BVaG53OFpqUC9ULzFmc2l5?=
 =?utf-8?B?MEVpeVFhRXVYSGZ4RG51Q3RvcWV0WjZ6TEdEMGRFOEF4UXZiUHpiTW43OGlF?=
 =?utf-8?B?MEV5SGFaSDYyUTVwOWpoR001UDhyeElLZFVhY2JERTNNK1ltd3NzaUVhRysr?=
 =?utf-8?B?dmNYSVdwcFRVSzUzdnJWSUhScmdLcnhZNGJoM0NnblhhNFY4Y1g3eFZLcU9Z?=
 =?utf-8?B?Tm1INlpMd2dWaE5lejN2cVdLamZ6ZmNMWVE2V3lIS004T05FSm11SCtmcnpG?=
 =?utf-8?B?TndQRnpjaWpKVjFsbkYrY3hOaDFGckw0bEtvczNXcFdiNVprTUhkUk1COUR1?=
 =?utf-8?B?dE1GNkVSdjdTdExCZlR1RTFYWDU4R1hKY2VSWUZIU2VPdFY0N1lTY3kzeDd5?=
 =?utf-8?Q?ug8ffweUGEgEHPwxX0Qs5t13uZepU67YD7tYU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFlydjlsZWRBdzJQZVZtd2FVTWVPdXU1QisyVlZxTTFmNzUwN241d2svWmw4?=
 =?utf-8?B?aW9vYmw2SnVWM3BQNXhnSlpiWEltY25IVEUvb1RaT2krUlo1RVNnMlJVQ0Va?=
 =?utf-8?B?cTJsVUNvNnpEemlseUEydVpXUHJOSno4MStMOFl5NzJnYnp1K2Q1eGZnM3NT?=
 =?utf-8?B?bTE2SXVHWVRmNkVLNm5qelYvS3crT010MENCSzNxaVVQV2szQll2UEIwMURN?=
 =?utf-8?B?Sm9DVEdJaTdVejJSWUc4K1ZwQ1JOdkdTTDgybHFCSmV2YWpOYjliQ2hTZERs?=
 =?utf-8?B?Tk4yclJuNFlOYlRLNVJqSzZXSUk5Q3I5bG0vNGIzZUFKeUNrSEVFRmh3cFlu?=
 =?utf-8?B?aVE0M0oza05NclQ4QXFRNk1EaUZOYXZGVDl5VTRhR2xtbG1sM0ZmVW9ndERR?=
 =?utf-8?B?dnFlald5alZjRVVHRVd6VVRVS1hwZms0UE0yVVZXSURhRE5mUUlCTTBZeG9s?=
 =?utf-8?B?NHc2VU85YytpMys4WFVPUmVzY3Y3K3I4OVRZb1lQeVlEUlZlZlI3RTUrQXRX?=
 =?utf-8?B?ZDZwN0tJNEYzODNzWk00UkhJMDlqa2s1cVZvM0haeW5wU0E2VUZDZnlHSGY1?=
 =?utf-8?B?VWVtZDZ6OFNTN3hUT1B3aVcyNzV1c0JXeWJYUThMTmY3TVRPbVNSa3NpeGpx?=
 =?utf-8?B?UW9IS2tWU0I2MkwwT2FiR1VMUUtxRXdJbGJaOUtGbVU2WUtvdVNnSStJUVNi?=
 =?utf-8?B?dnl2V0tNd3RGc0kzQUxOaDZRdXpOckEydlpERGZaZklUQmR4alEvVUNDVTVa?=
 =?utf-8?B?bnpPRnRQeHRubHRVaU1MTmU1MGlETkRFQ0xRbnVuTjVvLzVGNHcwVHRRa3ZP?=
 =?utf-8?B?OWtTdFU2akF5bzVoNTJCSkUyRC9FWHVTV3NscWFqcy9tMmRwdDJZM00yODk3?=
 =?utf-8?B?eVl3NVFKMUw1aVhXdmFlNk00eDdaZjFlM0JLM2ZVK0NnUEY0ZzBreTB2VFZK?=
 =?utf-8?B?emZHV0NrZEVWUlc0eXZBWDBsZ2Y1c2cxV1RKL3JmakdHVmoxK0poaDB4cTVu?=
 =?utf-8?B?WHFOMWRlc1p0dkhuRkhOYTlqN2dzT3BQak5mLzRmb2QvcXFGWE9PR0FVNnpr?=
 =?utf-8?B?WDUyOEhpdFZ6RmV6bjFmYUVCWmpONzRwT09RbmZtV0tnUG1VNjFvUjNpQjlQ?=
 =?utf-8?B?R0RoVWVRZUZhWkphei9wV0w1dDR5cjZER3NGbnJmQUppZ2RuMzRCQkQzeHFS?=
 =?utf-8?B?K0RYY256N2lxdC91VE01N3ZCQ1NWQnpsaDJ2N0pPb3BUZm1RdGpCbjNnOGJ1?=
 =?utf-8?B?czVlamw1bDVPYXF1OU8zb3RMLzVtZElsRGUvQ2V2N3hmZmNQZ0FLejJoODdx?=
 =?utf-8?B?TW5QU3BXdjk3cGFSUDhObURqQ3BCaFVIQXhKUk1taU9NWWdablNXZ1l5UE9O?=
 =?utf-8?B?SjJoeTVjOWdTckxrNkV6ei94bjBNV2d0MjkxOVBtRW50aDVWbDdlTkRXSkNC?=
 =?utf-8?B?MXU4QmtjR1QyTzdqQ0FMeUt5NDQyVjhxR09IZUUrVXdWVXNZUFdSLy9BR21U?=
 =?utf-8?B?cndQMXc2RG8yN0wxUUE3d1IzWGpVcEhlT2hId1dSQmZaSnRFRlFnd1Fqb2t0?=
 =?utf-8?B?dmhybVNBb1IrRjdhRXEvVURpYVlTbEtrd1E4NmFPeHk4Q2dwNjh4UnVEOWJu?=
 =?utf-8?B?ak9YZEphdkkrNlVFdDRMNGx2YzZpZDZLM1V1M05LY0JEK1JjRUhhZXg5OUcw?=
 =?utf-8?B?dmpkRTFBT0pHSUhYeWpyLzh5RE9HUHIyYk9FcUp5aE5HYWI4WC95TElvZnJu?=
 =?utf-8?B?UlYzTDNuc3l3T21CMVA0VWxRNFRYS0pTNDRpVlFWN2JmcVg4dHZLWUR3OHBT?=
 =?utf-8?B?cDR3QXlMZ05MMGRnS3BjNmRJWHcycjlCRlVsYTlpeDhqRjhoZG96bk5HdzZ6?=
 =?utf-8?B?NllSdVJQMmpaejZqZnJYUDBKNlIxWmlYWXRMQnhrWWFkMmMzQ1RwTXMydWl0?=
 =?utf-8?B?SW9wa2FGQlN1Z1RUQTJ0R2NXSUczRHYyZHR0UzYxOHlpZXlrVWJwdnhMQjRr?=
 =?utf-8?B?RW04d2xZTXV0V1psb0ZlTjZoeVh2SW42WUdTaG5WM3BuMkUwc0gxTWpJRFRs?=
 =?utf-8?B?b2lZSXErZ3BDb3BEbTUxUHU5aFpMbDljbDlqSDlvRW4zdG5SQ3d5NUxTbWl4?=
 =?utf-8?B?VFB2SUloa2lhaHVOdkVKSmhSQUdMeVpYRnRURnhham9Nb09ocHR1RnVZTzB2?=
 =?utf-8?Q?Q2FhDdB5nOhP0FSpmDrbQs4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c90cdb-9955-454e-3c82-08dde40e4365
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:33:26.9545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82S8b4XIa7cL22+TS14S8lGnR1FOMlgC/edmiy0B9VXnxCCLtursRkXnN/pqRLJ1aeNuwnyVOwJ0m+mlAaYYjMj7LIpd7cgIaC4AL80RNBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8777

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Common TIF bits do not have to be defined by every architecture. They can
> be defined in a generic header.
> 
> That allows adding generic TIF bits without chasing a gazillion of
> architecture headers, which is again a unjustified burden on anyone who
> works on generic infrastructure as it always needs a boat load of work to
> keep existing architecture code working when adding new stuff.
> 
> While it is not as horrible as the ignorance of the generic entry
> infrastructure, it is a welcome mechanism to make architecture people
> rethink their approach of just leaching generic improvements into
> architecture code and thereby making it accumulatingly harder to maintain
> and improve generic code. It's about time that this changea.

changes

> 
> Provide the infrastructure and split the TIF space in half, 16 generic and
> 16 architecture specific bits.
> 
> This could probably be extended by TIF_SINGLESTEP and BLOCKSTEP, but those
> are only used in architecture specific code. So leave them alone for now.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   arch/Kconfig                          |    4 ++
>   include/asm-generic/thread_info_tif.h |   48 ++++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1730,6 +1730,10 @@ config ARCH_VMLINUX_NEEDS_RELOCS
>   	  relocations preserved. This is used by some architectures to
>   	  construct bespoke relocation tables for KASLR.
>   
> +# Select if architecture uses the common generic TIF bits
> +config HAVE_GENERIC_TIF_BITS
> +       bool
> +
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
> --- /dev/null
> +++ b/include/asm-generic/thread_info_tif.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_GENERIC_THREAD_INFO_TIF_H_
> +#define _ASM_GENERIC_THREAD_INFO_TIF_H_
> +
> +#include <vdso/bits.h>
> +
> +/* Bits 16-31 are reserved for architecture specific purposes */
> +
> +#define TIF_NOTIFY_RESUME	0	// callback before returning to user
> +#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
> +
> +#define TIF_SIGPENDING		1	// signal pending
> +#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
> +
> +#define TIF_NOTIFY_SIGNAL	2	// signal notifications exist
> +#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
> +
> +#define TIF_MEMDIE		3	// is terminating due to OOM killer
> +#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
> +
> +#define TIF_NEED_RESCHED	4	// rescheduling necessary
> +#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
> +
> +#ifdef HAVE_TIF_NEED_RESCHED_LAZY
> +# define TIF_NEED_RESCHED_LAZY	5	// Lazy rescheduling needed
> +# define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
> +#endif
> +
> +#ifdef HAVE_TIF_POLLING_NRFLAG
> +# define TIF_POLLING_NRFLAG	6	// idle is polling for TIF_NEED_RESCHED
> +# define _TIF_POLLING_NRFLAG	BIT(TIF_POLLING_NRFLAG)
> +#endif
> +
> +#define TIF_USER_RETURN_NOTIFY	7	// notify kernel of userspace return
> +#define _TIF_USER_RETURN_NOTIFY	BIT(TIF_USER_RETURN_NOTIFY)
> +
> +#define TIF_UPROBE		8	// breakpointed or singlestepping
> +#define _TIF_UPROBE		BIT(TIF_UPROBE)
> +
> +#define TIF_PATCH_PENDING	9	// pending live patching update
> +#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
> +
> +#ifdef HAVE_TIF_RESTORE_SIGMASK
> +# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
> +# define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
> +#endif
> +
> +#endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

