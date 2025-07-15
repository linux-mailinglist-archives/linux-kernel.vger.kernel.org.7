Return-Path: <linux-kernel+bounces-731259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92538B051DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1584A835C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78AB266574;
	Tue, 15 Jul 2025 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UcpReeF2";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UcpReeF2"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A225F790
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561344; cv=fail; b=AohqhzzImTLe5xnKfsETVvb2qtRfTeA4utGsk0sHuj7y3Nz6BQKicHBBkAzuds99QKDEphPDp7hrxCsttOxScrVuRRoW44hAY/3Gi/fyAH5G8hEkA+OKm7qhe6C7GT0EybxdqEHmnxtfQVMzGifd+j0YVE2l+bbMbzfgzkqb2vA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561344; c=relaxed/simple;
	bh=4z/fZcuhAb/4kzJoBoK++HdoBLKK3z4X3beIBzIaz3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NLAqxOSIFpjjWns2Gb5oUOj6fah6q6Q4gCrrZOA92uo3qj+Ew1MRmAQxsPJEkOGIcTkCd0I6aag+s2Y0LAoggq7KUeVt3RibO2QHi8aD440781H3HiXbP+qNNpJjJZU62245Mo1Y91hmGYib6tmRLXakjv9UbIp89fPZAHAcLas=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UcpReeF2; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UcpReeF2; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vO2Z8A/OQx7eWoOm3vFgz5NWFzYYneNxA8/ifUUIWaooQ1DlYU8UDBecpo8PuP5FCj95zoXJOBq+7530mUjMYb72aUIR7RT5bbjer+Ek7xVhEtHp4axQYkOreuu0DQdjLYULNJAHUJOWyE7tGe3B96ScFoKHQP/HG7RT4KwsB9o809EjtIM/i12HdaL979pn+boMGTGn548QR5OFbpqoL+Q0HW3gmVmmFghAGxHttbLr87ky+DZTbbho2KDaVH3wzoj3/gYg6Nae1IhGxEthp7Zh27745kGKJc6zSOtbfHL9vqJM7wvTrW+R0eOnaM8rgQX7T9JTAVo3SYmhOYA7Ew==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/0bAXBM3JyVaZ3utkImdI45VGrTg7HOGjtocjAO0MM=;
 b=KPRZzq0K+gW2patZKfFaO2CLc1cWqqZ1wH4ZSky89bdmNbEfpi0z7zRNbWB+Wypp8qptNnOp3Zaeahs+yZgzkXCG+Kns7YkYra+m3WSl+S7HAnTHRVS0Vi949AXO0dphDOi2DyqQzoGkhbzqg3DbP5G7PeL6wX7cIGI8EtIlUwBOz90BxKH4pyH6m2riNHCKXQK/EWUBVvkxDu7HIWkpv99zzQ0FPvJdA6MCQ526qqg4VciqF+Si/mEONVLaeBDO7YCrXl2SwLXIYzvxAmPxd8kiActrhj3PUgNXrP0KaZcupIC/lRFJHbW8rlT59ezOJYtn3yJLLAPVhT23F9l49g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/0bAXBM3JyVaZ3utkImdI45VGrTg7HOGjtocjAO0MM=;
 b=UcpReeF2ifuamyGBZIa4NMzxXNvzItupoWO9wR/5+X+MIA4HVzpI+JvY5yeJljnoX7ED12DLve+6wnrDi+LOL8Kc16Qy0FfJYCdV0R8rymi7eqH1J/W8zdDAGGDYxDEEq4HniH8Cw+2IXY/Ej43+fYCkDc9Sql5sKMD8Th7dVas=
Received: from AS4PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::13)
 by AS2PR08MB9871.eurprd08.prod.outlook.com (2603:10a6:20b:594::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 06:35:39 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::d) by AS4PR10CA0005.outlook.office365.com
 (2603:10a6:20b:5dc::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 06:35:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22
 via Frontend Transport; Tue, 15 Jul 2025 06:35:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvBCuugmCXE7+OjwIRKOmtpPFuhnXX7fpigAxGJHKaGi9ypXYDDLmo9yWlGyCP5GPVrX9ESe6lwJAlUFsrkSuubAMqN1yntQ/VCfYgrdLLTrWHFmyzYqoGy0ETG95VGzhKcsNeS6auTLrbxjgzhd7srdTGmOGaAMSDP3oXHEvmMuVoFC9K1Yl0zCcpZFjxOwUh51j1V4IQjBOzgXoIsKwn2LIeC+e7G2PTed8SQ8uHmev1sATa8GPLf4q2dYfPK5iMuGS6/FiwBNx56Z5Rpp3EQDztdhYKjFwKarWbmlSWtpKXyLMOuvYmi9Qc37TIwFGMOO8Q+oVzgUX70/ag2WaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/0bAXBM3JyVaZ3utkImdI45VGrTg7HOGjtocjAO0MM=;
 b=hZ7Vi+0rRA3+5HgUZdW7Rj9r3kHBrJ2+IGFRGh6yX5tXm1eKkD23RElwE7WtItceYRd41D7X+3EMhAQU9o5O+8xs9caIGOxoBV2DfiTX+o94LL6zQ3tniFj43MUypXMMZdSgnL/u6VuBE79P6xyLQAZFpdq3hnxWZkTspTWb14f/BMVOPg0V/CI+RTj2wE0epLUj+FVE9TN5ZJqvuVhavVwsc1I8+GoqlQaT0RUJlNJqZfBLgOg0wJZYLkgetEixKW70rREtaCASuqqrcwv6mN2X/LMDIDOHQVQiODFVlZhgh7WCKpDXeoT7233npkrjme0t4Vi+0gsmRHLSshdWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/0bAXBM3JyVaZ3utkImdI45VGrTg7HOGjtocjAO0MM=;
 b=UcpReeF2ifuamyGBZIa4NMzxXNvzItupoWO9wR/5+X+MIA4HVzpI+JvY5yeJljnoX7ED12DLve+6wnrDi+LOL8Kc16Qy0FfJYCdV0R8rymi7eqH1J/W8zdDAGGDYxDEEq4HniH8Cw+2IXY/Ej43+fYCkDc9Sql5sKMD8Th7dVas=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS4PR08MB7453.eurprd08.prod.outlook.com (2603:10a6:20b:4e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 15 Jul
 2025 06:35:02 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:35:02 +0000
Message-ID: <d58dc96a-4082-4a24-84cf-fed27b85763a@arm.com>
Date: Tue, 15 Jul 2025 12:04:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] khugepaged: Optimize collapse_pte_mapped_thp() for
 large folios by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250625055806.82645-1-dev.jain@arm.com>
 <20250625055806.82645-3-dev.jain@arm.com>
 <71350398-b5d8-45b9-b05c-d2b63030f766@lucifer.local>
 <8109236a-9288-4935-8321-dbff361dc529@arm.com>
 <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <e9b027c8-9db9-4950-8d25-9984ae0a4de1@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS4PR08MB7453:EE_|AM2PEPF0001C714:EE_|AS2PR08MB9871:EE_
X-MS-Office365-Filtering-Correlation-Id: bad2babc-121f-496c-fba9-08ddc369cf94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UDFublFuM2VNTHp5NFd4bHVUNDhBYXAzL0pNSSt5bzhoc0RwelRveDR2aGN1?=
 =?utf-8?B?c1E5a2pOV1R4anA3TGVzck9KUmtxdW5OQW9raVB4K1VwWUFXNE9QZzR1Y3B1?=
 =?utf-8?B?VmYxendRUDRrMDBPTlV4dmVDdE16N2R4MlhQK1Jsd2s5ckFPSVRMVm5Fc3Ix?=
 =?utf-8?B?dW5YZkJscTE5MVplTVNwemVPZ3lUbytPNFdkeWhEa0EyODZFQXZJOGlQZGdu?=
 =?utf-8?B?MVpwMmRNY3ppS3E1OTdOenNKMUY2anV5MzRoV0hEUGZabjZCbFkwaCtia05C?=
 =?utf-8?B?RVFHNStTUUZkSlVMTGtxN2Qyd055RTlOVmgvcncvMVk4Sit5ZEtZTmVmbzF1?=
 =?utf-8?B?VVRIbDdwT3kyWjl2NHlxVXk2aWRJT05ibkEwY0JLRXlCYWNmTHc2UHE3VnJE?=
 =?utf-8?B?L3hKak1xOU91ZWpKbTRjS291NzhnTkJQUDBNTDN0ZUNRQ1RRZ04ybGZNdGVn?=
 =?utf-8?B?RmFkOEJJNzVCM3ZuYTErZFphZ29pRno1R0VxcDNzY1JudHpCTVVHL2wwZno0?=
 =?utf-8?B?dEJaTXoyejZTMG5QbGdRbDlhUzArbDlSMnpmOGltR25ZdTN6YjlHRWprMlBF?=
 =?utf-8?B?TjREbDgxdCtLZ3M5c1ZhaXB4ZUNJa2thTnlNaldTSkF3ak02WHhSMlRycTdr?=
 =?utf-8?B?QW9LK0JsSTBDa1hBeS9wOGdxZ25UMGQzbnV6bWpoQkF3U3pHVjdsdUp0UlpZ?=
 =?utf-8?B?VTNlbEYwOGMzWkNOV25va0ZjbEQ4bjVHY0ZPanFsbFlUNG5tL3RYbEduQmlw?=
 =?utf-8?B?bitEKzBvbDM3V0VXTkJ4aktBYTVLM2Y2aUN0SXI3VmJoemJGTThNT2RtbjA2?=
 =?utf-8?B?cE9NVkpzQWcySzZyVGVsS250V0tIY1RCMHB4d0JEVGk1Z1BXeEF6UExYVWtk?=
 =?utf-8?B?dVBPQzZvd2F0ZVNEVUI0MGhKUmNmcGhtZHJIUjBlNGFPd0hodVJHN3J1a3JM?=
 =?utf-8?B?ZlFxdFpYMFp1dStFTWtTcnF1WjFRTmNWbnFoMnV5aHdUaXBhL0poZnRlRWZz?=
 =?utf-8?B?Y09wd1RTM1FWMFdocnp5YzBGN1NoVFdCeTlHYzE4NWFvK25yaGdIczdtdGN4?=
 =?utf-8?B?bFVGSHRTYlJZSXJxT29mMDQ2WnFhTXc4TzF4cHlCMmFLa1NXKy9QNG04NUtS?=
 =?utf-8?B?cGhzZUZ5ZkwzdEZ6T2hYS0FjYmYycEhnU3U3MmlyTHVMbmMwaGRzTWtGUE1W?=
 =?utf-8?B?U1ZiU01PeTZhZEJKT0NRR29tUnpRVkdqMU9HRVg4aUJPVTl5cVhnK0ppMW5q?=
 =?utf-8?B?eVZjQ1d0WnBmc3d6elJsWXgyMk9PajBOUlIwdklZMDV3cW5xcXp3WUZJN3lu?=
 =?utf-8?B?NFk5dTVXZVNRSFpxTHhBajdIMGZpT2dhdjdHMHFzeXNEQm5ONzB1WGpUa2FD?=
 =?utf-8?B?b1dkNTJoR0ttRWtrZDUxbFc4M2ZyZmpLYVFuT2VoQVcva0lTcVltRUFTN1Qw?=
 =?utf-8?B?dEpsTTN1YXpDejAzeVhNZkxhNC81M3dsZk1mWGpwcXlsWmxXQ0FkOThXeTA4?=
 =?utf-8?B?QjUyOUpuOWh3Z21MY2p2VmNjZm5KZCszdThPUXZ1TCtwdndiMGcyWUFKZWp2?=
 =?utf-8?B?OTVYRkdROWozT1BDeEp5UTN5QU9tcXg3UWFJMVFNSHZvSEJNRG5ubW9HVXRY?=
 =?utf-8?B?c3ZZYUhLOVFZU2FoUDMwUjNOTGVqVzVpbkgvQitVTnBSYkVaUGR2SHVnaXlZ?=
 =?utf-8?B?bUFaNXA3RjhSRkhIbGFJZElTSG1jQ1pPb0Q3bWZKSlRLcjRtc0kyTDUwY3BD?=
 =?utf-8?B?dzlaQVZQd0R2UWpSVER3WWdPcy9Uc2RJTzRiWXpqdHZRc2xCK2d6T25qcno2?=
 =?utf-8?B?M3dzVmxMdm9tNlZuVG56Qi91ajVieGY1aUYzL0hDSm0vT3VxOGpvTVhuL2Z1?=
 =?utf-8?B?V3lLU3RscWRwQ3pCY0JGZXlacHI5N2JYZ1VZMUlmNmV3bVE9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7453
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c023ffd3-0bef-4ef8-cefa-08ddc369ba61
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|35042699022|82310400026|36860700013|376014|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0M4Y0VjTHZ4bDA2L1hxMlU4QzVMRDZYL0lrcHBKenFwOUlrKzNiQ0hmYUJU?=
 =?utf-8?B?UGhxa01PdlVyTlZkK2ZiYVI0MzhIc2hLUDlQSC95RkNSRDJVTUFQYTJXR2or?=
 =?utf-8?B?ZERMend1K1pQM05DQjY3UG13SVdOMk9tR2pyREs2NFA2Zkd3YnAveWJjUXBt?=
 =?utf-8?B?b3MyOGJxQncvTFp3b1l0UGs0cjZiR2poL2xRelBNVE1OeGpDRForcHMrNncz?=
 =?utf-8?B?Mi8xRDZRZU5IRENvczZsOFQ4RWVjYUhvRW5mM29Ybm1lL2x3ZDdaLzRUSnJM?=
 =?utf-8?B?aE5TVzdCd3p5amYrTytsMXBUWVdUaFBKUi9ZK2FNSENjZ1ZWU0FrR1l2alFY?=
 =?utf-8?B?Z2xwZy9POWJZZkJ5cEhrY3cvemtKUjJWOGVZVy9NdFFmbDJYckI2QS9EV1Zo?=
 =?utf-8?B?ZFR6MHNhTzNUNVcyZzdtckRWTnhmVnFQSWNJYmZsajg2QklqUlNab3RjTkx3?=
 =?utf-8?B?ZzVOdkJUbDZ2OEFkK1VHQllLVlpKczFCcTVYOHRVZmlOeVd5Q3pKYkJvSEFH?=
 =?utf-8?B?MnkwamQwSjk3SnlsZS9zb1gyak5BeStYTCtTaEdYbGtqQXFIcW0xaVV6Nmxr?=
 =?utf-8?B?alNWWjlxRk0vSUtEV09Fc0xjYzVHNHllVm13L1c3VG16bDlLYlB6OWJYL0dV?=
 =?utf-8?B?dW5CejlLTEozU1VFWk9DWjZId1pORjlqcFVnOWNlbXhlbVNxc0Q3RVVnc1dI?=
 =?utf-8?B?bFYyN2pNN3l5ZVFFRzZuTE1EZk5ISm00RXlUSDYzL2doZWxFZlNwS09zaUtt?=
 =?utf-8?B?blVkT0QreUpsbUNMZUNySXp1ZGl4T1A0b0JndUd6NFRMcjJGbWhiSEptOTF3?=
 =?utf-8?B?ck1HdEJES3VKT0RqOGRRUHN1dTgyVnREYkhYaE8vV2NzMTlFeHVtY2RQUi9F?=
 =?utf-8?B?MllKSW9BamxGcVhJQm8rZ3I1TVdVSmRGUTRkUXpqdlJGemxjRGNTb1VKcDZD?=
 =?utf-8?B?ZHNGS1pqa2VlTW10YlVoeWZ2QW05T3dvTm44cTY0dllQL0RpVHpYZXd4TkEw?=
 =?utf-8?B?RURNajRYZVcrSmJudjJOSlVvc1UveGRRM2dsVktlZDRVYXhVUTJGbEY2aW5Z?=
 =?utf-8?B?NnNiazFTNVNaNFliM1lpbThsMXp4VXhHa1djd0hENXI1RGsvM1BIUEJ6L2gv?=
 =?utf-8?B?QTAweUU1N28xRXNzK3RIRWo1WXA4SHUxMkJ5UWtPc2RyRUlWcVZ4cURlcmRz?=
 =?utf-8?B?aGQvNWY4SUlXTUhIdXg1Z2tGV3FEQnJBNEM5L0orK1NyaGhBOEpPYkVhSEIz?=
 =?utf-8?B?MFBVbFR5UUNtQnVidXhoa3ZuRU90UC9rd05PNlRQR1BXMWlKa01QK3l5b3Uz?=
 =?utf-8?B?N05KSVhLT2dQUTJJN0lZSGZxeHpnZC9SYUR6ZTE0NVRRQ0N4Sk5rUjRtNE9O?=
 =?utf-8?B?TzE5VXVkNXZ2YkcxMGJBWGppS0JqTkdybjBSbFFGTDQzdC9TS0ppL21keUli?=
 =?utf-8?B?TGZibHROa2J1a01VZy9scWRTNXYxMFppOGVweEtOR05VREhzb0VXUnJMUWtm?=
 =?utf-8?B?QWdzcktIWGlVQXlZaHRpV2RyRVNlNkxYN1NGMXhubGZSQTRvSGlhYTNiVnQ1?=
 =?utf-8?B?cXBCM1o0TnN4UUhsTXl5b2F6TnJ5SzRJcVlmWWFrQ0gxZDhPN2pJcHpON0JQ?=
 =?utf-8?B?RGliM1YwTzI0cWs2NFZMOUZVeXJEMGVUNm5XbDJEZlVQNGZINGxsdWxIcUFK?=
 =?utf-8?B?bFlGM0xVemoyZHUrMDZjMHEwWGFmL3RJaEVYbVZ4TU5TNzFiQmV0dFJ3VVhK?=
 =?utf-8?B?bGxLaTFQak5WM3ZEMEZGcnpHcVRya3JycU90TThCckUyVm9MclBHWWthNjBL?=
 =?utf-8?B?emZBdDZMNDlhOHluMVkwTlpZck96enNoTCs0Y0E5c1g1MjZSd3VsbFFONUgy?=
 =?utf-8?B?UjJwenRhc296dllaTmF5Ky95d3U5VmxvWm9TN1VmYU1OdlczWERIQ01vMC9x?=
 =?utf-8?B?YVFWRkhaKzluaE5nR3hDWXA4aXVGbEFJQThKSS8xRXQwL3RWREo5SkxRdFBN?=
 =?utf-8?B?a29ZMGFJZ2VDTmVsUktBMXZjcXY0SG9PeGNqRjlvNHRqVWlsV0IxUGNja2M5?=
 =?utf-8?Q?a7BQLX?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(35042699022)(82310400026)(36860700013)(376014)(14060799003)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:35:37.7064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bad2babc-121f-496c-fba9-08ddc369cf94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9871


On 26/06/25 10:17 am, Lorenzo Stoakes wrote:
> On Thu, Jun 26, 2025 at 09:18:47AM +0530, Dev Jain wrote:
>> On 25/06/25 6:41 pm, Lorenzo Stoakes wrote:
>>> On Wed, Jun 25, 2025 at 11:28:05AM +0530, Dev Jain wrote:
>>>> Use PTE batching to optimize collapse_pte_mapped_thp().
>>>>
>>>> On arm64, suppose khugepaged is scanning a pte-mapped 2MB THP for collapse.
>>>> Then, calling ptep_clear() for every pte will cause a TLB flush for every
>>>> contpte block. Instead, clear_full_ptes() does a
>>>> contpte_try_unfold_partial() which will flush the TLB only for the (if any)
>>>> starting and ending contpte block, if they partially overlap with the range
>>>> khugepaged is looking at.
>>>>
>>>> For all arches, there should be a benefit due to batching atomic operations
>>>> on mapcounts due to folio_remove_rmap_ptes().
>>>>
>>>> Note that we do not need to make a change to the check
>>>> "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
>>>> to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
>>>> pages of the folio will be equal to the corresponding pages of our
>>>> batch mapping consecutive pages.
>>>>
>>>> No issues were observed with mm-selftests.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    mm/khugepaged.c | 38 ++++++++++++++++++++++++++------------
>>>>    1 file changed, 26 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 3944b112d452..4c8d33abfbd8 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1499,15 +1499,16 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>>>>    int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>    			    bool install_pmd)
>>>>    {
>>>> +	int nr_mapped_ptes = 0, nr_batch_ptes, result = SCAN_FAIL;
>>>>    	struct mmu_notifier_range range;
>>>>    	bool notified = false;
>>>>    	unsigned long haddr = addr & HPAGE_PMD_MASK;
>>>> +	unsigned long end = haddr + HPAGE_PMD_SIZE;
>>>>    	struct vm_area_struct *vma = vma_lookup(mm, haddr);
>>>>    	struct folio *folio;
>>>>    	pte_t *start_pte, *pte;
>>>>    	pmd_t *pmd, pgt_pmd;
>>>>    	spinlock_t *pml = NULL, *ptl;
>>>> -	int nr_ptes = 0, result = SCAN_FAIL;
>>>>    	int i;
>>>>
>>>>    	mmap_assert_locked(mm);
>>>> @@ -1621,11 +1622,17 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>    		goto abort;
>>>>
>>>>    	/* step 2: clear page table and adjust rmap */
>>>> -	for (i = 0, addr = haddr, pte = start_pte;
>>>> -	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
>>>> +	for (i = 0, addr = haddr, pte = start_pte; i < HPAGE_PMD_NR;
>>>> +	     i += nr_batch_ptes, addr += nr_batch_ptes * PAGE_SIZE,
>>>> +	     pte += nr_batch_ptes) {
>>>> +		const fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>> +		int max_nr_batch_ptes = (end - addr) >> PAGE_SHIFT;
>>>> +		struct folio *mapped_folio;
>>>>    		struct page *page;
>>>>    		pte_t ptent = ptep_get(pte);
>>>>
>>>> +		nr_batch_ptes = 1;
>>>> +
>>>>    		if (pte_none(ptent))
>>>>    			continue;
>>>>    		/*
>>>> @@ -1639,26 +1646,33 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>    			goto abort;
>>>>    		}
>>>>    		page = vm_normal_page(vma, addr, ptent);
>>>> +		mapped_folio = page_folio(page);
>>>> +
>>>>    		if (folio_page(folio, i) != page)
>>>>    			goto abort;
>>> Isn't this asserting that folio == mapped_folio here? We're saying page is the
>>> ith page of folio, so why do we need to look up mapped_folio?
>> We need to check for all PTEs whether they map the right page or not. This may
>> get disturbed due to mremap and stuff.
> Right but I'm saying mapped_folio == folio right? You're literally asserting it
> here? So there's no need to assign mapped_folio at all, just reference folio no?
>
>>>> +		mapped_folio = page_folio(page);
>>> You're assigning this twice.
>> Forgot to remove, thanks.
>>
>>>> +		nr_batch_ptes = folio_pte_batch(mapped_folio, addr, pte, ptent,
>>>> +						max_nr_batch_ptes, flags,
>>>> +						NULL, NULL, NULL);
>>>> +
>>>>    		/*
>>>>    		 * Must clear entry, or a racing truncate may re-remove it.
>>>>    		 * TLB flush can be left until pmdp_collapse_flush() does it.
>>>>    		 * PTE dirty? Shmem page is already dirty; file is read-only.
>>>>    		 */
>>>> -		ptep_clear(mm, addr, pte);
>>>> -		folio_remove_rmap_pte(folio, page, vma);
>>>> -		nr_ptes++;
>>>> +		clear_full_ptes(mm, addr, pte, nr_batch_ptes, /* full = */ false);
>>>> +		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
>>>> +		nr_mapped_ptes += nr_batch_ptes;
>>>>    	}
>>>>
>>>>    	if (!pml)
>>>>    		spin_unlock(ptl);
>>>>
>>>>    	/* step 3: set proper refcount and mm_counters. */
>>>> -	if (nr_ptes) {
>>>> -		folio_ref_sub(folio, nr_ptes);
>>>> -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
>>>> +	if (nr_mapped_ptes) {
>>>> +		folio_ref_sub(folio, nr_mapped_ptes);
>>>> +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
>>>>    	}
>>>>
>>>>    	/* step 4: remove empty page table */
>>>> @@ -1691,10 +1705,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>>>    			: SCAN_SUCCEED;
>>>>    	goto drop_folio;
>>>>    abort:
>>>> -	if (nr_ptes) {
>>>> +	if (nr_mapped_ptes) {
>>> I know it's ironic coming from me :P but I'm not sure why we need to churn this
>>> up by renaming?
>> Because nr_ptes is an existing variable and I need a new variable to make
>> the jump at the end of the PTE batch.
> I thought you eliminated nr_ptes as a variable here? Where else is it used?
>
> Oh how this code needs refactoring...

If we retain nr_ptes, then the two variables will be nr_ptes and nr_mapped_ptes,
which is confusing since the former is plain and the latter has a _mapped_ thingy
in it, so instead now we call them nr_batch_ptes and nr_mapped_ptes.

>
>>>>    		flush_tlb_mm(mm);
>>>> -		folio_ref_sub(folio, nr_ptes);
>>>> -		add_mm_counter(mm, mm_counter_file(folio), -nr_ptes);
>>>> +		folio_ref_sub(folio, nr_mapped_ptes);
>>>> +		add_mm_counter(mm, mm_counter_file(folio), -nr_mapped_ptes);
>>>>    	}
>>>>    unlock:
>>>>    	if (start_pte)
>>>> --
>>>> 2.30.2
>>>>
>>> V

