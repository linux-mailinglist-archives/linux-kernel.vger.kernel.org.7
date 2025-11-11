Return-Path: <linux-kernel+bounces-896148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 135E5C4FC27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE334D222
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A03A9BE4;
	Tue, 11 Nov 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kro/PmRB"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7F3546E9;
	Tue, 11 Nov 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894740; cv=fail; b=g9AiIw7yOZK6tVT16QSmWwTbfAsQa1V+F7Q3/OPPs5Py95Mnspp+yxoBB4xggv8eqbclWiUuvpGiHpYdJCeduyEsZTaJkU/cRgLmuCaIRNcEp8iWrTNdI0xr7IibW/JQSiB9s5XCsis/cZ5APuOXxixP1YajbFrNX7i4QkE0DFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894740; c=relaxed/simple;
	bh=p9CTqckX8XLIjvM1S8KKGkR8YYbwD4hLohEqR1Bp7SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B3N2lGgdStSM2yZIMX1v8onyG9+qsf/6ed79iTDUyinJ24O1teIj0kpmXtPKHCJtHUcigC2BLk12FwZr2Sw9GttbuN9/Qqke0fTihlmAK4ldPVYvScCgOKIvhlCVc9hkzoplvV7WBXdd8BZzr7XDqqTDP5OFNQXMFWmtnYkKJp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Kro/PmRB; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvibsm/3sy9ieaEg2prwLSa1xnBXqbFNHGNZETISx79mQ77rAWeD+HPqo4SAydifyby3tdsHovg77Rpcv7svJ+aYAjXuojU/Zv9vOSMUalEjnAhAKM+zZ3tg19MZfNteBCNuvZ9/2lUwa199jEtTCe+qHIBIwglGOJqCV8mqAUPUaHq3yJAq/MC6YaRCbw1NJ8krQO2ZzDPk+Z0NRM4DlSbKqwL0ATxbTJESw9JkSFG9BG8kjqRqWU2Pr8qK7WSBWl/eTFK/xQlSblUsutrpGW8NYs4GnbAGuCyVmQDOBOb8aejURi66xwd8PbaetImxb4fqRYL+pRzHIqhvbGUOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXy2E+QaVntRJX+vTifDXFSou+p3SdEJVKqGd+ydShQ=;
 b=RyDdNcx7J+x+OD5zu010pn3aHtSaZ6NzXfJtd/IEGq1DBl6zj+HIG8OXl4X4zOlrEl/igY19pilS5mxuAHqjCKwDSmmnBaSQf+ZtILMRFTpqYSM4QIfrPkmAEOANH7hTgUMoVXNlHUaQWDifFm0H5RrtnuXv+xHMwC50BibHTUGfrnPRCPkxKSIaGTBcLz9wpI7bs9sKcIclMpQ5r+/8izXMXt1gA5tYtBxNRp+FBBZewL7IAKeVyxNPyYF9PerOzUOnLO/GTsEwJPvDDQmDMZ/OP2r9Id93s+k8o1OjqZ1XHWqDgKUvyjxobo6UVDrM9In5vx6lFGefHO3ljuIDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXy2E+QaVntRJX+vTifDXFSou+p3SdEJVKqGd+ydShQ=;
 b=Kro/PmRB66EgzA5ujwxzIXzPKYkDiTnW4eJdJPOcLO4d9yiug14bbJDmsnu+vZrbmV50Pbx/7ReweaG/T8TTJnrnGK90iX90efkmucz8zMONJfVNzno7R4I63GB8NAOzgX1UWPCNIvWwzQfJNSBiUFin8OCxTf27VY1h9VD8i/M=
Received: from CH0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:610:e6::28)
 by IA3PR10MB8417.namprd10.prod.outlook.com (2603:10b6:208:573::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 20:58:54 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::d) by CH0PR03CA0293.outlook.office365.com
 (2603:10b6:610:e6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 20:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 20:58:53 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:58:51 -0600
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 14:58:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 14:58:50 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABKwowW1551128;
	Tue, 11 Nov 2025 14:58:50 -0600
Message-ID: <cf5d745d-4d98-4ce8-931b-d496fbfb980b@ti.com>
Date: Tue, 11 Nov 2025 14:58:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] arm64: dts: ti: k3-am62: Define possible system
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
 <20251103-topic-am62-dt-partialio-v6-15-v5-1-b8d9ff5f2742@baylibre.com>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <20251103-topic-am62-dt-partialio-v6-15-v5-1-b8d9ff5f2742@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|IA3PR10MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f4742d-0394-4196-1231-08de21651fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmVhOWVaZ3N2bGMzVzRoeUpTV3NGck5OVnVFclUyN2x3blA2bnNNWGowbG9y?=
 =?utf-8?B?cEFNR3h1SGt5dG9JTy9uTWNtOXR6NzJicnZzRXdzdVhSWnhjRVZ3em16a1pz?=
 =?utf-8?B?aHNFZWFEd0d3amFMbHFDMnlPeUlDVXM3NWhwa3pvNUtlVGlLSWNldm1GbGFs?=
 =?utf-8?B?dnNtbm15UFBPVXhsVjkvNnZzSnJXdFBiZktRQ3VFUndsTk9vZ3E2V0RzUXlQ?=
 =?utf-8?B?bUo5byt4ZTZoTkowdFB4cHlvNERLcER5TVRUcWJ5akpqWm5aOEZBeUtOQ3Jt?=
 =?utf-8?B?K3RhcjdES0gwcUQ2c2xwWnRYa2NWMkZQdG81a0d1eDBUdkVGUzdTTTVPWGFi?=
 =?utf-8?B?ZjhkUkFrNFUrZWw3NlAxcDJaT3d5NGlOR0ZQTjdwcGYxNHcxT09UeHFHV3Fh?=
 =?utf-8?B?aHd1MGpvZzNYZ2xRS0cvODBBMXpERmwvTllVd0VmN2MyLysxWE0zbjlRZnAw?=
 =?utf-8?B?T1BhUGRBMGQ5bVV1WWQxUFIycno5QXBzT002ME1zb2l3UFJPbEF6QVIxMk5u?=
 =?utf-8?B?OUJURzNBZXBLbzFsT3I2ait0VjlCS0xBclAzRlA0OXJWVjk1Wm9UWXFiU3pF?=
 =?utf-8?B?SGd5QUVIOVVzcHAvc1BWOG12Zk5xZzcvZG9ONVJxU0JNeEhuN21SZlVDM05G?=
 =?utf-8?B?YTBvL2VSVENLRCtWUWpYMnZxWkVBSXNGdmp1VUJSamFQQ21XZGQ2M3hBLzZm?=
 =?utf-8?B?SWRuOUVSVEFjOXVyTFBNY2JJN2hsbzEwa0o1VVQ0L1NnMUJlY0U1eFVORWpp?=
 =?utf-8?B?WmxaTFJkWXZ0dCtkeVNxNm8wam1TcFJPalFTU0d4cjU1TkxKSW55MUdWY09a?=
 =?utf-8?B?NUR1aXhVWktJdzhncnZvMldkRXFuS3R3R1IrM0lLc2JVS1M0Y1B3TmNTVTJV?=
 =?utf-8?B?SFNtMmxBWFFKYnJJSVlXaWVHUHpLQitFNlM2V2g0am1WTlVKRTJCOHFDUnky?=
 =?utf-8?B?WnVpMVJYU2g4R0FMa0kxbEhEYStOUnc1MVpkZnAvS3JxRDcrRjBuOVdnZ1pk?=
 =?utf-8?B?Wm5qVm9TSlBvOTJZMTVONkk4dFFPekg5TlpqTTFoYk1FODV3RGN3V2gxN3VU?=
 =?utf-8?B?TjhiZlE3Wk92cjJTSU1MQ3ZRQk5ub3JaTk9TbVVhWGUxVGhJN040cXlITndN?=
 =?utf-8?B?ZmdJSkNFbVZ5NE1jTXAwdUdraUs3a3pYbzExOXdSR21rUmVRQXh3d0tEZUFF?=
 =?utf-8?B?UXdkUi93MENXRktEVUlKdEhaQlFBdGtHMDN3Q2l4K0k0LzlVT2NnMHNwNHU3?=
 =?utf-8?B?R0d6UE4yMFV6SFVCSnlmS2FjZDdJRzNoK2QvLy9IdkRMbGt0Y2tVOFpYU29P?=
 =?utf-8?B?ajRSMWwwVlVFenVuaTRuY1B4dnJaNVV3VUVsZlFaUitEbENjSHRrd3o1NGlB?=
 =?utf-8?B?d1hyMUhaeTFEaEgwcnQ0QjVLTnp1S2Fqam9xZnE5RTYxaVFLNXgzUFN3NU9j?=
 =?utf-8?B?M3IvZ2NhSDdaTnBnMDRwVGU2REdKQ2gwTXpRbnRpVXhMVlNhVnlkWE1Bd3pE?=
 =?utf-8?B?Q3djRzNuU1kzYXZSZi9Cc01hQ3lNcDhSZ3ZHK3FpSDdjWnVyZWdEYmpIOEs3?=
 =?utf-8?B?UVVDd2lEQkRuck1TNysrdHY5VVcvVlB2UVN6WldsVlNiWTV4N3VibXFiNWlm?=
 =?utf-8?B?TjZjNnJWb1RKV0NtNnRMR3JBL2cvRnBpbTNIRnJYQnNlUFhDdGxTa2V4aWxu?=
 =?utf-8?B?cjkxdkRjK2JNQ3ArOUVuQ2pRYThscE41S1h3UWVON2trc0ZFZFJ6d212Nll0?=
 =?utf-8?B?MzE2NkV1Z2lRdkNxN1VKSURobDZobFB5c1E5NTZOR2ltSUd4Qy9DNkltWlpS?=
 =?utf-8?B?R1htU3J0WE5Od1B6bEtpY3N5RWM4bjgwRkpOcUtNa3dvQ0FWNUlwMGZZamFj?=
 =?utf-8?B?Ynh6UzNIYUs3alJ6VnRTaFVGZkc4bVN5Y0ZFU0hWV0ZCa1Y2TjNuOVo4Q2xp?=
 =?utf-8?B?dno0bEoyVVowd1VrY2t6aEpkaVVVTi93Y0NtTm1mOGMxWUEvUFpxcHhuLzJP?=
 =?utf-8?B?YzNGOXNGb2xyQUwySjhZQ2RPb01ldkwvUkEvbTZXK2JGQXlZQThlcXFZM0xK?=
 =?utf-8?B?emF5Yjh0Z2JqRktOMVlUcGFXQWRDTVdoY0hGQ2FHRWF3ODRja2FuNTMxMWN0?=
 =?utf-8?Q?vtpY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:58:53.9951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f4742d-0394-4196-1231-08de21651fb6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8417

On 11/3/25 06:39, Markus Schneider-Pargmann (TI.com) wrote:
> Add the system states that are available on TI AM62 SoCs.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62.dtsi | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> index 59f6dff552ed40e4ac0f9c7077aa25d68d3b5283..b08b7062060ca12ecae83917a831ee779f1a288f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
> @@ -46,6 +46,28 @@ pmu: pmu {
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
> +	system-idle-states {
> +		system_partial_io: system-partial-io {
> +			compatible = "system-idle-state";
> +			idle-state-name = "off-wake";
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
>   		bootph-all;
>   		compatible = "simple-bus";
> 

Reviewed-by: Kendall Willis <k-willis@ti.com>

Best,
Kendall Willis

