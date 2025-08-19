Return-Path: <linux-kernel+bounces-776446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89CAB2CD60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E577AB6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E530F7E1;
	Tue, 19 Aug 2025 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WNqEmylX"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B652F99
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755633314; cv=none; b=eGnhlXn2UU8UpmLL2VsiYtFJaqrQjvI9DJMsCFioKAc5KsjVT00CqzuoVoS2AMUiQG1kwOwGmlZ6Q7vxK5Xqs6rZr8/pJhFbRNIclyBPQALaC6ocWEqyCA2Jt2NAujnKIj3FVIYIyk3RrR2dE1QXMj88oCkP83YMLnlcBE0VCFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755633314; c=relaxed/simple;
	bh=1LlImT6c8BnD6dd/JPbzt9grQdISRDVcXlB7Ve7mp1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Odvx9Uyr21wth6VvLDzfetldknjPWEkg72RHU5FkKZVKXM64F0rxnp8qDT+zzZMK/73N7WanOFUX3Yf32E2CisyvUNRUnvVQFbvereccqYgkRYZ+G31sUddBs7os5jKB3ycWnXFfYx1ui16fhVDTDL/lcXM6BWyX2pLeodDdHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WNqEmylX; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JJt3fw3026446;
	Tue, 19 Aug 2025 14:55:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755633303;
	bh=qf75CQPmS6Vgpu2bv+6a7KC69P8DBinE50c4UZCzCAE=;
	h=From:To:CC:Subject:Date;
	b=WNqEmylXI/vfjj8iQPt8nHCge9EvKLNj1LTA2IRBy1WpD63DbtsCCfG3eliCkd7Rh
	 mQYsCosctFHGoYBFLh3L1TZsmFmlCQjHBagFTErk3kyAlchh/bBj6CSasfy2xlIGGr
	 nr2VOLXsGzyudzIMLgi0mSdwe5sCByHS/4XSip4c=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JJt3KD637564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 14:55:03 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 14:55:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 14:55:03 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JJt3q43241995;
	Tue, 19 Aug 2025 14:55:03 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ulf.hansson@linaro.org>, <d-gole@ti.com>, <vishalm@ti.com>,
        <sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
        <k-willis@ti.com>
Subject: [PATCH v4] firmware: ti_sci: Enable abort handling of entry to LPM
Date: Tue, 19 Aug 2025 14:54:53 -0500
Message-ID: <20250819195453.1094520-1-k-willis@ti.com>
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
latest version of its firmware (11.01.09) [1].

Enable the ti_sci driver to support the LPM abort call which clears the
low power mode selection of the DM. This fixes an issue where failed
system suspend attempts would cause subsequent suspends to fail.

After system suspend completes, regardless of if system suspend succeeds
or fails, the ->complete() hook in TI SCI will be called. In the
->complete() hook, a message will be sent to the DM to clear the current
low power mode selection. Clearing the low power mode selection
unconditionally will not cause any error in the DM.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Signed-off-by: Kendall Willis <k-willis@ti.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Series has been tested on an SK-AM62B-P1 board. Normal suspend/resume
has been verified. Abort was tested by adding an error into the TI SCI
suspend hook.

Link to v3:
https://lore.kernel.org/all/20250709221619.2237699-1-k-willis@ti.com/
Link to v2:
https://lore.kernel.org/all/20250709205332.2235072-1-k-willis@ti.com/
Link to v1:
https://lore.kernel.org/all/20250627204821.1150459-1-k-willis@ti.com/

Changes from v3 to v4:
  - rebase on linux-next
  - reword commit message
  - change ti_sci_cmd_lpm_abort parameter to be the device pointer
  - remove setting ret to 0 when checking for failure in
    ti_sci_cmd_lpm_abort since ret is set to 0 by default
  - change ti_sci_complete() to ti_sci_pm_complete()
  - add firmware capability support for LPM abort
  - update debug message of detected firmware capabilities with
    LPM-Abort
  - check if the firmware has the capability for LPM abort functionality
    before calling ti_sci_cmd_lpm_abort
  - remove updated year in the ti_sci.h license

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
 drivers/firmware/ti_sci.c | 57 +++++++++++++++++++++++++++++++++++++--
 drivers/firmware/ti_sci.h |  3 +++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ae5fd1936ad32..49fd2ae01055d 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2015,6 +2015,47 @@ static int ti_sci_cmd_set_latency_constraint(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_lpm_abort() - Abort entry to LPM by clearing selection of LPM to enter
+ * @dev:	Device pointer corresponding to the SCI entity
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ */
+static int ti_sci_cmd_lpm_abort(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+	struct ti_sci_msg_hdr *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
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
@@ -3739,11 +3780,22 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 	return 0;
 }
 
+static void __maybe_unused ti_sci_pm_complete(struct device *dev)
+{
+	struct ti_sci_info *info = dev_get_drvdata(dev);
+
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT) {
+		if (ti_sci_cmd_lpm_abort(dev))
+			dev_err(dev, "LPM clear selection failed.\n");
+	}
+}
+
 static const struct dev_pm_ops ti_sci_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.suspend = ti_sci_suspend,
 	.suspend_noirq = ti_sci_suspend_noirq,
 	.resume_noirq = ti_sci_resume_noirq,
+	.complete = ti_sci_pm_complete,
 #endif
 };
 
@@ -3876,10 +3928,11 @@ static int ti_sci_probe(struct platform_device *pdev)
 	}
 
 	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
-	dev_dbg(dev, "Detected firmware capabilities: %s%s%s\n",
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s\n",
 		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
-		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : ""
+		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : ""
 	);
 
 	ti_sci_setup_ops(info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 053387d7baa06..701c416b2e78f 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -42,6 +42,7 @@
 #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
 #define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
 #define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
+#define TI_SCI_MSG_LPM_ABORT	0x0311
 
 /* Resource Management Requests */
 #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
@@ -147,6 +148,7 @@ struct ti_sci_msg_req_reboot {
  *		MSG_FLAG_CAPS_GENERIC: Generic capability (LPM not supported)
  *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
  *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
+ *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
  *
  * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
  * providing currently available SOC/firmware capabilities. SoC that don't
@@ -157,6 +159,7 @@ struct ti_sci_msg_resp_query_fw_caps {
 #define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
 #define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
 #define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
+#define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
 #define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
 	u64 fw_caps;
 } __packed;

base-commit: 886e5e7b0432360842303d587bb4a65d10741ae8
-- 
2.34.1


