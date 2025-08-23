Return-Path: <linux-kernel+bounces-783205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9816BB32AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B102A25E00
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34152ECD06;
	Sat, 23 Aug 2025 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZVu9S/PH"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDA2F1FF6;
	Sat, 23 Aug 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965460; cv=none; b=M9eif/2+JUjwZhErjXVZ1+QirOxvBrSNKh1dHBucepaaIO5F3277x+fI1LggnUeP2QzO4xIlNxBZnX3oftcuOuzIp7Mp/BkVi79ZBvGIimfSN76QT4REtuEvnKww5UstZbn6u6JAcUpwQSvzkwh6msDvQucns3bFvj5tpVSmye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965460; c=relaxed/simple;
	bh=xcKgtCMK/u/3+PwR5ftZQ3jZ82METuHVOhVIqC81SO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eea8HE36HJF5qCHfygfn/8qmPDly0GBUUDE5KcS7zjLSh6QM7JrMvBzwV25WfOetsomUg8p2iPzQN0/mRWeR7DfHcd1IIi0+Qn1gPoY1x0FQPEBu1iCi8qjv62FpsI0GcWzMBkFBFyUEV5A57nu21fXGaT9gIz/MKaS4GsnduMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZVu9S/PH; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGAjnu465165;
	Sat, 23 Aug 2025 11:10:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965445;
	bh=b9uSfr6ojlMufEEW06DLD5dJuKT5Cow3HA+9ylipXx8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZVu9S/PHOnDl36o+mBsGEvA6sXYlQATcf1YsbWz+Y7KKOOwCP0DnrmurPEVJWG0iH
	 IcJ7uHmY8XbpFKJLvZTgehvbhdwAge3Q44JqtIwibrcJ3WcaWIrkfa9g5y4QEHE5d2
	 bYkTed4acL8RY97BumpvHkH/a9eGkf3Uf3NX95Ys=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGAji6239731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:10:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:10:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:10:44 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9ExY1274978;
	Sat, 23 Aug 2025 11:10:39 -0500
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
Subject: [PATCH v2 18/33] arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Firmware
Date: Sat, 23 Aug 2025 21:38:46 +0530
Message-ID: <20250823160901.2177841-19-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823160901.2177841-1-b-padhi@ti.com>
References: <20250823160901.2177841-1-b-padhi@ti.com>
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
---
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: Matt McKee <mmckee@phytec.com>
Cc: Garrett Giordano <ggiordano@phytec.com>
Cc: Nathan Morrisson <nmorrisson@phytec.com>
Cc: John Ma <jma@phytec.com>
Cc: Logan Bristol <logan.bristol@utexas.edu>
Requesting for review/test of this patch.

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


