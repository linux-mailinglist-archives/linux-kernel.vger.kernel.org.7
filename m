Return-Path: <linux-kernel+bounces-872932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE21C12A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B01A6373B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093623AB95;
	Tue, 28 Oct 2025 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="PdbDjSYX"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8773A22D9E9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617773; cv=fail; b=VV5QIC2UqsEtWxEuJ1ceA2tm0OPE30aVunpdVmvBVVKTBNQEk+Zu2Ri7vkcPdertJNq8mnNO5Yja+Unrel8MCQlgB83vkwciFnA/gfbfE2CktGBSHNOW+Um4Df/IpCpoGocKdQaDzM45Jqzyd9hO3PNFXLn++XzcBVGic1pWnU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617773; c=relaxed/simple;
	bh=NZuAPlMvOUm9CCKkRwEfHaKYx7NIQZ6PQVDj5CRAyvo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pbdFCNGRWhwPLaM3fAZ6ze2Qc+mQ4rk43kJyr15SbQVAdmBkj9kXAM2eJnefU3IKDGv/vaBcni1EkCwpO9tCC4cu2c/ejRH+dDrF3pcwvhF43JQTJau01LCtkmc3huPn0jqdexaDPehxfddfitkc0vtXiUaf7iaLifC30OTG2z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=PdbDjSYX; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S1Kh963396419;
	Tue, 28 Oct 2025 02:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ODE9dA19lZ2wuyDIrO3PrG7fr8tIHN0aM0tVBEvHeKU=; b=
	PdbDjSYXag5jc/CEHY5qwJ61UeW1psHnMRIIhS5o3yot0FCL7LCp1QoZQE++GMlK
	CKl0UYWapfyvXn6NuDv94yz+UgpcWkZ+VJKpCgCa544PYvi70mor6+ut1QajPmlw
	uWV5TjavZwj4A2kLWjU+fixFidiMIRH9k5AJaF9RHIKVGs3g6M6oiBQcbq8Qlv+L
	jC7dS5sHN60onhhoBScMyXOSU8H1i7kssy0L9vVLJlaKOENvWTisHFs/au4cwifa
	YlUWqlk6wj39p4JWlWBInC4nwQsvf258DI9HpA0239bkzzIwX/Pz8DCJjLMzrudp
	CtWT+5bqLTXM530CIERVlQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a0nh5tn05-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 02:16:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUoFCkM0lommg5Yengn3JUs6+LO4LuvUlNxqVR34cNsDiutfMaIkr3x+021Ny/kfImEc0xzADSNOyqSisNc5GNO9cUeUGAxyQs5gQTQ6vEZCmSlKLIcjVv+VBsBSnGeQ/vEoKr+JwQg1h4JHm2JNv8C5V3eC2r9LSjXTBi39b5ep4/I4Igz9WNHg7P+J8kvtchuKRk2ea4keTrY8Ij7h80QJyTsrMKPQQ2MZOV0I7llOqkPwsQG2Abhp+NQ2/ypLGZxpJS8uVrX+RtbBc+HDYnDAPC2dgUaxgC5qHdD66kCkAydJzYDLE/E4JGgAgyxtMeSURXelVEz1adqzc6FNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODE9dA19lZ2wuyDIrO3PrG7fr8tIHN0aM0tVBEvHeKU=;
 b=LZXDvIutujsyo6Dx2yUis7XsA4IngTJlFSnO89lUkBcSmMn3frnpHuoVqXf0iOXiETcwK2t7PYdzjMtWDSx2yV7Pw4eP05YNCi6RyEew0HLno/8udWJ3EsmfRu2GMtshrb8F2drx13zeExX5ssKOUTGwnn527WImS2KffPf7hXPR0aXAwNUNPEbb/gxv6yYYpcW3CY3zJc/ux9nXLGjVzmYJ7UoVkWpLcoeirWGxfkALsI8RmtNSXXQ3dUq9g80aXEi3GeceO0U5R093576F173exldD11UMdnjTdtAFDRB2Gtjdyp/tv8RuFtnOJTvXeF2fm0D1dLSX9h1zrYUF5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SA2PR11MB4794.namprd11.prod.outlook.com (2603:10b6:806:f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Tue, 28 Oct
 2025 02:16:01 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:16:01 +0000
Message-ID: <00dac1a5-16b0-4b54-8525-c0c706f08626@windriver.com>
Date: Tue, 28 Oct 2025 10:15:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/build: make in-target rule robust against too long
 argument error
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, james.clark@linaro.org, charlie@rivosinc.com,
        linux-kernel@vger.kernel.org
References: <20250728093153.2330009-1-changqing.li@windriver.com>
 <CAP-5=fW983q0NUEvxibY+QKLss+_TsyRGtgZF_n_q-XFZ98JLA@mail.gmail.com>
 <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <ef286bfd-0703-4393-87eb-4b0a85084767@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0119.jpnprd01.prod.outlook.com
 (2603:1096:405:4::35) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SA2PR11MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 455f2517-c6af-4096-047a-08de15c7f07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGZjeFhDMGF6bG5OU01FMWdHZklJcGwvNzl1b2x6akVCdUtuOUo4UnpoTTNO?=
 =?utf-8?B?dlI4c0JPTVo5Zi9RRlM4b0pWWndNZ1VqSjRiT1B1YXBQYUYwS3ZOdThSZWJJ?=
 =?utf-8?B?QlFYdWRlSXF1ZGxUUTMzS1BRQ2dSOXZKaGRER2NVMGF4U0xpS3lKdFo2Nnc2?=
 =?utf-8?B?V0o5cEYxckttUTh6VHdkSkM5eCtHbW5ZSXlEdjVVL0J1MUhzU1lwTE41dFFX?=
 =?utf-8?B?S2hMUXAxUXRmcnVhVWVnaWkrVWdsV0dWbmttOC95ZE51MmtxYUQvL3FFQXVr?=
 =?utf-8?B?ZmFLaCtTSnNEcW11cHQrVHRYNk12YXB2a2xOTnhyNGZ1THF6L25hMXczUHJm?=
 =?utf-8?B?c213RmVucWY0UGhEemswUU5vU1RzQUZjTVNEcWRFNjk5LzJzbnhJRmkyU2hZ?=
 =?utf-8?B?YTl2QUhaemVSZFYzRDBtQVpIMmRWVTBXVjkzN0RGTlpBejM1eW8yZmRONmVP?=
 =?utf-8?B?dURrQXkwZk9lOE1QcVZuU3poWXNvSG9WTWpMWDN3OHgwYjFFODdGNVpZUWdv?=
 =?utf-8?B?TmNtSXRRS3FPM3Z2L3R6OE9xZGNVaGg2Mkw0K2cvTkJaUXRLUkpDL2pYaGlC?=
 =?utf-8?B?d3ZZanB4WnVEb2RzNW9kRTBsOFRpdVIyNkYya1c0a24zV04vRUtsNlFQZm1R?=
 =?utf-8?B?c1NjZGdPY3BOa3l3YW0wNWsvaU1pK2tFWE1ZM1Q5dExBMFNiSHV0RG1maU5T?=
 =?utf-8?B?RGgxeE9xSHkwUGViNnRWWFBsb1lZaUR6OXNuem9uL2hpTkQ3bk5BMGJWdWw2?=
 =?utf-8?B?bXB4eTk2azRwRUp4OVFXK214WUNMNjVpWUpRS2tLL1Y0QWtwSDgyODg5Ykpy?=
 =?utf-8?B?QnhRckZheEI0RmwxQkF4enlhdllsMlc1bStnM2cxZmxGTVlTdjBxVWtEUElO?=
 =?utf-8?B?VnB4cWxSWnRaT1gxcjcrd2ZZMDlGd2p5ZFJlUXdlQ3JrUDNNYThQcmtLVURw?=
 =?utf-8?B?cnA3WGZvMjROZ29PVGp0Wm5BOWFJRFhTRDhzU3RCWFVtaXdHeDRUVFphWHpJ?=
 =?utf-8?B?N0ZKQlhwRjI3TzhXUERRYW5nL1IvZDhWeFE3RjUwRHV0OUYxY0FBV05GaWY1?=
 =?utf-8?B?TjFnVFJOUU9Cay9SU0lubzhUUi9PVlgrNHBpYVBESjRxZkpDUTFJNFRHbWJz?=
 =?utf-8?B?SStzNWErb1UxT2hOS21qREhpc2dnZkRnekFaUlVVaDN4Rnk4a3VuQis5bHZ2?=
 =?utf-8?B?Wm5vMkNpSFVqSnFZc1VJNmFLRHZRajg2VlYvbmxydWlBdmxzUkVKbEVIV3Zt?=
 =?utf-8?B?NVVVRnJBMmMwYmNUSG1Bdm5CcjZJS0Faa0hkS1NSN1ZycExTL3hoa0Jsc29M?=
 =?utf-8?B?MEwvUVg5VFNLOWlRNTVvRkFNWjZqQWdkWjBWcFZhZ3BIM2RONTh0NkdBZUcz?=
 =?utf-8?B?YWNSUEtCMGpoNXE3UVhTQ2NEYzR1LzArNTlHdm01YTQyOEJwOEtBcjhFSnFJ?=
 =?utf-8?B?R2lNY2IyNzFqeFdDUnUyTVBsT3JjR0k2VE9xc0FDN0RZcTdIaXNUMXlwVk52?=
 =?utf-8?B?Sm9tSEVRQUhhT0tXVEhHZ0EwTnJnclg2bUo1VGJBakxBT2h2MjV3V2I4NUIr?=
 =?utf-8?B?ZTgwWVc2QWNCb0w1cVlVN1ZXeGNUL2U2ZjljejJUeTZnV05CdDltVWRVZERU?=
 =?utf-8?B?SVlORzZZQncwNGttdkl5UkRMbE5aNFpnVWpwWGRyZlBCaitNRHYrMlB0Q3hq?=
 =?utf-8?B?QTRMME1zbFFXL1FPRGpMSHg4RisrUXk4Rmg0eCtUS0dYS3dVeFQvWGVCYzZI?=
 =?utf-8?B?UjRGdDBRWUt3NG5hN1pUZUNrd2FlSUdyMmZwc3dJYlJWUDZ0M3RzcmlBWG54?=
 =?utf-8?B?ckNpVmErdllGMVNReXBhSUNMNXpudlpGTUNWMzFrVkVXK3RoeGhBa3F0SVdX?=
 =?utf-8?B?NmE3Nm0rZVYwZ0F0ekJYTXFUcEY4eDZBN1h2ZVVZWTZPNUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU5PMHVPTUlXRythWWphYmRZdnhMSXlnQVBYb29LZHc5NTROcnlObXdwbEhW?=
 =?utf-8?B?dnY3Rm9ONTdCOVY5UmhmZGRTSzU0ZzByNmVBbnhrbDFjdnBNYUZOQ1l0RjY5?=
 =?utf-8?B?VThOR3hJbVFFRGRURGdnVlZLY2E3V2ZjaTdQMFZ4bnh1Y0pEcS9jbm95U1Yz?=
 =?utf-8?B?N3IzbzJYOCtzMnY5aG5EKy8wWTlneExUdzdoN2F4dXBpeXhEeFlORGtsWnhj?=
 =?utf-8?B?SjM5cGQxZmp2T0xaNTQ0MUVsQVR3OUE0OWNSSUxpd29KVVY5cHhscEZpdml2?=
 =?utf-8?B?UTdlTm1MdlRRSERudUM0eDBDSnlqR09WVGVZUUJwZngvYThCY3puUEVHS1p2?=
 =?utf-8?B?QzNiRmhQSU55WThnanZ1YmRFTWxHdDhVRDZZclBKVmZIWXdpNmVlQ2g0MGtr?=
 =?utf-8?B?NjRWQXVWSy9YZmUzV1hycDExOXQ2SFo5QlZoM1hZclNqZTNYcmU5RytNak90?=
 =?utf-8?B?KzhyTVNGQ3VjVmFCaVJRRlBNRW1iMWlSZXRFc1FDV3FQNHJaRGVsSVhtc09J?=
 =?utf-8?B?aU1UVUh6ZjZpbzhYcEJJd2MxcDRkdEN6QWFMTXlEdW56REFEdEd3ZklXTXZY?=
 =?utf-8?B?OXJpLzZPM0pETjN5cjQwSTVWL0x3TDZGQUlNWjBEVUNmRzE5UVQ5ZHRIdlJG?=
 =?utf-8?B?TmNuT1RHUUpzaW9jWnR3dzdwSjNJS3JRVlNVQXlSWmVHekY4d3lzK0EvYyts?=
 =?utf-8?B?eGR0R3kzcEhZbTBQYkVtcUhaTURoTXFoRFNzdGplTk9WVUxPMWJrQ3F5ak9F?=
 =?utf-8?B?RmJkc09ZZ3lTM2xKRk5EV0pPdTM4NTJzTzlNU21OZTlvK2tZN0E5eDU0cXBC?=
 =?utf-8?B?MnVxMmFXSHBxRnoxT3RlTW8raWxCMG9pOGxzVlFxeHZZdzZKbXZaQ29MRExM?=
 =?utf-8?B?QW1udzVKUW1CR3BNSVArS2NtZTVtcmwxaUNpOFQ4MUJDMDFXckV4dEFPcUVZ?=
 =?utf-8?B?QmxJNXBSSUhiTjQxNExnL24zUU5IZlNBYVVpOEhnMmJkLzNIYzRzZ2FnOG1Q?=
 =?utf-8?B?aUFXUzM0SWZHeE5NQmZHYXREWCtVcUd0SGxDVXhJc3hNS25makpidXJVUzBX?=
 =?utf-8?B?cGVQY1EzdDRMNGVTQzNvK1JmZXBOemlPZnBwZy9sZTAwWWdGUDFucHdEUFVN?=
 =?utf-8?B?dmFKb3JOK2lhdFMyYXdaV2ZTUVdLaGVlaVdLQ0xFbjkvcUIyU2EvOG1lSmxM?=
 =?utf-8?B?Y01hMCtmSHF2UnBvSkxQSnRER0plNVlOQ09DUUlHMkdKQzM2aTRhWCtPUnJO?=
 =?utf-8?B?Vm4yaUdsKzhKdkFpditpeC8yTXJRRXhKVFVoZ1Y2Zi9STWVzWVRkUEhkRitB?=
 =?utf-8?B?R21OUmlEb3plbWZCbDZJa3I1djZ1dnNtUHNzNW0raWU5WVdXajdEOEx3ZGp0?=
 =?utf-8?B?V1laclpVa1ROTWp1U3dtT0xXWXZnaktNbnVUaUlwSmk5RER4K0d6VThIbXlk?=
 =?utf-8?B?bmk1UWswVzZSNmhkR0YydHRHVjFHWUQvbzJvS0ppZGVOQlZRNERjcFd4N2Iw?=
 =?utf-8?B?M0ExOFRDMTE0cVhKbkZNSG83anhmVXIrQk1EaXEzdkJFZk9DYUt3OEJIUHJZ?=
 =?utf-8?B?QU14bXJyTXIxT0xlTDJYVlMyc2d5elA3d1dRYVlGb1orOXVtS0YwZVh6czAz?=
 =?utf-8?B?V0ZxU0phL0JHSUVIRldnT0FRL1o4YXpuOHJZdktYMDhlUk9RVS9NbGh6bUZ1?=
 =?utf-8?B?OTV4ZEpYZ2Q5bjRyVk1Db3pta0xvNzZRVGIySEdwVFNadmtnSFQ2OG14Mm1Q?=
 =?utf-8?B?cytUT2RBTkY0c1l4U1lJSnM3S0xVenJ3QnBHL3RnaHZ1VU8wSW5RMTFEU0pT?=
 =?utf-8?B?dUs1UzRxRGdycGJDTzJZdHZkS1ZxVUt1M2hBdGdWdFhZMWp6MURvSnI4L1k2?=
 =?utf-8?B?cWJwelJjVTNRVWkxZlovZVZ6a2J0Nm9nUG9MVUlTTUZHNW1CMUVmVXVLdzVH?=
 =?utf-8?B?a3hJenpTcmthMWxQaTFFKytkT3ZvUGMvWkF2STNDaUp1QkduODB2V1FLNmxU?=
 =?utf-8?B?SGJEUTlydzEzdDVYN2tVbGEyTGh5cDFFZDJ4OUtmTGZUQWUvN3FrS1A1djNF?=
 =?utf-8?B?dDZLanI2RVRVUTM2cjNWcEtjZWc4czFBbFptcitqVVNtT3hZb29JOXdPU041?=
 =?utf-8?B?cUlxUjNvVVl0Z2FyY0dQOS93ZXNBRFRscWo1UXcvbkVoWkxPaEFQWUZFRjNZ?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455f2517-c6af-4096-047a-08de15c7f07f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:16:01.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHhJI16ki5/ivA0Om0RYDoHcERsjgoYgkLYhqDfuHymlYFHFmPhkfgFl7CHz+McZGlzVNQXVIKYjxyMsUFMQnaNccioJyckWCsYdR7nDKec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4794
X-Proofpoint-GUID: pzr27pr4gWvaigWW1ZHpb5DBJOy04xu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAxOCBTYWx0ZWRfX2CgRV2ybJdP4
 UNFbnAmL7+0ZK7iUabSHe8ldg8hUbgpxcRPcd0ox77hVe8ISL5W8ZX83k/v4F7DiVFqktQjCNXI
 xH1/rm2f6xIc0erGoewvPLjbtK2o0nSlowG5RWNfrCO8Dq9Jme6I+hDyJS07RplJtMPx8oF+8bm
 Z41vSPcUXMPmMJDWzfj0Il5+QWGrMyf0sjJFYa3iU1Yv3Ph/RJ9EsXMuf6S4Y70IBG/sYfFE/xT
 IdPVuT447QE/q3JS0X5/RyjNA9tME7xvW8ckC46wnNZFUzI9j3PeMwxo/7nNOj5qOA2d5A47GFP
 epB2p2+MNIQ12irzCKEFHBvWZnRzc5pe0gOq6AasFGqj3fU+qrbxN2O+lEjqOa/QYTwR8aq6bvM
 mjIVHqyJ29xjGUcXNG29uMl3Wiek+A==
X-Authority-Analysis: v=2.4 cv=FOoWBuos c=1 sm=1 tr=0 ts=69002764 cx=c_pps
 a=TKURuYQIacZDyiG+Utq8vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=Ptvq9zoxAAAA:8 a=t7CeM3EgAAAA:8
 a=z8vU8Gr3U-nLPclttLsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ke9shIQgfMkOMJk9-b84:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: pzr27pr4gWvaigWW1ZHpb5DBJOy04xu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280018

Hi, Ian

Kindly ping.  Could you reproduce it?  Any comments?

Regards

Changqing

On 8/19/25 11:01, Changqing Li wrote:
>
> On 8/19/25 04:38, Ian Rogers wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the 
>> sender and know the content is safe.
>>
>> On Mon, Jul 28, 2025 at 2:31 AM <changqing.li@windriver.com> wrote:
>>> From: Changqing Li <changqing.li@windriver.com>
>>>
>>> The command length of in-target scales with the depth of the directory
>>> times the number of objects in the Makefile. When there are many
>>> objects, and O=[absolute_path] is set, and the absolute_path is
>>> relatively long. It is possile that this line "$(call
>>> if_changed,$(host)ld_multi)" will report error:
>>> "make[4]: /bin/sh: Argument list too long"
>>>
>>> For example, build perf tools with O=/long/output/path
>>>
>>> Like built-in.a and *.mod rules in scripts/Makefile.build, add
>>> $(objpredix)/ by the shell command instead of by Make's builtin
>>> function.
>>>
>>> Signed-off-by: Changqing Li <changqing.li@windriver.com>
>> Thanks Changqing, the change makes sense to me. The printf is pushing
>> the values into xargs rather than using $^ with ld. I've tried
>> reproducing the error to test your fix by creating long directory
>> names in /tmp and then passing them to O=. I've not been able to do
>> this. Could you send a reproduction for me to test?
>>
>> Thanks,
>> Ian
>
> Hi, Ian
>
> Thanks. Here is my steps:
>
> 1. git clone https://github.com/torvalds/linux.git
>
> 2. cd linux/tools/perf/
>
> 3. mkdir 
> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0
>
> 4.  make NO_LIBTRACEEVENT=1 
> O=/tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0 
>
>
> 5. Above step failed with error:
>
> make[4]: /bin/sh: Argument list too long
>
> make[4]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build 
> <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:148: 
> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/util/perf-util-in.o] 
> Error 127
>
> make[3]: *** [/buildarea2/cli10/tmp/linux/tools/build/Makefile.build 
> <https://urldefense.com/v3/__http://Makefile.build__;!!AjveYdw8EvQ!c2n7zPX4Vrhwd7a9UxsjCXBGO5V8Llmon1egvupz4kHL4869ilesQgRgQZO8nj8AWwQJUlY9DOoWPD688quA73jNugR6IZRxy09Eig$>:142: 
> util] Error 2
>
> make[2]: *** [Makefile.perf:797: 
> /tmp/01234567890123456789/0123456789012345678901234567890123456789/0123456789012345678901234567890123456789/012345678901234567890123456789/01234567890123456789/012345678901234567890123456789/01234567890123456789012345678/9012345678901234567890123456789/012345678901234567890123456789/012345678901234567890123456789/01234567890123456789012345678901234567890123456789012345678901234567890123/perf-1.0/perf-util-in.o] 
> Error 2
>
>
> Regards
>
> Changqing
>>> ---
>>>   tools/build/Makefile.build | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
>>> index 3584ff308607..39066a3ef2fc 100644
>>> --- a/tools/build/Makefile.build
>>> +++ b/tools/build/Makefile.build
>>> @@ -70,11 +70,13 @@ quiet_cmd_gen = GEN     $@
>>>   # If there's nothing to link, create empty $@ object.
>>>   quiet_cmd_ld_multi = LD      $@
>>>         cmd_ld_multi = $(if $(strip $(obj-y)),\
>>> -                     $(LD) -r -o $@  $(filter $(obj-y),$^),rm -f 
>>> $@; $(AR) rcs $@)
>>> +                     printf "$(objprefix)%s " $(patsubst 
>>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>>> +                     xargs $(LD) -r -o $@,rm -f $@; $(AR) rcs $@)
>>>
>>>   quiet_cmd_host_ld_multi = HOSTLD  $@
>>>         cmd_host_ld_multi = $(if $(strip $(obj-y)),\
>>> -                          $(HOSTLD) -r -o $@  $(filter 
>>> $(obj-y),$^),rm -f $@; $(HOSTAR) rcs $@)
>>> +                          printf "$(objprefix)%s " $(patsubst 
>>> $(objprefix)%,%,$(filter $(obj-y),$^)) | \
>>> +                          xargs $(HOSTLD) -r -o $@,rm -f $@; 
>>> $(HOSTAR) rcs $@)
>>>
>>>   ifneq ($(filter $(obj),$(hostprogs)),)
>>>     host = host_
>>> -- 
>>> 2.34.1
>>>

