Return-Path: <linux-kernel+bounces-817280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33326B58029
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E14189F65D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F20F338F29;
	Mon, 15 Sep 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kau2eHQl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kau2eHQl"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D43327A1C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948936; cv=fail; b=JVhbBfuZZrs7nDBerqCFsM8YGwGvsBUJOfzKwmkVEyQ+Fxuq4sbzWeZIb2lhEERlAZB308lJIKM18TAdF7K2XyWoreEHm+esmGEJiApsm99t37tgmCKzNJ6etbJBwHU2VvrxzIKSzd1TnWp4R4dffcERA/ccIBWVfYtYQn13Yv4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948936; c=relaxed/simple;
	bh=o7HXyrL5rJclx9piqgrQ4L+sUoNXl8nMhhjIpam+jus=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IXDFVjKAvDclIu6Q6aRcOpcJwaxqR7WRZidIGi5k7grbnXqa4sR1vzE1Ppbr9ajWMmdIphGSZ2jtXN5YotAUGRql9gKC4edABwGDplIF82bfAF21VMgR523iOvT96XRlsht+ii6rnuBUclAjcFw2LQdrF3z7ijcRQ6dPvBH0XiU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kau2eHQl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kau2eHQl; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=bf/JopkQKkJXtaBj9sb8Ig0/t2W5ndqKvP8kKOxU1EZC66/NmolrRl9HJEJEwxq0OPkAx8R/GDM5rb9T7S4NTeeP7SGlmjXbWCmd+el+9jn4BEJb2V58z7ehGVciDSAYBascYQmt36ewCGKrfzrjhzTRqVi+h1FHBDb1mKef8ZIgmb4YDrfZHxOCvyTdwimd6DXKmuUT4998mc9dZnweoz8ghOGpa51NDpkb1fbDzhWrro4LA7gV1ShQ5V+EizCHLm0iwSgzQ0fS4NLyvnYFPdCfTkNYwwm8WFkJ4ydWITwxONsbz2R3SsfoaNS+RgC/JJm/SG1kO+PQaeGHSnk2gw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1fJQcJm5SkuVjXnUbm1adc1AkUDi6OgG+Tf5BqqrU=;
 b=lwD0uAO8gYn0whgb+FNGeZpKu55kaZTWdv5Q7xJXgpyUlhFClV5shWzyoJC2mezWZ0T9WM096CXQ8HWctIYaTwNYUnbteAQpWaNfo5GmbZWiAY4Cooo365TGAAtL3Z5vgo0vpNWHJxWh5Tj3D/o2fhrJLbWH5+31ZSf/mpsn7UGfsKSwsZjslMCd5CP5W+L1cf/l2SYK2l1inWfC86CZ8Fk3UE+U/T87A9EQcfKmWNZuhvv2aQhwQzRokiKwkMjpHjDXY41U3/y8cfwzUQeIBazsL161gbqSRnuZJ00AYlledHtn/WO/McpE1oWyO98SELQDfb5VxWedEAGPi4biMg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=shutemov.name smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1fJQcJm5SkuVjXnUbm1adc1AkUDi6OgG+Tf5BqqrU=;
 b=kau2eHQlOuVls6lnmgjsTsDa9mYzrEAOg+HI2QgTwkZuyaQqGzvo/znpWDBNzVQVomUGiO3ISC468bVHGYiVr0dyTlOz0cx2ah9+trhSau1mnQQNnqMyH8lOyeL3MO6no1pB5bnIQuS3zYY/ls9tYA8WC7gmdYv2zMwVZyMwqcQ=
Received: from AS4P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::15)
 by AS4PR08MB7949.eurprd08.prod.outlook.com (2603:10a6:20b:575::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 15:08:46 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::65) by AS4P191CA0005.outlook.office365.com
 (2603:10a6:20b:5d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 15:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Mon, 15 Sep 2025 15:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGtxZ1tusnYOSSEy79JjsZoMoMk71O6jyCcokFLrtyZR8fL+RnKhB6hFTW8UChX97O6AA2zKqiZg87r6GMSRDemrU8tujdAChmih/dDP3w7UMuOvuXls0GMaIyIG1E85p235ekDOycIEFv6Ao0lqB+jZCyypCPp6oYQnrhM47AwTWe2Icghgo2/2jWIn6cdm4eP6aojfqg39FeYNIsIILVgP7wGFQbtroDrTI+wJKavfrrlTFEzVPZDtkK//s1Rlzm1F02+wljnSn80JwdKszVm1h9RCzQ6PEfMR3AHGUm7g3dTRlZPwm2ELvXMGwi8sVQWFc6zbmG77VagXavyDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU1fJQcJm5SkuVjXnUbm1adc1AkUDi6OgG+Tf5BqqrU=;
 b=Kwf6ELdqyttYh37Ou0jQeUmBKwfCJjnpmvJ2+pLtZRE4/puP45M39DXWsjp8BwltA64ceL9VE5XNA8KbwvY3HaklLZBsXlzBBwLLd1yd477QRvvB7pdyEgYEUsGaepoae9zb36oSw4Ks5Bm9Ox8ncNqxDMOPrz09V43NXzmmKgJwKFGUuqtWYnuJrCXVnTp+QcE/dBjqXd5C1BpXVe/Rrh7VR+yovcmWwfRGAxz0cWicdk/+c6pkJFckvn4Ntxl3zdVcViuZNfqB6kdy9Tj7AoYWvGLE+eIws0u/P92eeGoQ6zQ0deSw4mmrE+38/PJpiDzSjHyYh5jtTsZKfrfMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU1fJQcJm5SkuVjXnUbm1adc1AkUDi6OgG+Tf5BqqrU=;
 b=kau2eHQlOuVls6lnmgjsTsDa9mYzrEAOg+HI2QgTwkZuyaQqGzvo/znpWDBNzVQVomUGiO3ISC468bVHGYiVr0dyTlOz0cx2ah9+trhSau1mnQQNnqMyH8lOyeL3MO6no1pB5bnIQuS3zYY/ls9tYA8WC7gmdYv2zMwVZyMwqcQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Mon, 15 Sep
 2025 15:08:13 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:08:13 +0000
Message-ID: <c00d14a8-c34a-4f0d-8c7d-b1b1ec329c0b@arm.com>
Date: Mon, 15 Sep 2025 20:38:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, nd@arm.com
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB10650:EE_|AM3PEPF0000A79C:EE_|AS4PR08MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be1b00c-5b85-4c96-fdc2-08ddf469c493
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?QTY0azJOazU1M0c2Yk5jV3hYNkZwcHpRK01SanZxTXB4SStXR1VLSjF3dXc4?=
 =?utf-8?B?c0hCSUpZaWJ4TFZ5YWU0U21xaEI3T2hyVXhMVG1hOWFJS25zYnF1MitnQ1l2?=
 =?utf-8?B?WXlrQlJTY0tJV2ZucDlrK3dtRTBoakxLb0JiQUgxRkx2UFBDMXgzRVM4MG0z?=
 =?utf-8?B?VTJzYkhOb0dLZUxTcWZ0UkdUTHMyaEJjWVJXZVBNbnFNWW5nb3lnTEQvY2l4?=
 =?utf-8?B?K2psNFh0R3NJMmdkMzJUV2kwUVVpNDI1RVNwRU1XcGVwdGY1WnM5VFdHU3My?=
 =?utf-8?B?c0kvdFA0eU90cG01eEJVanlBSmFmejJTVWpKZTg2VG1kbThZaThyWit4WTE4?=
 =?utf-8?B?L2xOZnpuSVZINFRUUFludDUya1ZXN3VLdFVFK2R2Y1NTek51WityVEZ5ODZx?=
 =?utf-8?B?dUVnaExJZUhKczJIczZKMlVUTW9VWFVZbmdqUHkyRitPaHVLMmc2K2lhejRF?=
 =?utf-8?B?blBNRk1teTE3eUxNRE1kdGlpVUZNZG9qQm5td09ZQ0U2dkllcGQrc1lpR3No?=
 =?utf-8?B?c2JpVm1PMHVpbEF6eVBmcFhKOVRwMWdOUFVORldiZWZLN1FrcitsR3h1MTVl?=
 =?utf-8?B?N1d5OTY4ckZaVkZ6eC80TzhYNlNzckp4Um5yU2ZEM0F5dWdOb3BxWWlpREZX?=
 =?utf-8?B?TncrZjFWdzIxZUpXZytYMGtZa2VBaXF4Z08reDhQUm8vNjA0RXZnWEJNOGxi?=
 =?utf-8?B?R1I0SUtNVVdNaklJNzA4djB5dFB3cFRoMCt4L0FJU1FGVG1LNE10SHpZaHY4?=
 =?utf-8?B?Ylp4MlZiK29xUjFUd1NPUlNQZDVKY3FSRWJIb2Y4TTNIVXdRUWo1bGVGamp3?=
 =?utf-8?B?NFVKVVR2eTRKNlBJL1h1M1JtNEVSMmlyWTFWNXdwYnBHS2o1Q2p4Q25zQUVi?=
 =?utf-8?B?Z3JmQ0lpakpvcFNYL1ByazhHRW8wbGN2WGUrL21SQUk3d1Rid25DbnpmQktF?=
 =?utf-8?B?bktvckczZ0lDdTFVOUhJM01sNktFaFEyOFJnMUN0THdXM1RnV2d6aFI5dWRY?=
 =?utf-8?B?aWdnb1ovbEtmdE5jQzlVVVFubEcvRXloNmRIM2x1ZDdDUFNFMmQ3aGtMZDRH?=
 =?utf-8?B?SXpYQWpZaUc4UWJVaGF2a3NPZDRXOVYwVVBnV252eC9mVWszQnFKdkNRMXJS?=
 =?utf-8?B?Q21pbDlBMjRDQWJVQTMwTzZjRlVVUTlnbHo2K0tsTktaSnFHUUFlejFnVkdm?=
 =?utf-8?B?akNybHlNSzJBdmhIS0pQcncxZTJwTENXbW9SckFIK2RvZ0FsUlF2VktvRGdk?=
 =?utf-8?B?bGxzVzlOdzYzYUpJVjNScys2clNHYnFOZ3ZSOE4rc2JKQUd0OGc5Tkc0UGZU?=
 =?utf-8?B?Q0RDejQwTVNzMTVXdmMzazRrMkUxQmtEcnExWUdZMER2azlsTnBNVDBjL0Jr?=
 =?utf-8?B?Q1VYQUYraVVyMlVqdUc4d3lNNTNLNVZRRjhZU3B5OWgzTkMyL2NmaVhQRjd6?=
 =?utf-8?B?VC9oS1lZbWtMaEFNV3hNWExXOHp4ZkxyYWJjOU5uRWNxWFB1M1lQQlU1VmFj?=
 =?utf-8?B?TThld3dxZ0RJcTFNYnYybHRCY0xHNDYrbHY2R0V0alhLck5SUkRFb2ZhWE1s?=
 =?utf-8?B?SkErdGRWdFVQK0luMnA3NEprSitpUTI0YmoxS3dKL1hmL2VlTitVUGZGb05V?=
 =?utf-8?B?MVZOdEFiV2pzTThDbjBBYmtZcEpMc1ZkdXVYVXg1WVBUNDViVmk0UDhNRmYz?=
 =?utf-8?B?ai9wOHJLY1IzcjF3Mm5rRDNSZlBlaXJVMEhkRitpcXAvK3N4c21hUVRYNm9O?=
 =?utf-8?B?ay9ETVBDbmh2cGs2N2dONWxDU0xIM0RDZ3Q0VkY1K1JFbzhnd1BjSmFpSUMw?=
 =?utf-8?B?SlliSm01aXlHajhRM21KVHF1SkN5Uloyd1lBbHhPbzU3WXJQZkpKdVIwcnJl?=
 =?utf-8?B?YjM2aGVrY0hzN3ZhZllzZ0M0T0xHNm9zVEVESDJ3SExnUHNPU1RQekpKT2w0?=
 =?utf-8?Q?hmPc8rkZHHU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10650
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	5c318f93-478c-4ad9-2060-08ddf469b0d1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGNIMXl2NHUwbXhDTEpiRHRJRDFnSXpjS3FZTVRXTjhOTkJWalBSUWp0Vnlo?=
 =?utf-8?B?K05qNzZnbWl0VzY1Wjk1cnV3Mml1MG1VUkZkSkw2NlV3VjYyV05XRnBiaGFi?=
 =?utf-8?B?TWpXYUh5aE9JMUFKQi9UMkYrd1pzRDBSdnZzKy82NHcxbkNEMGRDZ3BMQThn?=
 =?utf-8?B?UFJFbWpkdXdCSnJZeDRLSVFtL21mRGdHSis2RjJhYndIZFNxR2RGS2dOcFhG?=
 =?utf-8?B?WWJrYWprckxVSHcyMUJGSks5dWEzaHUrSVZEUldPeTNDZ3RzY2Z6ZFE5ZkFz?=
 =?utf-8?B?cmRqRVNHbTVxVnBLVHM2bjZ3emVGcFRwa0FqVGJUZjJKalFuY085TlZ6ZURs?=
 =?utf-8?B?TWkrWFk5V05ocGUvc01Sd2tteENSZkpISktVdXlJQnJyanFYTEl0YTlqanpT?=
 =?utf-8?B?RFRNQ3B4bnFpbEdTQU96WnM5TzJNOUE5ckt2NkpnTWZXSXd6djNBRGlOYThK?=
 =?utf-8?B?ZHVhMzdsRC9IQjdFWkRTOGt2TERMcE1nbGpKVnpOc2JLSEF0VitrSzY1bTg3?=
 =?utf-8?B?d3Y3MVFkTWpKTlFzWVNaV3VkaDRKMDVxdXQrRkxkWHU2MHlNaWQ1N1BlblI4?=
 =?utf-8?B?V1FWTkM4STVYekN3eFg5Wk5JTGtxQXRVV2JGTHFwNWF4OCt6aTZVTVRXcng4?=
 =?utf-8?B?dGJjdjZJeTZhMHg4UkZ5dk1mRWRYdUlXSzBOMllBT2VRVGN1c3d6UzhBK210?=
 =?utf-8?B?NmxTMDBVWjNMS1Fwdk5qRWhsN0s1dzZZbCtwK2xFaFhYWHVnN3BtREZNODJh?=
 =?utf-8?B?V1BKU1hKUXpVUlNNL3ZUc0ZueGVzUUhpMm4wejJQTGNCeW1adEVvQTVFbGtS?=
 =?utf-8?B?U3VpWlc4bnh3Z0ZoaVpENmFtYjUzWmJpKys5QlZFaWxBa2lCdXFPamc5NEhh?=
 =?utf-8?B?MEwyK0k5M1BOZTVQQkFydlhaQi9KWVVmK0VlQ3NiQ3N5dnI0dWVESVgrcjhm?=
 =?utf-8?B?MS9xRDlyRnRoYVhuaVRDWXlPSUZaQmVrZTJYYng3N0hINGF2WXhORUQ2MTFN?=
 =?utf-8?B?T243R2RKRWs3WUpwdFlCRi9jcHF5Nk1tc29veHR6d0srS2ZYdG83eVVxT1do?=
 =?utf-8?B?cTZBSDM2cmkvVWd2TXBWUmZSN2lVNDJkUzI3ejB4dEt2SkQrR3RxZm44TE9L?=
 =?utf-8?B?UDNRRFlLc25xeDR4blJ0YzY5cVc0ekxUb2pLcmQ4MGt5aVNISGczUk1sZ2xk?=
 =?utf-8?B?TFRVVG1uTUtvbTFsenJvNDVqMzl2UkFjTVRzWTFaMFltTGVBZHlrL1lsVDRJ?=
 =?utf-8?B?eG5UNTF5ak85aGIwN0ZGTVV0YlVMbkpydExGU3R3RlBuNXhOVzFhMEFHMWdP?=
 =?utf-8?B?dksrcTVkdUs1UHNoTGlsR0ZXOHlwbks2b29EakoyemR2cXpTZVRiNFBvV2Mz?=
 =?utf-8?B?dUdJSmRObVl5M1VaMW4yWEs0NE9kTktkV3B6aW5lZkIrdUpZZnM2VUlDMFNU?=
 =?utf-8?B?VUg0YnNCcnhIaTZhMS9lNDFvVXpDV2cyZHJmQ1IwdEZxWkpOTG5nT2g1S0Ex?=
 =?utf-8?B?dHJhVGl3RUNPZCtTVEpQVFNpZ2dzTjY1K1YxT2V5eU9INlhvWEh3TnlKaTg5?=
 =?utf-8?B?Q0MzSC9ETDQ0Z1Vma2xLbGh2alhxcFVjbG5xSjREVThoSDV4OTR5Z2h2THY2?=
 =?utf-8?B?UGsyYUlYZWRsMFJzdWwrMDZhWUNuYTdIdWk1b0JwRzg4Wkt2RCtzR2trL3Y2?=
 =?utf-8?B?ZkN5eGVlUTlZVVlUbm5YVlZWYmVVWTBWYVUwK0U0SmFqOGFPM3lVODNaYUpv?=
 =?utf-8?B?V2paTzZrWnVMeFdNaEMrK2xkeUsrbmErelkwdkpNWFJWNGRqYkoxR1pUTS9j?=
 =?utf-8?B?SDdvWW0rUGdtc1RZWmI3THdFNzVMSVB4aDdyRVhOck1QRHA3ZGxwVWwvY0hX?=
 =?utf-8?B?VWJkL0M4UzdQTVV4aWEyMzc2STNVcHdEek9XUlBCamZ2TWt5Qmo2czJheDQ1?=
 =?utf-8?B?QmJuT1puVmdnaHBCbWJZNkVYYzkxeW9Fay9NOCtPVDhyb2Nsa3BYY2hFbCs2?=
 =?utf-8?B?SWpmTC9BNlpuZHREWWFUNGdHd3hzZjhDbm1uQVhCc2dCSDRST3pINHJVcFJ2?=
 =?utf-8?Q?Ajd7xH?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:08:46.2388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be1b00c-5b85-4c96-fdc2-08ddf469c493
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7949


On 15/09/25 7:22 pm, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
>
> MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
> PMD page table is installed or not.
>
> Consider following example:
>
> 	p = mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
> 		 MAP_SHARED, fd, 0);
> 	err = madvise(p, 2UL << 20, MADV_COLLAPSE);
>
> fd is a populated tmpfs file.
>
> The result depends on the address that the kernel returns on mmap().
> If it is located in an existing PMD table, the madvise() will succeed.
> However, if the table does not exist, it will fail with -EINVAL.
>
> This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL when
> a page table is missing, which causes collapse_pte_mapped_thp() to fail.
>
> SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
> collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
> tables as needed.
>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>
> v2:
>   - Modify set_huge_pmd() instead of introducing install_huge_pmd();
>
> ---
>   mm/khugepaged.c | 20 +++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b486c1d19b2d..986718599355 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>   static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
>   			pmd_t *pmdp, struct folio *folio, struct page *page)
>   {
> +	struct mm_struct *mm = vma->vm_mm;
>   	struct vm_fault vmf = {
>   		.vma = vma,
>   		.address = addr,
>   		.flags = 0,
> -		.pmd = pmdp,
>   	};
> +	pgd_t *pgdp;
> +	p4d_t *p4dp;
> +	pud_t *pudp;
>   
>   	mmap_assert_locked(vma->vm_mm);

I was going to reply to v1 - you could replace vma->vm_mm
with mm here.

Reviewed-by: Dev Jain <dev.jain@arm.com>




