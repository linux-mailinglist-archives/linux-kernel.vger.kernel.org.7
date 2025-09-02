Return-Path: <linux-kernel+bounces-796730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610F0B4065F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B383B93D9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79476309DB1;
	Tue,  2 Sep 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nAJqWt1b"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013014.outbound.protection.outlook.com [52.103.33.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB32C30BB8D;
	Tue,  2 Sep 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822515; cv=fail; b=k7BgY/KdGpQlkFKNkbETv9y+QV0SE1T6O2PlA2Au7AOUhAKB9CZjqdyJathKpHNTg6O8kUe++g/Vz7mh7BxNuIWCppKb2J/kUvzJzcObWgyTrQLsF5XV0Z2r9b6vaaztSYWDXKzOG2Wu/NIZWflaDoyAefwjGfjUOwisDdElOtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822515; c=relaxed/simple;
	bh=VRU+M0LvB/9ctPhQ7EZHYEgSLZJrzWBZ+x4pBLF6D3I=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rsk31OHES9+uQpT6AQYzQEbPbgjKjDIhsM5hjgmyjY6FZWMDoeWHMp64NVdJS5mrg/Iw7CNGjj4GsAhkTCJm/XearZG9fwZ99G0GO2Y6FZg/J5QJ+XLF+P1ZL1ULYjFTFMR43ansg8Wx8IjOOYY69jnY/mFY7YRgw05gQlQtVKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=nAJqWt1b; arc=fail smtp.client-ip=52.103.33.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJF6t/wAp2VIUXHixfVwdhg1CQiZlWiEJQuMc6a6YIQRhM83iuFnP8mwxUJQJSslHbbqv8Izmb/Jqk4o2FGBv1xedu9jccwOu/x5kkdRaGzw2STchUt7LySGJx6SgbGyfM+SZqkgFCEe74ng5+rGbb98wFJWYADGNF4xi8FyVzaastGCWiCGAfLyvVQ3cs2j+4QzQUthrljDNHLfuB7HdCbWJzGoWOA92Ex7A4/LfTvgZeNsVsZwXDPsOsoABEmrB0Xyb5n+0Xf5LEsTqHjiGMINm3aT66Z/OY4t7Odv03D0QHYz8lwf9ubvbj+1g5Cka8QqMWV6fAv1LMrLVe+sTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcpIKHrSvPxpxbRKbu8SqXeXF0u+GIjSftD4ow3iOPQ=;
 b=OqOdctYv+FDHced2+Ga7rK1NiM49Ncf3xnHNKxiqwLBCwoc+4iSM8cBl7zVwiDvWautvKdLmt1jlIgQ3AWyRdLJwsQmYZ9V8egI/fYOFF9+74k40fNpl4uTWGW3wvqJtJP1N/Khke+jDrqu+vqEYqdD4uP/M3WSiun9kP9xrA5gQfI5rmfaXJefmZ1N6oLyEyxTCNB6RSWWUPFY6IlSUARQaO02kH/1VFfK5qcStFkM80dUFmyHaCP89riSZ1yT5AIymZc72aMM82EiGtNt6SJqbipdq6AvE4vcynIqakgbpwM8rGylY80PwXRb4h+3sUEIAzjkPQIAzsoImJZeDLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcpIKHrSvPxpxbRKbu8SqXeXF0u+GIjSftD4ow3iOPQ=;
 b=nAJqWt1bbudplIw/qUZweyPHGYOJ57MROWZoDfO2EHGoJnWN/7jLS/BDVmfVTfD3lsXybdinm50Oos2nKpGsu0WeJa/J7JS18c36pnLDS8OhwPHu6bDTkEZyVMk/waYheHfzPICo+MzdtfHIlxO/did4Pd5AkYsCVGQSHVqIg45OelcbGv1BUnjiNLUtJnbz1inPaNajfokiaKgbXeewcSU/vWmcp+IuuZHGSvzIa3DY3z5e+M1MiV1sGiGhN59OeTfa7zf/ibgvDTgX+cY+kkTGbwXSYcxx5gnOIg+3AWCYP4m5wjCMGIOx1iJIj2QPJ99nquBIz2jnofKrTkrwJg==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by GV1P189MB2105.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 14:15:10 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::5756:694d:1641:3b13%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 14:15:10 +0000
Message-ID:
 <AM7P189MB100965809B3DE48A90A15415E306A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Tue, 2 Sep 2025 16:15:08 +0200
User-Agent: Mozilla Thunderbird
To: ziyao@disroot.org
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, conor+dt@kernel.org,
 devicetree@vger.kernel.org, fustini@kernel.org, gaohan@iscas.ac.cn,
 guoren@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, m.wilczynski@samsung.com,
 p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com,
 rabenda.cn@gmail.com, robh@kernel.org, uwu@icenowy.me, wefu@redhat.com
References: <20250901042320.22865-4-ziyao@disroot.org>
Subject: Re: [PATCH 3/4] reset: th1520: Support reset controllers in more
 subsystems
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250901042320.22865-4-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::13) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <ab815bcc-bdbe-4c71-a1c7-1ad8759ce7df@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|GV1P189MB2105:EE_
X-MS-Office365-Filtering-Correlation-Id: 151407a4-f457-4a73-4b4c-08ddea2b1fd6
X-MS-Exchange-SLBlob-MailProps:
	quCBMN2EvO+pPRgpcRKeMpPKDEKjvqeWrSn0pGK4vxwdhlYYbzhtZ2eZRcvcWsa0JV2eVPiUX8p4PrErY70MQu63/QGd24Mx70h1h2qf8kdEE/xpjxqUKyOiR1LEKY+s0XoYINJTwa+Ff4i8XMmyOgwTZkpxXZKKvuKyoTN1AnDZU9oy9lmsdI07cvHsUCgOMX/s+bXEHng9cqdeqIKnZfA8tJl5gj5hX4dNerSMUG5ANvzbQM0n3eaJjDPC1HtEzNxMqe4/iYwt4WhUfQ3lUzDeru0dYKe+gEWyItmtW0eCa8Ien+YnCM5EQXXIKH2WYYdFFS1prLexu991RPrtPjxAloTaHcgMRkrpxsJDopr8wuKzFh8ByUJhNIWhNKjbN/JrVd2UUbQHqGtSQw1scZFvuWN8Trg+2bzQTWa060YsWi4MNC1oDqwbFNXuWHmQkBKEJ2vo967pKRw2+0Jw/FE7+SFQL2AM3K8OtrCS8JIqZ1QkME4kGF4VRGlSgBrJ/RNicZsA9D6efn8+rMCXJrbJ7GV71dNhctlxELlalG4PdMnX5N6HM//Iru9+mUjT6xdUENHBG77hlruRJUaYF9X+5tRPeX3+afUgbxsnYb5Xs+ozV/ezAS1G1oVtnnRfkfn2ebYJUhSKOiwOe/yFYCL8YgVZjmjRs1fuNgU7rGik92S6dh7z8OoCsJFyDPHqJFPwtkLEdxkVfI2G6Fzepg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|21061999006|23021999003|15080799012|19110799012|8060799015|6090799003|440099028|40105399003|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGZIK0k0eGZmT09TcXFqUGFBYy84SVJQaU5oVmpXVUNURjVleUpHc2gyVmNG?=
 =?utf-8?B?WllIYllObGdWS3pqT0N2Y3d5MHNEVzhjdDdxcWFVeERRMzZRRnVBTndJK1hS?=
 =?utf-8?B?VmN5VDAvSytFd0kvRkVQV0lYZnpERitNWEV1Y0I0QkhLd1lpbG9WUFpWNVpy?=
 =?utf-8?B?NnpQdTcyZkxBTkovNHlBOW5hZ0pjb3hhY2hHQkxtN29xUUduN2xTUmNEbEhI?=
 =?utf-8?B?SmVFZ1R3SVRqZG5iczdwUU1mWVZTTTNyWnpleFNVRFprU0doMTJRL0xZTmRM?=
 =?utf-8?B?ZkFWS2J0ODF0MUM4OVRFdVBnaEx1RzZIbjl5eVdIV2RVcXJCSmlJQnNGb014?=
 =?utf-8?B?S0RRU2lLbTVwOVdBdkhVUlJuT0UzYlZrWk5qRkdwN0d5MDU4QXpsaWdxZjhQ?=
 =?utf-8?B?Rit1Q0I2alM4dExQcTBmUFZEbm9zbFZQZzNybGdMaDh0QW1QUDB5amFZdmFu?=
 =?utf-8?B?NjR3YTdRYWpBd1NoWVFlaTBhNllQbUUxa2xnTU9ocjM5bmloMzFLSVNHbVgw?=
 =?utf-8?B?WTJrTXBNRnMyMzVab1RKekwwcmZ6RGljZnJYU2RPVVdkY0tkTHBaTWhjVTZT?=
 =?utf-8?B?c3BlOCtwODZRWkYrN2ErM3RNZ1dFMEdwZFpsRHc2eXpSV1R3eitGcVltdDVL?=
 =?utf-8?B?VHpXY1VFS3hVOG82QWNyTlZOV2pZWjJianhWN3JhVFoxNThXZFR4WXY1RXhR?=
 =?utf-8?B?YTE1V2RIejJJeXIwVXNNOFhoVDN5SFhIVmVqSDdOeWN2UDJqZDV5aDQvczY1?=
 =?utf-8?B?NlZVK3FaYW1BbzZBa0UvYmdGd2xiUkNyUVZ1N3J0Ylp4ZEJ5QWhtaDdmN3dU?=
 =?utf-8?B?SkQ4a2VBQmsvRFdBRzNFeHJlbi9DNjh0ODhHVEhad3lDNmFvUzhZc1puMUtZ?=
 =?utf-8?B?STNONjAwRG5WVXNIQks4WWVyd21WcFJhcXFka1FnZ1dmZWdVa2tYZHdFNE4y?=
 =?utf-8?B?S0xZOWNnNVk2STYyS0VySlBNZ2Y2WDdRVzFSb0I4cnRYSERDT3BoK0laNUdH?=
 =?utf-8?B?emdyOWU5aG9QSStPdmhtZXNPdTJPQ0VSY1pOclFUaTQxWEhXWjVHcDRjbkpW?=
 =?utf-8?B?cUN2YjRMVmVEa1hJVUdCa1NhUjdQaXo0NFZER0laRGpEdVNwMU5JZnFKdkwr?=
 =?utf-8?B?Y2NjV2txcS9CanZyQUVEUUViMG9STFBmTmRtMDNjblRkTGsyUHdOSXVqSjJn?=
 =?utf-8?B?UGNJWjlxOUduejJFYWxSdmg2MHFCOEVNWXltMW1jNGhFZzRWdzhTNkNycWRK?=
 =?utf-8?B?NmYva0k1cFZBV0xTU28xZFFlTE0rOUhLZlVnOXg1eXFBZjZld0YveUxmeks5?=
 =?utf-8?B?SWkzcy9XOWl1Zk0wV0c4SHNzVllUdEpiOXcyT2JaRmhWc2NpRVRJWkdQR2lP?=
 =?utf-8?B?UEl1dEpXZjcrU3lxOTVMaW51citIWm9yNFM0b05uQVRBV1B0SGF5UHU0T2xj?=
 =?utf-8?B?WXdOMmFXajEwZTRBZlV1OUNUcTk5RXlkbTNmYTBYZkRTSi9zd3QxZGlDakNi?=
 =?utf-8?B?Qjd2M2E5aGlpdXNCMkY2Mm9vY2pvMUF5amhPMVZCd1VSb1FzNVVWU1V6dWtN?=
 =?utf-8?B?THp2cTZ1L0o1TWdMME95L1NNL0IxTzhQTDhENGRvZDZoWllUNmZpTXhHVmhw?=
 =?utf-8?B?MHA4OGx4TU0rajJsOU01WlNBTC9DRHc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW80YmN0TXBPZzRPZC9ZTVJCMVdzZWFwblJvNmN4M094aTlVSkxkbnU1ZURK?=
 =?utf-8?B?ZHFtRjBlaHQ4QUZ1UU1Jd1Z5WVhUWmdUY1ZBZzNLcDIzWVo0SDFablc0TVhP?=
 =?utf-8?B?aWdZaW04dmVReVo4RCtiQm5wSTR0bDFFOERoUU5qVGFqMEg2dHhOL2tPRmg4?=
 =?utf-8?B?cjVsckhWZzJiOGpDVHFxNDBRUnliVnkxeHhneHoyUGozcHpmV21NZWc2VnZ1?=
 =?utf-8?B?NmZUN2Y5azFUV2hUVmIvQ1VhY0p5OVYrWWNPRFVKNFNoNDQwNlVyUDNWbG9q?=
 =?utf-8?B?QUdwUW1iRmpwcVY5Q1pSaTEzTDRiVFVpWk5ZWkQ3RGk3KzNWN2pXWGEwd09M?=
 =?utf-8?B?Vk1XcHBNL0lmQmwvb3FzMlZOSzZyWkhLbzhtUWZtWkVzNjltZXhmRUNUb0ND?=
 =?utf-8?B?NC9PNXc4cTkwck0wU3p6OG9lTmdFaWM3L3k0VUFPR1VoZ0tvZ1IxdTNnU1BB?=
 =?utf-8?B?U2g2cXZ0NmEwZEp0bUFYUCtIVldCYmI2alc4dVdQZWlTa0c0ZysvdmJrNmlS?=
 =?utf-8?B?R0lsSlJMeTNaUGs2c2VLSGRBV25Ma28wcUNSU0hMbDJ3L2t1N05SbExGaVdt?=
 =?utf-8?B?TG8rWXcrdzA1M2w5aC96OGVNSzVvb0xsZlBXd0ZBY21iRXRNS1g3YVVWVkJV?=
 =?utf-8?B?OENIZ1FOaDNleldQbUtzZW5HTDFkWmVhNWt1aTRwUVNMRi9DUENsN2JvZFoz?=
 =?utf-8?B?VnE5WTVXQ3NiT2R0WmxjdXgwTDVJQUZjdnhIWHV2c25PQ0NuL3MwYktqYmZT?=
 =?utf-8?B?YjgvcjJnVExqc285cFhZVmdWaFFnKzA3NmFhNC9Wd3FiR0QyREpQczU3R3JG?=
 =?utf-8?B?TmpjemtSV2liSEZ6TmxpWnJYcDdpMVlBYkpiT3hnRk1EZjhsMUxuUEFUdExV?=
 =?utf-8?B?TUhWdlRHRUNQSHo3RzJCR09WbmhNOGlRaGlaMU9vMmNOcXUvSHpzWlgxSU5i?=
 =?utf-8?B?c085ZTRMQVpMejRod3gxbndjZXV2UnJpRHlxMjFNaVJVUWVpL1hMT3RCL0wx?=
 =?utf-8?B?d0RMR3k1MmNaVHBxcnNKNFFqQlJPdm9WVm5XbFFQZW9WZ0U4YVlqaXNYMWt5?=
 =?utf-8?B?NUFCZktCa2NqbHpqekZ2bVA2S0VGYUtpbUpKb0RNUTY1Ym1CeE5qOWdKL2dm?=
 =?utf-8?B?Zkc1dlBHT1M2MmEweEJrQnYrNG4vU0NHTUNZeTVTMWhRcFl2Q283NVAyUjRU?=
 =?utf-8?B?d1FTVndsaDY3aE1aSjhuSkNzTFRWc2VHVnpSaFdGUmhVcHhjdjFjM2pLMXFE?=
 =?utf-8?B?SkZ5OUUxeStDNWZyaSsvUTBBWkdPMFZyd1NPanRVMGhHYWZYVTZwK2picGpE?=
 =?utf-8?B?cHliMFppTzczTTh3UzE0SGVUaGxaQjhoQi9EVGdqcG90cXhVZlU3VDFvOVRx?=
 =?utf-8?B?RXZ3TXRzVHRDWTRxNm9UQUdrOHR0eVdzMXZFNTlHMXQzd2l6SEoxb0Zhc3hQ?=
 =?utf-8?B?ayt6alFNUko2Tk1LSEpaM3lsQ3ZzeTMrUDU3TlhMVHVFbHFaeGVKVWhtdnJT?=
 =?utf-8?B?K3VlQnl2ZDhRNDJwa3k4ekFvYTdKbllyMSs0V05NSHNuQUJ1RnhjZHVqU0JO?=
 =?utf-8?B?U2dJZ21rV21XWXQxQyticWJ5VW1lTXFNUEloTlNYNUl2MkJmRzJpcWY4c0xR?=
 =?utf-8?B?eHhZYmFFVkxxNjFQeE40ZkV1OXBQRFlVSmViOEl6L0VQL1lKYnZuNU0vNEdP?=
 =?utf-8?B?Mk1Xd1lSaHpEdTA0M0FTTjMyL3Z4ZjJSaHgxNDZpbVdpRldWc0huTjQxZDhD?=
 =?utf-8?Q?rff7wTRxezEwNpLtuJ8HDZ3HvHmMneYF4BPoLMf?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 151407a4-f457-4a73-4b4c-08ddea2b1fd6
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:15:10.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2105

Hi Yao,

> Introduce reset controllers for AP, MISC, VI, VP and DSP subsystems and
> add their reset signal mappings.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

/* snip */

>  static const struct of_device_id th1520_reset_match[] = {
> +	{ .compatible = "thead,th1520-reset-ap", .data = &th1520_ap_reset_data },
> +	{ .compatible = "thead,th1520-reset-misc", .data = &th1520_misc_reset_data },
> +	{ .compatible = "thead,th1520-reset-vi", .data = &th1520_vi_reset_data },
>  	{ .compatible = "thead,th1520-reset", .data = &th1520_reset_data },
> +	{ .compatible = "thead,th1520-reset-vp", .data = &th1520_vp_reset_data },
> +	{ .compatible = "thead,th1520-reset-dsp", .data = &th1520_dsp_reset_data },

I believe these should be alphabetically sorted on compatible name.

>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, th1520_reset_match);
> -- 
> 2.50.1

Kind regards,
Maud

