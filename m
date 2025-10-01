Return-Path: <linux-kernel+bounces-839071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E780BB0BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9287D1945CB5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FCA25A343;
	Wed,  1 Oct 2025 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zFMUPWc5"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B415259CBC
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329499; cv=none; b=DKkChx57ScIgn0P2XFGSw8ZtWOK+ygr7VjZOR/sI01yt++Wo8wGAe4zQtArxDMoZ3V4hpy8IuYYetUYFIgifRmEec685sZ2Tpsx2AcRWzXlkOgLCCHiA1bhWU/i6n2w2K4pmyPnxFuRZ2KCrmMDKBVGzz69B2kqJvdUnK1CllJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329499; c=relaxed/simple;
	bh=26F0Bvu56G754C2jeroEex8fImMoz0+Y7BY0qxomFcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QeWgxuC/rXtdq6E4kESUWtA6RY9YMn/feyFvPO2Kfnt6Y332EARGM5eCYoTaZECy51ZQ8OaIaLN9HIINAZKqRa4oYAyaX91Ewl8lZ6xS6XWvYKHqJjmi9ScBHDYUzRuXjnPXzgiBbZo5iUVI35r7rn3clFjsf87QJ2xSlBqDigA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zFMUPWc5; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fca216e4aso2538941a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329495; x=1759934295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJU/7pOy6k5Otq6sscIBJ2rwBspnn6iIa72yddH68yU=;
        b=zFMUPWc5kNac3qJiHDiXoxxw9/HrAuRbaiH+J96qjZM37bHDYf6yQFMQUHFAXjKCxL
         BFV23W/wonSlKZi4gHhybQ9w7canW9x2ImCwupjmAWF6tM/2x2GzUkGkrhPAYTUwfhfh
         UPpTmi/lNkgs0FeDNKk5oPlMBLH2PDvzaY+ArKpiVHzAINgA3v6oxmNmTTVTMblv6VS/
         nchMwrsbYQICXMnUtZeyixp230SivgItVCN6lXrnBbiqrpt4uy7YDxZT2a8pBjU7TBNO
         pi5em2xLF4uxK6JIF4wEP4D+tVzI8N2BuOgpAvuWGWQ9t/kuBJPn7+gifT8yAijcmDYE
         lwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329495; x=1759934295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJU/7pOy6k5Otq6sscIBJ2rwBspnn6iIa72yddH68yU=;
        b=qNMoprSJe0xwVlCaB1LYUp5tgr3+kNkqOhBC3gMv7d1ZcSPHnOqAi0ega2bOaqio86
         /uR+IF4b9/2kGkzIdMXoV/U540NMkDydTfdpuEakKeEphKhnbGJtBYOqPH4lhFnf8r1O
         nv2b5ADwx+eUie8ZkXEZlac1UNZnKa2DTHpCpGMNXznQXcaSHnSg/sVjE3ejFacWEeBn
         2HisaOJEi11o8UGoIkBW99mSlkk9W++BJYUPFthXJsrR+3Ka9of95eA2Fs2s3ud0Rq4G
         Ad3x+Vi8+hXMMTzQMQVc157ZnRh/b7Cz7i7iBRCjPXllu53dpliLMp8TgGI9L4RfVuTx
         6SbA==
X-Forwarded-Encrypted: i=1; AJvYcCUL66eQ4h4PRHl9W+Rr6qLeDmQfrnaiCGFwuQ5qPRcCPd3zuqPdb/l2htmtEjLB9IdekO9xEKJPsKuDuw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWdk2VAcgUISIaPoB9Fgj71oVe5uDGLRNpL8hCQyMtuI44ag2n
	XlQkZ5ydO7iU2CBHPqqSLbFatT0YGy0iRtc96R+rBmzWlkK93qTeBFfcwB++dbPereg=
X-Gm-Gg: ASbGncti9Evi09GC5uqxS/ufo7xujnaBJQzOaNcH8NRmY2z4D5FX3AAwKkKtRSJ0cI9
	1z/uC/RxjNEhYhPWjhILk8GcNXe+SWoD5pHP8YMNqejQbjxT5LTi/O16vv1vluvPAvqXg2j0Khp
	9Bcu2ddAYXWoGZ8AUrdP13kCUIZoLKIiZyK9WRAARQDsIOg6iuKVP1p+o+ZMnMrS3FEbk7uxft5
	bH60lovTsiXVFsfCs6vbGl75pJnHEUsKvvYxTFUKVwgUtick5HhpNQoLUryq+upl7Ljx6XcMybc
	Rf8F9yVNUarQ/LuvBRkp7HTQJH2s1JZp31EF/m0sKafF+5CBO3AP65+99AGI9KcwBl58cTe+882
	fBLgJYDdo3X7gnNLVfAO9MKjxrdD1VjRewH/4nXYm5Wxl
X-Google-Smtp-Source: AGHT+IHa+wgm9MD2zteKAX3Y2oGpaJkBinAUJ1mEYJmTWJxIgm9mxSJSEQIgwJA1FEqnxgmGTDrd0A==
X-Received: by 2002:a05:6402:649:b0:633:14bb:dcb1 with SMTP id 4fb4d7f45d1cf-6365af5ecedmr6350873a12.11.1759329495320;
        Wed, 01 Oct 2025 07:38:15 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6366a3e38cbsm3065840a12.15.2025.10.01.07.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:38:14 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:37:40 +0200
Subject: [PATCH v8 3/3] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-am62-partialio-v6-12-b4-v8-3-76a742605110@baylibre.com>
References: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
In-Reply-To: <20251001-topic-am62-partialio-v6-12-b4-v8-0-76a742605110@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7001; i=msp@baylibre.com;
 h=from:subject:message-id; bh=26F0Bvu56G754C2jeroEex8fImMoz0+Y7BY0qxomFcU=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy7Nme6LR9Mm8jepaJtdpuDzyVKLWeh2pQnN1obzItsO
 rrfftDsKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIkcKGRk+MNx876kxQbP6JKW
 dg2zOX9/8f59tqXEVKR5bnnCfAbZEoZfTLZCGgFqS2xVmiWc7gZvtNmgcjvj3nrxqZt+RDV9903
 iAwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add support for Partial-IO poweroff. In Partial-IO pins of a few
hardware units can generate system wakeups while DDR memory is not
powered resulting in a fresh boot of the system. These hardware units in
the SoC are always powered so that some logic can detect pin activity.

If the system supports Partial-IO as described in the fw capabilities, a
sys_off handler is added. This sys_off handler decides if the poweroff
is executed by entering normal poweroff or Partial-IO instead. The
decision is made by checking if wakeup is enabled on all devices that
may wake up the SoC from Partial-IO.

The possible wakeup devices are found by checking which devices
reference a "Partial-IO" system state in the list of wakeup-source
system states. Only devices that are actually enabled by the user will
be considered as an active wakeup source. If none of the wakeup sources
is enabled the system will do a normal poweroff. If at least one wakeup
source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
message from the sys_off handler. Sending this message will result in an
immediate shutdown of the system. No execution is expected after this
point. The code will wait for 5s and do an emergency_restart afterwards
if Partial-IO wasn't entered at that point.

A short documentation about Partial-IO can be found in section 6.2.4.5
of the TRM at
  https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4db84a92a517b0aa7bb8d47e809d9848a16e2cc4..f2922fccfbe748a436cb9aa0a8c8e5f48db02ef9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -6,6 +6,7 @@
  *	Nishanth Menon
  */
 
+#include "linux/dev_printk.h"
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/bitmap.h>
@@ -3663,6 +3664,116 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
 
+/*
+ * Enter Partial-IO, which disables everything including DDR with only a small
+ * logic being active for wakeup.
+ */
+static int ti_sci_enter_partial_io(struct ti_sci_info *info)
+{
+	struct ti_sci_msg_req_prepare_sleep *req;
+	struct ti_sci_xfer *xfer;
+	struct device *dev = info->dev;
+	int ret = 0;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
+				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
+				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+
+	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
+	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
+	req->ctx_lo = 0;
+	req->ctx_hi = 0;
+	req->debug_flags = 0;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
+/*
+ * Iterate all device nodes that have a wakeup-source property and check if one
+ * of the possible phandles points to a Partial-IO system state. If it
+ * does resolve the device node to an actual device and check if wakeup is
+ * enabled.
+ */
+static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
+{
+	struct device_node *wakeup_node = NULL;
+
+	for_each_node_with_property(wakeup_node, "wakeup-source") {
+		struct of_phandle_iterator it;
+		int err;
+
+		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) {
+			struct platform_device *pdev;
+			bool may_wakeup;
+
+			/*
+			 * Continue if idle-state-name is not off-wake. Return
+			 * value is the index of the string which should be 0 if
+			 * off-wake is present.
+			 */
+			if (of_property_match_string(it.node, "idle-state-name", "off-wake"))
+				continue;
+
+			pdev = of_find_device_by_node(wakeup_node);
+			if (!pdev)
+				continue;
+
+			may_wakeup = device_may_wakeup(&pdev->dev);
+			put_device(&pdev->dev);
+
+			if (may_wakeup) {
+				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
+					wakeup_node);
+				of_node_put(it.node);
+				of_node_put(wakeup_node);
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static int ti_sci_sys_off_handler(struct sys_off_data *data)
+{
+	struct ti_sci_info *info = data->cb_data;
+	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
+	int ret;
+
+	if (!enter_partial_io)
+		return NOTIFY_DONE;
+
+	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
+
+	ret = ti_sci_enter_partial_io(info);
+
+	if (ret) {
+		dev_err(info->dev,
+			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
+			ERR_PTR(ret));
+		emergency_restart();
+	}
+
+	mdelay(5000);
+	emergency_restart();
+
+	return NOTIFY_DONE;
+}
+
 static int tisci_reboot_handler(struct sys_off_data *data)
 {
 	struct ti_sci_info *info = data->cb_data;
@@ -3941,6 +4052,19 @@ static int ti_sci_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (info->fw_caps & MSG_FLAG_CAPS_LPM_PARTIAL_IO) {
+		ret = devm_register_sys_off_handler(dev,
+						    SYS_OFF_MODE_POWER_OFF,
+						    SYS_OFF_PRIO_FIRMWARE,
+						    ti_sci_sys_off_handler,
+						    info);
+		if (ret) {
+			dev_err(dev, "Failed to register sys_off_handler %pe\n",
+				ERR_PTR(ret));
+			goto out;
+		}
+	}
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -3950,7 +4074,13 @@ static int ti_sci_probe(struct platform_device *pdev)
 	list_add_tail(&info->node, &ti_sci_list);
 	mutex_unlock(&ti_sci_list_mutex);
 
-	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "platform_populate failed %pe\n", ERR_PTR(ret));
+		goto out;
+	}
+	return 0;
+
 out:
 	if (!IS_ERR(info->chan_tx))
 		mbox_free_channel(info->chan_tx);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 701c416b2e78f8ef20ce6741a88ffa6fd4853b2d..09eaea54dd5cabce72dd1652c9603e3ab446b60c 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -595,6 +595,11 @@ struct ti_sci_msg_resp_get_clock_freq {
 struct ti_sci_msg_req_prepare_sleep {
 	struct ti_sci_msg_hdr	hdr;
 
+/*
+ * When sending prepare_sleep with MODE_PARTIAL_IO no response will be sent,
+ * no further steps are required.
+ */
+#define TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO				0x03
 #define TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED				0xfd
 	u8			mode;
 	u32			ctx_lo;

-- 
2.51.0


