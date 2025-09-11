Return-Path: <linux-kernel+bounces-812318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A29B5362A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAF521BC1484
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990134AAF3;
	Thu, 11 Sep 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rZ3ZQuBw"
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020097.outbound.protection.outlook.com [52.101.189.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7450B31353F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601958; cv=fail; b=Dfcmu0vMwMupdLHf67K7JR4YjJvGBJHXtz6Q6K/VIyhZti2UZdFAgwhkPz5gtwmzDgqHX9bBj3T5WudLPmtsLD1epB5diJVNk4NM8EgFAPI4ZSTgUR4t/jb+S4ZEVhAc0yQoir8pqGgI8oVHt7MFtGatc97YJvOx9TdeDfblpeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601958; c=relaxed/simple;
	bh=zW0L2CBi5w+VuzD48m8pcoFJjkEFl/MWBTVWEQwWLdk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k+rP/lIIzqmc8wgF06HnlaTAe0wnq87WnnzVhUKXwMTUJ1nfke/Eocapklx92d4dXAvUxyOgwQOgnq+JDwo6Z8X+aBRzux2LmqoGFnSrzXAX4eN7wPKz5Sg1OE1sk7j8TfLOtFFbua4OM4FLuM6igJDZSm0PyJLHoRVyv00qIwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rZ3ZQuBw; arc=fail smtp.client-ip=52.101.189.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zib+1by73ytXr3rbhQiZe+F6HVoI9FpUTvWdu7uzoqFlanlLwjN1gjFark9OlvtdwYqTy3X3U22/BSv2yu51pZ/mWW95SznzzS4flsKMwUVG8wWzZTBR0eqLbit31NXziApg3HxqTOr9E6YyQSdmKRlTudMgKPpDWaHsHYQylMscjljutZXJarZ4rVS8HXuwCBo/EzKMY5bsDNYNYfepRRpsZHzo990KOGOiZIaL3Ta9q8kvE9dgXsQ6iBo64RmWQB9mjmkUUm/VHepxzVXlThV9Imy/gCFIM0kOIQcFnbaK7pfpmDPYXnfxOAVGQY6HSMwk258tdt0fFehJSq83iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8A1MryOjnDceI6AvEd73StZTOM5xvaKzezITgzsDZA=;
 b=grpp3uDuZbUNxbo+UJLWI+YsJCdwe6O07qoClvWKU9X5OfrPgiaBfhWfM0D54Gsm5ixEy5sDVvZUdGzXSx6Rq8Yu27Pr+SeKrlJMduNAUcW3ZYVNzz0+sDYO4rY3VfrwymCmE8kbtX1btV8oLRiFc6Sir5UJxwFniaHPPEsokVsK84rwom67GLM48to4hboEgSoM1jR/U3ajSTXGlddE5O+WyOjfTuInSPXSnlwF4E02wx6dwSFNpi7HQ/pVl6waC3oq2YRx1CsWmy/Cl4vUZAQBkRPYsrAOb155EDA6+VqCiQ6kEnjESNpIXXdgUHNwiwaRVlY9L+ZEzBKmULzxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8A1MryOjnDceI6AvEd73StZTOM5xvaKzezITgzsDZA=;
 b=rZ3ZQuBwfVzsuk3LM0A9o7BncScHWGmYC1A0VzKrK9AqeMpP71/lrdaCbNUHMElGkT/4lzA89UZbXJ4Tb0PypN2FMeYr6f/+5AC8hKHy85wM7OQg60y5rP9fh5HE6e9h4cLtuguAOHx7BdI1mCde4IIvK80fKs1TKNyqM3a/tz1e6ReMRSbyVM43JhMiY80TuMRIqjjR2qV9l2HtlIDE3k3CJnWtJZGDzQGXRw7kQEdjvNk83gaOxNWNq0T4Zd09SFqXV0aaBLEOTI94+zILR3Y6XIbBbjiCGjTt+TY6Zz0APKW5zMfP+KpBgGgVNPEx15qhUmEgBh5OL5Ab/kyqRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPFF9B425E0D.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::5ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:45:45 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:45:45 +0000
Message-ID: <5c1e0366-1016-4cc0-9b86-888e8c5c2a31@efficios.com>
Date: Thu, 11 Sep 2025 10:45:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 28/36] rseq: Switch to fast path processing on exit to
 user
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <20250908212927.058801648@linutronix.de>
 <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
Content-Language: en-US
In-Reply-To: <84d9beb2-85e7-4fc0-b403-0514bd87ae8b@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPFF9B425E0D:EE_
X-MS-Office365-Filtering-Correlation-Id: b240421e-59c9-406f-92e5-08ddf141e37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0tCVDA5TUdwQVcvMnV0TGgzUVE0NG5EaXlMVGxBUDg2eG55OHBnL0FmMEIv?=
 =?utf-8?B?dDR2Q0RQR2tqTThFNGZCSlVPTmlQYStaQWQwWDdDZFdjcnVNM3FQTDdZaGdN?=
 =?utf-8?B?d1hYeEVoSWNCTVdabU8rMFIrWlpwU2JRWUpHYXppNWwzWkNORjJway9oRTJI?=
 =?utf-8?B?T0FITFpkZ2FKTjEvcGcydXl5QmJOR2ViK2kwanZCUFc1VEI1NmdGWGJSWVBs?=
 =?utf-8?B?amJadEhqODRwL1dJTTU3SldoeCs5Z3FGYTQrWURDTHlMOTAzTUp4WklOS2lq?=
 =?utf-8?B?anY2QWtEU3hTS2twU0Mrb0xkbGN4cmVhejZmd1lHRG9QT21jU2t6TU1oOXM2?=
 =?utf-8?B?RlVoWUdGckRQQ1dOWHJoSkZ4V25YeHpMUGpYSGc4TkllbEdHMk9RYUtUdGU1?=
 =?utf-8?B?aXNKNjZxbkYrTUxGcWNzcW40SWtmOEtVRStjbkxpQklZTUFFYzlnaVdmQXll?=
 =?utf-8?B?UFVvWVY0WWx5cnhVS3loc3B1ek5aem1iY2d4b2VBa1RXRndaQzBDTVdPT1BD?=
 =?utf-8?B?RVlVNTJMdFh4b0Y2dUw0Q2F6UjBCb0g0a0J5MjBjTjVFaFhVckVzNWwxMFVj?=
 =?utf-8?B?OVk1bVMzL2ZmOG55NXdOa2NvdnZ5R3BuM2tzWjBPY0ZjZHp2dWpxZlI4Rklh?=
 =?utf-8?B?SmJTbUtxVGdKYUd6djNldTBIazVBdEphOGowSEZZOFRnazROaHN3eDRWMHA2?=
 =?utf-8?B?SzhnSmJUVnllcFRpblFZU1JlNnFDSnc4ejdha2Zrc0xOcENiSjZ0cVZEaW50?=
 =?utf-8?B?K1JtMDhSR28xTEJIWmprZlFpSncxbmtySGRkZFBBeWtNWUJiL3V6ZVZrSmVI?=
 =?utf-8?B?S0l2ejhjRDB5L1lldW5vRXpLZ2UrSStyalQydDQ1c2VubzNNY3g1NWNyU2Jj?=
 =?utf-8?B?UnhYVG82aWVWYTZxY1MycC9tbzI4cG02M1VOTlZGUytFMERObkQ1UHRDaEM5?=
 =?utf-8?B?QTQ1aGREUVBjS3U0NTlNWGR1Y0svWUJtRms5VXQ0eFFNM1hyenRnRGsrSzlO?=
 =?utf-8?B?ZmlWWllER082UGJWUGs2QTZrYVM3R1M5YndSbzN5WHU0OVRiOEJBNlU3amRC?=
 =?utf-8?B?SFJLd09ZZUlLT1NxcW0zaWlucFlhbSsvMkhSZU5XUXA5YngyanlleG84NWcy?=
 =?utf-8?B?ZUtqY25uTGE2a0VpeXBnZTdWUEZxc0FBZzN2YXc2RGpUS2kxcDN3OFl6MzJp?=
 =?utf-8?B?aVd0ZUUzVU5weHJQck5uUWc3SVU3OEtRZndVZ0dvNFJFREsrbmFldjQ0dThr?=
 =?utf-8?B?QStkMUFmbzRPeXEzTTYvcHFXVGhnNzV5Tk5qOWw0MVpNZjI0MTIwTWRLNFBI?=
 =?utf-8?B?V1BvREtkNnlrQkNzRDY5SGhQOEg3NUhTQ1BDQWVqWE11UGxoeUZhRjBLcW1h?=
 =?utf-8?B?WUhUY083MmJ5d2tpV3ZvanEvSGc1RGNCMEcxTFdzQU5ScGQzS2NsTk5nakZv?=
 =?utf-8?B?eHU1dE1LeHMxWk9ieWNQU09LMEdEWVF1eVNtcDd1VVpoeUp3eWhtOEZ3NHRN?=
 =?utf-8?B?bWJNcVYwbkNqWDBOWTlUbnNpMWNRYzJEN2RSOCtSVDl2a1lZcFZXVDJkTVdF?=
 =?utf-8?B?M1lXNlRlcnI2dkVKdi9FVnB6S2ErV2FZVC85YWwweWlTQWZ5ZlNCQXhZQ3pE?=
 =?utf-8?B?MU9ZL29nYi93bDBZcno2azBxbis3K2hiL1BVckwyL1NMdFd3ZklyOVRZYzN0?=
 =?utf-8?B?WmE1SHEzV3NZVll2ODFlR3hKVU5qeWl0NzkrOXFLK2Q4eVFlVkNnaEJBWGpR?=
 =?utf-8?B?VVV5UmN0OFpnRGYzeVJBUHNlaTZ4K1ROYlRudHAzL0pFbThBY1M3YUVQRmlZ?=
 =?utf-8?Q?4dZlss/bMIIwUFFpsez8g1uY1tdgw6egDG9DE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WitBbGNCRDNmdkJMaXhnb0hxdlJIL0ZScCt6eGRNMGhXRHIvK1pMdnhIbGRt?=
 =?utf-8?B?blhzc0xRT2tJSUlXcy9aQVNMOFJ3VmtiSkZiaGJOSWRmalNiWkhNOVA4NmRO?=
 =?utf-8?B?YVZkeGdCY0FWcldpa2NMRnJSM00rQm9VaU8xRUlmVFdtMGc4cFRFQzJ2NUZB?=
 =?utf-8?B?dU4rTlhxWlZtdkxJeWZBTU03TmloOUpIQ3NHYkx2eVBOaW5KSmF5UE9xbGpP?=
 =?utf-8?B?WlR5bWx0TlJVZDlpQlVSQlNLRWdJYXNvK3hJcFNNcW5YdnQ0UlNTV05mWVZS?=
 =?utf-8?B?SlllY3BLeXEyTm8yTGg2b0gyNnBqd3FWTklQTzBNR29ndTFzeTBwZE01Tkxo?=
 =?utf-8?B?bmZ2d3lVb2NzS3l3S1c3OTFvOUsyNGMwY2pKUXNYVU5JSlhidU9NZElBUnpY?=
 =?utf-8?B?aHBwdVJuNW8yZkYxei9VSnFHNlJFTlpGYnlRaTlhY1dIRWNyNkZLQjh0cUR3?=
 =?utf-8?B?b0NvRzRSQ0d2U0syRXlVQ2pnYVI2N0Z1KzJ4QnJibDdoNFRRdEo3Qkt1UHV0?=
 =?utf-8?B?MDUwOVA1ZTJSanRTZnprVXJVakN3NVAzaTM2OWltcjRJUFVmTERwbGJVNWE2?=
 =?utf-8?B?dVFXZlRSN2ZQQXUwOEM0Nk11VTlzeDhmdWhOYVNQRXdhbklmbmowRlQ5SHRs?=
 =?utf-8?B?aGNNRFVTaG1ZRDZab3VGbXFzV0Y0QURCQlIrbElEbXp2TFkwR2hEelc2eHNp?=
 =?utf-8?B?YnJrdzVQVkN1cDFFdUdPV2NYWUY0UXlkUExJUjA4TVBsWUowQkNPMzBmK1Zk?=
 =?utf-8?B?VW1KaXpjMTEwUWZpbmlKbytyLzdoNlR4M2szcHk3Qmt6d1BIekpJVEtXODlQ?=
 =?utf-8?B?aTlUYVJwOUcrRWJ4Yy9Za2g2VW1TbUJ3NTVyckZLYk9TNlU0UG9BQ3JVL2RL?=
 =?utf-8?B?ZlV1OXdYRER4blhFbXI3Mlh4Wmo2eS9QS3kvcjA3dVM1anNDUGdrWVlzWE56?=
 =?utf-8?B?U0s1KzBlZUMrY3gzY3BDS05hOVMrZzJkTVlXUVA1aXFrR3JvSkg2NHQ5dFRy?=
 =?utf-8?B?dzRtdjRVbU9HVGd1UnNVeVU5ekdiT3FEcEtQRWlOU01MUkdkRGhRRldiUjc0?=
 =?utf-8?B?UFhYWWVZNVpTbzV4QXBZMnlkRjVxaVRWUUVEalJ4a0lsUnA2dldjUVN1NUtP?=
 =?utf-8?B?WFZBK3ZhRnBUY0x0bGY0eHRWY1FiRmhLVzAxS1lSZlN5Q01xdmZaMy9CSWJk?=
 =?utf-8?B?b1NtOHZ2aWwxOHhtVXIxby9XQ3lrWnZCSEZPMUN5SHIyakZrUWNZNFg0dkdz?=
 =?utf-8?B?akY0UjRFVFAvb3ErdnJkdU5nYUZBNVlnUmZFK3IwY0l2NHBCaDZGRitoa2Qy?=
 =?utf-8?B?LzgxRDQ0Q2Z6TW9oK2N1UHJQRWMzYlBqWmc3WVZpazIxclVYSXUySmRvT1pr?=
 =?utf-8?B?VkZSUDNxV1E0OGsxcHJ2UTJzSWZtazdNTjZhcmVER3VycmdMaWt0U3pGblNv?=
 =?utf-8?B?cEVWN2x6ZUR5Q0IxeGkyamRaaHFCOXE4a2dOYURUc3g4V2grVmFHZzdDWno4?=
 =?utf-8?B?S3d3VitKQTRCc0R2dFZrOTcxWXlEVlJGVHJXYmhxL3pLUEEycUswM3lmZ0Fz?=
 =?utf-8?B?M0Q3SHNYVDlRem9jSXhiN2ZLTVBsNll0c3VMRzNGNjF2SGpqVUlmSVd6b2Yr?=
 =?utf-8?B?eVc2dityalRvU0gxQm9BcEdpb0pUT3o2OTNkcEt0Smx5LzJWYm5JOUpjc0o3?=
 =?utf-8?B?akoxR21vWUlBcUJHUDRsNkI3NUx4WEtZWllvQ3NWYnlMYy9XZXUwNUNsTXo0?=
 =?utf-8?B?dE5QVm5LczFzRFJ4Vlh4SkIrOS83LzhmSTRxazZyc3R6dk8vSHkvNjZ4cG9u?=
 =?utf-8?B?US96Q3RFdzlDWDBEc2EvcFcrcGZ5U29aaUpySWljT2NrdkVNVktJbDVlZXdl?=
 =?utf-8?B?blphQzdBSzJrWTFDVTE5UzJuV3R0Y3J0dU9zajEwMlBwUmN2aU8zTVhaeGZM?=
 =?utf-8?B?V0o2cHE1ZlRJbEpITU94a1B6aXJxZXAxSWJmUk16RHZlK0dNdGhxYmEwTWh1?=
 =?utf-8?B?WVhwSGtPRE4rSjNyOTZTNFV6dFJ4UlZWRVd1SS9xTDhnbmNDUlB3ak4yL0Vq?=
 =?utf-8?B?UXhQV2RvRlU3MGxhUE1FaFpDQzdEbEgzTjdrY1JDT2Z5WFlQelNuSTFKMVli?=
 =?utf-8?B?VHpRcTJnSm55TlRFYzNwSWNsU2N4YTV4czNmTnN4TndaeXg4ak5qNlBHMnZW?=
 =?utf-8?Q?+2f+I42vJ1HrAH9HqhrRzzA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b240421e-59c9-406f-92e5-08ddf141e37e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:45:44.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3eRHR7oHyCENtALBuQZyAgrip7I2Yfe3oSkGwfFgD0GZ1Rq7ORAScGurVXqQwJ2Ww+U7YvoDS8J/VH/csX8oqVkroEzrshPciqRts4xJwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFF9B425E0D

On 2025-09-11 10:44, Mathieu Desnoyers wrote:
> On 2025-09-08 17:32, Thomas Gleixner wrote:
>> Now that all bits and pieces are in place, hook the RSEQ handling fast 
>> path
>> function into exit_to_user_mode_prepare() after the TIF work bits have 
>> been
>> handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
>> and the caller needs to take another turn through the TIF handling slow
>> path.
>>
>> This only works for architectures, which use the generic entry code.
> 
> Remove comma after "architectures"
> 
>> Architectures, who still have their own incomplete hacks are not 
>> supported
> 
> Remove comma after "Architectures"
> 
>> and won't be.
>>
>> This results in the following improvements:
>>
>>    Kernel build           Before          After              Reduction
>>
>>    exit to user         80692981          80514451
>>    signal checks:          32581               121           99%
>>    slowpath runs:        1201408   1.49%           198 0.00%      100%
>>    fastpath runs:                         675941 0.84%       N/A
>>    id updates:           1233989   1.53%         50541 0.06%       96%
>>    cs checks:            1125366   1.39%             0 0.00%      100%
>>      cs cleared:         1125366      100%     0            100%
>>      cs fixup:                 0        0%     0
>>
>>    RSEQ selftests      Before          After              Reduction
>>
>>    exit to user:       386281778          387373750
>>    signal checks:       35661203                  0           100%
>>    slowpath runs:      140542396 36.38%            100  0.00%    100%
>>    fastpath runs:                         9509789  2.51%     N/A
>>    id updates:         176203599 45.62%        9087994  2.35%     95%
>>    cs checks:          175587856 45.46%        4728394  1.22%     98%
>>      cs cleared:       172359544   98.16%    1319307   27.90%   99%
>>      cs fixup:           3228312    1.84%    3409087   72.10%
>>
>> The 'cs cleared' and 'cs fixup' percentanges are not relative to the exit
> 
> percentages
> 
>> to user invocations, they are relative to the actual 'cs check'
>> invocations.
>>
>> While some of this could have been avoided in the original code, like the
>> obvious clearing of CS when it's already clear, the main problem of going
>> through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
>> notify handler is invoked more than once before going out to user
>> space. Doing this once when everything has stabilized is the only 
>> solution
>> to avoid this.
>>
>> The initial attempt to completely decouple it from the TIF work turned 
>> out
>> to be suboptimal for workloads, which do a lot of quick and short system
>> calls. Even if the fast path decision is only 4 instructions (including a
>> conditional branch), this adds up quickly and becomes measurable when the
>> rate for actually having to handle rseq is in the low single digit
>> percentage range of user/kernel transitions.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>> V4: Move the rseq handling into a separate loop to avoid gotos later on
>> ---
>>   include/linux/irq-entry-common.h |    7 ++-----
>>   include/linux/resume_user_mode.h |    2 +-
>>   include/linux/rseq.h             |   23 +++++++++++++++++------
>>   init/Kconfig                     |    2 +-
>>   kernel/entry/common.c            |   26 +++++++++++++++++++-------
>>   kernel/rseq.c                    |    8 ++++++--
>>   6 files changed, 46 insertions(+), 22 deletions(-)
>>
>> --- a/include/linux/irq-entry-common.h
>> +++ b/include/linux/irq-entry-common.h
>> @@ -197,11 +197,8 @@ static __always_inline void arch_exit_to
>>    */
>>   void arch_do_signal_or_restart(struct pt_regs *regs);
>> -/**
>> - * exit_to_user_mode_loop - do any pending work before leaving to 
>> user space
>> - */
>> -unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>> -                     unsigned long ti_work);
>> +/* Handle pending TIF work */
>> +unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned 
>> long ti_work);
>>   /**
>>    * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if 
>> required
>> --- a/include/linux/resume_user_mode.h
>> +++ b/include/linux/resume_user_mode.h
>> @@ -59,7 +59,7 @@ static inline void resume_user_mode_work
>>       mem_cgroup_handle_over_high(GFP_KERNEL);
>>       blkcg_maybe_throttle_current();
>> -    rseq_handle_notify_resume(regs);
>> +    rseq_handle_slowpath(regs);
>>   }
>>   #endif /* LINUX_RESUME_USER_MODE_H */
>> --- a/include/linux/rseq.h
>> +++ b/include/linux/rseq.h
>> @@ -5,13 +5,19 @@
>>   #ifdef CONFIG_RSEQ
>>   #include <linux/sched.h>
>> -void __rseq_handle_notify_resume(struct pt_regs *regs);
>> +void __rseq_handle_slowpath(struct pt_regs *regs);
>> -static inline void rseq_handle_notify_resume(struct pt_regs *regs)
>> +/* Invoked from resume_user_mode_work() */
>> +static inline void rseq_handle_slowpath(struct pt_regs *regs)
>>   {
>> -    /* '&' is intentional to spare one conditional branch */
>> -    if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
>> -        __rseq_handle_notify_resume(regs);
>> +    if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
>> +        if (current->rseq.event.slowpath)
>> +            __rseq_handle_slowpath(regs);
>> +    } else {
>> +        /* '&' is intentional to spare one conditional branch */
>> +        if (current->rseq.event.sched_switch & current- 
>> >rseq.event.has_rseq)
> 
> Ref. to earlier comment about has_rseq check perhaps redundant.
> 
>> +            __rseq_handle_slowpath(regs);
>> +    }
>>   }
>>   void __rseq_signal_deliver(int sig, struct pt_regs *regs);
>> @@ -142,11 +148,16 @@ static inline void rseq_fork(struct task
>>       } else {
>>           t->rseq = current->rseq;
>>           t->rseq.ids.cpu_cid = ~0ULL;
> 
> As discussed earlier, do we really want to clear cpu_cid here, or
> copy from parent ? If we keep the parent's cached values, I suspect
> we can skip the page fault on return from fork in many cases.
> 
>> +        /*
>> +         * If it has rseq, force it into the slow path right away
>> +         * because it is guaranteed to fault.
>> +         */
>> +        t->rseq.event.slowpath = t->rseq.event.has_rseq;
> 
> I think we can do better here. It's only guaranteed to fault if:
> 
> - has_rseq is set, AND
>    - cpu or cid has changed compared to the cached value OR
>    - rseq_cs user pointer is non-NULL.
> 
> Otherwise we should be able to handle the return from fork from the fast
> path just with loads from the rseq area, or am I missing something ?
> 
> Thanks,
> 
> Mathieu
> 

Just making sure you don't miss one additional comment below...

>>       }
>>   }
>>   #else /* CONFIG_RSEQ */
>> -static inline void rseq_handle_notify_resume(struct ksignal *ksig, 
>> struct pt_regs *regs) { }
>> +static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
>>   static inline void rseq_signal_deliver(struct ksignal *ksig, struct 
>> pt_regs *regs) { }
>>   static inline void rseq_sched_switch_event(struct task_struct *t) { }
>>   static inline void rseq_sched_set_task_cpu(struct task_struct *t, 
>> unsigned int cpu) { }
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1911,7 +1911,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>>   config DEBUG_RSEQ
>>       default n
>>       bool "Enable debugging of rseq() system call" if EXPERT
>> -    depends on RSEQ && DEBUG_KERNEL
>> +    depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
> 
> I'm confused about this hunk. Perhaps this belongs to a different
> commit ?

^ here.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
>>       select RSEQ_DEBUG_DEFAULT_ENABLE
>>       help
>>         Enable extra debugging checks for the rseq system call.
>> --- a/kernel/entry/common.c
>> +++ b/kernel/entry/common.c
>> @@ -11,13 +11,8 @@
>>   /* Workaround to allow gradual conversion of architecture code */
>>   void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
>> -/**
>> - * exit_to_user_mode_loop - do any pending work before leaving to 
>> user space
>> - * @regs:    Pointer to pt_regs on entry stack
>> - * @ti_work:    TIF work flags as read by the caller
>> - */
>> -__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs 
>> *regs,
>> -                             unsigned long ti_work)
>> +static __always_inline unsigned long __exit_to_user_mode_loop(struct 
>> pt_regs *regs,
>> +                                  unsigned long ti_work)
>>   {
>>       /*
>>        * Before returning to user space ensure that all pending work
>> @@ -62,6 +57,23 @@ void __weak arch_do_signal_or_restart(st
>>       return ti_work;
>>   }
>> +/**
>> + * exit_to_user_mode_loop - do any pending work before leaving to 
>> user space
>> + * @regs:    Pointer to pt_regs on entry stack
>> + * @ti_work:    TIF work flags as read by the caller
>> + */
>> +__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs 
>> *regs,
>> +                             unsigned long ti_work)
>> +{
>> +    for (;;) {
>> +        ti_work = __exit_to_user_mode_loop(regs, ti_work);
>> +
>> +        if (likely(!rseq_exit_to_user_mode_restart(regs)))
>> +            return ti_work;
>> +        ti_work = read_thread_flags();
>> +    }
>> +}
>> +
>>   noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>>   {
>>       irqentry_state_t ret = {
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -234,7 +234,11 @@ static bool rseq_handle_cs(struct task_s
>>   static void rseq_slowpath_update_usr(struct pt_regs *regs)
>>   {
>> -    /* Preserve rseq state and user_irq state for exit to user */
>> +    /*
>> +     * Preserve rseq state and user_irq state. The generic entry code
>> +     * clears user_irq on the way out, the non-generic entry
>> +     * architectures are not having user_irq.
>> +     */
>>       const struct rseq_event evt_mask = { .has_rseq = true, .user_irq 
>> = true, };
>>       struct task_struct *t = current;
>>       struct rseq_ids ids;
>> @@ -286,7 +290,7 @@ static void rseq_slowpath_update_usr(str
>>       }
>>   }
>> -void __rseq_handle_notify_resume(struct pt_regs *regs)
>> +void __rseq_handle_slowpath(struct pt_regs *regs)
>>   {
>>       /*
>>        * If invoked from hypervisors before entering the guest via
>>
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

