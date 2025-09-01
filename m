Return-Path: <linux-kernel+bounces-794383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7069B3E0EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A338344393C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FE63128DE;
	Mon,  1 Sep 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGScmK/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0830F549;
	Mon,  1 Sep 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724719; cv=none; b=W0c2z88S5ZtWwVXd9Omhd4YYQ7U/+Z3zqKzvTpIl0y/dQ2ZDZFjXyrF4xCRQmBAxUnTT17CWgmGtaRt9j2OtX/m0r6xzCXyLUMo75MDr0pprsPf7QW7J7PtaDEZ6SCL+hlpNTrGEHu7YbgClSb/64rSzPFXX7+KsC8GzF8a48VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724719; c=relaxed/simple;
	bh=HhAxMhzIWpGbIo7jKoWEEEwRf9Ce/jHp1L+yBzRh2ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyFMGFz34nQv4ywkSEmGmsnmcFDOmCxsmdKBDROV1XK1KEW2kNshvmikyU4+bX8zkqSomZvpTUhKsWcQa93oTNEFvZpVq/kqRDbzavJKcKIcvc9hIrSa/L/8s5zepstiIXHi47CuWaM4X3p51DKZApndQkPac6d+6QPK7QYXxZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGScmK/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC49C4CEF9;
	Mon,  1 Sep 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756724719;
	bh=HhAxMhzIWpGbIo7jKoWEEEwRf9Ce/jHp1L+yBzRh2ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGScmK/6FpuRVuYSYAd6H6szvYlh2nSs0IA7N+Ncc2fnGUMVkEdTtVjENWPfVGVRS
	 4qbLR+Le8ZEveB/z70SfVlv9Yy0Ri3HX3v/FAuPFsQKUyKbspxbcwt1hHe0dsQxzq9
	 nyz8hVihxaZY8TgqG+tttHlyK36S1rHzb4a/dGiMZ3gH593Rqbg2F8sxYf2ULaVMoO
	 1t6OwdWVto3F1hHV5LyAWyR5Ret/9C7vEmUwsXDeuDcbPIpVhgSxmRPlllrs7uwiph
	 /Z39zX0vrH8NDBqPVMo4SJ8fBNTzQfA9ps1lMcJC7qOVMpRHpYoj1eBCrB7CkeZNtp
	 mBETgy49T7S9A==
From: Conor Dooley <conor@kernel.org>
To: sboyd@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
Subject: [PATCH v4 6/9] riscv: dts: microchip: fix mailbox description
Date: Mon,  1 Sep 2025 12:04:18 +0100
Message-ID: <20250901-excretion-employed-1e497728e00e@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901-rigid-sacrifice-0039c6e6234e@spud>
References: <20250901-rigid-sacrifice-0039c6e6234e@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=s6ZIEUHnNiMIErq0YtoV3qkwNiLtaSKSNvr8gxSu+hU=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlba9edPD9/Mc+5Kx3zlG/fMfXzPBt6qU8g3awxVilSn HmzQ3FuRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbiVsfwz/LLfq+Yu9djX4u+ SnzXcbyTXUbauqfk1ze/N/mNDctmzGRk6K3bf/KKB/9OX6cDb0WUms8++7Yqw1br5pOY6QGMjrK rGQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the binding for the mailbox on PolarFire SoC was originally
written, and later modified, mistakes were made - and the precise
nature of the later modification should have been a giveaway, but alas
I was naive at the time.

A more correct modelling of the hardware is to use two syscons and have
a single reg entry for the mailbox, containing the mailbox region. The
two syscons contain the general control/status registers for the mailbox
and the interrupt related registers respectively. The reason for two
syscons is that the same mailbox is present on the non-SoC version of
the FPGA, which has no interrupt controller, and the shared part of the
rtl was unchanged between devices.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 9883ca3554c50..f9d6bf08e7170 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -259,6 +259,11 @@ clkcfg: clkcfg@20002000 {
 			#reset-cells = <1>;
 		};
 
+		sysreg_scb: syscon@20003000 {
+			compatible = "microchip,mpfs-sysreg-scb", "syscon";
+			reg = <0x0 0x20003000 0x0 0x1000>;
+		};
+
 		ccc_se: clock-controller@38010000 {
 			compatible = "microchip,mpfs-ccc";
 			reg = <0x0 0x38010000 0x0 0x1000>, <0x0 0x38020000 0x0 0x1000>,
@@ -521,10 +526,14 @@ usb: usb@20201000 {
 			status = "disabled";
 		};
 
-		mbox: mailbox@37020000 {
+		control_scb: syscon@37020000 {
+			compatible = "microchip,mpfs-control-scb", "syscon";
+			reg = <0x0 0x37020000 0x0 0x100>;
+		};
+
+		mbox: mailbox@37020800 {
 			compatible = "microchip,mpfs-mailbox";
-			reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
-			      <0x0 0x37020800 0x0 0x100>;
+			reg = <0x0 0x37020800 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <96>;
 			#mbox-cells = <1>;
-- 
2.47.2


