Return-Path: <linux-kernel+bounces-810646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65198B51D41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 08AA14E31AC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B86253F13;
	Wed, 10 Sep 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R9r1oggt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32828168BD;
	Wed, 10 Sep 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520970; cv=fail; b=KZPOhUtmQpMqzsZuOx1Yhke1oi/MNXlolhM+vG7f41S8WHPr5/3OSGMlwgkkFLVaF8fy/mgVM4UlzVDbPKArTlUixPJYzEAA08GL2S3wi/YGoEweYCfJhYsy1bz5EGSz6A7g2feSNoCR9E1B14YpcgYZ6S18LjGKWS/pgwc1yJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520970; c=relaxed/simple;
	bh=QB7K3AYwNaSsWzx2qgsm78i3TWhUStfHQSlxVzFPVPQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GmiVJ6jxiFlbxnFy3aoCyhEvZa3NgS7q4ocAFm26TbN6fHC84EtRxDjpGJRK7gwKQIKgDpQsto02UI5OaRuV832s5XDoMOaXCHcVVincXYy1WhnHrmCLi8ooiCuG9Va8zt0NGGh2A0oEdws1bbwqOam3p2ceXK2Z+5FK9iktiSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R9r1oggt; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7T/h+5TDNU+anz/UB52Ua81kB2ds3lx3fHjgvqg+TD0wFr9d7sQfuDMqCFv1JJIEtnpi1NTw7UWICoB5eyR0EYWoUZAweAyMLiqstzDbxP5qLReCHteivF2bNIH4eJEFXB+Uc73T5B4OYn6K3+X7END12zjxtIs8YMqnfFCE5hq5H592eQduBodK6eA0xUEXUWf6hK9OyQKWOqguMAWLCb3Ho8tXaF7JrHLGa9PWstrJJ71oXsfAqw78hN6T8ReGa9i4fuNZpMWyIrclnXGQUScn3P9BJLB4TfiHe2QDrmHPyJ0Qgn6yJSUsJBg2pxXbtaYBqdveEyqGB8h2sh4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gTciQLtn1HmFWlCbRFdyHPcS7tWJDL3hWmi5RYOMEI=;
 b=Rzpj2cv7hMTlMeX3uA7p3kVOg282oDEKGWsxvlyB3gJsMNrPskeKHEFAVqSyOefEr9O5IYjNAZ2CyvJOdE9lCFUkQcsKNBBVMfCXYkQn9rV8GcFv9VAupFUer4hhxRreLLoFLpyU1tq/k8LkoZuAN+/Wbnb0v7qUvNSfoTGnAEb9KgZsIJRzWW5lr5cBObGnqCBWgPpv5YZJJ1h9/udCPuBqoC9hPqMudu6WWk6yKIPRvJzfItvIYJXJwFL3o5+gq4yG+cuB6JYkwoxb9DzRtVsdZZxWB1d42EGlU8gr2TIQ0nsxEc6HfLhd7ptomx9lqCmD85XUeuBL17SlzXzVZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gTciQLtn1HmFWlCbRFdyHPcS7tWJDL3hWmi5RYOMEI=;
 b=R9r1oggtHV4sTxu+mzIXPb6pIIOuyfTJwt6yfBo5RAj9r/DrGGIJO0Kgi6/hDq/ulrwu0nwQLRg1iOlTBonulGdSx2U3rF34cLV+Bylr+5DN5Aia+Q2zCa99LX91OuFY3mw8l9McTdP5zqia//tV/47Io7Qk+Q8Lqv7CyrOySmEd6v9ndoIYSsC1ZonMYr2Eh0EbUmZhwZosFz4W9f0uN677FPmZInj8PNI2wUTWVSe+miceFqHCkYoCbgEFsJo/zukOQfUm1ic9SbU87dd2dnWWiJ+H0LDpJpjqBX+J0jFqmLjagobYc/APR4uZC37DxZYHdUZOY+1Jmg1DTcrCbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:16:05 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:16:05 +0000
Message-ID: <8e3a9caa-14e8-4987-8eee-d353c37eae54@nvidia.com>
Date: Wed, 10 Sep 2025 09:16:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board
To: Andrew Lunn <andrew@lunn.ch>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, etanous@nvidia.com
References: <20250910041736.245451-1-donalds@nvidia.com>
 <20250910041736.245451-3-donalds@nvidia.com>
 <e51d1a9c-a54e-4fe4-9091-4f5ea29535ec@lunn.ch>
Content-Language: en-US
From: Donald Shannon <donalds@nvidia.com>
In-Reply-To: <e51d1a9c-a54e-4fe4-9091-4f5ea29535ec@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::26) To PH7PR12MB7282.namprd12.prod.outlook.com
 (2603:10b6:510:209::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7282:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b0d9e1-f937-46f2-82f3-08ddf08557ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWpMZWYrMndHaHJOMjJQS2pPU1dSSHJHZkdQdjhveHM5aGo1cmdUNjgvazdW?=
 =?utf-8?B?bHl5MWJ6V0hZa2w3blcwQXRNNXJpYUxFbThZTFVsWVY0TjZ6bTVYTDhGbmFU?=
 =?utf-8?B?cTdiSGxuUXBwWmo2ODJSTGNYT3FSNDFCRDhFdXJPWXBHQ0xwUkthTGVLRDNQ?=
 =?utf-8?B?VHo5S1M2RTBiU3RpSlp0Sk9JTFl1cGREam93WDNPT0hidDF2UHhoeVJMeTNG?=
 =?utf-8?B?dHRyOWI1UW55NFl4Y0VGNkI5UUtwd01ZeThQbUVFWUU3TWpGbWJFNVBaRU5p?=
 =?utf-8?B?UFgwUHdpMGNPdUFrRXVkRmozWU41WWlhRVBxTjJuZlZ4VkY2NnJwV1liOUNj?=
 =?utf-8?B?L1J2bm1Za3NYQXpUeitqcm9mbkJ0RHhBais3M0VOK05Vc2lTenlsMnpWRmFE?=
 =?utf-8?B?cDROS2U3UWFTT2hjMFVneWQrSEVtaEJEdEhTMHpEem9mRzhMTllVTXFpeU16?=
 =?utf-8?B?ZXdGeFdUWWx0c2dNbHhQeEdlMkVkRmxhSWh5Z1gvdXh1ejROVUQ2dkgxcTdM?=
 =?utf-8?B?TFFzZGJZemJUWDFrVTRlU3BxaGdqdkllRFRFVHlnaWNXQ3pEbnVORzJJZVdL?=
 =?utf-8?B?bHBGTEg4R1RtNnVvZHNVbkRMSy95ekx1ZmwwNWpIUjIzQys4elU2RTdKdTA5?=
 =?utf-8?B?cW1GZHF1Z1didnoxdTkzcEZBMGJpalpIQ25hZklFemE4QXB3UzcrSG1idGh4?=
 =?utf-8?B?OVZaZkxjcm92cDcxV3hmYytYV01oaFgzNk4rYm5USHJneTgzcWFxOVZaWkor?=
 =?utf-8?B?YTFnWDFhVVNRbWpYL1RlUXQySHJDcnQwempwcFdpbHo4Q25jOHVzcGhtaXM5?=
 =?utf-8?B?RktKYXhDc0MwQy9hcDBlcUhZOUM0UzZRbXFoZ29nOTB3VXN6cUErSkRGS2Jv?=
 =?utf-8?B?Rno1UG9VaG9MZjE4czRJQ0MyR3V6TjlVZ3RtOFNsVlc1Wk11OEVaeCtsM1Mx?=
 =?utf-8?B?TnJYcjlTajYzL3BVWDJCS3NnTUd5TW1QM2ZRRk5kYjgwdTRlNW03ZTFzRW1U?=
 =?utf-8?B?em50dHhVS0s4UEo4ZlE1Nzkyb21rU3RkUTY3NkdZM1N6ZEpLNGNVSWp3bmZl?=
 =?utf-8?B?a25MMzMxeHZjbDlZSWJ1WDdTQnhUbVlkYmx0Tkg1OHRXRXJ1azltZ1oyQnZR?=
 =?utf-8?B?QXdNaEJLR3ZERWZOdG1taDlGeDc3dFNMOFBoVWU1amVKNFh6QmhIcHpxMzcv?=
 =?utf-8?B?citoUmRuaHhDSC9Jb1RNVE0yQ0p3QmJYVDYvVzZKTjBHRUZKZzZyVnBTUWlx?=
 =?utf-8?B?c0FzRmFweTBsY0FteTdjeXg3dGdFRGNOdjJ2YnpWVFdKb2lLYnZGcUdkUWdE?=
 =?utf-8?B?Y0VyYldHcjZYRXBiSlFkUTlKdFZqbDRLcGE0YWtvTkJZOUlBUzVrekhEMFBq?=
 =?utf-8?B?Qis1ZUtFbGRKY24vc21nMHlpZkdDekRYNk10QXpQQlJHM0ZMbzliNVhhZy8x?=
 =?utf-8?B?L04zMWpRbU1FTW9FRUFBZGl5YkJraXB6N0o3Q1dtRWFjNUd4V1pZRXgxZHky?=
 =?utf-8?B?c0NxLys5OTB4SHBLQUNTZG1RendMM3B0aVBzelpUUU0rZEVZQmJQRnEweWJh?=
 =?utf-8?B?WnV1VERVWlpuN2ptUU1TbXNMczdaejB3aTBZa0R0L3pVWCtsUDJ1cEYvcE1L?=
 =?utf-8?B?Njc4R2FBTzlYdkZzU1RoV2szdmZCalk1dkZXcWRpRmlXS1VJQUwxTkU3MDVS?=
 =?utf-8?B?SUxObUt5VER5QTE1SXNGNkxubGo1SkczalJ4K0l3ODVvV0ZpMTlPOTJ1YXYy?=
 =?utf-8?B?TGkrMDNHQVBnc2Vvc3BYdGhUaVZqc05wamhGaWc4VjVLZjZvK2xsclJsWUlB?=
 =?utf-8?B?VDNXQTRPYThlenFuZy9yVy9WYk1rT2lIUmhhNzJ1RGtFbGxNS0RnbXNZSCtM?=
 =?utf-8?B?VFVkNXZ5TWdJUno0aGRqdExQZWpMZnk4a0FBU05yRHYyV3pVb056MTVMMUxv?=
 =?utf-8?Q?w7fLru6lJ8E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1nTEJ1NVFQVjFkRHJQbGZ1MzJTQWtuYTd0WUZ2TVZ4N21JbzM5TkVmbXJy?=
 =?utf-8?B?UTNUSG9VK0dwMGZnTE5sWUVPQWxrRXZGNmV3VzIxUGc0ak1yS0M5RkNmcGtN?=
 =?utf-8?B?TVJsOXpLais0QWNDTjI0RGZCMkl0TGV6TW5aOVZWdjU0YTNWNkZnRHpGTE15?=
 =?utf-8?B?elpuYThxNFJLRUllbUN1UUJrMUI1ak1KdUxpRTNIaEt5aWo2dHdQMHZiOVFY?=
 =?utf-8?B?ZjY3eFpuZTRPZDJ3YnpDY2ZtSHBUOTNTc21yMEN6SzVVM2NLU29mTVZVcFJu?=
 =?utf-8?B?MUZwM3RmM3hNNGhSWmcwekhjeWZhWUxqUy84SWNnbE9LaFJ3TEwxb1Bwbm83?=
 =?utf-8?B?MXBaWGVRRWFUaVpZZHhBNWpiSWlsRXBjN0hiN2Uyb0FMMnJra2xhMmZQdmQ1?=
 =?utf-8?B?VVMwRnhWVUpMZmJleEZzOExKMzlqM2h6SDJVMkRyRTNEYU02QXQrWnpjb2Np?=
 =?utf-8?B?ZHZwMW54U3pBR1ZjMFYwTVdjeTNBMmVUWlZQQm9PeFpCSTAzZDV6SUxKYXR5?=
 =?utf-8?B?TTlpTndZOE5ORmxDV084VTVjeUZoMHpTVGl5cU9LcVRNMTNBZEJKTTE1c0hG?=
 =?utf-8?B?Ky9TWEoxL2VHSnNGc1hRTU5uY1JtYXZ2dU16bWhGaXRzU2RCelc3YkxFRlRw?=
 =?utf-8?B?MUs5WHpMMWlsZ2cxcDZmMldxck1YWjF2bzNlNENJdVRrZFdHQVJYUDF5VVlH?=
 =?utf-8?B?MVBGNTJMcjkrWWkzOWxkdSs3a2IwSy9JNjRSZG9FSmEyV1hmMlZZQTh1b201?=
 =?utf-8?B?NVphTHROY0JGU3h1OHJKQlY1TmlGOWhKbzFFQS9KMklRcnlDRnVFS1J5Z2Mr?=
 =?utf-8?B?by9oYVJVNjg4eFFVY1BTSFJURmpaMWQwekVkcHNoTS9kblJJZFdybGQ3eitt?=
 =?utf-8?B?SnJOTW9rUEVDejl5aFV4QlpvZmhGVmpJQ1JGbmFidXdRSVBBWC9LdG1xZTRR?=
 =?utf-8?B?MEl1OFpyaENCbVZpTFJoZjZCMEJXelFZVGZYeEl4UG51Z1FNNW81OWVEaC9Y?=
 =?utf-8?B?azE1VHQwUjhOUk5yUnhoWG1HVDJXZGtVNC9Xa0FhL0M4cFluMzViSzlzSm5s?=
 =?utf-8?B?QU1mUklZYXVpdHd6Rk9rUGU4TkNFK0dUeGRLYThQL0pMbldEdFhGWjMvT2dn?=
 =?utf-8?B?Uk9zTWl1Wm90OGhBajZXbGpmeDA0L24yVG1DbVJzbTZnMUdRNTVreXdjNmw3?=
 =?utf-8?B?SDErbHdtUE5YaXhJeWF2cVNRT1RFVDBiYnJvcjBsaXU4cW0ybDk1UHQ2RHdG?=
 =?utf-8?B?WTVLNXRwOVEzQTkrOG1aekJRNGcwSDBVN0JNSmV3VzdpTXVLSHM1UmtBS1Zu?=
 =?utf-8?B?eW5HN3htOTZKRjM1SExkeDNrUlZVMjQ5Z1dDVUlhNVFtOE8vR2tXa05Sanpt?=
 =?utf-8?B?c1M4U2paalZnMm5tTm9jWVVHVFBYRE9LQjVKWE1aR2pCY1hlaWVEMCtVUUR1?=
 =?utf-8?B?ZUI1MG5qaVZTWlRlRU42NUJDWjZSYmxScE1SVGYrT2NQd25qNmJ3MHl0WnVD?=
 =?utf-8?B?dVlzcEdTQ1BRMHJWeTUrdUhWdVRoNnk4aE5vL1JQWi9wTzVHdWdOeURZUndz?=
 =?utf-8?B?TEZoa0xDZGVNVmRyem1zdUZuVW1DckhNMjZ3cDM4ZlZ1RTZIQnB2TE5iZlh1?=
 =?utf-8?B?dzY0NEl5NFFEbjdzcE5IM0p2L2pZanNXWHc0c2ZxSlJVYVp6cjlkSFRuSnRC?=
 =?utf-8?B?MnN2bWQ1K3FkaGtYV0QzZjBPTHl0cC9xQ1d3WTBGSzhURDJEVEZYbUxGY2My?=
 =?utf-8?B?OTB3M2JZZXVOcS9WOWhnaFNzYnMyS2duMCtqMTNaMHFQdUZmL2M1UkVqTTM2?=
 =?utf-8?B?SmpFKzZPbi94UUQ4dERHR3ArYnNKQ1liOC9rdFRDQmUwbFplckhyWUh2eVNG?=
 =?utf-8?B?QUk1SlpuR3l0TVBHTDlNdDcwUnhxZzlRY213ZDlqSlRGSjlieDVjdTNGZEhv?=
 =?utf-8?B?UUU5ZG1RZ1JNU1ZrR2dtemsyTEhRZ3JFTHlnUnlONDFtVy9xOVh4V0VKWUtR?=
 =?utf-8?B?ZVdDeStYME4wRHEwS1hnNGdlYjRlOVZ3Y1NEWTJmdmlFalhTc2tlRFBxK3p1?=
 =?utf-8?B?WTM3K0c2YWpLb3RQNm4wamZOVFZzTTZydHUvb0FFaVVMMy94N3Z5TENyc3B0?=
 =?utf-8?Q?X8SN3iW26AMFRDHzCmFTBuSpb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b0d9e1-f937-46f2-82f3-08ddf08557ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 16:16:05.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1hNv9azlqgwWTrUAenJ8aeqCummFddtkrR2D0eClSpJOgJqQGIWQMnAQevqim6GzKf+exh+JcmkHF5spXNk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

On 9/10/25 05:58, Andrew Lunn wrote:

>> +&mac0 {
>> +     pinctrl-names = "default";
>> +     phy-handle = <&ethphy0>;
>> +     pinctrl-0 = <&pinctrl_rgmii1_default>;
>> +     status = "okay";
>> +};
> Same here. Please describe your PCB.
>
>          Andrew

Hi Andrew,

This board has tx and rx delays from the phy. I will add it back in.

Don


