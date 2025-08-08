Return-Path: <linux-kernel+bounces-760636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9241B1EE09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6D91C27F63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC381E7C2E;
	Fri,  8 Aug 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y3N7mUJX"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556AF10F1;
	Fri,  8 Aug 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675271; cv=fail; b=VQaxFA8g5KNaPgxURPOBDx+pkNykDSrEUDU9fCEQ2ZsEE/CF/3WCUY+R9fy2tDvsG/TnrOa5kgZkj+1cWjQhMBIoYPuoOrpwryUFgB3v76UlfdJfRglS/7RC/ymAMnAhx9og4sPNe79lqxeiv+L7Dj6GLjYr6ehbIDzmdwrpCc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675271; c=relaxed/simple;
	bh=Kn+lmZrmN2J3pS7pQCpXeo8SqQNxz+6oxNTNR87MM6Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDS63FGR8JzeNVRUYuXrDEbTBUdpB0FJFE6DF4MPU4qf94Cqu9eVNm9hhnMdSAfXghqk9lvXk51tDZFx0W8YlO3kMRH5fNQEqiRNbnsWByuZI6n56IVzpWhBbfbH1wxtWN/tU2GJAK0xNY6yqQHJUnAt4FbIu+xb5vQAHoicpFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y3N7mUJX; arc=fail smtp.client-ip=40.107.212.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhXl0mUE4cK2GiiciW3KaBkE2xjgLU7GXfAGPBilwXZ8zlkam0aNODw0hxI9gXYMggfFre+SkjgELf4fvIVs3QjiHAXE3kJhOk1ErG+LMyegqUe+o0+x98+Er2m8EhvqCEhAxbZLBrHFpgP8nGdNsXm6MCvJZnBlvVNllmaATb4/LMWDhZX4QGEM4IAy+7/rsxsxhJnCu1n9ilDEAEsiJDG2rD1QKkFtchdLIBHGEyFvXzdxLQQkS0kHWM7d5dNZ34FL43OagtpzOm8sHzxgS/dZZKDc0ChwOLsKQD7nqCaZ+MlVdrSJ0A2UiA5T5r8krXxuaXlw6SHxuzZeiCln+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN6EbyeVxC+pw3G7K2iq46RBHgVAKfon6GKo8eK6Xho=;
 b=s7faPpFkmCGQha49H2kjQLOvEPugs3BhbNErAoei655+fS9IEbLyv6SKZo7E4ausyWOUdYZzSsoyWNBhypp/nsNdbmiEBKZJ5SUo9+VSXaDD/vWQblziK42bx3cct5y7ghkArQBKDHpwL0b8ubOexWBJDVtxlCe5JQpBpJQwm6p/EaFTu+g1cWmL5G3nkkZQaVq6e+rSttsMiUNYf4uQmCuv98jJk0TlD9tC6pvLyNt0+rMhXbL99L5aL54iV1mHzq8SmUZPy5pfjLD8wScwrfy+jW40tSaYG8IoeAo7bvk+ehLZFzlepyJXQrrnPZyZ6COq7CBe3RYDX5H62eNcMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN6EbyeVxC+pw3G7K2iq46RBHgVAKfon6GKo8eK6Xho=;
 b=Y3N7mUJXEXZ0WMqMLWM5/dLyX8qfSX7ppjL7++agAcUHWcKrRjeZMKI/ZxSRVCmfNmTS/+wMjaQidGyyqZEozGzJgeDfU48YysUet5wnBRHEgSdOti5larJx1IRFnACpN1aql68TWtZ3CmkmXwdc7S2RGuda3AdzLDjS3TRCubU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 17:47:43 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Fri, 8 Aug 2025
 17:47:42 +0000
Message-ID: <0ce4f15c-40aa-49fe-82f1-3a30d3e56f35@amd.com>
Date: Fri, 8 Aug 2025 12:47:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 25/34] fs/resctrl: Add event configuration directory
 under info/L3_MON/
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
 <13467b9a56bccf960974741741b4960a8f02e333.1753467772.git.babu.moger@amd.com>
 <99614342-b6ce-47ec-baf9-f5cdf42f77be@intel.com>
 <40d722fc-e08c-4543-973a-3fb7ee29bf2a@amd.com>
 <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <1a19e3df-2915-46f9-9677-c369aa31adf7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 85283291-abff-4033-23bb-08ddd6a3acf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEllQnJFNUpuaEV0OUdOci9LOUFkQjNQNmZ6UkhsaGZsSE1GQm84QXVxblkr?=
 =?utf-8?B?VS9mSE5TbDNIZUljam9ETVpYSVFuN0FrSkxtMVk0WHJtRng1YmNIcEhIZERF?=
 =?utf-8?B?MFNWd2hmY3Nxczl6OFYyVGE4T3NGbGhDazlaQ0QvdUtQWkFKd0owR0Y5WWwr?=
 =?utf-8?B?a0pJZ2UyRExEZk1vTWRNSFJUTFJUcWFPV0NYb09wNXFmS09QbXY5SHdhRE1V?=
 =?utf-8?B?VG1oZkIxcHlDeUl1NFhxaHNQUnBIaVlOVW91UmE0R0crV3liVzl3OFFVamdn?=
 =?utf-8?B?cW1jY21CbFB4U3JDUDZyQWI4RmVYV3lEbmdIMUt0MWNWUVdLL0Vwd0diZEtr?=
 =?utf-8?B?WUROdFl4am5LaTFuMWJDODB1UnJiMWZFSVI1aEhJNDRZWUJBWG10dzkzZHJx?=
 =?utf-8?B?UVcwamRKTWZuS2k5MUcxbHozYUY2dmt0RkxCUi9MTlY4UHRmcmFoRG5QdEZr?=
 =?utf-8?B?NXdnUkNCNi8zQVR6VlBFK01ic0hqVm9YOCt1UEllUzdJa2lsNU5LUEEyQ3RQ?=
 =?utf-8?B?eXBUcFdyQlNNbHFsRm1jb0pSRnZteDljVVIrNDFGY2tnRXppN0dpOUUxTkhZ?=
 =?utf-8?B?cFcwL0Zjc3FkaXMwbHVCOG03TzY5RlNxN2NEcG5DSTdubEpGc0g2aFdGMVFx?=
 =?utf-8?B?dHMwaGhGWDBKU3Nib0JtZldUYTdmcDljUC96dGhCaW96d0lkcHQyUU9xYTMz?=
 =?utf-8?B?WjUyUEVYZmVHZnNsL3RSTE5QSTJlck5HbjgvdlhiRWt3VW1VbndsTVR2blpE?=
 =?utf-8?B?SHZLZjhQcnNFYTIrV3dWU0RoRUNjenFQQkYxL2NPTjAxN0ZHWTNlYUw3TXpB?=
 =?utf-8?B?T01BN3RFNjY1VVloMy9NY2lkR2UyWlVYN3RaZDVUYjVoRlNodnh2cjY0OGI1?=
 =?utf-8?B?OHM0elBmZXEwVUtzZk05Ky8wOUVZUlJZZUtrOWFWSE5qczlRNmVwTGRpR3Qr?=
 =?utf-8?B?SXVYTS80emZhNXIydnkxQ2RZUG1tQ0l3TUcremFSeVJRemwzdHNvTEdXc2JN?=
 =?utf-8?B?MGNiZ2k5U25nRzdBWE03aUVZMFhGbjV5cGVTbHdzRHU1ellhb1VKbTEySlR4?=
 =?utf-8?B?SFZmamhDTHpBL2g5YUQyZDNJaVMyTE1nQ1VtOFZ4bkV3amw3MFo2VCtKUCtK?=
 =?utf-8?B?T3YzZzdLdjB1eUt5Z1BCNWEzaEZ4Yy9VQndCRXFPMUZlYkcwNjd2Tm82WVJn?=
 =?utf-8?B?TCtHQ1FTUXpqeTFLR1VzdjdsRVQya1YyS1ZsWm9SbDVqSVhoM2VQWW41VE5h?=
 =?utf-8?B?aUdHRVd4RitadG9Ec3Q4Z0lGTTZHdldlOUlrWjhsN2d4ODlJVmxzT0YrN080?=
 =?utf-8?B?bjdMQTY5eUUwa0M5eTJCMW41M1gzT2c0M1ZIRWcyTVF6MTFFT2JOaHVvWmNR?=
 =?utf-8?B?azlYeVVmVzcxakhsRXRPaEVYTDYzdUdtSXRnOVRFZzlDdVFtUkVYczhIZ3Yw?=
 =?utf-8?B?Y0JjeEdyRzJBWENBaG00V2ZmYzR1UzFld1JlUGt3QkJXYnlFcnZWOERBVFhx?=
 =?utf-8?B?TmFxL0t0aUVCemNnaEdzeTY5QUNHZTZMZlgvMVZ3WmMvU0RDVjZQM3hnUVhl?=
 =?utf-8?B?RWVBRHdUUlQrMFFpcEFFdi9vRVFjMXhVMlVuVmN1UFNRWUthSW84VVFhMCt6?=
 =?utf-8?B?SWFSOUltRk05OFR6ZFN5QUtSWVJUcjR5NnlkMEhTU3NXWHhzWVNDMXduRkhD?=
 =?utf-8?B?OXB1S2xWL28zWFpoeTliN3Z1WVFwQjBrT1ZXTUh4cUxkd3V0b21mc0FRQkpT?=
 =?utf-8?B?ZTZPYWUwMTF3WEl3ZGJOY2R2QlBSZUxvdnhRYWhvN3k4UlBqN3RzelJQZXVo?=
 =?utf-8?B?ZDBkMHFDaHVRTkhydDdTYStKZ2JudTZmY0pFYzBzYTBtZ3JJdFBwWFRPcVo4?=
 =?utf-8?B?MndEcE9wZGhXK2JGN3lFZ3BXdUhoeXlzWnp6dk52V3ZBemYyM1VuNHhoUEo2?=
 =?utf-8?Q?63N02+2L6+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGEzUVVrSmJIVlJpNE54a255QlpEZGF5MzFURTRkN0VmV2tWLzlaVGdRcmox?=
 =?utf-8?B?SktYbU4zc2tXUVhTWWhiVFZhbGFQYmNJNk5tT3dyRzlZQ0lYd3dVbER5bkx3?=
 =?utf-8?B?Y01adEZDRFlJdURiRTNCTkdLVHZ5bEJ1WnVuekJkNzVsRzI5bHg0RGxSdkxx?=
 =?utf-8?B?V250a1JVWFlmS3F6R005Mk5OZFowZk83T0hNTXFoemg4MzlLU3cwRGhmb3hN?=
 =?utf-8?B?aGM3alc0WHI0WUI5RzJUdVBMaElzSWM3VWZVSTZPZDUvU0lGR1VxcUdoVXNV?=
 =?utf-8?B?U1lZeHM2UU5JcU1IOGZUekhUZjY0bXFpcmlvL0p5N2hKSERnVEJIZnNXNG5U?=
 =?utf-8?B?Z2o5WHFtY0sxWXVtSE9xRitIZkJGMXRmNjVQSkFMUzNCV3MrSnN3ZnBrTVVR?=
 =?utf-8?B?aTZONEFLVm43OS9CRjBvajFFdkpzakdMNzhYaU03WHk5T3NtOHVMQVFyYXNL?=
 =?utf-8?B?NmRJU0hNQkdGMFIrVGRjdUxKZng0RXFxbjNLZkVwTTI4QXdJaHV4R0QzWTMr?=
 =?utf-8?B?QkowalVoWjN4OGFnSUlFTnFYU3NvMHJzVDcrNTF6QXVUb2d2K1A2YVRBYUZr?=
 =?utf-8?B?MkNvbkhzckdBdnBTRksrWEJBU1hSQk5weitpWXFsYkxSQ3NPdkQ2WUh4WVZl?=
 =?utf-8?B?QVd3NnFLWWV6b2Z5WmtSOVJIbmZFdlFRcHVCOXR0b1ZmdFd5TExKeDgxTXJR?=
 =?utf-8?B?ZEF5czhWQUwzWnE3S2dZZkl5YnJ0VkZNamplbDNKK0FURVY0Z01zRk8yRXdN?=
 =?utf-8?B?ZmFLQUVrRC9td1pQeG9yVkNkNk42aFFLbTJzYVhNSjgwUUNablhtbCtMK3h1?=
 =?utf-8?B?WDVaaTFoVVd4d0pkeENkbmRkdGZ3L3hiMDJjL29aT0NoOVFlLzh0ekdYdjFz?=
 =?utf-8?B?ZnV0UnBSaW1tY3VvdE1Vd0Rvb25aS1RuczdObUN0TFZlRXJmOFNxR1BDRGRF?=
 =?utf-8?B?TDBlVWo1aFVKUXFtRTBIbXg3Nmk1c1B6ZFNCT25nL2Q5SGg1M3RjRmdVVkxE?=
 =?utf-8?B?aEdKSTNYNWM0REdZYXBMTW5rY0lkWEtPTXYrdUs1ZkFUenEySERjd2FVTDlP?=
 =?utf-8?B?MnJGU29ZNzNDQ2o0SlVYZE93cXk0WENCb1N5dXBJcFNLUVA4WXRad3dTMnpr?=
 =?utf-8?B?WTdGQm8xeWs0WEpyMEl3dTJoOG0yK0N0Y0x2Zlp0QWNZQzZNd2dTcFJPL0xM?=
 =?utf-8?B?a3VVVFRmLzFjL0I1QmRqbDBDU2dJQjhIc2tsN2VIbmlEZjZ0cWIrSEE4aXBj?=
 =?utf-8?B?cEd6TXE5U2hHTkJocnVESzhFN3NtYjluOWpKYjhaOHQ2Qk0yTnM0ZXVjWmUw?=
 =?utf-8?B?RFRwcFpPWFM3S2UwNG1JbDkwQjdSZ0F1TGpkbkRoWThyZUJtQkNHSGswUmoy?=
 =?utf-8?B?eWU5a0JkMmMxQTBha2RWM2tZTDB5dU9Zc2NrbVMvVWU0QmFNbjRCbTdqRURE?=
 =?utf-8?B?SzhYNm83S0w5SDBhT1U2Z1pNRUh0ZnFpRkhYYU5CK1dKMjJYMEJBYjh5Zm13?=
 =?utf-8?B?amdyNUsrb200bGw5MGxqR3E0K1M3TEs4UW1yd2xSN2crb2p2ZGl4eHF0S3Er?=
 =?utf-8?B?WlhlTTZUdXV5eHR5bXphQml0T3V0Wi9oOWtTRGMrY0UvMWsxZ0NLb05OQmtX?=
 =?utf-8?B?bVZXRCtqTVNKWHJGRkJ1eGdrc3lXNWh1OEM0eElWUGhUWFk3eEZOZ1NZemZN?=
 =?utf-8?B?eEZKVGNZWVJOU2tBT2QxQkRraTVYM3V5cVNDT05JaFdCaUhFN0dwcTdKN25F?=
 =?utf-8?B?dDlaaVVoNnJKRnNaeUE5ZVcvc0hLQWJUUnhoUFhLMVo4dWJwUHVSMWNQNmdo?=
 =?utf-8?B?azZwSTdLcnRMZFN6L2xwYzlRcmt3Mi96bHIyc3FqSTJqSXBHR2M5UkNMM3ZX?=
 =?utf-8?B?L3FHeXZSajdPWEY4NExEQ0EzZklkeW5ORFFubmJnajFoTFVPY2NJdjM1YmdP?=
 =?utf-8?B?dzgyVE5QNk5nQW9FSEF2Z2YydTBzb29vZDR2NlB0OWtWUVV6WEVuWkFtYW85?=
 =?utf-8?B?WmxhT3VyRjRZb3MyTDlXdXlwdE5LemRiQllPNGdZNFF0WXpKYlcwdmRBSGJq?=
 =?utf-8?B?RnBmbzRXL0JuYldhbVhqdTZlOEMyVFJuZUlSbllUdGsxYmI2SEdicjJLY3lh?=
 =?utf-8?Q?JFIA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85283291-abff-4033-23bb-08ddd6a3acf0
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:47:42.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA1X2qSt9Pwh0/RTn/CCnPCD3qD6IInkeYDpC7Cg1vk72vKmioW5ZzvhEAte+rEb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B

Hi Reinette,

On 8/8/2025 10:12 AM, Reinette Chatre wrote:
> Hi Babu,
>
> On 8/8/25 6:56 AM, Moger, Babu wrote:
>> On 7/30/2025 3:04 PM, Reinette Chatre wrote:
>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>> diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
>>>> index 16bcfeeb89e6..fa5f63126682 100644
>>>> --- a/fs/resctrl/monitor.c
>>>> +++ b/fs/resctrl/monitor.c
>>>> @@ -929,6 +929,29 @@ struct mbm_transaction mbm_transactions[NUM_MBM_TRANSACTIONS] = {
>>>>        {"dirty_victim_writes_all", DIRTY_VICTIMS_TO_ALL_MEM},
>>>>    };
>>>>    +int event_filter_show(struct kernfs_open_file *of, struct seq_file *seq, void *v)
>>>> +{
>>>> +    struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>> +    bool sep = false;
>>>> +    int i;
>>>> +
>>>> +    mutex_lock(&rdtgroup_mutex);
>>>> +
>>> There is inconsistency among the files introduced on how
>>> "mbm_event mode disabled" case is handled. Some files return failure
>>> from their _show()/_write() when "mbm_event mode is disabled", some don't.
>>>
>>> The "event_filter" file always prints the MBM transactions monitored
>>> when assignable counters are supported, whether mbm_event mode is enabled
>>> or not. This means that the MBM event's configuration values are printed
>>> when "default" mode is enabled.  I have two concerns about this
>>> 1) This is potentially very confusing since switching to "default" will
>>>      make the BMEC files visible that will enable the user to modify the
>>>      event configurations per domain. Having this file print a global event
>>>      configuration while there are potentially various different domain-specific
>>>      configuration active will be confusing.
>> Yes. I agree.
> hmmm ... ok, you say that you agree but I cannot tell if you are going to
> do anything about it.
>
> On a system with BMEC enabled the mbm_total_bytes_config and mbm_local_bytes_config
> files should be the *only* source of MBM event configuration information, no?

That is correct.


>
> It may be ok to have event_filter print configuration when assignable counters are disabled
> if BMEC is not supported but that would require that this information will always be
> known for a "default" monitoring setup. While this may be true for AMD it is not obvious
> to me that this is universally true. Once this file exists in this form resctrl will always
> be required to provide data for the event configuration and it is not clear to me that
> this can always be guaranteed.

Yea. It is not true universally true. I don't know what these values are 
for Intel and ARM.

>
>>> 2) Can it be guaranteed that the MBM events will monitor the default
>>>      assignable counter memory transactions when in "default" mode? It has
>>>      never been possible to query which memory transactions are monitored by
>>>      the default X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
>>>      so this seems to use one feature to deduce capabilities or another?
>> So, initialize both total and local event configuration to default values when switched to "default mode"?
>>
>> Something like this?
>>
>> mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg = r->mon.mbm_cfg_mask;
>>
>> mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg = READS_TO_LOCAL_MEM | READS_TO_LOCAL_S_MEM | NON_TEMP_WRITE_TO_LOCAL_MEM;
>>
>> We are already doing that right (in patch 32)?
> Yes, but it creates this strange dependency where the "default" monitoring mode
> (that has been supported long before configurable events and assignable counters came
> along) requires support of "assignable counter mode".
>
> Consider it from another view, if resctrl wants to make event configuration available
> for the "default" mode then the "event_filter" file could always be visible when MBM
> local/total is supported to give users insight into what is monitored, whether
> assignable counters are supported or not. This is not possible on systems that do
> not support ABMC though, right?

That is correct. With BMEC, each domain can have its own settings.  So, 
printing the default will not be accurate.

What options do we have here.

How about adding the check if (resctrl_arch_mbm_cntr_assign_enabled())?  
Only print the values when ABMC is supported else print information in 
"last_cmd_status".

Thanks

Babu


