Return-Path: <linux-kernel+bounces-802061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A9BB44D43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83235819AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E63C2882CC;
	Fri,  5 Sep 2025 05:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NxxQyYgu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10142882A6;
	Fri,  5 Sep 2025 05:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049587; cv=none; b=uVhP2pM59ibIjWJGD3zesklG/gAK5tnVoN41tEPXXfqFitmPgaD8bmYyE6bBRzs50S8irSNqP3DtdLfzEjvkHMbySfJgnwB47Cqb3ciYppg9sGiqEImuTxx2aypNq5e2D/D9e7cNgOEiWf0f59gcj4+x73oYXVhwyUe2zK4M/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049587; c=relaxed/simple;
	bh=gKUtSKxNIRX9xnlBFGeZvyGUz9scKLbfUFd20+WmH6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH07wkapIaLhZv0PSkMU2o1PFVztxkzus3KbXp0xMhAajkBVAWsn/dpLWcotUcue93kf77LAVmm+ueMBaG/r74kV1Lpon2mh4w4n2NYrtmEdio1IQtzHXf71u3qdCrGsQEa1g2PUvZZmbRlORljtHhRvufu7vD2JI1u1rGc5s9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NxxQyYgu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5855Jf2K3246373;
	Fri, 5 Sep 2025 00:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757049581;
	bh=DVy18PILXYnifdwEYcy49fmDDwIUp7yNGnM1FnMcRJ8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NxxQyYguJu3NCll2pmHslpUkrzX6jr7hByttbfiNYX3VptXz0HrN0pIHAtze63eaX
	 vc7MYDHxdh1sITDKXr0V5vlPWW7gLBh6nBslLgcpiqDv+BQuMT9jsmI8EwAmjMINHM
	 jnYUZxIXT1/ocVQOcHJ5phcbGwnFklanZnNkeCNg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5855Jf3L136247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 5 Sep 2025 00:19:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 00:19:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 00:19:41 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5855Ioid220581;
	Fri, 5 Sep 2025 00:19:37 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 10/33] arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
Date: Fri, 5 Sep 2025 10:48:23 +0530
Message-ID: <20250905051846.1189612-11-b-padhi@ti.com>
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

Mailbox nodes defined in the top-level AM62x SoC dtsi files are
incomplete and may not be functional unless they are extended with a
chosen interrupt and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones
that are actually used on a given board.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
---
v3: Changelog:
1. Carried A/B tag.

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-11-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 20/33] to [PATCH v2 10/33].
2. Added new-line before sub-nodes in mailboxes.

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-21-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi         | 1 +
 arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts | 2 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi       | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 029380dc1a35..40fb3c9e674c 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -808,6 +808,7 @@ mailbox0_cluster0: mailbox@29000000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	ecap0: pwm@23100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
index 2e4cf65ee323..2eee5f638e0f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-pocketbeagle2.dts
@@ -293,6 +293,8 @@ &epwm2 {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index bc2289d74774..bbf2d630b305 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1317,6 +1317,8 @@ &main_i2c3 {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
 		ti,mbox-tx = <1 0 0>;
-- 
2.34.1


