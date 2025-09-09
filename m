Return-Path: <linux-kernel+bounces-808243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F5FB4FCBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E961C60163
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59C340D9B;
	Tue,  9 Sep 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="I2gYnTV/"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021087.outbound.protection.outlook.com [40.107.192.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566422D1F4A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424357; cv=fail; b=aDfbgPZa7fDTiwYW44rCqKumtqGTdwrUN/AV2A1uIN6YeG6coNqbYp2wkxdheFSiz8q9K1MxrMbcdVEmaDm08AuW3VIsz2jcsRQvFD71+a9GIsfixycwPgTmDUKohtHewdHvU0AHzo73lOrRoQn28FqYCEbEmnvGTelEuhhQP5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424357; c=relaxed/simple;
	bh=psYrv1P8PO+Q5vyFSrGJ/kax984PNsJNM0apgWRngAM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNm8MgCMsfTWPvtyG8QimYfYzCl/tV+Vq/uyLC+KxPxoHJc/mA6AUeiEE2eleFyTBLiqaUNUQki6N2NUbaP9oB5b2XwEhDsjFkqJ964TD8Xp0hPSrXihWp1pBzwmp9n65R4AWF355OMaVUitN4oE6X/0WmLGyHU4KR90ZBV4SoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=I2gYnTV/; arc=fail smtp.client-ip=40.107.192.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7iZC0nJMyRDoZwbDML1KHgA+JFkOn2yW7XrYFZz5kpgVCsSyaj/2cDyztonrUbq9N35200C1L/+jJdTzQljw6vaJQICkIdMWzw7s8XWdMTX/7apU5rfKMCj1wOeseN3EdS1NAisO6lIV3m65ekq+zHyQPrFRK9ZoHy/ervhvXouvqlWjhv9WJzXc0wU5C6pDQREIDjYzTnvHJR/P04sZy2LCv/xNbPlP539AiT0owvd/G7nmCFWMpjlzuMKsUzOiDaKbLQxaWfYzVA74heB7ac7pFIWWJZmX5UcJK5t0aUMfsUcYGnQM4O+prIT6IYLc7qnPFcpU5VfK3jYi5ZAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTXchuw9m9wDElN123BLgtuwBEHWM7jA0lJvXznNuq8=;
 b=tVj/+i3yMce0maDVvyS5t7KBBpRYVUC7bkXEQlOoiMhGYCTKoTaHQtr17gYTH/aG7FZjEr6Ae7/Cd7kcNrmtMUJiFvAgve0HhsTktFIOoTwMr0TYaDKoYP43hKKN6JlhHx0LLUGteKbcORXHw7o2Hc0bXTZ/M03KJGrAKCwk9vI9uz7G3EucB9BHRAMOOyhfawTpJY6gt9FQTmfuo6bvLOc9YWSFnrzpYFCw0K6wsi+px25aAapusQf4TpABbCzjjifK4ZcM6Sr/6dkvXToWVUKSQeHPpZAkrKTKeuMON2qAG+VCz89ZUPw19MIjYFbhjCas3+hnpoioZkVPPj4VEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTXchuw9m9wDElN123BLgtuwBEHWM7jA0lJvXznNuq8=;
 b=I2gYnTV/Rd8w8fAoTyW6ZBN1hR8BUpfldDUa4gqqUcVjcbE5kSk7SjcClUJlThWSyl2QSz09r+f6O5UY+9NY51BPIhbAFSYq0t7N6edFClv8Lz77JJyoRzJwltnIWbUzG9vC9MXBzD2m4NoRxaSJRR4r+9ejT8OZIvvmjl+I3PWvpLW7i1O/tQzpZG6/2zxBZJH6gBQ8lbPrNebHOZtJ6z9cTT30SIg9eF8J27qr1Y+n6GUvVABWE2aiqBlT6P/1o64Nn7QGMw/j/EopOeWhyWsOpy6jivxzJ4Tv9kCABp346lOsBSru5fa1TujVjh1UL+KJS7KzOafG/FSjvRmiMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8830.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:59::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 13:25:49 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 13:25:49 +0000
Message-ID: <b69916d8-8e16-40d6-a0e3-ce6793513a07@efficios.com>
Date: Tue, 9 Sep 2025 09:25:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 08/36] rseq: Avoid CPU/MM CID updates when no event
 pending
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
 <20250908212925.775679381@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212925.775679381@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0166.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: 116aca78-d566-4cf3-fd8d-08ddefa46447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWVFdWI3eTlyNVJIU2ZudW14b3Y0amloallzN1BoaFNLOW9YZlBQdFRvbnJ4?=
 =?utf-8?B?M2xZendBaGJqbXBLRzhrbVFReHFoOFMwRjlyczdwZHY5cC8vYkRHWkFWZktI?=
 =?utf-8?B?d2lYNzJtYjZ2YnluK1VLejNBQ1E0SGo0WXlIaTEyNTlleVlSTkVlYzdGdEJE?=
 =?utf-8?B?VGJCSDRzUGJEdHp4ZVRaVjhWTll2UmNPVk1Xc016VW9ZWEhFR0haSTJxcmQ5?=
 =?utf-8?B?YjFEZnU5Z2JtMEd4MVVxSGJGU0hnZElkM1p5RFpHYWtkenBqb3FzdEo3Vmxs?=
 =?utf-8?B?ODNOc2o0V2FCNW9VcWFUYWcrdEk0bXBxYUVjUGpMYmlCTW5LVHVYQ2hFUklB?=
 =?utf-8?B?ajdxRGRWM1E5YlBOWXhvWWhWbFdoN25XN1FFNlNTSEpEeXNBVGRQQitPcUhS?=
 =?utf-8?B?WEhXbVZKSFZJOTRUL2dNamFnY3czeG9XSy9aeXpTMGNYMi9nS1pvVGtCZXNz?=
 =?utf-8?B?SEJUNExaRUV4aHRoSG8rWjdDdnhydjNXaktQcjFDSVVwTm1KTjVKUC8rcW5E?=
 =?utf-8?B?cWVkWGhDWFpSSGJiYjBmZGNlRm9oTUwrV3M0K3FHdTJ1cmNoOC9LVk9NSjAy?=
 =?utf-8?B?MzYxMUY1czVncWV6d0xISk1UTHdCM29iUWMrTERDK0d5bVNOZk05QXNtSXR5?=
 =?utf-8?B?TFlWQ1lpLzdsQTI1SGNmZE5wb2NwN3ZEVjNWRHliK1FpMzVyalp1cytyb2tO?=
 =?utf-8?B?L2Z0QnRKRkM0dFJGWEhOcTZvdjFjeWNaTXRyQjRZWXZnTVhzNWRBMWtqUWJx?=
 =?utf-8?B?aG5EYVVpcjJsVjVsS20yRVUzaDlscHB4SWtIT2trWlczSkJ1UGp5WE54OXN2?=
 =?utf-8?B?bzYxMXJwMzlTM24za0JZODg5aEhLRXhBbFdxcVg1MHNwOGNTbUJJWTdVQjhH?=
 =?utf-8?B?TDBlTlViQjZQZW4weFAyZ3Q5ZklCcWJQc1pnMWtsdWh2UFdSdlpEYVRUUWMx?=
 =?utf-8?B?bzVKVjV1RGF6Rngvb0pjR3V3QlZRVHVIVWU0bllqYUM0SUxOVWEyNTc5U2dY?=
 =?utf-8?B?OHF1MXJKWDlsWTVHQmZseERvb2pPUnJDZFVEbG5tVTNsWVFLY1JRVnozREtW?=
 =?utf-8?B?UVBhZkpiNFZVWmtleC8rKzBXN1JJL1RSUTU0UEJUaXltVDY1SDNrSXN4YjNT?=
 =?utf-8?B?aEZ0WXB6VkhneXN4TUdhOGIwOTQ3M3pvUlQ0MjEzQWZnc2kyWDhNd0NwdU5Y?=
 =?utf-8?B?cGdRSm9LTVZ0R01SSXpGMWJJamIycGhqelB6d2E1ak9jOHRudDA3cDhSSU5O?=
 =?utf-8?B?bm1BOWpMc2JDYmlWVllHLzdqL01GRWFCSjJuaXdod2hNR2x1OHRaNlFheEF1?=
 =?utf-8?B?SWp0bXZ3MjZ2RkxaNENVSnQ4ZVU0QnNLQTJCMHJEeGlYNEVhMUNYMkJXWWFI?=
 =?utf-8?B?OW9nMFY2VFhkcUJaMkJrYW03OU5iMmtRamN2VDM3RGdQU0IrQk5paFJhVENH?=
 =?utf-8?B?bUM0aENZQkMyUmdPMVFIRDk1Q1ZmNzYrdGNGK3VUZjZTVm1Bb2NaY3JmK3hL?=
 =?utf-8?B?Z1V1UkR5Vkx6SHVybFdBajh5dkxsZzdJWlFOSzk0WHQ4YWV0L1BVdEd2K21G?=
 =?utf-8?B?akFJOGtCZWc2Y0t5R2grNFhxMW5NUDhCbWx3NE0zNXNHenNKc1g0NHJzOUVi?=
 =?utf-8?B?QWZWdzNUSTViTEIvTi9YQm03bUV6MGo1OVdGa2RRWklVZGllUEhxcWZBSVJ0?=
 =?utf-8?B?d0crdGZvSnBjb0RvMjQ2UlF0Q2VFWmUwSjdPeHlEdFBjdTd2QW4vd2JXcUVw?=
 =?utf-8?B?VlRzYXhTMnc3aHNMekhKdDFyYUtIMklCVEJERC84Kzh2azdOd21va1ZocjZw?=
 =?utf-8?Q?kFhoCJRnMgXTfDAvoQR4XtHABBT4NDVdGdBic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3Z2OFlGd1VWRDZWRFliNllIcTVmVEE5eTZBaXhJYUhkeDlhQnVYTzFpbHVr?=
 =?utf-8?B?NXF2eEhuZHRGdHNoUWJBaGcyQUtjSWNjMFcraXlSRk5FS2RtQjJ0aUt0OXV0?=
 =?utf-8?B?V0ZYaHB3SlZjVGVDbnRQRGRrT3NxU3dWRG9QQ1dkRUJsQlBoei9CaTVKVFN2?=
 =?utf-8?B?NE4vTUFaUG1MdThvU3RWY2cwUlRpTk56Z3Y2YndrT3ZHMkRuQlRrOGtPaDFI?=
 =?utf-8?B?cEdzQUJrTTFLVzhNRS92WVo5dm1vT3RqUXRlMDIwTXo1aU5zWXRLZTJWaC9p?=
 =?utf-8?B?blFmdXpNekFack1GbllTaEt0YXhBK0dTdUVFOUpyU2ZpdVN0WHowU1FhV3d0?=
 =?utf-8?B?OFpHeFFLaVcvbkpsemZmazUxK0FJYlU3WGp0aXdFd2xGTU01MzdOMWgyaVdY?=
 =?utf-8?B?T05oOTQzMHF5RnczbXIwZ2xUem1LOWxlRWUzK1UxbER2bDlaeS9nNHZaTmdZ?=
 =?utf-8?B?cFQyWXRNQkZMUElUT0JDai91ODhOamZEN3Btd0s5aHN1NWRGbzNiZEQ0QnYz?=
 =?utf-8?B?eTBieUFia0NEWC9vNnovZS9tNVV6ZWc3VDN3cVl4Ty9aU2pMcUYwMWNwaHRI?=
 =?utf-8?B?Mk5zV293UVFyZHE4aG44WitERDVpY01CbVYzY3FXRnQva2tmRGdDWkdwdlQ1?=
 =?utf-8?B?d1ZUOGFwUTJTR2hVcHFyaVBuL25TeGFGSWt3NFQ3akhHWmF1Y2N3ZTVyb1pL?=
 =?utf-8?B?bnRiSWQxVFlkaExkQ0hiVUZYZHNCQ2xmckYvYitmTEd4STRTa05CZXkwc1VF?=
 =?utf-8?B?dEx5Y01EdFc4alN2a2I2ZWkxZVZqZGM1dEp5alpDRC9CNEZrWGowRnArTjhB?=
 =?utf-8?B?Z215eDFqNGQzaGdzckV4Zkp0ZC9yMXNVS3NKbmtSOE9LSGtseFl4V3dsUXlM?=
 =?utf-8?B?WVVHWEV3dFBBVFNqQXRCaHhjZE5mSmo2SXNVMDA4R1c1dFZzVEhOcm1OS0pX?=
 =?utf-8?B?eVAzRkVDYnJEemVsOTB0R1dkTjJUd2FzZ2Vub2M5VU81aEpsVUJCVnJxVUdE?=
 =?utf-8?B?RTNKWlR4Yzhxb0czSk15UnJrcy9PL1ZkZFpFWU9zK3JiLzZVNGpQdXkwR1Z3?=
 =?utf-8?B?RzM1V0E0dlVnYnAwdW9hNURONHpSeExXUWlNU1EzdUFjYko3ckpDcERjN0dT?=
 =?utf-8?B?QXBQLzN3aGZ1Q0xqVjc3NUVJKzRCVEJiU0llTjlVeEhvZE1sUFRjc1l4UHpx?=
 =?utf-8?B?ejhIdnM3WmpseWxTcHgxdjRIenFBcFdDQjloMHdzeW5XNW5PWXFkbmVSamFH?=
 =?utf-8?B?MWRSRk14MThlMWRuYVRNc1lxbXJNN0VtVUdrVEtEK2R3akNmWVhNakcyRVFG?=
 =?utf-8?B?YWVPM04yb2cvN2JOdHdpODFqbjJrMkRZdmU3TUlTRFZjVU5TV3M4Q25KTlFm?=
 =?utf-8?B?dFdxaDdVZlFQdGVqb1lkM1NGWWp0bktmT3BhUlU0eVBaRzc3T20zRVY4TkR3?=
 =?utf-8?B?TXhKYzllSmh4dFovRDFDTVh3WUNyRi96aXBWWlpuSFpmMmJRZ3BBSmh2YlAr?=
 =?utf-8?B?aGVOb3Y3cmpsMzhQR2VmS0dNZnErOXozTmNNMmZZUnpCNjRlakZGcDlvRzNU?=
 =?utf-8?B?R1YrSUxtdENhRXQyempvQUFLNllhY1B1ZTBHYWtCbVNDditRc2JYY0x5dUt4?=
 =?utf-8?B?dmlQZkljbEROUC9hc05BYWgrV0dpTmJqN2xqT1VFOEdnUlVwQjdqMlNvd3dH?=
 =?utf-8?B?alBHUFlaRW5wOTdZQUJNTG9tQzNsbWxKQ0Vkcmc2ZW14NDdRN2pQK0JHN2My?=
 =?utf-8?B?ajhqaHYvWG11eitVY3A3bEdhQW1qTjkyNVBLK2FNN3VkLzdBZEhPYmpZS2Zo?=
 =?utf-8?B?YmQxRExCWjZmMmc3ZGhZbGUwZkJBa0k0dVJ4UHNpQllId3NXY2Jla20zTDQw?=
 =?utf-8?B?Z1d3VVg5am51eEd5RENhbG9VUktFRHBRUVBJSDFKWlFSQlJ5SmE4WnkxVUdN?=
 =?utf-8?B?K3VoTGpCYnFOcUtkampzMlBlZmFqM0Q1S2pDYlRUc3gvdkFLOHFsbExFOHFv?=
 =?utf-8?B?REF2ZFI4Ym1IbDNPSWg5N3B3MVBXYTNJV2Y1OGtDS2FOUS84NXBTZ3pHTmJj?=
 =?utf-8?B?OXJQVnJzVjJBZUwrN2ZYeC9yUzBmRFh4VzhWZE1YVEFXd2lLQ3FpZzgwU3BH?=
 =?utf-8?B?eVJPLzl6bzJPTU4waFZBYWNjWmtFVzN1NVRsODFSZWZhQU94N1B4am5QSHhl?=
 =?utf-8?Q?oJlV8TdGPWEWIEZiiHzRx5w=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116aca78-d566-4cf3-fd8d-08ddefa46447
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 13:25:49.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FytekMjZGS3Oc3DQikJ0VbUTPiULUv8eFbJel5S/icnbwKHItW/5KRMFJFn0xVuFv6bo7yTfBHl1uZXkUGy4XlCLCMuAgQSJ/e2sHeo+Z+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8830

On 2025-09-08 17:31, Thomas Gleixner wrote:
> There is no need to update these values unconditionally if there is no
> event pending.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> ---
>   kernel/rseq.c |   11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -464,11 +464,12 @@ void __rseq_handle_notify_resume(struct
>   		t->rseq_event_pending = false;
>   	}
>   
> -	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
> -		ret = rseq_ip_fixup(regs, event);
> -		if (unlikely(ret < 0))
> -			goto error;
> -	}
> +	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
> +		return;
> +
> +	ret = rseq_ip_fixup(regs, event);
> +	if (unlikely(ret < 0))
> +		goto error;
>   
>   	if (unlikely(rseq_update_cpu_node_id(t)))
>   		goto error;
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

