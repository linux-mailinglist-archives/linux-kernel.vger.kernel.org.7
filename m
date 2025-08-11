Return-Path: <linux-kernel+bounces-762458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8482EB206CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E8F18C1ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592B2BE7A0;
	Mon, 11 Aug 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g628liCX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6A2BE7A3;
	Mon, 11 Aug 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910252; cv=fail; b=u8o0uT+j2m28SF+lsaj0tRqvphDFgHBtWlm2ud5e4qwMDtnXdudmeUlXbOHlZGKumG7xFd9jAVbXigYywN/LsTptrKg33aj8/bvkT4L2s7/nM47RqWTe19dMtv3snytztz7hqjvfvpvXWANeyH0Pg1x0iCNEm2LcsFpuHbrDdF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910252; c=relaxed/simple;
	bh=mzRI3McxAF11SulI4WhY3ucdxyW0OEFAzhPlJxJcFik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GyUd8+lyf5M+uMXT3SGnCak4zo/lmSeOhmlTdBDfkatI5y/Ah6CNKFYsMEzwWs+VbaZCZ0S1j8DhLvWIB6wLv/y8zxa2KEGnScnLG+eJp0ItdqpaQlfTWHp4l16M9WqMDvPy4ZU9sQjPvuHZzH15VqGdVRsgLXrYsHKVupPs58M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g628liCX; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2jijBflZwtcBgsi+waXHalA15HwgYFty/SPud6BLCgR6/IET1/YWFbzKnFnqt3QlyKZjD/bxscUijCMux56ucFsNWdrrX8LgAXiFMzh8QNZHbl7MHDTQYRat5bieZPV60AhlWx87RRphj1NvgXUpqUdDYw+TZnfl5mwuEwx7mLL7tgWA7d5QW+kvw8lMiUfC7i4OQF89URyPL8PdDVCmjGvDNgNIFdr/9K3qe6GB0wCzSlhvv4V5eSuavGAgUVgy1+hX5ngRU4ZvsZ0dncEoPHEUS96omEd5slx0CSEmzumfysVUDXhLcPh6OyfQVXRrxMZxZOKA3+IV45cGdrdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdAK6cjuWcTRGlTwQjxbcWFPEXmOw+D5ClRxkUaSXVk=;
 b=GrlNxRBdM2K2P+lfsyvZ+UvloACexgRJ+o4zwyrnOzse7o1pnpmMrzjzCvJCSXr+i87gSiRVkGo1eSHp5smHz0zEGjTU9R2vSu5B/+lKQ/aL6Z5PnT9Uq8BbaTLii50QHOXINqSjrI075WwSTJ0j+prwgbfZs1exoi7lOohX+BgAL5qD0NnIbs7tBccUyrEjgLFkUTM/X9BPLSxu5HmSn/uzRF+Lfc9q09fFXYecbmzHqxMx3wJyCFUkwinhJNIW3q0nkB0YJiDeUI+SpmyBaQlIolE066oZfXu0XTk/c2Gu698/P51yDy01Ppjd/CA1WkhAjGltm1X0xJWX60KpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdAK6cjuWcTRGlTwQjxbcWFPEXmOw+D5ClRxkUaSXVk=;
 b=g628liCXD97rAo4KG506RrXhj8xNsSSZgDJ0lRZh6fGNQER69AsdrCxzbTaxVrs4NaEL8CrdMsdS7WDm767k2poahxA51aUeshnzcPu/dGRNgv49LHq99lw8gLXc87aeacv7Lck1PvxBa0FFV4/t8mm3P/VA4qTnC53RAC+hnmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 11:04:01 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:04:01 +0000
Message-ID: <a03dba0e-1739-41e0-8607-7e4371d6df78@amd.com>
Date: Mon, 11 Aug 2025 16:33:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] misc: amd-sbi: Add support for SB-RMI over I3C
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-2-akshay.gupta@amd.com>
 <67c98aa0-575d-4c04-a4e8-fe0df0d1a3ef@kernel.org>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <67c98aa0-575d-4c04-a4e8-fe0df0d1a3ef@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0108.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::12) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|PH7PR12MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a48d4f-c4a4-42f6-f379-08ddd8c6c6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3dlM3pXU0dGNGJHTVJJTVN1R1R6aUtKeGlRSStyOFltNUc2WExMOG0rOUhF?=
 =?utf-8?B?NnBaU1hFSEt4cXlTVktaT3QvM0t0dzNkdHNYSmJBWlpWTG1Ec3lpWDhKMGds?=
 =?utf-8?B?SlhUMG5vTFJVUHJBNllSZUh1cVFWMnZxU0NJTFJjMnNRSGRES0lweHhOMW55?=
 =?utf-8?B?aG96V3MwdlJSOU9DczlOVFZHejZFV2dlWlB5T0ovcFBTMDlVQlcrb3lMek9K?=
 =?utf-8?B?TmFXYTJoVDZ6aHJmUnNYeUFPUUd3bHluT1ZzQ2FBZ1FVRm5aL3RSZ0txeWtH?=
 =?utf-8?B?czByMlFkWFBLZVVETllrV3FXUytzUlBtZWlrcGVCNWpSMGd2aTBtTnJlU0FC?=
 =?utf-8?B?YzNudjBtWXVIUS9BSy9UM0VpKy9QdDkraWcxQVQ0U0g3bXAzRVBJejN4dENL?=
 =?utf-8?B?SWlHM0s4RDl1WWhtVE8wQWNOWWV2N1h1dEpnZjBLSUlCOFZPc3AvZ3lZUVFz?=
 =?utf-8?B?cVhnVWcyWUFUN3dmM01oZDBqNHg5Z0VaUHFRYWlvb25DRGhtcUlweVRRajht?=
 =?utf-8?B?ZG9yR0lmdjVnWlIrNEE4RHpERDVNWGVxK2Z5TmJ4bHdSdmxQNkVEc2NEZzR6?=
 =?utf-8?B?N0E3VW8xZDlhMW1OSWU4cU82VnZMamdNQWordEN4Vm5Uc2VEazNIV2U3N2x3?=
 =?utf-8?B?clpUZEhMNUJKdThmbVlkY3Q1bTdBc0hLZk93VlZsaGtXY2ptTVhIYlVPS21K?=
 =?utf-8?B?ZmdkbW1KTkdrVmcxaHZ5VmZnOTV5a3NGWFNTa0JJSFFZWXA0L3c2ZGw0OHhW?=
 =?utf-8?B?NzF3Qk92STZjUUExTzRWT3NCSTMrTHBwNWY2MUZOMVVwdVJlb2VSdTFmVXZG?=
 =?utf-8?B?UDB4SU41S1dRb2Iwd1JSRThhS2pwUFBqcmpvV1hpdmZabFVwd05NeVdtcFNq?=
 =?utf-8?B?SGcxRzd3UXNicEduRXFpMStwdGU1Y1ptMXFkc01nSHpJQ2kxT3E5dEpCOTFt?=
 =?utf-8?B?VHB4ejd0WXlveExyTzdISnJRWjY1QVBnUWNZazlGRTRKdmF2QVhCY0M1Um53?=
 =?utf-8?B?YWJ3TzBWZkhyRWo4YlJXOHorZTZ0WFNyOGRJc3JBN2ZvZ01Yc1V0c0NRQWht?=
 =?utf-8?B?NGpKWFQxRVg2eVN1dU1kc2JST2ZjUXN2MktiVElhOEZSUExzVm9qL0xWRGFI?=
 =?utf-8?B?QjVvU2ZVbDQrWG5WVUgyMEJ3T1JLOGFJb1hkOHNhQmw0WWNKU01Vc0tndHdQ?=
 =?utf-8?B?Z3d5MTNWZTdzRlp5dDdtc1ZFb3U2UkJmZVVmd3V2SE84dmxHZThIZXROYi80?=
 =?utf-8?B?Z2dlUUpWU1lITkdwUWpNdVFaY0FSTWRnRWZ3U2NUK3ZUSWxLWHVBeDNpL1N1?=
 =?utf-8?B?SmI1SlJiNDJsUWVWNmFWbFl1ekVMNXlWWFJWVHR4TStOeW5QN3kwSmt4ZUVJ?=
 =?utf-8?B?UWRhMkJJTWNxMXRNOUI4WXF6bWhyMi9WMlpsY2sxc3NVTGpYam40ZzcvZUFM?=
 =?utf-8?B?VW9MdlVJNW90TnE4TW1uTmhoWThIajYrenFnVHdTQ3JUOHJWWVBnYmFNalVq?=
 =?utf-8?B?UXZzeHpLaEd6Q0h5ZStMelpXRmk1RXFTajZkSk0zUWVqTkliM0V5UlhTd0FH?=
 =?utf-8?B?UDZML0JLV3pPeVdNdEJaSnR6S3VnNStLMXNNOWE3cWhXaEpYditGaWJSdHlr?=
 =?utf-8?B?Zlhnek13Z3JFaW5FWER4K29lb3dEOXM1NmNHZFl4Q1YxVFV2QWtyMVhJbkRD?=
 =?utf-8?B?c0IvYTlyZzdzR090UlJyRjZJT1JrUlVsNlI4M1JZc1NuUS9wd3ZsZ1QrTmFx?=
 =?utf-8?B?RlFtY3hrV0VlMW0vcmxsc2dYeHU5K1A4V0l6S3lRYnVpUnRXeUFFTDhSM0RF?=
 =?utf-8?B?REdIem1EWGg4VVRPTVBhZlZ0RkQ1eDB3Wnp4SVJHeXpqeDhBNXFKTEdTMUpZ?=
 =?utf-8?B?dGM0djJNb1RadXVkaUNrZmpKUlhKRDdZZ0NJYXVZM0xNT1VRNFJvcUUzZ3ZQ?=
 =?utf-8?Q?PFnqEbKWe9k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWVGd1NXMm9kQ1o0bFcrUmlVZ1hUQjNXR3BPYlpJaWZBbzFVaithOVlraE94?=
 =?utf-8?B?b1oweUZ2TEl4T05rU0ZlM3lWa09NUzlrYllzTk01ZW1pb0VqL3Zuc2x1SHJt?=
 =?utf-8?B?NkRqbGlRdkxjK2t1RVpuRlRSLzNPK0VoekdyVnNUQTN4dUJSYndscksrbFkx?=
 =?utf-8?B?T1FhSUp6UVpBL1JuRGxJejJsWEY4ZTcxSi9tSzRDWUtPSWVwVWM4UFN6RHpO?=
 =?utf-8?B?S3RwVG5pREZCbGdpM1hIcVcyUmh6TWxOeXVsNEg0NlFpcmVqMnI5b2dCeXZ3?=
 =?utf-8?B?eWR2SDVhdVAzVUpTSlFHWFdXbzYrYWNEK1RMM0pXUVJRZkJGZ1RhUHp6SURJ?=
 =?utf-8?B?QXNvVFVGeDQrVlcyd3UwL25PKzFYdHpyQnpHYk9PRzR3bDExV2VJSmwxQjZU?=
 =?utf-8?B?alMvaFdMNndVSWR0V0FBcnZNdE9tR2FqZnQ5QTV5QWdqUlRCbW5ZKy9nZmVT?=
 =?utf-8?B?UHhNOEtJQmpTZ0FxQVYzdS9vc0NENDAzUTdlSmw1RFJUM1daemJRcG85SzdO?=
 =?utf-8?B?a2E2NDAyM0cxTHkvMzFNRGRlSzg5VSs3bG13UEFJNVZvenRnWG5SZVBmUzkr?=
 =?utf-8?B?Wm1wOFNzcGxZU1Z4U3lVdVVnWmNxcnM3ODUwUThERVdYQXRTTzcvRFpYZGFD?=
 =?utf-8?B?ZDI2MlRJLzJvTC9pQThZcGNLQlVCcjh1bjl3ZEJ3d015UENPTG4rK3E0SUJi?=
 =?utf-8?B?YWJPcmUyNUJDT29Fd0greW5zdy81dms3bjlNTlBiNGltUjJKcSs5Q28zNXF0?=
 =?utf-8?B?TnRGYUhvY3VDcVFDK2ZjdXgyb09QMDRhRURoNkFNS0twRU5WWXp2U0NKdURn?=
 =?utf-8?B?NXE0RmovM2dwbTMvNlZsQ00vNFhKZ1doZTV3cDM4QS9ESmdSN250M1pkSjY5?=
 =?utf-8?B?dG9FT0VuRUlkajRSbHYvY0pEWnI1OWJldFR3L0FzMlVTTSs4L2ZUa3dpMllN?=
 =?utf-8?B?ajhOUDNpRG1NcUxvck8vSm01bFcrbE9FQWpXS2lPMU4vRlhoZWs4Rm5lblRT?=
 =?utf-8?B?VXg4ZWhKMDNWaEh1L3ljVkUxeHpiN1VIOHZhbEZmUjBGb2pNSTJscXkyZGpx?=
 =?utf-8?B?RHJuT2o4em5jUWtOTFR3dFM5VlJsaWQyWE12b2NnRmpvM0t5eVRtZFhoM0th?=
 =?utf-8?B?ZjJobE5HN0wrcmVvUGVVamRDRnpxaHRmbjVZdm5aY1JkN0xGdnU1N0c1Rlkr?=
 =?utf-8?B?UjI3NDJ6eDZYZkpTM0VTU0dWclVST0Z1U2Nvd1NobjNXV2F5RHpPWEJtR0NR?=
 =?utf-8?B?VXFXSU9aRzhUZ050OXQxU0N1S3ZHVFBtcmJsdXVLYUFadXFyT3VGQU1NWHls?=
 =?utf-8?B?Y0IwQ0RzZm51WXpPSWRhWTNyQWczVUFDaE56OCttbjdGNnlHaWlwMTQvcXhL?=
 =?utf-8?B?Wk5ISHlWbVpuaC82UGlrMUd3K0VYYkRjY1BZZ3p0SkMxSnU3TXZTYkFZUEQx?=
 =?utf-8?B?VmxFcEpDcHkrSisyL1M5R2k2emR5Ky9Ya2xsZEVmTXJDT1VSbXZvaWtGRkRG?=
 =?utf-8?B?aStpY3JVaGRSUk9IQmZhSjl0Y08xOWRvNExjR0wyL05DSTEyTzNYRkhQOGNi?=
 =?utf-8?B?TVlYU2V3NytHcU9kb0d3T3BkcjYzOENmV1B5YzVSeFVXbnpITVZvcXhZMFBi?=
 =?utf-8?B?OFlkbmw3RXhsNERoeDlxOXBxR2lYaDhySUpxRFM4bFJUVXFMcGx5aW5oZG5G?=
 =?utf-8?B?ck5xUjY1bkNLd28zNFJmVTBncnpEYXNSMEt2aFc5STR1eXRKOHRiWEE3UzE5?=
 =?utf-8?B?clVkZ0xKRU1zSHZRdWpyeGVKTHBHY040VUhDZlprbC9jc2pQVGl1SnN1MGVq?=
 =?utf-8?B?U0IwNjVZYkt3L2dabVAvLzQwMWFGQlQvb3k3RmVGT1MvUEpQTWtlQ0ZkUm1s?=
 =?utf-8?B?dUJHcjI5V2UwVVExRS9tOTBTS21EUElSRXhENU9DRnp2ZkVPNTNNVmJpeFI0?=
 =?utf-8?B?MnRZL0I1Z3NkbWFqb1pLZ2JVYTdPSTRtVi92Yk0vVUJqUmZlcjYxUXlTN09S?=
 =?utf-8?B?cHdoTXQxdEZPTXU1UE9SZ3pMZ0FybEJNVmdzbzZucjVsNW92THdjMnUwWU9i?=
 =?utf-8?B?UnhPeGEvRHJpL0hvYVJFbXF4blBEMnB1M0NSNGFhTzNZdGZSYS9jZmI1dDg0?=
 =?utf-8?Q?ECi/ILavXkZrXgGOxazV9SLjW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a48d4f-c4a4-42f6-f379-08ddd8c6c6fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 11:04:01.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTQG/4/w36+16MLVUPJn6rCSV5adHxrBrjkzY5jmS9XwCY+re/FN9dTc6/WRIrsE+er2TFdMV8+rJqKilkJu+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914


On 7/29/2025 12:03 PM, Krzysztof Kozlowski wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 28/07/2025 08:10, Akshay Gupta wrote:
>> AMD EPYC platforms with zen5 and later support APML(SB-RMI)
>> connection to the BMC over I3C bus for improved efficiency.
>> Add the same functionality supported by rmi-i2c.c over I3C bus.
>>
>> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
>> ---
>>   drivers/misc/amd-sbi/Kconfig   |  15 +++-
>>   drivers/misc/amd-sbi/Makefile  |   2 +
>>   drivers/misc/amd-sbi/rmi-i3c.c | 133 +++++++++++++++++++++++++++++++++
>>   3 files changed, 148 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/misc/amd-sbi/rmi-i3c.c
>>
>> diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
>> index 9b1abeb6ab1a..838cf98805d9 100644
>> --- a/drivers/misc/amd-sbi/Kconfig
>> +++ b/drivers/misc/amd-sbi/Kconfig
>> @@ -15,10 +15,21 @@ config AMD_SBRMI_I2C
>>          This driver can also be built as a module. If so, the module will
>>          be called sbrmi-i2c.
>>
>> +config AMD_SBRMI_I3C
>> +     tristate "AMD side band RMI support over I3C"
>> +     depends on I3C
>> +     select AMD_SBRMI
>> +     select REGMAP_I3C
>> +     help
>> +       Side band RMI over I3C support for AMD out of band management.
>> +
>> +       This driver can also be built as a module. If so, the module will
>> +       be called sbrmi-i3c.
>> +
>>   config AMD_SBRMI_HWMON
>>        bool "SBRMI hardware monitoring"
>> -     depends on AMD_SBRMI_I2C && HWMON
>> -     depends on !(AMD_SBRMI_I2C=y && HWMON=m)
>> +     depends on (AMD_SBRMI_I2C || AMD_SBRMI_I3C) && HWMON
>> +     depends on !(AMD_SBRMI_I2C=y && HWMON=m) || !(AMD_SBRMI_I3C=y && HWMON=m)
>>        help
>>          This provides support for RMI device hardware monitoring. If enabled,
>>          a hardware monitoring device will be created for each socket in
>> diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
>> index 6f3090fb9ff3..e43d4058a0f0 100644
>> --- a/drivers/misc/amd-sbi/Makefile
>> +++ b/drivers/misc/amd-sbi/Makefile
>> @@ -4,3 +4,5 @@ sbrmi_core-y                  := rmi-core.o
>>   obj-$(CONFIG_AMD_SBRMI_HWMON)        += rmi-hwmon.o
>>   sbrmi-i2c-y                  := rmi-i2c.o
>>   obj-$(CONFIG_AMD_SBRMI_I2C)  += sbrmi-i2c.o
>> +sbrmi-i3c-y                          := rmi-i3c.o
>> +obj-$(CONFIG_AMD_SBRMI_I3C)  += sbrmi-i3c.o
>> diff --git a/drivers/misc/amd-sbi/rmi-i3c.c b/drivers/misc/amd-sbi/rmi-i3c.c
>> new file mode 100644
>> index 000000000000..b960743afad1
>> --- /dev/null
>> +++ b/drivers/misc/amd-sbi/rmi-i3c.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * rmi-i3c.c - Side band RMI over I3C support for AMD out
>> + *             of band management
>> + *
>> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/err.h>
>> +#include <linux/i3c/device.h>
>> +#include <linux/i3c/master.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/of.h>
> Where do you use it?
Ack, will remove.
>
>> +#include <linux/regmap.h>
>> +#include "rmi-core.h"
>
> ...
>
>> +static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
>> +{
>> +     struct device *dev = &i3cdev->dev;
>> +     struct sbrmi_data *data;
>> +     struct regmap_config sbrmi_i3c_regmap_config = {
>> +             .reg_bits = 8,
>> +             .val_bits = 8,
>> +     };
>> +     int ret;
>> +
>> +     data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
> sizeof(*). Use recent coding style, not some old, downstream code.
Ack, will update.
>
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     mutex_init(&data->lock);
>> +
>> +     data->regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_i3c_regmap_config);
>> +     if (IS_ERR(data->regmap))
>> +             return PTR_ERR(data->regmap);
>> +
>> +     /* Enable alert for SB-RMI sequence */
>> +     ret = sbrmi_enable_alert(data);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /* Cache maximum power limit */
>> +     ret = sbrmi_get_max_pwr_limit(data);
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     /*
>> +      * AMD APML I3C devices support static address
>> +      */
>> +     if (i3cdev->desc->info.static_addr)
>> +             data->dev_static_addr = i3cdev->desc->info.static_addr;
>> +     else
>> +             data->dev_static_addr = i3cdev->desc->info.dyn_addr;
>> +
>> +     dev_set_drvdata(dev, data);
>> +
>> +     ret = create_hwmon_sensor_device(dev, data);
>> +     if (ret < 0)
>> +             return ret;
>> +     return create_misc_rmi_device(data, dev);
>> +}
>> +
>> +static void sbrmi_i3c_remove(struct i3c_device *i3cdev)
>> +{
>> +     struct sbrmi_data *data = dev_get_drvdata(&i3cdev->dev);
>> +
>> +     misc_deregister(&data->sbrmi_misc_dev);
>> +     /* Assign fops and parent of misc dev to NULL */
>> +     data->sbrmi_misc_dev.fops = NULL;
>> +     data->sbrmi_misc_dev.parent = NULL;
>> +     dev_info(&i3cdev->dev, "Removed sbrmi-i3c driver\n");
> No, drop. This is useless.
Ack, will update.
>
>
>
> Best regards,
> Krzysztof

