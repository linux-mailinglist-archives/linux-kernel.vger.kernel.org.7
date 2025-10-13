Return-Path: <linux-kernel+bounces-851119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32737BD5960
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AC454E835B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F172D0C88;
	Mon, 13 Oct 2025 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1ov6qgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F92C1788;
	Mon, 13 Oct 2025 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377684; cv=none; b=Lj+FNLYZcIuanunk82CpHdDl0OThXwRmTfmX8pLPtshtMvhZyA3jCzA6lXGZ5EH4Xitip5n5WZqO+1KBdmJupz+vHuEP7YzXRul3S4baVWfBEdHJ2vUQIqQNbg6YhWatGVO8w/xF4/nmoNUrSDIM7BUyHUG6DNwBAMpJJh9oD88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377684; c=relaxed/simple;
	bh=yx40n6aW+7axlHFIv+/k4z1XcQ+4QDorszZ6b/jKM44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mk6Z2vmpRpo1McT506Scz3cWUprbqbmhnxHaWrc1QdTUdlp3L2fwRgYZ8wafZDeKusAegsGP7Cl1co3thqB0rt+rFx9mtnaednMN+GjqL+sNsuxJB3YHJNF+IBu3FKZoKFRpjvC3PJC/J02xKHFHbUqN91GotZZ2oltIfCS6G2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1ov6qgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200C9C19423;
	Mon, 13 Oct 2025 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377683;
	bh=yx40n6aW+7axlHFIv+/k4z1XcQ+4QDorszZ6b/jKM44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O1ov6qgsCC+yGKq4N9oLMRt+D9rGFNCpo4Rew9BM8xH0s0J+vdCDQPHen6LUokd+p
	 zdNQgFL/ENzp/uEI4qGNRdP+xoJ73FZ5OO8RBGA7yD8iDStSc/b28iaV5io7o3aN4e
	 apK4mMyE/mV5K1eI/s+3Tn6L8z6/lb3t0W8HI8lJtlCXLTPewSwJMNBacEClO5f+LY
	 h6SLU2UGc8AlDgxeO95rf+uDNn9R2XM+nYDPOAAcO2yrzXV74plEM3maipS2xiFEbj
	 2szzCtlpodmJNerS047bDB4c7vRXlhhwI064vI+w1+pFYeU+C6FZKO/H+wp9tlseew
	 8NdLXNaZFxJNQ==
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
Subject: [PATCH v5 6/9] riscv: dts: microchip: fix mailbox description
Date: Mon, 13 Oct 2025 18:45:38 +0100
Message-ID: <20251013-failing-wobbly-56a7bce3f21b@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013-album-bovine-faf9f5ebc5d4@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CJ93zZ/gwT2VF26tXat2Gljwq2Roq9NVUZwBFI4dODQ=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBlvrQ4Ebjlkd6djitCy1O23n+oLfs3xrs+9d8kwppUti Tnqy6+PHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIMTmGf+aNet8uPzNZfdj6 /gZf7pSp9SmHb1/dU3n8ctKTeXfudW5gZFijeLvuTvn+VU4/XqgvCjM4PbH9zQz16W8WCBvukPq 9rJ0FAA==
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


