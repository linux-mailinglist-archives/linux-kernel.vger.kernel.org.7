Return-Path: <linux-kernel+bounces-750445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C21B15B63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4401D5615AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22162701AB;
	Wed, 30 Jul 2025 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPKRiOiO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8A273D96
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867329; cv=fail; b=JKSdxC+2Iu8LcfVd5DKr2OFg6thg+DgynXewG5mbz2mMGiX4rmK/l7EKc/XReaIFQq4RUwgROOmXYbA93A3RTL0W/g9tAobRaHyvfl0w61tU/dgTmsgeAIHC58wqTPQiOgqjYzCHgb4QOc3ksUXBW/soIqLjo9WabpYDI6t4gvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867329; c=relaxed/simple;
	bh=jEY87tCOSot+dW3m2MtlXrS2q7VT2U4vUINWV0CX8fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2kkqzYy9FOhwLzRBvnBj0/u5ITTYrhFTsX8zpET0gRUhGu37e26WCS9KCRByzNj9co7QfSr5Sy3zo/KbOTKtPYKQTeQ54CHR1O6E/RfdyTlCFQ0wlhDy07i3An1seLZX62yuoRRzZm9iRzKcXnBM/J/dMYrp/3fEXo80xdunBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPKRiOiO; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pXrSp0b7oOxBq1Lb+bLLfx1As9hzgkn5XqoBcLMMu3uyHp4RAKs3UR3y2tq3PI94ds0Clg9U4tO8LtEPAD8/9ECuJj7YSq3wstpT9YsN/KWENgdj7Irlq1Zz8uWbv5O3bnQ2hP9D0mSioLM7Hv1AqKucmONbOpyx7qt+ja05qkYtwfpWAyl5Xh0Lc/Pwogbd9ZMPprFQlGoKkwaPfsCJh3Gshjwd0jWKmnf+2MfiOUszIpfRdmtFq6iPS8FWpHXFmabC5qAtKOr0vmqtz3IGllkyKlWJ/zcjZcd4BKYlne3ZOJNnwIN21MTsmvgfU7W27fCNd4F1syPLtuHw24itOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WukgZ7ecUPoMqaBYd0oZ5Rm1/mV/0Ja/pqB4Fscaf8=;
 b=OXSX07N/8JdoTWl8mW/8o2PdRWUufUrmQdNxge6wnn9NfhreZL5qm1smQmtzycI9eIng79+vn7R8Fx91y3tDCgHkQNF8TGzLv0k9rCfQrMU2IE0b3aOC7vy8Og2HaMLy9N09iYdsQGdRZjsmZYbQRk0iEUIFho03se9r9XVOK1DfKYUOcvDRLNZqrUDEsBvsx4ETfEYkSnFfZz+pJz8V50T792hZawPSZearp84z7FTYF36kYD6xCgCR7NyDj8rT+dHyM9MGG0Mh4kEE5Ug11e7qL3qmpo9zzgzRAIEtTdZJFJpcAJjjfssZ7TeGaXvzZYCghZz6m3XYQ6NKI4gs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WukgZ7ecUPoMqaBYd0oZ5Rm1/mV/0Ja/pqB4Fscaf8=;
 b=aPKRiOiOC94sOxYHS+G/RqdgqchdNWNl/nvY56MvcmMdcsQnnrMccHpCO8DM4gckxYuUjstDSGpttEw4b3SkRkxVIhkm2tMHtXZNOS3Vu4Vwd+uFc/nSFKSSce5Yh01mmb0psOuVJfyz7Gf0YSwapZxcNHOWiyrc3rTtYcNcDjOMUNGAVHFDcozFfJ5/odU8mcOM0ewNIgia6kv6MMdEWZUoCpibFHmVHKkVfzVnxoidiqeteQDwvbbn5zbnwXdUkyfSo2AMfpEpGg+2bqevDHSlmmVuWIk4Sz9bSlB83eUICshHHgqtapLEu4/DxEuy5Xvlh/5GNb8kifbtrU7j/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 09:22:03 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8964.025; Wed, 30 Jul 2025
 09:22:03 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Xu <peterx@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Jane Chu <jane.chu@oracle.com>,
	Alistair Popple <apopple@nvidia.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	=?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Francois Dugast <francois.dugast@intel.com>
Subject: [v2 04/11] mm/memory/fault: add support for zone device THP fault handling
Date: Wed, 30 Jul 2025 19:21:32 +1000
Message-ID: <20250730092139.3890844-5-balbirs@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250730092139.3890844-1-balbirs@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 8774e1a1-8924-41ce-93d9-08ddcf4a8bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmNwTklzeWlJbUZxbnhLcXVYalNPSUFpOVRQMURUOCtUTUgrUjBrMmtET0ZG?=
 =?utf-8?B?cEZEM0ZyaS9uT1c3ZkxKSHpDMm5TQmVKNktjR0ZNQzdwYUViMFppU0V6NWwx?=
 =?utf-8?B?ck0rZjdBVkd3NWJMZ2M2SkNUaFRva3ZiTFY1OXJKWGZpN1h4SzlHMC95ZXly?=
 =?utf-8?B?RDNPRFp0Z002ZHpLVEZlQzRycVVmVGs1SSs4am9jZUhKSEcrWjhSR3RMdS9s?=
 =?utf-8?B?Q2ZvdTNwTytEdWlyUGVkN09TS0YxL1lUSDFrNkxXKzlGNVFoWS9HYkNsSlo2?=
 =?utf-8?B?Y3pwN3dSYi9RZWpERmVHQ2hEajBPUVFkWnBpSnJ6dHJNcmdFVjRHQVA2T1ZB?=
 =?utf-8?B?Vk1MREpiUHRUM1FRbXlnTkY1MDlyODVFN0Uvd2JGTmREY1dGcFhpNGR0Si9k?=
 =?utf-8?B?RFRuSDh1Q2hubVZ2bVlqOVhrUTZiaWVyUmQyZHNVSnQ3YllKSm90ODg0Sm1X?=
 =?utf-8?B?QlRkWEM2T3hYYlJicXA5QjIwSHN1eWF3amd5bmMrNFNvdTQ0aHFjMy8yVmJt?=
 =?utf-8?B?ZExXTlJ1ZVEyZGdCY3VtVUZWOXUreHVPT0syMWg0LzJIRzV5YUVVT3NpMVd2?=
 =?utf-8?B?K2JReDJyL0JHRExTTk9vMmFuVXhPU0hLVzlXeG1vUlVKY0hlTVhDeFMzVjJF?=
 =?utf-8?B?OG9hMU5GOFNJMnBmQWNGL2lEa0x3S0c3aklvSnR1Qk5aSzE0VTJWVUU1VkpW?=
 =?utf-8?B?UmVkcTIrbVRpeUpVdEFDUnBxK0Y4ZlM4K1o3Y2QzeXBMU2pvT3diQk1ZcGxv?=
 =?utf-8?B?ajZDNHphUG5ObGJ5SUtlc2R3Q0E3NllPWDR6bTR4QU9INHRLUEN6bERIT0pG?=
 =?utf-8?B?VVB5aGdvRXdtaERIejFKU0JTa29pRjlBUXpRR25vR2RRdk5tOWFIaDlCUExy?=
 =?utf-8?B?Zm9GRHZXTHNtZXRmc2M2Ty9aMms4Z3Zib0E5QXB1RzlRRytqdXV0WE1lZHlh?=
 =?utf-8?B?anpEMlZseXQxZzJDZjJXUzlwL0dUVCtLNmYxY0xQV1cyVnVyYkhQREVkUUFC?=
 =?utf-8?B?T3B3b3hQNUNvS3haRGVQSHROcHk5TkpIYXdHSE1BMHp2QUxMNmJRSmRUajA3?=
 =?utf-8?B?RGZsaWkrQjdFdjc0Q05jQ2NJTHZuKzhTUmZhUE8rSDgzRmJqTmZ5TUYyN0xq?=
 =?utf-8?B?SmZzTTFDRld2cWtsRStLM2xoblAzT0VOMmNZeHNaWUM3OTBZbTlLSkdKMXFK?=
 =?utf-8?B?UXd4TCtrL21zT0NMblJGQ1d6NlpXU3U0YU5mSW1aZzJNK0FjVWo3SmNKbUxE?=
 =?utf-8?B?a2hjUUMzWmhVMC83bi9tS3J5c3lBdHV3MjJ3Q0NxWjM2QmdHUlFGcWw2VStO?=
 =?utf-8?B?YzdkV1RZZVhQSWJJUzcxcXhhMGhLNGJ3UzQ2bDlReCtFUktlalh5dWo1Zml1?=
 =?utf-8?B?bTk3d3hvMlV1VkVTMXd3RjhFZEo5SjBFTEp0bkEyVVZxdzFiS2FTSkE0Unp0?=
 =?utf-8?B?VC9QTVhZcmNlYjVWTzQ5QVZuY2lTNTAxZ3ZuZFdtY0w4YXkrNEJyK2FiNElR?=
 =?utf-8?B?UU9LWmRsR09zNGNhbmdPMTVqanArRU9OcE0yL1NPa282VWtCR2JEWXN6aVJT?=
 =?utf-8?B?MGRCZnE5Um4ycUhtY1NKKzVBeWJvTW9MWTZuNGFyaTRWSkVWTTFKR2paMnRz?=
 =?utf-8?B?RjJvZUxSRGpUWU03T2hhSW1XdEEzcGZFWndJVjlFWG1zRjkvVFJqWHRHNzBW?=
 =?utf-8?B?Si9GV3NZbWZhNU5iU3hXNDdmTHk5MjdxbFBKMTd3azNWTEJ6THUyRlBmaUhr?=
 =?utf-8?B?U1k2Sm5oN3hFMWE5Rm8rcG1odTU4Y2o5a2JTSWFBWlJrbWdyTk5RTmpXQTVO?=
 =?utf-8?B?aGtibkNxa0hyM1c4b3laYXFYeUVyY1pUMmlGWjdzMGtJMTMzb3c5N1hXTjdD?=
 =?utf-8?B?N2hieTVENzlUTVRJdHlJSVlsdDFsOW90bk9VREFtc3g1VjQ2cGpsODhIQjdw?=
 =?utf-8?Q?rfYJg44xotw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmhQa1NwaU5SZWZhMEd5bWlNZ2J3ZDlpZ1RObkU1QXZTLzJzQ3hISFM1a0oz?=
 =?utf-8?B?Y1JFOEU2ME9uUDc1VU1qQndTd3FtaEZDakxrWXI3SjZEV1NzVnM3Nm9YSU5w?=
 =?utf-8?B?QTA4U3BxUUROUlJ2a0N5YjIzZnYrYmVxVEZLNXF2YTczczlBWEswb2ZrSTN5?=
 =?utf-8?B?WFVjREZmSmVHSVVzb29yREpuL1BtVXhPOUFMUFpTNG81QlJoU1U0OW1FbDNz?=
 =?utf-8?B?WHg1c3hqb1hBYVNWWHlXWXBMd3VvWmM5azhOZ2M1N1JyM0VjT3h0UzNpOGht?=
 =?utf-8?B?bm5hWXU5enRqQ25waitHUFgxVUp2KzIyOGVOL0V1MFpKTUl3Zm9kUElnUjND?=
 =?utf-8?B?Z1plZEtmR2hlQzlSMjE2czh1a0l1T0kvRzJacVZPYUZGcW9ZNGNJUkpaY25x?=
 =?utf-8?B?UWtnUS94cHJqejIybnNVaUtDQ2h5ZFZjdE1EcWp3MlNtYWJRT09RbHliTlJV?=
 =?utf-8?B?YUVVcTFXWXpEQ3ZVdlIzdEVMdm5aRE1NRnJDZnh2bGt1Y1NveGZQbHQ2VFQv?=
 =?utf-8?B?RTZya0QvOTFmUG0xSFloWTQxZW5tUTh2Q3RwOW9xL2o3b1l2UUxDQWU4TDZo?=
 =?utf-8?B?Z21yTW4xMnBaU0p3dVIxQnU3NWZYckJ6VEExTTBrSm1CRVBGNk4wc3BydzMz?=
 =?utf-8?B?Nm55WjdQTU8zK01DMkg5eHg4YXVhUzNZT1BteExjOG5TNWw2VkxweUhNTGZa?=
 =?utf-8?B?aGVtWTFDMHg4aHlnYndYYUgzaUVXK25aaWJOeUtnRVdTaTVjaTJiK1JVeGFy?=
 =?utf-8?B?SDBTbGZZRUNXVWFYRFlHQjJjRTd0MFRlT0FSUUYySlhTd3d6QUQzTFdRbXFy?=
 =?utf-8?B?N2tGcW5xVDV2NlFKU0lFUFJ5NS85UmNWOGtGdDc0c09YbmJueEVHT1NTd3Ri?=
 =?utf-8?B?U09sM1NnTk1CNU53TnNXWkdGQThCenliYU5wSlFmalc5NEJYalhBT1ZPNmhP?=
 =?utf-8?B?cEV5VFJ3UElFRWhjR2lGbWI1WXRjZ1FFcElaSDVDSEQ0Ukk0UjI3Tms5cXNO?=
 =?utf-8?B?YUZpM3JaVDR4djhoQzhJMlVFNklSTW91TXBYVm1JcTZzcFJUbXhwT0tRamJh?=
 =?utf-8?B?MFhUYjZ2VmpSNmh3Qm52aUFUU1o0aGpackw3eVFxd3dpdkVJM3lpMWwrMXFV?=
 =?utf-8?B?YWJyTzFyTklaNnV3NlFVdnJ6QjUwRVoxZVJIVWE5cUVrNSt1Wm82ZllEZm9B?=
 =?utf-8?B?TFJWcTJvaFV1MzhMUFUxMjhHSXIyak5PSi9tY3dob1hNQkg5TEdFbEcyRnFC?=
 =?utf-8?B?NDAvVU90Zk1xVjVicHJGNTgwNkNOdmI0bWJEaUhobXVhR1pOQ0x5Q2hvaGh4?=
 =?utf-8?B?dlI3bjdYdGVORWFVZ0tqYzQraHN1T1VsaG94eHl6bU5MbE9ydHE2MTN6V2hW?=
 =?utf-8?B?N3lhQWp0N1FVV2s3WGp5cVkrMGo2NzE1OG81TE9hN2tCZGoyN042MVZuem1G?=
 =?utf-8?B?L0NXc3BWMlc3MVRuVENlMFRQMk9PNVlqY3JNTGh4ZTEzTW53OWxvNmptQkdP?=
 =?utf-8?B?bkxVUGNISEkyb3hMMXk0UmtFcXZySkRrRURWdnlpKzB1T1pWQmcyNndNTmoy?=
 =?utf-8?B?SnlBZ21LRnZFcXVQcGZDbWhBbWRheU82TU5QN0MzUVpNbGhLZ3VvMUpKeXZQ?=
 =?utf-8?B?a3gyU3FKSkFtYkRDR0NlZjdXUStTOEN1UCtqdnFqSVdnTytVdGVaWkttaCs3?=
 =?utf-8?B?bDhpRWVIdWY4Zk1Jb0RoaWRJY3U1ZXlXN0lndFdSZUdCTnBnMUhncGU5VExK?=
 =?utf-8?B?ekw5QzdwVHd2Rk4reXM0VTI1RmhZeUtGaktmQ2RWWU4xeE40UE5WNlVoZDVM?=
 =?utf-8?B?MnlkSVhsMFNXalF4RG56czU0TXUxTDJzdVVua1ZuQi9KVXZxWm5OVDUvWnE3?=
 =?utf-8?B?b0ViQmxlNlNMOFZHeWIxeE05MlRuOUxScWxNenRKMzJaMk96aERsR0xOOEdu?=
 =?utf-8?B?Rkl3U09tMzZpOWk3NDg5UXBMRmY2ZDlEZEZneDc0Vk83UWxUa2VzR3ExNUFP?=
 =?utf-8?B?TUU0N2d6a0lpTGQ5NHJTT0hEaXYrMXRNaE82blFJSkFvbjdIV1lUWk5pazlh?=
 =?utf-8?B?VjB5bGdzVE5KczRwdnkrdnovZ2lBd3BHVi9hanBoYmVvd2ZTZ1JqTldrcDNP?=
 =?utf-8?Q?wOaAXx3ZsOrJ0hkDYk9/9t48K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8774e1a1-8924-41ce-93d9-08ddcf4a8bab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 09:22:03.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImF69gI6AlAcjhJxQAYLfCP49fRSOlBfRGRUL1Q+d+MRIeWwToQrRpz3HU7U6wkkVnbR09AnOZd4U4xLbLyAiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

When the CPU touches a zone device THP entry, the data needs to
be migrated back to the CPU, call migrate_to_ram() on these pages
via do_huge_pmd_device_private() fault handling helper.

Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Francois Dugast <francois.dugast@intel.com>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
 include/linux/huge_mm.h |  7 +++++++
 mm/huge_memory.c        | 36 ++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  6 ++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2a6f5ff7bca3..56fdcaf7604b 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -475,6 +475,8 @@ static inline bool folio_test_pmd_mappable(struct folio *folio)
 
 vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf);
 
+vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf);
+
 extern struct folio *huge_zero_folio;
 extern unsigned long huge_zero_pfn;
 
@@ -633,6 +635,11 @@ static inline vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	return 0;
 }
 
+static inline vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
+{
+	return 0;
+}
+
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
 	return false;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e373c6578894..713dd433d352 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1271,6 +1271,42 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 
 }
 
+vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = 0;
+	spinlock_t *ptl;
+	swp_entry_t swp_entry;
+	struct page *page;
+
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
+		vma_end_read(vma);
+		return VM_FAULT_RETRY;
+	}
+
+	ptl = pmd_lock(vma->vm_mm, vmf->pmd);
+	if (unlikely(!pmd_same(*vmf->pmd, vmf->orig_pmd))) {
+		spin_unlock(ptl);
+		return 0;
+	}
+
+	swp_entry = pmd_to_swp_entry(vmf->orig_pmd);
+	page = pfn_swap_entry_to_page(swp_entry);
+	vmf->page = page;
+	vmf->pte = NULL;
+	if (trylock_page(vmf->page)) {
+		get_page(page);
+		spin_unlock(ptl);
+		ret = page_pgmap(page)->ops->migrate_to_ram(vmf);
+		unlock_page(vmf->page);
+		put_page(page);
+	} else {
+		spin_unlock(ptl);
+	}
+
+	return ret;
+}
+
 /*
  * always: directly stall for all thp allocations
  * defer: wake kswapd and fail if not immediately available
diff --git a/mm/memory.c b/mm/memory.c
index 92fd18a5d8d1..6c87f043eea1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6152,8 +6152,10 @@ static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		vmf.orig_pmd = pmdp_get_lockless(vmf.pmd);
 
 		if (unlikely(is_swap_pmd(vmf.orig_pmd))) {
-			VM_BUG_ON(thp_migration_supported() &&
-					  !is_pmd_migration_entry(vmf.orig_pmd));
+			if (is_device_private_entry(
+					pmd_to_swp_entry(vmf.orig_pmd)))
+				return do_huge_pmd_device_private(&vmf);
+
 			if (is_pmd_migration_entry(vmf.orig_pmd))
 				pmd_migration_entry_wait(mm, vmf.pmd);
 			return 0;
-- 
2.50.1


