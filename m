Return-Path: <linux-kernel+bounces-874433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DDDC16568
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 862534FD049
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE634B415;
	Tue, 28 Oct 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CKOU1Loy"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF314147C9B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674050; cv=fail; b=WQdHrcJEk1IxnSuqFNX5ouQdqhjUy7KGNWIKK6MyfrPs3elq+iEL8E8Pq1k1zPtkxYzkGmDfXXOtGInEitDQOhfz4ByHX83GRF/Ip15+9zUpxstHhMguN5cpAQb+pZ9c4QBlPI7e52cqz1k+77/0uYYBIE8gzmVQgw19tbIP2GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674050; c=relaxed/simple;
	bh=G6ppnFe6ts9M4g6kpYznc3YUPTFdPl3ouuFPsxcPdWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oRNcG0fz1Pl/GEEnFuS9TmalWyHD+VN7bz/8o7fgGA+nQdbQL+YPGCLKuYOVwT7eFgDWS6F088KBJUCzhfMfB+hvUeFj6feZboCbs5VYovD9lCWJscY0tANqPyviIh7dwSc4jOitco/swt+MI2TBhB2hEZ7RvSC0XpuvwkoEcGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CKOU1Loy; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cn541XNcAaSF9MNEpzPbtporJLY/jEG4NoQDv7mVUQ6msyMYpfvdxrvi2oZXAePVWuOOMJCXiYsKsTM86kOJGSdQDxONOXfCZeuRQiUPtUIZQye0PwFBRf35ZrSGOCMYXTkqQXg3dl89yM2SibvL4qh1yx+X1zoZjE8wEweXEFqjUMEpcKHM0hLYmeaGK1lj05tn9IKN2FF1en71LA41GMm7zGtYimuZXXjphZi4sBD5MrgZ58dYApCrB7OObMq09BDLMZOXwDhrEBVYmPhYkcMWBZipwp5gWzTQl7ygvadpWXsEUVXLpm1ZkXWh7GtY6/TbLIT3qjkWDR/5Mf5pLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlz04YWgQDycjgDRAQMzg70R0PHpNlQQR15+dmDAfHU=;
 b=DCbOGuz2ML+Vi5ol1MbNSnztJkhbZs07GZZgMD4poHMpAoMxHkgS0JfWr8g+u4bwguspGGcLxk+HiDtQkbOYYc5Uw+3v1uV2LfhMVlnbRZj9H5HXo/1bhGMyDms6wZiIg2XdNu+7kAkiRnnzr1/hCbc0p0Ee3RqlCjNyPqZkSbE3jzxLomjjE4zs9YUmP7Wm/H87RpP5FsljPEg6fAq7wrTmbUhQkX/Xc6BVi0Va0b8u7zeF+euq1szGsKZCFkIi9yQDZrpgdqpxI3BBVeK+bmVGcYZXQV9oUO+7NSwHW4q+HZ4Q8/c7PILlVG1LEmD0iCMVOw3QVmjFkrtNQhhfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlz04YWgQDycjgDRAQMzg70R0PHpNlQQR15+dmDAfHU=;
 b=CKOU1Loy8qZ+P5qW4ARVuLMRwLEazmnfmVFqgP9mtidtZovD0ihwyz3M/WYLLA09m+WBnf3zJGfX7XmBuyQEz1jOhV+PtNUCoXq1UAfMgzHtudzEHljj9gp0grcNjmNVD+JxVdaxR1vm7JnOUpp41J/YXwEAxK3B1XZmY8+UD5jY056hxR7gFBYT+3sE/52jPQSPSkYQXV/7Hiv/da2U2ANrobLHhPL+CxdowODPvXGSCBaabhHfxAnPWV8aXs+AlW0kbKDRrxD0S2H5xONjOPe/nBu4ehWdGBa0aOryD7GMHDC1ONGSnsg08GFxKrI/+15n6wAdEZOGZArGz5UnRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10812.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Tue, 28 Oct
 2025 17:53:56 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 17:53:55 +0000
Message-ID: <d142d345-6a6c-4a90-a773-ec3fa11144fb@efficios.com>
Date: Tue, 28 Oct 2025 13:53:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 15/31] rseq: Record interrupt from user space
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, x86@kernel.org, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>
References: <20251027084220.785525188@linutronix.de>
 <20251027084306.905067101@linutronix.de>
 <05d439ae-8f25-4b23-bb0c-3a3ce04eebbe@efficios.com> <87cy67ufhl.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87cy67ufhl.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0047.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10812:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f0d627-9fa7-4278-465b-08de164af69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1NiT0IyaDY4R3R4OWovV29rOXFob3JtUTJXb0JhdCtZS3lKZmdJZzQ1WHV0?=
 =?utf-8?B?VEwzTXBWbldaR2R1RGd2MEpIaTdFVXZWK090N1kzZzRUWGd3aE0yQjJJTlc2?=
 =?utf-8?B?NHRxS2t6Y3Yzb3FmaS9MSjZHWXRhZjRYaGdEcUs5TWRZUGUxNHdEbGFOcm5R?=
 =?utf-8?B?NjRmQUVRa1d0V1hxek56bTdBVnpMcTVpK3pxZzFhUDN2WWIveTdKQjUvajdG?=
 =?utf-8?B?L0RMTFhyYTcxNWtRdFVpNy85MGJsSCtDMysya09DSTR1RldYc3FrazQ0TUtZ?=
 =?utf-8?B?Z1gzdnJsbGoza0wxVlFZYjZLUlI3UG5OV0t6aHkwWnlRWGZZZ1doTE1kWGc1?=
 =?utf-8?B?OVlhMUVSMUM2UVJybWtyamxEdnh3UUVrY0RuODUyK0I3NmZyY1dtR2pUY2Nm?=
 =?utf-8?B?ZlhjMHJIYnY1RGVRTW0vWVFZZmVaSDREMEtUTzhjVkVKWVlwUTRTV2J2RThl?=
 =?utf-8?B?UUFNNERrYlJiRXZaZENjV3RtWDBxWGFEcjhiNThjU0M1Z2RyUGMvUm1OTjlx?=
 =?utf-8?B?d3EvNndyVXlsRkdkazRHdjBzZW0yTElGNmxxc2x5aDFaV1JwajFONlBWSzdU?=
 =?utf-8?B?ejIvaWZBdDdrbzBxY1EzcEpCYmEzOCszeGFveVRWdlVtWWhXa1FuVlRKR0xU?=
 =?utf-8?B?TUkySEZlL2xJelFlaC8yYS9UV3pEUkpzbDErRU9EdTdLd1dkeXk0ZXp0c1Bq?=
 =?utf-8?B?Y2VtUWRVZVZqYjR6WnVjL3FwWFR5VUxpVVBSMys5cTdLKzNkQU5sZjNqSFdk?=
 =?utf-8?B?YTRSQVZsOXNWcWlXbkZpb2VaUTRYeFlBNTljY3BMMFFMVlB2eEk5QUthZlVY?=
 =?utf-8?B?YzJqc0hoRTdYdW9taEZNeGZXQjAralR6N2w2MSt2U2ZJTmpjR0VDbytMWDlt?=
 =?utf-8?B?WVJ0bVkxM1F1bmZHNjVnVzk5OW1MbmdSQVMvRlJUY1BRRmhadXczMHZYQjNl?=
 =?utf-8?B?YW0zWW54b3NQd1JJUFU5V3dCVXI3VUN5ZitiNlRYeXF4dFhZVWlyb2dLUUZX?=
 =?utf-8?B?RWwzUzE1SnJ6dTNsYzNoclFkNHUyVzNiU1dUbHYzNDFnQURUT005Yjk2ZlVB?=
 =?utf-8?B?YUFJWFRQQTg4ZGpTYW9lR1pKbWs2SkVTSFZ2dm01bGNJTGhJY2tqZmQ2a2xw?=
 =?utf-8?B?U1lVWFRVeHgrUkQyTGJteEQrdk1TeHZxSmgwM2EyMnQxUE5xUEhLN3J5TnNO?=
 =?utf-8?B?NG1BUDBsaDY1Nm0vZUduRFkyWnl6RFA4UzhKbEM2ZURaamVDSm42bVEwS2dz?=
 =?utf-8?B?V2ZLRkc2bWRoUWFxMWt4ZnBCM1NiZkZUUWovVUw3QU1kMFRRN21HVm5wdE1D?=
 =?utf-8?B?NEFpejNSNVVZTlJpck1IZUFKNk9jQjRQZlZTWmp6T3N4ZHpYcGdxKzBTMnZR?=
 =?utf-8?B?d0V4dDlDdHdTQ2lpSXhJRzNQeDhwcmNKSXVlR0NnNVUxUXRrSTgyeFZNdTYy?=
 =?utf-8?B?Y3pBK0VEUnl5SVFvQVZ4WWU2RnVmRGo1WENiMTZseWVkK2czWHZ5ck52WlpL?=
 =?utf-8?B?b2o2U2FQMkwxVlN2ekh0TGU3ZHI1RENVdTRrODFMb3lNNTJvQ2hXbjRhcUVW?=
 =?utf-8?B?UWQvYU9IOVZIZi9paG56NnRwbFYrQ0lKQTUrbUwxcE5JUFlFQjlXSnp3MFgz?=
 =?utf-8?B?REFpanhKMUtKS2d5aW9KTkduMGxTdENKOXpKNkpidkowZlJmM2dxTkhybm05?=
 =?utf-8?B?RWkyQko5WWw1bVFXdmhFNEIyTDB1SmJVbXU5a0loWWpoZ2hwd28wc2dFS3hB?=
 =?utf-8?B?RWhGQStpSktvY0U5UmswUCtDTmtoT09EN2tJM2dXTDJ2WnBmL1dMSTNrUllj?=
 =?utf-8?B?alpkN2ZraElxY3hGRmFHMlRUbG91dUsxY3psbGpjQXF1cmlCNTRFK1FlM2Q2?=
 =?utf-8?Q?APTC6gAss+av/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S20zRll0S0l5VHV3N1AvZk1YT1VrdmZ6WUliMyt2Z0JCNUZNK0lZOVlhQnpC?=
 =?utf-8?B?cWtNMkYrYURyY2l0bm5CS0dPaUtMRzBBOGhMUVRFQTZyUklENGQ2Qmorcncy?=
 =?utf-8?B?OGdYSDJGR2xLV0t3UHJvdUJtVHFnYXZVSXVjWm5OZDJ5aHhyVGVFODNTQWdF?=
 =?utf-8?B?NEg1Sm9sNFU0RC91ZkZQOTJ4M3BCRTNVQnVVQnJETUIwVUVZNmQ2MFhmUXFX?=
 =?utf-8?B?VnR5V0RpeUR5a0crbHFjaVlSQzBweW9ra2o3M1JTcmp1VlJ4WDVQMG9XcTRG?=
 =?utf-8?B?dlloc0s0T2pCNWMzUHpBYkk3WFppLytYOTNJbE9Ga1A5WThRYXhFcGo2d2pQ?=
 =?utf-8?B?M0FUVVZHWFN2cS9wandUamdybFZaVDZTQlRoVGhNU3BURTJ2dXIwVkZ4aExu?=
 =?utf-8?B?WjBKTlN3aDhncVU5M2k0OTB4bnBxOFhiUG9pN1cyR2I5dU1jUFYvQU5lVlhH?=
 =?utf-8?B?RGRpRUR0SlFWRGFmU1JEa0xBV2U0aGVGVTlSRUZBbzU4NlNXUWxXc2NId25E?=
 =?utf-8?B?a0xUeUVSMkRGbmNTa0h6OWtxWWdXSjhGWVVVVkpOdEtXeVRSUW9Oak5yTWtX?=
 =?utf-8?B?aGFBWC9QekpwR1Z5Q0swR3ZFVzQ5cGRmRi8wY0N0TEdBdWlhTTZ3dHIwM0d0?=
 =?utf-8?B?c0tsVE9lazdHMXpjSEFCbmVhc3F2TS9WWXZIemRxZXoxUDMzaG9Oc1ZhRUFB?=
 =?utf-8?B?aS9SdlhKai85Y25wYkFZZndSUkZFekxOQndBeDJMdGFWbjQ1YzVvbjREeWxW?=
 =?utf-8?B?cHhPd29ic2w3OENZT0tzbEFLd05GWUc3eGhrNGFtWFdkWllwSFdVQVZQR0w1?=
 =?utf-8?B?djNYR29hYUtqejFpeGswV1hQeWovTDVqMGw4NlgyOEo1S2ZlZWVWdTQ2VnV2?=
 =?utf-8?B?dU8vNll4WmtVQUZmZFg0TlFkY1FMb1dwTDloWW11M09YbDNYMFZQRnBITkFw?=
 =?utf-8?B?VEVrTjR3OVVOR0M1NUtXdys3T3hBT1pRY2haM1ZHS3NPRXk2YXdqbGNEeTFE?=
 =?utf-8?B?RFN6em8yTGtZdiswUWdySzdFbDJydzRTMkdCNHR4Rko1aFB2cFMyUWhnMUdN?=
 =?utf-8?B?OUR6ZytISE9EaDhZc2k2anltazFjUDg0ZjJqWHMxRnNuS2VGR0ViN1lSSDRM?=
 =?utf-8?B?eGZ5VmNvSkh0aUpCaEc4Qll5RmV1S0M5WlEvK2kwa0lyWkRZK0Fqbm9KZ2xX?=
 =?utf-8?B?MmVxeGl5Zm5RS0h5SURYcy9wMkgzQkcrQVRET0FrRzRkUUhNb2s3TGhNQUtD?=
 =?utf-8?B?NGxrNnJYeUVlczdpMm5JNlAyVTZvWDRzRXRCUGkvNVpwQVh1M1pGTitPQzZ3?=
 =?utf-8?B?MlJ4VXY1dUYxZDNKckY2MjhIN29mOVUwS3dvayt1ckR1YjgxUWFVMlZmbFRF?=
 =?utf-8?B?UjFQRnR4TVpJRDNUZDF6QTUzVUM4SE16bndVNnlyTkoxQlppdFpvbUgwWG9i?=
 =?utf-8?B?cENNYTFLSkI3aHlnbU1YV09qbmFhNHA3QVFmeE03VVdWbUY2WTdPNGZ1Nlds?=
 =?utf-8?B?VUJoRk9WSDQzb3lKeCtFYUF5MWJtRzhyRkxCU2tIZ1FjYjJqbVNXbGI1eGl6?=
 =?utf-8?B?ZEJGQWZDYWF0eTY1bzV4SUNFQktaRWx2bk5XVTljL0FNd3VpN0JEUllZdVZN?=
 =?utf-8?B?Y0NxbkhvWlYwVHdNVlpEU2pYaVpIQ0FmbGRwSU14U2NJd3ErMjA1aGQ1enZr?=
 =?utf-8?B?QVdjK1djaEtBOVBQZ1Vmb0RuYmIxWmxJK3VYVjZEWHFQK1A0R1ZJWWRRZk14?=
 =?utf-8?B?eFpnRW94VHY5TTdwY3k5cmFXbWlPVE9aTTM0eXFUQXhJeGsvQ0ZtUEl4WUlO?=
 =?utf-8?B?dUZxaVZXM05LV05NNzFpd1JHZ0ZwQ3lueEdKUWZkUVF1dDVEYTBNb2VlTDZ2?=
 =?utf-8?B?QTRCeklYeEtpYitBWk4xcjdFcW11aGlMeXVsOVhFbVJPbEpRUGkzVXRBRklJ?=
 =?utf-8?B?ZWkvL0JSTlc2WnJtazViVit3UjdpcmZqQkhsZU9NQXZnVTRDZm0vV24vZEUx?=
 =?utf-8?B?c3VZTjY2M05mS2huTW9aTERZbHJrRlQvZDJNZzZkS2N4UFVtTW91UkxOQkJr?=
 =?utf-8?B?MHlZTnY5b2pDVFYzekZzck9FcnZoeGh1K3JGRVRMdU9KTTRJRzBtY01GRnBR?=
 =?utf-8?B?NTI1U25zRlU2c1cyeUdFMzhNMTRnOEcyblRSRFdBUkRwVXdtdDBKTmp2Mmdi?=
 =?utf-8?Q?e8TSsBzHDIkk52vBQ6oFxZw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f0d627-9fa7-4278-465b-08de164af69e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 17:53:55.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfCigiXoss6uqMSpkxT4x8/wf3yF9xSbt1XmWbrJskIiuPgJPH3xX6nOw9eC9fLXMjUjdwoDg9PNUuyM3W5gmkIuNy62JuWKURrkuuBMi8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10812

On 2025-10-28 13:02, Thomas Gleixner wrote:
> On Tue, Oct 28 2025 at 11:26, Mathieu Desnoyers wrote:
>> On 2025-10-27 04:44, Thomas Gleixner wrote:
>> [...]
>>> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>>>    static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>>>    {
>>>    	enter_from_user_mode(regs);
>>> +	rseq_note_user_irq_entry();
>>>    }
>>>    
>> Looking at x86, both exc_debug_user() and exc_int3() invoke
>> irqentry_enter_from_user_mode(), but there are various
>> other traps that can come from userspace (e.g. math_error,
>> exc_general_protection, ...). Some of those traps don't
>> necessarily end with a signal delivery to the offending
>> process. And some of those traps enable interrupts.
> 
> They all go through irqentry_enter_from_user_mode(). See
> DEFINE_IDTENTRY*() macros. They invoke:
> 
>     irqentry_enter()
>       if (user_mode())
>          irqentry_enter_from_user_mode();
> 
> If that wouldn't be the case then all the RCU/NOHZ magic would not work
> either. So any exception, trap, interrupt must go through this to
> establish state correctly. Whether that's explicit as it's required for
> int3 and debug_user or implicit through the IDTENTRY magic.

That's what I missed, thanks for the explanation.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

