Return-Path: <linux-kernel+bounces-837429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 801ACBAC50C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FA7321B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97682F8BF1;
	Tue, 30 Sep 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr6/GDpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92642F533A;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225051; cv=none; b=p59AIGxwiiMtbiNuzw9z/OEgFoNec9owqB87dn6vJpCSCHLKq35EiudL9KuDuwZVKVyOhScKTHebg/xRiU8E8U/CEaqKKWP/yV0dgqeQxOzhIYxNY1wFxtggTyVScv1smnhnFjPgrcF8691rfihlAU/Gf+1PxHQ+ejyHQNqfkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225051; c=relaxed/simple;
	bh=tvbsNP2qVU1cS/ayMypPvum2ysqLXXw2xrupi3Us5z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjlsNI7a5eqWRm8Jvk3poTCeDLGmCMXVpB7G89N5axR8qLyy/yddEQ787vAfgsrBP/AdcCtMS0EOzqXgUYkE9aQlBbrVQHDKxoeRcDS9afDUYXSJ5ghw/yTcYmhEnH2wgi225fPoFcbadc7v2uVCZu3MSrM3HVLWF2nt56Erb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr6/GDpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F585C113D0;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=tvbsNP2qVU1cS/ayMypPvum2ysqLXXw2xrupi3Us5z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rr6/GDpauEY2HHAqRcDmiTNhPC7TN9DAYYCycVXlDHtgTxBjCkc0uJgP65l+B+keg
	 IG5OhTR5p2myHJndvJuwe6EBdnrjZG+N3ZocVpjpthu4fDFCEKSIhqnL0tv99g9Z3f
	 /V4WdCoMcyEn11g12Y7Dmojcrfqdi5QKtD7H/QqDqdPPB3elrqmiIhYMOcG76ao0z9
	 /eT1wpxwfTl3tvjwkyJwiUWcYNPXbRbeqkNYAiifZ7b8iIdE14ORShYP/+C9deIr4Y
	 Dpj5k0HogW95ceGK2HuPd2zss+gv7edzgvwTBJ8qWqbvCT8eVyCL68ADpgGTBa2DVf
	 cOxoDpwD8M2vA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41289CAC5B8;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:14 +0800
Subject: [PATCH 01/19] dt-bindings: clock: Add Amlogic A4 SCMI clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-1-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=1814;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=lepg6iT8bmM81rEU5ToL/dWT4QLnpMs52RztUgBBpJI=;
 b=9DlKusjYS9lvJ5c+yIorherlGXVHoEWA7WXl+kn4Crs79ES3JyMECgX8nYfKzxnBZ3aewWJbC
 PNqO/UxUUyuC5w6Rvv8v4ryBepX5x7v5MVHuUbUJjfzWlvDFRb2nrux
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Add the SCMI clock controller dt-bindings for Amlogic A4 SoC family.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 include/dt-bindings/clock/amlogic,a4-scmi-clkc.h | 42 ++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/dt-bindings/clock/amlogic,a4-scmi-clkc.h b/include/dt-bindings/clock/amlogic,a4-scmi-clkc.h
new file mode 100644
index 000000000000..454e492f8f6f
--- /dev/null
+++ b/include/dt-bindings/clock/amlogic,a4-scmi-clkc.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2025 Amlogic, Inc. All rights reserved.
+ * Author: Chuan Liu <chuan.liu@amlogic.com>
+ */
+
+#ifndef __AMLOGIC_A4_SCMI_CLKC_H
+#define __AMLOGIC_A4_SCMI_CLKC_H
+
+#define CLKID_OSC				0
+#define CLKID_SYS_CLK				1
+#define CLKID_AXI_CLK				2
+#define CLKID_CPU_CLK				3
+#define CLKID_FIXED_PLL				4
+#define CLKID_GP1_PLL				5
+#define CLKID_ACLKM				6
+#define CLKID_SYS_PLL_DIV16			7
+#define CLKID_CPU_CLK_DIV16			8
+#define CLKID_FCLK_50M_PREDIV			9
+#define CLKID_FCLK_50M_DIV			10
+#define CLKID_FCLK_50M				11
+#define CLKID_FCLK_DIV2_DIV			12
+#define CLKID_FCLK_DIV2				13
+#define CLKID_FCLK_DIV2P5_DIV			14
+#define CLKID_FCLK_DIV2P5			15
+#define CLKID_FCLK_DIV3_DIV			16
+#define CLKID_FCLK_DIV3				17
+#define CLKID_FCLK_DIV4_DIV			18
+#define CLKID_FCLK_DIV4				19
+#define CLKID_FCLK_DIV5_DIV			20
+#define CLKID_FCLK_DIV5				21
+#define CLKID_FCLK_DIV7_DIV			22
+#define CLKID_FCLK_DIV7				23
+#define CLKID_SYS_MMC_PCLK			24
+#define CLKID_SYS_CPU_CTRL			25
+#define CLKID_SYS_IRQ_CTRL			26
+#define CLKID_SYS_GIC				27
+#define CLKID_SYS_BIG_NIC			28
+#define CLKID_AXI_SYS_NIC			29
+#define CLKID_AXI_CPU_DMC			30
+
+#endif /* __AMLOGIC_A4_SCMI_CLKC_H */

-- 
2.42.0



