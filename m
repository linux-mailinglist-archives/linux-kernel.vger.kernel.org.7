Return-Path: <linux-kernel+bounces-808491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E315B50075
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40028166014
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C8343D6B;
	Tue,  9 Sep 2025 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OZv5qOhk"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020137.outbound.protection.outlook.com [52.101.189.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7411F0E2E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429998; cv=fail; b=ThiKedMFqnkc7IRSEHz3EyzczdDXexiZG0wwirICYm9JZJ6S8hq9LD6A1dg2CS5RMlI3Ahis+p6vF8wnTTJ0BhSin0rFt+j5N5iY4YYNEG70mbr9nJ6AbsZEpTcoZn0KxkKOBiIzojLZn1DL1NnIej4ucPiLJMrFdDJLTuVkh9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429998; c=relaxed/simple;
	bh=iGiQX/8gFSAS2WkLW4VQ2mVNd0+GOyAL5joJu7NgrS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvHvszszGrlYSLH8AYd0b73u6SjM8pg4ysCrpst2whhpHceOzteKgLWSgOA6Hdvo/B0kYWs+c8KOBFlLozwzixdPjrGQ0544ExgT4JPcW8wYNAzyDnLp7LRAzcIQHOYeYk/CI9LyIAVNSobQVeBZV6P7RLoOt1Bb3L+TnLalMqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OZv5qOhk; arc=fail smtp.client-ip=52.101.189.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brlGBTB2nFDnFca1IT8tisg6n/OzmlCgLN0CXPOI2b6fPxOFtaZ70y/sNDwcROw5127QFFA6hqVt2aL8nrEDdZ/xTVJZSvVkprPcfpdzfJceIqVpnFKTcvw0+7SRcVPO5jKZJGYnbGcnMJvCrVDB5xCfM8D6/X7XFmy8lgL9OevPVKSH1V6pMXmELS140s/iX41mH/ceqisZkI7leVDj7TYDcdCUYCf05TQvT5Hm08Arog57LVB/pTPujKXZMxt/57cZhfHQF8YBlxRx6ke2DsHhrNxak0QfDQD0BmmxsDNpr7dZWMG8bOOrNPJ2Vlz2SAIU2zjgnfRu2XRJTB5GtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4I1uJRzfJjTjj8it/aJ5tz6NNmGrpOBNQSwvOR27Ks=;
 b=pmNRKDj8FW5Tbnah/FlurmxV3c0+EnSNV3jYsCKWEqzBGbxhHZytVE3nBRebWfFlWTjjeKmocz/2fyopuLegqx1q69NTy7c6oMbDGfuG9nVmWTVPyTg5wBJIBmr1iZNl2fUV0FxuU2hjoeK+mkguje25qy/Gl6TjK3YMJzzO9RrcKNAoSzfkOTg8tOWw8nhJJmx/6VjnAdEfLXixvmzFG8El6cePy8gf9e9gwTzYQxDexkcqZq2CDWJyJIkxS6Z6MT1Uj3h3Qffa28EKt4tFl+UN2tvwfQxcYUnjF4fzUsuCGWqeXkLLhVzVFWgNGUgwVtWauOfgG8OOVDL0PJ3hug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4I1uJRzfJjTjj8it/aJ5tz6NNmGrpOBNQSwvOR27Ks=;
 b=OZv5qOhkEEy7bw6kLQNkdKMB1ry0G1xB/1nTV8MCMR//bHdsY9l0lJpV8QyCO8cwPSuDyNVmSASKT9ZP+5aD1pTrYdgmXLZVK6XgiuEuPixy/B63DraF7LVmAvnbMjeEljtj8uWzZLbcYX23qzelbq04J5mVhRL3Z4cJ1dMX9MZ9o3DJA1qcB6A6Ia1kkwbQWpOzcNc8jYMn7JpvV4vYHcF6U57q82s24A5Qfmk70i3kYNvb8HJToD/dr+ozHdtcOzFhQ760zrLepci1F0Zazd/R4ABxTMSVLDcFyWJOJLh85ZpSum0CkuVijwe9ra1RjCyHoskoCIVglrGlsQAygg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9586.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 14:59:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 14:59:52 +0000
Message-ID: <2fd47d96-f4a6-4eeb-a7c8-8e4e27a9e017@efficios.com>
Date: Tue, 9 Sep 2025 10:59:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 12/36] entry: Inline
 irqentry_enter/exit_from/to_user_mode()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212926.033244852@linutronix.de>
 <45ce1b35-76ee-41b8-9fd2-b3b0d8126bf1@efficios.com> <87jz27vhs5.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87jz27vhs5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f921340-3252-4222-e3b8-08ddefb18806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFp5WjNhZzRoSktvRHBveXNhb2J1cm1Oa1o3ZUdLK0lLaXpldnl6M28zN3B2?=
 =?utf-8?B?Ymlhbk44ZUt2OVk4aUcvWGM4OVFxRDRrazlFSEczY1Q2dDdLLzV5ZjZwNkxO?=
 =?utf-8?B?SWVYekFVM2k3Z2FnTmJEVXJiakVldFRyYno0Qk5xVTQ4Vy9zWU1CbXo4QVVm?=
 =?utf-8?B?TlFVMTJ5cGVKOXVQQmxTRUV0dFNYYlVpa2dDczZCcVpPSFdWTHBvMkxvVG1h?=
 =?utf-8?B?eGFzQ3h1V01PWEhKR0l5N1luRTdGNmRTU2I4aUxOQzhsVmhmUGN5Q1BHUlY1?=
 =?utf-8?B?ajYwayt0Uk55S1JRWVFFbGV3d0FiR2ZtRjU0SGIrN09aR1NBU25kbWZjOFFT?=
 =?utf-8?B?cmUycjI5c1k2b3FsMTdyTmlTUkNXY2srSjcyQnY1anpiM2Y1UFo2WjE0bUpT?=
 =?utf-8?B?aXMyb3VqdGhVWGJ6WXJGVVlHN01hTHJLMkl6VStNQjNjeTQzano5bnhzTDMy?=
 =?utf-8?B?Z0N4REk3Y0o0aG8wcGVweHdRS09RUS9XdXBRNXF2L3FwTXlNVGc2ZGpJRVBY?=
 =?utf-8?B?VTlVMmkzRDFhNzhVamhHT2RlR0RNajRXQmhpb3lqMGFPVWg2OVRPeUh0cmc2?=
 =?utf-8?B?WDdFeUVreFQzejl0UXE0cHpZbkg0NWVIRytEclNBMWo1V2JnSXQxYnFBRFZx?=
 =?utf-8?B?L2w5RjVXU2RNcXVabkpucUxBWjZUSXhoMlIwN0ZQVTgrN1lvUC9hZ2NvZ1hI?=
 =?utf-8?B?S0FjN1I3c1VFU2Q5amIxMHVvSTB0UkRWYTZwR2dRNUZIVEIzeitjYnJod1pm?=
 =?utf-8?B?K1d1M1JnblM1Sk56MUhwVldzeUVscGViR2czb3VLU05PRlhpM0VRM0ZPT0hk?=
 =?utf-8?B?MnBqVUNvblM5V3BPQ0VIMXZCdjBRTHJpdXhISlNWdnQ4eGVFRE1tcmZxOTd4?=
 =?utf-8?B?cHFxK0pBbTEwdHZvNkNtMzdjYW9KVWZzcjMrTG1iMnZRcmdLZHQ5UnU1WDds?=
 =?utf-8?B?TmNnNHYwTkR0Um0wUkJGY2E4cUpCcVdwY0tmWmQweE43cVlwQVdHeWFwWHZy?=
 =?utf-8?B?MlkrTlFZTnAwYTdrQWFFRUtqK1llV2FJMTRKeVF5VG1NWXlpTGxNdms4TUpZ?=
 =?utf-8?B?L0FJN0c0Zko0SE5URXN5ZmRrYUdYS1RyTVRyaExaUW54RnpJQnRJMjBvTlpn?=
 =?utf-8?B?Y0tWZ0o1QXg1czJheWFOOHhWN0swc0N4RGhaMXhFWld0aWlPM2F6THVoMkF1?=
 =?utf-8?B?NGFlc0FOUHdmeXMxMURqUmw1THB1Si9OalhTeWh4U2hrQzZ2aVhyOEU3RDd4?=
 =?utf-8?B?Y3ZIOUNITzZFQUpqVVhBTmtESlNKWjNDZFM2S3NHMHNzNElxRG1kK1FzcWtL?=
 =?utf-8?B?NzhsUWE1UTJiVmVKZ2EwM2g5OUN3eEJRSnY2ZVpJdXpXcXh2eFF6cENVSHh6?=
 =?utf-8?B?UHpJVjRVamVmRSs3bHBmOHo0SlBIUVpjaXZWVHVNSjRNOTJwa3ZBREEvNVVv?=
 =?utf-8?B?V25Ta2JjM3F4Q3hVTFdoNkdOZndDN2FMRktKOHFpZlBHSmRXYnpxbk9GK2N5?=
 =?utf-8?B?VHhBdkVQOFJiUXJDOHFiQUdtSFZFZWpNeXU0LzJ6bU1CTjdGcXhUYVRyS0pz?=
 =?utf-8?B?NkJySjJ5aXZXMnRaS3lTbndWNFhtWHExOU8zb0VMVHVzSGVBNDMrWWFoOUlu?=
 =?utf-8?B?eHp2SnJsc3poNnVzaHZodVdlK2R3cXFEWjFyQVBlVitHWjhxcG5IeXRuYTM0?=
 =?utf-8?B?MmYrTGRlaE5ybEkzcGhHTjZyeDA5VWpiR2ZrMkpQbnVLWHdJR0JiSW1reE5Z?=
 =?utf-8?B?RzZuRTRRUHE3OGNuVFl3clFuNnpVY2lmK1pkbUptWXRCalczWVR0ZjdWOTNo?=
 =?utf-8?Q?8HiEsPtz64MLRX0m7Z+0ZHdRtVpxm47dMyQiM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlQaVJoSGh6ekN6VDM2a2pPRm5zYXZmaHR0ODBlY3lhUjIxa3ZyMDVhbVpa?=
 =?utf-8?B?SmdZNVFuUGxBWlpHQ2NKcWg5SVlSaEFWc2ZkcUNyUnlHUTVjTm1JbkNuSWhs?=
 =?utf-8?B?elM1SE15cWhWVnh5NEQ1enVnOXJuV29pVHVqSXJ0TEplbm53dXkrUFJZMkdE?=
 =?utf-8?B?MG42TlFuN1Z2UXJhcWQxd3lMVWdDWUVzMmE4SS9FZWhydjhxZVNEdWc2WXlu?=
 =?utf-8?B?QTJOZ3FsVGo4dTlSZU13WUd6Q0tUcWg4UUpjb3ZtTGZUMGlFbitBTUtVNThX?=
 =?utf-8?B?eFBiZmQ3aUkyZVZhN08vL1ViVWRXQWx3cEJYMU84UHJpbVdMcUwzZy9xU2dR?=
 =?utf-8?B?K1Zvd0hKSzNHNzRjWlpFTGtvckc4WkxueUwrUEFYSWdDUGNxYW9xeVVic1lu?=
 =?utf-8?B?R0luMmxCa2s0dE9KSWcrNUkzNFVSU2o4alE3WnprdEZ5dEdzeEpRTVUyMjg2?=
 =?utf-8?B?aWprUTEvQkN1dXJrV3ZXQXdFaWdxVzIyazIwOXZkeDA2Z3YvdXRPTVAxOVFo?=
 =?utf-8?B?RVd2eGw2eTVYMHBSYTkwY2xqM3JZM0xlcGp6Y09nWkMvNVI2dWU1TzN1ZmFX?=
 =?utf-8?B?YzZJS2x0eVplYnFUMk40QlAwSnlsS3NsK05ZWEJDQ20yUEc2Z0l0cHhnY00r?=
 =?utf-8?B?WWlWT2J6dkxGcmR3THZuWTFMNXN0RnNBdU4yTktpWVRCWW0vOC9zK0w2Y2J3?=
 =?utf-8?B?QzRURXNETEh6RjA1SWU2RTllSC9lTXJBZUJlT1JldTgzRTZvckNoSEhuS0FI?=
 =?utf-8?B?L3F5U3R2a3NEWDVRNXNYMFlKelNxZlB3TTBKL2hyejdBRWFJK041RStNN1Jh?=
 =?utf-8?B?bzNPa1c4cXgvRC9NRVk0VmFDRGhFNXVFMnp2UVA4NHB0djc3THhESUlHMlUr?=
 =?utf-8?B?R0xkMWtWSHpvNk9CcFRVNEZKU0RtZC9VU1UvY2F3dFpUWGRCV0lCbGRJUEN4?=
 =?utf-8?B?bFVpLzJCd3JiSmhjU3NVUjZhR1NmSFV0c2R3U2NZaTdBdGc4ZkRkMjNlT3NO?=
 =?utf-8?B?UFNPb0plNTN5ME5iUWR1YldjdHp6Z1R0T0J5M3RabVRUTUxCZ1VjakhDWjAz?=
 =?utf-8?B?SFFxa2dBeDYyM3dwZ1BTNWR2dGlvTXdlN281bWREK3pDMTRhVUFCS3JXSWpB?=
 =?utf-8?B?VVBHbkk0a1Mrd2xPYTQ5MjBNMERMa3pFUW14eE9ZSUkybzRqSTFzelBUOXJv?=
 =?utf-8?B?WVA5dS9OeFB0YldWUkRZQ2hnN2U5TVpKOVNIdWpwWms2Y2dLS0hTY1NSYTRO?=
 =?utf-8?B?NkhNcnBKV25FSEhkU2VMejhJT0dvU1VYOFk1WTlFZUtrZkNtdzY1UjkzcE9D?=
 =?utf-8?B?YzdZakVUa3dvYmdLUlVoemU1WE9ZaVh2OWkwZDYrU2VQQjFhVUpGOXJFOHMy?=
 =?utf-8?B?TlJWeSs2SDY3RmVpdHRCZVZrSENiVkIrcDNTZXJrODE2UlJLT0pSRmU3QWpj?=
 =?utf-8?B?TU91RlVnTnBSQ3Jqc3F5aXVEeTZnQ0tkUXo3OFRHMEs0aFJackRmcGlQS1FF?=
 =?utf-8?B?YUxtd2IzZmgrOHhBRnVXSzlUUVQwMlFlRGoveXNsZ0htbVhIYW90SDNraFhT?=
 =?utf-8?B?N2lrajhuazdYc0oraSt4N0pyMExLbFRHd2Z2Nm1vTEF6T25HUmZqcGZVMXZO?=
 =?utf-8?B?SEN0VHpSOWUyTGpiZFkwWFZHeTZOL2tvdnIrVFUyajZ3bGJ4bUpVM2R1dm1U?=
 =?utf-8?B?eUxFTjN3TjYwOFo5clNyNGV3aGRwdURWR2tJc2QwcS8rZm9abklqS1RlclAy?=
 =?utf-8?B?YXFNRTJLd2ViZWxuUXFpUWJuT3NudHNsRzdlaHpiS2Y3cFdXalI4eDlEdlh4?=
 =?utf-8?B?by9Zb2NBaUc3djdpdVN6N1lNRFNuNG5EVmo5YldtU0RERzdRdHhZK0F3Sjl6?=
 =?utf-8?B?N2cwcTBpVGRZcXpBdkIvY1NHU3hWU1hTZXNMNGJrc1VkbVJPUUlHRTdFTjRN?=
 =?utf-8?B?d3Zqd045dXo2TUFVU0ZzNFZveXJtQVFUc1RQcDQxdFNKdmV5dFNQeWkvSEhL?=
 =?utf-8?B?cExSVkN1ZStkNXV1Tk54c2JXOVBsNnlwWXZjblBIaDVsemkvMW1zdkttQjlI?=
 =?utf-8?B?SXg1MmZjV1FLbEhqaWJCdEVxLzFIZUpOcUpqZGhmbVFjTFE2Ujh5ZVg0bjNX?=
 =?utf-8?B?VUt0WTNQSm1RcmM3TFBDdjVNY2VQNHhMZHpjL09DK1JlZktQYXZtakpFQUx2?=
 =?utf-8?Q?42FBTLcRX5VwnrYfBa10Nsg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f921340-3252-4222-e3b8-08ddefb18806
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 14:59:52.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNSoVePLqoCzikRW2FhFvU1XmkPx/pJYJq7CV4A45+ZpYV9+GOdW6fh9STvHNiRjlhycqctTjCUWmNCmW2KhICDXlzRhtLOwnJzIN5ps/tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9586

On 2025-09-09 10:10, Thomas Gleixner wrote:
> On Tue, Sep 09 2025 at 09:38, Mathieu Desnoyers wrote:
> 
>> On 2025-09-08 17:31, Thomas Gleixner wrote:
>>> There is no point to have this as a function which just inlines
>>> enter_from_user_mode(). The function call overhead is larger than the
>>> function itself.
>>
>> I'm wondering if there is a reason for making those actual functions and
>> not inlines.
>>
>> The functions sit in kernel/entry/common.c, which are built with
>> specific compiler flags in kernel/entry/Makefile:
>>
>> # Prevent the noinstr section from being pestered by sanitizer and other
>> goodies
>> # as long as these things cannot be disabled per function.
>> KASAN_SANITIZE := n
>> UBSAN_SANITIZE := n
>> KCOV_INSTRUMENT := n
>>
>> # Branch profiling isn't noinstr-safe
>> ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
>>
>> CFLAGS_REMOVE_common.o   = -fstack-protector -fstack-protector-strong
>> CFLAGS_common.o         += -fno-stack-protector
>>
>> So I wonder if we're not breaking something in the area of "noinstr"
>> tagging by inlining those into their caller ?
> 
> No, because the call sites have to be non-instrumented as well.

OK.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

