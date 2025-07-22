Return-Path: <linux-kernel+bounces-741494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4DAB0E4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901551C88145
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6232690D1;
	Tue, 22 Jul 2025 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mwB6xHz7"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52980C02
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215701; cv=fail; b=I69FvX+AixYhh3lYK7hOKkogmadWRGeoSwrm/nVHqtn+QipTQGlQGj/BJjleucfFOp+pLoRJY0EK03UTK6Pz23rs/BVMnNPb/DgqIz1+eOkt9vmI8U094sDbmJR/LMJvY/6/J3eqRzDMoOIK0Z3uxfIyXAz3/KG+A93t6528cM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215701; c=relaxed/simple;
	bh=pW/+kOK7YtY+joSsrObrwMrE+TZ0xau7oduj/OcXr6I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/ACdR067T3+iuaDLv8YP4mv4ySD1gHBiBtHi58hSZ7EvidMe3RAymlVAZYyL/uXaGF0Lc7+M9Xq8IOrz6PzRWISsYh8Rck2zf08SjbzRgkLXIMgOL2K66R5zwVkUTsgXI4tHhqeY9KMLClJDdLgU4tcEBP2wNTR2oYmbnOIe3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mwB6xHz7; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MKHJKS010312;
	Tue, 22 Jul 2025 13:20:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=hNvViE17kHWTERKuuzsrovUZ6Fxey3wSPbqb80tMBK4=; b=mwB6xHz7tg0U
	9sif2iFgUVA3TyTWi8sbJGNRCMOeMA26r0sOg5N//nnZIDx94UqFQuX9bVN3JHRW
	GNpF1ucyNYdoTDQHCVfIPZc3eKyG72wXxBln46meu+1s8HR7qkk/wtsDKC17Ov2g
	U68LkL5V8aV+RB0LUhCCZB9JIcrER5yFQpuAmLo2yclbEZgtCYeSrFaECnbkmdXa
	1wLAvtlK2u1ehS49maR8epuCXk/5BuamsPL3rvEgQI5KFUsUjHzoabMBAfQZT159
	fmJAsbHiOsqx8akKiR+uEIsUetOClGouLiI/RYmmU0dDkN5JJQtunxA9qEHN7knX
	cWUj1Pskbg==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48257xp0gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 13:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QClNaiq8N/9M6nlVOnZK9j5nu9vzD54Qr4/XC3ThbHEts/mR30Sf+fGktxchha0J/63S6/+B4QpcL1WGgi6S8G5f66uxr+iLDcpE75XwzbI0+m6sj6NtJt5CECySCTkX7OEX3cT7RLpZgaI6M7nJGgf4168GD7njTzifNl0JSo920dgdYh034vPYAIyOEnt0h1tf8eH19vAwLx7mnFCTvbyr/AuMTOzWwcrsj/iuaQzSsV5CoSc0To+oLTidWe5LU9iu4Td2+BLmEdeU9vpHS+74q3SidqpXH1hUh0a/qsCH8Ltl+d//3DpPECgJEVvYjXxHyYUZd+btJUPx60c3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNvViE17kHWTERKuuzsrovUZ6Fxey3wSPbqb80tMBK4=;
 b=TwNZTrDy/i+rSwu+0bjSRrs2L9WOMfPVjeszXsK7ENVGw3g8BvkNzJs1JqR42cSiNe8CDrJz8/LzKXR3XQ04PnV/7wqyxPVVwtbSJzTMcd+VrjsYcM9fPUM0mmuPb9JcHFZqxwXHXERKgYsgvwVzK6tdjcBBd8J1kVOhInZNjiu5QEjFSseAihlr2ORo6e9IpCMq8Cyp3UsypFh8KZS3EyfV/WH1+SlX1VQIqCWI5uwDYJttTOrsoM3rX8XoyFiVlN4r/mOBXwmUwpdfsG9BFchecs0bKd2WaDKMQO/ER3AqWYB8vF6TSXOof0SdlxuPjKJ0y40m9NcmZyjRBrKIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV8PR15MB6612.namprd15.prod.outlook.com (2603:10b6:408:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 20:20:24 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::f4f9:d61d:89e5:74a3%2]) with mapi id 15.20.8964.019; Tue, 22 Jul 2025
 20:20:23 +0000
Message-ID: <8c6b7753-02ec-44d5-9b32-5c8fbfa2e7da@meta.com>
Date: Tue, 22 Jul 2025 13:20:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
 <20250708190201.GE477119@noisy.programming.kicks-ass.net>
 <cc582ddb-2f16-4c0b-be27-b9a1dedb646a@linux.ibm.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <cc582ddb-2f16-4c0b-be27-b9a1dedb646a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV8PR15MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc0a0b1-bf0e-42c4-46fd-08ddc95d302e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWNGMWV6a3U2UnpDSGdUNGNSTGJBTkdUbGJLRS9HL0JBRlpYZTF2REp2OVNV?=
 =?utf-8?B?YjhHRHAwdEJaUmVnZUdjTjFwakUxSHcreTJrRlRSU2h1elIwNlNXME93NFU5?=
 =?utf-8?B?U1ZaOVVyWEhwdHRBL1FHc2NSNnp6OXNST2dsZGdYYWE0SUlvUnIxamtLQjVP?=
 =?utf-8?B?emxuRlRmTW52S0Y3UGJiNGtsbjhzN3ZpbzQzQ2ZhOVRJWDJ0clpkSmsvbm1u?=
 =?utf-8?B?RDNtbyt0Uzk4L0tsd1JCTXdCeGxwTG1Zcjd5MWMxdktyalNqWU92aWRMc2Z5?=
 =?utf-8?B?UytqajBVNTNyUFpaanBCbTh5dUZSRkhzY3dhaE96NUU3QjNYNFIvVEE3eS8r?=
 =?utf-8?B?aGkyaHBnMEpERFR3L25KMjZwTXpOcm1ZMnlkZk5tYjBwUUE2UzFDN1hmQnlR?=
 =?utf-8?B?cWpCbGs4cU9NSnI2TkdQM3hOQjN0RFUrU2k5aDA0VVNRM0VocUNBSkZ6SWlu?=
 =?utf-8?B?TUZBc1FZbzhhaHpBRXBXV3ZNaGdOdy93VUxMQTB2cW1SSE9tcm4wVndza1dM?=
 =?utf-8?B?NmRrOWw5MzBySHBxOTh6bXNuaDB4clZBU1ZUMkR1V3QybWhUQndqcnEyRkNM?=
 =?utf-8?B?bHhJbzNWRzBMcGJnWngzVlVXRDZGVWlpQ1V2Rm5VdVVLWmVCZWJSWGh0TUxh?=
 =?utf-8?B?eDM5NHJoWmVKL0pvd21PSnVkaTVQak9GdGFXQytnK1I1YW5IREZ6dnhNbnVT?=
 =?utf-8?B?V2pIV3JGZDlITVJZOEcxMTg0WlpMWS9IakJqbXdvaFBlclJpRlBMZGtoYXov?=
 =?utf-8?B?clBIL0FNNVI0dFdUamdhTVpBKzBMaVpNREVSYUNoN0ZkZC9SaWM0Z3RqSENW?=
 =?utf-8?B?RFUxR3ZOU2pvRkpjY20xSGpOUWdNeCtXZHgya1hZVHYzT29mRHEvb3RXVGIv?=
 =?utf-8?B?Yit1S1NLMG1wdWgvRVRGcGFEdVZMZjQzd2FrZEprenIvTE5vNzE4VkUra3hm?=
 =?utf-8?B?WGV3K040dVgwSjVkaWpNYzFieVNRWXhJTVFYQnI0RHZmTSttK081ZTB1YTRM?=
 =?utf-8?B?b0lRQXlrZlB1eFIxZ0RmTStOaTk4WnI3N2s2YmNjZXNZZUU1cm15MzNBN09C?=
 =?utf-8?B?SlZ0VEJnaWZpeko3TkMwV2RDL2lwRUVaVjRTSnAweUFjS2pSYnY4VG5TaEgy?=
 =?utf-8?B?T3NOdk01UStYRDJIcnpIU3FDcng4TnNKbGs4ZGZjcVd3MVBmS09Mak0rVnhL?=
 =?utf-8?B?YnZOelphY3BVSXZ5aVd6Z0FIL0JnZUJzQ3R4ejIwNDhvTExob2k4dWc5bXNV?=
 =?utf-8?B?OXBHaUQzWXo4cEUvSUNwUFNaQzJEVkk3dEZqbnNZL2ZJbGoyUlJEMEVRMkhh?=
 =?utf-8?B?WHgxVnNoYXlpNXZkWWlWbjdrRENvR2x5ek9oYWRNendnUVJjUEpOWkFFN2Iv?=
 =?utf-8?B?eTBIQ3RYeTliVGNWbUk5TUdHYU0xbUdycmpJOG45WlovREZIN1l2ampUNk5G?=
 =?utf-8?B?dWh1SVFzYy9GOGMydmJrSFc4cjhlQmt5N0N1dy9PZkxVOTFrK1lmVEE2WXE0?=
 =?utf-8?B?LzcwUm9BdUExS2MrSys2dGNMTG9UUmpQSzFiSUpkT3BGMVRFYWMwOTBzN29Z?=
 =?utf-8?B?UW1XaERrWkZnT1BOaUdwZldxRG01Y2xZTjlYLyt1c1IzOUJCRkZhQXVyaWkv?=
 =?utf-8?B?endoOENYQzlETjJ6RThiY1JsTFdGNlVrNEtzRmpwYjBtakszb3RkMmI2VzNo?=
 =?utf-8?B?WGJpKzhGKzdXM0JXMHZjc0dtZTJvOHpFK0ZVZW9qUkRQbjRZb1NSVWpHWE9a?=
 =?utf-8?B?TUVtUWdHZ0VtSGdLYXZKQ2JaUjlJV21GSnNwdWRuOU0rd0ViZVJEMzlVM052?=
 =?utf-8?B?VGE1MXlEd0ZBNFNnRDBGSWY2WnFJUDVvK3l3QnFDTktyV21vSXJTbDRYQXhM?=
 =?utf-8?B?dzR0c2hsU1lkUG9tNy90R29oWUlGT2tqOTN5NGxOV0hxWnVpdlpEZEVwZTNF?=
 =?utf-8?Q?EXCd1C9oIWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkZNbU5nbWN5MmdtUGFqNVppK0JiZnJQK1Y0cnZXaEdnWGF5MXlBS1k1ZlYv?=
 =?utf-8?B?L1RqOXpOU1FEVFJkQXZsdG1ab25jSFBMRnRpR21tYkxrY1RUVXVyWld3NGZ3?=
 =?utf-8?B?U0VnNHpGYTVHZSsrZmlueGYwNjhnT01wQUZoTGYySXQ3THNrbm5hRU15eEdL?=
 =?utf-8?B?TWMvRVlBbE5jTFRzNUgrOEFWK2h0MFl1dGNsSm52bWNkcXZ4R1BDeUFRK21r?=
 =?utf-8?B?UlhBQ045bUhNa0V2Tmg4RUV2eCtPaHRWRjg4RWJEbzhDOCtMU2IwUm1XNEtw?=
 =?utf-8?B?aHNLZ2NwVkpybFlkTmF5RCs5TmNRc2k3SXlVWG5HNE1HMFRwMCtOMW5saVRV?=
 =?utf-8?B?MWxpU280ZzdoVFR4MTA1ZGR5V0JGenc2Z0w2b3dCQW1sUFhEME5VQjM0eWFm?=
 =?utf-8?B?Y3R1UVRGM29xc2Vwa1gza1FZNlhXdzYvQkYwR1BlK2RWVm1LaUJnVzF3YXEr?=
 =?utf-8?B?OEZEeHpUcUd5RWdKaXRGQkQ1OTlSU1AwRldHbTl0amhpUkVWUGg0SmI1Q2Q0?=
 =?utf-8?B?eGFtREpsQ1dOb3psVUdNVmVFMjc4RU5JdUhlMFQ3QWVOQnZ0Qnp5Sko1dERs?=
 =?utf-8?B?Z3d6N1E3eld4Si9oVmVML09FSEJmazJQSmlVb0tYcDBtbjFEbVZjUFdLZW5J?=
 =?utf-8?B?Y001Rlg3Tkpid1VxN2d5cDVNVnVqNVhkRzZqKzRINU5ZcGw3ZWpiL0FPQStl?=
 =?utf-8?B?endCdkZrTit0cXpqMTZhdWJrSTVHcTkyaGpMVEVyLzFUYWxnMCt1TU1IR1JS?=
 =?utf-8?B?bG1Vbk41TUg0ZC9wM1E3SFFEUDhBTVBiYjE2V1VkTWtUMFVncXJzQkJ6aFFM?=
 =?utf-8?B?amJEeW50dUxhRFpTOVZiM0xtU2c3Sk10M2hxL0hPNm1nTnoraUV6M0h3WDN1?=
 =?utf-8?B?ZW1KMWpFN3FjWk5nNGdDVFNtOGx0c2JwSGdiaVY2WCt5S3g0L1JFZFBOc2wx?=
 =?utf-8?B?UmUwNHBRcnVOOEIyN2s2Wjd3clpLTGlWeGJmd2JFbWFvbUhpNUxVWE5SZGZp?=
 =?utf-8?B?dkkyR1pxYllPSmZ3TGp3c2I0RkpvUXdiYnpiaVFLeTdhQTBGa3NhNnM5bmdG?=
 =?utf-8?B?N2VYZFIrRlErZUpEVXdnM0hmdUZmc3dZT0Q2aEx4N0svYmJhZFFTZVgwYTFK?=
 =?utf-8?B?NlZQUHNGbmJRVjJmTnY5UzRLWk9nRzJ0cU5LeHJrZjZnU1owNjZpZG5yb0FU?=
 =?utf-8?B?d3owNjRxVm5oaCtDWkhSYVBLUkdMVzVlTjV4TXFOdS8yWEFPMWxabGRiYmgx?=
 =?utf-8?B?NHg3a1VqNVFnM1JvUFBrejhKVnJza05mQ2ZyK3pFTzFYR2ZCTUppUDkrWURT?=
 =?utf-8?B?MjRlVHpOOGRDU1RiYW5kVFVUV0NYN09oNnNlL0NkdlBOZjF6VnNzdFZBTFRC?=
 =?utf-8?B?RzlTOFVaejRSZUwrTE1tTUNxVlpDalVacHdsQTdZUTZOZVlUMDdEU05QMU5a?=
 =?utf-8?B?UTlLQWtXRFVQa0VmcFZzbHRFaHdCUi9kQnk0YmNubit4REFzWVM3V3JBRzh1?=
 =?utf-8?B?bmFWdVJlcVVVZ0NZbzJWVFpnc1BkNHluUk5ZS3FxMHhuak5DZmdORDBVWmtl?=
 =?utf-8?B?aW4wMnEvOTE0VlNTUkZUbDdDUDhjQTRmSlp5eEJvaU5XeVFGVUhZbzRYL2FV?=
 =?utf-8?B?ejNWRzhndmV0ZFFzenJ2Rjh6WU9iSzFqUmJwb2pyMjdCbmNlMEtSYmZTTDNl?=
 =?utf-8?B?VDN6RXBuSXEza25oUWNsMEZYNWhQOFlTeHJHNnNncjV6L1J6a0ZLRU93NnNk?=
 =?utf-8?B?L3ZuVVhDeVlPWVdWcEN6YmNqbkJhaE5iUEVhK0gwcXFKOWVqZ1V5R2lMRG1h?=
 =?utf-8?B?a1IwVnJJZnVxc3JiUnNvSndJdmpsLzhYejEzK3JWcUtvNUdnYzFTK210UDFw?=
 =?utf-8?B?NXJhYXpYcEp2b1RDc3pQNktsUkUwbFZGSjN4QisvMERUdDNZcTY5YXEvMHVT?=
 =?utf-8?B?WGhOOXlwcnAwaG5vZ20wUllKYWRWOS9RVkt2VXdLNUU5dE9tYmNHcy9scEc0?=
 =?utf-8?B?S25xb2pSaFRtQ0Q4QkxaWVdoZGl0UkJLU24rSlpBN05XcmNFaFY2RkxCWWdp?=
 =?utf-8?B?QUhWZ2plZ0U2SmI5L21Pdms1VWZMd1cwVFpQRXFIVWhhejF2emtMTWhXWWxI?=
 =?utf-8?B?WElRU0FoSlVaNXZnNGo4YTNPQk96cFNFSmt6V1I0WWRBekZPWDY2R1BZNzNW?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc0a0b1-bf0e-42c4-46fd-08ddc95d302e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 20:20:23.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGqp0M0R5zKidazI9xuVwB04JHzvKeL8N55VTnTLLmNlNla3iwDFefprOQDoOT4Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6612
X-Proofpoint-GUID: r5jn2ImDfLe7Vdb6ycA3wVdrpXIavaNP
X-Authority-Analysis: v=2.4 cv=aoSyCTZV c=1 sm=1 tr=0 ts=687ff289 cx=c_pps a=n4RqILhGRq/0WckfvtHWag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=XQAnPjo2PHIUGl_0UX8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE3NCBTYWx0ZWRfX6uTsko/Eta+U b9kKC7PS//8gsoc7dqcBtawsLfkR9zzK+tXvlqhrpVwBHx3eIfoSkSESqxr+/DbzKfDL0zKnLTy tMKhvNy35/trJG0u2+WnVajU/9SZ3x7eDohMCjLKCkqjQA2w+0yelSjsIr5dQ3B+K8P7vN9l0o/
 MwDNZVcuSCx4oRcYizUy6ULPfIBu4UyNBOZfu1gZ8oA0Y+cUKoRNx+HZFFcDp+/VbifEI/Ccj1R WoCmYIjeR2SwgLVQcWRRO6mBH4QcyRERLcQYxrtbcZEjugMl3IqeFp+PJWzzlJBeFdX3h/OpFtP t405X9u7fyt+CnZA73nymyOLbqIiff+XvkSGyoi2jZ1+cXjMt/QFIVkKk+H+yBmRQsSxrW5XzVc
 S0gaM5VLMcbYjJgen6P16Mmg9FVsoBIJDgRC7qkBM4S1n80urPgCU2ixmuAf6kjuJGuKztLt
X-Proofpoint-ORIG-GUID: r5jn2ImDfLe7Vdb6ycA3wVdrpXIavaNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-22_01,2025-03-28_01

On 7/21/25 12:37 PM, Shrikanth Hegde wrote:

> *** issues/observations in schbench.
> 
> Chris,
> 
> When one does -W auto or -M auto i think code is meant to run, n message
> threads on first n CPUs and worker threads
> on remaining CPUs?
> I don't see that happening.  above behavior can be achieved only with -M
> <cpus> -W <cpus>
> 
>         int i = 0;
>         CPU_ZERO(m_cpus);
>         for (int i = 0; i < m_threads; ++i) {
>                 CPU_SET(i, m_cpus);
>                 CPU_CLR(i, w_cpus);
>         }
>         for (; i < CPU_SETSIZE; i++) {             << here i refers to
> the one in scope. which is 0. Hence w_cpus is set for all cpus.
>                                                       And hence workers
> end up running on all CPUs even with -W auto
>                 CPU_SET(i, w_cpus);
>         }

Oh, you're exactly right.  Fixing this up, thanks.  I'll do some runs to
see if this changes things on my test boxes as well.

> 
> 
> Another issue, is that if CPU0 if offline, then auto pinning fails.
> Maybe no one cares about that case?

The auto pinning is pretty simple right now, I'm planning on making it
numa/ccx aware.  Are CPUs offline enough on test systems that we want to
worry about that?

-chris


