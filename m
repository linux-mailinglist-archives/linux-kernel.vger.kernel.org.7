Return-Path: <linux-kernel+bounces-808331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39AB4FE34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C0A17A672C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA63340DA1;
	Tue,  9 Sep 2025 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TxNTNkWF"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020082.outbound.protection.outlook.com [52.101.191.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A377342C80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426015; cv=fail; b=S4rwz1xseeFHr8CzDbkdo4oTVjLV8vPakhFMBStbGZs68mZU3HMuZKFPlPqiW13TdingAQfW8MNNQ9FsIp4N9xw8j4EFBtyj3mSMyP+ey+R8J96aw9TmFdisZpXFy6AHdUqHkWj3oKyQ6ACHRN+wnCcXpLfvIXHx5tE4JELWIR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426015; c=relaxed/simple;
	bh=d3ZrDC2/Pmptb0jKDx+sBYXNkiCSLYylp3oiI3EXFd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MNszCFYxr2cCEQxCjluu8clrTNf4f2BaElcLWOjrtG2/0LuubnOx/0v2ZCpOOydSE+hNefFsDIiPB2zZ5XuQp0gXJzy8aCRRAWnSOsivrb6/rn4eyIMGqI3inVR8HjqRczF5INIYtof+NCvlt+g89yw0QffJkd2fIiE7vgCLV3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TxNTNkWF; arc=fail smtp.client-ip=52.101.191.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWb4GPULsprFH1ddrw89GoOP+aCwIq6Ev1UmDLmY0V1qsn6ngNcdj3lmway8+k5pf2kV+YPwmXZnmB63+XdD8PPIeKc1K+F5nFJROW3KpnLD1LJW5H/CziV0hBw0fTVjDzQq5dz/tZJyq5SwiMEIStBDljuZnAqgPlOkXpfe0lD/rQWz1XmoFVg8eWemQz5Xrbm4KZInl3YAhFdXsDofBoxq1XN3bk0RAwhJL/45X+glZTb1/bWuTmyr5dGkGIOygUAInPf64mH/IJLM3rljrG5bhEc5XF7duh+Ham4omyxovsfk+ffLgHbmcgUg1jJg+clH3D8SoNim7IwfIfVOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlaYC2bSj81KGqVJwbuLNubUVRgDa/3NxS37VRbQe+k=;
 b=Z8LX6I+IPE+JAxlk3a925c4BJXtlHPdPkpVxbtu0/NwBgaqgFTsUGZ16RZvVqKUuN6We/mlDZ9fYAJbWbBNAasxiUcN4F3dP4clUEDAvfzBNC2144flTzDHBCxSAwhOQ8nHje1VD/cSFME5Pzglfoevg4hA5Zepkx/LPNt002f0o3ahRyUu5jDKsfFg0AiT7in2Wo1X+Eu7py7h5FAiQZ+HsXK+0NkbiHdTnDH/nJeB2xxZy8Mkusox05Qixe4mNzbMPgfxhZ3hlvtQkqyAn5rzSAY/rysyBzgVrfuhZESXVPlZDOQgmcFMQrVF0HKbMVFLXgUjgK1cUvz9LKj5OLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlaYC2bSj81KGqVJwbuLNubUVRgDa/3NxS37VRbQe+k=;
 b=TxNTNkWFviphfgMkZGr0eBHigCK1kdzMKjDMKLPJoGdiWr2aBFTGcu6rW5Irbh+QqsYKhr9yT1uUy6F/bUn2JUyP24F3YcFzTyqbCudofoTDtxYCihUwyuHNQWwSNgo/5YZVf2mA8eiyFnGtvfFy1EKBilNDomDFbOnGK4kN+O39UNfA/KuJ46rI6ldPkUn/wIFPWrbo0M57nIC+XIsoGIIpaLfrHDcrpKwuY20Ik/q5Wh9PT8z8W+u8kKcjj4cj6/rnoGviMJHa8/iUem/TnkOEHWlAFkeylGW69gUAYp23N9eMhEUAggBL4nxD7uhF0CNt5A4ZoYEcqatGOLQLFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6548.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:53:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:53:28 +0000
Message-ID: <5911c934-db16-433b-a1b8-c5367e420248@efficios.com>
Date: Tue, 9 Sep 2025 09:53:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 15/36] rseq: Record interrupt from user space
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
 <20250908212926.225746125@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.225746125@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0203.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e4d460-6779-4cfd-32db-08ddefa84152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVppaXVBcHE3dUJZRzF0cWhiMGR3aGFuaWdHUkRiU3lJUmZicXZGeXZlZTkz?=
 =?utf-8?B?VUtZTUF4UGxEaHkvdnVOQkovMkZZRXZOck1ETG4yOWwvdEt6OFlKYmpkN215?=
 =?utf-8?B?MXg1ZU1hUUdqMW1GVCtsVndxTEUxcjN3V2Z2dW51N1Z3Z3VZK0JVc1NEVGt1?=
 =?utf-8?B?U0RWRUVVMlROWWNUSnYrTWg0L1JnTld5RUZoOTlXWGpLOEZUZ1I0ejhCaUFY?=
 =?utf-8?B?b0kyVERMYVVtWEFCb1QwK01nODgwOXVnU0lHSHE2WThmNTNDYTNad3NuNGMv?=
 =?utf-8?B?ZVRmOUdnakl0dEd3TDhNSU81a3hpNjVpaXJFMG9nbFJkNGtoYzVqOUZjT1RE?=
 =?utf-8?B?TXpVR0JQYUhKb1VjejFJM0ZLaVpQSkFpaXN0RjFaY2hOQ0d0NTdQUDFIbE5o?=
 =?utf-8?B?cGFzUkRSUjFuakdSVFFqWVlrTEZnZnpiOWpXTkJOR0lLclk2L2tkU1lSVStp?=
 =?utf-8?B?N0MwdnhkY0MxTEg2SVhzTTVJV2FPbm56MWhjSFUrUTZaOU10NjZFWnNGYnlM?=
 =?utf-8?B?b0xpamxNalFnNTVYcWROdGxleUYzbGtTTmc1U2dyN2JtWk9CRmtmMHZiSnU5?=
 =?utf-8?B?cFpJRG1sbGMwdDBmbGd6N3RqUDM4MisveDZZblNzRGQveE80bWpLazByMFl0?=
 =?utf-8?B?SlIvcHEzWTZaMnZEUkRWWE9kSjQycnBMNFByVTZHS2N2YVNxZndUNFRFb1FT?=
 =?utf-8?B?YVhNeElndHdLZDV6N2x2YWJsQUNhU0lyVXhwemhJUDluc28zTk5EWDNsRUp1?=
 =?utf-8?B?Ry9EdjYzOC9NRTRPQi9lNUxtVkwyZHJrWGFWamszaWdqQm9rNnFXNzhPVlZs?=
 =?utf-8?B?TTl3Mm5oY1ZGckhpNkJ0UjVNM2pGUkR2MzFJNC9NRFloT0ZKWG5id0ROZmls?=
 =?utf-8?B?SjhoUEV5cFZId1lXTUVTUCtvSWdsdWh3RURETDRlV2VZa2hRakRQWDdqd3p1?=
 =?utf-8?B?amJ3QU80bEZSQjJaeHNvNmp2d0Z1Q0Fod2dMNUh3aVRqN2prNjJQRG9SRjN5?=
 =?utf-8?B?cDB6a0xhK0djUHBnSUhDdDNNa0h0Mk1SeGpQODlKdXJTbExtb0NDL1RUUUJL?=
 =?utf-8?B?U0hMUVJwZFRNRm1yT0V0OHdZVkR6aC81VEgrODl4M3ZGZ2RrMWlPUU9qSVBW?=
 =?utf-8?B?WmZQc1dFNDJVSkJyY3laVE1TS3dsODJuT1pKWllUaUk2WUdOYmJGdjY1cm8z?=
 =?utf-8?B?bG1SQktCMktLeFp0YmUxbEk3OVQ5Y0dLRlBCZDZlbi9wU3BqaXBMTDMzY1B3?=
 =?utf-8?B?TkEwRFBnTEIxMlliQy95NVgwTGpEWERVbVpUNzZRV20zbDRzTUU0WGF0Uytl?=
 =?utf-8?B?RHhCQlB3RElORjliOWh3bnB6MFZVNVI1V3hrZ0pVZFk1TExPUjBFUWg5SzM3?=
 =?utf-8?B?Uk16M2lrRVhjUm9rbjFUSERiOW5XNGZrUVlvM0RmQjhmVmRJMVV2WGVLYllC?=
 =?utf-8?B?QTFKUVp1MDlZQVpKUVgxUVI3cjdmN1NHMXhoQjZ3QU9mRTF4R0xkNlpNa0g4?=
 =?utf-8?B?VUJ5WENRODJzSmJwY1lXdXZxSysrZnJ3bXQyL0dURXA0SUFVeitScXdlRnNN?=
 =?utf-8?B?T3cxalM1cHQ2em9JZUR6T2dvb2E3bmJPeDRDODd4bmNFa05BZnQ1enVhWVdE?=
 =?utf-8?B?ODlwVXcrRndjb1N5ak9iNW5yYWVienB2Rm5nd3hvWnp5SVdhems4a2hodE9I?=
 =?utf-8?B?bS96dUxrMWdjcFpGN3ZLTUJUQnhWWG1scHQvL0poOHlFNS9rempVZy9IcDU4?=
 =?utf-8?B?UGZCVE4wSkZZOXdnR1FKRk96ekEvTmVYSWs1bFV6VEFyQWFPYmlFR3pCelVm?=
 =?utf-8?Q?fb9ntKr2hR4Kzz+gQHaWJZ5eGJ3wUSjzfuAfU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qmt3MXYrb3RnTVQyZ1k0MWhXQTN5Wmp6TW5ZeVNyUkFYVEk5c01VNkYyUm5r?=
 =?utf-8?B?dmt0L1RpdlFCNVdUM21GUlo3bnBFTkQyaWx2WkVEakpoYW1LRjdDMkxHcWg4?=
 =?utf-8?B?d1F5bFpMODNrcXAxYVdRNktuOFNiS2tXTEJuYnZRWTlNOUJYeC9BQ0pWR3pQ?=
 =?utf-8?B?Qm1LYk1RTWp1M0tEc3Nta1ZHTDJNSmFhSEJINDU0K3RoVzcwaHdxclEvMCtE?=
 =?utf-8?B?Qi81bzVOWHVzZlhBSXBscUt5ZE1NRDZZUng4cEd0ODZVQmRVSm9XRUlMSWVk?=
 =?utf-8?B?aytnOHhuNEI3SDMwZ1RMTU5tNFFKOURCcXE4NlpyRWIyQWo3aGVRQkVMZXpE?=
 =?utf-8?B?SUdlclRuN2ZqNlVqcDJBQmRMaFZDc3ZrTWNHckgxWjFycGF0VzRoTEdKYzVR?=
 =?utf-8?B?WXFwamJhTklGS28rLytlMGF1b05TaTV6Y1ZHOVFqMXRZbjFGRFBvMXR6SXRo?=
 =?utf-8?B?RjBrYjNlV2VzRFFaNk43UFMyem5LR1ZGQXdYUktERGFnWWhtclYxWFZFTXBu?=
 =?utf-8?B?YnlyMzB1Wk5UeW1YeHJkaGo1OWsxdzhPLzJtUGN2Mi9zcDFuNStRNDJHK3Vr?=
 =?utf-8?B?K0Q1TGd3M1JKaVN1a1UrYVBmK3pKUk0rTWtCVnpuc1lwaHlkd21iUk0zQVgx?=
 =?utf-8?B?S2RrajdJOVZkUnYrVjI2Wk5PbFlZMG9oYnNUV3NSMG1NSWVIanhJMDlCY1FS?=
 =?utf-8?B?VENnMlQ0anFtbVhGQk9kK0NCTGdoenJsWkwzQ3J3NGM1MDE2bHdwd3pRSitH?=
 =?utf-8?B?SHlJbWhOVi9nd05JRHYxSGl5L0VWS1hQU0xWL0U2TzZyb1pHRVN2aFJMa1NS?=
 =?utf-8?B?OUVhdEJxSE5xMVVXT2h0and4WFJRRmxZRTcyZjdxQS9Rd2Z0NjEycGxicmdN?=
 =?utf-8?B?L2ZZL0pBUlRkSW1jckFJK243VFRqd1hVTm5kRHVuMU4zTGNCOGlyQXFHMG1H?=
 =?utf-8?B?YWJVQjFYQi9vTjV5dktjTDJLTlpRVDEwdnEwaHpDSnE0cm5PUU55OHpZSEV1?=
 =?utf-8?B?UHlDSEd6amhRSkxvOENTWVdyakRXVnFNcGhldk92WnJqUXVFbEFLTGJqTEtG?=
 =?utf-8?B?dm1GaVlhNGpYVk0xZE1BRm5LTVFDZjhNTC9qakJBcmE3V3BIQzU1blBmeUta?=
 =?utf-8?B?TVh5eE9qc2p6OVVkRnJsK3Z1ZW5INVkwMkhERkx3SkgrYVhMRXVicWFMQnJk?=
 =?utf-8?B?NTdmMC9JNjN6R1RvcThxMUxjY25lNS9jU055amYrQWZEWHQ0MzJCSEJwMnlE?=
 =?utf-8?B?d3A0VGhqQnRGQUw1UGZFUFFDQ2tNRVpQVTVRK3ZNQ0w4S1dKSi9ZNll0MGh0?=
 =?utf-8?B?QStsMVQ1cEw0eVByTEhtdnZQQlJMbmVsQVh4RnJXWlozT1REYnFNNkh6QlpL?=
 =?utf-8?B?VWZlclN5Qzc5WXdiak5zMGh1Uk1FS3YyZ3grOEdCN3R1MDB6MmF2N1JXZFk5?=
 =?utf-8?B?REhBQXhiL1NMaGZLM3pDZUorQkQ0Vk42aFBsVUllWjA3ZVdwTVp3bUxHbzVJ?=
 =?utf-8?B?TWhNQXRaU01JRUdUK0ZKV3dJWUN2MlhmV0hLVTdaZlFoZDFTUUpwclVPMFAv?=
 =?utf-8?B?eVlvNUVEK0pacU85RDJFUWJBV3Y4bUJabVZCUTVHZmF0YkZ2akZmL2JkcWtI?=
 =?utf-8?B?Zi9md2tybnNNTUgzVnBXZjJrak10VTNYNTdXQmxORzcxYlpuSytPSm85NHM5?=
 =?utf-8?B?c05sdENxTi9KbUx0Q2RQbFU5K2JFcGpuQU4xUlNCOTlLcDUyd1p1UnY1Ulgw?=
 =?utf-8?B?Tzlxeit6MUU1WFJWNVE4WS9BZ2dLVUN4ejdnd2JrbGxhN3dDdmdEMnRaSnlv?=
 =?utf-8?B?RCs4SU5wRk9iTFVyY1pZS3RvMU95MTNwNzhCOUJBM1NDbjN6bktWcVVVWUJR?=
 =?utf-8?B?cm5WRnoyNHpLYWlBdm5GRnNUN3k2NXdSUTFkR29xTFBLZTF1bUp5Mk43UVRF?=
 =?utf-8?B?K1o1cDBkbHVtcldLNXFXM05mczJWcU5qUE1mMVFuMTVGRWY4STBDVUZzZDFT?=
 =?utf-8?B?TkJtRUtNYXJCcUJ4MWpldWdFdmlpYURPbWhyNURlamYvZ080VDVQR0hGdGk2?=
 =?utf-8?B?VHNqbU9DNXhBdXAyM1QzM0RuRll0QXVOblBmaDFOV2xRV2xobWw5YTFEUEk3?=
 =?utf-8?B?UmNNWU95ZEhxY2p5SUw2VDZEcUl6ejVkWEJ2UVAvaWloaEJyWTlzWmkrbWlF?=
 =?utf-8?Q?TaPfgwNY7UmiCQTdnN+cvkI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4d460-6779-4cfd-32db-08ddefa84152
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:53:28.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HsOrbqawH3Cm5rllaM6/ix5JkRYQBbrXExO1Bblj961urr9W2UHec+FANvzPlQ1ojRFkDN9rILJ3HUFBadWyRcpFgwzr5zhIxI+5LGUpzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6548

On 2025-09-08 17:31, Thomas Gleixner wrote:
> For RSEQ the only relevant reason to inspect and eventually fixup (abort)
> user space critical sections is when user space was interrupted and the
> task was scheduled out.
> 
> If the user to kernel entry was from a syscall no fixup is required. If
> user space invokes a syscall from a critical section it can keep the
> pieces as documented.
> 
> This is only supported on architectures which utilize the generic entry
> code. If your architecture does not use it, bad luck.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   include/linux/irq-entry-common.h |    3 ++-
>   include/linux/rseq.h             |   16 +++++++++++-----
>   include/linux/rseq_entry.h       |   18 ++++++++++++++++++
>   include/linux/rseq_types.h       |    2 ++
>   4 files changed, 33 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -4,7 +4,7 @@
>   
>   #include <linux/context_tracking.h>
>   #include <linux/kmsan.h>
> -#include <linux/rseq.h>
> +#include <linux/rseq_entry.h>
>   #include <linux/static_call_types.h>
>   #include <linux/syscalls.h>
>   #include <linux/tick.h>
> @@ -281,6 +281,7 @@ static __always_inline void exit_to_user
>   static __always_inline void irqentry_enter_from_user_mode(struct pt_regs *regs)
>   {
>   	enter_from_user_mode(regs);
> +	rseq_note_user_irq_entry();
>   }
>   
>   /**
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -31,11 +31,17 @@ static inline void rseq_sched_switch_eve
>   
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
> -		if (WARN_ON_ONCE(current->rseq.event.has_rseq &&
> -				 current->rseq.event.events))
> -			current->rseq.event.events = 0;
> -	}
> +	struct rseq_event *ev = &current->rseq.event;
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
> +		WARN_ON_ONCE(ev->sched_switch);

OK. Now I'm confused.

It is perfectly legal to issue a system call from userspace as long
as it's not from within an rseq critical section.

That system call can be scheduled out, and can set the ev->sched_switch.

This would cause the rseq_exit_to_user_mode from system call to
hit this.

What is disallowed is only issuing a system call from a rseq critical
section. The other parts of rseq (updates of cpu id and mm cid) still
have to happen when returning from a system call.

What am I missing ?

Thanks,

Mathieu

> +
> +	/*
> +	 * Ensure that event (especially user_irq) is cleared when the
> +	 * interrupt did not result in a schedule and therefore the
> +	 * rseq processing did not clear it.
> +	 */
> +	ev->events = 0;
>   }
>   
>   /*
> --- /dev/null
> +++ b/include/linux/rseq_entry.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_RSEQ_ENTRY_H
> +#define _LINUX_RSEQ_ENTRY_H
> +
> +#ifdef CONFIG_RSEQ
> +#include <linux/rseq.h>
> +
> +static __always_inline void rseq_note_user_irq_entry(void)
> +{
> +	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
> +		current->rseq.event.user_irq = true;
> +}
> +
> +#else /* CONFIG_RSEQ */
> +static inline void rseq_note_user_irq_entry(void) { }
> +#endif /* !CONFIG_RSEQ */
> +
> +#endif /* _LINUX_RSEQ_ENTRY_H */
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -12,6 +12,7 @@ struct rseq;
>    * @all:		Compound to initialize and clear the data efficiently
>    * @events:		Compound to access events with a single load/store
>    * @sched_switch:	True if the task was scheduled out
> + * @user_irq:		True on interrupt entry from user mode
>    * @has_rseq:		True if the task has a rseq pointer installed
>    */
>   struct rseq_event {
> @@ -22,6 +23,7 @@ struct rseq_event {
>   				u16		events;
>   				struct {
>   					u8	sched_switch;
> +					u8	user_irq;
>   				};
>   			};
>   
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

