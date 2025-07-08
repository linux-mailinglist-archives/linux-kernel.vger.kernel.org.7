Return-Path: <linux-kernel+bounces-721074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79EFAFC466
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DE189F1E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0807299AAF;
	Tue,  8 Jul 2025 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFNIUKLS"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FD1F63F9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960596; cv=fail; b=JVxWtGDz7Ny1ZQkA4Le37IO3dIBUbhcvJ9Tz5Ay9PCBCSHIJIw/YT8vAG/quQQHoHwuFJ9Qv48UpgJToXMYvIgJ+l+1lP1KlWM8Tzc5TvRr37jVzC43FL5uAzX7gRKx/s/f8J9gmSs6gzYdbhwrmuMISA9iWy900UNZSnX9f0og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960596; c=relaxed/simple;
	bh=rhCuFLmdYCAd8nB5YY8qdkNSYsNiIicx9btmOKnHjUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bjBiIj0M+1koABxn3oEA/HWu1GsZnHXrzPwKgl0MHiA51SODjTrO7zfKzHPas4TX+DQBABqNQYmxFMsFJlXddYsQH1R2yHHvXzBuyGyZ36EgQCXP6G7t9513042IZv7UEQoYNHVqyqxJw3ztHbwuKLRk4I0STfPM06W+qsPejXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFNIUKLS; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1FGv95VeZ93B0obVraiI4TukzpIx7an6b8kpTfY3b0zqLmYR2JxxJcKtDHZG35qrL9ZNzmUXbfPaQFOr5S5pwr6GgwBZuRamdKiXJxRzKiK3AyV63Qv7RcNOo/041STWVI+LqQlAlW7H6GxAfjFVMKuXf+z665qveO5DQ+ompSQmsiqA48Voqsh6WT4fhug5ISh6Sd6vOO0goysSfLSJ6Tfj9BK3UwwECZi/zaiiS+B0NycNgPePITPwrEA4GZjgIxeAp1eYhSd3y7t09RsqJ2ypdmuoWqSihFWwuWogcQ6geyLKkJ+0C1XeRJoVGYQJB+8FrFohE0Hq4RlD5Q/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1LQ308snVzUIEa3LUGiNLF9H8kOMgAmm81J73OVRx0=;
 b=rLnKnzp18q6BQQPjmKN4ufs+VblVS3znJn8P0YN1GyHNZOrHtsVZho3iwqlc1kmi/ZS6SEBpZU8FdSp8cgFER0k66ntw36uyS9BF+H2yq6FGhMUGax05RtVXFC6Yr+IjWIWzby/U7UWP68gSyJC3qgIgcsrq0RVMjyP5IhNLdjYWaIewGWe7nYR4n5Wdlbcaq6gMU3N3nrRx7EaEnxGlsOLT3q/VOBfZMNMQMSgJb/qqKiQX6QogiRV4l7HyEtm941djAOxqOWJez30jMwGuCv46t3uX7O1JALQkvsaVHsP+LntInvVJJbld/zKW8Vp4XgVAkXHis4udSHhw7OmbaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1LQ308snVzUIEa3LUGiNLF9H8kOMgAmm81J73OVRx0=;
 b=cFNIUKLSNwwxpJQomTITI33STg8wxjTGkp/Hr8kCg+ewb87bw0bEC7x7Fz2jXJxYpao52EWQ8tjGmYs48DB7pSdWiR+6p6gD/4EMdMY/QObQQqKzqjEI2do1GGkHpQ2kvrZ49AR2O7xKoi5BdY80161V3bwDiax/+hClbjSjrGs4Bqbk7Vs2zZNbGGnfBot6D3rdHlf6NTEnikWa9tbeS9ZVrpcntAhaWMr/AVEMZt/Ve/mujeUkCluXM4BgB6zWe1G1sZ2P4Tq0uJk0DKP4SFbrOCmyNjmOu2HpWK+2NkGfdcBJBVxYcqnv8G/tt+1c546q3pa8iLs+kGpaKSg2Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 07:43:10 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:43:10 +0000
Message-ID: <e4369b0c-c051-41ac-b0ba-65d456e53863@nvidia.com>
Date: Tue, 8 Jul 2025 17:43:04 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 08/12] mm/thp: add split during migration support
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-9-balbirs@nvidia.com>
 <D129A3F2-D79C-482E-BC70-A26C781B149E@nvidia.com>
 <1a451d37-56c3-4d60-8e06-3abae72e6bbd@nvidia.com>
 <007E2728-5BFC-40F9-8B8F-25504863D217@nvidia.com>
 <aa4f94a3-f601-4379-b6ca-4389421ccca4@nvidia.com>
 <906590D4-04E2-40CB-A853-25FE6212700C@nvidia.com>
 <eab52820-813f-4137-b664-c79ba8b453b7@nvidia.com>
 <2BC37A17-1005-4016-B4D8-85832F75C500@nvidia.com>
 <94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com>
 <0d1e51f3-ccea-4255-9c5f-68e5a41da03c@nvidia.com>
 <660F3BCC-0360-458F-BFF5-92C797E165CC@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <660F3BCC-0360-458F-BFF5-92C797E165CC@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH0PR12MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1953e0-9adb-427f-55ed-08ddbdf31606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVE3Zm5rTFFUTW5lQUxEK1pYMjhIODdXbGMyOTluL202WUVrOVRrR050d25W?=
 =?utf-8?B?TFE4RURvTDV4VElPOGdUNm5Nbnc3RzhxdE1Zb0pHaUdIeGpEbllXdUpLdDBR?=
 =?utf-8?B?RG40dWpMM2pVWlRwQkZHdmxPVnlPeTRobDAxWWZkNCtZT1JkbUFQdG9sdmhB?=
 =?utf-8?B?MDFHOU5oNEo3b3B5eTh3M0tXQTQvN0JNU1VvLzRYK0pmd2pRdGg0QjQ3aktC?=
 =?utf-8?B?ZXc0eU9VdkdBbGhPdGV4ajR1Y3RNOU5iTXd2Zm1wQ1Uyenk4VGJJQXdxOW16?=
 =?utf-8?B?RmlRRGNINWhtVlFnSUFLUmJuRmNReDR1UysxYjRNeWo2bXFXSGJlS1VybW9I?=
 =?utf-8?B?OGgrbU5RSjJrZHZ6cTBnR2pEeUdjNjhqUjl3R0JGdXRTbjgyWm5HTEM0eHpG?=
 =?utf-8?B?RE4wa3JZZDVJSkdXSlpCUUd6TVBaRndPSmNmVjhxVkVLWTZqYzR3NVBFTlo3?=
 =?utf-8?B?TVlMYXpUMVJUa0RpZ01CNEt0MWQwb2taVTJCN0RZTUphRFY0ejN2ZkloUlVo?=
 =?utf-8?B?Rmd0Y21RUXhyMnJUSUlNaEROV0Era0FVbXIralNjSThVMGxSUHhVbURYVzVw?=
 =?utf-8?B?ZjBtRmRiMER2NnFLY2lGWkw1K2pkVUJqUmpYU3k0QXVNbEdpU2dyRnBRbG5u?=
 =?utf-8?B?Um9JdUFTSjBlZWloa0VsSFlTenJ2bExaTlk1T1RDV0tBZVpUMk45L3l5MFA0?=
 =?utf-8?B?VUJRNnFoOWpTYkNKdkhJM2NodEJKUTJaMHNPbDRaV2V0TjYrTnRYbWtIT2wr?=
 =?utf-8?B?djBBdUM2SjhTU0VaOFp5T1V5S1RGQmRqdDdMbHgrcjJ1clFiSlFEZ2dYT0xv?=
 =?utf-8?B?RWV2VHQ1S0xiaDBvbFIzS0ExUUJ1R3hmeFBLTE94Z1lNV3E1UzZ4UW1pSlhT?=
 =?utf-8?B?RTRnZEFOeldiMTV2bWxNQndRdC9OcWZINVJWdWpEZzB4VXdrcnYreTJvdjBC?=
 =?utf-8?B?YU1vazI0V3FBUURCNDRYYnRPT3VLdjlZZEJlUkMrWXAwSS8xb2FPTGhERGs3?=
 =?utf-8?B?YkZiVGdQRXkvelFQM3l1TDdvZ1VzeEpWZUNuWDdjL3FhVGR5Y0V5a2xkdGJK?=
 =?utf-8?B?UWZ5OTJrUXhlMXJUb09KbFo2Y0hsMUFGWmdqNm1pOTRzSm8wWUF6Ym94M1c2?=
 =?utf-8?B?Z3NVK0FpRmJmVGk4OTRJeXppeDJQZGJSaHI3M2VPTlZuS0g4ZzdjbUhkbFE2?=
 =?utf-8?B?VmVhaFpucTJ2N2JsL28xRTFaMDVWaFV1aXd5ek1yanZmVy9wOGl4dEdBcm10?=
 =?utf-8?B?MitSOWJ3SlZrN1dJVHFJdW1KR25MR3BJNzN1WlJNcWYvNUxZcHV6Qk04WGI1?=
 =?utf-8?B?elhWa1ZtK21kQmtkTml6SUR0UUNYYjlRdEMwdlZGdXpWd2FwUHNrNGpDWDhC?=
 =?utf-8?B?UHBXU2JTMVRVSGJPdTJpUm5UL05lTzBRNGl4cW56RXlza1hhY1JzanU1aFJK?=
 =?utf-8?B?TXdpYVN2YXdxYVlSNUJUdWhIZ20ydkQxUy9xckZoYUZqanVVMG93eWppSUtp?=
 =?utf-8?B?S3ArZFA2Q2FXNmNzRjJPSVVJZU1JRGx0WGpPZEhBajlRUnNDK2grQWNBN04r?=
 =?utf-8?B?Rjc0SHZMLys5UmVSbHdxZE9oTDBGRmYvVmxtZ2hWSHYrOENxS2hjaENSWU9j?=
 =?utf-8?B?VVBNRm5vVEFDUm8yYmt2YUkva3hyVWFKTWoveWVZWVdaVTEzQlhmUHNSNUwx?=
 =?utf-8?B?VE5jWC9BNjNXUnRaOHhpR3VlVldDT1FTL2l1MnRVQ1hablRHYlQ0dUg0ZEhw?=
 =?utf-8?B?M00rbjdwcUpQdXJJaVJrUVdyRzhIWFUvT3ROdndnbW1wY3d3TVNWMmMxVjBl?=
 =?utf-8?B?VjhZeTF5eis4YnRpUCtLMzNNZWtURTBtTVpCWGhGSE9aYk1Ib0lvR2xtMjBM?=
 =?utf-8?B?OVBnTWtLNElzdlhMbDY2RzhKaHFDcXNDK0Q0MnowYURGYlRtVVVGL0dRaysw?=
 =?utf-8?Q?ViVAp8KRihM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHJOYjliMjU1dnhrYXYrcVhCSEdPZ3FvRjJueXBQSzRCelhTQkR5L0pGSkFm?=
 =?utf-8?B?R1JKTzVrUlpQRkRuZTUyMVpQME5DWGJQdWtYbXdKQWVBbkdjcWg1bjdaYmhH?=
 =?utf-8?B?VTZDVHNMNCttT2Y2N0lDU3g4eUVmbjdqczU2OTZ0UFlYWE4yT3F3KzYrQWJv?=
 =?utf-8?B?NEFuRmdBamtaQk9kN0VRSXRHenBtVVp5QmtWcFlVa01NbVJKL1pBbkJUMytK?=
 =?utf-8?B?MSsycGJ1S1N3T2pzN01YbHlSZWMwRzgraHJnTVZBNlc1NEJsOThxVzd0S0wr?=
 =?utf-8?B?Y2xmcTZLNS9TWWRqUDRTZGl1bWdkdGRhV0s5dlRGcDVNY1IrbjFhd080RC9H?=
 =?utf-8?B?bjNiR1BJYm1wN0hyU0RrbWhNb0pXQkxobVZGYVFjQjJGdUtlQi9vc25BSVQy?=
 =?utf-8?B?MWh4ZUlKT2xhV1VKRENjdFVxOUFRUlFyamQ0b2NVVUdzeUxLK0NGNlE3OXdh?=
 =?utf-8?B?WmV0b09ZQ0l6WWhFU0FPSThZakRxRXhHSzc4Vy8weVRUT1lpMjdlcXJvRUhK?=
 =?utf-8?B?dllvUXB2TU5nTW83cXVNVXdwZEtEeG5pbkdYakVSc3ZHUHZYTUpBaGVsUUdX?=
 =?utf-8?B?OXBCZiticFNsM2xpSE85ajB5aUxEN0NiRzkyTWM3bldROGFjNEpFZHB1Mis5?=
 =?utf-8?B?YXYvOHBrV1RBV2pzUWJoSFk2NlhIY01ZRVR0eHhWS08wUy9CSktwWHpsdXhX?=
 =?utf-8?B?S25UOEp6Q3ZBaHBTMkpXbUVPNFVYeWpWTmwvb0pjU3k3SnB3TW1PeUgwd1hi?=
 =?utf-8?B?QzBKWithUlNlbGFpWGdKc0ZzNzhFeDY2T3gzMlZFeFgzNDRaRUo3M0xUZ096?=
 =?utf-8?B?bWh2dHVPRXpibTVSc3NWYWxvTGY4dEU4V3J2NUVsUTdjUDFlb3pkQUN0RWZT?=
 =?utf-8?B?S3VjR3RQdXVOVzRVL1BCbTFqU3lrdEZpbFErZkNTbnh2Z284cjFkZ2tzWk5Y?=
 =?utf-8?B?VHV0bEtvZUJoQVhzeVNic2VZV0djcTVkaktIN1Yyb29SV2lNaDNCSGp1Vjhy?=
 =?utf-8?B?T0JMemVyQTN1ZmIwby9KNm5nU0lLS3pYODVZZEx2MlFWcEhOM0xxd1ZmaGtJ?=
 =?utf-8?B?ZEx4Slc3eC9VL1ZXNnlhN042TDdxTys2TTZRSHZlUU1BUDRpZENyaVR0N01j?=
 =?utf-8?B?OXRvS09lNHVQR2ZBRCtuaXRLUE8vaHc2aGRmdEpRbDEzUGlWMzBPVWJRWWFE?=
 =?utf-8?B?cnNlcFRXT1JWVzlKRksyTERqbnhNb3hJVzZvOU02N3llT2tzYXM0NzZyMXVB?=
 =?utf-8?B?RkVtNGVmOHE2elhrSGlGcmxGcStzWDIvNFZFeExRcVBrd2F0TXZlV2c2emFa?=
 =?utf-8?B?SlgyK3RVL2tZSWJLZWVtU1BjNUo2cDEzVUN4WkFva1V2RStqaUoweDdLR0J2?=
 =?utf-8?B?bWgvckVIdlozZkJ1dUhGSDJNdndjb2NQSXhFR0JhejQzMnJKZS9MQXFva25r?=
 =?utf-8?B?M3RpZVZYRTV5RjBucUpISmYxYkZ0dHNLT0ZVcllPRnE1QSt2L0doSDhhV291?=
 =?utf-8?B?cnF1UG9iVW9YT3Vzei84REloVzhGYVhkTHptMlhhbm9YSExVT1VuaVJyRXFw?=
 =?utf-8?B?MGt4Z2drZnJ5dFBHVnFEdFZnNFV4clhxelV2Mm9MZFB6cFAycDZqamk4OCtZ?=
 =?utf-8?B?SE5RNlIzMEY1NWVWRGVxK0lJK1NZY1JPakJKTHdpWWhyMFNqM3lBZ2xqSno4?=
 =?utf-8?B?citXOWovcXpIYTVMQVdNRXRmZ1BCTFlHamVDcE1GM29Ic0pDdTNqQk5Ob1dQ?=
 =?utf-8?B?NVRqY2k0ZVpXdzBDS2JYR1NUWDkybUowUWY5THRveXBUMHJBcWhvazlTRFU1?=
 =?utf-8?B?czhaOXBZUzk5YVprMmxuTkxJbnIvK0Y2eHg0ZU1FeVVmMnBPbSs5T2dSTlFl?=
 =?utf-8?B?NUxXMnlCK1hHRDJGZnNXK0g0amlJZXBoeVRlOEdTQmN0YU1ibVcvdXpJRHJN?=
 =?utf-8?B?aU9GQUdobm1LQm9SeE1aOEUrTHpya2tpcStGRkEvUEZjUEZ3VDRGeE5VVGNT?=
 =?utf-8?B?UDVXK09yay80TEZuSXYveXBhR0RFWnhOUXJ5MVhKcHBjMVh6VHBhR3RyUWRp?=
 =?utf-8?B?Mmo2RjVSYUNRcS8vbkdlbkR1Tk1ML3VvNFhEZ2ZmTndHd00wZzhSc1pwd3M0?=
 =?utf-8?Q?I+JgviULROqD2lO4eMHg0/Di1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1953e0-9adb-427f-55ed-08ddbdf31606
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:43:10.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0Mymx8ThC05GyB+oIjkVMWpDB70bIAiD01gsIKw9EMB2eMR1RjGTPYgFuY1QHbLalHSdnAD09vPqvQrf3Xc+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632

>>
>> That sounds like a plan, it seems like there needs to be a finish phase of
>> the split and it does not belong to __split_unmapped_folio(). I would propose
>> that we rename "isolated" to "folio_is_migrating" and then your cleanups can
>> follow? Once your cleanups come in, we won't need to pass the parameter to
>> __split_unmapped_folio().
> 
> Sure.
> 
> The patch below should work. It only passed mm selftests and I am planning
> to do more. If you are brave enough, you can give it a try and use
> __split_unmapped_folio() from it.
> 
> From e594924d689bef740c38d93c7c1653f31bd5ae83 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Sun, 6 Jul 2025 22:40:53 -0400
> Subject: [PATCH] mm/huge_memory: move epilogue code out of
>  __split_unmapped_folio()
> 
> The code is not related to splitting unmapped folio operations. Move
> it out, so that __split_unmapped_folio() only do split works on unmapped
> folios.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 226 ++++++++++++++++++++++++-----------------------
>  1 file changed, 116 insertions(+), 110 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3eb1c34be601..6eead616583f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3396,9 +3396,6 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   *             order - 1 to new_order).
>   * @split_at: in buddy allocator like split, the folio containing @split_at
>   *            will be split until its order becomes @new_order.
> - * @lock_at: the folio containing @lock_at is left locked for caller.
> - * @list: the after split folios will be added to @list if it is not NULL,
> - *        otherwise to LRU lists.
>   * @end: the end of the file @folio maps to. -1 if @folio is anonymous memory.
>   * @xas: xa_state pointing to folio->mapping->i_pages and locked by caller
>   * @mapping: @folio->mapping
> @@ -3436,40 +3433,20 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   * split. The caller needs to check the input folio.
>   */
>  static int __split_unmapped_folio(struct folio *folio, int new_order,
> -		struct page *split_at, struct page *lock_at,
> -		struct list_head *list, pgoff_t end,
> -		struct xa_state *xas, struct address_space *mapping,
> -		bool uniform_split)
> +				  struct page *split_at, struct xa_state *xas,
> +				  struct address_space *mapping,
> +				  bool uniform_split)
>  {
> -	struct lruvec *lruvec;
> -	struct address_space *swap_cache = NULL;
> -	struct folio *origin_folio = folio;
> -	struct folio *next_folio = folio_next(folio);
> -	struct folio *new_folio;
>  	struct folio *next;
>  	int order = folio_order(folio);
>  	int split_order;
>  	int start_order = uniform_split ? new_order : order - 1;
> -	int nr_dropped = 0;
>  	int ret = 0;
>  	bool stop_split = false;
> 
> -	if (folio_test_swapcache(folio)) {
> -		VM_BUG_ON(mapping);
> -
> -		/* a swapcache folio can only be uniformly split to order-0 */
> -		if (!uniform_split || new_order != 0)
> -			return -EINVAL;
> -
> -		swap_cache = swap_address_space(folio->swap);
> -		xa_lock(&swap_cache->i_pages);
> -	}
> -
>  	if (folio_test_anon(folio))
>  		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
> 
> -	/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> -	lruvec = folio_lruvec_lock(folio);
> 
>  	folio_clear_has_hwpoisoned(folio);
> 
> @@ -3541,89 +3518,10 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  						MTHP_STAT_NR_ANON, 1);
>  			}
> 
> -			/*
> -			 * origin_folio should be kept frozon until page cache
> -			 * entries are updated with all the other after-split
> -			 * folios to prevent others seeing stale page cache
> -			 * entries.
> -			 */
> -			if (release == origin_folio)
> -				continue;
> -
> -			folio_ref_unfreeze(release, 1 +
> -					((mapping || swap_cache) ?
> -						folio_nr_pages(release) : 0));
> -
> -			lru_add_split_folio(origin_folio, release, lruvec,
> -					list);
> -
> -			/* Some pages can be beyond EOF: drop them from cache */
> -			if (release->index >= end) {
> -				if (shmem_mapping(mapping))
> -					nr_dropped += folio_nr_pages(release);
> -				else if (folio_test_clear_dirty(release))
> -					folio_account_cleaned(release,
> -						inode_to_wb(mapping->host));
> -				__filemap_remove_folio(release, NULL);
> -				folio_put_refs(release, folio_nr_pages(release));
> -			} else if (mapping) {
> -				__xa_store(&mapping->i_pages,
> -						release->index, release, 0);
> -			} else if (swap_cache) {
> -				__xa_store(&swap_cache->i_pages,
> -						swap_cache_index(release->swap),
> -						release, 0);
> -			}
>  		}
>  	}
> 
> -	/*
> -	 * Unfreeze origin_folio only after all page cache entries, which used
> -	 * to point to it, have been updated with new folios. Otherwise,
> -	 * a parallel folio_try_get() can grab origin_folio and its caller can
> -	 * see stale page cache entries.
> -	 */
> -	folio_ref_unfreeze(origin_folio, 1 +
> -		((mapping || swap_cache) ? folio_nr_pages(origin_folio) : 0));
> -
> -	unlock_page_lruvec(lruvec);
> -
> -	if (swap_cache)
> -		xa_unlock(&swap_cache->i_pages);
> -	if (mapping)
> -		xa_unlock(&mapping->i_pages);
> 
> -	/* Caller disabled irqs, so they are still disabled here */
> -	local_irq_enable();
> -
> -	if (nr_dropped)
> -		shmem_uncharge(mapping->host, nr_dropped);
> -
> -	remap_page(origin_folio, 1 << order,
> -			folio_test_anon(origin_folio) ?
> -				RMP_USE_SHARED_ZEROPAGE : 0);
> -
> -	/*
> -	 * At this point, folio should contain the specified page.
> -	 * For uniform split, it is left for caller to unlock.
> -	 * For buddy allocator like split, the first after-split folio is left
> -	 * for caller to unlock.
> -	 */
> -	for (new_folio = origin_folio; new_folio != next_folio; new_folio = next) {
> -		next = folio_next(new_folio);
> -		if (new_folio == page_folio(lock_at))
> -			continue;
> -
> -		folio_unlock(new_folio);
> -		/*
> -		 * Subpages may be freed if there wasn't any mapping
> -		 * like if add_to_swap() is running on a lru page that
> -		 * had its mapping zapped. And freeing these pages
> -		 * requires taking the lru_lock so we do the put_page
> -		 * of the tail pages after the split is complete.
> -		 */
> -		free_folio_and_swap_cache(new_folio);
> -	}
>  	return ret;
>  }
> 
> @@ -3706,10 +3604,12 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  {
>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> +	struct folio *next_folio = folio_next(folio);
>  	bool is_anon = folio_test_anon(folio);
>  	struct address_space *mapping = NULL;
>  	struct anon_vma *anon_vma = NULL;
>  	int order = folio_order(folio);
> +	struct folio *new_folio, *next;
>  	int extra_pins, ret;
>  	pgoff_t end;
>  	bool is_hzp;
> @@ -3840,6 +3740,10 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  	/* Prevent deferred_split_scan() touching ->_refcount */
>  	spin_lock(&ds_queue->split_queue_lock);
>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
> +		struct address_space *swap_cache = NULL;
> +		struct lruvec *lruvec;
> +		int nr_dropped = 0;
> +
>  		if (folio_order(folio) > 1 &&
>  		    !list_empty(&folio->_deferred_list)) {
>  			ds_queue->split_queue_len--;
> @@ -3873,19 +3777,121 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>  			}
>  		}
> 
> -		ret = __split_unmapped_folio(folio, new_order,
> -				split_at, lock_at, list, end, &xas, mapping,
> -				uniform_split);
> +		if (folio_test_swapcache(folio)) {
> +			VM_BUG_ON(mapping);
> +
> +			/* a swapcache folio can only be uniformly split to order-0 */
> +			if (!uniform_split || new_order != 0) {
> +				ret = -EINVAL;
> +				goto out_unlock;
> +			}
> +
> +			swap_cache = swap_address_space(folio->swap);
> +			xa_lock(&swap_cache->i_pages);
> +		}
> +
> +		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> +		lruvec = folio_lruvec_lock(folio);
> +
> +		ret = __split_unmapped_folio(folio, new_order, split_at, &xas,
> +					     mapping, uniform_split);
> +
> +		/* Unfreeze after-split folios */
> +		for (new_folio = folio; new_folio != next_folio;
> +		     new_folio = next) {
> +			next = folio_next(new_folio);
> +			/*
> +			 * @folio should be kept frozon until page cache
> +			 * entries are updated with all the other after-split
> +			 * folios to prevent others seeing stale page cache
> +			 * entries.
> +			 */
> +			if (new_folio == folio)
> +				continue;
> +
> +			folio_ref_unfreeze(
> +				new_folio,
> +				1 + ((mapping || swap_cache) ?
> +					     folio_nr_pages(new_folio) :
> +					     0));
> +
> +			lru_add_split_folio(folio, new_folio, lruvec, list);
> +
> +			/* Some pages can be beyond EOF: drop them from cache */
> +			if (new_folio->index >= end) {
> +				if (shmem_mapping(mapping))
> +					nr_dropped += folio_nr_pages(new_folio);
> +				else if (folio_test_clear_dirty(new_folio))
> +					folio_account_cleaned(
> +						new_folio,
> +						inode_to_wb(mapping->host));
> +				__filemap_remove_folio(new_folio, NULL);
> +				folio_put_refs(new_folio,
> +					       folio_nr_pages(new_folio));
> +			} else if (mapping) {
> +				__xa_store(&mapping->i_pages, new_folio->index,
> +					   new_folio, 0);
> +			} else if (swap_cache) {
> +				__xa_store(&swap_cache->i_pages,
> +					   swap_cache_index(new_folio->swap),
> +					   new_folio, 0);
> +			}
> +		}
> +		/*
> +		 * Unfreeze @folio only after all page cache entries, which
> +		 * used to point to it, have been updated with new folios.
> +		 * Otherwise, a parallel folio_try_get() can grab origin_folio
> +		 * and its caller can see stale page cache entries.
> +		 */
> +		folio_ref_unfreeze(folio, 1 +
> +			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
> +
> +		unlock_page_lruvec(lruvec);
> +
> +		if (swap_cache)
> +			xa_unlock(&swap_cache->i_pages);
> +		if (mapping)
> +			xa_unlock(&mapping->i_pages);
> +
> +		if (nr_dropped)
> +			shmem_uncharge(mapping->host, nr_dropped);
> +
>  	} else {
>  		spin_unlock(&ds_queue->split_queue_lock);
>  fail:
>  		if (mapping)
>  			xas_unlock(&xas);
> -		local_irq_enable();
> -		remap_page(folio, folio_nr_pages(folio), 0);
>  		ret = -EAGAIN;
>  	}
> 
> +	local_irq_enable();
> +
> +	remap_page(folio, 1 << order,
> +		   !ret && folio_test_anon(folio) ? RMP_USE_SHARED_ZEROPAGE :
> +						    0);
> +
> +	/*
> +	 * At this point, folio should contain the specified page.
> +	 * For uniform split, it is left for caller to unlock.
> +	 * For buddy allocator like split, the first after-split folio is left
> +	 * for caller to unlock.
> +	 */
> +	for (new_folio = folio; new_folio != next_folio; new_folio = next) {
> +		next = folio_next(new_folio);
> +		if (new_folio == page_folio(lock_at))
> +			continue;
> +
> +		folio_unlock(new_folio);
> +		/*
> +		 * Subpages may be freed if there wasn't any mapping
> +		 * like if add_to_swap() is running on a lru page that
> +		 * had its mapping zapped. And freeing these pages
> +		 * requires taking the lru_lock so we do the put_page
> +		 * of the tail pages after the split is complete.
> +		 */
> +		free_folio_and_swap_cache(new_folio);
> +	}
> +
>  out_unlock:
>  	if (anon_vma) {
>  		anon_vma_unlock_write(anon_vma);


I applied my changes and tested on top of this patch. Thanks!

Tested-by: Balbir Singh <balbirs@nvidia.com>


