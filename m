Return-Path: <linux-kernel+bounces-782993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8373CB32815
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6745C1C8297A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E5C246779;
	Sat, 23 Aug 2025 10:03:25 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552E23AE9B;
	Sat, 23 Aug 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755943405; cv=none; b=QFs3ld/4vLcpsY4J+EXX6zeojIx7J3StcxQBnter5IHYy7jMc59qypz9YMpQt0dIQU/QVLcGJz+RcH9980AeEOqoibQgmqekuoFPG2cHi5YFF7ZAFDgz8sbsq0T37TltiGJ2VRST7PAC2xKzRmEMexmtCRxiw0jqQq8P+QTiBnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755943405; c=relaxed/simple;
	bh=V0gZbguz6xs9WFtpOVv8iGW574l1xkCUBM2m+4GVyBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tu59GPe6TefTkThns4xMMdptk7tHyR3QCZ19gRl81V/8xseWKPYGKh7UR2H0Qr3kiZCE+teVmFetXrQ6spWMgLq/SyMJABu7SAWb3AFoMBBYbwPSmcNMAt5Db3FwR7Pj0WFNWs6qujJOzLAGHinim64+OvsSAgQkzz69eq15HBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id ED278B4E1E2E;
	Sat, 23 Aug 2025 12:03:18 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 2/3] riscv: dts: starfive: jh7110: add DMC memory controller
Date: Sat, 23 Aug 2025 03:01:42 -0700
Message-ID: <20250823100159.203925-3-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250823100159.203925-1-e@freeshell.de>
References: <20250823100159.203925-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add JH7110 SoC DDR external memory controller.

Signed-off-by: E Shattow <e@freeshell.de>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 0ba74ef04679..f3876660c07f 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -931,6 +931,18 @@ watchdog@13070000 {
 				 <&syscrg JH7110_SYSRST_WDT_CORE>;
 		};
 
+		memory-controller@15700000 {
+			compatible = "starfive,jh7110-dmc";
+			reg = <0x0 0x15700000 0x0 0x10000>,
+			      <0x0 0x13000000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_PLLCLK_PLL1_OUT>;
+			clock-names = "pll";
+			resets = <&syscrg JH7110_SYSRST_DDR_AXI>,
+				 <&syscrg JH7110_SYSRST_DDR_OSC>,
+				 <&syscrg JH7110_SYSRST_DDR_APB>;
+			reset-names = "axi", "osc", "apb";
+		};
+
 		crypto: crypto@16000000 {
 			compatible = "starfive,jh7110-crypto";
 			reg = <0x0 0x16000000 0x0 0x4000>;
-- 
2.50.0


