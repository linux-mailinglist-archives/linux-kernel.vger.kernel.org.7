Return-Path: <linux-kernel+bounces-798120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C36B419BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC356806D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA702E9EA6;
	Wed,  3 Sep 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m7aXUpqa";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m7aXUpqa"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4308B258CDF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890975; cv=fail; b=Qcrqfm2i/EPIp3c+9JUY0WAnoOodbPFU+uWk9c5ceBKSjT+I1RAboBP1/nqPjOt09mUuW3Gq/9IakA0kddObGSdFetmo6lU4myPbcl1leA47e/cErQ/yitWqz0KP4YqfFeyOKLe+9uao17OtlXIozai+f+afy/N9iwMwHwxants=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890975; c=relaxed/simple;
	bh=qsddKGDvMCgcl3VU6MwmTqjl0pFheKbxOc8KmR7ZCXI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nN0LOKuUFcFBagKa82NfF2QnDF1YYoXpWctXzeDfPB9Hgw/Rc4K4O8BvX842s0zlShnmx0S8YHSvs1fGQqxUwjYm58xJVvIhzSg1GiAZcjfGxJvOITURdB4so0IQNxMwoGYNH78wWSMrmi+I3FUjMLe2x8uwoY9zSRJZcgYJVjk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m7aXUpqa; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m7aXUpqa; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vH2fgZBc3xeRjik1O+WuUundI4i23vzdflO1Wv/kC4+m6n5GT9a3XwPwJ0ArRIiIxmflp2Gu0ddb9Mmdjww4n9bbnCXhugUy/kFRkPtPX7LjYyXcrph1xa2nJ6yWy43juMN9Lxp1UETtz8yz0OqxoxAJYFavtfJf4vkBaf8scJqpgevTZJWvE4RhCjmye5b/RxrS5cGVSBfQCo7LFFCRwKXnq4vsexicthAL7zjsl5v6sOJogcxBOdUz7XcY/HGCmmeAINw8M2hYdVI+HPq8hYhmRXLHEDjVlhiX3ycYgIfxcwcjbx/n0Tgge7naoMohtOW+Ejzs1jayKD6D2/TQyg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clS+LTjdyyx52VUXGVHjIBDveYv31DXYt+7TbVZW0qw=;
 b=fmr6K6X7aUif6OAw/xoUuG+X8RWR9g7ICWPQjiOZl8q6bf2D2afhBNDthaJ4o3o0mV0x6b71g5LfYoqXdBAqx6u/7lVkKUXetsgA1HUyMOJFjjRl/ey2+dA+uq+hZUXSp/ZnRWSW0uYmYrmaS0UYtmNgWeLzHvJMHji63G/5US0V0AxJSe7PR+WbpL08puyUJ0C5Y/F6zscNZ2b/NF3AmXVfw+TgSCWahbHfPO7FvOhfnBvuG7zZx9dI4btA9YiRaDopEYA0HEfSGnsGw1gVJldV9bfqjw1FHZl38JgysuN8WWX7VHtGAJGIv08CcCYneb5mcmA+ESx7a8dYwPYmWw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clS+LTjdyyx52VUXGVHjIBDveYv31DXYt+7TbVZW0qw=;
 b=m7aXUpqargOSBZqjlwYk2+UGzKd1wc2Jf6ZnDbFimvMezWKCf35kKPn36E+4kpcophZw8wivj+76G3xvYKRb8oexqyeXXQcxkeJP+Bt+tPmuYU+dI6xrn53BjaBlEHDylZg9txK7a1AUJ4CjTqPo6bsN0+OaS43Kvqi1xi1ZTKw=
Received: from DB9PR06CA0005.eurprd06.prod.outlook.com (2603:10a6:10:1db::10)
 by AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 09:16:09 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::5e) by DB9PR06CA0005.outlook.office365.com
 (2603:10a6:10:1db::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 09:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Wed, 3 Sep 2025 09:16:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRXbseX/TjwIhIItX43qYIw36d3ocgwisCpNF88HGnNOUWPE6fhd4uVuzejC4nOOxhopeot+E8GCDo2htqMTJ9awp2z1htULZRdzpiR0/DObX5Q2AUAnanuh9ZFjuhtc/a4SGLLT6Y3myhypmHyGDG+LZyecKcWyBYa2cU0d/BTahBaZIZdsZA/yN+8fJSn2FX0CGG28l7n0GULI0yPTtjCzJQSco8p8P6e1vw4uQF0fKy8K3FuQB14jztEjEQXD+ibzZKAZ4nuxpc5Da/3xcgfq6QAtYdQaVy4GLDSQ14emfhhsYx/bP+GqcqbY8d3kBxWi6iCoF0nwhm9IHMtLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clS+LTjdyyx52VUXGVHjIBDveYv31DXYt+7TbVZW0qw=;
 b=Ytza8vl4S7skYQHhK2VXMt9lsK/ID6agfvGD3whqbkJ3GlA27mViYo32fh/gwh8IPyC1ldOdbG+85JLdmNZMgcMRWRq/dDGg9PCMeRg9rHrX9avxQZNFz221/iwsYmMA6sj+Y4HSvL0HE4f0JUnCI81ySRWsNw0JuQX91Lg5AUNXn/EcSRotRjHAQRquOdqr8NzqHWoV9i5Fdfm3HiSfYIcZo/SZmVVqiSHQoRY5pKI1t7Uw+SijX2LJEtMjUP7bGS6RcLteFlQDCW8Qfl1l6R4v+w/k6gjyuuh2inYrMaW68GrqPt5zTPpNLhXbWbdsnvqQSHaqLNyVWkm7KcJzdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clS+LTjdyyx52VUXGVHjIBDveYv31DXYt+7TbVZW0qw=;
 b=m7aXUpqargOSBZqjlwYk2+UGzKd1wc2Jf6ZnDbFimvMezWKCf35kKPn36E+4kpcophZw8wivj+76G3xvYKRb8oexqyeXXQcxkeJP+Bt+tPmuYU+dI6xrn53BjaBlEHDylZg9txK7a1AUJ4CjTqPo6bsN0+OaS43Kvqi1xi1ZTKw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB8PR08MB5404.eurprd08.prod.outlook.com (2603:10a6:10:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:15:35 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:15:35 +0000
Message-ID: <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
Date: Wed, 3 Sep 2025 14:45:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
 willy@infradead.org, hughd@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250903080839.wuivg2u7smyuxo5e@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB8PR08MB5404:EE_|DB1PEPF000509EE:EE_|AM7PR08MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: c05b48f0-592c-47f0-6ae4-08ddeaca84ad
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RVN6UUg3K1FTUXVVRzBTbFhpV0xQT1BZS2NNUVFnRGNZUWp0R3o3NmdyWHQx?=
 =?utf-8?B?K2g3QWtWMTliWHVyNUZLU1k4WnhDUS9ZUS9OR3pValFIbGNtTFdGc1ZnYnpx?=
 =?utf-8?B?R3BGZEo5LzZkSHNWa1FoR2dNVHlkaGQxY3NLK0EvTWxENVBiTmk4V3F4Ymw5?=
 =?utf-8?B?WnBxQ1RFckxRSVVTYTl5Z3FuQ2RMN1BHVk9Fb3c0WUYwd3JkMEFPK2FrZ240?=
 =?utf-8?B?S1ZiMll6Nng2SzFLRWxvcjE2eHE4SWRiRGlMbi8rLzBwYW10RGhvend6WXJv?=
 =?utf-8?B?NGJSREQ0SXUxa1ZSNnhQVXh1elNSb1BGZy9mYTRUZ1VVL1gyUjlaL1JhMWtN?=
 =?utf-8?B?d0JUeEw2N3RENXA3Wkx1dnN6KzA1TFZ4V1dwTXpMcGUrT1dSYWRlaXEyUzJj?=
 =?utf-8?B?Q3pwY0lVamh2NE1iWC9IRFl0K1N3RUFuUjlyZEtUc3N6VlFoelNMUDVoK3ht?=
 =?utf-8?B?a09HSUJhZCtXRm5wWjBDOXUvZXhTQlpRVWxSZFYwK2s4bDVTbnk0dUJ2SG1Y?=
 =?utf-8?B?bWhzOHVZQjdTVWNJSTlPMGJ0SDdMeHBqaHFXb3hvWHRnQXdZcmprSmFIeEtJ?=
 =?utf-8?B?M1hOc2lrc1FTdnNvMXRVK2prdm5jbUtncEl5TzRobWZncHd3OWFjSDZqSUlK?=
 =?utf-8?B?bFN6d3YwKzRMd08zdUo5bDUzSDFlbzhFaUh2Y1Rrd1hTRENyOXIyVGN6UDVI?=
 =?utf-8?B?cHlXZllqZ3EwQ2tkQzZEVlk4bnlQZGtxdENMMUp3ak91MHZUMEpFNncxM3NT?=
 =?utf-8?B?NEN4ZVJhZjZXazc2bUhtdElWajZoUE1qZzRSaGYzcHlSSDBmQ2pqbU5MV1Yy?=
 =?utf-8?B?c21IeTh1YU1Fb0dDZ0tKV0JhSjhZVnQwUUh0NXJQVXVwZC9BS3NheWtCYjlL?=
 =?utf-8?B?VW5POHMxVHhMamt4UEhXeUsvNUZGUHJ0b3NMUm92OHNvalFxUlhOSDRxVTJu?=
 =?utf-8?B?bTNEOFQyTDd6TVdVTktUeXNLVVRySnVaNjFpa1I3dzhNcUc0M0NQUDFBSkFK?=
 =?utf-8?B?ZDZ5ZFJVbHdJTlJzY2xTakViODFNTzZxaWFXaGFWdHlSUzlwN3g0TFFoOWJq?=
 =?utf-8?B?RVVSR0ZRVDgySUdkc0cwUi9tcnE2dC9YaVpHeGhtSjRpdVhjeFp4RUc2UkdC?=
 =?utf-8?B?YjNmd2dmdmc4MDBjUnByMmp0VHRxTnJwZk1hSWJjYmIrVFNVK3NxL3RTVTlH?=
 =?utf-8?B?UktiZWNKRlhtWnFadWYrQVNrL0dJM2lUNFMyLzRHc0J1YzVjVmhSczRBUURO?=
 =?utf-8?B?ZStFeUdJTnhRRlRSa2lJNFp4SzNNS1VMNURTeTA1UzJ4VkJmTURuaXR0SFBM?=
 =?utf-8?B?RTErQkRuUGpGU1BlT0lZY0gwYUtPdnJUckZyZVUrM0w3RWUycXIxYmt2WmVJ?=
 =?utf-8?B?S2RLd0FNYUI4QTFKajZ6UWQ2Ym9IR0pYN0NOb0VtdElzakRxRWlYMDRwZXJP?=
 =?utf-8?B?TTcvK3BLM29XUW1BNEJJdW1rRjNKNzQzZTZpRktodGp5TUhjNDBlQ2M5cDFr?=
 =?utf-8?B?NXNCejVpZElyY0NEOXNvdjRUU08rTllNcjhPeE5HbmVZYVdHNmNmL1RhRkRD?=
 =?utf-8?B?ZVBPK05hSXZ3T283K0YxNEYrakdBM3phc0k4WG92dDBRVTBvdzR6WkY1MjUv?=
 =?utf-8?B?YjExeUoxc1laMlJVNHBxeGV4d2UvT1pCSWdKYXlNNEcxeXZIZUh1RVQxVDhD?=
 =?utf-8?B?WWFuQ3UyM2tCc3RFZ3dIemZLc0RyTWhPenJUeWp2WE5uNGllYmhJVEo1amRk?=
 =?utf-8?B?T2duaU5QNGxZN0pZS05JT2pFeG1CL1JOdHdtRTJXTi80QjJ1b3RXUmo3S3lU?=
 =?utf-8?B?My95RFljc0VybmdRK2xHNVR6bDcveTFrN1A2NTc4ZHZRcXJTNUd4S2hwdmNG?=
 =?utf-8?B?bUVUWGpDNDVrOXQ5MDI0VEVSZVo1Smd0bzBEZkRIZVVBLzZZU0lOc1JSWVJI?=
 =?utf-8?Q?ZIvF44AOGIM=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5404
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2c1f36e5-0a03-4485-0cc0-08ddeaca7086
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|35042699022|14060799003|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVJqUXUvN3JZd09XQ3dreWtTaVhtZDhER1Jkd2d5ZE9RR3VoU3Y4SE5Ick40?=
 =?utf-8?B?elFzUGc1WklHclZIT2UweHQrSGxWM0V0cytWVlF1ai9UbUp1WTJzUDdMUlVj?=
 =?utf-8?B?ZXJFZnFNdFJ5Ly9OS2pySlVZM1VPdVhBVjcxWGZRMzk0cUNCQ3h5citUbG5T?=
 =?utf-8?B?aHRVdlVqODZZaENuanQ5Tm8wcVBUNGQ1a3hoN1AwbXl3K3d4L1NvTlRZWkMv?=
 =?utf-8?B?VjNObUZnWDZMVEtOWDNsOVhSRTYxSXh1WWJaMVJ0WGlVOFJJVkd6eDNnTjIz?=
 =?utf-8?B?Z2tZdGFibWVESXJHT1BoYTl6Z3d5S2FUeHFvRmhHNy9ZbXAxRUU1UmltcjFS?=
 =?utf-8?B?cDA2ZGxEQi9CWGYvWWJMTzhZR2Y0TytHNEJIcXJyeFBvMWRDUkJqKzlwc0po?=
 =?utf-8?B?WnFVN25Ha3F5RGRIRHFTcVFJNm16QXBwdmNhU3diekpsUXhHbVFvRWlYclQ1?=
 =?utf-8?B?MG5VdkJPcjZSMytKekZtYWNybnhNdExyem9HQUVib3RENm5pUnVpVUo1UE4z?=
 =?utf-8?B?eVNSL2RSRzl3ckpCZGo2MFFOYjBTMjlXbnhkYUJsVU1YWGNESnJKWHV6MG1G?=
 =?utf-8?B?alFOZi9pRHphQytJUG1rYmlaMmhxTEtRbUNoUG5uMC9BZDlBRUZuVXZLVXM1?=
 =?utf-8?B?M0xsOXpHWVZDdG1jOThIeC9JMGhXbE1jMkliK3lxVGw5a25qdk1OMkxmWWc5?=
 =?utf-8?B?ZzFOTUVidzJ4SUwxeWljY0xhTXc3S0VodDVYRUY5S2lNR3dodGRRNWIrNFRE?=
 =?utf-8?B?OTVTWDdUbVJZTnJjazBwUFVDVnhLdGhXQjlVQmR1dXU1SFBBalpFNHlXWDNO?=
 =?utf-8?B?V0FpQW5RTFcyMlZvai9Ycy9ERnVhdEgrMFFJRWIrZG1oSnM0TUNLd1hkdmxL?=
 =?utf-8?B?SmM5WkFFRUJaWnBJSlJXckhXakZ4ZVlDTENnSlp0MTA1RGp6YWNQTzFzNHNh?=
 =?utf-8?B?RFI2WW96eHA0RTkvZjhOUUd3VjJxbGlKbDZMcElJRkM0VGs1RWFTWXY0T2s1?=
 =?utf-8?B?ZmdlS3UrbHhEQTRaVTJaYncxcHNDbldvMVU0aU1CVWFvT1FQMTZTenhRTFk4?=
 =?utf-8?B?L3Y4RnczNjlLelYvOWJhdmNkUHRDNGtMUjZZMjZmbGdYS0tkRGx2RGZ1dEFx?=
 =?utf-8?B?bUYvQ1R2SkNiaXhwYmcwL3duSXFURVRvdG5kWi9nUFZnQmlhUzl3Y2xZdDBi?=
 =?utf-8?B?N1ZubXhXaVErV2dRN1VuZlA2RFNoZlZCakVqYVg3bDBuYzUwbVRkYlFaVGtk?=
 =?utf-8?B?L2RERWYzYjd6dHZQSVdIbDIvbXY0a0kyVTljVHRPWUl6L3ErZUphV3lZUVFE?=
 =?utf-8?B?N0l5ejYvT3VlYTlKbWFrbndsNGlwcWFlZ2dTUXc0TTNId2FTcDhEYzY2V3g5?=
 =?utf-8?B?WDd4dmRHbUtZUXUyVC80Nm1KOUt1aE45dk1SM1NiOENNYXU5TkU3NkJLOGhC?=
 =?utf-8?B?YnA0a3dUVXJ5Ylh3eUlMWnFCZUlPY2xRcWliLzdBK1hPR1QvcnhiU3dxVnFC?=
 =?utf-8?B?UitVQUdvTUlXSzd2dUFEUHdIUHZkTkFXc0FJdzdoL1B2a3AwbzlYYThpTTh3?=
 =?utf-8?B?SmdGaWd5c2tHS0NiWWV2SXFHVWF5cEU0SXRVdnVYdjMvR1FZOXRQMjFEKysz?=
 =?utf-8?B?RnBzN1pMVlNVaHlDcGdQQThyMzU4RTZiN0hOa3c3QzFZdE1iYjFnNkpLeWZn?=
 =?utf-8?B?Y25vd1lqbEl1Qjd3WkR6Q1NmZTA3eWhnTVhZUXo3V09lcTl6bW94TDkxWjR5?=
 =?utf-8?B?ek12c0tLRDBSRUxuMmFYbnF3L1Axdit2R2tIRDc1bDlVSXBlREVXSXFMSTN6?=
 =?utf-8?B?WjNkNFFUd0tLOUtQdmF6RkpuZkdyeTNzSzlQdnZROW11SWtNUTNEYXJGd2pr?=
 =?utf-8?B?YzVyRUlzNUMzN1dkMG41ejZNVjEzTEV3bWt0ZFNnVFlXQ2J4RlI3c2hLRElO?=
 =?utf-8?B?REZzRTNsSXpFMzd2VU5SNHBsYkF4WVhjN0RFbXVYUWM1QWxxMDA4ZUhxUXJ0?=
 =?utf-8?B?TDBOQy81VGJJbWNYb0ZnWnJOWFU1MTRwRmlHL3NTRm5KYy9Pamh6alVyaGJx?=
 =?utf-8?Q?D81Wtk?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(35042699022)(14060799003)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:16:08.5739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c05b48f0-592c-47f0-6ae4-08ddeaca84ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5494


On 03/09/25 1:38 pm, Wei Yang wrote:
> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>> Currently khugepaged does not collapse a region which does not have a
>> single writable page. This is wasteful since non-writable VMAs mapped by
>> the application won't benefit from THP collapse. Therefore, remove this
>> restriction and allow khugepaged to collapse a VMA with arbitrary
>> protections.
>>
>> Along with this, currently MADV_COLLAPSE does not perform a collapse on a
>> non-writable VMA, and this restriction is nowhere to be found on the
>> manpage - the restriction itself sounds wrong to me since the user knows
>> the protection of the memory it has mapped, so collapsing read-only
>> memory via madvise() should be a choice of the user which shouldn't
>> be overriden by the kernel.
>>
>> On an arm64 machine, an average of 5% improvement is seen on some mmtests
>> benchmarks, particularly hackbench, with a maximum improvement of 12%.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
> [...]
>> mm/khugepaged.c | 9 ++-------
>> 1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 4ec324a4c1fe..a0f1df2a7ae6 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>> 			writable = true;
>> 	}
>>
>> -	if (unlikely(!writable)) {
>> -		result = SCAN_PAGE_RO;
>> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
> Would this cause more memory usage in system?
>
> For example, one application would fork itself many times. It executable area
> is read only, so all of them share one copy in memory.
>
> Now we may collapse the range and create one copy for each process.
>
> Ok, we have max_ptes_shared, while if some ptes are none, could it still do
> collapse?
>
> Maybe this is not realistic, just curious.

Misunderstood your concern - you mean to say that a parent forks and the children
VMAs are read-only pointing to the pages which were mapped by parent. Hmm.

>
>> +	if (unlikely(cc->is_khugepaged && !referenced)) {
>> 		result = SCAN_LACK_REFERENCED_PAGE;
>> 	} else {
>> 		result = SCAN_SUCCEED;
>> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>> 		     mmu_notifier_test_young(vma->vm_mm, _address)))
>> 			referenced++;
>> 	}
>> -	if (!writable) {
>> -		result = SCAN_PAGE_RO;
>> -	} else if (cc->is_khugepaged &&
>> +	if (cc->is_khugepaged &&
>> 		   (!referenced ||
>> 		    (unmapped && referenced < HPAGE_PMD_NR / 2))) {
>> 		result = SCAN_LACK_REFERENCED_PAGE;
>> @@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>> 		case SCAN_PMD_NULL:
>> 		case SCAN_PTE_NON_PRESENT:
>> 		case SCAN_PTE_UFFD_WP:
>> -		case SCAN_PAGE_RO:
>> 		case SCAN_LACK_REFERENCED_PAGE:
>> 		case SCAN_PAGE_NULL:
>> 		case SCAN_PAGE_COUNT:
>> -- 
>> 2.30.2
>>

