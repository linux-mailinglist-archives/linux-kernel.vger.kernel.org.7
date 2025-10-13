Return-Path: <linux-kernel+bounces-851120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0EBBD5969
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992CD18A5FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA52D23A8;
	Mon, 13 Oct 2025 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FddGmuzX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962702C0276;
	Mon, 13 Oct 2025 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377687; cv=none; b=d9fKTFX4XcLECLUdw10PLUQmE9w8SYdTTz1NgImtW64ZRBh/xShA9W6d8CD2n6S3ncz/g7Ps2DXBlh+VeiwUhyVb2kIM3CefDYapEofKYSvra5G2/s3r5Rixue3zTUlUfK7OYErs6k9ss+8KjWk7sfokyq9+gLcWqwQvVkkUeTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377687; c=relaxed/simple;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JV8jNM7Ew5xuLCHqkMJKZ4OGqMjw4Q4Us/Ifw8nhKRe7fj3nyn5hZ7SOiEZDmUN/99fzOQxUCOE5b9Pu6L3D8PaXCk7blPk4ATXdXx3ENoPKCG9OipBCmVvLov7avVZng4QFN4wlXCxkuve6LgpBA377GY22w4Fhw4kMOtsv23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FddGmuzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F3C4CEE7;
	Mon, 13 Oct 2025 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377687;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FddGmuzXEPWGJiD8edvsv5EIrfNMx2o7xlTVcAvgS7jTCf4o13YZ8QPipLTJPAKkq
	 Jj/cavfYWjB03ykTnC7YFXWhQK9JIo1il+tXKtLK8GYj9+dFj8K12V9De2/o1Sqc4w
	 5tC6nwPkIZBO7c+0kqU9CzocvS9RIrXFMHV7gGIuQfD72eAsZmIc+GnqA31PpMYE1D
	 5mudkdoVm+atcuaoXjSOhpyr6+NXyp4X66oXGtEUanpRu2AILeXMtW/yIpH2EpIZcZ
	 ZR6vOLUwmwfYFabONmiFmiyrPbOfrNooLGON0K2Yr4AiKAL9K0WAlqM2KYjoocmp1u
	 xQPHtYrnI0nXQ==
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
Subject: [PATCH v5 7/9] riscv: dts: microchip: convert clock and reset to use syscon
Date: Mon, 13 Oct 2025 18:45:39 +0100
Message-ID: <20251013-princess-unstitch-a6a0c75f8c12@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+zR8fbMXO9YW4YzwKnjp5SrmA8iRht4FGjwYBRXJ6yY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ5Os7+pdNj+rW+22OWQFPdZE7l9F0tFdpWqsgvMv Ks4uSixo5SFQYyLQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNhXsjwV/Tz0WxDEwZrjxtW X66c53vppczPcS42a8KBJY9EmWR/TGT4px2imVFxbP10rTXlNnNP6lu8+XRRZcFtg+cNH6K0NkX t5wAA
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


