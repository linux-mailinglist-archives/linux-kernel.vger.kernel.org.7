Return-Path: <linux-kernel+bounces-752255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621B5B1730C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8865B581779
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E5D13C9A6;
	Thu, 31 Jul 2025 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5esVpAGz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE878C91;
	Thu, 31 Jul 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971479; cv=fail; b=cjiJeLqNVzHmqfAn+lNhe/S01UPFf4zvJbDre+G8dN94n82Azhr4cw4AAvnoMIs8fNDuew8Gep0AQYTqxH38DwxudyOwsLBgL536HJOcS2W/DHbFDVy+e38kHann2uPKA6JCSLiK9lN8It9ikZZFwPHkL/LgwCv2TyAzFjYsczU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971479; c=relaxed/simple;
	bh=atoNN2wA9CU/LU5N73jCplAuIRN0WcrIo3w0t+N+Pg4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MAV61UY9hB1wmYfMkGls0UsfNHglRDsNcOQT0ORcvgKllj8C6m2tduvtYZ2lBYRFqnS6qmfvwSSNaHwDsCn3aF/WWsbdNW8SRnFTGSa6sw0vCpbrciP46Ege5yZ15+wPGnzAYs5hBDWrTGsxVita3n5w2sjPufNrjFteCcNzCK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5esVpAGz; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wdsbp0K9pnHUE6+qWthk9zG7JTELuVxmkd+OoVW0t0AB/pH81XYetQuxg9n7TjSGozXG6wBa4Bs3jvXmPUNlbEVmN1Wjk3ILwtMM9+1tE6rr3ViIuZ50D/VWMLI3xAt+EDxDmpWOnAAPpTdijbxdgJU5mB6zCVrE2dFSKDrdu1KPOnP/KV+XOYsM8IE0F7Cnwfsrnw2SieX+JP67cwPBmdOKdEWihlRQ5DS5BF3rBfdde8EY+tWnep+m+76fGrQuHbI0Pg8bepS5MVB5rwAViJiEFsdW9BPRXpt+1dyN4fc49Y6XZPhu37c6VP5PPkduRxJiefh6oXC0AdwT4BVvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqff3Wu4ulzZ9IADFSqUkiAnR5cAHVAsepHDR1vsuGs=;
 b=qnQM+8JRQ4ig1IWmpLD9780h6pNJM1nDMpU6Lqb28a6yIsNAmI1sAMA3WGV1Z0zZdrZq8q+2UYNsnacLU68PmdAPQr/kyIMJ8048PMj2wnOt+4KnooAPZEGtuOwIwjp6XS+LWcAObnD2aEqDKOFX1oivWVo3U5mlNFoBcx6NY0SxHgdeYmCOYxN+3wAd1HixPqaEnlE1IQOhlBTBNzlEOpQlx1lETMTwaIgHptSaTACAgUFn2Zxt4UvKqGVo2Lh7TU2JcMmGSbYbWWwP+CyfnDk1ZKQbz1Anz36/Q1XYKvMNPYk0+eZZuU104LzbJJ+r2qNdlZ3qgRTt2rXVPJgKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqff3Wu4ulzZ9IADFSqUkiAnR5cAHVAsepHDR1vsuGs=;
 b=5esVpAGzj214+KEE2VcsVWgS0V2N3wBtszHrC5RMHIoPuscIo31tG8dzeDebaBTKNY0j2p3xL605BXGd+mPEsG2GU2FwRdTeesR3m2f6Z4+hYbtuPbjH9leCYLWkyAwzDj2ELePokSGYXWfhCQQMjfpkdJwbY3Xcyj1S9yThzLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by IA0PR12MB7628.namprd12.prod.outlook.com
 (2603:10b6:208:436::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 14:17:55 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 14:17:48 +0000
Message-ID: <85069db7-63bb-40a2-bd03-0fe7e2e82d4f@amd.com>
Date: Thu, 31 Jul 2025 09:17:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/34] x86,fs/resctrl: Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
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
References: <cover.1753467772.git.babu.moger@amd.com>
 <a259ff37-9e3e-4b4f-970f-04610c35f4cf@intel.com>
 <1a916a0a-66da-455b-9b09-4eae42e6eb1c@amd.com>
 <eaa518e8-2864-4b6a-91a0-4b92b5acc777@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <eaa518e8-2864-4b6a-91a0-4b92b5acc777@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0035.prod.exchangelabs.com (2603:10b6:805:b6::48)
 To IA0PPF9A76BB3A6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 66783869-c6be-4d2d-a902-08ddd03d06e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUZhaTJrNGtzeitVd2tjMW51SnBjYStKeEx3R0VFOTEvUGRkb1dUVXp0eGxa?=
 =?utf-8?B?SDhrWkx0YTlXV0ZKN0dOTU9UY3g0OGg1bzcvemdUUTJPWWU1UHgxZkI5TTB5?=
 =?utf-8?B?ejhZa3NaSW56R2JvS3hNeHlvUXhDT1ZBeElDLzd3ZHpVZXgvekN5dklpNkZ2?=
 =?utf-8?B?QTJsMisyMFFJVTNhdW1ySlRlREJXVGMvY0c5a1FjcSt2ckN0MGJTQVFIRTBK?=
 =?utf-8?B?Z01PVmZDanA4UUFUSzQ5Q0FHV2Y3YnNjNmJjNGQ5Vm9NdHRKRHYvczh5L1Qw?=
 =?utf-8?B?ditBU1dqYVdmT0hjbzBjNkRORVFjQlBBOGhjQkx1WkNJNUM0cW9ZMTdnaSs5?=
 =?utf-8?B?cENTZFpsSWhxNUVPblBBNGoxa3FhSTdhU3JSQUVISlhuU2NnNHpidEZUNkZK?=
 =?utf-8?B?dkltZ2dVdU1SWlI1T1o2NUcrL3ZYVkNOc3RlZ2ZHTmRJc21TeDVNQXdqTFlI?=
 =?utf-8?B?bnVqZFI3SExET3dnbFdvN1NSYUhwTHI5bUFWT3VKU2FZeXFSZ29Zdjlrc3hk?=
 =?utf-8?B?eWJWd0orT21zMlR0UlBWU1ZOWXJNMDNFby9MT3kybFFHNzVBOEQwVVpVek5L?=
 =?utf-8?B?MGFJVE84Yjk1SVh2MGRwZThrdHNIT096WmdnTzZZVzFYRHpxZm40a2RWYzR6?=
 =?utf-8?B?MkMvTkdZWmRNa0JManNteFEvR0lUVkw3RnI0eGRob0svaENzenBUbjNjOUVB?=
 =?utf-8?B?YkZxTXpFeEdXU1lRaUNKT0ZjUG1KTmVoamFYMVNGOFBHVkRIcWQxa3lRZlQz?=
 =?utf-8?B?Z3ZqOHR1MUlPTjNLMnZuQ25FeEljVWU5dXJuQlhVd3RpUG9kbm5uV2l2L05w?=
 =?utf-8?B?RXFib3hyaTBwNnVLNHhObldBcVRacWVXK2diMGpJZjFhVTN1RE1GK3pBNUM3?=
 =?utf-8?B?UFdEUkJrWlZ0SkxmQ1lYWEtwdkxKS2J3Ym9LQlVEWGV2RVhjVVJ6YjBzL1lZ?=
 =?utf-8?B?cTJYc1lwOXZKZVNSTC9qRVF5YUVweS9iSzZsby9FMkZUbnFDZFBQYTZYQmJV?=
 =?utf-8?B?Qk0zM2dwc2VZWHFBV0VBZWNYQWErSXFMRGNYNm5OUWszMVh5Yy9WamJ3Qk5J?=
 =?utf-8?B?emNNcE9mdnYwakYySkhRUmRsRDIyMHA2NDg4bzdZWEJyWW9qR3hFcElPV1Z3?=
 =?utf-8?B?NnptOEM0MnpiZ3NTaTMzWWl3QlVSRFdjdVVKenVUb3ppQnNqbys1bmppQlJo?=
 =?utf-8?B?d1Q3MVpwbUpPRXZtZzQ4YnBlMHlQUnBRRXVEZnRYYUFod01tZklYWW54akZ3?=
 =?utf-8?B?bHJ4aE9mZGY3ZHBEUmdQQUNPK1dhQWdKVUYrc3orMjJRSWNmSWNWWWk4ZkhX?=
 =?utf-8?B?VDkwVmdUb3JQRWR0Sm5RQ0pvVDdHd1JveERZTXF4czhRWnl3eHdaMHRkK3Jh?=
 =?utf-8?B?eEt3aC9WVlUwdjlCVzhUcnl4cFFDTndkSHRJZ0EwTEZYdGNPUXg2Ym1mcXI0?=
 =?utf-8?B?anNxUk9rYWpyM3dUNlVQWFVKNmptOEZld2t5TnYyR2xLR3JqeVVrM1BmQTcv?=
 =?utf-8?B?a1pqcDhNWHFNY1ZrSTRzaVlUaXBLVVlQWng2WUpvTUMwWjFkVGpmUTNlVnBj?=
 =?utf-8?B?Yi9POUJNZytMTVVHYXd5N2RDQ3E5OXUrSWZrMUJMRkR4aUlOZ1A3VkRrdDBz?=
 =?utf-8?B?WXFpWCs0T1VwVGNZZE1QeVI3SEdTNXAwc1RNT01zWE95Z0h0Wmk2YkRvdits?=
 =?utf-8?B?eU9JcGtrUEF3RkUveDFxOXZvWm9aUzdCWThnemcwc3RCeGNTbUZIa241YkNn?=
 =?utf-8?B?WnNMcGRVYlZnY3pZeVNUbHNucjVsQ2hkMnhOaW9UcHJwM3MwM3laS0JWYlJN?=
 =?utf-8?B?RFdBVXQ4ejJiNGRSaWt4VE5rMG9TVmlWVWwyRklDRGQrbGZFVmU4SmVmMjIw?=
 =?utf-8?B?aVpKbVpxaGhNbU9GSVdDNDdJYkZxM2lpU2pNc0JSRERTSi94UWZMYk1vVjdW?=
 =?utf-8?Q?yPNH+436UcY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti9ZYXQ0aEk4V01rQmFERGplRW9QdlRWZC9PQ3VZVGVVNXpGU1NFL3h0Ui8y?=
 =?utf-8?B?OEhxMllEUUVjYWtzR3JHVWpQK05GR21SaWJKU3dGZEQ4ZGRoL0xKN3lCbFlk?=
 =?utf-8?B?NmVDWDV1TFlZODlpMkJOak0wQ2x0aTJLeFFQUGZVUFlXVm5MRW1FOXFzcjR4?=
 =?utf-8?B?Ri9Ud1RUeno0TWRNcVBnVXVkdmtmYnZOTW5IUlFLMExkdmp2U3d3TndKZWZt?=
 =?utf-8?B?dFJSUlUzRERsekVIbDJtdXVsNDRTVGZuYkxpVHpoNHl6dDA4ZS9hRmk0b3Jy?=
 =?utf-8?B?L0J0UGxRRkVhSm0xSk0rZE82dW42ZHdCTG44YkVnSEZOY3doK2tGakwvREt1?=
 =?utf-8?B?ZE5PT1lmZVBjR1BQOFFkb2ZsaFdtcGR2cnNlTXhnOVhvOEFVeEN3ZDlpa0Y0?=
 =?utf-8?B?dGZ2Nlg3UmZGMWlxdDZQNit2OTFtVGx6V3NBSUQ2SzZGMTR2QStSOG5WZHZa?=
 =?utf-8?B?cjlVUjY1WU1kOVBGdzkwMFgyNDkwK3lic3o3ck9UdG85cTlJV0kwaCtza1Vp?=
 =?utf-8?B?Ykx6M3JBekdyVTZINXpjdnpKV0I2aHFDVEtJem5UUENIb3o2UnZla2FqK3Aw?=
 =?utf-8?B?cTA4eSttQlFWM0dtZmVWK2p3L3JNSmdreGhoQXVqRkFPUkV5QnkzZkY0R0Zw?=
 =?utf-8?B?SitzL1ZPSzJjQzUxbkUxRkdYcTFPdkNqMVlaS0N2Qm5BeWdpSXptMWUvZVc0?=
 =?utf-8?B?RXhLWCtSQUZQcUFjUUJKd25mR2ZvTjZjZ25UNm9iTmZYdk1qTW1udThVd25D?=
 =?utf-8?B?b29nVm1NcTBpV3IxR2Vlc2cwMVQwYmlFNFlqVFVzclZtOE16N3l6UysvR1pQ?=
 =?utf-8?B?NDRZWlBnWjZaR2VlVFYyMit2YnZIQTMrSUFSRTVuQW1GYU16UkpDTlJ0a01M?=
 =?utf-8?B?ZnoyNEtiNXZUY3NBSDhqNWI2VkRGSjBIcVozYWo3d1ZmZ3lSKzUwK2V3QjV0?=
 =?utf-8?B?Y08xYmlQVURwaHo4dmhvOXYrUjVGQzd3S3BzRVpxKzlQK0g5TkJRakhZOFBM?=
 =?utf-8?B?c0Z4OGtRbVd4NzBJek8rZGg3SFJxbHBOcnNRNW9BbDZZcUFxMUljR2F3b0Jq?=
 =?utf-8?B?SFRNNUlJNXVoZ25vZnZFdnJENGpSWnpnY0xyV1l5MFl5dURYdmxiMm92anhV?=
 =?utf-8?B?ZEMwd2RRN1RPUnptWEMrT3pDdTZkcDhhK1VpcTdrOXlFN2xReXB6aVVqTHF0?=
 =?utf-8?B?bzlxMTF5aDdidEpSSHphZ1N5U2kwVW5Walk2dTNJRVhFY3ZxR29yeGVMR05I?=
 =?utf-8?B?Rmc3ZW5KaTRQK0hRdDlGdUljb2M4bENQNW9NWE1mYUZxSmhtenl1YVplNHpt?=
 =?utf-8?B?RExEYUJhdE9Ma1ZwMHRtRHkxcjdnRVBHR29pNDUxa05rQ3NkV2tYYUtWK1Fn?=
 =?utf-8?B?U0N3N0I2STEyb0Q5ZUdMYzVjWFNoVWVxNnFQMjRtRytHRVpONElXd3RCMnFZ?=
 =?utf-8?B?VVFMa2ppaERacm0vb3hYekw0Zmpyd0ZoK2VSODlmTEZqSUd4STlkTDhvV2NG?=
 =?utf-8?B?VzY3VmpVTlhVQjlkbmszVHFRanJiaXBaZ3JGZklNUHlyOEQ0NUVnV1AyekJF?=
 =?utf-8?B?N2NwekNBdGlxZllsOGtpVGZZU3VyMmNydENvMzZubWQzVEFOYlg1T0lQaFhw?=
 =?utf-8?B?TTBCdmRlYzgwcC96TTh2MW9PWE9oOUdnQ1E4QVlLeW1sc0hoNXF3Qnh0RW1s?=
 =?utf-8?B?MlNiK3R0V1BQejQvTHhRZ0g1VVU4bURZVlhOcmIxeXFHSy91UjNYdWZabjJO?=
 =?utf-8?B?N0dhOVFNQXM1TFpKYmpsWGlCMnZmVXZsL1Zub2R4Q0EvZWtWMThpZ3E0S2xn?=
 =?utf-8?B?ZU1OVmJLRU02YWRwVldjbXNlTHhQSHRtVjY3VTU5RzB0UktiL09nV3BrWWl2?=
 =?utf-8?B?TWZ5ZTgzbkZhVWFXUTFBRDl2YUM2eXFjajUvV1ZFVkVTdit2bm8wMWpDK2Nu?=
 =?utf-8?B?UHZsNWN4eHdpS05ac3FuTmE0YkZkeDY4b2tzRWEySk00TGNKYWcybmhoT2Mz?=
 =?utf-8?B?YkRoaE1KNFJENndiTDVqYXQ5REtUUnYwTGxGWUdMUEo0bnZuRHNrajczajFN?=
 =?utf-8?B?ZFRhakNlN2prQlA1QmxvbFVSNk14UG9QNHJIR3VhbExDc1BEK1VTRDVRSUNZ?=
 =?utf-8?Q?P3svvx/FJVBNNl9JOpq362+Yo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66783869-c6be-4d2d-a902-08ddd03d06e7
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:17:48.5530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYSLYPSB3WSmogAhhYduC9uqNv+90FGU/YbN1f9ncdBMJx/KiT6LvEftZI3L8xyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628

Hi Reinette,

On 7/30/2025 6:57 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/30/25 4:31 PM, Moger, Babu wrote:
>> Hi Reinette,,
>>
>> On 7/30/2025 2:47 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 7/25/25 11:29 AM, Babu Moger wrote:
>>>> i. Change the event configuration for mbm_local_bytes.
>>>>
>>>>      # echo "local_reads, local_non_temporal_writes, local_reads_slow_memory, remote_reads" >
>>>>      /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>
>>>>      # cat /sys/fs/resctrl/info/L3_MON/counter_configs/mbm_local_bytes/event_filter
>>>>      local_reads,local_non_temporal_writes,local_reads_slow_memory,remote_reads
>>>
>>> Above are some more "counter_configs" stragglers.
>>
>> Yea. Sure. Missed that.
>>
>>>
>>> Also, while considering our exchange in [1], I encountered quite a few functions doing
>>> counter management work for which I believe monitor.c would be more appropriate. Centralizing
>>> MBM counter management code to monitor.c was something that you planned for this version
>>> so I may be missing why you decided to keep some of these functions in rdtgroup.c? I
>>> highlighted these functions as I noticed them.
>>>
>>
>> I looked at them. Most of the functions you mentioned are directly referenced in res_common_files[] (show or write) and some of them are even named as rdtgroup_<>. So, was not sure about moving them.
> 
> If you prefer a precedent you can compare with rdtgroup_schemata_write()/rdtgroup_schemata_show()
> that is directly referenced in res_common_files[] while the implementation can be found in
> ctrlmondata.c that is intended to contain the "Cache allocation code".
> 
> I assumed we agreed on this since I specifically highlighted the topic of the handlers in [1] and you
> responded to referring to the handler event_filter_show() and mentioned that you plan to consider the
> others. This version thus looks different from what I thought we agreed on :/

Looks like I misunderstood few things here.  Will take care of it in 
next revision.

Thanks
Babu

> 
>> Sure, I will move them one by one to monitor.c
> 
> [1] https://lore.kernel.org/lkml/0fa9a12b-e900-4ceb-b59c-e653ec3db0ca@intel.com/
> 


