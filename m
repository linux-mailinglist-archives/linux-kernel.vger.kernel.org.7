Return-Path: <linux-kernel+bounces-721052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F5AFC419
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C17B4A3183
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93314298CBE;
	Tue,  8 Jul 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bw2dQBl7"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17853221283
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959922; cv=fail; b=j1O5+1XY9K5QNf4DX6hwNKlEY1KavJiMhgxS2H//9tmQu/3zLj4rqR1OliEiGy1WDNYDsAe0EPWx4p/hR21NxTSzxrzo6V4fiXmNqDiA/WLC1ftvABPX+O8qYO8no/w6lVmMKSx4RxWiNztgRf9b2sa7TDevEeMcfVlfbmczPBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959922; c=relaxed/simple;
	bh=LGjV5041neukL65a3tr093wmGAjTkIiyVtMQGYOa0iU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zh+v3vcZYISHA8621NV9C5tD//2+FAFir1fAuKQZb4wF+VMUVIQcZTh+BalwGYjpbhPmNmDFfc3w0UN2n7RcI23s31VzbQ79Q6X4ShXLDTahoHz7Itz+bTtBkXgyGxLgapLQ6/QiiKOLKILwlUpIJCbDMLKddIjcfFZ4T01EkeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bw2dQBl7; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK5zasbv3I1sUciJAJcoW6Bj70OGSfc/SMDkiLAk1VyFQMhynS1h/7KiJiJrijjE8wNokdktOLyl87cRZQvA/I0OKPrGiW2c0VXovAr7lb6JG5MnLaI2y0AvBn0NzdFSUoptBaYp2M6FhXaacZF24BWwHi6WFGmWu76X1zeEOghPTIn+fkJ4apZxLW22/3dfBOcaXaKsgc5sQMZ7dxvobfPlC0q+DH8BgAkkQ4+LTjIGsAS3zLa1M7YvkB0TZ81D4ngevyJAvirXItR4gyxuw55ykQQBAZv/u0OyYQSiA9p4zZpi6RbaoGUDcd8k6f3ZHhm8/Pdp8RUjQwI9wcOboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoegpaYz+WXoZkfOhNVOgp9DoRc7GuK8LH60J0knFbc=;
 b=wk9CQvNgy5lH6L5x01E3hXeSi/GsTcfHeaJ4jftFFP+qmQSy2ry0kIyzxERdrHfTkGx64RwLQv0m5LHMyj8B1/WOSm5kZDDTI+LVAh6yBfn7yBP1wvlUKnS2/eRAIe74Cp0CID9+w4qOojCcfMf7KTeUNmAGBDvI9ZYA7EGsKU530163VpGF/Zlq0MdDx10qR5Fnl+EpbCm6IjoASqVo8tI6hCOKB9mfYX5MWux/7Ol8uusPO2p6BjlgTVZbFCWBkV0R7lr8hIAbR3d+xOor3PzJ9T9faoV1ENbyEvaH0oIrnejqOFjUHwa1YOjPu9eSNPidKREo/Ii1V+gpWXTmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoegpaYz+WXoZkfOhNVOgp9DoRc7GuK8LH60J0knFbc=;
 b=Bw2dQBl7ZbKNnaeODFiSdgcjmJfP5n/vavumzcmL6r89jKucX/W3NvyNcAjdQmVUlccvuuQGsjqI9i1fR1og2mGhDoDdM7paTz0SoLVYvaCcYVdpUswmETejWE+4NAkezLiOOrvvlaxfmSuyB+F4hYNoe6uKEh3qLfw32UOWsmAAUUor5tq4s2zfi9xsdp2/lpCK/1kjzvqWpUFKolB7W3e/C7oCnP4PF9RCdRIyfjcnFBjIHMuZW++1ThBA4MwQhqNIu3NrQ/zSBPcIzsvRY8VhGhT49QLd5FCFekl4ZTuQQ1IaeDEN58Dk/K7Av45EL5pLct6u/HLEXkzLLbrbtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 07:31:55 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 07:31:55 +0000
Message-ID: <6eba6c3e-a579-44ca-af59-b8adc7dfffe1@nvidia.com>
Date: Tue, 8 Jul 2025 17:31:49 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 resend 02/12] mm/migrate_device: flags for selecting device
 private THP pages
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jane Chu <jane.chu@oracle.com>,
 Donet Tom <donettom@linux.ibm.com>
References: <20250703233511.2028395-1-balbirs@nvidia.com>
 <20250703233511.2028395-3-balbirs@nvidia.com>
 <ln75hcgtiuutmlbamc4yd2sbwcada35daz5zufrrz3ad5ids3x@vtq2kntpg74s>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <ln75hcgtiuutmlbamc4yd2sbwcada35daz5zufrrz3ad5ids3x@vtq2kntpg74s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0025.namprd05.prod.outlook.com
 (2603:10b6:a03:254::30) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf3c77c-e178-40de-7f58-08ddbdf183d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0dzS2s0Unp4L25pV0p6UEp4YXRMNzhKWHFDVEdybnBkWDJPVlg4c1o3UEhB?=
 =?utf-8?B?dUhnZWNWYUkyOGJMOG0rMGViU25GMngvN2QxT1dJZ2F4Zk9lTHZGRkZEVTRu?=
 =?utf-8?B?bG1zZ21SNGVaZGVYajdMbDVQMy83U2VPQWN5VDhBbmx5UXhmQXRkaGNQSDlF?=
 =?utf-8?B?bjFiR1ovWW1hcDVzTndZWlMybDVnTjhYNXRMWEJWTW56NUplK1M1N2VIMmdE?=
 =?utf-8?B?Zkd3VGoyOElqQXBUYXVEZ1AvNmxhUEVXMGRHRS9qTjBFNmtTZkM2cE53Z2kx?=
 =?utf-8?B?STJ2MStWd2JCb0FTeU1VcHZ6MElFc28xcjMvNGNzTlNjMTdMUnRlWTJDSHd2?=
 =?utf-8?B?dnM4aWNjdi9GbGpJMFBiSTRtSXUwNzl1RkRWZE5vV3VsMVd1NjJENTluUHVo?=
 =?utf-8?B?UzZTOUFuT3FQc3BjSDJmcUdBNkJYOXJ3a2JGeENUSHRPQjVoelo0bksrcExi?=
 =?utf-8?B?WVlOOGd6anZsWE4rZ0x6TmdFc29jQjdSeUFTVWRPcFRlRGxvUkFVbXJTcWZK?=
 =?utf-8?B?dFBXRlEraTBlSXVsVzRSbVpMa3FpVWczdmJOaXBjSXpkWmoxNitoS3MyVkxO?=
 =?utf-8?B?L1p5TjBhZEtqOW1uaWhGN2RsTlV2TTFjVlJ6RWVORFBjTkpLVlpqSFRXWXFI?=
 =?utf-8?B?ekxNa0pFM2dabjE4NXNwVUY2Q0VrWXJjOTEyaXZGMzNpZXF3QU43NnVQZkVH?=
 =?utf-8?B?enQ4TnBwaCt2eEhibUt2d3VmcStaMnJTOVZnMGk1THZjMUVWWTJhckZpSjd3?=
 =?utf-8?B?U0t1Z3htZ3ZZQzRRQ09CNHlJWmZuZEZGUWRpTkg4ZDByaklOUDJDYllxOXJI?=
 =?utf-8?B?c2I3ckwrVkpwbVlJTXZRRGlKdEhSS25vMG11VEp5Y2ZyemJycE1NWGUrNVJx?=
 =?utf-8?B?ekhXbWx0RjgzMHNrUTN1cHFHQVVlOWhnNW5YMjJCT3VoVnY1Y0ZZNlJIamdt?=
 =?utf-8?B?N2t4eG5pQVJGanFKL0laUEVENjVJVkgvZ0hCOEdqNDBXUnowUEIrdE9qU2N6?=
 =?utf-8?B?UExXaGdQblZWbjh0czNYWUl4U0c2WFU4Mlk1RCs5RnlQV0xYZGI3N2lJY05P?=
 =?utf-8?B?ekc0RTZSem96MmF2b08rNGRJaUo1dm9OSDJGViszWVp3TzhDRFFNK3BuWEt1?=
 =?utf-8?B?am5XdStQQ04zZm9hUWhFcFRTR2V6Q2Ivd01oZ3k4V1BkeWFNZ3ZadzQrUkdn?=
 =?utf-8?B?dlE0V0RPaDNFQktUNm5qTlJXajZCbXJFaDNkVnhsZWlVT2ZkcXlZQXRnc2xs?=
 =?utf-8?B?T2EvRnJXTDBlRXlnM1lXLzFZRlpxSWhwUlBlaGdhdHljSmdNOFJqRHo1VUtX?=
 =?utf-8?B?QTVHOU41ZUlQTWZpWUtDY05RY1hFZFlzUWRJOTZlcE9yRS9IeFpaTmVjdVEy?=
 =?utf-8?B?dGxMVWkwWk5zd2lINHl5L29XdlpzOHhZTkJ3b3ZXQVV4Q3lFNzh6TmRHRzlu?=
 =?utf-8?B?YS91YVVKeGhIOGk4bm1QcHc4TzRXZ0ZkOTlvL0pEV1ZDRmVQODEveThlKy9k?=
 =?utf-8?B?RWFrTXVGTFhNQ25TNmxidTIyRGhkL0ZReHNXWEFhODBuNE9ydS94NkFzUURo?=
 =?utf-8?B?WjBGd1UyMmVFTnlISHVnOXJFME9oaHFHVmpMSXU0RER1ZVFWZnYwUUpIcVRw?=
 =?utf-8?B?RVNjSndETnd5ZjB4QVN4dWNaQi9laGlGb28rMnNnZDFTV0ErbTJQYUVoNmJh?=
 =?utf-8?B?WDR3bHZIaGttenVlWE5Eb3FhSWVMelRlNVlMRDNjRDRRNzUyWWtkNUJMbDJW?=
 =?utf-8?B?Smt2ZnN4aWk5eXIyeTBnT1ByWXFYbWtkaWxxS253ekVPVkI4b0lWS0E5R0po?=
 =?utf-8?B?dGVNeXJSNVRqZmFkdnNNZ01tMHZhZlFHVUdHYm9xZkRhcEwrVHFoYjRwZmtO?=
 =?utf-8?B?TzNlZ1MvV3ViMGU1ZzNldUFGUno1Q0wrZEFqaUZVdEtMVUdoUHBCemlwMFZV?=
 =?utf-8?Q?1BD4ik049ms=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXRQcWVpN040M1dHeFZOZTE5ZUFXYmdUdnhmTHpFa080U1o3NW11bFVrYWVx?=
 =?utf-8?B?NmlwV3B0T1lGclJjN056dTFFeHhVYmR2VnhGUDg4alBMQ3JqUnUrV2FuUzVS?=
 =?utf-8?B?cVpyeEJpUHJnNmliMjI3YitBOXFybEN0ZGQ0bm50NjM2TG1vQkkvbnI1bDcx?=
 =?utf-8?B?Qy9YbEtndk1icU55eFB3VFZuWWYzS09yNG1DaThYNFRGeWRMQWlpUDNSVGJS?=
 =?utf-8?B?QVZKTWpNYTVIMndWTU9GaDFRR2U5MlZSa3BEWEdIVmZIdjc0aTdsNDZBWFFw?=
 =?utf-8?B?bjB5N1dzS3BBcWxGa0U1V0JBMGdJWjFxYXBMdmdSeVByaktPRVJxZmFLMDdI?=
 =?utf-8?B?RVRPT0ozSnFabWRqRUVheWY4S05Ocml4RlJKMnlCYmlrVUdxUGNHTmVTbE1N?=
 =?utf-8?B?SFpUeWV1MHJseVBZT2pUczJRaG40bW1mK2dJWDdmdHZ2TDh3RzRJSWZSSnVB?=
 =?utf-8?B?V3JRSHRDMmVqM1h5K24zalhxbzc1L0hPcWJOZzRxaTVlNTFIbkF1SDMwSE9S?=
 =?utf-8?B?Mm5YaWFrRmRDa0ZHV3RpbGZ6TUZNcktsM2liWnFlcWJheWI0em5FZUJlVXZN?=
 =?utf-8?B?dEVxMkVEQjFMUlc3OWh3Z2lrdGt5b2ZyY3Z1UnBHSzJ0c2paSW1XRWN2S3R1?=
 =?utf-8?B?M3ByTlBtbmUwd0NrRVZoVXVYbmFxOE1HbExFSEU2aVpqSlNRMGhVRXpxVkYw?=
 =?utf-8?B?RmNmQjJhWlp1RUNlUzhxWFFKdjNoODFmOWpIbEh2R2RLY1lyRkszNGdMOGlo?=
 =?utf-8?B?Wm1WdEhUWHIvaFVEbE10ekFEQk84eG81c0V0cnphOWpNbDdaQjBJa3dJQnNJ?=
 =?utf-8?B?SzM3MDN3SXE1MGVFQ3lna1c0UWtOTHNyNjhLdUpPcUFZRXorM2VEMjdUZ0lJ?=
 =?utf-8?B?RnNuS0pqNnJFOTFkYlRlUkFjd2l0SFdBdnl4ekk3OThxbG9vekV0NVlIVXkw?=
 =?utf-8?B?SW9JbkpHcW1yc2FjK2l0OHpOL0xhZTQ5YWgwa0plVG10ZGZORVhDTWpYUHNF?=
 =?utf-8?B?WW4zNys5ZGlnNGcyZ1R4b2w1RC9YWmU5Rm1WbmxMbFgwNUpJWDVRNHFkNWw4?=
 =?utf-8?B?K0haZ3VKdVBDZDdqNlpSaktCNmI3ckpEOVZ2cGVqbFQvUXdRM0l1aDRtZjdX?=
 =?utf-8?B?ZTNWTnllVUo1djFMdmdoeFdzUVFXRHlKZ1J1U0ZXdmRqUFlkdGM5blZmUTds?=
 =?utf-8?B?bFpLTEE1ZkE5ejRkaEhNczVuNzRPYzlWOWQyRlpLK1E2Mk5MWmJ3bzM4OUxv?=
 =?utf-8?B?eXBTRDBXUWJWMEY1dnlKYWZmK0p1ZkU5b0NYai9oNHczWUhucWNOY0paYnI5?=
 =?utf-8?B?TGJsdWpOMzJNYVVXa1h5U2t1WlNOSlp5ZmxUWDdUVVh1OXBwU0xsRElKa29L?=
 =?utf-8?B?RGorSjRvWXhjTVMrSGREaEwvNGN4SWQ0N1RMWmpJQ0FHYlQ4eHpkazBrVmNN?=
 =?utf-8?B?ZjFPUVAwR2JSK1cvWXpEVjAxRjRMclY2M3hOMnp6ZkE5Y2dIbWtoNy85MDdT?=
 =?utf-8?B?aUkrbU9uRmlnRkJSYjNBUnFkTmVBWEkrcnpUSW4wcXorNWdCUWpTcGN1ay9J?=
 =?utf-8?B?NVVRU3lxUE5MNng0akRPTGV3cFZVUjJSQ0JuUkZseEQvNVdLTUVCb2g0ZmhK?=
 =?utf-8?B?SDF2YWh1STQ5d1A4MlZ3NWR5S1pVanIxQjFMakxZaC8yN2JneDFLK2U5SlZJ?=
 =?utf-8?B?QXBZdnZYOElySjdEaThRa0l0RS9FZGxpdlRvYmhyUGFKb3FQMlA3bysyY0pU?=
 =?utf-8?B?U25XbW95eU9mZktXTUlBNzhNTnMyTEpQZlJlSEozaUdWN2tmM2hGUnhSTHU3?=
 =?utf-8?B?QzFSU2JqTFlmY2pINVUvZXEwRVhWcDkzTEM2aytXQStiVDZXaVhQY2JZRDJm?=
 =?utf-8?B?bE0rWUNCTmZTYzdTdVA1NUVBOUU2NFpIOXlMSUVFczhBdTMxTHR5Z2FXamlJ?=
 =?utf-8?B?TWVEa201Ny9xMzFnUXFMUzB3dEh4WjNuUit4RURmYVBtNnBYN2dqNWEvSnFU?=
 =?utf-8?B?bm5OZ3hCUHhXYUl3MlFpVmpoOG1uK3BOVFNpc3RBUHd5R3BZYUcwdmxGWFhW?=
 =?utf-8?B?RlFaY2tVZ2NKcnI2VmR2RE16bTVPSkI1MDlNMll1YmtRbzhIR3FGaXpxYm9a?=
 =?utf-8?Q?S/EnuxgWBTHCKtQ0zUxCFCH8B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf3c77c-e178-40de-7f58-08ddbdf183d3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:31:55.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIzB2Om5VCgoGgXgbKtdY3HT59ZM39YUc3wYOg6lvUGQ6b5U1c88hZzXrlp7KpKo1FyLn6RItGJD5jwH1tpRuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451

On 7/7/25 15:31, Alistair Popple wrote:
> On Fri, Jul 04, 2025 at 09:35:01AM +1000, Balbir Singh wrote:
>> Add flags to mark zone device migration pages.
>>
>> MIGRATE_VMA_SELECT_COMPOUND will be used to select THP pages during
>> migrate_vma_setup() and MIGRATE_PFN_COMPOUND will make migrating
>> device pages as compound pages during device pfn migration.
>>
>> Cc: Karol Herbst <kherbst@redhat.com>
>> Cc: Lyude Paul <lyude@redhat.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Cc: Jane Chu <jane.chu@oracle.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Donet Tom <donettom@linux.ibm.com>
>>
>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>> ---
>>  include/linux/migrate.h | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
>> index aaa2114498d6..1661e2d5479a 100644
>> --- a/include/linux/migrate.h
>> +++ b/include/linux/migrate.h
>> @@ -167,6 +167,7 @@ static inline int migrate_misplaced_folio(struct folio *folio, int node)
>>  #define MIGRATE_PFN_VALID	(1UL << 0)
>>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>>  #define MIGRATE_PFN_WRITE	(1UL << 3)
>> +#define MIGRATE_PFN_COMPOUND	(1UL << 4)
> 
> Why is this necessary? Couldn't migrate_vma just use folio_order() to figure out
> if it's a compound page or not?
> 

I can definitely explore that angle. As we move towards mTHP, we'll need additional bits for the various order sizes as well.

Balbir Singh

