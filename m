Return-Path: <linux-kernel+bounces-744763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13471B11096
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BEB1890B65
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C912EB5D1;
	Thu, 24 Jul 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aNT5Fizf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2092.outbound.protection.outlook.com [40.107.96.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1BD1D9A5D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753379967; cv=fail; b=G3kf3BYXsSb7uNj6ZjUeB3t/DY3pskxthutvZtxga+TWqdlbNPzVsfT2b/ww3E/UcEd0p1auVYI/PwM2bHsmDciiP0EQ5zI3RkkKSQab0iGhs8EsbLRhg3jXYJ91hg0hk+d2zDu/kJ72F/TScQEHa69yBmqo7YbG6+wz0xeHm0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753379967; c=relaxed/simple;
	bh=KVVup4qDrBjPSmsMN5qwclvt29Es3P81X3xC1dY1n7c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZYuTQ8zEINf6CBu7JAQlUEExlLImBM1vzZojl2OSmniF1SN8+xRfC76oRHc8ox0JIpQR2XW93znv/ybVwV0V/a1Dq/Soigop5rx102TkpZ6LeXepbFgTX1FmENV/JtYf7/zygB1OAK1HKQJSvcaR/xcdbYs9hcXPCwUnB9O4NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=aNT5Fizf; arc=fail smtp.client-ip=40.107.96.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rza5W6MpIDS2wZOa6hDTvEbmbj37XZBb1IVRAL52NK0+R8oaMBu5xRCP6vWep6itqscOWZAcZ/U5/3KakbOfUFZF69BFojJRdJjn8FxjrH2IwqcyBYhuzdb1NY24mQJTnYvgfclb8oVimlaXnxLrQR0uMZNgt61337U0jXNZglzk9L3IOsnArOATkOL4vv4PnQYSuRCuM8weNuP6p1BhTyx1WICNCdMAz4np6vW2BkauWgDNC1VZhqYifyYfY3fhUfQWdCWmHkvqY8kk/jGkYmCZHmC8kkB3qgydMWl+EA/vQXRURDrD3Bc4+QIsb3cg6Wx4mWj4t7lKaAncdUou6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ga6DK1JOUcqAYAkFGm/WsFM1U4RuG8dl2katZELsORI=;
 b=R/xB51yMEcxRng3i5PMstaLEM+kpW2538k5uQjVNbmQJTbbZea4dlfR3mZxm/LEILstaZgmn2bWhdGMz9hZVrwa3C4XWuLPg5bZEpfEXnn5sCp+8MhQNBkq8wTz6ofrvuWwMdDX28YBVNqY6MbNGVN2mu8Ce5dykuz60s9Cw9atT8pog5ngs716M+LF7BAkD8wkNAe0QOnHGcBOuh7FuDRyH774ZRf0SDZMEVVVJzN4/JByskPIgL6y6xIV+uQ3z1z5xp45yM0vsBH/itWZihBD0WxT8F2ycvSCNM64rkL19amA7MO2O0skZuJ/Ono1XKYoCKufFu6aratiLi5V8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ga6DK1JOUcqAYAkFGm/WsFM1U4RuG8dl2katZELsORI=;
 b=aNT5FizfFlyV0eG75Ey3mWDwtQDPWUj2mj1AUSvRNUh830l+xez8gq0uZhVdbbWqlB5+BgteWf1hllifZx3RNJs4cfEd939Cngl/v8f/rZ7nLYjVa+4yITfoXJRKqR2BHOyW39qyrBW2xV5zyzcbtVdnCJ1HtgSx5yklwshDVxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6481.prod.exchangelabs.com (2603:10b6:303:7f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.23; Thu, 24 Jul 2025 17:59:22 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 17:59:22 +0000
Message-ID: <c99da082-23f5-41a2-9f50-3ce287f0e361@os.amperecomputing.com>
Date: Thu, 24 Jul 2025 10:59:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: mm: support large block mapping when
 rodata=full
To: Dev Jain <dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 will@kernel.org, catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250531024545.1101304-1-yang@os.amperecomputing.com>
 <20250531024545.1101304-4-yang@os.amperecomputing.com>
 <f036acea-1bd1-48a7-8600-75ddd504b8db@arm.com>
 <50a4f767-0007-4f6a-8c62-398962d54029@os.amperecomputing.com>
 <ed942c01-58e8-4d91-8f86-3b3645af6940@arm.com>
 <452be681-f28b-4b5b-848d-c967672b4f5e@arm.com>
 <3b3be4db-4f8e-4d81-8e52-dadad23dcd24@os.amperecomputing.com>
 <c77aa9e4-2209-4dbd-904e-daace1c929b6@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <c77aa9e4-2209-4dbd-904e-daace1c929b6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:806:22::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7a9748-ccdf-4c84-7164-08ddcadbd190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2JtY3AyTTd6Sm9pa2VHWnJjNWt2cXZ6aUMreXlCWTRaaVpVcUxJelJsNmR3?=
 =?utf-8?B?dzZVVFgvdnhzeWlpYVhvaXdmTHJZNEZ1bk1tUHV1NWVNSDZhQjNOQ2IreXhP?=
 =?utf-8?B?cHQ2alVEWDdIRitLempUTFhpb096ZzUrcTVrWitYNkxHMWRTVHVIVjhsd1pK?=
 =?utf-8?B?b2hpVElNdGk4UnpiK0dVRnlqemlQaGhycTFNMHVMTWxsemltZGE5TkNBc3A5?=
 =?utf-8?B?OVNwQURiRlM0WW0wSHVXK3JqcDJQaWVpRW1HRkh1YWo3VWhOK3Q1Q1lqTkdz?=
 =?utf-8?B?V1l2eVZzTEI5c3dGbmMrYlFKK2E0b0dnNHRFcjlCZVQ1d1oyNHR0NS9UQ3Bu?=
 =?utf-8?B?bGs5Ykw1Y1FWQzgyZzRvbkVDdjUzMXlGRXlFV3dENDZ1dStocWNWVXpqZmVE?=
 =?utf-8?B?MlhmOEgvZGtiaCtyeHpGZGRweWk4RUd6OUZLaUMvWW4zdWlFSUgzLzNNc3gz?=
 =?utf-8?B?RWpHSkhIRmxibjJCUWVMSDBzS3ZvNlY1dEwrc2tPV2RtcnJ6SlNyS3BaMkFM?=
 =?utf-8?B?L1F1eGNNTVJXNzdoYTg1SUtrN3d5VXVnNTJ0aEVXWFFaYTEwV0NNR0EzRldI?=
 =?utf-8?B?Y3NtYTV1aDA4T0tmZC9HZWszRk5YaDRpVXREZlBjN0dHK1cwWk54OXpla3dX?=
 =?utf-8?B?TGtLaDQ3T2VyWjlmNFdyQkU3c0ROZFd3K2RoQi9XeHlZbUw2dWMxNkRYZjBz?=
 =?utf-8?B?V1czL1hSL01zdExNZmd3TGpJb05mNnk5aFJqOGFKTzV5dVB1QkUvTkV0d3B1?=
 =?utf-8?B?RFN4SVRsbkU5bHF0ek92eCtwODBZbGZkRXRZL3FCQjJ4bW52MkNGMU5oTWJ4?=
 =?utf-8?B?YmZxZUtDaXd6WEt2Rmp3d3dlU2NNTXJLUHRZaHZXZ1c4UXQvbWRBTkFQQjRq?=
 =?utf-8?B?cTM5RlI2UityTng2MVAwSWhJRjk5RmRaYVhhTDdMaU9CSmtKOEpTeGdIazlr?=
 =?utf-8?B?dE1nVUlOZ2FXK0ZDd213UDRGZk9oVTZTQWZrK3JwVFBtU3A5d0VxcVNVRUdu?=
 =?utf-8?B?Uk9jYTdEaEdGZDJIaDhFRmo0TWkwMDh6Wkw5VUw5aDZESlplLy9ETFdpV1M1?=
 =?utf-8?B?NFFaQ0VTbjFMQ0VPZVRYeGplaFpLUUltVXh1ZTZMVS8yTzZIY0RxTkhhZWxC?=
 =?utf-8?B?UWJhcEVKQUNpVFU4VVJBeFhNeTYzTzBSVkxacjJPTEtxeVA4U2pRc0RlMzE0?=
 =?utf-8?B?ZWNMU29ZeDNXRkFaZnc5VkowQng5L00xaHFCZU1TenNNNURnKzlnZEkxU0dN?=
 =?utf-8?B?amV2MS9JbG1hOTU5UVE3dk9iQUhwRjNWaENkYkRFYTVhdllLUm5TVXB3d1NK?=
 =?utf-8?B?TW9HTXpZWm9ZRk95YjcwUkNIR040RkltUUdxZVJNV0hQMWNNay9WdHR4a0hs?=
 =?utf-8?B?bEFPMmoxVWhzOGZjUkVhcWVoMXRGcVZsRnhySmY1ZnBGUEprQklWcU1rMXZO?=
 =?utf-8?B?T0l0L2Z0WTNkN2NkWjNOKzdiU0NtSys1Ny9kWkcxWDFpaDlyc2hqZGVnNnhU?=
 =?utf-8?B?Y1RhVE82NCtTMHhUQUV3ZjRxVkxqUFVJR1dMc21jSXJXUGVxenFEOHJXcHRC?=
 =?utf-8?B?ZEcrTDBZdUpHaXAvV090b2twSG1yWW4vUFZ6L2dLQy9sRElEakVXekEzaERR?=
 =?utf-8?B?aC9xSk05YzFDeWp1VWs2L3JUZFM2SzUrVGdjUkJSTEhXSHlZWVJLV3B4azVp?=
 =?utf-8?B?N211U2lFYjY2SWJDRXNFZjMwRjVGd3loUE9aeEtVc2dzaHUxQzE2cGNCVWZK?=
 =?utf-8?B?R2wva0U5U0RjQitFdWozcWZUZ0gxL3gveUs2dDFpVlE1RHhHNW1JWTBtdG54?=
 =?utf-8?B?NithK1VrSGZ2K2o3Z243OTQrM2FkUTcvbVRQUTI4eFpkekdNUUVlc2RpbEd6?=
 =?utf-8?B?WXJCWXNuTXZScjVYWEsvb3YrQWliUXJtc1lVVW9tMXViV1I1MkVOZXIxTEFy?=
 =?utf-8?Q?2fv+daeYydQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXR0UGo0c2RDeEQ1cU1jOTNpV1ZKcXJlK3F4NUlwZDA5ZStTU1NSWkROWXZQ?=
 =?utf-8?B?L1R2bzUwcFA1TzNvbGJUdFZuNmRUVStrVDVTNDMzUnZtZGJEMlczQzFCc0hL?=
 =?utf-8?B?eGk2RE4rdStqeEhNd09KU0ZVZHFsd05lTFRzZ01uZkxaY2dXSjdXampxa01p?=
 =?utf-8?B?OE9Gb2swNGNWL2pzSHlYTkcwZFhBc0FFdVdBc1FwM3hlTVNwMHpJcXdra2Rh?=
 =?utf-8?B?cVBkaURhb3htbC9QU1FOanNqN3ZwbGhUTzFiTThlSGx6Y05ieXZ2QlFYU0dw?=
 =?utf-8?B?TytCUjliMk1GUVJFWk01Zm4vOGUxMFIzZWlxaWdIY0pVK2tkcE1Sc1RIUDAx?=
 =?utf-8?B?UXZlMU5xUUprU2VBbDk2Sy9vU2VNcjY1UW9NaG03SkgwOHhkbW56QnZtSkRo?=
 =?utf-8?B?bEdQbFdENi9iYnRXb2JtcjUreHNocEdyMmZXbkhoS3AvdlBTWUNJdzQxTzFa?=
 =?utf-8?B?WUlkTVFSVFNMamV3OEdrWVAxNnZrck0wMFI3cWR3L0VRcVVpYnpiOWo0L0hr?=
 =?utf-8?B?MUgyVGU2OXcveFc3eFk2VWpuUzdhQnlYS1pSZXdEUkJvTWRDakpuQWYzRDFO?=
 =?utf-8?B?c2M4QVlpRXVscitoaUxxSGRKZjNMMUt2bFRrRU5FcWhkaUhkNEpnWGh5YTB3?=
 =?utf-8?B?UGJmZWF5dkRRMk5hajh6dUN0cTBQc1cwd3lzOHdlblRvclNscHY5L0QzK0ZN?=
 =?utf-8?B?Y1YzamY4UmJqaEdvWlZhZjZiNVI2SmR6RFpYcnl1d2VRVXdJV1dMWVgzdjA5?=
 =?utf-8?B?WURJdEtHckdieng4M2ZJZlpvMFAvR0tsZ2tMSmU0S2ZDbitNdHlqRFQ1dkRQ?=
 =?utf-8?B?UWFESDRDTXlhK0ZranI4eVlxbUNtZEQ2bDByeDBNaHZpSjdWU3BNUEtUMlNH?=
 =?utf-8?B?S3hQdnNDMXZjWVFCeGpaRFppbjMwZ2ZVZTF6WHhHaFdsZnVjeXA0eHo1K0RU?=
 =?utf-8?B?aGxsNk1QeFlKR1FxQ2gxRnBoTWVRM0svY1lKVENYT2pvenNyczcwY1VzbE5I?=
 =?utf-8?B?anQ2b3NmR0svUURIUjF5ZExKY0pvQkhGd3ZYVUphTUNocmlBVGVkQTBlN2J6?=
 =?utf-8?B?Mk1xekxxYkRIa21sbFQvM2NibzUyWHZmUGJ1MXNteVFGM1RDRnFkRzdDS3Er?=
 =?utf-8?B?dGZtQ2ZIQzhGRVB5b3paaVIyWU05YUhYcERReWxJQzFyNkIydGFnZmxncHNY?=
 =?utf-8?B?M0lXRXlZZ0NRdnNEZnQ3ZkxsN1FaMENCazQ2a1N0QnhtRXQwcmhadGVZVURa?=
 =?utf-8?B?ZEhmWTA2dzdhdW5CdHVFRFppbmxtQ1lHeWJIblNQOTB3Q3VDWjNlWDVYT2gr?=
 =?utf-8?B?YldONHo5MGgzbk9qNm50NmFBa29GSFh3UjR1M3Fuemtza0g3aHcrYzhIZVRU?=
 =?utf-8?B?RjJrYVNRaVNWR2p1SlNlb1Z5cWY0WUx1cGNXQ3M4OGF4VWNRa2RJVnJHR2VP?=
 =?utf-8?B?R3Q5b1VjMUpybDY4NjFyRGlab2dhNUdtYVV1UlVFcG5iU1pFcTBqVS8vRTg3?=
 =?utf-8?B?bCtQQ2wwOFZWa0FFK2c5R0JDbDEzb1k5RXhOdGhxWFF2V0FuTUpIdS9zQ1c1?=
 =?utf-8?B?U3RjbWlJeGU5Ly9zd3FwZW44TXRsOHpWYWl6VmlRYnptaE0zd1VlWmxHRmtv?=
 =?utf-8?B?MmtYbmxwQ0tscXN2OUNuYllXV1Z0Mm5Rd2c3NURiUUpPWlc4RW5PVmwvSFI0?=
 =?utf-8?B?QzNmaDNEUE9JSm15QkVHMHRoMHlyYzlBV2hBMGhvK1NJK0M1TUR0cGFEbXM2?=
 =?utf-8?B?L3YvZW5LSElibWdkVlZHQnNYdnZGaHhsdUVDM2hzcnBIa2MrWk5LZzhrOWJr?=
 =?utf-8?B?THk0VUVFdm1CR2VsK0RrZDVBRW5ieHlSa3RiTVM3RXpuWWhPb1ErWStKMEdv?=
 =?utf-8?B?a25ZV1MwdUpmNkY0eTM3MG0waFYxVG1LRnNKNjB2RVRyZitsV3l1NGxic21V?=
 =?utf-8?B?VWhkNmJUY2J5VGtuNzN6T0paVE40OE8rRHVIVlFKMjk1aTVJTkdPNHY4UmVi?=
 =?utf-8?B?M29zWGxXQlJDbHJ5QUxjK1U0SmgwWkVWY0VWUWp5czVGcUp2UTkzTlNWdzJO?=
 =?utf-8?B?UUpFNzJ4TFBqVkpialQzZ1NMZktvSnFIeXdXNnRZRG13aG9SY2VIZ1MrT01N?=
 =?utf-8?B?REEvVkJQbVMxeWNicUkvQ1Y5QmZIMHp4cDBYeTQzS3Awc2oxTEg4TWFQOGtN?=
 =?utf-8?Q?JlHsRzNNMkRVZT1WD+RvKwA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7a9748-ccdf-4c84-7164-08ddcadbd190
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 17:59:22.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDwuu+nMPh3u6sgLBQaxvVtchzyX/vT/dRLh3DVhb4VxYeEUxBoz5bXoKeksrXhQaL0+uJhu+cvt8rhY4F/nnMJUJTBVbxP/MvTgIECkUHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6481



On 7/24/25 4:43 AM, Dev Jain wrote:
>
> On 24/07/25 2:21 am, Yang Shi wrote:
>>
>>
>> On 7/23/25 10:38 AM, Dev Jain wrote:
>>>
>>> On 23/06/25 6:56 pm, Ryan Roberts wrote:
>>>> [...]
>>>>
>>>>>> +
>>>>>> +int split_leaf_mapping(unsigned long addr)
>>>>> Thanks for coming up with the code. It does help to understand 
>>>>> your idea. Now I
>>>>> see why you suggested "split_mapping(start); split_mapping(end);" 
>>>>> model. It does
>>>>> make the implementation easier because we don't need a loop 
>>>>> anymore. But this
>>>>> may have a couple of problems:
>>>>>    1. We need walk the page table twice instead of once. It sounds 
>>>>> expensive.
>>>> Yes we need to walk twice. That may be more expensive or less 
>>>> expensive,
>>>> depending on the size of the range that you are splitting. If the 
>>>> range is large
>>>> then your approach loops through every leaf mapping between the 
>>>> start and end
>>>> which will be more expensive than just doing 2 walks. If the range 
>>>> is small then
>>>> your approach can avoid the second walk, but at the expense of all 
>>>> the extra
>>>> loop overhead.
>>>>
>>>> My suggestion requires 5 loads (assuming the maximum of 5 levels of 
>>>> lookup).
>>>> Personally I think this is probably acceptable? Perhaps we need 
>>>> some other
>>>> voices here.
>>>
>>> Hello all,
>>>
>>> I am starting to implement vmalloc-huge by default with BBML2 
>>> no-abort on arm64.
>>> I see that there is some disagreement related to the way the 
>>> splitting needs to
>>> be implemented - I skimmed through the discussions and it will 
>>> require some work
>>> to understand what is going on :) hopefully I'll be back soon to 
>>> give some of
>>> my opinions.
>>
>> Hi Dev,
>>
>> Thanks for the heads up.
>>
>> In the last email I suggested skip the leaf mappings in the split 
>> range in order to reduce page table walk overhead for 
>> split_mapping(start, end). In this way we can achieve:
>>     - reuse the most split code for repainting (just need 
>> NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS flag for repainting to split 
>> page table to PTEs)
>>     - just walk page table once
>>     - have similar page table walk overhead with 
>> split_mapping(start)/split_mapping(end) if the split range is large
>>
>> I'm basically done on a new spin to implement it and solve all the 
>> review comments from v4. I should be able to post the new spin by the 
>> end of this week.
>
> Great! As Catalin notes on my huge-perm change series, that series 
> doesn't have any user so it does not make sense for that to go in 
> without your
>
> series - can you merge that series into your work for the new version?

Yeah, sure. But I saw Andrew had some nits on the generic mm code part. 
The other way is you can have your patch applied on top of my series so 
that we don't interlock each other. Anyway I will still keep it as 
prerequisite of my series for now.

Yang

>
>
>>
>> Regards,
>> Yang
>>
>>>
>>>>
>>>>
>>


