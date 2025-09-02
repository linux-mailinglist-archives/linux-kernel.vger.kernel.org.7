Return-Path: <linux-kernel+bounces-795558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98EFB3F483
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4351A83937
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961F2E2F13;
	Tue,  2 Sep 2025 05:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lfox1VpW"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450412E2845;
	Tue,  2 Sep 2025 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791035; cv=none; b=CAUIgB3l40diiJfzw/15DQEb5nCXtUBZD3t1ZTO/2J9ViDSmLVe+KnJtKr5U6fii28J+0G7CyFP0kX75ZigTv10Y3BGXO0bsMFyTeDeuOYi5KR4Hd1sirdpxEAypVkmUGSLo0KCssPxM7y1ChN/ZfMaNyeXrBmzZRgpAFqgD1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791035; c=relaxed/simple;
	bh=Ulhv75Qlq44PjAt1fNn3aAWHWlfAkTXC2kJODrhgsRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxFTnVAETu9qh58kr1l5X6lulcbXGsBARvh+8rV3eRXxtyEq9VwkL0tXZvpnNEstA5uJ3G0dTYWpAYqx4jSsL3p4z58lE2W12Wow17O2XWi9fp/06AqZpqn4QGaeunyoKTY1/PfMIqd2lt2kVuokOQ0v2szDFNfW0/KRbbK7FCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lfox1VpW; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5825UUs12512920;
	Tue, 2 Sep 2025 00:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756791030;
	bh=h6g6xeJfug9dBxQVoWAcU+Vude4Jbl2xTde0IUatn9c=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Lfox1VpWMAvbVqDqWtMw6BvPTM3A54Q/QMuPU9TC8YTGCGKksVonamMPpZOfwHbmA
	 OLOexSDFciFsiZ4OCzu8k5IJlX1186QuLwEuD3ACf8fyMMDci79sVFYWfwvq1HOJ5j
	 svyHZUGdgKakZ0IT9qncT10SyGHekDK2WGVnnrpI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5825UTP53247974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 00:30:30 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 00:30:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 00:30:29 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5825UAWr3551148;
	Tue, 2 Sep 2025 00:30:26 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 4/4] arm64: dts: ti: k3-j722s-evm: Add bootph-all tag to usb0_phy_ctrl node
Date: Tue, 2 Sep 2025 11:00:09 +0530
Message-ID: <20250902053009.1732607-5-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902053009.1732607-1-h-salunke@ti.com>
References: <20250902053009.1732607-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add bootph-all property to the USB0 PHY controller node to make it
available during all boot phases. This is required for USB DFU boot.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 9d8abfa9afd2..747fd63f86c7 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -936,6 +936,10 @@ &usb0 {
 	usb-role-switch;
 };
 
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
 &usbss1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_usb1_pins_default>;
-- 
2.34.1


