Return-Path: <linux-kernel+bounces-846102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69404BC70A6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5893A4E4D7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC919004A;
	Thu,  9 Oct 2025 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23iLFegt"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54814F9FB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759971803; cv=none; b=sibEkn89jLma39zzo/2oYHQnv7k695sE+yTM5gyj9/uEaNpNiACUJTLmQp1QiJo9eUDyAQhp8DTC5T9hZA8rADI1s3G0yXluPICpLXIOhJTu0t0hvSAwr7M8STjpOtDKxoqSa6kYRcq45wIm0+Xqdhzqj/+kzjR+mM6l3z7z6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759971803; c=relaxed/simple;
	bh=tSONzkd/O/+rs+POwDj3o16Z3uPD6VSUJul2FCsIGzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sahuib5VsJbB9XU+iju8MmY/SQ/Jo3vbqMg8ClkkK73zsRueW5z8k6H/RuS3OL6HTTxuLSOUYtDRC/SjL29nlbUvrzArc2rDJ1Ia26ackGoOznVeFzgsRvbzofdY64FkRPHVHF8fmg1sUtrAKaIKtU2p+v9xPipRd23czyhuERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23iLFegt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so506657a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759971801; x=1760576601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g/4YIFu4sS9h/R2pTNo5KqxfeVEIXuxRpdzIrSZfq5Y=;
        b=23iLFegtmjncrs/yt3YWctcS4S6Fxu2d3wNSec/GEUgIKs2nNclPm/93Noi5a4cNNG
         BwNI4E0uqbE2Y6PflMFVZFrxzx0IIeh2n3eIZ9cPK7CTCaCVaoBA9imisaJN+sNkhQzj
         dkr2C0pSOTyGBmJrS5ZBcFWjRc9ZgoHP23znpM9lVIpFhWUYKu7ePrjL/CsioA6v0KsU
         8TsjavBec8yivNWlBh+VvH6HIfKxpHnwizo/iqVLdqXo1SCxrvla8Cb4YyIDpWs1e+Go
         UVZS43X0qFr74MRcudWmZUePCe5okhcGit0FDGhZlPO9bGigfFnZTVQ7JWu5EB22KdJ+
         XNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759971801; x=1760576601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/4YIFu4sS9h/R2pTNo5KqxfeVEIXuxRpdzIrSZfq5Y=;
        b=NacGsL/DW2vmKryg/i9CXmZarrm75SSeCppPN9ajMhtbNESwFL02wS/8iNrPSCpRqT
         X4aXxyN/j5bL/LfdAr4gUjfscgcck0uhNu0AjWpkpcsxZTUeAPtk+ez0B5fAs0O/qdgR
         4c2uacnEkVI45Ba/bxLf/XONYgw1j7/xxi9qLvMuJyfk4EDSDo+39nYz66Q9XVKxOESq
         yhuGmiLk42Uy+BmuIyZhfLdWyeZ9ATj9YFEE6/f9FOfVqly4y653V+pvgnwu6eZc4/SE
         Mzcc38IBTyiQIIcAY8FQpGX/QClXxpFDtqcZpbxaW5uXS28aOY3oC8wnpAZk79Rt3odl
         qftQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjjboneANhSG76gyelE8+vmKT9V8Vl0e1kmVNS+Tt0oVzw1MmfEYaJ451nobQlpJZdUGm+L8ycFZMK3E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAlaToVvvxgJR5zZKYcmWv6rGMKsR3K9mwgATZAPmCY/XJrgu
	Mc66eotSnHtW9mveAKL9xdz8MSmR2Du4n27IibV5YpboBl8HoavExiAehto+JDU5JUHzzb+HVoC
	spy4mjg==
X-Google-Smtp-Source: AGHT+IHp9lhngu8Gcn0L1T1mTc3AnO+MfrO5+f6Ss5kpMxPs3s4Tw2S+ucM0AiCl634GfbIg65sr8/46cQg=
X-Received: from pjbbt21.prod.google.com ([2002:a17:90a:f015:b0:32e:a3c3:df27])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0a:b0:334:cb89:bde6
 with SMTP id 98e67ed59e1d1-33b51105dcemr6509867a91.4.1759971800738; Wed, 08
 Oct 2025 18:03:20 -0700 (PDT)
Date: Thu,  9 Oct 2025 01:03:07 +0000
In-Reply-To: <20251009010312.2203812-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251009010312.2203812-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251009010312.2203812-3-jthies@google.com>
Subject: [PATCH v3 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
index eed2a7d0ebc6..62b80ad85a68 100644
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
@@ -235,7 +237,6 @@ static void cros_ucsi_destroy(struct cros_ucsi_data *udata)
 static int cros_ucsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct cros_ec_dev *ec_data = dev_get_drvdata(dev->parent);
 	struct cros_ucsi_data *udata;
 	int ret;
 
@@ -244,8 +245,11 @@ static int cros_ucsi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	udata->dev = dev;
+	if (is_acpi_device_node(dev->fwnode) || is_of_node(dev->fwnode))
+		udata->ec = dev_get_drvdata(dev->parent);
+	else
+		udata->ec = ((struct cros_ec_dev *)dev_get_drvdata(dev->parent))->ec_dev;
 
-	udata->ec = ec_data->ec_dev;
 	if (!udata->ec)
 		return dev_err_probe(dev, -ENODEV, "couldn't find parent EC device\n");
 
@@ -326,10 +330,24 @@ static const struct platform_device_id cros_ucsi_id[] = {
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
2.51.0.710.ga91ca5db03-goog


