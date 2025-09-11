Return-Path: <linux-kernel+bounces-812601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC25B53A32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A99AC0894
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3136209B;
	Thu, 11 Sep 2025 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="V6zuetJw"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020132.outbound.protection.outlook.com [52.101.191.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BAB338F4E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610916; cv=fail; b=DUMVRj2TjLnMM1LAUr9/3Z5fXtZa0v+eoZUyzWfyiZ+2jBPU7/BkJbatSFKM06M+17oBKblB2HXd5T//IgjfmxIgkikbMoORryfHmDcGPoeo/F+A/DIaWw3QsCgiykqiIj2eW6mch3hN9FkN3qEfl4B+EhE2Lyir7WemMvD8+Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610916; c=relaxed/simple;
	bh=cU+WOg56dNDFqva4YwdqdJKLiP5jYXeIN67aOQMRB9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qoTl4TwgOUI500t0HDPE4owT31fqWTa8jtBQwI9tBE0zkZAVhZMM/KtJNQfAJjWegnohpYGPi1no8gyoCclEcsBeSn+85NzdIdz8i7fb5CRTeA45F/WGDCS4Zj+swsCYfsWYukQjhU+uFHIT8sJUTTYgzCw4yNlLlKnqoWyUdlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=V6zuetJw; arc=fail smtp.client-ip=52.101.191.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqP8O3CC4UYWRyzZTrhoOTfNhAdshIKpy8hxn5hZBEuuscXT+I5D5xBo4hAHSXzPP/d1itH46H0WhOIWI8AUfIUzavjezuhFQ8IAuCTBVnr+L7OSnBK5zH7csWGjW0e60hAlhkPWp4aM551qbJX8E1nIUPVC/fqLpzrtKJ7dRQZdt6IiJbHTOPvkL79A0hs43I0X+9LPfQT0ro+v/VbRvtlW39vOdxmuHCv5EGIHxOY8LLve9Bq7KlhYbFinqC+mD0Q2jdIjquk1iuN8sUQDx4T6MEn77h255SvQufdb1Hgl4J9yJ1MDrmbLwJbDc7aka9nyo3LP0I2b1/hi7NRPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jXGMfUQheXh+3zEWk5tBAfhEApQebXfjLjXfE+kp7w=;
 b=pX1fFPHWgXbWks+A6ocqJxES8wYmXcFRRPLP7Ms0+6lg6xBQyzpQYAhzhCj6suPs/4LSRbOTNMNHbGaikNAw3R4ovnIUC9tvSiAQI5xk7vUB3iVfOymgs/yLYcKG6QlGBQQz4lBviLGIkePTgU5Rto+IoWG9511gYOVYiAMjlomUot1S+Jg32SHQhZlfFDgHuVFRPI4Sm1DEdjDFeaNROtoBVPPqSPzs9qnRB5HnouUY1+itchCuL3gd9pXunoRYt1ygdCpOQm4Ypt5v44K+tyI77OIG+VDjIl2pQnATFV+hLAZY1bQqjwF8/4qrQHCKiCIY094/zmdut061Cc5lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jXGMfUQheXh+3zEWk5tBAfhEApQebXfjLjXfE+kp7w=;
 b=V6zuetJwE0RmjQkZGDDUf5xZ6UV5iWkAh9LtiGA2pto/7gpgTlU6FdTGAkWCWiSct9uR1PDXFjlucupAAjeVPxki0EQeKQUJT6jDSR+PfIVfEgVbgmwnnlxS1DrZbAfeBOWcC6FCJig5BXlqfheAvDBI2wLYZX8hHGyjcvX2XLE7zHAYnEsKQjkpTjleLVRVpuTf7y15z7r/leP5BQR7PlgS6NWcuZLPoSyrUp8qBNdn6+Q3P8Lhraq/nuB3Ex5jgyFpuqGSz7HoW/dMV5I5+kXXH0qIzxt7vSkUsKICETbELa6kmpBfVQ17mG2hxlHgLF0ikjxMu+qZaAf6FxjodQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB5639.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:15:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:15:10 +0000
Message-ID: <1cdacbf9-9564-4025-a5a8-777211a1fc2d@efficios.com>
Date: Thu, 11 Sep 2025 13:15:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 26/36] rseq: Optimize event setting
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
 <20250908212926.929787629@linutronix.de>
 <6e0bcd7c-f842-4db0-b30b-5f6857b45b66@efficios.com> <871podrn2i.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <871podrn2i.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB5639:EE_
X-MS-Office365-Filtering-Correlation-Id: deddaf67-f876-400a-9af4-08ddf156c376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clhFVTVRcmZ4NmNFVmJpSUhkVi9kUDkxcEtTREU5NUhJQnJ0bHAveWNPdEFU?=
 =?utf-8?B?RUVtSVVIQk8wQjJVOVJmSUVKcGVwV1ZCaUFPWTJ5WGxhQVUzKy9BamlXeUxm?=
 =?utf-8?B?U296R1J6K1VQcnhiZFFJU2ZMVDlnemZ0UTAzdzl3UHZscDZPV2FjMW05SUlG?=
 =?utf-8?B?RDZSRUIxMVVLVTZXa2JGQnpQWEJUc0RNckNubnB6MkQ0R3RiWjA0R2htTHY1?=
 =?utf-8?B?a3cwcEVna0FpZllBaXVZekpNaHlSU1I4RFI1OVpEbnNGZ1dDTTNTY0NadUVH?=
 =?utf-8?B?UGR2OENvWEx0OHBMalFBbWF1VThtUnJuamhlMUpROGorSG5PQkNZL0hSdlc2?=
 =?utf-8?B?Nk8wQS9VSU9LNFBRNFIrMDR3QmdpTkNWaXUyMVF2cmtGaE5LQVVhQnhZby91?=
 =?utf-8?B?OHN2TmJzc3VYRnNObDRZZUdIVVdka08xRUxCS3BUWHh6cFNyWlgxYkNxeTlD?=
 =?utf-8?B?cXYwdFlnMktBNEFha3YyaDBDL016Z0NPZmRLWUtQWStFemZTWW01TmsrNHdz?=
 =?utf-8?B?eWphNGIwV2QrMjNiSUw5ejQwMENHTUg5UUpUT2E2ZE1jb1dVaHYybzFxNEg3?=
 =?utf-8?B?U1lwajhEWEh2dEp1NExVZGliWEFHdlpISVpoYVI0aGtBTzlJMkp1QkcvaTBz?=
 =?utf-8?B?Q0RXOTZRU3FPN1lZQ0pnd3RIK3hqa09EeTk2R2lOSERlaGdiOEhNL3M4bjRk?=
 =?utf-8?B?c0tyUldCN2c4dkwvYjlkbkhKTmp4UGtsTDl3blEzR2pRMlppVGdTTG1kNm5T?=
 =?utf-8?B?QVR5VzJ5RzhwTjNLM092a0ZGcG9xSUpTaHNzRTYxd1poSEphd1ZZYnVpTjRm?=
 =?utf-8?B?S2V6VzVMdDJraktyQnZrdW0vOWk0RndsK3ZpRFVvUmhuTEtFMVBTeTZhLzdR?=
 =?utf-8?B?Ry9MRjlBM3Zjbndjb3oxeVZnSmJUOS9vcmpST21WbHBBRC9keTUydy9QeWFV?=
 =?utf-8?B?bEMzWGhkMERYcTBlRzk0Q1dDQ0taWjlmWUM2bjdORlBoWkJCcUdkYWJKMGFm?=
 =?utf-8?B?YzhHWHpHWHdtQW92eU1GMUkxektMSGJWcVRZNUl1bGprdVNmUEhDcmVpbHBR?=
 =?utf-8?B?WVNxNmwxZ1BXSDBKcXVXZVlkTTMyNllGaHRMelFVVytBTTJWNEwxMyt5cUM1?=
 =?utf-8?B?K1VReksrUFAyMmkrUDRMNjZmWWJYVkxod1JNSm8yckpWbzhkQ3lXK2w1UWxD?=
 =?utf-8?B?OTc0WnNlYmRPYW5BNDcyTUd3R2pQV3FBbnFpQ1pqcDhNSzZyWDJpa3ZYR0Nn?=
 =?utf-8?B?RVMwMnQzK1owR1Vha3MyMjluYm5hSnhUVzAzUVl5Z1ZMWFlLVWIwNVFFNGYr?=
 =?utf-8?B?SlBNbnQrVGxpTGJzR3ZNeFBwREhZcjhlL0tlRHhIdGJPTER4VmlHMzUwUnJE?=
 =?utf-8?B?dzRlR25hRGxMaUJZUnFWVy9JQ1c3NE1NMUZtTkdhZCtmK3hNeGROQUNWQXAy?=
 =?utf-8?B?RlRyU0lMNVVDbnJnSkc4d3lPc0xXTXdmVFROcXZsZGRON25UdVpjdDNiMmMr?=
 =?utf-8?B?RWtQL01mdkNyOGtJckYvZFBKRWlxM2hJNDVpOTlMMEF6QUE2UHRpNFM0YXIx?=
 =?utf-8?B?endXMFpqSFVBTEJmTzdtNk5XejV6NHJ5NGh0VW13dThCMnRuSGlNLzVpaUtn?=
 =?utf-8?B?bzBwQjRIOVdXTVRyWm5tYitFRXFocUV0UzRvN0VDSGR2bkNXMFFQcGZWTUVN?=
 =?utf-8?B?ekFwVzljQ212VXBGanJDa2NJT1RHaFR2TFlvc2dkWSt6ZWJnbWFQRGgvbnk1?=
 =?utf-8?B?TC9qT2Y5RGNOWnM4a3VrdHVhbHN5b1V3UTBhV2xaOW5xSm9xeng3dnE4T1Ev?=
 =?utf-8?Q?CEQzE0atjAuJrnSkgTbRQ9iHFw1rYDdEZwCz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTNqMVBaYmxBWmtUZ21YRkwrMUlNTXJVZTBST2lseG1xblJZRk9jR25jQzNY?=
 =?utf-8?B?aWwxMjJBY2dzb3R6eXdNSnQ3V0ttOTlPSFlTaHpBbTVHMGd3aHdUaEZ3NEpR?=
 =?utf-8?B?RldXc2dSL0ozeXNCdFRzUy9nd0hyYzBaSWlxaEtraG45NDVSVHBXTVg3NW5v?=
 =?utf-8?B?VnBYTkdnY0xVL04vbmdkNHAzMi9TL3lxelpERTVlOURCTFpzZ25MWkxuWG5Y?=
 =?utf-8?B?VWJBUjFIM2txc3hpbS9aSElFaGkvM0tRU0dLWWRpU3Z0RXFnMjNWZHBvQzBD?=
 =?utf-8?B?OG0xcjRtT2FWbXRtN1FiQXhLbW9QaVpPMTdVZkx6ek9UczZWOHh0aE5jWXFa?=
 =?utf-8?B?c0ZpZ05kRm1hK3VnU2phTkVUQTlTcWdyL0lYTk1neGpqZ3hBVXZkaGFHeXcx?=
 =?utf-8?B?TnpZR0VVKzJyMGhiSVBEbEQxQ1AvSWxwZzVsTlowT0xzNmJQeUE4OStta25m?=
 =?utf-8?B?UjhDTXdEWFgzT2dUQ2pwT0lBRldPL3ZsTUNpZWtubTdMazR5MWxDUkRnOUpG?=
 =?utf-8?B?c2piME51d0o1T1BwYVFOUlRqaE9hWnBqYURuaFRyZmMxMWxFaWtMeXgzZDdV?=
 =?utf-8?B?K1BTWmhtdzloa0Z4UzAyK2FNbUtTSVhkdmJvcG4rdXhMeFBLT2F1L1oxeFFG?=
 =?utf-8?B?cHRac0RjUk9pVHZ3cG9mNktLSUR0cWN2OXhRaWYwNG14a0NhL3hLVUxwRUFu?=
 =?utf-8?B?WWZFeDRzM1BMcFl3NjkwNFljbEplRmdHODB5N3FwSFVoRVA0SUczSmhpbW4z?=
 =?utf-8?B?NkxMbjliNGdEVkhHVXlNL1oyczNEZWxjR0FaRVVvaUUzQTAwOEtnSHFxVVU2?=
 =?utf-8?B?dTZ5OUx2QTQyYlFucnkrZWx6eVl4alNtRjJHTFJxdVdkR1UwcVlPS24vNWFh?=
 =?utf-8?B?VkRzbHA3cDQwMkpaMU5KTXhYeXR4VUlkSkxzbFlMaEFweW1PcWI2ZE5sZWpw?=
 =?utf-8?B?SFpxOEJscFVJTjFJOUR5VmQydkJhbHhxS2JST2NPV1VLM1RwTXZhSDlFTGJr?=
 =?utf-8?B?OVk0U0V6NVRNWHlrQzM2QVBGMDJlZTkwekdMQnFYQXBjSHphcjB1ZWVDWHNJ?=
 =?utf-8?B?RkY2dDFWMmRGVEhZakJqZjVEU2Q5OFRFZnphQ2NISXFtTEhzMHNOSzVKWkpx?=
 =?utf-8?B?MVpoeXhybmEzMHpLdVBwZmVYek5BZnc1a3ZnNDBycUhKNGFKQ0V6VitZOXp6?=
 =?utf-8?B?dm43dk9JZDh1ZWxVU1gvQW83a0xQRm5DWWtwWGZ5TlZsZU1EZDhKTWU0VUtZ?=
 =?utf-8?B?Q3FUeHZkUnVEb1lsalNPcWp6dlc5cmRsMlZUT3pQdlJSSm4rVUFNNlVSNkYx?=
 =?utf-8?B?Mm52TnQ4UWhxVWJZZEs1d3U3dTM0cGVSbjdqd291MWpPdXNPeDNBTVdRYm5p?=
 =?utf-8?B?WTZQdDZLQTNJaGpJRC94TzVKN1FGbkhUN3NhbmZKYkE4TTR5aWNqNDhKWUhX?=
 =?utf-8?B?c2V4UEw2UlhHdDVnUFFVY3QyekZBM2p1Uk9oWHhmeG9uemJCK0RpTytvbjRi?=
 =?utf-8?B?SGFLa3RKbnB0MVNhakFFeWJwYkNtWlRxcUQ4TUw0L3d5RVNZZUwrOUN3Z2RL?=
 =?utf-8?B?anQvWW5zNGpJR0I3UStueWllV1JTSVQ0Ulh1WHVRNDhXcnk0VFNxR2hTaHF5?=
 =?utf-8?B?dFh4a0xyaU9LQTlHQ3NUOVBKaEZOV3c2SXZWR09pd0tyWVNKYW1FWXBPT3hk?=
 =?utf-8?B?eUNPblh1KzNtTWZJNXNuLzE2bjBYRVV6cW9ISDNsOWNyOXBUMEdsdlFJak1j?=
 =?utf-8?B?dEhCcmFSNDlqN3pzVlJoUGtzaFlSSjJyR0F3NDFhZFVLTXMrNC9kcGRiVTRz?=
 =?utf-8?B?YnNlamg2eWVYZUM0OHBUY3BVOWhmZFlSYWRDamFHOXlYUk1idE4xRVorYWM0?=
 =?utf-8?B?ZHc4bjhiWmhqdEs1V3BhWE15ZE9QeDBPQ3R5RXFKNXNCWTdNaEhaZGZoMzNJ?=
 =?utf-8?B?ZkZxdUVZRE5IZ3pQd1JLbHFubmg0aEhscVRoVEkvRHFhejgxZWZ3ZllHTUlv?=
 =?utf-8?B?Rnl3WFp1K3Zna0lZUkwvb1piNy9yekpkWktFZCtsdFVCaERpa2E1cUttZ1Jh?=
 =?utf-8?B?TVVYT1E2SDJvTXlLYjFpTHNrZHpMZ295YWhYaGFXM2I2WUxnSEdNUlZScHdj?=
 =?utf-8?B?OEJvTnV0cGJHdGVGNEZET3FQcFRyM3pML3dHZCtiQ1B1Y2NtcDZiZGFVTzR0?=
 =?utf-8?Q?MpsNIWvKJ+DOv9GuJAFl4qc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deddaf67-f876-400a-9af4-08ddf156c376
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:15:10.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jeePBuwmp6QUuycgBNVuc+k1DMMU4C++zA3VZi+g7yeio2P09cQGTR9gM7k90RQIRyAGXBpH2umJ99oUYaWHBwI+K8gbpOr5/0pW4h4pP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5639

On 2025-09-11 12:06, Thomas Gleixner wrote:
> On Thu, Sep 11 2025 at 10:03, Mathieu Desnoyers wrote:
>> On 2025-09-08 17:32, Thomas Gleixner wrote:
>>>    static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>>>    {
>>> -	if (current->rseq.event.has_rseq)
>>> +	/* '&' is intentional to spare one conditional branch */
>>> +	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
>>
>> I wonder.. except for the corner case of rseq unregistration,
>> when can we have sched_switch set but not has_rseq ?
>>
>> We could remove a load from the fast path and the AND if we
>> clear the sched_switch flag on rseq unregistration.
> 
> We probably could. Though I doubt it matters much and I opted for
> correctness instead of premature optimization.
Note that this concerns code that documents an explicit " & " as
intentional to spare a branch, which led me to assume that optimizing
it was important.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

