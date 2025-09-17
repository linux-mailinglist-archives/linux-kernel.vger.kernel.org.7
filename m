Return-Path: <linux-kernel+bounces-819919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BBB7E6F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DFE325783
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6632777E0;
	Wed, 17 Sep 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRVUfNBX"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC2149E17
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079262; cv=fail; b=UAPOwbdPLywbiqgWHyLWQ+vJNy1HsQhpFJ7VZNThr5Fn2iFcLSabfgCl7Y6IFRmaEVL5jxpA3fJCPbyOY+6cGnnJwvWjHf3wPffJ18dwQdBB1Hi3GPfZA4Hjks4fSghhuuEargmPauyEpYFlus1N+IVtnLktHrUphewOoE8+VYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079262; c=relaxed/simple;
	bh=P54Q12FDEkrWfsDo90Xxbqmxdql+WXiJqcgpbumCU2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H8Ex5A+IurGk8vtj772ZU5f0Z7wkrwK66Z0rL0yKWKG8VSokpb0t5VqsPme8bLsVw4GVe8hcc8IeJln9At/fySqgezRI2bmTNFdDFuYaIWYjQ7PYWlCk1kHePf5wnP5O9ZVn6v/2VRWXaaIgsWGw/wY3vbMalHoNlBBPlasHqmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRVUfNBX; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEAQY1JwtLGvU+ZVUA7i577XLOWiAVUvGDQ+6pY5BZURlTOqbqORCfIl1xC3dw5ESHA0NjLPKLhgtvDAYIfqTsAX91kCscsmHWO3TAtVlzvPg298BjwuYP3gnEIFInplH0UyW1fStsf3K3Zbkw3Wwt/UKOFRcLcZL7X5dIcqGv5Hx/gUoxEYvEjlgpiTIeiox6GrqFQKausn0BFNyyCKXttjAksMeyNVDQKlq+N9KLtDCHlOBJzvqQSdkPRyyAlGv2mZJXa4oO9gDA1DpU6U7BfSyErRLdafveLwpq7FqDoUdttRmvAYEUALMox/YVX2uFH0G9Bj+1cYqzE1/t7rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwCsTvqgCNM9qgcrjQ3QpR/kZrfenU2IUrVEuCcgctQ=;
 b=sr8/DTkIJrEv947EnzBmfZcAETQmVN9wIBMvgsRlkyuWZh64ja+hkjYSI5caBY2cGKLQeFjL0a7e5udChW6E+QmxlJbB8+dg/nW1NKpEDuATZMrNTxm61QxTmjQO8NeIjJyvpWHSZUA1qxO3VZ5ArKEuOvt4eAo/uj9JQfy32xAV7KQE44+zbiTUyZrLEXsvNYn0RwA0ar/rfOUvMflT9A3cy9p5wgKWh9XOs3qlWOtWZxuaDlmAXbMdkMKZu46JILyxDwxOI5CVe/oJguwvxeYMn7po/6d/lBT6wSc7SjCouvWigr7UhHJmdBAQZ3guwa6h+xlcmyUsNQ4bb6rINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwCsTvqgCNM9qgcrjQ3QpR/kZrfenU2IUrVEuCcgctQ=;
 b=WRVUfNBX0K81LhWeWZqOewRKmE53em042bH/jQvckn92IkzRJmT2NDJr5vKrAzw9iUyw8Q84kSYHUeMXdxCPlwSPYHyMPYB6EBaF8GzErgS1SL9cfLQN7i4gqzyK9DF03IZqSmoGdFpU02YeQ4IC3FEsOG4qQ5DVTowDxfLGYZVTfyCTHIiqT6UlmvpcihU1Q1XQwMuyIcFen174a+sZSsNQo68NDDxIeK2wGufQKxd3qd4calnhgvNbU6BkEKhgjqPNCZMvjbbxxhW7S89jDlQyoNhw4Eaizs6Mkf+SO+Gg9einPtO42hbOzqcAushSp8UJc6iQb5osz9KxU88HFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 03:20:57 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9115.018; Wed, 17 Sep 2025
 03:20:57 +0000
Message-ID: <71ac5779-d535-4b0f-bf8d-7a60bf6a6ecf@nvidia.com>
Date: Wed, 17 Sep 2025 13:20:49 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
To: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
 Bharata B Rao <bharata@amd.com>
Cc: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Jonathan.Cameron@huawei.com, dave.hansen@intel.com, hannes@cmpxchg.org,
 mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
 raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
 nifan.cxl@gmail.com, xuezhengchu@huawei.com, yiannis@zptcorp.com,
 akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
 kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
 alok.rathore@samsung.com
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 237f59e9-74f4-410e-0058-08ddf59937b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z20vdDI2QUhFMzBUOHh1Tzh2dUV6R0lxeHBzWlRTUXlOUCtCK09NZE9tQVVH?=
 =?utf-8?B?VjI0c0Q3UFY2UWhKcjk3MGRHM0xQd0lVOHZ0SXhMTndtcWxtVmJyK2tRWnZ5?=
 =?utf-8?B?UnV3djhIb1BFak1yN1E4WXJOaFhnQlo1MFhkOXdHRDRyc2Nsc2lUU2swRDRH?=
 =?utf-8?B?ZmR4SEFlRHFIc1I3S3E5djFBVHBiaUpTQkxBY2ZWaU1yb1Q1VmZuczdUSFF0?=
 =?utf-8?B?NU5qMFRNNjh5ekFXdHNqekZ1T0dvZ0RJbWFUQnVKejJSS1RBdG5VYlZLR3RK?=
 =?utf-8?B?YWZETkxwVnEyRm5hSjVBdENqV0NHM2V4ckxtTUVTNmQ3ZlB6dEF6bUlYTzhG?=
 =?utf-8?B?VzRJMVRmS000TGZkajdWTVpNUHYyY0EvbW5IU2tneHNvSjBVT0pYNDRvU2ZZ?=
 =?utf-8?B?WEVsdzhlaXd5ckdlc0ZVQnVMUnIzTVhKcEZqeXNDK0ViV09ZaHJEV0UrQWxZ?=
 =?utf-8?B?QXlZaGlLejk0S3l5R0VRQVQvOUpjSzgybUNtMVU5bWNVK080d0J5cXdxOURU?=
 =?utf-8?B?eGpDWi9hRitQU0kreGp6aUVMV1QyNXEzOWdFeGJnNTQwSExkZEY1UkZxZEVs?=
 =?utf-8?B?VmErS0M4SXR1U3M2RVZsYjlrcUlYWUlkc2E4eE5TM3JERXBtU21SdTQybVMz?=
 =?utf-8?B?L1BOZHJWazh1R0dJYnUrNy9OWVRNeWpqemg1ZWR2ZnoxMEJiejQ4ZzBibU4x?=
 =?utf-8?B?SXhtbFhTYVR2cG9zL2VDaTNiaFM3cnY2R3VUdnFmdm8wSzIzdXgrUlRYcU5x?=
 =?utf-8?B?elF6TVFHNSsrU1J5YWNrRVliMXZnbVp6enpJRVBkeHdrOXBoQnlkM1ZNeWk2?=
 =?utf-8?B?M2xVck91RG5XOXk3R2kreDllSk1PaVFUa0JuNEYzMVZ4dThVSmxtSmhFRTRS?=
 =?utf-8?B?WG9leHRDQ0l0dGxZN1NaK3BSMDcrbml0NXdSTlJkblRxNCtpUGxDeCsyNjZt?=
 =?utf-8?B?b3ZLdncrZmVRTXZQL2l3amZFMWJ1aW1IMWVEVEwxb3BWSHYxNmtkNmdneWFn?=
 =?utf-8?B?bTBsZzRrMnA1VXRPeHp5cHVCb2t3aXVsU3o3L05UaDJkdURudHlaYm0vTlF6?=
 =?utf-8?B?NE55eFhnUjRKcFlwZWh0TXFYdGRRUjkyOXdEc2dsbjRxYTErOEk0Z1ZFSGpu?=
 =?utf-8?B?NXZSQk5ERlpzN3R1a0FSUm9Gb1lVWTE2ME9LUjBucEppdFIwRHpQTzlJdU1n?=
 =?utf-8?B?b1BBd0hNd2Y4OUpudVZhaklZQWtGampFUTZFbFFDaEFGMHVrdlFNWjJYVkdN?=
 =?utf-8?B?dUNMVENhaFNmUjNQS1ZEamNnLzRvVUVLaTNiUG9SWGlVT3Y4a3N2WUJReDkw?=
 =?utf-8?B?dHZqV3lBT1pCVTExck51SGdBZk9FS1lIOXBES0NzUTl3WUlpQmdwaU9qdm1k?=
 =?utf-8?B?UE9wZVc1UmgxbmFrZ2pzcEJXSHRVVUdlOFdwUjN4elVhbXhjQUx5RmZHdm5a?=
 =?utf-8?B?bGc5ZGRhMUNwWUlZc2FQVGpGY2dGR1k1UU1xWDNIMkpCNm44Szg3S3RmUnk2?=
 =?utf-8?B?Q1ZWUURpN2FhdDRHbVF6T3V3NGxEMUlwN1JFblhJZ0lNYTl6bFRZcmN0UzRQ?=
 =?utf-8?B?T3B3N3FJMWlpbnhrR1h3Vmo0cnJyTlo4WUNnUlZvanRFS1Q2SlRqQjZWL1Jl?=
 =?utf-8?B?a0djRDhxOWZjS1VydFo3STYrQmxQNm5JUk5USnF6MkdnVXIrRnBFNmxMd05X?=
 =?utf-8?B?SWZSdlB0WDRuZHhXMTNtVERPOHcxU0J0UGkzNzR6WCt1WmVTVVh3clNoT3RE?=
 =?utf-8?B?TURtNlNHdi80S010Y21QWFZXZzJaZ2hQOVpmYXl5RGd2NkJad3lmTVNrYlJx?=
 =?utf-8?B?dEFicFhvRmFLcHQ5LzRSbjgwRUsxZnplL3oxL1dweVZTQ2tGd3FLUll4eFp4?=
 =?utf-8?B?YkpMZTUwZ0xmNlBTNnR6VFd0SEtydUUzTUk2YnQvZ1haV1VJK3paVjJYU0ZP?=
 =?utf-8?Q?asSVtBKCEMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHNqam1wNEsva2ZOZi82MU50T1lXSFRRb0NIU0JDSzVWS1hDaVFSYjhIQkpn?=
 =?utf-8?B?MnBhQUFHZTFCNzhGYml0NUlXN0dVQTY5cGFvc2EraTAxd2FUS1lFSytBY2l6?=
 =?utf-8?B?QlFNaDRFcHVTRzVxU2cydmZFUllpM2Y0NWdFb2dWSTcvTTI0a0ZEc1JUdUZ3?=
 =?utf-8?B?TXgxazVCOFBBdjFuS0NhVFN5RzFpajBjTkdKSDNVQ3pEWURHY3FFUGFPYjJv?=
 =?utf-8?B?SEtYcExrU2tlNXN6aFJ0ZUNlbXMrRGt5N1BkS3ZSV1prY3l3bExrc3c5ZmVY?=
 =?utf-8?B?WkFiYUk0QkZ4R3dSY092UHpUb1NBYi9Da1hIaGE4UTVLMGJSS0hoQUNMYUhH?=
 =?utf-8?B?ekN6K0NTSGsvT3RRSGQyVnlRZ01BSzg4cSs3RmZBbWhOZU81SDVvNFc2QjR0?=
 =?utf-8?B?MHBLOXlGYXRreTcyNS90RndrZ3AwOFp5M21FR2pZc2kxaW5MYytHN3dad3Fh?=
 =?utf-8?B?ZlBqZ2QwRnhkZGZsYUJiK3BsNTA3NlJyWm93YlBpQXhwQmhCbmFFY1huYzdH?=
 =?utf-8?B?aEcrSGtqK3R0blFuSlMzVUlnMjhvQTdJUHVOODBFWVlVZ3hLbGVqcmVjdVNV?=
 =?utf-8?B?L1JNR3kzbXllSi8rZzZWZVZ4Zm85QitwMHJ6d0MxUHVnM3NSSTVpNzJjbzcy?=
 =?utf-8?B?Q3ZiVjdUc1JXTGwrU3c1S2RRY2pjVER6NTNjZGI5SkcxYkpRb1AvK1pqMGlY?=
 =?utf-8?B?amxhWFpVcENBMzdFVlk0ODVqSVk0WnUxUzlUT1JRTkc5dlVoOWFNcjdFdWhw?=
 =?utf-8?B?dTZESTJ1dWZUejUyL2JBTlRWTlE0SFBJM1FzQTBHZHAzMGNwTVIwZEl2Wjla?=
 =?utf-8?B?T1Q4ejF5MUQwNGZrSmxZL2hPanVxQlI4R09JbHdEVldPZXd4Ui9KZDRpTlk2?=
 =?utf-8?B?RllMMDZRVjhGb0RvRVI5K3FTTE9nbFZBek43RUQ3bjUyY2N6YzFXZXJKS1lG?=
 =?utf-8?B?SThMdjdSOW8vV1IxMjh6eXJ1emZwSTQ2TUhla1BodDBVTk1vcWVEVkxKR0Yy?=
 =?utf-8?B?d0xTUWt1UGsrRXVuVzlUeG1BcW93cjhWWE5HblVGeEl4bkl1bzBkTlVLdUdS?=
 =?utf-8?B?ejFQanRZYUVTNC9JUGRzQWVXUW1XZUhWSVhuYnMySlEva0MveUw0NE9SL0lN?=
 =?utf-8?B?UHM4UGdQOHdEWDBMYUpRdWlycmREMkNaK3BIZjQycm1TdDJRRTVKSlM2Q0hY?=
 =?utf-8?B?R0pjeXgyR2lJWHJCR1RQdzBKMlZRTStHZVRGTGJGK3B4TWowamdObUcxaU9F?=
 =?utf-8?B?Y0RkYlk3bk8zaEpYMXFTYlQ4ZXJVR1ZQUFhnRXk4bjFJU0R1RUlMM1JQNFNW?=
 =?utf-8?B?Q3EvR2QyYnM4WXFUQ05CQy9VREkweHQ0L3ZKSFBxM3VWMFZZdW83N2trZHM3?=
 =?utf-8?B?c05mVk93YkJLb0dsd2ZEc3I2YlA1TGtDZXRKSTI2Q1A5YXJMRTdud1pHSlBk?=
 =?utf-8?B?UnhtQjlVd3Q0aXVFTy8xSExPNEhmdUt5ZkxHWXVvZkVKTnhXNDd3My8rZmJR?=
 =?utf-8?B?MFE0V2lWaUtUeHVIaVRFN2piWnlRYjE1T0hrMkI5WGQyMWRQUklGaW9vbldB?=
 =?utf-8?B?RVpkaERkcmxDenR2ak10NHJPRlNlS3JOZTFPNG8vRXBUaXlJb1VtK01sZjF1?=
 =?utf-8?B?ZGNGa1RKeGcxTkxtcU94NWZqVUszSlFldi8yNnZEUzBWVW5XZ2tIeGFXRlZO?=
 =?utf-8?B?TDVCekdQNjFGeTBUUEJlZ094RW92SHdBb1ZuUWtUZU5ETlc5QkVUUmdEMUJw?=
 =?utf-8?B?MmZEa1lhK1JITGh6Ty9LVEkweVJvcFR5V3BTZTNzelJpcG5CbzU2Y1NNVkxE?=
 =?utf-8?B?dW5TNzc5M2k4UzZNZzFOUVY2OU9BNjFyVDZlNTRZTExBK3hvTS9rYi91ZjFX?=
 =?utf-8?B?alFrbjZ6SHJta0tTejRsS3F6UXZoNTVObFVaeGUrbWZBOWdNWlZoc3VjbGZp?=
 =?utf-8?B?K094S2M1bnFVZlhoTkRMR0VZZWhvR1BIdnZFYzIrNFpFYlZIQVRwckVuZ2tS?=
 =?utf-8?B?TEhJdzRYWEY3azBKZ2pYR1ZlRHc4SjFWWVVHcCt3bklDeUlyVVBHbWhKREtX?=
 =?utf-8?B?Z1ovc2Y5TndXcytaTVJqYzRpVlJwUUZvc3IydURrbjBFNzRxck0wQTJ0MGZE?=
 =?utf-8?B?ekErYzVBNnp5VStTdEJrZDRNMEZ1ZXNMbnJkVlNTQ3g5cW1IbE1SbXhYaDNZ?=
 =?utf-8?Q?X4N4IMgfk0EZZ6PUYY/rZ4Cfm5pm/oCnltX9qGfbf4w1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237f59e9-74f4-410e-0058-08ddf59937b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 03:20:57.1102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MowUSxVVptBmYq6lrfVUnMJ2xkLCgpw91+b2LwzabuYqjhRp2hYWNyMrI0z6HFsXvl0yREqPRPOF8Z7tsdadKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

On 9/17/25 10:30, Wei Xu wrote:
> On Tue, Sep 16, 2025 at 12:45 PM David Rientjes <rientjes@google.com> wrote:
>>
>> On Wed, 10 Sep 2025, Gregory Price wrote:
>>
>>> On Wed, Sep 10, 2025 at 04:39:16PM +0100, Matthew Wilcox wrote:
>>>> On Wed, Sep 10, 2025 at 08:16:45PM +0530, Bharata B Rao wrote:
>>>>> This patchset introduces a new subsystem for hot page tracking
>>>>> and promotion (pghot) that consolidates memory access information
>>>>> from various sources and enables centralized promotion of hot
>>>>> pages across memory tiers.
>>>>
>>>> Just to be clear, I continue to believe this is a terrible idea and we
>>>> should not do this.  If systems will be built with CXL (and given the
>>>> horrendous performance, I cannot see why they would be), the kernel
>>>> should not be migrating memory around like this.
>>>
>>> I've been considered this problem from the opposite approach since LSFMM.
>>>
>>> Rather than decide how to move stuff around, what if instead we just
>>> decide not to ever put certain classes of memory on CXL.  Right now, so
>>> long as CXL is in the page allocator, it's the wild west - any page can
>>> end up anywhere.
>>>
>>> I have enough data now from ZONE_MOVABLE-only CXL deployments on real
>>> workloads to show local CXL expansion is valuable and performant enough
>>> to be worth deploying - but the key piece for me is that ZONE_MOVABLE
>>> disallows GFP_KERNEL.  For example: this keeps SLAB meta-data out of
>>> CXL, but allows any given user-driven page allocation (including page
>>> cache, file, and anon mappings) to land there.
>>>
>>
>> This is similar to our use case, although the direct allocation can be
>> controlled by cpusets or mempolicies as needed depending on the memory
>> access latency required for the workload; nothing new there, though, it's
>> the same argument as NUMA in general and the abstraction of these far
>> memory nodes as separate NUMA nodes makes this very straightforward.
>>
>>> I'm hoping to share some of this data in the coming months.
>>>
>>> I've yet to see any strong indication that a complex hotness/movement
>>> system is warranted (yet) - but that may simply be because we have
>>> local cards with no switching involved. So far LRU-based promotion and
>>> demotion has been sufficient.
>>>
>>
>> To me, this is a key point.  As we've discussed in meetings, we're in the
>> early days here.  The CHMU does provide a lot of flexibility, both to
>> create very good and very bad hotness trackers.  But I think the key point
>> is that we have multiple sources of hotness information depending on the
>> platform and some of these sources only make sense for the kernel (or a
>> BPF offload) to maintain as the source of truth.  Some of these sources
>> will be clear-on-read so only one entity would be possible to have as the
>> source of truth of page hotness.
>>
>> I've been pretty focused on the promotion story here rather than demotion
>> because of how responsive it needs to be.  Harvesting the page table
>> accessed bits or waiting on a sliding window through NUMA Balancing (even
>> NUMAB=2) is not as responsive as needed for very fast promotion to top
>> tier memory, hence things like the CHMU (or PEBS or IBS etc).
>>
>> A few things that I think we need to discuss and align on:
>>
>>  - the kernel as the source of truth for all memory hotness information,
>>    which can then be abstracted and used for multiple downstream purposes,
>>    memory tiering only being one of them
>>
>>  - the long-term plan for NUMAB=2 and memory tiering support in the kernel
>>    in general, are we planning on supporting this through NUMA hint faults
>>    forever despite their drawbacks (too slow, too much overhead for KVM)
>>
>>  - the role of the kernel vs userspace in driving the memory migration;
>>    lots of discussion on hardware assists that can be leveraged for memory
>>    migration but today the balancing is driven in process context.  The
>>    kthread as the driver of migration is yet to be a sold argument, but
>>    are where a number of companies are currently looking
>>
>> There's also some feature support that is possible with these CXL memory
>> expansion devices that have started to pop up in labs that can also
>> drastically reduce overall TCO.  Perhaps Wei Xu, cc'd, will be able to
>> chime in as well.
>>
>> This topic seems due for an alignment session as well, so will look to get
>> that scheduled in the coming weeks if people are up for it.
> 
> Our experience is that workloads in hyper-scalar data centers such as
> Google often have significant cold memory. Offloading this to CXL memory
> devices, backed by cheaper, lower-performance media (e.g. DRAM with
> hardware compression), can be a practical approach to reduce overall
> TCO. Page promotion and demotion are then critical for such a tiered
> memory system.
> 
> A kernel thread to drive hot page collection and promotion seems
> logical, especially since hot page data from new sources (e.g. CHMU)
> are collected outside the process execution context and in the form of
> physical addresses.
> 
> I do agree that we need to balance the complexity and benefits of any
> new data structures for hotness tracking.


I think there is a mismatch in the tiering structure and
the patches. If you see the example in memory tiering

/*
 * ...
 * Example 3:
 *
 * Node 0 is CPU + DRAM nodes, Node 1 is HBM node, node 2 is PMEM node.
 *
 * node distances:
 * node   0    1    2
 *    0  10   20   30
 *    1  20   10   40
 *    2  30   40   10
 *
 * memory_tiers0 = 1
 * memory_tiers1 = 0
 * memory_tiers2 = 2
 *..
 */

The topmost tier need not be DRAM, patch 3 states

"
[..]
 * kpromoted is a kernel thread that runs on each toptier node and
 * promotes pages from max_heap.
"

Also, there is no data in the cover letter to indicate what workloads benefit from
migration to top-tier and by how much?


Balbir


