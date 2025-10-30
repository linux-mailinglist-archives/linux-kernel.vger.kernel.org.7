Return-Path: <linux-kernel+bounces-878389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA5C207E3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBD91885ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3A4192B90;
	Thu, 30 Oct 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="L9+G+xFR"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC747B67A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832980; cv=fail; b=i1WdlHbDlySyIgB3c19kpq6xOaB1YP7UaEHxo+K0wgxLhbebHLqYmhrcR8Pu88wprTo1pnMKmN13rJT19ov2IG1Jl5GDEgcZvla2JXFuGwLEnAB2VIzg31khqouwx5V32zA9VlcLLDOWi+6f9auzPr+QnK+5ZBmNgzpM6pPGFxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832980; c=relaxed/simple;
	bh=kQCa0qCrzfj4O31R4U6nG85od0og7hnB4Z/H26xQK6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rv/Gac3FiAvmEcy0jNQUMmchL+Z4FERsOfiEuqEVfX3PL2rTO+ZWsonNNcyKrB2Rj2YgbMptPy6/nbghxA8f4KGeBLSNoKOjmxAb3lEKNeMhwjEJbeDy08hYRShbybmfiWvKfzz9DOeQXq3B94N95VZJfg9RMdESmtTKeYs4iNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=L9+G+xFR; arc=fail smtp.client-ip=40.107.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0eoQAQCwOdakJamxb+w4WcWDv7kMF8knQqwkG+qrowC35osIMdSjGlPPhQGG00YK+uQ68MIqV919IciCJQqDrWsYV5TFU/NLC+DRmzZcmIo8VAU8SfSETafsG1eTxZd5u5Tbgsb5Z0SZdknGEY01VMKZfIRLMG5lwx8LGShk83ImVBsmNYEUJ4fZmnJRojJSeaLVdfYNJM6XBUS/GMAp7cmPNb9qZd9dk6veA/S1IUQZcAqEbtxxDN3IQIDL1L2Q0q/yV+CkqipiDEdDJ12xQfk4WNo4Y+zRqexfPuDIDWgCkUTB0yMGg/XNeRMLWBcbnFSZ0ZLb8zAXpNqBnsBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMmxie8ZccBw8pb1nCsO8FEjB9ILR8NlIQi5/cSIfH4=;
 b=N484Xa4kGItPfocaonBdOwnw4n4GOGAr/BNqSlfT67102FJAThgmd44C9ivLVmUwxskRo4Ba5K+Qj2fCvcH04WJNbJ+ccpseelEWJGZcDjJJzG90iAk7oPYAQA2WYpZx198tAW12lzo6T+jAjQtuToXOOGzUXD5Sy+vDlAaPsBmAQAJDX0AHFAwQYH35Py8apxIFY2x2B8HzFw96YfZOB1C3Nn5Af9YnmXO+t5D/Y06EGCoKnGuBjrnigqqgSdARC1a6GLPtlqz+NzSP4uBaaXzlcEKl/rvJEWAZUdkIgnIacqixDtXjL99PxRP7LpeJC+1MpI9mWQ67SU+duyPh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMmxie8ZccBw8pb1nCsO8FEjB9ILR8NlIQi5/cSIfH4=;
 b=L9+G+xFRWZG+KyYOe/ll8KmVpL/E1BJ5Qnte5OvZxpn6PXR4JCtyuSCqDvvYeuEfWcmJ0WbsVoZCS93n9hN1nPedWtRE5lZijwRPNmzAkWmK1PmavXfvu8WkUbbKC7XPZdP8kv4QrZe5U1bDbgI3Q/qtbroQbXZfLhEfw2e8shTbzgfjCPNlDobiFRB2wqwPVZhQdLrVhjpAB7j4cahnSZQT/HuMfHUaG+Ay/GTrCcAcBqhqK6E50DNa/1+kso4KAaRxZ1xrcWo7yEug0thXylmhjAhZ4C2qktLh9UVqlzFfzLsOtAgfEAXvOWQS4hL/BK1ELNa4b+5xJLG/68vJ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5741.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 14:02:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:02:54 +0000
Message-ID: <6baad1eb-d6fd-45b6-aec6-30f298b7e636@efficios.com>
Date: Thu, 30 Oct 2025 10:02:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 12/20] sched/mmcid: Move initialization out of line
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124516.034484128@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124516.034484128@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::40) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: caade1f3-bc65-429a-db5b-08de17bd0558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENHU09HMFRha0swQ1AxK3pVcktFT2Z3dG1keVRESmdhWDFEMlBNbGljdS94?=
 =?utf-8?B?ZVNJSkUwL1Frd2dGMFBlTklMMitpendUOUMwS3BkWUNRMm5yVm1PQS9QTUVJ?=
 =?utf-8?B?MU1kaXRjcTdpODlGS2c4TXpBTC93ZE1yUzUvVzBDZWliUG9FM1BqMUNzc29S?=
 =?utf-8?B?c01ON1RVeExKZTdteHpnSWhLdllhS002cmRLd0F0MnoyZXNtd1JmR2xGdnk3?=
 =?utf-8?B?elUvNEExYzMxbFhFYTcrOGZNUCtyN2xHRWZzLzExYUxZVFQ0Y0hKbTVzZ1NS?=
 =?utf-8?B?U2ljVjlCanhQVVJUUU9mZWR4WU8rc2pzZmNQY1ovcXBqRmVZUjhoVTZmUEtt?=
 =?utf-8?B?cXFieHU1ckViQ0FyOXRINERyVTRLVk83cFJCYzhvc0dqY2pVNGQzaUs0dzJG?=
 =?utf-8?B?QkpzSVFFWUFYNEJuL2Z4dXg2T1EzYlJhUEdMdWQ0TTQ0RnFIZHQyMFdIZEdS?=
 =?utf-8?B?SGl6NEFwdHBvUjhkZkJiSDA0alYxalR5OG9JdFNNUUxXb3BFaHBKT0NFaVBz?=
 =?utf-8?B?cnRlV2pIL2NQdHZzQVRrZHlVaVVIUjB6Mm14K1B5ank1QjFwVjhTa0lwNVFE?=
 =?utf-8?B?NHFheEY4SE84S2s1anNxaEM5cThBVjllcGZISWw5YkZaZHBVZ0I1L0RRRkxP?=
 =?utf-8?B?b0pLVFByak5XaG8rVkhneVZ6cDAxeC9YalV5czNNZmRsdU1Yeko4RFB5UWRM?=
 =?utf-8?B?bnl1WWJzVjVNU0xFS1JSY2xTdUN1WFBXRytKYWEvVzBNVzBNRFpUaE4veHM2?=
 =?utf-8?B?SkVtbkh6c0R6cUNPMWU5Q0lVZlFqYzhkcjBONndEVmRScllHaThtb1V4enB3?=
 =?utf-8?B?YVV3UkpjVnZISFJLd1ZnSmt4dWRlYldrSFNjL0lkR2ZFNEd5emd1Sm5JOGM2?=
 =?utf-8?B?Y29SZ3BqV1pOMDA3ZzRpU2gxd0wybGFuYktvWmZuR1lqbnRsMWdNWE00NFpI?=
 =?utf-8?B?aElvYjZsUVV0TTBobmRKVWFCdG53aEw0WUlGUTV3SFVHMDhLVE1nNEtReU9P?=
 =?utf-8?B?WWVrNzlVUE5oQSs4cllMMm1yWVJ4U1k5Q2srZ0hjQktlSDcyUTU1cmo2WlRZ?=
 =?utf-8?B?SlN1QTM0ZkFFODh1ZVcrendOd1VEUVZJOUxVNXArUVh5M1RCU1BvSWUwbFdR?=
 =?utf-8?B?RHJ2bE9VbURieTdFTEt4VjdST1BPb3RMbUtjTi9XKzVOdSt5VWZKYmlCeWZy?=
 =?utf-8?B?dm5OVVdZQ0lYWTVJRFVkVDhTZWRwTmhhMmZ1Vk1mWkZXL2JWY3pVaTZuRWtt?=
 =?utf-8?B?VVlhNDVkTzFEb2lmOFdlT0E0V1dXbUNuVHdKL2x5dXVhdVhXaEN4TXBpTDU1?=
 =?utf-8?B?MHlLZjJmRTk5K0xveko5SURlYk5LUDZIS3R2WkNoMUNwdXE5d0h1cnB4MVlo?=
 =?utf-8?B?Y202NCtWYTRBSXo5dnVVS29FUW5pNU8vN1ZIOFFFVGxuT3VrVjRjUEo4cG5I?=
 =?utf-8?B?N2JJOVFPYWJNdjVwV3dBSXovVzhrUVMxVG9wU3NablJFZXJwSTBYSUpDd2Zj?=
 =?utf-8?B?R3dheHU5L3BEM0hNSkk3Nmgrblh4Z0NjN2pUUkt2L0FPSzFya2VrT2xjYnRO?=
 =?utf-8?B?bHEzQmpxbWo1NHE1a2V2aDJ1UDFRNHlzaVA3YzJiNXZtUUkwQmxETU1qRXpE?=
 =?utf-8?B?Skl5TW9ieURKWHlnbXhYTXFEdTJCZnJXUVBYTjRzNTc5N1hyQ1pKRnYyODgy?=
 =?utf-8?B?aGY0THZ2cmVWdFBsRnk2YjRvemRpLzRwVWZyVUI0SlZEbVpiaFpmUUlsaEUr?=
 =?utf-8?B?ZkVkL2JZTHVFSVpnclAvbTZHME52UnFxVkh5NkZPaFBkc0NjMWN6dUg3Uisr?=
 =?utf-8?B?SGIwZldvS0QrVFMyWnN1QzM2Y2dONExrRUFiUkFPSi9XR2JmbGxHZGc5aEVO?=
 =?utf-8?B?Mk5nU2FDb3ZRdkEzUSszNml4Nmk3eFNTbWtkbDVRQ0c4alE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJHNWxzTms2UWhaUmg2RWN2Zzl6djZURU91SmJFclZLLy9iMVlMWE9IOS9k?=
 =?utf-8?B?aDIxbmg0R3l1RFA5UzFzZ2lxS0hVQU1PZ3FQaHJESEdhaEJ1YkYwT3B0M2s3?=
 =?utf-8?B?WEtwUUo5SGtQYWdCWU5LVHhrMTdsM2h4U0xNYzV6YVhkR3VhakNOeEJkS2VS?=
 =?utf-8?B?d0kzaGs2MVoveWxrT1JpZy91THh0ZVpTeFk4Yllad3QvdFZwcmFvT2YwemRa?=
 =?utf-8?B?RW9EZFRZTG1KRUMwK0hwMk9SRWZWTm1oT0w1eUhlcnBsSUVraWZrUTZtdFlh?=
 =?utf-8?B?aFk5UVpaTkRiNkJKU1NvNlp5MXI1YzQrMmlQQTZ4YlMzYnNIMC9sNUNVbnps?=
 =?utf-8?B?VjA1Tkg3czd4WGdmdFJNOHFNeXBwSGo1c3VNb2FQSkticllPSUdydEw1VW5Z?=
 =?utf-8?B?STNuYklieHVGcVFyOTVwaUVkcDA2MWczMmhyRXVJZHRoVHNkTjdUSHlYUDd0?=
 =?utf-8?B?VUhEcVJmbzBuR2V2blV6T3JVZ3o1MUtRNUoxbjZpTnkzVlh3SnVrWk45OXNH?=
 =?utf-8?B?QkZ0c2ZFVHpkZ1RYc2pxcUhpTExiSWIrcXI4dkI0aVR4djR6MWROTGtHVm5q?=
 =?utf-8?B?Y2FCOHhQNUJ0Q3JCYkZpVjY2NklKUU8rTURBbjdycXdRZGVWcStMbFIzUXoy?=
 =?utf-8?B?MldibmZIOWNvV21xRit3b2hzcC9WUVlQaEljeFBUaC9PM3c5NFNldnZlaXJx?=
 =?utf-8?B?NUtWVVZaK0V6RFpadkRkTEc3NHlJQnFMajhCU1JUeHRFYm56cEdpL3MrbmRV?=
 =?utf-8?B?bTQ1bEtZRUpYa2RxbkdGVk9RQlhhWjZmN2xabGF6ZGlFYlBSSC83VHZXcC83?=
 =?utf-8?B?TFRxZ1BzTEJLUzVjUHRFSmw3Nm9PbTJ2dVZsa0FNK3hOZHFhTEpQM3JBTW5w?=
 =?utf-8?B?cDFuRDE2RWY3TngxeFFTRGJnSUcwZkg1VU5NZ0VXUmpHYUhMVGtVZy9yeXMw?=
 =?utf-8?B?bUNZbjViYVRpemNrQjJJWHVhMi82eUJQS3FQdGlUNGpGcFJPeFR4dUFHNWpS?=
 =?utf-8?B?eldNU1J3aTRMcmk2cVNWT0RQT2JRUlJoUUFZR2NneUoyT2ExLzErazl2dFJV?=
 =?utf-8?B?THBrTFZCQ2lnY09XaHRJanI5dm5IRjYydEhKUXllK1JwSnR0eGZuTzYwWElx?=
 =?utf-8?B?N3grTER4bCtGZnpLaHBmMkMySTVUS3J0WEExYnluUWZ4RE14V2s4OGlHVHQw?=
 =?utf-8?B?dDBxU1ZkQTRQb0k4L2xoKy9sOGhwZ0YwYVQrL25BbXhaNnFqbGtEWm5Mb0tn?=
 =?utf-8?B?am8ySmJxME43RFNrUmp5Rk1lUm92TWtqZEJCWlBSQ0pRWGVKR01WeGt4N3NZ?=
 =?utf-8?B?bWpoSmxsTGw5TVRhcWhuZDI4dWc5YUdnQWlyWTJiVUpZZm9xb0YzaDZzSGVy?=
 =?utf-8?B?dFVIU1U0YjNrT1FzZzc4Z040aGZpclNKMVR1ZUdScjVUVi8yei9wT2cwSzAx?=
 =?utf-8?B?UEllT251aE1wUyt2ZThtTnZhUGRsSmdTeC8rUTgyV0FxNEl3cVdnZHRwZXd2?=
 =?utf-8?B?clZDd2pzWlVselJyMzZTQ2xGeUt1RlFBSGNwNWNsc1hYRGZyN1hHdStUbHlW?=
 =?utf-8?B?eHVIUFlnZ2xUK3JJUFNzSUVHUU1SS290Vmp1MGlySHBBMTJzZ3VwT2ZBUWFU?=
 =?utf-8?B?N1hWcXh6RlpmSmFoa0o4Z1pkcThMd0k5UEdMTlg1Tjc5anFqSkpwVDVjOVNl?=
 =?utf-8?B?NEdpbWl2Z3JxbFJWZDIrNytmazluU0hJbXVwOUwrTXF1aDZReW96Q2owczdZ?=
 =?utf-8?B?NGJ2S1plVnBYRmVXRkpvdWhRUXJSQi9LaXhzWmJaVDBPekw0V1FjV1MveHNX?=
 =?utf-8?B?S2JKZ3RYaGNwR1N2RXFJZmZxeEN4dVZmWGpEemFQZFZkalNCRWRwQjNSRVRT?=
 =?utf-8?B?S0hFa2VHSzhpT2VxZ2tkNG5qSzI5aXNJTEdhaUtxOTBJZjlBRUl5aWk4VTRZ?=
 =?utf-8?B?Z0ZRR09saVZGK29DZktxVjhXOFdlNkFOSVAzeFlNRzNEUHJlT0Y3dTcza1lo?=
 =?utf-8?B?K0JMR2p3T2tySVJQbm9GT1BDVkxLaUNzTkdsM2JCeFpvbitzR2NhbDJ0Q2R2?=
 =?utf-8?B?MUU3cjg2dkZwUThRNitxdVBaMUdaaFkwbXQvRUVxVDQ5eU1ER0w2UThxZU83?=
 =?utf-8?B?T054YWwwT2JHRUFxb1hISHNSUjA1SWJpQkNsK08zSmN0UlNUcjFkQ3E4UWc3?=
 =?utf-8?Q?0ZG+2EUICmepUVggnVVjj8k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caade1f3-bc65-429a-db5b-08de17bd0558
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:02:54.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6o2bdB1lO04oTwHyXtUeulzlWCmEOCAU8LMm2LlMR6vQAeGMekyPiLN8hSLTyyH1Eaif2YH+TNFGTmJsvWuQegFL1ZQf2j315SCAU2BfoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5741

On 2025-10-29 09:09, Thomas Gleixner wrote:
> It's getting bigger soon, so just move it out of line to the rest of the
> code.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

