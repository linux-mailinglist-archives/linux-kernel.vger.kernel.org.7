Return-Path: <linux-kernel+bounces-839438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DEABB19DA
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D5C2A7CA5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18482FBE13;
	Wed,  1 Oct 2025 19:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7QMDq7q"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54A2F0666
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347242; cv=none; b=NzUZvlg+CHM8dDb6HEt7h3YIDNwm8BY1MAzqgst20Uo+N2Eyv1a5mc7KZxZ6fpPBX4gnit4QUc8PLyeK8kfIWujRc+549iaLi2QkpkAWvhhuZwrUckfdmo7jRwpqOI5qyTz9AmdLvvobd1PtJ5DokUDQctLk48mywV0BZMnOtKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347242; c=relaxed/simple;
	bh=Re7GUviQQ/McZMZXcizPzU9VQkGIF/9Gqs/MVdCmSq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gSXTH3LCKGEYhAUm1Mxm8ejL0y7GVEGXnWnEtk3zLJVRdUpfbREkl88AHCPdOhgT/3bs2fCifVoPSm0P+JlDh/2IOQW4Ynbc40CIT+gTECHVarEMwWZ8x9FfvfEA2+8u1Yj5jAHucvAeGApH/r6v67kjtW/LRtYJMRu8we0zStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7QMDq7q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b5533921eb2so139412a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759347240; x=1759952040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab9LbOojENiRCLzu2+LM4yAW/ppnt27Oi1gZ0mzkbeM=;
        b=X7QMDq7qsB0Mjqacfk2ssPAEIMSxEi65WKNktAXYu7j6hXe+5pPdPBUi18iJxy3HSm
         YO8ztCkct0lGueS6R3IAqrrjKrQpk5iNcykoR0YtmUIKurIIF1nMsoBjej3EFsWTDFud
         jf1UMiKpPybosXoQfyu3hsb90iZKWLFuVraac0aC2cpzKJdtMWzqZDTFc6+7QKd5qS8g
         1gOr7eSpubS3JEqdtnyQ2QnE2b+7TbPUX38OBtYL9bSwdGdewTI4U91FjIul+iPEbJ6G
         C40eEFxc0S0Qu4z6Y2OYGYAh1ru9qQ8hNDKWrfFVdcYziSiUT3mxQxqp4CTQ1bgz5Hkr
         z19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347240; x=1759952040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab9LbOojENiRCLzu2+LM4yAW/ppnt27Oi1gZ0mzkbeM=;
        b=ci/EK2WxTXo8YixBQNWbKDx1/0NWSJ4mcbEKh5W4oyxqfRUNVNadxWu4mztudeU3Vl
         21KD64DmtKpiHXK6yXKdqCoLz/JUlFkE/KjbWxZZ9+SWb677n50Zcoo3Ng8Jar3GGXm7
         t064bwVNgeX0yu+sOPINmS0yjqawJZ8iFRz9QtiAPh5YG7KDacSsaiC1U9sjqHu4HRRp
         ljIeqhNmUu/3NxnxrSSDmBOM3wyprAXa7HAcEYO9yR0+XI2fF15nzf9upt3vxj95Jwsa
         HAE2lPfwWQE6Vi75cDe9PogTc0lJIEGuQVJ9AUTp7ggbQX4l6SOdsul/a8WZx2bO8rsi
         PIpw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Xua4Q3585U2Nf7OXbAh4kmwrK85HHWJvodTL8BmdKnxLXK07yyzBgnI4gv7FlzFMzNQ89DYPPq2u5PU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy18RCqPWKTGqNOM7YauYalRTrvWNiPgilEuwzAxgSW5X5DQTWV
	cjqox6MFH3qvSVeZQQnjZNoZJAyqsb6cQe4g9VFMMBGDsddyRqje0iXviMtlN/leEuq+XV9sOeB
	MWlYl7Q==
X-Google-Smtp-Source: AGHT+IHpeChB7wBWGbIToLlpa6Wkhfvaeaky3iS+MzUWr5j+7Q7cE+k6HmDkvIJbqJHBJhco83UQXyJFy4c=
X-Received: from plpc16.prod.google.com ([2002:a17:903:1b50:b0:28e:8363:fb93])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70b:b0:26a:589b:cf11
 with SMTP id d9443c01a7336-28e7f315a95mr52240345ad.43.1759347239903; Wed, 01
 Oct 2025 12:33:59 -0700 (PDT)
Date: Wed,  1 Oct 2025 19:33:42 +0000
In-Reply-To: <20251001193346.1724998-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001193346.1724998-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001193346.1724998-3-jthies@google.com>
Subject: [PATCH v2 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
From: Jameson Thies <jthies@google.com>
To: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com, 
	ukaszb@chromium.org, tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for cros_ec_ucsi to load based on "google,cros-ec-ucsi"
compatible devices and "GOOG0021" ACPI nodes.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
index eed2a7d0ebc6..3d19560bbaa7 100644
--- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
+++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
@@ -5,11 +5,13 @@
  * Copyright 2024 Google LLC.
  */
 
+#include <linux/acpi.h>
 #include <linux/container_of.h>
 #include <linux/dev_printk.h>
 #include <linux/jiffies.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -235,7 +237,7 @@ static void cros_ucsi_destroy(struct cros_ucsi_data *udata)
 static int cros_ucsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct cros_ec_dev *ec_data = dev_get_drvdata(dev->parent);
+	struct cros_ec_dev *ec_data;
 	struct cros_ucsi_data *udata;
 	int ret;
 
@@ -244,8 +246,13 @@ static int cros_ucsi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	udata->dev = dev;
+	if (is_acpi_device_node(dev->fwnode) || is_of_node(dev->fwnode)) {
+		udata->ec = dev_get_drvdata(pdev->dev.parent);
+	} else {
+		ec_data = dev_get_drvdata(dev->parent);
+		udata->ec = ec_data->ec_dev;
+	}
 
-	udata->ec = ec_data->ec_dev;
 	if (!udata->ec)
 		return dev_err_probe(dev, -ENODEV, "couldn't find parent EC device\n");
 
@@ -326,10 +333,24 @@ static const struct platform_device_id cros_ucsi_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, cros_ucsi_id);
 
+static const struct acpi_device_id cros_ec_ucsi_acpi_device_ids[] = {
+	{ "GOOG0021", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_ucsi_acpi_device_ids);
+
+static const struct of_device_id cros_ucsi_of_match[] = {
+	{ .compatible = "google,cros-ec-ucsi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cros_ucsi_of_match);
+
 static struct platform_driver cros_ucsi_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.pm = &cros_ucsi_pm_ops,
+		.acpi_match_table = cros_ec_ucsi_acpi_device_ids,
+		.of_match_table = cros_ucsi_of_match,
 	},
 	.id_table = cros_ucsi_id,
 	.probe = cros_ucsi_probe,
-- 
2.51.0.618.g983fd99d29-goog


