Return-Path: <linux-kernel+bounces-806077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DCB49193
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738E044261E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB73112D6;
	Mon,  8 Sep 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c6oalWVY"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB1310783;
	Mon,  8 Sep 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341848; cv=none; b=DN35fouEK76jVus1EtEytGa4cSFguIlPc+gjkN1C2SfN8qlW98ePWt3VES9wbyVzFGVGYil7wJyjWwnu4cQKBSrsf/NTPWzrR+EIiqYDFxjej49CoaVLGfIi1WegXss8gSF+y9JIVPFAg/xmBwa2G5wj4DPyyJk5J7pj44t8nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341848; c=relaxed/simple;
	bh=Eg3lbr5+J5RMy14cqOptDZdnkB6gAw065T7R65RTLpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CV3bQ0ffGRcZt7yO4t6esqK8FG6cSnH8HSVP5NU8fG0dzVOlcjVxf5OvL4LqFbyl5n6JpzfQgzcoDUKqNuT4z5NEzMCjYGda/MVXs7gbL9nymsyOJcZx6iYBL+DrZY4+qp0ok1QwJbDbRpxl9qLpMP78Y6gFyZpQVPFfmFKbKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c6oalWVY; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EUXmI120446;
	Mon, 8 Sep 2025 09:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341833;
	bh=d0PM6BQoMCaPEbPybv2NDcfnzLwH94k+onqfWHsmaCk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c6oalWVYr/tfl+8DFPE+K+sDjPjnUZNbi9oUN/QzrDcRZZn3SPsUzy2DgWKlsW4WV
	 DH1ZK2riNk7KIj+K+p2FxlhSCPKlN2ztluvE8YVYDMgXhPpCu8Ihs5ZQCm1+KFyXPe
	 PUiaBXZwTdxdvSbSN+/fL+Z7Nng6fPBF5r8A/Fr4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EUX4b3835446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:33 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:33 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:33 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecv1037553;
	Mon, 8 Sep 2025 09:30:27 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Wadim
 Egorov <w.egorov@phytec.de>, Matt McKee <mmckee@phytec.com>,
        Garrett Giordano
	<ggiordano@phytec.com>,
        Nathan Morrisson <nmorrisson@phytec.com>, John Ma
	<jma@phytec.com>,
        Logan Bristol <logan.bristol@utexas.edu>
Subject: [PATCH v4 19/34] arm64: dts: ti: k3-am64-phycore-som: Add missing cfg for TI IPC Firmware
Date: Mon, 8 Sep 2025 19:58:11 +0530
Message-ID: <20250908142826.1828676-20-b-padhi@ti.com>
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

v4: Changelog:
1. None

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-19-b-padhi@ti.com/

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
index ba425b125d63..5e0c82960a6c 100644
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


