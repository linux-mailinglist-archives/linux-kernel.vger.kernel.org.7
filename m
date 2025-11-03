Return-Path: <linux-kernel+bounces-882253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D15CC29FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7CCD188F131
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B5288502;
	Mon,  3 Nov 2025 03:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lca+4QFx"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975E71339B1;
	Mon,  3 Nov 2025 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142003; cv=fail; b=j59SKgcX2pjx4N04hsHyA50AA/uLwqN10Nc+XqThf8kC71FKI3VT8DCrpyZTARVwPdip1eEVBNCb1s3MkS3mAlxeWA8cXExzUqo61gz16p/60Lc+xQaZgrGDj4Vis7tE9TQOTpFqy4+LjDCRJ/v4kO9EdyiBVXnlRcKHVWhRX+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142003; c=relaxed/simple;
	bh=lG5dm1drV9aaCMeYSF6GnkE13X7roXz26EbtoTzvlF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iQDe5fOtH8vWUIrPwGxZdaRCHMXtDXwAnbzGS0F4z1mApqjDjeVDvm3NVe4PIbEZIDlvptl3gvxPAaQpxwPqI1qZHdf0zu4asce4QZlxip99TuqFQpL+SmP9chXwqcTzFwZkz4/ST0aINi2odqSQ8EBCTE7JhWeWEuqsELZTgZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lca+4QFx; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDTHwb21THfjQLCZaacBtaoDXne6pcZktA4dZW++LMlf5D9SJ/8iPeotmuuElQl/yK+n3ApOb2m9yJrZGi+dFEDnLkZIHTHATiOZQMfcAcK+PqjubZVsap8EGIWf4cIQQelBAsOTKl8NRzlLDvmFSwjawINSo1Hwy3FOxwovH9lxY4O8vFou/hVHcqSJeYm6W9iTLkMEwf49tEiJgMzh0TKMYPL/RULlJZOCP5P6HXX8vD8zm9GzpVOuRLYa3xYSKFkDvlDrBfjPyEmHeRAlq29Ge+eifHK8HqFDC77grydtRQVKH7xv+QJwJtPbZS2nXY31A1gec1oXZCiowmeOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l/kDJWH0z64WjQy44aSChC/KtKdIO9Fq2KBjazock4=;
 b=VBWGCr5y50yvTwGCtdWauTNC0aj91Lx0UEFrqwn4gvHd9oCMEBCZsjvZiUD2PX/8CyrOE+UOi1t9RX63eKKarXU+tqLbF8NScdMJlL07k5hvMybrOV8ZqDKnMOhCxUX04oozYBY/M2uf6eSQiuB0KjF2WcXA8uojJ8F9fhG28acGtpoLjI1tgTyXV1jPp1XTStwQUWjJJK663QdantYmJXo2UQqupdeOCCcLdNHUSpIwVph3F2f7ltdlfBapjjqHLJrzPOXEcJN/LHDl4ycDehwubO8MNbenY1j7B1YPJ1Czj4IfL5kGnCD66dZp4ikwYKYnGhptKoputtkKhir3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l/kDJWH0z64WjQy44aSChC/KtKdIO9Fq2KBjazock4=;
 b=lca+4QFxCeWLMGDqMTrHSbiOHA+cqgFiwqTkZK5bJHPqdY8hf4NELeXkDR7IovFUS07xSsGJ8S5opN/ba723iKBiCWaMpiO2NNeOMNTe1itk7Hnn2ruBZhvL01qj4XkIExEoPxuTORdt9XQcwfnWA3D7JpsSMHpEZcPJZEYYFeQ=
Received: from SA9PR13CA0068.namprd13.prod.outlook.com (2603:10b6:806:23::13)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 03:53:18 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::25) by SA9PR13CA0068.outlook.office365.com
 (2603:10b6:806:23::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Mon, 3
 Nov 2025 03:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 03:53:18 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 21:53:17 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 2 Nov
 2025 21:53:16 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 2 Nov 2025 21:53:16 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A33rCa03445047;
	Sun, 2 Nov 2025 21:53:12 -0600
Message-ID: <32b13258-19dd-4ba7-a13b-daaf3804a7c8@ti.com>
Date: Mon, 3 Nov 2025 09:21:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] arm64: dts: ti: k3-am62a7-sk: Set wakeup-source
 system-states
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Nishanth Menon
	<nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vishal Mahaveer <vishalm@ti.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Sebin Francis
	<sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, Akashdeep Kaur
	<a-kaur@ti.com>
References: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
 <20251030-topic-am62-dt-partialio-v6-15-v4-5-6b520dfa8591@baylibre.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20251030-topic-am62-dt-partialio-v6-15-v4-5-6b520dfa8591@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: f4314c2e-a156-40bf-2264-08de1a8c8643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|34020700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGgwbGtQMVVSYUFWRldqTC9kNFBHQnlTQVNiKzdjaWdIM1pBTFgyaEFlOGc3?=
 =?utf-8?B?c200TTlvKzN6V29NRHVnUWtEa2I1OUlWUEs4RHA4MCtFWjlvSWFFN3pmUm9q?=
 =?utf-8?B?alZpUm43WmF4YTR2bWxQckxnVTI0ZzdUcVU1VkJjQXBMRSsrSUE5Ni9LcThJ?=
 =?utf-8?B?Q2srUStaMlR4WnFyRlJ0Q2ZiYkROZXovcnRNN3hVZDhXZ3pLZWtDK3B3cExQ?=
 =?utf-8?B?S25GaFVQN3RUcVpDVVVxenNDamt1d3ZzVnNQY0RsS29zcmUwNXBrMkc1TE9E?=
 =?utf-8?B?RFRUY0phN3JadWE0VG5pRlpVYm92TnZnbVVubmhvUVFDVzJrOVd3eXdJSWw5?=
 =?utf-8?B?dGFzV2hoa2oyNzZubEJ6a05IWE5ZbmFZbzdWcVlmekN5ckV0NzhRVyt4bDVp?=
 =?utf-8?B?dGpDNFQ0RzZCT0JGcGpJNjJuVGpJaFJNZ2hDOEgrVVAxMEcyaW1QVFNhbEtL?=
 =?utf-8?B?akpjMkM2Zmd1QWdjNjM2VDNaWURUbWJ2WXZFR2tkL1hhY3FWdDBQWlN3Zndu?=
 =?utf-8?B?eEpvejRaZi85K0NCUjRCeWgwK0pteDcwWW94bkJsd08yOFNUckhuSTZlNGJ4?=
 =?utf-8?B?c3hMZmhzcW1yT0x2VlVwWnBDeElJajJ5VHhrVWFxeTlvV0pBV2pITWRmTzZs?=
 =?utf-8?B?NWNrMzFOdi9kdWwrUXNpQS93dFluTEg2MWF6QkozMzdGcGszSmRnRG43bHZL?=
 =?utf-8?B?d21ybm5Bc3kvYlRFNTNUWTVSU1UxZDJSKzZLaFJ2d1FpRWxsV0k1VTZzb1cv?=
 =?utf-8?B?YW5JRFdFZi8xRi9admFUdVdBa25USWRiNm5DUFZOMkdSNU9yUkczUk9rejdO?=
 =?utf-8?B?MjYwaHRLUFpsdTNDZk9STW9MSUxRQTYvVDZlU05QSUpielNBMGVuYlhCbEhO?=
 =?utf-8?B?Z2hxWUxpQ1BvR0RORlRvV2VzUUhyemlBbTFjMWkvVGdHTlNjaHRtOVRjRXJi?=
 =?utf-8?B?WEpEVHJUa25TSEdmT2hvUlhmZzI0YjByOTNiWXZqN0dlVncrcDR0ZVdFR2Rt?=
 =?utf-8?B?QjAxd2NKeUloWCtSSEdwaXNsVXA5MVVJZ0QwaDN3WlNmenR5bDlTTG0wVDRM?=
 =?utf-8?B?WWNtYmo4QTFsbkI5eVM1SUhURURxR2lPQ0FDbEdiQXRpMCtiUnhQMFVPUzhR?=
 =?utf-8?B?Sjlkb2xTbnhjSk1qeUdPUjhCUjZLRzRHZmx4WHBlRHJlUEhkVWM0T1Y0L0R4?=
 =?utf-8?B?R1ZvcUovRzJSUDdwSlAzM1JmMGFhRS9VRWxBTzJSSjFIUDlLd3dNazFCVHFL?=
 =?utf-8?B?T2I0anliTnNHcGJLV2o5RXdmNGVMWVVHbTJLQXZJNnpES2tKU3hYQVZHTTJZ?=
 =?utf-8?B?aWltUm5PRTNBY3c5Ny91cTdZU3pxcXVyT1BzTTJ5V0ZBUXhHbFg0S2FxbkpE?=
 =?utf-8?B?SnE5bHhGUmo4MTFFQlpHZkJVQnRYUUVKQWwvaVVHYlNzSTJVcDNndm5ZNmRP?=
 =?utf-8?B?Uk5jUjlLYWJzSlBCdEd4dlNIYW9CZmQ0MVpxQUNHM3dBK29FR3lTMjA4VDRr?=
 =?utf-8?B?YzZJd3BTLzM3b1JRU2IrZ3c1VlVHM2xuR2hzOUZ2WHZueEFId1Z1TmJTRTFm?=
 =?utf-8?B?QW1mZ2sxQ0Rlc2hCU0VHTVpqZHB5aXp1SVBkY0t6SlVqa1FucWpMQklvaVF3?=
 =?utf-8?B?M0czdHJIUU5VQWNxK0daWnFxbWszSUl1enFVSlMwVGdRVzRTblFqaUo0N2gz?=
 =?utf-8?B?eWhXTUUwMTltd2c1NU44S0lVcTdmL05yNkMxQjR1VFVPU2crV0RzaFFsVzNy?=
 =?utf-8?B?N0pLMENqVzlPQ1ErN0kvb2VFN1pldUVBSDhnZTZraTNlS2RRTk5xRVkvTnp2?=
 =?utf-8?B?YUJuTUhqblZGZkt1ZUlLQ0hHeUJUWUtpRFptYVZWYWN0WkdvSVBVMjRuMnAx?=
 =?utf-8?B?d1FxVit4Sk5wUUNlRHZtRy9lQUdWN25NQ2RuRk1uOTdVa2w1QVdOV3V6NDA4?=
 =?utf-8?B?OElOY1oydUNHanpiWlRMOFdqYkh4a1JNRGsrV0kyUkFMR2dHWTIzUzlQSHFY?=
 =?utf-8?B?REpmZ1o3cHhIcjFHWFVmNlpncUN0WVYvdGNhMkYyUndwZjhpU1JHYkJEeVhI?=
 =?utf-8?B?cWpMaWtZVitwQm1rUkRiMGx2TzVlNEUydy9UQi9UL0ZIT1Q4YWgrenZ4YUpK?=
 =?utf-8?Q?dSXw=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(34020700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 03:53:18.2753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4314c2e-a156-40bf-2264-08de1a8c8643
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790

Hi Markus

[...]

On 30/10/25 14:47, Markus Schneider-Pargmann (TI.com) wrote:
> +&mcu_mcan0 {
> +	pinctrl-names = "default", "wakeup";
> +	pinctrl-0 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_default>;
> +	pinctrl-1 = <&mcu_mcan0_tx_pins_default>, <&mcu_mcan0_rx_pins_wakeup>;
> +	wakeup-source = <&system_partial_io>,
> +			<&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +	status = "okay";
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
> +	status = "okay";
> +};
> +
> +&mcu_uart0 {
> +	wakeup-source = <&system_io_ddr>,
> +			<&system_deep_sleep>,
> +			<&system_mcu_only>,
> +			<&system_standby>;
> +};
> +

MCU peripherals are under control of MCU R5 which would be running a
safety application on AM62A class of SoC. So these peripherals should
not be enabled by default here.

>  #include "k3-am62a-ti-ipc-firmware.dtsi"

-- 
Regards
Vignesh
https://ti.com/opensource


