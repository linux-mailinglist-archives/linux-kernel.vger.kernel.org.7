Return-Path: <linux-kernel+bounces-769962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C33B27568
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA31CE75F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9455298CB0;
	Fri, 15 Aug 2025 02:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qWaRX+Vy"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E1026F44D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223301; cv=fail; b=iLDc5xRj2I5ED7beVlJ7aq4w8T8hditu7ti+WYmviJnniyozWoyPpuQDm2LyGyDxFHrWNh9+0ID2mL+kVA2OET4AZ2xfj35gPl1hkDy3n5/B/10r5tYUWCTv/nEMmynN7D+COvVHhfJciPIzQEPJyDUZqwqn9iVtlv+2EkZP/F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223301; c=relaxed/simple;
	bh=yNYUnu+rsrpFlU7oR1qWWw/s+BxpLDjyY3x1gYxQnck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccSS4l0PqBj+sF1kgFyU1hKRGMkOGl5fDKHuXaZCM5fvG24A6CCsKfUAggcFd92sQxvjvpPuqnboCYaFfKRhuF5MPMOZYw9RRBM5C5zHopIPtW7AzlUEV2FWl+8YMRjqulSefnXFR11F7R62hG7y7SAA+CevTllSB1P6U5JGg0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qWaRX+Vy; arc=fail smtp.client-ip=40.107.102.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkVMvcHnWD7V+5a7CiVWO1Dhn1Eo5AvpHchLT86Ao1cmJfzpdqf6H4kosvfJxktkDaZk4dwI2pE4QMBMrqVN74Dg2h8y1X94noKD1Z1fe6akaxh3RIra0VUGuPjNlBLYXWPOw175vX+0Z6iwlqBE5BBHY0ls/c5cL+XLo88nb6Xnk4ffuN6vF0plXk2VLI+RhQYCSe3BjQiB3Kmr1yIEaS6xc/CyWuOvwKZlyQ+NzUTR6KP2My4+lDgF4n6XxGDhzs5/Df/IMm8L4neSgMyvGWkXxjBXMJSG1AGV01TZOia/JWCZm1Hbqc7mpvNWlMRGjAhAgzDDDf5b78tIlW0Dhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNYUnu+rsrpFlU7oR1qWWw/s+BxpLDjyY3x1gYxQnck=;
 b=cwrXPyBQKsZ8HDNua0I7ZEzH3zFMrnr0/BHoJRVcnJFJAysD+mvdpg9NKqT+R1iF232yC1IsmxU5ki3QLRq71+1l/szfcF5dKW+nih9Vixzi7PfZ7FYl4wZ8b3KBaAghdF9ETfUwdaecfdeV0cVeDQNEB2YAXgP+Rzd3l5OLNC0JfUmD+p9OWe1VwQIaUEXsIqnRrU28Onj7hizaOQvTsWvDCwZrTkXIlb6ZxCVJkCeEoWnGGEsGrt+fHTzuqWOJFT9dAJRfW1/fF63eAE2cGEgzD/aC3UUPQdX/rO0PX5jdXmrCONSQl0Z2FaO2b7RRovQxPW7+cCIRkC2wkq2d1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNYUnu+rsrpFlU7oR1qWWw/s+BxpLDjyY3x1gYxQnck=;
 b=qWaRX+VynY5krZWRDe+HQUXeSpB7WihNoUpb07PF99enBCAu5GIUIbVBVkr9B7oBPX25K04Cf07s9qMf0wi8rqt2zd/503/dflLOPbHc59jU40+zWO//3AkZO336UNRWEO4uBx9Z94OhMS3jNzgNu0waaSpJsJhaCDJxe1FdV3xM1t/wWu0LoGur4H1beEvOPD85ztsv4ur9MN/ZvZDOCCIfnxKE7DxXcfbLq3Z0dprkDourL6+1ESmUmbm7PLwCtCVFHdrDJyJ/mUh2qkP5coJcYDWwP6uBIxWWezIBcUxMSqDkLKqsRpXI+McWUkJt2Kl2OAKJ1OAE3tqnjsQ0hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Fri, 15 Aug 2025 02:01:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:01:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Ye Liu <liuye@kylinos.cn>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: simplify lowmem_reserve max calculation
Date: Thu, 14 Aug 2025 22:01:32 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <B655AC6F-B6B5-4B1A-96F4-DF9EE52993D0@nvidia.com>
In-Reply-To: <e5b381aa-33a2-4537-9f71-a95f621441a7@linux.dev>
References: <20250814090053.22241-1-ye.liu@linux.dev>
 <20250814140713.GF115258@cmpxchg.org>
 <e5b381aa-33a2-4537-9f71-a95f621441a7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:208:52d::29) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbf4b2b-4918-4f6e-a632-08dddb9fa9c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXUxaFdjc1VJZFdtbXZJNm9oL2FIV1ppVllveEE5bVYxL3hIcGRuQ3ZzMXZ0?=
 =?utf-8?B?aVVSQTlJd2t5MTlqaW1ickpNRVZ5TDhyUm9oNjF5VjRSTXJnQnBWYlErWExw?=
 =?utf-8?B?U0EvdkdSbUJGa1RmM3ozK3dJeDJsZUdPVEd3OWtTazV5QzBHaDJ1TXU2YTBo?=
 =?utf-8?B?M2Z6VzY5WGk4SUNaR0F0Ry95bXJ2cWswMmRVWnp2eTdKTlhkZDBDTkx0RTBl?=
 =?utf-8?B?NUNJaGUrVk5LWlo1K1pDTXAwMFlEb1JaU0tJZzNhQk9BQ0ZnTjB2SVorZTVS?=
 =?utf-8?B?aWlvTnlqR3FLK2tVQUd6MTVyUU9IWjJ2WXJOaG5zNis2ZFM3dnJGRmE0YWo4?=
 =?utf-8?B?VGR2NFhnY3JwSWgycFM3UlEvYllaTE5yd0psKzZLeEYrZy9ZcFVrOWRjamhk?=
 =?utf-8?B?MDVUdVlTbVFycUpBdVVIckhhUFV0cGg2VlkxUVUraDZmNE5vbS82N2RHWkhH?=
 =?utf-8?B?ZlhiSzJBVzlPNkhpcnJmWmttdnpPUlo2M3RsSzZZbUxPa0g5QlAvY2s3ZGRC?=
 =?utf-8?B?Y0UrYkxyVXdQMzNBd3FTL2RMcHI4cnU3RXFxSjJObTFJaWRNT2xqbGYzeEVm?=
 =?utf-8?B?bW5xbmM1S3VreDBiZFU0SVdNaVBxK2N4N3g0UUpPbENtZ2F4MXRscGx6WjNZ?=
 =?utf-8?B?NmVZaEZ1bWpCZnIvWWZiV0dxK2ZJYXdBbUpuRk0xdWY4TkRIdUhjaEpwL2Rm?=
 =?utf-8?B?S0c3VkRKcUdlWjhRUFpQVHozcXFnWVRvOFJ6TWxCamhoM0ZXbVlwOTdBQ0Zu?=
 =?utf-8?B?TDBnM0tYOE1FT1FCOTlNS3ZyL1JoemlvRmZkUWVUWDdPVktoNlBnQnNDQTNy?=
 =?utf-8?B?aWZxMy8xMldzbVEvV3kvZTdNVkVwdUJCdGEvU2UvejlFWVN3ZUNoSkNCaFJt?=
 =?utf-8?B?V1RkeFB3ZmhkVzBSMDUvRjYxYTQ1REsybmFIdzJRUHJGVU92VFpocWorUzNB?=
 =?utf-8?B?bnhheUhyZ2wwTmE2T0hTM2dOaU5leVBWditNZ0RiZWt0Q3dKMDNjNDc4MWY3?=
 =?utf-8?B?ZnF6Sm9OaWRVOUFPVXAzTHk3TXpMRDRFMHRhYm1GYXloSkhIYjZzcUVRUDU1?=
 =?utf-8?B?M3U1Q2k2RjZ1S211ZUZXMi96TXBjaHVCbGNDcVVGdWNGRXVvZTV4VHRWb0JN?=
 =?utf-8?B?aEphR0tMQTNTUVUwTHBjNWtlUWpudG9iZE90U285dkxweUVGb21LZHk4SytI?=
 =?utf-8?B?ZnEvUkx4Wjk2em9tNFZ3b3B2T1A1Ym1JdG9oS0w3dzNEZ3o4WjJic3pjVVkw?=
 =?utf-8?B?b3dEWVBsdms2SWdtdHNKNXh6QzJKekE0eWx6L0I2bTIvMUhyYnF3cDVEOVNZ?=
 =?utf-8?B?T2RoM0I1REFMcHN4b25VZUdDcXZmK2pxUTQ1d3Y1THZ2QVkxdVlndUdYdVdh?=
 =?utf-8?B?UGg1MmlPRlNYcVZEaG1hZkJDdkc5dGZGTG53c2plNXp0dkZLaFdPRm1lNWlZ?=
 =?utf-8?B?ek84ZjFwYkFvOU1ka1ZFMlRsZlFSRDMwM2VhczBtdk5wczY1R2xnTWRIeXBv?=
 =?utf-8?B?OUFZL1BnclE4QjFiOHpEWVhMVytIK1FpYU1uMHRocHBBT3owMllBdHBJaVRY?=
 =?utf-8?B?eDhyL1JQQzBJM3lnazNJUXhUdWhpK2NCQ2hFWjl3d2lKdkVWQXJlTDNERU1x?=
 =?utf-8?B?UTRpeGlmZ2tGS0JiZFIyUll0OGliQUlOVGJidDN3dFZ4R1FDYTlDR014cFdr?=
 =?utf-8?B?RUh1MXo2Mm5abjdoY3I4dzlqTWk1SU5Ha2NWejBhUHVQZms5QlFzRVh1N1dW?=
 =?utf-8?B?MTdmKy96Ujd2VWlkZjV5NHdndm9tSnMvdHBUdDRKS25QMDhBRnBtOFpsNDNt?=
 =?utf-8?B?QzVNUE5NaUprZDE1V09RK1NkckR3cUpSc3FBUnhHMWxvNG1iVGZrNGRXOXl2?=
 =?utf-8?B?SEtTUHdxRVJUN2V2S2QrUWJJcDZ4MmZCZy9zNmh4SFZxS2NVcTRxcE1uUjdi?=
 =?utf-8?Q?nX3YQW/h8Ng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZMcEpmZ3oxOFVrSDdWWkhwNjY5MTZPcUZMeWdKYWJGczN0YWZlaUdIT1JF?=
 =?utf-8?B?L2tpZEo5bUsrdWFxc21vZHpUeFRRbU4ya0NVV051RUxOdEdwSVZURHVlREFO?=
 =?utf-8?B?OVczYzg1ckhpZ1hlZVl4ZXFnTDZzbElvOWd3b3cwTEFYM0ZsUkt3K292Z01Q?=
 =?utf-8?B?TGNsWHJKRE5MOHhYUG1qb2N2SVhjM2xueFNrTEl5MG1BZFBpaWJVVjl3aDlJ?=
 =?utf-8?B?U1NiZUtHNGFlK0J0YUs4UmJaOXc2R2E3Z05ESjZIWXg1aExvYW1YZ1NpUnhQ?=
 =?utf-8?B?d0dJNG85LzVzTW52YU5RZ2lhdjBDbDlCQ2NhQkpoZ3RvMVc4TWUySmowby9H?=
 =?utf-8?B?emd5TmlkUngyOEdnMFNpd0duWHFLRnplRmNYQUN3a2VmSE4yM1g5YVVpMm4r?=
 =?utf-8?B?SFFPQ2hRUjUwYXVlTFU3aDFSZXdzaXVUckRpNEJlZUJuSEN4SnZIOTcrcy83?=
 =?utf-8?B?cmptd2Fyek5za1J1RGRiVDViZko0SU4rSDhwU1ovZWRNelhpcUg1Zk9zWmlB?=
 =?utf-8?B?cm1hWXBmL0QxSlJRNmhJVEhxT2xlOVZNTU04YW5iSGxQMGVrd0JaaHIwN3NO?=
 =?utf-8?B?RlczclJiMzNsUUpsUlQ2VzJaSDZBaFNFSXlEbGtpY2FuUXd4UzhnOElZMWlN?=
 =?utf-8?B?QTl0SEo1RHJFWGhVSWZXNzhVcjlrblpiR3hxaWFCc1czSUZKSDF2cndCMHZE?=
 =?utf-8?B?anovUkNtcUE1MTdYQTVYSnBDaFdCYTU4c3Nqcmd1Mk1SRFpNQjJ4cTUrM2NV?=
 =?utf-8?B?OXVVc0kxc1V4K204NmdzMHg2TWhPMlQ2aEp1UEVJV0c4TnhmTmxwQXRQU1BW?=
 =?utf-8?B?dG9jRnNHQXhXTUxwK1RtZGp0cmhwK0kwa1BxRzJWQ1FtR3ZLYTVONGswUmdK?=
 =?utf-8?B?bG5oaFg5NFlUMy9CV0gvNlJrdGRjNnhQd1VxN3l2Z09UR3AzRXNrYXBnVGpM?=
 =?utf-8?B?S0NKRjhEVENLSWM5RFQrNUZhdjhhNTNXSm55akVKRVovKzZacWlkRDlabHNa?=
 =?utf-8?B?R25qUUlYdlRsZWxCcXg5ZC8zSU1BbndxYmZ4czhQK0lPdjkxWUlENEJYU2Ra?=
 =?utf-8?B?ZUVEUDR6RS9YTjBiN3ZCSG1SQXVNaVFNUGNnUGJJU3pnR0JBbU1QbVM2Wk94?=
 =?utf-8?B?UjJXejR1TC9lZEFNUDRwYVRzakRobHQ5a0VDMHNyVjBqM0dDb20xTkJuN1JJ?=
 =?utf-8?B?bWRFbUNvWG1MVXNDa09HNVFRYWd3ZXNrenRPSVhuQmlDY1lEOWk4R0xGV1pq?=
 =?utf-8?B?bUxscnUvRnlTbGFxSGlmKzEweGtKOVVIdDVrZnlKV0dYU1F4SGRLTG9mY2x2?=
 =?utf-8?B?UGp3V2JIRVlZQlpKT2NmUzlyU1BFdUdobmx5Q1NvVXErT0IyS3FKOTgrNURT?=
 =?utf-8?B?ZjlwRGd2NHpoNXA2OVJ3c3RaY3h4K0VWMkF5dWtHWjAvY3N4b0tZN1Y4L3FI?=
 =?utf-8?B?MitKN2pCMkV2MkFUK2VHc1VNbS9yQjNDTUFvZU5SeUxhd2VFTVN1VklOWFdx?=
 =?utf-8?B?V0FJUHpKTTdhQXlBNDd2RWNVc0tJNFJBNStoeHhtcHpSS1FvUDdHOVo5RkJi?=
 =?utf-8?B?K1NaZlc4MmFsZlVwUTFLZXBjaThjdEVzQkdiRjB1a01XdTdVcDFqRDFhbUo1?=
 =?utf-8?B?SGVUZFhRMEVBZmZMcndsaG9CNHB1MVR2Sm92Uytkd2w3Zk42RVo2VWppVzVQ?=
 =?utf-8?B?U0I4RVRzcW9jK2hmdFJXK29LN0FLMGg4UkdvTlhUZzk3cTJWVmljYkUvOVdh?=
 =?utf-8?B?N3ZHUHNOWW5vWlVIN2Q1YUtTZUVucGtsSmNVZ0kwdm1qWnJKZFdKR1ZYS2g4?=
 =?utf-8?B?OEZOSHZxMGtmVUgyekxWeFg1SDIrRENmSEFKZlpqUE43SHVIVGx3QXVaV2hN?=
 =?utf-8?B?dEdkbG5rWkI4WDlIcUwxblBBZUhDV0Z2dVd1V0kwN1RiWDhPYStVNjg5R1dL?=
 =?utf-8?B?RzNGaVcyNi9jaWJlZlpiL3JVV3ZRRG9Pc1J3cDRMVmFId1ZHUUxZY2o5cGVB?=
 =?utf-8?B?bE1pSjc1bEM5MFMyakZXQ3U5VnI5UFVoWDNiMDQ0Y1NyR01waVdreXJOeGVX?=
 =?utf-8?B?eEplQ09XZ2d6Nlh2VXYzcnhWQkJiT0QrU1BsM0NXbWsvQUJ3Rk9nZ0lBTEhY?=
 =?utf-8?Q?mto+dMp7Qk2AFaF6FCtAqklXE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbf4b2b-4918-4f6e-a632-08dddb9fa9c6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:01:35.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUqNWlICBcA/kAL6AiYpf0MO12v0h3ln8/fvjWiDFDN02Pn0SZfnr2U/NT6U0ph6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646

On 14 Aug 2025, at 21:59, Ye Liu wrote:

> 在 2025/8/14 22:07, Johannes Weiner 写道:
>> On Thu, Aug 14, 2025 at 05:00:52PM +0800, Ye Liu wrote:
>>> From: Ye Liu <liuye@kylinos.cn>
>>>
>>> Use max() macro to simplify the calculation of maximum lowmem_reserve
>>> value in calculate_totalreserve_pages(), instead of open-coding the
>>> comparison. The functionality remains identical.
>>>
>>> Signed-off-by: Ye Liu <liuye@kylinos.cn>
>>
>> You can remove the {} from the for block as well now.
>
> I agree to delete it, but I noticed a patch has been added to the -mm
> mm-new branch by Andrew Morton[1]. What should I do now? Send v2 ?
> Or send a new patch? If this is my first time, please feel free to give me some advice.
> [1]：https://lore.kernel.org/all/20250815004917.03FD7C4CEED@smtp.kernel.org/

If you read the message carefully, you will see:

“Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.”

So feel free to send v2.


Best Regards,
Yan, Zi

