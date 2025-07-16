Return-Path: <linux-kernel+bounces-733586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38AB076A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BFD4E4750
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126642F50B8;
	Wed, 16 Jul 2025 13:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tdBlO81r"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F82F363F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671399; cv=fail; b=NFgX7sXF5wtBfFnBmoYqtLtIa2InQI1eNNWwto1VFK+yfYSYd6fb/d1TqVKfmIBRwh3MfK0OS16RVH7iUVzR0RnTWhKfBkwe5ZpVrMFMoeeD9Ku7ePJAz4GjFBC/ZPEaBdVN+lEW/EI8dxUZCJ9/exjsAlhdj4AQ4kFCnZA+ugk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671399; c=relaxed/simple;
	bh=1O8ufKu6jwJufC/wN5f7xRNLd+96lITCKcT2NvwfPX0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=gq3xUn9Pu90T9T0/gJjFKzLEMvYG+rLINARVcAG3dVvlHDMBFJ83A4kGwtDR6V/4VeujF3Ni/IxbzyMXO6CqQuR5m4MYREewUtU5ZJSFrKoZ1I9qCyyGhaAasJkDH9/8vbhthuIgGGkWjhWd5Ie2iBM7uOgDSmAN0UJQ2xVDKq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tdBlO81r; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na/BUCI8nqopHuNxdR3+c77r2ZVQgEb262zKiFXsWrgu2+r0DUq1gPPh0JNTbl08hy8WZ+mx2xdjkSbdxJcXGCuMR8ghJccq+CMuXRYX1u82AWccrATLCo09dAVefi3vsjMV2CtbCnIYV4MzDTirlYrmi58qZvTR139eLw1KdUvEemqJZIg2jjkyRZyOd7nArKL6mXogSUCL56nfr4TzC6mh2nekEIDmixNyxRPIRlmAWe/1m9r7HJ2WkrguM93ufWHTgKTlWYjApJsfN9+vglwmNYgEgoYQwW/2RQXLh6pgKKIknsAYomxYGzYff6fsSlJglGzp1d81PV0wT2mjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLBmmwy7kty0U9YXB7TcyOruyv7J7AoI1IVMb7llGBQ=;
 b=axx+PMTTcbVnxyOUVD4ChitrZFsaZ0JW91qvhZhsSHkh06ZWkFatfwStExn56yAnqXJq7s+il0r73X8cDw0ooAdcr9Nnz5O2KSH2Q/rqnW47kESly7MI2jnPbUEhfbC+w5bIUdvMfTH3CXGtTRirZbUEf6cN4rkgaIc55SVtl3C2fCsxtlyP/xmg3ufED5EuLoDdj9dhMkExNFT2CUVoVNTCJcKhPUuO9Ce2WYdT386MRcwdzAHobf5ziB+jT18mHng1z5lNZAoksEmRzNfX3TqSr2HzRW6Sj70KBfW61Tx4qw6F1YJJ32YN7oWZeSGKBv1rcXIPckaPdBbTC35AHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLBmmwy7kty0U9YXB7TcyOruyv7J7AoI1IVMb7llGBQ=;
 b=tdBlO81rq6KkdACUQhKrHuI7lEoC+biF9ShA/B5n+LiwYRoz6pWpTJfjAiknCGgsmHCLLTYNRNe36BvcyBP4BH/+cPTX3V4xfHBlaQBTYcS1e4WMzOcuNa4vfG4cq5Ss6eKa147YtNMubq7JIkRm8rwd16V512orvB8/zn2jlh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 13:09:53 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 13:09:52 +0000
Message-ID: <229325e8-a461-6e5c-0d32-1c36086b62f7@amd.com>
Date: Wed, 16 Jul 2025 08:09:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
 bp@alien8.de, x86@kernel.org
Cc: seanjc@google.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, santosh.shukla@amd.com
References: <20250716055315.2229037-1-nikunj@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2] x86/sev: Improve handling of writes to intercepted TSC
 MSRs
In-Reply-To: <20250716055315.2229037-1-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 9945cfed-8332-46e3-c609-08ddc46a0d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDBIQlNaRG1GUG9wMHQ2bHpEYkUvTW1tNTZvaVMxODU5aUJ3UmlESllhYU91?=
 =?utf-8?B?Z1pqVmNRdGJaV2JJYUNDRmZrdU13S0NHWmdDU3lJY21DT2s0bVQxYldKb3Z2?=
 =?utf-8?B?U3phNDJnUDV6Y3NqVkYwVWlTN3RVd0dFMjNiUkN4Qm5ZLzhmakQwYXprQmx3?=
 =?utf-8?B?WE1mcm9uZlE4R0syYnF0eXU3elpJVUMwQ01DczY5S0VKQ2tYMDhNcnBWUzlL?=
 =?utf-8?B?NHh3dEhlVXRPL1R3VlNtN3FMOWhwYnovTjJyRHRqVDRKc0tJRG9tWjRpSVhv?=
 =?utf-8?B?eFlGMXo1eHlSa2ZLclBWOTJrMVMxaXZLZlR4UmhvdnlkRmVIOURJS2lINExB?=
 =?utf-8?B?WWdyLzlEZjFwRWdnaU1ZTmU2eWhvUXZKTUFvUVRNVVc2Qzg5QjRuUjY0WkJy?=
 =?utf-8?B?MWVZanhVWlh4am5PZkl3NG5qMHBIR0s4MENSREFZbDFxbzJSWDhTYzB2UERC?=
 =?utf-8?B?YVRTSnYrZnZEQU4zeHAySllSVVhTRjdlbDVXbUo1UWV1UzQrLzVneDBUNU9m?=
 =?utf-8?B?d25zWFJ1U3c0ZXVqZXBvVFpNczNYSk9lbDlDUHR5Vm9QKzAzYUxMNmFnRHVE?=
 =?utf-8?B?VG1oZ1lnTFBMNE8xL290L3BoTmJ0Unk5S2s1a0Y0aCt0MVRlNk5OOGRya1RT?=
 =?utf-8?B?bUFWWktKbG05VDZsU2RXRjNIeDJ1NEVQODVUcnRudFBpeGZMT3h0VmZsZmRm?=
 =?utf-8?B?dVl6dVllNDE5d3RTSFE5Z0c4cy9jUmZMeUhUdWxxZFQ4emZSQnBqZlEzejEz?=
 =?utf-8?B?K2xxc0U0dkdrS3lQZGpFU1VMUU1YTG4rTUJoTjJnUlpxcjN0aitjT0grQmI0?=
 =?utf-8?B?bVJUSFlUMTJ6eC9mSEdIVWUzenFwRXQxUEtLZDdGOVVkS0tOZjRqL2FPVGVw?=
 =?utf-8?B?SjVBellXN0FjOUc1anJ3Q3I5Z0gxUXBmTStyeHJMcEhPSExXQjNmZjNMdGlC?=
 =?utf-8?B?dzNmWWtlYmJYRU5Kell3QmU2Z0NTN0NjSWNCS21mQTdwQ0RXMUlpYUUxdlNo?=
 =?utf-8?B?MDR3TjhOVlpubkpDaTM5MWNEdFNZVVI1MERKT1BuRVlTMFVScGJGWndTK2NH?=
 =?utf-8?B?MENUUEVqbXVwMWg5U0pxdUFZQVdaTnhMVHNyL1VaeFBjOURMUzRqN3I1dm9p?=
 =?utf-8?B?WXFnVG1URnZkaHFtdUM2N2tGUEZBWUJzR1VITTJNYVRHbUhiYy9KaVdrOTI3?=
 =?utf-8?B?Vmx2V1haaUgweFl3OW9jbkJnUFZyYzZPZjR0ZFpNbDU2M0xuSHpkVmkxczV6?=
 =?utf-8?B?WStGWXBpaFRCcDdDL3lHNnZJMjcvTkZ3dmtZZnFmbnFVd1djUkFUd2ovRHll?=
 =?utf-8?B?TGQ3b0hFQzg1ZVczK1M3b1VUN3IxcHV6d0wySDdFSCs4NWpVR0hqOWJUcGZ5?=
 =?utf-8?B?dVBDRks2VldiVzlOWCtCdXhKNVNoU1I2Y2dlUnpaRGpLWFluRVhKMEhGai9T?=
 =?utf-8?B?SjA5N2VPTVVIcTJjdnVJZjBPSmRNVFpyeXB6c2dtQ0F2RDRHVXNxNTl2Qm9v?=
 =?utf-8?B?a3JWMEx6Y0M5My9FUkora2FrM0ZXNXI1WksrT1dvTldHZzFWNnVIM2NNM0Nv?=
 =?utf-8?B?bWFaeTZwM1BEdFNYZFpaTFZjeVhCYXh3Vms3ZkxkMGM5cGFpWVVVRlIyQTAz?=
 =?utf-8?B?TW94dDVQSmZjM2JhQ1NMd3NVVnJuSUtoMUYyM1lRc2daSDBaWWxhU3dJTlJp?=
 =?utf-8?B?SElZa1ZkL2dOVFhYd2tyVjdLOVpVbWx6dGZFK3ZEcFdkcE50OXphM1RCOVg2?=
 =?utf-8?B?RGlhNVF3SDNhM0orR3hqMThkTFg4M21aYnJ3Zk51MnVHZkRMdXFmMmFZUkNM?=
 =?utf-8?B?aDVqejFqRVhKNld2NEtucTBYSHBiL3RxL3FnalJOZ0ZMZSsxODZOVy9DTVVI?=
 =?utf-8?B?amNSamhpSk0ySWtkR1FuWFNPYzJ2bEIzTmlyMDhxTmRjRGVnbEZxNkUyUFJE?=
 =?utf-8?Q?/i3FjV3ayLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXQxV296UmZpRFY2T09VWGtJb2tEVzZ1QjBCUysySlUzMmg0bEFDTjFNWjFP?=
 =?utf-8?B?ZHVNc0tvSlQ5T3huK1lrbHpMNHgzR1RuWWIwU0x1RC83ampicEFJTG1PcXc2?=
 =?utf-8?B?ZHVUZHlTeWpVK2ZQc3BQMnBGRDFKL1RjVElLQy9wb2NIbXVtdXFMc0tXR0Fi?=
 =?utf-8?B?Z0srSjNOQVZoWWVoaFBBRmhLWEdNcGl2QmdkSVFVaTgvc09makhwQUkxNFlL?=
 =?utf-8?B?Sktkdys1S1RGaFRidG5uQVZzVlVGRUszUFp2ZERQR2t6Qjh0VUttUzdDdWNa?=
 =?utf-8?B?MDg0Ny90RFNRY2R6VG85VWV2WTlRWWd4WE9xaUg0ZWM4KzUxeXdFbzIwR3FG?=
 =?utf-8?B?Rm5NRmI5b1pMaVJ1YzU1RjF4VnJocGhNOWlTSkRWVjNSNFlJcGo2bEpGUVFF?=
 =?utf-8?B?L1BBVHBIRmZ5K2xNRUxIWHV6Y3l3OENNenczL3RtOGNGWnlEam5BMnlSd1Iz?=
 =?utf-8?B?WkNQUUZjZDJRdW5aUXl1TUpTajRDRFdIdVhVSCtYVDIzVkFpN0N6NXNvT1VE?=
 =?utf-8?B?ck53cnBNc284QkU3YWdQcXNPeHVEUlFuR1BTa3UzWjFPTEhZUzg3MTJPUER1?=
 =?utf-8?B?QjlBVWNKckpySlZBZjVHa0Q5QjBaZTUyNFdsZk1Na0ZYRmh0dE4wblp3R2pI?=
 =?utf-8?B?aTNUWTcxRC9xUmplNnhnc05SWDdzTUp3eU00OFphUjM5M3NFcVhNR3ExRURr?=
 =?utf-8?B?cjM5UVIrcElqVE5kRktkVDFURXlGTWhjb3VmRy9BcUdhVjgvTVpHeURTK01N?=
 =?utf-8?B?SzdJSzNjVTE1YndwbUZ1Zm01TkRhUTVnK1gvMENFNkdVc0tKeGlYUU5ZbHBW?=
 =?utf-8?B?UGU5MEMvQXJ4NTdFS3BjRTloUW5nbHhxNUNua0dNWDB6WXpZRWgvdG5PQkhS?=
 =?utf-8?B?d01ZSVhZb29HVDVlem9mcTF6MmdZdVZFSThNQmJrQm1vV3ZjTS8zcm01L3dv?=
 =?utf-8?B?Q0Q4bmRyT1lJTzF5VmtXcExtenZoZEpnY2dLMjQxeG4zaTZPZ3dZZy9adUlD?=
 =?utf-8?B?ZkxzNEhDT2o3TGVMbENwNndRVXVWMkl4TFpwUHJEdXFKZkdkU2dxZElrZkZp?=
 =?utf-8?B?dGw5WTJScXduWmZ3WHhRdVMwbGNHVWs0d2dCOVV5eTJqbUprWU05cVQ2Z2Zp?=
 =?utf-8?B?aXZwVVkwNjFtQ2VXTENPK2Q1RXBCZTZWYVliVUxZUlJLQlFtSlcweEVORUJo?=
 =?utf-8?B?bHJqQ3c1akRRZVc1UFcrdHNWYmVIUWw2Nnc0WUw3Yk8weFMraUE3MFFmNm92?=
 =?utf-8?B?YzBsQXZGd1lSck1jbHFqVVhYTkNGZVVDV3JScHdKdmJwUEF4RFBCalBETkVq?=
 =?utf-8?B?Z1NzazlpVGN1OEE3WHFKd2dHN1V1b1J0VGNQcWlRUXR0YTFMdy9zSnFQT1lD?=
 =?utf-8?B?YW5VSURTVHVkakFnaGk0QnNybEN6ZUxGQ0d6S1ovK1hnUHphUnl0cnk1a2Yr?=
 =?utf-8?B?U055TFdIeDJtV0ZvUkxrbUZPVGJZTFVIQ3AwSHFxaG5PTXZYWk1HbXBReUk5?=
 =?utf-8?B?UitwclpwV1hVQ0FWWmlJYzAvck5kVEpNRXVEbk90VGZJTzNJdmJ5WTFBUGlH?=
 =?utf-8?B?dnc2UEFJSzVGaUxNdUVIYm1wb2QzR3VEeHBLZ0pqYjNMSC9kM05QM2hYMWxX?=
 =?utf-8?B?VGI5UDJmRnlld2FUVnphWjVmbVB3ZWtTSWM2WUhTbDJzNEgyaVU1c2FsR0s0?=
 =?utf-8?B?Z0x4MDJuMHdpK2s3YU5Wb1BqaklZREVjQmRtczN4VnRGdzVMWTdWUk1FUVRM?=
 =?utf-8?B?dUFLd1F3M3ZOaUlzYnZoUG9YbWx0YnBOdjFzV24xOG5vcXNIUHVFTlQ4cW5h?=
 =?utf-8?B?MDJmZWw3L21uR285VVRjRk1TWHozRVhldStQbWYxMm9vYzU4a29BMVdhdzJa?=
 =?utf-8?B?Y2VTcUprblovRW9FRUZrYzM1NHNRc0JUL0R1THVNcmdUV0pvMFQ3UTZtbmsw?=
 =?utf-8?B?eXBVSHJ2TWtuVm5peng2MTRFRWViTmZqSi9JRmI2UUU1aU91dDNMR0luZGtN?=
 =?utf-8?B?MEY3S0NmOE03NktTd3kwRlloOVdwdWVaTkJxWXJSdlk5b0I0b3p3VU95Tkk5?=
 =?utf-8?B?RG5jRzN1STBFTzZnRUhUa3RoemlHbjFFZFpWdmdrZUFVS3B5SENXaEJzVmJm?=
 =?utf-8?Q?kV1uVvcCVs7t8rf9hrgXyOI1g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9945cfed-8332-46e3-c609-08ddc46a0d23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 13:09:52.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxzCWuVpaQkiplX86YL/pHfs7nz/GUi++64w8TbPlAksWkDCU0/nGh/k1UK3ZI2U254Rb5aV2gXTfUBVpFF3tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

On 7/16/25 00:53, Nikunj A Dadhania wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Currently, when a Secure TSC enabled SNP guest attempts to write to the
> intercepted GUEST_TSC_FREQ MSR (a read-only MSR), the guest kernel response
> incorrectly implies a VMM configuration error, when in fact it is the usual
> VMM configuration to intercept writes to read-only MSRs, unless explicitly
> documented.
> 
> Modify the intercepted TSC MSR #VC handling:
> * Write to GUEST_TSC_FREQ will generate a #GP instead of terminating the
>   guest
> * Write to MSR_IA32_TSC will generate a #GP instead of silently ignoring it
> 
> Add a WARN_ONCE to log the incident, as well-behaved SNP guest kernels
> should never attempt to write to these MSRs.
> 
> However, continue to terminate the guest when reading from intercepted
> GUEST_TSC_FREQ MSR with Secure TSC enabled, as intercepted reads indicate
> an improper VMM configuration for Secure TSC enabled SNP guests.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
>  arch/x86/coco/sev/vc-handle.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
> index faf1fce89ed4..18be9f8bd015 100644
> --- a/arch/x86/coco/sev/vc-handle.c
> +++ b/arch/x86/coco/sev/vc-handle.c
> @@ -371,29 +371,30 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
>   * executing with Secure TSC enabled, so special handling is required for
>   * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
>   */
> -static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
> +static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write,
> +						  struct es_em_ctxt  *ctxt)

The pt_regs pointer is part of the es_em_ctxt struct, so probably just
change this to:

static enum es_result __vc_handle_secure_tsc_msrs(struct es_em_ctxt *ctxt, bool write)

and then get the regs pointer from ctxt:

struct pt_regs *regs = ctxt->regs;

>  {
>  	u64 tsc;
>  
>  	/*
> -	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
> -	 * Terminate the SNP guest when the interception is enabled.
> +	 * Writing to MSR_IA32_TSC can cause subsequent reads of the TSC to
> +	 * return undefined values, and GUEST_TSC_FREQ is read-only. Generate
> +	 * a #GP on all writes, but WARN to log a kernel bug.
>  	 */
> -	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
> -		return ES_VMM_ERROR;
> +	if (WARN_ON_ONCE(write)) {

Do we want to capture individual WARNs for each MSR? I guess I'm ok with
a single WARN for either MSR, but just asking the question.

Thanks,
Tom

> +		ctxt->fi.vector = X86_TRAP_GP;
> +		ctxt->fi.error_code = 0;
> +		return ES_EXCEPTION;
> +	}
>  
>  	/*
> -	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
> -	 *         to return undefined values, so ignore all writes.
> -	 *
> -	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
> -	 *        the value returned by rdtsc_ordered().
> +	 * GUEST_TSC_FREQ read should not be intercepted when Secure TSC is
> +	 * enabled. Terminate the SNP guest when the interception is enabled.
>  	 */
> -	if (write) {
> -		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
> -		return ES_OK;
> -	}
> +	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
> +		return ES_VMM_ERROR;
>  
> +	/* Reads of MSR_IA32_TSC should return the current TSC value. */
>  	tsc = rdtsc_ordered();
>  	regs->ax = lower_32_bits(tsc);
>  	regs->dx = upper_32_bits(tsc);
> @@ -416,7 +417,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
>  	case MSR_IA32_TSC:
>  	case MSR_AMD64_GUEST_TSC_FREQ:
>  		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
> -			return __vc_handle_secure_tsc_msrs(regs, write);
> +			return __vc_handle_secure_tsc_msrs(regs, write, ctxt);
>  		break;
>  	default:
>  		break;
> 
> base-commit: 9f4a425223f3bd8ccaebc7f4f42b1d8c5f12fb45

