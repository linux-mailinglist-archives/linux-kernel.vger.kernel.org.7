Return-Path: <linux-kernel+bounces-806069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEFCB49188
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C08B34161A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FAD1EB5CE;
	Mon,  8 Sep 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h+v9/1RU"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92C1D514B;
	Mon,  8 Sep 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341812; cv=none; b=YEPx94XIyqCR3TPncSJRW58YJNSH1F6afScydUEktcEbX3snnTz/yalQGCazm/D4BL5hEb5NrerMX2GhQ6e9H0MFCPXpB7gdsJYVkRuz11DM4Xu4EIKR/dQeReEsJ0QCBU8lBNr3/i3DFngafNCtCVnGQ5rexiegM/Nfk+XVrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341812; c=relaxed/simple;
	bh=jJ97JC4ai9lfsQnAz9OqT5mIr3eSnFGAysRIQ9f/4wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBgzykX52QTfMjt05hQv8B9ct5hGpSfQMQHJp4G9e9QWRbUoJfCEI6oDc60PhwT01VlO9riBCUInAYVIEXNAbjpKk80Lv+a6dxHPHuXaY5d/MM+3daIkXg4ojldlfhRF3joEXYkp6/aNjvVB4/EH0zieFK9wjr//SxD98PiIG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h+v9/1RU; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EU5qd071480;
	Mon, 8 Sep 2025 09:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341805;
	bh=5Fw4uR5QXWsFCxr67i5Lils6Jy5yWW6LOeuKX7d910Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h+v9/1RU8nxoL6QnVmVY3uI7xUzZxSAYHS6CzUjqs37OQIaQ4kpMGh/d2lMHgL08M
	 JVFbEram/8jJdkwFpR+kqB7KerhQ0H577eJDoBbUgD+/EBWdBagRytSZXO2Yvxh1SO
	 78BhBxd/UOWkRQzJP/FHW4HaS/GnPxHgWeygTiK8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EU4WL2465100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:04 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecq1037553;
	Mon, 8 Sep 2025 09:29:59 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH v4 14/34] arm64: dts: ti: k3-j721e-beagleboneai64: Add missing cfg for TI IPC FW
Date: Mon, 8 Sep 2025 19:58:06 +0530
Message-ID: <20250908142826.1828676-15-b-padhi@ti.com>
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

The TI IPC Firmwares running on J721E SoCs use certain MAIN domain
timers as tick. Reserve those at board level DT to avoid remote
processor crashes. This config aligns with other J721E boards and can
be refactored out later.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Cc: Robert Nelson <robertcnelson@gmail.com>
Requesting for review/test of this patch.

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-14-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-14-b-padhi@ti.com/

v2: Changelog:
1. Split [PATCH 06/33] into [PATCH v2 13/33] and [PATCH v2 22/33].
This patch only reserves the timer nodes used by rproc firmware.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-7-b-padhi@ti.com/

 .../boot/dts/ti/k3-j721e-beagleboneai64.dts   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index ac4d90e82aab..66c4614f9e42 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -935,6 +935,35 @@ mbox_c71_0: mbox-c71-0 {
 	};
 };
 
+/* Timers are used by Remoteproc firmware */
+&main_timer0 {
+	status = "reserved";
+};
+
+&main_timer1 {
+	status = "reserved";
+};
+
+&main_timer2 {
+	status = "reserved";
+};
+
+&main_timer12 {
+	status = "reserved";
+};
+
+&main_timer13 {
+	status = "reserved";
+};
+
+&main_timer14 {
+	status = "reserved";
+};
+
+&main_timer15 {
+	status = "reserved";
+};
+
 &mcu_r5fss0 {
 	status = "okay";
 };
-- 
2.34.1


