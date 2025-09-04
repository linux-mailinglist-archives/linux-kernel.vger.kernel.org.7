Return-Path: <linux-kernel+bounces-801364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E8B44437
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC447561429
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F2309DA1;
	Thu,  4 Sep 2025 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HofHk6U4"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2048.outbound.protection.outlook.com [40.107.96.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A8223DFB;
	Thu,  4 Sep 2025 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757006517; cv=fail; b=D1m2SIEAvX1QgzxKqoT35SiCHH4gCdO9nuufub179DWY1zL0odXsmP4eCviVcHQCFnILnF/nASPqHSpjhAsLPr5jVklZRYEl/weSexIEcZ0gRAnIGMytpbH61Lkl3PEQ/BWCDh7kCiNAh0cYPKEkNMEt9NNcD1Fme9/GgrS/iX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757006517; c=relaxed/simple;
	bh=VxrziEUdGvfRFyLpasvceUHXmAPrSYhJvXBvgtM8+WE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMpea8guDet/jkkSahm80DRscGkZOe2D8nWCCbwBWR1u/1qbM7oG0RN/pvT+jDw9HdbY7+T6EupaOF1Th8kGhsN7UxaZx6qtBEz7YUaA/wB0+D+j4spjgvHWyhTkNPTD2M/TuL+SuTbcwG7vuV8EWQUbit4FeKAl53j13zlhnj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HofHk6U4; arc=fail smtp.client-ip=40.107.96.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyJBGoUpZRj9kgagvMoS0FpnX57vRh0g7ZLc19M52WLlVSgXgg8FqUKkP6EpSFOFGTOuE2wg5feo+vL3cihLIkbovtAbGXM0Bj0h9gDlHFNaUK5NxGGvej8XHX0UYsHjGMUth8mP0Mp5IgYcMnf+p2kTLXr1Cpai4AY6mGOlGm2uhMHPqIbl9YAc4zN+vNfHvVFw5f/LbV2Exzhkm6j3GsvokQceK7n3oVP4djzl2dYRLRBNpgSQCgN1PwbQWBK1pLIgvADJT/wwan9s4j0+FL47nYJTHVgRoLKvDUenvCax1xvRRGjdKtcahZOxqupjDr0J6mSEooyE8WL/s8Dq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5qjxFQcUXJTNyfLZ6kwEgnVr+o72XEQ/Ml+5E08S5k=;
 b=SXK9U218YNzeq5Qvp/MESsyOm6fUY13OL4xPt4QFr3AuUnUlF6dVJr96nJIXqp1+radKuCblaqBXF/Ai1+WWYumd0qHc0JLDGyG9+WkzcNaI46mfUSsd0QOUSzDZJoLrGDAKS2XRNYpbfAYMAx/DeXEjd0gHXLBBffNCmSkXw//BemZ7Usnq7xBJANVdPmLWZFFk38jMWgRymZlhZW90EV05qXm5DXxCjxXvx0p1LATonDkhLa1ia+4BrtQ4CTZuPTBirjeONmUt5y7WB3vQX5CiKbFyUTSxXI4j9FEuLYwAKryIRCTt5GCiNXlSvqi8KaqAJeE7hHZDArvuHDXdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5qjxFQcUXJTNyfLZ6kwEgnVr+o72XEQ/Ml+5E08S5k=;
 b=HofHk6U4345SYFjMUMXDy5DTrhuFDcvI3YxH57r+XFvE65MfVhZ5lWkkvd2PkTceS8c0I5CP5MUwkbOqfmF6UYmJqgzzGPG+wyFx8zfmB+2P0x9WBAF0mGxQfgsz27sRi1NsA8p25255rwYSh7JJRFJPrbeA/Uwaa1nE0L+rRLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by PH7PR12MB6564.namprd12.prod.outlook.com
 (2603:10b6:510:210::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:21:53 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 17:21:52 +0000
Message-ID: <55dbe7ee-8e4a-4f09-b00e-8e879d8f6ad6@amd.com>
Date: Thu, 4 Sep 2025 12:21:49 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 05/33] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
To: corbet@lwn.net, tony.luck@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <8f2c506c2e0bdc4ab3e4736435d683ceb5322839.1755224735.git.babu.moger@amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8f2c506c2e0bdc4ab3e4736435d683ceb5322839.1755224735.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::26) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: a710d5a3-e322-4957-8527-08ddebd78a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1RBNDNzVDJtNlNMZnRVbDhIbWhJazVFV3IrY0hQMWU1K2NlNG1LcjJHcHIv?=
 =?utf-8?B?WHAyQ0FEVWtUeXU0L2lIK0hoUkVWNjBwZVF2Qm84VUJndW1XaWdiRWFBWXB6?=
 =?utf-8?B?ZTVHNHVjME5FN0s4cHdvKzlpNUhDMXB0bjFYSS9oYTFWSW9Na0NKV2tCOW56?=
 =?utf-8?B?Ny9VUmhURGJXeW1FOERBMUk5SGd6YzlTVFJYK1FXcnRtb1J5cW1PYmtSeUpa?=
 =?utf-8?B?Qm1lZmRRZTlrcnY4aEUwMStadG9OeTlxaWlaYmFickFRSzF3OTBrNTVKTkRJ?=
 =?utf-8?B?N1FmSFhFMkRweXJDWjJtbm92cW9xbXB0VGRnb1VGdUNyRG9GOUJua21SS1pF?=
 =?utf-8?B?bGt2ZzJZUlQwaDJmTEwvbHVLZXF3T2lOTGVJWUhtbTNEeHdpR25xUWIvU3pa?=
 =?utf-8?B?elVQb3ZKVU1MelVqanUyNlZqUSs2cUQ5cFVUYjFQYWNmaEgyUEdrRnUzSjJq?=
 =?utf-8?B?SmNueG14NzVtVDlRY3l5MVY5emUrWm45azN6dlJmY2xyZUcrQnJybVdETHhX?=
 =?utf-8?B?ZEU4b0tuV0JpWDAyTjBuMkczNEFKK25uZm5odW9heUh3STBXaElVRWlqcVor?=
 =?utf-8?B?UldHdk5kaG8yUEpnLytCaUh4K29nMnUrcXB3Sm54M2wxV2NzVjJsMEVCWHJ1?=
 =?utf-8?B?cTRnbHM2MFQ3MTVmdGZuTUtkK2I3WTRUUXV1K29mb1phRG80STB3NWxLOW96?=
 =?utf-8?B?THpNV2pFUThBdWZSK1piYVZuV21oN1NYOG5lVzJocEFETEVnVGozek9kYlR0?=
 =?utf-8?B?aEpGb3dNaEd3MWFqMjdxQ0pYZXNod21JVXdyMDg5WXF3SEhKUzNYTVdNdE5n?=
 =?utf-8?B?ODNMUG9EcFljSjd1dVFRM1N5TFBrcVVmN3ZoQ0h4SUxueXhITTA5bHAzejRO?=
 =?utf-8?B?SDlXYU1nanNieGVRN3dEQkhrcjB0Tnl4ZUNhL3B3Ym5ZWTZpd1h5Z1NTUTQ0?=
 =?utf-8?B?ckhvdWluS0l0dVduYlJNSDRzY3RPT0ZnZVdsbUpvbkMzQmYxUEhaRDI5R3pn?=
 =?utf-8?B?U1NPZGhEYitEU1JxeUJoNm1zcWZVRlR4SjRDbk5IQk9oSFBnbzRzSDJwSjZU?=
 =?utf-8?B?dHY0MzRSK05DaFhpaWk5TXVabjBEOE5lZlE3VERYMGw2V3BXL0pLSjkrT0o3?=
 =?utf-8?B?TEkyRVNFOFlyV1VPaDBzajB2NURqNkdlcmZhaVFZbG9SbEg2bnZjQURycTNu?=
 =?utf-8?B?bU9veUgxRGNrR1ZUdmhwQjlJMVVMT2lEZVNhWG9JWXNnSXBWQVZ0bFBvNFJ3?=
 =?utf-8?B?NDAwdmdSMnFQTFdIR2lNNVVrL3NXaWxwVEkvSG1aOGd6Uk16OElKWHpvRUlB?=
 =?utf-8?B?WnozR1BhSUt5bXZ3S2ZLWUpWcXpKVW5zU2xENXZNOVJTNlo4aEM1VW9jampE?=
 =?utf-8?B?MXBNMHFYN2V1eU5KQ3Q3S0MwdFo0NDgwWnRSN1RLU21hM3JzOHdiRUpJbGJE?=
 =?utf-8?B?YWVvMFpyVjY0OTdhdithaUZETjBhNm9tdU1pOXpNaXNrVTdTUVpIQndFdTlQ?=
 =?utf-8?B?U3VObjF0NHg3eC9GbnNvL25QaThtK0RadUdwc2tiYVBaclp2eENaWDhTNW9z?=
 =?utf-8?B?ZW5tR1hHNzNJMnNiMFVZcmNSVFRobkY4R0FOd0Q1MjljbUdKU2NJVkVCV0JU?=
 =?utf-8?B?LzdtY3p1cFMzUHBKOXozNDFKUHFBNW1rK3l0bFJKd0NWeXg0VEY0QVJjRU5u?=
 =?utf-8?B?S2RVZDRZcFdZbG9IdlZMYkVhelN0Sm5WOWQ4L3pOUzFReHZKQndYVUhhZWNr?=
 =?utf-8?B?c21WMGhXak9qc0U0YzhoQkZOcW92ekJDblVCMkJzYW9XZnArN3NVY3VOUWla?=
 =?utf-8?B?NFBCWEJKZzVsd3ZuZG8vWDdHaEI2ek53V1dIcFI1K0kzd1BabGcyMlpRQnFh?=
 =?utf-8?Q?+HynwGqp3uu4E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0JSQ1U2S3JHajhkYjE1VVNsS01KbFBtM0NvbVA2ZGxKMmNTdGhPMlhNWHRv?=
 =?utf-8?B?MGVzUmFZWkVoUk8vWXlRVjFqV2htQWdQUEh3blcraVBSNDR4ZEhBaE44UjFP?=
 =?utf-8?B?TXU0RklUc3paNWdvV1VtR2NRSmlXUTZXckczVC8wQ3dYRkI4NmpSMzZza2h2?=
 =?utf-8?B?MXp6VjlUZ2tzbTVYYmp2NFFzRnQ5ZzFGL1JRVjlQQ2V1YXdwWGtyUmpZMHdi?=
 =?utf-8?B?QVNiYnVQQ2tuRE9jdjB6OEdvTDhmaGREaGN2aWVRWXpxSlhHOWlSejArTTRW?=
 =?utf-8?B?WkZoQUtNakFyWllOcTRZa0FOUUs4WkRRTWhwdDdOWVlEMmUwc2Z5V2ZtQ1hZ?=
 =?utf-8?B?RjE1cGpmaGFNWGVsVjdRTFZYMEJPTU4zdzk3YjNLMGFJeVo4UE1rT1pqayt4?=
 =?utf-8?B?Z0s1eDJTbEdVRDlyQUMzdSs1TmRqY1RtYzNCT3pxMVpCSlFMRzF0Q1pTbTJC?=
 =?utf-8?B?SVprZDQyQXMvZGhpMThrcTE3ZUd3RGx2c20zSVhqZEpYUnlsek5CNExsbUpo?=
 =?utf-8?B?djJtWC9yLzJnZXFXTGdnTmw2eW5XdE9MZUxCRm8zYkdZWFRmWU1xenVBUmZo?=
 =?utf-8?B?QVZNc1pFTFhyenRhZlRycm1EVGY1N3VVUWVPRmF3T082VWk1NlhneGdiZ0xO?=
 =?utf-8?B?dzRvaGhqbCtMNGc1UThKUERGUUNVcDV5OHlBQkpOTWhJU3hMOTRxTE56Q1ZV?=
 =?utf-8?B?OVUvM09FRGd6L2tLa1pVRDNJRndYYzB5VmxXZFlrdDBZNmVyWnJUNjdSSCtj?=
 =?utf-8?B?Y2NhQkJRQjFESDU4enI0a1pLN3o0b0d6N2Z4T3lreWFid2k0ZWMyVjVEcys5?=
 =?utf-8?B?d2w0L2RVZ2Q4NnM1dTdzNzB4cmZIMUZOZFdleFM0bUI1cGFXUE5ZQVpTNlpz?=
 =?utf-8?B?TFRtcU5uL29ZaTk5QXVFSThsSy9OeGRkUVMrbC9abzlGQnA5U1M0ZkRFQ0ln?=
 =?utf-8?B?NksyS0ZQNkVXRjZnSG1PYWZpdUFxMitWeFd3Si9qNWMvVXM1blVLUFNhTm9Z?=
 =?utf-8?B?VENnUWRCODlaQ1hKM2FjakVVbUpudEtTSEovU2Z1bnJlRzVkSTY2MTJ0eDc5?=
 =?utf-8?B?SmJsWEFQOVoxQnhuYU5sTnNFdmlMZG5uT1NuelpVcE5WZlp0UWhkdXp3cFRU?=
 =?utf-8?B?Z215Q2k2V2hncU02OTZxaFM2TVl1VExyUE1FbTg4azllVCtsQ2phOFMycHRk?=
 =?utf-8?B?NFhwdHpLZDRQVGx0b3A3eUZjei9MT21qdHluT2oxQUdxRi9iajNwbm5ncEtJ?=
 =?utf-8?B?bEtEaE94bGVHWENYbk1CSXBEa3RTaUZWcFVmL05aUXF1ci9RTTJ4OGpLZ2Uy?=
 =?utf-8?B?RDRsVlNmOCtnZ3BNSURSWUk5STFCTm9qdDQ4SnNTaHZBUjZVRSs1NUxZMG5r?=
 =?utf-8?B?K0M3U2J5SGFtajJ4QUN4cWRGVzRoakJnamlaMWJBUGNzZzYwNVFSMDZhZTUr?=
 =?utf-8?B?aTZSNUE4YWVEbU5DenFrcklCWXhzajJRTkVUUkpJdEN0QSswcEVTdkVQMWlS?=
 =?utf-8?B?d0Q4TDlTZS9Pc0tTamwvUWhMMXNpWXllby9Sd3VzNWZwZzAwUHFQa2ZCVGlu?=
 =?utf-8?B?bkI1Y3c4VWxVN1F0UEJWazd3QmhWamMxQW1wZ2VEMnRqZk1sYTBWN0Fmc2hI?=
 =?utf-8?B?YTZQNENuR0VwSzJYRm56ZnBpUk5SQzFFbEFUNVN3SXNBZ0ZoSTZjd1U4aUZC?=
 =?utf-8?B?MFRCNFdiMEVLd3gzRUpCSnVObldROFlBZ3AwSVMrWThuWEZlV3dhcEVzNWFP?=
 =?utf-8?B?TmFHZDVHRlZEa1NwbFBoUUFINGNZZEhJNlQxbHJkcCswUFlRbmpiTWNQNEgx?=
 =?utf-8?B?QmdNOXZvSENwdWF3cVFDcHFoNFRNY0NoSGp1V1BDMWU3VEVhU3FSc01JeFo1?=
 =?utf-8?B?ZzRzTFo0dEhrU3hWOC9OSHdHeUNkb1VNelo1S2VLdmJYQlM0SzJ2VWNPNGYv?=
 =?utf-8?B?ZFVST01lMzN6MTZvV2MvL2JGVzdhLzBDZE9vdG9aZ2hsellRTEV6N01oRlV0?=
 =?utf-8?B?YXVCd1VHbjJDRDRvKzdLcjVveHlzU1YyYlQ4TGV4QlZSZkx3QVBPT3JDQXBj?=
 =?utf-8?B?Qk1sNFNUZWVHS0trVU5lbGplUHhCMDZkeHEySm9BV3JPRkZMTjBUUWFPVS95?=
 =?utf-8?Q?qpCA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a710d5a3-e322-4957-8527-08ddebd78a3d
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:21:52.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UigtUlGZUxWios9cwPfI/lChcHLT+jAbPwMP1TSFeGXsHNpRYALRdLmslmgZMRHX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564

Hi Reinette,

On 8/14/25 21:25, Babu Moger wrote:
> Users can create as many monitor groups as RMIDs supported by the hardware.
> However, bandwidth monitoring feature on AMD system only guarantees that
> RMIDs currently assigned to a processor will be tracked by hardware. The
> counters of any other RMIDs which are no longer being tracked will be reset
> to zero. The MBM event counters return "Unavailable" for the RMIDs that are
> not tracked by hardware. So, there can be only limited number of groups
> that can give guaranteed monitoring numbers. With ever changing
> configurations there is no way to definitely know which of these groups are
> being tracked during a particular time. Users do not have the option to
> monitor a group or set of groups for a certain period of time without
> worrying about RMID being reset in between.
> 
> The ABMC feature allows users to assign a hardware counter to an RMID,
> event pair and monitor bandwidth usage as long as it is assigned. The
> hardware continues to track the assigned counter until it is explicitly
> unassigned by the user. There is no need to worry about counters being
> reset during this period. Additionally, the user can specify the type of
> memory transactions (e.g., reads, writes) for the counter to track.
> 
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
> 
> The Linux resctrl subsystem provides an interface that allows monitoring of
> up to two memory bandwidth events per group, selected from a combination of
> available total and local events. When ABMC is enabled, two events will be
> assigned to each group by default, in line with the current interface
> design. Users will also have the option to configure which types of memory
> transactions are counted by these events.
> 
> Due to the limited number of available counters (32), users may quickly
> exhaust the available counters. If the system runs out of assignable ABMC
> counters, the kernel will report an error. In such cases, users will need
> to unassign one or more active counters to free up counters for new
> assignments. resctrl will provide options to assign or unassign events
> through the group-specific interface file.
> 
> The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5.
> Bits Description
> 5    ABMC (Assignable Bandwidth Monitoring Counters)
> 
> The feature details are documented in APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC).
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

This is an FYI. I am updating the text about the documentation to address
your comment.
https://lore.kernel.org/lkml/53387aa7-0e72-4bf9-a188-43c0f78c2d6f@intel.com/


The ABMC feature details are documented in APM [1] available from [2].
[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
   Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
   Monitoring (ABMC).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]



Hope it is fine.

Thanks

Babu



