Return-Path: <linux-kernel+bounces-804775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E0B47CDC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013993C04B6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839129AB02;
	Sun,  7 Sep 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OLma8Lk9"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690E296BB8;
	Sun,  7 Sep 2025 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269732; cv=none; b=B9kTQtQob+DBDZOWS7E++WmlmEYVhUbRjdkpuPOtB12mV8gAFmp7LVI9vypsNZ/wCvJm2psHq1FY0s/IrqT2tsRER9VyY7suxUN6YxoFPdMk++VELHDILv2HYjaSvZ88jLLAJEdK9BPipmjKA+F2GhKTyiSO7oZMJPjJncXP3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269732; c=relaxed/simple;
	bh=nBIwNiPkOMwW9OHJiusl8UibS2XIS75YwPQpmgAFjIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2Vl2I9d5gRs32t8O4jLnMllg0HdtsM46WIM72X3FZrEBNek2h96MxTuwOrbQs1e5gbKYOpeZJvpG/woYhjr+ad3zoOxF+EDK6vE0dBKkCC+/6c/la6IrO6pjqmtLP3dAUxOlFiieFW8rnWdHCDGFeidb+DBsZCvGfykMvaA0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OLma8Lk9; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 587ISOAx3702489;
	Sun, 7 Sep 2025 13:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757269704;
	bh=Hz/82D98eZoBGY+tKGqxEu2J24lF98TY0l4nYBfE6YA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=OLma8Lk9vD8z+w09qVZkTAjWmkgmN7AkULfErW9wJQGUiqcYo5knZV82wG10uua0O
	 1j9UV9vszBWXRwg7oqq2BWv0qJnhrfhPYxnQwuKBq/yhP4viIgLQsKCxypoHsG5sYr
	 aqhZBokIys5ISXai0iphHRkJTu2c177Pr/whH7vU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 587ISOwc2429729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 13:28:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 13:28:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 13:28:23 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 587IS7US3565173;
	Sun, 7 Sep 2025 13:28:18 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <m-chawdhry@ti.com>, <b-padhi@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <s-jain1@ti.com>
Subject: [PATCH v2 2/2] arm64: dts: ti: k3-j784s4-j742s2-main-common: Update DSS EDP integration configuration register
Date: Sun, 7 Sep 2025 23:58:06 +0530
Message-ID: <20250907182806.1031544-3-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907182806.1031544-1-h-shenoy@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
TRM Table 2-1 MAIN Domain Memory Map.
Link:https://www.ti.com/lit/zip/spruj52/SPRUJ52-J84S4 AM69A TRM

Fixes: 9cc161a4509c ("arm64: dts: ti: Refactor J784s4 SoC files to a common file")
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
index fbbe768e7a30..f0cda14c2530 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -2573,7 +2573,7 @@ port@1 {
 	mhdp: bridge@a000000 {
 		compatible = "ti,j721e-mhdp8546";
 		reg = <0x0 0xa000000 0x0 0x30a00>,
-		      <0x0 0x4f40000 0x0 0x20>;
+		      <0x0 0x4f40000 0x0 0x100>;
 		reg-names = "mhdptx", "j721e-intg";
 		clocks = <&k3_clks 217 11>;
 		interrupt-parent = <&gic500>;
-- 
2.34.1


