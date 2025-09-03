Return-Path: <linux-kernel+bounces-799232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1C7B428B6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B9E206AE0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4B352086;
	Wed,  3 Sep 2025 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="13TSsi88"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589612D375D;
	Wed,  3 Sep 2025 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924334; cv=fail; b=sicCZfV82wBH0o8R6dQ2ytkP+a/0RH2AvL0Eqfy+kViI6qL0879NeBGqFCf1Dd5UNU/QIfkiG7STCKBkF6A0179jdYcg3p/6lh707xjWGsrgPMfYkfTsE/ygyItY+O+CmD5txgxMKyXILHU/3CkElpucQwNwA45bb2wqr1OqaAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924334; c=relaxed/simple;
	bh=GIHvA2cpA5mQOzgTuvLaMIZwonUgCbq1duYcnvaFduQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSzSY34Ih4yWWmP38SrucdtpZQZma0eLyPS6sqnvo37W6jc9unACKo2iF4yme8CBLHfYhwpRkp4sTllZBL+GW0xRL6uBwehBd8OJRXqRHOuxORhAu/01s5mRzcj0G+AfviUL6p1fnBd0rYWsNQl9+t+ncoUM9diRohBC00V8gLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=13TSsi88; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajyYCDOKYwZRFA0e+Jd/vB1bDIbkZACgkw3c/2niqLdFNEzfeWFaSHC68W1xXnBFH2RJoCvnWJHi+BnXH05shNlk9ixNUz3ydBmye4qwLiW0aNjEtDqnR57g147GRM6SLWnevm+1B3fAW+hvKxzFdlyo50MfxXEzMvN2q6chVlUtGxNOOKUJk4stEoJ5VtlSWgdRVL2VuzBUS6PeYWGObLN35LrRSUv9VJPWZon+dd0Dxta8p3q1y37uO4xUXRXMq1+phz8Wv2t6z1qusWwUZ/QoKDUjeaBPE+SdmfVB+xarOjO2hMVX3PUoPprRb70tSRuVFaBf808Z5aW67jHQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLaJ8enLl8zYITEaC2B0AVendKQMtkTlf4wg42QSteg=;
 b=k+IT6ToAT0m0Nqzi6c5RocC3BH13f9Jen5tfkbwlJbz97krJsd8clGISCFSMhVSjctjLj03DrCrVw2LxlSJhW2AIrve/7mH5BcsIitt/4/us2PSkFPJDW6sCOiP7KMjZfoaiO/GJcP/GA5fblM+eTqcYn5/HtJoAECNk4WjkXT7Vyqrhh3QI3XyJeoCB5bV8BxQ5nupwSS8rRixkSyaMc8YNl0OqpnviN/V2G5MXeotYZpW3DOkDslRbdr49dncO0K+yttKjIzbQBTo+T6HyoaqhGXszEK97WxIYQzMHmiHTuYd5L16vlAMvWQ3e0LDFZiYP0nM2M6KQxakRdrsHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLaJ8enLl8zYITEaC2B0AVendKQMtkTlf4wg42QSteg=;
 b=13TSsi88YE1/HaydEg1KYK1YqJGSN3+tW2JsB5t0C4PEMA9LNofuG9tW7bttJZlb/1nWAuXPadivg7RowaQvepIaGv9vDx2fm9wdNdNReZigiXnmAw9iw0H/AVmghiGCznPGNggxvmbzJ6t5JgesMG1tSFsOCzo/MbrpfhCQyTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by CYYPR12MB8962.namprd12.prod.outlook.com
 (2603:10b6:930:c4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 18:32:11 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::bed0:97a3:545d:af16%7]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 18:32:11 +0000
Message-ID: <ec5e1f6d-f662-4932-81a4-dc917c6afac9@amd.com>
Date: Wed, 3 Sep 2025 13:32:07 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v17 25/33] fs/resctrl: Provide interface to update the
 event configurations
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: Dave.Martin@arm.com, james.morse@arm.com, x86@kernel.org, hpa@zytor.com,
 akpm@linux-foundation.org, rostedt@goodmis.org, paulmck@kernel.org,
 pawan.kumar.gupta@linux.intel.com, kees@kernel.org, arnd@arndb.de,
 fvdl@google.com, seanjc@google.com, thomas.lendacky@amd.com,
 yosry.ahmed@linux.dev, xin@zytor.com, sohil.mehta@intel.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, peterz@infradead.org,
 mario.limonciello@amd.com, xin3.li@intel.com, perry.yuan@amd.com,
 chang.seok.bae@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, peternewman@google.com, eranian@google.com,
 gautham.shenoy@amd.com
References: <cover.1755224735.git.babu.moger@amd.com>
 <4d497589d3bb5389565676512c2116e5cfa6df7c.1755224735.git.babu.moger@amd.com>
 <c5f97d82-bb87-47e8-bbf0-e9dfca332313@intel.com>
 <dfc629d3-08d8-4443-9a8d-61e4612dfbd6@amd.com>
 <c6c1df22-e3df-4acd-a93a-f2972cac9793@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c6c1df22-e3df-4acd-a93a-f2972cac9793@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::25) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: af7d7b9f-7ed0-40d4-cf02-08ddeb18320c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE9sb0ZKeUovS1pXT0RhZVY2RlB4ZmYzVTN5NEEvU0Y5Y3pwSlBlYm50Ymlq?=
 =?utf-8?B?NmhIZ1p3STNXVFpYVlVTYnZiOUNaLzR4TzhyQnROV2J3T3krYk11Zmk2UEZD?=
 =?utf-8?B?c0hET3FUaWVZQ1d3SkpmUnhaVW9NWlJjQWMrSkpleW1xTU9XV0t0NjYyeUtK?=
 =?utf-8?B?UHlNaERndjQyUHVaeWsyOE4rNjZUdHBxRkJzd0dSTk1HZ1RuVGVaeTdCWnJJ?=
 =?utf-8?B?K0ZlSHUyQmNDUTlQYzg3MkVYc0EyVDZoekxzelBDdm5STVpYZVcwRUxGekV3?=
 =?utf-8?B?dDRFNUpOaFpnOTJzNGJ6R3BZcGorSlFZRWpqalV4b3dVMVNFdHVSVEJOclpN?=
 =?utf-8?B?YzFHdnY1cWFxT2p0V3ZaQTVYSDA5cFFJUGRkd05kbXZrSGI0UGVxK2RNdDR4?=
 =?utf-8?B?WFNKS0o0dTE1K3YxSWtkTUZhaDZYaXZYYTFQSEJpVjYwMllrSmt1NDRnSEZ5?=
 =?utf-8?B?ejNGRTY3ZHdteGJsQ1ZqdkpTYjdPWmd6dERkNTF1Uy9VVVVjcjJvdFc1L2lD?=
 =?utf-8?B?N2lPN3BtS01RbWZqM25aaEsvWmZMWUZiK2FNOG00aWpNVDdBNWVHZERzQzFZ?=
 =?utf-8?B?b1J6OG1PbmUyNXZuK3dzU0lrcEE5cjBhdDljajhYc04zQzRWaEwxSDQxMk5H?=
 =?utf-8?B?MzkvRWZTekV3NlJJQ3VsUkhBdzhvTlNXN0FyQXBWTkdkYXdCRUNtU3NNK2VN?=
 =?utf-8?B?RDg3YkthcEhTMjdNUzN5YUZQNFhDRlJWdmlieTVIRlkxd3N4bDJJK043bTFD?=
 =?utf-8?B?TXJkV2RjTzR4NTZnWitobG1IYUNPZUI0cHZJb1MxTndkYXhtQXRKRFlrNnRl?=
 =?utf-8?B?RjJHNlhURjU4ZE1xYnU3TWZodWFnS0lYOEd4TTNCMk14eHF0bERRb0tQQllS?=
 =?utf-8?B?dm91bHppODJOdnVYWjNCR0tJYjUvS00vTnBYYmViODlnWkFPdzAzWTRlSXBh?=
 =?utf-8?B?NFZxWi9vSGZSWG9lWjkxZ2xuRFVtZ21vVVQ0YXRkQzhJMG53WTA3elkyQVRm?=
 =?utf-8?B?QmxSRFdLSmx0eDRKSWhDN3ZtR2xESkRMUHFTR2lSa05pUDBiWHJ5RHFGVmlY?=
 =?utf-8?B?blhvalNMNEY4SXorcGg1bGZ3L0FzRUVkd0RVUFByMWhCVVhIRnoxQ0tIRjho?=
 =?utf-8?B?Mk52Qmg4b2xMdXpFMHpESWt0UGZYdmpOVmJNbXRKcnVab05rQXAyc21FVi9T?=
 =?utf-8?B?OG5YMEx5a2ZQamxhcCtiQUF3WUVFdjk2TXkrY2dlcWtlMVdrL1p4c2RPMm9Q?=
 =?utf-8?B?UTJldXNFLzN2a3RNSTk5WEw1M2M2ZUNYK1g5TlRYbkR6N1pDTHNzeVlqT2lD?=
 =?utf-8?B?eksvNmRTTm13ZkdzNlFWL3lBT0hqM0ZIeWNjNHVRaHVpN29FVmpzOEhnZHY3?=
 =?utf-8?B?Y053TmFvaWxqRk1SeVRGbncvdEIyS2t5KzEwcUM4Yzl2MDUvVitWdi8wRVFu?=
 =?utf-8?B?T1JtK3ptVkFnQkR2UWVRMEVUb1FhL3ltL3oxMyt0b3JyMW1RTFlVYlRZdDMy?=
 =?utf-8?B?MFJscHBPY2xmYzhuOW16SUJGTjVHc21FcjA1NldKR01aYUxueS9XUm4xMUtF?=
 =?utf-8?B?ZWhrd291QXJSQ3hKcUdiUkIwK1BsOFB0QXVHRjRDM3lPTVBKUXozMnVXa3ll?=
 =?utf-8?B?TlFXalRqazJ0QlBkMzVObWRNcU5ZYW9iOE9pT1VMdFE2V2l1b0JOa3BheFpT?=
 =?utf-8?B?WE1yNjBBZzZiZlFHUXVtRHZ3UWNMc1ZwSXBRUHhEeW0rbVk1SktOblN1aFFC?=
 =?utf-8?B?QlVPSEI2YmN6L3VwR3B3M0RBdm1Dd0dEZDJUOG1ISW9UZEpTOWFYZEF0a3c3?=
 =?utf-8?B?ZnJXQ2lFMWhSOWNpb21GRlJqUlRUL0U0Y3hiclNiWXEwVWFIL2V5bWZ0ZnJY?=
 =?utf-8?B?UnB0dTltRXRDTm5paVRtL0psN1c0UFUzbHNhOWlpUUtXd2VNbDFIcndvb3Jo?=
 =?utf-8?Q?gPjAakSOFyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHE1YUl0NmFueWxMNDNXNExISCtlanVDOGJBTm9udGRIN0NBRkc5dmdWWk5Q?=
 =?utf-8?B?ejNsUkFEeDI2Ym5FM3U3S3RKZ2laZEhnMzI0cUtxV01mU0x0NXpQUmo4WFo5?=
 =?utf-8?B?UUk3UlpMRlo4TzluRjNoa1VTRVdWVEdOUDNZMkVWWG1kUWFFOFRKS1NoTlln?=
 =?utf-8?B?c1JJejZLYVpXd0JPMUQ4TVZiY1NqdENGa3ZoSW9ra2xTRks1Rzh4SjJjbEpX?=
 =?utf-8?B?SjY3QkFpVlpuME5VVFJUTVZocTFMeE11OG5wRENvVU90eG9kb0FhVkNkZlln?=
 =?utf-8?B?Q2ZDN0R4dEZVeHJGZVZsL1hyTzFpUzdwdisxakVyQ1ZLUkl0VFlzanlBSVNL?=
 =?utf-8?B?N2JZNlA0SGtIWnV6dTM5aWlhRExZUTd3NHJFNmx5Ym15Rk5lSmh4a2FzSFdI?=
 =?utf-8?B?V3d2WHZab0pTV3RuWDNTRDVFQTQwOGhNT0pzUXpaTFEyNjN3bXVlK3U0cnJ5?=
 =?utf-8?B?K0o1K0VxNFJ2RXZrZWJnWWhGd3QyUHI1bDdqQ0xUMlRFL1M2QXR0U1hPUlZq?=
 =?utf-8?B?RWw1TnZUSVRqV0lsZ00xeGF3blNYOXVNSHhDL1dnZUdCbjBueTVydm9VZjE4?=
 =?utf-8?B?cjdzR0ljbEdVQWJRajBPSC9FcENwd2dKR0pPYldiY2tveHpmd04zUzhMd3dU?=
 =?utf-8?B?ODRjdExOd2Y3ejZLdURJV2Z0clRRWEdXRkpTRUl3QmNaNlV2bHp2M21rMTZ4?=
 =?utf-8?B?NzhrcDlBSXNQQmFCaXJ2dUNZKzE5ZXlvamRYSEpESTFjalBRbmU0UnM5VmhS?=
 =?utf-8?B?dWhUMkM1MmhBTEljbjhHZFNENkpaaksveW5tcGFkbjZ3U1NCRFBzeW1LOEZp?=
 =?utf-8?B?VUE3YjZVTG9TVm1JcG1Wb1FsY3YwMTJUUlJNajBpcFlqQ3lCaW9XbUxlbElu?=
 =?utf-8?B?QnA3bks5MnV0ZFVxNTExMjE0MEowL2poczVjdHdUdnNrSDFJTjJWUzRUS01Y?=
 =?utf-8?B?eTE0MzBqN2w0Mk1hL04ybllETUdOdmdjc1Z3NzlHTEozL0NsS3oxbFNaZm9R?=
 =?utf-8?B?YmZUNHl5bnpZbHUyQk5LYkREa1RRMDQzN3owN1FNZGJFUVMrYWFuRGdpL25O?=
 =?utf-8?B?VXhvQ013bXlzVEcwOG96ODl2Z0ZvanBNdWNZZzJ5Z0V6R1RVWjlSUHI3eC8x?=
 =?utf-8?B?blVVeDBURGJodnJJTXpTeEt0SVlwT2RLU0JaTWp4NndhazZNOTdVQjhnQ2hq?=
 =?utf-8?B?a0xqdWtVSmdyaVh3VXVpS3hDNDJXZHNtUGtrTEVsbnVyMHl3NHR3aksyM0hq?=
 =?utf-8?B?SXNCVlRDQkxpNEk3Ly9uV2FvdUtTeVhnaGtVZUhmbDNhUFl3UjhOR0hsWjZp?=
 =?utf-8?B?Sk1DYURLSUtheXNXeEFvZjZkR2tVUUoyUXdCVGFkaVhWdUVSYXVab0JoTEhD?=
 =?utf-8?B?Nm45cHRtRXpRclROYnRYV2NRa1U4WDRDRnhqSDNBS3VSWnU1WmF6bFI2WkpF?=
 =?utf-8?B?ZDFGWVIwaFRJU3JxMmZRZklCSVJzaU42alFYcmY3dXhqQW1PRC82VEZDdktV?=
 =?utf-8?B?cVEzZy9uNVZhakVPRm9BWFVyamtsUjRMTUJZRXBiWHhMWXhQRUNsUFYraXdm?=
 =?utf-8?B?Mk1oUS9pQkZvOWcxRXlYUzBrZE9pQUZ3K2NxL1RpdFY3S2FDdGZnVjRTUHF2?=
 =?utf-8?B?SVBhVWZ0SnZKNXpmYnJXQUlwWGxEU0RWaysrMnpkUlptZnRodTcxMFJOamdJ?=
 =?utf-8?B?M3ZITklwZ0hTYU0wS21aS2IvbXErNHprM2JPTnBoY1JmMzRKZG95YlllVkU2?=
 =?utf-8?B?TStveXB2ZUVXclcvUjFKOUNGOWplRlRGRkhZYktVcENFM2dvakV4OXE1SkYr?=
 =?utf-8?B?MktBN2RsR0s0eEVHZ2hzRzZZYU1rVCtHK05CdkpXZGtTOFZSUmtUSGRQbFpi?=
 =?utf-8?B?c1FEZU5uOWQvYU4yaENWc2xmby9iTkxRbTJmZzhOam1rVWxPUXJkT1dLTzN5?=
 =?utf-8?B?MDAxN2o1clhkR212VWsvY3ZDellzYzZoeDBlNEhGUGQ2aitONjFFMXdQR1V2?=
 =?utf-8?B?RitWbVo5Uy9zRzhnVk9VV0RFZC9VM0xVNWt5Qzk2VmpPS0ZTN0U3ZUFOK05T?=
 =?utf-8?B?VGJ0NUI3c2Z2VFpsY1J4TmxXaVpGU25sM1BqV3I5SE0wVW00Y0xxY3VQM3ky?=
 =?utf-8?Q?HQy8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7d7b9f-7ed0-40d4-cf02-08ddeb18320c
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:32:11.0163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QYAlQVWyuUxdDEWKBTL0IAQCAH8Ct494Ec+ntkJi649oxlPcAw+Lz5B/bTG4uwG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962

Hi Reinette,

On 9/3/25 12:55, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/3/25 10:38 AM, Moger, Babu wrote:
>> On 9/2/25 21:41, Reinette Chatre wrote:
>>> On 8/14/25 7:25 PM, Babu Moger wrote:
> 
>>>> +
>>>> +ssize_t event_filter_write(struct kernfs_open_file *of, char *buf, size_t nbytes,
>>>> +			   loff_t off)
>>>> +{
>>>> +	struct mon_evt *mevt = rdt_kn_parent_priv(of->kn);
>>>> +	struct rdt_resource *r;
>>>> +	u32 evt_cfg = 0;
>>>> +	int ret = 0;
>>>> +
>>>> +	/* Valid input requires a trailing newline */
>>>> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>>>> +		return -EINVAL;
>>>> +
>>>> +	buf[nbytes - 1] = '\0';
>>>> +
>>>> +	cpus_read_lock();
>>>> +	mutex_lock(&rdtgroup_mutex);
>>>> +
>>>> +	rdt_last_cmd_clear();
>>>> +
>>>> +	r = resctrl_arch_get_resource(mevt->rid);
>>>> +	if (!resctrl_arch_mbm_cntr_assign_enabled(r)) {
>>>> +		rdt_last_cmd_puts("mbm_event counter assignment mode is not enabled\n");
>>>> +		ret = -EINVAL;
>>>> +		goto out_unlock;
>>>> +	}
>>>> +
>>>> +	ret = resctrl_parse_mem_transactions(buf, &evt_cfg);
>>>> +	if (!ret && mevt->evt_cfg != evt_cfg) {
>>>
>>> ... is evt_cfg of 0 (a) a valid value (that will not cause hardware to fault) and
>>> (b) a reasonable value to allow? 
>>>
>>
>> The value evt_cfg = 0 is valid and permitted for both ABMC and BMEC. I
>> have confirmed here through verification and testing. In that case, the
>> event counter will not be monitoring anything.
> 
> Thank you for checking.
> 
> I do not know what a use case for this would be but I also do not see why kernel
> should prevent user space from doing this. Looks like event_filter_show() will then
> just print a '\n' that is expected. Are counters expected to always return 0 in this
> case or will they return an error? I am not clear on what qualifies as "invalid counter
> configuration" for ABMC that results in RMID_VAL_ERROR.

The event counters return 0 in this case. I would not think this as an
invalid event configuration.

One option is to add a text in last_cmd_status from event_filter_show().

rdt_last_cmd_printf("Event %s is not configured to monitor any memory
transactions\n", mevt->name);
-- 
Thanks
Babu Moger


