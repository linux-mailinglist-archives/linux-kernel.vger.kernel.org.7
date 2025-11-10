Return-Path: <linux-kernel+bounces-893182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5AC46B8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48E3BE004
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543673101C4;
	Mon, 10 Nov 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VDpgiB8p"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C873101A6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779293; cv=fail; b=og0XeG2B/juEI2+RiE2mCYgbNAAQRMOFRUg4o+C7bY1SubK/fnhcrlthLLQX5JlP96QoRPsYCICWHtIwSYk9CfX4qn64FajBcf2XXLHjfdUXVQj1UmpLcCw61vGNYcuiRxGV2ZiCLXAJTQXiQHbolJSsvnXyvGzocyqC7RXATyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779293; c=relaxed/simple;
	bh=o55z5Fh/5mO7+Y/qY4OlFw0apno3vkO2zBtAo1Wtl8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ItFImmBv80KgbQeGW6Czb7sP16T78CiYfZlBoJ6ChbWQnenLqrpcRSRvkCMDlKJaz+C7FsW1i2V766KNITDFxg7aVBnPwJCYblkFg7rri30koCnTGFIAZUKg/SuLUJJkHnCv456lBUrP3pa0g8gMLb/jaUM61ceau2JZ6t5HXSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VDpgiB8p; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnsRHTlIFCFNZjJWcpXbDihUPJe6/M+szRsMlu8RikTECc2OjDfCcnsGioKR0ibjhmn11GWf0OMrK9e+d8I/nBkJrW1s0qk1QubjIJHO++6b4TMOJklnKRFNzqHQY5L0h8+/uCg4pvZXFDlSRyXrVFfiOBykoFXPv7XwfUh62kOD663UnpX/0vIvjE+e1zE1ODBWNcoP2RhhF6sKR+O99iKRCloFOg2iIr3vHkadeosBFfUj01CAaKKRzNE39FWiHQC9Rhhd8vKYk1MAq0rYaQquO+X8mZACKtZEXzsqLKxj9Cpw/Dqhhzc6sb5cb4YZRwSMrFX08dZeDlhBQhrHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MITnm1h72Z4xTIFwg+bR7Y3ojjmJnD4x0NTtrVhQj9Q=;
 b=cRQFBQzzrQGDXVod/2J2KfhZFt6ot1mro8dF5tr4/edEuOviioG+jeu5eKKlEa04vazcZqCqBn+4GJkKfyuIu0ZS0QrmEIft9xaYh8QdZKnN3ojW1QcBTb24w8a2kaV+f6NikfqNM13XgodBETnwUhzUkmcxyo7dJ9H+RVHWRAKMf1gE0K3Ee+SmVtBD5zARARypXZuINHPvzvJF0hxaeCpI9n48L0v+v+RtKP+goWHG843kieqQ+gacVcN2ZfLWyGgBzQbUg3U0txZlB4aVCh6e+ZMSEI9AgQIzOYfnWF0O+qXxdx6iTTThStUQYMJSpPmzZvsfU1i68+He8xTWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MITnm1h72Z4xTIFwg+bR7Y3ojjmJnD4x0NTtrVhQj9Q=;
 b=VDpgiB8pPOJ6ohOYYPuNJ/Pk+12B79RYMNktjL4fX3uDGqcPvXoo+Mdwm5u7XXDBxM4audH/gPIiB2YsHlVnT72ttw0b+fwYFv3SjGwN0WQ2w7hAbsmrrKNWelZz1PFkpXQs0PWr1qDMKIMCrLFDpNFoBBN+mkKGXs3wfFnko/A=
Received: from BLAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:32b::24)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:54:46 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::97) by BLAPR03CA0019.outlook.office365.com
 (2603:10b6:208:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 12:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 12:54:45 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:54:40 -0600
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 10 Nov
 2025 06:54:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 10 Nov 2025 06:54:39 -0600
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AACsaFw3428624;
	Mon, 10 Nov 2025 06:54:37 -0600
Message-ID: <1a9e3681-9fe2-405a-b2b2-038d10759f11@ti.com>
Date: Mon, 10 Nov 2025 18:24:35 +0530
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
	Dhruva Gole <d-gole@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ0PR10MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: ee826c48-ec67-4d9d-792d-08de205852cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3FJNE9ZVERrU3pWU3JhTzRWWXZxL1JCUU4xdFdpK1pJN04vbTJkYVV5alAw?=
 =?utf-8?B?QzNQbDZTdVVkYTlJb0hhc1FRR1hEZjk3dXpYaHlWM1AremJxZjlOc0Rrd1Z3?=
 =?utf-8?B?TlpvcmtVaGhQYkw5YlQwb3VDQ3BTODBkZEZYSjZwZ0syMU1CcmZXbElWc2gr?=
 =?utf-8?B?dWJjUXBadHlsSkE5cU94MjlxQ2pWeFRDaTZCTkh5eVJVejBRZmN3TVlpRGJQ?=
 =?utf-8?B?NFZlOXVLWDd5R1F1ckRhLzg1UDlQYlNLeGxnSGRCcUErT0NEZVVCZjE2RGVQ?=
 =?utf-8?B?cFZsUDVVZzNEdkNRNE03UFF3cnN6Y3JHNzBFNUQ2aW9IRXpidkdsMjNZSWYv?=
 =?utf-8?B?dXpZRHNhbXBydnVUbnFNWkYzN1JkZytWQ2FTRUZGRmdROGVTTHJRWUxQSk9N?=
 =?utf-8?B?VUFEOW9JSjVBZno4NnhpT3RnVzU2NERuUkFtZ1B6QzFBWXBYc2lLa1IzM3Z3?=
 =?utf-8?B?a1hRQzI2VzRubkhQNExqZ3dJOEE2dE8zVDVDRlBWWmdmVk0vaHRUZXNIYzE2?=
 =?utf-8?B?VFIyc1A5M0doSEdyRlhPNUlBZEFkSjJtc1VpT3NWTk9oWUVGdEdlWjNJb0g2?=
 =?utf-8?B?U1Q5b0VVM0xOOG5ZUEd2RVpZcENoY1FOVlNkNExJQTQ1V0VSOUZnMUNpM2s2?=
 =?utf-8?B?c0RPNTZ1QTF5TXQ2MG94SmIvZExIWEo1WXlWQW9HeklKVUZCL3NmRUkydkJ5?=
 =?utf-8?B?bVJVSHppTCtrN3pvWkhGYlk4K1kvdlk3eWJGZlcvcHRhQThaTHMrakQveTVr?=
 =?utf-8?B?ZDJLQStUUHFBRTdQczRCdHh4ZjJlSDhwYzlmdkpuVStPekZBS1FZYy84SVhh?=
 =?utf-8?B?cE1XS1Z5MCsrcjU2dE1kcGJBSDVLb01ON0NpRzJYNmJmSUxsVEZGb3MyR1kz?=
 =?utf-8?B?Vm52anFVWDNOQlg1MXBnZjFrTjZPSWNQdTFWUWo1b0U1VkxGMjBrZEJmMDNa?=
 =?utf-8?B?UjZYM1NUdDI3LzRDTTBDc0pjKzhjaUtIVXBGQ0pjSk1mSXV5dFhIMCtzUmVy?=
 =?utf-8?B?ZlYrZEhiUGVwRVJwaTlSVS8zWlU2Rkx1SEo5QzlmRlJrOUpTWVJvYXdPRDBC?=
 =?utf-8?B?cEtzLys1cmdERWp0WFNKa2cxU1VkSXV0SXVYUndhRzJPdGYzQkJnVVpuRWVM?=
 =?utf-8?B?SWpnVTcxVFYyK0xiTVJsbDA0THM0QjUrV2lNaXExQlhQajlMb0hJL29zYTFj?=
 =?utf-8?B?QVdHNDQ1L3I4UitHNEpaR0krUFh4dFQ4NmNHNnpGU2pmcURmSWt6Y0pobWJw?=
 =?utf-8?B?NHVJWEVGWVEzajEyaGZnTmFwN2NkQ2ZRQzFDYTRGcC82V3ROWUxDenkxWCtJ?=
 =?utf-8?B?VWRtbm5NS1diRlphYlZYa0ZEMHcwUm1hL1R3UmFkZ0RYVUtjM0w2NFZ2dGtj?=
 =?utf-8?B?Q3J4cEZHOVJuTmFCQmp4ZDAzeHJucWZUUVBaSUNSWWt2VVhuQ0JQbHNEZllU?=
 =?utf-8?B?QjdzNmh3L2orV2xyN2JqWXd6cnFuSDFVditTelpqVWFURTk3LzVwZDFjNjF3?=
 =?utf-8?B?ei81eFdORFVMR0Z0N1ZKZlFWbkVMWEdpVDR6SmVqSjVxWFpDMDI2QkVsL1ZP?=
 =?utf-8?B?SEQ4S2NhTkJROUhrZm5SVHhaQ2xoeExnQ2ZTMFN6c1ZzNm8vSFR5WG96QjBP?=
 =?utf-8?B?ZWx6RkhQWkEvTDBhT252NWd1K0J5YTV3czZja3Rwc3VEMU5iV0FUbDdRRDFu?=
 =?utf-8?B?dmVTaHRpUUJHUFF4V1cwOHBNWDVrWCsyZVdzOUR2eXZGbWxob29IRUhhdUZ3?=
 =?utf-8?B?b3VPSllsa1c0Y0JNUm5RcFRjUDBkYjhoSW9wSlB1VmtUbVBqK3F2RWhuWGJW?=
 =?utf-8?B?N1Y0UHlEN091eG9HanJHSlZ1dko1Vk94ZUdUcmNEMWZRcGxHdHpDbmdmbnRQ?=
 =?utf-8?B?ZEx2OUdwVTVodFJxQzd0R0VwOFAzTG15Ynh5Mkd6Q1RmQ3UvWEsyWTYvbWxh?=
 =?utf-8?B?dUZqSjdoL2ZWSDJVSGV2R0FzM2ZIZytlY0lDZ0ZVS0JVMHBQSXZlMW9mOEpD?=
 =?utf-8?B?dFBVRjErTzlPWGZHZ0F2WlpmbCswb09jL2M4TDRzL05kSFovNXpxN1RYaHVp?=
 =?utf-8?B?QUdEbFg0UWRVYU5reW1tTFZRMENIZ0J0MEJxakRCZHc3VTUwV09hdXA2Rm12?=
 =?utf-8?Q?U0/I=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:54:45.0670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee826c48-ec67-4d9d-792d-08de205852cf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462

Hi

On 03/11/25 18:12, Markus Schneider-Pargmann (TI.com) wrote:
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

[...]

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

Changes looks good.
Reviewed-by: Sebin Francis <sebin.francis@ti.com>

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

