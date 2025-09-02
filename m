Return-Path: <linux-kernel+bounces-795559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD1B3F48A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D337AE9C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD02E1749;
	Tue,  2 Sep 2025 05:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hinylNHc"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DC2E2EF5;
	Tue,  2 Sep 2025 05:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791037; cv=none; b=G9bFP/7TzyrbDo6ZjdGfp6bntI8I7SzCPF6srOl+wpy1mJaAz5GNcHBs82fabZETMiToHPcffyc+oJe44EvIfUCN3mFVyvreKmv8m29AnE/RltP1ZZmN7yJMnC9No9n3IFBYW7OxuJ9BSe2n+NVH080nAvO6xdnT725Cktdv5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791037; c=relaxed/simple;
	bh=rpZAay6a2V9sMzqZJgbhDyf4U3sTNt6BRKx7wNlYEDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHqqM2adhDEeI2RdULRIy1aV9U/D6v4csSaK4hwxuutFfGNRSiO8YVTJSSc6ziaNAaQ7eSYsXP17Xdsj1o0Hfstc0vBY4WnCDhLCgELtBjdMjMdcMmmX4SVwPXk4P2daTeB/hGbB5fBpbz0rVNE3XvJgB3Prpe7I73viDa+4wZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hinylNHc; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5825UQot2947813;
	Tue, 2 Sep 2025 00:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756791026;
	bh=fY/E7hIcZ5ehqKi0AptPwrgo3N8a67AyknBPyxBdMsw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hinylNHcKzZvT9r8IhVRwWYCY9hL6rUqzEOo3P+28aecOLKyT0H7kUNBQGkgXUvJG
	 vpAhr6zBXfzm522N64ElKG3s2mfBJIf605TZ0dFKGHt/G/04dklYfD53/wI3e9+C+v
	 gqEbHDbc0plMuzpZz1G9pSr88wUL64wBbwacApL8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5825UQYX2606377
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 00:30:26 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 00:30:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 00:30:25 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5825UAWq3551148;
	Tue, 2 Sep 2025 00:30:22 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 3/4] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all tag to usb0_phy_ctrl node
Date: Tue, 2 Sep 2025 11:00:08 +0530
Message-ID: <20250902053009.1732607-4-h-salunke@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 13e1d36123d5..554def7b5c55 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -530,6 +530,10 @@ usb0_hs_ep: endpoint {
 	};
 };
 
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
 &usb1 {
 	dr_mode = "host";
 	pinctrl-names = "default";
-- 
2.34.1


