Return-Path: <linux-kernel+bounces-727737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68478B01EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310311CA797B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C182E610A;
	Fri, 11 Jul 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Kvl1KlmT"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2112.outbound.protection.outlook.com [40.107.116.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A4E2E49B3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243466; cv=fail; b=qKrR19ihe3YT9Tcop8DjL5SPTnQ9ahySyalllflVVBFFv1Y8Ih3QYaaq06B3AvoB2a6E3fUZF8T0Mt6RACe0XYfkMo7Q1kkyEaijAnu9tH3+7PcF/YJaT+PVQbfoIMJDvklzv10vE3gpymkzZ8cwf5x02/A8Sfvi/Wz3fAJGEPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243466; c=relaxed/simple;
	bh=4LB6x75hX3uZeRSWgkmIcKqpDGrwfwewTBqb2XUnlcM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i983lNNFMN2sOcfUS9ZdBnrNE2eoOY1zKk6EM72GTzAZwWT0SdbZm5AyQjPLmrwhWnl2Ti3lTq/B3ZvC26AUVF12D2GEVfqi4UY1dCS8mPRjEc2gkm+ZAr/G6tyUxD10uVEfacNEY29cW8rnTzDWo4PvlH3OukSiRnj16Nj4BI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Kvl1KlmT; arc=fail smtp.client-ip=40.107.116.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3OvY7QdRHbp/kvG0Rw8DY/rV4iBiMK575ZF2v2+J0SxawsOOUl77/ustpSwUuz+Ya6YJj6QHymDguiplwXhV9ShaLuaRt2VQbZt3auo2xJ6NIt9zNWj+b2FsuhSNidlfAGSLvqftuo+LEWOx6tce5DmTPDLbuz/FlOAjlFieZjAOPguBPzIOccDPZ1VWVVbf6KjrQJ03EnUBc1AlB/UTOiqy8RK33tVDmg3j73MKSd4KUc4bWFkk9q4B4/PF5ETVmMxGwDpJtYV8xHlkUfrEFT+IvZjaee2gnEQlybww8aT2m7xqRbu8DfFqDZz5uYsgWlKOkaLqJVFcXaWOm/ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTVZb8XWVDb7R1dEUYptMElz//aHyzxfH6+Dh+MPKQw=;
 b=qO8wbzekxMiRYqsQvwE8HHPRQninCr/jjdMb9tRa7rvcEeW3jh6tLpbV6QT5uCm0ZHUl4PYkwvRn8v1jE54zx0MFWMnhH96oYTKXbF1+/YvEdWMLgVrs/Os57QQI5AIKLmpNFo9n0QGWwEvlLp2T5BoGRaGue6riSbsQOPGpTjwiiBQl5yevW1/yr5GnTReXB4QKrpzDjoSWEa3XVcfMAeEZxVtwlUDMCmSKaTV4tvnxcz2msskpYv4PDS8rSaWCHzY/RLFRe9PadT6uaZ19qelG2ZCUfPigom68DQifcEzFY9m7atQgtso30DWdokJrMw7skxK70Ff/NTfTBf+TpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTVZb8XWVDb7R1dEUYptMElz//aHyzxfH6+Dh+MPKQw=;
 b=Kvl1KlmTNb5qEVh/H7J3Zpv4DQ5K8lVxlGrA5j/7qevgAVZ9NCgSkZBi7Td7G+TVhPSy1l5u0q5Y+0ukLSkGA5AsJwvYO0vaURVb3I0YTiu8qVJiX98PhwLg7ki3NU8znJoyNA4fTbcKZe6eCMygazXMwqQYLsBxNRj7C1yP+v8M2HBK+03APwgPcbc/tRjyKoME0PBtU5L197iushyqtUUl5iUIWCkGnN2gewubZJ0T7sHvFhXbCaEmCRE4c+728Vr6sO4vH0JaZYY7WGSc/MrtPNdt0Kzkv/rrIzCPMKxGHXTdqL5qeBr9TEsjqpWxCRutbL2YWoHh7sWPDre7+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB10877.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 14:17:40 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8922.025; Fri, 11 Jul 2025
 14:17:40 +0000
Message-ID: <caf5e94b-5daa-459b-a81b-fadf685c6af1@efficios.com>
Date: Fri, 11 Jul 2025 10:17:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL modules
To: Steven Rostedt <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
 Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus
 <jremus@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 tech-board-discuss@lists.linuxfoundation.org
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
 <20250709212556.32777-3-mathieu.desnoyers@efficios.com>
 <aHC-_HWR2L5kTYU5@infradead.org> <20250711065742.00d6668b@gandalf.local.home>
 <2025071124-cola-slouching-9dd2@gregkh>
 <20250711100239.55434108@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250711100239.55434108@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::31) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB10877:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcc8a77-64ee-497e-4e3d-08ddc085b180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mkdja3g3Z0dIbnBxZWRsdnN4dDNXM2R0aVNSYjJvOVZHeklLL2poc2QxcWtv?=
 =?utf-8?B?OGdQczVEc1FueEorbGlVL0liTW1XRWltZ1BOaHk2NmRWbVRjSTBQMUZGOENR?=
 =?utf-8?B?dUd0ejJMTVROYVZSVnM3Y3pTa2lEbHd0MEdRK0Z5cTNEeGJleVBSYmhGNGdv?=
 =?utf-8?B?MWhGNTltYWdncEJaSzJFNmx0dHNxUDBYUXhGWHE1ckNMd1FOdGdxalp3QTNY?=
 =?utf-8?B?c2UwajlabENnYzAzL08vK0kxSmdIckNwcGc1VGI0RzI5QTVYdXZMSStoV0c2?=
 =?utf-8?B?NFE4aGcwd0pSdUs0S0RoNW4rdHM0QzR1WmlkZ2hrOVdqcWd5RktlT3pQNHdP?=
 =?utf-8?B?Wk04cnlvMzNFRkNUTmN1eVBxMGJmaXVPTGdoU3dLR1dheEg4UHZ3d1lZNUNt?=
 =?utf-8?B?SEVCZGliWjFnOUtWTGhXRWdJOWdaQkErTnZhNVpUQlZFWmJiWnJ1VHJEaHoy?=
 =?utf-8?B?SGlZOFJvNjNrR1lweG9kSFl5Tm1iWmY1RWEvRU9mNzQzSjFtK2dnZlFyb0VP?=
 =?utf-8?B?S3N6c3ZGRWJFck5IZFBHZFQ2RXNGbWRyMngyZGlPUksxOENzNTk3SFBGUTFI?=
 =?utf-8?B?RG5sZndDOG5Cb045S0xrSDBtTXp0bHpLNmJmODJhWXJmY1dOY2FUamsvRUta?=
 =?utf-8?B?bGJjUGR4SjR6RXFUS2w5MW5ETjNycFJkaDNjYldlNzdQZlFNZ09vdnFmcElo?=
 =?utf-8?B?WWRLdEtSV1BPS1Q3bjNwaGw1a2JZRzJkUmpSUDh0NFdvRko5M0wxUGJqMjJR?=
 =?utf-8?B?dFM0RWJaN0dURlFoUGliangvOXdVays5ejNabEF3WW56dzZvUHc4azVJV3Q1?=
 =?utf-8?B?R2l0c3I2a3lwM0tVcXk4L2VEdFBvL1l6Q2YyMVV4K2xqS0VUakxkMjA3dWZN?=
 =?utf-8?B?Y29temhtU2ZQMkwvU0NCT3QwRm0yZE1ydDdTV0ptdEJ6SVZJODBUZDdPSWpB?=
 =?utf-8?B?ZVhwTnJ1cXE5WEJWdHVtR1lVSXczeXQ0R24wVysxeXMyZmJndFROSWJYVkQx?=
 =?utf-8?B?eXd3aVZyellEdTBsN1crYW1OdEtkQll4alcxNWNaRExxMC9rMDZzc1RubnpN?=
 =?utf-8?B?cVl3MlpLOWpZaUo1bVEza0R5dWhhWmtEc3FoMTVYbDk5S2pvRVBzdHVaL0l4?=
 =?utf-8?B?a09ZR3JJV09tQnZFWHVrYVRWVkM1SUt4Qm83ZkJCUmNCR2FMZXhlYzRzQ3Np?=
 =?utf-8?B?OCtSM2xqNDBxeWJOazh5bVBoZSswTXdqUkQrSmFkSFluVjUzSTRjVW5rNWQ2?=
 =?utf-8?B?bDhSVVJxZTR5M3UwZkR3RCtxVGd6T3YyUWphNmd5SFdwY3lEQ1VYWlVXaUdm?=
 =?utf-8?B?YW81ZVhoVjZrSW9DREhTUWlzanJRODJ2QXRhZGxVSUl6Qm1lOGQ1WVl4Ky83?=
 =?utf-8?B?MnRHSDhHNGpyRy91THJuRWpyK2svcG90UXJRMlUvM1F3SVFPRG90WkVtUHda?=
 =?utf-8?B?b2hGa3JhUmRnWmFkZGVrQnN5T1BpS2JYUWpYK1NtUjUyZnBDdDJiNVhHenk3?=
 =?utf-8?B?d3ZVajVuN2w5aFRRNlVYendMemFadnpLa1BoVG5rek5FQmNramlCcFRnWTM0?=
 =?utf-8?B?VHR0aHBsc0drTW53M0gzTzY1Tmw3a3hwMlRUcnBCemNYbERLWEoxZ0ZOTVRq?=
 =?utf-8?B?YXduR0ZxbzFSbEdHUWg3NUVhUk9jQ1Nvdm5scS9DNnJkTlZDdlJhaFVUMGlu?=
 =?utf-8?B?TmFiZmJBR3ljMUJiUkYya1JkN1ZlMVNVeU1RdUtNWFdhQUNkcVhnc1M3T2ly?=
 =?utf-8?B?dFBKcXlPOEFwS21qT0NMRlh1UjFyRCtLWGh2Z3h3WG5ablR0NktYcFpiRjRy?=
 =?utf-8?Q?EhLLs7/vE0YUsbxdT1/+I42RYr2sJ6MsK21+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjZlV2VuR00vY2xLb2psUnRaTWZjejM3clJlUHozOHRrVFRtd05VNWpLUzYr?=
 =?utf-8?B?a04rZURKU2UxWGVqTEM2SU1jSjV4dHpERXRUeGc2bGRuZURBTWl2ZCt1SjJW?=
 =?utf-8?B?TFJFVWVGZkVMbENXTXlwSGlpcWk0cGoraHdjeCt1WUJJbUdUMnBpRG8vZ0sy?=
 =?utf-8?B?alVrY3RCa0NxQXowcmhOVlRub2pvSGRxbEhWSmc3R1R4bWlWU2pMdTJGeGdo?=
 =?utf-8?B?ank4STU5bEVGSHlFWnEwdHo4aWdMYXFadlpnNE9lZTIxaVdnRnhYcjBHeGNJ?=
 =?utf-8?B?NEppeFZTMzdGV1VGclhLMjBQdUU1WFVJaUZ0WCtlRTBrNU93YlNHYTkrMlRD?=
 =?utf-8?B?bnhMTW04T2M1bnJ3VkNEM3BtRzhCQ3hLSGFTaXo2b2VzSEtwU1NhUGFLYzY1?=
 =?utf-8?B?VllxekdzZW5jUktJSTJrSTJKTStUZS9LYjByeGpNWldHbldBdFlocklvOE1J?=
 =?utf-8?B?MWhFRkEvNU91c1Ardlorakt0RldTOHhmdU9SNEN4NGhxU3ZPWEY2eXlRdEdl?=
 =?utf-8?B?MkdQb3l5aFAvRXRuWVpaUGFMR3NRVzVvSG56TWRPZWpVMS9NWWxmem1ueFJp?=
 =?utf-8?B?OVlNNS9MVGlqZ25UblFmZTBxRjQ5TVpyazBFUUtNTkMvZXFrV00xN0JTY1Bw?=
 =?utf-8?B?V3FCY2djcjJiTXdwN0xtWGVSQjRJemxWSWlQNEdXTWZMenR0eTJldy9iUUxV?=
 =?utf-8?B?UU80WW9ncE92ZFFva2F2UkRiRG1VNUNpdm5sRzJxTXZnbFp0Q1p0anpQY3l5?=
 =?utf-8?B?QWtXN3ZhcHdVMjdpM0xMMmdRSHlRQU5WOWFvWWl1bUk2ZFZNYUFtQ3V2T0Na?=
 =?utf-8?B?Um11ZndTSFExTE5hWDlMZllETlhJeWdaWHMvUkV6Y1dzRlhRT2JPK0dYczlo?=
 =?utf-8?B?RW9ZRUEwcmRPOFlFVzcxYW1VQ3RIdk04aXEzb0hsU1dwb1NCYlVEN3E3bm9R?=
 =?utf-8?B?VG1jQjRFTVQxRWdsN1JkVE9zYXdzUmdvV3MzYWhxVThqU0FGa055MS85UDI1?=
 =?utf-8?B?T3lpRzBwek9qTWZUZnBjcmZFdEJDMm53eHI5ZSt2Q0RnWXpyZldKVlRuRmNR?=
 =?utf-8?B?UHgrOHltbkZUTUhmMmFML1I2VU01L2xiR1NZdnMzK2pwVzQ4VmloLzNvZXBu?=
 =?utf-8?B?M2RhZ2NjY2hkekFuclYvbVh0dEIyVEkzYUtoZG5nWGVEbWpBUlRQZUI4S01t?=
 =?utf-8?B?eG80QUx4aHFoQVFDbG5DdTRnZk1ockdEbG5OMklxcGdVNnpmUnJMU0FwQ1Bo?=
 =?utf-8?B?TWdyZ3lZbm5taXlHemI0bHBKVG85M3lmSUsvb1ZOUHd2UU5ZMXhHb3lBOXoz?=
 =?utf-8?B?QnZOaklWSGo0KzBmZHVkWWxnZEM1aU9DVzZxTUxzWXZRTUJiSXpkajZJMktv?=
 =?utf-8?B?RWpTejZtbGQ4Ny9tdG1ZS0hQU1pqVjcvRnNTUjFZcE5RL2NqTkVJUFRiYUFW?=
 =?utf-8?B?cUMvelVIYXpCMkxoYjdZWnpJUGdER3BrN1VFUGhKOWdVbDh5Q01wOTNZUEVz?=
 =?utf-8?B?cnpkYnVOMnE2Z0xDbkFIN1lpQmxuR0lCMCtacjJwMmZEZ0piZ1ZBVWdOMEp1?=
 =?utf-8?B?ZzZJMXBLa0JzcWRWZGpDOXNUOFpMdHViWi91cGJ0TWhoQytMRnB6STZwaDFj?=
 =?utf-8?B?Ym1LSlZIL1BhaDk5SnZYeG1hQm4xcTlUK3p3ZjZhWG5UbHpCMnhEYlhPTjJU?=
 =?utf-8?B?d3JWTEh2Y2JYNUNZa2ExelQ2cERDbjkxQXZham95aEtLY1BKTGpFK3RVbUhU?=
 =?utf-8?B?aDgzSklPcGpISHhxdmowUXUrWndBM2dEOUkvb254cVE2SWZOVENHL3RSUFpQ?=
 =?utf-8?B?ZTBPdUozWmw2WkNEQkNGWGVCbzRUcXBkRGsrTC80VFdWdWkxeC9tRUpoRDVD?=
 =?utf-8?B?eERvOUdaRzNLeHRML2RyVkJSbDdKUXZYQXNMWVdWMDVMOXdrM0NRVjB1NWZK?=
 =?utf-8?B?SlV4OFMrS3Evb2hlSXFacy92YURvaWNLRjJpY01ENklCREo3cVlSQjRsRmwv?=
 =?utf-8?B?bEhrSnRDZ3IzVFovR0RNbHQvdjF6UGRFSGJYNXRuU2V2U1hyejQyZ29VcFlI?=
 =?utf-8?B?a0M3czlXZXBtdnlVdUFGWm5DdWwrRVh6UHNaTWhMRE1MbUxWTUl4Qjd6T1Mw?=
 =?utf-8?B?TXprL2Q1NCtlR05TLzRjVWw1THlwbWllQ3dYMmxoRlMwMHBidytEanZsSEo0?=
 =?utf-8?Q?A58YfPA9YHf9tQX3lThmLww=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcc8a77-64ee-497e-4e3d-08ddc085b180
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 14:17:40.0283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJMqmCcASJPtxIIfHsM7cV/9wscJeR/7cZTTbNXLuAHq3uIX/b/TcOqGO+hkgvaHfj9BfuHH6SUXfQQ8HaxsZj7Mt7OaeKBieWnc3LC5lp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10877

On 2025-07-11 10:02, Steven Rostedt wrote:
> On Fri, 11 Jul 2025 13:38:07 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
>> Yes, lttng is a "good citizen" of the kernel community, and yes, it's
>> not merged into the tree, but that's not our issue, and living outside
>> of the tree has it's penalities, both economic and technical.  This is
>> one of those penalities, sorry.
> 
> BTW, when it comes to tracers, being out of tree is actually a huge
> advantage. Tracers, unlike drivers, are only monitoring the kernel. Which
> means it doesn't really rely on the workings of the kernel, so it really
> doesn't get much help from changes made by other kernel developers. Like
> the BPF folks have said keeping BPF programs up to date, isn't that much of
> a burden.
> 
> The huge advantage that LTTng has over perf and ftrace for being out of
> tree is that it controls the ABI between the LTTng kernel side and the user
> space side. LTTng can experiment with new interfaces, and if something
> breaks, it can simply change it and deliver a new tool that includes the
> new module with the update.
> 
> One thing that perf and ftrace struggle with is getting the API correct the
> first time. That's because they have no control over what other tools may use
> their interface. If I expose something that another tool starts to use
> (like powertop) and then I change it to enhance tracing and it breaks that
> tool, that change gets reverted. To make any new update, I have to guess at
> what are all the ways a tool could abuse this interface and also make sure
> it works well into the future when new things come up. There's a lot of
> interfaces I would love to change but can't, simply because they are now
> ABI.
> 
> LTTng doesn't have the burden of worrying about "what other tool may use
> this kernel interface?", and can even change it much later if Mathieu finds
> a better way to do it.

This is indeed one advantage LTTng has: it controls both the kernel
and userspace sides of the software.

I should point out however that since about LTTng 2.7 (2015) we've made
it a project policy to never break the LTTng-modules userspace ABI.
Those ABIs are effectively append-only (with possible gradual
deprecation) to make life easier for distro vendors for which the
userspace vs kernel modules packages are not in sync sometimes.
ABI-breaking changes to LTTng-modules makes packaging of kernel + OOT
modules + userspace tricky for distros. Similarly to the Linux kernel,
our "do not break userspace ABI" policy takes care of this.

So even though LTTng does not _break_ ABIs, it benefits from controlling
what userspace is allowed to interact with it. The fact that we have
an aligned release cycle across LTTng-Tools, the LTTng userspace tracer,
and the LTTng kernel tracer allows us to deprecate ABIs at a faster pace
than what typical kernel ABIs with arbitrary userspace consumers can do.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

