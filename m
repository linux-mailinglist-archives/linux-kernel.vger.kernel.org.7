Return-Path: <linux-kernel+bounces-887061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDEDC37345
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED64625F18
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723D3375CB;
	Wed,  5 Nov 2025 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="soFtLtDH"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA70B1A9F82;
	Wed,  5 Nov 2025 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363871; cv=fail; b=ujceym+DBNXW50DMnO0F4Hcej818hCaDPjfTSz/mZLxjQ2OmhNEllSoCN4Kg5fKCfOyyXB7trZGL06+MLwwf+i5Ea8I242UjbhiQpr4IaQcwC9Kfzbdjv8oAy+iGisIAy8O6xQkal2ZAFdDXP+c84MIOZoSWfK0Mp/EvyzxFkx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363871; c=relaxed/simple;
	bh=yiIbGnZ2p/0suxQQePCl4xWEgHqlQkm2YOHq0726n4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ei1uIvTf5/iirWCXkSr4o6Id5bKbx3y685iMiHrUdqdSdtz8dOanTWe2Bf4NfSP24VvrYTnJfmzRVQL3sNYTr7a8hhIw5EXSP7E1256KUE3Nc50wnFHFAuEZ+FWOpRqaNMjIAx3aaiPx7LbwzGQEYmspBI/KI+LTOFhbhh6ng0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=soFtLtDH; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpp/T7qnMqYu6GLIdqwTN3CqiY45geBZ1S/1EDz7hYf+IL2QB0x4HJw2ApMbtPfUoYp4CK5Vb8FjuNFGUI7y1fyRbydwsxf2M6rNlYIoaiDlusCwL47EbrioW69YaXEeuPlFQbN0vvxeZ3XMjve5sTv0N97L+6Hb2pCONviai/oKQkwC7fxWr6DnPNtOp8/z+M/tlps+oYFJLeHBPGEeia5TheIzuaYQw73qqvuYFaSbE3D27qSelTqq1dfJ3fjEgTMPxCgdRoRsSuBw4gwiAq3bVCdpl8eLHXQ/BbqD0C3ROjda+2gdR8LI8fKHZGDrV69UXvvXuX/o5Ob//6iihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDHO8QMskRnU+nScLhsVdhmJw6rRR05/NMLqoXYfmoI=;
 b=nIEHGQN3oNw7hgk6GT2lzoNNQiBFX71Ve2UGSdXJE0EgsQLvwu4neWt+mikPfke5pIhJlPdcSTMLgYZ2FxmRETGVHqCsEHRH3ftWNq1HK2OvNRzr0b+buBER64Bp7SM4aOv1ePYBaRfsQ90Clw15RHtlyDFlRdqpW3Oj5bxuhen/qw0iR7R3TWY5gvUpOxjSYg36pk3yS1j3falBBAamokwgxStLr7kX3l0ofmvgV5JvXD4jY6HB+HaaSsn0tPoCeQAKB205+ynm60DDq8x5BhH+KkrmKqS98T/P5Kh3dcYg6zHRbNaZizmw/pEhl/XLj31IYcGD1s7MdKTT3OnGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDHO8QMskRnU+nScLhsVdhmJw6rRR05/NMLqoXYfmoI=;
 b=soFtLtDH4nEs1x3VI+aA6whyLDYgwUuh0Hb7WB5QvSqXFXhbOKz7dRsgy/Cvmr0huWIr4hEKfp+DwCbKruVmtRlBjHr3bC4YXRalmdAA9J2GgxLVbGsTAcxmvBA284eJKY+UMoY1XZIQzBxgUvkVQiQ6fbpCwFYmpblucD79UGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CH3PR12MB8076.namprd12.prod.outlook.com
 (2603:10b6:610:127::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 17:31:06 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 17:31:06 +0000
Message-ID: <4a120a9b-b84e-4cfe-af46-1b4d721c2995@amd.com>
Date: Wed, 5 Nov 2025 11:31:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/10] fs/resctrl: Add user interface to
 enable/disable io_alloc feature
To: Dave Martin <Dave.Martin@arm.com>, Babu Moger <babu.moger@amd.com>
Cc: tony.luck@intel.com, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, corbet@lwn.net,
 james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, paulmck@kernel.org, rdunlap@infradead.org,
 pmladek@suse.com, kees@kernel.org, arnd@arndb.de, fvdl@google.com,
 seanjc@google.com, pawan.kumar.gupta@linux.intel.com, xin@zytor.com,
 thomas.lendacky@amd.com, sohil.mehta@intel.com, jarkko@kernel.org,
 chang.seok.bae@intel.com, ebiggers@google.com, elena.reshetova@intel.com,
 ak@linux.intel.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, feng.tang@linux.alibaba.com
References: <cover.1761844489.git.babu.moger@amd.com>
 <deb3a4f19d6e138a502b136034fb88ad8b8c9c75.1761844489.git.babu.moger@amd.com>
 <aQt/dSRgtQNfJPCj@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <aQt/dSRgtQNfJPCj@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0072.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::28) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d63ee7-13cb-44c1-965d-08de1c9119ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JtYXJUM1NjcFMrUHhEbzQ0MGxXcFVqMGtMWGlLN3lTeWN6RVRNZlpZRVJq?=
 =?utf-8?B?ZUwybEs1Mmdwd0tnNEhhb0MxQVM5aHRZd25DV1g1NElDK3dDdlB1UFYrSm5R?=
 =?utf-8?B?eVVjRHRlM0RFd0FaWEU1R1daY2l5c2F2b1RDVTZOZE5UMUZoNEhkMTlXdVRY?=
 =?utf-8?B?aHdIZTlLNDh0SFJhMGZxWGpWK1RUcm80RCtpZ1FZWnhVM1RGN1JrbnBXQ1dJ?=
 =?utf-8?B?YngzRVpmU2NsbWFhajEzc3FQVURBdnQwcG1oa1lIZlo3eEtyWS9aeXFRdGdD?=
 =?utf-8?B?OWIwcXYwTVh1UjlxTUpaWE5sem1UblVwWXZWRTlXNGIvRE0yOUVNYTJEcEM5?=
 =?utf-8?B?UFdWbEJPd2RpLzU5aXJUNEozZkhZMzc4TCtueHBpeDFYYUIrcHJObkxkaTFv?=
 =?utf-8?B?Y3BRY0xDNUVsa0xmY1pGTjBycXpSSzZBei9Rb3hjNmhjV1V2WXpwNDVsdnd3?=
 =?utf-8?B?K29iY29DUEVrUlVxUlBLTDFiMytOdFNmVUJ1WkNTTXFIQ3Y3RjV2aDU1UWRh?=
 =?utf-8?B?SlRUaGdNVVRMcUswRFNtRjg3cFZxMmRNdEdjeVF1clMwQnVacmJCbitiOXhQ?=
 =?utf-8?B?RXdhekN0aG5sbDVsTUJ4aXdjZFdyaGFFVXh2TzBvRGw4WHMyUXRmc3BxOHQv?=
 =?utf-8?B?SG8vT215UVRlSGdqY24xTUVDcVlXK0s3UXBKZWkydjZUSVNzZ0RuNDFvZCt4?=
 =?utf-8?B?V1BlT2R4QVpwWnBhWExSZTNKL0YxQjM2dU1RVXZ4RzVKL1E5aHRxS3RkVHJQ?=
 =?utf-8?B?RnptL29rSTVBWURCcVpyWU0vRmU0WVpqRCtTMEdGNW9BMTdWUm9Pdko0NHBn?=
 =?utf-8?B?aFNNSWdVSE83b3M5bUNoNnN5MUhDMUVSQXNhSk5qVmVvWXRmUzdVS1FVWHlm?=
 =?utf-8?B?dGEwQVVsek9mK0JuRjREZXFoMnNPTkkydmRnZGltRlVGSmhYbC9MZDQ2UGNk?=
 =?utf-8?B?clRldlhkd0ZES3dybi9mSTZoNU15QXpYY1JhMy9mSXpkbXpTV1F1T0JYMTRZ?=
 =?utf-8?B?clYzT1piYjVKWTAyQTArU3pvTXdWdkhtZXVtUUNBblpvVDR6RGYxRUE0RHZh?=
 =?utf-8?B?UExpR0FkN09iYXlqRXNDWXJmclBoL00rWm5leVN6Vkp0dmk0UFRPK1lNaG5j?=
 =?utf-8?B?Mm5XVkVjaExwT1BDaGFHSHlWbTVCVTc2dnhtYldhN2c4ZE9MclhxVytvVkFs?=
 =?utf-8?B?U21UNkNDc3U2eHQ0TGU2M3hUSzNFM21LdXpKNWRjL1gxaUdZcm9pU2MrQm9W?=
 =?utf-8?B?U1MxMnUwR3YwUy9aV1pjeVY5QVk1d1FtK3ZDTzdTRklEVk1ZS2xMc3J2Tldq?=
 =?utf-8?B?bFpmVXRIck96UFk1dTR0WUU5ZDh1SlZwWlhHbEF1cTkraHRQYXl6YkdXYTlX?=
 =?utf-8?B?b1MraklQT0pjdHdmNFFsM0duZWlLemNOTWZzbHUwVkV1aE5HYkVqOUtiR1k2?=
 =?utf-8?B?b003VE5XNTI5TnNtWERVMHBpNkdFaFhiVm1YV2JHQ0V1aG5GbGJZQzI0TDlJ?=
 =?utf-8?B?R2QrMEl0ZktRNXZjeHZORzdTTkpkenN5dFRwSkh0WGxQanphY1N3SGlhb1M1?=
 =?utf-8?B?L1BoeGxiWmhnMzZ0d2VJS3NCYUsyMGFBT0RQY2EwRHB5bEFjak9rbUNLZ2Rw?=
 =?utf-8?B?dXB2SVpmU0xjSWlIRWpVRWNoZzVWNDNaM0JteXhMbkNMcXVkQ0JGT0NNN1E0?=
 =?utf-8?B?aFRjNE5nVm5TY0l6QXlyaWhFY1ZGdjZRcVpDWUlKY2ZxNkpsK0VBRjlpT09H?=
 =?utf-8?B?cnI3Z2Jsci9QTHZZK0c2dWxxK3NQZXlNc1BvU2JrZTRJNk9wa0NJQlcyWm1x?=
 =?utf-8?B?R0F4WVdhT1JBeCs0VTNPVkZCbmI5OEV5SjJqM0Fxb1VGbFNFVGFIK2g5STFM?=
 =?utf-8?B?L0pwV0pxZ2Y5anpDQ3lpbTREY1EybWJFQml5UUltS3RRVE1SL3dhWUpZbTJt?=
 =?utf-8?Q?73CUlWbGUXCWbuLZCYeKVB/YGjRYu+H+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2ZjYzUyU2NVZzlSZnJaY21wRWlPYWhRNjBtQ1BvOHNweGJpS2xvekZPZHFP?=
 =?utf-8?B?dFdVYXZDdW1iWjhicjdOMVpDbUM2VkdPQ2FGUHhEdG1HcVBRK3pSUHRnUi9z?=
 =?utf-8?B?MXVXelFaYjYvNWVJMWNCNm1sekdCS0ZBQWRFam5DRURKK210YkxCVVFURnFk?=
 =?utf-8?B?VXBEVHBBSFlubGI3TUpnSnJqOWUrSGJCc3owZ0Y4T0xlU3BCV0l5MjB1bERF?=
 =?utf-8?B?Sy9WNkZTdXkzdUdHN3ErUVNodkptejNoSDQrQlRFNWdVU1pFM1NINGIySDkr?=
 =?utf-8?B?L3NqS3RydW5MeEErSUdLSDdjUUhBbWd1L1M0blVqbzUydVNEcHhvRkZJbGVr?=
 =?utf-8?B?a2d3ejlqQkpWV3lCRFhabEMwTTU5RWdpNjdvekFUdXMzNlVrQ3cyUUJXMzRw?=
 =?utf-8?B?MDczMnNQbzFWZzRsTFFVakZPLzdtNURHWnFwMFdJVlRKcUZjdi85bkRlYzBK?=
 =?utf-8?B?b3o4RGl0bEwzd3dxSFNlT1FSaGZnMGRsejZacC8yVENjcG84bVMyTjBHQVpC?=
 =?utf-8?B?ZE9kbzdzSFZiZklrbGpjV2hyWU9oRVczL3FydjZNbk44R205OFlCLzlQWkRh?=
 =?utf-8?B?eFlZNjZIM1JmMms2MHRGN0R4N3dyc0lxd3ZVV2FJbFpUN3pHbE5BSEVvRWlZ?=
 =?utf-8?B?RkxtVnJYdWU5VHJTTklPTTZTNFZNcXA1VDkvUjkzUEI4VFBHME9tL2dMWkRy?=
 =?utf-8?B?OGlSUXJTWkgvYVZrRTZvdFdzSmNvZjRxbHdmRzJlMFRHVVc0NVZqTytJQlRy?=
 =?utf-8?B?a25KM3NkV29GWWRCbEtXT1o5Ri9adkhYZDhPVEFiUzYxM251cHROM3JhNDll?=
 =?utf-8?B?MUlNdnJ6R2hkd1dSWjZkN2pXQzN2QnJBQlZRYlJUV09sSHZGb3lZVVB3WEpq?=
 =?utf-8?B?QTBsZExSVUsrdDhhTUNLc2VGR2xkWVRra0l0R3ZZY2xkZzVqSVpRN1E5dW1G?=
 =?utf-8?B?TW51MUJkNjliNklibURCOEdSK09xSGRmMmtKcnlzcHErYjZjaGZFRytCdzI4?=
 =?utf-8?B?REdMTFFhU3p0Nk03bU5CRGRsc3BMemZVTVk1USswUEw4ZkN0dWpoTEhoSlZl?=
 =?utf-8?B?SStuZ1EwRTVEM3h0QVNwYi8yUzNnUjB5TkdFNEhKOEpBckp1TGpFd2xxb0FN?=
 =?utf-8?B?UGxyclV0RVJvZngzZnMzUzRMMW5jVFhUeWZlV1JkWVovajQ1VEpEYUhjNkV1?=
 =?utf-8?B?ekxsNi9BdXc4OEEwYVFkUmNDSkJoTE9GdGV2aFQwNEZFUnJhcFZHQlJncExR?=
 =?utf-8?B?NHdoWDNHTlVPWTFac2VyQW5uQW1mV1dMdFE5Ymx4Nm9kbkVhdVZJVXh5UU8x?=
 =?utf-8?B?R0xFaERhaDhFZmNCdS90VzNpdm5RK3hTc2RwUTVjUW9OTWsrQ3RPUFpRa1Bk?=
 =?utf-8?B?NmNpSkNQcHBCYWVpckpQbmVPREdEeFBjS3Z2blJ5ODhiejJSdThXZWFJM25M?=
 =?utf-8?B?emZZUHZQOVVkWVdzTlY2a2FvZ2xZcSsvNkE4YzNmUzhiOGNLdkx1SDhtMlFq?=
 =?utf-8?B?UXA1RGkvajFUTytBMkJDRitRb01aLzdXOGJhRzRmM2s4L1gyTnhZTGtyTjVF?=
 =?utf-8?B?YXJxTDBCT2NKNEZDdUJKaHFSWWd4U1JRV1dvWjJBTzNXM0xvRHFFZ0lyeTZ2?=
 =?utf-8?B?c0EvSzNQRElMcHY4ZERHUEUzNjlmM1hQTEprY1JtZDU4aXhQUFU5YmNLSHVm?=
 =?utf-8?B?TVZKS08weXA5c1hOSHVSUmFhUHZEcGsxOWlLWTdkTWpPQmJiMzZrQVlQL0c0?=
 =?utf-8?B?d1diZXdNeWxmdEdQenZzcStqbU1XdVF5a3pVT3RYOTdZZ2ZNZU4wT2JSQmdL?=
 =?utf-8?B?ZGl3MllCVExOcjRiMEhnN0dWTHIzRUMrN3dJd3YxNldxTTdUQ0VMNXhhSUpJ?=
 =?utf-8?B?eUsyVmtHVDRxUlVCYmFGWWlTWUhhblg5VXRORDFrSHE5QjJsZDcyWnF5RHRx?=
 =?utf-8?B?UGc5cWJMQmRyL3Z2TzNHZ3htVy9xdnNXT1JFQVZtemMzMm9EeHl4bXIya21Q?=
 =?utf-8?B?eUd1dS9SUGExVlN3N1NGWVM2VE5lWFF4clBHdm14M2RUSUlSenkzZTZPTnRl?=
 =?utf-8?B?VWpOMkh4ZW1aR1A4NEZPL2J6ejkzSlNCa2EvRGE2Vmgwd3VPNmZKMkpxV1Bx?=
 =?utf-8?Q?5LyYHvg2jkqj9m2EU1z0JtvnC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d63ee7-13cb-44c1-965d-08de1c9119ef
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 17:31:06.6764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YpnpdePpa4Xr2jktLEZwnP5glVkEFmkoRSE7jNIchCSJspXMmpG8FH0P7MtVzm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076

Hi Dave,

On 11/5/2025 10:46 AM, Dave Martin wrote:
> Hi Babu,
> 
> On Thu, Oct 30, 2025 at 12:15:35PM -0500, Babu Moger wrote:
>> AMD's SDCIAE forces all SDCI lines to be placed into the L3 cache portions
>> identified by the highest-supported L3_MASK_n register, where n is the
>> maximum supported CLOSID.
>>
>> To support AMD's SDCIAE, when io_alloc resctrl feature is enabled, reserve
>> the highest CLOSID exclusively for I/O allocation traffic making it no
>> longer available for general CPU cache allocation.
> 
> Does resctrl have a free choice for which CLOSID to use?  (From the
> code, it appears "yes"?)

Yes.

But in AMD systems its the highest CLOSID (15). Also, this CLOSID usage 
in not visible to user. There is no update of PQR_ASSOC register during 
the context switch. Hardware internally routes the traffic using the 
CLOSID's(15) limits.

> 
> Could this be exposed as a special control group?  Or could IO be made
> a special "task" that can be added to regular control groups?
> 
> e.g.,
> 
> # mkdir /sys/fs/resctrl/some_group
> # some_group IO >/sys/fs/resctrl/some_group/tasks
> 
> This would assign the group's CLOSID to IO (in addition to any tasks
> using the CLOSID).
> 
> Or, we have some special file:
> 
> # echo foo >/sys/fs/resctrl/some_group/io_devices
> 
> This would assign the group's CLOSID to the device "foo" (we'd need
> some manageable naming scheme, preferably that maps in a sane way to
> sysfs).
> 
> 
> I'm not trying to rock the boat here, but for MPAM we're anticipating
> the need to be able to control the CLOSID used by devices that are
> behind an IOMMU.  (Arm's SMMU allows a PARTID to be configured for each
> device I/O context behind the SMMU.)
> 
> This is desirable for assigning devices to VMs, so that their traffic
> can be managed alongside the VM.
> 
> 
> Do you think SDCIAE could fit in with this kind of scheme?

All these things you mentioned can be done today without SDCIAE also.
It does not need SDCIAE or similar feature.

You can consolidate all the IO tasks into one group and assign limits or 
monitor. However, resctrl does not have the knowledge of IO devices (or 
names of the devices). It only knows about the tasks.

> 
> 
> [...]
> 
>> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
>> index 108995640ca5..89e856e6892c 100644
>> --- a/Documentation/filesystems/resctrl.rst
>> +++ b/Documentation/filesystems/resctrl.rst
>> @@ -152,6 +152,29 @@ related to allocation:
>>   			"not supported":
>>   			      Support not available for this resource.
>>   
>> +		The feature can be modified by writing to the interface, for example:
>> +
>> +		To enable:
>> +			# echo 1 > /sys/fs/resctrl/info/L3/io_alloc
>> +
>> +		To disable:
>> +			# echo 0 > /sys/fs/resctrl/info/L3/io_alloc
> 
> "info" is mostly read-only, though it does seems a reasonable place for
> per-resource global controls.  Today, there is already
> "max_threshold_occupancy".

Agree.

> 
> It doesn't feel worth trying to introduce a new hierarchy for this kind
> of thing, but the name "info" does not suggest that there are writable
> controls here.
> 
> To make it official, does it make sense to add something like:
> 
> --8<--
> 
> diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
> index fbbcf5421346..0cc9edf8d357 100644
> --- a/Documentation/filesystems/resctrl.rst
> +++ b/Documentation/filesystems/resctrl.rst
> @@ -72,6 +72,10 @@ The 'info' directory contains information about the enabled
>   resources. Each resource has its own subdirectory. The subdirectory
>   names reflect the resource names.
>   
> +Most of the files in the resource's subdirectory are read-only, and describe
> +properties of the resource. Resources that have global configuration options
> +provide writable files here that can be used to control them.
> +

Yes. It is reasonable. We can add it. How about this?

"Most of the files in the resource's subdirectory are read-only, and 
describe properties of the resource. Resources that support global 
configuration options also include writable files that can be used to 
modify those settings."


Thanks
Babu

