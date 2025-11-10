Return-Path: <linux-kernel+bounces-892964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2249BC46399
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C7B4EAF59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DD22538F;
	Mon, 10 Nov 2025 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Galcd/L1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499AF30BF4F;
	Mon, 10 Nov 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773853; cv=none; b=P4maDDwYKYgR6kvfHTSen/XiZNMf3KG+maM9empNFXoN58GdxhgG+lIAyBL5A42ulzsBN0cTyQnObR1KJRJYuHEGmYIMYfiqwEGSlOQq86DkJsIAQp8A3+Mv6Me05jDh7goIbUjSPidGzWzmgdVKkmY/2LMbdlbdqd5vq5oaEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773853; c=relaxed/simple;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuqdFbCHBYrUZqMKX5r1Xp7ITyjvoXFob1f0u59BzpmhjbykTLyQqQlh0DQ9U3MGzOxmCBdxKF2IX1zULEsawZUv1xOc/h/UyMV4J3yikOb1ged9QELU/3h4ItvCIK4S18Z4QU8KWyYyZEisKKmu2QRi91eJAhjxEbHH1SG0OTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Galcd/L1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D160DC2BC87;
	Mon, 10 Nov 2025 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773852;
	bh=o06pwj8GQhduMpl8X9PMCjFDAGlLMLElJucB88tSCYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Galcd/L10+CvJOyC2hB+L/6sEPakTPxv6oq5pEbYX100syMbpTcxaQKXxF4UIFfpw
	 Nqn8Mfe5bWKVI5e0PiGO+ZId+qQQx71UAaiP/4nIqTTENORb4bWFk7taghyyQgtpYM
	 QNrqj0tS6a9BK5IXgUnoBFQEZ0QYGFojppOHr0uMJ1Klyvb4D5KY57odrVfHHeRVbg
	 7ESqQ7kKyO+a4i2JMC8vHMLvxO3BwihzlLBpKPjAAzGcC0/A+Ex5bFDWBCI2a1+gzn
	 wfan6ikC5Qg8xo9uZDGWRl6wLXf/V/oNwYrI8jOJdmZiz72YZJtXbvMtA6/zKGV5c3
	 s9OYl5W7IlkJQ==
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
Subject: [PATCH v7 3/5] riscv: dts: microchip: convert clock and reset to use syscon
Date: Mon, 10 Nov 2025 11:23:52 +0000
Message-ID: <20251110-vicinity-stream-b6954d17e01c@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110-zookeeper-femur-68a0ae346397@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=+zR8fbMXO9YW4YzwKnjp5SrmA8iRht4FGjwYBRXJ6yY=; b=kA0DAAoWeLQxh6CCYtIByyZiAGkRy0ei3kWAlDeH5mIUl4g8elSv50NtiF0eZr8sfY+ix+Wzx Yh1BAAWCgAdFiEEYduOhBqv/ES4Q4zteLQxh6CCYtIFAmkRy0cACgkQeLQxh6CCYtJ/tgD9FM5J TeDenWu0gbF67ZshvF6KSC/NO3RzRieteMYGyzoBAMmQ9BwHCizv+5ziMGu8PtoqmynJl+SVbnc awI51JWYD
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


