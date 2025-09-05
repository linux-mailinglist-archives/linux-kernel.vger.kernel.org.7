Return-Path: <linux-kernel+bounces-801965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F805B44C23
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4CF1C267D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F98246BC7;
	Fri,  5 Sep 2025 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="d0M0Gf1G"
Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D788221F32;
	Fri,  5 Sep 2025 03:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041901; cv=pass; b=Bsw0r0mQryJQ6YguIQIz89FCXwhZm/6lykiglxJ41j7LLQrmvTqBaTFACUq07/Q4+G1WzZmyWchj0dTUp9a9OQGJ2aLIVvlEfSpxTSZfrX31lHQpkpvsb4n002MSsqvWO+vhaB8zQ/qHOqk2vxMlqa4J6jhBKm0JAkeWjch5ziA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041901; c=relaxed/simple;
	bh=4YoStVEom2viy3eD3Fpt0549I1Cez1s6MWNVHg4hWG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SIN499s6AVvcufcnspW7G00RwkvLxQGafxiaBwdErD+Tm6synU5SY1mTAudRacy5iyakahwDq3aEhDEvKwFA5XVqOZsLb/pysdmcWI51fxwSOsDOwVkxYP+WMJLAjSp9jqrev5GGUuo7mgbcwFselKqYo5ljJKfu44nutgN5oYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=d0M0Gf1G; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757041857; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bRowkLUp2jHLHKmjNo72kcTTaTfMmkd7hOuHUD6ODWHwOsrf+pqwl4Y4FB4FqM+lVaVj3tb/OxPrHsooFNDrtvvAj8Vn3ovUQkMN0VN20GfVLtb3YA0IpkKlpgrxD1ALDXgbuoDiL3Zo1eblJim8ai+DiT7xxWbDlFD5jXQzsdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757041857; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HAaOZik2ANBAT+yVYgoI1i1OIdAH5HCdNG6Pbp04IcU=; 
	b=KQ6nYZs1Su6xtBQg6p8l8gqxL9b/6mMFe60F0y0DXABR6wHXDH/vZoVyk4FUsXtzTgc7yMWjPRpFFTTbQbYDHtcEd6qfGfi/K9dgRE5tz/yc+iiV8j3dphGNfkNgPjIVC7E0ZKPUmunIITSbn9/dCNeFSoty8YWPHx4seP0EH3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757041857;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=HAaOZik2ANBAT+yVYgoI1i1OIdAH5HCdNG6Pbp04IcU=;
	b=d0M0Gf1GUPJLVQxn/PWn14DGc+4jlmxFNpMfCsN5HmgH7aoZkaDdmKR2ZPkrniuw
	tT712xUZwDD6eVXWxJPV4BU0rk30t+E75d8BgkH7ysxvEqVdSohebfzD4qwz0TtIAS0
	7NhE5OxEc4Jm+t/RGrPQA1Os84YQX962gdEKNQPs=
Received: by mx.zohomail.com with SMTPS id 175704185450396.43789058508014;
	Thu, 4 Sep 2025 20:10:54 -0700 (PDT)
From: Xukai Wang <kingxukai@zohomail.com>
Date: Fri, 05 Sep 2025 11:10:22 +0800
Subject: [PATCH v8 1/3] dt-bindings: clock: Add bindings for Canaan K230
 clock controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-k230-clk-v8-1-96caa02d5428@zohomail.com>
References: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
In-Reply-To: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
Feedback-ID: rr080112274ff31d8bf776af84df8d64a70000b8c4ee5d4395f404b23f4b2f3cf28cb02537d7ec1beb2653d8:zu080112271c0bd73724cc6ee37e4e20670000e01efa4694a701f7b1025ee3cbc7ec48ef7e68e6f0ebf6c084:rf0801122cb1c0099e0a989776f504788d0000017441974cfbe2ba5bf42552cdeef0b44249af8edb66435a17c322babf4c:ZohoMail
X-ZohoMailClient: External

This patch adds the Device Tree binding for the clock controller
on Canaan k230. The binding defines the clocks and the required
properties to configure them correctly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
---
 .../devicetree/bindings/clock/canaan,k230-clk.yaml |  59 ++++++
 include/dt-bindings/clock/canaan,k230-clk.h        | 223 +++++++++++++++++++++
 2 files changed, 282 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..34c93cb5db400c7db0a7ede2ef79d340354f150c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/canaan,k230-clk.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/canaan,k230-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Canaan Kendryte K230 Clock
+
+maintainers:
+  - Xukai Wang <kingxukai@zohomail.com>
+
+description:
+  The Canaan K230 clock controller generates various clocks for SoC
+  peripherals. See include/dt-bindings/clock/canaan,k230-clk.h for
+  valid clock IDs.
+
+properties:
+  compatible:
+    const: canaan,k230-clk
+
+  reg:
+    items:
+      - description: PLL control registers
+      - description: Sysclk control registers
+
+  clocks:
+    items:
+      - description: Main external reference clock
+      - description:
+          External clock which used as the pulse input
+          for the timer to provide timing signals.
+
+  clock-names:
+    items:
+      - const: osc24m
+      - const: timer-pulse-in
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@91102000 {
+        compatible = "canaan,k230-clk";
+        reg = <0x91102000 0x40>,
+              <0x91100000 0x108>;
+        clocks = <&osc24m>, <&timerx_pulse_in>;
+        clock-names = "osc24m", "timer-pulse-in";
+        #clock-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/canaan,k230-clk.h b/include/dt-bindings/clock/canaan,k230-clk.h
new file mode 100644
index 0000000000000000000000000000000000000000..9eee9440a4f14583eac845b649e5685d623132e1
--- /dev/null
+++ b/include/dt-bindings/clock/canaan,k230-clk.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Kendryte Canaan K230 Clock Drivers
+ *
+ * Author: Xukai Wang <kingxukai@zohomail.com>
+ */
+
+#ifndef __DT_BINDINGS_CANAAN_K230_CLOCK_H__
+#define __DT_BINDINGS_CANAAN_K230_CLOCK_H__
+
+/* Kendryte K230 SoC clock identifiers (arbitrary values) */
+#define K230_CPU0_SRC_GATE			0
+#define K230_CPU0_PLIC_GATE			1
+#define K230_CPU0_NOC_DDRCP4_GATE		2
+#define K230_CPU0_APB_GATE			3
+#define K230_CPU0_SRC_RATE			4
+#define K230_CPU0_AXI_RATE			5
+#define K230_CPU0_PLIC_RATE			6
+#define K230_CPU0_APB_RATE			7
+#define K230_HS_OSPI_SRC_MUX			8
+#define K230_HS_USB_REF_MUX			9
+#define K230_HS_HCLK_HIGH_GATE			10
+#define K230_HS_HCLK_SRC_GATE			11
+#define K230_HS_SD0_AHB_GATE			12
+#define K230_HS_SD1_AHB_GATE			13
+#define K230_HS_SSI1_AHB_GATE			14
+#define K230_HS_SSI2_AHB_GATE			15
+#define K230_HS_USB0_AHB_GATE			16
+#define K230_HS_USB1_AHB_GATE			17
+#define K230_HS_SSI0_AXI_GATE			18
+#define K230_HS_SSI1_GATE			19
+#define K230_HS_SSI2_GATE			20
+#define K230_HS_QSPI_AXI_SRC_GATE		21
+#define K230_HS_SSI1_AXI_GATE			22
+#define K230_HS_SSI2_AXI_GATE			23
+#define K230_HS_SD_CARD_SRC_GATE		24
+#define K230_HS_SD0_CARD_GATE			25
+#define K230_HS_SD1_CARD_GATE			26
+#define K230_HS_SD_AXI_SRC_GATE			27
+#define K230_HS_SD0_AXI_GATE			28
+#define K230_HS_SD1_AXI_GATE			29
+#define K230_HS_SD0_BASE_GATE			30
+#define K230_HS_SD1_BASE_GATE			31
+#define K230_HS_OSPI_SRC_GATE			32
+#define K230_HS_SD_TIMER_SRC_GATE		33
+#define K230_HS_SD0_TIMER_GATE			34
+#define K230_HS_SD1_TIMER_GATE			35
+#define K230_HS_USB0_REF_GATE			36
+#define K230_HS_USB1_REF_GATE			37
+#define K230_HS_HCLK_HIGH_SRC_RATE		38
+#define K230_HS_HCLK_SRC_RATE			39
+#define K230_HS_SSI0_AXI_RATE			40
+#define K230_HS_SSI1_RATE			41
+#define K230_HS_SSI2_RATE			42
+#define K230_HS_QSPI_AXI_SRC_RATE		43
+#define K230_HS_SD_CARD_SRC_RATE		44
+#define K230_HS_SD_AXI_SRC_RATE			45
+#define K230_HS_USB_REF_50M_RATE		46
+#define K230_HS_SD_TIMER_SRC_RATE		47
+#define K230_TIMER0_MUX				48
+#define K230_TIMER1_MUX				49
+#define K230_TIMER2_MUX				50
+#define K230_TIMER3_MUX				51
+#define K230_TIMER4_MUX				52
+#define K230_TIMER5_MUX				53
+#define K230_SHRM_SRAM_MUX			54
+#define K230_DDRC_SRC_MUX			55
+#define K230_AI_SRC_MUX				56
+#define K230_CAMERA0_MUX			57
+#define K230_CAMERA1_MUX			58
+#define K230_CAMERA2_MUX			59
+#define K230_CPU1_SRC_MUX			60
+#define K230_CPU1_SRC_GATE			61
+#define K230_CPU1_PLIC_GATE			62
+#define K230_CPU1_APB_GATE			63
+#define K230_CPU1_SRC_RATE			64
+#define K230_CPU1_AXI_RATE			65
+#define K230_CPU1_PLIC_RATE			66
+#define K230_CPU1_APB_RATE			67
+#define K230_PMU_APB_GATE			68
+#define K230_LS_APB_SRC_GATE			69
+#define K230_LS_UART0_APB_GATE			70
+#define K230_LS_UART1_APB_GATE			71
+#define K230_LS_UART2_APB_GATE			72
+#define K230_LS_UART3_APB_GATE			73
+#define K230_LS_UART4_APB_GATE			74
+#define K230_LS_I2C0_APB_GATE			75
+#define K230_LS_I2C1_APB_GATE			76
+#define K230_LS_I2C2_APB_GATE			77
+#define K230_LS_I2C3_APB_GATE			78
+#define K230_LS_I2C4_APB_GATE			79
+#define K230_LS_GPIO_APB_GATE			80
+#define K230_LS_PWM_APB_GATE			81
+#define K230_LS_JAMLINK0_APB_GATE		82
+#define K230_LS_JAMLINK1_APB_GATE		83
+#define K230_LS_JAMLINK2_APB_GATE		84
+#define K230_LS_JAMLINK3_APB_GATE		85
+#define K230_LS_AUDIO_APB_GATE			86
+#define K230_LS_ADC_APB_GATE			87
+#define K230_LS_CODEC_APB_GATE			88
+#define K230_LS_I2C0_GATE			89
+#define K230_LS_I2C1_GATE			90
+#define K230_LS_I2C2_GATE			91
+#define K230_LS_I2C3_GATE			92
+#define K230_LS_I2C4_GATE			93
+#define K230_LS_CODEC_ADC_GATE			94
+#define K230_LS_CODEC_DAC_GATE			95
+#define K230_LS_AUDIO_DEV_GATE			96
+#define K230_LS_PDM_GATE			97
+#define K230_LS_ADC_GATE			98
+#define K230_LS_UART0_GATE			99
+#define K230_LS_UART1_GATE			100
+#define K230_LS_UART2_GATE			101
+#define K230_LS_UART3_GATE			102
+#define K230_LS_UART4_GATE			103
+#define K230_LS_JAMLINK0CO_GATE			104
+#define K230_LS_JAMLINK1CO_GATE			105
+#define K230_LS_JAMLINK2CO_GATE			106
+#define K230_LS_JAMLINK3CO_GATE			107
+#define K230_LS_GPIO_DEBOUNCE_GATE		108
+#define K230_SYSCTL_WDT0_APB_GATE		109
+#define K230_SYSCTL_WDT1_APB_GATE		110
+#define K230_SYSCTL_TIMER_APB_GATE		111
+#define K230_SYSCTL_IOMUX_APB_GATE		112
+#define K230_SYSCTL_MAILBOX_APB_GATE		113
+#define K230_SYSCTL_HDI_GATE			114
+#define K230_SYSCTL_TIME_STAMP_GATE		115
+#define K230_SYSCTL_WDT0_GATE			116
+#define K230_SYSCTL_WDT1_GATE			117
+#define K230_TIMER0_GATE			118
+#define K230_TIMER1_GATE			119
+#define K230_TIMER2_GATE			120
+#define K230_TIMER3_GATE			121
+#define K230_TIMER4_GATE			122
+#define K230_TIMER5_GATE			123
+#define K230_SHRM_APB_GATE			124
+#define K230_SHRM_AXI_GATE			125
+#define K230_SHRM_AXI_SLAVE_GATE		126
+#define K230_SHRM_NONAI2D_AXI_GATE		127
+#define K230_SHRM_SRAM_GATE			128
+#define K230_SHRM_DECOMPRESS_AXI_GATE		129
+#define K230_SHRM_SDMA_AXI_GATE			130
+#define K230_SHRM_PDMA_AXI_GATE			131
+#define K230_DDRC_SRC_GATE			132
+#define K230_DDRC_BYPASS_GATE			133
+#define K230_DDRC_APB_GATE			134
+#define K230_DISPLAY_AHB_GATE			135
+#define K230_DISPLAY_AXI_GATE			136
+#define K230_DISPLAY_GPU_GATE			137
+#define K230_DISPLAY_DPIP_GATE			138
+#define K230_DISPLAY_CFG_GATE			139
+#define K230_DISPLAY_REF_GATE			140
+#define K230_USB_480M_GATE			141
+#define K230_USB_100M_GATE			142
+#define K230_DPHY_DFT_GATE			143
+#define K230_SPI2AXI_GATE			144
+#define K230_AI_SRC_GATE			145
+#define K230_AI_AXI_GATE			146
+#define K230_AI_SRC_RATE			147
+#define K230_CAMERA0_GATE			148
+#define K230_CAMERA1_GATE			149
+#define K230_CAMERA2_GATE			150
+#define K230_LS_APB_SRC_RATE			151
+#define K230_LS_I2C0_RATE			152
+#define K230_LS_I2C1_RATE			153
+#define K230_LS_I2C2_RATE			154
+#define K230_LS_I2C3_RATE			155
+#define K230_LS_I2C4_RATE			156
+#define K230_LS_CODEC_ADC_RATE			157
+#define K230_LS_CODEC_DAC_RATE			158
+#define K230_LS_AUDIO_DEV_RATE			159
+#define K230_LS_PDM_RATE			160
+#define K230_LS_ADC_RATE			161
+#define K230_LS_UART0_RATE			162
+#define K230_LS_UART1_RATE			163
+#define K230_LS_UART2_RATE			164
+#define K230_LS_UART3_RATE			165
+#define K230_LS_UART4_RATE			166
+#define K230_LS_JAMLINKCO_SRC_RATE		167
+#define K230_LS_GPIO_DEBOUNCE_RATE		168
+#define K230_SYSCTL_HDI_RATE			169
+#define K230_SYSCTL_TIME_STAMP_RATE		170
+#define K230_SYSCTL_TEMP_SENSOR_RATE		171
+#define K230_SYSCTL_WDT0_RATE			172
+#define K230_SYSCTL_WDT1_RATE			173
+#define K230_TIMER0_SRC_RATE			174
+#define K230_TIMER1_SRC_RATE			175
+#define K230_TIMER2_SRC_RATE			176
+#define K230_TIMER3_SRC_RATE			177
+#define K230_TIMER4_SRC_RATE			178
+#define K230_TIMER5_SRC_RATE			179
+#define K230_SHRM_APB_RATE			180
+#define K230_DDRC_SRC_RATE			181
+#define K230_DDRC_APB_RATE			182
+#define K230_DISPLAY_AHB_RATE			183
+#define K230_DISPLAY_CLKEXT_RATE		184
+#define K230_DISPLAY_GPU_RATE			185
+#define K230_DISPLAY_DPIP_RATE			186
+#define K230_DISPLAY_CFG_RATE			187
+#define K230_VPU_SRC_GATE			188
+#define K230_VPU_AXI_GATE			189
+#define K230_VPU_DDRCP2_GATE			190
+#define K230_VPU_CFG_GATE			191
+#define K230_VPU_SRC_RATE			192
+#define K230_VPU_AXI_SRC_RATE			193
+#define K230_VPU_CFG_RATE			194
+#define K230_SEC_APB_GATE			195
+#define K230_SEC_FIX_GATE			196
+#define K230_SEC_AXI_GATE			197
+#define K230_SEC_APB_RATE			198
+#define K230_SEC_FIX_RATE			199
+#define K230_SEC_AXI_RATE			200
+#define K230_USB_480M_RATE			201
+#define K230_USB_100M_RATE			202
+#define K230_DPHY_DFT_RATE			203
+#define K230_SPI2AXI_RATE			204
+#define K230_CAMERA0_RATE			205
+#define K230_CAMERA1_RATE			206
+#define K230_CAMERA2_RATE			207
+#define K230_SHRM_SRAM_DIV2			208
+
+#endif /* __DT_BINDINGS_CANAAN_K230_CLOCK_H__ */
+

-- 
2.34.1


