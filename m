Return-Path: <linux-kernel+bounces-806935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE69B49DA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F793C68CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D01F30E0D2;
	Mon,  8 Sep 2025 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ejwVWK/p"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2230F80D;
	Mon,  8 Sep 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375543; cv=none; b=VLnuwrHAJCp6gjqyKbxrZN1vTKfrzid8RqzJ/bfc325DhbZTmN792VACg/hb6EHArGgMiBH5+fpMCb3WcEy9ODJZ8+tQcngLUfC4zbJsKx7IDwW3OXIDSsFZiZmHqmA6ptK+2xnxgGDUE7k5o67BYmPOU378+prhpHhgadQYjIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375543; c=relaxed/simple;
	bh=qe1JUUJtmwWu/elsDk6SZ5E9rFWhQSgYmI7khKjbKVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brpslLl1E+ZtGn7nvkmJVIGS6td/4yjyhSE4damAGrEnxiqimxureyJl7RVL5x/oWVQYobKWp27+0LsvjMjnmTNNzleoDh3LkWiB4sFMxBeydQAWIxhrELXdo1UYld3raTPzAjzzK+utaJ5o8KF8+VkCU/V0Ur8S9XqN+EUynC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ejwVWK/p; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588Nq8Co3970607;
	Mon, 8 Sep 2025 18:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757375528;
	bh=CEbZ+I5Gax1pbF+ot+GrzdHUbVfgmhN6ToYQ/7joaBs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ejwVWK/pxmaHtPgekY/s4O/LvfezaIhnEaIa9s3/Fvv6U+GcCAD+/dUrDtQtE6+dg
	 w6eLFQvgfSimH1WtoYpg7YT5n9hENm7WNtKeaQQ1jMWu0ktPJwue7Jnui6AVOI0nm2
	 pnJbZip+i57LtK2dk9GUp0vh6eb0F8qhQDv2NOd4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588Nq8Ft3353620
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 18:52:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 18:52:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 18:52:07 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588Nq7WW1677746;
	Mon, 8 Sep 2025 18:52:07 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>
CC: Moteen Shah <m-shah@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-am62p/j722s: Remove HS400 support from common
Date: Mon, 8 Sep 2025 18:52:06 -0500
Message-ID: <20250908235207.473628-2-jm@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908235207.473628-1-jm@ti.com>
References: <20250908235207.473628-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Since eMMC HS400 has been descoped for J722s due to errata i2478 [0]
and is supported for AM62Px device, remove eMMC HS400 support from
common-main.dtsi and include only in am62p-main.dtsi.

[0] https://www.ti.com/lit/pdf/sprz575
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 3 ---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi              | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 4427b12058a6..0c05bcf1d776 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -576,15 +576,12 @@ sdhci0: mmc@fa10000 {
 		bus-width = <8>;
 		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
 		ti,clkbuf-sel = <0x7>;
-		ti,strobe-sel = <0x77>;
 		ti,trm-icp = <0x8>;
 		ti,otap-del-sel-legacy = <0x1>;
 		ti,otap-del-sel-mmc-hs = <0x1>;
 		ti,otap-del-sel-ddr52 = <0x6>;
 		ti,otap-del-sel-hs200 = <0x8>;
-		ti,otap-del-sel-hs400 = <0x5>;
 		ti,itap-del-sel-legacy = <0x10>;
 		ti,itap-del-sel-mmc-hs = <0xa>;
 		ti,itap-del-sel-ddr52 = <0x3>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
index 6aea9d3f134e..020bd121a6a3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -74,3 +74,9 @@ &main_gpio1 {
 	gpio-reserved-ranges = <32 10>;
 	ti,ngpio = <52>;
 };
+
+&sdhci0 {
+	mmc-hs400-1_8v;
+	ti,strobe-sel = <0x77>;
+	ti,otap-del-sel-hs400 = <0x5>;
+};
-- 
2.51.0


