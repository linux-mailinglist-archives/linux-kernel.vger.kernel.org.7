Return-Path: <linux-kernel+bounces-885262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D543CC32688
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B88A04EA4EC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB4303C9C;
	Tue,  4 Nov 2025 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b6Gn/IiO"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B58433B6F8;
	Tue,  4 Nov 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278127; cv=fail; b=odF2ZsL+zIuJm43umaXiFhsiTMSnzSkpFquKfnRzbJ+cwBVwYVuG3brDIjR5YReZ23eeizYOBvVHPtYnWEYtQORgutrPtHMyoJHzJmvBsY3M6h7PbEoX5WmHZlPZd5aGz0PsuXJStI/yhFXzr0/zmUza4sYbX6bbwLtg1X3+Md8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278127; c=relaxed/simple;
	bh=BCu1miLxeAB7bCvrYwcRgPd40mU3y2u9lXnep7RdR2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KOiBoow4qhUYIwyYn6rYHXwF0y8lspX/ElTKnhMw7tDTJC1GYC1/STIBW0hSF6FwUQ4wP77qmJqhghZd8bLPCFGkU9KN5M4wrvfSDOx68yAhRYsMgGO3dbnvvdMCZOjRTfnT+00nMkCN1ff4huJHs0ri1u4FlkfCrvaXKmL2ktM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=b6Gn/IiO; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC5JoFXS7mEISEVjyRaeDhEaHbgI1o7BpcheAuZ1yTVewNndQ+ovQgBoJYeuZquEhpmyqXcr6W9FAKATsKGhkIeC5NMnMiWnmwoVifUBWOzVgnerTubxupKDdU4fyQtoNwcJlqYq1k2C4O4/fQhAqzEDE+XgJX8jaRyox3NbF455P3bME3VpPP3orQvqLlytG9n9qF9jN/j1zEOcLTx7mogAbLU2MVXn7lqskQ/od3EH+M40l0S7BtfRsC2poXcYgwT2ShUyyLWwdt090CYFO35lxjIEBSK5T3TD8gjt1FAPGnfI3Kt50vfBEVetKZIPgoJD9MhkJ/ymrDfoYDVb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps8gb1UFiKQlKpg6ERugQFNxrtusopktfYr9lJ8xNGY=;
 b=FMFeNLpNtTMPq/uk7OZ1D91IMNUBONPVcrdGm3sSbGdR7Jp0ISXinxNZq1BvIW3nfEDc8VrwlYkfWL0rIDgC1W0IU3aY1rl3eBYRu2IRZYuFm6dtAjZ4y7c2X16QsAQQ8ZGTcX8t2QkoAV7WkQ7w3kMeqwu7t6a63giCZwzbDnvWkPzh2HwN9YEaYZjmCeaaRa91yMu0X7dhAi/IBoaVJxBiV2/MpteuDGlyXrP0xqiHG2E8VrmibIAHCHssJcs9o/iMdUE2Rk80ELHIDitfc5QIJI/+d/3zaZeo8ZAcdlIrm3eli1jgc3wBkOSJOqV/VYJWQhnvJFDD3QzDAFkh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps8gb1UFiKQlKpg6ERugQFNxrtusopktfYr9lJ8xNGY=;
 b=b6Gn/IiONGF1lX5N4Bd79jJ2W6vvHEqrdAAHtA4gcr1QzB5pOw2KMrTSsnN0Wgy6z72kvBzPK7B/0vq9/CfbTVxEJgP3lMX0c4IVpNk2UTPx88BH8gDjdm0sz3/8RdEMOtKxYOwpgP0KFG4+JLRW8iOL+3TfBtpZ6lPKaH8IGVk=
Received: from DM6PR08CA0053.namprd08.prod.outlook.com (2603:10b6:5:1e0::27)
 by DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 17:42:01 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::5c) by DM6PR08CA0053.outlook.office365.com
 (2603:10b6:5:1e0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 17:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:42:01 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:41:55 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 11:41:55 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 11:41:55 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4Hfsnm2306194;
	Tue, 4 Nov 2025 11:41:54 -0600
Message-ID: <d77bf3dd-4501-4f17-a776-3353f96f4fb1@ti.com>
Date: Tue, 4 Nov 2025 11:41:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: dts: ti: Add Aquila AM69 Support
To: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Parth Pancholi <parth.pancholi@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Emanuele Ghidoli
	<emanuele.ghidoli@toradex.com>, Ernest Van Hoecke
	<ernest.vanhoecke@toradex.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
References: <20251104144915.60445-1-francesco@dolcini.it>
 <20251104145240.61219-1-francesco@dolcini.it>
 <20251104145240.61219-2-francesco@dolcini.it>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20251104145240.61219-2-francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DS3PR10MB997700:EE_
X-MS-Office365-Filtering-Correlation-Id: 65885de7-1bf9-40cb-4337-08de1bc975c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|376014|7416014|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nmwyem1STThOeWtoZzVyMVhGdFdzUDB4c2Zzb0RURlhybEpTQnhPZHBrWTU3?=
 =?utf-8?B?NUdqbWNqTG55OFhqTjBJcStmK2hQWGg3SVFZZ3RTRE9salFZZkd6K1VaR3g1?=
 =?utf-8?B?L2k4TzFYZUp4emtsbkE1Mi9tcVFpR3hydkl2cEVsSUN5ZjFVdWNlcjhqMi8y?=
 =?utf-8?B?SFdmazhIa0xJTXp3WjhJTTRzWWxXSzZnWVFWUnlzQkJuS0gzMUpVREEwa0lk?=
 =?utf-8?B?RXhjQ3E0YmtRdUpWMUswcy9vT1ZCRXJ3QmZvemNXcm5MWmUxdlowNXJ2N09Y?=
 =?utf-8?B?ODJDTVVNaTBNWWZ6emlOZkdsQlJxME1Nd3FRUWg4TnlNWm5TNkZVZVczVWdt?=
 =?utf-8?B?ZnB4SXNEZHUrMHgxUVhVVFMwWTU5TGlJUCtJQnNoUlJ2MWdKZm13eUNCZ2xB?=
 =?utf-8?B?ZFF0Q3NjZmQ1TFFhUlRkejc1N2dPR0hTcXRtK2VOdDJlUkZuQ1VpdklaQkha?=
 =?utf-8?B?Ulg0Nm9xaWJ5bVlSbE1uYWZlR3BmNlpPQzlrVmVlK3NROE50RVBkSDE1Y0Y2?=
 =?utf-8?B?cUIycVZ3RkZsQm1Ucy81UzdvZndUMDc0c0FWSWlmNHlnQmdUbk5UaWlWbkxE?=
 =?utf-8?B?eGZOK0pqV2hYVlhKN0QrUWFxaldKNDJFOGFjNHNqMEFudWd6cEZHanpybEFU?=
 =?utf-8?B?WWRndXhTZWp5Y3hGSCtXeEl4cmlwRldhbWtaZU96S2pZSWE2TUtoMWlLV3FE?=
 =?utf-8?B?ZDg1cFVxWEx5SmpWb3F6TjZTU3NKTkE1QlF5ZjhOeGxJK3Z2Rm9BVGVJRjdT?=
 =?utf-8?B?OUxZWEYrVEFpbEFtaytsT3RiNFFmR1k5Z0dQbEFsWlVONDYyRFlxUFcrbWoz?=
 =?utf-8?B?UHphRE5lUjhNUU95OWlOWitHWXFRRDBhN1dVaVJ5VmVLenlOZE9tT01KbzU5?=
 =?utf-8?B?NjZESHJiTTlDUy9OejQ5cmk1ZWE4NlB3WXZZeDV5b1pDclRDSExwdU5YVXli?=
 =?utf-8?B?ZThaMmwxLzdmMmJJOWtNRlVIWHQwL3ltMUtoWWt2ZWFtZUExL0F3OVp2aU14?=
 =?utf-8?B?NGNIMnVkdHA5WGhxcnZFZ0pNazJIbm1uRmxFNTFudjhqR3pOcURMZUZlSFpN?=
 =?utf-8?B?bktkUGp1UkQwamtGdFgvUVc5VUVHQ3NJRFE2cW9UUUtlM2xMdDIvMnNVL20v?=
 =?utf-8?B?WVF5WlduSTZ4dzVYQWVRU0lVdFhyZTVxNGN6Zjc0VlB4T09QY2JacXhvelBP?=
 =?utf-8?B?Mm5OVGZqS29VWm54TERFU3plQnRCYm9GMmVSSWJHRDNMUVBwNStES2RYdHVB?=
 =?utf-8?B?NHBBeEdSZ3dGY3A5ck5JQ210bVFxNTdrajRsaWU1T1djb3V1QS9VS1dtZG1I?=
 =?utf-8?B?VjVRUjV1ckdoMkpKOFJnOXRlSGU4WXYyL1RiZjlsUHFPUjhQN0tpejQyTXU4?=
 =?utf-8?B?U216VVhlVU9XVDlkZDNqSi9lNkh5Rm1XcWpRVFBOREtaOEVGekw1ZktLZHFY?=
 =?utf-8?B?UzdEby9UTDV4enc4WGw1bFE4ZFFEam9QUnQxZFF0aUNWdnJjcWxSajdlNzBx?=
 =?utf-8?B?aHUrMUlhL1lrNHRtV1NQNjhYRXNqY09GMDFVODdnQk1nb0JLS3dkbjZ3UGtL?=
 =?utf-8?B?STlTbDZxUjcxMksxUTNNUEdKdm9lbWtYQS9UVFduVndvQU12aDYyYkkzVUpM?=
 =?utf-8?B?UHlGMHRwZUZyd1pFZ0NOb1VlOTIrZnMvM1d3dHYwMEpLT0JUNnBpdDJuV09j?=
 =?utf-8?B?MnU1MVMzMVZpNmVhMUg1YmU2MDhuNFNYN2RhUU9kOG9rb1dIZ2FaVndqTlpU?=
 =?utf-8?B?M3Z0RlE1WnNaM3M1Mk5BY09VeWdvMHF5K0txb004STlVaUZ6U1ZZY2svMXNK?=
 =?utf-8?B?YXFCVmx1ZEtWUW4zTlBaVGZQU1RrcWJlYk1sYmpDM0xRa3ViWGRDSWl2TG1n?=
 =?utf-8?B?c2VsUXo4QXY0enpqaEpmSFVSQzhpbE5aT0NpWGRVTFdUMGtSS2F3NU83RTJj?=
 =?utf-8?B?RU4zWXdnZnhxakFUUE1ITzJxZ014aWE0QndlYkJpUzBxTUw2Y3hBVk85bEYw?=
 =?utf-8?B?VE9OK0pRV285N1praEFpM2hFYjlmVXNGT25NcWgwNUsxMVo5cTBOL09RL3hz?=
 =?utf-8?B?bnp6dHFTTHFlRktER2dSMWNvUFE3cFJXRXExSzRHWndKaVh0bS93Yzh5ODF0?=
 =?utf-8?Q?rWiU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(7416014)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:42:01.0546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65885de7-1bf9-40cb-4337-08de1bc975c5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997700



On 11/4/25 8:52 AM, Francesco Dolcini wrote:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> Add support for the Toradex Aquila AM69 and its Development Carrier
> Board.
> 
> The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> family and is designed for high-end embedded computing, featuring up to
> 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
> Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
> a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> Temperature Sensor, and optional TPM 2.0 module.
> 
> Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Co-developed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Co-developed-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Co-developed-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> Co-developed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |    1 +
>   arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts |  576 ++++++
>   arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi    | 1840 +++++++++++++++++
>   3 files changed, 2417 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am69-aquila.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 361248dcfff4..6ce652fe98fa 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -153,6 +153,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-rpi-cam-imx219.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm-csi2-quad-tevi-ov5640.dtbo
>   
>   # Boards with J784s4 SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-am69-aquila-dev.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am69-sk-pcie0-ep.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> new file mode 100644
> index 000000000000..c7ce804eac70
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (C) 2025 Toradex
> + *
> + * https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> + * https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pwm/pwm.h>
> +#include "k3-am69-aquila.dtsi"
> +

[...]

> +/* Aquila SPI_2 */
> +&main_spi0 {
> +	status = "okay";
> +};
> +
> +/* Aquila SPI_1 */
> +&main_spi2 {
> +	status = "okay";

Why enable this with nothing connected to it?

[...]

> +/* Aquila SPI_1 */
> +&main_spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_main_spi2>, <&pinctrl_main_spi2_cs0>;
> +	status = "disabled";

This is already disabled by default in the SoC dtsi file.

Andrew

> +};
> +
> +/* Aquila UART_1 */
> +&main_uart4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_main_uart4>;
> +	status = "disabled";
> +};
> +
> +/* Aquila UART_3, used as the Linux console */
> +&main_uart8 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_main_uart8>;
> +	status = "disabled";
> +};
> +
> +/* Aquila I2S_1 */
> +&mcasp4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_main_mcasp4>;
> +	op-mode = <0>;  /* MCASP_I2S_MODE */
> +	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
> +		0 1 2 0
> +		0 0 0 0
> +		0 0 0 0
> +		0 0 0 0
> +	>;
> +	tdm-slots = <2>;
> +	#sound-dai-cells = <0>;
> +	status = "disabled";
> +};
> +
> +&mcu_cpsw {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_rgmii1>;
> +	status = "disabled";
> +};
> +
> +/* On-module ETH_1 RGMII */
> +&mcu_cpsw_port1 {
> +	phy-handle = <&mcu_phy0>;
> +	phy-mode = "rgmii-id";
> +	status = "disabled";
> +};
> +
> +/* Aquila I2C_1 */
> +&mcu_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_i2c0>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +/* Aquila I2C_2 */
> +&mcu_i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +/* Aquila CAN_2 */
> +&mcu_mcan0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_mcan0>;
> +	status = "disabled";
> +};
> +
> +/* Aquila CAN_4 */
> +&mcu_mcan1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_mcan1>;
> +	status = "disabled";
> +};
> +
> +/* On-module SPI (TPM_SPI) */
> +&mcu_spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_spi0>;
> +	status = "okay";
> +
> +	tpm@0 {
> +		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
> +		reg = <0>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tpm_irq>;
> +		interrupt-parent = <&wkup_gpio0>;
> +		interrupts = <81 IRQ_TYPE_EDGE_FALLING>;
> +		spi-max-frequency = <33000000>;
> +	};
> +};
> +
> +/* Aquila UART_4 */
> +&mcu_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_uart0_rx>, <&pinctrl_mcu_uart0_tx>;
> +	status = "disabled";
> +};
> +
> +&mhdp {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_main_dp0_hpd>;
> +	phy-names = "dpphy";
> +	phys = <&serdes4_dp0_link>;
> +	status = "disabled";
> +};
> +
> +/* Aquila QSPI_1 */
> +&ospi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_ospi0_8bit>, <&pinctrl_mcu_ospi0_cs0>;
> +	status = "disabled";
> +};
> +
> +/* Aquila PCIE_1 */
> +&pcie0_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie0_reset>;
> +	clocks = <&k3_clks 332 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> +	clock-names = "fck", "pcie_refclk";
> +	num-lanes = <2>;
> +	phy-names = "pcie-phy";
> +	phys = <&serdes1_pcie0_2l_link>;
> +	reset-gpios = <&main_gpio0 32 GPIO_ACTIVE_HIGH>;
> +	ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x3>;
> +	status = "disabled";
> +};
> +
> +/* Aquila PCIE_2 */
> +&pcie1_rc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pcie1_reset>;
> +	clocks = <&k3_clks 333 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
> +	clock-names = "fck", "pcie_refclk";
> +	num-lanes = <2>;
> +	phy-names = "pcie-phy";
> +	phys = <&serdes0_pcie1_2l_link>;
> +	reset-gpios = <&main_gpio0 41 GPIO_ACTIVE_HIGH>;
> +	ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x3>;
> +	status = "disabled";
> +};
> +
> +/* On-module PCIe USB Bridge */
> +&pcie2_rc {
> +	clocks = <&k3_clks 334 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
> +	clock-names = "fck", "pcie_refclk";
> +	num-lanes = <1>;
> +	phy-names = "pcie-phy";
> +	phys = <&serdes1_pcie2_1l_link>;
> +	reset-gpios = <&som_gpio_expander 3 GPIO_ACTIVE_HIGH>;
> +	ti,syscon-acspcie-proxy-ctrl = <&acspcie1_proxy_ctrl 0x3>;
> +	status = "okay";
> +
> +	pci@0,0 {
> +		device_type = "pci";
> +		reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		usb@0 {
> +			compatible = "pci104c,8241";
> +			reg = <0x0 0x0 0x0 0x0 0x0>;
> +			ti,pwron-active-high;
> +		};
> +	};
> +};
> +
> +/* PCIE for On-module Wi-Fi */
> +&pcie3_rc {
> +	clocks = <&k3_clks 335 0>, <&serdes0 CDNS_TORRENT_REFCLK_DRIVER>;
> +	clock-names = "fck", "pcie_refclk";
> +	num-lanes = <1>;
> +	phy-names = "pcie-phy";
> +	phys = <&serdes0_pcie3_1l_link>;
> +	reset-gpios = <&som_gpio_expander 4 GPIO_ACTIVE_HIGH>;
> +	ti,syscon-acspcie-proxy-ctrl = <&acspcie0_proxy_ctrl 0x3>;
> +	status = "okay";
> +};
> +
> +&serdes0 {
> +	status = "okay";
> +
> +	/* Aquila PCIE_2 */
> +	serdes0_pcie1_2l_link: phy@0 {
> +		reg = <0>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
> +		cdns,num-lanes = <2>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +	};
> +
> +	/* On-module PCIe Wi-Fi */
> +	serdes0_pcie3_1l_link: phy@2 {
> +		reg = <2>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz0 3>;
> +		cdns,num-lanes = <1>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +	};
> +
> +	/* Aquila USB0 SS */
> +	serdes0_usb0_ss_link: phy@3 {
> +		reg = <3>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz0 4>;
> +		cdns,num-lanes = <1>;
> +		cdns,phy-type = <PHY_TYPE_USB3>;
> +	};
> +};
> +
> +&serdes1 {
> +	status = "okay";
> +
> +	/* Aquila PCIE_1 */
> +	serdes1_pcie0_2l_link: phy@0 {
> +		reg = <0>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz1 1>, <&serdes_wiz1 2>;
> +		cdns,num-lanes = <2>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +	};
> +
> +	/* On-module PCIe USB Bridge */
> +	serdes1_pcie2_1l_link: phy@2 {
> +		reg = <2>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz1 3>;
> +		cdns,num-lanes = <1>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +	};
> +};
> +
> +&serdes2 {
> +	status = "disabled";
> +
> +	/* Aquila ETH_2 xGMII */
> +	serdes2_sgmii_link: phy@3 {
> +		reg = <3>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz2 4>;
> +		cdns,num-lanes = <1>;
> +		cdns,phy-type = <PHY_TYPE_SGMII>;
> +	};
> +};
> +
> +&serdes4 {
> +	status = "disabled";
> +
> +	/* Aquila DP_1 */
> +	serdes4_dp0_link: phy@0 {
> +		reg = <0>;
> +		#phy-cells = <0>;
> +		resets = <&serdes_wiz4 1>, <&serdes_wiz4 2>,
> +			 <&serdes_wiz4 3>, <&serdes_wiz4 4>;
> +		cdns,max-bit-rate = <5400>;
> +		cdns,num-lanes = <4>;
> +		cdns,phy-type = <PHY_TYPE_DP>;
> +	};
> +};
> +
> +&serdes_refclk {
> +	clock-frequency = <100000000>;
> +	status = "okay";
> +};
> +
> +&serdes_ln_ctrl {
> +	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,     /* Aquila PCIE_2 L0          */
> +		      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,     /* Aquila PCIE_2 L1          */
> +		      <J784S4_SERDES0_LANE2_PCIE3_LANE0>,     /* On-module PCIe Wi-Fi      */
> +		      <J784S4_SERDES0_LANE3_USB>,             /* Aquila USB0 SS            */
> +		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>,     /* Aquila PCIE_1 L0          */
> +		      <J784S4_SERDES1_LANE1_PCIE0_LANE1>,     /* Aquila PCIE_1 L1          */
> +		      <J784S4_SERDES1_LANE2_PCIE2_LANE0>,     /* On-module PCIe USB Bridge */
> +		      <J784S4_SERDES1_LANE3_QSGMII_LANE2>,    /* Aquila SGMII MSP_9        */
> +		      <J784S4_SERDES2_LANE0_QSGMII_LANE5>,    /* Aquila SGMII MSP_6        */
> +		      <J784S4_SERDES2_LANE1_QSGMII_LANE6>,    /* Aquila SGMII MSP_7        */
> +		      <J784S4_SERDES2_LANE2_QSGMII_LANE7>,    /* Aquila SGMII MSP_8        */
> +		      <J784S4_SERDES2_LANE3_QSGMII_LANE8>,    /* Aquila ETH_2 xGMII        */
> +		      <J784S4_SERDES4_LANE0_EDP_LANE0>,       /* Aquila DP L0              */
> +		      <J784S4_SERDES4_LANE1_EDP_LANE1>,       /* Aquila DP L1              */
> +		      <J784S4_SERDES4_LANE2_EDP_LANE2>,       /* Aquila DP L2              */
> +		      <J784S4_SERDES4_LANE3_EDP_LANE3>;       /* Aquila DP L3              */
> +};
> +
> +&serdes_wiz0 {
> +	status = "okay";
> +};
> +
> +&serdes_wiz1 {
> +	status = "okay";
> +};
> +
> +&serdes_wiz2 {
> +	status = "disabled";
> +};
> +
> +&serdes_wiz4 {
> +	status = "disabled";
> +};
> +
> +/* Aquila ADC_[1-4] */
> +&tscadc0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_mcu_adc0>;
> +	status = "disabled";
> +
> +	adc {
> +		ti,adc-channels = <0 1 2 3>;
> +	};
> +};
> +
> +&usb0 {
> +	phys = <&serdes0_usb0_ss_link>;
> +	phy-names = "cdns3,usb3-phy";
> +	dr_mode = "otg";
> +	maximum-speed = "super-speed";
> +	usb-role-switch;
> +	status = "disabled";
> +};
> +
> +&usb_serdes_mux {
> +	idle-states = <0>; /* USB0 to SERDES lane 3 */
> +};
> +
> +&usbss0 {
> +	ti,vbus-divider;
> +	status = "disabled";
> +};
> +
> +&wkup_gpio0 {
> +	gpio-line-names =
> +		"", /* 0 */
> +		"",
> +		"",
> +		"AQUILA_C53",
> +		"AQUILA_B55",
> +		"AQUILA_B56",
> +		"AQUILA_B32",
> +		"AQUILA_B34",
> +		"AQUILA_C17",
> +		"AQUILA_C16",
> +		"AQUILA_D22", /* 10 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"AQUILA_B65",
> +		"AQUILA_C20",
> +		"AQUILA_B63",
> +		"AQUILA_B68",
> +		"AQUILA_B67", /* 20 */
> +		"AQUILA_B61",
> +		"AQUILA_B60",
> +		"AQUILA_B70",
> +		"AQUILA_B71",
> +		"AQUILA_B72",
> +		"AQUILC_B73",
> +		"AQUILA_B66",
> +		"AQUILA_B62",
> +		"AQUILA_C21",
> +		"AQUILA_C22", /* 30 */
> +		"AQUILA_C23",
> +		"AQUILA_C01",
> +		"AQUILA_C02",
> +		"",
> +		"AQUILA_D21",
> +		"",
> +		"AQUILA_C03",
> +		"AQUILA_C24",
> +		"AQUILA_C04",
> +		"AQUILA_B84", /* 40 */
> +		"",
> +		"AQUILA_B86",
> +		"AQUILA_B87",
> +		"",
> +		"",
> +		"AQUILA_B83",
> +		"",
> +		"",
> +		"",
> +		"", /* 50 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"AQUILA_B31",
> +		"AQUILA_B33",
> +		"AQUILA_B50", /* 60 */
> +		"AQUILA_B51",
> +		"",
> +		"",
> +		"",
> +		"AQUILA_D08",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"", /* 70 */
> +		"AQUILA_D01",
> +		"AQUILA_D02",
> +		"AQUILA_D03",
> +		"AQUILA_D04",
> +		"AQUILA_D54",
> +		"AQUILA_D55",
> +		"AQUILA_C55",
> +		"AQUILA_C56",
> +		"",
> +		"AQUILA_C36", /* 80 */
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"",
> +		"AQUILA_D07",
> +		"";
> +
> +	status = "okay";
> +};
> +
> +/* On-module I2C - WKUP_I2C0 */
> +&wkup_i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wkup_i2c0>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	som_gpio_expander: gpio@21 {
> +		compatible = "ti,tca6408";
> +		reg = <0x21>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		gpio-line-names =
> +			"USB_MUX_SEL",
> +			"COLD_RESET_REQ",
> +			"PWR_DOWN_REQ",
> +			"PCIE_3_RESET#",
> +			"PCIE_4_RESET#",
> +			"WIFI_DISABLE",
> +			"BT_DISABLE",
> +			"SDIO_PWR_SEL_3.3V";
> +	};
> +
> +	rtc_i2c: rtc@32 {
> +		compatible = "epson,rx8130";
> +		reg = <0x32>;
> +	};
> +
> +	tps62873a: regulator@40 {
> +		compatible = "ti,tps62873";
> +		reg = <0x40>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <900000>;
> +		regulator-min-microvolt = <600000>;
> +		regulator-name = "+VDD_CPU_AVS";
> +	};
> +
> +	tps62873b: regulator@43 {
> +		compatible = "ti,tps62873";
> +		reg = <0x43>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-max-microvolt = <840000>;
> +		regulator-min-microvolt = <760000>;
> +		regulator-name = "+V0.8_VDD_CORE";
> +	};
> +
> +	pmic_tps6594: pmic@48 {
> +		compatible = "ti,tps6594-q1";
> +		reg = <0x48>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic_int>;
> +		interrupt-parent = <&main_gpio0>;
> +		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		buck12-supply = <&reg_vin>;
> +		buck3-supply = <&reg_vin>;
> +		buck4-supply = <&reg_vin>;
> +		buck5-supply = <&reg_vin>;
> +		ldo1-supply = <&reg_vin>;
> +		ldo2-supply = <&reg_vin>;
> +		ldo3-supply = <&reg_vin>;
> +		ldo4-supply = <&reg_vin>;
> +		system-power-controller;
> +		ti,primary-pmic;
> +
> +		regulators {
> +			reg_vdd_ddr: buck12 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-min-microvolt = <1100000>;
> +				regulator-name = "+V1.1_VDD_DDR (PMIC BUCK12)";
> +			};
> +
> +			reg_vdd_ram: buck3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <850000>;
> +				regulator-min-microvolt = <850000>;
> +				regulator-name = "+V0.85_VDD_RAM (PMIC BUCK3)";
> +			};
> +
> +			reg_vdd_io: buck4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "+V1.8_VDD_IO (PMIC BUCK4)";
> +			};
> +
> +			reg_3v3_vio: buck5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-name = "+V3.3_VIO (PMIC BUCK5)";
> +			};
> +
> +			reg_vda_phy: ldo1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "+V1.8_VDA_PHY (PMIC LDO1)";
> +			};
> +
> +			reg_2v5_eth: ldo2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <2500000>;
> +				regulator-min-microvolt = <2500000>;
> +				regulator-name = "+V2.5_ETH (PMIC LDO2)";
> +			};
> +
> +			reg_vda_dll: ldo3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <800000>;
> +				regulator-min-microvolt = <800000>;
> +				regulator-name = "+V0.8_VDA_DLL (PMIC LDO3)";
> +			};
> +
> +			reg_vda_pll: ldo4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-name = "+V0.8_VDA_PLL (PMIC LDO4)";
> +			};
> +		};
> +	};
> +
> +	temperature-sensor@4f {
> +		compatible = "ti,tmp1075";
> +		reg = <0x4f>;
> +	};
> +
> +	som_eeprom: eeprom@50 {
> +		compatible = "st,24c02", "atmel,24c02";
> +		reg = <0x50>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +&wkup0_crit {
> +	temperature = <105000>;
> +};
> +
> +&wkup0_thermal {
> +	trips {
> +		wkup0_alert0: trip-point0 {
> +			temperature = <70000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		wkup0_alert1: trip-point1 {
> +			temperature = <85000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +};
> +
> +&wkup1_crit {
> +	temperature = <105000>;
> +};
> +
> +&wkup1_thermal {
> +	trips {
> +		wkup1_alert0: trip-point0 {
> +			temperature = <70000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +
> +		wkup1_alert1: trip-point1 {
> +			temperature = <85000>;
> +			hysteresis = <2000>;
> +			type = "active";
> +		};
> +	};
> +};
> +
> +&wkup_gpio_intr {
> +	status = "okay";
> +};
> +
> +/* Aquila UART_2 */
> +&wkup_uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wkup_uart0>;
> +	status = "disabled";
> +};
> +
> +#include "k3-j784s4-j742s2-ti-ipc-firmware-common.dtsi"
> +#include "k3-j784s4-ti-ipc-firmware.dtsi"


