Return-Path: <linux-kernel+bounces-805707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D5FB48C82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC891B25F21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD202FC896;
	Mon,  8 Sep 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jx4DZuYH"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CD2ECD3F;
	Mon,  8 Sep 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332138; cv=none; b=bpXZevPEMk4XV366s14S85MTtO//3dQ3s5DRNDAPne/1OLQArwKaf4/XL7KvKuSWftoLKZIcqPd1aaZK8ai5GxYzCMKzFaJJfKzt8kDLjoNTThVi1HSXY6Zx24YLJoA2idAQTKja9ML2e7KAUrHXS7+FXKB8wZNS3q00zcrv7uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332138; c=relaxed/simple;
	bh=8bkYLA4xUuudCPu+AHAnNxN6Ibcrth5oobu0nbo54dM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2l0hFMi/BcZAbSNyfoGzkfN1HL2sqXt0YjBVbHwV82pLzqUH6e5Tk+9nqPeVQK0X5sJigu656Zk48gBHKip8Aucuo0xpxxcKM03Ei0zt5fPZl748zhjp1IURJ4+y4OBU+CSjDdVAdUrhL1c1kiddrCZd8LAVtXavUf6+Goi770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jx4DZuYH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757332136; x=1788868136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bkYLA4xUuudCPu+AHAnNxN6Ibcrth5oobu0nbo54dM=;
  b=Jx4DZuYHhe0NzfQpMT6mOOErzuB/J9WqWTSNUebuKLKHV0QskqheKMir
   TuKajBstiAzNHa68ORFLF2uE+wtw+Ge/KcR+pvs5q2/y93uaic/CEYlAT
   xTYiDLBNf2RhS9+lOooT8jyzi78jzTsfK8a6DbYY3sTC1KgJx0r3qkyqO
   GPdYGVqbn7yZ3kLbH5zvCQQwyTEYOifFwpGM753UbC4Ps6kqr4lWy40Iu
   wOQ+Rihxsz32zStQJnKL6kNF1DWqW1J7eKXj11VXIoy5AG7KXQ6FPN8+N
   dbF2FC7h4BbYOTdVEjtMUlUnOpPrl2d/PPK10nBmeD5CFAZosbRYdfZjY
   w==;
X-CSE-ConnectionGUID: vDOPHTnsQiaqmkXt9yltVw==
X-CSE-MsgGUID: daIQFNEpRC+WLUmKKzn9Gw==
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="45634880"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 04:48:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 04:48:45 -0700
Received: from valentina.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 04:48:43 -0700
From: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
To: <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<valentina.fernandezalanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 4/6] riscv: dts: microchip: rename icicle kit ccc clock and other minor fixes
Date: Mon, 8 Sep 2025 12:57:30 +0100
Message-ID: <20250908115732.31092-5-valentina.fernandezalanis@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
References: <20250908115732.31092-1-valentina.fernandezalanis@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Rename the Clock Conditioning Circuit (CCC) reference clock to match
the fixed clock bindings naming recommendation.

Update the reserved memory regions in the Icicle Kit common dtsi to
use lowercase hex and drop the redundant status properties from the
memory regions, as they are not required.

Signed-off-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi | 6 ++----
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
index 5c7a8ffad85b..e01a216e6c3a 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-common.dtsi
@@ -53,13 +53,11 @@ led-4 {
 	ddrc_cache_lo: memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0x0 0x40000000>;
-		status = "okay";
 	};
 
 	ddrc_cache_hi: memory@1040000000 {
 		device_type = "memory";
 		reg = <0x10 0x40000000 0x0 0x40000000>;
-		status = "okay";
 	};
 
 	reserved-memory {
@@ -67,8 +65,8 @@ reserved-memory {
 		#size-cells = <2>;
 		ranges;
 
-		hss_payload: region@BFC00000 {
-			reg = <0x0 0xBFC00000 0x0 0x400000>;
+		hss_payload: region@bfc00000 {
+			reg = <0x0 0xbfc00000 0x0 0x400000>;
 			no-map;
 		};
 	};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index e673b676fd1a..71f724325578 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -74,7 +74,7 @@ pcie_intc: interrupt-controller {
 		};
 	};
 
-	refclk_ccc: cccrefclk {
+	refclk_ccc: clock-cccref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 	};
-- 
2.34.1


