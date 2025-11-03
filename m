Return-Path: <linux-kernel+bounces-882899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B558C2BD3F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618924F8BF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1842A30C63C;
	Mon,  3 Nov 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mFZTLWae"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696A308F33
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173768; cv=none; b=UOGM2sx7OUxcHxGzROhDKrfypwdOG6LqLObLEqc42wiN9e2fawHZPwFZW3Wy0PO+lIcR8qq7Sl1AZKne6NIhW1PdtRVgf7/ZEKYRHWNuRHKS/mwdFakeyLcDlEI7BSY1/Jh6n92vStgMyE72OatGh6GQpTXWTykFYmV/eBtjqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173768; c=relaxed/simple;
	bh=3nTf+/ss8Vb1phICCN/rX1fk5ehJsdJVA3tLrFZB+zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6gocOAzZidHRH7LnMtv+j8XHpykrHWlOBJNdV2eCYHo8/spPR9WmS4YcIAMJ8pLjfLf561gIKSx0fLVUTNFoMIWMJBVeBgH7MBVwK5gnei2490cTwKW2O4Zoa+DdBjLaPKFIRk/jKyhXNCsZjOrVsW4fOBAJhHa/HHRypJwecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mFZTLWae; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bdfd73e6eso10130547a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762173764; x=1762778564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+/t9bteFAoRNa+cQTzNOtIizDYHm0AvKyEZOiZN2Yo=;
        b=mFZTLWaeASw94HUsRKaHFP1S5fPxai9bP9KG7YJJUyJhe+R+B9C3TH1SQT1UWGSElE
         G02HijpTBNWrTcdx+OE7GZYkWE8wAdXAFi+cJgYlZlzu5LKLpiQ0vSTal4DOjiFORfyT
         gk+TftrsrElxexu4oSag/1Imyz4bbDgVybB1RGVy2mZF7zd7ZhW47FziuJFQb/XtZbRW
         YsAnB3ECLJF4JvqW9OEtKiA4GqEYZmk7f3AC+1NjJtnprVeYHlJnzFXMq2cOzRbmhZ90
         tO1//ldvjeBFG8XctdDnKNwks1E+ez0F9kf47hOtHWsjhb1QFiKJReLKg3sjwLMgaeAS
         qqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762173764; x=1762778564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+/t9bteFAoRNa+cQTzNOtIizDYHm0AvKyEZOiZN2Yo=;
        b=gWtOZBdJWbpxkkiuViYCt+8WL2yQPW04A2uX7auCQoRagZMBYSMwi+jxqQdUlkvC7Q
         hUst8AstYPINpkUqj2OLaUv4gfv5hgCv+WHYeJ9cQYZwuRYbz5hbu+jM1TqqWi39TKoi
         3mgBqJBnYrL4yVBaSnw0vMVQnvj2t4z+AFulQxSipR06i5G09gTCz+5gcwEH0P7sMkQ1
         a0G0acJu5BHRLuig3m3tb/fzQmuPmfr06CxvY0N1Uz/DLglJnvYgE/7LDHnpIYjvLefW
         E//7g09MoK2G6z+Lwvf45qyNInp6B0cJOERxswU7S1PeJqCz4+A0PuNmgBt30xWyrTJT
         KDCA==
X-Forwarded-Encrypted: i=1; AJvYcCUdcztJzVU28POs7XbO3RdZgWCqJ+aCR2YVjaoaN/IpfFaB1JoqwIBb+I1qyCGYsF215ndGjDmin/pD5z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIndZHVvKG1qJBKs0ASvchUdF890KWehEDW+l2uk14UEvERCcg
	J4I6e+uNoIVqm3PEz/3pXsyipl5HWSasPaOfWwmj17O8lWhrd53cuSl7v0yYz7yauZg=
X-Gm-Gg: ASbGnctZKCE3YDbUW3h3XVIcc+vCaO3dpwUneaiinQFymtp0rz58ZZZiyJjLo3e6RbF
	DrThskW13hr0sJNVUGmpbEPgBN7ieRXnqSJa50lhrTbnhh+FzV5xJTU/Hl0LmLg/w8LMpmvFT0P
	f6P/7GP6vEzYEaJzUqrOAUE9cI2AcAut/6Zqov9tSGpvsKCPUEpBNvTQ9EfsiW6F44SV6TnZAXS
	w9xW2IfdrAe5dyePC31+PnhiJQWIEXbeaMVmrrVExdxYDSG9P289ba0WGNjvq21SnEvfAeinecL
	Pc+OM+G76q3JVRCCTpX7mh1QrihWcLDOaVyXkHFWe2RP1cd/9CUakqO+g0/c+eZ6g8aKu7q12l8
	cZT1QKLs3X6wdsmADrRvIC3CwH1vxQxew9t007cnzW6qlowHyHsd+WLZ3L/UkWQkAGTEOi9y2oA
	iLnzA66g==
X-Google-Smtp-Source: AGHT+IFIHqwLMhjGscMYSAijor0+3yh5hRoO0Raw0QVXNoSscDyDDbST6mC5uISlP4ngwkAwYv6teg==
X-Received: by 2002:a17:907:9707:b0:b3c:5f99:dac7 with SMTP id a640c23a62f3a-b706e54eabfmr1302167766b.21.1762173764075;
        Mon, 03 Nov 2025 04:42:44 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b70acf84c51sm510327066b.30.2025.11.03.04.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:42:43 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 03 Nov 2025 13:42:20 +0100
Subject: [PATCH v10 2/3] firmware: ti_sci: Partial-IO support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-topic-am62-partialio-v6-12-b4-v10-2-0557e858d747@baylibre.com>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
In-Reply-To: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7313; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3nTf+/ss8Vb1phICCN/rX1fk5ehJsdJVA3tLrFZB+zQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkyOxaZpaTeDLddf+spvW/3j+orOe8slzeqzCj/0xrB9m
 MKw/U9ARykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEykT4WR4axrzwFtDSZNw/xn
 1b0bIw8d474xd2f+x602rPGWWU+W5TH8D/oaNmOf/bIZp5XjTz3y9v6t/Ld7U8amrs+Gm0SyWeY
 asAEA
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
 drivers/firmware/ti_sci.c | 109 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/firmware/ti_sci.h |   5 +++
 2 files changed, 107 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2585cb82d1ad8e3d79bca458a2b86cc81a3e627b..811507ded63ac784ad6c6ad77b2f827768f3f3c7 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1673,6 +1673,9 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
 static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
 {
+	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
+			TI_SCI_FLAG_REQ_GENERIC_NORESPONSE :
+			TI_SCI_FLAG_REQ_ACK_ON_PROCESSED;
 	struct ti_sci_info *info;
 	struct ti_sci_msg_req_prepare_sleep *req;
 	struct ti_sci_msg_hdr *resp;
@@ -1689,7 +1692,7 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 	dev = info->dev;
 
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
-				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   msg_flags,
 				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
@@ -1709,11 +1712,12 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
 		goto fail;
 	}
 
-	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
-
-	if (!ti_sci_is_response_ack(resp)) {
-		dev_err(dev, "Failed to prepare sleep\n");
-		ret = -ENODEV;
+	if (msg_flags == TI_SCI_FLAG_REQ_ACK_ON_PROCESSED) {
+		resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+		if (!ti_sci_is_response_ack(resp)) {
+			dev_err(dev, "Failed to prepare sleep\n");
+			ret = -ENODEV;
+		}
 	}
 
 fail:
@@ -3667,6 +3671,78 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
 
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
+	const struct ti_sci_handle *handle = &info->handle;
+	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
+	int ret;
+
+	if (!enter_partial_io)
+		return NOTIFY_DONE;
+
+	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
+
+	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO, 0, 0, 0);
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
@@ -3946,6 +4022,19 @@ static int ti_sci_probe(struct platform_device *pdev)
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
@@ -3955,7 +4044,13 @@ static int ti_sci_probe(struct platform_device *pdev)
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


