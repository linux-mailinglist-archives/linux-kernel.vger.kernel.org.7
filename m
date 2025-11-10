Return-Path: <linux-kernel+bounces-894283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CF4C49AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A93A9F96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241932D8DD0;
	Mon, 10 Nov 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aj4GMwaU"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1125285042
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762815338; cv=fail; b=Ncm8kvo0Cs3o9l4WxcX1xi372N8h2k7SEePl0jcC72twzeW1GYSkw3bwWr24YQu5+4nqY8h2wfesw99/hj/h92uQ4K8Uo5+QbTG7e4P9PTNDQC5yqw6IpncU3AjcppwJrtgTYB6Way77hdH0v8GYNJcIv8wwROlz8qyRx7fWghg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762815338; c=relaxed/simple;
	bh=5+c+VO7unwEQjdPllFy0a5RQqbCR2fouoUApm0nEIAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E24BAvM9SbsImse1ZxbZAE94jhg8iXu30ohPuGNWmmAgv2RfdwsLnDeY4YivDAzJBFSqe0rZPBSW8SyLMo7X5o2aSd/kbmms0UkWhdvjimJm5rnJHmuJgX7gc49tbCcFhP2eZnaBXOqeo8tEZkFlUfmHNzmLvsRm72du0Q2llEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aj4GMwaU; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtYwWu9Yr3Ro0PBRLGpc8hwmqTNe9FdUFssdik7yxjO5oQrG2fnZQtpQ+9x23vEQ7kbpciuh08wjtU9AJllEOeq0D7a0N1S4qVSDxyHnaM2jI1GGlOVBwAqFpk8NKoAcetAMPiSPUQ7/05b42gG9A1N/SKF2IaXzDJy6bc7i8GcUWK5QMSHaMIXGcTSj2/uCEVKGIYaleb2hCBg5ktEz2Rtk4F1bosD9OfhXd4igfljuKqj/1T0xaqFhR6PUSr5Zk3xYh0snC+qv9f4sZQFjNgrrqTaixR68LzUOtoqYdN2oVH9eTSUH5SDwBeLhM6BHLUhvwk1s9kzLbnWy67TS9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8sCDMMX/+5drWAx9Odhf/yoh+VxnmGA/cAsfGqYLF8=;
 b=rB9+l4cpM4O9ghA36UcQcrKhaYVyZvPYXPih4RP6+A0XSjMPWrozvndZdtsdZKZgn0JoRauhPtQpg0QKAlxFmIejCkyWq/VZNPlU2+msbK8FPZTEy/Sx/nbH7R53GFlNMrJKI+zOr63t46ji9rbglOqk89ZfvUevFXs/pAyZkvnZV1wkqpO/vzUr1a6k0AD2efcagnJgeS7TL832MK6xkw06pHbDr0hq47i6FcpBEqWvNofqiipixZHaLw4aaJbSujKGEaAiqMP4Y8Xr/VT2PHgGnFLZgcgjYlYPsGLkJe7g2/zkwub/Q0ZoSmyLU78NX3BPaJh+CpXEieQPez6kJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8sCDMMX/+5drWAx9Odhf/yoh+VxnmGA/cAsfGqYLF8=;
 b=aj4GMwaUDLkMwErEqsStTXL2rXXpZX1M342wEzdp4aCzn5kr4J85t69cvrnaBZJzoIx/ZhZwQh59+LSHoYQOjNrVh8TGrDG3HfTK3zS7FWAuOM7Pqix8nrkzu8/tNEaARqIoa3Ak9cpRkmuQyoxr2vBSDo4a/Om+fiDtviigsUM=
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by SJ2PR10MB7584.namprd10.prod.outlook.com (2603:10b6:a03:547::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:55:32 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:208:32a:cafe::80) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 22:55:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 22:55:29 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 16:55:26 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 16:55:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 16:55:26 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AAMtQMm4114591;
	Mon, 10 Nov 2025 16:55:26 -0600
Message-ID: <ec49d7b5-abb5-45b6-94d6-8f06264e8b88@ti.com>
Date: Mon, 10 Nov 2025 16:55:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] firmware: ti_sci: Partial-IO support
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Akashdeep
 Kaur" <a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|SJ2PR10MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2952eb-9f2c-4fdf-d74e-08de20ac3f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hULzJJV09tQTdGRHBMQThFNVhPZC9ZRWpnTW05RGZGRzVnWlZxK2VDZVpm?=
 =?utf-8?B?VkoyRTd0RkdsbmhVdmVoQ3pYZGFIMUw2VnlyVGd1RGZtTUVFOE1lTzBCdnMv?=
 =?utf-8?B?M1hUeXNmODd2LytFcEhHR25QdmtPeXNjUUVYRGtFK1dIbVo0cHlRWDdSNU1X?=
 =?utf-8?B?WTIrRitWUWxkaVlrQkc0QWhXd2dRTEttR0ZVUS9zN1NsaHVuUG1UOXhuVXNY?=
 =?utf-8?B?UjRhaGdLR3Rtb0oxT3JrNlpqZHlYWmd1ZFNSNVU4d1VaTnExUWZKWnN0aDMy?=
 =?utf-8?B?dVIxR21iODFuYlVFeGtEdXVENDZBbEw1S1hiMGUvK1diOWUwanREa1BCQ2pT?=
 =?utf-8?B?ZEhETUswejlRTDdDQTd2MXlUR1RSV3J1a3FWN2MzK3Z2Rkw1bThFcTNaRGlN?=
 =?utf-8?B?b2FSbTVCN1lJdWFEY3RjK2pyRE1QR042aWVZSG95b1hvRFVxN0FWK0pEUnhW?=
 =?utf-8?B?eEsxVnNLRmtWS25VWWxvWHFQMnB5L3JPT3NrVUljR2w0QU85bStKdUcxSGwz?=
 =?utf-8?B?NUJ0MWZtSUpvME5IWHNHNnBneHBRcm14LzZJY1lxaytzdDdFV21YcmZIbVR0?=
 =?utf-8?B?ZjgwVEllYU44Y1lsT3p5bU1jTFRzMGE4akt1QTRjQUV2N3Q1R0tqREdCZWR5?=
 =?utf-8?B?TU5SUFhNaC9VUHdyTUVUOXZONWNBc3ljd3lXU1NXbUhJRkMzaU1zNWE0d2V1?=
 =?utf-8?B?Z0FtazlyNE5CNG04V2thNm5hZExNUWRFdVJpRzhDT1BFenBjRVhSb3NsNDky?=
 =?utf-8?B?bE5pa1hzSXhWUTRwekt4NGt5bXNQb203SUpyNnNhSE90d0ZWazA2bi9EalZM?=
 =?utf-8?B?Ry9vaGFyd0xBQTA3OW5MQkRKQndPc1RtYnZVQnpIQnBzUG01MzJNQU0weEsv?=
 =?utf-8?B?bXdIVXdNdEk2d3FYdm1HS3N0NjZFcmtIVlJ5dWlZdTJ4UDZ1UEt5MTZKMk4v?=
 =?utf-8?B?MVdTbnhMZVUwR0w4SFlTUnN2Ri9KdlpiNmtsWHRVWHVGa3R0S0liVFFQbTBz?=
 =?utf-8?B?UEtJOS94andMQnpRT2RtOU1xbGVHdmNBdVBPZUZyRExIZW1jMktsb01ZN3FS?=
 =?utf-8?B?M21sS3dxRjk1YnB6UlEwRkJ3UG1ENGpoR0dOd0hnaUt4bVd5cE1ZUFJvcHVl?=
 =?utf-8?B?Zzc5Ukl4YjdoLzdNcDd6OHNoTHJaTUNmV0dvR1NiZENUSDNYbEEzWTcvRENa?=
 =?utf-8?B?OFozM3VxSW5udUl4aS92dmVqTHR4c292VG91K0ljWnFnT2NWaHk3NU90T04z?=
 =?utf-8?B?TnpMbWNsc3dUR29yaXN2N1kxOFRGZDVlb3Rndk1EV210VGxqM1l6WGxIdDNk?=
 =?utf-8?B?UnhBZ0JUK2Z4b2grQjJOZUJhSVJjVU4wZGxBMnZiVmhOM0k4dHE3VlhtVDlT?=
 =?utf-8?B?b0hLcDRkckhINXVXbmZ4bnZuZHAvcjE4VkFCb1ZJTHVMZ2hSRGVUSkIzdXNS?=
 =?utf-8?B?bXBJQ2xtUGpiWEFvZDlMZ0Rxa0paaTkwVFdOdnVpNDFELytHM1FRWEt2aGMy?=
 =?utf-8?B?cEEwODhpRUM2UWV0NkpwUUZDcFp0TUU3aTZJNEE0d0ZzOU1kbXpwVVQ0RXNh?=
 =?utf-8?B?aG5Kei9ieDN3MGpaa0N5TndCZExYMlZ6Yjg4Ukh4OGcwRE1UT0labXo2THRQ?=
 =?utf-8?B?a2pXa3d0a2QwZHNtUVZ3Z0NMb2QyZ3N3TmFFZ2ZuUGp0VlBEM3o5TUZ3MStN?=
 =?utf-8?B?QloxRWp4MHByeWZtMDJ3K3ZlanVKSXFXUWNNajJLY0lYOXZJb2NWS3JsNEtH?=
 =?utf-8?B?ekRPSDhDK1d0ZVpoRk5SS1NTVmxyajNic0pReC9aWHNYYi9NZDNUSFlhbUdF?=
 =?utf-8?B?bzV3dVRYdk1RVWM2Vm1Ydlhqa2hrVDJFUW9mMGEyV3AydE9WUFlKYk9pQ3pS?=
 =?utf-8?B?L1hLRGNzWkptRTdtWlgxUjYxMnFQNHl5MzE3bFAxaDYrMnZFWEp6SW1pTnpr?=
 =?utf-8?B?SVlIYm92WDZ5dWZyWTNMNUFkM3JKTENYRDhxQTdkMWExeE9YWVZkTUdELzNu?=
 =?utf-8?B?UTA0NnJyS3dLV3hnZnI5cEZPMUZFaUNpN25RTWNDOC9SWmFhT2k4TmxEWWR2?=
 =?utf-8?B?bXQvU1dRdnl1aFhkMFY0ZVlYTGJaWVYwZGJlZTU3Qm5LSFJzN1UxMnFtWnJD?=
 =?utf-8?Q?Dsd0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:55:29.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2952eb-9f2c-4fdf-d74e-08de20ac3f44
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7584

On 11/3/25 06:42, Markus Schneider-Pargmann (TI.com) wrote:
> Hi,
> 
> This series adds support for Partial-IO to the ti-sci driver,
> implementing the firmware interface necessary to enter this low power
> state. It processes the wakeup-source properties from the devicetree and
> communicates with the system firmware to enter Partial-IO mode when
> appropriate wakeup sources are enabled.
> 
> Partial-IO Overview
> ------------------
> Partial-IO is a low power system state in which nearly everything is
> turned off except the pins of the CANUART group (mcu_mcan0, mcu_mcan1,
> wkup_uart0 and mcu_uart0). These devices can trigger a wakeup of the
> system on pin activity. Note that this does not resume the system as the
> DDR is off as well. So this state can be considered a power-off state
> with wakeup capabilities.
> 
> A documentation can also be found in section 6.2.4 in the TRM:
>    https://www.ti.com/lit/pdf/spruiv7
> 
> Implementation Details
> ----------------------
> The complete Partial-IO feature requires three coordinated series, each
> handling a different aspect of the implementation:
> 
> 1. [MERGED] m_can driver series: Implements device-specific wakeup functionality
>     for m_can devices, allowing them to be set as wakeup sources. This is
>     now available in linux-next.
>     https://lore.kernel.org/r/20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com
> 
> 2. Devicetree series: Defines system states and wakeup sources in the
>     devicetree for am62, am62a and am62p.
>     https://gitlab.baylibre.com/msp8/linux/-/tree/topic/am62-dt-partialio/v6.18?ref_type=heads
>     https://lore.kernel.org/r/20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com
> 
> 3. This series (TI-SCI firmware): Implements the firmware interface to
>     enter Partial-IO mode when appropriate wakeup sources are enabled.
> 
> Testing
> -------
> A test branch is available here that includes all patches required to
> test Partial-IO:
> 
> https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-partialio/v6.18?ref_type=heads
> 
> After enabling Wake-on-LAN the system can be powered off and will enter
> the Partial-IO state in which it can be woken up by activity on the
> specific pins:
>      ethtool -s can0 wol p
>      ethtool -s can1 wol p
>      poweroff
> 
> These patches are tested on am62-lp-sk.
> 
> Best,
> Markus
> 
> Previous versions "firmware: ti_sci: Partial-IO support":
>   v1: https://lore.kernel.org/lkml/20240523080225.1288617-1-msp@baylibre.com/
>   v2: https://lore.kernel.org/lkml/20240729080101.3859701-1-msp@baylibre.com/
>   v3: https://lore.kernel.org/r/20241012-topic-am62-partialio-v6-13-b4-v3-0-f7c6c2739681@baylibre.com
>   v4: https://lore.kernel.org/r/20241219-topic-am62-partialio-v6-12-b4-v4-0-1cb8eabd407e@baylibre.com
>   v5: https://lore.kernel.org/r/20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com
>   v6: https://lore.kernel.org/r/20250421-topic-am62-partialio-v6-12-b4-v6-0-3b5cefab1339@baylibre.com
>   v7: https://lore.kernel.org/r/20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com
>   v8: https://lore.kernel.org/r/20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com
>   v9: https://lore.kernel.org/r/20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com
> 
> Previous versions "can: m_can: Add am62 wakeup support":
>   v1: https://lore.kernel.org/lkml/20240523075347.1282395-1-msp@baylibre.com/
>   v2: https://lore.kernel.org/lkml/20240729074135.3850634-1-msp@baylibre.com/
>   v3: https://lore.kernel.org/lkml/20241011-topic-mcan-wakeup-source-v6-12-v3-0-9752c714ad12@baylibre.com
>   v4: https://lore.kernel.org/r/20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com
>   v5: https://lore.kernel.org/r/20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com
>   v6: https://lore.kernel.org/r/20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com
> 
> Changes in v10:
>   - Remove unnecessary empty line
>   - Make ti_sci_cmd_prepare_sleep aware of PARTIAL_IO mode and the
>     not-expected response, because both Kendall and Andrew seem to
>     prefer this.
>   - Moved the removal of the ctx_lo, ctx_hi and debug_flags to the end of
>     the series so merging is optional.
> 
> Changes in v9:
>   - Rebased to next-20251029
> 
> Changes in v8:
>   - Add a patch to remove constant 0 argument passing to
>     ti_sci_cmd_prepare_sleep
>   - Move partial-io functions further up in the file before the first
>     static const initializations
> 
> Changes in v7:
>   - Rebase to v6.17-rc1
>   - Update the idle-state-name used to off-wake as introduced in
>     dt-schema
> 
> Changes in v6:
>   - Narrowed down the wakeup-source binding to phandle lists
>   - Split off the mcan and DT changes into separate series
> 
> Changes in v5:
>   - Rebased to v6.14-rc1
>   - Merged m_can and ti_sci series to avoid conflicts and show
>     dependencies more easily
>   - Added definitions of system-states for am62/am62a/am62p
>   - Moved wakeup-source definitions into board dts files as they require
>     a bit of support on the board.
>   - Updated ti_sci support to walk through the wakeup-source phandle
>     lists
>   - Added pinctrl settings for mcu_mcan0/1 on all boards
>   - Minor style updates for ti_sci support for transfers without response
>   - Update and move the dt-binding for wakeup-source from the m_can
>     binding to the dt-schema repository
> 
> Changes in v4:
>   - Rebased to v6.13-rc1
>   - Removed all regulator related structures from patches and implemented
>     the wakeup-source property use instead.
> 
> Changes in v3:
>   - Remove other modes declared for PREPARE_SLEEP as they probably won't
>     ever be used in upstream.
>   - Replace the wait loop after sending PREPARE_SLEEP with msleep and do
>     an emergency_restart if it exits
>   - Remove uarts from DT wakeup sources
>   - Split no response handling in ti_sci_do_xfer() into a separate patch
>     and use goto instead of if ()
>   - Remove DT binding parital-io-wakeup-sources. Instead I am modeling
>     the devices that are in the relevant group that are powered during
>     Partial-IO with the power supplies that are externally provided to
>     the SoC. In this case they are provided through 'vddshv_canuart'. All
>     devices using this regulator can be considered a potential wakeup
>     source if they are wakeup capable and wakeup enabled.
>   - Added devicetree patches adding vcc_3v3_sys regulator and
>     vddshv_canuart for am62-lp-sk
>   - Add pinctrl entries for am62-lp-sk to add WKUP_EN for mcu_mcan0 and
>     mcu_mcan1
> 
> Changes in v2:
>   - Rebase to v6.11-rc1
>   - dt-binding:
>      - Update commit message
>      - Add more verbose description of the new binding for a better
>        explanation.
>   - ti_sci driver:
>      - Combine ti_sci_do_send() into ti_sci_do_xfer and only wait on a
>        response if a flag is set.
>      - On failure to enter Partial-IO, do emergency_restart()
>      - Add comments
>      - Fix small things
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
> Markus Schneider-Pargmann (TI.com) (3):
>        firmware: ti_sci: Support transfers without response
>        firmware: ti_sci: Partial-IO support
>        firmware: ti_sci: Remove constant 0 function arguments
> 
>   drivers/firmware/ti_sci.c | 131 +++++++++++++++++++++++++++++++++++++++-------
>   drivers/firmware/ti_sci.h |   5 ++
>   2 files changed, 117 insertions(+), 19 deletions(-)
> ---
> base-commit: c9a389ffad27e7847c69f4d2b67ba56b77190209
> change-id: 20241008-topic-am62-partialio-v6-12-b4-c273fbac4447
> 
> Best regards,

LGTM, for the whole series,

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis


