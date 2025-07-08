Return-Path: <linux-kernel+bounces-721478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980C0AFC9C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45C43B655E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB3A2DAFA5;
	Tue,  8 Jul 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BWou2GPZ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062F25E828;
	Tue,  8 Jul 2025 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974803; cv=none; b=AwQMLt0WWXolj+gNIqnOUIetDhcw6F87wVb6Hxhf6Qs+Y05uaQ5TNgNmp/xMy9BcNldEkS5TrCCHCiiZ4B8scYL8tP98WF4ST0f4per9eVLo3T1NTJdzqXGzrp4TYSIJrIpArh2sMkVucyAeaQ3M7fn8vSuNxlje340ymP87u/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974803; c=relaxed/simple;
	bh=NaXF+SWgYv7kRBtwEFQbe7Bc7oXL2R98o9nJKHF8ma4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6b0piTVcXdCEyLcIB8ZRVERCKUZJmW2yRRGoKB7T9NceZAzGquM/a9SkVzexnwK/e9fiuu0x1srSa20VL8G5OBjnvgYLn/t0TroYFZAE57g1fDUiJJYgRIHqQ1LgahdnvMCJnvHqF8nXZdCyC7BvMnJdaZCWSZhGfxcUVGEdNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BWou2GPZ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 568Bdl3m499007;
	Tue, 8 Jul 2025 06:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751974787;
	bh=mxl6kC3SyfXYPZI+86oINoVU7EXBLmnBKdgbQsXZOjA=;
	h=From:To:CC:Subject:Date;
	b=BWou2GPZiXLNX6iFcYbiJ66NJeRYAT2o/7GJQcEGFjh5LF+a948tDU0EpgTuQOcZ7
	 /JzM2QaHJoxKVQmKDnuCgM5MmwWVVqMlpSlSGqjj7odxSM6cz5RFb72tgXHP5ifWGH
	 swdoKqvMT0HwKdnWMsj/SEfG9c+yJygkvUf8Zbmk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 568BdlZM3229883
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 06:39:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 06:39:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 06:39:46 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 568Bdgqi1700412;
	Tue, 8 Jul 2025 06:39:43 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2] arm64: dts: ti: k3-am69-sk: Add idle-states for remaining SERDES instances
Date: Tue, 8 Jul 2025 17:09:42 +0530
Message-ID: <20250708113942.4137917-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

In AM69 SoC there are 4 instances of the 4 lane SERDES. So in
"serdes_ln_ctrl" node there are total 16 entries in "mux-reg-mask"
property. But "idle-states" is defined only for the lanes of first two
SERDES instances. SERDES lane mapping is left at its reset state of
"zero" for all four lanes of SERDES2 and SERDES4. The reset state of
"zero" corresponds to the following configuration:

Lanes 0 and 1 of SERDES2 are unused
CPSW MAC Ports 1 and 2 mapped to lanes 2 and 3 of SERDES2
EDP Lanes 0, 1, 2 and 3 mapped to lanes 0, 1, 2 and 3 of SERDES4

For completeness, define the "idle-states" for the lanes of remaining
SERDES instances.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
26ffb3d6f02c  Add linux-next specific files for 20250704

Changes since v1
As pointed by out by Siddharth, setting lanes of remaining SERDES
to "unused" will cause regression on AM69-SK as these lanes are used
by CPSW and Display. Updated patch to set the desired values for
remaining serdes lanes.

Rebased on current next.

v1: https://lore.kernel.org/all/20250609115921.2380611-1-h-salunke@ti.com/

 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index f28375629739..e803fa139b73 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -1294,8 +1294,12 @@ partition@3fc0000 {
 &serdes_ln_ctrl {
 	idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>, <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
 		      <J784S4_SERDES0_LANE2_PCIE3_LANE0>, <J784S4_SERDES0_LANE3_USB>,
-			<J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
-			<J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>;
+		      <J784S4_SERDES1_LANE0_PCIE0_LANE0>, <J784S4_SERDES1_LANE1_PCIE0_LANE1>,
+		      <J784S4_SERDES1_LANE2_PCIE0_LANE2>, <J784S4_SERDES1_LANE3_PCIE0_LANE3>,
+		      <J784S4_SERDES2_LANE0_IP2_UNUSED>, <J784S4_SERDES2_LANE1_IP2_UNUSED>,
+		      <J784S4_SERDES2_LANE2_QSGMII_LANE1>, <J784S4_SERDES2_LANE3_QSGMII_LANE2>,
+		      <J784S4_SERDES4_LANE0_EDP_LANE0>, <J784S4_SERDES4_LANE1_EDP_LANE1>,
+		      <J784S4_SERDES4_LANE2_EDP_LANE2>, <J784S4_SERDES4_LANE3_EDP_LANE3>;
 };
 
 &serdes_wiz0 {
-- 
2.34.1


