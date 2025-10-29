Return-Path: <linux-kernel+bounces-876306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E11AC1BB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DFD6662C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41272BD5AD;
	Wed, 29 Oct 2025 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="duHM/toJ"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48B2BFC9B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746400; cv=fail; b=u5s068Sxyw7RUz8gT0wnpCLS+zrPDV8YkOTArTjYYlzzcVhkH6IJCFModDtDR+i9mLU1mHCG2HkkE2rvzaJB0e+HNIjSO0jyC6sPx3S39lcfDXY4+MMCn8juATIeEpnB0ACWOUP5z55QzNMbtbWm1fxYvFIE7W3GDnoyNlSEEsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746400; c=relaxed/simple;
	bh=qXYNE9PeyjO6Ib7nAZiKeix97kxgOJhfYFXWydj80t8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=che+cLp+buxP3kl2MfkCSGjo+TsMU7dzeBKd91D/Qt3fga7bEIfSAyetct/NVWpI0xK0+s5EP6AUF78pA4B6df5kdqdsz2aPIFJAHWzPn2G3UwfcVF5mVcSYWOjrsWSgxrSI3/fQSx8xkGypInJQuSKeWmNPXlyhs7XtqWOOk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=duHM/toJ; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grJuv6nbMqp0ZBVRRO9pBrU09pffzGsLwfHFV0Pa2JdVgeeMvQnRwT85IsSz5lf/jiZKPA2w04zjhJpE8ovC9Gc8GMfvQ8t2OSbKd5qbAYcjVRHvx7aZ1sVeL7wz3NlIfbv/KlDZOSdf/rsSkdA5LcnJpF3Q3yJTKho7q3lEFTbDJK8h0aX1SUDVo1cOjwi3wHdf9XJ36oUqZZlPnUpqrI3K3+lKuI/yGbw3jPOJ+iCNsB2G9+wHGKfec4fzCsc7AL0egaFzjmah/OPl+soduUqMoNlUx3NhNj5Hv82GkZbxVHuIlezzMeiSRjud8/k/MLoYzEzuS9jXCbYVUSVXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc0QzzoKZWLvucTt/iHroS+l5c8OdL5hT6fkSg2rEhA=;
 b=uANj5Qc27die5eHMUc7zMCRBnrdLU2XYkAHpvQXWxMGJI5fyOsLu/I3faxWLAO0RnrJd7IMiXslMTbVV4q3v49cxBlGoKwnmt3DgUJ797bDvX+Y2BOlVSMDlr6amZurLf0Di8kiiTt+xsOOZk3ZZbCzw9TeQ8i4o01XEMogOeY5WioIMtgL6EdpDRXjLxVTKqy/7/m74p+Ank8JhWOMtnLS47PYVOWOcRiuWq+XRFcn4N9M6zMggspIU+mc/fZVgiOmkuVdrQUd5VKNP5mzVcUIQW7HkNxGodVFmteG8WGhmklSLX3NP69c1TuVlthb9EKL+Uto4orpht0v9ArZ67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc0QzzoKZWLvucTt/iHroS+l5c8OdL5hT6fkSg2rEhA=;
 b=duHM/toJfw2fGN+3TlpcWSM8zSzW01T2spyp2tcZzdA64ACVifmi0PUWMa2oiN5pNfv5P7RrhNyuJOewfkWdifnoe9bdP+j1ka5GlxTfh2HpdBImoCFqjXrSRRU3HZU2xTTJh77zl2Zztcs5J6QhvI764r861wwpM3fZWx9LIQ/f1zIQaupgrvleZiS0bPtja/iryTlZ6LTFEG04DPPStXKm9RonU6vT8Zqko6fuavCZPaHA0OPj2zjRavbbqi6EB6DzW1a9UJuE3bRwSIVYPXzhaexo1BDfx0KY6Tnr9E1s01JPKGWFx/OHxpMOpxPSYT1zcQU9CJjzk+Pm0vEpjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 13:59:55 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 13:59:55 +0000
Message-ID: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Date: Wed, 29 Oct 2025 15:59:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
To: Johan Hovold <johan@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>,
 Simon Horman <horms@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org
References: <20251029132922.17329-1-johan@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251029132922.17329-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 8545024e-e356-4573-b50a-08de16f3705a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEs0amQyTDJ6djlvaXdIcFBZMVQzVVhLbWE5RE1ITzZqU1BRb3RjcWhrRGpR?=
 =?utf-8?B?YlNMY25xbE8xQ1hhWVVxYUN5b3BZY3lZZUsxRm5ZSzl5RGRIY3Y2aGcyL0Ns?=
 =?utf-8?B?NnNHYTNVempEaGlMUWhpYkd4YzlxbVo3Q3RldFRwamQ3ZUV2OExYbnpvbUJL?=
 =?utf-8?B?aEx3S1RsQ3k1N0lzV0hKOThia0k2dzJsbE9CajdUYnFweUpQck1wM3RwWUsw?=
 =?utf-8?B?QWNpN0w3dHE3R2NjcEYvZlMvZmpwUWE1Um9Qczd3ZVpTWThBa0loVWRGajE3?=
 =?utf-8?B?WG1JZkRNZHgyLy9yZ3ZKQWd0cjg4YzZEeTZIQ20rRHQ2VjBtZHQ1QUFvOW9k?=
 =?utf-8?B?MEFmSGMvUjJiNVRUc3Q1bjBOZXhXbXNjZ210ZlBaWmRJaWg0R1NCbDRrT1JH?=
 =?utf-8?B?a0dnTmVtcmUraDlaZ2tyMnRpRXRaUHdRR2ZFU2dqNGc4R2N0YTRIQXhycSsz?=
 =?utf-8?B?TGRmNUJ4anU4TE8rTWREWDMweVoxVTJGSjVHRUVBaWNmc3F5WUs3dWpiU1ZO?=
 =?utf-8?B?NTNGTytEV1VuaGwvY2NXVnVROTNsdFNWbVV6dWlpbHVnOUdEelIrNTZtYkhF?=
 =?utf-8?B?SW1pZ2dkbFVmRldYUy9mNFA2L29ZQzVqTWpkNEhyUWRCa0toelRWVlF2eUlL?=
 =?utf-8?B?SkE5TkJjZ0tmUTVzbHdrdXhNSTVvaWpKellIeitJaFRWNWxGZDVVQS9oVlNj?=
 =?utf-8?B?OXdmcVVOWXN5TmJML21qc2l0dzNvSFEvTXphUllrWnNlZEp2NGljK2x3VFU2?=
 =?utf-8?B?SXhNVVhkNjBxL3c4YlBJN3hnL3loTVlmQklPYy9rQVNBbHdFNGNvZ0gvaE1E?=
 =?utf-8?B?ZS80OTFDOEx6Q0trOWg2VnAyUlVmYi94K3NabkpDNk9iNTJiNEhZK2JIa0RF?=
 =?utf-8?B?TTFVVUY5OHZmK2YvMEhQR2o4cmthUGNNdElsVFZYOFlsSC9VbTU0blBzWmJD?=
 =?utf-8?B?TTMrcEtwQ09OMXpaZEk5QmRhRUpTS3FlSXovZEZTUlQ1R1VvRGw5NkJrQ1pa?=
 =?utf-8?B?cHVzMld6NTJwRnIrb3NaSFhJZkliblA4MTVjcEI2SlNKbnFXK1Fack80WGZN?=
 =?utf-8?B?NzlLN2IvUTFwaG80SlUwOHFWV3o3bFNpR1JhaWZvalBVNUdjb1N5dE85UldK?=
 =?utf-8?B?WnpIMm9kQWxXYlJJRTFySnF4QXF4UjM3c2NRcUpBeFZoTnFQVkZhcDNnTkNx?=
 =?utf-8?B?WWUxR0o1MWIxM01TSHRxNnNCWVlwS28xS2VxV1dLOW42Umsxcm1UWFVCR0hz?=
 =?utf-8?B?TjhRZGEwajhQRnMwRzBuYTRNUmlxZzQ5M3BiZGpwWGhYNDNsSmFPZzhVZnp4?=
 =?utf-8?B?WVphUTdhOUJkd214UWdWOHVwNEdNV0wxcDl3eUdsdVZBakg0TU1IMkRqQUo2?=
 =?utf-8?B?WU1kcnZSYVNIQkZtdnEzSzNQMnFkUFVWZ3ozRkQvZmVTKzlLU2R0WnFPTURh?=
 =?utf-8?B?bkV4eFVsZjF0TitTT2VNUVV3dEVoUkxlcVBrRk5MZGxiMjFteGNPZ2lBcW43?=
 =?utf-8?B?c1RyMm96S1BlanNka1pFaGNIcmhUM0Z0RmMzYnBUZ0VCZ1ZXQm9jbVA2VDdI?=
 =?utf-8?B?TmdoeWlnSHBTSU04M3RkN3lZSU1SSERtRGlSRWR4S0FLRkFIVysrUElKcGxI?=
 =?utf-8?B?cVBDcS9jTzZaZGc1NktjWXV5a0lSWmNxRXRBVTZ1WkY0ZW9HN1dMS3pPSjZv?=
 =?utf-8?B?K2xJdEpqcm9rTWRkVmlLTGltVWJrM1lBSVQySWxOOVZaVUJJVVBTRW1qWEky?=
 =?utf-8?B?T2Rpb1Z0RisxQ280WUlZZHQ3VU1vaFhGcWpNWTlDSVNuOWxQWlQyZHArbmpP?=
 =?utf-8?B?WjdERHZBMEdQRWxLdStnalM3RCtZclFVWWY3TTNwcGNpMmJaTktJQWdyckhV?=
 =?utf-8?B?WUtrN1Q2a3c4aFZLd2NxQU1wRHl0Vnhadmw2VzA5dkQzaXZ6RExjM0ZrUUVK?=
 =?utf-8?B?YzlWSUpIVGRFeU4vNjZkU2dSaWZkZml4bWFGMHJsbzdtcW1GZ2d5VWlYdGM0?=
 =?utf-8?B?V2xqcDUvOU9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2JOc1Z0bjdNckRNMWhhVEk4azJibEg3ajU2QVpwNWVaRTJSYVlINGY5S3pR?=
 =?utf-8?B?OExBVksrZDFSZ1g3dkFaR0lNUDZDbzNzdCtsY1lDbEtEaGZEZ2FheklQSUEy?=
 =?utf-8?B?N2F4bS9YRktOcCtuMXJoOEx0dHdtMDI1Z0k2bTBReTQ2QmM2K3hrclluUG1P?=
 =?utf-8?B?dDdpczJnaTc1MXpPdlVCVmphZURzbVFBNmg0OXBkcEN0dlBsNkJSWnE2YjhD?=
 =?utf-8?B?REd1akRnb0JwVVVjVXJ5SGZkKzZVNmZsTmlRUm5pVk9nRG1GY29FZ3liSlh3?=
 =?utf-8?B?THhzUlhNTEh3YWFrdXYzdjBMYmcyS0RIZHg2OUtzNW04MjIvVW9Sa0lzaVJF?=
 =?utf-8?B?UHpkWksvK2pDbzduQW1qbktNaGtLdGlMbU9VZVdOWUVlZ0J4a1MyMFBEZjFq?=
 =?utf-8?B?bzZadzNaci9RVzdzMUdFRG9abkFJM3l2UytpY0diWVl6enRDeUN4eTdZYWlh?=
 =?utf-8?B?L0JCTDk2N040ZEVZZ0dBUmpyQmxTb0FMY3dsZHRzd25wUVJ2WGRiSjVPMW9N?=
 =?utf-8?B?ZDNNeVNiL1ZOQjVhVGF0VjIrdVFFUVg3dW9SM3pKcVBwRzZUVnZIMlRuZTgv?=
 =?utf-8?B?VW8rdkoybmxkYmUwTG9Yd1gwSnR3Lzg4dG1yRThYM3RadUhUckIwVmh6bjRJ?=
 =?utf-8?B?cVB1M0IvdmhlaFlpQTVEaVAvM3dtY0tTN1BRWW5lc3BUdzh4bXpBU1lEQ2tH?=
 =?utf-8?B?ZWxJNGFuTkpweVVkUUt1aDBacWQ1cE9YalUza0Vpbmh3dzFRaUJaVjBscmdy?=
 =?utf-8?B?d3IzVnBFUjZDaHdYRUZTUzBRelJpQnM3dlE4Y1FjaURLVUJGVlUxOWU5bzhN?=
 =?utf-8?B?Vzc3T3pSRFE5ekxpbnB1ZExwcGJ5TUxyZDRQMjR0OHNqWngrRUhPUE5RZDZV?=
 =?utf-8?B?eGdGTXR5TWZXVnVMam9zbFJKUzNFci9QWDRFL0FzcmUySkdvV0J2WnBHYWNS?=
 =?utf-8?B?WWJOd0xMaEhMeVptZW1CRHZaWW1jS0JuQk1ON2MyRjBlRFllWTRxam0rbmhJ?=
 =?utf-8?B?MEpubTZMck81ditGSVk2eWtLTjdXa0MrYzBmMWJYK1NFcEgvTUU2OGkvakVZ?=
 =?utf-8?B?Q1ZYUmZZSGhndjIwc3pueElGVWFQaG1VQVhvTzUrdzFyWFFLMzIybVJDOVA2?=
 =?utf-8?B?M2V2VFQvRXlINFVhYmhqek9BZVFwLzhaazIxNHprZDl0S245b1IyOEVsMTJv?=
 =?utf-8?B?M2N5SzJ3Z3I3dmJrcUh6aWUwQWxxTHVCTXg2TjVSdE9NM1BKaE9udThaUFhz?=
 =?utf-8?B?L045My9EeTMweDlqTmlBS2pnVm1tTXJkbVRzb0ppSlEwV0c5NWsxR29RWGFw?=
 =?utf-8?B?T25KZW5CK1VpK2dGNysyNUtOV05EVWREaUNOaW81LzAxUklvUVpFcW1LNm1T?=
 =?utf-8?B?SWlnOHh1cmNtNHY1eUkzZ2JwSm1CQ25HMTlHYlcwRm5VQTBsTFJDampqOFdy?=
 =?utf-8?B?YVZhQWhxNHhHNUtqdk10WGdjcGRlVm9wd3VNNEw3eTdkZjVGYkFYL2NnYTAw?=
 =?utf-8?B?ZDFnQWl5S0JObGpqSFYvUVYycS83blRKTmhwUFpvZHcvMFFQU0hUSFpjMWZU?=
 =?utf-8?B?UFZYZ0hsbzZZc2xWUlFkeVVrc0l2WU5BTG9qL3ExTUd0dVltaTVac0JoNHls?=
 =?utf-8?B?SzI5aWtTS0FTZFhmazIwR0YybDRKRitsemJmc1dnTWd0a2diaUN2eWxSSU5i?=
 =?utf-8?B?dStRVjI3Nkh0bStaRGZYVDJRZ1pnWWRhVmlId0daWEFIK29GTnViWXB0czU3?=
 =?utf-8?B?SlZzS3RoVXhpaUtIc0s0K1pVQ1RLSlZDeFRhUHVDaHlta1VIZkdTN1lyeFRO?=
 =?utf-8?B?NXVzaUdNVVRPcmJady8zTVNVaU5VK1JYcGttalZZTXpqR09JRGxnSkpmRU1C?=
 =?utf-8?B?YWhINkQ0L1YycmhqODNHeWR2cXFHQlltTmdKeWI2ZWdoaTFhVzBEVFlnSmM2?=
 =?utf-8?B?VFF5VjBZWFdML0ZYL2dHN3hhekF4RHI1UG5qVjJpdnhCOWw5QmxhcDlBYlh5?=
 =?utf-8?B?RHVIdkVPZkJlTEIwV2lodVd2RVlkRU81dk52YThxb0tvcDkzaUg4cC9xYkZq?=
 =?utf-8?B?M3FxR2ZwbTRoOUp4a0h5N0NPazFUYkpuK29HckZXbklJOUxMWXFoTEt6NGp0?=
 =?utf-8?Q?YCck=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545024e-e356-4573-b50a-08de16f3705a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 13:59:55.4877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPyg2lcaqo0+99SvL094+DLExv45Uhqh7LCL8CSPVHzWF3Qm7+RbY9+wah4Dt3IV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

Hi Johan,

On 29/10/2025 15:29, Johan Hovold wrote:
> This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> 
> Using "%pe" to print errnos is in no way mandated and a driver authors
> may chose not to use it, for example, for consistency reasons.
> 
> Drop the recently added cocci script that has gotten the build bots to
> send warning emails about perfectly valid code and which will likely
> only result in churn and inconsistency.
> 
> Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> Signed-off-by: Johan Hovold <johan@kernel.org>

The test by no means mandates authors to use %pe, as the output says:
WARNING: Consider using %pe to print PTR_ERR()

"Consider" :).

I would consider it best practice to use it, and a few drivers were
converted thanks to this test.

If the issue is with automatic build bots, then maybe this test should
be excluded from them, rather than deleted?

