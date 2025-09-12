Return-Path: <linux-kernel+bounces-814599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D108B55641
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E843B0054
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A9E32ED35;
	Fri, 12 Sep 2025 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p4j82gva"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C6329F1F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702056; cv=fail; b=KZK1TNL/EHKIeCa1P4MuVyw4zqwXCD3pIvwlDib4IbRvbJN6AoW2fwBN6tQByTjt0GDO4vmiy/ZtmdGkOJsCTbfhcVsPEJpy4Aea527sPNjIv4YWcvCOkcQrZYDPsX7R/Umv5jzcnur/jSnN8eoAy4RFtzKISKcjNIBmJbwJnaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702056; c=relaxed/simple;
	bh=Kha0LB5+0CIDZRu6zTyQAePi3BQzZ6BCwkYOtyz/158=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O6NubjYVjkvur9kvQjcQ8sC0JMmX+Rk9vyULv908VcuGLOvOFXNJ9w+OFdYm+t5+PIxM7H9XrScyF9ddi/iejN3mrWVrqJ0wVOK0+biB8/hEowGNbtbAu0UiFDyxjlahwU+cghd1ILnTqSvYeR8MeCpSm3djmaxqAQxZdLexbDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p4j82gva; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KrR7ZEvulhnz1QwLisNflaLqSohUJUT8sNKrC3Sm630AGVGc/nZD+GAB2YAaEknQil61/WSg7HOK7MGlvF/mUPivxrszEvm5kHIf+G4VYS8eirS/gRctuUZ35vuzIN5X2o7gMVu2vt8OfTmyZjuGhqkjiRcXWaj6CfRJrGPIgwo71sXDzobwhzppb6HqzZLVBL2D/AbGIPTyd7rB9vBKM80KjNf9kO2f6dJ3KlmhakGQO/XxtKGayV6DOhVMPr63MVG8hcVMWa/xvjBjaznvnGfc1dX1ozf7qkrV6ua/IqaPz4X8kH3yhJ4MPYeYmmLxu+4yPteRITqsL2Lh4mSh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAqC5nMzhjXq6M4r/pHPMzlGF0Iud0C1vqImJH8NU+0=;
 b=m9EgpPnB0UCMiqw1WplpAGMM8bBgiHj12XAnifbC+tA4LBbEvisX7Q4oXLWZ4rCH7zhmAF2iyXbSdpji3SK4GtUK5aRkVnqRC9JmiGnxgbsXiBcKJMhE7Cc+A6nrgvW5UK5dUleGAwC6eZPUwcHwDCycGl9m9fnt5al0wmWBaon2acPm+6X1fvR/FkSo7IuaidW2XQpfBt5crXcM/ATMAsVENu/LwE13sxZKvkmbCl4F2kDQSOXImUuhFS/FtP6CHev/jdtu9Pz5Kyxc+tcNL/cP6D483TUw5tiOd1dmRRGT6E/7KuJ+Ojc99ZqPWB+lUkdEEKYcUOMY0C7WROPw+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAqC5nMzhjXq6M4r/pHPMzlGF0Iud0C1vqImJH8NU+0=;
 b=p4j82gvabTdd7+6iXk2Qzu/B44NZ9SnKYP3YSeNZhIaSCHpgWdSlKNqXcH4DR0gw18bx5VY/sSdOfRq66+LTmoBKlruj+VPiaJzPEX9+ef1esgsUiu5HpC18BQw2ZcvsazBd2unyoncJ6rQC5H7x+5dpZaPS+N/X1I90ee1sIGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 18:34:11 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 18:34:11 +0000
Message-ID: <77049b07-9e13-4c6a-a7bb-70e9e74a662f@amd.com>
Date: Fri, 12 Sep 2025 13:34:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:x86/boot 10/10] arch/x86/boot/compressed/sev-handle-vc.c:104
 do_boot_stage2_vc() error: we previously assumed 'boot_ghcb' could be null
 (see line 101)
To: Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@kernel.org>
References: <202505100719.9pE7wDfB-lkp@intel.com>
 <CAMj1kXHyVh7KwNyekd8ZAATufnMHyzyMismVf2xW8F=LfBJviQ@mail.gmail.com>
 <20250912182642.GCaMRl4nu7R9C8uP6R@fat_crate.local>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20250912182642.GCaMRl4nu7R9C8uP6R@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24)
 To BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: f4663d5b-7d79-42ef-db9c-08ddf22af7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWlhdVRpemJDMW41K2UrSHRhRUVoV2U0ZTl5MDY0VWRkYVhibVY4VTRQbVNT?=
 =?utf-8?B?Z1piVFBQbGFqZDZncTNFMHNtVzJvVS9aRzNBTHFKNW4yc1BSUS9CcDFYK2Yx?=
 =?utf-8?B?WEUrMFh0eXhIK0xFbUVTbExKY1U3eno3SmJEY2V1a2RvM2ZDaUNDREhHRE1L?=
 =?utf-8?B?eUw3cUN2M3hyL2F6WjFqaTJyUy9MZzZoQnlERzM4WDRYTXdweVpmSytreEp4?=
 =?utf-8?B?MUkwL0dRRmpQdmF5L3JOT1pkc09UclplL0NlSmY0VkJaQ2JqMUJTVHZ4UjhX?=
 =?utf-8?B?V1dPbmgwRXpFaXorV01nQnl2eFd3dGJvcGEwRThKa0pwVVFHZXBFMkVBc1BB?=
 =?utf-8?B?dnc3YUN2bm4wWDVFNDl0RU9rUG1xU2ZrTnBxZVduZGtTZEQ1b3VoVDV3b1pZ?=
 =?utf-8?B?ZXl0YlJlaFByOGF4ZWxlTFhadkFqaGtIZTI2ME5RN3VsNXlWUjNlQjViaGN4?=
 =?utf-8?B?KzFHVCtlbEN3ajlKeEFzaENWR2c2Z0dXb29YeW5XK1VvSFRSVndqNTV4VFBF?=
 =?utf-8?B?ZldZNytYRndDbDJ4WTVveW5lMkZsMTJpTm5hZ0NiV2NacHV1TWN5cHNzWjFj?=
 =?utf-8?B?SGxXMW0veDF6QVF0UHc2UHV6VGdac2Z6K2xFRGJUR0hkUm43T2ZnTkpPSFlO?=
 =?utf-8?B?cXJOSXBSUUlQeVJOREJYb01DdTdVRW9xVGVscUFUYUZmUWQzc1V3TUtLOUNF?=
 =?utf-8?B?aTJDNFZDSkxmam96MjcyS01HcFFEd0Z2VGx2RDRldFRKby9GT2xrR1hhdzJp?=
 =?utf-8?B?NFJ3R3RObzVaMFRHQkJTVGk5TXViZ2Z0T1NjQTkzSVlRTHBJbFNMUEUxQ1hn?=
 =?utf-8?B?Nk1STlRnazY3M1UrNXphaEJuUWpPUDV1M3k2QXBnWGN6alR0YVZLZXlsQld4?=
 =?utf-8?B?RmpOdm01aUt5R1FxS0pCb3owZHFqQnlURGtMT2I1MnU3TEQyTDNqZVZlZEpS?=
 =?utf-8?B?V2d1aFZoTDJMSzBuVEhEYmpOSlozWTI5em5IemRKcVh1MThCVFptNXRsR1Iz?=
 =?utf-8?B?UUZoc0xxcUFyNVpMYXJNdUVQa0tBcmpNOUxLR3h2dnozOGJhakFPZ3poNmlv?=
 =?utf-8?B?R3J1bEpSKzBMUFc2azk1U2tGQzl1VU5oL2hZMDZWMFVBVGxENG9yV3JGalNu?=
 =?utf-8?B?b1d6VFZ4anVjNEtlWW5lck9GRVB2a2ZxMXBsUmREODkxM3lRejdXcktHMEUv?=
 =?utf-8?B?cmhsak9TOGRrQ2VyQ3d1SE51TnVhaXpGODhBSFlBcHg5UktHQSs0NTEyUld4?=
 =?utf-8?B?OU00Q09WeVF1RlhjNXJGWmtCUXhLR1RWS2oxazIzdnRUcVpKdHJhY2dzdm40?=
 =?utf-8?B?MkFGUjZ5dXFIeGRTOXV6QlJJTE0xSi81S2xVSnFiV0p0TWJnU2x6SUcwNUd2?=
 =?utf-8?B?TVEvWHNWb1NFd0xsUm1adEcrN0pMek56R2drR0phVWZ0blRPUTJhMjZzeGd0?=
 =?utf-8?B?WEVvLzVPekJDSU12NEYyNVJDakRJdjJxV1gvclo4S2F4WXdIS09tVUI3dzlj?=
 =?utf-8?B?NkYyd2tpYi9nZjNRZGZ1YWdGdEloWHF0QkR6c0ROZHU2ZzFKSVdEclVOZk0w?=
 =?utf-8?B?Y3BhZGxFWFN1TTJWWVVXSWxLMVVVT0g1OVVJOHBvcnV6S3QyVFpRZzVJWnNN?=
 =?utf-8?B?R0xKSC9vUkxyaTE5WDk4S3Uya3FpU2k4dUErYzlwWXVyaGhyM0lQWXh4VGEx?=
 =?utf-8?B?djFFY3I4SmM1dFZEeFNnSlpReURZYWRDVnRWelViQmVxYi9QOUo1dmo5K3RO?=
 =?utf-8?B?b0VBYnRLVkNuZ2wxbTg0Z1NxR2g5U0d3d1g0ZCtqZ1I1NGR1NGtjSE5Wd1ps?=
 =?utf-8?B?aGZZazhSZHNYV2pmMHhXKzR3WDRUL0xmTzN6MndxWng5Wk1PZjJoUGowYUFs?=
 =?utf-8?B?THpxeVptMzdpcG8yWGhUeVE5eCtmcC8rWTY4RWNacTRSR1YybDU2bUF2ZEZG?=
 =?utf-8?Q?O88JUR2rJgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qkc2ZXdZVGgrdUJ4bGRueFNVU1VKUnFyMXlwVE1RMDBmWHlJU1FzNjBEMDdy?=
 =?utf-8?B?Z25pb1BkZ1BBVzJYU3VCN2prNklYaUcvM280Y3RvT1d6ZE1iVzBJaEUzMVk2?=
 =?utf-8?B?ZVdLTFpZNnVybCtMZTZaZEYwRGdpVHpKOTZuRmlXZUtzWklLUHZDVy92aGtC?=
 =?utf-8?B?YU1Td2pKbjl6czZKL3ZrZVBBZHp6K04zdTRVbTV2ak55aTBCUjF1MFk4Ulpa?=
 =?utf-8?B?ZnZzajBURkhGMWtkR09IT04yVWgrWEdXSzdkYnlMQnpiTlI5K2VpTmMvdE9K?=
 =?utf-8?B?eUtmKzloWHI3K2RsR2F4UG9waDh5RG1Yd3p5UWhjS1E4NVY1dm41Ym53WkRo?=
 =?utf-8?B?RG9nSXdYbkJBSlpsS2VSUmpzYVVyQ3RHb05pbk9Ud2xFaDZPaG5VN0tGNTRV?=
 =?utf-8?B?eFp4Kzk3SmdGNVViRStCWUtTWmhJV0E1YnoyYTZqblRlRE5IM2g3RTZmR01K?=
 =?utf-8?B?ZXNIRmJsbEtYL1pCd0dGVFh3MnVZdStvWmxWRlVvMlhPTGhnMGVVMmVoTEgw?=
 =?utf-8?B?VzNuSDFObGxlNUowOGJiQXk5cXBTeDZ4Q2o3aXpYd3NuT0tkRzdObGI0cVNT?=
 =?utf-8?B?YlBjZ1lUdEJNRmZudFZuMXcrUVFLaSs1WGZqOGFJSTJ4eDJmazdia3Z3R1M3?=
 =?utf-8?B?YzdsTzlnRkxxSlpwdlUzT2RvSm1yTURMWHRtbFRQTzg2ZitKSkpKU1krbVcr?=
 =?utf-8?B?OXJlT2tCaXBjOGhST1ZyOHZHWmRkRTllb3g4MWMvNVlhQ3Vkbm9vcGxNQUxh?=
 =?utf-8?B?TGlsNnNyZHJ4Uks5NlMxUUpTVnZHWmJQMUIrNm5CSzByREtoclNMRE1IUHJY?=
 =?utf-8?B?NzhDVUovU2ZpVG9MVzNFdWhRMGwwZnlnNWNhZzcrNFMzQ3BaRSsvZEFIMDE3?=
 =?utf-8?B?OS9vSXNzOUJqV0xEQmRIN2NyVlAzZkF1cGZjVjQxVTVHTG1VT1N6ckhob0xw?=
 =?utf-8?B?V2Z6aVFYd2E2STBTMVJTblVGbnJBVUNvRzdpdjRoL1UxMnBWWi9xU3ZnSEwv?=
 =?utf-8?B?N2pseUlxeXMzcWVlTXVKU2kyZmNCMVc1SC9pSzJROWMxRk5vU0hxeHdGY04x?=
 =?utf-8?B?SWRSZXFDNzF4Zll5emdxcHF3S2REN1A0L21FWmxSSkFjVW9qQVRKZDNESldF?=
 =?utf-8?B?dFF3VHlKQTc3eWY0YWl1RGVpWUNzL1Q4WUhuNm1BekphTkJ6aHB2eFM5ZmNj?=
 =?utf-8?B?UklsTE5hVHlHc3N3RlpnL3pBTVZEQWJpMGltbHVSTmc3WGhsNzcyNXo2Z3g5?=
 =?utf-8?B?d0QzbWdHa1VrMlhTN0J5S3djWUJSZU5SdEl4TVcvOEF0aUh5MVIzM3hNRUkr?=
 =?utf-8?B?UThac2E1dVBHLzJEZWY2bzZuOG4wYmc1ZFpDSGw2NkZPcUhBS0FNcEx4QnhC?=
 =?utf-8?B?S2dhOGNQTUJQUDI1azUwbDFidnhlZ1U1T1ZmbC9aSVBGQ1FleEVtMkdyVDlJ?=
 =?utf-8?B?NmJDZG9HSE04MWtkNWR6SHhQa0NQY1d6bkRYRjZIay93Sm8rNDEzbFoybkMw?=
 =?utf-8?B?YkRwY2U1ZGppU1VkZC9JVTQvcTN4TEtkRUxCTGhha1EwSFRYYjR4MnIxK3kz?=
 =?utf-8?B?b2psRDVXUXNrNFo2bDNrUXRhbVRGUzhZa3FaRzNzU0J1MFo3Y0MxSmpJVHV1?=
 =?utf-8?B?bHFIZTV1aStESkJ0elp1RW9SL2s1QWZBMEppQWRrRzZTSzV2aGRpUTVTQzZF?=
 =?utf-8?B?ZVpOdnBNZ0x2V0laOFRtRlh0R0xZVTRLZnZTenBrYllPaVBsVXFwY3ZNNzNa?=
 =?utf-8?B?MGxzM01oQlA3R0wzRGIvZTYwMUdHZjMyTjdDMkZqMWZDbEZuTjB2WFhZb1Jp?=
 =?utf-8?B?VlAydCtIVElGam1VcVBUcStnRW1SM29SUXZqbFV0QkhHTEZIRzJ0d2VPbisv?=
 =?utf-8?B?TkVUUUUycnZCTTVFUzBiSVhPSm16Yno4QXlsL3ZpUjVvVFd4dHpLcThiU0xn?=
 =?utf-8?B?dk1id2NmTUIxeDRDUXRmbXA0bnUzSDZ5QVhLZElQeWp4blRKWGxyNmtzSVRz?=
 =?utf-8?B?VVJOdlNKYVRXekdvSWhvN1hLbGRQWjB3R09ONHg1WjRMQ2hwa09SY203aEg1?=
 =?utf-8?B?MnNqNlJaUUlBVVQ3TEcxcDhjUDRod0VETExlL3YrelpTQmJXUVM5ZnI2cG9i?=
 =?utf-8?Q?iyHqgN/y3XfV+zzhBS8grjbFk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4663d5b-7d79-42ef-db9c-08ddf22af7a0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 18:34:11.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx1OYVWVRrlhqnH611YsJFkiTSVfCuSNiCcGOR6fC5R7/mcfcsbCdT4RwMyBykIJs7IjyMHXk/RQ+DkA5s/iMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408

On 9/12/25 13:26, Borislav Petkov wrote:
> On Sat, May 10, 2025 at 09:57:23AM +0200, Ard Biesheuvel wrote:
>> The logic is a bit clunky here: for clarity, it could be rewritten as
>>
>> if (!boot_ghcb) {
>>   early_setup_ghcb();
>>   if (!boot_ghcb)
>>     sev_es_terminate(...);
>> }
> 
> I like that. Untested patch below:
> 
> ---
> 
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 12 Sep 2025 20:21:39 +0200
> Subject: [PATCH] x86/sev: Clean up boot_ghcb assignment
> 
> Make it more obvious that early_setup_ghcb() assigns the boot_ghcb
> pointer by simply returning it. This way the code becomes a bit
> more readable and comprehensible.
> 
> No functional changes intended.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/202505100719.9pE7wDfB-lkp@intel.com
> ---
>  arch/x86/boot/compressed/misc.h          |  2 +-
>  arch/x86/boot/compressed/sev-handle-vc.c |  5 ++++-
>  arch/x86/boot/compressed/sev.c           | 11 +++++++----
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index db1048621ea2..648f751538de 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -150,7 +150,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt);
>  enum es_result vc_decode_insn(struct es_em_ctxt *ctxt);
>  bool insn_has_rep_prefix(struct insn *insn);
>  void sev_insn_decode_init(void);
> -bool early_setup_ghcb(void);
> +struct ghcb *early_setup_ghcb(void);
>  #else
>  static inline void sev_enable(struct boot_params *bp)
>  {
> diff --git a/arch/x86/boot/compressed/sev-handle-vc.c b/arch/x86/boot/compressed/sev-handle-vc.c
> index 7530ad8b768b..66b29fbb9f57 100644
> --- a/arch/x86/boot/compressed/sev-handle-vc.c
> +++ b/arch/x86/boot/compressed/sev-handle-vc.c
> @@ -101,7 +101,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
>  	struct es_em_ctxt ctxt;
>  	enum es_result result;
>  
> -	if (!boot_ghcb && !early_setup_ghcb())
> +	if (!boot_ghcb)
> +		boot_ghcb = early_setup_ghcb();
> +
> +	if (!boot_ghcb)
>  		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
>  
>  	vc_ghcb_invalidate(boot_ghcb);
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 6e5c32a53d03..f9dcd1b795d7 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -75,10 +75,10 @@ void snp_set_page_shared(unsigned long paddr)
>  	__page_state_change(paddr, paddr, &d);
>  }
>  
> -bool early_setup_ghcb(void)
> +struct ghcb *early_setup_ghcb(void)
>  {
>  	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
> -		return false;
> +		return NULL;
>  
>  	/* Page is now mapped decrypted, clear it */
>  	memset(&boot_ghcb_page, 0, sizeof(boot_ghcb_page));
> @@ -92,7 +92,7 @@ bool early_setup_ghcb(void)
>  	if (sev_snp_enabled())
>  		snp_register_ghcb_early(__pa(&boot_ghcb_page));
>  
> -	return true;
> +	return boot_ghcb;

Shouldn't this routine then delete the line that assigns boot_ghcb and
instead return &boot_ghcb_page?

Thanks,
Tom

>  }
>  
>  void snp_accept_memory(phys_addr_t start, phys_addr_t end)
> @@ -216,6 +216,9 @@ void snp_check_features(void)
>  {
>  	u64 unsupported;
>  
> +	if (!boot_ghcb)
> +		boot_ghcb = early_setup_ghcb();
> +
>  	/*
>  	 * Terminate the boot if hypervisor has enabled any feature lacking
>  	 * guest side implementation. Pass on the unsupported features mask through
> @@ -224,7 +227,7 @@ void snp_check_features(void)
>  	 */
>  	unsupported = snp_get_unsupported_features(sev_status);
>  	if (unsupported) {
> -		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
> +		if (ghcb_version < 2 || !boot_ghcb)
>  			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
>  
>  		sev_es_ghcb_terminate(boot_ghcb, SEV_TERM_SET_GEN,


