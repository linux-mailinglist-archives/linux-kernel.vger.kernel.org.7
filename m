Return-Path: <linux-kernel+bounces-899510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6074EC57FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA1B3B8C97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4782BEFE3;
	Thu, 13 Nov 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="miIeLDAp"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579E2C08A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044247; cv=fail; b=sRtteYNEuqNtCbvqPFror1jxZBfo3NFbKzYP76wWKcKahPNU49VCu0Nonusm4oPX1ECZsxXp3ZS58lH09VDfQj/P9b07xeyHKgSfnjRhuSR6y34zjfaGUgBwBP84LFbNvUgUvKtfszIO6Uj2kkOOU5Dl+1txwI6NE7Fc5ies2GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044247; c=relaxed/simple;
	bh=v3vM6m5i3DxlU6RwrShBehstb049Vv9yFrSR054+img=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TcAMS8YeVqPrxDKrdp6FK99YuDvCS4IhgqwqdVKT5Kn8N6QUSdECca8704Ti3Rfa0CLrSkf+CZgvobzzklTpfANXgiAsGo4fxPG+65B9aM8Etc7EuqW2jwL/vVaOneI5AI6/xdWiAUthEw/BzzZ6TjOOtmwLxeKSgIM6pXOeNfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=miIeLDAp; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY74VnXDh11zm8NrtQsGunR8Kl97SyFTHK4NRqw9Ybw7VPYkK9e1jdMw7V9vLFinxHBNTeP10m52RMFYow7k3dEm3NtmrJN8F7FdhJqOtLaWVhbpkZr45TiLO6C65r3D3KrA4ht6lgA5vHdNcLPdKOW7uiJj44NJEZ8LRuxx/1aFLL3w/yPqR9pH+pyoU9PaoAQ7FuhMRzxdQWNkjB3KS+8KHEaf136MVoqVdvLOqMdtNueD1DA37wrXAwxwyMb7tYEfavMSlAhxpeIy8D8jNo0mpeOC4gnck1AjwrTRQ0Jz1v+I6PG0j4pkrKVq6EsFpTs2JNh2uSsZGNek+YFeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJazKR9FP0DRCQgQmSHYwJjZQiJRde1SSfBIIbmZ1mY=;
 b=Abg5nMc7dBH0eegvv2t6yORXFulk1UrYW67Ay2pwGS5bqL0TvPAN5oPV6Zccx4lWaR9mlNzrH7yH9vJnZDajmYh51GBThqTZW3WsKcOiQyJRnNXVrdAFKa7EhcDDL5YP+MHRR0J5cn+ZKtqFCOsIngaNanrmxm53MIIFSEwOLy17M4TGmTHxXJVVzEakCZnqG9tWEC0hNNz7hqWAqmcFg6xaxaoiQDhSW2zCjftF7elpuimIvve2iQJ0MEMxOMjLnOwHGAxVHGc4XYWL4QLf3U9zsAj0YdViP++ZtmMM8G1HnZZ7VFfsy2TL7xL/2l7npE4hPeORi0ZRz0/nNjDiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJazKR9FP0DRCQgQmSHYwJjZQiJRde1SSfBIIbmZ1mY=;
 b=miIeLDApTVAiUuONB8hW/JZgeF/JW6SyUXcRRA3ivfRfnZIwzPh0x8YB2L1j3Bog9ful2Yvn/MRwWNNgBf9Wk+pPsOJFpwU3RhGWd+biBoloc2+7eMLLMUjJ5u+H8Q0d+De55OSGqHQh7LCpH/JxAAkvqet8Lh1NGCPCwg2j/Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 14:30:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 14:30:36 +0000
Message-ID: <e89951cf-3a1a-4ce5-92d0-2ba63e2fd94b@amd.com>
Date: Thu, 13 Nov 2025 08:30:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/acpi/boot: Correct acpi_is_processor_usable() check
 again
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, Michal Pecio <michal.pecio@gmail.com>,
 Eric DeVolder <eric.devolder@oracle.com>
References: <20251111145357.4031846-1-yazen.ghannam@amd.com>
 <20251112135618.GCaRSSAkqagSF_gr9j@fat_crate.local>
 <c430ae05-74ca-4620-bb11-ff40d2eb62f6@amd.com>
 <20251112172113.GFaRTCCfu2H6JpkZWB@fat_crate.local>
 <20251113142713.GBaRXqweHEuZw1bjD1@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20251113142713.GBaRXqweHEuZw1bjD1@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:805:ca::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ab72cd-69a6-4731-8ebc-08de22c135c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTY5NVV6OHpuT3BsQVYzOHNCTjVrRE5rdE1tR2xhRW5SL1FhdjdjUzRhV0d1?=
 =?utf-8?B?Sll2KzFwdEJ1bC9rb3VwVWhyV1A2TTI1Zkxibk1DZUFvc0RYdW84U0luVFly?=
 =?utf-8?B?WEJnY3FSWVlld2E1SWZWdXRTWThrSW5nSGxGUkszZmFLdUxua3FES2Rlcitk?=
 =?utf-8?B?ZXViS3puQVF1R2xNS0pnU3RodkQ2VFAxY0hGSy9vZ1BvcmxZc2c0aHRIUTN1?=
 =?utf-8?B?QTJPcjg0bThKcGVJMFhJNUJBaGNjczVkaVhNSnkzYmpwSnpXUm5yWG1xVXhS?=
 =?utf-8?B?RUE3VVhKRHVZZkRCekx1RC9FYVJxOUc5bEFFU3dNeC9Rb1BaOEFJdFBGbjJs?=
 =?utf-8?B?dU50VkZMZHF4b2w0RjBaQWdaSEx4NjVNRHIvNGFzbDVmZ3QvWmlSakN6QnFF?=
 =?utf-8?B?dmFaQ2hZTXZWa0oxbWNPNmZKV0F0cE4zY0RSMC9DSnhUWitNK1JqQ3E4eWVl?=
 =?utf-8?B?cXpQeCtuYW9BWGRKekJ0UkNjWGgzU291VlFqNC9UYlViSHBQNkZmcHRKU3Fi?=
 =?utf-8?B?Q3dCTzZ3NWRJb3A0dnpSd2dJYjB0TW1aT0xWVTVmZW9VcHpkSGFnc2FzTjJF?=
 =?utf-8?B?WGlieGVlWFoyTVlnb0VpclZwQ3VZRjJWU1ovUjQwdUZqcy93aGh2Q1lHZ2Ri?=
 =?utf-8?B?azZQbkVMNlVhYjI1Ty85WVlZc2dlZVFLSExkZXRRU1Bpbi9jM3FBUE1wSTlq?=
 =?utf-8?B?TlhwRHZSMXNObEpMczVsU1BPc1pWZDhvUWlHQlFpdWJ6dkROQ1I4MWM1Q05Y?=
 =?utf-8?B?N1RtS2hBR3FHdzF0WHo2c1Y2MmRIaWFIRGg0bVRCbldsMUZjbFJ6VEFDZzlv?=
 =?utf-8?B?MW0xS1JFVysxdC9Fd2FVZ3IzcnNuQnFZbFJ3anlRei9KT0tQckZyekYzbUFM?=
 =?utf-8?B?SEthYUZPY0I3OWgyWWgrNG9jWllhb2w4c3ExRXllYk05dGx4Sm9TZjBPT2R2?=
 =?utf-8?B?NE5sZWdqNG82UkZhVFpqSnkyWThHd25CWENPRmVsbnJWczd5SUk0YVJnMlRr?=
 =?utf-8?B?MVRSYXNQZ2dlSSs0em0vUktOUmJlRVJET3o5cWRkY3Yzdkp3ZUpZSXBwUnpZ?=
 =?utf-8?B?aUhsbWd5UlRWSzBYL0lhdUpUNHBvaFlaamdzZjl1UFM5OFpBRW1oU3kxY2s2?=
 =?utf-8?B?WXRpWHRPT2d5bkVjdG96OXo4dFVvd1F3endJTE1DM2cvWDJhcmR4WDYzU203?=
 =?utf-8?B?MHhkZkt6WWVaZHYxWjIxZXZWbDVkUWx4UG9hYzJWeUxvc3l2Ty90SFJGbVhG?=
 =?utf-8?B?bEpBVklTTUI5TjlKSmE4MjY1Vy9vYzY4S3E1N3JOd2lyWEN4THRWK1BRbVJ6?=
 =?utf-8?B?Qk1qbHV1cVJtdjU5Y2c1OVpIYUNZcVVCNmViQy9uM0c2U3ExalIvS2E2cVBK?=
 =?utf-8?B?WC9QSEU1Vy9qN1JYampXMFBDSVEwMWE0VDBxTkJ6SXU4YW5jL2NKOTRsblBv?=
 =?utf-8?B?Vmo2eXh5L2ZEQUxPKzFEYlUzaFgrV2dzVEl3QnN1TS9qUDlkRUI4OWZDbkx3?=
 =?utf-8?B?Z2xTalliUFNXc3pqcHlCaXlKWmM5RUNzYnFHYllxenpHeE9ncnI3VVAwV0xJ?=
 =?utf-8?B?a01PR1R1LzYvWSthSG1qNXVMOG1GRFRJZmd0cFkvY1U4STZKdFRLVGVJUWxk?=
 =?utf-8?B?YkFTOXU4d1RtRlIvUEV4Ynp1dmdrZXNON28ram1ZeWZ5TnRHc1hiWTNMMXFz?=
 =?utf-8?B?aE4yOUwyRFdybEtyZTBVUVFySTM1WmpvMnJhTkpRRmwySTBYZVY5YVRjazRB?=
 =?utf-8?B?Q1RlZW5KMWdOZnc0OXo3NzB6SDc0NStTNlIvdXBHKzFPajBxL2Q5eWRUOThm?=
 =?utf-8?B?N1ZrTkJmZkRDSWt6ODJMMzZHUk9rSmZOdWJWbHFseHh3YlNuQkpaUGFkY05y?=
 =?utf-8?B?REMyMHlzYzdORHJRN3ByNXYrNStBeS9YeGx0VjU5Y1RpWFdlVm40VFhkZXBY?=
 =?utf-8?B?UzNnZ0RaSnkvZlVhelY1MXQzZXkzNE0rdUdXMDBlZjBpY0xCbUhOeFU3WVgx?=
 =?utf-8?B?bUxBK2pKa3pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1VxQ05lTGdMK0tVeWZmWWxPUzd0S2owYm11Ui9OdzlBY0owa0I2RGxyTlpN?=
 =?utf-8?B?ak9hWmJVSHR4Y2JrTU1zZnV3ZkxkaTZZWFpaTm1mZ09GZTRFMnBPUCtUeFV5?=
 =?utf-8?B?eUdlOEJoREh0bXFtTzdRdUJXUUNFYWFMSzBsZ0ZibjNwZVkxWkFkQzB4WEp1?=
 =?utf-8?B?NURiN0lIdEovKzlhR2RYdWFPWTNLTTVSMEgxekJLYWJBQ2lrVWxKWTVSc3gw?=
 =?utf-8?B?QVgwVVRkVTlKMWVIemsySFhJcVpDL3BCZ0NaMXhxbnpjRlhqVkFRSTdOam1V?=
 =?utf-8?B?R1RrQzJzbFBCTG5oWTJETlg3aTMvOE5EdmE3NnJZVUhOL0pjWUJYZGh4VHNu?=
 =?utf-8?B?Z1ZDUzVCWWxhdEd0bXFpT1VYbVAwMEtMUkg0dWFEOTZ5Sm1XNkE4eXB6RHhO?=
 =?utf-8?B?R0ExeFRhcTZYZ1NIVm85UG85V1Y1Nk0xZzlwbGFNVTY1YnhPa1FKa2xndEFR?=
 =?utf-8?B?WjgxeW83S010a295eE1LTVkvbmQwUWkzSUFYMjhMZlNXM3d1N2hmNkJUVDNw?=
 =?utf-8?B?TUpmWlNLUUdGUVpFU3ExSnpXN3o5WTFmYWRMM01aaWljOE4rQjZPWUU2aUk1?=
 =?utf-8?B?WEdPUEZoTVk3SEhXVThpYjFVRno4ZmxxMzNIN0dKaHVmRHJnR21nTUg4SXQy?=
 =?utf-8?B?RTJKVTBtVGFDRzVoMDJPV294UmRsQmk4ckMyZ0xoQy8ybEQrYmZMc3JOT0hz?=
 =?utf-8?B?RW1TcUFhWHlXS1FzL2NBNmY5T09DUHNRTTlzNlVwL0p4N3NTRWpkUzl1aHFx?=
 =?utf-8?B?eTZ2L0ptd0hHanl3cEFMMDU1c1VtNWlCSU5PMmdFb05hbVZTdnVsSXZqU1J6?=
 =?utf-8?B?ZXNqT3Rxa2ZreTBMM080MWhCMUtGVzJnQ3l0KzN0L1AvUGtnVTVKQVVlMnZC?=
 =?utf-8?B?bkx1d3JzL0NGOXVvRXJIbU5BNUowQ0V3eExTMHZNYktKZmNHV293bkZxdVpF?=
 =?utf-8?B?UXcxTTJiREpTZ3doZkFId29FRmJDVHoycWdHS1pqbGxHeExCR3V1cXdIQ3lH?=
 =?utf-8?B?RGRJWVZwWmdCdExvVWRLOVlzOW1ZRVNMWlc2aXcyOG0xMm5uVmoyNnRKalha?=
 =?utf-8?B?eUREOEVzdm9zNTlxaC8wbUlNdXBnMmJSMVlMcURRNUFhN2FuQUh1MkthNmxN?=
 =?utf-8?B?SUZWeCtlaHRhR2gyMlhMeDl2ODZjTThUUWIrV2ZIOTdrYUtTZXlLU0hoWk5N?=
 =?utf-8?B?SzBUY1FsMlk1aDRySFJVakxNVDE1TmRsTDMvaHVjOFQ3RytjbjBHeHVkbjRp?=
 =?utf-8?B?Wlg5REw1WEk2Y1pvdEcyUWI2dlVqVjY2eVlUenRYZ3RoSk50ZENPbUgxKzBH?=
 =?utf-8?B?NFROWTZWRnBpd3RZUkN6UUQ5eThmVk1YUFI0MU8rSWZVN3RZenV0cytGUkdN?=
 =?utf-8?B?SDR5aUhxTlhHM1QzbnB1ckgzVmxzOGpCeHYrL016QnFaYmlXVUV1TjZFbE8x?=
 =?utf-8?B?SjdraTQ2RVdyajRUNFZzazJObzBiaGFpY2pEbnJJV2xMdk9UWFRwZzlsSjJZ?=
 =?utf-8?B?dHplNlVCS2xwUEVjcTlHc0lIR1BmaUlITTMwVHFKTk5UVDdNK2VZdUdjdjF0?=
 =?utf-8?B?SXRKTGJSSUZKZlQvZ3pxZHIvYU4vdEFUZTRjTmRrZVBRNThBSWk3TkVrbDR4?=
 =?utf-8?B?NkE1eFRUSlRraDdJcnhRRGZKaHU4bzhjcGx4OHBOajBidGNPaTlGL2t4L1pO?=
 =?utf-8?B?M24rcmU5Q3ZWOHVLeERTbnpRKzlEZ1BJN0hPWWFGY2tQZm5EUWdSOFVic0hK?=
 =?utf-8?B?L0RudW5aZVZhQUkxUUE0WFVOYlBBaElhc2d2RHVYbHNSa0xXZkNpYy93aXdw?=
 =?utf-8?B?QnBQK3QxWitLODhwd0pjVkpLSGIyMkxRTlVjQjc1Qk5kdXVqRWgrekZDTUxS?=
 =?utf-8?B?NUtNM1locXBvcVM3R0VlM0lXT2NqSmx1c3g3bzhlajhzQ3p3c3k2S0VjWm8v?=
 =?utf-8?B?eld0d2x6VDNpYUtneUlzTFFIT2FGUjJDY1l1dGFENUVURzgzd0hvNGFwVGtR?=
 =?utf-8?B?cDRtMFlRbk81dS84a1RaSlIrT3A5QlFMenhjVmx6OHlUTEwxRGdpZzFkQUJa?=
 =?utf-8?B?dXVIYUZoSEdqVEZKSktESytQeld5YUZmcnYyS1hMcHNvUS8xakVTUzJnYitC?=
 =?utf-8?Q?lPK4Rd5Qy+W2f8vyKH5grhfT4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab72cd-69a6-4731-8ebc-08de22c135c5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 14:30:36.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFH2R3Su1mn3On5c5mXydjtc498lsmXOv1CcSmupG+LoiEvNBm6GEDkAWU0R+hVmcz3Kwg9B9pQxQdakBnQRSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771

On 11/13/25 8:27 AM, Borislav Petkov wrote:
> Seems to work here, I will run it on a couple more machines and even if it is
> stable material, I'd let it go through a full cycle merge window so that it
> sees more testing.
> 
> Thx.
> 
> ---
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Tue, 11 Nov 2025 14:53:57 +0000
> 
> ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
> used in conjunction with the "Enabled" MADT LAPIC flag to determine if
> a CPU can be enabled/hotplugged by the OS after boot.
> 
> Before the new bit was defined, the "Enabled" bit was explicitly
> described like this (ACPI v6.0 wording provided):
> 
>    "If zero, this processor is unusable, and the operating system
>    support will not attempt to use it"
> 
> This means that CPU hotplug (based on MADT) is not possible. Many BIOS
> implementations follow this guidance. They may include LAPIC entries in
> MADT for unavailable CPUs, but since these entries are marked with
> "Enabled=0" it is expected that the OS will completely ignore these
> entries.
> 
> However, QEMU will do the same (include entries with "Enabled=0") for
> the purpose of allowing CPU hotplug within the guest.
> 
> Comment from QEMU function pc_madt_cpu_entry():
> 
>    /* ACPI spec says that LAPIC entry for non present
>     * CPU may be omitted from MADT or it must be marked
>     * as disabled. However omitting non present CPU from
>     * MADT breaks hotplug on linux. So possible CPUs
>     * should be put in MADT but kept disabled.
>     */
> 
> Recent Linux topology changes broke the QEMU use case. A following fix
> for the QEMU use case broke bare metal topology enumeration.
> 
> Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
> for guests and to maintain the ACPI spec behavior for bare metal.
> 
> Remove an unnecessary check added to fix a bare metal case introduced by
> the QEMU "fix".
> 
>    [ bp: Change logic as Michal suggested. ]
> 
> Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check")
> Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present package")
> Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.com
> Reported-by: Michal Pecio <michal.pecio@gmail.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Tested-by: Michal Pecio <michal.pecio@gmail.com>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/20251111145357.4031846-1-yazen.ghannam@amd.com
> ---
>   arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
>   arch/x86/kernel/cpu/topology.c | 15 ---------------
>   2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 9fa321a95eb3..d6138b2b633a 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -35,6 +35,7 @@
>   #include <asm/smp.h>
>   #include <asm/i8259.h>
>   #include <asm/setup.h>
> +#include <asm/hypervisor.h>
>   
>   #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
>   static int __initdata acpi_force = 0;
> @@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_flags)
>   	if (lapic_flags & ACPI_MADT_ENABLED)
>   		return true;
>   
> -	if (!acpi_support_online_capable ||
> -	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
> -		return true;
> +	if (acpi_support_online_capable)
> +		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
>   
> -	return false;
> +	/*
> +	 * QEMU expects legacy "Enabled=0" LAPIC entries to be counted as usable
> +	 * in order to support CPU hotplug in guests.
> +	 */

I think it would be good to amend this comment to indicate that the 
behavior of the "enabled bit" changed and that QEMU follows the newer 
behavior but advertises the older version.

> +	return !hypervisor_is_type(X86_HYPER_NATIVE);
>   }
>   
>   static int __init
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 6073a16628f9..425404e7b7b4 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -27,7 +27,6 @@
>   #include <xen/xen.h>
>   
>   #include <asm/apic.h>
> -#include <asm/hypervisor.h>
>   #include <asm/io_apic.h>
>   #include <asm/mpspec.h>
>   #include <asm/msr.h>
> @@ -240,20 +239,6 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
>   		cpuid_to_apicid[cpu] = apic_id;
>   		topo_set_cpuids(cpu, apic_id, acpi_id);
>   	} else {
> -		u32 pkgid = topo_apicid(apic_id, TOPO_PKG_DOMAIN);
> -
> -		/*
> -		 * Check for present APICs in the same package when running
> -		 * on bare metal. Allow the bogosity in a guest.
> -		 */
> -		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
> -		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
> -			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
> -				     apic_id);
> -			topo_info.nr_rejected_cpus++;
> -			return;
> -		}
> -
>   		topo_info.nr_disabled_cpus++;
>   	}
>   


