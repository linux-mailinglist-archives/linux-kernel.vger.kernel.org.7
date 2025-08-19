Return-Path: <linux-kernel+bounces-774778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58DBB2B760
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE5B4E1142
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF223505F;
	Tue, 19 Aug 2025 03:01:29 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97111A4F12
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755572488; cv=fail; b=IrjjMhkqEXb9iW8H6B4zaV3QKdBmNkG8aoG47D/kUDij6lV40BGAYFDPAAZm6o4D6IXTwtydXOVpVhjWdd3rkW9LwRYBRwlhgtQYP/dGFh02JwTsMA2eAVX1bmrllo/lBuFW/FT7gDXPVK/0I06fO6Nqa974a0rt7vf5E8ONkOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755572488; c=relaxed/simple;
	bh=hmzJ42d6YrxxhNXkYzkMIM/YEyWCIMkIva5JaOYALzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ieoePR1szwrcTl03xHz9O0XFG9RXiSK3cHYJB1AB/NHbBDAEpWJg3CRQItEphQceseNu34F33YzXFnYoktsJktul/0xJEC+yeqnY03fTXUFDDr+HYS++TlSnk9vsBGuP0aNMHMyJdkdGEb619uz1vNrFSm+ojoSkB7IzQ+9FFZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57I9ak9Y048978;
	Mon, 18 Aug 2025 20:01:21 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48m1amrymq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 20:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRRiLz9Mz5v+J+3WwqnY5iBfX860xnYFWavGmoLSGpu5DVZMx/zODy6fA+rQs4rv9EJULFYq9L4NnLBh3mhm95VarLE7ofFkCsesKSXQZA1Oq/PGlDq90ayDLzNM7UlmG5zUWm4F7qHyRT6ol0+5A1PZtIGjFcZU6EYye//XNjpo1zWtVrKHiX7nJw28LWo8EC7n/rWL987npyI7eM5sr4Y2i9SPwdrKPFUNtN6eMlRmNvH7dD6rbVX48+Bubwm+hvj98WlV4yrpV9Dq0LmOWz32O4udzi6+zeiXe8dMgV2qySP2Ffv+HOF6qUrshY9v5l707bvvX1HvXvzVG+x+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk0j0q5qGEleeT5YVD/EavYhOq4cNtewFbcGhL8Iiq4=;
 b=LwysbNDXscXuFSBsToj5XUQz2rRVE4xiBA3t1+/7AZH2w3tll+pLAYC08Vkfp2z85sBdCyVxiXO+YD+CLBFc8fpl5x/F/W+k7RkRUhJyxiO7zrlnD0B7lQVySz1u0g/pPlOXEzZZloU+J1hYzo+3AtifMFVtuUMyUvGMbeveSEYYfn0Sqq0VHH1wledyc4LCngWFq2SdebOqUsH6dEmQy/iCYiifxozY9XiiaeTeMp8f0m1y8Hay54pJFYrkGa2Clc/KtN09gtkKhoyknFIgKpN5y7lMtGzjLvKsai5Xs+2LuK/tTbrUENsZTltXUvXArcUlV+aWlDNujXNMicMfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SA0PR11MB4576.namprd11.prod.outlook.com (2603:10b6:806:97::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 19 Aug
 2025 03:01:18 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 03:01:18 +0000
Message-ID: <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com>
Date: Tue, 19 Aug 2025 11:01:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, james.clark@linaro.org, charlie@rivosinc.com,
        linux-kernel@vger.kernel.org,
        Changqing Li <changqing.li@windriver.com>
References: <20250728093153.2330009-1-changqing.li@windriver.com>
 <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SA0PR11MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc6208b-0973-48ec-2d13-08dddeccab57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0pVWXhnR2N0N2Vjc2FtOTd3SlA0NjF5REpCb0ptK0xGckNRS3hEWGw2V1ho?=
 =?utf-8?B?UUVtZElQN0RnUFh1S1EvOXhjQ2ZiTEpPV1YwWGxvcUVwdm92aUtudEpESW5J?=
 =?utf-8?B?bFRhRkh4Yk02aVVkdGIrQ1Qyd043bVp4dDFLbFNjbU5VdENHaVpKNEVHZXBG?=
 =?utf-8?B?MktBcXhaRThacTlpZXRMVVhVeVBnSjNWcGdNQkhCSXNpOW9JajJEYTMvYXZS?=
 =?utf-8?B?QVZxNUhJSjUxT3BRNXJOS2crMGNhaVErMk5VaTgvNzZqdEx2cmZQamc5TkhU?=
 =?utf-8?B?NjUxb21LbklUUG9aMWpBWU1nVEIzTE5pUDlhc2RXRjRYYVNVWXRRc0pQUDUw?=
 =?utf-8?B?Z3V3NmE3VDNraytQWVM2bFRQeE9ROStQb2txb3haUlp4N1hCOFozWlBjZ1FY?=
 =?utf-8?B?UXlCdGs0QWE1RnJmeU84VUdOSFh3Q2IrV2JVNlFUWTNIY0Q1a0cxNkwzMW1Y?=
 =?utf-8?B?L3lGeWZSN2llL3JGMGhaZWRQOHpEMWRGVlo4VnUxNjZiMTZXclJ4NFllZUZJ?=
 =?utf-8?B?Z3J3ci9EeXhsU0luMjJUQVdUTUtKSkRCeWFMQkhRWERBUU5TUmdYTnNML2NT?=
 =?utf-8?B?R0hLalc1akVKRWNLWVdiZm8zRDlKN1JuMlNUeGN3UDNnemR0R2JSalE5YWQ0?=
 =?utf-8?B?NFRxQVllZlQ4b1pKRXhFc0RueDZhTUhHSTRhNmw3NE9HWG5BSzFDUVh0ZWdz?=
 =?utf-8?B?THJHNklKYitpblRPSy9HVU12K29pd3ZReWJ4YkJ2UTQ5K1RZNTNMbUdmdmdL?=
 =?utf-8?B?aWVVY05nL3ZaaU1mZTlwamZuN3JwaldVUi9wWHhjUGxZSWI3VFdGaFpXenhU?=
 =?utf-8?B?eExldGpjb1hHTForTnQrVW9aazRiQXQycE1PemlSNjZkN0szejRDVDM0RTJv?=
 =?utf-8?B?WGV2UHhWSW5ZVFEzTGFCSkFpVlFDekkyVGpwaTlmdlp2cHNnbmJSd1ZKTWxP?=
 =?utf-8?B?WjlRY1BXZkhlWFhFeG11RldRQW1ydndtczFjVmM5eWlaenEyQXR3TVg1eDFQ?=
 =?utf-8?B?Z0ZUWERRVlIwdi9tOXhFYzdNS3ZnTkhMTVNxUW1oUkFrK0JnV3A5anFUM1lE?=
 =?utf-8?B?eDJrRXlibmdkOFZ0dVhYUFVEL2Nzdi9Ra0VmVDYya3ZjbVZOallQMXRqVTZo?=
 =?utf-8?B?VStkUXhkZ1F0UlZMdXpHU1Rjb3YyeFRIQ25BcE5GckhaejVwU1d2MU1TOEdY?=
 =?utf-8?B?UHVyY2h0dzBzb1NKMW5RaExndXloRWdzTlJZRE1sSGpJSVNzbGpwLzNENkZt?=
 =?utf-8?B?bFZNMjFEMDEwUWxiRDNCLytxeTdLTEhBcnR5VHB6a2lYdkh0SFJtTjdLd29i?=
 =?utf-8?B?dzYvcC83cDZkdENkYWVBN2FQTEZwM3lnWjhubldVMzRVbFdUcnlBOExpNXhI?=
 =?utf-8?B?WWt1VG91MXBRSnY2Z0hrMkZWM21HRkRwYTd0VGFnL3JMa3IxNkY0QURHSlpT?=
 =?utf-8?B?RzdLRGgzZ1phTXZDTUcwUlRyVndrZ2pNQnQ3NzFhVWt0ZW0rd0Uwd3B2aGFR?=
 =?utf-8?B?NEhQYm9xL1c4TmJELzB3VmRCUE9kZ2tmWXQrV2hWSW12NkFuNitqS0p2Nk1S?=
 =?utf-8?B?U2lNdHlRajJkUDJ3WVhBQll6N3JFQWFEcUpkMFBqdEkvNmJkaW01WXhUdlJF?=
 =?utf-8?B?c1FmY3NCQi9GVC9OdTFvcTRoWnBDaU1BTkVLa251cThYbTZZNE50YmdLNy9t?=
 =?utf-8?B?aDF0Zkw2cm56UUk3a1JYZVZEVURxWWs5Wmhsd3NTUHQvM1UvTXFaS2F6YWN1?=
 =?utf-8?B?VnRUcVlUUUZvTUs3TnB1Qk5UV1liUld6dW1oMnFsVVdwU3NVZE56cW5iNTF1?=
 =?utf-8?Q?XegcBaTRuz70wHYgDzWREvSpELtxNUKBirOCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBBSGVHZjlldTJRbUJUclRjYmVWZ0dnVzFVdDV2OTlDUW1IeDFRaUVZNTU4?=
 =?utf-8?B?aVNoN2dLOHFsQVg3WjNNRVF0NmdoaUxJSlh0enZzVko2ck1TK01jVVR6bzZ4?=
 =?utf-8?B?aWMyZ3hRdnBscDRzRktUdlp2YTZPV1JQNkJTaU5uSEhETHVWZWEyL00zU0lX?=
 =?utf-8?B?bkM2eXlUU0tLL3Y3MXJORFBUeldRakNQN3NaZ2w4S3BkMFY1VHd6UVZEbEk2?=
 =?utf-8?B?N05GWWtxODViVkhINWEwcGxLWmlYcy9HZ2x6czhhdHkwRXI4WUIvTWRBOGor?=
 =?utf-8?B?WFNGdE01OEdPK1FFSVJuSDhCYU1CUHNJbktKUXFPTmVSYVZOM2RFZUpteHE4?=
 =?utf-8?B?LzZaaEVJdWpjeEROWVYrc2VVMEZXcVBXSVZTNVhJUlpkSVhwSUxkZ2RGd1V0?=
 =?utf-8?B?dUcwRm90ZVMwMVdHUHNQM2tVQldkdWR3dGpLTlByT0xmcUNjU0FFcXhYSmtB?=
 =?utf-8?B?NnNhNGVIYUZraWExOHdodGovUGpTWDNLSExFQjgzM2xnUXk2UUVCSXhHS3dV?=
 =?utf-8?B?clB6ek16bWxVTyttV1ljMUdlbjJYNE44c2wrR1lVMFlDWWQ4VkI3TUtCUEVn?=
 =?utf-8?B?b2ZNYjU1ak1OdlBJak13Q1NHL09Yb1FBOTRjSjFsTThtaDAyWjA0R0M2M2Qy?=
 =?utf-8?B?VUdTRFhjcUtTRzZYRjFYaTM0M3VFalg4RmlZQjdFM1ZFNWgyQXR6NlVYMHdh?=
 =?utf-8?B?ekY2TTVZMmVvb0xnZExYc3Q4aGpkbkJWc0VUTTJoWHR3d3NCSnBHVnoyYVVM?=
 =?utf-8?B?Z2NiYkZtL3p3QWg3eVdtRmlQV1B6bmJvMmd4NlY5TjltT09jL2Y5VURZWWZr?=
 =?utf-8?B?QThxUXEwR3VDaWdsNXNmVmtZV2YvRE1id2ZSc0NoUndWS3F6K3RscTNGS0kw?=
 =?utf-8?B?MWZ6eEljdXlURGpVTURZMjQwUWV6dnFoK1lrQkNLeTFVSGFWWENKNm93RVZP?=
 =?utf-8?B?RC9uTXhMVTRiZ1F0OE5wVSs4YkZqTnVXTDgrcHp4UmdjTWVRQWNFb0VPcXdw?=
 =?utf-8?B?VFYzMU9pdVJDNXNLNkZCRVJHQ1hlTWQ2V3RxNTlZb3pZemdlaExwMkcrejRY?=
 =?utf-8?B?UWJ0Mlk3cjZZQWVmS0RJM1RjMmtyYnVFb3daTHByVDQwOEJVTXR6L2YxMnpI?=
 =?utf-8?B?eHdqSGRSUXJBMmpxQXFiUWtNcEplbzdlNUpxNXFaTkpCQU9zL1hOemo0ZjFU?=
 =?utf-8?B?bDJTQWg5Tmd1YUVXOStQUVU3ZkJOSGtkSUJaZ1hVb3hUQmJUSmxzT2U1WHhX?=
 =?utf-8?B?OHQ1NkpHZ3pYYWxLUUtwaXByZ0Zab2p2U3BQcUNxbU94RTJJY3g5eGZlRDdC?=
 =?utf-8?B?L1FTd2ttMnZMTUwxU1ZDcktMeHczK0orMnNLUlJzWXR1Q0VPSUtmaUx3ZEdq?=
 =?utf-8?B?aytFVFdFUVc5V0dQcFR0eHZ0TjZZbGp4b0hEM3VxQk1jZ1VjelZyQTBLSmJp?=
 =?utf-8?B?YWk2SGI1UEhFT3FnQzljNGNHSTZneERYRzMyR1plWlYvdWZkRXZqWFNlUy9q?=
 =?utf-8?B?cE00VWNDR3ZRNGRXK0d1amFNOEpETyszbUxhazhkc2E2TVVEV1lwWnY5clpw?=
 =?utf-8?B?M3JIUHRFM243ZXB1UDRmMkZWQkwzYkt4RXZtWllnZUhqN1JFZEhVMVBNVVRX?=
 =?utf-8?B?UzBaejhuMllUYkxzNDhFZTdCTHgrOE9zb3JBY2pSNTV6eFNHaHR3OEdta3Jr?=
 =?utf-8?B?VU4yNDU0eXN0eVhUK3BLS0lreStMLzZ5cE5ZMDM4ek04bExhTnowdEpoZSto?=
 =?utf-8?B?bFFSSGZ2bEFPenZVYVZoamVWOUpnM250Z2dyVU9Zd0xwQ0w3dDFLSkhPa3VZ?=
 =?utf-8?B?cWRUbzEzcEIvTjd3TmU0TXhUaXBmTmVETDJ0QUo3bFVTS2VoNmlUZlRBN0Uv?=
 =?utf-8?B?M1UzQ3p3UGE2TUdXWHpIQmxRdVkxKzZ1ODR0WVhVeTdZVXJjOWFUYlc4NVhr?=
 =?utf-8?B?SkxBVmprcHFpMytlV1JNKzViTWZTdi93M3c2ZG4vQXNTL0pLRVNmK2ZRNmF1?=
 =?utf-8?B?c3hhSVZqZnAxdjBMMGkvQTNVeUx0YzlLRDFWZWd2aWFqMTFvaEg0VSt1aWZK?=
 =?utf-8?B?NVpzQnNUNm8vRUYxNHc1VFQxL3Z0MmZvNWppamxLcnRMWHRPUGdyaUh2YzNq?=
 =?utf-8?B?TGo5bkU4d3JtdmRTUVhudjVOMS9nN2xLZTdXLzRHcXBYblVDMXJmMGVmY0VT?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc6208b-0973-48ec-2d13-08dddeccab57
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 03:01:18.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yo22hknbXx5JpbVj5gmtgZwMtaqn+ic7pu9TFoM5GLJ6LqJQAgmgtJ9MLE+vEmeNBCBQmpG+cRfMkfVCI7eutyQdBZenMrOdQ3mvThbe0Gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4576
X-Authority-Analysis: v=2.4 cv=NaTm13D4 c=1 sm=1 tr=0 ts=68a3e900 cx=c_pps
 a=EpvH1avkcIZxQBnqYGWDjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8
 a=Ptvq9zoxAAAA:8 a=t7CeM3EgAAAA:8 a=OivOvW_V7R2FCZ_PkQEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ke9shIQgfMkOMJk9-b84:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: FHeE76iId_maBwHxcJdhsUCSlr-wbQ4I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDAyNyBTYWx0ZWRfX5Il9zFaSUZlK
 aVPusLHmQugGMIoROsTgoXyIMn4mZhISe/YvZqe8YmDQyevpslGIW1LQPNq/sFphhQ7mFgIGo5q
 8/K454jwnVc0lRFOh8R8sp7V3G0/0Er5bFK288QaTuy2JUkkpZYHO+mnSlX9tF5fCFP6wElPGLT
 FAPAB1lzDMYf23+YqODb0E2WdySKXp83dVVT5i59c5BnAW/ik+WBmfYHFkPYwqnmxnMDUNOL9Lb
 FxbyS9YT+nzcLOthm5FfYg35l/fk5QB2rP29LfGMf8OGZE9H51zb6RTkWujAm346uaGaZs1lsf/
 05QmuIHJX7PWxLNHyc9UQ8lqr11t75nKT2KX5S6ZwlUdmadv5OGxCtHauoh0Yo=
X-Proofpoint-ORIG-GUID: FHeE76iId_maBwHxcJdhsUCSlr-wbQ4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun


On 8/19/25 04:38, Ian Rogers wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Mon, Jul 28, 2025 at 2:31 AM <changqing.li@windriver.com> wrote:
>> From: Changqing Li <changqing.li@windriver.com>
>>
>> The command length of in-target scales with the depth of the directory
>> times the number of objects in the Makefile. When there are many
>> objects, and O=[absolute_path] is set, and the absolute_path is
>> relatively long. It is possile that this line "$(call
>> if_changed,$(host)ld_multi)" will report error:
>> "make[4]: /bin/sh: Argument list too long"
>>
>> For example, build perf tools with O=/long/output/path
>>
>> Like built-in.a and *.mod rules in scripts/Makefile.build, add
>> $(objpredix)/ by the shell command instead of by Make's builtin
>> function.
>>
>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
> Thanks Changqing, the change makes sense to me. The printf is pushing
> the values into xargs rather than using $^ with ld. I've tried
> reproducing the error to test your fix by creating long directory
> names in /tmp and then passing them to O=. I've not been able to do
> this. Could you send a reproduction for me to test?
>
> Thanks,
> Ian

Hi, Ian

Thanks. Here is my steps:

1. git clone https://github.com/torvalds/linux.git

2. cd linux/tools/perf/

3. mkdir 
/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0

4.  make NO_LIBTRACEEVENT=1 
O=/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0 


5. Above step failed with error:

make[4]: /bin/sh: Argument list too long

make[4]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build 
<https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:148: 
/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/util/perf-util-in.o] 
Error 127

make[3]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build 
<https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:142: 
util] Error 2

make[2]: *** [Makefile.perf:797: 
/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/perf-util-in.o] 
Error 2


Regards

Changqing
>> ---
>>   tools/build/Makefile.build | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
>> index 3584ff308607..39066a3ef2fc 100644
>> --- a/tools/build/Makefile.build
>> +++ b/tools/build/Makefile.build
>> @@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
>>   # If there's nothing to link, create empty $@ object.
>>   quiet_cmd_ld_multi = LD      $@
>>         cmd_ld_multi = $(if $(strip $(obj-y)),\
>> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(AR) rcs $@)
>> +                     printf "$(objprefix)%s " $(patsubst $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>> +                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
>>
>>   quiet_cmd_host_ld_multi = HOSTLD  $@
>>         cmd_host_ld_multi = $(if $(strip $(obj-y)),\
>> -                          $(HOSTLD) -r -o $@  $(filter $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
>> +                          printf "$(objprefix)%s " $(patsubst $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>> +                          xargs $(HOSTLD) -r -o $@,rm -f $@; $(HOSTAR) rcs $@)
>>
>>   ifneq ($(filter $(obj),$(hostprogs)),)
>>     host = host_
>> --
>> 2.34.1
>>

