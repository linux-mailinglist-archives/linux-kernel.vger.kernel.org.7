Return-Path: <linux-kernel+bounces-741133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BF2B0E076
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2703B06F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133C266573;
	Tue, 22 Jul 2025 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m2tedSuy"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C4E1E2834;
	Tue, 22 Jul 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197970; cv=fail; b=qZSqEPxkf2gpS5yOf1McZOlMDrbCLqZy9ZYU4+VUxpUAaMse2cNJ930QcoKJn7s20N/QPE2zCpZ7c7F3jr5BVxoEPapyO+/B8F8BDRQuaBDWGxdmjVjQgdWoLTL0CuUAXMJ75PJtlHpV8U1s5nolsPKx+N5PCAzaX0uUaWxUPJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197970; c=relaxed/simple;
	bh=amBS6tXsB5Dl0GgqJqaHy7rFDbJ3/wnMGQWiyt/F4Vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OYm8zlFvYNpGEug8aaQ5mtiq4a8MubfSkzYUcrGnA2IwJpbv3hq/pRhhg3CuJ+z89JdAr+Y4EXoyaDb2TiYfsGen9tIlJrWHDocHBVh/vuPkLPLlNIkJcHgxBPiIknGuk6MC9mnT7+pBfuVbqGXkVjvgFd/4OtooKZeZawX/PUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m2tedSuy; arc=fail smtp.client-ip=40.107.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUDR+vwEcm5LwKCg07KtoFHSC1JEILT98oq4kQEWF9wtD/Af0dE8Kz4v8O6G/n7UmVYD/xa32YGNVD2C0KT7MibCUWp43XrGg+LJ8Y9DbCPnAPTAKonb5v9YO/PyUo8Tq9oRlBDTJHOm4dmAp0hop6+i8Y/7pPH+HMgV1hjfCbrqJIPVu52ewvgUzgU4JVFKsh9PDhyZdglzbkZiTj5s1LN1e4IkhvoZmwgL/mmb80ISTrCwYujOX+ek6dTc9ka2FSeJ40SLStxaGwddUgnUHMpOAPdIuCbUSocX42+TsZvaTzODOpvKQze7C8l7zLxUPolsfdkqeuEp6MuptE28pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/6jTvheJy9xXlnr7cknm/Q01VcgXp/oXw56O1ixNrE=;
 b=THWpBCtuAqIDF95XauoMl9tKY9c8IWUr2J32aXz5OzOCTalrZ1MJeMFwWztykdeQN8+JPkUVEkiTASHX7PJNzAL7kHPyWM7hjW4WfRjvRiRb1cFz4ZqucWazhVziayI3C1GLV9662mJClCeoFvts/ALgcNQ4XxNh7qfEMaE7GFeAqDyT+pOtyce0p9Djr7mgq8RWyKJM/fqQWttDUwFZFWhYDo6EUjVt3vC+vRnlDw8Q9SsnldSgCoIOdigYhfy6VdaRbVX9uZpNmnLP0udq47Fw8GwLYtwZV0CkvycKMQHVa2l0zlrX7KiBHqH5z1Z2ThhYprg4MXT5XD8fj3rBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/6jTvheJy9xXlnr7cknm/Q01VcgXp/oXw56O1ixNrE=;
 b=m2tedSuyqwKB7GEv/YxEf13LigU6llaJ8AM/U+UwbHHC+f7JnrY2KD/3l8t2PcI1LgVTU170Lxq8e2Pn0ue219S5Z0RvX/qOPsghsv7FrEB/RFlEfm7R7efDrPklHfHBmHlfhkc5iM6zKuKZ8u4YCauFuG1XhQx71szm3SONLrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 15:26:04 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%3]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 15:26:04 +0000
Message-ID: <afb94c18-9de5-4d33-b99e-53dcdebeae95@amd.com>
Date: Tue, 22 Jul 2025 10:25:57 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15 21/34] x86/resctrl: Refactor resctrl_arch_rmid_read()
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
 <7cab88ccc3e0e173271c9b12fce22785bbde9239.1752013061.git.babu.moger@amd.com>
 <d240b37c-e00e-4b6f-a0c2-267041aaf9de@intel.com>
 <cd5bc14a-8b96-40ac-bd5f-7ecedd1d3464@amd.com>
 <0770f2db-2def-4cca-8e20-9bb864a46511@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <0770f2db-2def-4cca-8e20-9bb864a46511@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0007.namprd05.prod.outlook.com
 (2603:10b6:803:40::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f330ab0-311f-46c6-81e1-08ddc934124e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC9Cak0wTEpJb0hGUDBJSTVIRTZIc2drY2J2NXpqZFEzOHp5aGEvZjRJZkVo?=
 =?utf-8?B?L1pTNG9RZW5jVDZZVEpQdlJvVkIxeW9YNTRrakpOeUx1ZlBrSTR5RW12ZlMw?=
 =?utf-8?B?TFdTeEVlQVRzeVBxYVNqdzlXNkd5ZUM1TGg0cXQrVVFrRWFqTXJHeW1VQ3V6?=
 =?utf-8?B?cWhGLzNJVll1S2hpc0FKQnNwOVpvZ2NwU1QwWWdaQ0d1SDlzRDE0VlI2RDRY?=
 =?utf-8?B?KzBkN1hvV2VoSHlZcGFYNnhsQ0dDenYzcVlUb3VPeEp0Sk5kM3IraW1xR3Rh?=
 =?utf-8?B?RkxzN0pYTFAxNGtDNWQ1TmliTERNYVBjMUdEbkxPelBFZVF0a2pNc3ZQVmxp?=
 =?utf-8?B?QzZoOWlwYjZjcFVZTWFqbGt0L09takVXc2JaTjRpdGdkSVdmVGNFT3Jlbmdx?=
 =?utf-8?B?ZWpxR2tRSGFpTWh6MjJKaTh4Y1Y3RmMrMmlITXpzVTBkUFd2ejJBOGlIRnJ4?=
 =?utf-8?B?YmlKOENRWlQxTUF6b1ZZd0tza2RmR3Zmc1ZhOEJNTit1VE1VUFloajZJREs3?=
 =?utf-8?B?aXd3ZURSaFU0Tmg0MVpmV2FBaUxzRi8zZVR4d09LaXVnMjNwRHk3REhGUzdO?=
 =?utf-8?B?cG11TGphcDNsMkhDVkxvMjZGVytCWDdacnZRSmFObnRtNlYxa3lpbkxBVlNL?=
 =?utf-8?B?dWFwSEI1RTNWL1BmU2NwOXBoTE9sRFg5TDR0NlR0R1RadjFoWXFnSVJEVng4?=
 =?utf-8?B?VnhRSFhsODNDTG83N1J0ZVZJcmVBL2FHRk1VQXIvZkkzaEtlenNKQTRrdStS?=
 =?utf-8?B?Q2VFZU9iY2tjblpITzNyQkdWZ2xvUTBkTnR1YzFwajZ4Ym9SbUNFZUhaNUxK?=
 =?utf-8?B?bWc4c3dDU3hCTlgwdVFkQ25Sa0hJT1ROZ0tibzdEbUF0SUY1bklZUVlxQjEy?=
 =?utf-8?B?VTR1WDd5WGFKZTAwbi9hZFFOTXBzbEtFS2t2TjlhWXBLRm5RQ0E4bG1Jb0Q5?=
 =?utf-8?B?VlU4NHMwUmFGQjJtSGxvR1dySHNzQTNrYnV6RzZhZHkyR2MrTElOOGI3dTRH?=
 =?utf-8?B?ZjlWWm1BdUoyaGhScjlPQkFienFSU3A2RXhicjNjUGdmL0J3ckJCdmxNa1RR?=
 =?utf-8?B?cE5OOXIvUGplaU5waktEZGF0aDVrR1NwTVJLQkJoODhTelBEU2pRL2c1UDVh?=
 =?utf-8?B?UDFsTitDZ1ZFWGFwcEZoMjViZ2FwN1dLM3pxY1cyRmxHZE9kS3hiUm9sRXlL?=
 =?utf-8?B?cmxDRG1jQ3IrRk9TQW83dDN0L01XY1BUVXVmbEpUNzdIUmJWWWsyZFhVZ1c0?=
 =?utf-8?B?c1ZCMFAvSFQyb0tiWmlGL1ZZMjloNmxwTEJELy80ZEdUWUNmczN1WUZVclVH?=
 =?utf-8?B?Lzh0ZFU0aGtKK0lBbWY5U2hIWHBpNUZmNXdwWmpPL0R1dzNVVWxteFZiSngy?=
 =?utf-8?B?ZjlTMElXdDdQcVA3OUdsM080YTBUWm1XeW9oVzZZUmVjSkxrRHRXRVd5NHA2?=
 =?utf-8?B?UDJpR2lKb0NSNloybVA1OWxyeXh1VFZOeEdCRHJKNC9MVmRWeDJCcXZ0NnBh?=
 =?utf-8?B?cmxFSnNkQmJBWHVxOEZpU0VWWDF6RitSZXBFYVRnbjZGYmx0akcxRnhNVEJn?=
 =?utf-8?B?eTBHTjQ2c1dLbTF1ZWEyNGdVYy95citBR3VjUTJycDRtY2pRamtBOXdHT05z?=
 =?utf-8?B?NS9iMTJMVDl5ZlUxV2lDd3J3K0Z3ajRRRDdYcEVwZVVOUWxvNVJzZjNyNkFi?=
 =?utf-8?B?c3h5cHFoRm1uRlVoeGZVdmpOeXgvT1E4eXgzTHhvMGJBSmxSQk1FcHNRRTJu?=
 =?utf-8?B?dWM0bTVZa1Y2UTVGcEpXQTluV1ZtTEVPaGRrVDJvMlAzY09Wc1RWa25nS2wr?=
 =?utf-8?B?T1p6eVozbG9TK2pWSmM1YS9ocEt0YUJ2eExvVEcvM0NnYTkwYW9Dbmludzhy?=
 =?utf-8?B?bGFFbis1RVFzeUg0QjZSTWUvWmFLeEoyamxFME5Ta0FQdkd5eVJDN2hYeDF5?=
 =?utf-8?Q?7vjpKi/blTw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3dJQ1JDUXpDTGFKV0t2V09YbHZnRDc2TmNIRkh0cFpnTGErVSs2aHYzbmY2?=
 =?utf-8?B?SVgrSjZzRlZDMDE5K0Q4MklOVy85MFREMm9QcitZKzQxamRhWWJ6eXhIdkdZ?=
 =?utf-8?B?SGlKNGNFdkFNVkYzRGUrWTF4eVVGVmcyQkhNNi9pT0hZbVhXaGx1L1JvTlZK?=
 =?utf-8?B?MHBJK1B4OXVxWmhXTlNZY1REY2ZMVjZFRzN2VjgxcS81a2pDaC9HTUIwcG5r?=
 =?utf-8?B?S29QNyt0eTZpKytaYlpWOGZBMWppVXFuQXpRSEw0blBxUlZidjlvWUpKUjZy?=
 =?utf-8?B?Q0lTRHB3TGRSMVRPMGtnTHU2VHRuRFJwalROWXhjZjIzeTVjRmZkVXU0SnY0?=
 =?utf-8?B?ZmJCNHprM3NaMExCLzRxc0lVMi82NFJCQUREME5ZZjJOZkhmSHkyWnExTzZB?=
 =?utf-8?B?bEVkNERMc1QvUk9razh3a0pKUWpRU0t2Tm0vcDU2K0hkeXFKYWlMNjJTcS9J?=
 =?utf-8?B?bWc0a1NmdzhJQmtTVytxOE9EaGtUaG5peTZBSHk4Z0VZQ2VaZG5PdDcxQllI?=
 =?utf-8?B?NjBvMXNwSk9Qc21HVUxKNDE3REY1ZkhQZ1VxQXdyY0NZb2E0S2R5VlBhRW1P?=
 =?utf-8?B?U3owNHFEMUFaQmJ4bThnMUpMblJJVU1xbG9TQUhIanpVS1ljSEVWdGE2UUlj?=
 =?utf-8?B?NUFVMDZnQksxMWFVckFvT0hWSjFsVUoybzJVWjJMQjVkRDJHbDNXZVJDd0NM?=
 =?utf-8?B?SUlRTDBCWS9kRytSdFR2MkpyeDVBUktLTXlYOHptSGhNUUNtMUlPR2tqa1ZU?=
 =?utf-8?B?UUVFZHE0YjBpUDNXQU9ZTk5VOFJuYVZscHdTNXN5aW1ESzI1dGs5SVVSS3dL?=
 =?utf-8?B?MTRGaDNrVkxkZ0UyaDUvTytFZGtZK0VpeU9ZUEhLblJQTTBONS9PTGhvOFBM?=
 =?utf-8?B?a3Bhek14VkY1amNYemVDUCsyUHNtdlFxdUlNQ0RnckZwQStNN1grQjVUbDZa?=
 =?utf-8?B?TFVmWmFyUldYUVhaM09qSjI5OWZ5akZpN1cvQ25XRTNPeWdSR2gvUzlPRkQ5?=
 =?utf-8?B?am5lOVVzaXpHMEJHb0hKLzhJUEFNZkFxSTRocHVGcmhxS09lVHhydW9uZVMx?=
 =?utf-8?B?UlRPc01vYzFYaHB1b1J2NVhiaVkxb1k3TmV5c2h2YzN3aFloVXppaDhrUXRk?=
 =?utf-8?B?QnNyUHdDa2VpRTBTanFBTTBOZkJtUTV1VWxuTCtldXY3YjkzTkVTUm44OFd4?=
 =?utf-8?B?M2FJZXlMcEQydjZmZEFhTHNNTzJXNHg4anVPYjNmS0lITkRUYkRadTFzYk9F?=
 =?utf-8?B?Ti9OMjJEWEVBeVF1VjhNNFMrcFptL1NrL2s3N0RMOFJGdHJrUnI5aDRvRmRj?=
 =?utf-8?B?RGtHMHZpTllSUDJZS2JKQ0xaWnFvOUlsUjg4OGJIRVNMMUhEdVFHZWZBNTRz?=
 =?utf-8?B?U2I5MHVHV1R6UlhoZmRETGxFRWtBWFNMMHF0dlYwaHBtbm9aZnNCZDI2NUZl?=
 =?utf-8?B?ckFSQzdnb1RONTY0Rmx4bGNhbGFXT1VoNkJxZ2VQU2svaG9zRG5ZT3YyaTJi?=
 =?utf-8?B?UisrUlhuNXgxSXpDaG5zT29pc3BrMHJMRGdhNCs3UXVRZmMwT1hpeWJuR2d2?=
 =?utf-8?B?MzZIb1VmM2JtU2lwZ0Erbk4zNWtkSjltMFh0WjlTNjEyZUxyNGtRNUF2M2ZQ?=
 =?utf-8?B?TlRCTlM1YURyTkllOGtKUnZSUy9kdVFpS3VCc3VxQ1AwYkRoQ2FPK3RYMk1Q?=
 =?utf-8?B?SG03Tit1bHU3Y2c3dUFZbEZSV2ZFSDJOd1hKZWtGamZwNjlEMS8rMW5taG8v?=
 =?utf-8?B?V0J1V3NpYVNMc2Y4a1FUVWhzZGVKLzhmM2R3ZzdTalpOTHNmc1h3WnRlclZo?=
 =?utf-8?B?VlVJUi85bU9iY2N3Q0Q2QzlQcUFIL3Jmc1BZUzFYR2dLSkRaY2U5a2hObUxq?=
 =?utf-8?B?VFRyM2VXNGR1VHRMRzg1Rzk4NE5WTmoyMllKTGM3NzBENERFcnc3TEpVUjly?=
 =?utf-8?B?VzR2MlcwclM3NzNvTmFhVUpOcEYyZ0tCdkZZTm5NeUpac25wYm55M1U0ZWNJ?=
 =?utf-8?B?SGxMTkw0OEZObCtScUVuMEk1a1ZYNnV0a01LaWtzYXRCYlVhRmRWYWYyK1Rx?=
 =?utf-8?B?amRZaGxpa3kvQ3NzQTlCaHA4MVpGSXJFTTFLcE1oczNvaG5UOWdkRFJKWXI2?=
 =?utf-8?Q?si24=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f330ab0-311f-46c6-81e1-08ddc934124e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 15:26:04.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lVUwYOcJEZTES8/1VrH4TZwew8xo8ABk6TyVi5+CbkL3tYBa+fAT5Bqcm6hHU8ga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074

Hi Reinette,

On 7/22/25 09:56, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/22/25 7:23 AM, Moger, Babu wrote:
>> Hi Reinette,
>>
>>
>> On 7/17/25 22:51, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/8/25 3:17 PM, Babu Moger wrote:
>>>> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
>>>> to account for overflow. This adjustment is common to both
>>>
>>> The portion factored out does not just handle MBM overflow counts but also
>>> handles counter scaling for *all* events, including cache occupancy.
>>
>> Yes. Got it. thanks
>>
>>>
>>>> resctrl_arch_rmid_read() and resctrl_arch_cntr_read().
>>>>
>>>> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
>>>> this logic into a new function called mbm_corrected_val().
>>>
>>> This thus cannot be made specific to MBM. More accurate may be
>>> get_corrected_val().
>>
>> Sure.
>>
>> Rephrased the changelog.
>>
>> x86/resctrl: Refactor resctrl_arch_rmid_read()
>>
>> resctrl_arch_rmid_read() modifies the value obtained from MSR_IA32_QM_CTR
> 
> "modifies" -> "adjusts"?

Sure.

> 
>> to account for the overflow for MBM events and apply counter scaling for
>> all the events. This logic is common to both resctrl_arch_rmid_read() and
>> resctrl_arch_cntr_read().
> 
> This may not be obvious since resctrl_arch_cntr_read() does not exist at this
> point in the series. Perhaps just make it a bit higher level, for example:
> "This logic is common to both reading an RMID and reading a hardware counter
> directly."
> 
Sure.

>>
>> To prepare for the implementation of resctrl_arch_cntr_read(), refactor
>> this logic into a new function called get_corrected_val().
> 
> No need for "function" when using (). Could be :
> "Refactor the hardware value adjustment logic into get_corrected_val() to
> prepare for support of reading a hardware counter."?
> 

Sure

-- 
Thanks
Babu Moger

