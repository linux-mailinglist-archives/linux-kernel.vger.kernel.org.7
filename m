Return-Path: <linux-kernel+bounces-876674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C30C1BF8A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2696034AD81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28149347FEE;
	Wed, 29 Oct 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0gI1KfZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C92EC088;
	Wed, 29 Oct 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754311; cv=none; b=qGJsrMpm+uNSQa3w6KTx7ZbPniO2Gh2WoT+7Cmgn6qHhxFnoJJdQOcj2Hhbl6PLYVd8guDCKh7Yve7FIJoEQaDR0ca0z1UcY95fPeDUNHslyikAOZxzell4evgd5lf/fJAtWjWurllSoDhNz5hWb/Q4755k/t/XTtJMGaSgGg+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754311; c=relaxed/simple;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdvFEkSQ28Rh24DuPo4AhByiRPwLgAVe+GyjJ2Q+nL6afTn7+3GKwolHhU5GsuL+QkqQRFQhzVNKaCbEqjQVIRAI1swvW844jYmIuajW3Wh36ACIOXRJ4iYGXpSObQJUs0aiv7/zKi1fl7C/lyHKTNNj3Icaj2ckOfsMzOaCcig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0gI1KfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FEFC4CEF7;
	Wed, 29 Oct 2025 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761754310;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O0gI1KfZlA0/45L4U9eJrx6qpu2IGzA4wsjML93oPVhLNXOYtnWX6CXllgZboqBWY
	 vhyfgBB7crP61m7dAm7gSTWaW2puf4AiUZ0jf2IkEAYPPAsdIeOWZ46byVOAJny4vt
	 vCJBbKeyLaK6wA0nB1rKUpAWQmZh4kYAkvaqM4xicqU5J/X+9ELkj97AtmW2+tIXA1
	 mOQw9x9JmMJRo7iiaGICMrZLj6sNQ9IweicaszD5IzK59M50W6DfWee2Nm6kQWLMB6
	 FLvzrC/+KfgsiMu13uEq2OeZqvvKZpp0eFsDRZSnXJak8K7tXoyndkITATDw8434ED
	 dcNcJp4fIBM5g==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/7] riscv: dts: microchip: convert clock and reset to use syscon
Date: Wed, 29 Oct 2025 16:11:21 +0000
Message-ID: <20251029-polyester-dubiously-55915f5c7962@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+zR8fbMXO9YW4YzwKnjp5SrmA8iRht4FGjwYBRXJ6yY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlMNut3HPy0mnNWf/rhFwWOM+01G8SW19s+mH++M/St6 h4r7aurO0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCR0/EMfwWVq15GmWRs9jj8 +qGyFMu2KuEjAlv03W977glfPo/p5yWGf1qL9SO2Rmddm/bttfaSq9/2h0pYNjKHWDqx8XfUNU7 ezgEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The "subblock" clocks and reset registers on PolarFire SoC are located
in the mss-top-sysreg region, alongside pinctrl and interrupt control
functionality. Re-write the devicetree to describe the sys explicitly,
as its own node, rather than as a region of the clock node.
Correspondingly, the phandles to the reset controller must be updated to
the new provider. The drivers will continue to support the old way of
doing things.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index f9d6bf08e717..5c2963e269b8 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -251,11 +251,9 @@ pdma: dma-controller@3000000 {
 			#dma-cells = <1>;
 		};
 
-		clkcfg: clkcfg@20002000 {
-			compatible = "microchip,mpfs-clkcfg";
-			reg = <0x0 0x20002000 0x0 0x1000>, <0x0 0x3E001000 0x0 0x1000>;
-			clocks = <&refclk>;
-			#clock-cells = <1>;
+		mss_top_sysreg: syscon@20002000 {
+			compatible = "microchip,mpfs-mss-top-sysreg", "syscon", "simple-mfd";
+			reg = <0x0 0x20002000 0x0 0x1000>;
 			#reset-cells = <1>;
 		};
 
@@ -452,7 +450,7 @@ mac0: ethernet@20110000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC0>;
+			resets = <&mss_top_sysreg CLK_MAC0>;
 			status = "disabled";
 		};
 
@@ -466,7 +464,7 @@ mac1: ethernet@20112000 {
 			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
 			clock-names = "pclk", "hclk";
-			resets = <&clkcfg CLK_MAC1>;
+			resets = <&mss_top_sysreg CLK_MAC1>;
 			status = "disabled";
 		};
 
@@ -550,5 +548,12 @@ syscontroller_qspi: spi@37020100 {
 			clocks = <&scbclk>;
 			status = "disabled";
 		};
+
+		clkcfg: clkcfg@3e001000 {
+			compatible = "microchip,mpfs-clkcfg";
+			reg = <0x0 0x3e001000 0x0 0x1000>;
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+		};
 	};
 };
-- 
2.51.0


