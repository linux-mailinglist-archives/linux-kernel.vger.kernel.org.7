Return-Path: <linux-kernel+bounces-724578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D1AFF483
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6D75A0EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5940323B61D;
	Wed,  9 Jul 2025 22:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U8KtgA7f"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A6801
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752099400; cv=none; b=jGYg8l14MUOtnhn2khhznvDCB3XGPEGAWiQAXY+OBpihmn/tft8QosE73ET9bow4ZeWPQFn8W+bLNrmeGah66iwAQ3Aca/oZ9FBTZirw8l4Mafx9AusJil/cVHGDHNpO7U2BC9/jZYwhXB78Z3Wln35cLnhxdxndpimXDR3cOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752099400; c=relaxed/simple;
	bh=8zdAVsojbnQtCEVi9cTOyfUNw8mbMpmwW+XR6xMrJEw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BWVroLTDFQ4T1uw/qz/foU7QaHk+3EdPOMg531zU+i6bC6u/aP4JMjBHWhMFZ7cxYkM2EO+WvEoHhkCpAEu2GNWUcE8mNYX/wE7tBbU3GE8tIKt1VWrYxHOFQQuAebOTaP5r+RE+TzApY+AQKi4mRxV2jQ7bGj566fsJpsCR+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=U8KtgA7f; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 569MGKFP1326375;
	Wed, 9 Jul 2025 17:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752099380;
	bh=JIbyMx4pUQJaQizBCeoW8CblQcIuSEi6aEA0o/7zXuo=;
	h=From:To:CC:Subject:Date;
	b=U8KtgA7f0G7/Q5k60eGmmtYwDl/dSwlZeQt7UoYwuDwgLDO2fv4ctxpiOIX2KqO3F
	 mVYDjZZJ9NqtZQJP8uCH9N2w6CjEDY5dtRyADMVEU+5cDbIlAGOwoNS3p++sK0pR/m
	 sFykixi1k3aX3DmGfA0RuSDl0VHwJAuvynKW7Qww=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 569MGKxe555986
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 9 Jul 2025 17:16:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 9
 Jul 2025 17:16:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 9 Jul 2025 17:16:19 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 569MGJuI207024;
	Wed, 9 Jul 2025 17:16:19 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <vigneshr@ti.com>, <d-gole@ti.com>,
        <vishalm@ti.com>, <sebin.francis@ti.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <k-willis@ti.com>
Subject: [PATCH v3] firmware: ti_sci: Enable abort handling of entry to LPM
Date: Wed, 9 Jul 2025 17:16:19 -0500
Message-ID: <20250709221619.2237699-1-k-willis@ti.com>
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

The PM co-processor (device manager or DM) adds the ability to abort
entry to a low power mode by clearing the mode selection in the
latest version of its firmware (11.x). The following power management
operation defined in the TISCI Low Power Mode API [1] is implemented to
enable aborting entry to LPM:

TISCI_MSG_LPM_ABORT
Abort the current low power mode entry by clearing the current mode
selection.

Introduce LPM abort call that enables the ti_sci driver to support abort
by clearing the low power mode selection of the DM. This fixes behavior
from the DM where if system suspend failed, the next time system suspend
is entered, it will fail because DM did not have the low power mode
selection cleared. Instead of this behavior, the low power mode selection
will be cleared after Linux resume which will allow subsequent system
suspends to work correctly.

When Linux suspends, the TI SCI ->suspend() call will send a prepare_sleep
message to the DM. The DM will choose what low power mode to enter once
Linux is suspended based on constraints given by devices in the TI SCI PM
domain. After system suspend completes, regardless of if system suspend
succeeds or fails, the ->complete() hook in TI SCI will be called. In the
->complete() hook, a message will be sent to the DM to clear the current
low power mode selection. This is necessary because if suspend fails, the
low power mode selection in the DM is not cleared and the next system
suspend will fail due to the low power mode not having been cleared from
the previous failed system suspend.

Clearing the mode selection unconditionally acts as a cleanup from sending
the prepare_sleep message in ->suspend(). The DM already clears the low
power selection automatically when resuming from system suspend. If
suspend/resume executed without failure, clearing the low power mode
selection will not cause an error in the DM.

The flow for the abort sequence is the following:
   1. User sends a command to enter sleep
   2. Linux starts to suspend drivers
   3. TI SCI suspends and sends prepare_sleep message to DM
   4. A driver fails to suspend
   5. Linux resumes the drivers that have already suspended
   6. Linux sends DM to clear the current low power mode selection from
      TI SCI ->complete() hook
   7. DM aborts LPM entry by clearing the current mode selection
   8. Linux works as normal

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Series has been tested on an SK-AM62B-P1 board. Normal suspend/resume
has been verified. Abort was tested by adding an error into the TI SCI
suspend hook.

Link to v2:
https://lore.kernel.org/all/20250709205332.2235072-1-k-willis@ti.com/
Link to v1:
https://lore.kernel.org/all/20250627204821.1150459-1-k-willis@ti.com/

Changes from v2 to v3:
  - added links to previous series and the changes between them

Changes from v1 to v2:
   - rebase on linux-next
   - drop the following patch:
     pmdomain: ti_sci: Add LPM abort sequence to suspend path
   - remove lpm_abort from ti_sci_pm_ops
   - add ->complete() hook with ti_sci_cmd_lpm_abort to be called
     unconditionally within it
   - remove ti_sci_cmd_lpm_abort from the ->suspend() and
     ->suspend_noirq() hooks
   - reword commit message
---
 drivers/firmware/ti_sci.c | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h |  3 +-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ae5fd1936ad32..63c405f7037f0 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2015,6 +2015,58 @@ static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_lpm_abort() - Abort entry to LPM by clearing selection of LPM to enter
+ * @handle:     pointer to TI SCI handle
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_lpm_abort(const struct ti_sci_handle *handle)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_hdr *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_LPM_ABORT,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	if (!ti_sci_is_response_ack(resp))
+		ret = -ENODEV;
+	else
+		ret = 0;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
 {
 	struct ti_sci_info *info;
@@ -3739,11 +3791,20 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static void __maybe_unused ti_sci_complete(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+
+	if (ti_sci_cmd_lpm_abort(&info->handle))
+		dev_err(dev, "LPM clear selection failed.\n");
+}
+
 static const struct dev_pm_ops ti_sci_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.suspend = ti_sci_suspend,
 	.suspend_noirq = ti_sci_suspend_noirq,
 	.resume_noirq = ti_sci_resume_noirq,
+	.complete = ti_sci_complete,
 #endif
 };
 
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 053387d7baa06..51d77f90a32cc 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -6,7 +6,7 @@
  * The system works in a message response protocol
  * See: https://software-dl.ti.com/tisci/esd/latest/index.html for details
  *
- * Copyright (C)  2015-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C)  2015-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #ifndef __TI_SCI_H
@@ -42,6 +42,7 @@
 #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
 #define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
 #define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
+#define TI_SCI_MSG_LPM_ABORT	0x0311
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500

base-commit: 835244aba90de290b4b0b1fa92b6734f3ee7b3d9
-- 
2.34.1


