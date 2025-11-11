Return-Path: <linux-kernel+bounces-896152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE823C4FC39
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 531C934D3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A899326937;
	Tue, 11 Nov 2025 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JSGE5JbR"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B8326933;
	Tue, 11 Nov 2025 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894756; cv=fail; b=U3YmKNszQW9I9RbHPXzpIjd6n0rfYdJHSjyxGtKolG4weTc790+Ht6vWNSVKRZ7kR/+b8GNTyFwUi8QXumBoEcABTs68nsm95GQlJdlzmgmUblA+iTeMcLgVaTUrd11vx/wNdvlegHaYBAyT6P5pA+B/wBcUejXQCz4/kNtgSRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894756; c=relaxed/simple;
	bh=NIRoHBNxLzPNiD+K9we18liCRG6f9mhgJ0gg2X1zofA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TYV6gsn+ODqmrIuFqC7/tq29N8nq19LVdUIKAQWSgQPqv+pRzsFx3E+b8ycI/MeBVsXuhBUopT2IWTQBXWy2rk5TYywF6Gvb+iX6tMqMdZYwq3naGh6LP5Fmwf2k8D/Q1z2kcxAgpWvJC3jUaBGgWPLfZQiDwngsX5bqTmGpIIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JSGE5JbR; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCpXgCv2mrD7bXglrt2OGHowg70HTAjKZIihW/UsNQ8qDxYrzpYevo0Ye0630XooeTpNefJHM2BoWLUHSFBcOAXTpybhDor8wnJMFlbCWY11R7vstADIfZWQRpFpnr/9jvLiCJg3i8SIAc60cpVFh2hvcBKyBezK43Y0+wsqbOrlsqnoAF2zMwJDPxc3g7/DYP7Kw37j9Mt2tE+t96P02UrBhhNM/07v+fut/1bbF+geF6x3KdbBPH5HiPzKEiDv/bQEsNzFQRjBCp5AC5d56pavGpQs68Bk7L9Y79nkFUPGudz52l0Y4ohhQDmq5kaP6O5/96gCXE6aBbgph0pzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SccHB8C1HQYGtVf5CnokvznrssMFJHKkFrkv4xy658=;
 b=dND7VNg9ZoOQX1AnOr7zm+XGFaovfaXR085nLD9u0+YPBxuE0b36IdvtAQQI8qjRmjTyr8zsuOEJIW5DpndNyOd+TsLCiQEqVzK3TbgohQdL5Jw2Z4ysDEF2cKSmk6Nw2fJrWZZphV4XT0xHKgH7lO1ewVNLmuHV7WglS1Mnp1NI3Q1zQCDOFeDIUl9XObT9Xz6EmF9sUZOF0vGMyOjJApflTlw4XiGkmpxZX8c2EqQRMSHM9e7EPNXpnudw2hqulRRA77QCloKOJedqDXmoCr8oew+h8chxLXLF3ZOkTN6c/c2Mois+pTJSZztfEpRi8ZcqSeyTcJbVH8BCJIOA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SccHB8C1HQYGtVf5CnokvznrssMFJHKkFrkv4xy658=;
 b=JSGE5JbRwSO/YzxntdIUs4bh3tWLRO+ZM1kVxLtYamZlBKw+wp6n1sQ4PNBDnGjGHIgG/px1e+EmsjJQSl5yPV13XpTjLx3Aq3RkrYbi/v90tz/AlZDwfUxwqxBeiYBu0wBn5juq28Y92UCu+GzOX4t+QgvQ+XYwjBPOki191RE=
Received: from BLAPR03CA0087.namprd03.prod.outlook.com (2603:10b6:208:329::32)
 by SJ0PR10MB6301.namprd10.prod.outlook.com (2603:10b6:a03:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 20:59:10 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::58) by BLAPR03CA0087.outlook.office365.com
 (2603:10b6:208:329::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 20:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 20:59:09 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:59:04 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:59:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 14:59:04 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABKx4Aj1551388;
	Tue, 11 Nov 2025 14:59:04 -0600
Message-ID: <48194baf-83a2-4d10-89a5-a45267c0da7d@ti.com>
Date: Tue, 11 Nov 2025 14:59:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] arm64: dts: ti: k3-am62a: Define possible system
 states
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
 <20251103-topic-am62-dt-partialio-v6-15-v5-2-b8d9ff5f2742@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-2-b8d9ff5f2742@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SJ0PR10MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c974e3-decb-4cb9-5521-08de216528dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0F3Vkp6aXMvR2ZvSmlDRzdPUE5RT01VRmFhL2Vjd3JsME9tUFlYb2htZTht?=
 =?utf-8?B?azZKL3NIeHNQdkNwY1JSL3o4dnc1aDlGZitSY3ovZGdEa1dWTXpqTFlmaFBD?=
 =?utf-8?B?WkQ4cTJwUWdZUTdLRXZPOVEvY1ozWXpPL2l5SllDYjhuMzlLUzE5eHRvekZ1?=
 =?utf-8?B?VG1EYlRpR1h3dHhpSENuWThIUFBad3BxeXBkcnY5dGM2bkRrRGFCcHUzYlUv?=
 =?utf-8?B?UTlJaHlwMW5PNjZjYVlNejhFWXpGYzZhc3VDZWJZOENqZ3F3WW0rNUVKQWd4?=
 =?utf-8?B?T1VJUlVEUlFmZmFLT2MzdllhaUVGVTY5K0RlQlVQVFRDWSswZDFhNU9oWWwy?=
 =?utf-8?B?dFk1WDB1elUrcVlVM3FQeUZkNlZ0a1J4YWhFZDU3Z3ZiUisybzdOYytyVWw5?=
 =?utf-8?B?UHRraWFVRE85TWJLakUrWlZYVm44Y1Y3UUtLbCs4eFM1RmUzK3YvSzk2YWEy?=
 =?utf-8?B?ZmRkWXd5M2hDMmRqL3p2R3VmTFZlSnZiQXNGekNRN1ZhVG5qWGV5NEtmelc1?=
 =?utf-8?B?cHBSbnZSTWdhZTlIWk4yeks0NDdLeVdEcmFlMjVkUDJ3QjJ2aW91bHdNUkgz?=
 =?utf-8?B?MjFHL295bjJwb1ZNOXhkU0dDT2ptY09CaE5rVkFvY1hURFYvc0kxK3pzS2tK?=
 =?utf-8?B?WE5qR2ZMWmg0T0FCbHlWRlhCRDl5d0pDbk4xWHBSZnVMcUdwMXJRQjQrRGVy?=
 =?utf-8?B?UXc4UEZsL1FTN1V1cDVRZTB1dkVMN0JaUlE3a2dqVlJ0Ym56U0hGNXFRU2k3?=
 =?utf-8?B?SzU0U0ppR2tVWFYraFRmY2VDTUh5NXk4b2wvKzJsQmpFcVBYMU9nYnZyZlBV?=
 =?utf-8?B?T1F5bnpmOEFCbCtwRWNRN2dMWThpTWV2OGFSMTlIM3huYTYvWFdhaHJFNFZG?=
 =?utf-8?B?Y0Z0aHF4OUR0d0J2R0U0RFFlZUsrT1pNVXI5QnVmVkQ1UGpHd1RON0RwbEdo?=
 =?utf-8?B?Mk9hZDlTWmZUa2ttb1ExaDRWZTgxQkpRYitCZlBvcHhXTmNYaGlreUI1cnJH?=
 =?utf-8?B?ZDZjaXVyYU0vbko0bTBzY3JsTm5YWmtqemJnSlNqbTJ6NUU1a0x6dzY1b2Jr?=
 =?utf-8?B?bUtwS2w3c1JBbC9DeFV1N2N0N2NZRnc5ei9QM040UkprcXZKcjgzZFdsK3Jq?=
 =?utf-8?B?TDhuRllQUUlkZ0FiTUtnbVdKeGpvazVsU2VSK1RnNnBiTzlyVWY5aktZay82?=
 =?utf-8?B?OFdma0ZYTWZEdUxCbnF0VVdWclNkbExucWxMWnFKbHlhai8zQ2lpMlNVZEJO?=
 =?utf-8?B?anM4U0o4cHdST3lwYlFpMXhGd1RUN2FXY3hNTXZJa1N4TjgyMEVZbVgxbmY2?=
 =?utf-8?B?WmhjdGExU0psdXd3bWo3K3ZRMlg2aE5GYXhEYWRCVWdsbmcwNkZUZk13WDA5?=
 =?utf-8?B?bm1haWNZUXpGS2dsQnpZVWo3NFVoYkR5Ykh0WHZkWlZkS2wrMUlIckoycnlT?=
 =?utf-8?B?WnY2akx5cTZSdnRKbEd4VzBONVlzSy9vdWFONGV0MjNpdlU4MDVCM0N2N1BX?=
 =?utf-8?B?alJPMXFVWE5FMTJxNE5wSTJHRHo1c1ZmOHdKYkY5a09OTDlDaE52cU94c28w?=
 =?utf-8?B?U1dKZ3JpOThvNk4zMTlleFJGdXYyTy9lSllobXBmZGRWZVBKdHZDZE8yS0k2?=
 =?utf-8?B?UUI1REgyQVAvbkVTMVh6TUlyMmtFQVh5aHppMjl1TTFCblhiUFNQQWN4TFlU?=
 =?utf-8?B?WUUzdHgySU1WZTZqbGVpZHk0c3JtbVFVT0laRmVkSDhBVTBlR3VOdXpQeG82?=
 =?utf-8?B?dVhoQktBU1UyT0tBZ1MvWmo1ZUhKQ0VqekJNYVB6VHBUcHhlMkNJTGUrWk1K?=
 =?utf-8?B?MlVlVjlPNW4wdWdJWkEzZUovd21DdUlSSi9aWDVNaUIyNytUcmt1T1F0N2lk?=
 =?utf-8?B?QzZ4ZCtoNGg2SGQxZzhRZktyVG5MY21NUEhNK3IwS3R2SC9ZeWxBdzI4MlhI?=
 =?utf-8?B?cnVodStSSHZnS2hrcVIxTkp5OVQ4dmp2N2ZNc2FwTFVYN2U3VHJqTDJOZVZj?=
 =?utf-8?B?d2NKdlRhTFJMQngxZ1ZjdDJTd0ZtcFBXdWpMTDZGTTg0cUF6d08vdEdRSVpN?=
 =?utf-8?B?TGROa2hDNHNiSkludEJuNnBySXJzWTJEK2V1a0d3R2kwV0NEc21zRWlQUWNR?=
 =?utf-8?Q?Em7k=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:59:09.3081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c974e3-decb-4cb9-5521-08de216528dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6301

On 11/3/25 06:39, Markus Schneider-Pargmann (TI.com) wrote:
> Add the system states that are available on TI AM62A SoCs.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a.dtsi | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a.dtsi b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
> index 4d79b3e9486af18b8813a8980a57937669ff6095..31b2de035f0f748e34b8919f90251aa0551d9b32 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a.dtsi
> @@ -46,6 +46,33 @@ pmu: pmu {
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
> +	system-idle-states {
> +		system_partial_io: system-partial-io {
> +			compatible = "system-idle-state";
> +			idle-state-name = "off-wake";
> +		};
> +
> +		system_io_ddr: system-io-ddr {
> +			compatible = "system-idle-state";
> +			idle-state-name = "mem-deep";
> +		};
> +
> +		system_deep_sleep: system-deep-sleep {
> +			compatible = "system-idle-state";
> +			idle-state-name = "mem";
> +		};
> +
> +		system_mcu_only: system-mcu-only {
> +			compatible = "system-idle-state";
> +			idle-state-name = "mem-mcu-active";
> +		};
> +
> +		system_standby: system-standby {
> +			compatible = "system-idle-state";
> +			idle-state-name = "standby";
> +		};
> +	};
> +
>   	cbass_main: bus@f0000 {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;
> 


Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis

