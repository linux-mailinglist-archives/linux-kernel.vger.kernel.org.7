Return-Path: <linux-kernel+bounces-801651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61EB44857
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3F26AA3A32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11ED29ACE5;
	Thu,  4 Sep 2025 21:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sGWiBWqZ"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597C299AB1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020585; cv=none; b=ervE9aWvTS3r2JsdvWE7fvrPjM80G2LcOUOyYJPWUhgt2zmTHUc73e+VNyfJJ+ETyB1nDD1rAhv+ybwPsQXCdrw64QUDg26mbWDN/U16LpORyBTzDMCEmMHcEt2uYkdBDl1LOIrntwT4wvjRTOFrlbEHjupsLb3jfIuRXVL5qrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020585; c=relaxed/simple;
	bh=ivOX1ld7VvCQmLVQ5AfKBAztJa+1u3QWHuo+5r13KLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ul+TGsSGlAm2JrkKpJ6YWmC/38hXYbQpBPNNZ5yg+050VtbbPr2jhfmY+0lkcV5fqy7tH24gILfNLYCpfS21QSWgefl7kCb6Z1x/7DxAUafT3mPl9h86ZUnCG9rIf55z07Ldj6znnwKQFhkprNWfOLZwpzA93yvYqsKVb2JorZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sGWiBWqZ; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 584LGDx53601372;
	Thu, 4 Sep 2025 16:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757020573;
	bh=DWJ2W+AjO7Vr3KpquAF9HugBJC33BjyuCqaTUfC2d0Q=;
	h=From:To:CC:Subject:Date;
	b=sGWiBWqZx1g8mum1FG/ztCM5Op30pmpaS5YFGr5qJcuzFD8EXoTx8Ci9qDinYPRMT
	 k6IFzqwKiPq/VHwC0IWXnaExRErsA7AJHuZq5GRGL0r2VTslIVBdxB7/TBBY4MuLqu
	 ysS6EZOD2+GywEEb03FpjDUP5cUOQK8k/hBD+YYg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 584LGD13444459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 16:16:13 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 16:16:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 16:16:12 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 584LGCQI3890784;
	Thu, 4 Sep 2025 16:16:12 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
        <k-willis@ti.com>
Subject: [PATCH] pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl wakeup state
Date: Thu, 4 Sep 2025 16:16:07 -0500
Message-ID: <20250904211607.3725897-1-k-willis@ti.com>
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

In TI K3 SoCs the PM co-processor (device manager or DM) will decide
which low power state to suspend into based off of constraints given by
Linux. If a device is marked as a wakeup source in Linux, Linux will add
a constraint that the wakeup source has to be on. The DM will enter the
deepest low power state based off of the constraint.

In cases like UARTs, IO daisy-chaining can be used to wakeup the system,
however if the UART is marked as a wakeup source, the system is not able
to enter any low power mode.

IO daisy-chain wakeup can use the pinctrl wakeup state instead of using
wake IRQs. For example, the serial driver on K3 platforms uses a wakeup
pinctrl state to be able to resume from suspend.

Devices that are marked as a wakeup source and use pinctrl wakeup state
should not set wakeup constraints since these can happen even from deepest
low power state, so the DM should not be prevented from picking deep power
states.

Detect the pinctrl wakeup state in the suspend path, and if it exists,
skip sending the constraint.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
This series is intended to be implemented along with the following
series:

1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
   wakeup state": (this patch) skips setting constraints for wakeup
   sources that use pinctrl state 'wakeup'.

2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
   the UARTs for TI K3 SoCs

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
   functionality to wakeup the system from the Main UART

Testing
-------
Tested on a SK-AM62B-P1 board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 82df7e44250bb..884905fd0686c 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
@@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
 	struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
 	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
+	struct pinctrl *pinctrl = devm_pinctrl_get(dev);
+	struct pinctrl_state *pinctrl_state_wakeup;
 	int ret;
 
 	if (device_may_wakeup(dev)) {
+		/*
+		 * If device can wakeup using pinctrl wakeup state,
+		 * we do not want to set a constraint
+		 */
+		if (!IS_ERR_OR_NULL(pinctrl)) {
+			pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
+			if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
+				dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
+						"constraints\n", __func__);
+				return;
+			}
+		}
+
 		/*
 		 * If device can wakeup using IO daisy chain wakeups,
 		 * we do not want to set a constraint.

base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
-- 
2.34.1


