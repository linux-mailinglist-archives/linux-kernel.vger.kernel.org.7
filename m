Return-Path: <linux-kernel+bounces-772826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F4B29804
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC41165566
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355E2690DB;
	Mon, 18 Aug 2025 04:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ZQU6pGq4"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6A261585
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490381; cv=none; b=BeEfLSS67Ty1gl5h4ybY6Kfw4Ck8mR63cC/eEbzSZO8NWR2W6JBD/FY9NMXz4T6kf6r23kCV8dchFPPVJ7xOOekIYpLbokSmucGQ8OL/qViMcvXQvfgfrkKZVKTDsZso9koQFz9j3eL1HSTotOkIjah2Y2qKUS7q9bDT1opfAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490381; c=relaxed/simple;
	bh=9oHSmkR5BSlb6YNScWRBlcLQba4czDyHg5KKv03AfE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNudTgMkAY6JeAvHwaLUVnvCloMoQbFKf3ixmf1nMXNBkfdTG+zloBBSbIgH21ReC5LikEDvmaY4gCDuewvruAIWO7PDVLe2DVWmgNKgEgxrfgcfTlf2UaCQ8CtPuGzqc2XDaM1HFDGzcD608ZqKNaqmIzbOfOJQLxvqyfYRHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ZQU6pGq4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244581cc971so44275455ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490379; x=1756095179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnjod1mifEH5b/qp1WwSmznv0TnT3EP+iS7ZheWdF/Q=;
        b=ZQU6pGq49xLt203UFDhovN5ehXlzwLU/swqWGF0ISp5UyXYxy4QlNgVzQqln/Qj5iQ
         bBUy7HyJX/VuxLeYIYzfiPTDaqd48zwYisiBNQIZA9AXPuF5j8a+Q/U/FypAmC1QEhAN
         xS0Nhxk8pHckBqA0M80HCSfXb4Sd0+LO/EIBw8a7psCelLfeMUVVUS5CLceTOxPjReik
         c/YYeox/81VkTW3YyJ1leQg+wyBlptDk1lx+umCWbwC7jxDdncoL0CiY2oofMTlfAPjF
         +TX72D+x4kCB46szYhYxc+mQ/Xbr2SjxPbw8FbLfhkmIifROIDvJzrQldpDQx8sm1nQX
         txLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490379; x=1756095179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnjod1mifEH5b/qp1WwSmznv0TnT3EP+iS7ZheWdF/Q=;
        b=uRJlif/keD4OyqDo3NZoJ13IBGq3IT5NMcPK1t/6ATj2jAhzgBDLzyti0CMNM+M48P
         OZkYW8eb9c0MEdLyHnLjyn26WJGPexW5qfMucnkyeA0m0w8OpmimMH0rHoVidZTQ0650
         M6FaDwnzgzaslllwOVW7R/RodPRdViIqHVD0jJ71RW0APrZWgxWcCKJqJ/Jwnr2dIlRm
         pwmYhOuy4Omup3zYSqy7R+oR1kyuYywvUg32icSCqHUyasfQjenwAEIZtGiu7pmQQS2X
         cLNu+9rFns5d/F3i4dW5VhMZnaMPbLOqrBOjC1LgAf4v/gaKh1YsdSJVcWFngGv7J6wg
         wsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzfSWSxV2y6lDMF2sgJbr0wMLcUdFMdduFT/3/+DoTaEWLdsudFz9/XMQ2kGe+5Oogz6KUa+VkPN38WVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0myNK+FAOEgmmkiEd3YUf4yO1INXs7sEav1Smjk+sEFFM0yX
	w33AmUaUkcGcZ/JMi6AVwyJXMVpok/467+py03cgFuW/Caodd33mLH32xWqslHmPAV4=
X-Gm-Gg: ASbGncuav7p+kaQ+9FDuKO9arkWEO1U8iFqKcY7W+rbqpScjsFdwvjqYWx1GKjZBFjV
	i20LrLL1kG6K5chV9UkeDnaJCKL8mIGcC+yCpTH7qQ3EOLK/SxYeoLcYNvZR2XIIGjSAfMnXPAK
	A9S3ekVQNQncqYJ2d/lTguatWDa/gAbMtL0QW3KhWb1P0ggAGeR23R6v76kz4w1uieW9/+QwTIV
	TQkZ6O8mXNnPHeev95p7Nbi5BMNfCS2eThXZmWsVTxfFhbkdM6gUvzkG9toNNTIGtluQ9UkBng5
	mbo8fXzfYtDOwFybSLxAih4/FrzUCPZzbn67rdlSA1PN00UXrHt6v59mZuoPNqaJbupybbDTr5e
	IfwsFAC07dAe6ywWecIFUYNmgDYQYb3kKKhUH5IxGGLQbyPqs61q2xg==
X-Google-Smtp-Source: AGHT+IG8j5so9LT6XTGWsEtufkwowpwix82la3oqJqNnsExlbLVaOnLWc/li5RhrKLvcU04tm9JZeA==
X-Received: by 2002:a17:903:1983:b0:240:38f8:ed05 with SMTP id d9443c01a7336-2446d8f36edmr131628175ad.36.1755490378108;
        Sun, 17 Aug 2025 21:12:58 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:12:57 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v10 21/24] mailbox/riscv-sbi-mpxy: Add ACPI support
Date: Mon, 18 Aug 2025 09:39:17 +0530
Message-ID: <20250818040920.272664-22-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sunil V L <sunilvl@ventanamicro.com>

Add ACPI support for the RISC-V SBI message proxy (MPXY) based
mailbox driver.

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/mailbox/riscv-sbi-mpxy-mbox.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/riscv-sbi-mpxy-mbox.c b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
index 21404baa6df0..7c9c006b7244 100644
--- a/drivers/mailbox/riscv-sbi-mpxy-mbox.c
+++ b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2025 Ventana Micro Systems Inc.
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/mailbox_controller.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/minmax.h>
@@ -906,6 +908,8 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 		 * explicitly configure here.
 		 */
 		if (!dev_get_msi_domain(dev)) {
+			struct fwnode_handle *fwnode = dev_fwnode(dev);
+
 			/*
 			 * The device MSI domain for OF devices is only set at the
 			 * time of populating/creating OF device. If the device MSI
@@ -913,8 +917,15 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 			 * then we need to set it explicitly before using any platform
 			 * MSI functions.
 			 */
-			if (dev_of_node(dev))
+			if (is_of_node(fwnode)) {
 				of_msi_configure(dev, dev_of_node(dev));
+			} else if (is_acpi_device_node(fwnode)) {
+				struct irq_domain *msi_domain;
+
+				msi_domain = irq_find_matching_fwnode(imsic_acpi_get_fwnode(dev),
+								      DOMAIN_BUS_PLATFORM_MSI);
+				dev_set_msi_domain(dev, msi_domain);
+			}
 
 			if (!dev_get_msi_domain(dev))
 				return -EPROBE_DEFER;
@@ -960,6 +971,13 @@ static int mpxy_mbox_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+
+	if (adev)
+		acpi_dev_clear_dependencies(adev);
+#endif
+
 	dev_info(dev, "mailbox registered with %d channels\n",
 		 mbox->channel_count);
 	return 0;
@@ -979,10 +997,17 @@ static const struct of_device_id mpxy_mbox_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mpxy_mbox_of_match);
 
+static const struct acpi_device_id mpxy_mbox_acpi_match[] = {
+	{ "RSCV0005" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mpxy_mbox_acpi_match);
+
 static struct platform_driver mpxy_mbox_driver = {
 	.driver = {
 		.name = "riscv-sbi-mpxy-mbox",
 		.of_match_table = mpxy_mbox_of_match,
+		.acpi_match_table = mpxy_mbox_acpi_match,
 	},
 	.probe = mpxy_mbox_probe,
 	.remove = mpxy_mbox_remove,
-- 
2.43.0


