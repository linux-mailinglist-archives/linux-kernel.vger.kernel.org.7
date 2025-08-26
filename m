Return-Path: <linux-kernel+bounces-786805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960FB36AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0E6581F90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408D350D67;
	Tue, 26 Aug 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XfptoP6b"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2118.outbound.protection.outlook.com [40.107.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA672F83BA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218493; cv=fail; b=s4G5a+OOqKBBFeWTPy+jqfnjyf89bNWlVAqfXq3LOT73aS2Whw0GeHlcJiB4bPN+NoX+tfRxfSePMwkEyjCRlstPLMTojGKrq8QGuldnjdy4gsQkIONWqPLgY3iMjffrLcgWOAA6BobZ7bWlCtbbqbJAIBQIOb6bD+D+Z/Ak3ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218493; c=relaxed/simple;
	bh=7tzeu1K52+hsk/arYw9ztGb6VprHkEH/ne5gE1jp+aE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kvH+BKrJb2/AKxXXpJNR8wW6h1zDzgUDyjhFwEPgfomZd6PL5KsQJYD6Wtch8WLUeeGlfrwpJpUaR+jULczDkHznb0mSp7hsfz98eltn7POM+1F3D1+jSJQy0JnuSxnu88iPSttMoyagTs7LC9d2C+7DnCSxCsNivKdWBUFMsyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XfptoP6b; arc=fail smtp.client-ip=40.107.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb4p/DlfjiT0klEtyfG7TIqKXgl9HgcckPCuVzNjrISbTIAH3McwPEXlPM3UWcPpVl8ITCIiaHOOBICIT+mYfpWzBwc3CUNwsS6Bczz4w15lZuc2JMtKmqIbtlRXj1txhD5NUzrhdZW/iaNA2crLrSlM+sgjYj9uUsyHsBiji67p6OfhfPHQaejqH6jcrUCDlnq0Hbf6BnUEJbxciS6AepiMgPzDcIbM3EJVSVxXmXb3ecD3Qwby2Yiu5BCw8AV2tsgA4zAhMlaWSf6llzpt6eUkeAzLQCy2voN31hUpuPnacXrNYvXv4WthmcI2mZCLSgoSsnjDm4+35LS5dcwBGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wiONffBqu+h9A1GIVoKcxZdUFdMiJ+kAFC/jxuEkTg=;
 b=OmAKbMClbnWFjQbwXNtd3nx42ekJtHbQikEZL8bX+PU53JAFAGLeyeyviwxIZDlIJx4DvWM5vOHCu1bD2Gf03XctSeuZnp2tZwcdHgr6oEygcvE4lkn1OAO6z+Kila/DJqvp6PtzeE1sH5Y3iaDloqILM++KvCZS6HnrD+0JpCQarpjbKargtSA4vA2NEOjs0Iexux20dxxIL76uMA+bOjU1xKRhloJXa7GLpXqxGqPE/be24JrBPEkJ/6webXvC9t3RC/4+Uural15/eeK9T8EYsq8XI/dUSP+b12Od3Hz+h5O4Cnf0MklaIib8ogGsBQI2szhNmvbq0XewfMhF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wiONffBqu+h9A1GIVoKcxZdUFdMiJ+kAFC/jxuEkTg=;
 b=XfptoP6be+TXk5imt3ufv1wlDJ01jDGnSyH8CWJzUPjWqp68agxLMQaQv1vUIMw1ltAJets+cqjKzg3bxqbIr33Sm21wWfiDfAukJlAMweQ67EpOkGbQ+l7oKpf0Rljnfnmdg/bYhsz2fSxumENsuZdD99My9wrCDXLjTbe2ZReD9uSEm9o59dhv9HGkZdRmewO/p1tadfnieeHE4qpQ4thhgzZkIQCOfvseqZA9FJsdW9boAtaSQXH4ptmkHjwA06ZPeWUhTO9sInMJ3i3opwYvevIVkA4J8jdeFrTS5Hm1ALVtjAUlIBxtI4K0YfwhAN+JxP10YKDToBNw6Ud0nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF2616F21D7.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::515) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 14:28:07 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 14:28:06 +0000
Message-ID: <e63dd2e6-ade5-4032-b9ce-51e97d1c2a0f@efficios.com>
Date: Tue, 26 Aug 2025 10:28:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V2 22/37] rseq: Use static branch for syscall exit debug
 when GENERIC_IRQ_ENTRY=y
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
 <20250823161654.677961303@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250823161654.677961303@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0096.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF2616F21D7:EE_
X-MS-Office365-Filtering-Correlation-Id: 93ca66b2-de52-41e2-8d65-08dde4acc5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZFeUluMWVLZFhqUU9JcTQzSy9GbHpXWnhHcVhHWjJvQTBPd3BwOVlpM1dm?=
 =?utf-8?B?TG8rLzdpSk9zS29zUy82SFVUb3ZadmU1SDZkSlduT2ErQmIwN1FqWVVZampO?=
 =?utf-8?B?Y3h3NjRNZXBJM2JQTTBPbm9TZlFPd1pGd1dhWjNmWnZNZm12MzlmV1VwTTVw?=
 =?utf-8?B?SUQrajlXcmtnQ2tKNUxma2NWRTA3amNLMDg1M2tUZmxHOCtvK0tDTGFPbXFH?=
 =?utf-8?B?UlhGRk5GQ2pEZExkcHoxYVB2bVFyd2R5QnJKdm96VjFrNUpoWGxmTTRqVjFn?=
 =?utf-8?B?c2JtZlFqekV3S0lyd2ZNMTFXNFNMWUh6NDBjbksyeGZpNWxCc1pnZUg2bTlx?=
 =?utf-8?B?ZlErcFZibGZrYXdrSTZsRUYzcTMxUkp5Smk3L3VmelhSTnFTNFZVd0NnaXNt?=
 =?utf-8?B?R1B5UlhYdndaMEVHWGwwWXlTVGg0OTI3R1NQdThicmNlbUk2MXA5emlqRm40?=
 =?utf-8?B?azJYUFp5Uy9RMm4rNkd0L3Jidk9ISkFiUGs4bE51SzNsZ0VaS2JSaGtOMEIy?=
 =?utf-8?B?REJsejRyMzlKaXRYbUE2eDUyODdoNEpUbWVma1c0OTZxcEVsbFlyOEJCVkl2?=
 =?utf-8?B?V05XMnlSYkE0T0tCNHRIdnY0UXVWT015MVJaaU9JSU5xQ2xXSksrcVg0RGVH?=
 =?utf-8?B?a1prQU9TbEZGOU9HaTliYWRNcmRIYXRNS1ZFbHYyNDFScHAyVGdSRmhzZncv?=
 =?utf-8?B?MWlsTUxiVUI1Z0l1R3lPQXNjRWgvYUZRWElkbkhYUDFKUWc2YURqRkw0cFpx?=
 =?utf-8?B?UzRXL0FYTGhnYXV3L2JkWjhORnBhb1U5WExpRytYWXJUZUVQOFJkb3BIKzV1?=
 =?utf-8?B?SU5JTm9UR2c0WndRcG9DeTc5MXZmWkVzNkxyWU56bDJoT1ZMako5VVBjTHli?=
 =?utf-8?B?bHZsN0gwaDBkYjM3UXUySWVFV0R4ZjVFeDlMVXVmLzZlM21ucDlZL2V0Qkx0?=
 =?utf-8?B?OS9vdk5JQzFYWThXTVoxbXU4bHpzRVBaRWNCeXFBM0lnMEZqWUtiUVNpNC8v?=
 =?utf-8?B?M2VIbUo2SzR6N0N2TTJGTlBtOTZXVDJaelg4dVE4aEhtcHJGU3dienhJTFAz?=
 =?utf-8?B?SzArcDl4c240MEk4UTFkaHZOdW9LS0N6WVlobk5sRk5WZTk1SWhsN2ZCRUt6?=
 =?utf-8?B?bjVQTVpIVDhManhrK3RFOFNRc05McmdBZ05hSThmL2VYdUY2NU9tYWY5QU9x?=
 =?utf-8?B?akgweXZkNUl6dE4ydmJHc2REYVZuRlE5QlBrWFFWaXFsYkRFTUtqYzE2Rkk5?=
 =?utf-8?B?bDBwUnAxZVhxZnkwUUwyc2xId0tvSTJWeG5zL294aTdmK0pYTGxiU2x1RGR4?=
 =?utf-8?B?dCs5Z1U1MjRHeFFnT3RvbXRVeDc1b2piczJRMnBCTUM1YXRLSjR6V0hsc3VS?=
 =?utf-8?B?aXU5WmhHZG1zZmV1L21HdjBCb3JRbCsySWR5dk9vTExxNGNYckM0NVVScGdW?=
 =?utf-8?B?NkFxeFByTjM4VVlPWFVlc2FSRTcrNUR6OXlyQ2FxbHlnc3dNNTcvck9pQnJN?=
 =?utf-8?B?RTlSR3NMaGRUR09PQ05nR3I3ZjgwK05OaktRQjdZSURxNU5RcGN1VzJDT0VW?=
 =?utf-8?B?L2RGbjZTS2R4MlhZUDhpdnVtSzk5RFZrdEJoUGp2WVJ1Q29zTHVmK29yU0VZ?=
 =?utf-8?B?Q0tzSnh4ekh5bHBYNkNPR3JaNmIyQ3dlNWZ4dlFTZnZRdnBwYzFBNk9mQXVY?=
 =?utf-8?B?L0lXbHArZ1ltdDJvM3lYTEpBOXJMUUdRaWNmcXFWUHVFYWUrYmdsNVp6VG5n?=
 =?utf-8?B?ditCMWVTR3Vvc3ZvSXBxWmVlODc4WkVMckppb1dic1oyYTYrbW00UEVKdXlo?=
 =?utf-8?Q?8Pwueq1O9u7MPblabka9ZDgLTnb/FaD66NDSo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VThyWHdLdElTY0VrY1ViVnFNUzVGNklDaEN1YUZpRVlnckUwYURqbndpUzl5?=
 =?utf-8?B?eUVmVWxyTVBTOVNGNnluUld0TTNrcnhaa2plTGVKRjJ5SWZQZUY3QU5uOGFr?=
 =?utf-8?B?Nk5jem9OeDZTQXpSMS9KaHRYWUF4a3pTZEFYS01zUkl4dng2RzRlRWJkOUU5?=
 =?utf-8?B?cjZFU3ZGOE82S1AxSnpId0xOWFNzeThnS0paZXpCNTdzQUJpUnlHdTMxUm5E?=
 =?utf-8?B?SlJjcW1OaE9FYlUyaTZJRUFPakwzU3pVUHZXdEUzYi9XLzdWdExTaG9Xc0o1?=
 =?utf-8?B?dWJvZmRsWWdSdjlkcUF0QVpTcEw1czl5cVVtenY2Rm9QSVNkbldmalhSTVFM?=
 =?utf-8?B?VDN3enBmWGM5OUM0WVB2UEdlUmZBdzRmd05uQlh3UkNYZWN0K2o5MDBjQ0tw?=
 =?utf-8?B?a2FhVkcxUnZsUTBLbUt0dmpUSkZUdENGemJuTElOV2pkRFd6MWFhajVtTFRG?=
 =?utf-8?B?ZzhJM3BoaFhhYXBzVVE1cmFJc3hWY3h1V3VWVjFWWW1PdFVEZTdEUkNuL0t1?=
 =?utf-8?B?eGNQN3ZmS2c2MTY3Q09xN2FyYWNRM2FBMVAvcGFXRnpvb0VNRE15dUduSjhP?=
 =?utf-8?B?ZjJGWkhQVGwxaG1IQ2NxMWdqQnRWU2orWFErL00veTlRYTRoaFo1MEFlb3dD?=
 =?utf-8?B?WGpEQ1I2RWQwdHQzRENzbHQ3ZHc0a1pGWS9IQm8zRi9pYUFmb2JIY1M1Qnpa?=
 =?utf-8?B?N1dVMWUxRTNYVGViRVY5VFJlVURRV0xOb1RCd1U2K2hQdkRDWng2UXlPemV6?=
 =?utf-8?B?Qzg0d2FOeExBUWhwSEsvNlgxdlBRSFlXbC9wWkNSTGFlTTM1S0JJK01PSXA5?=
 =?utf-8?B?bWFnUUlmMnRsKzVCRmtXY2FqMUhjTGozaHFxQUgwTG5vWE1UNk5MeWU4UFc5?=
 =?utf-8?B?bytLV3MybVRNN3o0M1pFVWVGSjZUS05RWmRwVGxCSjRYZTd5aGZFa3lyZFh6?=
 =?utf-8?B?Um9WQ1plRXlmVFErSWoyRW1CZytzVzBWTko3MUlvN3lYT3dyTWFJZTlkQ1Jr?=
 =?utf-8?B?cktFSTF6UWc2QzNmTjg0L3VBVytqWlhmWHF3dmd1N0lvc3Uvb3RHelRsOTVl?=
 =?utf-8?B?bksrNHVPbUFCc25CRDlBRTUxM29Vb2pudFgyS1BpMTh6QzllK0RUMnF2Rmln?=
 =?utf-8?B?L00rMmF5YkhjUWtyb1NBNCtzcEtyZnhsNlBGYXYySUFaUzhDcU5iSWI5NDd0?=
 =?utf-8?B?NWUxWXNQajhqZm1keFVoRmIyNDJCSWZxUXlGYWNNcVFSSjYzdGdIWkpTNUpK?=
 =?utf-8?B?Mk8vZENxU2hiTGliMlU0dVRWcVdmeEZmTjJwbG5xTE96cVc0b0ZiazRBdWkx?=
 =?utf-8?B?L3BRM1pCVVlTZHAvZUdyc05INXhmaGNJMzZxZ1VFdEJqRDl4MmZkUjZzRjBZ?=
 =?utf-8?B?aFM2cXoweEVhS24wck9nc2NuVU0zQXJ3dWlUOGZQcjJKeHlnUk0wR1oxUDRF?=
 =?utf-8?B?bDYvblZyMDg0RHVEMXJ6RW1VRjQ3dFZJbWJjejVQWmI1SmNLMy9FZEN5MmxJ?=
 =?utf-8?B?NXdOSzN5OFp6T2lXVW1MS3VYRTQ1Y3EwbHlyQ1BRanVGdktVZGkrSGdESlla?=
 =?utf-8?B?SkJCeUZwekRXNTRXYUdFditZbWxNSDhtZG1PNkR4UFZKMkFleFJLRUJlZDR2?=
 =?utf-8?B?VXZjZlJGWVFPUGhQb2VGN1lqczhqZHFqQWhyVGU2ZVNNN2lJS0pDdWJFUmR0?=
 =?utf-8?B?djB4Y054SDM4cmdFUVFwTXAvYldNcFlMMjE4RllRenhJbTNMeXJreWkwY1ZV?=
 =?utf-8?B?bUF5U2I5QmRSSnFHUnRRZXVuQ2oxaER6OUFBUWZLSXNpVFJhSHFqK2FWdTEy?=
 =?utf-8?B?WDFOZVlWWGV0Ly9DeHVNbU9tL1d2MXFrNHFhcUpNa2l4dDZZUiszUWJxQ1Z5?=
 =?utf-8?B?aFVHQ0FGOGV3b2xRNGRzUUJkTmhlVjA5NW0xMEwxc0Y4TWZoYjlsUW11SzBF?=
 =?utf-8?B?VFZQNXpvODhDbVR4czlRcFY0K1JBMVc3MFMybDk5YTVtNysveWNnTk5GL3Ji?=
 =?utf-8?B?cHAwUWpkOUxxYUNsTkdPYThRWmFXZVJWWUZqVWFOUm5pMTlGNEZMcUE2Zmts?=
 =?utf-8?B?WXIxeWpJUzJ5dklnTjFHSVlPQmFxMGdyeHJhZ3dJK0F3ZHF0MklrZUIySHps?=
 =?utf-8?B?bDFkUVE2MEZNMkZNWkxFY1F0azJtbGdGMHU1ckZzNUcvMVZublBkSTlwSWFt?=
 =?utf-8?Q?+SeYl92vCaD5f8zXT3ZEiYE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ca66b2-de52-41e2-8d65-08dde4acc5d0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:28:06.2226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q28sCyl8so3YvlkFe/9DyW/e45bgoF9eRYk7u9sMerSJBApS28m7csMbXjzxsuv60pmBCVrZVSg4AnEAluQHNSinP9T6fDp3WwsZsy2Q48s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF2616F21D7

On 2025-08-23 12:40, Thomas Gleixner wrote:
> Make the syscall exit debug mechanism available via the static branch on
> architectures which utilize the generic entry code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>   include/linux/entry-common.h |    2 +-
>   include/linux/rseq_entry.h   |    9 +++++++++
>   kernel/rseq.c                |   19 +++++++++++++------
>   3 files changed, 23 insertions(+), 7 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -146,7 +146,7 @@ static __always_inline void syscall_exit
>   			local_irq_enable();
>   	}
>   
> -	rseq_syscall(regs);
> +	rseq_debug_syscall_return(regs);
>   
>   	/*
>   	 * Do one-time syscall specific work. If these work items are
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -286,9 +286,18 @@ static __always_inline void rseq_exit_to
>   	ev->events = 0;
>   }
>   
> +void __rseq_debug_syscall_return(struct pt_regs *regs);
> +
> +static inline void rseq_debug_syscall_return(struct pt_regs *regs)
> +{
> +	if (static_branch_unlikely(&rseq_debug_enabled))
> +		__rseq_debug_syscall_return(regs);
> +}
> +
>   #else /* CONFIG_RSEQ */
>   static inline void rseq_note_user_irq_entry(void) { }
>   static inline void rseq_exit_to_user_mode(void) { }
> +static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
>   #endif /* !CONFIG_RSEQ */
>   
>   #endif /* _LINUX_RSEQ_ENTRY_H */
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -470,12 +470,7 @@ void __rseq_handle_notify_resume(struct
>   	force_sigsegv(sig);
>   }
>   
> -#ifdef CONFIG_DEBUG_RSEQ
> -/*
> - * Terminate the process if a syscall is issued within a restartable
> - * sequence.
> - */
> -void rseq_syscall(struct pt_regs *regs)
> +void __rseq_debug_syscall_return(struct pt_regs *regs)
>   {
>   	struct task_struct *t = current;
>   	u64 csaddr;
> @@ -493,6 +488,18 @@ void rseq_syscall(struct pt_regs *regs)
>   fail:
>   	force_sig(SIGSEGV);
>   }
> +
> +#ifdef CONFIG_DEBUG_RSEQ
> +/*
> + * Kept around to keep GENERIC_ENTRY=n architectures supported.
> + *
> + * Terminate the process if a syscall is issued within a restartable
> + * sequence.
> + */
> +void rseq_syscall(struct pt_regs *regs)
> +{
> +	__rseq_debug_syscall_return(regs);
> +}
>   #endif
>   
>   /*
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

