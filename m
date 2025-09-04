Return-Path: <linux-kernel+bounces-801342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8EB443E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 330C21CC062C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DFE2F617D;
	Thu,  4 Sep 2025 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TLWq898b"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021074.outbound.protection.outlook.com [40.107.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9320E21B905
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005641; cv=fail; b=EtnmS1TzL7Ez8EyswK+juRIzVOLfvcmGO59LxhJlqDcoRkg81ghqArR/6uMqkESNg3fmIgBnzX9rrKWUge591CcTE8x9zjR5xp5FaFt7q2EEyHG9AdjIzJfp/7NkPJg3ilA9p8O2xDNDv2WfuolnHpBOmVZWEJ8TmJo32oiO64Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005641; c=relaxed/simple;
	bh=B4GZAxMTXNN5fEeiBjy7q4Y2AMLL9L0qytOxTeri8Uk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBI4DBQDgo88lqBnN+Bk6WwXZroMwTdxwFWKn+on05qdkOTYGsDc55sDL1aMZ45byFcaKFYfCN/1jJYmEMWHaIfaKAcCjrpBsVoPCL87Hh1gN9abBqba8aCGv33vF13XoZV8g7bAd1rZMttn8mXpyxaM40ES1PJ7nGyF4XTLL3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TLWq898b; arc=fail smtp.client-ip=40.107.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jkao/TEiqV20baC07cWS8C0/KBLARdqGvQD3N4gwnKgdQYLOeekzuL0aDOztGMx1Hl2rEmtepjErSTAUlcQy4l5GPhu68lrEuacPvh6SknrC3W33CD9/n80PW+CoqPi2sFvqtHS63njto0DCIbgkgkgd15An2cSYlozw9owLL6X9130NfV2RtODO8ghrXQKD9iDzAY0vKHSyYMRRPW5VMX/2OMTM6ehkZ2Q3Nh5u6iRxflQSH82KuHyG9WEYy5au9I0494bLqXaZ7ZZhyo55UiJI39qmtmrzmBDrpnCsu+HznMrjreXYHAgWPgHHDQa+G902WUtHu8f6vBC3/N3sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwW2RK/W314fThTMdT5pCOIxT+2NaDgJfL5M9Dp0gg0=;
 b=ODAZxV9Q4uyz+Grs3eZZJth3ReVmTT9LMjQ4K4HVe+6XRdJdVL+L3kU45PXwd6oZy65RpK1xADtxzD6giO7AN9+Z3dE3AzyhFXATdcZn+6HVMVj47n1EldonCQ43hO/QTV066xYyQxLouu1Fc56GKuExVGkvAK4bk6jRPs6jpdHEK9pFyIfIFr3xE9tw3hTjxoNFtFoU59ejuti2oDXgJcKqo7XWNpzzbmAat615Op4CTYvIpVJfcDdX5k44yEJ0QKPuZlwyOtiL5TB4mpHuWZVLIUG78G4z/pC5iwfSYFLW54DJXPGMx7pOXMXvIUXlfFG4XTZyDYqLAwKcmqXhpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwW2RK/W314fThTMdT5pCOIxT+2NaDgJfL5M9Dp0gg0=;
 b=TLWq898bETtq+rOG8MeooUJ3wFV1bhbzFsheWJC3/wGClWx7KYasac1LVGf8ePXqkKU+AikxUwqvRbUqF37up/7s9F7NLepVdGM6oWzR8RQ/Mp0X/DG7OsFXhAEqIoqB+cFysGbWbUkfQy1Y1eJH5XH1T9Ardsjv/8YoFyITjyxL7tuOnFweFS9QnwZhcRBCjDs4/+ikI3RBbPzkpDQoyHRR8753EQsMabCVOB1vVr30Dac3ckFlbIbp3nkKFmxWLNkPuLIBU/eMr43EHIJUWYeYFrDeWoFKWD0ru8iGVgWeYlPss1AjjrW5K6hXP/1osr3uoDaaQF19I8hA1YWBYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9491.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:76::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 17:07:15 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:07:14 +0000
Message-ID: <760fe585-9a81-49ed-b020-a099f56bc503@efficios.com>
Date: Thu, 4 Sep 2025 13:07:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 25/37] rseq: Rework the TIF_NOTIFY handler
To: Thomas Gleixner <tglx@linutronix.de>,
 Sean Christopherson <seanjc@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161654.869197102@linutronix.de>
 <0610d1be-15b4-40a6-8bec-307e62f810bb@efficios.com> <87o6rszrnp.ffs@tglx>
 <aLlhSmeA_TPSheyu@google.com> <87ldmuxzcs.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87ldmuxzcs.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 2218a865-fe18-4ae4-7ca2-08ddebd57edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEFWb0ZLTHJNckdNeVZnSVlVeUZLOW5CcWxVZ242akgwMFpJVWxnZlY5QTl3?=
 =?utf-8?B?OEZMS0s3ais3MWlDY2FkcDh2ZVZNNjFJZUZnZDJyd0RqYlBHbEVNTG50bWRt?=
 =?utf-8?B?ZTRMeksxbkJZK0pyVGpYWEZDY0pEMmxZZ2Vla0JCSGJCRmRVdzEyUmxWOEJ2?=
 =?utf-8?B?M1ZCQkRwK0tOUnFXWFNBU2pjMmRZV2hoN3JOai8xNHpSMnhQdWNTKzRJbDNu?=
 =?utf-8?B?RUhIS09nTlh2TmpPRXN5djBSZ2ZNS085T0QrMFhWZmk1U3ZFb3NoVkp1SUpL?=
 =?utf-8?B?bEpxc05OTXhxNEVDdWhYblBFdytDalYzSmZEbSsrR1BNNStFQTVTdGl4azVk?=
 =?utf-8?B?Q0ZWQ3Z1NDBZZytDNFVHRW9jSGNwaWZTRW5KRmFkM2ZBUk5ZVGJIQ3M0akk3?=
 =?utf-8?B?OFVTNGlHbVE4anpIbWhyejVvSmY0c3hmSkUyZFJQOXFQRlJCSjd1MFIxM1VY?=
 =?utf-8?B?RER5N3RKaWVWSmxicXVMVmE3Ly83ZldPak5pYTJncWR3VUtxOFdoUVk2Smxw?=
 =?utf-8?B?bVp3bHBHeEpxeitPQ2hLR0dCd0pUOVhUQkZmREtwYzBhdFBzS2F1dXdFaDVl?=
 =?utf-8?B?S3F2ZlFzTTB4b1lkb0UzZ1hUYVgvT3B5U1dTZ3h2MjRYZWpmcjkweDhxTmp1?=
 =?utf-8?B?SGhMb2tNN3hhNm40azZDd3NuVHlxS1NOOGRvcW5PYVQvL1A5WnpMbXRKa0tm?=
 =?utf-8?B?L1R5b3VxL3JHK2VsZVNxSHFxeXdxd0J2bWphdXgxZGdsQmVwcytSdFU0aFFQ?=
 =?utf-8?B?enNLaGovZHBYYnoxS3VDc0kwRXJWT3JiYjNqNXgzTVlZYzBTK2ZURnZaUHBh?=
 =?utf-8?B?cDhiYlc5WDY1dEF0UmxINHZ6Rm5MNlFhMTg2dGJVMklPaGlOVTBwSHI4UkYx?=
 =?utf-8?B?d2lZcHB5M2h3QXVRWjY1eDJ5cTFYWFRzSkQvWnI0YTNSbS95NUltSDZqaVRH?=
 =?utf-8?B?QzlYaTI1UmRPeFpzUUVhWXpDWU5RTGJOU1hqajRFODgwNFowVFpMY1hvVEdO?=
 =?utf-8?B?cGhtWWdNMk4wa3dqZXVOMEM3V2lCUzJERlVuWDJGbzhKZUgzb1dNblFqVjJa?=
 =?utf-8?B?NzFvRldhcHJDa0tVRTY3Mmo4eFlDNmlSK3AzVGlNbnFwZ1JDaFFubXdjcEg5?=
 =?utf-8?B?dk4wT2RnTzRGYnUzSlpCY1k1MGlHVWY1RUNZRHJocmhaYlMzZnJXZTdzWWVo?=
 =?utf-8?B?eDNMVTA5VmxYcGczbzdNY0xmMVFBeC9GRE5TbDdyc3JiVitqcUo4eHVzMC9u?=
 =?utf-8?B?MEFZajhvRkYrck91MnljODNJYUhjckR4cjZNTTdYM1NucUMrWHdnc2YzelNE?=
 =?utf-8?B?ajZ4V0hSVWpQeVlKY3cwTTFSdENkUFlDSk9acS9JbE11M3ZkSFVIYWdWbkVP?=
 =?utf-8?B?TlZjNklVV2pLSFVTeTZaR1I4MDBwKzNBRG9tTXp1VXY4cXBXZ2hOblZ1dFBq?=
 =?utf-8?B?amRlalFVUk9OL01rTThmbXQ0amsvbTZTTnZKTzhCQ01hdVRwUWpYYnhJd2JR?=
 =?utf-8?B?THRmVDFvQWhva013cTZRaDk5di9pU0tkb1R0WkZab0M2WnZBZEZmb3ZDVVVS?=
 =?utf-8?B?QmVHTjNidFhMeGt0OFZPK3R5NU5oQnkwQ1g4dURqMXFJMTNxNUhQRHY1WE5T?=
 =?utf-8?B?Y0JTc2Fvdk11alZtUzNmY01WVGJmdGsyYUowdGNJSS9BbVZGUkZoVTFpNlU3?=
 =?utf-8?B?TkFHNktaQ1Jldm9pNlFRdk96T0JPaExsVU10bXRPN2h3YUZFUGpuYUlJU05O?=
 =?utf-8?B?ZzNVWGdrRTRuUStBN0FPRDRYdWIvMXdFNkR1cEdqYjNUcHB1QW5ScWNOV2lz?=
 =?utf-8?Q?vnfYnnZwAyOdYuabGTXkgS9gc4umEf8lnJ4Cs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1HRGFjWGp2L0FEWGRNSjdSK3VCK2FBVDVwUG5ubExsNGpWTTFDL2w3aDd4?=
 =?utf-8?B?UWI0VUpEOUhqZW4zeGU0S2lIQTJJb0d4ZEtLbnRGSmF1MkhnMkp6bEx2V2Nq?=
 =?utf-8?B?Q2p5YXB2NHVEaVNnWEhndXF0NWdtRkZITmpUYS85OTJNQUMrUGFNTmNmMzd6?=
 =?utf-8?B?VGEvbEROOGxNd0VrOHhFWDMxSWlGNEV4V0ptQmNhWEwwTVk1WWtMb3hwLzRB?=
 =?utf-8?B?cW04Ym1zUDVYTWR3N3hCOHhJWXllaW5lc2ZqdGFkd3VGdTVram8rb2VqOStT?=
 =?utf-8?B?dmh1bm5LSFgwUzRoSHp0T0JEYlQ2OVE4WEhZdWQvN2JJMmJUN2RYS3VFbjds?=
 =?utf-8?B?YXJvYUdRYUcybHc1WWtXY1VNZTBKQ1BWNjZPY0RQV28vN2grUkNBT1o3MVRS?=
 =?utf-8?B?M3dOcHFtWE1uNmtIejh1YWhTaEUzL3dtM0krQS9wY0R0YUVLRzRBbUo1ek9u?=
 =?utf-8?B?b200ZWRQT3lFMTF6bUtyV1ZqbmxqeDA1dVJXKzF5d1ROOTM3SVNwZUp1SGto?=
 =?utf-8?B?TEpKaTdqL3FwSWtkM2hTakdUUURVazJkRzJZdVZWWEMybzhoYjZEOC9KT01j?=
 =?utf-8?B?bm5KUHBlNjc3WHhyUGVKZHBqa0l1aXpaT3g3V3Q1STd1VElFTVBZMC91K2M2?=
 =?utf-8?B?T214ZUd1Qy9xZWNQSG5QWTZjSGgrejBVMEhmWXA5d1ZTZVNpZExLcklzdllw?=
 =?utf-8?B?VnN5QkVFb0haZytKQ2VrSVRydkR5RjdaVkswZ09TdFlSOVovamwxd2JNQ0U5?=
 =?utf-8?B?WmN1SUZNcHd1cWFDV29USllFUFhYNTN5ZDBIejVDMDI5bm1lcTNrT0lTNk9T?=
 =?utf-8?B?M0kyTjU0T0l0UWo2dFFNekVTaDcyVkQydjkvYWh0ejd4VS9KQ1VtYzVMSlhC?=
 =?utf-8?B?RDZ1SXA5NDllZGhIV1VGRWV2TGY5cEN2TlVzSmdCZ3djbmdDWWhGYmZFdU5V?=
 =?utf-8?B?K01rNE1iaEw1MG5HUjVCQklvKzRtNHBVTGFMNHpJZjdWU0dJR2lDUGEyZy84?=
 =?utf-8?B?VytxYlppU2lmQ2dxQzB3UnM1NXJLVERkVmQybFdzalVqWXFOeVJYam9haURE?=
 =?utf-8?B?UWFJSDJaQ2ZxejNIN2UxTXRmTVlVRnhDMjhlTUJwTlVBR1JvcjN4dUZaZmZV?=
 =?utf-8?B?MWhEUEhISWFvQXUzWlRJcjRKMzdnSk54U3hiNUkwREhzZzdGVGpvYlhZSFh2?=
 =?utf-8?B?d2ZRUFRDTFo3VFRUZFJQcy9PdW01eUpEMkRzN0RDQ0RCNHhBTDR3UnhlRmJn?=
 =?utf-8?B?aVJybFJjRllaT3hWcXVTNHB1M2RkVFVLZEI3VXBxZlFOR284TElRNlAzLzJH?=
 =?utf-8?B?QzFLY0c5UmFvR0x1NXRQcWpBUjQyTnBzaGprTENSZllVbENhU1oxM2xsdnUv?=
 =?utf-8?B?SzNjNHVXcGtzOGtqeWcxS1FKanVGc2U0SWxUcnhOajBiNUIySzBnZkIvcGhk?=
 =?utf-8?B?WENDVUxSWkdZVXgzOU51Wjd6M2Nka3FESUV4T1Q4TVpmeU4zMW9pQ0l3WXhM?=
 =?utf-8?B?d3FYckhOeXVnOGF3ZTJ3VnZ2UkQ5TzY5UnNmbmp6cVphMjh2dG1QUDBOY3Ix?=
 =?utf-8?B?UkM2OGZBSHdlczdNY2sxVksxd2szV0tsWTU2MmRMMUFWVENCMk05K2c4ZWRI?=
 =?utf-8?B?WFl5bDhMZ3pMejM4OStMWHJiRXc3YzNkZ2pGbFB5andhU3E5UkJqaGZPdEpl?=
 =?utf-8?B?VmJMTzdPYWxCQ3l5K1ZnaVU3NnVPamgrMzZCTHE0aHdlNm5sakNhQzhDYnJV?=
 =?utf-8?B?UVhjalAxMUxqOXVPNzhCVFRVY21tOXVhVG5iNkZJbVdWYTRJZUNnNXBzRER5?=
 =?utf-8?B?Q2g4THJRTUd2QUovazJFenlYdVV3NXI5MWduMjdwcFVuWm5DNGV1TjRscTRL?=
 =?utf-8?B?ckExeFpQSXhZdnM1VUhzdldhTmpiRkg4VFVBVGNaUUk4TndiSnA5U2l1clI0?=
 =?utf-8?B?Q3BjYlMrQkV0MjFNU3BnTnk1UXdBYzJqS254N3lER1JWSXRtVU1MS3EwNjAv?=
 =?utf-8?B?dWJtc3ZrazNjeVBzTG4xREF5T2JOME5ZeGUzc2N1ZTJFNVcvdnJ5U3dYeDZk?=
 =?utf-8?B?SHV0T1pQc08vdmpyQUJGSSsreCttOXA4VTE0VzFDUWQ5bmFlbWlTdmQxdHVy?=
 =?utf-8?B?cFpyOEN6U0U2Slo5VFlHQmZONklnVXZnWDYwcTN1QVNQaHBCakV6aE81dWt2?=
 =?utf-8?B?bXMxYndGa25nd3VUeUQ5a0gwVXo2QlBoVjFRRnVLK1pRaTVLdkc2WUU3d2Zu?=
 =?utf-8?B?WDFuNEV0VHV6Vy93RTM4dFhHcE5RPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2218a865-fe18-4ae4-7ca2-08ddebd57edc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:07:14.7470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7AWR4N5npoK3HEBebrSAm4KrZBSKL2Zbifj814aOiWxVAxDhR7HsqRZV/MZ5PR9KjEHnJNvYO3Yu8ReevLkGE1DpdBNbuLOR0pk5Izh2e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9491

On 2025-09-04 06:53, Thomas Gleixner wrote:
> On Thu, Sep 04 2025 at 02:52, Sean Christopherson wrote:
>> On Tue, Sep 02, 2025, Thomas Gleixner wrote:
>>>> I don't think any virt user should expect the userspace fields to be
>>>> updated on the host process while running in guest mode, but it's good
>>>> to clarify that we intend to change this user-visible behavior within
>>>> this series, to spare any unwelcome surprise.
>>>
>>> Actually it is not really a user-visible change.
>>
>> It's definitely a user-visible change in the sense that userspace, via the guest,
>> will see different behavior.
>>
>>> TLS::rseq is thread local and any update to it becomes only visible to
>>> user space once the vCPU thread actually returns to user space. Arguably
>>> no guest has legitimately access to the hosts VCPU thread's TLS.
>>>
>>> You might argue, that GDB might look at the thread's TLS::rseq while the
>>> task runs in VCPUs guest mode. But that's completely irrelevant because
>>> once a task enters the kernel the RSEQ CPU/NODE/MM ids have no meaning
>>> anymore. They are only valid as long as the task runs in user space.
>>
>> Paravirt setups, e.g. hoisting host-controlled workloads into VMs, have explored
>> (ab)using rseq.  In such setups, host threads are often mapped 1:1 to vCPUs, in
>> which case the pCPU in particular becomes interesting.
> 
> Why am I not suprised?
> 
>>> When a task hits a breakpoint GDB can only look at the state _before_
>>> that and that's all what it can see when it looks at the TLS of a
>>> thread, which voluntarily went into the kernel via the KVM ioctl.
>>>
>>> That update is truly a kernel internal implementation detail and it got
>>> introduced way _after_ the initial RSEQ implementation.
>>
>> Yes, but that doesn't change the fact that a user _could_ have come to depend on
>> the current behavior sometime in the last ~5 years.
> 
> So it depends on a kernel internal implementation detail which happened
> to be introduced by chance rather by design and without any guaranteed
> behaviour vs. a guest.
> 
>> I'm ok formally stating that exposing rseq directly to a KVM guest is unsupported,
>> but I would like to explicitly call out and document the change.
> 
> Fair enough. I've amended the change log accordingly.
> 
> If that turns out to be a real world problem, then it needs to be
> brought back explicitly into the virt TIF work handling code, but I
> prefer not to :)

That works for me !

Thanks,

Mathieu

> 
> Thanks,
> 
>          tglx


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

