Return-Path: <linux-kernel+bounces-742954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CFBB0F8B6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5851D583B37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9921772A;
	Wed, 23 Jul 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ivigbyzS"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336817C91
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290683; cv=fail; b=htfCw1y0y3jGsre4S7ViNF0cEsUniaLuRL6n2DN2MrANQCgh1/ex16y2xzBcMQ6Bw+kmZZMwm1gXIyki5OEw760gkKXwZKATIxNJqaLQMz4yYdPHpPqi8cyqLD1ecnRH29MUJhBnzud1mDMf7FXx7Wi80WBfKvwC3LBaQnlIHnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290683; c=relaxed/simple;
	bh=R0VhGN2gI8mF+0sYayYkWtPOAQs0dlGX7LbxTL/HDOo=;
	h=Message-ID:Date:From:To:Cc:References:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=eJIdGVLn7YWyjXYxNCEChK4jADzJrrGqF8AyZ/jxwWKEerx47MtAbVZoqISGS/9+FhxD1mykZ+ZY+k8HXRsJT08+SqZtNN6EWOVQ9VtzcxZNEmVnOJuXLGmyy1YH5dT8iTy8gdSE+bBjGkAhANe6iir0Ns7wmBDJ/WEDBVZbCv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ivigbyzS; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIvUKS+Rc3oaDeWoULLy6+hbIY/CuJEaAjntZT8K5O4hRKz0ax/y0bagAYtZsNzcylq7xRa5a7A6/mX/e0okwxJPw0cr0Vgx26Deh62hmmUswg2uF8RqXAprz4gJICuKo28LIyDVGp1PSWo7nGia+g1+XOgJLNGqRjfO2UJIjBeuDL1nWr+6OEJX+LUn9YDTmXt2eooSJReudMmSWiCTjoWsw+RsWWSaksXMk5OiW7XshenG9p6SRR21Vq1Z+yiooN/XV5UqgRkU4AiI679kCON7cnDJpQC6cQEKEPCfb3YgIqfZk2HDZG+dp75pajCAhvbM6rCVDyXMuyn4XrGF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p383f9ij8mq45PueIr370123IVItmel6xlfn2d1myAI=;
 b=C8lT/AEoYu++Hzsumd78JeCkozYmNjIvJ11VfYQFS9MmLz1H3EZrjBqgeZ1a4Fo0SwEnEuk1fGb5NUVj1jUH+ZLZRRffrn+C1DpOz9rhKFcvZjjutGWmm4RMxWXu1qiobFn7+N6+z96DCF+XnK4wHUnGlcqCYH2DgQoXX/+onbAlruYpIDhHZpk7hr2cv7Kpi7IJ3YRYqSZauSXuKmn5YfXml2w8Ue2vrBZfpWUJOyYS60gGjgBfeRDiFRXK+cNiytPnXrq+W9i5V0FbfHZXxnnQriikALX1ZFI7svHaSx5xGuu0CKocGznkeI9Oil9SYxNy2CBnVBwHg5l/b3+Qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p383f9ij8mq45PueIr370123IVItmel6xlfn2d1myAI=;
 b=ivigbyzSkjzeINiXpRHyM6fsgGAi3SEyhduy6Ym2XduocR26orvAXRtwQJlR4PXf6A096Jt3xN6OyIv9BCps/aFCuKQ4lkGA5FlqAeEyD1NUyBcgZ3alPiKC8gIAJYd0KZy0GTlkEZRBwox5WLm3SStbzhThxwvd+R0rlsTsZiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 17:11:18 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%6]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:11:18 +0000
Message-ID: <5aa1c496-f790-4a02-78ce-3590ff340d70@amd.com>
Date: Wed, 23 Jul 2025 12:11:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/CPU/AMD: Perform function calls post ZEN feature
 check regardless
In-Reply-To: <ee4e9ea71713cee72bb637e848c6a272f8a9e631.1753290066.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::32) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff51095-01d4-4cdb-ed41-08ddca0bf07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Szk1MFRvT29MSjZPMk9GM3VvaGcxb0VOa1hVaUt0Q0M3RWxxRXpkVVNPV1R2?=
 =?utf-8?B?VGxUUnJQMkw1UmptS3RDdkY0WHFlWlpjVVA4c3VidlI3bjBJVnc2STVhTFpG?=
 =?utf-8?B?dEc5czBYQUlCSTJrQUVBRmhWQUlVbC9ONmRKK1I0bi8zaXo5VmhoeGMrekpG?=
 =?utf-8?B?RFJUckgzSG9vMkRPbXJqOWRHRDNTRnVlTStEOEVRVmVzVFROT3BBYVpKZWl4?=
 =?utf-8?B?cnR3YWt4S0s5YU9NTHM2UUUwcTU1bWJXdW9kYWdCNE1qMG1HYjJyZUZwUTYz?=
 =?utf-8?B?Y3h4NUtGUUlvUFZCTFYyQjRFeVprTEpIY1ZYRjhFdzNPZTBJUGdkdHF5aHFn?=
 =?utf-8?B?ckdFbVpIcEpqTkpMTzc1VVdib0xRWElSYVFoQlZVR2NGOWZDa3lad0hvSDdt?=
 =?utf-8?B?aU8rdHI3Rk5oM01qZGh5dGpZdXFmWXJvQUtKTmJZZldLWitaMGZ2Q0JxMDU1?=
 =?utf-8?B?b2hkblJUeWxUN2xQWkZrMEoxelpuSXdYbm9UQVBxYkY0Z2xNOHZsRGFaWG1V?=
 =?utf-8?B?Y3d6NFlTQ0R0MVVEUmdGWloyTW1PeEdZdktac3pBTEpsN0Q0VXpOYmExZGtr?=
 =?utf-8?B?Q1RxalRUV2tkQ0svWitvMkNlODhXUEpCL3VRWFRFQjBDMS9rYmFWc0pCazgr?=
 =?utf-8?B?S3IwUXFGQkxTRlIxUGtLRW4xcVh6VHBFR3JZRFZsNDczd013YngxT0szb0tF?=
 =?utf-8?B?dG1sanR5Q0k2VmxjekNYNFZROFF5SnlPRENrSC9wcVJ6WG00WDNtVGtRVkF2?=
 =?utf-8?B?RkxPNHdYZ2RKNzg4bWhFM1ZWTERJbHBPSGVobGpuYWYwN3U3RXhZcFVJYTQy?=
 =?utf-8?B?SEhZR1lYR0VhK1FDbzArTWQ3S1BZUitUNjRLaTVXTURtbzZEV2w3cEdXemg0?=
 =?utf-8?B?WWdzZzJ3dmtLekxiNlNPMExEZm5JZXdjNWVLUjhZUVVXZEFjRHdtb1F3UzFE?=
 =?utf-8?B?clF2ZWdOak9vVCtlcHFXUWZyZnM4dXJFby9EN1kwRGxsNlZYdXNPanVSdlRZ?=
 =?utf-8?B?VDNuQWhWZTRTMVp1WjBPQ2NBR2Jid213TlBwVkdCL2VHOU1SaHNvTHlvQVJU?=
 =?utf-8?B?elZvamNhWWx6a1BDMUdQZXFxc2RFbWxXUU8xVE1PVGZRcGRhUDN5bU0wTVVK?=
 =?utf-8?B?cGlDTXpSMEhzNXE2VE1tTTdZUE1Zdjloc1gwN3BSbU9SNkFuNk92YUp1Kzlh?=
 =?utf-8?B?cmxYYUZHZGpLaGphQkErdWNpc1pxVkNidDdlVWtUN2JibDdrczFZa1pkb0hT?=
 =?utf-8?B?KzZJUkgyVmZ3Y0Y2amJlMDByN1FnTEZYYkhkRHcyQk40UU54YlVCWEgzZFcx?=
 =?utf-8?B?VzlQeXdyM3JjTjBITzhHa2FaUTRyQ3FqWjFkVStZNzFsV0FnQVJyM0NKQjdX?=
 =?utf-8?B?emYrU0pGVWphSkRtUXFuNEVWM2tBa1lnUEZlQXpkbTk5Z2ZTTmhCWWM2VGZZ?=
 =?utf-8?B?ZkJPS1ZpTlhxbFdpcmdJOHVNcUlQaHF2cTUvWThQN3ZRd3RYQ1g1VjM1MndN?=
 =?utf-8?B?VE52a1ZaanowY3l4S010elNaM2hIeEFhblRlMFpmb3BSSjRBRTNpZk84VEFE?=
 =?utf-8?B?VXdwZWFGekpQM2lOdFZDSGlhbkN1UmpVOCsvejJtRE1HbEtrbkRPZjVkeE0v?=
 =?utf-8?B?MDdCVFlUZnpmQTBLbUlIblJUTGxIYTdSYmQwOHZJSXordjd6Z3dhM1Z2NkFs?=
 =?utf-8?B?ZDZmYWpHbmk4VjhoajZqTUpibGJUVkRROGpzVlU3Ui9PNFlqQUQvRXg3VDhQ?=
 =?utf-8?B?ai94ajRTdHF6Y0drZW02YUQzTnlSdEdBU3M4QVlIK1hsNml0Nmdha3o1dk5s?=
 =?utf-8?B?WitLYjNsQkwyeGk4L3pVNldBelN6dkNzZ2IxcmxKSWw5Ky9qanZxOWhRdFpT?=
 =?utf-8?B?YW8wbkh6R0I1QUV3WEJXdEJlb3Q1Lzg3MHh5dnhpRDFVdGxRd0NFRVg4MVh3?=
 =?utf-8?Q?9BJ4gNNMA1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVlZN0NkNkFnQ1RhMmZGV2Q2ZURBaEczaVcwWWIwZTJnTUxmOThOS0tYdHZE?=
 =?utf-8?B?eFVRbGhqQlFneTkzZU5tVWxSYXFRdi9SczNYbTQrOXFrK2J2Q1FmQ0xWeEln?=
 =?utf-8?B?b0FNN1ZSQ09wQkttMm44T1pmTDVMRXlidHIyZFZJeExqTVVkYWpnbkpZTDMx?=
 =?utf-8?B?eVQ0bExabHhZaUZDK0J5VTBvcHlTTUQ5M0FZZ2dwQklBUXlQODdWbkVtRzFz?=
 =?utf-8?B?NUU3ODdSZjdlR0pHRTZqMG5FOE80UXVkMU5wVmFuZU1veWtOMWFtbkkyQ0pG?=
 =?utf-8?B?SlQzU2dmZDZVbHpQdmkyMG9rZ1NkYnFCM1hYd1NsNVQ5cDgvQk5URlZScDZX?=
 =?utf-8?B?OWxkOUNYN3VIU2R5NGxMYm10bThjVTNSdUJBVXB2UC9VazhrNnd6TklCNDc3?=
 =?utf-8?B?aE8vVmdxSmJIbjJCR2gxQlljUTdEZDV1cCtSeW1SNU1NMW5RTjJGVGZySE9S?=
 =?utf-8?B?VWJ0czhCdURPL2pWNkpwVCsrZzhaNzRJOGhRVzIxQXBpbWpBVTkxcmo2QkJD?=
 =?utf-8?B?VVZGTXBsYVZzL2E2dUE0L095NU5BYlUzU0o1eFVWbExkSTE1WXNJMTAwVVRW?=
 =?utf-8?B?THdnSkJCWVVkOXJjR0FQWFRkVHJTWFZJUjAzeUpGTVNzVzljZzIxbjRyM2RN?=
 =?utf-8?B?YTBzV3hUaS9pNVR4V1RQUmJJbUZRTkFrVGw1ZWpVeUpaN1RQeGxxSUlwdi9p?=
 =?utf-8?B?RUJoUFpxNHFWTEplbmVZb1hYK1ZiOW1XdTBJQ2RtNGFkMVZrc3dYWVBuSnJY?=
 =?utf-8?B?QytSWGlVNDRHMG50bDJWV1hTNUNEK3BuTy9ubTZ1M25rcnNibkp3UlRXczBm?=
 =?utf-8?B?YmxOQ1dUQWJucVZvRUptZ0xHd0RBUWNkWDJlUDhEUGEzREN2SU9NbUZJMHdR?=
 =?utf-8?B?eEp1WGxGVWVpejhkQmhqZFhXaEpzN1pmK3M2R3hWWTRXb2pnTUc3K3haQUtK?=
 =?utf-8?B?NVRybys3dmR2ZUwvNTFLQlE3Y3VodGZVMXNtZkNnbzhLVUpLZSswQzNhS2dY?=
 =?utf-8?B?bUVYOUVjMWRWWXFHLytRQWZldEloWTB5OVd5MjU5ZXFORmozMDE4NDlWMzBO?=
 =?utf-8?B?cDV4QmJDb3ZsWElKRWlwUjBvTTlpSEhXcGJiUTlHMm1jeGxlU2N3TWNiM0dw?=
 =?utf-8?B?MnZ1MEJsV01mZTEyeGxmSnhxbklMRkNkajl4L1lNZm1ma0FIVkg4WG9aenhC?=
 =?utf-8?B?cEdoTHEyOC9tY2Q2U0wzNWo5NHdSZERndTFYZVlnL1VZNWM3bmEvd3dsdWRz?=
 =?utf-8?B?Yzh0QUhPQ3V6WEUrWTliekx2ZzMzN2ZabE1JWC9rQjQ2ZnJNVCtIYXBnc0Z2?=
 =?utf-8?B?YUYxY29lS0hmSTJId0hsNjVaS0QyQlV2UUMrb2hWSjZ2TloraS9NaHNLc1l5?=
 =?utf-8?B?bVJMcmY3TlR2YXR4TWVIWjJFd0VmcjAvNVhla3pvYVJMdDdmZjNWak5VdkVG?=
 =?utf-8?B?NmNpWFRwQ3NUbGJyWDdVZXprRFlBOE05TmkyTjZBS2RiT1FjUGM3UCtyY000?=
 =?utf-8?B?cm0zbFJHRm9PQ0cxUStzZlk2b3hEcno5cG1DaGpOVld2T2wrZ1JYdmtoTnRn?=
 =?utf-8?B?SVlGT2UyeS9aT3F3a3BORE5vZ0pLM3F4Ly9jZjUyNStMTGJTSXpVOFpZT2Er?=
 =?utf-8?B?YjhlNWhJdEFGSDhtb2NzS1Z6R2VaT1E0bDJia3NvdHhqV2pvVmt4clNSSGF4?=
 =?utf-8?B?N0NpTTR1a2Z3WjlIQ3NXYVcvNGZCRGhGQXF5ZXczeERBWDdGMXhUeHY4Tit3?=
 =?utf-8?B?ZzFuL2V2d1NrdmdveGJRUnRxN3ZWdmlZSS9BbzE5TlR6VHk1R0hUL2hxdXh4?=
 =?utf-8?B?aXRCTk5mUnpJUW1nQnlKTTZESitQZWwyVXIvMXhjR0cra0l3MlZGNjcwQXFP?=
 =?utf-8?B?U0hYY2pVbTU3enN2UXg3Z21JQTBXVnNYUk9VVkp0Y3YxZitvc1QvNnBlNVA1?=
 =?utf-8?B?RHpPN2o5NkQ5ZFdEeEpZNUtqVFJnRTBCVVVMbHN6bG9ZRGhpKzJYN0RwSWs4?=
 =?utf-8?B?dVhVOXdwWUJmRmRSM0JEaTEwWlI4RTRXQTZrZ3NFelU5V3lWOTBBYU1mN2tF?=
 =?utf-8?B?dGdpK0x0T1VES3Vhd0YvbUR1TmVwZUprU2FUdEY3R3RmZ3kzN1pTRE1LUGlB?=
 =?utf-8?Q?oHavL+14xQwqYeUWFkSkA5390?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff51095-01d4-4cdb-ed41-08ddca0bf07e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:11:18.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkyHWaxwI4smOJERw/ByqMijo74xDKJ4U1ggdgXa2LpsxU5NRAa39NVUMnBjPsw6GJhOD+Kh33gS0dHVjvdH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

On 7/23/25 12:01, Tom Lendacky wrote:
> Currently, if a ZEN family/model is not recognized in bsp_init_amd(), then
> function calls after the family/model check are skipped. This can prevent
> older kernels from enabling features on newer hardware, e.g., unrecognized
> new hardware won't enable SEV-SNP because bsp_determine_snp() is skipped.
> 
> Rearrange the way the WARN_ONCE() is issued so that functions called after
> the family/model check are still called.
> 
> Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")

I put a Fixes: tag, but I'm not sure if this should go to stable. Given
that tsa_init() has been backported, it might be?

Thanks,
Tom

> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index a5ece6ebe8a7..79ea6a0fcf8a 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -420,6 +420,8 @@ static void tsa_init(struct cpuinfo_x86 *c)
>  
>  static void bsp_init_amd(struct cpuinfo_x86 *c)
>  {
> +	bool model_warn = false;
> +
>  	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
>  
>  		if (c->x86 > 0x10 ||
> @@ -489,7 +491,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  			setup_force_cpu_cap(X86_FEATURE_ZEN2);
>  			break;
>  		default:
> -			goto warn;
> +			model_warn = true;
>  		}
>  		break;
>  
> @@ -504,7 +506,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  			setup_force_cpu_cap(X86_FEATURE_ZEN4);
>  			break;
>  		default:
> -			goto warn;
> +			model_warn = true;
>  		}
>  		break;
>  
> @@ -521,7 +523,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  			setup_force_cpu_cap(X86_FEATURE_ZEN6);
>  			break;
>  		default:
> -			goto warn;
> +			model_warn = true;
>  		}
>  		break;
>  
> @@ -529,16 +531,13 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
>  		break;
>  	}
>  
> +	WARN_ONCE(model_warn, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
> +
>  	bsp_determine_snp(c);
>  	tsa_init(c);
>  
>  	if (cpu_has(c, X86_FEATURE_GP_ON_USER_CPUID))
>  		setup_force_cpu_cap(X86_FEATURE_CPUID_FAULT);
> -
> -	return;
> -
> -warn:
> -	WARN_ONCE(1, "Family 0x%x, model: 0x%x??\n", c->x86, c->x86_model);
>  }
>  
>  static void early_detect_mem_encrypt(struct cpuinfo_x86 *c)
> 
> base-commit: 804fa10c3a3c8a33ce6ffdb999f94d3a7a6c20b8

