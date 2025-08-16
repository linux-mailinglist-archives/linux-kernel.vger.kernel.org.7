Return-Path: <linux-kernel+bounces-771793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E343B28B9D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CB9AA7D14
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F342F22FE15;
	Sat, 16 Aug 2025 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="lr2ya7xb"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF67223DCB
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330626; cv=pass; b=o3NI74ieoaFCBfk5jk09qeIT9ok0gUy2m1xHhwzZLu0qTNYdojtt1WUaRvl4kMRvmI4zORwL6jW+pMRDQ8ZnUSLFUEFhGB5nFV/+NBHxAnx8syGCrWO7ok+ev6WvfZwR6po4F2Y8pEgdpDVXaVBkJ+VM+T38xjorTY4HBcWyLqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330626; c=relaxed/simple;
	bh=lArGCjFVKd4sqLoCTFlFq1QowlCm/vKWS/y8bEx3K9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRye3bBcsxYd4ZfeQzfokGQaeoiU+tL41/4v09igRwdMLBYL8H++VNCaxGJ7dM0SoI3W4VA4TRfGe62Q2hLkFafsghfeHQeS0GBG2ecLlwtqc1tUOCwqVUHBPrZs9/TkB12ECeJbK/Xj7RTb7LDXcEaVfgBteZR9DLGbHK0YdQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=lr2ya7xb; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755330608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bRIBP23Y2ylQdHyImJXvD14HwjwUSpPUyjy5Yo1t7D8EXFbNZu+m0zYe68AenkV8T9/1ogDPszwlEPJangV45qbJJOgkN3s4ZAhd6xMPbQGSIz/MrP0Q1TUXItKY5L5wPWwySTPFRHo3LDzmM2O1nGhdbaPtyWV280E1YpMWgyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755330608; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RKVNLFhAmULFUVk/4/UgqVYn12Un3zwHAL+8oU8wrEY=; 
	b=b9lwSazD+oDggzY75pFgNp2ioqLk1kjXpP7YAgzBrlWU5MiJF+ucS12rb7sJRQBxmWXCQYdGl5bLub/a4hdcxMrH4YO3x61NujThAzaWOZmW+IX1Zrs5mu3yj5GIcl/bK/iLk+QrQWXv+2mbl2dLBtBpMCVrXkQLyHcEtpsVpvQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755330608;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=RKVNLFhAmULFUVk/4/UgqVYn12Un3zwHAL+8oU8wrEY=;
	b=lr2ya7xbDyoj/LKhQv0oLLFaHdP7+1e7ch5bc2tO92CVWCWllMQyLHhOG93ElCXn
	Udoq4fyzAXn4v97KFumIyVcr/WDjbpV34IifKu1/g5eAaCx2iciw8SzOvBNqMbhSGAk
	a3AtSFXptFiV3eDQuySJwo51gjiLICgCrT54h6puQpfT6jtut66YrIzDd3b3FM4Ye84
	8OINcyNE//uRAywRwMzqm2oeE0XeslceYyufky1oqsS3r1ZWgdVnJlPWuvZjYHBRGdd
	ZD8pLVEMZpgPSPMN+Pvef3rHLcb6V/nGjMc0tivuQKJ87d1kzAduP9AeT8M6BjOpZNr
	VgVssPGulA==
Received: by mx.zohomail.com with SMTPS id 1755330606588202.98819779340647;
	Sat, 16 Aug 2025 00:50:06 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 7/7] [NOT FOR UPSTREAM] riscv: dts: thead: enable GC620 G2D on TH1520
Date: Sat, 16 Aug 2025 15:47:57 +0800
Message-ID: <20250816074757.2559055-8-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816074757.2559055-1-uwu@icenowy.me>
References: <20250816074757.2559055-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The T-Head TH1520 SoC contains a GC620 2D graphics accelerator.

Enable it in the devicetree to allow using etnaviv driver with it.

This patch is currently very dirty because it relies on the bootloader
leaving the clocks enabled, and the core clock is a fake one.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 42626f35de37b..f21598aec82a7 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -225,6 +225,13 @@ aonsys_clk: clock-73728000 {
 		#clock-cells = <0>;
 	};
 
+	gc620_cclk: clk-gc620-fake {
+		compatible = "fixed-clock";
+		clock-frequency = <264000000>;
+		clock-output-names = "gc620_cclk";
+		#clock-cells = <0>;
+	};
+
 	stmmac_axi_config: stmmac-axi-config {
 		snps,wr_osr_lmt = <15>;
 		snps,rd_osr_lmt = <15>;
@@ -516,6 +523,18 @@ uart2: serial@ffec010000 {
 			status = "disabled";
 		};
 
+		/* Vivante GC620, 2D only */
+		g2d: gpu@ffecc80000 {
+			compatible = "vivante,gc";
+			reg = <0xff 0xecc80000 0x0 0x40000>;
+			interrupt-parent = <&plic>;
+			interrupts = <101 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gc620_cclk>;
+			clock-names = "core";
+			status = "okay";
+		};
+
 		clk: clock-controller@ffef010000 {
 			compatible = "thead,th1520-clk-ap";
 			reg = <0xff 0xef010000 0x0 0x1000>;
-- 
2.50.1


