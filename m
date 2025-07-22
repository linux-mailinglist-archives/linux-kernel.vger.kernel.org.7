Return-Path: <linux-kernel+bounces-741369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC321B0E34B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9561C80B25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B4C27F4D4;
	Tue, 22 Jul 2025 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Kvivprfj"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B682E36FD;
	Tue, 22 Jul 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753208153; cv=fail; b=bRXmHajSm9zpKb56Yp8MLvkZYmlsJ/q7BuuJ4CfAbhgT66ZTkf8FrivEgcPi3U4y058dy+xHPGWXMU9LTfb+gOpWmo/QnaSwSoT24sBRQXuPGJaxpT3jK47l6SupBjvf/bZJuqEjcnR7L+y94ma+AFndTb6uYWWPDftvtnDaN/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753208153; c=relaxed/simple;
	bh=0uAfvEvCzKt+gHrYP17EcT58FUjvlyxK+CQo44Zfqh8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMozOTZIK1h/hzZawAsDpTZBTHDFCf+jLx4pnrYkDMEprV4QHHpI+U0BSsCj739fXPdvfsP8VkHy5dr/zVzQY1nq3VntFtu4lAGYTUKBWZepW2aHv7ZUi5l2pDDkzaIcz+oMd2xvpFvn1c6mGxxDY6EJ8flTPflmBzcVKQCvASs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Kvivprfj; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D13Yf0JvTWgFxek6N9pXJ44e0ksPmQBKmjBiT1WsAnjNxrD90BZFudRiZvcpC6z7zknm0HkFYo8c2p9FqJ5l3LJpeQVRCLv6ed0ekOhOiwWPenvh8GXGdUn7v+cDbxgD3UwNC7YoS8KapqxESLcdUhDCa8gySCeyu2KEPpEtLus3dLkMlTv345ZCwp+gNZqsSEGlUD0dGxHdkdqGn9QPsYVwktTOgJE7vZGZAsIQGqOdPdI8sBGLtuesygLptH+hw2r5q1svup7M3bTpy68A8z3bt8aLSrRlDxWgkg6oxMWf74LsPc7ZWeq03IFQ/OPH4UPf6J3PN0ThH1EQDR4i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyNnBv2yCEs1jRkotO1UvbUkblIGQkIcwZr9Q9nsOEM=;
 b=UgPXCdWjGtgK3pJfVYdQP6Q17ksSAJ0hskbXYPCVfxWdto8oG5EpWq15qbRPJR37oZ7xp4SJM93S0GS5qWeEqFJsC1VYdfrAd4rviWdt3cpGg3kbqMxJMYgsRiXGKD8fk7AT3UvZWyS4qZotueQSIUs25depP39Gkcru/13A+1M4osG2Yq0xdmiTYmi17m0pNG4ZOu0Xkv39vwtNT9o9cm/jS8ZeWN/iJgnB8/9f86/Ad312DCYiGWtM4v8YSGH08jY53wy1v9Ux+EzD3TcFEhlKrv+OXT1MRfi1yQvil8kowVV/pv/lU/Z9b/UayM+nR16cbMow0cg3x0fAcr8ZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyNnBv2yCEs1jRkotO1UvbUkblIGQkIcwZr9Q9nsOEM=;
 b=Kvivprfj0BoNTnNQ25Bf+qnzQCJxFnpChlgCbGzlA7HYtwzX6Z5rrMCgWtkw/vDVj6HAy90aaXhOW2PTpNBNkqjZ9L/J4h/V1TYIe9rAIWqpWrASUPWSzH2KOnC2MkiBbBEYLBtDhHDnFoThQsBsCMyE/3gsyqOLS3fm++3ahlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 18:15:48 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 18:15:46 +0000
Message-ID: <1a7e2a89-4006-4180-88c6-aa7cad76fba1@amd.com>
Date: Tue, 22 Jul 2025 13:15:42 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 24/34] fs/resctrl: Report 'Unassigned' for MBM events
 in mbm_event mode
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
References: <cover.1752013061.git.babu.moger@amd.com>
 <296c435e9bf63fc5031114cced00fbb4837ad327.1752013061.git.babu.moger@amd.com>
 <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <4b5eef45-9110-47f7-8e1b-a59028d66c52@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0107.namprd12.prod.outlook.com
 (2603:10b6:802:21::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faa23a9-e71d-4be8-e2b2-08ddc94bc7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjhZc3gwMHJzNnNCT2M3dU01VS9EUGNML1lGall0Y1Q1SDF2S2kySDV1UW9p?=
 =?utf-8?B?OTN3N0ZTdEsrd2F0MURIT0hlVlhhTkNRdUlZTnhoV0hsMUI3YU0wL1hhdjVk?=
 =?utf-8?B?Z0duZXdydDdhWWR2OUFNMEJTTitWWWxSOCs5WjdKc1pVcjZQRHhtVzc2bk1n?=
 =?utf-8?B?TldUTXQrbmJQYnFxWWt5VDNtclVXT3loeWtkU3NGd2RaUW11T1FNdHlOK2FO?=
 =?utf-8?B?dnNXSktEMXFnK0JjSEFZOThHMjcwc2tXM25TVnMxcEJrSVF5bjUwNE02Umds?=
 =?utf-8?B?LzJZckRqUkxVbXNaVUUrTm0zbHBvQUhrWGxYM3pIU2U1b1ZBUjRTT2NHZUJU?=
 =?utf-8?B?TlFtbFliQW1FUWwrbHIyS0RucFdHOEJpdHhRYUlUdEY4a2lEMW1oUG5tZ3pm?=
 =?utf-8?B?d29YcVI2NW5TdllCMytZbzBXYnp0TVV0NVc0R2NWNWJsWHErOUpjd0hqTExn?=
 =?utf-8?B?cFk2L0VCQTg3Si9OczBYWkpYamZPSHBMSTIvb29EOEZBREw5TTh5dnorT1V0?=
 =?utf-8?B?VEd4V3hEU1RQOHZtMWhxS1FyMXg0WU1qN2NVUUhoVndvblRlQ1M5Y25leEcx?=
 =?utf-8?B?T0I5dThTYzFWaFdwcEgxMzFWS0MzeTlDOWtCalVUQ3R4elAybFNrblNVS2li?=
 =?utf-8?B?Uyt2MmRHSlFJdytUb0txK29VYXdIZmt1eXpCZ0lSRzBmVFFqWjhJRlk3WXJw?=
 =?utf-8?B?T1VGdWQzb1RaQ09Vc0piVzBTcUFTcUxXSUZsWGI4MG56NXVDTnBGUlo1ZXVG?=
 =?utf-8?B?THhGZllRaVNsYnZ5SVRodkh6UEcyWXUrRTNjY1BEejU3THgvQW9jMFJrbGZa?=
 =?utf-8?B?ZlZ4Y21VUjdrS0xCZ0dHUmZ5TGZHUTYvazN0dkNmT0F0Q2hvUmdHSUN0c3V4?=
 =?utf-8?B?blE5VnQ3cW1qbk1RVW9MWkV5WEo5UUdyc0xoSE5wWDRkem12ZVNpdXlIS0Ro?=
 =?utf-8?B?OXFEYW52ZkM4bVlNVmx4RGJBdTljaTgxdjVwQWh5cXlkVElpZHhCbEVDK3kv?=
 =?utf-8?B?WHZ1N2QwM3NoeDZCbkFNWHJ0bWhTRWVFYXFIYW1GVlVBc0pPMlA0ZVQzcWMw?=
 =?utf-8?B?K2Z4ZXFWTVZWaUxydnh6QUsrcUNvWWNNdmM4TC9LT2MwM3JmMEpZTU5NR2JF?=
 =?utf-8?B?M09ONE83RWJuODZQYkJEL0hpSHFxLzVkZ2ZydnFJb09UN1Q5bnhhRTIrS2du?=
 =?utf-8?B?dHcvUVVpYlRiWG1aTzE4Si9HYjhoWHhPaUpEOXJxZUVzVzJoV3IzZmNGZml3?=
 =?utf-8?B?UGsxb0s4TnQvNzRRajluU0xuV3FPT1pCQ2tWRW5KalJxN25PTHZGWlVkVFNF?=
 =?utf-8?B?TTJadFFlZzMvY1RmSVNzVlR0NWlmTURiNHpNN1ZGZ0xYMzg2a1daNGJmdkdF?=
 =?utf-8?B?Nzk1cXVjK2MraFZOZE81Qk1taENjTGRrSlpDeVk2NlByMjZtWDhzS2l0ZEtV?=
 =?utf-8?B?aWJGRzRKU1lsWEpmcldXeU5XZ0hJTDR4cjlrWHNpTERrUk5NUXhtWkdFNGNq?=
 =?utf-8?B?TU4vdHNMZjJPQS85akRYdVAzblBWYVR6VE9Lbk1SVlp4bFkrZlBzNlpUNlBn?=
 =?utf-8?B?NVoyby9FdzArRmJGLzhjdkJuZ0VZdjNTa0g4dWxxclhRSmFmTFJuNnBnd0JL?=
 =?utf-8?B?WThVcjQ0Sm51RTRINHMvcGtabDFkc2dLVGlwNy9pSUJCazBreGpFTUppRUp6?=
 =?utf-8?B?dmxHK2ozSnN1b3VDOXFOM1FFQTB2RE5Gd29MOS9tK3I3aExEWkRSMEc2UnQ3?=
 =?utf-8?B?RFpIZGxYQThiNzhUTjJWM1o3bzBaaTUrVVNqcE1ISHU4WVhEbytZdWErK0d3?=
 =?utf-8?B?UjNyN3V5T0RFRlA2bUczcVYrTG9GY3U1N3RLL2d2Q2xDeFd5S21hVW0rdDZy?=
 =?utf-8?B?aS82b0ZLNEs5WXBEQUVFenVVNkF5NjBqUFZEWDdBbXFFRjNwOXY4V3VLMVNh?=
 =?utf-8?Q?6nyOgNabH8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVQUFViMWM3YnBhcnhtbm5wS3JPU2JuR0ZPclUwMElyZmI2N1dlbm55TE9y?=
 =?utf-8?B?L1lUMk16SCs3dEJtakpyTlk0MGNkQTFqeVVpS0t5WHBHcC9aVGtCMjliVnNC?=
 =?utf-8?B?T1VDSyttUG5peHZwUFJaVll4UWtSWTZZWmQwN2oyWEFZV29JTmV4RTEwZnJW?=
 =?utf-8?B?SXpqU2pycTloU2p3aEJ3N0syWG1jQjdOTlJkMG9CVkpHTDQ2Z0Z3cVh1cFla?=
 =?utf-8?B?YU9vTmJyYmZVVUo2UC8xS3RhSk9MaXAwNER1a2M3VCtmckZ1SkN0RWluODdZ?=
 =?utf-8?B?ejJ6TXZiRy9WZSt0eHhRS1Foa1hDOTdUZGFWVHZzTDlYSk1UZWpWano3NUdP?=
 =?utf-8?B?MHhIYmNwa0U1UU1TVlQ3d2x2ck5uQk54UDVpV0EzZW8rRXdHMGdIZGN5VnNT?=
 =?utf-8?B?cTBpaEhVQ1FnWTI0Y0hOcnQ2RUpYSkZISmx5NkxlR2FaMERrWjZFSXlHVnhl?=
 =?utf-8?B?UkVOMXowQ3Bxc1BGeUZ0c0dJN0VqZThLTnhEMUZJSTdUTzhGSkpLdHphbVZM?=
 =?utf-8?B?N2NFYW1sd1dBUWFpQWtLdCtvTjliZ2craXpFMk9mQVNkZWlRT09iOUgvK3dy?=
 =?utf-8?B?bE1mWmsrQmxlMUpxMWlaZlBVRWVKUE5yM0UyUlA3Nk5kVkxac0pmWW9nS1lx?=
 =?utf-8?B?aFZuTFpCZFAxeW9OVnJLeS9NSmprSmdoOEg4MjFobmN4ZXdHWDZIdVY4eG1h?=
 =?utf-8?B?TVMrRXBybktHZG45QVAyYzdQWlVGY3RrdUJRelVGbWh4eW5Xc0twSVgvL2Jw?=
 =?utf-8?B?K1BhMndKL3l6Y0p1WWR0SFBqb3VzUWNKa3ZudWFwSG1aZUh1YURGdDZQZUtL?=
 =?utf-8?B?VVlxUXJUVjlVWkxKSVRwdnA5bElPMXFENEZjdWpkUGVqV0FRNFd2dXN6N0kz?=
 =?utf-8?B?aSs5U3Y0UWk4VG9YWkVCNlAycTJvU0hUdmREaXMyUXFhc1BISERDYnNBTHlR?=
 =?utf-8?B?eHo2VThqZFA4N20yTnVkcmJHZFhQL0l1RXZ0UTNOanIvQ0JOcG5tUEIybllZ?=
 =?utf-8?B?Uk5aRXhRL0pGc1FnZGJxYlN2OFBPeTE1TGx4cjZkYVdRRmNGZ210cE9QNGlC?=
 =?utf-8?B?VDVVT2JKSHdkS1Y1cTFqZlJNS0o2OXJyUjRzbUZtT1pTcytmWGNYa1hvclE3?=
 =?utf-8?B?VENwYzdKVmkwb2E5U3JYYjNpM2VYS2oyQTMxYmlvOGNudk9TYmZtZW11d0pl?=
 =?utf-8?B?L0haZzg0WTV3MWZPTVJld1ozS3NrZkttNzFxd1ZnWXVBTnh2WEtQZ1ZMb3JB?=
 =?utf-8?B?ZGRqM0NObnRiclpsZDlLWTNjZ0hrMDBVOHhuWGc0Uk0rVjdVL3FMWjRXRFhX?=
 =?utf-8?B?SkIxSWs3b3FzbHRGeUlreUh0c2RpTnlZMjZNdXUxSFNhVlpBc3hac1Avbnkr?=
 =?utf-8?B?UjY2OGFtczN3dURiaFNxSTZSYlVicGlFZ1FVM3hDL2RYL1BudjhOMnhTWnpn?=
 =?utf-8?B?RGxSa2VzT1c0Uzc4Y25NVlZ6MzdDblN4dm1HaXZvQVRyQnBDREhzRytqaE5R?=
 =?utf-8?B?KzNyTDNTTmdCWGgra1RPSWpjWmZNT2NXdGd0NVlLOHNWZU1XcGtqbklEYnAx?=
 =?utf-8?B?VHB3cWpySlRTTGlhcHhXUjNKVzZCdDRRbTVpQS9yaUNSZFZFbHNJRnVNeGMr?=
 =?utf-8?B?RGYvbzF2RHBjT2VxTEJOTzBZWW81Wlc4S2pHejI0UlprcS8wazFqYWgzVndD?=
 =?utf-8?B?c3hlZW9qYUY4N2srK0hHNVd2NllsOWpnSHEwTndLV3djRyt2QXNPMmZaM29v?=
 =?utf-8?B?VDRNSi85cnFWVTk3ZzVWTzdZWW9HcUNzWlB6M1hKazRWVVVHWjFsQ1lsU0pp?=
 =?utf-8?B?bVlWS0Z0WnpBUDUwTU94MUpOMXpCajYvSWFDT2x1K1JWc2gzS1RsZFZ5STJB?=
 =?utf-8?B?LzJPaDFsRTE2ODNlcm85ZU4wTlVrUGtqS1c5NTk5OENrdXVwcFZVd3VWVjM5?=
 =?utf-8?B?R0VHeHc0K01TNmg5K1VnZjErclVxZ09qUURDN0svQUNNa2UwMUt2aTNNZ1NP?=
 =?utf-8?B?RkJKWTlnN3dyM00rQTJtMkw3VlI0TzdRcTZXQ2Vlcmt4NDh5V1l6RXNkSWtM?=
 =?utf-8?B?ZzVVem5aNERwcCt3cTRKTXZpVUpNY0xMSEdBblVXUjdtbXM5cWNkdVlpSVJx?=
 =?utf-8?Q?yXBg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faa23a9-e71d-4be8-e2b2-08ddc94bc7a2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 18:15:46.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nim+jEm7Js20s5m6yhvYV5S86hwH/INL7OwhjS6w4eRTDok6n2VJAMUdDu2z/5R0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937

Hi Reinette,

On 7/17/25 22:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> When the "mbm_event" counter assignment mode is enabled, a hardware counter
>> must be assigned to read the event.
>>
>> Report 'Unassigned' in case the user attempts to read the event without
>> assigning a hardware counter.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> 
> 
>> ---
>>  Documentation/filesystems/resctrl.rst | 8 ++++++++
>>  fs/resctrl/ctrlmondata.c              | 6 ++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 446736dbd97f..4f5eb5bbd4b5 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -434,6 +434,14 @@ When monitoring is enabled all MON groups will also contain:
>>  	for the L3 cache they occupy). These are named "mon_sub_L3_YY"
>>  	where "YY" is the node number.
>>  
>> +	The "mbm_event" counter assignment mode offers "num_mbm_cntrs" number of
>> +	counters and allows users to assign counters to mon_hw_id, event pairs
>> +	enabling bandwidth monitoring for as long as the counter remains assigned.
>> +	The hardware will continue tracking the assigned counter until the user
>> +	manually unassigns it, ensuring that event data is not reset during this
>> +	period. An MBM event returns 'Unassigned' when the event does not have
>> +	a hardware counter assigned.
> 
> Most of this duplicates the "mbm_event" description added in patch #10. It should just
> be sufficient to mention that this applies to "mbm_event" counter assignment mode
> and then user can look up the main description in the doc.
> 
> The last sentence is related to this section and need an update to reflect behavior
> when a CTRL_MON event is read and it or some of the MON groups do not have
> counters assigned. The paragraph that precedes this does describe how the sum
> works so this can tie into that.

Just added following text.

When the 'mbm_event' counter assignment mode is enabled, reading
an MBM event returns 'Unassigned' if no hardware counter is assigned
to it. For CTRL_MON groups, 'Unassigned' is returned if none of the
events in the CTRL_MON group or its associated MON groups have assigned
counters.


> 
>> +
>>  "mon_hw_id":
>>  	Available only with debug option. The identifier used by hardware
>>  	for the monitor group. On x86 this is the RMID.
>> diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
>> index ce766b2cdfc1..45351673e4ee 100644
>> --- a/fs/resctrl/ctrlmondata.c
>> +++ b/fs/resctrl/ctrlmondata.c
>> @@ -661,10 +661,16 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>>  
>>  checkresult:
>>  
>> +	/*
>> +	 * -ENOENT is a special case, set only when "mbm_event" counter assignment
>> +	 * mode is enabled and no counter has been assigned.
>> +	 */
>>  	if (rr.err == -EIO)
>>  		seq_puts(m, "Error\n");
>>  	else if (rr.err == -EINVAL)
>>  		seq_puts(m, "Unavailable\n");
>> +	else if (rr.err == -ENOENT)
>> +		seq_puts(m, "Unassigned\n");
>>  	else
>>  		seq_printf(m, "%llu\n", rr.val);
>>  
> 
> As mentioned in previous patch, please squash with previous patch.
> 
Sure.

-- 
Thanks
Babu Moger

