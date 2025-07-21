Return-Path: <linux-kernel+bounces-738656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AA7B0BB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B07A6060
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CE620C461;
	Mon, 21 Jul 2025 03:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W01Ap/aA";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W01Ap/aA"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A91FFC46
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753069499; cv=fail; b=sQLE+FQEHcxA44KfIrsKq/OM4iQVadCcKrSb6RNHTQRIE6cQCbn5uZlU6HOWbJ/fAX9a5wgoFt0+KiVHleA1nNN5SKBqo+Xa2KCKGKEhWC4L+rwjtsT7XOj/8WIRfXHP0JiYVuPnAhqgZohQPQiqGM0ON/xCEoj6AnZPq+wLtTk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753069499; c=relaxed/simple;
	bh=tCkT42yG+VkN1ODC/a6e89x0fbGRBXO+o3JeOW5qELQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ml0xb9ljc+/vb/aM7DF1+Hypx/r0AgHS+kQenrxvC0i3lgVyWUpkqbkhiUiH+ecWSCDpFX4mJk6vb9VWILqRfNvB7ERhUnF9VDDBvi9xtB1V8vdRHmqC8JnB/ip9lQTJfgk+Y8cEHLnQtT24OM7arQsPU42S3/fe/fx/A1af39o=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W01Ap/aA; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W01Ap/aA; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M4Wr6UJL7ukEzrMR7yweoydG3d1fzk1+0APHTFMlMi94T7WA2c21qUUZiLYomm7SX6BBCqYuJrsR+eOug1ZTDZRu2GEWoxmQmfU1cfp/x0wz3irmTRM6CG+aE0HhrFD+5BvwimYVSmL6VkzcDsIyndXsnjN+QBdxm4MVAoYbL+W5G5+ZNZEFaDrKPFYiuQCINyPF70xnuw2VjpQnVsDjX8taGfOA/QEUyDXM5edI63iuPDi8gJ64+Yx6E/GbDICWvnhgQffBVXCbAPo/yIcZZ7/lBbume8MHbswz85Er8LDc0bFDvBtyhLsty04oyEDUbhAybMbMqGEw2aR29/5KfA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFIycobpfS5STcottL/lvBYj9K/8obUtAZcvTAkxv2A=;
 b=CFn3GStgOptB2goKO8dMPanVquohqimFgYJJXfgnqcPWUWRz8G1VyxIoWib1qkPYBrEWAs+AcqppTgqPtoBqbsVTfn5y+ZGQNC39DXXthnSiP3idQmPTVJYwvV0MwQOQ3OEFDoJMdfSWQt5QaN2rJ9Mc6PHziD/+EbuTyCGrVHoAcA/M76LQmNAUSf9znc+1V5yOamH6HLiSjGKKgmQxFz4LeUEoyp6J+MvMqF90/nYJJcbCcSa4Lf7QhEGkTcJ9XgrHeXL+Aby7JfON/FVsJt9TIGFIE2ixnok9Td7KxAX4+c3uy200TXiwLftMVwBmUlcySwS7F2zMn0QwcZO+dg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFIycobpfS5STcottL/lvBYj9K/8obUtAZcvTAkxv2A=;
 b=W01Ap/aA2ibejAfHTDQPLuMwcQnKwFx8WDX3cre9YEc+7NXWX2ZJeCrQtRMUCqXU8on6uDQAMW4pUoZEv2Cy074SapeGWaEKoQdpONjlgPlQ5oAn9b5qAuInfLHQNvyPul4t1Ag1BnDv4WfedymI+2OTRsYYIzK2dXMooiT5L6I=
Received: from AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) by VI0PR08MB10757.eurprd08.prod.outlook.com
 (2603:10a6:800:1b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 03:44:49 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:208:10e:cafe::ec) by AM0PR01CA0085.outlook.office365.com
 (2603:10a6:208:10e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 03:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Mon, 21 Jul 2025 03:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+6veT9Xpe+Z2qB+R6VtG/9V4SET0KzBLz4CfHGrMsEdB/veGzg7HMDF7Y769p0iJViD/agbpZDR1A3B40ww116gdn4poAydhCOBhs5WjKrhSqzwRut9RFRBvf0Eoy70eQdfSyy4V1Aj1gkVQyuT1d/priuRXXRXckYf4LtXWakYCjMbKJzM3+pHwA/LsAR/qukyQEd11kmiA/qNJFztHfOSNoIu5X+gVHKnnkVSGRzZcgV8X4wurr2sEuwOFgrJC6KaBr5pIANCWXCkMprUtU1JAG+GzwbwZgwrPzsKzudmq3qH5+TLspoo2Rr/zI3+hRVyLyW9TC/tqlkU5rQwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFIycobpfS5STcottL/lvBYj9K/8obUtAZcvTAkxv2A=;
 b=DfP789Y1UR1pX6JAifyz18hnPnK3J+jJ+1OTTIuAwproxo4ovH2Z1LsBpXcLGHtIC4gUdx7VMsKxOiVjtRM2KaF+iT56KD4Njkpn41xy1569aAoAggbO9ggLY3uqPg/udI7uxlLKpwNP17FnJVtoz9NFDMIenTZ7JYoOa9HiET46gNzXVImuj/lJuJbR4NuGWM/8Je68QSvlGcD1cz6dLsytGIYbLrdPNkNwgRHikjQrJwm4tBlq1u30ve1TpkPPMFzz6nt0PIDa1ibv+exASYAs2ngX9k9YE+e8+5sZQWQYPGnLGAH4N1XI//Cvqa59V3NBtN5bCw47dbeg0V5YNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFIycobpfS5STcottL/lvBYj9K/8obUtAZcvTAkxv2A=;
 b=W01Ap/aA2ibejAfHTDQPLuMwcQnKwFx8WDX3cre9YEc+7NXWX2ZJeCrQtRMUCqXU8on6uDQAMW4pUoZEv2Cy074SapeGWaEKoQdpONjlgPlQ5oAn9b5qAuInfLHQNvyPul4t1Ag1BnDv4WfedymI+2OTRsYYIzK2dXMooiT5L6I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DBBPR08MB5932.eurprd08.prod.outlook.com (2603:10a6:10:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 03:44:16 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 03:44:16 +0000
Message-ID: <d0163616-eacc-4ca2-9816-c577e710c5bd@arm.com>
Date: Mon, 21 Jul 2025 09:14:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] mm: Refactor MM_CP_PROT_NUMA skipping case into
 new function
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
 anshuman.khandual@arm.com, peterx@redhat.com, joey.gouly@arm.com,
 ioworker0@gmail.com, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-2-dev.jain@arm.com>
 <CAGsJ_4y1rJ7Omv-8ADk-cZdkAA37bxOxaeM3-vpz1MMaT_G04A@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAGsJ_4y1rJ7Omv-8ADk-cZdkAA37bxOxaeM3-vpz1MMaT_G04A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DBBPR08MB5932:EE_|AMS1EPF00000046:EE_|VI0PR08MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a02fef-286e-4799-9c7e-08ddc808f15b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WDR6MzBaT09zMXJNYkhabk1QMUF2TWFNRWtNNERWZms2aVJMT2hCUzNkdXdl?=
 =?utf-8?B?djlESmlHVTcrQzIxVEhjam82cENxVHNidnlIYmNQQjlvQ3NjL2pDRHk2b1pJ?=
 =?utf-8?B?UjczOTBxNm5abWUvc09XeUVKd1VPUWZaTm5ZT1Vzcm40d1NzckdhS1pMZkdV?=
 =?utf-8?B?NW5JUys4OEQvU0JkSThldG1KNDM5TkpFcHN4c3hiOHJ6N3pUS0RrQU1QUzIr?=
 =?utf-8?B?aEZNWHJhcEtENjkwSHNaYmsxT0k0b1hnSGtqSDhFSGt2MWJQazlPNTZlTVVN?=
 =?utf-8?B?RXN1cCt2V1hRMloxWlJJV0hhbUdLdGZtNkZDYnFiS1B3ek5iK1RvdnN6VTl3?=
 =?utf-8?B?bGl3NnJTRGxsRE42YUhvSHZ0M3BZY2J6TjhFYXBEZ2F3enBMK0ZZaGY0TnFi?=
 =?utf-8?B?Ym1Va3IybW1nbGZSSWZZS1MrWS9QUlZScXp0M0krVVdQVlBxL21yWmpkVVpF?=
 =?utf-8?B?ZlhqY0Uydm9ad2R3aUpKaitQVWwvZ3I5SlpvNGZCU2xTYVgvMlk0Q3A5RXl3?=
 =?utf-8?B?NDBDTzJ1ZTdVQ0pzai8xdURVQndZSGxGRmJWd2E0TGt0ZWNyYTUxWGVycGNm?=
 =?utf-8?B?dHc5bFgzRzR2ZXhlS1lzckhxUWMvNEQxc3RhRCtmanpha0hMSkZ4bnFra0NK?=
 =?utf-8?B?emp4OGYyaDNReHFXVm5BbDhjTU1BT1E5TmQ2WXVHYzNMQ2t0dk8yekZBZ3RH?=
 =?utf-8?B?OUQ2cmgxdjlMUXYrRFpSZFRHWXA0bmhrVnFOaXJKeWpldWpTL2tmZndEV3Jp?=
 =?utf-8?B?Z3dJK3pyU0JZRkdIanF5OXI4TGVjeFU5NGtLc01mY0NSUnRWd0h6eURDbDEv?=
 =?utf-8?B?QlZ0NTlHbHhZeHBGYStWWENjVDVvNytSVTlUQW00QXhSSTFlbUk4R3A3SlIx?=
 =?utf-8?B?cDdjNjFLVkI4THQ1a3FGMUJVWEIwTWN2YTQ4bENtd0pmNHRzSXp6WUhVTG8x?=
 =?utf-8?B?dW1ESlhVTm5aVXljYkdsdStEd1RKVU4yUE4rVUduL1FzellhRXhQWWtNcXhz?=
 =?utf-8?B?VXF5UWJodkEvTVB6dFhuaC9EcVVwd1NXRG1oSVlERUszM1FFeXR2VVg3YzJX?=
 =?utf-8?B?THJuempNMGpSNTlXT0U1ZmZqN0ZoTiswcjZSOUtPWDNhRnF4K3dDUkdlbkhn?=
 =?utf-8?B?TnR4Z2kzUUFmY3IvdG8wLzVyNDZLN1NwZjlIN0FCbjlCY0tFeC9ZUGEzU3Ev?=
 =?utf-8?B?QWdsSnIwWk9qTWh3NUE4Wml6M3IxME0yNTNlcjREUnplZmcwaGhBOERHVHli?=
 =?utf-8?B?OURYWDlxcE9qQ0MvbCt5NkZIOGp4S00xRXV5bkZTVjlnL1RZcVN2SGhUR1dU?=
 =?utf-8?B?L1JRdlpWV3A4VHIvVnNDcy85WmEzaU54bW1HMVNVSUtnRU9qMzRyZnJmUVh2?=
 =?utf-8?B?RkZLaWF6ci9YMzZTbTNSaS9ZSUFYM0luWWdnQ0NNUGJRMVNOSnF4OG1VTmdj?=
 =?utf-8?B?TmU2aFhSSWJYVC9DMy9MVWxpTnZGZEFXZUJmQjlGOEI0SUZnZHFTckxKSUxK?=
 =?utf-8?B?c2dwai9hNFZQdFJCQzd1cUlyWTF0eUZTbEc3bm5CYlQrcklnNkdxdG9Bb1JV?=
 =?utf-8?B?S0lHTHFwOGN2RGUrMFhOcGtjZ3hFWHNRQUx6SjhnSGxXemxMY0Q2cjVqZGZu?=
 =?utf-8?B?RFFOWGdyT2dKYUVpMURRZHdhb3lHZklYWEZsOVNTUm9BUk5MRDNFWmc0cDJF?=
 =?utf-8?B?VitDcDZLY1VweGNyZUNaSmVDM1hwUlc3ek9NL3Zoa0dIdDE0U3FUdzlEL2VC?=
 =?utf-8?B?SnAzaWZDUFZaUjBIZ2g5QUVyR2xsZzY0dGVoSlN1SSsyUGR2TmJDRFlvQUE0?=
 =?utf-8?B?WUZnRTQwS0E5YXI4M1hNQ0dSaXdyTGZoeEQycDlXMmlTNUw5elFqQ2pSYzBa?=
 =?utf-8?B?SmlEQjZUYnI1Rk40WjR5dHFjT3RqMlNrZDNJb1JXTVRBT1hpWWUyNHc1NVUv?=
 =?utf-8?Q?lOrII7NOUdU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5932
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	62dfafd8-5c8d-45bc-b385-08ddc808dd00
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDhzdmhkYU93YUNpOEZZY2VyRzVyVHZiR1ZhcW9zcXE5SEptcGp2SUhPU29V?=
 =?utf-8?B?YWphdVJKb1VBUDZRSi9MdTdhYkQyWUZzTHE1NEsxTkNZRE1nQzA4d1o4bjVE?=
 =?utf-8?B?YUNNckFTNG9TTEFvMEg0WGc5bjRTdk5aaWhwejBTbFFnN3dSY0hmUUVwbzJt?=
 =?utf-8?B?eGhJOExZZmZkeWk3cTlsYW9LL1NRUnh6WHZJMW5WR1Y3MkxWMlhlQmVQQTlt?=
 =?utf-8?B?MEJjOGw2WjlFWlFZSjNxbTBvbmhvUWtFQ1huSEMvK1l6ejB0YnJ3NHp3bjF2?=
 =?utf-8?B?Y2NJKzN0ODdMZTl1YXZEVGVkWVoxT0piYTNrbXhnMzdBZVQ0cVZXOTdqSWdT?=
 =?utf-8?B?dTVUN00yY2lEMUdTMTZ3S2g3U0hBUHg5VGdNQzJSeVlLZnBxSTZXTjFxRVQ5?=
 =?utf-8?B?Zk1LalJvZFpOQlpQeHhHNk0zd1Y4YlVCV1VGdHdPcnNCVno4WVl5NmE1aklQ?=
 =?utf-8?B?OXBGYVVWV2tJaTlGditrcXhmdnhkUW9TZG10aXp1NEY4SnpnaTI2djVHcndi?=
 =?utf-8?B?QW00MmR3MmVTTnNUOGZ6L0FBMVZXamxsRDNIR2ZsMVVDb1RCejB2KzdvdjNG?=
 =?utf-8?B?ckFSZW1XdDhtaTFWNjNhemE0OEZBbmN3RTdDNWpOTEF6OWl5S3NyMko3MW1j?=
 =?utf-8?B?enFhb1YwcllMOEJhRW85WFhJeFJOU0hjTUNNenVjQlVKUGw2a2w2QndtWjN0?=
 =?utf-8?B?VlJxbzI5ZGlBUEc0MjNCcHNjZFN0VDF2aUMxNWM2T1hFNkhFZ1JPeFBBQm1q?=
 =?utf-8?B?emJXS0JwWUh0eXdnMzR1aXBUdnlZcHRlWGJLdnJNMlpTdFk2VGtDVWUzVzlx?=
 =?utf-8?B?akxMUW9zWUs4MnNKZmgrV0xSNjVLRDAyNEkzbXZ2akhzTG14YjIyNm96UERV?=
 =?utf-8?B?UGl3dElyQ3dtdG4rcWtUZHNlb1FzeWV5REdwZlRPK0lkaG1QaDd2Wnh6ZGV5?=
 =?utf-8?B?K3RxaWJoVklBY21ZNTlzZ1dRNFRvcGJPT0YvZ2hjbEQ1UkUrd0JSSi9qZXU2?=
 =?utf-8?B?YUFYRzloeE92R2IwMmVRQkpmSzRWUFUxQjdIc2NKb2M5MyswTWdVemdieW9S?=
 =?utf-8?B?MWU4bVFYV1h1K1hLK0VGYXJCcFpOVFlpd2tGQ2F0MkNxTkQxTHJ1cndnMCtU?=
 =?utf-8?B?Z2c3U1VDNm0vVFZtNHZhTG1QZG5DTm1xcldkaGhvbTVQeHlvL2c5aXc1d0N5?=
 =?utf-8?B?VXhrblRzTTNSa0g3dlpEU21Wc1p2OUhjRE1yRzVJbnFQbC9ITWdxU0E4ZzZw?=
 =?utf-8?B?OEF2YzVPUGxjdlJJQ1pNbWFybDd4Y2FLUVdtalFFTVV4UWFBWHQ0QnhVN0dr?=
 =?utf-8?B?Z1l5a3dWaFF6OXNaUHJIc0YxTmNXdlUzdWZtNnliT3VMSHZHU21ROFR1THph?=
 =?utf-8?B?T0xxblQ4M0xNSDYvWVpQbDdzWWhPNmJwQmlCaUtLa1lpWWc0Q3lOT2RRb2hU?=
 =?utf-8?B?eUNRZGpBVTFsVnpreG5xK0FuZCtNcVNYVUVtL2ZyWWlmT0Jqcm5acFVTTzdF?=
 =?utf-8?B?M1h1MFpHZVNzVHFvaS9PSXU5c2I1NklqOUREL3h0aGJTcjlVcG5KUXZQOC8y?=
 =?utf-8?B?OWdRM29WZEtKZXhxd0pkR3p6OTVIbU52TXlHMk9oRDFvQVdoV29BRWZ5Qmxl?=
 =?utf-8?B?ZVUrVDU4QVBob01vNy9DQUh1Vm96SmZCNVFpU3Y3bGtJamprczJoOFlrSXF0?=
 =?utf-8?B?TjBEN0swYUdwNjBFNmxrazh3Y3ZadUtBZTdTM0gyWFBFMURvdG5QbUVYTWRy?=
 =?utf-8?B?eGhqSGJlTlhJRkkxTUVWSVVXNGZtb2lJUWJVeTNBMDdyMWZCTlF1YkdaT2Nx?=
 =?utf-8?B?N1U2V3FPaEZFNVk0QVRHUjdpTnBXZWF2Q0t6UERnemRtOXU1RGFtb1pUZFRa?=
 =?utf-8?B?R2tUbHJWMTZPSmZBNW42TUtkbFgwTUw0dWVHQU8vT3g3UjBFS29kbU9WNmhW?=
 =?utf-8?B?Y2ErUHI2MHp2NW9ENy8rcysrdzNHcjhHSmliN3A2LzZ4RjdYZWdZTjIzVStp?=
 =?utf-8?B?WXJ3ODZubVEwUS9pdGpaNDJhakEwbmo1TDhCT2xuaEx4VWVmTWY3VDJ4ckho?=
 =?utf-8?Q?3qyo1H?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 03:44:49.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a02fef-286e-4799-9c7e-08ddc808f15b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10757


On 21/07/25 5:14 am, Barry Song wrote:
> On Fri, Jul 18, 2025 at 5:03 PM Dev Jain <dev.jain@arm.com> wrote:
>> Reduce indentation by refactoring the prot_numa case into a new function.
>> No functional change intended.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
>
>> ---
>>   mm/mprotect.c | 101 +++++++++++++++++++++++++++-----------------------
>>   1 file changed, 55 insertions(+), 46 deletions(-)
>>
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 88709c01177b..2a9c73bd0778 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -83,6 +83,59 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>          return pte_dirty(pte);
>>   }
>>
>> +static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>> +                          pte_t oldpte, pte_t *pte, int target_node)
>> +{
> [...]
>
>> +       /*
>> +        * Skip scanning top tier node if normal numa
>> +        * balancing is disabled
>> +        */
>> +       if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) && toptier)
>> +               return true;
>> +
>> +       if (folio_use_access_time(folio))
>> +               folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
> Nit: I wonder if this should be moved elsewhere, since this isn't
> actually about 'skipping', even though the function is named
> `prot_numa_skip()`.

Agreed, thanks. We can use prot_numa_skip() only to return true
or false, and if returned false, we can call folio_xchg_access_time.
I will wait for 2-3 days for any more comments and respin.

>
>> +       return false;
>> +}
>> +
> Thanks
> Barry

