Return-Path: <linux-kernel+bounces-774855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9DDB2B85E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB3B1BA0337
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 04:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B387625FA1D;
	Tue, 19 Aug 2025 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eH5fB6WX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B538B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755577674; cv=fail; b=Ln6UjqBURAmJG05BLrM9gM4spOwcWS/3AebHveUrE79cr2hhY4gLkrR7Ymo2o9wEWg/h4Z5wV50M1Osz7MI3u1uIwHboVzci/L5cdVGi/TejI3Ztxg/7buwg0ao/sUXpo4hbGQGDYZ0HKT4mOZodtIAxhh/iVsTti2ntJqBjn+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755577674; c=relaxed/simple;
	bh=bwvDqSRNaeRt3oyZ03vc0p9NoDFLA9MKvXUoF/t3l8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hp0Ol2uD7hO1pD9dNhTKMS7A7FYB50/nfHvfzEgpqo/hNWp1mcpFJbXUNGlV+tR9ch8HoK+q558robmxsADBbDJ5+wZeh6fBMzgERc6+PtGWIDY+WW7+mu7AmGaQY1a3o/xJbup7AwiXm6nDJbjpkLfDUy7fAXc8ElcBTZiA/o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eH5fB6WX; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tk3eRrIPOSbWcb9L0rSf7zKR0ERsIcBoWaJ8vwGtJUFBQK4cpDyupaVLavEP/7lL95mZ62gpUho01vIDliQc+MbIn6W3pj9qH0C3k0szzMYSwjPnenF+hdoCN7JOwTIb0Dy+5RvHzLJ9TL4iXJ2JuVq7grjDAy0eJzUfQKKIqPcmFgob+CQuyXJOfOpM7SrlEy+KNMwoNnMNY0DXsOh9yiBFxCcDE+3K6AGgvmbkMbWnZIyUk3wU3iv/X8BkcpHgL0K6zZY6cJ3+KsjXVTHz/2qw4HGIeO3ZkRWYTUPOPdHpg7l78BBCiuVzWQJR/unX0NXzoqMobtyBNIoKAIlh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K39AUmQ9r/9DAt/IBAz75VzwCCqULi4W/vEWwX2Y+4g=;
 b=gC+pZBrWegGeXxq9ldh/2PoxwoY5Y/mOpXUz3OSlfqmfCXQAFzSDpw452pbi0xh18935Ionxt9PJKPhd+FS681Tbis9dwyIa+M69/aBMKbWM7KbNFHG+o2OIn3vJRnDaNjQeBfb/8phgUaqHODRv3LHo1XfQ2hCBdkj5XcIDYDhxgCtj5wI0VT+ibxFwl8j0HVZ7KQGnr2kI5PeyhzEAKFTb/feInjWe+8/PvfmDQDv9U52dc0lv2FqMA696UEjvX90dywPxZd3hyrMbk+fTdHsQ4psNlj5pkFMtT9PjoOt+xLPNDHV0AqfmZZilGtul6qZFDOFOXt6Vz7EiaZzfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K39AUmQ9r/9DAt/IBAz75VzwCCqULi4W/vEWwX2Y+4g=;
 b=eH5fB6WXPa11Fzcuc8MGin3dY/DF+Bu9tV9PDnB9qenu2aowx9Et6a7qflFk6+GtJT/R8yVah8D6GukyKNhD/16pqpYw+5f19SZB6xTzdaQBgDKLEsKEZrP1yyyXL3VTwXiZj7z6POLLgC2oBXxSL6bGhaReK3l9x636hQeTC8Ok3TymP0lTHr5C5wPAVEPhd3BaQxAEFghvOrQBCNCXJvec+5gVjQ7jiZMLC1/GfK6UxLPnjBpyInZIGMa5FMMXCmvlAo5W/PITPyG+1+bo8mqgR1jctmCh/Jf68/fKiChaqAE1sTj54Qlck2yzdNgdsyH6+eJ64naW40pgRNnHSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 04:27:49 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 04:27:49 +0000
Message-ID: <e054f622-69ad-4724-b12d-c2545d913170@nvidia.com>
Date: Tue, 19 Aug 2025 14:27:44 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
 <20250814130403.GF699432@nvidia.com>
 <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
 <20250814141136.GG802098@nvidia.com>
 <c7bbbbc8-b9fc-40f5-b86f-e43b9a85aaef@redhat.com>
 <20250814172018.GJ802098@nvidia.com>
 <2982b6f1-7c14-46ef-afb0-7951f7cdc2aa@redhat.com>
 <pk4yq5kt5csh5yqd7f2s66eux6yvluxv3rcwrskaagyxcgo34j@6wei37bgqlye>
 <1e854923-c746-45ce-9f56-1c01a41992b3@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <1e854923-c746-45ce-9f56-1c01a41992b3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: b1117348-020c-4c80-b380-08ddded8c10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0p4SHRyZlQ0bUo5ZXVQYzkwZWt0UzlvaVlHQjhQYmJ5b1NGWkFVcDliRlZ5?=
 =?utf-8?B?QkpwMkF2cTh0dW5QOWVwdVIzbUdRNDFqQlJvUDRLbW1hS3hIdUloVHVkTU8v?=
 =?utf-8?B?cjBVWnRINTY3ZVhlNG84aExDa29GaEpWMU9tTlVub1R2SU9pdVk2Z2JWSVlX?=
 =?utf-8?B?b2ttOFIyS3JGaEJlaFNyTkRDQlRSa0s2UkZaazdaRnlMRFBtKzE5NFRqcyt2?=
 =?utf-8?B?Y01PUmtUSENaZ2tkZXZMVnFxQzBiditlODEzdWJSbTNCbmp0b0NaRnZCMW1Y?=
 =?utf-8?B?clNJMlVpTEFzRWQ4QldxeVc2bFl2R0ZjVDJsNnp2dlVmTDUrcTc0Q1JKaEpI?=
 =?utf-8?B?UFoydzNiN1grbGoxajNlMlFEdUpYZVV2cjZjMTVpY2RVVWVZZTdYQ2UySE9S?=
 =?utf-8?B?UVhDVE1acDAyRE9DbktMeHVpUGdyWUp4cDF2S3BrLy9xZjlETk9hMURjSlA0?=
 =?utf-8?B?bnE0QVNZZm9rbzQ4V0dERytoUnkrNFhOTFdjUjRpbEFXTnlSNjJqeWtXVjRt?=
 =?utf-8?B?U1ZCU3phaWFPNks1VHo2WmZncDFxdy9hTGt1cytVaTNicVUzNkt3Yk1PUWdl?=
 =?utf-8?B?dGtsVFVHaGlETjdhSUM0N2NaS1gyZzVIZFBBSjJRcExSOU9ZelY4M0h5Z1h5?=
 =?utf-8?B?SVRjVXVFQm5pdjFiR1VkcDdXMXJ0WGlONWMxRGtYNUVVZFJ5b1NRU0FHbVhW?=
 =?utf-8?B?TU5mYXZmTXk4RDFYSVVhMnByVzBYblo4aHJYSGQ3V0hLTWlIWXNOeVJTbWpj?=
 =?utf-8?B?ZFFSTGN0M3JBZlpsM0tsdEVBUkdoTCtGVFAyYWRhR3BlM2Y5alR2ODFZNnRl?=
 =?utf-8?B?cWhJL3RyVko3ZWt3Uk4yUGdBQ2RqM3kyalMyNzduOTRCbC9wNDZURm5xSlpW?=
 =?utf-8?B?QTJVV2pNcGlQNmh5c0pQV1dYVG9yclNPQXQ1YlUvRURvTWwrYlhrUzhDQnVR?=
 =?utf-8?B?MXF1V3dWWE5uS29LKzBCWlZOVnlPc2xiVFAwZUhkZm5xZWFkTGNtblZsSzlw?=
 =?utf-8?B?L21tRStMMjVtT3V2QS9qajJXY1ZPcEViTXhvWWxiQS9xKzRvNGFPRWZjbktq?=
 =?utf-8?B?VE9KNDJiODBkTzBDSUFGUjBiTUJ3TU1EUFhwMEVrS01ZTlliSFBjY0xONTZS?=
 =?utf-8?B?TEJDeUFVYTF4OEFGUzdoUlhiQ25yNVBCbUJTekdQRUczTXRtVlZmdy9ucmVq?=
 =?utf-8?B?c1lZOHgvTS9IMXpsSy9TL1JFM3NscmprVEY3TVMzc2swZjl0SFo0VzhOZ1p6?=
 =?utf-8?B?VEYvb2lUWjQ5OTJ2amg1S1p2bG1ZNU0yY3N2YVBmaHJFdm1XT09kUHF0blg0?=
 =?utf-8?B?N1E3NmJBSlRhTGpoeUtkdk5Qb3hmUUNjd2FJNXZLN3ExY1p6OHF3Z3cwZVFh?=
 =?utf-8?B?V3ZxRjlsN1cyVUdHVGZ4emtVbm9tN1hWVFpCaFdaU3NkS2x2N1I3NXZadWpQ?=
 =?utf-8?B?Rkdpb3doMm1aV3UxOHRta3l2b2dVMjN6MEdVMFdZeFU1UzlrZFRaZHh4MmNB?=
 =?utf-8?B?bEVDcHZ5b29SekZCenErWGxmYURodmlXMjJDd29QdUh2RzBRQlJaZHlxNDJs?=
 =?utf-8?B?bExCc0JIM2k1Y1BnK0NRS1gza2V0R2NFdzAxQ01nUDNxZTYrK1hqOHRwd3FF?=
 =?utf-8?B?NnFKdDYwSnlKeFdHaGZBdTdJS2Y0VzdSdXY0M2o1Z0dGMTdUdWdCU1l1V2RV?=
 =?utf-8?B?eWpVNXBjVXhLVm5jRUR6Z3pGSzQxMkhzNWZaOWpzMFJTU1MrSVhRN21LY3dU?=
 =?utf-8?B?dXFZRVZSVERtcjNBak9SSDZUQzhtazNRWFN4c1ZFanI1SkRmR04yU25qNEFX?=
 =?utf-8?B?Z0UwQlZiZUlzNVVJTWRSYlYvSjk2WkVsQ0drU0JDQUtDcllnOUJKVk9uTS9w?=
 =?utf-8?B?SDF0cGRHK05sdDV5TUdOeWNxMXFoQ2dwQzBhQUt6SXFTMDFwK1ZQaWpjSjRU?=
 =?utf-8?Q?FbRMFCzo1X4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3V5dHlHYTd1ZHV2aXhxVlZKM2ExUFFvZmlZcFd3UnNqaU5RSDF2b3BXMEYy?=
 =?utf-8?B?RmxOb0JxeVpIbHBDUENTSERGZDczYkZLUjN5eDZTcjBkaktYSXBvZWk0WEVk?=
 =?utf-8?B?TVZtbWtMaXFPUFFLZno0Z2E1dDk1Q01FQUdzK2lySEo4YzZaTUlNMmdFdXVK?=
 =?utf-8?B?ME1KcGF5SmR1bVdmTjljVTVTVk0xRXhpeWF3SU9MSDRzTlZSa3Z3TXhnRWpp?=
 =?utf-8?B?YktPZThTei8wRFVDZW1QOCs4RHZUdDRraldCVFlwRnBXOC9nUVdSdE45ekFI?=
 =?utf-8?B?UnNHdkJzWFNTc2RMaCtORUZPZ3VoSUs4a242bWlnQXNmK3pydEtaS3Q0cW45?=
 =?utf-8?B?Umx3SytiMXhXQlE2RGh4Ni9CdVNUKzFlR2lnVG40c2VnVUhZQVJVbWgycU1u?=
 =?utf-8?B?MjNrWVZOSmJKbHR1RWsxY01ZcmFMZ3J3UkVWZ0xBVktyVXJ2M2FCUkFEdG80?=
 =?utf-8?B?SFJNVFhHenFWQjNPSXErQUk3UVNydVBwMjFaNFBvYUZkRzFWZ1BxdlU4YmpC?=
 =?utf-8?B?RDBMSFI2VXo2aWUvbktYVmtvRkQwYUxydjVPUExFVUhmVjVTS0d1aFRMdDZq?=
 =?utf-8?B?OC9YZ280dTZjMG9NNThYVHJoZXVXRFkrU2MxT0w4aTZTYkM4TmJsbzRYWDZk?=
 =?utf-8?B?SWlSNW01dWIya2cvRjVqOVE3OXE5N09SbkhwT1VDcDNjQU53M0lZRzI1blJC?=
 =?utf-8?B?a3VHZzRvTUpoZE1XU3JSQ25yUnd1QmdsUFd6M0g1bUNoZjYyMEJoYnFjMVJx?=
 =?utf-8?B?WFBLTlMxZkJtVkRzSDIrdnFDUG1mTkpSQkI4T1lIcmc0aTBuY05qUzlreUU4?=
 =?utf-8?B?WWRxMEJpbEdvZVpOS2l0WFkxOUpkdytML3JXeDB5UFp6SlZzN3Y5UDdrSXZH?=
 =?utf-8?B?RXlUUWdFa211NVhVaC9nQk5oeE9DZEdMdGg1S1pSd0JpbnRHaHcrNDRuOFRB?=
 =?utf-8?B?SXRueVlpNXNSYzZxYWI5dEtKMTNSS1FIbEJEdHUvcUo0c3N1M2pNZXkxWUZS?=
 =?utf-8?B?d3Z6M0xMU0ZGKzZkVjNma2IxcEVLRmRmak9VVldUcmVFV3p2aEhTbFAveEJk?=
 =?utf-8?B?d3lmdTJXRU1jUUptVlg1YjhpcWlleFlIZ0hoSTN4UXozRWNUMVVKSGY4WDgw?=
 =?utf-8?B?S1ZDZHBTYTVnNnlmTnA4TnlGUGY3clhHT1FRTWJIRFY3OWRjenRDN3lPS0Q3?=
 =?utf-8?B?NTAwOVF2MXI2aUJxUnBHQkRLcXVoUkpxQUxuaVRGL0JGM1JLS3dpaG5kR3Jy?=
 =?utf-8?B?c3MyOE13LythRWVXV21OUm9JTlRnTTFHUzI3L3ErL0Z1WkNndnhhQVU2ZnpI?=
 =?utf-8?B?VDFCeDcwbEM5RHVPQ0RVK3lMb3pqZ3laVXVHVE5FVjgwRFNNWHczeGYvN3Fz?=
 =?utf-8?B?NHYyUjZVa3JGeloxUit5eVZOeGErOFg4bm9YSS9vVU9BZlc4YjQ2QTQ2SDc0?=
 =?utf-8?B?b2RTY1grT2FyM0s3MEtqY0Z2Vkp3dGpiM0UyOW96VlRQQ0NHZEVrS2w0a0Nn?=
 =?utf-8?B?d0YwRVd0OGI3ZmRVdUZ1T3FMaWpVZ2x6KzYwRWN2U2NpVDJMU04vVDYvUFVm?=
 =?utf-8?B?dXNXbVY3SUY3VWwxcmJTZ0UvT3IxdHk4T0YrYURJWXNlK3pLSXQyYlp1QTBG?=
 =?utf-8?B?YmQzL29GOGQwbFdOQTBVSFdwazFNVys4aHBhM05RNkpEYjJLVEg5aDBJdGlh?=
 =?utf-8?B?MkQvL3BUaDN1U01IdkZwVmEvQzJkSU82VTN3K1l2ak1vbzI4bVpsendMWXln?=
 =?utf-8?B?QzU1Vk5QeWVmbUZqMXZOWndrZVYwYXF3QVFDRHJrMGhoWUlISFRFK2JUcXBR?=
 =?utf-8?B?UHJUcDgyQ0FNVHpKRFlSOCtJZWxUdnA3VjRkb2ROZVJUY05ZbzJ5SmRCMEN0?=
 =?utf-8?B?eDhtdmkzSU92ZG1yVjBmUmU5SlJwYUhuK2NudWh4M0UrTXNiNkFwcWhUektq?=
 =?utf-8?B?Qk1udG1Wb3JPcU5iaGMxN3RIMEo3MHhMWm9MTkgwQy9EanlhTGFOU2NUMktk?=
 =?utf-8?B?bzNEWFUvQWNIZFFWNjNsVmgvMTdPSjZkTWcxOHhDaG0wQm5XMlBuMW1jckFV?=
 =?utf-8?B?R3dzc0grYm0vZFhJQmFhNXBTbFduT1Z6YkVKdEs2UmNodDVBR0JZTjRrcFNP?=
 =?utf-8?Q?ABlUPZzQcIC95FjzvoVMsAZ7k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1117348-020c-4c80-b380-08ddded8c10a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:27:49.0713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Af6f6A19X7E4jbxVunqeNHjn8e2WRGyF5qG3I9Tfc1GSbH1K52Tcj7nD7iKkqPCn8iwbDe4R3rxV9E8OzrIJ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

On 8/15/25 17:11, Mika Penttilä wrote:
> On 8/15/25 08:23, Alistair Popple wrote:
> 
>> On Thu, Aug 14, 2025 at 08:45:43PM +0300, Mika Penttilä wrote:
>>> On 8/14/25 20:20, Jason Gunthorpe wrote:
>>>
>>>> On Thu, Aug 14, 2025 at 08:00:01PM +0300, Mika Penttilä wrote:
>>>>> as well as hmm test module with :
>>>>>
>>>>>          * Ignore invalidation callbacks for device private pages since
>>>>>          * the invalidation is handled as part of the migration process.
>>>>>          */
>>>>>         if (range->event == MMU_NOTIFY_MIGRATE &&
>>>>>             range->owner == dmirror->mdevice)
>>>>>                 return true;
>>>> If I recall this was about a very specific case where migration does a
>>>> number of invalidations and some of the earlier ones are known to be
>>>> redundant in this specific case. Redundant means it can be ignored
>>>> without causing an inconsistency.
>>>>
>>>> Alistair would know, but I assumed this works OK because the above
>>>> invalidation doesn't actually go on to free any pages but keeps them
>>>> around until a later invalidation?
> 
> Thanks Alistair for your deep insights! 
> 
>> Right, the pages don't actually get freed because a reference is taken on them
>> during migrate_vma_setup(). However other device MMU's still need invalidating
>> because the driver will go on to copy the page after this step. It's just
>> assumed that the driver is able to be consistent with itself (ie. it will unmap/
>> invalidate it's own MMU prior to initiating the copy).
> 
> And reference is taken as well in migrate on fault during hmm_range_fault
> if migrating.
> 
>>
>> In practice I suspect what Mika is running into is that the page table
>> synchronisation for migration works slightly differently for migrate_vma_*().
>>
>> Instead of using mmu_interval_notifier's which have a sequence number drivers
>> typically use normal mmu_notifier's and take a device specific lock to block
>> page table downgrades (eg. RW -> RO). This ensures it's safe to update the
>> device page tables with the PFNs/permissions collected in migrate_vma_setup()
>> (or the new PFN) by blocking other threads from updating the page table.
>>
>> The ususal problem with this approach is that when migrate_vma_setup() calls
>> the mmu_notifier it deadlocks on the device specific lock in the notifier
>> callback because it already holds the lock, which it can't drop before calling
>> migrate_vma_setup().
>>
>> I think one of the main benefits of a series which consolidates these two
>> page-table mirroring techniques into common code would also be to make the
>> mirroring/invalidation logic the same for migration as hmm_range_fault(). Ie. to
>> move to mmu_interval notifers with sequence numbers for migration, perhaps with
>> filtering if required/safe and retries
> 
> Yes with the migrate_vma_setup() and collecting removed, the firing of mmu notifiers
> and "collecting" are integral part of the hmm_range_fault() flow, so logical to use
> interval notifiers for migrate also.
> 
> I have removed the commit with the owner games. I studied it more and seems it was added
> to mitigate a bug in an early version, which led me to do wrong conclusion of the root cause
> of the hang. That version had unbalanced mmu_notifier_invalidate_range_start()
> after returning from hmm_range_fault() with EBUSY (after done a folio split).
> With that fixed, driving the migrate on fault using the interval notifiers seems to work well, 
> filtering MMU_NOTIFY_MIGRATE for device for retries.
> 

So this patch can be ignored in the series?

Balbir

