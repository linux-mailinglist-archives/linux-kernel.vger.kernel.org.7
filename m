Return-Path: <linux-kernel+bounces-886035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E3C348DA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 09:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9E4A4EEC9B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEE92DEA8F;
	Wed,  5 Nov 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qMcEuXwU"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548772DE719;
	Wed,  5 Nov 2025 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332480; cv=fail; b=XerchiEGS8YV9Dz3o+RJC5lCK6L/tIEw847mZxqNgVNdD6A8hprCiRgH261P/LIdunFHA9dMAlWWVMQ9bFvzi9hiLEP02TAA4c9fqXOCkfXZAAkDp+fRg2izOGctTWJsiIW9OvicbEeAg6egBBpyvKNKEksy5A9sdHOpSx0Qth8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332480; c=relaxed/simple;
	bh=V8W2VS5qe2vX/y8gEJKU2UjEO4EYuB2YnjKQhLSORdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QK8DAtfqZDWjhwRMOnAQSuHbHpiSL/Uprh7tTsBXhTqlLpUe/9GPRvEoWfwUF8shjmIAvO+xMIbdzuFXSs1tC2i3FwacYrak+xEvg4RSSsLjvARexV2D4SPbqqwUchPztXEubxi0l3pG4j6MIyleA2X9IGJjuTwmIUGOrr385pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qMcEuXwU; arc=fail smtp.client-ip=52.101.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB64P8yvBMqKU3Rczmadgdm6GbTmfi1DM30ObzBbKtJp27QmgimkfwKNQ123J2nJLdEGKGyWx0sfpYj9JGff9ReguyA2hCDwTtPqojis7WFzHudPNh8mptCy4VuBzMPaTtylFvXxDyszy3sfXRiBEh6xZgkvk03K6XgMe9FLK/SOhjprEzGUMX0Zu67eGH4GruYOwu01B/p82ZMNw22OmzIRBWMDG5WI/OlHtppRK/NneZEDRoYS9tLWipkZ4mee9mnqgcy9ki9/piapRN74v+lCBrZSQIWUyl0D+Ku5keYWVAK/ZA5XQsSJEJdy0QcPIyNB6ymBoymIUpftmCUpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uP+wtpv0qu7rdnBGWGgoh1h8k08n3O6hLRGVoAijtI=;
 b=qruMAkzyLYTYzt1eWn8uL8fuF/eJuo8Fzmclm8VbnmtUcAvTsAFyALO49YsxZlbx+Jn2UAIZbjSTzSBVvwHckV3a4IR2nPOi1qPPCwF16qW6sK28sgu94MHRwPeEpcNhHYf6NuNbe8oYd031v3/8RNmhMWiQx20uHiDHClbd1L58yzRkGNeIgtud7XhTxiSIQGrCjE1+KCbbRdxdDpBq/LYk98Xm1sYipJi9HM7K9LVb3nPnB9lSdDI9bc15Tt0/W1xKr3GGpRKnId6+3ZMqAWBj3Dl7jcIzMpA9en7FL4oy7LcAxhJyqYe91Y0BeiRwTYICjH7hnaT0zKLG6noWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uP+wtpv0qu7rdnBGWGgoh1h8k08n3O6hLRGVoAijtI=;
 b=qMcEuXwU4G7gAEREmk9nA56W95lKoJD4dhw+7yz61O546jLbhUv6MBvbuZyT0lYtgM0rVZQamjJqjcK2CQU8qt3pK3bvHnkZbUIndMGmfsEmPyaB4G8Kz5GkZX4oYd3EgD2XhFS0Ws2HA1ozQVsjuecV2Pdb9x9mMcLKidE5Mt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 08:47:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 08:47:55 +0000
Message-ID: <5aaa34bb-7017-4bb1-9826-94f41c9f18d3@amd.com>
Date: Wed, 5 Nov 2025 09:47:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 18/20] drm/amdgpu: rename amdgpu_fill_buffer as
 amdgpu_clear_buffer
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20251104083605.13677-1-pierre-eric.pelloux-prayer@amd.com>
 <20251104083605.13677-19-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251104083605.13677-19-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: dd206b31-c79e-4392-dd70-08de1c480385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TElKM05SMmoxWUNGc1RTR2lWNmtwWWpiMStCSTl2TzNsQkZlUFNnZ1I1Z0lS?=
 =?utf-8?B?R1FnbXUwdnlFZXlmNnBhK3FyV01IZ0xBM2NRYTFseGxibGhYWkltU3VjSGZS?=
 =?utf-8?B?OVpjNVhTSHAyTTM0aU1CY3hFeU5XaEcwVlFHb3NHbGpvY3pmbjdHenpxY3ZT?=
 =?utf-8?B?T2k5d3c2Rm5zNWxjYklDcTVyMCtCbnJjTzRZamxPNFovL0E2bWxZMmczK2R0?=
 =?utf-8?B?d3pRTis0WkNJTkcwZHB1YWtNRTJSalRxOWpwUTNpeVlRM2h2MldDRVo2cEFI?=
 =?utf-8?B?bG9IVVd6SUJLdytQWVBBM1NUOUhVL2J5U0RVejFJdWdvcjZvRTc1aHFPMCtP?=
 =?utf-8?B?UWh5V3MxRHljN3VLSWRHMDFjaXF1Z2tveUJmb2VSekltVmxiZkNJVktqMS9O?=
 =?utf-8?B?cXhNUDhBMEl0RHc4N2tBbmpiWlVHWkU5aGE1aWdKbUJES1A3ZEZsWGZQQ20v?=
 =?utf-8?B?aVZCMlh3MDl4eXh4QWJTYVd2aEJzUElWWVJEVGV0bXR3KzNiRXNpc0RTNlpY?=
 =?utf-8?B?MUxFaGkxY1I5R0EvSkl2WUsxQTBmVU1wTjBZS0dhUnY4T0FYWEdGakYrbGxn?=
 =?utf-8?B?YW9Edzg2WFZsMDVhMDFPOUNlYk1TZnBCUVQ1c01nOHN3VGhDR1BjZUdZeXVY?=
 =?utf-8?B?WHJuZUNRTTVsTlQ0SEwxQzN0dGQ2eklOZkFZbHRLaEd6Qk94UzdqWCtZSlZ3?=
 =?utf-8?B?ZkJEczBzNEtPdFZIUU1weHJ2VWNwbUxqNWNneHlwdnpLVWNVVDNVeTQyUlJk?=
 =?utf-8?B?Nkd4SmVuYXI0bFdubzBMWU9XL0JGNENjTXg2Vk4xczNGL3NvOGVja0NhdWN5?=
 =?utf-8?B?N3RCT2pPaGFJdkRJbWNrMHhUL3l3MUFQN2h4OUFySk5jeXErWFNiSm5ZYnN5?=
 =?utf-8?B?NnJhSTBoSU01MDlJQzRlVWoyNS9jR2xSc3hqaldrNlc5M0F0ZzkvdG9iVUJ4?=
 =?utf-8?B?SlNuOHUycjUxczJ1WUdpRmpNaVdzR1Z0Q1hBNWhHeWlmZDB2cXQyQjFodUE4?=
 =?utf-8?B?N21COS8xNGcveTJRVjFjUTVXWjBpNTZmc3ZMWDM2eDg1THVKenVpZlNTT1pG?=
 =?utf-8?B?VlhySkEyMXBaTXZ4SW9kZmxud3ZKYy9OOXIxZkdaNWJsL0RBaE00SGcxaSs4?=
 =?utf-8?B?MFFhNUZTR2pPcUdKemJ0UGtWaXkrNjN2RytvVjBsS1MvNUZPYVd3OFVqYTgw?=
 =?utf-8?B?Q28va3I5OXZhaWVhMFVJazRWNzlEY1BBNjdvSFB5OHJoWG9mV1BSM2hodTNT?=
 =?utf-8?B?TU51Mzl5OUFnajVjOFpHVDJNQ0tKVHFFVU95UXhiNkhMaVZpYkVUN3Ywa2xi?=
 =?utf-8?B?eXZwNVcrK3ZDWG9BQzU1U0JtcGZST243NThTVmJwU0V3YlEwU3M1elpwWE5s?=
 =?utf-8?B?Z1RsMGpLVGlxTGJTOElDY0t6ekZiejhXY2E5SEJ5QmZCYUVucytKUW5oQndJ?=
 =?utf-8?B?blRENEd6WkJQT2g5K1lXeFA1YUlWYm54VFdyNGZ3MklOcDBVWnBGczR6MEtX?=
 =?utf-8?B?Y1BBRVlNRFFLMld1NGVZbmdUNlBGWW4zYUt1RWhaeVA4MzhPa3YxUlI5OGhm?=
 =?utf-8?B?MTJ1R0JqcUYvanRUaDZlTUlmYXMxaTdBdTN2VDhQQy9xTWtMdnRXRURYNE1j?=
 =?utf-8?B?b2ZsRnBrbis4QlRoM3ZpdFZQMU4vZFFhTm0yb3ZFVTJiL0IyR3d4M2gvY3B3?=
 =?utf-8?B?SmRvdmMvMVNtTkVMejd5RkJqUGpZaVB5aHRXQ2VoTU16N2dVVmRLZTg5SFh1?=
 =?utf-8?B?MDhEbXBhVGVJTXh0U2Y4SFZmVTVTb1dsY3N6emx3ZDFHenlHQ25CdXk2OXRH?=
 =?utf-8?B?M1Bkb0UxRVdLbG5nUkpBK2JtU3QzZ1JRbTgya1BWc0FRZ244bmVMalZkUUVY?=
 =?utf-8?B?SXdzS2tvd0ZQQXJ2ZHpGajZ4MGhOUy9TSDhpSStuUDNMTFh4ZnRWZWRVOVR0?=
 =?utf-8?Q?f0uku8hstewNjw/H2dDbu2PSlHejzgJE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk5mckVuOTdHdlFMZUYrWDdhUW5SckhhNmVaZkhYM1RpTTNxb1JpeFBrai90?=
 =?utf-8?B?MDhEQkdId0RvWEkyYXQ1S01BVDFYWkM2YjlvS2J2MzhWZkhaR243endJV25t?=
 =?utf-8?B?UlBjV3pSWFlJQWk3cmJmR0dWY0hlcGUvN1BmQllZWE10RFpQTTZhVjcwdko0?=
 =?utf-8?B?SWdTMkgrbFRGVnZWY1VwWENMeEdmTXlLY3ZYa0V6c2J1c0FqRmV5WWRtN0Fk?=
 =?utf-8?B?VGY1OWFjMFNwNjAxQ3dpREx5cmh2QmYrOU1TcVU3QlhUYXRCa1g5WDdzYjJT?=
 =?utf-8?B?RmljT1VaQWNuRVphVExVSG5YSnUrZnM5S2lQM3M5aDhnekhyV0ZmTDRuWVlD?=
 =?utf-8?B?TmJRU0dxVnpHNFhPZDhjY0dUdWgzL0kyNEdqYTJvSnc1MVh5dDBzbnFCZ2Za?=
 =?utf-8?B?YzlOQXhFWlBuZjY4Y1JQQll1d2lkUExsU3JkRjNXbHdxdGZpNDREeXFzdmdQ?=
 =?utf-8?B?NjFPQ1lsdENEalRtSEJIUGRzY2QvNGpsdDdWODFqOHl1eUx4eko2QzM4bnNM?=
 =?utf-8?B?emh3TU5sTHEwKzNnSUV4cEdzb1VOWElqWTVFYnJIdGVHclhFQ3E2STBkOGxK?=
 =?utf-8?B?RjlNZzBnTzRGYVVObmtRY3ZHRG9ySHBBME9RSmhpeUxOK3YxK2xGNHMrb3Qx?=
 =?utf-8?B?UFNsMVQwS0FGTU1FMGhhS1JUMzJjV2VtMHBpajRkU1Zmb1IwRDFkWGo2VHpt?=
 =?utf-8?B?MFdSaDJDYnI2LzlET3k5R1I4eVQ5am5MWDRHNDFjNWZISmh1eXhuRmRON2g4?=
 =?utf-8?B?SVhsRmZVNTdZV3l0N2xiZ1ltcXlYSGlQWnNlbnJOSTBnSXpLKzBCMjNXMCsy?=
 =?utf-8?B?WktaNlMzUlBwNW12SW1McEs2S0tpZkFqaHNYelN4dGVUZlppM1FydU85SWho?=
 =?utf-8?B?emZsWVhyNDlFZ3dHeklMTmhhbytUa1Z4SnFZQjVEa1NaWHpwbkp2TzZNNnZv?=
 =?utf-8?B?cFVrclZZbnQyOEhtWnc4S3NhMDlVNnJWME5NbCtnblR5MVpTNG1HenBzNGRN?=
 =?utf-8?B?ZXhHRXJPNmJsbWtTSjl4SXF1MDhDcVpEdFRMNEZ1dm9NdUxjU0dCVVNZUHhh?=
 =?utf-8?B?NytmOUNEdHZaK0lza0RmRFN1ZnlqTnY5S3FiVjdST0xCUTNjUzBNcmxZYTI4?=
 =?utf-8?B?SVc0aTdMQlVDL2toVlFicFdRZHZWYjV6bVBXbWI0RzQzT1U2RTRHeWNIeFIz?=
 =?utf-8?B?cWJHZVIxU2NTMUt2SCt5TjJzM1g5U0dGeXBWVWR2b25XbmsxSVZ0L29tbFdm?=
 =?utf-8?B?YzZBRzNvb2ZiT2NjYkhZMzVQcGkxNEZscm5ieUpHUnJhaGtNcmhjemZndXBv?=
 =?utf-8?B?RGVCV3dOZ3dxTTZTTjBnZ3paTlh5NzVkWmJTNGNxZnM5NmltMWYrZ2l4TDBP?=
 =?utf-8?B?RXJHc1BGYlJUaUJhMGl1aEtTS0tSa1RtWFdUWUJSbVIyVi9VSlVOZVpmclI3?=
 =?utf-8?B?MU1kanlkc2dNdU9QTUJlT1VHR2g2MjE4YTY3OFJvQnBLSnN3SlZDV1ZvNkQ5?=
 =?utf-8?B?bGh6bmF3MWJXT2ZJSjJUWXNGR0krajl5a0ZyZUZXbVo5ZlkyeHZpWFh4QWpo?=
 =?utf-8?B?N0V3U1JIbDhQc3NBL3pHYk1XbHR6cStHQytHbkk1bi9kN2VLOXVUczJuK2Nj?=
 =?utf-8?B?Q1ZudWIvTXU1VnZia0luK2lieTEzM0dZRDlrSE5oTXA1NGcycWhGaXRtTldU?=
 =?utf-8?B?bXRnL0x0V2tyVDJJK0pqYVpVa2pTbmI5ZUo3b2lWQXpOd0pBNzUyWncwUERV?=
 =?utf-8?B?V2NxSThGNHlPZUQzSkRzRG9EeDdEVmIyQjhwNmZPTndZZis2Q25Icm8waG53?=
 =?utf-8?B?bTU2YllTN2pLd01TMW5oajRqV2FWRXAyMStsWEdxV2c0aW9oOVNCMUtCdGRy?=
 =?utf-8?B?eVA1SXhyRyt0WmJlTFRDanZ6VWJiSU1zSVJCa3phbi9WZFZsdUJVTm1IS3FP?=
 =?utf-8?B?QlNQVStvUnRDb01GNmF4WGVOVHM2S0wyU1dwTUtabExITUZVaXFSVjJQL1p0?=
 =?utf-8?B?QlMwd3F3RDlaSDI1c284Q1lNRi9SUkRlcUlwWkZ1YldScitpUjh0NEdKYnB1?=
 =?utf-8?B?VHM2Skg3YVYyMk1hK281YkxvMkFjY0hRM2NMUkttOWNXNFhUYksrU0V5ekV3?=
 =?utf-8?Q?4zjy1nq6Yd5no55TFkS5qfzTt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd206b31-c79e-4392-dd70-08de1c480385
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:47:55.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bGqCB5up4InpyXyFSTAGDSKf9F81RVfoS0/fHYWCQOsa35VNIQ+Ig6153KGsckt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

On 11/4/25 09:35, Pierre-Eric Pelloux-Prayer wrote:
> This is the only use case for this function.

amdgpu_ttm_clear_buffer please, but apart from that looks good to me.

Regards,
Christian.

> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  8 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 25 ++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    | 11 +++++-----
>  3 files changed, 20 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 410e9b68ff81..9dc262cac39f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -723,8 +723,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  
>  	if (bp->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED &&
>  	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
> -		r = amdgpu_fill_buffer(NULL, bo, 0, NULL,
> -				       NULL, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
> +		r = amdgpu_clear_buffer(NULL, bo, NULL,
> +					NULL, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>  		if (unlikely(r))
>  			goto fail_unreserve;
>  	}
> @@ -1311,8 +1311,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  	    adev->in_suspend || drm_dev_is_unplugged(adev_to_drm(adev)))
>  		goto out;
>  
> -	r = amdgpu_fill_buffer(NULL, abo, 0, NULL,
> -			       NULL, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> +	r = amdgpu_clear_buffer(NULL, abo, NULL,
> +				NULL, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 1f553c56f31d..ac2857314d68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -431,9 +431,9 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>  	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>  		struct dma_fence *wipe_fence = NULL;
>  
> -		r = amdgpu_fill_buffer(entity,
> -				       abo, 0, &wipe_fence, fence,
> -				       AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
> +		r = amdgpu_clear_buffer(entity,
> +					abo, &wipe_fence, fence,
> +					AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>  		if (r) {
>  			goto error;
>  		} else if (wipe_fence) {
> @@ -2413,23 +2413,21 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring,
>  }
>  
>  /**
> - * amdgpu_fill_buffer - fill a buffer with a given value
> + * amdgpu_clear_buffer - fill a buffer with 0
>   * @entity: optional entity to use. If NULL, the clearing entities will be
>   *          used to load-balance the partial clears
>   * @bo: the bo to fill
> - * @src_data: the value to set
>   * @f: optional out fence. If @entity is NULL, this must be NULL and the
>   *     fences from each partial clear will be added to the &dma_resv.
>   * @dependency: optional input dependency fence.
>   * @k_job_id: trace id
>   *
>   */
> -int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
> -		       struct amdgpu_bo *bo,
> -		       uint32_t src_data,
> -		       struct dma_fence **f,
> -		       struct dma_fence *dependency,
> -		       u64 k_job_id)
> +int amdgpu_clear_buffer(struct amdgpu_ttm_entity *entity,
> +			struct amdgpu_bo *bo,
> +			struct dma_fence **f,
> +			struct dma_fence *dependency,
> +			u64 k_job_id)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct amdgpu_ring *ring = adev->mman.buffer_funcs_rings[0];
> @@ -2440,8 +2438,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  	uint64_t cur_size, to;
>  	int r, e, n_fences;
>  	/* The clear flag is only valid directly after allocation. */
> -	bool consider_clear_flag =
> -		src_data == 0 && k_job_id == AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER;
> +	bool consider_clear_flag = k_job_id == AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER;
>  
>  	/* The fences will be either added to the resv object or the last fence
>  	 * will be returned to the caller. In the latter case, all fill jobs will
> @@ -2520,7 +2517,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>  
>  
>  		r = amdgpu_ttm_fill_mem(ring, &entity->base,
> -					src_data, to, cur_size,
> +					0, to, cur_size,
>  					resv,
>  					&fence, true, k_job_id);
>  		if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 97e73919cb0c..b685bf207e43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -182,12 +182,11 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring,
>  		       struct dma_resv *resv,
>  		       struct dma_fence **fence,
>  		       bool vm_needs_flush, uint32_t copy_flags);
> -int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
> -		       struct amdgpu_bo *bo,
> -		       uint32_t src_data,
> -		       struct dma_fence **f,
> -		       struct dma_fence *dependency,
> -		       u64 k_job_id);
> +int amdgpu_clear_buffer(struct amdgpu_ttm_entity *entity,
> +			struct amdgpu_bo *bo,
> +			struct dma_fence **f,
> +			struct dma_fence *dependency,
> +			u64 k_job_id);
>  
>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);


