Return-Path: <linux-kernel+bounces-808237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99600B4FC50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259431BC777A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51001340DA3;
	Tue,  9 Sep 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Jk1EoWSK"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2119.outbound.protection.outlook.com [40.107.116.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F9D32BF23
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424084; cv=fail; b=kZNid4FvJdoaBIxwfJAfsMoT/trBQkAAdl3ufMp8NG1cM/rnnKu+Me/zb2FihXK0Fj5nfaXmegOQxdJbuYW4guJLXYTa6NPxuFaH7qJfxPTrZYH6NwQiCWH4hlxSSUY3v5eJRpAzYVuC7Q28wiMV0fPBwPYIbqqqU+9oOrdzv6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424084; c=relaxed/simple;
	bh=6wpsgFcRcUiEA9FGgLzBFb5iUFzuDQCQs/dJHTA3Xw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RHgq1dJNOaQwUPbqzBc1A0uZC9U55QGpOi7x7xymbe7itgUCqXNfrVmlJV8jQe2c1ZhwHp+7+ZszXCSRJqRu4I2pE8iTnBR0t/ztsQ0X2dLUVHeQ+Gx85zYNpVnZ3ex57JguPzDlSI8MnpLLzqWUqzWtcJXfhT7bw1312Eakhbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Jk1EoWSK; arc=fail smtp.client-ip=40.107.116.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVK/J/XzMyErMEOVMGAUJ2IIv8KN5xWBo6y/ejmpYbp5+O4nj3+N3/axgOniQZHBeE4HOlSsB0sgH3qgUvbt/keSJqu0WvWxSyKiVYEppzmqcRbBxVsV/6O9MRUJE6nM846OB1a8RtL46A+D/Hmmj3UzcHDh5PW57702SeyBXsSia04m9C042j4ISKePg49ug92zWIMqpWgFY3zrMYS60LsyUGPk0dr85cottWrMO3KiAjQ8G4KlnwKv8UN7g8C0oKUojo6lEk1Y/MUZGaWiGwJHbe7kf7NOsEg9TG4W2qyw4tchRKmzf3VOhHoRncAQiH4aonCJi1oGzXBI3qpbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkrNSK7qxiZdahrTWnJKMjRHTYKVgX1hcjL4EFyG/8o=;
 b=UgWXqBTxC/mn6vSBTr7el9LlJNthSJRhOF1VlfnGLCBSlbIBuSlaWhOinDkrAWqwOHEz9vol6TrblCLTl6/w/57OLpFA32JGzsEK8CWhddOBBFzZWi8F4fGUaK2MVz5xZG7KmphqXBiXyxysKpL2J3SzSlHtBLQ9pyngABjqov1/pSix6rFEyKanJKx1McpTgurqhp8wySpapjlF1TpCf43BpyXnmw0a34sbm5K0J9QV7Il/wwGVwOfYA7AcmU9IoRJuFtHaumI90mln8Nc/TZLEH/QbNeCH7O64pGo2itW+8Syctv6otZTYSvymJrwLci2sLgC72RmDndCGtpPKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkrNSK7qxiZdahrTWnJKMjRHTYKVgX1hcjL4EFyG/8o=;
 b=Jk1EoWSKMkImYGLqhexRD/R1k1ZirKacVyU/Zq9/9xQ1u7+1KcV3xMus0K68rkIduaaqlnMVoPkwyIOus6Q5N2eopnxouTeH2csLlvxBIqTZtUY4k3iKMIIy5sL+mW6IGQOjfceiL3sgf84iDZijlcU8a4ZijThLunZ0PsPY/yhnLhNb9/5ZDYcZr48apFncb2uPM4GwjDS6gRGhQp1pZ+l1fynQNdSL4seXUPnCCFhZFGZP81R+5sphdMH2uGmH7oj0mJUGtpX3nCYt256dHOliUgf3WWR21iTExHbtFZ6bpOuJF/ZmXiuHN9vQNXXneYmggs3RpD+bWrTsh7e49A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6276.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:21:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:21:14 +0000
Message-ID: <ee2c27ed-1c72-4fff-8798-1ad20016da95@efficios.com>
Date: Tue, 9 Sep 2025 09:21:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 07/36] rseq, virt: Retrigger RSEQ after vcpu_run()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250908212737.353775467@linutronix.de>
 <20250908212925.708769718@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212925.708769718@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e38926d-d36d-44cd-9861-08ddefa3c067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnR5aHpPS3ZOSlBkaElWKzRyTGtXQW15UHJTWmkzL29yb1pOL3lXSWFLYmZX?=
 =?utf-8?B?WFNpK0JQT1dkVkxIUWlMNWdnZiswWmxOb0kyL0pzSEd4MHNCZ3NneCt1MXRl?=
 =?utf-8?B?R3F2QTZjUjhONEZpU2lxeVZjK3laY3BabTA4VWt3dlBTSGRlSDBoTHJIVXhx?=
 =?utf-8?B?N3hpYTdnSG9OdHVsakdQa1Y3UDlnWVZ0QjhTbTlFNXNUMThMUEZ1dG5VZDRL?=
 =?utf-8?B?cUhVRUNPU0VzbmtLWEhGWnpOT0d4bWZqWTIvSXlVbytlZW1aNFMxMUJCaU95?=
 =?utf-8?B?T2wrczdDeGJQUGtNVElqd3hncWltK3AzYS9lQkt3Rml5L3lXUVhPbW9ycW9E?=
 =?utf-8?B?L3JNQUxtRmhRVzgxZlo1WG5Dc0JTY2pzOTBoemdmWDF5ZE9tcGpuN2U0MjM0?=
 =?utf-8?B?U3ozMUp2cUkxSGgzMEZmTzhLOE55OThRekEzVFIvZjRaTlpqanNBaXJsMWV5?=
 =?utf-8?B?bWJlT2pHWGJSbSt6UHJ6dnl3ZUtTWWorZzZ6ckg4VnRNcmdHK21ROWlEWmQ1?=
 =?utf-8?B?VDJZenVEMDhtKzZLTGRtQmt2V2E5ekZ2YjhKSFN0emhJcGhDdGxNNXB4VXM3?=
 =?utf-8?B?MzJPbXBVOWgyM216bXU2VnBIUWN4RkZxWDg2bS9peUdWSlpJd2VaZjNVRjBu?=
 =?utf-8?B?T2hyS3lLOXRHcnFUbEcvM05rT1RrdEdjQnNIbnNEeWx6ME1EUEprbEFiL0Ji?=
 =?utf-8?B?dGJyQU96Z2t2SXB3QmxVZi82RThTQURzbS9LRVYwdUluK2F2ZzdXMG5ZSC9i?=
 =?utf-8?B?aE4veVpzaUowME83OTdWMUxDKzdJRWNUb0FnTGJhK2tmZDVQRHhHV3Q1cFdM?=
 =?utf-8?B?UHJZTkxyTTIwU1JxRlo0YUZId1JXdTJYSUs1UFUrR096QjRoeGhrUzlJeEF5?=
 =?utf-8?B?ekw0aFA0Q05iYjZ4OWM2YS8xL0pMQU16Ulo4VVU3T0ZMTndMOHk3WnRhTFdL?=
 =?utf-8?B?NHJNdm11d2xYNkdxU0pRazN2NFIzN1VKeXc2bmY1ZGppekx2TmVCeE1tNFZM?=
 =?utf-8?B?Y3E1YlBWQjdFSkdGd3dzcnNCQzgya1lsbzZPZzNvL3ZGVms0Y2lVbTFKSkYz?=
 =?utf-8?B?WFRJaVk2cmJaSTViOTVHdlpONkRMMjlTbjgxU1pSaU9mcktEOWQxclFZalVY?=
 =?utf-8?B?a1JDRHFNUGJtaDdFQ1Q4M3lrVCtGTTZzMkVOZEtWQnJET3lxZ0Q0WUhtbDFu?=
 =?utf-8?B?K3A5Y1F0TTZveThrYmJlSXJYRm1aLzl3OTBhMFBvNVN1cTU4Wnhzb09Randv?=
 =?utf-8?B?UE45d3ZRWE4rd0Z6V1ZueHNRK2R0UTNpY3BKUlhXakJ5dTBqd2RjTnM0QWFG?=
 =?utf-8?B?QVZiYTljL0pMWDNvSG1VTTRpckNTWEczKzk4cHJkTWlBQS8yQjJkaVN6VU5z?=
 =?utf-8?B?TEZpYlRXTzZndU42QzgwKzR1cXFyNFg1VzNSeTl1QzNZSjBRd3lQbG1rVnEy?=
 =?utf-8?B?d2NLSXR4cno5U04ycTdyNHpSL2p4clpqN215RFdtdXROazRZRVZZTEVHSzlZ?=
 =?utf-8?B?VXQxTUtJZ0doeGlKYTJVVlU4cUluS1RhbFBMQUY4Ui91Q2xMSm5HcWJDUFNo?=
 =?utf-8?B?VXd0R1ppYXZuaCt6MGpiZDFBbHY2TnhLNkkzWUFUWENIdld3b3d2SXJDVTNx?=
 =?utf-8?B?VkZTUjlUb3pVNnRmenFzbzJZOUpkaXFlWkhyL253bkI4Mm5iMzBkazE0alRi?=
 =?utf-8?B?dWY3Z0hDQXBoSHY0Zjk5VGdkRW4rSUNFVXJzZDMxVUt2dTRMakJmbXQ1clNh?=
 =?utf-8?B?SkFPQjA1UWNxbWtTb1NzcTRYbVRxYXNmZVdLbFlMdmlLNTNyS05lS1NaLzJt?=
 =?utf-8?Q?DkpV91JFel32MSeBeBoY/onGPr5jrHD3rKRp0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDM2bnUwRUtuNjMxaW1LWW9mTHJ2QTBTakEyU0V0TFBYQ0psN3k5OTB2dSth?=
 =?utf-8?B?bDI4NG80VytGYVZhZW5BS1RidWppZ0dpbTZ1UGtFMzFWK3hvVmk3MmI2aHRm?=
 =?utf-8?B?Znd5N21jMEx3QlZKV2tTOWJQVE1heGFQcVlXenhKOE8vZUFxUXYwamUyTXUy?=
 =?utf-8?B?amQvRitQcy9lQ3BLOGJIOGdGNGpkYkNiN2poU0RxMWkyZUlaWkVjSm5MUkdp?=
 =?utf-8?B?ejFRYVUvbUFLbzkwMTFEb3RuUTVEaXBPdytHNFhjdjlBMHgveVVzSmFkMldL?=
 =?utf-8?B?NFFmdloxbTNPM1plaW1UYUE3Mnh4MVNuWlU4TnNicE5qdFFUbnhJK05CVzE5?=
 =?utf-8?B?Z0lxWlJiTnRHT2VRUzlqelBPNkI3VlNyTWlwZ1F0TjBzUDVPMklGbFByVXoy?=
 =?utf-8?B?YjlSOEdTYkdCUGFzUjg5d1M2ZUR6OFZTRVQrelVHMXI1VmU0T01FY0xQaXI2?=
 =?utf-8?B?Zk5xOWdOMkhPWDdleGJLcjdlNXFRV2gwUDlKdWRtK0J5VXJUeW5qN2kveWdq?=
 =?utf-8?B?N3pZUW9yOGZBU2ZlMytlYWFyeGE2V2hESnV3NE80OC8rNWxOVmcwWW1NdDdU?=
 =?utf-8?B?OThsZUJOTWxSL2JIcTdQNzRwOElINHR6Y3ZsS2ZCZWdYZWdBRzVvWXo4bzFj?=
 =?utf-8?B?Qi9sTUt5UVVOQU9sdFNmK3o3eWU4enBGYTZWRlBZNUdNUDdacmFpSlVYQUF6?=
 =?utf-8?B?bW95KzZMWTJuRnp4WXJNOFpVSFRoTTJKcC8yQnlVQllXb0R0RU5NckNZZ21J?=
 =?utf-8?B?MGtRUUw4M2NXbXlyWnVuL1hkOVlaWTdjcjhLdS9uUDFURFF5Qk5QcXJEaVhG?=
 =?utf-8?B?Y3JCcklBTFd0ZjYyTExpeXpoaXpiMHp3a0xCUVd6SFRkM3ZnZzFRaWNQa3M5?=
 =?utf-8?B?KzBzOS9YM0tkNGJtbW53ZEE1cWxTRkkzVG0yVlhaN0RZTmxVT2N3a3RXYjdv?=
 =?utf-8?B?czNCVk9iZmYvLzJINWh4SnRka3JyQ1ZpS3lpZkJzNFNVUUtxUGZGZWVBVThv?=
 =?utf-8?B?aWFkclBnMklQL2o5d3hmbjBydG1ETzlud1N5eTZqN2p2cndWb3V0T1M2TGNv?=
 =?utf-8?B?aGJoV3R0QzZHMHQ0T3lmRzdhcmpZWENHcmFFeVpCT29oQ1FVc09wdUxyVENZ?=
 =?utf-8?B?TVA3R2hQRW9GRU15bVd1NFo4alZUODVFQUtka2RvOXJROGZFbmNBa01kQ0ZE?=
 =?utf-8?B?M3RsWURvY0dmY3o0NXJOSXdkeUhaUkFyU0xrekdaQ1NLcGZqcng5ekUweXZO?=
 =?utf-8?B?TUh6bHJsa1p0SjZuNjhRRTEwbUg1VVF0bEVxZzdoMkRHbkJUb05YajY3VFk3?=
 =?utf-8?B?SkVsNHNvNkcrVS9RZS95dlZCbDd0Mk9hVXprblZnNXVLYUdCbTd4dzkzMC83?=
 =?utf-8?B?VTdIVTcwbWtVSEMvTWI4WStzbmJva0R3RmE5RWxEMGdWSUVSOFhlc090VkZr?=
 =?utf-8?B?S2NTR2pHUXpkSTU0N3JBeHQyQ2JXVmxmL2U5ZityaTl6OU1Yc3Fibmt0c0hr?=
 =?utf-8?B?ODZRMXhlSGJpRitYa2dnVmxDZDNiaWRXNmtZd2pDQ2YwTEZZQmlITHNZRnMv?=
 =?utf-8?B?OTRlSCtUVllFbXlCd0wvdFJWUkxHOU51T1hobGErcXYvQzB2b0hJQk5mQ0g2?=
 =?utf-8?B?TXhkcERzWXhOUlYxNUZkVGFvTC9QRFAyMVJpby96ZVo5ZkFOcmVJSzlqYW96?=
 =?utf-8?B?dklyTS91Uy9kbndlSVVhSDBDekdnUmVDenR1QTFvUnhtNGFKWm5sSjNtb2t0?=
 =?utf-8?B?UjhSTzZVUlNVa3hhMzh4ajJkQTl1WTIya1lLUk9QVzJBTGZWS2toYkdNb3RR?=
 =?utf-8?B?bjY1UW9sZzM5MDIrTUNCSERhRm90U0ZENjEyTitENEowSTJteDJlK3NHUHhF?=
 =?utf-8?B?RkxyUk5hYUxUQ0k4OUxGMnRvWThRRWZ0Y0JrVjY1aGdoa1Y4RjV1M1dXNE1w?=
 =?utf-8?B?QlYwYWFhNkp6QjNKLyt2NGtFTGlyWG5tT1NXTVFscjIrMDZFajN3UGlaOWNl?=
 =?utf-8?B?YldFU3JGbGJJU1gzVEJOeGlCNndZMDZIWThHLzNTSW5HV0RPakdWalZpWkhI?=
 =?utf-8?B?blY5SkZ1OC9ieHhJS29XdXNZNHkwcTN6Njl3ZnczL0tIUXJyTnd4enNuQ2lz?=
 =?utf-8?B?bXlXUTdFa2pYa1lCNWM1RmtFREpBRzRKaG9PaXY5QTdpMFl5V2RpbklVKzlP?=
 =?utf-8?Q?gYz6fXgXX3s8CtVLHfXZEWE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e38926d-d36d-44cd-9861-08ddefa3c067
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:21:14.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YCRkUzZKLgBTR4fGpwIXme76bYr6+BJwwgDi9GicKje9jHzBxqNutX+oUyol7N7yKXf7d3qXdGza81C6m+exa5x/FBZTwk9xX0T3ZttE9cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6276

On 2025-09-08 17:31, Thomas Gleixner wrote:
> Hypervisors invoke resume_user_mode_work() before entering the guest, which
> clears TIF_NOTIFY_RESUME. The @regs argument is NULL as there is no user
> space context available to them, so the rseq notify handler skips
> inspecting the critical section, but updates the CPU/MM CID values
> unconditionally so that the eventual pending rseq event is not lost on the
> way to user space.
> 
> This is a pointless exercise as the task might be rescheduled before
> actually returning to user space and it creates unnecessary work in the
> vcpu_run() loops.
> 
> It's way more efficient to ignore that invocation based on @regs == NULL
> and let the hypervisors re-raise TIF_NOTIFY_RESUME after returning from the
> vcpu_run() loop before returning from the ioctl().
> 
> This ensures that a pending RSEQ update is not lost and the IDs are updated
> before returning to user space.
> 
> Once the RSEQ handling is decoupled from TIF_NOTIFY_RESUME, this turns into
> a NOOP.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> ---
> V3: Add the missing rseq.h include for HV - 0-day
> ---
>   drivers/hv/mshv_root_main.c |    3 +
>   include/linux/rseq.h        |   17 +++++++++
>   kernel/rseq.c               |   76 +++++++++++++++++++++++---------------------
>   virt/kvm/kvm_main.c         |    3 +
>   4 files changed, 63 insertions(+), 36 deletions(-)
> 
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -28,6 +28,7 @@
>   #include <linux/crash_dump.h>
>   #include <linux/panic_notifier.h>
>   #include <linux/vmalloc.h>
> +#include <linux/rseq.h>
>   
>   #include "mshv_eventfd.h"
>   #include "mshv.h"
> @@ -585,6 +586,8 @@ static long mshv_run_vp_with_root_schedu
>   		}
>   	} while (!vp->run.flags.intercept_suspend);
>   
> +	rseq_virt_userspace_exit();
> +
>   	return ret;
>   }
>   
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -38,6 +38,22 @@ static __always_inline void rseq_exit_to
>   }
>   
>   /*
> + * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
> + * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
> + * that case just to do it eventually again before returning to user space,
> + * the entry resume_user_mode_work() invocation is ignored as the register
> + * argument is NULL.
> + *
> + * After returning from guest mode, they have to invoke this function to
> + * re-raise TIF_NOTIFY_RESUME if necessary.
> + */
> +static inline void rseq_virt_userspace_exit(void)
> +{
> +	if (current->rseq_event_pending)
> +		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +}
> +
> +/*
>    * If parent process has a registered restartable sequences area, the
>    * child inherits. Unregister rseq for a clone with CLONE_VM set.
>    */
> @@ -68,6 +84,7 @@ static inline void rseq_execve(struct ta
>   static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
> +static inline void rseq_virt_userspace_exit(void) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -422,50 +422,54 @@ void __rseq_handle_notify_resume(struct
>   {
>   	struct task_struct *t = current;
>   	int ret, sig;
> +	bool event;
> +
> +	/*
> +	 * If invoked from hypervisors before entering the guest via
> +	 * resume_user_mode_work(), then @regs is a NULL pointer.
> +	 *
> +	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
> +	 * it before returning from the ioctl() to user space when
> +	 * rseq_event.sched_switch is set.
> +	 *
> +	 * So it's safe to ignore here instead of pointlessly updating it
> +	 * in the vcpu_run() loop.
> +	 */
> +	if (!regs)
> +		return;
>   
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
>   	/*
> -	 * If invoked from hypervisors or IO-URING, then @regs is a NULL
> -	 * pointer, so fixup cannot be done. If the syscall which led to
> -	 * this invocation was invoked inside a critical section, then it
> -	 * will either end up in this code again or a possible violation of
> -	 * a syscall inside a critical region can only be detected by the
> -	 * debug code in rseq_syscall() in a debug enabled kernel.
> +	 * Read and clear the event pending bit first. If the task
> +	 * was not preempted or migrated or a signal is on the way,
> +	 * there is no point in doing any of the heavy lifting here
> +	 * on production kernels. In that case TIF_NOTIFY_RESUME
> +	 * was raised by some other functionality.
> +	 *
> +	 * This is correct because the read/clear operation is
> +	 * guarded against scheduler preemption, which makes it CPU
> +	 * local atomic. If the task is preempted right after
> +	 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> +	 * again and this function is invoked another time _before_
> +	 * the task is able to return to user mode.
> +	 *
> +	 * On a debug kernel, invoke the fixup code unconditionally
> +	 * with the result handed in to allow the detection of
> +	 * inconsistencies.
>   	 */
> -	if (regs) {
> -		/*
> -		 * Read and clear the event pending bit first. If the task
> -		 * was not preempted or migrated or a signal is on the way,
> -		 * there is no point in doing any of the heavy lifting here
> -		 * on production kernels. In that case TIF_NOTIFY_RESUME
> -		 * was raised by some other functionality.
> -		 *
> -		 * This is correct because the read/clear operation is
> -		 * guarded against scheduler preemption, which makes it CPU
> -		 * local atomic. If the task is preempted right after
> -		 * re-enabling preemption then TIF_NOTIFY_RESUME is set
> -		 * again and this function is invoked another time _before_
> -		 * the task is able to return to user mode.
> -		 *
> -		 * On a debug kernel, invoke the fixup code unconditionally
> -		 * with the result handed in to allow the detection of
> -		 * inconsistencies.
> -		 */
> -		bool event;
> -
> -		scoped_guard(RSEQ_EVENT_GUARD) {
> -			event = t->rseq_event_pending;
> -			t->rseq_event_pending = false;
> -		}
> +	scoped_guard(RSEQ_EVENT_GUARD) {
> +		event = t->rseq_event_pending;
> +		t->rseq_event_pending = false;
> +	}
>   
> -		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> -			ret = rseq_ip_fixup(regs, event);
> -			if (unlikely(ret < 0))
> -				goto error;
> -		}
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> +		ret = rseq_ip_fixup(regs, event);
> +		if (unlikely(ret < 0))
> +			goto error;
>   	}
> +
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
>   	return;
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -49,6 +49,7 @@
>   #include <linux/lockdep.h>
>   #include <linux/kthread.h>
>   #include <linux/suspend.h>
> +#include <linux/rseq.h>
>   
>   #include <asm/processor.h>
>   #include <asm/ioctl.h>
> @@ -4466,6 +4467,8 @@ static long kvm_vcpu_ioctl(struct file *
>   		r = kvm_arch_vcpu_ioctl_run(vcpu);
>   		vcpu->wants_to_run = false;
>   
> +		rseq_virt_userspace_exit();
> +
>   		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
>   		break;
>   	}
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

