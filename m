Return-Path: <linux-kernel+bounces-815747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C757B56AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3E217C814
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A022DC350;
	Sun, 14 Sep 2025 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pm6NVL8O";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pm6NVL8O"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D1519C560
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757869456; cv=fail; b=i4UHn7yj0hy5u/FBzCk+awm6jwRyUmqqgIysZiT2wMv1paD/dZL/IMxnC8zTXlsiVMkgI8k1x6oc47F+UBFop5KhjstgBFaYJ0m7IJN02J55IR1tnj4Jlq7Nzl4m3VeJr+BkBk1m2Y4QWaROdqLUnjH0gu8YtEP+toP8h9zRKdw=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757869456; c=relaxed/simple;
	bh=GEJqq1H9R+Bgz7cnQnQHJI+Q60euF1zZ9WvRq9h/E4w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kcTT3bJrN7xzJtyIvzrCX7mFm7XnbE4Em0QPhzaeLIklTa6IKtrQPzqtqPsJGKKYANYL4mBTj1le6k4hfVMaNJ3s8z+UdzVyv9pbZOKmurg9SS0FkZ0p03Y9WdPmi3mX1+nkIKjFMptUaxbOcEHgreTTYKbc71OrkgjQLdSfMBI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pm6NVL8O; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pm6NVL8O; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=PnSdSWzACApGfmYb/exsxktBtRDdS2wWB9FGGbnckmrzAJvGtARFZ4yg3Jo2p7X8TfY9FDrHhR5VCNVGYzQFsC7MTGXqBzOkR/4S44ggCIDQC4hIArnFqZ+u/JDzs/pBTG24tg/A+wGiMsUtlmsRTBfg8gSaWQ8yyCaUIR4KKWwmEBXoqilZ0+wluMFqtR7ioz7Yb6KRz6piDC5zmFZVeErRz0nJBgpY+nsNAZqKgc2bdWTZToIhqjGIiNd0XGuXo1MCKzWpl1S9DpwcvfHt5OmLUnTekWBd4q1zuwktE1A745GiaiDOdIcC1ELUEMZ0ubCaL2vqNdIE6nRPVy1dYA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KsQDMh32O/YwrbGCkYBeAKE+SuC3XibdGgrI9nqQww=;
 b=Eso7lvLmEnflOUatoj33xlbIGAX7ZzXYEuW+ll9Um6xg1MDFWN1OCwWntUf7NSCFvhtbObyS49ElX8Rtpr1oU9YCZEjHc5mCeg4jotuJ/P5B91MoM7Fi8+IqcCuIswCq2W5f94WrNkMQ9Ho21UM1z74U60z28eV8kP2JuJAfjZfN6jUw/yxDuvTvx4iodP2EJcxGr2PPAzI0wpQ9ceXvrGVATAXKEvyMOn6KogUqFXLnvkHGLDq7J7CIMgT9OTRZxCVfkX7ODMHcXQDp2lYsom8LbPO0q1sBQ04Yu4MeuYZEX1UfABDb0PguWEL6u3z99JpLHGUVuoHpVTHvNk1fXQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.dev smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KsQDMh32O/YwrbGCkYBeAKE+SuC3XibdGgrI9nqQww=;
 b=Pm6NVL8O6W3xFUJzWVW8VNRl36Qj66avYL9r9Ll0fdFORWcLjKdDxFrOqj4NP3kO8udevd3nIWj6WS5fuulZDqwt7Cblf4kSjmPNr+v7jpdr/6hREPhpBBjl37feQjW4qrFPDGdDRFNqGdOL958HGQ6neWhIsPA+WMdg7AryscI=
Received: from DU2P251CA0029.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::31)
 by DU0PR08MB8954.eurprd08.prod.outlook.com (2603:10a6:10:465::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Sun, 14 Sep
 2025 17:04:07 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::bb) by DU2P251CA0029.outlook.office365.com
 (2603:10a6:10:230::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.20 via Frontend Transport; Sun,
 14 Sep 2025 17:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Sun, 14 Sep 2025 17:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgD/Ca7O5aMlN6qYK1zUoeHCc5vWiaJ6BmRz2FNpdxJOFfyTAZbC9dZHAEskB3uCqxTOqT4J+oB2Ve/OhXJ3vwjpPKQCNVRuvwLC3HVMq7Xh3y/VnX6j0wNRzN9KpZF0f7HHYWCoXO5cIMiC4VWpub/CddJTv9pVqQkiUxvKc+mbTn+dbjw26Dn0+K1sQXwksuJpaV0Rm90XjvLg7QSKyp1wAlfGaJI+MGvzkZtdkqR65Je/tHbU+STbJhYTY0dd0QuXFxpx7JgE1akNeK5bE9A46HEcLHir3JsA378ZF6MfRV7lDglV2poJ0oVn+lcPnly4zYa3G+MieViQfmIEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KsQDMh32O/YwrbGCkYBeAKE+SuC3XibdGgrI9nqQww=;
 b=LDP/y807FkWTAjZlH6pvZancnGbg5ykadXwS5QUa9SjK+dogz/pWC/o4nIY/REETs4SKrXRub4Uf7jx+gakp6XZpDXAjBfuqXiTGOvpSfq4BiamAQhd78abrG6cDWBtM4BpK0SeIK+0Yn0uC1zd56+GHoodwdneGA9+owoO6QYmwxd+bF3OmGQxvkIFUOqticFNfu3nU78S9lRVaXIJVYacIT9zcfAyf6QG4oRwdQxfoz50VKpy9HywH5vvP8txkJ9+Ubd+wD7Q2CN1yRGzmQy0jSH1qM4nZ0eXgEq69hbhyD9r1QoLEjAVREjuirCAzzywITnJC/LN7G8YzbVbPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KsQDMh32O/YwrbGCkYBeAKE+SuC3XibdGgrI9nqQww=;
 b=Pm6NVL8O6W3xFUJzWVW8VNRl36Qj66avYL9r9Ll0fdFORWcLjKdDxFrOqj4NP3kO8udevd3nIWj6WS5fuulZDqwt7Cblf4kSjmPNr+v7jpdr/6hREPhpBBjl37feQjW4qrFPDGdDRFNqGdOL958HGQ6neWhIsPA+WMdg7AryscI=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by GV1PR08MB8105.eurprd08.prod.outlook.com (2603:10a6:150:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sun, 14 Sep
 2025 17:03:30 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9094.021; Sun, 14 Sep 2025
 17:03:30 +0000
Message-ID: <750a06dc-db3d-43c6-b234-95efb393a9df@arm.com>
Date: Sun, 14 Sep 2025 22:33:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 3/3] mm/khugepaged: abort collapse scan on guard
 PTEs
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-4-lance.yang@linux.dev>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250914143547.27687-4-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|GV1PR08MB8105:EE_|DU6PEPF0000B61B:EE_|DU0PR08MB8954:EE_
X-MS-Office365-Filtering-Correlation-Id: 355519c1-16ab-41c9-29ae-08ddf3b0b642
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TjJGU1FrRG1mdjJCYVpQSlZkSVN1U3hFWjV3YjFzZzdiZjBINis4bGJHTExT?=
 =?utf-8?B?cVZ3a0tweDB2cWRxWERQNTdtQ25EclBHMElwZXhqNWF0OGtJSG1tSCs0a2Q5?=
 =?utf-8?B?VlUvNEFiREpyeWFYc2wydDR1RnVqeWNlT0NJME8zZjZ0SHhzaXdRdjYyOW5r?=
 =?utf-8?B?ekJuc1ZCVFhzSFpUT3ZkejZDTGFmL0lXRm5ybmFKYVJTTHVPa2l3b3hjc3M4?=
 =?utf-8?B?akw4L3VlRWRFZ09idlIxRFpMTWI1bHNOVkFlZjcrNDMrM1dmdTZ6eE1nZVdF?=
 =?utf-8?B?RzdGTDBkSGlrN0wyMG1iMkRmc21raWkwZFdua3lJNExVWGt1S2JJTDR3b0w1?=
 =?utf-8?B?Uzlucnl5VVRUS3g0c09PNm1SNUR3RkNCdWNYd1ZrWWNhd1U0VnU0cHd0eFVt?=
 =?utf-8?B?SmxrRGxUV21vWnNtNDZkREFzSzRyR2Fja25nV2g0RUkySTl5K3ZNMzRkNEFV?=
 =?utf-8?B?WDQyTmJ1OE1ObFBiUWxqREUwamswVk4ycW1maWw3NUZIL3VnUHg2TVd1YWo4?=
 =?utf-8?B?RnZMZ0REU2hOcjFQVWxZQzhMN2Fqdm1VNlZjazBkMjdEOFB2eU9MRzRod2pE?=
 =?utf-8?B?RGx5akl2REpNQUhlODJMWmo3RjlRNTZYQmdSYnErUG5tL2tlNTd2RzQ1dGdP?=
 =?utf-8?B?ZVd1Mi9ETXE2MEU5OHdpNUdFYmtEb3dxMkI5blhtaGJqSU5kM0orT1lwZnNv?=
 =?utf-8?B?ZWF4ckNQbmxLbmE5RUVvelRVZXZRRmNKQ2lUQzhkVHIvc1g1akxZZi9NZnNv?=
 =?utf-8?B?YW40OVZicXcrWk5UcGljeGNzTno2YlZ1V1F5S2NZdDlmOUVERUxwUWV3VUta?=
 =?utf-8?B?SW1wQ2JFRytTNnlRVFJVTTUrNTl6R3I4eURiWWk0SGR2dHpuUVVIS2x0L0tR?=
 =?utf-8?B?UVVETmwydlQ3Umw2dW5mazEzUmFibmx5eWh2TStzL1ZXZWxnTXVnQ1BIRWVm?=
 =?utf-8?B?a0l1Q0s2NHVGUmtrbTBkWlJNU1hLUU1pYWNTT0lMNm04STZYL2VtMkJvVHlW?=
 =?utf-8?B?bEdHU3plYW9zY1RSYnV3bXdoVHpockYxTGZxYjNaVTFTdHduNUcvR2hHeDVD?=
 =?utf-8?B?d3kxQ3JBMlIyQ21KT0pEWmdPUm0rSm1FVXNlOHZVeklIMHdYdG1hQzlrcFFt?=
 =?utf-8?B?enJmYms5YklKY1FpZXd4eUdqOHQvTkhJY0J0ZHJBWjM1aGVjQWQ4Y1g4MDZI?=
 =?utf-8?B?Mkl1dStlU3NadGdtSjhoRXFFQURCRUxPbXArWkI2NzMzR0FLVWV5Y21ydjBH?=
 =?utf-8?B?TjZXVDRBSlRKY0JxM1pSYzlUYm5vMVFoMnVxVU1OaGdHVlVPSTBZOVZia0Nh?=
 =?utf-8?B?STdLTDA5UGZZTG5aK3Q5SldWL2JFS0MwcC9jVGFZbndXME5ZYU9CTTFBZkxn?=
 =?utf-8?B?SUI0ZWxHeHV1NEZTUFJaZzRmbXlMa3RuZWcwZUdpdk5pbk5kRmJrU3JpUGxR?=
 =?utf-8?B?VzRkL2FtcTZ2NjR1R1JwWmJ3NmZRby80bFgwYllhMWpVbVpmOVZjR2VFMmhv?=
 =?utf-8?B?WW45SFhJU0ppdDJ1K3U3VzkrOUsxdnFRdnROeFE2YWcrdWdFT2xRQlJyOStk?=
 =?utf-8?B?ZHArKzhsUW1oYjI0clJrajU5aXlqQ2F1TzA2Zk8vdTUzbDNjNFRqTHdFd2lK?=
 =?utf-8?B?Wm85TG5YL0xiemtqUVFZTkZnKzFsZXhlWDk4SXIxWm1JMDNQeHl2OWk1RWhR?=
 =?utf-8?B?MWhvekVRVURzeUg1czNnaTY0NTFpUXp5UEQ2TXc0U3pPaVhCSUNSdUNraHdk?=
 =?utf-8?B?dExHL1h2cTdMY3ZON0g0ckZFOWQ0cmhqL2c2K0JSQjBjSEtyejMrbGY0Q0ZT?=
 =?utf-8?B?K0x1VkwzOUV3dEV5cDY3MlZLRjNQM3lFcVVmN0pPOUhPaHg2R3FGRDVPYlJo?=
 =?utf-8?B?S1FCZnUzUERmK2RnUVdsM1B3L090L0hnR2tpSXJIdDNoYVBPdFE0SFppMGdj?=
 =?utf-8?Q?CFNPMLUhWUQ=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8105
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	21f2720d-742e-4d9b-058a-08ddf3b0a0fb
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|35042699022|36860700013|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3R5MXJ5czdGamg4UnExaFBoYTlGa3RBTW1Icy85djExdWk3clN4Z2dCOEJG?=
 =?utf-8?B?a3RldElqTWZCcHdieFAwN0xJS2sxUmk0N3E1VndDU0dLRFVIWmNDb3AvWkRj?=
 =?utf-8?B?Zm4wUXBIaEgxUFk5NlB0TnJRbzdrODBHTVZXd2krM001YS8vSG1tdWhzUjZP?=
 =?utf-8?B?Z0tTYVRMald6NmQrOHRxb3cyZ0NxSk5POEdScGw0cmVXZGVnUllaNFdIR09v?=
 =?utf-8?B?NGhwMzc2VEhxMTAzTGxsRHlxQlRFditsVXJOL3RGdTk5RXI1cEt1T1QvZ3Vs?=
 =?utf-8?B?QmpnMVR4eStyN3QvZnJmM09nbExwa01WUzAyUXR1Qm1tOVpEbFJXWE1abWUw?=
 =?utf-8?B?NU9vRnh1NDh3eDR0WldxV0RlSEYzdGFTMWx2RjBzbThXWGFMaHUwOEd3VHVl?=
 =?utf-8?B?aUZhR3A4Qjc2U0REWEpnbExUUW1ndHR4azd2Ym5nTHkyZTQ0bldYS1VhOGNK?=
 =?utf-8?B?cVRlNzFRSjVoblZkWEtFaXMyK3k3S0VJS2N0TGRYcVJ4ZWo4L3k3OWZ1S0Zn?=
 =?utf-8?B?K2x2aTk4TWdRSFFJekFoR1M4c2Q3UytkY1dtV0NJQldCT0haaUNCZW92OHA5?=
 =?utf-8?B?TU5sVHpVbWRWeklLOUNnMlZhcnNsWWZMV3ZPcXAwemVVOS94U1R0TDhKRmth?=
 =?utf-8?B?cG80MnNNTGduM3N0YmMxeFFiVStLV2NMZFQ2ZFVuN2VPb05POTVwaFY2K0Zm?=
 =?utf-8?B?WWpoWHZYbmtlVmlSYzBlTStRLzdOZUJiZTZKUHN6cDl4eWFVMis2ZzVYNDAv?=
 =?utf-8?B?UWRVWHVOMm4raGZ3Vzl0T2lrVCtBWHNwNkRKLzN2NFZKTWZNdWg4REtKcHZh?=
 =?utf-8?B?RVFTMmpqV2JvMDBPaHk1VlBJem0vdXVqY0lZYit2R0VGQnlXbHorYjNUSHF6?=
 =?utf-8?B?TWFSbGhtdFI4aUFCOS83NVFMS09MWUo3RXB5WXgrLyszeUpmUTRRUHJKd2ZW?=
 =?utf-8?B?dkRwTkl5cmJ1dnp5Nk0vZVFtK2I2cWE4anJ3WXVnNU03aVdRY1FPRE5qNXdz?=
 =?utf-8?B?VENiRkVYd0VtV3RGeEVKSWVPR1paMmZGSy8zVnh5dzcrZG01eVRTeU9wU3JF?=
 =?utf-8?B?eGxYUGRsNHZRWE45ZEJXT0pVclVHTkpYTmhJRm9LaDJaTldpNXh3eWFReGRs?=
 =?utf-8?B?T25DclZLeVd1VHpyRTYwU0U1c25JOVFoclZqQ3FiWnhWYVJ5NlU1a0JDWit1?=
 =?utf-8?B?UHQ2UnlGN0hnSE1WZ041dDFRc0VxeEsyZ0c1M0VBMnVsTys4dWlPOFk2cG1X?=
 =?utf-8?B?NWxpbStKOThQV05XRlRIdGY4OWdLWVE2b3NFcld4RWV0M3plejFYbDFoUmIy?=
 =?utf-8?B?cTJGaFFlbGlaNlZWb3FhSEwxY01GM0xrc3pJSnQ1V2RlSXpxZjNjS05lc3pI?=
 =?utf-8?B?dmZ0Mm01VDRyYnpBN25XRzZyZWZhM2RPTmJWczdYWXRxQjhLSHQrU0hNaSt2?=
 =?utf-8?B?cEpwKy9idGxFUlpPNXVWbFF2ZllEQW9Dc2NQeFdHQWtFZHRYQWFQcWZSRE02?=
 =?utf-8?B?bDR2d2x6V0t5UEswRCtrdjBJYW5xN0lhK1dlQ3dMajEvcDF5TWZ1SkIxTFJy?=
 =?utf-8?B?a2pERWsyWXpJdHllUC9VOUc4WmpZSE5VNlRNSlgydnE2YTFaWDFLVUxmTVFt?=
 =?utf-8?B?ajJ6TWQyNTdFVk5hMWRkWXd4emxkVVY4b2VPd0x1b0pOMVBhemdZYmcxSFhM?=
 =?utf-8?B?TllMWU1MaEs2dlpiUm1rSW4rR3Y3SVJTUFdDR2M2ZkJpTlJHUnZKdHF2VG1E?=
 =?utf-8?B?VUFLRHNOTFJ5dW9MUzczSmRSS3F3RHV4NjdSOVBaMFBTbkJkNkxMMitnRDNi?=
 =?utf-8?B?MEEwbGN4Qm53MVlQYVlrWG15TU1QelhrR0wydDJBT3liUDBTa3dXL1k2TFNr?=
 =?utf-8?B?cGw4clhiZ21GUGpVREpVVllQazA2dHFkRnd4R0hSbFZXZlRnSnpMclkyV0tX?=
 =?utf-8?B?djYyR1puaGdXbklDNkM4NWRqa0FjU1hWc0hoREQ4U1dTZzl6VEhWMXFyQnll?=
 =?utf-8?B?dSs2OE12SkxkNG4xMm13ZzRMMW1ucThDQUZjNk9pUEFHL3F1ek55NGkyMmtO?=
 =?utf-8?Q?lOQtON?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(35042699022)(36860700013)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2025 17:04:05.3011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355519c1-16ab-41c9-29ae-08ddf3b0b642
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8954


On 14/09/25 8:05 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
> lightweight guard regions.
>
> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail when
> encountering such a range.
>
> MADV_COLLAPSE fails deep inside the collapse logic when trying to swap-in
> the special marker in __collapse_huge_page_swapin().
>
> hpage_collapse_scan_pmd()
>   `- collapse_huge_page()
>       `- __collapse_huge_page_swapin() -> fails!
>
> khugepaged's behavior is slightly different due to its max_ptes_swap limit
> (default 64). It won't fail as deep, but it will still needlessly scan up
> to 64 swap entries before bailing out.
>
> IMHO, we can and should detect this much earlier ;)
>
> This patch adds a check directly inside the PTE scan loop. If a guard
> marker is found, the scan is aborted immediately with a new SCAN_PTE_GUARD
> status, avoiding wasted work.
>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   mm/khugepaged.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e54f99bb0b57..910a6f2ec8a9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -59,6 +59,7 @@ enum scan_result {
>   	SCAN_STORE_FAILED,
>   	SCAN_COPY_MC,
>   	SCAN_PAGE_FILLED,
> +	SCAN_PTE_GUARD,
>   };
>   
>   #define CREATE_TRACE_POINTS
> @@ -1317,6 +1318,16 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   					result = SCAN_PTE_UFFD_WP;
>   					goto out_unmap;
>   				}
> +				/*
> +				 * Guard PTE markers are installed by
> +				 * MADV_GUARD_INSTALL. Any collapse path must
> +				 * not touch them, so abort the scan immediately
> +				 * if one is found.
> +				 */
> +				if (is_guard_pte_marker(pteval)) {
> +					result = SCAN_PTE_GUARD;
> +					goto out_unmap;
> +				}
>   				continue;

This looks good, but see below.

>   			} else {
>   				result = SCAN_EXCEED_SWAP_PTE;
> @@ -2860,6 +2871,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>   		case SCAN_PAGE_COMPOUND:
>   		case SCAN_PAGE_LRU:
>   		case SCAN_DEL_PAGE_LRU:
> +		case SCAN_PTE_GUARD:
>   			last_fail = result;

Should we not do this, and just send this case over to the default case. That
would mean immediate exit with -EINVAL, instead of iterating over the complete
range, potentially collapsing a non-guard range, and returning -EINVAL. I do not
think we should spend a significant time in the kernel when the user is literally
invoking madvise(MADV_GUARD_INSTALL) and madvise(MADV_COLLAPSE) on overlapping regions.

>   			break;
>   		default:

