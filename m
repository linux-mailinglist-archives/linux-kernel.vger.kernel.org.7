Return-Path: <linux-kernel+bounces-856792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F03BE5177
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BFD19A77C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE74145B3E;
	Thu, 16 Oct 2025 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="U0YlZ7V5"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023099.outbound.protection.outlook.com [40.93.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B57623B0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640352; cv=fail; b=i2M7opoJXcBH3fJatFLd0NVfbTx5a+H6mUf9f5wVhr3jrOv5eFF3Eo3pnvzw9mzquYgsTJ2xeFtvFQ1/Zt0pZg7RtU+E5LgwYbCBfGxatgS/2AnDC1bevxEPdgvmewREnqBnnicg0X6tzZrjKKcv7Q2Ve4Mm0iExXYpjDQFT7IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640352; c=relaxed/simple;
	bh=pYRbaSpITeKCV5dmevIEg9e2FzcCQQqKu0CUXaBGadU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwNSD8bSeWefdtlihGSPwA0Hadj7koSvlLHl/iEuxx0KaGyg47xdO2KMpLsvwZAfvB7sKz1BST6nFP/jvcZqXNI6x58Pht5tiVtYKYg9+Dn3n79aaS9+zc8k4JIZdLLoPCjB1rHwB/aR8xzrF6vDBBO6SXyBGxhE1KqCy38o8/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=U0YlZ7V5; arc=fail smtp.client-ip=40.93.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/ST/31yxtmjHKngMPDvGyFHlMiAjoeD0euwxwe9AIyHHNGbLOhoI/js/n74vRmvpkUXcYJ9cP2YUZiL0FulC184eM9JkhPz22EycvUowc9pCZfl8OXEzuOpDrToA5dtjNRNEQwMSPfKMa0oE0fauRB2jVsu9HTqxqtZNImq1JPCe9nNKJF9psCPxyuE5vhmJUOvNN7YeJpFXwrx5t/wd43l5DNHX8C6/zPo+PI+FYKMPSRbh6YNwKdGsoMofZ2QtGO/ndEXQu7zXPwr5mOYoAqeZ3NV2Jej+/LRVpuQZwtGL38+q5DYo4h1d5kFd2G8/l5UrJ0KR8LM0pa9gGkp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeKcN9jfTQoKJ4pCjH/wCFAOWlzVI1usCfjGX0Jt1fs=;
 b=b+f0KH5yucd6ZN2fx29fy2VOunjqZfAU80ll5t06rE7cyc8eXwU9jrhbc6LFKkbzPgN1tnqDZo14RwB04wMcpOUW9fmEFpuNbbEw+w44fymFx6pNwdYUpwh76xCeHDlBW8HeK+eIhXUQY2ZYvcYju2C+Kajy0+3KN3vjVzvFYO+GtzdNOGHD8ctEu0i43KxE/TCoQN0NkkG+8IDHRC5xN7NOQ5i2HktSwm1KGGMFbXgxWf4F8pKv0/MI324hnE1LqmANdIo3MRwQKlPXEi7gtvSBq1uhZrvYv3gLDHVcmfURO6RAfA4MS8gehoKHcx9ytRBwP4ezSmSZYXGrYSmdtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LeKcN9jfTQoKJ4pCjH/wCFAOWlzVI1usCfjGX0Jt1fs=;
 b=U0YlZ7V5dka/pioCyamD0cYPfGaPfbakvndwJ7eqYWMUHsLJ9ZFCAeQVz2YCY5ctuwD5zBRnLk0Vvoc5Xw97UBRYCyqVw5jfsB6Em0SmWRplgEu+fPFknWwq1NwjG6mkjJ5cbEilxZcCm9eMJ/uvkRWy2wOF2Y9Ai9tXBnNbMk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB6777.prod.exchangelabs.com (2603:10b6:510:93::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Thu, 16 Oct 2025 18:45:47 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 18:45:47 +0000
Message-ID: <8943fe0e-0bf7-49a4-bf58-efe08bfd037d@os.amperecomputing.com>
Date: Thu, 16 Oct 2025 11:45:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: make linear mapping permission update more
 robust for patial range
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-2-yang@os.amperecomputing.com>
 <00bf0498-8f11-466e-9f2a-f7e656ecddf9@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <00bf0498-8f11-466e-9f2a-f7e656ecddf9@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:930::24)
 To CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f6c14e5-5315-49d1-ecf3-08de0ce4384e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGEwdlZLUWhXcmJPb0FSbHFqSVhvVG5iY0JneFRuaHZ4eUxMV01sVkQ5bUlB?=
 =?utf-8?B?aVF0dnduaEk5aFpONkVUYjZXeDJVdldYQndaVUp4YnBHQUFzYkZWTTk1MHZk?=
 =?utf-8?B?Y2NRMDRYUlByV3lTL1dzVDk1blFiWStQRDVrbFU4TWkrVEIxNFFFeHNiYUhY?=
 =?utf-8?B?THJhN1h6ZkgvOGk0OWEzSk9MUkk3THZhdjJScHFXblZSbDA0dVFQZzcrVUg1?=
 =?utf-8?B?T3hHOHJyRkhDSVlHYWQrVFhMdjUyMXllVjRsbHFIakIxOUltUWpOdTZGZVpF?=
 =?utf-8?B?cm81NzNoQmRkT2Jha0prNHR2R3VvSUkzYmRmakJIR2lvRENlUGFxY1RCamM2?=
 =?utf-8?B?NXhrazQyV0RCWEtKRkEvTm5jSHBjb0NjR0dJNUdLWWo5N0hhM295Mm5KVENp?=
 =?utf-8?B?eitPNGsrbHJkcUNKQW1CczZLMUlZemVFeDQ0T3Rja2szcUo1ZDBtdEhYWkVH?=
 =?utf-8?B?a0NNL0FNYThYSmJQdVF0QThlY2lwYXBnNzdQREdBeUlHbWNILytxM2pMZStp?=
 =?utf-8?B?Y0MrRVcwcmxiZHJ2YVNYWnB2WThraUd3VTl1dHVvRlk0K0JONm4zd29Db3JI?=
 =?utf-8?B?bDUvVjErRjBIeDJabFZlY2syNGxSTnZkNGx4M0FJMjNpWHU2bVkwV0RrWWJi?=
 =?utf-8?B?NzB6VTE3U3ZaR1QyZWxJa210eFA3d1dQV3FhT3czMVF2eU5XNWRqSTZhdlhq?=
 =?utf-8?B?WnNBR1hJMWZaSHI4Mk4zKzAwT1FLRHBnWGR0WjFhaW5zTVJZVlBZQVBRYWRh?=
 =?utf-8?B?ZGQrem0rUTNSSXN1QXhXVXhtMTJZZllsMjFBWm04YWpCbjZDTGJoWUhselRJ?=
 =?utf-8?B?emVpeWIvK0ZMeHdiMU1LeXdMM1FTa3pvdFkxNGpibDdObStvRVBzNVhkS3Qx?=
 =?utf-8?B?amlQZ2RLWTc1ZDQ4dGxXVTZQREJMS0EyQ1RNWjF6QlBNUW9EYjBUSTJjd0dt?=
 =?utf-8?B?TU5HOStBa0JhVmxvVTJ2eTBGNEppb25tcWNrbzhRbTlHRitwMXdNbno3ajRM?=
 =?utf-8?B?WXpreFBEVHVnRDFweEY3VDZPNERnU2ZiR3V6Y2M2SUtNd3JKMnVkdHlBUVRm?=
 =?utf-8?B?ZzgzdTlRSGlqRkNLcHdLVlBqZk1XdHlLUUlxSDVIWmFxL0pXenU3OFZ1L2Nj?=
 =?utf-8?B?b1FyK2t0WHQrVzIzbFVYOHFUWkQ2MTZicTFpbVdxRTJuOTY2Z3lZTGtWSEgy?=
 =?utf-8?B?YXc1a2NGcGRkQ2NYSXhpSjJXT1FOeWg2cjFtTlYrUDIxQXVpWW9UejBQTkNF?=
 =?utf-8?B?d3BFVkd1VGIxRUxZcDhPOFh3dDRIUFNOSm9DdVJDd2lxUVdvKzJISFM3M2Jh?=
 =?utf-8?B?MWJQdHFQeGZnNVJuRGNSSVQ5bzJzSzVMMzJ3ME0ySDFJVjdKbDVLcmZTWDFE?=
 =?utf-8?B?c3ZCajhsMUx3UTF6Nk5aY01MR3ByenNEcWE1UjU3NnJnVjJ1a29hUVdQVDFm?=
 =?utf-8?B?SmhqK2VvT0NrT2FRNjZwYUVJTThubXAzdVZuQWZNaytnUkJlRzJnNmI1K09u?=
 =?utf-8?B?VFBxRGExMlVJMXYxdnZEZjlXNlhXVFlLWG9uMTBLMnZ5Ujk3TlcrU29RQ3JB?=
 =?utf-8?B?bGFmV1QxZUdDZ1dkQUdrMXpUVCtkLzA0T3pyck52WnZXUDMxM1NFbFVMazlJ?=
 =?utf-8?B?dEZsMXI5RTFJa1NSbVE3VU9TWmliWmVWNWlIaXo0ekVVcG45ZUM4ejNabHNN?=
 =?utf-8?B?YlFMK3hnbm1MU3V2UGZ1Q0thTjZLV2psZlVpTlVDN1g0dis0d0xjd21ZdXFX?=
 =?utf-8?B?cjQxV1c2VTV1V0lsdi9KOHA0cGtmaTlsYXFqR1RMNitWeU9lQlRpQXB1blpy?=
 =?utf-8?B?OXpZRG51eEVST05kODMvUjBLQjJnMFBHUlk1NkxhTTg4WjZoaFFZbmk1bzhS?=
 =?utf-8?B?dnlydHFJSXM3Z1ZZMjVnZzZQbUdYYi9zQmhLMEdqbHNjRkxrUzRrZklNK1R4?=
 =?utf-8?Q?n5Sqx58jEmYIsAss0DlLFjQxWufW13ZB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckVIeUpSV2ZoN0tJekVVVld2Rkx1b3kvZ2hwMG5aQnhRdnlTbmh2eXpwVjJa?=
 =?utf-8?B?Zm5RaWJpUXpjSE9SOE12UFNFNFVIbmxyVDN4SVl2dFZTa05XQ242VWhXU1Fu?=
 =?utf-8?B?Y2s2ajhUWTRuUyt5U1dDN3RjaDJnM3FPVzVVbzNQZnMxd2NZQi9NWTZHZnNX?=
 =?utf-8?B?Yml0cW9nMEtCWDMrSkZ2T2RhaHFQUkVTblpkd3FScXlmSjJZNHN1bUROUzNj?=
 =?utf-8?B?RWVYTlRsQkdFKzdkS3oyMmpJdVlrV0h6clZNT1NwMlFxaGZ3NWZhSXhLelJE?=
 =?utf-8?B?bEFUV1gvT0JiOWxSZVVjSXBVeTNtblMxQmplaS9GSEtacHNnL0RUVi9sOFcw?=
 =?utf-8?B?eVlvSGMzNTZTcHE2OVNxWjdmOGNac0hkcHlqTEk4TmhTeWFtL3JEVW1TTmR0?=
 =?utf-8?B?T0F2c0dVdk1TcWJ2REk5aVFxa3hYa05sdHlRTzdRODNpNTR2U2Uya3BSOWo5?=
 =?utf-8?B?a0Z4bDBBWGpFRXF0MDRFL3QvckRyanI5QXQ1cXM5SXpCYzREOUFDSGpUNEFa?=
 =?utf-8?B?MUVFQVlUM3lJSGlMMkRidmtxaEpCZU1NTW9La0taMUgydUhnSEFrRXpWRHha?=
 =?utf-8?B?ZG5MaHFFTy9zS05WY2FRWXduWVQzbVFFR0dxRTdnVFJaTDlOSjFlemt3eTIy?=
 =?utf-8?B?UGR6SkVYdVJtcDdaSFpGc1VkQThBM2ZKWStuMjcxVjdYVEI5eGh6RXoxcXJT?=
 =?utf-8?B?SUFQdXdlVEFnTEdOTEpKY25Cd0xyUGc3ZUN1bkZaQWJ0bG9uUTZFdytlZkVP?=
 =?utf-8?B?NlVVakQyN2o3Rm91UEQyYzJCZzFrM210Sm9RaXZab2htdmlSWUNCbHhkbjlY?=
 =?utf-8?B?MXZENEx3dHVOQzFNUW1LUXlVeWxZdUhGK0NrZmdoNGRWc1Zsb1FxOHFSL3Br?=
 =?utf-8?B?SzN5V1VHZm41OXVVaUpjem14ZWpEeG5xWlJMQm1jM0tPemZ5YUlKbUlacHA0?=
 =?utf-8?B?OS9DWVN1UFZ6dFZPeE9jUDlXWjNheEM0TDhxcWFRWHVOM0JaZEFmckptZnR0?=
 =?utf-8?B?T2pUM1YxYXU3OEk0YkxLTk1UbkMxbDZiZUVYQlBhOEVMT29zWGtyeGF6QW9u?=
 =?utf-8?B?UXJxbUVxZ251cDhTaXY5dEdObTA1Zjd2WlJyaXYvS1JYdlc3VUorWWNjRXdi?=
 =?utf-8?B?dEFYRDNvTHFHTXVmb3ZINnc1cEJ6T1AvbldybUkzN2JZUC9PMHNFazRDVUNX?=
 =?utf-8?B?ZDJFQU0yVUMrYVZUTFltNE8rQTgyS2dOMnRlcWdUSXFyUlo0MHZLK0VKdWZy?=
 =?utf-8?B?UjQ1TnJpamZIQjVteXFIQTFENzYyVXRCS1YydlVpRVdRNy9ta0tuaS8yZlc0?=
 =?utf-8?B?WW8zQjFvRXA2c0dBd2ZQUGNhUmFxcmk2RGdIY256NUY2LzBuZ0h5MVNQWEhp?=
 =?utf-8?B?UDNLUFB4aVNBaWVKQVBEbWxacmgwTnJjWE1lMTZzc2VDUlAvWHZqR0VjdUtv?=
 =?utf-8?B?ck1WVjFZVzFHUUM5cC9aN1JwK1pDemN1azJKOWpwZFNYOWtCNUdMVzFoSlIv?=
 =?utf-8?B?bW4zSHBBK2Y4blBtMHZQVVBUbFNNWVNpZEVwNkFUc3NSR1I5Tmp2YzdwV2pa?=
 =?utf-8?B?MGV5NEZVSXQrenR2aU5WYVdrdnVQNXFKZjY3NFllUVFrblJkTHhJQnhKYmNm?=
 =?utf-8?B?OUY0d1RvTUZVa0prYjhzd215QjZ6WWFrYWlzdGo5amRyMHlqRllYcklpMDk5?=
 =?utf-8?B?M2JBRkJOYW9HT1JwV3pYSVRMamVDVEg0K0c1N0ZLbUVxcSs0R3JJYVlUUW5G?=
 =?utf-8?B?VkU4TzBmQWhmZms4UGtYOEozUFpSUllsR1NuUnN1aVZ6TFpGM052R1h5akwr?=
 =?utf-8?B?Qk9neUR3dkFvUWFCeWw0R1dGNTk4OGtRcjQxNmV0V2lUVFhNSHUzL3JUamFL?=
 =?utf-8?B?NElrTC83eDlIYjI0eitBN2hsWUZsRHpLSGE3bEhQallYOEJxQXlKTWRBeVpm?=
 =?utf-8?B?Wm5ZdGNla2lsZ3BnaDlqdy9CdjM1cFpLYkhXY3hUeHY1SGt4c0txRHIwRDBD?=
 =?utf-8?B?SmZ6WVU1dnhrRkQwUnJUUDRiUkN0NUkycWFJemluWjYyRnRoNVBGSk5uSWlO?=
 =?utf-8?B?UjI4REhpMVg5aTJqa2RvM29JT25lT3pjS3IybUhSL0c4ejRidlRvSFRXdFh1?=
 =?utf-8?B?TjVxUFRpQTRwRkd5TFlFaVVkK1FJSTV2V2YwTU5RNmR0WFk5cWlWcGdmOGpN?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6c14e5-5315-49d1-ecf3-08de0ce4384e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 18:45:47.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUQ4RdA8tZZv6xdms+yJnZNJl88WrsZGgGicCxMMsz9Y+7cJIu76ePkfPBPzMBQDyPib3eod2zaf5dUukGkwgLzwpqMwkCWG19z1Ymom96U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6777



On 10/14/25 11:46 PM, Dev Jain wrote:
>
> On 14/10/25 4:57 am, Yang Shi wrote:
>> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when 
>> changing
>> permissions for vmalloc_huge mappings") made permission update for
>> partial range more robust. But the linear mapping permission update
>> still assumes update the whole range by iterating from the first page
>> all the way to the last page of the area.
>>
>> Make it more robust by updating the linear mapping permission from the
>> page mapped by start address, and update the number of numpages.
>>
>> Fixes: fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when 
>> changing permissions for vmalloc_huge mappings")
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/pageattr.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 5135f2d66958..c21a2c319028 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long 
>> addr, int numpages,
>>       unsigned long size = PAGE_SIZE * numpages;
>>       unsigned long end = start + size;
>>       struct vm_struct *area;
>> -    int i;
>>         if (!PAGE_ALIGNED(addr)) {
>>           start &= PAGE_MASK;
>> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long 
>> addr, int numpages,
>>        */
>>       if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>                   pgprot_val(clear_mask) == PTE_RDONLY)) {
>> -        for (i = 0; i < area->nr_pages; i++) {
>> - __change_memory_common((u64)page_address(area->pages[i]),
>> +        unsigned long idx = (start - (unsigned long)area->addr) >> 
>> PAGE_SHIFT;
>> +        for (int i = 0; i < numpages; i++) {
>> + __change_memory_common((u64)page_address(area->pages[idx++]),
>>                              PAGE_SIZE, set_mask, clear_mask);
>
> Why not just use idx as the iterator in the for loop? Using i and then 
> incrementing
> idx is confusing.

You meant something like:

while (idx < idx + numpages)

It is fine to me.

>
> As noted by Ryan, the fixes commit is wrong. The issues persists from 
> commit c55191e.
>
> After fixing these:
>
> Reviewed-by: Dev Jain <dev.jain@arm.com>

Thank you.

Yang

>
>>           }
>>       }


