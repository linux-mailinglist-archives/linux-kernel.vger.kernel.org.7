Return-Path: <linux-kernel+bounces-896146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D61EC4FC18
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76EF63A66FD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAACA3A8D7C;
	Tue, 11 Nov 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rc/MsYI8"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46E83A5E9B;
	Tue, 11 Nov 2025 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894684; cv=fail; b=mCWh2HIc65QJhgxZjf7jXuswfNOmAMT4P8H/Ea9x2+HqEAOkP9Q93nkTporJubx530TzCm/3BQynGPqnBhBREXCCuhYmlffQ3Vb5/+HdCrIIy2P4hjh3GRKqgeL2zgdMxkJfIKiZusyQWCmNNzMKStsvn8A3W0cdxiePceObSA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894684; c=relaxed/simple;
	bh=7iqTvm9finSAXvkTyN3+X3HpyC+vcHBKKSzEcWfzdx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZSu0EGJsgcADlPJWgABO5wIDSUKGC2tyeD9SmFabVQS2ABhKVhuBYGdhSRblCV3zv4NEhf9JiiP8+8AemCB0BTsmdb/4YB8VHw9vT7BOXZ8WXs1bSn3YA2HJTIsvDRfDrmRttWHdsEz9MI68XAGye8dnQR3ZPTNCkLOd8Q3LPp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rc/MsYI8; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDdrdCk6aQLW1i9PJEK88jXFScUcC70JPFogEtfp4ap29r5gZDkzMGcQ6jLUgYjG2A7BmUlL2WvjdtLbFcTJsUGE2FKBzH682t0mWl9ki31fzHLKidrYNsR2zuVZ6e0vWjNXmCIwea+gW/LB/Cr42EZCmuD0gksPgarKl03CY6/PPgNtuQ6WFJg/JCnj4EbFx414Bf9eYRg+5FKkMJ9dXvanS2jSUMqTNKVgzBk0S2OrHVb3Otlh9QJbknHfFeq0wz+WZVW2nmFACEs/cJmK/XMRVDQ/SKlMwu+AbbAj7nxJNtfx/5mAoJ5tB9MmiNqMvBu5gFYY5yxJ1zIZGSZn5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjdlGAdaYWkBb/6nFSLN04jc6cM78S9Jz7sxlTA87yk=;
 b=TgyHfagUWqHDp6xGhcNC4Zn4TRxwF6pqRSELUqoVUmHTvHxTL8AB2FbWO8VINuk9XrsUnCzbMBwKo7Tfp/wmCU+xiOcwP32rHsuV6y1grtatU1KcOwCxS1ElM4YUpitcCarWOAlOQkyAGjMA93XfG/r/cKtsep9Wuh8b7/x93OBEDmPmUzcnXuKc57jhXU7kKnALb7+muuWRT7TcbtHx0eM4/1zBNvQo4hEZMTJ8rw/ptbYBxMsPrFdfxtyPeG+Kd6zYKnyklDGj6EZoW4RGLuMhtBGtpFGhP7oaESx+6mLOeuhTED1rfeVOUdJdrlte8fAcdgZKRKJHb1CFSDaLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjdlGAdaYWkBb/6nFSLN04jc6cM78S9Jz7sxlTA87yk=;
 b=Rc/MsYI8mV3mkyOBFvLD6Hvj/7bZCc0hcSjU2D/7w/eE7AVzu8WC0DCktKmDZBOc2RQp3EfTKXV+hSKyCcuYOlcfU77NJCIoBknEB7FKKYgE49L2lALt+KvZqIKci92tXZvCF6bvlaMAXpaoX0cmKYf17GqW2qSB9GdIEnL41uE=
Received: from BL1PR13CA0104.namprd13.prod.outlook.com (2603:10b6:208:2b9::19)
 by BN0PR10MB5125.namprd10.prod.outlook.com (2603:10b6:408:12e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Tue, 11 Nov
 2025 20:57:59 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::7b) by BL1PR13CA0104.outlook.office365.com
 (2603:10b6:208:2b9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 20:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 20:57:58 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:57:52 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:57:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 14:57:52 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABKvpSJ1517626;
	Tue, 11 Nov 2025 14:57:52 -0600
Message-ID: <fafe395e-b8d2-4a46-9884-7241b24d3b06@ti.com>
Date: Tue, 11 Nov 2025 14:57:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Sebin Francis
	<sebin.francis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
References: <20251103-topic-am62-dt-partialio-v6-15-v5-0-b8d9ff5f2742@baylibre.com>
 <20251103-topic-am62-dt-partialio-v6-15-v5-5-b8d9ff5f2742@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-5-b8d9ff5f2742@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|BN0PR10MB5125:EE_
X-MS-Office365-Filtering-Correlation-Id: e87210c3-ce26-4031-336d-08de2164fe83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ZHaUVObElxUUFPM3F4YUIwSUk5SC9UNlJuLzVXdHFVclJWQ3NTeHVNeThM?=
 =?utf-8?B?UUhUSDV3M0xZOG96d3Z2bTBCSnYxRVA2NTVucW5DZ3VGeGVwZjQ3YTF0VFNr?=
 =?utf-8?B?bTd4SGs2TWRzRXF5d3JkRTFuMTZ4OWhsY21FQlBqMFFBRElPRVIrczJkYVFj?=
 =?utf-8?B?S015b3kwOS81QmZxL203TmRqcE1jY1VzODZsUnFrSzJLV0k3OGp4MGNmU0Ny?=
 =?utf-8?B?UUJ5U01HNE0wVDB6cEd1ZS9zdnM0UElveDlQWGJTWHZhUVdjMFhPbkNpd0hz?=
 =?utf-8?B?VmtFbDR5RDIwSXZtc1hLTzdxeXJOL2tFRXRRbktzOEZQZm1lZ3ZDZy93cENn?=
 =?utf-8?B?K29BemhtcGpldXM5NjE1c21JSGpXRm9VZUMybnlzNlUxeWg4VjBpbGRJbEdI?=
 =?utf-8?B?U3kzTnRCWDZFRTVQZThLTVNGaFZ1S1FrZ1dPaHZ3MzJ4UzhVT01pbnBIOHd0?=
 =?utf-8?B?VWVtV0dUcFdWQWg3enVieHpXalRVL0xYN3NCNVJNbTROOTFEZWtZOWdlM1BZ?=
 =?utf-8?B?MElNN281dEJSTE84anNnZVoxd2dMSUlhOHRtSW1XUGxLSkh2KzdvMXAxWHBn?=
 =?utf-8?B?alpjOWpjRmx4UkFYeFhJYzVTTjRpZk1XR2RBazZ3SUlscnQyQkMyVU5penZS?=
 =?utf-8?B?cG5xVVpLdko2YVV5c0k1UDVsQzIrbWZHZUJSWFZyVVR6am1EbnN0M054eU5Y?=
 =?utf-8?B?Z3loM1ZTQyt2M2ZTZHlSYSt3K3ZBSGRSa3lxZlNjcXBiaXBmSnczdUx1dlBK?=
 =?utf-8?B?WXNZT2FMQWNPcWlJYnFIeG9mMkRjT2V5aDUra3laeldLUzJQb09Tc0F5aGJX?=
 =?utf-8?B?Q2lmMmczS3BVUWxIejZvUlZ0Tk51eXdZSllCSU1XZ1JGYnd1a1kwVEVIeUpF?=
 =?utf-8?B?WnFBeSt1VFBaaWdraWpoZ1VFbVFiQWpUQ2wySnpjeno2NWhma1hBeXE0OXdq?=
 =?utf-8?B?Vk13Q1dYNzZKVGNIWnV3a2RjTHF4V0VaUTR1T0lNSVYxa2tZUSs5SlltUjFN?=
 =?utf-8?B?L0VZaEhSdmpiek01NVpDK05IMVRiNjZQRGsrOHRzTFpaTEZDYndDVlFZQzVF?=
 =?utf-8?B?enE2THhDbURHcWtSbkZFY3pjVEg0UldZbjgwbWZTek1TVy9rWENnYlJ4UUNU?=
 =?utf-8?B?NnJpRGZXRTN5U2dlQzZBRFF5WDF5NFBYY0h0cmdqYXlyL3FsVURmc3Z0NEcr?=
 =?utf-8?B?eWl5RUc0aUJQeFY4a3pPYlROMzlOS2YzQ2lONDRNQ1VXNTE2Q0NLbE80Q2Nh?=
 =?utf-8?B?NVk4N250MWJYQWp1V0V5cW4xdnlhV1YxYkxCMDRoNk9YU0QxT2tJV3JMTVRi?=
 =?utf-8?B?NlQ2OGFXUkhLMm1oUkN0TG9UZU5lekF1QTBTeHlpajJ5RmdESWlpUjE5em5u?=
 =?utf-8?B?ZGZiWUhZR3ZsVUd5MFpLM2tNbXVMQ3lUb1JxR29vQW5nbDZ2ZTdQZjVNckNw?=
 =?utf-8?B?bFp4UlNuNmkrRmk3Y3JEM0cvMjNVbXNTRXZWV2hZVmwrNVlzWlcrN243SFNS?=
 =?utf-8?B?M3Z6dWk5clczZXhwcmhYalNKcDFWWnNQN1lhekV2RGVld0JYTFY2d1U4M0xZ?=
 =?utf-8?B?N2VxVERwb0dUa2JyTFpIRHZCREVZK3JTWWt3aVlrL0plZHdldG5randZWGpW?=
 =?utf-8?B?WW1FOUJrU3U3TUJUQ2xNZzVJVWlqUEtCTHZNOVh6bCt0ZGtWUnJlcnhRazR6?=
 =?utf-8?B?ZGtrNnhQTGo3WDdjT2VONG5PSEg2bVlMc3B0Q3piSTFRaFh2OTUrQWlaWlVN?=
 =?utf-8?B?Y0hpVmFqdWIzNFZ5aTFac1IwalJudzVHSnp4YTBienRQSmlpbyt6MlZKSGta?=
 =?utf-8?B?b2xaK2ZINGltOE51bmZadHZqUnlGVkRqWDF6L3FnS3VVdU83NmlKSGhPelBO?=
 =?utf-8?B?ZHc3VU5RQ29hcDNBNngvdE8wYjMxOHo3Z1FDTjlVUlhCSE1qK0dXNEcvSVNz?=
 =?utf-8?B?MmhwYmVZSERZK2VHRmR6ZklET2gybng4MVMrSzU3dWc0OXFac0l2YjRweHpV?=
 =?utf-8?B?TUx3MVA0L2ZuZFY4Vng0VkJnVEo5ckcxbXJmT0V4SkFnN25STDJMZTUwbFBL?=
 =?utf-8?B?YlJPNVgvbmJLbElmT1VDeWJ2UC9lNC9naU1oZWpVbHk5WXVwTmNMMVpROHNQ?=
 =?utf-8?Q?5qJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:57:58.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87210c3-ce26-4031-336d-08de2164fe83
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5125

On 11/3/25 06:39, Markus Schneider-Pargmann (TI.com) wrote:
> The CANUART pins of mcu_mcan0, mcu_mcan1, mcu_uart0 and wkup_uart0 are
> powered during Partial-IO and I/O Only + DDR and are capable of waking
> up the system in these states. Specify the states in which these units
> can do a wakeup on this board.
> 
> Note that the UARTs are not capable of wakeup in Partial-IO because of
> of a UART mux on the board not being powered during Partial-IO.
> 
> Add pincontrol definitions for mcu_mcan0 and mcu_mcan1 for wakeup from
> Partial-IO. Add these as wakeup pinctrl entries for both devices.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 69 +++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> index af591fe6ae4f0a91991d2904a9a61905a0eeb614..b61370db6986308ec97983f796b993a26debcabc 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> @@ -233,6 +233,10 @@ AM62AX_MCU_IOPAD(0x0030, PIN_OUTPUT, 0) /* (C8) WKUP_UART0_RTSn */
>   &wkup_uart0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&wkup_uart0_pins_default>;
> +	wakeup-source = <&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
>   	status = "reserved";
>   };
>   
> @@ -426,6 +430,42 @@ pmic_irq_pins_default: pmic-irq-default-pins {
>   			AM62AX_MCU_IOPAD(0x000, PIN_INPUT, 7) /* (E11) MCU_GPIO0_0 */
>   		>;
>   	};
> +
> +	mcu_mcan0_tx_pins_default: mcu-mcan0-tx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x034, PIN_OUTPUT, 0) /* (D6) MCU_MCAN0_TX */
> +		>;
> +	};
> +
> +	mcu_mcan0_rx_pins_default: mcu-mcan0-rx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x038, PIN_INPUT, 0) /* (B3) MCU_MCAN0_RX */
> +		>;
> +	};
> +
> +	mcu_mcan0_rx_pins_wakeup: mcu-mcan0-rx-wakeup-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x038, PIN_INPUT | PIN_WKUP_EN, 0) /* (B3) MCU_MCAN0_RX */
> +		>;
> +	};
> +
> +	mcu_mcan1_tx_pins_default: mcu-mcan1-tx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x03c, PIN_OUTPUT, 0) /* (E5) MCU_MCAN1_TX */
> +		>;
> +	};
> +
> +	mcu_mcan1_rx_pins_default: mcu-mcan1-rx-default-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x040, PIN_INPUT, 0) /* (D4) MCU_MCAN1_RX */
> +		>;
> +	};
> +
> +	mcu_mcan1_rx_pins_wakeup: mcu-mcan1-rx-wakeup-pins {
> +		pinctrl-single,pins = <
> +			AM62AX_MCU_IOPAD(0x040, PIN_INPUT | PIN_WKUP_EN, 0) /* (D4) MCU_MCAN1_RX */
> +		>;
> +	};
>   };
>   
>   &mcu_gpio0 {
> @@ -852,4 +892,33 @@ AM62AX_IOPAD(0x008, PIN_INPUT, 0) /* (J24) OSPI0_DQS */
>   	};
>   };
>   
> +&mcu_mcan0 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
> +			<&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +};
> +
> +&mcu_mcan1 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan1_tx_pins_default>, <&mcu_mcan1_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
> +			<&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +};

Did you mean to set the status = "okay" for mcu_mcan0 and mcu_mcan1? The 
nodes would still be disabled without it since in k3-am62a-mcu.dtsi the 
status is set to "disabled". Same goes for the patch you sent for AM62P.

> +
> +&mcu_uart0 {
> +	wakeup-source = <&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +};
> +
>   #include "k3-am62a-ti-ipc-firmware.dtsi"
> 

Best,
Kendall Willis

