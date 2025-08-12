Return-Path: <linux-kernel+bounces-764434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386EB22304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFC172328
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4092EA721;
	Tue, 12 Aug 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vin7QPZt"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AB2E8E13
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990421; cv=none; b=ZvxfbfZqnUlWklSQQxE9GGwYIXMD0aRK3OgyXOnvdMaYJxQIyudd3sq3TX76SJsdfLoe0ircEt+aUdVn5t4GU3H+ju3XmFGQOlSIhmTtGISyWIIUyIMQ6LKxhYk2c2NRD9Ds7y3rZK7gdtLExmH46w5MoM/gV5JAk+WKEsJw/9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990421; c=relaxed/simple;
	bh=CbzzAmP8/LO6r8tSC7sWQSxfvx2aA7gDFVK/fKBIvbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkInlZPmW9aBn/XDd35I3inAg27M4CLs35IUuHjSqDQQcYON9JsgsuuZe8nrcNYDgIw7g3Gd73SH8BXCcfWJwgh0KYi5cNlf0cR6fBHPpKrKW2wVx3/kpPmot36zvkNIVLbhBcZP4+ivroK1UPgJ4gjgZotKm+GyrlKcqUKypeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vin7QPZt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso7847243a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754990416; x=1755595216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bs1SP51KioxwpFXq0E6v21nkJ3BmZQZeWMYcveEiXdk=;
        b=Vin7QPZtylJZ1XxkTogOoXqbtVngBKexAyPgUisFInyc/RINg9CF5gsebqAVxPVmdl
         Wz3Bcdy+75ikiRRHhrkZwJrgD76Lk/eX99lvbdDu4PHS3bA97oOop09/qdeQy+K657tk
         /Q7lP6OqnNl1Mb8uhB+q3OTYMyYu6osLg9JhFQZQ5thTHqWpb4F++XdFf8oRyeOiZrZU
         DkDWlrCzobExE5Ebo9T1fXYktlZvK+grXDlSwERQ4H66fkyExp1hjuOEpaAeYPJ+74uv
         /gJMSxQ+op5XWkkKELtgMQjz1u+8mIWxITTGraGKsu2zOXQFb1YnMa5LQlhS8p/iMLT5
         SQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990416; x=1755595216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs1SP51KioxwpFXq0E6v21nkJ3BmZQZeWMYcveEiXdk=;
        b=clOI/bUHDLq9dwnpkAWWe2B5d6CMbJ4mRow46uBgO5VdZsdKzttPm5MqHcmVdqFliC
         ceezGkAZYIEjagV3pfk6Rf+z9bnXTfhl661m6urRc6YF6SjLlWTMzlVCXd7HYpzKzFx6
         zgxsclR0I8quTPEOQXxRP41/FHey3JY3p3w7fRSAbb8rGlxVvHm7kofpoXACB6tXuhOG
         0UTaBumtyB8xqO5YG0nexqmaPHPEEWtzyBCyCygZolZTAkVnh48yMJt8N1TC8btw11HN
         wvzSSk2YgUV9fI4Sdzrc8aVPCSsI2kZKi90tvtRyFlcUAiyt/BUEt7UUPdVGO+zmTCfX
         e75g==
X-Forwarded-Encrypted: i=1; AJvYcCUiQUZGgSniDC5L1ceGZGeKatP3s39g4kouyelPfuGKed8loSOG+75apq6lbgNqYWehLmVJQEFKod8nomY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNV7bBKzDm9maZPDY5qKVTyrNEsrcuhklL0s2ecVTkI2uwF4Q
	s6d/7PLitNJFf7myg+SWM1ASPksXaD7gU/H9JybRr2hAPOL0Ek/lqroOLpeRWk5U678=
X-Gm-Gg: ASbGncu30deew22R/HfE7NdK8yKTO4SNjJSBpIVQzrmktUtH4yQJUfPEKTrPsZPFCfT
	oaF+Cmx5U2aVOJx720LuyalyMqWosTWjP19nEkvuDYnC+XLWn7Uw8UhxE4L562CPxouWft128mc
	XWC6jo6KCD/TgyRwPs371shPDTLjjllBFhFnJk1CTIS8T/vRWSA9FIxn4zx236FeknFna5wJSVx
	RB9DG9Bmn7dU2PwBGGu2DEiIprfrJURtzcbns+ASXVTljii6I6VnPxGn723WH4OjKY1EAocZ2xb
	XvCZ+W4tmMGH6Cj4UFWySjicpJPDK1dspQ22eOdImdUl9g+3LeD6AQc7FOE2yQ+tJaOobKCYWql
	2iKzfpt31BOri2mXoig==
X-Google-Smtp-Source: AGHT+IGVGPmsAHT5sVpRUb2RNBxpNpsTSK02TiTZkCzc5O4CNPBG0bmI7BZgtMYhiG6O3Ki5lv3Liw==
X-Received: by 2002:a05:6402:430c:b0:618:4044:67a7 with SMTP id 4fb4d7f45d1cf-6184ea20e98mr2039588a12.5.1754990415955;
        Tue, 12 Aug 2025 02:20:15 -0700 (PDT)
Received: from localhost ([2001:4090:a244:8691:4b7a:7bbd:bac:c56e])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-615a8f25739sm20175496a12.21.2025.08.12.02.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:20:15 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 12 Aug 2025 11:19:48 +0200
Subject: [PATCH v7 2/2] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-topic-am62-partialio-v6-12-b4-v7-2-ac10865c2d87@baylibre.com>
References: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
In-Reply-To: <20250812-topic-am62-partialio-v6-12-b4-v7-0-ac10865c2d87@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6767; i=msp@baylibre.com;
 h=from:subject:message-id; bh=CbzzAmP8/LO6r8tSC7sWQSxfvx2aA7gDFVK/fKBIvbk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhozZ7O6hzLcDlUulvZUcxWft/P+7y7FLej5j1fx/e8OnK
 e5q3KTbUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABPJecDwP/dsfFFhzO/IUw8O
 1PzYtlaN4f0B7eAZaQ7nzR811XcaTmP4p8nzZRqvR3WkRtGGj+/iRRNnP2g5vNy92CDh0DW7fWt
 W8wIA
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

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c | 131 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/firmware/ti_sci.h |   5 ++
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index c187fb714b3a4c658d0593c844716d4b160e4fa9..fb6f3d7f7413917cf9534ba65f0a9786d1183c71 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3750,6 +3750,116 @@ static const struct dev_pm_ops ti_sci_pm_ops = {
 #endif
 };
 
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
+	dev_info(dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
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
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.default_host_id = 2,
@@ -3893,6 +4003,19 @@ static int ti_sci_probe(struct platform_device *pdev)
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
@@ -3902,7 +4025,13 @@ static int ti_sci_probe(struct platform_device *pdev)
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
index 053387d7baa064498e6a208daa7f70040ef87281..006a3d40ba040f12d0b2dff7fce49b4eefa52517 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -592,6 +592,11 @@ struct ti_sci_msg_resp_get_clock_freq {
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
2.50.1


