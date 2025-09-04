Return-Path: <linux-kernel+bounces-801369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFBB4443F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8121756727E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D672FF15F;
	Thu,  4 Sep 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cUS8ZPpt"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020109.outbound.protection.outlook.com [52.101.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10296EEAB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006715; cv=fail; b=Xuv+sswV2EWhHyp/MNk3lRU8t4SrrT2dadbT08fQB4su2VYJBkfsUYFSLvvYIGDu3DMoBCeJwP0kixW6G4HYjuTlHeo9kOgNdtoZvpj2uf9t9X0GQ6VmNetPFIjO5LN9F3+neUr7eW4Ym1Lc+HxjjsCh5N2VzgvlwcAlP/Akoao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006715; c=relaxed/simple;
	bh=aQr9Bv6MS6Bt0IIVlZQ7H3EFSytk4rum/VutDaXK3QI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OA+qi3K2T10eCuPOvlFyEqXtb/SYpEpIvqLsspWPZa3B0lVs+7XuM+7YCaNNpvm2PNfBzPakE7bBbhy5zugEbSKbXPUfV2TLz4M/SXX4a3AqaEgiqAog4dP7dv5nN2pAcLAVQGm6gLH0BQhV88COdmFbZi6byvhaXRErNtbXqkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cUS8ZPpt; arc=fail smtp.client-ip=52.101.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0hbhrVgAZ5VisGuGnwv/WEwjzwONIMu71apFF+dISSz+J5o9AaoLxMk6n1Ds/t6u/fIatk9Yn2H20T1rz6j71MgdShAftQsaU6h784AILCUONXEJntd1rwWMVKZKU8ij0PtsSQ2RDeJWYU9/+8urnj6VMLvg9vIOVaA2tUI2HCOEdV4RsJx4TnToKLR2cfdQ474RnAFwS+RJGM1f8H/0NB2d1wpDaYkOcXn74gP5kICz78agq20TT9MxOUH1u/dEATVYclyWalaCcrR9Y8OuP2AS6Sf6iZ6xxemjhncbuysHfC8LGyoVyueFziBGRZ82stensRmiwrXJqKxx9vuTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmYFmdPQa3aWBNy4Pr2KFra229DFmxC4al7o6G38MIE=;
 b=dU/7/9KGqMcudbcRcLSZ2/V8GzeRd/3gRsCFAVacPumkOoT9b8WgwVCu/J+ZU4aMEJGmKX+9y0KdNVj7VOqxSXeE8IPUXcPPlPCjg7FTOw13DPEOse6fy5187sCHOdcmPu5981zLuCYuaReC9XMjFz/brnS9egRYMq+c9u6ThERaZhPGvYCMxV2bLfwQzlXWc+uYOXe5OJpPF08dyrsF4borWGXNRLqlNjFa5/UVRSVize3NZ3o4F+4mz4Co6NzQwYTo7f+dX6g41Q/KpCx2g9gPKWcr6jsKb59690uyiHgVMvBpdx86P2wj1VXiK5rplsMf5s9sBnxY2Z7Ofl+kkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmYFmdPQa3aWBNy4Pr2KFra229DFmxC4al7o6G38MIE=;
 b=cUS8ZPptNtQkHKDepwQOEJFaGhdnJq8a45sQjXPQqTcNAl1bryYmiOEEPwSbHnNLe38YIZ+KZlTiOrFKgUVaXditSqpbeRRQNxKSf/MIILnAcWprCbBP5cUSziPgALA5mGyXII+H7mwvZ+JUrz1PaLFCDQoWhL7VDQkZRRadpPyk2He0SCtm2CG3utGQtmgbEz3RCE6jMcuImDtswdnOkMiXyUDcAWL1ma1XH06pHKPUw/BdxOInEs1U+/CZeLqbMTi2Uv9onHq3ZSXDwkZcuZ9ihTKXKbIFOtDN9QilqBZPU9SA6TrftnJj+DsoWqSnyITRsB0gOeHRpJR/a2YinA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB10828.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Thu, 4 Sep
 2025 17:25:06 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:25:06 +0000
Message-ID: <a5d17e1f-ee63-4e13-ae3d-c6404d411b32@efficios.com>
Date: Thu, 4 Sep 2025 13:25:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 23/37] rseq: Provide and use rseq_set_uids()
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
 <20250823161654.741798449@linutronix.de>
 <e87fb53b-329b-44dc-a14e-e8c7a49d9adf@efficios.com> <878qix0wx4.ffs@tglx>
 <87qzwozudw.ffs@tglx>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87qzwozudw.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB10828:EE_
X-MS-Office365-Filtering-Correlation-Id: 3257db51-c0e1-454f-3f57-08ddebd7fdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEU1T1VYZnpEWGZjZG53UzNPL1NlY2xZVXVxemJIN0RUQnowRDlCRTh4eUo3?=
 =?utf-8?B?bUttMGlQUVYwNC85dlhOVHl3TmdjNVhsenl1VWRBMVRvaTMxQTRRSmJabkJW?=
 =?utf-8?B?NEY2ZmYrSThuQ1dVckY4WFArM2dBdlN6bUZQTmo3K1kwNzNFcWpucHRmTWVI?=
 =?utf-8?B?UlVIM0hoVjFvbThYRkxvSFFQNUdaQ0JBd0c5czBqd3g2ZHBwbG5URmd4K3hX?=
 =?utf-8?B?M0daVUZybmZwVm8xZlVkM3ZYcHFuaHA0ZW5wUk9jVFBlcWtlSldQMXJWWGJH?=
 =?utf-8?B?NDVHN3IxQXk0akJjSUJvWHVJdjF4cUNQNHN3dk4vbnZmc0J4TmN4alhsKzZi?=
 =?utf-8?B?RXpZcFRIWWlOTlVaVExKajJ5U3YxRmJNS2RQQTZNUUh3Q1FEaUZrZnp4NVBS?=
 =?utf-8?B?WGpaUzZvSmJIRXArN05haEhrSG9GYlZqbkYwYkJ6ZGM2RVNxTThlZTZsdEYy?=
 =?utf-8?B?THZFZmVMMEtpUk9YdTFNN2lIbG1WaCt6RlB4UHp4U0Z1TURuN1Q0K2ppUVY4?=
 =?utf-8?B?d3UyRmVRTW9GbHhVOTJycER0Ump1aGorYkExQWhDWDdXMEVDUnFIYjNDNWg1?=
 =?utf-8?B?Mlk1ZlpPOHRYQzhsa2ZDUm9mTncvSldRanoyVC8rWm9FWDBRaDZ2UmhVQ05U?=
 =?utf-8?B?S0VQZmJxVWZXS3pMSldzVThJcmJ6RXkvaTFnQTc1MCtiNDlFdmllQXNydlQy?=
 =?utf-8?B?bjQweWVYVC9raFZHNjB3Kzk2a0N0Qi9iUE1HVXZyMW1XeGI4NUM3amNqbi9s?=
 =?utf-8?B?cHEvK1d3THk3Vlc1cWtsUFVuN2pEY2MvM0lXMVp5bzNhSXVPWFkvNkEwUTZS?=
 =?utf-8?B?Ky9HdGQvbnJOL0x2MEJ3SmhvY09INE9RQzNWeGRpUzg1OXAyYXluZVJpODha?=
 =?utf-8?B?UnMrYW1nWjhSVEVnMHV5UDAwTWRRbGd1WGVtcm5XNGN6MnZWc2hQbks0OE5p?=
 =?utf-8?B?d2V6bk5yZXJtTkpXR2laMk9qa3d6THVsRlNxMzc3VGdvWlhnWUZmalFZT0pX?=
 =?utf-8?B?NXRHdFRGclJ3TG5remg2bXlQSlNhRTJFSklFb3FJczFXZEIrS3o1bzExVzZr?=
 =?utf-8?B?TjFrNjV2ek5DMHhLR3IvWC9TSmNiU1BmOFRqWU00YmlWTCs1Qm02enhrSkVu?=
 =?utf-8?B?WVZWYUdhVC9uNDRJUHN2cmJDSDA2Vm9ma2ZRT2ZjRDZrbURoSjFCdGNvR2hI?=
 =?utf-8?B?L1FwWTBiaUd4ZmhLUmVaQ2lQMHNLbm40bUZJZ01GekozM2ZzVWVaOFlmMkNw?=
 =?utf-8?B?ZmdsMWVNRXF0NGZTbVcwbmQ1THU1eDRGVW9CTmJPVFprZDg0RVVwbFpLT3Ew?=
 =?utf-8?B?MUFtMncyUmFPTkNDblNoMG03SjNzZGR4bmRta05HWVFNZUxpRXZyNSszUTh1?=
 =?utf-8?B?bVp1M1BiVEVsYTcyR3hPUzR3RitXb2dXUGZEYUo3cXE1a3kyTUk4dXhmRzVF?=
 =?utf-8?B?Q3FjcndCckN4VmdlUjJYYTVLQUplUTg2QThZeTRJOFEzbW1jSE8rTklJV1hF?=
 =?utf-8?B?N0Y2MHU5ejd3bEs5V2h4b0hpOVVVRzczcjJNZkF4N1JGNWxrNVZzZjA1QXQ2?=
 =?utf-8?B?cjVjYS9QczdpVUJMZ21DeXlCNVBHbGJ6RGRrYVM0SDhaakhCRFhlM25oMGNR?=
 =?utf-8?B?UmF0UW5jeldrN3FTWE5BQm8zdkNVV0lobko5Nm5Zdmt4UEp3SWIwRitudnls?=
 =?utf-8?B?ZEx4VFo5emVvVFJFRW9FdkNqem5sQzNQbDNEMXVESWd0bE82TzJOeDBnNEhu?=
 =?utf-8?B?L3VLdjdoRGNwNTBrOFpJT0ZjYTJzQzZuTUhoMGc4bFBvUWtJTmNFeWd0VjJP?=
 =?utf-8?Q?pleBC4Dvvujl94NbreaThUSipCZYlzdOyo2y4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1ZxMkNtZ2tqWklXSlVjVEdHUjZmUEk4K1JWK3A1U1daN1RtbXA5VlU1RHBI?=
 =?utf-8?B?VFVrZlBWSWNObGZCaGFnYi9jenNNTjJBL3dBRkdQK2tRT3M2WW5JTEhtcVhi?=
 =?utf-8?B?UXRhcmVVcUFyYTJlRDZNQ0NLWHJzVmg1K3I2VUNtRXVJcldqdFZKeEVxdTJ6?=
 =?utf-8?B?Mmx5bXgyVE9MWlJyVjRmUzZxL29DUFZ3VC9IWmM5V1ZWR0xwcWN3NUhORU1i?=
 =?utf-8?B?SDdyUDhmNkJIY3Y1dmlVNTJFVW1IWU5WOTVoazd6S01EbnBsU1B4V04yNnhH?=
 =?utf-8?B?RGh1YVlqTHJzOUg2VkZ3WHYzTkUyb2dBTTVLbkxnMWd2MWhxNWROSUdLTERx?=
 =?utf-8?B?emVsbldpdzRTYTk5MlAwQlZXck02eGVWWXFqU2ZSemVVVTZRSk45aFVqZU5h?=
 =?utf-8?B?cG5KemZvM01zTFdkMFNGVU53YytMWDJMU3R5ZERESnBXZWcyMW9rZ0FVSFdT?=
 =?utf-8?B?Q2VuZUFlMVNRdE1RcGN1SldQRVowb0IvTC9WOWx1VFc4OGptaW91MmpsUkJP?=
 =?utf-8?B?THZLd3dFcFJQUExmQk1pVlIxaFJuRk9EdUtxeGN0SjR2UmwvOUV3U28zUUh1?=
 =?utf-8?B?NEUvMHQvcHI4SXlvRzZ6Z2dHS0lBT2lDZC8vZWl3dmhYYU4vOG9SR1JTQytK?=
 =?utf-8?B?MFQwMU9iaVQzbGZaaHJ2SFJpTzF0MmkxRDhjdU1nNkJ4bG9MUDZ5QXg2NVE3?=
 =?utf-8?B?ZlUvNmpjbkNOMjNqN3Y2cUNmRjh0azhia1dNUFN6bjlxQkxQSC9XR2Y4N2lQ?=
 =?utf-8?B?dVZmbWVBbmFuR3VXNzRRUmp3dnFIaWxMblVaQ2p2VmEwcjZlUGpzS0hlTHR5?=
 =?utf-8?B?YmZ0TVpiMUQ2YnF0MU5oSzZ0RnhOUDIrQ2t6enhJenZ3dDNNNWcvMXVpcGNa?=
 =?utf-8?B?N1RLRkRQRGRQcWd5SDczRWlkRml6by96U1o5YXNyZ2czMFlwRkRRZHg0akFL?=
 =?utf-8?B?SkgrSkYvRjJ3WGc3c3NBRDMwR3JUeXZzaGVFcXhYZ05VZVNXZTdabEhNRzlZ?=
 =?utf-8?B?OC93MmpLQUR4VFY0RVYxWTAzVDVORGNpb2hvY3QxOWt6OEtGek55UTlxUi94?=
 =?utf-8?B?QjZucmk4Z2pwcWZZb1NZcjBwK2xtYnBDaUFBK1h6K0wyWVZOaTZ0eCtmU01v?=
 =?utf-8?B?Z003b1M0TDFrelRTZ2ovblRTSTd5U21DMmpDRFI0OGFhaU5BakxWZ1pKWDR4?=
 =?utf-8?B?Tjk0dnYyeVVMc1hKOFBBNytQT3VQM3pmbStSWmk0d2tGRFM3RlJQUHBqR0d2?=
 =?utf-8?B?aHExclJMejRqeGRJeVgzSmc1V24rQmZQTXNjekh0RS9DME9ReEYzM1JZanhU?=
 =?utf-8?B?aEtHVVNwdi93VjVyZFpzWTZiUkNaRlFvVVU2M1J2OGxPZmNvSWxRR1EzNWVW?=
 =?utf-8?B?UlIxaUxGeVd6Y1NCL0phTk55U0dUczhuZVpGNUZJVTF3eENhWjREYS9kR3Q1?=
 =?utf-8?B?K3R5eWkxZW93L1lRdjJpcEt3bzZmK3VaM3VqUThXd3h4OCswbFliTWN6dmk2?=
 =?utf-8?B?UUE1V3dOcktlRmFxUlRjR1ZCUVRKVWxYNzZ3a0QwdUFOeVp2QjZtMDBLUDlk?=
 =?utf-8?B?RVhCY3FrQzVQdHBBRzVmNUUzbXhiV1p2UnRxTCtaTWRKSS9OcDNuWjQ0Yytu?=
 =?utf-8?B?SHNIRDZRVHZhUmxyV2JYNnFHN3JXMnNBRHNnRDEvVWxJeGdGZXNFWUpKUS9U?=
 =?utf-8?B?dXFkeFgvLzdoWXFkVHBYQXFROVB5N242N0NEMlh5K3BQUytCMmNyYmVUUDZQ?=
 =?utf-8?B?RWFvcFhaQ0o0S3lJZjlYdHpsZW1mVlErRVpGdDNSOTR4TGpVb0RDblZ6b3Rr?=
 =?utf-8?B?SnlXbmJsK3NJSS84Tis3V2JzL0NaY1FQZklTanErTHpGbVFjVXJDMUxBVTUy?=
 =?utf-8?B?SzBJaTA4ME9uaEF2ZUZ3czY4QXp1QlFzV0lIOHBJd1RhV3dKSVdwazlmWUIz?=
 =?utf-8?B?M21oeEQ2c1htL1hLUFlodWlOajdNaUQvUUsvL25zUk8xRGVrTGRnMGlLT3pD?=
 =?utf-8?B?K1pJSGR4RmwyVDl4VnNsNDhQRVZ2UEZxK2NoMkhBSGxhUVg2UElHVFJEMG9U?=
 =?utf-8?B?djFoUUsrQVd3ZzlMWlRqVm9Ma0hSRDFVT0UrOUdnVTd2YTg5eWhzSXFZV29T?=
 =?utf-8?B?N2ZkakxWalFCYkowMFYxNGsvMXFzSkpBcHFoWlJlNExzbUEralNwTjdEL2cx?=
 =?utf-8?B?VEJXNTFtWEV3TVNoVWpsamUvb3EwRG93QzRyMWJxN2NCTzhPUVl6WmpQeGR6?=
 =?utf-8?B?dGpCYys0RHVyR3lDalpJV28zTHBBPT0=?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3257db51-c0e1-454f-3f57-08ddebd7fdc8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:25:06.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XETtDQ7MCZiguHg66Zt9SZkPCRuy96VrJkPeUs8w9md4falRTryOJftWOwyo5/ambPNFDilM3KpZXMs8msFWU407qhpAI9uvH/qFa3C/9Zs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10828

On 2025-09-02 12:33, Thomas Gleixner wrote:
> On Tue, Sep 02 2025 at 16:08, Thomas Gleixner wrote:
>> On Tue, Aug 26 2025 at 10:52, Mathieu Desnoyers wrote:
>>>> +
>>>> +	/* Cache the new values */
>>>> +	t->rseq_ids.cpu_cid = ids->cpu_cid;
>>>
>>> I may be missing something, but I think we're missing updates to
>>> t->rseq_ids.mm_cid and we may want to keep track of t->rseq_ids.node_id
>>> as well.
>>
>> Oops. I'm sure I had that mm_cid caching, but somehow dropped it. And
>> again, no need to keep track of the node id. It's stable vs. CPU ID.
> 
> Correcting myself. You are missing that this caches the compound value
> and not only the CPU id.

OK, yes. Thanks for the clarification , I indeed missed that.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

