Return-Path: <linux-kernel+bounces-720994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3ECAFC313
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C54D1642CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B312222C3;
	Tue,  8 Jul 2025 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CeFXos50"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DA221FCB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957269; cv=fail; b=Tf/1pygrLat6fQ/Sy3SgvsHSpqXr/nFjoJoKyUrqgID9t/3laLdiGS426nTMrmWkgHkeLinxPm1SPDT6zEVEqmQHYQeHVCRNXp2X/uTR9Y9Nw9jP+6OoFkeUvJlkFaSsgSimRhz98SFOmTS6wyqEOMdL17j6bixcbGXpyNtgg1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957269; c=relaxed/simple;
	bh=t0aFPmEg1J3FWzASyDsedcl9qx8T4q45tVDBkGRYzPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B5+O4EJEFw5nvvO7Brze8bz4FEHE8HsWbmtttowGgQeQLo8rdVmgivcT4nf5xDWDCD+taCqSlx1QPw8MEN8vZtsGV2DriC5UMX9Th0fXO5Yey0scC2Coi/87BOX5hPcvww3cqWOSXTNfnfwI2Sgtr5bu2HFftJYm1JT4si0wyLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CeFXos50; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxL+5JTNJULLuidTJWVm4ZTEu3KejXsc08D9ba6JzFmwastmTXTMwv+vs5EIPnU5jfIP7mY0ZcolGHyFVx/569L2FJeSfPP/6QDWKpQ2kcAVRstzH3qs5XyFx3QyxNvDgRnV/gr58d3WzNeWBJ33pgyWPCW1d9zsZrjEEoONWyV/HXFSTKDU2hc4vn5xyti6F/4yOoA39W8H4zxpJWYGf8QLZEzYUmV5XiKpHeeMOVXMAHrrbIabdYD7JyYL0JGwnFcvpRjCcQxT/Wph2Kgzc7ZKpFoAVIBe6ZNQJuVCXc/4yV8nUEfb6WL2WfN3TSi1QbPsSGYNyT8ttUYFQi42pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHXt7H+zYkQd/ni2yrq+/2Kfc4YxO5tUcxOr8hL5bfU=;
 b=bDSXh81y5KmhCgW+j8Y6RYste7dgd9XO9/txPKrI8tOCuMvMKaJMjw1njPo8kVYpsJ1Dzrx0g+t2UigtxS4wvvtdxcxTzKqQYVEWxIUjlcQ28xs5EtMEvpHhnG3BaZhTJy5q0K3p0CfhfUi+1qWhVHZ1nPK5vE+PWy7Nj+G+J0SkXWmfQOJ4cSLH0oOeoiz/Dk0dqG5i5/dNAB7cj8/wYp3PX1p3vkA9lCaR7eXBAymEAqUUMiqvrWXiq9SkBL4Kje3sCtcZ2177fxA8j1rioUzSQtWO7BEvi1H38xaBtX5/H/a4VmWE3olvzM7C98pDOv/dsVXZqiZBULIkcrVPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHXt7H+zYkQd/ni2yrq+/2Kfc4YxO5tUcxOr8hL5bfU=;
 b=CeFXos50hm9KOeU/OYjkZnnyPd/WvhlPmPcevefvuRjRVwt2SPyz7WJQFa0pGBTbJHfhvIrCoqdzwMwPEWnp1lFRVptVs20pmpDuVUtAZHy4z1/BzvU6hyAgchAsQUBKdiIl9gOE2Bq5lquEEOH+etYqvTFY5+vl9WdSuIERt0gQF4mR3S4seYJPcRXQ1gSWGejA1blMWgZMfFPM5+vJef3crsBK3+Y2d/Nb3vccQ/VXLLpfWeD3mLHsZD0C+y18Z//9ddMpKbAvZ2oJsPOOJPvqQdPIz2tmpJDd6eIa//mKMIV0cCojAHjdxyHJPlyviSmu/pVlF3yFJsMfeuBmag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 06:47:42 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 06:47:41 +0000
Message-ID: <f7abedaf-abf0-49aa-b152-31250f2ba7ba@nvidia.com>
Date: Tue, 8 Jul 2025 16:47:35 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 01/12] mm/zone_device: support large zone device
 private folios
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-2-balbirs@nvidia.com>
 <2lhuidibe4vn2wvoswvf5s35s6yv5iflgkwo7c6q6uvy3khe3a@qsunrew5l4re>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <2lhuidibe4vn2wvoswvf5s35s6yv5iflgkwo7c6q6uvy3khe3a@qsunrew5l4re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::19) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e8f131-c149-49d6-8760-08ddbdeb5623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUx1ZWFYSGZXU2xUckc4L01QaWpJekxmUHcrbVBZTiszclFqUi9FTUFlWEFu?=
 =?utf-8?B?c0FybjBRU0REaUNWT1Nxc29wcm1CZ2lnZnc3bExVQUYzNnFib1RUdncxK0My?=
 =?utf-8?B?VjVqRVVzaG5HU3RxZURQeHhBT3p5SjVBcWd5VENyNTFNVFdra05JOUluTy9W?=
 =?utf-8?B?Um9zamNkOU9jS214VnJsLzZYcXJQaWQ2U1VHUm90NjRXa3NQR1pyTUR3c3ZB?=
 =?utf-8?B?ajlNcVJhVzdvNkZiVTU3SFRjVmpTa3B0bndYYUt0dW50Ymdvc1FQNE9tdHpl?=
 =?utf-8?B?alNYWU84VDFqNXEyODBtb2R1Sk1LMkNyU0FaNTJ0S1RjNzViTnRlZS9WUFRj?=
 =?utf-8?B?QnVQOWFTUHRiQjE4Y2FMUFNqbWwzQXdnNTlNcml6cTU0eHZmWFYrYzgrcE0y?=
 =?utf-8?B?Vy9MT2RnM3FiRG9JSXdOZDROdkhsRWJPRVhHdFZIamthRjhYSTlwOTYzLy8y?=
 =?utf-8?B?Q1gyWXpNMWtxc1dYVW83RDhLV1JwL0RZQ05vN0ZTdUZ2WkxPS0FLNHVzQTda?=
 =?utf-8?B?MW1qTk1UZ2xFb05sbXExeDllQ3JHMFdVTE56NTM0djNPUGV2dkNqdnhnU09h?=
 =?utf-8?B?WXlNSGttSkRuU0FBSnVEM0w3dkpmUlcwc1lQV21qWlR0V3VuQXQ2Y09mMlV2?=
 =?utf-8?B?WTNZUlRvUGo0cGx5TjZockVTdzV4N0xFd1NUY3BuMDd1NHFwQ01aeC9rM1kr?=
 =?utf-8?B?eTZLYUxTaEFzZTlrSFFEZVpUQWFBNUU1NkdraVNuVFMzQXpqbjYwT003Ukx0?=
 =?utf-8?B?S2xJNnZzUFJJNmpKbzJqMENJV3Fvd2JiOEJkVWJ4WjVtL2lTSXJVeUhReEdF?=
 =?utf-8?B?amh3bndpcWlpQnZaaG45akNZWTd5OHg2QkplWTJyNy9NekoyMERmd1NCMkZC?=
 =?utf-8?B?WG9pcWFiaS9JbVZKajFjMDV3NHdveE1TL1JXUkc1c0NSSGNzeXBwcmZ5Zisz?=
 =?utf-8?B?RmlESjVLeTVOTEhxdWg0VCtQby8xSkUzK3JueWJKN3czOHc2L3JRRGRyUEh5?=
 =?utf-8?B?aEdqMWZmSHM5dEppSzlOS3NkaUpBMzc4QXhYK1NJL09VQUJjbnpIMFVkUFBE?=
 =?utf-8?B?R2FEQ2NzZm5HRVhYNEF2SEhNSTNTTG5wdDh2azdndDZYdnAzOE5pblQ3ZVp0?=
 =?utf-8?B?VVFadFV2WG1tMTJ5UzVGMnkrQ2RxbGticGVsY2F2Nlo5alM2Z0NuczJBTVNh?=
 =?utf-8?B?eXZYSldwUDVQQ2RBNndyLzd0V0MrQ1ZsdEVGbU52TmJrQ0NCY1FVcjJrcmkr?=
 =?utf-8?B?bHV4TFU3YkkyUzYzOEdkN2hrQUNkTmxMd0lGZHJTMm9mZ09UNVFKYnkwMSts?=
 =?utf-8?B?ekZyY3VpQmFJTGVrdVlyeDJKQXJXWW1qSVRCZFF1VktoUVhGZXZ3MDJaTDlh?=
 =?utf-8?B?d0F1eVB3SHZteXo1QnRKaW1Vem15MjZWUWJ5UnFmOE5WMXY4MmxiVGFFbVc0?=
 =?utf-8?B?SVR5c2g0TUw1bGpTUlNiV0xuMTRaVkZ4TE1zL2JOaUhjZ3ZEMVJCMWovQkoy?=
 =?utf-8?B?eG44ZEM5RnptZWh6d3Q2VlRVNlVTZzFyZ0I5bzF5Zzl4TnpNRnZmdmM4NlpP?=
 =?utf-8?B?U3RwcitoZGVrZGhXSnJGNUVqODN0WWlHcXZBbzk1SGRZWStOYnY4dHk0cGNm?=
 =?utf-8?B?UXZPWlNWNEFCNk93VkVKREtzazBxSTNDcndXYXVpOCt5alZxOFlqOXc4Qmxr?=
 =?utf-8?B?dTB3ZmF0NERYOWcxK1J5cWZXU1ZHdXQ1UEcySndMS0Z3MVZ6Nm5rM2hvRzYv?=
 =?utf-8?B?WlhtK29wYlI2ejRXbFRmMEV6MGduNHhEVHBtQ3ZOTzFNQXJNVEk3VEtHK1Ez?=
 =?utf-8?B?UThCaHRvQWJPamNQeEhrbFVzTjBOV3pwbjRpazVnUjl0TnlRMUlRaVZOZXI1?=
 =?utf-8?B?aWUzd0FmdWpDY0FxRjloaVFMVHB1UHNBWmNHcWlQTGwrTWhmZlRQWHhiUUcr?=
 =?utf-8?Q?mWvVP5/6k7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ljQU90ZnZzSU4wbnZ6ajFxaGFlSFk1OVRqY05lRnoydGp0bmNHVlhRVURj?=
 =?utf-8?B?Y0xMY2NEck5qZjhRV0t0V1FObGlPc3FlY0FZZ1NqRUtNN29BVkJMQm9vWFhP?=
 =?utf-8?B?ZnZFZE00bzBKV3d6YWFpQjN3dmI2amowcnhZQzJTaXd0dnVtU2NqZ2JPZm1i?=
 =?utf-8?B?eWVIMHpmRTBCb2x3ZEhvSDRUSG0yY29hZkJjMC9ZUlJBVTE4K292d21BZU5Y?=
 =?utf-8?B?eTloS0J4NXk4dUt0Q0dqQWRhZ3MzRWQ5Y1BOZFExRE5Ic25QYnBYR2J2SWo1?=
 =?utf-8?B?TXB5UW5jVmF5SThrSGI5dzFoU3grd2Zkcm9WREZuTStBQy92OTAxNkRwYjRO?=
 =?utf-8?B?a2ZtQWlFRGorQnY4YlA4Ty9GSUdLT1BpN0ZuVzhEUk5xRmthTGV6S0FmQjMv?=
 =?utf-8?B?UEU2VmNZQVFkSWEvT3ZGQTc5RXlFd04yUDl2aFdaWW4ydE5MWTExTGI0VytV?=
 =?utf-8?B?NlZBWDNNRTNIekV3SW90dVAvZWxyc003ZWtuUXQ4MDVRNytOblp1U0NGVVc4?=
 =?utf-8?B?UStNNFJYT2F2RndCR0dCb3ZtcXpjbDBPdTF2dUNvb0Z0VzRFRDhiTlVyNmVD?=
 =?utf-8?B?djZtdFIrYnNTWVhkYisyQUV3dVRzSzBDdSttZnljRG9sVkszZHNjS0ZZQ0ZZ?=
 =?utf-8?B?ZXpFQVZJYTBaWUVGWE0wTjJoS3REeTYyUU1OMzlSd0xtWDZIaWVGcWJWN2F6?=
 =?utf-8?B?TDY5c0Fyc0VKRUxIN3Y0ZzYydmtxTHdEUnFsRzB1SkZ0NGlXZ0hjbkZYWXdq?=
 =?utf-8?B?dmZZVEo3QldRV25mRCtIdTlpK1IwMTMvNm8zTEZwWHJIT2tLSCtDdzNxNmVx?=
 =?utf-8?B?VmxWNzRWR3hJeXNpRXhmZHFRaGozWndiZGsrUmp2RG8vY0FRcFpla0puLzhX?=
 =?utf-8?B?aWtTZmpVM2pTQmxpSjZOTHkxa3FrdzVzRHFtMnhIb0RvbVVoSDdVUGdzVStq?=
 =?utf-8?B?Z3VEWERURWJPQjh3WnlyaGlvSnVRTmNGbVdrQXVHUWJ3VDVpTmhObmVwTDBh?=
 =?utf-8?B?emgrbko2dURnMTBBL21YSzlwczZ2dm9xT0lMMUlyWnV3NDFZTWtVZk4zN01v?=
 =?utf-8?B?Y05QTHBJMVN6RlpqZ1dOdDhNa0x4OW10TlBrdGc0K3hPWDcwdGZOMHlUbW1J?=
 =?utf-8?B?M0dxZUgweG04TkVKRmRaUWozZXlKRGd0eDBtUWthZVV1c29JcWlJdVR6TFM3?=
 =?utf-8?B?aGF4R2lhR1pDRnJzTGpTK1Z4eVRwZGNOMDAvdDN1K0hOODl6Zll3SmE0V0lo?=
 =?utf-8?B?bmYyeFpZMWZlQjBWNGpWQzQ3N1VJbEVzb1hESGx6TEpHY2J6bCtsSXpHNnhu?=
 =?utf-8?B?Q09YdkY3allrcTBWV0dRV0U2RjlqcXAwL0xuL1VXUjA0aFpNaWhMWUVEd2Zh?=
 =?utf-8?B?ZmZ0U25DR3FwRkdHT3VscTdpWkxOVFlXY3F2VUZuVks4UGlPMW9DWUVXa295?=
 =?utf-8?B?TldxYmRoV0ZLUHc5QkVMYXE2Y0psTFV1RjdZME41emZLUStXMGJCOVhWRm80?=
 =?utf-8?B?SlU4WlhON29CZjhpcXJ0NFNzQzNsaHZDb1hrSGlGYm91SStvVWhWT1pDZE14?=
 =?utf-8?B?WkE0Y0dzQkhNVyt0QjRiWDVHbldEY3lIcGZWV0tGRjdxSitqRFIveHI5aCtq?=
 =?utf-8?B?aURkdGRYaGVYaG9KYWZ0c3pkTWpubjBmK1cycFgyWWV6d0RNL1daRVVsTjA4?=
 =?utf-8?B?alpCQzlxWkZwTWhmMXN6d2hIaUxhcUprc1k2MnNtY0JVa3hudmhGM1pXdDds?=
 =?utf-8?B?SHhMS0tNVC9vWWFZdFl6Q28rN0h0ekgrVEwrQXE5UGdKRVRjWVRQSllaVjh3?=
 =?utf-8?B?TnRZZVlkd1QwTDJ4Z2dLZVNPZjZiemFjNEVnb3J0NDgzMG5rZVJlNjYreUtP?=
 =?utf-8?B?ellvYUZ2R3dqTEdDMDJXK2ZpYjFna3QzZlN5b0o1eWhkWE84L0NMOENTaEN3?=
 =?utf-8?B?NndGdWFGYTFkc3RMdjBsMWlHd2VMcXVkYVFOT0psZmtRaEx0Tzd5VWM5cE5i?=
 =?utf-8?B?TWVRUDMxSXl3RFNsbnYxdW5oeVNJT2pYek9BUnhuNWFVSENpUEVPcXVzTkRn?=
 =?utf-8?B?b1RvMStCdFpocVFqK1FLcWlBc3VtMm1nMlpEZmZIRjBRWUZSc1hMeUJMdStG?=
 =?utf-8?Q?f1HANkmMoIm7q8wFk2ZbxMtH6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e8f131-c149-49d6-8760-08ddbdeb5623
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 06:47:41.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NojT4lQDo+mLO6z2iEYMvJFtp6ekbDF3nix8QVRgwoClGDfP6xQWRkttt6BKsokuC6GgVX3OPU89L/VEzrEvog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125

On 7/7/25 15:28, Alistair Popple wrote:
> On Fri, Jul 04, 2025 at 09:35:00AM +1000, Balbir Singh wrote:
>> Add routines to support allocation of large order zone device folios
>> and helper functions for zone device folios, to check if a folio is
>> device private and helpers for setting zone device data.
>>
>> When large folios are used, the existing page_free() callback in
>> pgmap is called when the folio is freed, this is true for both
>> PAGE_SIZE and higher order pages.
>>
>> Cc: Karol Herbst <kherbst@redhat.com>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Jane Chu <jane.chu@oracle.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Donet Tom <donettom@linux.ibm.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>  include/linux/memremap.h | 22 +++++++++++++++++-
>>  mm/memremap.c            | 50 +++++++++++++++++++++++++++++-----------
>>  2 files changed, 58 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
>> index 4aa151914eab..11d586dd8ef1 100644
>> --- a/include/linux/memremap.h
>> +++ b/include/linux/memremap.h
>> @@ -169,6 +169,18 @@ static inline bool folio_is_device_private(const struct folio *folio)
>>  	return is_device_private_page(&folio->page);
>>  }
>>  
>> +static inline void *folio_zone_device_data(const struct folio *folio)
>> +{
>> +	VM_BUG_ON_FOLIO(!folio_is_device_private(folio), folio);
>> +	return folio->page.zone_device_data;
>> +}
>> +
>> +static inline void folio_set_zone_device_data(struct folio *folio, void *data)
>> +{
>> +	VM_BUG_ON_FOLIO(!folio_is_device_private(folio), folio);
>> +	folio->page.zone_device_data = data;
>> +}
>> +
>>  static inline bool is_pci_p2pdma_page(const struct page *page)
>>  {
>>  	return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
>> @@ -199,7 +211,7 @@ static inline bool folio_is_fsdax(const struct folio *folio)
>>  }
>>  
>>  #ifdef CONFIG_ZONE_DEVICE
>> -void zone_device_page_init(struct page *page);
>> +void init_zone_device_folio(struct folio *folio, unsigned int order);
>>  void *memremap_pages(struct dev_pagemap *pgmap, int nid);
>>  void memunmap_pages(struct dev_pagemap *pgmap);
>>  void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
>> @@ -209,6 +221,14 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
>>  bool pgmap_pfn_valid(struct dev_pagemap *pgmap, unsigned long pfn);
>>  
>>  unsigned long memremap_compat_align(void);
>> +
>> +static inline void zone_device_page_init(struct page *page)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +
>> +	init_zone_device_folio(folio, 0);
> 
> Minor nit, but why not call this zone_device_folio_init() to keep the naming
> consistent with zone_device_page_init()?
> 

Ack, will do!

>> +}
>> +
>>  #else
>>  static inline void *devm_memremap_pages(struct device *dev,
>>  		struct dev_pagemap *pgmap)
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index b0ce0d8254bd..4085a3893e64 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -427,20 +427,21 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
>>  void free_zone_device_folio(struct folio *folio)
>>  {
>>  	struct dev_pagemap *pgmap = folio->pgmap;
>> +	unsigned int nr = folio_nr_pages(folio);
>> +	int i;
>> +	bool anon = folio_test_anon(folio);
>> +	struct page *page = folio_page(folio, 0);
>>  
>>  	if (WARN_ON_ONCE(!pgmap))
>>  		return;
>>  
>>  	mem_cgroup_uncharge(folio);
>>  
>> -	/*
>> -	 * Note: we don't expect anonymous compound pages yet. Once supported
>> -	 * and we could PTE-map them similar to THP, we'd have to clear
>> -	 * PG_anon_exclusive on all tail pages.
>> -	 */
>> -	if (folio_test_anon(folio)) {
>> -		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>> -		__ClearPageAnonExclusive(folio_page(folio, 0));
>> +	WARN_ON_ONCE(folio_test_large(folio) && !anon);
>> +
>> +	for (i = 0; i < nr; i++) {
> 
> The above comment says we should do this for all tail pages, but this appears to
> do it for the head page as well. Is there a particular reason for that?
> 

The original code clears the head page (when the folio is not large), the only
page. I don't think the head page can be skipped.

>> +		if (anon)
>> +			__ClearPageAnonExclusive(folio_page(folio, i));
>>  	}
>>  
>>  	/*
>> @@ -464,10 +465,19 @@ void free_zone_device_folio(struct folio *folio)
>>  
>>  	switch (pgmap->type) {
>>  	case MEMORY_DEVICE_PRIVATE:
>> +		if (folio_test_large(folio)) {
>> +			folio_unqueue_deferred_split(folio);
>> +
>> +			percpu_ref_put_many(&folio->pgmap->ref, nr - 1);
>> +		}
>> +		pgmap->ops->page_free(page);
>> +		put_dev_pagemap(pgmap);
> 
> Why is this needed/added, and where is the associated get_dev_pagemap()? Note
> that the whole {get|put}_dev_pagemap() thing is basically unused now. Which
> reminds me I should send a patch to remove it.
> 

Thanks, I'll remove these bits

>> +		page->mapping = NULL;
>> +		break;
>>  	case MEMORY_DEVICE_COHERENT:
>>  		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->page_free))
>>  			break;
>> -		pgmap->ops->page_free(folio_page(folio, 0));
>> +		pgmap->ops->page_free(page);
>>  		put_dev_pagemap(pgmap);
>>  		break;
>>  
>> @@ -491,14 +501,28 @@ void free_zone_device_folio(struct folio *folio)
>>  	}
>>  }
>>  
>> -void zone_device_page_init(struct page *page)
>> +void init_zone_device_folio(struct folio *folio, unsigned int order)
> 
> See above for some bike-shedding on the name.
> 

Ack

>>  {
>> +	struct page *page = folio_page(folio, 0);
>> +
>> +	VM_BUG_ON(order > MAX_ORDER_NR_PAGES);
>> +
>> +	WARN_ON_ONCE(order && order != HPAGE_PMD_ORDER);
>> +
>>  	/*
>>  	 * Drivers shouldn't be allocating pages after calling
>>  	 * memunmap_pages().
>>  	 */
>> -	WARN_ON_ONCE(!percpu_ref_tryget_live(&page_pgmap(page)->ref));
>> -	set_page_count(page, 1);
>> +	WARN_ON_ONCE(!percpu_ref_tryget_many(&page_pgmap(page)->ref, 1 << order));
>> +	folio_set_count(folio, 1);
>>  	lock_page(page);
>> +
>> +	/*
>> +	 * Only PMD level migration is supported for THP migration
>> +	 */
>> +	if (order > 1) {
>> +		prep_compound_page(page, order);
> 
> Shouldn't this happen for order > 0 not 1? What about calling
> INIT_LIST_HEAD(&folio->_deferred_list)? Last time I looked prep_compound_page()
> didn't do that and I see above you are calling folio_unqueue_deferred_split() so
> I assume you need to do this for DEVICE_PRIVATE pages too.
> 

order == 1 has no deferred_list. prep_compound_page handles the INIT_LIST_HEAD



>> +		folio_set_large_rmappable(folio);
>> +	}
>>  }
>> -EXPORT_SYMBOL_GPL(zone_device_page_init);
>> +EXPORT_SYMBOL_GPL(init_zone_device_folio);
>> -- 
>> 2.49.0
>>


Thanks for the review
Balbir

