Return-Path: <linux-kernel+bounces-743095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17507B0FA81
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482FD587F68
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89583223328;
	Wed, 23 Jul 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SRjswjuy"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701E321FF5B;
	Wed, 23 Jul 2025 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753296613; cv=fail; b=fU8j427PrF6fcK8LIz/7Lv+/TvwOjrPBIU7yA07PdawV1Zw81lS+gBVqZX4bHhpYLOcroYJkTA6h24n87wxhkKf/dZdzAmVtvU+DpTWYJ/5qGPBOoyS85cvgJUM0jBPyhaD8tAPhYm8bWKSJPjOASrEYkR68oE/c2GRWNUmgYz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753296613; c=relaxed/simple;
	bh=jBawuChAOYstfuXsFNSjQNMzMQXEjemyp1PBCPzZDI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UOkDW0k9i7GRwi7SW2zdM4qGzb9d9z6MdfOrClmkAqq92rBqN2kH4vCKZ3fHpdcWIWmOgKxv97qsMCB96ZsjXYvOGnO0z+WQagKu6x0WgjIL2WDwPRt11RwYO6+Y/whKDcY4ZdHSPzy3u+gU4hosCpW9MfZAIpSkc0tF1RvgAhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SRjswjuy; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUb5TLM+5QtQg4EclmO+YDAy9DKFAwSyfu3MSLJW6nJt3iKLBGLceYTe3BmbcD/5XohcQpenrDLfhTyOMvqHRfXHYUf22SEDFNVzobM4fSh6iMEu9LhVEZpkPWhL4nLouXHNs31vAe2Ci6Ca1wiYYqwa3CEi5kAzglmQsy8g+PWtfWh4wjA6mnbU4qGv2c1CJ9wZxFhkbLZIDTIxGLT0UIb0utsvJIzTgXB006FYZv/IlqRmV5j2y5KXxqtWIgB/wc6yQ2lZa3hY9uLw8Vn/HjWtiC779GLysFSi8yU0qcoybVn5DVZAojAL8eE3jQAruR8evWOsrXpfIjuVy2yX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvmuK56kqOYMMFAzHpauGe5SluzLyeJfOF9Btbvezro=;
 b=N719gMDAx+L5RdreHy25F5HKhY2Kacgddss5rwhgr5IcHVx/1g5IBS4SStr6UswE0nBvwCLJPPy8YL8xpYn8ZbVDpxwnRcz/56nqQnMxgc3gUkEVarqT0ufTyvl6OksRl84DJc4VBRW/VHcUkCSKdgSzdXZ2sGmdyQq8zgamaET4jviHUVHuvuoCFqIIlsOZ9tc+cSggI4I8Bv100WKuAlb++9pOGgK/4gSrNf/+zj5lMF6ak2hu7gJ1dTfHCaYJzXmM85n8xFnfJEkJSHwcU/JYxQFWZ+AHG08Npvpe7YCN1rofHQTejTOUiXtzKx4I95zRVKWVUjTPybmrIr2hSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvmuK56kqOYMMFAzHpauGe5SluzLyeJfOF9Btbvezro=;
 b=SRjswjuywpqJWz/WrbKYnZFv/JAMQ532aKcx5j/4Ll3fT8PFet4K642YS3BJQz3aOv6gWsKFFPZ0e9Yvao3++caH2TorasbxHvzr9HV8M/LtOu8RfpurVZqwUV9FcCMVIYJ8H5VTdr1H74aKxPy14agW/W1jyybV41IPmer6hCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6913.namprd12.prod.outlook.com (2603:10b6:510:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:50:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 18:50:08 +0000
Message-ID: <82b8e6fb-8663-42b7-b67c-43e4ea6f8aa8@amd.com>
Date: Wed, 23 Jul 2025 13:50:03 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 33/34] fs/resctrl: Introduce the interface to switch
 between monitor modes
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
 <7869219493bb4cc5626da704c4f8f107fe7c8f69.1752013061.git.babu.moger@amd.com>
 <af0a7a35-2f6d-4c8c-990d-af809d9547bf@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <af0a7a35-2f6d-4c8c-990d-af809d9547bf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 477cb277-3199-46a6-c17e-08ddca19befa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cytzVWpld0VqK28rS09pOUlqMmxFQXVHam5EWWMxTGlhNStCWjdrZzI0NUpx?=
 =?utf-8?B?eVgwNTN3L0QrOU9uM2hhSCtiOGU4Qm51b2NLdjJuNHJrTkhyYmdIaUZLL3dN?=
 =?utf-8?B?SjBFbkQ2bTlqOWJmaC9jV25DWStxQmtDYlk4TlZXMWMzRUsxYnNsVkdiYmcw?=
 =?utf-8?B?SzduWGNBcVRYNHdhUVpQdWx1QUd2RDdpV2ZZWW9mK0RDUCtKRFlQWFMrM3R2?=
 =?utf-8?B?UWYrU21GaTl3Q2RDZTJXQXFiZStSM3JmRm9kMkI0eVhNT3FhU09xRHhmOVJC?=
 =?utf-8?B?TE9ucmFaZVlxOXMxUmN1VHdUTUZ4QWUwZVp3b3MrME1tQmpTUTdkWTRtUG1v?=
 =?utf-8?B?ajA5S3hER20zVkUxY05kQThiams1eFVGT1U1djBoK0JKY1FSeHlQdGZ2TXpD?=
 =?utf-8?B?a1BKMXFkLzVwTjZZVWxPYVdHcVdabVJ5bzE3MWxDS0k5MGUyQWdFaGFZcWEw?=
 =?utf-8?B?c3I5M201YkNIcXJMeXhQY1BOYXN1R0d4OTliMDRNb0txaFNKdEFvdnNoMmtT?=
 =?utf-8?B?YnozNmlsMVEwRlNGa3RFRVlYR2FpdG5MNDZrYXo0L2puSHgzR2g3MEd4eXJX?=
 =?utf-8?B?YklrOEdQSHZNNnh6WVBaSDd4NHk5TG9SL0MvK2VDbTVNdXZjS0d0ZENLUmlU?=
 =?utf-8?B?WTF0MlQ4eXlYeCtWcU1kWjMzcFJzZm9qNmdKUHRzTTUwRFYvT3lseEZaQ05y?=
 =?utf-8?B?UUtUdkZucUFxOHNBNDlBQk96ZlA2TlgzMU93WW1VclVJM1hISFFJWk5JOVBR?=
 =?utf-8?B?eHZxNHJjNW5VTGtHVzhZRUpZRmd6encvcGVSYTNBL2lVT3hvekxlRVdpYXhF?=
 =?utf-8?B?WjU1UmRweVBzN3djbFBnd2E1SnRWVlpaaEJacXcrM1BIRjFTRkpNelE0TXBM?=
 =?utf-8?B?K1hEZWdSYWdLNGpKa3VRSURXTVNhZWFTRXQvMHJtZjZqMThkWTVqMHc5Y3lo?=
 =?utf-8?B?UWdpTHBMdWIwSnZHMFhWSE83bnkybjZwTWJzQ3dOTiswU2hEenYyUnl3eklq?=
 =?utf-8?B?VGtsNDNIUkx6eFFrUmNRQkJURjFGNlJRVi9ORWpSelpieXhhQXhZS3h3emQr?=
 =?utf-8?B?amlCemxwQm8vNjN5djVxZUJBaGNSYUdCNCtkTzBUTGVtaDdYVVY0WHJWb0J4?=
 =?utf-8?B?YnpNc0daUnRkV0ZoLzA2UW44blNBWU41NjZVWm1sTVI4dm1PTnllU1hpWmtp?=
 =?utf-8?B?eVR6MGhVTk0xczZwV05HUmJSMGN1STBMcVl6VXdDajJoNXhpM2cwakdtVjFh?=
 =?utf-8?B?aGdpNlcwMVVhM0F3cFBJRUJIYXFuM3hKekRMRmJQRWdXUkxnRk1ocWNURkJC?=
 =?utf-8?B?RWxoYytjOUQ4RzN2RllpQVk5TmI3WWxsSkNabDE0Z0IwdWpqby83bVRrVlQ0?=
 =?utf-8?B?cmxFeGtBdmpXdU45eG1naVBpblpDVFNsVU9XRVpJUEN4NGFwVktxUGMrWW1V?=
 =?utf-8?B?aWNuYnRIcDZIT0dkK2NTdm1EbmJwSEJNY0dnaytQakZlUTlpUEpObEJoMS9Q?=
 =?utf-8?B?WlZDalkzWEh1N3N1RGc3cVErSEl1Q3h0NGVyWDh4UWF0WkZXN2d1c21EcWJm?=
 =?utf-8?B?S0wwUnkyWHA0b3JGUGFuazhjU2xNazFGTXlPS2E4dWh6MUl4dVdaV0V6UlJw?=
 =?utf-8?B?RTRidDJ5aFFtVStsM050ais5TENRU0NSTHRoOXV4L21CbzI3VSt6dUV0VE80?=
 =?utf-8?B?anRUQTZwV00yZDRQcGQyUVJVaTE4NSt0Vy9IOVM4eXYvRFNNbDNQNkZhUzRS?=
 =?utf-8?B?UzFLRW1YWmcwZUoraWszZ3FsVWNwV0wwUUVPREU3amVPbHZCQ3p0NzV0REZY?=
 =?utf-8?B?KytrQkhPeDczVC9Cak43N2ZnbGc5c0RLbE5vQUNaT2F2L00zS2UyNjdpa0Yr?=
 =?utf-8?B?SkkyN2tFeGozWEZnRWFWUDZQUjU5ZnBaTWdHWjBrbDJKZG45T0xWZFNEdEc4?=
 =?utf-8?Q?J3HF4t/1IAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anZZL0NtK0dZcFhNZzRIOVRxQ2xyanJrZXpnVUVOVWVrQ3ZPdGxFN0Vhck13?=
 =?utf-8?B?UE4vZEgzMklDOHkyL2cyNUR4T2VUcTN5ZXc2Y3BKeW4rU2JWaTIxaGswMWRx?=
 =?utf-8?B?MzZhSEJTZjRjK0wxL3VOMVV6YytUNGpZb3lGemhhZmZwWmNCbGNvVnFEc1dz?=
 =?utf-8?B?Y0J6dTh5ZkhlaUlja0xzaGdac1IyWlhjOVROeE0xTFkyM3VZbmhYT1JCUXk2?=
 =?utf-8?B?L3hkY0RUQ1lLbGhuajIvTUQvWUVQSjFaQ2VleXF3MStpdXhOV2JnazhEVzNX?=
 =?utf-8?B?V0tPallSV1FSUWlsZ3l4YVQyQ08reG9ucXRFYVJmS3BYU1ZkakJtN0dEaWFI?=
 =?utf-8?B?MW94Y3Z5SGxQT0s4Wjg4NktUbi8vRFVQakpUSDFNN3pwL0g3dktrQTZna1hZ?=
 =?utf-8?B?ZzRwMVdYTkFxNVdDUndncmc4dXpPMUhVMFlmcER6bnpNejcyR0tOU0p3UDVz?=
 =?utf-8?B?eTNmYUR5bWFBb0xZWGxQV08wNzFjMEdZQmZIYVhHdWFUUStlTEg0VDlmSyto?=
 =?utf-8?B?eU1nMVJJK1E3SzJ5b3F3OXlDRStyUzhZYUcrQ1hCamdraFpqRnJHOGJtUGI4?=
 =?utf-8?B?Q0lXTjhISnEwY2VLbHMwdGd2RkNKN1hDVWdZd01jZ2FrRGNiN1ZlSTdYcjhq?=
 =?utf-8?B?U2ZTb2dFUXd0QVJ2dXZhWEFuZ3FDek1YcHVmR0VxcHBrMTFXSDVyMStmVEtX?=
 =?utf-8?B?dmtxUUlIRit6S0l3L0w5cjd0REQvemp6N3MyZ0RoUWVxbXZOYjFGMVlZQzdI?=
 =?utf-8?B?THlqZkVoVkRxTVdvdWRsb2JQMy96Sm56bWRsdytjZ09wNzZ1T2puY0Y3VnhI?=
 =?utf-8?B?RXN5N0hNNnZoajhHRHpOWnFDNmtTOElFNElKSW05eGc3UEdsQmVENTFuUHhG?=
 =?utf-8?B?SVRDSzJKSFlIcEM5ZjFoVi9DUTJjbnhIcnlnRFJadVR0QkNEUmhXVktuUFdD?=
 =?utf-8?B?NHhHbVRGLzJXd2lwZ2RCQ0RjUEJZaDZYWmtodWV2WmdUaFBydldOTllxRExG?=
 =?utf-8?B?ZFlHVWRvUUYzcVpLd1ZzZ2JIckRWWk9UdFMzL2RNMzlTUGpSNWhKaGFueS9s?=
 =?utf-8?B?U1lJOG5Ba1pRSW4vN2lLOEhpOUl0alF0TGN2VVJZaG55T3BPdWpqclVwckVF?=
 =?utf-8?B?UlhPWXBERVZ5V2U5ajJFaUd3K09ibThtcWMza0tXcGtUVkdURDdmQ0JKRG5N?=
 =?utf-8?B?VFd1TVEwMG1TdG9Zcm1LM0JQb3NxQjY3Y09RQzVGaHNaeVlGRGYyWUdEZmhq?=
 =?utf-8?B?RkVsODBTOUpHWnJyNHd6Wk5jNERzY1BzSk16blpuUDA5SWNQZ3NkTEhPeW5M?=
 =?utf-8?B?UEMrWllBWnVCb1JaNVo4L0t6NjdXdllVVXU1UTd5ZnJsV0o2bW5aTHRpcXNM?=
 =?utf-8?B?MVVWbXQ2dlVOb0VvbzU3MG44dFVtcG9FT1lNSHlDZFhwQjlORnhDUmZFMTV0?=
 =?utf-8?B?dFZBcWsxekRYQmFwVDVJS0RmT2wxMkpIVHUva0NFb0ttTU5TWXZBMyttUC9w?=
 =?utf-8?B?WHZJckR0bHJlMEhmYWxzMnEzWjR3aHRYNWhxdVVBN1dQWkRqK2xEaHptb3ov?=
 =?utf-8?B?UzRpQmJweVN6Q2JtbEFFamRhNTFPNkUrRXhncXBKbGU4WUZrRUxSNWxpVGxV?=
 =?utf-8?B?aEt3THZHYnpPOEcwaWExeHNoYmNBVnI0eFhXUkREd1hsWVdsUEdRVDRKV084?=
 =?utf-8?B?VzhFc2Jnd0ZjOEhDdXJ0eUd6c0tjVE41ZjQxc3dxQjBjWmprekIwMGZuQUQ5?=
 =?utf-8?B?Y3pzcDNuWGVCZlNxSGZadFVRcXVkSW1NSzBqV1lYNFZBSDRPdThtcm9BR3hH?=
 =?utf-8?B?aWhkZlZ6dmhzdW94ZWlWdjdKZ3Q2MjE4S1RhMTRzejMvT0c0VFBYbE9ZbTg0?=
 =?utf-8?B?ZlU4dU5rd2l1RDVMZTQrOWxTSzdXQzRSRmlRU3N1MmRHSlFNTGJ1TWZBM3lu?=
 =?utf-8?B?RXp3VXR6YTFyOG5pNENaR0V3QlVHeCt2Sm5UVW1CTHcyZExuZ05qTE9SR05a?=
 =?utf-8?B?a1BLSGtsbjVkdFZTcFl6dm41MTlYMkhvTlNYeVRyRlNPcVMxQS93QlZEclVR?=
 =?utf-8?B?RldUMHdoSFVQQm9MNTVMckY1dlk3aVZNSjlSSmZ1bmFkaWFEL0NydUNMcDVr?=
 =?utf-8?Q?9ycdm5sZzllkuYMSG/HHsO7Lr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477cb277-3199-46a6-c17e-08ddca19befa
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:50:08.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmOpnII2k7pIO/25ngIYmG3+6A2NICGOMuQkc29JZ99QE+QAYBYwTZRiKDZlkxYr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6913

Hi Reinette,

On 7/17/25 23:03, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/8/25 3:17 PM, Babu Moger wrote:
>> Resctrl subsystem can support two monitoring modes, "mbm_event" or
>> "default". In mbm_event mode, monitoring event can only accumulate data
>> while it is backed by a hardware counter. In "default" mode, resctrl
>> assumes there is a hardware counter for each event within every CTRL_MON
>> and MON group.
>>
>> Introduce mbm_assign_mode resctrl file to switch between mbm_event and
>> default modes.
>>
>> Example:
>> To list the MBM monitor modes supported:
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> [mbm_event]
>> default
>>
>> To enable the "mbm_event" monitoring mode:
> 
> "monitoring mode" -> "counter assignment mode"?

Sure.

> 
>> $ echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> To enable the "default" monitoring mode:
>> $ echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>>
>> MBM event counters are automatically reset as part of changing the mode.
>> Clear both architectural and non-architectural event states to prevent
>> overflow conditions during the next event read. Also clear assignable
>> counter configuration on all the domains.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> ...
> 
>> ---
>>  Documentation/filesystems/resctrl.rst | 22 +++++++-
>>  fs/resctrl/internal.h                 |  2 +
>>  fs/resctrl/monitor.c                  | 27 ++++++++++
>>  fs/resctrl/rdtgroup.c                 | 72 ++++++++++++++++++++++++++-
>>  4 files changed, 121 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 2b2acb55d8b1..b8a4dbe061ea 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -259,7 +259,8 @@ with the following files:
>>  
>>  "mbm_assign_mode":
>>  	The supported counter assignment modes. The enclosed brackets indicate which mode
>> -	is enabled.
>> +	is enabled. The MBM events associated with counters may reset when "mbm_assign_mode"
>> +	is changed.
>>  	::
>>  
>>  	  # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> @@ -279,6 +280,15 @@ with the following files:
>>  	of counters available is described in the "num_mbm_cntrs" file. Changing the
>>  	mode may cause all counters on the resource to reset.
>>  
>> +	Moving to mbm_event counter assignment mode requires users to assign the counters
>> +	to the events. Otherwise, the MBM event counters will return 'Unassigned' when read.
>> +
>> +	The mode is beneficial for AMD platforms that support more CTRL_MON
>> +	and MON groups than available hardware counters. By default, this
>> +	feature is enabled on AMD platforms with the ABMC (Assignable Bandwidth
>> +	Monitoring Counters) capability, ensuring counters remain assigned even
>> +	when the corresponding RMID is not actively used by any processor.
>> +
>>  	"default":
>>  
>>  	In default mode, resctrl assumes there is a hardware counter for each
>> @@ -288,6 +298,16 @@ with the following files:
>>  	result in misleading values or display "Unavailable" if no counter is assigned
>>  	to the event.
>>  
>> +	* To enable "mbm_event" monitoring mode:
> 
> "monitoring mode" -> "counter assignment mode"?
> 

Sure.

>> +	  ::
>> +
>> +	    # echo "mbm_event" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +
>> +	* To enable "default" monitoring mode:
>> +	  ::
>> +
>> +	    # echo "default" > /sys/fs/resctrl/info/L3_MON/mbm_assign_mode
>> +
>>  "num_mbm_cntrs":
>>  	The maximum number of counters (total of available and assigned counters) in
>>  	each domain when the system supports mbm_event mode.
> 
> Reinette
> 
> 

-- 
Thanks
Babu Moger

