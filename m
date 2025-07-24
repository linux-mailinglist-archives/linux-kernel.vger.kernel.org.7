Return-Path: <linux-kernel+bounces-743395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA88B0FE28
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDCC967331
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C128CA5E;
	Thu, 24 Jul 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JDxZIfqx"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C929A5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753316724; cv=fail; b=R2hsg/0BPc7XXSDYjSg1FdOcY0KEtBzfRQUlIwigcEFl9xig7216lbHS+JG4ego9By/Ma6k4XEpdn2a/NRpw3cnQjvDzVM2LRY+dH5pNJFk95i+Ib/etBCSDonn9TWeiE7CEQcN0d7Da2Xqba3JdlAeBefkrLzZb2ok+F3waH1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753316724; c=relaxed/simple;
	bh=t6s2f/Vlg8DBNm79xvJyaROzIF3q8NenK34rEP7v0Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWHIf1JqhSdd/u46wf1VQyCbvPvKv+Hxsh3gbZVHv2gLm3648FDm5V0aRQ1UzpDfpgJGlVk5Zs7pPL2Pmaj5pTsqt6YR7xZV2Y1n2EB2OcbzJINbGC9NpzAXsAUn4U51p+M/cI+4pgf+rGDXMqznBgz99wDinOXQzkB5MUUWWJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JDxZIfqx; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGSE7oAxkBJWtuVTtGp9FBT7URqeeMu9Zq1cPYPc6gR3PeLzMzIEAebDusAb+SWJnjiDffec9fJV9XHFGZFl4u6j+coc44drbvjk7TC95KK/37oniK3ust7wZYbP4FzUonH/AGUNt1UPUvHagBuoOwTwUSpuvkL4GqnKMI//BU9pJoEwxXk9bE4VbRAEGG9ZFXd5Y0Z5SITVTCACYCPFp5iaDjAe8CKJsOTnSMac1b2zTufiDF6DXgxBbawEudVhk8JD5gCvtY8iwh7x/TWbbAYZrzxUZNLAUZB3bYdTOThQW7owMPF/cFMJ/dLu/vA4W074MrVTo0aR6dQTxGRHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nz4prEIFVH3k6TeGLtLTWcEQHkBDBOtUyEDvYCYxff4=;
 b=e56ILdlsU3D1V+3ZzvW78GH5zlC+qB7c4TqVVVojVbi2hVXcohShMu+beBBlGQGQU5851xSlkNiAxEnj/XbSQDFylCM3EoXR96PryWFPPLNeen0CeuWTmBTVv47n7vc6h4GsEenOKykjvcAC53FgMFDdIsEc8tjwpEIvYQXTusLs0wofJQY8Qge52E6L35vZ1J6CI42tytVIAbqj1L1aA5+Ucyaqq74oPFqe9jqGUWal5rzrd7TJfUzszZTGDeIty8uOhfuE5QlyhdycidHMkWhiAmAZ2dcSR7kE4Ra2iwqR7JebFLJvrO0Z2d6cb8BaPAZTOwM9k51EVI+ieNTuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nz4prEIFVH3k6TeGLtLTWcEQHkBDBOtUyEDvYCYxff4=;
 b=JDxZIfqx90d9FqrxAQ5783u8Oeb1B3CTp6LHpF82sNjuvPULvt1fWH7Hv+QBa/pRvqFOPureIZtiRpNTr4+xeO5RK8T6soSQmnhPoAp3O5JsxGdoaKZXSVqmdr0ttFBVDZ0uhLb360RH20kQXT2Vu4oVsQaw6fkQvdmfpAp1tHlIPHEh0iTR2K/67k/ZwHqML3EcDDA7FBgSsHTdw4WGqRMq6zsnHyds/uBgUeF/G5LQAkSy3fRdA++PbaGQRLsIvS6DBqbkd3XTDlW7ycdlU/KtdEKgkM0IDWoY9FrJXuIAYjPIDMaWn3chBMkvRZRdIEdYlGAHYDH7uXMT1R69Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 00:25:18 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 00:25:17 +0000
Message-ID: <023ab16d-f3af-487e-a7ce-929bf7b2fe3e@nvidia.com>
Date: Thu, 24 Jul 2025 10:25:11 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: Do not fault in device private pages owned by the
 caller
To: Francois Dugast <francois.dugast@intel.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, dakr@kernel.org,
 david@redhat.com, donettom@linux.ibm.com, jane.chu@oracle.com,
 jglisse@redhat.com, kherbst@redhat.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lyude@redhat.com, matthew.brost@intel.com,
 peterx@redhat.com, ryan.roberts@arm.com, shuah@kernel.org, simona@ffwll.ch,
 wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com
References: <9ae3e014-c7d0-4d58-af0e-925bcd9e4cfd@nvidia.com>
 <20250722193445.1588348-1-francois.dugast@intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250722193445.1588348-1-francois.dugast@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 74329e1f-0bf6-4d1f-062c-08ddca4890f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amM2c0M1dFF0RWdXY04yc2VUdHVOOXZhVU1MOXVNNisxbGZPU3ZSQm45SE9p?=
 =?utf-8?B?LzN3R1FjU29MNmwxT0J3NXY2NDBjeTAvMzF3bm9MV3pxczhwTDhiNm5BNjZY?=
 =?utf-8?B?ekI1WWNXZDV6VnFVcFRUNEhBRjNRNG9FaE0wN3Vxa200Si9HNmx6cWdUODBY?=
 =?utf-8?B?U3NUaGxnNWdlQjdPbWlFbnpuYkdXQ3UzSTMrYUlHM1dEYWZkdEg4YnJwUmZB?=
 =?utf-8?B?dm1qOGI2aXhuREpqaG9LVHVDOHo0R2Y2RG5mSExqOEF5dkFSdkVwUXZvTWJE?=
 =?utf-8?B?S3FjSEpNdEFIWXRiclVEcDRmUVFLMTRETzg3U0RubXFCdUtaYWUwYlY5KzhY?=
 =?utf-8?B?UWxOc3BVU2VPbFZzNEpLUk4xVEtFTkpNcGNXZVBoclNYOWYzMklMMFRHWmVm?=
 =?utf-8?B?S3JlNy9Ocm1XNlZ0L3FwbVB5ajQzSW5rNTJYeHlRRElDZG9sVkxWMkEzN1R2?=
 =?utf-8?B?ZFkxbXFreC9DQ1NHOEdDM0YwSExUTE1EN2tNeWR6UEs0SzIvNXM3b0sxSUpz?=
 =?utf-8?B?RzBLbGxtNUN0dVgwZ3VXT2I3MmFJSkc4K3A2dlVWMGtCRW9MWUkySnRDSVB3?=
 =?utf-8?B?anZGUjVQazdwMTB5WC9LWFhEeTNEWG90U1IyQkpIcVRRZ01wU0hNSEZRZndD?=
 =?utf-8?B?aHZnMjY0VnNrNllOL05IcllEdWlUQiswZFl3WnBTNzF1UGlqTGhmaFpBRDJw?=
 =?utf-8?B?czh4Ym45TnVEVmJ5WGpXS3VnV281RjJXZTdQNDBmT2xGZFE0MkdHdjlPTk13?=
 =?utf-8?B?NWhUVFM4b2ltZ1pZU0h4Y1RkYm9wamN5RHUzdDdqYjVZQlJXUncyb2p1c21k?=
 =?utf-8?B?M2ZJa2g0QmNPNGg1cFVDTzdORHY4U1UwYmpOQmpuajRtNFk0MFllcXowY2V3?=
 =?utf-8?B?Y1dYWmtIT2tCVEMwNmkvRGpZREJKcEhsQ0VkU2NpWmhCWmF3Y0RRaGRrVXlW?=
 =?utf-8?B?TURPWlBqeVBwRVRFRE42QmVEcFBNUU1yWEYyK2R5WCtlcUMvZWpJSmN5Nkx1?=
 =?utf-8?B?b2FEcmxjNzdTUWhFSldJc2lTUkwrV2J4WDVyd0dlNnJwVE54VFNHUDUyMFZh?=
 =?utf-8?B?SXNXWVFXdXhMU2VuUnNVTnhuQ29QV3JPOFdHaVdLckxTZm5Db2Y2Njl3VkIr?=
 =?utf-8?B?eWMxaTVTSUdSeGxUQmRTWThFTmh6QnQ4cVgxL0NJYm43VHM4WG5FUGV0ZTJa?=
 =?utf-8?B?V3pFc2szclgzZ211Ym9TSnBGZk96SXhJT2l6dERZZ1dQYWY1djdFbHFjZ0I0?=
 =?utf-8?B?OVRDdFFkeHhwUDB6a3NWdnJveTcxV0hYZUJDTHN5ZnJKQ0ErM0thbGk4ZkEx?=
 =?utf-8?B?ZWI3OTFmSVZpVnRtMXlXdkpVSmpQVEFldHNSODFIQjc3eG9KMlhaZU9ldEZu?=
 =?utf-8?B?aWNlQ2FPcmdrMmFveXlYUkdrTkk4TTNUQkcyTmVwb1R5eHpSdUFIZjF6dWk4?=
 =?utf-8?B?YjVucUtZMGZkM3MvbUdNMk5rTktkdjY5c0FpelpWd3dFbWF1WGxMZThLUURI?=
 =?utf-8?B?a0FLbVVtbnlObytZYXo3YmYwUnNJNFZKS0tWYWFXUDlZdFRLRjFBdkZPbDRX?=
 =?utf-8?B?bkJTYm5SL3kzUFkvTW85MTBPeVY5Y0hQL3R2NjlDNUQ4aXIrdkpYam9pTUdX?=
 =?utf-8?B?RzB4Sjl2SXlueXdFUUxtSE9PVnZCS0dKR09NbndXQmtaRnJVL2w4Rm05Q2M2?=
 =?utf-8?B?dW9PTkJhNjJrMkRTM2dRb1JpNG80THRKeDl6Z1RLMXRna01JWEJVd1dxaFBz?=
 =?utf-8?B?ejMrZDBSSG8zMXdhK09zQ0xpNFZPaUVXMGh3cHI0aUpXYW1IbFJ3MWF5eEVQ?=
 =?utf-8?B?cHJEQndoU25yN09nYXMxMWRPRmhDWmMwdGhRQVVxN3AyamQ3K1gwTWpiWnVU?=
 =?utf-8?B?UXpLRWN3L0JjQkxMTUZYMXR4UEZabFlHSDcvYnRMbHE4U3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlE2Y2RkMUxDb0NKVUI3K1lCYk9FVGtWUDFYcVRxN01DUW9ZdVVWc1FwS2or?=
 =?utf-8?B?VjE2aFlhbnJYWlhCRG1TUkt1aEtSZVh6d1JSbXFLMEUyWHFVWm9pMVJGTHha?=
 =?utf-8?B?WUhEUDFZaDR1Ykh6UnBSSHJRcmE5YTd2V2I4ckY0ai9UT0hSUDFkTUFiVDNN?=
 =?utf-8?B?QU1ZaHlqV3ZFN2NQNUhUMjd6cW5WZnpMYldWeVJRdFRzMFd1RS9wVmdtWjdz?=
 =?utf-8?B?Z0JCWktLMnl4VXArTDN3NnJCdFpDREp1Mk1IVG1FdnFIVEFpYzZ5NWIwaW5v?=
 =?utf-8?B?NlBDRGowMStyaXlIVEg4ZUdJMEVoZzRmYUdsRG9VMkFMWmVGWHkvWHpSWGVD?=
 =?utf-8?B?VEJoQkhyTVVVWmtDSFBPMUN1SWRuS21xbmVOaURtREFJbG1qNXQyMDgyT3lN?=
 =?utf-8?B?TmlpbnpaREs5VTM3K085WTcveU93SXYvUWNnSUVsTEQ2VnhacHR1KzB0MWZ5?=
 =?utf-8?B?T1pUSXNQSllsMkVGenpOQS84aUlvZDlvMHVIZUdhamlyNVdveTQ2RS9yM0Jv?=
 =?utf-8?B?M2lBVGdlSkcyWk4rZjRUcytxQTBVWmh2ZHd3amZPVURTdUc3UFpDb3loNHAr?=
 =?utf-8?B?ZThoeXBTYUZmcldUQ1FBUnhRUDEyVFNaeWIxdVRCdU1YS0tVUzlHWEhxZm9L?=
 =?utf-8?B?ZnZ6cHU5U2J1ajIxWm95T29RQkxXUVhMbGt2ZHh0cG9XMzBGMkphaEpWMkV3?=
 =?utf-8?B?S3Z1c3Avcms5MHRqK1NVMkpMMUdnL2t6YjU4U2lxVmYyM1l0ZS94WGRWQUEw?=
 =?utf-8?B?NXhxREY2ZlhPU2VzSE5MVXh0UldsbHZjUXA4Z2ZWeTc1NjlkREh1eDNFVUJq?=
 =?utf-8?B?KzVsTjdpWHlKRlQ2dG14bWluY0kvOWFtakNLYnF0M25YVnBCUHBGTzFoakJm?=
 =?utf-8?B?NDN5Kzg4NnJzVDNIeXh6YkhWWUZPWlBDTGc5T3U4emJadUtXNzI0ck5HaWJV?=
 =?utf-8?B?MXFzUlNCdk0vTUpqa1RvTWN4cFlMNGVKeHZsdHkyblRsQlVyd0lSSXRGL09O?=
 =?utf-8?B?TUdlWUZ4TG5HV09mZmEzOHlwelYyei9OeVNJOG5UTDhzOHR4V1ZKcjZ6cGVo?=
 =?utf-8?B?NlovUVNTbitlY0FnRkN2MEQvNWNvZ1VyVDE1N3NndGpOZFV4dGI5TGZpcjIv?=
 =?utf-8?B?WENQNFlleVRLZGhpZXhDVzJlanVxY1FTaVBlck00TDRpK1JFTE13WWdLeVZI?=
 =?utf-8?B?SzNGcTlyMFdKaFJzMlVabWx0Y1pzU1g5TkdPZElEak9FQ3RxN1dPQWlydWZu?=
 =?utf-8?B?SEgwNWRDSjVpMXM3ZFc5Ly9MN1Vza2pucVdJSG5ZUXBMd2xpL1k4Y1hHTlNH?=
 =?utf-8?B?Rk9IV3EyYS9IbWpWT1J6a2FyWXR0MEkwckp0Rno0c3F5RkhTV3hZZFdEa2Ja?=
 =?utf-8?B?NGVUTHBHZ0xCQXREbDk1dTQ1ZlQ0VUVuZG53WmJsVlMzYW12SFlPOWFmUVpN?=
 =?utf-8?B?MzBTL1RPWHY0MzFhaGJiaGliMW5nM2VxNld2MmJoVkFWbTJvbHFFbXllNUlm?=
 =?utf-8?B?MG14aEhkRFFhb3Y0bEhkblVXMFYrVHpZZEFyTm9hcVpPSHo2Rk1kM2tGNnhX?=
 =?utf-8?B?NmxCUWxvYlBTTjJGcVptUWYydnI4dXJQbitwMFpOckZDbjQvWHo3Q25XcXNz?=
 =?utf-8?B?VkNtbURpU2ozUFNSVWNlY2ZaR1NDYk1TL1FnNzJpYXlRTnpsYnlpN2xoS1Fs?=
 =?utf-8?B?NTltTXJEYThtY3dPaHlmbmtscVpWbmhpMFJjQkVwYXQwcHFHMWhRaDdBNytk?=
 =?utf-8?B?QjRDOUhDS0E2WGFVTFJaSk5peCt1dFI5YXcvdkp4QjZUYU41R3JXVlNZY20y?=
 =?utf-8?B?bmJrM1dNN2FvSGtWNnJJTDRPeVFRU2lHVVN3Z0J3UlFpNXJrS1pkcW1ESmJu?=
 =?utf-8?B?OTAvQjgrRlRtcUpiMlljY0FhT3J1QzFWSnd3N3JEZ3h5UXhWdUt1YTV5eXln?=
 =?utf-8?B?YTVoSCt0MGtITmJrd0NlbUxUZ2Jjd2N2dytlSDRmUml5VGlOaGlCSm1WRUpK?=
 =?utf-8?B?RU1aQXVrejJUKytHRGhjQ3NKSmc2OFRtekc1akd1OUVtbHJkeDRrK1ZPQU5T?=
 =?utf-8?B?cWNwM2tKaCtIb1JBeWdzQlpMNlNESmFwK3FWOXV6cUpBVDZ5b0VSUFNySzlF?=
 =?utf-8?B?bk1wTlNjVVFrb2M1TC9JemdWWE1SbXZZVkg2VVJhMjhxUEFpaHFldWxIZGNY?=
 =?utf-8?Q?o0N5geR5Xg4itY48bUpmK+ye5zqB9d9g1DgzTym+1WDi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74329e1f-0bf6-4d1f-062c-08ddca4890f4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 00:25:17.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDRv7fQQ8VuJubTXV4Y6dt7CSj+6UHgfG705GWLkAZ4s5+RbDleB2QC8CXaE5iSq7zP0hl6w0VACyI3O4bao9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227

On 7/23/25 05:34, Francois Dugast wrote:
> When the PMD swap entry is device private and owned by the caller,
> skip the range faulting and instead just set the correct HMM PFNs.
> This is similar to the logic for PTEs in hmm_vma_handle_pte().
> 
> For now, each hmm_pfns[i] entry is populated as it is currently done
> in hmm_vma_handle_pmd() but this might not be necessary. A follow-up
> optimization could be to make use of the order and skip populating
> subsequent PFNs.

I think we should test and remove these now

> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> ---
>  mm/hmm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f2415b4b2cdd..63ec1b18a656 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -355,6 +355,31 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  	}
>  
>  	if (!pmd_present(pmd)) {
> +		swp_entry_t entry = pmd_to_swp_entry(pmd);
> +
> +		/*
> +		 * Don't fault in device private pages owned by the caller,
> +		 * just report the PFNs.
> +		 */
> +		if (is_device_private_entry(entry) &&
> +		    pfn_swap_entry_folio(entry)->pgmap->owner ==
> +		    range->dev_private_owner) {
> +			unsigned long cpu_flags = HMM_PFN_VALID |
> +				hmm_pfn_flags_order(PMD_SHIFT - PAGE_SHIFT);
> +			unsigned long pfn = swp_offset_pfn(entry);
> +			unsigned long i;
> +
> +			if (is_writable_device_private_entry(entry))
> +				cpu_flags |= HMM_PFN_WRITE;
> +
> +			for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
> +				hmm_pfns[i] &= HMM_PFN_INOUT_FLAGS;
> +				hmm_pfns[i] |= pfn | cpu_flags;
> +			}
> +

As discussed, can we remove these.

> +			return 0;
> +		}

All of this be under CONFIG_ARCH_ENABLE_THP_MIGRATION

> +
>  		if (hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, 0))
>  			return -EFAULT;
>  		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);



Balbir Singh

