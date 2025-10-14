Return-Path: <linux-kernel+bounces-852108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB2BD82F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB9B74EE840
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437882DC32D;
	Tue, 14 Oct 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kRhb9m4+"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BE16F265
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430730; cv=none; b=mZx26tnQ+PNgcsQIzYdmQCuC97tdT7c63TjvoC0WARflCGK9afQCgD66bEip8hFFXwQu9UNf7D3k4zVBivNos6GjIoaJTrRUq5Ibp+5ghIrompEuAG70QOe0LczMUo34Ey4dz7dNlFxmlON9UlWFsDbYlT8FqHTzjD8kyyeuLuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430730; c=relaxed/simple;
	bh=DRk1IjvTasJN18u0p07ewwgVONxb6nL6wm5Y8t1OMiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G9yUHe3TW5Z+icT3zqhaCAip+VHVVXy96enmSUS9d4QPdxVCkWo2a9P6UnMEIDOZKwZcm5NOV8m8ldQKtUWg79OhBrtwlfv1wR+uztIpik1dgfZQdO5zcs+cRHb1GIG+Kih5q0K2VxNspFpif+5CRqCM+WJZ7P34DABVLSxRRs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kRhb9m4+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 16B1BC09F84;
	Tue, 14 Oct 2025 08:31:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 130B4606EC;
	Tue, 14 Oct 2025 08:32:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2858102F224B;
	Tue, 14 Oct 2025 10:32:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760430725; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lOAp+5UR+SK7oAZ3rWSUse+h2e6ToNaMpOEv6uQIYMs=;
	b=kRhb9m4+5/rK0ib7LkwRPXBXX5JbTjywCIc/43t3hP1ekvAL1NlGcABwX0r7CbpK5f+WUx
	EmQGmVLXwdGUEFr+v73EEcGSnibLG9hH7XO8rp0FheSKQLeR6w9tM+gGdY8w6cFpnI/Qar
	twM/oCya+dQJtUtd/oeV8ogLokDKbisWwHXJPzyPO13StgyIAclGaDaTefDs//1qv+lAfH
	Lj3txHXwTv9jjRmyWOXmGmg7P6i3zVcvsZ0Q3QilDoW/EkXSZJ/+kbprNmsDI3t+r9wcm/
	nkwFNrcUOSU1V5tHH+UQpugEK0USIeoneterp6tn8e4JnUpKu1/YNWJMOD0JPQ==
From: "Thomas Richard (TI.com)" <thomas.richard@bootlin.com>
Date: Tue, 14 Oct 2025 10:31:47 +0200
Subject: [PATCH] firmware: ti_sci: set IO Isolation only if the firmware is
 capable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-ti-sci-io-isolation-v1-1-67c7ce5d1b63@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAHIK7mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nj3ZJM3eLkTN3MfN3M4vycxBKgel0z40SLpOQUyxSTVEsloM6CotS
 0zAqwqdGxtbUAMDH+oWUAAAA=
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

Add the IO_ISOLATION firmware capability, and set IO Isolation during
suspend only if the firmware is capable.

Fixes: ec24643bdd62 ("firmware: ti_sci: Add system suspend and resume call")
Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
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


