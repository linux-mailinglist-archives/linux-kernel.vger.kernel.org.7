Return-Path: <linux-kernel+bounces-775509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C65B2BFFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D07213D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68470326D5B;
	Tue, 19 Aug 2025 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgdKJWaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A958C322C78;
	Tue, 19 Aug 2025 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602013; cv=none; b=Sv7UGtdLTaeQ6ihoV6Ub5dOsPesmt0u1rScZPEzR+WLGZkr57jK7tYAq0+o8+fnuxIGX27Gnqco7R1BaM4IMzAmHyo+OCKIPesDDPjvnblPqHhlzxw1FoPmF0tzfYmTKmuO28v6GJYbGnKyYNeNocNV17rk9i8FYnXNA0PyE2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602013; c=relaxed/simple;
	bh=A+ClZFMba5OQu8qT/J08hiEW4Q53nfuS5azTNQ9i1c8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V9Sgomw/h3Piq+lw21z3JB8c7S6WPFtWIiZi6Bp7fAuySxgXUqTjXwmOwqxu4iogpg1U9i75t15W9meCWpYvlijNp23mbZfIraw13kCqbfLvqGtnTRhx+3lQE/N2TV5yKaaU6Akz72rs+GMSVb5XhAbfXhCVXxiAUkiDDJbjFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgdKJWaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DB3C4CEF1;
	Tue, 19 Aug 2025 11:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755602013;
	bh=A+ClZFMba5OQu8qT/J08hiEW4Q53nfuS5azTNQ9i1c8=;
	h=From:To:Cc:Subject:Date:From;
	b=GgdKJWaZ2pNTWZrymGcdopualb+xGHE2jJQbioAWxgvRbAaPedFylqaZyXSaR7jX9
	 ZIEfjN2YBPr6pY1inDpBI5RUITo+z6JC0KJo83epVo8kF7qK7c4qCVtJIRhck2XP7c
	 6yfvsprIaTeqZV8zNbnVbqfC7UCJ7qe2TMtROLt0qrg5ArazPvHrRxmN08HXjKAwCg
	 1oZ/1tdQPwtKtBQuI6P4w1Xy35TLDZouBDkmL9Ogu1C9dOGhTAjCyGvAoBYunjuZLY
	 DFRByWTb0pOLYlOVQa2pgCHxWhUph/B1//pA+vSdY3zAI06Gq88+3nZUw2npzAXWtG
	 4dwJSlC/LCxAw==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-j722s-main: add legacy PCIe interrupts
Date: Tue, 19 Aug 2025 13:13:17 +0200
Message-Id: <20250819111317.1082515-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will try to map the legacy interrupt pins, but the
interrupt mapping is missing from the device tree and thus that
fails with:

   pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22

Add the node for the legacy PCIe interrupts to fix that. This is just
compile-time tested.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index ab2e7b6eb98e..3e10b78d5bf3 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -119,7 +119,20 @@ pcie0_rc: pcie@f102000 {
 		cdns,no-bar-match-nbits = <64>;
 		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
 		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
+				<0 0 0 2 &pcie0_intc 0>, /* INT B */
+				<0 0 0 3 &pcie0_intc 0>, /* INT C */
+				<0 0 0 4 &pcie0_intc 0>; /* INT D */
 		status = "disabled";
+
+		pcie0_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 
 	usbss1: usb@f920000 {
-- 
2.39.5


