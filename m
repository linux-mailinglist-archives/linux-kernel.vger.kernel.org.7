Return-Path: <linux-kernel+bounces-858215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F236DBE94FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8BBB188FEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A822A7E4;
	Fri, 17 Oct 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qV/2XbYI"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2232C92A
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712310; cv=none; b=A06s9XduPHDsr1zuxMi7geJ82M7MQYgmP71dt9jUvy0vmV+lxsFZfmM6z9nRf4xu+CY2RhLrT245tRN1YG6rr0FJyrYRMlg2hBX8a/5m4oFVZDZAw49NKN/eco7UWh0YeBUZcuNji1K8ekVNB/TkCQet9uXiRKV63iHg9SaaqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712310; c=relaxed/simple;
	bh=clXNDy0DWgZwMoSm4KLIhxGZtZTDjJaOuAY2R4rT/No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rI+d26KVAmgN9Bhp+GSrr6JOtcAX42Rug6UEy2aNzSjOi3yPGgjGwu5uxJEn9xLYAla41wqveNMraupQ9ltcNDgjeXk0eh8O5Rsotz0GFWQbLIOLn8pZc7PYESXKIzZTrPxNjsmeF57BPZgc1TFT9FCmaQH0wLsM/dm8z2GEigo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qV/2XbYI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A5FB54E41146;
	Fri, 17 Oct 2025 14:45:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7D399606DB;
	Fri, 17 Oct 2025 14:45:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E297D102F235B;
	Fri, 17 Oct 2025 16:45:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760712304; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+uSUt2yy1oBYQ/RdtM4uwbd3VCepGzm02yRdJys3CrI=;
	b=qV/2XbYI6EMZpuFBgBfatWFWpGSkhu5KbnA2S+ke1yXdBAeevHyQrlnmC7s1Z5sM9wV5lP
	zVxsdBO5Yps3FShlV/eX+Ap50Ene7uURlFPn2rKVLwv9pAyxMx6h0yCeGtmSc1DWjpPYPC
	EDsG1JA/fdLNtwRMX2YUgnqe/NkYV5TeYIlz8YFrQc1l/ds7c1ZEg1u04eqXOB5Yk1g7DV
	pk+yz3OuIHqOKEIohY+q/1uHzpkLOUpc27CESkXd7aJ6KYtLrk8szfjSkVS7j2LGNgufpX
	m1soRs3fr40iyUZDwkgRb0ZBbKQza3rnLqSSTDKRxrzCVVsqlwaQHkRBSQJdKA==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Fri, 17 Oct 2025 16:44:50 +0200
Subject: [PATCH RFC 1/2] firmware: ti_sci: add BOARDCFG_MANAGED mode
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-1-34d4339d247a@bootlin.com>
References: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
In-Reply-To: <20251017-ti-sci-jacinto-s2r-restore-irq-v1-0-34d4339d247a@bootlin.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, 
 richard.genoud@bootlin.com, Udit Kumar <u-kumar1@ti.com>, 
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

In BOARDCFG_MANAGED mode, the low power mode configuration is done
statically for the DM via the boardcfg. Constraints are not supported, and
prepare_sleep() is not needed.

Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
---
 drivers/firmware/ti_sci.c | 10 +++++++---
 drivers/firmware/ti_sci.h | 14 ++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index da134ada64e179b4b307f7e0de5ed0f7371a96f2..f9f1a67e8e66b0a4048fae04ce31be54ca5cba7a 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3693,8 +3693,11 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
 			return ti_sci_cmd_prepare_sleep(&info->handle,
 							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
 							0, 0, 0);
+		} else if (info->fw_caps & MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED) {
+			/* Nothing to do in the BOARDCFG_MANAGED mode */
+			return 0;
 		} else {
-			/* DM Managed is not supported by the firmware. */
+			/* DM Managed and BoardCfg Managed are not supported by the firmware. */
 			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
 			return -EOPNOTSUPP;
 		}
@@ -3932,12 +3935,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 	}
 
 	ti_sci_msg_cmd_query_fw_caps(&info->handle, &info->fw_caps);
-	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s\n",
+	dev_dbg(dev, "Detected firmware capabilities: %s%s%s%s%s%s\n",
 		info->fw_caps & MSG_FLAG_CAPS_GENERIC ? "Generic" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO ? " Partial-IO" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED ? " DM-Managed" : "",
 		info->fw_caps & MSG_FLAG_CAPS_LPM_ABORT ? " LPM-Abort" : "",
-		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : ""
+		info->fw_caps & MSG_FLAG_CAPS_IO_ISOLATION ? " IO-Isolation" : "",
+		info->fw_caps & MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED ? " BoardConfig-Managed" : ""
 	);
 
 	ti_sci_setup_ops(info);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 7559cde17b6ccfeeb1bc357fce5c5767c3f75c54..ac1cf6971b8678aa1277abb86d9ec672493f4c86 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -150,6 +150,7 @@ struct ti_sci_msg_req_reboot {
  *		MSG_FLAG_CAPS_LPM_DM_MANAGED: LPM can be managed by DM
  *		MSG_FLAG_CAPS_LPM_ABORT: Abort entry to LPM
  *		MSG_FLAG_CAPS_IO_ISOLATION: IO Isolation support
+ *		MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED: LPM config done statically for the DM via boardcfg
  *
  * Response to a generic message with message type TI_SCI_MSG_QUERY_FW_CAPS
  * providing currently available SOC/firmware capabilities. SoC that don't
@@ -157,12 +158,13 @@ struct ti_sci_msg_req_reboot {
  */
 struct ti_sci_msg_resp_query_fw_caps {
 	struct ti_sci_msg_hdr hdr;
-#define MSG_FLAG_CAPS_GENERIC		TI_SCI_MSG_FLAG(0)
-#define MSG_FLAG_CAPS_LPM_PARTIAL_IO	TI_SCI_MSG_FLAG(4)
-#define MSG_FLAG_CAPS_LPM_DM_MANAGED	TI_SCI_MSG_FLAG(5)
-#define MSG_FLAG_CAPS_LPM_ABORT		TI_SCI_MSG_FLAG(9)
-#define MSG_FLAG_CAPS_IO_ISOLATION	TI_SCI_MSG_FLAG(7)
-#define MSG_MASK_CAPS_LPM		GENMASK_ULL(4, 1)
+#define MSG_FLAG_CAPS_GENERIC			TI_SCI_MSG_FLAG(0)
+#define MSG_FLAG_CAPS_LPM_PARTIAL_IO		TI_SCI_MSG_FLAG(4)
+#define MSG_FLAG_CAPS_LPM_DM_MANAGED		TI_SCI_MSG_FLAG(5)
+#define MSG_FLAG_CAPS_LPM_ABORT			TI_SCI_MSG_FLAG(9)
+#define MSG_FLAG_CAPS_IO_ISOLATION		TI_SCI_MSG_FLAG(7)
+#define MSG_FLAG_CAPS_LPM_BOARDCFG_MANAGED	TI_SCI_MSG_FLAG(10)
+#define MSG_MASK_CAPS_LPM			GENMASK_ULL(4, 1)
 	u64 fw_caps;
 } __packed;
 

-- 
2.51.0


