Return-Path: <linux-kernel+bounces-785423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDD6B34A76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A51D1A87DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC78303CA1;
	Mon, 25 Aug 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="WMZQDeWK"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2115.outbound.protection.outlook.com [40.107.116.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A623E340
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146905; cv=fail; b=ICXfSVEajCKVG53f7qBw65TQWdKGY7sSp5rg2Gnv/GW4t3+FfaxC9o7wAin2O5Y+V0s9XzTLaSuVNmLlkrDJFrD+D16UhNMbFmfd4wy0nrwZ0HApycImcTGxCo34DpU5GZq/uefFFpClMCydxOHPXmee2ULZRRB3l0VVBu17+VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146905; c=relaxed/simple;
	bh=uCHsWIvchOHmDea8XhhsarbG3CpFBsZUp6Nt5sCtPN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P+hqOhwCgL3chdBBVKwlnPyFZK2McmPERlugRPQW64ofGp8V06pJAbGuJOYf84ts3UOSSyMbdZVkmP+iUZdDsLXVZRfvM8gbjAsQmvow70H4T5Ll1G0D0bO6sMN7VLbu6eyd0pN/t+vu9D/IRt9yECFUJ2RmBt3WE+8xF4mSGVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=WMZQDeWK; arc=fail smtp.client-ip=40.107.116.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5nhj20G+ikfFr19dWBPVfaIGsWPBrrS/emejpmnJmQtYnWizsVWHRvJLwxVe9GKFUCX98BCUytvzZC35kGYoUMNvfiSyRJecj1kMkeq+9qw6cMMtt3xqQfA4jzSW5Zq2WMz4KqRGDV5PS/jb4JpSuY1BTGG1rkSEqcEDXRkCgYKKZHQmX/UKGRjQHyxMCFIuy5TeJn7TD6HQMJb5i3xz/wqwSih8Tdfmfrv+mxhCP2fEVOTvgLa/O8VIozUKzJwAjIVcj8ZX31nMJug7wJv0sUY3EsujA9hUazwjOBd5Z9CS3Vr5IqFsZBhpqe9nQK8TZMQ580TULi3V2+u1puO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dY02eAZBNQURircGhltQj8yHIXZFWsvoMnjW/hBbVyY=;
 b=vypGL1IbcWiAjN1SGv+oyU66D+SioYxoFIdhnxPZbkjptC6a+iI2UVToedVsrxwpejrgrYsdWfcktKyQ8uh6wFOnVFaFMItzcGFuY6+7S2yVsWcG03OorEBRiuLwJJIFHqtQM5Gb+nSxYFr2fmq907QH4LfnsFT/FI1Hxhqr+JpGX1ulp8KAQsEMo/gPOxCElyStUk7Yjje29XMsIJNm1YS7BzObdrDxkg4ObdEYGhMm3ILm/va9aq/wiEIDxpND5Dnf4aoPpd7a8uvj6IKD6IFRoct4lu04WxZ9ZFrvz1VzoLR/D6IKaI7lV/sb+HshWL0gH7sH6z7Qz3OZ6QbscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dY02eAZBNQURircGhltQj8yHIXZFWsvoMnjW/hBbVyY=;
 b=WMZQDeWKwhAuWoAd+KlH6p3L3IgqVNp4DGibbMX3pPk1wUQlSjwM8Wp+NKmRnu7DG3cgwxr45EyChybqtiTLfX/7NQ2w7HDSRcb4bUj0sn19toep8R++FEH+Qz/HRYxTUm51LSuXVXA/uDHJ+BjQSnDZBQj8Hb+et0YcfpwKhv26c9/nMLOFB12m8/lzhE+emVA1ZlOQmyTUygFOOZ8MZl3R4OxqT6OHZqTs9c92sMiKbesa6auRaHNXWxj4wY2S/KJmQzgB6+HDOgPkX70zAdA+QWRiWwTl/VazTIojjRrNotafNIZYGVnr7rNMDl/HX2y1nthXA+eIPKZuLgaHAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9478.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 18:35:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Mon, 25 Aug 2025
 18:34:59 +0000
Message-ID: <885d6f67-f0e7-43c1-a173-740586cc0da5@efficios.com>
Date: Mon, 25 Aug 2025 14:34:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 17/37] rseq: Expose lightweight statistics in debugfs
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
 <20250823161654.357235187@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.357235187@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 68646207-a327-4f05-bb3e-08dde4061873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUUrTy80cGE1UG5LQzBDWmlJd3pnMFpqNVBXd1Q2b05ERVVnV1ZCMVA0RTNz?=
 =?utf-8?B?SVJKR1VLcVNNaDBRTGRIVlZRVm5IY2NTa0g3bndxRWVMU1pFdDMreWxaUHJl?=
 =?utf-8?B?dExYWkxtVlpUUGlTU2kxWFNLam43Z0RjSCtlVDAxL09obTNaSmkwZEFWTXI1?=
 =?utf-8?B?UGttU2wwcDlkRTVBOVhsRG5oaVFycnJzUjFjcnVxclBCUTdvK24xNnRxaGJx?=
 =?utf-8?B?ODBQRWhoODZ6NWxHS3hqY3EzRXNucjVvbXpkK0VHL256RzM3cVcvaldMM3VT?=
 =?utf-8?B?MnNpbGRBNTJGN1piRXRZMW90bmFUUXhxTWJDOFZPa0dnK1lIc1BsYVQ1dFlw?=
 =?utf-8?B?VXNJZElYYVlCUWtQZEhnL0RBZ0JkbDE5NEtPMFp5YjIvaE15Nm4wOHdUeXVY?=
 =?utf-8?B?THV0anNlamo1WVhUYXlQSW9DTjBvNDJleEF1K3QzaW1UUjl0RTJUUUppbjkw?=
 =?utf-8?B?cHAyamo0Q3FZRk1ISzNQS1hWLzVWMkFubDhtajQ0ZTl0S1J2RmUvZnByRWV4?=
 =?utf-8?B?amRXcXliQ0d2VWNzMm42YnVvcFZhOW1raUhKSCsySW81T09kYitOVit2dnBP?=
 =?utf-8?B?K3I4Y0NrTHRnY2k0REt4SmVQUnE3cWJGSm51djFxUjBmblRYWm9ZWTFkek9n?=
 =?utf-8?B?ajJXMnJNZ0phUEh2aVl5UGROSnYrRkYxUk9GK0NVUkY0cFNwZEQ0bG0wa0hI?=
 =?utf-8?B?SHVJV0pDMkR4VlJHL1dnZjNkeGhMMFFEOE1iS0t1WUlSMklLS3dEcnRTYkpV?=
 =?utf-8?B?YXBEREkwdHpBb0MydmcrdTdDVk80NnNsR1kxamdaSFhXdk1UcnRxa3I3bXdZ?=
 =?utf-8?B?aHlXQ3AyR3UvSGwxOE81dGZYeDRSOEN3YnZaVkpJK2ZId3FJYzkzV3RaZGJE?=
 =?utf-8?B?VjZoL08yMXp5THZkQmVXVmVlajZjeUVtOFdYREVwVERydFp4Qlo4Y0QvbDBz?=
 =?utf-8?B?RXBFYkN6VU42L2lCUFJrUm9ud3pvT0k4WXVKaTgvZUtzSnkxU3hwMyt6TDlu?=
 =?utf-8?B?UHE0dU9yUzRHbUZiaFFTL2VWeDkvdXdMazQyMWhmemJqRlIxNjBkdkdWRnVL?=
 =?utf-8?B?VVN1V3NkT1M5RHNpNHRlcVVDRSsyam9NUUVVYThucFFyRXpQU2ExL3dRRjBR?=
 =?utf-8?B?aTZtUHl5MThybFJDdU1UZDVGZHBlV056UVdqajRweWJMNUdaR3oyR3R0T3lP?=
 =?utf-8?B?RFh3aExNdk1CenBFTUZYc2hwRlBDb2tuWXQ4MUxqdk1yVWw0bTF1K2JyT3Zz?=
 =?utf-8?B?ZU9Jb0ZIT2ovMk5Kc004WmI1YVJQSlgwdFRQa0hYTWZqcUFWOHc2dm00bWlB?=
 =?utf-8?B?NlczS2I4cUVaZW1mUVdQb2lYSEtjaHRpaE1RVlV2a09DeTM5WHZKaXUvYnpi?=
 =?utf-8?B?eGFwWW9QN3dOWk5YNTkzejZ2TlJtbTFrRUZOQWdtb1lqd0JYOXIyc2toRTNm?=
 =?utf-8?B?ZUhPSTdRbVN1QzRyemE2TUpWcHdrdHQ2WW9iR0pvM3RUeHBoUDluRHhkUEEz?=
 =?utf-8?B?UnVFVUQ4MUFCSERaa3FHeFJtRElyZ1ppNTFNb0JBOTNVYmVsWGxtZUdjdUpI?=
 =?utf-8?B?bmcrL0dQajhJejhON3dxbE82QTZ2WlN2cldpdHNKU1BDUFVublkxek01NDQ2?=
 =?utf-8?B?bjBPeGJ3Q1VPNGFjeUFqR09HNGRSZkxtcHl5YnFrc2k2am1YRE4xS0tFTXE2?=
 =?utf-8?B?M1BWQkh0dkdJQXRvYzNFOFFVWlB6YUxySGErbTNyTkhkNGFrcit5Skp4eFZ0?=
 =?utf-8?B?SzMxN2dMYmFaREo5YjJzMVI5U2J3Nm5hcmFLM1hUazNDOEVLRloyQ1AxbC8v?=
 =?utf-8?Q?PzVD6s3AEr4TnBZfN3SmmTk/zFztu7nw/Z6og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjIvVUdTZVdQU3ZzeHIvczhQOURPS05Md3NEd21yRU92Yys5L0pvZXZSSTM2?=
 =?utf-8?B?Yi9Jb1RlQjlMeWs2L2hoN1phUEpOUVBkZktMWXdnVXE5M1lxK0ZJbVZFUFdt?=
 =?utf-8?B?UTIrMzRKMm4zU2VDelQ0c2FRdmpUSVE0bXRXT3FRRWx0WHJnYS9ZdnVLdGNa?=
 =?utf-8?B?MlJsY0JNRXpuRVJCTENiQVpEYkxZSW1vUEpjOWErbjd2U25ja2J4RzRKQVJl?=
 =?utf-8?B?UmFoT1VaczR6Lzh5cFcrOTNpeEpST2VkOVNJVUNTTmlSMTlabDhkM0QzdjR2?=
 =?utf-8?B?dkNCbUZtNWNIWWNiM1Baa21vUkZFWmpUbVhWemdEajEyUHFCUUd3dG45NFlK?=
 =?utf-8?B?Y0RIcEN4K3VzcWpmY0t2M3UzVGwxcllaTFA4SGxId01lWUd6aWwySEFXK2Mw?=
 =?utf-8?B?WGk5dW55VTlVUEZEWUJuZSt6QTVJQ25OWTJGU3l1TXZicENRK1pESUtuSWdW?=
 =?utf-8?B?R2NOK0VIek55UUdQeCtRRmtESEJUbWo5aDEvM08xd3lxQUZNdHQ0WS9USVZl?=
 =?utf-8?B?a1dUMFJHaDFxcHloaGtIOXpvdC93dXJsWUljV0lWRzRER0ZWZUhBQnU0blR2?=
 =?utf-8?B?akdTMWlkRGFyd2hTWW5FRzJiTkZnWlFiTEMvc2pWZ1JldTdMSjNwVHhDS0w4?=
 =?utf-8?B?TXV3ZUtmNVkwYmZ5emlkS09zSDNob1ZveElXa3AxY2NYb3ZIYTJDQ2x5cjVs?=
 =?utf-8?B?RndQRDV1aFZTQnU0VW4zZFRrQzRUSHBWWDJnRUhYc2UrcWlhZXI3U1NSRDEv?=
 =?utf-8?B?R2ZaV0g0UkQxVE1vUkEyeGw4L0JLQm5Eb1hZOExkZ0FhVkhYcnBMamRNVjVL?=
 =?utf-8?B?UzJXM1A4aXdsUzMwYkk0VmdmU3F1RFR0RWcyS0R0d2dTZVZQaUxmdnY5R004?=
 =?utf-8?B?dWZMQ1ZPbzdSMjM5eVp0RkZnVkM5OXZIaVVBRytrRHhVQ09uNHp3SS9HeXhE?=
 =?utf-8?B?eXROVU1NTlorZDIzUHR4WXZURlozQWErZmJxc3ZFR01pU0prTW4zTE45MU4z?=
 =?utf-8?B?c3VJNU9WTE00bC8ybTFPWlRFcGlEM2pWN0NNYm9ROEFOSllUb3FiOTZxU09z?=
 =?utf-8?B?YllZcGxJS0FIZHFIa3Y1OWxiSVlqRUJQRnAxVnJYSThpckQwTG9xeGh6bFVG?=
 =?utf-8?B?TWJrS05tTy9kZ3hiYWhqMVJLbTF4cVJhRFlYVWwzdTYyb2dkSjJRUStZSE41?=
 =?utf-8?B?WlRRNkw3bnpxa2NzcWIvTkxHRG1HZlNpem80Smo1VDBETG5YT2pxaVFURkFR?=
 =?utf-8?B?TFNBdHJYOWwva0RPNHJVa1A5UEo0SlBidGZOVXZiMm1qYzJwa2RWVzV3ZW1o?=
 =?utf-8?B?OEg2Yjh5MnlGU1J2dno2MWNFelFVazY2NkVzdEk5Wk1kdEJza0hScm9WZUwy?=
 =?utf-8?B?NG5lQWVmMjVTeGZhZDNQMDdjTnZ3UlNLTm9uVit3RlpjOVV1emdCRDJKaGVY?=
 =?utf-8?B?cWFVeCtMYTFRT0JqclBmMXR4N3FKVm15aThBRVpDMGV0Q25wVVVmN25pZTNx?=
 =?utf-8?B?a2JpOFl4LzdmUE02ZWlHMTFJNkhDTDdOelQzaTlaUlF3dCtTYXlCWlpLR29K?=
 =?utf-8?B?TUpYTFNLOTZYVXRRL2pxNjNXeUtOUVZud2lmMkpvZ09uYXdoeDhHTG8vVXRa?=
 =?utf-8?B?eVFORGVqeEVVUTBvRWhDemdoVEJpOXNBTVEwTmtwM1BDeXV1YVp3LzFkZlRH?=
 =?utf-8?B?MERDSWVqc0dGT3BWc0gvUTdaZm01Y0FlcTIrenUrN28rTkMzVlFSallaNFpr?=
 =?utf-8?B?NUNZcllqN2FlcDA4TVBydXNCc0lVbVNEUkdIWjl5NFR3TzJzQytsRHowWHF5?=
 =?utf-8?B?RU5IWkxPdUJlQURuVUxTUzBkQnBweDJZRnJLWjF1MEo0bFBhSWlkcGc1Umxy?=
 =?utf-8?B?LzZRR1E3dWpPc3M3OHJUZGNjWXNjaHA3bzJDM091am1sN080TU5MTTczNmlC?=
 =?utf-8?B?N3pubTJRd2lKNHFGeVZ5RUtNNXhwbDBGUklrODJCOVJtVmVNNktJdzdyaW1z?=
 =?utf-8?B?M2VIanlVTFZNalJnRzd3OXcwQXQ1NUkwK1JGQUloSlVucUdoTU4vZ0hwamhj?=
 =?utf-8?B?SUVONzUwUlc2NjZqMWM5Z2ZwY0o3cmcrSnlBZ3E2ZzlYUFhFaXpITXRqWTMy?=
 =?utf-8?B?QnNkT05MRFlLNlo0cWNtMC9MRThReGgzSDBWSEJXMzJpdm14MW1zZzV5VjRw?=
 =?utf-8?Q?NX2k3xh/XLZ5mcQ7zpuLlME=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68646207-a327-4f05-bb3e-08dde4061873
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 18:34:58.9991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiugFhVUsN2urVwcgecrFNM0fXf8vAsMOFkzN2DxEAGKYG2Eq+aRkHUAlcI+i0XKb+JU0Ke87GTC1hpv68Das82LN3OHs7xB6X3LCbBOEFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9478

On 2025-08-23 12:39, Thomas Gleixner wrote:
> Analyzing the call frequency without actually using tracing is helpful for
> analysis of this infrastructure. The overhead is minimal as it just
> increments a per CPU counter associated to each operation.
> 
> The debugfs readout provides a racy sum of all counters.

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   include/linux/rseq.h       |   16 ---------
>   include/linux/rseq_entry.h |   49 +++++++++++++++++++++++++++
>   init/Kconfig               |   12 ++++++
>   kernel/rseq.c              |   79 +++++++++++++++++++++++++++++++++++++++++----
>   4 files changed, 133 insertions(+), 23 deletions(-)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -29,21 +29,6 @@ static inline void rseq_sched_switch_eve
>   	}
>   }
>   
> -static __always_inline void rseq_exit_to_user_mode(void)
> -{
> -	struct rseq_event *ev = &current->rseq_event;
> -
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
> -		WARN_ON_ONCE(ev->sched_switch);
> -
> -	/*
> -	 * Ensure that event (especially user_irq) is cleared when the
> -	 * interrupt did not result in a schedule and therefore the
> -	 * rseq processing did not clear it.
> -	 */
> -	ev->events = 0;
> -}
> -
>   /*
>    * KVM/HYPERV invoke resume_user_mode_work() before entering guest mode,
>    * which clears TIF_NOTIFY_RESUME. To avoid updating user space RSEQ in
> @@ -97,7 +82,6 @@ static inline void rseq_sched_switch_eve
>   static inline void rseq_virt_userspace_exit(void) { }
>   static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags) { }
>   static inline void rseq_execve(struct task_struct *t) { }
> -static inline void rseq_exit_to_user_mode(void) { }
>   #endif  /* !CONFIG_RSEQ */
>   
>   #ifdef CONFIG_DEBUG_RSEQ
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -2,6 +2,37 @@
>   #ifndef _LINUX_RSEQ_ENTRY_H
>   #define _LINUX_RSEQ_ENTRY_H
>   
> +/* Must be outside the CONFIG_RSEQ guard to resolve the stubs */
> +#ifdef CONFIG_RSEQ_STATS
> +#include <linux/percpu.h>
> +
> +struct rseq_stats {
> +	unsigned long	exit;
> +	unsigned long	signal;
> +	unsigned long	slowpath;
> +	unsigned long	ids;
> +	unsigned long	cs;
> +	unsigned long	clear;
> +	unsigned long	fixup;
> +};
> +
> +DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
> +
> +/*
> + * Slow path has interrupts and preemption enabled, but the fast path
> + * runs with interrupts disabled so there is no point in having the
> + * preemption checks implied in __this_cpu_inc() for every operation.
> + */
> +#ifdef RSEQ_BUILD_SLOW_PATH
> +#define rseq_stat_inc(which)	this_cpu_inc((which))
> +#else
> +#define rseq_stat_inc(which)	raw_cpu_inc((which))
> +#endif
> +
> +#else /* CONFIG_RSEQ_STATS */
> +#define rseq_stat_inc(x)	do { } while (0)
> +#endif /* !CONFIG_RSEQ_STATS */
> +
>   #ifdef CONFIG_RSEQ
>   #include <linux/rseq.h>
>   
> @@ -41,8 +72,26 @@ static __always_inline void rseq_note_us
>   		current->rseq_event.user_irq = true;
>   }
>   
> +static __always_inline void rseq_exit_to_user_mode(void)
> +{
> +	struct rseq_event *ev = &current->rseq_event;
> +
> +	rseq_stat_inc(rseq_stats.exit);
> +
> +	if (IS_ENABLED(CONFIG_DEBUG_RSEQ))
> +		WARN_ON_ONCE(ev->sched_switch);
> +
> +	/*
> +	 * Ensure that event (especially user_irq) is cleared when the
> +	 * interrupt did not result in a schedule and therefore the
> +	 * rseq processing did not clear it.
> +	 */
> +	ev->events = 0;
> +}
> +
>   #else /* CONFIG_RSEQ */
>   static inline void rseq_note_user_irq_entry(void) { }
> +static inline void rseq_exit_to_user_mode(void) { }
>   #endif /* !CONFIG_RSEQ */
>   
>   #endif /* _LINUX_RSEQ_ENTRY_H */
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1883,6 +1883,18 @@ config RSEQ
>   
>   	  If unsure, say Y.
>   
> +config RSEQ_STATS
> +	default n
> +	bool "Enable lightweight statistics of restartable sequences" if EXPERT
> +	depends on RSEQ && DEBUG_FS
> +	help
> +	  Enable lightweight counters which expose information about the
> +	  frequency of RSEQ operations via debugfs. Mostly interesting for
> +	  kernel debugging or performance analysis. While lightweight it's
> +	  still adding code into the user/kernel mode transitions.
> +
> +	  If unsure, say N.
> +
>   config DEBUG_RSEQ
>   	default n
>   	bool "Enable debugging of rseq() system call" if EXPERT
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -67,12 +67,16 @@
>    *   F1. <failure>
>    */
>   
> +/* Required to select the proper per_cpu ops for rseq_stats_inc() */
> +#define RSEQ_BUILD_SLOW_PATH
> +
> +#include <linux/debugfs.h>
> +#include <linux/ratelimit.h>
> +#include <linux/rseq_entry.h>
>   #include <linux/sched.h>
> -#include <linux/uaccess.h>
>   #include <linux/syscalls.h>
> -#include <linux/rseq.h>
> +#include <linux/uaccess.h>
>   #include <linux/types.h>
> -#include <linux/ratelimit.h>
>   #include <asm/ptrace.h>
>   
>   #define CREATE_TRACE_POINTS
> @@ -108,6 +112,56 @@ void __rseq_trace_ip_fixup(unsigned long
>   }
>   #endif /* CONFIG_TRACEPOINTS */
>   
> +#ifdef CONFIG_RSEQ_STATS
> +DEFINE_PER_CPU(struct rseq_stats, rseq_stats);
> +
> +static int rseq_debug_show(struct seq_file *m, void *p)
> +{
> +	struct rseq_stats stats = { };
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		stats.exit	+= data_race(per_cpu(rseq_stats.exit, cpu));
> +		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
> +		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
> +		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
> +		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
> +		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
> +		stats.fixup	+= data_race(per_cpu(rseq_stats.fixup, cpu));
> +	}
> +
> +	seq_printf(m, "exit:   %16lu\n", stats.exit);
> +	seq_printf(m, "signal: %16lu\n", stats.signal);
> +	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
> +	seq_printf(m, "ids:    %16lu\n", stats.ids);
> +	seq_printf(m, "cs:     %16lu\n", stats.cs);
> +	seq_printf(m, "clear:  %16lu\n", stats.clear);
> +	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
> +	return 0;
> +}
> +
> +static int rseq_debug_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rseq_debug_show, inode->i_private);
> +}
> +
> +static const struct file_operations dfs_ops = {
> +	.open		= rseq_debug_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int __init rseq_debugfs_init(void)
> +{
> +	struct dentry *root_dir = debugfs_create_dir("rseq", NULL);
> +
> +	debugfs_create_file("stats", 0444, root_dir, NULL, &dfs_ops);
> +	return 0;
> +}
> +__initcall(rseq_debugfs_init);
> +#endif /* CONFIG_RSEQ_STATS */
> +
>   #ifdef CONFIG_DEBUG_RSEQ
>   static struct rseq *rseq_kernel_fields(struct task_struct *t)
>   {
> @@ -187,12 +241,13 @@ static int rseq_update_cpu_node_id(struc
>   	u32 node_id = cpu_to_node(cpu_id);
>   	u32 mm_cid = task_mm_cid(t);
>   
> -	/*
> -	 * Validate read-only rseq fields.
> -	 */
> +	rseq_stat_inc(rseq_stats.ids);
> +
> +	/* Validate read-only rseq fields on debug kernels */
>   	if (rseq_validate_ro_fields(t))
>   		goto efault;
>   	WARN_ON_ONCE((int) mm_cid < 0);
> +
>   	if (!user_write_access_begin(rseq, t->rseq_len))
>   		goto efault;
>   
> @@ -403,6 +458,8 @@ static int rseq_ip_fixup(struct pt_regs
>   	struct rseq_cs rseq_cs;
>   	int ret;
>   
> +	rseq_stat_inc(rseq_stats.cs);
> +
>   	ret = rseq_get_rseq_cs(t, &rseq_cs);
>   	if (ret)
>   		return ret;
> @@ -412,8 +469,10 @@ static int rseq_ip_fixup(struct pt_regs
>   	 * If not nested over a rseq critical section, restart is useless.
>   	 * Clear the rseq_cs pointer and return.
>   	 */
> -	if (!in_rseq_cs(ip, &rseq_cs))
> +	if (!in_rseq_cs(ip, &rseq_cs)) {
> +		rseq_stat_inc(rseq_stats.clear);
>   		return clear_rseq_cs(t->rseq);
> +	}
>   	ret = rseq_check_flags(t, rseq_cs.flags);
>   	if (ret < 0)
>   		return ret;
> @@ -422,6 +481,7 @@ static int rseq_ip_fixup(struct pt_regs
>   	ret = clear_rseq_cs(t->rseq);
>   	if (ret)
>   		return ret;
> +	rseq_stat_inc(rseq_stats.fixup);
>   	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
>   			    rseq_cs.abort_ip);
>   	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
> @@ -462,6 +522,11 @@ void __rseq_handle_notify_resume(struct
>   	if (unlikely(t->flags & PF_EXITING))
>   		return;
>   
> +	if (ksig)
> +		rseq_stat_inc(rseq_stats.signal);
> +	else
> +		rseq_stat_inc(rseq_stats.slowpath);
> +
>   	/*
>   	 * Read and clear the event pending bit first. If the task
>   	 * was not preempted or migrated or a signal is on the way,
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

