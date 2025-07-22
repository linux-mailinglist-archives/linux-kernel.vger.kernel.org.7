Return-Path: <linux-kernel+bounces-741622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85661B0E6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AC2547F18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116ED2882D2;
	Tue, 22 Jul 2025 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J/Az7eMi"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65C4C92;
	Tue, 22 Jul 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224957; cv=fail; b=FSLEuER/gX0f5uOP18Y4Mb80VrEu9grq2ZlD2vSLeRnZ37NyYbKjocM7RM/2qfiLTP+88CrogEDZmGf58UcPhav0v6G8stHTlkwb03yNHyV0wEIfafqW16/Z9vWitlEvjg0FykMK4DqdsAo3Zydkq8CfnpGQxFMmPvKlyXiuoNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224957; c=relaxed/simple;
	bh=GD3X8DkJVjskV++f7f3KA0MiNlVuJ+9bp43PfA7fZWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=udbt9JnFSCaG2kfqT50ReGPY7NT9MxNx1eNilXtyPIRKdIJUuciPqODpQyOLHwjkx7pPha8fAT9MDWC6Jd+XVtEBwSRNd51gnLnt8uH1Ozfces8t5xDPPPIFRdZd9kXhCVHhQFAytAO0YGj21NG9B8kkayixe4XhZ2x5iUuTZdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J/Az7eMi; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tascuFkIW8xkBciy17j7T6zDtDcSZtfggN+rR9qfILTNFGLORw/NE/fRQkRoqPm2B9QE3MZWQb0/bmPzd8EoXnEVt++10NdOvsNumyhQRN/MzhjsM2QigvsGAp5PHzivTvq5LZIwivXGaItb4Z+yojeXK/2hmQV6WOGVXEYAPpqHuwPBghFprxy/oy+tDLXK1huu9NsdbGBW4C1PxwcGUmOIio2gPfrzXyiW8qBfdYGNYEOAxFEf1VnlL4qZ9N8c4subP2vHfUiGJQSCoObZDotcBb6EQgN3bzVq1bimV0PPUat7Dss8uWHZ1V6ZmwS81dTjFfll5PZvCFr7RO99TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byoNO3oBMZF/DpwNI9RBVrEsxJbaxFeWKTXfWyYkPDs=;
 b=RIyShIAfmB7W2iU34OsEF+qWnbqM9bEOJmtSzNZatN2Au7gf4n7XHFZwlRKvqfCSZWnYNz9eOvrLmU8vCERV6OP4ZZj54ekFIWe+2NDDiX4gdiKa7RpLkc2yLKVO+x8JxuGbB6xMpODxuKSVoDqctDUsM5d0I+JksC+R/5zCHwuval3ZO03EGPKyO6T6cY0Ka2JBufdh8uGlFBdtAj/h8HcerJ6tWSm31OJ7VrZClctlp6l4EMThN1IiZjFOUwwNdbxZ/V+Tc6m0T4RaNnF1ySfrYsaYfQh5oUdSNq9gwkUF4AZ7sT6vSQa/sCZdYSlitH3gxUmTNCAcYqTW9goSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byoNO3oBMZF/DpwNI9RBVrEsxJbaxFeWKTXfWyYkPDs=;
 b=J/Az7eMiQ2UWY84z3nmHWMONr+4fnE3acJDeiciluhTfBYa+4kHHtSLWyWr2gHm7l3VVfCNBiM73SACn99qCwDBqSEiXTdfyIAj2tysXxObO7/E0UPpZrgasiPZ06/qj8PjZ8XV+NvHyNJAb9EYFjl0uPuqx2s0RKJs5j7sL3pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 22:55:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 22:55:50 +0000
Message-ID: <4fa74aeb-7078-48fa-8bcc-c83389aaf73b@amd.com>
Date: Tue, 22 Jul 2025 17:55:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 27/34] fs/resctrl: Provide interface to update the
 event configurations
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, tony.luck@intel.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <8213746e89e4813e397043325520353ada56651d.1752013061.git.babu.moger@amd.com>
 <e3a6e460-b7d8-4164-ad0d-894e78c323d1@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <e3a6e460-b7d8-4164-ad0d-894e78c323d1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:805:66::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 0824d887-734d-4e54-f211-08ddc972e798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R00yT2Jhd0dQcDNqWkhYdXdvNGRsVHp5d21LRVJGVFpkeEhYRk5LeExURkp6?=
 =?utf-8?B?TkZjQU5yeGc0b3dLODhZWmxvbjVqa3lxcW5aNlhLT2F3ekRaQzF1QzI3UFlF?=
 =?utf-8?B?Y1lmZUw4L0Y1YUVhQjN0ZFpHUHM4MWlvRDRPZ2N2ZzNTMGhSSTEwSWpSTDk4?=
 =?utf-8?B?d3ZEM2g1cU1wT1I1dUZRTWIzaC9vdldSUTUwQ2xaK0FJcEJEVG54K1RXUzFD?=
 =?utf-8?B?YU1pdjRURHVKb2JWQUJRVWJkT1VSKzdRUEM1SWlCRGtmUG9tTFhtUWREWW1a?=
 =?utf-8?B?WWRGbHZZNXlrMU5WQkdEU0pKNE44UGhxM2p1S3U3R2cvMlozeDdkaVZjR3Ix?=
 =?utf-8?B?aFkwbnMvdVpIeG5vT3FOb3pSQ1VWOXN0OFZ5SkpqVjQwRDZHdXFTa0dBcis1?=
 =?utf-8?B?bkxuNTlaeWMzUHZOTW1TTzF6MkpUcWVSUFpFNUdxRXJZc1BDZFZIbXMveVdH?=
 =?utf-8?B?ZS9oR1UyaW5qUytIM3owRFdOMUtDNlhuajVGbmhGZkJ6UXROUFh6Zll4SnlK?=
 =?utf-8?B?YXNhM0YwdGxiVUs4Z3RLcTZPZk5ZQ3doZEVjU1hYNEloMUsrU3AwZDROU1hF?=
 =?utf-8?B?NTFKUlRNL1I3TGwrZlZpZldWVlcraGZxZDNNYnJudTNOUHpEMllpaS9nRC9K?=
 =?utf-8?B?bzNPTTNXcndKZGpDSG9vMHdFTHRCZnc4b3FaU1pHeERxaEZrT24xOGF5aTk3?=
 =?utf-8?B?RC9EUVhLT3NOSFpZZ3VCT3NqS2dVSHhKdzdKa3p6QlRJNTNYUmZCdXB6M202?=
 =?utf-8?B?TTNKdzlGdGZHemJWc0pIb21DU28vQ2NJSHVqcnZXUzRoYmdOcmRQRTVzOTAr?=
 =?utf-8?B?TFZhZFY0c2tDUHpNZVl1Y1RxbnV1dTdsWEtDejlKeUpFVVVYRVNDRTQyK3lo?=
 =?utf-8?B?L1NVaXp3ZDEwU2lTdnVJdDEzMlFlcUVtTFJBSjhZSjlaN1JtcFRZc0FmOGVI?=
 =?utf-8?B?U1RmQzR2NXhkb1Rlc1Rxdy90NVFWT0RWMkRFK0pCMDV6OExiUmJXSFlZMWtm?=
 =?utf-8?B?STNGREhBRzdrblBtVElxcGlIR0JSc1lhbFlGdjV6TWJ4VTlVSDFYeXN4MDVO?=
 =?utf-8?B?bG41WERwMTR1NHhsMXp6eVc3L29BQ3VOQkpIQis0NUpOWTRwV0NPVXI5aGRR?=
 =?utf-8?B?a0ZmKzJkUnFCeXJlVlhjOXNSN29Lclord1h4bDB0MEFlSnBONStiQ3hCKzBI?=
 =?utf-8?B?K29ScEtiOUJtRFFvbm14ZjVBNlNYb09UZ1RMRFk3cGtnR0dtUWNuZ21RRFFo?=
 =?utf-8?B?Yjlid2xvWkNNVkxSTDZ0ME9qbnhkWnB4K21hUFFodmxvdWlEc0RzVjR6Q2d3?=
 =?utf-8?B?U2ZBWUptcDhIcm8zK1MwZGpaKzl3VytUY2hFS3N2RkVGZTg1V2l1dHM5Yi9s?=
 =?utf-8?B?eWdMUE5GWGxYWlUzRk81d2xrdWJuM2ZKMmJMS3NDUnBhVkZ5MnF0ckN3bEk0?=
 =?utf-8?B?TVdHK1ZweEFud285ZGlneEJmWkR4YmZ6TTJsQ1N0ejhOdmt3WG0zQ0M2bUFw?=
 =?utf-8?B?SHZCK2RwZmkyYU9iM2VITXVYaE9WaXdSbWk4cDBDaU5RNHpiRnZraVNJRXFC?=
 =?utf-8?B?c2NEaDgvVjdUMFg4c082N3NiS1BlUTF2UlRjM0l1Ym5mOFJDcnZodFErNDA1?=
 =?utf-8?B?aklWL21YRnZGS2xRTVZsNnJINnIxOElZNjFKeHF2SE05dVhUV3p0R3U4NGZ3?=
 =?utf-8?B?S2xmK0NjQ2dJZUdURGUvUUw4QXhlZGErOVR4VUtrU1V3QXl3Sk1EYVZvK2FP?=
 =?utf-8?B?WHl6SjVSVnErM3kwNFdwUzZaUmFnaC9KWXFrd0V0OER6clRmUjQ3SHdqRFpO?=
 =?utf-8?B?SGk3OUVkb3BpTmFZZVBabWdEZHl1L0F2THc5c3VzSFZLeDJCeTY4dGtIMW0z?=
 =?utf-8?B?WnpPWTJWeEVHT1pMeXMxMzdOb29nQUJBQ2lueWdmeEdhMVJIZ1c4Qm90M3FV?=
 =?utf-8?Q?PsiRaPNtX8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lZdWZIMmxjYWgzYUtWQjFoZFJUcm8yYzAyajUyK09BRDZ0bUlTSy8yYlov?=
 =?utf-8?B?dkhHbk85bnRIZ0lmUmNINGx0cnluZm9TWVBCSVVFdUN4TjRhRXRjK3JIOGtL?=
 =?utf-8?B?NHZncHhxZHVGOFZ2eVVRM2FrcTV5a2laeGQwMVpiUGZpV3IvclFIUXZwSWZy?=
 =?utf-8?B?SHg5UEtoaFM2bEd2TjVMSlRuSVAwcGNOY0hZdStoYlYrdCtxdHlLMDMyaFZP?=
 =?utf-8?B?a0VJeFpGMlNEQWwxREdtOTUyeFVyMXliazlKdVFsbjhxVG5zVzZ2Mjl3allR?=
 =?utf-8?B?bDRmN3NKTThYQUs2VGxYYUJKQzJrdHlKSUcyRFpYUzVQbzdUOWVZUW51cGY2?=
 =?utf-8?B?V3p6UjFrYTRWVllQc0xRcEpRaEhhaTJsZXJyRklUYjVQVlRIbjVvSU1RQVRy?=
 =?utf-8?B?OUk3THg0c0RXSUZEWGYxRDFhL01yM0podldNOWdGVURsY2dEaENiOWNrZlJq?=
 =?utf-8?B?M21CNXg2ekF6alpsdTJjUXppUFd6L2Q4WmxCQW50R3BrbXBVVFpnLzJHcnEv?=
 =?utf-8?B?RnEvcy9ibkNGNG1Va1ppWEd3TnNpWTZwSDNiYWhIdTBkbEtYZjJMUnRKMys3?=
 =?utf-8?B?aVMyMXl2dXdBc25Da01KUXVZTHlLem15ejRrblFlWk52STE1cXN6bzR4TEFy?=
 =?utf-8?B?KzRzaHVMVURHN3RZQjhXTDJZOVNoeUpVaXA1OHVpTVRadGhhT0kySnRHelVU?=
 =?utf-8?B?U0hrS1k5MmxsK3BNRlp0R1ltK1h2Nzk5eGVvcnZrRU9NSVBERDJJY2Zqbm1p?=
 =?utf-8?B?QloyVjFNQnB5dDB6ekdVcUNpZFN3dUpKOGpubUhMQmNySWNmNjhCZnJjY1py?=
 =?utf-8?B?Y2xvZExaZlhGUStST2h2WEVmbmRSY01WbnF5c1oybU5NR3lyNW9JZzRhMDZG?=
 =?utf-8?B?dkIrWkpJZ3Zid0tJbWlwSFJsTmFnNUNZN1IyNHRwMnNVUU5EVEdiYXc0T0w1?=
 =?utf-8?B?dHdQMk1LK0JJTTFzWEZBSXFYbXYzbjEvaTQ3MWxqM1JtRGgxdHNlVFg3djcz?=
 =?utf-8?B?WGl6dmxsREc4ZUs4aTN1aGpLb0Z3Z1l3S3dZVzJhbTN6THJhVXRKUklJVUVx?=
 =?utf-8?B?QVlaM2lwaE5jYlVLbXJRc00xVzhJUVJyL0tNeWRDTjM1SHNUbXR3RDRJWEJa?=
 =?utf-8?B?Q3hZSjlRVk9xNmJldmt1c0hRMkliZ0p6L1ZnMG5BMGxvRzVFZzFCb1FyMzhi?=
 =?utf-8?B?K052RTJ3a0JrTzArNGl3S0sxSTRoRjRWODNFcUN1V080QVNudzd6VC9oTXEw?=
 =?utf-8?B?SllRMm9XTGI0aitEVktxRzRNMGc5aW5HWmdOYmRrc3M0VDlGa2FDNDhZeHZs?=
 =?utf-8?B?UXBuZ3hQNlJpT0hhTUpvbll4NWhlNEZIRDB0Q2JvTWtyZ1RWT2s3YndoUUY0?=
 =?utf-8?B?bEJ4WGFyV3kySkdVUjJJSWNwcGovNnl6b1M3enVKZDdTYi9qR2xSODNqUVJX?=
 =?utf-8?B?UEZJLzFzb2h3L0R0VmJEalBxRUpvUGpkS1NRcG8wdnR3alFDbDI3SEdwV0FP?=
 =?utf-8?B?UmFPQzkzYkthQ1JpSFNjek8yWDBoMWcxWmR3TkxXYnI4SEVhTm1Rd3Y3NXZE?=
 =?utf-8?B?NjAyeGJlaWV6VlBObEtzKzk5WU02YVJ1d0lZZmU5MmZBVFpTNEo3VVAxQ0lP?=
 =?utf-8?B?S3o4YVVMVjQ2REFJckFuU0s5TmE2UkYySTlOMEErR053dEx3bFVrSnpZbEFs?=
 =?utf-8?B?V0tHczFOVlVORmpZeitvN2M4K2JvQkdpM1h6dWpkOEloTTVoZmpXN1dMalFQ?=
 =?utf-8?B?Rkg2eVk4eVA5V2M2OHBGTVF0aXlQRHFsV1JiblRYNVFKa05kejlmL08vZ0Jv?=
 =?utf-8?B?Y2JvdDBtZVkxN1d2WFpuTmd1dUtxS3BPYjd3MXlNOFNnbTV3RXh0MzB0emJ1?=
 =?utf-8?B?MkY0SGdwN1IrSElIRSt1TjJCbU5lREllYWp3SitkT1VrTDErcGpNNHp2cmRF?=
 =?utf-8?B?anQ1MzlMVWIwbXB4dDZpcnpSZUd0OWJEL1RGYklyQ09vbHkwK0lzZ0NNeGZ3?=
 =?utf-8?B?cUVYNHhhYlVmcUFNVGFnRm1HWXNCTGc2SFlDcGtRK293ekpkVTBqN2tacWFG?=
 =?utf-8?B?Y3piMjhtR3lsK1ZKNGhWTDVNa3QyajZDajhtTFkvUTNkQit6b1lPaU8vTWZl?=
 =?utf-8?Q?j/eZQhF9JQmqKLiWQ4A1UNyGy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0824d887-734d-4e54-f211-08ddc972e798
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 22:55:50.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBP973epOSlSoHW9JGsy7Rb1vgyMvFokpHDBHMWcUl8CLE6+1dcURYtSC7xforRq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

Hi Reinette,

On 7/17/2025 10:55 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> When "mbm_event" counter assignment mode is supported, users can modify
>> the event configuration by writing to the 'event_filter' resctrl file.
>> The event configurations for mbm_event mode are located in
>> /sys/fs/resctrl/info/L3_MON/event_configs/.
>>
>> Update the assignments of all CTRL_MON and MON resource groups when the
>> event configuration is modified.
>>
>> Example:
>> $ mount -t resctrl resctrl /sys/fs/resctrl
>>
>> $ cd /sys/fs/resctrl/
>>
>> $ cat info/L3_MON/event_configs/mbm_local_bytes/event_filter
>>    local_reads,local_non_temporal_writes,local_reads_slow_memory
>>
>> $ echo "local_reads,local_non_temporal_writes" >
>>    info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>
>> $ cat info/L3_MON/event_configs/mbm_total_bytes/event_filter
>>    local_reads,local_non_temporal_writes
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>   Documentation/filesystems/resctrl.rst | 12 +++++
>>   fs/resctrl/internal.h                 |  1 +
>>   fs/resctrl/monitor.c                  | 44 ++++++++++++++++
>>   fs/resctrl/rdtgroup.c                 | 74 ++++++++++++++++++++++++++-
>>   4 files changed, 130 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 57fd12f0aeca..06c8c08d0341 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -342,6 +342,18 @@ with the following files:
>>   	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_local_bytes/event_filter
>>   	  local_reads,local_non_temporal_writes,local_reads_slow_memory
>>   
>> +	Modify the event configuration by writing to the "event_filter" file within
>> +	the "event_configs" directory. The read/write "event_filter" file contains the
>> +	configuration of the event that reflects which memory transactions are counted by it.
>> +
>> +	For example::
>> +
>> +	  # echo "local_reads, local_non_temporal_writes" >
>> +	    /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> +
>> +	  # cat /sys/fs/resctrl/info/L3_MON/event_configs/mbm_total_bytes/event_filter
>> +	   local_reads,local_non_temporal_writes
>> +
>>   "max_threshold_occupancy":
>>   		Read/write file provides the largest value (in
>>   		bytes) at which a previously used LLC_occupancy
>> diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
>> index b107874407b2..b42890fd937a 100644
>> --- a/fs/resctrl/internal.h
>> +++ b/fs/resctrl/internal.h
>> @@ -409,6 +409,7 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>>   				  struct mon_evt *mevt);
>>   int mbm_cntr_get(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   		 struct rdtgroup *rdtgrp, enum resctrl_event_id evtid);
>> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt);
>>   
>>   #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
>>   int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>> index 787dce934903..0722e72f6cb1 100644
>> --- a/fs/resctrl/monitor.c
>> +++ b/fs/resctrl/monitor.c
>> @@ -1173,3 +1173,47 @@ void rdtgroup_unassign_cntr_event(struct rdt_mon_domain *d, struct rdtgroup *rdt
>>   		rdtgroup_free_config_cntr(r, d, rdtgrp, mevt->evtid);
>>   	}
>>   }
>> +
>> +/*
>> + * rdtgroup_update_cntr_event - Update the counter assignments for the event
>> + *				in a group.
>> + * @r:		Resource to which update needs to be done.
>> + * @rdtgrp:	Resctrl group.
>> + * @mevt:	MBM monitor event.
> 
> @mevt needs update match actual parameter

Sure.

> 
>> + */
>> +static void rdtgroup_update_cntr_event(struct rdt_resource *r, struct rdtgroup *rdtgrp,
>> +				       enum resctrl_event_id evtid)
>> +{
>> +	struct rdt_mon_domain *d;
>> +	int cntr_id;
>> +
>> +	list_for_each_entry(d, &r->mon_domains, hdr.list) {
>> +		cntr_id = mbm_cntr_get(r, d, rdtgrp, evtid);
>> +		if (cntr_id >= 0)
>> +			resctrl_arch_config_cntr(r, d, evtid, rdtgrp->mon.rmid,
>> +						 rdtgrp->closid, cntr_id, true);
>> +	}
>> +}
>> +
>> +/*
>> + * resctrl_update_cntr_allrdtgrp - Update the counter assignments for the event
>> + *				   for all the groups.
>> + * @r:		Resource to which update needs to be done.
> 
> @r no longer a parameter
> 

Removed it.

>> + * @mevt	MBM Monitor event.
>> + */
>> +void resctrl_update_cntr_allrdtgrp(struct mon_evt *mevt)
>> +{
>> +	struct rdt_resource *r = resctrl_arch_get_resource(mevt->rid);
>> +	struct rdtgroup *prgrp, *crgrp;
>> +
>> +	/*
>> +	 * Find all the groups where the event is assigned and update
>> +	 * the assignment
> 
> "update the assignment" -> "update the configuration of existing assignments" ?
> 

Sure.

>> +	 */
>> +	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>> +		rdtgroup_update_cntr_event(r, prgrp, mevt->evtid);
>> +
>> +		list_for_each_entry(crgrp, &prgrp->mon.crdtgrp_list, mon.crdtgrp_list)
>> +			rdtgroup_update_cntr_event(r, crgrp, mevt->evtid);
>> +	}
>> +}
>> diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
>> index bb28ef7e4600..4889e7556cc7 100644
>> --- a/fs/resctrl/rdtgroup.c
>> +++ b/fs/resctrl/rdtgroup.c
>> @@ -1916,6 +1916,77 @@ static int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq,
>>   	return 0;
>>   }
>>   
>> +static int resctrl_process_configs(char *tok, u32 *val)
> 
> Please move to monitor.c and give more specific name. Perhaps
> resctrl_parse_mem_transactions()? Open to ideas.

Sure.
> 
>> +{
>> +	u32 temp_val = 0;
>> +	char *evt_str;
>> +	bool found;
>> +	int i;
>> +
>> +next_config:
>> +	if (!tok || tok[0] == '\0') {
>> +		*val = temp_val;
>> +		return 0;
>> +	}
>> +
>> +	/* Start processing the strings for each memory transaction type */
>> +	evt_str = strim(strsep(&tok, ","));
>> +	found = false;
>> +	for (i = 0; i < NUM_MBM_TRANSACTIONS; i++) {
>> +		if (!strcmp(mbm_transactions[i].name, evt_str)) {
>> +			temp_val |= mbm_transactions[i].val;
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		rdt_last_cmd_printf("Invalid memory transaction type %s\n", evt_str);
>> +		return -EINVAL;
>> +	}
>> +
>> +	goto next_config;
>> +}
>> +
>> +static ssize_t event_filter_write(struct kernfs_open_file *of, char *buf,
>> +				  size_t nbytes, loff_t off)
>> +{
>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>> +	struct rdt_resource *r;
>> +	u32 evt_cfg = 0;
>> +	int ret = 0;
>> +
>> +	/* Valid input requires a trailing newline */
>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +		return -EINVAL;
>> +
>> +	buf[nbytes - 1] = '\0';
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&rdtgroup_mutex);
>> +
>> +	rdt_last_cmd_clear();
>> +
>> +	r = resctrl_arch_get_resource(mevt->rid);
>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	ret = resctrl_process_configs(buf, &evt_cfg);
>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
>> +		mevt->evt_cfg = evt_cfg;
>> +		resctrl_update_cntr_allrdtgrp(mevt);
>> +	}
>> +
>> +out_unlock:
>> +	mutex_unlock(&rdtgroup_mutex);
>> +	cpus_read_unlock();
>> +
>> +	return ret ?: nbytes;
>> +}
>> +
>>   /* rdtgroup information files for one cache resource. */
>>   static struct rftype res_common_files[] = {
>>   	{
>> @@ -2042,9 +2113,10 @@ static struct rftype res_common_files[] = {
>>   	},
>>   	{
>>   		.name		= "event_filter",
>> -		.mode		= 0444,
>> +		.mode		= 0644,
>>   		.kf_ops		= &rdtgroup_kf_single_ops,
>>   		.seq_show	= event_filter_show,
>> +		.write		= event_filter_write,
>>   	},
>>   	{
>>   		.name		= "mbm_assign_mode",
> 
> Reinette
> 

thanks
Babu

