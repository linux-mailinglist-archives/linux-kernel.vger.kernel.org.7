Return-Path: <linux-kernel+bounces-759122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719DB1D8C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EEE1AA4408
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2C723F40C;
	Thu,  7 Aug 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EibNamFn";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="qkTAnFmG"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB67013FD86;
	Thu,  7 Aug 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572574; cv=fail; b=OQdPYBWhyJOTUclkWOX82chuTw33phVH7Q4xzmtSx1ExniANFb49f6jtzj0vi8phvMaw6tCI1aLL4Fv7fTMH74uHh4oB2vXZbOU8KaRxCHix2WJHwz/JsPIxRLxviMvpvk9YuKww/I+zChvgNS6c7CNMq01BbgIc487Z/ghhDq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572574; c=relaxed/simple;
	bh=d8ygnZ16KZ4Xu9/Bp7s9SpAX2im5CnKvtMnFHT40bs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTH2U5tkrbrsSD/+vD4qO8/F27EjtJRC/tvwLgH0zmvZ8ofcV6n51H4wIB89J456W8WJstTNMyRaqOob6fXHh5nW7eAc/paoLhiSK6uIGaXhtsAYkkF4GmVXiBSVXgNilRPFOW4tYJYTx4VndYkQ4R0T2a6/EKHF/6h8d0VJDys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EibNamFn; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=qkTAnFmG; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577AoWPI024694;
	Thu, 7 Aug 2025 08:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Oe6rLdidTgVK3hL24ozGkDAIk/IsLPwb5xflBmj82Vc=; b=
	EibNamFnjCIzy4E0Q2M05kQ97zVp+TyVSlgoskL7VuHgoamamB5ab5Jd0X0Z7nnN
	dKVjrC+KRoTh94rlmqz6K4atEBP+JnFgbTW/hWuZvTEUI3w9s9r3f51QcwmIC4ZQ
	MHdBmEubRAIuhDotzRW2BY4zOltjfARlFZpnUcns2vEqhkTRU3Ilsdg98Q/5ZOXN
	WlAyZ9mCn3G3iVFJ1GevZRJ3MwqJF6xY1171edP+RBsSXm8QqFiU4vfPnx9htXKP
	8EetAAEUS6x66iI/f6NaUeA+2hqSWqy4UUJ7vftYlFG2PDNz5iNlOBssFQufSbeq
	qNl85BejhKqiAsNy0dezWg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2124.outbound.protection.outlook.com [40.107.237.124])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48c3m52eja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 08:15:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z92P6YMFm52GGYrSKW353xHH60Ps+J5fPL1NrbScT4t09ZfZ1Mh4bFrA0Y3aHKDxN5S0PoUAICWj+Bln+79nJR8l/j0hLUdE5VwpNKVQawuaizR0MJ5A5/jwwIvCXifR5WxrQAJtK5xAknrWcrlnJtOCX2Yk2kxBhhovoHhcRR9m7zkLFDdcYyDHJmwjCO9AbzQBOcH87jpopoJoswGOVvqJKAVJGNMy3z8CGcqit7A+qxODayGXvGj8ZRv1c5k5XQWd/biGw3M0DI9ChqujdnOPOndYGX4T69Kz02LtINbtUDGqbdXiXoDaPPMWdFopeaAPddalfXzad6aPT1wskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oe6rLdidTgVK3hL24ozGkDAIk/IsLPwb5xflBmj82Vc=;
 b=I4fdKoYF86w6FXGeBhluUWF0kXRuFFGtSiZaP2FJqox/AANoCpjzKWLzebkOULo2hl5//QKfeTdArKGY0UdayJt3gIx0YoVME1OLnRr5M79shtwQWtDEx1pmg18enNr/QyDYiTQBnLR+bzJuVhftAvG8ClQAXhd9H+0+FNyOhJRNRjbdRsm2j3tO/XUkkIHmAhBbCgwsZ6DlEtrY3YuDXu8BoFd6Ro9MKqKp83qWdDpTg56LFPcKG8cofnX5UJZrjjw/uR2Xrmc9jhCw4dBKav26lrb4iHvDdPH9iAV62CHCqUgcDR8T5tNWjuSYD8MjVqQuwroXDA9Rzb0MkVCLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=arndb.de smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe6rLdidTgVK3hL24ozGkDAIk/IsLPwb5xflBmj82Vc=;
 b=qkTAnFmGVf0/W6/oeEIfJx6f8+3l2+2ROkf64TumhNXz9RYzRdC/Zb/B05BCrNEomaQdDyuJdlXmcZs/3cZrgaIY/+z1Y1YN+MrzUOF6OJ9RwNevN+T0Asd4ktFKyU1BFLckIGHD8K4mYhbI9LWCIhFpyjelqUILtKRfvpF1P/c=
Received: from SA1PR03CA0018.namprd03.prod.outlook.com (2603:10b6:806:2d3::29)
 by CY5PR19MB6339.namprd19.prod.outlook.com (2603:10b6:930:21::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 13:15:45 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::d8) by SA1PR03CA0018.outlook.office365.com
 (2603:10b6:806:2d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 13:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Thu, 7 Aug 2025 13:15:44 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 1E4CB406540;
	Thu,  7 Aug 2025 13:15:43 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 02873820249;
	Thu,  7 Aug 2025 13:15:43 +0000 (UTC)
Message-ID: <1e7d772f-f4db-4202-a9c5-6792b37c3d26@opensource.cirrus.com>
Date: Thu, 7 Aug 2025 14:15:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: madera: work around false-positive -Wininitialized
 warning
To: Arnd Bergmann <arnd@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-sound@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20250807071932.4085458-1-arnd@kernel.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250807071932.4085458-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|CY5PR19MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a119742-2bc7-41a9-9d11-08ddd5b48439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|61400799027|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitITHhaUkhDd3Juc0FSeDc0VjR2a1ZsOFB3R05jYjhYMVlXbE1vdmRmU3Vz?=
 =?utf-8?B?WDVCT0owMVB3K3BGRmdWcjJMd3pVVTVsR3ZrYUsweW1FZDUrNXVtMitaRHlU?=
 =?utf-8?B?TFh1a2NlMW1DMVJNVHhUeXp3Y2p3K1AyRHBqdElWSkhSR1EyQ0ZxRnRxcUFa?=
 =?utf-8?B?YmFqZWU0UWFobjNTOTBkekU3N2EwdHFTQzRnMkk5VVQwR2t6NHo0SzN4WEVx?=
 =?utf-8?B?bVZCZWJlUElBWmJLVCtHL1g1bkhPdlNTcHMxbEZ1bkF3ZEtURWJoZHk1ZU0y?=
 =?utf-8?B?NUUrQzcrRFU1aE9mdDIxR0t1d05sMi9NL09uODZoa2xJM0tUREloNHZLZnds?=
 =?utf-8?B?cUFHNFFUUFBtVzdqOWlZMEkxSjAzQW1OeUxLOFd0N2o2emtKSHcxL0JCU2tv?=
 =?utf-8?B?RzNVSzhkRWJPU29FRmJGallwT1hNeGxUZXlYa21BRUNRQWVXS1FqU2JDZnhG?=
 =?utf-8?B?MUhMNnRMU1pZRHJkZllvaENJRUpTUFFoM1ZDOU1ySmZLNUZHUzcwUmtRV2Yv?=
 =?utf-8?B?TFJteWpGTnQ0eDJ5Nk1oNzNuN2ttZHp4aUQ3R214ZENCTTJMZ01hLzYrbXc5?=
 =?utf-8?B?WmhrTlpzVjhOUjRrWVIxZ0YyR3RIQzExS09lMlY1OGhMb3IwcGlKU0lDazR3?=
 =?utf-8?B?azNuMGJlZkZuV3NlNTZVY1J1ZHZOL0tGWmZmOEFVRmI3RGJWY0N6bXZzdStZ?=
 =?utf-8?B?bXhxak9vOWdtMCtUN1FxdCtqK1FUL1U3V0xVNGpSYjBHajNHOEtyeUNydCs2?=
 =?utf-8?B?MmVuS2c3L2toVWw5OS9sblBqTzBDQnFTU3h0SURzUHVZVUlkN3JicElrUkRx?=
 =?utf-8?B?dUFJR0tMU2VjMklXQWNjblNuN2dKaFhDL25jbkJ3eStNNTB0b3RJbUh2L0dM?=
 =?utf-8?B?bEZaWkpsYkw2WVAybVc5VTJvYVV4cWo2TjIrNStpUDJaZ3NUK0draXEySXFU?=
 =?utf-8?B?WmdwY2Z1VlVVaXUrcjVmNXJzZ2VNYTRrQVdydXBpUUNwQm54Q3J1dTdzTHBV?=
 =?utf-8?B?UTcyNlNKWDEyQnF2RGVwWm15VkxaTUFqVmo5SU5NdFNUcXFKaUszeUJMWnpt?=
 =?utf-8?B?WXQ5b1RXbVFuR2xjcUluL21NdGVvQ3RMRnVZUmVCRk1VMXNtUCtBSFhWeUJx?=
 =?utf-8?B?QWZ3bDFtM0lYVGVEOVkvY3pRTkF6aXRYejQ1cXFaRDZDNHFlL0hLS0tZdnp6?=
 =?utf-8?B?OHU0Mkt6NzZXL2dUUmZYWEx6UzRzL0FRazVITDVUYkZJdnJXWTZEbndMWkRC?=
 =?utf-8?B?RDNEblZET3NmVFY2SFJzdHFmVXhmaVorZ0RzcEJqOXBQaFBKbk5HV2hkYVNw?=
 =?utf-8?B?Z2QveEM5SENYRUhJcTYrWHIzTm11M1lVSmpseHVUNU5sampzL0pabXpxMDZo?=
 =?utf-8?B?L0x6SjRYOERIcjlGVzcwamJjMFUxRit0djU0L1dwTW14ZVZVbG04ZWZCVllE?=
 =?utf-8?B?enpRUm9IcC9LQ1h6Z3QrWG03U0tVRHpxTmY1eVJYZmEvUThMRmFUTkxNc05E?=
 =?utf-8?B?d2k4Q2lwbE83a3Z3MVJmT0RVV0JWK2dPcUNxOE9TL2JUL3pQa2VYbmRxRm5u?=
 =?utf-8?B?TE11dW1WU1RmOGZpVGY2MTNXdjJYd2V3dklpOFpJREhxWCtPQWdTcFRxTDN6?=
 =?utf-8?B?c3dMUE4rdUI0UVoyNUdPN2tBeS9ibGF2cWRwc3RuNUdNbDRWbXNRVG5qMm5m?=
 =?utf-8?B?UGxnc3RBaXdxYnBPanMxeXYwZnBuaFliQU1lbDlhVmc4Q0U3WTc4WFFnblBv?=
 =?utf-8?B?TTBMaUEyZUhuSHA5OWdGbmREZHk3U1ZiQmFySlM0dXJsbFJvUFZJcGRqQmFU?=
 =?utf-8?B?KzF0Z2NMcVlJcFBMYkxFT3NYdHU2QmZRNytqZVRSMTBUMmhpMG90OVY1a28r?=
 =?utf-8?B?bnNhTVE2b09FM1ZlSXNsSnlFZERYWDdOby9MVGRSY1MrNXhyUFVQUld0VDA4?=
 =?utf-8?B?L2xMMElDZmpYRFU1Wlc1bUJxdUNNeEpidWoxa1NWdEYyUm5Ga3hPS1J5cUlB?=
 =?utf-8?B?OFVMdkx3b3hJSlpQb2dmK3ArbThRMVJHaWdJQVBIcWZoWmx5aERsUithZHgv?=
 =?utf-8?Q?fP2gU4?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(61400799027)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 13:15:44.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a119742-2bc7-41a9-9d11-08ddd5b48439
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6339
X-Proofpoint-GUID: n8q7axAr2KM6hiCVbNGIgnuTD-taG-cD
X-Authority-Analysis: v=2.4 cv=W/A4VQWk c=1 sm=1 tr=0 ts=6894a703 cx=c_pps a=Bx4JecnaPChsX23rVfvkjQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=voSFIoK9SR7PB3qk9MUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: n8q7axAr2KM6hiCVbNGIgnuTD-taG-cD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA1MCBTYWx0ZWRfX+3PLYaqQo6NE XNdxTkjqiM5hgvfwxFaBq+wLbDaNTvtZ3kROCp/8S1dAhFT+uWVx2ugXA/JSBMEdwrUqcXpubEo IQ3eGvbSOOJKS8rjpSdSeeX4TFM5qnyjMD6EdUWiDz/DMwDOUUB8ihZkjt3kljBNhf1n5XeZKx3
 2ZhaI0L8OV332+W5dNJiPLvjur8UaY9dVa4mIhFFJYGLNoNh/SHmVD+2B9YlTR7gcEDF3uD2nzj BXM183C5MbMa/XRhZgpu7CIcCwU//WSTlEKrx8iFZFZZhLcdSRtj6bX2NeBE2ZZNZq2+dodfXtf srPf55ZIlLCZ9M4BDhdIiYnxdAo5ezY9dO6KE4C9E29wZeoefRnJfGyUh03sH4ME08cpYW8d9zn 9jUJAsga
X-Proofpoint-Spam-Reason: safe

On 07/08/2025 8:19 am, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-21 warns about one uninitialized variable getting dereferenced
> in madera_dev_init:
> 
> drivers/mfd/madera-core.c:739:10: error: variable 'mfd_devs' is uninitialized when used here [-Werror,-Wuninitialized]
>    739 |                               mfd_devs, n_devs,
>        |                               ^~~~~~~~
> drivers/mfd/madera-core.c:459:33: note: initialize the variable 'mfd_devs' to silence this warning
>    459 |         const struct mfd_cell *mfd_devs;
>        |                                        ^
>        |                                         = NULL
> 
> The code is actually correct here because n_devs is only nonzero
> when mfd_devs is a valid pointer, but this is impossible for the
> compiler to see reliably.
> 
> Change the logic to check for the pointer as well, to make this easier
> for the compiler to follow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/mfd/madera-core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> index bdbd5bfc9714..2f74a8c644a3 100644
> --- a/drivers/mfd/madera-core.c
> +++ b/drivers/mfd/madera-core.c
> @@ -456,7 +456,7 @@ int madera_dev_init(struct madera *madera)
>   	struct device *dev = madera->dev;
>   	unsigned int hwid;
>   	int (*patch_fn)(struct madera *) = NULL;
> -	const struct mfd_cell *mfd_devs;
> +	const struct mfd_cell *mfd_devs = NULL;
>   	int n_devs = 0;
>   	int i, ret;
>   
> @@ -670,7 +670,7 @@ int madera_dev_init(struct madera *madera)
>   		goto err_reset;
>   	}
>   
> -	if (!n_devs) {
> +	if (!n_devs || !mfd_devs) {
>   		dev_err(madera->dev, "Device ID 0x%x not a %s\n", hwid,
>   			madera->type_name);
>   		ret = -ENODEV;
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

