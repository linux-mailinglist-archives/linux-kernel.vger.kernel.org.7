Return-Path: <linux-kernel+bounces-877893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20222C1F482
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09D914E9900
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE32342C95;
	Thu, 30 Oct 2025 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q/XGFwAV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21A33EAE3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816428; cv=none; b=uB8bjXZSVDwbDa2kO0r1weONsPRVHMHfMpTRLRMarN8B226W5ThMGlfUPbxIpLi8r2LziOj+jM+9lPTj6saGgSxuoEqRDSOPq4neoRUNe54UfgfxDC04glPXRd61DzqevJlNUiY3LyNXNhhRHk0SKiJK/KyzpWu30iK2HAdgr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816428; c=relaxed/simple;
	bh=26F0Bvu56G754C2jeroEex8fImMoz0+Y7BY0qxomFcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3R5TZHmt0na3NPUjlUkuvF93X0/RKVPJDxZxt0NvYdc8bBUonbh99cp/JNX4wTVYdUAyVlf4Q96TtO2E85ixNxMbbT9SLF4cfLI7x1f7mf2smQ6DwEf4u24UrrRPkmeFxHqvLWYVoaIQs61T0otyizD1xVgWCnjKLmm4n6ZTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q/XGFwAV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47710acf715so4144255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761816424; x=1762421224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJU/7pOy6k5Otq6sscIBJ2rwBspnn6iIa72yddH68yU=;
        b=q/XGFwAVSheVbui53IHDUS4ePMMwFdglHYj/04KlgOjzY2Ga5NEbi7Lh+8MPnQ3AFY
         jaNLobCYijonQy3UMGensxysdSvp+f6ohL2u+CoPUDQHHPlEhn63reiTa9lGtuF9AOWd
         rp/+mM15gx8cCm1aS/9Kl79ZLa8BUQ1KRpUWiGhkvk4EXJoqNKpDGTxWwgN3dJxfubBU
         qHthqgISKqwhRF2Wvy3sjvNEUb92PE8kQOCKCYl3yTqp1NUooxSVT/cEVKnevWXyze3f
         VNYIV5hNkEVmn3TtqHRCirlNo8ObV9wmSJqkMsNrjmdG5Ic2V0K987KGWy2MBgeT3H1t
         ykZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816424; x=1762421224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJU/7pOy6k5Otq6sscIBJ2rwBspnn6iIa72yddH68yU=;
        b=L029NYzPj4nKJkJrlM40P8q0UOLLjj4VJBIhsqlYpArMeHA7WPFjuc0C95ShosKWjm
         1gevY4kRJG7qDw+R7mQeEbz4l0xFwUcwxt5Ir900iBGE/ZDVl2xnK7ZBYQEvdNY5lbjr
         Zi3DYni/D3TOPCyCbECgVErE78djLElMZb5nurmQCDN/f1bYkgyOepIHjfNi/pbaljdW
         jtdNCRRoq6Up7gRuh9jZ9eEijw2DArO5WRJ8UmxYqXKJAg4EPa/mWkUxrh5QYclp1SvJ
         08j6mB2bzd7C91Hel3q8TejzRaSGXsh1Lvo20EqE6/jls3H7+F9tQf7I023py93KoBNs
         zqDg==
X-Forwarded-Encrypted: i=1; AJvYcCWH51XmL05TDRUebOS3KCnkqktAOyJu9mGye91zjeutKNnl3UizZaFT178qsWimHYlDlTUNhOhYBKgQlxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtRwT6oKV0AxFb0CjOi213CPEtYd2psEXLYalwtMSOqmCSdsut
	KjAQxAE3T+wkETtIiOOrs//zjqdhRQ+xgw6GGQXkHjTa9FqAsC9cfj8VC3sm0daGDRY=
X-Gm-Gg: ASbGncuDoNQnbSBCeXuvbVLxln0KyDKaqAsz41psbOxgHFbOTQ7Mbz/1nr3uWklE9ku
	AiSSjeNRT7LvRU3PCPWfU7U9pxQZ2RLi+2TfTgdyf6vYNM18WrA+TT9enLJW+QX9EcYAntlJ4Jk
	iEJEtln3ScaK80NGIdOpowvHy2sc0uKJHbJtAvBxGGrOHUsoKviY/Im9cwdaYXR4kBZ5oWO/qj6
	2i8W+3wTij10CFeS9/fM/FOpFjzrCqPF47eC5vU7xgJeqXPc+ew4t6dw6t9onnSeRz31Ft2xidz
	rGAUYt0LiwAVhco/2/HI4PuN0AxAKAq2nsCbUwNQR52rzv6HYK17W5xGwPNUXEhXz6QqXhKJRtS
	R61paEMv3fvbWrNVuzMgJxs34X0fsjk+wmIegQdsWGpTBIUaiOBaVb7+cjYSvJPXkLlUHHUEKpA
	==
X-Google-Smtp-Source: AGHT+IGiKMp7FmmJWvCzcPKsR4nFMCkOPRvUXCQdoKXYcyEIZ/3Nl23pSGaG1drR1Wm1x82x0LhDRQ==
X-Received: by 2002:a05:600c:6303:b0:46e:4329:a4d1 with SMTP id 5b1f17b1804b1-4772675fffdmr19910835e9.4.1761816424323;
        Thu, 30 Oct 2025 02:27:04 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952b79cbsm31002262f8f.4.2025.10.30.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:27:03 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:26:10 +0100
Subject: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
In-Reply-To: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmfR/5LunG1oM/Zvep7WJM4vz1fIqe7/y9kefYt956N
 FNosdrcjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjI/m6Gf8Y/D854mCh9wMBS
 NOW4C+e5u6Km5uEtPfl8L5t7FsQ0BTMydMRfOZx8Pm5NlLbHIk/VQ4L6C8+vzzcOO2P5+oX7h6M
 r2QA=
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


