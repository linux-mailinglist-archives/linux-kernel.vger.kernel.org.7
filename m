Return-Path: <linux-kernel+bounces-770305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F1B2798B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B80F1C85F08
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86BC22126E;
	Fri, 15 Aug 2025 07:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iHS59yQt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iHS59yQt"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013026.outbound.protection.outlook.com [52.101.83.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF29217734
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.26
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755241369; cv=fail; b=SJSTQC9qBAG8uaqaLE2aKOxJehwjDD/mnnXBBqJ+1lsr+AEdySKYqxABMg2r7e80A6HZM+FAq4dUoBvCt5X0MDbkA+JruEtIClS5Q4BUZtUNVx2qfoAg3sW1vpiyVC4mcIjVzfm71Q9PX1fI8ANQtv0JDaY2IAzkeiQYFFcp3ic=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755241369; c=relaxed/simple;
	bh=o3opihwFVE5DP65TFPDyXTyzan0srqV5xgIFoPaqpss=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rx8x3Z4VzOWbRQGbekdAx3KJZl9b+I9rsVqXBGg2ZN1yf+DHaNtdOXPwHHBxHfFNrAxZUF7DU1hGUtZ9k3EBA41mmqLBiNhrpAMkVNZBQkco7aNnQsNi5XghasyrcPBUbHr7UL49NJmGO6/KmCu4tklB8I4v460B8YothjlbT6k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iHS59yQt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iHS59yQt; arc=fail smtp.client-ip=52.101.83.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cJwEEX+kN04Lxkzv27eYeXMOjupRTI8QWnAJ0dZVqauVinf6zDhWyzSnNl1fVXuLz8UeSeGQCRg3hvQgvPpnHYrjFYrDEUglq00FnjnRo3magtdDv8viIPG+B3gAQHXNa/rL+TaS2uAADAe67+tnoBv6yDJhI3KWrk3vlaaMhL0aPQzcrwTfBAtLWpdMC4yjc48BoZKgrmPyYBIpK+xArbBbjkc2GP21REmRCaUqPhJE7P5llWXVZGhtzEEycFZJVt7APv4vdv6MeNAGAVG1OK0cnlvO5Xmva3pu6QhPe3PMhLTtj418l36n1yozsbiBpcR4FyqpxuPdJ0tSGZMtjw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8O8YGD68aP5zNzl81mjJq3NVjiGDIMEwSraWrW5mgA=;
 b=VreXNi5rpgP4V9YoF6pJ/as0lDqC6HiU8qY2nggbS2H40ef6tfLCvVGooa9/Z5I5hgaxxivQTXhTBcNS5Be4PQV21ebPVvIuGL6bCy9I10E1vj0IEF3JfoH/Ad6dw3nBSH3fIfR5CnmBahP7wQc0MTCehMbrjKJKZuQv4q57werrgvyG4/emDu3WOS2EmY4d+fF1bxIgLFsvIVJG6e+klMFssBfG83kMCRz3lwSQTmJb9TBs4k6DUHgEx6cEdPRKEXVcxdirelMR08OQSV67ZmAFTw9pCyRu7+QGcZrUYGz1uqfCH/6GQlF6UJXqMQRLQnKZeE12Eje+O8QUwC5c4w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=baidu.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8YGD68aP5zNzl81mjJq3NVjiGDIMEwSraWrW5mgA=;
 b=iHS59yQt983mhCwoR1EabtrocVnIu48L02w6OTqta/YvKy4lu0k3b+D4SN+H9GfCOaBpc9GOyfk4jfSsbZPOIZ3D1OQYZrcMmyG2ytB3BkbGyCLMaVIaGN18BM75nS8k6D7Pr11QDQOtYRNFSb9GZ1o3b4xhbZ9kSCexoJ/WQnY=
Received: from AS4P192CA0008.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::6)
 by DU0PR08MB9049.eurprd08.prod.outlook.com (2603:10a6:10:471::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 15 Aug
 2025 07:02:42 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5da:cafe::4b) by AS4P192CA0008.outlook.office365.com
 (2603:10a6:20b:5da::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 07:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 07:02:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX/JwC8aFD+p87XFdyX869ocA9mngOrap2HRoMOoKHyYIhms+AGSkCCrPhkDa4vnk2so7yNcPNN+6cfm/ejhBWnvZqQ0D6fbSRld9JlXGMPYjFUprY/MLSW5YcxLhfHY8tQFDiCyemaDAIaKflzdqZ2Lg9anleW9CC8GxAnFLPUDqM8d+g6TqW3TtdGusqGrLJiZurkCHziZF9oPWBuAX1hztz0LM6PTu493RezeeCIpYDlCjHm5TeSjoVGiNnHB1aFI1AuE19nKcnDi/CIWzF3r5wiLARFfKZJyke5rDTpbIeK4lPqMMQsKFxJmxQ+c20PBg78Tlza3Xk7/hzUWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8O8YGD68aP5zNzl81mjJq3NVjiGDIMEwSraWrW5mgA=;
 b=u/RO1/eUxE1yqLWsv7vry2+4BTXIQLkxKTDmh24jGdCJ15lYbXlatsUqFITvAQ22uJ/ldVF85t1CFBuudj40HmkvB3eCBW+KQE7DIOOOgqNZIbOaSFcZ+4Qoj0NWIIEm/4j2t8D+wTXdEMlxCcnVZfHk9WfcTSeKlIQcUyxe6b971mEl2jc/hg85hoeEaXi2tFHunF8o49VA9qQYpCIPyWCuUeECTbv8PZpvLt1Y8H7OBEjH98059efL7JOvBzsGsbgvDISj2krbW+qYv3Y3UdwQ02A3S/cL2qNIgRuBoXHb0DqW9UcLFDn3uGx+NYv+Rq9wDOMz6IKmrzq2oIXx1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8O8YGD68aP5zNzl81mjJq3NVjiGDIMEwSraWrW5mgA=;
 b=iHS59yQt983mhCwoR1EabtrocVnIu48L02w6OTqta/YvKy4lu0k3b+D4SN+H9GfCOaBpc9GOyfk4jfSsbZPOIZ3D1OQYZrcMmyG2ytB3BkbGyCLMaVIaGN18BM75nS8k6D7Pr11QDQOtYRNFSb9GZ1o3b4xhbZ9kSCexoJ/WQnY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DU2PR08MB10015.eurprd08.prod.outlook.com (2603:10a6:10:49f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 15 Aug
 2025 07:02:08 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 07:02:08 +0000
Message-ID: <60418a4a-0c7e-4812-967d-036c6cf48a43@arm.com>
Date: Fri, 15 Aug 2025 12:32:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][v2] mm/hugetlb: early exit from
 hugetlb_pages_alloc_boot() when max_huge_pages=0
To: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250814102333.4428-1-lirongqing@baidu.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250814102333.4428-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::14) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DU2PR08MB10015:EE_|AM3PEPF00009B9F:EE_|DU0PR08MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: d222eb96-a677-4cc4-ba7f-08dddbc9ba1e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?TlVrRU9QRWhlV1c4NnozYUdubTgyV2xQU1c2OGluVmplay9EOXhWUnZZTUtL?=
 =?utf-8?B?TGR5QmlpK3lsTE40aW5RUzBKclVEZEVpWlZ3SmN1OThXZnNrQVcrS2R0T2Iv?=
 =?utf-8?B?cThNTFl1eUtCQkloNkk0aXBPM0NHY0RBUzQ3bUNBaE9sUzBGL211bGtOTHRZ?=
 =?utf-8?B?MHgxdW95b3pWVUJwSVQrdnUzclUvUEwxS0dobFk0Sk8xNUJteUdTdHFTVlc4?=
 =?utf-8?B?d0MyS1JuamJPaGZBMWFRSU5NSjdHVlBKdmE2bFI4ZzRsdkhTbGZGNnY0cU0r?=
 =?utf-8?B?aGhYQlFSL2sydEdYbVEzQWpxWHpmUHViTHZpTXVrd2NsbHIra1BNZGszZzU5?=
 =?utf-8?B?QzUyWEllY05PTDBwK0FWaDJwdjNqdmFvYkVEQlFiUG1DQ1lWanJERUNyVWNk?=
 =?utf-8?B?Z21tbFE5UzQ3djVTRDZxWld0TjBGWEpDdVJMZkJHcTlodW9mRWY1U093bERq?=
 =?utf-8?B?OS9uY1RPQ2xIc2VUWEZxTzRSSUZSbnF1V21PNEFodWtnNE91YWJSSWt6NG1G?=
 =?utf-8?B?aHBUblpIRFFWOEtiWVNyZHE2WE1IV2NKZHNTTTh1Z0RXTGw3TEkvOU9UQUEz?=
 =?utf-8?B?UXR5WlgzOUlZYjJKcFdIdXMyYkFmWllRZEk4bTNjbFFJeFFtR21yUTBLbVZR?=
 =?utf-8?B?SUhRVUFyaDlNaEFTUFg5azBBQURyODNaUi9MWDVaWVhHbDZCdVo2Nmd6R2JS?=
 =?utf-8?B?UFdpbE83QXRPbk5qcmNCc0c4dG82OU9Eb2czcXNaOUVtdmVHWVViYUcrVlY5?=
 =?utf-8?B?VXkvTUlWV3ZYNUpRcWxVV3QvTS8rWXp3SjBHMGU2MXNEVTJqZldoN1dQU0xO?=
 =?utf-8?B?Q0p6MmY0Qm5JdXdCbzhaWFZKT3JYTzhhMjEydHY2RXUvVmMzbDZHTzlFOVpW?=
 =?utf-8?B?VzVCNFU2alBDMDNYL29YZUVnankvMTRkbFY1UHlOd3E2ZzQ3b0xrMk52dm92?=
 =?utf-8?B?eHlrZE9pYWRrUlV2aHRub1BGSXBzay9LdkNOL0hWVXI1Si9tVjdnZW1YT0xX?=
 =?utf-8?B?NnJSWk92THJTeXBlL2lmdmxCUWt0QkdXT2Jsb1VOd1J0d2VTVGZubnIzN1Vs?=
 =?utf-8?B?aVZtb0RJNzlyT3BIYURyMWVQaW5UdjE5bEw1QkpnWERUQjQ1eTNGekhRQlFP?=
 =?utf-8?B?ZWpZUDl0WFFhREJiUEh6NTN3d3VDRmEwWFlCY1RkMG1kejBBSU0rWjFPd2dC?=
 =?utf-8?B?WGhrRVhTNkFVdkh1NzBHYUJrRS9QL0Y3RTFtY29lSWpFUGthbnZtYUk3S0JW?=
 =?utf-8?B?WTBkRmhoTnlnaVdqcDNBdStQOXRyYUlCRjBEdWVpVng5aWRDaGJYUE8rb09N?=
 =?utf-8?B?aDJoY2dFTnh0MXNGVnQrUm9GVFJKMGo0VyszSlhFL3ovQlBSQ3Z2M1ZjQ2t2?=
 =?utf-8?B?RkZOTEtkaGxCVkNqWjJlSzFvdkNuNmRIMGs2eGh0YThHbXJLMVM5a21zalNh?=
 =?utf-8?B?eHVzazBldlZJd1dKbVlZVFVVK29leUdxVFpCR2RVSnJuZzNFSGlCSFcyMlB1?=
 =?utf-8?B?MExLWWxnOWJoNjdsUXgrMndJTGJvaThnU25UUDF3ZTdCN1JsYmVwRjJIUXpF?=
 =?utf-8?B?aFo1NzBqVXlMTHdwbkFaRUN5NmRPQkRkNzRiRytHZlFqbXk0NEZ6MGpqaFhv?=
 =?utf-8?B?U2VoMVBVTzBPNDEvakYvRzlwaVN5UE5CcENkeHpQeWpKcVpqaTNjS243SGl2?=
 =?utf-8?B?bEhtenl1NFA5bmttcStSS0lhOUkyRXpZZGM5dS9RRlpMVFNUWStSWWZmWE1V?=
 =?utf-8?B?OTFTSlA2T01WeVNNcjZuZFdEVDZoZEFnckdSV1l1S2tZdnhxem9rK09OZk4r?=
 =?utf-8?B?aEhEUlJudEh4alBNa215djMrZUd0V01SZnNWNnE3eGQwa0VobkJyRVRBZVdU?=
 =?utf-8?B?dkZ1ZlFVeTM2QUZOZVZqTm1uTDVPMTlXSjIyREt2OWxQVCtjWXpJS0krN2Rv?=
 =?utf-8?Q?3cp7yd9vR9U=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10015
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	edb3e26b-3a91-4a7a-8823-08dddbc9a62f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|14060799003|82310400026|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RU9QenhlbUdweWg0K29CdlhBV2FxNlFZTyt4MzZlRVRDRmNlMjlHMmc4dm5k?=
 =?utf-8?B?cTZ2SytLN3ZpREsvMlJFZ3pVMXJYdTl1VDlxVXpwQ1g1WHFaSVVSUmthNUo2?=
 =?utf-8?B?eGpuajhmUUtka3o5SG1CODVldE5JWUR1cERoQUkySDBWQzJXY3JEUUZzTWRK?=
 =?utf-8?B?bHZZbG5sMElGRjN6KzcrdnIweVNUL2t6VGNMNldqdmZTN2sybDJWREc0Rm50?=
 =?utf-8?B?UHUxMk00S1pWbkJuKzBsUHFQWkQ4c05vQmFwNlgzL0NBc1hPaFZyR0xHblgw?=
 =?utf-8?B?Nm1MZE9xL0tDb20ySk9SeDBjakFTZE9SRVZWTWo0R3Y0VG8va05qV01rWk00?=
 =?utf-8?B?S2JiaGNacnBkMWlUcnd0c3pPWnNQSVFjL1Z0bmtiVkwza3hQbU1EdDdYWDlj?=
 =?utf-8?B?bnpWZ0FRcmVuYzBoQ1MyOG9uOGRnNUVZeUZDcFM2a2VqcXJqbXcyRExHNVh3?=
 =?utf-8?B?a0tPYk0vYzJmOW5FUGVZL3RqWnFjSkdWa21PcmYrZGs2UUFsTDd0MUFleVdU?=
 =?utf-8?B?VEl3MDBPTmg2c0h3RVJmZjJkTGZxRjFlNlJtT3ZUSFVnSCtzVkc3eGF4UTQx?=
 =?utf-8?B?SUQrQjlHa0N5cFYwamZudVh0eGVoNGUxY1ZKeXBQVzNWdTNmWUg5ZEdFL3B5?=
 =?utf-8?B?Y2J4K0VmQk4wV2lCQnppM0JpcklyRnQrTklaenkvbWxKalVmTzY0cXllSzRZ?=
 =?utf-8?B?NE9WRmgwcm81WGxLT2RUWmRRcjE2eHZGbVRmdDFqMkJFOWlNOFkzclVTQmxE?=
 =?utf-8?B?Y0ZIRUNwdXI0U2cwVkZseEZ0Wk5GWEtaTm82Y1ZNYnZUWjJxckpSd0dMckRj?=
 =?utf-8?B?cktBZUVlREdvYzJmazhrZGs5QkhGRklDRS9BaEN5K0s0SHkvYklzRXZjbDQ3?=
 =?utf-8?B?L0FENnBKaENuNXh1bWJVZG53bFArOG5LV2kraGxOVTFVZk45d1lFVm0ySld5?=
 =?utf-8?B?SUN4ejJkV2VkQnBSY2lHUlo1OGJmc291d2x2TkRHekd1K1JJL0RteFRubzhU?=
 =?utf-8?B?azNldUNsc1A3WEo4bUZBTk95MlY3OEVKb09GNXUvN2wrYkVjSjl2SVF1UWxt?=
 =?utf-8?B?ZXNYa3JJNmN2TnhKaGc0aEdLbmJ4emhpREkzTTZQdW9VYVlvb1V5OUR5Vm5z?=
 =?utf-8?B?YVhlOU9waVJGR3hpOUNnVUtlWkVPNHZQS2FrbkxUd2RQMnlRN1huRDZPQXZY?=
 =?utf-8?B?UmhoSmE1VUZtOWhXNlhYa2VOV25xUmhzcE0vNnNzY2lBUXZVamxsOTFoN091?=
 =?utf-8?B?akJ2czhobk4yUUw0QWE3UjY0MUxKVkxhUmtmNm5XVVNDRm0vcjZwU0I5UXV2?=
 =?utf-8?B?UmFPUWtiUnBSa0pPRFc5OW1FMnQwKzRndjBINGRuUTgzeXVzNEVYSHpTYnph?=
 =?utf-8?B?dXJXU2ZxL2xlZ2JFK3FsUUgwaFJ3cG9WUG01eDJ6YXdEK2w3di9uSmVCLzNz?=
 =?utf-8?B?cWd2bEdhcHBUWVk2enprQkxGN1lNNHdLdC9HZTcwUDN5VVZFTFNoNEdJS3RU?=
 =?utf-8?B?YmtVOWZ5aHNsYkFEWW42ZnE3cEFYRVpSZVVBOUZmZGJNVitFUUs0Z2pGN2Na?=
 =?utf-8?B?QnpPaXRZaXZRWDdMd3IwZGlQdXEzWlIzbkJDM0s0YmNsQXNlTXJiemQ5eDJS?=
 =?utf-8?B?b2lrMHduR2hXcGRIbWdXek83eU5OakhZRlg1U2ZKTVErSzJpb0JEZGJFTDdS?=
 =?utf-8?B?cFJCNkNMVVVhaXRYZ2VyM3QrOWxGKzROcUlCU01aajRxcW90cGRiK050aUNM?=
 =?utf-8?B?RENrOGl5bVFtTCtiTzl6S0c2R1h5Yk9kelRFYVNlR2IrZTlITExxUVVRVVk2?=
 =?utf-8?B?UlJteWMvRTRERU15Mm1HcmpvWXJsZklqeFRQY2t4SHBsUjZzdkJ3OGEzS01N?=
 =?utf-8?B?TERjUzkvc25kSVpENTJvU1UvUXM0ZXBoeHZzN3BuV09GUjhoN3N2MWNsSjVy?=
 =?utf-8?B?bkV6NVFlcEkySnBwVVRzSGprcGF5cVFOK1V2bmdaVnJKSmttaU1RMVZRMFZj?=
 =?utf-8?B?VXRzTG80a2VuL3VzemZIanpFN0xJU0xaeTJsRGJORU1Yc3V2a3l6YXdxMCs1?=
 =?utf-8?Q?EiaUS6?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(14060799003)(82310400026)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 07:02:41.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d222eb96-a677-4cc4-ba7f-08dddbc9ba1e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9049


On 14/08/25 3:53 pm, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
>
> Optimize hugetlb_pages_alloc_boot() to return immediately when
> max_huge_pages is 0, avoiding unnecessary CPU cycles and the below
> log message when hugepages aren't configured in the kernel command
> line.
> [    3.702280] HugeTLB: allocation took 0ms with hugepage_allocation_threads=32
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> diff with v1: adding the reduced log messages in commit header
>
>   mm/hugetlb.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 753f99b..514fab5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3654,6 +3654,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   		return;
>   	}
>   
> +	if (!h->max_huge_pages)
> +		return;
> +
>   	/* do node specific alloc */
>   	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
>   		return;

Useful change!

Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Dev Jain <dev.jain@arm.com>


