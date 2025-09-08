Return-Path: <linux-kernel+bounces-806066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007CFB49180
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF08216618F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723A30F958;
	Mon,  8 Sep 2025 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J+Davq9a"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6370A30F947;
	Mon,  8 Sep 2025 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341786; cv=none; b=C07RgVIbrsa6Knu8ZRViGj9JwkVqT1hl8xvJY1mKV6eoL+f9K+xaVCdtxhCiOFvLevewzD+3/FN1/HnRMO9BAdvsHl2RxPbNggP3mduqXk1SkPt1rgRC3e2+6GK0ekErj+2ObHxBGS1dAOruZ9mvdavIIF9cS/daO3bMe1qZI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341786; c=relaxed/simple;
	bh=4VAC74sntX6P1mfy/0Q2mFhZFOd1n3eR5P2A8ZcJo4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMoJV+4yRFsbZgBXjgTKbK0OcO73ieecReyTPPzwwKtUNX7r2Z/dZHAvvJm/Tsv89GVpfjCOndorgL7T1zOtgTKULZpF+Va/eTzQWztCTkhC/JjUFAX8avFhYmcGNFWoVSed0YfweujQsVgNG3t19o1ulhkUHCzvUwPWEjfw46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J+Davq9a; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588ETeE63810306;
	Mon, 8 Sep 2025 09:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341780;
	bh=rU+mm+amp45bfduue8CY66HDzrVq8m5EaGM9aWyB0eU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J+Davq9aMLZHR6bjBe2Z+XabYR8cg4KHtSxBhzp7CiSmN+xpYU4J+Fb+4PP+v/M1u
	 3yuNGEA9mM4zk6ezgKWIOv7e1+tC9dzTKFmGUbT8GCp9vCP+42JijKwMOxd0JcSqrV
	 acxkvBY1SRDZr71uRdHSMsvrz5wb86XfWakHZ8f4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588ETdcc3833444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:29:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:29:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:29:39 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecm1037553;
	Mon, 8 Sep 2025 09:29:34 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 10/34] arm64: dts: ti: k3-am62: Enable Mailbox nodes at the board level
Date: Mon, 8 Sep 2025 19:58:02 +0530
Message-ID: <20250908142826.1828676-11-b-padhi@ti.com>
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
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---
v4: Changelog:
1. Carried R/B tag.

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-11-b-padhi@ti.com/

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


