Return-Path: <linux-kernel+bounces-886502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80045C35C24
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676ED567AB0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D43164D2;
	Wed,  5 Nov 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mjwrfCBC"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazhn15011022.outbound.protection.outlook.com [52.102.139.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E8122A813
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.139.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347935; cv=fail; b=D4gFft3B8w5Gdr9/PATfVA0emjIDR2N2LKX6w3KlcJbg1tSPMjn+bTZdvbgJOYSooiINjra4ScJ0khPXqG0ntKtqUoTyB9bDL7nlPBjLoLPTEIGdrnHGa6A4WgbKHs/kCof+UXFWL1L3oZXE/Nfpr40FIZqnS11McpjMsuryYCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347935; c=relaxed/simple;
	bh=nYFpX6tO8p1N+Zu0yUK+XfqvAa4yOcFMPw7P0an3pkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZmM3+/S0OGdvahDptVoX38uC4CG2rjXH+adh0Q/svbPce1p6a0tNoTziuJkOmjklTMcKJvXh1/hPNL9SMgEA3Dq6IPFd5ZTQp6LMhh6xkd/E3Loh5FUlNdfH7y7uv5NqaVIqHPfJgIOcIN21z0JRl/S1+KkiF23pzlHn7RgGtkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mjwrfCBC; arc=fail smtp.client-ip=52.102.139.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMbnSCObacT/PvS9OSM13Np6qRF/cyHTWp/awkTQBaYKuE8q5oaMG/igxHA6FR4984jkSyDpFI2NK7gBJnWJREB9Tt8Pc6oqKGysQQceojGYD0Fm2UcVdWT7wJ20719grTZzNnEdCdGj/8i264Ppy7WxUQM444x5iLRSUGMHwFjHufBjhkU26E9ntBweCVYM+SYT67IQye+R3hNOj7eoEzjJIH3FBjC+H/SeJbM/qqfdm80VsG14r+etctz9W4wV5oZHWcouZiIkhoOLXsfaAJZfvhCxZiSn6Zaoj+4DcB3o572ZoLy72RFTWJLljFtLgC3fkRrI41uO7ya+4l9rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNc5ld+vlq9ExpZhB8yfuVkexrUiw0zPh3BeO0WztRg=;
 b=D7hc+W6SwLH+EFA3+ESKcG8WbBWBiotW9n+vvdmx4/IgrNKFngZWLQVf+tGWIXd6Lq67BMzgCiX5yWyZEbWf2RoajNMr6e7m9FDG5isFeMts8Pe3+2Vu0qWCuNCLa6Sa36o38PzxqbHQtuqMGEs4Lo+31qb3sdc0Sfd4KWEbSpRpcCsCa5Bn+NzCH1dcuK3Hq5D3JA9WAQBiXzQuYs9XLNilp4RvzrfCO+KANknc0S6mV94yKYmH+EH4aVnOXKG+5QEd55oH5jiDAq7e/y0L/bB9vSCt2dt51ZaaNYe1agOfWAn89iylTaacA3ghrE968FkIiRvPfbKIsyo/HB88sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNc5ld+vlq9ExpZhB8yfuVkexrUiw0zPh3BeO0WztRg=;
 b=mjwrfCBC778+hW+YSdpk263romZtDWLg4UJKaPw2XmIjQFlrJv3cqyVZa+XwwAt1QioPQf6YCVOCWYEyZ2imZ4FSVw15X7f2x7vhYiZ9uiLyKrVcgsA0yckooFq1G+/favXnypvozR1ufUATjdc/pYj6Osf0Igda0y4SZEqPUw8=
Received: from BN9PR03CA0754.namprd03.prod.outlook.com (2603:10b6:408:13a::9)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 13:05:29 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::f0) by BN9PR03CA0754.outlook.office365.com
 (2603:10b6:408:13a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 13:05:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 13:05:28 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:05:26 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 07:05:25 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 07:05:25 -0600
Received: from [10.249.139.123] ([10.249.139.123])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A5D5MIs3697370;
	Wed, 5 Nov 2025 07:05:22 -0600
Message-ID: <cf751cf7-53a5-438b-9903-903bd8c39b23@ti.com>
Date: Wed, 5 Nov 2025 18:35:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TI K3 AM69 Kernel Panic when PCIe Controller is Enabled
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
	<jpaulo.silvagoncalves@gmail.com>, Nishanth Menon <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>,
	Swapnil Jakhade <sjakhade@cadence.com>
CC: Andrew Davis <afd@ti.com>, Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>
References: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 343561d8-bdac-4d80-2e26-08de1c6bfe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWd6ZjNmalhZbE13N0xzd0ZNZFZObS9INnRjQkRWTHJnZjBCQjV2TzFpOXdv?=
 =?utf-8?B?MnFuc0RjcnFZQUJTaThPRkJseXp5N2t1VnQvU2d5UlNKVC95dm8yZFZtd0Y0?=
 =?utf-8?B?Y3QwMzk5TkhoL0R5MHBwYm1HV3R0Y3pNcTZTUGt2UFJSL0Q5UXhGZUVxZU8w?=
 =?utf-8?B?SGJhbmMzeXpWTTdRNDg4c3V3Qk8wYk4xWUxFM1VjN0VaWTdVbGtYM1ppSEJs?=
 =?utf-8?B?bUdLTXBzRW5NaEIzMy84eENQamU5ZUtWYlNSOHNaWGNGZ2l2VlJYNUJWcWdX?=
 =?utf-8?B?S3FRL1k2L095UkRYQkh0R3NLMDU4K3BBdm04VEd4ZTlmaE9sdHdvSjZHb0N4?=
 =?utf-8?B?UDRCclFha1U5QmJhTnA1bU9uTEtkN3FOWnZ4TGZFdGIvV2taSkUrNVlmdWo0?=
 =?utf-8?B?bVd1QjRRTXhtcGFjTFZzTmxmaGF6Ynd4Znk2cHNGMjVydEI0MGM0ZnE4eFdZ?=
 =?utf-8?B?WDNocXVMcVFWMnhkVXRGY2xpSy92SmtlVkh1RWcxdWxKTDRsS243TWpGeEtD?=
 =?utf-8?B?SmY3OFc5Y0tMb2laVlBHQlNjN1E4ZjhKUE5rVXlGcGdxamdFWkpaNldQOE0z?=
 =?utf-8?B?VWZXMmtJZWlQUW5adWd4QkVHc0FETXlWUTlUaTQxbTErb3IvTnJ0ejBQSHJT?=
 =?utf-8?B?ZUtPRU1RbHVDWFN5REQ1R2JjTmp5dS8wSytUaExDNjIwb1JDYUd6anVlbk8y?=
 =?utf-8?B?anpkdmdJZHc3UXJkSjI4ay9qS0tYbyt6dSs1eUhoM0l3cC8yR3VVc3dIdnh3?=
 =?utf-8?B?UEVnN1ltMlEySmgxTDQ0RU15Vk4wTUdhRGpYbHJYYzhKRE9iaEpFNEdJeUhI?=
 =?utf-8?B?Z1dGSk05clEyWlFEQTNySDBUdUxDQmNzUTJkQ1pET2hBZmI0S2swWFJMK0Q3?=
 =?utf-8?B?ajZYUVFCcnpQcWFzRjg1enFpMWk5MjBYTWI4MXl3elRTaUh1NnBmQU1UKzJJ?=
 =?utf-8?B?c0RLaktsenc2cXRQL2hDVkJ0eUViYXFHVmRZNWErdCt6ZDdOeDhUd2RNNmNn?=
 =?utf-8?B?akVqWGxzS3dZdHFhUmhOcTM3K3p6R3doZ0VXZXNvWnRrcnFxTUp6MXJtTnF6?=
 =?utf-8?B?aTJLQjZ1N1p6VUFFUVRuVnRuekNCbzFKaUY2ZXp5TWtxSVZWcm9wRUFuWm9N?=
 =?utf-8?B?bFdOcktkUVNGSy9lR0d0VjNWTHgyT1hhcG95akd3bGtwcjY5ZGEvMzlZYVdx?=
 =?utf-8?B?WXB3QmRFcWhPM3QvZFBaNTduRGoxUnRSa1ZwZVRTakI0UWo3VFdsQmZBeDRI?=
 =?utf-8?B?MElnMW5sM2J6TUVxU3VUNDlvREhSdDlaQ1Ria04wYlpvQi9JZDUwUEJBTURY?=
 =?utf-8?B?UmRPbUpEM04weHJJTnB2NWwyeGVYTkhxWk5kelBweEkwdkZUR01YTFp2bkFp?=
 =?utf-8?B?MUpDd2lQbHZHTWIxa2lEUmJVSU8xUDRHOU5XUzQ0alZQd0ZDMzk0UVNmRDJ5?=
 =?utf-8?B?UmtOOTFJZkJiSDRhZWYyNFVyRzUzcXIwTjdFaEVlcHJib0h3UW5lSzh6cEUx?=
 =?utf-8?B?d0RSSVhibWxGVFhtdVRjcitGZEJMSHFvdDlSQm0zWUpsRlpLcVFPeitrVnpx?=
 =?utf-8?B?TnNZbjZiRXc0dzlVZGhYWFV6dmR1K09oZWxNU2F1T1I1NWdKbmZhandzVnY3?=
 =?utf-8?B?M1RNcnMzUEp3TFlyN1F4VVhBNUx2Y0xGazY0ZjVaTHQ4M09iVXNSUEh3aHFH?=
 =?utf-8?B?dEhJbm40MCszYkhOZzdxcjVrR2tVVVFnUjV2bi95bUFRVTEvRFJzZHBnQ0N3?=
 =?utf-8?B?TEJmdjl5ckJaa1dWTHVPZ2F5V0d2OW5sK3hMekI5Q3RWR2JTT1VPSEVNMFBT?=
 =?utf-8?B?NmdyT0phNXl0WmpQSEdaNzhnNVRmVE9TS012K1RBMGVFSmhlQUxjYis2bWta?=
 =?utf-8?B?Z24vSXYvYXdueU9JbW1GUmpycllmbTVvR2o4NlVQSW1IZ0dnQk9tblRGbDFW?=
 =?utf-8?B?cTlEY1MrRGt6cU9RbkZ3eHFDR1RTWlFvc3doVjJ1WkJWS0FqWGsvY0RmQTdG?=
 =?utf-8?B?a2IvcU5DWDE2bktjdVc4SEEzVVFkUkYyUkxGVHFBV2loYVZvVnBoM3h0dEFN?=
 =?utf-8?B?WjY0VXQ5b2liVGprQU0yRWRlaFVzc3RyeTl2K1pyQ1RBb21ycnRKTDRRLzBC?=
 =?utf-8?Q?jh54=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 13:05:28.8395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343561d8-bdac-4d80-2e26-08de1c6bfe79
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592

On 05/11/25 6:16 PM, João Paulo Gonçalves wrote:
> Hello,
> 
> I was testing PCIe upstream support on TI AM69 with a NVMe Samsung SSD
> to add upstream support for Toradex Aquila AM69 (sent upstream [1]) and
> noticed that when enabling the PCIe controller (CONFIG_PCI_J721E_HOST=y)
> on the arm64 defconfig, there is a kernel panic on nvme_pci_enable:
> 
> [    7.397838] pci 0000:00:00.0: PCI bridge to [bus 00]
> [    7.402799] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> [    7.408887] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [    7.415675] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [    7.423501] pci 0000:00:00.0: supports D1
> [    7.427509] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    7.435887] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [    7.444083] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
> [    7.451449] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> [    7.458407] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    7.480637] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
> 
> [    7.493685] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
> [    7.500002] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> [    7.506679] pci 0000:00:00.0: bridge window [mem 0x4000200000-0x40002fffff]: assigned
> [    7.514553] pci 0000:00:00.0: bridge window [mem 0x4000300000-0x40003fffff 64bit pref]: assigned
> [    7.514562] pci 0000:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
> [    7.530134] pci 0000:01:00.0: BAR 0 [mem 0x4000200000-0x4000203fff 64bit]: assigned
>           Starting Connection service...
> [    7.537834] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    7.547531] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
> [    7.553644] pci 0000:00:00.0:   bridge window [mem 0x4000200000-0x40002fffff]
> [    7.553684] audit: type=1334 audit(1748569869.624:11): prog-id=15 op=LOAD
> [    7.560814] pci 0000:00:00.0:   bridge window [mem 0x4000300000-0x40003fffff 64bit pref]
> [    7.575695] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
> [    7.575702] pci_bus 0000:00: resource 5 [mem 0x4000101000-0x40ffffffff]
> [    7.587971] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
> [    7.587976] pci_bus 0000:01: resource 1 [mem 0x4000200000-0x40002fffff]
> [    7.587979] pci_bus 0000:01: resource 2 [mem 0x4000300000-0x40003fffff 64bit pref]
> 
> [    7.612848] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
> [    7.619482] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
> [    7.635343] pcieport 0000:00:00.0: PME: Signaling with IRQ 600
>           Starting Virtual Console Setup...
> [    7.649648] pcieport 0000:00:00.0: AER: enabled with IRQ 600
> [    7.660029] am65-cpsw-nuss c000000.ethernet eth1: PHY [gpio-0:04] driver [TI DP83867] (irq=379)
> [    7.660666] nvme 0000:01:00.0: of_irq_parse_pci: failed with rc=-22
> [    7.668777] j721e-pcie 2910000.pcie: host bridge /bus@100000/pcie@2910000 ranges:
> [    7.669791] am65-cpsw-nuss c000000.ethernet eth1: configuring for phy/sgmii link mode
> [    7.675751] nvme nvme0: pci function 0000:01:00.0
> [    7.682528] j721e-pcie 2910000.pcie:       IO 0x4100001000..0x4100100fff -> 0x0000001000
> [    7.690339] nvme 0000:01:00.0: enabling device (0000 -> 0002)
> [    7.695034] j721e-pcie 2910000.pcie:      MEM 0x4100101000..0x41ffffffff -> 0x0000101000
> [    7.703120] SError Interrupt on CPU7, code 0x00000000bf000000 -- SError
> [    7.703127] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:3 Tainted: G   M                6.18.0-rc1-00023-g417c89ae1522 #3 PREEMPT
> [    7.703133] Tainted: [M]=MACHINE_CHECK
> [    7.703135] Hardware name: Toradex Aquila AM69 V1.0 on Aquila Development Board (DT)
> [    7.703139] Workqueue: async async_run_entry_fn
> [    7.703155] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    7.703159] pc : nvme_pci_enable+0x54/0x598 [nvme]
> [    7.703178] lr : nvme_pci_enable+0x48/0x598 [nvme]
> [    7.703183] sp : ffff80008130bad0
> [    7.703184] x29: ffff80008130baf0 x28: 0000000000000000 x27: 0000000000000000
> [    7.703189] x26: ffff000800028028 x25: ffff000800e211c0 x24: ffff00080d242260
> [    7.703194] x23: ffffbfcbbb091150 x22: ffff0008081b50c8 x21: ffff0008081b5000
> [    7.703199] x20: ffff0008081b5000 x19: ffff00080d242000 x18: 0000000000000006
> [    7.703203] x17: 203e2d2066666630 x16: ffffbfcbeb0d1ca0 x15: 2e2e303030313030
> [    7.703207] x14: 303031347830204f x13: 3030303130303030 x12: 30307830203e2d20
> [    7.703211] x11: 6666663030313030 x10: 313478302e2e3030 x9 : 4920202020202020
> [    7.703216] x8 : 3a656963702e3030 x7 : 205d383235323836 x6 : 362e37202020205b
> [    7.703220] x5 : ffff00080834f000 x4 : 0000000000000006 x3 : ffff800092800000
> [    7.703224] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> [    7.703229] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    7.703232] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:3 Tainted: G   M                6.18.0-rc1-00023-g417c89ae1522 #3 PREEMPT
> [    7.703236] Tainted: [M]=MACHINE_CHECK
> [    7.703238] Hardware name: Toradex Aquila AM69 V1.0 on Aquila Development Board (DT)
> [    7.703239] Workqueue: async async_run_entry_fn
> [    7.703244] Call trace:
> [    7.703247]  show_stack+0x18/0x24 (C)
> [    7.703254]  dump_stack_lvl+0x34/0x8c
> [    7.703260]  dump_stack+0x18/0x24
> [    7.703263]  vpanic+0x324/0x368
> [    7.703270]  nmi_panic+0x0/0x64
> [    7.703274]  add_taint+0x0/0xbc
> [    7.703279]  arm64_serror_panic+0x70/0x80
> [    7.703282]  do_serror+0x3c/0x70
> [    7.703285]  el1h_64_error_handler+0x34/0x50
> [    7.703290]  el1h_64_error+0x6c/0x70
> [    7.703293]  nvme_pci_enable+0x54/0x598 [nvme] (P)
> [    7.703299]  nvme_probe+0x358/0x77c [nvme]
> [    7.703304]  local_pci_probe+0x40/0xa4
> [    7.703311]  pci_device_probe+0xc0/0x240
> [    7.703316]  really_probe+0xbc/0x29c
> [    7.703324]  __driver_probe_device+0x78/0x12c
> [    7.703329]  driver_probe_device+0xd8/0x15c
> [    7.703334]  __device_attach_driver+0xb8/0x134
> [    7.703339]  bus_for_each_drv+0x88/0xe8
> [    7.703344]  __device_attach_async_helper+0xb4/0xd8
> [    7.703349]  async_run_entry_fn+0x34/0xe0
> [    7.703353]  process_one_work+0x148/0x28c
> [    7.703360]  worker_thread+0x2d0/0x3d8
> [    7.703364]  kthread+0x12c/0x204
> [    7.703369]  ret_from_fork+0x10/0x20
> [    7.703374] SMP: stopping secondary CPUs
> [    7.708837] Kernel Offset: 0x3fcb6aa00000 from 0xffff800080000000
> [    7.708840] PHYS_OFFSET: 0xfff1000080000000
> [    7.708842] CPU features: 0x080000,04025000,40004001,0400421b
> [    7.708845] Memory Limit: none
> [    7.996038] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
> 
> 
> The issue seems to be related to the Serdes PHY
> (CONFIG_PHY_CADENCE_TORRENT and CONFIG_PHY_J721E_WIZ) being enabled as a
> module on the arm64 defconfig. Enabling these configs as built-in, at
> least on my system, makes the PCIe work.
> 
> Toradex already reported this to TI for the downstream kernel [2], but
> it seems that it is also happening on upstream.
> 
> [1] https://lore.kernel.org/lkml/20251104144915.60445-1-francesco@dolcini.it/
> [2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1406797/am69-nvme-pcie-and-kernel-panic

The E2E thread above leads to another one where the issue was claimed to 
be seen only with the usage of an external reference clock, and it was 
fixed with the usage of the internal reference clock. Does this hold 
true for the board that you are using as well?

Regards,
Siddharth.

