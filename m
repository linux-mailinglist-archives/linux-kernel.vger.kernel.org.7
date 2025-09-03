Return-Path: <linux-kernel+bounces-798124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1EB419C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A344617585B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448C22DF86;
	Wed,  3 Sep 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jD0nXIYH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jD0nXIYH"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC383246BA4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891152; cv=fail; b=sVVkYm9feLP1JA77gUvQydEuP+aEHvAw+g190WaXuDN4UgMYz1bnhusXOMEIUBiYx6RsOTdedzdpKRcr+TklbEo+UOLh2gXtrkPTwllIRD9Ta7BC5d6+C00jFFZVn/aP6DElJ1BlG3JYFF1XSulpYUH8W39BsLHkj4YD2FUT1ag=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891152; c=relaxed/simple;
	bh=QAc/UAQWEY1rndma9Rcjs194PtF3N9CuV4EQ1Q8XDRo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBXiSuDcANwgZvaBR8/Na7OV0yuQXtSjXVeM9ogDb0xNHb8wwpy27PjXanklK7TTX+/MW79sLMy1IpQ6JPSmbJgK+XSVA6dRUBbvv43u4rm08qiX4PqIek7eAVhZt9ZJsjOBNN4vXZufZdWXbUaWA2ldsdPA3R5A2wUYqh6vXts=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jD0nXIYH; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jD0nXIYH; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XglIcSKtGVIbZjCLt85LiQM81+Xdrk7BvV2v9W2zZh8NgpB67dZKGLNnqJ63AQ42u2N/pxoe4n06x6L6afIoNoK1kd2biav2orTg6MPVx3zAuLBiRbMdT/fZxqRWQQ+9JWoCZK5T5gkUiWYH7rEKzs6EH3nX+6GudsFWmN11pfBEqYOOsAGCeuz4Z8Kd6UFmLN4aPKD8AIrv2ixoGhTF9kcSGVWEg6Fh3WLvmGvUlVQ9Sud50tCCwguF0Yc6UNlFPHImIOnR064EB/lwMbr6KvtrNeG5nOGc+THBr9mq+duPybjgZLD3I5dmi6C8XYbnokUKOZGUj9YoPIo7zE/E5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKdToSC7NupNaxSDJpkyXrCPGInIYIJL+4FM+pkALuM=;
 b=Kw2A0U9uaXABhgUVYJbebabeZsatit0+GsYosvDKaS79C5kIcsWVDquuwodLevbUkuLktbfcqQEj8vWXPU0xal1F4u4etDUNLOIoJGjyrpSaMnhAKaUCbizeHLCkrcaamY5MR+s25qIwPKdwWdwIGW4/I4WtfhaLJjrurq2M+hkKJvmvaPvCb7Uyx/eYiEJ76uZqv5sSkz7aBukJwxouAIP19HyS3AwL0bWVKxKPbC1TpYa6mpbVeRtzQ41WEkuyhsaK4Cns770Zv/C0huQN/CibyWi/hX+WX2xT3pEXzqh3TRobcfsR0Oys/XDvESb9aQGccJr1fCDc4XtPszHcSQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdToSC7NupNaxSDJpkyXrCPGInIYIJL+4FM+pkALuM=;
 b=jD0nXIYH9IfqnduwtEzNn3QWAxqZFsWDnSW4bDiUNbZHkqLmPZMk3rZndzhsbskixZprgqdDQ3ePb1sxRohJGjsBndGscyAjjay0dPkIJ0mkAxvw4O8DaTYd2jlYuZheDHYfwhBwmIzV9DrgfLIBXjJPRNDmG+LXOTL6yN8GDxA=
Received: from DU2PR04CA0324.eurprd04.prod.outlook.com (2603:10a6:10:2b5::29)
 by PAVPR08MB9723.eurprd08.prod.outlook.com (2603:10a6:102:31e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:19:05 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::63) by DU2PR04CA0324.outlook.office365.com
 (2603:10a6:10:2b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 09:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Wed, 3 Sep 2025 09:19:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZypCn2qNfrf4EEdYdmRBSrCqw/3l8ltMbHjkEXSKCjpddTqobsjmHdqH7ZRjaFz8v0dvCxrnTOIsTzCQ3ywPSdt4k1IyHrQPfMkglXwF5MxRAHoDLWb2Xe2q4jZWldd8Vla/JPNJjU+GEJj4rcMk1MFesrzp5cAeigvugrdBbwZG603Lv8KAbYad8QwCX/vSBIcSA0goNzWQq3bVJv3rIvIRI3stP6irw4/g4ZzRSalDgnSS0txjy61jX4fpGvTRUiREEJ1ftraZEV69mr/3l5gBYQwz+HOuYY2QYNBr96RR/tWWQaMtRbDzwy/kP5bMS8L9KYYo7DLSuCWZ7qXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKdToSC7NupNaxSDJpkyXrCPGInIYIJL+4FM+pkALuM=;
 b=PnBJzBHl5sXPagyQQgIM/eWmyFbIpUky2gxsWSux0BoLZ5yyjKKm3pUYOC9+eNcAuykO2xhk1vkKjOaQkQkC35If93LlED2Rp6JbYDGkQgDtexBRbMXRA89Tsy++MGEMHr94HABqMYEb5HTmQbUkXJ6eVPzt+yBh/0Is/ZCguSWPG1RdWDj+BmqabssI8a2svvt6O+0IFBb3eywFNzdwWq/F6tkDdDFKb3QWh/E7aFdSHq8zFy9LzjEUm8gKZxROn0PTL0Cgn/ZPxDKt+usYW/ZU+sD+9VohjvYeVZMbIRd80IuOrqyOQ0M2XiP9a37JU2TsjZ4Fr7jytN+Y+Z7OjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKdToSC7NupNaxSDJpkyXrCPGInIYIJL+4FM+pkALuM=;
 b=jD0nXIYH9IfqnduwtEzNn3QWAxqZFsWDnSW4bDiUNbZHkqLmPZMk3rZndzhsbskixZprgqdDQ3ePb1sxRohJGjsBndGscyAjjay0dPkIJ0mkAxvw4O8DaTYd2jlYuZheDHYfwhBwmIzV9DrgfLIBXjJPRNDmG+LXOTL6yN8GDxA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU0PR08MB9874.eurprd08.prod.outlook.com (2603:10a6:10:422::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 09:18:33 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 09:18:33 +0000
Message-ID: <3bd9ff5d-de8a-469f-a7b0-41c192b23993@arm.com>
Date: Wed, 3 Sep 2025 14:48:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Enable khugepaged to operate on non-writable VMAs
From: Dev Jain <dev.jain@arm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
 willy@infradead.org, hughd@google.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903080839.wuivg2u7smyuxo5e@master>
 <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
Content-Language: en-US
In-Reply-To: <0a52cb54-5633-4374-baa5-199194dfc2e1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::11) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU0PR08MB9874:EE_|DB5PEPF00014B97:EE_|PAVPR08MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: c15b0f0e-9cda-4af3-a170-08ddeacaedfc
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Sm81ZTlpOThkbXZBb0J6Z1h5Mkl5WEF2QTZ4b2ZrRzg2VnY1bjN6TldSZXNa?=
 =?utf-8?B?MWZMR3AxTVArVDhSdWlCWTF1UitiNkZZOS8rYjhFcTFhM3JVSVAvZ3pzUy9y?=
 =?utf-8?B?RHJpT0svOVduMVNWZzVVaGI1T21lZDVXalJYTDVrS05ocTFOQWRtZXY0eXcv?=
 =?utf-8?B?d3BidzBOOFozV0liekp4TTFFc2lwb2xydEloM2lRcVJkMzdva3Bia0dWb1RS?=
 =?utf-8?B?dnZMZzJ2ZGh3Zzh2M1dGVk11clNnQVdraXZCVjErNk5qVXhxUUJqWFNncmsr?=
 =?utf-8?B?c1FiL1pPMDlTR0JsVURreUh1TUp6WnhJOFRROThwSXA1Ny8wMEQ1bmI3VEF5?=
 =?utf-8?B?c3BKOGRvOWdCNWF5OTdwWE1TcXBWRzFuVk9DL2RTSU8wK2wxRnNqVU10YmNv?=
 =?utf-8?B?TjZvemtGeGtFUnJPR3Y1b2piK1hSSC9IVnAyUkFXb2hiQkpQSmllQUlRcDVx?=
 =?utf-8?B?YUpGTUJQb1FSMGtRMW1VVnZNOVI0bG5wOERjWFkzU0ZVdWVycmkyR1VDU3Nt?=
 =?utf-8?B?K1oyWCsrdWFJb3RLWGZaSU5zZGtyQ2ZEMWppSjFSZ3BUMmQzTUZIMVd0L25F?=
 =?utf-8?B?Q3hyZFc0VE5JQW5HNUJMcCtENDBVd1NYUE1mbkUwWkhFWHNuSUZRUEFRNHc4?=
 =?utf-8?B?SWxyVkw0V0JBR2Y0NDVBTEh1MnRoc2JGRXpITnBsdmxxRmpJOWJWKzAxREY1?=
 =?utf-8?B?YzhPMmh2TlBXeHRWaWlrOGR4TVJ4OXFOWUlTUVhkb1J5K1dWZldHeTdRZC9V?=
 =?utf-8?B?WXQyWWI2cE9sVGRxOHQ0Yzl1bENWR3M0RTV1Mjl5OUtzeHcvVWw4QnIvU1BS?=
 =?utf-8?B?UEs3ZnF3YzJ0MHdYUmdBdjdpVTY4QmliK0dRUXNtNG9KTVYycXYrbW1zN3JQ?=
 =?utf-8?B?NWx5aFZGSGFEb1hmVEliOTI5OHJoNWx1ZVVlc0tEYzNxR0ZrMllsWXNQVExo?=
 =?utf-8?B?aTJVZ1NPQ2FEcmtBejhrZlFYZjZHVlhUbUc1ZTNiaHl5Ky9EOUNySE1tc3RG?=
 =?utf-8?B?MFdIZXAxRGhXakRpRUU3c0hSRDRXclFxUnpGR1FIZW1oRTZqSFdBM0pFQ2pa?=
 =?utf-8?B?K2FqTUxjMXhoK0xmWmJwY2hLK20xMnlJZTh0QjZtaVdRUmc1M0hOaW9BejVx?=
 =?utf-8?B?R3R4ZlpwR3BidXJyWWlLVU1wNFNrNUFFcXI5SFBUTjVLMHJyWGY3TmI1dnRT?=
 =?utf-8?B?dE9yWHV0M1lhWXkxNlo2VkR6VlJKbWFCd2dLTmFEbWc2NGhOVGJiTGxubjZv?=
 =?utf-8?B?aFFJelVMbEJCTUo0MkVleFNjL1dJbm5udElvT0NTbS95SzNKZC9vUXd6Um9F?=
 =?utf-8?B?VnJZNEtEbktqOVNBU2MrNHVnS05pT0FndWNZdGFadHl0NElzV1dHOSt6ZVJ4?=
 =?utf-8?B?Z1RoTG5QUldydHh6QnBBQnVhMTJwdWhFdFIxbW9xMUpwUG1TdEVkakJreERJ?=
 =?utf-8?B?eHFqYlJlUmtaVjJzK0JQR1hISm45S01RYXhVVEdLaFdrOG5HVmUrVjVXUEwv?=
 =?utf-8?B?UTYzaThmaXNHcTUwL0VsNnkvYVUrNU9VQjZOQmZlOFpremFyTlF1ZVVza3lY?=
 =?utf-8?B?YmFZalR6YUpTRlk4eUhlR1hFSlcvTWhwZlltelpGVWRQbTREcVZPSTlabzJM?=
 =?utf-8?B?eVl6ZnRkRUVSeVI1M2dNdnZhVHVwVDBKUHd6RkQzL2NyWDIxbkpzeWwxeC9V?=
 =?utf-8?B?VmpNZnBmbjVYNDBYVWYyQlZkdTRUN0xVTkRMVEhCQ0VHMGUrSjBnV09OMS9P?=
 =?utf-8?B?UTAzb2hiY3FHa3p4cmVyMlNSY2x2cU9YZmMyNXhKZ1YzUVY0M1gxNzZCVFNC?=
 =?utf-8?B?b0pqV29aUXA3Z2hsUGIwREhOU1FmdWJmSjQwc0ZWVUppMjhGTnRRaFdMTWtV?=
 =?utf-8?B?ejZSRkJRU3pqWkdaRG42WUh3SDlxaTdBK0kvRjlxY2xBZXc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9874
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0c921cd9-b1dd-4581-e508-08ddeacada8f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|36860700013|1800799024|14060799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVU5SDRvd2RLZFY2MTgvMWZENkgxamlFQUxScEV0MWpnYXlKb05heEtiV2Mx?=
 =?utf-8?B?QzhDUWtMZGNHd3ZkaFdaWkFqQ005RDRDb1pkWW1kc0p4TUtCbXdNOVQvOEN2?=
 =?utf-8?B?cHFaUjZyQnZ3bitacFJLOXdNVWxHenRSUjJGZ05XMk1YKzVGTWNxVHJSRDdI?=
 =?utf-8?B?bFRkTTN4S3IrTUQ1TFJCTWRjV2IwbHdjVEM0R0Z4SG5KaVVTY3FVOXpFb3VL?=
 =?utf-8?B?WnBNcW5vT3l4c0RkZTJUZDVpcjNldm5uVmh2L3Q3a1RPSW1IS20wbjdPN0tu?=
 =?utf-8?B?L1VWRVFNYnZEU2JJYTV4bWQ2WVl4MWJtdXRyTXlMQVBMdit2Ry9MQ0hSWjB5?=
 =?utf-8?B?UGtZdEpBNXhUSXVwck1xTTR0dzR5V2JBWHhMd3JaaUppWEl0VHNQMHBUVGFo?=
 =?utf-8?B?SGUyUGhPVzNBbDFOcDcwb1pVaVIvNnhnL1hFZWVaVCtOSjQwU2tJamdXSDdN?=
 =?utf-8?B?U3pGOUJLaCtxKzMrakJqcTViQVI0NjU0VkNxaG44ZDYxSEMxTHQ0M3FZL0oz?=
 =?utf-8?B?VitKdnFFMWRRZ05OVHJmYlA3dEx5YXUzbW4raUlYT3ZKTys4R0Q1Q0gyWjJh?=
 =?utf-8?B?V2IvcmFGU004ZDRMQ3lsbjU2RWZ6bEkvYXRhY2F6djVQWTY0aDYySDBlN28w?=
 =?utf-8?B?V0UwRHNuUS9vQkhOMS9BOThmSjFPNEVjWDNJQnhJRmRETnhwQzZjdU9zOGc2?=
 =?utf-8?B?Y2dkVHBNclNJUWpuR3hjbmsxR0gzRHhKQjczeDlCU0twRnRCSDFNc255eFQr?=
 =?utf-8?B?SFJDU25neGlVOWlmZXhnZzlrK013bTA3Y0EvcGFUN3ZMWmdzTHpIMUkrV0cv?=
 =?utf-8?B?eXM1a3ZtYmJqRFpUZFVDYmwxV25KTTJRRnhIQ0owVW9YdVRZYWd3QmVlZ1l3?=
 =?utf-8?B?Yng1V09QbmsyM3pyL21iVlR4dHcyVmsxUkk2dEFNcGlIVG1JZ1VTZXBFYmtt?=
 =?utf-8?B?ampTdWg5MWtKbkc3K0dnd0xvUU90OVNoYlZFdjZOdGtJcWJXcW1vK2wwNkg4?=
 =?utf-8?B?VWpjVTF5bkVTMEk4VkdpOVR1Nk1aK3lkOUxwc3JvNkVvWDZ3ZWoxdWVSM0R0?=
 =?utf-8?B?K2hJWEZZNWFRZVFaTHo4QXl5S0trUWZVYldoaHNBVW9ybUZjcEkvQVdoY0JW?=
 =?utf-8?B?ZFhHQWFTcDJpdXBCS0FlNDNuOWI4VmpjYkZsUFE5NUVOOTc4ZlhNZFQvaDIw?=
 =?utf-8?B?alNxSWVySFAxTEY1TDFLU2tia3lEM1dvZ0JZY0M0RDUrVVJmQlJvaEZZaUsw?=
 =?utf-8?B?Z2lJZE1GUjc0STFQYWF3c0x6SzhjdlFpNFRWZmMyUFgrVVF5Vlk4d2NDM1Zr?=
 =?utf-8?B?U3VxWDlrUXN0d3MxZCtKNDcrNTVNY0xHWXhXZ1ZqcmVFTndGVUpNWDdEQ1lN?=
 =?utf-8?B?c0hydFZ5WG0xTXR0eXozYS80ajAzMG93ZTVrNys0RmQ2cmpGYUxUOGkrbXlB?=
 =?utf-8?B?bkZwTUtsQXhyUlMvWXk3NGUzaHI1ZXg4NGM0citOTG82K3hka3plN3hjRU12?=
 =?utf-8?B?QXM5NG9nOENYMWNYcFFGL1R6ZGR6Q281Tk40NnRaM0ViNy9QVWFiZU55VnVs?=
 =?utf-8?B?bWp4UGIxNEwwdG9KUlFQQmVRbHcrN0xYdS9oY2Jmc0hoaHpBQzVJbFBwd2FB?=
 =?utf-8?B?UTEyWHhrQ3NwajlhbTN1SmE0MWlZYktBY3ZIZUVwdDIrMllENWwwQUVpL1Iv?=
 =?utf-8?B?cjNvZEdQV1A4dDJIa3FCZFJ1ZzNZQzVxWXZsZUZJMGxLQ1FBemlDaVRRY0ZI?=
 =?utf-8?B?R01NelFsS3crUXFJeEFSNGhyaHRVK3MvTUFsRjdvWXVhTFRJWCt5cmdBUFhO?=
 =?utf-8?B?dlpNSzR5cEQvUTdLaFNBaXdPZnZGUWtLdHVUdFAzODREQng1VnR1UlhzMS9G?=
 =?utf-8?B?SFdRMHNjN2Jyb2M2RkxNaFAvUzFtT2ZWWGhXNEt1SDhxZlY0MDZua2J5VURF?=
 =?utf-8?B?LzgyR1RYMWdHRUkvOWRWRGJxVkpUYnlZditiaThYd2hxSGE5M2ZoYUpUSWtS?=
 =?utf-8?B?SE9HY0pIU3lKSHduMWV3cm1xWXJtdmltTGRkcVNGc0R4S0pORVppekpZZEVQ?=
 =?utf-8?Q?+tNdTf?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(36860700013)(1800799024)(14060799003)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 09:19:05.2516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c15b0f0e-9cda-4af3-a170-08ddeacaedfc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9723


On 03/09/25 2:45 pm, Dev Jain wrote:
>
> On 03/09/25 1:38 pm, Wei Yang wrote:
>> On Wed, Sep 03, 2025 at 11:16:34AM +0530, Dev Jain wrote:
>>> Currently khugepaged does not collapse a region which does not have a
>>> single writable page. This is wasteful since non-writable VMAs 
>>> mapped by
>>> the application won't benefit from THP collapse. Therefore, remove this
>>> restriction and allow khugepaged to collapse a VMA with arbitrary
>>> protections.
>>>
>>> Along with this, currently MADV_COLLAPSE does not perform a collapse 
>>> on a
>>> non-writable VMA, and this restriction is nowhere to be found on the
>>> manpage - the restriction itself sounds wrong to me since the user 
>>> knows
>>> the protection of the memory it has mapped, so collapsing read-only
>>> memory via madvise() should be a choice of the user which shouldn't
>>> be overriden by the kernel.
>>>
>>> On an arm64 machine, an average of 5% improvement is seen on some 
>>> mmtests
>>> benchmarks, particularly hackbench, with a maximum improvement of 12%.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>> [...]
>>> mm/khugepaged.c | 9 ++-------
>>> 1 file changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 4ec324a4c1fe..a0f1df2a7ae6 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct 
>>> vm_area_struct *vma,
>>>             writable = true;
>>>     }
>>>
>>> -    if (unlikely(!writable)) {
>>> -        result = SCAN_PAGE_RO;
>>> -    } else if (unlikely(cc->is_khugepaged && !referenced)) {
>> Would this cause more memory usage in system?
>>
>> For example, one application would fork itself many times. It 
>> executable area
>> is read only, so all of them share one copy in memory.
>>
>> Now we may collapse the range and create one copy for each process.
>>
>> Ok, we have max_ptes_shared, while if some ptes are none, could it 
>> still do
>> collapse?
>>
>> Maybe this is not realistic, just curious.
>
> Misunderstood your concern - you mean to say that a parent forks and 
> the children
> VMAs are read-only pointing to the pages which were mapped by parent. 
> Hmm.

I meant to say, writable VMAs with wrprotected ptes. Maybe after this 
patch, people

can finally make some real use of the max_ptes_shared tunable :)


>
>>
>>> +    if (unlikely(cc->is_khugepaged && !referenced)) {
>>>         result = SCAN_LACK_REFERENCED_PAGE;
>>>     } else {
>>>         result = SCAN_SUCCEED;
>>> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct 
>>> mm_struct *mm,
>>>              mmu_notifier_test_young(vma->vm_mm, _address)))
>>>             referenced++;
>>>     }
>>> -    if (!writable) {
>>> -        result = SCAN_PAGE_RO;
>>> -    } else if (cc->is_khugepaged &&
>>> +    if (cc->is_khugepaged &&
>>>            (!referenced ||
>>>             (unmapped && referenced < HPAGE_PMD_NR / 2))) {
>>>         result = SCAN_LACK_REFERENCED_PAGE;
>>> @@ -2830,7 +2826,6 @@ int madvise_collapse(struct vm_area_struct 
>>> *vma, unsigned long start,
>>>         case SCAN_PMD_NULL:
>>>         case SCAN_PTE_NON_PRESENT:
>>>         case SCAN_PTE_UFFD_WP:
>>> -        case SCAN_PAGE_RO:
>>>         case SCAN_LACK_REFERENCED_PAGE:
>>>         case SCAN_PAGE_NULL:
>>>         case SCAN_PAGE_COUNT:
>>> -- 
>>> 2.30.2
>>>
>

