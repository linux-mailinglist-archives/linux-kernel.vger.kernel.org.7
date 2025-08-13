Return-Path: <linux-kernel+bounces-766321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C8B2451C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B2C17C5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A72EFDA9;
	Wed, 13 Aug 2025 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CUBybRtf"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B61A9F94;
	Wed, 13 Aug 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755076594; cv=fail; b=TeM32bBkIzzMmf6uaUj72wc/OrZ2d+b/sKUZKwTDYNCXYCnzMTW2bLjnfQlV4rhel+pMhg8t8nwJYUiKcm62V13VaAAYh6WnGM+EVcquP5N782lHUq3EsrD9/3a7it5UWqQhTXGcDlixIzPpsshGtoePs41waORS2nTSrhNCkEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755076594; c=relaxed/simple;
	bh=GrAofSermi3SPZ/+MJrlP2uMysXPCFWaCTyjVlMog0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DFptm+Er3+SACKZJjX0JqDoAF336D2v2jvi/YO3gnfxUr+ms5RiIN3oa+n219Po6i1CWYvcDuAXK+p6kICIkkIApnjMr/Xa8sCVIUNHJXS1zfXlnApJ0pdSn2I8+3IIRH274Wx96Tf05PBRYR1QeSy+p70yuNDFRf8WTsh3TIZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CUBybRtf; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1AX7udw+aLTPRXLRwk+ingch8x/iBT9dpl2+OupIcJ7ZsT8E01PDKrwxTdmL1aLlebY0XPHjbESCjlohbkLqmsix1ECYN0hKTZ5+DQJYx/2sFG8dOEyJwP+Q0Aqw6KrWETRw2YEr/7Ef7kCBAH3RAn17Ue4oxQbeeuW9A85wqLxbdfU2H5GdtOxB39uxQcr9UkCI8ESaLpmzZL6tRvjRnRvMKkjzGM8Ha4AmsyMCjpE2QNfgrocNXmCHHPUv0NaNI/B8gHjped39zcCUj37McVU8GJs7yKtrfvz9mx1PMm648AuHXH/KZ1ZPu7yXIo2x8uDG32KqZu9rMdq8kNcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Or+ckiNZBYwkgRTfUWZRJUm31d4RsPNf/DCV2UEajU=;
 b=EfortgpwNnCVx2lWvUEBEi2yS8srpuOjS3KmeFZH7JDgUGqUEyWBf5KfOlxeFv8FIE8soQ/NVKNiYXflG2b+cnr8nXmItjoFGl/juoUMtV8PFzlYSD+1UPgN1RjlV74B36bxR3DWbsMek9H4DDFYuci6ewpcW3Y/NsxSFeX9r6/vJSXQ83Sl5Wr5S+Ok+Y+MiYyX82jD+TVSVZA3vpwAZ5hJZnYYBnKgEtv4dwqufvRdrO2WS7qIczjYlMY8oRvxFriaxlj07Z4tiYpeREMEjnYVD1w7Vny2Pchjpj3/tpCI0mwpMpnqgtVAi82tGxQm5RqHJlyWGrovgdjIAWT1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Or+ckiNZBYwkgRTfUWZRJUm31d4RsPNf/DCV2UEajU=;
 b=CUBybRtft3RTd1AmOTI2c2fXU9tm/AwSxctMmvq5I1p3KrOBqhX48ZZUEeyp0V/cf5qjVOZA4i8GEj0W7EVtG3YB35W2nxgv+Rkf11puCA2m31o5wQpZNpYP5qxAui5xnaaC3HN6gos+ufaJee1PFssavLcqaFNYAVAnA5sBq100A5V3al3onLlEO45s3PgaqhY4sO+vHQ2KzoyKDP/jxu8knbkiLmeMl0Gg7CprGjGkJYbRNQkLoQVs7B5KyH6Gtuca1KdKIgIyZS5pachl9d9xTjYh7Ai0GVzUg6f9bv/jgJs/QGwUjd0v1tesvh3pi0HKLbALO/7ttmD+W1THCQ==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MAXPR01MB4422.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 09:16:26 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 09:16:25 +0000
Message-ID:
 <MAUPR01MB110727C208BC6E8E94821982BFE2AA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 13 Aug 2025 17:16:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add SPI NOR DTS node for SG2042 SoC and boards using
 it
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <rabenda.cn@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <61bf0288-699a-42ed-b5e6-db53a75d5f04@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MAXPR01MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e2f0a8-94a1-4123-895f-08ddda4a13f1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|19110799012|6090799003|5072599009|15080799012|10035399007|40105399003|4302099013|440099028|3412199025|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEozcFY4bmJGS1ZTeXVld0hjT2xaOVRQWkRYWFQ1QUZ5bnMrdkJoMGlkbGdy?=
 =?utf-8?B?NlBGdzIzUFFoR29lemdWaE1OSDhySERXU2IxUG43OXY0cXRKOVVNTXlCQlRp?=
 =?utf-8?B?T1E3OXJIcUxMVXQ4QUtNYjR3VFVXZFpTcDBuM0F2UjhIa2xQYlRGRjV6Qk5H?=
 =?utf-8?B?eEVXTmc1ampXNDE5aUJnakw2V29tQ0JlV1V1QWw5Sy9zalNHeVFjSlVqUS82?=
 =?utf-8?B?c0NVaDNCZldWMXB3aXJuM2xkeENvK1F1ZHdac2ExZ3BPd0lBZXFzRDFzT25l?=
 =?utf-8?B?OTZybFJ2RGE3M2g4bTlGdE42UEw5SVpBMTJMUlBWeGpmTTFJcllRQ25RSmZJ?=
 =?utf-8?B?d0IvbTZuMlJkMzZjMmwxZ3VtNmZuNmhUTGRnYjhsbmxKOURrT1ZNR0VxaEov?=
 =?utf-8?B?WEZUNUVnWm9vSDQ3TVRvMlpJZ0VCdGVLNmJYSGlOZGdHRGhDWVdlQWpQRmNE?=
 =?utf-8?B?eWZ1TmpLb3FZYWROWEZwTGdRZ2RvT2tMRFlvOFllQW5JbEhJNFFDWFZweCs3?=
 =?utf-8?B?WDZ0bVUvdVJKUkF2NUxVenV6a3VmTFA2cEVuRmM1VHJ3UjAraGwrdmg0cFFv?=
 =?utf-8?B?VnlWSm03d2I3S0swQXV3WVdHcXR0RG1JVGttRlZkQUQwYUl1Qms0dFNGTi9F?=
 =?utf-8?B?WTBkK2dUNnJQbkN4MU9Ud2JlamwxbUZSWnE2VDlNUXIwRDlCQ0lZZ1ZsNGVN?=
 =?utf-8?B?N2hXNkFWcnpha2NNaFRLWlVBaVdxRTFwemJZejVYNTgyYXc1SGFaNTYrMkRw?=
 =?utf-8?B?UklrWU01WkxhU04ra1lhQUZCcmhDVVlvTEhZaXZQbTZsTXV2STBDcHRWazB1?=
 =?utf-8?B?M1Q4V0FXV1Vjb0duclVjMFpCVkpBTXE2VkdaNUtvc0ZTQzFzNzlnZ2xvS09R?=
 =?utf-8?B?c1RIVXhTdmY5N2J5UlhWQ2JIRVlIR2lVdXFCRkZhSnJsMEVzQ0xTd00wRzk2?=
 =?utf-8?B?MU1naWM2RE16a1c1d21NVEhaVG14dTJSbUVVaTJmQ3M3aHVaNS9oOFdaUitO?=
 =?utf-8?B?b3IvK1VFTE0zM1lRSzdQdnlocFlkaCt5Vmh6eFVDZDNrdEt3YnpwV01LbDBx?=
 =?utf-8?B?Mk5TVHhZTklPdzc4eWxNWm1LTUtEV2YrN2dvbGVFSVBFQXhDb3FmQXE5Mlhx?=
 =?utf-8?B?emhYeENleFl2dFVkTncrWmNwU1ErY3o4VklxWVhvMU9BWHFkSGJoNS9wV2lH?=
 =?utf-8?B?ZWZsR3dYRlZxaWhFMHRWU3R6a1A1NDdRVk90eHZIRXF6eCtkNGV3dnZWWEpj?=
 =?utf-8?B?Y053cEgzQ0J2bXpxNi9ZUmlpdmdIUUdra1VreWxOamlaZ2cxWDJBN2d1Zmwz?=
 =?utf-8?B?YlNRUml6dSt1QWV4VTNGdTd6VllHVkV6MS9FYWdaejQxZngvc2Z0UHBHSzlx?=
 =?utf-8?B?VnNlTHRmK2psYy9qa0ozdmFHQi8zQVo3SFZzelRYbnRpQ1IydGt1RFVPTFdz?=
 =?utf-8?B?bmw2TlY5VHdaUGY3ekhkS2xCZndwRnE5WVdEWmZxV3lUTU1jMXl4Yi9lQ3Ju?=
 =?utf-8?B?NDFuL0NqUWVtZHBZUkt1WU9FczMzN2FuZzliRzFFLzkwdVR5NDlhNExSNkhX?=
 =?utf-8?B?cXREY29FZjdZSE9qUXVwVUNNbS9UOS9qSzd3SVR6N0V0dmNlWG9vdUpJS2pZ?=
 =?utf-8?B?OFZLbEtWSWlzRWdZbDdGcENqL2x2NkkzUVJIUGg0YWMrV3lCSXdxcHd2YjJ2?=
 =?utf-8?B?ZUsxWGhESzdEcHREM0xkeXNML1BNdUpYbWVneFF1QTN4UlJNNTB1dzRBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmxGalpFbGR6NHFXN24zclBJeERiamZMVm1PdlVGeDNjZWFBTEpKZEFxZStB?=
 =?utf-8?B?NmREU1EyK21XQ0N6akJWYmJXMUczdlpNUjRVeTBKVWRFelZWYnhRdUFsZ3hH?=
 =?utf-8?B?QkY5QVU4ZWtzT0w1eEdGV2k0enU3RlFjS2pPa1cwRit3WGpKOVMvRXpPU3RR?=
 =?utf-8?B?dm1WNlZFMEM0MnI3L3cvejczc0JWUVpnN0o5SnVSeEdxbWVVenE0bTZDWmdz?=
 =?utf-8?B?VUl2ZmFhdHN4NDVQaXB6UGhVdGFxdGZLbXVmSG5JZnhoR2l3MXBvbUNsWEF2?=
 =?utf-8?B?aU1DUE1OK1htVWRzbHdrYjRTeE1xc29PT0t1c0MzOUVkWm5MbDQ5eks2UWdV?=
 =?utf-8?B?aEdzc3d2aXNlQXdNUmJmSU5SdFVGS2I2ZkE4a0M2WjRRZ25DS1I2MDFuMmZE?=
 =?utf-8?B?STlkL1dRQjBOMExvYkYvVXprZW9jTEQzNnkzTkJVWDVVam5mTm9GT0RwclYz?=
 =?utf-8?B?L0xjdDJ5aERiUkkwVmRTR1loenBmTnJ5WG1CY01UQkJSbFVxTk1DQmNibVUy?=
 =?utf-8?B?TnZ5QlVvL2RkUUZPUnBhbkQ4M2RjYWtkS2huYVBLSFZnV2p1RU9HVmJPWE5N?=
 =?utf-8?B?THhyd1g2R0I0VUhFb0QzZmhJbmxxR1gzM1BCdEFkOWJrKzlHcllCTVhYU2o5?=
 =?utf-8?B?ZmM2ZWUzN096WTRzU08yZmZ4dGdVQXh4cFQ2TjI4ZGRTNjlvNGsyVTdWeFNY?=
 =?utf-8?B?QXFtb09FQSsxMXJqU0dVVUZTWk40eXdvRk9KM28xUHcxc1NTWFc1Yk1vTHpw?=
 =?utf-8?B?eU50WDhnWkdYdlRER0lLMi9ReXF5c3J4b01qRWJzSnJzNjBsaXdUVkJ4MU9t?=
 =?utf-8?B?TUxXRFhYc1IxcFl3Ty8va2xVc0ZEOG0vUnZFeG1qdlY4L0VLZ0F5Q1dQME5H?=
 =?utf-8?B?aDJaZjZlRWNMK2h1Uk1ZeUx3T1MyK1VnTnB4NmdHcVZkYlY2QXhCUndXeEdS?=
 =?utf-8?B?MUVxcHZKZlF4d0RQTHU3aFpJY0FURmQ2YUVjQnlJVlFqR1hLVStZc2plUldM?=
 =?utf-8?B?V3pZT2VqdExTVFlaWFNxL3QxdUlMUnRLanVGT3o1aUFJMEwwZk8wOC9qdWtk?=
 =?utf-8?B?bjRsQW9iOTAxZVFSUjZoRDZNVldubmtGM21wTW9SeDZPVW5mZUUxOUYyQ002?=
 =?utf-8?B?S2NnMG9sektCRlFPbzU5YWNOT2drSnFpQ0ptZ1dyMS9vY3ZmZkQva2I1T0dD?=
 =?utf-8?B?bERhcFV4M2xINFRZT3h0OS9mRTZaYVRMMmcybDZucFBlclRKSFQwZ2ViSU55?=
 =?utf-8?B?TVFrWlRHaS9wNWZXb3RHdEpYbU9CYXprdE5BSFQweFU5NGw2UUE4K0Q5ZHVy?=
 =?utf-8?B?RDhmM0hUWENFQnlRYjVsUUxTRXE0MUpkSitaNnkvenZzRWhwNVdhWVpiSFBU?=
 =?utf-8?B?L1A0QklyN05GRUlwT2FzS1BDdCs3TldZbkVsb3NQeitNVEFmUUlUM0VsSm9u?=
 =?utf-8?B?cEdCVHMxYUQ3STFpUkpZZnkzNnlYMFIvZlo0WGM4alRaZUdWeUJERW9IMTJ6?=
 =?utf-8?B?dWtSeWdmZSthM2Y4eUd1NnAvVFFoMWo4MXY2V0RrOE1xMnlFVE5wTnRLMk1Y?=
 =?utf-8?B?QWpibnNyL3BOQXdiV012V1JQelFnT2dqRXBkdFdzOEFxRlBiNXFUV2F2ejFG?=
 =?utf-8?B?RVpnc3ppdHpvNlRFOGJpRUFWdmUxeUExY2dkazJ0N0E3K1ZJUlJaeVo3L1k4?=
 =?utf-8?B?eDgzdTUxZ244dmxsL1VDd3ozMFhIdTRaR0dGOFh4UUhpVkJIU3F5Ky8rVW00?=
 =?utf-8?Q?a2YIJL11Xq7evw+wjH+aVcuKDOdJ3B1cirlZwD9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e2f0a8-94a1-4123-895f-08ddda4a13f1
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 09:16:25.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4422


On 8/13/2025 4:33 PM, Zixian Zeng wrote:
> [PATCH 1/4] and [PATCH 2/4] are copied from patch set [1]
> [PATCH v4 4/4] without content changes.
>
> Link: https://lore.kernel.org/linux-riscv/20250720-sfg-spifmc-v4-0-033188ad801e@gmail.com/ [1]
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
Need not SOB in cover letter.
> ---
> Zixian Zeng (4):
>        riscv: dts: sophgo: Add SPI NOR node for SG2042
>        riscv: dts: sophgo: Enable SPI NOR node for PioneerBox
>        riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V1
>        riscv: dts: sophgo: Enable SPI NOR node for SG2042_EVB_V2
>
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts       | 24 ++++++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts       | 12 +++++++++++
>   .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 24 ++++++++++++++++++++++
>   4 files changed, 84 insertions(+)
> ---
> base-commit: 8a4fdd09c96f6713e6cb47d36e9f9dd6f6694215
> change-id: 20250813-sfg-spidts-ee56044969fe
>
> Best regards,

