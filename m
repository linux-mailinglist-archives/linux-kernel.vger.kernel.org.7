Return-Path: <linux-kernel+bounces-880182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48679C25113
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 365DA4E8859
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D01F872D;
	Fri, 31 Oct 2025 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MUY1i8uU"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D61A23B6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914723; cv=none; b=JWX+Y7TCyK1PJBF7pZ0Y463tQEBURySg7qPxt37e6n9ZZdigfgXTQAEsG1jkeyt02uaNyVeRe/zojVWUgyDSR4oE2CWkCBNzY/We2Zh8TyWsl9S+zy9m5AQOcPSuG+ZXiR9N7WtJjow4qrtD9rPI8WTd0OGA/IemyuQIfWmmW88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914723; c=relaxed/simple;
	bh=K5q//jN+xFbMnjLt2ib59yWrnzhPh0H51eHTGov1I/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PanCYEF421fX8gPSmVZ+zNlGYLhI50OMd6+aRp8clHU3QcuL3wZD7lYGYLJYCemEVTXJ67ujsVKEPB4CYL40DCn8S87M9ySNFVit35apNRMt9EHOnPYHTPP6GxgqMA1h7JrimwN0IXYW/lF4OM4D4YakGdLUY3O+doCGZvXFOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MUY1i8uU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D71FAC0E952;
	Fri, 31 Oct 2025 12:44:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4314460704;
	Fri, 31 Oct 2025 12:45:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15CD2102F23AA;
	Fri, 31 Oct 2025 13:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761914709; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qgp6G2apTFkb3BTGo6WcnDijZFxPuR/3oy0/Azz+WCc=;
	b=MUY1i8uUMpvgefI9eoO3XmEIctdlBkOt1P6m+IdM/SUJq3wMJEzoVpdNDeS1n1bBfnp167
	wUxbi/+n7wmfr3AxctsYaZb+JcxV6vSe6v3DGA34/hlYlKpijUpJtPP6NLvyGJG+OOrdu4
	TMPC+WgJ2eBBXxd/Z7q7RNSozwIRR8OEGrotYYcwYdUieEUGZwnQSeSa0tZY7/R0Xnt7Af
	VY+Ivzz628EgNSFmfbLYgKueOoi1qP2k9g2LqKLuhGrDyjdV0zGJtRX8EjUHIKSYX7Fbh1
	7EAz9YjTiUDEdgVlAx/l8hBnMNkDCyMt2M1hjcGX3OfO1FHuMda8wZ6R14VzqA==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Fri, 31 Oct 2025 13:44:56 +0100
Subject: [PATCH v2] firmware: ti_sci: set IO Isolation only if the firmware
 is capable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-ti-sci-io-isolation-v2-1-60d826b65949@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAEevBGkC/22NSwrCQBBErxJ6bUsmX+PKe0gW82lNQ0zLzBCUM
 Hd3DLhz+YqqVxsE8kwBzsUGnlYOLEuG6lCAnfRyJ2SXGaqyalWpaoyMwTKyIAeZdcx97Gp9MtY
 NrqEB8vLp6cav3XodM08covj3frKqb/rzNX99q0KFXW97S61TpqsvRiTOvBytPGBMKX0ATAPOy
 bgAAAA=
X-Change-ID: 20251013-ti-sci-io-isolation-63a8bcd9d4e9
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Prevent calling ti_sci_cmd_set_io_isolation() on firmware that does not
support the IO_ISOLATION capability. Add the MSG_FLAG_CAPS_IO_ISOLATION
capability flag and check it before attempting to set IO isolation during
suspend/resume operations.

Without this check, systems with older firmware may experience undefined
behavior or errors when entering/exiting suspend states.

Fixes: ec24643bdd62 ("firmware: ti_sci: Add system suspend and resume call")
Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
Changes in v2:
- improve commit message
- Link to v1: https://lore.kernel.org/r/20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com
---
 drivers/firmware/ti_sci.c | 21 +++++++++++++--------
 drivers/firmware/ti_sci.h |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 49fd2ae01055d0f425062147422471f0fd49e4bd..8d96a3c12b36a908097805b44dc3343172fbbfec 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3751,9 +3751,11 @@ static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
 	struct ti_sci_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
-	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
-	if (ret)
-		return ret;
+	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
+		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_ENABLE);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -3767,9 +3769,11 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
 	u8 pin;
 	u8 mode;
 
-	ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
-	if (ret)
-		return ret;
+	if (info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION) {
+		ret = ti_sci_cmd_set_io_isolation(&info->handle, TISCI_MSG_VALUE_IO_DISABLE);
+		if (ret)
+			return ret;
+	}
 
 	ret = ti_sci_msg_cmd_lpm_wake_reason(&info->handle, &source, &time, &pin, &mode);
 	/* Do not fail to resume on error as the wake reason is not critical */
@@ -3928,11 +3932,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	}
 
 	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
-	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s\n",
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s\n",
 		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
-		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : ""
+		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : "",
+		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : ""
 	);
 
 	ti_sci_setup_ops(info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 701c416b2e78f8ef20ce6741a88ffa6fd4853b2d..7559cde17b6ccfeeb1bc357fce5c5767c3f75c54 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -149,6 +149,7 @@ struct ti_sci_msg_req_reboot {
  *		MSG_FLAG_CAPS_LPM_PARTIAL_IO: Partial IO in LPM
  *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
  *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
+ *		MSG_FLAG_CAPS_IO_ISOLATION: IO Isolation support
  *
  * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
  * providing currently available SOC/firmware capabilities. SoC that don't
@@ -160,6 +161,7 @@ struct ti_sci_msg_resp_query_fw_caps {
 #define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
 #define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
 #define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
+#define MSG_FLAG_CAPS_IO_ISOLATION	TI_SCI_MSG_FLAG(7)
 #define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
 	u64 fw_caps;
 } __packed;

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251013-ti-sci-io-isolation-63a8bcd9d4e9

Best regards,
-- 
Thomas Richard (TI.com) <thomas.richard@bootlin.com>


