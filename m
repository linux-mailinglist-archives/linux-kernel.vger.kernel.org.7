Return-Path: <linux-kernel+bounces-768932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A724FB267E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C7DD7B1EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770993002B0;
	Thu, 14 Aug 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GRrSuZoy"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C62FF648;
	Thu, 14 Aug 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179230; cv=none; b=gchAVe9E0H/mVI1eLz+f8ttRtKIqg6zbe0D0GuXNjFw2tx2cOBwYJTVMkTv8iU+RPJBqG+blih2Jgrsy6YTsgSvQvLBdqQRFACdTWFPdK9jKiTNJPv8VrRj1OBm34qD/ZBm6dPaMAMbMlFShrqfUF1VUlv6QVSIqzV/kn4zEZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179230; c=relaxed/simple;
	bh=cPvDSEQKrZluoVkIJtKNEnmIuLUeV/XH1pGS0Oz+BQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DD9H2OJc+fRVcKLFUCyD6dL5OjOMZXxE4A3deeG+y1eTxsbakBYuTxOo0rKh9tN0IqHq57PgrTiVsailPkbZzZ661Rk3kO1JH+nWg6aDgvVlMiWEHWGzcWbCxemjJQBns1HxTbFSgbhnUvDmU75ELZqYxt9uVNx62LaNXIgU2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GRrSuZoy; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EDkxNH1890365;
	Thu, 14 Aug 2025 08:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755179219;
	bh=Buc6rlApwruj6W3+FP82DHK9JKaKV424nIqt395WFlg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GRrSuZoyPxUHlArfe315Sv7y9Eiaxu6ls+ojy685CtQlto67aV3i305taeuHsrGyU
	 g/9DGk8UglFAyPmIjWILTl4My4rd88zFJ9Cf9Axgq5OeQ6zKu2xT2vx357nGDTviDC
	 MvKp+WlUEmvJ16HMtOYAqFUuKPRgfXFWG+xedzLk=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EDkxaU1872418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 08:46:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 08:46:58 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 08:46:58 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EDkvNN3995964;
	Thu, 14 Aug 2025 08:46:58 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: Anshul Dalal <anshuld@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/4] arm64: dts: ti: Introduce base support for AM6254atl SiP
Date: Thu, 14 Aug 2025 19:15:29 +0530
Message-ID: <20250814134531.2743874-4-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814134531.2743874-1-anshuld@ti.com>
References: <20250814134531.2743874-1-anshuld@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch adds the top level dtsi for AM6254atl SiP which integrates
the existing AM625 SoC with 512MiB of DDR in a single package.

More information about the package can be found here:
https://www.ti.com/lit/ds/symlink/am625sip.pdf

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6254atl.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am6254atl.dtsi b/arch/arm64/boot/dts/ti/k3-am6254atl.dtsi
new file mode 100644
index 000000000000..976ad7dc1e71
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6254atl.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * DTS for AM625 SiP SoC family in Quad core configuration and 512MiB RAM.
+ *
+ * Webpage: https://www.ti.com/product/AM625SIP
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-am625.dtsi"
+
+/ {
+	model = "Texas Instruments AM6254atl SiP";
+	compatible = "ti,am6254atl", "ti,am625";
+
+	memory@80000000 {
+		/* 512MiB of integrated RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x20000000>;
+		device_type = "memory";
+		bootph-all;
+	};
+
+};
-- 
2.50.1


