Return-Path: <linux-kernel+bounces-785108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4785B3460E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A3AE7A7D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D132FDC53;
	Mon, 25 Aug 2025 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cUGAre7i"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2118.outbound.protection.outlook.com [40.107.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D62FA0CD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136422; cv=fail; b=g50Q6fpsfaIWkquNilY0s/ItnmMbBXG0klD7/zTfKVenBbEtJcw4uWjIyJOe6Hbj6+dn9IgkRbGuI87zJ+wgEz5uCczpzAVOwXIALNrir9VOpfa80aUEMqoxLpNCnWKsu0ifx7r5k9iWFXzBX9ZuiuJWuy1AxsUGbK6n9bJeLwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136422; c=relaxed/simple;
	bh=b2rMbxpyMbzm8/MffF6gRzR3tTbm0HhL42AIX+wt9P0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhQ/jHtnALL4QweYUwJx5b5xIxU9KjIBqkonvzDVCadlXh7UPvdb9o5HcUJo0TF/eCVx0H0ePc1GkPpqEe1w6YbdA07yHNudi7pPRJtIVrDCirSKZaz9CcD9HiqBIRNXV2j3XhJZKRMItyc8d9fut8V3rnpj7eSMPECVCZYWsBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cUGAre7i; arc=fail smtp.client-ip=40.107.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUXicZsX7Gf0YEUK8qYC28fJ+sz+cbUfyo0ScipCbhQ49AIplfjMbfcwJFJMifOBc3K0MHj7igWP8zjMaTbA5R2N5otRcf3iiJUhNzvgT94vERAmI0wrCSbz1e/AsCfy7XXhacz+FurGLS28A0T3v3lbL2YXmVLDugqGHcL077MkOqHNvCWGNUUl+DcDFLDWfDQHRS8iYUOZ3O780orhzD5vte5Ha/U/svF+MmUZ0WFEdeQPhmBohttFclG7FiKQoYDLNeWeJe479SCAzjNHXvGQ8Fn+5SVd9/+EQFDW6Iarrab4uoejECTKFizPSiqHxiHYuHOCAzaWtJ8gvF893Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tsjhvgGzGHOOhPPSzIvAN6HGRTEKHntWcepioH1rAg=;
 b=hnI3T8rcPo/jl0NOuuEX4J4IUy6qt0E1S/+GL42jVdmHI5OhQMLXjteTom+w9hXxAzX+oaEmyQPagy3pR7IYfRbJD29oNPwuT61QiAkw+jp4HgynPTNYzcS0M6wdhbMv2cHUWCoes4FC9IRRWFx3O1OB2XtojrkMAyF6b7INGGGKdTsE8ObZs7g6cr2B1XVMPA6DV9TjogI1Fxu+r2d7S1lm/h6iOxaDeXInbK2wnTUhohWJxJCm6b5sI2VS6mj90Yko/rQWsSTz+Yg219V1VXxqRgTJ+z//myZv08qxRSDgwlbZbyH417cLB+9uJIlkzXxXB7SiHGI15Vv9J5nC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tsjhvgGzGHOOhPPSzIvAN6HGRTEKHntWcepioH1rAg=;
 b=cUGAre7ilaVE4E9HbuMZ1xNMo0B8z6BnEd1hcCqItcpqIoMuQ0/K21nQD5eXZc9WkEZNQj6punv2AoKxVZNrpFxl4h3Osj/tHulDyoZbBTa6uwuI2jZd49SkylYQC5/izm7rYrl6YODqO9wHWuqQndKdIzoScCb3+ikrMe9qyK54d9pmXTDeFedQR5wdYztnOpogcPb1/zMoM0p0uLKZu7Hsr04oTcZfU6Cj9cpqccmh0Y7zMmMSBpMn91pjzgezKcte37bK1/6Hw9k3t1e1sw/FgGS5jy9v40mRTgsn3coPaiajSJ1MxpktsM8AROMgqtS8e+T4OUq+EHLITPghbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5767.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 15:40:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 15:40:16 +0000
Message-ID: <53d3b1d3-74dc-4965-af69-32fd27cfbc7c@efficios.com>
Date: Mon, 25 Aug 2025 11:40:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 02/37] rseq: Condense the inline stubs
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20250823161326.635281786@linutronix.de>
 <20250823161653.387469844@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161653.387469844@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c8e4c0-501c-41ba-bdea-08dde3edb091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3BsN0dBSkVyRmFsNU1UNDYvUkxiYVF6d2JYNXlSYkw0dFBHUkFjV2M2ay9F?=
 =?utf-8?B?dWFaZ2xmSzFGNmNiaEx3cUFpeGJlVEg5SzdxM3ZuQUsxWW1zU2hXNWdUZnFZ?=
 =?utf-8?B?QzAwZzZ4bERyMEZsSStQaDN3L0lmb2U5TlpodnVsdERJVGQ4N2VLVGhDMk5o?=
 =?utf-8?B?a3VCV3czVkNrMS9SVG8vdWpsQ2ErQ2s0U2k1ZmwzMFBVY3Z3em0reXR0ZmFa?=
 =?utf-8?B?Y052UElhdnJZOHFwcmJLZ2RLR2tJeG1Nc0NQU2dLSmlrWk5wdGNIMjBnL1Y4?=
 =?utf-8?B?ZjdOMWpZVnhLMGQyWWhYVWdzYW9NTDY2ZkVkTmpwanMzSlJOSWd2ZnZUR3lK?=
 =?utf-8?B?MFZDdEhrc2xpS2Rib1Zvcjg5eko3Y0YwdzJEKzJmOXQrVjFaWjZuSWYxUWk4?=
 =?utf-8?B?V0xZamhMeGdqbFgyVWdIRlNrejNEVmF0SkdWOExQSW1JVmcrUGlwRXRVNGx6?=
 =?utf-8?B?TTZpTHhseDJoZlhIVzZ6Mlg4THJETHBkOWNFLzQ4blRORjl1RGVQbHBHN1BG?=
 =?utf-8?B?ZDMyNm8yWkg3Ym5WZXRheWh0VXhHRGErVlRyOVJtQXc3enVnc3k0ekYxWExz?=
 =?utf-8?B?bE90Znk0a1FvQm9DRWY0bmhPUklFYkt3Zit0N1EvS3I5RDNiYkJsTFJCdEZB?=
 =?utf-8?B?UnVtcitiYkh2bENjVUdmTHk4QmloUE1nNzR5SzZMTkoxTEJUOHE1TUtpY3ZJ?=
 =?utf-8?B?ejhOYjFFZTJYSE1sVDVZbEt1b1RhZG0yaWdjdHdnVzR6cGtzZ2lRQzEzdWIr?=
 =?utf-8?B?Nld4ZFdvVXhwZnhyZ2laVTEwZlord2kxS1IwSmw2WnlNeVhyWGN5U2dLWVgr?=
 =?utf-8?B?eDJXQ3NIT2pvQk90RkNRc0hoRnFTbVIyNTRncE9IdEQrejU5Qkp1OTRFaVNt?=
 =?utf-8?B?dlJyVXdUUk9uMmttakM3QUNkSFB0Q01rc1dsMWl3MDVSRm1WNERWdFdVb3pX?=
 =?utf-8?B?MlhsenE4K3hZMCtKMTdjN093bmdKNzl6M0JKR1JsUzJHSmEwWlR3amZCaDdQ?=
 =?utf-8?B?Q0N1S0hnejFUaytXZCtLU1cxOHozbnk4YWIzakhyOWxqNWRpZE1ueHJETzFE?=
 =?utf-8?B?YlVKV2VpMTZKOERxbFczRVNOclZhdll2UFpDdWVMWHVEUS9Db0gwdmJvZC9q?=
 =?utf-8?B?MzVyZXE0SHF4VmxNYWI3c2FadndDTk9jVEdOaWFBTkZzNHZOVXY2UWxIcXFW?=
 =?utf-8?B?bTF4eTVMOTRCeVRaUU56OUk0K2F0VlVFRDVFNlZ0VVBOUVZWN25qNnp5WXBD?=
 =?utf-8?B?VFkrS0dwK091eDU1ekpJZlpTRlEzNUpzSDgyaDRZL3o3OUNZTFVFNnU0WnlR?=
 =?utf-8?B?Z0FzR0ZvV0gxWER6N00vSXQ3MWR0eXo4TnZIeXNpMXEvVWFMalNFTElrUDVm?=
 =?utf-8?B?VytobkRSZnRHVmdlRG5EYWFzQ3oxSC92K1FBWG0zZ1E2dnoxemwzWElSTzcv?=
 =?utf-8?B?RVlSeHBUak9EbXBxSHY5UHFDaHI2NjkwN0EwV1FObWZMMjFDcit2ZCswVWlm?=
 =?utf-8?B?NThPbWJ4dmdEUVNIY1FmL0hCaWZCOU9Kc3hCSVZhR0pBV0VlcnRTaWdpZHhx?=
 =?utf-8?B?K253SW5DZUdtZEdlZjJnd2NISW5nOUtOSzlYVUE5emRsMFhhTCtFY0hjaHJE?=
 =?utf-8?B?U2NybHdBZzdweDQrcGhDZEliZjY4UEZpTVpTTlRwUEovWE9nWERiOTVYaWJ2?=
 =?utf-8?B?TGNWK3dsYUd1UmFkdklwWHNjNWNyc1NSRHg3RzBhQk1SWXpuL2dacjQrTnlh?=
 =?utf-8?B?dSsvSUxTeEJTS2FKSmdJUTdhOFFwRlhwazFwNGMybXlkdCs0MUgzUFJrUzZi?=
 =?utf-8?Q?ah6ZIsQMZUBvSDVwL35G++Kx4ctS4i6mHqWFc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3dUcW8rK1JoYU9XZUJrNXAyNXZXTk93Mk1VNWNzS0ZWYTNydzdpTnU2VnJ5?=
 =?utf-8?B?M2JpdGliRXZhYnNMbzB1a2hVOXpOTllIdFkxZk9LeXdkeXdYVU5qbUtBK2Z6?=
 =?utf-8?B?UDRsdzlIMkFXQmhHMkJKV25sSnFTdkhHa2hWczlaQ2pPTHROUDFSYzIvZmVs?=
 =?utf-8?B?TE4xOWRSQmJFMGFxVEI3b24wMDUzYkJnbmdIeTV3Z05GYS9ueDBmRkhUcHhH?=
 =?utf-8?B?c2l1R0llaWp6dHZpUmVFUFpXSWxhcHJRdHVnSXFpYjlSVlRMdlVmcGVuV1My?=
 =?utf-8?B?TDVuSHdZaXF3MVdUYXVVTVlkOWtoQy9qckF4OFFsUDNkaWtYZ2hROWU3T0FU?=
 =?utf-8?B?amd0RU9qNFNuR1FDenBueEE2MjhDQXQvSkNRd2lHVmdLbUFxUGxTbE9IV1V5?=
 =?utf-8?B?UU53b0k3QlJMSmJpNUx1U2ttdktkbGEvb0x0bVRJWldsaWh6YWNJWk1UWXF1?=
 =?utf-8?B?eXF6NFo0alBwQk9tUzBlSEpJZkdVWVdlWEJBZ0tBTjA2cGZRUUtXRmRuTS8w?=
 =?utf-8?B?R015M0xjd1FnUm05aklRaVRRRElrWWZhNk1OVFQrTENqbWd4RVFCZVBXRk5P?=
 =?utf-8?B?dkdQalk3Vy8zelZleVRvZUxuNDhDQzBjaDZLQkI2blllanNmbVd1ODdFSDZP?=
 =?utf-8?B?YkovZFRhUWZJNHIzclhpTUVSenpJNkFwYlJkT0Y1V0V2Sk9XR3dWNzl2N0F2?=
 =?utf-8?B?bExwT3A3c2tMRGlzU2tvODg0QzY5VmU1Q1VVY1JhV0NiK2gzRkpTY09pNHVn?=
 =?utf-8?B?K2pKa05BR0pMN0xmaW1zZ2VWbVhMczRFaE45emdWRHV2VzFldmE2ZmRxbHJo?=
 =?utf-8?B?Rmw1TFZabzR5dGlQckxJUW9jTkdOeWp4V2loN0lpeHdGc1htdlJLd2pNQXNj?=
 =?utf-8?B?YW5YdjExcFB5UklsY0YrUDlqdDV1TG81eEtLM3pCMkp0b0lyT0Y2Ym9GOEVz?=
 =?utf-8?B?cVBzeUlMSzYrODgzMk9BSFpLOXdzOC8vNmNqV3F6RlQyTk51cEpJL3FNTUkr?=
 =?utf-8?B?VVQ3NTgvK2x0Q0ZjU2dPK0I2Mjk4MW5wRXdGREFBc1c2cnY4OU5rMGFVUUdI?=
 =?utf-8?B?TUU5TTlCSG1QaE10RlhCS3ZnUG9ud1lKOUo1bTZ4d1g2SzY0eDVnVWFMcDVl?=
 =?utf-8?B?VzExNSsrd0Q5QkdGak5WNWtMTHplcjlTc0tyMldSc1o0a2l6bkpjRkwyY3lO?=
 =?utf-8?B?UnF5S1UwNzFzSEtiZVFPK3BHZHBweTZxclFLV0VOWE9DMXFkR0ZkR3dsdFNr?=
 =?utf-8?B?UjdqRnVlalF5NTFTTXhnTFFSWjlnRkl3M2Evc1pYRVBtNUQyc2ZISzVSWFhC?=
 =?utf-8?B?Uk1IZSsvYXVwZDdEMTZOMGYvM0s5bjdMdGROelV3bDJmenRMNDhaRlIrTEtm?=
 =?utf-8?B?eklqZzJXeWVybnM1cjRta1FRWmNFMGNKaWw0bU9BL1BzbEtZWkRWRVRSNThB?=
 =?utf-8?B?ejNBaE5pWDg2dTMrTE80eXdyd3REdzgzUFdJV2pNQS9IaGVoYjcrNjdsY2RJ?=
 =?utf-8?B?WnJFa0RJSVIvalZNL1R4WjFXWEROVG4yNFFLb3VodURnUDFOWnpWZmZCdVdU?=
 =?utf-8?B?YjBsQm5qbXozSTFWKzlDYXphWFFJc1NrcEs2Q3c1dmJRczJCVzROeWxPWXZL?=
 =?utf-8?B?b1lST3hLeWJWSzFmb3pxcTJUYkRsS1JsOHV4d3lZTXNEemp2YTJjcUh2Qkxs?=
 =?utf-8?B?SXdqeC8rMU1ETlRnbHJWYjR0eFYzZjk2SEdtaEJXRzZLR3lrSVFrV2ttVFc2?=
 =?utf-8?B?UmdzRVZLUStsSG9yRStQYkFpQm1aUXFMMVUxVitja0xuSmFDRmZuQ2NjbzB0?=
 =?utf-8?B?NTMrbVdTWHdoSUUxVHhpQ0VjL0lzenZyYXB3SnZvZnlZSlcyYnc0THFUV2lZ?=
 =?utf-8?B?SWRZUWJxUU5rTUl0d1JYZ0JycGtVVjh4UEpzcHVzQ29Xci9sVW1iVTRaYzVt?=
 =?utf-8?B?SVBkNlY3NU9URldCbDYvYW9mSUVYL09nZTdwRk0rUFd6NVgxRG0wbFFmL2Zy?=
 =?utf-8?B?QU1zUzczck8wdm11ZzdyWndaNFFVdTdxOStFRTE0WENtWTN5OFpRS0c2bVZn?=
 =?utf-8?B?ZldoQjFmWXZsUkZKYkMrbFpCdWc2Wm5zY1RXSldYT3poTVN5Q213Umd5ZWdI?=
 =?utf-8?B?QUJXdUJ2ak5lS0FaM1FYZk9QS1pQMi9HYS8yMG5EOE4zMWl0MWxWNlh2YjV3?=
 =?utf-8?Q?2ovpKuCEmmEHs4nr1LsWt8U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c8e4c0-501c-41ba-bdea-08dde3edb091
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 15:40:16.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7neN7ehFV1eAbElizAWsTdPBC0WiTERivg4WK1WG0+hsvZeckIVK/Rb0U9YAx/nuZjaJSPS267tm2+izVkpa/LN0AMqAoTh+si5VZDab4o8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5767

On 2025-08-23 12:39, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Scrolling over tons of pointless
> 
> {
> }
> 
> lines to find the actual code is annoying at best.
> 

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> 
> ---
>   include/linux/rseq.h |   47 ++++++++++++-----------------------------------
>   1 file changed, 12 insertions(+), 35 deletions(-)
> ---
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -101,44 +101,21 @@ static inline void rseq_execve(struct ta
>   	t->rseq_event_mask = 0;
>   }
>   
> -#else
> -
> -static inline void rseq_set_notify_resume(struct task_struct *t)
> -{
> -}
> -static inline void rseq_handle_notify_resume(struct ksignal *ksig,
> -					     struct pt_regs *regs)
> -{
> -}
> -static inline void rseq_signal_deliver(struct ksignal *ksig,
> -				       struct pt_regs *regs)
> -{
> -}
> -static inline void rseq_preempt(struct task_struct *t)
> -{
> -}
> -static inline void rseq_migrate(struct task_struct *t)
> -{
> -}
> -static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
> -{
> -}
> -static inline void rseq_execve(struct task_struct *t)
> -{
> -}
> +#else /* CONFIG_RSEQ */
> +static inline void rseq_set_notify_resume(struct task_struct *t) { }
> +static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs) { }
> +static inline void rseq_preempt(struct task_struct *t) { }
> +static inline void rseq_migrate(struct task_struct *t) { }
> +static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
> +static inline void rseq_execve(struct task_struct *t) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> -#endif
> +#endif  /* !CONFIG_RSEQ */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> -
>   void rseq_syscall(struct pt_regs *regs);
> -
> -#else
> -
> -static inline void rseq_syscall(struct pt_regs *regs)
> -{
> -}
> -
> -#endif
> +#else /* CONFIG_DEBUG_RSEQ */
> +static inline void rseq_syscall(struct pt_regs *regs) { }
> +#endif /* !CONFIG_DEBUG_RSEQ */
>   
>   #endif /* _LINUX_RSEQ_H */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

