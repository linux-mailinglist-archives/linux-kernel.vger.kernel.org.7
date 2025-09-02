Return-Path: <linux-kernel+bounces-796813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9483DB40773
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0093B413C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA531CA61;
	Tue,  2 Sep 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GpjeFl/v"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AED3126B8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756824238; cv=none; b=qJMj72FPDD90/mWM5RHopY+j8B+M3xFyDncfD5y/8sSCXJ2paoU98QPxp7ZrWUQ3xQO+/8AxO7ROYp7aOYpn3Y+FjW1eSrmWGhZwFT+QhcFW60L01JQuRgec7pAlUNgZWxdMmfL+UKOxOj/6qQqVDPtnBWUBCziVnPCIlRD+L/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756824238; c=relaxed/simple;
	bh=HcQchtRslDyRXYgw4RtewbOf6/LJsYueNE8Laf4FCKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/EmFLPtmQ5RMtkXS0UR/BdjIjDehucpUpbjCAmDdLSK9tOMuMUlo7myJOmoZFW1vF0NpNQm+EAQ0dp4KWejnIi3Ar3veUNhsUaS9SLPuv7ej3X9TflbuSQ5ItLhQp41uUZfRPup9XWWr88qoWsYU+rJpiUyzR1Ii7caOwa2ijM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GpjeFl/v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8b7ac427so14387255e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756824234; x=1757429034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH9KVtMgBsrkYXH8nnFecmz5YKaJj3+GxgiEXc+y1YA=;
        b=GpjeFl/vTUDELKh06rwoJmtkj2VnNfzEjcmCd6InQq3Hqvln1JQi6z9wRyiuMW1Dde
         YGKIWQfIp2iFQGlJA5a0XYCETTEIJ91ADzRyvnU38M5/VZ2SbhuUwYld3vWPLbszLHZY
         CRqLYkNkFKDE1lsdudak9xlU86jgXMawusFBmqrTqjZaRmwRzbiSGSVVNZbRHJ/G1tUB
         Bhgi/ulvjEJE2wPwuxqNJvjBels2vulXESSNBGr3TA5LFTXui4YZPv7HIkh8c0IOqGxF
         ghvlpii2+GB+A2VNjnzLJmM+MIt+9vq40BLJcr2HprOjxIKY6SXNks2YciZPpdXWFrto
         KWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756824234; x=1757429034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH9KVtMgBsrkYXH8nnFecmz5YKaJj3+GxgiEXc+y1YA=;
        b=fsq6GI5ux3ynYQ5dHHw8g6NJWJIl8ITeOuwtDzY5RMWOkjsnvmkxxyhzrG+irJPvE9
         nHDrQAtFka12VxV5nZ7XPsutsjSVIe8S6HNGgZqHhaLdOzn3IXMNyUX+emnVFn9Mu+sO
         3LE7cr6KA7NxvyIFiuAdY28ECgq4r4D56zkJEeq80x2WNwzjU5+I3RwYmR3jUUV28xSi
         WldGlQ0Dc8OEr4N4r2RTV2vnxI72ICwiHjw0mgOWkZSTaCTTZj7m8Rc0PE5TjiDswRRR
         uSc+jaYzFPuEMQ1VgbyJk4oSRZp/ZWGWb1FI8/cBJhm91keeZ1FRrRHyb7XSZcnXzNnY
         yjXQ==
X-Gm-Message-State: AOJu0Yzbqv7SHcXL+0CaLn/Q1oKHFwljzgXYyZKLIb8kN1kF8MjLR6jJ
	eyiraEpomngPRzYZFRx9GDhBu76EQOuuqI8nHxzI4ISYb6yZ6mPzD21cQsxFxcXLPNn13w1Uv69
	QYoSs+iE=
X-Gm-Gg: ASbGncvQpkv9oyQiu89ycdFkGdEubeK4nxARJ0Q8eJ1XlgXfzwqdp7N36KRQrzTe0D4
	Tj9p0lTzQvyDjJS6Ju02tywikol8sSNM/lA/r0o2163/MDD24yLbJaEBjAiztKluI4FcckN0pzN
	+Wt71kK7CoEuz9AJEmUDHTebZ1ZCDEzH+4Jpm/JUmC1FHF0u7R6847y4gckWOtjSEZvXj5/bM4R
	tF8CmiEURmhZ7GieHk1oVCMf0DbwyHFrlYIMkN7/L1mnuQIt9nvXggstRpmxpJz8HeOQawV0Nk0
	9dF/ZIC7bCzra7gipNqxFJA02n8GbYu7zuc7YSny2hPNvTaDTjBdIaxxOpb1FGzG7H+AojynUjn
	hGJmMHYmp4+4CE8l4nCTFqCN+HAxLpVqGdoon
X-Google-Smtp-Source: AGHT+IGpupBT6EHFzOMLYCsL7LBAOUDN4k39dYPwyyUTNOojUsQ7qqzMe2eWw9e30BaKnja3qYWcIA==
X-Received: by 2002:a05:600c:1c96:b0:459:e466:1bec with SMTP id 5b1f17b1804b1-45b979f4207mr21840595e9.2.1756824234329;
        Tue, 02 Sep 2025 07:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:5982:3242:38ad:8b12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab093sm209604635e9.22.2025.09.02.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:43:53 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Tue, 02 Sep 2025 16:43:50 +0200
Subject: [PATCH RESEND v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-timsi-v2-2-a5bf0f32905b@baylibre.com>
References: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
In-Reply-To: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
To: Thomas Gleixner <tglx@linutronix.de>, vigneshr@ti.com, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, 
 Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Add module support to the TI SCI INTA MSI driver:
- Change Kconfig from bool to tristate to allow module compilation
- Add linux/module.h include for module functionality
- Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros

This allows the driver to be compiled as a loadable kernel module
named ti_sci_inta_msi.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/soc/ti/Kconfig           | 5 ++++-
 drivers/soc/ti/ti_sci_inta_msi.c | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index 1a93001c9e36..0a9eb5ac264b 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -85,7 +85,10 @@ config TI_PRUSS
 endif # SOC_TI
 
 config TI_SCI_INTA_MSI_DOMAIN
-	bool
+	tristate "TI SCI INTA MSI Domain driver"
 	select GENERIC_MSI_IRQ
 	help
 	  Driver to enable Interrupt Aggregator specific MSI Domain.
+
+	  Say Y here to compile it into the kernel or M to compile it as a
+	  module. The module will be called ti_sci_inta_msi.
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 193266f5e3f9..d92cab319d57 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -8,6 +8,7 @@
 
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -115,3 +116,7 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Texas Instruments K3 Interrupt Aggregator MSI bus");
+MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");

-- 
2.34.1


