Return-Path: <linux-kernel+bounces-720431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1EFAFBB97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD56423FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CCE265CCB;
	Mon,  7 Jul 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IhRBkAHj"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937F19755B;
	Mon,  7 Jul 2025 19:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915578; cv=none; b=UpnY8pY/C9Ej+GcvlcQN/SbDPPmonKTpTbplwhX2LH8c7qavKC4d1PGUx98rl41aR6JacJYU0quu9Sr4Xx/+jLt/kP/+0Sk1f28m/nwrzcxJpAWyMvQ8xcy9eBAOenXo07Khx6kURgXmVJjgFyjq9G3STteftSQOVQgPu3eS/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915578; c=relaxed/simple;
	bh=nsxpHC86mW8xx3W4Taj3Nyp6PVYWXkXcHnSRvy7t7CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVguf0YBam4iEnB9vtrhU8UkKrHmlgsc9A63T9t3B0Ga49s3hp6YpZSwKmX/YmkIvUSHTQSvWq+22AeTYcccJObSoGZz9aKit167sUCSvFDfvyqzjrj24Dga9gHODHS/7Jhi6hnK2GssdKJO/dV4+TQvSRj8o3gJtFj3hVp2ELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IhRBkAHj; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567JCpAn298267;
	Mon, 7 Jul 2025 14:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751915571;
	bh=7adI8oLB0BAnpxxs1jA0XuZRc/jv21LnPErqeKfN2DM=;
	h=From:To:CC:Subject:Date;
	b=IhRBkAHj2RuICYLsXCliyqj/+a+np/jaUyvRykqvzob1ifFgVbwLk1oPZiE8fp/cR
	 MSFroq7OCSDTKWNQ7HoXMhIAxvOIKQSgzSKLJR15xoyeWnsk2CHRs1LMF+xBkx2sSl
	 ZIZ7rOdHe0vRCKDlxHIxDVp1K4gEJVWhAP8K3RE8=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567JCp3u288048
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 14:12:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 14:12:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 14:12:50 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567JCok1735887;
	Mon, 7 Jul 2025 14:12:50 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62-main: Remove eMMC High Speed DDR support
Date: Mon, 7 Jul 2025 14:12:50 -0500
Message-ID: <20250707191250.3953990-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

For eMMC, High Speed DDR mode is not supported [0], so remove
mmc-ddr-1_8v flag which adds the capability.

[0] https://www.ti.com/lit/gpn/am625
Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- patch was split from series [0]

v1[0]: https://lore.kernel.org/linux-mmc/20250624221230.1952291-1-jm@ti.com/
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 9e0b6eee9ac7..120ba8f9dd0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -553,7 +553,6 @@ sdhci0: mmc@fa10000 {
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
-- 
2.49.0


