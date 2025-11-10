Return-Path: <linux-kernel+bounces-892962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92841C46387
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A44EA500
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818E530B526;
	Mon, 10 Nov 2025 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F59LTQtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D591F30ACFA;
	Mon, 10 Nov 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773849; cv=none; b=uJxuxfhe10HyT6A3Wcgig7Ei503YdLnejk6NzY+dID9bLWxUq19Nr++ydlJvkyAyyLiY/znYtt9MeDwbVSAED5/q2bLpi7WExmtBwDf1vXF+K2FWAwNuK8qHUcsjcKtjhEc4phaDvXPa87Xgjw0uLsiR/McFUu+nPPIYKu6p3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773849; c=relaxed/simple;
	bh=yx40n6aW+7axlHFIv+/k4z1XcQ+4QDorszZ6b/jKM44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FybR8OjXirzyUsnUn6l1e6AdWqEWH+2BkEhcOv2v3GmpQYbfvEVRry7ea5ql2IXxXNefifdmkYKN0KFaWKjSkk6rLkCOeBUn2z4UE1LGlkHwjhbsAmOfuuxVgzVi3Yq3LlJcgKyC9VdLwSmhZr5NDGOtNdwxTyB3K2B3tGMwwTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F59LTQtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA67C4CEFB;
	Mon, 10 Nov 2025 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762773849;
	bh=yx40n6aW+7axlHFIv+/k4z1XcQ+4QDorszZ6b/jKM44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F59LTQtQ/T46ZHPhSBD6fAl/2N80oWK7OmmcQRc9LG6mbzvxSs/Wxjg5BBaqiXr7j
	 4UO4qcU2x7S+N+5lhfigGP1Pt6tzqhuLxTEuV+qcwNwjQcumnCPndDp7lDzBJP3N7c
	 sM8dZJPvNPGA8XTxsDGknW8hKbQfBIoY3Wr5uDUxjfjf/5kBfrYbTmF7Nl6xjQqgy+
	 rwDZfw1AosKhCT92iKWFPYMJfVfWfhKvG9ZLXV4Fvbm0IC14CxQ5+3B7b6Va0F2LJr
	 nUNeKwVJMe8gfSiuBpfG10S8CqgWHZd9Y1yNvbrdKyUH1wTaylH6MuQaR8ZWRdaC8T
	 D7DrVCbh/VoYg==
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
Subject: [PATCH v7 2/5] riscv: dts: microchip: fix mailbox description
Date: Mon, 10 Nov 2025 11:23:51 +0000
Message-ID: <20251110-rockiness-sank-c22fa8a3bafb@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110-zookeeper-femur-68a0ae346397@spud>
References: <20251110-zookeeper-femur-68a0ae346397@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CJ93zZ/gwT2VF26tXat2Gljwq2Roq9NVUZwBFI4dODQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmCp92P6z3eFjfpFded7KLe80fbPaf6daxL2FJwXkZit sLlCdMedpSyMIhxMciKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAi/PcY/qkoHKi4fah5gljy sQkTIzUWyhq+DRfdqSlcNf9lxkP3jA0M/1Sf9KYyzH0zq6rp1tq5jpJsr8/F9RlUxP3u/Rjx8FB WIz8A
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
index 9883ca3554c5..f9d6bf08e717 100644
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
2.51.0


