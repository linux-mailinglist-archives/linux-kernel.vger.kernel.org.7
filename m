Return-Path: <linux-kernel+bounces-759456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FFB1DDC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45547189200A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9122F77E;
	Thu,  7 Aug 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BOnNMSx5"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D902253FF;
	Thu,  7 Aug 2025 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596794; cv=fail; b=TTybpkJi6X3XUG37NqtuzWvu79bYU90PzyUqzCrvarW35TV0uXxUQjCfq7hrW41jjSeArm5ACanPUcgJF9QVzYCqhzUGcwl14o/8Bky8oLau+3Cd4KlqbyZIT+z7XoawRqpcSu7CLTlpllzVagGeR5oCV8VQSNuuPUUvyK/duzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596794; c=relaxed/simple;
	bh=I72IU46OcjtrEM7BVSdVm4D6LZcRs59wG+TUeMZO+nM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZI8YbeEkEkAqjValrAo72XdBeIAle8k10t4YvOKHrUTggoN6go+oR0JJ0MOK3QZiPkfW1T5UDvytZQxmDFMzuOJ88Vd799nMNuFe2nfESspG2DFR2X/nwqiVlVVO76s1GohBQ3l7rdttINVU1Ryyky/xWe3AmAggOGOI648ZSsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BOnNMSx5; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJMXfxLy+p8BW+ytYBTFAO3XJmGQGi6O2f6lJIeHosQ+Fp667Vbgvw1No9FMra+1rxk+EwtvrJE4N4w0W8NHQYLiy1mJVU8lnb2FKqdfjIvo4flpPHIaSHd0O+X8Zhi2kGcUkukipcoiGcItSPM7uEAIwTIahepdKb1uRc2/DPO0UnrEYEWQkmj/vWq2r4Iq9bCaSsJ7rQpW72j+p5CG3EA3CR3hpsLHRho3q6MDnJbaPyD6z6miuIMl80CfpEDHhMGIMxr/MoWhI2Ffjf/sU7oDim5Q4ybu+6hzy6ugjBNHRsnpYy5vvcULtAzFGq6Nx/8gdUabduo9riizhFrILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idu3umTtPs1TjrOnlghGN9sMWTXxiAbCObHWxeWoBQc=;
 b=Z5bHsF4KmFiRlJVBYwSPFEcPRVrwZMt6SJjTNjrArSY5Mioba0RXniyp/pa/3J9vnyrBhtvMvWXdXtnrjKdrNG1jiXhc02jUlGEarlvlSvENsZwZr1fOBfzrclzMzJq9Cu54qmdQK1RzKmsYXNHcEpbSEceW1oGSFLYXn94hoxbnPdBa18TCvSK+TrZV7Wn55TP+aLv+NadcrAVDYBFY9uMJwUaZQZoD6laqWXGvs5Pdma9tiwgJozJO7tHCfbgKrDcXbvPaVmb2+roecclk91Ct21EEmgfhbERKsaEZBaRxxWqg/ZgeTDdiYhpr2NnQVApoMS/aSq4GhacEHf47vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idu3umTtPs1TjrOnlghGN9sMWTXxiAbCObHWxeWoBQc=;
 b=BOnNMSx54+dqs13e5dc2V7AhN5Bq6mya7GJCufievI3aBI1Ak1PskD5vaaF72CEcMD70xmzTjLtX2NvWHTUT999CrodWLNrHTY0/AuYQIxeE0rJrWpEt6nDxvfdI8UxwXGBqYuJ9gIke3JpZkm4DXnG9RLVyr2r63EthvJd+PBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by SA1PR12MB5669.namprd12.prod.outlook.com
 (2603:10b6:806:237::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 19:59:48 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 7 Aug 2025
 19:59:47 +0000
Message-ID: <bc29115c-c120-4911-9ac2-4d70838c4188@amd.com>
Date: Thu, 7 Aug 2025 14:59:43 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v16 20/34] fs/resctrl: Introduce counter ID read, reset
 calls in mbm_event mode
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, james.morse@arm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rostedt@goodmis.org,
 Neeraj.Upadhyay@amd.com, david@redhat.com, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 xin@zytor.com, manali.shukla@amd.com, tao1.su@linux.intel.com,
 sohil.mehta@intel.com, kai.huang@intel.com, xiaoyao.li@intel.com,
 peterz@infradead.org, xin3.li@intel.com, kan.liang@linux.intel.com,
 mario.limonciello@amd.com, thomas.lendacky@amd.com, perry.yuan@amd.com,
 gautham.shenoy@amd.com, chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com
References: <cover.1753467772.git.babu.moger@amd.com>
 <518b133429018f8b2f51055cfc2342536df98b84.1753467772.git.babu.moger@amd.com>
 <3b0f08bf-9b44-4188-a3a8-b5175510016e@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <3b0f08bf-9b44-4188-a3a8-b5175510016e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::10) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a29784-1155-41b3-a75d-08ddd5ecf638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGlzc0UzK1lzYldSY3NHMEd6YVFBQ1JJVDNDQkZiZ29uTTVFdEZEZnA3SkUw?=
 =?utf-8?B?NW53cmxqemRIYXhtcm83K1B4K3ZJVWx5MlZoZUV0RkZzenJ3Q05rclp5THk0?=
 =?utf-8?B?ckE4Tmc5cFpYVW9xaHN3ZE4vMkdrS1FaWkVPdXJra1E4MUd6ckNVRnlVT081?=
 =?utf-8?B?UHdad09WclIrS1dXQUx0WjVNUEJob0tCT3hKY2pJYUx2T2lLeldxV25Qb3Vr?=
 =?utf-8?B?R2VCc3pXTTQ4KzNxcmk0TWJSaXJadS9GMVA1aXFaK0M2cDkwWHdKVDRaSThG?=
 =?utf-8?B?Z1R2RVh2Ly9PSm14WXZOUlZYbGltUW5XTXp0ZjBtZE5ZUkcrc1NTUnFVV1Y0?=
 =?utf-8?B?QmtSZW0wdDU0bFpJaEZkZ2VRb1NNcHhaWUw5Z3ExVHkzTGoxZnYvRVRQUWN5?=
 =?utf-8?B?bGlqUllJaEhCNi83RkhoeFA5MFlodHEzakc0elZsazIxMVczZ3cxRHdzRnJF?=
 =?utf-8?B?bHpTQVJONEUrVEJjdFNOeTQwTnExR2F6VGVIWmZkT09WckdzbE9IOVFCQzVm?=
 =?utf-8?B?QVNuYUF6Y0FQcGRmaW9sSXVrbG0rcllKZjFHZHplbFUrRmtuWVQ2VGZ0cTI1?=
 =?utf-8?B?bzZSMENidyt3WW5HU0YzeXFwOU55Z204aDJtUzFTdjEyRTFoY0ZVb1JFSGx4?=
 =?utf-8?B?c1hKVW5JZ0tjb3lMa0Q0ZGFLeVgrd3hHaDlQZGdMTDlqZ0hxdkRYc01KTzJa?=
 =?utf-8?B?TGcwSzRFdVZ4ZkhmLzRQcGtlNko5WW9CZ3BiOVIwVXlTQlM1Vm9nTythbFJM?=
 =?utf-8?B?WnBPeFFYd2h6eUkzUHZwQUNkaGFJUHpSQnFNYkgxQ2xkQWJ3cWRrQldCMERr?=
 =?utf-8?B?Z0JqUmF4NmxBZC90aGhKenRHdVlyV0txTnRObU1sRkdVR2o0RGkvWXFjeWxv?=
 =?utf-8?B?RXJUUVZnUnJOci84NjgyU241bHBKWC93T0t3aFp0V1NsOEd0MnRZL3c0SDdH?=
 =?utf-8?B?RDdhQitxSXNmcHRPVkIyZHBvZmVGVVhCY2lHZUFQWkVIQmo2emxLT1RlUkdO?=
 =?utf-8?B?bTVxRlQ1Nk9jUDkyOStSYm10RjhMYlZaNzd5MEx5aDVSTWtQbWpLMStZQmVG?=
 =?utf-8?B?UGlMRWhva2JPRGxmc3RzNmFvWUdsZW9pRUlscUpuNVkyakZ2UmRJK3ZYVkg4?=
 =?utf-8?B?eXIrd09DWUJCT0ZMRUFURnF6bVJzbXFhQkdPVmFRQVR4RHBrQThEdXFGZDFY?=
 =?utf-8?B?MUJBU2QrNXNLUjJ4eHlhS3JtUDF4ZW9ncnN4NFFlZWE5ZERNSkRTZEcxQXFD?=
 =?utf-8?B?Z3lsb05qYmtadnc2UDVBbFVMVlRiMXFOelZPU1dHcFJLNXlhbkhxcWJhdUx1?=
 =?utf-8?B?RXV0ekc1YjJpcHk4UVVzMDQyazc0V3hVK0tuWlZ4ZWI0Rzc5bVNBb1lLSkdT?=
 =?utf-8?B?SU9RWGk3eWE4a21ST1VUYWdnUHZBQjdlUFlYcjAzTGRNS2FvWTV4VUJ3RGx5?=
 =?utf-8?B?bFprc2pCMVBPaEsxUWxRbTNMVWNXUHo3RlZGd2NySExWeGxUa3F4M3E2UTlK?=
 =?utf-8?B?c3ZvRHRFL2taUkM4REtGdUJha0c5U1Z0VzlYb3N0bnNPRXJEUEU4L2xjS2g4?=
 =?utf-8?B?OENPWjBxSlFaM0J3a2dRUlhmNEFKdXF0RU5QZnJpcUllaElmM0tKYy96SGxp?=
 =?utf-8?B?L1U1bG1rK2M1dFpiM2kwWFdDTzdFNzlMaERHdCs2NnZtUEFpUXlFU3o5SUpJ?=
 =?utf-8?B?WkJiZG9lOFZETm1TdjlJRytpVy8xZzZwVi8weW9XemJIczZoMkZ1VkhWVlQv?=
 =?utf-8?B?VnpmZThWeVlqM2tnUEtQWG5OeDE2T2FiSk9rYnhkRkJzQjkycHVPWHNKdWxR?=
 =?utf-8?B?SDFoQUJIejdlazR2L0E2Vkd3RmRrVzhlVnpNQkdUQmpKcTgwT2xhdHc2aTMx?=
 =?utf-8?B?M3pHTmI0TG83WlhRV3d2Uzd5VFR5R2Q0OGJkMXUyeDZOM1lOQ29SbGtwSnRt?=
 =?utf-8?Q?+jufYmdq7jw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHJNNlRpZWdUdkFhdU94VzlhRkx6LzIwajZ4RnNTWWEwMjJ1clp5bkZ0M2pO?=
 =?utf-8?B?dUl3TUhvSDVWWXIxT3BJRm9QZFBDaUkvbkxDMmFsVkFBM1dvRDJCaUhaKzFD?=
 =?utf-8?B?Q2NzUGhsZXFrQlIzV0ZTS1JlbUhxK3AxU1daV0dIOUk2N1daK2E3dW1YNTN6?=
 =?utf-8?B?V09jTnFROUtjc0FoR2NiS21UbC9kMTFzcVltSm5TS1RLbDF1MUdSM20xdC9O?=
 =?utf-8?B?Qy81VVMzbXNwRFhkdU1WenVmQ0VQVnF0QW94b3M2LyswQk1pY1pCVjdpeFpz?=
 =?utf-8?B?clJlOFpjQlhJSiszZUZWUFBDM1VyVnZiVzdQKzZWbkdNR1NFT09TWk9BWHha?=
 =?utf-8?B?MUZOS3U4SlVMQ2lFanFPRGc1T0VnN1dRNVE1WXVyTGpXUmhlY3E3UVg4cXlH?=
 =?utf-8?B?MmRvOVRnZ2ZjVW9BMS8rejAvUzZWSWwzYi9LenVpaE1HdGlmd0d0Q0lSV04x?=
 =?utf-8?B?dnJrMXZtVGZHYlNuRjlRaGdTYXA5ZlZVSGMxMVVYRjRBV21qU0JWYnIyNjkz?=
 =?utf-8?B?QUt6clF3UG9pdzJHaUN2cEJ1YUthejduZ1NsVVdNNWVqVnY4K2lVeGgrL1pC?=
 =?utf-8?B?MDArYkVWcG9LQXpBNk1RaEVZZWN3YzZzMFNMYnljcVJXekJxMmZjbmtJQUJE?=
 =?utf-8?B?Tkp3UG84WkZPL2hzL3ZlMlVFeFQ2N1hxY3VwTWpmK24yaUxwU2JRamZjMnZU?=
 =?utf-8?B?RUVtdS9oOElvSzBuNUJQTUgvOFVmUGozOXBwbGF0SnQvUDJOWHdIUjVsUHh4?=
 =?utf-8?B?S1pEZy9RUURwOUJYT1BrTmk3YlBYRXBqQ2VGTmszemFRVUFiRDJyUHZmY1c2?=
 =?utf-8?B?RzBKZGFEZGg1cUNlTlgwL3J1UkRIdGZ4RWNQY01pZ3BIR0lnOE9tbHN6VkVR?=
 =?utf-8?B?cVdRQXJsN2lGQ2pSdUg3dWNUckRjeElZcXlGc3ROY1Q0ZTdjaTNJZWZ5NTRs?=
 =?utf-8?B?NTZNSDE4YW1pc3dqNGdycjRvc0lXOW1jTGltYkVuemEwUElWNTVOQzlEOWRS?=
 =?utf-8?B?R0VyNHUrL0hVMVo4K0l1VFN2ZnhLS2ljZjJOZTlMUGF6WkFzMjkzbmNMWkRM?=
 =?utf-8?B?RVVrZlhpdHhGMUxMaGovcTMxUWNReldtUUQ3S1hoY3hlUng1dkpaRDEweGxw?=
 =?utf-8?B?OTZuTmVDay9KT25YcStQUmJPUmM1OTNPR0RpQUFkTTRQNTVCMzUrNFpPaFpo?=
 =?utf-8?B?UzVGUUNvcGJMYXU5T1lQZXU4c3NVck9mQnk3c0NtMTRvUUt6dFBGQUNMSHhY?=
 =?utf-8?B?S21WTGlFZ3VpalUxeWR1RVhKT2FGYWltU1BPMVowdVpYSU9kRmhPc1lpeWtn?=
 =?utf-8?B?MzBKUXlWN3dka3R5THB6Um5aZS9tcEY3Vk9qSmgrU1ZXcUFNY256dWdiRlN3?=
 =?utf-8?B?OWt3bHJOMllFSFZkcGVGNk53OTVWVStkc3dQZ2xIcS9xd1ZwQ25SRmUvL0RT?=
 =?utf-8?B?UlZKU3RMd2NPanhVNis5cERueEFWd2FBTkkrYVRFcFd5aUFxRHFEa2x3bDRz?=
 =?utf-8?B?SGZCTUJRSTJqSytoTzhjdmRnS3F3UG44bkxsRFo3cE5KOW5YTndTTFJmUkZ5?=
 =?utf-8?B?K3QwRW93ZHVHMG80UGNJeEdodFRlbmtvUlRHVGhIYkFZcFRzc3RsdnQxVWJ6?=
 =?utf-8?B?N3RYdTdDblhrSERpendEcmovYlhnc3dqdUxPbUpNNGU5Mk5scGhsUXNaL0RC?=
 =?utf-8?B?b1dtbGVGODhWL1FMVFZKdjlOOUxuSnZNdWN0MkFMRmxPSi9FY1pyZUVNTEZm?=
 =?utf-8?B?MHA3S1dIa0ZRMW5SSVhySXppc2xrY3NaQU8wQUNiN1FQczRlbSttQmorbXRh?=
 =?utf-8?B?OG1WMXdYd1hKclJuVW1Kc3A3SXN5YUQydFFqREh5cmR4RTY0V292NlM2Qjdy?=
 =?utf-8?B?cm9kMXdHK21maTQ2aGpmcEluNlRrMVFzUWdnV1BJYTBTK3F1SFQ5OWY5Z1ho?=
 =?utf-8?B?Tm01MzA4Y3YyckFmUG0rREJha1NodDJxSTRkRWhhdU9zbUJLSHJPWTkxWGd3?=
 =?utf-8?B?UDNwU1d6S1BWSTVmQU8zeXh0a2F0UE9qS08zVVdJNFo5Vi91bGlkN3hubE9k?=
 =?utf-8?B?OUtiTjNJMEQ4NnpNVzV1UTZqRU5QWkQ2NTQwakRsaWZCaUxKTVozMjJPSTd3?=
 =?utf-8?Q?H+Sk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a29784-1155-41b3-a75d-08ddd5ecf638
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 19:59:47.8505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqOim4BnNHfU+jnA5iR1p9X3ZdvRBD9kRGfluSZ/HdpB3Xtlwue1O/4YXxU2W8cU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669

Hi Reinette,

On 7/30/25 14:59, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/25/25 11:29 AM, Babu Moger wrote:
>> When supported, "mbm_event" counter assignment mode allows users to assign
>> a hardware counter to an RMID, event pair and monitor the bandwidth usage
>> as long as it is assigned. The hardware continues to track the assigned
>> counter until it is explicitly unassigned by the user.
>>
>> Introduce the architecture calls resctrl_arch_cntr_read() and
>> resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
>> mode is supported. Function names are chosen to match existing
> 
> (apologies if I gave you the text ... trying to polish with more focus on
> imperative tone now)
> "Function names are chosen to match" -> "Function names match"?

Looks good.

> 
>> resctrl_arch_rmid_read() and resctrl_arch_reset_rmid().
>>
>> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  include/linux/resctrl.h | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 50e38445183a..4d37827121a6 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -613,6 +613,44 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>>  			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
>>  			      u32 cntr_id, bool assign);
>>  
>> +/**
>> + * resctrl_arch_cntr_read() - Read the event data corresponding to the counter ID
>> + *			      assigned to the RMID, event pair for this resource
>> + *			      and domain.
>> + * @r:			Resource that the counter should be read from.
>> + * @d:			Domain that the counter should be read from.
>> + * @closid:		CLOSID that matches the RMID.
>> + * @rmid:		RMID used for counter ID assignment.
> 
> Can this be more specific, for example:
> 			The RMID to which @cntr_id is assigned.

Sure.

> 
>> + * @cntr_id:		The counter ID whose event data should be read. Valid when
>> + *			"mbm_event" mode is enabled and @eventid is MBM event.
> 
> Would the counter ID not always be valid? Specifically,  resctrl_arch_cntr_read() is
> _only_ called when "mbm_event" mode is enabled and @eventid is _always_
> an MBM event, no? If you agree, the @cntr_id description can be something like below
> with the calling context details moved to general function description:
> 
> 	 @cntr_id: The counter to read.

Yes. that is fine.

> 
>> + * @eventid:		eventid used for counter ID assignment, such as
>> + *			QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.
> 
> The "@eventid is an MBM event" can move here? For example:
> 			The MBM event to which @cntr_id is assigned.	

Sure.
		
> 
>> + * @val:		Result of the counter read in bytes.
>> + *
> 
> It looks to me as though some of the @cntr_id text could move to be the
> function description. The description can also be expanded to include where this
> will be called from. For example, 
> 
> 	Called on a CPU that belongs to domain @d when "mbm_event" mode is enabled.
> 	Called from a non-migrateable process context via smp_call_on_cpu() unless
> 	all CPUs are nohz_full, in which case it is called via IPI (smp_call_function_any()).
> 	
> The goal is to make information specific. Please feel free to improve.

Looks good.

> 
>> + * Return:
>> + * 0 on success, or -EIO, -EINVAL etc on error.
>> + */
>> +int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			   u32 closid, u32 rmid, int cntr_id,
>> +			   enum resctrl_event_id eventid, u64 *val);
>> +
>> +/**
>> + * resctrl_arch_reset_cntr() - Reset any private state associated with counter ID.
>> + * @r:		The domain's resource.
>> + * @d:		The counter ID's domain.
>> + * @closid:	CLOSID that matches the RMID.
>> + * @rmid:	RMID used for counter ID assignment.
>> + * @cntr_id:	The counter ID whose event data should be reset. Valid when
>> + *		"mbm_event" mode is enabled and @eventid is MBM event.
>> + * @eventid:	eventid used for counter ID assignment, such as
>> + *		QOS_L3_MBM_TOTAL_EVENT_ID or QOS_L3_MBM_LOCAL_EVENT_ID.
> 
> Above should similarly be specific.
> 

Sure.

>> + *
>> + * This can be called from any CPU.
>> + */
>> +void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     u32 closid, u32 rmid, int cntr_id,
>> +			     enum resctrl_event_id eventid);
>> +
>>  extern unsigned int resctrl_rmid_realloc_threshold;
>>  extern unsigned int resctrl_rmid_realloc_limit;
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger


