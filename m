Return-Path: <linux-kernel+bounces-806062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2457FB49175
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFD9D7B36F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989C30BBA5;
	Mon,  8 Sep 2025 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XADLn1ZF"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3A30C62A;
	Mon,  8 Sep 2025 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341770; cv=none; b=EEzQ4wmpTXFCvnibiGIGx8n1Xfnw8it0p5qD3YyAanbC02Une8X1u/ASVkMXITqzVAbBPA9Y2qbq41SsCQBGwvJxF9IgkEDyatkHnVK3qHOGSx9idCMsof1zmmko/d8lTGIUG9PDC0pmFS0kmbPvVuwz55MP8aeH8Ez1oulQ3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341770; c=relaxed/simple;
	bh=0YwF8WTFUqagvwavCeSH/awL5i8m+RC7BD7TT3KpBWw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3O2C4ANzjqWjf+shyEtFTDYHnTK1FxYM6OJmPNAIPFTkO01QTBY/3x4WInV0uxlPP/pY7tasSO5D7mQhy8X0wSxcW+ncjMkCCvgelinPZo4UqYcANSeSgganU3qX3/cIcW/YBDNbgyg9pEFu0FIX7STkMOtp0EVu2ufiGEQSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XADLn1ZF; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588ETKVN071249;
	Mon, 8 Sep 2025 09:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341760;
	bh=d5FD+MoRxRPOTyFKx1rY9IYjAvYQnJl2/VowkMUFuJI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XADLn1ZFBhcH83k13mFr5Ec+1zsFZJ9uFKPammxpXtFZErIgTzK1QwAfGh0Q/ifZy
	 PjfDU9cPDSJeVRuFtdUgML3f4x5Q/Z6erc31ERW6vCrCr0aoLglpZM2BCCQR4d4RnD
	 Ms34CXfrxay5tqeJO+OCGI6E/MhlNX9cdT7Bh7t0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588ETKdP3063609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:29:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:29:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:29:19 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESeci1037553;
	Mon, 8 Sep 2025 09:29:15 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>
Subject: [PATCH v4 06/34] arm64: dts: ti: k3-am62: Enable remote processors at board level
Date: Mon, 8 Sep 2025 19:57:58 +0530
Message-ID: <20250908142826.1828676-7-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908142826.1828676-1-b-padhi@ti.com>
References: <20250908142826.1828676-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Remote Processors defined in top-level AM62x SoC dtsi files are
incomplete without the memory carveouts and mailbox assignments which
are only known at board integration level.

Therefore, disable the remote processors at SoC level and enable them at
board level where above information is available.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
v4: Changelog:
1. Carried R/B tag.

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-7-b-padhi@ti.com/

v3: Changelog:
1. Carried A/B, T/B, R/B tags.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-7-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 21/33] to [PATCH v2 06/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-22-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi      | 1 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 10e6b5c08619..dcd22ff487ec 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -407,4 +407,5 @@ &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 6549b7efa656..75aed3a88284 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -128,6 +128,7 @@ wkup_r5fss0_core0: r5f@78000000 {
 			ti,sci = <&dmsc>;
 			ti,sci-dev-id = <121>;
 			ti,sci-proc-ids = <0x01 0xff>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d5..840772060cb1 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -506,6 +506,7 @@ &wkup_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;
 	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
 			<&wkup_r5fss0_core0_memory_region>;
+	status = "okay";
 };
 
 &usbss0 {
-- 
2.34.1


