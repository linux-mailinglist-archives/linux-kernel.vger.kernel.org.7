Return-Path: <linux-kernel+bounces-779041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D364FB2EE46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82B03B6FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050326F2BC;
	Thu, 21 Aug 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TaSuj0Ch"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19463157A48
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757969; cv=fail; b=mQz5Wclzxs633GnY0pMtrjdEdFm48odLiPBfvDYiLaRaDpN/ju173IHy2IT7NTknQi/5B+ef3quOKEntz7Vjl1l1hMrtfF2tZzRWM81dlMVVdMMeypg05FHklZjEpJqeg0YKbCfk9kVNxYQqxLHzgqoXLQ8wWfj74Ru4oKRJ/Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757969; c=relaxed/simple;
	bh=5o2zQ2/yrFB89A2NJm0ix/dB9Nk9203n2+tJAypUcEE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ial3XewQlD91azYiJ2KDnQ7zkhZmN0/ahKs/Ohctoxuw6D8ne4NpfJz7wcdvuVWcryYkiQUDN6DjKONh0R+AAYYw8sT0/IaDXVZhiAkHzJXnHUwIDlp3bTpoDryKzjAlYOJ1M/2k3ao3b198zNoPWXaKegRZv/ctbSqRpgdrBmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TaSuj0Ch; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6FrZ+4Ool+9zyO0vKppNY1RLUixOQtuWnpz4tHuCxXTiRf+ohEI4mHlVwnDYyKtaS9kY/Z8p5Iu6NmErKa6EeHCrJ7KqeYCoe88wRwjF1NRjgsaVrFjYzN4Z95PdAyN3Z+ySOrY/PqtaMDHo6o3Q3C/lmb1bM4awQHPthQJB699LKlVnxd7dvXhalCEwlX8wkqydo+hWA8Umr4vtdf7SpzyOVnMh5QzQVMckbYwjxnNfQwpFvBG6V2phADXuQNmUMITVfGufqyYeYTtCfjJ2qImGKjqxwDfORnXnNs1hqXuNsIQOspjfDGMkcnA71YP8vtQGCFJ/zC7yP0zfr7J8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPmcLMJDvxXFX/nfJgkjfQMo4bUKC47Ld1L4lEwpAKk=;
 b=HrwKlib0POHkRM/Dv/YiSJxttMZiHjirhCybHy2Sjj5rfODH9yrbpuCFEftqqykg8eiYhQrGjfpYYGNzIUoay791lzUxcAESQKkvX9x9mLmND2jeAUNyAwdZ6wp7xTCMH9g3PHzux3+v4rf1YdUkJaFBraKIt8R7odgEj0n/ke0lwyp9sxpww05+R2hE7I4Raxt4NhCb//BoClmFKoUfGGyVA3XqL/6s7UQp19MLxUH3gOuvRpfclXT6o9NDkGhX+QCWX/48KJGun1HVaMZ17f/Z1o1KihgVDr5Ju4r1bV1G+ggpXCJB4kJCPS0EWI3Tsv+2bb15zGAMId1bjHNbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPmcLMJDvxXFX/nfJgkjfQMo4bUKC47Ld1L4lEwpAKk=;
 b=TaSuj0Ch/degMvwYeRv74ksDa695Iw0nIb5ED0CLN77HaqeiM/eyOKxdIxzOhgwZcz7kZOw6g9PO9w5+iDDDjfOjPcLm1EjtktQXOYTQY7gmjs2H/knrf6aF0jwQM/N8A4j+weC8K4kSrgOmnhcnDL5NGljdMxt/36fPX1KsWWX520OwvCoRPXWZ5EsQX1MqBRvI3q45h/LIMEMly457eYnuTQd0DYCytQzvg8mP6EDZuGi7WwpHfOCMVhZT5LVbrqr20FyJkpbzWCK+5PtEGCcid7diCslV6Y/jLTQxnaRFZ3DFqtKYDgPz46FpZFpKV8Zlx42Czjl0NOi11UUiPg==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by PN3PR01MB7271.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:8a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:32:43 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:32:42 +0000
Message-ID:
 <MAUPR01MB110721C4A0C82AD2A8348CEF0FE32A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 21 Aug 2025 14:32:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Affinity setting problem for emulated MSI on PLIC
From: Chen Wang <unicorn_wang@outlook.com>
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Marc Zyngier <maz@kernel.org>,
 Nam Cao <namcao@linutronix.de>
References: <20250722224513.22125-1-inochiama@gmail.com> <87tt32r082.ffs@tglx>
 <re3qxwkm3lu7o77kyfswwennqvtpyonlj4zajt5eu7z5zwkosr@mwacqq6bpbk4>
 <87frelrgn6.ffs@tglx>
 <qy6z6ym2rje36vgt6az6hkubsaeenicsu5ouxwbkuwml2inib6@qvz66lad64h3>
 <236be1b9-58a6-4d4d-9faf-9cbd38f63162@outlook.com>
In-Reply-To: <236be1b9-58a6-4d4d-9faf-9cbd38f63162@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <f4625219-6058-4df4-a254-4060641de3f8@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|PN3PR01MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e4dfde7-10bf-47ef-fe85-08dde07c87ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5072599009|461199028|19110799012|23021999003|6090799003|15080799012|53005399003|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RStlZjFtYWtjczVEOVVBdmh1YWVpQWhuY08xUDd2NTBQOHBtbW5rSThGUCsz?=
 =?utf-8?B?M3ZQOGtOYjl3RVRMUzVGaDJlZlMxd08rNm4zbFFiOTl4eUk1NnVMMXc3RS8w?=
 =?utf-8?B?VWE2WTNXSTFOdXEwak5YYU1GaHEydVdWSUc3Mmt5V2VKSlQ3OUdzbWlNaUtL?=
 =?utf-8?B?Mms4WlBPOFpFSkozd2VHNjJJRThtUlBJS0kvYWNIQVIxY2JFTHl5S0hnWExN?=
 =?utf-8?B?OWl6N215ZkJ0MVFrczJZOTN5b3l5R1AzN0J4bHpYSHVCY3dkOXRjc2RPdmlP?=
 =?utf-8?B?bTFNaUJ6T2RlenBNTS90blM5WlUwdkJRbE9OTE5GV3B1OUgxc0p5Q0N2RW1G?=
 =?utf-8?B?djc4ejhIYStOWmI2QkdBdmUvbWVjTCt5UjNrVjNHUy9tbTMrd2d2WFVzaW9r?=
 =?utf-8?B?NHZBS3I5TXJPRkMvazlzZjdXOFBRZmd4Q0xhSHQ4TXNRV1k1T0pNWTE3RGNh?=
 =?utf-8?B?QURyeVRndlpBazJTNHhvVjZSNnlXY0trT2QybDNLR1Q0Tkc3aEppT2xjcTVT?=
 =?utf-8?B?VEpoYXZUVXF5MGMzN0s4RFZKQUg0SGtmR3N0TUl0cGh5VkVkbktUZC9hNWRt?=
 =?utf-8?B?aTVqSzNwYnhnQ0F6SUhPZ0NZY0pFbUtZMmUzRzMxRGhJbmVra0taN2FWY3Vw?=
 =?utf-8?B?TnkzOXg4aURMYWNTa3BIKy9MQkV3ME1sblhqUk9oNkRFQkVCTWtHQXBlVEg5?=
 =?utf-8?B?VkNvb1lWRUdQZGJPNEIyaElmWHQ0YmFpandsMHRlR0o5UThYZDJWVDQ0eGdy?=
 =?utf-8?B?VkM5MjZHRGNYU216Q0lINnJTaDhxQTJMMTV3UytrVW1FNXpScU5rcE5mbTZH?=
 =?utf-8?B?bDRSUDJlRWVWVHBFNVVDSW1iUjJsTUYwQmtIcmxtcHR6UjZBYTBGMGxpSnJq?=
 =?utf-8?B?VWpCU2NIa3ZkL09yTFhoQlBlUDNtVGROSG5HdDhqalRWMjFUei9Rc1pGRGdh?=
 =?utf-8?B?NzEvdnJQVmlQT3NCanExL3R6UnNSbW5aVkhieXRZZTlDa2JZb29MM3pmRzJy?=
 =?utf-8?B?aHBEeUdzaEpPb1ZmVUE4UDcyd3BMeW4wMk05a1FKd0lsbjJRaWVhK0M5N3Az?=
 =?utf-8?B?Um5wRTVIekkxVE5xN01pVUV0Y3BkbG50d3h2VEVkTS80ZlpHb1R6UEMzMDdR?=
 =?utf-8?B?WC9xbUE2YktJK2hDczU5dU5wN1k4eEdXS0g1ZWhuQU90cUZPbEJOcWp6cTYx?=
 =?utf-8?B?UUg2cUZXUTBhRVdwZ2xpaFg0UVNjcmgxWUVQWUhPTHdWVmd3MDE0YWRVbEc5?=
 =?utf-8?B?bUhpUFluNzFqczBjRWdMUDIxdXhwVE93aDRqKzZuc2tQL0NtT2pCS1VPWkNC?=
 =?utf-8?B?Q1VQY1ZDS2w5QmxjQ091MFhlMFEzdzhwWkdIV0tsakFrRXg5Q3JoUkMwZG5z?=
 =?utf-8?B?WmJBTElxVnVBcGJMNUhLb3hVMmhFb0JTTkhqcUZYQVJjYm9pdzRRYmR1QVY0?=
 =?utf-8?B?eFBqcjd5ZnpsS01ZZzMyVWlhOHVyamVOakpvWGx6TDFnd2JoZ1lOVDFLKzBG?=
 =?utf-8?B?d0JvS3dDSFNkVnQvdnh4anNpQWZYYWEzYnIzUUlWREhsa2pPRFpGUjlGbTdi?=
 =?utf-8?B?b04wd25NYUVSTitFc2g2SGppUDl3a2ZJUU9HdzExUURtS3Bkd1N5bWZmR3d1?=
 =?utf-8?B?ZjByL1FScnlsR2VDb1c5dGRQR3BXcmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmVYTjgvWCtNQnEzSGlaSGNVcmtiWndCTmZJMFlZSStzaUpYM0lMNW9TYWZD?=
 =?utf-8?B?Mkk2cVlxUTlVeC8ydW9GOFI4RE5Hcy9hWCs4WWhYbmVVelZMNTRmeG02ZzhP?=
 =?utf-8?B?QjFhSHhHZndjRE1hUjhTWW9sVnJVV1lOemFRRlFoN0lHZFc1aGgveVllYTZz?=
 =?utf-8?B?WGRBZ3V4VFBOVGovb0YxYXNRWjZzRDhtQ1grYXZ6b2hUNkJGUmdkK1d6Yklz?=
 =?utf-8?B?eElEWkpNZTEweW82Z08wNHBjQVJNR0hSVGZyQStWczdFV04yRHpJQW00N01v?=
 =?utf-8?B?YUZJNm45NnIvZVhkTTJvTS8yL3NiZU1zN2hNWEc3ZnN5Z3NGTThEUk02VzRR?=
 =?utf-8?B?L2xXK3RheW1zSXJUTENWVEM5dHhHMnJKdlZBODI0ZCtmRSswUm9SVEdqbnd6?=
 =?utf-8?B?NEVSSkZ4empBakJpcE9OSlROd29LSkYzK0c4YVljTlJTZ0RyVENKcitzQ21U?=
 =?utf-8?B?eU1FaGFSSWhLQzgzTkwzWFhnOTNZb2ZTaW1rbE1aZitZMStRWHQxV0RyaEVR?=
 =?utf-8?B?Y0kySVBZRFJXUlNOV0dEQmNRbDJ5MXVxNFZPVlE5ZkVnMGtwVElTUCtBb3Fa?=
 =?utf-8?B?emxpTk5Da2JYZ0cvdWJ2cHBERXRGUmVKVGZNUUN5L3F0ejZZTGhDbDdTYzhl?=
 =?utf-8?B?aTUwaWt0Ykk2ZS85ZWJXVENrM3FRU2RuQ0Ztd245b0VuWmlyb0RtZHdieWdG?=
 =?utf-8?B?Q01IdHh6ZWpnSFJVV3lsMFlaS2htdGg0YWdyRnlmd3I3WUVPaWMxZlNnVFc3?=
 =?utf-8?B?RHJTSld3cE9PYW5YNE4xZ2ZuanNncUJHUjBtUlB1a2RWZzZFOS9nb240Yndu?=
 =?utf-8?B?WHRKZ055RjBzZUV6bjcxTzk0QWo1RlRHV0pibzJON1BiVmMrZnJmMklVUkFl?=
 =?utf-8?B?STFBdHliYVdDVEgvUzRUYXlleW0yWWQxSTlPYVVtQ2d0QjFkSDgwZDRtSXha?=
 =?utf-8?B?cTZ4U1ZYSE0wR2UzY2RUQ2xsWk4wQjZpanEwOXRWQm1YMHFzVDl3VWs5NTB6?=
 =?utf-8?B?YWxoRktuWFRsb2lxNjFyZ052R1NtRjBaNXNzZ1V3SVB1RVVFNWl5cE5ZSWxs?=
 =?utf-8?B?WVE2dWlrbThXRGcrR3VyN0x5UTVPQUwzbC9TZGUwQkpCckJObXdtMG9XQyto?=
 =?utf-8?B?UUZLMVB5MFI2bkZvNHBTbEhndEZSZnpPUVZaK0dNcDRqUEN2QmVHNDZ1NHBF?=
 =?utf-8?B?dzJJOTdWL285SHJTMnc3U25maW1oQ0NkSHJZQ1FVUkkyOWF4eEYvOWRIRHpM?=
 =?utf-8?B?aXE0YXFwR1FTQVFLcXpESnZENng1bzNVMnNOcW85YkdweHFUd1JpK1Ywcldv?=
 =?utf-8?B?N3kzUTJmLzkyS0VPRk5zNXVoSVQwMFl6SUNNQzFibjlCZGVidUZKajV2Q3gr?=
 =?utf-8?B?Z1BuRUVlbTNHSlZYMEd0V1BSVEFLVUdnVkp4bXI2S1VSbHhvOWNmWTY0RG5G?=
 =?utf-8?B?Y1Uxdm53OVFuaHpEVk9BVDdFRUZSSE1xODFBQUY1SzUzaDFqVDN1ZDViT0V3?=
 =?utf-8?B?VXQvaGhMTTNjZGExWlQyTXFoUHlQUU9UMFhCUTRkVVhQd3dyZllGSExkVXpn?=
 =?utf-8?B?SnlZRmF0RGd6OUN3cUpCWFQzZ3FOWGxEU3F2Z0t6Ny9aNUNmK2ZrdnZMY3hP?=
 =?utf-8?B?WWpXQVdsUU50OGhJbUxNSlpqcE8vY25xOXFpWFNWSWY3VUY4cmZ6UENNbUNR?=
 =?utf-8?B?Q1VadGxlclI4V0lWTGtsSldRRnFsREFSWEQ3N1BtcWpKVjNWcndCYy83QXpO?=
 =?utf-8?Q?Mw781X8LcACwmpxWcAvXT1WcQO9/z/ARk9PSZfU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4dfde7-10bf-47ef-fe85-08dde07c87ed
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:32:42.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7271


On 8/20/2025 3:40 PM, Chen Wang wrote:

[......]
> So it might be worth investigating why the two different processing 
> paths in `irq_startup()` cause this problem. I saw that Inochi 
> submitted a patch titled "irqchip/sifive-plic: Respect mask state when 
> setting affinity." Can we assume that simply applying this patch will 
> resolve the current issues with the SG2044? Do we also need to 
> consider introducing changes to the startup/shutdown functions of the 
> plic?

Sorry, please ignore my question. I looked at the patch again today and 
it is still necessary to introduce startup/shutdown for plic.

Thanks,

Chen

[......]

