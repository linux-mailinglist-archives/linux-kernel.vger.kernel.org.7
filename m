Return-Path: <linux-kernel+bounces-876546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC1FC1C0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DD815A91F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868453376BA;
	Wed, 29 Oct 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="o4nd1Pqb"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022085.outbound.protection.outlook.com [40.107.193.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C4721B192
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752393; cv=fail; b=NCtFmJsQJ0IbEwoaFdw2XBa85PR/jHwvtJxA9QVCsBuhlciyLB5uEP0bqE5QwHIqnQFwM2+UwrV1qVFrQ7OmiABodmJWKNix83FOwc6eM4mGzK0qM0T9pVQygZUPqdWqn1/FXs6pGJhkfvrbfHXSIFRHi13fEt+Lvs/flE0gTGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752393; c=relaxed/simple;
	bh=xPKQ0iiKFum1ReheuhcLHPpfEYYNzuGwkF82UaL7/bI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BFYfE5FQtGBU1rNZcQ0RQ3TtEWozHcH8D4Wzc7Pa8HmRbZ2zoV10zuICUbgSkqHgQJQiMuVdTqtLjF9IfrwVP9nlxn14oW9BaDzxCrwXG0DwX9VgT/QA1lL5ZQI6QgKDCPSA4Sh21hMwGduDwjsUSQPbMeXWqv87/8P8mY+7dKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=o4nd1Pqb; arc=fail smtp.client-ip=40.107.193.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkSWik7a6QmdNVlCXQrewUHgBeME6zIdqXghL2SHk3TFXHfF617z0qPWOs+IhOI/AgnZGFV4bBeGcOsOvu9gqMv7yueIh2P/9MakR43LoJaq/r8MoK3JVJJSRK95HANQYpP9H+P73Q8dGdvAaoEba5UoOgG6FPSJv0uGV3eLJfoyKvDQq3HxhdDXv8VrMDRQiXsIU03O/UeowPDfl7EMM9aCB8qafNv5bxYiXGnYGgmHGmKrUzODDm5xcK2XCHX3w0sO/+0iewIee6jUzZyuudK3ZeaLZ9x50gXzFlTsNXSHxRFTBHy4YgZY54b7GJQX9Pa5UxFnhGoqD+S+g6PlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7sWzOliyn/IbyCHwy4FgB96TkxNH0sib+vQ6tAEAwc=;
 b=T5kOv1x5qN0LtVk7WKq8eG32JKxBGzBCeIfBpZDLxGqErytf5v667778nxZ0I/SYSRfAIl4XjSMP3KJm3bjS5pi+ZWCjdBKWT4ZQknv8l635jZ63/I9vGZhsjhz5AH//KkLgt+c/4COaaCUzYYcmVixIF1EkDMF8my4qR7v6udMEI/kZ7nei9Vbnl+RQ3+ClmPmFM9yRMMYx8/1cL+CUwN0T9UanNxWFvxyJw51k19zZ7jF79m0ouuKxh2kvlti0JFaMwsK8wOeCztHMWyrCe1rm3UY7bNlOBeyFXVQ506/dfWzsXoPNwV5bDdlGr50cYVCNa4EswUuXZ+r9PM3Bcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7sWzOliyn/IbyCHwy4FgB96TkxNH0sib+vQ6tAEAwc=;
 b=o4nd1PqbCpcCYq+XepavMqIiCqS+tJtOoWGRSUE4s1qeQ5uKd7fFmd/XVLiS2sp+RrtQTKWfkD26Bocj1RohIoi7LKJ0rDPtdI1+n2UHm9hvtfRmLD1ZDdlVt8pqS9tjsoca72VT1uU/EGABRhxIs8seKE0RSRLWWP8gyeshos1LVCg2VvNaxtlbLXeIs8edLgi9R+iOUqZxh5279LlnME2nhCffRAWeo5U6Xm+pWSMz0fFhV1jwvM+9DazmPRcH9bOkWM5aut+ak9Nq0wWZG3EIzBFh2RUTaIGLTWPnRfcnc+MrW43PIJgqLLScEkK+mAS8FW7KzR/pGEgwEKFKkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9717.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:39:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:39:47 +0000
Message-ID: <996b1e7a-59df-4638-9dd8-ff6edbe8d1d4@efficios.com>
Date: Wed, 29 Oct 2025 11:39:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 03/20] sched/mmcid: Cacheline align MM CID storage
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>, Michael Jeanson
 <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.466070081@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029124515.466070081@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0262.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::24) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9717:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d6fcab-03f1-43c4-4e17-08de170163a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ZQVzJWK05rZUIxTXdEcmRsNGJqdHByRkwzbmRhYk1XTGgvNm9kS1pSOHdi?=
 =?utf-8?B?U1poaTNtU3dFaUNORHdGQXpRNzRrZWh4RW9mUWJOWm5uclZjTkU2cTl3ZmhS?=
 =?utf-8?B?aXl6b1pvdWJTVjJxRythM3hXK2ZRbEVvdjVNQ0lBa2R6a0VTMWtxelJTZWhX?=
 =?utf-8?B?Vmt4NjJiRFlCTlZNVllPTUtQWGd5YWcwN3VIbDI3eDlhL25MUER5NW1zb3ZO?=
 =?utf-8?B?SFU0L2l3QWduVXJ6ZTBCSkpBS0ZZRW5MQ0lZUDRsSDJCVldUMkc0RGdnSjQ3?=
 =?utf-8?B?RnBaOUoxTlBsWGdkUjcxWk9ER3V3SUVrZVU4enFrSHJwYVR3d2M5QklUSko4?=
 =?utf-8?B?SWptMW1Sb0N6MTRyTk1DaUd2M285WXQ0N3o2c2NFQXIzSUJuVWRjNmwvYUFl?=
 =?utf-8?B?bTRRWk9mV1J2cjVzZzFPdDZvbGV6anpERVhyZnpZSEFqR1VYejVpeksydGlZ?=
 =?utf-8?B?WHkvbzBDTUtnbEVxdTJ5S25XY0pSTDBlMm1icmJIWE5MdkJZUFpqYlg4Rlg2?=
 =?utf-8?B?QkJGNkNlMnh0cHc1YU9CSFNYMWZTZi9LcEhaTUZlRlIvRjV4eHRZMkRNK1ly?=
 =?utf-8?B?em5zMUJvZzNvWVZYWkZUSG40VE8wR0NqNXBEQkpHV1Jjc1VnV0JnRGVtbEh2?=
 =?utf-8?B?ZXU5bEZVbTNwdEhON09hYjl4WDVjQk5OWmdMdlJNQlJ1WmJOQ2M1WnY1RFF2?=
 =?utf-8?B?SyswODQwUXpLS1VJcWJmMHhsTzNEVE9NMHFTMFk2MHhRVDQwMy9ydmhmekJO?=
 =?utf-8?B?YVFWZTA3bE00QjlIZzF4RllPMWQ2ajlyc0UwWlhVOTY2bFdIZFNKcDFqd0ds?=
 =?utf-8?B?Y1IyKzA5bXNmMkZvOHhsVmZYNFpoenZmc3ZCY283ZzMwbXNDSW9XbzJxSy81?=
 =?utf-8?B?blhUb0pWSjlVM1YxNXQ4cFBQUXFGRUpOc2ZQNm14T01uTXlDaUVXaVNuUWhE?=
 =?utf-8?B?VTYyRitKbVVuWkVBUElabzUvSU1BRWg3clJ6dTNCWDc2TDBnL0s4SGRYRUUw?=
 =?utf-8?B?STBTbHljRHpZM2ZHakF0WWJTb3h4d0Q0YVdzS1k2bkIwOE5kUlV1SzNzWk83?=
 =?utf-8?B?cHhUVzI4cFNLNnd6Tk11TTFIWVlZTDJVRTd1YlhPTUxFVWFMVTBYa1VzSStn?=
 =?utf-8?B?c2tuUTg5bzBCWWRNRHlDYzNVZTJqQjJSUjk4N0dId09lY2M2ejlKTHBGYmV5?=
 =?utf-8?B?aTBZNDhsRGNia3BJYTBQZXdrL3VJMnVxb0t5SlgxQlFBWmpXTm5zbnZlRnhM?=
 =?utf-8?B?MTRwbVdGSkttNDBFbGpSL2ZYSzIxQm9xaXBoT1lHaEc3Q3dUOEIzZkdsZzNt?=
 =?utf-8?B?bXRDanJlcVdxdEI0dGpmNTFuUUNHa0RSQlNtZ3J4TDdoQ2ZFVnhWNUdJTWZX?=
 =?utf-8?B?SExEUTBJUTBOMmZrTy9Ddmo4cEVna2x6RE5ES0o2N0pVYUFQdGhTd0ZDelk2?=
 =?utf-8?B?QkwrVzB6cnNzUmViUDNxV21rMUxWN0N0YkhtZTA4cXVDa1hjdTI0RlgrT2k4?=
 =?utf-8?B?bmxRaTI5VHdzbStvQjZXZHJyV25DUktLamlUZG9lUTBKdEIyRlRCQ3o2Ky8v?=
 =?utf-8?B?WWM4V09NYUpjdjNycXFXUndRWm5ZOFZpMzdvWmJpLzZ3dXZ2c1djY1lHaUhK?=
 =?utf-8?B?Qm1Zalhvam50VFZLOFB5T2tiT1dJaWpoRExKRWgvQllXQWc1enVQcFJCSVF2?=
 =?utf-8?B?a0VrT0JFSlk2dlNHSTExcW5xZ1JlK2xMNHpoWU04U2hVVE45ZkdqL3gwTGNl?=
 =?utf-8?B?Tit1OWRxall3aVFQcU91eWhHQXhrSENzb0I4NFpuSlBROE53TE5aSEQwMXZT?=
 =?utf-8?B?clpZbG5oRnRSMkwyTkJMWkVrZGtEMU5WbXV0eVdRQWhXZ3VpUU9kc090RmNu?=
 =?utf-8?B?b1ptNnNaUW40dWxtaUNUd2FRREhtalJlRTkwUkdXNnNVWUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHJtRGloYmY2Wm1GVWFPeS9odkdzdEk4ZWxKa0c5WkxjZ2FPMUxHTGI5a3NX?=
 =?utf-8?B?OGU0Zy9Ba1YvVGxabjZNVW43WTdWdG12QVZybXFNMWlibEIzVmJLYzJZellQ?=
 =?utf-8?B?TW9PSnN0Zm5DSnFEYThxOW10NUtScU1wa01ydHlCcER1ZVJ1ald0bnR5Vmw1?=
 =?utf-8?B?N2Q5eGRCRHVzeFF6Z29VaUJYNzBTaUlrS1RESmQ3YjJVUVR3V25rWlp5ZlBq?=
 =?utf-8?B?MENHWlV2OGtkbDBFUlVON1plMGVLVC9GQ1ZEUEMxM0RTSW1SeWtqYUxIUkhN?=
 =?utf-8?B?MGNnVWIrN2htdDExVjB1dk9sWTZoa203Y0t6Mnh5ZkpUbURXSVAxdlpQY2cy?=
 =?utf-8?B?bFJIL2JTRW5haXFjSS82d3NmOXlmRm5iQ2l2bUFGWUVIZW5XZVZKWklPdUo4?=
 =?utf-8?B?ajJEa3FFQ2JDMk5jZENvVUpYZGlSSmp0NHpsamk3b3M4d1FQTnhUVjI1dFZ6?=
 =?utf-8?B?Nzh4RlkrVEpmOE93cnk4L2laNy9HS0lNMTF0WXc3WTR0M01YZXVNOXoxM2tT?=
 =?utf-8?B?dHJNQUhxWDY2WGZZZWhGNHdkMjk4MnlxNGdTMzZuQkw3UGFoZ0wxRnd1VlJD?=
 =?utf-8?B?WnlBY2JZaEtkRXB0RGQ0M1doMmZFbnkvckprVFdNc1FIbVNiM0NPR0hxUVdI?=
 =?utf-8?B?RTEyZTJDa3gwdGpnMVNjSm1EQ1lzTFBUdzkwbElvd28raitwak9tUGNTTnIz?=
 =?utf-8?B?QjVNS2tzaTUvaUtHRkVESUU1OWFaNDVzL2pvbzU0OEtlNTJoZUZxWDhuV3BZ?=
 =?utf-8?B?Tk5rZ1AraVp4ZXl0R3orUnQzM2Q2dFJBVEttbHUzWGJkWmovUHp5NUg3STcr?=
 =?utf-8?B?YnZGMXZQaDU3ZEk5aVZPZDMvRC82L0hhQ0tFa2cxNUxJTU9DWkRqeEt4QnA2?=
 =?utf-8?B?RjQzdzZ3dzZUQ2VZcGF1R1VDNjFqOTJhZEFtVmEwclp5My9vamlMbitNZDly?=
 =?utf-8?B?RmpwRUJURU96aE51Rmt5UUlkbTNRZEdnQ1R5TllMRjE2NTFOMUlRQjdLRTVK?=
 =?utf-8?B?YkNEMlhOWDljY1pRWVh4VExxRkNXaFU2ZGUzdFZQNDcwTjI0OGxBVm05N3RW?=
 =?utf-8?B?bzRKZlA2blFYU0szY1l4UFh0R2FIUFAvaUJwWmJ4UWZxWmpndldTck0ydE9x?=
 =?utf-8?B?MVMzV1pzYTdIV2JOS1hRQVZzR0VxdDB0akRCUzFCYm13TTJCOEltR204ZDNM?=
 =?utf-8?B?b3l1Ykc5eGV4a3VRQzJnQVlzVU1XVU5KV29nMXBHNGFTZ1J4WE55c2tjc2RX?=
 =?utf-8?B?UkgwWDNlS1VZc1NrdUpCd000c2EzRUI2TG5YMUdxM0lVU0tPbkpkOU9yTDAv?=
 =?utf-8?B?ZWVWd01Rckd5R1FSRUR3L3h3a3ZVOFR4bEcyYlZGUkJPWkxJdnJDV2tLQUFu?=
 =?utf-8?B?YWhFNXphbEVJTXEwakdDS3hOa2ZzUTBuTkJLMjlLSU9FTGpMVzJFMklITFBs?=
 =?utf-8?B?SnQrMlh0U3pGQmszdFgxNlNGWHp1VzBja1A3VEJ4RDhTN3NWNFhlVFk0dTRD?=
 =?utf-8?B?VmE5MmJGTWV3TVV0NkRXVWtoaEpIeFE2aStHTnRZSUVSVlhpL3RnRzlWYTR3?=
 =?utf-8?B?aDF3NEthTWoxMzg0bFFEdVRTUzhQbnZDNTN1N0xtallXdURJK2FaVENpSE9O?=
 =?utf-8?B?cE1yTmpzT1JWek9KUCtUblVSaldwV2tFVUo5L1JzbVd3K1kyYmViT1FPOTNx?=
 =?utf-8?B?eVJUTDZURTRuOHNEOVk5N040UkpSL3EzdU9wajhCMFcwTDNTc0VrdS9IZjNM?=
 =?utf-8?B?SHhucTZSSDlmNE0rQzNxbkwzR016Ty9WSEVEclJqZXJiMFJyUTRtSW01MGJm?=
 =?utf-8?B?WEtqSHUxbmRkZlc5QUltUW5JMzNhWDZSOWdZUXlZWEx3S09BcEJCTXhJT1U2?=
 =?utf-8?B?ZmhPTVIyVkNoUU9XQ0JubGlOYVNGWWhlOHF2VDZmaEgxbHJ0K3I5OVpadXlF?=
 =?utf-8?B?R2V4YnpZYVY2djZwd2wwUFBWQVVBcU1FMGVGL3dER25QckJVZXE4cnVDNG1q?=
 =?utf-8?B?NFdTVVpncFV6N2VVbWxLMlVaRERKSGJRb0t2R1lFUVpyLzAwc0pscGR1cUd3?=
 =?utf-8?B?VkVkc0lVVWFJYXFycnhIc1ZzSEw1N3FuY05zanlBZ1FsVmtYUlhETHB1amQv?=
 =?utf-8?B?aTNRQVNhZDAxcXRqR3poc2NYUzhGRDZISFRGOVpJSG54NG03a1R0eC92SjRz?=
 =?utf-8?Q?B3bhuZcVp2AoJPwQfk7Xy4U=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d6fcab-03f1-43c4-4e17-08de170163a6
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 15:39:47.0005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8f5U7jC4Gk/+2CZW14UrRTw1Y+0YDhncfF+geHQXQo6cvDoHSX4JDN3YzZaigsIff15As7+hOSqdVfJIZpW22bFr4Yher3yHK93psZVilA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9717

On 2025-10-29 09:08, Thomas Gleixner wrote:
[...]
>   struct mm_cid_pcpu {
>   	unsigned int	cid;
> -};
> +}____cacheline_aligned_in_smp;

What's the point in cacheline aligning this per-CPU variable ?
Should we expect other accesses to per-CPU variables sharing the
same cache line to update them frequently from remote CPUs ?

I did not cacheline align it expecting that per-CPU variables are
typically updated from their respective CPUs. So perhaps reality
don't match my expectations, but that's news to me.

> @@ -126,7 +126,7 @@ struct mm_mm_cid {
[...]
> -};
> +}____cacheline_aligned_in_smp;

OK for this cacheline align.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

