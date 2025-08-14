Return-Path: <linux-kernel+bounces-768929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30988B26807
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2EC3B9244
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C3C3002AE;
	Thu, 14 Aug 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eJRZKCQP"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47898318150;
	Thu, 14 Aug 2025 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179224; cv=none; b=Ac5/21geO7b08Zn8OOv3MB+nSEM+HTUhsf3RWAeliFuL4Ojv6bzoMoIPi+U2YweTzjlCzUddh0hSH7SB9qhbYDRop8BF7mExLvx1vEiULcTrT+rZXq636j8nrdysjtrEPnFY56YhiCgJO0FGSftObE6/RJH8xgCxRlGIgIyE6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179224; c=relaxed/simple;
	bh=zYvVasO4eoNV0G3+210vL+nijQxcm6ff1tIlErKLTIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rCguwuERIQGR0/IU8j9Wgj8is8D+bFG/xzihARb9m4B8VDg4K2D1XKRQjAuf51HsuLuerXhbLxx9LPL2D1cZm4q9cEPJTWSQTDYI+69Xa4OdENF7149XBzB2CqoOO/f6OYlWMoxZZuVVDaSShiyABKaLUFr3OjTHFpxCSYqsy4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eJRZKCQP; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EDktGa1942951;
	Thu, 14 Aug 2025 08:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755179215;
	bh=0NBs7RKwRufRSxBBCqcPJwdIIQf5V5X3kn7DC3EoZuk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eJRZKCQPduENzaLjUnDw9FTwXUYH3Zj+AsR3qRYo/q3u+/tRlAQrfFjysUeIkY3vt
	 QHwH1LSa5lj93J7jFwFPRDM9qIdRRV0A1HeR8qL2u5z3XtB2Lzi3EBEhhGevB+Qc+2
	 6J8up6I3i9DA1DWMFxJMC7i+kmXA1ijV4b5i46yI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EDktPg1748928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 08:46:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 08:46:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 08:46:55 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EDkrTY3995919;
	Thu, 14 Aug 2025 08:46:54 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: Anshul Dalal <anshuld@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/4] arm64: dts: ti: k3-am62*: remove SoC dtsi from common dtsi
Date: Thu, 14 Aug 2025 19:15:27 +0530
Message-ID: <20250814134531.2743874-2-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814134531.2743874-1-anshuld@ti.com>
References: <20250814134531.2743874-1-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The k3-am62x-sk-common dtsi represents the common hardware used across
am62x EVMs which can be configured with various DDR sizes or none (with
DDR integrated in the package) based on the specific am62x SoC used.

Therefore this patch moves the memory node and the SoC specific k3-am625
dtsi out of sk-common and into the board dts files. No functional change
is intended from this patch. The device-tree inheritance is changed as
follows:

Before:

               k3-am62
                 ^
               k3-am625
                 ^
         k3-am62x-sk-common
                 ^
  am62x EVMs (k3-am625-sk, k3-am62-lp-sk)

After:

        k3-am62
          ^
        k3-am625    k3-am62x-sk-common
          ^              ^
  am62x EVMs (k3-am625-sk, k3-am62-lp-sk)

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts       | 8 ++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts         | 5 +++--
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 --------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 4609f366006e..ecfba05fe5c2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -7,12 +7,20 @@
 
 /dts-v1/;
 
+#include "k3-am625.dtsi"
 #include "k3-am62x-sk-common.dtsi"
 
 / {
 	compatible = "ti,am62-lp-sk", "ti,am625";
 	model = "Texas Instruments AM62x LP SK";
 
+	memory@80000000 {
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		device_type = "memory";
+		bootph-pre-ram;
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS65988 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index d240165bda9c..1c6812a8ae9b 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 
+#include "k3-am625.dtsi"
 #include "k3-am62x-sk-common.dtsi"
 
 / {
@@ -23,10 +24,10 @@ opp-1400000000 {
 	};
 
 	memory@80000000 {
-		device_type = "memory";
 		/* 2G RAM */
 		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-
+		device_type = "memory";
+		bootph-pre-ram;
 	};
 
 	vmain_pd: regulator-0 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d5..bf84d392e60d 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -8,7 +8,6 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/net/ti-dp83867.h>
-#include "k3-am625.dtsi"
 
 / {
 	aliases {
@@ -29,13 +28,6 @@ chosen {
 		stdout-path = "serial2:115200n8";
 	};
 
-	memory@80000000 {
-		bootph-pre-ram;
-		device_type = "memory";
-		/* 2G RAM */
-		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
-	};
-
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.50.1


