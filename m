Return-Path: <linux-kernel+bounces-756827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96AB1B9DF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1341E7A3600
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA459295D91;
	Tue,  5 Aug 2025 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vMy++Ups"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2105.outbound.protection.outlook.com [40.107.96.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D08292B47
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417653; cv=fail; b=ort3FF64MnpaIBbauvAQC60B85l/oIU0cTSV683dZFBi+epZOk0l9/WzUh38S3q4E2SEKGMS72UoqwKvJqBXPTSBYH6vl7HFu2m6TilqWcG6iULC4CcBZxep9KhjuDRMCZab8tYG5dmzrco0XWSAQHRMmmb7NuVdK90iEGWlVMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417653; c=relaxed/simple;
	bh=BoSoEIt+JJlrKnSQkr49j+CGRSA+Ros+no5ZFsIWUgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hFXgMeFIkbxpT79gg2RGKNoKRWs2RMLdsvPa8YwhIvMG1T9+DISp9JI8X1TOGrl6xCGVaTjestkovPQrspHcSMKsscDsvqBqH/FpLUKfhLecNoBsRqsdfWyHYPjR7fj81agP1n+ELuSwi52Q4qBYNa1D++wZz6ERI6IlPS6D3pA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vMy++Ups; arc=fail smtp.client-ip=40.107.96.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT4lXqCjNDfwejq9GznrIQAgoj/lt2IzVfXLdBgkuyl5RDE3o+7lFtny4mkJQSO29XcCQJhFGOcLgWNzCsiyRbrZfBcWpytpKhXDeh8b/JPT+cgm77bRyoA9OWP1xzPWQ9ZG+JukWU6PxxWn0LyXpHFKWboxXGShAomlR7o+37S7oFNDp5DrxVAQ167MltntLw69tgBf6gY7Ll/LX83eCs53UpcK6rDsoV4slT79Ky7Wquhpre2Jz8aGlrqgs3K0Fvq2bIfCIqi2UtNRDz7Ngy6cIMI/WjSA+UJShCbsmAF7zl29YMugvyEIfmifArvbmblgMFxiWgYFzTlar8TjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHMCaljCoDQ2e/EQ2irvg/QTfpswG9svT9QCyE/9RkA=;
 b=Rl9yXdKZfg8BjhInUc5CT4VxiVCfuUJEj8mni5LB+QiweN6oxvkqFyu9ln4xU+TPOH7ZBmZISAhmbFLN5g9Sgkafj5J9hV5X7lWPlC7Poi7wiX6nLGcjXChapJxNbOQlonQGlSBLvjnae4t368B4JoubdJcArwLBfn/iTBdIL7O95B5Ktn3aSQGGMn7A7UVht+j9s/61cO6pIECdquJZSBjgg0kUeQr1d87f3CA/gZzuX6wGfE2zS4cYzF+LxWr9s63u6+geie/M7TCFk4fGCy6R2IvAVEZEmJnZQCHw5N5l2sDQqs0A86YujEbj26kVrc5c6Zm+/zMdDoUWwgc3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHMCaljCoDQ2e/EQ2irvg/QTfpswG9svT9QCyE/9RkA=;
 b=vMy++UpsPyTiiT9rgz827BQ0hMI6GPOcuSIaVF3GloD8mCwULL+N4Ij6Ojx99ERjfh2vn6VWlmdxCdKZuvvpkJ8VpGF6Q1C64SX08MRKJxbcgOv5VOx4U/7nCjZ2lKcBuQHR0k7W/EThaFpJgfc2OKwJIixsNhfDBylYaVJB0fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BN0PR01MB7181.prod.exchangelabs.com (2603:10b6:408:158::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:14:08 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:14:08 +0000
Message-ID: <6d32bdf5-ccde-4779-a2df-08b6859dbf8e@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 11:14:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 4/4] arm64: mm: split linear mapping if BBML2
 unsupported on secondary CPUs
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
 <20250805081350.3854670-5-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250805081350.3854670-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0108.namprd05.prod.outlook.com
 (2603:10b6:803:42::25) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BN0PR01MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0410a3-abcd-41d5-0779-08ddd44bdea7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0dPNENteWo3RmgySEFXZkcreXNUWVEyNGlpVTV3dmZSaUhKeEphRzlNOU5v?=
 =?utf-8?B?ZE9QbWhBZkZyM1ljY2JWMCs0WmNJTDEzQUpNNFBVSVl2OWUxWi9zTHVzK3Bj?=
 =?utf-8?B?VWJWMlFtcGkwVkdzMWhaMDZLdGc2bUV2RDZmT0RBbWwwcHppV0laNmRCUWhX?=
 =?utf-8?B?cm5wdlBWTFp3eWJvQVpCRDE1aXpET0JPTnVTS0NYZEIybE5BYVhEbFdjRDBK?=
 =?utf-8?B?Zk9UcG80SVB4WjRVdGVNeDVVekdBVHhyQkJiNmZpNUlHMXI2NWZHZ2xBeWRk?=
 =?utf-8?B?LzE3MHBDUGxmQUE1M3BxK290MG5UM3lZSUxvQjRlU3NndGdHQ2UxMXp6QVBr?=
 =?utf-8?B?ZHBENGdKSEtUNjdHWkJja05kSXFvV01lTUMyMERaNEQ4ZVNBNG1WdTNzNzJN?=
 =?utf-8?B?SmpUY0NpNEtQeUN5dnUycnZSdkk3NHQ0eXp5NGJCOXJoanVpNDNnMDcveTl5?=
 =?utf-8?B?dW1WM2tzMEFYbk9rNlJ0UDFqd3pQVmRGTVgxWlhqVFlyWnpqTmdBazkxN1Vy?=
 =?utf-8?B?UEN4YzhGdWpGc3FQSVlRVXVwVEZVOEhBSmsrV3dIeExld1ZOZEZWY0ZvOGtF?=
 =?utf-8?B?OVVubXpITjhaalRMUkhnakpYa2c0eEJRTGw0Rzd6QWNKcUh3Zzc1Q2tTa1ZR?=
 =?utf-8?B?U2FhS1NlZmR1THJ3ejZwQit3bVh3RTY4ZldyUDJNcCtmSzdWSjNhR0Y2RWFF?=
 =?utf-8?B?WFRXKyt1bVRnd3VFcFhLcmNOMnFzcGdpcmF1WFJ5bjBBQW4vL2d0S1Q2Sk9u?=
 =?utf-8?B?eDJ1ZmRKOVRNU1NSMitCSlY5UjlEclBCMXlSZXhZTjAxSXFiMmRjNDVIWlNu?=
 =?utf-8?B?UFg4MThnS2JPeVh6cGcvaG1wNkwrWHNaaDZ2V01NejVIdlc4c0xkdGVuSkdx?=
 =?utf-8?B?SFdPZjBORVVBSkoyelpPUHF3dGF2cmlrbTdsK0dWLzBnTUMxdzZGeEpudUp2?=
 =?utf-8?B?ckxnZjUzcGxqZCswSERwNXRpNmRHWmZ5RDUySjhOczd3ak9JYzBqYk1GNklh?=
 =?utf-8?B?a0o3WXZLczhjZlB3MTZxalFCbDRTVDZtTWNVTWUxcm9RTDN4dUdiS3NHdnlh?=
 =?utf-8?B?d2R6d08zbXpBQjVidDNCbFBQSllGSzFaU25qV0lJYThyb1JTOUNXWE5DNGZv?=
 =?utf-8?B?L1orYWQvU3hOeWdhTUY0RUJzKzJ4RXF4Ly9EbmlzR3dOK3ZkeWI3L1JLUlBh?=
 =?utf-8?B?OTFRbWc3UmcwbEVzdmo2b2NETFNIL1pONmhxdUJraUxLRGhUN0ppQy9jak5Q?=
 =?utf-8?B?VVFrVE05M24xYTduRGp3QzFwdkkxaXlYZld6VTZZWWREVWdFSUc5Q1QxOG5l?=
 =?utf-8?B?dTF2ZExFSThodkNDNVNOUnVnb3o4MHJOdUtGcWxHWC9YTWZHZVBLVzRkOTkw?=
 =?utf-8?B?Rk5tZ25teW1oSWRra0pvc2ppN3paMStZazdsRWNrVm5oeHdxYmsrZ25OcUpI?=
 =?utf-8?B?TE81Mmx2dFRIRlM3OG5tNnRGVnk0K0JGMGRiTFBNRjZWY3d4WHhOMUx0OEhQ?=
 =?utf-8?B?RmU2RVlTcDh3V2dQZktMUGRpVU91U2FBNTR5bTIzeUdnaVdpd2ZTZHI2aGlY?=
 =?utf-8?B?VlUrODY2NzYrTWtkRWM3NnFPbkkyR3pCYm5GSkNERmlpZ294L1BkRC9uSmx5?=
 =?utf-8?B?cVlhODFLcVdPYUhveldlRUowZ25DSElkRi9TS1R4c1RVUkNHV2hzZFdkbDEy?=
 =?utf-8?B?QkhVc04zaGFhT1NXYjUwaURKeDJSMGl4SkdFcVRud2VUYk5Wblh3ayszRTZF?=
 =?utf-8?B?Y2dqOGtQZkVLeGQ5V3BLMnRYSnR1UTByZ0tVNjUrbDg4Z2NsOUJYUUxnV1pT?=
 =?utf-8?B?RTBJUDg4emhRVHFFUG1oalhrTGFLS1lnYzBYOUJRWDlyWjJqcTRWV2E2TFBv?=
 =?utf-8?B?NDA2eTRRTHBUSjFOdS9tMkl6L2JpWGI4Y0hqemRBdGdOdllhcFZnUUJibk1E?=
 =?utf-8?Q?lrpqAjcxXc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akJvVjcxRWlvakxZK2lBa3V4RUVETlBxL3c4Wlp4OEwrTlUrbEJlWU10WWlT?=
 =?utf-8?B?dkJRMStXL3gzRHh2OHZjQmdRQWFDN1BqYWlSUUZHV09JekxXR01WYUc3ZnNK?=
 =?utf-8?B?MUZRZFYyYlRpbTdHUFZVOVc3YXZMeDAyeVZJTGJzelFCcHVNbVBrTkdZR2hl?=
 =?utf-8?B?UU03TWcwTTlQZm1BRmc3S2hkeDlOMEJaVldXK1k2Nis5d2twSHBCMVNJN1Nv?=
 =?utf-8?B?NnBQQ2hUdkpnS2VmbE9OcFZmZzJNZGxwWlRwS0x3SHZ3SmdJVmQ1eGE0UG9j?=
 =?utf-8?B?cGU1VGptYTBnSWFvZHdYSlhNbmVzaE5EbTRBQ0ZTY2t2QU9PdEltUWJYV21B?=
 =?utf-8?B?VUFSakVOQ1Fpci9sSDN2d1RFWDFGeE8xTXRvcGhpaGpwTnJFZkpHbzlwWEVl?=
 =?utf-8?B?cmtEeHc1VjJjK2JZbGl1ZEgxcDN0K243VXZ1ck9rN2FqSDVQZ2E4SG5JUGxp?=
 =?utf-8?B?OHFQV2UvdlcwUEZlZUZtYUJSbkN3Qzl4VGl6bnRzTFFMVXpiRDBkL05wbllO?=
 =?utf-8?B?Q2dqYUpzclpjY3l3K1RlK2Y2TTVKNW92VDdNNDJLd1p1YUNPKytELzJUbjZw?=
 =?utf-8?B?MzZoaVg5dVRJOWx0c1UyWng4Yk1JNDdUMW5DRlZUVm05emNDQVN0SlV1a2s5?=
 =?utf-8?B?QVFNeldvTllZTzIvZndNUit6Y2NRbTdTWUN3VjdaT0tSM0NlQXc1M1FNcDFn?=
 =?utf-8?B?dDZ5WlZreUw0YnVJUzl5cUlHbXhRWnNvbUZ3bkhFQ2NMQTYvY3JaTUpQZytK?=
 =?utf-8?B?R1liM2U0dUpBSXdjcXhqemp1V0xwaFlJL3lpQytoL2w5MVR2cTNseVBteTNr?=
 =?utf-8?B?T0gwQjN2aTlsVE1rTnoySjRTcFgyVUdLMXovMk9nYTdZWlVtdk5SeG1tNTFT?=
 =?utf-8?B?VjBMRzNMaXZkYk5ObWRSaVRWdkxRbTZ4clN0TElHTldWa1JlTHRPUk0zbFBl?=
 =?utf-8?B?VWFhUVBOV1JPU0svbDlqNXB6U1R3UjJIVWZ3ZlRLeloyTW1jNEI3UFlRWStx?=
 =?utf-8?B?SXF1NmhZSC9wMXVLVEl3TlpRR3JITTNpL3dVNjU4cStNampHL2cyNE9RUFor?=
 =?utf-8?B?RkV1bGhSVUVJSzE0c3dUdWxWMG9mZ0VqeEFPeC9ibktYWXVQeE40VjB5MUNp?=
 =?utf-8?B?TEUrQjJSajNrK2ZwQjROMDdnY1A1MUFsU2tkNGtCM0VDSWFoOXBhWHU3N05y?=
 =?utf-8?B?dG10SHlTSm01cmVPVi9VTTFpc0xOZUZ2Ri9STnMwd2FMVXRJamw3V2YvTkx0?=
 =?utf-8?B?T0xEMXM2d0llUnNPWUZFNzJ3R0JKK0FkVy95NC9Vd0VpVUF3SllHNlFhYyta?=
 =?utf-8?B?a1NFOXA1WWtCVFhGQmdyZ3p2T1A3RlFNaXdWMkFDRDlqWFArMkx5dk1NSGtn?=
 =?utf-8?B?MUNJcFo3Z00xcEs5c3VqVlBmangxODQrbVZrMkp3QUVMOHREa1NPd3pxSU1l?=
 =?utf-8?B?WXhGck8wcE90cE5tSFlCMjlOL1NTTVZIY29WRnNYNXhRQkVoRXloNjBZazVF?=
 =?utf-8?B?a1FOSEZrWWpWeUF3UC8wZkRLK3lXalRpR21jVUZrRFlXS0xoZ0N6OWxiL1RK?=
 =?utf-8?B?eEdadzhGVE00QTRaa21rd29iSGR5Q3AweUk2WU85cmFnaXhJalJRRnlvUHFX?=
 =?utf-8?B?cWU3bUtCbkJCWHFlTjBEV3N4WVN2WkdPcjJNYXNxcUVocUhkL3lZYTRkcjVT?=
 =?utf-8?B?aklGQy9JNWRwMjQzb1VQaWtkQ2gyR1M1SGI2d3JvU1lsRFkyai9pM2d0UEo1?=
 =?utf-8?B?WUVNTFdwbnNPdGR4VXFVaXJIWUR5dlRXWTYwSHZYYUtZNUo2OE84QWVJWkFH?=
 =?utf-8?B?bk51OTd0MjIvbmdTZFhTRFZDRWVtTEVRK3VicUt2V1o5VDhBWk5qQlBwR21N?=
 =?utf-8?B?N2tTcWN6T05LUiszR0V0NTRxL3VLZThJS0l6YXp1QUhoQlhiM2pPb2RxeHRy?=
 =?utf-8?B?ZWpSTDNScjBkY2pmeG44L3pWbURWQ003RkR0ajIvb2psSVNNYXVLbUdnOFlt?=
 =?utf-8?B?b21ybG0zaDFDWitPbG8wVkhNT1l3SGNmVlZiYk9TNmhCNGVKNGpUT0N6bmFM?=
 =?utf-8?B?ckM1d0tHQWViOVByVGFaNUJVTUQ2UDhpK3RWYWxQeDdobHFBelJEWEpOd0Fm?=
 =?utf-8?B?NFBZbnJEQk5LaHZzR0JPMWlJM0U4T0NodmEwellDd3FiOXAzRDVlN014ZWs1?=
 =?utf-8?Q?k7Q/8UsnxzRryTspW1BBMsY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0410a3-abcd-41d5-0779-08ddd44bdea7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:14:08.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDVX7WmJ3etJ2sLFCZbIFR3suHq5O8WnCUFNWpxy8N1J6c3d7gJxnJQq4wn7274JWFMVsQ5Id1jsxGe8GykXcbB05ukg8YPd4tytV4SK+GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7181



On 8/5/25 1:13 AM, Ryan Roberts wrote:
> From: Yang Shi <yang@os.amperecomputing.com>
>
> The kernel linear mapping is painted in very early stage of system boot.
> The cpufeature has not been finalized yet at this point. So the linear
> mapping is determined by the capability of boot CPU only.  If the boot
> CPU supports BBML2, large block mappings will be used for linear
> mapping.
>
> But the secondary CPUs may not support BBML2, so repaint the linear
> mapping if large block mapping is used and the secondary CPUs don't
> support BBML2 once cpufeature is finalized on all CPUs.
>
> If the boot CPU doesn't support BBML2 or the secondary CPUs have the
> same BBML2 capability with the boot CPU, repainting the linear mapping
> is not needed.
>
> Repainting is implemented by the boot CPU, which we know supports BBML2,
> so it is safe for the live mapping size to change for this CPU. The
> linear map region is walked using the pagewalk API and any discovered
> large leaf mappings are split to pte mappings using the existing helper
> functions. Since the repainting is performed inside of a stop_machine(),
> we must use GFP_ATOMIC to allocate the extra intermediate pgtables. But
> since we are still early in boot, it is expected that there is plenty of
> memory available so we will never need to sleep for reclaim, and so
> GFP_ATOMIC is acceptable here.
>
> The secondary CPUs are all put into a waiting area with the idmap in
> TTBR0 and reserved map in TTBR1 while this is performed since they
> cannot be allowed to observe any size changes on the live mappings.
>
> Co-developed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---
>   arch/arm64/include/asm/mmu.h   |   3 +
>   arch/arm64/kernel/cpufeature.c |   8 ++
>   arch/arm64/mm/mmu.c            | 151 ++++++++++++++++++++++++++++++---
>   arch/arm64/mm/proc.S           |  25 +++++-
>   4 files changed, 172 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 98565b1b93e8..966c08fd8126 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -56,6 +56,8 @@ typedef struct {
>    */
>   #define ASID(mm)	(atomic64_read(&(mm)->context.id) & 0xffff)
>   
> +extern bool linear_map_requires_bbml2;
> +
>   static inline bool arm64_kernel_unmapped_at_el0(void)
>   {
>   	return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
> @@ -72,6 +74,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>   extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
>   extern void mark_linear_text_alias_ro(void);
>   extern int split_kernel_leaf_mapping(unsigned long addr);
> +extern int linear_map_split_to_ptes(void *__unused);
>   
>   /*
>    * This check is triggered during the early boot before the cpufeature
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f28f056087f3..11392c741e48 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -85,6 +85,7 @@
>   #include <asm/insn.h>
>   #include <asm/kvm_host.h>
>   #include <asm/mmu_context.h>
> +#include <asm/mmu.h>
>   #include <asm/mte.h>
>   #include <asm/hypervisor.h>
>   #include <asm/processor.h>
> @@ -2013,6 +2014,12 @@ static int __init __kpti_install_ng_mappings(void *__unused)
>   	return 0;
>   }
>   
> +static void __init linear_map_maybe_split_to_ptes(void)
> +{
> +	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort())
> +		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> +}
> +
>   static void __init kpti_install_ng_mappings(void)
>   {
>   	/* Check whether KPTI is going to be used */
> @@ -3930,6 +3937,7 @@ void __init setup_system_features(void)
>   {
>   	setup_system_capabilities();
>   
> +	linear_map_maybe_split_to_ptes();
>   	kpti_install_ng_mappings();
>   
>   	sve_setup();
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index f6cd79287024..5b5a84b34024 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -27,6 +27,7 @@
>   #include <linux/kfence.h>
>   #include <linux/pkeys.h>
>   #include <linux/mm_inline.h>
> +#include <linux/pagewalk.h>
>   
>   #include <asm/barrier.h>
>   #include <asm/cputype.h>
> @@ -483,11 +484,11 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>   
>   #define INVALID_PHYS_ADDR	-1
>   
> -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>   				       enum pgtable_type pgtable_type)
>   {
>   	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> -	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
> +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
>   	phys_addr_t pa;
>   
>   	if (!ptdesc)
> @@ -514,9 +515,9 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>   }
>   
>   static phys_addr_t
> -try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
> +try_pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type, gfp_t gfp)
>   {
> -	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
> +	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>   }
>   
>   static phys_addr_t __maybe_unused
> @@ -524,7 +525,7 @@ pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>   {
>   	phys_addr_t pa;
>   
> -	pa = __pgd_pgtable_alloc(&init_mm, pgtable_type);
> +	pa = __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>   	BUG_ON(pa == INVALID_PHYS_ADDR);
>   	return pa;
>   }
> @@ -534,7 +535,7 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>   {
>   	phys_addr_t pa;
>   
> -	pa = __pgd_pgtable_alloc(NULL, pgtable_type);
> +	pa = __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>   	BUG_ON(pa == INVALID_PHYS_ADDR);
>   	return pa;
>   }
> @@ -548,7 +549,7 @@ static void split_contpte(pte_t *ptep)
>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>   }
>   
> -static int split_pmd(pmd_t *pmdp, pmd_t pmd)
> +static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp)
>   {
>   	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>   	unsigned long pfn = pmd_pfn(pmd);
> @@ -557,7 +558,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd)
>   	pte_t *ptep;
>   	int i;
>   
> -	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE);
> +	pte_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PTE, gfp);
>   	if (pte_phys == INVALID_PHYS_ADDR)
>   		return -ENOMEM;
>   	ptep = (pte_t *)phys_to_virt(pte_phys);
> @@ -590,7 +591,7 @@ static void split_contpmd(pmd_t *pmdp)
>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>   }
>   
> -static int split_pud(pud_t *pudp, pud_t pud)
> +static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp)
>   {
>   	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>   	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> @@ -600,7 +601,7 @@ static int split_pud(pud_t *pudp, pud_t pud)
>   	pmd_t *pmdp;
>   	int i;
>   
> -	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD);
> +	pmd_phys = try_pgd_pgtable_alloc_init_mm(TABLE_PMD, gfp);
>   	if (pmd_phys == INVALID_PHYS_ADDR)
>   		return -ENOMEM;
>   	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> @@ -688,7 +689,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   	if (!pud_present(pud))
>   		goto out;
>   	if (pud_leaf(pud)) {
> -		ret = split_pud(pudp, pud);
> +		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL);
>   		if (ret)
>   			goto out;
>   	}
> @@ -713,7 +714,7 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   		 */
>   		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>   			goto out;
> -		ret = split_pmd(pmdp, pmd);
> +		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL);
>   		if (ret)
>   			goto out;
>   	}
> @@ -738,6 +739,112 @@ int split_kernel_leaf_mapping(unsigned long addr)
>   	return ret;
>   }
>   
> +static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pud_t pud = pudp_get(pudp);
> +	int ret = 0;
> +
> +	if (pud_leaf(pud))
> +		ret = split_pud(pudp, pud, GFP_ATOMIC);
> +
> +	return ret;
> +}
> +
> +static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pmd_t pmd = pmdp_get(pmdp);
> +	int ret = 0;
> +
> +	if (pmd_leaf(pmd)) {
> +		if (pmd_cont(pmd))
> +			split_contpmd(pmdp);
> +		ret = split_pmd(pmdp, pmd, GFP_ATOMIC);
> +	}
> +
> +	return ret;
> +}
> +
> +static int split_to_ptes_pte_entry(pte_t *ptep, unsigned long addr,
> +				   unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t pte = __ptep_get(ptep);
> +
> +	if (pte_cont(pte))
> +		split_contpte(ptep);
> +
> +	return 0;
> +}

IIUC pgtable walker API walks the page table PTE by PTE, so it means the 
split function is called on every PTE even though it has been split. 
This is not very efficient. But it may be ok since repainting is just 
called once at boot time.

Thanks,
Yang

> +
> +static const struct mm_walk_ops split_to_ptes_ops = {
> +	.pud_entry	= split_to_ptes_pud_entry,
> +	.pmd_entry	= split_to_ptes_pmd_entry,
> +	.pte_entry	= split_to_ptes_pte_entry,
> +};
> +
> +extern u32 repaint_done;
> +
> +int __init linear_map_split_to_ptes(void *__unused)
> +{
> +	/*
> +	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
> +	 * that's the only CPU that we know supports BBML2. The other CPUs will
> +	 * be held in a waiting area with the idmap active.
> +	 */
> +	if (!smp_processor_id()) {
> +		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
> +		unsigned long lend = PAGE_END;
> +		unsigned long kstart = (unsigned long)lm_alias(_stext);
> +		unsigned long kend = (unsigned long)lm_alias(__init_begin);
> +		int ret;
> +
> +		/*
> +		 * Wait for all secondary CPUs to be put into the waiting area.
> +		 */
> +		smp_cond_load_acquire(&repaint_done, VAL == num_online_cpus());
> +
> +		/*
> +		 * Walk all of the linear map [lstart, lend), except the kernel
> +		 * linear map alias [kstart, kend), and split all mappings to
> +		 * PTE. The kernel alias remains static throughout runtime so
> +		 * can continue to be safely mapped with large mappings.
> +		 */
> +		ret = walk_kernel_page_table_range_lockless(lstart, kstart,
> +						&split_to_ptes_ops, NULL);
> +		if (!ret)
> +			ret = walk_kernel_page_table_range_lockless(kend, lend,
> +						&split_to_ptes_ops, NULL);
> +		if (ret)
> +			panic("Failed to split linear map\n");
> +		flush_tlb_kernel_range(lstart, lend);
> +
> +		/*
> +		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
> +		 * before any page table split operations.
> +		 */
> +		WRITE_ONCE(repaint_done, 0);
> +	} else {
> +		typedef void (repaint_wait_fn)(void);
> +		extern repaint_wait_fn bbml2_wait_for_repainting;
> +		repaint_wait_fn *wait_fn;
> +
> +		wait_fn = (void *)__pa_symbol(bbml2_wait_for_repainting);
> +
> +		/*
> +		 * At least one secondary CPU doesn't support BBML2 so cannot
> +		 * tolerate the size of the live mappings changing. So have the
> +		 * secondary CPUs wait for the boot CPU to make the changes
> +		 * with the idmap active and init_mm inactive.
> +		 */
> +		cpu_install_idmap();
> +		wait_fn();
> +		cpu_uninstall_idmap();
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * This function can only be used to modify existing table entries,
>    * without allocating new levels of table. Note that this permits the
> @@ -857,6 +964,8 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>   
>   #endif /* CONFIG_KFENCE */
>   
> +bool linear_map_requires_bbml2;
> +
>   static inline bool force_pte_mapping(void)
>   {
>   	bool bbml2 = system_capabilities_finalized() ?
> @@ -892,6 +1001,8 @@ static void __init map_mem(pgd_t *pgdp)
>   
>   	early_kfence_pool = arm64_kfence_alloc_pool();
>   
> +	linear_map_requires_bbml2 = !force_pte_mapping() && can_set_direct_map();
> +
>   	if (force_pte_mapping())
>   		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>   
> @@ -1025,7 +1136,8 @@ void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
>   		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
>   
>   static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
> -	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
> +	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
> +	  bbml2_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;
>   
>   static void __init create_idmap(void)
>   {
> @@ -1050,6 +1162,19 @@ static void __init create_idmap(void)
>   			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
>   			       __phys_to_virt(ptep) - ptep);
>   	}
> +
> +	/*
> +	 * Setup idmap mapping for repaint_done flag.  It will be used if
> +	 * repainting the linear mapping is needed later.
> +	 */
> +	if (linear_map_requires_bbml2) {
> +		u64 pa = __pa_symbol(&repaint_done);
> +
> +		ptep = __pa_symbol(bbml2_ptes);
> +		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
> +			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
> +			       __phys_to_virt(ptep) - ptep);
> +	}
>   }
>   
>   void __init paging_init(void)
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 8c75965afc9e..dbaac2e824d7 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -416,7 +416,29 @@ alternative_else_nop_endif
>   __idmap_kpti_secondary:
>   	/* Uninstall swapper before surgery begins */
>   	__idmap_cpu_set_reserved_ttbr1 x16, x17
> +	b scondary_cpu_wait
>   
> +	.unreq	swapper_ttb
> +	.unreq	flag_ptr
> +SYM_FUNC_END(idmap_kpti_install_ng_mappings)
> +	.popsection
> +#endif
> +
> +	.pushsection	".data", "aw", %progbits
> +SYM_DATA(repaint_done, .long 1)
> +	.popsection
> +
> +	.pushsection ".idmap.text", "a"
> +SYM_TYPED_FUNC_START(bbml2_wait_for_repainting)
> +	/* Must be same registers as in idmap_kpti_install_ng_mappings */
> +	swapper_ttb	.req	x3
> +	flag_ptr	.req	x4
> +
> +	mrs     swapper_ttb, ttbr1_el1
> +	adr_l   flag_ptr, repaint_done
> +	__idmap_cpu_set_reserved_ttbr1 x16, x17
> +
> +scondary_cpu_wait:
>   	/* Increment the flag to let the boot CPU we're ready */
>   1:	ldxr	w16, [flag_ptr]
>   	add	w16, w16, #1
> @@ -436,9 +458,8 @@ __idmap_kpti_secondary:
>   
>   	.unreq	swapper_ttb
>   	.unreq	flag_ptr
> -SYM_FUNC_END(idmap_kpti_install_ng_mappings)
> +SYM_FUNC_END(bbml2_wait_for_repainting)
>   	.popsection
> -#endif
>   
>   /*
>    *	__cpu_setup


