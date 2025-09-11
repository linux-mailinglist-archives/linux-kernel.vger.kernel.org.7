Return-Path: <linux-kernel+bounces-812270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C0CB53544
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CD51CC08A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCDD338F45;
	Thu, 11 Sep 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gzFxUOIP"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020140.outbound.protection.outlook.com [52.101.191.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AED3376B0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600839; cv=fail; b=RW/q2rkGSD6BlpLThL94B9gaVDIX3HtDKU40dB9AQg0NmoaB+t+y8VvdYSMt6tP9BbAyutqYvHrP5JatktIY9cqzJhoJ5eIJB/CW3J5HusaTbVDxkXTS626ceV9T9VVKprNGxghbrVFS0xNK6sO8INHGEz0w6VM6UfrH9soTTc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600839; c=relaxed/simple;
	bh=RvsoqH3v/uQawmPjbkeyNIqa6CYh+fSFX3jmHelxUwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMjbcWtcmmaFT7RvQyQZk6fTPASh3axLvqZgEsetFanItGaVHUSOcclPQp7wWI4rmUuDFtWK403AKR3NpLdlunU3nXmbnpd81YnN+0IF+MK8KNJX82JLb865HhM6aP8kh+Vx0EDssaHt2w/OjhAW35KHt8WiaAZFH7bj6BEGnV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gzFxUOIP; arc=fail smtp.client-ip=52.101.191.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBZTNWxebuw16fqgqdQmT1HGa516RmffjZ4lSS+VaRiFQmXmDxeTFc4sKJAlocpAhg5YQaKVdsDzrFXT/LEdfE1XjEgBn2BN2lg9Mg+ew9UOSIaW22J0N/TXKpLRGse5793LDrahBVvMvq+bwwmZTnUqKJJRst6NwYxq9x/zKq0EKJ4kh+a3P2XCYshrcCHaR1yka9pD9IZR4UuoharypyaLEdB/ZHes/B3+JUXOlpzB41630aZRSXaQzTvWpPiDUbxsIWG/DewekolU+CH3kjAAo0Xn7lxgXCdfAXEe9cSiQGnSLVmJudoDOzyd/PjIem/fcwmONTbhQb8Et1MtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbHSzoFaSeFmy2hu65b3jW2CMAcHTVh4CYMYHJfUyfQ=;
 b=hR9C+ZprCWZLJXL5i7sqeQzh7dY+QttI3iczQ1ck+wkGFSqdCha5JXeUccqTdYD1LUa6R2JGpV0KzqGwUw2socKUfZRoFgC7FTvz/gcawt9JEv05zbgjr7wrHgqHdSphTKDw2p6Ayy2o/nnTqzppJtWo67RIZIJOg0IjWVkoR2m7u3cw/CybHR3kjPlYmoK4eNFG78wPOsD5P9RHbP7GMWbZRsjFa50vrNy5sYt2W6j2XW++lcWo4enTbllOoVAXF8aQ2mGK+MRT7FttWmuKYaj+zNU5plkQX5QUU8ZJcXj6meiV6BHL86JiJwswkglmog030Vhdm1BFGJNh7ovKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbHSzoFaSeFmy2hu65b3jW2CMAcHTVh4CYMYHJfUyfQ=;
 b=gzFxUOIPWpoPZthQLqtSqOHl4fttETJ3S0iM2j0ZLNdn8Bv5hxpYbgB0LLaxuf6CskDXS2LGYbUHympYfN78UpGpp4uPPNiciffG+X19hN5FEF8LLdgHgbFRT2dEkQx92QEeqwCd/nDz7aklRSQ4lKnbQBWzeGJSzoLGdS5VIsaXD6VSRHTvCWmJnPmsWgKGvclbN41y9kL6m9dR4qgCphhqj7NeBH041peIu//bHfIGChqOUaF6ILz8tCOKiNEfnmsAPMbwa+sdU1zI8a8JfmE1ZNApTD5VaQk4yZglsBGVEmWuV0bGdHaCtLLnW3N2GF2wqALD7r93Jd7DszDjDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6428.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:27:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:27:05 +0000
Message-ID: <ad0e0d2c-75e0-42c2-85d4-5232a5fb8af9@efficios.com>
Date: Thu, 11 Sep 2025 10:27:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V4 27/36] rseq: Implement fast path for exit to user
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
 <20250908212926.993963056@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908212926.993963056@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d67f1f54-13e0-48a0-23b9-08ddf13f4855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3gramQvMmJqVVJaaFJiT0dxUXBGZzg5WnhuRlk1REhWODlZL0VZbW9zZGZo?=
 =?utf-8?B?Mjk3Rm4ydEFvN2NWZlBSQWZPVWw3dUJ3S3N3dEhVTkphY3hlYkZ2YnVzaTVC?=
 =?utf-8?B?bGtaa09NcUJPWjNySVZSb0F5OVRqLzh0ZERqbnJ6UzFncG1zR3hoN0l5ckhO?=
 =?utf-8?B?a2FkNUJsSk9Lb1Arb1hOOFdsYzNGcmFlV0hsckRMTUZCUXp3N0ZzbmgrV1Vx?=
 =?utf-8?B?cTFBamlncFVyUEZoVHdBMUlFVis4d2N3RGVCSFZhdUl2aGlMZmFubWNTL2xE?=
 =?utf-8?B?SGM0UzIvUGI1eW85WWNZZU1Ra1R5WS83NjdIVUhMa1lyb0FhZlE3MVJKcndw?=
 =?utf-8?B?emY3ODRPeENJWGpqME53U3NORFBkY0w0N0phaXF0M2VjeG9OOWxScHNFdkRM?=
 =?utf-8?B?ZW03S3RVS0IxTXVrT3FUUjNINExzeGZTbm11U005TGNWS3VIc1pNbGMyNFl6?=
 =?utf-8?B?TGhoQ0t5TFNjaGRZT1FadkoxZXFNRUo3OHErV3h5QkhmRm9oOUtaTzJWZTJz?=
 =?utf-8?B?ZitPTlhwWGVBalhRNk0xSTRBSkFKUFRVdGxteXlMSURPSjBNWnNNcWVqQVdC?=
 =?utf-8?B?VEFITzVjNk9SK0I3OW1oMmZnem0wc2lvU2szdzFjdVlqUzlqQ3FUUTloc1JS?=
 =?utf-8?B?UzBsRDVpUXl6UXgwckhTMmQzdVlyNFVKT3pDbTZ3UjV5elhoY3pILzRQN3A5?=
 =?utf-8?B?N2RFT09SWXdPOFcxbkg3TktkTGtQMm5MRldVZ2Q3djFzY0Ewc3BnK0w3WW5n?=
 =?utf-8?B?V2dxRWVkdnJjZGtUa1VDS0NoRmN4UWxIV3ZHdzRRZ3ZvQUxUZUZsU21WbEM1?=
 =?utf-8?B?djBreFU2TG1lbE9MdThFRitQempvVENRWG96ZE1ZZjVaR3FQYU95SVFnT2t3?=
 =?utf-8?B?MWFLV1V0aHlUeFVxeEg3SVVuaGF3NWxyNkVJdmV1VFU2aDY3cU0rQzFieW9F?=
 =?utf-8?B?emJZVFNSK1RIakxUVzl5SkZHdFZQelczRlJRbW1sa0NnblhYcGdsV1k0THBt?=
 =?utf-8?B?eDRleVpWOTFlV25Cd2ZVaDhhVFVEZVdURW9PbkhlUVBXeGtSRlEzdVVhbzFh?=
 =?utf-8?B?ZmE2cm11UVFUek5DSDYxdW0xYm05K09ob1VXV1RSU053cFlYdldzV0dxUmVQ?=
 =?utf-8?B?ZjRtcWJKQWdBZnVRczRNdGlxMXMwckFKSlBlVEdOWDFTalVlTnNJNzFEWlZh?=
 =?utf-8?B?d2VueG9KR21sUzZwaExXUGRmbDBLaVFJRXo4d0FTZGMwdUFaL1JqazE1Q3hh?=
 =?utf-8?B?c1NUNlB2UnA3UjJKQjNlR2JjSGIyaVIwOHJma2JKMlpQWWhmTkxIME9sOGli?=
 =?utf-8?B?LzNyN095akFtVjdnMzdEOEhRbjYvVldRQVFxL1FQdzYzQXZEeGp5MVB1T09r?=
 =?utf-8?B?V1ZWSGp2QnJoWkdSRXlLNmYyNGo3UHdhNkp0aGZnbnVBdWtMeWFQSXE2VDE4?=
 =?utf-8?B?bm1zdUtQb0Z3Y3FPN1BwL0lLdUJiVjk3MU8rV2g5Nzk3UWl6K0lIRXp3cEwz?=
 =?utf-8?B?OWZqblZpN21LMDJWcmVuNzYyeCsyZDFmUElibDRBdytNUFBLMnJ4WmpreHpD?=
 =?utf-8?B?bmFxSXV1LzJvZFlxOTVQOVJBZnVJbFRnOWprYXBscGxZOE43YzRPeSsyNDNp?=
 =?utf-8?B?N1Yyb2xWZS9rZkplS0RYR2lYZi9jQkloWHlybGNkK3F1NHozWG5mWXpLMy9H?=
 =?utf-8?B?SEF2MXlkdmY2ZlZDZUNRQkd2QnBMS1BJMzhJRGdYejRhMlR2aHVJOGhaeTZZ?=
 =?utf-8?B?SW55NDRmenVXcVFOYTdQMWRmUm5CTkxSWGJsVHk5aW0wbVdhVWhmb2RkbGFF?=
 =?utf-8?Q?yWQ+vlaizoRf8/nRNlJNy0DB4rylytVD9KiGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rjl4OTZlM1VzcGpQZ0ZyUHA4ZGYySTYzWldSdUkzU3dpam5WQlpiVGtRUFI3?=
 =?utf-8?B?NTJhUlFOeWtUS01QQ1ZZR2pwZXlkb0owZDg0WXF4K1JaSDN3QVE4NnVqczRm?=
 =?utf-8?B?bGx5c3RaankydHJaUGUvcnVURlRLT0g2WHJZSnc3c0t0Z2RDeHJTWGlCeWp0?=
 =?utf-8?B?a2gxd1A2R3NtQktmOHY4ZEx6dDNaeGloT21la2NvSVF4TzVlSzZpMFVob0hl?=
 =?utf-8?B?OW9KZkcyZGtHVWlmaFNIdmJuRjkwMGJRNm9VS3hOWHQycXl5VEZRWUdwa1pV?=
 =?utf-8?B?bEZBNFBnWlVyeklqQ3RxdkdWVzhERHlNc3o5OHlMNC81angzUE56ZGpIUlRQ?=
 =?utf-8?B?Si81VUlMUW9VWktadEhVZEFoZHdmTWF5WTltZW9xOXlWRHowVkpVTVBQeEVX?=
 =?utf-8?B?NHQxU3ZtWGVRT1Q2MnJiYWdVbG13c0cwTm9WdXQ3NnNGSXN0K1VFbGJLSnVi?=
 =?utf-8?B?MXAyWTRhcy93QkQ1bVk2UDc3OUJtT3VaYWpBc3VxRlgvNWlMajMvbzU0aUo2?=
 =?utf-8?B?eXJCaFJNWEZzN2ZuZnkzc0dZeDd1cXVyUERDMmtTK29TZStwdm5JYjdLS1d4?=
 =?utf-8?B?UkQzeExteGxkVk94eEJHL3ZSVFBKMVdGTW5wanFJMklNWC90R1VHVTFYTjZs?=
 =?utf-8?B?eG9wdWRjQzNRVEJNZm81Qncvd2luZnZodVdPZWtBem9qejFhdm1uUzZ0Q0RC?=
 =?utf-8?B?TmM1OTdTZldFZklFUUdFbG4zdjdpUUFzaUtGMXN0NVVBSFpGblZSdXIwdnBE?=
 =?utf-8?B?anQvb3g5Q0xvWXViV01adVBtejFIT2VPaGFhaUxBMGRIY3pFQXAreldrZDk0?=
 =?utf-8?B?MVM4MXhqNENoSVBxeGE3RDVJUjJGK2VvQ1NNdXdHRXM2QUozR3BsZ01VUW1Y?=
 =?utf-8?B?ZUxUNzR5d2VrTkhzcXZVMVRTQS80RHJpR0p2dVBQTVBPK091U1pQMlB4d3RT?=
 =?utf-8?B?Wm9mcGpDN1BQSEVqckxWWjErVVhybTdrNGxvZ05jWG9qRjVGNDFDSTRoM3Yz?=
 =?utf-8?B?YlpFNTlXYjNpWnN4NUwzVWI4enNFdFZlbmVBQTlGOGRzTEJrcWlTbFNDaThs?=
 =?utf-8?B?dm1wejJuMkhjKzFhUHRld0ZTMTF3ZmlzNlFpVTFMRStzRFltdG1mTXJQYy8y?=
 =?utf-8?B?cjRSUUR6akowZ0JrUEF2N0Fubm4zWG9BTGwrR3NVQmtwZEEwcFoyTkdrTURy?=
 =?utf-8?B?SGdxSCtoaE4rTkV5UEM4RGFXL3pUVVdnQ2pncGxEdjdRRnhaTXVjbDFCdlF6?=
 =?utf-8?B?Z1pFcXoya1BkckVSbG1UYmhEUXg5alZUdllDZHlRYWx1U1V5MHd4RnliVmQ2?=
 =?utf-8?B?QmJsTGRGa0lwYW0rS2JvNzcweHZ1STZUS05PczBuaHFsKy9mOUduRENPbnhT?=
 =?utf-8?B?N25GK1RneGRVNnhSSGJBTVg0alk4M2hTc0FqbmFwSEVwR0cyakZmQmlOMk91?=
 =?utf-8?B?V09TTlU1V2VqeDNZamF6SDU3VGhwU0dyYnlZWUZRUUJMMFBWR1ZpSVk4UUda?=
 =?utf-8?B?NWk4d3BVQkxIczVtSTcwWTBVaEhNRlFpdHJsR1VTODc1dHVPNmVSTDRHRkl0?=
 =?utf-8?B?QXBkZlR5dmZDQzMwSGNjQm56TGtiTlBIQm9mNE9IaGo5VC9DSHVDb3NjRGtx?=
 =?utf-8?B?TUJveWJWUEVjblNQNklCOWIwaEpDNnRTYkZZSEdaak9lQTI1ZUU1TDZmcGdU?=
 =?utf-8?B?V1pmaXpVRkErbmRWT1FjV0NtakNMd2djRUtXNEcrdFpuTUpZUlZISXVrYmla?=
 =?utf-8?B?UlVxb0ZoTVJwbGlxdDdRRG44d3BadlhsamtYOXkyTWVRTXRobHQwWW9ia3E2?=
 =?utf-8?B?S3I1SDkzWkg3MWwrMzBueUovbzNqaTZESDRYdTFPREVWOFJJK01qN0hobFpw?=
 =?utf-8?B?bXA1WTRWcGVWRXJhaEFYcGFmSS85aWY3V3hiOWhYSHY1Mm1EbWpqQytyaWU1?=
 =?utf-8?B?RlJQZDBWM1RpdlVUSWx6TVNibzRHTzBMbGtsUVBtejM2YTFjT0t1VTQxVnQ0?=
 =?utf-8?B?U3NIcXdDek1Icm43cG1DY0kxcXdjTTBlMWRHblJVMkkvaklHMUh2aXAzYmQv?=
 =?utf-8?B?L21JVGpPQU93TXZyRmM4eno5S0RCLzJxeHU3bzNVS3pDTUUwaVFzdkxCS3NH?=
 =?utf-8?B?aDhqS1FsZFZlNjV4QndDVVc0YnhHTmpXUmFPcnZ2U0NKeGpXc0hCUy9tTzhz?=
 =?utf-8?Q?x12xj7ThWI4exzQODXb9ZGU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67f1f54-13e0-48a0-23b9-08ddf13f4855
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:27:05.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EDUviSzpLP3e2nRbfgGWCJVOlSWjH57vSwYL9r1tsrdkT1nnjKHSbhOS5cCsWXIalQ64Q8vmz/bRBmDE9ffVTwtquuoZSqI8wxz7DaDZDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6428

On 2025-09-08 17:32, Thomas Gleixner wrote:
> Implement the actual logic for handling RSEQ updates in a fast path after
> handling the TIF work and at the point where the task is actually returning
> to user space.
> 
> This is the right point to do that because at this point the CPU and the MM
> CID are stable and cannot longer change due to yet another reschedule.
> That happens when the task is handling it via TIF_NOTIFY_RESUME in
> resume_user_mode_work(), which is invoked from the exit to user mode work
> loop.
> 
> The function is invoked after the TIF work is handled and runs with
> interrupts disabled, which means it cannot resolve page faults. It
> therefore disables page faults and in case the access to the user space
> memory faults, it:
> 
>    - notes the fail in the event struct
>    - raises TIF_NOTIFY_RESUME
>    - returns false to the caller
> 
> The caller has to go back to the TIF work, which runs with interrupts
> enabled and therefore can resolve the page faults. This happens mostly on
> fork() when the memory is marked COW. That will be optimized by setting the
> failure flag and raising TIF_NOTIFY_RESUME right on fork to avoid the
> otherwise unavoidable round trip.
> 
> If the user memory inspection finds invalid data, the function returns
> false as well and sets the fatal flag in the event struct along with
> TIF_NOTIFY_RESUME. The slow path notify handler has to evaluate that flag
> and terminate the task with SIGSEGV as documented.
> 
> The initial decision to invoke any of this is based on two flags in the
> event struct: @has_rseq and @sched_switch. The decision is in pseudo ASM:
> 
>        load	tsk::event::has_rseq
>        and	tsk::event::sched_switch

I suspect that my earlier comment about has_rseq and AND applies here
as well. We could probably remove the has_rseq load and the AND
altogether and just load sched_switch for the conditional branch ?


>        jnz	inspect_user_space
>        mov	$0, tsk::event::events
>        ...
>        leave
> 
> So for the common case where the task was not scheduled out, this really
> boils down to four instructions before going out if the compiler is not
> completely stupid (and yes, some of them are).

Or three.

> 
> If the condition is true, then it checks, whether CPU ID or MM CID have
> changed. If so, then the CPU/MM IDs have to be updated and are thereby
> cached for the next round. The update unconditionally retrieves the user
> space critical section address to spare another user*begin/end() pair.  If
> that's not zero and tsk::event::user_irq is set, then the critical section
> is analyzed and acted upon. If either zero or the entry came via syscall
> the critical section analysis is skipped.
> 
> If the comparison is false then the critical section has to be analyzed
> because the event flag is then only true when entry from user was by
> interrupt.
> 
> This is provided without the actual hookup to let reviewers focus on the
> implementation details. The hookup happens in the next step.
> 
> Note: As with quite some other optimizations this depends on the generic
> entry infrastructure and is not enabled to be sucked into random
> architecture implementations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   include/linux/rseq_entry.h |  133 +++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/rseq_types.h |    3 +
>   kernel/rseq.c              |    2
>   3 files changed, 133 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -10,6 +10,7 @@ struct rseq_stats {
>   	unsigned long	exit;
>   	unsigned long	signal;
>   	unsigned long	slowpath;
> +	unsigned long	fastpath;
>   	unsigned long	ids;
>   	unsigned long	cs;
>   	unsigned long	clear;
> @@ -202,8 +203,8 @@ bool rseq_debug_update_user_cs(struct ta
>   
>   /*
>    * On debug kernels validate that user space did not mess with it if
> - * DEBUG_RSEQ is enabled, but don't on the first exit to user space. In
> - * that case cpu_cid is ~0. See fork/execve.
> + * debugging is enabled, but don't do that on the first exit to user
> + * space. In that case cpu_cid is ~0. See fork/execve.

see earlier comment about using either ~0 or ~0ULL for consistency.

>    */
>   bool rseq_debug_validate_ids(struct task_struct *t)
>   {
> @@ -254,12 +255,13 @@ rseq_update_user_cs(struct task_struct *
>   {
>   	struct rseq_cs __user *ucs = (struct rseq_cs __user *)(unsigned long)csaddr;
>   	unsigned long ip = instruction_pointer(regs);
> +	unsigned long tasksize = TASK_SIZE;
>   	u64 start_ip, abort_ip, offset;
>   	u32 usig, __user *uc_sig;
>   
>   	rseq_stat_inc(rseq_stats.cs);
>   
> -	if (unlikely(csaddr >= TASK_SIZE)) {
> +	if (unlikely(csaddr >= tasksize)) {
>   		t->rseq.event.fatal = true;
>   		return false;
>   	}
> @@ -298,7 +300,7 @@ rseq_update_user_cs(struct task_struct *
>   	 * in TLS::rseq::rseq_cs. An RSEQ abort would then evade ROP
>   	 * protection.
>   	 */
> -	if (abort_ip >= TASK_SIZE || abort_ip < sizeof(*uc_sig))
> +	if (unlikely(abort_ip >= tasksize || abort_ip < sizeof(*uc_sig)))
>   		goto die;
>   
>   	/* The address is guaranteed to be >= 0 and < TASK_SIZE */
> @@ -412,6 +414,124 @@ static rseq_inline bool rseq_update_usr(
>   	return rseq_update_user_cs(t, regs, csaddr);
>   }
>   
> +/*
> + * If you want to use this then convert your architecture to the generic
> + * entry code. I'm tired of building workarounds for people who can't be
> + * bothered to make the maintainence of generic infrastructure less

maintenance

> + * burdensome. Just sucking everything into the architecture code and
> + * thereby making others chase the horrible hacks and keep them working is
> + * neither acceptable nor sustainable.
> + */
> +#ifdef CONFIG_GENERIC_ENTRY
> +
> +/*
> + * This is inlined into the exit path because:
> + *
> + * 1) It's a one time comparison in the fast path when there is no event to
> + *    handle
> + *
> + * 2) The access to the user space rseq memory (TLS) is unlikely to fault
> + *    so the straight inline operation is:
> + *
> + *	- Four 32-bit stores only if CPU ID/ MM CID need to be updated
> + *	- One 64-bit load to retrieve the critical section address
> + *
> + * 3) In the unlikely case that the critical section address is != NULL:
> + *
> + *     - One 64-bit load to retrieve the start IP
> + *     - One 64-bit load to retrieve the offset for calculating the end
> + *     - One 64-bit load to retrieve the abort IP
> + *     - One store to clear the critical section address
> + *
> + * The non-debug case implements only the minimal required checking and
> + * protection against a rogue abort IP in kernel space, which would be
> + * exploitable at least on x86. Any fallout from invalid critical section
> + * descriptors is a user space problem. The debug case provides the full
> + * set of checks and terminates the task if a condition is not met.
> + *
> + * In case of a fault or an invalid value, this sets TIF_NOTIFY_RESUME and
> + * tells the caller to loop back into exit_to_user_mode_loop(). The rseq
> + * slow path there will handle the fail.
> + */
> +static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)
> +{
> +	struct task_struct *t = current;
> +
> +	/*
> +	 * If the task did not go through schedule or got the flag enforced
> +	 * by the rseq syscall or execve, then nothing to do here.
> +	 *
> +	 * CPU ID and MM CID can only change when going through a context
> +	 * switch.
> +	 *
> +	 * This can only be done when rseq_event::has_rseq is true.
> +	 * rseq_sched_switch_event() sets rseq_event::sched unconditionally
> +	 * true to avoid a load of rseq_event::has_rseq in the context
> +	 * switch path.

Based on the patch just before this one, I don't see that the
implementation of rseq_sched_switch_event() matches this comment.
It does check ev->has_rseq.

So I guess we need to pick one here:

Either we skip a has_rseq check in the scheduler and always set the
sched_switch event, in which case we need the sched_switch & has_rseq
check on return to userspace,

or we check has_rseq in the scheduler, and we don't need to load it
on return to userspace.

I suspect that this series went from one approach to the other without
entirely updating the relevant return to userspace code.

> +	 *
> +	 * This check uses a '&' and not a '&&' to force the compiler to do
> +	 * an actual AND operation instead of two seperate conditionals.

separate

> +	 *
> +	 * A sane compiler requires four instructions for the nothing to do
> +	 * case including clearing the events, but your milage might vary.

mileage

> +	 */
> +	if (likely(!(t->rseq.event.sched_switch & t->rseq.event.has_rseq)))

Same comment as earlier about checking has_rseq which may be redundant.

Thanks,

Mathieu

> +		goto done;
> +
> +	rseq_stat_inc(rseq_stats.fastpath);
> +
> +	pagefault_disable();
> +
> +	if (likely(!t->rseq.event.ids_changed)) {
> +		/*
> +		 * If IDs have not changed rseq_event::user_irq must be true
> +		 * See rseq_sched_switch_event().
> +		 */
> +		u64 csaddr;
> +
> +		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs)))
> +			goto fail;
> +
> +		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
> +			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
> +				goto fail;
> +		}
> +	} else {
> +		struct rseq_ids ids = {
> +			.cpu_id = task_cpu(t),
> +			.mm_cid = task_mm_cid(t),
> +		};
> +		u32 node_id = cpu_to_node(ids.cpu_id);
> +
> +		if (unlikely(!rseq_update_usr(t, regs, &ids, node_id)))
> +			goto fail;
> +	}
> +
> +	pagefault_enable();
> +
> +done:
> +	/* Clear state so next entry starts from a clean slate */
> +	t->rseq.event.events = 0;
> +	return false;
> +
> +fail:
> +	pagefault_enable();
> +	/* Force it into the slow path. Don't clear the state! */
> +	t->rseq.event.slowpath = true;
> +	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
> +	return true;
> +}
> +
> +static __always_inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
> +{
> +	if (unlikely(__rseq_exit_to_user_mode_restart(regs)))
> +		return true;
> +
> +	return false;
> +}
> +
> +#endif /* CONFIG_GENERIC_ENTRY */
> +
>   static __always_inline void rseq_exit_to_user_mode(void)
>   {
>   	struct rseq_event *ev = &current->rseq.event;
> @@ -436,9 +556,12 @@ static inline void rseq_debug_syscall_re
>   	if (static_branch_unlikely(&rseq_debug_enabled))
>   		__rseq_debug_syscall_return(regs);
>   }
> -
>   #else /* CONFIG_RSEQ */
>   static inline void rseq_note_user_irq_entry(void) { }
> +static inline bool rseq_exit_to_user_mode_restart(struct pt_regs *regs)
> +{
> +	return false;
> +}
>   static inline void rseq_exit_to_user_mode(void) { }
>   static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
>   #endif /* !CONFIG_RSEQ */
> --- a/include/linux/rseq_types.h
> +++ b/include/linux/rseq_types.h
> @@ -18,6 +18,8 @@ struct rseq;
>    * @has_rseq:		True if the task has a rseq pointer installed
>    * @error:		Compound error code for the slow path to analyze
>    * @fatal:		User space data corrupted or invalid
> + * @slowpath:		Indicator that slow path processing via TIF_NOTIFY_RESUME
> + *			is required
>    *
>    * @sched_switch and @ids_changed must be adjacent and the combo must be
>    * 16bit aligned to allow a single store, when both are set at the same
> @@ -42,6 +44,7 @@ struct rseq_event {
>   				u16		error;
>   				struct {
>   					u8	fatal;
> +					u8	slowpath;
>   				};
>   			};
>   		};
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -133,6 +133,7 @@ static int rseq_stats_show(struct seq_fi
>   		stats.exit	+= data_race(per_cpu(rseq_stats.exit, cpu));
>   		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
>   		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
> +		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
>   		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
>   		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
>   		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
> @@ -142,6 +143,7 @@ static int rseq_stats_show(struct seq_fi
>   	seq_printf(m, "exit:   %16lu\n", stats.exit);
>   	seq_printf(m, "signal: %16lu\n", stats.signal);
>   	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
> +	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
>   	seq_printf(m, "ids:    %16lu\n", stats.ids);
>   	seq_printf(m, "cs:     %16lu\n", stats.cs);
>   	seq_printf(m, "clear:  %16lu\n", stats.clear);
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

