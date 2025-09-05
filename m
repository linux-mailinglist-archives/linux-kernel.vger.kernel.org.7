Return-Path: <linux-kernel+bounces-802070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2936B44D55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E841C80C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B22D238C;
	Fri,  5 Sep 2025 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Rs5KrjfL"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A76278E7B;
	Fri,  5 Sep 2025 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049631; cv=none; b=ERf34uaQnONTwHmSGAoV/k/woAI+kZ0wcKQVGrarh9S0Ykd3uzsJQp+LE4o3ZOTUfrxS4jUVxC9x+rvLX1lYc31Vpm8ngnW0QzvCUKTuhjmG7SldxLghyAJcanS2VRqhs8rtL3ZclK/r6bHH6Gjsxv8q5j7ukEuPf1/eVNX2amw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049631; c=relaxed/simple;
	bh=8Qs36Abn2ggI8VJjUw9GvpP469qCfO3YLij1D5DMuD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qh1cr1SJclEKtvD2wjtJM9HITK/cCmuvbrC7ceHmK7vHsaJ3iHpzh35vurXZjJasT+ObK6IgWmAVWEDZ3q5yInPfr7iyhtsUAc9mu1ybfTSCN6IkqWLuO3zMRZlFet1yzOf9zS3YNg8Xw1wIfK+BbyW2xMRJPZdhKGL80ULcDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Rs5KrjfL; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855KKjb3246466;
	Fri, 5 Sep 2025 00:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049620;
	bh=S4vPSMY+WPy4tAS1pz3zNbAgISNuOjb0rEdgpdtUzpo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Rs5KrjfLDtfIcDwiQtlHXRfGIhe3JiQUB7oK9L2XkMh2+nsOQNIOS1ds/+uyvneZZ
	 UxDxzYrZqyBriEU/L3CnfhlKWoWFM/UujfoNrIGD1muDCPZ2Yk8Kazu4Gx4SzpzJbl
	 HTE7Q9/TRRnlGBY4aqp0rfEc1bPsUiRED4tXbGzA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855KKpS136669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:20:20 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:20:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:20:20 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioil220581;
	Fri, 5 Sep 2025 00:20:14 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>, Matt McKee <mmckee@phytec.com>,
        Garrett Giordano
	<ggiordano@phytec.com>,
        Nathan Morrisson <nmorrisson@phytec.com>, John Ma
	<jma@phytec.com>,
        Logan Bristol <logan.bristol@utexas.edu>
Subject: [PATCH v3 18/33] arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Firmware
Date: Fri, 5 Sep 2025 10:48:31 +0530
Message-ID: <20250905051846.1189612-19-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905051846.1189612-1-b-padhi@ti.com>
References: <20250905051846.1189612-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The k3-am64-phycore SoM enables all R5F and M4F remote processors.
Reserve the MAIN domain timers that are used by R5F remote
processors for ticks to avoid rproc crashes. This config aligns with
other AM64 boards and can be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Matt McKee <mmckee@phytec.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Nathan Morrisson <nmorrisson@phytec.com>
Cc: John Ma <jma@phytec.com>
Cc: Logan Bristol <logan.bristol@utexas.edu>
Requesting for review/test of this patch.

v3: Changelog:
1. Carried T/B tag.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-19-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 28/33] to [PATCH v2 18/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-29-b-padhi@ti.com/

 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 03c46d74ebb5..1efd547b2ba6 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -275,6 +275,30 @@ mbox_m4_0: mbox-m4-0 {
 	};
 };
 
+/* main_timer8 is used by r5f0-0 */
+&main_timer8 {
+	status = "reserved";
+};
+
+/* main_timer9 is used by r5f0-1 */
+&main_timer9 {
+	status = "reserved";
+};
+
+/* main_timer10 is used by r5f1-0 */
+&main_timer10 {
+	status = "reserved";
+};
+
+/* main_timer11 is used by r5f1-1 */
+&main_timer11 {
+	status = "reserved";
+};
+
+&main_r5fss0 {
+	status = "okay";
+};
+
 &main_i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
-- 
2.34.1


